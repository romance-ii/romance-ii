(in-package :caesar)

(cffi:defcstruct (utmp :conc-name utmp-)
  (type$ :int16)
  (pid :int32)
  (line$ :uint8 :count 32)
  (id$ :uint8 :count 4)
  (user$ :uint8 :count 32)
  (host$ :uint8 :count 256)
  (exit :int32)
  (sid :int32)
  (sec :int32)
  (μsec :int32)
  (address :uint8 :count 16)
  (unused :uint8 :count 20))

(defun strz-or-string (array)
  (if (every 'characterp array)
      (if-let (end (position #\Null array))
        (coerce (subseq array 0 end) 'string)
        (coerce array 'string))
      (strz-or-string 
       (babel:octets-to-string 
        (coerce
         (map 'vector
              (lambda (el)
                (etypecase el
                  (character (char-code el))
                  (number (coerce el '(unsigned-byte 8)))))
              array)
         '(vector (unsigned-byte 8)))))))

(assert (equal (strz-or-string #(#\t #\h #\i #\s)) "this") nil
        "StrZ-or-string should return the entire  char array as a string
        if there is no #\\Null (zero) terminator")
(assert (equal (strz-or-string #(#\f #\o #\o #\Null #\x)) "foo") nil
        "StrZ-or-string should return only the characters leading up to (but excluding) the
terminating #\\Null (zero) terminator, when it is present")
(assert (equal (strz-or-string #(#xe2 #x98 #xa0)) "☠") nil
        "StrZ-or-string must handle UTF-8 data properly")
(assert (equal (strz-or-string #(#xe2 #x98 #xa0 #\Null #\x)) "☠") nil
        "StrZ-or-string should return only the characters leading up to (but excluding) the
terminating #\\Null (zero) terminator, when it is present")

(defun utmp-line (utmp)
  (strz-or-string (utmp-line$ utmp)))

(defun utmp-id (utmp)
  (strz-or-string (utmp-id$ utmp)))

(defun utmp-user (utmp)
  (strz-or-string (utmp-user$ utmp)))

(defun utmp-host (utmp)
  (strz-or-string (utmp-host$ utmp)))

(defconstant utmp-empty 0)
(defconstant utmp-run-level 1)
(defconstant utmp-boot-time 2)
(defconstant utmp-new-time 3) ; clock adjustment
(defconstant utmp-old-time 4)
(defconstant utmp-init-process 5)
(defconstant utmp-login-process 6)
(defconstant utmp-user-process 7)
(defconstant utmp-accounting 8) ; not really…

(cffi:defctype comp-t :uint16)

(defmethod cffi:translate-from-foreign (value (type comp-t))
  (let ((exponent-bits (* 3 (ldb (byte 3 0) value)))
        (mantissa (ldb (byte 13 4) value)))
    (coerce (dpb mantissa (byte (+ 14 exponent-bits)
                                exponent-bits)
                 0) 'number)))

;; TODO: get a unit test in here for that mess.

(cffi:defcstruct (acct :conc-name acct-)
  (flags :uint8)
  (version :uint8)                      ; must be =3
  (tty :uint16)
  (exit-code :uint32)
  (uid :uint32)
  (gid :uint32)
  (pid :uint32)
  (ppid :uint32)
  (process-create-time :uint32)         ; sec > Epoch
  (elapsed-time :float)
  (user-cpu-time comp-t)
  (system-cpu-time comp-t)
  (average-memory comp-t)               ; in KiB
  (pad$character-io :uint16)            ; unused
  (pad$blocks-io :uint16)               ; unused
  (minor-page-faults comp-t)
  (major-page-faults comp-t)
  (pad$swaps :uint16)                   ; unused
  (command$ :uint8 :count 17))

(defun acct-command (acct)
  (strz-or-string (acct-command$ acct)))

(defun read-fixed-byte-count (byte-count stream)
  (handler-case 
      (coerce (loop for i from 0 upto byte-count
                 for byte = (read-byte stream t)
                 collect byte)
              '(vector (unsigned-byte 8)))
    (end-of-file (c) 
      (declare (ignore c)) 
      nil)))

(defun read-utmp (&optional (utmp-file-name #+linux #p"/var/run/utmp"
                                            #-linux (error "Where is utmp?")))
  (with-open-file (utmp-file utmp-file-name :direction :input
                             :element-type '(unsigned-byte 8)
                             :external-format :raw)
    (let* ((utmp-size (cffi:foreign-type-size 'utmp))
           (utmp-byte-array (list :array :uint8 utmp-size)))
      (loop for struct-bytes = 
           (read-fixed-byte-count utmp-size utmp-file)
         until (null struct-bytes)
         collect 
           (let (c-struct)
             (unwind-protect 
                  (progn (setf c-struct (cffi:convert-to-foreign 
                                         struct-bytes 
                                         utmp-byte-array))
                         (cffi:convert-from-foreign c-struct
                                                    '(:struct utmp)))
               (cffi:free-converted-object c-struct 
                                           utmp-byte-array t)))))))

(defun read-wtmp (&optional (wtmp-file-name #+linux #p"/var/log/wtmp"
                                            #-linux (error "Where is wtmp?")))
  (read-utmp wtmp-file-name))

