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

(defvar *sql-verbosity* 250)

(defun db-execute (query &rest raw-args)
  (let ((args (mapcar #'sql-translate-arg
                      raw-args)))
    ;; (
    ;; handler-case
    (cond ((or (string-equal "select " query :end2 7)
               (string-equal "describe " query :end2 9)
               (string-equal "show " query :end2 5))
           
           (multiple-value-bind (cached foundp)
               (gethash (list query args) *select-cache*)
             (when foundp
               (when (zerop (random *sql-verbosity*))
                 (format *error-output* "~& [SQL]* ~s ~s" query args))
               (return-from db-execute cached)))
           
           (when (zerop (random *sql-verbosity*))
             (format *error-output* "~& [SQL] ~s ~s" query args))
           (let ((found (db-filter-execution query args)))
             (setf (gethash (list query args) *select-cache*) found)
             found))
          
          (t (when (zerop (random *sql-verbosity*))
               (format *error-output* "~& [SQL] ~s ~s" query args))
             ;;(invalidate-db-cache)
             (db-filter-execution query args)))
    ;; (dbi.error:<dbi-database-error> (c)
    ;;   (warn "~2%{{{ ERROR in SQL engine }}}~%~a~%~s~%~s~2%~s ~a"
    ;;         query raw-args args c c)
    ;;   (signal c))
    ;;)
    ))

