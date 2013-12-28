(defpackage :asinius
  (:use :cl :alexandria :postmodern)
  (:nicknames :gaius-asinius-pollio)
  (:documentation
   "Asinius handles connectivity to the Postgres database server, for
long-term storage and disaster recovery.

Gaius Asinius Pollio was a consul noted for constructing the first
public library in Rome, the Atrium Libertatis, as a posthumous favor
to Caesar.")
  (:export #:start-server))

(in-package :asinius)


(defun mq-to-postmodern ())

(defun postmodern-to-mq ())

(defun get-quality-of-service ())

(defun get-quality-of-service-from-postgres ())

(defun map-entity-data-to-postgres ())



(defun start-server (argv)
  (romance:server-start-banner "Asinius"
                               "Gaius Asinius Pollio"
                               "Database persistence layer")
  (format t "~&Gaius Asinius Pollio: No-op."))
