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

(defmethod serve ((socket stream-server-usocket))
  "Accept a new connection"
  (let* ((accepted (socket-accept socket))
         (info (make-instance 'socket-info
                              :socket accepted)))
    (setf (gethash *connection-pool* accepted) info))
  (format t "~&TODO QoS and logging; but, I got a connection"))

(defgeneric serve-socket (stream encoding state socket info))

(defmethod serve ((socket stream-usocket))
  (let ((info (gethash *connection-pool* socket)))
    (serve-socket (socket-info-stream info)
                  (socket-info-encoding info)
                  (socket-info-state info)
                  socket info)))

(define-condition protocol-unhandled-error (error)
  (socket-info)
  (:report "no handler for this socket state: ~A"))

(defmethod serve-socket ((stream t) (encoding t) (state t)
                         (socket t) (info t))
  (error 'protocol-unhandled-error :socket-info))

(defparameter $reaper-cycles$ 40)

(defun send-server-message (code)
  "Send the server message with the given code to the client."
  (format (socket-stream *selected-socket*)
          "~C~CSERVER MESSAGE CODE ~S~%~C"
          (code-char 3) (code-char 0) code (code-char 4))
  (todo))

(defvar *connection-pool* nil)

(defun server-listen ()
  (restart-case
      (handler-case
          (serve *selected-socket*)
        (end-of-file (c)
          (when (typep *selected-socket* 'stream-server-usocket)
            (error 'listener-disconnected
                   :caused-by c))
          (invoke-restart 'disconnected c)))
    (disconnect-politely (note)
      ;; TODO QoS
      (when note (send-server-message note))
      (send-server-message :disconnecting)
      (invoke-restart 'disconnected note))
    (disconnected (c)
      (declare (ignore c))
      ;; TODO QoS
      (socket-close *selected-socket*)
      (remhash *selected-socket* *socket-accumulators*)
      (removef *connection-pool* *selected-socket*))))

(defun start-server/tcp-listener (&optional (address *wildcard-host*)
                                    (port 2770))
  "Start listening at the given address and port. Defaults to universal (all local addresses) and port 2770."
  (loop
     with listener = (socket-listen address port
                                    :reuse-address t
                                    :backlog #x100)
     with *connection-pool* = (list listener)
     with cycler = 0
     for *selected-socket*
     ;; return only ready sockets for 39 cycles, but return them all
     ;; on the 40. This means that, combined with the timeout, we
     ;; will wait at most 20 seconds to notice a dead connection â€”
     ;; and probably far less time.
     in (wait-for-input *connection-pool*
                        :timeout 1/2    ;sec
                        :ready-only (not (modincf cycler $reaper-cycles$)))
     until *server-quit*
     do (server-listen)))

(defun start-server/websockets (address port)
  "Note, we'll need COTS (Cross-Origin) headers. TODO all over the place.
"
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
  (format t "~&Appius Claudius Cæcus: Done. Bye!~%"))
