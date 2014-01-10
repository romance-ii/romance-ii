(defpackage :frontinus
  (:use :cl :alexandria)
  (:nicknames :sextus-julius-frontinus)
  (:documentation "Frontinus (Water Cycle)")
  (:export #:start-server))

(in-package :lutatius)

(defun server-start (argv)
  (romance:server-start-banner "Frontinus"
                               "Sextus Julius Frontinus"
                               "Water Cycle")
  (format t "~& Not doing anything (yet)"))
