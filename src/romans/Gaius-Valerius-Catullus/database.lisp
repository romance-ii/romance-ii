;;;; Database storage system for Catullus
;;;; -*- lisp -*-
(in-package :Catullus)
(defvar *concept-db* nil)
(defvar *new-inserts* nil
  "Newly-learned facts that have not yet been flushed to the database")
(defvar *concept-db-disc* nil)
(defvar *concept-db-lock*
  (make-lock "ConceptDB Update Lock"))
(defvar *concept-db-atom-lock*
  (make-lock "ConceptDB Atom Lock")
  "When interning a new atom, they must be atomic.")
(defvar *concept-db-last-flush-to-disc* 0)
(defparameter *concept-db-flush-to-disc-interval* 300
  "The  number  of seconds  between  flushes  to  disc (as  a  maximum).
  Writes  are generally  cached and  batched asynchronously,  until this
  much   time  has   elapsed  since   the  last   flush  ended,   or  if
  `*CONCEPT-DB-NEW-INSERTS-LIMIT*' facts are pending.")
(defparameter *concept-db-new-inserts-limit* 500000
  "When this many new inserts are pending, we will perform a synchronous
  flush  to  disc. These  are  “last  resort” writes;  the  asynchronous
  writers     will    generally     try    to     handle    these     at
  `*CONCEPT-DB-FLUSH-TO-DISC-INTERVAL*' seconds  between the end  of one
  batch write and the start of  the next, but when mass-“learning” these
  synchronous   writes  are   inserted   to  keep   memory  usage   from
  becoming ridiculous.")
(defvar *flush-to-disc-lock*
  (make-lock "ConceptDB Flush to Disc Lock"))


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
    (with-lock-held (*concept-db-lock*)
      (loop 
        while *new-inserts* 
        do (apply #'write-concept-to-db (pop *new-inserts*)))
      (setf *concept-db-last-flush-to-disc* (get-universal-time)))))

(defvar *flush-thread* nil)

(defun flush-to-disc-async () 
  (sleep 5)
  (loop
    with idle-time = 0
    while *flush-thread*
    if (and *new-inserts*
            (< (+ *concept-db-last-flush-to-disc* 
                  *concept-db-flush-to-disc-interval*)
               (get-universal-time)))
      do (progn (flush-to-disc)
                (setq idle-time 0))
         
    else do (progn (sleep 10)
                   (when (> (incf idle-time) 30)
                     (setf *flush-thread* nil)
                     (return)))))

(defun flush-inserts-synchronously ()
  (format *trace-output* "~&~:d new fact~:p are in core; stopping to flush these to disc…
 (Limit of ~:d fact~:p in *CONCEPT-DB-NEW-INSERTS-LIMIT*)"
          (length *new-inserts*)
          *concept-db-new-inserts-limit*) 
  (with-recursive-lock-held (*flush-to-disc-lock*)
    (format *trace-output* "~&Beginning synchronous flush…")
    (time (flush-to-disc))))

(defun start-flush-thread ()
  (setf *flush-thread* 
        (make-thread #'flush-to-disc-async
                     :name "Catullus Background DB Flush Thread")))

(defun flush-to-disc-maybe () 
  (cond ((< *concept-db-new-inserts-limit* (length *new-inserts*)) 
         (flush-inserts-synchronously))
        ((and *new-inserts* (not *flush-thread*))
         (start-flush-thread))))

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
    (with-lock-held (*concept-db-atom-lock*)
      (db-reset-statement &insert-atom)
      (db-bind-parameter &insert-atom 1 symbol)
      (db-step-statement &insert-atom)
      (db-last-insert-row-id *concept-db*))))

(defmethod add-concept ((s string) (p string) (o string)) 
  (push (list s p o) *new-inserts*)
  (flush-to-disc-maybe))

(defun write-concept-to-db (subj pred obj
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

(defgeneric map-facts (hook s p o)
  (:documentation "Find facts in the  conceptual database that match the
  given subject, predicate, and/or object. Any one or two parameters can
  be replaced with '* as a wildcard.

Calls HOOK with each record found. To return a list, use `FIND-FACTS'"))
(defun find-facts (s p o)
  "Find facts in  the conceptual database that match  the given subject,
  predicate, and/or  object. Any one  or two parameters can  be replaced
  with '* as a wildcard.

Returns a list of facts. See also `MAP-FACTS'"
  (let ((found nil))
    (map-facts (lambda (fact)
                 (push fact found))
               s p o)
    found))

(defmacro find-facts-pattern (s-spec p-spec o-spec)
  (let ((statement (intern (format nil "&SELECT-CONCEPT-~:[~;S~]~:[~;P~]~:[~;O~]"
                                   s-spec p-spec o-spec)))
        (p-index (if s-spec 2 1))
        (o-index (+ 1 (if s-spec 1 0) (if p-spec 1 0))))
    `(defmethod map-facts
         (hook 
          (subj ,(if s-spec 'string '(eql '*)))
          (pred ,(if p-spec 'string '(eql '*)))
          (obj  ,(if o-spec 'string '(eql '*))))
       ,(append (list 'declare)
                (unless s-spec `((ignore subj)))
                (unless p-spec `((ignore pred)))
                (unless o-spec `((ignore obj ))))
       (let ((filter (compose
                      ,(if s-spec
                           '(curry #'remove-if-not 
                             (lambda (fact)
                               (equal subj (first fact))))
                           '#'identity)
                      ,(if p-spec
                           '(curry #'remove-if-not 
                             (lambda (fact)
                               (equal pred (second fact))))
                           '#'identity)
                      ,(if o-spec
                           '(curry #'remove-if-not 
                             (lambda (fact)
                               (equal obj (third fact))))
                           '#'identity))))
         (map nil hook (funcall filter *new-inserts*)) 
         (in-db (:transaction nil)
           (db-reset-statement ,statement)
           ,(when s-spec `(db-bind-parameter ,statement 1 subj))
           ,(when p-spec `(db-bind-parameter ,statement ,p-index pred))
           ,(when o-spec `(db-bind-parameter ,statement ,o-index obj))
           (loop while (db-step-statement ,statement)
                 do (funcall hook
                             (list (db-statement-column-value ,statement 1)
                                   (db-statement-column-value ,statement 2)
                                   (db-statement-column-value ,statement 3)))))))))
(defmacro define-find-facts ()
  (cons
   'progn
   (loop for s? in '(t nil)
         append
         (loop for p? in '(t nil)
               append
               (loop for o? in '(t nil)
                     collect 
                     (when (or s? p? o?)
                       (list 'find-facts-pattern s? p? o?)))))))
(define-find-facts)

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
              (utterance->human (list subj pred obj) :en))
      (force-output *trace-output*))))

(defun db-statistics ()
  (in-db ()
    (format t "~&~|~% Concept database statistics:
  Atoms:~10t~:d
  Facts:~10t~:d
~[All facts currently on disc.~:;~
  New facts not yet flushed:  ~:d~]~%"
            (db-execute-single
             *concept-db*
             "select count(1) from atoms")
            (db-execute-single
             *concept-db*
             "select count(1) from concepts")
            (length *new-inserts*))))
