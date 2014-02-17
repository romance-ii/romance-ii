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

(defun strcat (&rest strings)
  (reduce (curry #'concatenate 'string) 
          (mapcar (lambda (element)
                    (typecase element
                      (cons (reduce #'strcat element))
                      (string element)
                      (t (princ-to-string element)))) 
                  (remove-if #'null strings))))

(define-constant +license-words+
    '(:license :licence :copying :copyright)
  :test 'equal)

(defun keywordify (word)
  (make-keyword (string-upcase (string word))))

(defun prerequisite-systems (&optional (child :romance-ii))
  (if-let ((prereqs (slot-value (asdf:find-system child)
                                'asdf::load-dependencies)))
    (remove-if 
     (lambda (sys)
       (member (keywordify sys)
               #+sbcl '(:sb-grovel :sb-posix :sb-rotate-byte
                        :sb-grovel :sb-bsd-sockets)))
     (remove-duplicates
      (append (remove-if #'null
                         (mapcan #'prerequisite-systems prereqs))
              prereqs)
      :test #'eql :key #'keywordify))))

(defun find-copyrights (&optional (long nil))
  (loop for system in (sort (prerequisite-systems :romance-ii)
                            #'string<
                            :key (compose #'string-upcase #'string))
     for asdf-dir = (make-pathname
                     :directory (pathname-directory
                                 (asdf:system-source-directory system))
                     :name :wild :type :wild)
     for license =
       (or
        (let ((override-file 
               (merge-pathnames
                (make-pathname :directory '(:relative "doc" "legal" "licenses")
                               :name (string-downcase (string system))
                               :type "txt") (translate-logical-pathname               
                                             (make-pathname :host "r2project")))))
          (when (fad:file-exists-p override-file)
            (list system override-file)))
        (unless long
          (if-let ((license (ignore-errors
                              (slot-value (asdf:find-system system) 'asdf::licence))))
            (list system license)))
        (loop
           for path in (directory asdf-dir)
           when (member (make-keyword (string-upcase 
                                       (pathname-name path))) +license-words+)
           return (list system (pathname path)))
        (loop
           for path in (directory (merge-pathnames "doc/" asdf-dir))
           when (member (make-keyword (string-upcase 
                                       (pathname-name path))) +license-words+)
           return (list system (pathname path)))
        (if long
          (if-let ((license (ignore-errors
                              (slot-value (asdf:find-system system) 'asdf::licence))))
            (list system license)))
        (loop
           for path in (directory asdf-dir)
           when (member (make-keyword (string-upcase
                                            (pathname-name path))) '(:readme))
           return (prog1 (list system (pathname path))
                    (warn "No LICENSE for ~:(~A~), using README~%(in ~A)" 
                          system asdf-dir))))
     when license collect license
     else collect (prog1 (list system nil)
                    (warn "No LICENSE for ~:(~A~)~%(in ~A)" system asdf-dir))))

(defun first-paragraph-of (file &optional (max-lines 10))
  (strcat
   (with-open-file (stream file :direction :input)
     (loop
        with seen = 0
        for line = (string-trim " #;/*" (read-line stream nil #\¶))
          
        for blank = (zerop (length line))
          
        until (or (and (> seen 1) blank)
                  (>= seen max-lines))
          
        unless blank do (incf seen)
          
          
        when (not blank)
        collect line
        and
        collect (when (= seen max-lines) (string #\…))
        and collect (string #\Newline)))))

(defun copyrights (&optional (long nil))
  "Return a string with applicable copyright notices."
  
  (strcat
   "Romance Game System
Copyright © 1987-2014, Bruce-Robert Pocock;

This program is free software: you may use, modify, and/or distribute it
 *ONLY* in accordance with the terms of the GNU Affero General Public License
 (GNU AGPL).

 *** Romance II contains libraries which have their own licenses. ***

"
   (unless long "(Abbreviated:)
")
   (loop for (package license) in (find-copyrights long)
      collect
        (if long
            (format nil "
————————————————————————————————————————————————————————————————————————
Romance II uses the library ~@:(~A~)~2%"
                    package)
            (format nil "~% • ~:(~A~): " package))
        
      collect
        (typecase license
          (pathname (if long
                        (alexandria:read-file-into-string license)
                        (first-paragraph-of license 2)))
          (string (if (or (< (length license) 75) long) 
                      license
                      (concatenate 'string (subseq license 0 75) "…")))
          (t (warn "Package ~A has no license?" package)
             "(see its documentation for license)")))
   (if long
       "~|
————————————————————————————————————————————————————————————————————————
    
Romance II itself is a program.

    Romance Game System Copyright © 1987-2014, Bruce-Robert Fenn
    Pocock;

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
       ;; short version
       "
See COPYING.AGPL3 or run “romance --copyright” for details.
")))

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
~|
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

/COPYRIGHTS~%~A~%\\COPYRIGHTS~%"
          long-name purpose short-name (machine-instance) (machine-type) (copyrights))

  (romanize-print *standard-output* long-name))


