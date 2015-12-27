(in-package :catullus)

(defvar *concept-db* nil)
(defvar *new-inserts* nil)
(defvar *concept-db-disc* nil)
(defvar *concept-db-lock* (make-lock "ConceptDB Update Lock"))
(defvar *concept-db-last-flush-to-disc* 0)
(defvar *concept-db-flush-to-disc-interval* 300)
(defvar *flush-to-disc-lock* (make-lock "ConceptDB Flush Lock"))

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

(defmacro in-db ((&key (transaction nil)) &body body)
  `(TAGBODY
    in-db
      (restart-case
          (handler-case
              (progn
                (unless *concept-db*
                  (connect-concepts-db))
                (prog1 ,(if transaction 
                            `(sqlite:with-transaction *concept-db*
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
  (in-db (:transaction t)
    (with-lock-held (*concept-db-lock*)
      (loop for (s p o) in *new-inserts*
         do (add-concept-db s p o))))
  (setf *concept-db-last-flush-to-disc* (get-universal-time))
  (release-lock *flush-to-disc-lock*)) 

(defun flush-to-disc-maybe ()
  (if (< (+ *concept-db-last-flush-to-disc* 
            *concept-db-flush-to-disc-interval*)
         (get-universal-time))
      (when (ignore-errors
              (sb-thread:grab-mutex *flush-to-disc-lock* :waitp nil :timeout 0))
        (format *trace-output* "~&Flushing in-core DB to disc also…")
        (make-thread #'flush-to-disc :name "Syncing new facts to disc DB"))))
(defun connect-concepts-db ()
  (setf *concept-db* (sqlite:connect
                      (merge-pathnames (make-pathname :directory '(:relative "conceptnet5-csv" "assertions")
                                                      :name "conceptnet5.sqlite"
                                                      :type "db")
                                       romans-compiler-setup:*path/r2src*))
        
        #+ (or) ":memory:")
  #+ (or) (setf *concept-db-disc* (sqlite:connect
                                   (merge-pathnames (make-pathname :directory '(:relative "conceptnet5-csv" "assertions")
                                                                   :name "conceptnet5.sqlite"
                                                                   :type "db")
                                                    romans-compiler-setup:*path/r2src*)))
  (in-db (:transaction nil)
    (let ((check (sqlite:prepare-statement *concept-db*
                                           "select 1 from atoms where symbol is not null limit 1")))
      (sqlite:reset-statement check)
      (sqlite:step-statement check)))
  (setf &select-atom-id
        (sqlite:prepare-statement
         *concept-db*
         "SELECT rowid FROM atoms WHERE symbol=?"))
  (setf &insert-atom
        (sqlite:prepare-statement
         *concept-db*
         "INSERT OR FAIL INTO atoms (symbol) VALUES (?)"))
  (setf &insert-concept
        (sqlite:prepare-statement
         *concept-db*
         "INSERT OR FAIL INTO concepts (s,p,o) VALUES (?,?,?)"))
  (setf &select-concept-spo
        (sqlite:prepare-statement
         *concept-db*
         "SELECT rowid,s,p,o FROM concepts WHERE s=? AND p=? AND o=?"))
  (setf &select-concept-sp
        (sqlite:prepare-statement
         *concept-db*
         "SELECT rowid,s,p,o FROM concepts WHERE s=? AND p=?"))
  (setf &select-concept-po
        (sqlite:prepare-statement
         *concept-db*
         "SELECT rowid,s,p,o FROM concepts WHERE p=? AND o=?"))
  (setf &select-concept-so
        (sqlite:prepare-statement
         *concept-db*
         "SELECT rowid,s,p,o FROM concepts WHERE s=? AND o=?"))
  (setf &select-concept-s
        (sqlite:prepare-statement
         *concept-db*
         "SELECT rowid,s,p,o FROM concepts WHERE s=?"))
  (setf &select-concept-p
        (sqlite:prepare-statement
         *concept-db*
         "SELECT rowid,s,p,o FROM concepts WHERE p=?"))
  (setf &select-concept-o
        (sqlite:prepare-statement
         *concept-db*
         "SELECT rowid,s,p,o FROM concepts WHERE o=?")))

(defun init-conceptnet-db ()
  (in-db (:transaction nil)
    (map nil (curry #'sqlite:execute-non-query *concept-db*)
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
                 (sqlite:reset-statement &select-atom-id)
                 (sqlite:bind-parameter &select-atom-id 1 symbol)
                 (sqlite:step-statement &select-atom-id)
                 (sqlite:statement-column-value &select-atom-id 0))))
    id
    (with-lock-held (*concept-db-lock*)
      (sqlite:reset-statement &insert-atom)
      (sqlite:bind-parameter &insert-atom 1 symbol)
      (sqlite:step-statement &insert-atom)
      (sqlite:last-insert-rowid *concept-db*))))

(defun add-concept (s p o)
  (push (list s p o) *new-inserts*)
  #+ (or) (princ "." *trace-output*)
  (flush-to-disc-maybe))

(defun add-concept-db (subj pred obj
                       &aux
                         (s (intern-cn5-symbol subj))
                         (p (intern-cn5-symbol pred))
                         (o (intern-cn5-symbol obj)))
  (sqlite:reset-statement &insert-concept)
  (sqlite:bind-parameter &insert-concept 1 s)
  (sqlite:bind-parameter &insert-concept 2 p)
  (sqlite:bind-parameter &insert-concept 3 o)
  (sqlite:step-statement &insert-concept)
  (sqlite:last-insert-rowid *concept-db*))

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
             (sqlite:reset-statement ,statement)
             ,(when s-spec `(sqlite:bind-parameter ,statement 1 subj))
             ,(when p-spec `(sqlite:bind-parameter ,statement ,p-index pred))
             ,(when o-spec `(sqlite:bind-parameter ,statement ,o-index obj))
             (loop while (sqlite:step-statement ,statement)
                collecting (list (sqlite:statement-column-value ,statement 1)
                                 (sqlite:statement-column-value ,statement 2)
                                 (sqlite:statement-column-value ,statement 3))))))
       ;; ,(when s-spec `(intern-cn5-symbol s))
       ;; ,(when p-spec `(intern-cn5-symbol p))
       ;; ,(when o-spec `(intern-cn5-symbol o))
       )))

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
       ;; for (pred subj obj ctx vers src eid lic) =
       ;;   (mapcar (lambda (s) (intern s :cvc)) (subseq parts 1 9))
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

