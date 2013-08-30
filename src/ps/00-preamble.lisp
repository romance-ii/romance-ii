;; -*- lisp -*-

                                        ;(defpackage "VIOLET-VOLTS"
                                        ;(:use :parenscript :common-lisp)
                                        ;)


                                        ;(in-package "VIOLET-VOLTS")

;; (handler-bind
;;     ((name-conflict
;;       (lambda (c)
;;         (declare (ignorable c))
;;         (when (find-restart 'sb-impl::take-new)
;;           (invoke-restart 'sb-impl::take-new))
;;         (format *error-output*
;;                 "~& No TAKE-NEW restart on NAME-CONFLICT; ~&~S 
;;  Found: ~{~% • ~S ~}~%" c (compute-restarts)))))
;;   (use-package :ps))

(setf parenscript::*js-string-delimiter* #\'
      parenscript::*js-target-version*   1.6)

(defmacro ps::by-id (id)
  `((@ document get-element-by-id) ,id))

(defmacro concat (&rest stuff)
  (append (list 'concatenate 'string) stuff))



