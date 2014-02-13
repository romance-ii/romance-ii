(in-package :bullet)

(defgeneric param (thing num &optional axis))
(defgeneric (setf param) (thing num value &optional axis))

(declaim (inline #.(lispify "btTypedConstraint_setParam" 'function)))
(cffi:defcfun ("_wrap_btTypedConstraint_setParam__SWIG_0"
               #.(lispify "btTypedConstraint_setParam_withAxis" 'function)) :void
  (self :pointer)
  (num :int)
  (value :float)
  (axis :int))

(declaim (inline #.(lispify "btTypedConstraint_setParam_withoutAxis" 'function)))
(cffi:defcfun ("_wrap_btTypedConstraint_setParam__SWIG_1"
               #.(lispify "btTypedConstraint_setParam_withoutAxis" 'function)) :void
  (self :pointer)
  (num :int)
  (value :float))

(declaim (inline #.(lispify "btTypedConstraint_getParam_withoutAxis" 'function)))
(cffi:defcfun ("_wrap_btTypedConstraint_getParam__SWIG_0"
               #.(lispify "btTypedConstraint_getParam_withAxis" 'function)) :float
  (self :pointer)
  (num :int)
  (axis :int))

(declaim (inline #.(lispify "btTypedConstraint_getParam_withoutAxis" 'function)))
(cffi:defcfun ("_wrap_btTypedConstraint_getParam__SWIG_1"
               #.(lispify "btTypedConstraint_getParam_withoutAxis" 'function)) :float
  (self :pointer)
  (num :int))

(declaim (inline #.(lispify "btPoint2PointConstraint_setParam_withoutAxis" 'function)))
(cffi:defcfun ("_wrap_btPoint2PointConstraint_setParam__SWIG_0"
               #.(lispify "btPoint2PointConstraint_setParam_withAxis" 'function)) :void
  (self :pointer)
  (num :int)
  (value :float)
  (axis :int))

(declaim (inline #.(lispify "btPoint2PointConstraint_setParam_withoutAxis" 'function)))
(cffi:defcfun ("_wrap_btPoint2PointConstraint_setParam__SWIG_1"
               #.(lispify "btPoint2PointConstraint_setParam_withoutAxis" 'function)) :void
  (self :pointer)
  (num :int)
  (value :float))

(declaim (inline #.(lispify "btPoint2PointConstraint_getParam_withoutAxis" 'function)))
(cffi:defcfun ("_wrap_btPoint2PointConstraint_getParam__SWIG_0"
               #.(lispify "btPoint2PointConstraint_getParam_withAxis" 'function)) :float
  (self :pointer)
  (num :int)
  (axis :int))

(declaim (inline #.(lispify "btPoint2PointConstraint_getParam_withoutAxis" 'function)))
(cffi:defcfun ("_wrap_btPoint2PointConstraint_getParam__SWIG_1"
               #.(lispify "btPoint2PointConstraint_getParam_withoutAxis" 'function)) :float
  (self :pointer)
  (num :int))

(declaim (inline #.(lispify "btHingeConstraint_setParam_withoutAxis" 'function)))
(cffi:defcfun ("_wrap_btHingeConstraint_setParam__SWIG_0"
               #.(lispify "btHingeConstraint_setParam_withAxis" 'function)) :void
  (self :pointer)
  (num :int)
  (value :float)
  (axis :int))

(declaim (inline #.(lispify "btHingeConstraint_setParam_withoutAxis" 'function)))
(cffi:defcfun ("_wrap_btHingeConstraint_setParam__SWIG_1"
               HINGE-CONSTRAINT/SET-PARAM/without-axis) :void
  (self :pointer)
  (num :int)
  (value :float))

(declaim (inline #.(lispify "btHingeConstraint_getParam_withoutAxis" 'function)))
(cffi:defcfun ("_wrap_btHingeConstraint_getParam__SWIG_0"
               #.(lispify "btHingeConstraint_getParam_withAxis" 'function)) :float
  (self :pointer)
  (num :int)
  (axis :int))

(declaim (inline #.(lispify "btHingeConstraint_getParam_withoutAxis" 'function)))
(cffi:defcfun ("_wrap_btHingeConstraint_getParam__SWIG_1"
               HINGE-CONSTRAINT/GET-PARAM/without-axis) :float
  (self :pointer)
  (num :int))

(declaim (inline #.(lispify "btConeTwistConstraint_setParam_withoutAxis" 'function)))
(cffi:defcfun ("_wrap_btConeTwistConstraint_setParam__SWIG_0"
               #.(lispify "btConeTwistConstraint_setParam_withAxis" 'function)) :void
  (self :pointer)
  (num :int)
  (value :float)
  (axis :int))

(declaim (inline #.(lispify "btConeTwistConstraint_setParam_withoutAxis" 'function)))
(cffi:defcfun ("_wrap_btConeTwistConstraint_setParam__SWIG_1"
               CONE-TWIST-CONSTRAINT/SET-PARAM/without-axis) :void
  (self :pointer)
  (num :int)
  (value :float))

(declaim (inline #.(lispify "btConeTwistConstraint_getParam_withoutAxis" 'function)))
(cffi:defcfun ("_wrap_btConeTwistConstraint_getParam__SWIG_0"
               #.(lispify "btConeTwistConstraint_getParam_withAxis" 'function)) :float
  (self :pointer)
  (num :int)
  (axis :int))

(declaim (inline #.(lispify "btConeTwistConstraint_getParam_withoutAxis" 'function)))
(cffi:defcfun ("_wrap_btConeTwistConstraint_getParam__SWIG_1"
               CONE-TWIST-CONSTRAINT/GET-PARAM/without-axis) :float
  (self :pointer)
  (num :int))

(declaim (inline #.(lispify "btGeneric6DofConstraint_setParam_withoutAxis" 'function)))
(cffi:defcfun ("_wrap_btGeneric6DofConstraint_setParam__SWIG_0"
               #.(lispify "btGeneric6DofConstraint_setParam_withAxis" 'function)) :void
  (self :pointer)
  (num :int)
  (value :float)
  (axis :int))

(declaim (inline #.(lispify "btGeneric6DofConstraint_setParam_withoutAxis" 'function)))
(cffi:defcfun ("_wrap_btGeneric6DofConstraint_setParam__SWIG_1"
               GENERIC-6-DOF-CONSTRAINT/SET-PARAM/without-axis) :void
  (self :pointer)
  (num :int)
  (value :float))

(declaim (inline #.(lispify "btGeneric6DofConstraint_getParam_withoutAxis" 'function)))
(cffi:defcfun ("_wrap_btGeneric6DofConstraint_getParam__SWIG_0"
               #.(lispify "btGeneric6DofConstraint_getParam_withAxis" 'function)) :float
  (self :pointer)
  (num :int)
  (axis :int))

(declaim (inline #.(lispify "btGeneric6DofConstraint_getParam_withoutAxis" 'function)))
(cffi:defcfun ("_wrap_btGeneric6DofConstraint_getParam__SWIG_1"
               GENERIC-6-DOF-CONSTRAINT/GET-PARAM/without-axis) :float
  (self :pointer)
  (num :int))

(declaim (inline #.(lispify "btSliderConstraint_setParam_withoutAxis" 'function)))
(cffi:defcfun ("_wrap_btSliderConstraint_setParam__SWIG_0"
               #.(lispify "btSliderConstraint_setParam_withAxis" 'function)) :void
  (self :pointer)
  (num :int)
  (value :float)
  (axis :int))

(declaim (inline #.(lispify "btSliderConstraint_setParam_withoutAxis" 'function)))
(cffi:defcfun ("_wrap_btSliderConstraint_setParam__SWIG_1"
               SLIDER-CONSTRAINT/SET-PARAM/without-axis) :void
  (self :pointer)
  (num :int)
  (value :float))

(declaim (inline SLIDER-CONSTRAINT/GET-PARAM/with-axis))
(cffi:defcfun ("_wrap_btSliderConstraint_getParam__SWIG_0"
               SLIDER-CONSTRAINT/GET-PARAM/with-axis) :float
  (self :pointer)
  (num :int)
  (axis :int))

(declaim (inline SLIDER-CONSTRAINT/GET-PARAM/without-axis))
(cffi:defcfun ("_wrap_btSliderConstraint_getParam__SWIG_1"
               SLIDER-CONSTRAINT/GET-PARAM/without-axis) :float
  (self :pointer)
  (num :int))

(declaim (inline gear-constraint/set-param/with-axis))
(cffi:defcfun ("_wrap_btGearConstraint_setParam__SWIG_0"
               gear-constraint/set-param/with-axis) :void
  (self :pointer)
  (num :int)
  (value :float)
  (axis :int))

(declaim (inline gear-constraint/set-param/without-axis))
(cffi:defcfun ("_wrap_btGearConstraint_setParam__SWIG_1"
               gear-constraint/set-param/without-axis) :void
  (self :pointer)
  (num :int)
  (value :float))

(declaim (inline gear-constraint/get-param/with-axis))
(cffi:defcfun ("_wrap_btGearConstraint_getParam__SWIG_0" 
               gear-constraint/get-param/with-axis) :float
  (self :pointer)
  (num :int)
  (axis :int))

(declaim (inline gear-constraint/get-param/without-axis))
(cffi:defcfun ("_wrap_btGearConstraint_getParam__SWIG_1"
               gear-constraint/get-param/without-axis) :float
  (self :pointer)
  (num :int))

(declaim (inline FIXED-CONSTRAINT/SET-PARAM/with-axis))
(cffi:defcfun ("_wrap_btFixedConstraint_setParam__SWIG_0"
               FIXED-CONSTRAINT/SET-PARAM/with-axis) :void
  (self :pointer)
  (num :int)
  (value :float)
  (axis :int))

(declaim (inline FIXED-CONSTRAINT/SET-PARAM/without-axis))
(cffi:defcfun ("_wrap_btFixedConstraint_setParam__SWIG_1"
               FIXED-CONSTRAINT/SET-PARAM/without-axis) :void
  (self :pointer)
  (num :int)
  (value :float))

(declaim (inline FIXED-CONSTRAINT/GET-PARAM/with-axis))
(cffi:defcfun ("_wrap_btFixedConstraint_getParam__SWIG_0"
               FIXED-CONSTRAINT/GET-PARAM/with-axis) :float
  (self :pointer)
  (num :int)
  (axis :int))

(declaim (inline FIXED-CONSTRAINT/GET-PARAM/without-axis))
(cffi:defcfun ("_wrap_btFixedConstraint_getParam__SWIG_1"
               FIXED-CONSTRAINT/GET-PARAM/without-axis) :float
  (self :pointer)
  (num :int))

(defmethod (setf param) ((self typed-constraint) (num integer) (value number)
                         &optional (axis nil axis?))  
  (if axis?
      (#.(lispify "btTypedConstraint_setParam_withAxis" 'function) (ff-pointer self) num value axis)
      (#.(lispify "btTypedConstraint_setParam_withoutAxis" 'function) (ff-pointer self) num value)))

(defmethod param ((self #.(lispify "bt-typed-constraint" 'classname)) (num integer) &optional (axis nil axis?))  
  (if axis?
      (#.(lispify "btTypedConstraint_getParam_withAxis" 'function) (ff-pointer self) num axis)
      (#.(lispify "btTypedConstraint_getParam_withoutAxis" 'function) (ff-pointer self) num)))

(defmethod (setf param) ((self point->point-constraint)
                         (num integer) (value number) &optional (axis nil axis?))  
  (if axis?
      (#.(lispify "btPoint2PointConstraint_setParam_withAxis" 'function) (ff-pointer self) num value axis)
      (#.(lispify "btPoint2PointConstraint_setParam_withoutAxis" 'function) (ff-pointer self) num value)))

(defmethod param ((self point->point-constraint) (num integer) &optional (axis nil axis?))  
  (if axis?
      (#.(lispify "btPoint2PointConstraint_getParam_withAxis" 'function) (ff-pointer self) num axis)
      (#.(lispify "btPoint2PointConstraint_getParam_withoutAxis" 'function) (ff-pointer self) num)))

(defmethod (setf param) ((self #.(lispify "bt-hinge-constraint" 'classname)) (num integer) (value number) &optional (axis nil axis?))  
  (if axis?
      (#.(lispify "btHingeConstraint_setParam_withAxis" 'function) (ff-pointer self) num value axis)
      (#.(lispify "btHingeConstraint_setParam_withoutAxis" 'function) (ff-pointer self) num value)))

(defmethod param ((self #.(lispify "bt-hinge-constraint" 'classname)) (num integer) &optional (axis nil axis?))  
  (if axis?
      (#.(lispify "btHingeConstraint_getParam_withAxis" 'function) (ff-pointer self) num axis)
      (#.(lispify "btHingeConstraint_getParam_withoutAxis" 'function) (ff-pointer self) num)))

(defmethod (setf param) ((self #.(lispify "bt-cone-twist-constraint" 'classname)) (num integer) (value number) &optional (axis nil axis?))  
  (if axis?
      (#.(lispify "btConeTwistConstraint_setParam_withAxis" 'function) (ff-pointer self) num value axis)
      (#.(lispify "btConeTwistConstraint_setParam_withoutAxis" 'function) (ff-pointer self) num value)))

(defmethod param ((self #.(lispify "bt-cone-twist-constraint" 'classname)) (num integer) &optional (axis nil axis?))  
  (if axis?
      (#.(lispify "btConeTwistConstraint_getParam_withAxis" 'function) (ff-pointer self) num axis)
      (#.(lispify "btConeTwistConstraint_getParam_withoutAxis" 'function) (ff-pointer self) num)))

(defmethod (setf param) ((self #.(lispify "bt-generic6-dof-constraint" 'classname)) (num integer) (value number) &optional (axis nil axis?))  
  (if axis?
      (#.(lispify "btGeneric6DofConstraint_setParam_withAxis" 'function) (ff-pointer self) num value axis)
      (#.(lispify "btGeneric6DofConstraint_setParam_withoutAxis" 'function) (ff-pointer self) num value)))

(defmethod param ((self #.(lispify "bt-generic6-dof-constraint" 'classname)) (num integer) &optional (axis nil axis?))  
  (if axis?
      (#.(lispify "btGeneric6DofConstraint_getParam_withAxis" 'function) (ff-pointer self) num axis)
      (#.(lispify "btGeneric6DofConstraint_getParam_withoutAxis" 'function) (ff-pointer self) num)))

(defmethod (setf param) ((self #.(lispify "bt-slider-constraint" 'classname)) (num integer) (value number) &optional (axis nil axis?))  
  (if axis?
      (#.(lispify "btSliderConstraint_setParam_withAxis" 'function) (ff-pointer self) num value axis)
      (#.(lispify "btSliderConstraint_setParam_withoutAxis" 'function) (ff-pointer self) num value)))

(defmethod param ((self #.(lispify "bt-slider-constraint" 'classname)) (num integer) &optional (axis nil axis?))  
  (if axis?
      (#.(lispify "btSliderConstraint_getParam_withAxis" 'function) (ff-pointer self) num axis)
      (#.(lispify "btSliderConstraint_getParam_withoutAxis" 'function) (ff-pointer self) num)))

(defmethod (setf param) ((self #.(lispify "bt-gear-constraint" 'classname)) (num integer) (value number) &optional (axis nil axis?))  
  (if axis?
      (#.(lispify "btGearConstraint_setParam_withAxis" 'function) (ff-pointer self) num value axis)
      (#.(lispify "btGearConstraint_setParam_withoutAxis" 'function) (ff-pointer self) num value)))

(defmethod param ((self #.(lispify "bt-gear-constraint" 'classname)) (num integer) &optional (axis nil axis?))  
  (if axis?
      (#.(lispify "btGearConstraint_getParam_withAxis" 'function) (ff-pointer self) num axis)
      (#.(lispify "btGearConstraint_getParam_withoutAxis" 'function) (ff-pointer self) num)))

(defmethod (setf param) ((self #.(lispify "bt-fixed-constraint" 'classname)) (num integer) (value number) &optional (axis nil axis?))
  (if axis?
      (#.(lispify "btFixedConstraint_setParam_withAxis" 'function) (ff-pointer self) num value axis)
      (#.(lispify "btFixedConstraint_setParam_withoutAxis" 'function) (ff-pointer self) num value)))

(defmethod param ((self #.(lispify "bt-fixed-constraint" 'classname)) (num integer) &optional (axis nil axis?))  
  (if axis?
      (#.(lispify "btFixedConstraint_getParam_withAxis" 'function) (ff-pointer self) num axis)
   (#.(lispify "btFixedConstraint_getParam_withoutAxis" 'function) (ff-pointer self) num)))

