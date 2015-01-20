(in-package :clodia)

(defclass mind-part () ())
(defclass consciousness (mind-part) ())
(defclass unconsciousness (mind-part) ())

(defclass mind ()
  ((consciousness :reader conscious
                  :initform (make-instance 'consciousness) :initarg :conscious)
   (unconsciousness :reader unconscious
                    :initform (make-instance 'unconsciousness) :initarg :unconscious)))

(defmethod print-object ((mind mind) s)
  (format s "#<MIND: can't print myself yet, FIXME!>"))

