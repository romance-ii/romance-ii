(in-package :caesar)

;;; SSH / Remote execution utilities



(defparameter *ssh-program* "/usr/bin/ssh"
  "The pathname to the SSH program to be executed.")
(defparameter *ssh-program-name* "ssh"
  "The (cosmetic) name to pass as argv[0] to the SSH program")
(defparameter *ssh-args* '("-A" "-C" "-e" "none")
  "A list of arguments always passed to SSH")
(defparameter *ssh-extra-args* ()
  "A list of additional arguments passed to SSH. Identical in purpose to SSH-ARGS.")
(defparameter *ssh-option-args* ()
  "A list of SSH option arguments passed to SSH, in AList form. Remapped to
  -Ooption-name=value. EG: (:foo . \"Bar\) maps to \"-OFOO=Bar\".")

(defun ssh-effective-args (&rest args)
  "Returns the argument vector for calling SSH, with ARGS appended."
  (list* (list *ssh-program-name* *ssh-args* *ssh-extra-args*)
         (mapcar (lambda (pair) (concatenate 'string
                                             "-O"
                                             (string (car pair))
                                             "="
                                             (string (cdr pair))))
                 *ssh-option-args*)
         args))

(defmacro run-external/remote ((host name command args environ
                                     input output error-output) &body body)
  `(run-external/local ((concatenate 'string "Remote " ,name " on " ,host)
                        *ssh-program*
                        (ssh-effective-args ,host ,command ,@args)
                        ,environ
                        ,input ,output ,error-output)
     ,@body))


