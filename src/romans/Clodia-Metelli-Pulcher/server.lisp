(in-package :clodia)
(defun start-server (&optional argv)
  (romans:server-start-banner "Clodia"
                              "Clodia Metelli Pulcher"
                              "Artificially Intelligent Logical Agent Server")
  (format t "~&Clōdia: Hi. Bye.~%"))
