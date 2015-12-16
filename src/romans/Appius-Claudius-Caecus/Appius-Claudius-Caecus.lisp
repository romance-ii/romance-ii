(in-package :appius)

(defun start-server/socket-activation (socket)
  "working with SystemD for TCP streams (and WebSockets streams as well?)"
  (declare (ignore socket))
  (todo))

(defvar *server-quit* nil
  "Set to true to abort the server on a request from Caesar")

(defvar *selected-socket* nil
  "When in context of a connection, the socket currently
  beign considered.")

(defgeneric serve (socket))

(define-condition tcp-connection-accepted (condition)
  ((socket-info :initarg :socket-info :reader connection-socket-info)))

(defvar *connection-pool* (make-hash-table)
  "The set of all connected sockets. The keys to the hash table are the
  socket objects; the values are socket-info objects providing
  their details.")

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
    (restart-bind
        ((continue
           #'values
           :report-function 
           (lambda (s) 
             (princ "Skip this socket, and continue handling others" s))))
      (serve-socket (socket-info-stream info)
                    (socket-info-encoding info)
                    (socket-info-state info)
                    socket info))))

(define-condition protocol-unhandled-error (error)
  ((socket-info :initarg :socket-info :reader error-socket-info))
  (:report (lambda (c s)
             (format s "no handler for this socket state: ~A"
                     (socket-info-state (error-socket-info c))))))

