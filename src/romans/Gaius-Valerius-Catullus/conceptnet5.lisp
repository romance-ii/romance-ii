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
     (let ((id (