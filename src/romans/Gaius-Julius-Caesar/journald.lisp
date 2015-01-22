(in-package :caesar)

(defpackage :systemd (:use :cl :sb-alien)
            (:export #:journal-send))

(in-package :systemd)

(define-foreign-library libsystemd
  (t "libsystemd.so"))

(eval-when (:load-toplevel)
  (load-foreign-library 'libsystemd))

(defun journal-send (&rest p-list)
  (let ((ret (eval `(alien-funcall
                     (extern-alien "sd_journal_send"
                                   (function sb-alien:int 
                                             ,@(repeat 'c-string (length p-list))
                                             c-string))
                     ,@(loop for (key value) on p-list by #'cddr
                          collect (concatenate 'string (string-upcase (string key))
                                               "=%s")
                          collect (princ-to-string value))
                     nil))))
    (values (zerop ret)
            ret)))