(defmethod serve-socket ((stream t) (encoding t) (state t)
                         (socket t) (info t))
  (error 'protocol-unhandled-error :socket-info info))

(defparameter $reaper-cycles$ 40)

(defun send-server-message (code)
  "Send the server message with the given code to the client."
  (format (socket-stream *selected-socket*)
          "~C~CSERVER MESSAGE CODE ~S~%~C"
          (code-char 3) (code-char 0) code (code-char 4)))

(defun send-raw (socket-info format &rest args)
  (check-type socket-info socket-info)
  (check-type format string)
  (format (socket-stream
           (socket-info-socket socket-info)) format args))

(defgeneric send-message (socket-stream encoding structure)
  (:method ((socket-stream stream) (encoding t) (structure t))
    (warn "No send-message for socket-stream ~s, encoding ~s"
          socket-stream encoding)
    (format socket-stream "~s" structure))
  (:method ((socket-stream t) (encoding t) (structure t))
    (error "No send-message for socket-stream ~s"
           socket-stream)))

(defvar *selected-socket*)

(defun end-of-file-handler (condition)
  (when (typep *selected-socket* 'stream-server-usocket)
    (error 'listener-disconnected
           :caused-by condition))
  (invoke-restart 'disconnected condition))

(define-condition socket-disconnect-polite-hook (condition) ())
(define-condition socket-disconnect-hook (condition) ())

(defun socket-to-client-p (&optional (socket *selected-socket*))
  (and (typep socket 'usocket:stream-usocket)
       (not (typep socket 'usocket:stream-server-usocket))))

(defun socket-polite-disconnect 
    (&optional (note 
                "Disconnection request from server"))
  ;; TODO QoS
  (when (and note
             (socket-to-client-p)) 
    (send-server-message note))
  (send-server-message :disconnecting)
  (signal 'socket-disconnect-polite-hook)
  (caesar::report :polite-disconnect (strcat "Note: " note)
                  :socket *selected-socket*)
  (invoke-restart 'disconnected note))

(defun socket-disconnected (&optional (socket *selected-socket*))
  ;; TODO QoS
  (signal 'socket-disconnect-hook)
  (caesar::report :disconnected "Socket disconnecting"
                  :socket socket)
  (handler-case
      (socket-close socket)
    (error (err)
      (warn err)))
  ;;(remhash socket *socket-accumulators*)
  (remhash socket *connection-pool*))

(defun server-listen ()
  (restart-bind
      ((disconnect-politely #'socket-polite-disconnect
         :report-function (lambda (s)
                            (princ "Politely disconnect socket" s))
         :test-function (lambda (c)
                          (declare (ignore c))
                          *selected-socket*))
       (disconnect-politely-from-operator
        (lambda ()
          (socket-polite-disconnect "Disconnected by operator action"))
         :report-function (lambda (s)
                            (princ "Politely disconnect socket (with generic operator message)" s))
         :test-function (lambda (c)
                          (declare (ignore c))
                          *selected-socket*))
       (disconnect-politely-with-note
        (lambda (note)
          (socket-polite-disconnect note))
         :report-function (lambda (s)
                            (princ "Politely disconnect socket with a note" s))
         :test-function (lambda (c)
                          (declare (ignore c))
                          *selected-socket*)
         :interactive-function
         (lambda ()
           (format *query-io* "~& Enter a message to send with the disconnection (may be visible to the end-user)
⇒ ")
           (list (read *query-io*))))
       (disconnected #'socket-disconnected
         :report-function (lambda (s)
                            (princ "Disconnect socket" s))
         :test-function (lambda (c)
                          (declare (ignore c))
                          *selected-socket*)))
    (handler-case
        (serve *selected-socket*)
      (end-of-file (c) (end-of-file-handler c))
      (usocket:bad-file-descriptor-error (c) (end-of-file-handler c))
      #+sbcl (sb-int:closed-stream-error (c) (end-of-file-handler c)))))


(define-condition tcp-pre-listen-hook (condition)
  ((address :initarg :address :reader ip-address)
   (port :initarg :port :reader tcp-port)))

(define-condition tcp-unwinding-hook (condition)
  ((connection-pool :initarg :connection-pool :reader connection-pool)))

(defun remove-closed-socket-from-pool (closed-stream-error)
  (when-let (stream (stream-error-stream closed-stream-error))
    (remhash stream *connection-pool*)))

(defun advertise-cluster-endpoint (address port)
  (todo "advertise-cluster-endpoint"))

(defun main-socket-loop (cycler)
  (loop
     until *server-quit*
     do (loop
           for *selected-socket*
           in (wait-for-input (hash-table-keys *connection-pool*)
                              :timeout 1/2 ;sec
                              :ready-only (funcall cycler))
           do (server-listen))))

(defun unwind-from-tcp-server ()
  (caesar:report :stopped-listening
                 "Stopped listening"
                 :connection-pool *connection-pool*)
  (signal 'tcp-unwinding-hook :connection-pool *connection-pool*)
  (when (and *connection-pool*
             (plusp (hash-table-count *connection-pool*)))
    (caesar:report :left-over-connections
                   (format nil "Closing ~:D sockets left in pool"
                           (hash-table-count *connection-pool*))
                   :connection-pool *connection-pool*)
    (loop for socket being each hash-key in *connection-pool*
       do (socket-disconnected socket))))

(defmacro with-tcp-restarts (() &body body)
  `(restart-bind
       
       ((use-other-interface
         (lambda (address)
           (start-server/tcp-listener address port))
          :report-function
          (lambda (s)
            (princ "Listen on another interface" s))
          :interactive-function
          (lambda ()
            (format *query-io* "~&Enter the address of the interface on which to listen

\(~S for all interfaces) ⇒ "
                    *wildcard-host*)
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
            (format *query-io* "~&Enter the port number on which to listen:

 \(Default is 2770) ⇒ ")
            (list (read *query-io*)))
          :test-function
          (lambda (c)
            (typep c 'address-in-use-error))))
     ,@body))

(defun prepare-to-listen/tcp (address port)
  (caesar::report :begin-listening
                  (format nil "Listening for TCP connections on ~{~d.~d.~d.~d~} port ~S"
                          (coerce address 'list) port))
  (signal 'tcp-pre-listen-hook :address address :port port))

(defun tcp-server (address port cycler)
  (let ((listener (socket-listen address port
                                 :reuse-address t
                                 :backlog #x20)))
    (setf (gethash listener *connection-pool*)
          (make-instance 'socket-info :socket listener
                         :encoding :tcp-listen))
    (advertise-cluster-endpoint address port)

    (handler-case
        (main-socket-loop cycler)
      #+sbcl (sb-int:closed-stream-error (c)
               (remove-closed-socket-from-pool c)))))

(defun start-server/tcp-listener (&optional (address *wildcard-host*)
                                    (port 2770))
  "Start listening at the given address and port. Defaults to
universal (all local addresses) and port 2770."
  (check-type port (integer 1024 65535) "Valid TCP port number")
  (caesar:with-oversight (appius/tcp-server)
    (with-tcp-restarts ()
      (prepare-to-listen/tcp address port)
      (let ((cycler  (make-t-every-n-times $reaper-cycles$)))
        (unwind-protect
             (tcp-server address port cycler)
          (unwind-from-tcp-server))))))



(defun start-server/websockets (address port)
  "Note, we'll need COTS (Cross-Origin) headers. TODO all over the place."
  (declare (ignore address port))
  (todo))

(defun connect-to-mq ()
  (todo))



(defgeneric convert-packet (data from to))

(defmethod convert-packet (data (from (eql :json)) (to (eql :mq)))
  (todo))
(defmethod convert-packet (data (from (eql :json)) (to (eql :bson)))
  (todo))
(defmethod convert-packet (data (from (eql :json)) (to (eql :sexp)))
  (todo))
(defmethod convert-packet (data (from (eql :json)) (to (eql :edn)))
  (todo))

(defmethod convert-packet (data (from (eql :bson)) (to (eql :mq)))
  (todo))
(defmethod convert-packet (data (from (eql :bson)) (to (eql :json)))
  (todo))
(defmethod convert-packet (data (from (eql :bson)) (to (eql :sexp)))
  (todo))
(defmethod convert-packet (data (from (eql :bson)) (to (eql :edn)))
  (todo))

(defmethod convert-packet (data (from (eql :mq)) (to (eql :json)))
  (todo))
(defmethod convert-packet (data (from (eql :mq)) (to (eql :bson)))
  (todo))
(defmethod convert-packet (data (from (eql :mq)) (to (eql :sexp)))
  (todo))
(defmethod convert-packet (data (from (eql :mq)) (to (eql :edn)))
  (todo))

(defmethod convert-packet (data (from (eql :sexp)) (to (eql :mq)))
  (todo))
(defmethod convert-packet (data (from (eql :sexp)) (to (eql :bson)))
  (todo))
(defmethod convert-packet (data (from (eql :sexp)) (to (eql :json)))
  (todo))
(defmethod convert-packet (data (from (eql :sexp)) (to (eql :edn)))
  (todo))

(defmethod convert-packet (data (from (eql :edn)) (to (eql :mq)))
  (todo))
(defmethod convert-packet (data (from (eql :edn)) (to (eql :bson)))
  (todo))
(defmethod convert-packet (data (from (eql :edn)) (to (eql :json)))
  (todo))
(defmethod convert-packet (data (from (eql :edn)) (to (eql :sexp)))
  (todo))

(defmethod convert-packet (data (from (eql :json)) (to (eql :json)))
  data)
(defmethod convert-packet (data (from (eql :bson)) (to (eql :bson)))
  data)
(defmethod convert-packet (data (from (eql :mq)) (to (eql :mq)))
  data)
(defmethod convert-packet (data (from (eql :sexp)) (to (eql :sexp)))
  data)
(defmethod convert-packet (data (from (eql :edn)) (to (eql :edn)))
  data)



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
