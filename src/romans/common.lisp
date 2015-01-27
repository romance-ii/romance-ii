(defpackage :romance
  (:use :cl :alexandria :split-sequence)
  (:nicknames :romans :romance-ii :romance2)
  (:documentation
   "Common code used by other modules in Romance Ⅱ")
  (:export
   #:+inline-whitespace+
   #:+often-naughty-chars+
   #:+whitespace+
   #:a/an
   #:a/an/some
   #:any
   #:copyrights
   #:counting
   #:c-style-identifier
   #:c-style-identifier-p
   #:doseq
   #:escape-by-doubling
   #:escape-c-style
   #:escape-lispy
   #:escape-url-encoded
   #:escape-with-char
   #:for-all
   #:for-any
   #:forever
   #:join
   #:keywordify
   #:letter-case
   #:make-t-every-n-times
   #:modincf
   #:membership
   #:plural
   #:repeat
   #:server-start-banner
   #:start-repl
   #:start-server/generic
   #:strcat
   #:string-case
   #:string-escape
   #:string-fixed
   #:strings-list
   #:strings-list-p
   #:until
   #:while
   #:without-warnings

   ))

(require :babel)

(in-package :romance)

(defun start-server/generic (&optional argv)
  (case (make-keyword (string-upcase (car argv)))
    (:caesar (warn "TODO Caesar"))
    (:copyrights (format t (copyrights t)))
    (otherwise
     (format t "Romance Ⅱ: Generic Executable.

Provide the name of the module to start; Caesar will launch
other modules.

REPL, HELP, or COPYRIGHTS are also options."))))

(defun romanize-print (stream string)
  (let ((len (length string))
        (string (substitute #\C #\G
                            (substitute #\I #\J
                                        (substitute #\V #\U
                                                    string)))))
    (format stream "~|~3%; ~VT ~V,,,'=A~%~3:*; ~VT ~2* ~:@(~A~)~%~4:*; ~VT ~V,,,'=A~3%"
            (round (- 34 (/ len 2))) (+ 2 len) "" string)))

(defun server-start-banner (short-name long-name purpose)
  (romanize-print *standard-output* short-name)

  (format *standard-output* "
~|
;
; ----------------------------------------------------------------------
;
; Romance Ⅱ Game System        ~40@A
;
; ~A
;
; ----------------------------------------------------------------------
Server-Process = ~A
Machine-Instance = ~:(~A~)
Machine-Type = ~A
Compiler = ~A ~A
Software = ~A ~A

/COPYRIGHTS~%~A~%\\COPYRIGHTS~%"
          long-name purpose short-name 
          (machine-instance) (machine-type)
          (lisp-implementation-type) (lisp-implementation-version)
          (software-type) (software-version)
          (copyrights))

  (romanize-print *standard-output* long-name))



