(in-package :caesar)

(defun collate-quality-of-service-reports ())

(defun heartbeat-failure-detection ())

(defgeneric start-program-container (container-model
                                     location program-identifier))

(defmethod start-program-container ((container-model (eql :lxc))
                                    location
                                    program-identifier) :TODO)

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
