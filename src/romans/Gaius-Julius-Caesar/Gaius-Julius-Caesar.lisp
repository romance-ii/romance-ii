(in-package :caesar)

(defun collate-quality-of-service-reports ())

(defun heartbeat-failure-detection ())

(defgeneric start-program-container (container-model
                                     location program-identifier))




(define-condition unable-to-exec-error (error)
  ((returned :initarg :returned :reader syscall-return-value)))

;;; The EXECVE call below is taken from the Public-Domain version of EXECV
;;; written in 2003 by Daniel Barlow <dan@metacircles.com> (and explicitly
;;; placed into the Public Domain) as a part of the Swank backend for
;;; SBCL. This modified version is licensed as a part of Caeser (i.e. under
;;; the same terms as the rest of this program).

#+(and sbcl unix)
(sb-alien:define-alien-routine ("execve" sys-execve) sb-alien:int
                               (program sb-alien:c-string)
                               (argv (* sb-alien:c-string))
                               (env (* sb-alien:c-string)))

#+ (and sbcl unix)
(defun execve (program args environ)
  "Replace current executable with another one. This is a direct wrapper
around the execve in the C library, which in turn calls the execve system
call; refer to the manual pages for details. In particular, note that the
zeroeth argument is generally the (possibly-cosmetic version of the)
program's name."
  (let ((alien-args (sb-alien:make-alien sb-alien:c-string
                                         (+ 1 (length args))))
        (alien-env (sb-alien:make-alien sb-alien:c-string
                                        (+ 1 (length environ)))))
    (unwind-protect
        (progn
          (loop for index from 0 by 1
                and item in (append args '(nil))
                do (setf (sb-alien:deref alien-args index)
                         item))
          (loop for index from 0 by 1
                and item in (append environ '(nil))
                do (setf (sb-alien:deref alien-env index)
                         (etypecase item
                           (cons (concatenate 'string
                                              (string (car item))
                                              "="
                                              (string (cdr item))))
                           (string item))))
          (let ((returned (sys-execve program alien-args alien-env)))
            (error 'unable-to-exec-error :returned returned)))
      (sb-alien:free-alien alien-args))))

;;; end of Swank-Backend-inspired code



(defmacro run-external/local ((name command args environ
                                    input output error-output
                                    killp) &body body)
  "Run a local program."
  (let ((child (gensym "CHILD")))
    `(with-open-stream (,input (make-broadcast-stream))
       (with-open-stream (,output (make-broadcast-stream))
         (with-open-stream (,error-output (make-broadcast-stream))
           (let ((,child (sb-posix:fork)))
             (unwind-protect
                  (if (zerop ,child)
                      (let ((*standard-input* ,input)
                            (*standard-output* ,output)
                            (*error-output* ,error-output)
                            (*trace-output* nil)
                            (*debug-io* nil)
                            (*query-io* nil))
                        (execve ,command
                                (cons ,name ,args)
                                ,environ))
                      (progn ,@body))
               ,(when killp
                      `(progn (sb-posix:kill ,child sb-posix:SIGTERM)
                              (sleep 1/100) ;; FIXME
                              (sb-posix:kill ,child sb-posix:SIGKILL))))))))))

(defparameter *ssh-program* "/usr/bin/ssh"
  "The pathname to the SSH program to be executed.")
(defparameter *ssh-program-name* "ssh"
  "The (cosmetic) name to pass as argv[0] to the SSH program")
(defparameter *ssh-args* '("-A" "-C" "-e" "none")
  "A list of arguments always passed to SSH")
(defparameter *ssh-extra-args* ()
  "A list of additional arguments passed to SSH. Identical in purpose to SSH-ARGS.")
