(defpackage :appius
  (:use :cl :alexandria :usocket)
  (:nicknames :appius-claudius-caecus :appius-claudius-cæcus)
  (:documentation
   "Appius Claudius Caecus handles network I/O. All socket connections
from clients are routed through Appius, and into the message queues
for the game itself.

Appius Claudius Caecus was notable for building a major road out of
Rome, the Appian Way, as well as being blind, and twice Consul.")
  (:export #:start-server))

(in-package :appius)

(define-condition todo ()
  ((whinge)))

(defmacro todo (&rest whinge)
  `(restart-case
       (error 'todo ,@whinge)
     (return-nil () nil)
     (return-t () t)
     (return-value (value) value)))

(defun start-server/socket-activation (socket)
  "working with SystemD for TCP streams (and WebSockets streams as well?)"
  (todo))

(defvar *server-quit* nil
  "Set to true to abort the server on a request from Caesar")

(defvar *socket-accumulators* (make-hash-table :test 'equal)
  "Stream sockets gather their data here until they acquire
  a packet.")

(defconstant +accumulator-limit+ #xfff)

(defun make-new-accumulator ()
  "Create a socket accumulator"
  (list :buffer (make-array 1 :element-type 'character
                            :initial-element (code-char 0)
                            :adjustable t
                            :fill-pointer t)
        :mode :text))

(defun accumulator-for-socket (socket)
  (if-let ((accum (gethash socket *socket-accumulators* nil)))
    accum
    (setf (gethash socket *socket-accumulators*)
          (make-new-accumulator))))

(defgeneric pop-from-buffer (indicator buffer))
(defmethod pop-from-buffer ((indicator (eql :bson)) buffer)
  (todo))
(defmethod pop-from-buffer ((indicator (eql #\{)) buffer)
  (todo))
(defmethod pop-from-buffer ((indicator (eql #\()) buffer)
  (todo))

(defun shift-buffer-start (buffer shift)
  (cond
    ((plusp shift)
     '(copy-array :fixme))
    ((minusp shift)
     '(copy-array :fixme))))

(defun find-whitespace (buffer)
  (loop for i from 0 to (fill-pointer buffer)
     when (member (aref buffer i)
                  '(#\Space #\Tab #\Return #\Linefeed #\Newline
                    #\Formfeed))
     return i))

(defmethod pop-from-buffer ((indicator t) buffer)
  (restart-case
      (error 'input-format-indicator-invalid
             "unrecognized format indicator ~S" indicator)
    (skip-bytes (n)
      (shift-buffer-start buffer (or n 1)))
    (skip-to-whitespace ()
      (shift-buffer-start buffer (find-whitespace buffer)))
    (skip-to-nul ()
      (shift-buffer-start buffer (find 0 buffer)))))

(defvar *selected-socket* nil
  "When in context of a connection, the socket currently
  beign considered.")

(defgeneric tcp-serve (socket))
(defmethod tcp-serve ((socket stream-server-usocket))
  "Accept a new connection"
  (push (socket-accept socket) *connection-pool*)
  (format t "~&TODO QoS and logging but I got one"))
(defmethod tcp-serve ((socket stream-usocket)
                      &aux
                        (stream (socket-stream socket))
                        (accum (accumulator-for-socket socket))
                        (buffer (getf accum :buffer)))
  (let ((read-chars
         (read-sequence buffer stream :start (fill-pointer buffer)
                        :end +accumulator-limit+))
        (*selected-socket* socket))
    (incf (fill-pointer buffer) read-chars)
    (let ((mode (getf accum :mode)))
      (if (eql :text mode)
          (pop-from-buffer (aref buffer 0) buffer)
          (pop-from-buffer mode buffer)))))

(defmacro modincf (place base)
  "Increment a setf'able place, and return true whenever it wraps
around modulo base.

Put in a more sane way: return true every `base' times it is called
with the same `place'"
  `(= 0 (setf ,place (mod (1+ ,place) ,base))))

(defparameter $reaper-cycles$ 40)

(defun send-server-message (code)
  "Send the server message with the given code to the client."
  (format (socket-stream *selected-socket*)
          " SERVER MESSAGE CODE ~S~%" code)
  (todo))

(defvar *connection-pool* (list))

(defun tcp-server-listen ()
  (restart-case
      (handler-case
          (tcp-serve *selected-socket*)
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
     ;; on the 40°. This means that, combined with the timeout, we
     ;; will wait at most 20 seconds to notice a dead connection —
     ;; and probably far less time.
     in (wait-for-input *connection-pool*
                        :timeout 1/2    ;sec
                        :ready-only (not (modincf cycler $reaper-cycles$)))
     until *server-quit*
     do (tcp-server-listen)))

(defun start-server/websockets (address port)
  "how to listen? native listener seems best, is that Kosher with
same-origin policy?

if not, how do we tie in to the HTTP server enough to make
same-origin happy? serve the live HTML from the chat servers?

some experimentation will be required for this bit" (todo))

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
  (romance:server-start-banner "Appius" "Appius Claudius Cæcus" "Network communications server")
  (format t "~&Appius Claudius Cæcus: Done. Bye!~%"))


