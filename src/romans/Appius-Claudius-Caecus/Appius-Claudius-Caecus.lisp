(in-package :appius)

(defun start-server/socket-activation (socket)
  "working with SystemD for TCP streams (and WebSockets streams as well?)"
  (todo))

(defvar *server-quit* nil
  "Set to true to abort the server on a request from Caesar")

(defvar *selected-socket* nil
  "When in context of a connection, the socket currently
  beign considered.")

(defgeneric serve (socket))

(define-condition tcp-connection-accepted (condition)
  ((socket-info :initarg :socket-info :reader connection-socket-info)))

(defmethod serve ((socket stream-server-usocket))
  "Accept a new connection"
  (let* ((accepted (socket-accept socket))
         (info (make-instance 'socket-info
                              :socket accepted)))
    (setf (gethash accepted *connection-pool*) info)
    (signal 'tcp-connection-accepted :socket-info info)
    (caesar::report :accepted-connection 
                    "Accepted a TCP/IP connection and added to connection pool"
                    :socket-info info)))

(defgeneric serve-socket (stream encoding state socket info))

(defmethod serve ((socket stream-usocket))
  (let ((info (gethash socket *connection-pool*)))
    (serve-socket (socket-info-stream info)
                  (socket-info-encoding info)
                  (socket-info-state info)
                  socket info)))

(define-condition protocol-unhandled-error (error)
  ((socket-info :initarg :socket-info :reader error-socket-info))
  (:report "no handler for this socket state: ~A"))

(defmethod serve-socket ((stream t) (encoding t) (state t)
                         (socket t) (info t))
  (error 'protocol-unhandled-error :socket-info info))

(defparameter $reaper-cycles$ 40)

(defun send-server-message (code)
  "Send the server message with the given code to the client."
  (format (socket-stream *selected-socket*)
          "~C~CSERVER MESSAGE CODE ~S~%~C"
          (code-char 3) (code-char 0) code (code-char 4)))

(defvar *connection-pool* (make-hash-table))

(defvar *selected-socket*)

(defun end-of-file-handler (condition)
  (when (typep *selected-socket* 'stream-server-usocket)
    (error 'listener-disconnected
           :caused-by condition))
  (invoke-restart 'disconnected condition))

(define-condition socket-disconnect-polite-hook (condition) ())
(define-condition socket-disconnect-hook (condition) ())

(defun socket-polite-disconnect (note)
  ;; TODO QoS
  (when note (send-server-message note))
  (send-server-message :disconnecting)
  (signal 'socket-disconnect-polite-hook)
  (caesar::report :polite-disconnect (strcat "Note: " note)
                  :socket *selected-socket*)
  (invoke-restart 'disconnected note))

(defun socket-disconnected ()
  ;; TODO QoS
  (signal 'socket-disconnect-hook)
  (caesar::report :disconnected "Socket disconnecting"
                  :socket *selected-socket*)
  (socket-close *selected-socket*)
  ;;(remhash *selected-socket* *socket-accumulators*)
  (remhash *selected-socket* *connection-pool*))

(defun server-listen ()
  (restart-bind
      ((disconnect-politely #'socket-polite-disconnect
         :report-function (lambda (s) 
                            (princ "Politely disconnect socket" s))
         :test-function (lambda (c) 
                          (declare (ignore c))
                          *selected-socket*))
       (disconnected #'socket-disconnected
         :report-function (lambda (s) 
                            (princ "Disconnect socket" s))
         :test-function (lambda (c)
                          (declare (ignore c))
                          *selected-socket*)))
    (handler-bind
        ((end-of-file #'end-of-file-handler)
         (bad-file-descriptor #'end-of-file-handler))
      (serve *selected-socket*))))


(define-condition tcp-pre-listen-hook (condition)
  ((address :initarg :address :reader ip-address)
   (port :initarg :port :reader tcp-port)))

(define-condition tcp-unwinding-hook (condition)
  ((connection-pool :initarg :connection-pool :reader connection-pool)))

(defun start-server/tcp-listener (&optional (address *wildcard-host*)
                                    (port 2770))
  "Start listening at the given address and port. Defaults to
universal (all local addresses) and port 2770."
  (check-type port (integer 1024 65535) "Valid TCP port number")
  (caesar:with-oversight (appius/tcp-server)
    (restart-bind
        
        ((use-other-interface 
          (lambda (address)
            (start-server/tcp-listener address port))
           :report-function (lambda (s) 
                              (princ "Listen on another interface" s))
           :interactive-function 
           (lambda ()
             (format *query-io* "~&Enter the address of the interface on which to listen
\(~S for all interfaces) ⇒ " *wildcard-host*)
             (list (read *query-io*)))
           :test-function
           (lambda (c)
             (typep c 'address-in-use-error)))
         
         (use-other-port 
          (lambda (port)
            (start-server/tcp-listener address port))
           :report-function (lambda (s) 
                              (princ "Listen on another port" s))
           :interactive-function 
           (lambda ()
             (format *query-io* "~&Enter the port number on which to listen
\(Default is 2770) ⇒ ")
             (list (read *query-io*)))
           :test-function
           (lambda (c)
             (typep c 'address-in-use-error))))
      
      (caesar::report :begin-listening 
                      (format nil "Listening for TCP connections on ~{~d.~d.~d.~d~} port ~S"
                              (coerce address 'list) port))
      (signal 'tcp-pre-listen-hook :address address :port port)
      (let* ((listener (socket-listen address port
                                      :reuse-address t
                                      :backlog #x20))
             (cycler  (make-t-every-n-times $reaper-cycles$)))
        (unwind-protect
             (progn
               (setf (gethash listener *connection-pool*)
                     (make-instance 'socket-info :socket listener
                                    :encoding :tcp-listen))

               (loop
                  for *selected-socket*
                  in (wait-for-input (hash-table-keys *connection-pool*)
                                     :timeout 1/2 ;sec
                                     :ready-only (funcall cycler))
                  until *server-quit*
                  do (server-listen)))
          (progn
            (signal 'tcp-unwinding-hook :connection-pool *connection-pool*)
            (when *connection-pool*
              (caesar:report :left-over-connections 
                             (format nil "Closing ~:D sockets left in pool" 
                                     (hash-table-count *connection-pool*))
                             :connection-pool *connection-pool*)
              (loop for socket in *connection-pool*
                 do (ignore-errors
                      (socket-close socket))))))))))



(defun start-server/websockets (address port)
  "Note, we'll need COTS (Cross-Origin) headers. TODO all over the place.
"(todo))

(defun connect-to-mq ()
  (todo))



(defgeneric convert-packet (data from to))

(defmethod convert-packet (data (from (eql :json)) (to (eql :mq)))
  (todo))
(defmethod convert-packet (data (from (eql :json)) (to (eql :bson)))
  (todo))
(defmethod convert-packet (data (from (eql :json)) (to (eql :sexp)))
  (todo))

(defmethod convert-packet (data (from (eql :bson)) (to (eql :mq)))
  (todo))
(defmethod convert-packet (data (from (eql :bson)) (to (eql :json)))
(todo))
(defmethod convert-packet (data (from (eql :bson)) (to (eql :sexp)))
(todo))

(defmethod convert-packet (data (from (eql :mq)) (to (eql :json)))
(todo))
(defmethod convert-packet (data (from (eql :mq)) (to (eql :bson)))
(todo))
(defmethod convert-packet (data (from (eql :mq)) (to (eql :sexp)))
(todo))

(defmethod convert-packet (data (from (eql :sexp)) (to (eql :mq)))
(todo))
(defmethod convert-packet (data (from (eql :sexp)) (to (eql :bson)))
(todo))
(defmethod convert-packet (data (from (eql :sexp)) (to (eql :json)))
(todo))

(defmethod convert-package (data (from (eql :json)) (to (eql :json))) data)
(defmethod convert-package (data (from (eql :bson)) (to (eql :bson))) data)
(defmethod convert-package (data (from (eql :mq)) (to (eql :mq))) data)
(defmethod convert-package (data (from (eql :sexp)) (to (eql :sexp))) data)



(defun get-quality-of-service ()
  (todo))

(defun connection-pool-moderation ()
  "when one guy's getting too many connections and another one is light,
alter the usual round-robin selection to balance the load"
(todo))

(defun migration-things-todo ()
  "when bringing up/down Appius nodes, migrate users around to balance
the load"
  (todo))


(defun start-server (argv)
  (romance:server-start-banner "Appius" "Appius Claudius Cæcus"
                               "Network communications server")
  (caesar::report :debug (format nil "Ignoring ARGV: ~S" argv))
  ;;  (start-server/socket-activation)
  (start-server/tcp-listener)
  (format t "~&Appius Claudius Cæcus: Done. Bye!~%"))
