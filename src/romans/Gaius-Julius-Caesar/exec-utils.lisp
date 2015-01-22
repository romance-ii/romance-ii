(in-package :caesar)


;; Utilities related to executing local processes

(define-condition unable-to-exec-error (error)
  ((returned :initarg :returned :reader syscall-return-value)))

;;; The EXECVE call below is taken from the Public-Domain version of EXECV
;;; written in 2003 by Daniel Barlow <dan@metacircles.com> (and explicitly
;;; placed into the Public Domain) as a part of the Swank backend for
;;; SBCL. This modified version is licensed as a part of Caeser (i.e. under
;;; the same terms as the rest of this program).

#+(and sbcl unix)
(sb-alien:define-alien-routine ("execve" sys-execve) sb-alien:int
  (program sb-alien:c-string)
  (argv (* sb-alien:c-string))
  (env (* sb-alien:c-string)))

#+ (and sbcl unix)
(defun execve (program args environ)
  "Replace current executable with another one. This is a direct wrapper
around the execve in the C library, which in turn calls the execve system
call; refer to the manual pages for details. In particular, note that the
zeroeth argument is generally the (possibly-cosmetic version of the)
program's name."
  (let ((alien-args (sb-alien:make-alien sb-alien:c-string
                                         (+ 1 (length args))))
        (alien-env (sb-alien:make-alien sb-alien:c-string
                                        (+ 1 (length environ)))))
    (unwind-protect
         (progn
           (loop for index from 0 by 1
              and item in (append args '(nil))
              do (setf (sb-alien:deref alien-args index)
                       item))
           (loop for index from 0 by 1
              and item in (append environ '(nil))
              do (setf (sb-alien:deref alien-env index)
                       (etypecase item
                         (cons (concatenate 'string
                                            (string (car item))
                                            "="
                                            (string (cdr item))))
                         (string item))))
           (let ((returned (sys-execve program alien-args alien-env)))
             (error 'unable-to-exec-error :returned returned)))
      (sb-alien:free-alien alien-args))))

;;; end of Swank-Backend-inspired code



(defmacro run-external/local ((name command args environ
                                    input output error-output
                                    killp) &body body)
  "Run a local program."
  (let ((child (gensym "CHILD")))
    `(with-open-stream (,input (make-broadcast-stream))
       (with-open-stream (,output (make-broadcast-stream))
         (with-open-stream (,error-output (make-broadcast-stream))
           (let ((,child (sb-posix:fork)))
             (unwind-protect
                  (if (zerop ,child)
                      (let ((*standard-input* ,input)
                            (*standard-output* ,output)
                            (*error-output* ,error-output)
                            (*trace-output* nil)
                            (*debug-io* nil)
                            (*query-io* nil))
                        (execve ,command
                                (cons ,name ,args)
                                ,environ))
                      (progn ,@body))
               ,(when killp
                      `(progn (sb-posix:kill ,child sb-posix:SIGTERM)
                              (sleep 1/100) ;; FIXME
                              (sb-posix:kill ,child sb-posix:SIGKILL))))))))))



(defun all-threads/alpha ()
  (sort (all-threads)
        #'string< :key (compose #'string-downcase #'thread-name)))

(defun what (&aux (proc (this-process)))
  (format t "~&~%Process ~A (~D) ~A on ~A"
          (process-name proc) 
          (process-id proc) (process-state-gerund proc)
          (machine-instance))
  (dolist (thread (all-threads/alpha))
    (format t "~& • ~A ~@[☠~]"
            (thread-name thread) (not (thread-alive-p thread)))))

(defvar *myselfness* 42)

(defun get-myselfness ()
  (incf *myselfness*))

(defun who ()
  (dolist (thread (all-threads/alpha))
    (format t "~& ~A ⇒ ~A"
            (thread-name thread)
            (interrupt-thread thread
                              (lambda () (get-myselfness))))))

(defun find-thread (name)
  (find name (all-threads) :key #'thread-name))

(defun read-from-thread (thread function)
  (let ((stream (make-string-output-stream)))
    (interrupt-thread thread (lambda () (ignore-errors (prin1 (funcall function) stream))))
    (read-from-string (get-output-stream-string stream))))


