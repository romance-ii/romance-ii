(in-package :romance)

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

(defun escape-c-style (char &optional _)
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



(defvar *language*)
(defvar *dialect*)
(defvar *language-coding*)

(defun get-lang ()
  (unless (and (boundp '*language*)
               (symbol-value '*language*))
    (setf *language* (keywordify
                      (first (split-sequence 
                              #\_ (sb-posix:getenv "LANG"))))))
  (unless (and (boundp '*dialect*)
               (symbol-value '*dialect*))
    (setf *dialect* (keywordify
                     (first (split-sequence 
                             #\. (second (split-sequence
                                          #\_ (sb-posix:getenv "LANG"))))))))
  (unless (and (boundp '*language-coding*)
               (symbol-value '*language-coding*))
    (setf *language-coding* (keywordify
                             (second (split-sequence 
                                      #\. (sb-posix:getenv "LANG")))))))

(defun letter-case (string)
  (cond ((equal string (string-upcase string))
         'string-upcase)
        ((equal string (string-downcase string))
         'string-downcase)
        ((equal string (string-capitalize string))
         'string-capitalize)
        (t 'identity)))

(define-condition language-not-implemented-warning (warning)
  ((language :initarg :language :reader language-not-implemented)
   (fn :initarg :function :reader language-not-implemented-function)))

(defmacro defun-lang (function (&rest lambda-list) &body bodies)
  (let ((underlying (intern (concatenate 'string (string function) "%"))))
    `(progn 
       (defgeneric ,underlying (language ,@lambda-list)
         ,@(mapcar (lambda (body)
                     (let ((match (car body))
                           (code (cdr body)))
                       `(:method ((language (eql ,match)) ,@lambda-list)
                          ,@code)))
                   bodies)
         (:method ((language t) ,@lambda-list)
           (warn 'language-not-implemented-warning :language language :function ',function)
           (,underlying :en ,@lambda-list)))
       (defun ,function (,@lambda-list)
         (,underlying (or (get-lang) :en) 
                      ,@lambda-list)))))

(defun-lang a/an (string)
  (:en (let ((letter (elt string 0)))
         (case letter
           ((#\a #\e #\i #\o #\u #\h)
            (concatenate 'string "an " string))
           ((#\A #\E #\I #\O #\U #\H)
            (concatenate 'string (funcall (letter-case string) "an ") string))
           (otherwise 
            (concatenate 'string (funcall (letter-case string) "a ") string))))))

(defun-lang plural (count string)
  (:en (if (= 1 count) 
           string
           (cond
             (t (funcall (letter-case string)
                         (concatenate 'string string "s"))))))
  (:fr (if (= 1 count) 
           string
           (cond
             (t (funcall (letter-case string)
                         (concatenate 'string string "s"))))))
  (:es (if (= 1 count) 
           string
           (cond
             (t (funcall (letter-case string)
                         (concatenate 'string string "s")))))))

(defun-lang counting (count string)
  (:en (cond
         ((zerop count) (a/an/some string))
         ((< 0 count 21) (funcall (letter-case string)
                                  (format nil "~R ~A" count
                                          (plural count string))))
         (t (format nil "~:D ~A" count (plural count string))))))

(defun-lang a/an/some (count string)
  (:en (case count
         (0 (concatenate 'string (funcall (letter-case string) "no ")
                         (plural 0 string)))
         (1 (a/an string))
         (otherwise (concatenate 'string (funcall (letter-case string) "some ")
                                 (plural count string)))))
  (:fr (case count
         (0 (concatenate 'string (funcall (letter-case string) "sans ")
                         (plural 0 string)))
         (1 (a/an string))
         (otherwise (concatenate 'string (funcall (letter-case string) "des ")
                                 (plural count string))))))



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



(defpackage roman/$trash)

(defun intern$ (string)
  (intern string :roman/$trash))

(defun string-case/literals% (compare clauses)
  (let ((instance (gensym "STRING-CASE")))
    `(let ((,instance (eval-once ,compare)))
       (cond
         ,@(mapcar (lambda (clause)
                     (if (or (eql t (car clause)) (eql 'otherwise (car clause)))
                         `(t ,@(cdr clause))
                         `((string= ,instance ,(car clause)) ,@(cdr clause))))
                   clauses)))))


(defun string-case/interning% (compare clauses)
  (let ((instance (gensym "STRING-INTERNED")))
    `(let ((,instance (intern$ (eval-once ,compare))))
       (case ,instance
         ,@(mapcar (lambda (clause)
                     (if (or (eql t (car clause)) (eql 'otherwise (car clause)))
                         `(t ,@(cdr clause))
                         `(,(intern$ (car clause)) ,@(cdr clause))))
                   clauses)))))


(let ((interning-better-breakpoint
       ;; Determine about how many cases there need to be, for interning to be
       ;; faster than STRING=
       (flet ((make-random-string (string-length)
                (format nil "~{~C~}"
                        (loop for char from 1 upto (1+ string-length)
                           collecting (code-char (+ 32 (random 95)))))))
         (format *trace-output* "~&;; timing STRING-CASE implementations …")
         (let ((trials
                (loop for trial-count from 1 to (* 5 (+ 5 (random 5)))
                   for num-repeats = (* 1000 (+ 2 (random 4)))
                   collecting
                     (loop for num-cases from 1 by (1+ (random 2))
                        for stuff = (loop for case from 1 upto num-cases
                                       for string = (make-random-string (+ 4 (random 28)))
                                       collect (list string :nobody))
                        for expr/literal = (compile 'expr/literal
                                                    (list 'lambda '(x)
                                                          (funcall #'string-case/literals%
                                                                   'x stuff)))
                        for expr/interning = (compile 'expr/interning
                                                      (list 'lambda '(x)
                                                            (funcall #'string-case/interning%
                                                                     'x stuff)))
                        for test-string = (make-random-string 40)
                        for cost/literal = (progn
                                             (trivial-garbage:gc)
                                             (let ((start (get-internal-real-time)))
                                               (dotimes (i num-repeats)
                                                 (funcall expr/literal test-string))
                                               (- (get-internal-real-time) start)))
                        for cost/interning = (progn
                                               (trivial-garbage:gc)
                                               (let ((start (get-internal-real-time)))
                                                 (dotimes (i num-repeats)
                                                   (funcall expr/interning test-string))
                                                 (- (get-internal-real-time) start)))
                          
                        ;; do (format *trace-output* "~&;; STRING-CASE Cost for ~D (~:D×): interning: ~F literals: ~F"
                        ;;            num-cases num-repeats cost/interning cost/literal)
                        when (< cost/interning cost/literal)
                        return num-cases))))
           (let ((average (round (/ (apply #'+ trials) (length trials)))))
             (format *trace-output* "~&;;; STRING-CASE trials done; sweet spot is about ~R case~:P after ~R trial~:P"
                     average (length trials))
             average)))))
  
  (defmacro string-case (compare &body clauses)
    "Like a CASE expression, but using STRING= to campare cases.

Example:

\(STRING-CASE FOO ((\"A\" (print :A)) (\"B\" (print :B)) (t (print :otherwise)) "
    (if (< interning-better-breakpoint (length clauses))
        (string-case/literals% compare clauses)
        (string-case/interning% compare clauses))))



(defun keywordify (word)
  (make-keyword
   (substitute #\- #\_ 
               (symbol-name (cffi:translate-camelcase-name word)))))


(defun join (joiner list-of-strings)
  (let ((joiner (etypecase joiner
                  (string joiner)
                  (character (princ-to-string joiner))
                  (symbol (symbol-name joiner))))) 
    (reduce (lambda (a b)
              (concatenate 'string a joiner b))
            list-of-strings)))

(defun repeat (what times)
  (loop for i from 1 upto times collecting what))



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



(defun error-or-nil-p (x)
  (or (null x)
      (eql :error x)))
(deftype error-or-nil () 
  '(satisfies error-or-nil-p))

(defun parse-bignum (string &key (if-not-bignum nil))
  (check-type if-not-bignum error-or-nil)
  (let ((string (string-trim '(#\Space #\Tab) string)))
    (cond 
      ((zerop (length string)) nil)
      
      ((and (= 1 (count #\. string))
            (every (lambda (ch)
                     (or (digit-char-p ch)
                         (eql #\. ch))) string))
       (let* ((decimal (position #\. string))
              (whole (parse-integer (subseq string 0 decimal)))
              (fraction$ (subseq string (1+ decimal))))
         (+ whole (/ (parse-integer fraction$) (expt 10 (length fraction$))))))
      
      ((every #'digit-char-p string)
       (parse-integer string))
      
      (t nil))))

(defun maybe-numeric (string)
  (if-let (numeric (parse-bignum string))
    numeric
    (let ((pos (- (length string) 3)))
      (if (and (plusp pos) 
               (equal " kB" (subseq string pos)))
          (* 1024 (parse-integer (subseq string 0 pos)))
          string))))


;;; String←file functions

(defun split-and-collect-line (line &optional (split-char #\Space)
                                      (filter #'string-upcase))
  (let ((split (position split-char line))) 
    (when split
      (let ((key-part (subseq line 0 split)))
        (list (if (every #'digit-char-p key-part)
                  (parse-integer key-part)
                  (make-keyword 
                   (funcall filter
                            (string-trim 
                             '(#\Space #\Tab)
                             (substitute #\- #\_
                                         (substitute #\- #\( 
                                                     (substitute #\Space #\)
                                                                 key-part)))))))
              (let* ((rest-of-line (subseq line (1+ split)))
                     (numeric (parse-bignum rest-of-line)))
                (if numeric 
                    numeric
                    rest-of-line)))))))

(defun split-and-collect-file (file &optional (split-char #\Space)
                                      (filter #'string-upcase))
  (handler-bind
      ((simple-file-error (lambda (c)
                            (return-from split-and-collect-file c))))
    (with-open-file (reading file :direction :input)
      (loop for line = (read-line reading nil nil)
         while line
         when line
         append (split-and-collect-line line split-char filter)))))

(defun collect-file-lines (file &optional (record-end-char #\Newline))
  (let (lines 
        (line (make-array 72 :element-type 'character :adjustable t :fill-pointer 0)))
    (with-open-file (reading file :direction :input)
      (loop for char = (read-char reading nil nil)
         while char
         do (if (char= record-end-char char)
                (progn (push (copy-seq line) lines)
                       (setf (fill-pointer line) 0))
                (vector-push-extend char line 16)))
      (when (plusp (length line)) 
        (push lines line)))
    (nreverse lines)))


(defun collect-file (file)
  (handler-bind
      ((simple-file-error (lambda (c) 
                            (return-from collect-file c))))
    (let ((contents (string-trim '(#\Space #\Tab #\Linefeed #\Return)
                                 (alexandria:read-file-into-string file))))
      (maybe-numeric contents))))

(defun collect-file-tabular (file &optional (tab-char #\Tab) (record-char #\Newline))
  (let ((contents (alexandria:read-file-into-string file)))
    (mapcar (lambda (row)
              (mapcar #'maybe-numeric row))
            (mapcar (curry #'split-sequence tab-char)
                    (split-sequence record-char
                                    contents)))))

(defun maybe-alist-row (string &optional (= #\=))
  (cond ((and (every #'alpha-char-p string)
              (equal (string-downcase string) string))
         (make-keyword (string-upcase string)))
        
        ((find = string)
         (let ((=pos (position = string))) 
           (cons (make-keyword (string-upcase (subseq string 0 =pos)))
                 (maybe-numeric (subseq string (1+ =pos))))))
        
        (t string)))

(defun maybe-alist-split (string &optional (= #\=) (record-char #\,))
  (mapcar (rcurry #'maybe-alist-row =)
          (split-sequence record-char string)))