(defun db-execute-single (query &rest args)
  (cadar (apply #'db-execute query args)))

(defmacro db-nest-transaction ((db) &body body)
  `(dbi:with-transaction ,db ,@body))


(defvar *db-reconnects-left* 4)

(defmacro in-db ((&key (transaction nil)) &body body)
  `(tagbody
    in-db
      (restart-case
          (handler-case
              (progn
                (unless *concept-db*
                  (connect-concepts-db))
                (prog1 ,(if transaction 
                            `(db-nest-transaction (*concept-db*)
                               ,@body)
                            `(progn ,@body))))
            ;; (dbi.error:<dbi-database-error> (c)
            ;;   (declare (ignore c))
            ;;   (when (plusp *db-reconnects-left*)
            ;;     (let ((*db-reconnects-left* (1- *db-reconnects-left*)))
            ;;       (invoke-restart 'reconnect-db))))
            )
        (reconnect-db ()
          :report "Reconnect to MySQL and retry"
          (connect-concepts-db)
          (go in-db))
        (initialize-db ()
          (init-conceptnet-db)
          (go in-db))
        #+ (or) (demolish-db-without-hope-of-recovery ()
                  (if (yes-or-no-p "Are you sure you wish to destroy the database of general knowledge facts forever?")
                      (mapcar (lambda (q) (sqlite:execute-non-query *concept-db* q))
                              '("DROP TABLE concepts"
                                "DROP TABLE atoms")))))))

(defun flush-to-db ()
  (with-lock-held (*flush-to-db-lock*)
    (let ((last-insert 0))
      (setf *flush-thread-started* (get-universal-time))
      (in-db (:transaction nil)
        (fresh-line)
        (let ((insert (dbi:prepare *concept-db* "INSERT INTO concepts (s, p, o) VALUES (?, ?, ?)")))
          (loop for (s p o) in *new-inserts*
             until (or (> (incf last-insert) (min 100 (length *new-inserts*)))
                       (> (get-universal-time)
                          (+ *flush-thread-started* *concept-db-flush-to-db-interval* -5)))
             do (handler-case 
                    (dbi:execute insert
                                 (intern-cn5-symbol s)
                                 (intern-cn5-symbol p)
                                 (intern-cn5-symbol o))
                  (dbi.error:<dbi-database-error> (c)
                    (unless (search "Duplicate entry" (princ-to-string c))
                      (error c))))
               
             do (princ "."))))
      (finish-output)
      (with-lock-held (*concept-db-lock*)
        (setf *concept-db-last-flush-to-db* (get-universal-time)
              *new-inserts* (nthcdr (1- last-insert) *new-inserts*)))))) 

(defvar *flush-thread-started* 0)

(defun flush-to-db-maybe ()
  (while (< 50 (length *new-inserts*))
    (format *trace-output* "~&Flushing in-core knowledgebase to database also…")
    (flush-to-db ;; :name "Flushing Catullus KB to DB"
     )))

(defvar catullus-db-secrets::user-name)
(defvar catullus-db-secrets::password)

(defun connect-concepts-db ()
  (load (merge-pathnames #p".config/catullus.db.secrets.lisp"
                         (user-homedir-pathname)))
  (setf *concept-db* 
        (dbi:connect :mysql :host database-host :database-name database-name 
                     :username catullus-db-secrets::user-name 
                     :password catullus-db-secrets::password)
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
    ;; (assert (= 1 (db-execute-single
    ;;               "select 1 from atoms where symbol is not null limit 1")))
    ))

(defun init-conceptnet-db ()
  (in-db (:transaction nil)
    (map nil #'db-execute
         '("CREATE TABLE atoms (id BIGINT AUTO_INCREMENT, symbol VARCHAR)"
           "CREATE INDEX symbolic ON atoms (symbol)"
           "CREATE TABLE concepts (id BIGINT AUTO_INCREMENT,  s BIGINT, p BIGINT, o BIGINT)"
           "CREATE INDEX s ON concepts (s)"
           "CREATE INDEX p ON concepts (p)"
           "CREATE INDEX o ON concepts (o)"
           "CREATE INDEX sp ON concepts (s, p)"
           "CREATE INDEX so ON concepts (s, o)"
           "CREATE INDEX po ON concepts (p, o)"
           "CREATE INDEX spo ON concepts (s, p, o)"))))

(defun intern-cn5-symbol (symbol)
  (check-type symbol string)
  (tagbody
   do-interning
     (let ((id (db-execute-single "SELECT id FROM atoms WHERE symbol=?" symbol)))
       (when id
         (return-from intern-cn5-symbol id))
       (db-execute "INSERT INTO atoms (symbol) VALUES (?)" symbol)
       (remhash (list "SELECT id FROM atoms WHERE symbol=?" (list symbol))
                *select-cache*)
       (go do-interning))))

(defun add-concept (s p o)
  (with-lock-held (*concept-db-lock*)
    (unless (find-facts s p o)
      (push (list s p o) *new-inserts*)))
  (flush-to-db-maybe))

(defun add-concept-db (subj pred obj
                       &aux
                         (s (intern-cn5-symbol subj))
                         (p (intern-cn5-symbol pred))
                         (o (intern-cn5-symbol obj)))
  (db-execute "INSERT INTO concepts (s,p,o) VALUES (?,?,?)" s p o)
  #+no  (db-execute-single "SELECT id FROM concepts WHERE s=? AND p=? AND o=?" s p o))

(defgeneric find-facts (s p o)
  (:documentation "Find facts in the conceptual database that match
  the given subject, predicate, and/or object. Any one or two
  parameters can be replaced with '* as a wildcard."))

(defun atom-id->symbol (id)
  (db-execute-single "SELECT symbol FROM atoms WHERE id=?" id))

(defun concept->cons (fact-row)
  (destructuring-bind (&key id s p o) fact-row
    (declare (ignore id))
    (list (atom-id->symbol s)
          (atom-id->symbol p)
          (atom-id->symbol o))))

(defmacro find-facts-pattern (s-spec-p p-spec-p o-spec-p)
  `(defmethod find-facts
       ((subj ,(if s-spec-p 'string '(eql '*)))
        (pred ,(if p-spec-p 'string '(eql '*)))
        (obj  ,(if o-spec-p 'string '(eql '*))))
     ,(append (list 'declare)
              (unless s-spec-p `((ignore subj)))
              (unless p-spec-p `((ignore pred)))
              (unless o-spec-p `((ignore obj ))))
     (append (funcall (compose ,(if s-spec-p
                                    '(curry #'delete-if-not 
                                      (lambda (fact)
                                        (equal subj (first fact))))
                                    '#'identity)
                               ,(if p-spec-p
                                    '(curry #'delete-if-not 
                                      (lambda (fact)
                                        (equal pred (second fact))))
                                    '#'identity)
                               ,(if o-spec-p
                                    '(curry #'delete-if-not 
                                      (lambda (fact)
                                        (equal obj (third fact))))
                                    '#'identity))
                      *new-inserts*)
             (mapcar #'concept->cons
                     ,(let ((expr (list 'db-execute 
                                        (format nil
                                                "SELECT * FROM concepts 
WHERE ~:[TRUE~;s=?~] AND ~:[TRUE~;p=?~] AND ~:[TRUE~;o=?~]"
                                                s-spec-p p-spec-p o-spec-p))))
                           (when s-spec-p (appendf expr `((intern-cn5-symbol subj))))
                           (when p-spec-p (appendf expr `((intern-cn5-symbol pred))))
                           (when o-spec-p (appendf expr `((intern-cn5-symbol obj))))
                           expr)))))

(dolist (s? '(t nil))
  (dolist (p? '(t nil))
    (dolist (o? '(t nil))
      (when (or s? p? o?)
        (eval (list 'find-facts-pattern s? p? o?))))))

#+test-macro-expand 
(find-facts-pattern nil nil t)

(defun line->assertion (file line-number line)
  (let ((parts (split-sequence #\Tab line :test #'char=)))
    (destructuring-bind (pred subj obj ctx)  (subseq parts 1 5)
      (if (equal ctx "/ctx/all")
          (add-concept subj pred obj)
          (error "Unhandled context type: ~a" ctx))
      (when (zerop (random 1000))
        (format *trace-output* "~& ~A Record #~:D states: ~A (~:d record~:p awaiting sync to DB now)"
                (pathname-name file) line-number
                (utterance->human (list subj pred obj) :en)
                (length *new-inserts*))))))

(defun conceptnet5-file->sexp (file)
  (format *trace-output* "~& Loading ConceptNet5 data from ~S~%" file)
  (with-open-file (in file :direction :input :external-format :utf-8)
    (loop
       for line = (read-line in nil :eof)
       until (eql :eof line)
       for line-count from 1
       do (line->assertion file line-count line)
       finally (format *trace-output* "~& Finished with ~:D records in ~a" line-count file))))

(defun conceptnet5-read-files (wildcard)
  (map nil #'conceptnet5-file->sexp (shuffle (directory wildcard))))

(defun print-fact (s p o)
  (format t "~&~A" (utterance->human (list s p o) :en)))

(defun dump-concepts ()
  (TODO))


