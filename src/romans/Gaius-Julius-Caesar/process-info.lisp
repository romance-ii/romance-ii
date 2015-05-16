(in-package :caesar)

(import 'romance::split-and-collect-file)

(defclass process ()
  ((pid :type fixnum :initarg :pid :initform (sb-posix::getpid) :reader process-id)))

(defun this-process ()
  (make-instance 'process :pid (sb-posix:getpid)))

(defmethod proc-file ((process process) file)
  (merge-pathnames file
                   (concatenate 'string "/proc/" (princ-to-string (process-id process)) "/")))

(defmethod process-io-stats ((process process))
  (split-and-collect-file (proc-file process "io") #\:))

(defmethod process-sched ((process process))
  (let ((plist (split-and-collect-file (proc-file process "sched") #\:)))
    (cons :number-of-threads (cdr plist)))) ;; first line is weird.

(defmethod process-wait-channel ((process process))
  (collect-file (proc-file process "wchan")))

(defmethod process-login-uid ((process process))
  (collect-file (proc-file process "loginuid")))
(defmethod process-security-attributes ((process process))
  (mapcan (lambda (token)
            (list (make-keyword (string-upcase token))
                  (collect-file (proc-file process (concatenate 'string "attr/" token)))))
          '("current" "exec" "fscreate" "keycreate" "prev" "sockcreate")))
(defmethod process-mount-points ((process process))
  (mapcar (lambda (row)
            (when (second row)
              (list (second row)
                    (first row)
                    (third row)
                    (maybe-alist-split (fourth row))
                    (nthcdr 4 row))))
          (collect-file-tabular (proc-file process "mounts") #\Space)))
(defmethod process-mount-info ((process process))
  (mapcar (lambda (row)
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
          (collect-file-tabular (proc-file process "mountinfo") #\Space)))

(defmethod process-status ((process process))
  (let ((skim (collect-file-lines (proc-file process "status"))))
    (flet ((trimmy (string)
             (string-trim '(#\Space #\Tab) string))
           (split-columns (string)
             (mapcar #'maybe-numeric (split-sequence #\Tab string)))
           (parse-hex (string)
             (parse-integer string :radix 16)))
      (let ((translator (list :state (curry #'split-sequence #\Space)
                              :uid #'split-columns
                              :gid #'split-columns
                              :groups (lambda (string)
                                        (mapcar #'maybe-numeric (split-sequence #\Space string)))
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
                                       (mapcar #'maybe-numeric (split-sequence #\/ row))))))
        (loop for line in skim
           for colon = (position #\: line)
           for key = (make-keyword (cffi:translate-camelcase-name 
                                    (substitute #\- #\_ (subseq line 0 colon))))
           for rest = (trimmy (subseq line (1+ colon)))
           for fn = (getf translator key)
           append (list key (if fn (funcall fn rest) (maybe-numeric rest))))))))

(defmethod process-name ((process process))
  (getf (process-status process) :name))

(defmethod process-state-gerund ((process process))
  (let* ((state-pair (getf (process-status process) :state))
         (gerund-stripped (remove #\( (remove #\) (second state-pair)))))
    (string-case gerund-stripped
      ("sleeping" (format nil "sleeping (~A)" (process-wait-channel process)))
      (t gerund-stripped))))

(defmethod process-control-groups ((process process))
  (split-and-collect-file (proc-file process "cgroup") #\:))
(defmethod process-command-line ((process process))
  (collect-file-lines (proc-file process "cmdline") #\Null))
(defmethod process-environment ((process process))
  (mapcar #'maybe-alist-row 
          (collect-file-lines (proc-file process "environ") #\Null)))

(defmethod process-command ((process process)) 
  (collect-file (proc-file process "comm")))
(defmethod process-oom-score ((process process))
  (collect-file (proc-file process "oom_score")))
(defmethod process-oom-adjust ((process process))
  (collect-file (proc-file process "oom_adj")))
(defmethod process-oom-score-adjust ((process process))
  (collect-file (proc-file process "oom_score_adj")))
(defmethod process-core-dump-filter ((process process))
  (collect-file (proc-file process "coredump_filter")))
