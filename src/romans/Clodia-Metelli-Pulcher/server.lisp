(in-package :clodia)
(defun start-server (&optional argv)
  (romance:server-start-banner "Clodia"
                               "Clodia Metelli Pulcher"
                               "Artificially Intelligent Logical Agent Server")
  (format t "~&Clōdia: Hi. Bye.~%"))
