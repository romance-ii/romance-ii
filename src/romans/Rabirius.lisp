(defpackage :rabirius
  (:use :cl :alexandria)
  (:documentation "Rabirius (geography)")
  (:export #:start-server))

(in-package :lutatius)

(defun server-start (argv)
  (romance:server-start-banner "Rabrius"
                               "Rabirius"
                               "Geography")
  (format t "~& Not doing anything (yet)"))
