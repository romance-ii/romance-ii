(in-package :catullus)

;; This  work  includes  data  from  ConceptNet  5,   which  was  compiled  by  the  Commonsense  Computing  Initiative.
;; ConceptNet 5  is freely  available under  the Creative  Commons Attribution-ShareAlike  license (CC  BY SA  3.0) from
;; http://conceptnet5.media.mit.edu. The  included data was created  by contributors to Commonsense  Computing projects,
;; contributors  to  Wikimedia  projects, Games  with  a  Purpose,  Princeton  University's WordNet,  DBPedia,  OpenCyc,
;; and Umbel.

(defvar *concept-db* nil)
(defvar *new-inserts* nil)
(defvar *concept-db-connection* :disconnected)
(defvar *concept-db-lock* (make-lock "ConceptDB Update Lock"))
(defvar *concept-db-last-flush-to-db* 0)
(defvar *concept-db-flush-to-db-interval* 300)
(defvar *flush-to-db-lock* (make-lock "ConceptDB Flush Lock"))


(defvar database-host "gaius-valerius-catullus.adventuring.click")
(defvar database-name "semantics")
(defvar lesbia-user-name "lesbia") ; read-only public access.
(defvar lesbia-password "s{Wu|crO^kJ[W|EEmnmJzxHWgRVo]qI")

(defvar &select-atom-id nil)
(defvar &insert-atom nil)
(defvar &insert-concept nil)
(defvar &select-concept-spo nil)
(defvar &select-concept-sp nil)
(defvar &select-concept-po nil)
(defvar &select-concept-so nil)
(defvar &select-concept-s nil)
(defvar &select-concept-p nil)
(defvar &select-concept-o nil)