(defparameter *ssh-option-args* ()
  "A list of SSH option arguments passed to SSH, in AList form. Remapped to
  -Ooption-name=value. EG: (:foo . \"Bar\) maps to \"-OFOO=Bar\".")

(defun ssh-effective-args (&rest args)
  "Returns the argument vector for calling SSH, with ARGS appended."
  (list* (list *ssh-program-name* *ssh-args* *ssh-extra-args*)
         (mapcar (lambda (pair) (concatenate 'string
                                             "-O"
                                             (string (car pair))
                                             "="
                                             (string (cdr pair))))
                 *ssh-option-args*)
         args))

(defmacro run-external/remote ((host name command args environ
                                     input output error-output) &body body)
  `(run-external/local ((concatenate 'string "Remote " ,name " on " ,host)
                        *ssh-program*
                        (ssh-effective-args ,host ,command ,@args)
                        ,environ
                        ,input ,output ,error-output)
     ,@body))

(defmacro run-external ((host name (command args &optional environ)
                              &key (input (gensym "INPUT"))
                              (output (gensym "OUTPUT"))
                              (error-output (gensym "ERROR-OUTPUT")))
                        &body body)
  (check-type host (or null string symbol))
  (check-type name (or null string symbol))
  (check-type command (or string pathname))
  (check-type input symbol)
  (check-type output symbol)
  (check-type error-output symbol)
  (if (and (constantp host)
           (or (null host)
               (equal (string host) "localhost")))
      `(run-external/local ,(list (string (eval name)) 
                                  command args environ 
                                  input output error-output)
         ,@body)
      `(if (or (null host)
               (equal (string host) "localhost")
               (equal (string host) (machine-instance)))
           `(run-external/local ,(list (string (eval name)) 
                                       command args environ
                                       input output error-output)
              ,@body)
           `(run-external/remote ,(list (string host) (string name) 
                                        command args environ 
                                        input output error-output)
              ,@body))))

(defmethod start-program-container ((container-model (eql :docker))
                                    host
                                    program-identifier) 
  (todo))

(defgeneric launch-program (container program))

(defmethod launch-program (container (program (eql :postgres))) (todo))
(defmethod launch-program (container (program (eql :static-web-server))) (todo))
(defmethod launch-program (container (program t)) (todo))

(defun stop-program (identifier) (todo))

(defun kill-program (identifier) (todo))

(defun stop-program-container (identifier) (todo))

(defun stonith (identifier) (todo))

(defun parse-bignum (string)
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

(defun machine-vmstat ()
  (split-and-collect-file "/proc/vmstat"))

(defun machine-meminfo ()
  (split-and-collect-file "/proc/meminfo" #\:
                          #'cffi:translate-camelcase-name))

(defun maybe-numeric (string)
  (if-let (numeric (parse-bignum string))
    numeric
    (let ((pos (- (length string) 3)))
      (if (and (plusp pos) 
               (equal " kB" (subseq string pos)))
          (* 1024 (parse-integer (subseq string 0 pos)))
          string))))

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

(defun process-info (&optional (pid (sb-posix:getpid)))
  (let ((proc-dir (concatenate 'string "/proc/" (princ-to-string pid) "/")))
    (flet ((proc-file (file-name)
             (merge-pathnames file-name proc-dir))) 
      (append (list
               :io (split-and-collect-file (proc-file "io") #\:)
               :sched (let ((plist (split-and-collect-file (proc-file "sched") #\:)))
                        (cons :number-of-threads (cdr plist))) ;; first line is weird.
               :waiting-channel (collect-file (proc-file "wchan"))
               :login-uid (collect-file (proc-file "loginuid"))
               :security-attributes (mapcan (lambda (token)
                                              (list (make-keyword (string-upcase token))
                                                    (collect-file (proc-file (concatenate 'string "attr/" token)))))
                                            '("current" "exec" "fscreate" "keycreate" "prev" "sockcreate"))
               :mount-points (mapcar (lambda (row)
                                       (when (second row)
                                         (list (second row)
                                               (first row)
                                               (third row)
                                               (maybe-alist-split (fourth row))
                                               (nthcdr 4 row))))
                                     (collect-file-tabular (proc-file "mounts") #\Space))
               :mount-info (mapcar (lambda (row)
                                     (when (fifth row)
                                       (list (fifth row)
                                             (first row)
                                             (second row)
                                             (mapcar #'parse-integer (split-sequence #\: (third row)))
                                             (fourth row)
                                             (maybe-alist-split (sixth row))
                                             (maybe-alist-row (seventh row) #\:)
                                             (eighth row)
                                             (ninth row)
                                             (tenth row)
                                             (maybe-alist-split (nth 10 row))))) 
                                   (collect-file-tabular (proc-file "mountinfo") #\Space))
               :status (let ((skim (collect-file-lines (proc-file "status"))))
                         (flet ((trimmy (string)
                                  (string-trim '(#\Space #\Tab) string))
                                (split-columns (string)
                                  (mapcar #'parse-integer (split-sequence #\Tab string)))
                                (parse-hex (string)
                                  (parse-integer string :radix 16)))
                           (let ((translator (list :state (curry #'split-sequence #\Space)
                                                   :uid #'split-columns
                                                   :gid #'split-columns
                                                   :groups (lambda (string)
                                                             (mapcar #'parse-integer (split-sequence #\Space string)))
                                                   :sig-pnd #'parse-hex
                                                   :shd-pnd #'parse-hex
                                                   :sig-blk #'parse-hex
                                                   :sig-ign #'parse-hex
                                                   :sig-cgt #'parse-hex
                                                   :cap-inh #'parse-hex
                                                   :cap-prm #'parse-hex
                                                   :cap-eff #'parse-hex
                                                   :cap-bnd #'parse-hex
                                                   :cpus-allowed #'parse-hex
                                                   :mems-allowed (lambda (row)
                                                                   (mapcar #'parse-hex (split-sequence #\, row)))
                                                   :sig-q (lambda (row)
                                                            (mapcar #'parse-integer (split-sequence #\/ row))))))
                             (loop for line in skim
                                for colon = (position #\: line)
                                for key = (make-keyword (cffi:translate-camelcase-name 
                                                         (substitute #\- #\_ (subseq line 0 colon))))
                                for rest = (trimmy (subseq line (1+ colon)))
                                for fn = (getf translator key)
                                collect (list key (if fn (funcall fn rest) (maybe-numeric rest)))))))
               :control-groups (split-and-collect-file (proc-file "cgroup") #\:)
               :command-line (collect-file-lines (proc-file "cmdline") #\Null)
               :environment (mapcar #'maybe-alist-row 
                                    (collect-file-lines (proc-file "environ") #\Null)))
              (mapcan (lambda (pair)
                        (let ((token (car pair))
                              (file (cdr pair)))
                          (list token (collect-file (proc-file file)))))
                      '((:program . "comm")
                        (:oom-score . "oom_score")
                        (:oom-adjust . "oom_adj")
                        (:oom-score-adjust . "oom_score_adj")
                        (:coredump-filter . "coredump_filter")))))))

(defun all-processes-info ()
  (loop for entry in (directory "/proc/*")
     for pid = (parse-integer (lastcar (pathname-directory entry)) :junk-allowed t)
     when pid
     append (list pid (block try-collect-info
                        (handler-bind
                            ((error (lambda (c) (return-from try-collect-info 
                                                  (list :error c)))))
                          (process-info pid))))))

(defun start-server (argv)
  (romance:server-start-banner "Caesar"
                               "Gaius Julius Cæsar"
                               "Command and control server")
  (format t "~&[CIC] Exiting.~%"))

(defgeneric handle-report (module machine message-keyword user-string 
                           &key &allow-other-keys))

(defmethod handle-report ((module t) (machine t) (message t) (user-string t)
                          &rest keys)
  (format *error-output*
          "~&[CIC] An unhandled message type (~s) was received from module ~:(~a~): “~a”~{~&  ~32<~:(~a~)~>: ~a~}"
          module message user-string keys))

(defmethod handle-report :after ((module t) (machine t) (message (eql :qos)) (user-string t)
                                 &key activity capacity vmstats)
  (collect-qos module machine activity capacity vmstats))

(defmethod handle-report :after ((module t) (machine t) (message (eql :begin-oversight)) (user-string t)
                                 &key)
  (format *standard-output* "[CIC] Beginning oversight of module ~:(~a~) on machine ~:(~a~).~[  “~a”~]"
          module machine user-string))
(defmethod handle-report :after ((module t) (machine t) (message (eql :end-oversight)) (user-string t)
                                 &key )
  (end-oversight module machine))

(defmethod handle-report :after ((module t) (machine t) (message (eql :machine-down)) (user-string t)
                                 &key time-to-live)
  "The machine MACHINE is going down. Schedule replacement for any tasks
  pending on it.")

(defmethod handle-report :after ((module t) (machine t) (message (eql :lisp-warning)) (user-string t)
                                 &key condition)
  "A Lisp program issued a WARNing"
  (journal ""))

(defmethod handle-report :after ((module t) (machine t) (message (eql :lisp-error)) (user-string t)
                                 &key condition)
  "A Lisp program issued an ERROR."
  )

(define-condition report (condition)
  ((module :reader report-module :initarg :module :type symbol)
   (message-keyword :reader report-message :initarg :message-keyword :type symbol)
   (user-string :reader report-user-string :initarg :user-string :type string)
   (keys :reader report-keys :initarg :keys :type list)
   (machine :reader report-machine :initarg :machine :type string)))

(defun report (module message-keyword user-string &rest keys)
  (signal 'report :module module :message-keyword message-keyword
          :user-string user-string :keys keys :machine (machine-instance)))

(defmacro with-oversight ((module) &body body)
  `(handler-bind
    (report
     (lambda (r)
       (apply #'handle-report (or (report-module r) ,module)
              (or (report-machine r) (machine-instance))
              (report-message-keyword r)
              (report-user-string r)
              (report-keys r))))
    
    (handler-bind
     (((warning error) 
       (lambda (c)
         (caesar:report ,module :lisp-error
                        (format nil
                                "Application signaled an ERROR condition:~%~S~% “~:*~A”"
                                c)
                        :condition c
                        :restarts (compute-restarts)
                        :condition-restarts (compute-restarts c)))))
     (caesar:report ,module :start-oversight "Beginning oversight by Caesar")
     (unwind-protect 
         (progn ,@body)
       (caesar:report ,module :end-oversight "Ending oversight by Caesar")))))
