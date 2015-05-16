(in-package :cl-user)
(require :alexandria)
(require :bordeaux-threads)
(require :split-sequence)
(require :cl-fad)
(require :local-time)
(require :parse-number)
(require 'trivial-gray-streams)

(defpackage :romance
  (:use :cl :alexandria 
        :bordeaux-threads :local-time :split-sequence :cl-fad :parse-number
        :trivial-gray-streams)
  (:nicknames :romans :romance-ii :romance2)
  (:shadowing-import-from :cl-fad :copy-file :copy-stream) ; conflicts with Alexandria.
  (:documentation
   "Common code used by other modules in Romance Ⅱ.")
  (:export
   ;; Locally-defined symbols
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
   #:string-ends-with
   #:string-escape
   #:string-fixed
   #:strings-list
   #:strings-list-p
   #:until
   #:while
   #:without-warnings
   
   ;;; Symbols from other libraries
   ;; There is a very lengthy set of library functions that we want to
   ;; use without package prefixes in all of our other packages. As
   ;; such, they're exported here from their original packages. In other
   ;; packages, (:USE :CL :ROMANS) is the normal DEFPACKAGE form; MOST
   ;; other packages should NOT be “used” in the DEFPACKAGE form, with
   ;; some exceptions on a subsystem basis.
   alexandria:alist-hash-table 
   alexandria:alist-plist
   alexandria:appendf 
   alexandria:array-index
   alexandria:array-length 
   alexandria:assoc-value
   alexandria:binomial-coefficient 
   alexandria:circular-list
   alexandria:circular-list-p 
   alexandria:circular-tree-p
   alexandria:clamp 
   alexandria:coercef
   alexandria:compose 
   alexandria:conjoin
   alexandria:copy-array 
   ;; NOT: alexandria:copy-file (using CL-FAD:COPY-FILE)
   alexandria:copy-hash-table 
   alexandria:copy-sequence
   ;; NOT: alexandria:copy-stream (using CL-FAD:COPY-STREAM)
   alexandria:count-permutations
   alexandria:cswitch 
   alexandria:curry
   alexandria:define-constant 
   alexandria:delete-from-plist
   alexandria:delete-from-plistf 
   alexandria:deletef
   alexandria:destructuring-case 
   alexandria:destructuring-ccase
   alexandria:destructuring-ecase 
   alexandria:disjoin
   alexandria:doplist 
   alexandria:emptyp
   alexandria:ends-with 
   alexandria:ends-with-subseq
   alexandria:ensure-car 
   alexandria:ensure-cons
   alexandria:ensure-function 
   alexandria:ensure-functionf
   alexandria:ensure-gethash 
   alexandria:ensure-list
   alexandria:ensure-symbol 
   alexandria:eswitch
   alexandria:extremum 
   alexandria:factorial
   alexandria:featurep 
   alexandria:first-elt
   alexandria:flatten 
   alexandria:format-symbol
   alexandria:gaussian-random 
   alexandria:hash-table-alist
   alexandria:hash-table-keys 
   alexandria:hash-table-plist
   alexandria:hash-table-values 
   alexandria:if-let
   alexandria:ignore-some-conditions 
   alexandria:iota
   alexandria:last-elt 
   alexandria:lastcar
   alexandria:length= 
   alexandria:lerp
   alexandria:make-circular-list 
   alexandria:make-gensym
   alexandria:make-gensym-list 
   alexandria:make-keyword
   alexandria:map-combinations 
   alexandria:map-derangements
   alexandria:map-iota 
   alexandria:map-permutations
   alexandria:map-product 
   alexandria:maphash-keys
   alexandria:maphash-values 
   alexandria:mappend
   alexandria:maxf 
   alexandria:mean
   alexandria:median 
   alexandria:minf
   alexandria:multiple-value-compose 
   alexandria:multiple-value-prog2
   alexandria:named-lambda 
   alexandria:nconcf
   alexandria:negative-double-float 
   alexandria:negative-double-float-p
   alexandria:negative-fixnum 
   alexandria:negative-fixnum-p
   alexandria:negative-float 
   alexandria:negative-float-p
   alexandria:negative-integer 
   alexandria:negative-integer-p
   alexandria:negative-long-float 
   alexandria:negative-long-float-p
   alexandria:negative-rational 
   alexandria:negative-rational-p
   alexandria:negative-real 
   alexandria:negative-real-p
   alexandria:negative-short-float 
   alexandria:negative-short-float-p
   alexandria:negative-single-float 
   alexandria:negative-single-float-p
   alexandria:non-negative-double-float 
   alexandria:non-negative-double-float-p
   alexandria:non-negative-fixnum 
   alexandria:non-negative-fixnum-p
   alexandria:non-negative-float 
   alexandria:non-negative-float-p
   alexandria:non-negative-integer 
   alexandria:non-negative-integer-p
   alexandria:non-negative-long-float 
   alexandria:non-negative-long-float-p
   alexandria:non-negative-rational 
   alexandria:non-negative-rational-p
   alexandria:non-negative-real 
   alexandria:non-negative-real-p
   alexandria:non-negative-short-float 
   alexandria:non-negative-short-float-p
   alexandria:non-negative-single-float 
   alexandria:non-negative-single-float-p
   alexandria:non-positive-double-float 
   alexandria:non-positive-double-float-p
   alexandria:non-positive-fixnum 
   alexandria:non-positive-fixnum-p
   alexandria:non-positive-float 
   alexandria:non-positive-float-p
   alexandria:non-positive-integer 
   alexandria:non-positive-integer-p
   alexandria:non-positive-long-float 
   alexandria:non-positive-long-float-p
   alexandria:non-positive-rational 
   alexandria:non-positive-rational-p
   alexandria:non-positive-real 
   alexandria:non-positive-real-p
   alexandria:non-positive-short-float 
   alexandria:non-positive-short-float-p
   alexandria:non-positive-single-float 
   alexandria:non-positive-single-float-p
   alexandria:nreversef 
   alexandria:nth-value-or
   alexandria:nunionf 
   alexandria:of-type
   alexandria:once-only 
   alexandria:ordinary-lambda-list-keywords
   alexandria:parse-body 
   alexandria:parse-ordinary-lambda-list
   alexandria:plist-alist 
   alexandria:plist-hash-table
   alexandria:positive-double-float 
   alexandria:positive-double-float-p
   alexandria:positive-fixnum 
   alexandria:positive-fixnum-p
   alexandria:positive-float 
   alexandria:positive-float-p
   alexandria:positive-integer 
   alexandria:positive-integer-p
   alexandria:positive-long-float 
   alexandria:positive-long-float-p
   alexandria:positive-rational 
   alexandria:positive-rational-p
   alexandria:positive-real 
   alexandria:positive-real-p
   alexandria:positive-short-float 
   alexandria:positive-short-float-p
   alexandria:positive-single-float 
   alexandria:positive-single-float-p
   alexandria:proper-list 
   alexandria:proper-list-length
   alexandria:proper-list-p 
   alexandria:proper-sequence
   alexandria:random-elt 
   alexandria:rassoc-value
   alexandria:rcurry 
   alexandria:read-file-into-byte-vector
   alexandria:read-file-into-string 
   alexandria:remove-from-plist
   alexandria:remove-from-plistf 
   alexandria:removef
   alexandria:required-argument 
   alexandria:reversef
   alexandria:rotate 
   alexandria:sequence-of-length-p
   alexandria:set-equal 
   alexandria:setp
   alexandria:shuffle 
   alexandria:simple-parse-error
   alexandria:simple-program-error 
   alexandria:simple-reader-error
   alexandria:simple-style-warning 
   alexandria:standard-deviation
   alexandria:starts-with 
   alexandria:starts-with-subseq
   alexandria:string-designator 
   alexandria:subfactorial
   alexandria:switch 
   alexandria:symbolicate
   alexandria:type= 
   alexandria:unionf
   alexandria:unwind-protect-case 
   alexandria:variance
   alexandria:when-let 
   alexandria:when-let*
   alexandria:whichever 
   alexandria:with-gensyms
   alexandria:with-input-from-file 
   alexandria:with-output-to-file
   alexandria:with-unique-names 
   alexandria:write-byte-vector-into-file
   alexandria:write-string-into-file 
   alexandria:xor
   bordeaux-threads:*default-special-bindings*
   bordeaux-threads:*standard-io-bindings* 
   bordeaux-threads:*supports-threads-p*
   bordeaux-threads:acquire-lock 
   bordeaux-threads:acquire-recursive-lock
   bordeaux-threads:all-threads 
   bordeaux-threads:condition-notify
   bordeaux-threads:condition-wait 
   bordeaux-threads:current-thread
   bordeaux-threads:destroy-thread 
   bordeaux-threads:interrupt-thread
   bordeaux-threads:join-thread 
   bordeaux-threads:make-condition-variable
   bordeaux-threads:make-lock 
   bordeaux-threads:make-recursive-lock
   bordeaux-threads:make-thread 
   bordeaux-threads:release-lock
   bordeaux-threads:release-recursive-lock 
   bordeaux-threads:start-multiprocessing
   bordeaux-threads:thread 
   bordeaux-threads:thread-alive-p
   bordeaux-threads:thread-name 
   bordeaux-threads:thread-yield
   bordeaux-threads:threadp 
   bordeaux-threads:timeout
   bordeaux-threads:with-lock-held
   bordeaux-threads:with-recursive-lock-held
   bordeaux-threads:with-timeout
   cl-fad:*default-template* 
   cl-fad:cannot-create-temporary-file
   cl-fad:canonical-pathname 
   cl-fad:copy-file
   cl-fad:copy-stream 
   cl-fad:delete-directory-and-files
   cl-fad:directory-exists-p 
   cl-fad:directory-pathname-p
   cl-fad:file-exists-p
   cl-fad:invalid-temporary-pathname-template
   cl-fad:list-directory 
   cl-fad:merge-pathnames-as-directory
   cl-fad:merge-pathnames-as-file 
   cl-fad:open-temporary
   cl-fad:pathname-absolute-p 
   cl-fad:pathname-as-directory
   cl-fad:pathname-as-file 
   cl-fad:pathname-directory-pathname
   cl-fad:pathname-equal 
   cl-fad:pathname-parent-directory
   cl-fad:pathname-relative-p 
   cl-fad:pathname-root-p
   cl-fad:walk-directory 
   cl-fad:with-open-temporary-file
   cl-fad:with-output-to-temporary-file
   local-time:*clock* 
   local-time:*default-timezone*
   local-time:+asctime-format+ 
   local-time:+day-names+
   local-time:+days-per-week+ 
   local-time:+gmt-zone+
   local-time:+hours-per-day+ 
   local-time:+iso-8601-date-format+
   local-time:+iso-8601-format+ 
   local-time:+iso-8601-time-format+
   local-time:+iso-week-date-format+ 
   local-time:+minutes-per-day+
   local-time:+minutes-per-hour+ 
   local-time:+month-names+
   local-time:+months-per-year+ 
   local-time:+rfc-1123-format+
   local-time:+rfc3339-format+ 
   local-time:+rfc3339-format/date-only+
   local-time:+seconds-per-day+ 
   local-time:+seconds-per-hour+
   local-time:+seconds-per-minute+ 
   local-time:+short-day-names+
   local-time:+short-month-names+ 
   local-time:+utc-zone+
   local-time:adjust-timestamp 
   local-time:adjust-timestamp!
   local-time:astronomical-julian-date
   local-time:astronomical-modified-julian-date
   local-time:clock-now 
   local-time:clock-today
   local-time:date 
   local-time:day-of
   local-time:days-in-month 
   local-time:decode-timestamp
   local-time:define-timezone 
   local-time:enable-read-macros
   local-time:encode-timestamp
   local-time:find-timezone-by-location-name
   local-time:format-rfc1123-timestring 
   local-time:format-rfc3339-timestring
   local-time:format-timestring 
   local-time:make-timestamp
   local-time:modified-julian-date 
   local-time:now
   local-time:nsec-of 
   local-time:parse-rfc3339-timestring
   local-time:parse-timestring 
   local-time:reread-timezone-repository
   local-time:sec-of 
   local-time:time-of-day
   local-time:timestamp 
   local-time:timestamp+
   local-time:timestamp- 
   local-time:timestamp-century
   local-time:timestamp-day 
   local-time:timestamp-day-of-week
   local-time:timestamp-decade 
   local-time:timestamp-difference
   local-time:timestamp-hour 
   local-time:timestamp-maximize-part
   local-time:timestamp-maximum 
   local-time:timestamp-microsecond
   local-time:timestamp-millennium 
   local-time:timestamp-millisecond
   local-time:timestamp-minimize-part 
   local-time:timestamp-minimum
   local-time:timestamp-minute 
   local-time:timestamp-month
   local-time:timestamp-second 
   local-time:timestamp-subtimezone
   local-time:timestamp-to-universal 
   local-time:timestamp-to-unix
   local-time:timestamp-week
   local-time:timestamp-whole-year-difference
   local-time:timestamp-year 
   local-time:timestamp/=
   local-time:timestamp< 
   local-time:timestamp<=
   local-time:timestamp= 
   local-time:timestamp>
   local-time:timestamp>= 
   local-time:to-rfc1123-timestring
   local-time:to-rfc3339-timestring 
   local-time:today
   local-time:universal-to-timestamp 
   local-time:unix-to-timestamp
   local-time:with-decoded-timestamp
   parse-number:parse-number
   split-sequence:partition 	
   split-sequence:partition-if
   split-sequence:partition-if-not
   split-sequence:split-sequence
   split-sequence:split-sequence-if
   split-sequence:split-sequence-if-not
   trivial-gray-streams:fundamental-binary-input-stream
   trivial-gray-streams:fundamental-binary-output-stream
   trivial-gray-streams:fundamental-binary-stream
   trivial-gray-streams:fundamental-character-input-stream
   trivial-gray-streams:fundamental-character-output-stream
   trivial-gray-streams:fundamental-character-stream
   trivial-gray-streams:fundamental-input-stream
   trivial-gray-streams:fundamental-output-stream
   trivial-gray-streams:fundamental-stream
   trivial-gray-streams:stream-advance-to-column
   trivial-gray-streams:stream-clear-input 	
   trivial-gray-streams:stream-clear-output
   trivial-gray-streams:stream-file-position
   trivial-gray-streams:stream-finish-output
   trivial-gray-streams:stream-force-output
   trivial-gray-streams:stream-fresh-line
   trivial-gray-streams:stream-line-column
   trivial-gray-streams:stream-listen
   trivial-gray-streams:stream-peek-char
   trivial-gray-streams:stream-read-byte
   trivial-gray-streams:stream-read-char
   trivial-gray-streams:stream-read-char-no-hang
   trivial-gray-streams:stream-read-line
   trivial-gray-streams:stream-read-sequence
   trivial-gray-streams:stream-start-line-p
   trivial-gray-streams:stream-terpri 
   trivial-gray-streams:stream-unread-char
   trivial-gray-streams:stream-write-byte
   trivial-gray-streams:stream-write-char
   trivial-gray-streams:stream-write-sequence
   trivial-gray-streams:stream-write-string
   
   
   )) ; end of DEFPACKAGE form

(require :babel)

(in-package :romance)

(defun start-server/generic (&optional argv)
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


