(defpackage systemd-fds
  (:use :cl :alexandria :romance #+sbcl :sb-bsd-sockets)
  (:export #:listen-fds))

(in-package :systemd-fds)

(defconstant +listen-fds-start+ 3)

#+(or linux)
(defconstant +fd-cloexec+ 1)
#-linux
(warn "I need to know the value of FD_CLOEXEC for your OS.
You can probably get it by compiling a short C program, like:

#include <stdio.h>
#include <unistd.h>
#include <fcntl.h>
int main (int argc, char** argv)
{ printf (\"(DEFCONSTANT +FD-CLOEXEC+ %d)\", FD_CLOEXEC); 
  exit (0); }

Add this to the file ~A
with an appropriate #+(feature) tag for your OS; your *FEATURES*
contains the following (one of which should, hopefully, match your OS):
~S"
      (or *compile-file-truename* *load-truename* "systemd-daemon.lisp")
      *features*)

#+sbcl
(defun set-close-on-exec (socket)
  (let* ((fd (socket-file-descriptor socket))
         (flags (sb-posix:fcntl fd sb-posix:f-getfd)))
    (sb-posix:fcntl fd sb-posix:f-setfd 
                    (logior +fd-cloexec+ flags))))

#-(or sbcl)
(warn "Need to implement SET-CLOSE-ON-EXEC for ~A; add an
implementation to ~A 
with an appropriate #+(feature) tag for your OS; your *FEATURES*
contains the following (one of which should, hopefully, match your OS):
~S"
      (lisp-implementation-type)
      (or *compile-file-truename* *load-truename* "systemd-daemon.lisp")
      *features*)

#+sbcl
(defun socket-from-fd (fd)
  (todo))

#-(or sbcl)
(warn "Need to implement SOCKET-FROM-FD for ~A;
add an implementation to ~A
with an appropriate #+(feature) tag for your OS; your *FEATURES*
contains the following (one of which should, hopefully, match your OS):
~S"
      (lisp-implementation-type)
      (or *compile-file-truename* *load-truename* "systemd-daemon.lisp")
      *features*)

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


