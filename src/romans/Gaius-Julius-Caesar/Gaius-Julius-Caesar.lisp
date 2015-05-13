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

#+sbcl
(defun find-throwing-frame ()
  (loop with signal-function-found = nil
     for frame = (or sb-debug:*stack-top-hint* (sb-di:top-frame)) 
     then (sb-di:frame-down frame)
     for function = (ignore-errors
                      (sb-di:debug-fun-name
                       (sb-di:frame-debug-fun frame)))
     do (cond ((member function '(signal throw error))
               (setf signal-function-found t))
              (signal-function-found
               (return-from find-throwing-frame frame)))))

#+sbcl
(defun frame-funcall (frame)
  (format nil "(~S~{ (~S←~S ~[✗~;✓~]~})"
          (ignore-errors
            (sb-di:debug-fun-name 			    
             (sb-di:frame-debug-fun frame)))
          (or (map 'list (lambda (var)
                           (or (ignore-errors
                                 (when (eq :valid
                                           (sb-di:debug-var-validity 
                                            var (sb-di:frame-code-location frame)))
                                   (list (sb-di:debug-var-symbol var)
                                         (sb-di:debug-var-value var frame)
                                         t)))
                               (list var '#:? nil)))
                   (ignore-errors (sb-di::debug-fun-debug-vars
                                   (sb-di:frame-debug-fun frame))))
              (list '#:? '#:… nil))))

(defun journal-condition (module machine message user-string &optional condition)
  (let* ((throwing-frame (find-throwing-frame))
         (debug-source (sb-di:code-location-debug-source 
                        (sb-di:frame-code-location throwing-frame))))
    (systemd:journal-send
     (cons (cons (list :message user-string
                       :priority (keyword-priority-map message)
                       :code-file (sb-di:debug-source-namestring debug-source)
                       :code-line (sb-di:debug-source-form debug-source)
                       :code-func (frame-funcall throwing-frame)
                       :x-module (string module)
                       :x-machine (string machine))
                 (when condition
                   (list :x-condition (princ-to-string condition)
                         :x-condition-type message)))
           (when-let ((message-id (keyword-journal-message-id message)))
             :message-id message-id)))))

(defmethod handle-report :before (module machine message-keyword user-string 
                                  &rest keys)
  (journal-condition module machine message-keyword user-string)
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

(defmethod handle-report ((module t) (machine t)
                          (message (eql :lisp-warning)) (user-string t)
                          &key condition)
  "A Lisp program issued a WARNing"
  )

(defmethod handle-report ((module t) (machine t) (message (eql :lisp-error)) (user-string t)
                          &key condition)
  "A Lisp program issued an ERROR."
  (journal-condition module machine message user-string condition))

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
(define-condition hook-early-timeout (hook-timeout)
  ())
(define-condition hook-soft-timeout (hook-timeout)
  ())
(define-condition hook-hard-timeout (hook-timeout)
  ())

(defun get-real-time ()
  (/ (get-internal-real-time)
     internal-time-units-per-second))

(defun timeout-handler%early (soft-timeout hard-timeout)
  `((< elapsed ,(or soft-timeout hard-timeout))
    (report :false-timeout "TIMEOUT signaled early (continuing, ignoring this)"
            :condition condition
            :elapsed-time elapsed
            :soft-timeout ,soft-timeout
            :hard-timeout ,hard-timeout)
    (signal 'hook-early-timeout :elapsed-time elapsed)
    (continue)))

(defun timeout-handler%soft (soft-timeout hard-timeout)
  (when soft-timeout
    `(((and ,@(when soft-timeout
                    `((<= ,soft-timeout elapsed)))
            (< elapsed ,hard-timeout)
            t)
       (report :soft-timeout "Function exceeded soft timeout"
               :condition condition
               :elapsed-time elapsed
               :soft-timeout ,soft-timeout)
       (continue)))))

(defun timeout-handler%hard (soft-timeout hard-timeout)
  `((t 
     (report :hard-timeout "Function exceeded hard timeout and is being aborted"
             :condition condition
             :elapsed-time elapsed
             :hard-timeout ,hard-timeout)
     (signal 'hook-hard-timeout :elapsed-time elapsed)
     (abort))))

(defmacro with-timeout-handler ((soft-timeout hard-timeout) &body body)
  (check-type soft-timeout (or real symbol null))
  (check-type hard-timeout (or real symbol null))
  (let ((timer-tag (gensym "TIMEOUT-BLOCK-")))
    (if (or soft-timeout hard-timeout)
        (let ((soft-timeout (if (and (realp soft-timeout)
                                     (realp hard-timeout))
                                (min soft-timeout hard-timeout)
                                soft-timeout))
              (hard-timeout (if (and (realp soft-timeout)
                                     (realp hard-timeout))
                                (max soft-timeout hard-timeout)
                                soft-timeout))
              (timer (gensym "TIMER-")))
          `(block ,timer-tag
             (let ((,timer (get-real-time)))
               (handler-bind
                   ((timeout (lambda (condition)
                               (let ((elapsed (- (get-real-time) ,timer)))
                                 (cond
                                   ,@(timeout-handler%early soft-timeout hard-timeout)
                                   ,@(timeout-handler%soft soft-timeout hard-timeout)
                                   ,@(timeout-handler%hard soft-timeout hard-timeout))))))
                 (,@(if (realp hard-timeout) 
                        (list 'with-timeout (list hard-timeout))
                        (list 'identity))
                    (,@(if (realp soft-timeout) 
                           (list 'with-timeout (list soft-timeout))
                           (list 'identity))
                       ,@body))))))
        `(block ,timer-tag
           ,@body))))

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


