(defpackage :regillus
  (:use :cl :alexandria)
  (:nicknames :lucius-aemilius-regillus)
  (:documentation "Regillus (pathfinding)")
  (:export #:start-server))

(in-package :regillus)

(defun server-start (argv)
  (romance:server-start-banner "Regillus"
                               "Lucius Aemilius Regillus"
                               "Pathfinding Server")
  (format t "~& Not doing anything (yet)"))
