++ b/bullet.lisp
@ -242,1667 +242,16057 @@
(cl:defconstant #.(bullet-wrap::swig-lispify "BT_BULLET_VERSION" 'constant) 282)

(cl:export '#.(bullet-wrap::swig-lispify "BT_BULLET_VERSION" 'constant))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btGetVersion" 'function)))

(cffi:defcfun ("_wrap_btGetVersion" #.(bullet-wrap::swig-lispify "btGetVersion" 'function)) :int)

(cl:export '#.(bullet-wrap::swig-lispify "btGetVersion" 'function))

(cl:defconstant #.(bullet-wrap::swig-lispify "BT_LARGE_FLOAT" 'constant) 1d18)

(cl:export '#.(bullet-wrap::swig-lispify "BT_LARGE_FLOAT" 'constant))

(cffi:defcvar ("btInfinityMask" #.(bullet-wrap::swig-lispify "btInfinityMask" 'variable))
 :int)

(cl:export '#.(bullet-wrap::swig-lispify "btInfinityMask" 'variable))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btGetInfinityMask" 'function)))

(cffi:defcfun ("_wrap_btGetInfinityMask" #.(bullet-wrap::swig-lispify "btGetInfinityMask" 'function)) :int)

(cl:export '#.(bullet-wrap::swig-lispify "btGetInfinityMask" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btSqrt" 'function)))

(cffi:defcfun ("_wrap_btSqrt" #.(bullet-wrap::swig-lispify "btSqrt" 'function)) :float
  (y :float))

(cl:export '#.(bullet-wrap::swig-lispify "btSqrt" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btFabs" 'function)))

(cffi:defcfun ("_wrap_btFabs" #.(bullet-wrap::swig-lispify "btFabs" 'function)) :float
  (x :float))

(cl:export '#.(bullet-wrap::swig-lispify "btFabs" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCos" 'function)))

(cffi:defcfun ("_wrap_btCos" #.(bullet-wrap::swig-lispify "btCos" 'function)) :float
  (x :float))

(cl:export '#.(bullet-wrap::swig-lispify "btCos" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btSin" 'function)))

(cffi:defcfun ("_wrap_btSin" #.(bullet-wrap::swig-lispify "btSin" 'function)) :float
  (x :float))

(cl:export '#.(bullet-wrap::swig-lispify "btSin" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btTan" 'function)))

(cffi:defcfun ("_wrap_btTan" #.(bullet-wrap::swig-lispify "btTan" 'function)) :float
  (x :float))

(cl:export '#.(bullet-wrap::swig-lispify "btTan" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btAcos" 'function)))

(cffi:defcfun ("_wrap_btAcos" #.(bullet-wrap::swig-lispify "btAcos" 'function)) :float
  (x :float))

(cl:export '#.(bullet-wrap::swig-lispify "btAcos" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btAsin" 'function)))

(cffi:defcfun ("_wrap_btAsin" #.(bullet-wrap::swig-lispify "btAsin" 'function)) :float
  (x :float))

(cl:export '#.(bullet-wrap::swig-lispify "btAsin" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btAtan" 'function)))

(cffi:defcfun ("_wrap_btAtan" #.(bullet-wrap::swig-lispify "btAtan" 'function)) :float
  (x :float))

(cl:export '#.(bullet-wrap::swig-lispify "btAtan" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btAtan2" 'function)))

(cffi:defcfun ("_wrap_btAtan2" #.(bullet-wrap::swig-lispify "btAtan2" 'function)) :float
  (x :float)
  (y :float))

(cl:export '#.(bullet-wrap::swig-lispify "btAtan2" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btExp" 'function)))

(cffi:defcfun ("_wrap_btExp" #.(bullet-wrap::swig-lispify "btExp" 'function)) :float
  (x :float))

(cl:export '#.(bullet-wrap::swig-lispify "btExp" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btLog" 'function)))

(cffi:defcfun ("_wrap_btLog" #.(bullet-wrap::swig-lispify "btLog" 'function)) :float
  (x :float))

(cl:export '#.(bullet-wrap::swig-lispify "btLog" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btPow" 'function)))

(cffi:defcfun ("_wrap_btPow" #.(bullet-wrap::swig-lispify "btPow" 'function)) :float
  (x :float)
  (y :float))

(cl:export '#.(bullet-wrap::swig-lispify "btPow" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btFmod" 'function)))

(cffi:defcfun ("_wrap_btFmod" #.(bullet-wrap::swig-lispify "btFmod" 'function)) :float
  (x :float)
  (y :float))

(cl:export '#.(bullet-wrap::swig-lispify "btFmod" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btAtan2Fast" 'function)))

(cffi:defcfun ("_wrap_btAtan2Fast" #.(bullet-wrap::swig-lispify "btAtan2Fast" 'function)) :float
  (y :float)
  (x :float))

(cl:export '#.(bullet-wrap::swig-lispify "btAtan2Fast" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btFuzzyZero" 'function)))

(cffi:defcfun ("_wrap_btFuzzyZero" #.(bullet-wrap::swig-lispify "btFuzzyZero" 'function)) :pointer
  (x :float))

(cl:export '#.(bullet-wrap::swig-lispify "btFuzzyZero" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btEqual" 'function)))

(cffi:defcfun ("_wrap_btEqual" #.(bullet-wrap::swig-lispify "btEqual" 'function)) :pointer
  (a :float)
  (eps :float))

(cl:export '#.(bullet-wrap::swig-lispify "btEqual" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btGreaterEqual" 'function)))

(cffi:defcfun ("_wrap_btGreaterEqual" #.(bullet-wrap::swig-lispify "btGreaterEqual" 'function)) :pointer
  (a :float)
  (eps :float))

(cl:export '#.(bullet-wrap::swig-lispify "btGreaterEqual" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btIsNegative" 'function)))

(cffi:defcfun ("_wrap_btIsNegative" #.(bullet-wrap::swig-lispify "btIsNegative" 'function)) :int
  (x :float))

(cl:export '#.(bullet-wrap::swig-lispify "btIsNegative" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btRadians" 'function)))

(cffi:defcfun ("_wrap_btRadians" #.(bullet-wrap::swig-lispify "btRadians" 'function)) :float
  (x :float))

(cl:export '#.(bullet-wrap::swig-lispify "btRadians" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btDegrees" 'function)))

(cffi:defcfun ("_wrap_btDegrees" #.(bullet-wrap::swig-lispify "btDegrees" 'function)) :float
  (x :float))

(cl:export '#.(bullet-wrap::swig-lispify "btDegrees" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btFsel" 'function)))

(cffi:defcfun ("_wrap_btFsel" #.(bullet-wrap::swig-lispify "btFsel" 'function)) :float
  (a :float)
  (b :float)
  (c :float))

(cl:export '#.(bullet-wrap::swig-lispify "btFsel" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btMachineIsLittleEndian" 'function)))

(cffi:defcfun ("_wrap_btMachineIsLittleEndian" #.(bullet-wrap::swig-lispify "btMachineIsLittleEndian" 'function)) :pointer)

(cl:export '#.(bullet-wrap::swig-lispify "btMachineIsLittleEndian" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btSelect" 'function)))

(cffi:defcfun ("_wrap_btSelect__SWIG_0" #.(bullet-wrap::swig-lispify "btSelect" 'function)) :unsigned-int
  (condition :unsigned-int)
  (valueIfConditionNonZero :unsigned-int)
  (valueIfConditionZero :unsigned-int))

(cl:export '#.(bullet-wrap::swig-lispify "btSelect" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btSelect" 'function)))

(cffi:defcfun ("_wrap_btSelect__SWIG_1" #.(bullet-wrap::swig-lispify "btSelect" 'function)) :int
  (condition :unsigned-int)
  (valueIfConditionNonZero :int)
  (valueIfConditionZero :int))

(cl:export '#.(bullet-wrap::swig-lispify "btSelect" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btSelect" 'function)))

(cffi:defcfun ("_wrap_btSelect__SWIG_2" #.(bullet-wrap::swig-lispify "btSelect" 'function)) :float
  (condition :unsigned-int)
  (valueIfConditionNonZero :float)
  (valueIfConditionZero :float))

(cl:export '#.(bullet-wrap::swig-lispify "btSelect" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btSwapEndian" 'function)))

(cffi:defcfun ("_wrap_btSwapEndian__SWIG_0" #.(bullet-wrap::swig-lispify "btSwapEndian" 'function)) :unsigned-int
  (val :unsigned-int))

(cl:export '#.(bullet-wrap::swig-lispify "btSwapEndian" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btSwapEndian" 'function)))

(cffi:defcfun ("_wrap_btSwapEndian__SWIG_1" #.(bullet-wrap::swig-lispify "btSwapEndian" 'function)) :unsigned-short
  (val :unsigned-short))

(cl:export '#.(bullet-wrap::swig-lispify "btSwapEndian" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btSwapEndian" 'function)))

(cffi:defcfun ("_wrap_btSwapEndian__SWIG_2" #.(bullet-wrap::swig-lispify "btSwapEndian" 'function)) :unsigned-int
  (val :int))

(cl:export '#.(bullet-wrap::swig-lispify "btSwapEndian" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btSwapEndian" 'function)))

(cffi:defcfun ("_wrap_btSwapEndian__SWIG_3" #.(bullet-wrap::swig-lispify "btSwapEndian" 'function)) :unsigned-short
  (val :short))

(cl:export '#.(bullet-wrap::swig-lispify "btSwapEndian" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btSwapEndianFloat" 'function)))

(cffi:defcfun ("_wrap_btSwapEndianFloat" #.(bullet-wrap::swig-lispify "btSwapEndianFloat" 'function)) :unsigned-int
  (d :float))

(cl:export '#.(bullet-wrap::swig-lispify "btSwapEndianFloat" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btUnswapEndianFloat" 'function)))

(cffi:defcfun ("_wrap_btUnswapEndianFloat" #.(bullet-wrap::swig-lispify "btUnswapEndianFloat" 'function)) :float
  (a :unsigned-int))

(cl:export '#.(bullet-wrap::swig-lispify "btUnswapEndianFloat" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btSwapEndianDouble" 'function)))

(cffi:defcfun ("_wrap_btSwapEndianDouble" #.(bullet-wrap::swig-lispify "btSwapEndianDouble" 'function)) :void
  (d :double)
  (dst :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btSwapEndianDouble" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btUnswapEndianDouble" 'function)))

(cffi:defcfun ("_wrap_btUnswapEndianDouble" #.(bullet-wrap::swig-lispify "btUnswapEndianDouble" 'function)) :double
  (src :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btUnswapEndianDouble" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btLargeDot" 'function)))

(cffi:defcfun ("_wrap_btLargeDot" #.(bullet-wrap::swig-lispify "btLargeDot" 'function)) :float
  (a :pointer)
  (b :pointer)
  (n :int))

(cl:export '#.(bullet-wrap::swig-lispify "btLargeDot" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btNormalizeAngle" 'function)))

(cffi:defcfun ("_wrap_btNormalizeAngle" #.(bullet-wrap::swig-lispify "btNormalizeAngle" 'function)) :float
  (angleInRadians :float))

(cl:export '#.(bullet-wrap::swig-lispify "btNormalizeAngle" 'function))

(cffi:defcstruct #.(bullet-wrap::swig-lispify "btTypedObject" 'classname)
	(#.(bullet-wrap::swig-lispify "m_objectType" 'slotname) :int)
	(#.(bullet-wrap::swig-lispify "getObjectType" 'slotname) :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btTypedObject" 'classname))

(cl:export '#.(bullet-wrap::swig-lispify "m_objectType" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "getObjectType" 'slotname))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btAlignedAllocInternal" 'function)))

(cffi:defcfun ("_wrap_btAlignedAllocInternal" #.(bullet-wrap::swig-lispify "btAlignedAllocInternal" 'function)) :pointer
  (size :pointer)
  (alignment :int))

(cl:export '#.(bullet-wrap::swig-lispify "btAlignedAllocInternal" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btAlignedFreeInternal" 'function)))

(cffi:defcfun ("_wrap_btAlignedFreeInternal" #.(bullet-wrap::swig-lispify "btAlignedFreeInternal" 'function)) :void
  (ptr :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btAlignedFreeInternal" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btAlignedAllocSetCustom" 'function)))

(cffi:defcfun ("_wrap_btAlignedAllocSetCustom" #.(bullet-wrap::swig-lispify "btAlignedAllocSetCustom" 'function)) :void
  (allocFunc :pointer)
  (freeFunc :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btAlignedAllocSetCustom" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btAlignedAllocSetCustomAligned" 'function)))

(cffi:defcfun ("_wrap_btAlignedAllocSetCustomAligned" #.(bullet-wrap::swig-lispify "btAlignedAllocSetCustomAligned" 'function)) :void
  (allocFunc :pointer)
  (freeFunc :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btAlignedAllocSetCustomAligned" 'function))

(cl:defconstant #.(bullet-wrap::swig-lispify "btVector3DataName" 'constant) "btVector3FloatData")

(cl:export '#.(bullet-wrap::swig-lispify "btVector3DataName" 'constant))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btVector3_makeCPlusPlusInstance" 'function)))

(cffi:defcfun ("_wrap_btVector3_makeCPlusPlusInstance__SWIG_0" #.(bullet-wrap::swig-lispify "btVector3_makeCPlusPlusInstance" 'function)) :pointer
  (self :pointer)
  (sizeInBytes :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btVector3_makeCPlusPlusInstance" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btVector3_deleteCPlusPlusInstance" 'function)))

(cffi:defcfun ("_wrap_btVector3_deleteCPlusPlusInstance__SWIG_0" #.(bullet-wrap::swig-lispify "btVector3_deleteCPlusPlusInstance" 'function)) :void
  (self :pointer)
  (ptr :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btVector3_deleteCPlusPlusInstance" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btVector3_makeCPlusPlusInstance" 'function)))

(cffi:defcfun ("_wrap_btVector3_makeCPlusPlusInstance__SWIG_1" #.(bullet-wrap::swig-lispify "btVector3_makeCPlusPlusInstance" 'function)) :pointer
  (self :pointer)
  (arg1 :pointer)
  (ptr :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btVector3_makeCPlusPlusInstance" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btVector3_deleteCPlusPlusInstance" 'function)))

(cffi:defcfun ("_wrap_btVector3_deleteCPlusPlusInstance__SWIG_1" #.(bullet-wrap::swig-lispify "btVector3_deleteCPlusPlusInstance" 'function)) :void
  (self :pointer)
  (arg1 :pointer)
  (arg2 :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btVector3_deleteCPlusPlusInstance" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btVector3_makeCPlusArray" 'function)))

(cffi:defcfun ("_wrap_btVector3_makeCPlusArray__SWIG_0" #.(bullet-wrap::swig-lispify "btVector3_makeCPlusArray" 'function)) :pointer
  (self :pointer)
  (sizeInBytes :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btVector3_makeCPlusArray" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btVector3_deleteCPlusArray" 'function)))

(cffi:defcfun ("_wrap_btVector3_deleteCPlusArray__SWIG_0" #.(bullet-wrap::swig-lispify "btVector3_deleteCPlusArray" 'function)) :void
  (self :pointer)
  (ptr :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btVector3_deleteCPlusArray" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btVector3_makeCPlusArray" 'function)))

(cffi:defcfun ("_wrap_btVector3_makeCPlusArray__SWIG_1" #.(bullet-wrap::swig-lispify "btVector3_makeCPlusArray" 'function)) :pointer
  (self :pointer)
  (arg1 :pointer)
  (ptr :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btVector3_makeCPlusArray" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btVector3_deleteCPlusArray" 'function)))

(cffi:defcfun ("_wrap_btVector3_deleteCPlusArray__SWIG_1" #.(bullet-wrap::swig-lispify "btVector3_deleteCPlusArray" 'function)) :void
  (self :pointer)
  (arg1 :pointer)
  (arg2 :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btVector3_deleteCPlusArray" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btVector3_m_floats_set" 'function)))

(cffi:defcfun ("_wrap_btVector3_m_floats_set" #.(bullet-wrap::swig-lispify "btVector3_m_floats_set" 'function)) :void
  (self :pointer)
  (m_floats :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btVector3_m_floats_set" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btVector3_m_floats_get" 'function)))

(cffi:defcfun ("_wrap_btVector3_m_floats_get" #.(bullet-wrap::swig-lispify "btVector3_m_floats_get" 'function)) :pointer
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btVector3_m_floats_get" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "new_btVector3" 'function)))

(cffi:defcfun ("_wrap_new_btVector3__SWIG_0" #.(bullet-wrap::swig-lispify "new_btVector3" 'function)) :pointer)

(cl:export '#.(bullet-wrap::swig-lispify "new_btVector3" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "new_btVector3" 'function)))

(cffi:defcfun ("_wrap_new_btVector3__SWIG_1" #.(bullet-wrap::swig-lispify "new_btVector3" 'function)) :pointer
  (_x :pointer)
  (_y :pointer)
  (_z :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "new_btVector3" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btVector3_increment" 'function)))

(cffi:defcfun ("_wrap_btVector3_increment" #.(bullet-wrap::swig-lispify "btVector3_increment" 'function)) :pointer
  (self :pointer)
  (v :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btVector3_increment" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btVector3_decrement" 'function)))

(cffi:defcfun ("_wrap_btVector3_decrement" #.(bullet-wrap::swig-lispify "btVector3_decrement" 'function)) :pointer
  (self :pointer)
  (v :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btVector3_decrement" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btVector3_multiplyAndAssign" 'function)))

(cffi:defcfun ("_wrap_btVector3_multiplyAndAssign__SWIG_0" #.(bullet-wrap::swig-lispify "btVector3_multiplyAndAssign" 'function)) :pointer
  (self :pointer)
  (s :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btVector3_multiplyAndAssign" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btVector3_divideAndAssign" 'function)))

(cffi:defcfun ("_wrap_btVector3_divideAndAssign" #.(bullet-wrap::swig-lispify "btVector3_divideAndAssign" 'function)) :pointer
  (self :pointer)
  (s :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btVector3_divideAndAssign" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btVector3_dot" 'function)))

(cffi:defcfun ("_wrap_btVector3_dot" #.(bullet-wrap::swig-lispify "btVector3_dot" 'function)) :float
  (self :pointer)
  (v :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btVector3_dot" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btVector3_length2" 'function)))

(cffi:defcfun ("_wrap_btVector3_length2" #.(bullet-wrap::swig-lispify "btVector3_length2" 'function)) :float
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btVector3_length2" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btVector3_length" 'function)))

(cffi:defcfun ("_wrap_btVector3_length" #.(bullet-wrap::swig-lispify "btVector3_length" 'function)) :float
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btVector3_length" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btVector3_norm" 'function)))

(cffi:defcfun ("_wrap_btVector3_norm" #.(bullet-wrap::swig-lispify "btVector3_norm" 'function)) :float
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btVector3_norm" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btVector3_distance2" 'function)))

(cffi:defcfun ("_wrap_btVector3_distance2" #.(bullet-wrap::swig-lispify "btVector3_distance2" 'function)) :float
  (self :pointer)
  (v :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btVector3_distance2" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btVector3_distance" 'function)))

(cffi:defcfun ("_wrap_btVector3_distance" #.(bullet-wrap::swig-lispify "btVector3_distance" 'function)) :float
  (self :pointer)
  (v :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btVector3_distance" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btVector3_safeNormalize" 'function)))

(cffi:defcfun ("_wrap_btVector3_safeNormalize" #.(bullet-wrap::swig-lispify "btVector3_safeNormalize" 'function)) :pointer
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btVector3_safeNormalize" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btVector3_normalize" 'function)))

(cffi:defcfun ("_wrap_btVector3_normalize" #.(bullet-wrap::swig-lispify "btVector3_normalize" 'function)) :pointer
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btVector3_normalize" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btVector3_normalized" 'function)))

(cffi:defcfun ("_wrap_btVector3_normalized" #.(bullet-wrap::swig-lispify "btVector3_normalized" 'function)) :pointer
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btVector3_normalized" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btVector3_rotate" 'function)))

(cffi:defcfun ("_wrap_btVector3_rotate" #.(bullet-wrap::swig-lispify "btVector3_rotate" 'function)) :pointer
  (self :pointer)
  (wAxis :pointer)
  (angle :float))

(cl:export '#.(bullet-wrap::swig-lispify "btVector3_rotate" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btVector3_angle" 'function)))

(cffi:defcfun ("_wrap_btVector3_angle" #.(bullet-wrap::swig-lispify "btVector3_angle" 'function)) :float
  (self :pointer)
  (v :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btVector3_angle" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btVector3_absolute" 'function)))

(cffi:defcfun ("_wrap_btVector3_absolute" #.(bullet-wrap::swig-lispify "btVector3_absolute" 'function)) :pointer
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btVector3_absolute" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btVector3_cross" 'function)))

(cffi:defcfun ("_wrap_btVector3_cross" #.(bullet-wrap::swig-lispify "btVector3_cross" 'function)) :pointer
  (self :pointer)
  (v :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btVector3_cross" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btVector3_triple" 'function)))

(cffi:defcfun ("_wrap_btVector3_triple" #.(bullet-wrap::swig-lispify "btVector3_triple" 'function)) :float
  (self :pointer)
  (v1 :pointer)
  (v2 :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btVector3_triple" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btVector3_minAxis" 'function)))

(cffi:defcfun ("_wrap_btVector3_minAxis" #.(bullet-wrap::swig-lispify "btVector3_minAxis" 'function)) :int
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btVector3_minAxis" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btVector3_maxAxis" 'function)))

(cffi:defcfun ("_wrap_btVector3_maxAxis" #.(bullet-wrap::swig-lispify "btVector3_maxAxis" 'function)) :int
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btVector3_maxAxis" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btVector3_furthestAxis" 'function)))

(cffi:defcfun ("_wrap_btVector3_furthestAxis" #.(bullet-wrap::swig-lispify "btVector3_furthestAxis" 'function)) :int
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btVector3_furthestAxis" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btVector3_closestAxis" 'function)))

(cffi:defcfun ("_wrap_btVector3_closestAxis" #.(bullet-wrap::swig-lispify "btVector3_closestAxis" 'function)) :int
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btVector3_closestAxis" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btVector3_setInterpolate3" 'function)))

(cffi:defcfun ("_wrap_btVector3_setInterpolate3" #.(bullet-wrap::swig-lispify "btVector3_setInterpolate3" 'function)) :void
  (self :pointer)
  (v0 :pointer)
  (v1 :pointer)
  (rt :float))

(cl:export '#.(bullet-wrap::swig-lispify "btVector3_setInterpolate3" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btVector3_lerp" 'function)))

(cffi:defcfun ("_wrap_btVector3_lerp" #.(bullet-wrap::swig-lispify "btVector3_lerp" 'function)) :pointer
  (self :pointer)
  (v :pointer)
  (t_arg2 :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btVector3_lerp" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btVector3_multiplyAndAssign" 'function)))

(cffi:defcfun ("_wrap_btVector3_multiplyAndAssign__SWIG_1" #.(bullet-wrap::swig-lispify "btVector3_multiplyAndAssign" 'function)) :pointer
  (self :pointer)
  (v :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btVector3_multiplyAndAssign" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btVector3_getX" 'function)))

(cffi:defcfun ("_wrap_btVector3_getX" #.(bullet-wrap::swig-lispify "btVector3_getX" 'function)) :pointer
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btVector3_getX" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btVector3_getY" 'function)))

(cffi:defcfun ("_wrap_btVector3_getY" #.(bullet-wrap::swig-lispify "btVector3_getY" 'function)) :pointer
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btVector3_getY" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btVector3_getZ" 'function)))

(cffi:defcfun ("_wrap_btVector3_getZ" #.(bullet-wrap::swig-lispify "btVector3_getZ" 'function)) :pointer
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btVector3_getZ" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btVector3_setX" 'function)))

(cffi:defcfun ("_wrap_btVector3_setX" #.(bullet-wrap::swig-lispify "btVector3_setX" 'function)) :void
  (self :pointer)
  (_x :float))

(cl:export '#.(bullet-wrap::swig-lispify "btVector3_setX" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btVector3_setY" 'function)))

(cffi:defcfun ("_wrap_btVector3_setY" #.(bullet-wrap::swig-lispify "btVector3_setY" 'function)) :void
  (self :pointer)
  (_y :float))

(cl:export '#.(bullet-wrap::swig-lispify "btVector3_setY" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btVector3_setZ" 'function)))

(cffi:defcfun ("_wrap_btVector3_setZ" #.(bullet-wrap::swig-lispify "btVector3_setZ" 'function)) :void
  (self :pointer)
  (_z :float))

(cl:export '#.(bullet-wrap::swig-lispify "btVector3_setZ" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btVector3_setW" 'function)))

(cffi:defcfun ("_wrap_btVector3_setW" #.(bullet-wrap::swig-lispify "btVector3_setW" 'function)) :void
  (self :pointer)
  (_w :float))

(cl:export '#.(bullet-wrap::swig-lispify "btVector3_setW" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btVector3_x" 'function)))

(cffi:defcfun ("_wrap_btVector3_x" #.(bullet-wrap::swig-lispify "btVector3_x" 'function)) :pointer
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btVector3_x" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btVector3_y" 'function)))

(cffi:defcfun ("_wrap_btVector3_y" #.(bullet-wrap::swig-lispify "btVector3_y" 'function)) :pointer
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btVector3_y" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btVector3_z" 'function)))

(cffi:defcfun ("_wrap_btVector3_z" #.(bullet-wrap::swig-lispify "btVector3_z" 'function)) :pointer
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btVector3_z" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btVector3_w" 'function)))

(cffi:defcfun ("_wrap_btVector3_w" #.(bullet-wrap::swig-lispify "btVector3_w" 'function)) :pointer
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btVector3_w" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btVector3_isEqual" 'function)))

(cffi:defcfun ("_wrap_btVector3_isEqual" #.(bullet-wrap::swig-lispify "btVector3_isEqual" 'function)) :pointer
  (self :pointer)
  (other :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btVector3_isEqual" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btVector3_notEquals" 'function)))

(cffi:defcfun ("_wrap_btVector3_notEquals" #.(bullet-wrap::swig-lispify "btVector3_notEquals" 'function)) :pointer
  (self :pointer)
  (other :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btVector3_notEquals" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btVector3_setMax" 'function)))

(cffi:defcfun ("_wrap_btVector3_setMax" #.(bullet-wrap::swig-lispify "btVector3_setMax" 'function)) :void
  (self :pointer)
  (other :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btVector3_setMax" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btVector3_setMin" 'function)))

(cffi:defcfun ("_wrap_btVector3_setMin" #.(bullet-wrap::swig-lispify "btVector3_setMin" 'function)) :void
  (self :pointer)
  (other :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btVector3_setMin" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btVector3_setValue" 'function)))

(cffi:defcfun ("_wrap_btVector3_setValue" #.(bullet-wrap::swig-lispify "btVector3_setValue" 'function)) :void
  (self :pointer)
  (_x :pointer)
  (_y :pointer)
  (_z :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btVector3_setValue" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btVector3_getSkewSymmetricMatrix" 'function)))

(cffi:defcfun ("_wrap_btVector3_getSkewSymmetricMatrix" #.(bullet-wrap::swig-lispify "btVector3_getSkewSymmetricMatrix" 'function)) :void
  (self :pointer)
  (v0 :pointer)
  (v1 :pointer)
  (v2 :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btVector3_getSkewSymmetricMatrix" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btVector3_setZero" 'function)))

(cffi:defcfun ("_wrap_btVector3_setZero" #.(bullet-wrap::swig-lispify "btVector3_setZero" 'function)) :void
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btVector3_setZero" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btVector3_isZero" 'function)))

(cffi:defcfun ("_wrap_btVector3_isZero" #.(bullet-wrap::swig-lispify "btVector3_isZero" 'function)) :pointer
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btVector3_isZero" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btVector3_fuzzyZero" 'function)))

(cffi:defcfun ("_wrap_btVector3_fuzzyZero" #.(bullet-wrap::swig-lispify "btVector3_fuzzyZero" 'function)) :pointer
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btVector3_fuzzyZero" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btVector3_serialize" 'function)))

(cffi:defcfun ("_wrap_btVector3_serialize" #.(bullet-wrap::swig-lispify "btVector3_serialize" 'function)) :void
  (self :pointer)
  (dataOut :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btVector3_serialize" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btVector3_deSerialize" 'function)))

(cffi:defcfun ("_wrap_btVector3_deSerialize" #.(bullet-wrap::swig-lispify "btVector3_deSerialize" 'function)) :void
  (self :pointer)
  (dataIn :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btVector3_deSerialize" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btVector3_serializeFloat" 'function)))

(cffi:defcfun ("_wrap_btVector3_serializeFloat" #.(bullet-wrap::swig-lispify "btVector3_serializeFloat" 'function)) :void
  (self :pointer)
  (dataOut :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btVector3_serializeFloat" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btVector3_deSerializeFloat" 'function)))

(cffi:defcfun ("_wrap_btVector3_deSerializeFloat" #.(bullet-wrap::swig-lispify "btVector3_deSerializeFloat" 'function)) :void
  (self :pointer)
  (dataIn :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btVector3_deSerializeFloat" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btVector3_serializeDouble" 'function)))

(cffi:defcfun ("_wrap_btVector3_serializeDouble" #.(bullet-wrap::swig-lispify "btVector3_serializeDouble" 'function)) :void
  (self :pointer)
  (dataOut :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btVector3_serializeDouble" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btVector3_deSerializeDouble" 'function)))

(cffi:defcfun ("_wrap_btVector3_deSerializeDouble" #.(bullet-wrap::swig-lispify "btVector3_deSerializeDouble" 'function)) :void
  (self :pointer)
  (dataIn :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btVector3_deSerializeDouble" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btVector3_maxDot" 'function)))

(cffi:defcfun ("_wrap_btVector3_maxDot" #.(bullet-wrap::swig-lispify "btVector3_maxDot" 'function)) :long
  (self :pointer)
  (array :pointer)
  (array_count :long)
  (dotOut :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btVector3_maxDot" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btVector3_minDot" 'function)))

(cffi:defcfun ("_wrap_btVector3_minDot" #.(bullet-wrap::swig-lispify "btVector3_minDot" 'function)) :long
  (self :pointer)
  (array :pointer)
  (array_count :long)
  (dotOut :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btVector3_minDot" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btVector3_dot3" 'function)))

(cffi:defcfun ("_wrap_btVector3_dot3" #.(bullet-wrap::swig-lispify "btVector3_dot3" 'function)) :pointer
  (self :pointer)
  (v0 :pointer)
  (v1 :pointer)
  (v2 :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btVector3_dot3" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "delete_btVector3" 'function)))

(cffi:defcfun ("_wrap_delete_btVector3" #.(bullet-wrap::swig-lispify "delete_btVector3" 'function)) :void
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "delete_btVector3" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btDot" 'function)))

(cffi:defcfun ("_wrap_btDot" #.(bullet-wrap::swig-lispify "btDot" 'function)) :float
  (v1 :pointer)
  (v2 :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btDot" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btDistance2" 'function)))

(cffi:defcfun ("_wrap_btDistance2" #.(bullet-wrap::swig-lispify "btDistance2" 'function)) :float
  (v1 :pointer)
  (v2 :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btDistance2" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btDistance" 'function)))

(cffi:defcfun ("_wrap_btDistance" #.(bullet-wrap::swig-lispify "btDistance" 'function)) :float
  (v1 :pointer)
  (v2 :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btDistance" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btAngle" 'function)))

(cffi:defcfun ("_wrap_btAngle__SWIG_0" #.(bullet-wrap::swig-lispify "btAngle" 'function)) :float
  (v1 :pointer)
  (v2 :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btAngle" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCross" 'function)))

(cffi:defcfun ("_wrap_btCross" #.(bullet-wrap::swig-lispify "btCross" 'function)) :pointer
  (v1 :pointer)
  (v2 :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btCross" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btTriple" 'function)))

(cffi:defcfun ("_wrap_btTriple" #.(bullet-wrap::swig-lispify "btTriple" 'function)) :float
  (v1 :pointer)
  (v2 :pointer)
  (v3 :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btTriple" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "lerp" 'function)))

(cffi:defcfun ("_wrap_lerp" #.(bullet-wrap::swig-lispify "lerp" 'function)) :pointer
  (v1 :pointer)
  (v2 :pointer)
  (t_arg2 :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "lerp" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "new_btVector4" 'function)))

(cffi:defcfun ("_wrap_new_btVector4__SWIG_0" #.(bullet-wrap::swig-lispify "new_btVector4" 'function)) :pointer)

(cl:export '#.(bullet-wrap::swig-lispify "new_btVector4" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "new_btVector4" 'function)))

(cffi:defcfun ("_wrap_new_btVector4__SWIG_1" #.(bullet-wrap::swig-lispify "new_btVector4" 'function)) :pointer
  (_x :pointer)
  (_y :pointer)
  (_z :pointer)
  (_w :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "new_btVector4" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btVector4_absolute4" 'function)))

(cffi:defcfun ("_wrap_btVector4_absolute4" #.(bullet-wrap::swig-lispify "btVector4_absolute4" 'function)) :pointer
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btVector4_absolute4" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btVector4_getW" 'function)))

(cffi:defcfun ("_wrap_btVector4_getW" #.(bullet-wrap::swig-lispify "btVector4_getW" 'function)) :float
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btVector4_getW" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btVector4_maxAxis4" 'function)))

(cffi:defcfun ("_wrap_btVector4_maxAxis4" #.(bullet-wrap::swig-lispify "btVector4_maxAxis4" 'function)) :int
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btVector4_maxAxis4" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btVector4_minAxis4" 'function)))

(cffi:defcfun ("_wrap_btVector4_minAxis4" #.(bullet-wrap::swig-lispify "btVector4_minAxis4" 'function)) :int
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btVector4_minAxis4" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btVector4_closestAxis4" 'function)))

(cffi:defcfun ("_wrap_btVector4_closestAxis4" #.(bullet-wrap::swig-lispify "btVector4_closestAxis4" 'function)) :int
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btVector4_closestAxis4" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btVector4_setValue" 'function)))

(cffi:defcfun ("_wrap_btVector4_setValue" #.(bullet-wrap::swig-lispify "btVector4_setValue" 'function)) :void
  (self :pointer)
  (_x :pointer)
  (_y :pointer)
  (_z :pointer)
  (_w :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btVector4_setValue" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "delete_btVector4" 'function)))

(cffi:defcfun ("_wrap_delete_btVector4" #.(bullet-wrap::swig-lispify "delete_btVector4" 'function)) :void
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "delete_btVector4" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btSwapScalarEndian" 'function)))

(cffi:defcfun ("_wrap_btSwapScalarEndian" #.(bullet-wrap::swig-lispify "btSwapScalarEndian" 'function)) :void
  (sourceVal :pointer)
  (destVal :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btSwapScalarEndian" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btSwapVector3Endian" 'function)))

(cffi:defcfun ("_wrap_btSwapVector3Endian" #.(bullet-wrap::swig-lispify "btSwapVector3Endian" 'function)) :void
  (sourceVec :pointer)
  (destVec :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btSwapVector3Endian" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btUnSwapVector3Endian" 'function)))

(cffi:defcfun ("_wrap_btUnSwapVector3Endian" #.(bullet-wrap::swig-lispify "btUnSwapVector3Endian" 'function)) :void
  (vector :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btUnSwapVector3Endian" 'function))

(cffi:defcstruct #.(bullet-wrap::swig-lispify "btVector3FloatData" 'classname)
	(#.(bullet-wrap::swig-lispify "m_floats" 'slotname) :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btVector3FloatData" 'classname))

(cl:export '#.(bullet-wrap::swig-lispify "m_floats" 'slotname))

(cffi:defcstruct #.(bullet-wrap::swig-lispify "btVector3DoubleData" 'classname)
	(#.(bullet-wrap::swig-lispify "m_floats" 'slotname) :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btVector3DoubleData" 'classname))

(cl:export '#.(bullet-wrap::swig-lispify "m_floats" 'slotname))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "new_btQuaternion" 'function)))

(cffi:defcfun ("_wrap_new_btQuaternion__SWIG_0" #.(bullet-wrap::swig-lispify "new_btQuaternion" 'function)) :pointer)

(cl:export '#.(bullet-wrap::swig-lispify "new_btQuaternion" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "new_btQuaternion" 'function)))

(cffi:defcfun ("_wrap_new_btQuaternion__SWIG_1" #.(bullet-wrap::swig-lispify "new_btQuaternion" 'function)) :pointer
  (_x :pointer)
  (_y :pointer)
  (_z :pointer)
  (_w :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "new_btQuaternion" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "new_btQuaternion" 'function)))

(cffi:defcfun ("_wrap_new_btQuaternion__SWIG_2" #.(bullet-wrap::swig-lispify "new_btQuaternion" 'function)) :pointer
  (_axis :pointer)
  (_angle :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "new_btQuaternion" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "new_btQuaternion" 'function)))

(cffi:defcfun ("_wrap_new_btQuaternion__SWIG_3" #.(bullet-wrap::swig-lispify "new_btQuaternion" 'function)) :pointer
  (yaw :pointer)
  (pitch :pointer)
  (roll :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "new_btQuaternion" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btQuaternion_setRotation" 'function)))

(cffi:defcfun ("_wrap_btQuaternion_setRotation" #.(bullet-wrap::swig-lispify "btQuaternion_setRotation" 'function)) :void
  (self :pointer)
  (axis :pointer)
  (_angle :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btQuaternion_setRotation" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btQuaternion_setEuler" 'function)))

(cffi:defcfun ("_wrap_btQuaternion_setEuler" #.(bullet-wrap::swig-lispify "btQuaternion_setEuler" 'function)) :void
  (self :pointer)
  (yaw :pointer)
  (pitch :pointer)
  (roll :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btQuaternion_setEuler" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btQuaternion_setEulerZYX" 'function)))

(cffi:defcfun ("_wrap_btQuaternion_setEulerZYX" #.(bullet-wrap::swig-lispify "btQuaternion_setEulerZYX" 'function)) :void
  (self :pointer)
  (yaw :pointer)
  (pitch :pointer)
  (roll :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btQuaternion_setEulerZYX" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btQuaternion_increment" 'function)))

(cffi:defcfun ("_wrap_btQuaternion_increment" #.(bullet-wrap::swig-lispify "btQuaternion_increment" 'function)) :pointer
  (self :pointer)
  (q :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btQuaternion_increment" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btQuaternion_decrement" 'function)))

(cffi:defcfun ("_wrap_btQuaternion_decrement" #.(bullet-wrap::swig-lispify "btQuaternion_decrement" 'function)) :pointer
  (self :pointer)
  (q :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btQuaternion_decrement" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btQuaternion_multiplyAndAssign" 'function)))

(cffi:defcfun ("_wrap_btQuaternion_multiplyAndAssign__SWIG_0" #.(bullet-wrap::swig-lispify "btQuaternion_multiplyAndAssign" 'function)) :pointer
  (self :pointer)
  (s :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btQuaternion_multiplyAndAssign" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btQuaternion_multiplyAndAssign" 'function)))

(cffi:defcfun ("_wrap_btQuaternion_multiplyAndAssign__SWIG_1" #.(bullet-wrap::swig-lispify "btQuaternion_multiplyAndAssign" 'function)) :pointer
  (self :pointer)
  (q :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btQuaternion_multiplyAndAssign" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btQuaternion_dot" 'function)))

(cffi:defcfun ("_wrap_btQuaternion_dot" #.(bullet-wrap::swig-lispify "btQuaternion_dot" 'function)) :float
  (self :pointer)
  (q :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btQuaternion_dot" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btQuaternion_length2" 'function)))

(cffi:defcfun ("_wrap_btQuaternion_length2" #.(bullet-wrap::swig-lispify "btQuaternion_length2" 'function)) :float
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btQuaternion_length2" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btQuaternion_length" 'function)))

(cffi:defcfun ("_wrap_btQuaternion_length" #.(bullet-wrap::swig-lispify "btQuaternion_length" 'function)) :float
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btQuaternion_length" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btQuaternion_normalize" 'function)))

(cffi:defcfun ("_wrap_btQuaternion_normalize" #.(bullet-wrap::swig-lispify "btQuaternion_normalize" 'function)) :pointer
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btQuaternion_normalize" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btQuaternion_multiply" 'function)))

(cffi:defcfun ("_wrap_btQuaternion_multiply" #.(bullet-wrap::swig-lispify "btQuaternion_multiply" 'function)) :pointer
  (self :pointer)
  (s :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btQuaternion_multiply" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btQuaternion_divide" 'function)))

(cffi:defcfun ("_wrap_btQuaternion_divide" #.(bullet-wrap::swig-lispify "btQuaternion_divide" 'function)) :pointer
  (self :pointer)
  (s :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btQuaternion_divide" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btQuaternion_divideAndAssign" 'function)))

(cffi:defcfun ("_wrap_btQuaternion_divideAndAssign" #.(bullet-wrap::swig-lispify "btQuaternion_divideAndAssign" 'function)) :pointer
  (self :pointer)
  (s :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btQuaternion_divideAndAssign" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btQuaternion_normalized" 'function)))

(cffi:defcfun ("_wrap_btQuaternion_normalized" #.(bullet-wrap::swig-lispify "btQuaternion_normalized" 'function)) :pointer
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btQuaternion_normalized" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btQuaternion_angle" 'function)))

(cffi:defcfun ("_wrap_btQuaternion_angle" #.(bullet-wrap::swig-lispify "btQuaternion_angle" 'function)) :float
  (self :pointer)
  (q :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btQuaternion_angle" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btQuaternion_angleShortestPath" 'function)))

(cffi:defcfun ("_wrap_btQuaternion_angleShortestPath" #.(bullet-wrap::swig-lispify "btQuaternion_angleShortestPath" 'function)) :float
  (self :pointer)
  (q :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btQuaternion_angleShortestPath" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btQuaternion_getAngle" 'function)))

(cffi:defcfun ("_wrap_btQuaternion_getAngle" #.(bullet-wrap::swig-lispify "btQuaternion_getAngle" 'function)) :float
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btQuaternion_getAngle" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btQuaternion_getAngleShortestPath" 'function)))

(cffi:defcfun ("_wrap_btQuaternion_getAngleShortestPath" #.(bullet-wrap::swig-lispify "btQuaternion_getAngleShortestPath" 'function)) :float
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btQuaternion_getAngleShortestPath" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btQuaternion_getAxis" 'function)))

(cffi:defcfun ("_wrap_btQuaternion_getAxis" #.(bullet-wrap::swig-lispify "btQuaternion_getAxis" 'function)) :pointer
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btQuaternion_getAxis" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btQuaternion_inverse" 'function)))

(cffi:defcfun ("_wrap_btQuaternion_inverse" #.(bullet-wrap::swig-lispify "btQuaternion_inverse" 'function)) :pointer
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btQuaternion_inverse" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btQuaternion_add" 'function)))

(cffi:defcfun ("_wrap_btQuaternion_add" #.(bullet-wrap::swig-lispify "btQuaternion_add" 'function)) :pointer
  (self :pointer)
  (q2 :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btQuaternion_add" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btQuaternion_subtract" 'function)))

(cffi:defcfun ("_wrap_btQuaternion_subtract" #.(bullet-wrap::swig-lispify "btQuaternion_subtract" 'function)) :pointer
  (self :pointer)
  (q2 :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btQuaternion_subtract" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btQuaternion___neg__" 'function)))

(cffi:defcfun ("_wrap_btQuaternion___neg__" #.(bullet-wrap::swig-lispify "btQuaternion___neg__" 'function)) :pointer
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btQuaternion___neg__" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btQuaternion_farthest" 'function)))

(cffi:defcfun ("_wrap_btQuaternion_farthest" #.(bullet-wrap::swig-lispify "btQuaternion_farthest" 'function)) :pointer
  (self :pointer)
  (qd :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btQuaternion_farthest" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btQuaternion_nearest" 'function)))

(cffi:defcfun ("_wrap_btQuaternion_nearest" #.(bullet-wrap::swig-lispify "btQuaternion_nearest" 'function)) :pointer
  (self :pointer)
  (qd :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btQuaternion_nearest" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btQuaternion_slerp" 'function)))

(cffi:defcfun ("_wrap_btQuaternion_slerp" #.(bullet-wrap::swig-lispify "btQuaternion_slerp" 'function)) :pointer
  (self :pointer)
  (q :pointer)
  (t_arg2 :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btQuaternion_slerp" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btQuaternion_getIdentity" 'function)))

(cffi:defcfun ("_wrap_btQuaternion_getIdentity" #.(bullet-wrap::swig-lispify "btQuaternion_getIdentity" 'function)) :pointer)

(cl:export '#.(bullet-wrap::swig-lispify "btQuaternion_getIdentity" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btQuaternion_getW" 'function)))

(cffi:defcfun ("_wrap_btQuaternion_getW" #.(bullet-wrap::swig-lispify "btQuaternion_getW" 'function)) :pointer
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btQuaternion_getW" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "delete_btQuaternion" 'function)))

(cffi:defcfun ("_wrap_delete_btQuaternion" #.(bullet-wrap::swig-lispify "delete_btQuaternion" 'function)) :void
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "delete_btQuaternion" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "dot" 'function)))

(cffi:defcfun ("_wrap_dot" #.(bullet-wrap::swig-lispify "dot" 'function)) :float
  (q1 :pointer)
  (q2 :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "dot" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "length" 'function)))

(cffi:defcfun ("_wrap_length" #.(bullet-wrap::swig-lispify "length" 'function)) :float
  (q :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "length" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btAngle" 'function)))

(cffi:defcfun ("_wrap_btAngle__SWIG_1" #.(bullet-wrap::swig-lispify "btAngle" 'function)) :float
  (q1 :pointer)
  (q2 :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btAngle" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "inverse" 'function)))

(cffi:defcfun ("_wrap_inverse" #.(bullet-wrap::swig-lispify "inverse" 'function)) :pointer
  (q :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "inverse" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "slerp" 'function)))

(cffi:defcfun ("_wrap_slerp" #.(bullet-wrap::swig-lispify "slerp" 'function)) :pointer
  (q1 :pointer)
  (q2 :pointer)
  (t_arg2 :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "slerp" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "quatRotate" 'function)))

(cffi:defcfun ("_wrap_quatRotate" #.(bullet-wrap::swig-lispify "quatRotate" 'function)) :pointer
  (rotation :pointer)
  (v :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "quatRotate" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "shortestArcQuat" 'function)))

(cffi:defcfun ("_wrap_shortestArcQuat" #.(bullet-wrap::swig-lispify "shortestArcQuat" 'function)) :pointer
  (v0 :pointer)
  (v1 :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "shortestArcQuat" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "shortestArcQuatNormalize2" 'function)))

(cffi:defcfun ("_wrap_shortestArcQuatNormalize2" #.(bullet-wrap::swig-lispify "shortestArcQuatNormalize2" 'function)) :pointer
  (v0 :pointer)
  (v1 :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "shortestArcQuatNormalize2" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "new_btMatrix3x3" 'function)))

(cffi:defcfun ("_wrap_new_btMatrix3x3__SWIG_0" #.(bullet-wrap::swig-lispify "new_btMatrix3x3" 'function)) :pointer)

(cl:export '#.(bullet-wrap::swig-lispify "new_btMatrix3x3" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "new_btMatrix3x3" 'function)))

(cffi:defcfun ("_wrap_new_btMatrix3x3__SWIG_1" #.(bullet-wrap::swig-lispify "new_btMatrix3x3" 'function)) :pointer
  (q :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "new_btMatrix3x3" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "new_btMatrix3x3" 'function)))

(cffi:defcfun ("_wrap_new_btMatrix3x3__SWIG_2" #.(bullet-wrap::swig-lispify "new_btMatrix3x3" 'function)) :pointer
  (xx :pointer)
  (xy :pointer)
  (xz :pointer)
  (yx :pointer)
  (yy :pointer)
  (yz :pointer)
  (zx :pointer)
  (zy :pointer)
  (zz :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "new_btMatrix3x3" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "new_btMatrix3x3" 'function)))

(cffi:defcfun ("_wrap_new_btMatrix3x3__SWIG_3" #.(bullet-wrap::swig-lispify "new_btMatrix3x3" 'function)) :pointer
  (other :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "new_btMatrix3x3" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btMatrix3x3_assignValue" 'function)))

(cffi:defcfun ("_wrap_btMatrix3x3_assignValue" #.(bullet-wrap::swig-lispify "btMatrix3x3_assignValue" 'function)) :pointer
  (self :pointer)
  (other :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btMatrix3x3_assignValue" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btMatrix3x3_getColumn" 'function)))

(cffi:defcfun ("_wrap_btMatrix3x3_getColumn" #.(bullet-wrap::swig-lispify "btMatrix3x3_getColumn" 'function)) :pointer
  (self :pointer)
  (i :int))

(cl:export '#.(bullet-wrap::swig-lispify "btMatrix3x3_getColumn" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btMatrix3x3_getRow" 'function)))

(cffi:defcfun ("_wrap_btMatrix3x3_getRow" #.(bullet-wrap::swig-lispify "btMatrix3x3_getRow" 'function)) :pointer
  (self :pointer)
  (i :int))

(cl:export '#.(bullet-wrap::swig-lispify "btMatrix3x3_getRow" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btMatrix3x3___aref__" 'function)))

(cffi:defcfun ("_wrap_btMatrix3x3___aref____SWIG_0" #.(bullet-wrap::swig-lispify "btMatrix3x3___aref__" 'function)) :pointer
  (self :pointer)
  (i :int))

(cl:export '#.(bullet-wrap::swig-lispify "btMatrix3x3___aref__" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btMatrix3x3___aref__" 'function)))

(cffi:defcfun ("_wrap_btMatrix3x3___aref____SWIG_1" #.(bullet-wrap::swig-lispify "btMatrix3x3___aref__" 'function)) :pointer
  (self :pointer)
  (i :int))

(cl:export '#.(bullet-wrap::swig-lispify "btMatrix3x3___aref__" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btMatrix3x3_multiplyAndAssign" 'function)))

(cffi:defcfun ("_wrap_btMatrix3x3_multiplyAndAssign" #.(bullet-wrap::swig-lispify "btMatrix3x3_multiplyAndAssign" 'function)) :pointer
  (self :pointer)
  (m :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btMatrix3x3_multiplyAndAssign" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btMatrix3x3_increment" 'function)))

(cffi:defcfun ("_wrap_btMatrix3x3_increment" #.(bullet-wrap::swig-lispify "btMatrix3x3_increment" 'function)) :pointer
  (self :pointer)
  (m :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btMatrix3x3_increment" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btMatrix3x3_decrement" 'function)))

(cffi:defcfun ("_wrap_btMatrix3x3_decrement" #.(bullet-wrap::swig-lispify "btMatrix3x3_decrement" 'function)) :pointer
  (self :pointer)
  (m :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btMatrix3x3_decrement" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btMatrix3x3_setFromOpenGLSubMatrix" 'function)))

(cffi:defcfun ("_wrap_btMatrix3x3_setFromOpenGLSubMatrix" #.(bullet-wrap::swig-lispify "btMatrix3x3_setFromOpenGLSubMatrix" 'function)) :void
  (self :pointer)
  (m :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btMatrix3x3_setFromOpenGLSubMatrix" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btMatrix3x3_setValue" 'function)))

(cffi:defcfun ("_wrap_btMatrix3x3_setValue" #.(bullet-wrap::swig-lispify "btMatrix3x3_setValue" 'function)) :void
  (self :pointer)
  (xx :pointer)
  (xy :pointer)
  (xz :pointer)
  (yx :pointer)
  (yy :pointer)
  (yz :pointer)
  (zx :pointer)
  (zy :pointer)
  (zz :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btMatrix3x3_setValue" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btMatrix3x3_setRotation" 'function)))

(cffi:defcfun ("_wrap_btMatrix3x3_setRotation" #.(bullet-wrap::swig-lispify "btMatrix3x3_setRotation" 'function)) :void
  (self :pointer)
  (q :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btMatrix3x3_setRotation" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btMatrix3x3_setEulerYPR" 'function)))

(cffi:defcfun ("_wrap_btMatrix3x3_setEulerYPR" #.(bullet-wrap::swig-lispify "btMatrix3x3_setEulerYPR" 'function)) :void
  (self :pointer)
  (yaw :pointer)
  (pitch :pointer)
  (roll :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btMatrix3x3_setEulerYPR" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btMatrix3x3_setEulerZYX" 'function)))

(cffi:defcfun ("_wrap_btMatrix3x3_setEulerZYX" #.(bullet-wrap::swig-lispify "btMatrix3x3_setEulerZYX" 'function)) :void
  (self :pointer)
  (eulerX :float)
  (eulerY :float)
  (eulerZ :float))

(cl:export '#.(bullet-wrap::swig-lispify "btMatrix3x3_setEulerZYX" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btMatrix3x3_setIdentity" 'function)))

(cffi:defcfun ("_wrap_btMatrix3x3_setIdentity" #.(bullet-wrap::swig-lispify "btMatrix3x3_setIdentity" 'function)) :void
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btMatrix3x3_setIdentity" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btMatrix3x3_getIdentity" 'function)))

(cffi:defcfun ("_wrap_btMatrix3x3_getIdentity" #.(bullet-wrap::swig-lispify "btMatrix3x3_getIdentity" 'function)) :pointer)

(cl:export '#.(bullet-wrap::swig-lispify "btMatrix3x3_getIdentity" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btMatrix3x3_getOpenGLSubMatrix" 'function)))

(cffi:defcfun ("_wrap_btMatrix3x3_getOpenGLSubMatrix" #.(bullet-wrap::swig-lispify "btMatrix3x3_getOpenGLSubMatrix" 'function)) :void
  (self :pointer)
  (m :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btMatrix3x3_getOpenGLSubMatrix" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btMatrix3x3_getRotation" 'function)))

(cffi:defcfun ("_wrap_btMatrix3x3_getRotation" #.(bullet-wrap::swig-lispify "btMatrix3x3_getRotation" 'function)) :void
  (self :pointer)
  (q :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btMatrix3x3_getRotation" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btMatrix3x3_getEulerYPR" 'function)))

(cffi:defcfun ("_wrap_btMatrix3x3_getEulerYPR" #.(bullet-wrap::swig-lispify "btMatrix3x3_getEulerYPR" 'function)) :void
  (self :pointer)
  (yaw :pointer)
  (pitch :pointer)
  (roll :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btMatrix3x3_getEulerYPR" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btMatrix3x3_getEulerZYX" 'function)))

(cffi:defcfun ("_wrap_btMatrix3x3_getEulerZYX__SWIG_0" #.(bullet-wrap::swig-lispify "btMatrix3x3_getEulerZYX" 'function)) :void
  (self :pointer)
  (yaw :pointer)
  (pitch :pointer)
  (roll :pointer)
  (solution_number :unsigned-int))

(cl:export '#.(bullet-wrap::swig-lispify "btMatrix3x3_getEulerZYX" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btMatrix3x3_getEulerZYX" 'function)))

(cffi:defcfun ("_wrap_btMatrix3x3_getEulerZYX__SWIG_1" #.(bullet-wrap::swig-lispify "btMatrix3x3_getEulerZYX" 'function)) :void
  (self :pointer)
  (yaw :pointer)
  (pitch :pointer)
  (roll :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btMatrix3x3_getEulerZYX" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btMatrix3x3_scaled" 'function)))

(cffi:defcfun ("_wrap_btMatrix3x3_scaled" #.(bullet-wrap::swig-lispify "btMatrix3x3_scaled" 'function)) :pointer
  (self :pointer)
  (s :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btMatrix3x3_scaled" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btMatrix3x3_determinant" 'function)))

(cffi:defcfun ("_wrap_btMatrix3x3_determinant" #.(bullet-wrap::swig-lispify "btMatrix3x3_determinant" 'function)) :float
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btMatrix3x3_determinant" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btMatrix3x3_adjoint" 'function)))

(cffi:defcfun ("_wrap_btMatrix3x3_adjoint" #.(bullet-wrap::swig-lispify "btMatrix3x3_adjoint" 'function)) :pointer
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btMatrix3x3_adjoint" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btMatrix3x3_absolute" 'function)))

(cffi:defcfun ("_wrap_btMatrix3x3_absolute" #.(bullet-wrap::swig-lispify "btMatrix3x3_absolute" 'function)) :pointer
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btMatrix3x3_absolute" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btMatrix3x3_transpose" 'function)))

(cffi:defcfun ("_wrap_btMatrix3x3_transpose" #.(bullet-wrap::swig-lispify "btMatrix3x3_transpose" 'function)) :pointer
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btMatrix3x3_transpose" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btMatrix3x3_inverse" 'function)))

(cffi:defcfun ("_wrap_btMatrix3x3_inverse" #.(bullet-wrap::swig-lispify "btMatrix3x3_inverse" 'function)) :pointer
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btMatrix3x3_inverse" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btMatrix3x3_transposeTimes" 'function)))

(cffi:defcfun ("_wrap_btMatrix3x3_transposeTimes" #.(bullet-wrap::swig-lispify "btMatrix3x3_transposeTimes" 'function)) :pointer
  (self :pointer)
  (m :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btMatrix3x3_transposeTimes" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btMatrix3x3_timesTranspose" 'function)))

(cffi:defcfun ("_wrap_btMatrix3x3_timesTranspose" #.(bullet-wrap::swig-lispify "btMatrix3x3_timesTranspose" 'function)) :pointer
  (self :pointer)
  (m :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btMatrix3x3_timesTranspose" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btMatrix3x3_tdotx" 'function)))

(cffi:defcfun ("_wrap_btMatrix3x3_tdotx" #.(bullet-wrap::swig-lispify "btMatrix3x3_tdotx" 'function)) :float
  (self :pointer)
  (v :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btMatrix3x3_tdotx" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btMatrix3x3_tdoty" 'function)))

(cffi:defcfun ("_wrap_btMatrix3x3_tdoty" #.(bullet-wrap::swig-lispify "btMatrix3x3_tdoty" 'function)) :float
  (self :pointer)
  (v :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btMatrix3x3_tdoty" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btMatrix3x3_tdotz" 'function)))

(cffi:defcfun ("_wrap_btMatrix3x3_tdotz" #.(bullet-wrap::swig-lispify "btMatrix3x3_tdotz" 'function)) :float
  (self :pointer)
  (v :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btMatrix3x3_tdotz" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btMatrix3x3_diagonalize" 'function)))

(cffi:defcfun ("_wrap_btMatrix3x3_diagonalize" #.(bullet-wrap::swig-lispify "btMatrix3x3_diagonalize" 'function)) :void
  (self :pointer)
  (rot :pointer)
  (threshold :float)
  (maxSteps :int))

(cl:export '#.(bullet-wrap::swig-lispify "btMatrix3x3_diagonalize" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btMatrix3x3_cofac" 'function)))

(cffi:defcfun ("_wrap_btMatrix3x3_cofac" #.(bullet-wrap::swig-lispify "btMatrix3x3_cofac" 'function)) :float
  (self :pointer)
  (r1 :int)
  (c1 :int)
  (r2 :int)
  (c2 :int))

(cl:export '#.(bullet-wrap::swig-lispify "btMatrix3x3_cofac" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btMatrix3x3_serialize" 'function)))

(cffi:defcfun ("_wrap_btMatrix3x3_serialize" #.(bullet-wrap::swig-lispify "btMatrix3x3_serialize" 'function)) :void
  (self :pointer)
  (dataOut :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btMatrix3x3_serialize" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btMatrix3x3_serializeFloat" 'function)))

(cffi:defcfun ("_wrap_btMatrix3x3_serializeFloat" #.(bullet-wrap::swig-lispify "btMatrix3x3_serializeFloat" 'function)) :void
  (self :pointer)
  (dataOut :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btMatrix3x3_serializeFloat" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btMatrix3x3_deSerialize" 'function)))

(cffi:defcfun ("_wrap_btMatrix3x3_deSerialize" #.(bullet-wrap::swig-lispify "btMatrix3x3_deSerialize" 'function)) :void
  (self :pointer)
  (dataIn :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btMatrix3x3_deSerialize" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btMatrix3x3_deSerializeFloat" 'function)))

(cffi:defcfun ("_wrap_btMatrix3x3_deSerializeFloat" #.(bullet-wrap::swig-lispify "btMatrix3x3_deSerializeFloat" 'function)) :void
  (self :pointer)
  (dataIn :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btMatrix3x3_deSerializeFloat" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btMatrix3x3_deSerializeDouble" 'function)))

(cffi:defcfun ("_wrap_btMatrix3x3_deSerializeDouble" #.(bullet-wrap::swig-lispify "btMatrix3x3_deSerializeDouble" 'function)) :void
  (self :pointer)
  (dataIn :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btMatrix3x3_deSerializeDouble" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "delete_btMatrix3x3" 'function)))

(cffi:defcfun ("_wrap_delete_btMatrix3x3" #.(bullet-wrap::swig-lispify "delete_btMatrix3x3" 'function)) :void
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "delete_btMatrix3x3" 'function))

(cffi:defcstruct #.(bullet-wrap::swig-lispify "btMatrix3x3FloatData" 'classname)
	(#.(bullet-wrap::swig-lispify "m_el" 'slotname) :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btMatrix3x3FloatData" 'classname))

(cl:export '#.(bullet-wrap::swig-lispify "m_el" 'slotname))

(cffi:defcstruct #.(bullet-wrap::swig-lispify "btMatrix3x3DoubleData" 'classname)
	(#.(bullet-wrap::swig-lispify "m_el" 'slotname) :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btMatrix3x3DoubleData" 'classname))

(cl:export '#.(bullet-wrap::swig-lispify "m_el" 'slotname))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "new_btTransform" 'function)))

(cffi:defcfun ("_wrap_new_btTransform__SWIG_0" #.(bullet-wrap::swig-lispify "new_btTransform" 'function)) :pointer)

(cl:export '#.(bullet-wrap::swig-lispify "new_btTransform" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "new_btTransform" 'function)))

(cffi:defcfun ("_wrap_new_btTransform__SWIG_1" #.(bullet-wrap::swig-lispify "new_btTransform" 'function)) :pointer
  (q :pointer)
  (c :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "new_btTransform" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "new_btTransform" 'function)))

(cffi:defcfun ("_wrap_new_btTransform__SWIG_2" #.(bullet-wrap::swig-lispify "new_btTransform" 'function)) :pointer
  (q :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "new_btTransform" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "new_btTransform" 'function)))

(cffi:defcfun ("_wrap_new_btTransform__SWIG_3" #.(bullet-wrap::swig-lispify "new_btTransform" 'function)) :pointer
  (b :pointer)
  (c :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "new_btTransform" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "new_btTransform" 'function)))

(cffi:defcfun ("_wrap_new_btTransform__SWIG_4" #.(bullet-wrap::swig-lispify "new_btTransform" 'function)) :pointer
  (b :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "new_btTransform" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "new_btTransform" 'function)))

(cffi:defcfun ("_wrap_new_btTransform__SWIG_5" #.(bullet-wrap::swig-lispify "new_btTransform" 'function)) :pointer
  (other :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "new_btTransform" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btTransform_assignValue" 'function)))

(cffi:defcfun ("_wrap_btTransform_assignValue" #.(bullet-wrap::swig-lispify "btTransform_assignValue" 'function)) :pointer
  (self :pointer)
  (other :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btTransform_assignValue" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btTransform_mult" 'function)))

(cffi:defcfun ("_wrap_btTransform_mult" #.(bullet-wrap::swig-lispify "btTransform_mult" 'function)) :void
  (self :pointer)
  (t1 :pointer)
  (t2 :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btTransform_mult" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btTransform___funcall__" 'function)))

(cffi:defcfun ("_wrap_btTransform___funcall__" #.(bullet-wrap::swig-lispify "btTransform___funcall__" 'function)) :pointer
  (self :pointer)
  (x :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btTransform___funcall__" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btTransform_multiply" 'function)))

(cffi:defcfun ("_wrap_btTransform_multiply__SWIG_0" #.(bullet-wrap::swig-lispify "btTransform_multiply" 'function)) :pointer
  (self :pointer)
  (x :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btTransform_multiply" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btTransform_multiply" 'function)))

(cffi:defcfun ("_wrap_btTransform_multiply__SWIG_1" #.(bullet-wrap::swig-lispify "btTransform_multiply" 'function)) :pointer
  (self :pointer)
  (q :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btTransform_multiply" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btTransform_getBasis" 'function)))

(cffi:defcfun ("_wrap_btTransform_getBasis__SWIG_0" #.(bullet-wrap::swig-lispify "btTransform_getBasis" 'function)) :pointer
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btTransform_getBasis" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btTransform_getBasis" 'function)))

(cffi:defcfun ("_wrap_btTransform_getBasis__SWIG_1" #.(bullet-wrap::swig-lispify "btTransform_getBasis" 'function)) :pointer
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btTransform_getBasis" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btTransform_getOrigin" 'function)))

(cffi:defcfun ("_wrap_btTransform_getOrigin__SWIG_0" #.(bullet-wrap::swig-lispify "btTransform_getOrigin" 'function)) :pointer
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btTransform_getOrigin" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btTransform_getOrigin" 'function)))

(cffi:defcfun ("_wrap_btTransform_getOrigin__SWIG_1" #.(bullet-wrap::swig-lispify "btTransform_getOrigin" 'function)) :pointer
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btTransform_getOrigin" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btTransform_getRotation" 'function)))

(cffi:defcfun ("_wrap_btTransform_getRotation" #.(bullet-wrap::swig-lispify "btTransform_getRotation" 'function)) :pointer
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btTransform_getRotation" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btTransform_setFromOpenGLMatrix" 'function)))

(cffi:defcfun ("_wrap_btTransform_setFromOpenGLMatrix" #.(bullet-wrap::swig-lispify "btTransform_setFromOpenGLMatrix" 'function)) :void
  (self :pointer)
  (m :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btTransform_setFromOpenGLMatrix" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btTransform_getOpenGLMatrix" 'function)))

(cffi:defcfun ("_wrap_btTransform_getOpenGLMatrix" #.(bullet-wrap::swig-lispify "btTransform_getOpenGLMatrix" 'function)) :void
  (self :pointer)
  (m :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btTransform_getOpenGLMatrix" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btTransform_setOrigin" 'function)))

(cffi:defcfun ("_wrap_btTransform_setOrigin" #.(bullet-wrap::swig-lispify "btTransform_setOrigin" 'function)) :void
  (self :pointer)
  (origin :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btTransform_setOrigin" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btTransform_invXform" 'function)))

(cffi:defcfun ("_wrap_btTransform_invXform" #.(bullet-wrap::swig-lispify "btTransform_invXform" 'function)) :pointer
  (self :pointer)
  (inVec :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btTransform_invXform" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btTransform_setBasis" 'function)))

(cffi:defcfun ("_wrap_btTransform_setBasis" #.(bullet-wrap::swig-lispify "btTransform_setBasis" 'function)) :void
  (self :pointer)
  (basis :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btTransform_setBasis" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btTransform_setRotation" 'function)))

(cffi:defcfun ("_wrap_btTransform_setRotation" #.(bullet-wrap::swig-lispify "btTransform_setRotation" 'function)) :void
  (self :pointer)
  (q :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btTransform_setRotation" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btTransform_setIdentity" 'function)))

(cffi:defcfun ("_wrap_btTransform_setIdentity" #.(bullet-wrap::swig-lispify "btTransform_setIdentity" 'function)) :void
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btTransform_setIdentity" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btTransform_multiplyAndAssign" 'function)))

(cffi:defcfun ("_wrap_btTransform_multiplyAndAssign" #.(bullet-wrap::swig-lispify "btTransform_multiplyAndAssign" 'function)) :pointer
  (self :pointer)
  (t_arg1 :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btTransform_multiplyAndAssign" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btTransform_inverse" 'function)))

(cffi:defcfun ("_wrap_btTransform_inverse" #.(bullet-wrap::swig-lispify "btTransform_inverse" 'function)) :pointer
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btTransform_inverse" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btTransform_inverseTimes" 'function)))

(cffi:defcfun ("_wrap_btTransform_inverseTimes" #.(bullet-wrap::swig-lispify "btTransform_inverseTimes" 'function)) :pointer
  (self :pointer)
  (t_arg1 :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btTransform_inverseTimes" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btTransform_multiply" 'function)))

(cffi:defcfun ("_wrap_btTransform_multiply__SWIG_2" #.(bullet-wrap::swig-lispify "btTransform_multiply" 'function)) :pointer
  (self :pointer)
  (t_arg1 :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btTransform_multiply" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btTransform_getIdentity" 'function)))

(cffi:defcfun ("_wrap_btTransform_getIdentity" #.(bullet-wrap::swig-lispify "btTransform_getIdentity" 'function)) :pointer)

(cl:export '#.(bullet-wrap::swig-lispify "btTransform_getIdentity" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btTransform_serialize" 'function)))

(cffi:defcfun ("_wrap_btTransform_serialize" #.(bullet-wrap::swig-lispify "btTransform_serialize" 'function)) :void
  (self :pointer)
  (dataOut :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btTransform_serialize" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btTransform_serializeFloat" 'function)))

(cffi:defcfun ("_wrap_btTransform_serializeFloat" #.(bullet-wrap::swig-lispify "btTransform_serializeFloat" 'function)) :void
  (self :pointer)
  (dataOut :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btTransform_serializeFloat" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btTransform_deSerialize" 'function)))

(cffi:defcfun ("_wrap_btTransform_deSerialize" #.(bullet-wrap::swig-lispify "btTransform_deSerialize" 'function)) :void
  (self :pointer)
  (dataIn :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btTransform_deSerialize" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btTransform_deSerializeDouble" 'function)))

(cffi:defcfun ("_wrap_btTransform_deSerializeDouble" #.(bullet-wrap::swig-lispify "btTransform_deSerializeDouble" 'function)) :void
  (self :pointer)
  (dataIn :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btTransform_deSerializeDouble" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btTransform_deSerializeFloat" 'function)))

(cffi:defcfun ("_wrap_btTransform_deSerializeFloat" #.(bullet-wrap::swig-lispify "btTransform_deSerializeFloat" 'function)) :void
  (self :pointer)
  (dataIn :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btTransform_deSerializeFloat" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "delete_btTransform" 'function)))

(cffi:defcfun ("_wrap_delete_btTransform" #.(bullet-wrap::swig-lispify "delete_btTransform" 'function)) :void
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "delete_btTransform" 'function))

(cffi:defcstruct #.(bullet-wrap::swig-lispify "btTransformFloatData" 'classname)
	(#.(bullet-wrap::swig-lispify "m_basis" 'slotname) #.(bullet-wrap::swig-lispify "btMatrix3x3FloatData" 'classname))
	(#.(bullet-wrap::swig-lispify "m_origin" 'slotname) #.(bullet-wrap::swig-lispify "btVector3FloatData" 'classname)))

(cl:export '#.(bullet-wrap::swig-lispify "btTransformFloatData" 'classname))

(cl:export '#.(bullet-wrap::swig-lispify "m_basis" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_origin" 'slotname))

(cffi:defcstruct #.(bullet-wrap::swig-lispify "btTransformDoubleData" 'classname)
	(#.(bullet-wrap::swig-lispify "m_basis" 'slotname) #.(bullet-wrap::swig-lispify "btMatrix3x3DoubleData" 'classname))
	(#.(bullet-wrap::swig-lispify "m_origin" 'slotname) #.(bullet-wrap::swig-lispify "btVector3DoubleData" 'classname)))

(cl:export '#.(bullet-wrap::swig-lispify "btTransformDoubleData" 'classname))

(cl:export '#.(bullet-wrap::swig-lispify "m_basis" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_origin" 'slotname))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "delete_btMotionState" 'function)))

(cffi:defcfun ("_wrap_delete_btMotionState" #.(bullet-wrap::swig-lispify "delete_btMotionState" 'function)) :void
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "delete_btMotionState" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btMotionState_getWorldTransform" 'function)))

(cffi:defcfun ("_wrap_btMotionState_getWorldTransform" #.(bullet-wrap::swig-lispify "btMotionState_getWorldTransform" 'function)) :void
  (self :pointer)
  (worldTrans :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btMotionState_getWorldTransform" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btMotionState_setWorldTransform" 'function)))

(cffi:defcfun ("_wrap_btMotionState_setWorldTransform" #.(bullet-wrap::swig-lispify "btMotionState_setWorldTransform" 'function)) :void
  (self :pointer)
  (worldTrans :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btMotionState_setWorldTransform" 'function))

(cl:defconstant #.(bullet-wrap::swig-lispify "BT_USE_PLACEMENT_NEW" 'constant) 1)

(cl:export '#.(bullet-wrap::swig-lispify "BT_USE_PLACEMENT_NEW" 'constant))

(cffi:defcfun ("_wrap_new_btCollisionWorld" #.(bullet-wrap::swig-lispify "new_btCollisionWorld" 'function)) :pointer
  (dispatcher :pointer)
  (broadphasePairCache :pointer)
  (collisionConfiguration :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "new_btCollisionWorld" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "delete_btCollisionWorld" 'function)))

(cffi:defcfun ("_wrap_delete_btCollisionWorld" #.(bullet-wrap::swig-lispify "delete_btCollisionWorld" 'function)) :void
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "delete_btCollisionWorld" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCollisionWorld_setBroadphase" 'function)))

(cffi:defcfun ("_wrap_btCollisionWorld_setBroadphase" #.(bullet-wrap::swig-lispify "btCollisionWorld_setBroadphase" 'function)) :void
  (self :pointer)
  (pairCache :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btCollisionWorld_setBroadphase" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCollisionWorld_getBroadphase" 'function)))

(cffi:defcfun ("_wrap_btCollisionWorld_getBroadphase__SWIG_0" #.(bullet-wrap::swig-lispify "btCollisionWorld_getBroadphase" 'function)) :pointer
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btCollisionWorld_getBroadphase" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCollisionWorld_getBroadphase" 'function)))

(cffi:defcfun ("_wrap_btCollisionWorld_getBroadphase__SWIG_1" #.(bullet-wrap::swig-lispify "btCollisionWorld_getBroadphase" 'function)) :pointer
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btCollisionWorld_getBroadphase" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCollisionWorld_getPairCache" 'function)))

(cffi:defcfun ("_wrap_btCollisionWorld_getPairCache" #.(bullet-wrap::swig-lispify "btCollisionWorld_getPairCache" 'function)) :pointer
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btCollisionWorld_getPairCache" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCollisionWorld_getDispatcher" 'function)))

(cffi:defcfun ("_wrap_btCollisionWorld_getDispatcher__SWIG_0" #.(bullet-wrap::swig-lispify "btCollisionWorld_getDispatcher" 'function)) :pointer
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btCollisionWorld_getDispatcher" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCollisionWorld_getDispatcher" 'function)))

(cffi:defcfun ("_wrap_btCollisionWorld_getDispatcher__SWIG_1" #.(bullet-wrap::swig-lispify "btCollisionWorld_getDispatcher" 'function)) :pointer
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btCollisionWorld_getDispatcher" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCollisionWorld_updateSingleAabb" 'function)))

(cffi:defcfun ("_wrap_btCollisionWorld_updateSingleAabb" #.(bullet-wrap::swig-lispify "btCollisionWorld_updateSingleAabb" 'function)) :void
  (self :pointer)
  (colObj :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btCollisionWorld_updateSingleAabb" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCollisionWorld_updateAabbs" 'function)))

(cffi:defcfun ("_wrap_btCollisionWorld_updateAabbs" #.(bullet-wrap::swig-lispify "btCollisionWorld_updateAabbs" 'function)) :void
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btCollisionWorld_updateAabbs" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCollisionWorld_computeOverlappingPairs" 'function)))

(cffi:defcfun ("_wrap_btCollisionWorld_computeOverlappingPairs" #.(bullet-wrap::swig-lispify "btCollisionWorld_computeOverlappingPairs" 'function)) :void
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btCollisionWorld_computeOverlappingPairs" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCollisionWorld_setDebugDrawer" 'function)))

(cffi:defcfun ("_wrap_btCollisionWorld_setDebugDrawer" #.(bullet-wrap::swig-lispify "btCollisionWorld_setDebugDrawer" 'function)) :void
  (self :pointer)
  (debugDrawer :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btCollisionWorld_setDebugDrawer" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCollisionWorld_getDebugDrawer" 'function)))

(cffi:defcfun ("_wrap_btCollisionWorld_getDebugDrawer" #.(bullet-wrap::swig-lispify "btCollisionWorld_getDebugDrawer" 'function)) :pointer
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btCollisionWorld_getDebugDrawer" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCollisionWorld_debugDrawWorld" 'function)))

(cffi:defcfun ("_wrap_btCollisionWorld_debugDrawWorld" #.(bullet-wrap::swig-lispify "btCollisionWorld_debugDrawWorld" 'function)) :void
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btCollisionWorld_debugDrawWorld" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCollisionWorld_debugDrawObject" 'function)))

(cffi:defcfun ("_wrap_btCollisionWorld_debugDrawObject" #.(bullet-wrap::swig-lispify "btCollisionWorld_debugDrawObject" 'function)) :void
  (self :pointer)
  (worldTransform :pointer)
  (shape :pointer)
  (color :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btCollisionWorld_debugDrawObject" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCollisionWorld_getNumCollisionObjects" 'function)))

(cffi:defcfun ("_wrap_btCollisionWorld_getNumCollisionObjects" #.(bullet-wrap::swig-lispify "btCollisionWorld_getNumCollisionObjects" 'function)) :int
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btCollisionWorld_getNumCollisionObjects" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCollisionWorld_rayTest" 'function)))

(cffi:defcfun ("_wrap_btCollisionWorld_rayTest" #.(bullet-wrap::swig-lispify "btCollisionWorld_rayTest" 'function)) :void
  (self :pointer)
  (rayFromWorld :pointer)
  (rayToWorld :pointer)
  (resultCallback :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btCollisionWorld_rayTest" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCollisionWorld_convexSweepTest" 'function)))

(cffi:defcfun ("_wrap_btCollisionWorld_convexSweepTest__SWIG_0" #.(bullet-wrap::swig-lispify "btCollisionWorld_convexSweepTest" 'function)) :void
  (self :pointer)
  (castShape :pointer)
  (from :pointer)
  (to :pointer)
  (resultCallback :pointer)
  (allowedCcdPenetration :float))

(cl:export '#.(bullet-wrap::swig-lispify "btCollisionWorld_convexSweepTest" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCollisionWorld_convexSweepTest" 'function)))

(cffi:defcfun ("_wrap_btCollisionWorld_convexSweepTest__SWIG_1" #.(bullet-wrap::swig-lispify "btCollisionWorld_convexSweepTest" 'function)) :void
  (self :pointer)
  (castShape :pointer)
  (from :pointer)
  (to :pointer)
  (resultCallback :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btCollisionWorld_convexSweepTest" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCollisionWorld_contactTest" 'function)))

(cffi:defcfun ("_wrap_btCollisionWorld_contactTest" #.(bullet-wrap::swig-lispify "btCollisionWorld_contactTest" 'function)) :void
  (self :pointer)
  (colObj :pointer)
  (resultCallback :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btCollisionWorld_contactTest" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCollisionWorld_contactPairTest" 'function)))

(cffi:defcfun ("_wrap_btCollisionWorld_contactPairTest" #.(bullet-wrap::swig-lispify "btCollisionWorld_contactPairTest" 'function)) :void
  (self :pointer)
  (colObjA :pointer)
  (colObjB :pointer)
  (resultCallback :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btCollisionWorld_contactPairTest" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCollisionWorld_rayTestSingle" 'function)))

(cffi:defcfun ("_wrap_btCollisionWorld_rayTestSingle" #.(bullet-wrap::swig-lispify "btCollisionWorld_rayTestSingle" 'function)) :void
  (rayFromTrans :pointer)
  (rayToTrans :pointer)
  (collisionObject :pointer)
  (collisionShape :pointer)
  (colObjWorldTransform :pointer)
  (resultCallback :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btCollisionWorld_rayTestSingle" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCollisionWorld_rayTestSingleInternal" 'function)))

(cffi:defcfun ("_wrap_btCollisionWorld_rayTestSingleInternal" #.(bullet-wrap::swig-lispify "btCollisionWorld_rayTestSingleInternal" 'function)) :void
  (rayFromTrans :pointer)
  (rayToTrans :pointer)
  (collisionObjectWrap :pointer)
  (resultCallback :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btCollisionWorld_rayTestSingleInternal" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCollisionWorld_objectQuerySingle" 'function)))

(cffi:defcfun ("_wrap_btCollisionWorld_objectQuerySingle" #.(bullet-wrap::swig-lispify "btCollisionWorld_objectQuerySingle" 'function)) :void
  (castShape :pointer)
  (rayFromTrans :pointer)
  (rayToTrans :pointer)
  (collisionObject :pointer)
  (collisionShape :pointer)
  (colObjWorldTransform :pointer)
  (resultCallback :pointer)
  (allowedPenetration :float))

(cl:export '#.(bullet-wrap::swig-lispify "btCollisionWorld_objectQuerySingle" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCollisionWorld_objectQuerySingleInternal" 'function)))

(cffi:defcfun ("_wrap_btCollisionWorld_objectQuerySingleInternal" #.(bullet-wrap::swig-lispify "btCollisionWorld_objectQuerySingleInternal" 'function)) :void
  (castShape :pointer)
  (convexFromTrans :pointer)
  (convexToTrans :pointer)
  (colObjWrap :pointer)
  (resultCallback :pointer)
  (allowedPenetration :float))

(cl:export '#.(bullet-wrap::swig-lispify "btCollisionWorld_objectQuerySingleInternal" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCollisionWorld_addCollisionObject" 'function)))

(cffi:defcfun ("_wrap_btCollisionWorld_addCollisionObject__SWIG_0" #.(bullet-wrap::swig-lispify "btCollisionWorld_addCollisionObject" 'function)) :void
  (self :pointer)
  (collisionObject :pointer)
  (collisionFilterGroup :short)
  (collisionFilterMask :short))

(cl:export '#.(bullet-wrap::swig-lispify "btCollisionWorld_addCollisionObject" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCollisionWorld_addCollisionObject" 'function)))

(cffi:defcfun ("_wrap_btCollisionWorld_addCollisionObject__SWIG_1" #.(bullet-wrap::swig-lispify "btCollisionWorld_addCollisionObject" 'function)) :void
  (self :pointer)
  (collisionObject :pointer)
  (collisionFilterGroup :short))

(cl:export '#.(bullet-wrap::swig-lispify "btCollisionWorld_addCollisionObject" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCollisionWorld_addCollisionObject" 'function)))

(cffi:defcfun ("_wrap_btCollisionWorld_addCollisionObject__SWIG_2" #.(bullet-wrap::swig-lispify "btCollisionWorld_addCollisionObject" 'function)) :void
  (self :pointer)
  (collisionObject :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btCollisionWorld_addCollisionObject" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCollisionWorld_getCollisionObjectArray" 'function)))

(cffi:defcfun ("_wrap_btCollisionWorld_getCollisionObjectArray__SWIG_0" #.(bullet-wrap::swig-lispify "btCollisionWorld_getCollisionObjectArray" 'function)) :pointer
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btCollisionWorld_getCollisionObjectArray" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCollisionWorld_getCollisionObjectArray" 'function)))

(cffi:defcfun ("_wrap_btCollisionWorld_getCollisionObjectArray__SWIG_1" #.(bullet-wrap::swig-lispify "btCollisionWorld_getCollisionObjectArray" 'function)) :pointer
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btCollisionWorld_getCollisionObjectArray" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCollisionWorld_removeCollisionObject" 'function)))

(cffi:defcfun ("_wrap_btCollisionWorld_removeCollisionObject" #.(bullet-wrap::swig-lispify "btCollisionWorld_removeCollisionObject" 'function)) :void
  (self :pointer)
  (collisionObject :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btCollisionWorld_removeCollisionObject" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCollisionWorld_performDiscreteCollisionDetection" 'function)))

(cffi:defcfun ("_wrap_btCollisionWorld_performDiscreteCollisionDetection" #.(bullet-wrap::swig-lispify "btCollisionWorld_performDiscreteCollisionDetection" 'function)) :void
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btCollisionWorld_performDiscreteCollisionDetection" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCollisionWorld_getDispatchInfo" 'function)))

(cffi:defcfun ("_wrap_btCollisionWorld_getDispatchInfo__SWIG_0" #.(bullet-wrap::swig-lispify "btCollisionWorld_getDispatchInfo" 'function)) :pointer
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btCollisionWorld_getDispatchInfo" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCollisionWorld_getDispatchInfo" 'function)))

(cffi:defcfun ("_wrap_btCollisionWorld_getDispatchInfo__SWIG_1" #.(bullet-wrap::swig-lispify "btCollisionWorld_getDispatchInfo" 'function)) :pointer
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btCollisionWorld_getDispatchInfo" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCollisionWorld_getForceUpdateAllAabbs" 'function)))

(cffi:defcfun ("_wrap_btCollisionWorld_getForceUpdateAllAabbs" #.(bullet-wrap::swig-lispify "btCollisionWorld_getForceUpdateAllAabbs" 'function)) :pointer
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btCollisionWorld_getForceUpdateAllAabbs" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCollisionWorld_setForceUpdateAllAabbs" 'function)))

(cffi:defcfun ("_wrap_btCollisionWorld_setForceUpdateAllAabbs" #.(bullet-wrap::swig-lispify "btCollisionWorld_setForceUpdateAllAabbs" 'function)) :void
  (self :pointer)
  (forceUpdateAllAabbs :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btCollisionWorld_setForceUpdateAllAabbs" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCollisionWorld_serialize" 'function)))

(cffi:defcfun ("_wrap_btCollisionWorld_serialize" #.(bullet-wrap::swig-lispify "btCollisionWorld_serialize" 'function)) :void
  (self :pointer)
  (serializer :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btCollisionWorld_serialize" 'function))

(cl:defconstant #.(bullet-wrap::swig-lispify "ACTIVE_TAG" 'constant) 1)

(cl:export '#.(bullet-wrap::swig-lispify "ACTIVE_TAG" 'constant))

(cl:defconstant #.(bullet-wrap::swig-lispify "ISLAND_SLEEPING" 'constant) 2)

(cl:export '#.(bullet-wrap::swig-lispify "ISLAND_SLEEPING" 'constant))

(cl:defconstant #.(bullet-wrap::swig-lispify "WANTS_DEACTIVATION" 'constant) 3)

(cl:export '#.(bullet-wrap::swig-lispify "WANTS_DEACTIVATION" 'constant))

(cl:defconstant #.(bullet-wrap::swig-lispify "DISABLE_DEACTIVATION" 'constant) 4)

(cl:export '#.(bullet-wrap::swig-lispify "DISABLE_DEACTIVATION" 'constant))

(cl:defconstant #.(bullet-wrap::swig-lispify "DISABLE_SIMULATION" 'constant) 5)

(cl:export '#.(bullet-wrap::swig-lispify "DISABLE_SIMULATION" 'constant))

(cl:defconstant #.(bullet-wrap::swig-lispify "btCollisionObjectDataName" 'constant) "btCollisionObjectFloatData")

(cl:export '#.(bullet-wrap::swig-lispify "btCollisionObjectDataName" 'constant))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCollisionObject_makeCPlusPlusInstance" 'function)))

(cffi:defcfun ("_wrap_btCollisionObject_makeCPlusPlusInstance__SWIG_0" #.(bullet-wrap::swig-lispify "btCollisionObject_makeCPlusPlusInstance" 'function)) :pointer
  (self :pointer)
  (sizeInBytes :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btCollisionObject_makeCPlusPlusInstance" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCollisionObject_deleteCPlusPlusInstance" 'function)))

(cffi:defcfun ("_wrap_btCollisionObject_deleteCPlusPlusInstance__SWIG_0" #.(bullet-wrap::swig-lispify "btCollisionObject_deleteCPlusPlusInstance" 'function)) :void
  (self :pointer)
  (ptr :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btCollisionObject_deleteCPlusPlusInstance" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCollisionObject_makeCPlusPlusInstance" 'function)))

(cffi:defcfun ("_wrap_btCollisionObject_makeCPlusPlusInstance__SWIG_1" #.(bullet-wrap::swig-lispify "btCollisionObject_makeCPlusPlusInstance" 'function)) :pointer
  (self :pointer)
  (arg1 :pointer)
  (ptr :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btCollisionObject_makeCPlusPlusInstance" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCollisionObject_deleteCPlusPlusInstance" 'function)))

(cffi:defcfun ("_wrap_btCollisionObject_deleteCPlusPlusInstance__SWIG_1" #.(bullet-wrap::swig-lispify "btCollisionObject_deleteCPlusPlusInstance" 'function)) :void
  (self :pointer)
  (arg1 :pointer)
  (arg2 :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btCollisionObject_deleteCPlusPlusInstance" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCollisionObject_makeCPlusArray" 'function)))

(cffi:defcfun ("_wrap_btCollisionObject_makeCPlusArray__SWIG_0" #.(bullet-wrap::swig-lispify "btCollisionObject_makeCPlusArray" 'function)) :pointer
  (self :pointer)
  (sizeInBytes :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btCollisionObject_makeCPlusArray" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCollisionObject_deleteCPlusArray" 'function)))

(cffi:defcfun ("_wrap_btCollisionObject_deleteCPlusArray__SWIG_0" #.(bullet-wrap::swig-lispify "btCollisionObject_deleteCPlusArray" 'function)) :void
  (self :pointer)
  (ptr :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btCollisionObject_deleteCPlusArray" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCollisionObject_makeCPlusArray" 'function)))

(cffi:defcfun ("_wrap_btCollisionObject_makeCPlusArray__SWIG_1" #.(bullet-wrap::swig-lispify "btCollisionObject_makeCPlusArray" 'function)) :pointer
  (self :pointer)
  (arg1 :pointer)
  (ptr :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btCollisionObject_makeCPlusArray" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCollisionObject_deleteCPlusArray" 'function)))

(cffi:defcfun ("_wrap_btCollisionObject_deleteCPlusArray__SWIG_1" #.(bullet-wrap::swig-lispify "btCollisionObject_deleteCPlusArray" 'function)) :void
  (self :pointer)
  (arg1 :pointer)
  (arg2 :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btCollisionObject_deleteCPlusArray" 'function))

(cffi:defcenum #.(bullet-wrap::swig-lispify "CollisionFlags" 'enumname)
	(#.(bullet-wrap::swig-lispify "CF_STATIC_OBJECT" 'enumvalue :keyword) #.1)
	(#.(bullet-wrap::swig-lispify "CF_KINEMATIC_OBJECT" 'enumvalue :keyword) #.2)
	(#.(bullet-wrap::swig-lispify "CF_NO_CONTACT_RESPONSE" 'enumvalue :keyword) #.4)
	(#.(bullet-wrap::swig-lispify "CF_CUSTOM_MATERIAL_CALLBACK" 'enumvalue :keyword) #.8)
	(#.(bullet-wrap::swig-lispify "CF_CHARACTER_OBJECT" 'enumvalue :keyword) #.16)
	(#.(bullet-wrap::swig-lispify "CF_DISABLE_VISUALIZE_OBJECT" 'enumvalue :keyword) #.32)
	(#.(bullet-wrap::swig-lispify "CF_DISABLE_SPU_COLLISION_PROCESSING" 'enumvalue :keyword) #.64))

(cl:export '#.(bullet-wrap::swig-lispify "CollisionFlags" 'enumname))

(cffi:defcenum #.(bullet-wrap::swig-lispify "CollisionObjectTypes" 'enumname)
	(#.(bullet-wrap::swig-lispify "CO_COLLISION_OBJECT" 'enumvalue :keyword) #.1)
	(#.(bullet-wrap::swig-lispify "CO_RIGID_BODY" 'enumvalue :keyword) #.2)
	(#.(bullet-wrap::swig-lispify "CO_GHOST_OBJECT" 'enumvalue :keyword) #.4)
	(#.(bullet-wrap::swig-lispify "CO_SOFT_BODY" 'enumvalue :keyword) #.8)
	(#.(bullet-wrap::swig-lispify "CO_HF_FLUID" 'enumvalue :keyword) #.16)
	(#.(bullet-wrap::swig-lispify "CO_USER_TYPE" 'enumvalue :keyword) #.32)
	(#.(bullet-wrap::swig-lispify "CO_FEATHERSTONE_LINK" 'enumvalue :keyword) #.64))

(cl:export '#.(bullet-wrap::swig-lispify "CollisionObjectTypes" 'enumname))

(cffi:defcenum #.(bullet-wrap::swig-lispify "AnisotropicFrictionFlags" 'enumname)
	(#.(bullet-wrap::swig-lispify "CF_ANISOTROPIC_FRICTION_DISABLED" 'enumvalue :keyword) #.0)
	(#.(bullet-wrap::swig-lispify "CF_ANISOTROPIC_FRICTION" 'enumvalue :keyword) #.1)
	(#.(bullet-wrap::swig-lispify "CF_ANISOTROPIC_ROLLING_FRICTION" 'enumvalue :keyword) #.2))

(cl:export '#.(bullet-wrap::swig-lispify "AnisotropicFrictionFlags" 'enumname))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCollisionObject_mergesSimulationIslands" 'function)))

(cffi:defcfun ("_wrap_btCollisionObject_mergesSimulationIslands" #.(bullet-wrap::swig-lispify "btCollisionObject_mergesSimulationIslands" 'function)) :pointer
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btCollisionObject_mergesSimulationIslands" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCollisionObject_getAnisotropicFriction" 'function)))

(cffi:defcfun ("_wrap_btCollisionObject_getAnisotropicFriction" #.(bullet-wrap::swig-lispify "btCollisionObject_getAnisotropicFriction" 'function)) :pointer
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btCollisionObject_getAnisotropicFriction" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCollisionObject_setAnisotropicFriction" 'function)))

(cffi:defcfun ("_wrap_btCollisionObject_setAnisotropicFriction__SWIG_0" #.(bullet-wrap::swig-lispify "btCollisionObject_setAnisotropicFriction" 'function)) :void
  (self :pointer)
  (anisotropicFriction :pointer)
  (frictionMode :int))

(cl:export '#.(bullet-wrap::swig-lispify "btCollisionObject_setAnisotropicFriction" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCollisionObject_setAnisotropicFriction" 'function)))

(cffi:defcfun ("_wrap_btCollisionObject_setAnisotropicFriction__SWIG_1" #.(bullet-wrap::swig-lispify "btCollisionObject_setAnisotropicFriction" 'function)) :void
  (self :pointer)
  (anisotropicFriction :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btCollisionObject_setAnisotropicFriction" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCollisionObject_hasAnisotropicFriction" 'function)))

(cffi:defcfun ("_wrap_btCollisionObject_hasAnisotropicFriction__SWIG_0" #.(bullet-wrap::swig-lispify "btCollisionObject_hasAnisotropicFriction" 'function)) :pointer
  (self :pointer)
  (frictionMode :int))

(cl:export '#.(bullet-wrap::swig-lispify "btCollisionObject_hasAnisotropicFriction" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCollisionObject_hasAnisotropicFriction" 'function)))

(cffi:defcfun ("_wrap_btCollisionObject_hasAnisotropicFriction__SWIG_1" #.(bullet-wrap::swig-lispify "btCollisionObject_hasAnisotropicFriction" 'function)) :pointer
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btCollisionObject_hasAnisotropicFriction" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCollisionObject_setContactProcessingThreshold" 'function)))

(cffi:defcfun ("_wrap_btCollisionObject_setContactProcessingThreshold" #.(bullet-wrap::swig-lispify "btCollisionObject_setContactProcessingThreshold" 'function)) :void
  (self :pointer)
  (contactProcessingThreshold :float))

(cl:export '#.(bullet-wrap::swig-lispify "btCollisionObject_setContactProcessingThreshold" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCollisionObject_getContactProcessingThreshold" 'function)))

(cffi:defcfun ("_wrap_btCollisionObject_getContactProcessingThreshold" #.(bullet-wrap::swig-lispify "btCollisionObject_getContactProcessingThreshold" 'function)) :float
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btCollisionObject_getContactProcessingThreshold" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCollisionObject_isStaticObject" 'function)))

(cffi:defcfun ("_wrap_btCollisionObject_isStaticObject" #.(bullet-wrap::swig-lispify "btCollisionObject_isStaticObject" 'function)) :pointer
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btCollisionObject_isStaticObject" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCollisionObject_isKinematicObject" 'function)))

(cffi:defcfun ("_wrap_btCollisionObject_isKinematicObject" #.(bullet-wrap::swig-lispify "btCollisionObject_isKinematicObject" 'function)) :pointer
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btCollisionObject_isKinematicObject" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCollisionObject_isStaticOrKinematicObject" 'function)))

(cffi:defcfun ("_wrap_btCollisionObject_isStaticOrKinematicObject" #.(bullet-wrap::swig-lispify "btCollisionObject_isStaticOrKinematicObject" 'function)) :pointer
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btCollisionObject_isStaticOrKinematicObject" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCollisionObject_hasContactResponse" 'function)))

(cffi:defcfun ("_wrap_btCollisionObject_hasContactResponse" #.(bullet-wrap::swig-lispify "btCollisionObject_hasContactResponse" 'function)) :pointer
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btCollisionObject_hasContactResponse" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "new_btCollisionObject" 'function)))

(cffi:defcfun ("_wrap_new_btCollisionObject" #.(bullet-wrap::swig-lispify "new_btCollisionObject" 'function)) :pointer)

(cl:export '#.(bullet-wrap::swig-lispify "new_btCollisionObject" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "delete_btCollisionObject" 'function)))

(cffi:defcfun ("_wrap_delete_btCollisionObject" #.(bullet-wrap::swig-lispify "delete_btCollisionObject" 'function)) :void
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "delete_btCollisionObject" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCollisionObject_setCollisionShape" 'function)))

(cffi:defcfun ("_wrap_btCollisionObject_setCollisionShape" #.(bullet-wrap::swig-lispify "btCollisionObject_setCollisionShape" 'function)) :void
  (self :pointer)
  (collisionShape :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btCollisionObject_setCollisionShape" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCollisionObject_getCollisionShape" 'function)))

(cffi:defcfun ("_wrap_btCollisionObject_getCollisionShape__SWIG_0" #.(bullet-wrap::swig-lispify "btCollisionObject_getCollisionShape" 'function)) :pointer
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btCollisionObject_getCollisionShape" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCollisionObject_getCollisionShape" 'function)))

(cffi:defcfun ("_wrap_btCollisionObject_getCollisionShape__SWIG_1" #.(bullet-wrap::swig-lispify "btCollisionObject_getCollisionShape" 'function)) :pointer
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btCollisionObject_getCollisionShape" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCollisionObject_internalGetExtensionPointer" 'function)))

(cffi:defcfun ("_wrap_btCollisionObject_internalGetExtensionPointer" #.(bullet-wrap::swig-lispify "btCollisionObject_internalGetExtensionPointer" 'function)) :pointer
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btCollisionObject_internalGetExtensionPointer" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCollisionObject_internalSetExtensionPointer" 'function)))

(cffi:defcfun ("_wrap_btCollisionObject_internalSetExtensionPointer" #.(bullet-wrap::swig-lispify "btCollisionObject_internalSetExtensionPointer" 'function)) :void
  (self :pointer)
  (pointer :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btCollisionObject_internalSetExtensionPointer" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCollisionObject_getActivationState" 'function)))

(cffi:defcfun ("_wrap_btCollisionObject_getActivationState" #.(bullet-wrap::swig-lispify "btCollisionObject_getActivationState" 'function)) :int
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btCollisionObject_getActivationState" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCollisionObject_setActivationState" 'function)))

(cffi:defcfun ("_wrap_btCollisionObject_setActivationState" #.(bullet-wrap::swig-lispify "btCollisionObject_setActivationState" 'function)) :void
  (self :pointer)
  (newState :int))

(cl:export '#.(bullet-wrap::swig-lispify "btCollisionObject_setActivationState" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCollisionObject_setDeactivationTime" 'function)))

(cffi:defcfun ("_wrap_btCollisionObject_setDeactivationTime" #.(bullet-wrap::swig-lispify "btCollisionObject_setDeactivationTime" 'function)) :void
  (self :pointer)
  (time :float))

(cl:export '#.(bullet-wrap::swig-lispify "btCollisionObject_setDeactivationTime" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCollisionObject_getDeactivationTime" 'function)))

(cffi:defcfun ("_wrap_btCollisionObject_getDeactivationTime" #.(bullet-wrap::swig-lispify "btCollisionObject_getDeactivationTime" 'function)) :float
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btCollisionObject_getDeactivationTime" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCollisionObject_forceActivationState" 'function)))

(cffi:defcfun ("_wrap_btCollisionObject_forceActivationState" #.(bullet-wrap::swig-lispify "btCollisionObject_forceActivationState" 'function)) :void
  (self :pointer)
  (newState :int))

(cl:export '#.(bullet-wrap::swig-lispify "btCollisionObject_forceActivationState" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCollisionObject_activate" 'function)))

(cffi:defcfun ("_wrap_btCollisionObject_activate__SWIG_0" #.(bullet-wrap::swig-lispify "btCollisionObject_activate" 'function)) :void
  (self :pointer)
  (forceActivation :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btCollisionObject_activate" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCollisionObject_activate" 'function)))

(cffi:defcfun ("_wrap_btCollisionObject_activate__SWIG_1" #.(bullet-wrap::swig-lispify "btCollisionObject_activate" 'function)) :void
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btCollisionObject_activate" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCollisionObject_isActive" 'function)))

(cffi:defcfun ("_wrap_btCollisionObject_isActive" #.(bullet-wrap::swig-lispify "btCollisionObject_isActive" 'function)) :pointer
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btCollisionObject_isActive" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCollisionObject_setRestitution" 'function)))

(cffi:defcfun ("_wrap_btCollisionObject_setRestitution" #.(bullet-wrap::swig-lispify "btCollisionObject_setRestitution" 'function)) :void
  (self :pointer)
  (rest :float))

(cl:export '#.(bullet-wrap::swig-lispify "btCollisionObject_setRestitution" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCollisionObject_getRestitution" 'function)))

(cffi:defcfun ("_wrap_btCollisionObject_getRestitution" #.(bullet-wrap::swig-lispify "btCollisionObject_getRestitution" 'function)) :float
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btCollisionObject_getRestitution" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCollisionObject_setFriction" 'function)))

(cffi:defcfun ("_wrap_btCollisionObject_setFriction" #.(bullet-wrap::swig-lispify "btCollisionObject_setFriction" 'function)) :void
  (self :pointer)
  (frict :float))

(cl:export '#.(bullet-wrap::swig-lispify "btCollisionObject_setFriction" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCollisionObject_getFriction" 'function)))

(cffi:defcfun ("_wrap_btCollisionObject_getFriction" #.(bullet-wrap::swig-lispify "btCollisionObject_getFriction" 'function)) :float
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btCollisionObject_getFriction" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCollisionObject_setRollingFriction" 'function)))

(cffi:defcfun ("_wrap_btCollisionObject_setRollingFriction" #.(bullet-wrap::swig-lispify "btCollisionObject_setRollingFriction" 'function)) :void
  (self :pointer)
  (frict :float))

(cl:export '#.(bullet-wrap::swig-lispify "btCollisionObject_setRollingFriction" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCollisionObject_getRollingFriction" 'function)))

(cffi:defcfun ("_wrap_btCollisionObject_getRollingFriction" #.(bullet-wrap::swig-lispify "btCollisionObject_getRollingFriction" 'function)) :float
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btCollisionObject_getRollingFriction" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCollisionObject_getInternalType" 'function)))

(cffi:defcfun ("_wrap_btCollisionObject_getInternalType" #.(bullet-wrap::swig-lispify "btCollisionObject_getInternalType" 'function)) :int
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btCollisionObject_getInternalType" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCollisionObject_getWorldTransform" 'function)))

(cffi:defcfun ("_wrap_btCollisionObject_getWorldTransform__SWIG_0" #.(bullet-wrap::swig-lispify "btCollisionObject_getWorldTransform" 'function)) :pointer
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btCollisionObject_getWorldTransform" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCollisionObject_getWorldTransform" 'function)))

(cffi:defcfun ("_wrap_btCollisionObject_getWorldTransform__SWIG_1" #.(bullet-wrap::swig-lispify "btCollisionObject_getWorldTransform" 'function)) :pointer
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btCollisionObject_getWorldTransform" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCollisionObject_setWorldTransform" 'function)))

(cffi:defcfun ("_wrap_btCollisionObject_setWorldTransform" #.(bullet-wrap::swig-lispify "btCollisionObject_setWorldTransform" 'function)) :void
  (self :pointer)
  (worldTrans :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btCollisionObject_setWorldTransform" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCollisionObject_getBroadphaseHandle" 'function)))

(cffi:defcfun ("_wrap_btCollisionObject_getBroadphaseHandle__SWIG_0" #.(bullet-wrap::swig-lispify "btCollisionObject_getBroadphaseHandle" 'function)) :pointer
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btCollisionObject_getBroadphaseHandle" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCollisionObject_getBroadphaseHandle" 'function)))

(cffi:defcfun ("_wrap_btCollisionObject_getBroadphaseHandle__SWIG_1" #.(bullet-wrap::swig-lispify "btCollisionObject_getBroadphaseHandle" 'function)) :pointer
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btCollisionObject_getBroadphaseHandle" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCollisionObject_setBroadphaseHandle" 'function)))

(cffi:defcfun ("_wrap_btCollisionObject_setBroadphaseHandle" #.(bullet-wrap::swig-lispify "btCollisionObject_setBroadphaseHandle" 'function)) :void
  (self :pointer)
  (handle :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btCollisionObject_setBroadphaseHandle" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCollisionObject_getInterpolationWorldTransform" 'function)))

(cffi:defcfun ("_wrap_btCollisionObject_getInterpolationWorldTransform__SWIG_0" #.(bullet-wrap::swig-lispify "btCollisionObject_getInterpolationWorldTransform" 'function)) :pointer
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btCollisionObject_getInterpolationWorldTransform" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCollisionObject_getInterpolationWorldTransform" 'function)))

(cffi:defcfun ("_wrap_btCollisionObject_getInterpolationWorldTransform__SWIG_1" #.(bullet-wrap::swig-lispify "btCollisionObject_getInterpolationWorldTransform" 'function)) :pointer
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btCollisionObject_getInterpolationWorldTransform" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCollisionObject_setInterpolationWorldTransform" 'function)))

(cffi:defcfun ("_wrap_btCollisionObject_setInterpolationWorldTransform" #.(bullet-wrap::swig-lispify "btCollisionObject_setInterpolationWorldTransform" 'function)) :void
  (self :pointer)
  (trans :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btCollisionObject_setInterpolationWorldTransform" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCollisionObject_setInterpolationLinearVelocity" 'function)))

(cffi:defcfun ("_wrap_btCollisionObject_setInterpolationLinearVelocity" #.(bullet-wrap::swig-lispify "btCollisionObject_setInterpolationLinearVelocity" 'function)) :void
  (self :pointer)
  (linvel :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btCollisionObject_setInterpolationLinearVelocity" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCollisionObject_setInterpolationAngularVelocity" 'function)))

(cffi:defcfun ("_wrap_btCollisionObject_setInterpolationAngularVelocity" #.(bullet-wrap::swig-lispify "btCollisionObject_setInterpolationAngularVelocity" 'function)) :void
  (self :pointer)
  (angvel :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btCollisionObject_setInterpolationAngularVelocity" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCollisionObject_getInterpolationLinearVelocity" 'function)))

(cffi:defcfun ("_wrap_btCollisionObject_getInterpolationLinearVelocity" #.(bullet-wrap::swig-lispify "btCollisionObject_getInterpolationLinearVelocity" 'function)) :pointer
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btCollisionObject_getInterpolationLinearVelocity" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCollisionObject_getInterpolationAngularVelocity" 'function)))

(cffi:defcfun ("_wrap_btCollisionObject_getInterpolationAngularVelocity" #.(bullet-wrap::swig-lispify "btCollisionObject_getInterpolationAngularVelocity" 'function)) :pointer
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btCollisionObject_getInterpolationAngularVelocity" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCollisionObject_getIslandTag" 'function)))

(cffi:defcfun ("_wrap_btCollisionObject_getIslandTag" #.(bullet-wrap::swig-lispify "btCollisionObject_getIslandTag" 'function)) :int
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btCollisionObject_getIslandTag" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCollisionObject_setIslandTag" 'function)))

(cffi:defcfun ("_wrap_btCollisionObject_setIslandTag" #.(bullet-wrap::swig-lispify "btCollisionObject_setIslandTag" 'function)) :void
  (self :pointer)
  (tag :int))

(cl:export '#.(bullet-wrap::swig-lispify "btCollisionObject_setIslandTag" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCollisionObject_getCompanionId" 'function)))

(cffi:defcfun ("_wrap_btCollisionObject_getCompanionId" #.(bullet-wrap::swig-lispify "btCollisionObject_getCompanionId" 'function)) :int
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btCollisionObject_getCompanionId" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCollisionObject_setCompanionId" 'function)))

(cffi:defcfun ("_wrap_btCollisionObject_setCompanionId" #.(bullet-wrap::swig-lispify "btCollisionObject_setCompanionId" 'function)) :void
  (self :pointer)
  (id :int))

(cl:export '#.(bullet-wrap::swig-lispify "btCollisionObject_setCompanionId" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCollisionObject_getHitFraction" 'function)))

(cffi:defcfun ("_wrap_btCollisionObject_getHitFraction" #.(bullet-wrap::swig-lispify "btCollisionObject_getHitFraction" 'function)) :float
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btCollisionObject_getHitFraction" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCollisionObject_setHitFraction" 'function)))

(cffi:defcfun ("_wrap_btCollisionObject_setHitFraction" #.(bullet-wrap::swig-lispify "btCollisionObject_setHitFraction" 'function)) :void
  (self :pointer)
  (hitFraction :float))

(cl:export '#.(bullet-wrap::swig-lispify "btCollisionObject_setHitFraction" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCollisionObject_getCollisionFlags" 'function)))

(cffi:defcfun ("_wrap_btCollisionObject_getCollisionFlags" #.(bullet-wrap::swig-lispify "btCollisionObject_getCollisionFlags" 'function)) :int
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btCollisionObject_getCollisionFlags" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCollisionObject_setCollisionFlags" 'function)))

(cffi:defcfun ("_wrap_btCollisionObject_setCollisionFlags" #.(bullet-wrap::swig-lispify "btCollisionObject_setCollisionFlags" 'function)) :void
  (self :pointer)
  (flags :int))

(cl:export '#.(bullet-wrap::swig-lispify "btCollisionObject_setCollisionFlags" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCollisionObject_getCcdSweptSphereRadius" 'function)))

(cffi:defcfun ("_wrap_btCollisionObject_getCcdSweptSphereRadius" #.(bullet-wrap::swig-lispify "btCollisionObject_getCcdSweptSphereRadius" 'function)) :float
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btCollisionObject_getCcdSweptSphereRadius" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCollisionObject_setCcdSweptSphereRadius" 'function)))

(cffi:defcfun ("_wrap_btCollisionObject_setCcdSweptSphereRadius" #.(bullet-wrap::swig-lispify "btCollisionObject_setCcdSweptSphereRadius" 'function)) :void
  (self :pointer)
  (radius :float))

(cl:export '#.(bullet-wrap::swig-lispify "btCollisionObject_setCcdSweptSphereRadius" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCollisionObject_getCcdMotionThreshold" 'function)))

(cffi:defcfun ("_wrap_btCollisionObject_getCcdMotionThreshold" #.(bullet-wrap::swig-lispify "btCollisionObject_getCcdMotionThreshold" 'function)) :float
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btCollisionObject_getCcdMotionThreshold" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCollisionObject_getCcdSquareMotionThreshold" 'function)))

(cffi:defcfun ("_wrap_btCollisionObject_getCcdSquareMotionThreshold" #.(bullet-wrap::swig-lispify "btCollisionObject_getCcdSquareMotionThreshold" 'function)) :float
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btCollisionObject_getCcdSquareMotionThreshold" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCollisionObject_setCcdMotionThreshold" 'function)))

(cffi:defcfun ("_wrap_btCollisionObject_setCcdMotionThreshold" #.(bullet-wrap::swig-lispify "btCollisionObject_setCcdMotionThreshold" 'function)) :void
  (self :pointer)
  (ccdMotionThreshold :float))

(cl:export '#.(bullet-wrap::swig-lispify "btCollisionObject_setCcdMotionThreshold" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCollisionObject_getUserPointer" 'function)))

(cffi:defcfun ("_wrap_btCollisionObject_getUserPointer" #.(bullet-wrap::swig-lispify "btCollisionObject_getUserPointer" 'function)) :pointer
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btCollisionObject_getUserPointer" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCollisionObject_getUserIndex" 'function)))

(cffi:defcfun ("_wrap_btCollisionObject_getUserIndex" #.(bullet-wrap::swig-lispify "btCollisionObject_getUserIndex" 'function)) :int
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btCollisionObject_getUserIndex" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCollisionObject_setUserPointer" 'function)))

(cffi:defcfun ("_wrap_btCollisionObject_setUserPointer" #.(bullet-wrap::swig-lispify "btCollisionObject_setUserPointer" 'function)) :void
  (self :pointer)
  (userPointer :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btCollisionObject_setUserPointer" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCollisionObject_setUserIndex" 'function)))

(cffi:defcfun ("_wrap_btCollisionObject_setUserIndex" #.(bullet-wrap::swig-lispify "btCollisionObject_setUserIndex" 'function)) :void
  (self :pointer)
  (index :int))

(cl:export '#.(bullet-wrap::swig-lispify "btCollisionObject_setUserIndex" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCollisionObject_getUpdateRevisionInternal" 'function)))

(cffi:defcfun ("_wrap_btCollisionObject_getUpdateRevisionInternal" #.(bullet-wrap::swig-lispify "btCollisionObject_getUpdateRevisionInternal" 'function)) :int
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btCollisionObject_getUpdateRevisionInternal" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCollisionObject_checkCollideWith" 'function)))

(cffi:defcfun ("_wrap_btCollisionObject_checkCollideWith" #.(bullet-wrap::swig-lispify "btCollisionObject_checkCollideWith" 'function)) :pointer
  (self :pointer)
  (co :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btCollisionObject_checkCollideWith" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCollisionObject_calculateSerializeBufferSize" 'function)))

(cffi:defcfun ("_wrap_btCollisionObject_calculateSerializeBufferSize" #.(bullet-wrap::swig-lispify "btCollisionObject_calculateSerializeBufferSize" 'function)) :int
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btCollisionObject_calculateSerializeBufferSize" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCollisionObject_serialize" 'function)))

(cffi:defcfun ("_wrap_btCollisionObject_serialize" #.(bullet-wrap::swig-lispify "btCollisionObject_serialize" 'function)) :string
  (self :pointer)
  (dataBuffer :pointer)
  (serializer :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btCollisionObject_serialize" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCollisionObject_serializeSingleObject" 'function)))

(cffi:defcfun ("_wrap_btCollisionObject_serializeSingleObject" #.(bullet-wrap::swig-lispify "btCollisionObject_serializeSingleObject" 'function)) :void
  (self :pointer)
  (serializer :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btCollisionObject_serializeSingleObject" 'function))

(cffi:defcstruct #.(bullet-wrap::swig-lispify "btCollisionObjectDoubleData" 'classname)
	(#.(bullet-wrap::swig-lispify "m_broadphaseHandle" 'slotname) :pointer)
	(#.(bullet-wrap::swig-lispify "m_collisionShape" 'slotname) :pointer)
	(#.(bullet-wrap::swig-lispify "m_rootCollisionShape" 'slotname) :pointer)
	(#.(bullet-wrap::swig-lispify "m_name" 'slotname) :string)
	(#.(bullet-wrap::swig-lispify "m_worldTransform" 'slotname) #.(bullet-wrap::swig-lispify "btTransformDoubleData" 'classname))
	(#.(bullet-wrap::swig-lispify "m_interpolationWorldTransform" 'slotname) #.(bullet-wrap::swig-lispify "btTransformDoubleData" 'classname))
	(#.(bullet-wrap::swig-lispify "m_interpolationLinearVelocity" 'slotname) #.(bullet-wrap::swig-lispify "btVector3DoubleData" 'classname))
	(#.(bullet-wrap::swig-lispify "m_interpolationAngularVelocity" 'slotname) #.(bullet-wrap::swig-lispify "btVector3DoubleData" 'classname))
	(#.(bullet-wrap::swig-lispify "m_anisotropicFriction" 'slotname) #.(bullet-wrap::swig-lispify "btVector3DoubleData" 'classname))
	(#.(bullet-wrap::swig-lispify "m_contactProcessingThreshold" 'slotname) :double)
	(#.(bullet-wrap::swig-lispify "m_deactivationTime" 'slotname) :double)
	(#.(bullet-wrap::swig-lispify "m_friction" 'slotname) :double)
	(#.(bullet-wrap::swig-lispify "m_rollingFriction" 'slotname) :double)
	(#.(bullet-wrap::swig-lispify "m_restitution" 'slotname) :double)
	(#.(bullet-wrap::swig-lispify "m_hitFraction" 'slotname) :double)
	(#.(bullet-wrap::swig-lispify "m_ccdSweptSphereRadius" 'slotname) :double)
	(#.(bullet-wrap::swig-lispify "m_ccdMotionThreshold" 'slotname) :double)
	(#.(bullet-wrap::swig-lispify "m_hasAnisotropicFriction" 'slotname) :int)
	(#.(bullet-wrap::swig-lispify "m_collisionFlags" 'slotname) :int)
	(#.(bullet-wrap::swig-lispify "m_islandTag1" 'slotname) :int)
	(#.(bullet-wrap::swig-lispify "m_companionId" 'slotname) :int)
	(#.(bullet-wrap::swig-lispify "m_activationState1" 'slotname) :int)
	(#.(bullet-wrap::swig-lispify "m_internalType" 'slotname) :int)
	(#.(bullet-wrap::swig-lispify "m_checkCollideWith" 'slotname) :int)
	(#.(bullet-wrap::swig-lispify "m_padding" 'slotname) :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btCollisionObjectDoubleData" 'classname))

(cl:export '#.(bullet-wrap::swig-lispify "m_broadphaseHandle" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_collisionShape" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_rootCollisionShape" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_name" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_worldTransform" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_interpolationWorldTransform" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_interpolationLinearVelocity" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_interpolationAngularVelocity" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_anisotropicFriction" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_contactProcessingThreshold" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_deactivationTime" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_friction" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_rollingFriction" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_restitution" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_hitFraction" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_ccdSweptSphereRadius" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_ccdMotionThreshold" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_hasAnisotropicFriction" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_collisionFlags" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_islandTag1" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_companionId" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_activationState1" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_internalType" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_checkCollideWith" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_padding" 'slotname))

(cffi:defcstruct #.(bullet-wrap::swig-lispify "btCollisionObjectFloatData" 'classname)
	(#.(bullet-wrap::swig-lispify "m_broadphaseHandle" 'slotname) :pointer)
	(#.(bullet-wrap::swig-lispify "m_collisionShape" 'slotname) :pointer)
	(#.(bullet-wrap::swig-lispify "m_rootCollisionShape" 'slotname) :pointer)
	(#.(bullet-wrap::swig-lispify "m_name" 'slotname) :string)
	(#.(bullet-wrap::swig-lispify "m_worldTransform" 'slotname) #.(bullet-wrap::swig-lispify "btTransformFloatData" 'classname))
	(#.(bullet-wrap::swig-lispify "m_interpolationWorldTransform" 'slotname) #.(bullet-wrap::swig-lispify "btTransformFloatData" 'classname))
	(#.(bullet-wrap::swig-lispify "m_interpolationLinearVelocity" 'slotname) #.(bullet-wrap::swig-lispify "btVector3FloatData" 'classname))
	(#.(bullet-wrap::swig-lispify "m_interpolationAngularVelocity" 'slotname) #.(bullet-wrap::swig-lispify "btVector3FloatData" 'classname))
	(#.(bullet-wrap::swig-lispify "m_anisotropicFriction" 'slotname) #.(bullet-wrap::swig-lispify "btVector3FloatData" 'classname))
	(#.(bullet-wrap::swig-lispify "m_contactProcessingThreshold" 'slotname) :float)
	(#.(bullet-wrap::swig-lispify "m_deactivationTime" 'slotname) :float)
	(#.(bullet-wrap::swig-lispify "m_friction" 'slotname) :float)
	(#.(bullet-wrap::swig-lispify "m_rollingFriction" 'slotname) :float)
	(#.(bullet-wrap::swig-lispify "m_restitution" 'slotname) :float)
	(#.(bullet-wrap::swig-lispify "m_hitFraction" 'slotname) :float)
	(#.(bullet-wrap::swig-lispify "m_ccdSweptSphereRadius" 'slotname) :float)
	(#.(bullet-wrap::swig-lispify "m_ccdMotionThreshold" 'slotname) :float)
	(#.(bullet-wrap::swig-lispify "m_hasAnisotropicFriction" 'slotname) :int)
	(#.(bullet-wrap::swig-lispify "m_collisionFlags" 'slotname) :int)
	(#.(bullet-wrap::swig-lispify "m_islandTag1" 'slotname) :int)
	(#.(bullet-wrap::swig-lispify "m_companionId" 'slotname) :int)
	(#.(bullet-wrap::swig-lispify "m_activationState1" 'slotname) :int)
	(#.(bullet-wrap::swig-lispify "m_internalType" 'slotname) :int)
	(#.(bullet-wrap::swig-lispify "m_checkCollideWith" 'slotname) :int)
	(#.(bullet-wrap::swig-lispify "m_padding" 'slotname) :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btCollisionObjectFloatData" 'classname))

(cl:export '#.(bullet-wrap::swig-lispify "m_broadphaseHandle" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_collisionShape" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_rootCollisionShape" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_name" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_worldTransform" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_interpolationWorldTransform" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_interpolationLinearVelocity" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_interpolationAngularVelocity" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_anisotropicFriction" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_contactProcessingThreshold" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_deactivationTime" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_friction" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_rollingFriction" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_restitution" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_hitFraction" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_ccdSweptSphereRadius" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_ccdMotionThreshold" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_hasAnisotropicFriction" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_collisionFlags" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_islandTag1" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_companionId" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_activationState1" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_internalType" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_checkCollideWith" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_padding" 'slotname))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btBoxShape_makeCPlusPlusInstance" 'function)))

(cffi:defcfun ("_wrap_btBoxShape_makeCPlusPlusInstance__SWIG_0" #.(bullet-wrap::swig-lispify "btBoxShape_makeCPlusPlusInstance" 'function)) :pointer
  (self :pointer)
  (sizeInBytes :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btBoxShape_makeCPlusPlusInstance" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btBoxShape_deleteCPlusPlusInstance" 'function)))

(cffi:defcfun ("_wrap_btBoxShape_deleteCPlusPlusInstance__SWIG_0" #.(bullet-wrap::swig-lispify "btBoxShape_deleteCPlusPlusInstance" 'function)) :void
  (self :pointer)
  (ptr :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btBoxShape_deleteCPlusPlusInstance" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btBoxShape_makeCPlusPlusInstance" 'function)))

(cffi:defcfun ("_wrap_btBoxShape_makeCPlusPlusInstance__SWIG_1" #.(bullet-wrap::swig-lispify "btBoxShape_makeCPlusPlusInstance" 'function)) :pointer
  (self :pointer)
  (arg1 :pointer)
  (ptr :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btBoxShape_makeCPlusPlusInstance" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btBoxShape_deleteCPlusPlusInstance" 'function)))

(cffi:defcfun ("_wrap_btBoxShape_deleteCPlusPlusInstance__SWIG_1" #.(bullet-wrap::swig-lispify "btBoxShape_deleteCPlusPlusInstance" 'function)) :void
  (self :pointer)
  (arg1 :pointer)
  (arg2 :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btBoxShape_deleteCPlusPlusInstance" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btBoxShape_makeCPlusArray" 'function)))

(cffi:defcfun ("_wrap_btBoxShape_makeCPlusArray__SWIG_0" #.(bullet-wrap::swig-lispify "btBoxShape_makeCPlusArray" 'function)) :pointer
  (self :pointer)
  (sizeInBytes :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btBoxShape_makeCPlusArray" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btBoxShape_deleteCPlusArray" 'function)))

(cffi:defcfun ("_wrap_btBoxShape_deleteCPlusArray__SWIG_0" #.(bullet-wrap::swig-lispify "btBoxShape_deleteCPlusArray" 'function)) :void
  (self :pointer)
  (ptr :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btBoxShape_deleteCPlusArray" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btBoxShape_makeCPlusArray" 'function)))

(cffi:defcfun ("_wrap_btBoxShape_makeCPlusArray__SWIG_1" #.(bullet-wrap::swig-lispify "btBoxShape_makeCPlusArray" 'function)) :pointer
  (self :pointer)
  (arg1 :pointer)
  (ptr :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btBoxShape_makeCPlusArray" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btBoxShape_deleteCPlusArray" 'function)))

(cffi:defcfun ("_wrap_btBoxShape_deleteCPlusArray__SWIG_1" #.(bullet-wrap::swig-lispify "btBoxShape_deleteCPlusArray" 'function)) :void
  (self :pointer)
  (arg1 :pointer)
  (arg2 :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btBoxShape_deleteCPlusArray" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btBoxShape_getHalfExtentsWithMargin" 'function)))

(cffi:defcfun ("_wrap_btBoxShape_getHalfExtentsWithMargin" #.(bullet-wrap::swig-lispify "btBoxShape_getHalfExtentsWithMargin" 'function)) :pointer
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btBoxShape_getHalfExtentsWithMargin" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btBoxShape_getHalfExtentsWithoutMargin" 'function)))

(cffi:defcfun ("_wrap_btBoxShape_getHalfExtentsWithoutMargin" #.(bullet-wrap::swig-lispify "btBoxShape_getHalfExtentsWithoutMargin" 'function)) :pointer
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btBoxShape_getHalfExtentsWithoutMargin" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btBoxShape_localGetSupportingVertex" 'function)))

(cffi:defcfun ("_wrap_btBoxShape_localGetSupportingVertex" #.(bullet-wrap::swig-lispify "btBoxShape_localGetSupportingVertex" 'function)) :pointer
  (self :pointer)
  (vec :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btBoxShape_localGetSupportingVertex" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btBoxShape_localGetSupportingVertexWithoutMargin" 'function)))

(cffi:defcfun ("_wrap_btBoxShape_localGetSupportingVertexWithoutMargin" #.(bullet-wrap::swig-lispify "btBoxShape_localGetSupportingVertexWithoutMargin" 'function)) :pointer
  (self :pointer)
  (vec :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btBoxShape_localGetSupportingVertexWithoutMargin" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btBoxShape_batchedUnitVectorGetSupportingVertexWithoutMargin" 'function)))

(cffi:defcfun ("_wrap_btBoxShape_batchedUnitVectorGetSupportingVertexWithoutMargin" #.(bullet-wrap::swig-lispify "btBoxShape_batchedUnitVectorGetSupportingVertexWithoutMargin" 'function)) :void
  (self :pointer)
  (vectors :pointer)
  (supportVerticesOut :pointer)
  (numVectors :int))

(cl:export '#.(bullet-wrap::swig-lispify "btBoxShape_batchedUnitVectorGetSupportingVertexWithoutMargin" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "new_btBoxShape" 'function)))

(cffi:defcfun ("_wrap_new_btBoxShape" #.(bullet-wrap::swig-lispify "new_btBoxShape" 'function)) :pointer
  (boxHalfExtents :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "new_btBoxShape" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btBoxShape_setMargin" 'function)))

(cffi:defcfun ("_wrap_btBoxShape_setMargin" #.(bullet-wrap::swig-lispify "btBoxShape_setMargin" 'function)) :void
  (self :pointer)
  (collisionMargin :float))

(cl:export '#.(bullet-wrap::swig-lispify "btBoxShape_setMargin" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btBoxShape_setLocalScaling" 'function)))

(cffi:defcfun ("_wrap_btBoxShape_setLocalScaling" #.(bullet-wrap::swig-lispify "btBoxShape_setLocalScaling" 'function)) :void
  (self :pointer)
  (scaling :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btBoxShape_setLocalScaling" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btBoxShape_getAabb" 'function)))

(cffi:defcfun ("_wrap_btBoxShape_getAabb" #.(bullet-wrap::swig-lispify "btBoxShape_getAabb" 'function)) :void
  (self :pointer)
  (t_arg1 :pointer)
  (aabbMin :pointer)
  (aabbMax :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btBoxShape_getAabb" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btBoxShape_calculateLocalInertia" 'function)))

(cffi:defcfun ("_wrap_btBoxShape_calculateLocalInertia" #.(bullet-wrap::swig-lispify "btBoxShape_calculateLocalInertia" 'function)) :void
  (self :pointer)
  (mass :float)
  (inertia :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btBoxShape_calculateLocalInertia" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btBoxShape_getPlane" 'function)))

(cffi:defcfun ("_wrap_btBoxShape_getPlane" #.(bullet-wrap::swig-lispify "btBoxShape_getPlane" 'function)) :void
  (self :pointer)
  (planeNormal :pointer)
  (planeSupport :pointer)
  (i :int))

(cl:export '#.(bullet-wrap::swig-lispify "btBoxShape_getPlane" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btBoxShape_getNumPlanes" 'function)))

(cffi:defcfun ("_wrap_btBoxShape_getNumPlanes" #.(bullet-wrap::swig-lispify "btBoxShape_getNumPlanes" 'function)) :int
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btBoxShape_getNumPlanes" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btBoxShape_getNumVertices" 'function)))

(cffi:defcfun ("_wrap_btBoxShape_getNumVertices" #.(bullet-wrap::swig-lispify "btBoxShape_getNumVertices" 'function)) :int
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btBoxShape_getNumVertices" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btBoxShape_getNumEdges" 'function)))

(cffi:defcfun ("_wrap_btBoxShape_getNumEdges" #.(bullet-wrap::swig-lispify "btBoxShape_getNumEdges" 'function)) :int
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btBoxShape_getNumEdges" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btBoxShape_getVertex" 'function)))

(cffi:defcfun ("_wrap_btBoxShape_getVertex" #.(bullet-wrap::swig-lispify "btBoxShape_getVertex" 'function)) :void
  (self :pointer)
  (i :int)
  (vtx :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btBoxShape_getVertex" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btBoxShape_getPlaneEquation" 'function)))

(cffi:defcfun ("_wrap_btBoxShape_getPlaneEquation" #.(bullet-wrap::swig-lispify "btBoxShape_getPlaneEquation" 'function)) :void
  (self :pointer)
  (plane :pointer)
  (i :int))

(cl:export '#.(bullet-wrap::swig-lispify "btBoxShape_getPlaneEquation" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btBoxShape_getEdge" 'function)))

(cffi:defcfun ("_wrap_btBoxShape_getEdge" #.(bullet-wrap::swig-lispify "btBoxShape_getEdge" 'function)) :void
  (self :pointer)
  (i :int)
  (pa :pointer)
  (pb :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btBoxShape_getEdge" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btBoxShape_isInside" 'function)))

(cffi:defcfun ("_wrap_btBoxShape_isInside" #.(bullet-wrap::swig-lispify "btBoxShape_isInside" 'function)) :pointer
  (self :pointer)
  (pt :pointer)
  (tolerance :float))

(cl:export '#.(bullet-wrap::swig-lispify "btBoxShape_isInside" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btBoxShape_getName" 'function)))

(cffi:defcfun ("_wrap_btBoxShape_getName" #.(bullet-wrap::swig-lispify "btBoxShape_getName" 'function)) :string
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btBoxShape_getName" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btBoxShape_getNumPreferredPenetrationDirections" 'function)))

(cffi:defcfun ("_wrap_btBoxShape_getNumPreferredPenetrationDirections" #.(bullet-wrap::swig-lispify "btBoxShape_getNumPreferredPenetrationDirections" 'function)) :int
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btBoxShape_getNumPreferredPenetrationDirections" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btBoxShape_getPreferredPenetrationDirection" 'function)))

(cffi:defcfun ("_wrap_btBoxShape_getPreferredPenetrationDirection" #.(bullet-wrap::swig-lispify "btBoxShape_getPreferredPenetrationDirection" 'function)) :void
  (self :pointer)
  (index :int)
  (penetrationVector :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btBoxShape_getPreferredPenetrationDirection" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "delete_btBoxShape" 'function)))

(cffi:defcfun ("_wrap_delete_btBoxShape" #.(bullet-wrap::swig-lispify "delete_btBoxShape" 'function)) :void
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "delete_btBoxShape" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btSphereShape_makeCPlusPlusInstance" 'function)))

(cffi:defcfun ("_wrap_btSphereShape_makeCPlusPlusInstance__SWIG_0" #.(bullet-wrap::swig-lispify "btSphereShape_makeCPlusPlusInstance" 'function)) :pointer
  (self :pointer)
  (sizeInBytes :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btSphereShape_makeCPlusPlusInstance" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btSphereShape_deleteCPlusPlusInstance" 'function)))

(cffi:defcfun ("_wrap_btSphereShape_deleteCPlusPlusInstance__SWIG_0" #.(bullet-wrap::swig-lispify "btSphereShape_deleteCPlusPlusInstance" 'function)) :void
  (self :pointer)
  (ptr :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btSphereShape_deleteCPlusPlusInstance" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btSphereShape_makeCPlusPlusInstance" 'function)))

(cffi:defcfun ("_wrap_btSphereShape_makeCPlusPlusInstance__SWIG_1" #.(bullet-wrap::swig-lispify "btSphereShape_makeCPlusPlusInstance" 'function)) :pointer
  (self :pointer)
  (arg1 :pointer)
  (ptr :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btSphereShape_makeCPlusPlusInstance" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btSphereShape_deleteCPlusPlusInstance" 'function)))

(cffi:defcfun ("_wrap_btSphereShape_deleteCPlusPlusInstance__SWIG_1" #.(bullet-wrap::swig-lispify "btSphereShape_deleteCPlusPlusInstance" 'function)) :void
  (self :pointer)
  (arg1 :pointer)
  (arg2 :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btSphereShape_deleteCPlusPlusInstance" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btSphereShape_makeCPlusArray" 'function)))

(cffi:defcfun ("_wrap_btSphereShape_makeCPlusArray__SWIG_0" #.(bullet-wrap::swig-lispify "btSphereShape_makeCPlusArray" 'function)) :pointer
  (self :pointer)
  (sizeInBytes :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btSphereShape_makeCPlusArray" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btSphereShape_deleteCPlusArray" 'function)))

(cffi:defcfun ("_wrap_btSphereShape_deleteCPlusArray__SWIG_0" #.(bullet-wrap::swig-lispify "btSphereShape_deleteCPlusArray" 'function)) :void
  (self :pointer)
  (ptr :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btSphereShape_deleteCPlusArray" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btSphereShape_makeCPlusArray" 'function)))

(cffi:defcfun ("_wrap_btSphereShape_makeCPlusArray__SWIG_1" #.(bullet-wrap::swig-lispify "btSphereShape_makeCPlusArray" 'function)) :pointer
  (self :pointer)
  (arg1 :pointer)
  (ptr :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btSphereShape_makeCPlusArray" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btSphereShape_deleteCPlusArray" 'function)))

(cffi:defcfun ("_wrap_btSphereShape_deleteCPlusArray__SWIG_1" #.(bullet-wrap::swig-lispify "btSphereShape_deleteCPlusArray" 'function)) :void
  (self :pointer)
  (arg1 :pointer)
  (arg2 :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btSphereShape_deleteCPlusArray" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "new_btSphereShape" 'function)))

(cffi:defcfun ("_wrap_new_btSphereShape" #.(bullet-wrap::swig-lispify "new_btSphereShape" 'function)) :pointer
  (radius :float))

(cl:export '#.(bullet-wrap::swig-lispify "new_btSphereShape" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btSphereShape_localGetSupportingVertex" 'function)))

(cffi:defcfun ("_wrap_btSphereShape_localGetSupportingVertex" #.(bullet-wrap::swig-lispify "btSphereShape_localGetSupportingVertex" 'function)) :pointer
  (self :pointer)
  (vec :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btSphereShape_localGetSupportingVertex" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btSphereShape_localGetSupportingVertexWithoutMargin" 'function)))

(cffi:defcfun ("_wrap_btSphereShape_localGetSupportingVertexWithoutMargin" #.(bullet-wrap::swig-lispify "btSphereShape_localGetSupportingVertexWithoutMargin" 'function)) :pointer
  (self :pointer)
  (vec :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btSphereShape_localGetSupportingVertexWithoutMargin" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btSphereShape_batchedUnitVectorGetSupportingVertexWithoutMargin" 'function)))

(cffi:defcfun ("_wrap_btSphereShape_batchedUnitVectorGetSupportingVertexWithoutMargin" #.(bullet-wrap::swig-lispify "btSphereShape_batchedUnitVectorGetSupportingVertexWithoutMargin" 'function)) :void
  (self :pointer)
  (vectors :pointer)
  (supportVerticesOut :pointer)
  (numVectors :int))

(cl:export '#.(bullet-wrap::swig-lispify "btSphereShape_batchedUnitVectorGetSupportingVertexWithoutMargin" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btSphereShape_calculateLocalInertia" 'function)))

(cffi:defcfun ("_wrap_btSphereShape_calculateLocalInertia" #.(bullet-wrap::swig-lispify "btSphereShape_calculateLocalInertia" 'function)) :void
  (self :pointer)
  (mass :float)
  (inertia :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btSphereShape_calculateLocalInertia" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btSphereShape_getAabb" 'function)))

(cffi:defcfun ("_wrap_btSphereShape_getAabb" #.(bullet-wrap::swig-lispify "btSphereShape_getAabb" 'function)) :void
  (self :pointer)
  (t_arg1 :pointer)
  (aabbMin :pointer)
  (aabbMax :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btSphereShape_getAabb" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btSphereShape_getRadius" 'function)))

(cffi:defcfun ("_wrap_btSphereShape_getRadius" #.(bullet-wrap::swig-lispify "btSphereShape_getRadius" 'function)) :float
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btSphereShape_getRadius" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btSphereShape_setUnscaledRadius" 'function)))

(cffi:defcfun ("_wrap_btSphereShape_setUnscaledRadius" #.(bullet-wrap::swig-lispify "btSphereShape_setUnscaledRadius" 'function)) :void
  (self :pointer)
  (radius :float))

(cl:export '#.(bullet-wrap::swig-lispify "btSphereShape_setUnscaledRadius" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btSphereShape_getName" 'function)))

(cffi:defcfun ("_wrap_btSphereShape_getName" #.(bullet-wrap::swig-lispify "btSphereShape_getName" 'function)) :string
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btSphereShape_getName" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btSphereShape_setMargin" 'function)))

(cffi:defcfun ("_wrap_btSphereShape_setMargin" #.(bullet-wrap::swig-lispify "btSphereShape_setMargin" 'function)) :void
  (self :pointer)
  (margin :float))

(cl:export '#.(bullet-wrap::swig-lispify "btSphereShape_setMargin" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btSphereShape_getMargin" 'function)))

(cffi:defcfun ("_wrap_btSphereShape_getMargin" #.(bullet-wrap::swig-lispify "btSphereShape_getMargin" 'function)) :float
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btSphereShape_getMargin" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "delete_btSphereShape" 'function)))

(cffi:defcfun ("_wrap_delete_btSphereShape" #.(bullet-wrap::swig-lispify "delete_btSphereShape" 'function)) :void
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "delete_btSphereShape" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCapsuleShape_makeCPlusPlusInstance" 'function)))

(cffi:defcfun ("_wrap_btCapsuleShape_makeCPlusPlusInstance__SWIG_0" #.(bullet-wrap::swig-lispify "btCapsuleShape_makeCPlusPlusInstance" 'function)) :pointer
  (self :pointer)
  (sizeInBytes :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btCapsuleShape_makeCPlusPlusInstance" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCapsuleShape_deleteCPlusPlusInstance" 'function)))

(cffi:defcfun ("_wrap_btCapsuleShape_deleteCPlusPlusInstance__SWIG_0" #.(bullet-wrap::swig-lispify "btCapsuleShape_deleteCPlusPlusInstance" 'function)) :void
  (self :pointer)
  (ptr :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btCapsuleShape_deleteCPlusPlusInstance" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCapsuleShape_makeCPlusPlusInstance" 'function)))

(cffi:defcfun ("_wrap_btCapsuleShape_makeCPlusPlusInstance__SWIG_1" #.(bullet-wrap::swig-lispify "btCapsuleShape_makeCPlusPlusInstance" 'function)) :pointer
  (self :pointer)
  (arg1 :pointer)
  (ptr :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btCapsuleShape_makeCPlusPlusInstance" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCapsuleShape_deleteCPlusPlusInstance" 'function)))

(cffi:defcfun ("_wrap_btCapsuleShape_deleteCPlusPlusInstance__SWIG_1" #.(bullet-wrap::swig-lispify "btCapsuleShape_deleteCPlusPlusInstance" 'function)) :void
  (self :pointer)
  (arg1 :pointer)
  (arg2 :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btCapsuleShape_deleteCPlusPlusInstance" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCapsuleShape_makeCPlusArray" 'function)))

(cffi:defcfun ("_wrap_btCapsuleShape_makeCPlusArray__SWIG_0" #.(bullet-wrap::swig-lispify "btCapsuleShape_makeCPlusArray" 'function)) :pointer
  (self :pointer)
  (sizeInBytes :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btCapsuleShape_makeCPlusArray" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCapsuleShape_deleteCPlusArray" 'function)))

(cffi:defcfun ("_wrap_btCapsuleShape_deleteCPlusArray__SWIG_0" #.(bullet-wrap::swig-lispify "btCapsuleShape_deleteCPlusArray" 'function)) :void
  (self :pointer)
  (ptr :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btCapsuleShape_deleteCPlusArray" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCapsuleShape_makeCPlusArray" 'function)))

(cffi:defcfun ("_wrap_btCapsuleShape_makeCPlusArray__SWIG_1" #.(bullet-wrap::swig-lispify "btCapsuleShape_makeCPlusArray" 'function)) :pointer
  (self :pointer)
  (arg1 :pointer)
  (ptr :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btCapsuleShape_makeCPlusArray" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCapsuleShape_deleteCPlusArray" 'function)))

(cffi:defcfun ("_wrap_btCapsuleShape_deleteCPlusArray__SWIG_1" #.(bullet-wrap::swig-lispify "btCapsuleShape_deleteCPlusArray" 'function)) :void
  (self :pointer)
  (arg1 :pointer)
  (arg2 :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btCapsuleShape_deleteCPlusArray" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "new_btCapsuleShape" 'function)))

(cffi:defcfun ("_wrap_new_btCapsuleShape__SWIG_1" #.(bullet-wrap::swig-lispify "new_btCapsuleShape" 'function)) :pointer
  (radius :float)
  (height :float))

(cl:export '#.(bullet-wrap::swig-lispify "new_btCapsuleShape" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCapsuleShape_calculateLocalInertia" 'function)))

(cffi:defcfun ("_wrap_btCapsuleShape_calculateLocalInertia" #.(bullet-wrap::swig-lispify "btCapsuleShape_calculateLocalInertia" 'function)) :void
  (self :pointer)
  (mass :float)
  (inertia :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btCapsuleShape_calculateLocalInertia" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCapsuleShape_localGetSupportingVertexWithoutMargin" 'function)))

(cffi:defcfun ("_wrap_btCapsuleShape_localGetSupportingVertexWithoutMargin" #.(bullet-wrap::swig-lispify "btCapsuleShape_localGetSupportingVertexWithoutMargin" 'function)) :pointer
  (self :pointer)
  (vec :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btCapsuleShape_localGetSupportingVertexWithoutMargin" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCapsuleShape_batchedUnitVectorGetSupportingVertexWithoutMargin" 'function)))

(cffi:defcfun ("_wrap_btCapsuleShape_batchedUnitVectorGetSupportingVertexWithoutMargin" #.(bullet-wrap::swig-lispify "btCapsuleShape_batchedUnitVectorGetSupportingVertexWithoutMargin" 'function)) :void
  (self :pointer)
  (vectors :pointer)
  (supportVerticesOut :pointer)
  (numVectors :int))

(cl:export '#.(bullet-wrap::swig-lispify "btCapsuleShape_batchedUnitVectorGetSupportingVertexWithoutMargin" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCapsuleShape_setMargin" 'function)))

(cffi:defcfun ("_wrap_btCapsuleShape_setMargin" #.(bullet-wrap::swig-lispify "btCapsuleShape_setMargin" 'function)) :void
  (self :pointer)
  (collisionMargin :float))

(cl:export '#.(bullet-wrap::swig-lispify "btCapsuleShape_setMargin" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCapsuleShape_getAabb" 'function)))

(cffi:defcfun ("_wrap_btCapsuleShape_getAabb" #.(bullet-wrap::swig-lispify "btCapsuleShape_getAabb" 'function)) :void
  (self :pointer)
  (t_arg1 :pointer)
  (aabbMin :pointer)
  (aabbMax :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btCapsuleShape_getAabb" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCapsuleShape_getName" 'function)))

(cffi:defcfun ("_wrap_btCapsuleShape_getName" #.(bullet-wrap::swig-lispify "btCapsuleShape_getName" 'function)) :string
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btCapsuleShape_getName" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCapsuleShape_getUpAxis" 'function)))

(cffi:defcfun ("_wrap_btCapsuleShape_getUpAxis" #.(bullet-wrap::swig-lispify "btCapsuleShape_getUpAxis" 'function)) :int
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btCapsuleShape_getUpAxis" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCapsuleShape_getRadius" 'function)))

(cffi:defcfun ("_wrap_btCapsuleShape_getRadius" #.(bullet-wrap::swig-lispify "btCapsuleShape_getRadius" 'function)) :float
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btCapsuleShape_getRadius" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCapsuleShape_getHalfHeight" 'function)))

(cffi:defcfun ("_wrap_btCapsuleShape_getHalfHeight" #.(bullet-wrap::swig-lispify "btCapsuleShape_getHalfHeight" 'function)) :float
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btCapsuleShape_getHalfHeight" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCapsuleShape_setLocalScaling" 'function)))

(cffi:defcfun ("_wrap_btCapsuleShape_setLocalScaling" #.(bullet-wrap::swig-lispify "btCapsuleShape_setLocalScaling" 'function)) :void
  (self :pointer)
  (scaling :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btCapsuleShape_setLocalScaling" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCapsuleShape_getAnisotropicRollingFrictionDirection" 'function)))

(cffi:defcfun ("_wrap_btCapsuleShape_getAnisotropicRollingFrictionDirection" #.(bullet-wrap::swig-lispify "btCapsuleShape_getAnisotropicRollingFrictionDirection" 'function)) :pointer
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btCapsuleShape_getAnisotropicRollingFrictionDirection" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCapsuleShape_calculateSerializeBufferSize" 'function)))

(cffi:defcfun ("_wrap_btCapsuleShape_calculateSerializeBufferSize" #.(bullet-wrap::swig-lispify "btCapsuleShape_calculateSerializeBufferSize" 'function)) :int
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btCapsuleShape_calculateSerializeBufferSize" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCapsuleShape_serialize" 'function)))

(cffi:defcfun ("_wrap_btCapsuleShape_serialize" #.(bullet-wrap::swig-lispify "btCapsuleShape_serialize" 'function)) :string
  (self :pointer)
  (dataBuffer :pointer)
  (serializer :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btCapsuleShape_serialize" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "delete_btCapsuleShape" 'function)))

(cffi:defcfun ("_wrap_delete_btCapsuleShape" #.(bullet-wrap::swig-lispify "delete_btCapsuleShape" 'function)) :void
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "delete_btCapsuleShape" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "new_btCapsuleShapeX" 'function)))

(cffi:defcfun ("_wrap_new_btCapsuleShapeX" #.(bullet-wrap::swig-lispify "new_btCapsuleShapeX" 'function)) :pointer
  (radius :float)
  (height :float))

(cl:export '#.(bullet-wrap::swig-lispify "new_btCapsuleShapeX" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCapsuleShapeX_getName" 'function)))

(cffi:defcfun ("_wrap_btCapsuleShapeX_getName" #.(bullet-wrap::swig-lispify "btCapsuleShapeX_getName" 'function)) :string
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btCapsuleShapeX_getName" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "delete_btCapsuleShapeX" 'function)))

(cffi:defcfun ("_wrap_delete_btCapsuleShapeX" #.(bullet-wrap::swig-lispify "delete_btCapsuleShapeX" 'function)) :void
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "delete_btCapsuleShapeX" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "new_btCapsuleShapeZ" 'function)))

(cffi:defcfun ("_wrap_new_btCapsuleShapeZ" #.(bullet-wrap::swig-lispify "new_btCapsuleShapeZ" 'function)) :pointer
  (radius :float)
  (height :float))

(cl:export '#.(bullet-wrap::swig-lispify "new_btCapsuleShapeZ" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCapsuleShapeZ_getName" 'function)))

(cffi:defcfun ("_wrap_btCapsuleShapeZ_getName" #.(bullet-wrap::swig-lispify "btCapsuleShapeZ_getName" 'function)) :string
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btCapsuleShapeZ_getName" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "delete_btCapsuleShapeZ" 'function)))

(cffi:defcfun ("_wrap_delete_btCapsuleShapeZ" #.(bullet-wrap::swig-lispify "delete_btCapsuleShapeZ" 'function)) :void
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "delete_btCapsuleShapeZ" 'function))

(cffi:defcstruct #.(bullet-wrap::swig-lispify "btCapsuleShapeData" 'classname)
	(#.(bullet-wrap::swig-lispify "m_convexInternalShapeData" 'slotname) :pointer)
	(#.(bullet-wrap::swig-lispify "m_upAxis" 'slotname) :int)
	(#.(bullet-wrap::swig-lispify "m_padding" 'slotname) :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btCapsuleShapeData" 'classname))

(cl:export '#.(bullet-wrap::swig-lispify "m_convexInternalShapeData" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_upAxis" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_padding" 'slotname))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCylinderShape_makeCPlusPlusInstance" 'function)))

(cffi:defcfun ("_wrap_btCylinderShape_makeCPlusPlusInstance__SWIG_0" #.(bullet-wrap::swig-lispify "btCylinderShape_makeCPlusPlusInstance" 'function)) :pointer
  (self :pointer)
  (sizeInBytes :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btCylinderShape_makeCPlusPlusInstance" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCylinderShape_deleteCPlusPlusInstance" 'function)))

(cffi:defcfun ("_wrap_btCylinderShape_deleteCPlusPlusInstance__SWIG_0" #.(bullet-wrap::swig-lispify "btCylinderShape_deleteCPlusPlusInstance" 'function)) :void
  (self :pointer)
  (ptr :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btCylinderShape_deleteCPlusPlusInstance" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCylinderShape_makeCPlusPlusInstance" 'function)))

(cffi:defcfun ("_wrap_btCylinderShape_makeCPlusPlusInstance__SWIG_1" #.(bullet-wrap::swig-lispify "btCylinderShape_makeCPlusPlusInstance" 'function)) :pointer
  (self :pointer)
  (arg1 :pointer)
  (ptr :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btCylinderShape_makeCPlusPlusInstance" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCylinderShape_deleteCPlusPlusInstance" 'function)))

(cffi:defcfun ("_wrap_btCylinderShape_deleteCPlusPlusInstance__SWIG_1" #.(bullet-wrap::swig-lispify "btCylinderShape_deleteCPlusPlusInstance" 'function)) :void
  (self :pointer)
  (arg1 :pointer)
  (arg2 :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btCylinderShape_deleteCPlusPlusInstance" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCylinderShape_makeCPlusArray" 'function)))

(cffi:defcfun ("_wrap_btCylinderShape_makeCPlusArray__SWIG_0" #.(bullet-wrap::swig-lispify "btCylinderShape_makeCPlusArray" 'function)) :pointer
  (self :pointer)
  (sizeInBytes :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btCylinderShape_makeCPlusArray" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCylinderShape_deleteCPlusArray" 'function)))

(cffi:defcfun ("_wrap_btCylinderShape_deleteCPlusArray__SWIG_0" #.(bullet-wrap::swig-lispify "btCylinderShape_deleteCPlusArray" 'function)) :void
  (self :pointer)
  (ptr :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btCylinderShape_deleteCPlusArray" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCylinderShape_makeCPlusArray" 'function)))

(cffi:defcfun ("_wrap_btCylinderShape_makeCPlusArray__SWIG_1" #.(bullet-wrap::swig-lispify "btCylinderShape_makeCPlusArray" 'function)) :pointer
  (self :pointer)
  (arg1 :pointer)
  (ptr :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btCylinderShape_makeCPlusArray" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCylinderShape_deleteCPlusArray" 'function)))

(cffi:defcfun ("_wrap_btCylinderShape_deleteCPlusArray__SWIG_1" #.(bullet-wrap::swig-lispify "btCylinderShape_deleteCPlusArray" 'function)) :void
  (self :pointer)
  (arg1 :pointer)
  (arg2 :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btCylinderShape_deleteCPlusArray" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCylinderShape_getHalfExtentsWithMargin" 'function)))

(cffi:defcfun ("_wrap_btCylinderShape_getHalfExtentsWithMargin" #.(bullet-wrap::swig-lispify "btCylinderShape_getHalfExtentsWithMargin" 'function)) :pointer
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btCylinderShape_getHalfExtentsWithMargin" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCylinderShape_getHalfExtentsWithoutMargin" 'function)))

(cffi:defcfun ("_wrap_btCylinderShape_getHalfExtentsWithoutMargin" #.(bullet-wrap::swig-lispify "btCylinderShape_getHalfExtentsWithoutMargin" 'function)) :pointer
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btCylinderShape_getHalfExtentsWithoutMargin" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "new_btCylinderShape" 'function)))

(cffi:defcfun ("_wrap_new_btCylinderShape" #.(bullet-wrap::swig-lispify "new_btCylinderShape" 'function)) :pointer
  (halfExtents :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "new_btCylinderShape" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCylinderShape_getAabb" 'function)))

(cffi:defcfun ("_wrap_btCylinderShape_getAabb" #.(bullet-wrap::swig-lispify "btCylinderShape_getAabb" 'function)) :void
  (self :pointer)
  (t_arg1 :pointer)
  (aabbMin :pointer)
  (aabbMax :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btCylinderShape_getAabb" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCylinderShape_calculateLocalInertia" 'function)))

(cffi:defcfun ("_wrap_btCylinderShape_calculateLocalInertia" #.(bullet-wrap::swig-lispify "btCylinderShape_calculateLocalInertia" 'function)) :void
  (self :pointer)
  (mass :float)
  (inertia :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btCylinderShape_calculateLocalInertia" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCylinderShape_localGetSupportingVertexWithoutMargin" 'function)))

(cffi:defcfun ("_wrap_btCylinderShape_localGetSupportingVertexWithoutMargin" #.(bullet-wrap::swig-lispify "btCylinderShape_localGetSupportingVertexWithoutMargin" 'function)) :pointer
  (self :pointer)
  (vec :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btCylinderShape_localGetSupportingVertexWithoutMargin" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCylinderShape_batchedUnitVectorGetSupportingVertexWithoutMargin" 'function)))

(cffi:defcfun ("_wrap_btCylinderShape_batchedUnitVectorGetSupportingVertexWithoutMargin" #.(bullet-wrap::swig-lispify "btCylinderShape_batchedUnitVectorGetSupportingVertexWithoutMargin" 'function)) :void
  (self :pointer)
  (vectors :pointer)
  (supportVerticesOut :pointer)
  (numVectors :int))

(cl:export '#.(bullet-wrap::swig-lispify "btCylinderShape_batchedUnitVectorGetSupportingVertexWithoutMargin" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCylinderShape_setMargin" 'function)))

(cffi:defcfun ("_wrap_btCylinderShape_setMargin" #.(bullet-wrap::swig-lispify "btCylinderShape_setMargin" 'function)) :void
  (self :pointer)
  (collisionMargin :float))

(cl:export '#.(bullet-wrap::swig-lispify "btCylinderShape_setMargin" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCylinderShape_localGetSupportingVertex" 'function)))

(cffi:defcfun ("_wrap_btCylinderShape_localGetSupportingVertex" #.(bullet-wrap::swig-lispify "btCylinderShape_localGetSupportingVertex" 'function)) :pointer
  (self :pointer)
  (vec :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btCylinderShape_localGetSupportingVertex" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCylinderShape_getUpAxis" 'function)))

(cffi:defcfun ("_wrap_btCylinderShape_getUpAxis" #.(bullet-wrap::swig-lispify "btCylinderShape_getUpAxis" 'function)) :int
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btCylinderShape_getUpAxis" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCylinderShape_getAnisotropicRollingFrictionDirection" 'function)))

(cffi:defcfun ("_wrap_btCylinderShape_getAnisotropicRollingFrictionDirection" #.(bullet-wrap::swig-lispify "btCylinderShape_getAnisotropicRollingFrictionDirection" 'function)) :pointer
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btCylinderShape_getAnisotropicRollingFrictionDirection" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCylinderShape_getRadius" 'function)))

(cffi:defcfun ("_wrap_btCylinderShape_getRadius" #.(bullet-wrap::swig-lispify "btCylinderShape_getRadius" 'function)) :float
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btCylinderShape_getRadius" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCylinderShape_setLocalScaling" 'function)))

(cffi:defcfun ("_wrap_btCylinderShape_setLocalScaling" #.(bullet-wrap::swig-lispify "btCylinderShape_setLocalScaling" 'function)) :void
  (self :pointer)
  (scaling :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btCylinderShape_setLocalScaling" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCylinderShape_getName" 'function)))

(cffi:defcfun ("_wrap_btCylinderShape_getName" #.(bullet-wrap::swig-lispify "btCylinderShape_getName" 'function)) :string
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btCylinderShape_getName" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCylinderShape_calculateSerializeBufferSize" 'function)))

(cffi:defcfun ("_wrap_btCylinderShape_calculateSerializeBufferSize" #.(bullet-wrap::swig-lispify "btCylinderShape_calculateSerializeBufferSize" 'function)) :int
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btCylinderShape_calculateSerializeBufferSize" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCylinderShape_serialize" 'function)))

(cffi:defcfun ("_wrap_btCylinderShape_serialize" #.(bullet-wrap::swig-lispify "btCylinderShape_serialize" 'function)) :string
  (self :pointer)
  (dataBuffer :pointer)
  (serializer :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btCylinderShape_serialize" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "delete_btCylinderShape" 'function)))

(cffi:defcfun ("_wrap_delete_btCylinderShape" #.(bullet-wrap::swig-lispify "delete_btCylinderShape" 'function)) :void
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "delete_btCylinderShape" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCylinderShapeX_makeCPlusPlusInstance" 'function)))

(cffi:defcfun ("_wrap_btCylinderShapeX_makeCPlusPlusInstance__SWIG_0" #.(bullet-wrap::swig-lispify "btCylinderShapeX_makeCPlusPlusInstance" 'function)) :pointer
  (self :pointer)
  (sizeInBytes :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btCylinderShapeX_makeCPlusPlusInstance" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCylinderShapeX_deleteCPlusPlusInstance" 'function)))

(cffi:defcfun ("_wrap_btCylinderShapeX_deleteCPlusPlusInstance__SWIG_0" #.(bullet-wrap::swig-lispify "btCylinderShapeX_deleteCPlusPlusInstance" 'function)) :void
  (self :pointer)
  (ptr :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btCylinderShapeX_deleteCPlusPlusInstance" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCylinderShapeX_makeCPlusPlusInstance" 'function)))

(cffi:defcfun ("_wrap_btCylinderShapeX_makeCPlusPlusInstance__SWIG_1" #.(bullet-wrap::swig-lispify "btCylinderShapeX_makeCPlusPlusInstance" 'function)) :pointer
  (self :pointer)
  (arg1 :pointer)
  (ptr :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btCylinderShapeX_makeCPlusPlusInstance" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCylinderShapeX_deleteCPlusPlusInstance" 'function)))

(cffi:defcfun ("_wrap_btCylinderShapeX_deleteCPlusPlusInstance__SWIG_1" #.(bullet-wrap::swig-lispify "btCylinderShapeX_deleteCPlusPlusInstance" 'function)) :void
  (self :pointer)
  (arg1 :pointer)
  (arg2 :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btCylinderShapeX_deleteCPlusPlusInstance" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCylinderShapeX_makeCPlusArray" 'function)))

(cffi:defcfun ("_wrap_btCylinderShapeX_makeCPlusArray__SWIG_0" #.(bullet-wrap::swig-lispify "btCylinderShapeX_makeCPlusArray" 'function)) :pointer
  (self :pointer)
  (sizeInBytes :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btCylinderShapeX_makeCPlusArray" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCylinderShapeX_deleteCPlusArray" 'function)))

(cffi:defcfun ("_wrap_btCylinderShapeX_deleteCPlusArray__SWIG_0" #.(bullet-wrap::swig-lispify "btCylinderShapeX_deleteCPlusArray" 'function)) :void
  (self :pointer)
  (ptr :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btCylinderShapeX_deleteCPlusArray" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCylinderShapeX_makeCPlusArray" 'function)))

(cffi:defcfun ("_wrap_btCylinderShapeX_makeCPlusArray__SWIG_1" #.(bullet-wrap::swig-lispify "btCylinderShapeX_makeCPlusArray" 'function)) :pointer
  (self :pointer)
  (arg1 :pointer)
  (ptr :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btCylinderShapeX_makeCPlusArray" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCylinderShapeX_deleteCPlusArray" 'function)))

(cffi:defcfun ("_wrap_btCylinderShapeX_deleteCPlusArray__SWIG_1" #.(bullet-wrap::swig-lispify "btCylinderShapeX_deleteCPlusArray" 'function)) :void
  (self :pointer)
  (arg1 :pointer)
  (arg2 :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btCylinderShapeX_deleteCPlusArray" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "new_btCylinderShapeX" 'function)))

(cffi:defcfun ("_wrap_new_btCylinderShapeX" #.(bullet-wrap::swig-lispify "new_btCylinderShapeX" 'function)) :pointer
  (halfExtents :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "new_btCylinderShapeX" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCylinderShapeX_localGetSupportingVertexWithoutMargin" 'function)))

(cffi:defcfun ("_wrap_btCylinderShapeX_localGetSupportingVertexWithoutMargin" #.(bullet-wrap::swig-lispify "btCylinderShapeX_localGetSupportingVertexWithoutMargin" 'function)) :pointer
  (self :pointer)
  (vec :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btCylinderShapeX_localGetSupportingVertexWithoutMargin" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCylinderShapeX_batchedUnitVectorGetSupportingVertexWithoutMargin" 'function)))

(cffi:defcfun ("_wrap_btCylinderShapeX_batchedUnitVectorGetSupportingVertexWithoutMargin" #.(bullet-wrap::swig-lispify "btCylinderShapeX_batchedUnitVectorGetSupportingVertexWithoutMargin" 'function)) :void
  (self :pointer)
  (vectors :pointer)
  (supportVerticesOut :pointer)
  (numVectors :int))

(cl:export '#.(bullet-wrap::swig-lispify "btCylinderShapeX_batchedUnitVectorGetSupportingVertexWithoutMargin" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCylinderShapeX_getName" 'function)))

(cffi:defcfun ("_wrap_btCylinderShapeX_getName" #.(bullet-wrap::swig-lispify "btCylinderShapeX_getName" 'function)) :string
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btCylinderShapeX_getName" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCylinderShapeX_getRadius" 'function)))

(cffi:defcfun ("_wrap_btCylinderShapeX_getRadius" #.(bullet-wrap::swig-lispify "btCylinderShapeX_getRadius" 'function)) :float
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btCylinderShapeX_getRadius" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "delete_btCylinderShapeX" 'function)))

(cffi:defcfun ("_wrap_delete_btCylinderShapeX" #.(bullet-wrap::swig-lispify "delete_btCylinderShapeX" 'function)) :void
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "delete_btCylinderShapeX" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCylinderShapeZ_makeCPlusPlusInstance" 'function)))

(cffi:defcfun ("_wrap_btCylinderShapeZ_makeCPlusPlusInstance__SWIG_0" #.(bullet-wrap::swig-lispify "btCylinderShapeZ_makeCPlusPlusInstance" 'function)) :pointer
  (self :pointer)
  (sizeInBytes :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btCylinderShapeZ_makeCPlusPlusInstance" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCylinderShapeZ_deleteCPlusPlusInstance" 'function)))

(cffi:defcfun ("_wrap_btCylinderShapeZ_deleteCPlusPlusInstance__SWIG_0" #.(bullet-wrap::swig-lispify "btCylinderShapeZ_deleteCPlusPlusInstance" 'function)) :void
  (self :pointer)
  (ptr :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btCylinderShapeZ_deleteCPlusPlusInstance" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCylinderShapeZ_makeCPlusPlusInstance" 'function)))

(cffi:defcfun ("_wrap_btCylinderShapeZ_makeCPlusPlusInstance__SWIG_1" #.(bullet-wrap::swig-lispify "btCylinderShapeZ_makeCPlusPlusInstance" 'function)) :pointer
  (self :pointer)
  (arg1 :pointer)
  (ptr :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btCylinderShapeZ_makeCPlusPlusInstance" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCylinderShapeZ_deleteCPlusPlusInstance" 'function)))

(cffi:defcfun ("_wrap_btCylinderShapeZ_deleteCPlusPlusInstance__SWIG_1" #.(bullet-wrap::swig-lispify "btCylinderShapeZ_deleteCPlusPlusInstance" 'function)) :void
  (self :pointer)
  (arg1 :pointer)
  (arg2 :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btCylinderShapeZ_deleteCPlusPlusInstance" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCylinderShapeZ_makeCPlusArray" 'function)))

(cffi:defcfun ("_wrap_btCylinderShapeZ_makeCPlusArray__SWIG_0" #.(bullet-wrap::swig-lispify "btCylinderShapeZ_makeCPlusArray" 'function)) :pointer
  (self :pointer)
  (sizeInBytes :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btCylinderShapeZ_makeCPlusArray" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCylinderShapeZ_deleteCPlusArray" 'function)))

(cffi:defcfun ("_wrap_btCylinderShapeZ_deleteCPlusArray__SWIG_0" #.(bullet-wrap::swig-lispify "btCylinderShapeZ_deleteCPlusArray" 'function)) :void
  (self :pointer)
  (ptr :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btCylinderShapeZ_deleteCPlusArray" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCylinderShapeZ_makeCPlusArray" 'function)))

(cffi:defcfun ("_wrap_btCylinderShapeZ_makeCPlusArray__SWIG_1" #.(bullet-wrap::swig-lispify "btCylinderShapeZ_makeCPlusArray" 'function)) :pointer
  (self :pointer)
  (arg1 :pointer)
  (ptr :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btCylinderShapeZ_makeCPlusArray" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCylinderShapeZ_deleteCPlusArray" 'function)))

(cffi:defcfun ("_wrap_btCylinderShapeZ_deleteCPlusArray__SWIG_1" #.(bullet-wrap::swig-lispify "btCylinderShapeZ_deleteCPlusArray" 'function)) :void
  (self :pointer)
  (arg1 :pointer)
  (arg2 :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btCylinderShapeZ_deleteCPlusArray" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "new_btCylinderShapeZ" 'function)))

(cffi:defcfun ("_wrap_new_btCylinderShapeZ" #.(bullet-wrap::swig-lispify "new_btCylinderShapeZ" 'function)) :pointer
  (halfExtents :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "new_btCylinderShapeZ" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCylinderShapeZ_localGetSupportingVertexWithoutMargin" 'function)))

(cffi:defcfun ("_wrap_btCylinderShapeZ_localGetSupportingVertexWithoutMargin" #.(bullet-wrap::swig-lispify "btCylinderShapeZ_localGetSupportingVertexWithoutMargin" 'function)) :pointer
  (self :pointer)
  (vec :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btCylinderShapeZ_localGetSupportingVertexWithoutMargin" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCylinderShapeZ_batchedUnitVectorGetSupportingVertexWithoutMargin" 'function)))

(cffi:defcfun ("_wrap_btCylinderShapeZ_batchedUnitVectorGetSupportingVertexWithoutMargin" #.(bullet-wrap::swig-lispify "btCylinderShapeZ_batchedUnitVectorGetSupportingVertexWithoutMargin" 'function)) :void
  (self :pointer)
  (vectors :pointer)
  (supportVerticesOut :pointer)
  (numVectors :int))

(cl:export '#.(bullet-wrap::swig-lispify "btCylinderShapeZ_batchedUnitVectorGetSupportingVertexWithoutMargin" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCylinderShapeZ_getName" 'function)))

(cffi:defcfun ("_wrap_btCylinderShapeZ_getName" #.(bullet-wrap::swig-lispify "btCylinderShapeZ_getName" 'function)) :string
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btCylinderShapeZ_getName" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCylinderShapeZ_getRadius" 'function)))

(cffi:defcfun ("_wrap_btCylinderShapeZ_getRadius" #.(bullet-wrap::swig-lispify "btCylinderShapeZ_getRadius" 'function)) :float
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btCylinderShapeZ_getRadius" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "delete_btCylinderShapeZ" 'function)))

(cffi:defcfun ("_wrap_delete_btCylinderShapeZ" #.(bullet-wrap::swig-lispify "delete_btCylinderShapeZ" 'function)) :void
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "delete_btCylinderShapeZ" 'function))

(cffi:defcstruct #.(bullet-wrap::swig-lispify "btCylinderShapeData" 'classname)
	(#.(bullet-wrap::swig-lispify "m_convexInternalShapeData" 'slotname) :pointer)
	(#.(bullet-wrap::swig-lispify "m_upAxis" 'slotname) :int)
	(#.(bullet-wrap::swig-lispify "m_padding" 'slotname) :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btCylinderShapeData" 'classname))

(cl:export '#.(bullet-wrap::swig-lispify "m_convexInternalShapeData" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_upAxis" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_padding" 'slotname))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btConeShape_makeCPlusPlusInstance" 'function)))

(cffi:defcfun ("_wrap_btConeShape_makeCPlusPlusInstance__SWIG_0" #.(bullet-wrap::swig-lispify "btConeShape_makeCPlusPlusInstance" 'function)) :pointer
  (self :pointer)
  (sizeInBytes :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btConeShape_makeCPlusPlusInstance" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btConeShape_deleteCPlusPlusInstance" 'function)))

(cffi:defcfun ("_wrap_btConeShape_deleteCPlusPlusInstance__SWIG_0" #.(bullet-wrap::swig-lispify "btConeShape_deleteCPlusPlusInstance" 'function)) :void
  (self :pointer)
  (ptr :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btConeShape_deleteCPlusPlusInstance" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btConeShape_makeCPlusPlusInstance" 'function)))

(cffi:defcfun ("_wrap_btConeShape_makeCPlusPlusInstance__SWIG_1" #.(bullet-wrap::swig-lispify "btConeShape_makeCPlusPlusInstance" 'function)) :pointer
  (self :pointer)
  (arg1 :pointer)
  (ptr :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btConeShape_makeCPlusPlusInstance" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btConeShape_deleteCPlusPlusInstance" 'function)))

(cffi:defcfun ("_wrap_btConeShape_deleteCPlusPlusInstance__SWIG_1" #.(bullet-wrap::swig-lispify "btConeShape_deleteCPlusPlusInstance" 'function)) :void
  (self :pointer)
  (arg1 :pointer)
  (arg2 :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btConeShape_deleteCPlusPlusInstance" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btConeShape_makeCPlusArray" 'function)))

(cffi:defcfun ("_wrap_btConeShape_makeCPlusArray__SWIG_0" #.(bullet-wrap::swig-lispify "btConeShape_makeCPlusArray" 'function)) :pointer
  (self :pointer)
  (sizeInBytes :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btConeShape_makeCPlusArray" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btConeShape_deleteCPlusArray" 'function)))

(cffi:defcfun ("_wrap_btConeShape_deleteCPlusArray__SWIG_0" #.(bullet-wrap::swig-lispify "btConeShape_deleteCPlusArray" 'function)) :void
  (self :pointer)
  (ptr :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btConeShape_deleteCPlusArray" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btConeShape_makeCPlusArray" 'function)))

(cffi:defcfun ("_wrap_btConeShape_makeCPlusArray__SWIG_1" #.(bullet-wrap::swig-lispify "btConeShape_makeCPlusArray" 'function)) :pointer
  (self :pointer)
  (arg1 :pointer)
  (ptr :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btConeShape_makeCPlusArray" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btConeShape_deleteCPlusArray" 'function)))

(cffi:defcfun ("_wrap_btConeShape_deleteCPlusArray__SWIG_1" #.(bullet-wrap::swig-lispify "btConeShape_deleteCPlusArray" 'function)) :void
  (self :pointer)
  (arg1 :pointer)
  (arg2 :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btConeShape_deleteCPlusArray" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "new_btConeShape" 'function)))

(cffi:defcfun ("_wrap_new_btConeShape" #.(bullet-wrap::swig-lispify "new_btConeShape" 'function)) :pointer
  (radius :float)
  (height :float))

(cl:export '#.(bullet-wrap::swig-lispify "new_btConeShape" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btConeShape_localGetSupportingVertex" 'function)))

(cffi:defcfun ("_wrap_btConeShape_localGetSupportingVertex" #.(bullet-wrap::swig-lispify "btConeShape_localGetSupportingVertex" 'function)) :pointer
  (self :pointer)
  (vec :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btConeShape_localGetSupportingVertex" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btConeShape_localGetSupportingVertexWithoutMargin" 'function)))

(cffi:defcfun ("_wrap_btConeShape_localGetSupportingVertexWithoutMargin" #.(bullet-wrap::swig-lispify "btConeShape_localGetSupportingVertexWithoutMargin" 'function)) :pointer
  (self :pointer)
  (vec :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btConeShape_localGetSupportingVertexWithoutMargin" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btConeShape_batchedUnitVectorGetSupportingVertexWithoutMargin" 'function)))

(cffi:defcfun ("_wrap_btConeShape_batchedUnitVectorGetSupportingVertexWithoutMargin" #.(bullet-wrap::swig-lispify "btConeShape_batchedUnitVectorGetSupportingVertexWithoutMargin" 'function)) :void
  (self :pointer)
  (vectors :pointer)
  (supportVerticesOut :pointer)
  (numVectors :int))

(cl:export '#.(bullet-wrap::swig-lispify "btConeShape_batchedUnitVectorGetSupportingVertexWithoutMargin" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btConeShape_getRadius" 'function)))

(cffi:defcfun ("_wrap_btConeShape_getRadius" #.(bullet-wrap::swig-lispify "btConeShape_getRadius" 'function)) :float
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btConeShape_getRadius" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btConeShape_getHeight" 'function)))

(cffi:defcfun ("_wrap_btConeShape_getHeight" #.(bullet-wrap::swig-lispify "btConeShape_getHeight" 'function)) :float
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btConeShape_getHeight" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btConeShape_calculateLocalInertia" 'function)))

(cffi:defcfun ("_wrap_btConeShape_calculateLocalInertia" #.(bullet-wrap::swig-lispify "btConeShape_calculateLocalInertia" 'function)) :void
  (self :pointer)
  (mass :float)
  (inertia :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btConeShape_calculateLocalInertia" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btConeShape_getName" 'function)))

(cffi:defcfun ("_wrap_btConeShape_getName" #.(bullet-wrap::swig-lispify "btConeShape_getName" 'function)) :string
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btConeShape_getName" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btConeShape_setConeUpIndex" 'function)))

(cffi:defcfun ("_wrap_btConeShape_setConeUpIndex" #.(bullet-wrap::swig-lispify "btConeShape_setConeUpIndex" 'function)) :void
  (self :pointer)
  (upIndex :int))

(cl:export '#.(bullet-wrap::swig-lispify "btConeShape_setConeUpIndex" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btConeShape_getConeUpIndex" 'function)))

(cffi:defcfun ("_wrap_btConeShape_getConeUpIndex" #.(bullet-wrap::swig-lispify "btConeShape_getConeUpIndex" 'function)) :int
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btConeShape_getConeUpIndex" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btConeShape_getAnisotropicRollingFrictionDirection" 'function)))

(cffi:defcfun ("_wrap_btConeShape_getAnisotropicRollingFrictionDirection" #.(bullet-wrap::swig-lispify "btConeShape_getAnisotropicRollingFrictionDirection" 'function)) :pointer
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btConeShape_getAnisotropicRollingFrictionDirection" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btConeShape_setLocalScaling" 'function)))

(cffi:defcfun ("_wrap_btConeShape_setLocalScaling" #.(bullet-wrap::swig-lispify "btConeShape_setLocalScaling" 'function)) :void
  (self :pointer)
  (scaling :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btConeShape_setLocalScaling" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btConeShape_calculateSerializeBufferSize" 'function)))

(cffi:defcfun ("_wrap_btConeShape_calculateSerializeBufferSize" #.(bullet-wrap::swig-lispify "btConeShape_calculateSerializeBufferSize" 'function)) :int
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btConeShape_calculateSerializeBufferSize" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btConeShape_serialize" 'function)))

(cffi:defcfun ("_wrap_btConeShape_serialize" #.(bullet-wrap::swig-lispify "btConeShape_serialize" 'function)) :string
  (self :pointer)
  (dataBuffer :pointer)
  (serializer :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btConeShape_serialize" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "delete_btConeShape" 'function)))

(cffi:defcfun ("_wrap_delete_btConeShape" #.(bullet-wrap::swig-lispify "delete_btConeShape" 'function)) :void
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "delete_btConeShape" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "new_btConeShapeX" 'function)))

(cffi:defcfun ("_wrap_new_btConeShapeX" #.(bullet-wrap::swig-lispify "new_btConeShapeX" 'function)) :pointer
  (radius :float)
  (height :float))

(cl:export '#.(bullet-wrap::swig-lispify "new_btConeShapeX" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btConeShapeX_getAnisotropicRollingFrictionDirection" 'function)))

(cffi:defcfun ("_wrap_btConeShapeX_getAnisotropicRollingFrictionDirection" #.(bullet-wrap::swig-lispify "btConeShapeX_getAnisotropicRollingFrictionDirection" 'function)) :pointer
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btConeShapeX_getAnisotropicRollingFrictionDirection" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btConeShapeX_getName" 'function)))

(cffi:defcfun ("_wrap_btConeShapeX_getName" #.(bullet-wrap::swig-lispify "btConeShapeX_getName" 'function)) :string
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btConeShapeX_getName" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "delete_btConeShapeX" 'function)))

(cffi:defcfun ("_wrap_delete_btConeShapeX" #.(bullet-wrap::swig-lispify "delete_btConeShapeX" 'function)) :void
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "delete_btConeShapeX" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "new_btConeShapeZ" 'function)))

(cffi:defcfun ("_wrap_new_btConeShapeZ" #.(bullet-wrap::swig-lispify "new_btConeShapeZ" 'function)) :pointer
  (radius :float)
  (height :float))

(cl:export '#.(bullet-wrap::swig-lispify "new_btConeShapeZ" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btConeShapeZ_getAnisotropicRollingFrictionDirection" 'function)))

(cffi:defcfun ("_wrap_btConeShapeZ_getAnisotropicRollingFrictionDirection" #.(bullet-wrap::swig-lispify "btConeShapeZ_getAnisotropicRollingFrictionDirection" 'function)) :pointer
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btConeShapeZ_getAnisotropicRollingFrictionDirection" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btConeShapeZ_getName" 'function)))

(cffi:defcfun ("_wrap_btConeShapeZ_getName" #.(bullet-wrap::swig-lispify "btConeShapeZ_getName" 'function)) :string
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btConeShapeZ_getName" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "delete_btConeShapeZ" 'function)))

(cffi:defcfun ("_wrap_delete_btConeShapeZ" #.(bullet-wrap::swig-lispify "delete_btConeShapeZ" 'function)) :void
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "delete_btConeShapeZ" 'function))

(cffi:defcstruct #.(bullet-wrap::swig-lispify "btConeShapeData" 'classname)
	(#.(bullet-wrap::swig-lispify "m_convexInternalShapeData" 'slotname) :pointer)
	(#.(bullet-wrap::swig-lispify "m_upIndex" 'slotname) :int)
	(#.(bullet-wrap::swig-lispify "m_padding" 'slotname) :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btConeShapeData" 'classname))

(cl:export '#.(bullet-wrap::swig-lispify "m_convexInternalShapeData" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_upIndex" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_padding" 'slotname))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btStaticPlaneShape_makeCPlusPlusInstance" 'function)))

(cffi:defcfun ("_wrap_btStaticPlaneShape_makeCPlusPlusInstance__SWIG_0" #.(bullet-wrap::swig-lispify "btStaticPlaneShape_makeCPlusPlusInstance" 'function)) :pointer
  (self :pointer)
  (sizeInBytes :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btStaticPlaneShape_makeCPlusPlusInstance" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btStaticPlaneShape_deleteCPlusPlusInstance" 'function)))

(cffi:defcfun ("_wrap_btStaticPlaneShape_deleteCPlusPlusInstance__SWIG_0" #.(bullet-wrap::swig-lispify "btStaticPlaneShape_deleteCPlusPlusInstance" 'function)) :void
  (self :pointer)
  (ptr :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btStaticPlaneShape_deleteCPlusPlusInstance" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btStaticPlaneShape_makeCPlusPlusInstance" 'function)))

(cffi:defcfun ("_wrap_btStaticPlaneShape_makeCPlusPlusInstance__SWIG_1" #.(bullet-wrap::swig-lispify "btStaticPlaneShape_makeCPlusPlusInstance" 'function)) :pointer
  (self :pointer)
  (arg1 :pointer)
  (ptr :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btStaticPlaneShape_makeCPlusPlusInstance" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btStaticPlaneShape_deleteCPlusPlusInstance" 'function)))

(cffi:defcfun ("_wrap_btStaticPlaneShape_deleteCPlusPlusInstance__SWIG_1" #.(bullet-wrap::swig-lispify "btStaticPlaneShape_deleteCPlusPlusInstance" 'function)) :void
  (self :pointer)
  (arg1 :pointer)
  (arg2 :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btStaticPlaneShape_deleteCPlusPlusInstance" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btStaticPlaneShape_makeCPlusArray" 'function)))

(cffi:defcfun ("_wrap_btStaticPlaneShape_makeCPlusArray__SWIG_0" #.(bullet-wrap::swig-lispify "btStaticPlaneShape_makeCPlusArray" 'function)) :pointer
  (self :pointer)
  (sizeInBytes :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btStaticPlaneShape_makeCPlusArray" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btStaticPlaneShape_deleteCPlusArray" 'function)))

(cffi:defcfun ("_wrap_btStaticPlaneShape_deleteCPlusArray__SWIG_0" #.(bullet-wrap::swig-lispify "btStaticPlaneShape_deleteCPlusArray" 'function)) :void
  (self :pointer)
  (ptr :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btStaticPlaneShape_deleteCPlusArray" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btStaticPlaneShape_makeCPlusArray" 'function)))

(cffi:defcfun ("_wrap_btStaticPlaneShape_makeCPlusArray__SWIG_1" #.(bullet-wrap::swig-lispify "btStaticPlaneShape_makeCPlusArray" 'function)) :pointer
  (self :pointer)
  (arg1 :pointer)
  (ptr :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btStaticPlaneShape_makeCPlusArray" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btStaticPlaneShape_deleteCPlusArray" 'function)))

(cffi:defcfun ("_wrap_btStaticPlaneShape_deleteCPlusArray__SWIG_1" #.(bullet-wrap::swig-lispify "btStaticPlaneShape_deleteCPlusArray" 'function)) :void
  (self :pointer)
  (arg1 :pointer)
  (arg2 :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btStaticPlaneShape_deleteCPlusArray" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "new_btStaticPlaneShape" 'function)))

(cffi:defcfun ("_wrap_new_btStaticPlaneShape" #.(bullet-wrap::swig-lispify "new_btStaticPlaneShape" 'function)) :pointer
  (planeNormal :pointer)
  (planeConstant :float))

(cl:export '#.(bullet-wrap::swig-lispify "new_btStaticPlaneShape" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "delete_btStaticPlaneShape" 'function)))

(cffi:defcfun ("_wrap_delete_btStaticPlaneShape" #.(bullet-wrap::swig-lispify "delete_btStaticPlaneShape" 'function)) :void
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "delete_btStaticPlaneShape" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btStaticPlaneShape_getAabb" 'function)))

(cffi:defcfun ("_wrap_btStaticPlaneShape_getAabb" #.(bullet-wrap::swig-lispify "btStaticPlaneShape_getAabb" 'function)) :void
  (self :pointer)
  (t_arg1 :pointer)
  (aabbMin :pointer)
  (aabbMax :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btStaticPlaneShape_getAabb" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btStaticPlaneShape_processAllTriangles" 'function)))

(cffi:defcfun ("_wrap_btStaticPlaneShape_processAllTriangles" #.(bullet-wrap::swig-lispify "btStaticPlaneShape_processAllTriangles" 'function)) :void
  (self :pointer)
  (callback :pointer)
  (aabbMin :pointer)
  (aabbMax :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btStaticPlaneShape_processAllTriangles" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btStaticPlaneShape_calculateLocalInertia" 'function)))

(cffi:defcfun ("_wrap_btStaticPlaneShape_calculateLocalInertia" #.(bullet-wrap::swig-lispify "btStaticPlaneShape_calculateLocalInertia" 'function)) :void
  (self :pointer)
  (mass :float)
  (inertia :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btStaticPlaneShape_calculateLocalInertia" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btStaticPlaneShape_setLocalScaling" 'function)))

(cffi:defcfun ("_wrap_btStaticPlaneShape_setLocalScaling" #.(bullet-wrap::swig-lispify "btStaticPlaneShape_setLocalScaling" 'function)) :void
  (self :pointer)
  (scaling :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btStaticPlaneShape_setLocalScaling" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btStaticPlaneShape_getLocalScaling" 'function)))

(cffi:defcfun ("_wrap_btStaticPlaneShape_getLocalScaling" #.(bullet-wrap::swig-lispify "btStaticPlaneShape_getLocalScaling" 'function)) :pointer
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btStaticPlaneShape_getLocalScaling" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btStaticPlaneShape_getPlaneNormal" 'function)))

(cffi:defcfun ("_wrap_btStaticPlaneShape_getPlaneNormal" #.(bullet-wrap::swig-lispify "btStaticPlaneShape_getPlaneNormal" 'function)) :pointer
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btStaticPlaneShape_getPlaneNormal" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btStaticPlaneShape_getPlaneConstant" 'function)))

(cffi:defcfun ("_wrap_btStaticPlaneShape_getPlaneConstant" #.(bullet-wrap::swig-lispify "btStaticPlaneShape_getPlaneConstant" 'function)) :pointer
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btStaticPlaneShape_getPlaneConstant" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btStaticPlaneShape_getName" 'function)))

(cffi:defcfun ("_wrap_btStaticPlaneShape_getName" #.(bullet-wrap::swig-lispify "btStaticPlaneShape_getName" 'function)) :string
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btStaticPlaneShape_getName" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btStaticPlaneShape_calculateSerializeBufferSize" 'function)))

(cffi:defcfun ("_wrap_btStaticPlaneShape_calculateSerializeBufferSize" #.(bullet-wrap::swig-lispify "btStaticPlaneShape_calculateSerializeBufferSize" 'function)) :int
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btStaticPlaneShape_calculateSerializeBufferSize" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btStaticPlaneShape_serialize" 'function)))

(cffi:defcfun ("_wrap_btStaticPlaneShape_serialize" #.(bullet-wrap::swig-lispify "btStaticPlaneShape_serialize" 'function)) :string
  (self :pointer)
  (dataBuffer :pointer)
  (serializer :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btStaticPlaneShape_serialize" 'function))

(cffi:defcstruct #.(bullet-wrap::swig-lispify "btStaticPlaneShapeData" 'classname)
	(#.(bullet-wrap::swig-lispify "m_collisionShapeData" 'slotname) :pointer)
	(#.(bullet-wrap::swig-lispify "m_localScaling" 'slotname) #.(bullet-wrap::swig-lispify "btVector3FloatData" 'classname))
	(#.(bullet-wrap::swig-lispify "m_planeNormal" 'slotname) #.(bullet-wrap::swig-lispify "btVector3FloatData" 'classname))
	(#.(bullet-wrap::swig-lispify "m_planeConstant" 'slotname) :float)
	(#.(bullet-wrap::swig-lispify "m_pad" 'slotname) :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btStaticPlaneShapeData" 'classname))

(cl:export '#.(bullet-wrap::swig-lispify "m_collisionShapeData" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_localScaling" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_planeNormal" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_planeConstant" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_pad" 'slotname))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btConvexHullShape_makeCPlusPlusInstance" 'function)))

(cffi:defcfun ("_wrap_btConvexHullShape_makeCPlusPlusInstance__SWIG_0" #.(bullet-wrap::swig-lispify "btConvexHullShape_makeCPlusPlusInstance" 'function)) :pointer
  (self :pointer)
  (sizeInBytes :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btConvexHullShape_makeCPlusPlusInstance" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btConvexHullShape_deleteCPlusPlusInstance" 'function)))

(cffi:defcfun ("_wrap_btConvexHullShape_deleteCPlusPlusInstance__SWIG_0" #.(bullet-wrap::swig-lispify "btConvexHullShape_deleteCPlusPlusInstance" 'function)) :void
  (self :pointer)
  (ptr :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btConvexHullShape_deleteCPlusPlusInstance" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btConvexHullShape_makeCPlusPlusInstance" 'function)))

(cffi:defcfun ("_wrap_btConvexHullShape_makeCPlusPlusInstance__SWIG_1" #.(bullet-wrap::swig-lispify "btConvexHullShape_makeCPlusPlusInstance" 'function)) :pointer
  (self :pointer)
  (arg1 :pointer)
  (ptr :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btConvexHullShape_makeCPlusPlusInstance" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btConvexHullShape_deleteCPlusPlusInstance" 'function)))

(cffi:defcfun ("_wrap_btConvexHullShape_deleteCPlusPlusInstance__SWIG_1" #.(bullet-wrap::swig-lispify "btConvexHullShape_deleteCPlusPlusInstance" 'function)) :void
  (self :pointer)
  (arg1 :pointer)
  (arg2 :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btConvexHullShape_deleteCPlusPlusInstance" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btConvexHullShape_makeCPlusArray" 'function)))

(cffi:defcfun ("_wrap_btConvexHullShape_makeCPlusArray__SWIG_0" #.(bullet-wrap::swig-lispify "btConvexHullShape_makeCPlusArray" 'function)) :pointer
  (self :pointer)
  (sizeInBytes :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btConvexHullShape_makeCPlusArray" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btConvexHullShape_deleteCPlusArray" 'function)))

(cffi:defcfun ("_wrap_btConvexHullShape_deleteCPlusArray__SWIG_0" #.(bullet-wrap::swig-lispify "btConvexHullShape_deleteCPlusArray" 'function)) :void
  (self :pointer)
  (ptr :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btConvexHullShape_deleteCPlusArray" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btConvexHullShape_makeCPlusArray" 'function)))

(cffi:defcfun ("_wrap_btConvexHullShape_makeCPlusArray__SWIG_1" #.(bullet-wrap::swig-lispify "btConvexHullShape_makeCPlusArray" 'function)) :pointer
  (self :pointer)
  (arg1 :pointer)
  (ptr :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btConvexHullShape_makeCPlusArray" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btConvexHullShape_deleteCPlusArray" 'function)))

(cffi:defcfun ("_wrap_btConvexHullShape_deleteCPlusArray__SWIG_1" #.(bullet-wrap::swig-lispify "btConvexHullShape_deleteCPlusArray" 'function)) :void
  (self :pointer)
  (arg1 :pointer)
  (arg2 :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btConvexHullShape_deleteCPlusArray" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "new_btConvexHullShape" 'function)))

(cffi:defcfun ("_wrap_new_btConvexHullShape__SWIG_0" #.(bullet-wrap::swig-lispify "new_btConvexHullShape" 'function)) :pointer
  (points :pointer)
  (numPoints :int)
  (stride :int))

(cl:export '#.(bullet-wrap::swig-lispify "new_btConvexHullShape" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "new_btConvexHullShape" 'function)))

(cffi:defcfun ("_wrap_new_btConvexHullShape__SWIG_1" #.(bullet-wrap::swig-lispify "new_btConvexHullShape" 'function)) :pointer
  (points :pointer)
  (numPoints :int))

(cl:export '#.(bullet-wrap::swig-lispify "new_btConvexHullShape" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "new_btConvexHullShape" 'function)))

(cffi:defcfun ("_wrap_new_btConvexHullShape__SWIG_2" #.(bullet-wrap::swig-lispify "new_btConvexHullShape" 'function)) :pointer
  (points :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "new_btConvexHullShape" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "new_btConvexHullShape" 'function)))

(cffi:defcfun ("_wrap_new_btConvexHullShape__SWIG_3" #.(bullet-wrap::swig-lispify "new_btConvexHullShape" 'function)) :pointer)

(cl:export '#.(bullet-wrap::swig-lispify "new_btConvexHullShape" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btConvexHullShape_addPoint" 'function)))

(cffi:defcfun ("_wrap_btConvexHullShape_addPoint__SWIG_0" #.(bullet-wrap::swig-lispify "btConvexHullShape_addPoint" 'function)) :void
  (self :pointer)
  (point :pointer)
  (recalculateLocalAabb :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btConvexHullShape_addPoint" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btConvexHullShape_addPoint" 'function)))

(cffi:defcfun ("_wrap_btConvexHullShape_addPoint__SWIG_1" #.(bullet-wrap::swig-lispify "btConvexHullShape_addPoint" 'function)) :void
  (self :pointer)
  (point :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btConvexHullShape_addPoint" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btConvexHullShape_getUnscaledPoints" 'function)))

(cffi:defcfun ("_wrap_btConvexHullShape_getUnscaledPoints__SWIG_0" #.(bullet-wrap::swig-lispify "btConvexHullShape_getUnscaledPoints" 'function)) :pointer
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btConvexHullShape_getUnscaledPoints" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btConvexHullShape_getUnscaledPoints" 'function)))

(cffi:defcfun ("_wrap_btConvexHullShape_getUnscaledPoints__SWIG_1" #.(bullet-wrap::swig-lispify "btConvexHullShape_getUnscaledPoints" 'function)) :pointer
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btConvexHullShape_getUnscaledPoints" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btConvexHullShape_getPoints" 'function)))

(cffi:defcfun ("_wrap_btConvexHullShape_getPoints" #.(bullet-wrap::swig-lispify "btConvexHullShape_getPoints" 'function)) :pointer
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btConvexHullShape_getPoints" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btConvexHullShape_getScaledPoint" 'function)))

(cffi:defcfun ("_wrap_btConvexHullShape_getScaledPoint" #.(bullet-wrap::swig-lispify "btConvexHullShape_getScaledPoint" 'function)) :pointer
  (self :pointer)
  (i :int))

(cl:export '#.(bullet-wrap::swig-lispify "btConvexHullShape_getScaledPoint" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btConvexHullShape_getNumPoints" 'function)))

(cffi:defcfun ("_wrap_btConvexHullShape_getNumPoints" #.(bullet-wrap::swig-lispify "btConvexHullShape_getNumPoints" 'function)) :int
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btConvexHullShape_getNumPoints" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btConvexHullShape_localGetSupportingVertex" 'function)))

(cffi:defcfun ("_wrap_btConvexHullShape_localGetSupportingVertex" #.(bullet-wrap::swig-lispify "btConvexHullShape_localGetSupportingVertex" 'function)) :pointer
  (self :pointer)
  (vec :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btConvexHullShape_localGetSupportingVertex" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btConvexHullShape_localGetSupportingVertexWithoutMargin" 'function)))

(cffi:defcfun ("_wrap_btConvexHullShape_localGetSupportingVertexWithoutMargin" #.(bullet-wrap::swig-lispify "btConvexHullShape_localGetSupportingVertexWithoutMargin" 'function)) :pointer
  (self :pointer)
  (vec :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btConvexHullShape_localGetSupportingVertexWithoutMargin" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btConvexHullShape_batchedUnitVectorGetSupportingVertexWithoutMargin" 'function)))

(cffi:defcfun ("_wrap_btConvexHullShape_batchedUnitVectorGetSupportingVertexWithoutMargin" #.(bullet-wrap::swig-lispify "btConvexHullShape_batchedUnitVectorGetSupportingVertexWithoutMargin" 'function)) :void
  (self :pointer)
  (vectors :pointer)
  (supportVerticesOut :pointer)
  (numVectors :int))

(cl:export '#.(bullet-wrap::swig-lispify "btConvexHullShape_batchedUnitVectorGetSupportingVertexWithoutMargin" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btConvexHullShape_project" 'function)))

(cffi:defcfun ("_wrap_btConvexHullShape_project" #.(bullet-wrap::swig-lispify "btConvexHullShape_project" 'function)) :void
  (self :pointer)
  (trans :pointer)
  (dir :pointer)
  (minProj :pointer)
  (maxProj :pointer)
  (witnesPtMin :pointer)
  (witnesPtMax :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btConvexHullShape_project" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btConvexHullShape_getName" 'function)))

(cffi:defcfun ("_wrap_btConvexHullShape_getName" #.(bullet-wrap::swig-lispify "btConvexHullShape_getName" 'function)) :string
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btConvexHullShape_getName" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btConvexHullShape_getNumVertices" 'function)))

(cffi:defcfun ("_wrap_btConvexHullShape_getNumVertices" #.(bullet-wrap::swig-lispify "btConvexHullShape_getNumVertices" 'function)) :int
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btConvexHullShape_getNumVertices" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btConvexHullShape_getNumEdges" 'function)))

(cffi:defcfun ("_wrap_btConvexHullShape_getNumEdges" #.(bullet-wrap::swig-lispify "btConvexHullShape_getNumEdges" 'function)) :int
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btConvexHullShape_getNumEdges" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btConvexHullShape_getEdge" 'function)))

(cffi:defcfun ("_wrap_btConvexHullShape_getEdge" #.(bullet-wrap::swig-lispify "btConvexHullShape_getEdge" 'function)) :void
  (self :pointer)
  (i :int)
  (pa :pointer)
  (pb :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btConvexHullShape_getEdge" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btConvexHullShape_getVertex" 'function)))

(cffi:defcfun ("_wrap_btConvexHullShape_getVertex" #.(bullet-wrap::swig-lispify "btConvexHullShape_getVertex" 'function)) :void
  (self :pointer)
  (i :int)
  (vtx :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btConvexHullShape_getVertex" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btConvexHullShape_getNumPlanes" 'function)))

(cffi:defcfun ("_wrap_btConvexHullShape_getNumPlanes" #.(bullet-wrap::swig-lispify "btConvexHullShape_getNumPlanes" 'function)) :int
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btConvexHullShape_getNumPlanes" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btConvexHullShape_getPlane" 'function)))

(cffi:defcfun ("_wrap_btConvexHullShape_getPlane" #.(bullet-wrap::swig-lispify "btConvexHullShape_getPlane" 'function)) :void
  (self :pointer)
  (planeNormal :pointer)
  (planeSupport :pointer)
  (i :int))

(cl:export '#.(bullet-wrap::swig-lispify "btConvexHullShape_getPlane" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btConvexHullShape_isInside" 'function)))

(cffi:defcfun ("_wrap_btConvexHullShape_isInside" #.(bullet-wrap::swig-lispify "btConvexHullShape_isInside" 'function)) :pointer
  (self :pointer)
  (pt :pointer)
  (tolerance :float))

(cl:export '#.(bullet-wrap::swig-lispify "btConvexHullShape_isInside" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btConvexHullShape_setLocalScaling" 'function)))

(cffi:defcfun ("_wrap_btConvexHullShape_setLocalScaling" #.(bullet-wrap::swig-lispify "btConvexHullShape_setLocalScaling" 'function)) :void
  (self :pointer)
  (scaling :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btConvexHullShape_setLocalScaling" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btConvexHullShape_calculateSerializeBufferSize" 'function)))

(cffi:defcfun ("_wrap_btConvexHullShape_calculateSerializeBufferSize" #.(bullet-wrap::swig-lispify "btConvexHullShape_calculateSerializeBufferSize" 'function)) :int
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btConvexHullShape_calculateSerializeBufferSize" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btConvexHullShape_serialize" 'function)))

(cffi:defcfun ("_wrap_btConvexHullShape_serialize" #.(bullet-wrap::swig-lispify "btConvexHullShape_serialize" 'function)) :string
  (self :pointer)
  (dataBuffer :pointer)
  (serializer :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btConvexHullShape_serialize" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "delete_btConvexHullShape" 'function)))

(cffi:defcfun ("_wrap_delete_btConvexHullShape" #.(bullet-wrap::swig-lispify "delete_btConvexHullShape" 'function)) :void
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "delete_btConvexHullShape" 'function))

(cffi:defcstruct #.(bullet-wrap::swig-lispify "btConvexHullShapeData" 'classname)
	(#.(bullet-wrap::swig-lispify "m_convexInternalShapeData" 'slotname) :pointer)
	(#.(bullet-wrap::swig-lispify "m_unscaledPointsFloatPtr" 'slotname) :pointer)
	(#.(bullet-wrap::swig-lispify "m_unscaledPointsDoublePtr" 'slotname) :pointer)
	(#.(bullet-wrap::swig-lispify "m_numUnscaledPoints" 'slotname) :int)
	(#.(bullet-wrap::swig-lispify "m_padding3" 'slotname) :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btConvexHullShapeData" 'classname))

(cl:export '#.(bullet-wrap::swig-lispify "m_convexInternalShapeData" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_unscaledPointsFloatPtr" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_unscaledPointsDoublePtr" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_numUnscaledPoints" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_padding3" 'slotname))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btTriangleMesh_m_weldingThreshold_set" 'function)))

(cffi:defcfun ("_wrap_btTriangleMesh_m_weldingThreshold_set" #.(bullet-wrap::swig-lispify "btTriangleMesh_m_weldingThreshold_set" 'function)) :void
  (self :pointer)
  (m_weldingThreshold :float))

(cl:export '#.(bullet-wrap::swig-lispify "btTriangleMesh_m_weldingThreshold_set" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btTriangleMesh_m_weldingThreshold_get" 'function)))

(cffi:defcfun ("_wrap_btTriangleMesh_m_weldingThreshold_get" #.(bullet-wrap::swig-lispify "btTriangleMesh_m_weldingThreshold_get" 'function)) :float
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btTriangleMesh_m_weldingThreshold_get" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "new_btTriangleMesh" 'function)))

(cffi:defcfun ("_wrap_new_btTriangleMesh__SWIG_0" #.(bullet-wrap::swig-lispify "new_btTriangleMesh" 'function)) :pointer
  (use32bitIndices :pointer)
  (use4componentVertices :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "new_btTriangleMesh" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "new_btTriangleMesh" 'function)))

(cffi:defcfun ("_wrap_new_btTriangleMesh__SWIG_1" #.(bullet-wrap::swig-lispify "new_btTriangleMesh" 'function)) :pointer
  (use32bitIndices :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "new_btTriangleMesh" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "new_btTriangleMesh" 'function)))

(cffi:defcfun ("_wrap_new_btTriangleMesh__SWIG_2" #.(bullet-wrap::swig-lispify "new_btTriangleMesh" 'function)) :pointer)

(cl:export '#.(bullet-wrap::swig-lispify "new_btTriangleMesh" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btTriangleMesh_getUse32bitIndices" 'function)))

(cffi:defcfun ("_wrap_btTriangleMesh_getUse32bitIndices" #.(bullet-wrap::swig-lispify "btTriangleMesh_getUse32bitIndices" 'function)) :pointer
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btTriangleMesh_getUse32bitIndices" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btTriangleMesh_getUse4componentVertices" 'function)))

(cffi:defcfun ("_wrap_btTriangleMesh_getUse4componentVertices" #.(bullet-wrap::swig-lispify "btTriangleMesh_getUse4componentVertices" 'function)) :pointer
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btTriangleMesh_getUse4componentVertices" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btTriangleMesh_addTriangle" 'function)))

(cffi:defcfun ("_wrap_btTriangleMesh_addTriangle__SWIG_0" #.(bullet-wrap::swig-lispify "btTriangleMesh_addTriangle" 'function)) :void
  (self :pointer)
  (vertex0 :pointer)
  (vertex1 :pointer)
  (vertex2 :pointer)
  (removeDuplicateVertices :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btTriangleMesh_addTriangle" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btTriangleMesh_addTriangle" 'function)))

(cffi:defcfun ("_wrap_btTriangleMesh_addTriangle__SWIG_1" #.(bullet-wrap::swig-lispify "btTriangleMesh_addTriangle" 'function)) :void
  (self :pointer)
  (vertex0 :pointer)
  (vertex1 :pointer)
  (vertex2 :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btTriangleMesh_addTriangle" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btTriangleMesh_getNumTriangles" 'function)))

(cffi:defcfun ("_wrap_btTriangleMesh_getNumTriangles" #.(bullet-wrap::swig-lispify "btTriangleMesh_getNumTriangles" 'function)) :int
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btTriangleMesh_getNumTriangles" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btTriangleMesh_preallocateVertices" 'function)))

(cffi:defcfun ("_wrap_btTriangleMesh_preallocateVertices" #.(bullet-wrap::swig-lispify "btTriangleMesh_preallocateVertices" 'function)) :void
  (self :pointer)
  (numverts :int))

(cl:export '#.(bullet-wrap::swig-lispify "btTriangleMesh_preallocateVertices" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btTriangleMesh_preallocateIndices" 'function)))

(cffi:defcfun ("_wrap_btTriangleMesh_preallocateIndices" #.(bullet-wrap::swig-lispify "btTriangleMesh_preallocateIndices" 'function)) :void
  (self :pointer)
  (numindices :int))

(cl:export '#.(bullet-wrap::swig-lispify "btTriangleMesh_preallocateIndices" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btTriangleMesh_findOrAddVertex" 'function)))

(cffi:defcfun ("_wrap_btTriangleMesh_findOrAddVertex" #.(bullet-wrap::swig-lispify "btTriangleMesh_findOrAddVertex" 'function)) :int
  (self :pointer)
  (vertex :pointer)
  (removeDuplicateVertices :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btTriangleMesh_findOrAddVertex" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btTriangleMesh_addIndex" 'function)))

(cffi:defcfun ("_wrap_btTriangleMesh_addIndex" #.(bullet-wrap::swig-lispify "btTriangleMesh_addIndex" 'function)) :void
  (self :pointer)
  (index :int))

(cl:export '#.(bullet-wrap::swig-lispify "btTriangleMesh_addIndex" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "delete_btTriangleMesh" 'function)))

(cffi:defcfun ("_wrap_delete_btTriangleMesh" #.(bullet-wrap::swig-lispify "delete_btTriangleMesh" 'function)) :void
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "delete_btTriangleMesh" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btConvexTriangleMeshShape_makeCPlusPlusInstance" 'function)))

(cffi:defcfun ("_wrap_btConvexTriangleMeshShape_makeCPlusPlusInstance__SWIG_0" #.(bullet-wrap::swig-lispify "btConvexTriangleMeshShape_makeCPlusPlusInstance" 'function)) :pointer
  (self :pointer)
  (sizeInBytes :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btConvexTriangleMeshShape_makeCPlusPlusInstance" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btConvexTriangleMeshShape_deleteCPlusPlusInstance" 'function)))

(cffi:defcfun ("_wrap_btConvexTriangleMeshShape_deleteCPlusPlusInstance__SWIG_0" #.(bullet-wrap::swig-lispify "btConvexTriangleMeshShape_deleteCPlusPlusInstance" 'function)) :void
  (self :pointer)
  (ptr :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btConvexTriangleMeshShape_deleteCPlusPlusInstance" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btConvexTriangleMeshShape_makeCPlusPlusInstance" 'function)))

(cffi:defcfun ("_wrap_btConvexTriangleMeshShape_makeCPlusPlusInstance__SWIG_1" #.(bullet-wrap::swig-lispify "btConvexTriangleMeshShape_makeCPlusPlusInstance" 'function)) :pointer
  (self :pointer)
  (arg1 :pointer)
  (ptr :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btConvexTriangleMeshShape_makeCPlusPlusInstance" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btConvexTriangleMeshShape_deleteCPlusPlusInstance" 'function)))

(cffi:defcfun ("_wrap_btConvexTriangleMeshShape_deleteCPlusPlusInstance__SWIG_1" #.(bullet-wrap::swig-lispify "btConvexTriangleMeshShape_deleteCPlusPlusInstance" 'function)) :void
  (self :pointer)
  (arg1 :pointer)
  (arg2 :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btConvexTriangleMeshShape_deleteCPlusPlusInstance" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btConvexTriangleMeshShape_makeCPlusArray" 'function)))

(cffi:defcfun ("_wrap_btConvexTriangleMeshShape_makeCPlusArray__SWIG_0" #.(bullet-wrap::swig-lispify "btConvexTriangleMeshShape_makeCPlusArray" 'function)) :pointer
  (self :pointer)
  (sizeInBytes :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btConvexTriangleMeshShape_makeCPlusArray" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btConvexTriangleMeshShape_deleteCPlusArray" 'function)))

(cffi:defcfun ("_wrap_btConvexTriangleMeshShape_deleteCPlusArray__SWIG_0" #.(bullet-wrap::swig-lispify "btConvexTriangleMeshShape_deleteCPlusArray" 'function)) :void
  (self :pointer)
  (ptr :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btConvexTriangleMeshShape_deleteCPlusArray" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btConvexTriangleMeshShape_makeCPlusArray" 'function)))

(cffi:defcfun ("_wrap_btConvexTriangleMeshShape_makeCPlusArray__SWIG_1" #.(bullet-wrap::swig-lispify "btConvexTriangleMeshShape_makeCPlusArray" 'function)) :pointer
  (self :pointer)
  (arg1 :pointer)
  (ptr :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btConvexTriangleMeshShape_makeCPlusArray" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btConvexTriangleMeshShape_deleteCPlusArray" 'function)))

(cffi:defcfun ("_wrap_btConvexTriangleMeshShape_deleteCPlusArray__SWIG_1" #.(bullet-wrap::swig-lispify "btConvexTriangleMeshShape_deleteCPlusArray" 'function)) :void
  (self :pointer)
  (arg1 :pointer)
  (arg2 :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btConvexTriangleMeshShape_deleteCPlusArray" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "new_btConvexTriangleMeshShape" 'function)))

(cffi:defcfun ("_wrap_new_btConvexTriangleMeshShape__SWIG_0" #.(bullet-wrap::swig-lispify "new_btConvexTriangleMeshShape" 'function)) :pointer
  (meshInterface :pointer)
  (calcAabb :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "new_btConvexTriangleMeshShape" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "new_btConvexTriangleMeshShape" 'function)))

(cffi:defcfun ("_wrap_new_btConvexTriangleMeshShape__SWIG_1" #.(bullet-wrap::swig-lispify "new_btConvexTriangleMeshShape" 'function)) :pointer
  (meshInterface :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "new_btConvexTriangleMeshShape" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btConvexTriangleMeshShape_getMeshInterface" 'function)))

(cffi:defcfun ("_wrap_btConvexTriangleMeshShape_getMeshInterface__SWIG_0" #.(bullet-wrap::swig-lispify "btConvexTriangleMeshShape_getMeshInterface" 'function)) :pointer
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btConvexTriangleMeshShape_getMeshInterface" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btConvexTriangleMeshShape_getMeshInterface" 'function)))

(cffi:defcfun ("_wrap_btConvexTriangleMeshShape_getMeshInterface__SWIG_1" #.(bullet-wrap::swig-lispify "btConvexTriangleMeshShape_getMeshInterface" 'function)) :pointer
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btConvexTriangleMeshShape_getMeshInterface" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btConvexTriangleMeshShape_localGetSupportingVertex" 'function)))

(cffi:defcfun ("_wrap_btConvexTriangleMeshShape_localGetSupportingVertex" #.(bullet-wrap::swig-lispify "btConvexTriangleMeshShape_localGetSupportingVertex" 'function)) :pointer
  (self :pointer)
  (vec :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btConvexTriangleMeshShape_localGetSupportingVertex" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btConvexTriangleMeshShape_localGetSupportingVertexWithoutMargin" 'function)))

(cffi:defcfun ("_wrap_btConvexTriangleMeshShape_localGetSupportingVertexWithoutMargin" #.(bullet-wrap::swig-lispify "btConvexTriangleMeshShape_localGetSupportingVertexWithoutMargin" 'function)) :pointer
  (self :pointer)
  (vec :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btConvexTriangleMeshShape_localGetSupportingVertexWithoutMargin" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btConvexTriangleMeshShape_batchedUnitVectorGetSupportingVertexWithoutMargin" 'function)))

(cffi:defcfun ("_wrap_btConvexTriangleMeshShape_batchedUnitVectorGetSupportingVertexWithoutMargin" #.(bullet-wrap::swig-lispify "btConvexTriangleMeshShape_batchedUnitVectorGetSupportingVertexWithoutMargin" 'function)) :void
  (self :pointer)
  (vectors :pointer)
  (supportVerticesOut :pointer)
  (numVectors :int))

(cl:export '#.(bullet-wrap::swig-lispify "btConvexTriangleMeshShape_batchedUnitVectorGetSupportingVertexWithoutMargin" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btConvexTriangleMeshShape_getName" 'function)))

(cffi:defcfun ("_wrap_btConvexTriangleMeshShape_getName" #.(bullet-wrap::swig-lispify "btConvexTriangleMeshShape_getName" 'function)) :string
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btConvexTriangleMeshShape_getName" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btConvexTriangleMeshShape_getNumVertices" 'function)))

(cffi:defcfun ("_wrap_btConvexTriangleMeshShape_getNumVertices" #.(bullet-wrap::swig-lispify "btConvexTriangleMeshShape_getNumVertices" 'function)) :int
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btConvexTriangleMeshShape_getNumVertices" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btConvexTriangleMeshShape_getNumEdges" 'function)))

(cffi:defcfun ("_wrap_btConvexTriangleMeshShape_getNumEdges" #.(bullet-wrap::swig-lispify "btConvexTriangleMeshShape_getNumEdges" 'function)) :int
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btConvexTriangleMeshShape_getNumEdges" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btConvexTriangleMeshShape_getEdge" 'function)))

(cffi:defcfun ("_wrap_btConvexTriangleMeshShape_getEdge" #.(bullet-wrap::swig-lispify "btConvexTriangleMeshShape_getEdge" 'function)) :void
  (self :pointer)
  (i :int)
  (pa :pointer)
  (pb :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btConvexTriangleMeshShape_getEdge" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btConvexTriangleMeshShape_getVertex" 'function)))

(cffi:defcfun ("_wrap_btConvexTriangleMeshShape_getVertex" #.(bullet-wrap::swig-lispify "btConvexTriangleMeshShape_getVertex" 'function)) :void
  (self :pointer)
  (i :int)
  (vtx :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btConvexTriangleMeshShape_getVertex" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btConvexTriangleMeshShape_getNumPlanes" 'function)))

(cffi:defcfun ("_wrap_btConvexTriangleMeshShape_getNumPlanes" #.(bullet-wrap::swig-lispify "btConvexTriangleMeshShape_getNumPlanes" 'function)) :int
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btConvexTriangleMeshShape_getNumPlanes" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btConvexTriangleMeshShape_getPlane" 'function)))

(cffi:defcfun ("_wrap_btConvexTriangleMeshShape_getPlane" #.(bullet-wrap::swig-lispify "btConvexTriangleMeshShape_getPlane" 'function)) :void
  (self :pointer)
  (planeNormal :pointer)
  (planeSupport :pointer)
  (i :int))

(cl:export '#.(bullet-wrap::swig-lispify "btConvexTriangleMeshShape_getPlane" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btConvexTriangleMeshShape_isInside" 'function)))

(cffi:defcfun ("_wrap_btConvexTriangleMeshShape_isInside" #.(bullet-wrap::swig-lispify "btConvexTriangleMeshShape_isInside" 'function)) :pointer
  (self :pointer)
  (pt :pointer)
  (tolerance :float))

(cl:export '#.(bullet-wrap::swig-lispify "btConvexTriangleMeshShape_isInside" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btConvexTriangleMeshShape_setLocalScaling" 'function)))

(cffi:defcfun ("_wrap_btConvexTriangleMeshShape_setLocalScaling" #.(bullet-wrap::swig-lispify "btConvexTriangleMeshShape_setLocalScaling" 'function)) :void
  (self :pointer)
  (scaling :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btConvexTriangleMeshShape_setLocalScaling" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btConvexTriangleMeshShape_getLocalScaling" 'function)))

(cffi:defcfun ("_wrap_btConvexTriangleMeshShape_getLocalScaling" #.(bullet-wrap::swig-lispify "btConvexTriangleMeshShape_getLocalScaling" 'function)) :pointer
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btConvexTriangleMeshShape_getLocalScaling" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btConvexTriangleMeshShape_calculatePrincipalAxisTransform" 'function)))

(cffi:defcfun ("_wrap_btConvexTriangleMeshShape_calculatePrincipalAxisTransform" #.(bullet-wrap::swig-lispify "btConvexTriangleMeshShape_calculatePrincipalAxisTransform" 'function)) :void
  (self :pointer)
  (principal :pointer)
  (inertia :pointer)
  (volume :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btConvexTriangleMeshShape_calculatePrincipalAxisTransform" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "delete_btConvexTriangleMeshShape" 'function)))

(cffi:defcfun ("_wrap_delete_btConvexTriangleMeshShape" #.(bullet-wrap::swig-lispify "delete_btConvexTriangleMeshShape" 'function)) :void
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "delete_btConvexTriangleMeshShape" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btBvhTriangleMeshShape_makeCPlusPlusInstance" 'function)))

(cffi:defcfun ("_wrap_btBvhTriangleMeshShape_makeCPlusPlusInstance__SWIG_0" #.(bullet-wrap::swig-lispify "btBvhTriangleMeshShape_makeCPlusPlusInstance" 'function)) :pointer
  (self :pointer)
  (sizeInBytes :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btBvhTriangleMeshShape_makeCPlusPlusInstance" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btBvhTriangleMeshShape_deleteCPlusPlusInstance" 'function)))

(cffi:defcfun ("_wrap_btBvhTriangleMeshShape_deleteCPlusPlusInstance__SWIG_0" #.(bullet-wrap::swig-lispify "btBvhTriangleMeshShape_deleteCPlusPlusInstance" 'function)) :void
  (self :pointer)
  (ptr :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btBvhTriangleMeshShape_deleteCPlusPlusInstance" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btBvhTriangleMeshShape_makeCPlusPlusInstance" 'function)))

(cffi:defcfun ("_wrap_btBvhTriangleMeshShape_makeCPlusPlusInstance__SWIG_1" #.(bullet-wrap::swig-lispify "btBvhTriangleMeshShape_makeCPlusPlusInstance" 'function)) :pointer
  (self :pointer)
  (arg1 :pointer)
  (ptr :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btBvhTriangleMeshShape_makeCPlusPlusInstance" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btBvhTriangleMeshShape_deleteCPlusPlusInstance" 'function)))

(cffi:defcfun ("_wrap_btBvhTriangleMeshShape_deleteCPlusPlusInstance__SWIG_1" #.(bullet-wrap::swig-lispify "btBvhTriangleMeshShape_deleteCPlusPlusInstance" 'function)) :void
  (self :pointer)
  (arg1 :pointer)
  (arg2 :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btBvhTriangleMeshShape_deleteCPlusPlusInstance" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btBvhTriangleMeshShape_makeCPlusArray" 'function)))

(cffi:defcfun ("_wrap_btBvhTriangleMeshShape_makeCPlusArray__SWIG_0" #.(bullet-wrap::swig-lispify "btBvhTriangleMeshShape_makeCPlusArray" 'function)) :pointer
  (self :pointer)
  (sizeInBytes :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btBvhTriangleMeshShape_makeCPlusArray" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btBvhTriangleMeshShape_deleteCPlusArray" 'function)))

(cffi:defcfun ("_wrap_btBvhTriangleMeshShape_deleteCPlusArray__SWIG_0" #.(bullet-wrap::swig-lispify "btBvhTriangleMeshShape_deleteCPlusArray" 'function)) :void
  (self :pointer)
  (ptr :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btBvhTriangleMeshShape_deleteCPlusArray" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btBvhTriangleMeshShape_makeCPlusArray" 'function)))

(cffi:defcfun ("_wrap_btBvhTriangleMeshShape_makeCPlusArray__SWIG_1" #.(bullet-wrap::swig-lispify "btBvhTriangleMeshShape_makeCPlusArray" 'function)) :pointer
  (self :pointer)
  (arg1 :pointer)
  (ptr :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btBvhTriangleMeshShape_makeCPlusArray" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btBvhTriangleMeshShape_deleteCPlusArray" 'function)))

(cffi:defcfun ("_wrap_btBvhTriangleMeshShape_deleteCPlusArray__SWIG_1" #.(bullet-wrap::swig-lispify "btBvhTriangleMeshShape_deleteCPlusArray" 'function)) :void
  (self :pointer)
  (arg1 :pointer)
  (arg2 :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btBvhTriangleMeshShape_deleteCPlusArray" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "new_btBvhTriangleMeshShape" 'function)))

(cffi:defcfun ("_wrap_new_btBvhTriangleMeshShape__SWIG_0" #.(bullet-wrap::swig-lispify "new_btBvhTriangleMeshShape" 'function)) :pointer
  (meshInterface :pointer)
  (useQuantizedAabbCompression :pointer)
  (buildBvh :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "new_btBvhTriangleMeshShape" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "new_btBvhTriangleMeshShape" 'function)))

(cffi:defcfun ("_wrap_new_btBvhTriangleMeshShape__SWIG_1" #.(bullet-wrap::swig-lispify "new_btBvhTriangleMeshShape" 'function)) :pointer
  (meshInterface :pointer)
  (useQuantizedAabbCompression :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "new_btBvhTriangleMeshShape" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "new_btBvhTriangleMeshShape" 'function)))

(cffi:defcfun ("_wrap_new_btBvhTriangleMeshShape__SWIG_2" #.(bullet-wrap::swig-lispify "new_btBvhTriangleMeshShape" 'function)) :pointer
  (meshInterface :pointer)
  (useQuantizedAabbCompression :pointer)
  (bvhAabbMin :pointer)
  (bvhAabbMax :pointer)
  (buildBvh :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "new_btBvhTriangleMeshShape" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "new_btBvhTriangleMeshShape" 'function)))

(cffi:defcfun ("_wrap_new_btBvhTriangleMeshShape__SWIG_3" #.(bullet-wrap::swig-lispify "new_btBvhTriangleMeshShape" 'function)) :pointer
  (meshInterface :pointer)
  (useQuantizedAabbCompression :pointer)
  (bvhAabbMin :pointer)
  (bvhAabbMax :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "new_btBvhTriangleMeshShape" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "delete_btBvhTriangleMeshShape" 'function)))

(cffi:defcfun ("_wrap_delete_btBvhTriangleMeshShape" #.(bullet-wrap::swig-lispify "delete_btBvhTriangleMeshShape" 'function)) :void
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "delete_btBvhTriangleMeshShape" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btBvhTriangleMeshShape_getOwnsBvh" 'function)))

(cffi:defcfun ("_wrap_btBvhTriangleMeshShape_getOwnsBvh" #.(bullet-wrap::swig-lispify "btBvhTriangleMeshShape_getOwnsBvh" 'function)) :pointer
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btBvhTriangleMeshShape_getOwnsBvh" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btBvhTriangleMeshShape_performRaycast" 'function)))

(cffi:defcfun ("_wrap_btBvhTriangleMeshShape_performRaycast" #.(bullet-wrap::swig-lispify "btBvhTriangleMeshShape_performRaycast" 'function)) :void
  (self :pointer)
  (callback :pointer)
  (raySource :pointer)
  (rayTarget :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btBvhTriangleMeshShape_performRaycast" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btBvhTriangleMeshShape_performConvexcast" 'function)))

(cffi:defcfun ("_wrap_btBvhTriangleMeshShape_performConvexcast" #.(bullet-wrap::swig-lispify "btBvhTriangleMeshShape_performConvexcast" 'function)) :void
  (self :pointer)
  (callback :pointer)
  (boxSource :pointer)
  (boxTarget :pointer)
  (boxMin :pointer)
  (boxMax :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btBvhTriangleMeshShape_performConvexcast" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btBvhTriangleMeshShape_processAllTriangles" 'function)))

(cffi:defcfun ("_wrap_btBvhTriangleMeshShape_processAllTriangles" #.(bullet-wrap::swig-lispify "btBvhTriangleMeshShape_processAllTriangles" 'function)) :void
  (self :pointer)
  (callback :pointer)
  (aabbMin :pointer)
  (aabbMax :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btBvhTriangleMeshShape_processAllTriangles" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btBvhTriangleMeshShape_refitTree" 'function)))

(cffi:defcfun ("_wrap_btBvhTriangleMeshShape_refitTree" #.(bullet-wrap::swig-lispify "btBvhTriangleMeshShape_refitTree" 'function)) :void
  (self :pointer)
  (aabbMin :pointer)
  (aabbMax :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btBvhTriangleMeshShape_refitTree" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btBvhTriangleMeshShape_partialRefitTree" 'function)))

(cffi:defcfun ("_wrap_btBvhTriangleMeshShape_partialRefitTree" #.(bullet-wrap::swig-lispify "btBvhTriangleMeshShape_partialRefitTree" 'function)) :void
  (self :pointer)
  (aabbMin :pointer)
  (aabbMax :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btBvhTriangleMeshShape_partialRefitTree" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btBvhTriangleMeshShape_getName" 'function)))

(cffi:defcfun ("_wrap_btBvhTriangleMeshShape_getName" #.(bullet-wrap::swig-lispify "btBvhTriangleMeshShape_getName" 'function)) :string
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btBvhTriangleMeshShape_getName" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btBvhTriangleMeshShape_setLocalScaling" 'function)))

(cffi:defcfun ("_wrap_btBvhTriangleMeshShape_setLocalScaling" #.(bullet-wrap::swig-lispify "btBvhTriangleMeshShape_setLocalScaling" 'function)) :void
  (self :pointer)
  (scaling :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btBvhTriangleMeshShape_setLocalScaling" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btBvhTriangleMeshShape_getOptimizedBvh" 'function)))

(cffi:defcfun ("_wrap_btBvhTriangleMeshShape_getOptimizedBvh" #.(bullet-wrap::swig-lispify "btBvhTriangleMeshShape_getOptimizedBvh" 'function)) :pointer
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btBvhTriangleMeshShape_getOptimizedBvh" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btBvhTriangleMeshShape_setOptimizedBvh" 'function)))

(cffi:defcfun ("_wrap_btBvhTriangleMeshShape_setOptimizedBvh__SWIG_0" #.(bullet-wrap::swig-lispify "btBvhTriangleMeshShape_setOptimizedBvh" 'function)) :void
  (self :pointer)
  (bvh :pointer)
  (localScaling :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btBvhTriangleMeshShape_setOptimizedBvh" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btBvhTriangleMeshShape_setOptimizedBvh" 'function)))

(cffi:defcfun ("_wrap_btBvhTriangleMeshShape_setOptimizedBvh__SWIG_1" #.(bullet-wrap::swig-lispify "btBvhTriangleMeshShape_setOptimizedBvh" 'function)) :void
  (self :pointer)
  (bvh :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btBvhTriangleMeshShape_setOptimizedBvh" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btBvhTriangleMeshShape_buildOptimizedBvh" 'function)))

(cffi:defcfun ("_wrap_btBvhTriangleMeshShape_buildOptimizedBvh" #.(bullet-wrap::swig-lispify "btBvhTriangleMeshShape_buildOptimizedBvh" 'function)) :void
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btBvhTriangleMeshShape_buildOptimizedBvh" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btBvhTriangleMeshShape_usesQuantizedAabbCompression" 'function)))

(cffi:defcfun ("_wrap_btBvhTriangleMeshShape_usesQuantizedAabbCompression" #.(bullet-wrap::swig-lispify "btBvhTriangleMeshShape_usesQuantizedAabbCompression" 'function)) :pointer
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btBvhTriangleMeshShape_usesQuantizedAabbCompression" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btBvhTriangleMeshShape_setTriangleInfoMap" 'function)))

(cffi:defcfun ("_wrap_btBvhTriangleMeshShape_setTriangleInfoMap" #.(bullet-wrap::swig-lispify "btBvhTriangleMeshShape_setTriangleInfoMap" 'function)) :void
  (self :pointer)
  (triangleInfoMap :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btBvhTriangleMeshShape_setTriangleInfoMap" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btBvhTriangleMeshShape_getTriangleInfoMap" 'function)))

(cffi:defcfun ("_wrap_btBvhTriangleMeshShape_getTriangleInfoMap__SWIG_0" #.(bullet-wrap::swig-lispify "btBvhTriangleMeshShape_getTriangleInfoMap" 'function)) :pointer
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btBvhTriangleMeshShape_getTriangleInfoMap" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btBvhTriangleMeshShape_getTriangleInfoMap" 'function)))

(cffi:defcfun ("_wrap_btBvhTriangleMeshShape_getTriangleInfoMap__SWIG_1" #.(bullet-wrap::swig-lispify "btBvhTriangleMeshShape_getTriangleInfoMap" 'function)) :pointer
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btBvhTriangleMeshShape_getTriangleInfoMap" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btBvhTriangleMeshShape_calculateSerializeBufferSize" 'function)))

(cffi:defcfun ("_wrap_btBvhTriangleMeshShape_calculateSerializeBufferSize" #.(bullet-wrap::swig-lispify "btBvhTriangleMeshShape_calculateSerializeBufferSize" 'function)) :int
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btBvhTriangleMeshShape_calculateSerializeBufferSize" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btBvhTriangleMeshShape_serialize" 'function)))

(cffi:defcfun ("_wrap_btBvhTriangleMeshShape_serialize" #.(bullet-wrap::swig-lispify "btBvhTriangleMeshShape_serialize" 'function)) :string
  (self :pointer)
  (dataBuffer :pointer)
  (serializer :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btBvhTriangleMeshShape_serialize" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btBvhTriangleMeshShape_serializeSingleBvh" 'function)))

(cffi:defcfun ("_wrap_btBvhTriangleMeshShape_serializeSingleBvh" #.(bullet-wrap::swig-lispify "btBvhTriangleMeshShape_serializeSingleBvh" 'function)) :void
  (self :pointer)
  (serializer :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btBvhTriangleMeshShape_serializeSingleBvh" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btBvhTriangleMeshShape_serializeSingleTriangleInfoMap" 'function)))

(cffi:defcfun ("_wrap_btBvhTriangleMeshShape_serializeSingleTriangleInfoMap" #.(bullet-wrap::swig-lispify "btBvhTriangleMeshShape_serializeSingleTriangleInfoMap" 'function)) :void
  (self :pointer)
  (serializer :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btBvhTriangleMeshShape_serializeSingleTriangleInfoMap" 'function))

(cffi:defcstruct #.(bullet-wrap::swig-lispify "btTriangleMeshShapeData" 'classname)
	(#.(bullet-wrap::swig-lispify "m_collisionShapeData" 'slotname) :pointer)
	(#.(bullet-wrap::swig-lispify "m_meshInterface" 'slotname) :pointer)
	(#.(bullet-wrap::swig-lispify "m_quantizedFloatBvh" 'slotname) :pointer)
	(#.(bullet-wrap::swig-lispify "m_quantizedDoubleBvh" 'slotname) :pointer)
	(#.(bullet-wrap::swig-lispify "m_triangleInfoMap" 'slotname) :pointer)
	(#.(bullet-wrap::swig-lispify "m_collisionMargin" 'slotname) :float)
	(#.(bullet-wrap::swig-lispify "m_pad3" 'slotname) :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btTriangleMeshShapeData" 'classname))

(cl:export '#.(bullet-wrap::swig-lispify "m_collisionShapeData" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_meshInterface" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_quantizedFloatBvh" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_quantizedDoubleBvh" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_triangleInfoMap" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_collisionMargin" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_pad3" 'slotname))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btScaledBvhTriangleMeshShape_makeCPlusPlusInstance" 'function)))

(cffi:defcfun ("_wrap_btScaledBvhTriangleMeshShape_makeCPlusPlusInstance__SWIG_0" #.(bullet-wrap::swig-lispify "btScaledBvhTriangleMeshShape_makeCPlusPlusInstance" 'function)) :pointer
  (self :pointer)
  (sizeInBytes :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btScaledBvhTriangleMeshShape_makeCPlusPlusInstance" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btScaledBvhTriangleMeshShape_deleteCPlusPlusInstance" 'function)))

(cffi:defcfun ("_wrap_btScaledBvhTriangleMeshShape_deleteCPlusPlusInstance__SWIG_0" #.(bullet-wrap::swig-lispify "btScaledBvhTriangleMeshShape_deleteCPlusPlusInstance" 'function)) :void
  (self :pointer)
  (ptr :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btScaledBvhTriangleMeshShape_deleteCPlusPlusInstance" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btScaledBvhTriangleMeshShape_makeCPlusPlusInstance" 'function)))

(cffi:defcfun ("_wrap_btScaledBvhTriangleMeshShape_makeCPlusPlusInstance__SWIG_1" #.(bullet-wrap::swig-lispify "btScaledBvhTriangleMeshShape_makeCPlusPlusInstance" 'function)) :pointer
  (self :pointer)
  (arg1 :pointer)
  (ptr :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btScaledBvhTriangleMeshShape_makeCPlusPlusInstance" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btScaledBvhTriangleMeshShape_deleteCPlusPlusInstance" 'function)))

(cffi:defcfun ("_wrap_btScaledBvhTriangleMeshShape_deleteCPlusPlusInstance__SWIG_1" #.(bullet-wrap::swig-lispify "btScaledBvhTriangleMeshShape_deleteCPlusPlusInstance" 'function)) :void
  (self :pointer)
  (arg1 :pointer)
  (arg2 :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btScaledBvhTriangleMeshShape_deleteCPlusPlusInstance" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btScaledBvhTriangleMeshShape_makeCPlusArray" 'function)))

(cffi:defcfun ("_wrap_btScaledBvhTriangleMeshShape_makeCPlusArray__SWIG_0" #.(bullet-wrap::swig-lispify "btScaledBvhTriangleMeshShape_makeCPlusArray" 'function)) :pointer
  (self :pointer)
  (sizeInBytes :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btScaledBvhTriangleMeshShape_makeCPlusArray" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btScaledBvhTriangleMeshShape_deleteCPlusArray" 'function)))

(cffi:defcfun ("_wrap_btScaledBvhTriangleMeshShape_deleteCPlusArray__SWIG_0" #.(bullet-wrap::swig-lispify "btScaledBvhTriangleMeshShape_deleteCPlusArray" 'function)) :void
  (self :pointer)
  (ptr :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btScaledBvhTriangleMeshShape_deleteCPlusArray" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btScaledBvhTriangleMeshShape_makeCPlusArray" 'function)))

(cffi:defcfun ("_wrap_btScaledBvhTriangleMeshShape_makeCPlusArray__SWIG_1" #.(bullet-wrap::swig-lispify "btScaledBvhTriangleMeshShape_makeCPlusArray" 'function)) :pointer
  (self :pointer)
  (arg1 :pointer)
  (ptr :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btScaledBvhTriangleMeshShape_makeCPlusArray" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btScaledBvhTriangleMeshShape_deleteCPlusArray" 'function)))

(cffi:defcfun ("_wrap_btScaledBvhTriangleMeshShape_deleteCPlusArray__SWIG_1" #.(bullet-wrap::swig-lispify "btScaledBvhTriangleMeshShape_deleteCPlusArray" 'function)) :void
  (self :pointer)
  (arg1 :pointer)
  (arg2 :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btScaledBvhTriangleMeshShape_deleteCPlusArray" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "new_btScaledBvhTriangleMeshShape" 'function)))

(cffi:defcfun ("_wrap_new_btScaledBvhTriangleMeshShape" #.(bullet-wrap::swig-lispify "new_btScaledBvhTriangleMeshShape" 'function)) :pointer
  (childShape :pointer)
  (localScaling :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "new_btScaledBvhTriangleMeshShape" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "delete_btScaledBvhTriangleMeshShape" 'function)))

(cffi:defcfun ("_wrap_delete_btScaledBvhTriangleMeshShape" #.(bullet-wrap::swig-lispify "delete_btScaledBvhTriangleMeshShape" 'function)) :void
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "delete_btScaledBvhTriangleMeshShape" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btScaledBvhTriangleMeshShape_getAabb" 'function)))

(cffi:defcfun ("_wrap_btScaledBvhTriangleMeshShape_getAabb" #.(bullet-wrap::swig-lispify "btScaledBvhTriangleMeshShape_getAabb" 'function)) :void
  (self :pointer)
  (t_arg1 :pointer)
  (aabbMin :pointer)
  (aabbMax :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btScaledBvhTriangleMeshShape_getAabb" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btScaledBvhTriangleMeshShape_setLocalScaling" 'function)))

(cffi:defcfun ("_wrap_btScaledBvhTriangleMeshShape_setLocalScaling" #.(bullet-wrap::swig-lispify "btScaledBvhTriangleMeshShape_setLocalScaling" 'function)) :void
  (self :pointer)
  (scaling :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btScaledBvhTriangleMeshShape_setLocalScaling" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btScaledBvhTriangleMeshShape_getLocalScaling" 'function)))

(cffi:defcfun ("_wrap_btScaledBvhTriangleMeshShape_getLocalScaling" #.(bullet-wrap::swig-lispify "btScaledBvhTriangleMeshShape_getLocalScaling" 'function)) :pointer
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btScaledBvhTriangleMeshShape_getLocalScaling" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btScaledBvhTriangleMeshShape_calculateLocalInertia" 'function)))

(cffi:defcfun ("_wrap_btScaledBvhTriangleMeshShape_calculateLocalInertia" #.(bullet-wrap::swig-lispify "btScaledBvhTriangleMeshShape_calculateLocalInertia" 'function)) :void
  (self :pointer)
  (mass :float)
  (inertia :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btScaledBvhTriangleMeshShape_calculateLocalInertia" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btScaledBvhTriangleMeshShape_processAllTriangles" 'function)))

(cffi:defcfun ("_wrap_btScaledBvhTriangleMeshShape_processAllTriangles" #.(bullet-wrap::swig-lispify "btScaledBvhTriangleMeshShape_processAllTriangles" 'function)) :void
  (self :pointer)
  (callback :pointer)
  (aabbMin :pointer)
  (aabbMax :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btScaledBvhTriangleMeshShape_processAllTriangles" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btScaledBvhTriangleMeshShape_getChildShape" 'function)))

(cffi:defcfun ("_wrap_btScaledBvhTriangleMeshShape_getChildShape__SWIG_0" #.(bullet-wrap::swig-lispify "btScaledBvhTriangleMeshShape_getChildShape" 'function)) :pointer
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btScaledBvhTriangleMeshShape_getChildShape" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btScaledBvhTriangleMeshShape_getChildShape" 'function)))

(cffi:defcfun ("_wrap_btScaledBvhTriangleMeshShape_getChildShape__SWIG_1" #.(bullet-wrap::swig-lispify "btScaledBvhTriangleMeshShape_getChildShape" 'function)) :pointer
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btScaledBvhTriangleMeshShape_getChildShape" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btScaledBvhTriangleMeshShape_getName" 'function)))

(cffi:defcfun ("_wrap_btScaledBvhTriangleMeshShape_getName" #.(bullet-wrap::swig-lispify "btScaledBvhTriangleMeshShape_getName" 'function)) :string
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btScaledBvhTriangleMeshShape_getName" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btScaledBvhTriangleMeshShape_calculateSerializeBufferSize" 'function)))

(cffi:defcfun ("_wrap_btScaledBvhTriangleMeshShape_calculateSerializeBufferSize" #.(bullet-wrap::swig-lispify "btScaledBvhTriangleMeshShape_calculateSerializeBufferSize" 'function)) :int
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btScaledBvhTriangleMeshShape_calculateSerializeBufferSize" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btScaledBvhTriangleMeshShape_serialize" 'function)))

(cffi:defcfun ("_wrap_btScaledBvhTriangleMeshShape_serialize" #.(bullet-wrap::swig-lispify "btScaledBvhTriangleMeshShape_serialize" 'function)) :string
  (self :pointer)
  (dataBuffer :pointer)
  (serializer :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btScaledBvhTriangleMeshShape_serialize" 'function))

(cffi:defcstruct #.(bullet-wrap::swig-lispify "btScaledTriangleMeshShapeData" 'classname)
	(#.(bullet-wrap::swig-lispify "m_trimeshShapeData" 'slotname) #.(bullet-wrap::swig-lispify "btTriangleMeshShapeData" 'classname))
	(#.(bullet-wrap::swig-lispify "m_localScaling" 'slotname) #.(bullet-wrap::swig-lispify "btVector3FloatData" 'classname)))

(cl:export '#.(bullet-wrap::swig-lispify "btScaledTriangleMeshShapeData" 'classname))

(cl:export '#.(bullet-wrap::swig-lispify "m_trimeshShapeData" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_localScaling" 'slotname))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btTriangleMeshShape_makeCPlusPlusInstance" 'function)))

(cffi:defcfun ("_wrap_btTriangleMeshShape_makeCPlusPlusInstance__SWIG_0" #.(bullet-wrap::swig-lispify "btTriangleMeshShape_makeCPlusPlusInstance" 'function)) :pointer
  (self :pointer)
  (sizeInBytes :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btTriangleMeshShape_makeCPlusPlusInstance" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btTriangleMeshShape_deleteCPlusPlusInstance" 'function)))

(cffi:defcfun ("_wrap_btTriangleMeshShape_deleteCPlusPlusInstance__SWIG_0" #.(bullet-wrap::swig-lispify "btTriangleMeshShape_deleteCPlusPlusInstance" 'function)) :void
  (self :pointer)
  (ptr :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btTriangleMeshShape_deleteCPlusPlusInstance" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btTriangleMeshShape_makeCPlusPlusInstance" 'function)))

(cffi:defcfun ("_wrap_btTriangleMeshShape_makeCPlusPlusInstance__SWIG_1" #.(bullet-wrap::swig-lispify "btTriangleMeshShape_makeCPlusPlusInstance" 'function)) :pointer
  (self :pointer)
  (arg1 :pointer)
  (ptr :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btTriangleMeshShape_makeCPlusPlusInstance" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btTriangleMeshShape_deleteCPlusPlusInstance" 'function)))

(cffi:defcfun ("_wrap_btTriangleMeshShape_deleteCPlusPlusInstance__SWIG_1" #.(bullet-wrap::swig-lispify "btTriangleMeshShape_deleteCPlusPlusInstance" 'function)) :void
  (self :pointer)
  (arg1 :pointer)
  (arg2 :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btTriangleMeshShape_deleteCPlusPlusInstance" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btTriangleMeshShape_makeCPlusArray" 'function)))

(cffi:defcfun ("_wrap_btTriangleMeshShape_makeCPlusArray__SWIG_0" #.(bullet-wrap::swig-lispify "btTriangleMeshShape_makeCPlusArray" 'function)) :pointer
  (self :pointer)
  (sizeInBytes :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btTriangleMeshShape_makeCPlusArray" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btTriangleMeshShape_deleteCPlusArray" 'function)))

(cffi:defcfun ("_wrap_btTriangleMeshShape_deleteCPlusArray__SWIG_0" #.(bullet-wrap::swig-lispify "btTriangleMeshShape_deleteCPlusArray" 'function)) :void
  (self :pointer)
  (ptr :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btTriangleMeshShape_deleteCPlusArray" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btTriangleMeshShape_makeCPlusArray" 'function)))

(cffi:defcfun ("_wrap_btTriangleMeshShape_makeCPlusArray__SWIG_1" #.(bullet-wrap::swig-lispify "btTriangleMeshShape_makeCPlusArray" 'function)) :pointer
  (self :pointer)
  (arg1 :pointer)
  (ptr :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btTriangleMeshShape_makeCPlusArray" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btTriangleMeshShape_deleteCPlusArray" 'function)))

(cffi:defcfun ("_wrap_btTriangleMeshShape_deleteCPlusArray__SWIG_1" #.(bullet-wrap::swig-lispify "btTriangleMeshShape_deleteCPlusArray" 'function)) :void
  (self :pointer)
  (arg1 :pointer)
  (arg2 :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btTriangleMeshShape_deleteCPlusArray" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "delete_btTriangleMeshShape" 'function)))

(cffi:defcfun ("_wrap_delete_btTriangleMeshShape" #.(bullet-wrap::swig-lispify "delete_btTriangleMeshShape" 'function)) :void
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "delete_btTriangleMeshShape" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btTriangleMeshShape_localGetSupportingVertex" 'function)))

(cffi:defcfun ("_wrap_btTriangleMeshShape_localGetSupportingVertex" #.(bullet-wrap::swig-lispify "btTriangleMeshShape_localGetSupportingVertex" 'function)) :pointer
  (self :pointer)
  (vec :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btTriangleMeshShape_localGetSupportingVertex" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btTriangleMeshShape_localGetSupportingVertexWithoutMargin" 'function)))

(cffi:defcfun ("_wrap_btTriangleMeshShape_localGetSupportingVertexWithoutMargin" #.(bullet-wrap::swig-lispify "btTriangleMeshShape_localGetSupportingVertexWithoutMargin" 'function)) :pointer
  (self :pointer)
  (vec :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btTriangleMeshShape_localGetSupportingVertexWithoutMargin" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btTriangleMeshShape_recalcLocalAabb" 'function)))

(cffi:defcfun ("_wrap_btTriangleMeshShape_recalcLocalAabb" #.(bullet-wrap::swig-lispify "btTriangleMeshShape_recalcLocalAabb" 'function)) :void
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btTriangleMeshShape_recalcLocalAabb" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btTriangleMeshShape_getAabb" 'function)))

(cffi:defcfun ("_wrap_btTriangleMeshShape_getAabb" #.(bullet-wrap::swig-lispify "btTriangleMeshShape_getAabb" 'function)) :void
  (self :pointer)
  (t_arg1 :pointer)
  (aabbMin :pointer)
  (aabbMax :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btTriangleMeshShape_getAabb" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btTriangleMeshShape_processAllTriangles" 'function)))

(cffi:defcfun ("_wrap_btTriangleMeshShape_processAllTriangles" #.(bullet-wrap::swig-lispify "btTriangleMeshShape_processAllTriangles" 'function)) :void
  (self :pointer)
  (callback :pointer)
  (aabbMin :pointer)
  (aabbMax :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btTriangleMeshShape_processAllTriangles" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btTriangleMeshShape_calculateLocalInertia" 'function)))

(cffi:defcfun ("_wrap_btTriangleMeshShape_calculateLocalInertia" #.(bullet-wrap::swig-lispify "btTriangleMeshShape_calculateLocalInertia" 'function)) :void
  (self :pointer)
  (mass :float)
  (inertia :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btTriangleMeshShape_calculateLocalInertia" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btTriangleMeshShape_setLocalScaling" 'function)))

(cffi:defcfun ("_wrap_btTriangleMeshShape_setLocalScaling" #.(bullet-wrap::swig-lispify "btTriangleMeshShape_setLocalScaling" 'function)) :void
  (self :pointer)
  (scaling :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btTriangleMeshShape_setLocalScaling" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btTriangleMeshShape_getLocalScaling" 'function)))

(cffi:defcfun ("_wrap_btTriangleMeshShape_getLocalScaling" #.(bullet-wrap::swig-lispify "btTriangleMeshShape_getLocalScaling" 'function)) :pointer
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btTriangleMeshShape_getLocalScaling" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btTriangleMeshShape_getMeshInterface" 'function)))

(cffi:defcfun ("_wrap_btTriangleMeshShape_getMeshInterface__SWIG_0" #.(bullet-wrap::swig-lispify "btTriangleMeshShape_getMeshInterface" 'function)) :pointer
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btTriangleMeshShape_getMeshInterface" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btTriangleMeshShape_getMeshInterface" 'function)))

(cffi:defcfun ("_wrap_btTriangleMeshShape_getMeshInterface__SWIG_1" #.(bullet-wrap::swig-lispify "btTriangleMeshShape_getMeshInterface" 'function)) :pointer
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btTriangleMeshShape_getMeshInterface" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btTriangleMeshShape_getLocalAabbMin" 'function)))

(cffi:defcfun ("_wrap_btTriangleMeshShape_getLocalAabbMin" #.(bullet-wrap::swig-lispify "btTriangleMeshShape_getLocalAabbMin" 'function)) :pointer
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btTriangleMeshShape_getLocalAabbMin" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btTriangleMeshShape_getLocalAabbMax" 'function)))

(cffi:defcfun ("_wrap_btTriangleMeshShape_getLocalAabbMax" #.(bullet-wrap::swig-lispify "btTriangleMeshShape_getLocalAabbMax" 'function)) :pointer
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btTriangleMeshShape_getLocalAabbMax" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btTriangleMeshShape_getName" 'function)))

(cffi:defcfun ("_wrap_btTriangleMeshShape_getName" #.(bullet-wrap::swig-lispify "btTriangleMeshShape_getName" 'function)) :string
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btTriangleMeshShape_getName" 'function))

(cffi:defcstruct #.(bullet-wrap::swig-lispify "btIndexedMesh" 'classname)
	(#.(bullet-wrap::swig-lispify "makeCPlusPlusInstance" 'slotname) :pointer)
	(#.(bullet-wrap::swig-lispify "deleteCPlusPlusInstance" 'slotname) :pointer)
	(#.(bullet-wrap::swig-lispify "makeCPlusPlusInstance" 'slotname) :pointer)
	(#.(bullet-wrap::swig-lispify "deleteCPlusPlusInstance" 'slotname) :pointer)
	(#.(bullet-wrap::swig-lispify "makeCPlusArray" 'slotname) :pointer)
	(#.(bullet-wrap::swig-lispify "deleteCPlusArray" 'slotname) :pointer)
	(#.(bullet-wrap::swig-lispify "makeCPlusArray" 'slotname) :pointer)
	(#.(bullet-wrap::swig-lispify "deleteCPlusArray" 'slotname) :pointer)
	(#.(bullet-wrap::swig-lispify "m_numTriangles" 'slotname) :int)
	(#.(bullet-wrap::swig-lispify "m_triangleIndexBase" 'slotname) :pointer)
	(#.(bullet-wrap::swig-lispify "m_triangleIndexStride" 'slotname) :int)
	(#.(bullet-wrap::swig-lispify "m_numVertices" 'slotname) :int)
	(#.(bullet-wrap::swig-lispify "m_vertexBase" 'slotname) :pointer)
	(#.(bullet-wrap::swig-lispify "m_vertexStride" 'slotname) :int)
	(#.(bullet-wrap::swig-lispify "m_indexType" 'slotname) :pointer)
	(#.(bullet-wrap::swig-lispify "m_vertexType" 'slotname) :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btIndexedMesh" 'classname))

(cl:export '#.(bullet-wrap::swig-lispify "makeCPlusPlusInstance" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "deleteCPlusPlusInstance" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "makeCPlusPlusInstance" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "deleteCPlusPlusInstance" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "makeCPlusArray" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "deleteCPlusArray" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "makeCPlusArray" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "deleteCPlusArray" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_numTriangles" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_triangleIndexBase" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_triangleIndexStride" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_numVertices" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_vertexBase" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_vertexStride" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_indexType" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_vertexType" 'slotname))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btTriangleIndexVertexArray_makeCPlusPlusInstance" 'function)))

(cffi:defcfun ("_wrap_btTriangleIndexVertexArray_makeCPlusPlusInstance__SWIG_0" #.(bullet-wrap::swig-lispify "btTriangleIndexVertexArray_makeCPlusPlusInstance" 'function)) :pointer
  (self :pointer)
  (sizeInBytes :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btTriangleIndexVertexArray_makeCPlusPlusInstance" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btTriangleIndexVertexArray_deleteCPlusPlusInstance" 'function)))

(cffi:defcfun ("_wrap_btTriangleIndexVertexArray_deleteCPlusPlusInstance__SWIG_0" #.(bullet-wrap::swig-lispify "btTriangleIndexVertexArray_deleteCPlusPlusInstance" 'function)) :void
  (self :pointer)
  (ptr :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btTriangleIndexVertexArray_deleteCPlusPlusInstance" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btTriangleIndexVertexArray_makeCPlusPlusInstance" 'function)))

(cffi:defcfun ("_wrap_btTriangleIndexVertexArray_makeCPlusPlusInstance__SWIG_1" #.(bullet-wrap::swig-lispify "btTriangleIndexVertexArray_makeCPlusPlusInstance" 'function)) :pointer
  (self :pointer)
  (arg1 :pointer)
  (ptr :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btTriangleIndexVertexArray_makeCPlusPlusInstance" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btTriangleIndexVertexArray_deleteCPlusPlusInstance" 'function)))

(cffi:defcfun ("_wrap_btTriangleIndexVertexArray_deleteCPlusPlusInstance__SWIG_1" #.(bullet-wrap::swig-lispify "btTriangleIndexVertexArray_deleteCPlusPlusInstance" 'function)) :void
  (self :pointer)
  (arg1 :pointer)
  (arg2 :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btTriangleIndexVertexArray_deleteCPlusPlusInstance" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btTriangleIndexVertexArray_makeCPlusArray" 'function)))

(cffi:defcfun ("_wrap_btTriangleIndexVertexArray_makeCPlusArray__SWIG_0" #.(bullet-wrap::swig-lispify "btTriangleIndexVertexArray_makeCPlusArray" 'function)) :pointer
  (self :pointer)
  (sizeInBytes :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btTriangleIndexVertexArray_makeCPlusArray" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btTriangleIndexVertexArray_deleteCPlusArray" 'function)))

(cffi:defcfun ("_wrap_btTriangleIndexVertexArray_deleteCPlusArray__SWIG_0" #.(bullet-wrap::swig-lispify "btTriangleIndexVertexArray_deleteCPlusArray" 'function)) :void
  (self :pointer)
  (ptr :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btTriangleIndexVertexArray_deleteCPlusArray" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btTriangleIndexVertexArray_makeCPlusArray" 'function)))

(cffi:defcfun ("_wrap_btTriangleIndexVertexArray_makeCPlusArray__SWIG_1" #.(bullet-wrap::swig-lispify "btTriangleIndexVertexArray_makeCPlusArray" 'function)) :pointer
  (self :pointer)
  (arg1 :pointer)
  (ptr :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btTriangleIndexVertexArray_makeCPlusArray" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btTriangleIndexVertexArray_deleteCPlusArray" 'function)))

(cffi:defcfun ("_wrap_btTriangleIndexVertexArray_deleteCPlusArray__SWIG_1" #.(bullet-wrap::swig-lispify "btTriangleIndexVertexArray_deleteCPlusArray" 'function)) :void
  (self :pointer)
  (arg1 :pointer)
  (arg2 :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btTriangleIndexVertexArray_deleteCPlusArray" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "new_btTriangleIndexVertexArray" 'function)))

(cffi:defcfun ("_wrap_new_btTriangleIndexVertexArray__SWIG_0" #.(bullet-wrap::swig-lispify "new_btTriangleIndexVertexArray" 'function)) :pointer)

(cl:export '#.(bullet-wrap::swig-lispify "new_btTriangleIndexVertexArray" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "delete_btTriangleIndexVertexArray" 'function)))

(cffi:defcfun ("_wrap_delete_btTriangleIndexVertexArray" #.(bullet-wrap::swig-lispify "delete_btTriangleIndexVertexArray" 'function)) :void
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "delete_btTriangleIndexVertexArray" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "new_btTriangleIndexVertexArray" 'function)))

(cffi:defcfun ("_wrap_new_btTriangleIndexVertexArray__SWIG_1" #.(bullet-wrap::swig-lispify "new_btTriangleIndexVertexArray" 'function)) :pointer
  (numTriangles :int)
  (triangleIndexBase :pointer)
  (triangleIndexStride :int)
  (numVertices :int)
  (vertexBase :pointer)
  (vertexStride :int))

(cl:export '#.(bullet-wrap::swig-lispify "new_btTriangleIndexVertexArray" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btTriangleIndexVertexArray_addIndexedMesh" 'function)))

(cffi:defcfun ("_wrap_btTriangleIndexVertexArray_addIndexedMesh__SWIG_0" #.(bullet-wrap::swig-lispify "btTriangleIndexVertexArray_addIndexedMesh" 'function)) :void
  (self :pointer)
  (mesh :pointer)
  (indexType :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btTriangleIndexVertexArray_addIndexedMesh" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btTriangleIndexVertexArray_addIndexedMesh" 'function)))

(cffi:defcfun ("_wrap_btTriangleIndexVertexArray_addIndexedMesh__SWIG_1" #.(bullet-wrap::swig-lispify "btTriangleIndexVertexArray_addIndexedMesh" 'function)) :void
  (self :pointer)
  (mesh :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btTriangleIndexVertexArray_addIndexedMesh" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btTriangleIndexVertexArray_getLockedVertexIndexBase" 'function)))

(cffi:defcfun ("_wrap_btTriangleIndexVertexArray_getLockedVertexIndexBase__SWIG_0" #.(bullet-wrap::swig-lispify "btTriangleIndexVertexArray_getLockedVertexIndexBase" 'function)) :void
  (self :pointer)
  (vertexbase :pointer)
  (numverts :pointer)
  (type :pointer)
  (vertexStride :pointer)
  (indexbase :pointer)
  (indexstride :pointer)
  (numfaces :pointer)
  (indicestype :pointer)
  (subpart :int))

(cl:export '#.(bullet-wrap::swig-lispify "btTriangleIndexVertexArray_getLockedVertexIndexBase" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btTriangleIndexVertexArray_getLockedVertexIndexBase" 'function)))

(cffi:defcfun ("_wrap_btTriangleIndexVertexArray_getLockedVertexIndexBase__SWIG_1" #.(bullet-wrap::swig-lispify "btTriangleIndexVertexArray_getLockedVertexIndexBase" 'function)) :void
  (self :pointer)
  (vertexbase :pointer)
  (numverts :pointer)
  (type :pointer)
  (vertexStride :pointer)
  (indexbase :pointer)
  (indexstride :pointer)
  (numfaces :pointer)
  (indicestype :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btTriangleIndexVertexArray_getLockedVertexIndexBase" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btTriangleIndexVertexArray_getLockedReadOnlyVertexIndexBase" 'function)))

(cffi:defcfun ("_wrap_btTriangleIndexVertexArray_getLockedReadOnlyVertexIndexBase__SWIG_0" #.(bullet-wrap::swig-lispify "btTriangleIndexVertexArray_getLockedReadOnlyVertexIndexBase" 'function)) :void
  (self :pointer)
  (vertexbase :pointer)
  (numverts :pointer)
  (type :pointer)
  (vertexStride :pointer)
  (indexbase :pointer)
  (indexstride :pointer)
  (numfaces :pointer)
  (indicestype :pointer)
  (subpart :int))

(cl:export '#.(bullet-wrap::swig-lispify "btTriangleIndexVertexArray_getLockedReadOnlyVertexIndexBase" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btTriangleIndexVertexArray_getLockedReadOnlyVertexIndexBase" 'function)))

(cffi:defcfun ("_wrap_btTriangleIndexVertexArray_getLockedReadOnlyVertexIndexBase__SWIG_1" #.(bullet-wrap::swig-lispify "btTriangleIndexVertexArray_getLockedReadOnlyVertexIndexBase" 'function)) :void
  (self :pointer)
  (vertexbase :pointer)
  (numverts :pointer)
  (type :pointer)
  (vertexStride :pointer)
  (indexbase :pointer)
  (indexstride :pointer)
  (numfaces :pointer)
  (indicestype :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btTriangleIndexVertexArray_getLockedReadOnlyVertexIndexBase" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btTriangleIndexVertexArray_unLockVertexBase" 'function)))

(cffi:defcfun ("_wrap_btTriangleIndexVertexArray_unLockVertexBase" #.(bullet-wrap::swig-lispify "btTriangleIndexVertexArray_unLockVertexBase" 'function)) :void
  (self :pointer)
  (subpart :int))

(cl:export '#.(bullet-wrap::swig-lispify "btTriangleIndexVertexArray_unLockVertexBase" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btTriangleIndexVertexArray_unLockReadOnlyVertexBase" 'function)))

(cffi:defcfun ("_wrap_btTriangleIndexVertexArray_unLockReadOnlyVertexBase" #.(bullet-wrap::swig-lispify "btTriangleIndexVertexArray_unLockReadOnlyVertexBase" 'function)) :void
  (self :pointer)
  (subpart :int))

(cl:export '#.(bullet-wrap::swig-lispify "btTriangleIndexVertexArray_unLockReadOnlyVertexBase" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btTriangleIndexVertexArray_getNumSubParts" 'function)))

(cffi:defcfun ("_wrap_btTriangleIndexVertexArray_getNumSubParts" #.(bullet-wrap::swig-lispify "btTriangleIndexVertexArray_getNumSubParts" 'function)) :int
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btTriangleIndexVertexArray_getNumSubParts" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btTriangleIndexVertexArray_getIndexedMeshArray" 'function)))

(cffi:defcfun ("_wrap_btTriangleIndexVertexArray_getIndexedMeshArray__SWIG_0" #.(bullet-wrap::swig-lispify "btTriangleIndexVertexArray_getIndexedMeshArray" 'function)) :pointer
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btTriangleIndexVertexArray_getIndexedMeshArray" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btTriangleIndexVertexArray_getIndexedMeshArray" 'function)))

(cffi:defcfun ("_wrap_btTriangleIndexVertexArray_getIndexedMeshArray__SWIG_1" #.(bullet-wrap::swig-lispify "btTriangleIndexVertexArray_getIndexedMeshArray" 'function)) :pointer
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btTriangleIndexVertexArray_getIndexedMeshArray" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btTriangleIndexVertexArray_preallocateVertices" 'function)))

(cffi:defcfun ("_wrap_btTriangleIndexVertexArray_preallocateVertices" #.(bullet-wrap::swig-lispify "btTriangleIndexVertexArray_preallocateVertices" 'function)) :void
  (self :pointer)
  (numverts :int))

(cl:export '#.(bullet-wrap::swig-lispify "btTriangleIndexVertexArray_preallocateVertices" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btTriangleIndexVertexArray_preallocateIndices" 'function)))

(cffi:defcfun ("_wrap_btTriangleIndexVertexArray_preallocateIndices" #.(bullet-wrap::swig-lispify "btTriangleIndexVertexArray_preallocateIndices" 'function)) :void
  (self :pointer)
  (numindices :int))

(cl:export '#.(bullet-wrap::swig-lispify "btTriangleIndexVertexArray_preallocateIndices" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btTriangleIndexVertexArray_hasPremadeAabb" 'function)))

(cffi:defcfun ("_wrap_btTriangleIndexVertexArray_hasPremadeAabb" #.(bullet-wrap::swig-lispify "btTriangleIndexVertexArray_hasPremadeAabb" 'function)) :pointer
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btTriangleIndexVertexArray_hasPremadeAabb" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btTriangleIndexVertexArray_setPremadeAabb" 'function)))

(cffi:defcfun ("_wrap_btTriangleIndexVertexArray_setPremadeAabb" #.(bullet-wrap::swig-lispify "btTriangleIndexVertexArray_setPremadeAabb" 'function)) :void
  (self :pointer)
  (aabbMin :pointer)
  (aabbMax :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btTriangleIndexVertexArray_setPremadeAabb" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btTriangleIndexVertexArray_getPremadeAabb" 'function)))

(cffi:defcfun ("_wrap_btTriangleIndexVertexArray_getPremadeAabb" #.(bullet-wrap::swig-lispify "btTriangleIndexVertexArray_getPremadeAabb" 'function)) :void
  (self :pointer)
  (aabbMin :pointer)
  (aabbMax :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btTriangleIndexVertexArray_getPremadeAabb" 'function))

(cffi:defcstruct #.(bullet-wrap::swig-lispify "btCompoundShapeChild" 'classname)
	(#.(bullet-wrap::swig-lispify "makeCPlusPlusInstance" 'slotname) :pointer)
	(#.(bullet-wrap::swig-lispify "deleteCPlusPlusInstance" 'slotname) :pointer)
	(#.(bullet-wrap::swig-lispify "makeCPlusPlusInstance" 'slotname) :pointer)
	(#.(bullet-wrap::swig-lispify "deleteCPlusPlusInstance" 'slotname) :pointer)
	(#.(bullet-wrap::swig-lispify "makeCPlusArray" 'slotname) :pointer)
	(#.(bullet-wrap::swig-lispify "deleteCPlusArray" 'slotname) :pointer)
	(#.(bullet-wrap::swig-lispify "makeCPlusArray" 'slotname) :pointer)
	(#.(bullet-wrap::swig-lispify "deleteCPlusArray" 'slotname) :pointer)
	(#.(bullet-wrap::swig-lispify "m_transform" 'slotname) :pointer)
	(#.(bullet-wrap::swig-lispify "m_childShape" 'slotname) :pointer)
	(#.(bullet-wrap::swig-lispify "m_childShapeType" 'slotname) :int)
	(#.(bullet-wrap::swig-lispify "m_childMargin" 'slotname) :float)
	(#.(bullet-wrap::swig-lispify "m_node" 'slotname) :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btCompoundShapeChild" 'classname))

(cl:export '#.(bullet-wrap::swig-lispify "makeCPlusPlusInstance" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "deleteCPlusPlusInstance" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "makeCPlusPlusInstance" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "deleteCPlusPlusInstance" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "makeCPlusArray" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "deleteCPlusArray" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "makeCPlusArray" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "deleteCPlusArray" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_transform" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_childShape" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_childShapeType" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_childMargin" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_node" 'slotname))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCompoundShape_makeCPlusPlusInstance" 'function)))

(cffi:defcfun ("_wrap_btCompoundShape_makeCPlusPlusInstance__SWIG_0" #.(bullet-wrap::swig-lispify "btCompoundShape_makeCPlusPlusInstance" 'function)) :pointer
  (self :pointer)
  (sizeInBytes :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btCompoundShape_makeCPlusPlusInstance" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCompoundShape_deleteCPlusPlusInstance" 'function)))

(cffi:defcfun ("_wrap_btCompoundShape_deleteCPlusPlusInstance__SWIG_0" #.(bullet-wrap::swig-lispify "btCompoundShape_deleteCPlusPlusInstance" 'function)) :void
  (self :pointer)
  (ptr :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btCompoundShape_deleteCPlusPlusInstance" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCompoundShape_makeCPlusPlusInstance" 'function)))

(cffi:defcfun ("_wrap_btCompoundShape_makeCPlusPlusInstance__SWIG_1" #.(bullet-wrap::swig-lispify "btCompoundShape_makeCPlusPlusInstance" 'function)) :pointer
  (self :pointer)
  (arg1 :pointer)
  (ptr :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btCompoundShape_makeCPlusPlusInstance" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCompoundShape_deleteCPlusPlusInstance" 'function)))

(cffi:defcfun ("_wrap_btCompoundShape_deleteCPlusPlusInstance__SWIG_1" #.(bullet-wrap::swig-lispify "btCompoundShape_deleteCPlusPlusInstance" 'function)) :void
  (self :pointer)
  (arg1 :pointer)
  (arg2 :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btCompoundShape_deleteCPlusPlusInstance" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCompoundShape_makeCPlusArray" 'function)))

(cffi:defcfun ("_wrap_btCompoundShape_makeCPlusArray__SWIG_0" #.(bullet-wrap::swig-lispify "btCompoundShape_makeCPlusArray" 'function)) :pointer
  (self :pointer)
  (sizeInBytes :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btCompoundShape_makeCPlusArray" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCompoundShape_deleteCPlusArray" 'function)))

(cffi:defcfun ("_wrap_btCompoundShape_deleteCPlusArray__SWIG_0" #.(bullet-wrap::swig-lispify "btCompoundShape_deleteCPlusArray" 'function)) :void
  (self :pointer)
  (ptr :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btCompoundShape_deleteCPlusArray" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCompoundShape_makeCPlusArray" 'function)))

(cffi:defcfun ("_wrap_btCompoundShape_makeCPlusArray__SWIG_1" #.(bullet-wrap::swig-lispify "btCompoundShape_makeCPlusArray" 'function)) :pointer
  (self :pointer)
  (arg1 :pointer)
  (ptr :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btCompoundShape_makeCPlusArray" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCompoundShape_deleteCPlusArray" 'function)))

(cffi:defcfun ("_wrap_btCompoundShape_deleteCPlusArray__SWIG_1" #.(bullet-wrap::swig-lispify "btCompoundShape_deleteCPlusArray" 'function)) :void
  (self :pointer)
  (arg1 :pointer)
  (arg2 :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btCompoundShape_deleteCPlusArray" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "new_btCompoundShape" 'function)))

(cffi:defcfun ("_wrap_new_btCompoundShape__SWIG_0" #.(bullet-wrap::swig-lispify "new_btCompoundShape" 'function)) :pointer
  (enableDynamicAabbTree :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "new_btCompoundShape" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "new_btCompoundShape" 'function)))

(cffi:defcfun ("_wrap_new_btCompoundShape__SWIG_1" #.(bullet-wrap::swig-lispify "new_btCompoundShape" 'function)) :pointer)

(cl:export '#.(bullet-wrap::swig-lispify "new_btCompoundShape" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "delete_btCompoundShape" 'function)))

(cffi:defcfun ("_wrap_delete_btCompoundShape" #.(bullet-wrap::swig-lispify "delete_btCompoundShape" 'function)) :void
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "delete_btCompoundShape" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCompoundShape_addChildShape" 'function)))

(cffi:defcfun ("_wrap_btCompoundShape_addChildShape" #.(bullet-wrap::swig-lispify "btCompoundShape_addChildShape" 'function)) :void
  (self :pointer)
  (localTransform :pointer)
  (shape :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btCompoundShape_addChildShape" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCompoundShape_removeChildShape" 'function)))

(cffi:defcfun ("_wrap_btCompoundShape_removeChildShape" #.(bullet-wrap::swig-lispify "btCompoundShape_removeChildShape" 'function)) :void
  (self :pointer)
  (shape :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btCompoundShape_removeChildShape" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCompoundShape_removeChildShapeByIndex" 'function)))

(cffi:defcfun ("_wrap_btCompoundShape_removeChildShapeByIndex" #.(bullet-wrap::swig-lispify "btCompoundShape_removeChildShapeByIndex" 'function)) :void
  (self :pointer)
  (childShapeindex :int))

(cl:export '#.(bullet-wrap::swig-lispify "btCompoundShape_removeChildShapeByIndex" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCompoundShape_getNumChildShapes" 'function)))

(cffi:defcfun ("_wrap_btCompoundShape_getNumChildShapes" #.(bullet-wrap::swig-lispify "btCompoundShape_getNumChildShapes" 'function)) :int
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btCompoundShape_getNumChildShapes" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCompoundShape_getChildShape" 'function)))

(cffi:defcfun ("_wrap_btCompoundShape_getChildShape__SWIG_0" #.(bullet-wrap::swig-lispify "btCompoundShape_getChildShape" 'function)) :pointer
  (self :pointer)
  (index :int))

(cl:export '#.(bullet-wrap::swig-lispify "btCompoundShape_getChildShape" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCompoundShape_getChildShape" 'function)))

(cffi:defcfun ("_wrap_btCompoundShape_getChildShape__SWIG_1" #.(bullet-wrap::swig-lispify "btCompoundShape_getChildShape" 'function)) :pointer
  (self :pointer)
  (index :int))

(cl:export '#.(bullet-wrap::swig-lispify "btCompoundShape_getChildShape" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCompoundShape_getChildTransform" 'function)))

(cffi:defcfun ("_wrap_btCompoundShape_getChildTransform__SWIG_0" #.(bullet-wrap::swig-lispify "btCompoundShape_getChildTransform" 'function)) :pointer
  (self :pointer)
  (index :int))

(cl:export '#.(bullet-wrap::swig-lispify "btCompoundShape_getChildTransform" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCompoundShape_getChildTransform" 'function)))

(cffi:defcfun ("_wrap_btCompoundShape_getChildTransform__SWIG_1" #.(bullet-wrap::swig-lispify "btCompoundShape_getChildTransform" 'function)) :pointer
  (self :pointer)
  (index :int))

(cl:export '#.(bullet-wrap::swig-lispify "btCompoundShape_getChildTransform" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCompoundShape_updateChildTransform" 'function)))

(cffi:defcfun ("_wrap_btCompoundShape_updateChildTransform__SWIG_0" #.(bullet-wrap::swig-lispify "btCompoundShape_updateChildTransform" 'function)) :void
  (self :pointer)
  (childIndex :int)
  (newChildTransform :pointer)
  (shouldRecalculateLocalAabb :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btCompoundShape_updateChildTransform" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCompoundShape_updateChildTransform" 'function)))

(cffi:defcfun ("_wrap_btCompoundShape_updateChildTransform__SWIG_1" #.(bullet-wrap::swig-lispify "btCompoundShape_updateChildTransform" 'function)) :void
  (self :pointer)
  (childIndex :int)
  (newChildTransform :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btCompoundShape_updateChildTransform" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCompoundShape_getChildList" 'function)))

(cffi:defcfun ("_wrap_btCompoundShape_getChildList" #.(bullet-wrap::swig-lispify "btCompoundShape_getChildList" 'function)) :pointer
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btCompoundShape_getChildList" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCompoundShape_getAabb" 'function)))

(cffi:defcfun ("_wrap_btCompoundShape_getAabb" #.(bullet-wrap::swig-lispify "btCompoundShape_getAabb" 'function)) :void
  (self :pointer)
  (t_arg1 :pointer)
  (aabbMin :pointer)
  (aabbMax :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btCompoundShape_getAabb" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCompoundShape_recalculateLocalAabb" 'function)))

(cffi:defcfun ("_wrap_btCompoundShape_recalculateLocalAabb" #.(bullet-wrap::swig-lispify "btCompoundShape_recalculateLocalAabb" 'function)) :void
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btCompoundShape_recalculateLocalAabb" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCompoundShape_setLocalScaling" 'function)))

(cffi:defcfun ("_wrap_btCompoundShape_setLocalScaling" #.(bullet-wrap::swig-lispify "btCompoundShape_setLocalScaling" 'function)) :void
  (self :pointer)
  (scaling :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btCompoundShape_setLocalScaling" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCompoundShape_getLocalScaling" 'function)))

(cffi:defcfun ("_wrap_btCompoundShape_getLocalScaling" #.(bullet-wrap::swig-lispify "btCompoundShape_getLocalScaling" 'function)) :pointer
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btCompoundShape_getLocalScaling" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCompoundShape_calculateLocalInertia" 'function)))

(cffi:defcfun ("_wrap_btCompoundShape_calculateLocalInertia" #.(bullet-wrap::swig-lispify "btCompoundShape_calculateLocalInertia" 'function)) :void
  (self :pointer)
  (mass :float)
  (inertia :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btCompoundShape_calculateLocalInertia" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCompoundShape_setMargin" 'function)))

(cffi:defcfun ("_wrap_btCompoundShape_setMargin" #.(bullet-wrap::swig-lispify "btCompoundShape_setMargin" 'function)) :void
  (self :pointer)
  (margin :float))

(cl:export '#.(bullet-wrap::swig-lispify "btCompoundShape_setMargin" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCompoundShape_getMargin" 'function)))

(cffi:defcfun ("_wrap_btCompoundShape_getMargin" #.(bullet-wrap::swig-lispify "btCompoundShape_getMargin" 'function)) :float
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btCompoundShape_getMargin" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCompoundShape_getName" 'function)))

(cffi:defcfun ("_wrap_btCompoundShape_getName" #.(bullet-wrap::swig-lispify "btCompoundShape_getName" 'function)) :string
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btCompoundShape_getName" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCompoundShape_getDynamicAabbTree" 'function)))

(cffi:defcfun ("_wrap_btCompoundShape_getDynamicAabbTree__SWIG_0" #.(bullet-wrap::swig-lispify "btCompoundShape_getDynamicAabbTree" 'function)) :pointer
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btCompoundShape_getDynamicAabbTree" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCompoundShape_getDynamicAabbTree" 'function)))

(cffi:defcfun ("_wrap_btCompoundShape_getDynamicAabbTree__SWIG_1" #.(bullet-wrap::swig-lispify "btCompoundShape_getDynamicAabbTree" 'function)) :pointer
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btCompoundShape_getDynamicAabbTree" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCompoundShape_createAabbTreeFromChildren" 'function)))

(cffi:defcfun ("_wrap_btCompoundShape_createAabbTreeFromChildren" #.(bullet-wrap::swig-lispify "btCompoundShape_createAabbTreeFromChildren" 'function)) :void
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btCompoundShape_createAabbTreeFromChildren" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCompoundShape_calculatePrincipalAxisTransform" 'function)))

(cffi:defcfun ("_wrap_btCompoundShape_calculatePrincipalAxisTransform" #.(bullet-wrap::swig-lispify "btCompoundShape_calculatePrincipalAxisTransform" 'function)) :void
  (self :pointer)
  (masses :pointer)
  (principal :pointer)
  (inertia :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btCompoundShape_calculatePrincipalAxisTransform" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCompoundShape_getUpdateRevision" 'function)))

(cffi:defcfun ("_wrap_btCompoundShape_getUpdateRevision" #.(bullet-wrap::swig-lispify "btCompoundShape_getUpdateRevision" 'function)) :int
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btCompoundShape_getUpdateRevision" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCompoundShape_calculateSerializeBufferSize" 'function)))

(cffi:defcfun ("_wrap_btCompoundShape_calculateSerializeBufferSize" #.(bullet-wrap::swig-lispify "btCompoundShape_calculateSerializeBufferSize" 'function)) :int
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btCompoundShape_calculateSerializeBufferSize" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCompoundShape_serialize" 'function)))

(cffi:defcfun ("_wrap_btCompoundShape_serialize" #.(bullet-wrap::swig-lispify "btCompoundShape_serialize" 'function)) :string
  (self :pointer)
  (dataBuffer :pointer)
  (serializer :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btCompoundShape_serialize" 'function))

(cffi:defcstruct #.(bullet-wrap::swig-lispify "btCompoundShapeChildData" 'classname)
	(#.(bullet-wrap::swig-lispify "m_transform" 'slotname) #.(bullet-wrap::swig-lispify "btTransformFloatData" 'classname))
	(#.(bullet-wrap::swig-lispify "m_childShape" 'slotname) :pointer)
	(#.(bullet-wrap::swig-lispify "m_childShapeType" 'slotname) :int)
	(#.(bullet-wrap::swig-lispify "m_childMargin" 'slotname) :float))

(cl:export '#.(bullet-wrap::swig-lispify "btCompoundShapeChildData" 'classname))

(cl:export '#.(bullet-wrap::swig-lispify "m_transform" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_childShape" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_childShapeType" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_childMargin" 'slotname))

(cffi:defcstruct #.(bullet-wrap::swig-lispify "btCompoundShapeData" 'classname)
	(#.(bullet-wrap::swig-lispify "m_collisionShapeData" 'slotname) :pointer)
	(#.(bullet-wrap::swig-lispify "m_childShapePtr" 'slotname) :pointer)
	(#.(bullet-wrap::swig-lispify "m_numChildShapes" 'slotname) :int)
	(#.(bullet-wrap::swig-lispify "m_collisionMargin" 'slotname) :float))

(cl:export '#.(bullet-wrap::swig-lispify "btCompoundShapeData" 'classname))

(cl:export '#.(bullet-wrap::swig-lispify "m_collisionShapeData" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_childShapePtr" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_numChildShapes" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_collisionMargin" 'slotname))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btBU_Simplex1to4_makeCPlusPlusInstance" 'function)))

(cffi:defcfun ("_wrap_btBU_Simplex1to4_makeCPlusPlusInstance__SWIG_0" #.(bullet-wrap::swig-lispify "btBU_Simplex1to4_makeCPlusPlusInstance" 'function)) :pointer
  (self :pointer)
  (sizeInBytes :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btBU_Simplex1to4_makeCPlusPlusInstance" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btBU_Simplex1to4_deleteCPlusPlusInstance" 'function)))

(cffi:defcfun ("_wrap_btBU_Simplex1to4_deleteCPlusPlusInstance__SWIG_0" #.(bullet-wrap::swig-lispify "btBU_Simplex1to4_deleteCPlusPlusInstance" 'function)) :void
  (self :pointer)
  (ptr :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btBU_Simplex1to4_deleteCPlusPlusInstance" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btBU_Simplex1to4_makeCPlusPlusInstance" 'function)))

(cffi:defcfun ("_wrap_btBU_Simplex1to4_makeCPlusPlusInstance__SWIG_1" #.(bullet-wrap::swig-lispify "btBU_Simplex1to4_makeCPlusPlusInstance" 'function)) :pointer
  (self :pointer)
  (arg1 :pointer)
  (ptr :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btBU_Simplex1to4_makeCPlusPlusInstance" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btBU_Simplex1to4_deleteCPlusPlusInstance" 'function)))

(cffi:defcfun ("_wrap_btBU_Simplex1to4_deleteCPlusPlusInstance__SWIG_1" #.(bullet-wrap::swig-lispify "btBU_Simplex1to4_deleteCPlusPlusInstance" 'function)) :void
  (self :pointer)
  (arg1 :pointer)
  (arg2 :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btBU_Simplex1to4_deleteCPlusPlusInstance" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btBU_Simplex1to4_makeCPlusArray" 'function)))

(cffi:defcfun ("_wrap_btBU_Simplex1to4_makeCPlusArray__SWIG_0" #.(bullet-wrap::swig-lispify "btBU_Simplex1to4_makeCPlusArray" 'function)) :pointer
  (self :pointer)
  (sizeInBytes :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btBU_Simplex1to4_makeCPlusArray" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btBU_Simplex1to4_deleteCPlusArray" 'function)))

(cffi:defcfun ("_wrap_btBU_Simplex1to4_deleteCPlusArray__SWIG_0" #.(bullet-wrap::swig-lispify "btBU_Simplex1to4_deleteCPlusArray" 'function)) :void
  (self :pointer)
  (ptr :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btBU_Simplex1to4_deleteCPlusArray" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btBU_Simplex1to4_makeCPlusArray" 'function)))

(cffi:defcfun ("_wrap_btBU_Simplex1to4_makeCPlusArray__SWIG_1" #.(bullet-wrap::swig-lispify "btBU_Simplex1to4_makeCPlusArray" 'function)) :pointer
  (self :pointer)
  (arg1 :pointer)
  (ptr :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btBU_Simplex1to4_makeCPlusArray" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btBU_Simplex1to4_deleteCPlusArray" 'function)))

(cffi:defcfun ("_wrap_btBU_Simplex1to4_deleteCPlusArray__SWIG_1" #.(bullet-wrap::swig-lispify "btBU_Simplex1to4_deleteCPlusArray" 'function)) :void
  (self :pointer)
  (arg1 :pointer)
  (arg2 :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btBU_Simplex1to4_deleteCPlusArray" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "new_btBU_Simplex1to4" 'function)))

(cffi:defcfun ("_wrap_new_btBU_Simplex1to4__SWIG_0" #.(bullet-wrap::swig-lispify "new_btBU_Simplex1to4" 'function)) :pointer)

(cl:export '#.(bullet-wrap::swig-lispify "new_btBU_Simplex1to4" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "new_btBU_Simplex1to4" 'function)))

(cffi:defcfun ("_wrap_new_btBU_Simplex1to4__SWIG_1" #.(bullet-wrap::swig-lispify "new_btBU_Simplex1to4" 'function)) :pointer
  (pt0 :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "new_btBU_Simplex1to4" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "new_btBU_Simplex1to4" 'function)))

(cffi:defcfun ("_wrap_new_btBU_Simplex1to4__SWIG_2" #.(bullet-wrap::swig-lispify "new_btBU_Simplex1to4" 'function)) :pointer
  (pt0 :pointer)
  (pt1 :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "new_btBU_Simplex1to4" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "new_btBU_Simplex1to4" 'function)))

(cffi:defcfun ("_wrap_new_btBU_Simplex1to4__SWIG_3" #.(bullet-wrap::swig-lispify "new_btBU_Simplex1to4" 'function)) :pointer
  (pt0 :pointer)
  (pt1 :pointer)
  (pt2 :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "new_btBU_Simplex1to4" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "new_btBU_Simplex1to4" 'function)))

(cffi:defcfun ("_wrap_new_btBU_Simplex1to4__SWIG_4" #.(bullet-wrap::swig-lispify "new_btBU_Simplex1to4" 'function)) :pointer
  (pt0 :pointer)
  (pt1 :pointer)
  (pt2 :pointer)
  (pt3 :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "new_btBU_Simplex1to4" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btBU_Simplex1to4_reset" 'function)))

(cffi:defcfun ("_wrap_btBU_Simplex1to4_reset" #.(bullet-wrap::swig-lispify "btBU_Simplex1to4_reset" 'function)) :void
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btBU_Simplex1to4_reset" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btBU_Simplex1to4_getAabb" 'function)))

(cffi:defcfun ("_wrap_btBU_Simplex1to4_getAabb" #.(bullet-wrap::swig-lispify "btBU_Simplex1to4_getAabb" 'function)) :void
  (self :pointer)
  (t_arg1 :pointer)
  (aabbMin :pointer)
  (aabbMax :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btBU_Simplex1to4_getAabb" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btBU_Simplex1to4_addVertex" 'function)))

(cffi:defcfun ("_wrap_btBU_Simplex1to4_addVertex" #.(bullet-wrap::swig-lispify "btBU_Simplex1to4_addVertex" 'function)) :void
  (self :pointer)
  (pt :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btBU_Simplex1to4_addVertex" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btBU_Simplex1to4_getNumVertices" 'function)))

(cffi:defcfun ("_wrap_btBU_Simplex1to4_getNumVertices" #.(bullet-wrap::swig-lispify "btBU_Simplex1to4_getNumVertices" 'function)) :int
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btBU_Simplex1to4_getNumVertices" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btBU_Simplex1to4_getNumEdges" 'function)))

(cffi:defcfun ("_wrap_btBU_Simplex1to4_getNumEdges" #.(bullet-wrap::swig-lispify "btBU_Simplex1to4_getNumEdges" 'function)) :int
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btBU_Simplex1to4_getNumEdges" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btBU_Simplex1to4_getEdge" 'function)))

(cffi:defcfun ("_wrap_btBU_Simplex1to4_getEdge" #.(bullet-wrap::swig-lispify "btBU_Simplex1to4_getEdge" 'function)) :void
  (self :pointer)
  (i :int)
  (pa :pointer)
  (pb :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btBU_Simplex1to4_getEdge" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btBU_Simplex1to4_getVertex" 'function)))

(cffi:defcfun ("_wrap_btBU_Simplex1to4_getVertex" #.(bullet-wrap::swig-lispify "btBU_Simplex1to4_getVertex" 'function)) :void
  (self :pointer)
  (i :int)
  (vtx :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btBU_Simplex1to4_getVertex" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btBU_Simplex1to4_getNumPlanes" 'function)))

(cffi:defcfun ("_wrap_btBU_Simplex1to4_getNumPlanes" #.(bullet-wrap::swig-lispify "btBU_Simplex1to4_getNumPlanes" 'function)) :int
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btBU_Simplex1to4_getNumPlanes" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btBU_Simplex1to4_getPlane" 'function)))

(cffi:defcfun ("_wrap_btBU_Simplex1to4_getPlane" #.(bullet-wrap::swig-lispify "btBU_Simplex1to4_getPlane" 'function)) :void
  (self :pointer)
  (planeNormal :pointer)
  (planeSupport :pointer)
  (i :int))

(cl:export '#.(bullet-wrap::swig-lispify "btBU_Simplex1to4_getPlane" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btBU_Simplex1to4_getIndex" 'function)))

(cffi:defcfun ("_wrap_btBU_Simplex1to4_getIndex" #.(bullet-wrap::swig-lispify "btBU_Simplex1to4_getIndex" 'function)) :int
  (self :pointer)
  (i :int))

(cl:export '#.(bullet-wrap::swig-lispify "btBU_Simplex1to4_getIndex" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btBU_Simplex1to4_isInside" 'function)))

(cffi:defcfun ("_wrap_btBU_Simplex1to4_isInside" #.(bullet-wrap::swig-lispify "btBU_Simplex1to4_isInside" 'function)) :pointer
  (self :pointer)
  (pt :pointer)
  (tolerance :float))

(cl:export '#.(bullet-wrap::swig-lispify "btBU_Simplex1to4_isInside" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btBU_Simplex1to4_getName" 'function)))

(cffi:defcfun ("_wrap_btBU_Simplex1to4_getName" #.(bullet-wrap::swig-lispify "btBU_Simplex1to4_getName" 'function)) :string
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btBU_Simplex1to4_getName" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "delete_btBU_Simplex1to4" 'function)))

(cffi:defcfun ("_wrap_delete_btBU_Simplex1to4" #.(bullet-wrap::swig-lispify "delete_btBU_Simplex1to4" 'function)) :void
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "delete_btBU_Simplex1to4" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btEmptyShape_makeCPlusPlusInstance" 'function)))

(cffi:defcfun ("_wrap_btEmptyShape_makeCPlusPlusInstance__SWIG_0" #.(bullet-wrap::swig-lispify "btEmptyShape_makeCPlusPlusInstance" 'function)) :pointer
  (self :pointer)
  (sizeInBytes :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btEmptyShape_makeCPlusPlusInstance" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btEmptyShape_deleteCPlusPlusInstance" 'function)))

(cffi:defcfun ("_wrap_btEmptyShape_deleteCPlusPlusInstance__SWIG_0" #.(bullet-wrap::swig-lispify "btEmptyShape_deleteCPlusPlusInstance" 'function)) :void
  (self :pointer)
  (ptr :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btEmptyShape_deleteCPlusPlusInstance" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btEmptyShape_makeCPlusPlusInstance" 'function)))

(cffi:defcfun ("_wrap_btEmptyShape_makeCPlusPlusInstance__SWIG_1" #.(bullet-wrap::swig-lispify "btEmptyShape_makeCPlusPlusInstance" 'function)) :pointer
  (self :pointer)
  (arg1 :pointer)
  (ptr :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btEmptyShape_makeCPlusPlusInstance" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btEmptyShape_deleteCPlusPlusInstance" 'function)))

(cffi:defcfun ("_wrap_btEmptyShape_deleteCPlusPlusInstance__SWIG_1" #.(bullet-wrap::swig-lispify "btEmptyShape_deleteCPlusPlusInstance" 'function)) :void
  (self :pointer)
  (arg1 :pointer)
  (arg2 :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btEmptyShape_deleteCPlusPlusInstance" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btEmptyShape_makeCPlusArray" 'function)))

(cffi:defcfun ("_wrap_btEmptyShape_makeCPlusArray__SWIG_0" #.(bullet-wrap::swig-lispify "btEmptyShape_makeCPlusArray" 'function)) :pointer
  (self :pointer)
  (sizeInBytes :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btEmptyShape_makeCPlusArray" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btEmptyShape_deleteCPlusArray" 'function)))

(cffi:defcfun ("_wrap_btEmptyShape_deleteCPlusArray__SWIG_0" #.(bullet-wrap::swig-lispify "btEmptyShape_deleteCPlusArray" 'function)) :void
  (self :pointer)
  (ptr :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btEmptyShape_deleteCPlusArray" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btEmptyShape_makeCPlusArray" 'function)))

(cffi:defcfun ("_wrap_btEmptyShape_makeCPlusArray__SWIG_1" #.(bullet-wrap::swig-lispify "btEmptyShape_makeCPlusArray" 'function)) :pointer
  (self :pointer)
  (arg1 :pointer)
  (ptr :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btEmptyShape_makeCPlusArray" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btEmptyShape_deleteCPlusArray" 'function)))

(cffi:defcfun ("_wrap_btEmptyShape_deleteCPlusArray__SWIG_1" #.(bullet-wrap::swig-lispify "btEmptyShape_deleteCPlusArray" 'function)) :void
  (self :pointer)
  (arg1 :pointer)
  (arg2 :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btEmptyShape_deleteCPlusArray" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "new_btEmptyShape" 'function)))

(cffi:defcfun ("_wrap_new_btEmptyShape" #.(bullet-wrap::swig-lispify "new_btEmptyShape" 'function)) :pointer)

(cl:export '#.(bullet-wrap::swig-lispify "new_btEmptyShape" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "delete_btEmptyShape" 'function)))

(cffi:defcfun ("_wrap_delete_btEmptyShape" #.(bullet-wrap::swig-lispify "delete_btEmptyShape" 'function)) :void
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "delete_btEmptyShape" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btEmptyShape_getAabb" 'function)))

(cffi:defcfun ("_wrap_btEmptyShape_getAabb" #.(bullet-wrap::swig-lispify "btEmptyShape_getAabb" 'function)) :void
  (self :pointer)
  (t_arg1 :pointer)
  (aabbMin :pointer)
  (aabbMax :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btEmptyShape_getAabb" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btEmptyShape_setLocalScaling" 'function)))

(cffi:defcfun ("_wrap_btEmptyShape_setLocalScaling" #.(bullet-wrap::swig-lispify "btEmptyShape_setLocalScaling" 'function)) :void
  (self :pointer)
  (scaling :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btEmptyShape_setLocalScaling" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btEmptyShape_getLocalScaling" 'function)))

(cffi:defcfun ("_wrap_btEmptyShape_getLocalScaling" #.(bullet-wrap::swig-lispify "btEmptyShape_getLocalScaling" 'function)) :pointer
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btEmptyShape_getLocalScaling" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btEmptyShape_calculateLocalInertia" 'function)))

(cffi:defcfun ("_wrap_btEmptyShape_calculateLocalInertia" #.(bullet-wrap::swig-lispify "btEmptyShape_calculateLocalInertia" 'function)) :void
  (self :pointer)
  (mass :float)
  (inertia :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btEmptyShape_calculateLocalInertia" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btEmptyShape_getName" 'function)))

(cffi:defcfun ("_wrap_btEmptyShape_getName" #.(bullet-wrap::swig-lispify "btEmptyShape_getName" 'function)) :string
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btEmptyShape_getName" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btEmptyShape_processAllTriangles" 'function)))

(cffi:defcfun ("_wrap_btEmptyShape_processAllTriangles" #.(bullet-wrap::swig-lispify "btEmptyShape_processAllTriangles" 'function)) :void
  (self :pointer)
  (arg1 :pointer)
  (arg2 :pointer)
  (arg3 :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btEmptyShape_processAllTriangles" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btMultiSphereShape_makeCPlusPlusInstance" 'function)))

(cffi:defcfun ("_wrap_btMultiSphereShape_makeCPlusPlusInstance__SWIG_0" #.(bullet-wrap::swig-lispify "btMultiSphereShape_makeCPlusPlusInstance" 'function)) :pointer
  (self :pointer)
  (sizeInBytes :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btMultiSphereShape_makeCPlusPlusInstance" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btMultiSphereShape_deleteCPlusPlusInstance" 'function)))

(cffi:defcfun ("_wrap_btMultiSphereShape_deleteCPlusPlusInstance__SWIG_0" #.(bullet-wrap::swig-lispify "btMultiSphereShape_deleteCPlusPlusInstance" 'function)) :void
  (self :pointer)
  (ptr :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btMultiSphereShape_deleteCPlusPlusInstance" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btMultiSphereShape_makeCPlusPlusInstance" 'function)))

(cffi:defcfun ("_wrap_btMultiSphereShape_makeCPlusPlusInstance__SWIG_1" #.(bullet-wrap::swig-lispify "btMultiSphereShape_makeCPlusPlusInstance" 'function)) :pointer
  (self :pointer)
  (arg1 :pointer)
  (ptr :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btMultiSphereShape_makeCPlusPlusInstance" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btMultiSphereShape_deleteCPlusPlusInstance" 'function)))

(cffi:defcfun ("_wrap_btMultiSphereShape_deleteCPlusPlusInstance__SWIG_1" #.(bullet-wrap::swig-lispify "btMultiSphereShape_deleteCPlusPlusInstance" 'function)) :void
  (self :pointer)
  (arg1 :pointer)
  (arg2 :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btMultiSphereShape_deleteCPlusPlusInstance" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btMultiSphereShape_makeCPlusArray" 'function)))

(cffi:defcfun ("_wrap_btMultiSphereShape_makeCPlusArray__SWIG_0" #.(bullet-wrap::swig-lispify "btMultiSphereShape_makeCPlusArray" 'function)) :pointer
  (self :pointer)
  (sizeInBytes :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btMultiSphereShape_makeCPlusArray" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btMultiSphereShape_deleteCPlusArray" 'function)))

(cffi:defcfun ("_wrap_btMultiSphereShape_deleteCPlusArray__SWIG_0" #.(bullet-wrap::swig-lispify "btMultiSphereShape_deleteCPlusArray" 'function)) :void
  (self :pointer)
  (ptr :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btMultiSphereShape_deleteCPlusArray" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btMultiSphereShape_makeCPlusArray" 'function)))

(cffi:defcfun ("_wrap_btMultiSphereShape_makeCPlusArray__SWIG_1" #.(bullet-wrap::swig-lispify "btMultiSphereShape_makeCPlusArray" 'function)) :pointer
  (self :pointer)
  (arg1 :pointer)
  (ptr :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btMultiSphereShape_makeCPlusArray" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btMultiSphereShape_deleteCPlusArray" 'function)))

(cffi:defcfun ("_wrap_btMultiSphereShape_deleteCPlusArray__SWIG_1" #.(bullet-wrap::swig-lispify "btMultiSphereShape_deleteCPlusArray" 'function)) :void
  (self :pointer)
  (arg1 :pointer)
  (arg2 :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btMultiSphereShape_deleteCPlusArray" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "new_btMultiSphereShape" 'function)))

(cffi:defcfun ("_wrap_new_btMultiSphereShape" #.(bullet-wrap::swig-lispify "new_btMultiSphereShape" 'function)) :pointer
  (positions :pointer)
  (radi :pointer)
  (numSpheres :int))

(cl:export '#.(bullet-wrap::swig-lispify "new_btMultiSphereShape" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btMultiSphereShape_calculateLocalInertia" 'function)))

(cffi:defcfun ("_wrap_btMultiSphereShape_calculateLocalInertia" #.(bullet-wrap::swig-lispify "btMultiSphereShape_calculateLocalInertia" 'function)) :void
  (self :pointer)
  (mass :float)
  (inertia :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btMultiSphereShape_calculateLocalInertia" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btMultiSphereShape_localGetSupportingVertexWithoutMargin" 'function)))

(cffi:defcfun ("_wrap_btMultiSphereShape_localGetSupportingVertexWithoutMargin" #.(bullet-wrap::swig-lispify "btMultiSphereShape_localGetSupportingVertexWithoutMargin" 'function)) :pointer
  (self :pointer)
  (vec :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btMultiSphereShape_localGetSupportingVertexWithoutMargin" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btMultiSphereShape_batchedUnitVectorGetSupportingVertexWithoutMargin" 'function)))

(cffi:defcfun ("_wrap_btMultiSphereShape_batchedUnitVectorGetSupportingVertexWithoutMargin" #.(bullet-wrap::swig-lispify "btMultiSphereShape_batchedUnitVectorGetSupportingVertexWithoutMargin" 'function)) :void
  (self :pointer)
  (vectors :pointer)
  (supportVerticesOut :pointer)
  (numVectors :int))

(cl:export '#.(bullet-wrap::swig-lispify "btMultiSphereShape_batchedUnitVectorGetSupportingVertexWithoutMargin" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btMultiSphereShape_getSphereCount" 'function)))

(cffi:defcfun ("_wrap_btMultiSphereShape_getSphereCount" #.(bullet-wrap::swig-lispify "btMultiSphereShape_getSphereCount" 'function)) :int
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btMultiSphereShape_getSphereCount" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btMultiSphereShape_getSpherePosition" 'function)))

(cffi:defcfun ("_wrap_btMultiSphereShape_getSpherePosition" #.(bullet-wrap::swig-lispify "btMultiSphereShape_getSpherePosition" 'function)) :pointer
  (self :pointer)
  (index :int))

(cl:export '#.(bullet-wrap::swig-lispify "btMultiSphereShape_getSpherePosition" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btMultiSphereShape_getSphereRadius" 'function)))

(cffi:defcfun ("_wrap_btMultiSphereShape_getSphereRadius" #.(bullet-wrap::swig-lispify "btMultiSphereShape_getSphereRadius" 'function)) :float
  (self :pointer)
  (index :int))

(cl:export '#.(bullet-wrap::swig-lispify "btMultiSphereShape_getSphereRadius" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btMultiSphereShape_getName" 'function)))

(cffi:defcfun ("_wrap_btMultiSphereShape_getName" #.(bullet-wrap::swig-lispify "btMultiSphereShape_getName" 'function)) :string
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btMultiSphereShape_getName" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btMultiSphereShape_calculateSerializeBufferSize" 'function)))

(cffi:defcfun ("_wrap_btMultiSphereShape_calculateSerializeBufferSize" #.(bullet-wrap::swig-lispify "btMultiSphereShape_calculateSerializeBufferSize" 'function)) :int
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btMultiSphereShape_calculateSerializeBufferSize" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btMultiSphereShape_serialize" 'function)))

(cffi:defcfun ("_wrap_btMultiSphereShape_serialize" #.(bullet-wrap::swig-lispify "btMultiSphereShape_serialize" 'function)) :string
  (self :pointer)
  (dataBuffer :pointer)
  (serializer :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btMultiSphereShape_serialize" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "delete_btMultiSphereShape" 'function)))

(cffi:defcfun ("_wrap_delete_btMultiSphereShape" #.(bullet-wrap::swig-lispify "delete_btMultiSphereShape" 'function)) :void
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "delete_btMultiSphereShape" 'function))

(cffi:defcstruct #.(bullet-wrap::swig-lispify "btPositionAndRadius" 'classname)
	(#.(bullet-wrap::swig-lispify "m_pos" 'slotname) #.(bullet-wrap::swig-lispify "btVector3FloatData" 'classname))
	(#.(bullet-wrap::swig-lispify "m_radius" 'slotname) :float))

(cl:export '#.(bullet-wrap::swig-lispify "btPositionAndRadius" 'classname))

(cl:export '#.(bullet-wrap::swig-lispify "m_pos" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_radius" 'slotname))

(cffi:defcstruct #.(bullet-wrap::swig-lispify "btMultiSphereShapeData" 'classname)
	(#.(bullet-wrap::swig-lispify "m_convexInternalShapeData" 'slotname) :pointer)
	(#.(bullet-wrap::swig-lispify "m_localPositionArrayPtr" 'slotname) :pointer)
	(#.(bullet-wrap::swig-lispify "m_localPositionArraySize" 'slotname) :int)
	(#.(bullet-wrap::swig-lispify "m_padding" 'slotname) :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btMultiSphereShapeData" 'classname))

(cl:export '#.(bullet-wrap::swig-lispify "m_convexInternalShapeData" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_localPositionArrayPtr" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_localPositionArraySize" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_padding" 'slotname))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btUniformScalingShape_makeCPlusPlusInstance" 'function)))

(cffi:defcfun ("_wrap_btUniformScalingShape_makeCPlusPlusInstance__SWIG_0" #.(bullet-wrap::swig-lispify "btUniformScalingShape_makeCPlusPlusInstance" 'function)) :pointer
  (self :pointer)
  (sizeInBytes :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btUniformScalingShape_makeCPlusPlusInstance" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btUniformScalingShape_deleteCPlusPlusInstance" 'function)))

(cffi:defcfun ("_wrap_btUniformScalingShape_deleteCPlusPlusInstance__SWIG_0" #.(bullet-wrap::swig-lispify "btUniformScalingShape_deleteCPlusPlusInstance" 'function)) :void
  (self :pointer)
  (ptr :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btUniformScalingShape_deleteCPlusPlusInstance" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btUniformScalingShape_makeCPlusPlusInstance" 'function)))

(cffi:defcfun ("_wrap_btUniformScalingShape_makeCPlusPlusInstance__SWIG_1" #.(bullet-wrap::swig-lispify "btUniformScalingShape_makeCPlusPlusInstance" 'function)) :pointer
  (self :pointer)
  (arg1 :pointer)
  (ptr :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btUniformScalingShape_makeCPlusPlusInstance" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btUniformScalingShape_deleteCPlusPlusInstance" 'function)))

(cffi:defcfun ("_wrap_btUniformScalingShape_deleteCPlusPlusInstance__SWIG_1" #.(bullet-wrap::swig-lispify "btUniformScalingShape_deleteCPlusPlusInstance" 'function)) :void
  (self :pointer)
  (arg1 :pointer)
  (arg2 :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btUniformScalingShape_deleteCPlusPlusInstance" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btUniformScalingShape_makeCPlusArray" 'function)))

(cffi:defcfun ("_wrap_btUniformScalingShape_makeCPlusArray__SWIG_0" #.(bullet-wrap::swig-lispify "btUniformScalingShape_makeCPlusArray" 'function)) :pointer
  (self :pointer)
  (sizeInBytes :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btUniformScalingShape_makeCPlusArray" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btUniformScalingShape_deleteCPlusArray" 'function)))

(cffi:defcfun ("_wrap_btUniformScalingShape_deleteCPlusArray__SWIG_0" #.(bullet-wrap::swig-lispify "btUniformScalingShape_deleteCPlusArray" 'function)) :void
  (self :pointer)
  (ptr :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btUniformScalingShape_deleteCPlusArray" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btUniformScalingShape_makeCPlusArray" 'function)))

(cffi:defcfun ("_wrap_btUniformScalingShape_makeCPlusArray__SWIG_1" #.(bullet-wrap::swig-lispify "btUniformScalingShape_makeCPlusArray" 'function)) :pointer
  (self :pointer)
  (arg1 :pointer)
  (ptr :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btUniformScalingShape_makeCPlusArray" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btUniformScalingShape_deleteCPlusArray" 'function)))

(cffi:defcfun ("_wrap_btUniformScalingShape_deleteCPlusArray__SWIG_1" #.(bullet-wrap::swig-lispify "btUniformScalingShape_deleteCPlusArray" 'function)) :void
  (self :pointer)
  (arg1 :pointer)
  (arg2 :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btUniformScalingShape_deleteCPlusArray" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "new_btUniformScalingShape" 'function)))

(cffi:defcfun ("_wrap_new_btUniformScalingShape" #.(bullet-wrap::swig-lispify "new_btUniformScalingShape" 'function)) :pointer
  (convexChildShape :pointer)
  (uniformScalingFactor :float))

(cl:export '#.(bullet-wrap::swig-lispify "new_btUniformScalingShape" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "delete_btUniformScalingShape" 'function)))

(cffi:defcfun ("_wrap_delete_btUniformScalingShape" #.(bullet-wrap::swig-lispify "delete_btUniformScalingShape" 'function)) :void
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "delete_btUniformScalingShape" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btUniformScalingShape_localGetSupportingVertexWithoutMargin" 'function)))

(cffi:defcfun ("_wrap_btUniformScalingShape_localGetSupportingVertexWithoutMargin" #.(bullet-wrap::swig-lispify "btUniformScalingShape_localGetSupportingVertexWithoutMargin" 'function)) :pointer
  (self :pointer)
  (vec :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btUniformScalingShape_localGetSupportingVertexWithoutMargin" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btUniformScalingShape_localGetSupportingVertex" 'function)))

(cffi:defcfun ("_wrap_btUniformScalingShape_localGetSupportingVertex" #.(bullet-wrap::swig-lispify "btUniformScalingShape_localGetSupportingVertex" 'function)) :pointer
  (self :pointer)
  (vec :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btUniformScalingShape_localGetSupportingVertex" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btUniformScalingShape_batchedUnitVectorGetSupportingVertexWithoutMargin" 'function)))

(cffi:defcfun ("_wrap_btUniformScalingShape_batchedUnitVectorGetSupportingVertexWithoutMargin" #.(bullet-wrap::swig-lispify "btUniformScalingShape_batchedUnitVectorGetSupportingVertexWithoutMargin" 'function)) :void
  (self :pointer)
  (vectors :pointer)
  (supportVerticesOut :pointer)
  (numVectors :int))

(cl:export '#.(bullet-wrap::swig-lispify "btUniformScalingShape_batchedUnitVectorGetSupportingVertexWithoutMargin" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btUniformScalingShape_calculateLocalInertia" 'function)))

(cffi:defcfun ("_wrap_btUniformScalingShape_calculateLocalInertia" #.(bullet-wrap::swig-lispify "btUniformScalingShape_calculateLocalInertia" 'function)) :void
  (self :pointer)
  (mass :float)
  (inertia :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btUniformScalingShape_calculateLocalInertia" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btUniformScalingShape_getUniformScalingFactor" 'function)))

(cffi:defcfun ("_wrap_btUniformScalingShape_getUniformScalingFactor" #.(bullet-wrap::swig-lispify "btUniformScalingShape_getUniformScalingFactor" 'function)) :float
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btUniformScalingShape_getUniformScalingFactor" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btUniformScalingShape_getChildShape" 'function)))

(cffi:defcfun ("_wrap_btUniformScalingShape_getChildShape__SWIG_0" #.(bullet-wrap::swig-lispify "btUniformScalingShape_getChildShape" 'function)) :pointer
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btUniformScalingShape_getChildShape" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btUniformScalingShape_getChildShape" 'function)))

(cffi:defcfun ("_wrap_btUniformScalingShape_getChildShape__SWIG_1" #.(bullet-wrap::swig-lispify "btUniformScalingShape_getChildShape" 'function)) :pointer
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btUniformScalingShape_getChildShape" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btUniformScalingShape_getName" 'function)))

(cffi:defcfun ("_wrap_btUniformScalingShape_getName" #.(bullet-wrap::swig-lispify "btUniformScalingShape_getName" 'function)) :string
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btUniformScalingShape_getName" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btUniformScalingShape_getAabb" 'function)))

(cffi:defcfun ("_wrap_btUniformScalingShape_getAabb" #.(bullet-wrap::swig-lispify "btUniformScalingShape_getAabb" 'function)) :void
  (self :pointer)
  (t_arg1 :pointer)
  (aabbMin :pointer)
  (aabbMax :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btUniformScalingShape_getAabb" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btUniformScalingShape_getAabbSlow" 'function)))

(cffi:defcfun ("_wrap_btUniformScalingShape_getAabbSlow" #.(bullet-wrap::swig-lispify "btUniformScalingShape_getAabbSlow" 'function)) :void
  (self :pointer)
  (t_arg1 :pointer)
  (aabbMin :pointer)
  (aabbMax :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btUniformScalingShape_getAabbSlow" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btUniformScalingShape_setLocalScaling" 'function)))

(cffi:defcfun ("_wrap_btUniformScalingShape_setLocalScaling" #.(bullet-wrap::swig-lispify "btUniformScalingShape_setLocalScaling" 'function)) :void
  (self :pointer)
  (scaling :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btUniformScalingShape_setLocalScaling" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btUniformScalingShape_getLocalScaling" 'function)))

(cffi:defcfun ("_wrap_btUniformScalingShape_getLocalScaling" #.(bullet-wrap::swig-lispify "btUniformScalingShape_getLocalScaling" 'function)) :pointer
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btUniformScalingShape_getLocalScaling" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btUniformScalingShape_setMargin" 'function)))

(cffi:defcfun ("_wrap_btUniformScalingShape_setMargin" #.(bullet-wrap::swig-lispify "btUniformScalingShape_setMargin" 'function)) :void
  (self :pointer)
  (margin :float))

(cl:export '#.(bullet-wrap::swig-lispify "btUniformScalingShape_setMargin" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btUniformScalingShape_getMargin" 'function)))

(cffi:defcfun ("_wrap_btUniformScalingShape_getMargin" #.(bullet-wrap::swig-lispify "btUniformScalingShape_getMargin" 'function)) :float
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btUniformScalingShape_getMargin" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btUniformScalingShape_getNumPreferredPenetrationDirections" 'function)))

(cffi:defcfun ("_wrap_btUniformScalingShape_getNumPreferredPenetrationDirections" #.(bullet-wrap::swig-lispify "btUniformScalingShape_getNumPreferredPenetrationDirections" 'function)) :int
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btUniformScalingShape_getNumPreferredPenetrationDirections" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btUniformScalingShape_getPreferredPenetrationDirection" 'function)))

(cffi:defcfun ("_wrap_btUniformScalingShape_getPreferredPenetrationDirection" #.(bullet-wrap::swig-lispify "btUniformScalingShape_getPreferredPenetrationDirection" 'function)) :void
  (self :pointer)
  (index :int)
  (penetrationVector :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btUniformScalingShape_getPreferredPenetrationDirection" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "new_btSphereSphereCollisionAlgorithm" 'function)))

(cffi:defcfun ("_wrap_new_btSphereSphereCollisionAlgorithm__SWIG_0" #.(bullet-wrap::swig-lispify "new_btSphereSphereCollisionAlgorithm" 'function)) :pointer
  (mf :pointer)
  (ci :pointer)
  (col0Wrap :pointer)
  (col1Wrap :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "new_btSphereSphereCollisionAlgorithm" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "new_btSphereSphereCollisionAlgorithm" 'function)))

(cffi:defcfun ("_wrap_new_btSphereSphereCollisionAlgorithm__SWIG_1" #.(bullet-wrap::swig-lispify "new_btSphereSphereCollisionAlgorithm" 'function)) :pointer
  (ci :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "new_btSphereSphereCollisionAlgorithm" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btSphereSphereCollisionAlgorithm_processCollision" 'function)))

(cffi:defcfun ("_wrap_btSphereSphereCollisionAlgorithm_processCollision" #.(bullet-wrap::swig-lispify "btSphereSphereCollisionAlgorithm_processCollision" 'function)) :void
  (self :pointer)
  (body0Wrap :pointer)
  (body1Wrap :pointer)
  (dispatchInfo :pointer)
  (resultOut :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btSphereSphereCollisionAlgorithm_processCollision" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btSphereSphereCollisionAlgorithm_calculateTimeOfImpact" 'function)))

(cffi:defcfun ("_wrap_btSphereSphereCollisionAlgorithm_calculateTimeOfImpact" #.(bullet-wrap::swig-lispify "btSphereSphereCollisionAlgorithm_calculateTimeOfImpact" 'function)) :float
  (self :pointer)
  (body0 :pointer)
  (body1 :pointer)
  (dispatchInfo :pointer)
  (resultOut :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btSphereSphereCollisionAlgorithm_calculateTimeOfImpact" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btSphereSphereCollisionAlgorithm_getAllContactManifolds" 'function)))

(cffi:defcfun ("_wrap_btSphereSphereCollisionAlgorithm_getAllContactManifolds" #.(bullet-wrap::swig-lispify "btSphereSphereCollisionAlgorithm_getAllContactManifolds" 'function)) :void
  (self :pointer)
  (manifoldArray :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btSphereSphereCollisionAlgorithm_getAllContactManifolds" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "delete_btSphereSphereCollisionAlgorithm" 'function)))

(cffi:defcfun ("_wrap_delete_btSphereSphereCollisionAlgorithm" #.(bullet-wrap::swig-lispify "delete_btSphereSphereCollisionAlgorithm" 'function)) :void
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "delete_btSphereSphereCollisionAlgorithm" 'function))

(cffi:defcstruct #.(bullet-wrap::swig-lispify "btDefaultCollisionConstructionInfo" 'classname)
	(#.(bullet-wrap::swig-lispify "m_persistentManifoldPool" 'slotname) :pointer)
	(#.(bullet-wrap::swig-lispify "m_collisionAlgorithmPool" 'slotname) :pointer)
	(#.(bullet-wrap::swig-lispify "m_defaultMaxPersistentManifoldPoolSize" 'slotname) :int)
	(#.(bullet-wrap::swig-lispify "m_defaultMaxCollisionAlgorithmPoolSize" 'slotname) :int)
	(#.(bullet-wrap::swig-lispify "m_customCollisionAlgorithmMaxElementSize" 'slotname) :int)
	(#.(bullet-wrap::swig-lispify "m_useEpaPenetrationAlgorithm" 'slotname) :int))

(cl:export '#.(bullet-wrap::swig-lispify "btDefaultCollisionConstructionInfo" 'classname))

(cl:export '#.(bullet-wrap::swig-lispify "m_persistentManifoldPool" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_collisionAlgorithmPool" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_defaultMaxPersistentManifoldPoolSize" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_defaultMaxCollisionAlgorithmPoolSize" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_customCollisionAlgorithmMaxElementSize" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_useEpaPenetrationAlgorithm" 'slotname))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "new_btDefaultCollisionConfiguration" 'function)))

(cffi:defcfun ("_wrap_new_btDefaultCollisionConfiguration__SWIG_0" #.(bullet-wrap::swig-lispify "new_btDefaultCollisionConfiguration" 'function)) :pointer
  (constructionInfo :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "new_btDefaultCollisionConfiguration" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "new_btDefaultCollisionConfiguration" 'function)))

(cffi:defcfun ("_wrap_new_btDefaultCollisionConfiguration__SWIG_1" #.(bullet-wrap::swig-lispify "new_btDefaultCollisionConfiguration" 'function)) :pointer)

(cl:export '#.(bullet-wrap::swig-lispify "new_btDefaultCollisionConfiguration" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "delete_btDefaultCollisionConfiguration" 'function)))

(cffi:defcfun ("_wrap_delete_btDefaultCollisionConfiguration" #.(bullet-wrap::swig-lispify "delete_btDefaultCollisionConfiguration" 'function)) :void
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "delete_btDefaultCollisionConfiguration" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btDefaultCollisionConfiguration_getPersistentManifoldPool" 'function)))

(cffi:defcfun ("_wrap_btDefaultCollisionConfiguration_getPersistentManifoldPool" #.(bullet-wrap::swig-lispify "btDefaultCollisionConfiguration_getPersistentManifoldPool" 'function)) :pointer
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btDefaultCollisionConfiguration_getPersistentManifoldPool" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btDefaultCollisionConfiguration_getCollisionAlgorithmPool" 'function)))

(cffi:defcfun ("_wrap_btDefaultCollisionConfiguration_getCollisionAlgorithmPool" #.(bullet-wrap::swig-lispify "btDefaultCollisionConfiguration_getCollisionAlgorithmPool" 'function)) :pointer
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btDefaultCollisionConfiguration_getCollisionAlgorithmPool" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btDefaultCollisionConfiguration_getSimplexSolver" 'function)))

(cffi:defcfun ("_wrap_btDefaultCollisionConfiguration_getSimplexSolver" #.(bullet-wrap::swig-lispify "btDefaultCollisionConfiguration_getSimplexSolver" 'function)) :pointer
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btDefaultCollisionConfiguration_getSimplexSolver" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btDefaultCollisionConfiguration_getCollisionAlgorithmCreateFunc" 'function)))

(cffi:defcfun ("_wrap_btDefaultCollisionConfiguration_getCollisionAlgorithmCreateFunc" #.(bullet-wrap::swig-lispify "btDefaultCollisionConfiguration_getCollisionAlgorithmCreateFunc" 'function)) :pointer
  (self :pointer)
  (proxyType0 :int)
  (proxyType1 :int))

(cl:export '#.(bullet-wrap::swig-lispify "btDefaultCollisionConfiguration_getCollisionAlgorithmCreateFunc" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btDefaultCollisionConfiguration_setConvexConvexMultipointIterations" 'function)))

(cffi:defcfun ("_wrap_btDefaultCollisionConfiguration_setConvexConvexMultipointIterations__SWIG_0" #.(bullet-wrap::swig-lispify "btDefaultCollisionConfiguration_setConvexConvexMultipointIterations" 'function)) :void
  (self :pointer)
  (numPerturbationIterations :int)
  (minimumPointsPerturbationThreshold :int))

(cl:export '#.(bullet-wrap::swig-lispify "btDefaultCollisionConfiguration_setConvexConvexMultipointIterations" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btDefaultCollisionConfiguration_setConvexConvexMultipointIterations" 'function)))

(cffi:defcfun ("_wrap_btDefaultCollisionConfiguration_setConvexConvexMultipointIterations__SWIG_1" #.(bullet-wrap::swig-lispify "btDefaultCollisionConfiguration_setConvexConvexMultipointIterations" 'function)) :void
  (self :pointer)
  (numPerturbationIterations :int))

(cl:export '#.(bullet-wrap::swig-lispify "btDefaultCollisionConfiguration_setConvexConvexMultipointIterations" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btDefaultCollisionConfiguration_setConvexConvexMultipointIterations" 'function)))

(cffi:defcfun ("_wrap_btDefaultCollisionConfiguration_setConvexConvexMultipointIterations__SWIG_2" #.(bullet-wrap::swig-lispify "btDefaultCollisionConfiguration_setConvexConvexMultipointIterations" 'function)) :void
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btDefaultCollisionConfiguration_setConvexConvexMultipointIterations" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btDefaultCollisionConfiguration_setPlaneConvexMultipointIterations" 'function)))

(cffi:defcfun ("_wrap_btDefaultCollisionConfiguration_setPlaneConvexMultipointIterations__SWIG_0" #.(bullet-wrap::swig-lispify "btDefaultCollisionConfiguration_setPlaneConvexMultipointIterations" 'function)) :void
  (self :pointer)
  (numPerturbationIterations :int)
  (minimumPointsPerturbationThreshold :int))

(cl:export '#.(bullet-wrap::swig-lispify "btDefaultCollisionConfiguration_setPlaneConvexMultipointIterations" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btDefaultCollisionConfiguration_setPlaneConvexMultipointIterations" 'function)))

(cffi:defcfun ("_wrap_btDefaultCollisionConfiguration_setPlaneConvexMultipointIterations__SWIG_1" #.(bullet-wrap::swig-lispify "btDefaultCollisionConfiguration_setPlaneConvexMultipointIterations" 'function)) :void
  (self :pointer)
  (numPerturbationIterations :int))

(cl:export '#.(bullet-wrap::swig-lispify "btDefaultCollisionConfiguration_setPlaneConvexMultipointIterations" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btDefaultCollisionConfiguration_setPlaneConvexMultipointIterations" 'function)))

(cffi:defcfun ("_wrap_btDefaultCollisionConfiguration_setPlaneConvexMultipointIterations__SWIG_2" #.(bullet-wrap::swig-lispify "btDefaultCollisionConfiguration_setPlaneConvexMultipointIterations" 'function)) :void
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btDefaultCollisionConfiguration_setPlaneConvexMultipointIterations" 'function))

(cl:defconstant #.(bullet-wrap::swig-lispify "USE_DISPATCH_REGISTRY_ARRAY" 'constant) 1)

(cl:export '#.(bullet-wrap::swig-lispify "USE_DISPATCH_REGISTRY_ARRAY" 'constant))

(cffi:defcenum #.(bullet-wrap::swig-lispify "DispatcherFlags" 'enumname)
	(#.(bullet-wrap::swig-lispify "CD_STATIC_STATIC_REPORTED" 'enumvalue :keyword) #.1)
	(#.(bullet-wrap::swig-lispify "CD_USE_RELATIVE_CONTACT_BREAKING_THRESHOLD" 'enumvalue :keyword) #.2)
	(#.(bullet-wrap::swig-lispify "CD_DISABLE_CONTACTPOOL_DYNAMIC_ALLOCATION" 'enumvalue :keyword) #.4))

(cl:export '#.(bullet-wrap::swig-lispify "DispatcherFlags" 'enumname))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCollisionDispatcher_getDispatcherFlags" 'function)))

(cffi:defcfun ("_wrap_btCollisionDispatcher_getDispatcherFlags" #.(bullet-wrap::swig-lispify "btCollisionDispatcher_getDispatcherFlags" 'function)) :int
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btCollisionDispatcher_getDispatcherFlags" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCollisionDispatcher_setDispatcherFlags" 'function)))

(cffi:defcfun ("_wrap_btCollisionDispatcher_setDispatcherFlags" #.(bullet-wrap::swig-lispify "btCollisionDispatcher_setDispatcherFlags" 'function)) :void
  (self :pointer)
  (flags :int))

(cl:export '#.(bullet-wrap::swig-lispify "btCollisionDispatcher_setDispatcherFlags" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCollisionDispatcher_registerCollisionCreateFunc" 'function)))

(cffi:defcfun ("_wrap_btCollisionDispatcher_registerCollisionCreateFunc" #.(bullet-wrap::swig-lispify "btCollisionDispatcher_registerCollisionCreateFunc" 'function)) :void
  (self :pointer)
  (proxyType0 :int)
  (proxyType1 :int)
  (createFunc :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btCollisionDispatcher_registerCollisionCreateFunc" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCollisionDispatcher_getNumManifolds" 'function)))

(cffi:defcfun ("_wrap_btCollisionDispatcher_getNumManifolds" #.(bullet-wrap::swig-lispify "btCollisionDispatcher_getNumManifolds" 'function)) :int
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btCollisionDispatcher_getNumManifolds" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCollisionDispatcher_getInternalManifoldPointer" 'function)))

(cffi:defcfun ("_wrap_btCollisionDispatcher_getInternalManifoldPointer" #.(bullet-wrap::swig-lispify "btCollisionDispatcher_getInternalManifoldPointer" 'function)) :pointer
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btCollisionDispatcher_getInternalManifoldPointer" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCollisionDispatcher_getManifoldByIndexInternal" 'function)))

(cffi:defcfun ("_wrap_btCollisionDispatcher_getManifoldByIndexInternal__SWIG_0" #.(bullet-wrap::swig-lispify "btCollisionDispatcher_getManifoldByIndexInternal" 'function)) :pointer
  (self :pointer)
  (index :int))

(cl:export '#.(bullet-wrap::swig-lispify "btCollisionDispatcher_getManifoldByIndexInternal" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCollisionDispatcher_getManifoldByIndexInternal" 'function)))

(cffi:defcfun ("_wrap_btCollisionDispatcher_getManifoldByIndexInternal__SWIG_1" #.(bullet-wrap::swig-lispify "btCollisionDispatcher_getManifoldByIndexInternal" 'function)) :pointer
  (self :pointer)
  (index :int))

(cl:export '#.(bullet-wrap::swig-lispify "btCollisionDispatcher_getManifoldByIndexInternal" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "new_btCollisionDispatcher" 'function)))

(cffi:defcfun ("_wrap_new_btCollisionDispatcher" #.(bullet-wrap::swig-lispify "new_btCollisionDispatcher" 'function)) :pointer
  (collisionConfiguration :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "new_btCollisionDispatcher" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "delete_btCollisionDispatcher" 'function)))

(cffi:defcfun ("_wrap_delete_btCollisionDispatcher" #.(bullet-wrap::swig-lispify "delete_btCollisionDispatcher" 'function)) :void
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "delete_btCollisionDispatcher" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCollisionDispatcher_getNewManifold" 'function)))

(cffi:defcfun ("_wrap_btCollisionDispatcher_getNewManifold" #.(bullet-wrap::swig-lispify "btCollisionDispatcher_getNewManifold" 'function)) :pointer
  (self :pointer)
  (b0 :pointer)
  (b1 :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btCollisionDispatcher_getNewManifold" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCollisionDispatcher_releaseManifold" 'function)))

(cffi:defcfun ("_wrap_btCollisionDispatcher_releaseManifold" #.(bullet-wrap::swig-lispify "btCollisionDispatcher_releaseManifold" 'function)) :void
  (self :pointer)
  (manifold :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btCollisionDispatcher_releaseManifold" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCollisionDispatcher_clearManifold" 'function)))

(cffi:defcfun ("_wrap_btCollisionDispatcher_clearManifold" #.(bullet-wrap::swig-lispify "btCollisionDispatcher_clearManifold" 'function)) :void
  (self :pointer)
  (manifold :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btCollisionDispatcher_clearManifold" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCollisionDispatcher_findAlgorithm" 'function)))

(cffi:defcfun ("_wrap_btCollisionDispatcher_findAlgorithm__SWIG_0" #.(bullet-wrap::swig-lispify "btCollisionDispatcher_findAlgorithm" 'function)) :pointer
  (self :pointer)
  (body0Wrap :pointer)
  (body1Wrap :pointer)
  (sharedManifold :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btCollisionDispatcher_findAlgorithm" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCollisionDispatcher_findAlgorithm" 'function)))

(cffi:defcfun ("_wrap_btCollisionDispatcher_findAlgorithm__SWIG_1" #.(bullet-wrap::swig-lispify "btCollisionDispatcher_findAlgorithm" 'function)) :pointer
  (self :pointer)
  (body0Wrap :pointer)
  (body1Wrap :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btCollisionDispatcher_findAlgorithm" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCollisionDispatcher_needsCollision" 'function)))

(cffi:defcfun ("_wrap_btCollisionDispatcher_needsCollision" #.(bullet-wrap::swig-lispify "btCollisionDispatcher_needsCollision" 'function)) :pointer
  (self :pointer)
  (body0 :pointer)
  (body1 :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btCollisionDispatcher_needsCollision" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCollisionDispatcher_needsResponse" 'function)))

(cffi:defcfun ("_wrap_btCollisionDispatcher_needsResponse" #.(bullet-wrap::swig-lispify "btCollisionDispatcher_needsResponse" 'function)) :pointer
  (self :pointer)
  (body0 :pointer)
  (body1 :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btCollisionDispatcher_needsResponse" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCollisionDispatcher_dispatchAllCollisionPairs" 'function)))

(cffi:defcfun ("_wrap_btCollisionDispatcher_dispatchAllCollisionPairs" #.(bullet-wrap::swig-lispify "btCollisionDispatcher_dispatchAllCollisionPairs" 'function)) :void
  (self :pointer)
  (pairCache :pointer)
  (dispatchInfo :pointer)
  (dispatcher :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btCollisionDispatcher_dispatchAllCollisionPairs" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCollisionDispatcher_setNearCallback" 'function)))

(cffi:defcfun ("_wrap_btCollisionDispatcher_setNearCallback" #.(bullet-wrap::swig-lispify "btCollisionDispatcher_setNearCallback" 'function)) :void
  (self :pointer)
  (nearCallback :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btCollisionDispatcher_setNearCallback" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCollisionDispatcher_getNearCallback" 'function)))

(cffi:defcfun ("_wrap_btCollisionDispatcher_getNearCallback" #.(bullet-wrap::swig-lispify "btCollisionDispatcher_getNearCallback" 'function)) :pointer
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btCollisionDispatcher_getNearCallback" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCollisionDispatcher_defaultNearCallback" 'function)))

(cffi:defcfun ("_wrap_btCollisionDispatcher_defaultNearCallback" #.(bullet-wrap::swig-lispify "btCollisionDispatcher_defaultNearCallback" 'function)) :void
  (collisionPair :pointer)
  (dispatcher :pointer)
  (dispatchInfo :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btCollisionDispatcher_defaultNearCallback" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCollisionDispatcher_allocateCollisionAlgorithm" 'function)))

(cffi:defcfun ("_wrap_btCollisionDispatcher_allocateCollisionAlgorithm" #.(bullet-wrap::swig-lispify "btCollisionDispatcher_allocateCollisionAlgorithm" 'function)) :pointer
  (self :pointer)
  (size :int))

(cl:export '#.(bullet-wrap::swig-lispify "btCollisionDispatcher_allocateCollisionAlgorithm" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCollisionDispatcher_freeCollisionAlgorithm" 'function)))

(cffi:defcfun ("_wrap_btCollisionDispatcher_freeCollisionAlgorithm" #.(bullet-wrap::swig-lispify "btCollisionDispatcher_freeCollisionAlgorithm" 'function)) :void
  (self :pointer)
  (ptr :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btCollisionDispatcher_freeCollisionAlgorithm" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCollisionDispatcher_getCollisionConfiguration" 'function)))

(cffi:defcfun ("_wrap_btCollisionDispatcher_getCollisionConfiguration__SWIG_0" #.(bullet-wrap::swig-lispify "btCollisionDispatcher_getCollisionConfiguration" 'function)) :pointer
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btCollisionDispatcher_getCollisionConfiguration" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCollisionDispatcher_getCollisionConfiguration" 'function)))

(cffi:defcfun ("_wrap_btCollisionDispatcher_getCollisionConfiguration__SWIG_1" #.(bullet-wrap::swig-lispify "btCollisionDispatcher_getCollisionConfiguration" 'function)) :pointer
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btCollisionDispatcher_getCollisionConfiguration" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCollisionDispatcher_setCollisionConfiguration" 'function)))

(cffi:defcfun ("_wrap_btCollisionDispatcher_setCollisionConfiguration" #.(bullet-wrap::swig-lispify "btCollisionDispatcher_setCollisionConfiguration" 'function)) :void
  (self :pointer)
  (config :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btCollisionDispatcher_setCollisionConfiguration" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCollisionDispatcher_getInternalManifoldPool" 'function)))

(cffi:defcfun ("_wrap_btCollisionDispatcher_getInternalManifoldPool__SWIG_0" #.(bullet-wrap::swig-lispify "btCollisionDispatcher_getInternalManifoldPool" 'function)) :pointer
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btCollisionDispatcher_getInternalManifoldPool" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btCollisionDispatcher_getInternalManifoldPool" 'function)))

(cffi:defcfun ("_wrap_btCollisionDispatcher_getInternalManifoldPool__SWIG_1" #.(bullet-wrap::swig-lispify "btCollisionDispatcher_getInternalManifoldPool" 'function)) :pointer
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btCollisionDispatcher_getInternalManifoldPool" 'function))

(cffi:defcstruct #.(bullet-wrap::swig-lispify "btSimpleBroadphaseProxy" 'classname)
	(#.(bullet-wrap::swig-lispify "m_nextFree" 'slotname) :int)
	(#.(bullet-wrap::swig-lispify "SetNextFree" 'slotname) :pointer)
	(#.(bullet-wrap::swig-lispify "GetNextFree" 'slotname) :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btSimpleBroadphaseProxy" 'classname))

(cl:export '#.(bullet-wrap::swig-lispify "m_nextFree" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "SetNextFree" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "GetNextFree" 'slotname))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "new_btSimpleBroadphase" 'function)))

(cffi:defcfun ("_wrap_new_btSimpleBroadphase__SWIG_0" #.(bullet-wrap::swig-lispify "new_btSimpleBroadphase" 'function)) :pointer
  (maxProxies :int)
  (overlappingPairCache :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "new_btSimpleBroadphase" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "new_btSimpleBroadphase" 'function)))

(cffi:defcfun ("_wrap_new_btSimpleBroadphase__SWIG_1" #.(bullet-wrap::swig-lispify "new_btSimpleBroadphase" 'function)) :pointer
  (maxProxies :int))

(cl:export '#.(bullet-wrap::swig-lispify "new_btSimpleBroadphase" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "new_btSimpleBroadphase" 'function)))

(cffi:defcfun ("_wrap_new_btSimpleBroadphase__SWIG_2" #.(bullet-wrap::swig-lispify "new_btSimpleBroadphase" 'function)) :pointer)

(cl:export '#.(bullet-wrap::swig-lispify "new_btSimpleBroadphase" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "delete_btSimpleBroadphase" 'function)))

(cffi:defcfun ("_wrap_delete_btSimpleBroadphase" #.(bullet-wrap::swig-lispify "delete_btSimpleBroadphase" 'function)) :void
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "delete_btSimpleBroadphase" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btSimpleBroadphase_aabbOverlap" 'function)))

(cffi:defcfun ("_wrap_btSimpleBroadphase_aabbOverlap" #.(bullet-wrap::swig-lispify "btSimpleBroadphase_aabbOverlap" 'function)) :pointer
  (proxy0 :pointer)
  (proxy1 :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btSimpleBroadphase_aabbOverlap" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btSimpleBroadphase_createProxy" 'function)))

(cffi:defcfun ("_wrap_btSimpleBroadphase_createProxy" #.(bullet-wrap::swig-lispify "btSimpleBroadphase_createProxy" 'function)) :pointer
  (self :pointer)
  (aabbMin :pointer)
  (aabbMax :pointer)
  (shapeType :int)
  (userPtr :pointer)
  (collisionFilterGroup :short)
  (collisionFilterMask :short)
  (dispatcher :pointer)
  (multiSapProxy :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btSimpleBroadphase_createProxy" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btSimpleBroadphase_calculateOverlappingPairs" 'function)))

(cffi:defcfun ("_wrap_btSimpleBroadphase_calculateOverlappingPairs" #.(bullet-wrap::swig-lispify "btSimpleBroadphase_calculateOverlappingPairs" 'function)) :void
  (self :pointer)
  (dispatcher :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btSimpleBroadphase_calculateOverlappingPairs" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btSimpleBroadphase_destroyProxy" 'function)))

(cffi:defcfun ("_wrap_btSimpleBroadphase_destroyProxy" #.(bullet-wrap::swig-lispify "btSimpleBroadphase_destroyProxy" 'function)) :void
  (self :pointer)
  (proxy :pointer)
  (dispatcher :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btSimpleBroadphase_destroyProxy" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btSimpleBroadphase_setAabb" 'function)))

(cffi:defcfun ("_wrap_btSimpleBroadphase_setAabb" #.(bullet-wrap::swig-lispify "btSimpleBroadphase_setAabb" 'function)) :void
  (self :pointer)
  (proxy :pointer)
  (aabbMin :pointer)
  (aabbMax :pointer)
  (dispatcher :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btSimpleBroadphase_setAabb" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btSimpleBroadphase_getAabb" 'function)))

(cffi:defcfun ("_wrap_btSimpleBroadphase_getAabb" #.(bullet-wrap::swig-lispify "btSimpleBroadphase_getAabb" 'function)) :void
  (self :pointer)
  (proxy :pointer)
  (aabbMin :pointer)
  (aabbMax :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btSimpleBroadphase_getAabb" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btSimpleBroadphase_rayTest" 'function)))

(cffi:defcfun ("_wrap_btSimpleBroadphase_rayTest__SWIG_0" #.(bullet-wrap::swig-lispify "btSimpleBroadphase_rayTest" 'function)) :void
  (self :pointer)
  (rayFrom :pointer)
  (rayTo :pointer)
  (rayCallback :pointer)
  (aabbMin :pointer)
  (aabbMax :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btSimpleBroadphase_rayTest" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btSimpleBroadphase_rayTest" 'function)))

(cffi:defcfun ("_wrap_btSimpleBroadphase_rayTest__SWIG_1" #.(bullet-wrap::swig-lispify "btSimpleBroadphase_rayTest" 'function)) :void
  (self :pointer)
  (rayFrom :pointer)
  (rayTo :pointer)
  (rayCallback :pointer)
  (aabbMin :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btSimpleBroadphase_rayTest" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btSimpleBroadphase_rayTest" 'function)))

(cffi:defcfun ("_wrap_btSimpleBroadphase_rayTest__SWIG_2" #.(bullet-wrap::swig-lispify "btSimpleBroadphase_rayTest" 'function)) :void
  (self :pointer)
  (rayFrom :pointer)
  (rayTo :pointer)
  (rayCallback :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btSimpleBroadphase_rayTest" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btSimpleBroadphase_aabbTest" 'function)))

(cffi:defcfun ("_wrap_btSimpleBroadphase_aabbTest" #.(bullet-wrap::swig-lispify "btSimpleBroadphase_aabbTest" 'function)) :void
  (self :pointer)
  (aabbMin :pointer)
  (aabbMax :pointer)
  (callback :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btSimpleBroadphase_aabbTest" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btSimpleBroadphase_getOverlappingPairCache" 'function)))

(cffi:defcfun ("_wrap_btSimpleBroadphase_getOverlappingPairCache__SWIG_0" #.(bullet-wrap::swig-lispify "btSimpleBroadphase_getOverlappingPairCache" 'function)) :pointer
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btSimpleBroadphase_getOverlappingPairCache" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btSimpleBroadphase_getOverlappingPairCache" 'function)))

(cffi:defcfun ("_wrap_btSimpleBroadphase_getOverlappingPairCache__SWIG_1" #.(bullet-wrap::swig-lispify "btSimpleBroadphase_getOverlappingPairCache" 'function)) :pointer
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btSimpleBroadphase_getOverlappingPairCache" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btSimpleBroadphase_testAabbOverlap" 'function)))

(cffi:defcfun ("_wrap_btSimpleBroadphase_testAabbOverlap" #.(bullet-wrap::swig-lispify "btSimpleBroadphase_testAabbOverlap" 'function)) :pointer
  (self :pointer)
  (proxy0 :pointer)
  (proxy1 :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btSimpleBroadphase_testAabbOverlap" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btSimpleBroadphase_getBroadphaseAabb" 'function)))

(cffi:defcfun ("_wrap_btSimpleBroadphase_getBroadphaseAabb" #.(bullet-wrap::swig-lispify "btSimpleBroadphase_getBroadphaseAabb" 'function)) :void
  (self :pointer)
  (aabbMin :pointer)
  (aabbMax :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btSimpleBroadphase_getBroadphaseAabb" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btSimpleBroadphase_printStats" 'function)))

(cffi:defcfun ("_wrap_btSimpleBroadphase_printStats" #.(bullet-wrap::swig-lispify "btSimpleBroadphase_printStats" 'function)) :void
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btSimpleBroadphase_printStats" 'function))

(cl:defconstant #.(bullet-wrap::swig-lispify "USE_OVERLAP_TEST_ON_REMOVES" 'constant) 1)

(cl:export '#.(bullet-wrap::swig-lispify "USE_OVERLAP_TEST_ON_REMOVES" 'constant))

(cffi:defcvar ("gOverlappingPairs" #.(bullet-wrap::swig-lispify "gOverlappingPairs" 'variable))
 :int)

(cl:export '#.(bullet-wrap::swig-lispify "gOverlappingPairs" 'variable))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "new_btAxisSweep3" 'function)))

(cffi:defcfun ("_wrap_new_btAxisSweep3__SWIG_0" #.(bullet-wrap::swig-lispify "new_btAxisSweep3" 'function)) :pointer
  (worldAabbMin :pointer)
  (worldAabbMax :pointer)
  (maxHandles :unsigned-short)
  (pairCache :pointer)
  (disableRaycastAccelerator :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "new_btAxisSweep3" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "new_btAxisSweep3" 'function)))

(cffi:defcfun ("_wrap_new_btAxisSweep3__SWIG_1" #.(bullet-wrap::swig-lispify "new_btAxisSweep3" 'function)) :pointer
  (worldAabbMin :pointer)
  (worldAabbMax :pointer)
  (maxHandles :unsigned-short)
  (pairCache :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "new_btAxisSweep3" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "new_btAxisSweep3" 'function)))

(cffi:defcfun ("_wrap_new_btAxisSweep3__SWIG_2" #.(bullet-wrap::swig-lispify "new_btAxisSweep3" 'function)) :pointer
  (worldAabbMin :pointer)
  (worldAabbMax :pointer)
  (maxHandles :unsigned-short))

(cl:export '#.(bullet-wrap::swig-lispify "new_btAxisSweep3" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "new_btAxisSweep3" 'function)))

(cffi:defcfun ("_wrap_new_btAxisSweep3__SWIG_3" #.(bullet-wrap::swig-lispify "new_btAxisSweep3" 'function)) :pointer
  (worldAabbMin :pointer)
  (worldAabbMax :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "new_btAxisSweep3" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "delete_btAxisSweep3" 'function)))

(cffi:defcfun ("_wrap_delete_btAxisSweep3" #.(bullet-wrap::swig-lispify "delete_btAxisSweep3" 'function)) :void
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "delete_btAxisSweep3" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "new_bt32BitAxisSweep3" 'function)))

(cffi:defcfun ("_wrap_new_bt32BitAxisSweep3__SWIG_0" #.(bullet-wrap::swig-lispify "new_bt32BitAxisSweep3" 'function)) :pointer
  (worldAabbMin :pointer)
  (worldAabbMax :pointer)
  (maxHandles :unsigned-int)
  (pairCache :pointer)
  (disableRaycastAccelerator :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "new_bt32BitAxisSweep3" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "new_bt32BitAxisSweep3" 'function)))

(cffi:defcfun ("_wrap_new_bt32BitAxisSweep3__SWIG_1" #.(bullet-wrap::swig-lispify "new_bt32BitAxisSweep3" 'function)) :pointer
  (worldAabbMin :pointer)
  (worldAabbMax :pointer)
  (maxHandles :unsigned-int)
  (pairCache :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "new_bt32BitAxisSweep3" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "new_bt32BitAxisSweep3" 'function)))

(cffi:defcfun ("_wrap_new_bt32BitAxisSweep3__SWIG_2" #.(bullet-wrap::swig-lispify "new_bt32BitAxisSweep3" 'function)) :pointer
  (worldAabbMin :pointer)
  (worldAabbMax :pointer)
  (maxHandles :unsigned-int))

(cl:export '#.(bullet-wrap::swig-lispify "new_bt32BitAxisSweep3" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "new_bt32BitAxisSweep3" 'function)))

(cffi:defcfun ("_wrap_new_bt32BitAxisSweep3__SWIG_3" #.(bullet-wrap::swig-lispify "new_bt32BitAxisSweep3" 'function)) :pointer
  (worldAabbMin :pointer)
  (worldAabbMax :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "new_bt32BitAxisSweep3" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "delete_bt32BitAxisSweep3" 'function)))

(cffi:defcfun ("_wrap_delete_bt32BitAxisSweep3" #.(bullet-wrap::swig-lispify "delete_bt32BitAxisSweep3" 'function)) :void
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "delete_bt32BitAxisSweep3" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btMultiSapBroadphase_getBroadphaseArray" 'function)))

(cffi:defcfun ("_wrap_btMultiSapBroadphase_getBroadphaseArray__SWIG_0" #.(bullet-wrap::swig-lispify "btMultiSapBroadphase_getBroadphaseArray" 'function)) :pointer
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btMultiSapBroadphase_getBroadphaseArray" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btMultiSapBroadphase_getBroadphaseArray" 'function)))

(cffi:defcfun ("_wrap_btMultiSapBroadphase_getBroadphaseArray__SWIG_1" #.(bullet-wrap::swig-lispify "btMultiSapBroadphase_getBroadphaseArray" 'function)) :pointer
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btMultiSapBroadphase_getBroadphaseArray" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "delete_btMultiSapBroadphase" 'function)))

(cffi:defcfun ("_wrap_delete_btMultiSapBroadphase" #.(bullet-wrap::swig-lispify "delete_btMultiSapBroadphase" 'function)) :void
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "delete_btMultiSapBroadphase" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btMultiSapBroadphase_createProxy" 'function)))

(cffi:defcfun ("_wrap_btMultiSapBroadphase_createProxy" #.(bullet-wrap::swig-lispify "btMultiSapBroadphase_createProxy" 'function)) :pointer
  (self :pointer)
  (aabbMin :pointer)
  (aabbMax :pointer)
  (shapeType :int)
  (userPtr :pointer)
  (collisionFilterGroup :short)
  (collisionFilterMask :short)
  (dispatcher :pointer)
  (multiSapProxy :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btMultiSapBroadphase_createProxy" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btMultiSapBroadphase_destroyProxy" 'function)))

(cffi:defcfun ("_wrap_btMultiSapBroadphase_destroyProxy" #.(bullet-wrap::swig-lispify "btMultiSapBroadphase_destroyProxy" 'function)) :void
  (self :pointer)
  (proxy :pointer)
  (dispatcher :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btMultiSapBroadphase_destroyProxy" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btMultiSapBroadphase_setAabb" 'function)))

(cffi:defcfun ("_wrap_btMultiSapBroadphase_setAabb" #.(bullet-wrap::swig-lispify "btMultiSapBroadphase_setAabb" 'function)) :void
  (self :pointer)
  (proxy :pointer)
  (aabbMin :pointer)
  (aabbMax :pointer)
  (dispatcher :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btMultiSapBroadphase_setAabb" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btMultiSapBroadphase_getAabb" 'function)))

(cffi:defcfun ("_wrap_btMultiSapBroadphase_getAabb" #.(bullet-wrap::swig-lispify "btMultiSapBroadphase_getAabb" 'function)) :void
  (self :pointer)
  (proxy :pointer)
  (aabbMin :pointer)
  (aabbMax :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btMultiSapBroadphase_getAabb" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btMultiSapBroadphase_rayTest" 'function)))

(cffi:defcfun ("_wrap_btMultiSapBroadphase_rayTest__SWIG_0" #.(bullet-wrap::swig-lispify "btMultiSapBroadphase_rayTest" 'function)) :void
  (self :pointer)
  (rayFrom :pointer)
  (rayTo :pointer)
  (rayCallback :pointer)
  (aabbMin :pointer)
  (aabbMax :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btMultiSapBroadphase_rayTest" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btMultiSapBroadphase_rayTest" 'function)))

(cffi:defcfun ("_wrap_btMultiSapBroadphase_rayTest__SWIG_1" #.(bullet-wrap::swig-lispify "btMultiSapBroadphase_rayTest" 'function)) :void
  (self :pointer)
  (rayFrom :pointer)
  (rayTo :pointer)
  (rayCallback :pointer)
  (aabbMin :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btMultiSapBroadphase_rayTest" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btMultiSapBroadphase_rayTest" 'function)))

(cffi:defcfun ("_wrap_btMultiSapBroadphase_rayTest__SWIG_2" #.(bullet-wrap::swig-lispify "btMultiSapBroadphase_rayTest" 'function)) :void
  (self :pointer)
  (rayFrom :pointer)
  (rayTo :pointer)
  (rayCallback :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btMultiSapBroadphase_rayTest" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btMultiSapBroadphase_addToChildBroadphase" 'function)))

(cffi:defcfun ("_wrap_btMultiSapBroadphase_addToChildBroadphase" #.(bullet-wrap::swig-lispify "btMultiSapBroadphase_addToChildBroadphase" 'function)) :void
  (self :pointer)
  (parentMultiSapProxy :pointer)
  (childProxy :pointer)
  (childBroadphase :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btMultiSapBroadphase_addToChildBroadphase" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btMultiSapBroadphase_calculateOverlappingPairs" 'function)))

(cffi:defcfun ("_wrap_btMultiSapBroadphase_calculateOverlappingPairs" #.(bullet-wrap::swig-lispify "btMultiSapBroadphase_calculateOverlappingPairs" 'function)) :void
  (self :pointer)
  (dispatcher :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btMultiSapBroadphase_calculateOverlappingPairs" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btMultiSapBroadphase_testAabbOverlap" 'function)))

(cffi:defcfun ("_wrap_btMultiSapBroadphase_testAabbOverlap" #.(bullet-wrap::swig-lispify "btMultiSapBroadphase_testAabbOverlap" 'function)) :pointer
  (self :pointer)
  (proxy0 :pointer)
  (proxy1 :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btMultiSapBroadphase_testAabbOverlap" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btMultiSapBroadphase_getOverlappingPairCache" 'function)))

(cffi:defcfun ("_wrap_btMultiSapBroadphase_getOverlappingPairCache__SWIG_0" #.(bullet-wrap::swig-lispify "btMultiSapBroadphase_getOverlappingPairCache" 'function)) :pointer
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btMultiSapBroadphase_getOverlappingPairCache" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btMultiSapBroadphase_getOverlappingPairCache" 'function)))

(cffi:defcfun ("_wrap_btMultiSapBroadphase_getOverlappingPairCache__SWIG_1" #.(bullet-wrap::swig-lispify "btMultiSapBroadphase_getOverlappingPairCache" 'function)) :pointer
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btMultiSapBroadphase_getOverlappingPairCache" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btMultiSapBroadphase_getBroadphaseAabb" 'function)))

(cffi:defcfun ("_wrap_btMultiSapBroadphase_getBroadphaseAabb" #.(bullet-wrap::swig-lispify "btMultiSapBroadphase_getBroadphaseAabb" 'function)) :void
  (self :pointer)
  (aabbMin :pointer)
  (aabbMax :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btMultiSapBroadphase_getBroadphaseAabb" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btMultiSapBroadphase_buildTree" 'function)))

(cffi:defcfun ("_wrap_btMultiSapBroadphase_buildTree" #.(bullet-wrap::swig-lispify "btMultiSapBroadphase_buildTree" 'function)) :void
  (self :pointer)
  (bvhAabbMin :pointer)
  (bvhAabbMax :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btMultiSapBroadphase_buildTree" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btMultiSapBroadphase_printStats" 'function)))

(cffi:defcfun ("_wrap_btMultiSapBroadphase_printStats" #.(bullet-wrap::swig-lispify "btMultiSapBroadphase_printStats" 'function)) :void
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btMultiSapBroadphase_printStats" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btMultiSapBroadphase_quicksort" 'function)))

(cffi:defcfun ("_wrap_btMultiSapBroadphase_quicksort" #.(bullet-wrap::swig-lispify "btMultiSapBroadphase_quicksort" 'function)) :void
  (self :pointer)
  (a :pointer)
  (lo :int)
  (hi :int))

(cl:export '#.(bullet-wrap::swig-lispify "btMultiSapBroadphase_quicksort" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btMultiSapBroadphase_resetPool" 'function)))

(cffi:defcfun ("_wrap_btMultiSapBroadphase_resetPool" #.(bullet-wrap::swig-lispify "btMultiSapBroadphase_resetPool" 'function)) :void
  (self :pointer)
  (dispatcher :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btMultiSapBroadphase_resetPool" 'function))

(cl:defconstant #.(bullet-wrap::swig-lispify "DBVT_BP_PROFILE" 'constant) 0)

(cl:export '#.(bullet-wrap::swig-lispify "DBVT_BP_PROFILE" 'constant))

(cl:defconstant #.(bullet-wrap::swig-lispify "DBVT_BP_PREVENTFALSEUPDATE" 'constant) 0)

(cl:export '#.(bullet-wrap::swig-lispify "DBVT_BP_PREVENTFALSEUPDATE" 'constant))

(cl:defconstant #.(bullet-wrap::swig-lispify "DBVT_BP_ACCURATESLEEPING" 'constant) 0)

(cl:export '#.(bullet-wrap::swig-lispify "DBVT_BP_ACCURATESLEEPING" 'constant))

(cl:defconstant #.(bullet-wrap::swig-lispify "DBVT_BP_ENABLE_BENCHMARK" 'constant) 0)

(cl:export '#.(bullet-wrap::swig-lispify "DBVT_BP_ENABLE_BENCHMARK" 'constant))

(cffi:defcstruct #.(bullet-wrap::swig-lispify "btDbvtProxy" 'classname)
	(#.(bullet-wrap::swig-lispify "leaf" 'slotname) :pointer)
	(#.(bullet-wrap::swig-lispify "links" 'slotname) :pointer)
	(#.(bullet-wrap::swig-lispify "stage" 'slotname) :int))

(cl:export '#.(bullet-wrap::swig-lispify "btDbvtProxy" 'classname))

(cl:export '#.(bullet-wrap::swig-lispify "leaf" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "links" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "stage" 'slotname))

(cffi:defcstruct #.(bullet-wrap::swig-lispify "btDbvtBroadphase" 'classname)
	(#.(bullet-wrap::swig-lispify "m_sets" 'slotname) :pointer)
	(#.(bullet-wrap::swig-lispify "m_stageRoots" 'slotname) :pointer)
	(#.(bullet-wrap::swig-lispify "m_paircache" 'slotname) :pointer)
	(#.(bullet-wrap::swig-lispify "m_prediction" 'slotname) :float)
	(#.(bullet-wrap::swig-lispify "m_stageCurrent" 'slotname) :int)
	(#.(bullet-wrap::swig-lispify "m_fupdates" 'slotname) :int)
	(#.(bullet-wrap::swig-lispify "m_dupdates" 'slotname) :int)
	(#.(bullet-wrap::swig-lispify "m_cupdates" 'slotname) :int)
	(#.(bullet-wrap::swig-lispify "m_newpairs" 'slotname) :int)
	(#.(bullet-wrap::swig-lispify "m_fixedleft" 'slotname) :int)
	(#.(bullet-wrap::swig-lispify "m_updates_call" 'slotname) :unsigned-int)
	(#.(bullet-wrap::swig-lispify "m_updates_done" 'slotname) :unsigned-int)
	(#.(bullet-wrap::swig-lispify "m_updates_ratio" 'slotname) :float)
	(#.(bullet-wrap::swig-lispify "m_pid" 'slotname) :int)
	(#.(bullet-wrap::swig-lispify "m_cid" 'slotname) :int)
	(#.(bullet-wrap::swig-lispify "m_gid" 'slotname) :int)
	(#.(bullet-wrap::swig-lispify "m_releasepaircache" 'slotname) :pointer)
	(#.(bullet-wrap::swig-lispify "m_deferedcollide" 'slotname) :pointer)
	(#.(bullet-wrap::swig-lispify "m_needcleanup" 'slotname) :pointer)
	(#.(bullet-wrap::swig-lispify "collide" 'slotname) :pointer)
	(#.(bullet-wrap::swig-lispify "optimize" 'slotname) :pointer)
	(#.(bullet-wrap::swig-lispify "createProxy" 'slotname) :pointer)
	(#.(bullet-wrap::swig-lispify "destroyProxy" 'slotname) :pointer)
	(#.(bullet-wrap::swig-lispify "setAabb" 'slotname) :pointer)
	(#.(bullet-wrap::swig-lispify "rayTest" 'slotname) :pointer)
	(#.(bullet-wrap::swig-lispify "rayTest" 'slotname) :pointer)
	(#.(bullet-wrap::swig-lispify "rayTest" 'slotname) :pointer)
	(#.(bullet-wrap::swig-lispify "aabbTest" 'slotname) :pointer)
	(#.(bullet-wrap::swig-lispify "getAabb" 'slotname) :pointer)
	(#.(bullet-wrap::swig-lispify "calculateOverlappingPairs" 'slotname) :pointer)
	(#.(bullet-wrap::swig-lispify "getOverlappingPairCache" 'slotname) :pointer)
	(#.(bullet-wrap::swig-lispify "getOverlappingPairCache" 'slotname) :pointer)
	(#.(bullet-wrap::swig-lispify "getBroadphaseAabb" 'slotname) :pointer)
	(#.(bullet-wrap::swig-lispify "printStats" 'slotname) :pointer)
	(#.(bullet-wrap::swig-lispify "resetPool" 'slotname) :pointer)
	(#.(bullet-wrap::swig-lispify "performDeferredRemoval" 'slotname) :pointer)
	(#.(bullet-wrap::swig-lispify "setVelocityPrediction" 'slotname) :pointer)
	(#.(bullet-wrap::swig-lispify "getVelocityPrediction" 'slotname) :pointer)
	(#.(bullet-wrap::swig-lispify "setAabbForceUpdate" 'slotname) :pointer)
	(#.(bullet-wrap::swig-lispify "benchmark" 'slotname) :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btDbvtBroadphase" 'classname))

(cl:export '#.(bullet-wrap::swig-lispify "m_sets" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_stageRoots" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_paircache" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_prediction" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_stageCurrent" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_fupdates" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_dupdates" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_cupdates" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_newpairs" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_fixedleft" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_updates_call" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_updates_done" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_updates_ratio" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_pid" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_cid" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_gid" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_releasepaircache" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_deferedcollide" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_needcleanup" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "collide" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "optimize" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "createProxy" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "destroyProxy" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "setAabb" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "rayTest" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "rayTest" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "rayTest" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "aabbTest" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "getAabb" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "calculateOverlappingPairs" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "getOverlappingPairCache" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "getOverlappingPairCache" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "getBroadphaseAabb" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "printStats" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "resetPool" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "performDeferredRemoval" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "setVelocityPrediction" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "getVelocityPrediction" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "setAabbForceUpdate" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "benchmark" 'slotname))

(cffi:defcstruct #.(bullet-wrap::swig-lispify "btDefaultMotionState" 'classname)
	(#.(bullet-wrap::swig-lispify "m_graphicsWorldTrans" 'slotname) :pointer)
	(#.(bullet-wrap::swig-lispify "m_centerOfMassOffset" 'slotname) :pointer)
	(#.(bullet-wrap::swig-lispify "m_startWorldTrans" 'slotname) :pointer)
	(#.(bullet-wrap::swig-lispify "m_userPointer" 'slotname) :pointer)
	(#.(bullet-wrap::swig-lispify "makeCPlusPlusInstance" 'slotname) :pointer)
	(#.(bullet-wrap::swig-lispify "deleteCPlusPlusInstance" 'slotname) :pointer)
	(#.(bullet-wrap::swig-lispify "makeCPlusPlusInstance" 'slotname) :pointer)
	(#.(bullet-wrap::swig-lispify "deleteCPlusPlusInstance" 'slotname) :pointer)
	(#.(bullet-wrap::swig-lispify "makeCPlusArray" 'slotname) :pointer)
	(#.(bullet-wrap::swig-lispify "deleteCPlusArray" 'slotname) :pointer)
	(#.(bullet-wrap::swig-lispify "makeCPlusArray" 'slotname) :pointer)
	(#.(bullet-wrap::swig-lispify "deleteCPlusArray" 'slotname) :pointer)
	(#.(bullet-wrap::swig-lispify "getWorldTransform" 'slotname) :pointer)
	(#.(bullet-wrap::swig-lispify "setWorldTransform" 'slotname) :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btDefaultMotionState" 'classname))

(cl:export '#.(bullet-wrap::swig-lispify "m_graphicsWorldTrans" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_centerOfMassOffset" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_startWorldTrans" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_userPointer" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "makeCPlusPlusInstance" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "deleteCPlusPlusInstance" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "makeCPlusPlusInstance" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "deleteCPlusPlusInstance" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "makeCPlusArray" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "deleteCPlusArray" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "makeCPlusArray" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "deleteCPlusArray" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "getWorldTransform" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "setWorldTransform" 'slotname))

(cl:defconstant #.(bullet-wrap::swig-lispify "USE_BT_CLOCK" 'constant) 1)

(cl:export '#.(bullet-wrap::swig-lispify "USE_BT_CLOCK" 'constant))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "new_btClock" 'function)))

(cffi:defcfun ("_wrap_new_btClock__SWIG_0" #.(bullet-wrap::swig-lispify "new_btClock" 'function)) :pointer)

(cl:export '#.(bullet-wrap::swig-lispify "new_btClock" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "new_btClock" 'function)))

(cffi:defcfun ("_wrap_new_btClock__SWIG_1" #.(bullet-wrap::swig-lispify "new_btClock" 'function)) :pointer
  (other :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "new_btClock" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btClock_assignValue" 'function)))

(cffi:defcfun ("_wrap_btClock_assignValue" #.(bullet-wrap::swig-lispify "btClock_assignValue" 'function)) :pointer
  (self :pointer)
  (other :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btClock_assignValue" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "delete_btClock" 'function)))

(cffi:defcfun ("_wrap_delete_btClock" #.(bullet-wrap::swig-lispify "delete_btClock" 'function)) :void
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "delete_btClock" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btClock_reset" 'function)))

(cffi:defcfun ("_wrap_btClock_reset" #.(bullet-wrap::swig-lispify "btClock_reset" 'function)) :void
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btClock_reset" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btClock_getTimeMilliseconds" 'function)))

(cffi:defcfun ("_wrap_btClock_getTimeMilliseconds" #.(bullet-wrap::swig-lispify "btClock_getTimeMilliseconds" 'function)) :unsigned-long
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btClock_getTimeMilliseconds" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btClock_getTimeMicroseconds" 'function)))

(cffi:defcfun ("_wrap_btClock_getTimeMicroseconds" #.(bullet-wrap::swig-lispify "btClock_getTimeMicroseconds" 'function)) :unsigned-long
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btClock_getTimeMicroseconds" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "new_CProfileNode" 'function)))

(cffi:defcfun ("_wrap_new_CProfileNode" #.(bullet-wrap::swig-lispify "new_CProfileNode" 'function)) :pointer
  (name :string)
  (parent :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "new_CProfileNode" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "delete_CProfileNode" 'function)))

(cffi:defcfun ("_wrap_delete_CProfileNode" #.(bullet-wrap::swig-lispify "delete_CProfileNode" 'function)) :void
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "delete_CProfileNode" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "CProfileNode_Get_Sub_Node" 'function)))

(cffi:defcfun ("_wrap_CProfileNode_Get_Sub_Node" #.(bullet-wrap::swig-lispify "CProfileNode_Get_Sub_Node" 'function)) :pointer
  (self :pointer)
  (name :string))

(cl:export '#.(bullet-wrap::swig-lispify "CProfileNode_Get_Sub_Node" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "CProfileNode_Get_Parent" 'function)))

(cffi:defcfun ("_wrap_CProfileNode_Get_Parent" #.(bullet-wrap::swig-lispify "CProfileNode_Get_Parent" 'function)) :pointer
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "CProfileNode_Get_Parent" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "CProfileNode_Get_Sibling" 'function)))

(cffi:defcfun ("_wrap_CProfileNode_Get_Sibling" #.(bullet-wrap::swig-lispify "CProfileNode_Get_Sibling" 'function)) :pointer
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "CProfileNode_Get_Sibling" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "CProfileNode_Get_Child" 'function)))

(cffi:defcfun ("_wrap_CProfileNode_Get_Child" #.(bullet-wrap::swig-lispify "CProfileNode_Get_Child" 'function)) :pointer
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "CProfileNode_Get_Child" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "CProfileNode_CleanupMemory" 'function)))

(cffi:defcfun ("_wrap_CProfileNode_CleanupMemory" #.(bullet-wrap::swig-lispify "CProfileNode_CleanupMemory" 'function)) :void
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "CProfileNode_CleanupMemory" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "CProfileNode_Reset" 'function)))

(cffi:defcfun ("_wrap_CProfileNode_Reset" #.(bullet-wrap::swig-lispify "CProfileNode_Reset" 'function)) :void
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "CProfileNode_Reset" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "CProfileNode_Call" 'function)))

(cffi:defcfun ("_wrap_CProfileNode_Call" #.(bullet-wrap::swig-lispify "CProfileNode_Call" 'function)) :void
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "CProfileNode_Call" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "CProfileNode_Return" 'function)))

(cffi:defcfun ("_wrap_CProfileNode_Return" #.(bullet-wrap::swig-lispify "CProfileNode_Return" 'function)) :pointer
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "CProfileNode_Return" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "CProfileNode_Get_Name" 'function)))

(cffi:defcfun ("_wrap_CProfileNode_Get_Name" #.(bullet-wrap::swig-lispify "CProfileNode_Get_Name" 'function)) :string
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "CProfileNode_Get_Name" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "CProfileNode_Get_Total_Calls" 'function)))

(cffi:defcfun ("_wrap_CProfileNode_Get_Total_Calls" #.(bullet-wrap::swig-lispify "CProfileNode_Get_Total_Calls" 'function)) :int
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "CProfileNode_Get_Total_Calls" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "CProfileNode_Get_Total_Time" 'function)))

(cffi:defcfun ("_wrap_CProfileNode_Get_Total_Time" #.(bullet-wrap::swig-lispify "CProfileNode_Get_Total_Time" 'function)) :float
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "CProfileNode_Get_Total_Time" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "CProfileNode_GetUserPointer" 'function)))

(cffi:defcfun ("_wrap_CProfileNode_GetUserPointer" #.(bullet-wrap::swig-lispify "CProfileNode_GetUserPointer" 'function)) :pointer
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "CProfileNode_GetUserPointer" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "CProfileNode_SetUserPointer" 'function)))

(cffi:defcfun ("_wrap_CProfileNode_SetUserPointer" #.(bullet-wrap::swig-lispify "CProfileNode_SetUserPointer" 'function)) :void
  (self :pointer)
  (ptr :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "CProfileNode_SetUserPointer" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "CProfileIterator_First" 'function)))

(cffi:defcfun ("_wrap_CProfileIterator_First" #.(bullet-wrap::swig-lispify "CProfileIterator_First" 'function)) :void
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "CProfileIterator_First" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "CProfileIterator_Next" 'function)))

(cffi:defcfun ("_wrap_CProfileIterator_Next" #.(bullet-wrap::swig-lispify "CProfileIterator_Next" 'function)) :void
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "CProfileIterator_Next" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "CProfileIterator_Is_Done" 'function)))

(cffi:defcfun ("_wrap_CProfileIterator_Is_Done" #.(bullet-wrap::swig-lispify "CProfileIterator_Is_Done" 'function)) :pointer
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "CProfileIterator_Is_Done" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "CProfileIterator_Is_Root" 'function)))

(cffi:defcfun ("_wrap_CProfileIterator_Is_Root" #.(bullet-wrap::swig-lispify "CProfileIterator_Is_Root" 'function)) :pointer
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "CProfileIterator_Is_Root" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "CProfileIterator_Enter_Child" 'function)))

(cffi:defcfun ("_wrap_CProfileIterator_Enter_Child" #.(bullet-wrap::swig-lispify "CProfileIterator_Enter_Child" 'function)) :void
  (self :pointer)
  (index :int))

(cl:export '#.(bullet-wrap::swig-lispify "CProfileIterator_Enter_Child" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "CProfileIterator_Enter_Largest_Child" 'function)))

(cffi:defcfun ("_wrap_CProfileIterator_Enter_Largest_Child" #.(bullet-wrap::swig-lispify "CProfileIterator_Enter_Largest_Child" 'function)) :void
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "CProfileIterator_Enter_Largest_Child" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "CProfileIterator_Enter_Parent" 'function)))

(cffi:defcfun ("_wrap_CProfileIterator_Enter_Parent" #.(bullet-wrap::swig-lispify "CProfileIterator_Enter_Parent" 'function)) :void
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "CProfileIterator_Enter_Parent" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "CProfileIterator_Get_Current_Name" 'function)))

(cffi:defcfun ("_wrap_CProfileIterator_Get_Current_Name" #.(bullet-wrap::swig-lispify "CProfileIterator_Get_Current_Name" 'function)) :string
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "CProfileIterator_Get_Current_Name" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "CProfileIterator_Get_Current_Total_Calls" 'function)))

(cffi:defcfun ("_wrap_CProfileIterator_Get_Current_Total_Calls" #.(bullet-wrap::swig-lispify "CProfileIterator_Get_Current_Total_Calls" 'function)) :int
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "CProfileIterator_Get_Current_Total_Calls" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "CProfileIterator_Get_Current_Total_Time" 'function)))

(cffi:defcfun ("_wrap_CProfileIterator_Get_Current_Total_Time" #.(bullet-wrap::swig-lispify "CProfileIterator_Get_Current_Total_Time" 'function)) :float
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "CProfileIterator_Get_Current_Total_Time" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "CProfileIterator_Get_Current_UserPointer" 'function)))

(cffi:defcfun ("_wrap_CProfileIterator_Get_Current_UserPointer" #.(bullet-wrap::swig-lispify "CProfileIterator_Get_Current_UserPointer" 'function)) :pointer
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "CProfileIterator_Get_Current_UserPointer" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "CProfileIterator_Set_Current_UserPointer" 'function)))

(cffi:defcfun ("_wrap_CProfileIterator_Set_Current_UserPointer" #.(bullet-wrap::swig-lispify "CProfileIterator_Set_Current_UserPointer" 'function)) :void
  (self :pointer)
  (ptr :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "CProfileIterator_Set_Current_UserPointer" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "CProfileIterator_Get_Current_Parent_Name" 'function)))

(cffi:defcfun ("_wrap_CProfileIterator_Get_Current_Parent_Name" #.(bullet-wrap::swig-lispify "CProfileIterator_Get_Current_Parent_Name" 'function)) :string
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "CProfileIterator_Get_Current_Parent_Name" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "CProfileIterator_Get_Current_Parent_Total_Calls" 'function)))

(cffi:defcfun ("_wrap_CProfileIterator_Get_Current_Parent_Total_Calls" #.(bullet-wrap::swig-lispify "CProfileIterator_Get_Current_Parent_Total_Calls" 'function)) :int
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "CProfileIterator_Get_Current_Parent_Total_Calls" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "CProfileIterator_Get_Current_Parent_Total_Time" 'function)))

(cffi:defcfun ("_wrap_CProfileIterator_Get_Current_Parent_Total_Time" #.(bullet-wrap::swig-lispify "CProfileIterator_Get_Current_Parent_Total_Time" 'function)) :float
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "CProfileIterator_Get_Current_Parent_Total_Time" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "delete_CProfileIterator" 'function)))

(cffi:defcfun ("_wrap_delete_CProfileIterator" #.(bullet-wrap::swig-lispify "delete_CProfileIterator" 'function)) :void
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "delete_CProfileIterator" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "CProfileManager_Start_Profile" 'function)))

(cffi:defcfun ("_wrap_CProfileManager_Start_Profile" #.(bullet-wrap::swig-lispify "CProfileManager_Start_Profile" 'function)) :void
  (name :string))

(cl:export '#.(bullet-wrap::swig-lispify "CProfileManager_Start_Profile" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "CProfileManager_Stop_Profile" 'function)))

(cffi:defcfun ("_wrap_CProfileManager_Stop_Profile" #.(bullet-wrap::swig-lispify "CProfileManager_Stop_Profile" 'function)) :void)

(cl:export '#.(bullet-wrap::swig-lispify "CProfileManager_Stop_Profile" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "CProfileManager_CleanupMemory" 'function)))

(cffi:defcfun ("_wrap_CProfileManager_CleanupMemory" #.(bullet-wrap::swig-lispify "CProfileManager_CleanupMemory" 'function)) :void)

(cl:export '#.(bullet-wrap::swig-lispify "CProfileManager_CleanupMemory" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "CProfileManager_Reset" 'function)))

(cffi:defcfun ("_wrap_CProfileManager_Reset" #.(bullet-wrap::swig-lispify "CProfileManager_Reset" 'function)) :void)

(cl:export '#.(bullet-wrap::swig-lispify "CProfileManager_Reset" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "CProfileManager_Increment_Frame_Counter" 'function)))

(cffi:defcfun ("_wrap_CProfileManager_Increment_Frame_Counter" #.(bullet-wrap::swig-lispify "CProfileManager_Increment_Frame_Counter" 'function)) :void)

(cl:export '#.(bullet-wrap::swig-lispify "CProfileManager_Increment_Frame_Counter" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "CProfileManager_Get_Frame_Count_Since_Reset" 'function)))

(cffi:defcfun ("_wrap_CProfileManager_Get_Frame_Count_Since_Reset" #.(bullet-wrap::swig-lispify "CProfileManager_Get_Frame_Count_Since_Reset" 'function)) :int)

(cl:export '#.(bullet-wrap::swig-lispify "CProfileManager_Get_Frame_Count_Since_Reset" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "CProfileManager_Get_Time_Since_Reset" 'function)))

(cffi:defcfun ("_wrap_CProfileManager_Get_Time_Since_Reset" #.(bullet-wrap::swig-lispify "CProfileManager_Get_Time_Since_Reset" 'function)) :float)

(cl:export '#.(bullet-wrap::swig-lispify "CProfileManager_Get_Time_Since_Reset" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "CProfileManager_Get_Iterator" 'function)))

(cffi:defcfun ("_wrap_CProfileManager_Get_Iterator" #.(bullet-wrap::swig-lispify "CProfileManager_Get_Iterator" 'function)) :pointer)

(cl:export '#.(bullet-wrap::swig-lispify "CProfileManager_Get_Iterator" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "CProfileManager_Release_Iterator" 'function)))

(cffi:defcfun ("_wrap_CProfileManager_Release_Iterator" #.(bullet-wrap::swig-lispify "CProfileManager_Release_Iterator" 'function)) :void
  (iterator :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "CProfileManager_Release_Iterator" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "CProfileManager_dumpRecursive" 'function)))

(cffi:defcfun ("_wrap_CProfileManager_dumpRecursive" #.(bullet-wrap::swig-lispify "CProfileManager_dumpRecursive" 'function)) :void
  (profileIterator :pointer)
  (spacing :int))

(cl:export '#.(bullet-wrap::swig-lispify "CProfileManager_dumpRecursive" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "CProfileManager_dumpAll" 'function)))

(cffi:defcfun ("_wrap_CProfileManager_dumpAll" #.(bullet-wrap::swig-lispify "CProfileManager_dumpAll" 'function)) :void)

(cl:export '#.(bullet-wrap::swig-lispify "CProfileManager_dumpAll" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "new_CProfileManager" 'function)))

(cffi:defcfun ("_wrap_new_CProfileManager" #.(bullet-wrap::swig-lispify "new_CProfileManager" 'function)) :pointer)

(cl:export '#.(bullet-wrap::swig-lispify "new_CProfileManager" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "delete_CProfileManager" 'function)))

(cffi:defcfun ("_wrap_delete_CProfileManager" #.(bullet-wrap::swig-lispify "delete_CProfileManager" 'function)) :void
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "delete_CProfileManager" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "new_CProfileSample" 'function)))

(cffi:defcfun ("_wrap_new_CProfileSample" #.(bullet-wrap::swig-lispify "new_CProfileSample" 'function)) :pointer
  (name :string))

(cl:export '#.(bullet-wrap::swig-lispify "new_CProfileSample" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "delete_CProfileSample" 'function)))

(cffi:defcfun ("_wrap_delete_CProfileSample" #.(bullet-wrap::swig-lispify "delete_CProfileSample" 'function)) :void
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "delete_CProfileSample" 'function))

(cffi:defcenum #.(bullet-wrap::swig-lispify "DebugDrawModes" 'enumname)
	(#.(bullet-wrap::swig-lispify "DBG_NoDebug" 'enumvalue :keyword) #.0)
	(#.(bullet-wrap::swig-lispify "DBG_DrawWireframe" 'enumvalue :keyword) #.1)
	(#.(bullet-wrap::swig-lispify "DBG_DrawAabb" 'enumvalue :keyword) #.2)
	(#.(bullet-wrap::swig-lispify "DBG_DrawFeaturesText" 'enumvalue :keyword) #.4)
	(#.(bullet-wrap::swig-lispify "DBG_DrawContactPoints" 'enumvalue :keyword) #.8)
	(#.(bullet-wrap::swig-lispify "DBG_NoDeactivation" 'enumvalue :keyword) #.16)
	(#.(bullet-wrap::swig-lispify "DBG_NoHelpText" 'enumvalue :keyword) #.32)
	(#.(bullet-wrap::swig-lispify "DBG_DrawText" 'enumvalue :keyword) #.64)
	(#.(bullet-wrap::swig-lispify "DBG_ProfileTimings" 'enumvalue :keyword) #.128)
	(#.(bullet-wrap::swig-lispify "DBG_EnableSatComparison" 'enumvalue :keyword) #.256)
	(#.(bullet-wrap::swig-lispify "DBG_DisableBulletLCP" 'enumvalue :keyword) #.512)
	(#.(bullet-wrap::swig-lispify "DBG_EnableCCD" 'enumvalue :keyword) #.1024)
	(#.(bullet-wrap::swig-lispify "DBG_DrawConstraints" 'enumvalue :keyword) #.(cl:ash 1 11))
	(#.(bullet-wrap::swig-lispify "DBG_DrawConstraintLimits" 'enumvalue :keyword) #.(cl:ash 1 12))
	(#.(bullet-wrap::swig-lispify "DBG_FastWireframe" 'enumvalue :keyword) #.(cl:ash 1 13))
	(#.(bullet-wrap::swig-lispify "DBG_DrawNormals" 'enumvalue :keyword) #.(cl:ash 1 14))
	#.(bullet-wrap::swig-lispify "DBG_MAX_DEBUG_DRAW_MODE" 'enumvalue :keyword))

(cl:export '#.(bullet-wrap::swig-lispify "DebugDrawModes" 'enumname))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "delete_btIDebugDraw" 'function)))

(cffi:defcfun ("_wrap_delete_btIDebugDraw" #.(bullet-wrap::swig-lispify "delete_btIDebugDraw" 'function)) :void
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "delete_btIDebugDraw" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btIDebugDraw_drawLine" 'function)))

(cffi:defcfun ("_wrap_btIDebugDraw_drawLine__SWIG_0" #.(bullet-wrap::swig-lispify "btIDebugDraw_drawLine" 'function)) :void
  (self :pointer)
  (from :pointer)
  (to :pointer)
  (color :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btIDebugDraw_drawLine" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btIDebugDraw_drawLine" 'function)))

(cffi:defcfun ("_wrap_btIDebugDraw_drawLine__SWIG_1" #.(bullet-wrap::swig-lispify "btIDebugDraw_drawLine" 'function)) :void
  (self :pointer)
  (from :pointer)
  (to :pointer)
  (fromColor :pointer)
  (toColor :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btIDebugDraw_drawLine" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btIDebugDraw_drawSphere" 'function)))

(cffi:defcfun ("_wrap_btIDebugDraw_drawSphere__SWIG_0" #.(bullet-wrap::swig-lispify "btIDebugDraw_drawSphere" 'function)) :void
  (self :pointer)
  (radius :float)
  (transform :pointer)
  (color :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btIDebugDraw_drawSphere" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btIDebugDraw_drawSphere" 'function)))

(cffi:defcfun ("_wrap_btIDebugDraw_drawSphere__SWIG_1" #.(bullet-wrap::swig-lispify "btIDebugDraw_drawSphere" 'function)) :void
  (self :pointer)
  (p :pointer)
  (radius :float)
  (color :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btIDebugDraw_drawSphere" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btIDebugDraw_drawTriangle" 'function)))

(cffi:defcfun ("_wrap_btIDebugDraw_drawTriangle__SWIG_0" #.(bullet-wrap::swig-lispify "btIDebugDraw_drawTriangle" 'function)) :void
  (self :pointer)
  (v0 :pointer)
  (v1 :pointer)
  (v2 :pointer)
  (arg4 :pointer)
  (arg5 :pointer)
  (arg6 :pointer)
  (color :pointer)
  (alpha :float))

(cl:export '#.(bullet-wrap::swig-lispify "btIDebugDraw_drawTriangle" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btIDebugDraw_drawTriangle" 'function)))

(cffi:defcfun ("_wrap_btIDebugDraw_drawTriangle__SWIG_1" #.(bullet-wrap::swig-lispify "btIDebugDraw_drawTriangle" 'function)) :void
  (self :pointer)
  (v0 :pointer)
  (v1 :pointer)
  (v2 :pointer)
  (color :pointer)
  (arg5 :float))

(cl:export '#.(bullet-wrap::swig-lispify "btIDebugDraw_drawTriangle" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btIDebugDraw_drawContactPoint" 'function)))

(cffi:defcfun ("_wrap_btIDebugDraw_drawContactPoint" #.(bullet-wrap::swig-lispify "btIDebugDraw_drawContactPoint" 'function)) :void
  (self :pointer)
  (PointOnB :pointer)
  (normalOnB :pointer)
  (distance :float)
  (lifeTime :int)
  (color :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btIDebugDraw_drawContactPoint" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btIDebugDraw_reportErrorWarning" 'function)))

(cffi:defcfun ("_wrap_btIDebugDraw_reportErrorWarning" #.(bullet-wrap::swig-lispify "btIDebugDraw_reportErrorWarning" 'function)) :void
  (self :pointer)
  (warningString :string))

(cl:export '#.(bullet-wrap::swig-lispify "btIDebugDraw_reportErrorWarning" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btIDebugDraw_draw3dText" 'function)))

(cffi:defcfun ("_wrap_btIDebugDraw_draw3dText" #.(bullet-wrap::swig-lispify "btIDebugDraw_draw3dText" 'function)) :void
  (self :pointer)
  (location :pointer)
  (textString :string))

(cl:export '#.(bullet-wrap::swig-lispify "btIDebugDraw_draw3dText" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btIDebugDraw_setDebugMode" 'function)))

(cffi:defcfun ("_wrap_btIDebugDraw_setDebugMode" #.(bullet-wrap::swig-lispify "btIDebugDraw_setDebugMode" 'function)) :void
  (self :pointer)
  (debugMode :int))

(cl:export '#.(bullet-wrap::swig-lispify "btIDebugDraw_setDebugMode" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btIDebugDraw_getDebugMode" 'function)))

(cffi:defcfun ("_wrap_btIDebugDraw_getDebugMode" #.(bullet-wrap::swig-lispify "btIDebugDraw_getDebugMode" 'function)) :int
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btIDebugDraw_getDebugMode" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btIDebugDraw_drawAabb" 'function)))

(cffi:defcfun ("_wrap_btIDebugDraw_drawAabb" #.(bullet-wrap::swig-lispify "btIDebugDraw_drawAabb" 'function)) :void
  (self :pointer)
  (from :pointer)
  (to :pointer)
  (color :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btIDebugDraw_drawAabb" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btIDebugDraw_drawTransform" 'function)))

(cffi:defcfun ("_wrap_btIDebugDraw_drawTransform" #.(bullet-wrap::swig-lispify "btIDebugDraw_drawTransform" 'function)) :void
  (self :pointer)
  (transform :pointer)
  (orthoLen :float))

(cl:export '#.(bullet-wrap::swig-lispify "btIDebugDraw_drawTransform" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btIDebugDraw_drawArc" 'function)))

(cffi:defcfun ("_wrap_btIDebugDraw_drawArc__SWIG_0" #.(bullet-wrap::swig-lispify "btIDebugDraw_drawArc" 'function)) :void
  (self :pointer)
  (center :pointer)
  (normal :pointer)
  (axis :pointer)
  (radiusA :float)
  (radiusB :float)
  (minAngle :float)
  (maxAngle :float)
  (color :pointer)
  (drawSect :pointer)
  (stepDegrees :float))

(cl:export '#.(bullet-wrap::swig-lispify "btIDebugDraw_drawArc" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btIDebugDraw_drawArc" 'function)))

(cffi:defcfun ("_wrap_btIDebugDraw_drawArc__SWIG_1" #.(bullet-wrap::swig-lispify "btIDebugDraw_drawArc" 'function)) :void
  (self :pointer)
  (center :pointer)
  (normal :pointer)
  (axis :pointer)
  (radiusA :float)
  (radiusB :float)
  (minAngle :float)
  (maxAngle :float)
  (color :pointer)
  (drawSect :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btIDebugDraw_drawArc" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btIDebugDraw_drawSpherePatch" 'function)))

(cffi:defcfun ("_wrap_btIDebugDraw_drawSpherePatch__SWIG_0" #.(bullet-wrap::swig-lispify "btIDebugDraw_drawSpherePatch" 'function)) :void
  (self :pointer)
  (center :pointer)
  (up :pointer)
  (axis :pointer)
  (radius :float)
  (minTh :float)
  (maxTh :float)
  (minPs :float)
  (maxPs :float)
  (color :pointer)
  (stepDegrees :float)
  (drawCenter :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btIDebugDraw_drawSpherePatch" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btIDebugDraw_drawSpherePatch" 'function)))

(cffi:defcfun ("_wrap_btIDebugDraw_drawSpherePatch__SWIG_1" #.(bullet-wrap::swig-lispify "btIDebugDraw_drawSpherePatch" 'function)) :void
  (self :pointer)
  (center :pointer)
  (up :pointer)
  (axis :pointer)
  (radius :float)
  (minTh :float)
  (maxTh :float)
  (minPs :float)
  (maxPs :float)
  (color :pointer)
  (stepDegrees :float))

(cl:export '#.(bullet-wrap::swig-lispify "btIDebugDraw_drawSpherePatch" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btIDebugDraw_drawSpherePatch" 'function)))

(cffi:defcfun ("_wrap_btIDebugDraw_drawSpherePatch__SWIG_2" #.(bullet-wrap::swig-lispify "btIDebugDraw_drawSpherePatch" 'function)) :void
  (self :pointer)
  (center :pointer)
  (up :pointer)
  (axis :pointer)
  (radius :float)
  (minTh :float)
  (maxTh :float)
  (minPs :float)
  (maxPs :float)
  (color :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btIDebugDraw_drawSpherePatch" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btIDebugDraw_drawBox" 'function)))

(cffi:defcfun ("_wrap_btIDebugDraw_drawBox__SWIG_0" #.(bullet-wrap::swig-lispify "btIDebugDraw_drawBox" 'function)) :void
  (self :pointer)
  (bbMin :pointer)
  (bbMax :pointer)
  (color :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btIDebugDraw_drawBox" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btIDebugDraw_drawBox" 'function)))

(cffi:defcfun ("_wrap_btIDebugDraw_drawBox__SWIG_1" #.(bullet-wrap::swig-lispify "btIDebugDraw_drawBox" 'function)) :void
  (self :pointer)
  (bbMin :pointer)
  (bbMax :pointer)
  (trans :pointer)
  (color :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btIDebugDraw_drawBox" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btIDebugDraw_drawCapsule" 'function)))

(cffi:defcfun ("_wrap_btIDebugDraw_drawCapsule" #.(bullet-wrap::swig-lispify "btIDebugDraw_drawCapsule" 'function)) :void
  (self :pointer)
  (radius :float)
  (halfHeight :float)
  (upAxis :int)
  (transform :pointer)
  (color :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btIDebugDraw_drawCapsule" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btIDebugDraw_drawCylinder" 'function)))

(cffi:defcfun ("_wrap_btIDebugDraw_drawCylinder" #.(bullet-wrap::swig-lispify "btIDebugDraw_drawCylinder" 'function)) :void
  (self :pointer)
  (radius :float)
  (halfHeight :float)
  (upAxis :int)
  (transform :pointer)
  (color :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btIDebugDraw_drawCylinder" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btIDebugDraw_drawCone" 'function)))

(cffi:defcfun ("_wrap_btIDebugDraw_drawCone" #.(bullet-wrap::swig-lispify "btIDebugDraw_drawCone" 'function)) :void
  (self :pointer)
  (radius :float)
  (height :float)
  (upAxis :int)
  (transform :pointer)
  (color :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btIDebugDraw_drawCone" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btIDebugDraw_drawPlane" 'function)))

(cffi:defcfun ("_wrap_btIDebugDraw_drawPlane" #.(bullet-wrap::swig-lispify "btIDebugDraw_drawPlane" 'function)) :void
  (self :pointer)
  (planeNormal :pointer)
  (planeConst :float)
  (transform :pointer)
  (color :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btIDebugDraw_drawPlane" 'function))

(cffi:defcvar ("sBulletDNAstr" #.(bullet-wrap::swig-lispify "sBulletDNAstr" 'variable))
 :pointer)

(cl:export '#.(bullet-wrap::swig-lispify "sBulletDNAstr" 'variable))

(cffi:defcvar ("sBulletDNAlen" #.(bullet-wrap::swig-lispify "sBulletDNAlen" 'variable))
 :int)

(cl:export '#.(bullet-wrap::swig-lispify "sBulletDNAlen" 'variable))

(cffi:defcvar ("sBulletDNAstr64" #.(bullet-wrap::swig-lispify "sBulletDNAstr64" 'variable))
 :pointer)

(cl:export '#.(bullet-wrap::swig-lispify "sBulletDNAstr64" 'variable))

(cffi:defcvar ("sBulletDNAlen64" #.(bullet-wrap::swig-lispify "sBulletDNAlen64" 'variable))
 :int)

(cl:export '#.(bullet-wrap::swig-lispify "sBulletDNAlen64" 'variable))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btStrLen" 'function)))

(cffi:defcfun ("_wrap_btStrLen" #.(bullet-wrap::swig-lispify "btStrLen" 'function)) :int
  (str :string))

(cl:export '#.(bullet-wrap::swig-lispify "btStrLen" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btChunk_m_chunkCode_set" 'function)))

(cffi:defcfun ("_wrap_btChunk_m_chunkCode_set" #.(bullet-wrap::swig-lispify "btChunk_m_chunkCode_set" 'function)) :void
  (self :pointer)
  (m_chunkCode :int))

(cl:export '#.(bullet-wrap::swig-lispify "btChunk_m_chunkCode_set" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btChunk_m_chunkCode_get" 'function)))

(cffi:defcfun ("_wrap_btChunk_m_chunkCode_get" #.(bullet-wrap::swig-lispify "btChunk_m_chunkCode_get" 'function)) :int
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btChunk_m_chunkCode_get" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btChunk_m_length_set" 'function)))

(cffi:defcfun ("_wrap_btChunk_m_length_set" #.(bullet-wrap::swig-lispify "btChunk_m_length_set" 'function)) :void
  (self :pointer)
  (m_length :int))

(cl:export '#.(bullet-wrap::swig-lispify "btChunk_m_length_set" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btChunk_m_length_get" 'function)))

(cffi:defcfun ("_wrap_btChunk_m_length_get" #.(bullet-wrap::swig-lispify "btChunk_m_length_get" 'function)) :int
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btChunk_m_length_get" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btChunk_m_oldPtr_set" 'function)))

(cffi:defcfun ("_wrap_btChunk_m_oldPtr_set" #.(bullet-wrap::swig-lispify "btChunk_m_oldPtr_set" 'function)) :void
  (self :pointer)
  (m_oldPtr :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btChunk_m_oldPtr_set" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btChunk_m_oldPtr_get" 'function)))

(cffi:defcfun ("_wrap_btChunk_m_oldPtr_get" #.(bullet-wrap::swig-lispify "btChunk_m_oldPtr_get" 'function)) :pointer
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btChunk_m_oldPtr_get" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btChunk_m_dna_nr_set" 'function)))

(cffi:defcfun ("_wrap_btChunk_m_dna_nr_set" #.(bullet-wrap::swig-lispify "btChunk_m_dna_nr_set" 'function)) :void
  (self :pointer)
  (m_dna_nr :int))

(cl:export '#.(bullet-wrap::swig-lispify "btChunk_m_dna_nr_set" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btChunk_m_dna_nr_get" 'function)))

(cffi:defcfun ("_wrap_btChunk_m_dna_nr_get" #.(bullet-wrap::swig-lispify "btChunk_m_dna_nr_get" 'function)) :int
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btChunk_m_dna_nr_get" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btChunk_m_number_set" 'function)))

(cffi:defcfun ("_wrap_btChunk_m_number_set" #.(bullet-wrap::swig-lispify "btChunk_m_number_set" 'function)) :void
  (self :pointer)
  (m_number :int))

(cl:export '#.(bullet-wrap::swig-lispify "btChunk_m_number_set" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btChunk_m_number_get" 'function)))

(cffi:defcfun ("_wrap_btChunk_m_number_get" #.(bullet-wrap::swig-lispify "btChunk_m_number_get" 'function)) :int
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btChunk_m_number_get" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "new_btChunk" 'function)))

(cffi:defcfun ("_wrap_new_btChunk" #.(bullet-wrap::swig-lispify "new_btChunk" 'function)) :pointer)

(cl:export '#.(bullet-wrap::swig-lispify "new_btChunk" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "delete_btChunk" 'function)))

(cffi:defcfun ("_wrap_delete_btChunk" #.(bullet-wrap::swig-lispify "delete_btChunk" 'function)) :void
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "delete_btChunk" 'function))

(cffi:defcenum #.(bullet-wrap::swig-lispify "btSerializationFlags" 'enumname)
	(#.(bullet-wrap::swig-lispify "BT_SERIALIZE_NO_BVH" 'enumvalue :keyword) #.1)
	(#.(bullet-wrap::swig-lispify "BT_SERIALIZE_NO_TRIANGLEINFOMAP" 'enumvalue :keyword) #.2)
	(#.(bullet-wrap::swig-lispify "BT_SERIALIZE_NO_DUPLICATE_ASSERT" 'enumvalue :keyword) #.4))

(cl:export '#.(bullet-wrap::swig-lispify "btSerializationFlags" 'enumname))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "delete_btSerializer" 'function)))

(cffi:defcfun ("_wrap_delete_btSerializer" #.(bullet-wrap::swig-lispify "delete_btSerializer" 'function)) :void
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "delete_btSerializer" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btSerializer_getBufferPointer" 'function)))

(cffi:defcfun ("_wrap_btSerializer_getBufferPointer" #.(bullet-wrap::swig-lispify "btSerializer_getBufferPointer" 'function)) :pointer
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btSerializer_getBufferPointer" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btSerializer_getCurrentBufferSize" 'function)))

(cffi:defcfun ("_wrap_btSerializer_getCurrentBufferSize" #.(bullet-wrap::swig-lispify "btSerializer_getCurrentBufferSize" 'function)) :int
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btSerializer_getCurrentBufferSize" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btSerializer_allocate" 'function)))

(cffi:defcfun ("_wrap_btSerializer_allocate" #.(bullet-wrap::swig-lispify "btSerializer_allocate" 'function)) :pointer
  (self :pointer)
  (size :pointer)
  (numElements :int))

(cl:export '#.(bullet-wrap::swig-lispify "btSerializer_allocate" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btSerializer_finalizeChunk" 'function)))

(cffi:defcfun ("_wrap_btSerializer_finalizeChunk" #.(bullet-wrap::swig-lispify "btSerializer_finalizeChunk" 'function)) :void
  (self :pointer)
  (chunk :pointer)
  (structType :string)
  (chunkCode :int)
  (oldPtr :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btSerializer_finalizeChunk" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btSerializer_findPointer" 'function)))

(cffi:defcfun ("_wrap_btSerializer_findPointer" #.(bullet-wrap::swig-lispify "btSerializer_findPointer" 'function)) :pointer
  (self :pointer)
  (oldPtr :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btSerializer_findPointer" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btSerializer_getUniquePointer" 'function)))

(cffi:defcfun ("_wrap_btSerializer_getUniquePointer" #.(bullet-wrap::swig-lispify "btSerializer_getUniquePointer" 'function)) :pointer
  (self :pointer)
  (oldPtr :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btSerializer_getUniquePointer" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btSerializer_startSerialization" 'function)))

(cffi:defcfun ("_wrap_btSerializer_startSerialization" #.(bullet-wrap::swig-lispify "btSerializer_startSerialization" 'function)) :void
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btSerializer_startSerialization" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btSerializer_finishSerialization" 'function)))

(cffi:defcfun ("_wrap_btSerializer_finishSerialization" #.(bullet-wrap::swig-lispify "btSerializer_finishSerialization" 'function)) :void
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btSerializer_finishSerialization" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btSerializer_findNameForPointer" 'function)))

(cffi:defcfun ("_wrap_btSerializer_findNameForPointer" #.(bullet-wrap::swig-lispify "btSerializer_findNameForPointer" 'function)) :string
  (self :pointer)
  (ptr :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btSerializer_findNameForPointer" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btSerializer_registerNameForPointer" 'function)))

(cffi:defcfun ("_wrap_btSerializer_registerNameForPointer" #.(bullet-wrap::swig-lispify "btSerializer_registerNameForPointer" 'function)) :void
  (self :pointer)
  (ptr :pointer)
  (name :string))

(cl:export '#.(bullet-wrap::swig-lispify "btSerializer_registerNameForPointer" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btSerializer_serializeName" 'function)))

(cffi:defcfun ("_wrap_btSerializer_serializeName" #.(bullet-wrap::swig-lispify "btSerializer_serializeName" 'function)) :void
  (self :pointer)
  (ptr :string))

(cl:export '#.(bullet-wrap::swig-lispify "btSerializer_serializeName" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btSerializer_getSerializationFlags" 'function)))

(cffi:defcfun ("_wrap_btSerializer_getSerializationFlags" #.(bullet-wrap::swig-lispify "btSerializer_getSerializationFlags" 'function)) :int
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btSerializer_getSerializationFlags" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btSerializer_setSerializationFlags" 'function)))

(cffi:defcfun ("_wrap_btSerializer_setSerializationFlags" #.(bullet-wrap::swig-lispify "btSerializer_setSerializationFlags" 'function)) :void
  (self :pointer)
  (flags :int))

(cl:export '#.(bullet-wrap::swig-lispify "btSerializer_setSerializationFlags" 'function))

(cl:defconstant #.(bullet-wrap::swig-lispify "BT_HEADER_LENGTH" 'constant) 12)

(cl:export '#.(bullet-wrap::swig-lispify "BT_HEADER_LENGTH" 'constant))

(cffi:defcstruct #.(bullet-wrap::swig-lispify "btPointerUid" 'classname))

(cl:export '#.(bullet-wrap::swig-lispify "btPointerUid" 'classname))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "new_btDefaultSerializer" 'function)))

(cffi:defcfun ("_wrap_new_btDefaultSerializer__SWIG_0" #.(bullet-wrap::swig-lispify "new_btDefaultSerializer" 'function)) :pointer
  (totalSize :int))

(cl:export '#.(bullet-wrap::swig-lispify "new_btDefaultSerializer" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "new_btDefaultSerializer" 'function)))

(cffi:defcfun ("_wrap_new_btDefaultSerializer__SWIG_1" #.(bullet-wrap::swig-lispify "new_btDefaultSerializer" 'function)) :pointer)

(cl:export '#.(bullet-wrap::swig-lispify "new_btDefaultSerializer" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "delete_btDefaultSerializer" 'function)))

(cffi:defcfun ("_wrap_delete_btDefaultSerializer" #.(bullet-wrap::swig-lispify "delete_btDefaultSerializer" 'function)) :void
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "delete_btDefaultSerializer" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btDefaultSerializer_writeHeader" 'function)))

(cffi:defcfun ("_wrap_btDefaultSerializer_writeHeader" #.(bullet-wrap::swig-lispify "btDefaultSerializer_writeHeader" 'function)) :void
  (self :pointer)
  (buffer :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btDefaultSerializer_writeHeader" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btDefaultSerializer_startSerialization" 'function)))

(cffi:defcfun ("_wrap_btDefaultSerializer_startSerialization" #.(bullet-wrap::swig-lispify "btDefaultSerializer_startSerialization" 'function)) :void
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btDefaultSerializer_startSerialization" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btDefaultSerializer_finishSerialization" 'function)))

(cffi:defcfun ("_wrap_btDefaultSerializer_finishSerialization" #.(bullet-wrap::swig-lispify "btDefaultSerializer_finishSerialization" 'function)) :void
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btDefaultSerializer_finishSerialization" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btDefaultSerializer_getUniquePointer" 'function)))

(cffi:defcfun ("_wrap_btDefaultSerializer_getUniquePointer" #.(bullet-wrap::swig-lispify "btDefaultSerializer_getUniquePointer" 'function)) :pointer
  (self :pointer)
  (oldPtr :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btDefaultSerializer_getUniquePointer" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btDefaultSerializer_getBufferPointer" 'function)))

(cffi:defcfun ("_wrap_btDefaultSerializer_getBufferPointer" #.(bullet-wrap::swig-lispify "btDefaultSerializer_getBufferPointer" 'function)) :pointer
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btDefaultSerializer_getBufferPointer" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btDefaultSerializer_getCurrentBufferSize" 'function)))

(cffi:defcfun ("_wrap_btDefaultSerializer_getCurrentBufferSize" #.(bullet-wrap::swig-lispify "btDefaultSerializer_getCurrentBufferSize" 'function)) :int
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btDefaultSerializer_getCurrentBufferSize" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btDefaultSerializer_finalizeChunk" 'function)))

(cffi:defcfun ("_wrap_btDefaultSerializer_finalizeChunk" #.(bullet-wrap::swig-lispify "btDefaultSerializer_finalizeChunk" 'function)) :void
  (self :pointer)
  (chunk :pointer)
  (structType :string)
  (chunkCode :int)
  (oldPtr :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btDefaultSerializer_finalizeChunk" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btDefaultSerializer_internalAlloc" 'function)))

(cffi:defcfun ("_wrap_btDefaultSerializer_internalAlloc" #.(bullet-wrap::swig-lispify "btDefaultSerializer_internalAlloc" 'function)) :pointer
  (self :pointer)
  (size :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btDefaultSerializer_internalAlloc" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btDefaultSerializer_allocate" 'function)))

(cffi:defcfun ("_wrap_btDefaultSerializer_allocate" #.(bullet-wrap::swig-lispify "btDefaultSerializer_allocate" 'function)) :pointer
  (self :pointer)
  (size :pointer)
  (numElements :int))

(cl:export '#.(bullet-wrap::swig-lispify "btDefaultSerializer_allocate" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btDefaultSerializer_findNameForPointer" 'function)))

(cffi:defcfun ("_wrap_btDefaultSerializer_findNameForPointer" #.(bullet-wrap::swig-lispify "btDefaultSerializer_findNameForPointer" 'function)) :string
  (self :pointer)
  (ptr :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btDefaultSerializer_findNameForPointer" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btDefaultSerializer_registerNameForPointer" 'function)))

(cffi:defcfun ("_wrap_btDefaultSerializer_registerNameForPointer" #.(bullet-wrap::swig-lispify "btDefaultSerializer_registerNameForPointer" 'function)) :void
  (self :pointer)
  (ptr :pointer)
  (name :string))

(cl:export '#.(bullet-wrap::swig-lispify "btDefaultSerializer_registerNameForPointer" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btDefaultSerializer_serializeName" 'function)))

(cffi:defcfun ("_wrap_btDefaultSerializer_serializeName" #.(bullet-wrap::swig-lispify "btDefaultSerializer_serializeName" 'function)) :void
  (self :pointer)
  (name :string))

(cl:export '#.(bullet-wrap::swig-lispify "btDefaultSerializer_serializeName" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btDefaultSerializer_getSerializationFlags" 'function)))

(cffi:defcfun ("_wrap_btDefaultSerializer_getSerializationFlags" #.(bullet-wrap::swig-lispify "btDefaultSerializer_getSerializationFlags" 'function)) :int
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btDefaultSerializer_getSerializationFlags" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btDefaultSerializer_setSerializationFlags" 'function)))

(cffi:defcfun ("_wrap_btDefaultSerializer_setSerializationFlags" #.(bullet-wrap::swig-lispify "btDefaultSerializer_setSerializationFlags" 'function)) :void
  (self :pointer)
  (flags :int))

(cl:export '#.(bullet-wrap::swig-lispify "btDefaultSerializer_setSerializationFlags" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btDiscreteDynamicsWorld_makeCPlusPlusInstance" 'function)))

(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_makeCPlusPlusInstance__SWIG_0" #.(bullet-wrap::swig-lispify "btDiscreteDynamicsWorld_makeCPlusPlusInstance" 'function)) :pointer
  (self :pointer)
  (sizeInBytes :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btDiscreteDynamicsWorld_makeCPlusPlusInstance" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btDiscreteDynamicsWorld_deleteCPlusPlusInstance" 'function)))

(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_deleteCPlusPlusInstance__SWIG_0" #.(bullet-wrap::swig-lispify "btDiscreteDynamicsWorld_deleteCPlusPlusInstance" 'function)) :void
  (self :pointer)
  (ptr :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btDiscreteDynamicsWorld_deleteCPlusPlusInstance" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btDiscreteDynamicsWorld_makeCPlusPlusInstance" 'function)))

(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_makeCPlusPlusInstance__SWIG_1" #.(bullet-wrap::swig-lispify "btDiscreteDynamicsWorld_makeCPlusPlusInstance" 'function)) :pointer
  (self :pointer)
  (arg1 :pointer)
  (ptr :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btDiscreteDynamicsWorld_makeCPlusPlusInstance" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btDiscreteDynamicsWorld_deleteCPlusPlusInstance" 'function)))

(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_deleteCPlusPlusInstance__SWIG_1" #.(bullet-wrap::swig-lispify "btDiscreteDynamicsWorld_deleteCPlusPlusInstance" 'function)) :void
  (self :pointer)
  (arg1 :pointer)
  (arg2 :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btDiscreteDynamicsWorld_deleteCPlusPlusInstance" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btDiscreteDynamicsWorld_makeCPlusArray" 'function)))

(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_makeCPlusArray__SWIG_0" #.(bullet-wrap::swig-lispify "btDiscreteDynamicsWorld_makeCPlusArray" 'function)) :pointer
  (self :pointer)
  (sizeInBytes :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btDiscreteDynamicsWorld_makeCPlusArray" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btDiscreteDynamicsWorld_deleteCPlusArray" 'function)))

(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_deleteCPlusArray__SWIG_0" #.(bullet-wrap::swig-lispify "btDiscreteDynamicsWorld_deleteCPlusArray" 'function)) :void
  (self :pointer)
  (ptr :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btDiscreteDynamicsWorld_deleteCPlusArray" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btDiscreteDynamicsWorld_makeCPlusArray" 'function)))

(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_makeCPlusArray__SWIG_1" #.(bullet-wrap::swig-lispify "btDiscreteDynamicsWorld_makeCPlusArray" 'function)) :pointer
  (self :pointer)
  (arg1 :pointer)
  (ptr :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btDiscreteDynamicsWorld_makeCPlusArray" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btDiscreteDynamicsWorld_deleteCPlusArray" 'function)))

(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_deleteCPlusArray__SWIG_1" #.(bullet-wrap::swig-lispify "btDiscreteDynamicsWorld_deleteCPlusArray" 'function)) :void
  (self :pointer)
  (arg1 :pointer)
  (arg2 :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btDiscreteDynamicsWorld_deleteCPlusArray" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "new_btDiscreteDynamicsWorld" 'function)))

(cffi:defcfun ("_wrap_new_btDiscreteDynamicsWorld" #.(bullet-wrap::swig-lispify "new_btDiscreteDynamicsWorld" 'function)) :pointer
  (dispatcher :pointer)
  (pairCache :pointer)
  (constraintSolver :pointer)
  (collisionConfiguration :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "new_btDiscreteDynamicsWorld" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "delete_btDiscreteDynamicsWorld" 'function)))

(cffi:defcfun ("_wrap_delete_btDiscreteDynamicsWorld" #.(bullet-wrap::swig-lispify "delete_btDiscreteDynamicsWorld" 'function)) :void
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "delete_btDiscreteDynamicsWorld" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btDiscreteDynamicsWorld_stepSimulation" 'function)))

(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_stepSimulation__SWIG_0" #.(bullet-wrap::swig-lispify "btDiscreteDynamicsWorld_stepSimulation" 'function)) :int
  (self :pointer)
  (timeStep :float)
  (maxSubSteps :int)
  (fixedTimeStep :float))

(cl:export '#.(bullet-wrap::swig-lispify "btDiscreteDynamicsWorld_stepSimulation" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btDiscreteDynamicsWorld_stepSimulation" 'function)))

(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_stepSimulation__SWIG_1" #.(bullet-wrap::swig-lispify "btDiscreteDynamicsWorld_stepSimulation" 'function)) :int
  (self :pointer)
  (timeStep :float)
  (maxSubSteps :int))

(cl:export '#.(bullet-wrap::swig-lispify "btDiscreteDynamicsWorld_stepSimulation" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btDiscreteDynamicsWorld_stepSimulation" 'function)))

(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_stepSimulation__SWIG_2" #.(bullet-wrap::swig-lispify "btDiscreteDynamicsWorld_stepSimulation" 'function)) :int
  (self :pointer)
  (timeStep :float))

(cl:export '#.(bullet-wrap::swig-lispify "btDiscreteDynamicsWorld_stepSimulation" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btDiscreteDynamicsWorld_synchronizeMotionStates" 'function)))

(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_synchronizeMotionStates" #.(bullet-wrap::swig-lispify "btDiscreteDynamicsWorld_synchronizeMotionStates" 'function)) :void
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btDiscreteDynamicsWorld_synchronizeMotionStates" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btDiscreteDynamicsWorld_synchronizeSingleMotionState" 'function)))

(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_synchronizeSingleMotionState" #.(bullet-wrap::swig-lispify "btDiscreteDynamicsWorld_synchronizeSingleMotionState" 'function)) :void
  (self :pointer)
  (body :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btDiscreteDynamicsWorld_synchronizeSingleMotionState" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btDiscreteDynamicsWorld_addConstraint" 'function)))

(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_addConstraint__SWIG_0" #.(bullet-wrap::swig-lispify "btDiscreteDynamicsWorld_addConstraint" 'function)) :void
  (self :pointer)
  (constraint :pointer)
  (disableCollisionsBetweenLinkedBodies :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btDiscreteDynamicsWorld_addConstraint" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btDiscreteDynamicsWorld_addConstraint" 'function)))

(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_addConstraint__SWIG_1" #.(bullet-wrap::swig-lispify "btDiscreteDynamicsWorld_addConstraint" 'function)) :void
  (self :pointer)
  (constraint :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btDiscreteDynamicsWorld_addConstraint" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btDiscreteDynamicsWorld_removeConstraint" 'function)))

(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_removeConstraint" #.(bullet-wrap::swig-lispify "btDiscreteDynamicsWorld_removeConstraint" 'function)) :void
  (self :pointer)
  (constraint :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btDiscreteDynamicsWorld_removeConstraint" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btDiscreteDynamicsWorld_addAction" 'function)))

(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_addAction" #.(bullet-wrap::swig-lispify "btDiscreteDynamicsWorld_addAction" 'function)) :void
  (self :pointer)
  (arg1 :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btDiscreteDynamicsWorld_addAction" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btDiscreteDynamicsWorld_removeAction" 'function)))

(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_removeAction" #.(bullet-wrap::swig-lispify "btDiscreteDynamicsWorld_removeAction" 'function)) :void
  (self :pointer)
  (arg1 :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btDiscreteDynamicsWorld_removeAction" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btDiscreteDynamicsWorld_getSimulationIslandManager" 'function)))

(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_getSimulationIslandManager__SWIG_0" #.(bullet-wrap::swig-lispify "btDiscreteDynamicsWorld_getSimulationIslandManager" 'function)) :pointer
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btDiscreteDynamicsWorld_getSimulationIslandManager" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btDiscreteDynamicsWorld_getSimulationIslandManager" 'function)))

(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_getSimulationIslandManager__SWIG_1" #.(bullet-wrap::swig-lispify "btDiscreteDynamicsWorld_getSimulationIslandManager" 'function)) :pointer
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btDiscreteDynamicsWorld_getSimulationIslandManager" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btDiscreteDynamicsWorld_getCollisionWorld" 'function)))

(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_getCollisionWorld" #.(bullet-wrap::swig-lispify "btDiscreteDynamicsWorld_getCollisionWorld" 'function)) :pointer
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btDiscreteDynamicsWorld_getCollisionWorld" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btDiscreteDynamicsWorld_setGravity" 'function)))

(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_setGravity" #.(bullet-wrap::swig-lispify "btDiscreteDynamicsWorld_setGravity" 'function)) :void
  (self :pointer)
  (gravity :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btDiscreteDynamicsWorld_setGravity" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btDiscreteDynamicsWorld_getGravity" 'function)))

(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_getGravity" #.(bullet-wrap::swig-lispify "btDiscreteDynamicsWorld_getGravity" 'function)) :pointer
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btDiscreteDynamicsWorld_getGravity" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btDiscreteDynamicsWorld_addCollisionObject" 'function)))

(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_addCollisionObject__SWIG_0" #.(bullet-wrap::swig-lispify "btDiscreteDynamicsWorld_addCollisionObject" 'function)) :void
  (self :pointer)
  (collisionObject :pointer)
  (collisionFilterGroup :short)
  (collisionFilterMask :short))

(cl:export '#.(bullet-wrap::swig-lispify "btDiscreteDynamicsWorld_addCollisionObject" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btDiscreteDynamicsWorld_addCollisionObject" 'function)))

(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_addCollisionObject__SWIG_1" #.(bullet-wrap::swig-lispify "btDiscreteDynamicsWorld_addCollisionObject" 'function)) :void
  (self :pointer)
  (collisionObject :pointer)
  (collisionFilterGroup :short))

(cl:export '#.(bullet-wrap::swig-lispify "btDiscreteDynamicsWorld_addCollisionObject" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btDiscreteDynamicsWorld_addCollisionObject" 'function)))

(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_addCollisionObject__SWIG_2" #.(bullet-wrap::swig-lispify "btDiscreteDynamicsWorld_addCollisionObject" 'function)) :void
  (self :pointer)
  (collisionObject :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btDiscreteDynamicsWorld_addCollisionObject" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btDiscreteDynamicsWorld_addRigidBody" 'function)))

(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_addRigidBody__SWIG_0" #.(bullet-wrap::swig-lispify "btDiscreteDynamicsWorld_addRigidBody" 'function)) :void
  (self :pointer)
  (body :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btDiscreteDynamicsWorld_addRigidBody" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btDiscreteDynamicsWorld_addRigidBody" 'function)))

(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_addRigidBody__SWIG_1" #.(bullet-wrap::swig-lispify "btDiscreteDynamicsWorld_addRigidBody" 'function)) :void
  (self :pointer)
  (body :pointer)
  (group :short)
  (mask :short))

(cl:export '#.(bullet-wrap::swig-lispify "btDiscreteDynamicsWorld_addRigidBody" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btDiscreteDynamicsWorld_removeRigidBody" 'function)))

(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_removeRigidBody" #.(bullet-wrap::swig-lispify "btDiscreteDynamicsWorld_removeRigidBody" 'function)) :void
  (self :pointer)
  (body :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btDiscreteDynamicsWorld_removeRigidBody" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btDiscreteDynamicsWorld_removeCollisionObject" 'function)))

(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_removeCollisionObject" #.(bullet-wrap::swig-lispify "btDiscreteDynamicsWorld_removeCollisionObject" 'function)) :void
  (self :pointer)
  (collisionObject :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btDiscreteDynamicsWorld_removeCollisionObject" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btDiscreteDynamicsWorld_debugDrawConstraint" 'function)))

(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_debugDrawConstraint" #.(bullet-wrap::swig-lispify "btDiscreteDynamicsWorld_debugDrawConstraint" 'function)) :void
  (self :pointer)
  (constraint :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btDiscreteDynamicsWorld_debugDrawConstraint" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btDiscreteDynamicsWorld_debugDrawWorld" 'function)))

(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_debugDrawWorld" #.(bullet-wrap::swig-lispify "btDiscreteDynamicsWorld_debugDrawWorld" 'function)) :void
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btDiscreteDynamicsWorld_debugDrawWorld" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btDiscreteDynamicsWorld_setConstraintSolver" 'function)))

(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_setConstraintSolver" #.(bullet-wrap::swig-lispify "btDiscreteDynamicsWorld_setConstraintSolver" 'function)) :void
  (self :pointer)
  (solver :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btDiscreteDynamicsWorld_setConstraintSolver" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btDiscreteDynamicsWorld_getConstraintSolver" 'function)))

(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_getConstraintSolver" #.(bullet-wrap::swig-lispify "btDiscreteDynamicsWorld_getConstraintSolver" 'function)) :pointer
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btDiscreteDynamicsWorld_getConstraintSolver" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btDiscreteDynamicsWorld_getNumConstraints" 'function)))

(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_getNumConstraints" #.(bullet-wrap::swig-lispify "btDiscreteDynamicsWorld_getNumConstraints" 'function)) :int
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btDiscreteDynamicsWorld_getNumConstraints" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btDiscreteDynamicsWorld_getConstraint" 'function)))

(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_getConstraint__SWIG_0" #.(bullet-wrap::swig-lispify "btDiscreteDynamicsWorld_getConstraint" 'function)) :pointer
  (self :pointer)
  (index :int))

(cl:export '#.(bullet-wrap::swig-lispify "btDiscreteDynamicsWorld_getConstraint" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btDiscreteDynamicsWorld_getConstraint" 'function)))

(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_getConstraint__SWIG_1" #.(bullet-wrap::swig-lispify "btDiscreteDynamicsWorld_getConstraint" 'function)) :pointer
  (self :pointer)
  (index :int))

(cl:export '#.(bullet-wrap::swig-lispify "btDiscreteDynamicsWorld_getConstraint" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btDiscreteDynamicsWorld_getWorldType" 'function)))

(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_getWorldType" #.(bullet-wrap::swig-lispify "btDiscreteDynamicsWorld_getWorldType" 'function)) :pointer
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btDiscreteDynamicsWorld_getWorldType" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btDiscreteDynamicsWorld_clearForces" 'function)))

(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_clearForces" #.(bullet-wrap::swig-lispify "btDiscreteDynamicsWorld_clearForces" 'function)) :void
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btDiscreteDynamicsWorld_clearForces" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btDiscreteDynamicsWorld_applyGravity" 'function)))

(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_applyGravity" #.(bullet-wrap::swig-lispify "btDiscreteDynamicsWorld_applyGravity" 'function)) :void
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btDiscreteDynamicsWorld_applyGravity" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btDiscreteDynamicsWorld_setNumTasks" 'function)))

(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_setNumTasks" #.(bullet-wrap::swig-lispify "btDiscreteDynamicsWorld_setNumTasks" 'function)) :void
  (self :pointer)
  (numTasks :int))

(cl:export '#.(bullet-wrap::swig-lispify "btDiscreteDynamicsWorld_setNumTasks" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btDiscreteDynamicsWorld_updateVehicles" 'function)))

(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_updateVehicles" #.(bullet-wrap::swig-lispify "btDiscreteDynamicsWorld_updateVehicles" 'function)) :void
  (self :pointer)
  (timeStep :float))

(cl:export '#.(bullet-wrap::swig-lispify "btDiscreteDynamicsWorld_updateVehicles" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btDiscreteDynamicsWorld_addVehicle" 'function)))

(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_addVehicle" #.(bullet-wrap::swig-lispify "btDiscreteDynamicsWorld_addVehicle" 'function)) :void
  (self :pointer)
  (vehicle :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btDiscreteDynamicsWorld_addVehicle" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btDiscreteDynamicsWorld_removeVehicle" 'function)))

(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_removeVehicle" #.(bullet-wrap::swig-lispify "btDiscreteDynamicsWorld_removeVehicle" 'function)) :void
  (self :pointer)
  (vehicle :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btDiscreteDynamicsWorld_removeVehicle" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btDiscreteDynamicsWorld_addCharacter" 'function)))

(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_addCharacter" #.(bullet-wrap::swig-lispify "btDiscreteDynamicsWorld_addCharacter" 'function)) :void
  (self :pointer)
  (character :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btDiscreteDynamicsWorld_addCharacter" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btDiscreteDynamicsWorld_removeCharacter" 'function)))

(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_removeCharacter" #.(bullet-wrap::swig-lispify "btDiscreteDynamicsWorld_removeCharacter" 'function)) :void
  (self :pointer)
  (character :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btDiscreteDynamicsWorld_removeCharacter" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btDiscreteDynamicsWorld_setSynchronizeAllMotionStates" 'function)))

(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_setSynchronizeAllMotionStates" #.(bullet-wrap::swig-lispify "btDiscreteDynamicsWorld_setSynchronizeAllMotionStates" 'function)) :void
  (self :pointer)
  (synchronizeAll :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btDiscreteDynamicsWorld_setSynchronizeAllMotionStates" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btDiscreteDynamicsWorld_getSynchronizeAllMotionStates" 'function)))

(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_getSynchronizeAllMotionStates" #.(bullet-wrap::swig-lispify "btDiscreteDynamicsWorld_getSynchronizeAllMotionStates" 'function)) :pointer
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btDiscreteDynamicsWorld_getSynchronizeAllMotionStates" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btDiscreteDynamicsWorld_setApplySpeculativeContactRestitution" 'function)))

(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_setApplySpeculativeContactRestitution" #.(bullet-wrap::swig-lispify "btDiscreteDynamicsWorld_setApplySpeculativeContactRestitution" 'function)) :void
  (self :pointer)
  (enable :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btDiscreteDynamicsWorld_setApplySpeculativeContactRestitution" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btDiscreteDynamicsWorld_getApplySpeculativeContactRestitution" 'function)))

(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_getApplySpeculativeContactRestitution" #.(bullet-wrap::swig-lispify "btDiscreteDynamicsWorld_getApplySpeculativeContactRestitution" 'function)) :pointer
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btDiscreteDynamicsWorld_getApplySpeculativeContactRestitution" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btDiscreteDynamicsWorld_serialize" 'function)))

(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_serialize" #.(bullet-wrap::swig-lispify "btDiscreteDynamicsWorld_serialize" 'function)) :void
  (self :pointer)
  (serializer :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btDiscreteDynamicsWorld_serialize" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btDiscreteDynamicsWorld_setLatencyMotionStateInterpolation" 'function)))

(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_setLatencyMotionStateInterpolation" #.(bullet-wrap::swig-lispify "btDiscreteDynamicsWorld_setLatencyMotionStateInterpolation" 'function)) :void
  (self :pointer)
  (latencyInterpolation :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btDiscreteDynamicsWorld_setLatencyMotionStateInterpolation" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btDiscreteDynamicsWorld_getLatencyMotionStateInterpolation" 'function)))

(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_getLatencyMotionStateInterpolation" #.(bullet-wrap::swig-lispify "btDiscreteDynamicsWorld_getLatencyMotionStateInterpolation" 'function)) :pointer
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btDiscreteDynamicsWorld_getLatencyMotionStateInterpolation" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "new_btSimpleDynamicsWorld" 'function)))

(cffi:defcfun ("_wrap_new_btSimpleDynamicsWorld" #.(bullet-wrap::swig-lispify "new_btSimpleDynamicsWorld" 'function)) :pointer
  (dispatcher :pointer)
  (pairCache :pointer)
  (constraintSolver :pointer)
  (collisionConfiguration :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "new_btSimpleDynamicsWorld" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "delete_btSimpleDynamicsWorld" 'function)))

(cffi:defcfun ("_wrap_delete_btSimpleDynamicsWorld" #.(bullet-wrap::swig-lispify "delete_btSimpleDynamicsWorld" 'function)) :void
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "delete_btSimpleDynamicsWorld" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btSimpleDynamicsWorld_stepSimulation" 'function)))

(cffi:defcfun ("_wrap_btSimpleDynamicsWorld_stepSimulation__SWIG_0" #.(bullet-wrap::swig-lispify "btSimpleDynamicsWorld_stepSimulation" 'function)) :int
  (self :pointer)
  (timeStep :float)
  (maxSubSteps :int)
  (fixedTimeStep :float))

(cl:export '#.(bullet-wrap::swig-lispify "btSimpleDynamicsWorld_stepSimulation" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btSimpleDynamicsWorld_stepSimulation" 'function)))

(cffi:defcfun ("_wrap_btSimpleDynamicsWorld_stepSimulation__SWIG_1" #.(bullet-wrap::swig-lispify "btSimpleDynamicsWorld_stepSimulation" 'function)) :int
  (self :pointer)
  (timeStep :float)
  (maxSubSteps :int))

(cl:export '#.(bullet-wrap::swig-lispify "btSimpleDynamicsWorld_stepSimulation" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btSimpleDynamicsWorld_stepSimulation" 'function)))

(cffi:defcfun ("_wrap_btSimpleDynamicsWorld_stepSimulation__SWIG_2" #.(bullet-wrap::swig-lispify "btSimpleDynamicsWorld_stepSimulation" 'function)) :int
  (self :pointer)
  (timeStep :float))

(cl:export '#.(bullet-wrap::swig-lispify "btSimpleDynamicsWorld_stepSimulation" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btSimpleDynamicsWorld_setGravity" 'function)))

(cffi:defcfun ("_wrap_btSimpleDynamicsWorld_setGravity" #.(bullet-wrap::swig-lispify "btSimpleDynamicsWorld_setGravity" 'function)) :void
  (self :pointer)
  (gravity :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btSimpleDynamicsWorld_setGravity" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btSimpleDynamicsWorld_getGravity" 'function)))

(cffi:defcfun ("_wrap_btSimpleDynamicsWorld_getGravity" #.(bullet-wrap::swig-lispify "btSimpleDynamicsWorld_getGravity" 'function)) :pointer
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btSimpleDynamicsWorld_getGravity" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btSimpleDynamicsWorld_addRigidBody" 'function)))

(cffi:defcfun ("_wrap_btSimpleDynamicsWorld_addRigidBody__SWIG_0" #.(bullet-wrap::swig-lispify "btSimpleDynamicsWorld_addRigidBody" 'function)) :void
  (self :pointer)
  (body :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btSimpleDynamicsWorld_addRigidBody" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btSimpleDynamicsWorld_addRigidBody" 'function)))

(cffi:defcfun ("_wrap_btSimpleDynamicsWorld_addRigidBody__SWIG_1" #.(bullet-wrap::swig-lispify "btSimpleDynamicsWorld_addRigidBody" 'function)) :void
  (self :pointer)
  (body :pointer)
  (group :short)
  (mask :short))

(cl:export '#.(bullet-wrap::swig-lispify "btSimpleDynamicsWorld_addRigidBody" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btSimpleDynamicsWorld_removeRigidBody" 'function)))

(cffi:defcfun ("_wrap_btSimpleDynamicsWorld_removeRigidBody" #.(bullet-wrap::swig-lispify "btSimpleDynamicsWorld_removeRigidBody" 'function)) :void
  (self :pointer)
  (body :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btSimpleDynamicsWorld_removeRigidBody" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btSimpleDynamicsWorld_debugDrawWorld" 'function)))

(cffi:defcfun ("_wrap_btSimpleDynamicsWorld_debugDrawWorld" #.(bullet-wrap::swig-lispify "btSimpleDynamicsWorld_debugDrawWorld" 'function)) :void
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btSimpleDynamicsWorld_debugDrawWorld" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btSimpleDynamicsWorld_addAction" 'function)))

(cffi:defcfun ("_wrap_btSimpleDynamicsWorld_addAction" #.(bullet-wrap::swig-lispify "btSimpleDynamicsWorld_addAction" 'function)) :void
  (self :pointer)
  (action :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btSimpleDynamicsWorld_addAction" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btSimpleDynamicsWorld_removeAction" 'function)))

(cffi:defcfun ("_wrap_btSimpleDynamicsWorld_removeAction" #.(bullet-wrap::swig-lispify "btSimpleDynamicsWorld_removeAction" 'function)) :void
  (self :pointer)
  (action :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btSimpleDynamicsWorld_removeAction" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btSimpleDynamicsWorld_removeCollisionObject" 'function)))

(cffi:defcfun ("_wrap_btSimpleDynamicsWorld_removeCollisionObject" #.(bullet-wrap::swig-lispify "btSimpleDynamicsWorld_removeCollisionObject" 'function)) :void
  (self :pointer)
  (collisionObject :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btSimpleDynamicsWorld_removeCollisionObject" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btSimpleDynamicsWorld_updateAabbs" 'function)))

(cffi:defcfun ("_wrap_btSimpleDynamicsWorld_updateAabbs" #.(bullet-wrap::swig-lispify "btSimpleDynamicsWorld_updateAabbs" 'function)) :void
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btSimpleDynamicsWorld_updateAabbs" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btSimpleDynamicsWorld_synchronizeMotionStates" 'function)))

(cffi:defcfun ("_wrap_btSimpleDynamicsWorld_synchronizeMotionStates" #.(bullet-wrap::swig-lispify "btSimpleDynamicsWorld_synchronizeMotionStates" 'function)) :void
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btSimpleDynamicsWorld_synchronizeMotionStates" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btSimpleDynamicsWorld_setConstraintSolver" 'function)))

(cffi:defcfun ("_wrap_btSimpleDynamicsWorld_setConstraintSolver" #.(bullet-wrap::swig-lispify "btSimpleDynamicsWorld_setConstraintSolver" 'function)) :void
  (self :pointer)
  (solver :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btSimpleDynamicsWorld_setConstraintSolver" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btSimpleDynamicsWorld_getConstraintSolver" 'function)))

(cffi:defcfun ("_wrap_btSimpleDynamicsWorld_getConstraintSolver" #.(bullet-wrap::swig-lispify "btSimpleDynamicsWorld_getConstraintSolver" 'function)) :pointer
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btSimpleDynamicsWorld_getConstraintSolver" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btSimpleDynamicsWorld_getWorldType" 'function)))

(cffi:defcfun ("_wrap_btSimpleDynamicsWorld_getWorldType" #.(bullet-wrap::swig-lispify "btSimpleDynamicsWorld_getWorldType" 'function)) :pointer
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btSimpleDynamicsWorld_getWorldType" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btSimpleDynamicsWorld_clearForces" 'function)))

(cffi:defcfun ("_wrap_btSimpleDynamicsWorld_clearForces" #.(bullet-wrap::swig-lispify "btSimpleDynamicsWorld_clearForces" 'function)) :void
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btSimpleDynamicsWorld_clearForces" 'function))

(cffi:defcvar ("gDeactivationTime" #.(bullet-wrap::swig-lispify "gDeactivationTime" 'variable))
 :float)

(cl:export '#.(bullet-wrap::swig-lispify "gDeactivationTime" 'variable))

(cffi:defcvar ("gDisableDeactivation" #.(bullet-wrap::swig-lispify "gDisableDeactivation" 'variable))
 :pointer)

(cl:export '#.(bullet-wrap::swig-lispify "gDisableDeactivation" 'variable))

(cl:defconstant #.(bullet-wrap::swig-lispify "btRigidBodyDataName" 'constant) "btRigidBodyFloatData")

(cl:export '#.(bullet-wrap::swig-lispify "btRigidBodyDataName" 'constant))

(cffi:defcenum #.(bullet-wrap::swig-lispify "btRigidBodyFlags" 'enumname)
	(#.(bullet-wrap::swig-lispify "BT_DISABLE_WORLD_GRAVITY" 'enumvalue :keyword) #.1)
	(#.(bullet-wrap::swig-lispify "BT_ENABLE_GYROPSCOPIC_FORCE" 'enumvalue :keyword) #.2))

(cl:export '#.(bullet-wrap::swig-lispify "btRigidBodyFlags" 'enumname))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "new_btRigidBody" 'function)))

(cffi:defcfun ("_wrap_new_btRigidBody__SWIG_0" #.(bullet-wrap::swig-lispify "new_btRigidBody" 'function)) :pointer
  (constructionInfo :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "new_btRigidBody" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "new_btRigidBody" 'function)))

(cffi:defcfun ("_wrap_new_btRigidBody__SWIG_1" #.(bullet-wrap::swig-lispify "new_btRigidBody" 'function)) :pointer
  (mass :float)
  (motionState :pointer)
  (collisionShape :pointer)
  (localInertia :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "new_btRigidBody" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "new_btRigidBody" 'function)))

(cffi:defcfun ("_wrap_new_btRigidBody__SWIG_2" #.(bullet-wrap::swig-lispify "new_btRigidBody" 'function)) :pointer
  (mass :float)
  (motionState :pointer)
  (collisionShape :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "new_btRigidBody" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "delete_btRigidBody" 'function)))

(cffi:defcfun ("_wrap_delete_btRigidBody" #.(bullet-wrap::swig-lispify "delete_btRigidBody" 'function)) :void
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "delete_btRigidBody" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btRigidBody_proceedToTransform" 'function)))

(cffi:defcfun ("_wrap_btRigidBody_proceedToTransform" #.(bullet-wrap::swig-lispify "btRigidBody_proceedToTransform" 'function)) :void
  (self :pointer)
  (newTrans :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btRigidBody_proceedToTransform" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btRigidBody_upcast" 'function)))

(cffi:defcfun ("_wrap_btRigidBody_upcast__SWIG_0" #.(bullet-wrap::swig-lispify "btRigidBody_upcast" 'function)) :pointer
  (colObj :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btRigidBody_upcast" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btRigidBody_upcast" 'function)))

(cffi:defcfun ("_wrap_btRigidBody_upcast__SWIG_1" #.(bullet-wrap::swig-lispify "btRigidBody_upcast" 'function)) :pointer
  (colObj :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btRigidBody_upcast" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btRigidBody_predictIntegratedTransform" 'function)))

(cffi:defcfun ("_wrap_btRigidBody_predictIntegratedTransform" #.(bullet-wrap::swig-lispify "btRigidBody_predictIntegratedTransform" 'function)) :void
  (self :pointer)
  (step :float)
  (predictedTransform :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btRigidBody_predictIntegratedTransform" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btRigidBody_saveKinematicState" 'function)))

(cffi:defcfun ("_wrap_btRigidBody_saveKinematicState" #.(bullet-wrap::swig-lispify "btRigidBody_saveKinematicState" 'function)) :void
  (self :pointer)
  (step :float))

(cl:export '#.(bullet-wrap::swig-lispify "btRigidBody_saveKinematicState" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btRigidBody_applyGravity" 'function)))

(cffi:defcfun ("_wrap_btRigidBody_applyGravity" #.(bullet-wrap::swig-lispify "btRigidBody_applyGravity" 'function)) :void
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btRigidBody_applyGravity" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btRigidBody_setGravity" 'function)))

(cffi:defcfun ("_wrap_btRigidBody_setGravity" #.(bullet-wrap::swig-lispify "btRigidBody_setGravity" 'function)) :void
  (self :pointer)
  (acceleration :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btRigidBody_setGravity" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btRigidBody_getGravity" 'function)))

(cffi:defcfun ("_wrap_btRigidBody_getGravity" #.(bullet-wrap::swig-lispify "btRigidBody_getGravity" 'function)) :pointer
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btRigidBody_getGravity" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btRigidBody_setDamping" 'function)))

(cffi:defcfun ("_wrap_btRigidBody_setDamping" #.(bullet-wrap::swig-lispify "btRigidBody_setDamping" 'function)) :void
  (self :pointer)
  (lin_damping :float)
  (ang_damping :float))

(cl:export '#.(bullet-wrap::swig-lispify "btRigidBody_setDamping" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btRigidBody_getLinearDamping" 'function)))

(cffi:defcfun ("_wrap_btRigidBody_getLinearDamping" #.(bullet-wrap::swig-lispify "btRigidBody_getLinearDamping" 'function)) :float
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btRigidBody_getLinearDamping" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btRigidBody_getAngularDamping" 'function)))

(cffi:defcfun ("_wrap_btRigidBody_getAngularDamping" #.(bullet-wrap::swig-lispify "btRigidBody_getAngularDamping" 'function)) :float
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btRigidBody_getAngularDamping" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btRigidBody_getLinearSleepingThreshold" 'function)))

(cffi:defcfun ("_wrap_btRigidBody_getLinearSleepingThreshold" #.(bullet-wrap::swig-lispify "btRigidBody_getLinearSleepingThreshold" 'function)) :float
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btRigidBody_getLinearSleepingThreshold" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btRigidBody_getAngularSleepingThreshold" 'function)))

(cffi:defcfun ("_wrap_btRigidBody_getAngularSleepingThreshold" #.(bullet-wrap::swig-lispify "btRigidBody_getAngularSleepingThreshold" 'function)) :float
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btRigidBody_getAngularSleepingThreshold" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btRigidBody_applyDamping" 'function)))

(cffi:defcfun ("_wrap_btRigidBody_applyDamping" #.(bullet-wrap::swig-lispify "btRigidBody_applyDamping" 'function)) :void
  (self :pointer)
  (timeStep :float))

(cl:export '#.(bullet-wrap::swig-lispify "btRigidBody_applyDamping" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btRigidBody_getCollisionShape" 'function)))

(cffi:defcfun ("_wrap_btRigidBody_getCollisionShape__SWIG_0" #.(bullet-wrap::swig-lispify "btRigidBody_getCollisionShape" 'function)) :pointer
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btRigidBody_getCollisionShape" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btRigidBody_getCollisionShape" 'function)))

(cffi:defcfun ("_wrap_btRigidBody_getCollisionShape__SWIG_1" #.(bullet-wrap::swig-lispify "btRigidBody_getCollisionShape" 'function)) :pointer
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btRigidBody_getCollisionShape" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btRigidBody_setMassProps" 'function)))

(cffi:defcfun ("_wrap_btRigidBody_setMassProps" #.(bullet-wrap::swig-lispify "btRigidBody_setMassProps" 'function)) :void
  (self :pointer)
  (mass :float)
  (inertia :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btRigidBody_setMassProps" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btRigidBody_getLinearFactor" 'function)))

(cffi:defcfun ("_wrap_btRigidBody_getLinearFactor" #.(bullet-wrap::swig-lispify "btRigidBody_getLinearFactor" 'function)) :pointer
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btRigidBody_getLinearFactor" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btRigidBody_setLinearFactor" 'function)))

(cffi:defcfun ("_wrap_btRigidBody_setLinearFactor" #.(bullet-wrap::swig-lispify "btRigidBody_setLinearFactor" 'function)) :void
  (self :pointer)
  (linearFactor :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btRigidBody_setLinearFactor" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btRigidBody_getInvMass" 'function)))

(cffi:defcfun ("_wrap_btRigidBody_getInvMass" #.(bullet-wrap::swig-lispify "btRigidBody_getInvMass" 'function)) :float
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btRigidBody_getInvMass" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btRigidBody_getInvInertiaTensorWorld" 'function)))

(cffi:defcfun ("_wrap_btRigidBody_getInvInertiaTensorWorld" #.(bullet-wrap::swig-lispify "btRigidBody_getInvInertiaTensorWorld" 'function)) :pointer
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btRigidBody_getInvInertiaTensorWorld" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btRigidBody_integrateVelocities" 'function)))

(cffi:defcfun ("_wrap_btRigidBody_integrateVelocities" #.(bullet-wrap::swig-lispify "btRigidBody_integrateVelocities" 'function)) :void
  (self :pointer)
  (step :float))

(cl:export '#.(bullet-wrap::swig-lispify "btRigidBody_integrateVelocities" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btRigidBody_setCenterOfMassTransform" 'function)))

(cffi:defcfun ("_wrap_btRigidBody_setCenterOfMassTransform" #.(bullet-wrap::swig-lispify "btRigidBody_setCenterOfMassTransform" 'function)) :void
  (self :pointer)
  (xform :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btRigidBody_setCenterOfMassTransform" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btRigidBody_applyCentralForce" 'function)))

(cffi:defcfun ("_wrap_btRigidBody_applyCentralForce" #.(bullet-wrap::swig-lispify "btRigidBody_applyCentralForce" 'function)) :void
  (self :pointer)
  (force :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btRigidBody_applyCentralForce" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btRigidBody_getTotalForce" 'function)))

(cffi:defcfun ("_wrap_btRigidBody_getTotalForce" #.(bullet-wrap::swig-lispify "btRigidBody_getTotalForce" 'function)) :pointer
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btRigidBody_getTotalForce" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btRigidBody_getTotalTorque" 'function)))

(cffi:defcfun ("_wrap_btRigidBody_getTotalTorque" #.(bullet-wrap::swig-lispify "btRigidBody_getTotalTorque" 'function)) :pointer
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btRigidBody_getTotalTorque" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btRigidBody_getInvInertiaDiagLocal" 'function)))

(cffi:defcfun ("_wrap_btRigidBody_getInvInertiaDiagLocal" #.(bullet-wrap::swig-lispify "btRigidBody_getInvInertiaDiagLocal" 'function)) :pointer
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btRigidBody_getInvInertiaDiagLocal" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btRigidBody_setInvInertiaDiagLocal" 'function)))

(cffi:defcfun ("_wrap_btRigidBody_setInvInertiaDiagLocal" #.(bullet-wrap::swig-lispify "btRigidBody_setInvInertiaDiagLocal" 'function)) :void
  (self :pointer)
  (diagInvInertia :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btRigidBody_setInvInertiaDiagLocal" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btRigidBody_setSleepingThresholds" 'function)))

(cffi:defcfun ("_wrap_btRigidBody_setSleepingThresholds" #.(bullet-wrap::swig-lispify "btRigidBody_setSleepingThresholds" 'function)) :void
  (self :pointer)
  (linear :float)
  (angular :float))

(cl:export '#.(bullet-wrap::swig-lispify "btRigidBody_setSleepingThresholds" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btRigidBody_applyTorque" 'function)))

(cffi:defcfun ("_wrap_btRigidBody_applyTorque" #.(bullet-wrap::swig-lispify "btRigidBody_applyTorque" 'function)) :void
  (self :pointer)
  (torque :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btRigidBody_applyTorque" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btRigidBody_applyForce" 'function)))

(cffi:defcfun ("_wrap_btRigidBody_applyForce" #.(bullet-wrap::swig-lispify "btRigidBody_applyForce" 'function)) :void
  (self :pointer)
  (force :pointer)
  (rel_pos :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btRigidBody_applyForce" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btRigidBody_applyCentralImpulse" 'function)))

(cffi:defcfun ("_wrap_btRigidBody_applyCentralImpulse" #.(bullet-wrap::swig-lispify "btRigidBody_applyCentralImpulse" 'function)) :void
  (self :pointer)
  (impulse :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btRigidBody_applyCentralImpulse" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btRigidBody_applyTorqueImpulse" 'function)))

(cffi:defcfun ("_wrap_btRigidBody_applyTorqueImpulse" #.(bullet-wrap::swig-lispify "btRigidBody_applyTorqueImpulse" 'function)) :void
  (self :pointer)
  (torque :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btRigidBody_applyTorqueImpulse" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btRigidBody_applyImpulse" 'function)))

(cffi:defcfun ("_wrap_btRigidBody_applyImpulse" #.(bullet-wrap::swig-lispify "btRigidBody_applyImpulse" 'function)) :void
  (self :pointer)
  (impulse :pointer)
  (rel_pos :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btRigidBody_applyImpulse" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btRigidBody_clearForces" 'function)))

(cffi:defcfun ("_wrap_btRigidBody_clearForces" #.(bullet-wrap::swig-lispify "btRigidBody_clearForces" 'function)) :void
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btRigidBody_clearForces" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btRigidBody_updateInertiaTensor" 'function)))

(cffi:defcfun ("_wrap_btRigidBody_updateInertiaTensor" #.(bullet-wrap::swig-lispify "btRigidBody_updateInertiaTensor" 'function)) :void
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btRigidBody_updateInertiaTensor" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btRigidBody_getCenterOfMassPosition" 'function)))

(cffi:defcfun ("_wrap_btRigidBody_getCenterOfMassPosition" #.(bullet-wrap::swig-lispify "btRigidBody_getCenterOfMassPosition" 'function)) :pointer
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btRigidBody_getCenterOfMassPosition" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btRigidBody_getOrientation" 'function)))

(cffi:defcfun ("_wrap_btRigidBody_getOrientation" #.(bullet-wrap::swig-lispify "btRigidBody_getOrientation" 'function)) :pointer
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btRigidBody_getOrientation" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btRigidBody_getCenterOfMassTransform" 'function)))

(cffi:defcfun ("_wrap_btRigidBody_getCenterOfMassTransform" #.(bullet-wrap::swig-lispify "btRigidBody_getCenterOfMassTransform" 'function)) :pointer
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btRigidBody_getCenterOfMassTransform" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btRigidBody_getLinearVelocity" 'function)))

(cffi:defcfun ("_wrap_btRigidBody_getLinearVelocity" #.(bullet-wrap::swig-lispify "btRigidBody_getLinearVelocity" 'function)) :pointer
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btRigidBody_getLinearVelocity" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btRigidBody_getAngularVelocity" 'function)))

(cffi:defcfun ("_wrap_btRigidBody_getAngularVelocity" #.(bullet-wrap::swig-lispify "btRigidBody_getAngularVelocity" 'function)) :pointer
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btRigidBody_getAngularVelocity" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btRigidBody_setLinearVelocity" 'function)))

(cffi:defcfun ("_wrap_btRigidBody_setLinearVelocity" #.(bullet-wrap::swig-lispify "btRigidBody_setLinearVelocity" 'function)) :void
  (self :pointer)
  (lin_vel :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btRigidBody_setLinearVelocity" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btRigidBody_setAngularVelocity" 'function)))

(cffi:defcfun ("_wrap_btRigidBody_setAngularVelocity" #.(bullet-wrap::swig-lispify "btRigidBody_setAngularVelocity" 'function)) :void
  (self :pointer)
  (ang_vel :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btRigidBody_setAngularVelocity" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btRigidBody_getVelocityInLocalPoint" 'function)))

(cffi:defcfun ("_wrap_btRigidBody_getVelocityInLocalPoint" #.(bullet-wrap::swig-lispify "btRigidBody_getVelocityInLocalPoint" 'function)) :pointer
  (self :pointer)
  (rel_pos :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btRigidBody_getVelocityInLocalPoint" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btRigidBody_translate" 'function)))

(cffi:defcfun ("_wrap_btRigidBody_translate" #.(bullet-wrap::swig-lispify "btRigidBody_translate" 'function)) :void
  (self :pointer)
  (v :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btRigidBody_translate" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btRigidBody_getAabb" 'function)))

(cffi:defcfun ("_wrap_btRigidBody_getAabb" #.(bullet-wrap::swig-lispify "btRigidBody_getAabb" 'function)) :void
  (self :pointer)
  (aabbMin :pointer)
  (aabbMax :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btRigidBody_getAabb" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btRigidBody_computeImpulseDenominator" 'function)))

(cffi:defcfun ("_wrap_btRigidBody_computeImpulseDenominator" #.(bullet-wrap::swig-lispify "btRigidBody_computeImpulseDenominator" 'function)) :float
  (self :pointer)
  (pos :pointer)
  (normal :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btRigidBody_computeImpulseDenominator" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btRigidBody_computeAngularImpulseDenominator" 'function)))

(cffi:defcfun ("_wrap_btRigidBody_computeAngularImpulseDenominator" #.(bullet-wrap::swig-lispify "btRigidBody_computeAngularImpulseDenominator" 'function)) :float
  (self :pointer)
  (axis :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btRigidBody_computeAngularImpulseDenominator" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btRigidBody_updateDeactivation" 'function)))

(cffi:defcfun ("_wrap_btRigidBody_updateDeactivation" #.(bullet-wrap::swig-lispify "btRigidBody_updateDeactivation" 'function)) :void
  (self :pointer)
  (timeStep :float))

(cl:export '#.(bullet-wrap::swig-lispify "btRigidBody_updateDeactivation" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btRigidBody_wantsSleeping" 'function)))

(cffi:defcfun ("_wrap_btRigidBody_wantsSleeping" #.(bullet-wrap::swig-lispify "btRigidBody_wantsSleeping" 'function)) :pointer
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btRigidBody_wantsSleeping" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btRigidBody_getBroadphaseProxy" 'function)))

(cffi:defcfun ("_wrap_btRigidBody_getBroadphaseProxy__SWIG_0" #.(bullet-wrap::swig-lispify "btRigidBody_getBroadphaseProxy" 'function)) :pointer
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btRigidBody_getBroadphaseProxy" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btRigidBody_getBroadphaseProxy" 'function)))

(cffi:defcfun ("_wrap_btRigidBody_getBroadphaseProxy__SWIG_1" #.(bullet-wrap::swig-lispify "btRigidBody_getBroadphaseProxy" 'function)) :pointer
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btRigidBody_getBroadphaseProxy" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btRigidBody_setNewBroadphaseProxy" 'function)))

(cffi:defcfun ("_wrap_btRigidBody_setNewBroadphaseProxy" #.(bullet-wrap::swig-lispify "btRigidBody_setNewBroadphaseProxy" 'function)) :void
  (self :pointer)
  (broadphaseProxy :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btRigidBody_setNewBroadphaseProxy" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btRigidBody_getMotionState" 'function)))

(cffi:defcfun ("_wrap_btRigidBody_getMotionState__SWIG_0" #.(bullet-wrap::swig-lispify "btRigidBody_getMotionState" 'function)) :pointer
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btRigidBody_getMotionState" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btRigidBody_getMotionState" 'function)))

(cffi:defcfun ("_wrap_btRigidBody_getMotionState__SWIG_1" #.(bullet-wrap::swig-lispify "btRigidBody_getMotionState" 'function)) :pointer
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btRigidBody_getMotionState" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btRigidBody_setMotionState" 'function)))

(cffi:defcfun ("_wrap_btRigidBody_setMotionState" #.(bullet-wrap::swig-lispify "btRigidBody_setMotionState" 'function)) :void
  (self :pointer)
  (motionState :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btRigidBody_setMotionState" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btRigidBody_m_contactSolverType_set" 'function)))

(cffi:defcfun ("_wrap_btRigidBody_m_contactSolverType_set" #.(bullet-wrap::swig-lispify "btRigidBody_m_contactSolverType_set" 'function)) :void
  (self :pointer)
  (m_contactSolverType :int))

(cl:export '#.(bullet-wrap::swig-lispify "btRigidBody_m_contactSolverType_set" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btRigidBody_m_contactSolverType_get" 'function)))

(cffi:defcfun ("_wrap_btRigidBody_m_contactSolverType_get" #.(bullet-wrap::swig-lispify "btRigidBody_m_contactSolverType_get" 'function)) :int
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btRigidBody_m_contactSolverType_get" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btRigidBody_m_frictionSolverType_set" 'function)))

(cffi:defcfun ("_wrap_btRigidBody_m_frictionSolverType_set" #.(bullet-wrap::swig-lispify "btRigidBody_m_frictionSolverType_set" 'function)) :void
  (self :pointer)
  (m_frictionSolverType :int))

(cl:export '#.(bullet-wrap::swig-lispify "btRigidBody_m_frictionSolverType_set" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btRigidBody_m_frictionSolverType_get" 'function)))

(cffi:defcfun ("_wrap_btRigidBody_m_frictionSolverType_get" #.(bullet-wrap::swig-lispify "btRigidBody_m_frictionSolverType_get" 'function)) :int
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btRigidBody_m_frictionSolverType_get" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btRigidBody_setAngularFactor" 'function)))

(cffi:defcfun ("_wrap_btRigidBody_setAngularFactor__SWIG_0" #.(bullet-wrap::swig-lispify "btRigidBody_setAngularFactor" 'function)) :void
  (self :pointer)
  (angFac :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btRigidBody_setAngularFactor" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btRigidBody_setAngularFactor" 'function)))

(cffi:defcfun ("_wrap_btRigidBody_setAngularFactor__SWIG_1" #.(bullet-wrap::swig-lispify "btRigidBody_setAngularFactor" 'function)) :void
  (self :pointer)
  (angFac :float))

(cl:export '#.(bullet-wrap::swig-lispify "btRigidBody_setAngularFactor" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btRigidBody_getAngularFactor" 'function)))

(cffi:defcfun ("_wrap_btRigidBody_getAngularFactor" #.(bullet-wrap::swig-lispify "btRigidBody_getAngularFactor" 'function)) :pointer
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btRigidBody_getAngularFactor" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btRigidBody_isInWorld" 'function)))

(cffi:defcfun ("_wrap_btRigidBody_isInWorld" #.(bullet-wrap::swig-lispify "btRigidBody_isInWorld" 'function)) :pointer
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btRigidBody_isInWorld" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btRigidBody_checkCollideWithOverride" 'function)))

(cffi:defcfun ("_wrap_btRigidBody_checkCollideWithOverride" #.(bullet-wrap::swig-lispify "btRigidBody_checkCollideWithOverride" 'function)) :pointer
  (self :pointer)
  (co :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btRigidBody_checkCollideWithOverride" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btRigidBody_addConstraintRef" 'function)))

(cffi:defcfun ("_wrap_btRigidBody_addConstraintRef" #.(bullet-wrap::swig-lispify "btRigidBody_addConstraintRef" 'function)) :void
  (self :pointer)
  (c :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btRigidBody_addConstraintRef" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btRigidBody_removeConstraintRef" 'function)))

(cffi:defcfun ("_wrap_btRigidBody_removeConstraintRef" #.(bullet-wrap::swig-lispify "btRigidBody_removeConstraintRef" 'function)) :void
  (self :pointer)
  (c :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btRigidBody_removeConstraintRef" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btRigidBody_getConstraintRef" 'function)))

(cffi:defcfun ("_wrap_btRigidBody_getConstraintRef" #.(bullet-wrap::swig-lispify "btRigidBody_getConstraintRef" 'function)) :pointer
  (self :pointer)
  (index :int))

(cl:export '#.(bullet-wrap::swig-lispify "btRigidBody_getConstraintRef" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btRigidBody_getNumConstraintRefs" 'function)))

(cffi:defcfun ("_wrap_btRigidBody_getNumConstraintRefs" #.(bullet-wrap::swig-lispify "btRigidBody_getNumConstraintRefs" 'function)) :int
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btRigidBody_getNumConstraintRefs" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btRigidBody_setFlags" 'function)))

(cffi:defcfun ("_wrap_btRigidBody_setFlags" #.(bullet-wrap::swig-lispify "btRigidBody_setFlags" 'function)) :void
  (self :pointer)
  (flags :int))

(cl:export '#.(bullet-wrap::swig-lispify "btRigidBody_setFlags" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btRigidBody_getFlags" 'function)))

(cffi:defcfun ("_wrap_btRigidBody_getFlags" #.(bullet-wrap::swig-lispify "btRigidBody_getFlags" 'function)) :int
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btRigidBody_getFlags" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btRigidBody_computeGyroscopicForce" 'function)))

(cffi:defcfun ("_wrap_btRigidBody_computeGyroscopicForce" #.(bullet-wrap::swig-lispify "btRigidBody_computeGyroscopicForce" 'function)) :pointer
  (self :pointer)
  (maxGyroscopicForce :float))

(cl:export '#.(bullet-wrap::swig-lispify "btRigidBody_computeGyroscopicForce" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btRigidBody_calculateSerializeBufferSize" 'function)))

(cffi:defcfun ("_wrap_btRigidBody_calculateSerializeBufferSize" #.(bullet-wrap::swig-lispify "btRigidBody_calculateSerializeBufferSize" 'function)) :int
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btRigidBody_calculateSerializeBufferSize" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btRigidBody_serialize" 'function)))

(cffi:defcfun ("_wrap_btRigidBody_serialize" #.(bullet-wrap::swig-lispify "btRigidBody_serialize" 'function)) :string
  (self :pointer)
  (dataBuffer :pointer)
  (serializer :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btRigidBody_serialize" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btRigidBody_serializeSingleObject" 'function)))

(cffi:defcfun ("_wrap_btRigidBody_serializeSingleObject" #.(bullet-wrap::swig-lispify "btRigidBody_serializeSingleObject" 'function)) :void
  (self :pointer)
  (serializer :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btRigidBody_serializeSingleObject" 'function))

(cffi:defcstruct #.(bullet-wrap::swig-lispify "btRigidBodyFloatData" 'classname)
	(#.(bullet-wrap::swig-lispify "m_collisionObjectData" 'slotname) #.(bullet-wrap::swig-lispify "btCollisionObjectFloatData" 'classname))
	(#.(bullet-wrap::swig-lispify "m_invInertiaTensorWorld" 'slotname) #.(bullet-wrap::swig-lispify "btMatrix3x3FloatData" 'classname))
	(#.(bullet-wrap::swig-lispify "m_linearVelocity" 'slotname) #.(bullet-wrap::swig-lispify "btVector3FloatData" 'classname))
	(#.(bullet-wrap::swig-lispify "m_angularVelocity" 'slotname) #.(bullet-wrap::swig-lispify "btVector3FloatData" 'classname))
	(#.(bullet-wrap::swig-lispify "m_angularFactor" 'slotname) #.(bullet-wrap::swig-lispify "btVector3FloatData" 'classname))
	(#.(bullet-wrap::swig-lispify "m_linearFactor" 'slotname) #.(bullet-wrap::swig-lispify "btVector3FloatData" 'classname))
	(#.(bullet-wrap::swig-lispify "m_gravity" 'slotname) #.(bullet-wrap::swig-lispify "btVector3FloatData" 'classname))
	(#.(bullet-wrap::swig-lispify "m_gravity_acceleration" 'slotname) #.(bullet-wrap::swig-lispify "btVector3FloatData" 'classname))
	(#.(bullet-wrap::swig-lispify "m_invInertiaLocal" 'slotname) #.(bullet-wrap::swig-lispify "btVector3FloatData" 'classname))
	(#.(bullet-wrap::swig-lispify "m_totalForce" 'slotname) #.(bullet-wrap::swig-lispify "btVector3FloatData" 'classname))
	(#.(bullet-wrap::swig-lispify "m_totalTorque" 'slotname) #.(bullet-wrap::swig-lispify "btVector3FloatData" 'classname))
	(#.(bullet-wrap::swig-lispify "m_inverseMass" 'slotname) :float)
	(#.(bullet-wrap::swig-lispify "m_linearDamping" 'slotname) :float)
	(#.(bullet-wrap::swig-lispify "m_angularDamping" 'slotname) :float)
	(#.(bullet-wrap::swig-lispify "m_additionalDampingFactor" 'slotname) :float)
	(#.(bullet-wrap::swig-lispify "m_additionalLinearDampingThresholdSqr" 'slotname) :float)
	(#.(bullet-wrap::swig-lispify "m_additionalAngularDampingThresholdSqr" 'slotname) :float)
	(#.(bullet-wrap::swig-lispify "m_additionalAngularDampingFactor" 'slotname) :float)
	(#.(bullet-wrap::swig-lispify "m_linearSleepingThreshold" 'slotname) :float)
	(#.(bullet-wrap::swig-lispify "m_angularSleepingThreshold" 'slotname) :float)
	(#.(bullet-wrap::swig-lispify "m_additionalDamping" 'slotname) :int))

(cl:export '#.(bullet-wrap::swig-lispify "btRigidBodyFloatData" 'classname))

(cl:export '#.(bullet-wrap::swig-lispify "m_collisionObjectData" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_invInertiaTensorWorld" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_linearVelocity" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_angularVelocity" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_angularFactor" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_linearFactor" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_gravity" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_gravity_acceleration" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_invInertiaLocal" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_totalForce" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_totalTorque" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_inverseMass" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_linearDamping" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_angularDamping" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_additionalDampingFactor" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_additionalLinearDampingThresholdSqr" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_additionalAngularDampingThresholdSqr" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_additionalAngularDampingFactor" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_linearSleepingThreshold" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_angularSleepingThreshold" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_additionalDamping" 'slotname))

(cffi:defcstruct #.(bullet-wrap::swig-lispify "btRigidBodyDoubleData" 'classname)
	(#.(bullet-wrap::swig-lispify "m_collisionObjectData" 'slotname) #.(bullet-wrap::swig-lispify "btCollisionObjectDoubleData" 'classname))
	(#.(bullet-wrap::swig-lispify "m_invInertiaTensorWorld" 'slotname) #.(bullet-wrap::swig-lispify "btMatrix3x3DoubleData" 'classname))
	(#.(bullet-wrap::swig-lispify "m_linearVelocity" 'slotname) #.(bullet-wrap::swig-lispify "btVector3DoubleData" 'classname))
	(#.(bullet-wrap::swig-lispify "m_angularVelocity" 'slotname) #.(bullet-wrap::swig-lispify "btVector3DoubleData" 'classname))
	(#.(bullet-wrap::swig-lispify "m_angularFactor" 'slotname) #.(bullet-wrap::swig-lispify "btVector3DoubleData" 'classname))
	(#.(bullet-wrap::swig-lispify "m_linearFactor" 'slotname) #.(bullet-wrap::swig-lispify "btVector3DoubleData" 'classname))
	(#.(bullet-wrap::swig-lispify "m_gravity" 'slotname) #.(bullet-wrap::swig-lispify "btVector3DoubleData" 'classname))
	(#.(bullet-wrap::swig-lispify "m_gravity_acceleration" 'slotname) #.(bullet-wrap::swig-lispify "btVector3DoubleData" 'classname))
	(#.(bullet-wrap::swig-lispify "m_invInertiaLocal" 'slotname) #.(bullet-wrap::swig-lispify "btVector3DoubleData" 'classname))
	(#.(bullet-wrap::swig-lispify "m_totalForce" 'slotname) #.(bullet-wrap::swig-lispify "btVector3DoubleData" 'classname))
	(#.(bullet-wrap::swig-lispify "m_totalTorque" 'slotname) #.(bullet-wrap::swig-lispify "btVector3DoubleData" 'classname))
	(#.(bullet-wrap::swig-lispify "m_inverseMass" 'slotname) :double)
	(#.(bullet-wrap::swig-lispify "m_linearDamping" 'slotname) :double)
	(#.(bullet-wrap::swig-lispify "m_angularDamping" 'slotname) :double)
	(#.(bullet-wrap::swig-lispify "m_additionalDampingFactor" 'slotname) :double)
	(#.(bullet-wrap::swig-lispify "m_additionalLinearDampingThresholdSqr" 'slotname) :double)
	(#.(bullet-wrap::swig-lispify "m_additionalAngularDampingThresholdSqr" 'slotname) :double)
	(#.(bullet-wrap::swig-lispify "m_additionalAngularDampingFactor" 'slotname) :double)
	(#.(bullet-wrap::swig-lispify "m_linearSleepingThreshold" 'slotname) :double)
	(#.(bullet-wrap::swig-lispify "m_angularSleepingThreshold" 'slotname) :double)
	(#.(bullet-wrap::swig-lispify "m_additionalDamping" 'slotname) :int)
	(#.(bullet-wrap::swig-lispify "m_padding" 'slotname) :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btRigidBodyDoubleData" 'classname))

(cl:export '#.(bullet-wrap::swig-lispify "m_collisionObjectData" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_invInertiaTensorWorld" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_linearVelocity" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_angularVelocity" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_angularFactor" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_linearFactor" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_gravity" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_gravity_acceleration" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_invInertiaLocal" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_totalForce" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_totalTorque" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_inverseMass" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_linearDamping" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_angularDamping" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_additionalDampingFactor" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_additionalLinearDampingThresholdSqr" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_additionalAngularDampingThresholdSqr" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_additionalAngularDampingFactor" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_linearSleepingThreshold" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_angularSleepingThreshold" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_additionalDamping" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_padding" 'slotname))

(cl:defconstant #.(bullet-wrap::swig-lispify "btTypedConstraintDataName" 'constant) "btTypedConstraintFloatData")

(cl:export '#.(bullet-wrap::swig-lispify "btTypedConstraintDataName" 'constant))

(cffi:defcenum #.(bullet-wrap::swig-lispify "btTypedConstraintType" 'enumname)
	(#.(bullet-wrap::swig-lispify "POINT2POINT_CONSTRAINT_TYPE" 'enumvalue :keyword) #.3)
	#.(bullet-wrap::swig-lispify "HINGE_CONSTRAINT_TYPE" 'enumvalue :keyword)
	#.(bullet-wrap::swig-lispify "CONETWIST_CONSTRAINT_TYPE" 'enumvalue :keyword)
	#.(bullet-wrap::swig-lispify "D6_CONSTRAINT_TYPE" 'enumvalue :keyword)
	#.(bullet-wrap::swig-lispify "SLIDER_CONSTRAINT_TYPE" 'enumvalue :keyword)
	#.(bullet-wrap::swig-lispify "CONTACT_CONSTRAINT_TYPE" 'enumvalue :keyword)
	#.(bullet-wrap::swig-lispify "D6_SPRING_CONSTRAINT_TYPE" 'enumvalue :keyword)
	#.(bullet-wrap::swig-lispify "GEAR_CONSTRAINT_TYPE" 'enumvalue :keyword)
	#.(bullet-wrap::swig-lispify "FIXED_CONSTRAINT_TYPE" 'enumvalue :keyword)
	#.(bullet-wrap::swig-lispify "MAX_CONSTRAINT_TYPE" 'enumvalue :keyword))

(cl:export '#.(bullet-wrap::swig-lispify "btTypedConstraintType" 'enumname))

(cffi:defcenum #.(bullet-wrap::swig-lispify "btConstraintParams" 'enumname)
	(#.(bullet-wrap::swig-lispify "BT_CONSTRAINT_ERP" 'enumvalue :keyword) #.1)
	#.(bullet-wrap::swig-lispify "BT_CONSTRAINT_STOP_ERP" 'enumvalue :keyword)
	#.(bullet-wrap::swig-lispify "BT_CONSTRAINT_CFM" 'enumvalue :keyword)
	#.(bullet-wrap::swig-lispify "BT_CONSTRAINT_STOP_CFM" 'enumvalue :keyword))

(cl:export '#.(bullet-wrap::swig-lispify "btConstraintParams" 'enumname))

(cffi:defcstruct #.(bullet-wrap::swig-lispify "btJointFeedback" 'classname)
	(#.(bullet-wrap::swig-lispify "m_appliedForceBodyA" 'slotname) :pointer)
	(#.(bullet-wrap::swig-lispify "m_appliedTorqueBodyA" 'slotname) :pointer)
	(#.(bullet-wrap::swig-lispify "m_appliedForceBodyB" 'slotname) :pointer)
	(#.(bullet-wrap::swig-lispify "m_appliedTorqueBodyB" 'slotname) :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btJointFeedback" 'classname))

(cl:export '#.(bullet-wrap::swig-lispify "m_appliedForceBodyA" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_appliedTorqueBodyA" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_appliedForceBodyB" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_appliedTorqueBodyB" 'slotname))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btTypedConstraint_makeCPlusPlusInstance" 'function)))

(cffi:defcfun ("_wrap_btTypedConstraint_makeCPlusPlusInstance__SWIG_0" #.(bullet-wrap::swig-lispify "btTypedConstraint_makeCPlusPlusInstance" 'function)) :pointer
  (self :pointer)
  (sizeInBytes :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btTypedConstraint_makeCPlusPlusInstance" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btTypedConstraint_deleteCPlusPlusInstance" 'function)))

(cffi:defcfun ("_wrap_btTypedConstraint_deleteCPlusPlusInstance__SWIG_0" #.(bullet-wrap::swig-lispify "btTypedConstraint_deleteCPlusPlusInstance" 'function)) :void
  (self :pointer)
  (ptr :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btTypedConstraint_deleteCPlusPlusInstance" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btTypedConstraint_makeCPlusPlusInstance" 'function)))

(cffi:defcfun ("_wrap_btTypedConstraint_makeCPlusPlusInstance__SWIG_1" #.(bullet-wrap::swig-lispify "btTypedConstraint_makeCPlusPlusInstance" 'function)) :pointer
  (self :pointer)
  (arg1 :pointer)
  (ptr :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btTypedConstraint_makeCPlusPlusInstance" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btTypedConstraint_deleteCPlusPlusInstance" 'function)))

(cffi:defcfun ("_wrap_btTypedConstraint_deleteCPlusPlusInstance__SWIG_1" #.(bullet-wrap::swig-lispify "btTypedConstraint_deleteCPlusPlusInstance" 'function)) :void
  (self :pointer)
  (arg1 :pointer)
  (arg2 :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btTypedConstraint_deleteCPlusPlusInstance" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btTypedConstraint_makeCPlusArray" 'function)))

(cffi:defcfun ("_wrap_btTypedConstraint_makeCPlusArray__SWIG_0" #.(bullet-wrap::swig-lispify "btTypedConstraint_makeCPlusArray" 'function)) :pointer
  (self :pointer)
  (sizeInBytes :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btTypedConstraint_makeCPlusArray" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btTypedConstraint_deleteCPlusArray" 'function)))

(cffi:defcfun ("_wrap_btTypedConstraint_deleteCPlusArray__SWIG_0" #.(bullet-wrap::swig-lispify "btTypedConstraint_deleteCPlusArray" 'function)) :void
  (self :pointer)
  (ptr :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btTypedConstraint_deleteCPlusArray" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btTypedConstraint_makeCPlusArray" 'function)))

(cffi:defcfun ("_wrap_btTypedConstraint_makeCPlusArray__SWIG_1" #.(bullet-wrap::swig-lispify "btTypedConstraint_makeCPlusArray" 'function)) :pointer
  (self :pointer)
  (arg1 :pointer)
  (ptr :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btTypedConstraint_makeCPlusArray" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btTypedConstraint_deleteCPlusArray" 'function)))

(cffi:defcfun ("_wrap_btTypedConstraint_deleteCPlusArray__SWIG_1" #.(bullet-wrap::swig-lispify "btTypedConstraint_deleteCPlusArray" 'function)) :void
  (self :pointer)
  (arg1 :pointer)
  (arg2 :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btTypedConstraint_deleteCPlusArray" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "delete_btTypedConstraint" 'function)))

(cffi:defcfun ("_wrap_delete_btTypedConstraint" #.(bullet-wrap::swig-lispify "delete_btTypedConstraint" 'function)) :void
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "delete_btTypedConstraint" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btTypedConstraint_getFixedBody" 'function)))

(cffi:defcfun ("_wrap_btTypedConstraint_getFixedBody" #.(bullet-wrap::swig-lispify "btTypedConstraint_getFixedBody" 'function)) :pointer)

(cl:export '#.(bullet-wrap::swig-lispify "btTypedConstraint_getFixedBody" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btTypedConstraint_getOverrideNumSolverIterations" 'function)))

(cffi:defcfun ("_wrap_btTypedConstraint_getOverrideNumSolverIterations" #.(bullet-wrap::swig-lispify "btTypedConstraint_getOverrideNumSolverIterations" 'function)) :int
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btTypedConstraint_getOverrideNumSolverIterations" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btTypedConstraint_setOverrideNumSolverIterations" 'function)))

(cffi:defcfun ("_wrap_btTypedConstraint_setOverrideNumSolverIterations" #.(bullet-wrap::swig-lispify "btTypedConstraint_setOverrideNumSolverIterations" 'function)) :void
  (self :pointer)
  (overideNumIterations :int))

(cl:export '#.(bullet-wrap::swig-lispify "btTypedConstraint_setOverrideNumSolverIterations" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btTypedConstraint_buildJacobian" 'function)))

(cffi:defcfun ("_wrap_btTypedConstraint_buildJacobian" #.(bullet-wrap::swig-lispify "btTypedConstraint_buildJacobian" 'function)) :void
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btTypedConstraint_buildJacobian" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btTypedConstraint_setupSolverConstraint" 'function)))

(cffi:defcfun ("_wrap_btTypedConstraint_setupSolverConstraint" #.(bullet-wrap::swig-lispify "btTypedConstraint_setupSolverConstraint" 'function)) :void
  (self :pointer)
  (ca :pointer)
  (solverBodyA :int)
  (solverBodyB :int)
  (timeStep :float))

(cl:export '#.(bullet-wrap::swig-lispify "btTypedConstraint_setupSolverConstraint" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btTypedConstraint_getInfo1" 'function)))

(cffi:defcfun ("_wrap_btTypedConstraint_getInfo1" #.(bullet-wrap::swig-lispify "btTypedConstraint_getInfo1" 'function)) :void
  (self :pointer)
  (info :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btTypedConstraint_getInfo1" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btTypedConstraint_getInfo2" 'function)))

(cffi:defcfun ("_wrap_btTypedConstraint_getInfo2" #.(bullet-wrap::swig-lispify "btTypedConstraint_getInfo2" 'function)) :void
  (self :pointer)
  (info :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btTypedConstraint_getInfo2" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btTypedConstraint_internalSetAppliedImpulse" 'function)))

(cffi:defcfun ("_wrap_btTypedConstraint_internalSetAppliedImpulse" #.(bullet-wrap::swig-lispify "btTypedConstraint_internalSetAppliedImpulse" 'function)) :void
  (self :pointer)
  (appliedImpulse :float))

(cl:export '#.(bullet-wrap::swig-lispify "btTypedConstraint_internalSetAppliedImpulse" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btTypedConstraint_internalGetAppliedImpulse" 'function)))

(cffi:defcfun ("_wrap_btTypedConstraint_internalGetAppliedImpulse" #.(bullet-wrap::swig-lispify "btTypedConstraint_internalGetAppliedImpulse" 'function)) :float
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btTypedConstraint_internalGetAppliedImpulse" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btTypedConstraint_getBreakingImpulseThreshold" 'function)))

(cffi:defcfun ("_wrap_btTypedConstraint_getBreakingImpulseThreshold" #.(bullet-wrap::swig-lispify "btTypedConstraint_getBreakingImpulseThreshold" 'function)) :float
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btTypedConstraint_getBreakingImpulseThreshold" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btTypedConstraint_setBreakingImpulseThreshold" 'function)))

(cffi:defcfun ("_wrap_btTypedConstraint_setBreakingImpulseThreshold" #.(bullet-wrap::swig-lispify "btTypedConstraint_setBreakingImpulseThreshold" 'function)) :void
  (self :pointer)
  (threshold :float))

(cl:export '#.(bullet-wrap::swig-lispify "btTypedConstraint_setBreakingImpulseThreshold" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btTypedConstraint_isEnabled" 'function)))

(cffi:defcfun ("_wrap_btTypedConstraint_isEnabled" #.(bullet-wrap::swig-lispify "btTypedConstraint_isEnabled" 'function)) :pointer
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btTypedConstraint_isEnabled" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btTypedConstraint_setEnabled" 'function)))

(cffi:defcfun ("_wrap_btTypedConstraint_setEnabled" #.(bullet-wrap::swig-lispify "btTypedConstraint_setEnabled" 'function)) :void
  (self :pointer)
  (enabled :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btTypedConstraint_setEnabled" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btTypedConstraint_solveConstraintObsolete" 'function)))

(cffi:defcfun ("_wrap_btTypedConstraint_solveConstraintObsolete" #.(bullet-wrap::swig-lispify "btTypedConstraint_solveConstraintObsolete" 'function)) :void
  (self :pointer)
  (arg1 :pointer)
  (arg2 :pointer)
  (arg3 :float))

(cl:export '#.(bullet-wrap::swig-lispify "btTypedConstraint_solveConstraintObsolete" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btTypedConstraint_getRigidBodyA" 'function)))

(cffi:defcfun ("_wrap_btTypedConstraint_getRigidBodyA__SWIG_0" #.(bullet-wrap::swig-lispify "btTypedConstraint_getRigidBodyA" 'function)) :pointer
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btTypedConstraint_getRigidBodyA" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btTypedConstraint_getRigidBodyB" 'function)))

(cffi:defcfun ("_wrap_btTypedConstraint_getRigidBodyB__SWIG_0" #.(bullet-wrap::swig-lispify "btTypedConstraint_getRigidBodyB" 'function)) :pointer
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btTypedConstraint_getRigidBodyB" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btTypedConstraint_getRigidBodyA" 'function)))

(cffi:defcfun ("_wrap_btTypedConstraint_getRigidBodyA__SWIG_1" #.(bullet-wrap::swig-lispify "btTypedConstraint_getRigidBodyA" 'function)) :pointer
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btTypedConstraint_getRigidBodyA" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btTypedConstraint_getRigidBodyB" 'function)))

(cffi:defcfun ("_wrap_btTypedConstraint_getRigidBodyB__SWIG_1" #.(bullet-wrap::swig-lispify "btTypedConstraint_getRigidBodyB" 'function)) :pointer
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btTypedConstraint_getRigidBodyB" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btTypedConstraint_getUserConstraintType" 'function)))

(cffi:defcfun ("_wrap_btTypedConstraint_getUserConstraintType" #.(bullet-wrap::swig-lispify "btTypedConstraint_getUserConstraintType" 'function)) :int
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btTypedConstraint_getUserConstraintType" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btTypedConstraint_setUserConstraintType" 'function)))

(cffi:defcfun ("_wrap_btTypedConstraint_setUserConstraintType" #.(bullet-wrap::swig-lispify "btTypedConstraint_setUserConstraintType" 'function)) :void
  (self :pointer)
  (userConstraintType :int))

(cl:export '#.(bullet-wrap::swig-lispify "btTypedConstraint_setUserConstraintType" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btTypedConstraint_setUserConstraintId" 'function)))

(cffi:defcfun ("_wrap_btTypedConstraint_setUserConstraintId" #.(bullet-wrap::swig-lispify "btTypedConstraint_setUserConstraintId" 'function)) :void
  (self :pointer)
  (uid :int))

(cl:export '#.(bullet-wrap::swig-lispify "btTypedConstraint_setUserConstraintId" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btTypedConstraint_getUserConstraintId" 'function)))

(cffi:defcfun ("_wrap_btTypedConstraint_getUserConstraintId" #.(bullet-wrap::swig-lispify "btTypedConstraint_getUserConstraintId" 'function)) :int
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btTypedConstraint_getUserConstraintId" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btTypedConstraint_setUserConstraintPtr" 'function)))

(cffi:defcfun ("_wrap_btTypedConstraint_setUserConstraintPtr" #.(bullet-wrap::swig-lispify "btTypedConstraint_setUserConstraintPtr" 'function)) :void
  (self :pointer)
  (ptr :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btTypedConstraint_setUserConstraintPtr" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btTypedConstraint_getUserConstraintPtr" 'function)))

(cffi:defcfun ("_wrap_btTypedConstraint_getUserConstraintPtr" #.(bullet-wrap::swig-lispify "btTypedConstraint_getUserConstraintPtr" 'function)) :pointer
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btTypedConstraint_getUserConstraintPtr" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btTypedConstraint_setJointFeedback" 'function)))

(cffi:defcfun ("_wrap_btTypedConstraint_setJointFeedback" #.(bullet-wrap::swig-lispify "btTypedConstraint_setJointFeedback" 'function)) :void
  (self :pointer)
  (jointFeedback :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btTypedConstraint_setJointFeedback" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btTypedConstraint_getJointFeedback" 'function)))

(cffi:defcfun ("_wrap_btTypedConstraint_getJointFeedback__SWIG_0" #.(bullet-wrap::swig-lispify "btTypedConstraint_getJointFeedback" 'function)) :pointer
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btTypedConstraint_getJointFeedback" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btTypedConstraint_getJointFeedback" 'function)))

(cffi:defcfun ("_wrap_btTypedConstraint_getJointFeedback__SWIG_1" #.(bullet-wrap::swig-lispify "btTypedConstraint_getJointFeedback" 'function)) :pointer
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btTypedConstraint_getJointFeedback" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btTypedConstraint_getUid" 'function)))

(cffi:defcfun ("_wrap_btTypedConstraint_getUid" #.(bullet-wrap::swig-lispify "btTypedConstraint_getUid" 'function)) :int
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btTypedConstraint_getUid" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btTypedConstraint_needsFeedback" 'function)))

(cffi:defcfun ("_wrap_btTypedConstraint_needsFeedback" #.(bullet-wrap::swig-lispify "btTypedConstraint_needsFeedback" 'function)) :pointer
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btTypedConstraint_needsFeedback" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btTypedConstraint_enableFeedback" 'function)))

(cffi:defcfun ("_wrap_btTypedConstraint_enableFeedback" #.(bullet-wrap::swig-lispify "btTypedConstraint_enableFeedback" 'function)) :void
  (self :pointer)
  (needsFeedback :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btTypedConstraint_enableFeedback" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btTypedConstraint_getAppliedImpulse" 'function)))

(cffi:defcfun ("_wrap_btTypedConstraint_getAppliedImpulse" #.(bullet-wrap::swig-lispify "btTypedConstraint_getAppliedImpulse" 'function)) :float
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btTypedConstraint_getAppliedImpulse" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btTypedConstraint_getConstraintType" 'function)))

(cffi:defcfun ("_wrap_btTypedConstraint_getConstraintType" #.(bullet-wrap::swig-lispify "btTypedConstraint_getConstraintType" 'function)) #.(bullet-wrap::swig-lispify "btTypedConstraintType" 'enumname)
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btTypedConstraint_getConstraintType" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btTypedConstraint_setDbgDrawSize" 'function)))

(cffi:defcfun ("_wrap_btTypedConstraint_setDbgDrawSize" #.(bullet-wrap::swig-lispify "btTypedConstraint_setDbgDrawSize" 'function)) :void
  (self :pointer)
  (dbgDrawSize :float))

(cl:export '#.(bullet-wrap::swig-lispify "btTypedConstraint_setDbgDrawSize" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btTypedConstraint_getDbgDrawSize" 'function)))

(cffi:defcfun ("_wrap_btTypedConstraint_getDbgDrawSize" #.(bullet-wrap::swig-lispify "btTypedConstraint_getDbgDrawSize" 'function)) :float
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btTypedConstraint_getDbgDrawSize" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btTypedConstraint_setParam" 'function)))

(cffi:defcfun ("_wrap_btTypedConstraint_setParam__SWIG_0" #.(bullet-wrap::swig-lispify "btTypedConstraint_setParam" 'function)) :void
  (self :pointer)
  (num :int)
  (value :float)
  (axis :int))

(cl:export '#.(bullet-wrap::swig-lispify "btTypedConstraint_setParam" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btTypedConstraint_setParam" 'function)))

(cffi:defcfun ("_wrap_btTypedConstraint_setParam__SWIG_1" #.(bullet-wrap::swig-lispify "btTypedConstraint_setParam" 'function)) :void
  (self :pointer)
  (num :int)
  (value :float))

(cl:export '#.(bullet-wrap::swig-lispify "btTypedConstraint_setParam" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btTypedConstraint_getParam" 'function)))

(cffi:defcfun ("_wrap_btTypedConstraint_getParam__SWIG_0" #.(bullet-wrap::swig-lispify "btTypedConstraint_getParam" 'function)) :float
  (self :pointer)
  (num :int)
  (axis :int))

(cl:export '#.(bullet-wrap::swig-lispify "btTypedConstraint_getParam" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btTypedConstraint_getParam" 'function)))

(cffi:defcfun ("_wrap_btTypedConstraint_getParam__SWIG_1" #.(bullet-wrap::swig-lispify "btTypedConstraint_getParam" 'function)) :float
  (self :pointer)
  (num :int))

(cl:export '#.(bullet-wrap::swig-lispify "btTypedConstraint_getParam" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btTypedConstraint_calculateSerializeBufferSize" 'function)))

(cffi:defcfun ("_wrap_btTypedConstraint_calculateSerializeBufferSize" #.(bullet-wrap::swig-lispify "btTypedConstraint_calculateSerializeBufferSize" 'function)) :int
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btTypedConstraint_calculateSerializeBufferSize" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btTypedConstraint_serialize" 'function)))

(cffi:defcfun ("_wrap_btTypedConstraint_serialize" #.(bullet-wrap::swig-lispify "btTypedConstraint_serialize" 'function)) :string
  (self :pointer)
  (dataBuffer :pointer)
  (serializer :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btTypedConstraint_serialize" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btAdjustAngleToLimits" 'function)))

(cffi:defcfun ("_wrap_btAdjustAngleToLimits" #.(bullet-wrap::swig-lispify "btAdjustAngleToLimits" 'function)) :float
  (angleInRadians :float)
  (angleLowerLimitInRadians :float)
  (angleUpperLimitInRadians :float))

(cl:export '#.(bullet-wrap::swig-lispify "btAdjustAngleToLimits" 'function))

(cffi:defcstruct #.(bullet-wrap::swig-lispify "btTypedConstraintFloatData" 'classname)
	(#.(bullet-wrap::swig-lispify "m_rbA" 'slotname) :pointer)
	(#.(bullet-wrap::swig-lispify "m_rbB" 'slotname) :pointer)
	(#.(bullet-wrap::swig-lispify "m_name" 'slotname) :string)
	(#.(bullet-wrap::swig-lispify "m_objectType" 'slotname) :int)
	(#.(bullet-wrap::swig-lispify "m_userConstraintType" 'slotname) :int)
	(#.(bullet-wrap::swig-lispify "m_userConstraintId" 'slotname) :int)
	(#.(bullet-wrap::swig-lispify "m_needsFeedback" 'slotname) :int)
	(#.(bullet-wrap::swig-lispify "m_appliedImpulse" 'slotname) :float)
	(#.(bullet-wrap::swig-lispify "m_dbgDrawSize" 'slotname) :float)
	(#.(bullet-wrap::swig-lispify "m_disableCollisionsBetweenLinkedBodies" 'slotname) :int)
	(#.(bullet-wrap::swig-lispify "m_overrideNumSolverIterations" 'slotname) :int)
	(#.(bullet-wrap::swig-lispify "m_breakingImpulseThreshold" 'slotname) :float)
	(#.(bullet-wrap::swig-lispify "m_isEnabled" 'slotname) :int))

(cl:export '#.(bullet-wrap::swig-lispify "btTypedConstraintFloatData" 'classname))

(cl:export '#.(bullet-wrap::swig-lispify "m_rbA" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_rbB" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_name" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_objectType" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_userConstraintType" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_userConstraintId" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_needsFeedback" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_appliedImpulse" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_dbgDrawSize" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_disableCollisionsBetweenLinkedBodies" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_overrideNumSolverIterations" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_breakingImpulseThreshold" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_isEnabled" 'slotname))

(cffi:defcstruct #.(bullet-wrap::swig-lispify "btTypedConstraintData" 'classname)
	(#.(bullet-wrap::swig-lispify "m_rbA" 'slotname) :pointer)
	(#.(bullet-wrap::swig-lispify "m_rbB" 'slotname) :pointer)
	(#.(bullet-wrap::swig-lispify "m_name" 'slotname) :string)
	(#.(bullet-wrap::swig-lispify "m_objectType" 'slotname) :int)
	(#.(bullet-wrap::swig-lispify "m_userConstraintType" 'slotname) :int)
	(#.(bullet-wrap::swig-lispify "m_userConstraintId" 'slotname) :int)
	(#.(bullet-wrap::swig-lispify "m_needsFeedback" 'slotname) :int)
	(#.(bullet-wrap::swig-lispify "m_appliedImpulse" 'slotname) :float)
	(#.(bullet-wrap::swig-lispify "m_dbgDrawSize" 'slotname) :float)
	(#.(bullet-wrap::swig-lispify "m_disableCollisionsBetweenLinkedBodies" 'slotname) :int)
	(#.(bullet-wrap::swig-lispify "m_overrideNumSolverIterations" 'slotname) :int)
	(#.(bullet-wrap::swig-lispify "m_breakingImpulseThreshold" 'slotname) :float)
	(#.(bullet-wrap::swig-lispify "m_isEnabled" 'slotname) :int))

(cl:export '#.(bullet-wrap::swig-lispify "btTypedConstraintData" 'classname))

(cl:export '#.(bullet-wrap::swig-lispify "m_rbA" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_rbB" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_name" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_objectType" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_userConstraintType" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_userConstraintId" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_needsFeedback" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_appliedImpulse" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_dbgDrawSize" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_disableCollisionsBetweenLinkedBodies" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_overrideNumSolverIterations" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_breakingImpulseThreshold" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_isEnabled" 'slotname))

(cffi:defcstruct #.(bullet-wrap::swig-lispify "btTypedConstraintDoubleData" 'classname)
	(#.(bullet-wrap::swig-lispify "m_rbA" 'slotname) :pointer)
	(#.(bullet-wrap::swig-lispify "m_rbB" 'slotname) :pointer)
	(#.(bullet-wrap::swig-lispify "m_name" 'slotname) :string)
	(#.(bullet-wrap::swig-lispify "m_objectType" 'slotname) :int)
	(#.(bullet-wrap::swig-lispify "m_userConstraintType" 'slotname) :int)
	(#.(bullet-wrap::swig-lispify "m_userConstraintId" 'slotname) :int)
	(#.(bullet-wrap::swig-lispify "m_needsFeedback" 'slotname) :int)
	(#.(bullet-wrap::swig-lispify "m_appliedImpulse" 'slotname) :double)
	(#.(bullet-wrap::swig-lispify "m_dbgDrawSize" 'slotname) :double)
	(#.(bullet-wrap::swig-lispify "m_disableCollisionsBetweenLinkedBodies" 'slotname) :int)
	(#.(bullet-wrap::swig-lispify "m_overrideNumSolverIterations" 'slotname) :int)
	(#.(bullet-wrap::swig-lispify "m_breakingImpulseThreshold" 'slotname) :double)
	(#.(bullet-wrap::swig-lispify "m_isEnabled" 'slotname) :int)
	(#.(bullet-wrap::swig-lispify "padding" 'slotname) :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btTypedConstraintDoubleData" 'classname))

(cl:export '#.(bullet-wrap::swig-lispify "m_rbA" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_rbB" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_name" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_objectType" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_userConstraintType" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_userConstraintId" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_needsFeedback" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_appliedImpulse" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_dbgDrawSize" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_disableCollisionsBetweenLinkedBodies" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_overrideNumSolverIterations" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_breakingImpulseThreshold" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_isEnabled" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "padding" 'slotname))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "new_btAngularLimit" 'function)))

(cffi:defcfun ("_wrap_new_btAngularLimit" #.(bullet-wrap::swig-lispify "new_btAngularLimit" 'function)) :pointer)

(cl:export '#.(bullet-wrap::swig-lispify "new_btAngularLimit" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btAngularLimit_set" 'function)))

(cffi:defcfun ("_wrap_btAngularLimit_set__SWIG_0" #.(bullet-wrap::swig-lispify "btAngularLimit_set" 'function)) :void
  (self :pointer)
  (low :float)
  (high :float)
  (_softness :float)
  (_biasFactor :float)
  (_relaxationFactor :float))

(cl:export '#.(bullet-wrap::swig-lispify "btAngularLimit_set" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btAngularLimit_set" 'function)))

(cffi:defcfun ("_wrap_btAngularLimit_set__SWIG_1" #.(bullet-wrap::swig-lispify "btAngularLimit_set" 'function)) :void
  (self :pointer)
  (low :float)
  (high :float)
  (_softness :float)
  (_biasFactor :float))

(cl:export '#.(bullet-wrap::swig-lispify "btAngularLimit_set" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btAngularLimit_set" 'function)))

(cffi:defcfun ("_wrap_btAngularLimit_set__SWIG_2" #.(bullet-wrap::swig-lispify "btAngularLimit_set" 'function)) :void
  (self :pointer)
  (low :float)
  (high :float)
  (_softness :float))

(cl:export '#.(bullet-wrap::swig-lispify "btAngularLimit_set" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btAngularLimit_set" 'function)))

(cffi:defcfun ("_wrap_btAngularLimit_set__SWIG_3" #.(bullet-wrap::swig-lispify "btAngularLimit_set" 'function)) :void
  (self :pointer)
  (low :float)
  (high :float))

(cl:export '#.(bullet-wrap::swig-lispify "btAngularLimit_set" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btAngularLimit_test" 'function)))

(cffi:defcfun ("_wrap_btAngularLimit_test" #.(bullet-wrap::swig-lispify "btAngularLimit_test" 'function)) :void
  (self :pointer)
  (angle :float))

(cl:export '#.(bullet-wrap::swig-lispify "btAngularLimit_test" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btAngularLimit_getSoftness" 'function)))

(cffi:defcfun ("_wrap_btAngularLimit_getSoftness" #.(bullet-wrap::swig-lispify "btAngularLimit_getSoftness" 'function)) :float
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btAngularLimit_getSoftness" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btAngularLimit_getBiasFactor" 'function)))

(cffi:defcfun ("_wrap_btAngularLimit_getBiasFactor" #.(bullet-wrap::swig-lispify "btAngularLimit_getBiasFactor" 'function)) :float
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btAngularLimit_getBiasFactor" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btAngularLimit_getRelaxationFactor" 'function)))

(cffi:defcfun ("_wrap_btAngularLimit_getRelaxationFactor" #.(bullet-wrap::swig-lispify "btAngularLimit_getRelaxationFactor" 'function)) :float
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btAngularLimit_getRelaxationFactor" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btAngularLimit_getCorrection" 'function)))

(cffi:defcfun ("_wrap_btAngularLimit_getCorrection" #.(bullet-wrap::swig-lispify "btAngularLimit_getCorrection" 'function)) :float
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btAngularLimit_getCorrection" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btAngularLimit_getSign" 'function)))

(cffi:defcfun ("_wrap_btAngularLimit_getSign" #.(bullet-wrap::swig-lispify "btAngularLimit_getSign" 'function)) :float
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btAngularLimit_getSign" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btAngularLimit_getHalfRange" 'function)))

(cffi:defcfun ("_wrap_btAngularLimit_getHalfRange" #.(bullet-wrap::swig-lispify "btAngularLimit_getHalfRange" 'function)) :float
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btAngularLimit_getHalfRange" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btAngularLimit_isLimit" 'function)))

(cffi:defcfun ("_wrap_btAngularLimit_isLimit" #.(bullet-wrap::swig-lispify "btAngularLimit_isLimit" 'function)) :pointer
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btAngularLimit_isLimit" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btAngularLimit_fit" 'function)))

(cffi:defcfun ("_wrap_btAngularLimit_fit" #.(bullet-wrap::swig-lispify "btAngularLimit_fit" 'function)) :void
  (self :pointer)
  (angle :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btAngularLimit_fit" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btAngularLimit_getError" 'function)))

(cffi:defcfun ("_wrap_btAngularLimit_getError" #.(bullet-wrap::swig-lispify "btAngularLimit_getError" 'function)) :float
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btAngularLimit_getError" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btAngularLimit_getLow" 'function)))

(cffi:defcfun ("_wrap_btAngularLimit_getLow" #.(bullet-wrap::swig-lispify "btAngularLimit_getLow" 'function)) :float
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btAngularLimit_getLow" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btAngularLimit_getHigh" 'function)))

(cffi:defcfun ("_wrap_btAngularLimit_getHigh" #.(bullet-wrap::swig-lispify "btAngularLimit_getHigh" 'function)) :float
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btAngularLimit_getHigh" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "delete_btAngularLimit" 'function)))

(cffi:defcfun ("_wrap_delete_btAngularLimit" #.(bullet-wrap::swig-lispify "delete_btAngularLimit" 'function)) :void
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "delete_btAngularLimit" 'function))

(cl:defconstant #.(bullet-wrap::swig-lispify "btPoint2PointConstraintDataName" 'constant) "btPoint2PointConstraintFloatData")

(cl:export '#.(bullet-wrap::swig-lispify "btPoint2PointConstraintDataName" 'constant))

(cffi:defcstruct #.(bullet-wrap::swig-lispify "btConstraintSetting" 'classname)
	(#.(bullet-wrap::swig-lispify "m_tau" 'slotname) :float)
	(#.(bullet-wrap::swig-lispify "m_damping" 'slotname) :float)
	(#.(bullet-wrap::swig-lispify "m_impulseClamp" 'slotname) :float))

(cl:export '#.(bullet-wrap::swig-lispify "btConstraintSetting" 'classname))

(cl:export '#.(bullet-wrap::swig-lispify "m_tau" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_damping" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_impulseClamp" 'slotname))

(cffi:defcenum #.(bullet-wrap::swig-lispify "btPoint2PointFlags" 'enumname)
	(#.(bullet-wrap::swig-lispify "BT_P2P_FLAGS_ERP" 'enumvalue :keyword) #.1)
	(#.(bullet-wrap::swig-lispify "BT_P2P_FLAGS_CFM" 'enumvalue :keyword) #.2))

(cl:export '#.(bullet-wrap::swig-lispify "btPoint2PointFlags" 'enumname))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btPoint2PointConstraint_makeCPlusPlusInstance" 'function)))

(cffi:defcfun ("_wrap_btPoint2PointConstraint_makeCPlusPlusInstance__SWIG_0" #.(bullet-wrap::swig-lispify "btPoint2PointConstraint_makeCPlusPlusInstance" 'function)) :pointer
  (self :pointer)
  (sizeInBytes :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btPoint2PointConstraint_makeCPlusPlusInstance" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btPoint2PointConstraint_deleteCPlusPlusInstance" 'function)))

(cffi:defcfun ("_wrap_btPoint2PointConstraint_deleteCPlusPlusInstance__SWIG_0" #.(bullet-wrap::swig-lispify "btPoint2PointConstraint_deleteCPlusPlusInstance" 'function)) :void
  (self :pointer)
  (ptr :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btPoint2PointConstraint_deleteCPlusPlusInstance" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btPoint2PointConstraint_makeCPlusPlusInstance" 'function)))

(cffi:defcfun ("_wrap_btPoint2PointConstraint_makeCPlusPlusInstance__SWIG_1" #.(bullet-wrap::swig-lispify "btPoint2PointConstraint_makeCPlusPlusInstance" 'function)) :pointer
  (self :pointer)
  (arg1 :pointer)
  (ptr :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btPoint2PointConstraint_makeCPlusPlusInstance" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btPoint2PointConstraint_deleteCPlusPlusInstance" 'function)))

(cffi:defcfun ("_wrap_btPoint2PointConstraint_deleteCPlusPlusInstance__SWIG_1" #.(bullet-wrap::swig-lispify "btPoint2PointConstraint_deleteCPlusPlusInstance" 'function)) :void
  (self :pointer)
  (arg1 :pointer)
  (arg2 :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btPoint2PointConstraint_deleteCPlusPlusInstance" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btPoint2PointConstraint_makeCPlusArray" 'function)))

(cffi:defcfun ("_wrap_btPoint2PointConstraint_makeCPlusArray__SWIG_0" #.(bullet-wrap::swig-lispify "btPoint2PointConstraint_makeCPlusArray" 'function)) :pointer
  (self :pointer)
  (sizeInBytes :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btPoint2PointConstraint_makeCPlusArray" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btPoint2PointConstraint_deleteCPlusArray" 'function)))

(cffi:defcfun ("_wrap_btPoint2PointConstraint_deleteCPlusArray__SWIG_0" #.(bullet-wrap::swig-lispify "btPoint2PointConstraint_deleteCPlusArray" 'function)) :void
  (self :pointer)
  (ptr :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btPoint2PointConstraint_deleteCPlusArray" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btPoint2PointConstraint_makeCPlusArray" 'function)))

(cffi:defcfun ("_wrap_btPoint2PointConstraint_makeCPlusArray__SWIG_1" #.(bullet-wrap::swig-lispify "btPoint2PointConstraint_makeCPlusArray" 'function)) :pointer
  (self :pointer)
  (arg1 :pointer)
  (ptr :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btPoint2PointConstraint_makeCPlusArray" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btPoint2PointConstraint_deleteCPlusArray" 'function)))

(cffi:defcfun ("_wrap_btPoint2PointConstraint_deleteCPlusArray__SWIG_1" #.(bullet-wrap::swig-lispify "btPoint2PointConstraint_deleteCPlusArray" 'function)) :void
  (self :pointer)
  (arg1 :pointer)
  (arg2 :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btPoint2PointConstraint_deleteCPlusArray" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btPoint2PointConstraint_m_useSolveConstraintObsolete_set" 'function)))

(cffi:defcfun ("_wrap_btPoint2PointConstraint_m_useSolveConstraintObsolete_set" #.(bullet-wrap::swig-lispify "btPoint2PointConstraint_m_useSolveConstraintObsolete_set" 'function)) :void
  (self :pointer)
  (m_useSolveConstraintObsolete :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btPoint2PointConstraint_m_useSolveConstraintObsolete_set" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btPoint2PointConstraint_m_useSolveConstraintObsolete_get" 'function)))

(cffi:defcfun ("_wrap_btPoint2PointConstraint_m_useSolveConstraintObsolete_get" #.(bullet-wrap::swig-lispify "btPoint2PointConstraint_m_useSolveConstraintObsolete_get" 'function)) :pointer
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btPoint2PointConstraint_m_useSolveConstraintObsolete_get" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btPoint2PointConstraint_m_setting_set" 'function)))

(cffi:defcfun ("_wrap_btPoint2PointConstraint_m_setting_set" #.(bullet-wrap::swig-lispify "btPoint2PointConstraint_m_setting_set" 'function)) :void
  (self :pointer)
  (m_setting :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btPoint2PointConstraint_m_setting_set" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btPoint2PointConstraint_m_setting_get" 'function)))

(cffi:defcfun ("_wrap_btPoint2PointConstraint_m_setting_get" #.(bullet-wrap::swig-lispify "btPoint2PointConstraint_m_setting_get" 'function)) :pointer
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btPoint2PointConstraint_m_setting_get" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "new_btPoint2PointConstraint" 'function)))

(cffi:defcfun ("_wrap_new_btPoint2PointConstraint__SWIG_0" #.(bullet-wrap::swig-lispify "new_btPoint2PointConstraint" 'function)) :pointer
  (rbA :pointer)
  (rbB :pointer)
  (pivotInA :pointer)
  (pivotInB :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "new_btPoint2PointConstraint" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "new_btPoint2PointConstraint" 'function)))

(cffi:defcfun ("_wrap_new_btPoint2PointConstraint__SWIG_1" #.(bullet-wrap::swig-lispify "new_btPoint2PointConstraint" 'function)) :pointer
  (rbA :pointer)
  (pivotInA :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "new_btPoint2PointConstraint" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btPoint2PointConstraint_buildJacobian" 'function)))

(cffi:defcfun ("_wrap_btPoint2PointConstraint_buildJacobian" #.(bullet-wrap::swig-lispify "btPoint2PointConstraint_buildJacobian" 'function)) :void
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btPoint2PointConstraint_buildJacobian" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btPoint2PointConstraint_getInfo1" 'function)))

(cffi:defcfun ("_wrap_btPoint2PointConstraint_getInfo1" #.(bullet-wrap::swig-lispify "btPoint2PointConstraint_getInfo1" 'function)) :void
  (self :pointer)
  (info :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btPoint2PointConstraint_getInfo1" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btPoint2PointConstraint_getInfo1NonVirtual" 'function)))

(cffi:defcfun ("_wrap_btPoint2PointConstraint_getInfo1NonVirtual" #.(bullet-wrap::swig-lispify "btPoint2PointConstraint_getInfo1NonVirtual" 'function)) :void
  (self :pointer)
  (info :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btPoint2PointConstraint_getInfo1NonVirtual" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btPoint2PointConstraint_getInfo2" 'function)))

(cffi:defcfun ("_wrap_btPoint2PointConstraint_getInfo2" #.(bullet-wrap::swig-lispify "btPoint2PointConstraint_getInfo2" 'function)) :void
  (self :pointer)
  (info :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btPoint2PointConstraint_getInfo2" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btPoint2PointConstraint_getInfo2NonVirtual" 'function)))

(cffi:defcfun ("_wrap_btPoint2PointConstraint_getInfo2NonVirtual" #.(bullet-wrap::swig-lispify "btPoint2PointConstraint_getInfo2NonVirtual" 'function)) :void
  (self :pointer)
  (info :pointer)
  (body0_trans :pointer)
  (body1_trans :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btPoint2PointConstraint_getInfo2NonVirtual" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btPoint2PointConstraint_updateRHS" 'function)))

(cffi:defcfun ("_wrap_btPoint2PointConstraint_updateRHS" #.(bullet-wrap::swig-lispify "btPoint2PointConstraint_updateRHS" 'function)) :void
  (self :pointer)
  (timeStep :float))

(cl:export '#.(bullet-wrap::swig-lispify "btPoint2PointConstraint_updateRHS" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btPoint2PointConstraint_setPivotA" 'function)))

(cffi:defcfun ("_wrap_btPoint2PointConstraint_setPivotA" #.(bullet-wrap::swig-lispify "btPoint2PointConstraint_setPivotA" 'function)) :void
  (self :pointer)
  (pivotA :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btPoint2PointConstraint_setPivotA" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btPoint2PointConstraint_setPivotB" 'function)))

(cffi:defcfun ("_wrap_btPoint2PointConstraint_setPivotB" #.(bullet-wrap::swig-lispify "btPoint2PointConstraint_setPivotB" 'function)) :void
  (self :pointer)
  (pivotB :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btPoint2PointConstraint_setPivotB" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btPoint2PointConstraint_getPivotInA" 'function)))

(cffi:defcfun ("_wrap_btPoint2PointConstraint_getPivotInA" #.(bullet-wrap::swig-lispify "btPoint2PointConstraint_getPivotInA" 'function)) :pointer
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btPoint2PointConstraint_getPivotInA" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btPoint2PointConstraint_getPivotInB" 'function)))

(cffi:defcfun ("_wrap_btPoint2PointConstraint_getPivotInB" #.(bullet-wrap::swig-lispify "btPoint2PointConstraint_getPivotInB" 'function)) :pointer
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btPoint2PointConstraint_getPivotInB" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btPoint2PointConstraint_setParam" 'function)))

(cffi:defcfun ("_wrap_btPoint2PointConstraint_setParam__SWIG_0" #.(bullet-wrap::swig-lispify "btPoint2PointConstraint_setParam" 'function)) :void
  (self :pointer)
  (num :int)
  (value :float)
  (axis :int))

(cl:export '#.(bullet-wrap::swig-lispify "btPoint2PointConstraint_setParam" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btPoint2PointConstraint_setParam" 'function)))

(cffi:defcfun ("_wrap_btPoint2PointConstraint_setParam__SWIG_1" #.(bullet-wrap::swig-lispify "btPoint2PointConstraint_setParam" 'function)) :void
  (self :pointer)
  (num :int)
  (value :float))

(cl:export '#.(bullet-wrap::swig-lispify "btPoint2PointConstraint_setParam" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btPoint2PointConstraint_getParam" 'function)))

(cffi:defcfun ("_wrap_btPoint2PointConstraint_getParam__SWIG_0" #.(bullet-wrap::swig-lispify "btPoint2PointConstraint_getParam" 'function)) :float
  (self :pointer)
  (num :int)
  (axis :int))

(cl:export '#.(bullet-wrap::swig-lispify "btPoint2PointConstraint_getParam" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btPoint2PointConstraint_getParam" 'function)))

(cffi:defcfun ("_wrap_btPoint2PointConstraint_getParam__SWIG_1" #.(bullet-wrap::swig-lispify "btPoint2PointConstraint_getParam" 'function)) :float
  (self :pointer)
  (num :int))

(cl:export '#.(bullet-wrap::swig-lispify "btPoint2PointConstraint_getParam" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btPoint2PointConstraint_calculateSerializeBufferSize" 'function)))

(cffi:defcfun ("_wrap_btPoint2PointConstraint_calculateSerializeBufferSize" #.(bullet-wrap::swig-lispify "btPoint2PointConstraint_calculateSerializeBufferSize" 'function)) :int
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btPoint2PointConstraint_calculateSerializeBufferSize" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btPoint2PointConstraint_serialize" 'function)))

(cffi:defcfun ("_wrap_btPoint2PointConstraint_serialize" #.(bullet-wrap::swig-lispify "btPoint2PointConstraint_serialize" 'function)) :string
  (self :pointer)
  (dataBuffer :pointer)
  (serializer :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btPoint2PointConstraint_serialize" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "delete_btPoint2PointConstraint" 'function)))

(cffi:defcfun ("_wrap_delete_btPoint2PointConstraint" #.(bullet-wrap::swig-lispify "delete_btPoint2PointConstraint" 'function)) :void
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "delete_btPoint2PointConstraint" 'function))

(cffi:defcstruct #.(bullet-wrap::swig-lispify "btPoint2PointConstraintFloatData" 'classname)
	(#.(bullet-wrap::swig-lispify "m_typeConstraintData" 'slotname) #.(bullet-wrap::swig-lispify "btTypedConstraintData" 'classname))
	(#.(bullet-wrap::swig-lispify "m_pivotInA" 'slotname) #.(bullet-wrap::swig-lispify "btVector3FloatData" 'classname))
	(#.(bullet-wrap::swig-lispify "m_pivotInB" 'slotname) #.(bullet-wrap::swig-lispify "btVector3FloatData" 'classname)))

(cl:export '#.(bullet-wrap::swig-lispify "btPoint2PointConstraintFloatData" 'classname))

(cl:export '#.(bullet-wrap::swig-lispify "m_typeConstraintData" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_pivotInA" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_pivotInB" 'slotname))

(cffi:defcstruct #.(bullet-wrap::swig-lispify "btPoint2PointConstraintDoubleData2" 'classname)
	(#.(bullet-wrap::swig-lispify "m_typeConstraintData" 'slotname) #.(bullet-wrap::swig-lispify "btTypedConstraintDoubleData" 'classname))
	(#.(bullet-wrap::swig-lispify "m_pivotInA" 'slotname) #.(bullet-wrap::swig-lispify "btVector3DoubleData" 'classname))
	(#.(bullet-wrap::swig-lispify "m_pivotInB" 'slotname) #.(bullet-wrap::swig-lispify "btVector3DoubleData" 'classname)))

(cl:export '#.(bullet-wrap::swig-lispify "btPoint2PointConstraintDoubleData2" 'classname))

(cl:export '#.(bullet-wrap::swig-lispify "m_typeConstraintData" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_pivotInA" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_pivotInB" 'slotname))

(cffi:defcstruct #.(bullet-wrap::swig-lispify "btPoint2PointConstraintDoubleData" 'classname)
	(#.(bullet-wrap::swig-lispify "m_typeConstraintData" 'slotname) #.(bullet-wrap::swig-lispify "btTypedConstraintData" 'classname))
	(#.(bullet-wrap::swig-lispify "m_pivotInA" 'slotname) #.(bullet-wrap::swig-lispify "btVector3DoubleData" 'classname))
	(#.(bullet-wrap::swig-lispify "m_pivotInB" 'slotname) #.(bullet-wrap::swig-lispify "btVector3DoubleData" 'classname)))

(cl:export '#.(bullet-wrap::swig-lispify "btPoint2PointConstraintDoubleData" 'classname))

(cl:export '#.(bullet-wrap::swig-lispify "m_typeConstraintData" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_pivotInA" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_pivotInB" 'slotname))

(cl:defconstant #.(bullet-wrap::swig-lispify "_BT_USE_CENTER_LIMIT_" 'constant) 1)

(cl:export '#.(bullet-wrap::swig-lispify "_BT_USE_CENTER_LIMIT_" 'constant))

(cl:defconstant #.(bullet-wrap::swig-lispify "btHingeConstraintDataName" 'constant) "btHingeConstraintFloatData")

(cl:export '#.(bullet-wrap::swig-lispify "btHingeConstraintDataName" 'constant))

(cffi:defcenum #.(bullet-wrap::swig-lispify "btHingeFlags" 'enumname)
	(#.(bullet-wrap::swig-lispify "BT_HINGE_FLAGS_CFM_STOP" 'enumvalue :keyword) #.1)
	(#.(bullet-wrap::swig-lispify "BT_HINGE_FLAGS_ERP_STOP" 'enumvalue :keyword) #.2)
	(#.(bullet-wrap::swig-lispify "BT_HINGE_FLAGS_CFM_NORM" 'enumvalue :keyword) #.4))

(cl:export '#.(bullet-wrap::swig-lispify "btHingeFlags" 'enumname))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btHingeConstraint_makeCPlusPlusInstance" 'function)))

(cffi:defcfun ("_wrap_btHingeConstraint_makeCPlusPlusInstance__SWIG_0" #.(bullet-wrap::swig-lispify "btHingeConstraint_makeCPlusPlusInstance" 'function)) :pointer
  (self :pointer)
  (sizeInBytes :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btHingeConstraint_makeCPlusPlusInstance" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btHingeConstraint_deleteCPlusPlusInstance" 'function)))

(cffi:defcfun ("_wrap_btHingeConstraint_deleteCPlusPlusInstance__SWIG_0" #.(bullet-wrap::swig-lispify "btHingeConstraint_deleteCPlusPlusInstance" 'function)) :void
  (self :pointer)
  (ptr :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btHingeConstraint_deleteCPlusPlusInstance" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btHingeConstraint_makeCPlusPlusInstance" 'function)))

(cffi:defcfun ("_wrap_btHingeConstraint_makeCPlusPlusInstance__SWIG_1" #.(bullet-wrap::swig-lispify "btHingeConstraint_makeCPlusPlusInstance" 'function)) :pointer
  (self :pointer)
  (arg1 :pointer)
  (ptr :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btHingeConstraint_makeCPlusPlusInstance" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btHingeConstraint_deleteCPlusPlusInstance" 'function)))

(cffi:defcfun ("_wrap_btHingeConstraint_deleteCPlusPlusInstance__SWIG_1" #.(bullet-wrap::swig-lispify "btHingeConstraint_deleteCPlusPlusInstance" 'function)) :void
  (self :pointer)
  (arg1 :pointer)
  (arg2 :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btHingeConstraint_deleteCPlusPlusInstance" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btHingeConstraint_makeCPlusArray" 'function)))

(cffi:defcfun ("_wrap_btHingeConstraint_makeCPlusArray__SWIG_0" #.(bullet-wrap::swig-lispify "btHingeConstraint_makeCPlusArray" 'function)) :pointer
  (self :pointer)
  (sizeInBytes :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btHingeConstraint_makeCPlusArray" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btHingeConstraint_deleteCPlusArray" 'function)))

(cffi:defcfun ("_wrap_btHingeConstraint_deleteCPlusArray__SWIG_0" #.(bullet-wrap::swig-lispify "btHingeConstraint_deleteCPlusArray" 'function)) :void
  (self :pointer)
  (ptr :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btHingeConstraint_deleteCPlusArray" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btHingeConstraint_makeCPlusArray" 'function)))

(cffi:defcfun ("_wrap_btHingeConstraint_makeCPlusArray__SWIG_1" #.(bullet-wrap::swig-lispify "btHingeConstraint_makeCPlusArray" 'function)) :pointer
  (self :pointer)
  (arg1 :pointer)
  (ptr :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btHingeConstraint_makeCPlusArray" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btHingeConstraint_deleteCPlusArray" 'function)))

(cffi:defcfun ("_wrap_btHingeConstraint_deleteCPlusArray__SWIG_1" #.(bullet-wrap::swig-lispify "btHingeConstraint_deleteCPlusArray" 'function)) :void
  (self :pointer)
  (arg1 :pointer)
  (arg2 :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btHingeConstraint_deleteCPlusArray" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "new_btHingeConstraint" 'function)))

(cffi:defcfun ("_wrap_new_btHingeConstraint__SWIG_0" #.(bullet-wrap::swig-lispify "new_btHingeConstraint" 'function)) :pointer
  (rbA :pointer)
  (rbB :pointer)
  (pivotInA :pointer)
  (pivotInB :pointer)
  (axisInA :pointer)
  (axisInB :pointer)
  (useReferenceFrameA :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "new_btHingeConstraint" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "new_btHingeConstraint" 'function)))

(cffi:defcfun ("_wrap_new_btHingeConstraint__SWIG_1" #.(bullet-wrap::swig-lispify "new_btHingeConstraint" 'function)) :pointer
  (rbA :pointer)
  (rbB :pointer)
  (pivotInA :pointer)
  (pivotInB :pointer)
  (axisInA :pointer)
  (axisInB :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "new_btHingeConstraint" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "new_btHingeConstraint" 'function)))

(cffi:defcfun ("_wrap_new_btHingeConstraint__SWIG_2" #.(bullet-wrap::swig-lispify "new_btHingeConstraint" 'function)) :pointer
  (rbA :pointer)
  (pivotInA :pointer)
  (axisInA :pointer)
  (useReferenceFrameA :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "new_btHingeConstraint" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "new_btHingeConstraint" 'function)))

(cffi:defcfun ("_wrap_new_btHingeConstraint__SWIG_3" #.(bullet-wrap::swig-lispify "new_btHingeConstraint" 'function)) :pointer
  (rbA :pointer)
  (pivotInA :pointer)
  (axisInA :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "new_btHingeConstraint" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "new_btHingeConstraint" 'function)))

(cffi:defcfun ("_wrap_new_btHingeConstraint__SWIG_4" #.(bullet-wrap::swig-lispify "new_btHingeConstraint" 'function)) :pointer
  (rbA :pointer)
  (rbB :pointer)
  (rbAFrame :pointer)
  (rbBFrame :pointer)
  (useReferenceFrameA :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "new_btHingeConstraint" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "new_btHingeConstraint" 'function)))

(cffi:defcfun ("_wrap_new_btHingeConstraint__SWIG_5" #.(bullet-wrap::swig-lispify "new_btHingeConstraint" 'function)) :pointer
  (rbA :pointer)
  (rbB :pointer)
  (rbAFrame :pointer)
  (rbBFrame :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "new_btHingeConstraint" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "new_btHingeConstraint" 'function)))

(cffi:defcfun ("_wrap_new_btHingeConstraint__SWIG_6" #.(bullet-wrap::swig-lispify "new_btHingeConstraint" 'function)) :pointer
  (rbA :pointer)
  (rbAFrame :pointer)
  (useReferenceFrameA :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "new_btHingeConstraint" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "new_btHingeConstraint" 'function)))

(cffi:defcfun ("_wrap_new_btHingeConstraint__SWIG_7" #.(bullet-wrap::swig-lispify "new_btHingeConstraint" 'function)) :pointer
  (rbA :pointer)
  (rbAFrame :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "new_btHingeConstraint" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btHingeConstraint_buildJacobian" 'function)))

(cffi:defcfun ("_wrap_btHingeConstraint_buildJacobian" #.(bullet-wrap::swig-lispify "btHingeConstraint_buildJacobian" 'function)) :void
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btHingeConstraint_buildJacobian" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btHingeConstraint_getInfo1" 'function)))

(cffi:defcfun ("_wrap_btHingeConstraint_getInfo1" #.(bullet-wrap::swig-lispify "btHingeConstraint_getInfo1" 'function)) :void
  (self :pointer)
  (info :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btHingeConstraint_getInfo1" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btHingeConstraint_getInfo1NonVirtual" 'function)))

(cffi:defcfun ("_wrap_btHingeConstraint_getInfo1NonVirtual" #.(bullet-wrap::swig-lispify "btHingeConstraint_getInfo1NonVirtual" 'function)) :void
  (self :pointer)
  (info :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btHingeConstraint_getInfo1NonVirtual" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btHingeConstraint_getInfo2" 'function)))

(cffi:defcfun ("_wrap_btHingeConstraint_getInfo2" #.(bullet-wrap::swig-lispify "btHingeConstraint_getInfo2" 'function)) :void
  (self :pointer)
  (info :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btHingeConstraint_getInfo2" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btHingeConstraint_getInfo2NonVirtual" 'function)))

(cffi:defcfun ("_wrap_btHingeConstraint_getInfo2NonVirtual" #.(bullet-wrap::swig-lispify "btHingeConstraint_getInfo2NonVirtual" 'function)) :void
  (self :pointer)
  (info :pointer)
  (transA :pointer)
  (transB :pointer)
  (angVelA :pointer)
  (angVelB :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btHingeConstraint_getInfo2NonVirtual" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btHingeConstraint_getInfo2Internal" 'function)))

(cffi:defcfun ("_wrap_btHingeConstraint_getInfo2Internal" #.(bullet-wrap::swig-lispify "btHingeConstraint_getInfo2Internal" 'function)) :void
  (self :pointer)
  (info :pointer)
  (transA :pointer)
  (transB :pointer)
  (angVelA :pointer)
  (angVelB :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btHingeConstraint_getInfo2Internal" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btHingeConstraint_getInfo2InternalUsingFrameOffset" 'function)))

(cffi:defcfun ("_wrap_btHingeConstraint_getInfo2InternalUsingFrameOffset" #.(bullet-wrap::swig-lispify "btHingeConstraint_getInfo2InternalUsingFrameOffset" 'function)) :void
  (self :pointer)
  (info :pointer)
  (transA :pointer)
  (transB :pointer)
  (angVelA :pointer)
  (angVelB :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btHingeConstraint_getInfo2InternalUsingFrameOffset" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btHingeConstraint_updateRHS" 'function)))

(cffi:defcfun ("_wrap_btHingeConstraint_updateRHS" #.(bullet-wrap::swig-lispify "btHingeConstraint_updateRHS" 'function)) :void
  (self :pointer)
  (timeStep :float))

(cl:export '#.(bullet-wrap::swig-lispify "btHingeConstraint_updateRHS" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btHingeConstraint_getRigidBodyA" 'function)))

(cffi:defcfun ("_wrap_btHingeConstraint_getRigidBodyA__SWIG_0" #.(bullet-wrap::swig-lispify "btHingeConstraint_getRigidBodyA" 'function)) :pointer
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btHingeConstraint_getRigidBodyA" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btHingeConstraint_getRigidBodyB" 'function)))

(cffi:defcfun ("_wrap_btHingeConstraint_getRigidBodyB__SWIG_0" #.(bullet-wrap::swig-lispify "btHingeConstraint_getRigidBodyB" 'function)) :pointer
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btHingeConstraint_getRigidBodyB" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btHingeConstraint_getRigidBodyA" 'function)))

(cffi:defcfun ("_wrap_btHingeConstraint_getRigidBodyA__SWIG_1" #.(bullet-wrap::swig-lispify "btHingeConstraint_getRigidBodyA" 'function)) :pointer
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btHingeConstraint_getRigidBodyA" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btHingeConstraint_getRigidBodyB" 'function)))

(cffi:defcfun ("_wrap_btHingeConstraint_getRigidBodyB__SWIG_1" #.(bullet-wrap::swig-lispify "btHingeConstraint_getRigidBodyB" 'function)) :pointer
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btHingeConstraint_getRigidBodyB" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btHingeConstraint_getFrameOffsetA" 'function)))

(cffi:defcfun ("_wrap_btHingeConstraint_getFrameOffsetA" #.(bullet-wrap::swig-lispify "btHingeConstraint_getFrameOffsetA" 'function)) :pointer
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btHingeConstraint_getFrameOffsetA" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btHingeConstraint_getFrameOffsetB" 'function)))

(cffi:defcfun ("_wrap_btHingeConstraint_getFrameOffsetB" #.(bullet-wrap::swig-lispify "btHingeConstraint_getFrameOffsetB" 'function)) :pointer
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btHingeConstraint_getFrameOffsetB" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btHingeConstraint_setFrames" 'function)))

(cffi:defcfun ("_wrap_btHingeConstraint_setFrames" #.(bullet-wrap::swig-lispify "btHingeConstraint_setFrames" 'function)) :void
  (self :pointer)
  (frameA :pointer)
  (frameB :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btHingeConstraint_setFrames" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btHingeConstraint_setAngularOnly" 'function)))

(cffi:defcfun ("_wrap_btHingeConstraint_setAngularOnly" #.(bullet-wrap::swig-lispify "btHingeConstraint_setAngularOnly" 'function)) :void
  (self :pointer)
  (angularOnly :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btHingeConstraint_setAngularOnly" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btHingeConstraint_enableAngularMotor" 'function)))

(cffi:defcfun ("_wrap_btHingeConstraint_enableAngularMotor" #.(bullet-wrap::swig-lispify "btHingeConstraint_enableAngularMotor" 'function)) :void
  (self :pointer)
  (enableMotor :pointer)
  (targetVelocity :float)
  (maxMotorImpulse :float))

(cl:export '#.(bullet-wrap::swig-lispify "btHingeConstraint_enableAngularMotor" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btHingeConstraint_enableMotor" 'function)))

(cffi:defcfun ("_wrap_btHingeConstraint_enableMotor" #.(bullet-wrap::swig-lispify "btHingeConstraint_enableMotor" 'function)) :void
  (self :pointer)
  (enableMotor :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btHingeConstraint_enableMotor" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btHingeConstraint_setMaxMotorImpulse" 'function)))

(cffi:defcfun ("_wrap_btHingeConstraint_setMaxMotorImpulse" #.(bullet-wrap::swig-lispify "btHingeConstraint_setMaxMotorImpulse" 'function)) :void
  (self :pointer)
  (maxMotorImpulse :float))

(cl:export '#.(bullet-wrap::swig-lispify "btHingeConstraint_setMaxMotorImpulse" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btHingeConstraint_setMotorTarget" 'function)))

(cffi:defcfun ("_wrap_btHingeConstraint_setMotorTarget__SWIG_0" #.(bullet-wrap::swig-lispify "btHingeConstraint_setMotorTarget" 'function)) :void
  (self :pointer)
  (qAinB :pointer)
  (dt :float))

(cl:export '#.(bullet-wrap::swig-lispify "btHingeConstraint_setMotorTarget" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btHingeConstraint_setMotorTarget" 'function)))

(cffi:defcfun ("_wrap_btHingeConstraint_setMotorTarget__SWIG_1" #.(bullet-wrap::swig-lispify "btHingeConstraint_setMotorTarget" 'function)) :void
  (self :pointer)
  (targetAngle :float)
  (dt :float))

(cl:export '#.(bullet-wrap::swig-lispify "btHingeConstraint_setMotorTarget" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btHingeConstraint_setLimit" 'function)))

(cffi:defcfun ("_wrap_btHingeConstraint_setLimit__SWIG_0" #.(bullet-wrap::swig-lispify "btHingeConstraint_setLimit" 'function)) :void
  (self :pointer)
  (low :float)
  (high :float)
  (_softness :float)
  (_biasFactor :float)
  (_relaxationFactor :float))

(cl:export '#.(bullet-wrap::swig-lispify "btHingeConstraint_setLimit" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btHingeConstraint_setLimit" 'function)))

(cffi:defcfun ("_wrap_btHingeConstraint_setLimit__SWIG_1" #.(bullet-wrap::swig-lispify "btHingeConstraint_setLimit" 'function)) :void
  (self :pointer)
  (low :float)
  (high :float)
  (_softness :float)
  (_biasFactor :float))

(cl:export '#.(bullet-wrap::swig-lispify "btHingeConstraint_setLimit" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btHingeConstraint_setLimit" 'function)))

(cffi:defcfun ("_wrap_btHingeConstraint_setLimit__SWIG_2" #.(bullet-wrap::swig-lispify "btHingeConstraint_setLimit" 'function)) :void
  (self :pointer)
  (low :float)
  (high :float)
  (_softness :float))

(cl:export '#.(bullet-wrap::swig-lispify "btHingeConstraint_setLimit" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btHingeConstraint_setLimit" 'function)))

(cffi:defcfun ("_wrap_btHingeConstraint_setLimit__SWIG_3" #.(bullet-wrap::swig-lispify "btHingeConstraint_setLimit" 'function)) :void
  (self :pointer)
  (low :float)
  (high :float))

(cl:export '#.(bullet-wrap::swig-lispify "btHingeConstraint_setLimit" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btHingeConstraint_setAxis" 'function)))

(cffi:defcfun ("_wrap_btHingeConstraint_setAxis" #.(bullet-wrap::swig-lispify "btHingeConstraint_setAxis" 'function)) :void
  (self :pointer)
  (axisInA :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btHingeConstraint_setAxis" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btHingeConstraint_getLowerLimit" 'function)))

(cffi:defcfun ("_wrap_btHingeConstraint_getLowerLimit" #.(bullet-wrap::swig-lispify "btHingeConstraint_getLowerLimit" 'function)) :float
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btHingeConstraint_getLowerLimit" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btHingeConstraint_getUpperLimit" 'function)))

(cffi:defcfun ("_wrap_btHingeConstraint_getUpperLimit" #.(bullet-wrap::swig-lispify "btHingeConstraint_getUpperLimit" 'function)) :float
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btHingeConstraint_getUpperLimit" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btHingeConstraint_getHingeAngle" 'function)))

(cffi:defcfun ("_wrap_btHingeConstraint_getHingeAngle__SWIG_0" #.(bullet-wrap::swig-lispify "btHingeConstraint_getHingeAngle" 'function)) :float
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btHingeConstraint_getHingeAngle" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btHingeConstraint_getHingeAngle" 'function)))

(cffi:defcfun ("_wrap_btHingeConstraint_getHingeAngle__SWIG_1" #.(bullet-wrap::swig-lispify "btHingeConstraint_getHingeAngle" 'function)) :float
  (self :pointer)
  (transA :pointer)
  (transB :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btHingeConstraint_getHingeAngle" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btHingeConstraint_testLimit" 'function)))

(cffi:defcfun ("_wrap_btHingeConstraint_testLimit" #.(bullet-wrap::swig-lispify "btHingeConstraint_testLimit" 'function)) :void
  (self :pointer)
  (transA :pointer)
  (transB :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btHingeConstraint_testLimit" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btHingeConstraint_getAFrame" 'function)))

(cffi:defcfun ("_wrap_btHingeConstraint_getAFrame__SWIG_0" #.(bullet-wrap::swig-lispify "btHingeConstraint_getAFrame" 'function)) :pointer
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btHingeConstraint_getAFrame" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btHingeConstraint_getBFrame" 'function)))

(cffi:defcfun ("_wrap_btHingeConstraint_getBFrame__SWIG_0" #.(bullet-wrap::swig-lispify "btHingeConstraint_getBFrame" 'function)) :pointer
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btHingeConstraint_getBFrame" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btHingeConstraint_getAFrame" 'function)))

(cffi:defcfun ("_wrap_btHingeConstraint_getAFrame__SWIG_1" #.(bullet-wrap::swig-lispify "btHingeConstraint_getAFrame" 'function)) :pointer
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btHingeConstraint_getAFrame" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btHingeConstraint_getBFrame" 'function)))

(cffi:defcfun ("_wrap_btHingeConstraint_getBFrame__SWIG_1" #.(bullet-wrap::swig-lispify "btHingeConstraint_getBFrame" 'function)) :pointer
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btHingeConstraint_getBFrame" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btHingeConstraint_getSolveLimit" 'function)))

(cffi:defcfun ("_wrap_btHingeConstraint_getSolveLimit" #.(bullet-wrap::swig-lispify "btHingeConstraint_getSolveLimit" 'function)) :int
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btHingeConstraint_getSolveLimit" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btHingeConstraint_getLimitSign" 'function)))

(cffi:defcfun ("_wrap_btHingeConstraint_getLimitSign" #.(bullet-wrap::swig-lispify "btHingeConstraint_getLimitSign" 'function)) :float
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btHingeConstraint_getLimitSign" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btHingeConstraint_getAngularOnly" 'function)))

(cffi:defcfun ("_wrap_btHingeConstraint_getAngularOnly" #.(bullet-wrap::swig-lispify "btHingeConstraint_getAngularOnly" 'function)) :pointer
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btHingeConstraint_getAngularOnly" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btHingeConstraint_getEnableAngularMotor" 'function)))

(cffi:defcfun ("_wrap_btHingeConstraint_getEnableAngularMotor" #.(bullet-wrap::swig-lispify "btHingeConstraint_getEnableAngularMotor" 'function)) :pointer
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btHingeConstraint_getEnableAngularMotor" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btHingeConstraint_getMotorTargetVelosity" 'function)))

(cffi:defcfun ("_wrap_btHingeConstraint_getMotorTargetVelosity" #.(bullet-wrap::swig-lispify "btHingeConstraint_getMotorTargetVelosity" 'function)) :float
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btHingeConstraint_getMotorTargetVelosity" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btHingeConstraint_getMaxMotorImpulse" 'function)))

(cffi:defcfun ("_wrap_btHingeConstraint_getMaxMotorImpulse" #.(bullet-wrap::swig-lispify "btHingeConstraint_getMaxMotorImpulse" 'function)) :float
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btHingeConstraint_getMaxMotorImpulse" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btHingeConstraint_getUseFrameOffset" 'function)))

(cffi:defcfun ("_wrap_btHingeConstraint_getUseFrameOffset" #.(bullet-wrap::swig-lispify "btHingeConstraint_getUseFrameOffset" 'function)) :pointer
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btHingeConstraint_getUseFrameOffset" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btHingeConstraint_setUseFrameOffset" 'function)))

(cffi:defcfun ("_wrap_btHingeConstraint_setUseFrameOffset" #.(bullet-wrap::swig-lispify "btHingeConstraint_setUseFrameOffset" 'function)) :void
  (self :pointer)
  (frameOffsetOnOff :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btHingeConstraint_setUseFrameOffset" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btHingeConstraint_setParam" 'function)))

(cffi:defcfun ("_wrap_btHingeConstraint_setParam__SWIG_0" #.(bullet-wrap::swig-lispify "btHingeConstraint_setParam" 'function)) :void
  (self :pointer)
  (num :int)
  (value :float)
  (axis :int))

(cl:export '#.(bullet-wrap::swig-lispify "btHingeConstraint_setParam" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btHingeConstraint_setParam" 'function)))

(cffi:defcfun ("_wrap_btHingeConstraint_setParam__SWIG_1" #.(bullet-wrap::swig-lispify "btHingeConstraint_setParam" 'function)) :void
  (self :pointer)
  (num :int)
  (value :float))

(cl:export '#.(bullet-wrap::swig-lispify "btHingeConstraint_setParam" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btHingeConstraint_getParam" 'function)))

(cffi:defcfun ("_wrap_btHingeConstraint_getParam__SWIG_0" #.(bullet-wrap::swig-lispify "btHingeConstraint_getParam" 'function)) :float
  (self :pointer)
  (num :int)
  (axis :int))

(cl:export '#.(bullet-wrap::swig-lispify "btHingeConstraint_getParam" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btHingeConstraint_getParam" 'function)))

(cffi:defcfun ("_wrap_btHingeConstraint_getParam__SWIG_1" #.(bullet-wrap::swig-lispify "btHingeConstraint_getParam" 'function)) :float
  (self :pointer)
  (num :int))

(cl:export '#.(bullet-wrap::swig-lispify "btHingeConstraint_getParam" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btHingeConstraint_calculateSerializeBufferSize" 'function)))

(cffi:defcfun ("_wrap_btHingeConstraint_calculateSerializeBufferSize" #.(bullet-wrap::swig-lispify "btHingeConstraint_calculateSerializeBufferSize" 'function)) :int
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btHingeConstraint_calculateSerializeBufferSize" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btHingeConstraint_serialize" 'function)))

(cffi:defcfun ("_wrap_btHingeConstraint_serialize" #.(bullet-wrap::swig-lispify "btHingeConstraint_serialize" 'function)) :string
  (self :pointer)
  (dataBuffer :pointer)
  (serializer :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btHingeConstraint_serialize" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "delete_btHingeConstraint" 'function)))

(cffi:defcfun ("_wrap_delete_btHingeConstraint" #.(bullet-wrap::swig-lispify "delete_btHingeConstraint" 'function)) :void
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "delete_btHingeConstraint" 'function))

(cffi:defcstruct #.(bullet-wrap::swig-lispify "btHingeConstraintDoubleData" 'classname)
	(#.(bullet-wrap::swig-lispify "m_typeConstraintData" 'slotname) #.(bullet-wrap::swig-lispify "btTypedConstraintData" 'classname))
	(#.(bullet-wrap::swig-lispify "m_rbAFrame" 'slotname) #.(bullet-wrap::swig-lispify "btTransformDoubleData" 'classname))
	(#.(bullet-wrap::swig-lispify "m_rbBFrame" 'slotname) #.(bullet-wrap::swig-lispify "btTransformDoubleData" 'classname))
	(#.(bullet-wrap::swig-lispify "m_useReferenceFrameA" 'slotname) :int)
	(#.(bullet-wrap::swig-lispify "m_angularOnly" 'slotname) :int)
	(#.(bullet-wrap::swig-lispify "m_enableAngularMotor" 'slotname) :int)
	(#.(bullet-wrap::swig-lispify "m_motorTargetVelocity" 'slotname) :float)
	(#.(bullet-wrap::swig-lispify "m_maxMotorImpulse" 'slotname) :float)
	(#.(bullet-wrap::swig-lispify "m_lowerLimit" 'slotname) :float)
	(#.(bullet-wrap::swig-lispify "m_upperLimit" 'slotname) :float)
	(#.(bullet-wrap::swig-lispify "m_limitSoftness" 'slotname) :float)
	(#.(bullet-wrap::swig-lispify "m_biasFactor" 'slotname) :float)
	(#.(bullet-wrap::swig-lispify "m_relaxationFactor" 'slotname) :float))

(cl:export '#.(bullet-wrap::swig-lispify "btHingeConstraintDoubleData" 'classname))

(cl:export '#.(bullet-wrap::swig-lispify "m_typeConstraintData" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_rbAFrame" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_rbBFrame" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_useReferenceFrameA" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_angularOnly" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_enableAngularMotor" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_motorTargetVelocity" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_maxMotorImpulse" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_lowerLimit" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_upperLimit" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_limitSoftness" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_biasFactor" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_relaxationFactor" 'slotname))

(cffi:defcstruct #.(bullet-wrap::swig-lispify "btHingeConstraintFloatData" 'classname)
	(#.(bullet-wrap::swig-lispify "m_typeConstraintData" 'slotname) #.(bullet-wrap::swig-lispify "btTypedConstraintData" 'classname))
	(#.(bullet-wrap::swig-lispify "m_rbAFrame" 'slotname) #.(bullet-wrap::swig-lispify "btTransformFloatData" 'classname))
	(#.(bullet-wrap::swig-lispify "m_rbBFrame" 'slotname) #.(bullet-wrap::swig-lispify "btTransformFloatData" 'classname))
	(#.(bullet-wrap::swig-lispify "m_useReferenceFrameA" 'slotname) :int)
	(#.(bullet-wrap::swig-lispify "m_angularOnly" 'slotname) :int)
	(#.(bullet-wrap::swig-lispify "m_enableAngularMotor" 'slotname) :int)
	(#.(bullet-wrap::swig-lispify "m_motorTargetVelocity" 'slotname) :float)
	(#.(bullet-wrap::swig-lispify "m_maxMotorImpulse" 'slotname) :float)
	(#.(bullet-wrap::swig-lispify "m_lowerLimit" 'slotname) :float)
	(#.(bullet-wrap::swig-lispify "m_upperLimit" 'slotname) :float)
	(#.(bullet-wrap::swig-lispify "m_limitSoftness" 'slotname) :float)
	(#.(bullet-wrap::swig-lispify "m_biasFactor" 'slotname) :float)
	(#.(bullet-wrap::swig-lispify "m_relaxationFactor" 'slotname) :float))

(cl:export '#.(bullet-wrap::swig-lispify "btHingeConstraintFloatData" 'classname))

(cl:export '#.(bullet-wrap::swig-lispify "m_typeConstraintData" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_rbAFrame" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_rbBFrame" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_useReferenceFrameA" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_angularOnly" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_enableAngularMotor" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_motorTargetVelocity" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_maxMotorImpulse" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_lowerLimit" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_upperLimit" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_limitSoftness" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_biasFactor" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_relaxationFactor" 'slotname))

(cffi:defcstruct #.(bullet-wrap::swig-lispify "btHingeConstraintDoubleData2" 'classname)
	(#.(bullet-wrap::swig-lispify "m_typeConstraintData" 'slotname) #.(bullet-wrap::swig-lispify "btTypedConstraintDoubleData" 'classname))
	(#.(bullet-wrap::swig-lispify "m_rbAFrame" 'slotname) #.(bullet-wrap::swig-lispify "btTransformDoubleData" 'classname))
	(#.(bullet-wrap::swig-lispify "m_rbBFrame" 'slotname) #.(bullet-wrap::swig-lispify "btTransformDoubleData" 'classname))
	(#.(bullet-wrap::swig-lispify "m_useReferenceFrameA" 'slotname) :int)
	(#.(bullet-wrap::swig-lispify "m_angularOnly" 'slotname) :int)
	(#.(bullet-wrap::swig-lispify "m_enableAngularMotor" 'slotname) :int)
	(#.(bullet-wrap::swig-lispify "m_motorTargetVelocity" 'slotname) :double)
	(#.(bullet-wrap::swig-lispify "m_maxMotorImpulse" 'slotname) :double)
	(#.(bullet-wrap::swig-lispify "m_lowerLimit" 'slotname) :double)
	(#.(bullet-wrap::swig-lispify "m_upperLimit" 'slotname) :double)
	(#.(bullet-wrap::swig-lispify "m_limitSoftness" 'slotname) :double)
	(#.(bullet-wrap::swig-lispify "m_biasFactor" 'slotname) :double)
	(#.(bullet-wrap::swig-lispify "m_relaxationFactor" 'slotname) :double)
	(#.(bullet-wrap::swig-lispify "m_padding1" 'slotname) :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btHingeConstraintDoubleData2" 'classname))

(cl:export '#.(bullet-wrap::swig-lispify "m_typeConstraintData" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_rbAFrame" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_rbBFrame" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_useReferenceFrameA" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_angularOnly" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_enableAngularMotor" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_motorTargetVelocity" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_maxMotorImpulse" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_lowerLimit" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_upperLimit" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_limitSoftness" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_biasFactor" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_relaxationFactor" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_padding1" 'slotname))

(cl:defconstant #.(bullet-wrap::swig-lispify "btConeTwistConstraintDataName" 'constant) "btConeTwistConstraintData")

(cl:export '#.(bullet-wrap::swig-lispify "btConeTwistConstraintDataName" 'constant))

(cffi:defcenum #.(bullet-wrap::swig-lispify "btConeTwistFlags" 'enumname)
	(#.(bullet-wrap::swig-lispify "BT_CONETWIST_FLAGS_LIN_CFM" 'enumvalue :keyword) #.1)
	(#.(bullet-wrap::swig-lispify "BT_CONETWIST_FLAGS_LIN_ERP" 'enumvalue :keyword) #.2)
	(#.(bullet-wrap::swig-lispify "BT_CONETWIST_FLAGS_ANG_CFM" 'enumvalue :keyword) #.4))

(cl:export '#.(bullet-wrap::swig-lispify "btConeTwistFlags" 'enumname))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btConeTwistConstraint_makeCPlusPlusInstance" 'function)))

(cffi:defcfun ("_wrap_btConeTwistConstraint_makeCPlusPlusInstance__SWIG_0" #.(bullet-wrap::swig-lispify "btConeTwistConstraint_makeCPlusPlusInstance" 'function)) :pointer
  (self :pointer)
  (sizeInBytes :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btConeTwistConstraint_makeCPlusPlusInstance" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btConeTwistConstraint_deleteCPlusPlusInstance" 'function)))

(cffi:defcfun ("_wrap_btConeTwistConstraint_deleteCPlusPlusInstance__SWIG_0" #.(bullet-wrap::swig-lispify "btConeTwistConstraint_deleteCPlusPlusInstance" 'function)) :void
  (self :pointer)
  (ptr :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btConeTwistConstraint_deleteCPlusPlusInstance" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btConeTwistConstraint_makeCPlusPlusInstance" 'function)))

(cffi:defcfun ("_wrap_btConeTwistConstraint_makeCPlusPlusInstance__SWIG_1" #.(bullet-wrap::swig-lispify "btConeTwistConstraint_makeCPlusPlusInstance" 'function)) :pointer
  (self :pointer)
  (arg1 :pointer)
  (ptr :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btConeTwistConstraint_makeCPlusPlusInstance" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btConeTwistConstraint_deleteCPlusPlusInstance" 'function)))

(cffi:defcfun ("_wrap_btConeTwistConstraint_deleteCPlusPlusInstance__SWIG_1" #.(bullet-wrap::swig-lispify "btConeTwistConstraint_deleteCPlusPlusInstance" 'function)) :void
  (self :pointer)
  (arg1 :pointer)
  (arg2 :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btConeTwistConstraint_deleteCPlusPlusInstance" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btConeTwistConstraint_makeCPlusArray" 'function)))

(cffi:defcfun ("_wrap_btConeTwistConstraint_makeCPlusArray__SWIG_0" #.(bullet-wrap::swig-lispify "btConeTwistConstraint_makeCPlusArray" 'function)) :pointer
  (self :pointer)
  (sizeInBytes :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btConeTwistConstraint_makeCPlusArray" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btConeTwistConstraint_deleteCPlusArray" 'function)))

(cffi:defcfun ("_wrap_btConeTwistConstraint_deleteCPlusArray__SWIG_0" #.(bullet-wrap::swig-lispify "btConeTwistConstraint_deleteCPlusArray" 'function)) :void
  (self :pointer)
  (ptr :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btConeTwistConstraint_deleteCPlusArray" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btConeTwistConstraint_makeCPlusArray" 'function)))

(cffi:defcfun ("_wrap_btConeTwistConstraint_makeCPlusArray__SWIG_1" #.(bullet-wrap::swig-lispify "btConeTwistConstraint_makeCPlusArray" 'function)) :pointer
  (self :pointer)
  (arg1 :pointer)
  (ptr :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btConeTwistConstraint_makeCPlusArray" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btConeTwistConstraint_deleteCPlusArray" 'function)))

(cffi:defcfun ("_wrap_btConeTwistConstraint_deleteCPlusArray__SWIG_1" #.(bullet-wrap::swig-lispify "btConeTwistConstraint_deleteCPlusArray" 'function)) :void
  (self :pointer)
  (arg1 :pointer)
  (arg2 :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btConeTwistConstraint_deleteCPlusArray" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "new_btConeTwistConstraint" 'function)))

(cffi:defcfun ("_wrap_new_btConeTwistConstraint__SWIG_0" #.(bullet-wrap::swig-lispify "new_btConeTwistConstraint" 'function)) :pointer
  (rbA :pointer)
  (rbB :pointer)
  (rbAFrame :pointer)
  (rbBFrame :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "new_btConeTwistConstraint" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "new_btConeTwistConstraint" 'function)))

(cffi:defcfun ("_wrap_new_btConeTwistConstraint__SWIG_1" #.(bullet-wrap::swig-lispify "new_btConeTwistConstraint" 'function)) :pointer
  (rbA :pointer)
  (rbAFrame :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "new_btConeTwistConstraint" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btConeTwistConstraint_buildJacobian" 'function)))

(cffi:defcfun ("_wrap_btConeTwistConstraint_buildJacobian" #.(bullet-wrap::swig-lispify "btConeTwistConstraint_buildJacobian" 'function)) :void
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btConeTwistConstraint_buildJacobian" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btConeTwistConstraint_getInfo1" 'function)))

(cffi:defcfun ("_wrap_btConeTwistConstraint_getInfo1" #.(bullet-wrap::swig-lispify "btConeTwistConstraint_getInfo1" 'function)) :void
  (self :pointer)
  (info :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btConeTwistConstraint_getInfo1" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btConeTwistConstraint_getInfo1NonVirtual" 'function)))

(cffi:defcfun ("_wrap_btConeTwistConstraint_getInfo1NonVirtual" #.(bullet-wrap::swig-lispify "btConeTwistConstraint_getInfo1NonVirtual" 'function)) :void
  (self :pointer)
  (info :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btConeTwistConstraint_getInfo1NonVirtual" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btConeTwistConstraint_getInfo2" 'function)))

(cffi:defcfun ("_wrap_btConeTwistConstraint_getInfo2" #.(bullet-wrap::swig-lispify "btConeTwistConstraint_getInfo2" 'function)) :void
  (self :pointer)
  (info :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btConeTwistConstraint_getInfo2" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btConeTwistConstraint_getInfo2NonVirtual" 'function)))

(cffi:defcfun ("_wrap_btConeTwistConstraint_getInfo2NonVirtual" #.(bullet-wrap::swig-lispify "btConeTwistConstraint_getInfo2NonVirtual" 'function)) :void
  (self :pointer)
  (info :pointer)
  (transA :pointer)
  (transB :pointer)
  (invInertiaWorldA :pointer)
  (invInertiaWorldB :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btConeTwistConstraint_getInfo2NonVirtual" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btConeTwistConstraint_solveConstraintObsolete" 'function)))

(cffi:defcfun ("_wrap_btConeTwistConstraint_solveConstraintObsolete" #.(bullet-wrap::swig-lispify "btConeTwistConstraint_solveConstraintObsolete" 'function)) :void
  (self :pointer)
  (bodyA :pointer)
  (bodyB :pointer)
  (timeStep :float))

(cl:export '#.(bullet-wrap::swig-lispify "btConeTwistConstraint_solveConstraintObsolete" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btConeTwistConstraint_updateRHS" 'function)))

(cffi:defcfun ("_wrap_btConeTwistConstraint_updateRHS" #.(bullet-wrap::swig-lispify "btConeTwistConstraint_updateRHS" 'function)) :void
  (self :pointer)
  (timeStep :float))

(cl:export '#.(bullet-wrap::swig-lispify "btConeTwistConstraint_updateRHS" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btConeTwistConstraint_getRigidBodyA" 'function)))

(cffi:defcfun ("_wrap_btConeTwistConstraint_getRigidBodyA" #.(bullet-wrap::swig-lispify "btConeTwistConstraint_getRigidBodyA" 'function)) :pointer
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btConeTwistConstraint_getRigidBodyA" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btConeTwistConstraint_getRigidBodyB" 'function)))

(cffi:defcfun ("_wrap_btConeTwistConstraint_getRigidBodyB" #.(bullet-wrap::swig-lispify "btConeTwistConstraint_getRigidBodyB" 'function)) :pointer
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btConeTwistConstraint_getRigidBodyB" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btConeTwistConstraint_setAngularOnly" 'function)))

(cffi:defcfun ("_wrap_btConeTwistConstraint_setAngularOnly" #.(bullet-wrap::swig-lispify "btConeTwistConstraint_setAngularOnly" 'function)) :void
  (self :pointer)
  (angularOnly :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btConeTwistConstraint_setAngularOnly" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btConeTwistConstraint_setLimit" 'function)))

(cffi:defcfun ("_wrap_btConeTwistConstraint_setLimit__SWIG_0" #.(bullet-wrap::swig-lispify "btConeTwistConstraint_setLimit" 'function)) :void
  (self :pointer)
  (limitIndex :int)
  (limitValue :float))

(cl:export '#.(bullet-wrap::swig-lispify "btConeTwistConstraint_setLimit" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btConeTwistConstraint_setLimit" 'function)))

(cffi:defcfun ("_wrap_btConeTwistConstraint_setLimit__SWIG_1" #.(bullet-wrap::swig-lispify "btConeTwistConstraint_setLimit" 'function)) :void
  (self :pointer)
  (_swingSpan1 :float)
  (_swingSpan2 :float)
  (_twistSpan :float)
  (_softness :float)
  (_biasFactor :float)
  (_relaxationFactor :float))

(cl:export '#.(bullet-wrap::swig-lispify "btConeTwistConstraint_setLimit" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btConeTwistConstraint_setLimit" 'function)))

(cffi:defcfun ("_wrap_btConeTwistConstraint_setLimit__SWIG_2" #.(bullet-wrap::swig-lispify "btConeTwistConstraint_setLimit" 'function)) :void
  (self :pointer)
  (_swingSpan1 :float)
  (_swingSpan2 :float)
  (_twistSpan :float)
  (_softness :float)
  (_biasFactor :float))

(cl:export '#.(bullet-wrap::swig-lispify "btConeTwistConstraint_setLimit" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btConeTwistConstraint_setLimit" 'function)))

(cffi:defcfun ("_wrap_btConeTwistConstraint_setLimit__SWIG_3" #.(bullet-wrap::swig-lispify "btConeTwistConstraint_setLimit" 'function)) :void
  (self :pointer)
  (_swingSpan1 :float)
  (_swingSpan2 :float)
  (_twistSpan :float)
  (_softness :float))

(cl:export '#.(bullet-wrap::swig-lispify "btConeTwistConstraint_setLimit" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btConeTwistConstraint_setLimit" 'function)))

(cffi:defcfun ("_wrap_btConeTwistConstraint_setLimit__SWIG_4" #.(bullet-wrap::swig-lispify "btConeTwistConstraint_setLimit" 'function)) :void
  (self :pointer)
  (_swingSpan1 :float)
  (_swingSpan2 :float)
  (_twistSpan :float))

(cl:export '#.(bullet-wrap::swig-lispify "btConeTwistConstraint_setLimit" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btConeTwistConstraint_getAFrame" 'function)))

(cffi:defcfun ("_wrap_btConeTwistConstraint_getAFrame" #.(bullet-wrap::swig-lispify "btConeTwistConstraint_getAFrame" 'function)) :pointer
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btConeTwistConstraint_getAFrame" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btConeTwistConstraint_getBFrame" 'function)))

(cffi:defcfun ("_wrap_btConeTwistConstraint_getBFrame" #.(bullet-wrap::swig-lispify "btConeTwistConstraint_getBFrame" 'function)) :pointer
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btConeTwistConstraint_getBFrame" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btConeTwistConstraint_getSolveTwistLimit" 'function)))

(cffi:defcfun ("_wrap_btConeTwistConstraint_getSolveTwistLimit" #.(bullet-wrap::swig-lispify "btConeTwistConstraint_getSolveTwistLimit" 'function)) :int
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btConeTwistConstraint_getSolveTwistLimit" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btConeTwistConstraint_getSolveSwingLimit" 'function)))

(cffi:defcfun ("_wrap_btConeTwistConstraint_getSolveSwingLimit" #.(bullet-wrap::swig-lispify "btConeTwistConstraint_getSolveSwingLimit" 'function)) :int
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btConeTwistConstraint_getSolveSwingLimit" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btConeTwistConstraint_getTwistLimitSign" 'function)))

(cffi:defcfun ("_wrap_btConeTwistConstraint_getTwistLimitSign" #.(bullet-wrap::swig-lispify "btConeTwistConstraint_getTwistLimitSign" 'function)) :float
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btConeTwistConstraint_getTwistLimitSign" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btConeTwistConstraint_calcAngleInfo" 'function)))

(cffi:defcfun ("_wrap_btConeTwistConstraint_calcAngleInfo" #.(bullet-wrap::swig-lispify "btConeTwistConstraint_calcAngleInfo" 'function)) :void
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btConeTwistConstraint_calcAngleInfo" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btConeTwistConstraint_calcAngleInfo2" 'function)))

(cffi:defcfun ("_wrap_btConeTwistConstraint_calcAngleInfo2" #.(bullet-wrap::swig-lispify "btConeTwistConstraint_calcAngleInfo2" 'function)) :void
  (self :pointer)
  (transA :pointer)
  (transB :pointer)
  (invInertiaWorldA :pointer)
  (invInertiaWorldB :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btConeTwistConstraint_calcAngleInfo2" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btConeTwistConstraint_getSwingSpan1" 'function)))

(cffi:defcfun ("_wrap_btConeTwistConstraint_getSwingSpan1" #.(bullet-wrap::swig-lispify "btConeTwistConstraint_getSwingSpan1" 'function)) :float
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btConeTwistConstraint_getSwingSpan1" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btConeTwistConstraint_getSwingSpan2" 'function)))

(cffi:defcfun ("_wrap_btConeTwistConstraint_getSwingSpan2" #.(bullet-wrap::swig-lispify "btConeTwistConstraint_getSwingSpan2" 'function)) :float
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btConeTwistConstraint_getSwingSpan2" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btConeTwistConstraint_getTwistSpan" 'function)))

(cffi:defcfun ("_wrap_btConeTwistConstraint_getTwistSpan" #.(bullet-wrap::swig-lispify "btConeTwistConstraint_getTwistSpan" 'function)) :float
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btConeTwistConstraint_getTwistSpan" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btConeTwistConstraint_getTwistAngle" 'function)))

(cffi:defcfun ("_wrap_btConeTwistConstraint_getTwistAngle" #.(bullet-wrap::swig-lispify "btConeTwistConstraint_getTwistAngle" 'function)) :float
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btConeTwistConstraint_getTwistAngle" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btConeTwistConstraint_isPastSwingLimit" 'function)))

(cffi:defcfun ("_wrap_btConeTwistConstraint_isPastSwingLimit" #.(bullet-wrap::swig-lispify "btConeTwistConstraint_isPastSwingLimit" 'function)) :pointer
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btConeTwistConstraint_isPastSwingLimit" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btConeTwistConstraint_setDamping" 'function)))

(cffi:defcfun ("_wrap_btConeTwistConstraint_setDamping" #.(bullet-wrap::swig-lispify "btConeTwistConstraint_setDamping" 'function)) :void
  (self :pointer)
  (damping :float))

(cl:export '#.(bullet-wrap::swig-lispify "btConeTwistConstraint_setDamping" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btConeTwistConstraint_enableMotor" 'function)))

(cffi:defcfun ("_wrap_btConeTwistConstraint_enableMotor" #.(bullet-wrap::swig-lispify "btConeTwistConstraint_enableMotor" 'function)) :void
  (self :pointer)
  (b :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btConeTwistConstraint_enableMotor" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btConeTwistConstraint_setMaxMotorImpulse" 'function)))

(cffi:defcfun ("_wrap_btConeTwistConstraint_setMaxMotorImpulse" #.(bullet-wrap::swig-lispify "btConeTwistConstraint_setMaxMotorImpulse" 'function)) :void
  (self :pointer)
  (maxMotorImpulse :float))

(cl:export '#.(bullet-wrap::swig-lispify "btConeTwistConstraint_setMaxMotorImpulse" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btConeTwistConstraint_setMaxMotorImpulseNormalized" 'function)))

(cffi:defcfun ("_wrap_btConeTwistConstraint_setMaxMotorImpulseNormalized" #.(bullet-wrap::swig-lispify "btConeTwistConstraint_setMaxMotorImpulseNormalized" 'function)) :void
  (self :pointer)
  (maxMotorImpulse :float))

(cl:export '#.(bullet-wrap::swig-lispify "btConeTwistConstraint_setMaxMotorImpulseNormalized" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btConeTwistConstraint_getFixThresh" 'function)))

(cffi:defcfun ("_wrap_btConeTwistConstraint_getFixThresh" #.(bullet-wrap::swig-lispify "btConeTwistConstraint_getFixThresh" 'function)) :float
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btConeTwistConstraint_getFixThresh" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btConeTwistConstraint_setFixThresh" 'function)))

(cffi:defcfun ("_wrap_btConeTwistConstraint_setFixThresh" #.(bullet-wrap::swig-lispify "btConeTwistConstraint_setFixThresh" 'function)) :void
  (self :pointer)
  (fixThresh :float))

(cl:export '#.(bullet-wrap::swig-lispify "btConeTwistConstraint_setFixThresh" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btConeTwistConstraint_setMotorTarget" 'function)))

(cffi:defcfun ("_wrap_btConeTwistConstraint_setMotorTarget" #.(bullet-wrap::swig-lispify "btConeTwistConstraint_setMotorTarget" 'function)) :void
  (self :pointer)
  (q :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btConeTwistConstraint_setMotorTarget" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btConeTwistConstraint_setMotorTargetInConstraintSpace" 'function)))

(cffi:defcfun ("_wrap_btConeTwistConstraint_setMotorTargetInConstraintSpace" #.(bullet-wrap::swig-lispify "btConeTwistConstraint_setMotorTargetInConstraintSpace" 'function)) :void
  (self :pointer)
  (q :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btConeTwistConstraint_setMotorTargetInConstraintSpace" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btConeTwistConstraint_GetPointForAngle" 'function)))

(cffi:defcfun ("_wrap_btConeTwistConstraint_GetPointForAngle" #.(bullet-wrap::swig-lispify "btConeTwistConstraint_GetPointForAngle" 'function)) :pointer
  (self :pointer)
  (fAngleInRadians :float)
  (fLength :float))

(cl:export '#.(bullet-wrap::swig-lispify "btConeTwistConstraint_GetPointForAngle" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btConeTwistConstraint_setParam" 'function)))

(cffi:defcfun ("_wrap_btConeTwistConstraint_setParam__SWIG_0" #.(bullet-wrap::swig-lispify "btConeTwistConstraint_setParam" 'function)) :void
  (self :pointer)
  (num :int)
  (value :float)
  (axis :int))

(cl:export '#.(bullet-wrap::swig-lispify "btConeTwistConstraint_setParam" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btConeTwistConstraint_setParam" 'function)))

(cffi:defcfun ("_wrap_btConeTwistConstraint_setParam__SWIG_1" #.(bullet-wrap::swig-lispify "btConeTwistConstraint_setParam" 'function)) :void
  (self :pointer)
  (num :int)
  (value :float))

(cl:export '#.(bullet-wrap::swig-lispify "btConeTwistConstraint_setParam" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btConeTwistConstraint_setFrames" 'function)))

(cffi:defcfun ("_wrap_btConeTwistConstraint_setFrames" #.(bullet-wrap::swig-lispify "btConeTwistConstraint_setFrames" 'function)) :void
  (self :pointer)
  (frameA :pointer)
  (frameB :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btConeTwistConstraint_setFrames" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btConeTwistConstraint_getFrameOffsetA" 'function)))

(cffi:defcfun ("_wrap_btConeTwistConstraint_getFrameOffsetA" #.(bullet-wrap::swig-lispify "btConeTwistConstraint_getFrameOffsetA" 'function)) :pointer
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btConeTwistConstraint_getFrameOffsetA" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btConeTwistConstraint_getFrameOffsetB" 'function)))

(cffi:defcfun ("_wrap_btConeTwistConstraint_getFrameOffsetB" #.(bullet-wrap::swig-lispify "btConeTwistConstraint_getFrameOffsetB" 'function)) :pointer
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btConeTwistConstraint_getFrameOffsetB" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btConeTwistConstraint_getParam" 'function)))

(cffi:defcfun ("_wrap_btConeTwistConstraint_getParam__SWIG_0" #.(bullet-wrap::swig-lispify "btConeTwistConstraint_getParam" 'function)) :float
  (self :pointer)
  (num :int)
  (axis :int))

(cl:export '#.(bullet-wrap::swig-lispify "btConeTwistConstraint_getParam" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btConeTwistConstraint_getParam" 'function)))

(cffi:defcfun ("_wrap_btConeTwistConstraint_getParam__SWIG_1" #.(bullet-wrap::swig-lispify "btConeTwistConstraint_getParam" 'function)) :float
  (self :pointer)
  (num :int))

(cl:export '#.(bullet-wrap::swig-lispify "btConeTwistConstraint_getParam" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btConeTwistConstraint_calculateSerializeBufferSize" 'function)))

(cffi:defcfun ("_wrap_btConeTwistConstraint_calculateSerializeBufferSize" #.(bullet-wrap::swig-lispify "btConeTwistConstraint_calculateSerializeBufferSize" 'function)) :int
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btConeTwistConstraint_calculateSerializeBufferSize" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btConeTwistConstraint_serialize" 'function)))

(cffi:defcfun ("_wrap_btConeTwistConstraint_serialize" #.(bullet-wrap::swig-lispify "btConeTwistConstraint_serialize" 'function)) :string
  (self :pointer)
  (dataBuffer :pointer)
  (serializer :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btConeTwistConstraint_serialize" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "delete_btConeTwistConstraint" 'function)))

(cffi:defcfun ("_wrap_delete_btConeTwistConstraint" #.(bullet-wrap::swig-lispify "delete_btConeTwistConstraint" 'function)) :void
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "delete_btConeTwistConstraint" 'function))

(cffi:defcstruct #.(bullet-wrap::swig-lispify "btConeTwistConstraintDoubleData" 'classname)
	(#.(bullet-wrap::swig-lispify "m_typeConstraintData" 'slotname) #.(bullet-wrap::swig-lispify "btTypedConstraintDoubleData" 'classname))
	(#.(bullet-wrap::swig-lispify "m_rbAFrame" 'slotname) #.(bullet-wrap::swig-lispify "btTransformDoubleData" 'classname))
	(#.(bullet-wrap::swig-lispify "m_rbBFrame" 'slotname) #.(bullet-wrap::swig-lispify "btTransformDoubleData" 'classname))
	(#.(bullet-wrap::swig-lispify "m_swingSpan1" 'slotname) :double)
	(#.(bullet-wrap::swig-lispify "m_swingSpan2" 'slotname) :double)
	(#.(bullet-wrap::swig-lispify "m_twistSpan" 'slotname) :double)
	(#.(bullet-wrap::swig-lispify "m_limitSoftness" 'slotname) :double)
	(#.(bullet-wrap::swig-lispify "m_biasFactor" 'slotname) :double)
	(#.(bullet-wrap::swig-lispify "m_relaxationFactor" 'slotname) :double)
	(#.(bullet-wrap::swig-lispify "m_damping" 'slotname) :double))

(cl:export '#.(bullet-wrap::swig-lispify "btConeTwistConstraintDoubleData" 'classname))

(cl:export '#.(bullet-wrap::swig-lispify "m_typeConstraintData" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_rbAFrame" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_rbBFrame" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_swingSpan1" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_swingSpan2" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_twistSpan" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_limitSoftness" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_biasFactor" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_relaxationFactor" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_damping" 'slotname))

(cffi:defcstruct #.(bullet-wrap::swig-lispify "btConeTwistConstraintData" 'classname)
	(#.(bullet-wrap::swig-lispify "m_typeConstraintData" 'slotname) #.(bullet-wrap::swig-lispify "btTypedConstraintData" 'classname))
	(#.(bullet-wrap::swig-lispify "m_rbAFrame" 'slotname) #.(bullet-wrap::swig-lispify "btTransformFloatData" 'classname))
	(#.(bullet-wrap::swig-lispify "m_rbBFrame" 'slotname) #.(bullet-wrap::swig-lispify "btTransformFloatData" 'classname))
	(#.(bullet-wrap::swig-lispify "m_swingSpan1" 'slotname) :float)
	(#.(bullet-wrap::swig-lispify "m_swingSpan2" 'slotname) :float)
	(#.(bullet-wrap::swig-lispify "m_twistSpan" 'slotname) :float)
	(#.(bullet-wrap::swig-lispify "m_limitSoftness" 'slotname) :float)
	(#.(bullet-wrap::swig-lispify "m_biasFactor" 'slotname) :float)
	(#.(bullet-wrap::swig-lispify "m_relaxationFactor" 'slotname) :float)
	(#.(bullet-wrap::swig-lispify "m_damping" 'slotname) :float)
	(#.(bullet-wrap::swig-lispify "m_pad" 'slotname) :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btConeTwistConstraintData" 'classname))

(cl:export '#.(bullet-wrap::swig-lispify "m_typeConstraintData" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_rbAFrame" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_rbBFrame" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_swingSpan1" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_swingSpan2" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_twistSpan" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_limitSoftness" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_biasFactor" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_relaxationFactor" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_damping" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_pad" 'slotname))

(cl:defconstant #.(bullet-wrap::swig-lispify "btGeneric6DofConstraintDataName" 'constant) "btGeneric6DofConstraintData")

(cl:export '#.(bullet-wrap::swig-lispify "btGeneric6DofConstraintDataName" 'constant))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btRotationalLimitMotor_m_loLimit_set" 'function)))

(cffi:defcfun ("_wrap_btRotationalLimitMotor_m_loLimit_set" #.(bullet-wrap::swig-lispify "btRotationalLimitMotor_m_loLimit_set" 'function)) :void
  (self :pointer)
  (m_loLimit :float))

(cl:export '#.(bullet-wrap::swig-lispify "btRotationalLimitMotor_m_loLimit_set" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btRotationalLimitMotor_m_loLimit_get" 'function)))

(cffi:defcfun ("_wrap_btRotationalLimitMotor_m_loLimit_get" #.(bullet-wrap::swig-lispify "btRotationalLimitMotor_m_loLimit_get" 'function)) :float
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btRotationalLimitMotor_m_loLimit_get" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btRotationalLimitMotor_m_hiLimit_set" 'function)))

(cffi:defcfun ("_wrap_btRotationalLimitMotor_m_hiLimit_set" #.(bullet-wrap::swig-lispify "btRotationalLimitMotor_m_hiLimit_set" 'function)) :void
  (self :pointer)
  (m_hiLimit :float))

(cl:export '#.(bullet-wrap::swig-lispify "btRotationalLimitMotor_m_hiLimit_set" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btRotationalLimitMotor_m_hiLimit_get" 'function)))

(cffi:defcfun ("_wrap_btRotationalLimitMotor_m_hiLimit_get" #.(bullet-wrap::swig-lispify "btRotationalLimitMotor_m_hiLimit_get" 'function)) :float
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btRotationalLimitMotor_m_hiLimit_get" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btRotationalLimitMotor_m_targetVelocity_set" 'function)))

(cffi:defcfun ("_wrap_btRotationalLimitMotor_m_targetVelocity_set" #.(bullet-wrap::swig-lispify "btRotationalLimitMotor_m_targetVelocity_set" 'function)) :void
  (self :pointer)
  (m_targetVelocity :float))

(cl:export '#.(bullet-wrap::swig-lispify "btRotationalLimitMotor_m_targetVelocity_set" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btRotationalLimitMotor_m_targetVelocity_get" 'function)))

(cffi:defcfun ("_wrap_btRotationalLimitMotor_m_targetVelocity_get" #.(bullet-wrap::swig-lispify "btRotationalLimitMotor_m_targetVelocity_get" 'function)) :float
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btRotationalLimitMotor_m_targetVelocity_get" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btRotationalLimitMotor_m_maxMotorForce_set" 'function)))

(cffi:defcfun ("_wrap_btRotationalLimitMotor_m_maxMotorForce_set" #.(bullet-wrap::swig-lispify "btRotationalLimitMotor_m_maxMotorForce_set" 'function)) :void
  (self :pointer)
  (m_maxMotorForce :float))

(cl:export '#.(bullet-wrap::swig-lispify "btRotationalLimitMotor_m_maxMotorForce_set" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btRotationalLimitMotor_m_maxMotorForce_get" 'function)))

(cffi:defcfun ("_wrap_btRotationalLimitMotor_m_maxMotorForce_get" #.(bullet-wrap::swig-lispify "btRotationalLimitMotor_m_maxMotorForce_get" 'function)) :float
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btRotationalLimitMotor_m_maxMotorForce_get" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btRotationalLimitMotor_m_maxLimitForce_set" 'function)))

(cffi:defcfun ("_wrap_btRotationalLimitMotor_m_maxLimitForce_set" #.(bullet-wrap::swig-lispify "btRotationalLimitMotor_m_maxLimitForce_set" 'function)) :void
  (self :pointer)
  (m_maxLimitForce :float))

(cl:export '#.(bullet-wrap::swig-lispify "btRotationalLimitMotor_m_maxLimitForce_set" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btRotationalLimitMotor_m_maxLimitForce_get" 'function)))

(cffi:defcfun ("_wrap_btRotationalLimitMotor_m_maxLimitForce_get" #.(bullet-wrap::swig-lispify "btRotationalLimitMotor_m_maxLimitForce_get" 'function)) :float
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btRotationalLimitMotor_m_maxLimitForce_get" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btRotationalLimitMotor_m_damping_set" 'function)))

(cffi:defcfun ("_wrap_btRotationalLimitMotor_m_damping_set" #.(bullet-wrap::swig-lispify "btRotationalLimitMotor_m_damping_set" 'function)) :void
  (self :pointer)
  (m_damping :float))

(cl:export '#.(bullet-wrap::swig-lispify "btRotationalLimitMotor_m_damping_set" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btRotationalLimitMotor_m_damping_get" 'function)))

(cffi:defcfun ("_wrap_btRotationalLimitMotor_m_damping_get" #.(bullet-wrap::swig-lispify "btRotationalLimitMotor_m_damping_get" 'function)) :float
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btRotationalLimitMotor_m_damping_get" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btRotationalLimitMotor_m_limitSoftness_set" 'function)))

(cffi:defcfun ("_wrap_btRotationalLimitMotor_m_limitSoftness_set" #.(bullet-wrap::swig-lispify "btRotationalLimitMotor_m_limitSoftness_set" 'function)) :void
  (self :pointer)
  (m_limitSoftness :float))

(cl:export '#.(bullet-wrap::swig-lispify "btRotationalLimitMotor_m_limitSoftness_set" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btRotationalLimitMotor_m_limitSoftness_get" 'function)))

(cffi:defcfun ("_wrap_btRotationalLimitMotor_m_limitSoftness_get" #.(bullet-wrap::swig-lispify "btRotationalLimitMotor_m_limitSoftness_get" 'function)) :float
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btRotationalLimitMotor_m_limitSoftness_get" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btRotationalLimitMotor_m_normalCFM_set" 'function)))

(cffi:defcfun ("_wrap_btRotationalLimitMotor_m_normalCFM_set" #.(bullet-wrap::swig-lispify "btRotationalLimitMotor_m_normalCFM_set" 'function)) :void
  (self :pointer)
  (m_normalCFM :float))

(cl:export '#.(bullet-wrap::swig-lispify "btRotationalLimitMotor_m_normalCFM_set" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btRotationalLimitMotor_m_normalCFM_get" 'function)))

(cffi:defcfun ("_wrap_btRotationalLimitMotor_m_normalCFM_get" #.(bullet-wrap::swig-lispify "btRotationalLimitMotor_m_normalCFM_get" 'function)) :float
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btRotationalLimitMotor_m_normalCFM_get" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btRotationalLimitMotor_m_stopERP_set" 'function)))

(cffi:defcfun ("_wrap_btRotationalLimitMotor_m_stopERP_set" #.(bullet-wrap::swig-lispify "btRotationalLimitMotor_m_stopERP_set" 'function)) :void
  (self :pointer)
  (m_stopERP :float))

(cl:export '#.(bullet-wrap::swig-lispify "btRotationalLimitMotor_m_stopERP_set" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btRotationalLimitMotor_m_stopERP_get" 'function)))

(cffi:defcfun ("_wrap_btRotationalLimitMotor_m_stopERP_get" #.(bullet-wrap::swig-lispify "btRotationalLimitMotor_m_stopERP_get" 'function)) :float
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btRotationalLimitMotor_m_stopERP_get" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btRotationalLimitMotor_m_stopCFM_set" 'function)))

(cffi:defcfun ("_wrap_btRotationalLimitMotor_m_stopCFM_set" #.(bullet-wrap::swig-lispify "btRotationalLimitMotor_m_stopCFM_set" 'function)) :void
  (self :pointer)
  (m_stopCFM :float))

(cl:export '#.(bullet-wrap::swig-lispify "btRotationalLimitMotor_m_stopCFM_set" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btRotationalLimitMotor_m_stopCFM_get" 'function)))

(cffi:defcfun ("_wrap_btRotationalLimitMotor_m_stopCFM_get" #.(bullet-wrap::swig-lispify "btRotationalLimitMotor_m_stopCFM_get" 'function)) :float
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btRotationalLimitMotor_m_stopCFM_get" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btRotationalLimitMotor_m_bounce_set" 'function)))

(cffi:defcfun ("_wrap_btRotationalLimitMotor_m_bounce_set" #.(bullet-wrap::swig-lispify "btRotationalLimitMotor_m_bounce_set" 'function)) :void
  (self :pointer)
  (m_bounce :float))

(cl:export '#.(bullet-wrap::swig-lispify "btRotationalLimitMotor_m_bounce_set" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btRotationalLimitMotor_m_bounce_get" 'function)))

(cffi:defcfun ("_wrap_btRotationalLimitMotor_m_bounce_get" #.(bullet-wrap::swig-lispify "btRotationalLimitMotor_m_bounce_get" 'function)) :float
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btRotationalLimitMotor_m_bounce_get" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btRotationalLimitMotor_m_enableMotor_set" 'function)))

(cffi:defcfun ("_wrap_btRotationalLimitMotor_m_enableMotor_set" #.(bullet-wrap::swig-lispify "btRotationalLimitMotor_m_enableMotor_set" 'function)) :void
  (self :pointer)
  (m_enableMotor :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btRotationalLimitMotor_m_enableMotor_set" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btRotationalLimitMotor_m_enableMotor_get" 'function)))

(cffi:defcfun ("_wrap_btRotationalLimitMotor_m_enableMotor_get" #.(bullet-wrap::swig-lispify "btRotationalLimitMotor_m_enableMotor_get" 'function)) :pointer
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btRotationalLimitMotor_m_enableMotor_get" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btRotationalLimitMotor_m_currentLimitError_set" 'function)))

(cffi:defcfun ("_wrap_btRotationalLimitMotor_m_currentLimitError_set" #.(bullet-wrap::swig-lispify "btRotationalLimitMotor_m_currentLimitError_set" 'function)) :void
  (self :pointer)
  (m_currentLimitError :float))

(cl:export '#.(bullet-wrap::swig-lispify "btRotationalLimitMotor_m_currentLimitError_set" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btRotationalLimitMotor_m_currentLimitError_get" 'function)))

(cffi:defcfun ("_wrap_btRotationalLimitMotor_m_currentLimitError_get" #.(bullet-wrap::swig-lispify "btRotationalLimitMotor_m_currentLimitError_get" 'function)) :float
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btRotationalLimitMotor_m_currentLimitError_get" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btRotationalLimitMotor_m_currentPosition_set" 'function)))

(cffi:defcfun ("_wrap_btRotationalLimitMotor_m_currentPosition_set" #.(bullet-wrap::swig-lispify "btRotationalLimitMotor_m_currentPosition_set" 'function)) :void
  (self :pointer)
  (m_currentPosition :float))

(cl:export '#.(bullet-wrap::swig-lispify "btRotationalLimitMotor_m_currentPosition_set" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btRotationalLimitMotor_m_currentPosition_get" 'function)))

(cffi:defcfun ("_wrap_btRotationalLimitMotor_m_currentPosition_get" #.(bullet-wrap::swig-lispify "btRotationalLimitMotor_m_currentPosition_get" 'function)) :float
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btRotationalLimitMotor_m_currentPosition_get" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btRotationalLimitMotor_m_currentLimit_set" 'function)))

(cffi:defcfun ("_wrap_btRotationalLimitMotor_m_currentLimit_set" #.(bullet-wrap::swig-lispify "btRotationalLimitMotor_m_currentLimit_set" 'function)) :void
  (self :pointer)
  (m_currentLimit :int))

(cl:export '#.(bullet-wrap::swig-lispify "btRotationalLimitMotor_m_currentLimit_set" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btRotationalLimitMotor_m_currentLimit_get" 'function)))

(cffi:defcfun ("_wrap_btRotationalLimitMotor_m_currentLimit_get" #.(bullet-wrap::swig-lispify "btRotationalLimitMotor_m_currentLimit_get" 'function)) :int
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btRotationalLimitMotor_m_currentLimit_get" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btRotationalLimitMotor_m_accumulatedImpulse_set" 'function)))

(cffi:defcfun ("_wrap_btRotationalLimitMotor_m_accumulatedImpulse_set" #.(bullet-wrap::swig-lispify "btRotationalLimitMotor_m_accumulatedImpulse_set" 'function)) :void
  (self :pointer)
  (m_accumulatedImpulse :float))

(cl:export '#.(bullet-wrap::swig-lispify "btRotationalLimitMotor_m_accumulatedImpulse_set" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btRotationalLimitMotor_m_accumulatedImpulse_get" 'function)))

(cffi:defcfun ("_wrap_btRotationalLimitMotor_m_accumulatedImpulse_get" #.(bullet-wrap::swig-lispify "btRotationalLimitMotor_m_accumulatedImpulse_get" 'function)) :float
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btRotationalLimitMotor_m_accumulatedImpulse_get" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "new_btRotationalLimitMotor" 'function)))

(cffi:defcfun ("_wrap_new_btRotationalLimitMotor__SWIG_0" #.(bullet-wrap::swig-lispify "new_btRotationalLimitMotor" 'function)) :pointer)

(cl:export '#.(bullet-wrap::swig-lispify "new_btRotationalLimitMotor" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "new_btRotationalLimitMotor" 'function)))

(cffi:defcfun ("_wrap_new_btRotationalLimitMotor__SWIG_1" #.(bullet-wrap::swig-lispify "new_btRotationalLimitMotor" 'function)) :pointer
  (limot :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "new_btRotationalLimitMotor" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btRotationalLimitMotor_isLimited" 'function)))

(cffi:defcfun ("_wrap_btRotationalLimitMotor_isLimited" #.(bullet-wrap::swig-lispify "btRotationalLimitMotor_isLimited" 'function)) :pointer
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btRotationalLimitMotor_isLimited" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btRotationalLimitMotor_needApplyTorques" 'function)))

(cffi:defcfun ("_wrap_btRotationalLimitMotor_needApplyTorques" #.(bullet-wrap::swig-lispify "btRotationalLimitMotor_needApplyTorques" 'function)) :pointer
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btRotationalLimitMotor_needApplyTorques" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btRotationalLimitMotor_testLimitValue" 'function)))

(cffi:defcfun ("_wrap_btRotationalLimitMotor_testLimitValue" #.(bullet-wrap::swig-lispify "btRotationalLimitMotor_testLimitValue" 'function)) :int
  (self :pointer)
  (test_value :float))

(cl:export '#.(bullet-wrap::swig-lispify "btRotationalLimitMotor_testLimitValue" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btRotationalLimitMotor_solveAngularLimits" 'function)))

(cffi:defcfun ("_wrap_btRotationalLimitMotor_solveAngularLimits" #.(bullet-wrap::swig-lispify "btRotationalLimitMotor_solveAngularLimits" 'function)) :float
  (self :pointer)
  (timeStep :float)
  (axis :pointer)
  (jacDiagABInv :float)
  (body0 :pointer)
  (body1 :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btRotationalLimitMotor_solveAngularLimits" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "delete_btRotationalLimitMotor" 'function)))

(cffi:defcfun ("_wrap_delete_btRotationalLimitMotor" #.(bullet-wrap::swig-lispify "delete_btRotationalLimitMotor" 'function)) :void
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "delete_btRotationalLimitMotor" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btTranslationalLimitMotor_m_lowerLimit_set" 'function)))

(cffi:defcfun ("_wrap_btTranslationalLimitMotor_m_lowerLimit_set" #.(bullet-wrap::swig-lispify "btTranslationalLimitMotor_m_lowerLimit_set" 'function)) :void
  (self :pointer)
  (m_lowerLimit :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btTranslationalLimitMotor_m_lowerLimit_set" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btTranslationalLimitMotor_m_lowerLimit_get" 'function)))

(cffi:defcfun ("_wrap_btTranslationalLimitMotor_m_lowerLimit_get" #.(bullet-wrap::swig-lispify "btTranslationalLimitMotor_m_lowerLimit_get" 'function)) :pointer
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btTranslationalLimitMotor_m_lowerLimit_get" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btTranslationalLimitMotor_m_upperLimit_set" 'function)))

(cffi:defcfun ("_wrap_btTranslationalLimitMotor_m_upperLimit_set" #.(bullet-wrap::swig-lispify "btTranslationalLimitMotor_m_upperLimit_set" 'function)) :void
  (self :pointer)
  (m_upperLimit :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btTranslationalLimitMotor_m_upperLimit_set" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btTranslationalLimitMotor_m_upperLimit_get" 'function)))

(cffi:defcfun ("_wrap_btTranslationalLimitMotor_m_upperLimit_get" #.(bullet-wrap::swig-lispify "btTranslationalLimitMotor_m_upperLimit_get" 'function)) :pointer
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btTranslationalLimitMotor_m_upperLimit_get" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btTranslationalLimitMotor_m_accumulatedImpulse_set" 'function)))

(cffi:defcfun ("_wrap_btTranslationalLimitMotor_m_accumulatedImpulse_set" #.(bullet-wrap::swig-lispify "btTranslationalLimitMotor_m_accumulatedImpulse_set" 'function)) :void
  (self :pointer)
  (m_accumulatedImpulse :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btTranslationalLimitMotor_m_accumulatedImpulse_set" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btTranslationalLimitMotor_m_accumulatedImpulse_get" 'function)))

(cffi:defcfun ("_wrap_btTranslationalLimitMotor_m_accumulatedImpulse_get" #.(bullet-wrap::swig-lispify "btTranslationalLimitMotor_m_accumulatedImpulse_get" 'function)) :pointer
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btTranslationalLimitMotor_m_accumulatedImpulse_get" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btTranslationalLimitMotor_m_limitSoftness_set" 'function)))

(cffi:defcfun ("_wrap_btTranslationalLimitMotor_m_limitSoftness_set" #.(bullet-wrap::swig-lispify "btTranslationalLimitMotor_m_limitSoftness_set" 'function)) :void
  (self :pointer)
  (m_limitSoftness :float))

(cl:export '#.(bullet-wrap::swig-lispify "btTranslationalLimitMotor_m_limitSoftness_set" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btTranslationalLimitMotor_m_limitSoftness_get" 'function)))

(cffi:defcfun ("_wrap_btTranslationalLimitMotor_m_limitSoftness_get" #.(bullet-wrap::swig-lispify "btTranslationalLimitMotor_m_limitSoftness_get" 'function)) :float
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btTranslationalLimitMotor_m_limitSoftness_get" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btTranslationalLimitMotor_m_damping_set" 'function)))

(cffi:defcfun ("_wrap_btTranslationalLimitMotor_m_damping_set" #.(bullet-wrap::swig-lispify "btTranslationalLimitMotor_m_damping_set" 'function)) :void
  (self :pointer)
  (m_damping :float))

(cl:export '#.(bullet-wrap::swig-lispify "btTranslationalLimitMotor_m_damping_set" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btTranslationalLimitMotor_m_damping_get" 'function)))

(cffi:defcfun ("_wrap_btTranslationalLimitMotor_m_damping_get" #.(bullet-wrap::swig-lispify "btTranslationalLimitMotor_m_damping_get" 'function)) :float
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btTranslationalLimitMotor_m_damping_get" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btTranslationalLimitMotor_m_restitution_set" 'function)))

(cffi:defcfun ("_wrap_btTranslationalLimitMotor_m_restitution_set" #.(bullet-wrap::swig-lispify "btTranslationalLimitMotor_m_restitution_set" 'function)) :void
  (self :pointer)
  (m_restitution :float))

(cl:export '#.(bullet-wrap::swig-lispify "btTranslationalLimitMotor_m_restitution_set" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btTranslationalLimitMotor_m_restitution_get" 'function)))

(cffi:defcfun ("_wrap_btTranslationalLimitMotor_m_restitution_get" #.(bullet-wrap::swig-lispify "btTranslationalLimitMotor_m_restitution_get" 'function)) :float
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btTranslationalLimitMotor_m_restitution_get" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btTranslationalLimitMotor_m_normalCFM_set" 'function)))

(cffi:defcfun ("_wrap_btTranslationalLimitMotor_m_normalCFM_set" #.(bullet-wrap::swig-lispify "btTranslationalLimitMotor_m_normalCFM_set" 'function)) :void
  (self :pointer)
  (m_normalCFM :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btTranslationalLimitMotor_m_normalCFM_set" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btTranslationalLimitMotor_m_normalCFM_get" 'function)))

(cffi:defcfun ("_wrap_btTranslationalLimitMotor_m_normalCFM_get" #.(bullet-wrap::swig-lispify "btTranslationalLimitMotor_m_normalCFM_get" 'function)) :pointer
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btTranslationalLimitMotor_m_normalCFM_get" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btTranslationalLimitMotor_m_stopERP_set" 'function)))

(cffi:defcfun ("_wrap_btTranslationalLimitMotor_m_stopERP_set" #.(bullet-wrap::swig-lispify "btTranslationalLimitMotor_m_stopERP_set" 'function)) :void
  (self :pointer)
  (m_stopERP :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btTranslationalLimitMotor_m_stopERP_set" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btTranslationalLimitMotor_m_stopERP_get" 'function)))

(cffi:defcfun ("_wrap_btTranslationalLimitMotor_m_stopERP_get" #.(bullet-wrap::swig-lispify "btTranslationalLimitMotor_m_stopERP_get" 'function)) :pointer
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btTranslationalLimitMotor_m_stopERP_get" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btTranslationalLimitMotor_m_stopCFM_set" 'function)))

(cffi:defcfun ("_wrap_btTranslationalLimitMotor_m_stopCFM_set" #.(bullet-wrap::swig-lispify "btTranslationalLimitMotor_m_stopCFM_set" 'function)) :void
  (self :pointer)
  (m_stopCFM :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btTranslationalLimitMotor_m_stopCFM_set" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btTranslationalLimitMotor_m_stopCFM_get" 'function)))

(cffi:defcfun ("_wrap_btTranslationalLimitMotor_m_stopCFM_get" #.(bullet-wrap::swig-lispify "btTranslationalLimitMotor_m_stopCFM_get" 'function)) :pointer
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btTranslationalLimitMotor_m_stopCFM_get" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btTranslationalLimitMotor_m_enableMotor_set" 'function)))

(cffi:defcfun ("_wrap_btTranslationalLimitMotor_m_enableMotor_set" #.(bullet-wrap::swig-lispify "btTranslationalLimitMotor_m_enableMotor_set" 'function)) :void
  (self :pointer)
  (m_enableMotor :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btTranslationalLimitMotor_m_enableMotor_set" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btTranslationalLimitMotor_m_enableMotor_get" 'function)))

(cffi:defcfun ("_wrap_btTranslationalLimitMotor_m_enableMotor_get" #.(bullet-wrap::swig-lispify "btTranslationalLimitMotor_m_enableMotor_get" 'function)) :pointer
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btTranslationalLimitMotor_m_enableMotor_get" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btTranslationalLimitMotor_m_targetVelocity_set" 'function)))

(cffi:defcfun ("_wrap_btTranslationalLimitMotor_m_targetVelocity_set" #.(bullet-wrap::swig-lispify "btTranslationalLimitMotor_m_targetVelocity_set" 'function)) :void
  (self :pointer)
  (m_targetVelocity :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btTranslationalLimitMotor_m_targetVelocity_set" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btTranslationalLimitMotor_m_targetVelocity_get" 'function)))

(cffi:defcfun ("_wrap_btTranslationalLimitMotor_m_targetVelocity_get" #.(bullet-wrap::swig-lispify "btTranslationalLimitMotor_m_targetVelocity_get" 'function)) :pointer
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btTranslationalLimitMotor_m_targetVelocity_get" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btTranslationalLimitMotor_m_maxMotorForce_set" 'function)))

(cffi:defcfun ("_wrap_btTranslationalLimitMotor_m_maxMotorForce_set" #.(bullet-wrap::swig-lispify "btTranslationalLimitMotor_m_maxMotorForce_set" 'function)) :void
  (self :pointer)
  (m_maxMotorForce :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btTranslationalLimitMotor_m_maxMotorForce_set" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btTranslationalLimitMotor_m_maxMotorForce_get" 'function)))

(cffi:defcfun ("_wrap_btTranslationalLimitMotor_m_maxMotorForce_get" #.(bullet-wrap::swig-lispify "btTranslationalLimitMotor_m_maxMotorForce_get" 'function)) :pointer
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btTranslationalLimitMotor_m_maxMotorForce_get" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btTranslationalLimitMotor_m_currentLimitError_set" 'function)))

(cffi:defcfun ("_wrap_btTranslationalLimitMotor_m_currentLimitError_set" #.(bullet-wrap::swig-lispify "btTranslationalLimitMotor_m_currentLimitError_set" 'function)) :void
  (self :pointer)
  (m_currentLimitError :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btTranslationalLimitMotor_m_currentLimitError_set" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btTranslationalLimitMotor_m_currentLimitError_get" 'function)))

(cffi:defcfun ("_wrap_btTranslationalLimitMotor_m_currentLimitError_get" #.(bullet-wrap::swig-lispify "btTranslationalLimitMotor_m_currentLimitError_get" 'function)) :pointer
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btTranslationalLimitMotor_m_currentLimitError_get" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btTranslationalLimitMotor_m_currentLinearDiff_set" 'function)))

(cffi:defcfun ("_wrap_btTranslationalLimitMotor_m_currentLinearDiff_set" #.(bullet-wrap::swig-lispify "btTranslationalLimitMotor_m_currentLinearDiff_set" 'function)) :void
  (self :pointer)
  (m_currentLinearDiff :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btTranslationalLimitMotor_m_currentLinearDiff_set" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btTranslationalLimitMotor_m_currentLinearDiff_get" 'function)))

(cffi:defcfun ("_wrap_btTranslationalLimitMotor_m_currentLinearDiff_get" #.(bullet-wrap::swig-lispify "btTranslationalLimitMotor_m_currentLinearDiff_get" 'function)) :pointer
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btTranslationalLimitMotor_m_currentLinearDiff_get" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btTranslationalLimitMotor_m_currentLimit_set" 'function)))

(cffi:defcfun ("_wrap_btTranslationalLimitMotor_m_currentLimit_set" #.(bullet-wrap::swig-lispify "btTranslationalLimitMotor_m_currentLimit_set" 'function)) :void
  (self :pointer)
  (m_currentLimit :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btTranslationalLimitMotor_m_currentLimit_set" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btTranslationalLimitMotor_m_currentLimit_get" 'function)))

(cffi:defcfun ("_wrap_btTranslationalLimitMotor_m_currentLimit_get" #.(bullet-wrap::swig-lispify "btTranslationalLimitMotor_m_currentLimit_get" 'function)) :pointer
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btTranslationalLimitMotor_m_currentLimit_get" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "new_btTranslationalLimitMotor" 'function)))

(cffi:defcfun ("_wrap_new_btTranslationalLimitMotor__SWIG_0" #.(bullet-wrap::swig-lispify "new_btTranslationalLimitMotor" 'function)) :pointer)

(cl:export '#.(bullet-wrap::swig-lispify "new_btTranslationalLimitMotor" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "new_btTranslationalLimitMotor" 'function)))

(cffi:defcfun ("_wrap_new_btTranslationalLimitMotor__SWIG_1" #.(bullet-wrap::swig-lispify "new_btTranslationalLimitMotor" 'function)) :pointer
  (other :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "new_btTranslationalLimitMotor" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btTranslationalLimitMotor_isLimited" 'function)))

(cffi:defcfun ("_wrap_btTranslationalLimitMotor_isLimited" #.(bullet-wrap::swig-lispify "btTranslationalLimitMotor_isLimited" 'function)) :pointer
  (self :pointer)
  (limitIndex :int))

(cl:export '#.(bullet-wrap::swig-lispify "btTranslationalLimitMotor_isLimited" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btTranslationalLimitMotor_needApplyForce" 'function)))

(cffi:defcfun ("_wrap_btTranslationalLimitMotor_needApplyForce" #.(bullet-wrap::swig-lispify "btTranslationalLimitMotor_needApplyForce" 'function)) :pointer
  (self :pointer)
  (limitIndex :int))

(cl:export '#.(bullet-wrap::swig-lispify "btTranslationalLimitMotor_needApplyForce" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btTranslationalLimitMotor_testLimitValue" 'function)))

(cffi:defcfun ("_wrap_btTranslationalLimitMotor_testLimitValue" #.(bullet-wrap::swig-lispify "btTranslationalLimitMotor_testLimitValue" 'function)) :int
  (self :pointer)
  (limitIndex :int)
  (test_value :float))

(cl:export '#.(bullet-wrap::swig-lispify "btTranslationalLimitMotor_testLimitValue" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btTranslationalLimitMotor_solveLinearAxis" 'function)))

(cffi:defcfun ("_wrap_btTranslationalLimitMotor_solveLinearAxis" #.(bullet-wrap::swig-lispify "btTranslationalLimitMotor_solveLinearAxis" 'function)) :float
  (self :pointer)
  (timeStep :float)
  (jacDiagABInv :float)
  (body1 :pointer)
  (pointInA :pointer)
  (body2 :pointer)
  (pointInB :pointer)
  (limit_index :int)
  (axis_normal_on_a :pointer)
  (anchorPos :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btTranslationalLimitMotor_solveLinearAxis" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "delete_btTranslationalLimitMotor" 'function)))

(cffi:defcfun ("_wrap_delete_btTranslationalLimitMotor" #.(bullet-wrap::swig-lispify "delete_btTranslationalLimitMotor" 'function)) :void
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "delete_btTranslationalLimitMotor" 'function))

(cffi:defcenum #.(bullet-wrap::swig-lispify "bt6DofFlags" 'enumname)
	(#.(bullet-wrap::swig-lispify "BT_6DOF_FLAGS_CFM_NORM" 'enumvalue :keyword) #.1)
	(#.(bullet-wrap::swig-lispify "BT_6DOF_FLAGS_CFM_STOP" 'enumvalue :keyword) #.2)
	(#.(bullet-wrap::swig-lispify "BT_6DOF_FLAGS_ERP_STOP" 'enumvalue :keyword) #.4))

(cl:export '#.(bullet-wrap::swig-lispify "bt6DofFlags" 'enumname))

(cl:defconstant #.(bullet-wrap::swig-lispify "BT_6DOF_FLAGS_AXIS_SHIFT" 'constant) 3)

(cl:export '#.(bullet-wrap::swig-lispify "BT_6DOF_FLAGS_AXIS_SHIFT" 'constant))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btGeneric6DofConstraint_makeCPlusPlusInstance" 'function)))

(cffi:defcfun ("_wrap_btGeneric6DofConstraint_makeCPlusPlusInstance__SWIG_0" #.(bullet-wrap::swig-lispify "btGeneric6DofConstraint_makeCPlusPlusInstance" 'function)) :pointer
  (self :pointer)
  (sizeInBytes :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btGeneric6DofConstraint_makeCPlusPlusInstance" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btGeneric6DofConstraint_deleteCPlusPlusInstance" 'function)))

(cffi:defcfun ("_wrap_btGeneric6DofConstraint_deleteCPlusPlusInstance__SWIG_0" #.(bullet-wrap::swig-lispify "btGeneric6DofConstraint_deleteCPlusPlusInstance" 'function)) :void
  (self :pointer)
  (ptr :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btGeneric6DofConstraint_deleteCPlusPlusInstance" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btGeneric6DofConstraint_makeCPlusPlusInstance" 'function)))

(cffi:defcfun ("_wrap_btGeneric6DofConstraint_makeCPlusPlusInstance__SWIG_1" #.(bullet-wrap::swig-lispify "btGeneric6DofConstraint_makeCPlusPlusInstance" 'function)) :pointer
  (self :pointer)
  (arg1 :pointer)
  (ptr :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btGeneric6DofConstraint_makeCPlusPlusInstance" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btGeneric6DofConstraint_deleteCPlusPlusInstance" 'function)))

(cffi:defcfun ("_wrap_btGeneric6DofConstraint_deleteCPlusPlusInstance__SWIG_1" #.(bullet-wrap::swig-lispify "btGeneric6DofConstraint_deleteCPlusPlusInstance" 'function)) :void
  (self :pointer)
  (arg1 :pointer)
  (arg2 :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btGeneric6DofConstraint_deleteCPlusPlusInstance" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btGeneric6DofConstraint_makeCPlusArray" 'function)))

(cffi:defcfun ("_wrap_btGeneric6DofConstraint_makeCPlusArray__SWIG_0" #.(bullet-wrap::swig-lispify "btGeneric6DofConstraint_makeCPlusArray" 'function)) :pointer
  (self :pointer)
  (sizeInBytes :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btGeneric6DofConstraint_makeCPlusArray" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btGeneric6DofConstraint_deleteCPlusArray" 'function)))

(cffi:defcfun ("_wrap_btGeneric6DofConstraint_deleteCPlusArray__SWIG_0" #.(bullet-wrap::swig-lispify "btGeneric6DofConstraint_deleteCPlusArray" 'function)) :void
  (self :pointer)
  (ptr :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btGeneric6DofConstraint_deleteCPlusArray" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btGeneric6DofConstraint_makeCPlusArray" 'function)))

(cffi:defcfun ("_wrap_btGeneric6DofConstraint_makeCPlusArray__SWIG_1" #.(bullet-wrap::swig-lispify "btGeneric6DofConstraint_makeCPlusArray" 'function)) :pointer
  (self :pointer)
  (arg1 :pointer)
  (ptr :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btGeneric6DofConstraint_makeCPlusArray" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btGeneric6DofConstraint_deleteCPlusArray" 'function)))

(cffi:defcfun ("_wrap_btGeneric6DofConstraint_deleteCPlusArray__SWIG_1" #.(bullet-wrap::swig-lispify "btGeneric6DofConstraint_deleteCPlusArray" 'function)) :void
  (self :pointer)
  (arg1 :pointer)
  (arg2 :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btGeneric6DofConstraint_deleteCPlusArray" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btGeneric6DofConstraint_m_useSolveConstraintObsolete_set" 'function)))

(cffi:defcfun ("_wrap_btGeneric6DofConstraint_m_useSolveConstraintObsolete_set" #.(bullet-wrap::swig-lispify "btGeneric6DofConstraint_m_useSolveConstraintObsolete_set" 'function)) :void
  (self :pointer)
  (m_useSolveConstraintObsolete :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btGeneric6DofConstraint_m_useSolveConstraintObsolete_set" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btGeneric6DofConstraint_m_useSolveConstraintObsolete_get" 'function)))

(cffi:defcfun ("_wrap_btGeneric6DofConstraint_m_useSolveConstraintObsolete_get" #.(bullet-wrap::swig-lispify "btGeneric6DofConstraint_m_useSolveConstraintObsolete_get" 'function)) :pointer
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btGeneric6DofConstraint_m_useSolveConstraintObsolete_get" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "new_btGeneric6DofConstraint" 'function)))

(cffi:defcfun ("_wrap_new_btGeneric6DofConstraint__SWIG_0" #.(bullet-wrap::swig-lispify "new_btGeneric6DofConstraint" 'function)) :pointer
  (rbA :pointer)
  (rbB :pointer)
  (frameInA :pointer)
  (frameInB :pointer)
  (useLinearReferenceFrameA :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "new_btGeneric6DofConstraint" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "new_btGeneric6DofConstraint" 'function)))

(cffi:defcfun ("_wrap_new_btGeneric6DofConstraint__SWIG_1" #.(bullet-wrap::swig-lispify "new_btGeneric6DofConstraint" 'function)) :pointer
  (rbB :pointer)
  (frameInB :pointer)
  (useLinearReferenceFrameB :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "new_btGeneric6DofConstraint" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btGeneric6DofConstraint_calculateTransforms" 'function)))

(cffi:defcfun ("_wrap_btGeneric6DofConstraint_calculateTransforms__SWIG_0" #.(bullet-wrap::swig-lispify "btGeneric6DofConstraint_calculateTransforms" 'function)) :void
  (self :pointer)
  (transA :pointer)
  (transB :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btGeneric6DofConstraint_calculateTransforms" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btGeneric6DofConstraint_calculateTransforms" 'function)))

(cffi:defcfun ("_wrap_btGeneric6DofConstraint_calculateTransforms__SWIG_1" #.(bullet-wrap::swig-lispify "btGeneric6DofConstraint_calculateTransforms" 'function)) :void
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btGeneric6DofConstraint_calculateTransforms" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btGeneric6DofConstraint_getCalculatedTransformA" 'function)))

(cffi:defcfun ("_wrap_btGeneric6DofConstraint_getCalculatedTransformA" #.(bullet-wrap::swig-lispify "btGeneric6DofConstraint_getCalculatedTransformA" 'function)) :pointer
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btGeneric6DofConstraint_getCalculatedTransformA" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btGeneric6DofConstraint_getCalculatedTransformB" 'function)))

(cffi:defcfun ("_wrap_btGeneric6DofConstraint_getCalculatedTransformB" #.(bullet-wrap::swig-lispify "btGeneric6DofConstraint_getCalculatedTransformB" 'function)) :pointer
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btGeneric6DofConstraint_getCalculatedTransformB" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btGeneric6DofConstraint_getFrameOffsetA" 'function)))

(cffi:defcfun ("_wrap_btGeneric6DofConstraint_getFrameOffsetA__SWIG_0" #.(bullet-wrap::swig-lispify "btGeneric6DofConstraint_getFrameOffsetA" 'function)) :pointer
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btGeneric6DofConstraint_getFrameOffsetA" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btGeneric6DofConstraint_getFrameOffsetB" 'function)))

(cffi:defcfun ("_wrap_btGeneric6DofConstraint_getFrameOffsetB__SWIG_0" #.(bullet-wrap::swig-lispify "btGeneric6DofConstraint_getFrameOffsetB" 'function)) :pointer
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btGeneric6DofConstraint_getFrameOffsetB" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btGeneric6DofConstraint_getFrameOffsetA" 'function)))

(cffi:defcfun ("_wrap_btGeneric6DofConstraint_getFrameOffsetA__SWIG_1" #.(bullet-wrap::swig-lispify "btGeneric6DofConstraint_getFrameOffsetA" 'function)) :pointer
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btGeneric6DofConstraint_getFrameOffsetA" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btGeneric6DofConstraint_getFrameOffsetB" 'function)))
(cffi:defcfun ("_wrap_btGeneric6DofConstraint_getFrameOffsetB__SWIG_1" #.(bullet-wrap::swig-lispify "btGeneric6DofConstraint_getFrameOffsetB" 'function)) :pointer
  (self :pointer))
(cl:export '#.(bullet-wrap::swig-lispify "btGeneric6DofConstraint_getFrameOffsetB" 'function))
(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btGeneric6DofConstraint_buildJacobian" 'function)))

(cffi:defcfun ("_wrap_btGeneric6DofConstraint_buildJacobian" #.(bullet-wrap::swig-lispify "btGeneric6DofConstraint_buildJacobian" 'function)) :void
(cl:export '#.(bullet-wrap::swig-lispify "btGeneric6DofConstraint_buildJacobian" 'function))
(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btGeneric6DofConstraint_getInfo1" 'function)))
(cffi:defcfun ("_wrap_btGeneric6DofConstraint_getInfo1" #.(bullet-wrap::swig-lispify "btGeneric6DofConstraint_getInfo1" 'function)) :void
  (info :pointer))
(cl:export '#.(bullet-wrap::swig-lispify "btGeneric6DofConstraint_getInfo1" 'function))
(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btGeneric6DofConstraint_getInfo1NonVirtual" 'function)))
(cffi:defcfun ("_wrap_btGeneric6DofConstraint_getInfo1NonVirtual" #.(bullet-wrap::swig-lispify "btGeneric6DofConstraint_getInfo1NonVirtual" 'function)) :void
  (self :pointer)
  (info :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btGeneric6DofConstraint_getInfo1NonVirtual" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btGeneric6DofConstraint_getInfo2" 'function)))

(cffi:defcfun ("_wrap_btGeneric6DofConstraint_getInfo2" #.(bullet-wrap::swig-lispify "btGeneric6DofConstraint_getInfo2" 'function)) :void
  (self :pointer)
  (info :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btGeneric6DofConstraint_getInfo2" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btGeneric6DofConstraint_getInfo2NonVirtual" 'function)))

(cffi:defcfun ("_wrap_btGeneric6DofConstraint_getInfo2NonVirtual" #.(bullet-wrap::swig-lispify "btGeneric6DofConstraint_getInfo2NonVirtual" 'function)) :void
  (self :pointer)
  (info :pointer)
  (transA :pointer)
  (transB :pointer)
  (linVelA :pointer)
  (linVelB :pointer)
  (angVelA :pointer)
  (angVelB :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btGeneric6DofConstraint_getInfo2NonVirtual" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btGeneric6DofConstraint_updateRHS" 'function)))

(cffi:defcfun ("_wrap_btGeneric6DofConstraint_updateRHS" #.(bullet-wrap::swig-lispify "btGeneric6DofConstraint_updateRHS" 'function)) :void
  (self :pointer)
  (timeStep :float))

(cl:export '#.(bullet-wrap::swig-lispify "btGeneric6DofConstraint_updateRHS" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btGeneric6DofConstraint_getAxis" 'function)))

(cffi:defcfun ("_wrap_btGeneric6DofConstraint_getAxis" #.(bullet-wrap::swig-lispify "btGeneric6DofConstraint_getAxis" 'function)) :pointer
  (self :pointer)
  (axis_index :int))

(cl:export '#.(bullet-wrap::swig-lispify "btGeneric6DofConstraint_getAxis" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btGeneric6DofConstraint_getAngle" 'function)))

(cffi:defcfun ("_wrap_btGeneric6DofConstraint_getAngle" #.(bullet-wrap::swig-lispify "btGeneric6DofConstraint_getAngle" 'function)) :float
  (self :pointer)
  (axis_index :int))

(cl:export '#.(bullet-wrap::swig-lispify "btGeneric6DofConstraint_getAngle" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btGeneric6DofConstraint_getRelativePivotPosition" 'function)))

(cffi:defcfun ("_wrap_btGeneric6DofConstraint_getRelativePivotPosition" #.(bullet-wrap::swig-lispify "btGeneric6DofConstraint_getRelativePivotPosition" 'function)) :float
  (self :pointer)
  (axis_index :int))

(cl:export '#.(bullet-wrap::swig-lispify "btGeneric6DofConstraint_getRelativePivotPosition" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btGeneric6DofConstraint_setFrames" 'function)))

(cffi:defcfun ("_wrap_btGeneric6DofConstraint_setFrames" #.(bullet-wrap::swig-lispify "btGeneric6DofConstraint_setFrames" 'function)) :void
  (self :pointer)
  (frameA :pointer)
  (frameB :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btGeneric6DofConstraint_setFrames" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btGeneric6DofConstraint_testAngularLimitMotor" 'function)))

(cffi:defcfun ("_wrap_btGeneric6DofConstraint_testAngularLimitMotor" #.(bullet-wrap::swig-lispify "btGeneric6DofConstraint_testAngularLimitMotor" 'function)) :pointer
  (self :pointer)
  (axis_index :int))

(cl:export '#.(bullet-wrap::swig-lispify "btGeneric6DofConstraint_testAngularLimitMotor" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btGeneric6DofConstraint_setLinearLowerLimit" 'function)))

(cffi:defcfun ("_wrap_btGeneric6DofConstraint_setLinearLowerLimit" #.(bullet-wrap::swig-lispify "btGeneric6DofConstraint_setLinearLowerLimit" 'function)) :void
  (self :pointer)
  (linearLower :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btGeneric6DofConstraint_setLinearLowerLimit" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btGeneric6DofConstraint_getLinearLowerLimit" 'function)))

(cffi:defcfun ("_wrap_btGeneric6DofConstraint_getLinearLowerLimit" #.(bullet-wrap::swig-lispify "btGeneric6DofConstraint_getLinearLowerLimit" 'function)) :void
  (self :pointer)
  (linearLower :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btGeneric6DofConstraint_getLinearLowerLimit" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btGeneric6DofConstraint_setLinearUpperLimit" 'function)))

(cffi:defcfun ("_wrap_btGeneric6DofConstraint_setLinearUpperLimit" #.(bullet-wrap::swig-lispify "btGeneric6DofConstraint_setLinearUpperLimit" 'function)) :void
  (self :pointer)
  (linearUpper :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btGeneric6DofConstraint_setLinearUpperLimit" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btGeneric6DofConstraint_getLinearUpperLimit" 'function)))

(cffi:defcfun ("_wrap_btGeneric6DofConstraint_getLinearUpperLimit" #.(bullet-wrap::swig-lispify "btGeneric6DofConstraint_getLinearUpperLimit" 'function)) :void
  (self :pointer)
  (linearUpper :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btGeneric6DofConstraint_getLinearUpperLimit" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btGeneric6DofConstraint_setAngularLowerLimit" 'function)))

(cffi:defcfun ("_wrap_btGeneric6DofConstraint_setAngularLowerLimit" #.(bullet-wrap::swig-lispify "btGeneric6DofConstraint_setAngularLowerLimit" 'function)) :void
  (self :pointer)
  (angularLower :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btGeneric6DofConstraint_setAngularLowerLimit" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btGeneric6DofConstraint_getAngularLowerLimit" 'function)))

(cffi:defcfun ("_wrap_btGeneric6DofConstraint_getAngularLowerLimit" #.(bullet-wrap::swig-lispify "btGeneric6DofConstraint_getAngularLowerLimit" 'function)) :void
  (self :pointer)
  (angularLower :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btGeneric6DofConstraint_getAngularLowerLimit" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btGeneric6DofConstraint_setAngularUpperLimit" 'function)))

(cffi:defcfun ("_wrap_btGeneric6DofConstraint_setAngularUpperLimit" #.(bullet-wrap::swig-lispify "btGeneric6DofConstraint_setAngularUpperLimit" 'function)) :void
  (self :pointer)
  (angularUpper :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btGeneric6DofConstraint_setAngularUpperLimit" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btGeneric6DofConstraint_getAngularUpperLimit" 'function)))

(cffi:defcfun ("_wrap_btGeneric6DofConstraint_getAngularUpperLimit" #.(bullet-wrap::swig-lispify "btGeneric6DofConstraint_getAngularUpperLimit" 'function)) :void
  (self :pointer)
  (angularUpper :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btGeneric6DofConstraint_getAngularUpperLimit" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btGeneric6DofConstraint_getRotationalLimitMotor" 'function)))

(cffi:defcfun ("_wrap_btGeneric6DofConstraint_getRotationalLimitMotor" #.(bullet-wrap::swig-lispify "btGeneric6DofConstraint_getRotationalLimitMotor" 'function)) :pointer
  (self :pointer)
  (index :int))

(cl:export '#.(bullet-wrap::swig-lispify "btGeneric6DofConstraint_getRotationalLimitMotor" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btGeneric6DofConstraint_getTranslationalLimitMotor" 'function)))

(cffi:defcfun ("_wrap_btGeneric6DofConstraint_getTranslationalLimitMotor" #.(bullet-wrap::swig-lispify "btGeneric6DofConstraint_getTranslationalLimitMotor" 'function)) :pointer
(cl:export '#.(bullet-wrap::swig-lispify "btGeneric6DofConstraint_getTranslationalLimitMotor" 'function))
(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btGeneric6DofConstraint_setLimit" 'function)))
(cffi:defcfun ("_wrap_btGeneric6DofConstraint_setLimit" #.(bullet-wrap::swig-lispify "btGeneric6DofConstraint_setLimit" 'function)) :void
  (self :pointer)
  (axis :int)
  (lo :float)
  (hi :float))

(cl:export '#.(bullet-wrap::swig-lispify "btGeneric6DofConstraint_setLimit" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btGeneric6DofConstraint_isLimited" 'function)))

(cffi:defcfun ("_wrap_btGeneric6DofConstraint_isLimited" #.(bullet-wrap::swig-lispify "btGeneric6DofConstraint_isLimited" 'function)) :pointer
  (self :pointer)
  (limitIndex :int))

(cl:export '#.(bullet-wrap::swig-lispify "btGeneric6DofConstraint_isLimited" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btGeneric6DofConstraint_calcAnchorPos" 'function)))

(cffi:defcfun ("_wrap_btGeneric6DofConstraint_calcAnchorPos" #.(bullet-wrap::swig-lispify "btGeneric6DofConstraint_calcAnchorPos" 'function)) :void
(cl:export '#.(bullet-wrap::swig-lispify "btGeneric6DofConstraint_calcAnchorPos" 'function))
(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btGeneric6DofConstraint_get_limit_motor_info2" 'function)))
(cffi:defcfun ("_wrap_btGeneric6DofConstraint_get_limit_motor_info2__SWIG_0" #.(bullet-wrap::swig-lispify "btGeneric6DofConstraint_get_limit_motor_info2" 'function)) :int
  (self :pointer)
  (limot :pointer)
  (transA :pointer)
  (transB :pointer)
  (linVelA :pointer)
  (linVelB :pointer)
  (angVelA :pointer)
  (angVelB :pointer)
  (info :pointer)
  (row :int)
  (ax1 :pointer)
  (rotational :int)
  (rotAllowed :int))

(cl:export '#.(bullet-wrap::swig-lispify "btGeneric6DofConstraint_get_limit_motor_info2" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btGeneric6DofConstraint_get_limit_motor_info2" 'function)))

(cffi:defcfun ("_wrap_btGeneric6DofConstraint_get_limit_motor_info2__SWIG_1" #.(bullet-wrap::swig-lispify "btGeneric6DofConstraint_get_limit_motor_info2" 'function)) :int
  (self :pointer)
  (limot :pointer)
  (transA :pointer)
  (transB :pointer)
  (linVelA :pointer)
  (linVelB :pointer)
  (angVelA :pointer)
  (angVelB :pointer)
  (info :pointer)
  (row :int)
  (ax1 :pointer)
  (rotational :int))

(cl:export '#.(bullet-wrap::swig-lispify "btGeneric6DofConstraint_get_limit_motor_info2" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btGeneric6DofConstraint_getUseFrameOffset" 'function)))

(cffi:defcfun ("_wrap_btGeneric6DofConstraint_getUseFrameOffset" #.(bullet-wrap::swig-lispify "btGeneric6DofConstraint_getUseFrameOffset" 'function)) :pointer
(cl:export '#.(bullet-wrap::swig-lispify "btGeneric6DofConstraint_getUseFrameOffset" 'function))
(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btGeneric6DofConstraint_setUseFrameOffset" 'function)))

(cffi:defcfun ("_wrap_btGeneric6DofConstraint_setUseFrameOffset" #.(bullet-wrap::swig-lispify "btGeneric6DofConstraint_setUseFrameOffset" 'function)) :void
  (self :pointer)
  (frameOffsetOnOff :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btGeneric6DofConstraint_setUseFrameOffset" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btGeneric6DofConstraint_setParam" 'function)))

(cffi:defcfun ("_wrap_btGeneric6DofConstraint_setParam__SWIG_0" #.(bullet-wrap::swig-lispify "btGeneric6DofConstraint_setParam" 'function)) :void
  (self :pointer)
  (num :int)
  (value :float)
  (axis :int))

(cl:export '#.(bullet-wrap::swig-lispify "btGeneric6DofConstraint_setParam" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btGeneric6DofConstraint_setParam" 'function)))

(cffi:defcfun ("_wrap_btGeneric6DofConstraint_setParam__SWIG_1" #.(bullet-wrap::swig-lispify "btGeneric6DofConstraint_setParam" 'function)) :void
  (self :pointer)
  (num :int)
  (value :float))

(cl:export '#.(bullet-wrap::swig-lispify "btGeneric6DofConstraint_setParam" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btGeneric6DofConstraint_getParam" 'function)))

(cffi:defcfun ("_wrap_btGeneric6DofConstraint_getParam__SWIG_0" #.(bullet-wrap::swig-lispify "btGeneric6DofConstraint_getParam" 'function)) :float
  (self :pointer)
  (num :int)
  (axis :int))

(cl:export '#.(bullet-wrap::swig-lispify "btGeneric6DofConstraint_getParam" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btGeneric6DofConstraint_getParam" 'function)))

(cffi:defcfun ("_wrap_btGeneric6DofConstraint_getParam__SWIG_1" #.(bullet-wrap::swig-lispify "btGeneric6DofConstraint_getParam" 'function)) :float
  (self :pointer)
  (num :int))

(cl:export '#.(bullet-wrap::swig-lispify "btGeneric6DofConstraint_getParam" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btGeneric6DofConstraint_setAxis" 'function)))

(cffi:defcfun ("_wrap_btGeneric6DofConstraint_setAxis" #.(bullet-wrap::swig-lispify "btGeneric6DofConstraint_setAxis" 'function)) :void
  (self :pointer)
  (axis1 :pointer)
  (axis2 :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btGeneric6DofConstraint_setAxis" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btGeneric6DofConstraint_calculateSerializeBufferSize" 'function)))

(cffi:defcfun ("_wrap_btGeneric6DofConstraint_calculateSerializeBufferSize" #.(bullet-wrap::swig-lispify "btGeneric6DofConstraint_calculateSerializeBufferSize" 'function)) :int
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btGeneric6DofConstraint_calculateSerializeBufferSize" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btGeneric6DofConstraint_serialize" 'function)))

(cffi:defcfun ("_wrap_btGeneric6DofConstraint_serialize" #.(bullet-wrap::swig-lispify "btGeneric6DofConstraint_serialize" 'function)) :string
  (self :pointer)
  (dataBuffer :pointer)
  (serializer :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btGeneric6DofConstraint_serialize" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "delete_btGeneric6DofConstraint" 'function)))

(cffi:defcfun ("_wrap_delete_btGeneric6DofConstraint" #.(bullet-wrap::swig-lispify "delete_btGeneric6DofConstraint" 'function)) :void
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "delete_btGeneric6DofConstraint" 'function))

(cffi:defcstruct #.(bullet-wrap::swig-lispify "btGeneric6DofConstraintData" 'classname)
	(#.(bullet-wrap::swig-lispify "m_typeConstraintData" 'slotname) #.(bullet-wrap::swig-lispify "btTypedConstraintData" 'classname))
	(#.(bullet-wrap::swig-lispify "m_rbAFrame" 'slotname) #.(bullet-wrap::swig-lispify "btTransformFloatData" 'classname))
	(#.(bullet-wrap::swig-lispify "m_rbBFrame" 'slotname) #.(bullet-wrap::swig-lispify "btTransformFloatData" 'classname))
	(#.(bullet-wrap::swig-lispify "m_linearUpperLimit" 'slotname) #.(bullet-wrap::swig-lispify "btVector3FloatData" 'classname))
	(#.(bullet-wrap::swig-lispify "m_linearLowerLimit" 'slotname) #.(bullet-wrap::swig-lispify "btVector3FloatData" 'classname))
	(#.(bullet-wrap::swig-lispify "m_angularUpperLimit" 'slotname) #.(bullet-wrap::swig-lispify "btVector3FloatData" 'classname))
	(#.(bullet-wrap::swig-lispify "m_angularLowerLimit" 'slotname) #.(bullet-wrap::swig-lispify "btVector3FloatData" 'classname))
	(#.(bullet-wrap::swig-lispify "m_useLinearReferenceFrameA" 'slotname) :int)
	(#.(bullet-wrap::swig-lispify "m_useOffsetForConstraintFrame" 'slotname) :int))

(cl:export '#.(bullet-wrap::swig-lispify "btGeneric6DofConstraintData" 'classname))

(cl:export '#.(bullet-wrap::swig-lispify "m_typeConstraintData" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_rbAFrame" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_rbBFrame" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_linearUpperLimit" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_linearLowerLimit" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_angularUpperLimit" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_angularLowerLimit" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_useLinearReferenceFrameA" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_useOffsetForConstraintFrame" 'slotname))

(cffi:defcstruct #.(bullet-wrap::swig-lispify "btGeneric6DofConstraintDoubleData2" 'classname)
	(#.(bullet-wrap::swig-lispify "m_typeConstraintData" 'slotname) #.(bullet-wrap::swig-lispify "btTypedConstraintDoubleData" 'classname))
	(#.(bullet-wrap::swig-lispify "m_rbAFrame" 'slotname) #.(bullet-wrap::swig-lispify "btTransformDoubleData" 'classname))
	(#.(bullet-wrap::swig-lispify "m_rbBFrame" 'slotname) #.(bullet-wrap::swig-lispify "btTransformDoubleData" 'classname))
	(#.(bullet-wrap::swig-lispify "m_linearUpperLimit" 'slotname) #.(bullet-wrap::swig-lispify "btVector3DoubleData" 'classname))
	(#.(bullet-wrap::swig-lispify "m_linearLowerLimit" 'slotname) #.(bullet-wrap::swig-lispify "btVector3DoubleData" 'classname))
	(#.(bullet-wrap::swig-lispify "m_angularUpperLimit" 'slotname) #.(bullet-wrap::swig-lispify "btVector3DoubleData" 'classname))
	(#.(bullet-wrap::swig-lispify "m_angularLowerLimit" 'slotname) #.(bullet-wrap::swig-lispify "btVector3DoubleData" 'classname))
	(#.(bullet-wrap::swig-lispify "m_useLinearReferenceFrameA" 'slotname) :int)
	(#.(bullet-wrap::swig-lispify "m_useOffsetForConstraintFrame" 'slotname) :int))

(cl:export '#.(bullet-wrap::swig-lispify "btGeneric6DofConstraintDoubleData2" 'classname))

(cl:export '#.(bullet-wrap::swig-lispify "m_typeConstraintData" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_rbAFrame" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_rbBFrame" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_linearUpperLimit" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_linearLowerLimit" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_angularUpperLimit" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_angularLowerLimit" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_useLinearReferenceFrameA" 'slotname))

(cl:export '#.(bullet-wrap::swig-lispify "m_useOffsetForConstraintFrame" 'slotname))

(cl:defconstant #.(bullet-wrap::swig-lispify "btSliderConstraintDataName" 'constant) "btSliderConstraintData")

(cl:export '#.(bullet-wrap::swig-lispify "btSliderConstraintDataName" 'constant))

(cffi:defcenum #.(bullet-wrap::swig-lispify "btSliderFlags" 'enumname)
	(#.(bullet-wrap::swig-lispify "BT_SLIDER_FLAGS_CFM_DIRLIN" 'enumvalue :keyword) #.(cl:ash 1 0))
	(#.(bullet-wrap::swig-lispify "BT_SLIDER_FLAGS_ERP_DIRLIN" 'enumvalue :keyword) #.(cl:ash 1 1))
	(#.(bullet-wrap::swig-lispify "BT_SLIDER_FLAGS_CFM_DIRANG" 'enumvalue :keyword) #.(cl:ash 1 2))
	(#.(bullet-wrap::swig-lispify "BT_SLIDER_FLAGS_ERP_DIRANG" 'enumvalue :keyword) #.(cl:ash 1 3))
	(#.(bullet-wrap::swig-lispify "BT_SLIDER_FLAGS_CFM_ORTLIN" 'enumvalue :keyword) #.(cl:ash 1 4))
	(#.(bullet-wrap::swig-lispify "BT_SLIDER_FLAGS_ERP_ORTLIN" 'enumvalue :keyword) #.(cl:ash 1 5))
	(#.(bullet-wrap::swig-lispify "BT_SLIDER_FLAGS_CFM_ORTANG" 'enumvalue :keyword) #.(cl:ash 1 6))
	(#.(bullet-wrap::swig-lispify "BT_SLIDER_FLAGS_ERP_ORTANG" 'enumvalue :keyword) #.(cl:ash 1 7))
	(#.(bullet-wrap::swig-lispify "BT_SLIDER_FLAGS_CFM_LIMLIN" 'enumvalue :keyword) #.(cl:ash 1 8))
	(#.(bullet-wrap::swig-lispify "BT_SLIDER_FLAGS_ERP_LIMLIN" 'enumvalue :keyword) #.(cl:ash 1 9))
	(#.(bullet-wrap::swig-lispify "BT_SLIDER_FLAGS_CFM_LIMANG" 'enumvalue :keyword) #.(cl:ash 1 10))
	(#.(bullet-wrap::swig-lispify "BT_SLIDER_FLAGS_ERP_LIMANG" 'enumvalue :keyword) #.(cl:ash 1 11)))

(cl:export '#.(bullet-wrap::swig-lispify "btSliderFlags" 'enumname))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btSliderConstraint_makeCPlusPlusInstance" 'function)))

(cffi:defcfun ("_wrap_btSliderConstraint_makeCPlusPlusInstance__SWIG_0" #.(bullet-wrap::swig-lispify "btSliderConstraint_makeCPlusPlusInstance" 'function)) :pointer
  (self :pointer)
  (sizeInBytes :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btSliderConstraint_makeCPlusPlusInstance" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btSliderConstraint_deleteCPlusPlusInstance" 'function)))

(cffi:defcfun ("_wrap_btSliderConstraint_deleteCPlusPlusInstance__SWIG_0" #.(bullet-wrap::swig-lispify "btSliderConstraint_deleteCPlusPlusInstance" 'function)) :void
  (self :pointer)
  (ptr :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btSliderConstraint_deleteCPlusPlusInstance" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btSliderConstraint_makeCPlusPlusInstance" 'function)))

(cffi:defcfun ("_wrap_btSliderConstraint_makeCPlusPlusInstance__SWIG_1" #.(bullet-wrap::swig-lispify "btSliderConstraint_makeCPlusPlusInstance" 'function)) :pointer
  (self :pointer)
  (arg1 :pointer)
  (ptr :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btSliderConstraint_makeCPlusPlusInstance" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btSliderConstraint_deleteCPlusPlusInstance" 'function)))

(cffi:defcfun ("_wrap_btSliderConstraint_deleteCPlusPlusInstance__SWIG_1" #.(bullet-wrap::swig-lispify "btSliderConstraint_deleteCPlusPlusInstance" 'function)) :void
  (self :pointer)
  (arg1 :pointer)
  (arg2 :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btSliderConstraint_deleteCPlusPlusInstance" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btSliderConstraint_makeCPlusArray" 'function)))

(cffi:defcfun ("_wrap_btSliderConstraint_makeCPlusArray__SWIG_0" #.(bullet-wrap::swig-lispify "btSliderConstraint_makeCPlusArray" 'function)) :pointer
  (self :pointer)
  (sizeInBytes :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btSliderConstraint_makeCPlusArray" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btSliderConstraint_deleteCPlusArray" 'function)))

(cffi:defcfun ("_wrap_btSliderConstraint_deleteCPlusArray__SWIG_0" #.(bullet-wrap::swig-lispify "btSliderConstraint_deleteCPlusArray" 'function)) :void
  (self :pointer)
  (ptr :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btSliderConstraint_deleteCPlusArray" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btSliderConstraint_makeCPlusArray" 'function)))

(cffi:defcfun ("_wrap_btSliderConstraint_makeCPlusArray__SWIG_1" #.(bullet-wrap::swig-lispify "btSliderConstraint_makeCPlusArray" 'function)) :pointer
  (self :pointer)
  (arg1 :pointer)
  (ptr :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btSliderConstraint_makeCPlusArray" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btSliderConstraint_deleteCPlusArray" 'function)))

(cffi:defcfun ("_wrap_btSliderConstraint_deleteCPlusArray__SWIG_1" #.(bullet-wrap::swig-lispify "btSliderConstraint_deleteCPlusArray" 'function)) :void
  (self :pointer)
  (arg1 :pointer)
  (arg2 :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btSliderConstraint_deleteCPlusArray" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "new_btSliderConstraint" 'function)))

(cffi:defcfun ("_wrap_new_btSliderConstraint__SWIG_0" #.(bullet-wrap::swig-lispify "new_btSliderConstraint" 'function)) :pointer
  (rbA :pointer)
  (rbB :pointer)
  (frameInA :pointer)
  (frameInB :pointer)
  (useLinearReferenceFrameA :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "new_btSliderConstraint" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "new_btSliderConstraint" 'function)))

(cffi:defcfun ("_wrap_new_btSliderConstraint__SWIG_1" #.(bullet-wrap::swig-lispify "new_btSliderConstraint" 'function)) :pointer
  (rbB :pointer)
  (frameInB :pointer)
  (useLinearReferenceFrameA :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "new_btSliderConstraint" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btSliderConstraint_getInfo1" 'function)))

(cffi:defcfun ("_wrap_btSliderConstraint_getInfo1" #.(bullet-wrap::swig-lispify "btSliderConstraint_getInfo1" 'function)) :void
  (self :pointer)
  (info :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btSliderConstraint_getInfo1" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btSliderConstraint_getInfo1NonVirtual" 'function)))

(cffi:defcfun ("_wrap_btSliderConstraint_getInfo1NonVirtual" #.(bullet-wrap::swig-lispify "btSliderConstraint_getInfo1NonVirtual" 'function)) :void
  (self :pointer)
  (info :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btSliderConstraint_getInfo1NonVirtual" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btSliderConstraint_getInfo2" 'function)))

(cffi:defcfun ("_wrap_btSliderConstraint_getInfo2" #.(bullet-wrap::swig-lispify "btSliderConstraint_getInfo2" 'function)) :void
  (self :pointer)
  (info :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btSliderConstraint_getInfo2" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btSliderConstraint_getInfo2NonVirtual" 'function)))

(cffi:defcfun ("_wrap_btSliderConstraint_getInfo2NonVirtual" #.(bullet-wrap::swig-lispify "btSliderConstraint_getInfo2NonVirtual" 'function)) :void
  (self :pointer)
  (info :pointer)
  (transA :pointer)
  (transB :pointer)
  (linVelA :pointer)
  (linVelB :pointer)
  (rbAinvMass :float)
  (rbBinvMass :float))

(cl:export '#.(bullet-wrap::swig-lispify "btSliderConstraint_getInfo2NonVirtual" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btSliderConstraint_getRigidBodyA" 'function)))

(cffi:defcfun ("_wrap_btSliderConstraint_getRigidBodyA" #.(bullet-wrap::swig-lispify "btSliderConstraint_getRigidBodyA" 'function)) :pointer
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btSliderConstraint_getRigidBodyA" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btSliderConstraint_getRigidBodyB" 'function)))

(cffi:defcfun ("_wrap_btSliderConstraint_getRigidBodyB" #.(bullet-wrap::swig-lispify "btSliderConstraint_getRigidBodyB" 'function)) :pointer
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btSliderConstraint_getRigidBodyB" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btSliderConstraint_getCalculatedTransformA" 'function)))

(cffi:defcfun ("_wrap_btSliderConstraint_getCalculatedTransformA" #.(bullet-wrap::swig-lispify "btSliderConstraint_getCalculatedTransformA" 'function)) :pointer
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btSliderConstraint_getCalculatedTransformA" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btSliderConstraint_getCalculatedTransformB" 'function)))

(cffi:defcfun ("_wrap_btSliderConstraint_getCalculatedTransformB" #.(bullet-wrap::swig-lispify "btSliderConstraint_getCalculatedTransformB" 'function)) :pointer
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btSliderConstraint_getCalculatedTransformB" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btSliderConstraint_getFrameOffsetA" 'function)))
(cffi:defcfun ("_wrap_btSliderConstraint_getFrameOffsetA__SWIG_0" #.(bullet-wrap::swig-lispify "btSliderConstraint_getFrameOffsetA" 'function)) :pointer
(cl:export '#.(bullet-wrap::swig-lispify "btSliderConstraint_getFrameOffsetA" 'function))
(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btSliderConstraint_getFrameOffsetB" 'function)))
(cffi:defcfun ("_wrap_btSliderConstraint_getFrameOffsetB__SWIG_0" #.(bullet-wrap::swig-lispify "btSliderConstraint_getFrameOffsetB" 'function)) :pointer
(cl:export '#.(bullet-wrap::swig-lispify "btSliderConstraint_getFrameOffsetB" 'function))
(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btSliderConstraint_getFrameOffsetA" 'function)))
(cffi:defcfun ("_wrap_btSliderConstraint_getFrameOffsetA__SWIG_1" #.(bullet-wrap::swig-lispify "btSliderConstraint_getFrameOffsetA" 'function)) :pointer
  (self :pointer))
(cl:export '#.(bullet-wrap::swig-lispify "btSliderConstraint_getFrameOffsetA" 'function))
(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btSliderConstraint_getFrameOffsetB" 'function)))
(cffi:defcfun ("_wrap_btSliderConstraint_getFrameOffsetB__SWIG_1" #.(bullet-wrap::swig-lispify "btSliderConstraint_getFrameOffsetB" 'function)) :pointer
(cl:export '#.(bullet-wrap::swig-lispify "btSliderConstraint_getFrameOffsetB" 'function))
(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btSliderConstraint_getLowerLinLimit" 'function)))
(cffi:defcfun ("_wrap_btSliderConstraint_getLowerLinLimit" #.(bullet-wrap::swig-lispify "btSliderConstraint_getLowerLinLimit" 'function)) :float
(cl:export '#.(bullet-wrap::swig-lispify "btSliderConstraint_getLowerLinLimit" 'function))
(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btSliderConstraint_setLowerLinLimit" 'function)))
(cffi:defcfun ("_wrap_btSliderConstraint_setLowerLinLimit" #.(bullet-wrap::swig-lispify "btSliderConstraint_setLowerLinLimit" 'function)) :void
  (lowerLimit :float))
(cl:export '#.(bullet-wrap::swig-lispify "btSliderConstraint_setLowerLinLimit" 'function))
(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btSliderConstraint_getUpperLinLimit" 'function)))
(cffi:defcfun ("_wrap_btSliderConstraint_getUpperLinLimit" #.(bullet-wrap::swig-lispify "btSliderConstraint_getUpperLinLimit" 'function)) :float
(cl:export '#.(bullet-wrap::swig-lispify "btSliderConstraint_getUpperLinLimit" 'function))
(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btSliderConstraint_setUpperLinLimit" 'function)))
(cffi:defcfun ("_wrap_btSliderConstraint_setUpperLinLimit" #.(bullet-wrap::swig-lispify "btSliderConstraint_setUpperLinLimit" 'function)) :void
  (self :pointer)
  (upperLimit :float))

(cl:export '#.(bullet-wrap::swig-lispify "btSliderConstraint_setUpperLinLimit" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btSliderConstraint_getLowerAngLimit" 'function)))

(cffi:defcfun ("_wrap_btSliderConstraint_getLowerAngLimit" #.(bullet-wrap::swig-lispify "btSliderConstraint_getLowerAngLimit" 'function)) :float
(cl:export '#.(bullet-wrap::swig-lispify "btSliderConstraint_getLowerAngLimit" 'function))
(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btSliderConstraint_setLowerAngLimit" 'function)))
(cffi:defcfun ("_wrap_btSliderConstraint_setLowerAngLimit" #.(bullet-wrap::swig-lispify "btSliderConstraint_setLowerAngLimit" 'function)) :void
  (lowerLimit :float))
(cl:export '#.(bullet-wrap::swig-lispify "btSliderConstraint_setLowerAngLimit" 'function))
(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btSliderConstraint_getUpperAngLimit" 'function)))
(cffi:defcfun ("_wrap_btSliderConstraint_getUpperAngLimit" #.(bullet-wrap::swig-lispify "btSliderConstraint_getUpperAngLimit" 'function)) :float
(cl:export '#.(bullet-wrap::swig-lispify "btSliderConstraint_getUpperAngLimit" 'function))
(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btSliderConstraint_setUpperAngLimit" 'function)))
(cffi:defcfun ("_wrap_btSliderConstraint_setUpperAngLimit" #.(bullet-wrap::swig-lispify "btSliderConstraint_setUpperAngLimit" 'function)) :void
  (upperLimit :float))
(cl:export '#.(bullet-wrap::swig-lispify "btSliderConstraint_setUpperAngLimit" 'function))
(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btSliderConstraint_getUseLinearReferenceFrameA" 'function)))
(cffi:defcfun ("_wrap_btSliderConstraint_getUseLinearReferenceFrameA" #.(bullet-wrap::swig-lispify "btSliderConstraint_getUseLinearReferenceFrameA" 'function)) :pointer
  (self :pointer))
(cl:export '#.(bullet-wrap::swig-lispify "btSliderConstraint_getUseLinearReferenceFrameA" 'function))
(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btSliderConstraint_getSoftnessDirLin" 'function)))
(cffi:defcfun ("_wrap_btSliderConstraint_getSoftnessDirLin" #.(bullet-wrap::swig-lispify "btSliderConstraint_getSoftnessDirLin" 'function)) :float
  (self :pointer))
(cl:export '#.(bullet-wrap::swig-lispify "btSliderConstraint_getSoftnessDirLin" 'function))
(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btSliderConstraint_getRestitutionDirLin" 'function)))
(cffi:defcfun ("_wrap_btSliderConstraint_getRestitutionDirLin" #.(bullet-wrap::swig-lispify "btSliderConstraint_getRestitutionDirLin" 'function)) :float
  (self :pointer))
(cl:export '#.(bullet-wrap::swig-lispify "btSliderConstraint_getRestitutionDirLin" 'function))
(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btSliderConstraint_getDampingDirLin" 'function)))
(cffi:defcfun ("_wrap_btSliderConstraint_getDampingDirLin" #.(bullet-wrap::swig-lispify "btSliderConstraint_getDampingDirLin" 'function)) :float
  (self :pointer))
(cl:export '#.(bullet-wrap::swig-lispify "btSliderConstraint_getDampingDirLin" 'function))
(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btSliderConstraint_getSoftnessDirAng" 'function)))
(cffi:defcfun ("_wrap_btSliderConstraint_getSoftnessDirAng" #.(bullet-wrap::swig-lispify "btSliderConstraint_getSoftnessDirAng" 'function)) :float
  (self :pointer))
(cl:export '#.(bullet-wrap::swig-lispify "btSliderConstraint_getSoftnessDirAng" 'function))
(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btSliderConstraint_getRestitutionDirAng" 'function)))
(cffi:defcfun ("_wrap_btSliderConstraint_getRestitutionDirAng" #.(bullet-wrap::swig-lispify "btSliderConstraint_getRestitutionDirAng" 'function)) :float
  (self :pointer))
(cl:export '#.(bullet-wrap::swig-lispify "btSliderConstraint_getRestitutionDirAng" 'function))
(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btSliderConstraint_getDampingDirAng" 'function)))
(cffi:defcfun ("_wrap_btSliderConstraint_getDampingDirAng" #.(bullet-wrap::swig-lispify "btSliderConstraint_getDampingDirAng" 'function)) :float
  (self :pointer))
(cl:export '#.(bullet-wrap::swig-lispify "btSliderConstraint_getDampingDirAng" 'function))
(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btSliderConstraint_getSoftnessLimLin" 'function)))
(cffi:defcfun ("_wrap_btSliderConstraint_getSoftnessLimLin" #.(bullet-wrap::swig-lispify "btSliderConstraint_getSoftnessLimLin" 'function)) :float
  (self :pointer))
(cl:export '#.(bullet-wrap::swig-lispify "btSliderConstraint_getSoftnessLimLin" 'function))
(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btSliderConstraint_getRestitutionLimLin" 'function)))
(cffi:defcfun ("_wrap_btSliderConstraint_getRestitutionLimLin" #.(bullet-wrap::swig-lispify "btSliderConstraint_getRestitutionLimLin" 'function)) :float
  (self :pointer))
(cl:export '#.(bullet-wrap::swig-lispify "btSliderConstraint_getRestitutionLimLin" 'function))
(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btSliderConstraint_getDampingLimLin" 'function)))
(cffi:defcfun ("_wrap_btSliderConstraint_getDampingLimLin" #.(bullet-wrap::swig-lispify "btSliderConstraint_getDampingLimLin" 'function)) :float
  (self :pointer))
(cl:export '#.(bullet-wrap::swig-lispify "btSliderConstraint_getDampingLimLin" 'function))
(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btSliderConstraint_getSoftnessLimAng" 'function)))
(cffi:defcfun ("_wrap_btSliderConstraint_getSoftnessLimAng" #.(bullet-wrap::swig-lispify "btSliderConstraint_getSoftnessLimAng" 'function)) :float
  (self :pointer))
(cl:export '#.(bullet-wrap::swig-lispify "btSliderConstraint_getSoftnessLimAng" 'function))
(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btSliderConstraint_getRestitutionLimAng" 'function)))
(cffi:defcfun ("_wrap_btSliderConstraint_getRestitutionLimAng" #.(bullet-wrap::swig-lispify "btSliderConstraint_getRestitutionLimAng" 'function)) :float
(cl:export '#.(bullet-wrap::swig-lispify "btSliderConstraint_getRestitutionLimAng" 'function))
(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btSliderConstraint_getDampingLimAng" 'function)))
(cffi:defcfun ("_wrap_btSliderConstraint_getDampingLimAng" #.(bullet-wrap::swig-lispify "btSliderConstraint_getDampingLimAng" 'function)) :float
(cl:export '#.(bullet-wrap::swig-lispify "btSliderConstraint_getDampingLimAng" 'function))
(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btSliderConstraint_getSoftnessOrthoLin" 'function)))
(cffi:defcfun ("_wrap_btSliderConstraint_getSoftnessOrthoLin" #.(bullet-wrap::swig-lispify "btSliderConstraint_getSoftnessOrthoLin" 'function)) :float
  (self :pointer))
(cl:export '#.(bullet-wrap::swig-lispify "btSliderConstraint_getSoftnessOrthoLin" 'function))
(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btSliderConstraint_getRestitutionOrthoLin" 'function)))
(cffi:defcfun ("_wrap_btSliderConstraint_getRestitutionOrthoLin" #.(bullet-wrap::swig-lispify "btSliderConstraint_getRestitutionOrthoLin" 'function)) :float
(cl:export '#.(bullet-wrap::swig-lispify "btSliderConstraint_getRestitutionOrthoLin" 'function))
(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btSliderConstraint_getDampingOrthoLin" 'function)))
(cffi:defcfun ("_wrap_btSliderConstraint_getDampingOrthoLin" #.(bullet-wrap::swig-lispify "btSliderConstraint_getDampingOrthoLin" 'function)) :float
(cl:export '#.(bullet-wrap::swig-lispify "btSliderConstraint_getDampingOrthoLin" 'function))
(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btSliderConstraint_getSoftnessOrthoAng" 'function)))
(cffi:defcfun ("_wrap_btSliderConstraint_getSoftnessOrthoAng" #.(bullet-wrap::swig-lispify "btSliderConstraint_getSoftnessOrthoAng" 'function)) :float
(cl:export '#.(bullet-wrap::swig-lispify "btSliderConstraint_getSoftnessOrthoAng" 'function))
(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btSliderConstraint_getRestitutionOrthoAng" 'function)))
(cffi:defcfun ("_wrap_btSliderConstraint_getRestitutionOrthoAng" #.(bullet-wrap::swig-lispify "btSliderConstraint_getRestitutionOrthoAng" 'function)) :float
(cl:export '#.(bullet-wrap::swig-lispify "btSliderConstraint_getRestitutionOrthoAng" 'function))
(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btSliderConstraint_getDampingOrthoAng" 'function)))
(cffi:defcfun ("_wrap_btSliderConstraint_getDampingOrthoAng" #.(bullet-wrap::swig-lispify "btSliderConstraint_getDampingOrthoAng" 'function)) :float
  (self :pointer))
(cl:export '#.(bullet-wrap::swig-lispify "btSliderConstraint_getDampingOrthoAng" 'function))
(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btSliderConstraint_setSoftnessDirLin" 'function)))
(cffi:defcfun ("_wrap_btSliderConstraint_setSoftnessDirLin" #.(bullet-wrap::swig-lispify "btSliderConstraint_setSoftnessDirLin" 'function)) :void
  (softnessDirLin :float))
(cl:export '#.(bullet-wrap::swig-lispify "btSliderConstraint_setSoftnessDirLin" 'function))
(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btSliderConstraint_setRestitutionDirLin" 'function)))
(cffi:defcfun ("_wrap_btSliderConstraint_setRestitutionDirLin" #.(bullet-wrap::swig-lispify "btSliderConstraint_setRestitutionDirLin" 'function)) :void
  (self :pointer)
  (restitutionDirLin :float))
(cl:export '#.(bullet-wrap::swig-lispify "btSliderConstraint_setRestitutionDirLin" 'function))
(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btSliderConstraint_setDampingDirLin" 'function)))
(cffi:defcfun ("_wrap_btSliderConstraint_setDampingDirLin" #.(bullet-wrap::swig-lispify "btSliderConstraint_setDampingDirLin" 'function)) :void
  (self :pointer)
  (dampingDirLin :float))
(cl:export '#.(bullet-wrap::swig-lispify "btSliderConstraint_setDampingDirLin" 'function))
(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btSliderConstraint_setSoftnessDirAng" 'function)))
(cffi:defcfun ("_wrap_btSliderConstraint_setSoftnessDirAng" #.(bullet-wrap::swig-lispify "btSliderConstraint_setSoftnessDirAng" 'function)) :void
  (self :pointer)
  (softnessDirAng :float))
(cl:export '#.(bullet-wrap::swig-lispify "btSliderConstraint_setSoftnessDirAng" 'function))
(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btSliderConstraint_setRestitutionDirAng" 'function)))
(cffi:defcfun ("_wrap_btSliderConstraint_setRestitutionDirAng" #.(bullet-wrap::swig-lispify "btSliderConstraint_setRestitutionDirAng" 'function)) :void
  (self :pointer)
  (restitutionDirAng :float))
(cl:export '#.(bullet-wrap::swig-lispify "btSliderConstraint_setRestitutionDirAng" 'function))
(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btSliderConstraint_setDampingDirAng" 'function)))
(cffi:defcfun ("_wrap_btSliderConstraint_setDampingDirAng" #.(bullet-wrap::swig-lispify "btSliderConstraint_setDampingDirAng" 'function)) :void
  (self :pointer)
  (dampingDirAng :float))
(cl:export '#.(bullet-wrap::swig-lispify "btSliderConstraint_setDampingDirAng" 'function))
(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btSliderConstraint_setSoftnessLimLin" 'function)))
(cffi:defcfun ("_wrap_btSliderConstraint_setSoftnessLimLin" #.(bullet-wrap::swig-lispify "btSliderConstraint_setSoftnessLimLin" 'function)) :void
  (self :pointer)
  (softnessLimLin :float))
(cl:export '#.(bullet-wrap::swig-lispify "btSliderConstraint_setSoftnessLimLin" 'function))
(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btSliderConstraint_setRestitutionLimLin" 'function)))
(cffi:defcfun ("_wrap_btSliderConstraint_setRestitutionLimLin" #.(bullet-wrap::swig-lispify "btSliderConstraint_setRestitutionLimLin" 'function)) :void
  (self :pointer)
  (restitutionLimLin :float))
(cl:export '#.(bullet-wrap::swig-lispify "btSliderConstraint_setRestitutionLimLin" 'function))
(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btSliderConstraint_setDampingLimLin" 'function)))
(cffi:defcfun ("_wrap_btSliderConstraint_setDampingLimLin" #.(bullet-wrap::swig-lispify "btSliderConstraint_setDampingLimLin" 'function)) :void
  (dampingLimLin :float))
(cl:export '#.(bullet-wrap::swig-lispify "btSliderConstraint_setDampingLimLin" 'function))
(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btSliderConstraint_setSoftnessLimAng" 'function)))
(cffi:defcfun ("_wrap_btSliderConstraint_setSoftnessLimAng" #.(bullet-wrap::swig-lispify "btSliderConstraint_setSoftnessLimAng" 'function)) :void
  (softnessLimAng :float))
(cl:export '#.(bullet-wrap::swig-lispify "btSliderConstraint_setSoftnessLimAng" 'function))
(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btSliderConstraint_setRestitutionLimAng" 'function)))
(cffi:defcfun ("_wrap_btSliderConstraint_setRestitutionLimAng" #.(bullet-wrap::swig-lispify "btSliderConstraint_setRestitutionLimAng" 'function)) :void
  (restitutionLimAng :float))
(cl:export '#.(bullet-wrap::swig-lispify "btSliderConstraint_setRestitutionLimAng" 'function))
(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btSliderConstraint_setDampingLimAng" 'function)))
(cffi:defcfun ("_wrap_btSliderConstraint_setDampingLimAng" #.(bullet-wrap::swig-lispify "btSliderConstraint_setDampingLimAng" 'function)) :void
  (self :pointer)
  (dampingLimAng :float))
(cl:export '#.(bullet-wrap::swig-lispify "btSliderConstraint_setDampingLimAng" 'function))
(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btSliderConstraint_setSoftnessOrthoLin" 'function)))
(cffi:defcfun ("_wrap_btSliderConstraint_setSoftnessOrthoLin" #.(bullet-wrap::swig-lispify "btSliderConstraint_setSoftnessOrthoLin" 'function)) :void
  (softnessOrthoLin :float))
(cl:export '#.(bullet-wrap::swig-lispify "btSliderConstraint_setSoftnessOrthoLin" 'function))
(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btSliderConstraint_setRestitutionOrthoLin" 'function)))
(cffi:defcfun ("_wrap_btSliderConstraint_setRestitutionOrthoLin" #.(bullet-wrap::swig-lispify "btSliderConstraint_setRestitutionOrthoLin" 'function)) :void
  (self :pointer)
  (restitutionOrthoLin :float))
(cl:export '#.(bullet-wrap::swig-lispify "btSliderConstraint_setRestitutionOrthoLin" 'function))
(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btSliderConstraint_setDampingOrthoLin" 'function)))
(cffi:defcfun ("_wrap_btSliderConstraint_setDampingOrthoLin" #.(bullet-wrap::swig-lispify "btSliderConstraint_setDampingOrthoLin" 'function)) :void
  (self :pointer)
  (dampingOrthoLin :float))
(cl:export '#.(bullet-wrap::swig-lispify "btSliderConstraint_setDampingOrthoLin" 'function))
(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btSliderConstraint_setSoftnessOrthoAng" 'function)))
(cffi:defcfun ("_wrap_btSliderConstraint_setSoftnessOrthoAng" #.(bullet-wrap::swig-lispify "btSliderConstraint_setSoftnessOrthoAng" 'function)) :void
  (self :pointer)
  (softnessOrthoAng :float))
(cl:export '#.(bullet-wrap::swig-lispify "btSliderConstraint_setSoftnessOrthoAng" 'function))
(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btSliderConstraint_setRestitutionOrthoAng" 'function)))
(cffi:defcfun ("_wrap_btSliderConstraint_setRestitutionOrthoAng" #.(bullet-wrap::swig-lispify "btSliderConstraint_setRestitutionOrthoAng" 'function)) :void
  (self :pointer)
  (restitutionOrthoAng :float))
(cl:export '#.(bullet-wrap::swig-lispify "btSliderConstraint_setRestitutionOrthoAng" 'function))
(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btSliderConstraint_setDampingOrthoAng" 'function)))
(cffi:defcfun ("_wrap_btSliderConstraint_setDampingOrthoAng" #.(bullet-wrap::swig-lispify "btSliderConstraint_setDampingOrthoAng" 'function)) :void
  (self :pointer)
  (dampingOrthoAng :float))
(cl:export '#.(bullet-wrap::swig-lispify "btSliderConstraint_setDampingOrthoAng" 'function))
(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btSliderConstraint_setPoweredLinMotor" 'function)))
(cffi:defcfun ("_wrap_btSliderConstraint_setPoweredLinMotor" #.(bullet-wrap::swig-lispify "btSliderConstraint_setPoweredLinMotor" 'function)) :void
  (self :pointer)
  (onOff :pointer))
(cl:export '#.(bullet-wrap::swig-lispify "btSliderConstraint_setPoweredLinMotor" 'function))
(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btSliderConstraint_getPoweredLinMotor" 'function)))
(cffi:defcfun ("_wrap_btSliderConstraint_getPoweredLinMotor" #.(bullet-wrap::swig-lispify "btSliderConstraint_getPoweredLinMotor" 'function)) :pointer
(cl:export '#.(bullet-wrap::swig-lispify "btSliderConstraint_getPoweredLinMotor" 'function))
(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btSliderConstraint_setTargetLinMotorVelocity" 'function)))
(cffi:defcfun ("_wrap_btSliderConstraint_setTargetLinMotorVelocity" #.(bullet-wrap::swig-lispify "btSliderConstraint_setTargetLinMotorVelocity" 'function)) :void
  (targetLinMotorVelocity :float))
(cl:export '#.(bullet-wrap::swig-lispify "btSliderConstraint_setTargetLinMotorVelocity" 'function))
(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btSliderConstraint_getTargetLinMotorVelocity" 'function)))
(cffi:defcfun ("_wrap_btSliderConstraint_getTargetLinMotorVelocity" #.(bullet-wrap::swig-lispify "btSliderConstraint_getTargetLinMotorVelocity" 'function)) :float
(cl:export '#.(bullet-wrap::swig-lispify "btSliderConstraint_getTargetLinMotorVelocity" 'function))
(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btSliderConstraint_setMaxLinMotorForce" 'function)))
(cffi:defcfun ("_wrap_btSliderConstraint_setMaxLinMotorForce" #.(bullet-wrap::swig-lispify "btSliderConstraint_setMaxLinMotorForce" 'function)) :void
  (self :pointer)
  (maxLinMotorForce :float))
(cl:export '#.(bullet-wrap::swig-lispify "btSliderConstraint_setMaxLinMotorForce" 'function))
(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btSliderConstraint_getMaxLinMotorForce" 'function)))
(cffi:defcfun ("_wrap_btSliderConstraint_getMaxLinMotorForce" #.(bullet-wrap::swig-lispify "btSliderConstraint_getMaxLinMotorForce" 'function)) :float
(cl:export '#.(bullet-wrap::swig-lispify "btSliderConstraint_getMaxLinMotorForce" 'function))
(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btSliderConstraint_setPoweredAngMotor" 'function)))
(cffi:defcfun ("_wrap_btSliderConstraint_setPoweredAngMotor" #.(bullet-wrap::swig-lispify "btSliderConstraint_setPoweredAngMotor" 'function)) :void
  (onOff :pointer))
(cl:export '#.(bullet-wrap::swig-lispify "btSliderConstraint_setPoweredAngMotor" 'function))
(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btSliderConstraint_getPoweredAngMotor" 'function)))
(cffi:defcfun ("_wrap_btSliderConstraint_getPoweredAngMotor" #.(bullet-wrap::swig-lispify "btSliderConstraint_getPoweredAngMotor" 'function)) :pointer
(cl:export '#.(bullet-wrap::swig-lispify "btSliderConstraint_getPoweredAngMotor" 'function))
(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btSliderConstraint_setTargetAngMotorVelocity" 'function)))
(cffi:defcfun ("_wrap_btSliderConstraint_setTargetAngMotorVelocity" #.(bullet-wrap::swig-lispify "btSliderConstraint_setTargetAngMotorVelocity" 'function)) :void
  (targetAngMotorVelocity :float))
(cl:export '#.(bullet-wrap::swig-lispify "btSliderConstraint_setTargetAngMotorVelocity" 'function))
(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btSliderConstraint_getTargetAngMotorVelocity" 'function)))
(cffi:defcfun ("_wrap_btSliderConstraint_getTargetAngMotorVelocity" #.(bullet-wrap::swig-lispify "btSliderConstraint_getTargetAngMotorVelocity" 'function)) :float
  (self :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "btSliderConstraint_getTargetAngMotorVelocity" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btSliderConstraint_setMaxAngMotorForce" 'function)))

(cffi:defcfun ("_wrap_btSliderConstraint_setMaxAngMotorForce" #.(bullet-wrap::swig-lispify "btSliderConstraint_setMaxAngMotorForce" 'function)) :void
  (maxAngMotorForce :float))
(cl:export '#.(bullet-wrap::swig-lispify "btSliderConstraint_setMaxAngMotorForce" 'function))
(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btSliderConstraint_getMaxAngMotorForce" 'function)))
(cffi:defcfun ("_wrap_btSliderConstraint_getMaxAngMotorForce" #.(bullet-wrap::swig-lispify "btSliderConstraint_getMaxAngMotorForce" 'function)) :float
(cl:export '#.(bullet-wrap::swig-lispify "btSliderConstraint_getMaxAngMotorForce" 'function))
(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btSliderConstraint_getLinearPos" 'function)))
(cffi:defcfun ("_wrap_btSliderConstraint_getLinearPos" #.(bullet-wrap::swig-lispify "btSliderConstraint_getLinearPos" 'function)) :float
  (self :pointer))
(cl:export '#.(bullet-wrap::swig-lispify "btSliderConstraint_getLinearPos" 'function))
(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btSliderConstraint_getAngularPos" 'function)))
(cffi:defcfun ("_wrap_btSliderConstraint_getAngularPos" #.(bullet-wrap::swig-lispify "btSliderConstraint_getAngularPos" 'function)) :float
  (self :pointer))
(cl:export '#.(bullet-wrap::swig-lispify "btSliderConstraint_getAngularPos" 'function))
(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btSliderConstraint_getSolveLinLimit" 'function)))
(cffi:defcfun ("_wrap_btSliderConstraint_getSolveLinLimit" #.(bullet-wrap::swig-lispify "btSliderConstraint_getSolveLinLimit" 'function)) :pointer
(cl:export '#.(bullet-wrap::swig-lispify "btSliderConstraint_getSolveLinLimit" 'function))
(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btSliderConstraint_getLinDepth" 'function)))
(cffi:defcfun ("_wrap_btSliderConstraint_getLinDepth" #.(bullet-wrap::swig-lispify "btSliderConstraint_getLinDepth" 'function)) :float
(cl:export '#.(bullet-wrap::swig-lispify "btSliderConstraint_getLinDepth" 'function))
(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btSliderConstraint_getSolveAngLimit" 'function)))
(cffi:defcfun ("_wrap_btSliderConstraint_getSolveAngLimit" #.(bullet-wrap::swig-lispify "btSliderConstraint_getSolveAngLimit" 'function)) :pointer
  (self :pointer))
(cl:export '#.(bullet-wrap::swig-lispify "btSliderConstraint_getSolveAngLimit" 'function))
(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btSliderConstraint_getAngDepth" 'function)))
(cffi:defcfun ("_wrap_btSliderConstraint_getAngDepth" #.(bullet-wrap::swig-lispify "btSliderConstraint_getAngDepth" 'function)) :float
(cl:export '#.(bullet-wrap::swig-lispify "btSliderConstraint_getAngDepth" 'function))
(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btSliderConstraint_calculateTransforms" 'function)))
(cffi:defcfun ("_wrap_btSliderConstraint_calculateTransforms" #.(bullet-wrap::swig-lispify "btSliderConstraint_calculateTransforms" 'function)) :void
  (transA :pointer)
  (transB :pointer))
(cl:export '#.(bullet-wrap::swig-lispify "btSliderConstraint_calculateTransforms" 'function))
(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btSliderConstraint_testLinLimits" 'function)))
(cffi:defcfun ("_wrap_btSliderConstraint_testLinLimits" #.(bullet-wrap::swig-lispify "btSliderConstraint_testLinLimits" 'function)) :void
(cl:export '#.(bullet-wrap::swig-lispify "btSliderConstraint_testLinLimits" 'function))
(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btSliderConstraint_testAngLimits" 'function)))
(cffi:defcfun ("_wrap_btSliderConstraint_testAngLimits" #.(bullet-wrap::swig-lispify "btSliderConstraint_testAngLimits" 'function)) :void
  (self :pointer))
(cl:export '#.(bullet-wrap::swig-lispify "btSliderConstraint_testAngLimits" 'function))
(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btSliderConstraint_getAncorInA" 'function)))
(cffi:defcfun ("_wrap_btSliderConstraint_getAncorInA" #.(bullet-wrap::swig-lispify "btSliderConstraint_getAncorInA" 'function)) :pointer
(cl:export '#.(bullet-wrap::swig-lispify "btSliderConstraint_getAncorInA" 'function))
(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btSliderConstraint_getAncorInB" 'function)))
(cffi:defcfun ("_wrap_btSliderConstraint_getAncorInB" #.(bullet-wrap::swig-lispify "btSliderConstraint_getAncorInB" 'function)) :pointer
(cl:export '#.(bullet-wrap::swig-lispify "btSliderConstraint_getAncorInB" 'function))
(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btSliderConstraint_getUseFrameOffset" 'function)))
(cffi:defcfun ("_wrap_btSliderConstraint_getUseFrameOffset" #.(bullet-wrap::swig-lispify "btSliderConstraint_getUseFrameOffset" 'function)) :pointer
(cl:export '#.(bullet-wrap::swig-lispify "btSliderConstraint_getUseFrameOffset" 'function))
(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btSliderConstraint_setUseFrameOffset" 'function)))
(cffi:defcfun ("_wrap_btSliderConstraint_setUseFrameOffset" #.(bullet-wrap::swig-lispify "btSliderConstraint_setUseFrameOffset" 'function)) :void
  (self :pointer)
  (frameOffsetOnOff :pointer))
(cl:export '#.(bullet-wrap::swig-lispify "btSliderConstraint_setUseFrameOffset" 'function))
(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btSliderConstraint_setFrames" 'function)))
(cffi:defcfun ("_wrap_btSliderConstraint_setFrames" #.(bullet-wrap::swig-lispify "btSliderConstraint_setFrames" 'function)) :void
  (frameA :pointer)
  (frameB :pointer))
(cl:export '#.(bullet-wrap::swig-lispify "btSliderConstraint_setFrames" 'function))
(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btSliderConstraint_setParam" 'function)))
(cffi:defcfun ("_wrap_btSliderConstraint_setParam__SWIG_0" #.(bullet-wrap::swig-lispify "btSliderConstraint_setParam" 'function)) :void
  (self :pointer)
  (num :int)
  (value :float)
  (axis :int))
(cl:export '#.(bullet-wrap::swig-lispify "btSliderConstraint_setParam" 'function))
(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btSliderConstraint_setParam" 'function)))
(cffi:defcfun ("_wrap_btSliderConstraint_setParam__SWIG_1" #.(bullet-wrap::swig-lispify "btSliderConstraint_setParam" 'function)) :void
  (self :pointer)
  (num :int)
  (value :float))
(cl:export '#.(bullet-wrap::swig-lispify "btSliderConstraint_setParam" 'function))
(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btSliderConstraint_getParam" 'function)))
(cffi:defcfun ("_wrap_btSliderConstraint_getParam__SWIG_0" #.(bullet-wrap::swig-lispify "btSliderConstraint_getParam" 'function)) :float
  (num :int)
  (axis :int))
(cl:export '#.(bullet-wrap::swig-lispify "btSliderConstraint_getParam" 'function))
(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btSliderConstraint_getParam" 'function)))
(cffi:defcfun ("_wrap_btSliderConstraint_getParam__SWIG_1" #.(bullet-wrap::swig-lispify "btSliderConstraint_getParam" 'function)) :float
  (self :pointer)
  (num :int))
(cl:export '#.(bullet-wrap::swig-lispify "btSliderConstraint_getParam" 'function))
(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btSliderConstraint_calculateSerializeBufferSize" 'function)))
(cffi:defcfun ("_wrap_btSliderConstraint_calculateSerializeBufferSize" #.(bullet-wrap::swig-lispify "btSliderConstraint_calculateSerializeBufferSize" 'function)) :int
(cl:export '#.(bullet-wrap::swig-lispify "btSliderConstraint_calculateSerializeBufferSize" 'function))
(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btSliderConstraint_serialize" 'function)))
(cffi:defcfun ("_wrap_btSliderConstraint_serialize" #.(bullet-wrap::swig-lispify "btSliderConstraint_serialize" 'function)) :string
  (dataBuffer :pointer)
  (serializer :pointer))
(cl:export '#.(bullet-wrap::swig-lispify "btSliderConstraint_serialize" 'function))
(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "delete_btSliderConstraint" 'function)))
(cffi:defcfun ("_wrap_delete_btSliderConstraint" #.(bullet-wrap::swig-lispify "delete_btSliderConstraint" 'function)) :void
  (self :pointer))
(cl:export '#.(bullet-wrap::swig-lispify "delete_btSliderConstraint" 'function))
(cffi:defcstruct #.(bullet-wrap::swig-lispify "btSliderConstraintData" 'classname)
	(#.(bullet-wrap::swig-lispify "m_typeConstraintData" 'slotname) #.(bullet-wrap::swig-lispify "btTypedConstraintData" 'classname))
	(#.(bullet-wrap::swig-lispify "m_rbAFrame" 'slotname) #.(bullet-wrap::swig-lispify "btTransformFloatData" 'classname))
	(#.(bullet-wrap::swig-lispify "m_rbBFrame" 'slotname) #.(bullet-wrap::swig-lispify "btTransformFloatData" 'classname))
	(#.(bullet-wrap::swig-lispify "m_linearUpperLimit" 'slotname) :float)
	(#.(bullet-wrap::swig-lispify "m_linearLowerLimit" 'slotname) :float)
	(#.(bullet-wrap::swig-lispify "m_angularUpperLimit" 'slotname) :float)
	(#.(bullet-wrap::swig-lispify "m_angularLowerLimit" 'slotname) :float)
	(#.(bullet-wrap::swig-lispify "m_useLinearReferenceFrameA" 'slotname) :int)
	(#.(bullet-wrap::swig-lispify "m_useOffsetForConstraintFrame" 'slotname) :int))
(cl:export '#.(bullet-wrap::swig-lispify "btSliderConstraintData" 'classname))
(cl:export '#.(bullet-wrap::swig-lispify "m_typeConstraintData" 'slotname))
(cl:export '#.(bullet-wrap::swig-lispify "m_rbAFrame" 'slotname))
(cl:export '#.(bullet-wrap::swig-lispify "m_rbBFrame" 'slotname))
(cl:export '#.(bullet-wrap::swig-lispify "m_linearUpperLimit" 'slotname))
(cl:export '#.(bullet-wrap::swig-lispify "m_linearLowerLimit" 'slotname))
(cl:export '#.(bullet-wrap::swig-lispify "m_angularUpperLimit" 'slotname))
(cl:export '#.(bullet-wrap::swig-lispify "m_angularLowerLimit" 'slotname))
(cl:export '#.(bullet-wrap::swig-lispify "m_useLinearReferenceFrameA" 'slotname))
(cl:export '#.(bullet-wrap::swig-lispify "m_useOffsetForConstraintFrame" 'slotname))
(cffi:defcstruct #.(bullet-wrap::swig-lispify "btSliderConstraintDoubleData" 'classname)
	(#.(bullet-wrap::swig-lispify "m_typeConstraintData" 'slotname) #.(bullet-wrap::swig-lispify "btTypedConstraintDoubleData" 'classname))
	(#.(bullet-wrap::swig-lispify "m_rbAFrame" 'slotname) #.(bullet-wrap::swig-lispify "btTransformDoubleData" 'classname))
	(#.(bullet-wrap::swig-lispify "m_rbBFrame" 'slotname) #.(bullet-wrap::swig-lispify "btTransformDoubleData" 'classname))
	(#.(bullet-wrap::swig-lispify "m_linearUpperLimit" 'slotname) :double)
	(#.(bullet-wrap::swig-lispify "m_linearLowerLimit" 'slotname) :double)
	(#.(bullet-wrap::swig-lispify "m_angularUpperLimit" 'slotname) :double)
	(#.(bullet-wrap::swig-lispify "m_angularLowerLimit" 'slotname) :double)
	(#.(bullet-wrap::swig-lispify "m_useLinearReferenceFrameA" 'slotname) :int)
	(#.(bullet-wrap::swig-lispify "m_useOffsetForConstraintFrame" 'slotname) :int))
(cl:export '#.(bullet-wrap::swig-lispify "btSliderConstraintDoubleData" 'classname))
(cl:export '#.(bullet-wrap::swig-lispify "m_typeConstraintData" 'slotname))
(cl:export '#.(bullet-wrap::swig-lispify "m_rbAFrame" 'slotname))
(cl:export '#.(bullet-wrap::swig-lispify "m_rbBFrame" 'slotname))
(cl:export '#.(bullet-wrap::swig-lispify "m_linearUpperLimit" 'slotname))
(cl:export '#.(bullet-wrap::swig-lispify "m_linearLowerLimit" 'slotname))
(cl:export '#.(bullet-wrap::swig-lispify "m_angularUpperLimit" 'slotname))
(cl:export '#.(bullet-wrap::swig-lispify "m_angularLowerLimit" 'slotname))
(cl:export '#.(bullet-wrap::swig-lispify "m_useLinearReferenceFrameA" 'slotname))
(cl:export '#.(bullet-wrap::swig-lispify "m_useOffsetForConstraintFrame" 'slotname))
(cl:defconstant #.(bullet-wrap::swig-lispify "btGeneric6DofSpringConstraintDataName" 'constant) "btGeneric6DofSpringConstraintData")
(cl:export '#.(bullet-wrap::swig-lispify "btGeneric6DofSpringConstraintDataName" 'constant))
(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btGeneric6DofSpringConstraint_makeCPlusPlusInstance" 'function)))
(cffi:defcfun ("_wrap_btGeneric6DofSpringConstraint_makeCPlusPlusInstance__SWIG_0" #.(bullet-wrap::swig-lispify "btGeneric6DofSpringConstraint_makeCPlusPlusInstance" 'function)) :pointer
  (sizeInBytes :pointer))
(cl:export '#.(bullet-wrap::swig-lispify "btGeneric6DofSpringConstraint_makeCPlusPlusInstance" 'function))
(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btGeneric6DofSpringConstraint_deleteCPlusPlusInstance" 'function)))
(cffi:defcfun ("_wrap_btGeneric6DofSpringConstraint_deleteCPlusPlusInstance__SWIG_0" #.(bullet-wrap::swig-lispify "btGeneric6DofSpringConstraint_deleteCPlusPlusInstance" 'function)) :void
  (self :pointer)
  (ptr :pointer))
(cl:export '#.(bullet-wrap::swig-lispify "btGeneric6DofSpringConstraint_deleteCPlusPlusInstance" 'function))
(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btGeneric6DofSpringConstraint_makeCPlusPlusInstance" 'function)))
(cffi:defcfun ("_wrap_btGeneric6DofSpringConstraint_makeCPlusPlusInstance__SWIG_1" #.(bullet-wrap::swig-lispify "btGeneric6DofSpringConstraint_makeCPlusPlusInstance" 'function)) :pointer
  (arg1 :pointer)
  (ptr :pointer))
(cl:export '#.(bullet-wrap::swig-lispify "btGeneric6DofSpringConstraint_makeCPlusPlusInstance" 'function))
(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btGeneric6DofSpringConstraint_deleteCPlusPlusInstance" 'function)))
(cffi:defcfun ("_wrap_btGeneric6DofSpringConstraint_deleteCPlusPlusInstance__SWIG_1" #.(bullet-wrap::swig-lispify "btGeneric6DofSpringConstraint_deleteCPlusPlusInstance" 'function)) :void
  (self :pointer)
  (arg1 :pointer)
  (arg2 :pointer))
(cl:export '#.(bullet-wrap::swig-lispify "btGeneric6DofSpringConstraint_deleteCPlusPlusInstance" 'function))
(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btGeneric6DofSpringConstraint_makeCPlusArray" 'function)))
(cffi:defcfun ("_wrap_btGeneric6DofSpringConstraint_makeCPlusArray__SWIG_0" #.(bullet-wrap::swig-lispify "btGeneric6DofSpringConstraint_makeCPlusArray" 'function)) :pointer
  (sizeInBytes :pointer))
(cl:export '#.(bullet-wrap::swig-lispify "btGeneric6DofSpringConstraint_makeCPlusArray" 'function))
(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btGeneric6DofSpringConstraint_deleteCPlusArray" 'function)))
(cffi:defcfun ("_wrap_btGeneric6DofSpringConstraint_deleteCPlusArray__SWIG_0" #.(bullet-wrap::swig-lispify "btGeneric6DofSpringConstraint_deleteCPlusArray" 'function)) :void
  (self :pointer)
  (ptr :pointer))
(cl:export '#.(bullet-wrap::swig-lispify "btGeneric6DofSpringConstraint_deleteCPlusArray" 'function))
(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btGeneric6DofSpringConstraint_makeCPlusArray" 'function)))
(cffi:defcfun ("_wrap_btGeneric6DofSpringConstraint_makeCPlusArray__SWIG_1" #.(bullet-wrap::swig-lispify "btGeneric6DofSpringConstraint_makeCPlusArray" 'function)) :pointer
  (self :pointer)
  (arg1 :pointer)
  (ptr :pointer))
(cl:export '#.(bullet-wrap::swig-lispify "btGeneric6DofSpringConstraint_makeCPlusArray" 'function))
(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btGeneric6DofSpringConstraint_deleteCPlusArray" 'function)))
(cffi:defcfun ("_wrap_btGeneric6DofSpringConstraint_deleteCPlusArray__SWIG_1" #.(bullet-wrap::swig-lispify "btGeneric6DofSpringConstraint_deleteCPlusArray" 'function)) :void
  (arg1 :pointer)
  (arg2 :pointer))
(cl:export '#.(bullet-wrap::swig-lispify "btGeneric6DofSpringConstraint_deleteCPlusArray" 'function))
(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "new_btGeneric6DofSpringConstraint" 'function)))
(cffi:defcfun ("_wrap_new_btGeneric6DofSpringConstraint__SWIG_0" #.(bullet-wrap::swig-lispify "new_btGeneric6DofSpringConstraint" 'function)) :pointer
  (rbA :pointer)
  (rbB :pointer)
  (frameInA :pointer)
  (frameInB :pointer)
  (useLinearReferenceFrameA :pointer))
(cl:export '#.(bullet-wrap::swig-lispify "new_btGeneric6DofSpringConstraint" 'function))
(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "new_btGeneric6DofSpringConstraint" 'function)))
(cffi:defcfun ("_wrap_new_btGeneric6DofSpringConstraint__SWIG_1" #.(bullet-wrap::swig-lispify "new_btGeneric6DofSpringConstraint" 'function)) :pointer
  (rbB :pointer)
  (frameInB :pointer)
  (useLinearReferenceFrameB :pointer))
(cl:export '#.(bullet-wrap::swig-lispify "new_btGeneric6DofSpringConstraint" 'function))
(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btGeneric6DofSpringConstraint_enableSpring" 'function)))
(cffi:defcfun ("_wrap_btGeneric6DofSpringConstraint_enableSpring" #.(bullet-wrap::swig-lispify "btGeneric6DofSpringConstraint_enableSpring" 'function)) :void
  (index :int)
  (onOff :pointer))
(cl:export '#.(bullet-wrap::swig-lispify "btGeneric6DofSpringConstraint_enableSpring" 'function))
(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btGeneric6DofSpringConstraint_setStiffness" 'function)))
(cffi:defcfun ("_wrap_btGeneric6DofSpringConstraint_setStiffness" #.(bullet-wrap::swig-lispify "btGeneric6DofSpringConstraint_setStiffness" 'function)) :void
  (index :int)
  (stiffness :float))
(cl:export '#.(bullet-wrap::swig-lispify "btGeneric6DofSpringConstraint_setStiffness" 'function))
(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btGeneric6DofSpringConstraint_setDamping" 'function)))
(cffi:defcfun ("_wrap_btGeneric6DofSpringConstraint_setDamping" #.(bullet-wrap::swig-lispify "btGeneric6DofSpringConstraint_setDamping" 'function)) :void
  (self :pointer)
  (index :int)
  (damping :float))
(cl:export '#.(bullet-wrap::swig-lispify "btGeneric6DofSpringConstraint_setDamping" 'function))
(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btGeneric6DofSpringConstraint_setEquilibriumPoint" 'function)))
(cffi:defcfun ("_wrap_btGeneric6DofSpringConstraint_setEquilibriumPoint__SWIG_0" #.(bullet-wrap::swig-lispify "btGeneric6DofSpringConstraint_setEquilibriumPoint" 'function)) :void
  (self :pointer))
(cl:export '#.(bullet-wrap::swig-lispify "btGeneric6DofSpringConstraint_setEquilibriumPoint" 'function))
(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btGeneric6DofSpringConstraint_setEquilibriumPoint" 'function)))
(cffi:defcfun ("_wrap_btGeneric6DofSpringConstraint_setEquilibriumPoint__SWIG_1" #.(bullet-wrap::swig-lispify "btGeneric6DofSpringConstraint_setEquilibriumPoint" 'function)) :void
  (self :pointer)
  (index :int))
(cl:export '#.(bullet-wrap::swig-lispify "btGeneric6DofSpringConstraint_setEquilibriumPoint" 'function))
(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btGeneric6DofSpringConstraint_setEquilibriumPoint" 'function)))
(cffi:defcfun ("_wrap_btGeneric6DofSpringConstraint_setEquilibriumPoint__SWIG_2" #.(bullet-wrap::swig-lispify "btGeneric6DofSpringConstraint_setEquilibriumPoint" 'function)) :void
  (index :int)
  (val :float))
(cl:export '#.(bullet-wrap::swig-lispify "btGeneric6DofSpringConstraint_setEquilibriumPoint" 'function))
(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btGeneric6DofSpringConstraint_setAxis" 'function)))
(cffi:defcfun ("_wrap_btGeneric6DofSpringConstraint_setAxis" #.(bullet-wrap::swig-lispify "btGeneric6DofSpringConstraint_setAxis" 'function)) :void
  (axis1 :pointer)
  (axis2 :pointer))
(cl:export '#.(bullet-wrap::swig-lispify "btGeneric6DofSpringConstraint_setAxis" 'function))
(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btGeneric6DofSpringConstraint_getInfo2" 'function)))
(cffi:defcfun ("_wrap_btGeneric6DofSpringConstraint_getInfo2" #.(bullet-wrap::swig-lispify "btGeneric6DofSpringConstraint_getInfo2" 'function)) :void
  (self :pointer)
  (info :pointer))
(cl:export '#.(bullet-wrap::swig-lispify "btGeneric6DofSpringConstraint_getInfo2" 'function))
(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btGeneric6DofSpringConstraint_calculateSerializeBufferSize" 'function)))
(cffi:defcfun ("_wrap_btGeneric6DofSpringConstraint_calculateSerializeBufferSize" #.(bullet-wrap::swig-lispify "btGeneric6DofSpringConstraint_calculateSerializeBufferSize" 'function)) :int
  (self :pointer))
(cl:export '#.(bullet-wrap::swig-lispify "btGeneric6DofSpringConstraint_calculateSerializeBufferSize" 'function))
(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btGeneric6DofSpringConstraint_serialize" 'function)))
(cffi:defcfun ("_wrap_btGeneric6DofSpringConstraint_serialize" #.(bullet-wrap::swig-lispify "btGeneric6DofSpringConstraint_serialize" 'function)) :string
  (self :pointer)
  (dataBuffer :pointer)
  (serializer :pointer))
(cl:export '#.(bullet-wrap::swig-lispify "btGeneric6DofSpringConstraint_serialize" 'function))
(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "delete_btGeneric6DofSpringConstraint" 'function)))
(cffi:defcfun ("_wrap_delete_btGeneric6DofSpringConstraint" #.(bullet-wrap::swig-lispify "delete_btGeneric6DofSpringConstraint" 'function)) :void
  (self :pointer))
(cl:export '#.(bullet-wrap::swig-lispify "delete_btGeneric6DofSpringConstraint" 'function))
(cffi:defcstruct #.(bullet-wrap::swig-lispify "btGeneric6DofSpringConstraintData" 'classname)
	(#.(bullet-wrap::swig-lispify "m_6dofData" 'slotname) #.(bullet-wrap::swig-lispify "btGeneric6DofConstraintData" 'classname))
	(#.(bullet-wrap::swig-lispify "m_springEnabled" 'slotname) :pointer)
	(#.(bullet-wrap::swig-lispify "m_equilibriumPoint" 'slotname) :pointer)
	(#.(bullet-wrap::swig-lispify "m_springStiffness" 'slotname) :pointer)
	(#.(bullet-wrap::swig-lispify "m_springDamping" 'slotname) :pointer))
(cl:export '#.(bullet-wrap::swig-lispify "btGeneric6DofSpringConstraintData" 'classname))
(cl:export '#.(bullet-wrap::swig-lispify "m_6dofData" 'slotname))
(cl:export '#.(bullet-wrap::swig-lispify "m_springEnabled" 'slotname))
(cl:export '#.(bullet-wrap::swig-lispify "m_equilibriumPoint" 'slotname))
(cl:export '#.(bullet-wrap::swig-lispify "m_springStiffness" 'slotname))
(cl:export '#.(bullet-wrap::swig-lispify "m_springDamping" 'slotname))
(cffi:defcstruct #.(bullet-wrap::swig-lispify "btGeneric6DofSpringConstraintDoubleData2" 'classname)
	(#.(bullet-wrap::swig-lispify "m_6dofData" 'slotname) #.(bullet-wrap::swig-lispify "btGeneric6DofConstraintDoubleData2" 'classname))
	(#.(bullet-wrap::swig-lispify "m_springEnabled" 'slotname) :pointer)
	(#.(bullet-wrap::swig-lispify "m_equilibriumPoint" 'slotname) :pointer)
	(#.(bullet-wrap::swig-lispify "m_springStiffness" 'slotname) :pointer)
	(#.(bullet-wrap::swig-lispify "m_springDamping" 'slotname) :pointer))
(cl:export '#.(bullet-wrap::swig-lispify "btGeneric6DofSpringConstraintDoubleData2" 'classname))
(cl:export '#.(bullet-wrap::swig-lispify "m_6dofData" 'slotname))
(cl:export '#.(bullet-wrap::swig-lispify "m_springEnabled" 'slotname))
(cl:export '#.(bullet-wrap::swig-lispify "m_equilibriumPoint" 'slotname))
(cl:export '#.(bullet-wrap::swig-lispify "m_springStiffness" 'slotname))
(cl:export '#.(bullet-wrap::swig-lispify "m_springDamping" 'slotname))
(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btUniversalConstraint_makeCPlusPlusInstance" 'function)))
(cffi:defcfun ("_wrap_btUniversalConstraint_makeCPlusPlusInstance__SWIG_0" #.(bullet-wrap::swig-lispify "btUniversalConstraint_makeCPlusPlusInstance" 'function)) :pointer
  (self :pointer)
  (sizeInBytes :pointer))
(cl:export '#.(bullet-wrap::swig-lispify "btUniversalConstraint_makeCPlusPlusInstance" 'function))
(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btUniversalConstraint_deleteCPlusPlusInstance" 'function)))
(cffi:defcfun ("_wrap_btUniversalConstraint_deleteCPlusPlusInstance__SWIG_0" #.(bullet-wrap::swig-lispify "btUniversalConstraint_deleteCPlusPlusInstance" 'function)) :void
  (self :pointer)
  (ptr :pointer))
(cl:export '#.(bullet-wrap::swig-lispify "btUniversalConstraint_deleteCPlusPlusInstance" 'function))
(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btUniversalConstraint_makeCPlusPlusInstance" 'function)))
(cffi:defcfun ("_wrap_btUniversalConstraint_makeCPlusPlusInstance__SWIG_1" #.(bullet-wrap::swig-lispify "btUniversalConstraint_makeCPlusPlusInstance" 'function)) :pointer
  (self :pointer)
  (arg1 :pointer)
  (ptr :pointer))
(cl:export '#.(bullet-wrap::swig-lispify "btUniversalConstraint_makeCPlusPlusInstance" 'function))
(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btUniversalConstraint_deleteCPlusPlusInstance" 'function)))
(cffi:defcfun ("_wrap_btUniversalConstraint_deleteCPlusPlusInstance__SWIG_1" #.(bullet-wrap::swig-lispify "btUniversalConstraint_deleteCPlusPlusInstance" 'function)) :void
  (self :pointer)
  (arg1 :pointer)
  (arg2 :pointer))
(cl:export '#.(bullet-wrap::swig-lispify "btUniversalConstraint_deleteCPlusPlusInstance" 'function))
(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btUniversalConstraint_makeCPlusArray" 'function)))
(cffi:defcfun ("_wrap_btUniversalConstraint_makeCPlusArray__SWIG_0" #.(bullet-wrap::swig-lispify "btUniversalConstraint_makeCPlusArray" 'function)) :pointer
  (self :pointer)
  (sizeInBytes :pointer))
(cl:export '#.(bullet-wrap::swig-lispify "btUniversalConstraint_makeCPlusArray" 'function))
(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btUniversalConstraint_deleteCPlusArray" 'function)))
(cffi:defcfun ("_wrap_btUniversalConstraint_deleteCPlusArray__SWIG_0" #.(bullet-wrap::swig-lispify "btUniversalConstraint_deleteCPlusArray" 'function)) :void
  (self :pointer)
  (ptr :pointer))
(cl:export '#.(bullet-wrap::swig-lispify "btUniversalConstraint_deleteCPlusArray" 'function))
(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btUniversalConstraint_makeCPlusArray" 'function)))
(cffi:defcfun ("_wrap_btUniversalConstraint_makeCPlusArray__SWIG_1" #.(bullet-wrap::swig-lispify "btUniversalConstraint_makeCPlusArray" 'function)) :pointer
  (self :pointer)
  (arg1 :pointer)
  (ptr :pointer))
(cl:export '#.(bullet-wrap::swig-lispify "btUniversalConstraint_makeCPlusArray" 'function))
(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btUniversalConstraint_deleteCPlusArray" 'function)))
(cffi:defcfun ("_wrap_btUniversalConstraint_deleteCPlusArray__SWIG_1" #.(bullet-wrap::swig-lispify "btUniversalConstraint_deleteCPlusArray" 'function)) :void
  (self :pointer)
  (arg1 :pointer)
  (arg2 :pointer))
(cl:export '#.(bullet-wrap::swig-lispify "btUniversalConstraint_deleteCPlusArray" 'function))
(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "new_btUniversalConstraint" 'function)))
(cffi:defcfun ("_wrap_new_btUniversalConstraint" #.(bullet-wrap::swig-lispify "new_btUniversalConstraint" 'function)) :pointer
  (rbA :pointer)
  (rbB :pointer)
  (anchor :pointer)
  (axis1 :pointer)
  (axis2 :pointer))
(cl:export '#.(bullet-wrap::swig-lispify "new_btUniversalConstraint" 'function))
(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btUniversalConstraint_getAnchor" 'function)))
(cffi:defcfun ("_wrap_btUniversalConstraint_getAnchor" #.(bullet-wrap::swig-lispify "btUniversalConstraint_getAnchor" 'function)) :pointer
  (self :pointer))
(cl:export '#.(bullet-wrap::swig-lispify "btUniversalConstraint_getAnchor" 'function))
(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btUniversalConstraint_getAnchor2" 'function)))
(cffi:defcfun ("_wrap_btUniversalConstraint_getAnchor2" #.(bullet-wrap::swig-lispify "btUniversalConstraint_getAnchor2" 'function)) :pointer
  (self :pointer))
(cl:export '#.(bullet-wrap::swig-lispify "btUniversalConstraint_getAnchor2" 'function))
(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btUniversalConstraint_getAxis1" 'function)))
(cffi:defcfun ("_wrap_btUniversalConstraint_getAxis1" #.(bullet-wrap::swig-lispify "btUniversalConstraint_getAxis1" 'function)) :pointer
  (self :pointer))
(cl:export '#.(bullet-wrap::swig-lispify "btUniversalConstraint_getAxis1" 'function))
(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btUniversalConstraint_getAxis2" 'function)))
(cffi:defcfun ("_wrap_btUniversalConstraint_getAxis2" #.(bullet-wrap::swig-lispify "btUniversalConstraint_getAxis2" 'function)) :pointer
  (self :pointer))
(cl:export '#.(bullet-wrap::swig-lispify "btUniversalConstraint_getAxis2" 'function))
(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btUniversalConstraint_getAngle1" 'function)))
(cffi:defcfun ("_wrap_btUniversalConstraint_getAngle1" #.(bullet-wrap::swig-lispify "btUniversalConstraint_getAngle1" 'function)) :float
  (self :pointer))
(cl:export '#.(bullet-wrap::swig-lispify "btUniversalConstraint_getAngle1" 'function))
(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btUniversalConstraint_getAngle2" 'function)))

(cffi:defcfun ("_wrap_btUniversalConstraint_getAngle2" #.(bullet-wrap::swig-lispify "btUniversalConstraint_getAngle2" 'function)) :float
(cl:export '#.(bullet-wrap::swig-lispify "btUniversalConstraint_getAngle2" 'function))
(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btUniversalConstraint_setUpperLimit" 'function)))
(cffi:defcfun ("_wrap_btUniversalConstraint_setUpperLimit" #.(bullet-wrap::swig-lispify "btUniversalConstraint_setUpperLimit" 'function)) :void
  (ang1max :float)
  (ang2max :float))
(cl:export '#.(bullet-wrap::swig-lispify "btUniversalConstraint_setUpperLimit" 'function))
(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btUniversalConstraint_setLowerLimit" 'function)))
(cffi:defcfun ("_wrap_btUniversalConstraint_setLowerLimit" #.(bullet-wrap::swig-lispify "btUniversalConstraint_setLowerLimit" 'function)) :void
  (ang1min :float)
  (ang2min :float))
(cl:export '#.(bullet-wrap::swig-lispify "btUniversalConstraint_setLowerLimit" 'function))
(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btUniversalConstraint_setAxis" 'function)))
(cffi:defcfun ("_wrap_btUniversalConstraint_setAxis" #.(bullet-wrap::swig-lispify "btUniversalConstraint_setAxis" 'function)) :void
  (axis1 :pointer)
  (axis2 :pointer))
(cl:export '#.(bullet-wrap::swig-lispify "btUniversalConstraint_setAxis" 'function))
(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "delete_btUniversalConstraint" 'function)))
(cffi:defcfun ("_wrap_delete_btUniversalConstraint" #.(bullet-wrap::swig-lispify "delete_btUniversalConstraint" 'function)) :void
(cl:export '#.(bullet-wrap::swig-lispify "delete_btUniversalConstraint" 'function))
(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btHinge2Constraint_makeCPlusPlusInstance" 'function)))
(cffi:defcfun ("_wrap_btHinge2Constraint_makeCPlusPlusInstance__SWIG_0" #.(bullet-wrap::swig-lispify "btHinge2Constraint_makeCPlusPlusInstance" 'function)) :pointer
  (sizeInBytes :pointer))
(cl:export '#.(bullet-wrap::swig-lispify "btHinge2Constraint_makeCPlusPlusInstance" 'function))
(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btHinge2Constraint_deleteCPlusPlusInstance" 'function)))
(cffi:defcfun ("_wrap_btHinge2Constraint_deleteCPlusPlusInstance__SWIG_0" #.(bullet-wrap::swig-lispify "btHinge2Constraint_deleteCPlusPlusInstance" 'function)) :void
  (ptr :pointer))
(cl:export '#.(bullet-wrap::swig-lispify "btHinge2Constraint_deleteCPlusPlusInstance" 'function))
(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btHinge2Constraint_makeCPlusPlusInstance" 'function)))
(cffi:defcfun ("_wrap_btHinge2Constraint_makeCPlusPlusInstance__SWIG_1" #.(bullet-wrap::swig-lispify "btHinge2Constraint_makeCPlusPlusInstance" 'function)) :pointer
  (arg1 :pointer)
  (ptr :pointer))
(cl:export '#.(bullet-wrap::swig-lispify "btHinge2Constraint_makeCPlusPlusInstance" 'function))
(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btHinge2Constraint_deleteCPlusPlusInstance" 'function)))
(cffi:defcfun ("_wrap_btHinge2Constraint_deleteCPlusPlusInstance__SWIG_1" #.(bullet-wrap::swig-lispify "btHinge2Constraint_deleteCPlusPlusInstance" 'function)) :void
  (arg1 :pointer)
  (arg2 :pointer))
(cl:export '#.(bullet-wrap::swig-lispify "btHinge2Constraint_deleteCPlusPlusInstance" 'function))
(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btHinge2Constraint_makeCPlusArray" 'function)))
(cffi:defcfun ("_wrap_btHinge2Constraint_makeCPlusArray__SWIG_0" #.(bullet-wrap::swig-lispify "btHinge2Constraint_makeCPlusArray" 'function)) :pointer
  (sizeInBytes :pointer))
(cl:export '#.(bullet-wrap::swig-lispify "btHinge2Constraint_makeCPlusArray" 'function))
(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btHinge2Constraint_deleteCPlusArray" 'function)))
(cffi:defcfun ("_wrap_btHinge2Constraint_deleteCPlusArray__SWIG_0" #.(bullet-wrap::swig-lispify "btHinge2Constraint_deleteCPlusArray" 'function)) :void
  (ptr :pointer))
(cl:export '#.(bullet-wrap::swig-lispify "btHinge2Constraint_deleteCPlusArray" 'function))
(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btHinge2Constraint_makeCPlusArray" 'function)))
(cffi:defcfun ("_wrap_btHinge2Constraint_makeCPlusArray__SWIG_1" #.(bullet-wrap::swig-lispify "btHinge2Constraint_makeCPlusArray" 'function)) :pointer
  (self :pointer)
  (arg1 :pointer)
  (ptr :pointer))
(cl:export '#.(bullet-wrap::swig-lispify "btHinge2Constraint_makeCPlusArray" 'function))
(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btHinge2Constraint_deleteCPlusArray" 'function)))
(cffi:defcfun ("_wrap_btHinge2Constraint_deleteCPlusArray__SWIG_1" #.(bullet-wrap::swig-lispify "btHinge2Constraint_deleteCPlusArray" 'function)) :void
  (self :pointer)
  (arg1 :pointer)
  (arg2 :pointer))
(cl:export '#.(bullet-wrap::swig-lispify "btHinge2Constraint_deleteCPlusArray" 'function))
(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "new_btHinge2Constraint" 'function)))
(cffi:defcfun ("_wrap_new_btHinge2Constraint" #.(bullet-wrap::swig-lispify "new_btHinge2Constraint" 'function)) :pointer
  (rbA :pointer)
  (rbB :pointer)
  (anchor :pointer)
  (axis1 :pointer)
  (axis2 :pointer))

(cl:export '#.(bullet-wrap::swig-lispify "new_btHinge2Constraint" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btHinge2Constraint_getAnchor" 'function)))

(cffi:defcfun ("_wrap_btHinge2Constraint_getAnchor" #.(bullet-wrap::swig-lispify "btHinge2Constraint_getAnchor" 'function)) :pointer
(cl:export '#.(bullet-wrap::swig-lispify "btHinge2Constraint_getAnchor" 'function))
(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btHinge2Constraint_getAnchor2" 'function)))
(cffi:defcfun ("_wrap_btHinge2Constraint_getAnchor2" #.(bullet-wrap::swig-lispify "btHinge2Constraint_getAnchor2" 'function)) :pointer
  (self :pointer))
(cl:export '#.(bullet-wrap::swig-lispify "btHinge2Constraint_getAnchor2" 'function))
(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btHinge2Constraint_getAxis1" 'function)))
(cffi:defcfun ("_wrap_btHinge2Constraint_getAxis1" #.(bullet-wrap::swig-lispify "btHinge2Constraint_getAxis1" 'function)) :pointer
(cl:export '#.(bullet-wrap::swig-lispify "btHinge2Constraint_getAxis1" 'function))
(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btHinge2Constraint_getAxis2" 'function)))
(cffi:defcfun ("_wrap_btHinge2Constraint_getAxis2" #.(bullet-wrap::swig-lispify "btHinge2Constraint_getAxis2" 'function)) :pointer
  (self :pointer))
(cl:export '#.(bullet-wrap::swig-lispify "btHinge2Constraint_getAxis2" 'function))
(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btHinge2Constraint_getAngle1" 'function)))
(cffi:defcfun ("_wrap_btHinge2Constraint_getAngle1" #.(bullet-wrap::swig-lispify "btHinge2Constraint_getAngle1" 'function)) :float
  (self :pointer))
(cl:export '#.(bullet-wrap::swig-lispify "btHinge2Constraint_getAngle1" 'function))
(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btHinge2Constraint_getAngle2" 'function)))
(cffi:defcfun ("_wrap_btHinge2Constraint_getAngle2" #.(bullet-wrap::swig-lispify "btHinge2Constraint_getAngle2" 'function)) :float
  (self :pointer))
(cl:export '#.(bullet-wrap::swig-lispify "btHinge2Constraint_getAngle2" 'function))
(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btHinge2Constraint_setUpperLimit" 'function)))
(cffi:defcfun ("_wrap_btHinge2Constraint_setUpperLimit" #.(bullet-wrap::swig-lispify "btHinge2Constraint_setUpperLimit" 'function)) :void
  (ang1max :float))
(cl:export '#.(bullet-wrap::swig-lispify "btHinge2Constraint_setUpperLimit" 'function))
(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btHinge2Constraint_setLowerLimit" 'function)))
(cffi:defcfun ("_wrap_btHinge2Constraint_setLowerLimit" #.(bullet-wrap::swig-lispify "btHinge2Constraint_setLowerLimit" 'function)) :void
  (ang1min :float))
(cl:export '#.(bullet-wrap::swig-lispify "btHinge2Constraint_setLowerLimit" 'function))
(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "delete_btHinge2Constraint" 'function)))
(cffi:defcfun ("_wrap_delete_btHinge2Constraint" #.(bullet-wrap::swig-lispify "delete_btHinge2Constraint" 'function)) :void
  (self :pointer))
(cl:export '#.(bullet-wrap::swig-lispify "delete_btHinge2Constraint" 'function))
(cl:defconstant #.(bullet-wrap::swig-lispify "btGearConstraintDataName" 'constant) "btGearConstraintFloatData")
(cl:export '#.(bullet-wrap::swig-lispify "btGearConstraintDataName" 'constant))
(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "new_btGearConstraint" 'function)))
(cffi:defcfun ("_wrap_new_btGearConstraint__SWIG_0" #.(bullet-wrap::swig-lispify "new_btGearConstraint" 'function)) :pointer
  (rbA :pointer)
  (rbB :pointer)
  (axisInA :pointer)
  (axisInB :pointer)
  (ratio :float))
(cl:export '#.(bullet-wrap::swig-lispify "new_btGearConstraint" 'function))
(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "new_btGearConstraint" 'function)))
(cffi:defcfun ("_wrap_new_btGearConstraint__SWIG_1" #.(bullet-wrap::swig-lispify "new_btGearConstraint" 'function)) :pointer
  (rbA :pointer)
  (rbB :pointer)
  (axisInA :pointer)
  (axisInB :pointer))
(cl:export '#.(bullet-wrap::swig-lispify "new_btGearConstraint" 'function))

(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "delete_btGearConstraint" 'function)))

(cffi:defcfun ("_wrap_delete_btGearConstraint" #.(bullet-wrap::swig-lispify "delete_btGearConstraint" 'function)) :void
(cl:export '#.(bullet-wrap::swig-lispify "delete_btGearConstraint" 'function))
(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btGearConstraint_getInfo1" 'function)))
(cffi:defcfun ("_wrap_btGearConstraint_getInfo1" #.(bullet-wrap::swig-lispify "btGearConstraint_getInfo1" 'function)) :void
  (info :pointer))
(cl:export '#.(bullet-wrap::swig-lispify "btGearConstraint_getInfo1" 'function))
(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btGearConstraint_getInfo2" 'function)))
(cffi:defcfun ("_wrap_btGearConstraint_getInfo2" #.(bullet-wrap::swig-lispify "btGearConstraint_getInfo2" 'function)) :void
  (self :pointer)
  (info :pointer))
(cl:export '#.(bullet-wrap::swig-lispify "btGearConstraint_getInfo2" 'function))
(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btGearConstraint_setAxisA" 'function)))
(cffi:defcfun ("_wrap_btGearConstraint_setAxisA" #.(bullet-wrap::swig-lispify "btGearConstraint_setAxisA" 'function)) :void
  (self :pointer)
  (axisA :pointer))
(cl:export '#.(bullet-wrap::swig-lispify "btGearConstraint_setAxisA" 'function))
(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btGearConstraint_setAxisB" 'function)))
(cffi:defcfun ("_wrap_btGearConstraint_setAxisB" #.(bullet-wrap::swig-lispify "btGearConstraint_setAxisB" 'function)) :void
  (axisB :pointer))
(cl:export '#.(bullet-wrap::swig-lispify "btGearConstraint_setAxisB" 'function))
(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btGearConstraint_setRatio" 'function)))
(cffi:defcfun ("_wrap_btGearConstraint_setRatio" #.(bullet-wrap::swig-lispify "btGearConstraint_setRatio" 'function)) :void
  (ratio :float))
(cl:export '#.(bullet-wrap::swig-lispify "btGearConstraint_setRatio" 'function))
(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btGearConstraint_getAxisA" 'function)))
(cffi:defcfun ("_wrap_btGearConstraint_getAxisA" #.(bullet-wrap::swig-lispify "btGearConstraint_getAxisA" 'function)) :pointer
(cl:export '#.(bullet-wrap::swig-lispify "btGearConstraint_getAxisA" 'function))
(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btGearConstraint_getAxisB" 'function)))
(cffi:defcfun ("_wrap_btGearConstraint_getAxisB" #.(bullet-wrap::swig-lispify "btGearConstraint_getAxisB" 'function)) :pointer
(cl:export '#.(bullet-wrap::swig-lispify "btGearConstraint_getAxisB" 'function))
(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btGearConstraint_getRatio" 'function)))
(cffi:defcfun ("_wrap_btGearConstraint_getRatio" #.(bullet-wrap::swig-lispify "btGearConstraint_getRatio" 'function)) :float
(cl:export '#.(bullet-wrap::swig-lispify "btGearConstraint_getRatio" 'function))
(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btGearConstraint_setParam" 'function)))
(cffi:defcfun ("_wrap_btGearConstraint_setParam__SWIG_0" #.(bullet-wrap::swig-lispify "btGearConstraint_setParam" 'function)) :void
  (num :int)
  (value :float)
  (axis :int))
(cl:export '#.(bullet-wrap::swig-lispify "btGearConstraint_setParam" 'function))
(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btGearConstraint_setParam" 'function)))
(cffi:defcfun ("_wrap_btGearConstraint_setParam__SWIG_1" #.(bullet-wrap::swig-lispify "btGearConstraint_setParam" 'function)) :void
  (num :int)
  (value :float))
(cl:export '#.(bullet-wrap::swig-lispify "btGearConstraint_setParam" 'function))
(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btGearConstraint_getParam" 'function)))
(cffi:defcfun ("_wrap_btGearConstraint_getParam__SWIG_0" #.(bullet-wrap::swig-lispify "btGearConstraint_getParam" 'function)) :float
  (num :int)
  (axis :int))
(cl:export '#.(bullet-wrap::swig-lispify "btGearConstraint_getParam" 'function))
(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btGearConstraint_getParam" 'function)))
(cffi:defcfun ("_wrap_btGearConstraint_getParam__SWIG_1" #.(bullet-wrap::swig-lispify "btGearConstraint_getParam" 'function)) :float
  (num :int))
(cl:export '#.(bullet-wrap::swig-lispify "btGearConstraint_getParam" 'function))
(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btGearConstraint_calculateSerializeBufferSize" 'function)))
(cffi:defcfun ("_wrap_btGearConstraint_calculateSerializeBufferSize" #.(bullet-wrap::swig-lispify "btGearConstraint_calculateSerializeBufferSize" 'function)) :int
  (self :pointer))
(cl:export '#.(bullet-wrap::swig-lispify "btGearConstraint_calculateSerializeBufferSize" 'function))
(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btGearConstraint_serialize" 'function)))
(cffi:defcfun ("_wrap_btGearConstraint_serialize" #.(bullet-wrap::swig-lispify "btGearConstraint_serialize" 'function)) :string
  (dataBuffer :pointer)
  (serializer :pointer))
(cl:export '#.(bullet-wrap::swig-lispify "btGearConstraint_serialize" 'function))
(cffi:defcstruct #.(bullet-wrap::swig-lispify "btGearConstraintFloatData" 'classname)
	(#.(bullet-wrap::swig-lispify "m_typeConstraintData" 'slotname) #.(bullet-wrap::swig-lispify "btTypedConstraintFloatData" 'classname))
	(#.(bullet-wrap::swig-lispify "m_axisInA" 'slotname) #.(bullet-wrap::swig-lispify "btVector3FloatData" 'classname))
	(#.(bullet-wrap::swig-lispify "m_axisInB" 'slotname) #.(bullet-wrap::swig-lispify "btVector3FloatData" 'classname))
	(#.(bullet-wrap::swig-lispify "m_ratio" 'slotname) :float)
	(#.(bullet-wrap::swig-lispify "m_padding" 'slotname) :pointer))
(cl:export '#.(bullet-wrap::swig-lispify "btGearConstraintFloatData" 'classname))
(cl:export '#.(bullet-wrap::swig-lispify "m_typeConstraintData" 'slotname))
(cl:export '#.(bullet-wrap::swig-lispify "m_axisInA" 'slotname))
(cl:export '#.(bullet-wrap::swig-lispify "m_axisInB" 'slotname))
(cl:export '#.(bullet-wrap::swig-lispify "m_ratio" 'slotname))
(cl:export '#.(bullet-wrap::swig-lispify "m_padding" 'slotname))
(cffi:defcstruct #.(bullet-wrap::swig-lispify "btGearConstraintDoubleData" 'classname)
	(#.(bullet-wrap::swig-lispify "m_typeConstraintData" 'slotname) #.(bullet-wrap::swig-lispify "btTypedConstraintDoubleData" 'classname))
	(#.(bullet-wrap::swig-lispify "m_axisInA" 'slotname) #.(bullet-wrap::swig-lispify "btVector3DoubleData" 'classname))
	(#.(bullet-wrap::swig-lispify "m_axisInB" 'slotname) #.(bullet-wrap::swig-lispify "btVector3DoubleData" 'classname))
	(#.(bullet-wrap::swig-lispify "m_ratio" 'slotname) :double))
(cl:export '#.(bullet-wrap::swig-lispify "btGearConstraintDoubleData" 'classname))
(cl:export '#.(bullet-wrap::swig-lispify "m_typeConstraintData" 'slotname))
(cl:export '#.(bullet-wrap::swig-lispify "m_axisInA" 'slotname))
(cl:export '#.(bullet-wrap::swig-lispify "m_axisInB" 'slotname))
(cl:export '#.(bullet-wrap::swig-lispify "m_ratio" 'slotname))
(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "new_btFixedConstraint" 'function)))
(cffi:defcfun ("_wrap_new_btFixedConstraint" #.(bullet-wrap::swig-lispify "new_btFixedConstraint" 'function)) :pointer
  (rbA :pointer)
  (rbB :pointer)
  (frameInA :pointer)
  (frameInB :pointer))
(cl:export '#.(bullet-wrap::swig-lispify "new_btFixedConstraint" 'function))
(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "delete_btFixedConstraint" 'function)))
(cffi:defcfun ("_wrap_delete_btFixedConstraint" #.(bullet-wrap::swig-lispify "delete_btFixedConstraint" 'function)) :void
(cl:export '#.(bullet-wrap::swig-lispify "delete_btFixedConstraint" 'function))
(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btFixedConstraint_getInfo1" 'function)))
(cffi:defcfun ("_wrap_btFixedConstraint_getInfo1" #.(bullet-wrap::swig-lispify "btFixedConstraint_getInfo1" 'function)) :void
  (self :pointer)
  (info :pointer))
(cl:export '#.(bullet-wrap::swig-lispify "btFixedConstraint_getInfo1" 'function))
(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btFixedConstraint_getInfo2" 'function)))
(cffi:defcfun ("_wrap_btFixedConstraint_getInfo2" #.(bullet-wrap::swig-lispify "btFixedConstraint_getInfo2" 'function)) :void
  (self :pointer)
  (info :pointer))
(cl:export '#.(bullet-wrap::swig-lispify "btFixedConstraint_getInfo2" 'function))
(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btFixedConstraint_setParam" 'function)))
(cffi:defcfun ("_wrap_btFixedConstraint_setParam__SWIG_0" #.(bullet-wrap::swig-lispify "btFixedConstraint_setParam" 'function)) :void
  (num :int)
  (value :float)
  (axis :int))
(cl:export '#.(bullet-wrap::swig-lispify "btFixedConstraint_setParam" 'function))
(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btFixedConstraint_setParam" 'function)))
(cffi:defcfun ("_wrap_btFixedConstraint_setParam__SWIG_1" #.(bullet-wrap::swig-lispify "btFixedConstraint_setParam" 'function)) :void
  (num :int)
  (value :float))
(cl:export '#.(bullet-wrap::swig-lispify "btFixedConstraint_setParam" 'function))
(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btFixedConstraint_getParam" 'function)))
(cffi:defcfun ("_wrap_btFixedConstraint_getParam__SWIG_0" #.(bullet-wrap::swig-lispify "btFixedConstraint_getParam" 'function)) :float
  (num :int)
  (axis :int))
(cl:export '#.(bullet-wrap::swig-lispify "btFixedConstraint_getParam" 'function))
(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btFixedConstraint_getParam" 'function)))
(cffi:defcfun ("_wrap_btFixedConstraint_getParam__SWIG_1" #.(bullet-wrap::swig-lispify "btFixedConstraint_getParam" 'function)) :float
  (num :int))
(cl:export '#.(bullet-wrap::swig-lispify "btFixedConstraint_getParam" 'function))
(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btSequentialImpulseConstraintSolver_makeCPlusPlusInstance" 'function)))
(cffi:defcfun ("_wrap_btSequentialImpulseConstraintSolver_makeCPlusPlusInstance__SWIG_0" #.(bullet-wrap::swig-lispify "btSequentialImpulseConstraintSolver_makeCPlusPlusInstance" 'function)) :pointer
  (self :pointer)
  (sizeInBytes :pointer))
(cl:export '#.(bullet-wrap::swig-lispify "btSequentialImpulseConstraintSolver_makeCPlusPlusInstance" 'function))
(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btSequentialImpulseConstraintSolver_deleteCPlusPlusInstance" 'function)))
(cffi:defcfun ("_wrap_btSequentialImpulseConstraintSolver_deleteCPlusPlusInstance__SWIG_0" #.(bullet-wrap::swig-lispify "btSequentialImpulseConstraintSolver_deleteCPlusPlusInstance" 'function)) :void
  (ptr :pointer))
(cl:export '#.(bullet-wrap::swig-lispify "btSequentialImpulseConstraintSolver_deleteCPlusPlusInstance" 'function))
(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btSequentialImpulseConstraintSolver_makeCPlusPlusInstance" 'function)))
(cffi:defcfun ("_wrap_btSequentialImpulseConstraintSolver_makeCPlusPlusInstance__SWIG_1" #.(bullet-wrap::swig-lispify "btSequentialImpulseConstraintSolver_makeCPlusPlusInstance" 'function)) :pointer
  (arg1 :pointer)
  (ptr :pointer))
(cl:export '#.(bullet-wrap::swig-lispify "btSequentialImpulseConstraintSolver_makeCPlusPlusInstance" 'function))
(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btSequentialImpulseConstraintSolver_deleteCPlusPlusInstance" 'function)))
(cffi:defcfun ("_wrap_btSequentialImpulseConstraintSolver_deleteCPlusPlusInstance__SWIG_1" #.(bullet-wrap::swig-lispify "btSequentialImpulseConstraintSolver_deleteCPlusPlusInstance" 'function)) :void
  (arg1 :pointer)
  (arg2 :pointer))
(cl:export '#.(bullet-wrap::swig-lispify "btSequentialImpulseConstraintSolver_deleteCPlusPlusInstance" 'function))
(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btSequentialImpulseConstraintSolver_makeCPlusArray" 'function)))
(cffi:defcfun ("_wrap_btSequentialImpulseConstraintSolver_makeCPlusArray__SWIG_0" #.(bullet-wrap::swig-lispify "btSequentialImpulseConstraintSolver_makeCPlusArray" 'function)) :pointer
  (self :pointer)
  (sizeInBytes :pointer))
(cl:export '#.(bullet-wrap::swig-lispify "btSequentialImpulseConstraintSolver_makeCPlusArray" 'function))
(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btSequentialImpulseConstraintSolver_deleteCPlusArray" 'function)))
(cffi:defcfun ("_wrap_btSequentialImpulseConstraintSolver_deleteCPlusArray__SWIG_0" #.(bullet-wrap::swig-lispify "btSequentialImpulseConstraintSolver_deleteCPlusArray" 'function)) :void
  (ptr :pointer))
(cl:export '#.(bullet-wrap::swig-lispify "btSequentialImpulseConstraintSolver_deleteCPlusArray" 'function))
(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btSequentialImpulseConstraintSolver_makeCPlusArray" 'function)))
(cffi:defcfun ("_wrap_btSequentialImpulseConstraintSolver_makeCPlusArray__SWIG_1" #.(bullet-wrap::swig-lispify "btSequentialImpulseConstraintSolver_makeCPlusArray" 'function)) :pointer
  (arg1 :pointer)
  (ptr :pointer))
(cl:export '#.(bullet-wrap::swig-lispify "btSequentialImpulseConstraintSolver_makeCPlusArray" 'function))
(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btSequentialImpulseConstraintSolver_deleteCPlusArray" 'function)))
(cffi:defcfun ("_wrap_btSequentialImpulseConstraintSolver_deleteCPlusArray__SWIG_1" #.(bullet-wrap::swig-lispify "btSequentialImpulseConstraintSolver_deleteCPlusArray" 'function)) :void
  (arg1 :pointer)
  (arg2 :pointer))
(cl:export '#.(bullet-wrap::swig-lispify "btSequentialImpulseConstraintSolver_deleteCPlusArray" 'function))
(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "new_btSequentialImpulseConstraintSolver" 'function)))
(cffi:defcfun ("_wrap_new_btSequentialImpulseConstraintSolver" #.(bullet-wrap::swig-lispify "new_btSequentialImpulseConstraintSolver" 'function)) :pointer)
(cl:export '#.(bullet-wrap::swig-lispify "new_btSequentialImpulseConstraintSolver" 'function))
(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "delete_btSequentialImpulseConstraintSolver" 'function)))
(cffi:defcfun ("_wrap_delete_btSequentialImpulseConstraintSolver" #.(bullet-wrap::swig-lispify "delete_btSequentialImpulseConstraintSolver" 'function)) :void
(cl:export '#.(bullet-wrap::swig-lispify "delete_btSequentialImpulseConstraintSolver" 'function))
(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btSequentialImpulseConstraintSolver_solveGroup" 'function)))
(cffi:defcfun ("_wrap_btSequentialImpulseConstraintSolver_solveGroup" #.(bullet-wrap::swig-lispify "btSequentialImpulseConstraintSolver_solveGroup" 'function)) :float
  (bodies :pointer)
  (numBodies :int)
  (manifold :pointer)
  (numManifolds :int)
  (constraints :pointer)
  (numConstraints :int)
  (info :pointer)
  (debugDrawer :pointer)
  (dispatcher :pointer))
(cl:export '#.(bullet-wrap::swig-lispify "btSequentialImpulseConstraintSolver_solveGroup" 'function))
(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btSequentialImpulseConstraintSolver_reset" 'function)))
(cffi:defcfun ("_wrap_btSequentialImpulseConstraintSolver_reset" #.(bullet-wrap::swig-lispify "btSequentialImpulseConstraintSolver_reset" 'function)) :void
(cl:export '#.(bullet-wrap::swig-lispify "btSequentialImpulseConstraintSolver_reset" 'function))
(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btSequentialImpulseConstraintSolver_btRand2" 'function)))
(cffi:defcfun ("_wrap_btSequentialImpulseConstraintSolver_btRand2" #.(bullet-wrap::swig-lispify "btSequentialImpulseConstraintSolver_btRand2" 'function)) :unsigned-long
(cl:export '#.(bullet-wrap::swig-lispify "btSequentialImpulseConstraintSolver_btRand2" 'function))
(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btSequentialImpulseConstraintSolver_btRandInt2" 'function)))
(cffi:defcfun ("_wrap_btSequentialImpulseConstraintSolver_btRandInt2" #.(bullet-wrap::swig-lispify "btSequentialImpulseConstraintSolver_btRandInt2" 'function)) :int
  (self :pointer)
  (n :int))
(cl:export '#.(bullet-wrap::swig-lispify "btSequentialImpulseConstraintSolver_btRandInt2" 'function))
(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btSequentialImpulseConstraintSolver_setRandSeed" 'function)))
(cffi:defcfun ("_wrap_btSequentialImpulseConstraintSolver_setRandSeed" #.(bullet-wrap::swig-lispify "btSequentialImpulseConstraintSolver_setRandSeed" 'function)) :void
  (self :pointer)
  (seed :unsigned-long))
(cl:export '#.(bullet-wrap::swig-lispify "btSequentialImpulseConstraintSolver_setRandSeed" 'function))
(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btSequentialImpulseConstraintSolver_getRandSeed" 'function)))
(cffi:defcfun ("_wrap_btSequentialImpulseConstraintSolver_getRandSeed" #.(bullet-wrap::swig-lispify "btSequentialImpulseConstraintSolver_getRandSeed" 'function)) :unsigned-long
  (self :pointer))
(cl:export '#.(bullet-wrap::swig-lispify "btSequentialImpulseConstraintSolver_getRandSeed" 'function))
(cl:declaim (cl:inline #.(bullet-wrap::swig-lispify "btSequentialImpulseConstraintSolver_getSolverType" 'function)))
(cffi:defcfun ("_wrap_btSequentialImpulseConstraintSolver_getSolverType" #.(bullet-wrap::swig-lispify "btSequentialImpulseConstraintSolver_getSolverType" 'function)) :pointer
  (self :pointer))
(cl:export '#.(bullet-wrap::swig-lispify "btSequentialImpulseConstraintSolver_getSolverType" 'function))
