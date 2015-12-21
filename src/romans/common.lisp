(in-package :romans)

(defun start-server (&optional argv)
  (let ((module (make-keyword (string-upcase (car argv)))))
    (case module
      (:caesar
       (funcall (intern "START-SERVER" (find-package module))))
      (:copyrights (format t (copyrights t)))
      (:repl (start-repl))
      ((:help :-h :/h :/help :--h :--he :--hel :--help :h :? :/? :-?)
       (command-line-help))
      (otherwise
       (format t "Romance Ⅱ: Generic Executable.

Provide the name of the module to start; Caesar will launch
other modules. (Module names are case-insensitive.)

Example: To start or join a cluster, you can run:
    romance2 Caesar

REPL, HELP, or COPYRIGHTS are also options.")))))

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

  (format *standard-output* "~&~|
;
; ----------------------------------------------------------------------
;
; Romance Ⅱ Game System        ~40@A
;
; ~A
;
; ----------------------------------------------------------------------
/ENVIRONMENT
Server-Process ~A
Machine-Instance ~:(~A~)
Machine-Type ~A
Compiler ~A ~A
Software ~A ~A
\\ENVIRONMENT

/COPYRIGHTS
~A
\\COPYRIGHTS~%"
          long-name purpose short-name
          (machine-instance) (machine-type)
          (lisp-implementation-type) (lisp-implementation-version)
          (software-type) (software-version)
          (copyrights))

  (romanize-print *standard-output* long-name))

(defun command-line-help ()
  (princ "
Romance Ⅱ Game System — Brief Command-line Help

Romance Ⅱ (Romance2) is a  multi-player game server system. This program
is a  monolithic executable  that performs various  functions, depending
upon how it is called.

You may either create a symbolic link to this program (which is normally
done for you  during installation) with the given name,  or else call it
with the module name as the first parameter after the program name.

The full documentation  should be installed in your Info  system on your
host, with additional documentation extracted into your system manual.

To read Info pages, you can:

• In Emacs (choose Help→More Manuals→All Other Manuals from the menu, or
   type <M-x> info <Ret> — Meta+x, “info”, Return)

• Run a Terminal program like  “info” (uses Emacs-style navigation keys)
   or “pinfo” (uses Pine/Alpine/Pico/Nano-style navigation)

• Use the  Gnome Help program: launch  Help from within Gnome,  often by
  hitting Super+Help  or Super+F1  keys; then,  press Control+L  for the
  (hidden) Location  bar to  appear, and enter  “info:romance2” (without
  the quotation marks) into the location box;

    • or,  from  a   Terminal  or  Run  (usually   Alt+F2)  window,  run
      “gnome-help info:romance2” (with no quotation marks)

A printed copy of the manual is available at a reasonable price from the
developers; see  thi introduction  to the  manual for  details. Proceeds
from the sales  of printed manuals support the  continued development of
this software.

"))
