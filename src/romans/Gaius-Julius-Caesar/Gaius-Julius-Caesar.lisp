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

