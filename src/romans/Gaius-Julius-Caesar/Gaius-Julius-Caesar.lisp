(in-package :caesar)

(import 'romance::split-and-collect-file)
(import 'romance::collect-file)
(import 'romance::collect-file-lines)
(import 'romance::collect-file-tabular)
(import 'romance::maybe-alist-split)
(import 'romance::maybe-alist-row)
(import 'romance::maybe-numeric)


(defun collate-quality-of-service-reports ())

(defun heartbeat-failure-detection ())





(defun machine-vmstat ()
  (split-and-collect-file "/proc/vmstat"))

(defun machine-meminfo ()
  (split-and-collect-file "/proc/meminfo" #\:
                          #'cffi:translate-camelcase-name))

(defun all-process-ids ()
  (loop for entry in (directory "/proc/*")
     for pid = (parse-integer (lastcar (pathname-directory entry)) :junk-allowed t)
     while entry
     when pid collect it))




(defun collect-qos (module machine activity capacity vmstats))



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
          "~&~%[CIC] Message (~s) from module ~:(~a~): “~a”~{~&  ~32<~:(~a~)~>: ~a~}"
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
  (journal module machine message user-string))

(defmethod handle-report ((module t) (machine t) (message (eql :lisp-error)) (user-string t)
                          &key condition)
  "A Lisp program issued an ERROR."
  (journal module machine message user-string))

(define-condition report (condition)
  ((module :reader report-module :initarg :module :type symbol)
   (message-keyword :reader report-message :initarg :message-keyword :type symbol)
   (user-string :reader report-user-string :initarg :user-string :type string)
   (keys :reader report-keys :initarg :keys :type list)
   (machine :reader report-machine :initarg :machine :type string)))

(defvar *module*)

(defun report (message-keyword user-string &rest keys)
  (signal 'report :module (if (boundp '*module*)
                              (symbol-value '*module*)
                              '#.(gensym "UNKNOWN-MODULE"))
          :message-keyword message-keyword
          :user-string user-string :keys keys :machine (machine-instance)))

(defmethod romance::todo :around (&optional message &rest keys)
  (apply #'report :todo message keys)
  (call-next-method))



(defun oversight-handle (case)
  `(,case
       (lambda (condition)
         (caesar:report ,(make-keyword (concatenate 'string "LISP-" (string case)))
                        (format nil
                                ,(concatenate 'string "Application signaled "
                                              (a/an (string case)) 
                                              " condition:~%~S~% “~:*~A”")
                                condition)
                        :condition condition
                        :restarts (compute-restarts)
                        :condition-restarts (compute-restarts condition)))))

(define-condition hook-timeout (warning)
  ((elapsed-time :initarg :elapsed-time :reader timeout-elapsed-time)))
(define-condition hook-soft-timeout (hook-timeout)
  ())
(define-condition hook-hard-timeout (hook-timeout)
  ())

(defmacro with-timeout-handler ((soft-timeout hard-timeout) &body body)
  (let ((soft-timeout (min soft-timeout hard-timeout))
        (hard-timeout (max soft-timeout hard-timeout))
        (timer (gensym "TIMER")))
    `(let ((,timer (/ (get-internal-real-time) internal-time-units-per-second)))
       (handler-bind
           ((timeout (lambda (condition)
                       (let ((elapsed (- (/ (get-internal-real-time) internal-time-units-per-second)
                                         ,timer)))
                         (cond ((< elapsed ,soft-timeout)
                                (report :false-timeout "TIMEOUT signaled before soft timeout"
                                        :condition condition
                                        :elapsed-time elapsed
                                        :soft-timeout ,soft-timeout
                                        :hard-timeout ,hard-timeout)
                                (signal 'hook-soft-timeout :elapsed-time elapsed)
                                (continue))
                               ((and (<= ,soft-timeout elapsed)
                                     (< elapsed ,hard-timeout))
                                (report :soft-timeout "Function exceeded soft timeout"
                                        :condition condition
                                        :elapsed-time elapsed
                                        :soft-timeout ,soft-timeout)
                                (continue))
                               (t 
                                (report :hard-timeout "Function exceeded hard timeout and is being aborted"
                                        :condition condition
                                        :elapsed-time elapsed
                                        :hard-timeout ,hard-timeout)
                                (signal 'hook-hard-timeout :elapsed-time elapsed)
                                (abort)))))))
         (with-timeout (,hard-timeout)
           (with-timeout (,soft-timeout)
             ,@body))))))

(defmacro with-report-acceptor (&body body)
  `(handler-bind
       ((report
         (lambda (r)
           (apply #'handle-report 
                  (or (report-module r) *module*)
                  (or (report-machine r) (machine-instance))
                  (report-message r)
                  (report-user-string r)
                  (report-keys r)))))
     ,@body))

(defmacro with-oversight ((module &key soft-timeout hard-timeout) &body body)
  `(let ((*module* ',(string module)))
     (block ,(format-symbol *package* "~A-MODULE" (string module))
       (with-report-acceptor
         (with-timeout-handler (,soft-timeout ,hard-timeout)
           (handler-bind
               (,(oversight-handle 'error)
                ,(oversight-handle 'warning))
             (caesar:report :begin-oversight "Beginning oversight by Caesar")
             (unwind-protect 
                  (progn ,@body)
               (caesar:report :end-oversight "Ending oversight by Caesar"))))))))


