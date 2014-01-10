(defpackage :vitruvius
  (:use :cl :alexandria)
  (:nicknames :marcus-vitruvius-pollio)
  (:documentation "Vitruvius (genotype, morphotype)")
  (:export #:start-server))

(in-package :lutatius)

(defun server-start (argv)
  (romance:server-start-banner "Vitruvius"
                               "Marcus Vitruvius Pollio"
                               "genotype, morphotype")
  (format t "~& Not doing anything (yet)"))
