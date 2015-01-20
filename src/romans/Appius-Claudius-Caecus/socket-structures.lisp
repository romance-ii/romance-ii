(in-package :appius)

(defclass socket-info ()
  ((socket :type socket :reader socket-info-socket
           :initarg :socket)
   (stream :type stream :reader socket-info-stream
           :initform (socket-stream socket))
   (authentication :accessor socket-info-authentication :initform nil)
   (state :accessor socket-info-state :initform :pre-login)
   (encoding :type symbol :accessor socket-info-encoding
             :initform :cons :initarg :encoding)
   (min-version :type number :accessor socket-info-min-version 
                :initform 0 :initarg :min-version)
   (max-version :type number :accessor socket-info-max-version 
                :initform 0 :initarg :max-version)))

(defun socket-info-accept-version-p (info version)
  (check-type info socket-info)
  (check-type version number)
  (<= (socket-info-min-version info) version (socket-info-max-version info)))

(defmethod print-object (stream (info socket-info))
  (format stream "#< Socket: ~A
  Stream: ~A
  Authentication: ~A
  State: ~A; Encoding: ~A
  Version range: ~:D to ~:D  >"
          (socket-info-socket info)
          (socket-info-stream info)
          (socket-info-authentication info)
          (socket-info-state info)
          (socket-info-encoding info)
          (socket-info-min-version info)
          (socket-info-max-version info)))
