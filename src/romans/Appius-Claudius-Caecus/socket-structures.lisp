(in-package :appius)

(defclass socket-info ()
  ((socket :type socket :reader socket-info-socket
           :initarg :socket :initform (error 'required-argument))
   (stream :type stream :reader socket-info-stream)
   (authentication :accessor socket-info-authentication :initform nil)
   (state :accessor socket-info-state :initform :pre-login)
   (encoding :type symbol :accessor socket-info-encoding
             :initform :cons :initarg :encoding)
   (min-version :type (or nil number) :accessor socket-info-min-version 
                :initform nil :initarg :min-version)
   (max-version :type (or nil number) :accessor socket-info-max-version 
                :initform nil :initarg :max-version)))

(defmethod initialize-instance :after ((socket-info socket-info) 
                                       &key &allow-other-keys)
  (let ((socket (socket-info-socket socket-info)))
    (unless (typep socket 'stream-server-usocket)
      (setf (slot-value socket-info 'stream) 
            (socket-stream socket)))))

(defun socket-info-accept-version-p (info version)
  (check-type info socket-info)
  (check-type version number)
  (<= (socket-info-min-version info) version (socket-info-max-version info)))

(defmethod print-object ((info socket-info) stream)
  (format stream "#< Socket: ~A
  Stream: ~A
  Authentication: ~A
  State: ~A; Encoding: ~A
  Version range: ~:D to ~:D >"
          (socket-info-socket info)
          (socket-info-stream info)
          (socket-info-authentication info)
          (socket-info-state info)
          (socket-info-encoding info)
          (socket-info-min-version info)
          (socket-info-max-version info)))
