(in-package :caesar)

(defun collate-quality-of-service-reports ())

(defun heartbeat-failure-detection ())





(defun machine-vmstat ()
  (split-and-collect-file "/proc/vmstat"))

(defun machine-meminfo ()
  (split-and-collect-file "/proc/meminfo" #\:
                          #'cffi:translate-camelcase-name))

(defun process-info (&optional (pid (sb-posix:getpid)))
  "Returns a plethora of information about a Unix Process (VM), in a nested
property-list-based structure. If no process ID is provided, then the
information returned is about the current process.

The structures should remain stable in future, but are not documented
here. Note, particularly, that most numeric data will be returned as numbers,
and list data as lists; some data which can be an atom or a list or pair will
use association lists when paired data is available."
  (let ((proc-dir (concatenate 'string "/proc/" (princ-to-string pid) "/")))
    (flet ((proc-file (file-name)
             (merge-pathnames file-name proc-dir))) 
      (append (list
               :io (split-and-collect-file (proc-file "io") #\:)
               :sched (let ((plist (split-and-collect-file (proc-file "sched") #\:)))
                        (cons :number-of-threads (cdr plist))) ;; first line is weird.
               :waiting-channel (collect-file (proc-file "wchan"))
               :login-uid (collect-file (proc-file "loginuid"))
               :security-attributes (mapcan (lambda (token)
                                              (list (make-keyword (string-upcase token))
                                                    (collect-file (proc-file (concatenate 'string "attr/" token)))))
                                            '("current" "exec" "fscreate" "keycreate" "prev" "sockcreate"))
               :mount-points (mapcar (lambda (row)
                                       (when (second row)
                                         (list (second row)
                                               (first row)
                                               (third row)
                                               (maybe-alist-split (fourth row))
                                               (nthcdr 4 row))))
                                     (collect-file-tabular (proc-file "mounts") #\Space))
               :mount-info (mapcar (lambda (row)
                                     (when (fifth row)
                                       (list (fifth row)
                                             (first row)
                                             (second row)
                                             (mapcar #'parse-integer (split-sequence #\: (third row)))
                                             (fourth row)
                                             (maybe-alist-split (sixth row))
                                             (maybe-alist-row (seventh row) #\:)
                                             (eighth row)
                                             (ninth row)
                                             (tenth row)
                                             (maybe-alist-split (nth 10 row))))) 
                                   (collect-file-tabular (proc-file "mountinfo") #\Space))
               :status (let ((skim (collect-file-lines (proc-file "status"))))
                         (flet ((trimmy (string)
                                  (string-trim '(#\Space #\Tab) string))
                                (split-columns (string)
                                  (mapcar #'parse-integer (split-sequence #\Tab string)))
                                (parse-hex (string)
                                  (parse-integer string :radix 16)))
                           (let ((translator (list :state (curry #'split-sequence #\Space)
                                                   :uid #'split-columns
                                                   :gid #'split-columns
                                                   :groups (lambda (string)
                                                             (mapcar #'parse-integer (split-sequence #\Space string)))
                                                   :sig-pnd #'parse-hex
                                                   :shd-pnd #'parse-hex
                                                   :sig-blk #'parse-hex
                                                   :sig-ign #'parse-hex
                                                   :sig-cgt #'parse-hex
                                                   :cap-inh #'parse-hex
                                                   :cap-prm #'parse-hex
                                                   :cap-eff #'parse-hex
                                                   :cap-bnd #'parse-hex
                                                   :cpus-allowed #'parse-hex
                                                   :mems-allowed (lambda (row)
                                                                   (mapcar #'parse-hex (split-sequence #\, row)))
                                                   :sig-q (lambda (row)
                                                            (mapcar #'parse-integer (split-sequence #\/ row))))))
                             (loop for line in skim
                                for colon = (position #\: line)
                                for key = (make-keyword (cffi:translate-camelcase-name 
                                                         (substitute #\- #\_ (subseq line 0 colon))))
                                for rest = (trimmy (subseq line (1+ colon)))
                                for fn = (getf translator key)
                                collect (list key (if fn (funcall fn rest) (maybe-numeric rest)))))))
               :control-groups (split-and-collect-file (proc-file "cgroup") #\:)
               :command-line (collect-file-lines (proc-file "cmdline") #\Null)
               :environment (mapcar #'maybe-alist-row 
                                    (collect-file-lines (proc-file "environ") #\Null)))
              (mapcan (lambda (pair)
                        (let ((token (car pair))
                              (file (cdr pair)))
                          (list token (collect-file (proc-file file)))))
                      '((:program . "comm")
                        (:oom-score . "oom_score")
                        (:oom-adjust . "oom_adj")
                        (:oom-score-adjust . "oom_score_adj")
                        (:coredump-filter . "coredump_filter")))))))

(defun all-processes-info ()
  (loop for entry in (directory "/proc/*")
     for pid = (parse-integer (lastcar (pathname-directory entry)) :junk-allowed t)
     while entry
     when pid
     append (list pid (block try-collect-info
                        (handler-bind
                            ((error (lambda (c) (return-from try-collect-info 
                                                  (list :error c)))))
                          (process-info pid))))))

(defun start-server (argv)
  (romance:server-start-banner "Caesar"
                               "Gaius Julius Cæsar"
                               "Command and control server")
  (format t "~&[CIC] Exiting.~%"))

(defgeneric handle-report (module machine message-keyword user-string 
                           &key &allow-other-keys))

(defun keyword-journal-message-id (keyword)
  (subseq (cl-oauth:hmac-sha1 (string keyword) (package-name (symbol-package keyword)))
          0 15))

(defun keyword-priority-map (keyword) 
  3)

(defmethod handle-report :before (module machine message-keyword user-string 
                                  &rest keys)
  (apply #'systemd:journal-send 
         (let ((args (list :message user-string
                           :message-id (keyword-journal-message-id message-keyword)
                           :priority (keyword-priority-map message-keyword)
                           :syslog-identifier (concatenate 'string "Romance/" (string module) "@" (string machine)))))
           (when-let ((code-file (getf keys :source-file)))
             (appendf args (list :code-file code-file)))
           (when-let ((code-func (getf keys :source-function)))
             (appendf args (list :code-func code-func)))
           (when-let ((code-line (getf keys :source-line)))
             (appendf args (list :code-line code-line)))
           (when-let ((errno (getf keys :libc-errno)))
             (appendf args (list :errno errno)))
           args))
  (format *trace-output* "~&~%〈CIC〉 “~a”~{~%〈CIC〉 ⋅ ~:(~a:~) ~a~}" 
          user-string
          (append (list :module module :machine machine 
                        :message message-keyword) keys)))

(defmethod handle-report ((module t) (machine t) (message t) (user-string t)
                          &rest keys)
  (format *error-output*
          "~&[CIC] Message (~s) from module ~:(~a~): “~a”~{~&  ~32<~:(~a~)~>: ~a~}"
          message module user-string keys))

(defmethod handle-report ((module t) (machine t) (message (eql :qos)) (user-string t)
                          &key activity capacity vmstats)
  (collect-qos module machine activity capacity vmstats))

(defmethod handle-report ((module t) (machine t) (message (eql :begin-oversight)) (user-string t)
                          &key)
  (format *standard-output* "~&[CIC] Beginning module ~:(~a~) on machine ~:(~a~).~[  “~a”~]"
          module machine user-string))
(defmethod handle-report ((module t) (machine t) (message (eql :end-oversight)) (user-string t)
                          &key )
  (format *standard-output* "~&[CIC] Ending module ~:(~a~) on machine ~:(~a~).~[  “~a”~]"
          module machine user-string))

(defmethod handle-report ((module t) (machine t) (message (eql :machine-down)) (user-string t)
                          &key time-to-live)
  "The machine MACHINE is going down. Schedule replacement for any tasks
  pending on it.")

(defmethod handle-report ((module t) (machine t) (message (eql :lisp-warning)) (user-string t)
                          &key condition)
  "A Lisp program issued a WARNing"
  (journal ""))

(defmethod handle-report ((module t) (machine t) (message (eql :lisp-error)) (user-string t)
                          &key condition)
  "A Lisp program issued an ERROR."
  )

(define-condition report (condition)
  ((module :reader report-module :initarg :module :type symbol)
   (message-keyword :reader report-message :initarg :message-keyword :type symbol)
   (user-string :reader report-user-string :initarg :user-string :type string)
   (keys :reader report-keys :initarg :keys :type list)
   (machine :reader report-machine :initarg :machine :type string)))

(defvar *module*)

(defun report (message-keyword user-string &rest keys)
  (signal 'report :module (if (boundp *module*)
                              (symbol-value '*module*)
                              '#.(gensym "UNKNOWN-MODULE"))
          :message-keyword message-keyword
          :user-string user-string :keys keys :machine (machine-instance)))

(defmethod romance::todo :around (&optional message &rest keys)
  (apply #'report :todo message keys)
  (call-next-method))

(defmacro with-oversight ((module) &body body)
  `(let ((*module* ',module))
     (block ,(format-symbol *package* "~A-MODULE" (string module)) 
       (handler-bind
           ((report
             (lambda (r)
               (apply #'handle-report 
                      (or (report-module r) ',module)
                      (or (report-machine r) (machine-instance))
                      (report-message r)
                      (report-user-string r)
                      (report-keys r)))))
         (handler-bind
             ((error 
               (lambda (c)
                 (caesar:report :lisp-error
                                (format nil
                                        "Application signaled an ERROR condition:~%~S~% “~:*~A”"
                                        c)
                                :condition c
                                :restarts (compute-restarts)
                                :condition-restarts (compute-restarts c))))
              (warning (lambda (c)
                         (caesar:report :lisp-warning
                                        (format nil
                                                "Application signaled a WARNING condition:~%~S~% “~:*~A”"
                                                c)
                                        :condition c
                                        :restarts (compute-restarts)
                                        :condition-restarts (compute-restarts c)))))
           (caesar:report :begin-oversight "Beginning oversight by Caesar")
           (unwind-protect 
                (progn ,@body)
             (caesar:report :end-oversight "Ending oversight by Caesar")))))))
