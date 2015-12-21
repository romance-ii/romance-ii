(in-package :caesar)


(defun collate-quality-of-service-reports ()
  (todo))

(defun heartbeat-failure-detection ()
  (todo))




(defun machine-vmstat ()
  (split-and-collect-file "/proc/vmstat"))

(defun multiply-bytes (object)
  (check-type object string)
  (assert (char= #\B (last-elt object)))
  (let ((base (parse-integer object :junk-allowed t))
        (multiplier (char object
                          (1+ (position #\Space object :from-end t :test #'char=)))))
    (* base
       (ecase multiplier
         (#\k 1024)
         (#\M (* 1024 1024))
         (#\G (* 1024 1024 1024))
         (#\T (* 1024 1024 1024 1024))
         (#\P (* 1024 1024 1024 1024 1024))
         (#\E (* 1024 1024 1024 1024 1024 1024))
         (#\Y (* 1024 1024 1024 1024 1024 1024 1024))))))

(defun multiply-bytes-maybe (object)
  (if (and (stringp object)
           (char= (last-elt object) #\B))
      (multiply-bytes object)
      object))

(defun machine-meminfo ()
  (mapcar #'multiply-bytes-maybe
          (split-and-collect-file "/proc/meminfo" #\:
                                  #'cffi:translate-camelcase-name)))

(defun all-process-ids ()
  (loop for entry in (directory "/proc/*")
     for pid = (parse-integer (lastcar (pathname-directory entry)) :junk-allowed t)
     while entry
     when pid collect it))




(defun collect-qos (module machine activity capacity vmstats)
  (declare (ignore module machine activity capacity vmstats))
  (todo))



(defvar *operator-handle-signals* nil
  "A list of threads to be signaled when a signal arrives.")

(defgeneric handle-report (module machine message-keyword user-string
                           &key &allow-other-keys))

(defun keyword-journal-message-id (keyword)
  (subseq (cl-oauth:hmac-sha1 (string keyword) (package-name (symbol-package keyword)))
          0 15))

(defgeneric keyword-priority-map (keyword)
  (:method ((keyword t)) (declare (ignore keyword)) 3))

(defun find-throwing-frame ()
  (let ((foundp nil))
    (ignore-errors
     (trivial-backtrace:map-backtrace
      (lambda (frame)
        (let ((function (trivial-backtrace::frame-func frame)))
          (cond
            ((member function '(signal throw error warn))
             (setf foundp t))
            (foundp (return-from find-throwing-frame frame)))))))))

(defun frame-funcall (frame)
  (format nil "(~S~{ (~S←~S ~})"
          (trivial-backtrace::frame-func frame)
          (or
           (map 'list
                (lambda (var)
                  (list (trivial-backtrace::var-name var)
                        (trivial-backtrace::var-value var)))
                (trivial-backtrace::frame-vars frame))
           (list '#:? '#:… nil))))

;; (defun journal-condition (module machine message user-string &optional condition throwing-frame)
;;   (let* ((throwing-frame throwing-frame)
;;          (debug-source (sb-di:code-location-debug-source
;;                         (sb-di:frame-code-location throwing-frame))))
;;     (systemd:journal-send
;;      (cons (cons (list :message user-string
;;                        :priority (keyword-priority-map message)
;;                        :code-file (sb-di:debug-source-namestring debug-source)
;;                        :code-line (sb-di:debug-source-form debug-source)
;;                        :code-func (frame-funcall throwing-frame)
;;                        :x-module (string module)
;;                        :x-machine (string machine))
;;                  (when condition
;;                    (list :x-condition (princ-to-string condition)
;;                          :x-condition-type message)))
;;            (when-let ((message-id (keyword-journal-message-id message)))
;;              :message-id message-id)))))

(defmethod handle-report :before (module machine message-keyword user-string
                                  &rest keys)
  (apply #'systemd:journal-send
         (let ((args (list :message user-string
                           :message-id (keyword-journal-message-id message-keyword)
                           :priority (keyword-priority-map message-keyword)
                           :syslog-identifier (concatenate 'string "Romance/"
                                                           (string module) "@"
                                                           (string machine)))))
           (when-let ((code-file (getf keys :source-file)))
             (appendf args (list :code-file code-file)))
           (when-let ((code-func (getf keys :source-function)))
             (appendf args (list :code-func code-func)))
           (when-let ((code-line (getf keys :source-line)))
             (appendf args (list :code-line code-line)))
           (when-let ((errno (getf keys :libc-errno)))
             (appendf args (list :errno errno)))
           args))
  (format *trace-output* "~&~%〈CIC〉 “~a”~{~%〈CIC〉 ⋅ ~:(~a:~) ~a~}"
          user-string
          (append (list :module module :machine machine
                        :message message-keyword) keys))
  (finish-output *trace-output*))

(defmethod handle-report ((module t) (machine t) (message t) (user-string t)
                          &rest keys)
  (format *error-output*
          "~&~%[CIC] Message (~s) from module ~:(~a~): “~a”~{~&  ~32<~:(~a~)~>: ~a~}"
          message module user-string keys)
  (finish-output *error-output*))

(defmethod handle-report ((module t) (machine t) (message (eql :qos)) (user-string t)
                          &key activity capacity vmstats)
  (collect-qos module machine activity capacity vmstats))

(defmethod handle-report ((module t) (machine t) (message (eql :begin-oversight))
                          (user-string t)
                          &key)
  (format *standard-output* "~&[CIC] Beginning module ~:(~a~) on machine ~:(~a~).~[  “~a”~]"
          module machine user-string)
  (finish-output *standard-output*))
(defmethod handle-report ((module t) (machine t) (message (eql :end-oversight))
                          (user-string t)
                          &key )
  (format *standard-output* "~&[CIC] Ending module ~:(~a~) on machine ~:(~a~).~[  “~a”~]"
          module machine user-string)
  (finish-output *standard-output*))

(defmethod handle-report ((module t) (machine t) (message (eql :machine-down))
                          (user-string t)
                          &key time-to-live)
  "The machine MACHINE is going down. Schedule replacement for any tasks
  pending on it."
  (declare (ignore time-to-live))
  (todo))

(defmethod handle-report ((module t) (machine t) (message (eql :lisp-warning))
                          (user-string t)
                          &rest keys)
  "A Lisp program issued a WARNing"
  (when *operator-handle-signals*
    (funcall *operator-handle-signals* module machine message user-string keys)))

(defmethod handle-report ((module t) (machine t) (message (eql :lisp-error))
                          (user-string t)
                          &rest keys &key condition)
  "A Lisp program issued an ERROR."
  ;; (journal-condition module machine message user-string condition)
  (declare (ignorable condition))
  (when *operator-handle-signals*
    (funcall *operator-handle-signals* module machine message user-string keys)))

(define-condition report (condition)
  ((module :reader report-module :initarg :module :type symbol)
   (message-keyword :reader report-message :initarg :message-keyword :type symbol)
   (user-string :reader report-user-string :initarg :user-string :type string)
   (keys :reader report-keys :initarg :keys :type list)
   (machine :reader report-machine :initarg :machine :type string)))

(defvar *module*)

(defun report (message-keyword user-string &rest keys)
  (let ((frame (find-throwing-frame)))
    (signal 'report
            :module (if (boundp '*module*)
                        (symbol-value '*module*)
                        '#:UNKNOWN-MODULE)
            :source-function (when frame (trivial-backtrace::frame-func frame))
            :source-filename (when frame (trivial-backtrace::frame-source-filename frame))
            :source-line (when frame (trivial-backtrace::frame-source-pos frame))
            :message-keyword message-keyword
            :user-string user-string :keys keys :machine (machine-instance))))

(defmethod romance::todo :around (&optional message &rest keys)
  (apply #'report :todo message keys)
  (call-next-method))



(eval-when (:compile-toplevel :load-toplevel :execute)
  (defun oversight-handle (case)
    `(,case
         (lambda (condition)
           (caesar:report ,(make-keyword (concatenate 'string "LISP-" (string case)))
                          (format nil
                                  ,(concatenate 'string "Application signaled "
                                                (string-downcase (a/an (string case)))
                                                " condition:~%~S~% “~:*~A”")
                                  condition)
                          :condition condition
                          :restarts (compute-restarts)
                          :condition-restarts (compute-restarts condition))))))

(define-condition hook-timeout (warning)
  ((elapsed-time :initarg :elapsed-time :reader timeout-elapsed-time)))
(define-condition hook-early-timeout (hook-timeout)
  ())
(define-condition hook-soft-timeout (hook-timeout)
  ())
(define-condition hook-hard-timeout (hook-timeout)
  ())

(defun get-real-time ()
  (/ (get-internal-real-time)
     internal-time-units-per-second))

(defun timeout-handler%early (soft-timeout hard-timeout)
  `((< elapsed ,(or soft-timeout hard-timeout))
    (report :false-timeout "TIMEOUT signaled early (continuing, ignoring this)"
            :condition condition
            :elapsed-time elapsed
            :soft-timeout ,soft-timeout
            :hard-timeout ,hard-timeout)
    (signal 'hook-early-timeout :elapsed-time elapsed)
    (continue)))

(defun timeout-handler%soft (soft-timeout hard-timeout)
  (when soft-timeout
    `(((and ,@(when soft-timeout
                    `((<= ,soft-timeout elapsed)))
            (< elapsed ,hard-timeout)
            t)
       (report :soft-timeout "Function exceeded soft timeout"
               :condition condition
               :elapsed-time elapsed
               :soft-timeout ,soft-timeout)
       (signal 'hook-soft-timeout :elapsed-time elapsed)
       (continue)))))

(defun timeout-handler%hard (soft-timeout hard-timeout)
  (declare (ignore soft-timeout))
  `((t
     (report :hard-timeout "Function exceeded hard timeout and is being aborted"
             :condition condition
             :elapsed-time elapsed
             :hard-timeout ,hard-timeout)
     (signal 'hook-hard-timeout :elapsed-time elapsed)
     (abort))))

(defmacro with-timeout-handler ((soft-timeout hard-timeout) &body body)
  (check-type soft-timeout (or real symbol null))
  (check-type hard-timeout (or real symbol null))
  (let ((timer-tag (gensym "TIMEOUT-BLOCK-")))
    (if (or soft-timeout hard-timeout)
        (let ((soft-timeout (if (and (realp soft-timeout)
                                     (realp hard-timeout))
                                (min soft-timeout hard-timeout)
                                soft-timeout))
              (hard-timeout (if (and (realp soft-timeout)
                                     (realp hard-timeout))
                                (max soft-timeout hard-timeout)
                                soft-timeout))
              (timer (gensym "TIMER-")))
          `(block ,timer-tag
             (let ((,timer (get-real-time)))
               (handler-bind
                   ((timeout (lambda (condition)
                               (let ((elapsed (- (get-real-time) ,timer)))
                                 (cond
                                   ,@(timeout-handler%early soft-timeout hard-timeout)
                                   ,@(timeout-handler%soft soft-timeout hard-timeout)
                                   ,@(timeout-handler%hard soft-timeout hard-timeout))))))
                 (,@(if (realp hard-timeout)
                        (list 'with-timeout (list hard-timeout))
                        (list 'values))
                    (,@(if (realp soft-timeout)
                           (list 'with-timeout (list soft-timeout))
                           (list 'values))
                       ,@body))))))
        `(block ,timer-tag
           ,@body))))

(defmacro with-report-acceptor (&body body)
  `(handler-bind
       ((report
         (lambda (r)
           (apply #'handle-report
                  (or (report-module r) *module*)
                  (or (report-machine r) (machine-instance))
                  (report-message r)
                  (report-user-string r)
                  (report-keys r)))))
     ,@body))

(defun start-module-in-thread (mod-keyword module-start)
  (bordeaux-threads:make-thread
   module-start
   :name (string (gensym (format nil "~:(~a~) thread " mod-keyword)))))

(defmacro with-oversight ((module &key soft-timeout hard-timeout) &body body)
  (let* ((mod-keyword (make-keyword (string-upcase (string module))))
         (module-block (format-symbol *package* 
                                      "~A-MODULE" mod-keyword))
         (module-start (format-symbol *package* 
                                      "~A-START" mod-keyword)))
    `(let ((*module* ',mod-keyword))
       (block ,module-block
         (labels
             ((,module-start ()
                (with-report-acceptor
                  (with-timeout-handler (,soft-timeout ,hard-timeout)
                    (handler-bind
                        (,(oversight-handle 'error)
                         ,(oversight-handle 'warning))
                      (caesar:report :begin-oversight
                                     "Beginning oversight by Caesar")
                      (unwind-protect
                           (restart-bind
                               ((restart-module-in-new-thread
                                 (lambda ()
                                   (start-module-in-thread ,mod-keyword (function ,module-start))
                                   t)
                                  :report-function
                                  (lambda (stream)
                                    (princ
                                     ,(format nil "Restart the ~:(~a~) module in a new thread"
                                              mod-keyword)
                                     stream)))
                                (exit-module
                                 (lambda ()
                                   (return-from
                                    ,module-block
                                     nil))
                                  :report-function 
                                  (lambda (stream)
                                    (princ ,(format nil "Exit the ~:(~a~) module"
                                                    mod-keyword)
                                           stream))))
                             ,@body)
                        (caesar:report :end-oversight "Ending oversight by Caesar")))))))
           (,module-start))))))




(defvar *cluster* nil)

(defvar *mdns-service-type* "_romance2")

(defun find-avahi-server ()
  (dbus:with-open-bus (bus (dbus:session-server-addresses))
    (dbus:with-introspected-object 
        (avahi bus 
               "/"
               "org.freedesktop.Avahi.ServiceResolver")
      (avahi "org.freedesktop.Avahi.ServiceResolver" "Found"))))

(defun find-all-clusters ()
  (todo))

(defun cluster-address (cluster)
  (when cluster
    (todo)))

(defun cluster-name (cluster)
  (when cluster
    (todo)))

(defun find-cluster (&key cluster-name cluster-address)
  (let ((found (remove-if
                #'null
                (append (when cluster-address
                          (remove-if-not
                           (complement (curry #'equalp cluster-name))
                           (find-all-clusters)
                           :key #'cluster-address))
                        (when cluster-name
                          (remove-if-not
                           (complement (curry #'equalp cluster-name))
                           (find-all-clusters)
                           :key #'cluster-name))
                        (unless (or cluster-name cluster-address)
                          (find-all-clusters))))))
    (case (length found)
      (0 (format *trace-output*
                 "~&Could not find any cluster~@[ named ~a~]~@[ at address ~a~]"
                 cluster-name cluster-address)
         nil)
      (1 (car found))
      (otherwise (error "~&Multiple clusters were found~@[ named ~a~]~@[ at address ~a~]
~{~% • ~a~}
Please provide an unique name or address to join one cluster"
                        cluster-name cluster-address found)))))

(defparameter *default-cluster-names*
  '("Beefy" "Composite" "Ganesh" "Goethe"
    "Indira" "Prime" "Rama" "Whitney"))

(define-constant +server-packages+
    '(:appius :asinius :clodia :frontinus :galen :lutatius :narcissus :rabirius :regillus :vitruvius)
  :test #'equalp)

(defun start-cluster (&key cluster-name)
  (unless cluster-name
    (loop for name in (shuffle *default-cluster-names*)
       until (not (find-cluster :cluster-name name))
       finally (setf cluster-name name)))
  (unless cluster-name
    (while (not (and cluster-name
                     (find-cluster :cluster-name cluster-name))) 
      (setf cluster-name
            (string (gensym (random-elt *default-cluster-names*))))))
  (when (find-cluster :cluster-name cluster-name)
    (error "Cluster named “~a” already exists, but I was asked to start it." cluster-name))
  (let ((*cluster* cluster-name))
    (dolist (package +server-packages+)
      (start-module-in-thread (format-symbol package "Package ~:(~a~)" package)
                              (intern "START-SERVER" (find-package package))))))

(defun join-cluster (&optional (cluster *cluster*))
  (format *trace-output* "~&Contacting cluster ~a to join them…" cluster)
  (finish-output)
  (todo))


(defun ensure-servers-live ()
  (todo))
(defun poll-qos-reports ()
  (todo))

(defun manage-cluster (&optional (cluster *cluster*))
  (format *trace-output* "~&Now managing cluster ~a." cluster)
  (restart-case
      (loop
         (ensure-servers-live)
         (poll-qos-reports))
    (stop-caesar-managing ()
      :report (lambda (s)
                (format s "Stop Caesar from managing this cluster"))
      (return-from manage-cluster nil))))




(defun caesar (&key cluster-name cluster-address)
  (if-let ((*cluster* (find-cluster :cluster-name cluster-name
                                    :cluster-address cluster-address)))
    (join-cluster *cluster*)
    (start-cluster)))

(defun argv->keywords (argument)
  (if (and (stringp argument)
           (plusp (length argument))
           (char= #\- (elt argument 0)))
      (if (and (< 2 (length argument))
               (char= #\- (elt argument 1)))
          (make-keyword (string-upcase (subseq argument 2)))
          (make-keyword (string-upcase (subseq argument 1))))
      argument))

(defun start-server (&rest argv)
  (romance:server-start-banner "Caesar"
                               "Gaius Julius Cæsar"
                               "Command and control server")
  (with-oversight (caesar)
    (apply #'caesar (mapcar #'argv->keywords (flatten argv))))
  (format t "~&[CIC] Exiting.~%"))

