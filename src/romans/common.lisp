(defpackage :romance
  (:use :cl :alexandria)
  (:nicknames :romans :romance-ii :romance2)
  (:documentation
   "Common code used by other modules in Romance Ⅱ")
  (:export
   #:+inline-whitespace+
   #:+often-naughty-chars+
   #:+whitespace+
   #:any
   #:copyrights
   #:doseq
   #:escape-by-doubling
   #:escape-c-style
   #:escape-lispy
   #:escape-url-encoded
   #:escape-with-char
   #:keywordify
   #:server-start-banner
   #:start-repl
   #:start-server
   #:strcat
   #:string-case
   #:string-escape
   #:string-escape
   #:string-fixed
   #:until
   #:while
   
   ))

(require :prepl)
(require :babel)

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

(define-constant +whitespace+
    (coerce #(;; Defined in ASCII
              #\Space #\Tab #\Page #\Linefeed #\Return #\Null
              ;; defined in ISO-8859-*
              #\No-Break_Space #\Reverse-Linefeed
              ;; defined in Unicode
              #\Ogham_space_mark #\Mongolian_Vowel_Separator
              #\En_quad #\Em_quad #\En_Space #\Em_Space
              #\Three-per-Em_Space #\Four-per-Em_Space
              #\Six-per-Em_Space #\Figure_Space #\Punctuation_Space
              #\Thin_Space #\Hair_Space 
              #\Zero_Width_Space #\Narrow_No-Break_Space
              #\Medium_Mathematical_Space #\Ideographic_Space
              #\Zero_Width_No-Break_Space)
            'simple-string)
  :test #'equal
  :documentation "A list of all whitespace chars in Unicode. Superset of
  the ASCII whitespace chars we expect to encounter.")

(define-constant +inline-whitespace+
    (coerce #(;; Defined in ASCII
              #\Space #\Tab
              ;; defined in ISO-8859-*
              #\No-Break_Space
              ;; defined in Unicode
              #\Ogham_space_mark #\Mongolian_Vowel_Separator
              #\En_quad #\Em_quad #\En_Space #\Em_Space
              #\Three-per-Em_Space #\Four-per-Em_Space
              #\Six-per-Em_Space #\Figure_Space #\Punctuation_Space
              #\Thin_Space #\Hair_Space 
              #\Zero_Width_Space #\Narrow_No-Break_Space
              #\Medium_Mathematical_Space #\Ideographic_Space
              #\Zero_Width_No-Break_Space)
            'simple-string)
  :test #'equal
  :documentation "A list of all whitespace chars in Unicode that occur
  \"on a line,\" i.e. excluding Null, Carriage Return, Linefeed, and
  Page Break. Superset of the ASCII whitespace chars we expect
  to encounter.")

(define-constant +often-naughty-chars+
    (coerce #(#\\ #\! #\| #\# #\$ #\% #\& #\?
              #\{ #\[ #\( #\) #\] #\} #\= #\^ #\~
              #\' #\" #\` #\< #\> #\*
              #\Space #\Tab #\Page #\Linefeed #\Return #\Null
              #\No-Break_Space #\Reverse-Linefeed
              #\Zero_Width_No-Break_Space)
            'simple-string)
  :test #'equal
  :documentation "A list of characters which often have special
meanings (e.g. in the shell) and should usually be replaced or escaped
in some contexts.")

(defmacro doseq ((element sequence) &body body)
  `(loop for ,element across ,sequence do (progn ,@body)))

(defun escape-with-char (char escape-char)
  (check-type char character)
  (check-type escape-char character)
  (coerce (list escape-char char) 'string))

(defun escape-by-doubling (char &optional _)
  (declare (ignore _))
  (check-type char character)
  (coerce (list char char) 'string))

(defun escape-url-encoded (char &optional _)
  (declare (ignore _))
  (check-type char character)
  (format nil "~{%~2,'0x~}" (coerce
                             (babel:string-to-octets (string char))
                             'list)))
(defun escape-octal (char &optional _)
  (declare (ignore _))
  (check-type char character)
  (format nil "~{\\0~o~}" (coerce
                           (babel:string-to-octets (string char))
                           'list)))
(defun escape-java (char &optional _)
  (declare (ignore _))
  (check-type char character)
  (assert (< (char-code char) #x10000) (char)
          "Cannot Java-encode characters whose Unicode codepoint is
          above #xFFFF. Character ~@C (~:*~:C) has a codepoint of #x~x."
          char (char-code char))
  (format nil "\\u~4,'0x" (char-code char)))

(defun escape-html (char &optional _)
  (declare (ignore _))
  (check-type char character)
  (format nil "&~d;" (char-code char)))

(defun string-escape (string &optional
                               (escape-chars +often-naughty-chars+)
                               (escape-with #\\)
                               (escape-function #'escape-with-char))
  "Escape a string in some of the more popular forms.

The STRING is compared, character-by-character, against ESCAPE-CHARS. When a
character in STRING is a member of ESCAPE-CHARS, it is passed through ESCAPE-FUNCTION with the additional parameter ESCAPE-WITH.

When ESCAPE-CHARS is NIL, every character in STRING is escaped.

When ESCAPE-CHARS is a vector of two non-negative integers, then every
character is escaped whose codepoint does NOT fall between the inclusive
range of those two characters, UNLESS that character is also CHAR= to
ESCAPE-WITH.

When ESCAPE-CHARS is a string, then only the characters in that string
are escaped. The default is a set of typically-troublesome characters in
the ASCII range, including whitespace.

For example, to octal-escape all characters outside the range of printable ASCII characters, you might use:

\(string-escape string #(#x20 #x7e) #\\ #'escape-octal)
"
  (check-type string string)
  (check-type escape-chars (or null (vector (integer 0 *) 2) string))
  ;; (check-type escape-function (function (character t) string))
  (let ((output (make-array (length string) :adjustable t
                            :fill-pointer 0 :element-type 'character)))
    (flet ((encode-char (char)
             (doseq (out-char (the string (funcall escape-function char
                                                   escape-with)))
               (vector-push-extend out-char output))))
      (etypecase escape-chars
        (null (concatenate 'string
                           (mapcar (rcurry escape-function
                                           escape-with) string)))
        (string (loop for char across string
                   do (cond
                        ((find char escape-chars :test #'char=)
                         (encode-char char))
                        (t 
                         (vector-push-extend char output)))))
        (vector (let ((range-start (code-char (elt escape-chars 0)))
                      (range-end (code-char (elt escape-chars 1))))
                  
                  (loop for char across string
                     do (cond
                          ((or (not (char< range-start 
                                           char
                                           range-end))
                               (char= escape-with char))
                           (encode-char char))
                          (t 
                           (vector-push-extend char output))))))))
    output))

(assert (equal (string-escape "C:/WIN" "/" #\*) "C:*/WIN"))
(assert (equal (string-escape "BLAH 'BLAH' BLAH" "'" nil
                              #'escape-by-doubling)
               "BLAH ''BLAH'' BLAH"))
(assert (equal (string-escape "Foo&Bar" "&" nil
                              #'escape-url-encoded)
               "Foo%26Bar"))
(assert (equal (string-escape "☠" #(#x20 #x7e) nil
                              #'escape-url-encoded)
               "%E2%98%A0"))
(assert (equal (string-escape "boo$" "$" nil
                              #'escape-octal)
               "boo\\044"))
(assert (equal (string-escape "Blah <p>" "<&>" nil
                              #'escape-html)
               "Blah &60;p&62;"))


(defun string-fixed (string target-length &key (trim-p t) 
                                            (pad-char #\Space))
  "Ensure that the string is precisely the length provided, right-padding with PAD-CHAR (Space).
If the string is too long, it will be truncated. Returns multiple
values: the trimmed string, and the difference in length of the new
string. If the second value is negative, the string was truncated."
  (check-type string string)
  (check-type target-length (integer 1 *))
  (check-type pad-char character)
  (let* ((trimmed (if trim-p
                      (string-trim +whitespace+ string)
                      string)) 
         (change-length (- target-length (length trimmed))))
    (values (cond
              ((plusp change-length)
               (concatenate 'string trimmed 
                            (make-string change-length
                                         :initial-element pad-char)))
              ((minusp change-length)
               (subseq trimmed 0 target-length))
              (t 
               trimmed))
            change-length)))

(assert (equal (string-fixed "Q" 5) "Q    "))
(assert (equal (string-fixed "  Q  " 5) "Q    "))
(assert (equal (string-fixed "  Q  " 5 :trim-p nil) "  Q  "))
(assert (equal (string-fixed "QJJJJJ" 5 ) "QJJJJ"))
(multiple-value-bind (string change)
    (string-fixed "Q" 5)
  (assert (= 4 change))
  (assert (equal "Q    " string)))
(multiple-value-bind (string change)
    (string-fixed "QJJJJJ" 5)
  (assert (= -1 change))
  (assert (equal "QJJJJ" string)))
(multiple-value-bind (string change)
    (string-fixed "QQQQQ" 5)
  (assert (= 0 change))
  (assert (equal "QQQQQ" string)))


(defmacro until (test &body body)
  `(do () (,test) ,@body))

(defmacro while (test &body body)
  `(do () ((not ,test)) ,@body))

(defmacro string-case (compare &body clauses)
  "Like a CASE expression, but using STRING= to campare cases. NOT
optimized for long lists. TODO — this macro should be smart enough to
use a hash table when the number of cases becomes large.

Example:

\(STRING-CASE FOO ((\"A\" (print :A)) (\"B\" (print :B)) (t (print :otherwise)) "
  `(cond
     ,@(mapcar (lambda (clause)
                 (if (or (eql t (car clause)) (eql 'otherwise (car clause)))
                     `(t ,@(cdr clause))
                     `((string= ,compare ,(car clause)) ,@(cdr clause))))
               clauses)))

(define-constant +license-words+
    '(:license :licence :copying :copyright)
  :test 'equal)

(defun keywordify (word)
  (make-keyword (string-upcase (string word))))

(defun any (predicate set)
  (loop for item in set
     when (funcall predicate item) return it))

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
  (append
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
                     (warn "No LICENSE for ~:(~A~)~%(in ~A)" system asdf-dir)))
   (if long
       (list :bullet2 (merge-pathnames
                       (make-pathname :directory '(:relative "doc" "legal" "licenses")
                                      :name "bullet2"
                                      :type "txt") 
                       (translate-logical-pathname               
                        (make-pathname :host "r2project"))))
       (list :bullet2 "MIT"))))

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

   ★ Romance Ⅱ contains libraries which have their own licenses. ★

"
   (unless long "(Abbreviated:)
")
   (loop for (package license) in (find-copyrights long)
      collect
        (if long
            (format nil "
————————————————————————————————————————————————————————————————————————
Romance Ⅱ uses the library ~@:(~A~)~2%"
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
    
Romance Ⅱ itself is a program.

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
     (format t "Romance Ⅱ: Generic Executable.  

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
Romance Ⅱ: Operations Communications

Use these functions in package CAESAR for messaging. (e.g. to invoke
WHO you might type (CAESAR:WHO) or (IN-PACKAGE :CAESAR) (WHO) ...)

WHO: Who is online throughout the sysplex? (WHO :CLASS :OPER) by
default; (WHO :CLASS :AGENT) (WHO :CLASS :USER) (WHO :CLASS :ALL) for
various types of connection.

")
     (:intro "

             Romance Ⅱ Read-Eval-Print-Loop (REPL) Help 

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
   (format t "~&Romance Ⅱ: Copyright © 2013-2014, Bruce-Robert Pocock.
Evaluate (ROMANCE:COPYRIGHTS T) for details.
Read-Eval-Print-Loop interactive session.
For help, evaluate (ROMANCE:REPL-HELP)~2%"))
  (unless *repl-ident*
    (format t "~&You haven't identified yourself. Say Hello!
... enter (HELLO \"your name here\") to identify yourself.")
    (setf *repl-ident* (format nil "REPL user ~A" (gensym "REPL"))))
  (let ((*package* (find-package :romance-user)))
    (prepl:repl :nobanner t :inspect t :continuable t)))

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
SERVER-PROCESS =    ~A
MACHINE-INSTANCE =  ~:(~A~)
MACHINE-TYPE =      ~A

/COPYRIGHTS~%~A~%\\COPYRIGHTS~%"
          long-name purpose short-name (machine-instance) (machine-type) (copyrights))

  (romanize-print *standard-output* long-name))


