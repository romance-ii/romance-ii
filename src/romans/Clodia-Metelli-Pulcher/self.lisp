(in-package :clodia)

(defclass mind () ())

(defmethod print-object ((mind mind) s)
  (format s "#<MIND: can't print myself yet, FIXME!>"))

