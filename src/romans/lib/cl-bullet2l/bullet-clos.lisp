
(cl:defclass #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)()
  ((ff-pointer :reader ff-pointer)))

(cl:shadow "new")
(cl:defmethod #.(bullet-wrap::swig-lispify "new" 'method) ((self #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) sizeInBytes)
  (#.(bullet-wrap::swig-lispify "btVector3_makeCPlusPlusInstance" 'function) (ff-pointer self) sizeInBytes))

(cl:shadow "delete")
(cl:defmethod #.(bullet-wrap::swig-lispify "delete" 'method) ((self #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) ptr)
  (#.(bullet-wrap::swig-lispify "btVector3_deleteCPlusPlusInstance" 'function) (ff-pointer self) ptr))

(cl:shadow "new")
(cl:defmethod #.(bullet-wrap::swig-lispify "new" 'method) ((self #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) arg1 ptr)
  (#.(bullet-wrap::swig-lispify "btVector3_makeCPlusPlusInstance" 'function) (ff-pointer self) arg1 ptr))

(cl:shadow "delete")
(cl:defmethod #.(bullet-wrap::swig-lispify "delete" 'method) ((self #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) arg1 arg2)
  (#.(bullet-wrap::swig-lispify "btVector3_deleteCPlusPlusInstance" 'function) (ff-pointer self) arg1 arg2))

(cl:shadow "new[]")
(cl:defmethod #.(bullet-wrap::swig-lispify "new[]" 'method) ((self #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) sizeInBytes)
  (#.(bullet-wrap::swig-lispify "btVector3_makeCPlusArray" 'function) (ff-pointer self) sizeInBytes))

(cl:shadow "delete[]")
(cl:defmethod #.(bullet-wrap::swig-lispify "delete[]" 'method) ((self #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) ptr)
  (#.(bullet-wrap::swig-lispify "btVector3_deleteCPlusArray" 'function) (ff-pointer self) ptr))

(cl:shadow "new[]")
(cl:defmethod #.(bullet-wrap::swig-lispify "new[]" 'method) ((self #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) arg1 ptr)
  (#.(bullet-wrap::swig-lispify "btVector3_makeCPlusArray" 'function) (ff-pointer self) arg1 ptr))

(cl:shadow "delete[]")
(cl:defmethod #.(bullet-wrap::swig-lispify "delete[]" 'method) ((self #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) arg1 arg2)
  (#.(bullet-wrap::swig-lispify "btVector3_deleteCPlusArray" 'function) (ff-pointer self) arg1 arg2))

(cl:defmethod (cl:setf #.(bullet-wrap::swig-lispify "m_floats" 'method)) (arg0 (obj #.(bullet-wrap::swig-lispify "bt-vector3" 'class)))
  (#.(bullet-wrap::swig-lispify "btVector3_m_floats_set" 'function) (ff-pointer obj) arg0))

(cl:defmethod #.(bullet-wrap::swig-lispify "m_floats" 'method) ((obj #.(bullet-wrap::swig-lispify "bt-vector3" 'class)))
  (#.(bullet-wrap::swig-lispify "btVector3_m_floats_get" 'function) (ff-pointer obj)))

(cl:defmethod initialize-instance :after ((obj #.(bullet-wrap::swig-lispify "bt-vector3" 'class)) &key)
  (setf (slot-value obj 'ff-pointer) (#.(bullet-wrap::swig-lispify "new_btVector3" 'function))))

(cl:defmethod initialize-instance :after ((obj #.(bullet-wrap::swig-lispify "bt-vector3" 'class)) &key _x _y _z)
  (setf (slot-value obj 'ff-pointer) (#.(bullet-wrap::swig-lispify "new_btVector3" 'function) _x _y _z)))

(cl:shadow "+=")
(cl:defmethod #.(bullet-wrap::swig-lispify "+=" 'method) ((self #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (v #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)))
  (#.(bullet-wrap::swig-lispify "btVector3_increment" 'function) (ff-pointer self) (ff-pointer v)))

(cl:shadow "-=")
(cl:defmethod #.(bullet-wrap::swig-lispify "-=" 'method) ((self #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (v #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)))
  (#.(bullet-wrap::swig-lispify "btVector3_decrement" 'function) (ff-pointer self) (ff-pointer v)))

(cl:shadow "*=")
(cl:defmethod #.(bullet-wrap::swig-lispify "*=" 'method) ((self #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) s)
  (#.(bullet-wrap::swig-lispify "btVector3_multiplyAndAssign" 'function) (ff-pointer self) s))

(cl:shadow "/=")
(cl:defmethod #.(bullet-wrap::swig-lispify "/=" 'method) ((self #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) s)
  (#.(bullet-wrap::swig-lispify "btVector3_divideAndAssign" 'function) (ff-pointer self) s))

(cl:defmethod #.(bullet-wrap::swig-lispify "dot" 'method) ((self #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (v #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)))
  (#.(bullet-wrap::swig-lispify "btVector3_dot" 'function) (ff-pointer self) (ff-pointer v)))

(cl:defmethod #.(bullet-wrap::swig-lispify "length2" 'method) ((self #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)))
  (#.(bullet-wrap::swig-lispify "btVector3_length2" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "length" 'method) ((self #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)))
  (#.(bullet-wrap::swig-lispify "btVector3_length" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "norm" 'method) ((self #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)))
  (#.(bullet-wrap::swig-lispify "btVector3_norm" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "distance2" 'method) ((self #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (v #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)))
  (#.(bullet-wrap::swig-lispify "btVector3_distance2" 'function) (ff-pointer self) (ff-pointer v)))

(cl:defmethod #.(bullet-wrap::swig-lispify "distance" 'method) ((self #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (v #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)))
  (#.(bullet-wrap::swig-lispify "btVector3_distance" 'function) (ff-pointer self) (ff-pointer v)))

(cl:defmethod #.(bullet-wrap::swig-lispify "safe-normalize" 'method) ((self #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)))
  (#.(bullet-wrap::swig-lispify "btVector3_safeNormalize" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "normalize" 'method) ((self #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)))
  (#.(bullet-wrap::swig-lispify "btVector3_normalize" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "normalized" 'method) ((self #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)))
  (#.(bullet-wrap::swig-lispify "btVector3_normalized" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "rotate" 'method) ((self #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (wAxis #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (angle cl:number))
  (#.(bullet-wrap::swig-lispify "btVector3_rotate" 'function) (ff-pointer self) (ff-pointer wAxis) angle))

(cl:defmethod #.(bullet-wrap::swig-lispify "angle" 'method) ((self #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (v #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)))
  (#.(bullet-wrap::swig-lispify "btVector3_angle" 'function) (ff-pointer self) (ff-pointer v)))

(cl:defmethod #.(bullet-wrap::swig-lispify "absolute" 'method) ((self #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)))
  (#.(bullet-wrap::swig-lispify "btVector3_absolute" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "cross" 'method) ((self #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (v #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)))
  (#.(bullet-wrap::swig-lispify "btVector3_cross" 'function) (ff-pointer self) (ff-pointer v)))

(cl:defmethod #.(bullet-wrap::swig-lispify "triple" 'method) ((self #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (v1 #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (v2 #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)))
  (#.(bullet-wrap::swig-lispify "btVector3_triple" 'function) (ff-pointer self) (ff-pointer v1) (ff-pointer v2)))

(cl:defmethod #.(bullet-wrap::swig-lispify "min-axis" 'method) ((self #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)))
  (#.(bullet-wrap::swig-lispify "btVector3_minAxis" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "max-axis" 'method) ((self #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)))
  (#.(bullet-wrap::swig-lispify "btVector3_maxAxis" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "furthest-axis" 'method) ((self #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)))
  (#.(bullet-wrap::swig-lispify "btVector3_furthestAxis" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "closest-axis" 'method) ((self #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)))
  (#.(bullet-wrap::swig-lispify "btVector3_closestAxis" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "set-interpolate3" 'method) ((self #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (v0 #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (v1 #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (rt cl:number))
  (#.(bullet-wrap::swig-lispify "btVector3_setInterpolate3" 'function) (ff-pointer self) (ff-pointer v0) (ff-pointer v1) rt))

(cl:defmethod #.(bullet-wrap::swig-lispify "lerp" 'method) ((self #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (v #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) t-arg2)
  (#.(bullet-wrap::swig-lispify "btVector3_lerp" 'function) (ff-pointer self) (ff-pointer v) t-arg2))

(cl:shadow "*=")
(cl:defmethod #.(bullet-wrap::swig-lispify "*=" 'method) ((self #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (v #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)))
  (#.(bullet-wrap::swig-lispify "btVector3_multiplyAndAssign" 'function) (ff-pointer self) (ff-pointer v)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-x" 'method) ((self #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)))
  (#.(bullet-wrap::swig-lispify "btVector3_getX" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-y" 'method) ((self #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)))
  (#.(bullet-wrap::swig-lispify "btVector3_getY" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-z" 'method) ((self #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)))
  (#.(bullet-wrap::swig-lispify "btVector3_getZ" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "set-x" 'method) ((self #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (_x cl:number))
  (#.(bullet-wrap::swig-lispify "btVector3_setX" 'function) (ff-pointer self) _x))

(cl:defmethod #.(bullet-wrap::swig-lispify "set-y" 'method) ((self #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (_y cl:number))
  (#.(bullet-wrap::swig-lispify "btVector3_setY" 'function) (ff-pointer self) _y))

(cl:defmethod #.(bullet-wrap::swig-lispify "set-z" 'method) ((self #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (_z cl:number))
  (#.(bullet-wrap::swig-lispify "btVector3_setZ" 'function) (ff-pointer self) _z))

(cl:defmethod #.(bullet-wrap::swig-lispify "set-w" 'method) ((self #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (_w cl:number))
  (#.(bullet-wrap::swig-lispify "btVector3_setW" 'function) (ff-pointer self) _w))

(cl:defmethod #.(bullet-wrap::swig-lispify "x" 'method) ((self #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)))
  (#.(bullet-wrap::swig-lispify "btVector3_x" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "y" 'method) ((self #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)))
  (#.(bullet-wrap::swig-lispify "btVector3_y" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "z" 'method) ((self #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)))
  (#.(bullet-wrap::swig-lispify "btVector3_z" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "w" 'method) ((self #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)))
  (#.(bullet-wrap::swig-lispify "btVector3_w" 'function) (ff-pointer self)))

(cl:shadow "==")
(cl:defmethod #.(bullet-wrap::swig-lispify "==" 'method) ((self #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (other #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)))
  (#.(bullet-wrap::swig-lispify "btVector3_isEqual" 'function) (ff-pointer self) (ff-pointer other)))

(cl:shadow "!=")
(cl:defmethod #.(bullet-wrap::swig-lispify "!=" 'method) ((self #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (other #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)))
  (#.(bullet-wrap::swig-lispify "btVector3_notEquals" 'function) (ff-pointer self) (ff-pointer other)))

(cl:defmethod #.(bullet-wrap::swig-lispify "set-max" 'method) ((self #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (other #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)))
  (#.(bullet-wrap::swig-lispify "btVector3_setMax" 'function) (ff-pointer self) (ff-pointer other)))

(cl:defmethod #.(bullet-wrap::swig-lispify "set-min" 'method) ((self #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (other #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)))
  (#.(bullet-wrap::swig-lispify "btVector3_setMin" 'function) (ff-pointer self) (ff-pointer other)))

(cl:defmethod #.(bullet-wrap::swig-lispify "set-value" 'method) ((self #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) _x _y _z)
  (#.(bullet-wrap::swig-lispify "btVector3_setValue" 'function) (ff-pointer self) _x _y _z))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-skew-symmetric-matrix" 'method) ((self #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (v0 #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (v1 #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (v2 #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)))
  (#.(bullet-wrap::swig-lispify "btVector3_getSkewSymmetricMatrix" 'function) (ff-pointer self) (ff-pointer v0) (ff-pointer v1) (ff-pointer v2)))

(cl:defmethod #.(bullet-wrap::swig-lispify "set-zero" 'method) ((self #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)))
  (#.(bullet-wrap::swig-lispify "btVector3_setZero" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "is-zero" 'method) ((self #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)))
  (#.(bullet-wrap::swig-lispify "btVector3_isZero" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "fuzzy-zero" 'method) ((self #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)))
  (#.(bullet-wrap::swig-lispify "btVector3_fuzzyZero" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "serialize" 'method) ((self #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) dataOut)
  (#.(bullet-wrap::swig-lispify "btVector3_serialize" 'function) (ff-pointer self) dataOut))

(cl:defmethod #.(bullet-wrap::swig-lispify "de-serialize" 'method) ((self #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) dataIn)
  (#.(bullet-wrap::swig-lispify "btVector3_deSerialize" 'function) (ff-pointer self) dataIn))

(cl:defmethod #.(bullet-wrap::swig-lispify "serialize-float" 'method) ((self #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) dataOut)
  (#.(bullet-wrap::swig-lispify "btVector3_serializeFloat" 'function) (ff-pointer self) dataOut))

(cl:defmethod #.(bullet-wrap::swig-lispify "de-serialize-float" 'method) ((self #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) dataIn)
  (#.(bullet-wrap::swig-lispify "btVector3_deSerializeFloat" 'function) (ff-pointer self) dataIn))

(cl:defmethod #.(bullet-wrap::swig-lispify "serialize-double" 'method) ((self #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) dataOut)
  (#.(bullet-wrap::swig-lispify "btVector3_serializeDouble" 'function) (ff-pointer self) dataOut))

(cl:defmethod #.(bullet-wrap::swig-lispify "de-serialize-double" 'method) ((self #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) dataIn)
  (#.(bullet-wrap::swig-lispify "btVector3_deSerializeDouble" 'function) (ff-pointer self) dataIn))

(cl:defmethod #.(bullet-wrap::swig-lispify "max-dot" 'method) ((self #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (array #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (array_count cl:integer) dotOut)
  (#.(bullet-wrap::swig-lispify "btVector3_maxDot" 'function) (ff-pointer self) (ff-pointer array) array_count dotOut))

(cl:defmethod #.(bullet-wrap::swig-lispify "min-dot" 'method) ((self #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (array #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (array_count cl:integer) dotOut)
  (#.(bullet-wrap::swig-lispify "btVector3_minDot" 'function) (ff-pointer self) (ff-pointer array) array_count dotOut))

(cl:defmethod #.(bullet-wrap::swig-lispify "dot3" 'method) ((self #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (v0 #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (v1 #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (v2 #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)))
  (#.(bullet-wrap::swig-lispify "btVector3_dot3" 'function) (ff-pointer self) (ff-pointer v0) (ff-pointer v1) (ff-pointer v2)))


(cl:defclass #.(bullet-wrap::swig-lispify "bt-vector4" 'classname)(#.(bullet-wrap::swig-lispify "btVector3" 'classname))
  ((ff-pointer :reader ff-pointer)))

(cl:defmethod initialize-instance :after ((obj #.(bullet-wrap::swig-lispify "bt-vector4" 'class)) &key)
  (setf (slot-value obj 'ff-pointer) (#.(bullet-wrap::swig-lispify "new_btVector4" 'function))))

(cl:defmethod initialize-instance :after ((obj #.(bullet-wrap::swig-lispify "bt-vector4" 'class)) &key _x _y _z _w)
  (setf (slot-value obj 'ff-pointer) (#.(bullet-wrap::swig-lispify "new_btVector4" 'function) _x _y _z _w)))

(cl:defmethod #.(bullet-wrap::swig-lispify "absolute4" 'method) ((self #.(bullet-wrap::swig-lispify "bt-vector4" 'classname)))
  (#.(bullet-wrap::swig-lispify "btVector4_absolute4" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-w" 'method) ((self #.(bullet-wrap::swig-lispify "bt-vector4" 'classname)))
  (#.(bullet-wrap::swig-lispify "btVector4_getW" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "max-axis4" 'method) ((self #.(bullet-wrap::swig-lispify "bt-vector4" 'classname)))
  (#.(bullet-wrap::swig-lispify "btVector4_maxAxis4" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "min-axis4" 'method) ((self #.(bullet-wrap::swig-lispify "bt-vector4" 'classname)))
  (#.(bullet-wrap::swig-lispify "btVector4_minAxis4" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "closest-axis4" 'method) ((self #.(bullet-wrap::swig-lispify "bt-vector4" 'classname)))
  (#.(bullet-wrap::swig-lispify "btVector4_closestAxis4" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "set-value" 'method) ((self #.(bullet-wrap::swig-lispify "bt-vector4" 'classname)) _x _y _z _w)
  (#.(bullet-wrap::swig-lispify "btVector4_setValue" 'function) (ff-pointer self) _x _y _z _w))


(cl:defclass #.(bullet-wrap::swig-lispify "bt-quaternion" 'classname)()
  ((ff-pointer :reader ff-pointer)))

(cl:defmethod initialize-instance :after ((obj #.(bullet-wrap::swig-lispify "bt-quaternion" 'class)) &key)
  (setf (slot-value obj 'ff-pointer) (#.(bullet-wrap::swig-lispify "new_btQuaternion" 'function))))

(cl:defmethod initialize-instance :after ((obj #.(bullet-wrap::swig-lispify "bt-quaternion" 'class)) &key _x _y _z _w)
  (setf (slot-value obj 'ff-pointer) (#.(bullet-wrap::swig-lispify "new_btQuaternion" 'function) _x _y _z _w)))

(cl:defmethod initialize-instance :after ((obj #.(bullet-wrap::swig-lispify "bt-quaternion" 'class)) &key (_axis #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) _angle)
  (setf (slot-value obj 'ff-pointer) (#.(bullet-wrap::swig-lispify "new_btQuaternion" 'function) _axis _angle)))

(cl:defmethod initialize-instance :after ((obj #.(bullet-wrap::swig-lispify "bt-quaternion" 'class)) &key yaw pitch roll)
  (setf (slot-value obj 'ff-pointer) (#.(bullet-wrap::swig-lispify "new_btQuaternion" 'function) yaw pitch roll)))

(cl:defmethod #.(bullet-wrap::swig-lispify "set-rotation" 'method) ((self #.(bullet-wrap::swig-lispify "bt-quaternion" 'classname)) (axis #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) _angle)
  (#.(bullet-wrap::swig-lispify "btQuaternion_setRotation" 'function) (ff-pointer self) axis _angle))

(cl:defmethod #.(bullet-wrap::swig-lispify "set-euler" 'method) ((self #.(bullet-wrap::swig-lispify "bt-quaternion" 'classname)) yaw pitch roll)
  (#.(bullet-wrap::swig-lispify "btQuaternion_setEuler" 'function) (ff-pointer self) yaw pitch roll))

(cl:defmethod #.(bullet-wrap::swig-lispify "set-euler-zyx" 'method) ((self #.(bullet-wrap::swig-lispify "bt-quaternion" 'classname)) yaw pitch roll)
  (#.(bullet-wrap::swig-lispify "btQuaternion_setEulerZYX" 'function) (ff-pointer self) yaw pitch roll))

(cl:shadow "+=")
(cl:defmethod #.(bullet-wrap::swig-lispify "+=" 'method) ((self #.(bullet-wrap::swig-lispify "bt-quaternion" 'classname)) (q #.(bullet-wrap::swig-lispify "bt-quaternion" 'classname)))
  (#.(bullet-wrap::swig-lispify "btQuaternion_increment" 'function) (ff-pointer self) (ff-pointer q)))

(cl:shadow "-=")
(cl:defmethod #.(bullet-wrap::swig-lispify "-=" 'method) ((self #.(bullet-wrap::swig-lispify "bt-quaternion" 'classname)) (q #.(bullet-wrap::swig-lispify "bt-quaternion" 'classname)))
  (#.(bullet-wrap::swig-lispify "btQuaternion_decrement" 'function) (ff-pointer self) (ff-pointer q)))

(cl:shadow "*=")
(cl:defmethod #.(bullet-wrap::swig-lispify "*=" 'method) ((self #.(bullet-wrap::swig-lispify "bt-quaternion" 'classname)) s)
  (#.(bullet-wrap::swig-lispify "btQuaternion_multiplyAndAssign" 'function) (ff-pointer self) s))

(cl:shadow "*=")
(cl:defmethod #.(bullet-wrap::swig-lispify "*=" 'method) ((self #.(bullet-wrap::swig-lispify "bt-quaternion" 'classname)) (q #.(bullet-wrap::swig-lispify "bt-quaternion" 'classname)))
  (#.(bullet-wrap::swig-lispify "btQuaternion_multiplyAndAssign" 'function) (ff-pointer self) (ff-pointer q)))

(cl:defmethod #.(bullet-wrap::swig-lispify "dot" 'method) ((self #.(bullet-wrap::swig-lispify "bt-quaternion" 'classname)) (q #.(bullet-wrap::swig-lispify "bt-quaternion" 'classname)))
  (#.(bullet-wrap::swig-lispify "btQuaternion_dot" 'function) (ff-pointer self) (ff-pointer q)))

(cl:defmethod #.(bullet-wrap::swig-lispify "length2" 'method) ((self #.(bullet-wrap::swig-lispify "bt-quaternion" 'classname)))
  (#.(bullet-wrap::swig-lispify "btQuaternion_length2" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "length" 'method) ((self #.(bullet-wrap::swig-lispify "bt-quaternion" 'classname)))
  (#.(bullet-wrap::swig-lispify "btQuaternion_length" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "normalize" 'method) ((self #.(bullet-wrap::swig-lispify "bt-quaternion" 'classname)))
  (#.(bullet-wrap::swig-lispify "btQuaternion_normalize" 'function) (ff-pointer self)))

(cl:shadow "*")
(cl:defmethod #.(bullet-wrap::swig-lispify "*" 'method) ((self #.(bullet-wrap::swig-lispify "bt-quaternion" 'classname)) s)
  (#.(bullet-wrap::swig-lispify "btQuaternion_multiply" 'function) (ff-pointer self) s))

(cl:shadow "/")
(cl:defmethod #.(bullet-wrap::swig-lispify "/" 'method) ((self #.(bullet-wrap::swig-lispify "bt-quaternion" 'classname)) s)
  (#.(bullet-wrap::swig-lispify "btQuaternion_divide" 'function) (ff-pointer self) s))

(cl:shadow "/=")
(cl:defmethod #.(bullet-wrap::swig-lispify "/=" 'method) ((self #.(bullet-wrap::swig-lispify "bt-quaternion" 'classname)) s)
  (#.(bullet-wrap::swig-lispify "btQuaternion_divideAndAssign" 'function) (ff-pointer self) s))

(cl:defmethod #.(bullet-wrap::swig-lispify "normalized" 'method) ((self #.(bullet-wrap::swig-lispify "bt-quaternion" 'classname)))
  (#.(bullet-wrap::swig-lispify "btQuaternion_normalized" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "angle" 'method) ((self #.(bullet-wrap::swig-lispify "bt-quaternion" 'classname)) (q #.(bullet-wrap::swig-lispify "bt-quaternion" 'classname)))
  (#.(bullet-wrap::swig-lispify "btQuaternion_angle" 'function) (ff-pointer self) (ff-pointer q)))

(cl:defmethod #.(bullet-wrap::swig-lispify "angle-shortest-path" 'method) ((self #.(bullet-wrap::swig-lispify "bt-quaternion" 'classname)) (q #.(bullet-wrap::swig-lispify "bt-quaternion" 'classname)))
  (#.(bullet-wrap::swig-lispify "btQuaternion_angleShortestPath" 'function) (ff-pointer self) (ff-pointer q)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-angle" 'method) ((self #.(bullet-wrap::swig-lispify "bt-quaternion" 'classname)))
  (#.(bullet-wrap::swig-lispify "btQuaternion_getAngle" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-angle-shortest-path" 'method) ((self #.(bullet-wrap::swig-lispify "bt-quaternion" 'classname)))
  (#.(bullet-wrap::swig-lispify "btQuaternion_getAngleShortestPath" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-axis" 'method) ((self #.(bullet-wrap::swig-lispify "bt-quaternion" 'classname)))
  (#.(bullet-wrap::swig-lispify "btQuaternion_getAxis" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "inverse" 'method) ((self #.(bullet-wrap::swig-lispify "bt-quaternion" 'classname)))
  (#.(bullet-wrap::swig-lispify "btQuaternion_inverse" 'function) (ff-pointer self)))

(cl:shadow "+")
(cl:defmethod #.(bullet-wrap::swig-lispify "+" 'method) ((self #.(bullet-wrap::swig-lispify "bt-quaternion" 'classname)) (q2 #.(bullet-wrap::swig-lispify "bt-quaternion" 'classname)))
  (#.(bullet-wrap::swig-lispify "btQuaternion_add" 'function) (ff-pointer self) (ff-pointer q2)))

(cl:shadow "-")
(cl:defmethod #.(bullet-wrap::swig-lispify "-" 'method) ((self #.(bullet-wrap::swig-lispify "bt-quaternion" 'classname)) (q2 #.(bullet-wrap::swig-lispify "bt-quaternion" 'classname)))
  (#.(bullet-wrap::swig-lispify "btQuaternion_subtract" 'function) (ff-pointer self) (ff-pointer q2)))

(cl:shadow "-")
(cl:defmethod #.(bullet-wrap::swig-lispify "-" 'method) ((self #.(bullet-wrap::swig-lispify "bt-quaternion" 'classname)))
  (#.(bullet-wrap::swig-lispify "btQuaternion___neg__" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "farthest" 'method) ((self #.(bullet-wrap::swig-lispify "bt-quaternion" 'classname)) (qd #.(bullet-wrap::swig-lispify "bt-quaternion" 'classname)))
  (#.(bullet-wrap::swig-lispify "btQuaternion_farthest" 'function) (ff-pointer self) (ff-pointer qd)))

(cl:defmethod #.(bullet-wrap::swig-lispify "nearest" 'method) ((self #.(bullet-wrap::swig-lispify "bt-quaternion" 'classname)) (qd #.(bullet-wrap::swig-lispify "bt-quaternion" 'classname)))
  (#.(bullet-wrap::swig-lispify "btQuaternion_nearest" 'function) (ff-pointer self) (ff-pointer qd)))

(cl:defmethod #.(bullet-wrap::swig-lispify "slerp" 'method) ((self #.(bullet-wrap::swig-lispify "bt-quaternion" 'classname)) (q #.(bullet-wrap::swig-lispify "bt-quaternion" 'classname)) t-arg2)
  (#.(bullet-wrap::swig-lispify "btQuaternion_slerp" 'function) (ff-pointer self) (ff-pointer q) t-arg2))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-w" 'method) ((self #.(bullet-wrap::swig-lispify "bt-quaternion" 'classname)))
  (#.(bullet-wrap::swig-lispify "btQuaternion_getW" 'function) (ff-pointer self)))


(cl:defclass #.(bullet-wrap::swig-lispify "bt-matrix3x3" 'classname)()
  ((ff-pointer :reader ff-pointer)))

(cl:defmethod initialize-instance :after ((obj #.(bullet-wrap::swig-lispify "bt-matrix3x3" 'class)) &key)
  (setf (slot-value obj 'ff-pointer) (#.(bullet-wrap::swig-lispify "new_btMatrix3x3" 'function))))

(cl:defmethod initialize-instance :after ((obj #.(bullet-wrap::swig-lispify "bt-matrix3x3" 'class)) &key (q #.(bullet-wrap::swig-lispify "bt-quaternion" 'classname)))
  (setf (slot-value obj 'ff-pointer) (#.(bullet-wrap::swig-lispify "new_btMatrix3x3" 'function) q)))

(cl:defmethod initialize-instance :after ((obj #.(bullet-wrap::swig-lispify "bt-matrix3x3" 'class)) &key xx xy xz yx yy yz zx zy zz)
  (setf (slot-value obj 'ff-pointer) (#.(bullet-wrap::swig-lispify "new_btMatrix3x3" 'function) xx xy xz yx yy yz zx zy zz)))

(cl:defmethod initialize-instance :after ((obj #.(bullet-wrap::swig-lispify "bt-matrix3x3" 'class)) &key (other #.(bullet-wrap::swig-lispify "bt-matrix3x3" 'classname)))
  (setf (slot-value obj 'ff-pointer) (#.(bullet-wrap::swig-lispify "new_btMatrix3x3" 'function) (ff-pointer other))))

(cl:shadow "=")
(cl:defmethod #.(bullet-wrap::swig-lispify "=" 'method) ((self #.(bullet-wrap::swig-lispify "bt-matrix3x3" 'classname)) (other #.(bullet-wrap::swig-lispify "bt-matrix3x3" 'classname)))
  (#.(bullet-wrap::swig-lispify "btMatrix3x3_assignValue" 'function) (ff-pointer self) (ff-pointer other)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-column" 'method) ((self #.(bullet-wrap::swig-lispify "bt-matrix3x3" 'classname)) (i cl:integer))
  (#.(bullet-wrap::swig-lispify "btMatrix3x3_getColumn" 'function) (ff-pointer self) i))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-row" 'method) ((self #.(bullet-wrap::swig-lispify "bt-matrix3x3" 'classname)) (i cl:integer))
  (#.(bullet-wrap::swig-lispify "btMatrix3x3_getRow" 'function) (ff-pointer self) i))

(cl:shadow "[]")
(cl:defmethod #.(bullet-wrap::swig-lispify "[]" 'method) ((self #.(bullet-wrap::swig-lispify "bt-matrix3x3" 'classname)) (i cl:integer))
  (#.(bullet-wrap::swig-lispify "btMatrix3x3___aref__" 'function) (ff-pointer self) i))

(cl:shadow "[]")
(cl:defmethod #.(bullet-wrap::swig-lispify "[]" 'method) ((self #.(bullet-wrap::swig-lispify "bt-matrix3x3" 'classname)) (i cl:integer))
  (#.(bullet-wrap::swig-lispify "btMatrix3x3___aref__" 'function) (ff-pointer self) i))

(cl:shadow "*=")
(cl:defmethod #.(bullet-wrap::swig-lispify "*=" 'method) ((self #.(bullet-wrap::swig-lispify "bt-matrix3x3" 'classname)) (m #.(bullet-wrap::swig-lispify "bt-matrix3x3" 'classname)))
  (#.(bullet-wrap::swig-lispify "btMatrix3x3_multiplyAndAssign" 'function) (ff-pointer self) (ff-pointer m)))

(cl:shadow "+=")
(cl:defmethod #.(bullet-wrap::swig-lispify "+=" 'method) ((self #.(bullet-wrap::swig-lispify "bt-matrix3x3" 'classname)) (m #.(bullet-wrap::swig-lispify "bt-matrix3x3" 'classname)))
  (#.(bullet-wrap::swig-lispify "btMatrix3x3_increment" 'function) (ff-pointer self) (ff-pointer m)))

(cl:shadow "-=")
(cl:defmethod #.(bullet-wrap::swig-lispify "-=" 'method) ((self #.(bullet-wrap::swig-lispify "bt-matrix3x3" 'classname)) (m #.(bullet-wrap::swig-lispify "bt-matrix3x3" 'classname)))
  (#.(bullet-wrap::swig-lispify "btMatrix3x3_decrement" 'function) (ff-pointer self) (ff-pointer m)))

(cl:defmethod #.(bullet-wrap::swig-lispify "set-from-open-glsub-matrix" 'method) ((self #.(bullet-wrap::swig-lispify "bt-matrix3x3" 'classname)) m)
  (#.(bullet-wrap::swig-lispify "btMatrix3x3_setFromOpenGLSubMatrix" 'function) (ff-pointer self) m))

(cl:defmethod #.(bullet-wrap::swig-lispify "set-value" 'method) ((self #.(bullet-wrap::swig-lispify "bt-matrix3x3" 'classname)) xx xy xz yx yy yz zx zy zz)
  (#.(bullet-wrap::swig-lispify "btMatrix3x3_setValue" 'function) (ff-pointer self) xx xy xz yx yy yz zx zy zz))

(cl:defmethod #.(bullet-wrap::swig-lispify "set-rotation" 'method) ((self #.(bullet-wrap::swig-lispify "bt-matrix3x3" 'classname)) (q #.(bullet-wrap::swig-lispify "bt-quaternion" 'classname)))
  (#.(bullet-wrap::swig-lispify "btMatrix3x3_setRotation" 'function) (ff-pointer self) q))

(cl:defmethod #.(bullet-wrap::swig-lispify "set-euler-ypr" 'method) ((self #.(bullet-wrap::swig-lispify "bt-matrix3x3" 'classname)) yaw pitch roll)
  (#.(bullet-wrap::swig-lispify "btMatrix3x3_setEulerYPR" 'function) (ff-pointer self) yaw pitch roll))

(cl:defmethod #.(bullet-wrap::swig-lispify "set-euler-zyx" 'method) ((self #.(bullet-wrap::swig-lispify "bt-matrix3x3" 'classname)) (eulerX cl:number) (eulerY cl:number) (eulerZ cl:number))
  (#.(bullet-wrap::swig-lispify "btMatrix3x3_setEulerZYX" 'function) (ff-pointer self) eulerX eulerY eulerZ))

(cl:defmethod #.(bullet-wrap::swig-lispify "set-identity" 'method) ((self #.(bullet-wrap::swig-lispify "bt-matrix3x3" 'classname)))
  (#.(bullet-wrap::swig-lispify "btMatrix3x3_setIdentity" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-open-glsub-matrix" 'method) ((self #.(bullet-wrap::swig-lispify "bt-matrix3x3" 'classname)) m)
  (#.(bullet-wrap::swig-lispify "btMatrix3x3_getOpenGLSubMatrix" 'function) (ff-pointer self) m))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-rotation" 'method) ((self #.(bullet-wrap::swig-lispify "bt-matrix3x3" 'classname)) (q #.(bullet-wrap::swig-lispify "bt-quaternion" 'classname)))
  (#.(bullet-wrap::swig-lispify "btMatrix3x3_getRotation" 'function) (ff-pointer self) q))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-euler-ypr" 'method) ((self #.(bullet-wrap::swig-lispify "bt-matrix3x3" 'classname)) yaw pitch roll)
  (#.(bullet-wrap::swig-lispify "btMatrix3x3_getEulerYPR" 'function) (ff-pointer self) yaw pitch roll))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-euler-zyx" 'method) ((self #.(bullet-wrap::swig-lispify "bt-matrix3x3" 'classname)) yaw pitch roll (solution_number cl:integer))
  (#.(bullet-wrap::swig-lispify "btMatrix3x3_getEulerZYX" 'function) (ff-pointer self) yaw pitch roll solution_number))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-euler-zyx" 'method) ((self #.(bullet-wrap::swig-lispify "bt-matrix3x3" 'classname)) yaw pitch roll)
  (#.(bullet-wrap::swig-lispify "btMatrix3x3_getEulerZYX" 'function) (ff-pointer self) yaw pitch roll))

(cl:defmethod #.(bullet-wrap::swig-lispify "scaled" 'method) ((self #.(bullet-wrap::swig-lispify "bt-matrix3x3" 'classname)) (s #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)))
  (#.(bullet-wrap::swig-lispify "btMatrix3x3_scaled" 'function) (ff-pointer self) s))

(cl:defmethod #.(bullet-wrap::swig-lispify "determinant" 'method) ((self #.(bullet-wrap::swig-lispify "bt-matrix3x3" 'classname)))
  (#.(bullet-wrap::swig-lispify "btMatrix3x3_determinant" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "adjoint" 'method) ((self #.(bullet-wrap::swig-lispify "bt-matrix3x3" 'classname)))
  (#.(bullet-wrap::swig-lispify "btMatrix3x3_adjoint" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "absolute" 'method) ((self #.(bullet-wrap::swig-lispify "bt-matrix3x3" 'classname)))
  (#.(bullet-wrap::swig-lispify "btMatrix3x3_absolute" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "transpose" 'method) ((self #.(bullet-wrap::swig-lispify "bt-matrix3x3" 'classname)))
  (#.(bullet-wrap::swig-lispify "btMatrix3x3_transpose" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "inverse" 'method) ((self #.(bullet-wrap::swig-lispify "bt-matrix3x3" 'classname)))
  (#.(bullet-wrap::swig-lispify "btMatrix3x3_inverse" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "transpose-times" 'method) ((self #.(bullet-wrap::swig-lispify "bt-matrix3x3" 'classname)) (m #.(bullet-wrap::swig-lispify "bt-matrix3x3" 'classname)))
  (#.(bullet-wrap::swig-lispify "btMatrix3x3_transposeTimes" 'function) (ff-pointer self) (ff-pointer m)))

(cl:defmethod #.(bullet-wrap::swig-lispify "times-transpose" 'method) ((self #.(bullet-wrap::swig-lispify "bt-matrix3x3" 'classname)) (m #.(bullet-wrap::swig-lispify "bt-matrix3x3" 'classname)))
  (#.(bullet-wrap::swig-lispify "btMatrix3x3_timesTranspose" 'function) (ff-pointer self) (ff-pointer m)))

(cl:defmethod #.(bullet-wrap::swig-lispify "tdotx" 'method) ((self #.(bullet-wrap::swig-lispify "bt-matrix3x3" 'classname)) (v #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)))
  (#.(bullet-wrap::swig-lispify "btMatrix3x3_tdotx" 'function) (ff-pointer self) v))

(cl:defmethod #.(bullet-wrap::swig-lispify "tdoty" 'method) ((self #.(bullet-wrap::swig-lispify "bt-matrix3x3" 'classname)) (v #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)))
  (#.(bullet-wrap::swig-lispify "btMatrix3x3_tdoty" 'function) (ff-pointer self) v))

(cl:defmethod #.(bullet-wrap::swig-lispify "tdotz" 'method) ((self #.(bullet-wrap::swig-lispify "bt-matrix3x3" 'classname)) (v #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)))
  (#.(bullet-wrap::swig-lispify "btMatrix3x3_tdotz" 'function) (ff-pointer self) v))

(cl:defmethod #.(bullet-wrap::swig-lispify "diagonalize" 'method) ((self #.(bullet-wrap::swig-lispify "bt-matrix3x3" 'classname)) (rot #.(bullet-wrap::swig-lispify "bt-matrix3x3" 'classname)) (threshold cl:number) (maxSteps cl:integer))
  (#.(bullet-wrap::swig-lispify "btMatrix3x3_diagonalize" 'function) (ff-pointer self) (ff-pointer rot) threshold maxSteps))

(cl:defmethod #.(bullet-wrap::swig-lispify "cofac" 'method) ((self #.(bullet-wrap::swig-lispify "bt-matrix3x3" 'classname)) (r1 cl:integer) (c1 cl:integer) (r2 cl:integer) (c2 cl:integer))
  (#.(bullet-wrap::swig-lispify "btMatrix3x3_cofac" 'function) (ff-pointer self) r1 c1 r2 c2))

(cl:defmethod #.(bullet-wrap::swig-lispify "serialize" 'method) ((self #.(bullet-wrap::swig-lispify "bt-matrix3x3" 'classname)) dataOut)
  (#.(bullet-wrap::swig-lispify "btMatrix3x3_serialize" 'function) (ff-pointer self) dataOut))

(cl:defmethod #.(bullet-wrap::swig-lispify "serialize-float" 'method) ((self #.(bullet-wrap::swig-lispify "bt-matrix3x3" 'classname)) dataOut)
  (#.(bullet-wrap::swig-lispify "btMatrix3x3_serializeFloat" 'function) (ff-pointer self) dataOut))

(cl:defmethod #.(bullet-wrap::swig-lispify "de-serialize" 'method) ((self #.(bullet-wrap::swig-lispify "bt-matrix3x3" 'classname)) dataIn)
  (#.(bullet-wrap::swig-lispify "btMatrix3x3_deSerialize" 'function) (ff-pointer self) dataIn))

(cl:defmethod #.(bullet-wrap::swig-lispify "de-serialize-float" 'method) ((self #.(bullet-wrap::swig-lispify "bt-matrix3x3" 'classname)) dataIn)
  (#.(bullet-wrap::swig-lispify "btMatrix3x3_deSerializeFloat" 'function) (ff-pointer self) dataIn))

(cl:defmethod #.(bullet-wrap::swig-lispify "de-serialize-double" 'method) ((self #.(bullet-wrap::swig-lispify "bt-matrix3x3" 'classname)) dataIn)
  (#.(bullet-wrap::swig-lispify "btMatrix3x3_deSerializeDouble" 'function) (ff-pointer self) dataIn))


(cl:defclass #.(bullet-wrap::swig-lispify "bt-transform" 'classname)()
  ((ff-pointer :reader ff-pointer)))

(cl:defmethod initialize-instance :after ((obj #.(bullet-wrap::swig-lispify "bt-transform" 'class)) &key)
  (setf (slot-value obj 'ff-pointer) (#.(bullet-wrap::swig-lispify "new_btTransform" 'function))))

(cl:defmethod initialize-instance :after ((obj #.(bullet-wrap::swig-lispify "bt-transform" 'class)) &key (q #.(bullet-wrap::swig-lispify "bt-quaternion" 'classname)) (c #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)))
  (setf (slot-value obj 'ff-pointer) (#.(bullet-wrap::swig-lispify "new_btTransform" 'function) q c)))

(cl:defmethod initialize-instance :after ((obj #.(bullet-wrap::swig-lispify "bt-transform" 'class)) &key (q #.(bullet-wrap::swig-lispify "bt-quaternion" 'classname)))
  (setf (slot-value obj 'ff-pointer) (#.(bullet-wrap::swig-lispify "new_btTransform" 'function) q)))

(cl:defmethod initialize-instance :after ((obj #.(bullet-wrap::swig-lispify "bt-transform" 'class)) &key (b #.(bullet-wrap::swig-lispify "bt-matrix3x3" 'classname)) (c #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)))
  (setf (slot-value obj 'ff-pointer) (#.(bullet-wrap::swig-lispify "new_btTransform" 'function) b c)))

(cl:defmethod initialize-instance :after ((obj #.(bullet-wrap::swig-lispify "bt-transform" 'class)) &key (b #.(bullet-wrap::swig-lispify "bt-matrix3x3" 'classname)))
  (setf (slot-value obj 'ff-pointer) (#.(bullet-wrap::swig-lispify "new_btTransform" 'function) b)))

(cl:defmethod initialize-instance :after ((obj #.(bullet-wrap::swig-lispify "bt-transform" 'class)) &key (other #.(bullet-wrap::swig-lispify "bt-transform" 'classname)))
  (setf (slot-value obj 'ff-pointer) (#.(bullet-wrap::swig-lispify "new_btTransform" 'function) (ff-pointer other))))

(cl:shadow "=")
(cl:defmethod #.(bullet-wrap::swig-lispify "=" 'method) ((self #.(bullet-wrap::swig-lispify "bt-transform" 'classname)) (other #.(bullet-wrap::swig-lispify "bt-transform" 'classname)))
  (#.(bullet-wrap::swig-lispify "btTransform_assignValue" 'function) (ff-pointer self) (ff-pointer other)))

(cl:defmethod #.(bullet-wrap::swig-lispify "mult" 'method) ((self #.(bullet-wrap::swig-lispify "bt-transform" 'classname)) (t1 #.(bullet-wrap::swig-lispify "bt-transform" 'classname)) (t2 #.(bullet-wrap::swig-lispify "bt-transform" 'classname)))
  (#.(bullet-wrap::swig-lispify "btTransform_mult" 'function) (ff-pointer self) (ff-pointer t1) (ff-pointer t2)))

(cl:shadow "()")
(cl:defmethod #.(bullet-wrap::swig-lispify "()" 'method) ((self #.(bullet-wrap::swig-lispify "bt-transform" 'classname)) (x #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)))
  (#.(bullet-wrap::swig-lispify "btTransform___funcall__" 'function) (ff-pointer self) x))

(cl:shadow "*")
(cl:defmethod #.(bullet-wrap::swig-lispify "*" 'method) ((self #.(bullet-wrap::swig-lispify "bt-transform" 'classname)) (x #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)))
  (#.(bullet-wrap::swig-lispify "btTransform_multiply" 'function) (ff-pointer self) x))

(cl:shadow "*")
(cl:defmethod #.(bullet-wrap::swig-lispify "*" 'method) ((self #.(bullet-wrap::swig-lispify "bt-transform" 'classname)) (q #.(bullet-wrap::swig-lispify "bt-quaternion" 'classname)))
  (#.(bullet-wrap::swig-lispify "btTransform_multiply" 'function) (ff-pointer self) q))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-basis" 'method) ((self #.(bullet-wrap::swig-lispify "bt-transform" 'classname)))
  (#.(bullet-wrap::swig-lispify "btTransform_getBasis" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-basis" 'method) ((self #.(bullet-wrap::swig-lispify "bt-transform" 'classname)))
  (#.(bullet-wrap::swig-lispify "btTransform_getBasis" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-origin" 'method) ((self #.(bullet-wrap::swig-lispify "bt-transform" 'classname)))
  (#.(bullet-wrap::swig-lispify "btTransform_getOrigin" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-origin" 'method) ((self #.(bullet-wrap::swig-lispify "bt-transform" 'classname)))
  (#.(bullet-wrap::swig-lispify "btTransform_getOrigin" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-rotation" 'method) ((self #.(bullet-wrap::swig-lispify "bt-transform" 'classname)))
  (#.(bullet-wrap::swig-lispify "btTransform_getRotation" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "set-from-open-glmatrix" 'method) ((self #.(bullet-wrap::swig-lispify "bt-transform" 'classname)) m)
  (#.(bullet-wrap::swig-lispify "btTransform_setFromOpenGLMatrix" 'function) (ff-pointer self) m))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-open-glmatrix" 'method) ((self #.(bullet-wrap::swig-lispify "bt-transform" 'classname)) m)
  (#.(bullet-wrap::swig-lispify "btTransform_getOpenGLMatrix" 'function) (ff-pointer self) m))

(cl:defmethod #.(bullet-wrap::swig-lispify "set-origin" 'method) ((self #.(bullet-wrap::swig-lispify "bt-transform" 'classname)) (origin #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)))
  (#.(bullet-wrap::swig-lispify "btTransform_setOrigin" 'function) (ff-pointer self) origin))

(cl:defmethod #.(bullet-wrap::swig-lispify "inv-xform" 'method) ((self #.(bullet-wrap::swig-lispify "bt-transform" 'classname)) (inVec #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)))
  (#.(bullet-wrap::swig-lispify "btTransform_invXform" 'function) (ff-pointer self) inVec))

(cl:defmethod #.(bullet-wrap::swig-lispify "set-basis" 'method) ((self #.(bullet-wrap::swig-lispify "bt-transform" 'classname)) (basis #.(bullet-wrap::swig-lispify "bt-matrix3x3" 'classname)))
  (#.(bullet-wrap::swig-lispify "btTransform_setBasis" 'function) (ff-pointer self) basis))

(cl:defmethod #.(bullet-wrap::swig-lispify "set-rotation" 'method) ((self #.(bullet-wrap::swig-lispify "bt-transform" 'classname)) (q #.(bullet-wrap::swig-lispify "bt-quaternion" 'classname)))
  (#.(bullet-wrap::swig-lispify "btTransform_setRotation" 'function) (ff-pointer self) q))

(cl:defmethod #.(bullet-wrap::swig-lispify "set-identity" 'method) ((self #.(bullet-wrap::swig-lispify "bt-transform" 'classname)))
  (#.(bullet-wrap::swig-lispify "btTransform_setIdentity" 'function) (ff-pointer self)))

(cl:shadow "*=")
(cl:defmethod #.(bullet-wrap::swig-lispify "*=" 'method) ((self #.(bullet-wrap::swig-lispify "bt-transform" 'classname)) (t-arg1 #.(bullet-wrap::swig-lispify "bt-transform" 'classname)))
  (#.(bullet-wrap::swig-lispify "btTransform_multiplyAndAssign" 'function) (ff-pointer self) (ff-pointer t-arg1)))

(cl:defmethod #.(bullet-wrap::swig-lispify "inverse" 'method) ((self #.(bullet-wrap::swig-lispify "bt-transform" 'classname)))
  (#.(bullet-wrap::swig-lispify "btTransform_inverse" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "inverse-times" 'method) ((self #.(bullet-wrap::swig-lispify "bt-transform" 'classname)) (t-arg1 #.(bullet-wrap::swig-lispify "bt-transform" 'classname)))
  (#.(bullet-wrap::swig-lispify "btTransform_inverseTimes" 'function) (ff-pointer self) (ff-pointer t-arg1)))

(cl:shadow "*")
(cl:defmethod #.(bullet-wrap::swig-lispify "*" 'method) ((self #.(bullet-wrap::swig-lispify "bt-transform" 'classname)) (t-arg1 #.(bullet-wrap::swig-lispify "bt-transform" 'classname)))
  (#.(bullet-wrap::swig-lispify "btTransform_multiply" 'function) (ff-pointer self) (ff-pointer t-arg1)))

(cl:defmethod #.(bullet-wrap::swig-lispify "serialize" 'method) ((self #.(bullet-wrap::swig-lispify "bt-transform" 'classname)) dataOut)
  (#.(bullet-wrap::swig-lispify "btTransform_serialize" 'function) (ff-pointer self) dataOut))

(cl:defmethod #.(bullet-wrap::swig-lispify "serialize-float" 'method) ((self #.(bullet-wrap::swig-lispify "bt-transform" 'classname)) dataOut)
  (#.(bullet-wrap::swig-lispify "btTransform_serializeFloat" 'function) (ff-pointer self) dataOut))

(cl:defmethod #.(bullet-wrap::swig-lispify "de-serialize" 'method) ((self #.(bullet-wrap::swig-lispify "bt-transform" 'classname)) dataIn)
  (#.(bullet-wrap::swig-lispify "btTransform_deSerialize" 'function) (ff-pointer self) dataIn))

(cl:defmethod #.(bullet-wrap::swig-lispify "de-serialize-double" 'method) ((self #.(bullet-wrap::swig-lispify "bt-transform" 'classname)) dataIn)
  (#.(bullet-wrap::swig-lispify "btTransform_deSerializeDouble" 'function) (ff-pointer self) dataIn))

(cl:defmethod #.(bullet-wrap::swig-lispify "de-serialize-float" 'method) ((self #.(bullet-wrap::swig-lispify "bt-transform" 'classname)) dataIn)
  (#.(bullet-wrap::swig-lispify "btTransform_deSerializeFloat" 'function) (ff-pointer self) dataIn))


(cl:defclass #.(bullet-wrap::swig-lispify "bt-motion-state" 'classname)()
  ((ff-pointer :reader ff-pointer)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-world-transform" 'method) ((self #.(bullet-wrap::swig-lispify "bt-motion-state" 'classname)) (worldTrans #.(bullet-wrap::swig-lispify "bt-transform" 'classname)))
  (#.(bullet-wrap::swig-lispify "btMotionState_getWorldTransform" 'function) (ff-pointer self) worldTrans))

(cl:defmethod #.(bullet-wrap::swig-lispify "set-world-transform" 'method) ((self #.(bullet-wrap::swig-lispify "bt-motion-state" 'classname)) (worldTrans #.(bullet-wrap::swig-lispify "bt-transform" 'classname)))
  (#.(bullet-wrap::swig-lispify "btMotionState_setWorldTransform" 'function) (ff-pointer self) worldTrans))


(cl:defclass #.(bullet-wrap::swig-lispify "bt-collision-world" 'classname)()
  ((ff-pointer :reader ff-pointer)))

(cl:defmethod initialize-instance :after ((obj #.(bullet-wrap::swig-lispify "bt-collision-world" 'class)) &key dispatcher broadphasePairCache collisionConfiguration)
  (setf (slot-value obj 'ff-pointer) (#.(bullet-wrap::swig-lispify "new_btCollisionWorld" 'function) dispatcher broadphasePairCache collisionConfiguration)))

(cl:defmethod #.(bullet-wrap::swig-lispify "set-broadphase" 'method) ((self #.(bullet-wrap::swig-lispify "bt-collision-world" 'classname)) pairCache)
  (#.(bullet-wrap::swig-lispify "btCollisionWorld_setBroadphase" 'function) (ff-pointer self) pairCache))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-broadphase" 'method) ((self #.(bullet-wrap::swig-lispify "bt-collision-world" 'classname)))
  (#.(bullet-wrap::swig-lispify "btCollisionWorld_getBroadphase" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-broadphase" 'method) ((self #.(bullet-wrap::swig-lispify "bt-collision-world" 'classname)))
  (#.(bullet-wrap::swig-lispify "btCollisionWorld_getBroadphase" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-pair-cache" 'method) ((self #.(bullet-wrap::swig-lispify "bt-collision-world" 'classname)))
  (#.(bullet-wrap::swig-lispify "btCollisionWorld_getPairCache" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-dispatcher" 'method) ((self #.(bullet-wrap::swig-lispify "bt-collision-world" 'classname)))
  (#.(bullet-wrap::swig-lispify "btCollisionWorld_getDispatcher" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-dispatcher" 'method) ((self #.(bullet-wrap::swig-lispify "bt-collision-world" 'classname)))
  (#.(bullet-wrap::swig-lispify "btCollisionWorld_getDispatcher" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "update-single-aabb" 'method) ((self #.(bullet-wrap::swig-lispify "bt-collision-world" 'classname)) colObj)
  (#.(bullet-wrap::swig-lispify "btCollisionWorld_updateSingleAabb" 'function) (ff-pointer self) colObj))

(cl:defmethod #.(bullet-wrap::swig-lispify "update-aabbs" 'method) ((self #.(bullet-wrap::swig-lispify "bt-collision-world" 'classname)))
  (#.(bullet-wrap::swig-lispify "btCollisionWorld_updateAabbs" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "compute-overlapping-pairs" 'method) ((self #.(bullet-wrap::swig-lispify "bt-collision-world" 'classname)))
  (#.(bullet-wrap::swig-lispify "btCollisionWorld_computeOverlappingPairs" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "set-debug-drawer" 'method) ((self #.(bullet-wrap::swig-lispify "bt-collision-world" 'classname)) debugDrawer)
  (#.(bullet-wrap::swig-lispify "btCollisionWorld_setDebugDrawer" 'function) (ff-pointer self) debugDrawer))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-debug-drawer" 'method) ((self #.(bullet-wrap::swig-lispify "bt-collision-world" 'classname)))
  (#.(bullet-wrap::swig-lispify "btCollisionWorld_getDebugDrawer" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "debug-draw-world" 'method) ((self #.(bullet-wrap::swig-lispify "bt-collision-world" 'classname)))
  (#.(bullet-wrap::swig-lispify "btCollisionWorld_debugDrawWorld" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "debug-draw-object" 'method) ((self #.(bullet-wrap::swig-lispify "bt-collision-world" 'classname)) (worldTransform #.(bullet-wrap::swig-lispify "bt-transform" 'classname)) shape (color #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)))
  (#.(bullet-wrap::swig-lispify "btCollisionWorld_debugDrawObject" 'function) (ff-pointer self) worldTransform shape color))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-num-collision-objects" 'method) ((self #.(bullet-wrap::swig-lispify "bt-collision-world" 'classname)))
  (#.(bullet-wrap::swig-lispify "btCollisionWorld_getNumCollisionObjects" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "ray-test" 'method) ((self #.(bullet-wrap::swig-lispify "bt-collision-world" 'classname)) (rayFromWorld #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (rayToWorld #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) resultCallback)
  (#.(bullet-wrap::swig-lispify "btCollisionWorld_rayTest" 'function) (ff-pointer self) rayFromWorld rayToWorld resultCallback))

(cl:defmethod #.(bullet-wrap::swig-lispify "convex-sweep-test" 'method) ((self #.(bullet-wrap::swig-lispify "bt-collision-world" 'classname)) castShape (from #.(bullet-wrap::swig-lispify "bt-transform" 'classname)) (to #.(bullet-wrap::swig-lispify "bt-transform" 'classname)) resultCallback (allowedCcdPenetration cl:number))
  (#.(bullet-wrap::swig-lispify "btCollisionWorld_convexSweepTest" 'function) (ff-pointer self) castShape from to resultCallback allowedCcdPenetration))

(cl:defmethod #.(bullet-wrap::swig-lispify "convex-sweep-test" 'method) ((self #.(bullet-wrap::swig-lispify "bt-collision-world" 'classname)) castShape (from #.(bullet-wrap::swig-lispify "bt-transform" 'classname)) (to #.(bullet-wrap::swig-lispify "bt-transform" 'classname)) resultCallback)
  (#.(bullet-wrap::swig-lispify "btCollisionWorld_convexSweepTest" 'function) (ff-pointer self) castShape from to resultCallback))

(cl:defmethod #.(bullet-wrap::swig-lispify "contact-test" 'method) ((self #.(bullet-wrap::swig-lispify "bt-collision-world" 'classname)) colObj resultCallback)
  (#.(bullet-wrap::swig-lispify "btCollisionWorld_contactTest" 'function) (ff-pointer self) colObj resultCallback))

(cl:defmethod #.(bullet-wrap::swig-lispify "contact-pair-test" 'method) ((self #.(bullet-wrap::swig-lispify "bt-collision-world" 'classname)) colObjA colObjB resultCallback)
  (#.(bullet-wrap::swig-lispify "btCollisionWorld_contactPairTest" 'function) (ff-pointer self) colObjA colObjB resultCallback))

(cl:defmethod #.(bullet-wrap::swig-lispify "add-collision-object" 'method) ((self #.(bullet-wrap::swig-lispify "bt-collision-world" 'classname)) collisionObject (collisionFilterGroup cl:integer) (collisionFilterMask cl:integer))
  (#.(bullet-wrap::swig-lispify "btCollisionWorld_addCollisionObject" 'function) (ff-pointer self) collisionObject collisionFilterGroup collisionFilterMask))

(cl:defmethod #.(bullet-wrap::swig-lispify "add-collision-object" 'method) ((self #.(bullet-wrap::swig-lispify "bt-collision-world" 'classname)) collisionObject (collisionFilterGroup cl:integer))
  (#.(bullet-wrap::swig-lispify "btCollisionWorld_addCollisionObject" 'function) (ff-pointer self) collisionObject collisionFilterGroup))

(cl:defmethod #.(bullet-wrap::swig-lispify "add-collision-object" 'method) ((self #.(bullet-wrap::swig-lispify "bt-collision-world" 'classname)) collisionObject)
  (#.(bullet-wrap::swig-lispify "btCollisionWorld_addCollisionObject" 'function) (ff-pointer self) collisionObject))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-collision-object-array" 'method) ((self #.(bullet-wrap::swig-lispify "bt-collision-world" 'classname)))
  (#.(bullet-wrap::swig-lispify "btCollisionWorld_getCollisionObjectArray" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-collision-object-array" 'method) ((self #.(bullet-wrap::swig-lispify "bt-collision-world" 'classname)))
  (#.(bullet-wrap::swig-lispify "btCollisionWorld_getCollisionObjectArray" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "remove-collision-object" 'method) ((self #.(bullet-wrap::swig-lispify "bt-collision-world" 'classname)) collisionObject)
  (#.(bullet-wrap::swig-lispify "btCollisionWorld_removeCollisionObject" 'function) (ff-pointer self) collisionObject))

(cl:defmethod #.(bullet-wrap::swig-lispify "perform-discrete-collision-detection" 'method) ((self #.(bullet-wrap::swig-lispify "bt-collision-world" 'classname)))
  (#.(bullet-wrap::swig-lispify "btCollisionWorld_performDiscreteCollisionDetection" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-dispatch-info" 'method) ((self #.(bullet-wrap::swig-lispify "bt-collision-world" 'classname)))
  (#.(bullet-wrap::swig-lispify "btCollisionWorld_getDispatchInfo" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-dispatch-info" 'method) ((self #.(bullet-wrap::swig-lispify "bt-collision-world" 'classname)))
  (#.(bullet-wrap::swig-lispify "btCollisionWorld_getDispatchInfo" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-force-update-all-aabbs" 'method) ((self #.(bullet-wrap::swig-lispify "bt-collision-world" 'classname)))
  (#.(bullet-wrap::swig-lispify "btCollisionWorld_getForceUpdateAllAabbs" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "set-force-update-all-aabbs" 'method) ((self #.(bullet-wrap::swig-lispify "bt-collision-world" 'classname)) (forceUpdateAllAabbs t))
  (#.(bullet-wrap::swig-lispify "btCollisionWorld_setForceUpdateAllAabbs" 'function) (ff-pointer self) forceUpdateAllAabbs))

(cl:defmethod #.(bullet-wrap::swig-lispify "serialize" 'method) ((self #.(bullet-wrap::swig-lispify "bt-collision-world" 'classname)) serializer)
  (#.(bullet-wrap::swig-lispify "btCollisionWorld_serialize" 'function) (ff-pointer self) serializer))


(cl:defclass #.(bullet-wrap::swig-lispify "bt-collision-object" 'classname)()
  ((ff-pointer :reader ff-pointer)))

(cl:shadow "new")
(cl:defmethod #.(bullet-wrap::swig-lispify "new" 'method) ((self #.(bullet-wrap::swig-lispify "bt-collision-object" 'classname)) sizeInBytes)
  (#.(bullet-wrap::swig-lispify "btCollisionObject_makeCPlusPlusInstance" 'function) (ff-pointer self) sizeInBytes))

(cl:shadow "delete")
(cl:defmethod #.(bullet-wrap::swig-lispify "delete" 'method) ((self #.(bullet-wrap::swig-lispify "bt-collision-object" 'classname)) ptr)
  (#.(bullet-wrap::swig-lispify "btCollisionObject_deleteCPlusPlusInstance" 'function) (ff-pointer self) ptr))

(cl:shadow "new")
(cl:defmethod #.(bullet-wrap::swig-lispify "new" 'method) ((self #.(bullet-wrap::swig-lispify "bt-collision-object" 'classname)) arg1 ptr)
  (#.(bullet-wrap::swig-lispify "btCollisionObject_makeCPlusPlusInstance" 'function) (ff-pointer self) arg1 ptr))

(cl:shadow "delete")
(cl:defmethod #.(bullet-wrap::swig-lispify "delete" 'method) ((self #.(bullet-wrap::swig-lispify "bt-collision-object" 'classname)) arg1 arg2)
  (#.(bullet-wrap::swig-lispify "btCollisionObject_deleteCPlusPlusInstance" 'function) (ff-pointer self) arg1 arg2))

(cl:shadow "new[]")
(cl:defmethod #.(bullet-wrap::swig-lispify "new[]" 'method) ((self #.(bullet-wrap::swig-lispify "bt-collision-object" 'classname)) sizeInBytes)
  (#.(bullet-wrap::swig-lispify "btCollisionObject_makeCPlusArray" 'function) (ff-pointer self) sizeInBytes))

(cl:shadow "delete[]")
(cl:defmethod #.(bullet-wrap::swig-lispify "delete[]" 'method) ((self #.(bullet-wrap::swig-lispify "bt-collision-object" 'classname)) ptr)
  (#.(bullet-wrap::swig-lispify "btCollisionObject_deleteCPlusArray" 'function) (ff-pointer self) ptr))

(cl:shadow "new[]")
(cl:defmethod #.(bullet-wrap::swig-lispify "new[]" 'method) ((self #.(bullet-wrap::swig-lispify "bt-collision-object" 'classname)) arg1 ptr)
  (#.(bullet-wrap::swig-lispify "btCollisionObject_makeCPlusArray" 'function) (ff-pointer self) arg1 ptr))

(cl:shadow "delete[]")
(cl:defmethod #.(bullet-wrap::swig-lispify "delete[]" 'method) ((self #.(bullet-wrap::swig-lispify "bt-collision-object" 'classname)) arg1 arg2)
  (#.(bullet-wrap::swig-lispify "btCollisionObject_deleteCPlusArray" 'function) (ff-pointer self) arg1 arg2))

(cl:defmethod #.(bullet-wrap::swig-lispify "merges-simulation-islands" 'method) ((self #.(bullet-wrap::swig-lispify "bt-collision-object" 'classname)))
  (#.(bullet-wrap::swig-lispify "btCollisionObject_mergesSimulationIslands" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-anisotropic-friction" 'method) ((self #.(bullet-wrap::swig-lispify "bt-collision-object" 'classname)))
  (#.(bullet-wrap::swig-lispify "btCollisionObject_getAnisotropicFriction" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "set-anisotropic-friction" 'method) ((self #.(bullet-wrap::swig-lispify "bt-collision-object" 'classname)) (anisotropicFriction #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (frictionMode cl:integer))
  (#.(bullet-wrap::swig-lispify "btCollisionObject_setAnisotropicFriction" 'function) (ff-pointer self) anisotropicFriction frictionMode))

(cl:defmethod #.(bullet-wrap::swig-lispify "set-anisotropic-friction" 'method) ((self #.(bullet-wrap::swig-lispify "bt-collision-object" 'classname)) (anisotropicFriction #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)))
  (#.(bullet-wrap::swig-lispify "btCollisionObject_setAnisotropicFriction" 'function) (ff-pointer self) anisotropicFriction))

(cl:defmethod #.(bullet-wrap::swig-lispify "has-anisotropic-friction" 'method) ((self #.(bullet-wrap::swig-lispify "bt-collision-object" 'classname)) (frictionMode cl:integer))
  (#.(bullet-wrap::swig-lispify "btCollisionObject_hasAnisotropicFriction" 'function) (ff-pointer self) frictionMode))

(cl:defmethod #.(bullet-wrap::swig-lispify "has-anisotropic-friction" 'method) ((self #.(bullet-wrap::swig-lispify "bt-collision-object" 'classname)))
  (#.(bullet-wrap::swig-lispify "btCollisionObject_hasAnisotropicFriction" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "set-contact-processing-threshold" 'method) ((self #.(bullet-wrap::swig-lispify "bt-collision-object" 'classname)) (contactProcessingThreshold cl:number))
  (#.(bullet-wrap::swig-lispify "btCollisionObject_setContactProcessingThreshold" 'function) (ff-pointer self) contactProcessingThreshold))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-contact-processing-threshold" 'method) ((self #.(bullet-wrap::swig-lispify "bt-collision-object" 'classname)))
  (#.(bullet-wrap::swig-lispify "btCollisionObject_getContactProcessingThreshold" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "is-static-object" 'method) ((self #.(bullet-wrap::swig-lispify "bt-collision-object" 'classname)))
  (#.(bullet-wrap::swig-lispify "btCollisionObject_isStaticObject" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "is-kinematic-object" 'method) ((self #.(bullet-wrap::swig-lispify "bt-collision-object" 'classname)))
  (#.(bullet-wrap::swig-lispify "btCollisionObject_isKinematicObject" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "is-static-or-kinematic-object" 'method) ((self #.(bullet-wrap::swig-lispify "bt-collision-object" 'classname)))
  (#.(bullet-wrap::swig-lispify "btCollisionObject_isStaticOrKinematicObject" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "has-contact-response" 'method) ((self #.(bullet-wrap::swig-lispify "bt-collision-object" 'classname)))
  (#.(bullet-wrap::swig-lispify "btCollisionObject_hasContactResponse" 'function) (ff-pointer self)))

(cl:defmethod initialize-instance :after ((obj #.(bullet-wrap::swig-lispify "bt-collision-object" 'class)) &key)
  (setf (slot-value obj 'ff-pointer) (#.(bullet-wrap::swig-lispify "new_btCollisionObject" 'function))))

(cl:defmethod #.(bullet-wrap::swig-lispify "set-collision-shape" 'method) ((self #.(bullet-wrap::swig-lispify "bt-collision-object" 'classname)) collisionShape)
  (#.(bullet-wrap::swig-lispify "btCollisionObject_setCollisionShape" 'function) (ff-pointer self) collisionShape))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-collision-shape" 'method) ((self #.(bullet-wrap::swig-lispify "bt-collision-object" 'classname)))
  (#.(bullet-wrap::swig-lispify "btCollisionObject_getCollisionShape" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-collision-shape" 'method) ((self #.(bullet-wrap::swig-lispify "bt-collision-object" 'classname)))
  (#.(bullet-wrap::swig-lispify "btCollisionObject_getCollisionShape" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "internal-get-extension-pointer" 'method) ((self #.(bullet-wrap::swig-lispify "bt-collision-object" 'classname)))
  (#.(bullet-wrap::swig-lispify "btCollisionObject_internalGetExtensionPointer" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "internal-set-extension-pointer" 'method) ((self #.(bullet-wrap::swig-lispify "bt-collision-object" 'classname)) pointer)
  (#.(bullet-wrap::swig-lispify "btCollisionObject_internalSetExtensionPointer" 'function) (ff-pointer self) pointer))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-activation-state" 'method) ((self #.(bullet-wrap::swig-lispify "bt-collision-object" 'classname)))
  (#.(bullet-wrap::swig-lispify "btCollisionObject_getActivationState" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "set-activation-state" 'method) ((self #.(bullet-wrap::swig-lispify "bt-collision-object" 'classname)) (newState cl:integer))
  (#.(bullet-wrap::swig-lispify "btCollisionObject_setActivationState" 'function) (ff-pointer self) newState))

(cl:defmethod #.(bullet-wrap::swig-lispify "set-deactivation-time" 'method) ((self #.(bullet-wrap::swig-lispify "bt-collision-object" 'classname)) (time cl:number))
  (#.(bullet-wrap::swig-lispify "btCollisionObject_setDeactivationTime" 'function) (ff-pointer self) time))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-deactivation-time" 'method) ((self #.(bullet-wrap::swig-lispify "bt-collision-object" 'classname)))
  (#.(bullet-wrap::swig-lispify "btCollisionObject_getDeactivationTime" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "force-activation-state" 'method) ((self #.(bullet-wrap::swig-lispify "bt-collision-object" 'classname)) (newState cl:integer))
  (#.(bullet-wrap::swig-lispify "btCollisionObject_forceActivationState" 'function) (ff-pointer self) newState))

(cl:defmethod #.(bullet-wrap::swig-lispify "activate" 'method) ((self #.(bullet-wrap::swig-lispify "bt-collision-object" 'classname)) (forceActivation t))
  (#.(bullet-wrap::swig-lispify "btCollisionObject_activate" 'function) (ff-pointer self) forceActivation))

(cl:defmethod #.(bullet-wrap::swig-lispify "activate" 'method) ((self #.(bullet-wrap::swig-lispify "bt-collision-object" 'classname)))
  (#.(bullet-wrap::swig-lispify "btCollisionObject_activate" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "is-active" 'method) ((self #.(bullet-wrap::swig-lispify "bt-collision-object" 'classname)))
  (#.(bullet-wrap::swig-lispify "btCollisionObject_isActive" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "set-restitution" 'method) ((self #.(bullet-wrap::swig-lispify "bt-collision-object" 'classname)) (rest cl:number))
  (#.(bullet-wrap::swig-lispify "btCollisionObject_setRestitution" 'function) (ff-pointer self) rest))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-restitution" 'method) ((self #.(bullet-wrap::swig-lispify "bt-collision-object" 'classname)))
  (#.(bullet-wrap::swig-lispify "btCollisionObject_getRestitution" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "set-friction" 'method) ((self #.(bullet-wrap::swig-lispify "bt-collision-object" 'classname)) (frict cl:number))
  (#.(bullet-wrap::swig-lispify "btCollisionObject_setFriction" 'function) (ff-pointer self) frict))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-friction" 'method) ((self #.(bullet-wrap::swig-lispify "bt-collision-object" 'classname)))
  (#.(bullet-wrap::swig-lispify "btCollisionObject_getFriction" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "set-rolling-friction" 'method) ((self #.(bullet-wrap::swig-lispify "bt-collision-object" 'classname)) (frict cl:number))
  (#.(bullet-wrap::swig-lispify "btCollisionObject_setRollingFriction" 'function) (ff-pointer self) frict))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-rolling-friction" 'method) ((self #.(bullet-wrap::swig-lispify "bt-collision-object" 'classname)))
  (#.(bullet-wrap::swig-lispify "btCollisionObject_getRollingFriction" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-internal-type" 'method) ((self #.(bullet-wrap::swig-lispify "bt-collision-object" 'classname)))
  (#.(bullet-wrap::swig-lispify "btCollisionObject_getInternalType" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-world-transform" 'method) ((self #.(bullet-wrap::swig-lispify "bt-collision-object" 'classname)))
  (#.(bullet-wrap::swig-lispify "btCollisionObject_getWorldTransform" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-world-transform" 'method) ((self #.(bullet-wrap::swig-lispify "bt-collision-object" 'classname)))
  (#.(bullet-wrap::swig-lispify "btCollisionObject_getWorldTransform" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "set-world-transform" 'method) ((self #.(bullet-wrap::swig-lispify "bt-collision-object" 'classname)) (worldTrans #.(bullet-wrap::swig-lispify "bt-transform" 'classname)))
  (#.(bullet-wrap::swig-lispify "btCollisionObject_setWorldTransform" 'function) (ff-pointer self) worldTrans))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-broadphase-handle" 'method) ((self #.(bullet-wrap::swig-lispify "bt-collision-object" 'classname)))
  (#.(bullet-wrap::swig-lispify "btCollisionObject_getBroadphaseHandle" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-broadphase-handle" 'method) ((self #.(bullet-wrap::swig-lispify "bt-collision-object" 'classname)))
  (#.(bullet-wrap::swig-lispify "btCollisionObject_getBroadphaseHandle" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "set-broadphase-handle" 'method) ((self #.(bullet-wrap::swig-lispify "bt-collision-object" 'classname)) handle)
  (#.(bullet-wrap::swig-lispify "btCollisionObject_setBroadphaseHandle" 'function) (ff-pointer self) handle))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-interpolation-world-transform" 'method) ((self #.(bullet-wrap::swig-lispify "bt-collision-object" 'classname)))
  (#.(bullet-wrap::swig-lispify "btCollisionObject_getInterpolationWorldTransform" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-interpolation-world-transform" 'method) ((self #.(bullet-wrap::swig-lispify "bt-collision-object" 'classname)))
  (#.(bullet-wrap::swig-lispify "btCollisionObject_getInterpolationWorldTransform" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "set-interpolation-world-transform" 'method) ((self #.(bullet-wrap::swig-lispify "bt-collision-object" 'classname)) (trans #.(bullet-wrap::swig-lispify "bt-transform" 'classname)))
  (#.(bullet-wrap::swig-lispify "btCollisionObject_setInterpolationWorldTransform" 'function) (ff-pointer self) trans))

(cl:defmethod #.(bullet-wrap::swig-lispify "set-interpolation-linear-velocity" 'method) ((self #.(bullet-wrap::swig-lispify "bt-collision-object" 'classname)) (linvel #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)))
  (#.(bullet-wrap::swig-lispify "btCollisionObject_setInterpolationLinearVelocity" 'function) (ff-pointer self) linvel))

(cl:defmethod #.(bullet-wrap::swig-lispify "set-interpolation-angular-velocity" 'method) ((self #.(bullet-wrap::swig-lispify "bt-collision-object" 'classname)) (angvel #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)))
  (#.(bullet-wrap::swig-lispify "btCollisionObject_setInterpolationAngularVelocity" 'function) (ff-pointer self) angvel))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-interpolation-linear-velocity" 'method) ((self #.(bullet-wrap::swig-lispify "bt-collision-object" 'classname)))
  (#.(bullet-wrap::swig-lispify "btCollisionObject_getInterpolationLinearVelocity" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-interpolation-angular-velocity" 'method) ((self #.(bullet-wrap::swig-lispify "bt-collision-object" 'classname)))
  (#.(bullet-wrap::swig-lispify "btCollisionObject_getInterpolationAngularVelocity" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-island-tag" 'method) ((self #.(bullet-wrap::swig-lispify "bt-collision-object" 'classname)))
  (#.(bullet-wrap::swig-lispify "btCollisionObject_getIslandTag" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "set-island-tag" 'method) ((self #.(bullet-wrap::swig-lispify "bt-collision-object" 'classname)) (tag cl:integer))
  (#.(bullet-wrap::swig-lispify "btCollisionObject_setIslandTag" 'function) (ff-pointer self) tag))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-companion-id" 'method) ((self #.(bullet-wrap::swig-lispify "bt-collision-object" 'classname)))
  (#.(bullet-wrap::swig-lispify "btCollisionObject_getCompanionId" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "set-companion-id" 'method) ((self #.(bullet-wrap::swig-lispify "bt-collision-object" 'classname)) (id cl:integer))
  (#.(bullet-wrap::swig-lispify "btCollisionObject_setCompanionId" 'function) (ff-pointer self) id))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-hit-fraction" 'method) ((self #.(bullet-wrap::swig-lispify "bt-collision-object" 'classname)))
  (#.(bullet-wrap::swig-lispify "btCollisionObject_getHitFraction" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "set-hit-fraction" 'method) ((self #.(bullet-wrap::swig-lispify "bt-collision-object" 'classname)) (hitFraction cl:number))
  (#.(bullet-wrap::swig-lispify "btCollisionObject_setHitFraction" 'function) (ff-pointer self) hitFraction))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-collision-flags" 'method) ((self #.(bullet-wrap::swig-lispify "bt-collision-object" 'classname)))
  (#.(bullet-wrap::swig-lispify "btCollisionObject_getCollisionFlags" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "set-collision-flags" 'method) ((self #.(bullet-wrap::swig-lispify "bt-collision-object" 'classname)) (flags cl:integer))
  (#.(bullet-wrap::swig-lispify "btCollisionObject_setCollisionFlags" 'function) (ff-pointer self) flags))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-ccd-swept-sphere-radius" 'method) ((self #.(bullet-wrap::swig-lispify "bt-collision-object" 'classname)))
  (#.(bullet-wrap::swig-lispify "btCollisionObject_getCcdSweptSphereRadius" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "set-ccd-swept-sphere-radius" 'method) ((self #.(bullet-wrap::swig-lispify "bt-collision-object" 'classname)) (radius cl:number))
  (#.(bullet-wrap::swig-lispify "btCollisionObject_setCcdSweptSphereRadius" 'function) (ff-pointer self) radius))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-ccd-motion-threshold" 'method) ((self #.(bullet-wrap::swig-lispify "bt-collision-object" 'classname)))
  (#.(bullet-wrap::swig-lispify "btCollisionObject_getCcdMotionThreshold" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-ccd-square-motion-threshold" 'method) ((self #.(bullet-wrap::swig-lispify "bt-collision-object" 'classname)))
  (#.(bullet-wrap::swig-lispify "btCollisionObject_getCcdSquareMotionThreshold" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "set-ccd-motion-threshold" 'method) ((self #.(bullet-wrap::swig-lispify "bt-collision-object" 'classname)) (ccdMotionThreshold cl:number))
  (#.(bullet-wrap::swig-lispify "btCollisionObject_setCcdMotionThreshold" 'function) (ff-pointer self) ccdMotionThreshold))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-user-pointer" 'method) ((self #.(bullet-wrap::swig-lispify "bt-collision-object" 'classname)))
  (#.(bullet-wrap::swig-lispify "btCollisionObject_getUserPointer" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-user-index" 'method) ((self #.(bullet-wrap::swig-lispify "bt-collision-object" 'classname)))
  (#.(bullet-wrap::swig-lispify "btCollisionObject_getUserIndex" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "set-user-pointer" 'method) ((self #.(bullet-wrap::swig-lispify "bt-collision-object" 'classname)) userPointer)
  (#.(bullet-wrap::swig-lispify "btCollisionObject_setUserPointer" 'function) (ff-pointer self) userPointer))

(cl:defmethod #.(bullet-wrap::swig-lispify "set-user-index" 'method) ((self #.(bullet-wrap::swig-lispify "bt-collision-object" 'classname)) (index cl:integer))
  (#.(bullet-wrap::swig-lispify "btCollisionObject_setUserIndex" 'function) (ff-pointer self) index))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-update-revision-internal" 'method) ((self #.(bullet-wrap::swig-lispify "bt-collision-object" 'classname)))
  (#.(bullet-wrap::swig-lispify "btCollisionObject_getUpdateRevisionInternal" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "check-collide-with" 'method) ((self #.(bullet-wrap::swig-lispify "bt-collision-object" 'classname)) (co #.(bullet-wrap::swig-lispify "bt-collision-object" 'classname)))
  (#.(bullet-wrap::swig-lispify "btCollisionObject_checkCollideWith" 'function) (ff-pointer self) (ff-pointer co)))

(cl:defmethod #.(bullet-wrap::swig-lispify "calculate-serialize-buffer-size" 'method) ((self #.(bullet-wrap::swig-lispify "bt-collision-object" 'classname)))
  (#.(bullet-wrap::swig-lispify "btCollisionObject_calculateSerializeBufferSize" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "serialize" 'method) ((self #.(bullet-wrap::swig-lispify "bt-collision-object" 'classname)) dataBuffer serializer)
  (#.(bullet-wrap::swig-lispify "btCollisionObject_serialize" 'function) (ff-pointer self) dataBuffer serializer))

(cl:defmethod #.(bullet-wrap::swig-lispify "serialize-single-object" 'method) ((self #.(bullet-wrap::swig-lispify "bt-collision-object" 'classname)) serializer)
  (#.(bullet-wrap::swig-lispify "btCollisionObject_serializeSingleObject" 'function) (ff-pointer self) serializer))


(cl:defclass #.(bullet-wrap::swig-lispify "bt-box-shape" 'classname)()
  ((ff-pointer :reader ff-pointer)))

(cl:shadow "new")
(cl:defmethod #.(bullet-wrap::swig-lispify "new" 'method) ((self #.(bullet-wrap::swig-lispify "bt-box-shape" 'classname)) sizeInBytes)
  (#.(bullet-wrap::swig-lispify "btBoxShape_makeCPlusPlusInstance" 'function) (ff-pointer self) sizeInBytes))

(cl:shadow "delete")
(cl:defmethod #.(bullet-wrap::swig-lispify "delete" 'method) ((self #.(bullet-wrap::swig-lispify "bt-box-shape" 'classname)) ptr)
  (#.(bullet-wrap::swig-lispify "btBoxShape_deleteCPlusPlusInstance" 'function) (ff-pointer self) ptr))

(cl:shadow "new")
(cl:defmethod #.(bullet-wrap::swig-lispify "new" 'method) ((self #.(bullet-wrap::swig-lispify "bt-box-shape" 'classname)) arg1 ptr)
  (#.(bullet-wrap::swig-lispify "btBoxShape_makeCPlusPlusInstance" 'function) (ff-pointer self) arg1 ptr))

(cl:shadow "delete")
(cl:defmethod #.(bullet-wrap::swig-lispify "delete" 'method) ((self #.(bullet-wrap::swig-lispify "bt-box-shape" 'classname)) arg1 arg2)
  (#.(bullet-wrap::swig-lispify "btBoxShape_deleteCPlusPlusInstance" 'function) (ff-pointer self) arg1 arg2))

(cl:shadow "new[]")
(cl:defmethod #.(bullet-wrap::swig-lispify "new[]" 'method) ((self #.(bullet-wrap::swig-lispify "bt-box-shape" 'classname)) sizeInBytes)
  (#.(bullet-wrap::swig-lispify "btBoxShape_makeCPlusArray" 'function) (ff-pointer self) sizeInBytes))

(cl:shadow "delete[]")
(cl:defmethod #.(bullet-wrap::swig-lispify "delete[]" 'method) ((self #.(bullet-wrap::swig-lispify "bt-box-shape" 'classname)) ptr)
  (#.(bullet-wrap::swig-lispify "btBoxShape_deleteCPlusArray" 'function) (ff-pointer self) ptr))

(cl:shadow "new[]")
(cl:defmethod #.(bullet-wrap::swig-lispify "new[]" 'method) ((self #.(bullet-wrap::swig-lispify "bt-box-shape" 'classname)) arg1 ptr)
  (#.(bullet-wrap::swig-lispify "btBoxShape_makeCPlusArray" 'function) (ff-pointer self) arg1 ptr))

(cl:shadow "delete[]")
(cl:defmethod #.(bullet-wrap::swig-lispify "delete[]" 'method) ((self #.(bullet-wrap::swig-lispify "bt-box-shape" 'classname)) arg1 arg2)
  (#.(bullet-wrap::swig-lispify "btBoxShape_deleteCPlusArray" 'function) (ff-pointer self) arg1 arg2))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-half-extents-with-margin" 'method) ((self #.(bullet-wrap::swig-lispify "bt-box-shape" 'classname)))
  (#.(bullet-wrap::swig-lispify "btBoxShape_getHalfExtentsWithMargin" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-half-extents-without-margin" 'method) ((self #.(bullet-wrap::swig-lispify "bt-box-shape" 'classname)))
  (#.(bullet-wrap::swig-lispify "btBoxShape_getHalfExtentsWithoutMargin" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "local-get-supporting-vertex" 'method) ((self #.(bullet-wrap::swig-lispify "bt-box-shape" 'classname)) (vec #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)))
  (#.(bullet-wrap::swig-lispify "btBoxShape_localGetSupportingVertex" 'function) (ff-pointer self) vec))

(cl:defmethod #.(bullet-wrap::swig-lispify "local-get-supporting-vertex-without-margin" 'method) ((self #.(bullet-wrap::swig-lispify "bt-box-shape" 'classname)) (vec #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)))
  (#.(bullet-wrap::swig-lispify "btBoxShape_localGetSupportingVertexWithoutMargin" 'function) (ff-pointer self) vec))

(cl:defmethod #.(bullet-wrap::swig-lispify "batched-unit-vector-get-supporting-vertex-without-margin" 'method) ((self #.(bullet-wrap::swig-lispify "bt-box-shape" 'classname)) (vectors #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (supportVerticesOut #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (numVectors cl:integer))
  (#.(bullet-wrap::swig-lispify "btBoxShape_batchedUnitVectorGetSupportingVertexWithoutMargin" 'function) (ff-pointer self) vectors supportVerticesOut numVectors))

(cl:defmethod initialize-instance :after ((obj #.(bullet-wrap::swig-lispify "bt-box-shape" 'class)) &key (boxHalfExtents #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)))
  (setf (slot-value obj 'ff-pointer) (#.(bullet-wrap::swig-lispify "new_btBoxShape" 'function) boxHalfExtents)))

(cl:defmethod #.(bullet-wrap::swig-lispify "set-margin" 'method) ((self #.(bullet-wrap::swig-lispify "bt-box-shape" 'classname)) (collisionMargin cl:number))
  (#.(bullet-wrap::swig-lispify "btBoxShape_setMargin" 'function) (ff-pointer self) collisionMargin))

(cl:defmethod #.(bullet-wrap::swig-lispify "set-local-scaling" 'method) ((self #.(bullet-wrap::swig-lispify "bt-box-shape" 'classname)) (scaling #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)))
  (#.(bullet-wrap::swig-lispify "btBoxShape_setLocalScaling" 'function) (ff-pointer self) scaling))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-aabb" 'method) ((self #.(bullet-wrap::swig-lispify "bt-box-shape" 'classname)) (t-arg1 #.(bullet-wrap::swig-lispify "bt-transform" 'classname)) (aabbMin #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (aabbMax #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)))
  (#.(bullet-wrap::swig-lispify "btBoxShape_getAabb" 'function) (ff-pointer self) t-arg1 aabbMin aabbMax))

(cl:defmethod #.(bullet-wrap::swig-lispify "calculate-local-inertia" 'method) ((self #.(bullet-wrap::swig-lispify "bt-box-shape" 'classname)) (mass cl:number) (inertia #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)))
  (#.(bullet-wrap::swig-lispify "btBoxShape_calculateLocalInertia" 'function) (ff-pointer self) mass inertia))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-plane" 'method) ((self #.(bullet-wrap::swig-lispify "bt-box-shape" 'classname)) (planeNormal #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (planeSupport #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (i cl:integer))
  (#.(bullet-wrap::swig-lispify "btBoxShape_getPlane" 'function) (ff-pointer self) planeNormal planeSupport i))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-num-planes" 'method) ((self #.(bullet-wrap::swig-lispify "bt-box-shape" 'classname)))
  (#.(bullet-wrap::swig-lispify "btBoxShape_getNumPlanes" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-num-vertices" 'method) ((self #.(bullet-wrap::swig-lispify "bt-box-shape" 'classname)))
  (#.(bullet-wrap::swig-lispify "btBoxShape_getNumVertices" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-num-edges" 'method) ((self #.(bullet-wrap::swig-lispify "bt-box-shape" 'classname)))
  (#.(bullet-wrap::swig-lispify "btBoxShape_getNumEdges" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-vertex" 'method) ((self #.(bullet-wrap::swig-lispify "bt-box-shape" 'classname)) (i cl:integer) (vtx #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)))
  (#.(bullet-wrap::swig-lispify "btBoxShape_getVertex" 'function) (ff-pointer self) i vtx))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-plane-equation" 'method) ((self #.(bullet-wrap::swig-lispify "bt-box-shape" 'classname)) (plane #.(bullet-wrap::swig-lispify "bt-vector4" 'classname)) (i cl:integer))
  (#.(bullet-wrap::swig-lispify "btBoxShape_getPlaneEquation" 'function) (ff-pointer self) plane i))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-edge" 'method) ((self #.(bullet-wrap::swig-lispify "bt-box-shape" 'classname)) (i cl:integer) (pa #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (pb #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)))
  (#.(bullet-wrap::swig-lispify "btBoxShape_getEdge" 'function) (ff-pointer self) i pa pb))

(cl:defmethod #.(bullet-wrap::swig-lispify "is-inside" 'method) ((self #.(bullet-wrap::swig-lispify "bt-box-shape" 'classname)) (pt #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (tolerance cl:number))
  (#.(bullet-wrap::swig-lispify "btBoxShape_isInside" 'function) (ff-pointer self) pt tolerance))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-name" 'method) ((self #.(bullet-wrap::swig-lispify "bt-box-shape" 'classname)))
  (#.(bullet-wrap::swig-lispify "btBoxShape_getName" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-num-preferred-penetration-directions" 'method) ((self #.(bullet-wrap::swig-lispify "bt-box-shape" 'classname)))
  (#.(bullet-wrap::swig-lispify "btBoxShape_getNumPreferredPenetrationDirections" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-preferred-penetration-direction" 'method) ((self #.(bullet-wrap::swig-lispify "bt-box-shape" 'classname)) (index cl:integer) (penetrationVector #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)))
  (#.(bullet-wrap::swig-lispify "btBoxShape_getPreferredPenetrationDirection" 'function) (ff-pointer self) index penetrationVector))


(cl:defclass #.(bullet-wrap::swig-lispify "bt-sphere-shape" 'classname)()
  ((ff-pointer :reader ff-pointer)))

(cl:shadow "new")
(cl:defmethod #.(bullet-wrap::swig-lispify "new" 'method) ((self #.(bullet-wrap::swig-lispify "bt-sphere-shape" 'classname)) sizeInBytes)
  (#.(bullet-wrap::swig-lispify "btSphereShape_makeCPlusPlusInstance" 'function) (ff-pointer self) sizeInBytes))

(cl:shadow "delete")
(cl:defmethod #.(bullet-wrap::swig-lispify "delete" 'method) ((self #.(bullet-wrap::swig-lispify "bt-sphere-shape" 'classname)) ptr)
  (#.(bullet-wrap::swig-lispify "btSphereShape_deleteCPlusPlusInstance" 'function) (ff-pointer self) ptr))

(cl:shadow "new")
(cl:defmethod #.(bullet-wrap::swig-lispify "new" 'method) ((self #.(bullet-wrap::swig-lispify "bt-sphere-shape" 'classname)) arg1 ptr)
  (#.(bullet-wrap::swig-lispify "btSphereShape_makeCPlusPlusInstance" 'function) (ff-pointer self) arg1 ptr))

(cl:shadow "delete")
(cl:defmethod #.(bullet-wrap::swig-lispify "delete" 'method) ((self #.(bullet-wrap::swig-lispify "bt-sphere-shape" 'classname)) arg1 arg2)
  (#.(bullet-wrap::swig-lispify "btSphereShape_deleteCPlusPlusInstance" 'function) (ff-pointer self) arg1 arg2))

(cl:shadow "new[]")
(cl:defmethod #.(bullet-wrap::swig-lispify "new[]" 'method) ((self #.(bullet-wrap::swig-lispify "bt-sphere-shape" 'classname)) sizeInBytes)
  (#.(bullet-wrap::swig-lispify "btSphereShape_makeCPlusArray" 'function) (ff-pointer self) sizeInBytes))

(cl:shadow "delete[]")
(cl:defmethod #.(bullet-wrap::swig-lispify "delete[]" 'method) ((self #.(bullet-wrap::swig-lispify "bt-sphere-shape" 'classname)) ptr)
  (#.(bullet-wrap::swig-lispify "btSphereShape_deleteCPlusArray" 'function) (ff-pointer self) ptr))

(cl:shadow "new[]")
(cl:defmethod #.(bullet-wrap::swig-lispify "new[]" 'method) ((self #.(bullet-wrap::swig-lispify "bt-sphere-shape" 'classname)) arg1 ptr)
  (#.(bullet-wrap::swig-lispify "btSphereShape_makeCPlusArray" 'function) (ff-pointer self) arg1 ptr))

(cl:shadow "delete[]")
(cl:defmethod #.(bullet-wrap::swig-lispify "delete[]" 'method) ((self #.(bullet-wrap::swig-lispify "bt-sphere-shape" 'classname)) arg1 arg2)
  (#.(bullet-wrap::swig-lispify "btSphereShape_deleteCPlusArray" 'function) (ff-pointer self) arg1 arg2))

(cl:defmethod initialize-instance :after ((obj #.(bullet-wrap::swig-lispify "bt-sphere-shape" 'class)) &key (radius cl:number))
  (setf (slot-value obj 'ff-pointer) (#.(bullet-wrap::swig-lispify "new_btSphereShape" 'function) radius)))

(cl:defmethod #.(bullet-wrap::swig-lispify "local-get-supporting-vertex" 'method) ((self #.(bullet-wrap::swig-lispify "bt-sphere-shape" 'classname)) (vec #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)))
  (#.(bullet-wrap::swig-lispify "btSphereShape_localGetSupportingVertex" 'function) (ff-pointer self) vec))

(cl:defmethod #.(bullet-wrap::swig-lispify "local-get-supporting-vertex-without-margin" 'method) ((self #.(bullet-wrap::swig-lispify "bt-sphere-shape" 'classname)) (vec #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)))
  (#.(bullet-wrap::swig-lispify "btSphereShape_localGetSupportingVertexWithoutMargin" 'function) (ff-pointer self) vec))

(cl:defmethod #.(bullet-wrap::swig-lispify "batched-unit-vector-get-supporting-vertex-without-margin" 'method) ((self #.(bullet-wrap::swig-lispify "bt-sphere-shape" 'classname)) (vectors #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (supportVerticesOut #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (numVectors cl:integer))
  (#.(bullet-wrap::swig-lispify "btSphereShape_batchedUnitVectorGetSupportingVertexWithoutMargin" 'function) (ff-pointer self) vectors supportVerticesOut numVectors))

(cl:defmethod #.(bullet-wrap::swig-lispify "calculate-local-inertia" 'method) ((self #.(bullet-wrap::swig-lispify "bt-sphere-shape" 'classname)) (mass cl:number) (inertia #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)))
  (#.(bullet-wrap::swig-lispify "btSphereShape_calculateLocalInertia" 'function) (ff-pointer self) mass inertia))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-aabb" 'method) ((self #.(bullet-wrap::swig-lispify "bt-sphere-shape" 'classname)) (t-arg1 #.(bullet-wrap::swig-lispify "bt-transform" 'classname)) (aabbMin #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (aabbMax #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)))
  (#.(bullet-wrap::swig-lispify "btSphereShape_getAabb" 'function) (ff-pointer self) t-arg1 aabbMin aabbMax))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-radius" 'method) ((self #.(bullet-wrap::swig-lispify "bt-sphere-shape" 'classname)))
  (#.(bullet-wrap::swig-lispify "btSphereShape_getRadius" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "set-unscaled-radius" 'method) ((self #.(bullet-wrap::swig-lispify "bt-sphere-shape" 'classname)) (radius cl:number))
  (#.(bullet-wrap::swig-lispify "btSphereShape_setUnscaledRadius" 'function) (ff-pointer self) radius))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-name" 'method) ((self #.(bullet-wrap::swig-lispify "bt-sphere-shape" 'classname)))
  (#.(bullet-wrap::swig-lispify "btSphereShape_getName" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "set-margin" 'method) ((self #.(bullet-wrap::swig-lispify "bt-sphere-shape" 'classname)) (margin cl:number))
  (#.(bullet-wrap::swig-lispify "btSphereShape_setMargin" 'function) (ff-pointer self) margin))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-margin" 'method) ((self #.(bullet-wrap::swig-lispify "bt-sphere-shape" 'classname)))
  (#.(bullet-wrap::swig-lispify "btSphereShape_getMargin" 'function) (ff-pointer self)))


(cl:defclass #.(bullet-wrap::swig-lispify "bt-capsule-shape" 'classname)()
  ((ff-pointer :reader ff-pointer)))

(cl:shadow "new")
(cl:defmethod #.(bullet-wrap::swig-lispify "new" 'method) ((self #.(bullet-wrap::swig-lispify "bt-capsule-shape" 'classname)) sizeInBytes)
  (#.(bullet-wrap::swig-lispify "btCapsuleShape_makeCPlusPlusInstance" 'function) (ff-pointer self) sizeInBytes))

(cl:shadow "delete")
(cl:defmethod #.(bullet-wrap::swig-lispify "delete" 'method) ((self #.(bullet-wrap::swig-lispify "bt-capsule-shape" 'classname)) ptr)
  (#.(bullet-wrap::swig-lispify "btCapsuleShape_deleteCPlusPlusInstance" 'function) (ff-pointer self) ptr))

(cl:shadow "new")
(cl:defmethod #.(bullet-wrap::swig-lispify "new" 'method) ((self #.(bullet-wrap::swig-lispify "bt-capsule-shape" 'classname)) arg1 ptr)
  (#.(bullet-wrap::swig-lispify "btCapsuleShape_makeCPlusPlusInstance" 'function) (ff-pointer self) arg1 ptr))

(cl:shadow "delete")
(cl:defmethod #.(bullet-wrap::swig-lispify "delete" 'method) ((self #.(bullet-wrap::swig-lispify "bt-capsule-shape" 'classname)) arg1 arg2)
  (#.(bullet-wrap::swig-lispify "btCapsuleShape_deleteCPlusPlusInstance" 'function) (ff-pointer self) arg1 arg2))

(cl:shadow "new[]")
(cl:defmethod #.(bullet-wrap::swig-lispify "new[]" 'method) ((self #.(bullet-wrap::swig-lispify "bt-capsule-shape" 'classname)) sizeInBytes)
  (#.(bullet-wrap::swig-lispify "btCapsuleShape_makeCPlusArray" 'function) (ff-pointer self) sizeInBytes))

(cl:shadow "delete[]")
(cl:defmethod #.(bullet-wrap::swig-lispify "delete[]" 'method) ((self #.(bullet-wrap::swig-lispify "bt-capsule-shape" 'classname)) ptr)
  (#.(bullet-wrap::swig-lispify "btCapsuleShape_deleteCPlusArray" 'function) (ff-pointer self) ptr))

(cl:shadow "new[]")
(cl:defmethod #.(bullet-wrap::swig-lispify "new[]" 'method) ((self #.(bullet-wrap::swig-lispify "bt-capsule-shape" 'classname)) arg1 ptr)
  (#.(bullet-wrap::swig-lispify "btCapsuleShape_makeCPlusArray" 'function) (ff-pointer self) arg1 ptr))

(cl:shadow "delete[]")
(cl:defmethod #.(bullet-wrap::swig-lispify "delete[]" 'method) ((self #.(bullet-wrap::swig-lispify "bt-capsule-shape" 'classname)) arg1 arg2)
  (#.(bullet-wrap::swig-lispify "btCapsuleShape_deleteCPlusArray" 'function) (ff-pointer self) arg1 arg2))

(cl:defmethod initialize-instance :after ((obj #.(bullet-wrap::swig-lispify "bt-capsule-shape" 'class)) &key (radius cl:number) (height cl:number))
  (setf (slot-value obj 'ff-pointer) (#.(bullet-wrap::swig-lispify "new_btCapsuleShape" 'function) radius height)))

(cl:defmethod #.(bullet-wrap::swig-lispify "calculate-local-inertia" 'method) ((self #.(bullet-wrap::swig-lispify "bt-capsule-shape" 'classname)) (mass cl:number) (inertia #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)))
  (#.(bullet-wrap::swig-lispify "btCapsuleShape_calculateLocalInertia" 'function) (ff-pointer self) mass inertia))

(cl:defmethod #.(bullet-wrap::swig-lispify "local-get-supporting-vertex-without-margin" 'method) ((self #.(bullet-wrap::swig-lispify "bt-capsule-shape" 'classname)) (vec #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)))
  (#.(bullet-wrap::swig-lispify "btCapsuleShape_localGetSupportingVertexWithoutMargin" 'function) (ff-pointer self) vec))

(cl:defmethod #.(bullet-wrap::swig-lispify "batched-unit-vector-get-supporting-vertex-without-margin" 'method) ((self #.(bullet-wrap::swig-lispify "bt-capsule-shape" 'classname)) (vectors #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (supportVerticesOut #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (numVectors cl:integer))
  (#.(bullet-wrap::swig-lispify "btCapsuleShape_batchedUnitVectorGetSupportingVertexWithoutMargin" 'function) (ff-pointer self) vectors supportVerticesOut numVectors))

(cl:defmethod #.(bullet-wrap::swig-lispify "set-margin" 'method) ((self #.(bullet-wrap::swig-lispify "bt-capsule-shape" 'classname)) (collisionMargin cl:number))
  (#.(bullet-wrap::swig-lispify "btCapsuleShape_setMargin" 'function) (ff-pointer self) collisionMargin))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-aabb" 'method) ((self #.(bullet-wrap::swig-lispify "bt-capsule-shape" 'classname)) (t-arg1 #.(bullet-wrap::swig-lispify "bt-transform" 'classname)) (aabbMin #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (aabbMax #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)))
  (#.(bullet-wrap::swig-lispify "btCapsuleShape_getAabb" 'function) (ff-pointer self) t-arg1 aabbMin aabbMax))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-name" 'method) ((self #.(bullet-wrap::swig-lispify "bt-capsule-shape" 'classname)))
  (#.(bullet-wrap::swig-lispify "btCapsuleShape_getName" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-up-axis" 'method) ((self #.(bullet-wrap::swig-lispify "bt-capsule-shape" 'classname)))
  (#.(bullet-wrap::swig-lispify "btCapsuleShape_getUpAxis" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-radius" 'method) ((self #.(bullet-wrap::swig-lispify "bt-capsule-shape" 'classname)))
  (#.(bullet-wrap::swig-lispify "btCapsuleShape_getRadius" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-half-height" 'method) ((self #.(bullet-wrap::swig-lispify "bt-capsule-shape" 'classname)))
  (#.(bullet-wrap::swig-lispify "btCapsuleShape_getHalfHeight" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "set-local-scaling" 'method) ((self #.(bullet-wrap::swig-lispify "bt-capsule-shape" 'classname)) (scaling #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)))
  (#.(bullet-wrap::swig-lispify "btCapsuleShape_setLocalScaling" 'function) (ff-pointer self) scaling))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-anisotropic-rolling-friction-direction" 'method) ((self #.(bullet-wrap::swig-lispify "bt-capsule-shape" 'classname)))
  (#.(bullet-wrap::swig-lispify "btCapsuleShape_getAnisotropicRollingFrictionDirection" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "calculate-serialize-buffer-size" 'method) ((self #.(bullet-wrap::swig-lispify "bt-capsule-shape" 'classname)))
  (#.(bullet-wrap::swig-lispify "btCapsuleShape_calculateSerializeBufferSize" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "serialize" 'method) ((self #.(bullet-wrap::swig-lispify "bt-capsule-shape" 'classname)) dataBuffer serializer)
  (#.(bullet-wrap::swig-lispify "btCapsuleShape_serialize" 'function) (ff-pointer self) dataBuffer serializer))


(cl:defclass #.(bullet-wrap::swig-lispify "bt-capsule-shape-x" 'classname)(#.(bullet-wrap::swig-lispify "btCapsuleShape" 'classname))
  ((ff-pointer :reader ff-pointer)))

(cl:defmethod initialize-instance :after ((obj #.(bullet-wrap::swig-lispify "bt-capsule-shape-x" 'class)) &key (radius cl:number) (height cl:number))
  (setf (slot-value obj 'ff-pointer) (#.(bullet-wrap::swig-lispify "new_btCapsuleShapeX" 'function) radius height)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-name" 'method) ((self #.(bullet-wrap::swig-lispify "bt-capsule-shape-x" 'classname)))
  (#.(bullet-wrap::swig-lispify "btCapsuleShapeX_getName" 'function) (ff-pointer self)))


(cl:defclass #.(bullet-wrap::swig-lispify "bt-capsule-shape-z" 'classname)(#.(bullet-wrap::swig-lispify "btCapsuleShape" 'classname))
  ((ff-pointer :reader ff-pointer)))

(cl:defmethod initialize-instance :after ((obj #.(bullet-wrap::swig-lispify "bt-capsule-shape-z" 'class)) &key (radius cl:number) (height cl:number))
  (setf (slot-value obj 'ff-pointer) (#.(bullet-wrap::swig-lispify "new_btCapsuleShapeZ" 'function) radius height)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-name" 'method) ((self #.(bullet-wrap::swig-lispify "bt-capsule-shape-z" 'classname)))
  (#.(bullet-wrap::swig-lispify "btCapsuleShapeZ_getName" 'function) (ff-pointer self)))


(cl:defclass #.(bullet-wrap::swig-lispify "bt-cylinder-shape" 'classname)()
  ((ff-pointer :reader ff-pointer)))

(cl:shadow "new")
(cl:defmethod #.(bullet-wrap::swig-lispify "new" 'method) ((self #.(bullet-wrap::swig-lispify "bt-cylinder-shape" 'classname)) sizeInBytes)
  (#.(bullet-wrap::swig-lispify "btCylinderShape_makeCPlusPlusInstance" 'function) (ff-pointer self) sizeInBytes))

(cl:shadow "delete")
(cl:defmethod #.(bullet-wrap::swig-lispify "delete" 'method) ((self #.(bullet-wrap::swig-lispify "bt-cylinder-shape" 'classname)) ptr)
  (#.(bullet-wrap::swig-lispify "btCylinderShape_deleteCPlusPlusInstance" 'function) (ff-pointer self) ptr))

(cl:shadow "new")
(cl:defmethod #.(bullet-wrap::swig-lispify "new" 'method) ((self #.(bullet-wrap::swig-lispify "bt-cylinder-shape" 'classname)) arg1 ptr)
  (#.(bullet-wrap::swig-lispify "btCylinderShape_makeCPlusPlusInstance" 'function) (ff-pointer self) arg1 ptr))

(cl:shadow "delete")
(cl:defmethod #.(bullet-wrap::swig-lispify "delete" 'method) ((self #.(bullet-wrap::swig-lispify "bt-cylinder-shape" 'classname)) arg1 arg2)
  (#.(bullet-wrap::swig-lispify "btCylinderShape_deleteCPlusPlusInstance" 'function) (ff-pointer self) arg1 arg2))

(cl:shadow "new[]")
(cl:defmethod #.(bullet-wrap::swig-lispify "new[]" 'method) ((self #.(bullet-wrap::swig-lispify "bt-cylinder-shape" 'classname)) sizeInBytes)
  (#.(bullet-wrap::swig-lispify "btCylinderShape_makeCPlusArray" 'function) (ff-pointer self) sizeInBytes))

(cl:shadow "delete[]")
(cl:defmethod #.(bullet-wrap::swig-lispify "delete[]" 'method) ((self #.(bullet-wrap::swig-lispify "bt-cylinder-shape" 'classname)) ptr)
  (#.(bullet-wrap::swig-lispify "btCylinderShape_deleteCPlusArray" 'function) (ff-pointer self) ptr))

(cl:shadow "new[]")
(cl:defmethod #.(bullet-wrap::swig-lispify "new[]" 'method) ((self #.(bullet-wrap::swig-lispify "bt-cylinder-shape" 'classname)) arg1 ptr)
  (#.(bullet-wrap::swig-lispify "btCylinderShape_makeCPlusArray" 'function) (ff-pointer self) arg1 ptr))

(cl:shadow "delete[]")
(cl:defmethod #.(bullet-wrap::swig-lispify "delete[]" 'method) ((self #.(bullet-wrap::swig-lispify "bt-cylinder-shape" 'classname)) arg1 arg2)
  (#.(bullet-wrap::swig-lispify "btCylinderShape_deleteCPlusArray" 'function) (ff-pointer self) arg1 arg2))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-half-extents-with-margin" 'method) ((self #.(bullet-wrap::swig-lispify "bt-cylinder-shape" 'classname)))
  (#.(bullet-wrap::swig-lispify "btCylinderShape_getHalfExtentsWithMargin" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-half-extents-without-margin" 'method) ((self #.(bullet-wrap::swig-lispify "bt-cylinder-shape" 'classname)))
  (#.(bullet-wrap::swig-lispify "btCylinderShape_getHalfExtentsWithoutMargin" 'function) (ff-pointer self)))

(cl:defmethod initialize-instance :after ((obj #.(bullet-wrap::swig-lispify "bt-cylinder-shape" 'class)) &key (halfExtents #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)))
  (setf (slot-value obj 'ff-pointer) (#.(bullet-wrap::swig-lispify "new_btCylinderShape" 'function) halfExtents)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-aabb" 'method) ((self #.(bullet-wrap::swig-lispify "bt-cylinder-shape" 'classname)) (t-arg1 #.(bullet-wrap::swig-lispify "bt-transform" 'classname)) (aabbMin #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (aabbMax #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)))
  (#.(bullet-wrap::swig-lispify "btCylinderShape_getAabb" 'function) (ff-pointer self) t-arg1 aabbMin aabbMax))

(cl:defmethod #.(bullet-wrap::swig-lispify "calculate-local-inertia" 'method) ((self #.(bullet-wrap::swig-lispify "bt-cylinder-shape" 'classname)) (mass cl:number) (inertia #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)))
  (#.(bullet-wrap::swig-lispify "btCylinderShape_calculateLocalInertia" 'function) (ff-pointer self) mass inertia))

(cl:defmethod #.(bullet-wrap::swig-lispify "local-get-supporting-vertex-without-margin" 'method) ((self #.(bullet-wrap::swig-lispify "bt-cylinder-shape" 'classname)) (vec #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)))
  (#.(bullet-wrap::swig-lispify "btCylinderShape_localGetSupportingVertexWithoutMargin" 'function) (ff-pointer self) vec))

(cl:defmethod #.(bullet-wrap::swig-lispify "batched-unit-vector-get-supporting-vertex-without-margin" 'method) ((self #.(bullet-wrap::swig-lispify "bt-cylinder-shape" 'classname)) (vectors #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (supportVerticesOut #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (numVectors cl:integer))
  (#.(bullet-wrap::swig-lispify "btCylinderShape_batchedUnitVectorGetSupportingVertexWithoutMargin" 'function) (ff-pointer self) vectors supportVerticesOut numVectors))

(cl:defmethod #.(bullet-wrap::swig-lispify "set-margin" 'method) ((self #.(bullet-wrap::swig-lispify "bt-cylinder-shape" 'classname)) (collisionMargin cl:number))
  (#.(bullet-wrap::swig-lispify "btCylinderShape_setMargin" 'function) (ff-pointer self) collisionMargin))

(cl:defmethod #.(bullet-wrap::swig-lispify "local-get-supporting-vertex" 'method) ((self #.(bullet-wrap::swig-lispify "bt-cylinder-shape" 'classname)) (vec #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)))
  (#.(bullet-wrap::swig-lispify "btCylinderShape_localGetSupportingVertex" 'function) (ff-pointer self) vec))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-up-axis" 'method) ((self #.(bullet-wrap::swig-lispify "bt-cylinder-shape" 'classname)))
  (#.(bullet-wrap::swig-lispify "btCylinderShape_getUpAxis" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-anisotropic-rolling-friction-direction" 'method) ((self #.(bullet-wrap::swig-lispify "bt-cylinder-shape" 'classname)))
  (#.(bullet-wrap::swig-lispify "btCylinderShape_getAnisotropicRollingFrictionDirection" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-radius" 'method) ((self #.(bullet-wrap::swig-lispify "bt-cylinder-shape" 'classname)))
  (#.(bullet-wrap::swig-lispify "btCylinderShape_getRadius" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "set-local-scaling" 'method) ((self #.(bullet-wrap::swig-lispify "bt-cylinder-shape" 'classname)) (scaling #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)))
  (#.(bullet-wrap::swig-lispify "btCylinderShape_setLocalScaling" 'function) (ff-pointer self) scaling))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-name" 'method) ((self #.(bullet-wrap::swig-lispify "bt-cylinder-shape" 'classname)))
  (#.(bullet-wrap::swig-lispify "btCylinderShape_getName" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "calculate-serialize-buffer-size" 'method) ((self #.(bullet-wrap::swig-lispify "bt-cylinder-shape" 'classname)))
  (#.(bullet-wrap::swig-lispify "btCylinderShape_calculateSerializeBufferSize" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "serialize" 'method) ((self #.(bullet-wrap::swig-lispify "bt-cylinder-shape" 'classname)) dataBuffer serializer)
  (#.(bullet-wrap::swig-lispify "btCylinderShape_serialize" 'function) (ff-pointer self) dataBuffer serializer))


(cl:defclass #.(bullet-wrap::swig-lispify "bt-cylinder-shape-x" 'classname)(#.(bullet-wrap::swig-lispify "btCylinderShape" 'classname))
  ((ff-pointer :reader ff-pointer)))

(cl:shadow "new")
(cl:defmethod #.(bullet-wrap::swig-lispify "new" 'method) ((self #.(bullet-wrap::swig-lispify "bt-cylinder-shape-x" 'classname)) sizeInBytes)
  (#.(bullet-wrap::swig-lispify "btCylinderShapeX_makeCPlusPlusInstance" 'function) (ff-pointer self) sizeInBytes))

(cl:shadow "delete")
(cl:defmethod #.(bullet-wrap::swig-lispify "delete" 'method) ((self #.(bullet-wrap::swig-lispify "bt-cylinder-shape-x" 'classname)) ptr)
  (#.(bullet-wrap::swig-lispify "btCylinderShapeX_deleteCPlusPlusInstance" 'function) (ff-pointer self) ptr))

(cl:shadow "new")
(cl:defmethod #.(bullet-wrap::swig-lispify "new" 'method) ((self #.(bullet-wrap::swig-lispify "bt-cylinder-shape-x" 'classname)) arg1 ptr)
  (#.(bullet-wrap::swig-lispify "btCylinderShapeX_makeCPlusPlusInstance" 'function) (ff-pointer self) arg1 ptr))

(cl:shadow "delete")
(cl:defmethod #.(bullet-wrap::swig-lispify "delete" 'method) ((self #.(bullet-wrap::swig-lispify "bt-cylinder-shape-x" 'classname)) arg1 arg2)
  (#.(bullet-wrap::swig-lispify "btCylinderShapeX_deleteCPlusPlusInstance" 'function) (ff-pointer self) arg1 arg2))

(cl:shadow "new[]")
(cl:defmethod #.(bullet-wrap::swig-lispify "new[]" 'method) ((self #.(bullet-wrap::swig-lispify "bt-cylinder-shape-x" 'classname)) sizeInBytes)
  (#.(bullet-wrap::swig-lispify "btCylinderShapeX_makeCPlusArray" 'function) (ff-pointer self) sizeInBytes))

(cl:shadow "delete[]")
(cl:defmethod #.(bullet-wrap::swig-lispify "delete[]" 'method) ((self #.(bullet-wrap::swig-lispify "bt-cylinder-shape-x" 'classname)) ptr)
  (#.(bullet-wrap::swig-lispify "btCylinderShapeX_deleteCPlusArray" 'function) (ff-pointer self) ptr))

(cl:shadow "new[]")
(cl:defmethod #.(bullet-wrap::swig-lispify "new[]" 'method) ((self #.(bullet-wrap::swig-lispify "bt-cylinder-shape-x" 'classname)) arg1 ptr)
  (#.(bullet-wrap::swig-lispify "btCylinderShapeX_makeCPlusArray" 'function) (ff-pointer self) arg1 ptr))

(cl:shadow "delete[]")
(cl:defmethod #.(bullet-wrap::swig-lispify "delete[]" 'method) ((self #.(bullet-wrap::swig-lispify "bt-cylinder-shape-x" 'classname)) arg1 arg2)
  (#.(bullet-wrap::swig-lispify "btCylinderShapeX_deleteCPlusArray" 'function) (ff-pointer self) arg1 arg2))

(cl:defmethod initialize-instance :after ((obj #.(bullet-wrap::swig-lispify "bt-cylinder-shape-x" 'class)) &key (halfExtents #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)))
  (setf (slot-value obj 'ff-pointer) (#.(bullet-wrap::swig-lispify "new_btCylinderShapeX" 'function) halfExtents)))

(cl:defmethod #.(bullet-wrap::swig-lispify "local-get-supporting-vertex-without-margin" 'method) ((self #.(bullet-wrap::swig-lispify "bt-cylinder-shape-x" 'classname)) (vec #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)))
  (#.(bullet-wrap::swig-lispify "btCylinderShapeX_localGetSupportingVertexWithoutMargin" 'function) (ff-pointer self) vec))

(cl:defmethod #.(bullet-wrap::swig-lispify "batched-unit-vector-get-supporting-vertex-without-margin" 'method) ((self #.(bullet-wrap::swig-lispify "bt-cylinder-shape-x" 'classname)) (vectors #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (supportVerticesOut #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (numVectors cl:integer))
  (#.(bullet-wrap::swig-lispify "btCylinderShapeX_batchedUnitVectorGetSupportingVertexWithoutMargin" 'function) (ff-pointer self) vectors supportVerticesOut numVectors))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-name" 'method) ((self #.(bullet-wrap::swig-lispify "bt-cylinder-shape-x" 'classname)))
  (#.(bullet-wrap::swig-lispify "btCylinderShapeX_getName" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-radius" 'method) ((self #.(bullet-wrap::swig-lispify "bt-cylinder-shape-x" 'classname)))
  (#.(bullet-wrap::swig-lispify "btCylinderShapeX_getRadius" 'function) (ff-pointer self)))


(cl:defclass #.(bullet-wrap::swig-lispify "bt-cylinder-shape-z" 'classname)(#.(bullet-wrap::swig-lispify "btCylinderShape" 'classname))
  ((ff-pointer :reader ff-pointer)))

(cl:shadow "new")
(cl:defmethod #.(bullet-wrap::swig-lispify "new" 'method) ((self #.(bullet-wrap::swig-lispify "bt-cylinder-shape-z" 'classname)) sizeInBytes)
  (#.(bullet-wrap::swig-lispify "btCylinderShapeZ_makeCPlusPlusInstance" 'function) (ff-pointer self) sizeInBytes))

(cl:shadow "delete")
(cl:defmethod #.(bullet-wrap::swig-lispify "delete" 'method) ((self #.(bullet-wrap::swig-lispify "bt-cylinder-shape-z" 'classname)) ptr)
  (#.(bullet-wrap::swig-lispify "btCylinderShapeZ_deleteCPlusPlusInstance" 'function) (ff-pointer self) ptr))

(cl:shadow "new")
(cl:defmethod #.(bullet-wrap::swig-lispify "new" 'method) ((self #.(bullet-wrap::swig-lispify "bt-cylinder-shape-z" 'classname)) arg1 ptr)
  (#.(bullet-wrap::swig-lispify "btCylinderShapeZ_makeCPlusPlusInstance" 'function) (ff-pointer self) arg1 ptr))

(cl:shadow "delete")
(cl:defmethod #.(bullet-wrap::swig-lispify "delete" 'method) ((self #.(bullet-wrap::swig-lispify "bt-cylinder-shape-z" 'classname)) arg1 arg2)
  (#.(bullet-wrap::swig-lispify "btCylinderShapeZ_deleteCPlusPlusInstance" 'function) (ff-pointer self) arg1 arg2))

(cl:shadow "new[]")
(cl:defmethod #.(bullet-wrap::swig-lispify "new[]" 'method) ((self #.(bullet-wrap::swig-lispify "bt-cylinder-shape-z" 'classname)) sizeInBytes)
  (#.(bullet-wrap::swig-lispify "btCylinderShapeZ_makeCPlusArray" 'function) (ff-pointer self) sizeInBytes))

(cl:shadow "delete[]")
(cl:defmethod #.(bullet-wrap::swig-lispify "delete[]" 'method) ((self #.(bullet-wrap::swig-lispify "bt-cylinder-shape-z" 'classname)) ptr)
  (#.(bullet-wrap::swig-lispify "btCylinderShapeZ_deleteCPlusArray" 'function) (ff-pointer self) ptr))

(cl:shadow "new[]")
(cl:defmethod #.(bullet-wrap::swig-lispify "new[]" 'method) ((self #.(bullet-wrap::swig-lispify "bt-cylinder-shape-z" 'classname)) arg1 ptr)
  (#.(bullet-wrap::swig-lispify "btCylinderShapeZ_makeCPlusArray" 'function) (ff-pointer self) arg1 ptr))

(cl:shadow "delete[]")
(cl:defmethod #.(bullet-wrap::swig-lispify "delete[]" 'method) ((self #.(bullet-wrap::swig-lispify "bt-cylinder-shape-z" 'classname)) arg1 arg2)
  (#.(bullet-wrap::swig-lispify "btCylinderShapeZ_deleteCPlusArray" 'function) (ff-pointer self) arg1 arg2))

(cl:defmethod initialize-instance :after ((obj #.(bullet-wrap::swig-lispify "bt-cylinder-shape-z" 'class)) &key (halfExtents #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)))
  (setf (slot-value obj 'ff-pointer) (#.(bullet-wrap::swig-lispify "new_btCylinderShapeZ" 'function) halfExtents)))

(cl:defmethod #.(bullet-wrap::swig-lispify "local-get-supporting-vertex-without-margin" 'method) ((self #.(bullet-wrap::swig-lispify "bt-cylinder-shape-z" 'classname)) (vec #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)))
  (#.(bullet-wrap::swig-lispify "btCylinderShapeZ_localGetSupportingVertexWithoutMargin" 'function) (ff-pointer self) vec))

(cl:defmethod #.(bullet-wrap::swig-lispify "batched-unit-vector-get-supporting-vertex-without-margin" 'method) ((self #.(bullet-wrap::swig-lispify "bt-cylinder-shape-z" 'classname)) (vectors #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (supportVerticesOut #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (numVectors cl:integer))
  (#.(bullet-wrap::swig-lispify "btCylinderShapeZ_batchedUnitVectorGetSupportingVertexWithoutMargin" 'function) (ff-pointer self) vectors supportVerticesOut numVectors))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-name" 'method) ((self #.(bullet-wrap::swig-lispify "bt-cylinder-shape-z" 'classname)))
  (#.(bullet-wrap::swig-lispify "btCylinderShapeZ_getName" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-radius" 'method) ((self #.(bullet-wrap::swig-lispify "bt-cylinder-shape-z" 'classname)))
  (#.(bullet-wrap::swig-lispify "btCylinderShapeZ_getRadius" 'function) (ff-pointer self)))


(cl:defclass #.(bullet-wrap::swig-lispify "bt-cone-shape" 'classname)()
  ((ff-pointer :reader ff-pointer)))

(cl:shadow "new")
(cl:defmethod #.(bullet-wrap::swig-lispify "new" 'method) ((self #.(bullet-wrap::swig-lispify "bt-cone-shape" 'classname)) sizeInBytes)
  (#.(bullet-wrap::swig-lispify "btConeShape_makeCPlusPlusInstance" 'function) (ff-pointer self) sizeInBytes))

(cl:shadow "delete")
(cl:defmethod #.(bullet-wrap::swig-lispify "delete" 'method) ((self #.(bullet-wrap::swig-lispify "bt-cone-shape" 'classname)) ptr)
  (#.(bullet-wrap::swig-lispify "btConeShape_deleteCPlusPlusInstance" 'function) (ff-pointer self) ptr))

(cl:shadow "new")
(cl:defmethod #.(bullet-wrap::swig-lispify "new" 'method) ((self #.(bullet-wrap::swig-lispify "bt-cone-shape" 'classname)) arg1 ptr)
  (#.(bullet-wrap::swig-lispify "btConeShape_makeCPlusPlusInstance" 'function) (ff-pointer self) arg1 ptr))

(cl:shadow "delete")
(cl:defmethod #.(bullet-wrap::swig-lispify "delete" 'method) ((self #.(bullet-wrap::swig-lispify "bt-cone-shape" 'classname)) arg1 arg2)
  (#.(bullet-wrap::swig-lispify "btConeShape_deleteCPlusPlusInstance" 'function) (ff-pointer self) arg1 arg2))

(cl:shadow "new[]")
(cl:defmethod #.(bullet-wrap::swig-lispify "new[]" 'method) ((self #.(bullet-wrap::swig-lispify "bt-cone-shape" 'classname)) sizeInBytes)
  (#.(bullet-wrap::swig-lispify "btConeShape_makeCPlusArray" 'function) (ff-pointer self) sizeInBytes))

(cl:shadow "delete[]")
(cl:defmethod #.(bullet-wrap::swig-lispify "delete[]" 'method) ((self #.(bullet-wrap::swig-lispify "bt-cone-shape" 'classname)) ptr)
  (#.(bullet-wrap::swig-lispify "btConeShape_deleteCPlusArray" 'function) (ff-pointer self) ptr))

(cl:shadow "new[]")
(cl:defmethod #.(bullet-wrap::swig-lispify "new[]" 'method) ((self #.(bullet-wrap::swig-lispify "bt-cone-shape" 'classname)) arg1 ptr)
  (#.(bullet-wrap::swig-lispify "btConeShape_makeCPlusArray" 'function) (ff-pointer self) arg1 ptr))

(cl:shadow "delete[]")
(cl:defmethod #.(bullet-wrap::swig-lispify "delete[]" 'method) ((self #.(bullet-wrap::swig-lispify "bt-cone-shape" 'classname)) arg1 arg2)
  (#.(bullet-wrap::swig-lispify "btConeShape_deleteCPlusArray" 'function) (ff-pointer self) arg1 arg2))

(cl:defmethod initialize-instance :after ((obj #.(bullet-wrap::swig-lispify "bt-cone-shape" 'class)) &key (radius cl:number) (height cl:number))
  (setf (slot-value obj 'ff-pointer) (#.(bullet-wrap::swig-lispify "new_btConeShape" 'function) radius height)))

(cl:defmethod #.(bullet-wrap::swig-lispify "local-get-supporting-vertex" 'method) ((self #.(bullet-wrap::swig-lispify "bt-cone-shape" 'classname)) (vec #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)))
  (#.(bullet-wrap::swig-lispify "btConeShape_localGetSupportingVertex" 'function) (ff-pointer self) vec))

(cl:defmethod #.(bullet-wrap::swig-lispify "local-get-supporting-vertex-without-margin" 'method) ((self #.(bullet-wrap::swig-lispify "bt-cone-shape" 'classname)) (vec #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)))
  (#.(bullet-wrap::swig-lispify "btConeShape_localGetSupportingVertexWithoutMargin" 'function) (ff-pointer self) vec))

(cl:defmethod #.(bullet-wrap::swig-lispify "batched-unit-vector-get-supporting-vertex-without-margin" 'method) ((self #.(bullet-wrap::swig-lispify "bt-cone-shape" 'classname)) (vectors #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (supportVerticesOut #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (numVectors cl:integer))
  (#.(bullet-wrap::swig-lispify "btConeShape_batchedUnitVectorGetSupportingVertexWithoutMargin" 'function) (ff-pointer self) vectors supportVerticesOut numVectors))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-radius" 'method) ((self #.(bullet-wrap::swig-lispify "bt-cone-shape" 'classname)))
  (#.(bullet-wrap::swig-lispify "btConeShape_getRadius" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-height" 'method) ((self #.(bullet-wrap::swig-lispify "bt-cone-shape" 'classname)))
  (#.(bullet-wrap::swig-lispify "btConeShape_getHeight" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "calculate-local-inertia" 'method) ((self #.(bullet-wrap::swig-lispify "bt-cone-shape" 'classname)) (mass cl:number) (inertia #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)))
  (#.(bullet-wrap::swig-lispify "btConeShape_calculateLocalInertia" 'function) (ff-pointer self) mass inertia))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-name" 'method) ((self #.(bullet-wrap::swig-lispify "bt-cone-shape" 'classname)))
  (#.(bullet-wrap::swig-lispify "btConeShape_getName" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "set-cone-up-index" 'method) ((self #.(bullet-wrap::swig-lispify "bt-cone-shape" 'classname)) (upIndex cl:integer))
  (#.(bullet-wrap::swig-lispify "btConeShape_setConeUpIndex" 'function) (ff-pointer self) upIndex))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-cone-up-index" 'method) ((self #.(bullet-wrap::swig-lispify "bt-cone-shape" 'classname)))
  (#.(bullet-wrap::swig-lispify "btConeShape_getConeUpIndex" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-anisotropic-rolling-friction-direction" 'method) ((self #.(bullet-wrap::swig-lispify "bt-cone-shape" 'classname)))
  (#.(bullet-wrap::swig-lispify "btConeShape_getAnisotropicRollingFrictionDirection" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "set-local-scaling" 'method) ((self #.(bullet-wrap::swig-lispify "bt-cone-shape" 'classname)) (scaling #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)))
  (#.(bullet-wrap::swig-lispify "btConeShape_setLocalScaling" 'function) (ff-pointer self) scaling))

(cl:defmethod #.(bullet-wrap::swig-lispify "calculate-serialize-buffer-size" 'method) ((self #.(bullet-wrap::swig-lispify "bt-cone-shape" 'classname)))
  (#.(bullet-wrap::swig-lispify "btConeShape_calculateSerializeBufferSize" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "serialize" 'method) ((self #.(bullet-wrap::swig-lispify "bt-cone-shape" 'classname)) dataBuffer serializer)
  (#.(bullet-wrap::swig-lispify "btConeShape_serialize" 'function) (ff-pointer self) dataBuffer serializer))


(cl:defclass #.(bullet-wrap::swig-lispify "bt-cone-shape-x" 'classname)(#.(bullet-wrap::swig-lispify "btConeShape" 'classname))
  ((ff-pointer :reader ff-pointer)))

(cl:defmethod initialize-instance :after ((obj #.(bullet-wrap::swig-lispify "bt-cone-shape-x" 'class)) &key (radius cl:number) (height cl:number))
  (setf (slot-value obj 'ff-pointer) (#.(bullet-wrap::swig-lispify "new_btConeShapeX" 'function) radius height)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-anisotropic-rolling-friction-direction" 'method) ((self #.(bullet-wrap::swig-lispify "bt-cone-shape-x" 'classname)))
  (#.(bullet-wrap::swig-lispify "btConeShapeX_getAnisotropicRollingFrictionDirection" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-name" 'method) ((self #.(bullet-wrap::swig-lispify "bt-cone-shape-x" 'classname)))
  (#.(bullet-wrap::swig-lispify "btConeShapeX_getName" 'function) (ff-pointer self)))


(cl:defclass #.(bullet-wrap::swig-lispify "bt-cone-shape-z" 'classname)(#.(bullet-wrap::swig-lispify "btConeShape" 'classname))
  ((ff-pointer :reader ff-pointer)))

(cl:defmethod initialize-instance :after ((obj #.(bullet-wrap::swig-lispify "bt-cone-shape-z" 'class)) &key (radius cl:number) (height cl:number))
  (setf (slot-value obj 'ff-pointer) (#.(bullet-wrap::swig-lispify "new_btConeShapeZ" 'function) radius height)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-anisotropic-rolling-friction-direction" 'method) ((self #.(bullet-wrap::swig-lispify "bt-cone-shape-z" 'classname)))
  (#.(bullet-wrap::swig-lispify "btConeShapeZ_getAnisotropicRollingFrictionDirection" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-name" 'method) ((self #.(bullet-wrap::swig-lispify "bt-cone-shape-z" 'classname)))
  (#.(bullet-wrap::swig-lispify "btConeShapeZ_getName" 'function) (ff-pointer self)))


(cl:defclass #.(bullet-wrap::swig-lispify "bt-static-plane-shape" 'classname)()
  ((ff-pointer :reader ff-pointer)))

(cl:shadow "new")
(cl:defmethod #.(bullet-wrap::swig-lispify "new" 'method) ((self #.(bullet-wrap::swig-lispify "bt-static-plane-shape" 'classname)) sizeInBytes)
  (#.(bullet-wrap::swig-lispify "btStaticPlaneShape_makeCPlusPlusInstance" 'function) (ff-pointer self) sizeInBytes))

(cl:shadow "delete")
(cl:defmethod #.(bullet-wrap::swig-lispify "delete" 'method) ((self #.(bullet-wrap::swig-lispify "bt-static-plane-shape" 'classname)) ptr)
  (#.(bullet-wrap::swig-lispify "btStaticPlaneShape_deleteCPlusPlusInstance" 'function) (ff-pointer self) ptr))

(cl:shadow "new")
(cl:defmethod #.(bullet-wrap::swig-lispify "new" 'method) ((self #.(bullet-wrap::swig-lispify "bt-static-plane-shape" 'classname)) arg1 ptr)
  (#.(bullet-wrap::swig-lispify "btStaticPlaneShape_makeCPlusPlusInstance" 'function) (ff-pointer self) arg1 ptr))

(cl:shadow "delete")
(cl:defmethod #.(bullet-wrap::swig-lispify "delete" 'method) ((self #.(bullet-wrap::swig-lispify "bt-static-plane-shape" 'classname)) arg1 arg2)
  (#.(bullet-wrap::swig-lispify "btStaticPlaneShape_deleteCPlusPlusInstance" 'function) (ff-pointer self) arg1 arg2))

(cl:shadow "new[]")
(cl:defmethod #.(bullet-wrap::swig-lispify "new[]" 'method) ((self #.(bullet-wrap::swig-lispify "bt-static-plane-shape" 'classname)) sizeInBytes)
  (#.(bullet-wrap::swig-lispify "btStaticPlaneShape_makeCPlusArray" 'function) (ff-pointer self) sizeInBytes))

(cl:shadow "delete[]")
(cl:defmethod #.(bullet-wrap::swig-lispify "delete[]" 'method) ((self #.(bullet-wrap::swig-lispify "bt-static-plane-shape" 'classname)) ptr)
  (#.(bullet-wrap::swig-lispify "btStaticPlaneShape_deleteCPlusArray" 'function) (ff-pointer self) ptr))

(cl:shadow "new[]")
(cl:defmethod #.(bullet-wrap::swig-lispify "new[]" 'method) ((self #.(bullet-wrap::swig-lispify "bt-static-plane-shape" 'classname)) arg1 ptr)
  (#.(bullet-wrap::swig-lispify "btStaticPlaneShape_makeCPlusArray" 'function) (ff-pointer self) arg1 ptr))

(cl:shadow "delete[]")
(cl:defmethod #.(bullet-wrap::swig-lispify "delete[]" 'method) ((self #.(bullet-wrap::swig-lispify "bt-static-plane-shape" 'classname)) arg1 arg2)
  (#.(bullet-wrap::swig-lispify "btStaticPlaneShape_deleteCPlusArray" 'function) (ff-pointer self) arg1 arg2))

(cl:defmethod initialize-instance :after ((obj #.(bullet-wrap::swig-lispify "bt-static-plane-shape" 'class)) &key (planeNormal #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (planeConstant cl:number))
  (setf (slot-value obj 'ff-pointer) (#.(bullet-wrap::swig-lispify "new_btStaticPlaneShape" 'function) planeNormal planeConstant)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-aabb" 'method) ((self #.(bullet-wrap::swig-lispify "bt-static-plane-shape" 'classname)) (t-arg1 #.(bullet-wrap::swig-lispify "bt-transform" 'classname)) (aabbMin #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (aabbMax #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)))
  (#.(bullet-wrap::swig-lispify "btStaticPlaneShape_getAabb" 'function) (ff-pointer self) t-arg1 aabbMin aabbMax))

(cl:defmethod #.(bullet-wrap::swig-lispify "process-all-triangles" 'method) ((self #.(bullet-wrap::swig-lispify "bt-static-plane-shape" 'classname)) callback (aabbMin #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (aabbMax #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)))
  (#.(bullet-wrap::swig-lispify "btStaticPlaneShape_processAllTriangles" 'function) (ff-pointer self) callback aabbMin aabbMax))

(cl:defmethod #.(bullet-wrap::swig-lispify "calculate-local-inertia" 'method) ((self #.(bullet-wrap::swig-lispify "bt-static-plane-shape" 'classname)) (mass cl:number) (inertia #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)))
  (#.(bullet-wrap::swig-lispify "btStaticPlaneShape_calculateLocalInertia" 'function) (ff-pointer self) mass inertia))

(cl:defmethod #.(bullet-wrap::swig-lispify "set-local-scaling" 'method) ((self #.(bullet-wrap::swig-lispify "bt-static-plane-shape" 'classname)) (scaling #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)))
  (#.(bullet-wrap::swig-lispify "btStaticPlaneShape_setLocalScaling" 'function) (ff-pointer self) scaling))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-local-scaling" 'method) ((self #.(bullet-wrap::swig-lispify "bt-static-plane-shape" 'classname)))
  (#.(bullet-wrap::swig-lispify "btStaticPlaneShape_getLocalScaling" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-plane-normal" 'method) ((self #.(bullet-wrap::swig-lispify "bt-static-plane-shape" 'classname)))
  (#.(bullet-wrap::swig-lispify "btStaticPlaneShape_getPlaneNormal" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-plane-constant" 'method) ((self #.(bullet-wrap::swig-lispify "bt-static-plane-shape" 'classname)))
  (#.(bullet-wrap::swig-lispify "btStaticPlaneShape_getPlaneConstant" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-name" 'method) ((self #.(bullet-wrap::swig-lispify "bt-static-plane-shape" 'classname)))
  (#.(bullet-wrap::swig-lispify "btStaticPlaneShape_getName" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "calculate-serialize-buffer-size" 'method) ((self #.(bullet-wrap::swig-lispify "bt-static-plane-shape" 'classname)))
  (#.(bullet-wrap::swig-lispify "btStaticPlaneShape_calculateSerializeBufferSize" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "serialize" 'method) ((self #.(bullet-wrap::swig-lispify "bt-static-plane-shape" 'classname)) dataBuffer serializer)
  (#.(bullet-wrap::swig-lispify "btStaticPlaneShape_serialize" 'function) (ff-pointer self) dataBuffer serializer))


(cl:defclass #.(bullet-wrap::swig-lispify "bt-convex-hull-shape" 'classname)()
  ((ff-pointer :reader ff-pointer)))

(cl:shadow "new")
(cl:defmethod #.(bullet-wrap::swig-lispify "new" 'method) ((self #.(bullet-wrap::swig-lispify "bt-convex-hull-shape" 'classname)) sizeInBytes)
  (#.(bullet-wrap::swig-lispify "btConvexHullShape_makeCPlusPlusInstance" 'function) (ff-pointer self) sizeInBytes))

(cl:shadow "delete")
(cl:defmethod #.(bullet-wrap::swig-lispify "delete" 'method) ((self #.(bullet-wrap::swig-lispify "bt-convex-hull-shape" 'classname)) ptr)
  (#.(bullet-wrap::swig-lispify "btConvexHullShape_deleteCPlusPlusInstance" 'function) (ff-pointer self) ptr))

(cl:shadow "new")
(cl:defmethod #.(bullet-wrap::swig-lispify "new" 'method) ((self #.(bullet-wrap::swig-lispify "bt-convex-hull-shape" 'classname)) arg1 ptr)
  (#.(bullet-wrap::swig-lispify "btConvexHullShape_makeCPlusPlusInstance" 'function) (ff-pointer self) arg1 ptr))

(cl:shadow "delete")
(cl:defmethod #.(bullet-wrap::swig-lispify "delete" 'method) ((self #.(bullet-wrap::swig-lispify "bt-convex-hull-shape" 'classname)) arg1 arg2)
  (#.(bullet-wrap::swig-lispify "btConvexHullShape_deleteCPlusPlusInstance" 'function) (ff-pointer self) arg1 arg2))

(cl:shadow "new[]")
(cl:defmethod #.(bullet-wrap::swig-lispify "new[]" 'method) ((self #.(bullet-wrap::swig-lispify "bt-convex-hull-shape" 'classname)) sizeInBytes)
  (#.(bullet-wrap::swig-lispify "btConvexHullShape_makeCPlusArray" 'function) (ff-pointer self) sizeInBytes))

(cl:shadow "delete[]")
(cl:defmethod #.(bullet-wrap::swig-lispify "delete[]" 'method) ((self #.(bullet-wrap::swig-lispify "bt-convex-hull-shape" 'classname)) ptr)
  (#.(bullet-wrap::swig-lispify "btConvexHullShape_deleteCPlusArray" 'function) (ff-pointer self) ptr))

(cl:shadow "new[]")
(cl:defmethod #.(bullet-wrap::swig-lispify "new[]" 'method) ((self #.(bullet-wrap::swig-lispify "bt-convex-hull-shape" 'classname)) arg1 ptr)
  (#.(bullet-wrap::swig-lispify "btConvexHullShape_makeCPlusArray" 'function) (ff-pointer self) arg1 ptr))

(cl:shadow "delete[]")
(cl:defmethod #.(bullet-wrap::swig-lispify "delete[]" 'method) ((self #.(bullet-wrap::swig-lispify "bt-convex-hull-shape" 'classname)) arg1 arg2)
  (#.(bullet-wrap::swig-lispify "btConvexHullShape_deleteCPlusArray" 'function) (ff-pointer self) arg1 arg2))

(cl:defmethod initialize-instance :after ((obj #.(bullet-wrap::swig-lispify "bt-convex-hull-shape" 'class)) &key points (numPoints cl:integer) (stride cl:integer))
  (setf (slot-value obj 'ff-pointer) (#.(bullet-wrap::swig-lispify "new_btConvexHullShape" 'function) points numPoints stride)))

(cl:defmethod initialize-instance :after ((obj #.(bullet-wrap::swig-lispify "bt-convex-hull-shape" 'class)) &key points (numPoints cl:integer))
  (setf (slot-value obj 'ff-pointer) (#.(bullet-wrap::swig-lispify "new_btConvexHullShape" 'function) points numPoints)))

(cl:defmethod initialize-instance :after ((obj #.(bullet-wrap::swig-lispify "bt-convex-hull-shape" 'class)) &key points)
  (setf (slot-value obj 'ff-pointer) (#.(bullet-wrap::swig-lispify "new_btConvexHullShape" 'function) points)))

(cl:defmethod initialize-instance :after ((obj #.(bullet-wrap::swig-lispify "bt-convex-hull-shape" 'class)) &key)
  (setf (slot-value obj 'ff-pointer) (#.(bullet-wrap::swig-lispify "new_btConvexHullShape" 'function))))

(cl:defmethod #.(bullet-wrap::swig-lispify "add-point" 'method) ((self #.(bullet-wrap::swig-lispify "bt-convex-hull-shape" 'classname)) (point #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (recalculateLocalAabb t))
  (#.(bullet-wrap::swig-lispify "btConvexHullShape_addPoint" 'function) (ff-pointer self) point recalculateLocalAabb))

(cl:defmethod #.(bullet-wrap::swig-lispify "add-point" 'method) ((self #.(bullet-wrap::swig-lispify "bt-convex-hull-shape" 'classname)) (point #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)))
  (#.(bullet-wrap::swig-lispify "btConvexHullShape_addPoint" 'function) (ff-pointer self) point))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-unscaled-points" 'method) ((self #.(bullet-wrap::swig-lispify "bt-convex-hull-shape" 'classname)))
  (#.(bullet-wrap::swig-lispify "btConvexHullShape_getUnscaledPoints" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-unscaled-points" 'method) ((self #.(bullet-wrap::swig-lispify "bt-convex-hull-shape" 'classname)))
  (#.(bullet-wrap::swig-lispify "btConvexHullShape_getUnscaledPoints" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-points" 'method) ((self #.(bullet-wrap::swig-lispify "bt-convex-hull-shape" 'classname)))
  (#.(bullet-wrap::swig-lispify "btConvexHullShape_getPoints" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-scaled-point" 'method) ((self #.(bullet-wrap::swig-lispify "bt-convex-hull-shape" 'classname)) (i cl:integer))
  (#.(bullet-wrap::swig-lispify "btConvexHullShape_getScaledPoint" 'function) (ff-pointer self) i))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-num-points" 'method) ((self #.(bullet-wrap::swig-lispify "bt-convex-hull-shape" 'classname)))
  (#.(bullet-wrap::swig-lispify "btConvexHullShape_getNumPoints" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "local-get-supporting-vertex" 'method) ((self #.(bullet-wrap::swig-lispify "bt-convex-hull-shape" 'classname)) (vec #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)))
  (#.(bullet-wrap::swig-lispify "btConvexHullShape_localGetSupportingVertex" 'function) (ff-pointer self) vec))

(cl:defmethod #.(bullet-wrap::swig-lispify "local-get-supporting-vertex-without-margin" 'method) ((self #.(bullet-wrap::swig-lispify "bt-convex-hull-shape" 'classname)) (vec #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)))
  (#.(bullet-wrap::swig-lispify "btConvexHullShape_localGetSupportingVertexWithoutMargin" 'function) (ff-pointer self) vec))

(cl:defmethod #.(bullet-wrap::swig-lispify "batched-unit-vector-get-supporting-vertex-without-margin" 'method) ((self #.(bullet-wrap::swig-lispify "bt-convex-hull-shape" 'classname)) (vectors #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (supportVerticesOut #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (numVectors cl:integer))
  (#.(bullet-wrap::swig-lispify "btConvexHullShape_batchedUnitVectorGetSupportingVertexWithoutMargin" 'function) (ff-pointer self) vectors supportVerticesOut numVectors))

(cl:defmethod #.(bullet-wrap::swig-lispify "project" 'method) ((self #.(bullet-wrap::swig-lispify "bt-convex-hull-shape" 'classname)) (trans #.(bullet-wrap::swig-lispify "bt-transform" 'classname)) (dir #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) minProj maxProj (witnesPtMin #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (witnesPtMax #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)))
  (#.(bullet-wrap::swig-lispify "btConvexHullShape_project" 'function) (ff-pointer self) trans dir minProj maxProj witnesPtMin witnesPtMax))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-name" 'method) ((self #.(bullet-wrap::swig-lispify "bt-convex-hull-shape" 'classname)))
  (#.(bullet-wrap::swig-lispify "btConvexHullShape_getName" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-num-vertices" 'method) ((self #.(bullet-wrap::swig-lispify "bt-convex-hull-shape" 'classname)))
  (#.(bullet-wrap::swig-lispify "btConvexHullShape_getNumVertices" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-num-edges" 'method) ((self #.(bullet-wrap::swig-lispify "bt-convex-hull-shape" 'classname)))
  (#.(bullet-wrap::swig-lispify "btConvexHullShape_getNumEdges" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-edge" 'method) ((self #.(bullet-wrap::swig-lispify "bt-convex-hull-shape" 'classname)) (i cl:integer) (pa #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (pb #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)))
  (#.(bullet-wrap::swig-lispify "btConvexHullShape_getEdge" 'function) (ff-pointer self) i pa pb))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-vertex" 'method) ((self #.(bullet-wrap::swig-lispify "bt-convex-hull-shape" 'classname)) (i cl:integer) (vtx #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)))
  (#.(bullet-wrap::swig-lispify "btConvexHullShape_getVertex" 'function) (ff-pointer self) i vtx))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-num-planes" 'method) ((self #.(bullet-wrap::swig-lispify "bt-convex-hull-shape" 'classname)))
  (#.(bullet-wrap::swig-lispify "btConvexHullShape_getNumPlanes" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-plane" 'method) ((self #.(bullet-wrap::swig-lispify "bt-convex-hull-shape" 'classname)) (planeNormal #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (planeSupport #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (i cl:integer))
  (#.(bullet-wrap::swig-lispify "btConvexHullShape_getPlane" 'function) (ff-pointer self) planeNormal planeSupport i))

(cl:defmethod #.(bullet-wrap::swig-lispify "is-inside" 'method) ((self #.(bullet-wrap::swig-lispify "bt-convex-hull-shape" 'classname)) (pt #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (tolerance cl:number))
  (#.(bullet-wrap::swig-lispify "btConvexHullShape_isInside" 'function) (ff-pointer self) pt tolerance))

(cl:defmethod #.(bullet-wrap::swig-lispify "set-local-scaling" 'method) ((self #.(bullet-wrap::swig-lispify "bt-convex-hull-shape" 'classname)) (scaling #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)))
  (#.(bullet-wrap::swig-lispify "btConvexHullShape_setLocalScaling" 'function) (ff-pointer self) scaling))

(cl:defmethod #.(bullet-wrap::swig-lispify "calculate-serialize-buffer-size" 'method) ((self #.(bullet-wrap::swig-lispify "bt-convex-hull-shape" 'classname)))
  (#.(bullet-wrap::swig-lispify "btConvexHullShape_calculateSerializeBufferSize" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "serialize" 'method) ((self #.(bullet-wrap::swig-lispify "bt-convex-hull-shape" 'classname)) dataBuffer serializer)
  (#.(bullet-wrap::swig-lispify "btConvexHullShape_serialize" 'function) (ff-pointer self) dataBuffer serializer))


(cl:defclass #.(bullet-wrap::swig-lispify "bt-triangle-mesh" 'classname)()
  ((ff-pointer :reader ff-pointer)))

(cl:defmethod (cl:setf #.(bullet-wrap::swig-lispify "m_weldingThreshold" 'method)) (arg0 (obj #.(bullet-wrap::swig-lispify "bt-triangle-mesh" 'class)))
  (#.(bullet-wrap::swig-lispify "btTriangleMesh_m_weldingThreshold_set" 'function) (ff-pointer obj) arg0))

(cl:defmethod #.(bullet-wrap::swig-lispify "m_weldingThreshold" 'method) ((obj #.(bullet-wrap::swig-lispify "bt-triangle-mesh" 'class)))
  (#.(bullet-wrap::swig-lispify "btTriangleMesh_m_weldingThreshold_get" 'function) (ff-pointer obj)))

(cl:defmethod initialize-instance :after ((obj #.(bullet-wrap::swig-lispify "bt-triangle-mesh" 'class)) &key (use32bitIndices t) (use4componentVertices t))
  (setf (slot-value obj 'ff-pointer) (#.(bullet-wrap::swig-lispify "new_btTriangleMesh" 'function) use32bitIndices use4componentVertices)))

(cl:defmethod initialize-instance :after ((obj #.(bullet-wrap::swig-lispify "bt-triangle-mesh" 'class)) &key (use32bitIndices t))
  (setf (slot-value obj 'ff-pointer) (#.(bullet-wrap::swig-lispify "new_btTriangleMesh" 'function) use32bitIndices)))

(cl:defmethod initialize-instance :after ((obj #.(bullet-wrap::swig-lispify "bt-triangle-mesh" 'class)) &key)
  (setf (slot-value obj 'ff-pointer) (#.(bullet-wrap::swig-lispify "new_btTriangleMesh" 'function))))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-use32bit-indices" 'method) ((self #.(bullet-wrap::swig-lispify "bt-triangle-mesh" 'classname)))
  (#.(bullet-wrap::swig-lispify "btTriangleMesh_getUse32bitIndices" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-use4component-vertices" 'method) ((self #.(bullet-wrap::swig-lispify "bt-triangle-mesh" 'classname)))
  (#.(bullet-wrap::swig-lispify "btTriangleMesh_getUse4componentVertices" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "add-triangle" 'method) ((self #.(bullet-wrap::swig-lispify "bt-triangle-mesh" 'classname)) (vertex0 #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (vertex1 #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (vertex2 #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (removeDuplicateVertices t))
  (#.(bullet-wrap::swig-lispify "btTriangleMesh_addTriangle" 'function) (ff-pointer self) vertex0 vertex1 vertex2 removeDuplicateVertices))

(cl:defmethod #.(bullet-wrap::swig-lispify "add-triangle" 'method) ((self #.(bullet-wrap::swig-lispify "bt-triangle-mesh" 'classname)) (vertex0 #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (vertex1 #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (vertex2 #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)))
  (#.(bullet-wrap::swig-lispify "btTriangleMesh_addTriangle" 'function) (ff-pointer self) vertex0 vertex1 vertex2))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-num-triangles" 'method) ((self #.(bullet-wrap::swig-lispify "bt-triangle-mesh" 'classname)))
  (#.(bullet-wrap::swig-lispify "btTriangleMesh_getNumTriangles" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "preallocate-vertices" 'method) ((self #.(bullet-wrap::swig-lispify "bt-triangle-mesh" 'classname)) (numverts cl:integer))
  (#.(bullet-wrap::swig-lispify "btTriangleMesh_preallocateVertices" 'function) (ff-pointer self) numverts))

(cl:defmethod #.(bullet-wrap::swig-lispify "preallocate-indices" 'method) ((self #.(bullet-wrap::swig-lispify "bt-triangle-mesh" 'classname)) (numindices cl:integer))
  (#.(bullet-wrap::swig-lispify "btTriangleMesh_preallocateIndices" 'function) (ff-pointer self) numindices))

(cl:defmethod #.(bullet-wrap::swig-lispify "find-or-add-vertex" 'method) ((self #.(bullet-wrap::swig-lispify "bt-triangle-mesh" 'classname)) (vertex #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (removeDuplicateVertices t))
  (#.(bullet-wrap::swig-lispify "btTriangleMesh_findOrAddVertex" 'function) (ff-pointer self) vertex removeDuplicateVertices))

(cl:defmethod #.(bullet-wrap::swig-lispify "add-index" 'method) ((self #.(bullet-wrap::swig-lispify "bt-triangle-mesh" 'classname)) (index cl:integer))
  (#.(bullet-wrap::swig-lispify "btTriangleMesh_addIndex" 'function) (ff-pointer self) index))


(cl:defclass #.(bullet-wrap::swig-lispify "bt-convex-triangle-mesh-shape" 'classname)()
  ((ff-pointer :reader ff-pointer)))

(cl:shadow "new")
(cl:defmethod #.(bullet-wrap::swig-lispify "new" 'method) ((self #.(bullet-wrap::swig-lispify "bt-convex-triangle-mesh-shape" 'classname)) sizeInBytes)
  (#.(bullet-wrap::swig-lispify "btConvexTriangleMeshShape_makeCPlusPlusInstance" 'function) (ff-pointer self) sizeInBytes))

(cl:shadow "delete")
(cl:defmethod #.(bullet-wrap::swig-lispify "delete" 'method) ((self #.(bullet-wrap::swig-lispify "bt-convex-triangle-mesh-shape" 'classname)) ptr)
  (#.(bullet-wrap::swig-lispify "btConvexTriangleMeshShape_deleteCPlusPlusInstance" 'function) (ff-pointer self) ptr))

(cl:shadow "new")
(cl:defmethod #.(bullet-wrap::swig-lispify "new" 'method) ((self #.(bullet-wrap::swig-lispify "bt-convex-triangle-mesh-shape" 'classname)) arg1 ptr)
  (#.(bullet-wrap::swig-lispify "btConvexTriangleMeshShape_makeCPlusPlusInstance" 'function) (ff-pointer self) arg1 ptr))

(cl:shadow "delete")
(cl:defmethod #.(bullet-wrap::swig-lispify "delete" 'method) ((self #.(bullet-wrap::swig-lispify "bt-convex-triangle-mesh-shape" 'classname)) arg1 arg2)
  (#.(bullet-wrap::swig-lispify "btConvexTriangleMeshShape_deleteCPlusPlusInstance" 'function) (ff-pointer self) arg1 arg2))

(cl:shadow "new[]")
(cl:defmethod #.(bullet-wrap::swig-lispify "new[]" 'method) ((self #.(bullet-wrap::swig-lispify "bt-convex-triangle-mesh-shape" 'classname)) sizeInBytes)
  (#.(bullet-wrap::swig-lispify "btConvexTriangleMeshShape_makeCPlusArray" 'function) (ff-pointer self) sizeInBytes))

(cl:shadow "delete[]")
(cl:defmethod #.(bullet-wrap::swig-lispify "delete[]" 'method) ((self #.(bullet-wrap::swig-lispify "bt-convex-triangle-mesh-shape" 'classname)) ptr)
  (#.(bullet-wrap::swig-lispify "btConvexTriangleMeshShape_deleteCPlusArray" 'function) (ff-pointer self) ptr))

(cl:shadow "new[]")
(cl:defmethod #.(bullet-wrap::swig-lispify "new[]" 'method) ((self #.(bullet-wrap::swig-lispify "bt-convex-triangle-mesh-shape" 'classname)) arg1 ptr)
  (#.(bullet-wrap::swig-lispify "btConvexTriangleMeshShape_makeCPlusArray" 'function) (ff-pointer self) arg1 ptr))

(cl:shadow "delete[]")
(cl:defmethod #.(bullet-wrap::swig-lispify "delete[]" 'method) ((self #.(bullet-wrap::swig-lispify "bt-convex-triangle-mesh-shape" 'classname)) arg1 arg2)
  (#.(bullet-wrap::swig-lispify "btConvexTriangleMeshShape_deleteCPlusArray" 'function) (ff-pointer self) arg1 arg2))

(cl:defmethod initialize-instance :after ((obj #.(bullet-wrap::swig-lispify "bt-convex-triangle-mesh-shape" 'class)) &key meshInterface (calcAabb t))
  (setf (slot-value obj 'ff-pointer) (#.(bullet-wrap::swig-lispify "new_btConvexTriangleMeshShape" 'function) meshInterface calcAabb)))

(cl:defmethod initialize-instance :after ((obj #.(bullet-wrap::swig-lispify "bt-convex-triangle-mesh-shape" 'class)) &key meshInterface)
  (setf (slot-value obj 'ff-pointer) (#.(bullet-wrap::swig-lispify "new_btConvexTriangleMeshShape" 'function) meshInterface)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-mesh-interface" 'method) ((self #.(bullet-wrap::swig-lispify "bt-convex-triangle-mesh-shape" 'classname)))
  (#.(bullet-wrap::swig-lispify "btConvexTriangleMeshShape_getMeshInterface" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-mesh-interface" 'method) ((self #.(bullet-wrap::swig-lispify "bt-convex-triangle-mesh-shape" 'classname)))
  (#.(bullet-wrap::swig-lispify "btConvexTriangleMeshShape_getMeshInterface" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "local-get-supporting-vertex" 'method) ((self #.(bullet-wrap::swig-lispify "bt-convex-triangle-mesh-shape" 'classname)) (vec #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)))
  (#.(bullet-wrap::swig-lispify "btConvexTriangleMeshShape_localGetSupportingVertex" 'function) (ff-pointer self) vec))

(cl:defmethod #.(bullet-wrap::swig-lispify "local-get-supporting-vertex-without-margin" 'method) ((self #.(bullet-wrap::swig-lispify "bt-convex-triangle-mesh-shape" 'classname)) (vec #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)))
  (#.(bullet-wrap::swig-lispify "btConvexTriangleMeshShape_localGetSupportingVertexWithoutMargin" 'function) (ff-pointer self) vec))

(cl:defmethod #.(bullet-wrap::swig-lispify "batched-unit-vector-get-supporting-vertex-without-margin" 'method) ((self #.(bullet-wrap::swig-lispify "bt-convex-triangle-mesh-shape" 'classname)) (vectors #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (supportVerticesOut #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (numVectors cl:integer))
  (#.(bullet-wrap::swig-lispify "btConvexTriangleMeshShape_batchedUnitVectorGetSupportingVertexWithoutMargin" 'function) (ff-pointer self) vectors supportVerticesOut numVectors))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-name" 'method) ((self #.(bullet-wrap::swig-lispify "bt-convex-triangle-mesh-shape" 'classname)))
  (#.(bullet-wrap::swig-lispify "btConvexTriangleMeshShape_getName" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-num-vertices" 'method) ((self #.(bullet-wrap::swig-lispify "bt-convex-triangle-mesh-shape" 'classname)))
  (#.(bullet-wrap::swig-lispify "btConvexTriangleMeshShape_getNumVertices" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-num-edges" 'method) ((self #.(bullet-wrap::swig-lispify "bt-convex-triangle-mesh-shape" 'classname)))
  (#.(bullet-wrap::swig-lispify "btConvexTriangleMeshShape_getNumEdges" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-edge" 'method) ((self #.(bullet-wrap::swig-lispify "bt-convex-triangle-mesh-shape" 'classname)) (i cl:integer) (pa #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (pb #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)))
  (#.(bullet-wrap::swig-lispify "btConvexTriangleMeshShape_getEdge" 'function) (ff-pointer self) i pa pb))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-vertex" 'method) ((self #.(bullet-wrap::swig-lispify "bt-convex-triangle-mesh-shape" 'classname)) (i cl:integer) (vtx #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)))
  (#.(bullet-wrap::swig-lispify "btConvexTriangleMeshShape_getVertex" 'function) (ff-pointer self) i vtx))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-num-planes" 'method) ((self #.(bullet-wrap::swig-lispify "bt-convex-triangle-mesh-shape" 'classname)))
  (#.(bullet-wrap::swig-lispify "btConvexTriangleMeshShape_getNumPlanes" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-plane" 'method) ((self #.(bullet-wrap::swig-lispify "bt-convex-triangle-mesh-shape" 'classname)) (planeNormal #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (planeSupport #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (i cl:integer))
  (#.(bullet-wrap::swig-lispify "btConvexTriangleMeshShape_getPlane" 'function) (ff-pointer self) planeNormal planeSupport i))

(cl:defmethod #.(bullet-wrap::swig-lispify "is-inside" 'method) ((self #.(bullet-wrap::swig-lispify "bt-convex-triangle-mesh-shape" 'classname)) (pt #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (tolerance cl:number))
  (#.(bullet-wrap::swig-lispify "btConvexTriangleMeshShape_isInside" 'function) (ff-pointer self) pt tolerance))

(cl:defmethod #.(bullet-wrap::swig-lispify "set-local-scaling" 'method) ((self #.(bullet-wrap::swig-lispify "bt-convex-triangle-mesh-shape" 'classname)) (scaling #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)))
  (#.(bullet-wrap::swig-lispify "btConvexTriangleMeshShape_setLocalScaling" 'function) (ff-pointer self) scaling))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-local-scaling" 'method) ((self #.(bullet-wrap::swig-lispify "bt-convex-triangle-mesh-shape" 'classname)))
  (#.(bullet-wrap::swig-lispify "btConvexTriangleMeshShape_getLocalScaling" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "calculate-principal-axis-transform" 'method) ((self #.(bullet-wrap::swig-lispify "bt-convex-triangle-mesh-shape" 'classname)) (principal #.(bullet-wrap::swig-lispify "bt-transform" 'classname)) (inertia #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) volume)
  (#.(bullet-wrap::swig-lispify "btConvexTriangleMeshShape_calculatePrincipalAxisTransform" 'function) (ff-pointer self) principal inertia volume))


(cl:defclass #.(bullet-wrap::swig-lispify "bt-bvh-triangle-mesh-shape" 'classname)()
  ((ff-pointer :reader ff-pointer)))

(cl:shadow "new")
(cl:defmethod #.(bullet-wrap::swig-lispify "new" 'method) ((self #.(bullet-wrap::swig-lispify "bt-bvh-triangle-mesh-shape" 'classname)) sizeInBytes)
  (#.(bullet-wrap::swig-lispify "btBvhTriangleMeshShape_makeCPlusPlusInstance" 'function) (ff-pointer self) sizeInBytes))

(cl:shadow "delete")
(cl:defmethod #.(bullet-wrap::swig-lispify "delete" 'method) ((self #.(bullet-wrap::swig-lispify "bt-bvh-triangle-mesh-shape" 'classname)) ptr)
  (#.(bullet-wrap::swig-lispify "btBvhTriangleMeshShape_deleteCPlusPlusInstance" 'function) (ff-pointer self) ptr))

(cl:shadow "new")
(cl:defmethod #.(bullet-wrap::swig-lispify "new" 'method) ((self #.(bullet-wrap::swig-lispify "bt-bvh-triangle-mesh-shape" 'classname)) arg1 ptr)
  (#.(bullet-wrap::swig-lispify "btBvhTriangleMeshShape_makeCPlusPlusInstance" 'function) (ff-pointer self) arg1 ptr))

(cl:shadow "delete")
(cl:defmethod #.(bullet-wrap::swig-lispify "delete" 'method) ((self #.(bullet-wrap::swig-lispify "bt-bvh-triangle-mesh-shape" 'classname)) arg1 arg2)
  (#.(bullet-wrap::swig-lispify "btBvhTriangleMeshShape_deleteCPlusPlusInstance" 'function) (ff-pointer self) arg1 arg2))

(cl:shadow "new[]")
(cl:defmethod #.(bullet-wrap::swig-lispify "new[]" 'method) ((self #.(bullet-wrap::swig-lispify "bt-bvh-triangle-mesh-shape" 'classname)) sizeInBytes)
  (#.(bullet-wrap::swig-lispify "btBvhTriangleMeshShape_makeCPlusArray" 'function) (ff-pointer self) sizeInBytes))

(cl:shadow "delete[]")
(cl:defmethod #.(bullet-wrap::swig-lispify "delete[]" 'method) ((self #.(bullet-wrap::swig-lispify "bt-bvh-triangle-mesh-shape" 'classname)) ptr)
  (#.(bullet-wrap::swig-lispify "btBvhTriangleMeshShape_deleteCPlusArray" 'function) (ff-pointer self) ptr))

(cl:shadow "new[]")
(cl:defmethod #.(bullet-wrap::swig-lispify "new[]" 'method) ((self #.(bullet-wrap::swig-lispify "bt-bvh-triangle-mesh-shape" 'classname)) arg1 ptr)
  (#.(bullet-wrap::swig-lispify "btBvhTriangleMeshShape_makeCPlusArray" 'function) (ff-pointer self) arg1 ptr))

(cl:shadow "delete[]")
(cl:defmethod #.(bullet-wrap::swig-lispify "delete[]" 'method) ((self #.(bullet-wrap::swig-lispify "bt-bvh-triangle-mesh-shape" 'classname)) arg1 arg2)
  (#.(bullet-wrap::swig-lispify "btBvhTriangleMeshShape_deleteCPlusArray" 'function) (ff-pointer self) arg1 arg2))

(cl:defmethod initialize-instance :after ((obj #.(bullet-wrap::swig-lispify "bt-bvh-triangle-mesh-shape" 'class)) &key meshInterface (useQuantizedAabbCompression t) (buildBvh t))
  (setf (slot-value obj 'ff-pointer) (#.(bullet-wrap::swig-lispify "new_btBvhTriangleMeshShape" 'function) meshInterface useQuantizedAabbCompression buildBvh)))

(cl:defmethod initialize-instance :after ((obj #.(bullet-wrap::swig-lispify "bt-bvh-triangle-mesh-shape" 'class)) &key meshInterface (useQuantizedAabbCompression t))
  (setf (slot-value obj 'ff-pointer) (#.(bullet-wrap::swig-lispify "new_btBvhTriangleMeshShape" 'function) meshInterface useQuantizedAabbCompression)))

(cl:defmethod initialize-instance :after ((obj #.(bullet-wrap::swig-lispify "bt-bvh-triangle-mesh-shape" 'class)) &key meshInterface (useQuantizedAabbCompression t) (bvhAabbMin #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (bvhAabbMax #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (buildBvh t))
  (setf (slot-value obj 'ff-pointer) (#.(bullet-wrap::swig-lispify "new_btBvhTriangleMeshShape" 'function) meshInterface useQuantizedAabbCompression bvhAabbMin bvhAabbMax buildBvh)))

(cl:defmethod initialize-instance :after ((obj #.(bullet-wrap::swig-lispify "bt-bvh-triangle-mesh-shape" 'class)) &key meshInterface (useQuantizedAabbCompression t) (bvhAabbMin #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (bvhAabbMax #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)))
  (setf (slot-value obj 'ff-pointer) (#.(bullet-wrap::swig-lispify "new_btBvhTriangleMeshShape" 'function) meshInterface useQuantizedAabbCompression bvhAabbMin bvhAabbMax)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-owns-bvh" 'method) ((self #.(bullet-wrap::swig-lispify "bt-bvh-triangle-mesh-shape" 'classname)))
  (#.(bullet-wrap::swig-lispify "btBvhTriangleMeshShape_getOwnsBvh" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "perform-raycast" 'method) ((self #.(bullet-wrap::swig-lispify "bt-bvh-triangle-mesh-shape" 'classname)) callback (raySource #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (rayTarget #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)))
  (#.(bullet-wrap::swig-lispify "btBvhTriangleMeshShape_performRaycast" 'function) (ff-pointer self) callback raySource rayTarget))

(cl:defmethod #.(bullet-wrap::swig-lispify "perform-convexcast" 'method) ((self #.(bullet-wrap::swig-lispify "bt-bvh-triangle-mesh-shape" 'classname)) callback (boxSource #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (boxTarget #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (boxMin #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (boxMax #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)))
  (#.(bullet-wrap::swig-lispify "btBvhTriangleMeshShape_performConvexcast" 'function) (ff-pointer self) callback boxSource boxTarget boxMin boxMax))

(cl:defmethod #.(bullet-wrap::swig-lispify "process-all-triangles" 'method) ((self #.(bullet-wrap::swig-lispify "bt-bvh-triangle-mesh-shape" 'classname)) callback (aabbMin #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (aabbMax #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)))
  (#.(bullet-wrap::swig-lispify "btBvhTriangleMeshShape_processAllTriangles" 'function) (ff-pointer self) callback aabbMin aabbMax))

(cl:defmethod #.(bullet-wrap::swig-lispify "refit-tree" 'method) ((self #.(bullet-wrap::swig-lispify "bt-bvh-triangle-mesh-shape" 'classname)) (aabbMin #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (aabbMax #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)))
  (#.(bullet-wrap::swig-lispify "btBvhTriangleMeshShape_refitTree" 'function) (ff-pointer self) aabbMin aabbMax))

(cl:defmethod #.(bullet-wrap::swig-lispify "partial-refit-tree" 'method) ((self #.(bullet-wrap::swig-lispify "bt-bvh-triangle-mesh-shape" 'classname)) (aabbMin #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (aabbMax #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)))
  (#.(bullet-wrap::swig-lispify "btBvhTriangleMeshShape_partialRefitTree" 'function) (ff-pointer self) aabbMin aabbMax))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-name" 'method) ((self #.(bullet-wrap::swig-lispify "bt-bvh-triangle-mesh-shape" 'classname)))
  (#.(bullet-wrap::swig-lispify "btBvhTriangleMeshShape_getName" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "set-local-scaling" 'method) ((self #.(bullet-wrap::swig-lispify "bt-bvh-triangle-mesh-shape" 'classname)) (scaling #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)))
  (#.(bullet-wrap::swig-lispify "btBvhTriangleMeshShape_setLocalScaling" 'function) (ff-pointer self) scaling))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-optimized-bvh" 'method) ((self #.(bullet-wrap::swig-lispify "bt-bvh-triangle-mesh-shape" 'classname)))
  (#.(bullet-wrap::swig-lispify "btBvhTriangleMeshShape_getOptimizedBvh" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "set-optimized-bvh" 'method) ((self #.(bullet-wrap::swig-lispify "bt-bvh-triangle-mesh-shape" 'classname)) bvh (localScaling #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)))
  (#.(bullet-wrap::swig-lispify "btBvhTriangleMeshShape_setOptimizedBvh" 'function) (ff-pointer self) bvh localScaling))

(cl:defmethod #.(bullet-wrap::swig-lispify "set-optimized-bvh" 'method) ((self #.(bullet-wrap::swig-lispify "bt-bvh-triangle-mesh-shape" 'classname)) bvh)
  (#.(bullet-wrap::swig-lispify "btBvhTriangleMeshShape_setOptimizedBvh" 'function) (ff-pointer self) bvh))

(cl:defmethod #.(bullet-wrap::swig-lispify "build-optimized-bvh" 'method) ((self #.(bullet-wrap::swig-lispify "bt-bvh-triangle-mesh-shape" 'classname)))
  (#.(bullet-wrap::swig-lispify "btBvhTriangleMeshShape_buildOptimizedBvh" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "uses-quantized-aabb-compression" 'method) ((self #.(bullet-wrap::swig-lispify "bt-bvh-triangle-mesh-shape" 'classname)))
  (#.(bullet-wrap::swig-lispify "btBvhTriangleMeshShape_usesQuantizedAabbCompression" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "set-triangle-info-map" 'method) ((self #.(bullet-wrap::swig-lispify "bt-bvh-triangle-mesh-shape" 'classname)) triangleInfoMap)
  (#.(bullet-wrap::swig-lispify "btBvhTriangleMeshShape_setTriangleInfoMap" 'function) (ff-pointer self) triangleInfoMap))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-triangle-info-map" 'method) ((self #.(bullet-wrap::swig-lispify "bt-bvh-triangle-mesh-shape" 'classname)))
  (#.(bullet-wrap::swig-lispify "btBvhTriangleMeshShape_getTriangleInfoMap" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-triangle-info-map" 'method) ((self #.(bullet-wrap::swig-lispify "bt-bvh-triangle-mesh-shape" 'classname)))
  (#.(bullet-wrap::swig-lispify "btBvhTriangleMeshShape_getTriangleInfoMap" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "calculate-serialize-buffer-size" 'method) ((self #.(bullet-wrap::swig-lispify "bt-bvh-triangle-mesh-shape" 'classname)))
  (#.(bullet-wrap::swig-lispify "btBvhTriangleMeshShape_calculateSerializeBufferSize" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "serialize" 'method) ((self #.(bullet-wrap::swig-lispify "bt-bvh-triangle-mesh-shape" 'classname)) dataBuffer serializer)
  (#.(bullet-wrap::swig-lispify "btBvhTriangleMeshShape_serialize" 'function) (ff-pointer self) dataBuffer serializer))

(cl:defmethod #.(bullet-wrap::swig-lispify "serialize-single-bvh" 'method) ((self #.(bullet-wrap::swig-lispify "bt-bvh-triangle-mesh-shape" 'classname)) serializer)
  (#.(bullet-wrap::swig-lispify "btBvhTriangleMeshShape_serializeSingleBvh" 'function) (ff-pointer self) serializer))

(cl:defmethod #.(bullet-wrap::swig-lispify "serialize-single-triangle-info-map" 'method) ((self #.(bullet-wrap::swig-lispify "bt-bvh-triangle-mesh-shape" 'classname)) serializer)
  (#.(bullet-wrap::swig-lispify "btBvhTriangleMeshShape_serializeSingleTriangleInfoMap" 'function) (ff-pointer self) serializer))


(cl:defclass #.(bullet-wrap::swig-lispify "bt-scaled-bvh-triangle-mesh-shape" 'classname)()
  ((ff-pointer :reader ff-pointer)))

(cl:shadow "new")
(cl:defmethod #.(bullet-wrap::swig-lispify "new" 'method) ((self #.(bullet-wrap::swig-lispify "bt-scaled-bvh-triangle-mesh-shape" 'classname)) sizeInBytes)
  (#.(bullet-wrap::swig-lispify "btScaledBvhTriangleMeshShape_makeCPlusPlusInstance" 'function) (ff-pointer self) sizeInBytes))

(cl:shadow "delete")
(cl:defmethod #.(bullet-wrap::swig-lispify "delete" 'method) ((self #.(bullet-wrap::swig-lispify "bt-scaled-bvh-triangle-mesh-shape" 'classname)) ptr)
  (#.(bullet-wrap::swig-lispify "btScaledBvhTriangleMeshShape_deleteCPlusPlusInstance" 'function) (ff-pointer self) ptr))

(cl:shadow "new")
(cl:defmethod #.(bullet-wrap::swig-lispify "new" 'method) ((self #.(bullet-wrap::swig-lispify "bt-scaled-bvh-triangle-mesh-shape" 'classname)) arg1 ptr)
  (#.(bullet-wrap::swig-lispify "btScaledBvhTriangleMeshShape_makeCPlusPlusInstance" 'function) (ff-pointer self) arg1 ptr))

(cl:shadow "delete")
(cl:defmethod #.(bullet-wrap::swig-lispify "delete" 'method) ((self #.(bullet-wrap::swig-lispify "bt-scaled-bvh-triangle-mesh-shape" 'classname)) arg1 arg2)
  (#.(bullet-wrap::swig-lispify "btScaledBvhTriangleMeshShape_deleteCPlusPlusInstance" 'function) (ff-pointer self) arg1 arg2))

(cl:shadow "new[]")
(cl:defmethod #.(bullet-wrap::swig-lispify "new[]" 'method) ((self #.(bullet-wrap::swig-lispify "bt-scaled-bvh-triangle-mesh-shape" 'classname)) sizeInBytes)
  (#.(bullet-wrap::swig-lispify "btScaledBvhTriangleMeshShape_makeCPlusArray" 'function) (ff-pointer self) sizeInBytes))

(cl:shadow "delete[]")
(cl:defmethod #.(bullet-wrap::swig-lispify "delete[]" 'method) ((self #.(bullet-wrap::swig-lispify "bt-scaled-bvh-triangle-mesh-shape" 'classname)) ptr)
  (#.(bullet-wrap::swig-lispify "btScaledBvhTriangleMeshShape_deleteCPlusArray" 'function) (ff-pointer self) ptr))

(cl:shadow "new[]")
(cl:defmethod #.(bullet-wrap::swig-lispify "new[]" 'method) ((self #.(bullet-wrap::swig-lispify "bt-scaled-bvh-triangle-mesh-shape" 'classname)) arg1 ptr)
  (#.(bullet-wrap::swig-lispify "btScaledBvhTriangleMeshShape_makeCPlusArray" 'function) (ff-pointer self) arg1 ptr))

(cl:shadow "delete[]")
(cl:defmethod #.(bullet-wrap::swig-lispify "delete[]" 'method) ((self #.(bullet-wrap::swig-lispify "bt-scaled-bvh-triangle-mesh-shape" 'classname)) arg1 arg2)
  (#.(bullet-wrap::swig-lispify "btScaledBvhTriangleMeshShape_deleteCPlusArray" 'function) (ff-pointer self) arg1 arg2))

(cl:defmethod initialize-instance :after ((obj #.(bullet-wrap::swig-lispify "bt-scaled-bvh-triangle-mesh-shape" 'class)) &key (childShape #.(bullet-wrap::swig-lispify "bt-bvh-triangle-mesh-shape" 'classname)) (localScaling #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)))
  (setf (slot-value obj 'ff-pointer) (#.(bullet-wrap::swig-lispify "new_btScaledBvhTriangleMeshShape" 'function) childShape localScaling)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-aabb" 'method) ((self #.(bullet-wrap::swig-lispify "bt-scaled-bvh-triangle-mesh-shape" 'classname)) (t-arg1 #.(bullet-wrap::swig-lispify "bt-transform" 'classname)) (aabbMin #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (aabbMax #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)))
  (#.(bullet-wrap::swig-lispify "btScaledBvhTriangleMeshShape_getAabb" 'function) (ff-pointer self) t-arg1 aabbMin aabbMax))

(cl:defmethod #.(bullet-wrap::swig-lispify "set-local-scaling" 'method) ((self #.(bullet-wrap::swig-lispify "bt-scaled-bvh-triangle-mesh-shape" 'classname)) (scaling #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)))
  (#.(bullet-wrap::swig-lispify "btScaledBvhTriangleMeshShape_setLocalScaling" 'function) (ff-pointer self) scaling))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-local-scaling" 'method) ((self #.(bullet-wrap::swig-lispify "bt-scaled-bvh-triangle-mesh-shape" 'classname)))
  (#.(bullet-wrap::swig-lispify "btScaledBvhTriangleMeshShape_getLocalScaling" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "calculate-local-inertia" 'method) ((self #.(bullet-wrap::swig-lispify "bt-scaled-bvh-triangle-mesh-shape" 'classname)) (mass cl:number) (inertia #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)))
  (#.(bullet-wrap::swig-lispify "btScaledBvhTriangleMeshShape_calculateLocalInertia" 'function) (ff-pointer self) mass inertia))

(cl:defmethod #.(bullet-wrap::swig-lispify "process-all-triangles" 'method) ((self #.(bullet-wrap::swig-lispify "bt-scaled-bvh-triangle-mesh-shape" 'classname)) callback (aabbMin #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (aabbMax #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)))
  (#.(bullet-wrap::swig-lispify "btScaledBvhTriangleMeshShape_processAllTriangles" 'function) (ff-pointer self) callback aabbMin aabbMax))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-child-shape" 'method) ((self #.(bullet-wrap::swig-lispify "bt-scaled-bvh-triangle-mesh-shape" 'classname)))
  (#.(bullet-wrap::swig-lispify "btScaledBvhTriangleMeshShape_getChildShape" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-child-shape" 'method) ((self #.(bullet-wrap::swig-lispify "bt-scaled-bvh-triangle-mesh-shape" 'classname)))
  (#.(bullet-wrap::swig-lispify "btScaledBvhTriangleMeshShape_getChildShape" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-name" 'method) ((self #.(bullet-wrap::swig-lispify "bt-scaled-bvh-triangle-mesh-shape" 'classname)))
  (#.(bullet-wrap::swig-lispify "btScaledBvhTriangleMeshShape_getName" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "calculate-serialize-buffer-size" 'method) ((self #.(bullet-wrap::swig-lispify "bt-scaled-bvh-triangle-mesh-shape" 'classname)))
  (#.(bullet-wrap::swig-lispify "btScaledBvhTriangleMeshShape_calculateSerializeBufferSize" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "serialize" 'method) ((self #.(bullet-wrap::swig-lispify "bt-scaled-bvh-triangle-mesh-shape" 'classname)) dataBuffer serializer)
  (#.(bullet-wrap::swig-lispify "btScaledBvhTriangleMeshShape_serialize" 'function) (ff-pointer self) dataBuffer serializer))


(cl:defclass #.(bullet-wrap::swig-lispify "bt-triangle-mesh-shape" 'classname)()
  ((ff-pointer :reader ff-pointer)))

(cl:shadow "new")
(cl:defmethod #.(bullet-wrap::swig-lispify "new" 'method) ((self #.(bullet-wrap::swig-lispify "bt-triangle-mesh-shape" 'classname)) sizeInBytes)
  (#.(bullet-wrap::swig-lispify "btTriangleMeshShape_makeCPlusPlusInstance" 'function) (ff-pointer self) sizeInBytes))

(cl:shadow "delete")
(cl:defmethod #.(bullet-wrap::swig-lispify "delete" 'method) ((self #.(bullet-wrap::swig-lispify "bt-triangle-mesh-shape" 'classname)) ptr)
  (#.(bullet-wrap::swig-lispify "btTriangleMeshShape_deleteCPlusPlusInstance" 'function) (ff-pointer self) ptr))

(cl:shadow "new")
(cl:defmethod #.(bullet-wrap::swig-lispify "new" 'method) ((self #.(bullet-wrap::swig-lispify "bt-triangle-mesh-shape" 'classname)) arg1 ptr)
  (#.(bullet-wrap::swig-lispify "btTriangleMeshShape_makeCPlusPlusInstance" 'function) (ff-pointer self) arg1 ptr))

(cl:shadow "delete")
(cl:defmethod #.(bullet-wrap::swig-lispify "delete" 'method) ((self #.(bullet-wrap::swig-lispify "bt-triangle-mesh-shape" 'classname)) arg1 arg2)
  (#.(bullet-wrap::swig-lispify "btTriangleMeshShape_deleteCPlusPlusInstance" 'function) (ff-pointer self) arg1 arg2))

(cl:shadow "new[]")
(cl:defmethod #.(bullet-wrap::swig-lispify "new[]" 'method) ((self #.(bullet-wrap::swig-lispify "bt-triangle-mesh-shape" 'classname)) sizeInBytes)
  (#.(bullet-wrap::swig-lispify "btTriangleMeshShape_makeCPlusArray" 'function) (ff-pointer self) sizeInBytes))

(cl:shadow "delete[]")
(cl:defmethod #.(bullet-wrap::swig-lispify "delete[]" 'method) ((self #.(bullet-wrap::swig-lispify "bt-triangle-mesh-shape" 'classname)) ptr)
  (#.(bullet-wrap::swig-lispify "btTriangleMeshShape_deleteCPlusArray" 'function) (ff-pointer self) ptr))

(cl:shadow "new[]")
(cl:defmethod #.(bullet-wrap::swig-lispify "new[]" 'method) ((self #.(bullet-wrap::swig-lispify "bt-triangle-mesh-shape" 'classname)) arg1 ptr)
  (#.(bullet-wrap::swig-lispify "btTriangleMeshShape_makeCPlusArray" 'function) (ff-pointer self) arg1 ptr))

(cl:shadow "delete[]")
(cl:defmethod #.(bullet-wrap::swig-lispify "delete[]" 'method) ((self #.(bullet-wrap::swig-lispify "bt-triangle-mesh-shape" 'classname)) arg1 arg2)
  (#.(bullet-wrap::swig-lispify "btTriangleMeshShape_deleteCPlusArray" 'function) (ff-pointer self) arg1 arg2))

(cl:defmethod #.(bullet-wrap::swig-lispify "local-get-supporting-vertex" 'method) ((self #.(bullet-wrap::swig-lispify "bt-triangle-mesh-shape" 'classname)) (vec #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)))
  (#.(bullet-wrap::swig-lispify "btTriangleMeshShape_localGetSupportingVertex" 'function) (ff-pointer self) vec))

(cl:defmethod #.(bullet-wrap::swig-lispify "local-get-supporting-vertex-without-margin" 'method) ((self #.(bullet-wrap::swig-lispify "bt-triangle-mesh-shape" 'classname)) (vec #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)))
  (#.(bullet-wrap::swig-lispify "btTriangleMeshShape_localGetSupportingVertexWithoutMargin" 'function) (ff-pointer self) vec))

(cl:defmethod #.(bullet-wrap::swig-lispify "recalc-local-aabb" 'method) ((self #.(bullet-wrap::swig-lispify "bt-triangle-mesh-shape" 'classname)))
  (#.(bullet-wrap::swig-lispify "btTriangleMeshShape_recalcLocalAabb" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-aabb" 'method) ((self #.(bullet-wrap::swig-lispify "bt-triangle-mesh-shape" 'classname)) (t-arg1 #.(bullet-wrap::swig-lispify "bt-transform" 'classname)) (aabbMin #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (aabbMax #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)))
  (#.(bullet-wrap::swig-lispify "btTriangleMeshShape_getAabb" 'function) (ff-pointer self) t-arg1 aabbMin aabbMax))

(cl:defmethod #.(bullet-wrap::swig-lispify "process-all-triangles" 'method) ((self #.(bullet-wrap::swig-lispify "bt-triangle-mesh-shape" 'classname)) callback (aabbMin #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (aabbMax #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)))
  (#.(bullet-wrap::swig-lispify "btTriangleMeshShape_processAllTriangles" 'function) (ff-pointer self) callback aabbMin aabbMax))

(cl:defmethod #.(bullet-wrap::swig-lispify "calculate-local-inertia" 'method) ((self #.(bullet-wrap::swig-lispify "bt-triangle-mesh-shape" 'classname)) (mass cl:number) (inertia #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)))
  (#.(bullet-wrap::swig-lispify "btTriangleMeshShape_calculateLocalInertia" 'function) (ff-pointer self) mass inertia))

(cl:defmethod #.(bullet-wrap::swig-lispify "set-local-scaling" 'method) ((self #.(bullet-wrap::swig-lispify "bt-triangle-mesh-shape" 'classname)) (scaling #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)))
  (#.(bullet-wrap::swig-lispify "btTriangleMeshShape_setLocalScaling" 'function) (ff-pointer self) scaling))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-local-scaling" 'method) ((self #.(bullet-wrap::swig-lispify "bt-triangle-mesh-shape" 'classname)))
  (#.(bullet-wrap::swig-lispify "btTriangleMeshShape_getLocalScaling" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-mesh-interface" 'method) ((self #.(bullet-wrap::swig-lispify "bt-triangle-mesh-shape" 'classname)))
  (#.(bullet-wrap::swig-lispify "btTriangleMeshShape_getMeshInterface" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-mesh-interface" 'method) ((self #.(bullet-wrap::swig-lispify "bt-triangle-mesh-shape" 'classname)))
  (#.(bullet-wrap::swig-lispify "btTriangleMeshShape_getMeshInterface" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-local-aabb-min" 'method) ((self #.(bullet-wrap::swig-lispify "bt-triangle-mesh-shape" 'classname)))
  (#.(bullet-wrap::swig-lispify "btTriangleMeshShape_getLocalAabbMin" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-local-aabb-max" 'method) ((self #.(bullet-wrap::swig-lispify "bt-triangle-mesh-shape" 'classname)))
  (#.(bullet-wrap::swig-lispify "btTriangleMeshShape_getLocalAabbMax" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-name" 'method) ((self #.(bullet-wrap::swig-lispify "bt-triangle-mesh-shape" 'classname)))
  (#.(bullet-wrap::swig-lispify "btTriangleMeshShape_getName" 'function) (ff-pointer self)))


(cl:defclass #.(bullet-wrap::swig-lispify "bt-triangle-index-vertex-array" 'classname)()
  ((ff-pointer :reader ff-pointer)))

(cl:shadow "new")
(cl:defmethod #.(bullet-wrap::swig-lispify "new" 'method) ((self #.(bullet-wrap::swig-lispify "bt-triangle-index-vertex-array" 'classname)) sizeInBytes)
  (#.(bullet-wrap::swig-lispify "btTriangleIndexVertexArray_makeCPlusPlusInstance" 'function) (ff-pointer self) sizeInBytes))

(cl:shadow "delete")
(cl:defmethod #.(bullet-wrap::swig-lispify "delete" 'method) ((self #.(bullet-wrap::swig-lispify "bt-triangle-index-vertex-array" 'classname)) ptr)
  (#.(bullet-wrap::swig-lispify "btTriangleIndexVertexArray_deleteCPlusPlusInstance" 'function) (ff-pointer self) ptr))

(cl:shadow "new")
(cl:defmethod #.(bullet-wrap::swig-lispify "new" 'method) ((self #.(bullet-wrap::swig-lispify "bt-triangle-index-vertex-array" 'classname)) arg1 ptr)
  (#.(bullet-wrap::swig-lispify "btTriangleIndexVertexArray_makeCPlusPlusInstance" 'function) (ff-pointer self) arg1 ptr))

(cl:shadow "delete")
(cl:defmethod #.(bullet-wrap::swig-lispify "delete" 'method) ((self #.(bullet-wrap::swig-lispify "bt-triangle-index-vertex-array" 'classname)) arg1 arg2)
  (#.(bullet-wrap::swig-lispify "btTriangleIndexVertexArray_deleteCPlusPlusInstance" 'function) (ff-pointer self) arg1 arg2))

(cl:shadow "new[]")
(cl:defmethod #.(bullet-wrap::swig-lispify "new[]" 'method) ((self #.(bullet-wrap::swig-lispify "bt-triangle-index-vertex-array" 'classname)) sizeInBytes)
  (#.(bullet-wrap::swig-lispify "btTriangleIndexVertexArray_makeCPlusArray" 'function) (ff-pointer self) sizeInBytes))

(cl:shadow "delete[]")
(cl:defmethod #.(bullet-wrap::swig-lispify "delete[]" 'method) ((self #.(bullet-wrap::swig-lispify "bt-triangle-index-vertex-array" 'classname)) ptr)
  (#.(bullet-wrap::swig-lispify "btTriangleIndexVertexArray_deleteCPlusArray" 'function) (ff-pointer self) ptr))

(cl:shadow "new[]")
(cl:defmethod #.(bullet-wrap::swig-lispify "new[]" 'method) ((self #.(bullet-wrap::swig-lispify "bt-triangle-index-vertex-array" 'classname)) arg1 ptr)
  (#.(bullet-wrap::swig-lispify "btTriangleIndexVertexArray_makeCPlusArray" 'function) (ff-pointer self) arg1 ptr))

(cl:shadow "delete[]")
(cl:defmethod #.(bullet-wrap::swig-lispify "delete[]" 'method) ((self #.(bullet-wrap::swig-lispify "bt-triangle-index-vertex-array" 'classname)) arg1 arg2)
  (#.(bullet-wrap::swig-lispify "btTriangleIndexVertexArray_deleteCPlusArray" 'function) (ff-pointer self) arg1 arg2))

(cl:defmethod initialize-instance :after ((obj #.(bullet-wrap::swig-lispify "bt-triangle-index-vertex-array" 'class)) &key)
  (setf (slot-value obj 'ff-pointer) (#.(bullet-wrap::swig-lispify "new_btTriangleIndexVertexArray" 'function))))

(cl:defmethod initialize-instance :after ((obj #.(bullet-wrap::swig-lispify "bt-triangle-index-vertex-array" 'class)) &key (numTriangles cl:integer) triangleIndexBase (triangleIndexStride cl:integer) (numVertices cl:integer) vertexBase (vertexStride cl:integer))
  (setf (slot-value obj 'ff-pointer) (#.(bullet-wrap::swig-lispify "new_btTriangleIndexVertexArray" 'function) numTriangles triangleIndexBase triangleIndexStride numVertices vertexBase vertexStride)))

(cl:defmethod #.(bullet-wrap::swig-lispify "add-indexed-mesh" 'method) ((self #.(bullet-wrap::swig-lispify "bt-triangle-index-vertex-array" 'classname)) mesh indexType)
  (#.(bullet-wrap::swig-lispify "btTriangleIndexVertexArray_addIndexedMesh" 'function) (ff-pointer self) mesh indexType))

(cl:defmethod #.(bullet-wrap::swig-lispify "add-indexed-mesh" 'method) ((self #.(bullet-wrap::swig-lispify "bt-triangle-index-vertex-array" 'classname)) mesh)
  (#.(bullet-wrap::swig-lispify "btTriangleIndexVertexArray_addIndexedMesh" 'function) (ff-pointer self) mesh))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-locked-vertex-index-base" 'method) ((self #.(bullet-wrap::swig-lispify "bt-triangle-index-vertex-array" 'classname)) vertexbase numverts type vertexStride indexbase indexstride numfaces indicestype (subpart cl:integer))
  (#.(bullet-wrap::swig-lispify "btTriangleIndexVertexArray_getLockedVertexIndexBase" 'function) (ff-pointer self) vertexbase numverts type vertexStride indexbase indexstride numfaces indicestype subpart))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-locked-vertex-index-base" 'method) ((self #.(bullet-wrap::swig-lispify "bt-triangle-index-vertex-array" 'classname)) vertexbase numverts type vertexStride indexbase indexstride numfaces indicestype)
  (#.(bullet-wrap::swig-lispify "btTriangleIndexVertexArray_getLockedVertexIndexBase" 'function) (ff-pointer self) vertexbase numverts type vertexStride indexbase indexstride numfaces indicestype))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-locked-read-only-vertex-index-base" 'method) ((self #.(bullet-wrap::swig-lispify "bt-triangle-index-vertex-array" 'classname)) vertexbase numverts type vertexStride indexbase indexstride numfaces indicestype (subpart cl:integer))
  (#.(bullet-wrap::swig-lispify "btTriangleIndexVertexArray_getLockedReadOnlyVertexIndexBase" 'function) (ff-pointer self) vertexbase numverts type vertexStride indexbase indexstride numfaces indicestype subpart))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-locked-read-only-vertex-index-base" 'method) ((self #.(bullet-wrap::swig-lispify "bt-triangle-index-vertex-array" 'classname)) vertexbase numverts type vertexStride indexbase indexstride numfaces indicestype)
  (#.(bullet-wrap::swig-lispify "btTriangleIndexVertexArray_getLockedReadOnlyVertexIndexBase" 'function) (ff-pointer self) vertexbase numverts type vertexStride indexbase indexstride numfaces indicestype))

(cl:defmethod #.(bullet-wrap::swig-lispify "un-lock-vertex-base" 'method) ((self #.(bullet-wrap::swig-lispify "bt-triangle-index-vertex-array" 'classname)) (subpart cl:integer))
  (#.(bullet-wrap::swig-lispify "btTriangleIndexVertexArray_unLockVertexBase" 'function) (ff-pointer self) subpart))

(cl:defmethod #.(bullet-wrap::swig-lispify "un-lock-read-only-vertex-base" 'method) ((self #.(bullet-wrap::swig-lispify "bt-triangle-index-vertex-array" 'classname)) (subpart cl:integer))
  (#.(bullet-wrap::swig-lispify "btTriangleIndexVertexArray_unLockReadOnlyVertexBase" 'function) (ff-pointer self) subpart))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-num-sub-parts" 'method) ((self #.(bullet-wrap::swig-lispify "bt-triangle-index-vertex-array" 'classname)))
  (#.(bullet-wrap::swig-lispify "btTriangleIndexVertexArray_getNumSubParts" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-indexed-mesh-array" 'method) ((self #.(bullet-wrap::swig-lispify "bt-triangle-index-vertex-array" 'classname)))
  (#.(bullet-wrap::swig-lispify "btTriangleIndexVertexArray_getIndexedMeshArray" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-indexed-mesh-array" 'method) ((self #.(bullet-wrap::swig-lispify "bt-triangle-index-vertex-array" 'classname)))
  (#.(bullet-wrap::swig-lispify "btTriangleIndexVertexArray_getIndexedMeshArray" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "preallocate-vertices" 'method) ((self #.(bullet-wrap::swig-lispify "bt-triangle-index-vertex-array" 'classname)) (numverts cl:integer))
  (#.(bullet-wrap::swig-lispify "btTriangleIndexVertexArray_preallocateVertices" 'function) (ff-pointer self) numverts))

(cl:defmethod #.(bullet-wrap::swig-lispify "preallocate-indices" 'method) ((self #.(bullet-wrap::swig-lispify "bt-triangle-index-vertex-array" 'classname)) (numindices cl:integer))
  (#.(bullet-wrap::swig-lispify "btTriangleIndexVertexArray_preallocateIndices" 'function) (ff-pointer self) numindices))

(cl:defmethod #.(bullet-wrap::swig-lispify "has-premade-aabb" 'method) ((self #.(bullet-wrap::swig-lispify "bt-triangle-index-vertex-array" 'classname)))
  (#.(bullet-wrap::swig-lispify "btTriangleIndexVertexArray_hasPremadeAabb" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "set-premade-aabb" 'method) ((self #.(bullet-wrap::swig-lispify "bt-triangle-index-vertex-array" 'classname)) (aabbMin #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (aabbMax #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)))
  (#.(bullet-wrap::swig-lispify "btTriangleIndexVertexArray_setPremadeAabb" 'function) (ff-pointer self) aabbMin aabbMax))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-premade-aabb" 'method) ((self #.(bullet-wrap::swig-lispify "bt-triangle-index-vertex-array" 'classname)) (aabbMin #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (aabbMax #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)))
  (#.(bullet-wrap::swig-lispify "btTriangleIndexVertexArray_getPremadeAabb" 'function) (ff-pointer self) aabbMin aabbMax))


(cl:defclass #.(bullet-wrap::swig-lispify "bt-compound-shape" 'classname)()
  ((ff-pointer :reader ff-pointer)))

(cl:shadow "new")
(cl:defmethod #.(bullet-wrap::swig-lispify "new" 'method) ((self #.(bullet-wrap::swig-lispify "bt-compound-shape" 'classname)) sizeInBytes)
  (#.(bullet-wrap::swig-lispify "btCompoundShape_makeCPlusPlusInstance" 'function) (ff-pointer self) sizeInBytes))

(cl:shadow "delete")
(cl:defmethod #.(bullet-wrap::swig-lispify "delete" 'method) ((self #.(bullet-wrap::swig-lispify "bt-compound-shape" 'classname)) ptr)
  (#.(bullet-wrap::swig-lispify "btCompoundShape_deleteCPlusPlusInstance" 'function) (ff-pointer self) ptr))

(cl:shadow "new")
(cl:defmethod #.(bullet-wrap::swig-lispify "new" 'method) ((self #.(bullet-wrap::swig-lispify "bt-compound-shape" 'classname)) arg1 ptr)
  (#.(bullet-wrap::swig-lispify "btCompoundShape_makeCPlusPlusInstance" 'function) (ff-pointer self) arg1 ptr))

(cl:shadow "delete")
(cl:defmethod #.(bullet-wrap::swig-lispify "delete" 'method) ((self #.(bullet-wrap::swig-lispify "bt-compound-shape" 'classname)) arg1 arg2)
  (#.(bullet-wrap::swig-lispify "btCompoundShape_deleteCPlusPlusInstance" 'function) (ff-pointer self) arg1 arg2))

(cl:shadow "new[]")
(cl:defmethod #.(bullet-wrap::swig-lispify "new[]" 'method) ((self #.(bullet-wrap::swig-lispify "bt-compound-shape" 'classname)) sizeInBytes)
  (#.(bullet-wrap::swig-lispify "btCompoundShape_makeCPlusArray" 'function) (ff-pointer self) sizeInBytes))

(cl:shadow "delete[]")
(cl:defmethod #.(bullet-wrap::swig-lispify "delete[]" 'method) ((self #.(bullet-wrap::swig-lispify "bt-compound-shape" 'classname)) ptr)
  (#.(bullet-wrap::swig-lispify "btCompoundShape_deleteCPlusArray" 'function) (ff-pointer self) ptr))

(cl:shadow "new[]")
(cl:defmethod #.(bullet-wrap::swig-lispify "new[]" 'method) ((self #.(bullet-wrap::swig-lispify "bt-compound-shape" 'classname)) arg1 ptr)
  (#.(bullet-wrap::swig-lispify "btCompoundShape_makeCPlusArray" 'function) (ff-pointer self) arg1 ptr))

(cl:shadow "delete[]")
(cl:defmethod #.(bullet-wrap::swig-lispify "delete[]" 'method) ((self #.(bullet-wrap::swig-lispify "bt-compound-shape" 'classname)) arg1 arg2)
  (#.(bullet-wrap::swig-lispify "btCompoundShape_deleteCPlusArray" 'function) (ff-pointer self) arg1 arg2))

(cl:defmethod initialize-instance :after ((obj #.(bullet-wrap::swig-lispify "bt-compound-shape" 'class)) &key (enableDynamicAabbTree t))
  (setf (slot-value obj 'ff-pointer) (#.(bullet-wrap::swig-lispify "new_btCompoundShape" 'function) enableDynamicAabbTree)))

(cl:defmethod initialize-instance :after ((obj #.(bullet-wrap::swig-lispify "bt-compound-shape" 'class)) &key)
  (setf (slot-value obj 'ff-pointer) (#.(bullet-wrap::swig-lispify "new_btCompoundShape" 'function))))

(cl:defmethod #.(bullet-wrap::swig-lispify "add-child-shape" 'method) ((self #.(bullet-wrap::swig-lispify "bt-compound-shape" 'classname)) (localTransform #.(bullet-wrap::swig-lispify "bt-transform" 'classname)) shape)
  (#.(bullet-wrap::swig-lispify "btCompoundShape_addChildShape" 'function) (ff-pointer self) localTransform shape))

(cl:defmethod #.(bullet-wrap::swig-lispify "remove-child-shape" 'method) ((self #.(bullet-wrap::swig-lispify "bt-compound-shape" 'classname)) shape)
  (#.(bullet-wrap::swig-lispify "btCompoundShape_removeChildShape" 'function) (ff-pointer self) shape))

(cl:defmethod #.(bullet-wrap::swig-lispify "remove-child-shape-by-index" 'method) ((self #.(bullet-wrap::swig-lispify "bt-compound-shape" 'classname)) (childShapeindex cl:integer))
  (#.(bullet-wrap::swig-lispify "btCompoundShape_removeChildShapeByIndex" 'function) (ff-pointer self) childShapeindex))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-num-child-shapes" 'method) ((self #.(bullet-wrap::swig-lispify "bt-compound-shape" 'classname)))
  (#.(bullet-wrap::swig-lispify "btCompoundShape_getNumChildShapes" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-child-shape" 'method) ((self #.(bullet-wrap::swig-lispify "bt-compound-shape" 'classname)) (index cl:integer))
  (#.(bullet-wrap::swig-lispify "btCompoundShape_getChildShape" 'function) (ff-pointer self) index))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-child-shape" 'method) ((self #.(bullet-wrap::swig-lispify "bt-compound-shape" 'classname)) (index cl:integer))
  (#.(bullet-wrap::swig-lispify "btCompoundShape_getChildShape" 'function) (ff-pointer self) index))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-child-transform" 'method) ((self #.(bullet-wrap::swig-lispify "bt-compound-shape" 'classname)) (index cl:integer))
  (#.(bullet-wrap::swig-lispify "btCompoundShape_getChildTransform" 'function) (ff-pointer self) index))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-child-transform" 'method) ((self #.(bullet-wrap::swig-lispify "bt-compound-shape" 'classname)) (index cl:integer))
  (#.(bullet-wrap::swig-lispify "btCompoundShape_getChildTransform" 'function) (ff-pointer self) index))

(cl:defmethod #.(bullet-wrap::swig-lispify "update-child-transform" 'method) ((self #.(bullet-wrap::swig-lispify "bt-compound-shape" 'classname)) (childIndex cl:integer) (newChildTransform #.(bullet-wrap::swig-lispify "bt-transform" 'classname)) (shouldRecalculateLocalAabb t))
  (#.(bullet-wrap::swig-lispify "btCompoundShape_updateChildTransform" 'function) (ff-pointer self) childIndex newChildTransform shouldRecalculateLocalAabb))

(cl:defmethod #.(bullet-wrap::swig-lispify "update-child-transform" 'method) ((self #.(bullet-wrap::swig-lispify "bt-compound-shape" 'classname)) (childIndex cl:integer) (newChildTransform #.(bullet-wrap::swig-lispify "bt-transform" 'classname)))
  (#.(bullet-wrap::swig-lispify "btCompoundShape_updateChildTransform" 'function) (ff-pointer self) childIndex newChildTransform))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-child-list" 'method) ((self #.(bullet-wrap::swig-lispify "bt-compound-shape" 'classname)))
  (#.(bullet-wrap::swig-lispify "btCompoundShape_getChildList" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-aabb" 'method) ((self #.(bullet-wrap::swig-lispify "bt-compound-shape" 'classname)) (t-arg1 #.(bullet-wrap::swig-lispify "bt-transform" 'classname)) (aabbMin #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (aabbMax #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)))
  (#.(bullet-wrap::swig-lispify "btCompoundShape_getAabb" 'function) (ff-pointer self) t-arg1 aabbMin aabbMax))

(cl:defmethod #.(bullet-wrap::swig-lispify "recalculate-local-aabb" 'method) ((self #.(bullet-wrap::swig-lispify "bt-compound-shape" 'classname)))
  (#.(bullet-wrap::swig-lispify "btCompoundShape_recalculateLocalAabb" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "set-local-scaling" 'method) ((self #.(bullet-wrap::swig-lispify "bt-compound-shape" 'classname)) (scaling #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)))
  (#.(bullet-wrap::swig-lispify "btCompoundShape_setLocalScaling" 'function) (ff-pointer self) scaling))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-local-scaling" 'method) ((self #.(bullet-wrap::swig-lispify "bt-compound-shape" 'classname)))
  (#.(bullet-wrap::swig-lispify "btCompoundShape_getLocalScaling" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "calculate-local-inertia" 'method) ((self #.(bullet-wrap::swig-lispify "bt-compound-shape" 'classname)) (mass cl:number) (inertia #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)))
  (#.(bullet-wrap::swig-lispify "btCompoundShape_calculateLocalInertia" 'function) (ff-pointer self) mass inertia))

(cl:defmethod #.(bullet-wrap::swig-lispify "set-margin" 'method) ((self #.(bullet-wrap::swig-lispify "bt-compound-shape" 'classname)) (margin cl:number))
  (#.(bullet-wrap::swig-lispify "btCompoundShape_setMargin" 'function) (ff-pointer self) margin))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-margin" 'method) ((self #.(bullet-wrap::swig-lispify "bt-compound-shape" 'classname)))
  (#.(bullet-wrap::swig-lispify "btCompoundShape_getMargin" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-name" 'method) ((self #.(bullet-wrap::swig-lispify "bt-compound-shape" 'classname)))
  (#.(bullet-wrap::swig-lispify "btCompoundShape_getName" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-dynamic-aabb-tree" 'method) ((self #.(bullet-wrap::swig-lispify "bt-compound-shape" 'classname)))
  (#.(bullet-wrap::swig-lispify "btCompoundShape_getDynamicAabbTree" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-dynamic-aabb-tree" 'method) ((self #.(bullet-wrap::swig-lispify "bt-compound-shape" 'classname)))
  (#.(bullet-wrap::swig-lispify "btCompoundShape_getDynamicAabbTree" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "create-aabb-tree-from-children" 'method) ((self #.(bullet-wrap::swig-lispify "bt-compound-shape" 'classname)))
  (#.(bullet-wrap::swig-lispify "btCompoundShape_createAabbTreeFromChildren" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "calculate-principal-axis-transform" 'method) ((self #.(bullet-wrap::swig-lispify "bt-compound-shape" 'classname)) masses (principal #.(bullet-wrap::swig-lispify "bt-transform" 'classname)) (inertia #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)))
  (#.(bullet-wrap::swig-lispify "btCompoundShape_calculatePrincipalAxisTransform" 'function) (ff-pointer self) masses principal inertia))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-update-revision" 'method) ((self #.(bullet-wrap::swig-lispify "bt-compound-shape" 'classname)))
  (#.(bullet-wrap::swig-lispify "btCompoundShape_getUpdateRevision" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "calculate-serialize-buffer-size" 'method) ((self #.(bullet-wrap::swig-lispify "bt-compound-shape" 'classname)))
  (#.(bullet-wrap::swig-lispify "btCompoundShape_calculateSerializeBufferSize" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "serialize" 'method) ((self #.(bullet-wrap::swig-lispify "bt-compound-shape" 'classname)) dataBuffer serializer)
  (#.(bullet-wrap::swig-lispify "btCompoundShape_serialize" 'function) (ff-pointer self) dataBuffer serializer))


(cl:defclass #.(bullet-wrap::swig-lispify "bt-bu-simplex1to4" 'classname)()
  ((ff-pointer :reader ff-pointer)))

(cl:shadow "new")
(cl:defmethod #.(bullet-wrap::swig-lispify "new" 'method) ((self #.(bullet-wrap::swig-lispify "bt-bu-simplex1to4" 'classname)) sizeInBytes)
  (#.(bullet-wrap::swig-lispify "btBU_Simplex1to4_makeCPlusPlusInstance" 'function) (ff-pointer self) sizeInBytes))

(cl:shadow "delete")
(cl:defmethod #.(bullet-wrap::swig-lispify "delete" 'method) ((self #.(bullet-wrap::swig-lispify "bt-bu-simplex1to4" 'classname)) ptr)
  (#.(bullet-wrap::swig-lispify "btBU_Simplex1to4_deleteCPlusPlusInstance" 'function) (ff-pointer self) ptr))

(cl:shadow "new")
(cl:defmethod #.(bullet-wrap::swig-lispify "new" 'method) ((self #.(bullet-wrap::swig-lispify "bt-bu-simplex1to4" 'classname)) arg1 ptr)
  (#.(bullet-wrap::swig-lispify "btBU_Simplex1to4_makeCPlusPlusInstance" 'function) (ff-pointer self) arg1 ptr))

(cl:shadow "delete")
(cl:defmethod #.(bullet-wrap::swig-lispify "delete" 'method) ((self #.(bullet-wrap::swig-lispify "bt-bu-simplex1to4" 'classname)) arg1 arg2)
  (#.(bullet-wrap::swig-lispify "btBU_Simplex1to4_deleteCPlusPlusInstance" 'function) (ff-pointer self) arg1 arg2))

(cl:shadow "new[]")
(cl:defmethod #.(bullet-wrap::swig-lispify "new[]" 'method) ((self #.(bullet-wrap::swig-lispify "bt-bu-simplex1to4" 'classname)) sizeInBytes)
  (#.(bullet-wrap::swig-lispify "btBU_Simplex1to4_makeCPlusArray" 'function) (ff-pointer self) sizeInBytes))

(cl:shadow "delete[]")
(cl:defmethod #.(bullet-wrap::swig-lispify "delete[]" 'method) ((self #.(bullet-wrap::swig-lispify "bt-bu-simplex1to4" 'classname)) ptr)
  (#.(bullet-wrap::swig-lispify "btBU_Simplex1to4_deleteCPlusArray" 'function) (ff-pointer self) ptr))

(cl:shadow "new[]")
(cl:defmethod #.(bullet-wrap::swig-lispify "new[]" 'method) ((self #.(bullet-wrap::swig-lispify "bt-bu-simplex1to4" 'classname)) arg1 ptr)
  (#.(bullet-wrap::swig-lispify "btBU_Simplex1to4_makeCPlusArray" 'function) (ff-pointer self) arg1 ptr))

(cl:shadow "delete[]")
(cl:defmethod #.(bullet-wrap::swig-lispify "delete[]" 'method) ((self #.(bullet-wrap::swig-lispify "bt-bu-simplex1to4" 'classname)) arg1 arg2)
  (#.(bullet-wrap::swig-lispify "btBU_Simplex1to4_deleteCPlusArray" 'function) (ff-pointer self) arg1 arg2))

(cl:defmethod initialize-instance :after ((obj #.(bullet-wrap::swig-lispify "bt-bu-simplex1to4" 'class)) &key)
  (setf (slot-value obj 'ff-pointer) (#.(bullet-wrap::swig-lispify "new_btBU_Simplex1to4" 'function))))

(cl:defmethod initialize-instance :after ((obj #.(bullet-wrap::swig-lispify "bt-bu-simplex1to4" 'class)) &key (pt0 #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)))
  (setf (slot-value obj 'ff-pointer) (#.(bullet-wrap::swig-lispify "new_btBU_Simplex1to4" 'function) pt0)))

(cl:defmethod initialize-instance :after ((obj #.(bullet-wrap::swig-lispify "bt-bu-simplex1to4" 'class)) &key (pt0 #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (pt1 #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)))
  (setf (slot-value obj 'ff-pointer) (#.(bullet-wrap::swig-lispify "new_btBU_Simplex1to4" 'function) pt0 pt1)))

(cl:defmethod initialize-instance :after ((obj #.(bullet-wrap::swig-lispify "bt-bu-simplex1to4" 'class)) &key (pt0 #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (pt1 #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (pt2 #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)))
  (setf (slot-value obj 'ff-pointer) (#.(bullet-wrap::swig-lispify "new_btBU_Simplex1to4" 'function) pt0 pt1 pt2)))

(cl:defmethod initialize-instance :after ((obj #.(bullet-wrap::swig-lispify "bt-bu-simplex1to4" 'class)) &key (pt0 #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (pt1 #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (pt2 #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (pt3 #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)))
  (setf (slot-value obj 'ff-pointer) (#.(bullet-wrap::swig-lispify "new_btBU_Simplex1to4" 'function) pt0 pt1 pt2 pt3)))

(cl:defmethod #.(bullet-wrap::swig-lispify "reset" 'method) ((self #.(bullet-wrap::swig-lispify "bt-bu-simplex1to4" 'classname)))
  (#.(bullet-wrap::swig-lispify "btBU_Simplex1to4_reset" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-aabb" 'method) ((self #.(bullet-wrap::swig-lispify "bt-bu-simplex1to4" 'classname)) (t-arg1 #.(bullet-wrap::swig-lispify "bt-transform" 'classname)) (aabbMin #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (aabbMax #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)))
  (#.(bullet-wrap::swig-lispify "btBU_Simplex1to4_getAabb" 'function) (ff-pointer self) t-arg1 aabbMin aabbMax))

(cl:defmethod #.(bullet-wrap::swig-lispify "add-vertex" 'method) ((self #.(bullet-wrap::swig-lispify "bt-bu-simplex1to4" 'classname)) (pt #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)))
  (#.(bullet-wrap::swig-lispify "btBU_Simplex1to4_addVertex" 'function) (ff-pointer self) pt))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-num-vertices" 'method) ((self #.(bullet-wrap::swig-lispify "bt-bu-simplex1to4" 'classname)))
  (#.(bullet-wrap::swig-lispify "btBU_Simplex1to4_getNumVertices" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-num-edges" 'method) ((self #.(bullet-wrap::swig-lispify "bt-bu-simplex1to4" 'classname)))
  (#.(bullet-wrap::swig-lispify "btBU_Simplex1to4_getNumEdges" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-edge" 'method) ((self #.(bullet-wrap::swig-lispify "bt-bu-simplex1to4" 'classname)) (i cl:integer) (pa #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (pb #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)))
  (#.(bullet-wrap::swig-lispify "btBU_Simplex1to4_getEdge" 'function) (ff-pointer self) i pa pb))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-vertex" 'method) ((self #.(bullet-wrap::swig-lispify "bt-bu-simplex1to4" 'classname)) (i cl:integer) (vtx #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)))
  (#.(bullet-wrap::swig-lispify "btBU_Simplex1to4_getVertex" 'function) (ff-pointer self) i vtx))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-num-planes" 'method) ((self #.(bullet-wrap::swig-lispify "bt-bu-simplex1to4" 'classname)))
  (#.(bullet-wrap::swig-lispify "btBU_Simplex1to4_getNumPlanes" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-plane" 'method) ((self #.(bullet-wrap::swig-lispify "bt-bu-simplex1to4" 'classname)) (planeNormal #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (planeSupport #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (i cl:integer))
  (#.(bullet-wrap::swig-lispify "btBU_Simplex1to4_getPlane" 'function) (ff-pointer self) planeNormal planeSupport i))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-index" 'method) ((self #.(bullet-wrap::swig-lispify "bt-bu-simplex1to4" 'classname)) (i cl:integer))
  (#.(bullet-wrap::swig-lispify "btBU_Simplex1to4_getIndex" 'function) (ff-pointer self) i))

(cl:defmethod #.(bullet-wrap::swig-lispify "is-inside" 'method) ((self #.(bullet-wrap::swig-lispify "bt-bu-simplex1to4" 'classname)) (pt #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (tolerance cl:number))
  (#.(bullet-wrap::swig-lispify "btBU_Simplex1to4_isInside" 'function) (ff-pointer self) pt tolerance))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-name" 'method) ((self #.(bullet-wrap::swig-lispify "bt-bu-simplex1to4" 'classname)))
  (#.(bullet-wrap::swig-lispify "btBU_Simplex1to4_getName" 'function) (ff-pointer self)))


(cl:defclass #.(bullet-wrap::swig-lispify "bt-empty-shape" 'classname)()
  ((ff-pointer :reader ff-pointer)))

(cl:shadow "new")
(cl:defmethod #.(bullet-wrap::swig-lispify "new" 'method) ((self #.(bullet-wrap::swig-lispify "bt-empty-shape" 'classname)) sizeInBytes)
  (#.(bullet-wrap::swig-lispify "btEmptyShape_makeCPlusPlusInstance" 'function) (ff-pointer self) sizeInBytes))

(cl:shadow "delete")
(cl:defmethod #.(bullet-wrap::swig-lispify "delete" 'method) ((self #.(bullet-wrap::swig-lispify "bt-empty-shape" 'classname)) ptr)
  (#.(bullet-wrap::swig-lispify "btEmptyShape_deleteCPlusPlusInstance" 'function) (ff-pointer self) ptr))

(cl:shadow "new")
(cl:defmethod #.(bullet-wrap::swig-lispify "new" 'method) ((self #.(bullet-wrap::swig-lispify "bt-empty-shape" 'classname)) arg1 ptr)
  (#.(bullet-wrap::swig-lispify "btEmptyShape_makeCPlusPlusInstance" 'function) (ff-pointer self) arg1 ptr))

(cl:shadow "delete")
(cl:defmethod #.(bullet-wrap::swig-lispify "delete" 'method) ((self #.(bullet-wrap::swig-lispify "bt-empty-shape" 'classname)) arg1 arg2)
  (#.(bullet-wrap::swig-lispify "btEmptyShape_deleteCPlusPlusInstance" 'function) (ff-pointer self) arg1 arg2))

(cl:shadow "new[]")
(cl:defmethod #.(bullet-wrap::swig-lispify "new[]" 'method) ((self #.(bullet-wrap::swig-lispify "bt-empty-shape" 'classname)) sizeInBytes)
  (#.(bullet-wrap::swig-lispify "btEmptyShape_makeCPlusArray" 'function) (ff-pointer self) sizeInBytes))

(cl:shadow "delete[]")
(cl:defmethod #.(bullet-wrap::swig-lispify "delete[]" 'method) ((self #.(bullet-wrap::swig-lispify "bt-empty-shape" 'classname)) ptr)
  (#.(bullet-wrap::swig-lispify "btEmptyShape_deleteCPlusArray" 'function) (ff-pointer self) ptr))

(cl:shadow "new[]")
(cl:defmethod #.(bullet-wrap::swig-lispify "new[]" 'method) ((self #.(bullet-wrap::swig-lispify "bt-empty-shape" 'classname)) arg1 ptr)
  (#.(bullet-wrap::swig-lispify "btEmptyShape_makeCPlusArray" 'function) (ff-pointer self) arg1 ptr))

(cl:shadow "delete[]")
(cl:defmethod #.(bullet-wrap::swig-lispify "delete[]" 'method) ((self #.(bullet-wrap::swig-lispify "bt-empty-shape" 'classname)) arg1 arg2)
  (#.(bullet-wrap::swig-lispify "btEmptyShape_deleteCPlusArray" 'function) (ff-pointer self) arg1 arg2))

(cl:defmethod initialize-instance :after ((obj #.(bullet-wrap::swig-lispify "bt-empty-shape" 'class)) &key)
  (setf (slot-value obj 'ff-pointer) (#.(bullet-wrap::swig-lispify "new_btEmptyShape" 'function))))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-aabb" 'method) ((self #.(bullet-wrap::swig-lispify "bt-empty-shape" 'classname)) (t-arg1 #.(bullet-wrap::swig-lispify "bt-transform" 'classname)) (aabbMin #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (aabbMax #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)))
  (#.(bullet-wrap::swig-lispify "btEmptyShape_getAabb" 'function) (ff-pointer self) t-arg1 aabbMin aabbMax))

(cl:defmethod #.(bullet-wrap::swig-lispify "set-local-scaling" 'method) ((self #.(bullet-wrap::swig-lispify "bt-empty-shape" 'classname)) (scaling #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)))
  (#.(bullet-wrap::swig-lispify "btEmptyShape_setLocalScaling" 'function) (ff-pointer self) scaling))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-local-scaling" 'method) ((self #.(bullet-wrap::swig-lispify "bt-empty-shape" 'classname)))
  (#.(bullet-wrap::swig-lispify "btEmptyShape_getLocalScaling" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "calculate-local-inertia" 'method) ((self #.(bullet-wrap::swig-lispify "bt-empty-shape" 'classname)) (mass cl:number) (inertia #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)))
  (#.(bullet-wrap::swig-lispify "btEmptyShape_calculateLocalInertia" 'function) (ff-pointer self) mass inertia))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-name" 'method) ((self #.(bullet-wrap::swig-lispify "bt-empty-shape" 'classname)))
  (#.(bullet-wrap::swig-lispify "btEmptyShape_getName" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "process-all-triangles" 'method) ((self #.(bullet-wrap::swig-lispify "bt-empty-shape" 'classname)) arg1 (arg2 #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (arg3 #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)))
  (#.(bullet-wrap::swig-lispify "btEmptyShape_processAllTriangles" 'function) (ff-pointer self) arg1 arg2 arg3))


(cl:defclass #.(bullet-wrap::swig-lispify "bt-multi-sphere-shape" 'classname)()
  ((ff-pointer :reader ff-pointer)))

(cl:shadow "new")
(cl:defmethod #.(bullet-wrap::swig-lispify "new" 'method) ((self #.(bullet-wrap::swig-lispify "bt-multi-sphere-shape" 'classname)) sizeInBytes)
  (#.(bullet-wrap::swig-lispify "btMultiSphereShape_makeCPlusPlusInstance" 'function) (ff-pointer self) sizeInBytes))

(cl:shadow "delete")
(cl:defmethod #.(bullet-wrap::swig-lispify "delete" 'method) ((self #.(bullet-wrap::swig-lispify "bt-multi-sphere-shape" 'classname)) ptr)
  (#.(bullet-wrap::swig-lispify "btMultiSphereShape_deleteCPlusPlusInstance" 'function) (ff-pointer self) ptr))

(cl:shadow "new")
(cl:defmethod #.(bullet-wrap::swig-lispify "new" 'method) ((self #.(bullet-wrap::swig-lispify "bt-multi-sphere-shape" 'classname)) arg1 ptr)
  (#.(bullet-wrap::swig-lispify "btMultiSphereShape_makeCPlusPlusInstance" 'function) (ff-pointer self) arg1 ptr))

(cl:shadow "delete")
(cl:defmethod #.(bullet-wrap::swig-lispify "delete" 'method) ((self #.(bullet-wrap::swig-lispify "bt-multi-sphere-shape" 'classname)) arg1 arg2)
  (#.(bullet-wrap::swig-lispify "btMultiSphereShape_deleteCPlusPlusInstance" 'function) (ff-pointer self) arg1 arg2))

(cl:shadow "new[]")
(cl:defmethod #.(bullet-wrap::swig-lispify "new[]" 'method) ((self #.(bullet-wrap::swig-lispify "bt-multi-sphere-shape" 'classname)) sizeInBytes)
  (#.(bullet-wrap::swig-lispify "btMultiSphereShape_makeCPlusArray" 'function) (ff-pointer self) sizeInBytes))

(cl:shadow "delete[]")
(cl:defmethod #.(bullet-wrap::swig-lispify "delete[]" 'method) ((self #.(bullet-wrap::swig-lispify "bt-multi-sphere-shape" 'classname)) ptr)
  (#.(bullet-wrap::swig-lispify "btMultiSphereShape_deleteCPlusArray" 'function) (ff-pointer self) ptr))

(cl:shadow "new[]")
(cl:defmethod #.(bullet-wrap::swig-lispify "new[]" 'method) ((self #.(bullet-wrap::swig-lispify "bt-multi-sphere-shape" 'classname)) arg1 ptr)
  (#.(bullet-wrap::swig-lispify "btMultiSphereShape_makeCPlusArray" 'function) (ff-pointer self) arg1 ptr))

(cl:shadow "delete[]")
(cl:defmethod #.(bullet-wrap::swig-lispify "delete[]" 'method) ((self #.(bullet-wrap::swig-lispify "bt-multi-sphere-shape" 'classname)) arg1 arg2)
  (#.(bullet-wrap::swig-lispify "btMultiSphereShape_deleteCPlusArray" 'function) (ff-pointer self) arg1 arg2))

(cl:defmethod initialize-instance :after ((obj #.(bullet-wrap::swig-lispify "bt-multi-sphere-shape" 'class)) &key (positions #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) radi (numSpheres cl:integer))
  (setf (slot-value obj 'ff-pointer) (#.(bullet-wrap::swig-lispify "new_btMultiSphereShape" 'function) positions radi numSpheres)))

(cl:defmethod #.(bullet-wrap::swig-lispify "calculate-local-inertia" 'method) ((self #.(bullet-wrap::swig-lispify "bt-multi-sphere-shape" 'classname)) (mass cl:number) (inertia #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)))
  (#.(bullet-wrap::swig-lispify "btMultiSphereShape_calculateLocalInertia" 'function) (ff-pointer self) mass inertia))

(cl:defmethod #.(bullet-wrap::swig-lispify "local-get-supporting-vertex-without-margin" 'method) ((self #.(bullet-wrap::swig-lispify "bt-multi-sphere-shape" 'classname)) (vec #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)))
  (#.(bullet-wrap::swig-lispify "btMultiSphereShape_localGetSupportingVertexWithoutMargin" 'function) (ff-pointer self) vec))

(cl:defmethod #.(bullet-wrap::swig-lispify "batched-unit-vector-get-supporting-vertex-without-margin" 'method) ((self #.(bullet-wrap::swig-lispify "bt-multi-sphere-shape" 'classname)) (vectors #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (supportVerticesOut #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (numVectors cl:integer))
  (#.(bullet-wrap::swig-lispify "btMultiSphereShape_batchedUnitVectorGetSupportingVertexWithoutMargin" 'function) (ff-pointer self) vectors supportVerticesOut numVectors))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-sphere-count" 'method) ((self #.(bullet-wrap::swig-lispify "bt-multi-sphere-shape" 'classname)))
  (#.(bullet-wrap::swig-lispify "btMultiSphereShape_getSphereCount" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-sphere-position" 'method) ((self #.(bullet-wrap::swig-lispify "bt-multi-sphere-shape" 'classname)) (index cl:integer))
  (#.(bullet-wrap::swig-lispify "btMultiSphereShape_getSpherePosition" 'function) (ff-pointer self) index))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-sphere-radius" 'method) ((self #.(bullet-wrap::swig-lispify "bt-multi-sphere-shape" 'classname)) (index cl:integer))
  (#.(bullet-wrap::swig-lispify "btMultiSphereShape_getSphereRadius" 'function) (ff-pointer self) index))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-name" 'method) ((self #.(bullet-wrap::swig-lispify "bt-multi-sphere-shape" 'classname)))
  (#.(bullet-wrap::swig-lispify "btMultiSphereShape_getName" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "calculate-serialize-buffer-size" 'method) ((self #.(bullet-wrap::swig-lispify "bt-multi-sphere-shape" 'classname)))
  (#.(bullet-wrap::swig-lispify "btMultiSphereShape_calculateSerializeBufferSize" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "serialize" 'method) ((self #.(bullet-wrap::swig-lispify "bt-multi-sphere-shape" 'classname)) dataBuffer serializer)
  (#.(bullet-wrap::swig-lispify "btMultiSphereShape_serialize" 'function) (ff-pointer self) dataBuffer serializer))


(cl:defclass #.(bullet-wrap::swig-lispify "bt-uniform-scaling-shape" 'classname)()
  ((ff-pointer :reader ff-pointer)))

(cl:shadow "new")
(cl:defmethod #.(bullet-wrap::swig-lispify "new" 'method) ((self #.(bullet-wrap::swig-lispify "bt-uniform-scaling-shape" 'classname)) sizeInBytes)
  (#.(bullet-wrap::swig-lispify "btUniformScalingShape_makeCPlusPlusInstance" 'function) (ff-pointer self) sizeInBytes))

(cl:shadow "delete")
(cl:defmethod #.(bullet-wrap::swig-lispify "delete" 'method) ((self #.(bullet-wrap::swig-lispify "bt-uniform-scaling-shape" 'classname)) ptr)
  (#.(bullet-wrap::swig-lispify "btUniformScalingShape_deleteCPlusPlusInstance" 'function) (ff-pointer self) ptr))

(cl:shadow "new")
(cl:defmethod #.(bullet-wrap::swig-lispify "new" 'method) ((self #.(bullet-wrap::swig-lispify "bt-uniform-scaling-shape" 'classname)) arg1 ptr)
  (#.(bullet-wrap::swig-lispify "btUniformScalingShape_makeCPlusPlusInstance" 'function) (ff-pointer self) arg1 ptr))

(cl:shadow "delete")
(cl:defmethod #.(bullet-wrap::swig-lispify "delete" 'method) ((self #.(bullet-wrap::swig-lispify "bt-uniform-scaling-shape" 'classname)) arg1 arg2)
  (#.(bullet-wrap::swig-lispify "btUniformScalingShape_deleteCPlusPlusInstance" 'function) (ff-pointer self) arg1 arg2))

(cl:shadow "new[]")
(cl:defmethod #.(bullet-wrap::swig-lispify "new[]" 'method) ((self #.(bullet-wrap::swig-lispify "bt-uniform-scaling-shape" 'classname)) sizeInBytes)
  (#.(bullet-wrap::swig-lispify "btUniformScalingShape_makeCPlusArray" 'function) (ff-pointer self) sizeInBytes))

(cl:shadow "delete[]")
(cl:defmethod #.(bullet-wrap::swig-lispify "delete[]" 'method) ((self #.(bullet-wrap::swig-lispify "bt-uniform-scaling-shape" 'classname)) ptr)
  (#.(bullet-wrap::swig-lispify "btUniformScalingShape_deleteCPlusArray" 'function) (ff-pointer self) ptr))

(cl:shadow "new[]")
(cl:defmethod #.(bullet-wrap::swig-lispify "new[]" 'method) ((self #.(bullet-wrap::swig-lispify "bt-uniform-scaling-shape" 'classname)) arg1 ptr)
  (#.(bullet-wrap::swig-lispify "btUniformScalingShape_makeCPlusArray" 'function) (ff-pointer self) arg1 ptr))

(cl:shadow "delete[]")
(cl:defmethod #.(bullet-wrap::swig-lispify "delete[]" 'method) ((self #.(bullet-wrap::swig-lispify "bt-uniform-scaling-shape" 'classname)) arg1 arg2)
  (#.(bullet-wrap::swig-lispify "btUniformScalingShape_deleteCPlusArray" 'function) (ff-pointer self) arg1 arg2))

(cl:defmethod initialize-instance :after ((obj #.(bullet-wrap::swig-lispify "bt-uniform-scaling-shape" 'class)) &key convexChildShape (uniformScalingFactor cl:number))
  (setf (slot-value obj 'ff-pointer) (#.(bullet-wrap::swig-lispify "new_btUniformScalingShape" 'function) convexChildShape uniformScalingFactor)))

(cl:defmethod #.(bullet-wrap::swig-lispify "local-get-supporting-vertex-without-margin" 'method) ((self #.(bullet-wrap::swig-lispify "bt-uniform-scaling-shape" 'classname)) (vec #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)))
  (#.(bullet-wrap::swig-lispify "btUniformScalingShape_localGetSupportingVertexWithoutMargin" 'function) (ff-pointer self) vec))

(cl:defmethod #.(bullet-wrap::swig-lispify "local-get-supporting-vertex" 'method) ((self #.(bullet-wrap::swig-lispify "bt-uniform-scaling-shape" 'classname)) (vec #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)))
  (#.(bullet-wrap::swig-lispify "btUniformScalingShape_localGetSupportingVertex" 'function) (ff-pointer self) vec))

(cl:defmethod #.(bullet-wrap::swig-lispify "batched-unit-vector-get-supporting-vertex-without-margin" 'method) ((self #.(bullet-wrap::swig-lispify "bt-uniform-scaling-shape" 'classname)) (vectors #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (supportVerticesOut #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (numVectors cl:integer))
  (#.(bullet-wrap::swig-lispify "btUniformScalingShape_batchedUnitVectorGetSupportingVertexWithoutMargin" 'function) (ff-pointer self) vectors supportVerticesOut numVectors))

(cl:defmethod #.(bullet-wrap::swig-lispify "calculate-local-inertia" 'method) ((self #.(bullet-wrap::swig-lispify "bt-uniform-scaling-shape" 'classname)) (mass cl:number) (inertia #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)))
  (#.(bullet-wrap::swig-lispify "btUniformScalingShape_calculateLocalInertia" 'function) (ff-pointer self) mass inertia))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-uniform-scaling-factor" 'method) ((self #.(bullet-wrap::swig-lispify "bt-uniform-scaling-shape" 'classname)))
  (#.(bullet-wrap::swig-lispify "btUniformScalingShape_getUniformScalingFactor" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-child-shape" 'method) ((self #.(bullet-wrap::swig-lispify "bt-uniform-scaling-shape" 'classname)))
  (#.(bullet-wrap::swig-lispify "btUniformScalingShape_getChildShape" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-child-shape" 'method) ((self #.(bullet-wrap::swig-lispify "bt-uniform-scaling-shape" 'classname)))
  (#.(bullet-wrap::swig-lispify "btUniformScalingShape_getChildShape" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-name" 'method) ((self #.(bullet-wrap::swig-lispify "bt-uniform-scaling-shape" 'classname)))
  (#.(bullet-wrap::swig-lispify "btUniformScalingShape_getName" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-aabb" 'method) ((self #.(bullet-wrap::swig-lispify "bt-uniform-scaling-shape" 'classname)) (t-arg1 #.(bullet-wrap::swig-lispify "bt-transform" 'classname)) (aabbMin #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (aabbMax #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)))
  (#.(bullet-wrap::swig-lispify "btUniformScalingShape_getAabb" 'function) (ff-pointer self) t-arg1 aabbMin aabbMax))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-aabb-slow" 'method) ((self #.(bullet-wrap::swig-lispify "bt-uniform-scaling-shape" 'classname)) (t-arg1 #.(bullet-wrap::swig-lispify "bt-transform" 'classname)) (aabbMin #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (aabbMax #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)))
  (#.(bullet-wrap::swig-lispify "btUniformScalingShape_getAabbSlow" 'function) (ff-pointer self) t-arg1 aabbMin aabbMax))

(cl:defmethod #.(bullet-wrap::swig-lispify "set-local-scaling" 'method) ((self #.(bullet-wrap::swig-lispify "bt-uniform-scaling-shape" 'classname)) (scaling #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)))
  (#.(bullet-wrap::swig-lispify "btUniformScalingShape_setLocalScaling" 'function) (ff-pointer self) scaling))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-local-scaling" 'method) ((self #.(bullet-wrap::swig-lispify "bt-uniform-scaling-shape" 'classname)))
  (#.(bullet-wrap::swig-lispify "btUniformScalingShape_getLocalScaling" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "set-margin" 'method) ((self #.(bullet-wrap::swig-lispify "bt-uniform-scaling-shape" 'classname)) (margin cl:number))
  (#.(bullet-wrap::swig-lispify "btUniformScalingShape_setMargin" 'function) (ff-pointer self) margin))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-margin" 'method) ((self #.(bullet-wrap::swig-lispify "bt-uniform-scaling-shape" 'classname)))
  (#.(bullet-wrap::swig-lispify "btUniformScalingShape_getMargin" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-num-preferred-penetration-directions" 'method) ((self #.(bullet-wrap::swig-lispify "bt-uniform-scaling-shape" 'classname)))
  (#.(bullet-wrap::swig-lispify "btUniformScalingShape_getNumPreferredPenetrationDirections" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-preferred-penetration-direction" 'method) ((self #.(bullet-wrap::swig-lispify "bt-uniform-scaling-shape" 'classname)) (index cl:integer) (penetrationVector #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)))
  (#.(bullet-wrap::swig-lispify "btUniformScalingShape_getPreferredPenetrationDirection" 'function) (ff-pointer self) index penetrationVector))


(cl:defclass #.(bullet-wrap::swig-lispify "bt-sphere-sphere-collision-algorithm" 'classname)()
  ((ff-pointer :reader ff-pointer)))

(cl:defmethod initialize-instance :after ((obj #.(bullet-wrap::swig-lispify "bt-sphere-sphere-collision-algorithm" 'class)) &key mf ci col0Wrap col1Wrap)
  (setf (slot-value obj 'ff-pointer) (#.(bullet-wrap::swig-lispify "new_btSphereSphereCollisionAlgorithm" 'function) mf ci col0Wrap col1Wrap)))

(cl:defmethod initialize-instance :after ((obj #.(bullet-wrap::swig-lispify "bt-sphere-sphere-collision-algorithm" 'class)) &key ci)
  (setf (slot-value obj 'ff-pointer) (#.(bullet-wrap::swig-lispify "new_btSphereSphereCollisionAlgorithm" 'function) ci)))

(cl:defmethod #.(bullet-wrap::swig-lispify "process-collision" 'method) ((self #.(bullet-wrap::swig-lispify "bt-sphere-sphere-collision-algorithm" 'classname)) body0Wrap body1Wrap dispatchInfo resultOut)
  (#.(bullet-wrap::swig-lispify "btSphereSphereCollisionAlgorithm_processCollision" 'function) (ff-pointer self) body0Wrap body1Wrap dispatchInfo resultOut))

(cl:defmethod #.(bullet-wrap::swig-lispify "calculate-time-of-impact" 'method) ((self #.(bullet-wrap::swig-lispify "bt-sphere-sphere-collision-algorithm" 'classname)) (body0 #.(bullet-wrap::swig-lispify "bt-collision-object" 'classname)) (body1 #.(bullet-wrap::swig-lispify "bt-collision-object" 'classname)) dispatchInfo resultOut)
  (#.(bullet-wrap::swig-lispify "btSphereSphereCollisionAlgorithm_calculateTimeOfImpact" 'function) (ff-pointer self) body0 body1 dispatchInfo resultOut))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-all-contact-manifolds" 'method) ((self #.(bullet-wrap::swig-lispify "bt-sphere-sphere-collision-algorithm" 'classname)) manifoldArray)
  (#.(bullet-wrap::swig-lispify "btSphereSphereCollisionAlgorithm_getAllContactManifolds" 'function) (ff-pointer self) manifoldArray))


(cl:defclass #.(bullet-wrap::swig-lispify "bt-default-collision-configuration" 'classname)()
  ((ff-pointer :reader ff-pointer)))

(cl:defmethod initialize-instance :after ((obj #.(bullet-wrap::swig-lispify "bt-default-collision-configuration" 'class)) &key constructionInfo)
  (setf (slot-value obj 'ff-pointer) (#.(bullet-wrap::swig-lispify "new_btDefaultCollisionConfiguration" 'function) constructionInfo)))

(cl:defmethod initialize-instance :after ((obj #.(bullet-wrap::swig-lispify "bt-default-collision-configuration" 'class)) &key)
  (setf (slot-value obj 'ff-pointer) (#.(bullet-wrap::swig-lispify "new_btDefaultCollisionConfiguration" 'function))))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-persistent-manifold-pool" 'method) ((self #.(bullet-wrap::swig-lispify "bt-default-collision-configuration" 'classname)))
  (#.(bullet-wrap::swig-lispify "btDefaultCollisionConfiguration_getPersistentManifoldPool" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-collision-algorithm-pool" 'method) ((self #.(bullet-wrap::swig-lispify "bt-default-collision-configuration" 'classname)))
  (#.(bullet-wrap::swig-lispify "btDefaultCollisionConfiguration_getCollisionAlgorithmPool" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-simplex-solver" 'method) ((self #.(bullet-wrap::swig-lispify "bt-default-collision-configuration" 'classname)))
  (#.(bullet-wrap::swig-lispify "btDefaultCollisionConfiguration_getSimplexSolver" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-collision-algorithm-create-func" 'method) ((self #.(bullet-wrap::swig-lispify "bt-default-collision-configuration" 'classname)) (proxyType0 cl:integer) (proxyType1 cl:integer))
  (#.(bullet-wrap::swig-lispify "btDefaultCollisionConfiguration_getCollisionAlgorithmCreateFunc" 'function) (ff-pointer self) proxyType0 proxyType1))

(cl:defmethod #.(bullet-wrap::swig-lispify "set-convex-convex-multipoint-iterations" 'method) ((self #.(bullet-wrap::swig-lispify "bt-default-collision-configuration" 'classname)) (numPerturbationIterations cl:integer) (minimumPointsPerturbationThreshold cl:integer))
  (#.(bullet-wrap::swig-lispify "btDefaultCollisionConfiguration_setConvexConvexMultipointIterations" 'function) (ff-pointer self) numPerturbationIterations minimumPointsPerturbationThreshold))

(cl:defmethod #.(bullet-wrap::swig-lispify "set-convex-convex-multipoint-iterations" 'method) ((self #.(bullet-wrap::swig-lispify "bt-default-collision-configuration" 'classname)) (numPerturbationIterations cl:integer))
  (#.(bullet-wrap::swig-lispify "btDefaultCollisionConfiguration_setConvexConvexMultipointIterations" 'function) (ff-pointer self) numPerturbationIterations))

(cl:defmethod #.(bullet-wrap::swig-lispify "set-convex-convex-multipoint-iterations" 'method) ((self #.(bullet-wrap::swig-lispify "bt-default-collision-configuration" 'classname)))
  (#.(bullet-wrap::swig-lispify "btDefaultCollisionConfiguration_setConvexConvexMultipointIterations" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "set-plane-convex-multipoint-iterations" 'method) ((self #.(bullet-wrap::swig-lispify "bt-default-collision-configuration" 'classname)) (numPerturbationIterations cl:integer) (minimumPointsPerturbationThreshold cl:integer))
  (#.(bullet-wrap::swig-lispify "btDefaultCollisionConfiguration_setPlaneConvexMultipointIterations" 'function) (ff-pointer self) numPerturbationIterations minimumPointsPerturbationThreshold))

(cl:defmethod #.(bullet-wrap::swig-lispify "set-plane-convex-multipoint-iterations" 'method) ((self #.(bullet-wrap::swig-lispify "bt-default-collision-configuration" 'classname)) (numPerturbationIterations cl:integer))
  (#.(bullet-wrap::swig-lispify "btDefaultCollisionConfiguration_setPlaneConvexMultipointIterations" 'function) (ff-pointer self) numPerturbationIterations))

(cl:defmethod #.(bullet-wrap::swig-lispify "set-plane-convex-multipoint-iterations" 'method) ((self #.(bullet-wrap::swig-lispify "bt-default-collision-configuration" 'classname)))
  (#.(bullet-wrap::swig-lispify "btDefaultCollisionConfiguration_setPlaneConvexMultipointIterations" 'function) (ff-pointer self)))


(cl:defclass #.(bullet-wrap::swig-lispify "bt-collision-dispatcher" 'classname)()
  ((ff-pointer :reader ff-pointer)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-dispatcher-flags" 'method) ((self #.(bullet-wrap::swig-lispify "bt-collision-dispatcher" 'classname)))
  (#.(bullet-wrap::swig-lispify "btCollisionDispatcher_getDispatcherFlags" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "set-dispatcher-flags" 'method) ((self #.(bullet-wrap::swig-lispify "bt-collision-dispatcher" 'classname)) (flags cl:integer))
  (#.(bullet-wrap::swig-lispify "btCollisionDispatcher_setDispatcherFlags" 'function) (ff-pointer self) flags))

(cl:defmethod #.(bullet-wrap::swig-lispify "register-collision-create-func" 'method) ((self #.(bullet-wrap::swig-lispify "bt-collision-dispatcher" 'classname)) (proxyType0 cl:integer) (proxyType1 cl:integer) createFunc)
  (#.(bullet-wrap::swig-lispify "btCollisionDispatcher_registerCollisionCreateFunc" 'function) (ff-pointer self) proxyType0 proxyType1 createFunc))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-num-manifolds" 'method) ((self #.(bullet-wrap::swig-lispify "bt-collision-dispatcher" 'classname)))
  (#.(bullet-wrap::swig-lispify "btCollisionDispatcher_getNumManifolds" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-internal-manifold-pointer" 'method) ((self #.(bullet-wrap::swig-lispify "bt-collision-dispatcher" 'classname)))
  (#.(bullet-wrap::swig-lispify "btCollisionDispatcher_getInternalManifoldPointer" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-manifold-by-index-internal" 'method) ((self #.(bullet-wrap::swig-lispify "bt-collision-dispatcher" 'classname)) (index cl:integer))
  (#.(bullet-wrap::swig-lispify "btCollisionDispatcher_getManifoldByIndexInternal" 'function) (ff-pointer self) index))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-manifold-by-index-internal" 'method) ((self #.(bullet-wrap::swig-lispify "bt-collision-dispatcher" 'classname)) (index cl:integer))
  (#.(bullet-wrap::swig-lispify "btCollisionDispatcher_getManifoldByIndexInternal" 'function) (ff-pointer self) index))

(cl:defmethod initialize-instance :after ((obj #.(bullet-wrap::swig-lispify "bt-collision-dispatcher" 'class)) &key collisionConfiguration)
  (setf (slot-value obj 'ff-pointer) (#.(bullet-wrap::swig-lispify "new_btCollisionDispatcher" 'function) collisionConfiguration)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-new-manifold" 'method) ((self #.(bullet-wrap::swig-lispify "bt-collision-dispatcher" 'classname)) (b0 #.(bullet-wrap::swig-lispify "bt-collision-object" 'classname)) (b1 #.(bullet-wrap::swig-lispify "bt-collision-object" 'classname)))
  (#.(bullet-wrap::swig-lispify "btCollisionDispatcher_getNewManifold" 'function) (ff-pointer self) b0 b1))

(cl:defmethod #.(bullet-wrap::swig-lispify "release-manifold" 'method) ((self #.(bullet-wrap::swig-lispify "bt-collision-dispatcher" 'classname)) manifold)
  (#.(bullet-wrap::swig-lispify "btCollisionDispatcher_releaseManifold" 'function) (ff-pointer self) manifold))

(cl:defmethod #.(bullet-wrap::swig-lispify "clear-manifold" 'method) ((self #.(bullet-wrap::swig-lispify "bt-collision-dispatcher" 'classname)) manifold)
  (#.(bullet-wrap::swig-lispify "btCollisionDispatcher_clearManifold" 'function) (ff-pointer self) manifold))

(cl:defmethod #.(bullet-wrap::swig-lispify "find-algorithm" 'method) ((self #.(bullet-wrap::swig-lispify "bt-collision-dispatcher" 'classname)) body0Wrap body1Wrap sharedManifold)
  (#.(bullet-wrap::swig-lispify "btCollisionDispatcher_findAlgorithm" 'function) (ff-pointer self) body0Wrap body1Wrap sharedManifold))

(cl:defmethod #.(bullet-wrap::swig-lispify "find-algorithm" 'method) ((self #.(bullet-wrap::swig-lispify "bt-collision-dispatcher" 'classname)) body0Wrap body1Wrap)
  (#.(bullet-wrap::swig-lispify "btCollisionDispatcher_findAlgorithm" 'function) (ff-pointer self) body0Wrap body1Wrap))

(cl:defmethod #.(bullet-wrap::swig-lispify "needs-collision" 'method) ((self #.(bullet-wrap::swig-lispify "bt-collision-dispatcher" 'classname)) (body0 #.(bullet-wrap::swig-lispify "bt-collision-object" 'classname)) (body1 #.(bullet-wrap::swig-lispify "bt-collision-object" 'classname)))
  (#.(bullet-wrap::swig-lispify "btCollisionDispatcher_needsCollision" 'function) (ff-pointer self) body0 body1))

(cl:defmethod #.(bullet-wrap::swig-lispify "needs-response" 'method) ((self #.(bullet-wrap::swig-lispify "bt-collision-dispatcher" 'classname)) (body0 #.(bullet-wrap::swig-lispify "bt-collision-object" 'classname)) (body1 #.(bullet-wrap::swig-lispify "bt-collision-object" 'classname)))
  (#.(bullet-wrap::swig-lispify "btCollisionDispatcher_needsResponse" 'function) (ff-pointer self) body0 body1))

(cl:defmethod #.(bullet-wrap::swig-lispify "dispatch-all-collision-pairs" 'method) ((self #.(bullet-wrap::swig-lispify "bt-collision-dispatcher" 'classname)) pairCache dispatchInfo dispatcher)
  (#.(bullet-wrap::swig-lispify "btCollisionDispatcher_dispatchAllCollisionPairs" 'function) (ff-pointer self) pairCache dispatchInfo dispatcher))

(cl:defmethod #.(bullet-wrap::swig-lispify "set-near-callback" 'method) ((self #.(bullet-wrap::swig-lispify "bt-collision-dispatcher" 'classname)) nearCallback)
  (#.(bullet-wrap::swig-lispify "btCollisionDispatcher_setNearCallback" 'function) (ff-pointer self) nearCallback))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-near-callback" 'method) ((self #.(bullet-wrap::swig-lispify "bt-collision-dispatcher" 'classname)))
  (#.(bullet-wrap::swig-lispify "btCollisionDispatcher_getNearCallback" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "allocate-collision-algorithm" 'method) ((self #.(bullet-wrap::swig-lispify "bt-collision-dispatcher" 'classname)) (size cl:integer))
  (#.(bullet-wrap::swig-lispify "btCollisionDispatcher_allocateCollisionAlgorithm" 'function) (ff-pointer self) size))

(cl:defmethod #.(bullet-wrap::swig-lispify "free-collision-algorithm" 'method) ((self #.(bullet-wrap::swig-lispify "bt-collision-dispatcher" 'classname)) ptr)
  (#.(bullet-wrap::swig-lispify "btCollisionDispatcher_freeCollisionAlgorithm" 'function) (ff-pointer self) ptr))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-collision-configuration" 'method) ((self #.(bullet-wrap::swig-lispify "bt-collision-dispatcher" 'classname)))
  (#.(bullet-wrap::swig-lispify "btCollisionDispatcher_getCollisionConfiguration" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-collision-configuration" 'method) ((self #.(bullet-wrap::swig-lispify "bt-collision-dispatcher" 'classname)))
  (#.(bullet-wrap::swig-lispify "btCollisionDispatcher_getCollisionConfiguration" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "set-collision-configuration" 'method) ((self #.(bullet-wrap::swig-lispify "bt-collision-dispatcher" 'classname)) config)
  (#.(bullet-wrap::swig-lispify "btCollisionDispatcher_setCollisionConfiguration" 'function) (ff-pointer self) config))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-internal-manifold-pool" 'method) ((self #.(bullet-wrap::swig-lispify "bt-collision-dispatcher" 'classname)))
  (#.(bullet-wrap::swig-lispify "btCollisionDispatcher_getInternalManifoldPool" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-internal-manifold-pool" 'method) ((self #.(bullet-wrap::swig-lispify "bt-collision-dispatcher" 'classname)))
  (#.(bullet-wrap::swig-lispify "btCollisionDispatcher_getInternalManifoldPool" 'function) (ff-pointer self)))


(cl:defclass #.(bullet-wrap::swig-lispify "bt-simple-broadphase" 'classname)()
  ((ff-pointer :reader ff-pointer)))

(cl:defmethod initialize-instance :after ((obj #.(bullet-wrap::swig-lispify "bt-simple-broadphase" 'class)) &key (maxProxies cl:integer) overlappingPairCache)
  (setf (slot-value obj 'ff-pointer) (#.(bullet-wrap::swig-lispify "new_btSimpleBroadphase" 'function) maxProxies overlappingPairCache)))

(cl:defmethod initialize-instance :after ((obj #.(bullet-wrap::swig-lispify "bt-simple-broadphase" 'class)) &key (maxProxies cl:integer))
  (setf (slot-value obj 'ff-pointer) (#.(bullet-wrap::swig-lispify "new_btSimpleBroadphase" 'function) maxProxies)))

(cl:defmethod initialize-instance :after ((obj #.(bullet-wrap::swig-lispify "bt-simple-broadphase" 'class)) &key)
  (setf (slot-value obj 'ff-pointer) (#.(bullet-wrap::swig-lispify "new_btSimpleBroadphase" 'function))))

(cl:defmethod #.(bullet-wrap::swig-lispify "create-proxy" 'method) ((self #.(bullet-wrap::swig-lispify "bt-simple-broadphase" 'classname)) (aabbMin #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (aabbMax #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (shapeType cl:integer) userPtr (collisionFilterGroup cl:integer) (collisionFilterMask cl:integer) dispatcher multiSapProxy)
  (#.(bullet-wrap::swig-lispify "btSimpleBroadphase_createProxy" 'function) (ff-pointer self) aabbMin aabbMax shapeType userPtr collisionFilterGroup collisionFilterMask dispatcher multiSapProxy))

(cl:defmethod #.(bullet-wrap::swig-lispify "calculate-overlapping-pairs" 'method) ((self #.(bullet-wrap::swig-lispify "bt-simple-broadphase" 'classname)) dispatcher)
  (#.(bullet-wrap::swig-lispify "btSimpleBroadphase_calculateOverlappingPairs" 'function) (ff-pointer self) dispatcher))

(cl:defmethod #.(bullet-wrap::swig-lispify "destroy-proxy" 'method) ((self #.(bullet-wrap::swig-lispify "bt-simple-broadphase" 'classname)) proxy dispatcher)
  (#.(bullet-wrap::swig-lispify "btSimpleBroadphase_destroyProxy" 'function) (ff-pointer self) proxy dispatcher))

(cl:defmethod #.(bullet-wrap::swig-lispify "set-aabb" 'method) ((self #.(bullet-wrap::swig-lispify "bt-simple-broadphase" 'classname)) proxy (aabbMin #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (aabbMax #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) dispatcher)
  (#.(bullet-wrap::swig-lispify "btSimpleBroadphase_setAabb" 'function) (ff-pointer self) proxy aabbMin aabbMax dispatcher))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-aabb" 'method) ((self #.(bullet-wrap::swig-lispify "bt-simple-broadphase" 'classname)) proxy (aabbMin #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (aabbMax #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)))
  (#.(bullet-wrap::swig-lispify "btSimpleBroadphase_getAabb" 'function) (ff-pointer self) proxy aabbMin aabbMax))

(cl:defmethod #.(bullet-wrap::swig-lispify "ray-test" 'method) ((self #.(bullet-wrap::swig-lispify "bt-simple-broadphase" 'classname)) (rayFrom #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (rayTo #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) rayCallback (aabbMin #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (aabbMax #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)))
  (#.(bullet-wrap::swig-lispify "btSimpleBroadphase_rayTest" 'function) (ff-pointer self) rayFrom rayTo rayCallback aabbMin aabbMax))

(cl:defmethod #.(bullet-wrap::swig-lispify "ray-test" 'method) ((self #.(bullet-wrap::swig-lispify "bt-simple-broadphase" 'classname)) (rayFrom #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (rayTo #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) rayCallback (aabbMin #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)))
  (#.(bullet-wrap::swig-lispify "btSimpleBroadphase_rayTest" 'function) (ff-pointer self) rayFrom rayTo rayCallback aabbMin))

(cl:defmethod #.(bullet-wrap::swig-lispify "ray-test" 'method) ((self #.(bullet-wrap::swig-lispify "bt-simple-broadphase" 'classname)) (rayFrom #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (rayTo #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) rayCallback)
  (#.(bullet-wrap::swig-lispify "btSimpleBroadphase_rayTest" 'function) (ff-pointer self) rayFrom rayTo rayCallback))

(cl:defmethod #.(bullet-wrap::swig-lispify "aabb-test" 'method) ((self #.(bullet-wrap::swig-lispify "bt-simple-broadphase" 'classname)) (aabbMin #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (aabbMax #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) callback)
  (#.(bullet-wrap::swig-lispify "btSimpleBroadphase_aabbTest" 'function) (ff-pointer self) aabbMin aabbMax callback))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-overlapping-pair-cache" 'method) ((self #.(bullet-wrap::swig-lispify "bt-simple-broadphase" 'classname)))
  (#.(bullet-wrap::swig-lispify "btSimpleBroadphase_getOverlappingPairCache" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-overlapping-pair-cache" 'method) ((self #.(bullet-wrap::swig-lispify "bt-simple-broadphase" 'classname)))
  (#.(bullet-wrap::swig-lispify "btSimpleBroadphase_getOverlappingPairCache" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "test-aabb-overlap" 'method) ((self #.(bullet-wrap::swig-lispify "bt-simple-broadphase" 'classname)) proxy0 proxy1)
  (#.(bullet-wrap::swig-lispify "btSimpleBroadphase_testAabbOverlap" 'function) (ff-pointer self) proxy0 proxy1))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-broadphase-aabb" 'method) ((self #.(bullet-wrap::swig-lispify "bt-simple-broadphase" 'classname)) (aabbMin #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (aabbMax #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)))
  (#.(bullet-wrap::swig-lispify "btSimpleBroadphase_getBroadphaseAabb" 'function) (ff-pointer self) aabbMin aabbMax))

(cl:defmethod #.(bullet-wrap::swig-lispify "print-stats" 'method) ((self #.(bullet-wrap::swig-lispify "bt-simple-broadphase" 'classname)))
  (#.(bullet-wrap::swig-lispify "btSimpleBroadphase_printStats" 'function) (ff-pointer self)))


(cl:defclass #.(bullet-wrap::swig-lispify "bt-axis-sweep3" 'classname)()
  ((ff-pointer :reader ff-pointer)))

(cl:defmethod initialize-instance :after ((obj #.(bullet-wrap::swig-lispify "bt-axis-sweep3" 'class)) &key (worldAabbMin #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (worldAabbMax #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (maxHandles cl:integer) pairCache (disableRaycastAccelerator t))
  (setf (slot-value obj 'ff-pointer) (#.(bullet-wrap::swig-lispify "new_btAxisSweep3" 'function) worldAabbMin worldAabbMax maxHandles pairCache disableRaycastAccelerator)))

(cl:defmethod initialize-instance :after ((obj #.(bullet-wrap::swig-lispify "bt-axis-sweep3" 'class)) &key (worldAabbMin #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (worldAabbMax #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (maxHandles cl:integer) pairCache)
  (setf (slot-value obj 'ff-pointer) (#.(bullet-wrap::swig-lispify "new_btAxisSweep3" 'function) worldAabbMin worldAabbMax maxHandles pairCache)))

(cl:defmethod initialize-instance :after ((obj #.(bullet-wrap::swig-lispify "bt-axis-sweep3" 'class)) &key (worldAabbMin #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (worldAabbMax #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (maxHandles cl:integer))
  (setf (slot-value obj 'ff-pointer) (#.(bullet-wrap::swig-lispify "new_btAxisSweep3" 'function) worldAabbMin worldAabbMax maxHandles)))

(cl:defmethod initialize-instance :after ((obj #.(bullet-wrap::swig-lispify "bt-axis-sweep3" 'class)) &key (worldAabbMin #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (worldAabbMax #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)))
  (setf (slot-value obj 'ff-pointer) (#.(bullet-wrap::swig-lispify "new_btAxisSweep3" 'function) worldAabbMin worldAabbMax)))


(cl:defclass #.(bullet-wrap::swig-lispify "bt32-bit-axis-sweep3" 'classname)()
  ((ff-pointer :reader ff-pointer)))

(cl:defmethod initialize-instance :after ((obj #.(bullet-wrap::swig-lispify "bt32-bit-axis-sweep3" 'class)) &key (worldAabbMin #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (worldAabbMax #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (maxHandles cl:integer) pairCache (disableRaycastAccelerator t))
  (setf (slot-value obj 'ff-pointer) (#.(bullet-wrap::swig-lispify "new_bt32BitAxisSweep3" 'function) worldAabbMin worldAabbMax maxHandles pairCache disableRaycastAccelerator)))

(cl:defmethod initialize-instance :after ((obj #.(bullet-wrap::swig-lispify "bt32-bit-axis-sweep3" 'class)) &key (worldAabbMin #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (worldAabbMax #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (maxHandles cl:integer) pairCache)
  (setf (slot-value obj 'ff-pointer) (#.(bullet-wrap::swig-lispify "new_bt32BitAxisSweep3" 'function) worldAabbMin worldAabbMax maxHandles pairCache)))

(cl:defmethod initialize-instance :after ((obj #.(bullet-wrap::swig-lispify "bt32-bit-axis-sweep3" 'class)) &key (worldAabbMin #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (worldAabbMax #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (maxHandles cl:integer))
  (setf (slot-value obj 'ff-pointer) (#.(bullet-wrap::swig-lispify "new_bt32BitAxisSweep3" 'function) worldAabbMin worldAabbMax maxHandles)))

(cl:defmethod initialize-instance :after ((obj #.(bullet-wrap::swig-lispify "bt32-bit-axis-sweep3" 'class)) &key (worldAabbMin #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (worldAabbMax #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)))
  (setf (slot-value obj 'ff-pointer) (#.(bullet-wrap::swig-lispify "new_bt32BitAxisSweep3" 'function) worldAabbMin worldAabbMax)))


(cl:defclass #.(bullet-wrap::swig-lispify "bt-multi-sap-broadphase" 'classname)()
  ((ff-pointer :reader ff-pointer)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-broadphase-array" 'method) ((self #.(bullet-wrap::swig-lispify "bt-multi-sap-broadphase" 'classname)))
  (#.(bullet-wrap::swig-lispify "btMultiSapBroadphase_getBroadphaseArray" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-broadphase-array" 'method) ((self #.(bullet-wrap::swig-lispify "bt-multi-sap-broadphase" 'classname)))
  (#.(bullet-wrap::swig-lispify "btMultiSapBroadphase_getBroadphaseArray" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "create-proxy" 'method) ((self #.(bullet-wrap::swig-lispify "bt-multi-sap-broadphase" 'classname)) (aabbMin #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (aabbMax #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (shapeType cl:integer) userPtr (collisionFilterGroup cl:integer) (collisionFilterMask cl:integer) dispatcher multiSapProxy)
  (#.(bullet-wrap::swig-lispify "btMultiSapBroadphase_createProxy" 'function) (ff-pointer self) aabbMin aabbMax shapeType userPtr collisionFilterGroup collisionFilterMask dispatcher multiSapProxy))

(cl:defmethod #.(bullet-wrap::swig-lispify "destroy-proxy" 'method) ((self #.(bullet-wrap::swig-lispify "bt-multi-sap-broadphase" 'classname)) proxy dispatcher)
  (#.(bullet-wrap::swig-lispify "btMultiSapBroadphase_destroyProxy" 'function) (ff-pointer self) proxy dispatcher))

(cl:defmethod #.(bullet-wrap::swig-lispify "set-aabb" 'method) ((self #.(bullet-wrap::swig-lispify "bt-multi-sap-broadphase" 'classname)) proxy (aabbMin #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (aabbMax #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) dispatcher)
  (#.(bullet-wrap::swig-lispify "btMultiSapBroadphase_setAabb" 'function) (ff-pointer self) proxy aabbMin aabbMax dispatcher))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-aabb" 'method) ((self #.(bullet-wrap::swig-lispify "bt-multi-sap-broadphase" 'classname)) proxy (aabbMin #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (aabbMax #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)))
  (#.(bullet-wrap::swig-lispify "btMultiSapBroadphase_getAabb" 'function) (ff-pointer self) proxy aabbMin aabbMax))

(cl:defmethod #.(bullet-wrap::swig-lispify "ray-test" 'method) ((self #.(bullet-wrap::swig-lispify "bt-multi-sap-broadphase" 'classname)) (rayFrom #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (rayTo #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) rayCallback (aabbMin #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (aabbMax #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)))
  (#.(bullet-wrap::swig-lispify "btMultiSapBroadphase_rayTest" 'function) (ff-pointer self) rayFrom rayTo rayCallback aabbMin aabbMax))

(cl:defmethod #.(bullet-wrap::swig-lispify "ray-test" 'method) ((self #.(bullet-wrap::swig-lispify "bt-multi-sap-broadphase" 'classname)) (rayFrom #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (rayTo #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) rayCallback (aabbMin #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)))
  (#.(bullet-wrap::swig-lispify "btMultiSapBroadphase_rayTest" 'function) (ff-pointer self) rayFrom rayTo rayCallback aabbMin))

(cl:defmethod #.(bullet-wrap::swig-lispify "ray-test" 'method) ((self #.(bullet-wrap::swig-lispify "bt-multi-sap-broadphase" 'classname)) (rayFrom #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (rayTo #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) rayCallback)
  (#.(bullet-wrap::swig-lispify "btMultiSapBroadphase_rayTest" 'function) (ff-pointer self) rayFrom rayTo rayCallback))

(cl:defmethod #.(bullet-wrap::swig-lispify "add-to-child-broadphase" 'method) ((self #.(bullet-wrap::swig-lispify "bt-multi-sap-broadphase" 'classname)) parentMultiSapProxy childProxy childBroadphase)
  (#.(bullet-wrap::swig-lispify "btMultiSapBroadphase_addToChildBroadphase" 'function) (ff-pointer self) parentMultiSapProxy childProxy childBroadphase))

(cl:defmethod #.(bullet-wrap::swig-lispify "calculate-overlapping-pairs" 'method) ((self #.(bullet-wrap::swig-lispify "bt-multi-sap-broadphase" 'classname)) dispatcher)
  (#.(bullet-wrap::swig-lispify "btMultiSapBroadphase_calculateOverlappingPairs" 'function) (ff-pointer self) dispatcher))

(cl:defmethod #.(bullet-wrap::swig-lispify "test-aabb-overlap" 'method) ((self #.(bullet-wrap::swig-lispify "bt-multi-sap-broadphase" 'classname)) proxy0 proxy1)
  (#.(bullet-wrap::swig-lispify "btMultiSapBroadphase_testAabbOverlap" 'function) (ff-pointer self) proxy0 proxy1))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-overlapping-pair-cache" 'method) ((self #.(bullet-wrap::swig-lispify "bt-multi-sap-broadphase" 'classname)))
  (#.(bullet-wrap::swig-lispify "btMultiSapBroadphase_getOverlappingPairCache" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-overlapping-pair-cache" 'method) ((self #.(bullet-wrap::swig-lispify "bt-multi-sap-broadphase" 'classname)))
  (#.(bullet-wrap::swig-lispify "btMultiSapBroadphase_getOverlappingPairCache" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-broadphase-aabb" 'method) ((self #.(bullet-wrap::swig-lispify "bt-multi-sap-broadphase" 'classname)) (aabbMin #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (aabbMax #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)))
  (#.(bullet-wrap::swig-lispify "btMultiSapBroadphase_getBroadphaseAabb" 'function) (ff-pointer self) aabbMin aabbMax))

(cl:defmethod #.(bullet-wrap::swig-lispify "build-tree" 'method) ((self #.(bullet-wrap::swig-lispify "bt-multi-sap-broadphase" 'classname)) (bvhAabbMin #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (bvhAabbMax #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)))
  (#.(bullet-wrap::swig-lispify "btMultiSapBroadphase_buildTree" 'function) (ff-pointer self) bvhAabbMin bvhAabbMax))

(cl:defmethod #.(bullet-wrap::swig-lispify "print-stats" 'method) ((self #.(bullet-wrap::swig-lispify "bt-multi-sap-broadphase" 'classname)))
  (#.(bullet-wrap::swig-lispify "btMultiSapBroadphase_printStats" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "quicksort" 'method) ((self #.(bullet-wrap::swig-lispify "bt-multi-sap-broadphase" 'classname)) a (lo cl:integer) (hi cl:integer))
  (#.(bullet-wrap::swig-lispify "btMultiSapBroadphase_quicksort" 'function) (ff-pointer self) a lo hi))

(cl:defmethod #.(bullet-wrap::swig-lispify "reset-pool" 'method) ((self #.(bullet-wrap::swig-lispify "bt-multi-sap-broadphase" 'classname)) dispatcher)
  (#.(bullet-wrap::swig-lispify "btMultiSapBroadphase_resetPool" 'function) (ff-pointer self) dispatcher))


(cl:defclass #.(bullet-wrap::swig-lispify "bt-clock" 'classname)()
  ((ff-pointer :reader ff-pointer)))

(cl:defmethod initialize-instance :after ((obj #.(bullet-wrap::swig-lispify "bt-clock" 'class)) &key)
  (setf (slot-value obj 'ff-pointer) (#.(bullet-wrap::swig-lispify "new_btClock" 'function))))

(cl:defmethod initialize-instance :after ((obj #.(bullet-wrap::swig-lispify "bt-clock" 'class)) &key (other #.(bullet-wrap::swig-lispify "bt-clock" 'classname)))
  (setf (slot-value obj 'ff-pointer) (#.(bullet-wrap::swig-lispify "new_btClock" 'function) (ff-pointer other))))

(cl:shadow "=")
(cl:defmethod #.(bullet-wrap::swig-lispify "=" 'method) ((self #.(bullet-wrap::swig-lispify "bt-clock" 'classname)) (other #.(bullet-wrap::swig-lispify "bt-clock" 'classname)))
  (#.(bullet-wrap::swig-lispify "btClock_assignValue" 'function) (ff-pointer self) (ff-pointer other)))

(cl:defmethod #.(bullet-wrap::swig-lispify "reset" 'method) ((self #.(bullet-wrap::swig-lispify "bt-clock" 'classname)))
  (#.(bullet-wrap::swig-lispify "btClock_reset" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-time-milliseconds" 'method) ((self #.(bullet-wrap::swig-lispify "bt-clock" 'classname)))
  (#.(bullet-wrap::swig-lispify "btClock_getTimeMilliseconds" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-time-microseconds" 'method) ((self #.(bullet-wrap::swig-lispify "bt-clock" 'classname)))
  (#.(bullet-wrap::swig-lispify "btClock_getTimeMicroseconds" 'function) (ff-pointer self)))


(cl:defclass #.(bullet-wrap::swig-lispify "cprofile-node" 'classname)()
  ((ff-pointer :reader ff-pointer)))

(cl:defmethod initialize-instance :after ((obj #.(bullet-wrap::swig-lispify "cprofile-node" 'class)) &key (name cl:string) (parent #.(bullet-wrap::swig-lispify "cprofile-node" 'classname)))
  (setf (slot-value obj 'ff-pointer) (#.(bullet-wrap::swig-lispify "new_CProfileNode" 'function) name (ff-pointer parent))))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-sub-node" 'method) ((self #.(bullet-wrap::swig-lispify "cprofile-node" 'classname)) (name cl:string))
  (#.(bullet-wrap::swig-lispify "CProfileNode_Get_Sub_Node" 'function) (ff-pointer self) name))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-parent" 'method) ((self #.(bullet-wrap::swig-lispify "cprofile-node" 'classname)))
  (#.(bullet-wrap::swig-lispify "CProfileNode_Get_Parent" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-sibling" 'method) ((self #.(bullet-wrap::swig-lispify "cprofile-node" 'classname)))
  (#.(bullet-wrap::swig-lispify "CProfileNode_Get_Sibling" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-child" 'method) ((self #.(bullet-wrap::swig-lispify "cprofile-node" 'classname)))
  (#.(bullet-wrap::swig-lispify "CProfileNode_Get_Child" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "cleanup-memory" 'method) ((self #.(bullet-wrap::swig-lispify "cprofile-node" 'classname)))
  (#.(bullet-wrap::swig-lispify "CProfileNode_CleanupMemory" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "reset" 'method) ((self #.(bullet-wrap::swig-lispify "cprofile-node" 'classname)))
  (#.(bullet-wrap::swig-lispify "CProfileNode_Reset" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "call" 'method) ((self #.(bullet-wrap::swig-lispify "cprofile-node" 'classname)))
  (#.(bullet-wrap::swig-lispify "CProfileNode_Call" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "return" 'method) ((self #.(bullet-wrap::swig-lispify "cprofile-node" 'classname)))
  (#.(bullet-wrap::swig-lispify "CProfileNode_Return" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-name" 'method) ((self #.(bullet-wrap::swig-lispify "cprofile-node" 'classname)))
  (#.(bullet-wrap::swig-lispify "CProfileNode_Get_Name" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-total-calls" 'method) ((self #.(bullet-wrap::swig-lispify "cprofile-node" 'classname)))
  (#.(bullet-wrap::swig-lispify "CProfileNode_Get_Total_Calls" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-total-time" 'method) ((self #.(bullet-wrap::swig-lispify "cprofile-node" 'classname)))
  (#.(bullet-wrap::swig-lispify "CProfileNode_Get_Total_Time" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-user-pointer" 'method) ((self #.(bullet-wrap::swig-lispify "cprofile-node" 'classname)))
  (#.(bullet-wrap::swig-lispify "CProfileNode_GetUserPointer" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "set-user-pointer" 'method) ((self #.(bullet-wrap::swig-lispify "cprofile-node" 'classname)) ptr)
  (#.(bullet-wrap::swig-lispify "CProfileNode_SetUserPointer" 'function) (ff-pointer self) ptr))


(cl:defclass #.(bullet-wrap::swig-lispify "cprofile-iterator" 'classname)()
  ((ff-pointer :reader ff-pointer)))

(cl:defmethod #.(bullet-wrap::swig-lispify "first" 'method) ((self #.(bullet-wrap::swig-lispify "cprofile-iterator" 'classname)))
  (#.(bullet-wrap::swig-lispify "CProfileIterator_First" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "next" 'method) ((self #.(bullet-wrap::swig-lispify "cprofile-iterator" 'classname)))
  (#.(bullet-wrap::swig-lispify "CProfileIterator_Next" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "is-done" 'method) ((self #.(bullet-wrap::swig-lispify "cprofile-iterator" 'classname)))
  (#.(bullet-wrap::swig-lispify "CProfileIterator_Is_Done" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "is-root" 'method) ((self #.(bullet-wrap::swig-lispify "cprofile-iterator" 'classname)))
  (#.(bullet-wrap::swig-lispify "CProfileIterator_Is_Root" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "enter-child" 'method) ((self #.(bullet-wrap::swig-lispify "cprofile-iterator" 'classname)) (index cl:integer))
  (#.(bullet-wrap::swig-lispify "CProfileIterator_Enter_Child" 'function) (ff-pointer self) index))

(cl:defmethod #.(bullet-wrap::swig-lispify "enter-largest-child" 'method) ((self #.(bullet-wrap::swig-lispify "cprofile-iterator" 'classname)))
  (#.(bullet-wrap::swig-lispify "CProfileIterator_Enter_Largest_Child" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "enter-parent" 'method) ((self #.(bullet-wrap::swig-lispify "cprofile-iterator" 'classname)))
  (#.(bullet-wrap::swig-lispify "CProfileIterator_Enter_Parent" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-current-name" 'method) ((self #.(bullet-wrap::swig-lispify "cprofile-iterator" 'classname)))
  (#.(bullet-wrap::swig-lispify "CProfileIterator_Get_Current_Name" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-current-total-calls" 'method) ((self #.(bullet-wrap::swig-lispify "cprofile-iterator" 'classname)))
  (#.(bullet-wrap::swig-lispify "CProfileIterator_Get_Current_Total_Calls" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-current-total-time" 'method) ((self #.(bullet-wrap::swig-lispify "cprofile-iterator" 'classname)))
  (#.(bullet-wrap::swig-lispify "CProfileIterator_Get_Current_Total_Time" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-current-user-pointer" 'method) ((self #.(bullet-wrap::swig-lispify "cprofile-iterator" 'classname)))
  (#.(bullet-wrap::swig-lispify "CProfileIterator_Get_Current_UserPointer" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "set-current-user-pointer" 'method) ((self #.(bullet-wrap::swig-lispify "cprofile-iterator" 'classname)) ptr)
  (#.(bullet-wrap::swig-lispify "CProfileIterator_Set_Current_UserPointer" 'function) (ff-pointer self) ptr))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-current-parent-name" 'method) ((self #.(bullet-wrap::swig-lispify "cprofile-iterator" 'classname)))
  (#.(bullet-wrap::swig-lispify "CProfileIterator_Get_Current_Parent_Name" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-current-parent-total-calls" 'method) ((self #.(bullet-wrap::swig-lispify "cprofile-iterator" 'classname)))
  (#.(bullet-wrap::swig-lispify "CProfileIterator_Get_Current_Parent_Total_Calls" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-current-parent-total-time" 'method) ((self #.(bullet-wrap::swig-lispify "cprofile-iterator" 'classname)))
  (#.(bullet-wrap::swig-lispify "CProfileIterator_Get_Current_Parent_Total_Time" 'function) (ff-pointer self)))


(cl:defclass #.(bullet-wrap::swig-lispify "cprofile-manager" 'classname)()
  ((ff-pointer :reader ff-pointer)))

(cl:defmethod initialize-instance :after ((obj #.(bullet-wrap::swig-lispify "cprofile-manager" 'class)) &key)
  (setf (slot-value obj 'ff-pointer) (#.(bullet-wrap::swig-lispify "new_CProfileManager" 'function))))


(cl:defclass #.(bullet-wrap::swig-lispify "cprofile-sample" 'classname)()
  ((ff-pointer :reader ff-pointer)))

(cl:defmethod initialize-instance :after ((obj #.(bullet-wrap::swig-lispify "cprofile-sample" 'class)) &key (name cl:string))
  (setf (slot-value obj 'ff-pointer) (#.(bullet-wrap::swig-lispify "new_CProfileSample" 'function) name)))


(cl:defclass #.(bullet-wrap::swig-lispify "bt-idebug-draw" 'classname)()
  ((ff-pointer :reader ff-pointer)))

(cl:defmethod #.(bullet-wrap::swig-lispify "draw-line" 'method) ((self #.(bullet-wrap::swig-lispify "bt-idebug-draw" 'classname)) (from #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (to #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (color #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)))
  (#.(bullet-wrap::swig-lispify "btIDebugDraw_drawLine" 'function) (ff-pointer self) from to color))

(cl:defmethod #.(bullet-wrap::swig-lispify "draw-line" 'method) ((self #.(bullet-wrap::swig-lispify "bt-idebug-draw" 'classname)) (from #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (to #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (fromColor #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (toColor #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)))
  (#.(bullet-wrap::swig-lispify "btIDebugDraw_drawLine" 'function) (ff-pointer self) from to fromColor toColor))

(cl:defmethod #.(bullet-wrap::swig-lispify "draw-sphere" 'method) ((self #.(bullet-wrap::swig-lispify "bt-idebug-draw" 'classname)) (radius cl:number) (transform #.(bullet-wrap::swig-lispify "bt-transform" 'classname)) (color #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)))
  (#.(bullet-wrap::swig-lispify "btIDebugDraw_drawSphere" 'function) (ff-pointer self) radius transform color))

(cl:defmethod #.(bullet-wrap::swig-lispify "draw-sphere" 'method) ((self #.(bullet-wrap::swig-lispify "bt-idebug-draw" 'classname)) (p #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (radius cl:number) (color #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)))
  (#.(bullet-wrap::swig-lispify "btIDebugDraw_drawSphere" 'function) (ff-pointer self) p radius color))

(cl:defmethod #.(bullet-wrap::swig-lispify "draw-triangle" 'method) ((self #.(bullet-wrap::swig-lispify "bt-idebug-draw" 'classname)) (v0 #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (v1 #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (v2 #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (arg4 #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (arg5 #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (arg6 #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (color #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (alpha cl:number))
  (#.(bullet-wrap::swig-lispify "btIDebugDraw_drawTriangle" 'function) (ff-pointer self) v0 v1 v2 arg4 arg5 arg6 color alpha))

(cl:defmethod #.(bullet-wrap::swig-lispify "draw-triangle" 'method) ((self #.(bullet-wrap::swig-lispify "bt-idebug-draw" 'classname)) (v0 #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (v1 #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (v2 #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (color #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (arg5 cl:number))
  (#.(bullet-wrap::swig-lispify "btIDebugDraw_drawTriangle" 'function) (ff-pointer self) v0 v1 v2 color arg5))

(cl:defmethod #.(bullet-wrap::swig-lispify "draw-contact-point" 'method) ((self #.(bullet-wrap::swig-lispify "bt-idebug-draw" 'classname)) (PointOnB #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (normalOnB #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (distance cl:number) (lifeTime cl:integer) (color #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)))
  (#.(bullet-wrap::swig-lispify "btIDebugDraw_drawContactPoint" 'function) (ff-pointer self) PointOnB normalOnB distance lifeTime color))

(cl:defmethod #.(bullet-wrap::swig-lispify "report-error-warning" 'method) ((self #.(bullet-wrap::swig-lispify "bt-idebug-draw" 'classname)) (warningString cl:string))
  (#.(bullet-wrap::swig-lispify "btIDebugDraw_reportErrorWarning" 'function) (ff-pointer self) warningString))

(cl:defmethod #.(bullet-wrap::swig-lispify "draw3d-text" 'method) ((self #.(bullet-wrap::swig-lispify "bt-idebug-draw" 'classname)) (location #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (textString cl:string))
  (#.(bullet-wrap::swig-lispify "btIDebugDraw_draw3dText" 'function) (ff-pointer self) location textString))

(cl:defmethod #.(bullet-wrap::swig-lispify "set-debug-mode" 'method) ((self #.(bullet-wrap::swig-lispify "bt-idebug-draw" 'classname)) (debugMode cl:integer))
  (#.(bullet-wrap::swig-lispify "btIDebugDraw_setDebugMode" 'function) (ff-pointer self) debugMode))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-debug-mode" 'method) ((self #.(bullet-wrap::swig-lispify "bt-idebug-draw" 'classname)))
  (#.(bullet-wrap::swig-lispify "btIDebugDraw_getDebugMode" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "draw-aabb" 'method) ((self #.(bullet-wrap::swig-lispify "bt-idebug-draw" 'classname)) (from #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (to #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (color #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)))
  (#.(bullet-wrap::swig-lispify "btIDebugDraw_drawAabb" 'function) (ff-pointer self) from to color))

(cl:defmethod #.(bullet-wrap::swig-lispify "draw-transform" 'method) ((self #.(bullet-wrap::swig-lispify "bt-idebug-draw" 'classname)) (transform #.(bullet-wrap::swig-lispify "bt-transform" 'classname)) (orthoLen cl:number))
  (#.(bullet-wrap::swig-lispify "btIDebugDraw_drawTransform" 'function) (ff-pointer self) transform orthoLen))

(cl:defmethod #.(bullet-wrap::swig-lispify "draw-arc" 'method) ((self #.(bullet-wrap::swig-lispify "bt-idebug-draw" 'classname)) (center #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (normal #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (axis #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (radiusA cl:number) (radiusB cl:number) (minAngle cl:number) (maxAngle cl:number) (color #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (drawSect t) (stepDegrees cl:number))
  (#.(bullet-wrap::swig-lispify "btIDebugDraw_drawArc" 'function) (ff-pointer self) center normal axis radiusA radiusB minAngle maxAngle color drawSect stepDegrees))

(cl:defmethod #.(bullet-wrap::swig-lispify "draw-arc" 'method) ((self #.(bullet-wrap::swig-lispify "bt-idebug-draw" 'classname)) (center #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (normal #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (axis #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (radiusA cl:number) (radiusB cl:number) (minAngle cl:number) (maxAngle cl:number) (color #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (drawSect t))
  (#.(bullet-wrap::swig-lispify "btIDebugDraw_drawArc" 'function) (ff-pointer self) center normal axis radiusA radiusB minAngle maxAngle color drawSect))

(cl:defmethod #.(bullet-wrap::swig-lispify "draw-sphere-patch" 'method) ((self #.(bullet-wrap::swig-lispify "bt-idebug-draw" 'classname)) (center #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (up #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (axis #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (radius cl:number) (minTh cl:number) (maxTh cl:number) (minPs cl:number) (maxPs cl:number) (color #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (stepDegrees cl:number) (drawCenter t))
  (#.(bullet-wrap::swig-lispify "btIDebugDraw_drawSpherePatch" 'function) (ff-pointer self) center up axis radius minTh maxTh minPs maxPs color stepDegrees drawCenter))

(cl:defmethod #.(bullet-wrap::swig-lispify "draw-sphere-patch" 'method) ((self #.(bullet-wrap::swig-lispify "bt-idebug-draw" 'classname)) (center #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (up #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (axis #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (radius cl:number) (minTh cl:number) (maxTh cl:number) (minPs cl:number) (maxPs cl:number) (color #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (stepDegrees cl:number))
  (#.(bullet-wrap::swig-lispify "btIDebugDraw_drawSpherePatch" 'function) (ff-pointer self) center up axis radius minTh maxTh minPs maxPs color stepDegrees))

(cl:defmethod #.(bullet-wrap::swig-lispify "draw-sphere-patch" 'method) ((self #.(bullet-wrap::swig-lispify "bt-idebug-draw" 'classname)) (center #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (up #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (axis #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (radius cl:number) (minTh cl:number) (maxTh cl:number) (minPs cl:number) (maxPs cl:number) (color #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)))
  (#.(bullet-wrap::swig-lispify "btIDebugDraw_drawSpherePatch" 'function) (ff-pointer self) center up axis radius minTh maxTh minPs maxPs color))

(cl:defmethod #.(bullet-wrap::swig-lispify "draw-box" 'method) ((self #.(bullet-wrap::swig-lispify "bt-idebug-draw" 'classname)) (bbMin #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (bbMax #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (color #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)))
  (#.(bullet-wrap::swig-lispify "btIDebugDraw_drawBox" 'function) (ff-pointer self) bbMin bbMax color))

(cl:defmethod #.(bullet-wrap::swig-lispify "draw-box" 'method) ((self #.(bullet-wrap::swig-lispify "bt-idebug-draw" 'classname)) (bbMin #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (bbMax #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (trans #.(bullet-wrap::swig-lispify "bt-transform" 'classname)) (color #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)))
  (#.(bullet-wrap::swig-lispify "btIDebugDraw_drawBox" 'function) (ff-pointer self) bbMin bbMax trans color))

(cl:defmethod #.(bullet-wrap::swig-lispify "draw-capsule" 'method) ((self #.(bullet-wrap::swig-lispify "bt-idebug-draw" 'classname)) (radius cl:number) (halfHeight cl:number) (upAxis cl:integer) (transform #.(bullet-wrap::swig-lispify "bt-transform" 'classname)) (color #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)))
  (#.(bullet-wrap::swig-lispify "btIDebugDraw_drawCapsule" 'function) (ff-pointer self) radius halfHeight upAxis transform color))

(cl:defmethod #.(bullet-wrap::swig-lispify "draw-cylinder" 'method) ((self #.(bullet-wrap::swig-lispify "bt-idebug-draw" 'classname)) (radius cl:number) (halfHeight cl:number) (upAxis cl:integer) (transform #.(bullet-wrap::swig-lispify "bt-transform" 'classname)) (color #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)))
  (#.(bullet-wrap::swig-lispify "btIDebugDraw_drawCylinder" 'function) (ff-pointer self) radius halfHeight upAxis transform color))

(cl:defmethod #.(bullet-wrap::swig-lispify "draw-cone" 'method) ((self #.(bullet-wrap::swig-lispify "bt-idebug-draw" 'classname)) (radius cl:number) (height cl:number) (upAxis cl:integer) (transform #.(bullet-wrap::swig-lispify "bt-transform" 'classname)) (color #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)))
  (#.(bullet-wrap::swig-lispify "btIDebugDraw_drawCone" 'function) (ff-pointer self) radius height upAxis transform color))

(cl:defmethod #.(bullet-wrap::swig-lispify "draw-plane" 'method) ((self #.(bullet-wrap::swig-lispify "bt-idebug-draw" 'classname)) (planeNormal #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (planeConst cl:number) (transform #.(bullet-wrap::swig-lispify "bt-transform" 'classname)) (color #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)))
  (#.(bullet-wrap::swig-lispify "btIDebugDraw_drawPlane" 'function) (ff-pointer self) planeNormal planeConst transform color))


(cl:defclass #.(bullet-wrap::swig-lispify "bt-chunk" 'classname)()
  ((ff-pointer :reader ff-pointer)))

(cl:defmethod (cl:setf #.(bullet-wrap::swig-lispify "m_chunkCode" 'method)) (arg0 (obj #.(bullet-wrap::swig-lispify "bt-chunk" 'class)))
  (#.(bullet-wrap::swig-lispify "btChunk_m_chunkCode_set" 'function) (ff-pointer obj) arg0))

(cl:defmethod #.(bullet-wrap::swig-lispify "m_chunkCode" 'method) ((obj #.(bullet-wrap::swig-lispify "bt-chunk" 'class)))
  (#.(bullet-wrap::swig-lispify "btChunk_m_chunkCode_get" 'function) (ff-pointer obj)))

(cl:defmethod (cl:setf #.(bullet-wrap::swig-lispify "m_length" 'method)) (arg0 (obj #.(bullet-wrap::swig-lispify "bt-chunk" 'class)))
  (#.(bullet-wrap::swig-lispify "btChunk_m_length_set" 'function) (ff-pointer obj) arg0))

(cl:defmethod #.(bullet-wrap::swig-lispify "m_length" 'method) ((obj #.(bullet-wrap::swig-lispify "bt-chunk" 'class)))
  (#.(bullet-wrap::swig-lispify "btChunk_m_length_get" 'function) (ff-pointer obj)))

(cl:defmethod (cl:setf #.(bullet-wrap::swig-lispify "m_oldPtr" 'method)) (arg0 (obj #.(bullet-wrap::swig-lispify "bt-chunk" 'class)))
  (#.(bullet-wrap::swig-lispify "btChunk_m_oldPtr_set" 'function) (ff-pointer obj) arg0))

(cl:defmethod #.(bullet-wrap::swig-lispify "m_oldPtr" 'method) ((obj #.(bullet-wrap::swig-lispify "bt-chunk" 'class)))
  (#.(bullet-wrap::swig-lispify "btChunk_m_oldPtr_get" 'function) (ff-pointer obj)))

(cl:defmethod (cl:setf #.(bullet-wrap::swig-lispify "m_dna_nr" 'method)) (arg0 (obj #.(bullet-wrap::swig-lispify "bt-chunk" 'class)))
  (#.(bullet-wrap::swig-lispify "btChunk_m_dna_nr_set" 'function) (ff-pointer obj) arg0))

(cl:defmethod #.(bullet-wrap::swig-lispify "m_dna_nr" 'method) ((obj #.(bullet-wrap::swig-lispify "bt-chunk" 'class)))
  (#.(bullet-wrap::swig-lispify "btChunk_m_dna_nr_get" 'function) (ff-pointer obj)))

(cl:defmethod (cl:setf #.(bullet-wrap::swig-lispify "m_number" 'method)) (arg0 (obj #.(bullet-wrap::swig-lispify "bt-chunk" 'class)))
  (#.(bullet-wrap::swig-lispify "btChunk_m_number_set" 'function) (ff-pointer obj) arg0))

(cl:defmethod #.(bullet-wrap::swig-lispify "m_number" 'method) ((obj #.(bullet-wrap::swig-lispify "bt-chunk" 'class)))
  (#.(bullet-wrap::swig-lispify "btChunk_m_number_get" 'function) (ff-pointer obj)))

(cl:defmethod initialize-instance :after ((obj #.(bullet-wrap::swig-lispify "bt-chunk" 'class)) &key)
  (setf (slot-value obj 'ff-pointer) (#.(bullet-wrap::swig-lispify "new_btChunk" 'function))))


(cl:defclass #.(bullet-wrap::swig-lispify "bt-serializer" 'classname)()
  ((ff-pointer :reader ff-pointer)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-buffer-pointer" 'method) ((self #.(bullet-wrap::swig-lispify "bt-serializer" 'classname)))
  (#.(bullet-wrap::swig-lispify "btSerializer_getBufferPointer" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-current-buffer-size" 'method) ((self #.(bullet-wrap::swig-lispify "bt-serializer" 'classname)))
  (#.(bullet-wrap::swig-lispify "btSerializer_getCurrentBufferSize" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "allocate" 'method) ((self #.(bullet-wrap::swig-lispify "bt-serializer" 'classname)) size (numElements cl:integer))
  (#.(bullet-wrap::swig-lispify "btSerializer_allocate" 'function) (ff-pointer self) size numElements))

(cl:defmethod #.(bullet-wrap::swig-lispify "finalize-chunk" 'method) ((self #.(bullet-wrap::swig-lispify "bt-serializer" 'classname)) (chunk #.(bullet-wrap::swig-lispify "bt-chunk" 'classname)) (structType cl:string) (chunkCode cl:integer) oldPtr)
  (#.(bullet-wrap::swig-lispify "btSerializer_finalizeChunk" 'function) (ff-pointer self) chunk structType chunkCode oldPtr))

(cl:defmethod #.(bullet-wrap::swig-lispify "find-pointer" 'method) ((self #.(bullet-wrap::swig-lispify "bt-serializer" 'classname)) oldPtr)
  (#.(bullet-wrap::swig-lispify "btSerializer_findPointer" 'function) (ff-pointer self) oldPtr))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-unique-pointer" 'method) ((self #.(bullet-wrap::swig-lispify "bt-serializer" 'classname)) oldPtr)
  (#.(bullet-wrap::swig-lispify "btSerializer_getUniquePointer" 'function) (ff-pointer self) oldPtr))

(cl:defmethod #.(bullet-wrap::swig-lispify "start-serialization" 'method) ((self #.(bullet-wrap::swig-lispify "bt-serializer" 'classname)))
  (#.(bullet-wrap::swig-lispify "btSerializer_startSerialization" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "finish-serialization" 'method) ((self #.(bullet-wrap::swig-lispify "bt-serializer" 'classname)))
  (#.(bullet-wrap::swig-lispify "btSerializer_finishSerialization" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "find-name-for-pointer" 'method) ((self #.(bullet-wrap::swig-lispify "bt-serializer" 'classname)) ptr)
  (#.(bullet-wrap::swig-lispify "btSerializer_findNameForPointer" 'function) (ff-pointer self) ptr))

(cl:defmethod #.(bullet-wrap::swig-lispify "register-name-for-pointer" 'method) ((self #.(bullet-wrap::swig-lispify "bt-serializer" 'classname)) ptr (name cl:string))
  (#.(bullet-wrap::swig-lispify "btSerializer_registerNameForPointer" 'function) (ff-pointer self) ptr name))

(cl:defmethod #.(bullet-wrap::swig-lispify "serialize-name" 'method) ((self #.(bullet-wrap::swig-lispify "bt-serializer" 'classname)) (ptr cl:string))
  (#.(bullet-wrap::swig-lispify "btSerializer_serializeName" 'function) (ff-pointer self) ptr))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-serialization-flags" 'method) ((self #.(bullet-wrap::swig-lispify "bt-serializer" 'classname)))
  (#.(bullet-wrap::swig-lispify "btSerializer_getSerializationFlags" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "set-serialization-flags" 'method) ((self #.(bullet-wrap::swig-lispify "bt-serializer" 'classname)) (flags cl:integer))
  (#.(bullet-wrap::swig-lispify "btSerializer_setSerializationFlags" 'function) (ff-pointer self) flags))


(cl:defclass #.(bullet-wrap::swig-lispify "bt-default-serializer" 'classname)(#.(bullet-wrap::swig-lispify "btSerializer" 'classname))
  ((ff-pointer :reader ff-pointer)))

(cl:defmethod initialize-instance :after ((obj #.(bullet-wrap::swig-lispify "bt-default-serializer" 'class)) &key (totalSize cl:integer))
  (setf (slot-value obj 'ff-pointer) (#.(bullet-wrap::swig-lispify "new_btDefaultSerializer" 'function) totalSize)))

(cl:defmethod initialize-instance :after ((obj #.(bullet-wrap::swig-lispify "bt-default-serializer" 'class)) &key)
  (setf (slot-value obj 'ff-pointer) (#.(bullet-wrap::swig-lispify "new_btDefaultSerializer" 'function))))

(cl:defmethod #.(bullet-wrap::swig-lispify "write-header" 'method) ((self #.(bullet-wrap::swig-lispify "bt-default-serializer" 'classname)) buffer)
  (#.(bullet-wrap::swig-lispify "btDefaultSerializer_writeHeader" 'function) (ff-pointer self) buffer))

(cl:defmethod #.(bullet-wrap::swig-lispify "start-serialization" 'method) ((self #.(bullet-wrap::swig-lispify "bt-default-serializer" 'classname)))
  (#.(bullet-wrap::swig-lispify "btDefaultSerializer_startSerialization" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "finish-serialization" 'method) ((self #.(bullet-wrap::swig-lispify "bt-default-serializer" 'classname)))
  (#.(bullet-wrap::swig-lispify "btDefaultSerializer_finishSerialization" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-unique-pointer" 'method) ((self #.(bullet-wrap::swig-lispify "bt-default-serializer" 'classname)) oldPtr)
  (#.(bullet-wrap::swig-lispify "btDefaultSerializer_getUniquePointer" 'function) (ff-pointer self) oldPtr))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-buffer-pointer" 'method) ((self #.(bullet-wrap::swig-lispify "bt-default-serializer" 'classname)))
  (#.(bullet-wrap::swig-lispify "btDefaultSerializer_getBufferPointer" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-current-buffer-size" 'method) ((self #.(bullet-wrap::swig-lispify "bt-default-serializer" 'classname)))
  (#.(bullet-wrap::swig-lispify "btDefaultSerializer_getCurrentBufferSize" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "finalize-chunk" 'method) ((self #.(bullet-wrap::swig-lispify "bt-default-serializer" 'classname)) (chunk #.(bullet-wrap::swig-lispify "bt-chunk" 'classname)) (structType cl:string) (chunkCode cl:integer) oldPtr)
  (#.(bullet-wrap::swig-lispify "btDefaultSerializer_finalizeChunk" 'function) (ff-pointer self) chunk structType chunkCode oldPtr))

(cl:defmethod #.(bullet-wrap::swig-lispify "internal-alloc" 'method) ((self #.(bullet-wrap::swig-lispify "bt-default-serializer" 'classname)) size)
  (#.(bullet-wrap::swig-lispify "btDefaultSerializer_internalAlloc" 'function) (ff-pointer self) size))

(cl:defmethod #.(bullet-wrap::swig-lispify "allocate" 'method) ((self #.(bullet-wrap::swig-lispify "bt-default-serializer" 'classname)) size (numElements cl:integer))
  (#.(bullet-wrap::swig-lispify "btDefaultSerializer_allocate" 'function) (ff-pointer self) size numElements))

(cl:defmethod #.(bullet-wrap::swig-lispify "find-name-for-pointer" 'method) ((self #.(bullet-wrap::swig-lispify "bt-default-serializer" 'classname)) ptr)
  (#.(bullet-wrap::swig-lispify "btDefaultSerializer_findNameForPointer" 'function) (ff-pointer self) ptr))

(cl:defmethod #.(bullet-wrap::swig-lispify "register-name-for-pointer" 'method) ((self #.(bullet-wrap::swig-lispify "bt-default-serializer" 'classname)) ptr (name cl:string))
  (#.(bullet-wrap::swig-lispify "btDefaultSerializer_registerNameForPointer" 'function) (ff-pointer self) ptr name))

(cl:defmethod #.(bullet-wrap::swig-lispify "serialize-name" 'method) ((self #.(bullet-wrap::swig-lispify "bt-default-serializer" 'classname)) (name cl:string))
  (#.(bullet-wrap::swig-lispify "btDefaultSerializer_serializeName" 'function) (ff-pointer self) name))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-serialization-flags" 'method) ((self #.(bullet-wrap::swig-lispify "bt-default-serializer" 'classname)))
  (#.(bullet-wrap::swig-lispify "btDefaultSerializer_getSerializationFlags" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "set-serialization-flags" 'method) ((self #.(bullet-wrap::swig-lispify "bt-default-serializer" 'classname)) (flags cl:integer))
  (#.(bullet-wrap::swig-lispify "btDefaultSerializer_setSerializationFlags" 'function) (ff-pointer self) flags))


(cl:defclass #.(bullet-wrap::swig-lispify "bt-discrete-dynamics-world" 'classname)()
  ((ff-pointer :reader ff-pointer)))

(cl:shadow "new")
(cl:defmethod #.(bullet-wrap::swig-lispify "new" 'method) ((self #.(bullet-wrap::swig-lispify "bt-discrete-dynamics-world" 'classname)) sizeInBytes)
  (#.(bullet-wrap::swig-lispify "btDiscreteDynamicsWorld_makeCPlusPlusInstance" 'function) (ff-pointer self) sizeInBytes))

(cl:shadow "delete")
(cl:defmethod #.(bullet-wrap::swig-lispify "delete" 'method) ((self #.(bullet-wrap::swig-lispify "bt-discrete-dynamics-world" 'classname)) ptr)
  (#.(bullet-wrap::swig-lispify "btDiscreteDynamicsWorld_deleteCPlusPlusInstance" 'function) (ff-pointer self) ptr))

(cl:shadow "new")
(cl:defmethod #.(bullet-wrap::swig-lispify "new" 'method) ((self #.(bullet-wrap::swig-lispify "bt-discrete-dynamics-world" 'classname)) arg1 ptr)
  (#.(bullet-wrap::swig-lispify "btDiscreteDynamicsWorld_makeCPlusPlusInstance" 'function) (ff-pointer self) arg1 ptr))

(cl:shadow "delete")
(cl:defmethod #.(bullet-wrap::swig-lispify "delete" 'method) ((self #.(bullet-wrap::swig-lispify "bt-discrete-dynamics-world" 'classname)) arg1 arg2)
  (#.(bullet-wrap::swig-lispify "btDiscreteDynamicsWorld_deleteCPlusPlusInstance" 'function) (ff-pointer self) arg1 arg2))

(cl:shadow "new[]")
(cl:defmethod #.(bullet-wrap::swig-lispify "new[]" 'method) ((self #.(bullet-wrap::swig-lispify "bt-discrete-dynamics-world" 'classname)) sizeInBytes)
  (#.(bullet-wrap::swig-lispify "btDiscreteDynamicsWorld_makeCPlusArray" 'function) (ff-pointer self) sizeInBytes))

(cl:shadow "delete[]")
(cl:defmethod #.(bullet-wrap::swig-lispify "delete[]" 'method) ((self #.(bullet-wrap::swig-lispify "bt-discrete-dynamics-world" 'classname)) ptr)
  (#.(bullet-wrap::swig-lispify "btDiscreteDynamicsWorld_deleteCPlusArray" 'function) (ff-pointer self) ptr))

(cl:shadow "new[]")
(cl:defmethod #.(bullet-wrap::swig-lispify "new[]" 'method) ((self #.(bullet-wrap::swig-lispify "bt-discrete-dynamics-world" 'classname)) arg1 ptr)
  (#.(bullet-wrap::swig-lispify "btDiscreteDynamicsWorld_makeCPlusArray" 'function) (ff-pointer self) arg1 ptr))

(cl:shadow "delete[]")
(cl:defmethod #.(bullet-wrap::swig-lispify "delete[]" 'method) ((self #.(bullet-wrap::swig-lispify "bt-discrete-dynamics-world" 'classname)) arg1 arg2)
  (#.(bullet-wrap::swig-lispify "btDiscreteDynamicsWorld_deleteCPlusArray" 'function) (ff-pointer self) arg1 arg2))

(cl:defmethod initialize-instance :after ((obj #.(bullet-wrap::swig-lispify "bt-discrete-dynamics-world" 'class)) &key dispatcher pairCache constraintSolver collisionConfiguration)
  (setf (slot-value obj 'ff-pointer) (#.(bullet-wrap::swig-lispify "new_btDiscreteDynamicsWorld" 'function) dispatcher pairCache constraintSolver collisionConfiguration)))

(cl:defmethod #.(bullet-wrap::swig-lispify "step-simulation" 'method) ((self #.(bullet-wrap::swig-lispify "bt-discrete-dynamics-world" 'classname)) (timeStep cl:number) (maxSubSteps cl:integer) (fixedTimeStep cl:number))
  (#.(bullet-wrap::swig-lispify "btDiscreteDynamicsWorld_stepSimulation" 'function) (ff-pointer self) timeStep maxSubSteps fixedTimeStep))

(cl:defmethod #.(bullet-wrap::swig-lispify "step-simulation" 'method) ((self #.(bullet-wrap::swig-lispify "bt-discrete-dynamics-world" 'classname)) (timeStep cl:number) (maxSubSteps cl:integer))
  (#.(bullet-wrap::swig-lispify "btDiscreteDynamicsWorld_stepSimulation" 'function) (ff-pointer self) timeStep maxSubSteps))

(cl:defmethod #.(bullet-wrap::swig-lispify "step-simulation" 'method) ((self #.(bullet-wrap::swig-lispify "bt-discrete-dynamics-world" 'classname)) (timeStep cl:number))
  (#.(bullet-wrap::swig-lispify "btDiscreteDynamicsWorld_stepSimulation" 'function) (ff-pointer self) timeStep))

(cl:defmethod #.(bullet-wrap::swig-lispify "synchronize-motion-states" 'method) ((self #.(bullet-wrap::swig-lispify "bt-discrete-dynamics-world" 'classname)))
  (#.(bullet-wrap::swig-lispify "btDiscreteDynamicsWorld_synchronizeMotionStates" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "synchronize-single-motion-state" 'method) ((self #.(bullet-wrap::swig-lispify "bt-discrete-dynamics-world" 'classname)) body)
  (#.(bullet-wrap::swig-lispify "btDiscreteDynamicsWorld_synchronizeSingleMotionState" 'function) (ff-pointer self) body))

(cl:defmethod #.(bullet-wrap::swig-lispify "add-constraint" 'method) ((self #.(bullet-wrap::swig-lispify "bt-discrete-dynamics-world" 'classname)) constraint (disableCollisionsBetweenLinkedBodies t))
  (#.(bullet-wrap::swig-lispify "btDiscreteDynamicsWorld_addConstraint" 'function) (ff-pointer self) constraint disableCollisionsBetweenLinkedBodies))

(cl:defmethod #.(bullet-wrap::swig-lispify "add-constraint" 'method) ((self #.(bullet-wrap::swig-lispify "bt-discrete-dynamics-world" 'classname)) constraint)
  (#.(bullet-wrap::swig-lispify "btDiscreteDynamicsWorld_addConstraint" 'function) (ff-pointer self) constraint))

(cl:defmethod #.(bullet-wrap::swig-lispify "remove-constraint" 'method) ((self #.(bullet-wrap::swig-lispify "bt-discrete-dynamics-world" 'classname)) constraint)
  (#.(bullet-wrap::swig-lispify "btDiscreteDynamicsWorld_removeConstraint" 'function) (ff-pointer self) constraint))

(cl:defmethod #.(bullet-wrap::swig-lispify "add-action" 'method) ((self #.(bullet-wrap::swig-lispify "bt-discrete-dynamics-world" 'classname)) arg1)
  (#.(bullet-wrap::swig-lispify "btDiscreteDynamicsWorld_addAction" 'function) (ff-pointer self) arg1))

(cl:defmethod #.(bullet-wrap::swig-lispify "remove-action" 'method) ((self #.(bullet-wrap::swig-lispify "bt-discrete-dynamics-world" 'classname)) arg1)
  (#.(bullet-wrap::swig-lispify "btDiscreteDynamicsWorld_removeAction" 'function) (ff-pointer self) arg1))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-simulation-island-manager" 'method) ((self #.(bullet-wrap::swig-lispify "bt-discrete-dynamics-world" 'classname)))
  (#.(bullet-wrap::swig-lispify "btDiscreteDynamicsWorld_getSimulationIslandManager" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-simulation-island-manager" 'method) ((self #.(bullet-wrap::swig-lispify "bt-discrete-dynamics-world" 'classname)))
  (#.(bullet-wrap::swig-lispify "btDiscreteDynamicsWorld_getSimulationIslandManager" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-collision-world" 'method) ((self #.(bullet-wrap::swig-lispify "bt-discrete-dynamics-world" 'classname)))
  (#.(bullet-wrap::swig-lispify "btDiscreteDynamicsWorld_getCollisionWorld" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "set-gravity" 'method) ((self #.(bullet-wrap::swig-lispify "bt-discrete-dynamics-world" 'classname)) (gravity #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)))
  (#.(bullet-wrap::swig-lispify "btDiscreteDynamicsWorld_setGravity" 'function) (ff-pointer self) gravity))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-gravity" 'method) ((self #.(bullet-wrap::swig-lispify "bt-discrete-dynamics-world" 'classname)))
  (#.(bullet-wrap::swig-lispify "btDiscreteDynamicsWorld_getGravity" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "add-collision-object" 'method) ((self #.(bullet-wrap::swig-lispify "bt-discrete-dynamics-world" 'classname)) (collisionObject #.(bullet-wrap::swig-lispify "bt-collision-object" 'classname)) (collisionFilterGroup cl:integer) (collisionFilterMask cl:integer))
  (#.(bullet-wrap::swig-lispify "btDiscreteDynamicsWorld_addCollisionObject" 'function) (ff-pointer self) collisionObject collisionFilterGroup collisionFilterMask))

(cl:defmethod #.(bullet-wrap::swig-lispify "add-collision-object" 'method) ((self #.(bullet-wrap::swig-lispify "bt-discrete-dynamics-world" 'classname)) (collisionObject #.(bullet-wrap::swig-lispify "bt-collision-object" 'classname)) (collisionFilterGroup cl:integer))
  (#.(bullet-wrap::swig-lispify "btDiscreteDynamicsWorld_addCollisionObject" 'function) (ff-pointer self) collisionObject collisionFilterGroup))

(cl:defmethod #.(bullet-wrap::swig-lispify "add-collision-object" 'method) ((self #.(bullet-wrap::swig-lispify "bt-discrete-dynamics-world" 'classname)) (collisionObject #.(bullet-wrap::swig-lispify "bt-collision-object" 'classname)))
  (#.(bullet-wrap::swig-lispify "btDiscreteDynamicsWorld_addCollisionObject" 'function) (ff-pointer self) collisionObject))

(cl:defmethod #.(bullet-wrap::swig-lispify "add-rigid-body" 'method) ((self #.(bullet-wrap::swig-lispify "bt-discrete-dynamics-world" 'classname)) body)
  (#.(bullet-wrap::swig-lispify "btDiscreteDynamicsWorld_addRigidBody" 'function) (ff-pointer self) body))

(cl:defmethod #.(bullet-wrap::swig-lispify "add-rigid-body" 'method) ((self #.(bullet-wrap::swig-lispify "bt-discrete-dynamics-world" 'classname)) body (group cl:integer) (mask cl:integer))
  (#.(bullet-wrap::swig-lispify "btDiscreteDynamicsWorld_addRigidBody" 'function) (ff-pointer self) body group mask))

(cl:defmethod #.(bullet-wrap::swig-lispify "remove-rigid-body" 'method) ((self #.(bullet-wrap::swig-lispify "bt-discrete-dynamics-world" 'classname)) body)
  (#.(bullet-wrap::swig-lispify "btDiscreteDynamicsWorld_removeRigidBody" 'function) (ff-pointer self) body))

(cl:defmethod #.(bullet-wrap::swig-lispify "remove-collision-object" 'method) ((self #.(bullet-wrap::swig-lispify "bt-discrete-dynamics-world" 'classname)) (collisionObject #.(bullet-wrap::swig-lispify "bt-collision-object" 'classname)))
  (#.(bullet-wrap::swig-lispify "btDiscreteDynamicsWorld_removeCollisionObject" 'function) (ff-pointer self) collisionObject))

(cl:defmethod #.(bullet-wrap::swig-lispify "debug-draw-constraint" 'method) ((self #.(bullet-wrap::swig-lispify "bt-discrete-dynamics-world" 'classname)) constraint)
  (#.(bullet-wrap::swig-lispify "btDiscreteDynamicsWorld_debugDrawConstraint" 'function) (ff-pointer self) constraint))

(cl:defmethod #.(bullet-wrap::swig-lispify "debug-draw-world" 'method) ((self #.(bullet-wrap::swig-lispify "bt-discrete-dynamics-world" 'classname)))
  (#.(bullet-wrap::swig-lispify "btDiscreteDynamicsWorld_debugDrawWorld" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "set-constraint-solver" 'method) ((self #.(bullet-wrap::swig-lispify "bt-discrete-dynamics-world" 'classname)) solver)
  (#.(bullet-wrap::swig-lispify "btDiscreteDynamicsWorld_setConstraintSolver" 'function) (ff-pointer self) solver))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-constraint-solver" 'method) ((self #.(bullet-wrap::swig-lispify "bt-discrete-dynamics-world" 'classname)))
  (#.(bullet-wrap::swig-lispify "btDiscreteDynamicsWorld_getConstraintSolver" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-num-constraints" 'method) ((self #.(bullet-wrap::swig-lispify "bt-discrete-dynamics-world" 'classname)))
  (#.(bullet-wrap::swig-lispify "btDiscreteDynamicsWorld_getNumConstraints" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-constraint" 'method) ((self #.(bullet-wrap::swig-lispify "bt-discrete-dynamics-world" 'classname)) (index cl:integer))
  (#.(bullet-wrap::swig-lispify "btDiscreteDynamicsWorld_getConstraint" 'function) (ff-pointer self) index))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-constraint" 'method) ((self #.(bullet-wrap::swig-lispify "bt-discrete-dynamics-world" 'classname)) (index cl:integer))
  (#.(bullet-wrap::swig-lispify "btDiscreteDynamicsWorld_getConstraint" 'function) (ff-pointer self) index))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-world-type" 'method) ((self #.(bullet-wrap::swig-lispify "bt-discrete-dynamics-world" 'classname)))
  (#.(bullet-wrap::swig-lispify "btDiscreteDynamicsWorld_getWorldType" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "clear-forces" 'method) ((self #.(bullet-wrap::swig-lispify "bt-discrete-dynamics-world" 'classname)))
  (#.(bullet-wrap::swig-lispify "btDiscreteDynamicsWorld_clearForces" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "apply-gravity" 'method) ((self #.(bullet-wrap::swig-lispify "bt-discrete-dynamics-world" 'classname)))
  (#.(bullet-wrap::swig-lispify "btDiscreteDynamicsWorld_applyGravity" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "set-num-tasks" 'method) ((self #.(bullet-wrap::swig-lispify "bt-discrete-dynamics-world" 'classname)) (numTasks cl:integer))
  (#.(bullet-wrap::swig-lispify "btDiscreteDynamicsWorld_setNumTasks" 'function) (ff-pointer self) numTasks))

(cl:defmethod #.(bullet-wrap::swig-lispify "update-vehicles" 'method) ((self #.(bullet-wrap::swig-lispify "bt-discrete-dynamics-world" 'classname)) (timeStep cl:number))
  (#.(bullet-wrap::swig-lispify "btDiscreteDynamicsWorld_updateVehicles" 'function) (ff-pointer self) timeStep))

(cl:defmethod #.(bullet-wrap::swig-lispify "add-vehicle" 'method) ((self #.(bullet-wrap::swig-lispify "bt-discrete-dynamics-world" 'classname)) vehicle)
  (#.(bullet-wrap::swig-lispify "btDiscreteDynamicsWorld_addVehicle" 'function) (ff-pointer self) vehicle))

(cl:defmethod #.(bullet-wrap::swig-lispify "remove-vehicle" 'method) ((self #.(bullet-wrap::swig-lispify "bt-discrete-dynamics-world" 'classname)) vehicle)
  (#.(bullet-wrap::swig-lispify "btDiscreteDynamicsWorld_removeVehicle" 'function) (ff-pointer self) vehicle))

(cl:defmethod #.(bullet-wrap::swig-lispify "add-character" 'method) ((self #.(bullet-wrap::swig-lispify "bt-discrete-dynamics-world" 'classname)) character)
  (#.(bullet-wrap::swig-lispify "btDiscreteDynamicsWorld_addCharacter" 'function) (ff-pointer self) character))

(cl:defmethod #.(bullet-wrap::swig-lispify "remove-character" 'method) ((self #.(bullet-wrap::swig-lispify "bt-discrete-dynamics-world" 'classname)) character)
  (#.(bullet-wrap::swig-lispify "btDiscreteDynamicsWorld_removeCharacter" 'function) (ff-pointer self) character))

(cl:defmethod #.(bullet-wrap::swig-lispify "set-synchronize-all-motion-states" 'method) ((self #.(bullet-wrap::swig-lispify "bt-discrete-dynamics-world" 'classname)) (synchronizeAll t))
  (#.(bullet-wrap::swig-lispify "btDiscreteDynamicsWorld_setSynchronizeAllMotionStates" 'function) (ff-pointer self) synchronizeAll))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-synchronize-all-motion-states" 'method) ((self #.(bullet-wrap::swig-lispify "bt-discrete-dynamics-world" 'classname)))
  (#.(bullet-wrap::swig-lispify "btDiscreteDynamicsWorld_getSynchronizeAllMotionStates" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "set-apply-speculative-contact-restitution" 'method) ((self #.(bullet-wrap::swig-lispify "bt-discrete-dynamics-world" 'classname)) (enable t))
  (#.(bullet-wrap::swig-lispify "btDiscreteDynamicsWorld_setApplySpeculativeContactRestitution" 'function) (ff-pointer self) enable))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-apply-speculative-contact-restitution" 'method) ((self #.(bullet-wrap::swig-lispify "bt-discrete-dynamics-world" 'classname)))
  (#.(bullet-wrap::swig-lispify "btDiscreteDynamicsWorld_getApplySpeculativeContactRestitution" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "serialize" 'method) ((self #.(bullet-wrap::swig-lispify "bt-discrete-dynamics-world" 'classname)) (serializer #.(bullet-wrap::swig-lispify "bt-serializer" 'classname)))
  (#.(bullet-wrap::swig-lispify "btDiscreteDynamicsWorld_serialize" 'function) (ff-pointer self) serializer))

(cl:defmethod #.(bullet-wrap::swig-lispify "set-latency-motion-state-interpolation" 'method) ((self #.(bullet-wrap::swig-lispify "bt-discrete-dynamics-world" 'classname)) (latencyInterpolation t))
  (#.(bullet-wrap::swig-lispify "btDiscreteDynamicsWorld_setLatencyMotionStateInterpolation" 'function) (ff-pointer self) latencyInterpolation))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-latency-motion-state-interpolation" 'method) ((self #.(bullet-wrap::swig-lispify "bt-discrete-dynamics-world" 'classname)))
  (#.(bullet-wrap::swig-lispify "btDiscreteDynamicsWorld_getLatencyMotionStateInterpolation" 'function) (ff-pointer self)))


(cl:defclass #.(bullet-wrap::swig-lispify "bt-simple-dynamics-world" 'classname)()
  ((ff-pointer :reader ff-pointer)))

(cl:defmethod initialize-instance :after ((obj #.(bullet-wrap::swig-lispify "bt-simple-dynamics-world" 'class)) &key dispatcher pairCache constraintSolver collisionConfiguration)
  (setf (slot-value obj 'ff-pointer) (#.(bullet-wrap::swig-lispify "new_btSimpleDynamicsWorld" 'function) dispatcher pairCache constraintSolver collisionConfiguration)))

(cl:defmethod #.(bullet-wrap::swig-lispify "step-simulation" 'method) ((self #.(bullet-wrap::swig-lispify "bt-simple-dynamics-world" 'classname)) (timeStep cl:number) (maxSubSteps cl:integer) (fixedTimeStep cl:number))
  (#.(bullet-wrap::swig-lispify "btSimpleDynamicsWorld_stepSimulation" 'function) (ff-pointer self) timeStep maxSubSteps fixedTimeStep))

(cl:defmethod #.(bullet-wrap::swig-lispify "step-simulation" 'method) ((self #.(bullet-wrap::swig-lispify "bt-simple-dynamics-world" 'classname)) (timeStep cl:number) (maxSubSteps cl:integer))
  (#.(bullet-wrap::swig-lispify "btSimpleDynamicsWorld_stepSimulation" 'function) (ff-pointer self) timeStep maxSubSteps))

(cl:defmethod #.(bullet-wrap::swig-lispify "step-simulation" 'method) ((self #.(bullet-wrap::swig-lispify "bt-simple-dynamics-world" 'classname)) (timeStep cl:number))
  (#.(bullet-wrap::swig-lispify "btSimpleDynamicsWorld_stepSimulation" 'function) (ff-pointer self) timeStep))

(cl:defmethod #.(bullet-wrap::swig-lispify "set-gravity" 'method) ((self #.(bullet-wrap::swig-lispify "bt-simple-dynamics-world" 'classname)) (gravity #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)))
  (#.(bullet-wrap::swig-lispify "btSimpleDynamicsWorld_setGravity" 'function) (ff-pointer self) gravity))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-gravity" 'method) ((self #.(bullet-wrap::swig-lispify "bt-simple-dynamics-world" 'classname)))
  (#.(bullet-wrap::swig-lispify "btSimpleDynamicsWorld_getGravity" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "add-rigid-body" 'method) ((self #.(bullet-wrap::swig-lispify "bt-simple-dynamics-world" 'classname)) body)
  (#.(bullet-wrap::swig-lispify "btSimpleDynamicsWorld_addRigidBody" 'function) (ff-pointer self) body))

(cl:defmethod #.(bullet-wrap::swig-lispify "add-rigid-body" 'method) ((self #.(bullet-wrap::swig-lispify "bt-simple-dynamics-world" 'classname)) body (group cl:integer) (mask cl:integer))
  (#.(bullet-wrap::swig-lispify "btSimpleDynamicsWorld_addRigidBody" 'function) (ff-pointer self) body group mask))

(cl:defmethod #.(bullet-wrap::swig-lispify "remove-rigid-body" 'method) ((self #.(bullet-wrap::swig-lispify "bt-simple-dynamics-world" 'classname)) body)
  (#.(bullet-wrap::swig-lispify "btSimpleDynamicsWorld_removeRigidBody" 'function) (ff-pointer self) body))

(cl:defmethod #.(bullet-wrap::swig-lispify "debug-draw-world" 'method) ((self #.(bullet-wrap::swig-lispify "bt-simple-dynamics-world" 'classname)))
  (#.(bullet-wrap::swig-lispify "btSimpleDynamicsWorld_debugDrawWorld" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "add-action" 'method) ((self #.(bullet-wrap::swig-lispify "bt-simple-dynamics-world" 'classname)) action)
  (#.(bullet-wrap::swig-lispify "btSimpleDynamicsWorld_addAction" 'function) (ff-pointer self) action))

(cl:defmethod #.(bullet-wrap::swig-lispify "remove-action" 'method) ((self #.(bullet-wrap::swig-lispify "bt-simple-dynamics-world" 'classname)) action)
  (#.(bullet-wrap::swig-lispify "btSimpleDynamicsWorld_removeAction" 'function) (ff-pointer self) action))

(cl:defmethod #.(bullet-wrap::swig-lispify "remove-collision-object" 'method) ((self #.(bullet-wrap::swig-lispify "bt-simple-dynamics-world" 'classname)) (collisionObject #.(bullet-wrap::swig-lispify "bt-collision-object" 'classname)))
  (#.(bullet-wrap::swig-lispify "btSimpleDynamicsWorld_removeCollisionObject" 'function) (ff-pointer self) collisionObject))

(cl:defmethod #.(bullet-wrap::swig-lispify "update-aabbs" 'method) ((self #.(bullet-wrap::swig-lispify "bt-simple-dynamics-world" 'classname)))
  (#.(bullet-wrap::swig-lispify "btSimpleDynamicsWorld_updateAabbs" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "synchronize-motion-states" 'method) ((self #.(bullet-wrap::swig-lispify "bt-simple-dynamics-world" 'classname)))
  (#.(bullet-wrap::swig-lispify "btSimpleDynamicsWorld_synchronizeMotionStates" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "set-constraint-solver" 'method) ((self #.(bullet-wrap::swig-lispify "bt-simple-dynamics-world" 'classname)) solver)
  (#.(bullet-wrap::swig-lispify "btSimpleDynamicsWorld_setConstraintSolver" 'function) (ff-pointer self) solver))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-constraint-solver" 'method) ((self #.(bullet-wrap::swig-lispify "bt-simple-dynamics-world" 'classname)))
  (#.(bullet-wrap::swig-lispify "btSimpleDynamicsWorld_getConstraintSolver" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-world-type" 'method) ((self #.(bullet-wrap::swig-lispify "bt-simple-dynamics-world" 'classname)))
  (#.(bullet-wrap::swig-lispify "btSimpleDynamicsWorld_getWorldType" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "clear-forces" 'method) ((self #.(bullet-wrap::swig-lispify "bt-simple-dynamics-world" 'classname)))
  (#.(bullet-wrap::swig-lispify "btSimpleDynamicsWorld_clearForces" 'function) (ff-pointer self)))


(cl:defclass #.(bullet-wrap::swig-lispify "bt-rigid-body" 'classname)(#.(bullet-wrap::swig-lispify "btCollisionObject" 'classname))
  ((ff-pointer :reader ff-pointer)))

(cl:defmethod initialize-instance :after ((obj #.(bullet-wrap::swig-lispify "bt-rigid-body" 'class)) &key constructionInfo)
  (setf (slot-value obj 'ff-pointer) (#.(bullet-wrap::swig-lispify "new_btRigidBody" 'function) constructionInfo)))

(cl:defmethod initialize-instance :after ((obj #.(bullet-wrap::swig-lispify "bt-rigid-body" 'class)) &key (mass cl:number) (motionState #.(bullet-wrap::swig-lispify "bt-motion-state" 'classname)) collisionShape (localInertia #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)))
  (setf (slot-value obj 'ff-pointer) (#.(bullet-wrap::swig-lispify "new_btRigidBody" 'function) mass motionState collisionShape localInertia)))

(cl:defmethod initialize-instance :after ((obj #.(bullet-wrap::swig-lispify "bt-rigid-body" 'class)) &key (mass cl:number) (motionState #.(bullet-wrap::swig-lispify "bt-motion-state" 'classname)) collisionShape)
  (setf (slot-value obj 'ff-pointer) (#.(bullet-wrap::swig-lispify "new_btRigidBody" 'function) mass motionState collisionShape)))

(cl:defmethod #.(bullet-wrap::swig-lispify "proceed-to-transform" 'method) ((self #.(bullet-wrap::swig-lispify "bt-rigid-body" 'classname)) (newTrans #.(bullet-wrap::swig-lispify "bt-transform" 'classname)))
  (#.(bullet-wrap::swig-lispify "btRigidBody_proceedToTransform" 'function) (ff-pointer self) newTrans))

(cl:defmethod #.(bullet-wrap::swig-lispify "predict-integrated-transform" 'method) ((self #.(bullet-wrap::swig-lispify "bt-rigid-body" 'classname)) (step cl:number) (predictedTransform #.(bullet-wrap::swig-lispify "bt-transform" 'classname)))
  (#.(bullet-wrap::swig-lispify "btRigidBody_predictIntegratedTransform" 'function) (ff-pointer self) step predictedTransform))

(cl:defmethod #.(bullet-wrap::swig-lispify "save-kinematic-state" 'method) ((self #.(bullet-wrap::swig-lispify "bt-rigid-body" 'classname)) (step cl:number))
  (#.(bullet-wrap::swig-lispify "btRigidBody_saveKinematicState" 'function) (ff-pointer self) step))

(cl:defmethod #.(bullet-wrap::swig-lispify "apply-gravity" 'method) ((self #.(bullet-wrap::swig-lispify "bt-rigid-body" 'classname)))
  (#.(bullet-wrap::swig-lispify "btRigidBody_applyGravity" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "set-gravity" 'method) ((self #.(bullet-wrap::swig-lispify "bt-rigid-body" 'classname)) (acceleration #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)))
  (#.(bullet-wrap::swig-lispify "btRigidBody_setGravity" 'function) (ff-pointer self) acceleration))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-gravity" 'method) ((self #.(bullet-wrap::swig-lispify "bt-rigid-body" 'classname)))
  (#.(bullet-wrap::swig-lispify "btRigidBody_getGravity" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "set-damping" 'method) ((self #.(bullet-wrap::swig-lispify "bt-rigid-body" 'classname)) (lin_damping cl:number) (ang_damping cl:number))
  (#.(bullet-wrap::swig-lispify "btRigidBody_setDamping" 'function) (ff-pointer self) lin_damping ang_damping))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-linear-damping" 'method) ((self #.(bullet-wrap::swig-lispify "bt-rigid-body" 'classname)))
  (#.(bullet-wrap::swig-lispify "btRigidBody_getLinearDamping" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-angular-damping" 'method) ((self #.(bullet-wrap::swig-lispify "bt-rigid-body" 'classname)))
  (#.(bullet-wrap::swig-lispify "btRigidBody_getAngularDamping" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-linear-sleeping-threshold" 'method) ((self #.(bullet-wrap::swig-lispify "bt-rigid-body" 'classname)))
  (#.(bullet-wrap::swig-lispify "btRigidBody_getLinearSleepingThreshold" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-angular-sleeping-threshold" 'method) ((self #.(bullet-wrap::swig-lispify "bt-rigid-body" 'classname)))
  (#.(bullet-wrap::swig-lispify "btRigidBody_getAngularSleepingThreshold" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "apply-damping" 'method) ((self #.(bullet-wrap::swig-lispify "bt-rigid-body" 'classname)) (timeStep cl:number))
  (#.(bullet-wrap::swig-lispify "btRigidBody_applyDamping" 'function) (ff-pointer self) timeStep))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-collision-shape" 'method) ((self #.(bullet-wrap::swig-lispify "bt-rigid-body" 'classname)))
  (#.(bullet-wrap::swig-lispify "btRigidBody_getCollisionShape" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-collision-shape" 'method) ((self #.(bullet-wrap::swig-lispify "bt-rigid-body" 'classname)))
  (#.(bullet-wrap::swig-lispify "btRigidBody_getCollisionShape" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "set-mass-props" 'method) ((self #.(bullet-wrap::swig-lispify "bt-rigid-body" 'classname)) (mass cl:number) (inertia #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)))
  (#.(bullet-wrap::swig-lispify "btRigidBody_setMassProps" 'function) (ff-pointer self) mass inertia))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-linear-factor" 'method) ((self #.(bullet-wrap::swig-lispify "bt-rigid-body" 'classname)))
  (#.(bullet-wrap::swig-lispify "btRigidBody_getLinearFactor" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "set-linear-factor" 'method) ((self #.(bullet-wrap::swig-lispify "bt-rigid-body" 'classname)) (linearFactor #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)))
  (#.(bullet-wrap::swig-lispify "btRigidBody_setLinearFactor" 'function) (ff-pointer self) linearFactor))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-inv-mass" 'method) ((self #.(bullet-wrap::swig-lispify "bt-rigid-body" 'classname)))
  (#.(bullet-wrap::swig-lispify "btRigidBody_getInvMass" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-inv-inertia-tensor-world" 'method) ((self #.(bullet-wrap::swig-lispify "bt-rigid-body" 'classname)))
  (#.(bullet-wrap::swig-lispify "btRigidBody_getInvInertiaTensorWorld" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "integrate-velocities" 'method) ((self #.(bullet-wrap::swig-lispify "bt-rigid-body" 'classname)) (step cl:number))
  (#.(bullet-wrap::swig-lispify "btRigidBody_integrateVelocities" 'function) (ff-pointer self) step))

(cl:defmethod #.(bullet-wrap::swig-lispify "set-center-of-mass-transform" 'method) ((self #.(bullet-wrap::swig-lispify "bt-rigid-body" 'classname)) (xform #.(bullet-wrap::swig-lispify "bt-transform" 'classname)))
  (#.(bullet-wrap::swig-lispify "btRigidBody_setCenterOfMassTransform" 'function) (ff-pointer self) xform))

(cl:defmethod #.(bullet-wrap::swig-lispify "apply-central-force" 'method) ((self #.(bullet-wrap::swig-lispify "bt-rigid-body" 'classname)) (force #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)))
  (#.(bullet-wrap::swig-lispify "btRigidBody_applyCentralForce" 'function) (ff-pointer self) force))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-total-force" 'method) ((self #.(bullet-wrap::swig-lispify "bt-rigid-body" 'classname)))
  (#.(bullet-wrap::swig-lispify "btRigidBody_getTotalForce" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-total-torque" 'method) ((self #.(bullet-wrap::swig-lispify "bt-rigid-body" 'classname)))
  (#.(bullet-wrap::swig-lispify "btRigidBody_getTotalTorque" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-inv-inertia-diag-local" 'method) ((self #.(bullet-wrap::swig-lispify "bt-rigid-body" 'classname)))
  (#.(bullet-wrap::swig-lispify "btRigidBody_getInvInertiaDiagLocal" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "set-inv-inertia-diag-local" 'method) ((self #.(bullet-wrap::swig-lispify "bt-rigid-body" 'classname)) (diagInvInertia #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)))
  (#.(bullet-wrap::swig-lispify "btRigidBody_setInvInertiaDiagLocal" 'function) (ff-pointer self) diagInvInertia))

(cl:defmethod #.(bullet-wrap::swig-lispify "set-sleeping-thresholds" 'method) ((self #.(bullet-wrap::swig-lispify "bt-rigid-body" 'classname)) (linear cl:number) (angular cl:number))
  (#.(bullet-wrap::swig-lispify "btRigidBody_setSleepingThresholds" 'function) (ff-pointer self) linear angular))

(cl:defmethod #.(bullet-wrap::swig-lispify "apply-torque" 'method) ((self #.(bullet-wrap::swig-lispify "bt-rigid-body" 'classname)) (torque #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)))
  (#.(bullet-wrap::swig-lispify "btRigidBody_applyTorque" 'function) (ff-pointer self) torque))

(cl:defmethod #.(bullet-wrap::swig-lispify "apply-force" 'method) ((self #.(bullet-wrap::swig-lispify "bt-rigid-body" 'classname)) (force #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (rel_pos #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)))
  (#.(bullet-wrap::swig-lispify "btRigidBody_applyForce" 'function) (ff-pointer self) force rel_pos))

(cl:defmethod #.(bullet-wrap::swig-lispify "apply-central-impulse" 'method) ((self #.(bullet-wrap::swig-lispify "bt-rigid-body" 'classname)) (impulse #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)))
  (#.(bullet-wrap::swig-lispify "btRigidBody_applyCentralImpulse" 'function) (ff-pointer self) impulse))

(cl:defmethod #.(bullet-wrap::swig-lispify "apply-torque-impulse" 'method) ((self #.(bullet-wrap::swig-lispify "bt-rigid-body" 'classname)) (torque #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)))
  (#.(bullet-wrap::swig-lispify "btRigidBody_applyTorqueImpulse" 'function) (ff-pointer self) torque))

(cl:defmethod #.(bullet-wrap::swig-lispify "apply-impulse" 'method) ((self #.(bullet-wrap::swig-lispify "bt-rigid-body" 'classname)) (impulse #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (rel_pos #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)))
  (#.(bullet-wrap::swig-lispify "btRigidBody_applyImpulse" 'function) (ff-pointer self) impulse rel_pos))

(cl:defmethod #.(bullet-wrap::swig-lispify "clear-forces" 'method) ((self #.(bullet-wrap::swig-lispify "bt-rigid-body" 'classname)))
  (#.(bullet-wrap::swig-lispify "btRigidBody_clearForces" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "update-inertia-tensor" 'method) ((self #.(bullet-wrap::swig-lispify "bt-rigid-body" 'classname)))
  (#.(bullet-wrap::swig-lispify "btRigidBody_updateInertiaTensor" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-center-of-mass-position" 'method) ((self #.(bullet-wrap::swig-lispify "bt-rigid-body" 'classname)))
  (#.(bullet-wrap::swig-lispify "btRigidBody_getCenterOfMassPosition" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-orientation" 'method) ((self #.(bullet-wrap::swig-lispify "bt-rigid-body" 'classname)))
  (#.(bullet-wrap::swig-lispify "btRigidBody_getOrientation" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-center-of-mass-transform" 'method) ((self #.(bullet-wrap::swig-lispify "bt-rigid-body" 'classname)))
  (#.(bullet-wrap::swig-lispify "btRigidBody_getCenterOfMassTransform" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-linear-velocity" 'method) ((self #.(bullet-wrap::swig-lispify "bt-rigid-body" 'classname)))
  (#.(bullet-wrap::swig-lispify "btRigidBody_getLinearVelocity" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-angular-velocity" 'method) ((self #.(bullet-wrap::swig-lispify "bt-rigid-body" 'classname)))
  (#.(bullet-wrap::swig-lispify "btRigidBody_getAngularVelocity" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "set-linear-velocity" 'method) ((self #.(bullet-wrap::swig-lispify "bt-rigid-body" 'classname)) (lin_vel #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)))
  (#.(bullet-wrap::swig-lispify "btRigidBody_setLinearVelocity" 'function) (ff-pointer self) lin_vel))

(cl:defmethod #.(bullet-wrap::swig-lispify "set-angular-velocity" 'method) ((self #.(bullet-wrap::swig-lispify "bt-rigid-body" 'classname)) (ang_vel #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)))
  (#.(bullet-wrap::swig-lispify "btRigidBody_setAngularVelocity" 'function) (ff-pointer self) ang_vel))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-velocity-in-local-point" 'method) ((self #.(bullet-wrap::swig-lispify "bt-rigid-body" 'classname)) (rel_pos #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)))
  (#.(bullet-wrap::swig-lispify "btRigidBody_getVelocityInLocalPoint" 'function) (ff-pointer self) rel_pos))

(cl:defmethod #.(bullet-wrap::swig-lispify "translate" 'method) ((self #.(bullet-wrap::swig-lispify "bt-rigid-body" 'classname)) (v #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)))
  (#.(bullet-wrap::swig-lispify "btRigidBody_translate" 'function) (ff-pointer self) v))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-aabb" 'method) ((self #.(bullet-wrap::swig-lispify "bt-rigid-body" 'classname)) (aabbMin #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (aabbMax #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)))
  (#.(bullet-wrap::swig-lispify "btRigidBody_getAabb" 'function) (ff-pointer self) aabbMin aabbMax))

(cl:defmethod #.(bullet-wrap::swig-lispify "compute-impulse-denominator" 'method) ((self #.(bullet-wrap::swig-lispify "bt-rigid-body" 'classname)) (pos #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (normal #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)))
  (#.(bullet-wrap::swig-lispify "btRigidBody_computeImpulseDenominator" 'function) (ff-pointer self) pos normal))

(cl:defmethod #.(bullet-wrap::swig-lispify "compute-angular-impulse-denominator" 'method) ((self #.(bullet-wrap::swig-lispify "bt-rigid-body" 'classname)) (axis #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)))
  (#.(bullet-wrap::swig-lispify "btRigidBody_computeAngularImpulseDenominator" 'function) (ff-pointer self) axis))

(cl:defmethod #.(bullet-wrap::swig-lispify "update-deactivation" 'method) ((self #.(bullet-wrap::swig-lispify "bt-rigid-body" 'classname)) (timeStep cl:number))
  (#.(bullet-wrap::swig-lispify "btRigidBody_updateDeactivation" 'function) (ff-pointer self) timeStep))

(cl:defmethod #.(bullet-wrap::swig-lispify "wants-sleeping" 'method) ((self #.(bullet-wrap::swig-lispify "bt-rigid-body" 'classname)))
  (#.(bullet-wrap::swig-lispify "btRigidBody_wantsSleeping" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-broadphase-proxy" 'method) ((self #.(bullet-wrap::swig-lispify "bt-rigid-body" 'classname)))
  (#.(bullet-wrap::swig-lispify "btRigidBody_getBroadphaseProxy" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-broadphase-proxy" 'method) ((self #.(bullet-wrap::swig-lispify "bt-rigid-body" 'classname)))
  (#.(bullet-wrap::swig-lispify "btRigidBody_getBroadphaseProxy" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "set-new-broadphase-proxy" 'method) ((self #.(bullet-wrap::swig-lispify "bt-rigid-body" 'classname)) broadphaseProxy)
  (#.(bullet-wrap::swig-lispify "btRigidBody_setNewBroadphaseProxy" 'function) (ff-pointer self) broadphaseProxy))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-motion-state" 'method) ((self #.(bullet-wrap::swig-lispify "bt-rigid-body" 'classname)))
  (#.(bullet-wrap::swig-lispify "btRigidBody_getMotionState" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-motion-state" 'method) ((self #.(bullet-wrap::swig-lispify "bt-rigid-body" 'classname)))
  (#.(bullet-wrap::swig-lispify "btRigidBody_getMotionState" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "set-motion-state" 'method) ((self #.(bullet-wrap::swig-lispify "bt-rigid-body" 'classname)) (motionState #.(bullet-wrap::swig-lispify "bt-motion-state" 'classname)))
  (#.(bullet-wrap::swig-lispify "btRigidBody_setMotionState" 'function) (ff-pointer self) motionState))

(cl:defmethod (cl:setf #.(bullet-wrap::swig-lispify "m_contactSolverType" 'method)) (arg0 (obj #.(bullet-wrap::swig-lispify "bt-rigid-body" 'class)))
  (#.(bullet-wrap::swig-lispify "btRigidBody_m_contactSolverType_set" 'function) (ff-pointer obj) arg0))

(cl:defmethod #.(bullet-wrap::swig-lispify "m_contactSolverType" 'method) ((obj #.(bullet-wrap::swig-lispify "bt-rigid-body" 'class)))
  (#.(bullet-wrap::swig-lispify "btRigidBody_m_contactSolverType_get" 'function) (ff-pointer obj)))

(cl:defmethod (cl:setf #.(bullet-wrap::swig-lispify "m_frictionSolverType" 'method)) (arg0 (obj #.(bullet-wrap::swig-lispify "bt-rigid-body" 'class)))
  (#.(bullet-wrap::swig-lispify "btRigidBody_m_frictionSolverType_set" 'function) (ff-pointer obj) arg0))

(cl:defmethod #.(bullet-wrap::swig-lispify "m_frictionSolverType" 'method) ((obj #.(bullet-wrap::swig-lispify "bt-rigid-body" 'class)))
  (#.(bullet-wrap::swig-lispify "btRigidBody_m_frictionSolverType_get" 'function) (ff-pointer obj)))

(cl:defmethod #.(bullet-wrap::swig-lispify "set-angular-factor" 'method) ((self #.(bullet-wrap::swig-lispify "bt-rigid-body" 'classname)) (angFac #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)))
  (#.(bullet-wrap::swig-lispify "btRigidBody_setAngularFactor" 'function) (ff-pointer self) angFac))

(cl:defmethod #.(bullet-wrap::swig-lispify "set-angular-factor" 'method) ((self #.(bullet-wrap::swig-lispify "bt-rigid-body" 'classname)) (angFac cl:number))
  (#.(bullet-wrap::swig-lispify "btRigidBody_setAngularFactor" 'function) (ff-pointer self) angFac))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-angular-factor" 'method) ((self #.(bullet-wrap::swig-lispify "bt-rigid-body" 'classname)))
  (#.(bullet-wrap::swig-lispify "btRigidBody_getAngularFactor" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "is-in-world" 'method) ((self #.(bullet-wrap::swig-lispify "bt-rigid-body" 'classname)))
  (#.(bullet-wrap::swig-lispify "btRigidBody_isInWorld" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "check-collide-with-override" 'method) ((self #.(bullet-wrap::swig-lispify "bt-rigid-body" 'classname)) (co #.(bullet-wrap::swig-lispify "bt-collision-object" 'classname)))
  (#.(bullet-wrap::swig-lispify "btRigidBody_checkCollideWithOverride" 'function) (ff-pointer self) co))

(cl:defmethod #.(bullet-wrap::swig-lispify "add-constraint-ref" 'method) ((self #.(bullet-wrap::swig-lispify "bt-rigid-body" 'classname)) c)
  (#.(bullet-wrap::swig-lispify "btRigidBody_addConstraintRef" 'function) (ff-pointer self) c))

(cl:defmethod #.(bullet-wrap::swig-lispify "remove-constraint-ref" 'method) ((self #.(bullet-wrap::swig-lispify "bt-rigid-body" 'classname)) c)
  (#.(bullet-wrap::swig-lispify "btRigidBody_removeConstraintRef" 'function) (ff-pointer self) c))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-constraint-ref" 'method) ((self #.(bullet-wrap::swig-lispify "bt-rigid-body" 'classname)) (index cl:integer))
  (#.(bullet-wrap::swig-lispify "btRigidBody_getConstraintRef" 'function) (ff-pointer self) index))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-num-constraint-refs" 'method) ((self #.(bullet-wrap::swig-lispify "bt-rigid-body" 'classname)))
  (#.(bullet-wrap::swig-lispify "btRigidBody_getNumConstraintRefs" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "set-flags" 'method) ((self #.(bullet-wrap::swig-lispify "bt-rigid-body" 'classname)) (flags cl:integer))
  (#.(bullet-wrap::swig-lispify "btRigidBody_setFlags" 'function) (ff-pointer self) flags))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-flags" 'method) ((self #.(bullet-wrap::swig-lispify "bt-rigid-body" 'classname)))
  (#.(bullet-wrap::swig-lispify "btRigidBody_getFlags" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "compute-gyroscopic-force" 'method) ((self #.(bullet-wrap::swig-lispify "bt-rigid-body" 'classname)) (maxGyroscopicForce cl:number))
  (#.(bullet-wrap::swig-lispify "btRigidBody_computeGyroscopicForce" 'function) (ff-pointer self) maxGyroscopicForce))

(cl:defmethod #.(bullet-wrap::swig-lispify "calculate-serialize-buffer-size" 'method) ((self #.(bullet-wrap::swig-lispify "bt-rigid-body" 'classname)))
  (#.(bullet-wrap::swig-lispify "btRigidBody_calculateSerializeBufferSize" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "serialize" 'method) ((self #.(bullet-wrap::swig-lispify "bt-rigid-body" 'classname)) dataBuffer (serializer #.(bullet-wrap::swig-lispify "bt-serializer" 'classname)))
  (#.(bullet-wrap::swig-lispify "btRigidBody_serialize" 'function) (ff-pointer self) dataBuffer serializer))

(cl:defmethod #.(bullet-wrap::swig-lispify "serialize-single-object" 'method) ((self #.(bullet-wrap::swig-lispify "bt-rigid-body" 'classname)) (serializer #.(bullet-wrap::swig-lispify "bt-serializer" 'classname)))
  (#.(bullet-wrap::swig-lispify "btRigidBody_serializeSingleObject" 'function) (ff-pointer self) serializer))


(cl:defclass #.(bullet-wrap::swig-lispify "bt-typed-constraint" 'classname)(#.(bullet-wrap::swig-lispify "btTypedObject" 'classname))
  ((ff-pointer :reader ff-pointer)))

(cl:shadow "new")
(cl:defmethod #.(bullet-wrap::swig-lispify "new" 'method) ((self #.(bullet-wrap::swig-lispify "bt-typed-constraint" 'classname)) sizeInBytes)
  (#.(bullet-wrap::swig-lispify "btTypedConstraint_makeCPlusPlusInstance" 'function) (ff-pointer self) sizeInBytes))

(cl:shadow "delete")
(cl:defmethod #.(bullet-wrap::swig-lispify "delete" 'method) ((self #.(bullet-wrap::swig-lispify "bt-typed-constraint" 'classname)) ptr)
  (#.(bullet-wrap::swig-lispify "btTypedConstraint_deleteCPlusPlusInstance" 'function) (ff-pointer self) ptr))

(cl:shadow "new")
(cl:defmethod #.(bullet-wrap::swig-lispify "new" 'method) ((self #.(bullet-wrap::swig-lispify "bt-typed-constraint" 'classname)) arg1 ptr)
  (#.(bullet-wrap::swig-lispify "btTypedConstraint_makeCPlusPlusInstance" 'function) (ff-pointer self) arg1 ptr))

(cl:shadow "delete")
(cl:defmethod #.(bullet-wrap::swig-lispify "delete" 'method) ((self #.(bullet-wrap::swig-lispify "bt-typed-constraint" 'classname)) arg1 arg2)
  (#.(bullet-wrap::swig-lispify "btTypedConstraint_deleteCPlusPlusInstance" 'function) (ff-pointer self) arg1 arg2))

(cl:shadow "new[]")
(cl:defmethod #.(bullet-wrap::swig-lispify "new[]" 'method) ((self #.(bullet-wrap::swig-lispify "bt-typed-constraint" 'classname)) sizeInBytes)
  (#.(bullet-wrap::swig-lispify "btTypedConstraint_makeCPlusArray" 'function) (ff-pointer self) sizeInBytes))

(cl:shadow "delete[]")
(cl:defmethod #.(bullet-wrap::swig-lispify "delete[]" 'method) ((self #.(bullet-wrap::swig-lispify "bt-typed-constraint" 'classname)) ptr)
  (#.(bullet-wrap::swig-lispify "btTypedConstraint_deleteCPlusArray" 'function) (ff-pointer self) ptr))

(cl:shadow "new[]")
(cl:defmethod #.(bullet-wrap::swig-lispify "new[]" 'method) ((self #.(bullet-wrap::swig-lispify "bt-typed-constraint" 'classname)) arg1 ptr)
  (#.(bullet-wrap::swig-lispify "btTypedConstraint_makeCPlusArray" 'function) (ff-pointer self) arg1 ptr))

(cl:shadow "delete[]")
(cl:defmethod #.(bullet-wrap::swig-lispify "delete[]" 'method) ((self #.(bullet-wrap::swig-lispify "bt-typed-constraint" 'classname)) arg1 arg2)
  (#.(bullet-wrap::swig-lispify "btTypedConstraint_deleteCPlusArray" 'function) (ff-pointer self) arg1 arg2))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-override-num-solver-iterations" 'method) ((self #.(bullet-wrap::swig-lispify "bt-typed-constraint" 'classname)))
  (#.(bullet-wrap::swig-lispify "btTypedConstraint_getOverrideNumSolverIterations" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "set-override-num-solver-iterations" 'method) ((self #.(bullet-wrap::swig-lispify "bt-typed-constraint" 'classname)) (overideNumIterations cl:integer))
  (#.(bullet-wrap::swig-lispify "btTypedConstraint_setOverrideNumSolverIterations" 'function) (ff-pointer self) overideNumIterations))

(cl:defmethod #.(bullet-wrap::swig-lispify "build-jacobian" 'method) ((self #.(bullet-wrap::swig-lispify "bt-typed-constraint" 'classname)))
  (#.(bullet-wrap::swig-lispify "btTypedConstraint_buildJacobian" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "setup-solver-constraint" 'method) ((self #.(bullet-wrap::swig-lispify "bt-typed-constraint" 'classname)) ca (solverBodyA cl:integer) (solverBodyB cl:integer) (timeStep cl:number))
  (#.(bullet-wrap::swig-lispify "btTypedConstraint_setupSolverConstraint" 'function) (ff-pointer self) ca solverBodyA solverBodyB timeStep))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-info1" 'method) ((self #.(bullet-wrap::swig-lispify "bt-typed-constraint" 'classname)) info)
  (#.(bullet-wrap::swig-lispify "btTypedConstraint_getInfo1" 'function) (ff-pointer self) info))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-info2" 'method) ((self #.(bullet-wrap::swig-lispify "bt-typed-constraint" 'classname)) info)
  (#.(bullet-wrap::swig-lispify "btTypedConstraint_getInfo2" 'function) (ff-pointer self) info))

(cl:defmethod #.(bullet-wrap::swig-lispify "internal-set-applied-impulse" 'method) ((self #.(bullet-wrap::swig-lispify "bt-typed-constraint" 'classname)) (appliedImpulse cl:number))
  (#.(bullet-wrap::swig-lispify "btTypedConstraint_internalSetAppliedImpulse" 'function) (ff-pointer self) appliedImpulse))

(cl:defmethod #.(bullet-wrap::swig-lispify "internal-get-applied-impulse" 'method) ((self #.(bullet-wrap::swig-lispify "bt-typed-constraint" 'classname)))
  (#.(bullet-wrap::swig-lispify "btTypedConstraint_internalGetAppliedImpulse" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-breaking-impulse-threshold" 'method) ((self #.(bullet-wrap::swig-lispify "bt-typed-constraint" 'classname)))
  (#.(bullet-wrap::swig-lispify "btTypedConstraint_getBreakingImpulseThreshold" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "set-breaking-impulse-threshold" 'method) ((self #.(bullet-wrap::swig-lispify "bt-typed-constraint" 'classname)) (threshold cl:number))
  (#.(bullet-wrap::swig-lispify "btTypedConstraint_setBreakingImpulseThreshold" 'function) (ff-pointer self) threshold))

(cl:defmethod #.(bullet-wrap::swig-lispify "is-enabled" 'method) ((self #.(bullet-wrap::swig-lispify "bt-typed-constraint" 'classname)))
  (#.(bullet-wrap::swig-lispify "btTypedConstraint_isEnabled" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "set-enabled" 'method) ((self #.(bullet-wrap::swig-lispify "bt-typed-constraint" 'classname)) (enabled t))
  (#.(bullet-wrap::swig-lispify "btTypedConstraint_setEnabled" 'function) (ff-pointer self) enabled))

(cl:defmethod #.(bullet-wrap::swig-lispify "solve-constraint-obsolete" 'method) ((self #.(bullet-wrap::swig-lispify "bt-typed-constraint" 'classname)) arg1 arg2 (arg3 cl:number))
  (#.(bullet-wrap::swig-lispify "btTypedConstraint_solveConstraintObsolete" 'function) (ff-pointer self) arg1 arg2 arg3))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-rigid-body-a" 'method) ((self #.(bullet-wrap::swig-lispify "bt-typed-constraint" 'classname)))
  (#.(bullet-wrap::swig-lispify "btTypedConstraint_getRigidBodyA" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-rigid-body-b" 'method) ((self #.(bullet-wrap::swig-lispify "bt-typed-constraint" 'classname)))
  (#.(bullet-wrap::swig-lispify "btTypedConstraint_getRigidBodyB" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-rigid-body-a" 'method) ((self #.(bullet-wrap::swig-lispify "bt-typed-constraint" 'classname)))
  (#.(bullet-wrap::swig-lispify "btTypedConstraint_getRigidBodyA" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-rigid-body-b" 'method) ((self #.(bullet-wrap::swig-lispify "bt-typed-constraint" 'classname)))
  (#.(bullet-wrap::swig-lispify "btTypedConstraint_getRigidBodyB" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-user-constraint-type" 'method) ((self #.(bullet-wrap::swig-lispify "bt-typed-constraint" 'classname)))
  (#.(bullet-wrap::swig-lispify "btTypedConstraint_getUserConstraintType" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "set-user-constraint-type" 'method) ((self #.(bullet-wrap::swig-lispify "bt-typed-constraint" 'classname)) (userConstraintType cl:integer))
  (#.(bullet-wrap::swig-lispify "btTypedConstraint_setUserConstraintType" 'function) (ff-pointer self) userConstraintType))

(cl:defmethod #.(bullet-wrap::swig-lispify "set-user-constraint-id" 'method) ((self #.(bullet-wrap::swig-lispify "bt-typed-constraint" 'classname)) (uid cl:integer))
  (#.(bullet-wrap::swig-lispify "btTypedConstraint_setUserConstraintId" 'function) (ff-pointer self) uid))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-user-constraint-id" 'method) ((self #.(bullet-wrap::swig-lispify "bt-typed-constraint" 'classname)))
  (#.(bullet-wrap::swig-lispify "btTypedConstraint_getUserConstraintId" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "set-user-constraint-ptr" 'method) ((self #.(bullet-wrap::swig-lispify "bt-typed-constraint" 'classname)) ptr)
  (#.(bullet-wrap::swig-lispify "btTypedConstraint_setUserConstraintPtr" 'function) (ff-pointer self) ptr))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-user-constraint-ptr" 'method) ((self #.(bullet-wrap::swig-lispify "bt-typed-constraint" 'classname)))
  (#.(bullet-wrap::swig-lispify "btTypedConstraint_getUserConstraintPtr" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "set-joint-feedback" 'method) ((self #.(bullet-wrap::swig-lispify "bt-typed-constraint" 'classname)) jointFeedback)
  (#.(bullet-wrap::swig-lispify "btTypedConstraint_setJointFeedback" 'function) (ff-pointer self) jointFeedback))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-joint-feedback" 'method) ((self #.(bullet-wrap::swig-lispify "bt-typed-constraint" 'classname)))
  (#.(bullet-wrap::swig-lispify "btTypedConstraint_getJointFeedback" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-joint-feedback" 'method) ((self #.(bullet-wrap::swig-lispify "bt-typed-constraint" 'classname)))
  (#.(bullet-wrap::swig-lispify "btTypedConstraint_getJointFeedback" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-uid" 'method) ((self #.(bullet-wrap::swig-lispify "bt-typed-constraint" 'classname)))
  (#.(bullet-wrap::swig-lispify "btTypedConstraint_getUid" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "needs-feedback" 'method) ((self #.(bullet-wrap::swig-lispify "bt-typed-constraint" 'classname)))
  (#.(bullet-wrap::swig-lispify "btTypedConstraint_needsFeedback" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "enable-feedback" 'method) ((self #.(bullet-wrap::swig-lispify "bt-typed-constraint" 'classname)) (needsFeedback t))
  (#.(bullet-wrap::swig-lispify "btTypedConstraint_enableFeedback" 'function) (ff-pointer self) needsFeedback))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-applied-impulse" 'method) ((self #.(bullet-wrap::swig-lispify "bt-typed-constraint" 'classname)))
  (#.(bullet-wrap::swig-lispify "btTypedConstraint_getAppliedImpulse" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-constraint-type" 'method) ((self #.(bullet-wrap::swig-lispify "bt-typed-constraint" 'classname)))
  (#.(bullet-wrap::swig-lispify "btTypedConstraint_getConstraintType" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "set-dbg-draw-size" 'method) ((self #.(bullet-wrap::swig-lispify "bt-typed-constraint" 'classname)) (dbgDrawSize cl:number))
  (#.(bullet-wrap::swig-lispify "btTypedConstraint_setDbgDrawSize" 'function) (ff-pointer self) dbgDrawSize))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-dbg-draw-size" 'method) ((self #.(bullet-wrap::swig-lispify "bt-typed-constraint" 'classname)))
  (#.(bullet-wrap::swig-lispify "btTypedConstraint_getDbgDrawSize" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "set-param" 'method) ((self #.(bullet-wrap::swig-lispify "bt-typed-constraint" 'classname)) (num cl:integer) (value cl:number) (axis cl:integer))
  (#.(bullet-wrap::swig-lispify "btTypedConstraint_setParam" 'function) (ff-pointer self) num value axis))

(cl:defmethod #.(bullet-wrap::swig-lispify "set-param" 'method) ((self #.(bullet-wrap::swig-lispify "bt-typed-constraint" 'classname)) (num cl:integer) (value cl:number))
  (#.(bullet-wrap::swig-lispify "btTypedConstraint_setParam" 'function) (ff-pointer self) num value))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-param" 'method) ((self #.(bullet-wrap::swig-lispify "bt-typed-constraint" 'classname)) (num cl:integer) (axis cl:integer))
  (#.(bullet-wrap::swig-lispify "btTypedConstraint_getParam" 'function) (ff-pointer self) num axis))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-param" 'method) ((self #.(bullet-wrap::swig-lispify "bt-typed-constraint" 'classname)) (num cl:integer))
  (#.(bullet-wrap::swig-lispify "btTypedConstraint_getParam" 'function) (ff-pointer self) num))

(cl:defmethod #.(bullet-wrap::swig-lispify "calculate-serialize-buffer-size" 'method) ((self #.(bullet-wrap::swig-lispify "bt-typed-constraint" 'classname)))
  (#.(bullet-wrap::swig-lispify "btTypedConstraint_calculateSerializeBufferSize" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "serialize" 'method) ((self #.(bullet-wrap::swig-lispify "bt-typed-constraint" 'classname)) dataBuffer (serializer #.(bullet-wrap::swig-lispify "bt-serializer" 'classname)))
  (#.(bullet-wrap::swig-lispify "btTypedConstraint_serialize" 'function) (ff-pointer self) dataBuffer serializer))


(cl:defclass #.(bullet-wrap::swig-lispify "bt-angular-limit" 'classname)()
  ((ff-pointer :reader ff-pointer)))

(cl:defmethod initialize-instance :after ((obj #.(bullet-wrap::swig-lispify "bt-angular-limit" 'class)) &key)
  (setf (slot-value obj 'ff-pointer) (#.(bullet-wrap::swig-lispify "new_btAngularLimit" 'function))))

(cl:defmethod #.(bullet-wrap::swig-lispify "set" 'method) ((self #.(bullet-wrap::swig-lispify "bt-angular-limit" 'classname)) (low cl:number) (high cl:number) (_softness cl:number) (_biasFactor cl:number) (_relaxationFactor cl:number))
  (#.(bullet-wrap::swig-lispify "btAngularLimit_set" 'function) (ff-pointer self) low high _softness _biasFactor _relaxationFactor))

(cl:defmethod #.(bullet-wrap::swig-lispify "set" 'method) ((self #.(bullet-wrap::swig-lispify "bt-angular-limit" 'classname)) (low cl:number) (high cl:number) (_softness cl:number) (_biasFactor cl:number))
  (#.(bullet-wrap::swig-lispify "btAngularLimit_set" 'function) (ff-pointer self) low high _softness _biasFactor))

(cl:defmethod #.(bullet-wrap::swig-lispify "set" 'method) ((self #.(bullet-wrap::swig-lispify "bt-angular-limit" 'classname)) (low cl:number) (high cl:number) (_softness cl:number))
  (#.(bullet-wrap::swig-lispify "btAngularLimit_set" 'function) (ff-pointer self) low high _softness))

(cl:defmethod #.(bullet-wrap::swig-lispify "set" 'method) ((self #.(bullet-wrap::swig-lispify "bt-angular-limit" 'classname)) (low cl:number) (high cl:number))
  (#.(bullet-wrap::swig-lispify "btAngularLimit_set" 'function) (ff-pointer self) low high))

(cl:defmethod #.(bullet-wrap::swig-lispify "test" 'method) ((self #.(bullet-wrap::swig-lispify "bt-angular-limit" 'classname)) (angle cl:number))
  (#.(bullet-wrap::swig-lispify "btAngularLimit_test" 'function) (ff-pointer self) angle))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-softness" 'method) ((self #.(bullet-wrap::swig-lispify "bt-angular-limit" 'classname)))
  (#.(bullet-wrap::swig-lispify "btAngularLimit_getSoftness" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-bias-factor" 'method) ((self #.(bullet-wrap::swig-lispify "bt-angular-limit" 'classname)))
  (#.(bullet-wrap::swig-lispify "btAngularLimit_getBiasFactor" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-relaxation-factor" 'method) ((self #.(bullet-wrap::swig-lispify "bt-angular-limit" 'classname)))
  (#.(bullet-wrap::swig-lispify "btAngularLimit_getRelaxationFactor" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-correction" 'method) ((self #.(bullet-wrap::swig-lispify "bt-angular-limit" 'classname)))
  (#.(bullet-wrap::swig-lispify "btAngularLimit_getCorrection" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-sign" 'method) ((self #.(bullet-wrap::swig-lispify "bt-angular-limit" 'classname)))
  (#.(bullet-wrap::swig-lispify "btAngularLimit_getSign" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-half-range" 'method) ((self #.(bullet-wrap::swig-lispify "bt-angular-limit" 'classname)))
  (#.(bullet-wrap::swig-lispify "btAngularLimit_getHalfRange" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "is-limit" 'method) ((self #.(bullet-wrap::swig-lispify "bt-angular-limit" 'classname)))
  (#.(bullet-wrap::swig-lispify "btAngularLimit_isLimit" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "fit" 'method) ((self #.(bullet-wrap::swig-lispify "bt-angular-limit" 'classname)) angle)
  (#.(bullet-wrap::swig-lispify "btAngularLimit_fit" 'function) (ff-pointer self) angle))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-error" 'method) ((self #.(bullet-wrap::swig-lispify "bt-angular-limit" 'classname)))
  (#.(bullet-wrap::swig-lispify "btAngularLimit_getError" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-low" 'method) ((self #.(bullet-wrap::swig-lispify "bt-angular-limit" 'classname)))
  (#.(bullet-wrap::swig-lispify "btAngularLimit_getLow" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-high" 'method) ((self #.(bullet-wrap::swig-lispify "bt-angular-limit" 'classname)))
  (#.(bullet-wrap::swig-lispify "btAngularLimit_getHigh" 'function) (ff-pointer self)))


(cl:defclass #.(bullet-wrap::swig-lispify "bt-point2-point-constraint" 'classname)(#.(bullet-wrap::swig-lispify "btTypedConstraint" 'classname))
  ((ff-pointer :reader ff-pointer)))

(cl:shadow "new")
(cl:defmethod #.(bullet-wrap::swig-lispify "new" 'method) ((self #.(bullet-wrap::swig-lispify "bt-point2-point-constraint" 'classname)) sizeInBytes)
  (#.(bullet-wrap::swig-lispify "btPoint2PointConstraint_makeCPlusPlusInstance" 'function) (ff-pointer self) sizeInBytes))

(cl:shadow "delete")
(cl:defmethod #.(bullet-wrap::swig-lispify "delete" 'method) ((self #.(bullet-wrap::swig-lispify "bt-point2-point-constraint" 'classname)) ptr)
  (#.(bullet-wrap::swig-lispify "btPoint2PointConstraint_deleteCPlusPlusInstance" 'function) (ff-pointer self) ptr))

(cl:shadow "new")
(cl:defmethod #.(bullet-wrap::swig-lispify "new" 'method) ((self #.(bullet-wrap::swig-lispify "bt-point2-point-constraint" 'classname)) arg1 ptr)
  (#.(bullet-wrap::swig-lispify "btPoint2PointConstraint_makeCPlusPlusInstance" 'function) (ff-pointer self) arg1 ptr))

(cl:shadow "delete")
(cl:defmethod #.(bullet-wrap::swig-lispify "delete" 'method) ((self #.(bullet-wrap::swig-lispify "bt-point2-point-constraint" 'classname)) arg1 arg2)
  (#.(bullet-wrap::swig-lispify "btPoint2PointConstraint_deleteCPlusPlusInstance" 'function) (ff-pointer self) arg1 arg2))

(cl:shadow "new[]")
(cl:defmethod #.(bullet-wrap::swig-lispify "new[]" 'method) ((self #.(bullet-wrap::swig-lispify "bt-point2-point-constraint" 'classname)) sizeInBytes)
  (#.(bullet-wrap::swig-lispify "btPoint2PointConstraint_makeCPlusArray" 'function) (ff-pointer self) sizeInBytes))

(cl:shadow "delete[]")
(cl:defmethod #.(bullet-wrap::swig-lispify "delete[]" 'method) ((self #.(bullet-wrap::swig-lispify "bt-point2-point-constraint" 'classname)) ptr)
  (#.(bullet-wrap::swig-lispify "btPoint2PointConstraint_deleteCPlusArray" 'function) (ff-pointer self) ptr))

(cl:shadow "new[]")
(cl:defmethod #.(bullet-wrap::swig-lispify "new[]" 'method) ((self #.(bullet-wrap::swig-lispify "bt-point2-point-constraint" 'classname)) arg1 ptr)
  (#.(bullet-wrap::swig-lispify "btPoint2PointConstraint_makeCPlusArray" 'function) (ff-pointer self) arg1 ptr))

(cl:shadow "delete[]")
(cl:defmethod #.(bullet-wrap::swig-lispify "delete[]" 'method) ((self #.(bullet-wrap::swig-lispify "bt-point2-point-constraint" 'classname)) arg1 arg2)
  (#.(bullet-wrap::swig-lispify "btPoint2PointConstraint_deleteCPlusArray" 'function) (ff-pointer self) arg1 arg2))

(cl:defmethod (cl:setf #.(bullet-wrap::swig-lispify "m_useSolveConstraintObsolete" 'method)) (arg0 (obj #.(bullet-wrap::swig-lispify "bt-point2-point-constraint" 'class)))
  (#.(bullet-wrap::swig-lispify "btPoint2PointConstraint_m_useSolveConstraintObsolete_set" 'function) (ff-pointer obj) arg0))

(cl:defmethod #.(bullet-wrap::swig-lispify "m_useSolveConstraintObsolete" 'method) ((obj #.(bullet-wrap::swig-lispify "bt-point2-point-constraint" 'class)))
  (#.(bullet-wrap::swig-lispify "btPoint2PointConstraint_m_useSolveConstraintObsolete_get" 'function) (ff-pointer obj)))

(cl:defmethod (cl:setf #.(bullet-wrap::swig-lispify "m_setting" 'method)) (arg0 (obj #.(bullet-wrap::swig-lispify "bt-point2-point-constraint" 'class)))
  (#.(bullet-wrap::swig-lispify "btPoint2PointConstraint_m_setting_set" 'function) (ff-pointer obj) arg0))

(cl:defmethod #.(bullet-wrap::swig-lispify "m_setting" 'method) ((obj #.(bullet-wrap::swig-lispify "bt-point2-point-constraint" 'class)))
  (#.(bullet-wrap::swig-lispify "btPoint2PointConstraint_m_setting_get" 'function) (ff-pointer obj)))

(cl:defmethod initialize-instance :after ((obj #.(bullet-wrap::swig-lispify "bt-point2-point-constraint" 'class)) &key (rbA #.(bullet-wrap::swig-lispify "bt-rigid-body" 'classname)) (rbB #.(bullet-wrap::swig-lispify "bt-rigid-body" 'classname)) (pivotInA #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (pivotInB #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)))
  (setf (slot-value obj 'ff-pointer) (#.(bullet-wrap::swig-lispify "new_btPoint2PointConstraint" 'function) rbA rbB pivotInA pivotInB)))

(cl:defmethod initialize-instance :after ((obj #.(bullet-wrap::swig-lispify "bt-point2-point-constraint" 'class)) &key (rbA #.(bullet-wrap::swig-lispify "bt-rigid-body" 'classname)) (pivotInA #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)))
  (setf (slot-value obj 'ff-pointer) (#.(bullet-wrap::swig-lispify "new_btPoint2PointConstraint" 'function) rbA pivotInA)))

(cl:defmethod #.(bullet-wrap::swig-lispify "build-jacobian" 'method) ((self #.(bullet-wrap::swig-lispify "bt-point2-point-constraint" 'classname)))
  (#.(bullet-wrap::swig-lispify "btPoint2PointConstraint_buildJacobian" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-info1" 'method) ((self #.(bullet-wrap::swig-lispify "bt-point2-point-constraint" 'classname)) info)
  (#.(bullet-wrap::swig-lispify "btPoint2PointConstraint_getInfo1" 'function) (ff-pointer self) info))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-info1-non-virtual" 'method) ((self #.(bullet-wrap::swig-lispify "bt-point2-point-constraint" 'classname)) info)
  (#.(bullet-wrap::swig-lispify "btPoint2PointConstraint_getInfo1NonVirtual" 'function) (ff-pointer self) info))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-info2" 'method) ((self #.(bullet-wrap::swig-lispify "bt-point2-point-constraint" 'classname)) info)
  (#.(bullet-wrap::swig-lispify "btPoint2PointConstraint_getInfo2" 'function) (ff-pointer self) info))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-info2-non-virtual" 'method) ((self #.(bullet-wrap::swig-lispify "bt-point2-point-constraint" 'classname)) info (body0_trans #.(bullet-wrap::swig-lispify "bt-transform" 'classname)) (body1_trans #.(bullet-wrap::swig-lispify "bt-transform" 'classname)))
  (#.(bullet-wrap::swig-lispify "btPoint2PointConstraint_getInfo2NonVirtual" 'function) (ff-pointer self) info body0_trans body1_trans))

(cl:defmethod #.(bullet-wrap::swig-lispify "update-rhs" 'method) ((self #.(bullet-wrap::swig-lispify "bt-point2-point-constraint" 'classname)) (timeStep cl:number))
  (#.(bullet-wrap::swig-lispify "btPoint2PointConstraint_updateRHS" 'function) (ff-pointer self) timeStep))

(cl:defmethod #.(bullet-wrap::swig-lispify "set-pivot-a" 'method) ((self #.(bullet-wrap::swig-lispify "bt-point2-point-constraint" 'classname)) (pivotA #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)))
  (#.(bullet-wrap::swig-lispify "btPoint2PointConstraint_setPivotA" 'function) (ff-pointer self) pivotA))

(cl:defmethod #.(bullet-wrap::swig-lispify "set-pivot-b" 'method) ((self #.(bullet-wrap::swig-lispify "bt-point2-point-constraint" 'classname)) (pivotB #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)))
  (#.(bullet-wrap::swig-lispify "btPoint2PointConstraint_setPivotB" 'function) (ff-pointer self) pivotB))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-pivot-in-a" 'method) ((self #.(bullet-wrap::swig-lispify "bt-point2-point-constraint" 'classname)))
  (#.(bullet-wrap::swig-lispify "btPoint2PointConstraint_getPivotInA" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-pivot-in-b" 'method) ((self #.(bullet-wrap::swig-lispify "bt-point2-point-constraint" 'classname)))
  (#.(bullet-wrap::swig-lispify "btPoint2PointConstraint_getPivotInB" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "set-param" 'method) ((self #.(bullet-wrap::swig-lispify "bt-point2-point-constraint" 'classname)) (num cl:integer) (value cl:number) (axis cl:integer))
  (#.(bullet-wrap::swig-lispify "btPoint2PointConstraint_setParam" 'function) (ff-pointer self) num value axis))

(cl:defmethod #.(bullet-wrap::swig-lispify "set-param" 'method) ((self #.(bullet-wrap::swig-lispify "bt-point2-point-constraint" 'classname)) (num cl:integer) (value cl:number))
  (#.(bullet-wrap::swig-lispify "btPoint2PointConstraint_setParam" 'function) (ff-pointer self) num value))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-param" 'method) ((self #.(bullet-wrap::swig-lispify "bt-point2-point-constraint" 'classname)) (num cl:integer) (axis cl:integer))
  (#.(bullet-wrap::swig-lispify "btPoint2PointConstraint_getParam" 'function) (ff-pointer self) num axis))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-param" 'method) ((self #.(bullet-wrap::swig-lispify "bt-point2-point-constraint" 'classname)) (num cl:integer))
  (#.(bullet-wrap::swig-lispify "btPoint2PointConstraint_getParam" 'function) (ff-pointer self) num))

(cl:defmethod #.(bullet-wrap::swig-lispify "calculate-serialize-buffer-size" 'method) ((self #.(bullet-wrap::swig-lispify "bt-point2-point-constraint" 'classname)))
  (#.(bullet-wrap::swig-lispify "btPoint2PointConstraint_calculateSerializeBufferSize" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "serialize" 'method) ((self #.(bullet-wrap::swig-lispify "bt-point2-point-constraint" 'classname)) dataBuffer (serializer #.(bullet-wrap::swig-lispify "bt-serializer" 'classname)))
  (#.(bullet-wrap::swig-lispify "btPoint2PointConstraint_serialize" 'function) (ff-pointer self) dataBuffer serializer))


(cl:defclass #.(bullet-wrap::swig-lispify "bt-hinge-constraint" 'classname)(#.(bullet-wrap::swig-lispify "btTypedConstraint" 'classname))
  ((ff-pointer :reader ff-pointer)))

(cl:shadow "new")
(cl:defmethod #.(bullet-wrap::swig-lispify "new" 'method) ((self #.(bullet-wrap::swig-lispify "bt-hinge-constraint" 'classname)) sizeInBytes)
  (#.(bullet-wrap::swig-lispify "btHingeConstraint_makeCPlusPlusInstance" 'function) (ff-pointer self) sizeInBytes))

(cl:shadow "delete")
(cl:defmethod #.(bullet-wrap::swig-lispify "delete" 'method) ((self #.(bullet-wrap::swig-lispify "bt-hinge-constraint" 'classname)) ptr)
  (#.(bullet-wrap::swig-lispify "btHingeConstraint_deleteCPlusPlusInstance" 'function) (ff-pointer self) ptr))

(cl:shadow "new")
(cl:defmethod #.(bullet-wrap::swig-lispify "new" 'method) ((self #.(bullet-wrap::swig-lispify "bt-hinge-constraint" 'classname)) arg1 ptr)
  (#.(bullet-wrap::swig-lispify "btHingeConstraint_makeCPlusPlusInstance" 'function) (ff-pointer self) arg1 ptr))

(cl:shadow "delete")
(cl:defmethod #.(bullet-wrap::swig-lispify "delete" 'method) ((self #.(bullet-wrap::swig-lispify "bt-hinge-constraint" 'classname)) arg1 arg2)
  (#.(bullet-wrap::swig-lispify "btHingeConstraint_deleteCPlusPlusInstance" 'function) (ff-pointer self) arg1 arg2))

(cl:shadow "new[]")
(cl:defmethod #.(bullet-wrap::swig-lispify "new[]" 'method) ((self #.(bullet-wrap::swig-lispify "bt-hinge-constraint" 'classname)) sizeInBytes)
  (#.(bullet-wrap::swig-lispify "btHingeConstraint_makeCPlusArray" 'function) (ff-pointer self) sizeInBytes))

(cl:shadow "delete[]")
(cl:defmethod #.(bullet-wrap::swig-lispify "delete[]" 'method) ((self #.(bullet-wrap::swig-lispify "bt-hinge-constraint" 'classname)) ptr)
  (#.(bullet-wrap::swig-lispify "btHingeConstraint_deleteCPlusArray" 'function) (ff-pointer self) ptr))

(cl:shadow "new[]")
(cl:defmethod #.(bullet-wrap::swig-lispify "new[]" 'method) ((self #.(bullet-wrap::swig-lispify "bt-hinge-constraint" 'classname)) arg1 ptr)
  (#.(bullet-wrap::swig-lispify "btHingeConstraint_makeCPlusArray" 'function) (ff-pointer self) arg1 ptr))

(cl:shadow "delete[]")
(cl:defmethod #.(bullet-wrap::swig-lispify "delete[]" 'method) ((self #.(bullet-wrap::swig-lispify "bt-hinge-constraint" 'classname)) arg1 arg2)
  (#.(bullet-wrap::swig-lispify "btHingeConstraint_deleteCPlusArray" 'function) (ff-pointer self) arg1 arg2))

(cl:defmethod initialize-instance :after ((obj #.(bullet-wrap::swig-lispify "bt-hinge-constraint" 'class)) &key (rbA #.(bullet-wrap::swig-lispify "bt-rigid-body" 'classname)) (rbB #.(bullet-wrap::swig-lispify "bt-rigid-body" 'classname)) (pivotInA #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (pivotInB #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (axisInA #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (axisInB #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (useReferenceFrameA t))
  (setf (slot-value obj 'ff-pointer) (#.(bullet-wrap::swig-lispify "new_btHingeConstraint" 'function) rbA rbB pivotInA pivotInB axisInA axisInB useReferenceFrameA)))

(cl:defmethod initialize-instance :after ((obj #.(bullet-wrap::swig-lispify "bt-hinge-constraint" 'class)) &key (rbA #.(bullet-wrap::swig-lispify "bt-rigid-body" 'classname)) (rbB #.(bullet-wrap::swig-lispify "bt-rigid-body" 'classname)) (pivotInA #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (pivotInB #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (axisInA #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (axisInB #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)))
  (setf (slot-value obj 'ff-pointer) (#.(bullet-wrap::swig-lispify "new_btHingeConstraint" 'function) rbA rbB pivotInA pivotInB axisInA axisInB)))

(cl:defmethod initialize-instance :after ((obj #.(bullet-wrap::swig-lispify "bt-hinge-constraint" 'class)) &key (rbA #.(bullet-wrap::swig-lispify "bt-rigid-body" 'classname)) (pivotInA #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (axisInA #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (useReferenceFrameA t))
  (setf (slot-value obj 'ff-pointer) (#.(bullet-wrap::swig-lispify "new_btHingeConstraint" 'function) rbA pivotInA axisInA useReferenceFrameA)))

(cl:defmethod initialize-instance :after ((obj #.(bullet-wrap::swig-lispify "bt-hinge-constraint" 'class)) &key (rbA #.(bullet-wrap::swig-lispify "bt-rigid-body" 'classname)) (pivotInA #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (axisInA #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)))
  (setf (slot-value obj 'ff-pointer) (#.(bullet-wrap::swig-lispify "new_btHingeConstraint" 'function) rbA pivotInA axisInA)))

(cl:defmethod initialize-instance :after ((obj #.(bullet-wrap::swig-lispify "bt-hinge-constraint" 'class)) &key (rbA #.(bullet-wrap::swig-lispify "bt-rigid-body" 'classname)) (rbB #.(bullet-wrap::swig-lispify "bt-rigid-body" 'classname)) (rbAFrame #.(bullet-wrap::swig-lispify "bt-transform" 'classname)) (rbBFrame #.(bullet-wrap::swig-lispify "bt-transform" 'classname)) (useReferenceFrameA t))
  (setf (slot-value obj 'ff-pointer) (#.(bullet-wrap::swig-lispify "new_btHingeConstraint" 'function) rbA rbB rbAFrame rbBFrame useReferenceFrameA)))

(cl:defmethod initialize-instance :after ((obj #.(bullet-wrap::swig-lispify "bt-hinge-constraint" 'class)) &key (rbA #.(bullet-wrap::swig-lispify "bt-rigid-body" 'classname)) (rbB #.(bullet-wrap::swig-lispify "bt-rigid-body" 'classname)) (rbAFrame #.(bullet-wrap::swig-lispify "bt-transform" 'classname)) (rbBFrame #.(bullet-wrap::swig-lispify "bt-transform" 'classname)))
  (setf (slot-value obj 'ff-pointer) (#.(bullet-wrap::swig-lispify "new_btHingeConstraint" 'function) rbA rbB rbAFrame rbBFrame)))

(cl:defmethod initialize-instance :after ((obj #.(bullet-wrap::swig-lispify "bt-hinge-constraint" 'class)) &key (rbA #.(bullet-wrap::swig-lispify "bt-rigid-body" 'classname)) (rbAFrame #.(bullet-wrap::swig-lispify "bt-transform" 'classname)) (useReferenceFrameA t))
  (setf (slot-value obj 'ff-pointer) (#.(bullet-wrap::swig-lispify "new_btHingeConstraint" 'function) rbA rbAFrame useReferenceFrameA)))

(cl:defmethod initialize-instance :after ((obj #.(bullet-wrap::swig-lispify "bt-hinge-constraint" 'class)) &key (rbA #.(bullet-wrap::swig-lispify "bt-rigid-body" 'classname)) (rbAFrame #.(bullet-wrap::swig-lispify "bt-transform" 'classname)))
  (setf (slot-value obj 'ff-pointer) (#.(bullet-wrap::swig-lispify "new_btHingeConstraint" 'function) rbA rbAFrame)))

(cl:defmethod #.(bullet-wrap::swig-lispify "build-jacobian" 'method) ((self #.(bullet-wrap::swig-lispify "bt-hinge-constraint" 'classname)))
  (#.(bullet-wrap::swig-lispify "btHingeConstraint_buildJacobian" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-info1" 'method) ((self #.(bullet-wrap::swig-lispify "bt-hinge-constraint" 'classname)) info)
  (#.(bullet-wrap::swig-lispify "btHingeConstraint_getInfo1" 'function) (ff-pointer self) info))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-info1-non-virtual" 'method) ((self #.(bullet-wrap::swig-lispify "bt-hinge-constraint" 'classname)) info)
  (#.(bullet-wrap::swig-lispify "btHingeConstraint_getInfo1NonVirtual" 'function) (ff-pointer self) info))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-info2" 'method) ((self #.(bullet-wrap::swig-lispify "bt-hinge-constraint" 'classname)) info)
  (#.(bullet-wrap::swig-lispify "btHingeConstraint_getInfo2" 'function) (ff-pointer self) info))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-info2-non-virtual" 'method) ((self #.(bullet-wrap::swig-lispify "bt-hinge-constraint" 'classname)) info (transA #.(bullet-wrap::swig-lispify "bt-transform" 'classname)) (transB #.(bullet-wrap::swig-lispify "bt-transform" 'classname)) (angVelA #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (angVelB #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)))
  (#.(bullet-wrap::swig-lispify "btHingeConstraint_getInfo2NonVirtual" 'function) (ff-pointer self) info transA transB angVelA angVelB))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-info2-internal" 'method) ((self #.(bullet-wrap::swig-lispify "bt-hinge-constraint" 'classname)) info (transA #.(bullet-wrap::swig-lispify "bt-transform" 'classname)) (transB #.(bullet-wrap::swig-lispify "bt-transform" 'classname)) (angVelA #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (angVelB #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)))
  (#.(bullet-wrap::swig-lispify "btHingeConstraint_getInfo2Internal" 'function) (ff-pointer self) info transA transB angVelA angVelB))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-info2-internal-using-frame-offset" 'method) ((self #.(bullet-wrap::swig-lispify "bt-hinge-constraint" 'classname)) info (transA #.(bullet-wrap::swig-lispify "bt-transform" 'classname)) (transB #.(bullet-wrap::swig-lispify "bt-transform" 'classname)) (angVelA #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (angVelB #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)))
  (#.(bullet-wrap::swig-lispify "btHingeConstraint_getInfo2InternalUsingFrameOffset" 'function) (ff-pointer self) info transA transB angVelA angVelB))

(cl:defmethod #.(bullet-wrap::swig-lispify "update-rhs" 'method) ((self #.(bullet-wrap::swig-lispify "bt-hinge-constraint" 'classname)) (timeStep cl:number))
  (#.(bullet-wrap::swig-lispify "btHingeConstraint_updateRHS" 'function) (ff-pointer self) timeStep))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-rigid-body-a" 'method) ((self #.(bullet-wrap::swig-lispify "bt-hinge-constraint" 'classname)))
  (#.(bullet-wrap::swig-lispify "btHingeConstraint_getRigidBodyA" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-rigid-body-b" 'method) ((self #.(bullet-wrap::swig-lispify "bt-hinge-constraint" 'classname)))
  (#.(bullet-wrap::swig-lispify "btHingeConstraint_getRigidBodyB" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-rigid-body-a" 'method) ((self #.(bullet-wrap::swig-lispify "bt-hinge-constraint" 'classname)))
  (#.(bullet-wrap::swig-lispify "btHingeConstraint_getRigidBodyA" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-rigid-body-b" 'method) ((self #.(bullet-wrap::swig-lispify "bt-hinge-constraint" 'classname)))
  (#.(bullet-wrap::swig-lispify "btHingeConstraint_getRigidBodyB" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-frame-offset-a" 'method) ((self #.(bullet-wrap::swig-lispify "bt-hinge-constraint" 'classname)))
  (#.(bullet-wrap::swig-lispify "btHingeConstraint_getFrameOffsetA" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-frame-offset-b" 'method) ((self #.(bullet-wrap::swig-lispify "bt-hinge-constraint" 'classname)))
  (#.(bullet-wrap::swig-lispify "btHingeConstraint_getFrameOffsetB" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "set-frames" 'method) ((self #.(bullet-wrap::swig-lispify "bt-hinge-constraint" 'classname)) (frameA #.(bullet-wrap::swig-lispify "bt-transform" 'classname)) (frameB #.(bullet-wrap::swig-lispify "bt-transform" 'classname)))
  (#.(bullet-wrap::swig-lispify "btHingeConstraint_setFrames" 'function) (ff-pointer self) frameA frameB))

(cl:defmethod #.(bullet-wrap::swig-lispify "set-angular-only" 'method) ((self #.(bullet-wrap::swig-lispify "bt-hinge-constraint" 'classname)) (angularOnly t))
  (#.(bullet-wrap::swig-lispify "btHingeConstraint_setAngularOnly" 'function) (ff-pointer self) angularOnly))

(cl:defmethod #.(bullet-wrap::swig-lispify "enable-angular-motor" 'method) ((self #.(bullet-wrap::swig-lispify "bt-hinge-constraint" 'classname)) (enableMotor t) (targetVelocity cl:number) (maxMotorImpulse cl:number))
  (#.(bullet-wrap::swig-lispify "btHingeConstraint_enableAngularMotor" 'function) (ff-pointer self) enableMotor targetVelocity maxMotorImpulse))

(cl:defmethod #.(bullet-wrap::swig-lispify "enable-motor" 'method) ((self #.(bullet-wrap::swig-lispify "bt-hinge-constraint" 'classname)) (enableMotor t))
  (#.(bullet-wrap::swig-lispify "btHingeConstraint_enableMotor" 'function) (ff-pointer self) enableMotor))

(cl:defmethod #.(bullet-wrap::swig-lispify "set-max-motor-impulse" 'method) ((self #.(bullet-wrap::swig-lispify "bt-hinge-constraint" 'classname)) (maxMotorImpulse cl:number))
  (#.(bullet-wrap::swig-lispify "btHingeConstraint_setMaxMotorImpulse" 'function) (ff-pointer self) maxMotorImpulse))

(cl:defmethod #.(bullet-wrap::swig-lispify "set-motor-target" 'method) ((self #.(bullet-wrap::swig-lispify "bt-hinge-constraint" 'classname)) (qAinB #.(bullet-wrap::swig-lispify "bt-quaternion" 'classname)) (dt cl:number))
  (#.(bullet-wrap::swig-lispify "btHingeConstraint_setMotorTarget" 'function) (ff-pointer self) qAinB dt))

(cl:defmethod #.(bullet-wrap::swig-lispify "set-motor-target" 'method) ((self #.(bullet-wrap::swig-lispify "bt-hinge-constraint" 'classname)) (targetAngle cl:number) (dt cl:number))
  (#.(bullet-wrap::swig-lispify "btHingeConstraint_setMotorTarget" 'function) (ff-pointer self) targetAngle dt))

(cl:defmethod #.(bullet-wrap::swig-lispify "set-limit" 'method) ((self #.(bullet-wrap::swig-lispify "bt-hinge-constraint" 'classname)) (low cl:number) (high cl:number) (_softness cl:number) (_biasFactor cl:number) (_relaxationFactor cl:number))
  (#.(bullet-wrap::swig-lispify "btHingeConstraint_setLimit" 'function) (ff-pointer self) low high _softness _biasFactor _relaxationFactor))

(cl:defmethod #.(bullet-wrap::swig-lispify "set-limit" 'method) ((self #.(bullet-wrap::swig-lispify "bt-hinge-constraint" 'classname)) (low cl:number) (high cl:number) (_softness cl:number) (_biasFactor cl:number))
  (#.(bullet-wrap::swig-lispify "btHingeConstraint_setLimit" 'function) (ff-pointer self) low high _softness _biasFactor))

(cl:defmethod #.(bullet-wrap::swig-lispify "set-limit" 'method) ((self #.(bullet-wrap::swig-lispify "bt-hinge-constraint" 'classname)) (low cl:number) (high cl:number) (_softness cl:number))
  (#.(bullet-wrap::swig-lispify "btHingeConstraint_setLimit" 'function) (ff-pointer self) low high _softness))

(cl:defmethod #.(bullet-wrap::swig-lispify "set-limit" 'method) ((self #.(bullet-wrap::swig-lispify "bt-hinge-constraint" 'classname)) (low cl:number) (high cl:number))
  (#.(bullet-wrap::swig-lispify "btHingeConstraint_setLimit" 'function) (ff-pointer self) low high))

(cl:defmethod #.(bullet-wrap::swig-lispify "set-axis" 'method) ((self #.(bullet-wrap::swig-lispify "bt-hinge-constraint" 'classname)) (axisInA #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)))
  (#.(bullet-wrap::swig-lispify "btHingeConstraint_setAxis" 'function) (ff-pointer self) axisInA))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-lower-limit" 'method) ((self #.(bullet-wrap::swig-lispify "bt-hinge-constraint" 'classname)))
  (#.(bullet-wrap::swig-lispify "btHingeConstraint_getLowerLimit" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-upper-limit" 'method) ((self #.(bullet-wrap::swig-lispify "bt-hinge-constraint" 'classname)))
  (#.(bullet-wrap::swig-lispify "btHingeConstraint_getUpperLimit" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-hinge-angle" 'method) ((self #.(bullet-wrap::swig-lispify "bt-hinge-constraint" 'classname)))
  (#.(bullet-wrap::swig-lispify "btHingeConstraint_getHingeAngle" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-hinge-angle" 'method) ((self #.(bullet-wrap::swig-lispify "bt-hinge-constraint" 'classname)) (transA #.(bullet-wrap::swig-lispify "bt-transform" 'classname)) (transB #.(bullet-wrap::swig-lispify "bt-transform" 'classname)))
  (#.(bullet-wrap::swig-lispify "btHingeConstraint_getHingeAngle" 'function) (ff-pointer self) transA transB))

(cl:defmethod #.(bullet-wrap::swig-lispify "test-limit" 'method) ((self #.(bullet-wrap::swig-lispify "bt-hinge-constraint" 'classname)) (transA #.(bullet-wrap::swig-lispify "bt-transform" 'classname)) (transB #.(bullet-wrap::swig-lispify "bt-transform" 'classname)))
  (#.(bullet-wrap::swig-lispify "btHingeConstraint_testLimit" 'function) (ff-pointer self) transA transB))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-aframe" 'method) ((self #.(bullet-wrap::swig-lispify "bt-hinge-constraint" 'classname)))
  (#.(bullet-wrap::swig-lispify "btHingeConstraint_getAFrame" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-bframe" 'method) ((self #.(bullet-wrap::swig-lispify "bt-hinge-constraint" 'classname)))
  (#.(bullet-wrap::swig-lispify "btHingeConstraint_getBFrame" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-aframe" 'method) ((self #.(bullet-wrap::swig-lispify "bt-hinge-constraint" 'classname)))
  (#.(bullet-wrap::swig-lispify "btHingeConstraint_getAFrame" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-bframe" 'method) ((self #.(bullet-wrap::swig-lispify "bt-hinge-constraint" 'classname)))
  (#.(bullet-wrap::swig-lispify "btHingeConstraint_getBFrame" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-solve-limit" 'method) ((self #.(bullet-wrap::swig-lispify "bt-hinge-constraint" 'classname)))
  (#.(bullet-wrap::swig-lispify "btHingeConstraint_getSolveLimit" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-limit-sign" 'method) ((self #.(bullet-wrap::swig-lispify "bt-hinge-constraint" 'classname)))
  (#.(bullet-wrap::swig-lispify "btHingeConstraint_getLimitSign" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-angular-only" 'method) ((self #.(bullet-wrap::swig-lispify "bt-hinge-constraint" 'classname)))
  (#.(bullet-wrap::swig-lispify "btHingeConstraint_getAngularOnly" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-enable-angular-motor" 'method) ((self #.(bullet-wrap::swig-lispify "bt-hinge-constraint" 'classname)))
  (#.(bullet-wrap::swig-lispify "btHingeConstraint_getEnableAngularMotor" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-motor-target-velosity" 'method) ((self #.(bullet-wrap::swig-lispify "bt-hinge-constraint" 'classname)))
  (#.(bullet-wrap::swig-lispify "btHingeConstraint_getMotorTargetVelosity" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-max-motor-impulse" 'method) ((self #.(bullet-wrap::swig-lispify "bt-hinge-constraint" 'classname)))
  (#.(bullet-wrap::swig-lispify "btHingeConstraint_getMaxMotorImpulse" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-use-frame-offset" 'method) ((self #.(bullet-wrap::swig-lispify "bt-hinge-constraint" 'classname)))
  (#.(bullet-wrap::swig-lispify "btHingeConstraint_getUseFrameOffset" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "set-use-frame-offset" 'method) ((self #.(bullet-wrap::swig-lispify "bt-hinge-constraint" 'classname)) (frameOffsetOnOff t))
  (#.(bullet-wrap::swig-lispify "btHingeConstraint_setUseFrameOffset" 'function) (ff-pointer self) frameOffsetOnOff))

(cl:defmethod #.(bullet-wrap::swig-lispify "set-param" 'method) ((self #.(bullet-wrap::swig-lispify "bt-hinge-constraint" 'classname)) (num cl:integer) (value cl:number) (axis cl:integer))
  (#.(bullet-wrap::swig-lispify "btHingeConstraint_setParam" 'function) (ff-pointer self) num value axis))

(cl:defmethod #.(bullet-wrap::swig-lispify "set-param" 'method) ((self #.(bullet-wrap::swig-lispify "bt-hinge-constraint" 'classname)) (num cl:integer) (value cl:number))
  (#.(bullet-wrap::swig-lispify "btHingeConstraint_setParam" 'function) (ff-pointer self) num value))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-param" 'method) ((self #.(bullet-wrap::swig-lispify "bt-hinge-constraint" 'classname)) (num cl:integer) (axis cl:integer))
  (#.(bullet-wrap::swig-lispify "btHingeConstraint_getParam" 'function) (ff-pointer self) num axis))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-param" 'method) ((self #.(bullet-wrap::swig-lispify "bt-hinge-constraint" 'classname)) (num cl:integer))
  (#.(bullet-wrap::swig-lispify "btHingeConstraint_getParam" 'function) (ff-pointer self) num))

(cl:defmethod #.(bullet-wrap::swig-lispify "calculate-serialize-buffer-size" 'method) ((self #.(bullet-wrap::swig-lispify "bt-hinge-constraint" 'classname)))
  (#.(bullet-wrap::swig-lispify "btHingeConstraint_calculateSerializeBufferSize" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "serialize" 'method) ((self #.(bullet-wrap::swig-lispify "bt-hinge-constraint" 'classname)) dataBuffer (serializer #.(bullet-wrap::swig-lispify "bt-serializer" 'classname)))
  (#.(bullet-wrap::swig-lispify "btHingeConstraint_serialize" 'function) (ff-pointer self) dataBuffer serializer))


(cl:defclass #.(bullet-wrap::swig-lispify "bt-cone-twist-constraint" 'classname)(#.(bullet-wrap::swig-lispify "btTypedConstraint" 'classname))
  ((ff-pointer :reader ff-pointer)))

(cl:shadow "new")
(cl:defmethod #.(bullet-wrap::swig-lispify "new" 'method) ((self #.(bullet-wrap::swig-lispify "bt-cone-twist-constraint" 'classname)) sizeInBytes)
  (#.(bullet-wrap::swig-lispify "btConeTwistConstraint_makeCPlusPlusInstance" 'function) (ff-pointer self) sizeInBytes))

(cl:shadow "delete")
(cl:defmethod #.(bullet-wrap::swig-lispify "delete" 'method) ((self #.(bullet-wrap::swig-lispify "bt-cone-twist-constraint" 'classname)) ptr)
  (#.(bullet-wrap::swig-lispify "btConeTwistConstraint_deleteCPlusPlusInstance" 'function) (ff-pointer self) ptr))

(cl:shadow "new")
(cl:defmethod #.(bullet-wrap::swig-lispify "new" 'method) ((self #.(bullet-wrap::swig-lispify "bt-cone-twist-constraint" 'classname)) arg1 ptr)
  (#.(bullet-wrap::swig-lispify "btConeTwistConstraint_makeCPlusPlusInstance" 'function) (ff-pointer self) arg1 ptr))

(cl:shadow "delete")
(cl:defmethod #.(bullet-wrap::swig-lispify "delete" 'method) ((self #.(bullet-wrap::swig-lispify "bt-cone-twist-constraint" 'classname)) arg1 arg2)
  (#.(bullet-wrap::swig-lispify "btConeTwistConstraint_deleteCPlusPlusInstance" 'function) (ff-pointer self) arg1 arg2))

(cl:shadow "new[]")
(cl:defmethod #.(bullet-wrap::swig-lispify "new[]" 'method) ((self #.(bullet-wrap::swig-lispify "bt-cone-twist-constraint" 'classname)) sizeInBytes)
  (#.(bullet-wrap::swig-lispify "btConeTwistConstraint_makeCPlusArray" 'function) (ff-pointer self) sizeInBytes))

(cl:shadow "delete[]")
(cl:defmethod #.(bullet-wrap::swig-lispify "delete[]" 'method) ((self #.(bullet-wrap::swig-lispify "bt-cone-twist-constraint" 'classname)) ptr)
  (#.(bullet-wrap::swig-lispify "btConeTwistConstraint_deleteCPlusArray" 'function) (ff-pointer self) ptr))

(cl:shadow "new[]")
(cl:defmethod #.(bullet-wrap::swig-lispify "new[]" 'method) ((self #.(bullet-wrap::swig-lispify "bt-cone-twist-constraint" 'classname)) arg1 ptr)
  (#.(bullet-wrap::swig-lispify "btConeTwistConstraint_makeCPlusArray" 'function) (ff-pointer self) arg1 ptr))

(cl:shadow "delete[]")
(cl:defmethod #.(bullet-wrap::swig-lispify "delete[]" 'method) ((self #.(bullet-wrap::swig-lispify "bt-cone-twist-constraint" 'classname)) arg1 arg2)
  (#.(bullet-wrap::swig-lispify "btConeTwistConstraint_deleteCPlusArray" 'function) (ff-pointer self) arg1 arg2))

(cl:defmethod initialize-instance :after ((obj #.(bullet-wrap::swig-lispify "bt-cone-twist-constraint" 'class)) &key (rbA #.(bullet-wrap::swig-lispify "bt-rigid-body" 'classname)) (rbB #.(bullet-wrap::swig-lispify "bt-rigid-body" 'classname)) (rbAFrame #.(bullet-wrap::swig-lispify "bt-transform" 'classname)) (rbBFrame #.(bullet-wrap::swig-lispify "bt-transform" 'classname)))
  (setf (slot-value obj 'ff-pointer) (#.(bullet-wrap::swig-lispify "new_btConeTwistConstraint" 'function) rbA rbB rbAFrame rbBFrame)))

(cl:defmethod initialize-instance :after ((obj #.(bullet-wrap::swig-lispify "bt-cone-twist-constraint" 'class)) &key (rbA #.(bullet-wrap::swig-lispify "bt-rigid-body" 'classname)) (rbAFrame #.(bullet-wrap::swig-lispify "bt-transform" 'classname)))
  (setf (slot-value obj 'ff-pointer) (#.(bullet-wrap::swig-lispify "new_btConeTwistConstraint" 'function) rbA rbAFrame)))

(cl:defmethod #.(bullet-wrap::swig-lispify "build-jacobian" 'method) ((self #.(bullet-wrap::swig-lispify "bt-cone-twist-constraint" 'classname)))
  (#.(bullet-wrap::swig-lispify "btConeTwistConstraint_buildJacobian" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-info1" 'method) ((self #.(bullet-wrap::swig-lispify "bt-cone-twist-constraint" 'classname)) info)
  (#.(bullet-wrap::swig-lispify "btConeTwistConstraint_getInfo1" 'function) (ff-pointer self) info))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-info1-non-virtual" 'method) ((self #.(bullet-wrap::swig-lispify "bt-cone-twist-constraint" 'classname)) info)
  (#.(bullet-wrap::swig-lispify "btConeTwistConstraint_getInfo1NonVirtual" 'function) (ff-pointer self) info))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-info2" 'method) ((self #.(bullet-wrap::swig-lispify "bt-cone-twist-constraint" 'classname)) info)
  (#.(bullet-wrap::swig-lispify "btConeTwistConstraint_getInfo2" 'function) (ff-pointer self) info))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-info2-non-virtual" 'method) ((self #.(bullet-wrap::swig-lispify "bt-cone-twist-constraint" 'classname)) info (transA #.(bullet-wrap::swig-lispify "bt-transform" 'classname)) (transB #.(bullet-wrap::swig-lispify "bt-transform" 'classname)) (invInertiaWorldA #.(bullet-wrap::swig-lispify "bt-matrix3x3" 'classname)) (invInertiaWorldB #.(bullet-wrap::swig-lispify "bt-matrix3x3" 'classname)))
  (#.(bullet-wrap::swig-lispify "btConeTwistConstraint_getInfo2NonVirtual" 'function) (ff-pointer self) info transA transB invInertiaWorldA invInertiaWorldB))

(cl:defmethod #.(bullet-wrap::swig-lispify "solve-constraint-obsolete" 'method) ((self #.(bullet-wrap::swig-lispify "bt-cone-twist-constraint" 'classname)) bodyA bodyB (timeStep cl:number))
  (#.(bullet-wrap::swig-lispify "btConeTwistConstraint_solveConstraintObsolete" 'function) (ff-pointer self) bodyA bodyB timeStep))

(cl:defmethod #.(bullet-wrap::swig-lispify "update-rhs" 'method) ((self #.(bullet-wrap::swig-lispify "bt-cone-twist-constraint" 'classname)) (timeStep cl:number))
  (#.(bullet-wrap::swig-lispify "btConeTwistConstraint_updateRHS" 'function) (ff-pointer self) timeStep))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-rigid-body-a" 'method) ((self #.(bullet-wrap::swig-lispify "bt-cone-twist-constraint" 'classname)))
  (#.(bullet-wrap::swig-lispify "btConeTwistConstraint_getRigidBodyA" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-rigid-body-b" 'method) ((self #.(bullet-wrap::swig-lispify "bt-cone-twist-constraint" 'classname)))
  (#.(bullet-wrap::swig-lispify "btConeTwistConstraint_getRigidBodyB" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "set-angular-only" 'method) ((self #.(bullet-wrap::swig-lispify "bt-cone-twist-constraint" 'classname)) (angularOnly t))
  (#.(bullet-wrap::swig-lispify "btConeTwistConstraint_setAngularOnly" 'function) (ff-pointer self) angularOnly))

(cl:defmethod #.(bullet-wrap::swig-lispify "set-limit" 'method) ((self #.(bullet-wrap::swig-lispify "bt-cone-twist-constraint" 'classname)) (limitIndex cl:integer) (limitValue cl:number))
  (#.(bullet-wrap::swig-lispify "btConeTwistConstraint_setLimit" 'function) (ff-pointer self) limitIndex limitValue))

(cl:defmethod #.(bullet-wrap::swig-lispify "set-limit" 'method) ((self #.(bullet-wrap::swig-lispify "bt-cone-twist-constraint" 'classname)) (_swingSpan1 cl:number) (_swingSpan2 cl:number) (_twistSpan cl:number) (_softness cl:number) (_biasFactor cl:number) (_relaxationFactor cl:number))
  (#.(bullet-wrap::swig-lispify "btConeTwistConstraint_setLimit" 'function) (ff-pointer self) _swingSpan1 _swingSpan2 _twistSpan _softness _biasFactor _relaxationFactor))

(cl:defmethod #.(bullet-wrap::swig-lispify "set-limit" 'method) ((self #.(bullet-wrap::swig-lispify "bt-cone-twist-constraint" 'classname)) (_swingSpan1 cl:number) (_swingSpan2 cl:number) (_twistSpan cl:number) (_softness cl:number) (_biasFactor cl:number))
  (#.(bullet-wrap::swig-lispify "btConeTwistConstraint_setLimit" 'function) (ff-pointer self) _swingSpan1 _swingSpan2 _twistSpan _softness _biasFactor))

(cl:defmethod #.(bullet-wrap::swig-lispify "set-limit" 'method) ((self #.(bullet-wrap::swig-lispify "bt-cone-twist-constraint" 'classname)) (_swingSpan1 cl:number) (_swingSpan2 cl:number) (_twistSpan cl:number) (_softness cl:number))
  (#.(bullet-wrap::swig-lispify "btConeTwistConstraint_setLimit" 'function) (ff-pointer self) _swingSpan1 _swingSpan2 _twistSpan _softness))

(cl:defmethod #.(bullet-wrap::swig-lispify "set-limit" 'method) ((self #.(bullet-wrap::swig-lispify "bt-cone-twist-constraint" 'classname)) (_swingSpan1 cl:number) (_swingSpan2 cl:number) (_twistSpan cl:number))
  (#.(bullet-wrap::swig-lispify "btConeTwistConstraint_setLimit" 'function) (ff-pointer self) _swingSpan1 _swingSpan2 _twistSpan))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-aframe" 'method) ((self #.(bullet-wrap::swig-lispify "bt-cone-twist-constraint" 'classname)))
  (#.(bullet-wrap::swig-lispify "btConeTwistConstraint_getAFrame" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-bframe" 'method) ((self #.(bullet-wrap::swig-lispify "bt-cone-twist-constraint" 'classname)))
  (#.(bullet-wrap::swig-lispify "btConeTwistConstraint_getBFrame" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-solve-twist-limit" 'method) ((self #.(bullet-wrap::swig-lispify "bt-cone-twist-constraint" 'classname)))
  (#.(bullet-wrap::swig-lispify "btConeTwistConstraint_getSolveTwistLimit" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-solve-swing-limit" 'method) ((self #.(bullet-wrap::swig-lispify "bt-cone-twist-constraint" 'classname)))
  (#.(bullet-wrap::swig-lispify "btConeTwistConstraint_getSolveSwingLimit" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-twist-limit-sign" 'method) ((self #.(bullet-wrap::swig-lispify "bt-cone-twist-constraint" 'classname)))
  (#.(bullet-wrap::swig-lispify "btConeTwistConstraint_getTwistLimitSign" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "calc-angle-info" 'method) ((self #.(bullet-wrap::swig-lispify "bt-cone-twist-constraint" 'classname)))
  (#.(bullet-wrap::swig-lispify "btConeTwistConstraint_calcAngleInfo" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "calc-angle-info2" 'method) ((self #.(bullet-wrap::swig-lispify "bt-cone-twist-constraint" 'classname)) (transA #.(bullet-wrap::swig-lispify "bt-transform" 'classname)) (transB #.(bullet-wrap::swig-lispify "bt-transform" 'classname)) (invInertiaWorldA #.(bullet-wrap::swig-lispify "bt-matrix3x3" 'classname)) (invInertiaWorldB #.(bullet-wrap::swig-lispify "bt-matrix3x3" 'classname)))
  (#.(bullet-wrap::swig-lispify "btConeTwistConstraint_calcAngleInfo2" 'function) (ff-pointer self) transA transB invInertiaWorldA invInertiaWorldB))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-swing-span1" 'method) ((self #.(bullet-wrap::swig-lispify "bt-cone-twist-constraint" 'classname)))
  (#.(bullet-wrap::swig-lispify "btConeTwistConstraint_getSwingSpan1" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-swing-span2" 'method) ((self #.(bullet-wrap::swig-lispify "bt-cone-twist-constraint" 'classname)))
  (#.(bullet-wrap::swig-lispify "btConeTwistConstraint_getSwingSpan2" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-twist-span" 'method) ((self #.(bullet-wrap::swig-lispify "bt-cone-twist-constraint" 'classname)))
  (#.(bullet-wrap::swig-lispify "btConeTwistConstraint_getTwistSpan" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-twist-angle" 'method) ((self #.(bullet-wrap::swig-lispify "bt-cone-twist-constraint" 'classname)))
  (#.(bullet-wrap::swig-lispify "btConeTwistConstraint_getTwistAngle" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "is-past-swing-limit" 'method) ((self #.(bullet-wrap::swig-lispify "bt-cone-twist-constraint" 'classname)))
  (#.(bullet-wrap::swig-lispify "btConeTwistConstraint_isPastSwingLimit" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "set-damping" 'method) ((self #.(bullet-wrap::swig-lispify "bt-cone-twist-constraint" 'classname)) (damping cl:number))
  (#.(bullet-wrap::swig-lispify "btConeTwistConstraint_setDamping" 'function) (ff-pointer self) damping))

(cl:defmethod #.(bullet-wrap::swig-lispify "enable-motor" 'method) ((self #.(bullet-wrap::swig-lispify "bt-cone-twist-constraint" 'classname)) (b t))
  (#.(bullet-wrap::swig-lispify "btConeTwistConstraint_enableMotor" 'function) (ff-pointer self) b))

(cl:defmethod #.(bullet-wrap::swig-lispify "set-max-motor-impulse" 'method) ((self #.(bullet-wrap::swig-lispify "bt-cone-twist-constraint" 'classname)) (maxMotorImpulse cl:number))
  (#.(bullet-wrap::swig-lispify "btConeTwistConstraint_setMaxMotorImpulse" 'function) (ff-pointer self) maxMotorImpulse))

(cl:defmethod #.(bullet-wrap::swig-lispify "set-max-motor-impulse-normalized" 'method) ((self #.(bullet-wrap::swig-lispify "bt-cone-twist-constraint" 'classname)) (maxMotorImpulse cl:number))
  (#.(bullet-wrap::swig-lispify "btConeTwistConstraint_setMaxMotorImpulseNormalized" 'function) (ff-pointer self) maxMotorImpulse))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-fix-thresh" 'method) ((self #.(bullet-wrap::swig-lispify "bt-cone-twist-constraint" 'classname)))
  (#.(bullet-wrap::swig-lispify "btConeTwistConstraint_getFixThresh" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "set-fix-thresh" 'method) ((self #.(bullet-wrap::swig-lispify "bt-cone-twist-constraint" 'classname)) (fixThresh cl:number))
  (#.(bullet-wrap::swig-lispify "btConeTwistConstraint_setFixThresh" 'function) (ff-pointer self) fixThresh))

(cl:defmethod #.(bullet-wrap::swig-lispify "set-motor-target" 'method) ((self #.(bullet-wrap::swig-lispify "bt-cone-twist-constraint" 'classname)) (q #.(bullet-wrap::swig-lispify "bt-quaternion" 'classname)))
  (#.(bullet-wrap::swig-lispify "btConeTwistConstraint_setMotorTarget" 'function) (ff-pointer self) q))

(cl:defmethod #.(bullet-wrap::swig-lispify "set-motor-target-in-constraint-space" 'method) ((self #.(bullet-wrap::swig-lispify "bt-cone-twist-constraint" 'classname)) (q #.(bullet-wrap::swig-lispify "bt-quaternion" 'classname)))
  (#.(bullet-wrap::swig-lispify "btConeTwistConstraint_setMotorTargetInConstraintSpace" 'function) (ff-pointer self) q))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-point-for-angle" 'method) ((self #.(bullet-wrap::swig-lispify "bt-cone-twist-constraint" 'classname)) (fAngleInRadians cl:number) (fLength cl:number))
  (#.(bullet-wrap::swig-lispify "btConeTwistConstraint_GetPointForAngle" 'function) (ff-pointer self) fAngleInRadians fLength))

(cl:defmethod #.(bullet-wrap::swig-lispify "set-param" 'method) ((self #.(bullet-wrap::swig-lispify "bt-cone-twist-constraint" 'classname)) (num cl:integer) (value cl:number) (axis cl:integer))
  (#.(bullet-wrap::swig-lispify "btConeTwistConstraint_setParam" 'function) (ff-pointer self) num value axis))

(cl:defmethod #.(bullet-wrap::swig-lispify "set-param" 'method) ((self #.(bullet-wrap::swig-lispify "bt-cone-twist-constraint" 'classname)) (num cl:integer) (value cl:number))
  (#.(bullet-wrap::swig-lispify "btConeTwistConstraint_setParam" 'function) (ff-pointer self) num value))

(cl:defmethod #.(bullet-wrap::swig-lispify "set-frames" 'method) ((self #.(bullet-wrap::swig-lispify "bt-cone-twist-constraint" 'classname)) (frameA #.(bullet-wrap::swig-lispify "bt-transform" 'classname)) (frameB #.(bullet-wrap::swig-lispify "bt-transform" 'classname)))
  (#.(bullet-wrap::swig-lispify "btConeTwistConstraint_setFrames" 'function) (ff-pointer self) frameA frameB))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-frame-offset-a" 'method) ((self #.(bullet-wrap::swig-lispify "bt-cone-twist-constraint" 'classname)))
  (#.(bullet-wrap::swig-lispify "btConeTwistConstraint_getFrameOffsetA" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-frame-offset-b" 'method) ((self #.(bullet-wrap::swig-lispify "bt-cone-twist-constraint" 'classname)))
  (#.(bullet-wrap::swig-lispify "btConeTwistConstraint_getFrameOffsetB" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-param" 'method) ((self #.(bullet-wrap::swig-lispify "bt-cone-twist-constraint" 'classname)) (num cl:integer) (axis cl:integer))
  (#.(bullet-wrap::swig-lispify "btConeTwistConstraint_getParam" 'function) (ff-pointer self) num axis))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-param" 'method) ((self #.(bullet-wrap::swig-lispify "bt-cone-twist-constraint" 'classname)) (num cl:integer))
  (#.(bullet-wrap::swig-lispify "btConeTwistConstraint_getParam" 'function) (ff-pointer self) num))

(cl:defmethod #.(bullet-wrap::swig-lispify "calculate-serialize-buffer-size" 'method) ((self #.(bullet-wrap::swig-lispify "bt-cone-twist-constraint" 'classname)))
  (#.(bullet-wrap::swig-lispify "btConeTwistConstraint_calculateSerializeBufferSize" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "serialize" 'method) ((self #.(bullet-wrap::swig-lispify "bt-cone-twist-constraint" 'classname)) dataBuffer (serializer #.(bullet-wrap::swig-lispify "bt-serializer" 'classname)))
  (#.(bullet-wrap::swig-lispify "btConeTwistConstraint_serialize" 'function) (ff-pointer self) dataBuffer serializer))


(cl:defclass #.(bullet-wrap::swig-lispify "bt-rotational-limit-motor" 'classname)()
  ((ff-pointer :reader ff-pointer)))

(cl:defmethod (cl:setf #.(bullet-wrap::swig-lispify "m_loLimit" 'method)) (arg0 (obj #.(bullet-wrap::swig-lispify "bt-rotational-limit-motor" 'class)))
  (#.(bullet-wrap::swig-lispify "btRotationalLimitMotor_m_loLimit_set" 'function) (ff-pointer obj) arg0))

(cl:defmethod #.(bullet-wrap::swig-lispify "m_loLimit" 'method) ((obj #.(bullet-wrap::swig-lispify "bt-rotational-limit-motor" 'class)))
  (#.(bullet-wrap::swig-lispify "btRotationalLimitMotor_m_loLimit_get" 'function) (ff-pointer obj)))

(cl:defmethod (cl:setf #.(bullet-wrap::swig-lispify "m_hiLimit" 'method)) (arg0 (obj #.(bullet-wrap::swig-lispify "bt-rotational-limit-motor" 'class)))
  (#.(bullet-wrap::swig-lispify "btRotationalLimitMotor_m_hiLimit_set" 'function) (ff-pointer obj) arg0))

(cl:defmethod #.(bullet-wrap::swig-lispify "m_hiLimit" 'method) ((obj #.(bullet-wrap::swig-lispify "bt-rotational-limit-motor" 'class)))
  (#.(bullet-wrap::swig-lispify "btRotationalLimitMotor_m_hiLimit_get" 'function) (ff-pointer obj)))

(cl:defmethod (cl:setf #.(bullet-wrap::swig-lispify "m_targetVelocity" 'method)) (arg0 (obj #.(bullet-wrap::swig-lispify "bt-rotational-limit-motor" 'class)))
  (#.(bullet-wrap::swig-lispify "btRotationalLimitMotor_m_targetVelocity_set" 'function) (ff-pointer obj) arg0))

(cl:defmethod #.(bullet-wrap::swig-lispify "m_targetVelocity" 'method) ((obj #.(bullet-wrap::swig-lispify "bt-rotational-limit-motor" 'class)))
  (#.(bullet-wrap::swig-lispify "btRotationalLimitMotor_m_targetVelocity_get" 'function) (ff-pointer obj)))

(cl:defmethod (cl:setf #.(bullet-wrap::swig-lispify "m_maxMotorForce" 'method)) (arg0 (obj #.(bullet-wrap::swig-lispify "bt-rotational-limit-motor" 'class)))
  (#.(bullet-wrap::swig-lispify "btRotationalLimitMotor_m_maxMotorForce_set" 'function) (ff-pointer obj) arg0))

(cl:defmethod #.(bullet-wrap::swig-lispify "m_maxMotorForce" 'method) ((obj #.(bullet-wrap::swig-lispify "bt-rotational-limit-motor" 'class)))
  (#.(bullet-wrap::swig-lispify "btRotationalLimitMotor_m_maxMotorForce_get" 'function) (ff-pointer obj)))

(cl:defmethod (cl:setf #.(bullet-wrap::swig-lispify "m_maxLimitForce" 'method)) (arg0 (obj #.(bullet-wrap::swig-lispify "bt-rotational-limit-motor" 'class)))
  (#.(bullet-wrap::swig-lispify "btRotationalLimitMotor_m_maxLimitForce_set" 'function) (ff-pointer obj) arg0))

(cl:defmethod #.(bullet-wrap::swig-lispify "m_maxLimitForce" 'method) ((obj #.(bullet-wrap::swig-lispify "bt-rotational-limit-motor" 'class)))
  (#.(bullet-wrap::swig-lispify "btRotationalLimitMotor_m_maxLimitForce_get" 'function) (ff-pointer obj)))

(cl:defmethod (cl:setf #.(bullet-wrap::swig-lispify "m_damping" 'method)) (arg0 (obj #.(bullet-wrap::swig-lispify "bt-rotational-limit-motor" 'class)))
  (#.(bullet-wrap::swig-lispify "btRotationalLimitMotor_m_damping_set" 'function) (ff-pointer obj) arg0))

(cl:defmethod #.(bullet-wrap::swig-lispify "m_damping" 'method) ((obj #.(bullet-wrap::swig-lispify "bt-rotational-limit-motor" 'class)))
  (#.(bullet-wrap::swig-lispify "btRotationalLimitMotor_m_damping_get" 'function) (ff-pointer obj)))

(cl:defmethod (cl:setf #.(bullet-wrap::swig-lispify "m_limitSoftness" 'method)) (arg0 (obj #.(bullet-wrap::swig-lispify "bt-rotational-limit-motor" 'class)))
  (#.(bullet-wrap::swig-lispify "btRotationalLimitMotor_m_limitSoftness_set" 'function) (ff-pointer obj) arg0))

(cl:defmethod #.(bullet-wrap::swig-lispify "m_limitSoftness" 'method) ((obj #.(bullet-wrap::swig-lispify "bt-rotational-limit-motor" 'class)))
  (#.(bullet-wrap::swig-lispify "btRotationalLimitMotor_m_limitSoftness_get" 'function) (ff-pointer obj)))

(cl:defmethod (cl:setf #.(bullet-wrap::swig-lispify "m_normalCFM" 'method)) (arg0 (obj #.(bullet-wrap::swig-lispify "bt-rotational-limit-motor" 'class)))
  (#.(bullet-wrap::swig-lispify "btRotationalLimitMotor_m_normalCFM_set" 'function) (ff-pointer obj) arg0))

(cl:defmethod #.(bullet-wrap::swig-lispify "m_normalCFM" 'method) ((obj #.(bullet-wrap::swig-lispify "bt-rotational-limit-motor" 'class)))
  (#.(bullet-wrap::swig-lispify "btRotationalLimitMotor_m_normalCFM_get" 'function) (ff-pointer obj)))

(cl:defmethod (cl:setf #.(bullet-wrap::swig-lispify "m_stopERP" 'method)) (arg0 (obj #.(bullet-wrap::swig-lispify "bt-rotational-limit-motor" 'class)))
  (#.(bullet-wrap::swig-lispify "btRotationalLimitMotor_m_stopERP_set" 'function) (ff-pointer obj) arg0))

(cl:defmethod #.(bullet-wrap::swig-lispify "m_stopERP" 'method) ((obj #.(bullet-wrap::swig-lispify "bt-rotational-limit-motor" 'class)))
  (#.(bullet-wrap::swig-lispify "btRotationalLimitMotor_m_stopERP_get" 'function) (ff-pointer obj)))

(cl:defmethod (cl:setf #.(bullet-wrap::swig-lispify "m_stopCFM" 'method)) (arg0 (obj #.(bullet-wrap::swig-lispify "bt-rotational-limit-motor" 'class)))
  (#.(bullet-wrap::swig-lispify "btRotationalLimitMotor_m_stopCFM_set" 'function) (ff-pointer obj) arg0))

(cl:defmethod #.(bullet-wrap::swig-lispify "m_stopCFM" 'method) ((obj #.(bullet-wrap::swig-lispify "bt-rotational-limit-motor" 'class)))
  (#.(bullet-wrap::swig-lispify "btRotationalLimitMotor_m_stopCFM_get" 'function) (ff-pointer obj)))

(cl:defmethod (cl:setf #.(bullet-wrap::swig-lispify "m_bounce" 'method)) (arg0 (obj #.(bullet-wrap::swig-lispify "bt-rotational-limit-motor" 'class)))
  (#.(bullet-wrap::swig-lispify "btRotationalLimitMotor_m_bounce_set" 'function) (ff-pointer obj) arg0))

(cl:defmethod #.(bullet-wrap::swig-lispify "m_bounce" 'method) ((obj #.(bullet-wrap::swig-lispify "bt-rotational-limit-motor" 'class)))
  (#.(bullet-wrap::swig-lispify "btRotationalLimitMotor_m_bounce_get" 'function) (ff-pointer obj)))

(cl:defmethod (cl:setf #.(bullet-wrap::swig-lispify "m_enableMotor" 'method)) (arg0 (obj #.(bullet-wrap::swig-lispify "bt-rotational-limit-motor" 'class)))
  (#.(bullet-wrap::swig-lispify "btRotationalLimitMotor_m_enableMotor_set" 'function) (ff-pointer obj) arg0))

(cl:defmethod #.(bullet-wrap::swig-lispify "m_enableMotor" 'method) ((obj #.(bullet-wrap::swig-lispify "bt-rotational-limit-motor" 'class)))
  (#.(bullet-wrap::swig-lispify "btRotationalLimitMotor_m_enableMotor_get" 'function) (ff-pointer obj)))

(cl:defmethod (cl:setf #.(bullet-wrap::swig-lispify "m_currentLimitError" 'method)) (arg0 (obj #.(bullet-wrap::swig-lispify "bt-rotational-limit-motor" 'class)))
  (#.(bullet-wrap::swig-lispify "btRotationalLimitMotor_m_currentLimitError_set" 'function) (ff-pointer obj) arg0))

(cl:defmethod #.(bullet-wrap::swig-lispify "m_currentLimitError" 'method) ((obj #.(bullet-wrap::swig-lispify "bt-rotational-limit-motor" 'class)))
  (#.(bullet-wrap::swig-lispify "btRotationalLimitMotor_m_currentLimitError_get" 'function) (ff-pointer obj)))

(cl:defmethod (cl:setf #.(bullet-wrap::swig-lispify "m_currentPosition" 'method)) (arg0 (obj #.(bullet-wrap::swig-lispify "bt-rotational-limit-motor" 'class)))
  (#.(bullet-wrap::swig-lispify "btRotationalLimitMotor_m_currentPosition_set" 'function) (ff-pointer obj) arg0))

(cl:defmethod #.(bullet-wrap::swig-lispify "m_currentPosition" 'method) ((obj #.(bullet-wrap::swig-lispify "bt-rotational-limit-motor" 'class)))
  (#.(bullet-wrap::swig-lispify "btRotationalLimitMotor_m_currentPosition_get" 'function) (ff-pointer obj)))

(cl:defmethod (cl:setf #.(bullet-wrap::swig-lispify "m_currentLimit" 'method)) (arg0 (obj #.(bullet-wrap::swig-lispify "bt-rotational-limit-motor" 'class)))
  (#.(bullet-wrap::swig-lispify "btRotationalLimitMotor_m_currentLimit_set" 'function) (ff-pointer obj) arg0))

(cl:defmethod #.(bullet-wrap::swig-lispify "m_currentLimit" 'method) ((obj #.(bullet-wrap::swig-lispify "bt-rotational-limit-motor" 'class)))
  (#.(bullet-wrap::swig-lispify "btRotationalLimitMotor_m_currentLimit_get" 'function) (ff-pointer obj)))

(cl:defmethod (cl:setf #.(bullet-wrap::swig-lispify "m_accumulatedImpulse" 'method)) (arg0 (obj #.(bullet-wrap::swig-lispify "bt-rotational-limit-motor" 'class)))
  (#.(bullet-wrap::swig-lispify "btRotationalLimitMotor_m_accumulatedImpulse_set" 'function) (ff-pointer obj) arg0))

(cl:defmethod #.(bullet-wrap::swig-lispify "m_accumulatedImpulse" 'method) ((obj #.(bullet-wrap::swig-lispify "bt-rotational-limit-motor" 'class)))
  (#.(bullet-wrap::swig-lispify "btRotationalLimitMotor_m_accumulatedImpulse_get" 'function) (ff-pointer obj)))

(cl:defmethod initialize-instance :after ((obj #.(bullet-wrap::swig-lispify "bt-rotational-limit-motor" 'class)) &key)
  (setf (slot-value obj 'ff-pointer) (#.(bullet-wrap::swig-lispify "new_btRotationalLimitMotor" 'function))))

(cl:defmethod initialize-instance :after ((obj #.(bullet-wrap::swig-lispify "bt-rotational-limit-motor" 'class)) &key (limot #.(bullet-wrap::swig-lispify "bt-rotational-limit-motor" 'classname)))
  (setf (slot-value obj 'ff-pointer) (#.(bullet-wrap::swig-lispify "new_btRotationalLimitMotor" 'function) (ff-pointer limot))))

(cl:defmethod #.(bullet-wrap::swig-lispify "is-limited" 'method) ((self #.(bullet-wrap::swig-lispify "bt-rotational-limit-motor" 'classname)))
  (#.(bullet-wrap::swig-lispify "btRotationalLimitMotor_isLimited" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "need-apply-torques" 'method) ((self #.(bullet-wrap::swig-lispify "bt-rotational-limit-motor" 'classname)))
  (#.(bullet-wrap::swig-lispify "btRotationalLimitMotor_needApplyTorques" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "test-limit-value" 'method) ((self #.(bullet-wrap::swig-lispify "bt-rotational-limit-motor" 'classname)) (test_value cl:number))
  (#.(bullet-wrap::swig-lispify "btRotationalLimitMotor_testLimitValue" 'function) (ff-pointer self) test_value))

(cl:defmethod #.(bullet-wrap::swig-lispify "solve-angular-limits" 'method) ((self #.(bullet-wrap::swig-lispify "bt-rotational-limit-motor" 'classname)) (timeStep cl:number) (axis #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (jacDiagABInv cl:number) (body0 #.(bullet-wrap::swig-lispify "bt-rigid-body" 'classname)) (body1 #.(bullet-wrap::swig-lispify "bt-rigid-body" 'classname)))
  (#.(bullet-wrap::swig-lispify "btRotationalLimitMotor_solveAngularLimits" 'function) (ff-pointer self) timeStep axis jacDiagABInv body0 body1))


(cl:defclass #.(bullet-wrap::swig-lispify "bt-translational-limit-motor" 'classname)()
  ((ff-pointer :reader ff-pointer)))

(cl:defmethod (cl:setf #.(bullet-wrap::swig-lispify "m_lowerLimit" 'method)) (arg0 (obj #.(bullet-wrap::swig-lispify "bt-translational-limit-motor" 'class)))
  (#.(bullet-wrap::swig-lispify "btTranslationalLimitMotor_m_lowerLimit_set" 'function) (ff-pointer obj) arg0))

(cl:defmethod #.(bullet-wrap::swig-lispify "m_lowerLimit" 'method) ((obj #.(bullet-wrap::swig-lispify "bt-translational-limit-motor" 'class)))
  (#.(bullet-wrap::swig-lispify "btTranslationalLimitMotor_m_lowerLimit_get" 'function) (ff-pointer obj)))

(cl:defmethod (cl:setf #.(bullet-wrap::swig-lispify "m_upperLimit" 'method)) (arg0 (obj #.(bullet-wrap::swig-lispify "bt-translational-limit-motor" 'class)))
  (#.(bullet-wrap::swig-lispify "btTranslationalLimitMotor_m_upperLimit_set" 'function) (ff-pointer obj) arg0))

(cl:defmethod #.(bullet-wrap::swig-lispify "m_upperLimit" 'method) ((obj #.(bullet-wrap::swig-lispify "bt-translational-limit-motor" 'class)))
  (#.(bullet-wrap::swig-lispify "btTranslationalLimitMotor_m_upperLimit_get" 'function) (ff-pointer obj)))

(cl:defmethod (cl:setf #.(bullet-wrap::swig-lispify "m_accumulatedImpulse" 'method)) (arg0 (obj #.(bullet-wrap::swig-lispify "bt-translational-limit-motor" 'class)))
  (#.(bullet-wrap::swig-lispify "btTranslationalLimitMotor_m_accumulatedImpulse_set" 'function) (ff-pointer obj) arg0))

(cl:defmethod #.(bullet-wrap::swig-lispify "m_accumulatedImpulse" 'method) ((obj #.(bullet-wrap::swig-lispify "bt-translational-limit-motor" 'class)))
  (#.(bullet-wrap::swig-lispify "btTranslationalLimitMotor_m_accumulatedImpulse_get" 'function) (ff-pointer obj)))

(cl:defmethod (cl:setf #.(bullet-wrap::swig-lispify "m_limitSoftness" 'method)) (arg0 (obj #.(bullet-wrap::swig-lispify "bt-translational-limit-motor" 'class)))
  (#.(bullet-wrap::swig-lispify "btTranslationalLimitMotor_m_limitSoftness_set" 'function) (ff-pointer obj) arg0))

(cl:defmethod #.(bullet-wrap::swig-lispify "m_limitSoftness" 'method) ((obj #.(bullet-wrap::swig-lispify "bt-translational-limit-motor" 'class)))
  (#.(bullet-wrap::swig-lispify "btTranslationalLimitMotor_m_limitSoftness_get" 'function) (ff-pointer obj)))

(cl:defmethod (cl:setf #.(bullet-wrap::swig-lispify "m_damping" 'method)) (arg0 (obj #.(bullet-wrap::swig-lispify "bt-translational-limit-motor" 'class)))
  (#.(bullet-wrap::swig-lispify "btTranslationalLimitMotor_m_damping_set" 'function) (ff-pointer obj) arg0))

(cl:defmethod #.(bullet-wrap::swig-lispify "m_damping" 'method) ((obj #.(bullet-wrap::swig-lispify "bt-translational-limit-motor" 'class)))
  (#.(bullet-wrap::swig-lispify "btTranslationalLimitMotor_m_damping_get" 'function) (ff-pointer obj)))

(cl:defmethod (cl:setf #.(bullet-wrap::swig-lispify "m_restitution" 'method)) (arg0 (obj #.(bullet-wrap::swig-lispify "bt-translational-limit-motor" 'class)))
  (#.(bullet-wrap::swig-lispify "btTranslationalLimitMotor_m_restitution_set" 'function) (ff-pointer obj) arg0))

(cl:defmethod #.(bullet-wrap::swig-lispify "m_restitution" 'method) ((obj #.(bullet-wrap::swig-lispify "bt-translational-limit-motor" 'class)))
  (#.(bullet-wrap::swig-lispify "btTranslationalLimitMotor_m_restitution_get" 'function) (ff-pointer obj)))

(cl:defmethod (cl:setf #.(bullet-wrap::swig-lispify "m_normalCFM" 'method)) (arg0 (obj #.(bullet-wrap::swig-lispify "bt-translational-limit-motor" 'class)))
  (#.(bullet-wrap::swig-lispify "btTranslationalLimitMotor_m_normalCFM_set" 'function) (ff-pointer obj) arg0))

(cl:defmethod #.(bullet-wrap::swig-lispify "m_normalCFM" 'method) ((obj #.(bullet-wrap::swig-lispify "bt-translational-limit-motor" 'class)))
  (#.(bullet-wrap::swig-lispify "btTranslationalLimitMotor_m_normalCFM_get" 'function) (ff-pointer obj)))

(cl:defmethod (cl:setf #.(bullet-wrap::swig-lispify "m_stopERP" 'method)) (arg0 (obj #.(bullet-wrap::swig-lispify "bt-translational-limit-motor" 'class)))
  (#.(bullet-wrap::swig-lispify "btTranslationalLimitMotor_m_stopERP_set" 'function) (ff-pointer obj) arg0))

(cl:defmethod #.(bullet-wrap::swig-lispify "m_stopERP" 'method) ((obj #.(bullet-wrap::swig-lispify "bt-translational-limit-motor" 'class)))
  (#.(bullet-wrap::swig-lispify "btTranslationalLimitMotor_m_stopERP_get" 'function) (ff-pointer obj)))

(cl:defmethod (cl:setf #.(bullet-wrap::swig-lispify "m_stopCFM" 'method)) (arg0 (obj #.(bullet-wrap::swig-lispify "bt-translational-limit-motor" 'class)))
  (#.(bullet-wrap::swig-lispify "btTranslationalLimitMotor_m_stopCFM_set" 'function) (ff-pointer obj) arg0))

(cl:defmethod #.(bullet-wrap::swig-lispify "m_stopCFM" 'method) ((obj #.(bullet-wrap::swig-lispify "bt-translational-limit-motor" 'class)))
  (#.(bullet-wrap::swig-lispify "btTranslationalLimitMotor_m_stopCFM_get" 'function) (ff-pointer obj)))

(cl:defmethod (cl:setf #.(bullet-wrap::swig-lispify "m_enableMotor" 'method)) (arg0 (obj #.(bullet-wrap::swig-lispify "bt-translational-limit-motor" 'class)))
  (#.(bullet-wrap::swig-lispify "btTranslationalLimitMotor_m_enableMotor_set" 'function) (ff-pointer obj) arg0))

(cl:defmethod #.(bullet-wrap::swig-lispify "m_enableMotor" 'method) ((obj #.(bullet-wrap::swig-lispify "bt-translational-limit-motor" 'class)))
  (#.(bullet-wrap::swig-lispify "btTranslationalLimitMotor_m_enableMotor_get" 'function) (ff-pointer obj)))

(cl:defmethod (cl:setf #.(bullet-wrap::swig-lispify "m_targetVelocity" 'method)) (arg0 (obj #.(bullet-wrap::swig-lispify "bt-translational-limit-motor" 'class)))
  (#.(bullet-wrap::swig-lispify "btTranslationalLimitMotor_m_targetVelocity_set" 'function) (ff-pointer obj) arg0))

(cl:defmethod #.(bullet-wrap::swig-lispify "m_targetVelocity" 'method) ((obj #.(bullet-wrap::swig-lispify "bt-translational-limit-motor" 'class)))
  (#.(bullet-wrap::swig-lispify "btTranslationalLimitMotor_m_targetVelocity_get" 'function) (ff-pointer obj)))

(cl:defmethod (cl:setf #.(bullet-wrap::swig-lispify "m_maxMotorForce" 'method)) (arg0 (obj #.(bullet-wrap::swig-lispify "bt-translational-limit-motor" 'class)))
  (#.(bullet-wrap::swig-lispify "btTranslationalLimitMotor_m_maxMotorForce_set" 'function) (ff-pointer obj) arg0))

(cl:defmethod #.(bullet-wrap::swig-lispify "m_maxMotorForce" 'method) ((obj #.(bullet-wrap::swig-lispify "bt-translational-limit-motor" 'class)))
  (#.(bullet-wrap::swig-lispify "btTranslationalLimitMotor_m_maxMotorForce_get" 'function) (ff-pointer obj)))

(cl:defmethod (cl:setf #.(bullet-wrap::swig-lispify "m_currentLimitError" 'method)) (arg0 (obj #.(bullet-wrap::swig-lispify "bt-translational-limit-motor" 'class)))
  (#.(bullet-wrap::swig-lispify "btTranslationalLimitMotor_m_currentLimitError_set" 'function) (ff-pointer obj) arg0))

(cl:defmethod #.(bullet-wrap::swig-lispify "m_currentLimitError" 'method) ((obj #.(bullet-wrap::swig-lispify "bt-translational-limit-motor" 'class)))
  (#.(bullet-wrap::swig-lispify "btTranslationalLimitMotor_m_currentLimitError_get" 'function) (ff-pointer obj)))

(cl:defmethod (cl:setf #.(bullet-wrap::swig-lispify "m_currentLinearDiff" 'method)) (arg0 (obj #.(bullet-wrap::swig-lispify "bt-translational-limit-motor" 'class)))
  (#.(bullet-wrap::swig-lispify "btTranslationalLimitMotor_m_currentLinearDiff_set" 'function) (ff-pointer obj) arg0))

(cl:defmethod #.(bullet-wrap::swig-lispify "m_currentLinearDiff" 'method) ((obj #.(bullet-wrap::swig-lispify "bt-translational-limit-motor" 'class)))
  (#.(bullet-wrap::swig-lispify "btTranslationalLimitMotor_m_currentLinearDiff_get" 'function) (ff-pointer obj)))

(cl:defmethod (cl:setf #.(bullet-wrap::swig-lispify "m_currentLimit" 'method)) (arg0 (obj #.(bullet-wrap::swig-lispify "bt-translational-limit-motor" 'class)))
  (#.(bullet-wrap::swig-lispify "btTranslationalLimitMotor_m_currentLimit_set" 'function) (ff-pointer obj) arg0))

(cl:defmethod #.(bullet-wrap::swig-lispify "m_currentLimit" 'method) ((obj #.(bullet-wrap::swig-lispify "bt-translational-limit-motor" 'class)))
  (#.(bullet-wrap::swig-lispify "btTranslationalLimitMotor_m_currentLimit_get" 'function) (ff-pointer obj)))

(cl:defmethod initialize-instance :after ((obj #.(bullet-wrap::swig-lispify "bt-translational-limit-motor" 'class)) &key)
  (setf (slot-value obj 'ff-pointer) (#.(bullet-wrap::swig-lispify "new_btTranslationalLimitMotor" 'function))))

(cl:defmethod initialize-instance :after ((obj #.(bullet-wrap::swig-lispify "bt-translational-limit-motor" 'class)) &key (other #.(bullet-wrap::swig-lispify "bt-translational-limit-motor" 'classname)))
  (setf (slot-value obj 'ff-pointer) (#.(bullet-wrap::swig-lispify "new_btTranslationalLimitMotor" 'function) (ff-pointer other))))

(cl:defmethod #.(bullet-wrap::swig-lispify "is-limited" 'method) ((self #.(bullet-wrap::swig-lispify "bt-translational-limit-motor" 'classname)) (limitIndex cl:integer))
  (#.(bullet-wrap::swig-lispify "btTranslationalLimitMotor_isLimited" 'function) (ff-pointer self) limitIndex))

(cl:defmethod #.(bullet-wrap::swig-lispify "need-apply-force" 'method) ((self #.(bullet-wrap::swig-lispify "bt-translational-limit-motor" 'classname)) (limitIndex cl:integer))
  (#.(bullet-wrap::swig-lispify "btTranslationalLimitMotor_needApplyForce" 'function) (ff-pointer self) limitIndex))

(cl:defmethod #.(bullet-wrap::swig-lispify "test-limit-value" 'method) ((self #.(bullet-wrap::swig-lispify "bt-translational-limit-motor" 'classname)) (limitIndex cl:integer) (test_value cl:number))
  (#.(bullet-wrap::swig-lispify "btTranslationalLimitMotor_testLimitValue" 'function) (ff-pointer self) limitIndex test_value))

(cl:defmethod #.(bullet-wrap::swig-lispify "solve-linear-axis" 'method) ((self #.(bullet-wrap::swig-lispify "bt-translational-limit-motor" 'classname)) (timeStep cl:number) (jacDiagABInv cl:number) (body1 #.(bullet-wrap::swig-lispify "bt-rigid-body" 'classname)) (pointInA #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (body2 #.(bullet-wrap::swig-lispify "bt-rigid-body" 'classname)) (pointInB #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (limit_index cl:integer) (axis_normal_on_a #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (anchorPos #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)))
  (#.(bullet-wrap::swig-lispify "btTranslationalLimitMotor_solveLinearAxis" 'function) (ff-pointer self) timeStep jacDiagABInv body1 pointInA body2 pointInB limit_index axis_normal_on_a anchorPos))


(cl:defclass #.(bullet-wrap::swig-lispify "bt-generic6-dof-constraint" 'classname)(#.(bullet-wrap::swig-lispify "btTypedConstraint" 'classname))
  ((ff-pointer :reader ff-pointer)))

(cl:shadow "new")
(cl:defmethod #.(bullet-wrap::swig-lispify "new" 'method) ((self #.(bullet-wrap::swig-lispify "bt-generic6-dof-constraint" 'classname)) sizeInBytes)
  (#.(bullet-wrap::swig-lispify "btGeneric6DofConstraint_makeCPlusPlusInstance" 'function) (ff-pointer self) sizeInBytes))

(cl:shadow "delete")
(cl:defmethod #.(bullet-wrap::swig-lispify "delete" 'method) ((self #.(bullet-wrap::swig-lispify "bt-generic6-dof-constraint" 'classname)) ptr)
  (#.(bullet-wrap::swig-lispify "btGeneric6DofConstraint_deleteCPlusPlusInstance" 'function) (ff-pointer self) ptr))

(cl:shadow "new")
(cl:defmethod #.(bullet-wrap::swig-lispify "new" 'method) ((self #.(bullet-wrap::swig-lispify "bt-generic6-dof-constraint" 'classname)) arg1 ptr)
  (#.(bullet-wrap::swig-lispify "btGeneric6DofConstraint_makeCPlusPlusInstance" 'function) (ff-pointer self) arg1 ptr))

(cl:shadow "delete")
(cl:defmethod #.(bullet-wrap::swig-lispify "delete" 'method) ((self #.(bullet-wrap::swig-lispify "bt-generic6-dof-constraint" 'classname)) arg1 arg2)
  (#.(bullet-wrap::swig-lispify "btGeneric6DofConstraint_deleteCPlusPlusInstance" 'function) (ff-pointer self) arg1 arg2))

(cl:shadow "new[]")
(cl:defmethod #.(bullet-wrap::swig-lispify "new[]" 'method) ((self #.(bullet-wrap::swig-lispify "bt-generic6-dof-constraint" 'classname)) sizeInBytes)
  (#.(bullet-wrap::swig-lispify "btGeneric6DofConstraint_makeCPlusArray" 'function) (ff-pointer self) sizeInBytes))

(cl:shadow "delete[]")
(cl:defmethod #.(bullet-wrap::swig-lispify "delete[]" 'method) ((self #.(bullet-wrap::swig-lispify "bt-generic6-dof-constraint" 'classname)) ptr)
  (#.(bullet-wrap::swig-lispify "btGeneric6DofConstraint_deleteCPlusArray" 'function) (ff-pointer self) ptr))

(cl:shadow "new[]")
(cl:defmethod #.(bullet-wrap::swig-lispify "new[]" 'method) ((self #.(bullet-wrap::swig-lispify "bt-generic6-dof-constraint" 'classname)) arg1 ptr)
  (#.(bullet-wrap::swig-lispify "btGeneric6DofConstraint_makeCPlusArray" 'function) (ff-pointer self) arg1 ptr))

(cl:shadow "delete[]")
(cl:defmethod #.(bullet-wrap::swig-lispify "delete[]" 'method) ((self #.(bullet-wrap::swig-lispify "bt-generic6-dof-constraint" 'classname)) arg1 arg2)
  (#.(bullet-wrap::swig-lispify "btGeneric6DofConstraint_deleteCPlusArray" 'function) (ff-pointer self) arg1 arg2))

(cl:defmethod (cl:setf #.(bullet-wrap::swig-lispify "m_useSolveConstraintObsolete" 'method)) (arg0 (obj #.(bullet-wrap::swig-lispify "bt-generic6-dof-constraint" 'class)))
  (#.(bullet-wrap::swig-lispify "btGeneric6DofConstraint_m_useSolveConstraintObsolete_set" 'function) (ff-pointer obj) arg0))

(cl:defmethod #.(bullet-wrap::swig-lispify "m_useSolveConstraintObsolete" 'method) ((obj #.(bullet-wrap::swig-lispify "bt-generic6-dof-constraint" 'class)))
  (#.(bullet-wrap::swig-lispify "btGeneric6DofConstraint_m_useSolveConstraintObsolete_get" 'function) (ff-pointer obj)))

(cl:defmethod initialize-instance :after ((obj #.(bullet-wrap::swig-lispify "bt-generic6-dof-constraint" 'class)) &key (rbA #.(bullet-wrap::swig-lispify "bt-rigid-body" 'classname)) (rbB #.(bullet-wrap::swig-lispify "bt-rigid-body" 'classname)) (frameInA #.(bullet-wrap::swig-lispify "bt-transform" 'classname)) (frameInB #.(bullet-wrap::swig-lispify "bt-transform" 'classname)) (useLinearReferenceFrameA t))
  (setf (slot-value obj 'ff-pointer) (#.(bullet-wrap::swig-lispify "new_btGeneric6DofConstraint" 'function) rbA rbB frameInA frameInB useLinearReferenceFrameA)))

(cl:defmethod initialize-instance :after ((obj #.(bullet-wrap::swig-lispify "bt-generic6-dof-constraint" 'class)) &key (rbB #.(bullet-wrap::swig-lispify "bt-rigid-body" 'classname)) (frameInB #.(bullet-wrap::swig-lispify "bt-transform" 'classname)) (useLinearReferenceFrameB t))
  (setf (slot-value obj 'ff-pointer) (#.(bullet-wrap::swig-lispify "new_btGeneric6DofConstraint" 'function) rbB frameInB useLinearReferenceFrameB)))

(cl:defmethod #.(bullet-wrap::swig-lispify "calculate-transforms" 'method) ((self #.(bullet-wrap::swig-lispify "bt-generic6-dof-constraint" 'classname)) (transA #.(bullet-wrap::swig-lispify "bt-transform" 'classname)) (transB #.(bullet-wrap::swig-lispify "bt-transform" 'classname)))
  (#.(bullet-wrap::swig-lispify "btGeneric6DofConstraint_calculateTransforms" 'function) (ff-pointer self) transA transB))

(cl:defmethod #.(bullet-wrap::swig-lispify "calculate-transforms" 'method) ((self #.(bullet-wrap::swig-lispify "bt-generic6-dof-constraint" 'classname)))
  (#.(bullet-wrap::swig-lispify "btGeneric6DofConstraint_calculateTransforms" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-calculated-transform-a" 'method) ((self #.(bullet-wrap::swig-lispify "bt-generic6-dof-constraint" 'classname)))
  (#.(bullet-wrap::swig-lispify "btGeneric6DofConstraint_getCalculatedTransformA" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-calculated-transform-b" 'method) ((self #.(bullet-wrap::swig-lispify "bt-generic6-dof-constraint" 'classname)))
  (#.(bullet-wrap::swig-lispify "btGeneric6DofConstraint_getCalculatedTransformB" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-frame-offset-a" 'method) ((self #.(bullet-wrap::swig-lispify "bt-generic6-dof-constraint" 'classname)))
  (#.(bullet-wrap::swig-lispify "btGeneric6DofConstraint_getFrameOffsetA" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-frame-offset-b" 'method) ((self #.(bullet-wrap::swig-lispify "bt-generic6-dof-constraint" 'classname)))
  (#.(bullet-wrap::swig-lispify "btGeneric6DofConstraint_getFrameOffsetB" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-frame-offset-a" 'method) ((self #.(bullet-wrap::swig-lispify "bt-generic6-dof-constraint" 'classname)))
  (#.(bullet-wrap::swig-lispify "btGeneric6DofConstraint_getFrameOffsetA" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-frame-offset-b" 'method) ((self #.(bullet-wrap::swig-lispify "bt-generic6-dof-constraint" 'classname)))
  (#.(bullet-wrap::swig-lispify "btGeneric6DofConstraint_getFrameOffsetB" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "build-jacobian" 'method) ((self #.(bullet-wrap::swig-lispify "bt-generic6-dof-constraint" 'classname)))
  (#.(bullet-wrap::swig-lispify "btGeneric6DofConstraint_buildJacobian" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-info1" 'method) ((self #.(bullet-wrap::swig-lispify "bt-generic6-dof-constraint" 'classname)) info)
  (#.(bullet-wrap::swig-lispify "btGeneric6DofConstraint_getInfo1" 'function) (ff-pointer self) info))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-info1-non-virtual" 'method) ((self #.(bullet-wrap::swig-lispify "bt-generic6-dof-constraint" 'classname)) info)
  (#.(bullet-wrap::swig-lispify "btGeneric6DofConstraint_getInfo1NonVirtual" 'function) (ff-pointer self) info))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-info2" 'method) ((self #.(bullet-wrap::swig-lispify "bt-generic6-dof-constraint" 'classname)) info)
  (#.(bullet-wrap::swig-lispify "btGeneric6DofConstraint_getInfo2" 'function) (ff-pointer self) info))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-info2-non-virtual" 'method) ((self #.(bullet-wrap::swig-lispify "bt-generic6-dof-constraint" 'classname)) info (transA #.(bullet-wrap::swig-lispify "bt-transform" 'classname)) (transB #.(bullet-wrap::swig-lispify "bt-transform" 'classname)) (linVelA #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (linVelB #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (angVelA #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (angVelB #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)))
  (#.(bullet-wrap::swig-lispify "btGeneric6DofConstraint_getInfo2NonVirtual" 'function) (ff-pointer self) info transA transB linVelA linVelB angVelA angVelB))

(cl:defmethod #.(bullet-wrap::swig-lispify "update-rhs" 'method) ((self #.(bullet-wrap::swig-lispify "bt-generic6-dof-constraint" 'classname)) (timeStep cl:number))
  (#.(bullet-wrap::swig-lispify "btGeneric6DofConstraint_updateRHS" 'function) (ff-pointer self) timeStep))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-axis" 'method) ((self #.(bullet-wrap::swig-lispify "bt-generic6-dof-constraint" 'classname)) (axis_index cl:integer))
  (#.(bullet-wrap::swig-lispify "btGeneric6DofConstraint_getAxis" 'function) (ff-pointer self) axis_index))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-angle" 'method) ((self #.(bullet-wrap::swig-lispify "bt-generic6-dof-constraint" 'classname)) (axis_index cl:integer))
  (#.(bullet-wrap::swig-lispify "btGeneric6DofConstraint_getAngle" 'function) (ff-pointer self) axis_index))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-relative-pivot-position" 'method) ((self #.(bullet-wrap::swig-lispify "bt-generic6-dof-constraint" 'classname)) (axis_index cl:integer))
  (#.(bullet-wrap::swig-lispify "btGeneric6DofConstraint_getRelativePivotPosition" 'function) (ff-pointer self) axis_index))

(cl:defmethod #.(bullet-wrap::swig-lispify "set-frames" 'method) ((self #.(bullet-wrap::swig-lispify "bt-generic6-dof-constraint" 'classname)) (frameA #.(bullet-wrap::swig-lispify "bt-transform" 'classname)) (frameB #.(bullet-wrap::swig-lispify "bt-transform" 'classname)))
  (#.(bullet-wrap::swig-lispify "btGeneric6DofConstraint_setFrames" 'function) (ff-pointer self) frameA frameB))

(cl:defmethod #.(bullet-wrap::swig-lispify "test-angular-limit-motor" 'method) ((self #.(bullet-wrap::swig-lispify "bt-generic6-dof-constraint" 'classname)) (axis_index cl:integer))
  (#.(bullet-wrap::swig-lispify "btGeneric6DofConstraint_testAngularLimitMotor" 'function) (ff-pointer self) axis_index))

(cl:defmethod #.(bullet-wrap::swig-lispify "set-linear-lower-limit" 'method) ((self #.(bullet-wrap::swig-lispify "bt-generic6-dof-constraint" 'classname)) (linearLower #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)))
  (#.(bullet-wrap::swig-lispify "btGeneric6DofConstraint_setLinearLowerLimit" 'function) (ff-pointer self) linearLower))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-linear-lower-limit" 'method) ((self #.(bullet-wrap::swig-lispify "bt-generic6-dof-constraint" 'classname)) (linearLower #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)))
  (#.(bullet-wrap::swig-lispify "btGeneric6DofConstraint_getLinearLowerLimit" 'function) (ff-pointer self) linearLower))

(cl:defmethod #.(bullet-wrap::swig-lispify "set-linear-upper-limit" 'method) ((self #.(bullet-wrap::swig-lispify "bt-generic6-dof-constraint" 'classname)) (linearUpper #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)))
  (#.(bullet-wrap::swig-lispify "btGeneric6DofConstraint_setLinearUpperLimit" 'function) (ff-pointer self) linearUpper))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-linear-upper-limit" 'method) ((self #.(bullet-wrap::swig-lispify "bt-generic6-dof-constraint" 'classname)) (linearUpper #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)))
  (#.(bullet-wrap::swig-lispify "btGeneric6DofConstraint_getLinearUpperLimit" 'function) (ff-pointer self) linearUpper))

(cl:defmethod #.(bullet-wrap::swig-lispify "set-angular-lower-limit" 'method) ((self #.(bullet-wrap::swig-lispify "bt-generic6-dof-constraint" 'classname)) (angularLower #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)))
  (#.(bullet-wrap::swig-lispify "btGeneric6DofConstraint_setAngularLowerLimit" 'function) (ff-pointer self) angularLower))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-angular-lower-limit" 'method) ((self #.(bullet-wrap::swig-lispify "bt-generic6-dof-constraint" 'classname)) (angularLower #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)))
  (#.(bullet-wrap::swig-lispify "btGeneric6DofConstraint_getAngularLowerLimit" 'function) (ff-pointer self) angularLower))

(cl:defmethod #.(bullet-wrap::swig-lispify "set-angular-upper-limit" 'method) ((self #.(bullet-wrap::swig-lispify "bt-generic6-dof-constraint" 'classname)) (angularUpper #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)))
  (#.(bullet-wrap::swig-lispify "btGeneric6DofConstraint_setAngularUpperLimit" 'function) (ff-pointer self) angularUpper))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-angular-upper-limit" 'method) ((self #.(bullet-wrap::swig-lispify "bt-generic6-dof-constraint" 'classname)) (angularUpper #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)))
  (#.(bullet-wrap::swig-lispify "btGeneric6DofConstraint_getAngularUpperLimit" 'function) (ff-pointer self) angularUpper))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-rotational-limit-motor" 'method) ((self #.(bullet-wrap::swig-lispify "bt-generic6-dof-constraint" 'classname)) (index cl:integer))
  (#.(bullet-wrap::swig-lispify "btGeneric6DofConstraint_getRotationalLimitMotor" 'function) (ff-pointer self) index))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-translational-limit-motor" 'method) ((self #.(bullet-wrap::swig-lispify "bt-generic6-dof-constraint" 'classname)))
  (#.(bullet-wrap::swig-lispify "btGeneric6DofConstraint_getTranslationalLimitMotor" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "set-limit" 'method) ((self #.(bullet-wrap::swig-lispify "bt-generic6-dof-constraint" 'classname)) (axis cl:integer) (lo cl:number) (hi cl:number))
  (#.(bullet-wrap::swig-lispify "btGeneric6DofConstraint_setLimit" 'function) (ff-pointer self) axis lo hi))

(cl:defmethod #.(bullet-wrap::swig-lispify "is-limited" 'method) ((self #.(bullet-wrap::swig-lispify "bt-generic6-dof-constraint" 'classname)) (limitIndex cl:integer))
  (#.(bullet-wrap::swig-lispify "btGeneric6DofConstraint_isLimited" 'function) (ff-pointer self) limitIndex))

(cl:defmethod #.(bullet-wrap::swig-lispify "calc-anchor-pos" 'method) ((self #.(bullet-wrap::swig-lispify "bt-generic6-dof-constraint" 'classname)))
  (#.(bullet-wrap::swig-lispify "btGeneric6DofConstraint_calcAnchorPos" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-limit-motor-info2" 'method) ((self #.(bullet-wrap::swig-lispify "bt-generic6-dof-constraint" 'classname)) (limot #.(bullet-wrap::swig-lispify "bt-rotational-limit-motor" 'classname)) (transA #.(bullet-wrap::swig-lispify "bt-transform" 'classname)) (transB #.(bullet-wrap::swig-lispify "bt-transform" 'classname)) (linVelA #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (linVelB #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (angVelA #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (angVelB #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) info (row cl:integer) (ax1 #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (rotational cl:integer) (rotAllowed cl:integer))
  (#.(bullet-wrap::swig-lispify "btGeneric6DofConstraint_get_limit_motor_info2" 'function) (ff-pointer self) limot transA transB linVelA linVelB angVelA angVelB info row ax1 rotational rotAllowed))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-limit-motor-info2" 'method) ((self #.(bullet-wrap::swig-lispify "bt-generic6-dof-constraint" 'classname)) (limot #.(bullet-wrap::swig-lispify "bt-rotational-limit-motor" 'classname)) (transA #.(bullet-wrap::swig-lispify "bt-transform" 'classname)) (transB #.(bullet-wrap::swig-lispify "bt-transform" 'classname)) (linVelA #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (linVelB #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (angVelA #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (angVelB #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) info (row cl:integer) (ax1 #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (rotational cl:integer))
  (#.(bullet-wrap::swig-lispify "btGeneric6DofConstraint_get_limit_motor_info2" 'function) (ff-pointer self) limot transA transB linVelA linVelB angVelA angVelB info row ax1 rotational))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-use-frame-offset" 'method) ((self #.(bullet-wrap::swig-lispify "bt-generic6-dof-constraint" 'classname)))
  (#.(bullet-wrap::swig-lispify "btGeneric6DofConstraint_getUseFrameOffset" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "set-use-frame-offset" 'method) ((self #.(bullet-wrap::swig-lispify "bt-generic6-dof-constraint" 'classname)) (frameOffsetOnOff t))
  (#.(bullet-wrap::swig-lispify "btGeneric6DofConstraint_setUseFrameOffset" 'function) (ff-pointer self) frameOffsetOnOff))

(cl:defmethod #.(bullet-wrap::swig-lispify "set-param" 'method) ((self #.(bullet-wrap::swig-lispify "bt-generic6-dof-constraint" 'classname)) (num cl:integer) (value cl:number) (axis cl:integer))
  (#.(bullet-wrap::swig-lispify "btGeneric6DofConstraint_setParam" 'function) (ff-pointer self) num value axis))

(cl:defmethod #.(bullet-wrap::swig-lispify "set-param" 'method) ((self #.(bullet-wrap::swig-lispify "bt-generic6-dof-constraint" 'classname)) (num cl:integer) (value cl:number))
  (#.(bullet-wrap::swig-lispify "btGeneric6DofConstraint_setParam" 'function) (ff-pointer self) num value))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-param" 'method) ((self #.(bullet-wrap::swig-lispify "bt-generic6-dof-constraint" 'classname)) (num cl:integer) (axis cl:integer))
  (#.(bullet-wrap::swig-lispify "btGeneric6DofConstraint_getParam" 'function) (ff-pointer self) num axis))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-param" 'method) ((self #.(bullet-wrap::swig-lispify "bt-generic6-dof-constraint" 'classname)) (num cl:integer))
  (#.(bullet-wrap::swig-lispify "btGeneric6DofConstraint_getParam" 'function) (ff-pointer self) num))

(cl:defmethod #.(bullet-wrap::swig-lispify "set-axis" 'method) ((self #.(bullet-wrap::swig-lispify "bt-generic6-dof-constraint" 'classname)) (axis1 #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (axis2 #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)))
  (#.(bullet-wrap::swig-lispify "btGeneric6DofConstraint_setAxis" 'function) (ff-pointer self) axis1 axis2))

(cl:defmethod #.(bullet-wrap::swig-lispify "calculate-serialize-buffer-size" 'method) ((self #.(bullet-wrap::swig-lispify "bt-generic6-dof-constraint" 'classname)))
  (#.(bullet-wrap::swig-lispify "btGeneric6DofConstraint_calculateSerializeBufferSize" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "serialize" 'method) ((self #.(bullet-wrap::swig-lispify "bt-generic6-dof-constraint" 'classname)) dataBuffer (serializer #.(bullet-wrap::swig-lispify "bt-serializer" 'classname)))
  (#.(bullet-wrap::swig-lispify "btGeneric6DofConstraint_serialize" 'function) (ff-pointer self) dataBuffer serializer))


(cl:defclass #.(bullet-wrap::swig-lispify "bt-slider-constraint" 'classname)(#.(bullet-wrap::swig-lispify "btTypedConstraint" 'classname))
  ((ff-pointer :reader ff-pointer)))

(cl:shadow "new")
(cl:defmethod #.(bullet-wrap::swig-lispify "new" 'method) ((self #.(bullet-wrap::swig-lispify "bt-slider-constraint" 'classname)) sizeInBytes)
  (#.(bullet-wrap::swig-lispify "btSliderConstraint_makeCPlusPlusInstance" 'function) (ff-pointer self) sizeInBytes))

(cl:shadow "delete")
(cl:defmethod #.(bullet-wrap::swig-lispify "delete" 'method) ((self #.(bullet-wrap::swig-lispify "bt-slider-constraint" 'classname)) ptr)
  (#.(bullet-wrap::swig-lispify "btSliderConstraint_deleteCPlusPlusInstance" 'function) (ff-pointer self) ptr))

(cl:shadow "new")
(cl:defmethod #.(bullet-wrap::swig-lispify "new" 'method) ((self #.(bullet-wrap::swig-lispify "bt-slider-constraint" 'classname)) arg1 ptr)
  (#.(bullet-wrap::swig-lispify "btSliderConstraint_makeCPlusPlusInstance" 'function) (ff-pointer self) arg1 ptr))

(cl:shadow "delete")
(cl:defmethod #.(bullet-wrap::swig-lispify "delete" 'method) ((self #.(bullet-wrap::swig-lispify "bt-slider-constraint" 'classname)) arg1 arg2)
  (#.(bullet-wrap::swig-lispify "btSliderConstraint_deleteCPlusPlusInstance" 'function) (ff-pointer self) arg1 arg2))

(cl:shadow "new[]")
(cl:defmethod #.(bullet-wrap::swig-lispify "new[]" 'method) ((self #.(bullet-wrap::swig-lispify "bt-slider-constraint" 'classname)) sizeInBytes)
  (#.(bullet-wrap::swig-lispify "btSliderConstraint_makeCPlusArray" 'function) (ff-pointer self) sizeInBytes))

(cl:shadow "delete[]")
(cl:defmethod #.(bullet-wrap::swig-lispify "delete[]" 'method) ((self #.(bullet-wrap::swig-lispify "bt-slider-constraint" 'classname)) ptr)
  (#.(bullet-wrap::swig-lispify "btSliderConstraint_deleteCPlusArray" 'function) (ff-pointer self) ptr))

(cl:shadow "new[]")
(cl:defmethod #.(bullet-wrap::swig-lispify "new[]" 'method) ((self #.(bullet-wrap::swig-lispify "bt-slider-constraint" 'classname)) arg1 ptr)
  (#.(bullet-wrap::swig-lispify "btSliderConstraint_makeCPlusArray" 'function) (ff-pointer self) arg1 ptr))

(cl:shadow "delete[]")
(cl:defmethod #.(bullet-wrap::swig-lispify "delete[]" 'method) ((self #.(bullet-wrap::swig-lispify "bt-slider-constraint" 'classname)) arg1 arg2)
  (#.(bullet-wrap::swig-lispify "btSliderConstraint_deleteCPlusArray" 'function) (ff-pointer self) arg1 arg2))

(cl:defmethod initialize-instance :after ((obj #.(bullet-wrap::swig-lispify "bt-slider-constraint" 'class)) &key (rbA #.(bullet-wrap::swig-lispify "bt-rigid-body" 'classname)) (rbB #.(bullet-wrap::swig-lispify "bt-rigid-body" 'classname)) (frameInA #.(bullet-wrap::swig-lispify "bt-transform" 'classname)) (frameInB #.(bullet-wrap::swig-lispify "bt-transform" 'classname)) (useLinearReferenceFrameA t))
  (setf (slot-value obj 'ff-pointer) (#.(bullet-wrap::swig-lispify "new_btSliderConstraint" 'function) rbA rbB frameInA frameInB useLinearReferenceFrameA)))

(cl:defmethod initialize-instance :after ((obj #.(bullet-wrap::swig-lispify "bt-slider-constraint" 'class)) &key (rbB #.(bullet-wrap::swig-lispify "bt-rigid-body" 'classname)) (frameInB #.(bullet-wrap::swig-lispify "bt-transform" 'classname)) (useLinearReferenceFrameA t))
  (setf (slot-value obj 'ff-pointer) (#.(bullet-wrap::swig-lispify "new_btSliderConstraint" 'function) rbB frameInB useLinearReferenceFrameA)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-info1" 'method) ((self #.(bullet-wrap::swig-lispify "bt-slider-constraint" 'classname)) info)
  (#.(bullet-wrap::swig-lispify "btSliderConstraint_getInfo1" 'function) (ff-pointer self) info))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-info1-non-virtual" 'method) ((self #.(bullet-wrap::swig-lispify "bt-slider-constraint" 'classname)) info)
  (#.(bullet-wrap::swig-lispify "btSliderConstraint_getInfo1NonVirtual" 'function) (ff-pointer self) info))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-info2" 'method) ((self #.(bullet-wrap::swig-lispify "bt-slider-constraint" 'classname)) info)
  (#.(bullet-wrap::swig-lispify "btSliderConstraint_getInfo2" 'function) (ff-pointer self) info))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-info2-non-virtual" 'method) ((self #.(bullet-wrap::swig-lispify "bt-slider-constraint" 'classname)) info (transA #.(bullet-wrap::swig-lispify "bt-transform" 'classname)) (transB #.(bullet-wrap::swig-lispify "bt-transform" 'classname)) (linVelA #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (linVelB #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (rbAinvMass cl:number) (rbBinvMass cl:number))
  (#.(bullet-wrap::swig-lispify "btSliderConstraint_getInfo2NonVirtual" 'function) (ff-pointer self) info transA transB linVelA linVelB rbAinvMass rbBinvMass))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-rigid-body-a" 'method) ((self #.(bullet-wrap::swig-lispify "bt-slider-constraint" 'classname)))
  (#.(bullet-wrap::swig-lispify "btSliderConstraint_getRigidBodyA" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-rigid-body-b" 'method) ((self #.(bullet-wrap::swig-lispify "bt-slider-constraint" 'classname)))
  (#.(bullet-wrap::swig-lispify "btSliderConstraint_getRigidBodyB" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-calculated-transform-a" 'method) ((self #.(bullet-wrap::swig-lispify "bt-slider-constraint" 'classname)))
  (#.(bullet-wrap::swig-lispify "btSliderConstraint_getCalculatedTransformA" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-calculated-transform-b" 'method) ((self #.(bullet-wrap::swig-lispify "bt-slider-constraint" 'classname)))
  (#.(bullet-wrap::swig-lispify "btSliderConstraint_getCalculatedTransformB" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-frame-offset-a" 'method) ((self #.(bullet-wrap::swig-lispify "bt-slider-constraint" 'classname)))
  (#.(bullet-wrap::swig-lispify "btSliderConstraint_getFrameOffsetA" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-frame-offset-b" 'method) ((self #.(bullet-wrap::swig-lispify "bt-slider-constraint" 'classname)))
  (#.(bullet-wrap::swig-lispify "btSliderConstraint_getFrameOffsetB" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-frame-offset-a" 'method) ((self #.(bullet-wrap::swig-lispify "bt-slider-constraint" 'classname)))
  (#.(bullet-wrap::swig-lispify "btSliderConstraint_getFrameOffsetA" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-frame-offset-b" 'method) ((self #.(bullet-wrap::swig-lispify "bt-slider-constraint" 'classname)))
  (#.(bullet-wrap::swig-lispify "btSliderConstraint_getFrameOffsetB" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-lower-lin-limit" 'method) ((self #.(bullet-wrap::swig-lispify "bt-slider-constraint" 'classname)))
  (#.(bullet-wrap::swig-lispify "btSliderConstraint_getLowerLinLimit" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "set-lower-lin-limit" 'method) ((self #.(bullet-wrap::swig-lispify "bt-slider-constraint" 'classname)) (lowerLimit cl:number))
  (#.(bullet-wrap::swig-lispify "btSliderConstraint_setLowerLinLimit" 'function) (ff-pointer self) lowerLimit))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-upper-lin-limit" 'method) ((self #.(bullet-wrap::swig-lispify "bt-slider-constraint" 'classname)))
  (#.(bullet-wrap::swig-lispify "btSliderConstraint_getUpperLinLimit" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "set-upper-lin-limit" 'method) ((self #.(bullet-wrap::swig-lispify "bt-slider-constraint" 'classname)) (upperLimit cl:number))
  (#.(bullet-wrap::swig-lispify "btSliderConstraint_setUpperLinLimit" 'function) (ff-pointer self) upperLimit))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-lower-ang-limit" 'method) ((self #.(bullet-wrap::swig-lispify "bt-slider-constraint" 'classname)))
  (#.(bullet-wrap::swig-lispify "btSliderConstraint_getLowerAngLimit" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "set-lower-ang-limit" 'method) ((self #.(bullet-wrap::swig-lispify "bt-slider-constraint" 'classname)) (lowerLimit cl:number))
  (#.(bullet-wrap::swig-lispify "btSliderConstraint_setLowerAngLimit" 'function) (ff-pointer self) lowerLimit))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-upper-ang-limit" 'method) ((self #.(bullet-wrap::swig-lispify "bt-slider-constraint" 'classname)))
  (#.(bullet-wrap::swig-lispify "btSliderConstraint_getUpperAngLimit" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "set-upper-ang-limit" 'method) ((self #.(bullet-wrap::swig-lispify "bt-slider-constraint" 'classname)) (upperLimit cl:number))
  (#.(bullet-wrap::swig-lispify "btSliderConstraint_setUpperAngLimit" 'function) (ff-pointer self) upperLimit))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-use-linear-reference-frame-a" 'method) ((self #.(bullet-wrap::swig-lispify "bt-slider-constraint" 'classname)))
  (#.(bullet-wrap::swig-lispify "btSliderConstraint_getUseLinearReferenceFrameA" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-softness-dir-lin" 'method) ((self #.(bullet-wrap::swig-lispify "bt-slider-constraint" 'classname)))
  (#.(bullet-wrap::swig-lispify "btSliderConstraint_getSoftnessDirLin" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-restitution-dir-lin" 'method) ((self #.(bullet-wrap::swig-lispify "bt-slider-constraint" 'classname)))
  (#.(bullet-wrap::swig-lispify "btSliderConstraint_getRestitutionDirLin" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-damping-dir-lin" 'method) ((self #.(bullet-wrap::swig-lispify "bt-slider-constraint" 'classname)))
  (#.(bullet-wrap::swig-lispify "btSliderConstraint_getDampingDirLin" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-softness-dir-ang" 'method) ((self #.(bullet-wrap::swig-lispify "bt-slider-constraint" 'classname)))
  (#.(bullet-wrap::swig-lispify "btSliderConstraint_getSoftnessDirAng" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-restitution-dir-ang" 'method) ((self #.(bullet-wrap::swig-lispify "bt-slider-constraint" 'classname)))
  (#.(bullet-wrap::swig-lispify "btSliderConstraint_getRestitutionDirAng" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-damping-dir-ang" 'method) ((self #.(bullet-wrap::swig-lispify "bt-slider-constraint" 'classname)))
  (#.(bullet-wrap::swig-lispify "btSliderConstraint_getDampingDirAng" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-softness-lim-lin" 'method) ((self #.(bullet-wrap::swig-lispify "bt-slider-constraint" 'classname)))
  (#.(bullet-wrap::swig-lispify "btSliderConstraint_getSoftnessLimLin" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-restitution-lim-lin" 'method) ((self #.(bullet-wrap::swig-lispify "bt-slider-constraint" 'classname)))
  (#.(bullet-wrap::swig-lispify "btSliderConstraint_getRestitutionLimLin" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-damping-lim-lin" 'method) ((self #.(bullet-wrap::swig-lispify "bt-slider-constraint" 'classname)))
  (#.(bullet-wrap::swig-lispify "btSliderConstraint_getDampingLimLin" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-softness-lim-ang" 'method) ((self #.(bullet-wrap::swig-lispify "bt-slider-constraint" 'classname)))
  (#.(bullet-wrap::swig-lispify "btSliderConstraint_getSoftnessLimAng" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-restitution-lim-ang" 'method) ((self #.(bullet-wrap::swig-lispify "bt-slider-constraint" 'classname)))
  (#.(bullet-wrap::swig-lispify "btSliderConstraint_getRestitutionLimAng" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-damping-lim-ang" 'method) ((self #.(bullet-wrap::swig-lispify "bt-slider-constraint" 'classname)))
  (#.(bullet-wrap::swig-lispify "btSliderConstraint_getDampingLimAng" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-softness-ortho-lin" 'method) ((self #.(bullet-wrap::swig-lispify "bt-slider-constraint" 'classname)))
  (#.(bullet-wrap::swig-lispify "btSliderConstraint_getSoftnessOrthoLin" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-restitution-ortho-lin" 'method) ((self #.(bullet-wrap::swig-lispify "bt-slider-constraint" 'classname)))
  (#.(bullet-wrap::swig-lispify "btSliderConstraint_getRestitutionOrthoLin" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-damping-ortho-lin" 'method) ((self #.(bullet-wrap::swig-lispify "bt-slider-constraint" 'classname)))
  (#.(bullet-wrap::swig-lispify "btSliderConstraint_getDampingOrthoLin" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-softness-ortho-ang" 'method) ((self #.(bullet-wrap::swig-lispify "bt-slider-constraint" 'classname)))
  (#.(bullet-wrap::swig-lispify "btSliderConstraint_getSoftnessOrthoAng" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-restitution-ortho-ang" 'method) ((self #.(bullet-wrap::swig-lispify "bt-slider-constraint" 'classname)))
  (#.(bullet-wrap::swig-lispify "btSliderConstraint_getRestitutionOrthoAng" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-damping-ortho-ang" 'method) ((self #.(bullet-wrap::swig-lispify "bt-slider-constraint" 'classname)))
  (#.(bullet-wrap::swig-lispify "btSliderConstraint_getDampingOrthoAng" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "set-softness-dir-lin" 'method) ((self #.(bullet-wrap::swig-lispify "bt-slider-constraint" 'classname)) (softnessDirLin cl:number))
  (#.(bullet-wrap::swig-lispify "btSliderConstraint_setSoftnessDirLin" 'function) (ff-pointer self) softnessDirLin))

(cl:defmethod #.(bullet-wrap::swig-lispify "set-restitution-dir-lin" 'method) ((self #.(bullet-wrap::swig-lispify "bt-slider-constraint" 'classname)) (restitutionDirLin cl:number))
  (#.(bullet-wrap::swig-lispify "btSliderConstraint_setRestitutionDirLin" 'function) (ff-pointer self) restitutionDirLin))

(cl:defmethod #.(bullet-wrap::swig-lispify "set-damping-dir-lin" 'method) ((self #.(bullet-wrap::swig-lispify "bt-slider-constraint" 'classname)) (dampingDirLin cl:number))
  (#.(bullet-wrap::swig-lispify "btSliderConstraint_setDampingDirLin" 'function) (ff-pointer self) dampingDirLin))

(cl:defmethod #.(bullet-wrap::swig-lispify "set-softness-dir-ang" 'method) ((self #.(bullet-wrap::swig-lispify "bt-slider-constraint" 'classname)) (softnessDirAng cl:number))
  (#.(bullet-wrap::swig-lispify "btSliderConstraint_setSoftnessDirAng" 'function) (ff-pointer self) softnessDirAng))

(cl:defmethod #.(bullet-wrap::swig-lispify "set-restitution-dir-ang" 'method) ((self #.(bullet-wrap::swig-lispify "bt-slider-constraint" 'classname)) (restitutionDirAng cl:number))
  (#.(bullet-wrap::swig-lispify "btSliderConstraint_setRestitutionDirAng" 'function) (ff-pointer self) restitutionDirAng))

(cl:defmethod #.(bullet-wrap::swig-lispify "set-damping-dir-ang" 'method) ((self #.(bullet-wrap::swig-lispify "bt-slider-constraint" 'classname)) (dampingDirAng cl:number))
  (#.(bullet-wrap::swig-lispify "btSliderConstraint_setDampingDirAng" 'function) (ff-pointer self) dampingDirAng))

(cl:defmethod #.(bullet-wrap::swig-lispify "set-softness-lim-lin" 'method) ((self #.(bullet-wrap::swig-lispify "bt-slider-constraint" 'classname)) (softnessLimLin cl:number))
  (#.(bullet-wrap::swig-lispify "btSliderConstraint_setSoftnessLimLin" 'function) (ff-pointer self) softnessLimLin))

(cl:defmethod #.(bullet-wrap::swig-lispify "set-restitution-lim-lin" 'method) ((self #.(bullet-wrap::swig-lispify "bt-slider-constraint" 'classname)) (restitutionLimLin cl:number))
  (#.(bullet-wrap::swig-lispify "btSliderConstraint_setRestitutionLimLin" 'function) (ff-pointer self) restitutionLimLin))

(cl:defmethod #.(bullet-wrap::swig-lispify "set-damping-lim-lin" 'method) ((self #.(bullet-wrap::swig-lispify "bt-slider-constraint" 'classname)) (dampingLimLin cl:number))
  (#.(bullet-wrap::swig-lispify "btSliderConstraint_setDampingLimLin" 'function) (ff-pointer self) dampingLimLin))

(cl:defmethod #.(bullet-wrap::swig-lispify "set-softness-lim-ang" 'method) ((self #.(bullet-wrap::swig-lispify "bt-slider-constraint" 'classname)) (softnessLimAng cl:number))
  (#.(bullet-wrap::swig-lispify "btSliderConstraint_setSoftnessLimAng" 'function) (ff-pointer self) softnessLimAng))

(cl:defmethod #.(bullet-wrap::swig-lispify "set-restitution-lim-ang" 'method) ((self #.(bullet-wrap::swig-lispify "bt-slider-constraint" 'classname)) (restitutionLimAng cl:number))
  (#.(bullet-wrap::swig-lispify "btSliderConstraint_setRestitutionLimAng" 'function) (ff-pointer self) restitutionLimAng))

(cl:defmethod #.(bullet-wrap::swig-lispify "set-damping-lim-ang" 'method) ((self #.(bullet-wrap::swig-lispify "bt-slider-constraint" 'classname)) (dampingLimAng cl:number))
  (#.(bullet-wrap::swig-lispify "btSliderConstraint_setDampingLimAng" 'function) (ff-pointer self) dampingLimAng))

(cl:defmethod #.(bullet-wrap::swig-lispify "set-softness-ortho-lin" 'method) ((self #.(bullet-wrap::swig-lispify "bt-slider-constraint" 'classname)) (softnessOrthoLin cl:number))
  (#.(bullet-wrap::swig-lispify "btSliderConstraint_setSoftnessOrthoLin" 'function) (ff-pointer self) softnessOrthoLin))

(cl:defmethod #.(bullet-wrap::swig-lispify "set-restitution-ortho-lin" 'method) ((self #.(bullet-wrap::swig-lispify "bt-slider-constraint" 'classname)) (restitutionOrthoLin cl:number))
  (#.(bullet-wrap::swig-lispify "btSliderConstraint_setRestitutionOrthoLin" 'function) (ff-pointer self) restitutionOrthoLin))

(cl:defmethod #.(bullet-wrap::swig-lispify "set-damping-ortho-lin" 'method) ((self #.(bullet-wrap::swig-lispify "bt-slider-constraint" 'classname)) (dampingOrthoLin cl:number))
  (#.(bullet-wrap::swig-lispify "btSliderConstraint_setDampingOrthoLin" 'function) (ff-pointer self) dampingOrthoLin))

(cl:defmethod #.(bullet-wrap::swig-lispify "set-softness-ortho-ang" 'method) ((self #.(bullet-wrap::swig-lispify "bt-slider-constraint" 'classname)) (softnessOrthoAng cl:number))
  (#.(bullet-wrap::swig-lispify "btSliderConstraint_setSoftnessOrthoAng" 'function) (ff-pointer self) softnessOrthoAng))

(cl:defmethod #.(bullet-wrap::swig-lispify "set-restitution-ortho-ang" 'method) ((self #.(bullet-wrap::swig-lispify "bt-slider-constraint" 'classname)) (restitutionOrthoAng cl:number))
  (#.(bullet-wrap::swig-lispify "btSliderConstraint_setRestitutionOrthoAng" 'function) (ff-pointer self) restitutionOrthoAng))

(cl:defmethod #.(bullet-wrap::swig-lispify "set-damping-ortho-ang" 'method) ((self #.(bullet-wrap::swig-lispify "bt-slider-constraint" 'classname)) (dampingOrthoAng cl:number))
  (#.(bullet-wrap::swig-lispify "btSliderConstraint_setDampingOrthoAng" 'function) (ff-pointer self) dampingOrthoAng))

(cl:defmethod #.(bullet-wrap::swig-lispify "set-powered-lin-motor" 'method) ((self #.(bullet-wrap::swig-lispify "bt-slider-constraint" 'classname)) (onOff t))
  (#.(bullet-wrap::swig-lispify "btSliderConstraint_setPoweredLinMotor" 'function) (ff-pointer self) onOff))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-powered-lin-motor" 'method) ((self #.(bullet-wrap::swig-lispify "bt-slider-constraint" 'classname)))
  (#.(bullet-wrap::swig-lispify "btSliderConstraint_getPoweredLinMotor" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "set-target-lin-motor-velocity" 'method) ((self #.(bullet-wrap::swig-lispify "bt-slider-constraint" 'classname)) (targetLinMotorVelocity cl:number))
  (#.(bullet-wrap::swig-lispify "btSliderConstraint_setTargetLinMotorVelocity" 'function) (ff-pointer self) targetLinMotorVelocity))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-target-lin-motor-velocity" 'method) ((self #.(bullet-wrap::swig-lispify "bt-slider-constraint" 'classname)))
  (#.(bullet-wrap::swig-lispify "btSliderConstraint_getTargetLinMotorVelocity" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "set-max-lin-motor-force" 'method) ((self #.(bullet-wrap::swig-lispify "bt-slider-constraint" 'classname)) (maxLinMotorForce cl:number))
  (#.(bullet-wrap::swig-lispify "btSliderConstraint_setMaxLinMotorForce" 'function) (ff-pointer self) maxLinMotorForce))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-max-lin-motor-force" 'method) ((self #.(bullet-wrap::swig-lispify "bt-slider-constraint" 'classname)))
  (#.(bullet-wrap::swig-lispify "btSliderConstraint_getMaxLinMotorForce" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "set-powered-ang-motor" 'method) ((self #.(bullet-wrap::swig-lispify "bt-slider-constraint" 'classname)) (onOff t))
  (#.(bullet-wrap::swig-lispify "btSliderConstraint_setPoweredAngMotor" 'function) (ff-pointer self) onOff))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-powered-ang-motor" 'method) ((self #.(bullet-wrap::swig-lispify "bt-slider-constraint" 'classname)))
  (#.(bullet-wrap::swig-lispify "btSliderConstraint_getPoweredAngMotor" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "set-target-ang-motor-velocity" 'method) ((self #.(bullet-wrap::swig-lispify "bt-slider-constraint" 'classname)) (targetAngMotorVelocity cl:number))
  (#.(bullet-wrap::swig-lispify "btSliderConstraint_setTargetAngMotorVelocity" 'function) (ff-pointer self) targetAngMotorVelocity))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-target-ang-motor-velocity" 'method) ((self #.(bullet-wrap::swig-lispify "bt-slider-constraint" 'classname)))
  (#.(bullet-wrap::swig-lispify "btSliderConstraint_getTargetAngMotorVelocity" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "set-max-ang-motor-force" 'method) ((self #.(bullet-wrap::swig-lispify "bt-slider-constraint" 'classname)) (maxAngMotorForce cl:number))
  (#.(bullet-wrap::swig-lispify "btSliderConstraint_setMaxAngMotorForce" 'function) (ff-pointer self) maxAngMotorForce))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-max-ang-motor-force" 'method) ((self #.(bullet-wrap::swig-lispify "bt-slider-constraint" 'classname)))
  (#.(bullet-wrap::swig-lispify "btSliderConstraint_getMaxAngMotorForce" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-linear-pos" 'method) ((self #.(bullet-wrap::swig-lispify "bt-slider-constraint" 'classname)))
  (#.(bullet-wrap::swig-lispify "btSliderConstraint_getLinearPos" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-angular-pos" 'method) ((self #.(bullet-wrap::swig-lispify "bt-slider-constraint" 'classname)))
  (#.(bullet-wrap::swig-lispify "btSliderConstraint_getAngularPos" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-solve-lin-limit" 'method) ((self #.(bullet-wrap::swig-lispify "bt-slider-constraint" 'classname)))
  (#.(bullet-wrap::swig-lispify "btSliderConstraint_getSolveLinLimit" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-lin-depth" 'method) ((self #.(bullet-wrap::swig-lispify "bt-slider-constraint" 'classname)))
  (#.(bullet-wrap::swig-lispify "btSliderConstraint_getLinDepth" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-solve-ang-limit" 'method) ((self #.(bullet-wrap::swig-lispify "bt-slider-constraint" 'classname)))
  (#.(bullet-wrap::swig-lispify "btSliderConstraint_getSolveAngLimit" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-ang-depth" 'method) ((self #.(bullet-wrap::swig-lispify "bt-slider-constraint" 'classname)))
  (#.(bullet-wrap::swig-lispify "btSliderConstraint_getAngDepth" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "calculate-transforms" 'method) ((self #.(bullet-wrap::swig-lispify "bt-slider-constraint" 'classname)) (transA #.(bullet-wrap::swig-lispify "bt-transform" 'classname)) (transB #.(bullet-wrap::swig-lispify "bt-transform" 'classname)))
  (#.(bullet-wrap::swig-lispify "btSliderConstraint_calculateTransforms" 'function) (ff-pointer self) transA transB))

(cl:defmethod #.(bullet-wrap::swig-lispify "test-lin-limits" 'method) ((self #.(bullet-wrap::swig-lispify "bt-slider-constraint" 'classname)))
  (#.(bullet-wrap::swig-lispify "btSliderConstraint_testLinLimits" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "test-ang-limits" 'method) ((self #.(bullet-wrap::swig-lispify "bt-slider-constraint" 'classname)))
  (#.(bullet-wrap::swig-lispify "btSliderConstraint_testAngLimits" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-ancor-in-a" 'method) ((self #.(bullet-wrap::swig-lispify "bt-slider-constraint" 'classname)))
  (#.(bullet-wrap::swig-lispify "btSliderConstraint_getAncorInA" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-ancor-in-b" 'method) ((self #.(bullet-wrap::swig-lispify "bt-slider-constraint" 'classname)))
  (#.(bullet-wrap::swig-lispify "btSliderConstraint_getAncorInB" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-use-frame-offset" 'method) ((self #.(bullet-wrap::swig-lispify "bt-slider-constraint" 'classname)))
  (#.(bullet-wrap::swig-lispify "btSliderConstraint_getUseFrameOffset" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "set-use-frame-offset" 'method) ((self #.(bullet-wrap::swig-lispify "bt-slider-constraint" 'classname)) (frameOffsetOnOff t))
  (#.(bullet-wrap::swig-lispify "btSliderConstraint_setUseFrameOffset" 'function) (ff-pointer self) frameOffsetOnOff))

(cl:defmethod #.(bullet-wrap::swig-lispify "set-frames" 'method) ((self #.(bullet-wrap::swig-lispify "bt-slider-constraint" 'classname)) (frameA #.(bullet-wrap::swig-lispify "bt-transform" 'classname)) (frameB #.(bullet-wrap::swig-lispify "bt-transform" 'classname)))
  (#.(bullet-wrap::swig-lispify "btSliderConstraint_setFrames" 'function) (ff-pointer self) frameA frameB))

(cl:defmethod #.(bullet-wrap::swig-lispify "set-param" 'method) ((self #.(bullet-wrap::swig-lispify "bt-slider-constraint" 'classname)) (num cl:integer) (value cl:number) (axis cl:integer))
  (#.(bullet-wrap::swig-lispify "btSliderConstraint_setParam" 'function) (ff-pointer self) num value axis))

(cl:defmethod #.(bullet-wrap::swig-lispify "set-param" 'method) ((self #.(bullet-wrap::swig-lispify "bt-slider-constraint" 'classname)) (num cl:integer) (value cl:number))
  (#.(bullet-wrap::swig-lispify "btSliderConstraint_setParam" 'function) (ff-pointer self) num value))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-param" 'method) ((self #.(bullet-wrap::swig-lispify "bt-slider-constraint" 'classname)) (num cl:integer) (axis cl:integer))
  (#.(bullet-wrap::swig-lispify "btSliderConstraint_getParam" 'function) (ff-pointer self) num axis))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-param" 'method) ((self #.(bullet-wrap::swig-lispify "bt-slider-constraint" 'classname)) (num cl:integer))
  (#.(bullet-wrap::swig-lispify "btSliderConstraint_getParam" 'function) (ff-pointer self) num))

(cl:defmethod #.(bullet-wrap::swig-lispify "calculate-serialize-buffer-size" 'method) ((self #.(bullet-wrap::swig-lispify "bt-slider-constraint" 'classname)))
  (#.(bullet-wrap::swig-lispify "btSliderConstraint_calculateSerializeBufferSize" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "serialize" 'method) ((self #.(bullet-wrap::swig-lispify "bt-slider-constraint" 'classname)) dataBuffer (serializer #.(bullet-wrap::swig-lispify "bt-serializer" 'classname)))
  (#.(bullet-wrap::swig-lispify "btSliderConstraint_serialize" 'function) (ff-pointer self) dataBuffer serializer))


(cl:defclass #.(bullet-wrap::swig-lispify "bt-generic6-dof-spring-constraint" 'classname)(#.(bullet-wrap::swig-lispify "btGeneric6DofConstraint" 'classname))
  ((ff-pointer :reader ff-pointer)))

(cl:shadow "new")
(cl:defmethod #.(bullet-wrap::swig-lispify "new" 'method) ((self #.(bullet-wrap::swig-lispify "bt-generic6-dof-spring-constraint" 'classname)) sizeInBytes)
  (#.(bullet-wrap::swig-lispify "btGeneric6DofSpringConstraint_makeCPlusPlusInstance" 'function) (ff-pointer self) sizeInBytes))

(cl:shadow "delete")
(cl:defmethod #.(bullet-wrap::swig-lispify "delete" 'method) ((self #.(bullet-wrap::swig-lispify "bt-generic6-dof-spring-constraint" 'classname)) ptr)
  (#.(bullet-wrap::swig-lispify "btGeneric6DofSpringConstraint_deleteCPlusPlusInstance" 'function) (ff-pointer self) ptr))

(cl:shadow "new")
(cl:defmethod #.(bullet-wrap::swig-lispify "new" 'method) ((self #.(bullet-wrap::swig-lispify "bt-generic6-dof-spring-constraint" 'classname)) arg1 ptr)
  (#.(bullet-wrap::swig-lispify "btGeneric6DofSpringConstraint_makeCPlusPlusInstance" 'function) (ff-pointer self) arg1 ptr))

(cl:shadow "delete")
(cl:defmethod #.(bullet-wrap::swig-lispify "delete" 'method) ((self #.(bullet-wrap::swig-lispify "bt-generic6-dof-spring-constraint" 'classname)) arg1 arg2)
  (#.(bullet-wrap::swig-lispify "btGeneric6DofSpringConstraint_deleteCPlusPlusInstance" 'function) (ff-pointer self) arg1 arg2))

(cl:shadow "new[]")
(cl:defmethod #.(bullet-wrap::swig-lispify "new[]" 'method) ((self #.(bullet-wrap::swig-lispify "bt-generic6-dof-spring-constraint" 'classname)) sizeInBytes)
  (#.(bullet-wrap::swig-lispify "btGeneric6DofSpringConstraint_makeCPlusArray" 'function) (ff-pointer self) sizeInBytes))

(cl:shadow "delete[]")
(cl:defmethod #.(bullet-wrap::swig-lispify "delete[]" 'method) ((self #.(bullet-wrap::swig-lispify "bt-generic6-dof-spring-constraint" 'classname)) ptr)
  (#.(bullet-wrap::swig-lispify "btGeneric6DofSpringConstraint_deleteCPlusArray" 'function) (ff-pointer self) ptr))

(cl:shadow "new[]")
(cl:defmethod #.(bullet-wrap::swig-lispify "new[]" 'method) ((self #.(bullet-wrap::swig-lispify "bt-generic6-dof-spring-constraint" 'classname)) arg1 ptr)
  (#.(bullet-wrap::swig-lispify "btGeneric6DofSpringConstraint_makeCPlusArray" 'function) (ff-pointer self) arg1 ptr))

(cl:shadow "delete[]")
(cl:defmethod #.(bullet-wrap::swig-lispify "delete[]" 'method) ((self #.(bullet-wrap::swig-lispify "bt-generic6-dof-spring-constraint" 'classname)) arg1 arg2)
  (#.(bullet-wrap::swig-lispify "btGeneric6DofSpringConstraint_deleteCPlusArray" 'function) (ff-pointer self) arg1 arg2))

(cl:defmethod initialize-instance :after ((obj #.(bullet-wrap::swig-lispify "bt-generic6-dof-spring-constraint" 'class)) &key (rbA #.(bullet-wrap::swig-lispify "bt-rigid-body" 'classname)) (rbB #.(bullet-wrap::swig-lispify "bt-rigid-body" 'classname)) (frameInA #.(bullet-wrap::swig-lispify "bt-transform" 'classname)) (frameInB #.(bullet-wrap::swig-lispify "bt-transform" 'classname)) (useLinearReferenceFrameA t))
  (setf (slot-value obj 'ff-pointer) (#.(bullet-wrap::swig-lispify "new_btGeneric6DofSpringConstraint" 'function) rbA rbB frameInA frameInB useLinearReferenceFrameA)))

(cl:defmethod initialize-instance :after ((obj #.(bullet-wrap::swig-lispify "bt-generic6-dof-spring-constraint" 'class)) &key (rbB #.(bullet-wrap::swig-lispify "bt-rigid-body" 'classname)) (frameInB #.(bullet-wrap::swig-lispify "bt-transform" 'classname)) (useLinearReferenceFrameB t))
  (setf (slot-value obj 'ff-pointer) (#.(bullet-wrap::swig-lispify "new_btGeneric6DofSpringConstraint" 'function) rbB frameInB useLinearReferenceFrameB)))

(cl:defmethod #.(bullet-wrap::swig-lispify "enable-spring" 'method) ((self #.(bullet-wrap::swig-lispify "bt-generic6-dof-spring-constraint" 'classname)) (index cl:integer) (onOff t))
  (#.(bullet-wrap::swig-lispify "btGeneric6DofSpringConstraint_enableSpring" 'function) (ff-pointer self) index onOff))

(cl:defmethod #.(bullet-wrap::swig-lispify "set-stiffness" 'method) ((self #.(bullet-wrap::swig-lispify "bt-generic6-dof-spring-constraint" 'classname)) (index cl:integer) (stiffness cl:number))
  (#.(bullet-wrap::swig-lispify "btGeneric6DofSpringConstraint_setStiffness" 'function) (ff-pointer self) index stiffness))

(cl:defmethod #.(bullet-wrap::swig-lispify "set-damping" 'method) ((self #.(bullet-wrap::swig-lispify "bt-generic6-dof-spring-constraint" 'classname)) (index cl:integer) (damping cl:number))
  (#.(bullet-wrap::swig-lispify "btGeneric6DofSpringConstraint_setDamping" 'function) (ff-pointer self) index damping))

(cl:defmethod #.(bullet-wrap::swig-lispify "set-equilibrium-point" 'method) ((self #.(bullet-wrap::swig-lispify "bt-generic6-dof-spring-constraint" 'classname)))
  (#.(bullet-wrap::swig-lispify "btGeneric6DofSpringConstraint_setEquilibriumPoint" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "set-equilibrium-point" 'method) ((self #.(bullet-wrap::swig-lispify "bt-generic6-dof-spring-constraint" 'classname)) (index cl:integer))
  (#.(bullet-wrap::swig-lispify "btGeneric6DofSpringConstraint_setEquilibriumPoint" 'function) (ff-pointer self) index))

(cl:defmethod #.(bullet-wrap::swig-lispify "set-equilibrium-point" 'method) ((self #.(bullet-wrap::swig-lispify "bt-generic6-dof-spring-constraint" 'classname)) (index cl:integer) (val cl:number))
  (#.(bullet-wrap::swig-lispify "btGeneric6DofSpringConstraint_setEquilibriumPoint" 'function) (ff-pointer self) index val))

(cl:defmethod #.(bullet-wrap::swig-lispify "set-axis" 'method) ((self #.(bullet-wrap::swig-lispify "bt-generic6-dof-spring-constraint" 'classname)) (axis1 #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (axis2 #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)))
  (#.(bullet-wrap::swig-lispify "btGeneric6DofSpringConstraint_setAxis" 'function) (ff-pointer self) axis1 axis2))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-info2" 'method) ((self #.(bullet-wrap::swig-lispify "bt-generic6-dof-spring-constraint" 'classname)) info)
  (#.(bullet-wrap::swig-lispify "btGeneric6DofSpringConstraint_getInfo2" 'function) (ff-pointer self) info))

(cl:defmethod #.(bullet-wrap::swig-lispify "calculate-serialize-buffer-size" 'method) ((self #.(bullet-wrap::swig-lispify "bt-generic6-dof-spring-constraint" 'classname)))
  (#.(bullet-wrap::swig-lispify "btGeneric6DofSpringConstraint_calculateSerializeBufferSize" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "serialize" 'method) ((self #.(bullet-wrap::swig-lispify "bt-generic6-dof-spring-constraint" 'classname)) dataBuffer (serializer #.(bullet-wrap::swig-lispify "bt-serializer" 'classname)))
  (#.(bullet-wrap::swig-lispify "btGeneric6DofSpringConstraint_serialize" 'function) (ff-pointer self) dataBuffer serializer))


(cl:defclass #.(bullet-wrap::swig-lispify "bt-universal-constraint" 'classname)(#.(bullet-wrap::swig-lispify "btGeneric6DofConstraint" 'classname))
  ((ff-pointer :reader ff-pointer)))

(cl:shadow "new")
(cl:defmethod #.(bullet-wrap::swig-lispify "new" 'method) ((self #.(bullet-wrap::swig-lispify "bt-universal-constraint" 'classname)) sizeInBytes)
  (#.(bullet-wrap::swig-lispify "btUniversalConstraint_makeCPlusPlusInstance" 'function) (ff-pointer self) sizeInBytes))

(cl:shadow "delete")
(cl:defmethod #.(bullet-wrap::swig-lispify "delete" 'method) ((self #.(bullet-wrap::swig-lispify "bt-universal-constraint" 'classname)) ptr)
  (#.(bullet-wrap::swig-lispify "btUniversalConstraint_deleteCPlusPlusInstance" 'function) (ff-pointer self) ptr))

(cl:shadow "new")
(cl:defmethod #.(bullet-wrap::swig-lispify "new" 'method) ((self #.(bullet-wrap::swig-lispify "bt-universal-constraint" 'classname)) arg1 ptr)
  (#.(bullet-wrap::swig-lispify "btUniversalConstraint_makeCPlusPlusInstance" 'function) (ff-pointer self) arg1 ptr))

(cl:shadow "delete")
(cl:defmethod #.(bullet-wrap::swig-lispify "delete" 'method) ((self #.(bullet-wrap::swig-lispify "bt-universal-constraint" 'classname)) arg1 arg2)
  (#.(bullet-wrap::swig-lispify "btUniversalConstraint_deleteCPlusPlusInstance" 'function) (ff-pointer self) arg1 arg2))

(cl:shadow "new[]")
(cl:defmethod #.(bullet-wrap::swig-lispify "new[]" 'method) ((self #.(bullet-wrap::swig-lispify "bt-universal-constraint" 'classname)) sizeInBytes)
  (#.(bullet-wrap::swig-lispify "btUniversalConstraint_makeCPlusArray" 'function) (ff-pointer self) sizeInBytes))

(cl:shadow "delete[]")
(cl:defmethod #.(bullet-wrap::swig-lispify "delete[]" 'method) ((self #.(bullet-wrap::swig-lispify "bt-universal-constraint" 'classname)) ptr)
  (#.(bullet-wrap::swig-lispify "btUniversalConstraint_deleteCPlusArray" 'function) (ff-pointer self) ptr))

(cl:shadow "new[]")
(cl:defmethod #.(bullet-wrap::swig-lispify "new[]" 'method) ((self #.(bullet-wrap::swig-lispify "bt-universal-constraint" 'classname)) arg1 ptr)
  (#.(bullet-wrap::swig-lispify "btUniversalConstraint_makeCPlusArray" 'function) (ff-pointer self) arg1 ptr))

(cl:shadow "delete[]")
(cl:defmethod #.(bullet-wrap::swig-lispify "delete[]" 'method) ((self #.(bullet-wrap::swig-lispify "bt-universal-constraint" 'classname)) arg1 arg2)
  (#.(bullet-wrap::swig-lispify "btUniversalConstraint_deleteCPlusArray" 'function) (ff-pointer self) arg1 arg2))

(cl:defmethod initialize-instance :after ((obj #.(bullet-wrap::swig-lispify "bt-universal-constraint" 'class)) &key (rbA #.(bullet-wrap::swig-lispify "bt-rigid-body" 'classname)) (rbB #.(bullet-wrap::swig-lispify "bt-rigid-body" 'classname)) (anchor #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (axis1 #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (axis2 #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)))
  (setf (slot-value obj 'ff-pointer) (#.(bullet-wrap::swig-lispify "new_btUniversalConstraint" 'function) rbA rbB anchor axis1 axis2)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-anchor" 'method) ((self #.(bullet-wrap::swig-lispify "bt-universal-constraint" 'classname)))
  (#.(bullet-wrap::swig-lispify "btUniversalConstraint_getAnchor" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-anchor2" 'method) ((self #.(bullet-wrap::swig-lispify "bt-universal-constraint" 'classname)))
  (#.(bullet-wrap::swig-lispify "btUniversalConstraint_getAnchor2" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-axis1" 'method) ((self #.(bullet-wrap::swig-lispify "bt-universal-constraint" 'classname)))
  (#.(bullet-wrap::swig-lispify "btUniversalConstraint_getAxis1" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-axis2" 'method) ((self #.(bullet-wrap::swig-lispify "bt-universal-constraint" 'classname)))
  (#.(bullet-wrap::swig-lispify "btUniversalConstraint_getAxis2" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-angle1" 'method) ((self #.(bullet-wrap::swig-lispify "bt-universal-constraint" 'classname)))
  (#.(bullet-wrap::swig-lispify "btUniversalConstraint_getAngle1" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-angle2" 'method) ((self #.(bullet-wrap::swig-lispify "bt-universal-constraint" 'classname)))
  (#.(bullet-wrap::swig-lispify "btUniversalConstraint_getAngle2" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "set-upper-limit" 'method) ((self #.(bullet-wrap::swig-lispify "bt-universal-constraint" 'classname)) (ang1max cl:number) (ang2max cl:number))
  (#.(bullet-wrap::swig-lispify "btUniversalConstraint_setUpperLimit" 'function) (ff-pointer self) ang1max ang2max))

(cl:defmethod #.(bullet-wrap::swig-lispify "set-lower-limit" 'method) ((self #.(bullet-wrap::swig-lispify "bt-universal-constraint" 'classname)) (ang1min cl:number) (ang2min cl:number))
  (#.(bullet-wrap::swig-lispify "btUniversalConstraint_setLowerLimit" 'function) (ff-pointer self) ang1min ang2min))

(cl:defmethod #.(bullet-wrap::swig-lispify "set-axis" 'method) ((self #.(bullet-wrap::swig-lispify "bt-universal-constraint" 'classname)) (axis1 #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (axis2 #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)))
  (#.(bullet-wrap::swig-lispify "btUniversalConstraint_setAxis" 'function) (ff-pointer self) axis1 axis2))


(cl:defclass #.(bullet-wrap::swig-lispify "bt-hinge2-constraint" 'classname)(#.(bullet-wrap::swig-lispify "btGeneric6DofSpringConstraint" 'classname))
  ((ff-pointer :reader ff-pointer)))

(cl:shadow "new")
(cl:defmethod #.(bullet-wrap::swig-lispify "new" 'method) ((self #.(bullet-wrap::swig-lispify "bt-hinge2-constraint" 'classname)) sizeInBytes)
  (#.(bullet-wrap::swig-lispify "btHinge2Constraint_makeCPlusPlusInstance" 'function) (ff-pointer self) sizeInBytes))

(cl:shadow "delete")
(cl:defmethod #.(bullet-wrap::swig-lispify "delete" 'method) ((self #.(bullet-wrap::swig-lispify "bt-hinge2-constraint" 'classname)) ptr)
  (#.(bullet-wrap::swig-lispify "btHinge2Constraint_deleteCPlusPlusInstance" 'function) (ff-pointer self) ptr))

(cl:shadow "new")
(cl:defmethod #.(bullet-wrap::swig-lispify "new" 'method) ((self #.(bullet-wrap::swig-lispify "bt-hinge2-constraint" 'classname)) arg1 ptr)
  (#.(bullet-wrap::swig-lispify "btHinge2Constraint_makeCPlusPlusInstance" 'function) (ff-pointer self) arg1 ptr))

(cl:shadow "delete")
(cl:defmethod #.(bullet-wrap::swig-lispify "delete" 'method) ((self #.(bullet-wrap::swig-lispify "bt-hinge2-constraint" 'classname)) arg1 arg2)
  (#.(bullet-wrap::swig-lispify "btHinge2Constraint_deleteCPlusPlusInstance" 'function) (ff-pointer self) arg1 arg2))

(cl:shadow "new[]")
(cl:defmethod #.(bullet-wrap::swig-lispify "new[]" 'method) ((self #.(bullet-wrap::swig-lispify "bt-hinge2-constraint" 'classname)) sizeInBytes)
  (#.(bullet-wrap::swig-lispify "btHinge2Constraint_makeCPlusArray" 'function) (ff-pointer self) sizeInBytes))

(cl:shadow "delete[]")
(cl:defmethod #.(bullet-wrap::swig-lispify "delete[]" 'method) ((self #.(bullet-wrap::swig-lispify "bt-hinge2-constraint" 'classname)) ptr)
  (#.(bullet-wrap::swig-lispify "btHinge2Constraint_deleteCPlusArray" 'function) (ff-pointer self) ptr))

(cl:shadow "new[]")
(cl:defmethod #.(bullet-wrap::swig-lispify "new[]" 'method) ((self #.(bullet-wrap::swig-lispify "bt-hinge2-constraint" 'classname)) arg1 ptr)
  (#.(bullet-wrap::swig-lispify "btHinge2Constraint_makeCPlusArray" 'function) (ff-pointer self) arg1 ptr))

(cl:shadow "delete[]")
(cl:defmethod #.(bullet-wrap::swig-lispify "delete[]" 'method) ((self #.(bullet-wrap::swig-lispify "bt-hinge2-constraint" 'classname)) arg1 arg2)
  (#.(bullet-wrap::swig-lispify "btHinge2Constraint_deleteCPlusArray" 'function) (ff-pointer self) arg1 arg2))

(cl:defmethod initialize-instance :after ((obj #.(bullet-wrap::swig-lispify "bt-hinge2-constraint" 'class)) &key (rbA #.(bullet-wrap::swig-lispify "bt-rigid-body" 'classname)) (rbB #.(bullet-wrap::swig-lispify "bt-rigid-body" 'classname)) (anchor #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (axis1 #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (axis2 #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)))
  (setf (slot-value obj 'ff-pointer) (#.(bullet-wrap::swig-lispify "new_btHinge2Constraint" 'function) rbA rbB anchor axis1 axis2)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-anchor" 'method) ((self #.(bullet-wrap::swig-lispify "bt-hinge2-constraint" 'classname)))
  (#.(bullet-wrap::swig-lispify "btHinge2Constraint_getAnchor" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-anchor2" 'method) ((self #.(bullet-wrap::swig-lispify "bt-hinge2-constraint" 'classname)))
  (#.(bullet-wrap::swig-lispify "btHinge2Constraint_getAnchor2" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-axis1" 'method) ((self #.(bullet-wrap::swig-lispify "bt-hinge2-constraint" 'classname)))
  (#.(bullet-wrap::swig-lispify "btHinge2Constraint_getAxis1" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-axis2" 'method) ((self #.(bullet-wrap::swig-lispify "bt-hinge2-constraint" 'classname)))
  (#.(bullet-wrap::swig-lispify "btHinge2Constraint_getAxis2" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-angle1" 'method) ((self #.(bullet-wrap::swig-lispify "bt-hinge2-constraint" 'classname)))
  (#.(bullet-wrap::swig-lispify "btHinge2Constraint_getAngle1" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-angle2" 'method) ((self #.(bullet-wrap::swig-lispify "bt-hinge2-constraint" 'classname)))
  (#.(bullet-wrap::swig-lispify "btHinge2Constraint_getAngle2" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "set-upper-limit" 'method) ((self #.(bullet-wrap::swig-lispify "bt-hinge2-constraint" 'classname)) (ang1max cl:number))
  (#.(bullet-wrap::swig-lispify "btHinge2Constraint_setUpperLimit" 'function) (ff-pointer self) ang1max))

(cl:defmethod #.(bullet-wrap::swig-lispify "set-lower-limit" 'method) ((self #.(bullet-wrap::swig-lispify "bt-hinge2-constraint" 'classname)) (ang1min cl:number))
  (#.(bullet-wrap::swig-lispify "btHinge2Constraint_setLowerLimit" 'function) (ff-pointer self) ang1min))


(cl:defclass #.(bullet-wrap::swig-lispify "bt-gear-constraint" 'classname)(#.(bullet-wrap::swig-lispify "btTypedConstraint" 'classname))
  ((ff-pointer :reader ff-pointer)))

(cl:defmethod initialize-instance :after ((obj #.(bullet-wrap::swig-lispify "bt-gear-constraint" 'class)) &key (rbA #.(bullet-wrap::swig-lispify "bt-rigid-body" 'classname)) (rbB #.(bullet-wrap::swig-lispify "bt-rigid-body" 'classname)) (axisInA #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (axisInB #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (ratio cl:number))
  (setf (slot-value obj 'ff-pointer) (#.(bullet-wrap::swig-lispify "new_btGearConstraint" 'function) rbA rbB axisInA axisInB ratio)))

(cl:defmethod initialize-instance :after ((obj #.(bullet-wrap::swig-lispify "bt-gear-constraint" 'class)) &key (rbA #.(bullet-wrap::swig-lispify "bt-rigid-body" 'classname)) (rbB #.(bullet-wrap::swig-lispify "bt-rigid-body" 'classname)) (axisInA #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)) (axisInB #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)))
  (setf (slot-value obj 'ff-pointer) (#.(bullet-wrap::swig-lispify "new_btGearConstraint" 'function) rbA rbB axisInA axisInB)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-info1" 'method) ((self #.(bullet-wrap::swig-lispify "bt-gear-constraint" 'classname)) info)
  (#.(bullet-wrap::swig-lispify "btGearConstraint_getInfo1" 'function) (ff-pointer self) info))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-info2" 'method) ((self #.(bullet-wrap::swig-lispify "bt-gear-constraint" 'classname)) info)
  (#.(bullet-wrap::swig-lispify "btGearConstraint_getInfo2" 'function) (ff-pointer self) info))

(cl:defmethod #.(bullet-wrap::swig-lispify "set-axis-a" 'method) ((self #.(bullet-wrap::swig-lispify "bt-gear-constraint" 'classname)) (axisA #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)))
  (#.(bullet-wrap::swig-lispify "btGearConstraint_setAxisA" 'function) (ff-pointer self) axisA))

(cl:defmethod #.(bullet-wrap::swig-lispify "set-axis-b" 'method) ((self #.(bullet-wrap::swig-lispify "bt-gear-constraint" 'classname)) (axisB #.(bullet-wrap::swig-lispify "bt-vector3" 'classname)))
  (#.(bullet-wrap::swig-lispify "btGearConstraint_setAxisB" 'function) (ff-pointer self) axisB))

(cl:defmethod #.(bullet-wrap::swig-lispify "set-ratio" 'method) ((self #.(bullet-wrap::swig-lispify "bt-gear-constraint" 'classname)) (ratio cl:number))
  (#.(bullet-wrap::swig-lispify "btGearConstraint_setRatio" 'function) (ff-pointer self) ratio))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-axis-a" 'method) ((self #.(bullet-wrap::swig-lispify "bt-gear-constraint" 'classname)))
  (#.(bullet-wrap::swig-lispify "btGearConstraint_getAxisA" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-axis-b" 'method) ((self #.(bullet-wrap::swig-lispify "bt-gear-constraint" 'classname)))
  (#.(bullet-wrap::swig-lispify "btGearConstraint_getAxisB" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-ratio" 'method) ((self #.(bullet-wrap::swig-lispify "bt-gear-constraint" 'classname)))
  (#.(bullet-wrap::swig-lispify "btGearConstraint_getRatio" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "set-param" 'method) ((self #.(bullet-wrap::swig-lispify "bt-gear-constraint" 'classname)) (num cl:integer) (value cl:number) (axis cl:integer))
  (#.(bullet-wrap::swig-lispify "btGearConstraint_setParam" 'function) (ff-pointer self) num value axis))

(cl:defmethod #.(bullet-wrap::swig-lispify "set-param" 'method) ((self #.(bullet-wrap::swig-lispify "bt-gear-constraint" 'classname)) (num cl:integer) (value cl:number))
  (#.(bullet-wrap::swig-lispify "btGearConstraint_setParam" 'function) (ff-pointer self) num value))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-param" 'method) ((self #.(bullet-wrap::swig-lispify "bt-gear-constraint" 'classname)) (num cl:integer) (axis cl:integer))
  (#.(bullet-wrap::swig-lispify "btGearConstraint_getParam" 'function) (ff-pointer self) num axis))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-param" 'method) ((self #.(bullet-wrap::swig-lispify "bt-gear-constraint" 'classname)) (num cl:integer))
  (#.(bullet-wrap::swig-lispify "btGearConstraint_getParam" 'function) (ff-pointer self) num))

(cl:defmethod #.(bullet-wrap::swig-lispify "calculate-serialize-buffer-size" 'method) ((self #.(bullet-wrap::swig-lispify "bt-gear-constraint" 'classname)))
  (#.(bullet-wrap::swig-lispify "btGearConstraint_calculateSerializeBufferSize" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "serialize" 'method) ((self #.(bullet-wrap::swig-lispify "bt-gear-constraint" 'classname)) dataBuffer (serializer #.(bullet-wrap::swig-lispify "bt-serializer" 'classname)))
  (#.(bullet-wrap::swig-lispify "btGearConstraint_serialize" 'function) (ff-pointer self) dataBuffer serializer))


(cl:defclass #.(bullet-wrap::swig-lispify "bt-fixed-constraint" 'classname)(#.(bullet-wrap::swig-lispify "btTypedConstraint" 'classname))
  ((ff-pointer :reader ff-pointer)))

(cl:defmethod initialize-instance :after ((obj #.(bullet-wrap::swig-lispify "bt-fixed-constraint" 'class)) &key (rbA #.(bullet-wrap::swig-lispify "bt-rigid-body" 'classname)) (rbB #.(bullet-wrap::swig-lispify "bt-rigid-body" 'classname)) (frameInA #.(bullet-wrap::swig-lispify "bt-transform" 'classname)) (frameInB #.(bullet-wrap::swig-lispify "bt-transform" 'classname)))
  (setf (slot-value obj 'ff-pointer) (#.(bullet-wrap::swig-lispify "new_btFixedConstraint" 'function) rbA rbB frameInA frameInB)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-info1" 'method) ((self #.(bullet-wrap::swig-lispify "bt-fixed-constraint" 'classname)) info)
  (#.(bullet-wrap::swig-lispify "btFixedConstraint_getInfo1" 'function) (ff-pointer self) info))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-info2" 'method) ((self #.(bullet-wrap::swig-lispify "bt-fixed-constraint" 'classname)) info)
  (#.(bullet-wrap::swig-lispify "btFixedConstraint_getInfo2" 'function) (ff-pointer self) info))

(cl:defmethod #.(bullet-wrap::swig-lispify "set-param" 'method) ((self #.(bullet-wrap::swig-lispify "bt-fixed-constraint" 'classname)) (num cl:integer) (value cl:number) (axis cl:integer))
  (#.(bullet-wrap::swig-lispify "btFixedConstraint_setParam" 'function) (ff-pointer self) num value axis))

(cl:defmethod #.(bullet-wrap::swig-lispify "set-param" 'method) ((self #.(bullet-wrap::swig-lispify "bt-fixed-constraint" 'classname)) (num cl:integer) (value cl:number))
  (#.(bullet-wrap::swig-lispify "btFixedConstraint_setParam" 'function) (ff-pointer self) num value))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-param" 'method) ((self #.(bullet-wrap::swig-lispify "bt-fixed-constraint" 'classname)) (num cl:integer) (axis cl:integer))
  (#.(bullet-wrap::swig-lispify "btFixedConstraint_getParam" 'function) (ff-pointer self) num axis))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-param" 'method) ((self #.(bullet-wrap::swig-lispify "bt-fixed-constraint" 'classname)) (num cl:integer))
  (#.(bullet-wrap::swig-lispify "btFixedConstraint_getParam" 'function) (ff-pointer self) num))


(cl:defclass #.(bullet-wrap::swig-lispify "bt-sequential-impulse-constraint-solver" 'classname)()
  ((ff-pointer :reader ff-pointer)))

(cl:shadow "new")
(cl:defmethod #.(bullet-wrap::swig-lispify "new" 'method) ((self #.(bullet-wrap::swig-lispify "bt-sequential-impulse-constraint-solver" 'classname)) sizeInBytes)
  (#.(bullet-wrap::swig-lispify "btSequentialImpulseConstraintSolver_makeCPlusPlusInstance" 'function) (ff-pointer self) sizeInBytes))

(cl:shadow "delete")
(cl:defmethod #.(bullet-wrap::swig-lispify "delete" 'method) ((self #.(bullet-wrap::swig-lispify "bt-sequential-impulse-constraint-solver" 'classname)) ptr)
  (#.(bullet-wrap::swig-lispify "btSequentialImpulseConstraintSolver_deleteCPlusPlusInstance" 'function) (ff-pointer self) ptr))

(cl:shadow "new")
(cl:defmethod #.(bullet-wrap::swig-lispify "new" 'method) ((self #.(bullet-wrap::swig-lispify "bt-sequential-impulse-constraint-solver" 'classname)) arg1 ptr)
  (#.(bullet-wrap::swig-lispify "btSequentialImpulseConstraintSolver_makeCPlusPlusInstance" 'function) (ff-pointer self) arg1 ptr))

(cl:shadow "delete")
(cl:defmethod #.(bullet-wrap::swig-lispify "delete" 'method) ((self #.(bullet-wrap::swig-lispify "bt-sequential-impulse-constraint-solver" 'classname)) arg1 arg2)
  (#.(bullet-wrap::swig-lispify "btSequentialImpulseConstraintSolver_deleteCPlusPlusInstance" 'function) (ff-pointer self) arg1 arg2))

(cl:shadow "new[]")
(cl:defmethod #.(bullet-wrap::swig-lispify "new[]" 'method) ((self #.(bullet-wrap::swig-lispify "bt-sequential-impulse-constraint-solver" 'classname)) sizeInBytes)
  (#.(bullet-wrap::swig-lispify "btSequentialImpulseConstraintSolver_makeCPlusArray" 'function) (ff-pointer self) sizeInBytes))

(cl:shadow "delete[]")
(cl:defmethod #.(bullet-wrap::swig-lispify "delete[]" 'method) ((self #.(bullet-wrap::swig-lispify "bt-sequential-impulse-constraint-solver" 'classname)) ptr)
  (#.(bullet-wrap::swig-lispify "btSequentialImpulseConstraintSolver_deleteCPlusArray" 'function) (ff-pointer self) ptr))

(cl:shadow "new[]")
(cl:defmethod #.(bullet-wrap::swig-lispify "new[]" 'method) ((self #.(bullet-wrap::swig-lispify "bt-sequential-impulse-constraint-solver" 'classname)) arg1 ptr)
  (#.(bullet-wrap::swig-lispify "btSequentialImpulseConstraintSolver_makeCPlusArray" 'function) (ff-pointer self) arg1 ptr))

(cl:shadow "delete[]")
(cl:defmethod #.(bullet-wrap::swig-lispify "delete[]" 'method) ((self #.(bullet-wrap::swig-lispify "bt-sequential-impulse-constraint-solver" 'classname)) arg1 arg2)
  (#.(bullet-wrap::swig-lispify "btSequentialImpulseConstraintSolver_deleteCPlusArray" 'function) (ff-pointer self) arg1 arg2))

(cl:defmethod initialize-instance :after ((obj #.(bullet-wrap::swig-lispify "bt-sequential-impulse-constraint-solver" 'class)) &key)
  (setf (slot-value obj 'ff-pointer) (#.(bullet-wrap::swig-lispify "new_btSequentialImpulseConstraintSolver" 'function))))

(cl:defmethod #.(bullet-wrap::swig-lispify "solve-group" 'method) ((self #.(bullet-wrap::swig-lispify "bt-sequential-impulse-constraint-solver" 'classname)) bodies (numBodies cl:integer) manifold (numManifolds cl:integer) constraints (numConstraints cl:integer) info (debugDrawer #.(bullet-wrap::swig-lispify "bt-idebug-draw" 'classname)) dispatcher)
  (#.(bullet-wrap::swig-lispify "btSequentialImpulseConstraintSolver_solveGroup" 'function) (ff-pointer self) bodies numBodies manifold numManifolds constraints numConstraints info debugDrawer dispatcher))

(cl:defmethod #.(bullet-wrap::swig-lispify "reset" 'method) ((self #.(bullet-wrap::swig-lispify "bt-sequential-impulse-constraint-solver" 'classname)))
  (#.(bullet-wrap::swig-lispify "btSequentialImpulseConstraintSolver_reset" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "bt-rand2" 'method) ((self #.(bullet-wrap::swig-lispify "bt-sequential-impulse-constraint-solver" 'classname)))
  (#.(bullet-wrap::swig-lispify "btSequentialImpulseConstraintSolver_btRand2" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "bt-rand-int2" 'method) ((self #.(bullet-wrap::swig-lispify "bt-sequential-impulse-constraint-solver" 'classname)) (n cl:integer))
  (#.(bullet-wrap::swig-lispify "btSequentialImpulseConstraintSolver_btRandInt2" 'function) (ff-pointer self) n))

(cl:defmethod #.(bullet-wrap::swig-lispify "set-rand-seed" 'method) ((self #.(bullet-wrap::swig-lispify "bt-sequential-impulse-constraint-solver" 'classname)) (seed cl:integer))
  (#.(bullet-wrap::swig-lispify "btSequentialImpulseConstraintSolver_setRandSeed" 'function) (ff-pointer self) seed))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-rand-seed" 'method) ((self #.(bullet-wrap::swig-lispify "bt-sequential-impulse-constraint-solver" 'classname)))
  (#.(bullet-wrap::swig-lispify "btSequentialImpulseConstraintSolver_getRandSeed" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-solver-type" 'method) ((self #.(bullet-wrap::swig-lispify "bt-sequential-impulse-constraint-solver" 'classname)))
  (#.(bullet-wrap::swig-lispify "btSequentialImpulseConstraintSolver_getSolverType" 'function) (ff-pointer self)))

