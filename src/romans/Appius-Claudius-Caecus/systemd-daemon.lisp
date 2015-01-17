(defpackage systemd-fds
  (:use :cl :alexandria)
  (:export #:listen-fds))

(in-package :systemd-fds)

(defconstant +listen-fds-start+ 3)

#+sbcl
(defun set-close-on-exec (socket)
  )

#-(or sbcl)
(error "Need to implement SET-CLOSE-ON-EXEC for ~A"
       (lisp-implementation-type))

#+sbcl
(defun socket-from-fd (fd))

#-(or sbcl)
(error "Need to implement SOCKET-FROM-FD for ~A"
       (lisp-implementation-type))


(defun listen-fds ()
  (when-let ((listen-pid 
              (parse-integer (sb-posix:getenv "LISTEN_PID")
                             :junk-allowed t)))
    (when (= listen-pid (sb-posix:getpid))
      (when-let ((listen-fds 
                  (parse-integer (sb-posix:getenv "LISTEN_FDS")
                                 :junk-allowed t)))
        (if (zerop listen-fds)
            (error "Asked to listen for zero FDs? SystemD environment error")
            (loop for fd
               from +listen-fds-start+ 
               upto (+ listen-fds
                       +listen-fds-start+)
               do (set-close-on-exec fd)
               collect (socket-from-fd fd)))))))


