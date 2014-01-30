(defpackage :galen
  (:use :cl :alexandria)
  (:nicknames :aelius-galenus :claudius-galenus)
  (:documentation "Galen handles the system whereby superposed states
of quiesced arrondissements are collapsed into a discrete state. In
other words: Galen burgeons areas that had been quiesced previously.

Galen was a noted philosopher, logician, and inventor.

This subsystem won't be in place yet for Romance 2.0")
  (:export #:start-server))

(in-package :galen)
(defun start-server (argv)
  (romance:server-start-banner "Galen"
                               "Ælius Claudius Galenus"
                               "Burgeoning quiesced subspace server")
  (format t "~&Galen: no op."))


