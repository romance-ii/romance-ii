(in-package :narcissus)

(define-condition unable-to-load-c++-libraries ()
  ((libs-loaded) (error-condition) (user-message)))

(defun start-server (argv)
  (caesar:with-oversight (:narcissus)
    (romance:server-start-banner "Narcissus" "Narcissus"
                                 "Physical forces simulation server"))
  (format t "~& Narcissus: Bye!~%"))


