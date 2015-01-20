(in-package :caesar)

(defun collate-quality-of-service-reports ())

(defun heartbeat-failure-detection ())

(defgeneric start-program-container (container-model
                                     location program-identifier))

(defun strings-list-p (list)
  (and (cons list)
       (every #'stringp list)))

(deftype strings-list ()
  '(satisfies string-list-p))

(defmacro run-external/local ((name command args environ
                                    input output error-output
                                    killp) &body body)
  (let ((child (gensym "CHILD")))
    `(with-open-stream (,input (make-broadcast-stream))
       (with-open-stream (,output (make-broadcast-stream))
         (with-open-stream (,error-output (make-broadcast-stream))
           (let ((,child (sb-posix:fork)))
             (unwind-protect
                  (if (zerop ,child)
                      (let ((*standard-input* ,input)
                            (*standard-output* ,output)
                            (*error-output* ,error-output)
                            (*trace-output* nil)
                            (*debug-io* nil)
                            (*query-io* nil))
                        (swank/sbcl::sys-execv (list ,command ,args)))
                      (progn ,@body))
               ,(when killp
                      `(progn (sb-posix:kill ,child sb-posix:SIGTERM)
                              (sleep 0.01) ;; FIXME
                              (sb-posix:kill ,child sb-posix:SIGKILL))))))))))

(defmacro run-external/remote ((host name command args environ
                                     input output error-output) &body body))

(defun run-external (host name (command args &optional environ))
  (check-type host (or null string symbol))
  (check-type name (or null string symbol))
  (check-type command (or string pathname))
  (check-type input symbol)
  (check-type output symbol)
  (check-type error-output symbol)
  (if (and (constantp host)
           (or (null host)
               (equal (string host) "localhost")))
      `(run-external/local ,(list (string name) 
                                  command args environ 
                                  input output error-output)
                           ,@body)
      `(if (or (null host)
               (equal (string host) "localhost")
               (equal (string host) (machine-instance)))
           `(run-external/local ,(list (string name) 
                                       command args environ
                                       input output error-output)
                                ,@body)
           `(run-external/remote ,(list (string host) (string name) 
                                        command args environ 
                                        input output error-output)
                                 ,@body))))

(defmethod start-program-container ((container-model (eql :docker))
                                    location
                                    program-identifier)
  (run-external ))

(defgeneric launch-program (container program))

(defmethod launch-program (container (program (eql :postgres))) :TODO)
(defmethod launch-program (container (program (eql :static-web-server))) :TODO)
(defmethod launch-program (container (program t)) :TODO)

(defun stop-program (identifier) :TODO)

(defun kill-program (identifier) :TODO)

(defun stop-program-container (identifier) :TODO)

(defun stonith (identifier) :TODO)

(defun start-server (argv)
  (romance:server-start-banner "Caesar"
                               "Gaius Julius Cæsar"
                               "Command and control server")
  (format t "~&[CIC] Exiting.~%"))

(defgeneric handle-report (module machine message-keyword user-string 
                           &key &allow-other-keys))

(defmethod handle-report ((module t) (machine t) (message t) (user-string t)
                          &rest keys)
  (format *trace-output*
          "~&~:(~A~): “~A” (~:(~a~))~{~&  ~32<~:(~A~)~>: ~A~}"
          module user-string message keys))

(defmethod handle-report :after ((module t) (machine t) (message (eql :qos)) (user-string t)
                                 &key activity capacity room-used room-total)
  (collect-qos module machine activity))

(defmethod handle-report :after ((module t) (machine t) (message (eql :begin-oversight)) (user-string t)
                                 &key )
  (start-oversight module machine))
(defmethod handle-report :after ((module t) (machine t) (message (eql :end-oversight)) (user-string t)
                                 &key )
  (end-oversight module machine))

(defmethod handle-report :after ((module t) (machine t) (message (eql :machine-down)) (user-string t)
                                 &key time-to-live)
  "The machine MACHINE is going down. Schedule replacement for any tasks
  pending on it.")

(defmethod handle-report :after ((module t) (machine t) (message (eql :lisp-warning)) (user-string t)
                                 &key condition)
  "A Lisp program issued a WARNing")

(defmethod handle-report :after ((module t) (machine t) (message (eql :lisp-error)) (user-string t)
                                 &key condition)
  "A Lisp program issued an ERROR."
  )

(defun report (module message-keyword user-string &rest keys)
  ())

(with-oversight (foobulous) (warn "boo"))

(defmacro with-oversight ((module) &body body)
  `(handler-bind
       ((or warning error) (lambda (c)
                             (caesar:report ,module :lisp-error
                                            (format nil
                                                    "Application signaled an ERROR condition:~%~S~% “~:*~A”"
                                                    c)
                                            :condition c
                                            :restarts (compute-restarts)
                                            :condition-restarts (compute-restarts c))))
     (caesar:report ,module :start-oversight "Beginning oversight by Caesar")
     (unwind-protect 
          (progn ,@body)
       (caesar:report ,module :end-oversight "Ending oversight by Caesar"))))
