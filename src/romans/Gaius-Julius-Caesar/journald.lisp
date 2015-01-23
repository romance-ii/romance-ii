(in-package :caesar)

(defpackage :systemd (:use :cl :sb-alien :cffi)
            (:export 
             #:notify-dbus-error
             #:notify-libc-error
             #:notify-main-pid
             #:notify-ping-watchdog
             #:notify-state
             #:journal-send))

(in-package :systemd)

(eval-when (:load-toplevel :compile-toplevel :execute)
  (define-foreign-library libsystemd
    (t "libsystemd.so")))

(eval-when (:load-toplevel)
  (load-foreign-library 'libsystemd))

#+sbcl
(defun journal-send (&rest p-list)
  (let ((ret (eval 
              `(alien-funcall
                (extern-alien "sd_journal_send"
                              (function sb-alien:int 
                                        ,@(romans::repeat
                                           'c-string (length p-list))
                                        c-string))
                ,@(loop for (key value) on p-list by #'cddr
                     collect (concatenate 'string (string-upcase (string key))
                                          "=%s")
                     collect (princ-to-string value))
                nil))))
    (values (zerop ret) ret)))

#-sbcl
(warn "You'll need to insert a JOURNAL-SEND implementation in the
SYSTEMD package, or whatever your OS uses instead. File:~%~A"
      (or *compile-file-truename* *load-truename*))

#+sbcl
(defun notify% (string)
  (let ((ret (alien-funcall (extern-alien "sd_notify"
                                          (function sb-alien:int
                                                    sb-alien:int 
                                                    c-string))
                            0 string)))
    (values (zerop ret) ret)))

#-sbcl
(warn "You'll need to insert a NOTIFY% implementation in the
SYSTEMD package, or whatever your OS uses instead. File:~%~A"
      (or *compile-file-truename* *load-truename*))

(defvar *state%* :starting)
(defvar *status$%* :starting)

(defun assert-state-change-valid-p% (new-state)
  (ecase *state%*
    (:starting (assert (member new-state
                               '(:starting 
                                 :ready 
                                 :reloading
                                 :stopping))))
    (:ready (assert (member new-state
                            '(:ready
                              :reloading
                              :stopping))))
    (:reloading (assert (member new-state
                                '(:ready
                                  :reloading
                                  :stopping))))
    (:stopping (assert (member new-state '(:stopping 
                                           :reloading))))))

(defun make-percentage-status (number)
  (let ((per-cent (if (<= number 1)
                      (* 100 number)
                      number)))
    (setf *status$%* (format nil "~:(~A~)~@[ module ~A~]: ~D%"
                             *state%*
                             (when (boundp 'caesar:*module*)
                               (symbol-value 'caesar:*module*))
                             per-cent))))

(defun notify-state (new-state status-text &optional extra-status)
  (assert-state-change-valid-p% new-state)
  (setf *state%* new-state)
  (etypecase status-text
    (null nil)
    (real (make-percentage-status status-text))
    (string (setf *status$%* status-text)))
  (notify% (format nil "~:@(~A~)=1
STATUS=~A~@[~%~A~]~%" *state%* *status$%* extra-status)))

(defun notify-libc-error (libc-error-number status-text)
  (assert (and (integerp libc-error-number)
               (< 0 libc-error-number #xff)))
  (notify-state *state%* status-text
                (format nil "ERRNO=~D" libc-error-number)))

(defun notify-dbus-error (dbus-error-ident status-text)
  (notify-state *state%* status-text
                (format nil "BUSERROR=~A" dbus-error-ident)))

(defun notify-main-pid (&optional (process-id (sb-posix:getpid)))
  (assert (and (integerp process-id)
               (< 1 process-id)))
  (notify-state *state%* *status$%*
                (format nil "MAINPID=~D" process-id)))

(defun notify-ping-watchdog ()
  (notify-state *state%* *status$%* "WATCHDOG=1"))




