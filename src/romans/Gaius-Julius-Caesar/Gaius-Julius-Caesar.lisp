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


(defun report (module message-keyword user-string &rest keys)
  ;; TODO
  (format *error-output*
          "~&~|~%/C/ CAESAR should have received this report:
/C/ From: ~:(~A~) @ ~:(~A~)
/C/ Keyword: ~:(~A~)
\"\"\"
~A
\"\"\"~:[~;~:*~{~&/C/ ~:(A~): ~S~}~]
/*/
"
          module (machine-instance) message-keyword user-string keys))

(defmacro with-oversight ((module) &body body)
  `(handler-bind
       ((warning (lambda (c)
                   (caesar:report ,module :lisp-warning
                           (format nil
                                   "Application signaled a WARNING condition:~%~S~% “~:*~A”"
                                   c)
                           :condition c)))
        (error (lambda (c)
                 (caesar:report ,module :lisp-error
                         (format nil
                                 "Application signaled an ERROR condition:~%~S~% “~:*~A”"
                                 c)
                         :condition c))))
     (caesar:report ,module :start-oversight "Beginning oversight by Caesar")
     (prog1 
         (progn ,@body)
       (caesar:report ,module :end-oversight "Ending oversight by Caesar"))))

