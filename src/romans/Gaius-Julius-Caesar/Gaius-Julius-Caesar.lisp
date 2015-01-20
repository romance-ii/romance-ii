(in-package :caesar)

(define-condition todo-item ((note)))

(defun todo (&optional string &rest args)
  (error 'todo-item :note (apply #'format
                                 (or string "TODO: This function is not implemented")
                                 args)))

(defun collate-quality-of-service-reports ())

(defun heartbeat-failure-detection ())

(defgeneric start-program-container (container-model
                                     location program-identifier))

(defmethod start-program-container ((container-model (eql :lxc))
                                    location
                                    program-identifier) (todo))

(defgeneric launch-program (container program))

(defmethod launch-program (container (program (eql :postgres))) (todo))
(defmethod launch-program (container (program (eql :static-web-server))) (todo))
(defmethod launch-program (container (program t)) (todo))

(defun stop-program (identifier) (todo))

(defun kill-program (identifier) (todo))

(defun stop-program-container (identifier) (todo))

(defun stonith (identifier) (todo))

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
  "A Lisp program issued a WARNing"
  (journal ""))

(defmethod handle-report :after ((module t) (machine t) (message (eql :lisp-error)) (user-string t)
                                 &key condition)
  "A Lisp program issued an ERROR."
  )

(define-condition report (condition)
  ((module :reader  report-module :initarg :report-module :type symbol)
   (message-keyword :reader report-message :initarg :message-keyword :type symbol)
   (user-string :reader report-user-string :initarg :user-string :type string)
   (keys :reader report-keys :initarg :keys :type list)))

(defun report (module message-keyword user-string &rest keys)
  (signal 'report))

(defmacro with-oversight ((module) &body body)
  `(handler-bind
       (report
        (lambda (r)
          (apply #'handle-report (or (report-module r) ,module)
                 (or (report-machine r) (machine-instance))
                 (report-message-keyword r)
                 (report-user-string r)
                 (report-keys r))))
     
     (handler-bind
         (((warning error) 
           (lambda (c)
             (caesar:report ,module :lisp-error
                            (format nil
                                    "Application signaled an ERROR condition:~%~S~% “~:*~A”"
                                    c)
                            :condition c
                            :restarts (compute-restarts)
                            :condition-restarts (compute-restarts c)))))
       (caesar:report ,module :start-oversight "Beginning oversight by Caesar")
       (unwind-protect 
            (progn ,@body)
         (caesar:report ,module :end-oversight "Ending oversight by Caesar")))))
