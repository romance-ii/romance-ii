(in-package :catullus)
;; This work includes data from ConceptNet  5, which was compiled by the
;; Commonsense Computing  Initiative. ConceptNet  5 is  freely available
;; under the  Creative Commons Attribution-ShareAlike license  (CC BY SA
;; 3.0)  from http://conceptnet5.media.mit.edu.  The  included data  was
;; created   by   contributors   to  Commonsense   Computing   projects,
;; contributors to  Wikimedia projects, Games with  a Purpose, Princeton
;; University's WordNet, DBPedia, OpenCyc, and Umbel.
(defparameter *concept-db* nil)
(defvar *new-inserts* nil)
(defvar *concept-db-disc* nil)
(defvar *concept-db-lock* (make-lock "ConceptDB Update Lock"))
(defvar *concept-db-last-flush-to-disc* 0)
(defvar *concept-db-flush-to-disc-interval* 300)
(defvar *flush-to-disc-lock* (make-lock "ConceptDB Flush Lock"))


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

(defmacro db-nest-transaction ((db) &body body)
  `(sqlite:with-transaction ,db ,@body))

(defun db-execute-non-query (db &rest query) 
  (apply #'sqlite:execute-non-query db query))

(defun db-execute-query (db &rest query)
  (apply #'sqlite:execute-to-list db query))

(defun db-execute-single (db &rest query)
  (apply #'sqlite:execute-single db query))

(defun db-prepare-statement (db &rest statement)
  (apply #'sqlite:prepare-statement db statement))

(defun db-reset-statement (st)
  (sqlite:reset-statement st))

(defun db-bind-parameter (st i value)
  (sqlite:bind-parameter st i value))

(defun db-step-statement (st)
  (sqlite:step-statement st))

(defun db-statement-column-value (st i)
  (sqlite:statement-column-value st i))

(defun db-last-insert-row-id (db)
  (sqlite:last-insert-rowid db))

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

(defun flush-to-disc ()
  (in-db ()
    (with-recursive-lock-held (*concept-db-lock*)
      (loop for (s p o) in *new-inserts*
         do (add-concept-db s p o)))))

(defun try-to-flush-to-disc-async () 
  (with-recursive-lock-held (*flush-to-disc-lock*) 
    (format *trace-output* "~&Flushing ~:d new fact~:p from in-core DB to disc also…"
            (length *new-inserts*))
    (make-thread #'flush-to-disc :name "Syncing new facts to disc DB")
    (setf *concept-db-last-flush-to-disc* (get-universal-time))))

(defun flush-to-disc-maybe () 
  (when (< (+ *concept-db-last-flush-to-disc* 
              *concept-db-flush-to-disc-interval*)
           (get-universal-time))
    (try-to-flush-to-disc-async)))

(defun connect-concepts-db ()
  (let ((db-path (merge-pathnames (make-pathname :directory '(:relative :up "db" "assertions")
                                                 :name "conceptnet5.sqlite"
                                                 :type "db")
                                  romans-compiler-setup:*path/r2src*)))
    #-conceptnet-memory
    (unless (probe-file db-path)
      (ensure-directories-exist db-path))
    (setf *concept-db* (sqlite:connect db-path)
          
          #+conceptnet-memory ":memory:"))
  #+conceptnet-memory
  (setf *concept-db-disc* (sqlite:connect
                           (merge-pathnames (make-pathname :directory '(:relative "conceptnet5-csv" "assertions")
                                                           :name "conceptnet5.sqlite"
                                                           :type "db")
                                            romans-compiler-setup:*path/r2src*)))
  (in-db (:transaction nil)
    (let ((check (db-prepare-statement *concept-db*
                                       "select 1 from atoms where symbol is not null limit 1")))
      (db-reset-statement check)
      (db-step-statement check)))
  (setf &select-atom-id
        (db-prepare-statement
         *concept-db*
         "SELECT rowid FROM atoms WHERE symbol=?"))
  (setf &insert-atom
        (db-prepare-statement
         *concept-db*
         "INSERT OR FAIL INTO atoms (symbol) VALUES (?)"))
  (setf &insert-concept
        (db-prepare-statement
         *concept-db*
         "INSERT OR FAIL INTO concepts (s,p,o) VALUES (?,?,?)"))
  (setf &select-concept-spo
        (db-prepare-statement
         *concept-db*
         "SELECT rowid,s,p,o FROM concepts WHERE s=? AND p=? AND o=?"))
  (setf &select-concept-sp
        (db-prepare-statement
         *concept-db*
         "SELECT rowid,s,p,o FROM concepts WHERE s=? AND p=?"))
  (setf &select-concept-po
        (db-prepare-statement
         *concept-db*
         "SELECT rowid,s,p,o FROM concepts WHERE p=? AND o=?"))
  (setf &select-concept-so
        (db-prepare-statement
         *concept-db*
         "SELECT rowid,s,p,o FROM concepts WHERE s=? AND o=?"))
  (setf &select-concept-s
        (db-prepare-statement
         *concept-db*
         "SELECT rowid,s,p,o FROM concepts WHERE s=?"))
  (setf &select-concept-p
        (db-prepare-statement
         *concept-db*
         "SELECT rowid,s,p,o FROM concepts WHERE p=?"))
  (setf &select-concept-o
        (db-prepare-statement
         *concept-db*
         "SELECT rowid,s,p,o FROM concepts WHERE o=?")))

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

(defvar &select-atom-id)
(defvar &insert-atom)
(defvar &insert-concept)
(defvar &select-concept-s)
(defvar &select-concept-p)
(defvar &select-concept-o)
(defvar &select-concept-sp)
(defvar &select-concept-so)
(defvar &select-concept-po)
(defvar &select-concept-spo)

(defun intern-cn5-symbol (symbol)
  (declare (type string symbol))
  (if-let ((id (progn
                 (db-reset-statement &select-atom-id)
                 (db-bind-parameter &select-atom-id 1 symbol)
                 (db-step-statement &select-atom-id)
                 (db-statement-column-value &select-atom-id 0))))
    id
    (with-lock-held (*concept-db-lock*)
      (db-reset-statement &insert-atom)
      (db-bind-parameter &insert-atom 1 symbol)
      (db-step-statement &insert-atom)
      (db-last-insert-row-id *concept-db*))))

(defmethod add-concept ((s string) (p string) (o string)) 
  (push (list s p o) *new-inserts*)
  (flush-to-disc-maybe))

(defun add-concept-db (subj pred obj
                       &aux
                         (s (intern-cn5-symbol subj))
                         (p (intern-cn5-symbol pred))
                         (o (intern-cn5-symbol obj)))
  (db-reset-statement &insert-concept)
  (db-bind-parameter &insert-concept 1 s)
  (db-bind-parameter &insert-concept 2 p)
  (db-bind-parameter &insert-concept 3 o)
  (db-step-statement &insert-concept)
  (db-last-insert-row-id *concept-db*))

(defgeneric find-facts (s p o)
  (:documentation "Find facts in the conceptual database that match
  the given subject, predicate, and/or object. Any one or two
  parameters can be replaced with '* as a wildcard."))

(defmacro find-facts-pattern (s-spec p-spec o-spec)
  (let ((statement (intern (format nil "&SELECT-CONCEPT-~:[~;S~]~:[~;P~]~:[~;O~]"
                                   s-spec p-spec o-spec)))
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
                                   '(curry #'remove-if-not 
                                     (lambda (fact)
                                       (equal subj (first fact)))))
                              ,(if p-spec
                                   '#'identity
                                   '(curry #'remove-if-not 
                                     (lambda (fact)
                                       (equal pred (second fact)))))
                              ,(if o-spec
                                   '#'identity
                                   '(curry #'remove-if-not 
                                     (lambda (fact)
                                       (equal obj (third fact))))))))
         (if-let (found (funcall filter *new-inserts*))
           found
           (in-db (:transaction nil)
             (db-reset-statement ,statement)
             ,(when s-spec `(db-bind-parameter ,statement 1 subj))
             ,(when p-spec `(db-bind-parameter ,statement ,p-index pred))
             ,(when o-spec `(db-bind-parameter ,statement ,o-index obj))
             (loop while (db-step-statement ,statement)
                collecting (list (db-statement-column-value ,statement 1)
                                 (db-statement-column-value ,statement 2)
                                 (db-statement-column-value ,statement 3))))))
       ;; ,(when s-spec `(intern-cn5-symbol s))
       ;; ,(when p-spec `(intern-cn5-symbol p))
       ;; ,(when o-spec `(intern-cn5-symbol o))
       )))

(dolist (s? '(t nil))
  (dolist (p? '(t nil))
    (dolist (o? '(t nil))
      (when (or s? p? o?)
        (eval (list 'find-facts-pattern s? p? o?))))))

(defvar *datasets* '()
  "Datasets used which should be attributed")

(defun trace-sample-record (file line-count subj pred obj)
  (when (zerop (random 10000))
    (with-simple-restart
        (retry-trace  "Retry tracing fact #~:d: ~a —~a—→ ~a"
                      line-count subj pred obj)
      #+ (or)
      (format *trace-output* "~&Fact #~:d: ~a —~a—→ ~a:"
              line-count subj pred obj)
      (format *trace-output* "~& ~A Record #~:D states~% ~A"
              (pathname-name file) line-count
              (utterance->human (list subj pred obj) :en)))))

(defun process-conceptnet5-fact (file line-count subj pred obj ctx) 
  (declare (ignore file))
  (with-simple-restart
      (retry-fact "Retry processing fact #~:d: ~a —~a—→ ~a"
                  line-count subj pred obj)
    (cond
      ((equal ctx "/ctx/all")
       (add-concept subj pred obj))
      
      ((char= (char ctx 0) #\{)
       (let* ((ctx.json (st-json:read-json-from-string ctx))
              (license (st-json:getjso "license" ctx.json)))
         (switch (license :test 'equal) 
           ("cc:by-sa/4.0" (pushnew (st-json:getjso "dataset" ctx.json)
                                    *datasets*
                                    :test 'equal))
           ("cc:by/4.0" (pushnew (st-json:getjso "dataset" ctx.json)
                                 *datasets*
                                 :test 'equal))
           (otherwise (error "Unhandled license type: ~a" license)))
         (add-concept subj pred obj)))
      (t (error "Unhandled context type: ~a" ctx)))))

(defun conceptnet5-file->sexp (file)
  (format *trace-output* "~& Loading ConceptNet5 data from ~S~%" file)
  (with-open-file (in file :direction :input :external-format :utf-8)
    (loop
       for line = (read-line in nil :eof)
       until (eql :eof line)
       for line-count from 1
       for parts = (split-sequence #\Tab line :test #'char=)
       for (pred subj obj ctx) = (subseq parts 1 5)
       do (process-conceptnet5-fact file line-count subj pred obj ctx)
         
       do (trace-sample-record file line-count subj pred obj)
       finally (format *trace-output* "~&~|~%Finished with ~:D records" line-count))))

(defun conceptnet5-read-files (wildcard)
  (map nil #'conceptnet5-file->sexp (shuffle (directory wildcard))))

(defun print-fact (s p o)
  (format t "~&~A" (utterance->human (list s p o) :en)))

(defun dump-concepts ()
  (TODO))