(defvar *select-cache* (make-hash-table :test 'equalp))

(defun invalidate-db-cache ()
  (clrhash *select-cache*))

(defun db-filter-execution (query args)
  (map 'list
       (lambda (row) (mapplist (key value) row
                       (list (keyword* key) value)))
       (dbi:fetch-all (apply #'dbi:execute (dbi:prepare *concept-db* query) args))))

(defun sql-translate-arg (arg)
  (cond ((member arg '(:null :true :false)) arg)
        ((null arg) :null)
        ((eql arg t) :true)
        ((symbolp arg) (string-downcase arg))
        (t arg)))

(defun db-execute (query &rest raw-args)
  (let ((args (mapcar #'sql-translate-arg
                      raw-args)))
    (handler-case
        (cond ((or (string-equal "select " query :end2 7)
                   (string-equal "describe " query :end2 9)
                   (string-equal "show " query :end2 5))
               
               (multiple-value-bind (cached foundp)
                   (gethash (list query args) *select-cache*)
                 (when foundp
                   (format *error-output* "~& [SQL]* ~s ~s" query args)
                   (return-from db-query cached)))
               
               (format *error-output* "~& [SQL] ~s ~s" query args)
               (let ((found (db-filter-execution query args)))
                 (setf (gethash (list query args) *select-cache*) found)
                 found))
              
              (t (format *error-output* "~& [SQL] ~s ~s" query args)
                 (invalidate-db-cache)
                 (db-filter-execution query args)))
      (dbi.error:<dbi-database-error> (c)
        (warn "~2%{{{ ERROR in SQL engine }}}~%~a~%~s~%~s~2%~s ~a"
              query raw-args args c c)
        (signal c)))))

(defun db-execute-single (query &rest args)
  (cadar (apply #'db-execute query args)))

(defmacro db-nest-transaction ((db) &body body)
  `(dbi:with-transaction ,db ,@body))

(defmacro in-db ((&key (transaction nil)) &body body)
  `(TAGBODY
    in-db
      (restart-case
          (handler-case
              (progn
                (unless *concept-db*
                  (connect-concepts-db))
                (prog1 ,(if transaction 
                            `(db-nest-transaction (*concept-db*)
                               ,@body)
                            `(progn ,@body)))))
        (initialize-db ()
          (init-conceptnet-db)
          (go in-db))
        #+ (or) (demolish-db-without-hope-of-recovery ()
                  (if (yes-or-no-p "Are you sure you wish to destroy the database of general knowledge facts forever?")
                      (mapcar (lambda (q) (sqlite:execute-non-query *concept-db* q))
                              '("DROP TABLE concepts"
                                "DROP TABLE atoms")))))))

(defun flush-to-db ()
  (when (sb-thread:grab-mutex *flush-to-db-lock* :waitp nil :timeout 0)
    (in-db (:transaction t)
      (loop for (s p o) in *new-inserts*
         do (add-concept-db s p o)))
    (setf *concept-db-last-flush-to-db* (get-universal-time))
    (release-lock *flush-to-db-lock*))) 

(defun flush-to-db-maybe ()
  (if (< (+ *concept-db-last-flush-to-db* 
            *concept-db-flush-to-db-interval*)
         (get-universal-time))
      (when (ignore-errors
              (sb-thread:grab-mutex *flush-to-db-lock* :waitp nil :timeout 0))
        (format *trace-output* "~&Flushing in-core DB to disc also…")
        (flush-to-db))))

(defun connect-concepts-db ()
  (setf *concept-db* 
        (dbi:connect :mysql :host database-host :db database-name :user database-user :password database-password)
        #+sqlite-backing-concept-db (sqlite:connect
                                     (merge-pathnames (make-pathname :directory '(:relative "conceptnet5-csv" "assertions")
                                                                     :name "conceptnet5.sqlite"
                                                                     :type "db")
                                                      romans-compiler-setup:*path/r2src*))
        
        #+conceptnet-memory ":memory:")
  #+conceptnet-memory
  (setf *concept-db-connection* (sqlite:connect
                                 (merge-pathnames (make-pathname :directory '(:relative "conceptnet5-csv" "assertions")
                                                                 :name "conceptnet5.sqlite"
                                                                 :type "db")
                                                  romans-compiler-setup:*path/r2src*)))
  (in-db (:transaction nil)
    (assert (= 1 (db-execute-single *concept-db*
                                    "select 1 from atoms where symbol is not null limit 1")))))

(defun init-conceptnet-db ()
  (in-db (:transaction nil)
    (map nil (curry #'db-execute-non-query *concept-db*)
         '("CREATE TABLE atoms (symbol VARCHAR)"
           "CREATE INDEX symbolic ON atoms (symbol)"
           "CREATE TABLE concepts (s INT, p INT, o INT)"
           "CREATE INDEX s ON concepts (s)"
           "CREATE INDEX p ON concepts (p)"
           "CREATE INDEX o ON concepts (o)"
           "CREATE INDEX sp ON concepts (s, p)"
           "CREATE INDEX so ON concepts (s, o)"
           "CREATE INDEX po ON concepts (p, o)"
           "CREATE INDEX spo ON concepts (s, p, o)"))))

(defun intern-cn5-symbol (symbol)
  (check-type symbol string)
  (if-let ((id (db-execute-single "SELECT id FROM atoms WHERE symbol=?" symbol)))
    id
    (with-lock-held (*concept-db-lock*)
      (db-execute-single "INSERT INTO atoms (symbol) VALUES (?) RETURNING id" symbol))))

(defun add-concept (s p o)
  (push (list s p o) *new-inserts*)
  (flush-to-db-maybe))

(defun add-concept-db (subj pred obj
                       &aux
                         (s (intern-cn5-symbol subj))
                         (p (intern-cn5-symbol pred))
                         (o (intern-cn5-symbol obj)))
  (db-execute-single "INSERT INTO concepts (s,p,o) VALUES (?,?,?) RETURNING id" s p o))

(defgeneric find-facts (s p o)
  (:documentation "Find facts in the conceptual database that match
  the given subject, predicate, and/or object. Any one or two
  parameters can be replaced with '* as a wildcard."))

(defmacro find-facts-pattern (s-spec p-spec o-spec)
  (let ((statement (format nil "SELECT id FROM atoms WHERE ~:[TRUE~;s=?~] AND ~:[TRUE~;p=?~] AND ~:[TRUE~;o=?~]"
                           s-spec p-spec o-spec))
        (p-index (if s-spec 2 1))
        (o-index (+ 1 (if s-spec 1 0) (if p-spec 1 0))))
    `(defmethod find-facts
         ((subj ,(if s-spec 'string '(eql '*)))
          (pred ,(if p-spec 'string '(eql '*)))
          (obj  ,(if o-spec 'string '(eql '*))))
       ,(append (list 'declare)
                (unless s-spec `((ignore subj)))
                (unless p-spec `((ignore pred)))
                (unless o-spec `((ignore obj ))))
       (let ((filter (compose ,(if s-spec
                                   '#'identity
                                   '(curry #'delete-if-not 
                                     (lambda (fact)
                                       (equal subj (first fact)))))
                              ,(if p-spec
                                   '#'identity
                                   '(curry #'delete-if-not 
                                     (lambda (fact)
                                       (equal pred (second fact)))))
                              ,(if o-spec
                                   '#'identity
                                   '(curry #'delete-if-not 
                                     (lambda (fact)
                                       (equal obj (third fact))))))))
         (let (found (funcall filter *new-inserts*))
           (append found
                   (in-db (:transaction nil)
                     ,(let ((l (list 'db-execute-query statement)))
                           (when s-spec (appendf l `(intern-cn5-symbol subj)))
                           (when p-spec (appendf l `(intern-cn5-symbol pred)))
                           (when o-spec (appendf l `(intern-cn5-symbol obj)))
                           l))))))))

(dolist (s? '(t nil))
  (dolist (p? '(t nil))
    (dolist (o? '(t nil))
      (when (or s? p? o?)
        (eval (list 'find-facts-pattern s? p? o?))))))

(defun conceptnet5-file->sexp (file)
  (format *trace-output* "~& Loading ConceptNet5 data from ~S~%" file)
  (with-open-file (in file :direction :input :external-format :utf-8)
    (loop
       for line = (read-line in nil :eof)
       until (eql :eof line)
       for line-count from 1
       for parts = (split-sequence #\Tab line :test #'char=)
       for (pred subj obj ctx) = (subseq parts 1 5)
       do (if (equal ctx "/ctx/all")
              (add-concept subj pred obj)
              (error "Unhandled context type: ~a" ctx))
       when (zerop (random 10000))
       do (format *trace-output* "~& ~A Record #~:D states: ~A"
                  (pathname-name file) line-count
                  (utterance->human (list subj pred obj) :en))
       finally (format *trace-output* "~& Finished with ~:D records" line-count))))

(defun conceptnet5-read-files (wildcard)
  (map nil #'conceptnet5-file->sexp (shuffle (directory wildcard))))

(defun print-fact (s p o)
  (format t "~&~A" (utterance->human (list s p o) :en)))

(defun dump-concepts ()
  (TODO))

