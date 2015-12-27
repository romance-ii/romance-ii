(in-package :asinius)


(defun mq-to-postmodern ())

(defun postmodern-to-mq ())

(defun get-quality-of-service ())

(defun get-quality-of-service-from-postgres ())

(defun map-entity-data-to-postgres ())



(defun start-server (&optional argv)
  (romans:server-start-banner "Asinius"
                              "Gaius Asinius Pollio"
                              "Database persistence layer")
  (format t "~&Gaius Asinius Pollio: No-op."))
