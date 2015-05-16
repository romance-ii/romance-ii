(in-package :rahab)

(defun emacs-popup (message &rest args)
  (swank:eval-in-emacs 
   `(let ((last-nonmenu-event nil)
          (use-dialog-box t))
      (message-box ,(apply #'format nil message args)))))

(defun emacs-y-or-n-p (message &rest args)
  (swank:eval-in-emacs 
   `(let ((last-nonmenu-event nil)
          (use-dialog-box t))
      (y-or-n-p ,(apply #'format nil message args)))))

(defun emacs-y-or-n-p-with-timeout (timeout default message &rest args)
  (swank:eval-in-emacs 
   `(let ((last-nonmenu-event nil)
          (use-dialog-box t))
      (y-or-n-p-with-timeout ,(apply #'format nil message args)
                             ,timeout ,default))))

(defvar *ui-mode* :query-io)

(defun alert (message &rest args)
  (ecase *ui-mode*
    (:emacs (apply #'emacs-popup message args))
    (:query-io (fresh-line)
               (format *query-io* " ☠ ~:(~a~) says ☠" (or caesar:*module*
                                                          "An unknown module"))
               (apply #'format *query-io* message args)
               (finish-output *query-io*))))

(defun ask-y-or-n-p (message &rest args)
  (ecase *ui-mode*
    (:emacs (apply #'emacs-y-or-n-p message args))
    (:query-io (fresh-line)
               (format *query-io* " ☠ ~:(~a~) asks ☠" (or caesar:*module*
                                                          "An unknown module"))
               (finish-output *query-io*)
               (apply #'y-or-n-p *query-io* message args))))



(defclass trace-output-stream (fundamental-character-output-stream)
  ((trace-buffer :initform (make-array 100
                                       :element-type 'character
                                       :adjustable t
                                       :fill-pointer 0)
                 :type 'string
                 :accessor trace-output-stream-buffer)
   (flush-function :initform #'alert
                   :initarg :flush-to
                   :accessor trace-output-stream-flush-function
                   :documentation "This is the function called to display output.")))

(defmethod stream-write-char ((stream trace-output-stream) (char character))
  (vector-push-extend char (trace-output-stream-buffer stream))
  (when (eql char #\page)
    (finish-output stream)))

(defmethod stream-finish-output ((stream trace-output-stream))
  (let ((to-print (copy-sequence 'string (trace-output-stream-buffer stream))))
    (setf (fill-pointer (trace-output-stream-buffer stream)) 0)
    (when (plusp (length to-print))
      (funcall (trace-output-stream-flush-function stream) to-print)
      to-print)))


(defclass query-io-stream (fundamental-character-stream)
  ((output-buffer :initform (make-array 100
                                        :element-type 'character
                                        :adjustable t
                                        :fill-pointer 0)
                  :type 'string
                  :accessor query-io-stream-output-buffer)
   (flush-function :initform #'prompt
                   :initarg :flush-to
                   :accessor query-io-stream-flush-function
                   :documentation "This is the function called to display output.")))

(defmethod stream-write-char ((stream trace-output-stream) (char character))
  (vector-push-extend char (trace-output-stream-buffer stream))
  (when (eql char #\page)
    (finish-output stream)))

(defmethod stream-finish-output ((stream trace-output-stream))
  (let ((to-print (copy-sequence 'string (trace-output-stream-buffer stream))))
    (setf (fill-pointer (trace-output-stream-buffer stream)) 0)
    (when (plusp (length to-print))
      (funcall (trace-output-stream-flush-function stream) to-print)
      to-print)))


(defun spy (&rest args)
  (caesar:with-oversight (rahab)
    (let ((*ui-mode* (cond
                       ((swank:connection-info) :emacs)
                       (t :query-io)))
          (*trace-output* (make-instance 'trace-output-stream))
          (*standard-output* (make-instance 'trace-output-stream))
          (*error-output* (make-instance 'trace-output-stream)))
      (fresh-line *query-io*)
      (format *query-io* (romans::greeting-tod))
      (format *query-io* "~&SPY called with ~s" args)
      (format *query-io* "~&Good-bye. Rahab away."))))

