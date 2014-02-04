(defpackage :romance
  (:use :cl :alexandria)
  (:nicknames :romans :romance-ii :romance2)
  (:documentation
   "Common code used by other modules in Romance II")
  (:export #:copyrights #:start-server #:start-repl #:server-start-banner))

(defpackage :romance-user
  (:use :cl :alexandria :romans))

(in-package :romance)

(defvar *repl-ident* nil)

(defun find-copyrights ()
  (loop for system
     in (append (slot-value (asdf:find-system :romance-ii)
                            'asdf::load-dependencies))
     for license =
       (loop for path
          in (directory
              (make-pathname
               :directory (pathname-directory
                           (asdf:system-source-directory system))
               :name :wild :type :wild))
          when (member (make-keyword (pathname-name path)) '(:license :copying))
          return (list system path)
          else when (member (make-keyword (pathname-name path)) '(:readme))
          return (list system path))
     when license collect license
     else collect (list system nil)))

(defun first-paragraph-of (file)
  (apply #'concatenate 'string
   (with-open-file (stream file :direction :input)
     (loop
        with seen = nil
        for line = (read-line stream)
          
        until (and seen (zerop (length line)))
          
        unless seen
        do (setf seen (plusp (length line)))
          
        when seen
        collect line
        and
        collect (string #\Newline)))))

(defun copyrights (&optional (long nil))
  "Return a string with applicable copyright notices."
  
  (apply 
   #'concatenate 
   'string
   (remove-if 
    #'null
    (list
     "Romance Game System
Copyright © 1987-2014, Bruce-Robert Pocock;

This program is free software: you may use, modify, and/or distribute it
 *ONLY* in accordance with the terms of the GNU Affero General Public License
 (GNU AGPL).

 *** Romance II contains libraries which have their own licenses. ***

"
     
     
     (apply #'concatenate 
            'string
            (loop for (package file) in (find-copyrights)
               when file
               collect (if long
                           (format nil "
————————————————————————————————————————————————————————————————————————
Romance II contains ~:(~A~)~2%~A~2%"
                                   package (alexandria:read-file-into-string file))
                           (format nil " • ~:(~A~); ~A"
                                   package (first-paragraph-of file)))
               else
               collect (format nil " • ~:(~A~) (see documentation for license)~2%" package)
               and do (warn "Package ~A has no license?" package)))
     (if long
         "
————————————————————————————————————————————————————————————————————————
    
Romance II itself is a program.

    This  program is  free software:  you can  redistribute it  and/or
    modify it under the terms of the GNU Affero General Public License
    as published by the Free  Software Foundation, either version 3 of
    the License, or (at your option) any later version.

    This program  is distributed in the  hope that it will  be useful,
    but WITHOUT  ANY WARRANTY;  without even  the implied  warranty of
    MERCHANTABILITY or FITNESS FOR A  PARTICULAR PURPOSE.  See the GNU
    Affero General Public License for more details.

    You should have  received a copy of the GNU  Affero General Public
    License    along    with    this    program.     If    not,    see
    < http://www.gnu.org/licenses/ >."
         
         "See COPYING.AGPL3 or run “romance --copyright” for details.
")))))

(defun start-server (&optional argv)
  (case (make-keyword (string-upcase (car argv)))
    (:caesar (warn "TODO Caesar"))
    (:copyrights (format t (copyrights t)))
    (otherwise
     (format t "Romance II: Generic Executable.  

Provide the name of the module to start; Caesar will launch
other modules.

REPL, HELP, or COPYRIGHTS are also options."))))

(defun repl-help (&optional (section :intro))
  (when (eql section :repl)
    (prepl::help-cmd) (return-from repl-help nil))
  (format
   t 
   (case section
     (:comm "
Romance II: Operations Communications

Use these functions in package CAESAR for messaging. (e.g. to invoke
WHO you might type (CAESAR:WHO) or (IN-PACKAGE :CAESAR) (WHO) ...)

WHO: Who is online throughout the sysplex? (WHO :CLASS :OPER) by
default; (WHO :CLASS :AGENT) (WHO :CLASS :USER) (WHO :CLASS :ALL) for
various types of connection.

")
     (:intro "

             Romance II Read-Eval-Print-Loop (REPL) Help 

Caution: Joining a live game world with this REPL is godlike power. Be
very careful.

 • For help with using the REPL, type :HELP or (HELP :REPL)

 • For copyright information, type (COPYRIGHTS) for brief, (COPYRIGHTS
   T) for full details.

 • If  you  enter  the  debugger,  choose  a  restart  with  :CONTINUE
   (restart)  from the  list  presented. (The  debugger  prompt has  a
   preceding number, usually [1], before your package prompt.) You can
   also use :ABORT  to kill the program you had  started and return to
   the REPL.

 • Use (HELP :COMM) to learn  about communicating with other operators
   through the REPL.

 • Use (HELP :SYSOP) to learn about systems administration tasks.
")
     (otherwise
      "
Sorry: No  help topic with that  ID exists. Try (ROMANS:HELP)  with no
topic  for a  brief overview;  (HELP  :COMM), (HELP  :REPL), or  (HELP
:SYSOP) for other entry points.

")) ))

(defun start-repl (&optional argv)
  (unless (member "--silent" argv)
   (format t "~&Romance II: Copyright © 2013-2014, Bruce-Robert Pocock.
Evaluate (ROMANCE:COPYRIGHTS T) for details.
Read-Eval-Print-Loop interactive session.
For help, evaluate (ROMANCE:REPL-HELP)~2%"))
  (unless *repl-ident*
    (format t "~&You haven't identified yourself. Say Hello!
... enter (HELLO \"your name here\") to identify yourself.")
    (setf *repl-ident* (format nil "REPL user ~A" (gensym "REPL"))))
  (in-package :romance-user)
  (prepl:repl :nobanner t :inspect t :continuable t))

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
;
; ----------------------------------------------------------------------
;
; Romance II Game System        ~40@A
;
; ~A
;
; ----------------------------------------------------------------------
SERVER-PROCESS =    ~A
MACHINE-INSTANCE =  ~:(~A~)
MACHINE-TYPE =      ~A

/COPYRIGHTS~%~A~%\\COPYRIGHTS~%~|"
          long-name purpose short-name (machine-instance) (machine-type) (copyrights))

  (romanize-print *standard-output* long-name))


