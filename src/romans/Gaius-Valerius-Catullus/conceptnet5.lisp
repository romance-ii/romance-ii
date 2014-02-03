(in-package :catullus)

(defvar *concept-db* nil)
(defvar *concept-db-lock* (make-lock "ConceptDB Update Lock"))

(defmacro in-db (&body body)
  `(restart-case
       (handler-case
           (progn 
             (unless *concept-db*
               (connect-concepts-db))
             ,@body))
     (reconnect-to-memory-db ()
       (connect-concepts-db))
     (initialize-db ()
       (init-memory-db))
     (demolish-db-without-hope-of-recovery ()
       (mapcar (lambda (q) (sqlite:execute-non-query *concept-db* q))
               '("DROP TABLE concepts"
                 "DROP TABLE atoms")))))

(defun connect-concepts-db ()
  (setf *concept-db* (sqlite:connect ":memory:"))
  (init-memory-db)
  (in-db
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
          "SELECT rowid,s,p,o FROM concepts WHERE o=?"))))

(defun init-memory-db ()
  (mapcar (lambda (q) (sqlite:execute-non-query *concept-db* q))
          '("CREATE TABLE atoms (symbol VARCHAR)"
            "CREATE INDEX symbolic ON atoms (symbol)"
            "CREATE TABLE concepts (s INT, p INT, o INT)"
            "CREATE INDEX spo ON concepts (s, p, o)"
            "CREATE INDEX sp ON concepts (s, p)"
            "CREATE INDEX po ON concepts (p, o)"
            "CREATE INDEX so ON concepts (s, o)"
            "CREATE INDEX s ON concepts (s)"
            "CREATE INDEX p ON concepts (p)"
            "CREATE INDEX o ON concepts (o)")))

(defvar &select-atom-id)
(defvar &insert-atom)
(defvar &insert-concept)
(defvar &select-concept-spo)
(defvar &select-concept-sp)
(defvar &select-concept-po)
(defvar &select-concept-so)
(defvar &select-concept-s)
(defvar &select-concept-p)
(defvar &select-concept-o)

(defun intern-cn5-symbol (symbol)
  (declare (type string symbol))
  (in-db
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
       (sqlite:last-insert-rowid *concept-db*)))))

(defun add-concept (subj pred obj
                    &aux
                      (s (intern-cn5-symbol subj))
                      (p (intern-cn5-symbol pred))
                      (o (intern-cn5-symbol obj)))
  (in-db
   (with-lock-held (*concept-db-lock*)
     (sqlite:reset-statement &insert-concept)
     (sqlite:bind-parameter &insert-concept 1 s)
     (sqlite:bind-parameter &insert-concept 2 p)
     (sqlite:bind-parameter &insert-concept 3 o)
     (sqlite:step-statement &insert-concept)
     (sqlite:last-insert-rowid *concept-db*))))

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
         ((s ,(if s-spec 'string '(eql '*)))
          (p ,(if p-spec 'string '(eql '*)))
          (o ,(if o-spec 'string '(eql '*))))
       ((lambda (subj pred obj )
          ,(append (list 'declare)
                   (unless s-spec `((ignore subj)))
                   (unless p-spec `((ignore pred)))
                   (unless o-spec `((ignore obj ))))
          (in-db
           (sqlite:reset-statement ,statement)
           ,(when s-spec `(sqlite:bind-parameter ,statement 1 subj))
           ,(when p-spec `(sqlite:bind-parameter ,statement ,p-index pred))
           ,(when o-spec `(sqlite:bind-parameter ,statement ,o-index obj))
           (loop while (sqlite:step-statement ,statement)
              collecting (list (sqlite:statement-column-value ,statement 1)
                               (sqlite:statement-column-value ,statement 2)
                               (sqlite:statement-column-value ,statement 3)))))
        ,(when s-spec `(intern-cn5-symbol s))
        ,(when p-spec `(intern-cn5-symbol p))
        ,(when o-spec `(intern-cn5-symbol o))))))

(find-facts-pattern nil  nil  t)
(find-facts-pattern nil  t    nil)
(find-facts-pattern nil  t    t)
(find-facts-pattern t    nil  nil)
(find-facts-pattern t    nil  t)
(find-facts-pattern t    t    nil)
(find-facts-pattern t    t    t)

(defun conceptnet5-file->sexp (file)
  (format *trace-output* "~& Loading ConceptNet5 data from ~S~%" file)
  (with-open-file (in file :direction :input :external-format :utf-8)
    (loop
       for line = (read-line in nil :eof)
       until (eql :eof line)
       for line-count from 1
       for parts = (split-sequence:split-sequence #\Tab line :test #'char=)
       ;; for (pred subj obj ctx vers src eid lic) =
       ;;   (mapcar (lambda (s) (intern s :cvc)) (subseq parts 1 9))
       for (pred subj obj) = (subseq parts 1 4)
       do (add-concept subj pred obj)
       when (or nil (= 0 (random 10000)))
       do (format *trace-output* "~& - Record #~:D states:	~A"
                  line-count (utterance->human (list subj pred obj) :en))
       finally (format *trace-output* "~& Finished with ~:D records" line-count))))

(defun conceptnet5-read-files (wildcard)
  (mapcar #'conceptnet5-file->sexp (directory wildcard)))

(defun print-fact (s p o)
  (format t "~&~A" (utterance->human (list s p o) :en)))

(defun dump-concepts ()
  
  (TODO))

