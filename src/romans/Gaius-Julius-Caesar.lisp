(defpackage :caesar
  (:use :cl :alexandria)
  (:nicknames :gaius-iulius-caesar)
  (:documentation "Caesar oversees the system on which it is running,
and ensures that sufficient resources are available for uninterrupted
operations. Caesar may terminate workers when they are no longer
needed, or requisition additional resources (such as starting a new
virtual machine or requesting additional storage space)
when necessary.

Gaius Julius Caesar was known as a famous general."))

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

