(in-package #:bullet-physics)
(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_removeCharacter"
               DISCRETE-DYNAMICS-WORLD/REMOVE-CHARACTER) :void
  (self :pointer)
  (character :pointer))
(declaim (inline DISCRETE-DYNAMICS-WORLD/SET-SYNCHRONIZE-ALL-MOTION-STATES))
(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_setSynchronizeAllMotionStates"
               DISCRETE-DYNAMICS-WORLD/SET-SYNCHRONIZE-ALL-MOTION-STATES) :void
  (self :pointer)
  (synchronizeAll :pointer))
(declaim (inline DISCRETE-DYNAMICS-WORLD/GET-SYNCHRONIZE-ALL-MOTION-STATES))
(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_getSynchronizeAllMotionStates"
               DISCRETE-DYNAMICS-WORLD/GET-SYNCHRONIZE-ALL-MOTION-STATES) :pointer
  (self :pointer))
(declaim (inline DISCRETE-DYNAMICS-WORLD/SET-APPLY-SPECULATIVE-CONTACT-RESTITUTION))
(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_setApplySpeculativeContactRestitution"
               DISCRETE-DYNAMICS-WORLD/SET-APPLY-SPECULATIVE-CONTACT-RESTITUTION) :void
  (self :pointer)
  (enable :pointer))
(declaim (inline DISCRETE-DYNAMICS-WORLD/GET-APPLY-SPECULATIVE-CONTACT-RESTITUTION))
(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_getApplySpeculativeContactRestitution"
               DISCRETE-DYNAMICS-WORLD/GET-APPLY-SPECULATIVE-CONTACT-RESTITUTION) :pointer
  (self :pointer))
(declaim (inline DISCRETE-DYNAMICS-WORLD/SERIALIZE))
(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_serialize"
               DISCRETE-DYNAMICS-WORLD/SERIALIZE) :void
  (self :pointer)
  (serializer :pointer))
(declaim (inline DISCRETE-DYNAMICS-WORLD/SET-LATENCY-MOTION-STATE-INTERPOLATION))
(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_setLatencyMotionStateInterpolation"
               DISCRETE-DYNAMICS-WORLD/SET-LATENCY-MOTION-STATE-INTERPOLATION) :void
  (self :pointer)
  (latencyInterpolation :pointer))
(declaim (inline DISCRETE-DYNAMICS-WORLD/GET-LATENCY-MOTION-STATE-INTERPOLATION))
(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_getLatencyMotionStateInterpolation"
               DISCRETE-DYNAMICS-WORLD/GET-LATENCY-MOTION-STATE-INTERPOLATION) :pointer
  (self :pointer))
(declaim (inline MAKE-SIMPLE-DYNAMICS-WORLD))
(cffi:defcfun ("_wrap_new_btSimpleDynamicsWorld"
               MAKE-SIMPLE-DYNAMICS-WORLD) :pointer
  (dispatcher :pointer)
  (pairCache :pointer)
  (constraintSolver :pointer)
  (collisionConfiguration :pointer))
(declaim (inline DELETE/BT-SIMPLE-DYNAMICS-WORLD))
(cffi:defcfun ("_wrap_delete_btSimpleDynamicsWorld"
               DELETE/BT-SIMPLE-DYNAMICS-WORLD) :void
  (self :pointer))
(declaim (inline SIMPLE-DYNAMICS-WORLD/STEP-SIMULATION))
(cffi:defcfun ("_wrap_btSimpleDynamicsWorld_stepSimulation__SWIG_0"
               SIMPLE-DYNAMICS-WORLD/STEP-SIMULATION/with-time-step&max-sub-steps&fixed-time-step)
    :int
  (self :pointer)
  (timeStep :float)
  (maxSubSteps :int)
  (fixedTimeStep :float))
(declaim (inline SIMPLE-DYNAMICS-WORLD/STEP-SIMULATION))
(cffi:defcfun ("_wrap_btSimpleDynamicsWorld_stepSimulation__SWIG_1"
               SIMPLE-DYNAMICS-WORLD/STEP-SIMULATION/with-time-step&max-sub-steps)
    :int
  (self :pointer)
  (timeStep :float)
  (maxSubSteps :int))
(declaim (inline SIMPLE-DYNAMICS-WORLD/STEP-SIMULATION))
(cffi:defcfun ("_wrap_btSimpleDynamicsWorld_stepSimulation__SWIG_2"
               SIMPLE-DYNAMICS-WORLD/STEP-SIMULATION/with-time-step) :int
  (self :pointer)
  (timeStep :float))
(declaim (inline SIMPLE-DYNAMICS-WORLD/SET-GRAVITY))
(cffi:defcfun ("_wrap_btSimpleDynamicsWorld_setGravity"
               SIMPLE-DYNAMICS-WORLD/SET-GRAVITY) :void
  (self :pointer)
  (gravity :pointer))
(declaim (inline SIMPLE-DYNAMICS-WORLD/GET-GRAVITY))
(cffi:defcfun ("_wrap_btSimpleDynamicsWorld_getGravity"
               SIMPLE-DYNAMICS-WORLD/GET-GRAVITY) :pointer
  (self :pointer))
(declaim (inline SIMPLE-DYNAMICS-WORLD/ADD-RIGID-BODY))
(cffi:defcfun ("_wrap_btSimpleDynamicsWorld_addRigidBody__SWIG_0"
               SIMPLE-DYNAMICS-WORLD/ADD-RIGID-BODY) :void
  (self :pointer)
  (body :pointer))
(declaim (inline SIMPLE-DYNAMICS-WORLD/ADD-RIGID-BODY))
(cffi:defcfun ("_wrap_btSimpleDynamicsWorld_addRigidBody__SWIG_1"
               SIMPLE-DYNAMICS-WORLD/ADD-RIGID-BODY/with-group&mask) :void
  (self :pointer)
  (body :pointer)
  (group :short)
  (mask :short))
(declaim (inline SIMPLE-DYNAMICS-WORLD/REMOVE-RIGID-BODY))
(cffi:defcfun ("_wrap_btSimpleDynamicsWorld_removeRigidBody"
               SIMPLE-DYNAMICS-WORLD/REMOVE-RIGID-BODY) :void
  (self :pointer)
  (body :pointer))
(declaim (inline SIMPLE-DYNAMICS-WORLD/DEBUG-DRAW-WORLD))
(cffi:defcfun ("_wrap_btSimpleDynamicsWorld_debugDrawWorld"
               SIMPLE-DYNAMICS-WORLD/DEBUG-DRAW-WORLD) :void
  (self :pointer))
(declaim (inline SIMPLE-DYNAMICS-WORLD/ADD-ACTION))
(cffi:defcfun ("_wrap_btSimpleDynamicsWorld_addAction"
               SIMPLE-DYNAMICS-WORLD/ADD-ACTION) :void
  (self :pointer)
  (action :pointer))
(declaim (inline SIMPLE-DYNAMICS-WORLD/REMOVE-ACTION))
(cffi:defcfun ("_wrap_btSimpleDynamicsWorld_removeAction"
               SIMPLE-DYNAMICS-WORLD/REMOVE-ACTION) :void
  (self :pointer)
  (action :pointer))
(declaim (inline SIMPLE-DYNAMICS-WORLD/REMOVE-COLLISION-OBJECT))
(cffi:defcfun ("_wrap_btSimpleDynamicsWorld_removeCollisionObject"
               SIMPLE-DYNAMICS-WORLD/REMOVE-COLLISION-OBJECT) :void
  (self :pointer)
  (collisionObject :pointer))
(declaim (inline SIMPLE-DYNAMICS-WORLD/UPDATE-AABBS))
(cffi:defcfun ("_wrap_btSimpleDynamicsWorld_updateAabbs"
               SIMPLE-DYNAMICS-WORLD/UPDATE-AABBS) :void
  (self :pointer))
(declaim (inline SIMPLE-DYNAMICS-WORLD/SYNCHRONIZE-MOTION-STATES))
(cffi:defcfun ("_wrap_btSimpleDynamicsWorld_synchronizeMotionStates"
               SIMPLE-DYNAMICS-WORLD/SYNCHRONIZE-MOTION-STATES) :void
  (self :pointer))
(declaim (inline SIMPLE-DYNAMICS-WORLD/SET-CONSTRAINT-SOLVER))
(cffi:defcfun ("_wrap_btSimpleDynamicsWorld_setConstraintSolver"
               SIMPLE-DYNAMICS-WORLD/SET-CONSTRAINT-SOLVER) :void
  (self :pointer)
  (solver :pointer))
(declaim (inline SIMPLE-DYNAMICS-WORLD/GET-CONSTRAINT-SOLVER))
(cffi:defcfun ("_wrap_btSimpleDynamicsWorld_getConstraintSolver"
               SIMPLE-DYNAMICS-WORLD/GET-CONSTRAINT-SOLVER) :pointer
  (self :pointer))
(declaim (inline SIMPLE-DYNAMICS-WORLD/GET-WORLD-TYPE))
(cffi:defcfun ("_wrap_btSimpleDynamicsWorld_getWorldType"
               SIMPLE-DYNAMICS-WORLD/GET-WORLD-TYPE) :pointer
  (self :pointer))
(declaim (inline SIMPLE-DYNAMICS-WORLD/CLEAR-FORCES))
(cffi:defcfun ("_wrap_btSimpleDynamicsWorld_clearForces"
               SIMPLE-DYNAMICS-WORLD/CLEAR-FORCES) :void
  (self :pointer))
(cffi:defcvar ("gDeactivationTime"
               *DEACTIVATION-TIME*)
    :float)
(cffi:defcvar ("gDisableDeactivation"
               *DISABLE-DEACTIVATION*)
    :pointer)


(define-constant +TYPED-CONSTRAINT-DATA-NAME+ "btTypedConstraintFloatData"
  :test 'equal)
(cffi:defcenum TYPED-CONSTRAINT-TYPE
  (:POINT->POINT-CONSTRAINT-TYPE #.3)
  :HINGE-CONSTRAINT-TYPE
  :CONETWIST-CONSTRAINT-TYPE
  :D-6-CONSTRAINT-TYPE
  :SLIDER-CONSTRAINT-TYPE
  :CONTACT-CONSTRAINT-TYPE
  :D-6-SPRING-CONSTRAINT-TYPE
  :GEAR-CONSTRAINT-TYPE
  :FIXED-CONSTRAINT-TYPE
  :MAX-CONSTRAINT-TYPE)
(cffi:defcenum CONSTRAINT-PARAMS
  (:CONSTRAINT-ERP 1)
  :CONSTRAINT-STOP-ERP
  :CONSTRAINT-CFM
  :CONSTRAINT-STOP-CFM)

(declaim (inline TYPED-CONSTRAINT/MAKE-c++-INSTANCE))
(cffi:defcfun ("_wrap_btTypedConstraint_makeCPlusPlusInstance__SWIG_0"
               TYPED-CONSTRAINT/MAKE-c++-INSTANCE) :pointer
  (self :pointer)
  (sizeInBytes :pointer))
(declaim (inline TYPED-CONSTRAINT/DELETE-c++-INSTANCE))
(cffi:defcfun ("_wrap_btTypedConstraint_deleteCPlusPlusInstance__SWIG_0"
               TYPED-CONSTRAINT/DELETE-c++-INSTANCE) :void
  (self :pointer)
  (ptr :pointer))
(declaim (inline TYPED-CONSTRAINT/MAKE-c++-INSTANCE))
(cffi:defcfun ("_wrap_btTypedConstraint_makeCPlusPlusInstance__SWIG_1"
               TYPED-CONSTRAINT/MAKE-c++-INSTANCE/with-arg1&ptr) :pointer
  (self :pointer)
  (arg1 :pointer)
  (ptr :pointer))
(declaim (inline TYPED-CONSTRAINT/DELETE-c++-INSTANCE))
(cffi:defcfun ("_wrap_btTypedConstraint_deleteCPlusPlusInstance__SWIG_1"
               TYPED-CONSTRAINT/DELETE-c++-INSTANCE/with-arg1&2) :void
  (self :pointer)
  (arg1 :pointer)
  (arg2 :pointer))
(declaim (inline TYPED-CONSTRAINT/MAKE-c++-ARRAY))
(cffi:defcfun ("_wrap_btTypedConstraint_makeCPlusArray__SWIG_0"
               TYPED-CONSTRAINT/MAKE-c++-ARRAY) :pointer
  (self :pointer)
  (sizeInBytes :pointer))
(declaim (inline TYPED-CONSTRAINT/DELETE-c++-ARRAY))
(cffi:defcfun ("_wrap_btTypedConstraint_deleteCPlusArray__SWIG_0"
               TYPED-CONSTRAINT/DELETE-c++-ARRAY) :void
  (self :pointer)
  (ptr :pointer))
(declaim (inline TYPED-CONSTRAINT/MAKE-c++-ARRAY))
(cffi:defcfun ("_wrap_btTypedConstraint_makeCPlusArray__SWIG_1"
               TYPED-CONSTRAINT/MAKE-c++-ARRAY/with-arg1&ptr) :pointer
  (self :pointer)
  (arg1 :pointer)
  (ptr :pointer))
(declaim (inline TYPED-CONSTRAINT/DELETE-c++-ARRAY))
(cffi:defcfun ("_wrap_btTypedConstraint_deleteCPlusArray__SWIG_1"
               TYPED-CONSTRAINT/DELETE-c++-ARRAY/with-arg1&2) :void
  (self :pointer)
  (arg1 :pointer)
  (arg2 :pointer))
(declaim (inline DELETE/BT-TYPED-CONSTRAINT))
(cffi:defcfun ("_wrap_delete_btTypedConstraint"
               DELETE/BT-TYPED-CONSTRAINT) :void
  (self :pointer))
(declaim (inline TYPED-CONSTRAINT/GET-FIXED-BODY))
(cffi:defcfun ("_wrap_btTypedConstraint_getFixedBody"
               TYPED-CONSTRAINT/GET-FIXED-BODY) :pointer)
(declaim (inline TYPED-CONSTRAINT/GET-OVERRIDE-NUM-SOLVER-ITERATIONS))
(cffi:defcfun ("_wrap_btTypedConstraint_getOverrideNumSolverIterations"
               TYPED-CONSTRAINT/GET-OVERRIDE-NUM-SOLVER-ITERATIONS) :int
  (self :pointer))
(declaim (inline TYPED-CONSTRAINT/SET-OVERRIDE-NUM-SOLVER-ITERATIONS))
(cffi:defcfun ("_wrap_btTypedConstraint_setOverrideNumSolverIterations"
               TYPED-CONSTRAINT/SET-OVERRIDE-NUM-SOLVER-ITERATIONS) :void
  (self :pointer)
  (overideNumIterations :int))
(declaim (inline TYPED-CONSTRAINT/BUILD-JACOBIAN))
(cffi:defcfun ("_wrap_btTypedConstraint_buildJacobian"
               TYPED-CONSTRAINT/BUILD-JACOBIAN) :void
  (self :pointer))
(declaim (inline TYPED-CONSTRAINT/SETUP-SOLVER-CONSTRAINT))
(cffi:defcfun ("_wrap_btTypedConstraint_setupSolverConstraint"
               TYPED-CONSTRAINT/SETUP-SOLVER-CONSTRAINT) :void
  (self :pointer)
  (ca :pointer)
  (solverBodyA :int)
  (solverBodyB :int)
  (timeStep :float))
(declaim (inline TYPED-CONSTRAINT/GET-INFO-1))
(cffi:defcfun ("_wrap_btTypedConstraint_getInfo1"
               TYPED-CONSTRAINT/GET-INFO-1) :void
  (self :pointer)
  (info :pointer))
(declaim (inline TYPED-CONSTRAINT/GET-INFO-2))
(cffi:defcfun ("_wrap_btTypedConstraint_getInfo2"
               TYPED-CONSTRAINT/GET-INFO-2) :void
  (self :pointer)
  (info :pointer))
(declaim (inline TYPED-CONSTRAINT/INTERNAL-SET-APPLIED-IMPULSE))
(cffi:defcfun ("_wrap_btTypedConstraint_internalSetAppliedImpulse"
               TYPED-CONSTRAINT/INTERNAL-SET-APPLIED-IMPULSE) :void
  (self :pointer)
  (appliedImpulse :float))
(declaim (inline TYPED-CONSTRAINT/INTERNAL-GET-APPLIED-IMPULSE))
(cffi:defcfun ("_wrap_btTypedConstraint_internalGetAppliedImpulse"
               TYPED-CONSTRAINT/INTERNAL-GET-APPLIED-IMPULSE) :float
  (self :pointer))
(declaim (inline TYPED-CONSTRAINT/GET-BREAKING-IMPULSE-THRESHOLD))
(cffi:defcfun ("_wrap_btTypedConstraint_getBreakingImpulseThreshold"
               TYPED-CONSTRAINT/GET-BREAKING-IMPULSE-THRESHOLD) :float
  (self :pointer))
(declaim (inline TYPED-CONSTRAINT/SET-BREAKING-IMPULSE-THRESHOLD))
(cffi:defcfun ("_wrap_btTypedConstraint_setBreakingImpulseThreshold"
               TYPED-CONSTRAINT/SET-BREAKING-IMPULSE-THRESHOLD) :void
  (self :pointer)
  (threshold :float))
(declaim (inline TYPED-CONSTRAINT/IS-ENABLED))
(cffi:defcfun ("_wrap_btTypedConstraint_isEnabled"
               TYPED-CONSTRAINT/IS-ENABLED) :pointer
  (self :pointer))
(declaim (inline TYPED-CONSTRAINT/SET-ENABLED))
(cffi:defcfun ("_wrap_btTypedConstraint_setEnabled"
               TYPED-CONSTRAINT/SET-ENABLED) :void
  (self :pointer)
  (enabled :pointer))
(declaim (inline TYPED-CONSTRAINT/SOLVE-CONSTRAINT-OBSOLETE))
(cffi:defcfun ("_wrap_btTypedConstraint_solveConstraintObsolete"
               TYPED-CONSTRAINT/SOLVE-CONSTRAINT-OBSOLETE) :void
  (self :pointer)
  (arg1 :pointer)
  (arg2 :pointer)
  (arg3 :float))
(declaim (inline TYPED-CONSTRAINT/GET-RIGID-BODY-A))
(cffi:defcfun ("_wrap_btTypedConstraint_getRigidBodyA__SWIG_0"
               TYPED-CONSTRAINT/GET-RIGID-BODY-A) :pointer
  (self :pointer))
(declaim (inline TYPED-CONSTRAINT/GET-RIGID-BODY-B))
(cffi:defcfun ("_wrap_btTypedConstraint_getRigidBodyB__SWIG_0"
               TYPED-CONSTRAINT/GET-RIGID-BODY-B) :pointer
  (self :pointer))
#+ (or)
(cffi:defcfun ("_wrap_btTypedConstraint_getRigidBodyA__SWIG_1"
               TYPED-CONSTRAINT/GET-RIGID-BODY-A) :pointer
  (self :pointer))
#+ (or)
(cffi:defcfun ("_wrap_btTypedConstraint_getRigidBodyB__SWIG_1"
               TYPED-CONSTRAINT/GET-RIGID-BODY-B) :pointer
  (self :pointer))
(declaim (inline TYPED-CONSTRAINT/GET-USER-CONSTRAINT-TYPE))
(cffi:defcfun ("_wrap_btTypedConstraint_getUserConstraintType"
               TYPED-CONSTRAINT/GET-USER-CONSTRAINT-TYPE) :int
  (self :pointer))
(declaim (inline TYPED-CONSTRAINT/SET-USER-CONSTRAINT-TYPE))
(cffi:defcfun ("_wrap_btTypedConstraint_setUserConstraintType"
               TYPED-CONSTRAINT/SET-USER-CONSTRAINT-TYPE) :void
  (self :pointer)
  (userConstraintType :int))
(declaim (inline TYPED-CONSTRAINT/SET-USER-CONSTRAINT-ID))
(cffi:defcfun ("_wrap_btTypedConstraint_setUserConstraintId"
               TYPED-CONSTRAINT/SET-USER-CONSTRAINT-ID) :void
  (self :pointer)
  (uid :int))
(declaim (inline TYPED-CONSTRAINT/GET-USER-CONSTRAINT-ID))
(cffi:defcfun ("_wrap_btTypedConstraint_getUserConstraintId"
               TYPED-CONSTRAINT/GET-USER-CONSTRAINT-ID) :int
  (self :pointer))
(declaim (inline TYPED-CONSTRAINT/SET-USER-CONSTRAINT-PTR))
(cffi:defcfun ("_wrap_btTypedConstraint_setUserConstraintPtr"
               TYPED-CONSTRAINT/SET-USER-CONSTRAINT-PTR) :void
  (self :pointer)
  (ptr :pointer))
(declaim (inline TYPED-CONSTRAINT/GET-USER-CONSTRAINT-PTR))
(cffi:defcfun ("_wrap_btTypedConstraint_getUserConstraintPtr"
               TYPED-CONSTRAINT/GET-USER-CONSTRAINT-PTR) :pointer
  (self :pointer))
(declaim (inline TYPED-CONSTRAINT/SET-JOINT-FEEDBACK))
(cffi:defcfun ("_wrap_btTypedConstraint_setJointFeedback"
               TYPED-CONSTRAINT/SET-JOINT-FEEDBACK) :void
  (self :pointer)
  (jointFeedback :pointer))
(declaim (inline TYPED-CONSTRAINT/GET-JOINT-FEEDBACK))
(cffi:defcfun ("_wrap_btTypedConstraint_getJointFeedback__SWIG_0"
               TYPED-CONSTRAINT/GET-JOINT-FEEDBACK) :pointer
  (self :pointer))
#+ (or)
(cffi:defcfun ("_wrap_btTypedConstraint_getJointFeedback__SWIG_1"
               TYPED-CONSTRAINT/GET-JOINT-FEEDBACK) :pointer
  (self :pointer))
(declaim (inline TYPED-CONSTRAINT/GET-UID))
(cffi:defcfun ("_wrap_btTypedConstraint_getUid"
               TYPED-CONSTRAINT/GET-UID) :int
  (self :pointer))
(declaim (inline TYPED-CONSTRAINT/NEEDS-FEEDBACK))
(cffi:defcfun ("_wrap_btTypedConstraint_needsFeedback"
               TYPED-CONSTRAINT/NEEDS-FEEDBACK) :pointer
  (self :pointer))
(declaim (inline TYPED-CONSTRAINT/ENABLE-FEEDBACK))
(cffi:defcfun ("_wrap_btTypedConstraint_enableFeedback"
               TYPED-CONSTRAINT/ENABLE-FEEDBACK) :void
  (self :pointer)
  (needsFeedback :pointer))
(declaim (inline TYPED-CONSTRAINT/GET-APPLIED-IMPULSE))
(cffi:defcfun ("_wrap_btTypedConstraint_getAppliedImpulse"
               TYPED-CONSTRAINT/GET-APPLIED-IMPULSE) :float
  (self :pointer))
(declaim (inline TYPED-CONSTRAINT/GET-CONSTRAINT-TYPE))
(cffi:defcfun ("_wrap_btTypedConstraint_getConstraintType"
               TYPED-CONSTRAINT/GET-CONSTRAINT-TYPE) TYPED-CONSTRAINT-TYPE
  (self :pointer))
(declaim (inline TYPED-CONSTRAINT/SET-DBG-DRAW-SIZE))
(cffi:defcfun ("_wrap_btTypedConstraint_setDbgDrawSize"
               TYPED-CONSTRAINT/SET-DBG-DRAW-SIZE) :void
  (self :pointer)
  (dbgDrawSize :float))
(declaim (inline TYPED-CONSTRAINT/GET-DBG-DRAW-SIZE))
(cffi:defcfun ("_wrap_btTypedConstraint_getDbgDrawSize"
               TYPED-CONSTRAINT/GET-DBG-DRAW-SIZE) :float
  (self :pointer))
(declaim (inline TYPED-CONSTRAINT/CALCULATE-SERIALIZE-BUFFER-SIZE))
(cffi:defcfun ("_wrap_btTypedConstraint_calculateSerializeBufferSize"
               TYPED-CONSTRAINT/CALCULATE-SERIALIZE-BUFFER-SIZE) :int
  (self :pointer))
(declaim (inline TYPED-CONSTRAINT/SERIALIZE))
(cffi:defcfun ("_wrap_btTypedConstraint_serialize"
               TYPED-CONSTRAINT/SERIALIZE) :string
  (self :pointer)
  (dataBuffer :pointer)
  (serializer :pointer))
(declaim (inline ADJUST-ANGLE-TO-LIMITS))
(cffi:defcfun ("_wrap_btAdjustAngleToLimits"
               ADJUST-ANGLE-TO-LIMITS) :float
  (angleInRadians :float)
  (angleLowerLimitInRadians :float)
  (angleUpperLimitInRadians :float))


(declaim (inline MAKE-ANGULAR-LIMIT))
(cffi:defcfun ("_wrap_new_btAngularLimit"
               MAKE-ANGULAR-LIMIT) :pointer)
(declaim (inline ANGULAR-LIMIT/SET))
(cffi:defcfun ("_wrap_btAngularLimit_set__SWIG_0"
               ANGULAR-LIMIT/SET/with-low&high&softness&bias-&relaxation-factor) :void
  (self :pointer)
  (low :float)
  (high :float)
  (_softness :float)
  (_biasFactor :float)
  (_relaxationFactor :float))
(declaim (inline ANGULAR-LIMIT/SET))
(cffi:defcfun ("_wrap_btAngularLimit_set__SWIG_1"
               ANGULAR-LIMIT/SET/with-low&high&softness&bias-factor) :void
  (self :pointer)
  (low :float)
  (high :float)
  (_softness :float)
  (_biasFactor :float))
(declaim (inline ANGULAR-LIMIT/SET))
(cffi:defcfun ("_wrap_btAngularLimit_set__SWIG_2"
               ANGULAR-LIMIT/SET/with-low&high&softness) :void
  (self :pointer)
  (low :float)
  (high :float)
  (_softness :float))
(declaim (inline ANGULAR-LIMIT/SET))
(cffi:defcfun ("_wrap_btAngularLimit_set__SWIG_3"
               ANGULAR-LIMIT/SET/with-low&high) :void
  (self :pointer)
  (low :float)
  (high :float))
(declaim (inline ANGULAR-LIMIT/TEST))
(cffi:defcfun ("_wrap_btAngularLimit_test"
               ANGULAR-LIMIT/TEST) :void
  (self :pointer)
  (angle :float))
(declaim (inline ANGULAR-LIMIT/GET-SOFTNESS))
(cffi:defcfun ("_wrap_btAngularLimit_getSoftness"
               ANGULAR-LIMIT/GET-SOFTNESS) :float
  (self :pointer))
(declaim (inline ANGULAR-LIMIT/GET-BIAS-FACTOR))
(cffi:defcfun ("_wrap_btAngularLimit_getBiasFactor"
               ANGULAR-LIMIT/GET-BIAS-FACTOR) :float
  (self :pointer))
(declaim (inline ANGULAR-LIMIT/GET-RELAXATION-FACTOR))
(cffi:defcfun ("_wrap_btAngularLimit_getRelaxationFactor"
               ANGULAR-LIMIT/GET-RELAXATION-FACTOR) :float
  (self :pointer))
(declaim (inline ANGULAR-LIMIT/GET-CORRECTION))
(cffi:defcfun ("_wrap_btAngularLimit_getCorrection"
               ANGULAR-LIMIT/GET-CORRECTION) :float
  (self :pointer))
(declaim (inline ANGULAR-LIMIT/GET-SIGN))
(cffi:defcfun ("_wrap_btAngularLimit_getSign"
               ANGULAR-LIMIT/GET-SIGN) :float
  (self :pointer))
(declaim (inline ANGULAR-LIMIT/GET-HALF-RANGE))
(cffi:defcfun ("_wrap_btAngularLimit_getHalfRange"
               ANGULAR-LIMIT/GET-HALF-RANGE) :float
  (self :pointer))
(declaim (inline ANGULAR-LIMIT/IS-LIMIT))
(cffi:defcfun ("_wrap_btAngularLimit_isLimit"
               ANGULAR-LIMIT/IS-LIMIT) :pointer
  (self :pointer))
(declaim (inline ANGULAR-LIMIT/FIT))
(cffi:defcfun ("_wrap_btAngularLimit_fit"
               ANGULAR-LIMIT/FIT) :void
  (self :pointer)
  (angle :pointer))
(declaim (inline ANGULAR-LIMIT/GET-ERROR))
(cffi:defcfun ("_wrap_btAngularLimit_getError"
               ANGULAR-LIMIT/GET-ERROR) :float
  (self :pointer))
(declaim (inline ANGULAR-LIMIT/GET-LOW))
(cffi:defcfun ("_wrap_btAngularLimit_getLow"
               ANGULAR-LIMIT/GET-LOW) :float
  (self :pointer))
(declaim (inline ANGULAR-LIMIT/GET-HIGH))
(cffi:defcfun ("_wrap_btAngularLimit_getHigh"
               ANGULAR-LIMIT/GET-HIGH) :float
  (self :pointer))
(declaim (inline DELETE/BT-ANGULAR-LIMIT))
(cffi:defcfun ("_wrap_delete_btAngularLimit"
               DELETE/BT-ANGULAR-LIMIT) :void
  (self :pointer))
(define-constant +POINT->POINT-CONSTRAINT-DATA-NAME+ "btPoint2PointConstraintFloatData"
  :test 'equal)

(cffi:defcenum POINT->POINT-FLAGS
  (:P-2-P-FLAGS-ERP 1)
  (:P-2-P-FLAGS-CFM 2))
(declaim (inline POINT->POINT-CONSTRAINT/MAKE-c++-INSTANCE))
(cffi:defcfun ("_wrap_btPoint2PointConstraint_makeCPlusPlusInstance__SWIG_0"
               POINT->POINT-CONSTRAINT/MAKE-c++-INSTANCE) :pointer
  (self :pointer)
  (sizeInBytes :pointer))
(declaim (inline POINT->POINT-CONSTRAINT/DELETE-c++-INSTANCE))
(cffi:defcfun ("_wrap_btPoint2PointConstraint_deleteCPlusPlusInstance__SWIG_0"
               POINT->POINT-CONSTRAINT/DELETE-c++-INSTANCE) :void
  (self :pointer)
  (ptr :pointer))
(declaim (inline POINT->POINT-CONSTRAINT/MAKE-c++-INSTANCE))
(cffi:defcfun ("_wrap_btPoint2PointConstraint_makeCPlusPlusInstance__SWIG_1"
               POINT->POINT-CONSTRAINT/MAKE-c++-INSTANCE/with-arg1&ptr) :pointer
  (self :pointer)
  (arg1 :pointer)
  (ptr :pointer))
(declaim (inline POINT->POINT-CONSTRAINT/DELETE-c++-INSTANCE))
(cffi:defcfun ("_wrap_btPoint2PointConstraint_deleteCPlusPlusInstance__SWIG_1"
               POINT->POINT-CONSTRAINT/DELETE-c++-INSTANCE/with-arg1&2) :void
  (self :pointer)
  (arg1 :pointer)
  (arg2 :pointer))
(declaim (inline POINT->POINT-CONSTRAINT/MAKE-c++-ARRAY))
(cffi:defcfun ("_wrap_btPoint2PointConstraint_makeCPlusArray__SWIG_0"
               POINT->POINT-CONSTRAINT/MAKE-c++-ARRAY) :pointer
  (self :pointer)
  (sizeInBytes :pointer))
(declaim (inline POINT->POINT-CONSTRAINT/DELETE-c++-ARRAY))
(cffi:defcfun ("_wrap_btPoint2PointConstraint_deleteCPlusArray__SWIG_0"
               POINT->POINT-CONSTRAINT/DELETE-c++-ARRAY) :void
  (self :pointer)
  (ptr :pointer))
(declaim (inline POINT->POINT-CONSTRAINT/MAKE-c++-ARRAY))
(cffi:defcfun ("_wrap_btPoint2PointConstraint_makeCPlusArray__SWIG_1"
               POINT->POINT-CONSTRAINT/MAKE-c++-ARRAY/with-arg1&ptr) :pointer
  (self :pointer)
  (arg1 :pointer)
  (ptr :pointer))
(declaim (inline POINT->POINT-CONSTRAINT/DELETE-c++-ARRAY))
(cffi:defcfun ("_wrap_btPoint2PointConstraint_deleteCPlusArray__SWIG_1"
               POINT->POINT-CONSTRAINT/DELETE-c++-ARRAY/with-arg1&2) :void
  (self :pointer)
  (arg1 :pointer)
  (arg2 :pointer))
(declaim (inline POINT->POINT-CONSTRAINT/USE-SOLVE-CONSTRAINT-OBSOLETE/SET))
(cffi:defcfun ("_wrap_btPoint2PointConstraint_m_useSolveConstraintObsolete_set"
               POINT->POINT-CONSTRAINT/USE-SOLVE-CONSTRAINT-OBSOLETE/SET) :void
  (self :pointer)
  (m_useSolveConstraintObsolete :pointer))
(declaim (inline POINT->POINT-CONSTRAINT/USE-SOLVE-CONSTRAINT-OBSOLETE/GET))
(cffi:defcfun ("_wrap_btPoint2PointConstraint_m_useSolveConstraintObsolete_get"
               POINT->POINT-CONSTRAINT/USE-SOLVE-CONSTRAINT-OBSOLETE/GET) :pointer
  (self :pointer))
(declaim (inline POINT->POINT-CONSTRAINT/SETTING/SET))
(cffi:defcfun ("_wrap_btPoint2PointConstraint_m_setting_set"
               POINT->POINT-CONSTRAINT/SETTING/SET) :void
  (self :pointer)
  (m_setting :pointer))
(declaim (inline POINT->POINT-CONSTRAINT/SETTING/GET))
(cffi:defcfun ("_wrap_btPoint2PointConstraint_m_setting_get"
               POINT->POINT-CONSTRAINT/SETTING/GET) :pointer
  (self :pointer))
(declaim (inline MAKE-POINT->POINT-CONSTRAINT))
(cffi:defcfun ("_wrap_new_btPoint2PointConstraint__SWIG_0"
               MAKE-POINT->POINT-CONSTRAINT) :pointer
  (rbA :pointer)
  (rbB :pointer)
  (pivotInA :pointer)
  (pivotInB :pointer))
(declaim (inline MAKE-POINT->POINT-CONSTRAINT))
(cffi:defcfun ("_wrap_new_btPoint2PointConstraint__SWIG_1"
               MAKE-POINT->POINT-CONSTRAINT/with-rigid-body-a&pivot-in-a) :pointer
  (rbA :pointer)
  (pivotInA :pointer))
(declaim (inline POINT->POINT-CONSTRAINT/BUILD-JACOBIAN))
(cffi:defcfun ("_wrap_btPoint2PointConstraint_buildJacobian"
               POINT->POINT-CONSTRAINT/BUILD-JACOBIAN) :void
  (self :pointer))
(declaim (inline POINT->POINT-CONSTRAINT/GET-INFO-1))
(cffi:defcfun ("_wrap_btPoint2PointConstraint_getInfo1"
               POINT->POINT-CONSTRAINT/GET-INFO-1) :void
  (self :pointer)
  (info :pointer))
(declaim (inline POINT->POINT-CONSTRAINT/GET-INFO-1-NON-VIRTUAL))
(cffi:defcfun ("_wrap_btPoint2PointConstraint_getInfo1NonVirtual"
               POINT->POINT-CONSTRAINT/GET-INFO-1-NON-VIRTUAL) :void
  (self :pointer)
  (info :pointer))
(declaim (inline POINT->POINT-CONSTRAINT/GET-INFO-2))
(cffi:defcfun ("_wrap_btPoint2PointConstraint_getInfo2"
               POINT->POINT-CONSTRAINT/GET-INFO-2) :void
  (self :pointer)
  (info :pointer))
(declaim (inline POINT->POINT-CONSTRAINT/GET-INFO-2-NON-VIRTUAL))
(cffi:defcfun ("_wrap_btPoint2PointConstraint_getInfo2NonVirtual"
               POINT->POINT-CONSTRAINT/GET-INFO-2-NON-VIRTUAL) :void
  (self :pointer)
  (info :pointer)
  (body0_trans :pointer)
  (body1_trans :pointer))
(declaim (inline POINT->POINT-CONSTRAINT/UPDATE-RHS))
(cffi:defcfun ("_wrap_btPoint2PointConstraint_updateRHS"
               POINT->POINT-CONSTRAINT/UPDATE-RHS) :void
  (self :pointer)
  (timeStep :float))
(declaim (inline POINT->POINT-CONSTRAINT/SET-PIVOT-A))
(cffi:defcfun ("_wrap_btPoint2PointConstraint_setPivotA"
               POINT->POINT-CONSTRAINT/SET-PIVOT-A) :void
  (self :pointer)
  (pivotA :pointer))
(declaim (inline POINT->POINT-CONSTRAINT/SET-PIVOT-B))
(cffi:defcfun ("_wrap_btPoint2PointConstraint_setPivotB"
               POINT->POINT-CONSTRAINT/SET-PIVOT-B) :void
  (self :pointer)
  (pivotB :pointer))
(declaim (inline POINT->POINT-CONSTRAINT/GET-PIVOT-IN-A))
(cffi:defcfun ("_wrap_btPoint2PointConstraint_getPivotInA"
               POINT->POINT-CONSTRAINT/GET-PIVOT-IN-A) :pointer
  (self :pointer))
(declaim (inline POINT->POINT-CONSTRAINT/GET-PIVOT-IN-B))
(cffi:defcfun ("_wrap_btPoint2PointConstraint_getPivotInB"
               POINT->POINT-CONSTRAINT/GET-PIVOT-IN-B) :pointer
  (self :pointer))
(declaim (inline POINT->POINT-CONSTRAINT/CALCULATE-SERIALIZE-BUFFER-SIZE))
(cffi:defcfun ("_wrap_btPoint2PointConstraint_calculateSerializeBufferSize"
               POINT->POINT-CONSTRAINT/CALCULATE-SERIALIZE-BUFFER-SIZE) :int
  (self :pointer))
(declaim (inline POINT->POINT-CONSTRAINT/SERIALIZE))
(cffi:defcfun ("_wrap_btPoint2PointConstraint_serialize"
               POINT->POINT-CONSTRAINT/SERIALIZE) :string
  (self :pointer)
  (dataBuffer :pointer)
  (serializer :pointer))
(declaim (inline DELETE/BT-POINT->POINT-CONSTRAINT))
(cffi:defcfun ("_wrap_delete_btPoint2PointConstraint"
               DELETE/BT-POINT->POINT-CONSTRAINT) :void
  (self :pointer))
(define-constant +-BT-USE-CENTER-LIMIT-+ 1)
(define-constant +HINGE-CONSTRAINT-DATA-NAME+ "btHingeConstraintFloatData"
  :test 'equal)
(cffi:defcenum HINGE-FLAGS
  (:HINGE-FLAGS-CFM-STOP 1)
  (:HINGE-FLAGS-ERP-STOP 2)
  (:HINGE-FLAGS-CFM-NORM 4))
(declaim (inline HINGE-CONSTRAINT/MAKE-c++-INSTANCE))
(cffi:defcfun ("_wrap_btHingeConstraint_makeCPlusPlusInstance__SWIG_0"
               HINGE-CONSTRAINT/MAKE-c++-INSTANCE) :pointer
  (self :pointer)
  (sizeInBytes :pointer))
(declaim (inline HINGE-CONSTRAINT/DELETE-c++-INSTANCE))
(cffi:defcfun ("_wrap_btHingeConstraint_deleteCPlusPlusInstance__SWIG_0"
               HINGE-CONSTRAINT/DELETE-c++-INSTANCE) :void
  (self :pointer)
  (ptr :pointer))
(declaim (inline HINGE-CONSTRAINT/MAKE-c++-INSTANCE))
(cffi:defcfun ("_wrap_btHingeConstraint_makeCPlusPlusInstance__SWIG_1"
               HINGE-CONSTRAINT/MAKE-c++-INSTANCE/with-arg1&ptr) :pointer
  (self :pointer)
  (arg1 :pointer)
  (ptr :pointer))
(declaim (inline HINGE-CONSTRAINT/DELETE-c++-INSTANCE))
(cffi:defcfun ("_wrap_btHingeConstraint_deleteCPlusPlusInstance__SWIG_1"
               HINGE-CONSTRAINT/DELETE-c++-INSTANCE/with-arg1&2) :void
  (self :pointer)
  (arg1 :pointer)
  (arg2 :pointer))
(declaim (inline HINGE-CONSTRAINT/MAKE-c++-ARRAY))
(cffi:defcfun ("_wrap_btHingeConstraint_makeCPlusArray__SWIG_0"
               HINGE-CONSTRAINT/MAKE-c++-ARRAY) :pointer
  (self :pointer)
  (sizeInBytes :pointer))
(declaim (inline HINGE-CONSTRAINT/DELETE-c++-ARRAY))
(cffi:defcfun ("_wrap_btHingeConstraint_deleteCPlusArray__SWIG_0"
               HINGE-CONSTRAINT/DELETE-c++-ARRAY) :void
  (self :pointer)
  (ptr :pointer))
(declaim (inline HINGE-CONSTRAINT/MAKE-c++-ARRAY))
(cffi:defcfun ("_wrap_btHingeConstraint_makeCPlusArray__SWIG_1"
               HINGE-CONSTRAINT/MAKE-c++-ARRAY/with-arg1&ptr) :pointer
  (self :pointer)
  (arg1 :pointer)
  (ptr :pointer))
(declaim (inline HINGE-CONSTRAINT/DELETE-c++-ARRAY))
(cffi:defcfun ("_wrap_btHingeConstraint_deleteCPlusArray__SWIG_1"
               HINGE-CONSTRAINT/DELETE-c++-ARRAY/with-arg1&2) :void
  (self :pointer)
  (arg1 :pointer)
  (arg2 :pointer))
(declaim (inline MAKE-HINGE-CONSTRAINT))
(cffi:defcfun ("_wrap_new_btHingeConstraint__SWIG_0"
               MAKE-HINGE-CONSTRAINT/with-a&b&use-a) :pointer
  (rbA :pointer)
  (rbB :pointer)
  (pivotInA :pointer)
  (pivotInB :pointer)
  (axisInA :pointer)
  (axisInB :pointer)
  (useReferenceFrameA :pointer))
  (cffi:defcfun ("_wrap_new_btHingeConstraint__SWIG_1"
                 MAKE-HINGE-CONSTRAINT/with-a&b) :pointer
    (rbA :pointer)
    (rbB :pointer)
    (pivotInA :pointer)
    (pivotInB :pointer)
    (axisInA :pointer)
    (axisInB :pointer))
  (declaim (inline MAKE-HINGE-CONSTRAINT))
  (cffi:defcfun ("_wrap_new_btHingeConstraint__SWIG_2"
                 MAKE-HINGE-CONSTRAINT/with-use-a) :pointer
    (rbA :pointer)
    (pivotInA :pointer)
    (axisInA :pointer)
    (useReferenceFrameA :pointer))
  (declaim (inline MAKE-HINGE-CONSTRAINT))
  (cffi:defcfun ("_wrap_new_btHingeConstraint__SWIG_3"
                 MAKE-HINGE-CONSTRAINT) :pointer
    (rbA :pointer)
    (pivotInA :pointer)
    (axisInA :pointer))
  (declaim (inline MAKE-HINGE-CONSTRAINT))
  (cffi:defcfun ("_wrap_new_btHingeConstraint__SWIG_4"
                 MAKE-HINGE-CONSTRAINT/with-frame-a&b&use-a) :pointer
    (rbA :pointer)
    (rbB :pointer)
    (rbAFrame :pointer)
    (rbBFrame :pointer)
    (useReferenceFrameA :pointer))
  (declaim (inline MAKE-HINGE-CONSTRAINT))
  (cffi:defcfun ("_wrap_new_btHingeConstraint__SWIG_5"
                 MAKE-HINGE-CONSTRAINT/with-frame-a&b) :pointer
    (rbA :pointer)
    (rbB :pointer)
    (rbAFrame :pointer)
    (rbBFrame :pointer))
  (declaim (inline MAKE-HINGE-CONSTRAINT))
  (cffi:defcfun ("_wrap_new_btHingeConstraint__SWIG_6"
                 MAKE-HINGE-CONSTRAINT/with-frame-a&use-a) :pointer
    (rbA :pointer)
    (rbAFrame :pointer)
    (useReferenceFrameA :pointer))
  (declaim (inline MAKE-HINGE-CONSTRAINT))
  (cffi:defcfun ("_wrap_new_btHingeConstraint__SWIG_7"
                 MAKE-HINGE-CONSTRAINT/with-frame-a) :pointer
    (rbA :pointer)
    (rbAFrame :pointer))
(declaim (inline HINGE-CONSTRAINT/BUILD-JACOBIAN))
(cffi:defcfun ("_wrap_btHingeConstraint_buildJacobian"
               HINGE-CONSTRAINT/BUILD-JACOBIAN) :void
  (self :pointer))
(declaim (inline HINGE-CONSTRAINT/GET-INFO-1))
(cffi:defcfun ("_wrap_btHingeConstraint_getInfo1"
               HINGE-CONSTRAINT/GET-INFO-1) :void
  (self :pointer)
  (info :pointer))
(declaim (inline HINGE-CONSTRAINT/GET-INFO-1-NON-VIRTUAL))
(cffi:defcfun ("_wrap_btHingeConstraint_getInfo1NonVirtual"
               HINGE-CONSTRAINT/GET-INFO-1-NON-VIRTUAL) :void
  (self :pointer)
  (info :pointer))
(declaim (inline HINGE-CONSTRAINT/GET-INFO-2))
(cffi:defcfun ("_wrap_btHingeConstraint_getInfo2"
               HINGE-CONSTRAINT/GET-INFO-2) :void
  (self :pointer)
  (info :pointer))
(declaim (inline HINGE-CONSTRAINT/GET-INFO-2-NON-VIRTUAL))
(cffi:defcfun ("_wrap_btHingeConstraint_getInfo2NonVirtual"
               HINGE-CONSTRAINT/GET-INFO-2-NON-VIRTUAL) :void
  (self :pointer)
  (info :pointer)
  (transA :pointer)
  (transB :pointer)
  (angVelA :pointer)
  (angVelB :pointer))
(declaim (inline HINGE-CONSTRAINT/GET-INFO-2-INTERNAL))
(cffi:defcfun ("_wrap_btHingeConstraint_getInfo2Internal"
               HINGE-CONSTRAINT/GET-INFO-2-INTERNAL) :void
  (self :pointer)
  (info :pointer)
  (transA :pointer)
  (transB :pointer)
  (angVelA :pointer)
  (angVelB :pointer))
(declaim (inline HINGE-CONSTRAINT/GET-INFO-2-INTERNAL-USING-FRAME-OFFSET))
(cffi:defcfun ("_wrap_btHingeConstraint_getInfo2InternalUsingFrameOffset"
               HINGE-CONSTRAINT/GET-INFO-2-INTERNAL-USING-FRAME-OFFSET) :void
  (self :pointer)
  (info :pointer)
  (transA :pointer)
  (transB :pointer)
  (angVelA :pointer)
  (angVelB :pointer))
(declaim (inline HINGE-CONSTRAINT/UPDATE-RHS))
(cffi:defcfun ("_wrap_btHingeConstraint_updateRHS"
               HINGE-CONSTRAINT/UPDATE-RHS) :void
  (self :pointer)
  (timeStep :float))
(declaim (inline HINGE-CONSTRAINT/GET-RIGID-BODY-A))
(cffi:defcfun ("_wrap_btHingeConstraint_getRigidBodyA__SWIG_0"
               HINGE-CONSTRAINT/GET-RIGID-BODY-A) :pointer
  (self :pointer))
(declaim (inline HINGE-CONSTRAINT/GET-RIGID-BODY-B))
(cffi:defcfun ("_wrap_btHingeConstraint_getRigidBodyB__SWIG_0"
               HINGE-CONSTRAINT/GET-RIGID-BODY-B) :pointer
  (self :pointer))
#+ (or)
(progn
  (declaim (inline HINGE-CONSTRAINT/GET-RIGID-BODY-A))
  (cffi:defcfun ("_wrap_btHingeConstraint_getRigidBodyA__SWIG_1"
                 HINGE-CONSTRAINT/GET-RIGID-BODY-A) :pointer
    (self :pointer))
  (declaim (inline HINGE-CONSTRAINT/GET-RIGID-BODY-B))
  (cffi:defcfun ("_wrap_btHingeConstraint_getRigidBodyB__SWIG_1"
                 HINGE-CONSTRAINT/GET-RIGID-BODY-B) :pointer
    (self :pointer))
  )
(declaim (inline HINGE-CONSTRAINT/GET-FRAME-OFFSET-A))
(cffi:defcfun ("_wrap_btHingeConstraint_getFrameOffsetA"
               HINGE-CONSTRAINT/GET-FRAME-OFFSET-A) :pointer
  (self :pointer))
(declaim (inline HINGE-CONSTRAINT/GET-FRAME-OFFSET-B))
(cffi:defcfun ("_wrap_btHingeConstraint_getFrameOffsetB"
               HINGE-CONSTRAINT/GET-FRAME-OFFSET-B) :pointer
  (self :pointer))
(declaim (inline HINGE-CONSTRAINT/SET-FRAMES))
(cffi:defcfun ("_wrap_btHingeConstraint_setFrames"
               HINGE-CONSTRAINT/SET-FRAMES) :void
  (self :pointer)
  (frameA :pointer)
  (frameB :pointer))
(declaim (inline HINGE-CONSTRAINT/SET-ANGULAR-ONLY))
(cffi:defcfun ("_wrap_btHingeConstraint_setAngularOnly"
               HINGE-CONSTRAINT/SET-ANGULAR-ONLY) :void
  (self :pointer)
  (angularOnly :pointer))
(declaim (inline HINGE-CONSTRAINT/ENABLE-ANGULAR-MOTOR))
(cffi:defcfun ("_wrap_btHingeConstraint_enableAngularMotor"
               HINGE-CONSTRAINT/ENABLE-ANGULAR-MOTOR) :void
  (self :pointer)
  (enableMotor :pointer)
  (targetVelocity :float)
  (maxMotorImpulse :float))
(declaim (inline HINGE-CONSTRAINT/ENABLE-MOTOR))
(cffi:defcfun ("_wrap_btHingeConstraint_enableMotor"
               HINGE-CONSTRAINT/ENABLE-MOTOR) :void
  (self :pointer)
  (enableMotor :pointer))
(declaim (inline HINGE-CONSTRAINT/SET-MAX-MOTOR-IMPULSE))
(cffi:defcfun ("_wrap_btHingeConstraint_setMaxMotorImpulse"
               HINGE-CONSTRAINT/SET-MAX-MOTOR-IMPULSE) :void
  (self :pointer)
  (maxMotorImpulse :float))
(declaim (inline HINGE-CONSTRAINT/SET-MOTOR-TARGET))
(cffi:defcfun ("_wrap_btHingeConstraint_setMotorTarget__SWIG_0"
               hinge-constraint/set-motor-target/q-a-in-b) :void
  (self :pointer)
  (qAinB :pointer)
  (dt :float))
(declaim (inline HINGE-CONSTRAINT/SET-MOTOR-TARGET))
(cffi:defcfun ("_wrap_btHingeConstraint_setMotorTarget__SWIG_1"
               hinge-constraint/set-motor-target/target-angle) :void
  (self :pointer)
  (targetAngle :float)
  (dt :float))
(declaim (inline HINGE-CONSTRAINT/SET-LIMIT/with-softness&bias&relaxation))
(cffi:defcfun ("_wrap_btHingeConstraint_setLimit__SWIG_0"
               HINGE-CONSTRAINT/SET-LIMIT/with-softness&bias&relaxation) :void
  (self :pointer)
  (low :float)
  (high :float)
  (_softness :float)
  (_biasFactor :float)
  (_relaxationFactor :float))
(declaim (inline HINGE-CONSTRAINT/SET-LIMIT/with-softness&bias))
(cffi:defcfun ("_wrap_btHingeConstraint_setLimit__SWIG_1"
               HINGE-CONSTRAINT/SET-LIMIT/with-softness&bias) :void
  (self :pointer)
  (low :float)
  (high :float)
  (_softness :float)
  (_biasFactor :float))
(declaim (inline HINGE-CONSTRAINT/SET-LIMIT/with-softness))
(cffi:defcfun ("_wrap_btHingeConstraint_setLimit__SWIG_2"
               HINGE-CONSTRAINT/SET-LIMIT/with-softness) :void
  (self :pointer)
  (low :float)
  (high :float)
  (_softness :float))
(declaim (inline HINGE-CONSTRAINT/SET-LIMIT))
(cffi:defcfun ("_wrap_btHingeConstraint_setLimit__SWIG_3"
               HINGE-CONSTRAINT/SET-LIMIT) :void
  (self :pointer)
  (low :float)
  (high :float))
(declaim (inline HINGE-CONSTRAINT/SET-AXIS))
(cffi:defcfun ("_wrap_btHingeConstraint_setAxis"
               HINGE-CONSTRAINT/SET-AXIS) :void
  (self :pointer)
  (axisInA :pointer))
(declaim (inline HINGE-CONSTRAINT/GET-LOWER-LIMIT))
(cffi:defcfun ("_wrap_btHingeConstraint_getLowerLimit"
               HINGE-CONSTRAINT/GET-LOWER-LIMIT) :float
  (self :pointer))
(declaim (inline HINGE-CONSTRAINT/GET-UPPER-LIMIT))
(cffi:defcfun ("_wrap_btHingeConstraint_getUpperLimit"
               HINGE-CONSTRAINT/GET-UPPER-LIMIT) :float
  (self :pointer))
(declaim (inline HINGE-CONSTRAINT/GET-HINGE-ANGLE))
(cffi:defcfun ("_wrap_btHingeConstraint_getHingeAngle__SWIG_0"
               HINGE-CONSTRAINT/GET-HINGE-ANGLE) :float
  (self :pointer))
(declaim (inline HINGE-CONSTRAINT/GET-HINGE-ANGLE))
(cffi:defcfun ("_wrap_btHingeConstraint_getHingeAngle__SWIG_1"
               HINGE-CONSTRAINT/GET-HINGE-ANGLE/with-trans-a&b) :float
  (self :pointer)
  (transA :pointer)
  (transB :pointer))
(declaim (inline HINGE-CONSTRAINT/TEST-LIMIT))
(cffi:defcfun ("_wrap_btHingeConstraint_testLimit"
               HINGE-CONSTRAINT/TEST-LIMIT) :void
  (self :pointer)
  (transA :pointer)
  (transB :pointer))
(declaim (inline HINGE-CONSTRAINT/GET-AFRAME))
(cffi:defcfun ("_wrap_btHingeConstraint_getAFrame__SWIG_0"
               HINGE-CONSTRAINT/GET-AFRAME) :pointer
  (self :pointer))
(declaim (inline HINGE-CONSTRAINT/GET-BFRAME))
(cffi:defcfun ("_wrap_btHingeConstraint_getBFrame__SWIG_0"
               HINGE-CONSTRAINT/GET-BFRAME) :pointer
  (self :pointer))
#+ (or)
(cffi:defcfun ("_wrap_btHingeConstraint_getAFrame__SWIG_1"
               HINGE-CONSTRAINT/GET-AFRAME) :pointer
  (self :pointer))
#+ (or)
(cffi:defcfun ("_wrap_btHingeConstraint_getBFrame__SWIG_1"
               HINGE-CONSTRAINT/GET-BFRAME) :pointer
  (self :pointer))
(declaim (inline HINGE-CONSTRAINT/GET-SOLVE-LIMIT))
(cffi:defcfun ("_wrap_btHingeConstraint_getSolveLimit"
               HINGE-CONSTRAINT/GET-SOLVE-LIMIT) :int
  (self :pointer))
(declaim (inline HINGE-CONSTRAINT/GET-LIMIT-SIGN))
(cffi:defcfun ("_wrap_btHingeConstraint_getLimitSign"
               HINGE-CONSTRAINT/GET-LIMIT-SIGN) :float
  (self :pointer))
(declaim (inline HINGE-CONSTRAINT/GET-ANGULAR-ONLY))
(cffi:defcfun ("_wrap_btHingeConstraint_getAngularOnly"
               HINGE-CONSTRAINT/GET-ANGULAR-ONLY) :pointer
  (self :pointer))
(declaim (inline HINGE-CONSTRAINT/GET-ENABLE-ANGULAR-MOTOR))
(cffi:defcfun ("_wrap_btHingeConstraint_getEnableAngularMotor"
               HINGE-CONSTRAINT/GET-ENABLE-ANGULAR-MOTOR) :pointer
  (self :pointer))
(declaim (inline HINGE-CONSTRAINT/GET-MOTOR-TARGET-VELOSITY))
(cffi:defcfun ("_wrap_btHingeConstraint_getMotorTargetVelosity"
               HINGE-CONSTRAINT/GET-MOTOR-TARGET-VELOSITY) :float
  (self :pointer))
(declaim (inline HINGE-CONSTRAINT/GET-MAX-MOTOR-IMPULSE))
(cffi:defcfun ("_wrap_btHingeConstraint_getMaxMotorImpulse"
               HINGE-CONSTRAINT/GET-MAX-MOTOR-IMPULSE) :float
  (self :pointer))
(declaim (inline HINGE-CONSTRAINT/GET-USE-FRAME-OFFSET))
(cffi:defcfun ("_wrap_btHingeConstraint_getUseFrameOffset"
               HINGE-CONSTRAINT/GET-USE-FRAME-OFFSET) :pointer
  (self :pointer))
(declaim (inline HINGE-CONSTRAINT/SET-USE-FRAME-OFFSET))
(cffi:defcfun ("_wrap_btHingeConstraint_setUseFrameOffset"
               HINGE-CONSTRAINT/SET-USE-FRAME-OFFSET) :void
  (self :pointer)
  (frameOffsetOnOff :pointer))
(declaim (inline HINGE-CONSTRAINT/CALCULATE-SERIALIZE-BUFFER-SIZE))
(cffi:defcfun ("_wrap_btHingeConstraint_calculateSerializeBufferSize"
               HINGE-CONSTRAINT/CALCULATE-SERIALIZE-BUFFER-SIZE) :int
  (self :pointer))
(declaim (inline HINGE-CONSTRAINT/SERIALIZE))
(cffi:defcfun ("_wrap_btHingeConstraint_serialize"
               HINGE-CONSTRAINT/SERIALIZE) :string
  (self :pointer)
  (dataBuffer :pointer)
  (serializer :pointer))
(declaim (inline DELETE/BT-HINGE-CONSTRAINT))
(cffi:defcfun ("_wrap_delete_btHingeConstraint"
               DELETE/BT-HINGE-CONSTRAINT) :void
  (self :pointer))

(define-constant +CONE-TWIST-CONSTRAINT-DATA-NAME+ "btConeTwistConstraintData"
  :test 'equal)
(cffi:defcenum CONE-TWIST-FLAGS
  (:CONETWIST-FLAGS-LIN-CFM 1)
  (:CONETWIST-FLAGS-LIN-ERP 2)
  (:CONETWIST-FLAGS-ANG-CFM 4))
(declaim (inline CONE-TWIST-CONSTRAINT/MAKE-c++-INSTANCE))
(cffi:defcfun ("_wrap_btConeTwistConstraint_makeCPlusPlusInstance__SWIG_0"
               cONE-TWIST-CONSTRAINT/MAKE-c++-INSTANCE) :pointer
  (self :pointer)
  (sizeInBytes :pointer))
(declaim (inline CONE-TWIST-CONSTRAINT/DELETE-c++-INSTANCE))
(cffi:defcfun ("_wrap_btConeTwistConstraint_deleteCPlusPlusInstance__SWIG_0"
               cONE-TWIST-CONSTRAINT/DELETE-c++-INSTANCE) :void
  (self :pointer)
  (ptr :pointer))
(declaim (inline CONE-TWIST-CONSTRAINT/MAKE-c++-INSTANCE))
(cffi:defcfun ("_wrap_btConeTwistConstraint_makeCPlusPlusInstance__SWIG_1"
               cONE-TWIST-CONSTRAINT/MAKE-c++-INSTANCE/with-arg1&ptr) :pointer
  (self :pointer)
  (arg1 :pointer)
  (ptr :pointer))
(declaim (inline CONE-TWIST-CONSTRAINT/DELETE-c++-INSTANCE))
(cffi:defcfun ("_wrap_btConeTwistConstraint_deleteCPlusPlusInstance__SWIG_1"
               cONE-TWIST-CONSTRAINT/DELETE-c++-INSTANCE/with-arg1&2) :void
  (self :pointer)
  (arg1 :pointer)
  (arg2 :pointer))
(declaim (inline CONE-TWIST-CONSTRAINT/MAKE-c++-ARRAY))
(cffi:defcfun ("_wrap_btConeTwistConstraint_makeCPlusArray__SWIG_0"
               cONE-TWIST-CONSTRAINT/MAKE-c++-ARRAY) :pointer
  (self :pointer)
  (sizeInBytes :pointer))
(declaim (inline CONE-TWIST-CONSTRAINT/DELETE-c++-ARRAY))
(cffi:defcfun ("_wrap_btConeTwistConstraint_deleteCPlusArray__SWIG_0"
               cONE-TWIST-CONSTRAINT/DELETE-c++-ARRAY) :void
  (self :pointer)
  (ptr :pointer))
(declaim (inline CONE-TWIST-CONSTRAINT/MAKE-c++-ARRAY))
(cffi:defcfun ("_wrap_btConeTwistConstraint_makeCPlusArray__SWIG_1"
               cONE-TWIST-CONSTRAINT/MAKE-c++-ARRAY/with-arg1&ptr) :pointer
  (self :pointer)
  (arg1 :pointer)
  (ptr :pointer))
(declaim (inline CONE-TWIST-CONSTRAINT/DELETE-c++-ARRAY))
(cffi:defcfun ("_wrap_btConeTwistConstraint_deleteCPlusArray__SWIG_1"
               cONE-TWIST-CONSTRAINT/DELETE-c++-ARRAY/with-arg1&2) :void
  (self :pointer)
  (arg1 :pointer)
  (arg2 :pointer))
(declaim (inline MAKE-CONE-TWIST-CONSTRAINT))
(cffi:defcfun ("_wrap_new_btConeTwistConstraint__SWIG_0"
               MAKE-CONE-TWIST-CONSTRAINT/with-b) :pointer
  (rbA :pointer)
  (rbB :pointer)
  (rbAFrame :pointer)
  (rbBFrame :pointer))
(declaim (inline MAKE-CONE-TWIST-CONSTRAINT))
(cffi:defcfun ("_wrap_new_btConeTwistConstraint__SWIG_1"
               make-cone-twist-constraint) :pointer
  (rbA :pointer)
  (rbAFrame :pointer))
(declaim (inline CONE-TWIST-CONSTRAINT/BUILD-JACOBIAN))
(cffi:defcfun ("_wrap_btConeTwistConstraint_buildJacobian"
               cONE-TWIST-CONSTRAINT/BUILD-JACOBIAN) :void
  (self :pointer))
(declaim (inline CONE-TWIST-CONSTRAINT/GET-INFO-1))
(cffi:defcfun ("_wrap_btConeTwistConstraint_getInfo1"
               cONE-TWIST-CONSTRAINT/GET-INFO-1) :void
  (self :pointer)
  (info :pointer))
(declaim (inline CONE-TWIST-CONSTRAINT/GET-INFO-1-NON-VIRTUAL))
(cffi:defcfun ("_wrap_btConeTwistConstraint_getInfo1NonVirtual"
               cONE-TWIST-CONSTRAINT/GET-INFO-1-NON-VIRTUAL) :void
  (self :pointer)
  (info :pointer))
(declaim (inline CONE-TWIST-CONSTRAINT/GET-INFO-2))
(cffi:defcfun ("_wrap_btConeTwistConstraint_getInfo2"
               cONE-TWIST-CONSTRAINT/GET-INFO-2) :void
  (self :pointer)
  (info :pointer))
(declaim (inline CONE-TWIST-CONSTRAINT/GET-INFO-2-NON-VIRTUAL))
(cffi:defcfun ("_wrap_btConeTwistConstraint_getInfo2NonVirtual"
               cONE-TWIST-CONSTRAINT/GET-INFO-2-NON-VIRTUAL) :void
  (self :pointer)
  (info :pointer)
  (transA :pointer)
  (transB :pointer)
  (invInertiaWorldA :pointer)
  (invInertiaWorldB :pointer))
(declaim (inline CONE-TWIST-CONSTRAINT/SOLVE-CONSTRAINT-OBSOLETE))
(cffi:defcfun ("_wrap_btConeTwistConstraint_solveConstraintObsolete"
               cONE-TWIST-CONSTRAINT/SOLVE-CONSTRAINT-OBSOLETE) :void
  (self :pointer)
  (bodyA :pointer)
  (bodyB :pointer)
  (timeStep :float))
(declaim (inline CONE-TWIST-CONSTRAINT/UPDATE-RHS))
(cffi:defcfun ("_wrap_btConeTwistConstraint_updateRHS"
               cONE-TWIST-CONSTRAINT/UPDATE-RHS) :void
  (self :pointer)
  (timeStep :float))
(declaim (inline CONE-TWIST-CONSTRAINT/GET-RIGID-BODY-A))
(cffi:defcfun ("_wrap_btConeTwistConstraint_getRigidBodyA"
               cONE-TWIST-CONSTRAINT/GET-RIGID-BODY-A) :pointer
  (self :pointer))
(declaim (inline CONE-TWIST-CONSTRAINT/GET-RIGID-BODY-B))
(cffi:defcfun ("_wrap_btConeTwistConstraint_getRigidBodyB"
               cONE-TWIST-CONSTRAINT/GET-RIGID-BODY-B) :pointer
  (self :pointer))
(declaim (inline CONE-TWIST-CONSTRAINT/SET-ANGULAR-ONLY))
(cffi:defcfun ("_wrap_btConeTwistConstraint_setAngularOnly"
               cONE-TWIST-CONSTRAINT/SET-ANGULAR-ONLY) :void
  (self :pointer)
  (angularOnly :pointer))
(declaim (inline CONE-TWIST-CONSTRAINT/SET-LIMIT/elt))
  (cffi:defcfun ("_wrap_btConeTwistConstraint_setLimit__SWIG_0"
                 cONE-TWIST-CONSTRAINT/SET-LIMIT/elt) :void
    (self :pointer)
    (limitIndex :int)
    (limitValue :float))
  (declaim (inline CONE-TWIST-CONSTRAINT/SET-LIMIT))
  (cffi:defcfun ("_wrap_btConeTwistConstraint_setLimit__SWIG_1"
                 cONE-TWIST-CONSTRAINT/SET-LIMIT/with-swing&twist&softness&bias&relaxation) 
      :void
    (self :pointer)
    (_swingSpan1 :float)
    (_swingSpan2 :float)
    (_twistSpan :float)
    (_softness :float)
    (_biasFactor :float)
    (_relaxationFactor :float))
  (declaim (inline CONE-TWIST-CONSTRAINT/SET-LIMIT))
  (cffi:defcfun ("_wrap_btConeTwistConstraint_setLimit__SWIG_2"
                 CONE-TWIST-CONSTRAINT/SET-LIMIT/with-swing&twist&softness&bias) :void
    (self :pointer)
    (_swingSpan1 :float)
    (_swingSpan2 :float)
    (_twistSpan :float)
    (_softness :float)
    (_biasFactor :float))
  (declaim (inline CONE-TWIST-CONSTRAINT/SET-LIMIT))
  (cffi:defcfun ("_wrap_btConeTwistConstraint_setLimit__SWIG_3"
                 CONE-TWIST-CONSTRAINT/SET-LIMIT/with-swing&twist&softness) :void
    (self :pointer)
    (_swingSpan1 :float)
    (_swingSpan2 :float)
    (_twistSpan :float)
    (_softness :float))
  (declaim (inline CONE-TWIST-CONSTRAINT/SET-LIMIT))
  (cffi:defcfun ("_wrap_btConeTwistConstraint_setLimit__SWIG_4"
                 CONE-TWIST-CONSTRAINT/SET-LIMIT/with-swing&twist) :void
    (self :pointer)
    (_swingSpan1 :float)
    (_swingSpan2 :float)
    (_twistSpan :float))
(declaim (inline CONE-TWIST-CONSTRAINT/GET-AFRAME))
(cffi:defcfun ("_wrap_btConeTwistConstraint_getAFrame"
               cONE-TWIST-CONSTRAINT/GET-AFRAME) :pointer
  (self :pointer))
(declaim (inline CONE-TWIST-CONSTRAINT/GET-BFRAME))
(cffi:defcfun ("_wrap_btConeTwistConstraint_getBFrame"
               cONE-TWIST-CONSTRAINT/GET-BFRAME) :pointer
  (self :pointer))
(declaim (inline CONE-TWIST-CONSTRAINT/GET-SOLVE-TWIST-LIMIT))
(cffi:defcfun ("_wrap_btConeTwistConstraint_getSolveTwistLimit"
               cONE-TWIST-CONSTRAINT/GET-SOLVE-TWIST-LIMIT) :int
  (self :pointer))
(declaim (inline CONE-TWIST-CONSTRAINT/GET-SOLVE-SWING-LIMIT))
(cffi:defcfun ("_wrap_btConeTwistConstraint_getSolveSwingLimit"
               cONE-TWIST-CONSTRAINT/GET-SOLVE-SWING-LIMIT) :int
  (self :pointer))
(declaim (inline CONE-TWIST-CONSTRAINT/GET-TWIST-LIMIT-SIGN))
(cffi:defcfun ("_wrap_btConeTwistConstraint_getTwistLimitSign"
               cONE-TWIST-CONSTRAINT/GET-TWIST-LIMIT-SIGN) :float
  (self :pointer))
(declaim (inline CONE-TWIST-CONSTRAINT/CALC-ANGLE-INFO))
(cffi:defcfun ("_wrap_btConeTwistConstraint_calcAngleInfo"
               cONE-TWIST-CONSTRAINT/CALC-ANGLE-INFO) :void
  (self :pointer))
(declaim (inline CONE-TWIST-CONSTRAINT/CALC-ANGLE-INFO-2))
(cffi:defcfun ("_wrap_btConeTwistConstraint_calcAngleInfo2"
               cONE-TWIST-CONSTRAINT/CALC-ANGLE-INFO-2) :void
  (self :pointer)
  (transA :pointer)
  (transB :pointer)
  (invInertiaWorldA :pointer)
  (invInertiaWorldB :pointer))
(declaim (inline CONE-TWIST-CONSTRAINT/GET-SWING-SPAN-1))
(cffi:defcfun ("_wrap_btConeTwistConstraint_getSwingSpan1"
               cONE-TWIST-CONSTRAINT/GET-SWING-SPAN-1) :float
  (self :pointer))
(declaim (inline CONE-TWIST-CONSTRAINT/GET-SWING-SPAN-2))
(cffi:defcfun ("_wrap_btConeTwistConstraint_getSwingSpan2"
               cONE-TWIST-CONSTRAINT/GET-SWING-SPAN-2) :float
  (self :pointer))
(declaim (inline CONE-TWIST-CONSTRAINT/GET-TWIST-SPAN))
(cffi:defcfun ("_wrap_btConeTwistConstraint_getTwistSpan"
               cONE-TWIST-CONSTRAINT/GET-TWIST-SPAN) :float
  (self :pointer))
(declaim (inline CONE-TWIST-CONSTRAINT/GET-TWIST-ANGLE))
(cffi:defcfun ("_wrap_btConeTwistConstraint_getTwistAngle"
               cONE-TWIST-CONSTRAINT/GET-TWIST-ANGLE) :float
  (self :pointer))
(declaim (inline CONE-TWIST-CONSTRAINT/IS-PAST-SWING-LIMIT))
(cffi:defcfun ("_wrap_btConeTwistConstraint_isPastSwingLimit"
               cONE-TWIST-CONSTRAINT/IS-PAST-SWING-LIMIT) :pointer
  (self :pointer))
(declaim (inline CONE-TWIST-CONSTRAINT/SET-DAMPING))
(cffi:defcfun ("_wrap_btConeTwistConstraint_setDamping"
               cONE-TWIST-CONSTRAINT/SET-DAMPING) :void
  (self :pointer)
  (damping :float))
(declaim (inline CONE-TWIST-CONSTRAINT/ENABLE-MOTOR))
(cffi:defcfun ("_wrap_btConeTwistConstraint_enableMotor"
               cONE-TWIST-CONSTRAINT/ENABLE-MOTOR) :void
  (self :pointer)
  (b :pointer))
(declaim (inline CONE-TWIST-CONSTRAINT/SET-MAX-MOTOR-IMPULSE))
(cffi:defcfun ("_wrap_btConeTwistConstraint_setMaxMotorImpulse"
               cONE-TWIST-CONSTRAINT/SET-MAX-MOTOR-IMPULSE) :void
  (self :pointer)
  (maxMotorImpulse :float))
(declaim (inline CONE-TWIST-CONSTRAINT/SET-MAX-MOTOR-IMPULSE-NORMALIZED))
(cffi:defcfun ("_wrap_btConeTwistConstraint_setMaxMotorImpulseNormalized"
               cONE-TWIST-CONSTRAINT/SET-MAX-MOTOR-IMPULSE-NORMALIZED) :void
  (self :pointer)
  (maxMotorImpulse :float))
(declaim (inline CONE-TWIST-CONSTRAINT/GET-FIX-THRESH))
(cffi:defcfun ("_wrap_btConeTwistConstraint_getFixThresh"
               cONE-TWIST-CONSTRAINT/GET-FIX-THRESH) :float
  (self :pointer))
(declaim (inline CONE-TWIST-CONSTRAINT/SET-FIX-THRESH))
(cffi:defcfun ("_wrap_btConeTwistConstraint_setFixThresh"
               cONE-TWIST-CONSTRAINT/SET-FIX-THRESH) :void
  (self :pointer)
  (fixThresh :float))
(declaim (inline CONE-TWIST-CONSTRAINT/SET-MOTOR-TARGET))
(cffi:defcfun ("_wrap_btConeTwistConstraint_setMotorTarget"
               cONE-TWIST-CONSTRAINT/SET-MOTOR-TARGET) :void
  (self :pointer)
  (q :pointer))
(declaim (inline CONE-TWIST-CONSTRAINT/SET-MOTOR-TARGET-IN-CONSTRAINT-SPACE))
(cffi:defcfun ("_wrap_btConeTwistConstraint_setMotorTargetInConstraintSpace"
               cONE-TWIST-CONSTRAINT/SET-MOTOR-TARGET-IN-CONSTRAINT-SPACE) :void
  (self :pointer)
  (q :pointer))
(declaim (inline CONE-TWIST-CONSTRAINT/GET-POINT-FOR-ANGLE))
(cffi:defcfun ("_wrap_btConeTwistConstraint_GetPointForAngle"
               cONE-TWIST-CONSTRAINT/GET-POINT-FOR-ANGLE) :pointer
  (self :pointer)
  (fAngleInRadians :float)
  (fLength :float))
(declaim (inline CONE-TWIST-CONSTRAINT/SET-FRAMES))
(cffi:defcfun ("_wrap_btConeTwistConstraint_setFrames"
               CONE-TWIST-CONSTRAINT/SET-FRAMES) :void
  (self :pointer)
  (frameA :pointer)
  (frameB :pointer))
(defmethod (setf frames) ((self CONE-TWIST-CONSTRAINT)
                          (frame-a transform)
                          (frame-b transform))
  (CONE-TWIST-CONSTRAINT/SET-FRAMES (ff-pointer self) 
                                    (ff-pointer frame-A)
                                    (ff-pointer frame-B)))
(declaim (inline CONE-TWIST-CONSTRAINT/GET-FRAME-OFFSET-A))
(cffi:defcfun ("_wrap_btConeTwistConstraint_getFrameOffsetA"
               cONE-TWIST-CONSTRAINT/GET-FRAME-OFFSET-A) :pointer
  (self :pointer))
(declaim (inline CONE-TWIST-CONSTRAINT/GET-FRAME-OFFSET-B))
(cffi:defcfun ("_wrap_btConeTwistConstraint_getFrameOffsetB"
               cONE-TWIST-CONSTRAINT/GET-FRAME-OFFSET-B) :pointer
  (self :pointer))
(declaim (inline CONE-TWIST-CONSTRAINT/CALCULATE-SERIALIZE-BUFFER-SIZE))
(cffi:defcfun ("_wrap_btConeTwistConstraint_calculateSerializeBufferSize"
               cONE-TWIST-CONSTRAINT/CALCULATE-SERIALIZE-BUFFER-SIZE) :int
  (self :pointer))
(declaim (inline CONE-TWIST-CONSTRAINT/SERIALIZE))
(cffi:defcfun ("_wrap_btConeTwistConstraint_serialize"
               cONE-TWIST-CONSTRAINT/SERIALIZE) :string
  (self :pointer)
  (dataBuffer :pointer)
  (serializer :pointer))
(declaim (inline DELETE/BT-CONE-TWIST-CONSTRAINT))
(cffi:defcfun ("_wrap_delete_btConeTwistConstraint"
               DELETE/BT-CONE-TWIST-CONSTRAINT) :void
  (self :pointer))

(define-constant +GENERIC-6-DOF-CONSTRAINT-DATA-NAME+ "btGeneric6DofConstraintData"
  :test 'equal)
(declaim (inline ROTATIONAL-LIMIT-MOTOR/LO-LIMIT/SET))
(cffi:defcfun ("_wrap_btRotationalLimitMotor_m_loLimit_set"
               ROTATIONAL-LIMIT-MOTOR/LO-LIMIT/SET) :void
  (self :pointer)
  (m_loLimit :float))
(declaim (inline ROTATIONAL-LIMIT-MOTOR/LO-LIMIT/GET))
(cffi:defcfun ("_wrap_btRotationalLimitMotor_m_loLimit_get"
               ROTATIONAL-LIMIT-MOTOR/LO-LIMIT/GET) :float
  (self :pointer))
(declaim (inline ROTATIONAL-LIMIT-MOTOR/HI-LIMIT/SET))
(cffi:defcfun ("_wrap_btRotationalLimitMotor_m_hiLimit_set"
               ROTATIONAL-LIMIT-MOTOR/HI-LIMIT/SET) :void
  (self :pointer)
  (m_hiLimit :float))
(declaim (inline ROTATIONAL-LIMIT-MOTOR/HI-LIMIT/GET))
(cffi:defcfun ("_wrap_btRotationalLimitMotor_m_hiLimit_get"
               ROTATIONAL-LIMIT-MOTOR/HI-LIMIT/GET) :float
  (self :pointer))
(declaim (inline ROTATIONAL-LIMIT-MOTOR/TARGET-VELOCITY/SET))
(cffi:defcfun ("_wrap_btRotationalLimitMotor_m_targetVelocity_set"
               ROTATIONAL-LIMIT-MOTOR/TARGET-VELOCITY/SET) :void
  (self :pointer)
  (m_targetVelocity :float))
(declaim (inline ROTATIONAL-LIMIT-MOTOR/TARGET-VELOCITY/GET))
(cffi:defcfun ("_wrap_btRotationalLimitMotor_m_targetVelocity_get"
               ROTATIONAL-LIMIT-MOTOR/TARGET-VELOCITY/GET) :float
  (self :pointer))
(declaim (inline ROTATIONAL-LIMIT-MOTOR/MAX-MOTOR-FORCE/SET))
(cffi:defcfun ("_wrap_btRotationalLimitMotor_m_maxMotorForce_set"
               ROTATIONAL-LIMIT-MOTOR/MAX-MOTOR-FORCE/SET) :void
  (self :pointer)
  (m_maxMotorForce :float))
(declaim (inline ROTATIONAL-LIMIT-MOTOR/MAX-MOTOR-FORCE/GET))
(cffi:defcfun ("_wrap_btRotationalLimitMotor_m_maxMotorForce_get"
               ROTATIONAL-LIMIT-MOTOR/MAX-MOTOR-FORCE/GET) :float
  (self :pointer))
(declaim (inline ROTATIONAL-LIMIT-MOTOR/MAX-LIMIT-FORCE/SET))
(cffi:defcfun ("_wrap_btRotationalLimitMotor_m_maxLimitForce_set"
               ROTATIONAL-LIMIT-MOTOR/MAX-LIMIT-FORCE/SET) :void
  (self :pointer)
  (m_maxLimitForce :float))
(declaim (inline ROTATIONAL-LIMIT-MOTOR/MAX-LIMIT-FORCE/GET))
(cffi:defcfun ("_wrap_btRotationalLimitMotor_m_maxLimitForce_get"
               ROTATIONAL-LIMIT-MOTOR/MAX-LIMIT-FORCE/GET) :float
  (self :pointer))
(declaim (inline ROTATIONAL-LIMIT-MOTOR/DAMPING/SET))
(cffi:defcfun ("_wrap_btRotationalLimitMotor_m_damping_set"
               ROTATIONAL-LIMIT-MOTOR/DAMPING/SET) :void
  (self :pointer)
  (m_damping :float))
(declaim (inline ROTATIONAL-LIMIT-MOTOR/DAMPING/GET))
(cffi:defcfun ("_wrap_btRotationalLimitMotor_m_damping_get"
               ROTATIONAL-LIMIT-MOTOR/DAMPING/GET) :float
  (self :pointer))
(declaim (inline ROTATIONAL-LIMIT-MOTOR/LIMIT-SOFTNESS/SET))
(cffi:defcfun ("_wrap_btRotationalLimitMotor_m_limitSoftness_set"
               ROTATIONAL-LIMIT-MOTOR/LIMIT-SOFTNESS/SET) :void
  (self :pointer)
  (m_limitSoftness :float))
(declaim (inline ROTATIONAL-LIMIT-MOTOR/LIMIT-SOFTNESS/GET))
(cffi:defcfun ("_wrap_btRotationalLimitMotor_m_limitSoftness_get"
               ROTATIONAL-LIMIT-MOTOR/LIMIT-SOFTNESS/GET) :float
  (self :pointer))
(declaim (inline ROTATIONAL-LIMIT-MOTOR/NORMAL-CFM/SET))
(cffi:defcfun ("_wrap_btRotationalLimitMotor_m_normalCFM_set"
               ROTATIONAL-LIMIT-MOTOR/NORMAL-CFM/SET) :void
  (self :pointer)
  (m_normalCFM :float))
(declaim (inline ROTATIONAL-LIMIT-MOTOR/NORMAL-CFM/GET))
(cffi:defcfun ("_wrap_btRotationalLimitMotor_m_normalCFM_get"
               ROTATIONAL-LIMIT-MOTOR/NORMAL-CFM/GET) :float
  (self :pointer))
(declaim (inline ROTATIONAL-LIMIT-MOTOR/STOP-ERP/SET))
(cffi:defcfun ("_wrap_btRotationalLimitMotor_m_stopERP_set"
               ROTATIONAL-LIMIT-MOTOR/STOP-ERP/SET) :void
  (self :pointer)
  (m_stopERP :float))
(declaim (inline ROTATIONAL-LIMIT-MOTOR/STOP-ERP/GET))
(cffi:defcfun ("_wrap_btRotationalLimitMotor_m_stopERP_get"
               ROTATIONAL-LIMIT-MOTOR/STOP-ERP/GET) :float
  (self :pointer))
(declaim (inline ROTATIONAL-LIMIT-MOTOR/STOP-CFM/SET))
(cffi:defcfun ("_wrap_btRotationalLimitMotor_m_stopCFM_set"
               ROTATIONAL-LIMIT-MOTOR/STOP-CFM/SET) :void
  (self :pointer)
  (m_stopCFM :float))
(declaim (inline ROTATIONAL-LIMIT-MOTOR/STOP-CFM/GET))
(cffi:defcfun ("_wrap_btRotationalLimitMotor_m_stopCFM_get"
               ROTATIONAL-LIMIT-MOTOR/STOP-CFM/GET) :float
  (self :pointer))
(declaim (inline ROTATIONAL-LIMIT-MOTOR/BOUNCE/SET))
(cffi:defcfun ("_wrap_btRotationalLimitMotor_m_bounce_set"
               ROTATIONAL-LIMIT-MOTOR/BOUNCE/SET) :void
  (self :pointer)
  (m_bounce :float))
(declaim (inline ROTATIONAL-LIMIT-MOTOR/BOUNCE/GET))
(cffi:defcfun ("_wrap_btRotationalLimitMotor_m_bounce_get"
               ROTATIONAL-LIMIT-MOTOR/BOUNCE/GET) :float
  (self :pointer))
(declaim (inline ROTATIONAL-LIMIT-MOTOR/ENABLE-MOTOR/SET))
(cffi:defcfun ("_wrap_btRotationalLimitMotor_m_enableMotor_set"
               ROTATIONAL-LIMIT-MOTOR/ENABLE-MOTOR/SET) :void
  (self :pointer)
  (m_enableMotor :pointer))
(declaim (inline ROTATIONAL-LIMIT-MOTOR/ENABLE-MOTOR/GET))
(cffi:defcfun ("_wrap_btRotationalLimitMotor_m_enableMotor_get"
               ROTATIONAL-LIMIT-MOTOR/ENABLE-MOTOR/GET) :pointer
  (self :pointer))
(declaim (inline ROTATIONAL-LIMIT-MOTOR/CURRENT-LIMIT-ERROR/SET))
(cffi:defcfun ("_wrap_btRotationalLimitMotor_m_currentLimitError_set"
               ROTATIONAL-LIMIT-MOTOR/CURRENT-LIMIT-ERROR/SET) :void
  (self :pointer)
  (m_currentLimitError :float))
(declaim (inline ROTATIONAL-LIMIT-MOTOR/CURRENT-LIMIT-ERROR/GET))
(cffi:defcfun ("_wrap_btRotationalLimitMotor_m_currentLimitError_get"
               ROTATIONAL-LIMIT-MOTOR/CURRENT-LIMIT-ERROR/GET) :float
  (self :pointer))
(declaim (inline ROTATIONAL-LIMIT-MOTOR/CURRENT-POSITION/SET))
(cffi:defcfun ("_wrap_btRotationalLimitMotor_m_currentPosition_set"
               ROTATIONAL-LIMIT-MOTOR/CURRENT-POSITION/SET) :void
  (self :pointer)
  (m_currentPosition :float))
(declaim (inline ROTATIONAL-LIMIT-MOTOR/CURRENT-POSITION/GET))
(cffi:defcfun ("_wrap_btRotationalLimitMotor_m_currentPosition_get"
               ROTATIONAL-LIMIT-MOTOR/CURRENT-POSITION/GET) :float
  (self :pointer))
(declaim (inline ROTATIONAL-LIMIT-MOTOR/CURRENT-LIMIT/SET))
(cffi:defcfun ("_wrap_btRotationalLimitMotor_m_currentLimit_set"
               ROTATIONAL-LIMIT-MOTOR/CURRENT-LIMIT/SET) :void
  (self :pointer)
  (m_currentLimit :int))
(declaim (inline ROTATIONAL-LIMIT-MOTOR/CURRENT-LIMIT/GET))
(cffi:defcfun ("_wrap_btRotationalLimitMotor_m_currentLimit_get"
               ROTATIONAL-LIMIT-MOTOR/CURRENT-LIMIT/GET) :int
  (self :pointer))
(declaim (inline ROTATIONAL-LIMIT-MOTOR/ACCUMULATED-IMPULSE/SET))
(cffi:defcfun ("_wrap_btRotationalLimitMotor_m_accumulatedImpulse_set"
               ROTATIONAL-LIMIT-MOTOR/ACCUMULATED-IMPULSE/SET) :void
  (self :pointer)
  (m_accumulatedImpulse :float))
(declaim (inline ROTATIONAL-LIMIT-MOTOR/ACCUMULATED-IMPULSE/GET))
(cffi:defcfun ("_wrap_btRotationalLimitMotor_m_accumulatedImpulse_get"
               ROTATIONAL-LIMIT-MOTOR/ACCUMULATED-IMPULSE/GET) :float
  (self :pointer))
(declaim (inline MAKE-ROTATIONAL-LIMIT-MOTOR))
(cffi:defcfun ("_wrap_new_btRotationalLimitMotor__SWIG_0"
               MAKE-ROTATIONAL-LIMIT-MOTOR) :pointer)
(declaim (inline MAKE-ROTATIONAL-LIMIT-MOTOR))
(cffi:defcfun ("_wrap_new_btRotationalLimitMotor__SWIG_1"
               MAKE-ROTATIONAL-LIMIT-MOTOR/with-limot) :pointer
  (limot :pointer))
(declaim (inline ROTATIONAL-LIMIT-MOTOR/IS-LIMITED))
(cffi:defcfun ("_wrap_btRotationalLimitMotor_isLimited"
               ROTATIONAL-LIMIT-MOTOR/IS-LIMITED) :pointer
  (self :pointer))
(declaim (inline ROTATIONAL-LIMIT-MOTOR/NEED-APPLY-TORQUES))
(cffi:defcfun ("_wrap_btRotationalLimitMotor_needApplyTorques"
               ROTATIONAL-LIMIT-MOTOR/NEED-APPLY-TORQUES) :pointer
  (self :pointer))
(declaim (inline ROTATIONAL-LIMIT-MOTOR/TEST-LIMIT-VALUE))
(cffi:defcfun ("_wrap_btRotationalLimitMotor_testLimitValue"
               ROTATIONAL-LIMIT-MOTOR/TEST-LIMIT-VALUE) :int
  (self :pointer)
  (test_value :float))
(declaim (inline ROTATIONAL-LIMIT-MOTOR/SOLVE-ANGULAR-LIMITS))
(cffi:defcfun ("_wrap_btRotationalLimitMotor_solveAngularLimits"
               ROTATIONAL-LIMIT-MOTOR/SOLVE-ANGULAR-LIMITS) :float
  (self :pointer)
  (timeStep :float)
  (axis :pointer)
  (jacDiagABInv :float)
  (body0 :pointer)
  (body1 :pointer))
(declaim (inline DELETE/BT-ROTATIONAL-LIMIT-MOTOR))
(cffi:defcfun ("_wrap_delete_btRotationalLimitMotor"
               DELETE/BT-ROTATIONAL-LIMIT-MOTOR) :void
  (self :pointer))
(declaim (inline TRANSLATIONAL-LIMIT-MOTOR/LOWER-LIMIT/SET))
(cffi:defcfun ("_wrap_btTranslationalLimitMotor_m_lowerLimit_set"
               TRANSLATIONAL-LIMIT-MOTOR/LOWER-LIMIT/SET) :void
  (self :pointer)
  (m_lowerLimit :pointer))
(declaim (inline TRANSLATIONAL-LIMIT-MOTOR/LOWER-LIMIT/GET))
(cffi:defcfun ("_wrap_btTranslationalLimitMotor_m_lowerLimit_get"
               TRANSLATIONAL-LIMIT-MOTOR/LOWER-LIMIT/GET) :pointer
  (self :pointer))
(declaim (inline TRANSLATIONAL-LIMIT-MOTOR/UPPER-LIMIT/SET))
(cffi:defcfun ("_wrap_btTranslationalLimitMotor_m_upperLimit_set"
               TRANSLATIONAL-LIMIT-MOTOR/UPPER-LIMIT/SET) :void
  (self :pointer)
  (m_upperLimit :pointer))
(declaim (inline TRANSLATIONAL-LIMIT-MOTOR/UPPER-LIMIT/GET))
(cffi:defcfun ("_wrap_btTranslationalLimitMotor_m_upperLimit_get"
               TRANSLATIONAL-LIMIT-MOTOR/UPPER-LIMIT/GET) :pointer
  (self :pointer))
(declaim (inline TRANSLATIONAL-LIMIT-MOTOR/ACCUMULATED-IMPULSE/SET))
(cffi:defcfun ("_wrap_btTranslationalLimitMotor_m_accumulatedImpulse_set"
               TRANSLATIONAL-LIMIT-MOTOR/ACCUMULATED-IMPULSE/SET) :void
  (self :pointer)
  (m_accumulatedImpulse :pointer))
(declaim (inline TRANSLATIONAL-LIMIT-MOTOR/ACCUMULATED-IMPULSE/GET))
(cffi:defcfun ("_wrap_btTranslationalLimitMotor_m_accumulatedImpulse_get"
               TRANSLATIONAL-LIMIT-MOTOR/ACCUMULATED-IMPULSE/GET) :pointer
  (self :pointer))

