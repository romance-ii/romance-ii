(in-package #:bullet-physics)


(defmethod set-frames ((self CONE-TWIST-CONSTRAINT) (frameA transform) (frameB transform))
  (CONE-TWIST-CONSTRAINT/SET-FRAMES (ff-pointer self) frameA frameB)))

(cffi:defcstruct LOCAL-SHAPE-INFO
  (SHAPE-PART :int)
  (TRIANGLE-INDEX :int))

(cffi:defcstruct LOCAL-RAY-RESULT
  (COLLISION-OBJECT :pointer)
  (LOCAL-SHAPE-INFO :pointer)
  (HIT-NORMAL-LOCAL :pointer)
  (HIT-FRACTION :float))

(cffi:defcstruct RAY-RESULT-CALLBACK 
  (CLOSEST-HIT-FRACTION :float)
  (collision-object :pointer)
  (COLLISION-FILTER-GROUP :short)
  (COLLISION-FILTER-MASK :short)
  (FLAGS :unsigned-int)
  (has-hit :pointer)
  (NEEDS-COLLISION :pointer)
  (add-single-result :pointer))

(cffi:defcstruct CLOSEST-RAY-RESULT-CALLBACK
  (RAY-FROM-WORLD :pointer)
  (RAY-TO-WORLD :pointer)
  (HIT-NORMAL-WORLD :pointer)
  (HIT-POINT-WORLD :pointer)
  (ADD-SINGLE-RESULT :pointer))

(cffi:defcstruct ALL-HITS-RAY-RESULT-CALLBACK
  (COLLISION-OBJECTS :pointer)
  (RAY-FROM-WORLD :pointer)
  (RAY-TO-WORLD :pointer)
  (HIT-NORMAL-WORLD :pointer)
  (HIT-POINT-WORLD :pointer)
  (HIT-FRACTIONS :pointer)
  (ADD-SINGLE-RESULT :pointer))

(cffi:defcstruct LOCAL-CONVEX-RESULT
  (HIT-COLLISION-OBJECT :pointer)
  (LOCAL-SHAPE-INFO :pointer)
  (HIT-NORMAL-LOCAL :pointer)
  (HIT-POINT-LOCAL :pointer)
  (HIT-FRACTION :float))

(cffi:defcstruct CONVEX-RESULT-CALLBACK
  (CLOSEST-HIT-FRACTION :float)
  (COLLISION-FILTER-GROUP :short)
  (COLLISION-FILTER-MASK :short)
  (HAS-HIT :pointer)
  (NEEDS-COLLISION :pointer)
  (ADD-SINGLE-RESULT :pointer))

(cffi:defcstruct CLOSEST-CONVEX-RESULT-CALLBACK
  (CONVEX-FROM-WORLD :pointer)
  (CONVEX-TO-WORLD :pointer)
  (HIT-NORMAL-WORLD :pointer)
  (HIT-POINT-WORLD :pointer)
  (HIT-COLLISION-OBJECT :pointer)
  (ADD-SINGLE-RESULT :pointer))

(cffi:defcstruct CONTACT-RESULT-CALLBACK
  (COLLISION-FILTER-GROUP :short)
  (COLLISION-FILTER-MASK :short)
  (NEEDS-COLLISION :pointer)
  (ADD-SINGLE-RESULT :pointer))

(declaim (inline MAKE-COLLISION-WORLD))

(cffi:defcfun ("_wrap_new_btCollisionWorld" MAKE-COLLISION-WORLD) :pointer
  (dispatcher :pointer)
  (broadphasePairCache :pointer)
  (collisionConfiguration :pointer))

(declaim (inline DELETE/BT-COLLISION-WORLD))

(cffi:defcfun ("_wrap_delete_btCollisionWorld" DELETE/BT-COLLISION-WORLD) :void
  (self :pointer))

(declaim (inline COLLISION-WORLD/SET-BROADPHASE))

(cffi:defcfun ("_wrap_btCollisionWorld_setBroadphase" COLLISION-WORLD/SET-BROADPHASE) :void
  (self :pointer)
  (pairCache :pointer))

(declaim (inline COLLISION-WORLD/GET-BROADPHASE))

(cffi:defcfun ("_wrap_btCollisionWorld_getBroadphase__SWIG_0"
               COLLISION-WORLD/GET-BROADPHASE) :pointer
  (self :pointer))

#+ (or)
(progn
  (declaim (inline COLLISION-WORLD/GET-BROADPHASE))

 (cffi:defcfun ("_wrap_btCollisionWorld_getBroadphase__SWIG_1"
                COLLISION-WORLD/GET-BROADPHASE) :pointer
   (self :pointer))

 )

(declaim (inline COLLISION-WORLD/GET-PAIR-CACHE))

(cffi:defcfun ("_wrap_btCollisionWorld_getPairCache" COLLISION-WORLD/GET-PAIR-CACHE) :pointer
  (self :pointer))

(declaim (inline COLLISION-WORLD/GET-DISPATCHER))

(cffi:defcfun ("_wrap_btCollisionWorld_getDispatcher__SWIG_0" COLLISION-WORLD/GET-DISPATCHER) :pointer
  (self :pointer))

#+ (or)
(progn
  (declaim (inline COLLISION-WORLD/GET-DISPATCHER))

  (cffi:defcfun ("_wrap_btCollisionWorld_getDispatcher__SWIG_1" COLLISION-WORLD/GET-DISPATCHER) :pointer
   (self :pointer))

 )

(declaim (inline COLLISION-WORLD/UPDATE-SINGLE-AABB))

(cffi:defcfun ("_wrap_btCollisionWorld_updateSingleAabb" COLLISION-WORLD/UPDATE-SINGLE-AABB) :void
  (self :pointer)
  (colObj :pointer))

(declaim (inline COLLISION-WORLD/UPDATE-AABBS))

(cffi:defcfun ("_wrap_btCollisionWorld_updateAabbs" COLLISION-WORLD/UPDATE-AABBS) :void
  (self :pointer))

(declaim (inline COLLISION-WORLD/COMPUTE-OVERLAPPING-PAIRS))

(cffi:defcfun ("_wrap_btCollisionWorld_computeOverlappingPairs" COLLISION-WORLD/COMPUTE-OVERLAPPING-PAIRS) :void
  (self :pointer))

(declaim (inline COLLISION-WORLD/SET-DEBUG-DRAWER))

(cffi:defcfun ("_wrap_btCollisionWorld_setDebugDrawer" COLLISION-WORLD/SET-DEBUG-DRAWER) :void
  (self :pointer)
  (debugDrawer :pointer))

(declaim (inline COLLISION-WORLD/GET-DEBUG-DRAWER))

(cffi:defcfun ("_wrap_btCollisionWorld_getDebugDrawer" COLLISION-WORLD/GET-DEBUG-DRAWER) :pointer
  (self :pointer))

(declaim (inline COLLISION-WORLD/DEBUG-DRAW-WORLD))

(cffi:defcfun ("_wrap_btCollisionWorld_debugDrawWorld" COLLISION-WORLD/DEBUG-DRAW-WORLD) :void
  (self :pointer))

(declaim (inline COLLISION-WORLD/DEBUG-DRAW-OBJECT))

(cffi:defcfun ("_wrap_btCollisionWorld_debugDrawObject" COLLISION-WORLD/DEBUG-DRAW-OBJECT) :void
  (self :pointer)
  (worldTransform :pointer)
  (shape :pointer)
  (color :pointer))

(declaim (inline COLLISION-WORLD/GET-NUM-COLLISION-OBJECTS))

(cffi:defcfun ("_wrap_btCollisionWorld_getNumCollisionObjects" COLLISION-WORLD/GET-NUM-COLLISION-OBJECTS) :int
  (self :pointer))

(declaim (inline COLLISION-WORLD/RAY-TEST))

(cffi:defcfun ("_wrap_btCollisionWorld_rayTest" COLLISION-WORLD/RAY-TEST) :void
  (self :pointer)
  (rayFromWorld :pointer)
  (rayToWorld :pointer)
  (resultCallback :pointer))

(declaim (inline              
          COLLISION-WORLD/CONVEX-SWEEP-TEST/WITH-CCD-PENETRATION))

(cffi:defcfun ("_wrap_btCollisionWorld_convexSweepTest__SWIG_0"
               COLLISION-WORLD/CONVEX-SWEEP-TEST/WITH-CCD-PENETRATION) :void
  (self :pointer)
  (castShape :pointer)
  (from :pointer)
  (to :pointer)
  (resultCallback :pointer)
  (allowedCcdPenetration :float))

(declaim (inline 
          COLLISION-WORLD/CONVEX-SWEEP-TEST/WITHOUT-CCD-PENETRATION))

(cffi:defcfun ("_wrap_btCollisionWorld_convexSweepTest__SWIG_1" 
               COLLISION-WORLD/CONVEX-SWEEP-TEST/WITHOUT-CCD-PENETRATION) :void
  (self :pointer)
  (castShape :pointer)
  (from :pointer)
  (to :pointer)
  (resultCallback :pointer))

(defun COLLISION-WORLD/CONVEX-SWEEP-TEST
    (self cast-shape from to result-callback 
     &key (allowed-ccd-penetration nil allowed-?))
  (if allowed-?
      (COLLISION-WORLD/CONVEX-SWEEP-TEST/WITH-CCD-PENETRATION
       self cast-shape from to result-callback allowed-ccd-penetration)
      (COLLISION-WORLD/CONVEX-SWEEP-TEST/WITHOUT-CCD-PENETRATION
       self cast-shape from to result-callback)))

(declaim (inline COLLISION-WORLD/CONTACT-TEST))

(cffi:defcfun ("_wrap_btCollisionWorld_contactTest"
               COLLISION-WORLD/CONTACT-TEST) :void
  (self :pointer)
  (colObj :pointer)
  (resultCallback :pointer))

(declaim (inline COLLISION-WORLD/CONTACT-PAIR-TEST))

(cffi:defcfun ("_wrap_btCollisionWorld_contactPairTest" COLLISION-WORLD/CONTACT-PAIR-TEST) :void
  (self :pointer)
  (colObjA :pointer)
  (colObjB :pointer)
  (resultCallback :pointer))

(declaim (inline COLLISION-WORLD/RAY-TEST-SINGLE))

(cffi:defcfun ("_wrap_btCollisionWorld_rayTestSingle" COLLISION-WORLD/RAY-TEST-SINGLE) :void
  (rayFromTrans :pointer)
  (rayToTrans :pointer)
  (collisionObject :pointer)
  (collisionShape :pointer)
  (colObjWorldTransform :pointer)
  (resultCallback :pointer))

(declaim (inline COLLISION-WORLD/RAY-TEST-SINGLE-INTERNAL))

(cffi:defcfun ("_wrap_btCollisionWorld_rayTestSingleInternal" COLLISION-WORLD/RAY-TEST-SINGLE-INTERNAL) :void
  (rayFromTrans :pointer)
  (rayToTrans :pointer)
  (collisionObjectWrap :pointer)
  (resultCallback :pointer))

(declaim (inline COLLISION-WORLD/OBJECT-QUERY-SINGLE))

(cffi:defcfun ("_wrap_btCollisionWorld_objectQuerySingle" COLLISION-WORLD/OBJECT-QUERY-SINGLE) :void
  (castShape :pointer)
  (rayFromTrans :pointer)
  (rayToTrans :pointer)
  (collisionObject :pointer)
  (collisionShape :pointer)
  (colObjWorldTransform :pointer)
  (resultCallback :pointer)
  (allowedPenetration :float))

(declaim (inline COLLISION-WORLD/OBJECT-QUERY-SINGLE-INTERNAL))

(cffi:defcfun ("_wrap_btCollisionWorld_objectQuerySingleInternal" COLLISION-WORLD/OBJECT-QUERY-SINGLE-INTERNAL) :void
  (castShape :pointer)
  (convexFromTrans :pointer)
  (convexToTrans :pointer)
  (colObjWrap :pointer)
  (resultCallback :pointer)
  (allowedPenetration :float))

(declaim (inline COLLISION-WORLD/ADD-COLLISION-OBJECT/with-filter-group&mask))

(cffi:defcfun ("_wrap_btCollisionWorld_addCollisionObject__SWIG_0"
               COLLISION-WORLD/ADD-COLLISION-OBJECT/with-filter-group&mask) :void
  (self :pointer)
  (collisionObject :pointer)
  (collisionFilterGroup :short)
  (collisionFilterMask :short))

(declaim (inline COLLISION-WORLD/ADD-COLLISION-OBJECT/with-filter-group))

(cffi:defcfun ("_wrap_btCollisionWorld_addCollisionObject__SWIG_1"
               COLLISION-WORLD/ADD-COLLISION-OBJECT/with-filter-group) :void
  (self :pointer)
  (collisionObject :pointer)
  (collisionFilterGroup :short))

(declaim (inline COLLISION-WORLD/ADD-COLLISION-OBJECT/simple))

(cffi:defcfun ("_wrap_btCollisionWorld_addCollisionObject__SWIG_2"
               COLLISION-WORLD/ADD-COLLISION-OBJECT/simple) :void
  (self :pointer)
  (collisionObject :pointer))

(declaim (inline COLLISION-WORLD/ADD-COLLISION-OBJECT))

(defun COLLISION-WORLD/ADD-COLLISION-OBJECT
    (self collision-object &key
                             (filter-group  nil filter-group-?)
                             (filter-mask   nil filter-mask-?))
  (cond
    (filter-mask-? (COLLISION-WORLD/ADD-COLLISION-OBJECT/with-filter-group&mask
                    self collision-object filter-group filter-mask))
    (filter-group-? (COLLISION-WORLD/ADD-COLLISION-OBJECT/with-filter-group
                     self collision-object filter-group))
    (t (COLLISION-WORLD/ADD-COLLISION-OBJECT/simple
        self collision-object))))

(declaim (inline COLLISION-WORLD/GET-COLLISION-OBJECT-ARRAY))

(cffi:defcfun ("_wrap_btCollisionWorld_getCollisionObjectArray__SWIG_0"
               COLLISION-WORLD/GET-COLLISION-OBJECT-ARRAY) :pointer
  (self :pointer))

#+ (or)
(progn
  (declaim (inline COLLISION-WORLD/GET-COLLISION-OBJECT-ARRAY))

 (cffi:defcfun ("_wrap_btCollisionWorld_getCollisionObjectArray__SWIG_1"
                COLLISION-WORLD/GET-COLLISION-OBJECT-ARRAY) :pointer
   (self :pointer))

 
 )
(declaim (inline COLLISION-WORLD/REMOVE-COLLISION-OBJECT))

(cffi:defcfun ("_wrap_btCollisionWorld_removeCollisionObject" COLLISION-WORLD/REMOVE-COLLISION-OBJECT) :void
  (self :pointer)
  (collisionObject :pointer))

(declaim (inline COLLISION-WORLD/PERFORM-DISCRETE-COLLISION-DETECTION))

(cffi:defcfun ("_wrap_btCollisionWorld_performDiscreteCollisionDetection" COLLISION-WORLD/PERFORM-DISCRETE-COLLISION-DETECTION) :void
  (self :pointer))

(declaim (inline COLLISION-WORLD/GET-DISPATCH-INFO))

(cffi:defcfun ("_wrap_btCollisionWorld_getDispatchInfo__SWIG_0" COLLISION-WORLD/GET-DISPATCH-INFO) :pointer
  (self :pointer))

#+ (or)
(progn
  (declaim (inline COLLISION-WORLD/GET-DISPATCH-INFO))

  (cffi:defcfun ("_wrap_btCollisionWorld_getDispatchInfo__SWIG_1" COLLISION-WORLD/GET-DISPATCH-INFO) :pointer
   (self :pointer))

 )

(declaim (inline COLLISION-WORLD/GET-FORCE-UPDATE-ALL-AABBS))

(cffi:defcfun ("_wrap_btCollisionWorld_getForceUpdateAllAabbs" COLLISION-WORLD/GET-FORCE-UPDATE-ALL-AABBS) :pointer
  (self :pointer))

(declaim (inline COLLISION-WORLD/SET-FORCE-UPDATE-ALL-AABBS))

(cffi:defcfun ("_wrap_btCollisionWorld_setForceUpdateAllAabbs" COLLISION-WORLD/SET-FORCE-UPDATE-ALL-AABBS) :void
  (self :pointer)
  (forceUpdateAllAabbs :pointer))

(declaim (inline COLLISION-WORLD/SERIALIZE))

(cffi:defcfun ("_wrap_btCollisionWorld_serialize" COLLISION-WORLD/SERIALIZE) :void
  (self :pointer)
  (serializer :pointer))

(define-constant +ACTIVE-TAG+ 1)

(define-constant +ISLAND-SLEEPING+ 2)

(define-constant +WANTS-DEACTIVATION+ 3)

(define-constant +DISABLE-DEACTIVATION+ 4)

(define-constant +DISABLE-SIMULATION+ 5)

(alexandria:define-constant +COLLISION-OBJECT-DATA-NAME+
  "btCollisionObjectFloatData" :test 'equal)

(cffi:defcenum COLLISION-FLAGS
  (:CF-STATIC-OBJECT #.1)
  (:CF-KINEMATIC-OBJECT #.2)
  (:CF-NO-CONTACT-RESPONSE #.4)
  (:CF-CUSTOM-MATERIAL-CALLBACK #.8)
  (:CF-CHARACTER-OBJECT #.16)
  (:CF-DISABLE-VISUALIZE-OBJECT #.32)
  (:CF-DISABLE-SPU-COLLISION-PROCESSING #.64))

(cffi:defcenum COLLISION-OBJECT-TYPES
  (:CO-COLLISION-OBJECT #.1)
  (:CO-RIGID-BODY #.2)
  (:CO-GHOST-OBJECT #.4)
  (:CO-SOFT-BODY #.8)
  (:CO-HF-FLUID #.16)
  (:CO-USER-TYPE #.32)
  (:CO-FEATHERSTONE-LINK #.64))

(cffi:defcenum ANISOTROPIC-FRICTION-FLAGS
  (:CF-ANISOTROPIC-FRICTION-DISABLED #.0)
  (:CF-ANISOTROPIC-FRICTION #.1)
  (:CF-ANISOTROPIC-ROLLING-FRICTION #.2))

(declaim (inline COLLISION-OBJECT/MERGES-SIMULATION-ISLANDS))

(cffi:defcfun ("_wrap_btCollisionObject_mergesSimulationIslands" COLLISION-OBJECT/MERGES-SIMULATION-ISLANDS) :pointer
  (self :pointer))

(declaim (inline COLLISION-OBJECT/GET-ANISOTROPIC-FRICTION))

(cffi:defcfun ("_wrap_btCollisionObject_getAnisotropicFriction" COLLISION-OBJECT/GET-ANISOTROPIC-FRICTION) :pointer
  (self :pointer))

(declaim (inline COLLISION-OBJECT/SET-ANISOTROPIC-FRICTION/with-mode))

(cffi:defcfun ("_wrap_btCollisionObject_setAnisotropicFriction__SWIG_0"
               COLLISION-OBJECT/SET-ANISOTROPIC-FRICTION/with-mode) :void
  (self :pointer)
  (anisotropicFriction :pointer)
  (frictionMode :int))

(declaim (inline COLLISION-OBJECT/SET-ANISOTROPIC-FRICTION/without-mode))

(cffi:defcfun ("_wrap_btCollisionObject_setAnisotropicFriction__SWIG_1"
               COLLISION-OBJECT/SET-ANISOTROPIC-FRICTION/without-mode) :void
  (self :pointer)
  (anisotropicFriction :pointer))

(declaim (inline COLLISION-OBJECT/SET-ANISOTROPIC-FRICTIONn))

(defun COLLISION-OBJECT/SET-ANISOTROPIC-FRICTION
    (self anisotropic-friction &key (friction-mode nil friction-mode-?))
  (if friction-mode-?
      (COLLISION-OBJECT/SET-ANISOTROPIC-FRICTION/with-mode
       self anisotropic-friction friction-mode)
      (COLLISION-OBJECT/SET-ANISOTROPIC-FRICTION/without-mode
       self anisotropic-friction)))

(declaim (inline COLLISION-OBJECT/HAS-ANISOTROPIC-FRICTION/with-mode))

(cffi:defcfun ("_wrap_btCollisionObject_hasAnisotropicFriction__SWIG_0" 
               COLLISION-OBJECT/HAS-ANISOTROPIC-FRICTION/with-mode) :pointer
  (self :pointer)
  (frictionMode :int))

(declaim (inline COLLISION-OBJECT/HAS-ANISOTROPIC-FRICTION/without-mode))

(cffi:defcfun ("_wrap_btCollisionObject_hasAnisotropicFriction__SWIG_1"
               COLLISION-OBJECT/HAS-ANISOTROPIC-FRICTION/without-mode) :pointer
  (self :pointer))

(declaim (inline COLLISION-OBJECT/HAS-ANISOTROPIC-FRICTION))

(defun COLLISION-OBJECT/HAS-ANISOTROPIC-FRICTION
    (self &key (friction-mode nil friction-mode-?))
  (if friction-mode-?
      (COLLISION-OBJECT/HAS-ANISOTROPIC-FRICTION/with-mode
       self friction-mode)
      (COLLISION-OBJECT/HAS-ANISOTROPIC-FRICTION/without-mode self)))

(declaim (inline COLLISION-OBJECT/SET-CONTACT-PROCESSING-THRESHOLD))

(cffi:defcfun ("_wrap_btCollisionObject_setContactProcessingThreshold" COLLISION-OBJECT/SET-CONTACT-PROCESSING-THRESHOLD) :void
  (self :pointer)
  (contactProcessingThreshold :float))

(declaim (inline COLLISION-OBJECT/GET-CONTACT-PROCESSING-THRESHOLD))

(cffi:defcfun ("_wrap_btCollisionObject_getContactProcessingThreshold" COLLISION-OBJECT/GET-CONTACT-PROCESSING-THRESHOLD) :float
  (self :pointer))

(declaim (inline COLLISION-OBJECT/IS-STATIC-OBJECT))

(cffi:defcfun ("_wrap_btCollisionObject_isStaticObject" COLLISION-OBJECT/IS-STATIC-OBJECT) :pointer
  (self :pointer))

(declaim (inline COLLISION-OBJECT/IS-KINEMATIC-OBJECT))

(cffi:defcfun ("_wrap_btCollisionObject_isKinematicObject" COLLISION-OBJECT/IS-KINEMATIC-OBJECT) :pointer
  (self :pointer))

(declaim (inline COLLISION-OBJECT/IS-STATIC-OR-KINEMATIC-OBJECT))

(cffi:defcfun ("_wrap_btCollisionObject_isStaticOrKinematicObject" BULLET> ) :pointer
  (self :pointer))

(declaim (inline (lispify "btCollisionObject_isStaticOrKinematicObject" 'function)))

(cffi:defcfun ("_wrap_btCollisionObject_hasContactResponse" COLLISION-OBJECT/HAS-CONTACT-RESPONSE) :pointer
  (self :pointer))

(declaim (inline MAKE-COLLISION-OBJECT))

(cffi:defcfun ("_wrap_new_btCollisionObject" MAKE-COLLISION-OBJECT) :pointer)

(declaim (inline DELETE/BT-COLLISION-OBJECT))

(cffi:defcfun ("_wrap_delete_btCollisionObject" DELETE/BT-COLLISION-OBJECT) :void
  (self :pointer))

(declaim (inline COLLISION-OBJECT/SET-COLLISION-SHAPE))

(cffi:defcfun ("_wrap_btCollisionObject_setCollisionShape" COLLISION-OBJECT/SET-COLLISION-SHAPE) :void
  (self :pointer)
  (collisionShape :pointer))

(declaim (inline COLLISION-OBJECT/GET-COLLISION-SHAPE))

(cffi:defcfun ("_wrap_btCollisionObject_getCollisionShape__SWIG_0" COLLISION-OBJECT/GET-COLLISION-SHAPE) :pointer
  (self :pointer))

#+ (or)
(progn 
  (declaim (inline COLLISION-OBJECT/GET-COLLISION-SHAPE))

  (cffi:defcfun ("_wrap_btCollisionObject_getCollisionShape__SWIG_1" COLLISION-OBJECT/GET-COLLISION-SHAPE) :pointer
   (self :pointer))

 )

(declaim (inline COLLISION-OBJECT/INTERNAL-GET-EXTENSION-POINTER))

(cffi:defcfun ("_wrap_btCollisionObject_internalGetExtensionPointer" COLLISION-OBJECT/INTERNAL-GET-EXTENSION-POINTER) :pointer
  (self :pointer))

(declaim (inline COLLISION-OBJECT/INTERNAL-SET-EXTENSION-POINTER))

(cffi:defcfun ("_wrap_btCollisionObject_internalSetExtensionPointer" COLLISION-OBJECT/INTERNAL-SET-EXTENSION-POINTER) :void
  (self :pointer)
  (pointer :pointer))

(declaim (inline COLLISION-OBJECT/GET-ACTIVATION-STATE))

(cffi:defcfun ("_wrap_btCollisionObject_getActivationState" COLLISION-OBJECT/GET-ACTIVATION-STATE) :int
  (self :pointer))

(declaim (inline COLLISION-OBJECT/SET-ACTIVATION-STATE))

(cffi:defcfun ("_wrap_btCollisionObject_setActivationState" COLLISION-OBJECT/SET-ACTIVATION-STATE) :void
  (self :pointer)
  (newState :int))

(declaim (inline COLLISION-OBJECT/SET-DEACTIVATION-TIME))

(cffi:defcfun ("_wrap_btCollisionObject_setDeactivationTime" COLLISION-OBJECT/SET-DEACTIVATION-TIME) :void
  (self :pointer)
  (time :float))

(declaim (inline COLLISION-OBJECT/GET-DEACTIVATION-TIME))

(cffi:defcfun ("_wrap_btCollisionObject_getDeactivationTime" COLLISION-OBJECT/GET-DEACTIVATION-TIME) :float
  (self :pointer))

(declaim (inline COLLISION-OBJECT/FORCE-ACTIVATION-STATE))

(cffi:defcfun ("_wrap_btCollisionObject_forceActivationState" COLLISION-OBJECT/FORCE-ACTIVATION-STATE) :void
  (self :pointer)
  (newState :int))

(declaim (inline COLLISION-OBJECT/ACTIVATE/force))

(cffi:defcfun ("_wrap_btCollisionObject_activate__SWIG_0"
               COLLISION-OBJECT/ACTIVATE/force) :void
  (self :pointer)
  (forceActivation :pointer))

(declaim (inline COLLISION-OBJECT/ACTIVATE))

(cffi:defcfun ("_wrap_btCollisionObject_activate__SWIG_1"
               COLLISION-OBJECT/ACTIVATE) :void
  (self :pointer))

(declaim (inline COLLISION-OBJECT/IS-ACTIVE))

(cffi:defcfun ("_wrap_btCollisionObject_isActive" COLLISION-OBJECT/IS-ACTIVE) :pointer
  (self :pointer))

(declaim (inline COLLISION-OBJECT/SET-RESTITUTION))

(cffi:defcfun ("_wrap_btCollisionObject_setRestitution" COLLISION-OBJECT/SET-RESTITUTION) :void
  (self :pointer)
  (rest :float))

(declaim (inline COLLISION-OBJECT/GET-RESTITUTION))

(cffi:defcfun ("_wrap_btCollisionObject_getRestitution" COLLISION-OBJECT/GET-RESTITUTION) :float
  (self :pointer))

(declaim (inline COLLISION-OBJECT/SET-FRICTION))

(cffi:defcfun ("_wrap_btCollisionObject_setFriction" COLLISION-OBJECT/SET-FRICTION) :void
  (self :pointer)
  (frict :float))

(declaim (inline COLLISION-OBJECT/GET-FRICTION))

(cffi:defcfun ("_wrap_btCollisionObject_getFriction" COLLISION-OBJECT/GET-FRICTION) :float
  (self :pointer))

(declaim (inline COLLISION-OBJECT/SET-ROLLING-FRICTION))

(cffi:defcfun ("_wrap_btCollisionObject_setRollingFriction" COLLISION-OBJECT/SET-ROLLING-FRICTION) :void
  (self :pointer)
  (frict :float))

(declaim (inline COLLISION-OBJECT/GET-ROLLING-FRICTION))

(cffi:defcfun ("_wrap_btCollisionObject_getRollingFriction" COLLISION-OBJECT/GET-ROLLING-FRICTION) :float
  (self :pointer))

(declaim (inline COLLISION-OBJECT/GET-INTERNAL-TYPE))

(cffi:defcfun ("_wrap_btCollisionObject_getInternalType" COLLISION-OBJECT/GET-INTERNAL-TYPE) :int
  (self :pointer))

(declaim (inline COLLISION-OBJECT/GET-WORLD-TRANSFORM))

(cffi:defcfun ("_wrap_btCollisionObject_getWorldTransform__SWIG_0" COLLISION-OBJECT/GET-WORLD-TRANSFORM) :pointer
  (self :pointer))

#+ (or)
(progn
  (declaim (inline COLLISION-OBJECT/GET-WORLD-TRANSFORM))

  (cffi:defcfun ("_wrap_btCollisionObject_getWorldTransform__SWIG_1" COLLISION-OBJECT/GET-WORLD-TRANSFORM) :pointer
   (self :pointer))

 )

(declaim (inline COLLISION-OBJECT/SET-WORLD-TRANSFORM))

(cffi:defcfun ("_wrap_btCollisionObject_setWorldTransform" COLLISION-OBJECT/SET-WORLD-TRANSFORM) :void
  (self :pointer)
  (worldTrans :pointer))

(declaim (inline COLLISION-OBJECT/GET-BROADPHASE-HANDLE))

(cffi:defcfun ("_wrap_btCollisionObject_getBroadphaseHandle__SWIG_0" COLLISION-OBJECT/GET-BROADPHASE-HANDLE) :pointer
  (self :pointer))

#+ (or)
(progn 
  (declaim (inline COLLISION-OBJECT/GET-BROADPHASE-HANDLE))

  (cffi:defcfun ("_wrap_btCollisionObject_getBroadphaseHandle__SWIG_1" COLLISION-OBJECT/GET-BROADPHASE-HANDLE) :pointer
   (self :pointer))

 )

(declaim (inline COLLISION-OBJECT/SET-BROADPHASE-HANDLE))

(cffi:defcfun ("_wrap_btCollisionObject_setBroadphaseHandle" COLLISION-OBJECT/SET-BROADPHASE-HANDLE) :void
  (self :pointer)
  (handle :pointer))

(declaim (inline COLLISION-OBJECT/GET-INTERPOLATION-WORLD-TRANSFORM))

(cffi:defcfun ("_wrap_btCollisionObject_getInterpolationWorldTransform__SWIG_0" COLLISION-OBJECT/GET-INTERPOLATION-WORLD-TRANSFORM) :pointer
  (self :pointer))

#+ (or)
(progn 
  (declaim (inline COLLISION-OBJECT/GET-INTERPOLATION-WORLD-TRANSFORM))

  (cffi:defcfun ("_wrap_btCollisionObject_getInterpolationWorldTransform__SWIG_1" COLLISION-OBJECT/GET-INTERPOLATION-WORLD-TRANSFORM) :pointer
   (self :pointer))

 )

(declaim (inline COLLISION-OBJECT/SET-INTERPOLATION-WORLD-TRANSFORM))

(cffi:defcfun ("_wrap_btCollisionObject_setInterpolationWorldTransform" COLLISION-OBJECT/SET-INTERPOLATION-WORLD-TRANSFORM) :void
  (self :pointer)
  (trans :pointer))

(declaim (inline COLLISION-OBJECT/SET-INTERPOLATION-LINEAR-VELOCITY))

(cffi:defcfun ("_wrap_btCollisionObject_setInterpolationLinearVelocity" COLLISION-OBJECT/SET-INTERPOLATION-LINEAR-VELOCITY) :void
  (self :pointer)
  (linvel :pointer))

(declaim (inline COLLISION-OBJECT/SET-INTERPOLATION-ANGULAR-VELOCITY))

(cffi:defcfun ("_wrap_btCollisionObject_setInterpolationAngularVelocity" COLLISION-OBJECT/SET-INTERPOLATION-ANGULAR-VELOCITY) :void
  (self :pointer)
  (angvel :pointer))

(declaim (inline COLLISION-OBJECT/GET-INTERPOLATION-LINEAR-VELOCITY))

(cffi:defcfun ("_wrap_btCollisionObject_getInterpolationLinearVelocity" COLLISION-OBJECT/GET-INTERPOLATION-LINEAR-VELOCITY) :pointer
  (self :pointer))

(declaim (inline COLLISION-OBJECT/GET-INTERPOLATION-ANGULAR-VELOCITY))

(cffi:defcfun ("_wrap_btCollisionObject_getInterpolationAngularVelocity" COLLISION-OBJECT/GET-INTERPOLATION-ANGULAR-VELOCITY) :pointer
  (self :pointer))

(declaim (inline COLLISION-OBJECT/GET-ISLAND-TAG))

(cffi:defcfun ("_wrap_btCollisionObject_getIslandTag" COLLISION-OBJECT/GET-ISLAND-TAG) :int
  (self :pointer))

(declaim (inline COLLISION-OBJECT/SET-ISLAND-TAG))

(cffi:defcfun ("_wrap_btCollisionObject_setIslandTag" COLLISION-OBJECT/SET-ISLAND-TAG) :void
  (self :pointer)
  (tag :int))

(declaim (inline COLLISION-OBJECT/GET-COMPANION-ID))

(cffi:defcfun ("_wrap_btCollisionObject_getCompanionId" COLLISION-OBJECT/GET-COMPANION-ID) :int
  (self :pointer))

(declaim (inline COLLISION-OBJECT/SET-COMPANION-ID))

(cffi:defcfun ("_wrap_btCollisionObject_setCompanionId" COLLISION-OBJECT/SET-COMPANION-ID) :void
  (self :pointer)
  (id :int))

(declaim (inline COLLISION-OBJECT/GET-HIT-FRACTION))

(cffi:defcfun ("_wrap_btCollisionObject_getHitFraction" COLLISION-OBJECT/GET-HIT-FRACTION) :float
  (self :pointer))

(declaim (inline COLLISION-OBJECT/SET-HIT-FRACTION))

(cffi:defcfun ("_wrap_btCollisionObject_setHitFraction" COLLISION-OBJECT/SET-HIT-FRACTION) :void
  (self :pointer)
  (hitFraction :float))

(declaim (inline COLLISION-OBJECT/GET-COLLISION-FLAGS))

(cffi:defcfun ("_wrap_btCollisionObject_getCollisionFlags" COLLISION-OBJECT/GET-COLLISION-FLAGS) :int
  (self :pointer))

(declaim (inline COLLISION-OBJECT/SET-COLLISION-FLAGS))

(cffi:defcfun ("_wrap_btCollisionObject_setCollisionFlags" COLLISION-OBJECT/SET-COLLISION-FLAGS) :void
  (self :pointer)
  (flags :int))

(declaim (inline COLLISION-OBJECT/GET-CCD-SWEPT-SPHERE-RADIUS))

(cffi:defcfun ("_wrap_btCollisionObject_getCcdSweptSphereRadius" COLLISION-OBJECT/GET-CCD-SWEPT-SPHERE-RADIUS) :float
  (self :pointer))

(declaim (inline COLLISION-OBJECT/SET-CCD-SWEPT-SPHERE-RADIUS))

(cffi:defcfun ("_wrap_btCollisionObject_setCcdSweptSphereRadius" COLLISION-OBJECT/SET-CCD-SWEPT-SPHERE-RADIUS) :void
  (self :pointer)
  (radius :float))

(declaim (inline COLLISION-OBJECT/GET-CCD-MOTION-THRESHOLD))

(cffi:defcfun ("_wrap_btCollisionObject_getCcdMotionThreshold" COLLISION-OBJECT/GET-CCD-MOTION-THRESHOLD) :float
  (self :pointer))

(declaim (inline COLLISION-OBJECT/GET-CCD-SQUARE-MOTION-THRESHOLD))

(cffi:defcfun ("_wrap_btCollisionObject_getCcdSquareMotionThreshold" COLLISION-OBJECT/GET-CCD-SQUARE-MOTION-THRESHOLD) :float
  (self :pointer))

(declaim (inline COLLISION-OBJECT/SET-CCD-MOTION-THRESHOLD))

(cffi:defcfun ("_wrap_btCollisionObject_setCcdMotionThreshold" COLLISION-OBJECT/SET-CCD-MOTION-THRESHOLD) :void
  (self :pointer)
  (ccdMotionThreshold :float))

(declaim (inline COLLISION-OBJECT/GET-USER-POINTER))

(cffi:defcfun ("_wrap_btCollisionObject_getUserPointer" COLLISION-OBJECT/GET-USER-POINTER) :pointer
  (self :pointer))

(declaim (inline COLLISION-OBJECT/GET-USER-INDEX))

(cffi:defcfun ("_wrap_btCollisionObject_getUserIndex" COLLISION-OBJECT/GET-USER-INDEX) :int
  (self :pointer))

(declaim (inline COLLISION-OBJECT/SET-USER-POINTER))

(cffi:defcfun ("_wrap_btCollisionObject_setUserPointer" COLLISION-OBJECT/SET-USER-POINTER) :void
  (self :pointer)
  (userPointer :pointer))

(declaim (inline COLLISION-OBJECT/SET-USER-INDEX))

(cffi:defcfun ("_wrap_btCollisionObject_setUserIndex" COLLISION-OBJECT/SET-USER-INDEX) :void
  (self :pointer)
  (index :int))

(declaim (inline COLLISION-OBJECT/GET-UPDATE-REVISION-INTERNAL))

(cffi:defcfun ("_wrap_btCollisionObject_getUpdateRevisionInternal" COLLISION-OBJECT/GET-UPDATE-REVISION-INTERNAL) :int
  (self :pointer))

(declaim (inline COLLISION-OBJECT/CHECK-COLLIDE-WITH))

(cffi:defcfun ("_wrap_btCollisionObject_checkCollideWith" COLLISION-OBJECT/CHECK-COLLIDE-WITH) :pointer
  (self :pointer)
  (co :pointer))

(declaim (inline COLLISION-OBJECT/CALCULATE-SERIALIZE-BUFFER-SIZE))

(cffi:defcfun ("_wrap_btCollisionObject_calculateSerializeBufferSize" COLLISION-OBJECT/CALCULATE-SERIALIZE-BUFFER-SIZE) :int
  (self :pointer))

(declaim (inline COLLISION-OBJECT/SERIALIZE))

(cffi:defcfun ("_wrap_btCollisionObject_serialize" COLLISION-OBJECT/SERIALIZE) :string
  (self :pointer)
  (dataBuffer :pointer)
  (serializer :pointer))

(declaim (inline COLLISION-OBJECT/SERIALIZE-SINGLE-OBJECT))

(cffi:defcfun ("_wrap_btCollisionObject_serializeSingleObject" COLLISION-OBJECT/SERIALIZE-SINGLE-OBJECT) :void
  (self :pointer)
  (serializer :pointer))

(cffi:defcstruct COLLISION-OBJECT-DOUBLE-DATA
  (BROADPHASE-HANDLE :pointer)
  (COLLISION-SHAPE :pointer)
  (ROOT-COLLISION-SHAPE :pointer)
  (NAME :string)
  (WORLD-TRANSFORM :pointer)
  (INTERPOLATION-WORLD-TRANSFORM :pointer)
  (INTERPOLATION-LINEAR-VELOCITY :pointer)
  (INTERPOLATION-ANGULAR-VELOCITY :pointer)
  (ANISOTROPIC-FRICTION :pointer)
  (CONTACT-PROCESSING-THRESHOLD :double)
  (DEACTIVATION-TIME :double)
  (FRICTION :double)
  (ROLLING-FRICTION :double)
  (RESTITUTION :double)
  (HIT-FRACTION :double)
  (CCD-SWEPT-SPHERE-RADIUS :double)
  (CCD-MOTION-THRESHOLD :double)
  (HAS-ANISOTROPIC-FRICTION :int)
  (COLLISION-FLAGS :int)
  (ISLAND-TAG-1 :int)
  (COMPANION-ID :int)
  (ACTIVATION-STATE-1 :int)
  (INTERNAL-TYPE :int)
  (CHECK-COLLIDE-WITH :int)
  (PADDING :pointer))

(cffi:defcstruct COLLISION-OBJECT-FLOAT-DATA
  (BROADPHASE-HANDLE :pointer)
  (COLLISION-SHAPE :pointer)
  (ROOT-COLLISION-SHAPE :pointer)
  (NAME :string)
  (WORLD-TRANSFORM :pointer)
  (INTERPOLATION-WORLD-TRANSFORM :pointer)
  (INTERPOLATION-LINEAR-VELOCITY :pointer)
  (INTERPOLATION-ANGULAR-VELOCITY :pointer)
  (ANISOTROPIC-FRICTION :pointer)
  (CONTACT-PROCESSING-THRESHOLD :float)
  (DEACTIVATION-TIME :float)
  (FRICTION :float)
  (ROLLING-FRICTION :float)
  (RESTITUTION :float)
  (HIT-FRACTION :float)
  (CCD-SWEPT-SPHERE-RADIUS :float)
  (CCD-MOTION-THRESHOLD :float)
  (HAS-ANISOTROPIC-FRICTION :int)
  (COLLISION-FLAGS :int)
  (ISLAND-TAG-1 :int)
  (COMPANION-ID :int)
  (ACTIVATION-STATE-1 :int)
  (INTERNAL-TYPE :int)
  (CHECK-COLLIDE-WITH :int)
  (PADDING :pointer))

(cffi:defcenum DISPATCHER-FLAGS
  (:CD-STATIC-STATIC-REPORTED #.1)
  (:CD-USE-RELATIVE-CONTACT-BREAKING-THRESHOLD #.2)
  (:CD-DISABLE-CONTACTPOOL-DYNAMIC-ALLOCATION #.4))

(define-anonymous-enum
  (DYNAMIC-SET #.0)
  (FIXED-SET #.1)
  (STAGECOUNT #.2))

(cffi:defcenum DEBUG-DRAW-MODES
  (:DBG-NO-DEBUG #.0)
  (:DBG-DRAW-WIREFRAME #.1)
  (:DBG-DRAW-AABB #.2)
  (:DBG-DRAW-FEATURES-TEXT #.4)
  (:DBG-DRAW-CONTACT-POINTS #.8)
  (:DBG-NO-DEACTIVATION #.16)
  (:DBG-NO-HELP-TEXT #.32)
  (:DBG-DRAW-TEXT #.64)
  (:DBG-PROFILE-TIMINGS #.128)
  (:DBG-ENABLE-SAT-COMPARISON #.256)
  (:DBG-DISABLE-BULLET-LCP #.512)
  (:DBG-ENABLE-CCD #.1024)
  (:DBG-DRAW-CONSTRAINTS #.(ash 1 11))
  (:DBG-DRAW-CONSTRAINT-LIMITS #.(ash 1 12))
  (:DBG-FAST-WIREFRAME #.(ash 1 13))
  (:DBG-DRAW-NORMALS #.(ash 1 14))
  :DBG-MAX-DEBUG-DRAW-MODE)

(cffi:defcenum SERIALIZATION-FLAGS
  (:SERIALIZE-NO-BVH #.1)
  (:SERIALIZE-NO-TRIANGLEINFOMAP #.2)
  (:SERIALIZE-NO-DUPLICATE-ASSERT #.4))

(declaim (inline MAKE-DISCRETE-DYNAMICS-WORLD))

(cffi:defcfun ("_wrap_new_btDiscreteDynamicsWorld" MAKE-DISCRETE-DYNAMICS-WORLD) :pointer
  (dispatcher :pointer)
  (pairCache :pointer)
  (constraint-Solver :pointer)
  (collision-Configuration :pointer))

(declaim (inline DELETE/BT-DISCRETE-DYNAMICS-WORLD))

(cffi:defcfun ("_wrap_delete_btDiscreteDynamicsWorld" DELETE/BT-DISCRETE-DYNAMICS-WORLD) :void
  (self :pointer))

(declaim (inline DISCRETE-DYNAMICS-WORLD/STEP-SIMULATION))

(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_stepSimulation__SWIG_0" DISCRETE-DYNAMICS-WORLD/STEP-SIMULATION) :int
  (self :pointer)
  (timeStep :float)
  (maxSubSteps :int)
  (fixedTimeStep :float))

#+ (or)
(progn
  (declaim (inline DISCRETE-DYNAMICS-WORLD/STEP-SIMULATION))

  (cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_stepSimulation__SWIG_1" DISCRETE-DYNAMICS-WORLD/STEP-SIMULATION) :int
   (self :pointer)
   (timeStep :float)
   (maxSubSteps :int))

 

  (declaim (inline DISCRETE-DYNAMICS-WORLD/STEP-SIMULATION))

  (cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_stepSimulation__SWIG_2" DISCRETE-DYNAMICS-WORLD/STEP-SIMULATION) :int
   (self :pointer)
   (timeStep :float))

 )

(declaim (inline DISCRETE-DYNAMICS-WORLD/SYNCHRONIZE-MOTION-STATES))

(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_synchronizeMotionStates" DISCRETE-DYNAMICS-WORLD/SYNCHRONIZE-MOTION-STATES) :void
  (self :pointer))

(declaim (inline DISCRETE-DYNAMICS-WORLD/SYNCHRONIZE-SINGLE-MOTION-STATE))

(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_synchronizeSingleMotionState" DISCRETE-DYNAMICS-WORLD/SYNCHRONIZE-SINGLE-MOTION-STATE) :void
  (self :pointer)
  (body :pointer))

(declaim (inline DISCRETE-DYNAMICS-WORLD/ADD-CONSTRAINT))

(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_addConstraint__SWIG_0" DISCRETE-DYNAMICS-WORLD/ADD-CONSTRAINT) :void
  (self :pointer)
  (constraint :pointer)
  (disableCollisionsBetweenLinkedBodies :pointer))

#+ (or)
(progn
  (declaim (inline DISCRETE-DYNAMICS-WORLD/ADD-CONSTRAINT))

  (cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_addConstraint__SWIG_1" DISCRETE-DYNAMICS-WORLD/ADD-CONSTRAINT) :void
   (self :pointer)
   (constraint :pointer))

 )

(declaim (inline DISCRETE-DYNAMICS-WORLD/REMOVE-CONSTRAINT))

(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_removeConstraint" DISCRETE-DYNAMICS-WORLD/REMOVE-CONSTRAINT) :void
  (self :pointer)
  (constraint :pointer))

(declaim (inline DISCRETE-DYNAMICS-WORLD/ADD-ACTION))

(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_addAction" DISCRETE-DYNAMICS-WORLD/ADD-ACTION) :void
  (self :pointer)
  (arg1 :pointer))

(declaim (inline DISCRETE-DYNAMICS-WORLD/REMOVE-ACTION))

(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_removeAction" DISCRETE-DYNAMICS-WORLD/REMOVE-ACTION) :void
  (self :pointer)
  (arg1 :pointer))

(declaim (inline DISCRETE-DYNAMICS-WORLD/GET-SIMULATION-ISLAND-MANAGER))

(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_getSimulationIslandManager__SWIG_0" DISCRETE-DYNAMICS-WORLD/GET-SIMULATION-ISLAND-MANAGER) :pointer
  (self :pointer))

#+ (or)
(progn
  (declaim (inline DISCRETE-DYNAMICS-WORLD/GET-SIMULATION-ISLAND-MANAGER))

  (cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_getSimulationIslandManager__SWIG_1" DISCRETE-DYNAMICS-WORLD/GET-SIMULATION-ISLAND-MANAGER) :pointer
   (self :pointer))

 )

(declaim (inline DISCRETE-DYNAMICS-WORLD/GET-COLLISION-WORLD))

(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_getCollisionWorld" DISCRETE-DYNAMICS-WORLD/GET-COLLISION-WORLD) :pointer
  (self :pointer))

(declaim (inline DISCRETE-DYNAMICS-WORLD/SET-GRAVITY))

(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_setGravity" DISCRETE-DYNAMICS-WORLD/SET-GRAVITY) :void
  (self :pointer)
  (gravity :pointer))

(declaim (inline DISCRETE-DYNAMICS-WORLD/GET-GRAVITY))

(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_getGravity" DISCRETE-DYNAMICS-WORLD/GET-GRAVITY) :pointer
  (self :pointer))

(declaim (inline DISCRETE-DYNAMICS-WORLD/ADD-COLLISION-OBJECT))

(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_addCollisionObject__SWIG_0" DISCRETE-DYNAMICS-WORLD/ADD-COLLISION-OBJECT) :void
  (self :pointer)
  (collisionObject :pointer)
  (collisionFilterGroup :short)
  (collisionFilterMask :short))

#+ (or)
(progn
  (declaim (inline DISCRETE-DYNAMICS-WORLD/ADD-COLLISION-OBJECT))

  (cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_addCollisionObject__SWIG_1" DISCRETE-DYNAMICS-WORLD/ADD-COLLISION-OBJECT) :void
   (self :pointer)
   (collisionObject :pointer)
   (collisionFilterGroup :short))

 

  (declaim (inline DISCRETE-DYNAMICS-WORLD/ADD-COLLISION-OBJECT))

  (cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_addCollisionObject__SWIG_2" DISCRETE-DYNAMICS-WORLD/ADD-COLLISION-OBJECT) :void
   (self :pointer)
   (collisionObject :pointer))

 )

(declaim (inline DISCRETE-DYNAMICS-WORLD/ADD-RIGID-BODY))

(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_addRigidBody__SWIG_0" 
               DISCRETE-DYNAMICS-WORLD/ADD-RIGID-BODY) :void
  (self :pointer)
  (body :pointer))

(declaim (inline DISCRETE-DYNAMICS-WORLD/ADD-RIGID-BODY))

(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_addRigidBody__SWIG_1"
               DISCRETE-DYNAMICS-WORLD/ADD-RIGID-BODY/WITH-GROUP&MASK) :void
  (self :pointer)
  (body :pointer)
  (group :short)
  (mask :short))

(export 'DISCRETE-DYNAMICS-WORLD/ADD-RIGID-BODY/WITH-GROUP&MASK)

(declaim (inline DISCRETE-DYNAMICS-WORLD/REMOVE-RIGID-BODY))

(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_removeRigidBody" DISCRETE-DYNAMICS-WORLD/REMOVE-RIGID-BODY) :void
  (self :pointer)
  (body :pointer))

(declaim (inline DISCRETE-DYNAMICS-WORLD/REMOVE-COLLISION-OBJECT))

(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_removeCollisionObject" DISCRETE-DYNAMICS-WORLD/REMOVE-COLLISION-OBJECT) :void
  (self :pointer)
  (collisionObject :pointer))

(declaim (inline DISCRETE-DYNAMICS-WORLD/DEBUG-DRAW-CONSTRAINT))

(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_debugDrawConstraint" DISCRETE-DYNAMICS-WORLD/DEBUG-DRAW-CONSTRAINT) :void
  (self :pointer)
  (constraint :pointer))

(declaim (inline DISCRETE-DYNAMICS-WORLD/DEBUG-DRAW-WORLD))

(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_debugDrawWorld" DISCRETE-DYNAMICS-WORLD/DEBUG-DRAW-WORLD) :void
  (self :pointer))

(declaim (inline DISCRETE-DYNAMICS-WORLD/SET-CONSTRAINT-SOLVER))

(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_setConstraintSolver" DISCRETE-DYNAMICS-WORLD/SET-CONSTRAINT-SOLVER) :void
  (self :pointer)
  (solver :pointer))

(declaim (inline DISCRETE-DYNAMICS-WORLD/GET-CONSTRAINT-SOLVER))

(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_getConstraintSolver" DISCRETE-DYNAMICS-WORLD/GET-CONSTRAINT-SOLVER) :pointer
  (self :pointer))

(declaim (inline DISCRETE-DYNAMICS-WORLD/GET-NUM-CONSTRAINTS))

(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_getNumConstraints" DISCRETE-DYNAMICS-WORLD/GET-NUM-CONSTRAINTS) :int
  (self :pointer))

(declaim (inline DISCRETE-DYNAMICS-WORLD/GET-CONSTRAINT))

(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_getConstraint__SWIG_0" DISCRETE-DYNAMICS-WORLD/GET-CONSTRAINT) :pointer
  (self :pointer)
  (index :int))

#+ (or)
(progn (declaim (inline DISCRETE-DYNAMICS-WORLD/GET-CONSTRAINT))

       (cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_getConstraint__SWIG_1" DISCRETE-DYNAMICS-WORLD/GET-CONSTRAINT) :pointer
   (self :pointer)
   (index :int))

 )

DISCRETE-DYNAMICS-WORLD/GET-WORLD-TYPE(declaim (inline ))

(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_getWorldType" DISCRETE-DYNAMICS-WORLD/GET-WORLD-TYPE) :pointer
  (self :pointer))

(declaim (inline DISCRETE-DYNAMICS-WORLD/CLEAR-FORCES))

(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_clearForces" DISCRETE-DYNAMICS-WORLD/CLEAR-FORCES) :void
  (self :pointer))

(declaim (inline DISCRETE-DYNAMICS-WORLD/APPLY-GRAVITY))

(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_applyGravity" DISCRETE-DYNAMICS-WORLD/APPLY-GRAVITY) :void
  (self :pointer))

(declaim (inline DISCRETE-DYNAMICS-WORLD/SET-NUM-TASKS))

(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_setNumTasks" DISCRETE-DYNAMICS-WORLD/SET-NUM-TASKS) :void
  (self :pointer)
  (numTasks :int))

(declaim (inline DISCRETE-DYNAMICS-WORLD/UPDATE-VEHICLES))

(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_updateVehicles" DISCRETE-DYNAMICS-WORLD/UPDATE-VEHICLES) :void
  (self :pointer)
  (timeStep :float))

(declaim (inline DISCRETE-DYNAMICS-WORLD/ADD-VEHICLE))

(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_addVehicle" DISCRETE-DYNAMICS-WORLD/ADD-VEHICLE) :void
  (self :pointer)
  (vehicle :pointer))

(declaim (inline DISCRETE-DYNAMICS-WORLD/REMOVE-VEHICLE))

(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_removeVehicle" DISCRETE-DYNAMICS-WORLD/REMOVE-VEHICLE) :void
  (self :pointer)
  (vehicle :pointer))

(declaim (inline DISCRETE-DYNAMICS-WORLD/ADD-CHARACTER))

(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_addCharacter" DISCRETE-DYNAMICS-WORLD/ADD-CHARACTER) :void
  (self :pointer)
  (character :pointer))

(declaim (inline DISCRETE-DYNAMICS-WORLD/REMOVE-CHARACTER))

(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_removeCharacter" DISCRETE-DYNAMICS-WORLD/REMOVE-CHARACTER) :void
  (self :pointer)
  (character :pointer))

(declaim (inline DISCRETE-DYNAMICS-WORLD/SET-SYNCHRONIZE-ALL-MOTION-STATES))

(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_setSynchronizeAllMotionStates" DISCRETE-DYNAMICS-WORLD/SET-SYNCHRONIZE-ALL-MOTION-STATES) :void
  (self :pointer)
  (synchronizeAll :pointer))

(declaim (inline DISCRETE-DYNAMICS-WORLD/GET-SYNCHRONIZE-ALL-MOTION-STATES))

(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_getSynchronizeAllMotionStates" DISCRETE-DYNAMICS-WORLD/GET-SYNCHRONIZE-ALL-MOTION-STATES) :pointer
  (self :pointer))

(declaim (inline DISCRETE-DYNAMICS-WORLD/SET-APPLY-SPECULATIVE-CONTACT-RESTITUTION))

(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_setApplySpeculativeContactRestitution" DISCRETE-DYNAMICS-WORLD/SET-APPLY-SPECULATIVE-CONTACT-RESTITUTION) :void
  (self :pointer)
  (enable :pointer))

(declaim (inline DISCRETE-DYNAMICS-WORLD/GET-APPLY-SPECULATIVE-CONTACT-RESTITUTION))

(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_getApplySpeculativeContactRestitution" DISCRETE-DYNAMICS-WORLD/GET-APPLY-SPECULATIVE-CONTACT-RESTITUTION) :pointer
  (self :pointer))

(declaim (inline DISCRETE-DYNAMICS-WORLD/SERIALIZE))

(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_serialize" DISCRETE-DYNAMICS-WORLD/SERIALIZE) :void
  (self :pointer)
  (serializer :pointer))

(declaim (inline DISCRETE-DYNAMICS-WORLD/SET-LATENCY-MOTION-STATE-INTERPOLATION))

(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_setLatencyMotionStateInterpolation" DISCRETE-DYNAMICS-WORLD/SET-LATENCY-MOTION-STATE-INTERPOLATION) :void
  (self :pointer)
  (latencyInterpolation :pointer))

(declaim (inline DISCRETE-DYNAMICS-WORLD/GET-LATENCY-MOTION-STATE-INTERPOLATION))

(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_getLatencyMotionStateInterpolation" DISCRETE-DYNAMICS-WORLD/GET-LATENCY-MOTION-STATE-INTERPOLATION) :pointer
  (self :pointer))

(declaim (inline MAKE-SIMPLE-DYNAMICS-WORLD))

(cffi:defcfun ("_wrap_new_btSimpleDynamicsWorld" MAKE-SIMPLE-DYNAMICS-WORLD) :pointer
  (dispatcher :pointer)
  (pairCache :pointer)
  (constraintSolver :pointer)
  (collisionConfiguration :pointer))

(declaim (inline DELETE/BT-SIMPLE-DYNAMICS-WORLD))

(cffi:defcfun ("_wrap_delete_btSimpleDynamicsWorld" DELETE/BT-SIMPLE-DYNAMICS-WORLD) :void
  (self :pointer))

(declaim (inline SIMPLE-DYNAMICS-WORLD/STEP-SIMULATION))

(cffi:defcfun ("_wrap_btSimpleDynamicsWorld_stepSimulation__SWIG_0" SIMPLE-DYNAMICS-WORLD/STEP-SIMULATION) :int
  (self :pointer)
  (timeStep :float)
  (maxSubSteps :int)
  (fixedTimeStep :float))

#+ (or)
(progn
  (declaim (inline SIMPLE-DYNAMICS-WORLD/STEP-SIMULATION))

  (cffi:defcfun ("_wrap_btSimpleDynamicsWorld_stepSimulation__SWIG_1" SIMPLE-DYNAMICS-WORLD/STEP-SIMULATION) :int
   (self :pointer)
   (timeStep :float)
   (maxSubSteps :int))

 

  (declaim (inline SIMPLE-DYNAMICS-WORLD/STEP-SIMULATION))

  (cffi:defcfun ("_wrap_btSimpleDynamicsWorld_stepSimulation__SWIG_2" SIMPLE-DYNAMICS-WORLD/STEP-SIMULATION) :int
   (self :pointer)
   (timeStep :float))

 )

(declaim (inline SIMPLE-DYNAMICS-WORLD/SET-GRAVITY))

(cffi:defcfun ("_wrap_btSimpleDynamicsWorld_setGravity" SIMPLE-DYNAMICS-WORLD/SET-GRAVITY) :void
  (self :pointer)
  (gravity :pointer))

(declaim (inline SIMPLE-DYNAMICS-WORLD/GET-GRAVITY))

(cffi:defcfun ("_wrap_btSimpleDynamicsWorld_getGravity" SIMPLE-DYNAMICS-WORLD/GET-GRAVITY) :pointer
  (self :pointer))

#+ (or)
(progn
  (declaim (inline SIMPLE-DYNAMICS-WORLD/ADD-RIGID-BODY))

  (cffi:defcfun ("_wrap_btSimpleDynamicsWorld_addRigidBody__SWIG_0" SIMPLE-DYNAMICS-WORLD/ADD-RIGID-BODY) :void
   (self :pointer)
   (body :pointer))

 )

(declaim (inline SIMPLE-DYNAMICS-WORLD/ADD-RIGID-BODY))

(cffi:defcfun ("_wrap_btSimpleDynamicsWorld_addRigidBody__SWIG_1" SIMPLE-DYNAMICS-WORLD/ADD-RIGID-BODY) :void
  (self :pointer)
  (body :pointer)
  (group :short)
  (mask :short))

(declaim (inline SIMPLE-DYNAMICS-WORLD/REMOVE-RIGID-BODY))

(cffi:defcfun ("_wrap_btSimpleDynamicsWorld_removeRigidBody" SIMPLE-DYNAMICS-WORLD/REMOVE-RIGID-BODY) :void
  (self :pointer)
  (body :pointer))

(declaim (inline SIMPLE-DYNAMICS-WORLD/DEBUG-DRAW-WORLD))

(cffi:defcfun ("_wrap_btSimpleDynamicsWorld_debugDrawWorld" SIMPLE-DYNAMICS-WORLD/DEBUG-DRAW-WORLD) :void
  (self :pointer))

(declaim (inline SIMPLE-DYNAMICS-WORLD/ADD-ACTION))

(cffi:defcfun ("_wrap_btSimpleDynamicsWorld_addAction" SIMPLE-DYNAMICS-WORLD/ADD-ACTION) :void
  (self :pointer)
  (action :pointer))

(declaim (inline SIMPLE-DYNAMICS-WORLD/REMOVE-ACTION))

(cffi:defcfun ("_wrap_btSimpleDynamicsWorld_removeAction" SIMPLE-DYNAMICS-WORLD/REMOVE-ACTION) :void
  (self :pointer)
  (action :pointer))

(declaim (inline SIMPLE-DYNAMICS-WORLD/REMOVE-COLLISION-OBJECT))

(cffi:defcfun ("_wrap_btSimpleDynamicsWorld_removeCollisionObject" SIMPLE-DYNAMICS-WORLD/REMOVE-COLLISION-OBJECT) :void
  (self :pointer)
  (collisionObject :pointer))

(declaim (inline SIMPLE-DYNAMICS-WORLD/UPDATE-AABBS))

(cffi:defcfun ("_wrap_btSimpleDynamicsWorld_updateAabbs" SIMPLE-DYNAMICS-WORLD/UPDATE-AABBS) :void
  (self :pointer))

(declaim (inline SIMPLE-DYNAMICS-WORLD/SYNCHRONIZE-MOTION-STATES))

(cffi:defcfun ("_wrap_btSimpleDynamicsWorld_synchronizeMotionStates" SIMPLE-DYNAMICS-WORLD/SYNCHRONIZE-MOTION-STATES) :void
  (self :pointer))

(declaim (inline SIMPLE-DYNAMICS-WORLD/SET-CONSTRAINT-SOLVER))

(cffi:defcfun ("_wrap_btSimpleDynamicsWorld_setConstraintSolver" SIMPLE-DYNAMICS-WORLD/SET-CONSTRAINT-SOLVER) :void
  (self :pointer)
  (solver :pointer))

(declaim (inline SIMPLE-DYNAMICS-WORLD/GET-CONSTRAINT-SOLVER))

(cffi:defcfun ("_wrap_btSimpleDynamicsWorld_getConstraintSolver" SIMPLE-DYNAMICS-WORLD/GET-CONSTRAINT-SOLVER) :pointer
  (self :pointer))

(declaim (inline SIMPLE-DYNAMICS-WORLD/GET-WORLD-TYPE))

(cffi:defcfun ("_wrap_btSimpleDynamicsWorld_getWorldType" SIMPLE-DYNAMICS-WORLD/GET-WORLD-TYPE) :pointer
  (self :pointer))

(declaim (inline SIMPLE-DYNAMICS-WORLD/CLEAR-FORCES))

(cffi:defcfun ("_wrap_btSimpleDynamicsWorld_clearForces" SIMPLE-DYNAMICS-WORLD/CLEAR-FORCES) :void
  (self :pointer))

(cffi:defcenum RIGID-BODY-FLAGS
  (:DISABLE-WORLD-GRAVITY #.1)
  (:ENABLE-GYROPSCOPIC-FORCE #.2))

(cffi:defcenum POINT-2-POINT-FLAGS
  (:P-2-P-FLAGS-ERP #.1)
  (:P-2-P-FLAGS-CFM #.2))

(cffi:defcenum HINGE-FLAGS
  (:HINGE-FLAGS-CFM-STOP #.1)
  (:HINGE-FLAGS-ERP-STOP #.2)
  (:HINGE-FLAGS-CFM-NORM #.4))

(cffi:defcenum CONE-TWIST-FLAGS
  (:CONETWIST-FLAGS-LIN-CFM #.1)
  (:CONETWIST-FLAGS-LIN-ERP #.2)
  (:CONETWIST-FLAGS-ANG-CFM #.4))

(cffi:defcenum 6-DOF-FLAGS
  (:6-DOF-FLAGS-CFM-NORM #.1)
  (:6-DOF-FLAGS-CFM-STOP #.2)
  (:6-DOF-FLAGS-ERP-STOP #.4))

(cffi:defcenum SLIDER-FLAGS
  (:SLIDER-FLAGS-CFM-DIRLIN #.(ash 1 0))
  (:SLIDER-FLAGS-ERP-DIRLIN #.(ash 1 1))
  (:SLIDER-FLAGS-CFM-DIRANG #.(ash 1 2))
  (:SLIDER-FLAGS-ERP-DIRANG #.(ash 1 3))
  (:SLIDER-FLAGS-CFM-ORTLIN #.(ash 1 4))
  (:SLIDER-FLAGS-ERP-ORTLIN #.(ash 1 5))
  (:SLIDER-FLAGS-CFM-ORTANG #.(ash 1 6))
  (:SLIDER-FLAGS-ERP-ORTANG #.(ash 1 7))
  (:SLIDER-FLAGS-CFM-LIMLIN #.(ash 1 8))
  (:SLIDER-FLAGS-ERP-LIMLIN #.(ash 1 9))
  (:SLIDER-FLAGS-CFM-LIMANG #.(ash 1 10))
  (:SLIDER-FLAGS-ERP-LIMANG #.(ash 1 11)))



(defmethod initialize-instance :after ((obj collision-world)
                                       &key dispatcher broadphase-Pair-Cache
                                         collision-Configuration)
  (setf (slot-value obj 'ff-pointer) (MAKE-COLLISION-WORLD dispatcher broadphase-Pair-Cache collision-Configuration)))

(defmethod (setf broadphase)
    ((self collision-world) pairCache)
  (COLLISION-WORLD/SET-BROADPHASE (ff-pointer self) pairCache))

(defmethod broadphase ((self collision-world))
  (COLLISION-WORLD/GET-BROADPHASE (ff-pointer self)))

(defmethod broadphase ((self collision-world))
  (COLLISION-WORLD/GET-BROADPHASE (ff-pointer self)))

(defmethod pair-cache ((self collision-world))
  (COLLISION-WORLD/GET-PAIR-CACHE (ff-pointer self)))

(defmethod dispatcher ((self collision-world))
  (COLLISION-WORLD/GET-DISPATCHER (ff-pointer self)))

(defmethod dispatcher ((self collision-world))
  (COLLISION-WORLD/GET-DISPATCHER (ff-pointer self)))

(defmethod update-single-aabb ((self collision-world) colObj)
  (COLLISION-WORLD/UPDATE-SINGLE-AABB (ff-pointer self) colObj))

(defmethod update-aabbs ((self collision-world))
  (COLLISION-WORLD/UPDATE-AABBS (ff-pointer self)))

(defmethod compute-overlapping-pairs ((self collision-world))
  (COLLISION-WORLD/COMPUTE-OVERLAPPING-PAIRS (ff-pointer self)))

(defmethod (setf debug-drawer) ((self collision-world) debugDrawer)
  (COLLISION-WORLD/SET-DEBUG-DRAWER (ff-pointer self) debugDrawer))

(defmethod debug-drawer ((self COLLISION-WORLD))
  (COLLISION-WORLD/GET-DEBUG-DRAWER (ff-pointer self)))

(defmethod debug-draw-world ((self collision-world))
  (COLLISION-WORLD/DEBUG-DRAW-WORLD (ff-pointer self)))

(defmethod debug-draw-object ((self collision-world) worldTransform shape color)
  (COLLISION-WORLD/DEBUG-DRAW-OBJECT (ff-pointer self) worldTransform shape color))

(defmethod num-collision-objects ((self collision-world))
  (COLLISION-WORLD/GET-NUM-COLLISION-OBJECTS (ff-pointer self)))

(defmethod ray-test ((self collision-world) rayFromWorld rayToWorld resultCallback)
  (COLLISION-WORLD/RAY-TEST (ff-pointer self) rayFromWorld rayToWorld resultCallback))

(defmethod convex-sweep-test
    ((self collision-world)
   castShape from to resultCallback 
   (allowedCcdPenetration number))
  (COLLISION-WORLD/CONVEX-SWEEP-TEST/with-ccd-penetration
   (ff-pointer self) castShape from to resultCallback
   allowedCcdPenetration))

(defmethod convex-sweep-test
    ((self collision-world)
   castShape from to resultCallback (allowedCcdPenetration null))
  (COLLISION-WORLD/CONVEX-SWEEP-TEST/without-ccd-penetration
   (ff-pointer self) castShape from to resultCallback))
                                                       
(defmethod contact-test
    ((self collision-world) colObj resultCallback)
  (COLLISION-WORLD/CONTACT-TEST (ff-pointer self) colObj resultCallback))

(defmethod contact-pair-test
    ((self collision-world) colObjA colObjB resultCallback)
  (COLLISION-WORLD/CONTACT-PAIR-TEST (ff-pointer self) colObjA colObjB resultCallback))

(defmethod add-collision-object
    ((self collision-world) collisionObject
   (collisionFilterGroup integer) (collisionFilterMask integer))
  (COLLISION-WORLD/ADD-COLLISION-OBJECT/WITH-FILTER-GROUP&MASK
     (ff-pointer self) collisionObject
     collisionFilterGroup collisionFilterMask))

(defmethod add-collision-object
    ((self collision-world) collisionObject
   (collisionFilterGroup integer)  (collisionFilterMask null))
  (COLLISION-WORLD/ADD-COLLISION-OBJECT/WITH-FILTER-GROUP
   (ff-pointer self) collisionObject
   collisionFilterGroup))

(defmethod add-collision-object 
    ((self collision-world) collisionObject
   (collisionFilterGroup null)  (collisionFilterMask null))
  (COLLISION-WORLD/ADD-COLLISION-OBJECT/simple
              (ff-pointer self) collisionObject))

(defmethod collision-object-array ((self collision-world))
  (COLLISION-WORLD/GET-COLLISION-OBJECT-ARRAY (ff-pointer self)))

(defmethod collision-object-array ((self collision-world))
  (COLLISION-WORLD/GET-COLLISION-OBJECT-ARRAY (ff-pointer self)))

(defmethod REMOVE-COLLISION-OBJECT ((self COLLISION-WORLD) collisionObject)
  (COLLISION-WORLD/REMOVE-COLLISION-OBJECT (ff-pointer self) collisionObject))

(defmethod PERFORM-DISCRETE-COLLISION-DETECTION ((self COLLISION-WORLD))
  (COLLISION-WORLD/PERFORM-DISCRETE-COLLISION-DETECTION (ff-pointer self)))

(defmethod DISPATCH-INFO ((self COLLISION-WORLD))
  (COLLISION-WORLD/GET-DISPATCH-INFO (ff-pointer self)))

(defmethod DISPATCH-INFO ((self COLLISION-WORLD))
  (COLLISION-WORLD/GET-DISPATCH-INFO (ff-pointer self)))

(defmethod FORCE-UPDATE-ALL-AABBS ((self COLLISION-WORLD))
  (COLLISION-WORLD/GET-FORCE-UPDATE-ALL-AABBS (ff-pointer self)))

(defmethod (SETF FORCE-UPDATE-ALL-AABBS) ((self COLLISION-WORLD) (forceUpdateAllAabbs t))
  (COLLISION-WORLD/SET-FORCE-UPDATE-ALL-AABBS (ff-pointer self) forceUpdateAllAabbs))

(defgeneric serialize (object &key &allow-other-keys))

(defmethod serialize ((self collision-world) &key serializer &allow-other-keys)
  (COLLISION-WORLD/SERIALIZE (ff-pointer self) serializer))



(defmethod MERGES-SIMULATION-ISLANDS ((self COLLISION-OBJECT))
  (COLLISION-OBJECT/MERGES-SIMULATION-ISLANDS (ff-pointer self)))

(defmethod ANISOTROPIC-FRICTION ((self COLLISION-OBJECT))
  (COLLISION-OBJECT/GET-ANISOTROPIC-FRICTION (ff-pointer self)))

(defmethod (SETF ANISOTROPIC-FRICTION)
    ((self COLLISION-OBJECT) 
   anisotropicFriction (frictionMode integer))
           (COLLISION-OBJECT/SET-ANISOTROPIC-FRICTION/WITH-MODE
            (ff-pointer self) anisotropicFriction
            frictionMode))

(defmethod (SETF ANISOTROPIC-FRICTION)
    ((self COLLISION-OBJECT)
   anisotropicFriction (friction-mode null))
  (COLLISION-OBJECT/SET-ANISOTROPIC-FRICTION/WITHOUT-MODE
     (ff-pointer self) anisotropicFriction))

(defmethod HAS-ANISOTROPIC-FRICTION-P
    ((self COLLISION-OBJECT) (frictionMode integer))
  (COLLISION-OBJECT/HAS-ANISOTROPIC-FRICTION/WITH-MODE
   (ff-pointer self) frictionMode))

(defmethod HAS-ANISOTROPIC-FRICTION-P
    ((self COLLISION-OBJECT) (friction-mode null))
  (COLLISION-OBJECT/HAS-ANISOTROPIC-FRICTION/WITHOUT-MODE
     (ff-pointer self)))

(defmethod (SETF CONTACT-PROCESSING-THRESHOLD)
    ((self COLLISION-OBJECT)
   (contactProcessingThreshold number))
  (COLLISION-OBJECT/SET-CONTACT-PROCESSING-THRESHOLD
     (ff-pointer self) contactProcessingThreshold))

(defmethod CONTACT-PROCESSING-THRESHOLD ((self COLLISION-OBJECT))
  (COLLISION-OBJECT/GET-CONTACT-PROCESSING-THRESHOLD (ff-pointer self)))

(defmethod STATIC-OBJECT-P ((self COLLISION-OBJECT))
  (COLLISION-OBJECT/IS-STATIC-OBJECT (ff-pointer self)))

(defmethod KINEMATIC-OBJECT-P ((self COLLISION-OBJECT))
  (COLLISION-OBJECT/IS-KINEMATIC-OBJECT (ff-pointer self)))

(defmethod STATIC-OR-KINEMATIC-OBJECT-P ((self COLLISION-OBJECT))
  (COLLISION-OBJECT/IS-STATIC-OR-KINEMATIC-OBJECT (ff-pointer self)))

(defmethod HAS-CONTACT-RESPONSE-P ((self COLLISION-OBJECT))
  (COLLISION-OBJECT/HAS-CONTACT-RESPONSE (ff-pointer self)))

(defmethod initialize-instance :after ((obj COLLISION-OBJECT)
                                       &key)
  (setf (slot-value obj 'ff-pointer) (MAKE-COLLISION-OBJECT)))

(defmethod (SETF COLLISION-SHAPE) ((self COLLISION-OBJECT) collisionShape)
  (COLLISION-OBJECT/SET-COLLISION-SHAPE (ff-pointer self) collisionShape))

(defmethod COLLISION-SHAPE ((self COLLISION-OBJECT))
  (COLLISION-OBJECT/GET-COLLISION-SHAPE (ff-pointer self)))

(defmethod COLLISION-SHAPE ((self COLLISION-OBJECT))
  (COLLISION-OBJECT/GET-COLLISION-SHAPE (ff-pointer self)))

(defmethod INTERNAL-GET-EXTENSION-POINTER ((self COLLISION-OBJECT))
  (COLLISION-OBJECT/INTERNAL-GET-EXTENSION-POINTER (ff-pointer self)))

(defmethod INTERNAL-SET-EXTENSION-POINTER ((self COLLISION-OBJECT) pointer)
  (COLLISION-OBJECT/INTERNAL-SET-EXTENSION-POINTER (ff-pointer self) pointer))

(defmethod ACTIVATION-STATE ((self COLLISION-OBJECT))
  (COLLISION-OBJECT/GET-ACTIVATION-STATE (ff-pointer self)))

(defmethod (SETF ACTIVATION-STATE) ((self COLLISION-OBJECT) (newState integer))
  (COLLISION-OBJECT/SET-ACTIVATION-STATE (ff-pointer self) newState))

(defmethod (SETF DEACTIVATION-TIME) ((self COLLISION-OBJECT) (time number))
  (COLLISION-OBJECT/SET-DEACTIVATION-TIME (ff-pointer self) time))

(defmethod DEACTIVATION-TIME ((self COLLISION-OBJECT))
  (COLLISION-OBJECT/GET-DEACTIVATION-TIME (ff-pointer self)))

(defmethod FORCE-ACTIVATION-STATE ((self COLLISION-OBJECT) (newState integer))
  (COLLISION-OBJECT/FORCE-ACTIVATION-STATE (ff-pointer self) newState))

(defmethod activate ((self collision-object)
                     &key (force-activation nil force-?))
  (if force-?
      (collision-object/activate/force (ff-pointer self) force-activation)
      (collision-object/activate (ff-pointer self))))

(defmethod ACTIVEP ((self COLLISION-OBJECT))
  (COLLISION-OBJECT/IS-ACTIVE (ff-pointer self)))

(defmethod (SETF RESTITUTION) ((self COLLISION-OBJECT) (rest number))
  (COLLISION-OBJECT/SET-RESTITUTION (ff-pointer self) rest))

(defmethod RESTITUTION ((self COLLISION-OBJECT))
  (COLLISION-OBJECT/GET-RESTITUTION (ff-pointer self)))

(defmethod (SETF FRICTION) ((self COLLISION-OBJECT) (frict number))
  (COLLISION-OBJECT/SET-FRICTION (ff-pointer self) frict))

(defmethod FRICTION ((self COLLISION-OBJECT))
  (COLLISION-OBJECT/GET-FRICTION (ff-pointer self)))

(defmethod (SETF ROLLING-FRICTION) ((self COLLISION-OBJECT) (frict number))
  (COLLISION-OBJECT/SET-ROLLING-FRICTION (ff-pointer self) frict))

(defmethod ROLLING-FRICTION ((self COLLISION-OBJECT))
  (COLLISION-OBJECT/GET-ROLLING-FRICTION (ff-pointer self)))

(defmethod INTERNAL-TYPE ((self COLLISION-OBJECT))
  (COLLISION-OBJECT/GET-INTERNAL-TYPE (ff-pointer self)))

(defmethod WORLD-TRANSFORM ((self COLLISION-OBJECT))
  (COLLISION-OBJECT/GET-WORLD-TRANSFORM (ff-pointer self)))

(defmethod WORLD-TRANSFORM ((self COLLISION-OBJECT))
  (COLLISION-OBJECT/GET-WORLD-TRANSFORM (ff-pointer self)))

(defmethod (SETF WORLD-TRANSFORM) ((self COLLISION-OBJECT) worldTrans)
  (COLLISION-OBJECT/SET-WORLD-TRANSFORM (ff-pointer self) worldTrans))

(defmethod GET-BROADPHASE-HANDLE ((self COLLISION-OBJECT))
  (COLLISION-OBJECT/GET-BROADPHASE-HANDLE (ff-pointer self)))

(defmethod (SETF BROADPHASE-HANDLE) ((self COLLISION-OBJECT) handle)
  (COLLISION-OBJECT/SET-BROADPHASE-HANDLE (ff-pointer self) handle))

(defmethod INTERPOLATION-WORLD-TRANSFORM ((self COLLISION-OBJECT))
  (COLLISION-OBJECT/GET-INTERPOLATION-WORLD-TRANSFORM (ff-pointer self)))

(defmethod INTERPOLATION-WORLD-TRANSFORM ((self COLLISION-OBJECT))
  (COLLISION-OBJECT/GET-INTERPOLATION-WORLD-TRANSFORM (ff-pointer self)))

(defmethod (SETF INTERPOLATION-WORLD-TRANSFORM) ((self COLLISION-OBJECT) trans)
  (COLLISION-OBJECT/SET-INTERPOLATION-WORLD-TRANSFORM (ff-pointer self) trans))

(defmethod (SETF INTERPOLATION-LINEAR-VELOCITY) ((self COLLISION-OBJECT) linvel)
  (COLLISION-OBJECT/SET-INTERPOLATION-LINEAR-VELOCITY (ff-pointer self) linvel))

(defmethod (SETF INTERPOLATION-ANGULAR-VELOCITY) ((self COLLISION-OBJECT) angvel)
  (COLLISION-OBJECT/SET-INTERPOLATION-ANGULAR-VELOCITY (ff-pointer self) angvel))

(defmethod INTERPOLATION-LINEAR-VELOCITY ((self COLLISION-OBJECT))
  (COLLISION-OBJECT/GET-INTERPOLATION-LINEAR-VELOCITY (ff-pointer self)))

(defmethod INTERPOLATION-ANGULAR-VELOCITY ((self COLLISION-OBJECT))
  (COLLISION-OBJECT/GET-INTERPOLATION-ANGULAR-VELOCITY (ff-pointer self)))

(defmethod ISLAND-TAG ((self COLLISION-OBJECT))
  (COLLISION-OBJECT/GET-ISLAND-TAG (ff-pointer self)))

(defmethod (SETF ISLAND-TAG) ((self COLLISION-OBJECT) (tag integer))
  (COLLISION-OBJECT/SET-ISLAND-TAG (ff-pointer self) tag))

(defmethod COMPANION-ID ((self COLLISION-OBJECT))
  (COLLISION-OBJECT/GET-COMPANION-ID (ff-pointer self)))

(defmethod (SETF COMPANION-ID) ((self COLLISION-OBJECT) (id integer))
  (COLLISION-OBJECT/SET-COMPANION-ID (ff-pointer self) id))

(defmethod HIT-FRACTION ((self COLLISION-OBJECT))
  (COLLISION-OBJECT/GET-HIT-FRACTION (ff-pointer self)))

(defmethod (SETF HIT-FRACTION) ((self COLLISION-OBJECT) (hitFraction number))
  (COLLISION-OBJECT/SET-HIT-FRACTION (ff-pointer self) hitFraction))

(defmethod COLLISION-FLAGS ((self COLLISION-OBJECT))
  (COLLISION-OBJECT/GET-COLLISION-FLAGS (ff-pointer self)))

(defmethod (SETF COLLISION-FLAGS) ((self COLLISION-OBJECT) (flags integer))
  (COLLISION-OBJECT/SET-COLLISION-FLAGS (ff-pointer self) flags))

(defmethod CCD-SWEPT-SPHERE-RADIUS ((self COLLISION-OBJECT))
  (COLLISION-OBJECT/GET-CCD-SWEPT-SPHERE-RADIUS (ff-pointer self)))

(defmethod (SETF CCD-SWEPT-SPHERE-RADIUS) ((self COLLISION-OBJECT) (radius number))
  (COLLISION-OBJECT/SET-CCD-SWEPT-SPHERE-RADIUS (ff-pointer self) radius))

(defmethod CCD-MOTION-THRESHOLD ((self COLLISION-OBJECT))
  (COLLISION-OBJECT/GET-CCD-MOTION-THRESHOLD (ff-pointer self)))

(defmethod CCD-SQUARE-MOTION-THRESHOLD ((self COLLISION-OBJECT))
  (COLLISION-OBJECT/GET-CCD-SQUARE-MOTION-THRESHOLD (ff-pointer self)))

(defmethod (SETF CCD-MOTION-THRESHOLD) ((self COLLISION-OBJECT) (ccdMotionThreshold number))
  (COLLISION-OBJECT/SET-CCD-MOTION-THRESHOLD (ff-pointer self) ccdMotionThreshold))

(defmethod USER-POINTER ((self COLLISION-OBJECT))
  (COLLISION-OBJECT/GET-USER-POINTER (ff-pointer self)))

(defmethod USER-INDEX ((self COLLISION-OBJECT))
  (COLLISION-OBJECT/GET-USER-INDEX (ff-pointer self)))

(defmethod (SETF USER-POINTER) ((self COLLISION-OBJECT) userPointer)
  (COLLISION-OBJECT/SET-USER-POINTER (ff-pointer self) userPointer))

(defmethod (SETF USER-INDEX) ((self COLLISION-OBJECT) (index integer))
  (COLLISION-OBJECT/SET-USER-INDEX (ff-pointer self) index))

(defmethod UPDATE-REVISION-INTERNAL ((self COLLISION-OBJECT))
  (COLLISION-OBJECT/GET-UPDATE-REVISION-INTERNAL (ff-pointer self)))

(defmethod CHECK-COLLIDE-WITH ((self COLLISION-OBJECT) (co COLLISION-OBJECT))
  (COLLISION-OBJECT/CHECK-COLLIDE-WITH (ff-pointer self) (ff-pointer co)))

(defmethod CALCULATE-SERIALIZE-BUFFER-SIZE ((self COLLISION-OBJECT))
  (COLLISION-OBJECT/CALCULATE-SERIALIZE-BUFFER-SIZE (ff-pointer self)))

(defmethod serialize ((self collision-object) &key data-Buffer serializer
                                                &allow-other-keys)
  (collision-object/serialize (ff-pointer self) data-Buffer serializer))

(defmethod SERIALIZE-SINGLE-OBJECT ((self COLLISION-OBJECT) serializer)
  (COLLISION-OBJECT/SERIALIZE-SINGLE-OBJECT (ff-pointer self) serializer))



(defmethod initialize-instance :after ((obj DISCRETE-DYNAMICS-WORLD) &key dispatcher pair-Cache constraint-Solver collision-Configuration)
  (setf (slot-value obj 'ff-pointer) (MAKE-DISCRETE-DYNAMICS-WORLD dispatcher pair-Cache constraint-Solver collision-Configuration)))

(defmethod STEP-SIMULATION
    ((self DISCRETE-DYNAMICS-WORLD)
   (timeStep number) (maxSubSteps integer) (fixedTimeStep number))
  (discrete-dynamics-world/step-simulation (ff-pointer self)
                                           timeStep maxSubSteps fixedTimeStep))

#+ (or)
(defmethod STEP-SIMULATION
    ((self DISCRETE-DYNAMICS-WORLD)
   (timeStep number) (maxSubSteps integer))
  (discrete-dynamics-world/step-simulation (ff-pointer self)
                                           timeStep maxSubSteps))

#+ (or)
(defmethod STEP-SIMULATION ((self DISCRETE-DYNAMICS-WORLD) (timeStep number))
  (DISCRETE-DYNAMICS-WORLD/STEP-SIMULATION (ff-pointer self) timeStep))

(defmethod SYNCHRONIZE-MOTION-STATES ((self DISCRETE-DYNAMICS-WORLD))
  (DISCRETE-DYNAMICS-WORLD/SYNCHRONIZE-MOTION-STATES (ff-pointer self)))

(defmethod SYNCHRONIZE-SINGLE-MOTION-STATE ((self DISCRETE-DYNAMICS-WORLD) body)
  (DISCRETE-DYNAMICS-WORLD/SYNCHRONIZE-SINGLE-MOTION-STATE (ff-pointer self) body))

(defmethod ADD-CONSTRAINT ((self DISCRETE-DYNAMICS-WORLD) constraint (disableCollisionsBetweenLinkedBodies t))
  (DISCRETE-DYNAMICS-WORLD/ADD-CONSTRAINT (ff-pointer self) constraint disableCollisionsBetweenLinkedBodies))

#+ (or)
(defmethod ADD-CONSTRAINT ((self DISCRETE-DYNAMICS-WORLD) constraint)
  (DISCRETE-DYNAMICS-WORLD/ADD-CONSTRAINT (ff-pointer self) constraint))

(defmethod REMOVE-CONSTRAINT ((self DISCRETE-DYNAMICS-WORLD) constraint)
  (DISCRETE-DYNAMICS-WORLD/REMOVE-CONSTRAINT (ff-pointer self) constraint))

(defmethod ADD-ACTION ((self DISCRETE-DYNAMICS-WORLD) arg1)
  (DISCRETE-DYNAMICS-WORLD/ADD-ACTION (ff-pointer self) arg1))

(defmethod REMOVE-ACTION ((self DISCRETE-DYNAMICS-WORLD) arg1)
  (DISCRETE-DYNAMICS-WORLD/REMOVE-ACTION (ff-pointer self) arg1))

(defmethod SIMULATION-ISLAND-MANAGER ((self DISCRETE-DYNAMICS-WORLD))
  (DISCRETE-DYNAMICS-WORLD/GET-SIMULATION-ISLAND-MANAGER (ff-pointer self)))

(defmethod SIMULATION-ISLAND-MANAGER ((self DISCRETE-DYNAMICS-WORLD))
  (DISCRETE-DYNAMICS-WORLD/GET-SIMULATION-ISLAND-MANAGER (ff-pointer self)))

(defmethod COLLISION-WORLD ((self DISCRETE-DYNAMICS-WORLD))
  (DISCRETE-DYNAMICS-WORLD/GET-COLLISION-WORLD (ff-pointer self)))

(defmethod (SETF GRAVITY) ((self DISCRETE-DYNAMICS-WORLD) gravity)
  (DISCRETE-DYNAMICS-WORLD/SET-GRAVITY (ff-pointer self) gravity))

(defmethod GRAVITY ((self DISCRETE-DYNAMICS-WORLD))
  (DISCRETE-DYNAMICS-WORLD/GET-GRAVITY (ff-pointer self)))

(defmethod ADD-COLLISION-OBJECT ((self DISCRETE-DYNAMICS-WORLD) (collisionObject COLLISION-OBJECT) (collisionFilterGroup integer) (collisionFilterMask integer))
  (DISCRETE-DYNAMICS-WORLD/ADD-COLLISION-OBJECT (ff-pointer self) collisionObject collisionFilterGroup collisionFilterMask))

#+ (or)
(progn
  (defmethod ADD-COLLISION-OBJECT ((self DISCRETE-DYNAMICS-WORLD) (collisionObject COLLISION-OBJECT) (collisionFilterGroup integer))
    (DISCRETE-DYNAMICS-WORLD/ADD-COLLISION-OBJECT (ff-pointer self) collisionObject collisionFilterGroup))

  (defmethod ADD-COLLISION-OBJECT ((self DISCRETE-DYNAMICS-WORLD) (collisionObject COLLISION-OBJECT))
    (DISCRETE-DYNAMICS-WORLD/ADD-COLLISION-OBJECT (ff-pointer self) collisionObject))
 )

(defmethod REMOVE-RIGID-BODY ((self DISCRETE-DYNAMICS-WORLD) body)
  (DISCRETE-DYNAMICS-WORLD/REMOVE-RIGID-BODY (ff-pointer self) body))

(defmethod REMOVE-COLLISION-OBJECT ((self DISCRETE-DYNAMICS-WORLD) (collisionObject COLLISION-OBJECT))
  (DISCRETE-DYNAMICS-WORLD/REMOVE-COLLISION-OBJECT (ff-pointer self) collisionObject))

(defmethod DEBUG-DRAW-CONSTRAINT ((self DISCRETE-DYNAMICS-WORLD) constraint)
  (DISCRETE-DYNAMICS-WORLD/DEBUG-DRAW-CONSTRAINT (ff-pointer self) constraint))

(defmethod DEBUG-DRAW-WORLD ((self DISCRETE-DYNAMICS-WORLD))
  (DISCRETE-DYNAMICS-WORLD/DEBUG-DRAW-WORLD (ff-pointer self)))

(defmethod (SETF CONSTRAINT-SOLVER) ((self DISCRETE-DYNAMICS-WORLD) solver)
  (DISCRETE-DYNAMICS-WORLD/SET-CONSTRAINT-SOLVER (ff-pointer self) solver))

(defmethod CONSTRAINT-SOLVER ((self DISCRETE-DYNAMICS-WORLD))
  (DISCRETE-DYNAMICS-WORLD/GET-CONSTRAINT-SOLVER (ff-pointer self)))

(defmethod NUM-CONSTRAINTS ((self DISCRETE-DYNAMICS-WORLD))
  (DISCRETE-DYNAMICS-WORLD/GET-NUM-CONSTRAINTS (ff-pointer self)))

(defmethod CONSTRAINT ((self DISCRETE-DYNAMICS-WORLD) (index integer))
  (DISCRETE-DYNAMICS-WORLD/GET-CONSTRAINT (ff-pointer self) index))

(defmethod CONSTRAINT ((self DISCRETE-DYNAMICS-WORLD) (index integer))
  (DISCRETE-DYNAMICS-WORLD/GET-CONSTRAINT (ff-pointer self) index))

(defmethod WORLD-TYPE ((self DISCRETE-DYNAMICS-WORLD))
  (DISCRETE-DYNAMICS-WORLD/GET-WORLD-TYPE (ff-pointer self)))

(defmethod CLEAR-FORCES ((self DISCRETE-DYNAMICS-WORLD))
  (DISCRETE-DYNAMICS-WORLD/CLEAR-FORCES (ff-pointer self)))

(defmethod APPLY-GRAVITY ((self DISCRETE-DYNAMICS-WORLD))
  (DISCRETE-DYNAMICS-WORLD/APPLY-GRAVITY (ff-pointer self)))

(defmethod (SETF NUM-TASKS) ((self DISCRETE-DYNAMICS-WORLD) (numTasks integer))
  (DISCRETE-DYNAMICS-WORLD/SET-NUM-TASKS (ff-pointer self) numTasks))

(defmethod UPDATE-VEHICLES ((self DISCRETE-DYNAMICS-WORLD) (timeStep number))
  (DISCRETE-DYNAMICS-WORLD/UPDATE-VEHICLES (ff-pointer self) timeStep))

(defmethod ADD-VEHICLE ((self DISCRETE-DYNAMICS-WORLD) vehicle)
  (DISCRETE-DYNAMICS-WORLD/ADD-VEHICLE (ff-pointer self) vehicle))

(defmethod REMOVE-VEHICLE ((self DISCRETE-DYNAMICS-WORLD) vehicle)
  (DISCRETE-DYNAMICS-WORLD/REMOVE-VEHICLE (ff-pointer self) vehicle))

(defmethod ADD-CHARACTER ((self DISCRETE-DYNAMICS-WORLD) character)
  (DISCRETE-DYNAMICS-WORLD/ADD-CHARACTER (ff-pointer self) character))

(defmethod REMOVE-CHARACTER ((self DISCRETE-DYNAMICS-WORLD) character)
  (DISCRETE-DYNAMICS-WORLD/REMOVE-CHARACTER (ff-pointer self) character))

(defmethod (SETF SYNCHRONIZE-ALL-MOTION-STATES) ((self DISCRETE-DYNAMICS-WORLD) (synchronizeAll t))
  (DISCRETE-DYNAMICS-WORLD/SET-SYNCHRONIZE-ALL-MOTION-STATES (ff-pointer self) synchronizeAll))

(defmethod SYNCHRONIZE-ALL-MOTION-STATES ((self DISCRETE-DYNAMICS-WORLD))
  (DISCRETE-DYNAMICS-WORLD/GET-SYNCHRONIZE-ALL-MOTION-STATES (ff-pointer self)))

(defmethod (SETF APPLY-SPECULATIVE-CONTACT-RESTITUTION) ((self DISCRETE-DYNAMICS-WORLD) (enable t))
  (DISCRETE-DYNAMICS-WORLD/SET-APPLY-SPECULATIVE-CONTACT-RESTITUTION (ff-pointer self) enable))

(defmethod APPLY-SPECULATIVE-CONTACT-RESTITUTION ((self DISCRETE-DYNAMICS-WORLD))
  (DISCRETE-DYNAMICS-WORLD/GET-APPLY-SPECULATIVE-CONTACT-RESTITUTION (ff-pointer self)))

(defmethod serialize ((self discrete-dynamics-world) &key serializer
                                                       &allow-other-keys)
  (DISCRETE-DYNAMICS-WORLD/SERIALIZE (ff-pointer self) serializer))

(defmethod (SETF LATENCY-MOTION-STATE-INTERPOLATION) ((self DISCRETE-DYNAMICS-WORLD) (latencyInterpolation t))
  (DISCRETE-DYNAMICS-WORLD/SET-LATENCY-MOTION-STATE-INTERPOLATION (ff-pointer self) latencyInterpolation))

(defmethod LATENCY-MOTION-STATE-INTERPOLATION ((self DISCRETE-DYNAMICS-WORLD))
  (DISCRETE-DYNAMICS-WORLD/GET-LATENCY-MOTION-STATE-INTERPOLATION (ff-pointer self)))



(defmethod initialize-instance :after ((obj simple-dynamics-world)
                                       &key dispatcher pair-Cache constraint-Solver collision-Configuration)
  (setf (slot-value obj 'ff-pointer)
        (MAKE-SIMPLE-DYNAMICS-WORLD
           dispatcher pair-Cache constraint-Solver collision-Configuration)))

(defmethod STEP-SIMULATION ((self SIMPLE-DYNAMICS-WORLD) (timeStep number) (maxSubSteps integer) (fixedTimeStep number))
  (SIMPLE-DYNAMICS-WORLD/STEP-SIMULATION (ff-pointer self) timeStep maxSubSteps fixedTimeStep))

#+ (or)
(progn
  (defmethod STEP-SIMULATION ((self SIMPLE-DYNAMICS-WORLD) (timeStep number) (maxSubSteps integer))
    (SIMPLE-DYNAMICS-WORLD/STEP-SIMULATION (ff-pointer self) timeStep maxSubSteps))

  (defmethod STEP-SIMULATION ((self SIMPLE-DYNAMICS-WORLD) (timeStep number))
    (SIMPLE-DYNAMICS-WORLD/STEP-SIMULATION (ff-pointer self) timeStep)))

(defmethod (SETF GRAVITY) ((self SIMPLE-DYNAMICS-WORLD) gravity)
  (SIMPLE-DYNAMICS-WORLD/SET-GRAVITY (ff-pointer self) gravity))

(defmethod GRAVITY ((self SIMPLE-DYNAMICS-WORLD))
  (SIMPLE-DYNAMICS-WORLD/GET-GRAVITY (ff-pointer self)))

(defgeneric add-rigid-body (world body &optional group mask)
  (:method ((self simple-dynamics-world) body &optional group mask)
    (if group
        (progn
          (check-type group integer)
          (check-type mask integer)
          (SIMPLE-DYNAMICS-WORLD/ADD-RIGID-BODY/with-group&mask (ff-pointer self) body group mask))
        (SIMPLE-DYNAMICS-WORLD/ADD-RIGID-BODY (ff-pointer self) body)))
  (:method ((self discrete-dynamics-world) body &optional group mask)
    (if group
        (progn
          (check-type group integer)
          (check-type mask integer)
          (DISCRETE-DYNAMICS-WORLD/ADD-RIGID-BODY/with-group&mask (ff-pointer self) body group mask))
        (DISCRETE-DYNAMICS-WORLD/ADD-RIGID-BODY (ff-pointer self) body))))

(defmethod REMOVE-RIGID-BODY ((self SIMPLE-DYNAMICS-WORLD) body)
  (SIMPLE-DYNAMICS-WORLD/REMOVE-RIGID-BODY (ff-pointer self) body))

(defmethod DEBUG-DRAW-WORLD ((self SIMPLE-DYNAMICS-WORLD))
  (SIMPLE-DYNAMICS-WORLD/DEBUG-DRAW-WORLD (ff-pointer self)))

(defmethod ADD-ACTION ((self SIMPLE-DYNAMICS-WORLD) action)
  (SIMPLE-DYNAMICS-WORLD/ADD-ACTION (ff-pointer self) action))

(defmethod REMOVE-ACTION ((self SIMPLE-DYNAMICS-WORLD) action)
  (SIMPLE-DYNAMICS-WORLD/REMOVE-ACTION (ff-pointer self) action))

(defmethod REMOVE-COLLISION-OBJECT ((self SIMPLE-DYNAMICS-WORLD) (collisionObject COLLISION-OBJECT))
  (SIMPLE-DYNAMICS-WORLD/REMOVE-COLLISION-OBJECT (ff-pointer self) collisionObject))

(defmethod UPDATE-AABBS ((self SIMPLE-DYNAMICS-WORLD))
  (SIMPLE-DYNAMICS-WORLD/UPDATE-AABBS (ff-pointer self)))

(defmethod SYNCHRONIZE-MOTION-STATES ((self SIMPLE-DYNAMICS-WORLD))
  (SIMPLE-DYNAMICS-WORLD/SYNCHRONIZE-MOTION-STATES (ff-pointer self)))

(defmethod (SETF CONSTRAINT-SOLVER) ((self SIMPLE-DYNAMICS-WORLD) solver)
  (SIMPLE-DYNAMICS-WORLD/SET-CONSTRAINT-SOLVER (ff-pointer self) solver))

(defmethod CONSTRAINT-SOLVER ((self SIMPLE-DYNAMICS-WORLD))
  (SIMPLE-DYNAMICS-WORLD/GET-CONSTRAINT-SOLVER (ff-pointer self)))

(defmethod WORLD-TYPE ((self SIMPLE-DYNAMICS-WORLD))
  (SIMPLE-DYNAMICS-WORLD/GET-WORLD-TYPE (ff-pointer self)))

(defmethod CLEAR-FORCES ((self SIMPLE-DYNAMICS-WORLD))
  (SIMPLE-DYNAMICS-WORLD/CLEAR-FORCES (ff-pointer self)))

(define-constant +BULLET-VERSION+ 282)

(export '+BULLET-VERSION+)

(declaim (inline GET-VERSION))

(cffi:defcfun ("_wrap_btGetVersion" GET-VERSION) :int)

(export 'GET-VERSION)

(define-constant +LARGE-FLOAT+ 1d18)

(export '+LARGE-FLOAT+)

(cffi:defcvar ("btInfinityMask" *INFINITY-MASK*)
 :int)

(export '*INFINITY-MASK*)

(declaim (inline GET-INFINITY-MASK))

(cffi:defcfun ("_wrap_btGetInfinityMask" GET-INFINITY-MASK) :int)

(export 'GET-INFINITY-MASK)

(declaim (inline square-root))

(cffi:defcfun ("_wrap_btSqrt" square-root) :float
  (y :float))

(export 'square-root)

(declaim (inline FABS))

(cffi:defcfun ("_wrap_btFabs" FABS) :float
  (x :float))

(export 'FABS)

(declaim (inline cosine))

(cffi:defcfun ("_wrap_btCos" cosine) :float
  (x :float))

(export 'cosine)

(declaim (inline sine))

(cffi:defcfun ("_wrap_btSin" sine) :float
  (x :float))

(export 'sine)

(declaim (inline tangent))

(cffi:defcfun ("_wrap_btTan" tangent) :float
  (x :float))

(export 'tangent)

(declaim (inline arc-cosine))

(cffi:defcfun ("_wrap_btAcos" arc-cosine) :float
  (x :float))

(export 'arc-cosine)

(declaim (inline arc-sine))

(cffi:defcfun ("_wrap_btAsin" arc-sine) :float
  (x :float))

(export 'arc-sine)

(declaim (inline arc-tangent))

(cffi:defcfun ("_wrap_btAtan" arc-tangent) :float
  (x :float))

(export 'arc-tangent)

(declaim (inline ATAN-2))

(cffi:defcfun ("_wrap_btAtan2" ATAN-2) :float
  (x :float)
  (y :float))

(export 'ATAN-2)

(declaim (inline exponent))

(cffi:defcfun ("_wrap_btExp" exponent) :float
  (x :float))

(export 'exponent)

(declaim (inline logarithm))

(cffi:defcfun ("_wrap_btLog" logarithm) :float
  (x :float))

(export 'logarithm)

(declaim (inline power))

(cffi:defcfun ("_wrap_btPow" power) :float
  (x :float)
  (y :float))

(export 'power)

(declaim (inline FMOD))

(cffi:defcfun ("_wrap_btFmod" FMOD) :float
  (x :float)
  (y :float))

(export 'FMOD)

(declaim (inline ATAN-2-FAST))

(cffi:defcfun ("_wrap_btAtan2Fast" ATAN-2-FAST) :float
  (y :float)
  (x :float))

(export 'ATAN-2-FAST)

(declaim (inline FUZZY-ZERO))

(cffi:defcfun ("_wrap_btFuzzyZero" FUZZY-ZERO) :pointer
  (x :float))

(export 'FUZZY-ZERO)

(declaim (inline equals))

(cffi:defcfun ("_wrap_btEqual" equals) :pointer
  (a :float)
  (eps :float))

(export 'equals)

(declaim (inline GREATER-EQUAL))

(cffi:defcfun ("_wrap_btGreaterEqual" GREATER-EQUAL) :pointer
  (a :float)
  (eps :float))

(export 'GREATER-EQUAL)

(declaim (inline IS-NEGATIVE))

(cffi:defcfun ("_wrap_btIsNegative" IS-NEGATIVE) :int
  (x :float))

(export 'IS-NEGATIVE)

(declaim (inline RADIANS))

(cffi:defcfun ("_wrap_btRadians" RADIANS) :float
  (x :float))

(export 'RADIANS)

(declaim (inline DEGREES))

(cffi:defcfun ("_wrap_btDegrees" DEGREES) :float
  (x :float))

(export 'DEGREES)

(declaim (inline FSEL))

(cffi:defcfun ("_wrap_btFsel" FSEL) :float
  (a :float)
  (b :float)
  (c :float))

(export 'FSEL)

(declaim (inline MACHINE-IS-LITTLE-ENDIAN))

(cffi:defcfun ("_wrap_btMachineIsLittleEndian" MACHINE-IS-LITTLE-ENDIAN) :pointer)

(export 'MACHINE-IS-LITTLE-ENDIAN)
#+ need-funky-select-forms
(progn
  (declaim (inline SELECT))

  (cffi:defcfun ("_wrap_btSelect__SWIG_0" SELECT) :unsigned-int
         (condition :unsigned-int)
         (valueIfConditionNonZero :unsigned-int)
         (valueIfConditionZero :unsigned-int))

  (export 'SELECT)

  (declaim (inline SELECT))

  (cffi:defcfun ("_wrap_btSelect__SWIG_1" SELECT) :int
         (condition :unsigned-int)
         (valueIfConditionNonZero :int)
         (valueIfConditionZero :int))

  (export 'SELECT)

  (declaim (inline SELECT))

  (cffi:defcfun ("_wrap_btSelect__SWIG_2" SELECT) :float
         (condition :unsigned-int)
         (valueIfConditionNonZero :float)
         (valueIfConditionZero :float))

  (export 'SELECT)
       )
(declaim (inline SWAP-ENDIAN))

(cffi:defcfun ("_wrap_btSwapEndian__SWIG_0" SWAP-ENDIAN) :unsigned-int
  (val :unsigned-int))

(export 'SWAP-ENDIAN)

(declaim (inline SWAP-ENDIAN))

(cffi:defcfun ("_wrap_btSwapEndian__SWIG_1"
               swap-endian/unsigned-short) :unsigned-short
  (val :unsigned-short))

(export 'SWAP-ENDIAN)

(declaim (inline SWAP-ENDIAN))

(cffi:defcfun ("_wrap_btSwapEndian__SWIG_2" 
               swap-endian/int) :unsigned-int
  (val :int))

(export 'SWAP-ENDIAN)

(declaim (inline SWAP-ENDIAN))

(cffi:defcfun ("_wrap_btSwapEndian__SWIG_3" swap-endian/short)
    :unsigned-short
  (val :short))

(export 'SWAP-ENDIAN)

(declaim (inline SWAP-ENDIAN-FLOAT))

(cffi:defcfun ("_wrap_btSwapEndianFloat" swap-endian/float) :unsigned-int
  (d :float))

(export 'SWAP-ENDIAN-FLOAT)

(declaim (inline UNSWAP-ENDIAN-FLOAT))

(cffi:defcfun ("_wrap_btUnswapEndianFloat" unswap-endian/float) :float
  (a :unsigned-int))

(export 'UNSWAP-ENDIAN-FLOAT)

(declaim (inline SWAP-ENDIAN-DOUBLE))

(cffi:defcfun ("_wrap_btSwapEndianDouble" swap-endian/double) :void
  (d :double)
  (dst :pointer))

(export 'SWAP-ENDIAN-DOUBLE)

(declaim (inline UNSWAP-ENDIAN-DOUBLE))

(cffi:defcfun ("_wrap_btUnswapEndianDouble" unswap-endian/double) :double
  (src :pointer))

(export 'UNSWAP-ENDIAN-DOUBLE)

(declaim (inline LARGE-DOT))

(cffi:defcfun ("_wrap_btLargeDot" LARGE-DOT) :float
  (a :pointer)
  (b :pointer)
  (n :int))

(export 'LARGE-DOT)

(declaim (inline NORMALIZE-ANGLE))

(cffi:defcfun ("_wrap_btNormalizeAngle" NORMALIZE-ANGLE) :float
  (angleInRadians :float))

(export 'NORMALIZE-ANGLE)

(cffi:defcstruct TYPED-OBJECT
  (OBJECT-TYPE :int)
  (GET-OBJECT-TYPE :pointer))

(export 'TYPED-OBJECT)

(export 'OBJECT-TYPE)

(export 'GET-OBJECT-TYPE)

(declaim (inline ALIGNED-ALLOC-INTERNAL))

(cffi:defcfun ("_wrap_btAlignedAllocInternal" ALIGNED-ALLOC-INTERNAL) :pointer
  (size :pointer)
  (alignment :int))

(export 'ALIGNED-ALLOC-INTERNAL)

(declaim (inline ALIGNED-FREE-INTERNAL))

(cffi:defcfun ("_wrap_btAlignedFreeInternal" ALIGNED-FREE-INTERNAL) :void
  (ptr :pointer))

(export 'ALIGNED-FREE-INTERNAL)

(declaim (inline ALIGNED-ALLOC-SET-CUSTOM))

(cffi:defcfun ("_wrap_btAlignedAllocSetCustom" ALIGNED-ALLOC-SET-CUSTOM) :void
  (allocFunc :pointer)
  (freeFunc :pointer))

(export 'ALIGNED-ALLOC-SET-CUSTOM)

(declaim (inline ALIGNED-ALLOC-SET-CUSTOM-ALIGNED))

(cffi:defcfun ("_wrap_btAlignedAllocSetCustomAligned" ALIGNED-ALLOC-SET-CUSTOM-ALIGNED) :void
  (allocFunc :pointer)
  (freeFunc :pointer))

(export 'ALIGNED-ALLOC-SET-CUSTOM-ALIGNED)

(define-constant +VECTOR-3-DATA-NAME+
  "btVector3FloatData"
                 :test 'equal)

(export '+VECTOR-3-DATA-NAME+)

(declaim (inline VECTOR-3/MAKE-CPLUS-PLUS-INSTANCE))

(cffi:defcfun ("_wrap_btVector3_makeCPlusPlusInstance__SWIG_0" VECTOR-3/MAKE-CPLUS-PLUS-INSTANCE) :pointer
  (self :pointer)
  (sizeInBytes :pointer))

(export 'VECTOR-3/MAKE-CPLUS-PLUS-INSTANCE)

(declaim (inline VECTOR-3/DELETE-CPLUS-PLUS-INSTANCE))

(cffi:defcfun ("_wrap_btVector3_deleteCPlusPlusInstance__SWIG_0" VECTOR-3/DELETE-CPLUS-PLUS-INSTANCE) :void
  (self :pointer)
  (ptr :pointer))

(export 'VECTOR-3/DELETE-CPLUS-PLUS-INSTANCE)

(declaim (inline VECTOR-3/MAKE-CPLUS-PLUS-INSTANCE))

(cffi:defcfun ("_wrap_btVector3_makeCPlusPlusInstance__SWIG_1"
               VECTOR-3/MAKE-CPLUS-PLUS-INSTANCE+ARG1) :pointer
  (self :pointer)
  (arg1 :pointer)
  (ptr :pointer))

(export 'VECTOR-3/MAKE-CPLUS-PLUS-INSTANCE)

(declaim (inline VECTOR-3/DELETE-CPLUS-PLUS-INSTANCE))

(cffi:defcfun ("_wrap_btVector3_deleteCPlusPlusInstance__SWIG_1" 
               VECTOR-3/DELETE-CPLUS-PLUS-INSTANCE+ARG2+ARG3) :void
  (self :pointer)
  (arg1 :pointer)
  (arg2 :pointer))

(export 'VECTOR-3/DELETE-CPLUS-PLUS-INSTANCE)

(declaim (inline VECTOR-3/MAKE-CPLUS-ARRAY))

(cffi:defcfun ("_wrap_btVector3_makeCPlusArray__SWIG_0" VECTOR-3/MAKE-CPLUS-ARRAY) :pointer
  (self :pointer)
  (sizeInBytes :pointer))

(export 'VECTOR-3/MAKE-CPLUS-ARRAY)

(declaim (inline VECTOR-3/DELETE-CPLUS-ARRAY))

(cffi:defcfun ("_wrap_btVector3_deleteCPlusArray__SWIG_0" VECTOR-3/DELETE-CPLUS-ARRAY) :void
  (self :pointer)
  (ptr :pointer))

(export 'VECTOR-3/DELETE-CPLUS-ARRAY)

(declaim (inline VECTOR-3/MAKE-CPLUS-ARRAY))

(cffi:defcfun ("_wrap_btVector3_makeCPlusArray__SWIG_1" VECTOR-3/MAKE-CPLUS-ARRAY+ARG1) :pointer
  (self :pointer)
  (arg1 :pointer)
  (ptr :pointer))

(export 'VECTOR-3/MAKE-CPLUS-ARRAY)

(declaim (inline VECTOR-3/DELETE-CPLUS-ARRAY))

(cffi:defcfun ("_wrap_btVector3_deleteCPlusArray__SWIG_1" VECTOR-3/DELETE-CPLUS-ARRAY+arg1+arg2) :void
  (self :pointer)
  (arg1 :pointer)
  (arg2 :pointer))

(export 'VECTOR-3/DELETE-CPLUS-ARRAY)

(declaim (inline VECTOR-3/M/FLOATS/SET))

(cffi:defcfun ("_wrap_btVector3_m_floats_set" VECTOR-3/M/FLOATS/SET) :void
  (self :pointer)
  (m_floats :pointer))

(export 'VECTOR-3/M/FLOATS/SET)

(declaim (inline VECTOR-3/M/FLOATS/GET))

(cffi:defcfun ("_wrap_btVector3_m_floats_get" VECTOR-3/M/FLOATS/GET) :pointer
  (self :pointer))

(export 'VECTOR-3/M/FLOATS/GET)

(declaim (inline make-vector3/naked))

(cffi:defcfun ("_wrap_new_btVector3__SWIG_0" make-vector3/naked) :pointer)

(declaim (inline make-vector3/x&y&z))

(cffi:defcfun ("_wrap_new_btVector3__SWIG_1" 
               make-vector3/x&y&z) :pointer
  (_x :pointer)
  (_y :pointer)
  (_z :pointer))

(declaim (inline make-vector3))

(defun make-vector3 (&optional (x nil x?) y (z nil z?))
  (cond
    (z? (make-vector3/x&y&z x y z))
    (x? (error "MAKE-VECTOR-3 requires either 0 or 3 arguments"))
    (t (make-vector3/naked))))

(export 'make-vector3)

(declaim (inline VECTOR-3/INCREMENT))

(cffi:defcfun ("_wrap_btVector3_increment" VECTOR-3/INCREMENT) :pointer
  (self :pointer)
  (v :pointer))

(export 'VECTOR-3/INCREMENT)

(declaim (inline VECTOR-3/DECREMENT))

(cffi:defcfun ("_wrap_btVector3_decrement" VECTOR-3/DECREMENT) :pointer
  (self :pointer)
  (v :pointer))

(export 'VECTOR-3/DECREMENT)

(declaim (inline VECTOR-3/MULTIPLY-AND-ASSIGN))

(cffi:defcfun ("_wrap_btVector3_multiplyAndAssign__SWIG_0" VECTOR-3/MULTIPLY-AND-ASSIGN) :pointer
  (self :pointer)
  (s :pointer))

(export 'VECTOR-3/MULTIPLY-AND-ASSIGN)

(declaim (inline VECTOR-3/DIVIDE-AND-ASSIGN))

(cffi:defcfun ("_wrap_btVector3_divideAndAssign" VECTOR-3/DIVIDE-AND-ASSIGN) :pointer
  (self :pointer)
  (s :pointer))

(export 'VECTOR-3/DIVIDE-AND-ASSIGN)

(declaim (inline VECTOR-3/DOT))

(cffi:defcfun ("_wrap_btVector3_dot" VECTOR-3/DOT) :float
  (self :pointer)
  (v :pointer))

(export 'VECTOR-3/DOT)

(declaim (inline VECTOR-3/LENGTH-2))

(cffi:defcfun ("_wrap_btVector3_length2" VECTOR-3/LENGTH-2) :float
  (self :pointer))

(export 'VECTOR-3/LENGTH-2)

(declaim (inline VECTOR-3/LENGTH))

(cffi:defcfun ("_wrap_btVector3_length" VECTOR-3/LENGTH) :float
  (self :pointer))

(export 'VECTOR-3/LENGTH)

(declaim (inline VECTOR-3/NORM))

(cffi:defcfun ("_wrap_btVector3_norm" VECTOR-3/NORM) :float
  (self :pointer))

(export 'VECTOR-3/NORM)

(declaim (inline VECTOR-3/DISTANCE-2))

(cffi:defcfun ("_wrap_btVector3_distance2" VECTOR-3/DISTANCE-2) :float
  (self :pointer)
  (v :pointer))

(export 'VECTOR-3/DISTANCE-2)

(declaim (inline VECTOR-3/DISTANCE))

(cffi:defcfun ("_wrap_btVector3_distance" VECTOR-3/DISTANCE) :float
  (self :pointer)
  (v :pointer))

(export 'VECTOR-3/DISTANCE)

(declaim (inline VECTOR-3/SAFE-NORMALIZE))

(cffi:defcfun ("_wrap_btVector3_safeNormalize" VECTOR-3/SAFE-NORMALIZE) :pointer
  (self :pointer))

(export 'VECTOR-3/SAFE-NORMALIZE)

(declaim (inline VECTOR-3/NORMALIZE))

(cffi:defcfun ("_wrap_btVector3_normalize" VECTOR-3/NORMALIZE) :pointer
  (self :pointer))

(export 'VECTOR-3/NORMALIZE)

(declaim (inline VECTOR-3/NORMALIZED))

(cffi:defcfun ("_wrap_btVector3_normalized" VECTOR-3/NORMALIZED) :pointer
  (self :pointer))

(export 'VECTOR-3/NORMALIZED)

(declaim (inline VECTOR-3/ROTATE))

(cffi:defcfun ("_wrap_btVector3_rotate" VECTOR-3/ROTATE) :pointer
  (self :pointer)
  (wAxis :pointer)
  (angle :float))

(export 'VECTOR-3/ROTATE)

(declaim (inline VECTOR-3/ANGLE))

(cffi:defcfun ("_wrap_btVector3_angle" VECTOR-3/ANGLE) :float
  (self :pointer)
  (v :pointer))

(export 'VECTOR-3/ANGLE)

(declaim (inline VECTOR-3/ABSOLUTE))

(cffi:defcfun ("_wrap_btVector3_absolute" VECTOR-3/ABSOLUTE) :pointer
  (self :pointer))

(export 'VECTOR-3/ABSOLUTE)

(declaim (inline VECTOR-3/CROSS))

(cffi:defcfun ("_wrap_btVector3_cross" VECTOR-3/CROSS) :pointer
  (self :pointer)
  (v :pointer))

(export 'VECTOR-3/CROSS)

(declaim (inline VECTOR-3/TRIPLE))

(cffi:defcfun ("_wrap_btVector3_triple" VECTOR-3/TRIPLE) :float
  (self :pointer)
  (v1 :pointer)
  (v2 :pointer))

(export 'VECTOR-3/TRIPLE)

(declaim (inline VECTOR-3/MIN-AXIS))

(cffi:defcfun ("_wrap_btVector3_minAxis" VECTOR-3/MIN-AXIS) :int
  (self :pointer))

(export 'VECTOR-3/MIN-AXIS)

(declaim (inline VECTOR-3/MAX-AXIS))

(cffi:defcfun ("_wrap_btVector3_maxAxis" VECTOR-3/MAX-AXIS) :int
  (self :pointer))

(export 'VECTOR-3/MAX-AXIS)

(declaim (inline VECTOR-3/FURTHEST-AXIS))

(cffi:defcfun ("_wrap_btVector3_furthestAxis" VECTOR-3/FURTHEST-AXIS) :int
  (self :pointer))

(export 'VECTOR-3/FURTHEST-AXIS)

(declaim (inline VECTOR-3/CLOSEST-AXIS))

(cffi:defcfun ("_wrap_btVector3_closestAxis" VECTOR-3/CLOSEST-AXIS) :int
  (self :pointer))

(export 'VECTOR-3/CLOSEST-AXIS)

(declaim (inline VECTOR-3/SET-INTERPOLATE-3))

(cffi:defcfun ("_wrap_btVector3_setInterpolate3" VECTOR-3/SET-INTERPOLATE-3) :void
  (self :pointer)
  (v0 :pointer)
  (v1 :pointer)
  (rt :float))

(export 'VECTOR-3/SET-INTERPOLATE-3)

#+ (or)
(progn (declaim (inline vector3/vlerp))

 (cffi:defcfun ("_wrap_btVector3_lerp" vector3/vlerp) :pointer
   (self :pointer)
   (v :pointer)
   (t_arg2 :pointer))

 (export 'vector3/vlerp))

#+ (or)
(progn (declaim (inline VECTOR-3/MULTIPLY-AND-ASSIGN))

       (cffi:defcfun ("_wrap_btVector3_multiplyAndAssign__SWIG_1" VECTOR-3/MULTIPLY-AND-ASSIGN) :pointer
   (self :pointer)
   (v :pointer))

       (export 'VECTOR-3/MULTIPLY-AND-ASSIGN))

(declaim (inline VECTOR-3/GET-X))

(cffi:defcfun ("_wrap_btVector3_getX" VECTOR-3/GET-X) :pointer
  (self :pointer))

(export 'VECTOR-3/GET-X)

(declaim (inline VECTOR-3/GET-Y))

(cffi:defcfun ("_wrap_btVector3_getY" VECTOR-3/GET-Y) :pointer
  (self :pointer))

(export 'VECTOR-3/GET-Y)

(declaim (inline VECTOR-3/GET-Z))

(cffi:defcfun ("_wrap_btVector3_getZ" VECTOR-3/GET-Z) :pointer
  (self :pointer))

(export 'VECTOR-3/GET-Z)

(declaim (inline VECTOR-3/SET-X))

(cffi:defcfun ("_wrap_btVector3_setX" VECTOR-3/SET-X) :void
  (self :pointer)
  (_x :float))

(export 'VECTOR-3/SET-X)

(declaim (inline VECTOR-3/SET-Y))

(cffi:defcfun ("_wrap_btVector3_setY" VECTOR-3/SET-Y) :void
  (self :pointer)
  (_y :float))

(export 'VECTOR-3/SET-Y)

(declaim (inline VECTOR-3/SET-Z))

(cffi:defcfun ("_wrap_btVector3_setZ" VECTOR-3/SET-Z) :void
  (self :pointer)
  (_z :float))

(export 'VECTOR-3/SET-Z)

(declaim (inline VECTOR-3/SET-W))

(cffi:defcfun ("_wrap_btVector3_setW" VECTOR-3/SET-W) :void
  (self :pointer)
  (_w :float))

(export 'VECTOR-3/SET-W)

(declaim (inline VECTOR-3/X))

(cffi:defcfun ("_wrap_btVector3_x" VECTOR-3/X) :pointer
  (self :pointer))

(export 'VECTOR-3/X)

(declaim (inline VECTOR-3/Y))

(cffi:defcfun ("_wrap_btVector3_y" VECTOR-3/Y) :pointer
  (self :pointer))

(export 'VECTOR-3/Y)

(declaim (inline VECTOR-3/Z))

(cffi:defcfun ("_wrap_btVector3_z" VECTOR-3/Z) :pointer
  (self :pointer))

(export 'VECTOR-3/Z)

(declaim (inline VECTOR-3/W))

(cffi:defcfun ("_wrap_btVector3_w" VECTOR-3/W) :pointer
  (self :pointer))

(export 'VECTOR-3/W)

(declaim (inline VECTOR-3/IS-EQUAL))

(cffi:defcfun ("_wrap_btVector3_isEqual" VECTOR-3/IS-EQUAL) :pointer
  (self :pointer)
  (other :pointer))

(export 'VECTOR-3/IS-EQUAL)

(declaim (inline VECTOR-3/NOT-EQUALS))

(cffi:defcfun ("_wrap_btVector3_notEquals" VECTOR-3/NOT-EQUALS) :pointer
  (self :pointer)
  (other :pointer))

(export 'VECTOR-3/NOT-EQUALS)

(declaim (inline VECTOR-3/SET-MAX))

(cffi:defcfun ("_wrap_btVector3_setMax" VECTOR-3/SET-MAX) :void
  (self :pointer)
  (other :pointer))

(export 'VECTOR-3/SET-MAX)

(declaim (inline VECTOR-3/SET-MIN))

(cffi:defcfun ("_wrap_btVector3_setMin" VECTOR-3/SET-MIN) :void
  (self :pointer)
  (other :pointer))

(export 'VECTOR-3/SET-MIN)

(declaim (inline VECTOR-3/SET-VALUE))

(cffi:defcfun ("_wrap_btVector3_setValue" VECTOR-3/SET-VALUE) :void
  (self :pointer)
  (_x :pointer)
  (_y :pointer)
  (_z :pointer))

(export 'VECTOR-3/SET-VALUE)

(declaim (inline VECTOR-3/GET-SKEW-SYMMETRIC-MATRIX))

(cffi:defcfun ("_wrap_btVector3_getSkewSymmetricMatrix" VECTOR-3/GET-SKEW-SYMMETRIC-MATRIX) :void
  (self :pointer)
  (v0 :pointer)
  (v1 :pointer)
  (v2 :pointer))

(export 'VECTOR-3/GET-SKEW-SYMMETRIC-MATRIX)

(declaim (inline VECTOR-3/SET-ZERO))

(cffi:defcfun ("_wrap_btVector3_setZero" VECTOR-3/SET-ZERO) :void
  (self :pointer))

(export 'VECTOR-3/SET-ZERO)

(declaim (inline VECTOR-3/IS-ZERO))

(cffi:defcfun ("_wrap_btVector3_isZero" VECTOR-3/IS-ZERO) :pointer
  (self :pointer))

(export 'VECTOR-3/IS-ZERO)

(declaim (inline VECTOR-3/FUZZY-ZERO))

(cffi:defcfun ("_wrap_btVector3_fuzzyZero" VECTOR-3/FUZZY-ZERO) :pointer
  (self :pointer))

(export 'VECTOR-3/FUZZY-ZERO)

(declaim (inline VECTOR-3/SERIALIZE))

(cffi:defcfun ("_wrap_btVector3_serialize" VECTOR-3/SERIALIZE) :void
  (self :pointer)
  (dataOut :pointer))

(export 'VECTOR-3/SERIALIZE)

(declaim (inline VECTOR-3/DE-SERIALIZE))

(cffi:defcfun ("_wrap_btVector3_deSerialize" VECTOR-3/DE-SERIALIZE) :void
  (self :pointer)
  (dataIn :pointer))

(export 'VECTOR-3/DE-SERIALIZE)

(declaim (inline VECTOR-3/SERIALIZE-FLOAT))

(cffi:defcfun ("_wrap_btVector3_serializeFloat" VECTOR-3/SERIALIZE-FLOAT) :void
  (self :pointer)
  (dataOut :pointer))

(export 'VECTOR-3/SERIALIZE-FLOAT)

(declaim (inline VECTOR-3/DE-SERIALIZE-FLOAT))

(cffi:defcfun ("_wrap_btVector3_deSerializeFloat" VECTOR-3/DE-SERIALIZE-FLOAT) :void
  (self :pointer)
  (dataIn :pointer))

(export 'VECTOR-3/DE-SERIALIZE-FLOAT)

(declaim (inline VECTOR-3/SERIALIZE-DOUBLE))

(cffi:defcfun ("_wrap_btVector3_serializeDouble" VECTOR-3/SERIALIZE-DOUBLE) :void
  (self :pointer)
  (dataOut :pointer))

(export 'VECTOR-3/SERIALIZE-DOUBLE)

(declaim (inline VECTOR-3/DE-SERIALIZE-DOUBLE))

(cffi:defcfun ("_wrap_btVector3_deSerializeDouble" VECTOR-3/DE-SERIALIZE-DOUBLE) :void
  (self :pointer)
  (dataIn :pointer))

(export 'VECTOR-3/DE-SERIALIZE-DOUBLE)

(declaim (inline VECTOR-3/MAX-DOT))

(cffi:defcfun ("_wrap_btVector3_maxDot" VECTOR-3/MAX-DOT) :long
  (self :pointer)
  (array :pointer)
  (array_count :long)
  (dotOut :pointer))

(export 'VECTOR-3/MAX-DOT)

(declaim (inline VECTOR-3/MIN-DOT))

(cffi:defcfun ("_wrap_btVector3_minDot" VECTOR-3/MIN-DOT) :long
  (self :pointer)
  (array :pointer)
  (array_count :long)
  (dotOut :pointer))

(export 'VECTOR-3/MIN-DOT)

(declaim (inline VECTOR-3/DOT-3))

(cffi:defcfun ("_wrap_btVector3_dot3" VECTOR-3/DOT-3) :pointer
  (self :pointer)
  (v0 :pointer)
  (v1 :pointer)
  (v2 :pointer))

(export 'VECTOR-3/DOT-3)

(declaim (inline DELETE/BT-VECTOR-3))

(cffi:defcfun ("_wrap_delete_btVector3" DELETE/BT-VECTOR-3) :void
  (self :pointer))

(export 'DELETE/BT-VECTOR-3)

(declaim (inline vector3/dot))

(cffi:defcfun ("_wrap_btDot" vector3/dot) :float
  (v1 :pointer)
  (v2 :pointer))

(export 'vector3/dot)

(declaim (inline DISTANCE-2))

(cffi:defcfun ("_wrap_btDistance2" DISTANCE-2) :float
  (v1 :pointer)
  (v2 :pointer))

(export 'DISTANCE-2)

(declaim (inline DISTANCE))

(cffi:defcfun ("_wrap_btDistance" DISTANCE) :float
  (v1 :pointer)
  (v2 :pointer))

(export 'DISTANCE)

(declaim (inline vector/angle))

(cffi:defcfun ("_wrap_btAngle__SWIG_0" vector/angle) :float
  (v1 :pointer)
  (v2 :pointer))

(export 'vector/angle)

(declaim (inline CROSS))

(cffi:defcfun ("_wrap_btCross" CROSS) :pointer
  (v1 :pointer)
  (v2 :pointer))

(export 'CROSS)

(declaim (inline TRIPLE))

(cffi:defcfun ("_wrap_btTriple" TRIPLE) :float
  (v1 :pointer)
  (v2 :pointer)
  (v3 :pointer))

(export 'TRIPLE)

(declaim (inline VLERP))

(cffi:defcfun ("_wrap_lerp" VLERP) :pointer
  (v1 :pointer)
  (v2 :pointer)
  (t_arg2 :pointer))

(export 'VLERP)

(declaim (inline make-vector-4/naked))

(cffi:defcfun ("_wrap_new_btVector4__SWIG_0" make-vector4/naked) :pointer)

(declaim (inline make-vector-4/x&y&z&w))

(cffi:defcfun ("_wrap_new_btVector4__SWIG_1" make-vector-4/x&y&z&w) :pointer
  (_x :pointer)
  (_y :pointer)
  (_z :pointer)
  (_w :pointer))

(declaim (inline make-vector-4))

(defun make-vector-4 (&optional (x nil x?) y z (w nil w?))
  (cond
    (w? (make-vector-4/x&y&z&w x y z w))
    (x? (error "MAKE-VECTOR-4 requires either 0 or 4 arguments"))
    (t (make-vector-4/naked))))

(export 'make-vector-4)

(declaim (inline VECTOR-4/ABSOLUTE-4))

(cffi:defcfun ("_wrap_btVector4_absolute4" VECTOR-4/ABSOLUTE-4) :pointer
  (self :pointer))

(export 'VECTOR-4/ABSOLUTE-4)

(declaim (inline VECTOR-4/GET-W))

(cffi:defcfun ("_wrap_btVector4_getW" VECTOR-4/GET-W) :float
  (self :pointer))

(export 'VECTOR-4/GET-W)

(declaim (inline VECTOR-4/MAX-AXIS-4))

(cffi:defcfun ("_wrap_btVector4_maxAxis4" VECTOR-4/MAX-AXIS-4) :int
  (self :pointer))

(export 'VECTOR-4/MAX-AXIS-4)

(declaim (inline VECTOR-4/MIN-AXIS-4))

(cffi:defcfun ("_wrap_btVector4_minAxis4" VECTOR-4/MIN-AXIS-4) :int
  (self :pointer))

(export 'VECTOR-4/MIN-AXIS-4)

(declaim (inline VECTOR-4/CLOSEST-AXIS-4))

(cffi:defcfun ("_wrap_btVector4_closestAxis4" VECTOR-4/CLOSEST-AXIS-4) :int
  (self :pointer))

(export 'VECTOR-4/CLOSEST-AXIS-4)

(declaim (inline VECTOR-4/SET-VALUE))

(cffi:defcfun ("_wrap_btVector4_setValue" VECTOR-4/SET-VALUE) :void
  (self :pointer)
  (_x :pointer)
  (_y :pointer)
  (_z :pointer)
  (_w :pointer))

(export 'VECTOR-4/SET-VALUE)

(declaim (inline DELETE/BT-VECTOR-4))

(cffi:defcfun ("_wrap_delete_btVector4" DELETE/BT-VECTOR-4) :void
  (self :pointer))

(export 'DELETE/BT-VECTOR-4)

(declaim (inline SWAP-SCALAR-ENDIAN))

(cffi:defcfun ("_wrap_btSwapScalarEndian" SWAP-SCALAR-ENDIAN) :void
  (sourceVal :pointer)
  (destVal :pointer))

(export 'SWAP-SCALAR-ENDIAN)

(declaim (inline SWAP-VECTOR-3-ENDIAN))

(cffi:defcfun ("_wrap_btSwapVector3Endian" SWAP-VECTOR-3-ENDIAN) :void
  (sourceVec :pointer)
  (destVec :pointer))

(export 'SWAP-VECTOR-3-ENDIAN)

(declaim (inline UN-SWAP-VECTOR-3-ENDIAN))

(cffi:defcfun ("_wrap_btUnSwapVector3Endian" UN-SWAP-VECTOR-3-ENDIAN) :void
  (vector :pointer))

(export 'UN-SWAP-VECTOR-3-ENDIAN)

(cffi:defcstruct VECTOR-3-FLOAT-DATA
  (FLOATS :pointer))

(export 'VECTOR-3-FLOAT-DATA)

(export 'FLOATS)

(cffi:defcstruct VECTOR-3-DOUBLE-DATA
  (FLOATS :pointer))

(export 'VECTOR-3-DOUBLE-DATA)

(export 'FLOATS)

(declaim (inline make-quaternion/naked))

(cffi:defcfun ("_wrap_new_btQuaternion__SWIG_0"  make-quaternion/naked) :pointer)

(declaim (inline  make-quaternion/x&y&z&w))

(cffi:defcfun ("_wrap_new_btQuaternion__SWIG_1" make-quaternion/x&y&z&w) :pointer
  (_x :pointer)
  (_y :pointer)
  (_z :pointer)
  (_w :pointer))

(declaim (inline make-quaternion/axis&angle))

(cffi:defcfun ("_wrap_new_btQuaternion__SWIG_2"
               make-quaternion/axis&angle) :pointer
  (_axis :pointer)
  (_angle :pointer))

(declaim (inline make-quaternion/yaw&pitch&roll))

(cffi:defcfun ("_wrap_new_btQuaternion__SWIG_3"
               make-quaternion/yaw&pitch&roll) :pointer
  (yaw :pointer)
  (pitch :pointer)
  (roll :pointer))

(declaim (inline make-quaternion))

(defun make-quaternion  (&optional 
                           (x/axis/yaw nil x?) 
                           (y/angle/pitch nil y?) 
                           (z/roll nil z?)
                           (w nil w?))
  (cond
    (w? (make-quaternion/x&y&z&w         x/axis/yaw y/angle/pitch z/roll w))
    (z? (make-quaternion/yaw&pitch&roll  x/axis/yaw y/angle/pitch z/roll))
    (y? (make-quaternion/axis&angle      x/axis/yaw y/angle/pitch))
    (x? (error "MAKE-QUATERNION needs 0 args or 2 (axis&angle) or 3 (yaw&pitch&roll) or 4 (x&y&z&w)"))
    (t (make-quaternion/naked))))

(export 'MAKE-QUATERNION)

(declaim (inline QUATERNION/SET-ROTATION))

(cffi:defcfun ("_wrap_btQuaternion_setRotation" QUATERNION/SET-ROTATION) :void
  (self :pointer)
  (axis :pointer)
  (_angle :pointer))

(export 'QUATERNION/SET-ROTATION)

(declaim (inline QUATERNION/SET-EULER))

(cffi:defcfun ("_wrap_btQuaternion_setEuler" QUATERNION/SET-EULER) :void
  (self :pointer)
  (yaw :pointer)
  (pitch :pointer)
  (roll :pointer))

(export 'QUATERNION/SET-EULER)

(declaim (inline QUATERNION/SET-EULER-ZYX))

(cffi:defcfun ("_wrap_btQuaternion_setEulerZYX" QUATERNION/SET-EULER-ZYX) :void
  (self :pointer)
  (yaw :pointer)
  (pitch :pointer)
  (roll :pointer))

(export 'QUATERNION/SET-EULER-ZYX)

(declaim (inline QUATERNION/INCREMENT))

(cffi:defcfun ("_wrap_btQuaternion_increment" QUATERNION/INCREMENT) :pointer
  (self :pointer)
  (q :pointer))

(export 'QUATERNION/INCREMENT)

(declaim (inline QUATERNION/DECREMENT))

(cffi:defcfun ("_wrap_btQuaternion_decrement" QUATERNION/DECREMENT) :pointer
  (self :pointer)
  (q :pointer))

(export 'QUATERNION/DECREMENT)

#+ (or)
(progn
  (declaim (inline QUATERNION/MULTIPLY-AND-ASSIGN))

  (cffi:defcfun ("_wrap_btQuaternion_multiplyAndAssign__SWIG_0" QUATERNION/MULTIPLY-AND-ASSIGN) :pointer
   (self :pointer)
   (s :pointer))

  (export 'QUATERNION/MULTIPLY-AND-ASSIGN)

  (declaim (inline QUATERNION/MULTIPLY-AND-ASSIGN))

  (cffi:defcfun ("_wrap_btQuaternion_multiplyAndAssign__SWIG_1" QUATERNION/MULTIPLY-AND-ASSIGN) :pointer
   (self :pointer)
   (q :pointer))

  (export 'QUATERNION/MULTIPLY-AND-ASSIGN)
 )
(declaim (inline QUATERNION/DOT))

(cffi:defcfun ("_wrap_btQuaternion_dot" QUATERNION/DOT) :float
  (self :pointer)
  (q :pointer))

(export 'QUATERNION/DOT)

(declaim (inline QUATERNION/LENGTH-2))

(cffi:defcfun ("_wrap_btQuaternion_length2" QUATERNION/LENGTH-2) :float
  (self :pointer))

(export 'QUATERNION/LENGTH-2)

(declaim (inline QUATERNION/LENGTH))

(cffi:defcfun ("_wrap_btQuaternion_length" QUATERNION/LENGTH) :float
  (self :pointer))

(export 'QUATERNION/LENGTH)

(declaim (inline QUATERNION/NORMALIZE))

(cffi:defcfun ("_wrap_btQuaternion_normalize" QUATERNION/NORMALIZE) :pointer
  (self :pointer))

(export 'QUATERNION/NORMALIZE)

(declaim (inline QUATERNION/MULTIPLY))

(cffi:defcfun ("_wrap_btQuaternion_multiply" QUATERNION/MULTIPLY) :pointer
  (self :pointer)
  (s :pointer))

(export 'QUATERNION/MULTIPLY)

(declaim (inline QUATERNION/DIVIDE))

(cffi:defcfun ("_wrap_btQuaternion_divide" QUATERNION/DIVIDE) :pointer
  (self :pointer)
  (s :pointer))

(export 'QUATERNION/DIVIDE)

(declaim (inline QUATERNION/DIVIDE-AND-ASSIGN))

(cffi:defcfun ("_wrap_btQuaternion_divideAndAssign" QUATERNION/DIVIDE-AND-ASSIGN) :pointer
  (self :pointer)
  (s :pointer))

(export 'QUATERNION/DIVIDE-AND-ASSIGN)

(declaim (inline QUATERNION/NORMALIZED))

(cffi:defcfun ("_wrap_btQuaternion_normalized" QUATERNION/NORMALIZED) :pointer
  (self :pointer))

(export 'QUATERNION/NORMALIZED)

(declaim (inline QUATERNION/ANGLE))

(cffi:defcfun ("_wrap_btQuaternion_angle" QUATERNION/ANGLE) :float
  (self :pointer)
  (q :pointer))

(export 'QUATERNION/ANGLE)

(declaim (inline QUATERNION/ANGLE-SHORTEST-PATH))

(cffi:defcfun ("_wrap_btQuaternion_angleShortestPath" QUATERNION/ANGLE-SHORTEST-PATH) :float
  (self :pointer)
  (q :pointer))

(export 'QUATERNION/ANGLE-SHORTEST-PATH)

(declaim (inline QUATERNION/GET-ANGLE))

(cffi:defcfun ("_wrap_btQuaternion_getAngle" QUATERNION/GET-ANGLE) :float
  (self :pointer))

(export 'QUATERNION/GET-ANGLE)

(declaim (inline QUATERNION/GET-ANGLE-SHORTEST-PATH))

(cffi:defcfun ("_wrap_btQuaternion_getAngleShortestPath" QUATERNION/GET-ANGLE-SHORTEST-PATH) :float
  (self :pointer))

(export 'QUATERNION/GET-ANGLE-SHORTEST-PATH)

(declaim (inline QUATERNION/GET-AXIS))

(cffi:defcfun ("_wrap_btQuaternion_getAxis" QUATERNION/GET-AXIS) :pointer
  (self :pointer))

(export 'QUATERNION/GET-AXIS)

(declaim (inline QUATERNION/INVERSE))

(cffi:defcfun ("_wrap_btQuaternion_inverse" QUATERNION/INVERSE) :pointer
  (self :pointer))

(export 'QUATERNION/INVERSE)

(declaim (inline QUATERNION/ADD))

(cffi:defcfun ("_wrap_btQuaternion_add" QUATERNION/ADD) :pointer
  (self :pointer)
  (q2 :pointer))

(export 'QUATERNION/ADD)

(declaim (inline QUATERNION/SUBTRACT))

(cffi:defcfun ("_wrap_btQuaternion_subtract" QUATERNION/SUBTRACT) :pointer
  (self :pointer)
  (q2 :pointer))

(export 'QUATERNION/SUBTRACT)

(declaim (inline QUATERNION///NEG//))

(cffi:defcfun ("_wrap_btQuaternion___neg__" QUATERNION///NEG//) :pointer
  (self :pointer))

(export 'QUATERNION///NEG//)

(declaim (inline QUATERNION/FARTHEST))

(cffi:defcfun ("_wrap_btQuaternion_farthest" QUATERNION/FARTHEST) :pointer
  (self :pointer)
  (qd :pointer))

(export 'QUATERNION/FARTHEST)

(declaim (inline QUATERNION/NEAREST))

(cffi:defcfun ("_wrap_btQuaternion_nearest" QUATERNION/NEAREST) :pointer
  (self :pointer)
  (qd :pointer))

(export 'QUATERNION/NEAREST)

(declaim (inline QUATERNION/SLERP))

(cffi:defcfun ("_wrap_btQuaternion_slerp" QUATERNION/SLERP) :pointer
  (self :pointer)
  (q :pointer)
  (t_arg2 :pointer))

(export 'QUATERNION/SLERP)

(declaim (inline QUATERNION/GET-IDENTITY))

(cffi:defcfun ("_wrap_btQuaternion_getIdentity" QUATERNION/GET-IDENTITY) :pointer)

(export 'QUATERNION/GET-IDENTITY)

(declaim (inline QUATERNION/GET-W))

(cffi:defcfun ("_wrap_btQuaternion_getW" QUATERNION/GET-W) :pointer
  (self :pointer))

(export 'QUATERNION/GET-W)

(declaim (inline DELETE/BT-QUATERNION))

(cffi:defcfun ("_wrap_delete_btQuaternion" DELETE/BT-QUATERNION) :void
  (self :pointer))

(export 'DELETE/BT-QUATERNION)

(declaim (inline dot))

(cffi:defcfun ("_wrap_dot" dot) :float
  (q1 :pointer)
  (q2 :pointer))

(export 'dot)

(declaim (inline qlength))

(cffi:defcfun ("_wrap_length" qlength) :float
  (q :pointer))

(export 'qlength)

(declaim (inline quaternion/angle))

(cffi:defcfun ("_wrap_btAngle__SWIG_1" quaternion/angle) :float
  (q1 :pointer)
  (q2 :pointer))

(export 'quaternion/angle)

(declaim (inline INVERSE))

(cffi:defcfun ("_wrap_inverse" INVERSE) :pointer
  (q :pointer))

(export 'INVERSE)

(declaim (inline SLERP))

(cffi:defcfun ("_wrap_slerp" SLERP) :pointer
  (q1 :pointer)
  (q2 :pointer)
  (t_arg2 :pointer))

(export 'SLERP)

(declaim (inline QUAT-ROTATE))

(cffi:defcfun ("_wrap_quatRotate" QUAT-ROTATE) :pointer
  (rotation :pointer)
  (v :pointer))

(export 'QUAT-ROTATE)

(declaim (inline SHORTEST-ARC-QUAT))

(cffi:defcfun ("_wrap_shortestArcQuat" SHORTEST-ARC-QUAT) :pointer
  (v0 :pointer)
  (v1 :pointer))

(export 'SHORTEST-ARC-QUAT)

(declaim (inline SHORTEST-ARC-QUAT-NORMALIZE-2))

(cffi:defcfun ("_wrap_shortestArcQuatNormalize2" SHORTEST-ARC-QUAT-NORMALIZE-2) :pointer
  (v0 :pointer)
  (v1 :pointer))

(export 'SHORTEST-ARC-QUAT-NORMALIZE-2)

(declaim (inline make-matrix-3x3/naked))

(cffi:defcfun ("_wrap_new_btMatrix3x3__SWIG_0" make-matrix-3x3/naked) :pointer)

(export 'make-matrix-3x3/naked)

(declaim (inline make-matrix-3x3/quaternion))

(cffi:defcfun ("_wrap_new_btMatrix3x3__SWIG_1" make-matrix-3x3/quaternion)
    :pointer
  (q :pointer))

(export 'make-matrix-3x3/quaternion)

(declaim (inline make-matrix-3x3/9))

(cffi:defcfun ("_wrap_new_btMatrix3x3__SWIG_2" make-matrix-3x3/9) :pointer
  (xx :pointer)
  (xy :pointer)
  (xz :pointer)
  (yx :pointer)
  (yy :pointer)
  (yz :pointer)
  (zx :pointer)
  (zy :pointer)
  (zz :pointer))

(export 'make-matrix-3x3/9)

(declaim (inline make-matrix-3x3/copy))

(cffi:defcfun ("_wrap_new_btMatrix3x3__SWIG_3" 
               make-matrix-3x3/copy) :pointer
  (other :pointer))

(export 'make-matrix-3x3/copy)

(declaim (inline matrix-3x3/assign-value))

(cffi:defcfun ("_wrap_btMatrix3x3_assignValue" matrix-3x3/assign-value) :pointer
  (self :pointer)
  (other :pointer))

(export 'matrix-3x3/assign-value)

(declaim (inline matrix-3x3/get-column))

(cffi:defcfun ("_wrap_btMatrix3x3_getColumn" matrix-3x3/get-column) :pointer
  (self :pointer)
  (i :int))

(export 'matrix-3x3/get-column)

(declaim (inline MATRIX-3X-3/GET-ROW))

(cffi:defcfun ("_wrap_btMatrix3x3_getRow" MATRIX-3X-3/GET-ROW) :pointer
  (self :pointer)
  (i :int))

(export 'MATRIX-3X-3/GET-ROW)

(declaim (inline matrix-3x3/aref))

(cffi:defcfun ("_wrap_btMatrix3x3___aref____SWIG_0" matrix-3x3/aref) :pointer
  (self :pointer)
  (i :int))

(export 'matrix-3x3/aref)

#+ (or)
(progn (declaim (inline matrix-3x3/aref))

 (cffi:defcfun ("_wrap_btMatrix3x3___aref____SWIG_1" matrix-3x3/aref) :pointer
   (self :pointer)
   (i :int))

 (export 'matrix-3x3/aref))

(declaim (inline MATRIX-3X-3/MULTIPLY-AND-ASSIGN))

(cffi:defcfun ("_wrap_btMatrix3x3_multiplyAndAssign" MATRIX-3X-3/MULTIPLY-AND-ASSIGN) :pointer
  (self :pointer)
  (m :pointer))

(export 'MATRIX-3X-3/MULTIPLY-AND-ASSIGN)

(declaim (inline MATRIX-3X-3/INCREMENT))

(cffi:defcfun ("_wrap_btMatrix3x3_increment" MATRIX-3X-3/INCREMENT) :pointer
  (self :pointer)
  (m :pointer))

(export 'MATRIX-3X-3/INCREMENT)

(declaim (inline MATRIX-3X-3/DECREMENT))

(cffi:defcfun ("_wrap_btMatrix3x3_decrement" MATRIX-3X-3/DECREMENT) :pointer
  (self :pointer)
  (m :pointer))

(export 'MATRIX-3X-3/DECREMENT)

(declaim (inline MATRIX-3X-3/SET-FROM-OPEN-GLSUB-MATRIX))

(cffi:defcfun ("_wrap_btMatrix3x3_setFromOpenGLSubMatrix" MATRIX-3X-3/SET-FROM-OPEN-GLSUB-MATRIX) :void
  (self :pointer)
  (m :pointer))

(export 'MATRIX-3X-3/SET-FROM-OPEN-GLSUB-MATRIX)

(declaim (inline MATRIX-3X-3/SET-VALUE))

(cffi:defcfun ("_wrap_btMatrix3x3_setValue" MATRIX-3X-3/SET-VALUE) :void
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

(export 'MATRIX-3X-3/SET-VALUE)

(declaim (inline MATRIX-3X-3/SET-ROTATION))

(cffi:defcfun ("_wrap_btMatrix3x3_setRotation" MATRIX-3X-3/SET-ROTATION) :void
  (self :pointer)
  (q :pointer))

(export 'MATRIX-3X-3/SET-ROTATION)

(declaim (inline MATRIX-3X-3/SET-EULER-YPR))

(cffi:defcfun ("_wrap_btMatrix3x3_setEulerYPR" MATRIX-3X-3/SET-EULER-YPR) :void
  (self :pointer)
  (yaw :pointer)
  (pitch :pointer)
  (roll :pointer))

(export 'MATRIX-3X-3/SET-EULER-YPR)

(declaim (inline MATRIX-3X-3/SET-EULER-ZYX))

(cffi:defcfun ("_wrap_btMatrix3x3_setEulerZYX" MATRIX-3X-3/SET-EULER-ZYX) :void
  (self :pointer)
  (eulerX :float)
  (eulerY :float)
  (eulerZ :float))

(export 'MATRIX-3X-3/SET-EULER-ZYX)

(declaim (inline MATRIX-3X-3/SET-IDENTITY))

(cffi:defcfun ("_wrap_btMatrix3x3_setIdentity" MATRIX-3X-3/SET-IDENTITY) :void
  (self :pointer))

(export 'MATRIX-3X-3/SET-IDENTITY)

(declaim (inline MATRIX-3X-3/GET-IDENTITY))

(cffi:defcfun ("_wrap_btMatrix3x3_getIdentity" MATRIX-3X-3/GET-IDENTITY) :pointer)

(export 'MATRIX-3X-3/GET-IDENTITY)

(declaim (inline MATRIX-3X-3/GET-OPEN-GLSUB-MATRIX))

(cffi:defcfun ("_wrap_btMatrix3x3_getOpenGLSubMatrix" MATRIX-3X-3/GET-OPEN-GLSUB-MATRIX) :void
  (self :pointer)
  (m :pointer))

(export 'MATRIX-3X-3/GET-OPEN-GLSUB-MATRIX)

(declaim (inline MATRIX-3X-3/GET-ROTATION))

(cffi:defcfun ("_wrap_btMatrix3x3_getRotation" MATRIX-3X-3/GET-ROTATION) :void
  (self :pointer)
  (q :pointer))

(export 'MATRIX-3X-3/GET-ROTATION)

(declaim (inline MATRIX-3X-3/GET-EULER-YPR))

(cffi:defcfun ("_wrap_btMatrix3x3_getEulerYPR" MATRIX-3X-3/GET-EULER-YPR) :void
  (self :pointer)
  (yaw :pointer)
  (pitch :pointer)
  (roll :pointer))

(export 'MATRIX-3X-3/GET-EULER-YPR)

(declaim (inline MATRIX-3X-3/GET-EULER-ZYX/WITH-SOLUTION#))

(cffi:defcfun ("_wrap_btMatrix3x3_getEulerZYX__SWIG_0" 
               MATRIX-3X-3/GET-EULER-ZYX/WITH-SOLUTION#) :void
  (self :pointer)
  (yaw :pointer)
  (pitch :pointer)
  (roll :pointer)
  (solution_number :unsigned-int))

(declaim (inline MATRIX-3X-3/GET-EULER-ZYX/WITHOUT-SOLUTION#))

(cffi:defcfun ("_wrap_btMatrix3x3_getEulerZYX__SWIG_1" 
               MATRIX-3X-3/GET-EULER-ZYX/WITHOUT-SOLUTION#) :void
  (self :pointer)
  (yaw :pointer)
  (pitch :pointer)
  (roll :pointer))

(declaim (inline MATRIX-3X-3/GET-EULER-ZYX))

(defun MATRIX-3X-3/GET-EULER-ZYX (self yaw pitch roll
                                  &optional solution#)
  (if solution#
      (MATRIX-3X-3/GET-EULER-ZYX/WITH-SOLUTION# self yaw pitch roll solution#)
      (MATRIX-3X-3/GET-EULER-ZYX/WITHOUT-SOLUTION# self yaw pitch roll)))

(export 'MATRIX-3X-3/GET-EULER-ZYX)

(declaim (inline MATRIX-3X-3/SCALED))

(cffi:defcfun ("_wrap_btMatrix3x3_scaled" MATRIX-3X-3/SCALED) :pointer
  (self :pointer)
  (s :pointer))

(export 'MATRIX-3X-3/SCALED)

(declaim (inline MATRIX-3X-3/DETERMINANT))

(cffi:defcfun ("_wrap_btMatrix3x3_determinant" MATRIX-3X-3/DETERMINANT) :float
  (self :pointer))

(export 'MATRIX-3X-3/DETERMINANT)

(declaim (inline MATRIX-3X-3/ADJOINT))

(cffi:defcfun ("_wrap_btMatrix3x3_adjoint" MATRIX-3X-3/ADJOINT) :pointer
  (self :pointer))

(export 'MATRIX-3X-3/ADJOINT)

(declaim (inline MATRIX-3X-3/ABSOLUTE))

(cffi:defcfun ("_wrap_btMatrix3x3_absolute" MATRIX-3X-3/ABSOLUTE) :pointer
  (self :pointer))

(export 'MATRIX-3X-3/ABSOLUTE)

(declaim (inline MATRIX-3X-3/TRANSPOSE))

(cffi:defcfun ("_wrap_btMatrix3x3_transpose" MATRIX-3X-3/TRANSPOSE) :pointer
  (self :pointer))

(export 'MATRIX-3X-3/TRANSPOSE)

(declaim (inline MATRIX-3X-3/INVERSE))

(cffi:defcfun ("_wrap_btMatrix3x3_inverse" MATRIX-3X-3/INVERSE) :pointer
  (self :pointer))

(export 'MATRIX-3X-3/INVERSE)

(declaim (inline MATRIX-3X-3/TRANSPOSE-TIMES))

(cffi:defcfun ("_wrap_btMatrix3x3_transposeTimes" MATRIX-3X-3/TRANSPOSE-TIMES) :pointer
  (self :pointer)
  (m :pointer))

(export 'MATRIX-3X-3/TRANSPOSE-TIMES)

(declaim (inline MATRIX-3X-3/TIMES-TRANSPOSE))

(cffi:defcfun ("_wrap_btMatrix3x3_timesTranspose" MATRIX-3X-3/TIMES-TRANSPOSE) :pointer
  (self :pointer)
  (m :pointer))

(export 'MATRIX-3X-3/TIMES-TRANSPOSE)

(declaim (inline MATRIX-3X-3/TDOTX))

(cffi:defcfun ("_wrap_btMatrix3x3_tdotx" MATRIX-3X-3/TDOTX) :float
  (self :pointer)
  (v :pointer))

(export 'MATRIX-3X-3/TDOTX)

(declaim (inline MATRIX-3X-3/TDOTY))

(cffi:defcfun ("_wrap_btMatrix3x3_tdoty" MATRIX-3X-3/TDOTY) :float
  (self :pointer)
  (v :pointer))

(export 'MATRIX-3X-3/TDOTY)

(declaim (inline MATRIX-3X-3/TDOTZ))

(cffi:defcfun ("_wrap_btMatrix3x3_tdotz" MATRIX-3X-3/TDOTZ) :float
  (self :pointer)
  (v :pointer))

(export 'MATRIX-3X-3/TDOTZ)

(declaim (inline MATRIX-3X-3/DIAGONALIZE))

(cffi:defcfun ("_wrap_btMatrix3x3_diagonalize" MATRIX-3X-3/DIAGONALIZE) :void
  (self :pointer)
  (rot :pointer)
  (threshold :float)
  (maxSteps :int))

(export 'MATRIX-3X-3/DIAGONALIZE)

(declaim (inline MATRIX-3X-3/COFAC))

(cffi:defcfun ("_wrap_btMatrix3x3_cofac" MATRIX-3X-3/COFAC) :float
  (self :pointer)
  (r1 :int)
  (c1 :int)
  (r2 :int)
  (c2 :int))

(export 'MATRIX-3X-3/COFAC)

(declaim (inline MATRIX-3X-3/SERIALIZE))

(cffi:defcfun ("_wrap_btMatrix3x3_serialize" MATRIX-3X-3/SERIALIZE) :void
  (self :pointer)
  (dataOut :pointer))

(export 'MATRIX-3X-3/SERIALIZE)

(declaim (inline MATRIX-3X-3/SERIALIZE-FLOAT))

(cffi:defcfun ("_wrap_btMatrix3x3_serializeFloat" MATRIX-3X-3/SERIALIZE-FLOAT) :void
  (self :pointer)
  (dataOut :pointer))

(export 'MATRIX-3X-3/SERIALIZE-FLOAT)

(declaim (inline MATRIX-3X-3/DE-SERIALIZE))

(cffi:defcfun ("_wrap_btMatrix3x3_deSerialize" MATRIX-3X-3/DE-SERIALIZE) :void
  (self :pointer)
  (dataIn :pointer))

(export 'MATRIX-3X-3/DE-SERIALIZE)

(declaim (inline MATRIX-3X-3/DE-SERIALIZE-FLOAT))

(cffi:defcfun ("_wrap_btMatrix3x3_deSerializeFloat" MATRIX-3X-3/DE-SERIALIZE-FLOAT) :void
  (self :pointer)
  (dataIn :pointer))

(export 'MATRIX-3X-3/DE-SERIALIZE-FLOAT)

(declaim (inline MATRIX-3X-3/DE-SERIALIZE-DOUBLE))

(cffi:defcfun ("_wrap_btMatrix3x3_deSerializeDouble" MATRIX-3X-3/DE-SERIALIZE-DOUBLE) :void
  (self :pointer)
  (dataIn :pointer))

(export 'MATRIX-3X-3/DE-SERIALIZE-DOUBLE)

(declaim (inline DELETE/BT-MATRIX-3X-3))

(cffi:defcfun ("_wrap_delete_btMatrix3x3" DELETE/BT-MATRIX-3X-3) :void
  (self :pointer))

(export 'DELETE/BT-MATRIX-3X-3)

(cffi:defcstruct matrix-3x3-float-data
                 (el :pointer))

(export 'matrix-3x3-float-data)

(export 'el)

(cffi:defcstruct MATRIX-3X-3-DOUBLE-DATA
                 (el :pointer))

(export 'MATRIX-3X-3-DOUBLE-DATA)

(export 'el)

(declaim (inline MAKE-TRANSFORM))

(cffi:defcfun ("_wrap_new_btTransform__SWIG_0" MAKE-TRANSFORM) :pointer)

(export 'MAKE-TRANSFORM)

(declaim (inline MAKE-TRANSFORM))

(cffi:defcfun ("_wrap_new_btTransform__SWIG_1" MAKE-TRANSFORM) :pointer
  (q :pointer)
  (c :pointer))

(export 'MAKE-TRANSFORM)

(declaim (inline MAKE-TRANSFORM))

(cffi:defcfun ("_wrap_new_btTransform__SWIG_2" MAKE-TRANSFORM) :pointer
  (q :pointer))

(export 'MAKE-TRANSFORM)

(declaim (inline MAKE-TRANSFORM))

(cffi:defcfun ("_wrap_new_btTransform__SWIG_3" MAKE-TRANSFORM) :pointer
  (b :pointer)
  (c :pointer))

(export 'MAKE-TRANSFORM)

(declaim (inline MAKE-TRANSFORM))

(cffi:defcfun ("_wrap_new_btTransform__SWIG_4" MAKE-TRANSFORM) :pointer
  (b :pointer))

(export 'MAKE-TRANSFORM)

(declaim (inline MAKE-TRANSFORM))

(cffi:defcfun ("_wrap_new_btTransform__SWIG_5" MAKE-TRANSFORM) :pointer
  (other :pointer))

(export 'MAKE-TRANSFORM)

(declaim (inline TRANSFORM/ASSIGN-VALUE))

(cffi:defcfun ("_wrap_btTransform_assignValue" TRANSFORM/ASSIGN-VALUE) :pointer
  (self :pointer)
  (other :pointer))

(export 'TRANSFORM/ASSIGN-VALUE)

(declaim (inline TRANSFORM/MULT))

(cffi:defcfun ("_wrap_btTransform_mult" TRANSFORM/MULT) :void
  (self :pointer)
  (t1 :pointer)
  (t2 :pointer))

(export 'TRANSFORM/MULT)

(declaim (inline TRANSFORM///FUNCALL//))

(cffi:defcfun ("_wrap_btTransform___funcall__" TRANSFORM///FUNCALL//) :pointer
  (self :pointer)
  (x :pointer))

(export 'TRANSFORM///FUNCALL//)

(declaim (inline TRANSFORM/MULTIPLY))

(cffi:defcfun ("_wrap_btTransform_multiply__SWIG_0" TRANSFORM/MULTIPLY) :pointer
  (self :pointer)
  (x :pointer))

(export 'TRANSFORM/MULTIPLY)

(declaim (inline TRANSFORM/MULTIPLY))

(cffi:defcfun ("_wrap_btTransform_multiply__SWIG_1" TRANSFORM/MULTIPLY) :pointer
  (self :pointer)
  (q :pointer))

(export 'TRANSFORM/MULTIPLY)

(declaim (inline TRANSFORM/GET-BASIS))

(cffi:defcfun ("_wrap_btTransform_getBasis__SWIG_0" TRANSFORM/GET-BASIS) :pointer
  (self :pointer))

(export 'TRANSFORM/GET-BASIS)

#+ (or)
(progn
  (declaim (inline TRANSFORM/GET-BASIS))

  (cffi:defcfun ("_wrap_btTransform_getBasis__SWIG_1" TRANSFORM/GET-BASIS) :pointer
    (self :pointer))

  (export 'TRANSFORM/GET-BASIS))

(declaim (inline TRANSFORM/GET-ORIGIN))

(cffi:defcfun ("_wrap_btTransform_getOrigin__SWIG_0" TRANSFORM/GET-ORIGIN) :pointer
  (self :pointer))

(export 'TRANSFORM/GET-ORIGIN)

#+ (or)
(progn
  (declaim (inline TRANSFORM/GET-ORIGIN))

  (cffi:defcfun ("_wrap_btTransform_getOrigin__SWIG_1" TRANSFORM/GET-ORIGIN) :pointer
   (self :pointer))

  (export 'TRANSFORM/GET-ORIGIN))

(declaim (inline TRANSFORM/GET-ROTATION))

(cffi:defcfun ("_wrap_btTransform_getRotation" TRANSFORM/GET-ROTATION) :pointer
  (self :pointer))

(export 'TRANSFORM/GET-ROTATION)

(declaim (inline TRANSFORM/SET-FROM-OPEN-GLMATRIX))

(cffi:defcfun ("_wrap_btTransform_setFromOpenGLMatrix" TRANSFORM/SET-FROM-OPEN-GLMATRIX) :void
  (self :pointer)
  (m :pointer))

(export 'TRANSFORM/SET-FROM-OPEN-GLMATRIX)

(declaim (inline TRANSFORM/GET-OPEN-GLMATRIX))

(cffi:defcfun ("_wrap_btTransform_getOpenGLMatrix" TRANSFORM/GET-OPEN-GLMATRIX) :void
  (self :pointer)
  (m :pointer))

(export 'TRANSFORM/GET-OPEN-GLMATRIX)

(declaim (inline TRANSFORM/SET-ORIGIN))

(cffi:defcfun ("_wrap_btTransform_setOrigin" TRANSFORM/SET-ORIGIN) :void
  (self :pointer)
  (origin :pointer))

(export 'TRANSFORM/SET-ORIGIN)

(declaim (inline TRANSFORM/INV-XFORM))

(cffi:defcfun ("_wrap_btTransform_invXform" TRANSFORM/INV-XFORM) :pointer
  (self :pointer)
  (inVec :pointer))

(export 'TRANSFORM/INV-XFORM)

(declaim (inline TRANSFORM/SET-BASIS))

(cffi:defcfun ("_wrap_btTransform_setBasis" TRANSFORM/SET-BASIS) :void
  (self :pointer)
  (basis :pointer))

(export 'TRANSFORM/SET-BASIS)

(declaim (inline TRANSFORM/SET-ROTATION))

(cffi:defcfun ("_wrap_btTransform_setRotation" TRANSFORM/SET-ROTATION) :void
  (self :pointer)
  (q :pointer))

(export 'TRANSFORM/SET-ROTATION)

(declaim (inline TRANSFORM/SET-IDENTITY))

(cffi:defcfun ("_wrap_btTransform_setIdentity" TRANSFORM/SET-IDENTITY) :void
  (self :pointer))

(export 'TRANSFORM/SET-IDENTITY)

(declaim (inline TRANSFORM/MULTIPLY-AND-ASSIGN))

(cffi:defcfun ("_wrap_btTransform_multiplyAndAssign" TRANSFORM/MULTIPLY-AND-ASSIGN) :pointer
  (self :pointer)
  (t_arg1 :pointer))

(export 'TRANSFORM/MULTIPLY-AND-ASSIGN)

(declaim (inline TRANSFORM/INVERSE))

(cffi:defcfun ("_wrap_btTransform_inverse" TRANSFORM/INVERSE) :pointer
  (self :pointer))

(export 'TRANSFORM/INVERSE)

(declaim (inline TRANSFORM/INVERSE-TIMES))

(cffi:defcfun ("_wrap_btTransform_inverseTimes" TRANSFORM/INVERSE-TIMES) :pointer
  (self :pointer)
  (t_arg1 :pointer))

(export 'TRANSFORM/INVERSE-TIMES)

#+ (or)
(progn
  (declaim (inline TRANSFORM/MULTIPLY))

  (cffi:defcfun ("_wrap_btTransform_multiply__SWIG_2" TRANSFORM/MULTIPLY) :pointer
   (self :pointer)
   (t_arg1 :pointer))

  (export 'TRANSFORM/MULTIPLY))

(declaim (inline TRANSFORM/GET-IDENTITY))

(cffi:defcfun ("_wrap_btTransform_getIdentity" TRANSFORM/GET-IDENTITY) :pointer)

(export 'TRANSFORM/GET-IDENTITY)

(declaim (inline TRANSFORM/SERIALIZE))

(cffi:defcfun ("_wrap_btTransform_serialize" TRANSFORM/SERIALIZE) :void
  (self :pointer)
  (dataOut :pointer))

(export 'TRANSFORM/SERIALIZE)

(declaim (inline TRANSFORM/SERIALIZE-FLOAT))

(cffi:defcfun ("_wrap_btTransform_serializeFloat" TRANSFORM/SERIALIZE-FLOAT) :void
  (self :pointer)
  (dataOut :pointer))

(export 'TRANSFORM/SERIALIZE-FLOAT)

(declaim (inline TRANSFORM/DE-SERIALIZE))

(cffi:defcfun ("_wrap_btTransform_deSerialize" TRANSFORM/DE-SERIALIZE) :void
  (self :pointer)
  (dataIn :pointer))

(export 'TRANSFORM/DE-SERIALIZE)

(declaim (inline TRANSFORM/DE-SERIALIZE-DOUBLE))

(cffi:defcfun ("_wrap_btTransform_deSerializeDouble" TRANSFORM/DE-SERIALIZE-DOUBLE) :void
  (self :pointer)
  (dataIn :pointer))

(export 'TRANSFORM/DE-SERIALIZE-DOUBLE)

(declaim (inline TRANSFORM/DE-SERIALIZE-FLOAT))

(cffi:defcfun ("_wrap_btTransform_deSerializeFloat" TRANSFORM/DE-SERIALIZE-FLOAT) :void
  (self :pointer)
  (dataIn :pointer))

(export 'TRANSFORM/DE-SERIALIZE-FLOAT)

(declaim (inline DELETE/BT-TRANSFORM))

(cffi:defcfun ("_wrap_delete_btTransform" DELETE/BT-TRANSFORM) :void
  (self :pointer))

(export 'DELETE/BT-TRANSFORM)

(cffi:defcstruct TRANSFORM-FLOAT-DATA
  (BASIS (:pointer (:struct matrix-3x3-float-data)))
  (ORIGIN (:pointer (:struct VECTOR-3-FLOAT-DATA))))

(export 'TRANSFORM-FLOAT-DATA)

(export 'BASIS)

(export 'ORIGIN)

(cffi:defcstruct TRANSFORM-DOUBLE-DATA
  (BASIS MATRIX-3X-3-DOUBLE-DATA)
  (ORIGIN VECTOR-3-DOUBLE-DATA))

(export 'TRANSFORM-DOUBLE-DATA)

(export 'BASIS)

(export 'ORIGIN)

(declaim (inline DELETE/BT-MOTION-STATE))

(cffi:defcfun ("_wrap_delete_btMotionState" DELETE/BT-MOTION-STATE) :void
  (self :pointer))

(export 'DELETE/BT-MOTION-STATE)

(declaim (inline MOTION-STATE/GET-WORLD-TRANSFORM))

(cffi:defcfun ("_wrap_btMotionState_getWorldTransform" MOTION-STATE/GET-WORLD-TRANSFORM) :void
  (self :pointer)
  (worldTrans :pointer))

(export 'MOTION-STATE/GET-WORLD-TRANSFORM)

(declaim (inline MOTION-STATE/SET-WORLD-TRANSFORM))

(cffi:defcfun ("_wrap_btMotionState_setWorldTransform" MOTION-STATE/SET-WORLD-TRANSFORM) :void
  (self :pointer)
  (worldTrans :pointer))

(export 'MOTION-STATE/SET-WORLD-TRANSFORM)

(define-constant +USE-PLACEMENT-NEW+ 1)

(export '+USE-PLACEMENT-NEW+)

(cffi:defcfun ("_wrap_new_btCollisionWorld" MAKE-COLLISION-WORLD) :pointer
  (dispatcher :pointer)
  (broadphasePairCache :pointer)
  (collisionConfiguration :pointer))

(export 'MAKE-COLLISION-WORLD)

(declaim (inline DELETE/BT-COLLISION-WORLD))

(cffi:defcfun ("_wrap_delete_btCollisionWorld" DELETE/BT-COLLISION-WORLD) :void
  (self :pointer))

(export 'DELETE/BT-COLLISION-WORLD)

(declaim (inline COLLISION-WORLD/SET-BROADPHASE))

(cffi:defcfun ("_wrap_btCollisionWorld_setBroadphase" COLLISION-WORLD/SET-BROADPHASE) :void
  (self :pointer)
  (pairCache :pointer))

(export 'COLLISION-WORLD/SET-BROADPHASE)

(declaim (inline COLLISION-WORLD/GET-BROADPHASE))

(cffi:defcfun ("_wrap_btCollisionWorld_getBroadphase__SWIG_0" COLLISION-WORLD/GET-BROADPHASE) :pointer
  (self :pointer))

(export 'COLLISION-WORLD/GET-BROADPHASE)

(declaim (inline COLLISION-WORLD/GET-BROADPHASE))

(cffi:defcfun ("_wrap_btCollisionWorld_getBroadphase__SWIG_1" COLLISION-WORLD/GET-BROADPHASE) :pointer
  (self :pointer))

(export 'COLLISION-WORLD/GET-BROADPHASE)

(declaim (inline COLLISION-WORLD/GET-PAIR-CACHE))

(cffi:defcfun ("_wrap_btCollisionWorld_getPairCache" COLLISION-WORLD/GET-PAIR-CACHE) :pointer
  (self :pointer))

(export 'COLLISION-WORLD/GET-PAIR-CACHE)

(declaim (inline COLLISION-WORLD/GET-DISPATCHER))

(cffi:defcfun ("_wrap_btCollisionWorld_getDispatcher__SWIG_0" COLLISION-WORLD/GET-DISPATCHER) :pointer
  (self :pointer))

(export 'COLLISION-WORLD/GET-DISPATCHER)

(declaim (inline COLLISION-WORLD/GET-DISPATCHER))

(cffi:defcfun ("_wrap_btCollisionWorld_getDispatcher__SWIG_1" COLLISION-WORLD/GET-DISPATCHER) :pointer
  (self :pointer))

(export 'COLLISION-WORLD/GET-DISPATCHER)

(declaim (inline COLLISION-WORLD/UPDATE-SINGLE-AABB))

(cffi:defcfun ("_wrap_btCollisionWorld_updateSingleAabb" COLLISION-WORLD/UPDATE-SINGLE-AABB) :void
  (self :pointer)
  (colObj :pointer))

(export 'COLLISION-WORLD/UPDATE-SINGLE-AABB)

(declaim (inline COLLISION-WORLD/UPDATE-AABBS))

(cffi:defcfun ("_wrap_btCollisionWorld_updateAabbs" COLLISION-WORLD/UPDATE-AABBS) :void
  (self :pointer))

(export 'COLLISION-WORLD/UPDATE-AABBS)

(declaim (inline COLLISION-WORLD/COMPUTE-OVERLAPPING-PAIRS))

(cffi:defcfun ("_wrap_btCollisionWorld_computeOverlappingPairs" COLLISION-WORLD/COMPUTE-OVERLAPPING-PAIRS) :void
  (self :pointer))

(export 'COLLISION-WORLD/COMPUTE-OVERLAPPING-PAIRS)

(declaim (inline COLLISION-WORLD/SET-DEBUG-DRAWER))

(cffi:defcfun ("_wrap_btCollisionWorld_setDebugDrawer" COLLISION-WORLD/SET-DEBUG-DRAWER) :void
  (self :pointer)
  (debugDrawer :pointer))

(export 'COLLISION-WORLD/SET-DEBUG-DRAWER)

(declaim (inline COLLISION-WORLD/GET-DEBUG-DRAWER))

(cffi:defcfun ("_wrap_btCollisionWorld_getDebugDrawer" COLLISION-WORLD/GET-DEBUG-DRAWER) :pointer
  (self :pointer))

(export 'COLLISION-WORLD/GET-DEBUG-DRAWER)

(declaim (inline COLLISION-WORLD/DEBUG-DRAW-WORLD))

(cffi:defcfun ("_wrap_btCollisionWorld_debugDrawWorld" COLLISION-WORLD/DEBUG-DRAW-WORLD) :void
  (self :pointer))

(export 'COLLISION-WORLD/DEBUG-DRAW-WORLD)

(declaim (inline COLLISION-WORLD/DEBUG-DRAW-OBJECT))

(cffi:defcfun ("_wrap_btCollisionWorld_debugDrawObject" COLLISION-WORLD/DEBUG-DRAW-OBJECT) :void
  (self :pointer)
  (worldTransform :pointer)
  (shape :pointer)
  (color :pointer))

(export 'COLLISION-WORLD/DEBUG-DRAW-OBJECT)

(declaim (inline COLLISION-WORLD/GET-NUM-COLLISION-OBJECTS))

(cffi:defcfun ("_wrap_btCollisionWorld_getNumCollisionObjects" COLLISION-WORLD/GET-NUM-COLLISION-OBJECTS) :int
  (self :pointer))

(export 'COLLISION-WORLD/GET-NUM-COLLISION-OBJECTS)

(declaim (inline COLLISION-WORLD/RAY-TEST))

(cffi:defcfun ("_wrap_btCollisionWorld_rayTest" COLLISION-WORLD/RAY-TEST) :void
  (self :pointer)
  (rayFromWorld :pointer)
  (rayToWorld :pointer)
  (resultCallback :pointer))

(export 'COLLISION-WORLD/RAY-TEST)

(declaim (inline COLLISION-WORLD/CONVEX-SWEEP-TEST))


#+i-am-emacs
(progn
  (defun eval-lispify ()
    (interactive)
    (execute-kbd-macro [?\C-s ?# ?. ?\( ?l ?i ?s ?p ?i ?f ?y ?\C-m ?\C-\M-b ?\C-\M-b ?\C-\M-  ?\C-w ?\C-? ?\C-? f8 ?\C-y ?\C-m ])
    (sleep-for .75)
    (execute-kbd-macro [?\C-\M-b ?\C-\M-b ?\C-\M-  ?\M-w ?\C-x ?o ?\C-y]))
  (defun eval-lispify-all ()
    (interactive)
    (dotimes (i 10000)
      (eval-lispify))))


(cffi:defcfun ("_wrap_btCollisionWorld_convexSweepTest__SWIG_0" COLLISION-WORLD/CONVEX-SWEEP-TEST) :void
  (self :pointer)
  (castShape :pointer)
  (from :pointer)
  (to :pointer)
  (resultCallback :pointer)
  (allowedCcdPenetration :float))

(export 'COLLISION-WORLD/CONVEX-SWEEP-TEST)

(declaim (inline COLLISION-WORLD/CONVEX-SWEEP-TEST))

(cffi:defcfun ("_wrap_btCollisionWorld_convexSweepTest__SWIG_1" COLLISION-WORLD/CONVEX-SWEEP-TEST) :void
  (self :pointer)
  (castShape :pointer)
  (from :pointer)
  (to :pointer)
  (resultCallback :pointer))

(export 'COLLISION-WORLD/CONVEX-SWEEP-TEST)

(declaim (inline COLLISION-WORLD/CONTACT-TEST))

(cffi:defcfun ("_wrap_btCollisionWorld_contactTest" COLLISION-WORLD/CONTACT-TEST) :void
  (self :pointer)
  (colObj :pointer)
  (resultCallback :pointer))

(export 'COLLISION-WORLD/CONTACT-TEST)

(declaim (inline COLLISION-WORLD/CONTACT-PAIR-TEST))

(cffi:defcfun ("_wrap_btCollisionWorld_contactPairTest" COLLISION-WORLD/CONTACT-PAIR-TEST) :void
  (self :pointer)
  (colObjA :pointer)
  (colObjB :pointer)
  (resultCallback :pointer))

(export 'COLLISION-WORLD/CONTACT-PAIR-TEST)

(declaim (inline COLLISION-WORLD/RAY-TEST-SINGLE))

(cffi:defcfun ("_wrap_btCollisionWorld_rayTestSingle" COLLISION-WORLD/RAY-TEST-SINGLE) :void
  (rayFromTrans :pointer)
  (rayToTrans :pointer)
  (collisionObject :pointer)
  (collisionShape :pointer)
  (colObjWorldTransform :pointer)
  (resultCallback :pointer))

(export 'COLLISION-WORLD/RAY-TEST-SINGLE)

(declaim (inline COLLISION-WORLD/RAY-TEST-SINGLE-INTERNAL))

(cffi:defcfun ("_wrap_btCollisionWorld_rayTestSingleInternal" COLLISION-WORLD/RAY-TEST-SINGLE-INTERNAL) :void
  (rayFromTrans :pointer)
  (rayToTrans :pointer)
  (collisionObjectWrap :pointer)
  (resultCallback :pointer))

(export 'COLLISION-WORLD/RAY-TEST-SINGLE-INTERNAL)

(declaim (inline COLLISION-WORLD/OBJECT-QUERY-SINGLE))

(cffi:defcfun ("_wrap_btCollisionWorld_objectQuerySingle" COLLISION-WORLD/OBJECT-QUERY-SINGLE) :void
  (castShape :pointer)
  (rayFromTrans :pointer)
  (rayToTrans :pointer)
  (collisionObject :pointer)
  (collisionShape :pointer)
  (colObjWorldTransform :pointer)
  (resultCallback :pointer)
  (allowedPenetration :float))

(export 'COLLISION-WORLD/OBJECT-QUERY-SINGLE)

(declaim (inline COLLISION-WORLD/OBJECT-QUERY-SINGLE-INTERNAL))

(cffi:defcfun ("_wrap_btCollisionWorld_objectQuerySingleInternal" COLLISION-WORLD/OBJECT-QUERY-SINGLE-INTERNAL) :void
  (castShape :pointer)
  (convexFromTrans :pointer)
  (convexToTrans :pointer)
  (colObjWrap :pointer)
  (resultCallback :pointer)
  (allowedPenetration :float))

(export 'COLLISION-WORLD/OBJECT-QUERY-SINGLE-INTERNAL)

(declaim (inline COLLISION-WORLD/ADD-COLLISION-OBJECT))

(cffi:defcfun ("_wrap_btCollisionWorld_addCollisionObject__SWIG_0" COLLISION-WORLD/ADD-COLLISION-OBJECT) :void
  (self :pointer)
  (collisionObject :pointer)
  (collisionFilterGroup :short)
  (collisionFilterMask :short))

(export 'COLLISION-WORLD/ADD-COLLISION-OBJECT)

(declaim (inline COLLISION-WORLD/ADD-COLLISION-OBJECT))

(cffi:defcfun ("_wrap_btCollisionWorld_addCollisionObject__SWIG_1" COLLISION-WORLD/ADD-COLLISION-OBJECT) :void
  (self :pointer)
  (collisionObject :pointer)
  (collisionFilterGroup :short))

(export 'COLLISION-WORLD/ADD-COLLISION-OBJECT)

(declaim (inline COLLISION-WORLD/ADD-COLLISION-OBJECT))

(cffi:defcfun ("_wrap_btCollisionWorld_addCollisionObject__SWIG_2" COLLISION-WORLD/ADD-COLLISION-OBJECT) :void
  (self :pointer)
  (collisionObject :pointer))

(export 'COLLISION-WORLD/ADD-COLLISION-OBJECT)

(declaim (inline COLLISION-WORLD/GET-COLLISION-OBJECT-ARRAY))

(cffi:defcfun ("_wrap_btCollisionWorld_getCollisionObjectArray__SWIG_0" COLLISION-WORLD/GET-COLLISION-OBJECT-ARRAY) :pointer
  (self :pointer))

(export 'COLLISION-WORLD/GET-COLLISION-OBJECT-ARRAY)

(declaim (inline COLLISION-WORLD/GET-COLLISION-OBJECT-ARRAY))

(cffi:defcfun ("_wrap_btCollisionWorld_getCollisionObjectArray__SWIG_1" COLLISION-WORLD/GET-COLLISION-OBJECT-ARRAY) :pointer
  (self :pointer))

(export 'COLLISION-WORLD/GET-COLLISION-OBJECT-ARRAY)

(declaim (inline COLLISION-WORLD/REMOVE-COLLISION-OBJECT))

(cffi:defcfun ("_wrap_btCollisionWorld_removeCollisionObject" COLLISION-WORLD/REMOVE-COLLISION-OBJECT) :void
  (self :pointer)
  (collisionObject :pointer))

(export 'COLLISION-WORLD/REMOVE-COLLISION-OBJECT)

(declaim (inline COLLISION-WORLD/PERFORM-DISCRETE-COLLISION-DETECTION))

(cffi:defcfun ("_wrap_btCollisionWorld_performDiscreteCollisionDetection" COLLISION-WORLD/PERFORM-DISCRETE-COLLISION-DETECTION) :void
  (self :pointer))

(export 'COLLISION-WORLD/PERFORM-DISCRETE-COLLISION-DETECTION)

(declaim (inline COLLISION-WORLD/GET-DISPATCH-INFO))

(cffi:defcfun ("_wrap_btCollisionWorld_getDispatchInfo__SWIG_0" COLLISION-WORLD/GET-DISPATCH-INFO) :pointer
  (self :pointer))

(export 'COLLISION-WORLD/GET-DISPATCH-INFO)

(declaim (inline COLLISION-WORLD/GET-DISPATCH-INFO))

(cffi:defcfun ("_wrap_btCollisionWorld_getDispatchInfo__SWIG_1" COLLISION-WORLD/GET-DISPATCH-INFO) :pointer
  (self :pointer))

(export 'COLLISION-WORLD/GET-DISPATCH-INFO)

(declaim (inline COLLISION-WORLD/GET-FORCE-UPDATE-ALL-AABBS))

(cffi:defcfun ("_wrap_btCollisionWorld_getForceUpdateAllAabbs" COLLISION-WORLD/GET-FORCE-UPDATE-ALL-AABBS) :pointer
  (self :pointer))

(export 'COLLISION-WORLD/GET-FORCE-UPDATE-ALL-AABBS)

(declaim (inline COLLISION-WORLD/SET-FORCE-UPDATE-ALL-AABBS))

(cffi:defcfun ("_wrap_btCollisionWorld_setForceUpdateAllAabbs" COLLISION-WORLD/SET-FORCE-UPDATE-ALL-AABBS) :void
  (self :pointer)
  (forceUpdateAllAabbs :pointer))

(export 'COLLISION-WORLD/SET-FORCE-UPDATE-ALL-AABBS)

(declaim (inline COLLISION-WORLD/SERIALIZE))

(cffi:defcfun ("_wrap_btCollisionWorld_serialize" COLLISION-WORLD/SERIALIZE) :void
  (self :pointer)
  (serializer :pointer))

(export 'COLLISION-WORLD/SERIALIZE)

(define-constant +ACTIVE-TAG+ 1)

(export '+ACTIVE-TAG+)

(define-constant +ISLAND-SLEEPING+ 2)

(export '+ISLAND-SLEEPING+)

(define-constant +WANTS-DEACTIVATION+ 3)

(export '+WANTS-DEACTIVATION+)

(define-constant +DISABLE-DEACTIVATION+ 4)

(export '+DISABLE-DEACTIVATION+)

(define-constant +DISABLE-SIMULATION+ 5)

(export '+DISABLE-SIMULATION+)

(define-constant +COLLISION-OBJECT-DATA-NAME+ "btCollisionObjectFloatData"  :test 'equal)

(export '+COLLISION-OBJECT-DATA-NAME+)

(declaim (inline COLLISION-OBJECT/MAKE-CPLUS-PLUS-INSTANCE))

(cffi:defcfun ("_wrap_btCollisionObject_makeCPlusPlusInstance__SWIG_0" COLLISION-OBJECT/MAKE-CPLUS-PLUS-INSTANCE) :pointer
  (self :pointer)
  (sizeInBytes :pointer))

(export 'COLLISION-OBJECT/MAKE-CPLUS-PLUS-INSTANCE)

(declaim (inline COLLISION-OBJECT/DELETE-CPLUS-PLUS-INSTANCE))

(cffi:defcfun ("_wrap_btCollisionObject_deleteCPlusPlusInstance__SWIG_0" COLLISION-OBJECT/DELETE-CPLUS-PLUS-INSTANCE) :void
  (self :pointer)
  (ptr :pointer))

(export 'COLLISION-OBJECT/DELETE-CPLUS-PLUS-INSTANCE)

(declaim (inline COLLISION-OBJECT/MAKE-CPLUS-PLUS-INSTANCE))

(cffi:defcfun ("_wrap_btCollisionObject_makeCPlusPlusInstance__SWIG_1" COLLISION-OBJECT/MAKE-CPLUS-PLUS-INSTANCE) :pointer
  (self :pointer)
  (arg1 :pointer)
  (ptr :pointer))

(export 'COLLISION-OBJECT/MAKE-CPLUS-PLUS-INSTANCE)

(declaim (inline COLLISION-OBJECT/DELETE-CPLUS-PLUS-INSTANCE))

(cffi:defcfun ("_wrap_btCollisionObject_deleteCPlusPlusInstance__SWIG_1" COLLISION-OBJECT/DELETE-CPLUS-PLUS-INSTANCE) :void
  (self :pointer)
  (arg1 :pointer)
  (arg2 :pointer))

(export 'COLLISION-OBJECT/DELETE-CPLUS-PLUS-INSTANCE)

(declaim (inline COLLISION-OBJECT/MAKE-CPLUS-ARRAY))

(cffi:defcfun ("_wrap_btCollisionObject_makeCPlusArray__SWIG_0" COLLISION-OBJECT/MAKE-CPLUS-ARRAY) :pointer
  (self :pointer)
  (sizeInBytes :pointer))

(export 'COLLISION-OBJECT/MAKE-CPLUS-ARRAY)

(declaim (inline COLLISION-OBJECT/DELETE-CPLUS-ARRAY))

(cffi:defcfun ("_wrap_btCollisionObject_deleteCPlusArray__SWIG_0" COLLISION-OBJECT/DELETE-CPLUS-ARRAY) :void
  (self :pointer)
  (ptr :pointer))

(export 'COLLISION-OBJECT/DELETE-CPLUS-ARRAY)

(declaim (inline COLLISION-OBJECT/MAKE-CPLUS-ARRAY))

(cffi:defcfun ("_wrap_btCollisionObject_makeCPlusArray__SWIG_1" COLLISION-OBJECT/MAKE-CPLUS-ARRAY) :pointer
  (self :pointer)
  (arg1 :pointer)
  (ptr :pointer))

(export 'COLLISION-OBJECT/MAKE-CPLUS-ARRAY)

(declaim (inline COLLISION-OBJECT/DELETE-CPLUS-ARRAY))

(cffi:defcfun ("_wrap_btCollisionObject_deleteCPlusArray__SWIG_1" COLLISION-OBJECT/DELETE-CPLUS-ARRAY) :void
  (self :pointer)
  (arg1 :pointer)
  (arg2 :pointer))

(export 'COLLISION-OBJECT/DELETE-CPLUS-ARRAY)

(cffi:defcenum COLLISION-FLAGS
  (:CF-STATIC-OBJECT #.1)
  (:CF-KINEMATIC-OBJECT #.2)
  (:CF-NO-CONTACT-RESPONSE #.4)
  (:CF-CUSTOM-MATERIAL-CALLBACK #.8)
  (:CF-CHARACTER-OBJECT #.16)
  (:CF-DISABLE-VISUALIZE-OBJECT #.32)
  (:CF-DISABLE-SPU-COLLISION-PROCESSING #.64))

(export 'COLLISION-FLAGS)

(cffi:defcenum COLLISION-OBJECT-TYPES
  (:CO-COLLISION-OBJECT #.1)
  (:CO-RIGID-BODY #.2)
  (:CO-GHOST-OBJECT #.4)
  (:CO-SOFT-BODY #.8)
  (:CO-HF-FLUID #.16)
  (:CO-USER-TYPE #.32)
  (:CO-FEATHERSTONE-LINK #.64))

(export 'COLLISION-OBJECT-TYPES)

(cffi:defcenum ANISOTROPIC-FRICTION-FLAGS
  (:CF-ANISOTROPIC-FRICTION-DISABLED #.0)
  (:CF-ANISOTROPIC-FRICTION #.1)
  (:CF-ANISOTROPIC-ROLLING-FRICTION #.2))

(export 'ANISOTROPIC-FRICTION-FLAGS)

(declaim (inline COLLISION-OBJECT/MERGES-SIMULATION-ISLANDS))

(cffi:defcfun ("_wrap_btCollisionObject_mergesSimulationIslands" COLLISION-OBJECT/MERGES-SIMULATION-ISLANDS) :pointer
  (self :pointer))

(export 'COLLISION-OBJECT/MERGES-SIMULATION-ISLANDS)

(declaim (inline COLLISION-OBJECT/GET-ANISOTROPIC-FRICTION))

(cffi:defcfun ("_wrap_btCollisionObject_getAnisotropicFriction" COLLISION-OBJECT/GET-ANISOTROPIC-FRICTION) :pointer
  (self :pointer))

(export 'COLLISION-OBJECT/GET-ANISOTROPIC-FRICTION)

(declaim (inline COLLISION-OBJECT/SET-ANISOTROPIC-FRICTION))

(cffi:defcfun ("_wrap_btCollisionObject_setAnisotropicFriction__SWIG_0" COLLISION-OBJECT/SET-ANISOTROPIC-FRICTION) :void
  (self :pointer)
  (anisotropicFriction :pointer)
  (frictionMode :int))

(export 'COLLISION-OBJECT/SET-ANISOTROPIC-FRICTION)

(declaim (inline COLLISION-OBJECT/SET-ANISOTROPIC-FRICTION))

(cffi:defcfun ("_wrap_btCollisionObject_setAnisotropicFriction__SWIG_1" COLLISION-OBJECT/SET-ANISOTROPIC-FRICTION) :void
  (self :pointer)
  (anisotropicFriction :pointer))

(export 'COLLISION-OBJECT/SET-ANISOTROPIC-FRICTION)

(declaim (inline COLLISION-OBJECT/HAS-ANISOTROPIC-FRICTION))

(cffi:defcfun ("_wrap_btCollisionObject_hasAnisotropicFriction__SWIG_0" COLLISION-OBJECT/HAS-ANISOTROPIC-FRICTION) :pointer
  (self :pointer)
  (frictionMode :int))

(export 'COLLISION-OBJECT/HAS-ANISOTROPIC-FRICTION)

(declaim (inline COLLISION-OBJECT/HAS-ANISOTROPIC-FRICTION))

(cffi:defcfun ("_wrap_btCollisionObject_hasAnisotropicFriction__SWIG_1" COLLISION-OBJECT/HAS-ANISOTROPIC-FRICTION) :pointer
  (self :pointer))

(export 'COLLISION-OBJECT/HAS-ANISOTROPIC-FRICTION)

(declaim (inline COLLISION-OBJECT/SET-CONTACT-PROCESSING-THRESHOLD))

(cffi:defcfun ("_wrap_btCollisionObject_setContactProcessingThreshold" COLLISION-OBJECT/SET-CONTACT-PROCESSING-THRESHOLD) :void
  (self :pointer)
  (contactProcessingThreshold :float))

(export 'COLLISION-OBJECT/SET-CONTACT-PROCESSING-THRESHOLD)

(declaim (inline COLLISION-OBJECT/GET-CONTACT-PROCESSING-THRESHOLD))

(cffi:defcfun ("_wrap_btCollisionObject_getContactProcessingThreshold" COLLISION-OBJECT/GET-CONTACT-PROCESSING-THRESHOLD) :float
  (self :pointer))

(export 'COLLISION-OBJECT/GET-CONTACT-PROCESSING-THRESHOLD)

(declaim (inline COLLISION-OBJECT/IS-STATIC-OBJECT))

(cffi:defcfun ("_wrap_btCollisionObject_isStaticObject" COLLISION-OBJECT/IS-STATIC-OBJECT) :pointer
  (self :pointer))

(export 'COLLISION-OBJECT/IS-STATIC-OBJECT)

(declaim (inline COLLISION-OBJECT/IS-KINEMATIC-OBJECT))

(cffi:defcfun ("_wrap_btCollisionObject_isKinematicObject" COLLISION-OBJECT/IS-KINEMATIC-OBJECT) :pointer
  (self :pointer))

(export 'COLLISION-OBJECT/IS-KINEMATIC-OBJECT)

(declaim (inline COLLISION-OBJECT/IS-STATIC-OR-KINEMATIC-OBJECT))

(cffi:defcfun ("_wrap_btCollisionObject_isStaticOrKinematicObject" COLLISION-OBJECT/IS-STATIC-OR-KINEMATIC-OBJECT) :pointer
  (self :pointer))

(export 'COLLISION-OBJECT/IS-STATIC-OR-KINEMATIC-OBJECT)

(declaim (inline COLLISION-OBJECT/HAS-CONTACT-RESPONSE))

(cffi:defcfun ("_wrap_btCollisionObject_hasContactResponse" COLLISION-OBJECT/HAS-CONTACT-RESPONSE) :pointer
  (self :pointer))

(export 'COLLISION-OBJECT/HAS-CONTACT-RESPONSE)

(declaim (inline MAKE-COLLISION-OBJECT))

(cffi:defcfun ("_wrap_new_btCollisionObject" MAKE-COLLISION-OBJECT) :pointer)

(export 'MAKE-COLLISION-OBJECT)

(declaim (inline DELETE/BT-COLLISION-OBJECT))

(cffi:defcfun ("_wrap_delete_btCollisionObject" DELETE/BT-COLLISION-OBJECT) :void
  (self :pointer))

(export 'DELETE/BT-COLLISION-OBJECT)

(declaim (inline COLLISION-OBJECT/SET-COLLISION-SHAPE))

(cffi:defcfun ("_wrap_btCollisionObject_setCollisionShape" COLLISION-OBJECT/SET-COLLISION-SHAPE) :void
  (self :pointer)
  (collisionShape :pointer))

(export 'COLLISION-OBJECT/SET-COLLISION-SHAPE)

(declaim (inline COLLISION-OBJECT/GET-COLLISION-SHAPE))

(cffi:defcfun ("_wrap_btCollisionObject_getCollisionShape__SWIG_0" COLLISION-OBJECT/GET-COLLISION-SHAPE) :pointer
  (self :pointer))

(export 'COLLISION-OBJECT/GET-COLLISION-SHAPE)

(declaim (inline COLLISION-OBJECT/GET-COLLISION-SHAPE))

(cffi:defcfun ("_wrap_btCollisionObject_getCollisionShape__SWIG_1" COLLISION-OBJECT/GET-COLLISION-SHAPE) :pointer
  (self :pointer))

(export 'COLLISION-OBJECT/GET-COLLISION-SHAPE)

(declaim (inline COLLISION-OBJECT/INTERNAL-GET-EXTENSION-POINTER))

(cffi:defcfun ("_wrap_btCollisionObject_internalGetExtensionPointer" COLLISION-OBJECT/INTERNAL-GET-EXTENSION-POINTER) :pointer
  (self :pointer))

(export 'COLLISION-OBJECT/INTERNAL-GET-EXTENSION-POINTER)

(declaim (inline COLLISION-OBJECT/INTERNAL-SET-EXTENSION-POINTER))

(cffi:defcfun ("_wrap_btCollisionObject_internalSetExtensionPointer" COLLISION-OBJECT/INTERNAL-SET-EXTENSION-POINTER) :void
  (self :pointer)
  (pointer :pointer))

(export 'COLLISION-OBJECT/INTERNAL-SET-EXTENSION-POINTER)

(declaim (inline COLLISION-OBJECT/GET-ACTIVATION-STATE))

(cffi:defcfun ("_wrap_btCollisionObject_getActivationState" COLLISION-OBJECT/GET-ACTIVATION-STATE) :int
  (self :pointer))

(export 'COLLISION-OBJECT/GET-ACTIVATION-STATE)

(declaim (inline COLLISION-OBJECT/SET-ACTIVATION-STATE))

(cffi:defcfun ("_wrap_btCollisionObject_setActivationState" COLLISION-OBJECT/SET-ACTIVATION-STATE) :void
  (self :pointer)
  (newState :int))

(export 'COLLISION-OBJECT/SET-ACTIVATION-STATE)

(declaim (inline COLLISION-OBJECT/SET-DEACTIVATION-TIME))

(cffi:defcfun ("_wrap_btCollisionObject_setDeactivationTime" COLLISION-OBJECT/SET-DEACTIVATION-TIME) :void
  (self :pointer)
  (time :float))

(export 'COLLISION-OBJECT/SET-DEACTIVATION-TIME)

(declaim (inline COLLISION-OBJECT/GET-DEACTIVATION-TIME))

(cffi:defcfun ("_wrap_btCollisionObject_getDeactivationTime" COLLISION-OBJECT/GET-DEACTIVATION-TIME) :float
  (self :pointer))

(export 'COLLISION-OBJECT/GET-DEACTIVATION-TIME)

(declaim (inline COLLISION-OBJECT/FORCE-ACTIVATION-STATE))

(cffi:defcfun ("_wrap_btCollisionObject_forceActivationState" COLLISION-OBJECT/FORCE-ACTIVATION-STATE) :void
  (self :pointer)
  (newState :int))

(export 'COLLISION-OBJECT/FORCE-ACTIVATION-STATE)

(declaim (inline COLLISION-OBJECT/ACTIVATE))

(cffi:defcfun ("_wrap_btCollisionObject_activate__SWIG_0" COLLISION-OBJECT/ACTIVATE) :void
  (self :pointer)
  (forceActivation :pointer))

(export 'COLLISION-OBJECT/ACTIVATE)

(declaim (inline COLLISION-OBJECT/ACTIVATE))

(cffi:defcfun ("_wrap_btCollisionObject_activate__SWIG_1" COLLISION-OBJECT/ACTIVATE) :void
  (self :pointer))

(export 'COLLISION-OBJECT/ACTIVATE)

(declaim (inline COLLISION-OBJECT/IS-ACTIVE))

(cffi:defcfun ("_wrap_btCollisionObject_isActive" COLLISION-OBJECT/IS-ACTIVE) :pointer
  (self :pointer))

(export 'COLLISION-OBJECT/IS-ACTIVE)

(declaim (inline COLLISION-OBJECT/SET-RESTITUTION))

(cffi:defcfun ("_wrap_btCollisionObject_setRestitution" COLLISION-OBJECT/SET-RESTITUTION) :void
  (self :pointer)
  (rest :float))

(export 'COLLISION-OBJECT/SET-RESTITUTION)

(declaim (inline COLLISION-OBJECT/GET-RESTITUTION))

(cffi:defcfun ("_wrap_btCollisionObject_getRestitution" COLLISION-OBJECT/GET-RESTITUTION) :float
  (self :pointer))

(export 'COLLISION-OBJECT/GET-RESTITUTION)

(declaim (inline COLLISION-OBJECT/SET-FRICTION))

(cffi:defcfun ("_wrap_btCollisionObject_setFriction" COLLISION-OBJECT/SET-FRICTION) :void
  (self :pointer)
  (frict :float))

(export 'COLLISION-OBJECT/SET-FRICTION)

(declaim (inline COLLISION-OBJECT/GET-FRICTION))

(cffi:defcfun ("_wrap_btCollisionObject_getFriction" COLLISION-OBJECT/GET-FRICTION) :float
  (self :pointer))

(export 'COLLISION-OBJECT/GET-FRICTION)

(declaim (inline COLLISION-OBJECT/SET-ROLLING-FRICTION))

(cffi:defcfun ("_wrap_btCollisionObject_setRollingFriction" COLLISION-OBJECT/SET-ROLLING-FRICTION) :void
  (self :pointer)
  (frict :float))

(export 'COLLISION-OBJECT/SET-ROLLING-FRICTION)

(declaim (inline COLLISION-OBJECT/GET-ROLLING-FRICTION))

(cffi:defcfun ("_wrap_btCollisionObject_getRollingFriction" COLLISION-OBJECT/GET-ROLLING-FRICTION) :float
  (self :pointer))

(export 'COLLISION-OBJECT/GET-ROLLING-FRICTION)

(declaim (inline COLLISION-OBJECT/GET-INTERNAL-TYPE))

(cffi:defcfun ("_wrap_btCollisionObject_getInternalType" COLLISION-OBJECT/GET-INTERNAL-TYPE) :int
  (self :pointer))

(export 'COLLISION-OBJECT/GET-INTERNAL-TYPE)

(declaim (inline COLLISION-OBJECT/GET-WORLD-TRANSFORM))

(cffi:defcfun ("_wrap_btCollisionObject_getWorldTransform__SWIG_0" COLLISION-OBJECT/GET-WORLD-TRANSFORM) :pointer
  (self :pointer))

(export 'COLLISION-OBJECT/GET-WORLD-TRANSFORM)

(declaim (inline COLLISION-OBJECT/GET-WORLD-TRANSFORM))

(cffi:defcfun ("_wrap_btCollisionObject_getWorldTransform__SWIG_1" COLLISION-OBJECT/GET-WORLD-TRANSFORM) :pointer
  (self :pointer))

(export 'COLLISION-OBJECT/GET-WORLD-TRANSFORM)

(declaim (inline COLLISION-OBJECT/SET-WORLD-TRANSFORM))

(cffi:defcfun ("_wrap_btCollisionObject_setWorldTransform" COLLISION-OBJECT/SET-WORLD-TRANSFORM) :void
  (self :pointer)
  (worldTrans :pointer))

(export 'COLLISION-OBJECT/SET-WORLD-TRANSFORM)

(declaim (inline COLLISION-OBJECT/GET-BROADPHASE-HANDLE))

(cffi:defcfun ("_wrap_btCollisionObject_getBroadphaseHandle__SWIG_0" COLLISION-OBJECT/GET-BROADPHASE-HANDLE) :pointer
  (self :pointer))

(export 'COLLISION-OBJECT/GET-BROADPHASE-HANDLE)

(declaim (inline COLLISION-OBJECT/GET-BROADPHASE-HANDLE))

(cffi:defcfun ("_wrap_btCollisionObject_getBroadphaseHandle__SWIG_1" COLLISION-OBJECT/GET-BROADPHASE-HANDLE) :pointer
  (self :pointer))

(export 'COLLISION-OBJECT/GET-BROADPHASE-HANDLE)

(declaim (inline COLLISION-OBJECT/SET-BROADPHASE-HANDLE))

(cffi:defcfun ("_wrap_btCollisionObject_setBroadphaseHandle" COLLISION-OBJECT/SET-BROADPHASE-HANDLE) :void
  (self :pointer)
  (handle :pointer))

(export 'COLLISION-OBJECT/SET-BROADPHASE-HANDLE)

(declaim (inline COLLISION-OBJECT/GET-INTERPOLATION-WORLD-TRANSFORM))

(cffi:defcfun ("_wrap_btCollisionObject_getInterpolationWorldTransform__SWIG_0" COLLISION-OBJECT/GET-INTERPOLATION-WORLD-TRANSFORM) :pointer
  (self :pointer))

(export 'COLLISION-OBJECT/GET-INTERPOLATION-WORLD-TRANSFORM)

(declaim (inline COLLISION-OBJECT/GET-INTERPOLATION-WORLD-TRANSFORM))

(cffi:defcfun ("_wrap_btCollisionObject_getInterpolationWorldTransform__SWIG_1" COLLISION-OBJECT/GET-INTERPOLATION-WORLD-TRANSFORM) :pointer
  (self :pointer))

(export 'COLLISION-OBJECT/GET-INTERPOLATION-WORLD-TRANSFORM)

(declaim (inline COLLISION-OBJECT/SET-INTERPOLATION-WORLD-TRANSFORM))

(cffi:defcfun ("_wrap_btCollisionObject_setInterpolationWorldTransform" COLLISION-OBJECT/SET-INTERPOLATION-WORLD-TRANSFORM) :void
  (self :pointer)
  (trans :pointer))

(export 'COLLISION-OBJECT/SET-INTERPOLATION-WORLD-TRANSFORM)

(declaim (inline COLLISION-OBJECT/SET-INTERPOLATION-LINEAR-VELOCITY))

(cffi:defcfun ("_wrap_btCollisionObject_setInterpolationLinearVelocity" COLLISION-OBJECT/SET-INTERPOLATION-LINEAR-VELOCITY) :void
  (self :pointer)
  (linvel :pointer))

(export 'COLLISION-OBJECT/SET-INTERPOLATION-LINEAR-VELOCITY)

(declaim (inline COLLISION-OBJECT/SET-INTERPOLATION-ANGULAR-VELOCITY))

(cffi:defcfun ("_wrap_btCollisionObject_setInterpolationAngularVelocity" COLLISION-OBJECT/SET-INTERPOLATION-ANGULAR-VELOCITY) :void
  (self :pointer)
  (angvel :pointer))

(export 'COLLISION-OBJECT/SET-INTERPOLATION-ANGULAR-VELOCITY)

(declaim (inline COLLISION-OBJECT/GET-INTERPOLATION-LINEAR-VELOCITY))

(cffi:defcfun ("_wrap_btCollisionObject_getInterpolationLinearVelocity" COLLISION-OBJECT/GET-INTERPOLATION-LINEAR-VELOCITY) :pointer
  (self :pointer))

(export 'COLLISION-OBJECT/GET-INTERPOLATION-LINEAR-VELOCITY)

(declaim (inline COLLISION-OBJECT/GET-INTERPOLATION-ANGULAR-VELOCITY))

(cffi:defcfun ("_wrap_btCollisionObject_getInterpolationAngularVelocity" COLLISION-OBJECT/GET-INTERPOLATION-ANGULAR-VELOCITY) :pointer
  (self :pointer))

(export 'COLLISION-OBJECT/GET-INTERPOLATION-ANGULAR-VELOCITY)

(declaim (inline COLLISION-OBJECT/GET-ISLAND-TAG))

(cffi:defcfun ("_wrap_btCollisionObject_getIslandTag" COLLISION-OBJECT/GET-ISLAND-TAG) :int
  (self :pointer))

(export 'COLLISION-OBJECT/GET-ISLAND-TAG)

(declaim (inline COLLISION-OBJECT/SET-ISLAND-TAG))

(cffi:defcfun ("_wrap_btCollisionObject_setIslandTag" COLLISION-OBJECT/SET-ISLAND-TAG) :void
  (self :pointer)
  (tag :int))

(export 'COLLISION-OBJECT/SET-ISLAND-TAG)

(declaim (inline COLLISION-OBJECT/GET-COMPANION-ID))

(cffi:defcfun ("_wrap_btCollisionObject_getCompanionId" COLLISION-OBJECT/GET-COMPANION-ID) :int
  (self :pointer))

(export 'COLLISION-OBJECT/GET-COMPANION-ID)

(declaim (inline COLLISION-OBJECT/SET-COMPANION-ID))

(cffi:defcfun ("_wrap_btCollisionObject_setCompanionId" COLLISION-OBJECT/SET-COMPANION-ID) :void
  (self :pointer)
  (id :int))

(export 'COLLISION-OBJECT/SET-COMPANION-ID)

(declaim (inline COLLISION-OBJECT/GET-HIT-FRACTION))

(cffi:defcfun ("_wrap_btCollisionObject_getHitFraction" COLLISION-OBJECT/GET-HIT-FRACTION) :float
  (self :pointer))

(export 'COLLISION-OBJECT/GET-HIT-FRACTION)

(declaim (inline COLLISION-OBJECT/SET-HIT-FRACTION))

(cffi:defcfun ("_wrap_btCollisionObject_setHitFraction" COLLISION-OBJECT/SET-HIT-FRACTION) :void
  (self :pointer)
  (hitFraction :float))

(export 'COLLISION-OBJECT/SET-HIT-FRACTION)

(declaim (inline COLLISION-OBJECT/GET-COLLISION-FLAGS))

(cffi:defcfun ("_wrap_btCollisionObject_getCollisionFlags" COLLISION-OBJECT/GET-COLLISION-FLAGS) :int
  (self :pointer))

(export 'COLLISION-OBJECT/GET-COLLISION-FLAGS)

(declaim (inline COLLISION-OBJECT/SET-COLLISION-FLAGS))

(cffi:defcfun ("_wrap_btCollisionObject_setCollisionFlags" COLLISION-OBJECT/SET-COLLISION-FLAGS) :void
  (self :pointer)
  (flags :int))

(export 'COLLISION-OBJECT/SET-COLLISION-FLAGS)

(declaim (inline COLLISION-OBJECT/GET-CCD-SWEPT-SPHERE-RADIUS))

(cffi:defcfun ("_wrap_btCollisionObject_getCcdSweptSphereRadius" COLLISION-OBJECT/GET-CCD-SWEPT-SPHERE-RADIUS) :float
  (self :pointer))

(export 'COLLISION-OBJECT/GET-CCD-SWEPT-SPHERE-RADIUS)

(declaim (inline COLLISION-OBJECT/SET-CCD-SWEPT-SPHERE-RADIUS))

(cffi:defcfun ("_wrap_btCollisionObject_setCcdSweptSphereRadius" COLLISION-OBJECT/SET-CCD-SWEPT-SPHERE-RADIUS) :void
  (self :pointer)
  (radius :float))

(export 'COLLISION-OBJECT/SET-CCD-SWEPT-SPHERE-RADIUS)

(declaim (inline COLLISION-OBJECT/GET-CCD-MOTION-THRESHOLD))

(cffi:defcfun ("_wrap_btCollisionObject_getCcdMotionThreshold" COLLISION-OBJECT/GET-CCD-MOTION-THRESHOLD) :float
  (self :pointer))

(export 'COLLISION-OBJECT/GET-CCD-MOTION-THRESHOLD)

(declaim (inline COLLISION-OBJECT/GET-CCD-SQUARE-MOTION-THRESHOLD))

(cffi:defcfun ("_wrap_btCollisionObject_getCcdSquareMotionThreshold" COLLISION-OBJECT/GET-CCD-SQUARE-MOTION-THRESHOLD) :float
  (self :pointer))

(export 'COLLISION-OBJECT/GET-CCD-SQUARE-MOTION-THRESHOLD)

(declaim (inline COLLISION-OBJECT/SET-CCD-MOTION-THRESHOLD))

(cffi:defcfun ("_wrap_btCollisionObject_setCcdMotionThreshold" COLLISION-OBJECT/SET-CCD-MOTION-THRESHOLD) :void
  (self :pointer)
  (ccdMotionThreshold :float))

(export 'COLLISION-OBJECT/SET-CCD-MOTION-THRESHOLD)

(declaim (inline COLLISION-OBJECT/GET-USER-POINTER))

(cffi:defcfun ("_wrap_btCollisionObject_getUserPointer" COLLISION-OBJECT/GET-USER-POINTER) :pointer
  (self :pointer))

(export 'COLLISION-OBJECT/GET-USER-POINTER)

(declaim (inline COLLISION-OBJECT/GET-USER-INDEX))

(cffi:defcfun ("_wrap_btCollisionObject_getUserIndex" COLLISION-OBJECT/GET-USER-INDEX) :int
  (self :pointer))

(export 'COLLISION-OBJECT/GET-USER-INDEX)

(declaim (inline COLLISION-OBJECT/SET-USER-POINTER))

(cffi:defcfun ("_wrap_btCollisionObject_setUserPointer" COLLISION-OBJECT/SET-USER-POINTER) :void
  (self :pointer)
  (userPointer :pointer))

(export 'COLLISION-OBJECT/SET-USER-POINTER)

(declaim (inline COLLISION-OBJECT/SET-USER-INDEX))

(cffi:defcfun ("_wrap_btCollisionObject_setUserIndex" COLLISION-OBJECT/SET-USER-INDEX) :void
  (self :pointer)
  (index :int))

(export 'COLLISION-OBJECT/SET-USER-INDEX)

(declaim (inline COLLISION-OBJECT/GET-UPDATE-REVISION-INTERNAL))

(cffi:defcfun ("_wrap_btCollisionObject_getUpdateRevisionInternal" COLLISION-OBJECT/GET-UPDATE-REVISION-INTERNAL) :int
  (self :pointer))

(export 'COLLISION-OBJECT/GET-UPDATE-REVISION-INTERNAL)

(declaim (inline COLLISION-OBJECT/CHECK-COLLIDE-WITH))

(cffi:defcfun ("_wrap_btCollisionObject_checkCollideWith" COLLISION-OBJECT/CHECK-COLLIDE-WITH) :pointer
  (self :pointer)
  (co :pointer))

(export 'COLLISION-OBJECT/CHECK-COLLIDE-WITH)

(declaim (inline COLLISION-OBJECT/CALCULATE-SERIALIZE-BUFFER-SIZE))

(cffi:defcfun ("_wrap_btCollisionObject_calculateSerializeBufferSize" COLLISION-OBJECT/CALCULATE-SERIALIZE-BUFFER-SIZE) :int
  (self :pointer))

(export 'COLLISION-OBJECT/CALCULATE-SERIALIZE-BUFFER-SIZE)

(declaim (inline COLLISION-OBJECT/SERIALIZE))

(cffi:defcfun ("_wrap_btCollisionObject_serialize" COLLISION-OBJECT/SERIALIZE) :string
  (self :pointer)
  (dataBuffer :pointer)
  (serializer :pointer))

(export 'COLLISION-OBJECT/SERIALIZE)

(declaim (inline COLLISION-OBJECT/SERIALIZE-SINGLE-OBJECT))

(cffi:defcfun ("_wrap_btCollisionObject_serializeSingleObject" COLLISION-OBJECT/SERIALIZE-SINGLE-OBJECT) :void
  (self :pointer)
  (serializer :pointer))

(export 'COLLISION-OBJECT/SERIALIZE-SINGLE-OBJECT)

(cffi:defcstruct COLLISION-OBJECT-DOUBLE-DATA
  (BROADPHASE-HANDLE :pointer)
  (COLLISION-SHAPE :pointer)
  (ROOT-COLLISION-SHAPE :pointer)
  (NAME :string)
  (WORLD-TRANSFORM TRANSFORM-DOUBLE-DATA)
  (INTERPOLATION-WORLD-TRANSFORM TRANSFORM-DOUBLE-DATA)
  (INTERPOLATION-LINEAR-VELOCITY VECTOR-3-DOUBLE-DATA)
  (INTERPOLATION-ANGULAR-VELOCITY VECTOR-3-DOUBLE-DATA)
  (ANISOTROPIC-FRICTION VECTOR-3-DOUBLE-DATA)
  (CONTACT-PROCESSING-THRESHOLD :double)
  (DEACTIVATION-TIME :double)
  (FRICTION :double)
  (ROLLING-FRICTION :double)
  (RESTITUTION :double)
  (HIT-FRACTION :double)
  (CCD-SWEPT-SPHERE-RADIUS :double)
  (CCD-MOTION-THRESHOLD :double)
  (HAS-ANISOTROPIC-FRICTION :int)
  (COLLISION-FLAGS :int)
  (ISLAND-TAG-1 :int)
  (COMPANION-ID :int)
  (ACTIVATION-STATE-1 :int)
  (INTERNAL-TYPE :int)
  (CHECK-COLLIDE-WITH :int)
  (PADDING :pointer))

(export 'COLLISION-OBJECT-DOUBLE-DATA)

(export 'BROADPHASE-HANDLE)

(export 'COLLISION-SHAPE)

(export 'ROOT-COLLISION-SHAPE)

(export 'NAME)

(export 'WORLD-TRANSFORM)

(export 'INTERPOLATION-WORLD-TRANSFORM)

(export 'INTERPOLATION-LINEAR-VELOCITY)

(export 'INTERPOLATION-ANGULAR-VELOCITY)

(export 'ANISOTROPIC-FRICTION)

(export 'CONTACT-PROCESSING-THRESHOLD)

(export 'DEACTIVATION-TIME)

(export 'FRICTION)

(export 'ROLLING-FRICTION)

(export 'RESTITUTION)

(export 'HIT-FRACTION)

(export 'CCD-SWEPT-SPHERE-RADIUS)

(export 'CCD-MOTION-THRESHOLD)

(export 'HAS-ANISOTROPIC-FRICTION)

(export 'COLLISION-FLAGS)

(export 'ISLAND-TAG-1)

(export 'COMPANION-ID)

(export 'ACTIVATION-STATE-1)

(export 'INTERNAL-TYPE)

(export 'CHECK-COLLIDE-WITH)

(export 'PADDING)

(cffi:defcstruct COLLISION-OBJECT-FLOAT-DATA
  (BROADPHASE-HANDLE :pointer)
  (COLLISION-SHAPE :pointer)
  (ROOT-COLLISION-SHAPE :pointer)
  (NAME :string)
  (WORLD-TRANSFORM TRANSFORM-FLOAT-DATA)
  (INTERPOLATION-WORLD-TRANSFORM TRANSFORM-FLOAT-DATA)
  (INTERPOLATION-LINEAR-VELOCITY VECTOR-3-FLOAT-DATA)
  (INTERPOLATION-ANGULAR-VELOCITY VECTOR-3-FLOAT-DATA)
  (ANISOTROPIC-FRICTION VECTOR-3-FLOAT-DATA)
  (CONTACT-PROCESSING-THRESHOLD :float)
  (DEACTIVATION-TIME :float)
  (FRICTION :float)
  (ROLLING-FRICTION :float)
  (RESTITUTION :float)
  (HIT-FRACTION :float)
  (CCD-SWEPT-SPHERE-RADIUS :float)
  (CCD-MOTION-THRESHOLD :float)
  (HAS-ANISOTROPIC-FRICTION :int)
  (COLLISION-FLAGS :int)
  (ISLAND-TAG-1 :int)
  (COMPANION-ID :int)
  (ACTIVATION-STATE-1 :int)
  (INTERNAL-TYPE :int)
  (CHECK-COLLIDE-WITH :int)
  (PADDING :pointer))

(export 'COLLISION-OBJECT-FLOAT-DATA)

(export 'BROADPHASE-HANDLE)

(export 'COLLISION-SHAPE)

(export 'ROOT-COLLISION-SHAPE)

(export 'NAME)

(export 'WORLD-TRANSFORM)

(export 'INTERPOLATION-WORLD-TRANSFORM)

(export 'INTERPOLATION-LINEAR-VELOCITY)

(export 'INTERPOLATION-ANGULAR-VELOCITY)

(export 'ANISOTROPIC-FRICTION)

(export 'CONTACT-PROCESSING-THRESHOLD)

(export 'DEACTIVATION-TIME)

(export 'FRICTION)

(export 'ROLLING-FRICTION)

(export 'RESTITUTION)

(export 'HIT-FRACTION)

(export 'CCD-SWEPT-SPHERE-RADIUS)

(export 'CCD-MOTION-THRESHOLD)

(export 'HAS-ANISOTROPIC-FRICTION)

(export 'COLLISION-FLAGS)

(export 'ISLAND-TAG-1)

(export 'COMPANION-ID)

(export 'ACTIVATION-STATE-1)

(export 'INTERNAL-TYPE)

(export 'CHECK-COLLIDE-WITH)

(export 'PADDING)

(declaim (inline BOX-SHAPE/MAKE-CPLUS-PLUS-INSTANCE))

(cffi:defcfun ("_wrap_btBoxShape_makeCPlusPlusInstance__SWIG_0" BOX-SHAPE/MAKE-CPLUS-PLUS-INSTANCE) :pointer
  (self :pointer)
  (sizeInBytes :pointer))

(export 'BOX-SHAPE/MAKE-CPLUS-PLUS-INSTANCE)

(declaim (inline BOX-SHAPE/DELETE-CPLUS-PLUS-INSTANCE))

(cffi:defcfun ("_wrap_btBoxShape_deleteCPlusPlusInstance__SWIG_0" BOX-SHAPE/DELETE-CPLUS-PLUS-INSTANCE) :void
  (self :pointer)
  (ptr :pointer))

(export 'BOX-SHAPE/DELETE-CPLUS-PLUS-INSTANCE)

(declaim (inline BOX-SHAPE/MAKE-CPLUS-PLUS-INSTANCE))

(cffi:defcfun ("_wrap_btBoxShape_makeCPlusPlusInstance__SWIG_1" BOX-SHAPE/MAKE-CPLUS-PLUS-INSTANCE) :pointer
  (self :pointer)
  (arg1 :pointer)
  (ptr :pointer))

(export 'BOX-SHAPE/MAKE-CPLUS-PLUS-INSTANCE)

(declaim (inline BOX-SHAPE/DELETE-CPLUS-PLUS-INSTANCE))

(cffi:defcfun ("_wrap_btBoxShape_deleteCPlusPlusInstance__SWIG_1" BOX-SHAPE/DELETE-CPLUS-PLUS-INSTANCE) :void
  (self :pointer)
  (arg1 :pointer)
  (arg2 :pointer))

(export 'BOX-SHAPE/DELETE-CPLUS-PLUS-INSTANCE)

(declaim (inline BOX-SHAPE/MAKE-CPLUS-ARRAY))

(cffi:defcfun ("_wrap_btBoxShape_makeCPlusArray__SWIG_0" BOX-SHAPE/MAKE-CPLUS-ARRAY) :pointer
  (self :pointer)
  (sizeInBytes :pointer))

(export 'BOX-SHAPE/MAKE-CPLUS-ARRAY)

(declaim (inline BOX-SHAPE/DELETE-CPLUS-ARRAY))

(cffi:defcfun ("_wrap_btBoxShape_deleteCPlusArray__SWIG_0" BOX-SHAPE/DELETE-CPLUS-ARRAY) :void
  (self :pointer)
  (ptr :pointer))

(export 'BOX-SHAPE/DELETE-CPLUS-ARRAY)

(declaim (inline BOX-SHAPE/MAKE-CPLUS-ARRAY))

(cffi:defcfun ("_wrap_btBoxShape_makeCPlusArray__SWIG_1" BOX-SHAPE/MAKE-CPLUS-ARRAY) :pointer
  (self :pointer)
  (arg1 :pointer)
  (ptr :pointer))

(export 'BOX-SHAPE/MAKE-CPLUS-ARRAY)

(declaim (inline BOX-SHAPE/DELETE-CPLUS-ARRAY))

(cffi:defcfun ("_wrap_btBoxShape_deleteCPlusArray__SWIG_1" BOX-SHAPE/DELETE-CPLUS-ARRAY) :void
  (self :pointer)
  (arg1 :pointer)
  (arg2 :pointer))

(export 'BOX-SHAPE/DELETE-CPLUS-ARRAY)

(declaim (inline BOX-SHAPE/GET-HALF-EXTENTS-WITH-MARGIN))

(cffi:defcfun ("_wrap_btBoxShape_getHalfExtentsWithMargin" BOX-SHAPE/GET-HALF-EXTENTS-WITH-MARGIN) :pointer
  (self :pointer))

(export 'BOX-SHAPE/GET-HALF-EXTENTS-WITH-MARGIN)

(declaim (inline BOX-SHAPE/GET-HALF-EXTENTS-WITHOUT-MARGIN))

(cffi:defcfun ("_wrap_btBoxShape_getHalfExtentsWithoutMargin" BOX-SHAPE/GET-HALF-EXTENTS-WITHOUT-MARGIN) :pointer
  (self :pointer))

(export 'BOX-SHAPE/GET-HALF-EXTENTS-WITHOUT-MARGIN)

(declaim (inline BOX-SHAPE/LOCAL-GET-SUPPORTING-VERTEX))

(cffi:defcfun ("_wrap_btBoxShape_localGetSupportingVertex" BOX-SHAPE/LOCAL-GET-SUPPORTING-VERTEX) :pointer
  (self :pointer)
  (vec :pointer))

(export 'BOX-SHAPE/LOCAL-GET-SUPPORTING-VERTEX)

(declaim (inline BOX-SHAPE/LOCAL-GET-SUPPORTING-VERTEX-WITHOUT-MARGIN))

(cffi:defcfun ("_wrap_btBoxShape_localGetSupportingVertexWithoutMargin" BOX-SHAPE/LOCAL-GET-SUPPORTING-VERTEX-WITHOUT-MARGIN) :pointer
  (self :pointer)
  (vec :pointer))

(export 'BOX-SHAPE/LOCAL-GET-SUPPORTING-VERTEX-WITHOUT-MARGIN)

(declaim (inline BOX-SHAPE/BATCHED-UNIT-VECTOR-GET-SUPPORTING-VERTEX-WITHOUT-MARGIN))

(cffi:defcfun ("_wrap_btBoxShape_batchedUnitVectorGetSupportingVertexWithoutMargin" BOX-SHAPE/BATCHED-UNIT-VECTOR-GET-SUPPORTING-VERTEX-WITHOUT-MARGIN) :void
  (self :pointer)
  (vectors :pointer)
  (supportVerticesOut :pointer)
  (numVectors :int))

(export 'BOX-SHAPE/BATCHED-UNIT-VECTOR-GET-SUPPORTING-VERTEX-WITHOUT-MARGIN)

(declaim (inline MAKE-BOX-SHAPE))

(cffi:defcfun ("_wrap_new_btBoxShape" MAKE-BOX-SHAPE) :pointer
  (boxHalfExtents :pointer))

(export 'MAKE-BOX-SHAPE)

(declaim (inline BOX-SHAPE/SET-MARGIN))

(cffi:defcfun ("_wrap_btBoxShape_setMargin" BOX-SHAPE/SET-MARGIN) :void
  (self :pointer)
  (collisionMargin :float))

(export 'BOX-SHAPE/SET-MARGIN)

(declaim (inline BOX-SHAPE/SET-LOCAL-SCALING))

(cffi:defcfun ("_wrap_btBoxShape_setLocalScaling" BOX-SHAPE/SET-LOCAL-SCALING) :void
  (self :pointer)
  (scaling :pointer))

(export 'BOX-SHAPE/SET-LOCAL-SCALING)

(declaim (inline BOX-SHAPE/GET-AABB))

(cffi:defcfun ("_wrap_btBoxShape_getAabb" BOX-SHAPE/GET-AABB) :void
  (self :pointer)
  (t_arg1 :pointer)
  (aabbMin :pointer)
  (aabbMax :pointer))

(export 'BOX-SHAPE/GET-AABB)

(declaim (inline BOX-SHAPE/CALCULATE-LOCAL-INERTIA))

(cffi:defcfun ("_wrap_btBoxShape_calculateLocalInertia" BOX-SHAPE/CALCULATE-LOCAL-INERTIA) :void
  (self :pointer)
  (mass :float)
  (inertia :pointer))

(export 'BOX-SHAPE/CALCULATE-LOCAL-INERTIA)

(declaim (inline BOX-SHAPE/GET-PLANE))

(cffi:defcfun ("_wrap_btBoxShape_getPlane" BOX-SHAPE/GET-PLANE) :void
  (self :pointer)
  (planeNormal :pointer)
  (planeSupport :pointer)
  (i :int))

(export 'BOX-SHAPE/GET-PLANE)

(declaim (inline BOX-SHAPE/GET-NUM-PLANES))

(cffi:defcfun ("_wrap_btBoxShape_getNumPlanes" BOX-SHAPE/GET-NUM-PLANES) :int
  (self :pointer))

(export 'BOX-SHAPE/GET-NUM-PLANES)

(declaim (inline BOX-SHAPE/GET-NUM-VERTICES))

(cffi:defcfun ("_wrap_btBoxShape_getNumVertices" BOX-SHAPE/GET-NUM-VERTICES) :int
  (self :pointer))

(export 'BOX-SHAPE/GET-NUM-VERTICES)

(declaim (inline BOX-SHAPE/GET-NUM-EDGES))

(cffi:defcfun ("_wrap_btBoxShape_getNumEdges" BOX-SHAPE/GET-NUM-EDGES) :int
  (self :pointer))

(export 'BOX-SHAPE/GET-NUM-EDGES)

(declaim (inline BOX-SHAPE/GET-VERTEX))

(cffi:defcfun ("_wrap_btBoxShape_getVertex" BOX-SHAPE/GET-VERTEX) :void
  (self :pointer)
  (i :int)
  (vtx :pointer))

(export 'BOX-SHAPE/GET-VERTEX)

(declaim (inline BOX-SHAPE/GET-PLANE-EQUATION))

(cffi:defcfun ("_wrap_btBoxShape_getPlaneEquation" BOX-SHAPE/GET-PLANE-EQUATION) :void
  (self :pointer)
  (plane :pointer)
  (i :int))

(export 'BOX-SHAPE/GET-PLANE-EQUATION)

(declaim (inline BOX-SHAPE/GET-EDGE))

(cffi:defcfun ("_wrap_btBoxShape_getEdge" BOX-SHAPE/GET-EDGE) :void
  (self :pointer)
  (i :int)
  (pa :pointer)
  (pb :pointer))

(export 'BOX-SHAPE/GET-EDGE)

(declaim (inline BOX-SHAPE/IS-INSIDE))

(cffi:defcfun ("_wrap_btBoxShape_isInside" BOX-SHAPE/IS-INSIDE) :pointer
  (self :pointer)
  (pt :pointer)
  (tolerance :float))

(export 'BOX-SHAPE/IS-INSIDE)

(declaim (inline BOX-SHAPE/GET-NAME))

(cffi:defcfun ("_wrap_btBoxShape_getName" BOX-SHAPE/GET-NAME) :string
  (self :pointer))

(export 'BOX-SHAPE/GET-NAME)

(declaim (inline BOX-SHAPE/GET-NUM-PREFERRED-PENETRATION-DIRECTIONS))

(cffi:defcfun ("_wrap_btBoxShape_getNumPreferredPenetrationDirections" BOX-SHAPE/GET-NUM-PREFERRED-PENETRATION-DIRECTIONS) :int
  (self :pointer))

(export 'BOX-SHAPE/GET-NUM-PREFERRED-PENETRATION-DIRECTIONS)

(declaim (inline BOX-SHAPE/GET-PREFERRED-PENETRATION-DIRECTION))

(cffi:defcfun ("_wrap_btBoxShape_getPreferredPenetrationDirection" BOX-SHAPE/GET-PREFERRED-PENETRATION-DIRECTION) :void
  (self :pointer)
  (index :int)
  (penetrationVector :pointer))

(export 'BOX-SHAPE/GET-PREFERRED-PENETRATION-DIRECTION)

(declaim (inline DELETE/BT-BOX-SHAPE))

(cffi:defcfun ("_wrap_delete_btBoxShape" DELETE/BT-BOX-SHAPE) :void
  (self :pointer))

(export 'DELETE/BT-BOX-SHAPE)

(declaim (inline SPHERE-SHAPE/MAKE-CPLUS-PLUS-INSTANCE))

(cffi:defcfun ("_wrap_btSphereShape_makeCPlusPlusInstance__SWIG_0" SPHERE-SHAPE/MAKE-CPLUS-PLUS-INSTANCE) :pointer
  (self :pointer)
  (sizeInBytes :pointer))

(export 'SPHERE-SHAPE/MAKE-CPLUS-PLUS-INSTANCE)

(declaim (inline SPHERE-SHAPE/DELETE-CPLUS-PLUS-INSTANCE))

(cffi:defcfun ("_wrap_btSphereShape_deleteCPlusPlusInstance__SWIG_0" SPHERE-SHAPE/DELETE-CPLUS-PLUS-INSTANCE) :void
  (self :pointer)
  (ptr :pointer))

(export 'SPHERE-SHAPE/DELETE-CPLUS-PLUS-INSTANCE)

(declaim (inline SPHERE-SHAPE/MAKE-CPLUS-PLUS-INSTANCE))

(cffi:defcfun ("_wrap_btSphereShape_makeCPlusPlusInstance__SWIG_1" SPHERE-SHAPE/MAKE-CPLUS-PLUS-INSTANCE) :pointer
  (self :pointer)
  (arg1 :pointer)
  (ptr :pointer))

(export 'SPHERE-SHAPE/MAKE-CPLUS-PLUS-INSTANCE)

(declaim (inline SPHERE-SHAPE/DELETE-CPLUS-PLUS-INSTANCE))

(cffi:defcfun ("_wrap_btSphereShape_deleteCPlusPlusInstance__SWIG_1" SPHERE-SHAPE/DELETE-CPLUS-PLUS-INSTANCE) :void
  (self :pointer)
  (arg1 :pointer)
  (arg2 :pointer))

(export 'SPHERE-SHAPE/DELETE-CPLUS-PLUS-INSTANCE)

(declaim (inline SPHERE-SHAPE/MAKE-CPLUS-ARRAY))

(cffi:defcfun ("_wrap_btSphereShape_makeCPlusArray__SWIG_0" SPHERE-SHAPE/MAKE-CPLUS-ARRAY) :pointer
  (self :pointer)
  (sizeInBytes :pointer))

(export 'SPHERE-SHAPE/MAKE-CPLUS-ARRAY)

(declaim (inline SPHERE-SHAPE/DELETE-CPLUS-ARRAY))

(cffi:defcfun ("_wrap_btSphereShape_deleteCPlusArray__SWIG_0" SPHERE-SHAPE/DELETE-CPLUS-ARRAY) :void
  (self :pointer)
  (ptr :pointer))

(export 'SPHERE-SHAPE/DELETE-CPLUS-ARRAY)

(declaim (inline SPHERE-SHAPE/MAKE-CPLUS-ARRAY))

(cffi:defcfun ("_wrap_btSphereShape_makeCPlusArray__SWIG_1" SPHERE-SHAPE/MAKE-CPLUS-ARRAY) :pointer
  (self :pointer)
  (arg1 :pointer)
  (ptr :pointer))

(export 'SPHERE-SHAPE/MAKE-CPLUS-ARRAY)

(declaim (inline SPHERE-SHAPE/DELETE-CPLUS-ARRAY))

(cffi:defcfun ("_wrap_btSphereShape_deleteCPlusArray__SWIG_1" SPHERE-SHAPE/DELETE-CPLUS-ARRAY) :void
  (self :pointer)
  (arg1 :pointer)
  (arg2 :pointer))

(export 'SPHERE-SHAPE/DELETE-CPLUS-ARRAY)

(declaim (inline MAKE-SPHERE-SHAPE))

(cffi:defcfun ("_wrap_new_btSphereShape" MAKE-SPHERE-SHAPE) :pointer
  (radius :float))

(export 'MAKE-SPHERE-SHAPE)

(declaim (inline SPHERE-SHAPE/LOCAL-GET-SUPPORTING-VERTEX))

(cffi:defcfun ("_wrap_btSphereShape_localGetSupportingVertex" SPHERE-SHAPE/LOCAL-GET-SUPPORTING-VERTEX) :pointer
  (self :pointer)
  (vec :pointer))

(export 'SPHERE-SHAPE/LOCAL-GET-SUPPORTING-VERTEX)

(declaim (inline SPHERE-SHAPE/LOCAL-GET-SUPPORTING-VERTEX-WITHOUT-MARGIN))

(cffi:defcfun ("_wrap_btSphereShape_localGetSupportingVertexWithoutMargin" SPHERE-SHAPE/LOCAL-GET-SUPPORTING-VERTEX-WITHOUT-MARGIN) :pointer
  (self :pointer)
  (vec :pointer))

(export 'SPHERE-SHAPE/LOCAL-GET-SUPPORTING-VERTEX-WITHOUT-MARGIN)

(declaim (inline SPHERE-SHAPE/BATCHED-UNIT-VECTOR-GET-SUPPORTING-VERTEX-WITHOUT-MARGIN))

(cffi:defcfun ("_wrap_btSphereShape_batchedUnitVectorGetSupportingVertexWithoutMargin" SPHERE-SHAPE/BATCHED-UNIT-VECTOR-GET-SUPPORTING-VERTEX-WITHOUT-MARGIN) :void
  (self :pointer)
  (vectors :pointer)
  (supportVerticesOut :pointer)
  (numVectors :int))

(export 'SPHERE-SHAPE/BATCHED-UNIT-VECTOR-GET-SUPPORTING-VERTEX-WITHOUT-MARGIN)

(declaim (inline SPHERE-SHAPE/CALCULATE-LOCAL-INERTIA))

(cffi:defcfun ("_wrap_btSphereShape_calculateLocalInertia" SPHERE-SHAPE/CALCULATE-LOCAL-INERTIA) :void
  (self :pointer)
  (mass :float)
  (inertia :pointer))

(export 'SPHERE-SHAPE/CALCULATE-LOCAL-INERTIA)

(declaim (inline SPHERE-SHAPE/GET-AABB))

(cffi:defcfun ("_wrap_btSphereShape_getAabb" SPHERE-SHAPE/GET-AABB) :void
  (self :pointer)
  (t_arg1 :pointer)
  (aabbMin :pointer)
  (aabbMax :pointer))

(export 'SPHERE-SHAPE/GET-AABB)

(declaim (inline SPHERE-SHAPE/GET-RADIUS))

(cffi:defcfun ("_wrap_btSphereShape_getRadius" SPHERE-SHAPE/GET-RADIUS) :float
  (self :pointer))

(export 'SPHERE-SHAPE/GET-RADIUS)

(declaim (inline SPHERE-SHAPE/SET-UNSCALED-RADIUS))

(cffi:defcfun ("_wrap_btSphereShape_setUnscaledRadius" SPHERE-SHAPE/SET-UNSCALED-RADIUS) :void
  (self :pointer)
  (radius :float))

(export 'SPHERE-SHAPE/SET-UNSCALED-RADIUS)

(declaim (inline SPHERE-SHAPE/GET-NAME))

(cffi:defcfun ("_wrap_btSphereShape_getName" SPHERE-SHAPE/GET-NAME) :string
  (self :pointer))

(export 'SPHERE-SHAPE/GET-NAME)

(declaim (inline SPHERE-SHAPE/SET-MARGIN))

(cffi:defcfun ("_wrap_btSphereShape_setMargin" SPHERE-SHAPE/SET-MARGIN) :void
  (self :pointer)
  (margin :float))

(export 'SPHERE-SHAPE/SET-MARGIN)

(declaim (inline SPHERE-SHAPE/GET-MARGIN))

(cffi:defcfun ("_wrap_btSphereShape_getMargin" SPHERE-SHAPE/GET-MARGIN) :float
  (self :pointer))

(export 'SPHERE-SHAPE/GET-MARGIN)

(declaim (inline DELETE/BT-SPHERE-SHAPE))

(cffi:defcfun ("_wrap_delete_btSphereShape" DELETE/BT-SPHERE-SHAPE) :void
  (self :pointer))

(export 'DELETE/BT-SPHERE-SHAPE)

(declaim (inline CAPSULE-SHAPE/MAKE-CPLUS-PLUS-INSTANCE))

(cffi:defcfun ("_wrap_btCapsuleShape_makeCPlusPlusInstance__SWIG_0" CAPSULE-SHAPE/MAKE-CPLUS-PLUS-INSTANCE) :pointer
  (self :pointer)
  (sizeInBytes :pointer))

(export 'CAPSULE-SHAPE/MAKE-CPLUS-PLUS-INSTANCE)

(declaim (inline CAPSULE-SHAPE/DELETE-CPLUS-PLUS-INSTANCE))

(cffi:defcfun ("_wrap_btCapsuleShape_deleteCPlusPlusInstance__SWIG_0" CAPSULE-SHAPE/DELETE-CPLUS-PLUS-INSTANCE) :void
  (self :pointer)
  (ptr :pointer))

(export 'CAPSULE-SHAPE/DELETE-CPLUS-PLUS-INSTANCE)

(declaim (inline CAPSULE-SHAPE/MAKE-CPLUS-PLUS-INSTANCE))

(cffi:defcfun ("_wrap_btCapsuleShape_makeCPlusPlusInstance__SWIG_1" CAPSULE-SHAPE/MAKE-CPLUS-PLUS-INSTANCE) :pointer
  (self :pointer)
  (arg1 :pointer)
  (ptr :pointer))

(export 'CAPSULE-SHAPE/MAKE-CPLUS-PLUS-INSTANCE)

(declaim (inline CAPSULE-SHAPE/DELETE-CPLUS-PLUS-INSTANCE))

(cffi:defcfun ("_wrap_btCapsuleShape_deleteCPlusPlusInstance__SWIG_1" CAPSULE-SHAPE/DELETE-CPLUS-PLUS-INSTANCE) :void
  (self :pointer)
  (arg1 :pointer)
  (arg2 :pointer))

(export 'CAPSULE-SHAPE/DELETE-CPLUS-PLUS-INSTANCE)

(declaim (inline CAPSULE-SHAPE/MAKE-CPLUS-ARRAY))

(cffi:defcfun ("_wrap_btCapsuleShape_makeCPlusArray__SWIG_0" CAPSULE-SHAPE/MAKE-CPLUS-ARRAY) :pointer
  (self :pointer)
  (sizeInBytes :pointer))

(export 'CAPSULE-SHAPE/MAKE-CPLUS-ARRAY)

(declaim (inline CAPSULE-SHAPE/DELETE-CPLUS-ARRAY))

(cffi:defcfun ("_wrap_btCapsuleShape_deleteCPlusArray__SWIG_0" CAPSULE-SHAPE/DELETE-CPLUS-ARRAY) :void
  (self :pointer)
  (ptr :pointer))

(export 'CAPSULE-SHAPE/DELETE-CPLUS-ARRAY)

(declaim (inline CAPSULE-SHAPE/MAKE-CPLUS-ARRAY))

(cffi:defcfun ("_wrap_btCapsuleShape_makeCPlusArray__SWIG_1" CAPSULE-SHAPE/MAKE-CPLUS-ARRAY) :pointer
  (self :pointer)
  (arg1 :pointer)
  (ptr :pointer))

(export 'CAPSULE-SHAPE/MAKE-CPLUS-ARRAY)

(declaim (inline CAPSULE-SHAPE/DELETE-CPLUS-ARRAY))

(cffi:defcfun ("_wrap_btCapsuleShape_deleteCPlusArray__SWIG_1" CAPSULE-SHAPE/DELETE-CPLUS-ARRAY) :void
  (self :pointer)
  (arg1 :pointer)
  (arg2 :pointer))

(export 'CAPSULE-SHAPE/DELETE-CPLUS-ARRAY)

(declaim (inline MAKE-CAPSULE-SHAPE))

(cffi:defcfun ("_wrap_new_btCapsuleShape__SWIG_1" MAKE-CAPSULE-SHAPE) :pointer
  (radius :float)
  (height :float))

(export 'MAKE-CAPSULE-SHAPE)

(declaim (inline CAPSULE-SHAPE/CALCULATE-LOCAL-INERTIA))

(cffi:defcfun ("_wrap_btCapsuleShape_calculateLocalInertia" CAPSULE-SHAPE/CALCULATE-LOCAL-INERTIA) :void
  (self :pointer)
  (mass :float)
  (inertia :pointer))

(export 'CAPSULE-SHAPE/CALCULATE-LOCAL-INERTIA)

(declaim (inline CAPSULE-SHAPE/LOCAL-GET-SUPPORTING-VERTEX-WITHOUT-MARGIN))

(cffi:defcfun ("_wrap_btCapsuleShape_localGetSupportingVertexWithoutMargin" CAPSULE-SHAPE/LOCAL-GET-SUPPORTING-VERTEX-WITHOUT-MARGIN) :pointer
  (self :pointer)
  (vec :pointer))

(export 'CAPSULE-SHAPE/LOCAL-GET-SUPPORTING-VERTEX-WITHOUT-MARGIN)

(declaim (inline CAPSULE-SHAPE/BATCHED-UNIT-VECTOR-GET-SUPPORTING-VERTEX-WITHOUT-MARGIN))

(cffi:defcfun ("_wrap_btCapsuleShape_batchedUnitVectorGetSupportingVertexWithoutMargin" CAPSULE-SHAPE/BATCHED-UNIT-VECTOR-GET-SUPPORTING-VERTEX-WITHOUT-MARGIN) :void
  (self :pointer)
  (vectors :pointer)
  (supportVerticesOut :pointer)
  (numVectors :int))

(export 'CAPSULE-SHAPE/BATCHED-UNIT-VECTOR-GET-SUPPORTING-VERTEX-WITHOUT-MARGIN)

(declaim (inline CAPSULE-SHAPE/SET-MARGIN))

(cffi:defcfun ("_wrap_btCapsuleShape_setMargin" CAPSULE-SHAPE/SET-MARGIN) :void
  (self :pointer)
  (collisionMargin :float))

(export 'CAPSULE-SHAPE/SET-MARGIN)

(declaim (inline CAPSULE-SHAPE/GET-AABB))

(cffi:defcfun ("_wrap_btCapsuleShape_getAabb" CAPSULE-SHAPE/GET-AABB) :void
  (self :pointer)
  (t_arg1 :pointer)
  (aabbMin :pointer)
  (aabbMax :pointer))

(export 'CAPSULE-SHAPE/GET-AABB)

(declaim (inline CAPSULE-SHAPE/GET-NAME))

(cffi:defcfun ("_wrap_btCapsuleShape_getName" CAPSULE-SHAPE/GET-NAME) :string
  (self :pointer))

(export 'CAPSULE-SHAPE/GET-NAME)

(declaim (inline CAPSULE-SHAPE/GET-UP-AXIS))

(cffi:defcfun ("_wrap_btCapsuleShape_getUpAxis" CAPSULE-SHAPE/GET-UP-AXIS) :int
  (self :pointer))

(export 'CAPSULE-SHAPE/GET-UP-AXIS)

(declaim (inline CAPSULE-SHAPE/GET-RADIUS))

(cffi:defcfun ("_wrap_btCapsuleShape_getRadius" CAPSULE-SHAPE/GET-RADIUS) :float
  (self :pointer))

(export 'CAPSULE-SHAPE/GET-RADIUS)

(declaim (inline CAPSULE-SHAPE/GET-HALF-HEIGHT))

(cffi:defcfun ("_wrap_btCapsuleShape_getHalfHeight" CAPSULE-SHAPE/GET-HALF-HEIGHT) :float
  (self :pointer))

(export 'CAPSULE-SHAPE/GET-HALF-HEIGHT)

(declaim (inline CAPSULE-SHAPE/SET-LOCAL-SCALING))

(cffi:defcfun ("_wrap_btCapsuleShape_setLocalScaling" CAPSULE-SHAPE/SET-LOCAL-SCALING) :void
  (self :pointer)
  (scaling :pointer))

(export 'CAPSULE-SHAPE/SET-LOCAL-SCALING)

(declaim (inline CAPSULE-SHAPE/GET-ANISOTROPIC-ROLLING-FRICTION-DIRECTION))

(cffi:defcfun ("_wrap_btCapsuleShape_getAnisotropicRollingFrictionDirection" CAPSULE-SHAPE/GET-ANISOTROPIC-ROLLING-FRICTION-DIRECTION) :pointer
  (self :pointer))

(export 'CAPSULE-SHAPE/GET-ANISOTROPIC-ROLLING-FRICTION-DIRECTION)

(declaim (inline CAPSULE-SHAPE/CALCULATE-SERIALIZE-BUFFER-SIZE))

(cffi:defcfun ("_wrap_btCapsuleShape_calculateSerializeBufferSize" CAPSULE-SHAPE/CALCULATE-SERIALIZE-BUFFER-SIZE) :int
  (self :pointer))

(export 'CAPSULE-SHAPE/CALCULATE-SERIALIZE-BUFFER-SIZE)

(declaim (inline CAPSULE-SHAPE/SERIALIZE))

(cffi:defcfun ("_wrap_btCapsuleShape_serialize" CAPSULE-SHAPE/SERIALIZE) :string
  (self :pointer)
  (dataBuffer :pointer)
  (serializer :pointer))

(export 'CAPSULE-SHAPE/SERIALIZE)

(declaim (inline DELETE/BT-CAPSULE-SHAPE))

(cffi:defcfun ("_wrap_delete_btCapsuleShape" DELETE/BT-CAPSULE-SHAPE) :void
  (self :pointer))

(export 'DELETE/BT-CAPSULE-SHAPE)

(declaim (inline MAKE-CAPSULE-SHAPE-X))

(cffi:defcfun ("_wrap_new_btCapsuleShapeX" MAKE-CAPSULE-SHAPE-X) :pointer
  (radius :float)
  (height :float))

(export 'MAKE-CAPSULE-SHAPE-X)

(declaim (inline CAPSULE-SHAPE-X/GET-NAME))

(cffi:defcfun ("_wrap_btCapsuleShapeX_getName" CAPSULE-SHAPE-X/GET-NAME) :string
  (self :pointer))

(export 'CAPSULE-SHAPE-X/GET-NAME)

(declaim (inline DELETE/BT-CAPSULE-SHAPE-X))

(cffi:defcfun ("_wrap_delete_btCapsuleShapeX" DELETE/BT-CAPSULE-SHAPE-X) :void
  (self :pointer))

(export 'DELETE/BT-CAPSULE-SHAPE-X)

(declaim (inline MAKE-CAPSULE-SHAPE-Z))

(cffi:defcfun ("_wrap_new_btCapsuleShapeZ" MAKE-CAPSULE-SHAPE-Z) :pointer
  (radius :float)
  (height :float))

(export 'MAKE-CAPSULE-SHAPE-Z)

(declaim (inline CAPSULE-SHAPE-Z/GET-NAME))

(cffi:defcfun ("_wrap_btCapsuleShapeZ_getName" CAPSULE-SHAPE-Z/GET-NAME) :string
  (self :pointer))

(export 'CAPSULE-SHAPE-Z/GET-NAME)

(declaim (inline DELETE/BT-CAPSULE-SHAPE-Z))

(cffi:defcfun ("_wrap_delete_btCapsuleShapeZ" DELETE/BT-CAPSULE-SHAPE-Z) :void
  (self :pointer))

(export 'DELETE/BT-CAPSULE-SHAPE-Z)

(cffi:defcstruct CAPSULE-SHAPE-DATA
  (CONVEX-INTERNAL-SHAPE-DATA :pointer)
  (UP-AXIS :int)
  (PADDING :pointer))

(export 'CAPSULE-SHAPE-DATA)

(export 'CONVEX-INTERNAL-SHAPE-DATA)

(export 'UP-AXIS)

(export 'PADDING)

(declaim (inline CYLINDER-SHAPE/MAKE-CPLUS-PLUS-INSTANCE))

(cffi:defcfun ("_wrap_btCylinderShape_makeCPlusPlusInstance__SWIG_0" CYLINDER-SHAPE/MAKE-CPLUS-PLUS-INSTANCE) :pointer
  (self :pointer)
  (sizeInBytes :pointer))

(export 'CYLINDER-SHAPE/MAKE-CPLUS-PLUS-INSTANCE)

(declaim (inline CYLINDER-SHAPE/DELETE-CPLUS-PLUS-INSTANCE))

(cffi:defcfun ("_wrap_btCylinderShape_deleteCPlusPlusInstance__SWIG_0" CYLINDER-SHAPE/DELETE-CPLUS-PLUS-INSTANCE) :void
  (self :pointer)
  (ptr :pointer))

(export 'CYLINDER-SHAPE/DELETE-CPLUS-PLUS-INSTANCE)

(declaim (inline CYLINDER-SHAPE/MAKE-CPLUS-PLUS-INSTANCE))

(cffi:defcfun ("_wrap_btCylinderShape_makeCPlusPlusInstance__SWIG_1" CYLINDER-SHAPE/MAKE-CPLUS-PLUS-INSTANCE) :pointer
  (self :pointer)
  (arg1 :pointer)
  (ptr :pointer))

(export 'CYLINDER-SHAPE/MAKE-CPLUS-PLUS-INSTANCE)

(declaim (inline CYLINDER-SHAPE/DELETE-CPLUS-PLUS-INSTANCE))

(cffi:defcfun ("_wrap_btCylinderShape_deleteCPlusPlusInstance__SWIG_1" CYLINDER-SHAPE/DELETE-CPLUS-PLUS-INSTANCE) :void
  (self :pointer)
  (arg1 :pointer)
  (arg2 :pointer))

(export 'CYLINDER-SHAPE/DELETE-CPLUS-PLUS-INSTANCE)

(declaim (inline CYLINDER-SHAPE/MAKE-CPLUS-ARRAY))

(cffi:defcfun ("_wrap_btCylinderShape_makeCPlusArray__SWIG_0" CYLINDER-SHAPE/MAKE-CPLUS-ARRAY) :pointer
  (self :pointer)
  (sizeInBytes :pointer))

(export 'CYLINDER-SHAPE/MAKE-CPLUS-ARRAY)

(declaim (inline CYLINDER-SHAPE/DELETE-CPLUS-ARRAY))

(cffi:defcfun ("_wrap_btCylinderShape_deleteCPlusArray__SWIG_0" CYLINDER-SHAPE/DELETE-CPLUS-ARRAY) :void
  (self :pointer)
  (ptr :pointer))

(export 'CYLINDER-SHAPE/DELETE-CPLUS-ARRAY)

(declaim (inline CYLINDER-SHAPE/MAKE-CPLUS-ARRAY))

(cffi:defcfun ("_wrap_btCylinderShape_makeCPlusArray__SWIG_1" CYLINDER-SHAPE/MAKE-CPLUS-ARRAY) :pointer
  (self :pointer)
  (arg1 :pointer)
  (ptr :pointer))

(export 'CYLINDER-SHAPE/MAKE-CPLUS-ARRAY)

(declaim (inline CYLINDER-SHAPE/DELETE-CPLUS-ARRAY))

(cffi:defcfun ("_wrap_btCylinderShape_deleteCPlusArray__SWIG_1" CYLINDER-SHAPE/DELETE-CPLUS-ARRAY) :void
  (self :pointer)
  (arg1 :pointer)
  (arg2 :pointer))

(export 'CYLINDER-SHAPE/DELETE-CPLUS-ARRAY)

(declaim (inline CYLINDER-SHAPE/GET-HALF-EXTENTS-WITH-MARGIN))

(cffi:defcfun ("_wrap_btCylinderShape_getHalfExtentsWithMargin" CYLINDER-SHAPE/GET-HALF-EXTENTS-WITH-MARGIN) :pointer
  (self :pointer))

(export 'CYLINDER-SHAPE/GET-HALF-EXTENTS-WITH-MARGIN)

(declaim (inline CYLINDER-SHAPE/GET-HALF-EXTENTS-WITHOUT-MARGIN))

(cffi:defcfun ("_wrap_btCylinderShape_getHalfExtentsWithoutMargin" CYLINDER-SHAPE/GET-HALF-EXTENTS-WITHOUT-MARGIN) :pointer
  (self :pointer))

(export 'CYLINDER-SHAPE/GET-HALF-EXTENTS-WITHOUT-MARGIN)

(declaim (inline MAKE-CYLINDER-SHAPE))

(cffi:defcfun ("_wrap_new_btCylinderShape" MAKE-CYLINDER-SHAPE) :pointer
  (halfExtents :pointer))

(export 'MAKE-CYLINDER-SHAPE)

(declaim (inline CYLINDER-SHAPE/GET-AABB))

(cffi:defcfun ("_wrap_btCylinderShape_getAabb" CYLINDER-SHAPE/GET-AABB) :void
  (self :pointer)
  (t_arg1 :pointer)
  (aabbMin :pointer)
  (aabbMax :pointer))

(export 'CYLINDER-SHAPE/GET-AABB)

(declaim (inline CYLINDER-SHAPE/CALCULATE-LOCAL-INERTIA))

(cffi:defcfun ("_wrap_btCylinderShape_calculateLocalInertia" CYLINDER-SHAPE/CALCULATE-LOCAL-INERTIA) :void
  (self :pointer)
  (mass :float)
  (inertia :pointer))

(export 'CYLINDER-SHAPE/CALCULATE-LOCAL-INERTIA)

(declaim (inline CYLINDER-SHAPE/LOCAL-GET-SUPPORTING-VERTEX-WITHOUT-MARGIN))

(cffi:defcfun ("_wrap_btCylinderShape_localGetSupportingVertexWithoutMargin" CYLINDER-SHAPE/LOCAL-GET-SUPPORTING-VERTEX-WITHOUT-MARGIN) :pointer
  (self :pointer)
  (vec :pointer))

(export 'CYLINDER-SHAPE/LOCAL-GET-SUPPORTING-VERTEX-WITHOUT-MARGIN)

(declaim (inline CYLINDER-SHAPE/BATCHED-UNIT-VECTOR-GET-SUPPORTING-VERTEX-WITHOUT-MARGIN))

(cffi:defcfun ("_wrap_btCylinderShape_batchedUnitVectorGetSupportingVertexWithoutMargin" CYLINDER-SHAPE/BATCHED-UNIT-VECTOR-GET-SUPPORTING-VERTEX-WITHOUT-MARGIN) :void
  (self :pointer)
  (vectors :pointer)
  (supportVerticesOut :pointer)
  (numVectors :int))

(export 'CYLINDER-SHAPE/BATCHED-UNIT-VECTOR-GET-SUPPORTING-VERTEX-WITHOUT-MARGIN)

(declaim (inline CYLINDER-SHAPE/SET-MARGIN))

(cffi:defcfun ("_wrap_btCylinderShape_setMargin" CYLINDER-SHAPE/SET-MARGIN) :void
  (self :pointer)
  (collisionMargin :float))

(export 'CYLINDER-SHAPE/SET-MARGIN)

(declaim (inline CYLINDER-SHAPE/LOCAL-GET-SUPPORTING-VERTEX))

(cffi:defcfun ("_wrap_btCylinderShape_localGetSupportingVertex" CYLINDER-SHAPE/LOCAL-GET-SUPPORTING-VERTEX) :pointer
  (self :pointer)
  (vec :pointer))

(export 'CYLINDER-SHAPE/LOCAL-GET-SUPPORTING-VERTEX)

(declaim (inline CYLINDER-SHAPE/GET-UP-AXIS))

(cffi:defcfun ("_wrap_btCylinderShape_getUpAxis" CYLINDER-SHAPE/GET-UP-AXIS) :int
  (self :pointer))

(export 'CYLINDER-SHAPE/GET-UP-AXIS)

(declaim (inline CYLINDER-SHAPE/GET-ANISOTROPIC-ROLLING-FRICTION-DIRECTION))

(cffi:defcfun ("_wrap_btCylinderShape_getAnisotropicRollingFrictionDirection" CYLINDER-SHAPE/GET-ANISOTROPIC-ROLLING-FRICTION-DIRECTION) :pointer
  (self :pointer))

(export 'CYLINDER-SHAPE/GET-ANISOTROPIC-ROLLING-FRICTION-DIRECTION)

(declaim (inline CYLINDER-SHAPE/GET-RADIUS))

(cffi:defcfun ("_wrap_btCylinderShape_getRadius" CYLINDER-SHAPE/GET-RADIUS) :float
  (self :pointer))

(export 'CYLINDER-SHAPE/GET-RADIUS)

(declaim (inline CYLINDER-SHAPE/SET-LOCAL-SCALING))

(cffi:defcfun ("_wrap_btCylinderShape_setLocalScaling" CYLINDER-SHAPE/SET-LOCAL-SCALING) :void
  (self :pointer)
  (scaling :pointer))

(export 'CYLINDER-SHAPE/SET-LOCAL-SCALING)

(declaim (inline CYLINDER-SHAPE/GET-NAME))

(cffi:defcfun ("_wrap_btCylinderShape_getName" CYLINDER-SHAPE/GET-NAME) :string
  (self :pointer))

(export 'CYLINDER-SHAPE/GET-NAME)

(declaim (inline CYLINDER-SHAPE/CALCULATE-SERIALIZE-BUFFER-SIZE))

(cffi:defcfun ("_wrap_btCylinderShape_calculateSerializeBufferSize" CYLINDER-SHAPE/CALCULATE-SERIALIZE-BUFFER-SIZE) :int
  (self :pointer))

(export 'CYLINDER-SHAPE/CALCULATE-SERIALIZE-BUFFER-SIZE)

(declaim (inline CYLINDER-SHAPE/SERIALIZE))

(cffi:defcfun ("_wrap_btCylinderShape_serialize" CYLINDER-SHAPE/SERIALIZE) :string
  (self :pointer)
  (dataBuffer :pointer)
  (serializer :pointer))

(export 'CYLINDER-SHAPE/SERIALIZE)

(declaim (inline DELETE/BT-CYLINDER-SHAPE))

(cffi:defcfun ("_wrap_delete_btCylinderShape" DELETE/BT-CYLINDER-SHAPE) :void
  (self :pointer))

(export 'DELETE/BT-CYLINDER-SHAPE)

(declaim (inline CYLINDER-SHAPE-X/MAKE-CPLUS-PLUS-INSTANCE))

(cffi:defcfun ("_wrap_btCylinderShapeX_makeCPlusPlusInstance__SWIG_0" CYLINDER-SHAPE-X/MAKE-CPLUS-PLUS-INSTANCE) :pointer
  (self :pointer)
  (sizeInBytes :pointer))

(export 'CYLINDER-SHAPE-X/MAKE-CPLUS-PLUS-INSTANCE)

(declaim (inline CYLINDER-SHAPE-X/DELETE-CPLUS-PLUS-INSTANCE))

(cffi:defcfun ("_wrap_btCylinderShapeX_deleteCPlusPlusInstance__SWIG_0" CYLINDER-SHAPE-X/DELETE-CPLUS-PLUS-INSTANCE) :void
  (self :pointer)
  (ptr :pointer))

(export 'CYLINDER-SHAPE-X/DELETE-CPLUS-PLUS-INSTANCE)

(declaim (inline CYLINDER-SHAPE-X/MAKE-CPLUS-PLUS-INSTANCE))

(cffi:defcfun ("_wrap_btCylinderShapeX_makeCPlusPlusInstance__SWIG_1" CYLINDER-SHAPE-X/MAKE-CPLUS-PLUS-INSTANCE) :pointer
  (self :pointer)
  (arg1 :pointer)
  (ptr :pointer))

(export 'CYLINDER-SHAPE-X/MAKE-CPLUS-PLUS-INSTANCE)

(declaim (inline CYLINDER-SHAPE-X/DELETE-CPLUS-PLUS-INSTANCE))

(cffi:defcfun ("_wrap_btCylinderShapeX_deleteCPlusPlusInstance__SWIG_1" CYLINDER-SHAPE-X/DELETE-CPLUS-PLUS-INSTANCE) :void
  (self :pointer)
  (arg1 :pointer)
  (arg2 :pointer))

(export 'CYLINDER-SHAPE-X/DELETE-CPLUS-PLUS-INSTANCE)

(declaim (inline CYLINDER-SHAPE-X/MAKE-CPLUS-ARRAY))

(cffi:defcfun ("_wrap_btCylinderShapeX_makeCPlusArray__SWIG_0" CYLINDER-SHAPE-X/MAKE-CPLUS-ARRAY) :pointer
  (self :pointer)
  (sizeInBytes :pointer))

(export 'CYLINDER-SHAPE-X/MAKE-CPLUS-ARRAY)

(declaim (inline CYLINDER-SHAPE-X/DELETE-CPLUS-ARRAY))

(cffi:defcfun ("_wrap_btCylinderShapeX_deleteCPlusArray__SWIG_0" CYLINDER-SHAPE-X/DELETE-CPLUS-ARRAY) :void
  (self :pointer)
  (ptr :pointer))

(export 'CYLINDER-SHAPE-X/DELETE-CPLUS-ARRAY)

(declaim (inline CYLINDER-SHAPE-X/MAKE-CPLUS-ARRAY))

(cffi:defcfun ("_wrap_btCylinderShapeX_makeCPlusArray__SWIG_1" CYLINDER-SHAPE-X/MAKE-CPLUS-ARRAY) :pointer
  (self :pointer)
  (arg1 :pointer)
  (ptr :pointer))

(export 'CYLINDER-SHAPE-X/MAKE-CPLUS-ARRAY)

(declaim (inline CYLINDER-SHAPE-X/DELETE-CPLUS-ARRAY))

(cffi:defcfun ("_wrap_btCylinderShapeX_deleteCPlusArray__SWIG_1" CYLINDER-SHAPE-X/DELETE-CPLUS-ARRAY) :void
  (self :pointer)
  (arg1 :pointer)
  (arg2 :pointer))

(export 'CYLINDER-SHAPE-X/DELETE-CPLUS-ARRAY)

(declaim (inline MAKE-CYLINDER-SHAPE-X))

(cffi:defcfun ("_wrap_new_btCylinderShapeX" MAKE-CYLINDER-SHAPE-X) :pointer
  (halfExtents :pointer))

(export 'MAKE-CYLINDER-SHAPE-X)

(declaim (inline CYLINDER-SHAPE-X/LOCAL-GET-SUPPORTING-VERTEX-WITHOUT-MARGIN))

(cffi:defcfun ("_wrap_btCylinderShapeX_localGetSupportingVertexWithoutMargin" CYLINDER-SHAPE-X/LOCAL-GET-SUPPORTING-VERTEX-WITHOUT-MARGIN) :pointer
  (self :pointer)
  (vec :pointer))

(export 'CYLINDER-SHAPE-X/LOCAL-GET-SUPPORTING-VERTEX-WITHOUT-MARGIN)

(declaim (inline CYLINDER-SHAPE-X/BATCHED-UNIT-VECTOR-GET-SUPPORTING-VERTEX-WITHOUT-MARGIN))

(cffi:defcfun ("_wrap_btCylinderShapeX_batchedUnitVectorGetSupportingVertexWithoutMargin" CYLINDER-SHAPE-X/BATCHED-UNIT-VECTOR-GET-SUPPORTING-VERTEX-WITHOUT-MARGIN) :void
  (self :pointer)
  (vectors :pointer)
  (supportVerticesOut :pointer)
  (numVectors :int))

(export 'CYLINDER-SHAPE-X/BATCHED-UNIT-VECTOR-GET-SUPPORTING-VERTEX-WITHOUT-MARGIN)

(declaim (inline CYLINDER-SHAPE-X/GET-NAME))

(cffi:defcfun ("_wrap_btCylinderShapeX_getName" CYLINDER-SHAPE-X/GET-NAME) :string
  (self :pointer))

(export 'CYLINDER-SHAPE-X/GET-NAME)

(declaim (inline CYLINDER-SHAPE-X/GET-RADIUS))

(cffi:defcfun ("_wrap_btCylinderShapeX_getRadius" CYLINDER-SHAPE-X/GET-RADIUS) :float
  (self :pointer))

(export 'CYLINDER-SHAPE-X/GET-RADIUS)

(declaim (inline DELETE/BT-CYLINDER-SHAPE-X))

(cffi:defcfun ("_wrap_delete_btCylinderShapeX" DELETE/BT-CYLINDER-SHAPE-X) :void
  (self :pointer))

(export 'DELETE/BT-CYLINDER-SHAPE-X)

(declaim (inline CYLINDER-SHAPE-Z/MAKE-CPLUS-PLUS-INSTANCE))

(cffi:defcfun ("_wrap_btCylinderShapeZ_makeCPlusPlusInstance__SWIG_0" CYLINDER-SHAPE-Z/MAKE-CPLUS-PLUS-INSTANCE) :pointer
  (self :pointer)
  (sizeInBytes :pointer))

(export 'CYLINDER-SHAPE-Z/MAKE-CPLUS-PLUS-INSTANCE)

(declaim (inline CYLINDER-SHAPE-Z/DELETE-CPLUS-PLUS-INSTANCE))

(cffi:defcfun ("_wrap_btCylinderShapeZ_deleteCPlusPlusInstance__SWIG_0" CYLINDER-SHAPE-Z/DELETE-CPLUS-PLUS-INSTANCE) :void
  (self :pointer)
  (ptr :pointer))

(export 'CYLINDER-SHAPE-Z/DELETE-CPLUS-PLUS-INSTANCE)

(declaim (inline CYLINDER-SHAPE-Z/MAKE-CPLUS-PLUS-INSTANCE))

(cffi:defcfun ("_wrap_btCylinderShapeZ_makeCPlusPlusInstance__SWIG_1" CYLINDER-SHAPE-Z/MAKE-CPLUS-PLUS-INSTANCE) :pointer
  (self :pointer)
  (arg1 :pointer)
  (ptr :pointer))

(export 'CYLINDER-SHAPE-Z/MAKE-CPLUS-PLUS-INSTANCE)

(declaim (inline CYLINDER-SHAPE-Z/DELETE-CPLUS-PLUS-INSTANCE))

(cffi:defcfun ("_wrap_btCylinderShapeZ_deleteCPlusPlusInstance__SWIG_1" CYLINDER-SHAPE-Z/DELETE-CPLUS-PLUS-INSTANCE) :void
  (self :pointer)
  (arg1 :pointer)
  (arg2 :pointer))

(export 'CYLINDER-SHAPE-Z/DELETE-CPLUS-PLUS-INSTANCE)

(declaim (inline CYLINDER-SHAPE-Z/MAKE-CPLUS-ARRAY))

(cffi:defcfun ("_wrap_btCylinderShapeZ_makeCPlusArray__SWIG_0" CYLINDER-SHAPE-Z/MAKE-CPLUS-ARRAY) :pointer
  (self :pointer)
  (sizeInBytes :pointer))

(export 'CYLINDER-SHAPE-Z/MAKE-CPLUS-ARRAY)

(declaim (inline CYLINDER-SHAPE-Z/DELETE-CPLUS-ARRAY))

(cffi:defcfun ("_wrap_btCylinderShapeZ_deleteCPlusArray__SWIG_0" CYLINDER-SHAPE-Z/DELETE-CPLUS-ARRAY) :void
  (self :pointer)
  (ptr :pointer))

(export 'CYLINDER-SHAPE-Z/DELETE-CPLUS-ARRAY)

(declaim (inline CYLINDER-SHAPE-Z/MAKE-CPLUS-ARRAY))

(cffi:defcfun ("_wrap_btCylinderShapeZ_makeCPlusArray__SWIG_1" CYLINDER-SHAPE-Z/MAKE-CPLUS-ARRAY) :pointer
  (self :pointer)
  (arg1 :pointer)
  (ptr :pointer))

(export 'CYLINDER-SHAPE-Z/MAKE-CPLUS-ARRAY)

(declaim (inline CYLINDER-SHAPE-Z/DELETE-CPLUS-ARRAY))

(cffi:defcfun ("_wrap_btCylinderShapeZ_deleteCPlusArray__SWIG_1" CYLINDER-SHAPE-Z/DELETE-CPLUS-ARRAY) :void
  (self :pointer)
  (arg1 :pointer)
  (arg2 :pointer))

(export 'CYLINDER-SHAPE-Z/DELETE-CPLUS-ARRAY)

(declaim (inline MAKE-CYLINDER-SHAPE-Z))

(cffi:defcfun ("_wrap_new_btCylinderShapeZ" MAKE-CYLINDER-SHAPE-Z) :pointer
  (halfExtents :pointer))

(export 'MAKE-CYLINDER-SHAPE-Z)

(declaim (inline CYLINDER-SHAPE-Z/LOCAL-GET-SUPPORTING-VERTEX-WITHOUT-MARGIN))

(cffi:defcfun ("_wrap_btCylinderShapeZ_localGetSupportingVertexWithoutMargin" CYLINDER-SHAPE-Z/LOCAL-GET-SUPPORTING-VERTEX-WITHOUT-MARGIN) :pointer
  (self :pointer)
  (vec :pointer))

(export 'CYLINDER-SHAPE-Z/LOCAL-GET-SUPPORTING-VERTEX-WITHOUT-MARGIN)

(declaim (inline CYLINDER-SHAPE-Z/BATCHED-UNIT-VECTOR-GET-SUPPORTING-VERTEX-WITHOUT-MARGIN))

(cffi:defcfun ("_wrap_btCylinderShapeZ_batchedUnitVectorGetSupportingVertexWithoutMargin" CYLINDER-SHAPE-Z/BATCHED-UNIT-VECTOR-GET-SUPPORTING-VERTEX-WITHOUT-MARGIN) :void
  (self :pointer)
  (vectors :pointer)
  (supportVerticesOut :pointer)
  (numVectors :int))

(export 'CYLINDER-SHAPE-Z/BATCHED-UNIT-VECTOR-GET-SUPPORTING-VERTEX-WITHOUT-MARGIN)

(declaim (inline CYLINDER-SHAPE-Z/GET-NAME))

(cffi:defcfun ("_wrap_btCylinderShapeZ_getName" CYLINDER-SHAPE-Z/GET-NAME) :string
  (self :pointer))

(export 'CYLINDER-SHAPE-Z/GET-NAME)

(declaim (inline CYLINDER-SHAPE-Z/GET-RADIUS))

(cffi:defcfun ("_wrap_btCylinderShapeZ_getRadius" CYLINDER-SHAPE-Z/GET-RADIUS) :float
  (self :pointer))

(export 'CYLINDER-SHAPE-Z/GET-RADIUS)

(declaim (inline DELETE/BT-CYLINDER-SHAPE-Z))

(cffi:defcfun ("_wrap_delete_btCylinderShapeZ" DELETE/BT-CYLINDER-SHAPE-Z) :void
  (self :pointer))

(export 'DELETE/BT-CYLINDER-SHAPE-Z)

(cffi:defcstruct CYLINDER-SHAPE-DATA
  (CONVEX-INTERNAL-SHAPE-DATA :pointer)
  (UP-AXIS :int)
  (PADDING :pointer))

(export 'CYLINDER-SHAPE-DATA)

(export 'CONVEX-INTERNAL-SHAPE-DATA)

(export 'UP-AXIS)

(export 'PADDING)

(declaim (inline CONE-SHAPE/MAKE-CPLUS-PLUS-INSTANCE))

(cffi:defcfun ("_wrap_btConeShape_makeCPlusPlusInstance__SWIG_0" CONE-SHAPE/MAKE-CPLUS-PLUS-INSTANCE) :pointer
  (self :pointer)
  (sizeInBytes :pointer))

(export 'CONE-SHAPE/MAKE-CPLUS-PLUS-INSTANCE)

(declaim (inline CONE-SHAPE/DELETE-CPLUS-PLUS-INSTANCE))

(cffi:defcfun ("_wrap_btConeShape_deleteCPlusPlusInstance__SWIG_0" CONE-SHAPE/DELETE-CPLUS-PLUS-INSTANCE) :void
  (self :pointer)
  (ptr :pointer))

(export 'CONE-SHAPE/DELETE-CPLUS-PLUS-INSTANCE)

(declaim (inline CONE-SHAPE/MAKE-CPLUS-PLUS-INSTANCE))

(cffi:defcfun ("_wrap_btConeShape_makeCPlusPlusInstance__SWIG_1" CONE-SHAPE/MAKE-CPLUS-PLUS-INSTANCE) :pointer
  (self :pointer)
  (arg1 :pointer)
  (ptr :pointer))

(export 'CONE-SHAPE/MAKE-CPLUS-PLUS-INSTANCE)

(declaim (inline CONE-SHAPE/DELETE-CPLUS-PLUS-INSTANCE))

(cffi:defcfun ("_wrap_btConeShape_deleteCPlusPlusInstance__SWIG_1" CONE-SHAPE/DELETE-CPLUS-PLUS-INSTANCE) :void
  (self :pointer)
  (arg1 :pointer)
  (arg2 :pointer))

(export 'CONE-SHAPE/DELETE-CPLUS-PLUS-INSTANCE)

(declaim (inline CONE-SHAPE/MAKE-CPLUS-ARRAY))

(cffi:defcfun ("_wrap_btConeShape_makeCPlusArray__SWIG_0" CONE-SHAPE/MAKE-CPLUS-ARRAY) :pointer
  (self :pointer)
  (sizeInBytes :pointer))

(export 'CONE-SHAPE/MAKE-CPLUS-ARRAY)

(declaim (inline CONE-SHAPE/DELETE-CPLUS-ARRAY))

(cffi:defcfun ("_wrap_btConeShape_deleteCPlusArray__SWIG_0" CONE-SHAPE/DELETE-CPLUS-ARRAY) :void
  (self :pointer)
  (ptr :pointer))

(export 'CONE-SHAPE/DELETE-CPLUS-ARRAY)

(declaim (inline CONE-SHAPE/MAKE-CPLUS-ARRAY))

(cffi:defcfun ("_wrap_btConeShape_makeCPlusArray__SWIG_1" CONE-SHAPE/MAKE-CPLUS-ARRAY) :pointer
  (self :pointer)
  (arg1 :pointer)
  (ptr :pointer))

(export 'CONE-SHAPE/MAKE-CPLUS-ARRAY)

(declaim (inline CONE-SHAPE/DELETE-CPLUS-ARRAY))

(cffi:defcfun ("_wrap_btConeShape_deleteCPlusArray__SWIG_1" CONE-SHAPE/DELETE-CPLUS-ARRAY) :void
  (self :pointer)
  (arg1 :pointer)
  (arg2 :pointer))

(export 'CONE-SHAPE/DELETE-CPLUS-ARRAY)

(declaim (inline MAKE-CONE-SHAPE))

(cffi:defcfun ("_wrap_new_btConeShape" MAKE-CONE-SHAPE) :pointer
  (radius :float)
  (height :float))

(export 'MAKE-CONE-SHAPE)

(declaim (inline CONE-SHAPE/LOCAL-GET-SUPPORTING-VERTEX))

(cffi:defcfun ("_wrap_btConeShape_localGetSupportingVertex" CONE-SHAPE/LOCAL-GET-SUPPORTING-VERTEX) :pointer
  (self :pointer)
  (vec :pointer))

(export 'CONE-SHAPE/LOCAL-GET-SUPPORTING-VERTEX)

(declaim (inline CONE-SHAPE/LOCAL-GET-SUPPORTING-VERTEX-WITHOUT-MARGIN))

(cffi:defcfun ("_wrap_btConeShape_localGetSupportingVertexWithoutMargin" CONE-SHAPE/LOCAL-GET-SUPPORTING-VERTEX-WITHOUT-MARGIN) :pointer
  (self :pointer)
  (vec :pointer))

(export 'CONE-SHAPE/LOCAL-GET-SUPPORTING-VERTEX-WITHOUT-MARGIN)

(declaim (inline CONE-SHAPE/BATCHED-UNIT-VECTOR-GET-SUPPORTING-VERTEX-WITHOUT-MARGIN))

(cffi:defcfun ("_wrap_btConeShape_batchedUnitVectorGetSupportingVertexWithoutMargin" CONE-SHAPE/BATCHED-UNIT-VECTOR-GET-SUPPORTING-VERTEX-WITHOUT-MARGIN) :void
  (self :pointer)
  (vectors :pointer)
  (supportVerticesOut :pointer)
  (numVectors :int))

(export 'CONE-SHAPE/BATCHED-UNIT-VECTOR-GET-SUPPORTING-VERTEX-WITHOUT-MARGIN)

(declaim (inline CONE-SHAPE/GET-RADIUS))

(cffi:defcfun ("_wrap_btConeShape_getRadius" CONE-SHAPE/GET-RADIUS) :float
  (self :pointer))

(export 'CONE-SHAPE/GET-RADIUS)

(declaim (inline CONE-SHAPE/GET-HEIGHT))

(cffi:defcfun ("_wrap_btConeShape_getHeight" CONE-SHAPE/GET-HEIGHT) :float
  (self :pointer))

(export 'CONE-SHAPE/GET-HEIGHT)

(declaim (inline CONE-SHAPE/CALCULATE-LOCAL-INERTIA))

(cffi:defcfun ("_wrap_btConeShape_calculateLocalInertia" CONE-SHAPE/CALCULATE-LOCAL-INERTIA) :void
  (self :pointer)
  (mass :float)
  (inertia :pointer))

(export 'CONE-SHAPE/CALCULATE-LOCAL-INERTIA)

(declaim (inline CONE-SHAPE/GET-NAME))

(cffi:defcfun ("_wrap_btConeShape_getName" CONE-SHAPE/GET-NAME) :string
  (self :pointer))

(export 'CONE-SHAPE/GET-NAME)

(declaim (inline CONE-SHAPE/SET-CONE-UP-INDEX))

(cffi:defcfun ("_wrap_btConeShape_setConeUpIndex" CONE-SHAPE/SET-CONE-UP-INDEX) :void
  (self :pointer)
  (upIndex :int))

(export 'CONE-SHAPE/SET-CONE-UP-INDEX)

(declaim (inline CONE-SHAPE/GET-CONE-UP-INDEX))

(cffi:defcfun ("_wrap_btConeShape_getConeUpIndex" CONE-SHAPE/GET-CONE-UP-INDEX) :int
  (self :pointer))

(export 'CONE-SHAPE/GET-CONE-UP-INDEX)

(declaim (inline CONE-SHAPE/GET-ANISOTROPIC-ROLLING-FRICTION-DIRECTION))

(cffi:defcfun ("_wrap_btConeShape_getAnisotropicRollingFrictionDirection" CONE-SHAPE/GET-ANISOTROPIC-ROLLING-FRICTION-DIRECTION) :pointer
  (self :pointer))

(export 'CONE-SHAPE/GET-ANISOTROPIC-ROLLING-FRICTION-DIRECTION)

(declaim (inline CONE-SHAPE/SET-LOCAL-SCALING))

(cffi:defcfun ("_wrap_btConeShape_setLocalScaling" CONE-SHAPE/SET-LOCAL-SCALING) :void
  (self :pointer)
  (scaling :pointer))

(export 'CONE-SHAPE/SET-LOCAL-SCALING)

(declaim (inline CONE-SHAPE/CALCULATE-SERIALIZE-BUFFER-SIZE))

(cffi:defcfun ("_wrap_btConeShape_calculateSerializeBufferSize" CONE-SHAPE/CALCULATE-SERIALIZE-BUFFER-SIZE) :int
  (self :pointer))

(export 'CONE-SHAPE/CALCULATE-SERIALIZE-BUFFER-SIZE)

(declaim (inline CONE-SHAPE/SERIALIZE))

(cffi:defcfun ("_wrap_btConeShape_serialize" CONE-SHAPE/SERIALIZE) :string
  (self :pointer)
  (dataBuffer :pointer)
  (serializer :pointer))

(export 'CONE-SHAPE/SERIALIZE)

(declaim (inline DELETE/BT-CONE-SHAPE))

(cffi:defcfun ("_wrap_delete_btConeShape" DELETE/BT-CONE-SHAPE) :void
  (self :pointer))

(export 'DELETE/BT-CONE-SHAPE)

(declaim (inline MAKE-CONE-SHAPE-X))

(cffi:defcfun ("_wrap_new_btConeShapeX" MAKE-CONE-SHAPE-X) :pointer
  (radius :float)
  (height :float))

(export 'MAKE-CONE-SHAPE-X)

(declaim (inline CONE-SHAPE-X/GET-ANISOTROPIC-ROLLING-FRICTION-DIRECTION))

(cffi:defcfun ("_wrap_btConeShapeX_getAnisotropicRollingFrictionDirection" CONE-SHAPE-X/GET-ANISOTROPIC-ROLLING-FRICTION-DIRECTION) :pointer
  (self :pointer))

(export 'CONE-SHAPE-X/GET-ANISOTROPIC-ROLLING-FRICTION-DIRECTION)

(declaim (inline CONE-SHAPE-X/GET-NAME))

(cffi:defcfun ("_wrap_btConeShapeX_getName" CONE-SHAPE-X/GET-NAME) :string
  (self :pointer))

(export 'CONE-SHAPE-X/GET-NAME)

(declaim (inline DELETE/BT-CONE-SHAPE-X))

(cffi:defcfun ("_wrap_delete_btConeShapeX" DELETE/BT-CONE-SHAPE-X) :void
  (self :pointer))

(export 'DELETE/BT-CONE-SHAPE-X)

(declaim (inline MAKE-CONE-SHAPE-Z))

(cffi:defcfun ("_wrap_new_btConeShapeZ" MAKE-CONE-SHAPE-Z) :pointer
  (radius :float)
  (height :float))

(export 'MAKE-CONE-SHAPE-Z)

(declaim (inline CONE-SHAPE-Z/GET-ANISOTROPIC-ROLLING-FRICTION-DIRECTION))

(cffi:defcfun ("_wrap_btConeShapeZ_getAnisotropicRollingFrictionDirection" CONE-SHAPE-Z/GET-ANISOTROPIC-ROLLING-FRICTION-DIRECTION) :pointer
  (self :pointer))

(export 'CONE-SHAPE-Z/GET-ANISOTROPIC-ROLLING-FRICTION-DIRECTION)

(declaim (inline CONE-SHAPE-Z/GET-NAME))

(cffi:defcfun ("_wrap_btConeShapeZ_getName" CONE-SHAPE-Z/GET-NAME) :string
  (self :pointer))

(export 'CONE-SHAPE-Z/GET-NAME)

(declaim (inline DELETE/BT-CONE-SHAPE-Z))

(cffi:defcfun ("_wrap_delete_btConeShapeZ" DELETE/BT-CONE-SHAPE-Z) :void
  (self :pointer))

(export 'DELETE/BT-CONE-SHAPE-Z)

(cffi:defcstruct CONE-SHAPE-DATA
  (CONVEX-INTERNAL-SHAPE-DATA :pointer)
  (UP-INDEX :int)
  (PADDING :pointer))

(export 'CONE-SHAPE-DATA)

(export 'CONVEX-INTERNAL-SHAPE-DATA)

(export 'UP-INDEX)

(export 'PADDING)

(declaim (inline STATIC-PLANE-SHAPE/MAKE-CPLUS-PLUS-INSTANCE))

(cffi:defcfun ("_wrap_btStaticPlaneShape_makeCPlusPlusInstance__SWIG_0" STATIC-PLANE-SHAPE/MAKE-CPLUS-PLUS-INSTANCE) :pointer
  (self :pointer)
  (sizeInBytes :pointer))

(export 'STATIC-PLANE-SHAPE/MAKE-CPLUS-PLUS-INSTANCE)

(declaim (inline STATIC-PLANE-SHAPE/DELETE-CPLUS-PLUS-INSTANCE))

(cffi:defcfun ("_wrap_btStaticPlaneShape_deleteCPlusPlusInstance__SWIG_0" STATIC-PLANE-SHAPE/DELETE-CPLUS-PLUS-INSTANCE) :void
  (self :pointer)
  (ptr :pointer))

(export 'STATIC-PLANE-SHAPE/DELETE-CPLUS-PLUS-INSTANCE)

(declaim (inline STATIC-PLANE-SHAPE/MAKE-CPLUS-PLUS-INSTANCE))

(cffi:defcfun ("_wrap_btStaticPlaneShape_makeCPlusPlusInstance__SWIG_1" STATIC-PLANE-SHAPE/MAKE-CPLUS-PLUS-INSTANCE) :pointer
  (self :pointer)
  (arg1 :pointer)
  (ptr :pointer))

(export 'STATIC-PLANE-SHAPE/MAKE-CPLUS-PLUS-INSTANCE)

(declaim (inline STATIC-PLANE-SHAPE/DELETE-CPLUS-PLUS-INSTANCE))

(cffi:defcfun ("_wrap_btStaticPlaneShape_deleteCPlusPlusInstance__SWIG_1" STATIC-PLANE-SHAPE/DELETE-CPLUS-PLUS-INSTANCE) :void
  (self :pointer)
  (arg1 :pointer)
  (arg2 :pointer))

(export 'STATIC-PLANE-SHAPE/DELETE-CPLUS-PLUS-INSTANCE)

(declaim (inline STATIC-PLANE-SHAPE/MAKE-CPLUS-ARRAY))

(cffi:defcfun ("_wrap_btStaticPlaneShape_makeCPlusArray__SWIG_0" STATIC-PLANE-SHAPE/MAKE-CPLUS-ARRAY) :pointer
  (self :pointer)
  (sizeInBytes :pointer))

(export 'STATIC-PLANE-SHAPE/MAKE-CPLUS-ARRAY)

(declaim (inline STATIC-PLANE-SHAPE/DELETE-CPLUS-ARRAY))

(cffi:defcfun ("_wrap_btStaticPlaneShape_deleteCPlusArray__SWIG_0" STATIC-PLANE-SHAPE/DELETE-CPLUS-ARRAY) :void
  (self :pointer)
  (ptr :pointer))

(export 'STATIC-PLANE-SHAPE/DELETE-CPLUS-ARRAY)

(declaim (inline STATIC-PLANE-SHAPE/MAKE-CPLUS-ARRAY))

(cffi:defcfun ("_wrap_btStaticPlaneShape_makeCPlusArray__SWIG_1" STATIC-PLANE-SHAPE/MAKE-CPLUS-ARRAY) :pointer
  (self :pointer)
  (arg1 :pointer)
  (ptr :pointer))

(export 'STATIC-PLANE-SHAPE/MAKE-CPLUS-ARRAY)

(declaim (inline STATIC-PLANE-SHAPE/DELETE-CPLUS-ARRAY))

(cffi:defcfun ("_wrap_btStaticPlaneShape_deleteCPlusArray__SWIG_1" STATIC-PLANE-SHAPE/DELETE-CPLUS-ARRAY) :void
  (self :pointer)
  (arg1 :pointer)
  (arg2 :pointer))

(export 'STATIC-PLANE-SHAPE/DELETE-CPLUS-ARRAY)

(declaim (inline MAKE-STATIC-PLANE-SHAPE))

(cffi:defcfun ("_wrap_new_btStaticPlaneShape" MAKE-STATIC-PLANE-SHAPE) :pointer
  (planeNormal :pointer)
  (planeConstant :float))

(export 'MAKE-STATIC-PLANE-SHAPE)

(declaim (inline DELETE/BT-STATIC-PLANE-SHAPE))

(cffi:defcfun ("_wrap_delete_btStaticPlaneShape" DELETE/BT-STATIC-PLANE-SHAPE) :void
  (self :pointer))

(export 'DELETE/BT-STATIC-PLANE-SHAPE)

(declaim (inline STATIC-PLANE-SHAPE/GET-AABB))

(cffi:defcfun ("_wrap_btStaticPlaneShape_getAabb" STATIC-PLANE-SHAPE/GET-AABB) :void
  (self :pointer)
  (t_arg1 :pointer)
  (aabbMin :pointer)
  (aabbMax :pointer))

(export 'STATIC-PLANE-SHAPE/GET-AABB)

(declaim (inline STATIC-PLANE-SHAPE/PROCESS-ALL-TRIANGLES))

(cffi:defcfun ("_wrap_btStaticPlaneShape_processAllTriangles" STATIC-PLANE-SHAPE/PROCESS-ALL-TRIANGLES) :void
  (self :pointer)
  (callback :pointer)
  (aabbMin :pointer)
  (aabbMax :pointer))

(export 'STATIC-PLANE-SHAPE/PROCESS-ALL-TRIANGLES)

(declaim (inline STATIC-PLANE-SHAPE/CALCULATE-LOCAL-INERTIA))

(cffi:defcfun ("_wrap_btStaticPlaneShape_calculateLocalInertia" STATIC-PLANE-SHAPE/CALCULATE-LOCAL-INERTIA) :void
  (self :pointer)
  (mass :float)
  (inertia :pointer))

(export 'STATIC-PLANE-SHAPE/CALCULATE-LOCAL-INERTIA)

(declaim (inline STATIC-PLANE-SHAPE/SET-LOCAL-SCALING))

(cffi:defcfun ("_wrap_btStaticPlaneShape_setLocalScaling" STATIC-PLANE-SHAPE/SET-LOCAL-SCALING) :void
  (self :pointer)
  (scaling :pointer))

(export 'STATIC-PLANE-SHAPE/SET-LOCAL-SCALING)

(declaim (inline STATIC-PLANE-SHAPE/GET-LOCAL-SCALING))

(cffi:defcfun ("_wrap_btStaticPlaneShape_getLocalScaling" STATIC-PLANE-SHAPE/GET-LOCAL-SCALING) :pointer
  (self :pointer))

(export 'STATIC-PLANE-SHAPE/GET-LOCAL-SCALING)

(declaim (inline STATIC-PLANE-SHAPE/GET-PLANE-NORMAL))

(cffi:defcfun ("_wrap_btStaticPlaneShape_getPlaneNormal" STATIC-PLANE-SHAPE/GET-PLANE-NORMAL) :pointer
  (self :pointer))

(export 'STATIC-PLANE-SHAPE/GET-PLANE-NORMAL)

(declaim (inline STATIC-PLANE-SHAPE/GET-PLANE-CONSTANT))

(cffi:defcfun ("_wrap_btStaticPlaneShape_getPlaneConstant" STATIC-PLANE-SHAPE/GET-PLANE-CONSTANT) :pointer
  (self :pointer))

(export 'STATIC-PLANE-SHAPE/GET-PLANE-CONSTANT)

(declaim (inline STATIC-PLANE-SHAPE/GET-NAME))

(cffi:defcfun ("_wrap_btStaticPlaneShape_getName" STATIC-PLANE-SHAPE/GET-NAME) :string
  (self :pointer))

(export 'STATIC-PLANE-SHAPE/GET-NAME)

(declaim (inline STATIC-PLANE-SHAPE/CALCULATE-SERIALIZE-BUFFER-SIZE))

(cffi:defcfun ("_wrap_btStaticPlaneShape_calculateSerializeBufferSize" STATIC-PLANE-SHAPE/CALCULATE-SERIALIZE-BUFFER-SIZE) :int
  (self :pointer))

(export 'STATIC-PLANE-SHAPE/CALCULATE-SERIALIZE-BUFFER-SIZE)

(declaim (inline STATIC-PLANE-SHAPE/SERIALIZE))

(cffi:defcfun ("_wrap_btStaticPlaneShape_serialize" STATIC-PLANE-SHAPE/SERIALIZE) :string
  (self :pointer)
  (dataBuffer :pointer)
  (serializer :pointer))

(export 'STATIC-PLANE-SHAPE/SERIALIZE)

(cffi:defcstruct STATIC-PLANE-SHAPE-DATA
  (COLLISION-SHAPE-DATA :pointer)
  (LOCAL-SCALING VECTOR-3-FLOAT-DATA)
  (PLANE-NORMAL VECTOR-3-FLOAT-DATA)
  (PLANE-CONSTANT :float)
  (PAD :pointer))

(export 'STATIC-PLANE-SHAPE-DATA)

(export 'COLLISION-SHAPE-DATA)

(export 'LOCAL-SCALING)

(export 'PLANE-NORMAL)

(export 'PLANE-CONSTANT)

(export 'PAD)

(declaim (inline CONVEX-HULL-SHAPE/MAKE-CPLUS-PLUS-INSTANCE))

(cffi:defcfun ("_wrap_btConvexHullShape_makeCPlusPlusInstance__SWIG_0" CONVEX-HULL-SHAPE/MAKE-CPLUS-PLUS-INSTANCE) :pointer
  (self :pointer)
  (sizeInBytes :pointer))

(export 'CONVEX-HULL-SHAPE/MAKE-CPLUS-PLUS-INSTANCE)

(declaim (inline CONVEX-HULL-SHAPE/DELETE-CPLUS-PLUS-INSTANCE))

(cffi:defcfun ("_wrap_btConvexHullShape_deleteCPlusPlusInstance__SWIG_0" CONVEX-HULL-SHAPE/DELETE-CPLUS-PLUS-INSTANCE) :void
  (self :pointer)
  (ptr :pointer))

(export 'CONVEX-HULL-SHAPE/DELETE-CPLUS-PLUS-INSTANCE)

(declaim (inline CONVEX-HULL-SHAPE/MAKE-CPLUS-PLUS-INSTANCE))

(cffi:defcfun ("_wrap_btConvexHullShape_makeCPlusPlusInstance__SWIG_1" CONVEX-HULL-SHAPE/MAKE-CPLUS-PLUS-INSTANCE) :pointer
  (self :pointer)
  (arg1 :pointer)
  (ptr :pointer))

(export 'CONVEX-HULL-SHAPE/MAKE-CPLUS-PLUS-INSTANCE)

(declaim (inline CONVEX-HULL-SHAPE/DELETE-CPLUS-PLUS-INSTANCE))

(cffi:defcfun ("_wrap_btConvexHullShape_deleteCPlusPlusInstance__SWIG_1" CONVEX-HULL-SHAPE/DELETE-CPLUS-PLUS-INSTANCE) :void
  (self :pointer)
  (arg1 :pointer)
  (arg2 :pointer))

(export 'CONVEX-HULL-SHAPE/DELETE-CPLUS-PLUS-INSTANCE)

(declaim (inline CONVEX-HULL-SHAPE/MAKE-CPLUS-ARRAY))

(cffi:defcfun ("_wrap_btConvexHullShape_makeCPlusArray__SWIG_0" CONVEX-HULL-SHAPE/MAKE-CPLUS-ARRAY) :pointer
  (self :pointer)
  (sizeInBytes :pointer))

(export 'CONVEX-HULL-SHAPE/MAKE-CPLUS-ARRAY)

(declaim (inline CONVEX-HULL-SHAPE/DELETE-CPLUS-ARRAY))

(cffi:defcfun ("_wrap_btConvexHullShape_deleteCPlusArray__SWIG_0" CONVEX-HULL-SHAPE/DELETE-CPLUS-ARRAY) :void
  (self :pointer)
  (ptr :pointer))

(export 'CONVEX-HULL-SHAPE/DELETE-CPLUS-ARRAY)

(declaim (inline CONVEX-HULL-SHAPE/MAKE-CPLUS-ARRAY))

(cffi:defcfun ("_wrap_btConvexHullShape_makeCPlusArray__SWIG_1" CONVEX-HULL-SHAPE/MAKE-CPLUS-ARRAY) :pointer
  (self :pointer)
  (arg1 :pointer)
  (ptr :pointer))

(export 'CONVEX-HULL-SHAPE/MAKE-CPLUS-ARRAY)

(declaim (inline CONVEX-HULL-SHAPE/DELETE-CPLUS-ARRAY))

(cffi:defcfun ("_wrap_btConvexHullShape_deleteCPlusArray__SWIG_1" CONVEX-HULL-SHAPE/DELETE-CPLUS-ARRAY) :void
  (self :pointer)
  (arg1 :pointer)
  (arg2 :pointer))

(export 'CONVEX-HULL-SHAPE/DELETE-CPLUS-ARRAY)

(declaim (inline MAKE-CONVEX-HULL-SHAPE))

(cffi:defcfun ("_wrap_new_btConvexHullShape__SWIG_0" MAKE-CONVEX-HULL-SHAPE) :pointer
  (points :pointer)
  (numPoints :int)
  (stride :int))

(export 'MAKE-CONVEX-HULL-SHAPE)

(declaim (inline MAKE-CONVEX-HULL-SHAPE))

(cffi:defcfun ("_wrap_new_btConvexHullShape__SWIG_1" MAKE-CONVEX-HULL-SHAPE) :pointer
  (points :pointer)
  (numPoints :int))

(export 'MAKE-CONVEX-HULL-SHAPE)

(declaim (inline MAKE-CONVEX-HULL-SHAPE))

(cffi:defcfun ("_wrap_new_btConvexHullShape__SWIG_2" MAKE-CONVEX-HULL-SHAPE) :pointer
  (points :pointer))

(export 'MAKE-CONVEX-HULL-SHAPE)

(declaim (inline MAKE-CONVEX-HULL-SHAPE))

(cffi:defcfun ("_wrap_new_btConvexHullShape__SWIG_3" MAKE-CONVEX-HULL-SHAPE) :pointer)

(export 'MAKE-CONVEX-HULL-SHAPE)

(declaim (inline CONVEX-HULL-SHAPE/ADD-POINT))

(cffi:defcfun ("_wrap_btConvexHullShape_addPoint__SWIG_0" CONVEX-HULL-SHAPE/ADD-POINT) :void
  (self :pointer)
  (point :pointer)
  (recalculateLocalAabb :pointer))

(export 'CONVEX-HULL-SHAPE/ADD-POINT)

(declaim (inline CONVEX-HULL-SHAPE/ADD-POINT))

(cffi:defcfun ("_wrap_btConvexHullShape_addPoint__SWIG_1" CONVEX-HULL-SHAPE/ADD-POINT) :void
  (self :pointer)
  (point :pointer))

(export 'CONVEX-HULL-SHAPE/ADD-POINT)

(declaim (inline CONVEX-HULL-SHAPE/GET-UNSCALED-POINTS))

(cffi:defcfun ("_wrap_btConvexHullShape_getUnscaledPoints__SWIG_0" CONVEX-HULL-SHAPE/GET-UNSCALED-POINTS) :pointer
  (self :pointer))

(export 'CONVEX-HULL-SHAPE/GET-UNSCALED-POINTS)

(declaim (inline CONVEX-HULL-SHAPE/GET-UNSCALED-POINTS))

(cffi:defcfun ("_wrap_btConvexHullShape_getUnscaledPoints__SWIG_1" CONVEX-HULL-SHAPE/GET-UNSCALED-POINTS) :pointer
  (self :pointer))

(export 'CONVEX-HULL-SHAPE/GET-UNSCALED-POINTS)

(declaim (inline CONVEX-HULL-SHAPE/GET-POINTS))

(cffi:defcfun ("_wrap_btConvexHullShape_getPoints" CONVEX-HULL-SHAPE/GET-POINTS) :pointer
  (self :pointer))

(export 'CONVEX-HULL-SHAPE/GET-POINTS)

(declaim (inline CONVEX-HULL-SHAPE/GET-SCALED-POINT))

(cffi:defcfun ("_wrap_btConvexHullShape_getScaledPoint" CONVEX-HULL-SHAPE/GET-SCALED-POINT) :pointer
  (self :pointer)
  (i :int))

(export 'CONVEX-HULL-SHAPE/GET-SCALED-POINT)

(declaim (inline CONVEX-HULL-SHAPE/GET-NUM-POINTS))

(cffi:defcfun ("_wrap_btConvexHullShape_getNumPoints" CONVEX-HULL-SHAPE/GET-NUM-POINTS) :int
  (self :pointer))

(export 'CONVEX-HULL-SHAPE/GET-NUM-POINTS)

(declaim (inline CONVEX-HULL-SHAPE/LOCAL-GET-SUPPORTING-VERTEX))

(cffi:defcfun ("_wrap_btConvexHullShape_localGetSupportingVertex" CONVEX-HULL-SHAPE/LOCAL-GET-SUPPORTING-VERTEX) :pointer
  (self :pointer)
  (vec :pointer))

(export 'CONVEX-HULL-SHAPE/LOCAL-GET-SUPPORTING-VERTEX)

(declaim (inline CONVEX-HULL-SHAPE/LOCAL-GET-SUPPORTING-VERTEX-WITHOUT-MARGIN))

(cffi:defcfun ("_wrap_btConvexHullShape_localGetSupportingVertexWithoutMargin" CONVEX-HULL-SHAPE/LOCAL-GET-SUPPORTING-VERTEX-WITHOUT-MARGIN) :pointer
  (self :pointer)
  (vec :pointer))

(export 'CONVEX-HULL-SHAPE/LOCAL-GET-SUPPORTING-VERTEX-WITHOUT-MARGIN)

(declaim (inline CONVEX-HULL-SHAPE/BATCHED-UNIT-VECTOR-GET-SUPPORTING-VERTEX-WITHOUT-MARGIN))

(cffi:defcfun ("_wrap_btConvexHullShape_batchedUnitVectorGetSupportingVertexWithoutMargin" CONVEX-HULL-SHAPE/BATCHED-UNIT-VECTOR-GET-SUPPORTING-VERTEX-WITHOUT-MARGIN) :void
  (self :pointer)
  (vectors :pointer)
  (supportVerticesOut :pointer)
  (numVectors :int))

(export 'CONVEX-HULL-SHAPE/BATCHED-UNIT-VECTOR-GET-SUPPORTING-VERTEX-WITHOUT-MARGIN)

(declaim (inline CONVEX-HULL-SHAPE/PROJECT))

(cffi:defcfun ("_wrap_btConvexHullShape_project" CONVEX-HULL-SHAPE/PROJECT) :void
  (self :pointer)
  (trans :pointer)
  (dir :pointer)
  (minProj :pointer)
  (maxProj :pointer)
  (witnesPtMin :pointer)
  (witnesPtMax :pointer))

(export 'CONVEX-HULL-SHAPE/PROJECT)

(declaim (inline CONVEX-HULL-SHAPE/GET-NAME))

(cffi:defcfun ("_wrap_btConvexHullShape_getName" CONVEX-HULL-SHAPE/GET-NAME) :string
  (self :pointer))

(export 'CONVEX-HULL-SHAPE/GET-NAME)

(declaim (inline CONVEX-HULL-SHAPE/GET-NUM-VERTICES))

(cffi:defcfun ("_wrap_btConvexHullShape_getNumVertices" CONVEX-HULL-SHAPE/GET-NUM-VERTICES) :int
  (self :pointer))

(export 'CONVEX-HULL-SHAPE/GET-NUM-VERTICES)

(declaim (inline CONVEX-HULL-SHAPE/GET-NUM-EDGES))

(cffi:defcfun ("_wrap_btConvexHullShape_getNumEdges" CONVEX-HULL-SHAPE/GET-NUM-EDGES) :int
  (self :pointer))

(export 'CONVEX-HULL-SHAPE/GET-NUM-EDGES)

(declaim (inline CONVEX-HULL-SHAPE/GET-EDGE))

(cffi:defcfun ("_wrap_btConvexHullShape_getEdge" CONVEX-HULL-SHAPE/GET-EDGE) :void
  (self :pointer)
  (i :int)
  (pa :pointer)
  (pb :pointer))

(export 'CONVEX-HULL-SHAPE/GET-EDGE)

(declaim (inline CONVEX-HULL-SHAPE/GET-VERTEX))

(cffi:defcfun ("_wrap_btConvexHullShape_getVertex" CONVEX-HULL-SHAPE/GET-VERTEX) :void
  (self :pointer)
  (i :int)
  (vtx :pointer))

(export 'CONVEX-HULL-SHAPE/GET-VERTEX)

(declaim (inline CONVEX-HULL-SHAPE/GET-NUM-PLANES))

(cffi:defcfun ("_wrap_btConvexHullShape_getNumPlanes" CONVEX-HULL-SHAPE/GET-NUM-PLANES) :int
  (self :pointer))

(export 'CONVEX-HULL-SHAPE/GET-NUM-PLANES)

(declaim (inline CONVEX-HULL-SHAPE/GET-PLANE))

(cffi:defcfun ("_wrap_btConvexHullShape_getPlane" CONVEX-HULL-SHAPE/GET-PLANE) :void
  (self :pointer)
  (planeNormal :pointer)
  (planeSupport :pointer)
  (i :int))

(export 'CONVEX-HULL-SHAPE/GET-PLANE)

(declaim (inline CONVEX-HULL-SHAPE/IS-INSIDE))

(cffi:defcfun ("_wrap_btConvexHullShape_isInside" CONVEX-HULL-SHAPE/IS-INSIDE) :pointer
  (self :pointer)
  (pt :pointer)
  (tolerance :float))

(export 'CONVEX-HULL-SHAPE/IS-INSIDE)

(declaim (inline CONVEX-HULL-SHAPE/SET-LOCAL-SCALING))

(cffi:defcfun ("_wrap_btConvexHullShape_setLocalScaling" CONVEX-HULL-SHAPE/SET-LOCAL-SCALING) :void
  (self :pointer)
  (scaling :pointer))

(export 'CONVEX-HULL-SHAPE/SET-LOCAL-SCALING)

(declaim (inline CONVEX-HULL-SHAPE/CALCULATE-SERIALIZE-BUFFER-SIZE))

(cffi:defcfun ("_wrap_btConvexHullShape_calculateSerializeBufferSize" CONVEX-HULL-SHAPE/CALCULATE-SERIALIZE-BUFFER-SIZE) :int
  (self :pointer))

(export 'CONVEX-HULL-SHAPE/CALCULATE-SERIALIZE-BUFFER-SIZE)

(declaim (inline CONVEX-HULL-SHAPE/SERIALIZE))

(cffi:defcfun ("_wrap_btConvexHullShape_serialize" CONVEX-HULL-SHAPE/SERIALIZE) :string
  (self :pointer)
  (dataBuffer :pointer)
  (serializer :pointer))

(export 'CONVEX-HULL-SHAPE/SERIALIZE)

(declaim (inline DELETE/BT-CONVEX-HULL-SHAPE))

(cffi:defcfun ("_wrap_delete_btConvexHullShape" DELETE/BT-CONVEX-HULL-SHAPE) :void
  (self :pointer))

(export 'DELETE/BT-CONVEX-HULL-SHAPE)

(cffi:defcstruct CONVEX-HULL-SHAPE-DATA
  (CONVEX-INTERNAL-SHAPE-DATA :pointer)
  (UNSCALED-POINTS-FLOAT-PTR :pointer)
  (UNSCALED-POINTS-DOUBLE-PTR :pointer)
  (NUM-UNSCALED-POINTS :int)
  (PADDING-3 :pointer))

(export 'CONVEX-HULL-SHAPE-DATA)

(export 'CONVEX-INTERNAL-SHAPE-DATA)

(export 'UNSCALED-POINTS-FLOAT-PTR)

(export 'UNSCALED-POINTS-DOUBLE-PTR)

(export 'NUM-UNSCALED-POINTS)

(export 'PADDING-3)

(declaim (inline TRIANGLE-MESH/M/WELDING-THRESHOLD/SET))

(cffi:defcfun ("_wrap_btTriangleMesh_m_weldingThreshold_set" TRIANGLE-MESH/M/WELDING-THRESHOLD/SET) :void
  (self :pointer)
  (m_weldingThreshold :float))

(export 'TRIANGLE-MESH/M/WELDING-THRESHOLD/SET)

(declaim (inline TRIANGLE-MESH/M/WELDING-THRESHOLD/GET))

(cffi:defcfun ("_wrap_btTriangleMesh_m_weldingThreshold_get" TRIANGLE-MESH/M/WELDING-THRESHOLD/GET) :float
  (self :pointer))

(export 'TRIANGLE-MESH/M/WELDING-THRESHOLD/GET)

(declaim (inline MAKE-TRIANGLE-MESH))

(cffi:defcfun ("_wrap_new_btTriangleMesh__SWIG_0" MAKE-TRIANGLE-MESH) :pointer
  (use32bitIndices :pointer)
  (use4componentVertices :pointer))

(export 'MAKE-TRIANGLE-MESH)

(declaim (inline MAKE-TRIANGLE-MESH))

(cffi:defcfun ("_wrap_new_btTriangleMesh__SWIG_1" MAKE-TRIANGLE-MESH) :pointer
  (use32bitIndices :pointer))

(export 'MAKE-TRIANGLE-MESH)

(declaim (inline MAKE-TRIANGLE-MESH))

(cffi:defcfun ("_wrap_new_btTriangleMesh__SWIG_2" MAKE-TRIANGLE-MESH) :pointer)

(export 'MAKE-TRIANGLE-MESH)

(declaim (inline TRIANGLE-MESH/GET-USE-32BIT-INDICES))

(cffi:defcfun ("_wrap_btTriangleMesh_getUse32bitIndices" TRIANGLE-MESH/GET-USE-32BIT-INDICES) :pointer
  (self :pointer))

(export 'TRIANGLE-MESH/GET-USE-32BIT-INDICES)

(declaim (inline TRIANGLE-MESH/GET-USE-4COMPONENT-VERTICES))

(cffi:defcfun ("_wrap_btTriangleMesh_getUse4componentVertices" TRIANGLE-MESH/GET-USE-4COMPONENT-VERTICES) :pointer
  (self :pointer))

(export 'TRIANGLE-MESH/GET-USE-4COMPONENT-VERTICES)

(declaim (inline TRIANGLE-MESH/ADD-TRIANGLE))

(cffi:defcfun ("_wrap_btTriangleMesh_addTriangle__SWIG_0" TRIANGLE-MESH/ADD-TRIANGLE) :void
  (self :pointer)
  (vertex0 :pointer)
  (vertex1 :pointer)
  (vertex2 :pointer)
  (removeDuplicateVertices :pointer))

(export 'TRIANGLE-MESH/ADD-TRIANGLE)

(declaim (inline TRIANGLE-MESH/ADD-TRIANGLE))

(cffi:defcfun ("_wrap_btTriangleMesh_addTriangle__SWIG_1" TRIANGLE-MESH/ADD-TRIANGLE) :void
  (self :pointer)
  (vertex0 :pointer)
  (vertex1 :pointer)
  (vertex2 :pointer))

(export 'TRIANGLE-MESH/ADD-TRIANGLE)

(declaim (inline TRIANGLE-MESH/GET-NUM-TRIANGLES))

(cffi:defcfun ("_wrap_btTriangleMesh_getNumTriangles" TRIANGLE-MESH/GET-NUM-TRIANGLES) :int
  (self :pointer))

(export 'TRIANGLE-MESH/GET-NUM-TRIANGLES)

(declaim (inline TRIANGLE-MESH/PREALLOCATE-VERTICES))

(cffi:defcfun ("_wrap_btTriangleMesh_preallocateVertices" TRIANGLE-MESH/PREALLOCATE-VERTICES) :void
  (self :pointer)
  (numverts :int))

(export 'TRIANGLE-MESH/PREALLOCATE-VERTICES)

(declaim (inline TRIANGLE-MESH/PREALLOCATE-INDICES))

(cffi:defcfun ("_wrap_btTriangleMesh_preallocateIndices" TRIANGLE-MESH/PREALLOCATE-INDICES) :void
  (self :pointer)
  (numindices :int))

(export 'TRIANGLE-MESH/PREALLOCATE-INDICES)

(declaim (inline TRIANGLE-MESH/FIND-OR-ADD-VERTEX))

(cffi:defcfun ("_wrap_btTriangleMesh_findOrAddVertex" TRIANGLE-MESH/FIND-OR-ADD-VERTEX) :int
  (self :pointer)
  (vertex :pointer)
  (removeDuplicateVertices :pointer))

(export 'TRIANGLE-MESH/FIND-OR-ADD-VERTEX)

(declaim (inline TRIANGLE-MESH/ADD-INDEX))

(cffi:defcfun ("_wrap_btTriangleMesh_addIndex" TRIANGLE-MESH/ADD-INDEX) :void
  (self :pointer)
  (index :int))

(export 'TRIANGLE-MESH/ADD-INDEX)

(declaim (inline DELETE/BT-TRIANGLE-MESH))

(cffi:defcfun ("_wrap_delete_btTriangleMesh" DELETE/BT-TRIANGLE-MESH) :void
  (self :pointer))

(export 'DELETE/BT-TRIANGLE-MESH)

(declaim (inline CONVEX-TRIANGLE-MESH-SHAPE/MAKE-CPLUS-PLUS-INSTANCE))

(cffi:defcfun ("_wrap_btConvexTriangleMeshShape_makeCPlusPlusInstance__SWIG_0" CONVEX-TRIANGLE-MESH-SHAPE/MAKE-CPLUS-PLUS-INSTANCE) :pointer
  (self :pointer)
  (sizeInBytes :pointer))

(export 'CONVEX-TRIANGLE-MESH-SHAPE/MAKE-CPLUS-PLUS-INSTANCE)

(declaim (inline CONVEX-TRIANGLE-MESH-SHAPE/DELETE-CPLUS-PLUS-INSTANCE))

(cffi:defcfun ("_wrap_btConvexTriangleMeshShape_deleteCPlusPlusInstance__SWIG_0" CONVEX-TRIANGLE-MESH-SHAPE/DELETE-CPLUS-PLUS-INSTANCE) :void
  (self :pointer)
  (ptr :pointer))

(export 'CONVEX-TRIANGLE-MESH-SHAPE/DELETE-CPLUS-PLUS-INSTANCE)

(declaim (inline CONVEX-TRIANGLE-MESH-SHAPE/MAKE-CPLUS-PLUS-INSTANCE))

(cffi:defcfun ("_wrap_btConvexTriangleMeshShape_makeCPlusPlusInstance__SWIG_1" CONVEX-TRIANGLE-MESH-SHAPE/MAKE-CPLUS-PLUS-INSTANCE) :pointer
  (self :pointer)
  (arg1 :pointer)
  (ptr :pointer))

(export 'CONVEX-TRIANGLE-MESH-SHAPE/MAKE-CPLUS-PLUS-INSTANCE)

(declaim (inline CONVEX-TRIANGLE-MESH-SHAPE/DELETE-CPLUS-PLUS-INSTANCE))

(cffi:defcfun ("_wrap_btConvexTriangleMeshShape_deleteCPlusPlusInstance__SWIG_1" CONVEX-TRIANGLE-MESH-SHAPE/DELETE-CPLUS-PLUS-INSTANCE) :void
  (self :pointer)
  (arg1 :pointer)
  (arg2 :pointer))

(export 'CONVEX-TRIANGLE-MESH-SHAPE/DELETE-CPLUS-PLUS-INSTANCE)

(declaim (inline CONVEX-TRIANGLE-MESH-SHAPE/MAKE-CPLUS-ARRAY))

(cffi:defcfun ("_wrap_btConvexTriangleMeshShape_makeCPlusArray__SWIG_0" CONVEX-TRIANGLE-MESH-SHAPE/MAKE-CPLUS-ARRAY) :pointer
  (self :pointer)
  (sizeInBytes :pointer))

(export 'CONVEX-TRIANGLE-MESH-SHAPE/MAKE-CPLUS-ARRAY)

(declaim (inline CONVEX-TRIANGLE-MESH-SHAPE/DELETE-CPLUS-ARRAY))

(cffi:defcfun ("_wrap_btConvexTriangleMeshShape_deleteCPlusArray__SWIG_0" CONVEX-TRIANGLE-MESH-SHAPE/DELETE-CPLUS-ARRAY) :void
  (self :pointer)
  (ptr :pointer))

(export 'CONVEX-TRIANGLE-MESH-SHAPE/DELETE-CPLUS-ARRAY)

(declaim (inline CONVEX-TRIANGLE-MESH-SHAPE/MAKE-CPLUS-ARRAY))

(cffi:defcfun ("_wrap_btConvexTriangleMeshShape_makeCPlusArray__SWIG_1" CONVEX-TRIANGLE-MESH-SHAPE/MAKE-CPLUS-ARRAY) :pointer
  (self :pointer)
  (arg1 :pointer)
  (ptr :pointer))

(export 'CONVEX-TRIANGLE-MESH-SHAPE/MAKE-CPLUS-ARRAY)

(declaim (inline CONVEX-TRIANGLE-MESH-SHAPE/DELETE-CPLUS-ARRAY))

(cffi:defcfun ("_wrap_btConvexTriangleMeshShape_deleteCPlusArray__SWIG_1" CONVEX-TRIANGLE-MESH-SHAPE/DELETE-CPLUS-ARRAY) :void
  (self :pointer)
  (arg1 :pointer)
  (arg2 :pointer))

(export 'CONVEX-TRIANGLE-MESH-SHAPE/DELETE-CPLUS-ARRAY)

(declaim (inline MAKE-CONVEX-TRIANGLE-MESH-SHAPE))

(cffi:defcfun ("_wrap_new_btConvexTriangleMeshShape__SWIG_0" MAKE-CONVEX-TRIANGLE-MESH-SHAPE) :pointer
  (meshInterface :pointer)
  (calcAabb :pointer))

(export 'MAKE-CONVEX-TRIANGLE-MESH-SHAPE)

(declaim (inline MAKE-CONVEX-TRIANGLE-MESH-SHAPE))

(cffi:defcfun ("_wrap_new_btConvexTriangleMeshShape__SWIG_1" MAKE-CONVEX-TRIANGLE-MESH-SHAPE) :pointer
  (meshInterface :pointer))

(export 'MAKE-CONVEX-TRIANGLE-MESH-SHAPE)

(declaim (inline CONVEX-TRIANGLE-MESH-SHAPE/GET-MESH-INTERFACE))

(cffi:defcfun ("_wrap_btConvexTriangleMeshShape_getMeshInterface__SWIG_0" CONVEX-TRIANGLE-MESH-SHAPE/GET-MESH-INTERFACE) :pointer
  (self :pointer))

(export 'CONVEX-TRIANGLE-MESH-SHAPE/GET-MESH-INTERFACE)

(declaim (inline CONVEX-TRIANGLE-MESH-SHAPE/GET-MESH-INTERFACE))

(cffi:defcfun ("_wrap_btConvexTriangleMeshShape_getMeshInterface__SWIG_1" CONVEX-TRIANGLE-MESH-SHAPE/GET-MESH-INTERFACE) :pointer
  (self :pointer))

(export 'CONVEX-TRIANGLE-MESH-SHAPE/GET-MESH-INTERFACE)

(declaim (inline CONVEX-TRIANGLE-MESH-SHAPE/LOCAL-GET-SUPPORTING-VERTEX))

(cffi:defcfun ("_wrap_btConvexTriangleMeshShape_localGetSupportingVertex" CONVEX-TRIANGLE-MESH-SHAPE/LOCAL-GET-SUPPORTING-VERTEX) :pointer
  (self :pointer)
  (vec :pointer))

(export 'CONVEX-TRIANGLE-MESH-SHAPE/LOCAL-GET-SUPPORTING-VERTEX)

(declaim (inline CONVEX-TRIANGLE-MESH-SHAPE/LOCAL-GET-SUPPORTING-VERTEX-WITHOUT-MARGIN))

(cffi:defcfun ("_wrap_btConvexTriangleMeshShape_localGetSupportingVertexWithoutMargin" CONVEX-TRIANGLE-MESH-SHAPE/LOCAL-GET-SUPPORTING-VERTEX-WITHOUT-MARGIN) :pointer
  (self :pointer)
  (vec :pointer))

(export 'CONVEX-TRIANGLE-MESH-SHAPE/LOCAL-GET-SUPPORTING-VERTEX-WITHOUT-MARGIN)

(declaim (inline CONVEX-TRIANGLE-MESH-SHAPE/BATCHED-UNIT-VECTOR-GET-SUPPORTING-VERTEX-WITHOUT-MARGIN))

(cffi:defcfun ("_wrap_btConvexTriangleMeshShape_batchedUnitVectorGetSupportingVertexWithoutMargin" CONVEX-TRIANGLE-MESH-SHAPE/BATCHED-UNIT-VECTOR-GET-SUPPORTING-VERTEX-WITHOUT-MARGIN) :void
  (self :pointer)
  (vectors :pointer)
  (supportVerticesOut :pointer)
  (numVectors :int))

(export 'CONVEX-TRIANGLE-MESH-SHAPE/BATCHED-UNIT-VECTOR-GET-SUPPORTING-VERTEX-WITHOUT-MARGIN)

(declaim (inline CONVEX-TRIANGLE-MESH-SHAPE/GET-NAME))

(cffi:defcfun ("_wrap_btConvexTriangleMeshShape_getName" CONVEX-TRIANGLE-MESH-SHAPE/GET-NAME) :string
  (self :pointer))

(export 'CONVEX-TRIANGLE-MESH-SHAPE/GET-NAME)

(declaim (inline CONVEX-TRIANGLE-MESH-SHAPE/GET-NUM-VERTICES))

(cffi:defcfun ("_wrap_btConvexTriangleMeshShape_getNumVertices" CONVEX-TRIANGLE-MESH-SHAPE/GET-NUM-VERTICES) :int
  (self :pointer))

(export 'CONVEX-TRIANGLE-MESH-SHAPE/GET-NUM-VERTICES)

(declaim (inline CONVEX-TRIANGLE-MESH-SHAPE/GET-NUM-EDGES))

(cffi:defcfun ("_wrap_btConvexTriangleMeshShape_getNumEdges" CONVEX-TRIANGLE-MESH-SHAPE/GET-NUM-EDGES) :int
  (self :pointer))

(export 'CONVEX-TRIANGLE-MESH-SHAPE/GET-NUM-EDGES)

(declaim (inline CONVEX-TRIANGLE-MESH-SHAPE/GET-EDGE))

(cffi:defcfun ("_wrap_btConvexTriangleMeshShape_getEdge" CONVEX-TRIANGLE-MESH-SHAPE/GET-EDGE) :void
  (self :pointer)
  (i :int)
  (pa :pointer)
  (pb :pointer))

(export 'CONVEX-TRIANGLE-MESH-SHAPE/GET-EDGE)

(declaim (inline CONVEX-TRIANGLE-MESH-SHAPE/GET-VERTEX))

(cffi:defcfun ("_wrap_btConvexTriangleMeshShape_getVertex" CONVEX-TRIANGLE-MESH-SHAPE/GET-VERTEX) :void
  (self :pointer)
  (i :int)
  (vtx :pointer))

(export 'CONVEX-TRIANGLE-MESH-SHAPE/GET-VERTEX)

(declaim (inline CONVEX-TRIANGLE-MESH-SHAPE/GET-NUM-PLANES))

(cffi:defcfun ("_wrap_btConvexTriangleMeshShape_getNumPlanes" CONVEX-TRIANGLE-MESH-SHAPE/GET-NUM-PLANES) :int
  (self :pointer))

(export 'CONVEX-TRIANGLE-MESH-SHAPE/GET-NUM-PLANES)

(declaim (inline CONVEX-TRIANGLE-MESH-SHAPE/GET-PLANE))

(cffi:defcfun ("_wrap_btConvexTriangleMeshShape_getPlane" CONVEX-TRIANGLE-MESH-SHAPE/GET-PLANE) :void
  (self :pointer)
  (planeNormal :pointer)
  (planeSupport :pointer)
  (i :int))

(export 'CONVEX-TRIANGLE-MESH-SHAPE/GET-PLANE)

(declaim (inline CONVEX-TRIANGLE-MESH-SHAPE/IS-INSIDE))

(cffi:defcfun ("_wrap_btConvexTriangleMeshShape_isInside" CONVEX-TRIANGLE-MESH-SHAPE/IS-INSIDE) :pointer
  (self :pointer)
  (pt :pointer)
  (tolerance :float))

(export 'CONVEX-TRIANGLE-MESH-SHAPE/IS-INSIDE)

(declaim (inline CONVEX-TRIANGLE-MESH-SHAPE/SET-LOCAL-SCALING))

(cffi:defcfun ("_wrap_btConvexTriangleMeshShape_setLocalScaling" CONVEX-TRIANGLE-MESH-SHAPE/SET-LOCAL-SCALING) :void
  (self :pointer)
  (scaling :pointer))

(export 'CONVEX-TRIANGLE-MESH-SHAPE/SET-LOCAL-SCALING)

(declaim (inline CONVEX-TRIANGLE-MESH-SHAPE/GET-LOCAL-SCALING))

(cffi:defcfun ("_wrap_btConvexTriangleMeshShape_getLocalScaling" CONVEX-TRIANGLE-MESH-SHAPE/GET-LOCAL-SCALING) :pointer
  (self :pointer))

(export 'CONVEX-TRIANGLE-MESH-SHAPE/GET-LOCAL-SCALING)

(declaim (inline CONVEX-TRIANGLE-MESH-SHAPE/CALCULATE-PRINCIPAL-AXIS-TRANSFORM))

(cffi:defcfun ("_wrap_btConvexTriangleMeshShape_calculatePrincipalAxisTransform" CONVEX-TRIANGLE-MESH-SHAPE/CALCULATE-PRINCIPAL-AXIS-TRANSFORM) :void
  (self :pointer)
  (principal :pointer)
  (inertia :pointer)
  (volume :pointer))

(export 'CONVEX-TRIANGLE-MESH-SHAPE/CALCULATE-PRINCIPAL-AXIS-TRANSFORM)

(declaim (inline DELETE/BT-CONVEX-TRIANGLE-MESH-SHAPE))

(cffi:defcfun ("_wrap_delete_btConvexTriangleMeshShape" DELETE/BT-CONVEX-TRIANGLE-MESH-SHAPE) :void
  (self :pointer))

(export 'DELETE/BT-CONVEX-TRIANGLE-MESH-SHAPE)

(declaim (inline BVH-TRIANGLE-MESH-SHAPE/MAKE-CPLUS-PLUS-INSTANCE))

(cffi:defcfun ("_wrap_btBvhTriangleMeshShape_makeCPlusPlusInstance__SWIG_0" BVH-TRIANGLE-MESH-SHAPE/MAKE-CPLUS-PLUS-INSTANCE) :pointer
  (self :pointer)
  (sizeInBytes :pointer))

(export 'BVH-TRIANGLE-MESH-SHAPE/MAKE-CPLUS-PLUS-INSTANCE)

(declaim (inline BVH-TRIANGLE-MESH-SHAPE/DELETE-CPLUS-PLUS-INSTANCE))

(cffi:defcfun ("_wrap_btBvhTriangleMeshShape_deleteCPlusPlusInstance__SWIG_0" BVH-TRIANGLE-MESH-SHAPE/DELETE-CPLUS-PLUS-INSTANCE) :void
  (self :pointer)
  (ptr :pointer))

(export 'BVH-TRIANGLE-MESH-SHAPE/DELETE-CPLUS-PLUS-INSTANCE)

(declaim (inline BVH-TRIANGLE-MESH-SHAPE/MAKE-CPLUS-PLUS-INSTANCE))

(cffi:defcfun ("_wrap_btBvhTriangleMeshShape_makeCPlusPlusInstance__SWIG_1" BVH-TRIANGLE-MESH-SHAPE/MAKE-CPLUS-PLUS-INSTANCE) :pointer
  (self :pointer)
  (arg1 :pointer)
  (ptr :pointer))

(export 'BVH-TRIANGLE-MESH-SHAPE/MAKE-CPLUS-PLUS-INSTANCE)

(declaim (inline BVH-TRIANGLE-MESH-SHAPE/DELETE-CPLUS-PLUS-INSTANCE))

(cffi:defcfun ("_wrap_btBvhTriangleMeshShape_deleteCPlusPlusInstance__SWIG_1" BVH-TRIANGLE-MESH-SHAPE/DELETE-CPLUS-PLUS-INSTANCE) :void
  (self :pointer)
  (arg1 :pointer)
  (arg2 :pointer))

(export 'BVH-TRIANGLE-MESH-SHAPE/DELETE-CPLUS-PLUS-INSTANCE)

(declaim (inline BVH-TRIANGLE-MESH-SHAPE/MAKE-CPLUS-ARRAY))

(cffi:defcfun ("_wrap_btBvhTriangleMeshShape_makeCPlusArray__SWIG_0" BVH-TRIANGLE-MESH-SHAPE/MAKE-CPLUS-ARRAY) :pointer
  (self :pointer)
  (sizeInBytes :pointer))

(export 'BVH-TRIANGLE-MESH-SHAPE/MAKE-CPLUS-ARRAY)

(declaim (inline BVH-TRIANGLE-MESH-SHAPE/DELETE-CPLUS-ARRAY))

(cffi:defcfun ("_wrap_btBvhTriangleMeshShape_deleteCPlusArray__SWIG_0" BVH-TRIANGLE-MESH-SHAPE/DELETE-CPLUS-ARRAY) :void
  (self :pointer)
  (ptr :pointer))

(export 'BVH-TRIANGLE-MESH-SHAPE/DELETE-CPLUS-ARRAY)

(declaim (inline BVH-TRIANGLE-MESH-SHAPE/MAKE-CPLUS-ARRAY))

(cffi:defcfun ("_wrap_btBvhTriangleMeshShape_makeCPlusArray__SWIG_1" BVH-TRIANGLE-MESH-SHAPE/MAKE-CPLUS-ARRAY) :pointer
  (self :pointer)
  (arg1 :pointer)
  (ptr :pointer))

(export 'BVH-TRIANGLE-MESH-SHAPE/MAKE-CPLUS-ARRAY)

(declaim (inline BVH-TRIANGLE-MESH-SHAPE/DELETE-CPLUS-ARRAY))

(cffi:defcfun ("_wrap_btBvhTriangleMeshShape_deleteCPlusArray__SWIG_1" BVH-TRIANGLE-MESH-SHAPE/DELETE-CPLUS-ARRAY) :void
  (self :pointer)
  (arg1 :pointer)
  (arg2 :pointer))

(export 'BVH-TRIANGLE-MESH-SHAPE/DELETE-CPLUS-ARRAY)

(declaim (inline MAKE-BVH-TRIANGLE-MESH-SHAPE))

(cffi:defcfun ("_wrap_new_btBvhTriangleMeshShape__SWIG_0" MAKE-BVH-TRIANGLE-MESH-SHAPE) :pointer
  (meshInterface :pointer)
  (useQuantizedAabbCompression :pointer)
  (buildBvh :pointer))

(export 'MAKE-BVH-TRIANGLE-MESH-SHAPE)

(declaim (inline MAKE-BVH-TRIANGLE-MESH-SHAPE))

(cffi:defcfun ("_wrap_new_btBvhTriangleMeshShape__SWIG_1" MAKE-BVH-TRIANGLE-MESH-SHAPE) :pointer
  (meshInterface :pointer)
  (useQuantizedAabbCompression :pointer))

(export 'MAKE-BVH-TRIANGLE-MESH-SHAPE)

(declaim (inline MAKE-BVH-TRIANGLE-MESH-SHAPE))

(cffi:defcfun ("_wrap_new_btBvhTriangleMeshShape__SWIG_2" MAKE-BVH-TRIANGLE-MESH-SHAPE) :pointer
  (meshInterface :pointer)
  (useQuantizedAabbCompression :pointer)
  (bvhAabbMin :pointer)
  (bvhAabbMax :pointer)
  (buildBvh :pointer))

(export 'MAKE-BVH-TRIANGLE-MESH-SHAPE)

(declaim (inline MAKE-BVH-TRIANGLE-MESH-SHAPE))

(cffi:defcfun ("_wrap_new_btBvhTriangleMeshShape__SWIG_3" MAKE-BVH-TRIANGLE-MESH-SHAPE) :pointer
  (meshInterface :pointer)
  (useQuantizedAabbCompression :pointer)
  (bvhAabbMin :pointer)
  (bvhAabbMax :pointer))

(export 'MAKE-BVH-TRIANGLE-MESH-SHAPE)

(declaim (inline DELETE/BT-BVH-TRIANGLE-MESH-SHAPE))

(cffi:defcfun ("_wrap_delete_btBvhTriangleMeshShape" DELETE/BT-BVH-TRIANGLE-MESH-SHAPE) :void
  (self :pointer))

(export 'DELETE/BT-BVH-TRIANGLE-MESH-SHAPE)

(declaim (inline BVH-TRIANGLE-MESH-SHAPE/GET-OWNS-BVH))

(cffi:defcfun ("_wrap_btBvhTriangleMeshShape_getOwnsBvh" BVH-TRIANGLE-MESH-SHAPE/GET-OWNS-BVH) :pointer
  (self :pointer))

(export 'BVH-TRIANGLE-MESH-SHAPE/GET-OWNS-BVH)

(declaim (inline BVH-TRIANGLE-MESH-SHAPE/PERFORM-RAYCAST))

(cffi:defcfun ("_wrap_btBvhTriangleMeshShape_performRaycast" BVH-TRIANGLE-MESH-SHAPE/PERFORM-RAYCAST) :void
  (self :pointer)
  (callback :pointer)
  (raySource :pointer)
  (rayTarget :pointer))

(export 'BVH-TRIANGLE-MESH-SHAPE/PERFORM-RAYCAST)

(declaim (inline BVH-TRIANGLE-MESH-SHAPE/PERFORM-CONVEXCAST))

(cffi:defcfun ("_wrap_btBvhTriangleMeshShape_performConvexcast" BVH-TRIANGLE-MESH-SHAPE/PERFORM-CONVEXCAST) :void
  (self :pointer)
  (callback :pointer)
  (boxSource :pointer)
  (boxTarget :pointer)
  (boxMin :pointer)
  (boxMax :pointer))

(export 'BVH-TRIANGLE-MESH-SHAPE/PERFORM-CONVEXCAST)

(declaim (inline BVH-TRIANGLE-MESH-SHAPE/PROCESS-ALL-TRIANGLES))

(cffi:defcfun ("_wrap_btBvhTriangleMeshShape_processAllTriangles" BVH-TRIANGLE-MESH-SHAPE/PROCESS-ALL-TRIANGLES) :void
  (self :pointer)
  (callback :pointer)
  (aabbMin :pointer)
  (aabbMax :pointer))

(export 'BVH-TRIANGLE-MESH-SHAPE/PROCESS-ALL-TRIANGLES)

(declaim (inline BVH-TRIANGLE-MESH-SHAPE/REFIT-TREE))

(cffi:defcfun ("_wrap_btBvhTriangleMeshShape_refitTree" BVH-TRIANGLE-MESH-SHAPE/REFIT-TREE) :void
  (self :pointer)
  (aabbMin :pointer)
  (aabbMax :pointer))

(export 'BVH-TRIANGLE-MESH-SHAPE/REFIT-TREE)

(declaim (inline BVH-TRIANGLE-MESH-SHAPE/PARTIAL-REFIT-TREE))

(cffi:defcfun ("_wrap_btBvhTriangleMeshShape_partialRefitTree" BVH-TRIANGLE-MESH-SHAPE/PARTIAL-REFIT-TREE) :void
  (self :pointer)
  (aabbMin :pointer)
  (aabbMax :pointer))

(export 'BVH-TRIANGLE-MESH-SHAPE/PARTIAL-REFIT-TREE)

(declaim (inline BVH-TRIANGLE-MESH-SHAPE/GET-NAME))

(cffi:defcfun ("_wrap_btBvhTriangleMeshShape_getName" BVH-TRIANGLE-MESH-SHAPE/GET-NAME) :string
  (self :pointer))

(export 'BVH-TRIANGLE-MESH-SHAPE/GET-NAME)

(declaim (inline BVH-TRIANGLE-MESH-SHAPE/SET-LOCAL-SCALING))

(cffi:defcfun ("_wrap_btBvhTriangleMeshShape_setLocalScaling" BVH-TRIANGLE-MESH-SHAPE/SET-LOCAL-SCALING) :void
  (self :pointer)
  (scaling :pointer))

(export 'BVH-TRIANGLE-MESH-SHAPE/SET-LOCAL-SCALING)

(declaim (inline BVH-TRIANGLE-MESH-SHAPE/GET-OPTIMIZED-BVH))

(cffi:defcfun ("_wrap_btBvhTriangleMeshShape_getOptimizedBvh" BVH-TRIANGLE-MESH-SHAPE/GET-OPTIMIZED-BVH) :pointer
  (self :pointer))

(export 'BVH-TRIANGLE-MESH-SHAPE/GET-OPTIMIZED-BVH)

(declaim (inline BVH-TRIANGLE-MESH-SHAPE/SET-OPTIMIZED-BVH))

(cffi:defcfun ("_wrap_btBvhTriangleMeshShape_setOptimizedBvh__SWIG_0" BVH-TRIANGLE-MESH-SHAPE/SET-OPTIMIZED-BVH) :void
  (self :pointer)
  (bvh :pointer)
  (localScaling :pointer))

(export 'BVH-TRIANGLE-MESH-SHAPE/SET-OPTIMIZED-BVH)

(declaim (inline BVH-TRIANGLE-MESH-SHAPE/SET-OPTIMIZED-BVH))

(cffi:defcfun ("_wrap_btBvhTriangleMeshShape_setOptimizedBvh__SWIG_1" BVH-TRIANGLE-MESH-SHAPE/SET-OPTIMIZED-BVH) :void
  (self :pointer)
  (bvh :pointer))

(export 'BVH-TRIANGLE-MESH-SHAPE/SET-OPTIMIZED-BVH)

(declaim (inline BVH-TRIANGLE-MESH-SHAPE/BUILD-OPTIMIZED-BVH))

(cffi:defcfun ("_wrap_btBvhTriangleMeshShape_buildOptimizedBvh" BVH-TRIANGLE-MESH-SHAPE/BUILD-OPTIMIZED-BVH) :void
  (self :pointer))

(export 'BVH-TRIANGLE-MESH-SHAPE/BUILD-OPTIMIZED-BVH)

(declaim (inline BVH-TRIANGLE-MESH-SHAPE/USES-QUANTIZED-AABB-COMPRESSION))

(cffi:defcfun ("_wrap_btBvhTriangleMeshShape_usesQuantizedAabbCompression" BVH-TRIANGLE-MESH-SHAPE/USES-QUANTIZED-AABB-COMPRESSION) :pointer
  (self :pointer))

(export 'BVH-TRIANGLE-MESH-SHAPE/USES-QUANTIZED-AABB-COMPRESSION)

(declaim (inline BVH-TRIANGLE-MESH-SHAPE/SET-TRIANGLE-INFO-MAP))

(cffi:defcfun ("_wrap_btBvhTriangleMeshShape_setTriangleInfoMap" BVH-TRIANGLE-MESH-SHAPE/SET-TRIANGLE-INFO-MAP) :void
  (self :pointer)
  (triangleInfoMap :pointer))

(export 'BVH-TRIANGLE-MESH-SHAPE/SET-TRIANGLE-INFO-MAP)

(declaim (inline BVH-TRIANGLE-MESH-SHAPE/GET-TRIANGLE-INFO-MAP))

(cffi:defcfun ("_wrap_btBvhTriangleMeshShape_getTriangleInfoMap__SWIG_0" BVH-TRIANGLE-MESH-SHAPE/GET-TRIANGLE-INFO-MAP) :pointer
  (self :pointer))

(export 'BVH-TRIANGLE-MESH-SHAPE/GET-TRIANGLE-INFO-MAP)

(declaim (inline BVH-TRIANGLE-MESH-SHAPE/GET-TRIANGLE-INFO-MAP))

(cffi:defcfun ("_wrap_btBvhTriangleMeshShape_getTriangleInfoMap__SWIG_1" BVH-TRIANGLE-MESH-SHAPE/GET-TRIANGLE-INFO-MAP) :pointer
  (self :pointer))

(export 'BVH-TRIANGLE-MESH-SHAPE/GET-TRIANGLE-INFO-MAP)

(declaim (inline BVH-TRIANGLE-MESH-SHAPE/CALCULATE-SERIALIZE-BUFFER-SIZE))

(cffi:defcfun ("_wrap_btBvhTriangleMeshShape_calculateSerializeBufferSize" BVH-TRIANGLE-MESH-SHAPE/CALCULATE-SERIALIZE-BUFFER-SIZE) :int
  (self :pointer))

(export 'BVH-TRIANGLE-MESH-SHAPE/CALCULATE-SERIALIZE-BUFFER-SIZE)

(declaim (inline BVH-TRIANGLE-MESH-SHAPE/SERIALIZE))

(cffi:defcfun ("_wrap_btBvhTriangleMeshShape_serialize" BVH-TRIANGLE-MESH-SHAPE/SERIALIZE) :string
  (self :pointer)
  (dataBuffer :pointer)
  (serializer :pointer))

(export 'BVH-TRIANGLE-MESH-SHAPE/SERIALIZE)

(declaim (inline BVH-TRIANGLE-MESH-SHAPE/SERIALIZE-SINGLE-BVH))

(cffi:defcfun ("_wrap_btBvhTriangleMeshShape_serializeSingleBvh" BVH-TRIANGLE-MESH-SHAPE/SERIALIZE-SINGLE-BVH) :void
  (self :pointer)
  (serializer :pointer))

(export 'BVH-TRIANGLE-MESH-SHAPE/SERIALIZE-SINGLE-BVH)

(declaim (inline BVH-TRIANGLE-MESH-SHAPE/SERIALIZE-SINGLE-TRIANGLE-INFO-MAP))

(cffi:defcfun ("_wrap_btBvhTriangleMeshShape_serializeSingleTriangleInfoMap" BVH-TRIANGLE-MESH-SHAPE/SERIALIZE-SINGLE-TRIANGLE-INFO-MAP) :void
  (self :pointer)
  (serializer :pointer))

(export 'BVH-TRIANGLE-MESH-SHAPE/SERIALIZE-SINGLE-TRIANGLE-INFO-MAP)

(cffi:defcstruct TRIANGLE-MESH-SHAPE-DATA
  (COLLISION-SHAPE-DATA :pointer)
  (MESH-INTERFACE :pointer)
  (QUANTIZED-FLOAT-BVH :pointer)
  (QUANTIZED-DOUBLE-BVH :pointer)
  (TRIANGLE-INFO-MAP :pointer)
  (COLLISION-MARGIN :float)
  (PAD-3 :pointer))

(export 'TRIANGLE-MESH-SHAPE-DATA)

(export 'COLLISION-SHAPE-DATA)

(export 'MESH-INTERFACE)

(export 'QUANTIZED-FLOAT-BVH)

(export 'QUANTIZED-DOUBLE-BVH)

(export 'TRIANGLE-INFO-MAP)

(export 'COLLISION-MARGIN)

(export 'PAD-3)

(declaim (inline SCALED-BVH-TRIANGLE-MESH-SHAPE/MAKE-CPLUS-PLUS-INSTANCE))

(cffi:defcfun ("_wrap_btScaledBvhTriangleMeshShape_makeCPlusPlusInstance__SWIG_0" SCALED-BVH-TRIANGLE-MESH-SHAPE/MAKE-CPLUS-PLUS-INSTANCE) :pointer
  (self :pointer)
  (sizeInBytes :pointer))

(export 'SCALED-BVH-TRIANGLE-MESH-SHAPE/MAKE-CPLUS-PLUS-INSTANCE)

(declaim (inline SCALED-BVH-TRIANGLE-MESH-SHAPE/DELETE-CPLUS-PLUS-INSTANCE))

(cffi:defcfun ("_wrap_btScaledBvhTriangleMeshShape_deleteCPlusPlusInstance__SWIG_0" SCALED-BVH-TRIANGLE-MESH-SHAPE/DELETE-CPLUS-PLUS-INSTANCE) :void
  (self :pointer)
  (ptr :pointer))

(export 'SCALED-BVH-TRIANGLE-MESH-SHAPE/DELETE-CPLUS-PLUS-INSTANCE)

(declaim (inline SCALED-BVH-TRIANGLE-MESH-SHAPE/MAKE-CPLUS-PLUS-INSTANCE))

(cffi:defcfun ("_wrap_btScaledBvhTriangleMeshShape_makeCPlusPlusInstance__SWIG_1" SCALED-BVH-TRIANGLE-MESH-SHAPE/MAKE-CPLUS-PLUS-INSTANCE) :pointer
  (self :pointer)
  (arg1 :pointer)
  (ptr :pointer))

(export 'SCALED-BVH-TRIANGLE-MESH-SHAPE/MAKE-CPLUS-PLUS-INSTANCE)

(declaim (inline SCALED-BVH-TRIANGLE-MESH-SHAPE/DELETE-CPLUS-PLUS-INSTANCE))

(cffi:defcfun ("_wrap_btScaledBvhTriangleMeshShape_deleteCPlusPlusInstance__SWIG_1" SCALED-BVH-TRIANGLE-MESH-SHAPE/DELETE-CPLUS-PLUS-INSTANCE) :void
  (self :pointer)
  (arg1 :pointer)
  (arg2 :pointer))

(export 'SCALED-BVH-TRIANGLE-MESH-SHAPE/DELETE-CPLUS-PLUS-INSTANCE)

(declaim (inline SCALED-BVH-TRIANGLE-MESH-SHAPE/MAKE-CPLUS-ARRAY))

(cffi:defcfun ("_wrap_btScaledBvhTriangleMeshShape_makeCPlusArray__SWIG_0" SCALED-BVH-TRIANGLE-MESH-SHAPE/MAKE-CPLUS-ARRAY) :pointer
  (self :pointer)
  (sizeInBytes :pointer))

(export 'SCALED-BVH-TRIANGLE-MESH-SHAPE/MAKE-CPLUS-ARRAY)

(declaim (inline SCALED-BVH-TRIANGLE-MESH-SHAPE/DELETE-CPLUS-ARRAY))

(cffi:defcfun ("_wrap_btScaledBvhTriangleMeshShape_deleteCPlusArray__SWIG_0" SCALED-BVH-TRIANGLE-MESH-SHAPE/DELETE-CPLUS-ARRAY) :void
  (self :pointer)
  (ptr :pointer))

(export 'SCALED-BVH-TRIANGLE-MESH-SHAPE/DELETE-CPLUS-ARRAY)

(declaim (inline SCALED-BVH-TRIANGLE-MESH-SHAPE/MAKE-CPLUS-ARRAY))

(cffi:defcfun ("_wrap_btScaledBvhTriangleMeshShape_makeCPlusArray__SWIG_1" SCALED-BVH-TRIANGLE-MESH-SHAPE/MAKE-CPLUS-ARRAY) :pointer
  (self :pointer)
  (arg1 :pointer)
  (ptr :pointer))

(export 'SCALED-BVH-TRIANGLE-MESH-SHAPE/MAKE-CPLUS-ARRAY)

(declaim (inline SCALED-BVH-TRIANGLE-MESH-SHAPE/DELETE-CPLUS-ARRAY))

(cffi:defcfun ("_wrap_btScaledBvhTriangleMeshShape_deleteCPlusArray__SWIG_1" SCALED-BVH-TRIANGLE-MESH-SHAPE/DELETE-CPLUS-ARRAY) :void
  (self :pointer)
  (arg1 :pointer)
  (arg2 :pointer))

(export 'SCALED-BVH-TRIANGLE-MESH-SHAPE/DELETE-CPLUS-ARRAY)

(declaim (inline MAKE-SCALED-BVH-TRIANGLE-MESH-SHAPE))

(cffi:defcfun ("_wrap_new_btScaledBvhTriangleMeshShape" MAKE-SCALED-BVH-TRIANGLE-MESH-SHAPE) :pointer
  (childShape :pointer)
  (localScaling :pointer))

(export 'MAKE-SCALED-BVH-TRIANGLE-MESH-SHAPE)

(declaim (inline DELETE/BT-SCALED-BVH-TRIANGLE-MESH-SHAPE))

(cffi:defcfun ("_wrap_delete_btScaledBvhTriangleMeshShape" DELETE/BT-SCALED-BVH-TRIANGLE-MESH-SHAPE) :void
  (self :pointer))

(export 'DELETE/BT-SCALED-BVH-TRIANGLE-MESH-SHAPE)

(declaim (inline SCALED-BVH-TRIANGLE-MESH-SHAPE/GET-AABB))

(cffi:defcfun ("_wrap_btScaledBvhTriangleMeshShape_getAabb" SCALED-BVH-TRIANGLE-MESH-SHAPE/GET-AABB) :void
  (self :pointer)
  (t_arg1 :pointer)
  (aabbMin :pointer)
  (aabbMax :pointer))

(export 'SCALED-BVH-TRIANGLE-MESH-SHAPE/GET-AABB)

(declaim (inline SCALED-BVH-TRIANGLE-MESH-SHAPE/SET-LOCAL-SCALING))

(cffi:defcfun ("_wrap_btScaledBvhTriangleMeshShape_setLocalScaling" SCALED-BVH-TRIANGLE-MESH-SHAPE/SET-LOCAL-SCALING) :void
  (self :pointer)
  (scaling :pointer))

(export 'SCALED-BVH-TRIANGLE-MESH-SHAPE/SET-LOCAL-SCALING)

(declaim (inline SCALED-BVH-TRIANGLE-MESH-SHAPE/GET-LOCAL-SCALING))

(cffi:defcfun ("_wrap_btScaledBvhTriangleMeshShape_getLocalScaling" SCALED-BVH-TRIANGLE-MESH-SHAPE/GET-LOCAL-SCALING) :pointer
  (self :pointer))

(export 'SCALED-BVH-TRIANGLE-MESH-SHAPE/GET-LOCAL-SCALING)

(declaim (inline SCALED-BVH-TRIANGLE-MESH-SHAPE/CALCULATE-LOCAL-INERTIA))

(cffi:defcfun ("_wrap_btScaledBvhTriangleMeshShape_calculateLocalInertia" SCALED-BVH-TRIANGLE-MESH-SHAPE/CALCULATE-LOCAL-INERTIA) :void
  (self :pointer)
  (mass :float)
  (inertia :pointer))

(export 'SCALED-BVH-TRIANGLE-MESH-SHAPE/CALCULATE-LOCAL-INERTIA)

(declaim (inline SCALED-BVH-TRIANGLE-MESH-SHAPE/PROCESS-ALL-TRIANGLES))

(cffi:defcfun ("_wrap_btScaledBvhTriangleMeshShape_processAllTriangles" SCALED-BVH-TRIANGLE-MESH-SHAPE/PROCESS-ALL-TRIANGLES) :void
  (self :pointer)
  (callback :pointer)
  (aabbMin :pointer)
  (aabbMax :pointer))

(export 'SCALED-BVH-TRIANGLE-MESH-SHAPE/PROCESS-ALL-TRIANGLES)

(declaim (inline SCALED-BVH-TRIANGLE-MESH-SHAPE/GET-CHILD-SHAPE))

(cffi:defcfun ("_wrap_btScaledBvhTriangleMeshShape_getChildShape__SWIG_0" SCALED-BVH-TRIANGLE-MESH-SHAPE/GET-CHILD-SHAPE) :pointer
  (self :pointer))

(export 'SCALED-BVH-TRIANGLE-MESH-SHAPE/GET-CHILD-SHAPE)

(declaim (inline SCALED-BVH-TRIANGLE-MESH-SHAPE/GET-CHILD-SHAPE))

(cffi:defcfun ("_wrap_btScaledBvhTriangleMeshShape_getChildShape__SWIG_1" SCALED-BVH-TRIANGLE-MESH-SHAPE/GET-CHILD-SHAPE) :pointer
  (self :pointer))

(export 'SCALED-BVH-TRIANGLE-MESH-SHAPE/GET-CHILD-SHAPE)

(declaim (inline SCALED-BVH-TRIANGLE-MESH-SHAPE/GET-NAME))

(cffi:defcfun ("_wrap_btScaledBvhTriangleMeshShape_getName" SCALED-BVH-TRIANGLE-MESH-SHAPE/GET-NAME) :string
  (self :pointer))

(export 'SCALED-BVH-TRIANGLE-MESH-SHAPE/GET-NAME)

(declaim (inline SCALED-BVH-TRIANGLE-MESH-SHAPE/CALCULATE-SERIALIZE-BUFFER-SIZE))

(cffi:defcfun ("_wrap_btScaledBvhTriangleMeshShape_calculateSerializeBufferSize" SCALED-BVH-TRIANGLE-MESH-SHAPE/CALCULATE-SERIALIZE-BUFFER-SIZE) :int
  (self :pointer))

(export 'SCALED-BVH-TRIANGLE-MESH-SHAPE/CALCULATE-SERIALIZE-BUFFER-SIZE)

(declaim (inline SCALED-BVH-TRIANGLE-MESH-SHAPE/SERIALIZE))

(cffi:defcfun ("_wrap_btScaledBvhTriangleMeshShape_serialize" SCALED-BVH-TRIANGLE-MESH-SHAPE/SERIALIZE) :string
  (self :pointer)
  (dataBuffer :pointer)
  (serializer :pointer))

(export 'SCALED-BVH-TRIANGLE-MESH-SHAPE/SERIALIZE)

(cffi:defcstruct SCALED-TRIANGLE-MESH-SHAPE-DATA
  (TRIMESH-SHAPE-DATA TRIANGLE-MESH-SHAPE-DATA)
  (LOCAL-SCALING VECTOR-3-FLOAT-DATA))

(export 'SCALED-TRIANGLE-MESH-SHAPE-DATA)

(export 'TRIMESH-SHAPE-DATA)

(export 'LOCAL-SCALING)

(declaim (inline TRIANGLE-MESH-SHAPE/MAKE-CPLUS-PLUS-INSTANCE))

(cffi:defcfun ("_wrap_btTriangleMeshShape_makeCPlusPlusInstance__SWIG_0" TRIANGLE-MESH-SHAPE/MAKE-CPLUS-PLUS-INSTANCE) :pointer
  (self :pointer)
  (sizeInBytes :pointer))

(export 'TRIANGLE-MESH-SHAPE/MAKE-CPLUS-PLUS-INSTANCE)

(declaim (inline TRIANGLE-MESH-SHAPE/DELETE-CPLUS-PLUS-INSTANCE))

(cffi:defcfun ("_wrap_btTriangleMeshShape_deleteCPlusPlusInstance__SWIG_0" TRIANGLE-MESH-SHAPE/DELETE-CPLUS-PLUS-INSTANCE) :void
  (self :pointer)
  (ptr :pointer))

(export 'TRIANGLE-MESH-SHAPE/DELETE-CPLUS-PLUS-INSTANCE)

(declaim (inline TRIANGLE-MESH-SHAPE/MAKE-CPLUS-PLUS-INSTANCE))

(cffi:defcfun ("_wrap_btTriangleMeshShape_makeCPlusPlusInstance__SWIG_1" TRIANGLE-MESH-SHAPE/MAKE-CPLUS-PLUS-INSTANCE) :pointer
  (self :pointer)
  (arg1 :pointer)
  (ptr :pointer))

(export 'TRIANGLE-MESH-SHAPE/MAKE-CPLUS-PLUS-INSTANCE)

(declaim (inline TRIANGLE-MESH-SHAPE/DELETE-CPLUS-PLUS-INSTANCE))

(cffi:defcfun ("_wrap_btTriangleMeshShape_deleteCPlusPlusInstance__SWIG_1" TRIANGLE-MESH-SHAPE/DELETE-CPLUS-PLUS-INSTANCE) :void
  (self :pointer)
  (arg1 :pointer)
  (arg2 :pointer))

(export 'TRIANGLE-MESH-SHAPE/DELETE-CPLUS-PLUS-INSTANCE)

(declaim (inline TRIANGLE-MESH-SHAPE/MAKE-CPLUS-ARRAY))

(cffi:defcfun ("_wrap_btTriangleMeshShape_makeCPlusArray__SWIG_0" TRIANGLE-MESH-SHAPE/MAKE-CPLUS-ARRAY) :pointer
  (self :pointer)
  (sizeInBytes :pointer))

(export 'TRIANGLE-MESH-SHAPE/MAKE-CPLUS-ARRAY)

(declaim (inline TRIANGLE-MESH-SHAPE/DELETE-CPLUS-ARRAY))

(cffi:defcfun ("_wrap_btTriangleMeshShape_deleteCPlusArray__SWIG_0" TRIANGLE-MESH-SHAPE/DELETE-CPLUS-ARRAY) :void
  (self :pointer)
  (ptr :pointer))

(export 'TRIANGLE-MESH-SHAPE/DELETE-CPLUS-ARRAY)

(declaim (inline TRIANGLE-MESH-SHAPE/MAKE-CPLUS-ARRAY))

(cffi:defcfun ("_wrap_btTriangleMeshShape_makeCPlusArray__SWIG_1" TRIANGLE-MESH-SHAPE/MAKE-CPLUS-ARRAY) :pointer
  (self :pointer)
  (arg1 :pointer)
  (ptr :pointer))

(export 'TRIANGLE-MESH-SHAPE/MAKE-CPLUS-ARRAY)

(declaim (inline TRIANGLE-MESH-SHAPE/DELETE-CPLUS-ARRAY))

(cffi:defcfun ("_wrap_btTriangleMeshShape_deleteCPlusArray__SWIG_1" TRIANGLE-MESH-SHAPE/DELETE-CPLUS-ARRAY) :void
  (self :pointer)
  (arg1 :pointer)
  (arg2 :pointer))

(export 'TRIANGLE-MESH-SHAPE/DELETE-CPLUS-ARRAY)

(declaim (inline DELETE/BT-TRIANGLE-MESH-SHAPE))

(cffi:defcfun ("_wrap_delete_btTriangleMeshShape" DELETE/BT-TRIANGLE-MESH-SHAPE) :void
  (self :pointer))

(export 'DELETE/BT-TRIANGLE-MESH-SHAPE)

(declaim (inline TRIANGLE-MESH-SHAPE/LOCAL-GET-SUPPORTING-VERTEX))

(cffi:defcfun ("_wrap_btTriangleMeshShape_localGetSupportingVertex" TRIANGLE-MESH-SHAPE/LOCAL-GET-SUPPORTING-VERTEX) :pointer
  (self :pointer)
  (vec :pointer))

(export 'TRIANGLE-MESH-SHAPE/LOCAL-GET-SUPPORTING-VERTEX)

(declaim (inline TRIANGLE-MESH-SHAPE/LOCAL-GET-SUPPORTING-VERTEX-WITHOUT-MARGIN))

(cffi:defcfun ("_wrap_btTriangleMeshShape_localGetSupportingVertexWithoutMargin" TRIANGLE-MESH-SHAPE/LOCAL-GET-SUPPORTING-VERTEX-WITHOUT-MARGIN) :pointer
  (self :pointer)
  (vec :pointer))

(export 'TRIANGLE-MESH-SHAPE/LOCAL-GET-SUPPORTING-VERTEX-WITHOUT-MARGIN)

(declaim (inline TRIANGLE-MESH-SHAPE/RECALC-LOCAL-AABB))

(cffi:defcfun ("_wrap_btTriangleMeshShape_recalcLocalAabb" TRIANGLE-MESH-SHAPE/RECALC-LOCAL-AABB) :void
  (self :pointer))

(export 'TRIANGLE-MESH-SHAPE/RECALC-LOCAL-AABB)

(declaim (inline TRIANGLE-MESH-SHAPE/GET-AABB))

(cffi:defcfun ("_wrap_btTriangleMeshShape_getAabb" TRIANGLE-MESH-SHAPE/GET-AABB) :void
  (self :pointer)
  (t_arg1 :pointer)
  (aabbMin :pointer)
  (aabbMax :pointer))

(export 'TRIANGLE-MESH-SHAPE/GET-AABB)

(declaim (inline TRIANGLE-MESH-SHAPE/PROCESS-ALL-TRIANGLES))

(cffi:defcfun ("_wrap_btTriangleMeshShape_processAllTriangles" TRIANGLE-MESH-SHAPE/PROCESS-ALL-TRIANGLES) :void
  (self :pointer)
  (callback :pointer)
  (aabbMin :pointer)
  (aabbMax :pointer))

(export 'TRIANGLE-MESH-SHAPE/PROCESS-ALL-TRIANGLES)

(declaim (inline TRIANGLE-MESH-SHAPE/CALCULATE-LOCAL-INERTIA))

(cffi:defcfun ("_wrap_btTriangleMeshShape_calculateLocalInertia" TRIANGLE-MESH-SHAPE/CALCULATE-LOCAL-INERTIA) :void
  (self :pointer)
  (mass :float)
  (inertia :pointer))

(export 'TRIANGLE-MESH-SHAPE/CALCULATE-LOCAL-INERTIA)

(declaim (inline TRIANGLE-MESH-SHAPE/SET-LOCAL-SCALING))

(cffi:defcfun ("_wrap_btTriangleMeshShape_setLocalScaling" TRIANGLE-MESH-SHAPE/SET-LOCAL-SCALING) :void
  (self :pointer)
  (scaling :pointer))

(export 'TRIANGLE-MESH-SHAPE/SET-LOCAL-SCALING)

(declaim (inline TRIANGLE-MESH-SHAPE/GET-LOCAL-SCALING))

(cffi:defcfun ("_wrap_btTriangleMeshShape_getLocalScaling" TRIANGLE-MESH-SHAPE/GET-LOCAL-SCALING) :pointer
  (self :pointer))

(export 'TRIANGLE-MESH-SHAPE/GET-LOCAL-SCALING)

(declaim (inline TRIANGLE-MESH-SHAPE/GET-MESH-INTERFACE))

(cffi:defcfun ("_wrap_btTriangleMeshShape_getMeshInterface__SWIG_0" TRIANGLE-MESH-SHAPE/GET-MESH-INTERFACE) :pointer
  (self :pointer))

(export 'TRIANGLE-MESH-SHAPE/GET-MESH-INTERFACE)

(declaim (inline TRIANGLE-MESH-SHAPE/GET-MESH-INTERFACE))

(cffi:defcfun ("_wrap_btTriangleMeshShape_getMeshInterface__SWIG_1" TRIANGLE-MESH-SHAPE/GET-MESH-INTERFACE) :pointer
  (self :pointer))

(export 'TRIANGLE-MESH-SHAPE/GET-MESH-INTERFACE)

(declaim (inline TRIANGLE-MESH-SHAPE/GET-LOCAL-AABB-MIN))

(cffi:defcfun ("_wrap_btTriangleMeshShape_getLocalAabbMin" TRIANGLE-MESH-SHAPE/GET-LOCAL-AABB-MIN) :pointer
  (self :pointer))

(export 'TRIANGLE-MESH-SHAPE/GET-LOCAL-AABB-MIN)

(declaim (inline TRIANGLE-MESH-SHAPE/GET-LOCAL-AABB-MAX))

(cffi:defcfun ("_wrap_btTriangleMeshShape_getLocalAabbMax" TRIANGLE-MESH-SHAPE/GET-LOCAL-AABB-MAX) :pointer
  (self :pointer))

(export 'TRIANGLE-MESH-SHAPE/GET-LOCAL-AABB-MAX)

(declaim (inline TRIANGLE-MESH-SHAPE/GET-NAME))

(cffi:defcfun ("_wrap_btTriangleMeshShape_getName" TRIANGLE-MESH-SHAPE/GET-NAME) :string
  (self :pointer))

(export 'TRIANGLE-MESH-SHAPE/GET-NAME)

(cffi:defcstruct INDEXED-MESH
  (MAKE-CPLUS-PLUS-INSTANCE :pointer)
  (DELETE-CPLUS-PLUS-INSTANCE :pointer)
  (MAKE-CPLUS-PLUS-INSTANCE :pointer)
  (DELETE-CPLUS-PLUS-INSTANCE :pointer)
  (MAKE-CPLUS-ARRAY :pointer)
  (DELETE-CPLUS-ARRAY :pointer)
  (MAKE-CPLUS-ARRAY :pointer)
  (DELETE-CPLUS-ARRAY :pointer)
  (NUM-TRIANGLES :int)
  (TRIANGLE-INDEX-BASE :pointer)
  (TRIANGLE-INDEX-STRIDE :int)
  (NUM-VERTICES :int)
  (VERTEX-BASE :pointer)
  (VERTEX-STRIDE :int)
  (INDEX-TYPE :pointer)
  (VERTEX-TYPE :pointer))

(export 'INDEXED-MESH)

(export 'MAKE-CPLUS-PLUS-INSTANCE)

(export 'DELETE-CPLUS-PLUS-INSTANCE)

(export 'MAKE-CPLUS-PLUS-INSTANCE)

(export 'DELETE-CPLUS-PLUS-INSTANCE)

(export 'MAKE-CPLUS-ARRAY)

(export 'DELETE-CPLUS-ARRAY)

(export 'MAKE-CPLUS-ARRAY)

(export 'DELETE-CPLUS-ARRAY)

(export 'NUM-TRIANGLES)

(export 'TRIANGLE-INDEX-BASE)

(export 'TRIANGLE-INDEX-STRIDE)

(export 'NUM-VERTICES)

(export 'VERTEX-BASE)

(export 'VERTEX-STRIDE)

(export 'INDEX-TYPE)

(export 'VERTEX-TYPE)

(declaim (inline TRIANGLE-INDEX-VERTEX-ARRAY/MAKE-CPLUS-PLUS-INSTANCE))

(cffi:defcfun ("_wrap_btTriangleIndexVertexArray_makeCPlusPlusInstance__SWIG_0" TRIANGLE-INDEX-VERTEX-ARRAY/MAKE-CPLUS-PLUS-INSTANCE) :pointer
  (self :pointer)
  (sizeInBytes :pointer))

(export 'TRIANGLE-INDEX-VERTEX-ARRAY/MAKE-CPLUS-PLUS-INSTANCE)

(declaim (inline TRIANGLE-INDEX-VERTEX-ARRAY/DELETE-CPLUS-PLUS-INSTANCE))

(cffi:defcfun ("_wrap_btTriangleIndexVertexArray_deleteCPlusPlusInstance__SWIG_0" TRIANGLE-INDEX-VERTEX-ARRAY/DELETE-CPLUS-PLUS-INSTANCE) :void
  (self :pointer)
  (ptr :pointer))

(export 'TRIANGLE-INDEX-VERTEX-ARRAY/DELETE-CPLUS-PLUS-INSTANCE)

(declaim (inline TRIANGLE-INDEX-VERTEX-ARRAY/MAKE-CPLUS-PLUS-INSTANCE))

(cffi:defcfun ("_wrap_btTriangleIndexVertexArray_makeCPlusPlusInstance__SWIG_1" TRIANGLE-INDEX-VERTEX-ARRAY/MAKE-CPLUS-PLUS-INSTANCE) :pointer
  (self :pointer)
  (arg1 :pointer)
  (ptr :pointer))

(export 'TRIANGLE-INDEX-VERTEX-ARRAY/MAKE-CPLUS-PLUS-INSTANCE)

(declaim (inline TRIANGLE-INDEX-VERTEX-ARRAY/DELETE-CPLUS-PLUS-INSTANCE))

(cffi:defcfun ("_wrap_btTriangleIndexVertexArray_deleteCPlusPlusInstance__SWIG_1" TRIANGLE-INDEX-VERTEX-ARRAY/DELETE-CPLUS-PLUS-INSTANCE) :void
  (self :pointer)
  (arg1 :pointer)
  (arg2 :pointer))

(export 'TRIANGLE-INDEX-VERTEX-ARRAY/DELETE-CPLUS-PLUS-INSTANCE)

(declaim (inline TRIANGLE-INDEX-VERTEX-ARRAY/MAKE-CPLUS-ARRAY))

(cffi:defcfun ("_wrap_btTriangleIndexVertexArray_makeCPlusArray__SWIG_0" TRIANGLE-INDEX-VERTEX-ARRAY/MAKE-CPLUS-ARRAY) :pointer
  (self :pointer)
  (sizeInBytes :pointer))

(export 'TRIANGLE-INDEX-VERTEX-ARRAY/MAKE-CPLUS-ARRAY)

(declaim (inline TRIANGLE-INDEX-VERTEX-ARRAY/DELETE-CPLUS-ARRAY))

(cffi:defcfun ("_wrap_btTriangleIndexVertexArray_deleteCPlusArray__SWIG_0" TRIANGLE-INDEX-VERTEX-ARRAY/DELETE-CPLUS-ARRAY) :void
  (self :pointer)
  (ptr :pointer))

(export 'TRIANGLE-INDEX-VERTEX-ARRAY/DELETE-CPLUS-ARRAY)

(declaim (inline TRIANGLE-INDEX-VERTEX-ARRAY/MAKE-CPLUS-ARRAY))

(cffi:defcfun ("_wrap_btTriangleIndexVertexArray_makeCPlusArray__SWIG_1" TRIANGLE-INDEX-VERTEX-ARRAY/MAKE-CPLUS-ARRAY) :pointer
  (self :pointer)
  (arg1 :pointer)
  (ptr :pointer))

(export 'TRIANGLE-INDEX-VERTEX-ARRAY/MAKE-CPLUS-ARRAY)

(declaim (inline TRIANGLE-INDEX-VERTEX-ARRAY/DELETE-CPLUS-ARRAY))

(cffi:defcfun ("_wrap_btTriangleIndexVertexArray_deleteCPlusArray__SWIG_1" TRIANGLE-INDEX-VERTEX-ARRAY/DELETE-CPLUS-ARRAY) :void
  (self :pointer)
  (arg1 :pointer)
  (arg2 :pointer))

(export 'TRIANGLE-INDEX-VERTEX-ARRAY/DELETE-CPLUS-ARRAY)

(declaim (inline MAKE-TRIANGLE-INDEX-VERTEX-ARRAY))

(cffi:defcfun ("_wrap_new_btTriangleIndexVertexArray__SWIG_0" MAKE-TRIANGLE-INDEX-VERTEX-ARRAY) :pointer)

(export 'MAKE-TRIANGLE-INDEX-VERTEX-ARRAY)

(declaim (inline DELETE/BT-TRIANGLE-INDEX-VERTEX-ARRAY))

(cffi:defcfun ("_wrap_delete_btTriangleIndexVertexArray" DELETE/BT-TRIANGLE-INDEX-VERTEX-ARRAY) :void
  (self :pointer))

(export 'DELETE/BT-TRIANGLE-INDEX-VERTEX-ARRAY)

(declaim (inline MAKE-TRIANGLE-INDEX-VERTEX-ARRAY))

(cffi:defcfun ("_wrap_new_btTriangleIndexVertexArray__SWIG_1" MAKE-TRIANGLE-INDEX-VERTEX-ARRAY) :pointer
  (numTriangles :int)
  (triangleIndexBase :pointer)
  (triangleIndexStride :int)
  (numVertices :int)
  (vertexBase :pointer)
  (vertexStride :int))

(export 'MAKE-TRIANGLE-INDEX-VERTEX-ARRAY)

(declaim (inline TRIANGLE-INDEX-VERTEX-ARRAY/ADD-INDEXED-MESH))

(cffi:defcfun ("_wrap_btTriangleIndexVertexArray_addIndexedMesh__SWIG_0" TRIANGLE-INDEX-VERTEX-ARRAY/ADD-INDEXED-MESH) :void
  (self :pointer)
  (mesh :pointer)
  (indexType :pointer))

(export 'TRIANGLE-INDEX-VERTEX-ARRAY/ADD-INDEXED-MESH)

(declaim (inline TRIANGLE-INDEX-VERTEX-ARRAY/ADD-INDEXED-MESH))

(cffi:defcfun ("_wrap_btTriangleIndexVertexArray_addIndexedMesh__SWIG_1" TRIANGLE-INDEX-VERTEX-ARRAY/ADD-INDEXED-MESH) :void
  (self :pointer)
  (mesh :pointer))

(export 'TRIANGLE-INDEX-VERTEX-ARRAY/ADD-INDEXED-MESH)

(declaim (inline TRIANGLE-INDEX-VERTEX-ARRAY/GET-LOCKED-VERTEX-INDEX-BASE))

(cffi:defcfun ("_wrap_btTriangleIndexVertexArray_getLockedVertexIndexBase__SWIG_0" TRIANGLE-INDEX-VERTEX-ARRAY/GET-LOCKED-VERTEX-INDEX-BASE) :void
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

(export 'TRIANGLE-INDEX-VERTEX-ARRAY/GET-LOCKED-VERTEX-INDEX-BASE)

(declaim (inline TRIANGLE-INDEX-VERTEX-ARRAY/GET-LOCKED-VERTEX-INDEX-BASE))

(cffi:defcfun ("_wrap_btTriangleIndexVertexArray_getLockedVertexIndexBase__SWIG_1" TRIANGLE-INDEX-VERTEX-ARRAY/GET-LOCKED-VERTEX-INDEX-BASE) :void
  (self :pointer)
  (vertexbase :pointer)
  (numverts :pointer)
  (type :pointer)
  (vertexStride :pointer)
  (indexbase :pointer)
  (indexstride :pointer)
  (numfaces :pointer)
  (indicestype :pointer))

(export 'TRIANGLE-INDEX-VERTEX-ARRAY/GET-LOCKED-VERTEX-INDEX-BASE)

(declaim (inline TRIANGLE-INDEX-VERTEX-ARRAY/GET-LOCKED-READ-ONLY-VERTEX-INDEX-BASE))

(cffi:defcfun ("_wrap_btTriangleIndexVertexArray_getLockedReadOnlyVertexIndexBase__SWIG_0" TRIANGLE-INDEX-VERTEX-ARRAY/GET-LOCKED-READ-ONLY-VERTEX-INDEX-BASE) :void
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

(export 'TRIANGLE-INDEX-VERTEX-ARRAY/GET-LOCKED-READ-ONLY-VERTEX-INDEX-BASE)

(declaim (inline TRIANGLE-INDEX-VERTEX-ARRAY/GET-LOCKED-READ-ONLY-VERTEX-INDEX-BASE))

(cffi:defcfun ("_wrap_btTriangleIndexVertexArray_getLockedReadOnlyVertexIndexBase__SWIG_1" TRIANGLE-INDEX-VERTEX-ARRAY/GET-LOCKED-READ-ONLY-VERTEX-INDEX-BASE) :void
  (self :pointer)
  (vertexbase :pointer)
  (numverts :pointer)
  (type :pointer)
  (vertexStride :pointer)
  (indexbase :pointer)
  (indexstride :pointer)
  (numfaces :pointer)
  (indicestype :pointer))

(export 'TRIANGLE-INDEX-VERTEX-ARRAY/GET-LOCKED-READ-ONLY-VERTEX-INDEX-BASE)

(declaim (inline TRIANGLE-INDEX-VERTEX-ARRAY/UN-LOCK-VERTEX-BASE))

(cffi:defcfun ("_wrap_btTriangleIndexVertexArray_unLockVertexBase" TRIANGLE-INDEX-VERTEX-ARRAY/UN-LOCK-VERTEX-BASE) :void
  (self :pointer)
  (subpart :int))

(export 'TRIANGLE-INDEX-VERTEX-ARRAY/UN-LOCK-VERTEX-BASE)

(declaim (inline TRIANGLE-INDEX-VERTEX-ARRAY/UN-LOCK-READ-ONLY-VERTEX-BASE))

(cffi:defcfun ("_wrap_btTriangleIndexVertexArray_unLockReadOnlyVertexBase" TRIANGLE-INDEX-VERTEX-ARRAY/UN-LOCK-READ-ONLY-VERTEX-BASE) :void
  (self :pointer)
  (subpart :int))

(export 'TRIANGLE-INDEX-VERTEX-ARRAY/UN-LOCK-READ-ONLY-VERTEX-BASE)

(declaim (inline TRIANGLE-INDEX-VERTEX-ARRAY/GET-NUM-SUB-PARTS))

(cffi:defcfun ("_wrap_btTriangleIndexVertexArray_getNumSubParts" TRIANGLE-INDEX-VERTEX-ARRAY/GET-NUM-SUB-PARTS) :int
  (self :pointer))

(export 'TRIANGLE-INDEX-VERTEX-ARRAY/GET-NUM-SUB-PARTS)

(declaim (inline TRIANGLE-INDEX-VERTEX-ARRAY/GET-INDEXED-MESH-ARRAY))

(cffi:defcfun ("_wrap_btTriangleIndexVertexArray_getIndexedMeshArray__SWIG_0" TRIANGLE-INDEX-VERTEX-ARRAY/GET-INDEXED-MESH-ARRAY) :pointer
  (self :pointer))

(export 'TRIANGLE-INDEX-VERTEX-ARRAY/GET-INDEXED-MESH-ARRAY)

(declaim (inline TRIANGLE-INDEX-VERTEX-ARRAY/GET-INDEXED-MESH-ARRAY))

(cffi:defcfun ("_wrap_btTriangleIndexVertexArray_getIndexedMeshArray__SWIG_1" TRIANGLE-INDEX-VERTEX-ARRAY/GET-INDEXED-MESH-ARRAY) :pointer
  (self :pointer))

(export 'TRIANGLE-INDEX-VERTEX-ARRAY/GET-INDEXED-MESH-ARRAY)

(declaim (inline TRIANGLE-INDEX-VERTEX-ARRAY/PREALLOCATE-VERTICES))

(cffi:defcfun ("_wrap_btTriangleIndexVertexArray_preallocateVertices" TRIANGLE-INDEX-VERTEX-ARRAY/PREALLOCATE-VERTICES) :void
  (self :pointer)
  (numverts :int))

(export 'TRIANGLE-INDEX-VERTEX-ARRAY/PREALLOCATE-VERTICES)

(declaim (inline TRIANGLE-INDEX-VERTEX-ARRAY/PREALLOCATE-INDICES))

(cffi:defcfun ("_wrap_btTriangleIndexVertexArray_preallocateIndices" TRIANGLE-INDEX-VERTEX-ARRAY/PREALLOCATE-INDICES) :void
  (self :pointer)
  (numindices :int))

(export 'TRIANGLE-INDEX-VERTEX-ARRAY/PREALLOCATE-INDICES)

(declaim (inline TRIANGLE-INDEX-VERTEX-ARRAY/HAS-PREMADE-AABB))

(cffi:defcfun ("_wrap_btTriangleIndexVertexArray_hasPremadeAabb" TRIANGLE-INDEX-VERTEX-ARRAY/HAS-PREMADE-AABB) :pointer
  (self :pointer))

(export 'TRIANGLE-INDEX-VERTEX-ARRAY/HAS-PREMADE-AABB)

(declaim (inline TRIANGLE-INDEX-VERTEX-ARRAY/SET-PREMADE-AABB))

(cffi:defcfun ("_wrap_btTriangleIndexVertexArray_setPremadeAabb" TRIANGLE-INDEX-VERTEX-ARRAY/SET-PREMADE-AABB) :void
  (self :pointer)
  (aabbMin :pointer)
  (aabbMax :pointer))

(export 'TRIANGLE-INDEX-VERTEX-ARRAY/SET-PREMADE-AABB)

(declaim (inline TRIANGLE-INDEX-VERTEX-ARRAY/GET-PREMADE-AABB))

(cffi:defcfun ("_wrap_btTriangleIndexVertexArray_getPremadeAabb" TRIANGLE-INDEX-VERTEX-ARRAY/GET-PREMADE-AABB) :void
  (self :pointer)
  (aabbMin :pointer)
  (aabbMax :pointer))

(export 'TRIANGLE-INDEX-VERTEX-ARRAY/GET-PREMADE-AABB)

(cffi:defcstruct COMPOUND-SHAPE-CHILD
  (MAKE-CPLUS-PLUS-INSTANCE :pointer)
  (DELETE-CPLUS-PLUS-INSTANCE :pointer)
  (MAKE-CPLUS-PLUS-INSTANCE :pointer)
  (DELETE-CPLUS-PLUS-INSTANCE :pointer)
  (MAKE-CPLUS-ARRAY :pointer)
  (DELETE-CPLUS-ARRAY :pointer)
  (MAKE-CPLUS-ARRAY :pointer)
  (DELETE-CPLUS-ARRAY :pointer)
  (TRANSFORM :pointer)
  (CHILD-SHAPE :pointer)
  (CHILD-SHAPE-TYPE :int)
  (CHILD-MARGIN :float)
  (NODE :pointer))

(export 'COMPOUND-SHAPE-CHILD)

(export 'MAKE-CPLUS-PLUS-INSTANCE)

(export 'DELETE-CPLUS-PLUS-INSTANCE)

(export 'MAKE-CPLUS-PLUS-INSTANCE)

(export 'DELETE-CPLUS-PLUS-INSTANCE)

(export 'MAKE-CPLUS-ARRAY)

(export 'DELETE-CPLUS-ARRAY)

(export 'MAKE-CPLUS-ARRAY)

(export 'DELETE-CPLUS-ARRAY)

(export 'TRANSFORM)

(export 'CHILD-SHAPE)

(export 'CHILD-SHAPE-TYPE)

(export 'CHILD-MARGIN)

(export 'NODE)

(declaim (inline COMPOUND-SHAPE/MAKE-CPLUS-PLUS-INSTANCE))

(cffi:defcfun ("_wrap_btCompoundShape_makeCPlusPlusInstance__SWIG_0" COMPOUND-SHAPE/MAKE-CPLUS-PLUS-INSTANCE) :pointer
  (self :pointer)
  (sizeInBytes :pointer))

(export 'COMPOUND-SHAPE/MAKE-CPLUS-PLUS-INSTANCE)

(declaim (inline COMPOUND-SHAPE/DELETE-CPLUS-PLUS-INSTANCE))

(cffi:defcfun ("_wrap_btCompoundShape_deleteCPlusPlusInstance__SWIG_0" COMPOUND-SHAPE/DELETE-CPLUS-PLUS-INSTANCE) :void
  (self :pointer)
  (ptr :pointer))

(export 'COMPOUND-SHAPE/DELETE-CPLUS-PLUS-INSTANCE)

(declaim (inline COMPOUND-SHAPE/MAKE-CPLUS-PLUS-INSTANCE))

(cffi:defcfun ("_wrap_btCompoundShape_makeCPlusPlusInstance__SWIG_1" COMPOUND-SHAPE/MAKE-CPLUS-PLUS-INSTANCE) :pointer
  (self :pointer)
  (arg1 :pointer)
  (ptr :pointer))

(export 'COMPOUND-SHAPE/MAKE-CPLUS-PLUS-INSTANCE)

(declaim (inline COMPOUND-SHAPE/DELETE-CPLUS-PLUS-INSTANCE))

(cffi:defcfun ("_wrap_btCompoundShape_deleteCPlusPlusInstance__SWIG_1" COMPOUND-SHAPE/DELETE-CPLUS-PLUS-INSTANCE) :void
  (self :pointer)
  (arg1 :pointer)
  (arg2 :pointer))

(export 'COMPOUND-SHAPE/DELETE-CPLUS-PLUS-INSTANCE)

(declaim (inline COMPOUND-SHAPE/MAKE-CPLUS-ARRAY))

(cffi:defcfun ("_wrap_btCompoundShape_makeCPlusArray__SWIG_0" COMPOUND-SHAPE/MAKE-CPLUS-ARRAY) :pointer
  (self :pointer)
  (sizeInBytes :pointer))

(export 'COMPOUND-SHAPE/MAKE-CPLUS-ARRAY)

(declaim (inline COMPOUND-SHAPE/DELETE-CPLUS-ARRAY))

(cffi:defcfun ("_wrap_btCompoundShape_deleteCPlusArray__SWIG_0" COMPOUND-SHAPE/DELETE-CPLUS-ARRAY) :void
  (self :pointer)
  (ptr :pointer))

(export 'COMPOUND-SHAPE/DELETE-CPLUS-ARRAY)

(declaim (inline COMPOUND-SHAPE/MAKE-CPLUS-ARRAY))

(cffi:defcfun ("_wrap_btCompoundShape_makeCPlusArray__SWIG_1" COMPOUND-SHAPE/MAKE-CPLUS-ARRAY) :pointer
  (self :pointer)
  (arg1 :pointer)
  (ptr :pointer))

(export 'COMPOUND-SHAPE/MAKE-CPLUS-ARRAY)

(declaim (inline COMPOUND-SHAPE/DELETE-CPLUS-ARRAY))

(cffi:defcfun ("_wrap_btCompoundShape_deleteCPlusArray__SWIG_1" COMPOUND-SHAPE/DELETE-CPLUS-ARRAY) :void
  (self :pointer)
  (arg1 :pointer)
  (arg2 :pointer))

(export 'COMPOUND-SHAPE/DELETE-CPLUS-ARRAY)

(declaim (inline MAKE-COMPOUND-SHAPE))

(cffi:defcfun ("_wrap_new_btCompoundShape__SWIG_0" MAKE-COMPOUND-SHAPE) :pointer
  (enableDynamicAabbTree :pointer))

(export 'MAKE-COMPOUND-SHAPE)

(declaim (inline MAKE-COMPOUND-SHAPE))

(cffi:defcfun ("_wrap_new_btCompoundShape__SWIG_1" MAKE-COMPOUND-SHAPE) :pointer)

(export 'MAKE-COMPOUND-SHAPE)

(declaim (inline DELETE/BT-COMPOUND-SHAPE))

(cffi:defcfun ("_wrap_delete_btCompoundShape" DELETE/BT-COMPOUND-SHAPE) :void
  (self :pointer))

(export 'DELETE/BT-COMPOUND-SHAPE)

(declaim (inline COMPOUND-SHAPE/ADD-CHILD-SHAPE))

(cffi:defcfun ("_wrap_btCompoundShape_addChildShape" COMPOUND-SHAPE/ADD-CHILD-SHAPE) :void
  (self :pointer)
  (localTransform :pointer)
  (shape :pointer))

(export 'COMPOUND-SHAPE/ADD-CHILD-SHAPE)

(declaim (inline COMPOUND-SHAPE/REMOVE-CHILD-SHAPE))

(cffi:defcfun ("_wrap_btCompoundShape_removeChildShape" COMPOUND-SHAPE/REMOVE-CHILD-SHAPE) :void
  (self :pointer)
  (shape :pointer))

(export 'COMPOUND-SHAPE/REMOVE-CHILD-SHAPE)

(declaim (inline COMPOUND-SHAPE/REMOVE-CHILD-SHAPE-BY-INDEX))

(cffi:defcfun ("_wrap_btCompoundShape_removeChildShapeByIndex" COMPOUND-SHAPE/REMOVE-CHILD-SHAPE-BY-INDEX) :void
  (self :pointer)
  (childShapeindex :int))

(export 'COMPOUND-SHAPE/REMOVE-CHILD-SHAPE-BY-INDEX)

(declaim (inline COMPOUND-SHAPE/GET-NUM-CHILD-SHAPES))

(cffi:defcfun ("_wrap_btCompoundShape_getNumChildShapes" COMPOUND-SHAPE/GET-NUM-CHILD-SHAPES) :int
  (self :pointer))

(export 'COMPOUND-SHAPE/GET-NUM-CHILD-SHAPES)

(declaim (inline COMPOUND-SHAPE/GET-CHILD-SHAPE))

(cffi:defcfun ("_wrap_btCompoundShape_getChildShape__SWIG_0" COMPOUND-SHAPE/GET-CHILD-SHAPE) :pointer
  (self :pointer)
  (index :int))

(export 'COMPOUND-SHAPE/GET-CHILD-SHAPE)

(declaim (inline COMPOUND-SHAPE/GET-CHILD-SHAPE))

(cffi:defcfun ("_wrap_btCompoundShape_getChildShape__SWIG_1" COMPOUND-SHAPE/GET-CHILD-SHAPE) :pointer
  (self :pointer)
  (index :int))

(export 'COMPOUND-SHAPE/GET-CHILD-SHAPE)

(declaim (inline COMPOUND-SHAPE/GET-CHILD-TRANSFORM))

(cffi:defcfun ("_wrap_btCompoundShape_getChildTransform__SWIG_0" COMPOUND-SHAPE/GET-CHILD-TRANSFORM) :pointer
  (self :pointer)
  (index :int))

(export 'COMPOUND-SHAPE/GET-CHILD-TRANSFORM)

(declaim (inline COMPOUND-SHAPE/GET-CHILD-TRANSFORM))

(cffi:defcfun ("_wrap_btCompoundShape_getChildTransform__SWIG_1" COMPOUND-SHAPE/GET-CHILD-TRANSFORM) :pointer
  (self :pointer)
  (index :int))

(export 'COMPOUND-SHAPE/GET-CHILD-TRANSFORM)

(declaim (inline COMPOUND-SHAPE/UPDATE-CHILD-TRANSFORM))

(cffi:defcfun ("_wrap_btCompoundShape_updateChildTransform__SWIG_0" COMPOUND-SHAPE/UPDATE-CHILD-TRANSFORM) :void
  (self :pointer)
  (childIndex :int)
  (newChildTransform :pointer)
  (shouldRecalculateLocalAabb :pointer))

(export 'COMPOUND-SHAPE/UPDATE-CHILD-TRANSFORM)

(declaim (inline COMPOUND-SHAPE/UPDATE-CHILD-TRANSFORM))

(cffi:defcfun ("_wrap_btCompoundShape_updateChildTransform__SWIG_1" COMPOUND-SHAPE/UPDATE-CHILD-TRANSFORM) :void
  (self :pointer)
  (childIndex :int)
  (newChildTransform :pointer))

(export 'COMPOUND-SHAPE/UPDATE-CHILD-TRANSFORM)

(declaim (inline COMPOUND-SHAPE/GET-CHILD-LIST))

(cffi:defcfun ("_wrap_btCompoundShape_getChildList" COMPOUND-SHAPE/GET-CHILD-LIST) :pointer
  (self :pointer))

(export 'COMPOUND-SHAPE/GET-CHILD-LIST)

(declaim (inline COMPOUND-SHAPE/GET-AABB))

(cffi:defcfun ("_wrap_btCompoundShape_getAabb" COMPOUND-SHAPE/GET-AABB) :void
  (self :pointer)
  (t_arg1 :pointer)
  (aabbMin :pointer)
  (aabbMax :pointer))

(export 'COMPOUND-SHAPE/GET-AABB)

(declaim (inline COMPOUND-SHAPE/RECALCULATE-LOCAL-AABB))

(cffi:defcfun ("_wrap_btCompoundShape_recalculateLocalAabb" COMPOUND-SHAPE/RECALCULATE-LOCAL-AABB) :void
  (self :pointer))

(export 'COMPOUND-SHAPE/RECALCULATE-LOCAL-AABB)

(declaim (inline COMPOUND-SHAPE/SET-LOCAL-SCALING))

(cffi:defcfun ("_wrap_btCompoundShape_setLocalScaling" COMPOUND-SHAPE/SET-LOCAL-SCALING) :void
  (self :pointer)
  (scaling :pointer))

(export 'COMPOUND-SHAPE/SET-LOCAL-SCALING)

(declaim (inline COMPOUND-SHAPE/GET-LOCAL-SCALING))

(cffi:defcfun ("_wrap_btCompoundShape_getLocalScaling" COMPOUND-SHAPE/GET-LOCAL-SCALING) :pointer
  (self :pointer))

(export 'COMPOUND-SHAPE/GET-LOCAL-SCALING)

(declaim (inline COMPOUND-SHAPE/CALCULATE-LOCAL-INERTIA))

(cffi:defcfun ("_wrap_btCompoundShape_calculateLocalInertia" COMPOUND-SHAPE/CALCULATE-LOCAL-INERTIA) :void
  (self :pointer)
  (mass :float)
  (inertia :pointer))

(export 'COMPOUND-SHAPE/CALCULATE-LOCAL-INERTIA)

(declaim (inline COMPOUND-SHAPE/SET-MARGIN))

(cffi:defcfun ("_wrap_btCompoundShape_setMargin" COMPOUND-SHAPE/SET-MARGIN) :void
  (self :pointer)
  (margin :float))

(export 'COMPOUND-SHAPE/SET-MARGIN)

(declaim (inline COMPOUND-SHAPE/GET-MARGIN))

(cffi:defcfun ("_wrap_btCompoundShape_getMargin" COMPOUND-SHAPE/GET-MARGIN) :float
  (self :pointer))

(export 'COMPOUND-SHAPE/GET-MARGIN)

(declaim (inline COMPOUND-SHAPE/GET-NAME))

(cffi:defcfun ("_wrap_btCompoundShape_getName" COMPOUND-SHAPE/GET-NAME) :string
  (self :pointer))

(export 'COMPOUND-SHAPE/GET-NAME)

(declaim (inline COMPOUND-SHAPE/GET-DYNAMIC-AABB-TREE))

(cffi:defcfun ("_wrap_btCompoundShape_getDynamicAabbTree__SWIG_0" COMPOUND-SHAPE/GET-DYNAMIC-AABB-TREE) :pointer
  (self :pointer))

(export 'COMPOUND-SHAPE/GET-DYNAMIC-AABB-TREE)

(declaim (inline COMPOUND-SHAPE/GET-DYNAMIC-AABB-TREE))

(cffi:defcfun ("_wrap_btCompoundShape_getDynamicAabbTree__SWIG_1" COMPOUND-SHAPE/GET-DYNAMIC-AABB-TREE) :pointer
  (self :pointer))

(export 'COMPOUND-SHAPE/GET-DYNAMIC-AABB-TREE)

(declaim (inline COMPOUND-SHAPE/CREATE-AABB-TREE-FROM-CHILDREN))

(cffi:defcfun ("_wrap_btCompoundShape_createAabbTreeFromChildren" COMPOUND-SHAPE/CREATE-AABB-TREE-FROM-CHILDREN) :void
  (self :pointer))

(export 'COMPOUND-SHAPE/CREATE-AABB-TREE-FROM-CHILDREN)

(declaim (inline COMPOUND-SHAPE/CALCULATE-PRINCIPAL-AXIS-TRANSFORM))

(cffi:defcfun ("_wrap_btCompoundShape_calculatePrincipalAxisTransform" COMPOUND-SHAPE/CALCULATE-PRINCIPAL-AXIS-TRANSFORM) :void
  (self :pointer)
  (masses :pointer)
  (principal :pointer)
  (inertia :pointer))

(export 'COMPOUND-SHAPE/CALCULATE-PRINCIPAL-AXIS-TRANSFORM)

(declaim (inline COMPOUND-SHAPE/GET-UPDATE-REVISION))

(cffi:defcfun ("_wrap_btCompoundShape_getUpdateRevision" COMPOUND-SHAPE/GET-UPDATE-REVISION) :int
  (self :pointer))

(export 'COMPOUND-SHAPE/GET-UPDATE-REVISION)

(declaim (inline COMPOUND-SHAPE/CALCULATE-SERIALIZE-BUFFER-SIZE))

(cffi:defcfun ("_wrap_btCompoundShape_calculateSerializeBufferSize" COMPOUND-SHAPE/CALCULATE-SERIALIZE-BUFFER-SIZE) :int
  (self :pointer))

(export 'COMPOUND-SHAPE/CALCULATE-SERIALIZE-BUFFER-SIZE)

(declaim (inline COMPOUND-SHAPE/SERIALIZE))

(cffi:defcfun ("_wrap_btCompoundShape_serialize" COMPOUND-SHAPE/SERIALIZE) :string
  (self :pointer)
  (dataBuffer :pointer)
  (serializer :pointer))

(export 'COMPOUND-SHAPE/SERIALIZE)

(cffi:defcstruct COMPOUND-SHAPE-CHILD-DATA
  (TRANSFORM TRANSFORM-FLOAT-DATA)
  (CHILD-SHAPE :pointer)
  (CHILD-SHAPE-TYPE :int)
  (CHILD-MARGIN :float))

(export 'COMPOUND-SHAPE-CHILD-DATA)

(export 'TRANSFORM)

(export 'CHILD-SHAPE)

(export 'CHILD-SHAPE-TYPE)

(export 'CHILD-MARGIN)

(cffi:defcstruct COMPOUND-SHAPE-DATA
  (COLLISION-SHAPE-DATA :pointer)
  (CHILD-SHAPE-PTR :pointer)
  (NUM-CHILD-SHAPES :int)
  (COLLISION-MARGIN :float))

(export 'COMPOUND-SHAPE-DATA)

(export 'COLLISION-SHAPE-DATA)

(export 'CHILD-SHAPE-PTR)

(export 'NUM-CHILD-SHAPES)

(export 'COLLISION-MARGIN)

(declaim (inline BU/SIMPLEX-1TO-4/MAKE-CPLUS-PLUS-INSTANCE))

(cffi:defcfun ("_wrap_btBU_Simplex1to4_makeCPlusPlusInstance__SWIG_0" BU/SIMPLEX-1TO-4/MAKE-CPLUS-PLUS-INSTANCE) :pointer
  (self :pointer)
  (sizeInBytes :pointer))

(export 'BU/SIMPLEX-1TO-4/MAKE-CPLUS-PLUS-INSTANCE)

(declaim (inline BU/SIMPLEX-1TO-4/DELETE-CPLUS-PLUS-INSTANCE))

(cffi:defcfun ("_wrap_btBU_Simplex1to4_deleteCPlusPlusInstance__SWIG_0" BU/SIMPLEX-1TO-4/DELETE-CPLUS-PLUS-INSTANCE) :void
  (self :pointer)
  (ptr :pointer))

(export 'BU/SIMPLEX-1TO-4/DELETE-CPLUS-PLUS-INSTANCE)

(declaim (inline BU/SIMPLEX-1TO-4/MAKE-CPLUS-PLUS-INSTANCE))

(cffi:defcfun ("_wrap_btBU_Simplex1to4_makeCPlusPlusInstance__SWIG_1" BU/SIMPLEX-1TO-4/MAKE-CPLUS-PLUS-INSTANCE) :pointer
  (self :pointer)
  (arg1 :pointer)
  (ptr :pointer))

(export 'BU/SIMPLEX-1TO-4/MAKE-CPLUS-PLUS-INSTANCE)

(declaim (inline BU/SIMPLEX-1TO-4/DELETE-CPLUS-PLUS-INSTANCE))

(cffi:defcfun ("_wrap_btBU_Simplex1to4_deleteCPlusPlusInstance__SWIG_1" BU/SIMPLEX-1TO-4/DELETE-CPLUS-PLUS-INSTANCE) :void
  (self :pointer)
  (arg1 :pointer)
  (arg2 :pointer))

(export 'BU/SIMPLEX-1TO-4/DELETE-CPLUS-PLUS-INSTANCE)

(declaim (inline BU/SIMPLEX-1TO-4/MAKE-CPLUS-ARRAY))

(cffi:defcfun ("_wrap_btBU_Simplex1to4_makeCPlusArray__SWIG_0" BU/SIMPLEX-1TO-4/MAKE-CPLUS-ARRAY) :pointer
  (self :pointer)
  (sizeInBytes :pointer))

(export 'BU/SIMPLEX-1TO-4/MAKE-CPLUS-ARRAY)

(declaim (inline BU/SIMPLEX-1TO-4/DELETE-CPLUS-ARRAY))

(cffi:defcfun ("_wrap_btBU_Simplex1to4_deleteCPlusArray__SWIG_0" BU/SIMPLEX-1TO-4/DELETE-CPLUS-ARRAY) :void
  (self :pointer)
  (ptr :pointer))

(export 'BU/SIMPLEX-1TO-4/DELETE-CPLUS-ARRAY)

(declaim (inline BU/SIMPLEX-1TO-4/MAKE-CPLUS-ARRAY))

(cffi:defcfun ("_wrap_btBU_Simplex1to4_makeCPlusArray__SWIG_1" BU/SIMPLEX-1TO-4/MAKE-CPLUS-ARRAY) :pointer
  (self :pointer)
  (arg1 :pointer)
  (ptr :pointer))

(export 'BU/SIMPLEX-1TO-4/MAKE-CPLUS-ARRAY)

(declaim (inline BU/SIMPLEX-1TO-4/DELETE-CPLUS-ARRAY))

(cffi:defcfun ("_wrap_btBU_Simplex1to4_deleteCPlusArray__SWIG_1" BU/SIMPLEX-1TO-4/DELETE-CPLUS-ARRAY) :void
  (self :pointer)
  (arg1 :pointer)
  (arg2 :pointer))

(export 'BU/SIMPLEX-1TO-4/DELETE-CPLUS-ARRAY)

(declaim (inline MAKE-BU/SIMPLEX-1TO-4))

(cffi:defcfun ("_wrap_new_btBU_Simplex1to4__SWIG_0" MAKE-BU/SIMPLEX-1TO-4) :pointer)

(export 'MAKE-BU/SIMPLEX-1TO-4)

(declaim (inline MAKE-BU/SIMPLEX-1TO-4))

(cffi:defcfun ("_wrap_new_btBU_Simplex1to4__SWIG_1" MAKE-BU/SIMPLEX-1TO-4) :pointer
  (pt0 :pointer))

(export 'MAKE-BU/SIMPLEX-1TO-4)

(declaim (inline MAKE-BU/SIMPLEX-1TO-4))

(cffi:defcfun ("_wrap_new_btBU_Simplex1to4__SWIG_2" MAKE-BU/SIMPLEX-1TO-4) :pointer
  (pt0 :pointer)
  (pt1 :pointer))

(export 'MAKE-BU/SIMPLEX-1TO-4)

(declaim (inline MAKE-BU/SIMPLEX-1TO-4))

(cffi:defcfun ("_wrap_new_btBU_Simplex1to4__SWIG_3" MAKE-BU/SIMPLEX-1TO-4) :pointer
  (pt0 :pointer)
  (pt1 :pointer)
  (pt2 :pointer))

(export 'MAKE-BU/SIMPLEX-1TO-4)

(declaim (inline MAKE-BU/SIMPLEX-1TO-4))

(cffi:defcfun ("_wrap_new_btBU_Simplex1to4__SWIG_4" MAKE-BU/SIMPLEX-1TO-4) :pointer
  (pt0 :pointer)
  (pt1 :pointer)
  (pt2 :pointer)
  (pt3 :pointer))

(export 'MAKE-BU/SIMPLEX-1TO-4)

(declaim (inline BU/SIMPLEX-1TO-4/RESET))

(cffi:defcfun ("_wrap_btBU_Simplex1to4_reset" BU/SIMPLEX-1TO-4/RESET) :void
  (self :pointer))

(export 'BU/SIMPLEX-1TO-4/RESET)

(declaim (inline BU/SIMPLEX-1TO-4/GET-AABB))

(cffi:defcfun ("_wrap_btBU_Simplex1to4_getAabb" BU/SIMPLEX-1TO-4/GET-AABB) :void
  (self :pointer)
  (t_arg1 :pointer)
  (aabbMin :pointer)
  (aabbMax :pointer))

(export 'BU/SIMPLEX-1TO-4/GET-AABB)

(declaim (inline BU/SIMPLEX-1TO-4/ADD-VERTEX))

(cffi:defcfun ("_wrap_btBU_Simplex1to4_addVertex" BU/SIMPLEX-1TO-4/ADD-VERTEX) :void
  (self :pointer)
  (pt :pointer))

(export 'BU/SIMPLEX-1TO-4/ADD-VERTEX)

(declaim (inline BU/SIMPLEX-1TO-4/GET-NUM-VERTICES))

(cffi:defcfun ("_wrap_btBU_Simplex1to4_getNumVertices" BU/SIMPLEX-1TO-4/GET-NUM-VERTICES) :int
  (self :pointer))

(export 'BU/SIMPLEX-1TO-4/GET-NUM-VERTICES)

(declaim (inline BU/SIMPLEX-1TO-4/GET-NUM-EDGES))

(cffi:defcfun ("_wrap_btBU_Simplex1to4_getNumEdges" BU/SIMPLEX-1TO-4/GET-NUM-EDGES) :int
  (self :pointer))

(export 'BU/SIMPLEX-1TO-4/GET-NUM-EDGES)

(declaim (inline BU/SIMPLEX-1TO-4/GET-EDGE))

(cffi:defcfun ("_wrap_btBU_Simplex1to4_getEdge" BU/SIMPLEX-1TO-4/GET-EDGE) :void
  (self :pointer)
  (i :int)
  (pa :pointer)
  (pb :pointer))

(export 'BU/SIMPLEX-1TO-4/GET-EDGE)

(declaim (inline BU/SIMPLEX-1TO-4/GET-VERTEX))

(cffi:defcfun ("_wrap_btBU_Simplex1to4_getVertex" BU/SIMPLEX-1TO-4/GET-VERTEX) :void
  (self :pointer)
  (i :int)
  (vtx :pointer))

(export 'BU/SIMPLEX-1TO-4/GET-VERTEX)

(declaim (inline BU/SIMPLEX-1TO-4/GET-NUM-PLANES))

(cffi:defcfun ("_wrap_btBU_Simplex1to4_getNumPlanes" BU/SIMPLEX-1TO-4/GET-NUM-PLANES) :int
  (self :pointer))

(export 'BU/SIMPLEX-1TO-4/GET-NUM-PLANES)

(declaim (inline BU/SIMPLEX-1TO-4/GET-PLANE))

(cffi:defcfun ("_wrap_btBU_Simplex1to4_getPlane" BU/SIMPLEX-1TO-4/GET-PLANE) :void
  (self :pointer)
  (planeNormal :pointer)
  (planeSupport :pointer)
  (i :int))

(export 'BU/SIMPLEX-1TO-4/GET-PLANE)

(declaim (inline BU/SIMPLEX-1TO-4/GET-INDEX))

(cffi:defcfun ("_wrap_btBU_Simplex1to4_getIndex" BU/SIMPLEX-1TO-4/GET-INDEX) :int
  (self :pointer)
  (i :int))

(export 'BU/SIMPLEX-1TO-4/GET-INDEX)

(declaim (inline BU/SIMPLEX-1TO-4/IS-INSIDE))

(cffi:defcfun ("_wrap_btBU_Simplex1to4_isInside" BU/SIMPLEX-1TO-4/IS-INSIDE) :pointer
  (self :pointer)
  (pt :pointer)
  (tolerance :float))

(export 'BU/SIMPLEX-1TO-4/IS-INSIDE)

(declaim (inline BU/SIMPLEX-1TO-4/GET-NAME))

(cffi:defcfun ("_wrap_btBU_Simplex1to4_getName" BU/SIMPLEX-1TO-4/GET-NAME) :string
  (self :pointer))

(export 'BU/SIMPLEX-1TO-4/GET-NAME)

(declaim (inline DELETE/BT-BU/SIMPLEX-1TO-4))

(cffi:defcfun ("_wrap_delete_btBU_Simplex1to4" DELETE/BT-BU/SIMPLEX-1TO-4) :void
  (self :pointer))

(export 'DELETE/BT-BU/SIMPLEX-1TO-4)

(declaim (inline EMPTY-SHAPE/MAKE-CPLUS-PLUS-INSTANCE))

(cffi:defcfun ("_wrap_btEmptyShape_makeCPlusPlusInstance__SWIG_0" EMPTY-SHAPE/MAKE-CPLUS-PLUS-INSTANCE) :pointer
  (self :pointer)
  (sizeInBytes :pointer))

(export 'EMPTY-SHAPE/MAKE-CPLUS-PLUS-INSTANCE)

(declaim (inline EMPTY-SHAPE/DELETE-CPLUS-PLUS-INSTANCE))

(cffi:defcfun ("_wrap_btEmptyShape_deleteCPlusPlusInstance__SWIG_0" EMPTY-SHAPE/DELETE-CPLUS-PLUS-INSTANCE) :void
  (self :pointer)
  (ptr :pointer))

(export 'EMPTY-SHAPE/DELETE-CPLUS-PLUS-INSTANCE)

(declaim (inline EMPTY-SHAPE/MAKE-CPLUS-PLUS-INSTANCE))

(cffi:defcfun ("_wrap_btEmptyShape_makeCPlusPlusInstance__SWIG_1" EMPTY-SHAPE/MAKE-CPLUS-PLUS-INSTANCE) :pointer
  (self :pointer)
  (arg1 :pointer)
  (ptr :pointer))

(export 'EMPTY-SHAPE/MAKE-CPLUS-PLUS-INSTANCE)

(declaim (inline EMPTY-SHAPE/DELETE-CPLUS-PLUS-INSTANCE))

(cffi:defcfun ("_wrap_btEmptyShape_deleteCPlusPlusInstance__SWIG_1" EMPTY-SHAPE/DELETE-CPLUS-PLUS-INSTANCE) :void
  (self :pointer)
  (arg1 :pointer)
  (arg2 :pointer))

(export 'EMPTY-SHAPE/DELETE-CPLUS-PLUS-INSTANCE)

(declaim (inline EMPTY-SHAPE/MAKE-CPLUS-ARRAY))

(cffi:defcfun ("_wrap_btEmptyShape_makeCPlusArray__SWIG_0" EMPTY-SHAPE/MAKE-CPLUS-ARRAY) :pointer
  (self :pointer)
  (sizeInBytes :pointer))

(export 'EMPTY-SHAPE/MAKE-CPLUS-ARRAY)

(declaim (inline EMPTY-SHAPE/DELETE-CPLUS-ARRAY))

(cffi:defcfun ("_wrap_btEmptyShape_deleteCPlusArray__SWIG_0" EMPTY-SHAPE/DELETE-CPLUS-ARRAY) :void
  (self :pointer)
  (ptr :pointer))

(export 'EMPTY-SHAPE/DELETE-CPLUS-ARRAY)

(declaim (inline EMPTY-SHAPE/MAKE-CPLUS-ARRAY))

(cffi:defcfun ("_wrap_btEmptyShape_makeCPlusArray__SWIG_1" EMPTY-SHAPE/MAKE-CPLUS-ARRAY) :pointer
  (self :pointer)
  (arg1 :pointer)
  (ptr :pointer))

(export 'EMPTY-SHAPE/MAKE-CPLUS-ARRAY)

(declaim (inline EMPTY-SHAPE/DELETE-CPLUS-ARRAY))

(cffi:defcfun ("_wrap_btEmptyShape_deleteCPlusArray__SWIG_1" EMPTY-SHAPE/DELETE-CPLUS-ARRAY) :void
  (self :pointer)
  (arg1 :pointer)
  (arg2 :pointer))

(export 'EMPTY-SHAPE/DELETE-CPLUS-ARRAY)

(declaim (inline MAKE-EMPTY-SHAPE))

(cffi:defcfun ("_wrap_new_btEmptyShape" MAKE-EMPTY-SHAPE) :pointer)

(export 'MAKE-EMPTY-SHAPE)

(declaim (inline DELETE/BT-EMPTY-SHAPE))

(cffi:defcfun ("_wrap_delete_btEmptyShape" DELETE/BT-EMPTY-SHAPE) :void
  (self :pointer))

(export 'DELETE/BT-EMPTY-SHAPE)

(declaim (inline EMPTY-SHAPE/GET-AABB))

(cffi:defcfun ("_wrap_btEmptyShape_getAabb" EMPTY-SHAPE/GET-AABB) :void
  (self :pointer)
  (t_arg1 :pointer)
  (aabbMin :pointer)
  (aabbMax :pointer))

(export 'EMPTY-SHAPE/GET-AABB)

(declaim (inline EMPTY-SHAPE/SET-LOCAL-SCALING))

(cffi:defcfun ("_wrap_btEmptyShape_setLocalScaling" EMPTY-SHAPE/SET-LOCAL-SCALING) :void
  (self :pointer)
  (scaling :pointer))

(export 'EMPTY-SHAPE/SET-LOCAL-SCALING)

(declaim (inline EMPTY-SHAPE/GET-LOCAL-SCALING))

(cffi:defcfun ("_wrap_btEmptyShape_getLocalScaling" EMPTY-SHAPE/GET-LOCAL-SCALING) :pointer
  (self :pointer))

(export 'EMPTY-SHAPE/GET-LOCAL-SCALING)

(declaim (inline EMPTY-SHAPE/CALCULATE-LOCAL-INERTIA))

(cffi:defcfun ("_wrap_btEmptyShape_calculateLocalInertia" EMPTY-SHAPE/CALCULATE-LOCAL-INERTIA) :void
  (self :pointer)
  (mass :float)
  (inertia :pointer))

(export 'EMPTY-SHAPE/CALCULATE-LOCAL-INERTIA)

(declaim (inline EMPTY-SHAPE/GET-NAME))

(cffi:defcfun ("_wrap_btEmptyShape_getName" EMPTY-SHAPE/GET-NAME) :string
  (self :pointer))

(export 'EMPTY-SHAPE/GET-NAME)

(declaim (inline EMPTY-SHAPE/PROCESS-ALL-TRIANGLES))

(cffi:defcfun ("_wrap_btEmptyShape_processAllTriangles" EMPTY-SHAPE/PROCESS-ALL-TRIANGLES) :void
  (self :pointer)
  (arg1 :pointer)
  (arg2 :pointer)
  (arg3 :pointer))

(export 'EMPTY-SHAPE/PROCESS-ALL-TRIANGLES)

(declaim (inline MULTI-SPHERE-SHAPE/MAKE-CPLUS-PLUS-INSTANCE))

(cffi:defcfun ("_wrap_btMultiSphereShape_makeCPlusPlusInstance__SWIG_0" MULTI-SPHERE-SHAPE/MAKE-CPLUS-PLUS-INSTANCE) :pointer
  (self :pointer)
  (sizeInBytes :pointer))

(export 'MULTI-SPHERE-SHAPE/MAKE-CPLUS-PLUS-INSTANCE)

(declaim (inline MULTI-SPHERE-SHAPE/DELETE-CPLUS-PLUS-INSTANCE))

(cffi:defcfun ("_wrap_btMultiSphereShape_deleteCPlusPlusInstance__SWIG_0" MULTI-SPHERE-SHAPE/DELETE-CPLUS-PLUS-INSTANCE) :void
  (self :pointer)
  (ptr :pointer))

(export 'MULTI-SPHERE-SHAPE/DELETE-CPLUS-PLUS-INSTANCE)

(declaim (inline MULTI-SPHERE-SHAPE/MAKE-CPLUS-PLUS-INSTANCE))

(cffi:defcfun ("_wrap_btMultiSphereShape_makeCPlusPlusInstance__SWIG_1" MULTI-SPHERE-SHAPE/MAKE-CPLUS-PLUS-INSTANCE) :pointer
  (self :pointer)
  (arg1 :pointer)
  (ptr :pointer))

(export 'MULTI-SPHERE-SHAPE/MAKE-CPLUS-PLUS-INSTANCE)

(declaim (inline MULTI-SPHERE-SHAPE/DELETE-CPLUS-PLUS-INSTANCE))

(cffi:defcfun ("_wrap_btMultiSphereShape_deleteCPlusPlusInstance__SWIG_1" MULTI-SPHERE-SHAPE/DELETE-CPLUS-PLUS-INSTANCE) :void
  (self :pointer)
  (arg1 :pointer)
  (arg2 :pointer))

(export 'MULTI-SPHERE-SHAPE/DELETE-CPLUS-PLUS-INSTANCE)

(declaim (inline MULTI-SPHERE-SHAPE/MAKE-CPLUS-ARRAY))

(cffi:defcfun ("_wrap_btMultiSphereShape_makeCPlusArray__SWIG_0" MULTI-SPHERE-SHAPE/MAKE-CPLUS-ARRAY) :pointer
  (self :pointer)
  (sizeInBytes :pointer))

(export 'MULTI-SPHERE-SHAPE/MAKE-CPLUS-ARRAY)

(declaim (inline MULTI-SPHERE-SHAPE/DELETE-CPLUS-ARRAY))

(cffi:defcfun ("_wrap_btMultiSphereShape_deleteCPlusArray__SWIG_0" MULTI-SPHERE-SHAPE/DELETE-CPLUS-ARRAY) :void
  (self :pointer)
  (ptr :pointer))

(export 'MULTI-SPHERE-SHAPE/DELETE-CPLUS-ARRAY)

(declaim (inline MULTI-SPHERE-SHAPE/MAKE-CPLUS-ARRAY))

(cffi:defcfun ("_wrap_btMultiSphereShape_makeCPlusArray__SWIG_1" MULTI-SPHERE-SHAPE/MAKE-CPLUS-ARRAY) :pointer
  (self :pointer)
  (arg1 :pointer)
  (ptr :pointer))

(export 'MULTI-SPHERE-SHAPE/MAKE-CPLUS-ARRAY)

(declaim (inline MULTI-SPHERE-SHAPE/DELETE-CPLUS-ARRAY))

(cffi:defcfun ("_wrap_btMultiSphereShape_deleteCPlusArray__SWIG_1" MULTI-SPHERE-SHAPE/DELETE-CPLUS-ARRAY) :void
  (self :pointer)
  (arg1 :pointer)
  (arg2 :pointer))

(export 'MULTI-SPHERE-SHAPE/DELETE-CPLUS-ARRAY)

(declaim (inline MAKE-MULTI-SPHERE-SHAPE))

(cffi:defcfun ("_wrap_new_btMultiSphereShape" MAKE-MULTI-SPHERE-SHAPE) :pointer
  (positions :pointer)
  (radi :pointer)
  (numSpheres :int))

(export 'MAKE-MULTI-SPHERE-SHAPE)

(declaim (inline MULTI-SPHERE-SHAPE/CALCULATE-LOCAL-INERTIA))

(cffi:defcfun ("_wrap_btMultiSphereShape_calculateLocalInertia" MULTI-SPHERE-SHAPE/CALCULATE-LOCAL-INERTIA) :void
  (self :pointer)
  (mass :float)
  (inertia :pointer))

(export 'MULTI-SPHERE-SHAPE/CALCULATE-LOCAL-INERTIA)

(declaim (inline MULTI-SPHERE-SHAPE/LOCAL-GET-SUPPORTING-VERTEX-WITHOUT-MARGIN))

(cffi:defcfun ("_wrap_btMultiSphereShape_localGetSupportingVertexWithoutMargin" MULTI-SPHERE-SHAPE/LOCAL-GET-SUPPORTING-VERTEX-WITHOUT-MARGIN) :pointer
  (self :pointer)
  (vec :pointer))

(export 'MULTI-SPHERE-SHAPE/LOCAL-GET-SUPPORTING-VERTEX-WITHOUT-MARGIN)

(declaim (inline MULTI-SPHERE-SHAPE/BATCHED-UNIT-VECTOR-GET-SUPPORTING-VERTEX-WITHOUT-MARGIN))

(cffi:defcfun ("_wrap_btMultiSphereShape_batchedUnitVectorGetSupportingVertexWithoutMargin" MULTI-SPHERE-SHAPE/BATCHED-UNIT-VECTOR-GET-SUPPORTING-VERTEX-WITHOUT-MARGIN) :void
  (self :pointer)
  (vectors :pointer)
  (supportVerticesOut :pointer)
  (numVectors :int))

(export 'MULTI-SPHERE-SHAPE/BATCHED-UNIT-VECTOR-GET-SUPPORTING-VERTEX-WITHOUT-MARGIN)

(declaim (inline MULTI-SPHERE-SHAPE/GET-SPHERE-COUNT))

(cffi:defcfun ("_wrap_btMultiSphereShape_getSphereCount" MULTI-SPHERE-SHAPE/GET-SPHERE-COUNT) :int
  (self :pointer))

(export 'MULTI-SPHERE-SHAPE/GET-SPHERE-COUNT)

(declaim (inline MULTI-SPHERE-SHAPE/GET-SPHERE-POSITION))

(cffi:defcfun ("_wrap_btMultiSphereShape_getSpherePosition" MULTI-SPHERE-SHAPE/GET-SPHERE-POSITION) :pointer
  (self :pointer)
  (index :int))

(export 'MULTI-SPHERE-SHAPE/GET-SPHERE-POSITION)

(declaim (inline MULTI-SPHERE-SHAPE/GET-SPHERE-RADIUS))

(cffi:defcfun ("_wrap_btMultiSphereShape_getSphereRadius" MULTI-SPHERE-SHAPE/GET-SPHERE-RADIUS) :float
  (self :pointer)
  (index :int))

(export 'MULTI-SPHERE-SHAPE/GET-SPHERE-RADIUS)

(declaim (inline MULTI-SPHERE-SHAPE/GET-NAME))

(cffi:defcfun ("_wrap_btMultiSphereShape_getName" MULTI-SPHERE-SHAPE/GET-NAME) :string
  (self :pointer))

(export 'MULTI-SPHERE-SHAPE/GET-NAME)

(declaim (inline MULTI-SPHERE-SHAPE/CALCULATE-SERIALIZE-BUFFER-SIZE))

(cffi:defcfun ("_wrap_btMultiSphereShape_calculateSerializeBufferSize" MULTI-SPHERE-SHAPE/CALCULATE-SERIALIZE-BUFFER-SIZE) :int
  (self :pointer))

(export 'MULTI-SPHERE-SHAPE/CALCULATE-SERIALIZE-BUFFER-SIZE)

(declaim (inline MULTI-SPHERE-SHAPE/SERIALIZE))

(cffi:defcfun ("_wrap_btMultiSphereShape_serialize" MULTI-SPHERE-SHAPE/SERIALIZE) :string
  (self :pointer)
  (dataBuffer :pointer)
  (serializer :pointer))

(export 'MULTI-SPHERE-SHAPE/SERIALIZE)

(declaim (inline DELETE/BT-MULTI-SPHERE-SHAPE))

(cffi:defcfun ("_wrap_delete_btMultiSphereShape" DELETE/BT-MULTI-SPHERE-SHAPE) :void
  (self :pointer))

(export 'DELETE/BT-MULTI-SPHERE-SHAPE)

(cffi:defcstruct POSITION-AND-RADIUS
  (POS VECTOR-3-FLOAT-DATA)
  (RADIUS :float))

(export 'POSITION-AND-RADIUS)

(export 'POS)

(export 'RADIUS)

(cffi:defcstruct MULTI-SPHERE-SHAPE-DATA
  (CONVEX-INTERNAL-SHAPE-DATA :pointer)
  (LOCAL-POSITION-ARRAY-PTR :pointer)
  (LOCAL-POSITION-ARRAY-SIZE :int)
  (PADDING :pointer))

(export 'MULTI-SPHERE-SHAPE-DATA)

(export 'CONVEX-INTERNAL-SHAPE-DATA)

(export 'LOCAL-POSITION-ARRAY-PTR)

(export 'LOCAL-POSITION-ARRAY-SIZE)

(export 'PADDING)

(declaim (inline UNIFORM-SCALING-SHAPE/MAKE-CPLUS-PLUS-INSTANCE))

(cffi:defcfun ("_wrap_btUniformScalingShape_makeCPlusPlusInstance__SWIG_0" UNIFORM-SCALING-SHAPE/MAKE-CPLUS-PLUS-INSTANCE) :pointer
  (self :pointer)
  (sizeInBytes :pointer))

(export 'UNIFORM-SCALING-SHAPE/MAKE-CPLUS-PLUS-INSTANCE)

(declaim (inline UNIFORM-SCALING-SHAPE/DELETE-CPLUS-PLUS-INSTANCE))

(cffi:defcfun ("_wrap_btUniformScalingShape_deleteCPlusPlusInstance__SWIG_0" UNIFORM-SCALING-SHAPE/DELETE-CPLUS-PLUS-INSTANCE) :void
  (self :pointer)
  (ptr :pointer))

(export 'UNIFORM-SCALING-SHAPE/DELETE-CPLUS-PLUS-INSTANCE)

(declaim (inline UNIFORM-SCALING-SHAPE/MAKE-CPLUS-PLUS-INSTANCE))

(cffi:defcfun ("_wrap_btUniformScalingShape_makeCPlusPlusInstance__SWIG_1" UNIFORM-SCALING-SHAPE/MAKE-CPLUS-PLUS-INSTANCE) :pointer
  (self :pointer)
  (arg1 :pointer)
  (ptr :pointer))

(export 'UNIFORM-SCALING-SHAPE/MAKE-CPLUS-PLUS-INSTANCE)

(declaim (inline UNIFORM-SCALING-SHAPE/DELETE-CPLUS-PLUS-INSTANCE))

(cffi:defcfun ("_wrap_btUniformScalingShape_deleteCPlusPlusInstance__SWIG_1" UNIFORM-SCALING-SHAPE/DELETE-CPLUS-PLUS-INSTANCE) :void
  (self :pointer)
  (arg1 :pointer)
  (arg2 :pointer))

(export 'UNIFORM-SCALING-SHAPE/DELETE-CPLUS-PLUS-INSTANCE)

(declaim (inline #.(lispify "btUniformScalingShape_makeCPlusArray" 'function)))

(cffi:defcfun ("_wrap_btUniformScalingShape_makeCPlusArray__SWIG_0" #.(lispify "btUniformScalingShape_makeCPlusArray" 'function)) :pointer
  (self :pointer)
  (sizeInBytes :pointer))

(export '#.(lispify "btUniformScalingShape_makeCPlusArray" 'function))

(declaim (inline #.(lispify "btUniformScalingShape_deleteCPlusArray" 'function)))

(cffi:defcfun ("_wrap_btUniformScalingShape_deleteCPlusArray__SWIG_0" #.(lispify "btUniformScalingShape_deleteCPlusArray" 'function)) :void
  (self :pointer)
  (ptr :pointer))

(export '#.(lispify "btUniformScalingShape_deleteCPlusArray" 'function))

(declaim (inline #.(lispify "btUniformScalingShape_makeCPlusArray" 'function)))

(cffi:defcfun ("_wrap_btUniformScalingShape_makeCPlusArray__SWIG_1" #.(lispify "btUniformScalingShape_makeCPlusArray" 'function)) :pointer
  (self :pointer)
  (arg1 :pointer)
  (ptr :pointer))

(export '#.(lispify "btUniformScalingShape_makeCPlusArray" 'function))

(declaim (inline #.(lispify "btUniformScalingShape_deleteCPlusArray" 'function)))

(cffi:defcfun ("_wrap_btUniformScalingShape_deleteCPlusArray__SWIG_1" #.(lispify "btUniformScalingShape_deleteCPlusArray" 'function)) :void
  (self :pointer)
  (arg1 :pointer)
  (arg2 :pointer))

(export '#.(lispify "btUniformScalingShape_deleteCPlusArray" 'function))

(declaim (inline #.(lispify "new_btUniformScalingShape" 'function)))

(cffi:defcfun ("_wrap_new_btUniformScalingShape" #.(lispify "new_btUniformScalingShape" 'function)) :pointer
  (convexChildShape :pointer)
  (uniformScalingFactor :float))

(export '#.(lispify "new_btUniformScalingShape" 'function))

(declaim (inline #.(lispify "delete_btUniformScalingShape" 'function)))

(cffi:defcfun ("_wrap_delete_btUniformScalingShape" #.(lispify "delete_btUniformScalingShape" 'function)) :void
  (self :pointer))

(export '#.(lispify "delete_btUniformScalingShape" 'function))

(declaim (inline #.(lispify "btUniformScalingShape_localGetSupportingVertexWithoutMargin" 'function)))

(cffi:defcfun ("_wrap_btUniformScalingShape_localGetSupportingVertexWithoutMargin" #.(lispify "btUniformScalingShape_localGetSupportingVertexWithoutMargin" 'function)) :pointer
  (self :pointer)
  (vec :pointer))

(export '#.(lispify "btUniformScalingShape_localGetSupportingVertexWithoutMargin" 'function))

(declaim (inline #.(lispify "btUniformScalingShape_localGetSupportingVertex" 'function)))

(cffi:defcfun ("_wrap_btUniformScalingShape_localGetSupportingVertex" #.(lispify "btUniformScalingShape_localGetSupportingVertex" 'function)) :pointer
  (self :pointer)
  (vec :pointer))

(export '#.(lispify "btUniformScalingShape_localGetSupportingVertex" 'function))

(declaim (inline #.(lispify "btUniformScalingShape_batchedUnitVectorGetSupportingVertexWithoutMargin" 'function)))

(cffi:defcfun ("_wrap_btUniformScalingShape_batchedUnitVectorGetSupportingVertexWithoutMargin" #.(lispify "btUniformScalingShape_batchedUnitVectorGetSupportingVertexWithoutMargin" 'function)) :void
  (self :pointer)
  (vectors :pointer)
  (supportVerticesOut :pointer)
  (numVectors :int))

(export '#.(lispify "btUniformScalingShape_batchedUnitVectorGetSupportingVertexWithoutMargin" 'function))

(declaim (inline #.(lispify "btUniformScalingShape_calculateLocalInertia" 'function)))

(cffi:defcfun ("_wrap_btUniformScalingShape_calculateLocalInertia" #.(lispify "btUniformScalingShape_calculateLocalInertia" 'function)) :void
  (self :pointer)
  (mass :float)
  (inertia :pointer))

(export '#.(lispify "btUniformScalingShape_calculateLocalInertia" 'function))

(declaim (inline #.(lispify "btUniformScalingShape_getUniformScalingFactor" 'function)))

(cffi:defcfun ("_wrap_btUniformScalingShape_getUniformScalingFactor" #.(lispify "btUniformScalingShape_getUniformScalingFactor" 'function)) :float
  (self :pointer))

(export '#.(lispify "btUniformScalingShape_getUniformScalingFactor" 'function))

(declaim (inline #.(lispify "btUniformScalingShape_getChildShape" 'function)))

(cffi:defcfun ("_wrap_btUniformScalingShape_getChildShape__SWIG_0" #.(lispify "btUniformScalingShape_getChildShape" 'function)) :pointer
  (self :pointer))

(export '#.(lispify "btUniformScalingShape_getChildShape" 'function))

(declaim (inline #.(lispify "btUniformScalingShape_getChildShape" 'function)))

(cffi:defcfun ("_wrap_btUniformScalingShape_getChildShape__SWIG_1" #.(lispify "btUniformScalingShape_getChildShape" 'function)) :pointer
  (self :pointer))

(export '#.(lispify "btUniformScalingShape_getChildShape" 'function))

(declaim (inline #.(lispify "btUniformScalingShape_getName" 'function)))

(cffi:defcfun ("_wrap_btUniformScalingShape_getName" #.(lispify "btUniformScalingShape_getName" 'function)) :string
  (self :pointer))

(export '#.(lispify "btUniformScalingShape_getName" 'function))

(declaim (inline #.(lispify "btUniformScalingShape_getAabb" 'function)))

(cffi:defcfun ("_wrap_btUniformScalingShape_getAabb" #.(lispify "btUniformScalingShape_getAabb" 'function)) :void
  (self :pointer)
  (t_arg1 :pointer)
  (aabbMin :pointer)
  (aabbMax :pointer))

(export '#.(lispify "btUniformScalingShape_getAabb" 'function))

(declaim (inline #.(lispify "btUniformScalingShape_getAabbSlow" 'function)))

(cffi:defcfun ("_wrap_btUniformScalingShape_getAabbSlow" #.(lispify "btUniformScalingShape_getAabbSlow" 'function)) :void
  (self :pointer)
  (t_arg1 :pointer)
  (aabbMin :pointer)
  (aabbMax :pointer))

(export '#.(lispify "btUniformScalingShape_getAabbSlow" 'function))

(declaim (inline #.(lispify "btUniformScalingShape_setLocalScaling" 'function)))

(cffi:defcfun ("_wrap_btUniformScalingShape_setLocalScaling" #.(lispify "btUniformScalingShape_setLocalScaling" 'function)) :void
  (self :pointer)
  (scaling :pointer))

(export '#.(lispify "btUniformScalingShape_setLocalScaling" 'function))

(declaim (inline #.(lispify "btUniformScalingShape_getLocalScaling" 'function)))

(cffi:defcfun ("_wrap_btUniformScalingShape_getLocalScaling" #.(lispify "btUniformScalingShape_getLocalScaling" 'function)) :pointer
  (self :pointer))

(export '#.(lispify "btUniformScalingShape_getLocalScaling" 'function))

(declaim (inline #.(lispify "btUniformScalingShape_setMargin" 'function)))

(cffi:defcfun ("_wrap_btUniformScalingShape_setMargin" #.(lispify "btUniformScalingShape_setMargin" 'function)) :void
  (self :pointer)
  (margin :float))

(export '#.(lispify "btUniformScalingShape_setMargin" 'function))

(declaim (inline #.(lispify "btUniformScalingShape_getMargin" 'function)))

(cffi:defcfun ("_wrap_btUniformScalingShape_getMargin" #.(lispify "btUniformScalingShape_getMargin" 'function)) :float
  (self :pointer))

(export '#.(lispify "btUniformScalingShape_getMargin" 'function))

(declaim (inline #.(lispify "btUniformScalingShape_getNumPreferredPenetrationDirections" 'function)))

(cffi:defcfun ("_wrap_btUniformScalingShape_getNumPreferredPenetrationDirections" #.(lispify "btUniformScalingShape_getNumPreferredPenetrationDirections" 'function)) :int
  (self :pointer))

(export '#.(lispify "btUniformScalingShape_getNumPreferredPenetrationDirections" 'function))

(declaim (inline #.(lispify "btUniformScalingShape_getPreferredPenetrationDirection" 'function)))

(cffi:defcfun ("_wrap_btUniformScalingShape_getPreferredPenetrationDirection" #.(lispify "btUniformScalingShape_getPreferredPenetrationDirection" 'function)) :void
  (self :pointer)
  (index :int)
  (penetrationVector :pointer))

(export '#.(lispify "btUniformScalingShape_getPreferredPenetrationDirection" 'function))

(declaim (inline #.(lispify "new_btSphereSphereCollisionAlgorithm" 'function)))

(cffi:defcfun ("_wrap_new_btSphereSphereCollisionAlgorithm__SWIG_0" #.(lispify "new_btSphereSphereCollisionAlgorithm" 'function)) :pointer
  (mf :pointer)
  (ci :pointer)
  (col0Wrap :pointer)
  (col1Wrap :pointer))

(export '#.(lispify "new_btSphereSphereCollisionAlgorithm" 'function))

(declaim (inline #.(lispify "new_btSphereSphereCollisionAlgorithm" 'function)))

(cffi:defcfun ("_wrap_new_btSphereSphereCollisionAlgorithm__SWIG_1" #.(lispify "new_btSphereSphereCollisionAlgorithm" 'function)) :pointer
  (ci :pointer))

(export '#.(lispify "new_btSphereSphereCollisionAlgorithm" 'function))

(declaim (inline #.(lispify "btSphereSphereCollisionAlgorithm_processCollision" 'function)))

(cffi:defcfun ("_wrap_btSphereSphereCollisionAlgorithm_processCollision" #.(lispify "btSphereSphereCollisionAlgorithm_processCollision" 'function)) :void
  (self :pointer)
  (body0Wrap :pointer)
  (body1Wrap :pointer)
  (dispatchInfo :pointer)
  (resultOut :pointer))

(export '#.(lispify "btSphereSphereCollisionAlgorithm_processCollision" 'function))

(declaim (inline #.(lispify "btSphereSphereCollisionAlgorithm_calculateTimeOfImpact" 'function)))

(cffi:defcfun ("_wrap_btSphereSphereCollisionAlgorithm_calculateTimeOfImpact" #.(lispify "btSphereSphereCollisionAlgorithm_calculateTimeOfImpact" 'function)) :float
  (self :pointer)
  (body0 :pointer)
  (body1 :pointer)
  (dispatchInfo :pointer)
  (resultOut :pointer))

(export '#.(lispify "btSphereSphereCollisionAlgorithm_calculateTimeOfImpact" 'function))

(declaim (inline #.(lispify "btSphereSphereCollisionAlgorithm_getAllContactManifolds" 'function)))

(cffi:defcfun ("_wrap_btSphereSphereCollisionAlgorithm_getAllContactManifolds" #.(lispify "btSphereSphereCollisionAlgorithm_getAllContactManifolds" 'function)) :void
  (self :pointer)
  (manifoldArray :pointer))

(export '#.(lispify "btSphereSphereCollisionAlgorithm_getAllContactManifolds" 'function))

(declaim (inline #.(lispify "delete_btSphereSphereCollisionAlgorithm" 'function)))

(cffi:defcfun ("_wrap_delete_btSphereSphereCollisionAlgorithm" #.(lispify "delete_btSphereSphereCollisionAlgorithm" 'function)) :void
  (self :pointer))

(export '#.(lispify "delete_btSphereSphereCollisionAlgorithm" 'function))

(cffi:defcstruct #.(lispify "btDefaultCollisionConstructionInfo" 'classname)
	(#.(lispify "m_persistentManifoldPool" 'slotname) :pointer)
	(#.(lispify "m_collisionAlgorithmPool" 'slotname) :pointer)
	(#.(lispify "m_defaultMaxPersistentManifoldPoolSize" 'slotname) :int)
	(#.(lispify "m_defaultMaxCollisionAlgorithmPoolSize" 'slotname) :int)
	(#.(lispify "m_customCollisionAlgorithmMaxElementSize" 'slotname) :int)
	(#.(lispify "m_useEpaPenetrationAlgorithm" 'slotname) :int))

(export '#.(lispify "btDefaultCollisionConstructionInfo" 'classname))

(export '#.(lispify "m_persistentManifoldPool" 'slotname))

(export '#.(lispify "m_collisionAlgorithmPool" 'slotname))

(export '#.(lispify "m_defaultMaxPersistentManifoldPoolSize" 'slotname))

(export '#.(lispify "m_defaultMaxCollisionAlgorithmPoolSize" 'slotname))

(export '#.(lispify "m_customCollisionAlgorithmMaxElementSize" 'slotname))

(export '#.(lispify "m_useEpaPenetrationAlgorithm" 'slotname))

(declaim (inline #.(lispify "new_btDefaultCollisionConfiguration" 'function)))

(cffi:defcfun ("_wrap_new_btDefaultCollisionConfiguration__SWIG_0" #.(lispify "new_btDefaultCollisionConfiguration" 'function)) :pointer
  (constructionInfo :pointer))

(export '#.(lispify "new_btDefaultCollisionConfiguration" 'function))

(declaim (inline #.(lispify "new_btDefaultCollisionConfiguration" 'function)))

(cffi:defcfun ("_wrap_new_btDefaultCollisionConfiguration__SWIG_1" #.(lispify "new_btDefaultCollisionConfiguration" 'function)) :pointer)

(export '#.(lispify "new_btDefaultCollisionConfiguration" 'function))

(declaim (inline #.(lispify "delete_btDefaultCollisionConfiguration" 'function)))

(cffi:defcfun ("_wrap_delete_btDefaultCollisionConfiguration" #.(lispify "delete_btDefaultCollisionConfiguration" 'function)) :void
  (self :pointer))

(export '#.(lispify "delete_btDefaultCollisionConfiguration" 'function))

(declaim (inline #.(lispify "btDefaultCollisionConfiguration_getPersistentManifoldPool" 'function)))

(cffi:defcfun ("_wrap_btDefaultCollisionConfiguration_getPersistentManifoldPool" #.(lispify "btDefaultCollisionConfiguration_getPersistentManifoldPool" 'function)) :pointer
  (self :pointer))

(export '#.(lispify "btDefaultCollisionConfiguration_getPersistentManifoldPool" 'function))

(declaim (inline #.(lispify "btDefaultCollisionConfiguration_getCollisionAlgorithmPool" 'function)))

(cffi:defcfun ("_wrap_btDefaultCollisionConfiguration_getCollisionAlgorithmPool" #.(lispify "btDefaultCollisionConfiguration_getCollisionAlgorithmPool" 'function)) :pointer
  (self :pointer))

(export '#.(lispify "btDefaultCollisionConfiguration_getCollisionAlgorithmPool" 'function))

(declaim (inline #.(lispify "btDefaultCollisionConfiguration_getSimplexSolver" 'function)))

(cffi:defcfun ("_wrap_btDefaultCollisionConfiguration_getSimplexSolver" #.(lispify "btDefaultCollisionConfiguration_getSimplexSolver" 'function)) :pointer
  (self :pointer))

(export '#.(lispify "btDefaultCollisionConfiguration_getSimplexSolver" 'function))

(declaim (inline #.(lispify "btDefaultCollisionConfiguration_getCollisionAlgorithmCreateFunc" 'function)))

(cffi:defcfun ("_wrap_btDefaultCollisionConfiguration_getCollisionAlgorithmCreateFunc" #.(lispify "btDefaultCollisionConfiguration_getCollisionAlgorithmCreateFunc" 'function)) :pointer
  (self :pointer)
  (proxyType0 :int)
  (proxyType1 :int))

(export '#.(lispify "btDefaultCollisionConfiguration_getCollisionAlgorithmCreateFunc" 'function))

(declaim (inline #.(lispify "btDefaultCollisionConfiguration_setConvexConvexMultipointIterations" 'function)))

(cffi:defcfun ("_wrap_btDefaultCollisionConfiguration_setConvexConvexMultipointIterations__SWIG_0" #.(lispify "btDefaultCollisionConfiguration_setConvexConvexMultipointIterations" 'function)) :void
  (self :pointer)
  (numPerturbationIterations :int)
  (minimumPointsPerturbationThreshold :int))

(export '#.(lispify "btDefaultCollisionConfiguration_setConvexConvexMultipointIterations" 'function))

(declaim (inline #.(lispify "btDefaultCollisionConfiguration_setConvexConvexMultipointIterations" 'function)))

(cffi:defcfun ("_wrap_btDefaultCollisionConfiguration_setConvexConvexMultipointIterations__SWIG_1" #.(lispify "btDefaultCollisionConfiguration_setConvexConvexMultipointIterations" 'function)) :void
  (self :pointer)
  (numPerturbationIterations :int))

(export '#.(lispify "btDefaultCollisionConfiguration_setConvexConvexMultipointIterations" 'function))

(declaim (inline #.(lispify "btDefaultCollisionConfiguration_setConvexConvexMultipointIterations" 'function)))

(cffi:defcfun ("_wrap_btDefaultCollisionConfiguration_setConvexConvexMultipointIterations__SWIG_2" #.(lispify "btDefaultCollisionConfiguration_setConvexConvexMultipointIterations" 'function)) :void
  (self :pointer))

(export '#.(lispify "btDefaultCollisionConfiguration_setConvexConvexMultipointIterations" 'function))

(declaim (inline #.(lispify "btDefaultCollisionConfiguration_setPlaneConvexMultipointIterations" 'function)))

(cffi:defcfun ("_wrap_btDefaultCollisionConfiguration_setPlaneConvexMultipointIterations__SWIG_0" #.(lispify "btDefaultCollisionConfiguration_setPlaneConvexMultipointIterations" 'function)) :void
  (self :pointer)
  (numPerturbationIterations :int)
  (minimumPointsPerturbationThreshold :int))

(export '#.(lispify "btDefaultCollisionConfiguration_setPlaneConvexMultipointIterations" 'function))

(declaim (inline #.(lispify "btDefaultCollisionConfiguration_setPlaneConvexMultipointIterations" 'function)))

(cffi:defcfun ("_wrap_btDefaultCollisionConfiguration_setPlaneConvexMultipointIterations__SWIG_1" #.(lispify "btDefaultCollisionConfiguration_setPlaneConvexMultipointIterations" 'function)) :void
  (self :pointer)
  (numPerturbationIterations :int))

(export '#.(lispify "btDefaultCollisionConfiguration_setPlaneConvexMultipointIterations" 'function))

(declaim (inline #.(lispify "btDefaultCollisionConfiguration_setPlaneConvexMultipointIterations" 'function)))

(cffi:defcfun ("_wrap_btDefaultCollisionConfiguration_setPlaneConvexMultipointIterations__SWIG_2" #.(lispify "btDefaultCollisionConfiguration_setPlaneConvexMultipointIterations" 'function)) :void
  (self :pointer))

(export '#.(lispify "btDefaultCollisionConfiguration_setPlaneConvexMultipointIterations" 'function))

(define-constant #.(lispify "USE_DISPATCH_REGISTRY_ARRAY" 'constant) 1)

(export '#.(lispify "USE_DISPATCH_REGISTRY_ARRAY" 'constant))

(cffi:defcenum #.(lispify "DispatcherFlags" 'enumname)
	(#.(lispify "CD_STATIC_STATIC_REPORTED" 'enumvalue :keyword) #.1)
	(#.(lispify "CD_USE_RELATIVE_CONTACT_BREAKING_THRESHOLD" 'enumvalue :keyword) #.2)
	(#.(lispify "CD_DISABLE_CONTACTPOOL_DYNAMIC_ALLOCATION" 'enumvalue :keyword) #.4))

(export '#.(lispify "DispatcherFlags" 'enumname))

(declaim (inline #.(lispify "btCollisionDispatcher_getDispatcherFlags" 'function)))

(cffi:defcfun ("_wrap_btCollisionDispatcher_getDispatcherFlags" #.(lispify "btCollisionDispatcher_getDispatcherFlags" 'function)) :int
  (self :pointer))

(export '#.(lispify "btCollisionDispatcher_getDispatcherFlags" 'function))

(declaim (inline #.(lispify "btCollisionDispatcher_setDispatcherFlags" 'function)))

(cffi:defcfun ("_wrap_btCollisionDispatcher_setDispatcherFlags" #.(lispify "btCollisionDispatcher_setDispatcherFlags" 'function)) :void
  (self :pointer)
  (flags :int))

(export '#.(lispify "btCollisionDispatcher_setDispatcherFlags" 'function))

(declaim (inline #.(lispify "btCollisionDispatcher_registerCollisionCreateFunc" 'function)))

(cffi:defcfun ("_wrap_btCollisionDispatcher_registerCollisionCreateFunc" #.(lispify "btCollisionDispatcher_registerCollisionCreateFunc" 'function)) :void
  (self :pointer)
  (proxyType0 :int)
  (proxyType1 :int)
  (createFunc :pointer))

(export '#.(lispify "btCollisionDispatcher_registerCollisionCreateFunc" 'function))

(declaim (inline #.(lispify "btCollisionDispatcher_getNumManifolds" 'function)))

(cffi:defcfun ("_wrap_btCollisionDispatcher_getNumManifolds" #.(lispify "btCollisionDispatcher_getNumManifolds" 'function)) :int
  (self :pointer))

(export '#.(lispify "btCollisionDispatcher_getNumManifolds" 'function))

(declaim (inline #.(lispify "btCollisionDispatcher_getInternalManifoldPointer" 'function)))

(cffi:defcfun ("_wrap_btCollisionDispatcher_getInternalManifoldPointer" #.(lispify "btCollisionDispatcher_getInternalManifoldPointer" 'function)) :pointer
  (self :pointer))

(export '#.(lispify "btCollisionDispatcher_getInternalManifoldPointer" 'function))

(declaim (inline #.(lispify "btCollisionDispatcher_getManifoldByIndexInternal" 'function)))

(cffi:defcfun ("_wrap_btCollisionDispatcher_getManifoldByIndexInternal__SWIG_0" #.(lispify "btCollisionDispatcher_getManifoldByIndexInternal" 'function)) :pointer
  (self :pointer)
  (index :int))

(export '#.(lispify "btCollisionDispatcher_getManifoldByIndexInternal" 'function))

(declaim (inline #.(lispify "btCollisionDispatcher_getManifoldByIndexInternal" 'function)))

(cffi:defcfun ("_wrap_btCollisionDispatcher_getManifoldByIndexInternal__SWIG_1" #.(lispify "btCollisionDispatcher_getManifoldByIndexInternal" 'function)) :pointer
  (self :pointer)
  (index :int))

(export '#.(lispify "btCollisionDispatcher_getManifoldByIndexInternal" 'function))

(declaim (inline #.(lispify "new_btCollisionDispatcher" 'function)))

(cffi:defcfun ("_wrap_new_btCollisionDispatcher" #.(lispify "new_btCollisionDispatcher" 'function)) :pointer
  (collisionConfiguration :pointer))

(export '#.(lispify "new_btCollisionDispatcher" 'function))

(declaim (inline #.(lispify "delete_btCollisionDispatcher" 'function)))

(cffi:defcfun ("_wrap_delete_btCollisionDispatcher" #.(lispify "delete_btCollisionDispatcher" 'function)) :void
  (self :pointer))

(export '#.(lispify "delete_btCollisionDispatcher" 'function))

(declaim (inline #.(lispify "btCollisionDispatcher_getNewManifold" 'function)))

(cffi:defcfun ("_wrap_btCollisionDispatcher_getNewManifold" #.(lispify "btCollisionDispatcher_getNewManifold" 'function)) :pointer
  (self :pointer)
  (b0 :pointer)
  (b1 :pointer))

(export '#.(lispify "btCollisionDispatcher_getNewManifold" 'function))

(declaim (inline #.(lispify "btCollisionDispatcher_releaseManifold" 'function)))

(cffi:defcfun ("_wrap_btCollisionDispatcher_releaseManifold" #.(lispify "btCollisionDispatcher_releaseManifold" 'function)) :void
  (self :pointer)
  (manifold :pointer))

(export '#.(lispify "btCollisionDispatcher_releaseManifold" 'function))

(declaim (inline #.(lispify "btCollisionDispatcher_clearManifold" 'function)))

(cffi:defcfun ("_wrap_btCollisionDispatcher_clearManifold" #.(lispify "btCollisionDispatcher_clearManifold" 'function)) :void
  (self :pointer)
  (manifold :pointer))

(export '#.(lispify "btCollisionDispatcher_clearManifold" 'function))

(declaim (inline #.(lispify "btCollisionDispatcher_findAlgorithm" 'function)))

(cffi:defcfun ("_wrap_btCollisionDispatcher_findAlgorithm__SWIG_0" #.(lispify "btCollisionDispatcher_findAlgorithm" 'function)) :pointer
  (self :pointer)
  (body0Wrap :pointer)
  (body1Wrap :pointer)
  (sharedManifold :pointer))

(export '#.(lispify "btCollisionDispatcher_findAlgorithm" 'function))

(declaim (inline #.(lispify "btCollisionDispatcher_findAlgorithm" 'function)))

(cffi:defcfun ("_wrap_btCollisionDispatcher_findAlgorithm__SWIG_1" #.(lispify "btCollisionDispatcher_findAlgorithm" 'function)) :pointer
  (self :pointer)
  (body0Wrap :pointer)
  (body1Wrap :pointer))

(export '#.(lispify "btCollisionDispatcher_findAlgorithm" 'function))

(declaim (inline #.(lispify "btCollisionDispatcher_needsCollision" 'function)))

(cffi:defcfun ("_wrap_btCollisionDispatcher_needsCollision" #.(lispify "btCollisionDispatcher_needsCollision" 'function)) :pointer
  (self :pointer)
  (body0 :pointer)
  (body1 :pointer))

(export '#.(lispify "btCollisionDispatcher_needsCollision" 'function))

(declaim (inline #.(lispify "btCollisionDispatcher_needsResponse" 'function)))

(cffi:defcfun ("_wrap_btCollisionDispatcher_needsResponse" #.(lispify "btCollisionDispatcher_needsResponse" 'function)) :pointer
  (self :pointer)
  (body0 :pointer)
  (body1 :pointer))

(export '#.(lispify "btCollisionDispatcher_needsResponse" 'function))

(declaim (inline #.(lispify "btCollisionDispatcher_dispatchAllCollisionPairs" 'function)))

(cffi:defcfun ("_wrap_btCollisionDispatcher_dispatchAllCollisionPairs" #.(lispify "btCollisionDispatcher_dispatchAllCollisionPairs" 'function)) :void
  (self :pointer)
  (pairCache :pointer)
  (dispatchInfo :pointer)
  (dispatcher :pointer))

(export '#.(lispify "btCollisionDispatcher_dispatchAllCollisionPairs" 'function))

(declaim (inline #.(lispify "btCollisionDispatcher_setNearCallback" 'function)))

(cffi:defcfun ("_wrap_btCollisionDispatcher_setNearCallback" #.(lispify "btCollisionDispatcher_setNearCallback" 'function)) :void
  (self :pointer)
  (nearCallback :pointer))

(export '#.(lispify "btCollisionDispatcher_setNearCallback" 'function))

(declaim (inline #.(lispify "btCollisionDispatcher_getNearCallback" 'function)))

(cffi:defcfun ("_wrap_btCollisionDispatcher_getNearCallback" #.(lispify "btCollisionDispatcher_getNearCallback" 'function)) :pointer
  (self :pointer))

(export '#.(lispify "btCollisionDispatcher_getNearCallback" 'function))

(declaim (inline #.(lispify "btCollisionDispatcher_defaultNearCallback" 'function)))

(cffi:defcfun ("_wrap_btCollisionDispatcher_defaultNearCallback" #.(lispify "btCollisionDispatcher_defaultNearCallback" 'function)) :void
  (collisionPair :pointer)
  (dispatcher :pointer)
  (dispatchInfo :pointer))

(export '#.(lispify "btCollisionDispatcher_defaultNearCallback" 'function))

(declaim (inline #.(lispify "btCollisionDispatcher_allocateCollisionAlgorithm" 'function)))

(cffi:defcfun ("_wrap_btCollisionDispatcher_allocateCollisionAlgorithm" #.(lispify "btCollisionDispatcher_allocateCollisionAlgorithm" 'function)) :pointer
  (self :pointer)
  (size :int))

(export '#.(lispify "btCollisionDispatcher_allocateCollisionAlgorithm" 'function))

(declaim (inline #.(lispify "btCollisionDispatcher_freeCollisionAlgorithm" 'function)))

(cffi:defcfun ("_wrap_btCollisionDispatcher_freeCollisionAlgorithm" #.(lispify "btCollisionDispatcher_freeCollisionAlgorithm" 'function)) :void
  (self :pointer)
  (ptr :pointer))

(export '#.(lispify "btCollisionDispatcher_freeCollisionAlgorithm" 'function))

(declaim (inline #.(lispify "btCollisionDispatcher_getCollisionConfiguration" 'function)))

(cffi:defcfun ("_wrap_btCollisionDispatcher_getCollisionConfiguration__SWIG_0" #.(lispify "btCollisionDispatcher_getCollisionConfiguration" 'function)) :pointer
  (self :pointer))

(export '#.(lispify "btCollisionDispatcher_getCollisionConfiguration" 'function))

(declaim (inline #.(lispify "btCollisionDispatcher_getCollisionConfiguration" 'function)))

(cffi:defcfun ("_wrap_btCollisionDispatcher_getCollisionConfiguration__SWIG_1" #.(lispify "btCollisionDispatcher_getCollisionConfiguration" 'function)) :pointer
  (self :pointer))

(export '#.(lispify "btCollisionDispatcher_getCollisionConfiguration" 'function))

(declaim (inline #.(lispify "btCollisionDispatcher_setCollisionConfiguration" 'function)))

(cffi:defcfun ("_wrap_btCollisionDispatcher_setCollisionConfiguration" #.(lispify "btCollisionDispatcher_setCollisionConfiguration" 'function)) :void
  (self :pointer)
  (config :pointer))

(export '#.(lispify "btCollisionDispatcher_setCollisionConfiguration" 'function))

(declaim (inline #.(lispify "btCollisionDispatcher_getInternalManifoldPool" 'function)))

(cffi:defcfun ("_wrap_btCollisionDispatcher_getInternalManifoldPool__SWIG_0" #.(lispify "btCollisionDispatcher_getInternalManifoldPool" 'function)) :pointer
  (self :pointer))

(export '#.(lispify "btCollisionDispatcher_getInternalManifoldPool" 'function))

(declaim (inline #.(lispify "btCollisionDispatcher_getInternalManifoldPool" 'function)))

(cffi:defcfun ("_wrap_btCollisionDispatcher_getInternalManifoldPool__SWIG_1" #.(lispify "btCollisionDispatcher_getInternalManifoldPool" 'function)) :pointer
  (self :pointer))

(export '#.(lispify "btCollisionDispatcher_getInternalManifoldPool" 'function))

(cffi:defcstruct #.(lispify "btSimpleBroadphaseProxy" 'classname)
	(#.(lispify "m_nextFree" 'slotname) :int)
	(#.(lispify "SetNextFree" 'slotname) :pointer)
	(#.(lispify "GetNextFree" 'slotname) :pointer))

(export '#.(lispify "btSimpleBroadphaseProxy" 'classname))

(export '#.(lispify "m_nextFree" 'slotname))

(export '#.(lispify "SetNextFree" 'slotname))

(export '#.(lispify "GetNextFree" 'slotname))

(declaim (inline #.(lispify "new_btSimpleBroadphase" 'function)))

(cffi:defcfun ("_wrap_new_btSimpleBroadphase__SWIG_0" #.(lispify "new_btSimpleBroadphase" 'function)) :pointer
  (maxProxies :int)
  (overlappingPairCache :pointer))

(export '#.(lispify "new_btSimpleBroadphase" 'function))

(declaim (inline #.(lispify "new_btSimpleBroadphase" 'function)))

(cffi:defcfun ("_wrap_new_btSimpleBroadphase__SWIG_1" #.(lispify "new_btSimpleBroadphase" 'function)) :pointer
  (maxProxies :int))

(export '#.(lispify "new_btSimpleBroadphase" 'function))

(declaim (inline #.(lispify "new_btSimpleBroadphase" 'function)))

(cffi:defcfun ("_wrap_new_btSimpleBroadphase__SWIG_2" #.(lispify "new_btSimpleBroadphase" 'function)) :pointer)

(export '#.(lispify "new_btSimpleBroadphase" 'function))

(declaim (inline #.(lispify "delete_btSimpleBroadphase" 'function)))

(cffi:defcfun ("_wrap_delete_btSimpleBroadphase" #.(lispify "delete_btSimpleBroadphase" 'function)) :void
  (self :pointer))

(export '#.(lispify "delete_btSimpleBroadphase" 'function))

(declaim (inline #.(lispify "btSimpleBroadphase_aabbOverlap" 'function)))

(cffi:defcfun ("_wrap_btSimpleBroadphase_aabbOverlap" #.(lispify "btSimpleBroadphase_aabbOverlap" 'function)) :pointer
  (proxy0 :pointer)
  (proxy1 :pointer))

(export '#.(lispify "btSimpleBroadphase_aabbOverlap" 'function))

(declaim (inline #.(lispify "btSimpleBroadphase_createProxy" 'function)))

(cffi:defcfun ("_wrap_btSimpleBroadphase_createProxy" #.(lispify "btSimpleBroadphase_createProxy" 'function)) :pointer
  (self :pointer)
  (aabbMin :pointer)
  (aabbMax :pointer)
  (shapeType :int)
  (userPtr :pointer)
  (collisionFilterGroup :short)
  (collisionFilterMask :short)
  (dispatcher :pointer)
  (multiSapProxy :pointer))

(export '#.(lispify "btSimpleBroadphase_createProxy" 'function))

(declaim (inline #.(lispify "btSimpleBroadphase_calculateOverlappingPairs" 'function)))

(cffi:defcfun ("_wrap_btSimpleBroadphase_calculateOverlappingPairs" #.(lispify "btSimpleBroadphase_calculateOverlappingPairs" 'function)) :void
  (self :pointer)
  (dispatcher :pointer))

(export '#.(lispify "btSimpleBroadphase_calculateOverlappingPairs" 'function))

(declaim (inline #.(lispify "btSimpleBroadphase_destroyProxy" 'function)))

(cffi:defcfun ("_wrap_btSimpleBroadphase_destroyProxy" #.(lispify "btSimpleBroadphase_destroyProxy" 'function)) :void
  (self :pointer)
  (proxy :pointer)
  (dispatcher :pointer))

(export '#.(lispify "btSimpleBroadphase_destroyProxy" 'function))

(declaim (inline #.(lispify "btSimpleBroadphase_setAabb" 'function)))

(cffi:defcfun ("_wrap_btSimpleBroadphase_setAabb" #.(lispify "btSimpleBroadphase_setAabb" 'function)) :void
  (self :pointer)
  (proxy :pointer)
  (aabbMin :pointer)
  (aabbMax :pointer)
  (dispatcher :pointer))

(export '#.(lispify "btSimpleBroadphase_setAabb" 'function))

(declaim (inline #.(lispify "btSimpleBroadphase_getAabb" 'function)))

(cffi:defcfun ("_wrap_btSimpleBroadphase_getAabb" #.(lispify "btSimpleBroadphase_getAabb" 'function)) :void
  (self :pointer)
  (proxy :pointer)
  (aabbMin :pointer)
  (aabbMax :pointer))

(export '#.(lispify "btSimpleBroadphase_getAabb" 'function))

(declaim (inline #.(lispify "btSimpleBroadphase_rayTest" 'function)))

(cffi:defcfun ("_wrap_btSimpleBroadphase_rayTest__SWIG_0" #.(lispify "btSimpleBroadphase_rayTest" 'function)) :void
  (self :pointer)
  (rayFrom :pointer)
  (rayTo :pointer)
  (rayCallback :pointer)
  (aabbMin :pointer)
  (aabbMax :pointer))

(export '#.(lispify "btSimpleBroadphase_rayTest" 'function))

(declaim (inline #.(lispify "btSimpleBroadphase_rayTest" 'function)))

(cffi:defcfun ("_wrap_btSimpleBroadphase_rayTest__SWIG_1" #.(lispify "btSimpleBroadphase_rayTest" 'function)) :void
  (self :pointer)
  (rayFrom :pointer)
  (rayTo :pointer)
  (rayCallback :pointer)
  (aabbMin :pointer))

(export '#.(lispify "btSimpleBroadphase_rayTest" 'function))

(declaim (inline #.(lispify "btSimpleBroadphase_rayTest" 'function)))

(cffi:defcfun ("_wrap_btSimpleBroadphase_rayTest__SWIG_2" #.(lispify "btSimpleBroadphase_rayTest" 'function)) :void
  (self :pointer)
  (rayFrom :pointer)
  (rayTo :pointer)
  (rayCallback :pointer))

(export '#.(lispify "btSimpleBroadphase_rayTest" 'function))

(declaim (inline #.(lispify "btSimpleBroadphase_aabbTest" 'function)))

(cffi:defcfun ("_wrap_btSimpleBroadphase_aabbTest" #.(lispify "btSimpleBroadphase_aabbTest" 'function)) :void
  (self :pointer)
  (aabbMin :pointer)
  (aabbMax :pointer)
  (callback :pointer))

(export '#.(lispify "btSimpleBroadphase_aabbTest" 'function))

(declaim (inline #.(lispify "btSimpleBroadphase_getOverlappingPairCache" 'function)))

(cffi:defcfun ("_wrap_btSimpleBroadphase_getOverlappingPairCache__SWIG_0" #.(lispify "btSimpleBroadphase_getOverlappingPairCache" 'function)) :pointer
  (self :pointer))

(export '#.(lispify "btSimpleBroadphase_getOverlappingPairCache" 'function))

(declaim (inline #.(lispify "btSimpleBroadphase_getOverlappingPairCache" 'function)))

(cffi:defcfun ("_wrap_btSimpleBroadphase_getOverlappingPairCache__SWIG_1" #.(lispify "btSimpleBroadphase_getOverlappingPairCache" 'function)) :pointer
  (self :pointer))

(export '#.(lispify "btSimpleBroadphase_getOverlappingPairCache" 'function))

(declaim (inline #.(lispify "btSimpleBroadphase_testAabbOverlap" 'function)))

(cffi:defcfun ("_wrap_btSimpleBroadphase_testAabbOverlap" #.(lispify "btSimpleBroadphase_testAabbOverlap" 'function)) :pointer
  (self :pointer)
  (proxy0 :pointer)
  (proxy1 :pointer))

(export '#.(lispify "btSimpleBroadphase_testAabbOverlap" 'function))

(declaim (inline #.(lispify "btSimpleBroadphase_getBroadphaseAabb" 'function)))

(cffi:defcfun ("_wrap_btSimpleBroadphase_getBroadphaseAabb" #.(lispify "btSimpleBroadphase_getBroadphaseAabb" 'function)) :void
  (self :pointer)
  (aabbMin :pointer)
  (aabbMax :pointer))

(export '#.(lispify "btSimpleBroadphase_getBroadphaseAabb" 'function))

(declaim (inline #.(lispify "btSimpleBroadphase_printStats" 'function)))

(cffi:defcfun ("_wrap_btSimpleBroadphase_printStats" #.(lispify "btSimpleBroadphase_printStats" 'function)) :void
  (self :pointer))

(export '#.(lispify "btSimpleBroadphase_printStats" 'function))

(define-constant #.(lispify "USE_OVERLAP_TEST_ON_REMOVES" 'constant) 1)

(export '#.(lispify "USE_OVERLAP_TEST_ON_REMOVES" 'constant))

(cffi:defcvar ("gOverlappingPairs" #.(lispify "gOverlappingPairs" 'variable))
 :int)

(export '#.(lispify "gOverlappingPairs" 'variable))

(declaim (inline #.(lispify "new_btAxisSweep3" 'function)))

(cffi:defcfun ("_wrap_new_btAxisSweep3__SWIG_0" #.(lispify "new_btAxisSweep3" 'function)) :pointer
  (worldAabbMin :pointer)
  (worldAabbMax :pointer)
  (maxHandles :unsigned-short)
  (pairCache :pointer)
  (disableRaycastAccelerator :pointer))

(export '#.(lispify "new_btAxisSweep3" 'function))

(declaim (inline #.(lispify "new_btAxisSweep3" 'function)))

(cffi:defcfun ("_wrap_new_btAxisSweep3__SWIG_1" #.(lispify "new_btAxisSweep3" 'function)) :pointer
  (worldAabbMin :pointer)
  (worldAabbMax :pointer)
  (maxHandles :unsigned-short)
  (pairCache :pointer))

(export '#.(lispify "new_btAxisSweep3" 'function))

(declaim (inline #.(lispify "new_btAxisSweep3" 'function)))

(cffi:defcfun ("_wrap_new_btAxisSweep3__SWIG_2" #.(lispify "new_btAxisSweep3" 'function)) :pointer
  (worldAabbMin :pointer)
  (worldAabbMax :pointer)
  (maxHandles :unsigned-short))

(export '#.(lispify "new_btAxisSweep3" 'function))

(declaim (inline #.(lispify "new_btAxisSweep3" 'function)))

(cffi:defcfun ("_wrap_new_btAxisSweep3__SWIG_3" #.(lispify "new_btAxisSweep3" 'function)) :pointer
  (worldAabbMin :pointer)
  (worldAabbMax :pointer))

(export '#.(lispify "new_btAxisSweep3" 'function))

(declaim (inline #.(lispify "delete_btAxisSweep3" 'function)))

(cffi:defcfun ("_wrap_delete_btAxisSweep3" #.(lispify "delete_btAxisSweep3" 'function)) :void
  (self :pointer))

(export '#.(lispify "delete_btAxisSweep3" 'function))

(declaim (inline #.(lispify "new_bt32BitAxisSweep3" 'function)))

(cffi:defcfun ("_wrap_new_bt32BitAxisSweep3__SWIG_0" #.(lispify "new_bt32BitAxisSweep3" 'function)) :pointer
  (worldAabbMin :pointer)
  (worldAabbMax :pointer)
  (maxHandles :unsigned-int)
  (pairCache :pointer)
  (disableRaycastAccelerator :pointer))

(export '#.(lispify "new_bt32BitAxisSweep3" 'function))

(declaim (inline #.(lispify "new_bt32BitAxisSweep3" 'function)))

(cffi:defcfun ("_wrap_new_bt32BitAxisSweep3__SWIG_1" #.(lispify "new_bt32BitAxisSweep3" 'function)) :pointer
  (worldAabbMin :pointer)
  (worldAabbMax :pointer)
  (maxHandles :unsigned-int)
  (pairCache :pointer))

(export '#.(lispify "new_bt32BitAxisSweep3" 'function))

(declaim (inline #.(lispify "new_bt32BitAxisSweep3" 'function)))

(cffi:defcfun ("_wrap_new_bt32BitAxisSweep3__SWIG_2" #.(lispify "new_bt32BitAxisSweep3" 'function)) :pointer
  (worldAabbMin :pointer)
  (worldAabbMax :pointer)
  (maxHandles :unsigned-int))

(export '#.(lispify "new_bt32BitAxisSweep3" 'function))

(declaim (inline #.(lispify "new_bt32BitAxisSweep3" 'function)))

(cffi:defcfun ("_wrap_new_bt32BitAxisSweep3__SWIG_3" #.(lispify "new_bt32BitAxisSweep3" 'function)) :pointer
  (worldAabbMin :pointer)
  (worldAabbMax :pointer))

(export '#.(lispify "new_bt32BitAxisSweep3" 'function))

(declaim (inline #.(lispify "delete_bt32BitAxisSweep3" 'function)))

(cffi:defcfun ("_wrap_delete_bt32BitAxisSweep3" #.(lispify "delete_bt32BitAxisSweep3" 'function)) :void
  (self :pointer))

(export '#.(lispify "delete_bt32BitAxisSweep3" 'function))

(declaim (inline #.(lispify "btMultiSapBroadphase_getBroadphaseArray" 'function)))

(cffi:defcfun ("_wrap_btMultiSapBroadphase_getBroadphaseArray__SWIG_0" #.(lispify "btMultiSapBroadphase_getBroadphaseArray" 'function)) :pointer
  (self :pointer))

(export '#.(lispify "btMultiSapBroadphase_getBroadphaseArray" 'function))

(declaim (inline #.(lispify "btMultiSapBroadphase_getBroadphaseArray" 'function)))

(cffi:defcfun ("_wrap_btMultiSapBroadphase_getBroadphaseArray__SWIG_1" #.(lispify "btMultiSapBroadphase_getBroadphaseArray" 'function)) :pointer
  (self :pointer))

(export '#.(lispify "btMultiSapBroadphase_getBroadphaseArray" 'function))

(declaim (inline #.(lispify "delete_btMultiSapBroadphase" 'function)))

(cffi:defcfun ("_wrap_delete_btMultiSapBroadphase" #.(lispify "delete_btMultiSapBroadphase" 'function)) :void
  (self :pointer))

(export '#.(lispify "delete_btMultiSapBroadphase" 'function))

(declaim (inline #.(lispify "btMultiSapBroadphase_createProxy" 'function)))

(cffi:defcfun ("_wrap_btMultiSapBroadphase_createProxy" #.(lispify "btMultiSapBroadphase_createProxy" 'function)) :pointer
  (self :pointer)
  (aabbMin :pointer)
  (aabbMax :pointer)
  (shapeType :int)
  (userPtr :pointer)
  (collisionFilterGroup :short)
  (collisionFilterMask :short)
  (dispatcher :pointer)
  (multiSapProxy :pointer))

(export '#.(lispify "btMultiSapBroadphase_createProxy" 'function))

(declaim (inline #.(lispify "btMultiSapBroadphase_destroyProxy" 'function)))

(cffi:defcfun ("_wrap_btMultiSapBroadphase_destroyProxy" #.(lispify "btMultiSapBroadphase_destroyProxy" 'function)) :void
  (self :pointer)
  (proxy :pointer)
  (dispatcher :pointer))

(export '#.(lispify "btMultiSapBroadphase_destroyProxy" 'function))

(declaim (inline #.(lispify "btMultiSapBroadphase_setAabb" 'function)))

(cffi:defcfun ("_wrap_btMultiSapBroadphase_setAabb" #.(lispify "btMultiSapBroadphase_setAabb" 'function)) :void
  (self :pointer)
  (proxy :pointer)
  (aabbMin :pointer)
  (aabbMax :pointer)
  (dispatcher :pointer))

(export '#.(lispify "btMultiSapBroadphase_setAabb" 'function))

(declaim (inline #.(lispify "btMultiSapBroadphase_getAabb" 'function)))

(cffi:defcfun ("_wrap_btMultiSapBroadphase_getAabb" #.(lispify "btMultiSapBroadphase_getAabb" 'function)) :void
  (self :pointer)
  (proxy :pointer)
  (aabbMin :pointer)
  (aabbMax :pointer))

(export '#.(lispify "btMultiSapBroadphase_getAabb" 'function))

(declaim (inline #.(lispify "btMultiSapBroadphase_rayTest" 'function)))

(cffi:defcfun ("_wrap_btMultiSapBroadphase_rayTest__SWIG_0" #.(lispify "btMultiSapBroadphase_rayTest" 'function)) :void
  (self :pointer)
  (rayFrom :pointer)
  (rayTo :pointer)
  (rayCallback :pointer)
  (aabbMin :pointer)
  (aabbMax :pointer))

(export '#.(lispify "btMultiSapBroadphase_rayTest" 'function))

(declaim (inline #.(lispify "btMultiSapBroadphase_rayTest" 'function)))

(cffi:defcfun ("_wrap_btMultiSapBroadphase_rayTest__SWIG_1" #.(lispify "btMultiSapBroadphase_rayTest" 'function)) :void
  (self :pointer)
  (rayFrom :pointer)
  (rayTo :pointer)
  (rayCallback :pointer)
  (aabbMin :pointer))

(export '#.(lispify "btMultiSapBroadphase_rayTest" 'function))

(declaim (inline #.(lispify "btMultiSapBroadphase_rayTest" 'function)))

(cffi:defcfun ("_wrap_btMultiSapBroadphase_rayTest__SWIG_2" #.(lispify "btMultiSapBroadphase_rayTest" 'function)) :void
  (self :pointer)
  (rayFrom :pointer)
  (rayTo :pointer)
  (rayCallback :pointer))

(export '#.(lispify "btMultiSapBroadphase_rayTest" 'function))

(declaim (inline #.(lispify "btMultiSapBroadphase_addToChildBroadphase" 'function)))

(cffi:defcfun ("_wrap_btMultiSapBroadphase_addToChildBroadphase" #.(lispify "btMultiSapBroadphase_addToChildBroadphase" 'function)) :void
  (self :pointer)
  (parentMultiSapProxy :pointer)
  (childProxy :pointer)
  (childBroadphase :pointer))

(export '#.(lispify "btMultiSapBroadphase_addToChildBroadphase" 'function))

(declaim (inline #.(lispify "btMultiSapBroadphase_calculateOverlappingPairs" 'function)))

(cffi:defcfun ("_wrap_btMultiSapBroadphase_calculateOverlappingPairs" #.(lispify "btMultiSapBroadphase_calculateOverlappingPairs" 'function)) :void
  (self :pointer)
  (dispatcher :pointer))

(export '#.(lispify "btMultiSapBroadphase_calculateOverlappingPairs" 'function))

(declaim (inline #.(lispify "btMultiSapBroadphase_testAabbOverlap" 'function)))

(cffi:defcfun ("_wrap_btMultiSapBroadphase_testAabbOverlap" #.(lispify "btMultiSapBroadphase_testAabbOverlap" 'function)) :pointer
  (self :pointer)
  (proxy0 :pointer)
  (proxy1 :pointer))

(export '#.(lispify "btMultiSapBroadphase_testAabbOverlap" 'function))

(declaim (inline #.(lispify "btMultiSapBroadphase_getOverlappingPairCache" 'function)))

(cffi:defcfun ("_wrap_btMultiSapBroadphase_getOverlappingPairCache__SWIG_0" #.(lispify "btMultiSapBroadphase_getOverlappingPairCache" 'function)) :pointer
  (self :pointer))

(export '#.(lispify "btMultiSapBroadphase_getOverlappingPairCache" 'function))

(declaim (inline #.(lispify "btMultiSapBroadphase_getOverlappingPairCache" 'function)))

(cffi:defcfun ("_wrap_btMultiSapBroadphase_getOverlappingPairCache__SWIG_1" #.(lispify "btMultiSapBroadphase_getOverlappingPairCache" 'function)) :pointer
  (self :pointer))

(export '#.(lispify "btMultiSapBroadphase_getOverlappingPairCache" 'function))

(declaim (inline #.(lispify "btMultiSapBroadphase_getBroadphaseAabb" 'function)))

(cffi:defcfun ("_wrap_btMultiSapBroadphase_getBroadphaseAabb" #.(lispify "btMultiSapBroadphase_getBroadphaseAabb" 'function)) :void
  (self :pointer)
  (aabbMin :pointer)
  (aabbMax :pointer))

(export '#.(lispify "btMultiSapBroadphase_getBroadphaseAabb" 'function))

(declaim (inline #.(lispify "btMultiSapBroadphase_buildTree" 'function)))

(cffi:defcfun ("_wrap_btMultiSapBroadphase_buildTree" #.(lispify "btMultiSapBroadphase_buildTree" 'function)) :void
  (self :pointer)
  (bvhAabbMin :pointer)
  (bvhAabbMax :pointer))

(export '#.(lispify "btMultiSapBroadphase_buildTree" 'function))

(declaim (inline #.(lispify "btMultiSapBroadphase_printStats" 'function)))

(cffi:defcfun ("_wrap_btMultiSapBroadphase_printStats" #.(lispify "btMultiSapBroadphase_printStats" 'function)) :void
  (self :pointer))

(export '#.(lispify "btMultiSapBroadphase_printStats" 'function))

(declaim (inline #.(lispify "btMultiSapBroadphase_quicksort" 'function)))

(cffi:defcfun ("_wrap_btMultiSapBroadphase_quicksort" #.(lispify "btMultiSapBroadphase_quicksort" 'function)) :void
  (self :pointer)
  (a :pointer)
  (lo :int)
  (hi :int))

(export '#.(lispify "btMultiSapBroadphase_quicksort" 'function))

(declaim (inline #.(lispify "btMultiSapBroadphase_resetPool" 'function)))

(cffi:defcfun ("_wrap_btMultiSapBroadphase_resetPool" #.(lispify "btMultiSapBroadphase_resetPool" 'function)) :void
  (self :pointer)
  (dispatcher :pointer))

(export '#.(lispify "btMultiSapBroadphase_resetPool" 'function))

(define-constant #.(lispify "DBVT_BP_PROFILE" 'constant) 0)

(export '#.(lispify "DBVT_BP_PROFILE" 'constant))

(define-constant #.(lispify "DBVT_BP_PREVENTFALSEUPDATE" 'constant) 0)

(export '#.(lispify "DBVT_BP_PREVENTFALSEUPDATE" 'constant))

(define-constant #.(lispify "DBVT_BP_ACCURATESLEEPING" 'constant) 0)

(export '#.(lispify "DBVT_BP_ACCURATESLEEPING" 'constant))

(define-constant #.(lispify "DBVT_BP_ENABLE_BENCHMARK" 'constant) 0)

(export '#.(lispify "DBVT_BP_ENABLE_BENCHMARK" 'constant))

(cffi:defcstruct #.(lispify "btDbvtProxy" 'classname)
	(#.(lispify "leaf" 'slotname) :pointer)
	(#.(lispify "links" 'slotname) :pointer)
	(#.(lispify "stage" 'slotname) :int))

(export '#.(lispify "btDbvtProxy" 'classname))

(export '#.(lispify "leaf" 'slotname))

(export '#.(lispify "links" 'slotname))

(export '#.(lispify "stage" 'slotname))

(cffi:defcstruct #.(lispify "btDbvtBroadphase" 'classname)
	(#.(lispify "m_sets" 'slotname) :pointer)
	(#.(lispify "m_stageRoots" 'slotname) :pointer)
	(#.(lispify "m_paircache" 'slotname) :pointer)
	(#.(lispify "m_prediction" 'slotname) :float)
	(#.(lispify "m_stageCurrent" 'slotname) :int)
	(#.(lispify "m_fupdates" 'slotname) :int)
	(#.(lispify "m_dupdates" 'slotname) :int)
	(#.(lispify "m_cupdates" 'slotname) :int)
	(#.(lispify "m_newpairs" 'slotname) :int)
	(#.(lispify "m_fixedleft" 'slotname) :int)
	(#.(lispify "m_updates_call" 'slotname) :unsigned-int)
	(#.(lispify "m_updates_done" 'slotname) :unsigned-int)
	(#.(lispify "m_updates_ratio" 'slotname) :float)
	(#.(lispify "m_pid" 'slotname) :int)
	(#.(lispify "m_cid" 'slotname) :int)
	(#.(lispify "m_gid" 'slotname) :int)
	(#.(lispify "m_releasepaircache" 'slotname) :pointer)
	(#.(lispify "m_deferedcollide" 'slotname) :pointer)
	(#.(lispify "m_needcleanup" 'slotname) :pointer)
	(#.(lispify "collide" 'slotname) :pointer)
	(#.(lispify "optimize" 'slotname) :pointer)
	(#.(lispify "createProxy" 'slotname) :pointer)
	(#.(lispify "destroyProxy" 'slotname) :pointer)
	(#.(lispify "setAabb" 'slotname) :pointer)
	(#.(lispify "rayTest" 'slotname) :pointer)
	(#.(lispify "rayTest" 'slotname) :pointer)
	(#.(lispify "rayTest" 'slotname) :pointer)
	(#.(lispify "aabbTest" 'slotname) :pointer)
	(#.(lispify "getAabb" 'slotname) :pointer)
	(#.(lispify "calculateOverlappingPairs" 'slotname) :pointer)
	(#.(lispify "getOverlappingPairCache" 'slotname) :pointer)
	(#.(lispify "getOverlappingPairCache" 'slotname) :pointer)
	(#.(lispify "getBroadphaseAabb" 'slotname) :pointer)
	(#.(lispify "printStats" 'slotname) :pointer)
	(#.(lispify "resetPool" 'slotname) :pointer)
	(#.(lispify "performDeferredRemoval" 'slotname) :pointer)
	(#.(lispify "setVelocityPrediction" 'slotname) :pointer)
	(#.(lispify "getVelocityPrediction" 'slotname) :pointer)
	(#.(lispify "setAabbForceUpdate" 'slotname) :pointer)
	(#.(lispify "benchmark" 'slotname) :pointer))

(export '#.(lispify "btDbvtBroadphase" 'classname))

(export '#.(lispify "m_sets" 'slotname))

(export '#.(lispify "m_stageRoots" 'slotname))

(export '#.(lispify "m_paircache" 'slotname))

(export '#.(lispify "m_prediction" 'slotname))

(export '#.(lispify "m_stageCurrent" 'slotname))

(export '#.(lispify "m_fupdates" 'slotname))

(export '#.(lispify "m_dupdates" 'slotname))

(export '#.(lispify "m_cupdates" 'slotname))

(export '#.(lispify "m_newpairs" 'slotname))

(export '#.(lispify "m_fixedleft" 'slotname))

(export '#.(lispify "m_updates_call" 'slotname))

(export '#.(lispify "m_updates_done" 'slotname))

(export '#.(lispify "m_updates_ratio" 'slotname))

(export '#.(lispify "m_pid" 'slotname))

(export '#.(lispify "m_cid" 'slotname))

(export '#.(lispify "m_gid" 'slotname))

(export '#.(lispify "m_releasepaircache" 'slotname))

(export '#.(lispify "m_deferedcollide" 'slotname))

(export '#.(lispify "m_needcleanup" 'slotname))

(export '#.(lispify "collide" 'slotname))

(export '#.(lispify "optimize" 'slotname))

(export '#.(lispify "createProxy" 'slotname))

(export '#.(lispify "destroyProxy" 'slotname))

(export '#.(lispify "setAabb" 'slotname))

(export '#.(lispify "rayTest" 'slotname))

(export '#.(lispify "rayTest" 'slotname))

(export '#.(lispify "rayTest" 'slotname))

(export '#.(lispify "aabbTest" 'slotname))

(export '#.(lispify "getAabb" 'slotname))

(export '#.(lispify "calculateOverlappingPairs" 'slotname))

(export '#.(lispify "getOverlappingPairCache" 'slotname))

(export '#.(lispify "getOverlappingPairCache" 'slotname))

(export '#.(lispify "getBroadphaseAabb" 'slotname))

(export '#.(lispify "printStats" 'slotname))

(export '#.(lispify "resetPool" 'slotname))

(export '#.(lispify "performDeferredRemoval" 'slotname))

(export '#.(lispify "setVelocityPrediction" 'slotname))

(export '#.(lispify "getVelocityPrediction" 'slotname))

(export '#.(lispify "setAabbForceUpdate" 'slotname))

(export '#.(lispify "benchmark" 'slotname))

(cffi:defcstruct #.(lispify "btDefaultMotionState" 'classname)
	(#.(lispify "m_graphicsWorldTrans" 'slotname) :pointer)
	(#.(lispify "m_centerOfMassOffset" 'slotname) :pointer)
	(#.(lispify "m_startWorldTrans" 'slotname) :pointer)
	(#.(lispify "m_userPointer" 'slotname) :pointer)
	(#.(lispify "makeCPlusPlusInstance" 'slotname) :pointer)
	(#.(lispify "deleteCPlusPlusInstance" 'slotname) :pointer)
	(#.(lispify "makeCPlusPlusInstance" 'slotname) :pointer)
	(#.(lispify "deleteCPlusPlusInstance" 'slotname) :pointer)
	(#.(lispify "makeCPlusArray" 'slotname) :pointer)
	(#.(lispify "deleteCPlusArray" 'slotname) :pointer)
	(#.(lispify "makeCPlusArray" 'slotname) :pointer)
	(#.(lispify "deleteCPlusArray" 'slotname) :pointer)
	(#.(lispify "getWorldTransform" 'slotname) :pointer)
	(#.(lispify "setWorldTransform" 'slotname) :pointer))

(export '#.(lispify "btDefaultMotionState" 'classname))

(export '#.(lispify "m_graphicsWorldTrans" 'slotname))

(export '#.(lispify "m_centerOfMassOffset" 'slotname))

(export '#.(lispify "m_startWorldTrans" 'slotname))

(export '#.(lispify "m_userPointer" 'slotname))

(export '#.(lispify "makeCPlusPlusInstance" 'slotname))

(export '#.(lispify "deleteCPlusPlusInstance" 'slotname))

(export '#.(lispify "makeCPlusPlusInstance" 'slotname))

(export '#.(lispify "deleteCPlusPlusInstance" 'slotname))

(export '#.(lispify "makeCPlusArray" 'slotname))

(export '#.(lispify "deleteCPlusArray" 'slotname))

(export '#.(lispify "makeCPlusArray" 'slotname))

(export '#.(lispify "deleteCPlusArray" 'slotname))

(export '#.(lispify "getWorldTransform" 'slotname))

(export '#.(lispify "setWorldTransform" 'slotname))

(define-constant #.(lispify "USE_BT_CLOCK" 'constant) 1)

(export '#.(lispify "USE_BT_CLOCK" 'constant))

(declaim (inline #.(lispify "new_btClock" 'function)))

(cffi:defcfun ("_wrap_new_btClock__SWIG_0" #.(lispify "new_btClock" 'function)) :pointer)

(export '#.(lispify "new_btClock" 'function))

(declaim (inline #.(lispify "new_btClock" 'function)))

(cffi:defcfun ("_wrap_new_btClock__SWIG_1" #.(lispify "new_btClock" 'function)) :pointer
  (other :pointer))

(export '#.(lispify "new_btClock" 'function))

(declaim (inline #.(lispify "btClock_assignValue" 'function)))

(cffi:defcfun ("_wrap_btClock_assignValue" #.(lispify "btClock_assignValue" 'function)) :pointer
  (self :pointer)
  (other :pointer))

(export '#.(lispify "btClock_assignValue" 'function))

(declaim (inline #.(lispify "delete_btClock" 'function)))

(cffi:defcfun ("_wrap_delete_btClock" #.(lispify "delete_btClock" 'function)) :void
  (self :pointer))

(export '#.(lispify "delete_btClock" 'function))

(declaim (inline #.(lispify "btClock_reset" 'function)))

(cffi:defcfun ("_wrap_btClock_reset" #.(lispify "btClock_reset" 'function)) :void
  (self :pointer))

(export '#.(lispify "btClock_reset" 'function))

(declaim (inline #.(lispify "btClock_getTimeMilliseconds" 'function)))

(cffi:defcfun ("_wrap_btClock_getTimeMilliseconds" #.(lispify "btClock_getTimeMilliseconds" 'function)) :unsigned-long
  (self :pointer))

(export '#.(lispify "btClock_getTimeMilliseconds" 'function))

(declaim (inline #.(lispify "btClock_getTimeMicroseconds" 'function)))

(cffi:defcfun ("_wrap_btClock_getTimeMicroseconds" #.(lispify "btClock_getTimeMicroseconds" 'function)) :unsigned-long
  (self :pointer))

(export '#.(lispify "btClock_getTimeMicroseconds" 'function))

(declaim (inline #.(lispify "new_CProfileNode" 'function)))

(cffi:defcfun ("_wrap_new_CProfileNode" #.(lispify "new_CProfileNode" 'function)) :pointer
  (name :string)
  (parent :pointer))

(export '#.(lispify "new_CProfileNode" 'function))

(declaim (inline #.(lispify "delete_CProfileNode" 'function)))

(cffi:defcfun ("_wrap_delete_CProfileNode" #.(lispify "delete_CProfileNode" 'function)) :void
  (self :pointer))

(export '#.(lispify "delete_CProfileNode" 'function))

(declaim (inline #.(lispify "CProfileNode_Get_Sub_Node" 'function)))

(cffi:defcfun ("_wrap_CProfileNode_Get_Sub_Node" #.(lispify "CProfileNode_Get_Sub_Node" 'function)) :pointer
  (self :pointer)
  (name :string))

(export '#.(lispify "CProfileNode_Get_Sub_Node" 'function))

(declaim (inline #.(lispify "CProfileNode_Get_Parent" 'function)))

(cffi:defcfun ("_wrap_CProfileNode_Get_Parent" #.(lispify "CProfileNode_Get_Parent" 'function)) :pointer
  (self :pointer))

(export '#.(lispify "CProfileNode_Get_Parent" 'function))

(declaim (inline #.(lispify "CProfileNode_Get_Sibling" 'function)))

(cffi:defcfun ("_wrap_CProfileNode_Get_Sibling" #.(lispify "CProfileNode_Get_Sibling" 'function)) :pointer
  (self :pointer))

(export '#.(lispify "CProfileNode_Get_Sibling" 'function))

(declaim (inline #.(lispify "CProfileNode_Get_Child" 'function)))

(cffi:defcfun ("_wrap_CProfileNode_Get_Child" #.(lispify "CProfileNode_Get_Child" 'function)) :pointer
  (self :pointer))

(export '#.(lispify "CProfileNode_Get_Child" 'function))

(declaim (inline #.(lispify "CProfileNode_CleanupMemory" 'function)))

(cffi:defcfun ("_wrap_CProfileNode_CleanupMemory" #.(lispify "CProfileNode_CleanupMemory" 'function)) :void
  (self :pointer))

(export '#.(lispify "CProfileNode_CleanupMemory" 'function))

(declaim (inline #.(lispify "CProfileNode_Reset" 'function)))

(cffi:defcfun ("_wrap_CProfileNode_Reset" #.(lispify "CProfileNode_Reset" 'function)) :void
  (self :pointer))

(export '#.(lispify "CProfileNode_Reset" 'function))

(declaim (inline #.(lispify "CProfileNode_Call" 'function)))

(cffi:defcfun ("_wrap_CProfileNode_Call" #.(lispify "CProfileNode_Call" 'function)) :void
  (self :pointer))

(export '#.(lispify "CProfileNode_Call" 'function))

(declaim (inline #.(lispify "CProfileNode_Return" 'function)))

(cffi:defcfun ("_wrap_CProfileNode_Return" #.(lispify "CProfileNode_Return" 'function)) :pointer
  (self :pointer))

(export '#.(lispify "CProfileNode_Return" 'function))

(declaim (inline #.(lispify "CProfileNode_Get_Name" 'function)))

(cffi:defcfun ("_wrap_CProfileNode_Get_Name" #.(lispify "CProfileNode_Get_Name" 'function)) :string
  (self :pointer))

(export '#.(lispify "CProfileNode_Get_Name" 'function))

(declaim (inline #.(lispify "CProfileNode_Get_Total_Calls" 'function)))

(cffi:defcfun ("_wrap_CProfileNode_Get_Total_Calls" #.(lispify "CProfileNode_Get_Total_Calls" 'function)) :int
  (self :pointer))

(export '#.(lispify "CProfileNode_Get_Total_Calls" 'function))

(declaim (inline #.(lispify "CProfileNode_Get_Total_Time" 'function)))

(cffi:defcfun ("_wrap_CProfileNode_Get_Total_Time" #.(lispify "CProfileNode_Get_Total_Time" 'function)) :float
  (self :pointer))

(export '#.(lispify "CProfileNode_Get_Total_Time" 'function))

(declaim (inline #.(lispify "CProfileNode_GetUserPointer" 'function)))

(cffi:defcfun ("_wrap_CProfileNode_GetUserPointer" #.(lispify "CProfileNode_GetUserPointer" 'function)) :pointer
  (self :pointer))

(export '#.(lispify "CProfileNode_GetUserPointer" 'function))

(declaim (inline #.(lispify "CProfileNode_SetUserPointer" 'function)))

(cffi:defcfun ("_wrap_CProfileNode_SetUserPointer" #.(lispify "CProfileNode_SetUserPointer" 'function)) :void
  (self :pointer)
  (ptr :pointer))

(export '#.(lispify "CProfileNode_SetUserPointer" 'function))

(declaim (inline #.(lispify "CProfileIterator_First" 'function)))

(cffi:defcfun ("_wrap_CProfileIterator_First" #.(lispify "CProfileIterator_First" 'function)) :void
  (self :pointer))

(export '#.(lispify "CProfileIterator_First" 'function))

(declaim (inline #.(lispify "CProfileIterator_Next" 'function)))

(cffi:defcfun ("_wrap_CProfileIterator_Next" #.(lispify "CProfileIterator_Next" 'function)) :void
  (self :pointer))

(export '#.(lispify "CProfileIterator_Next" 'function))

(declaim (inline #.(lispify "CProfileIterator_Is_Done" 'function)))

(cffi:defcfun ("_wrap_CProfileIterator_Is_Done" #.(lispify "CProfileIterator_Is_Done" 'function)) :pointer
  (self :pointer))

(export '#.(lispify "CProfileIterator_Is_Done" 'function))

(declaim (inline #.(lispify "CProfileIterator_Is_Root" 'function)))

(cffi:defcfun ("_wrap_CProfileIterator_Is_Root" #.(lispify "CProfileIterator_Is_Root" 'function)) :pointer
  (self :pointer))

(export '#.(lispify "CProfileIterator_Is_Root" 'function))

(declaim (inline #.(lispify "CProfileIterator_Enter_Child" 'function)))

(cffi:defcfun ("_wrap_CProfileIterator_Enter_Child" #.(lispify "CProfileIterator_Enter_Child" 'function)) :void
  (self :pointer)
  (index :int))

(export '#.(lispify "CProfileIterator_Enter_Child" 'function))

(declaim (inline #.(lispify "CProfileIterator_Enter_Largest_Child" 'function)))

(cffi:defcfun ("_wrap_CProfileIterator_Enter_Largest_Child" #.(lispify "CProfileIterator_Enter_Largest_Child" 'function)) :void
  (self :pointer))

(export '#.(lispify "CProfileIterator_Enter_Largest_Child" 'function))

(declaim (inline #.(lispify "CProfileIterator_Enter_Parent" 'function)))

(cffi:defcfun ("_wrap_CProfileIterator_Enter_Parent" #.(lispify "CProfileIterator_Enter_Parent" 'function)) :void
  (self :pointer))

(export '#.(lispify "CProfileIterator_Enter_Parent" 'function))

(declaim (inline #.(lispify "CProfileIterator_Get_Current_Name" 'function)))

(cffi:defcfun ("_wrap_CProfileIterator_Get_Current_Name" #.(lispify "CProfileIterator_Get_Current_Name" 'function)) :string
  (self :pointer))

(export '#.(lispify "CProfileIterator_Get_Current_Name" 'function))

(declaim (inline #.(lispify "CProfileIterator_Get_Current_Total_Calls" 'function)))

(cffi:defcfun ("_wrap_CProfileIterator_Get_Current_Total_Calls" #.(lispify "CProfileIterator_Get_Current_Total_Calls" 'function)) :int
  (self :pointer))

(export '#.(lispify "CProfileIterator_Get_Current_Total_Calls" 'function))

(declaim (inline #.(lispify "CProfileIterator_Get_Current_Total_Time" 'function)))

(cffi:defcfun ("_wrap_CProfileIterator_Get_Current_Total_Time" #.(lispify "CProfileIterator_Get_Current_Total_Time" 'function)) :float
  (self :pointer))

(export '#.(lispify "CProfileIterator_Get_Current_Total_Time" 'function))

(declaim (inline #.(lispify "CProfileIterator_Get_Current_UserPointer" 'function)))

(cffi:defcfun ("_wrap_CProfileIterator_Get_Current_UserPointer" #.(lispify "CProfileIterator_Get_Current_UserPointer" 'function)) :pointer
  (self :pointer))

(export '#.(lispify "CProfileIterator_Get_Current_UserPointer" 'function))

(declaim (inline #.(lispify "CProfileIterator_Set_Current_UserPointer" 'function)))

(cffi:defcfun ("_wrap_CProfileIterator_Set_Current_UserPointer" #.(lispify "CProfileIterator_Set_Current_UserPointer" 'function)) :void
  (self :pointer)
  (ptr :pointer))

(export '#.(lispify "CProfileIterator_Set_Current_UserPointer" 'function))

(declaim (inline #.(lispify "CProfileIterator_Get_Current_Parent_Name" 'function)))

(cffi:defcfun ("_wrap_CProfileIterator_Get_Current_Parent_Name" #.(lispify "CProfileIterator_Get_Current_Parent_Name" 'function)) :string
  (self :pointer))

(export '#.(lispify "CProfileIterator_Get_Current_Parent_Name" 'function))

(declaim (inline #.(lispify "CProfileIterator_Get_Current_Parent_Total_Calls" 'function)))

(cffi:defcfun ("_wrap_CProfileIterator_Get_Current_Parent_Total_Calls" #.(lispify "CProfileIterator_Get_Current_Parent_Total_Calls" 'function)) :int
  (self :pointer))

(export '#.(lispify "CProfileIterator_Get_Current_Parent_Total_Calls" 'function))

(declaim (inline #.(lispify "CProfileIterator_Get_Current_Parent_Total_Time" 'function)))

(cffi:defcfun ("_wrap_CProfileIterator_Get_Current_Parent_Total_Time" #.(lispify "CProfileIterator_Get_Current_Parent_Total_Time" 'function)) :float
  (self :pointer))

(export '#.(lispify "CProfileIterator_Get_Current_Parent_Total_Time" 'function))

(declaim (inline #.(lispify "delete_CProfileIterator" 'function)))

(cffi:defcfun ("_wrap_delete_CProfileIterator" #.(lispify "delete_CProfileIterator" 'function)) :void
  (self :pointer))

(export '#.(lispify "delete_CProfileIterator" 'function))

(declaim (inline #.(lispify "CProfileManager_Start_Profile" 'function)))

(cffi:defcfun ("_wrap_CProfileManager_Start_Profile" #.(lispify "CProfileManager_Start_Profile" 'function)) :void
  (name :string))

(export '#.(lispify "CProfileManager_Start_Profile" 'function))

(declaim (inline #.(lispify "CProfileManager_Stop_Profile" 'function)))

(cffi:defcfun ("_wrap_CProfileManager_Stop_Profile" #.(lispify "CProfileManager_Stop_Profile" 'function)) :void)

(export '#.(lispify "CProfileManager_Stop_Profile" 'function))

(declaim (inline #.(lispify "CProfileManager_CleanupMemory" 'function)))

(cffi:defcfun ("_wrap_CProfileManager_CleanupMemory" #.(lispify "CProfileManager_CleanupMemory" 'function)) :void)

(export '#.(lispify "CProfileManager_CleanupMemory" 'function))

(declaim (inline #.(lispify "CProfileManager_Reset" 'function)))

(cffi:defcfun ("_wrap_CProfileManager_Reset" #.(lispify "CProfileManager_Reset" 'function)) :void)

(export '#.(lispify "CProfileManager_Reset" 'function))

(declaim (inline #.(lispify "CProfileManager_Increment_Frame_Counter" 'function)))

(cffi:defcfun ("_wrap_CProfileManager_Increment_Frame_Counter" #.(lispify "CProfileManager_Increment_Frame_Counter" 'function)) :void)

(export '#.(lispify "CProfileManager_Increment_Frame_Counter" 'function))

(declaim (inline #.(lispify "CProfileManager_Get_Frame_Count_Since_Reset" 'function)))

(cffi:defcfun ("_wrap_CProfileManager_Get_Frame_Count_Since_Reset" #.(lispify "CProfileManager_Get_Frame_Count_Since_Reset" 'function)) :int)

(export '#.(lispify "CProfileManager_Get_Frame_Count_Since_Reset" 'function))

(declaim (inline #.(lispify "CProfileManager_Get_Time_Since_Reset" 'function)))

(cffi:defcfun ("_wrap_CProfileManager_Get_Time_Since_Reset" #.(lispify "CProfileManager_Get_Time_Since_Reset" 'function)) :float)

(export '#.(lispify "CProfileManager_Get_Time_Since_Reset" 'function))

(declaim (inline #.(lispify "CProfileManager_Get_Iterator" 'function)))

(cffi:defcfun ("_wrap_CProfileManager_Get_Iterator" #.(lispify "CProfileManager_Get_Iterator" 'function)) :pointer)

(export '#.(lispify "CProfileManager_Get_Iterator" 'function))

(declaim (inline #.(lispify "CProfileManager_Release_Iterator" 'function)))

(cffi:defcfun ("_wrap_CProfileManager_Release_Iterator" #.(lispify "CProfileManager_Release_Iterator" 'function)) :void
  (iterator :pointer))

(export '#.(lispify "CProfileManager_Release_Iterator" 'function))

(declaim (inline #.(lispify "CProfileManager_dumpRecursive" 'function)))

(cffi:defcfun ("_wrap_CProfileManager_dumpRecursive" #.(lispify "CProfileManager_dumpRecursive" 'function)) :void
  (profileIterator :pointer)
  (spacing :int))

(export '#.(lispify "CProfileManager_dumpRecursive" 'function))

(declaim (inline #.(lispify "CProfileManager_dumpAll" 'function)))

(cffi:defcfun ("_wrap_CProfileManager_dumpAll" #.(lispify "CProfileManager_dumpAll" 'function)) :void)

(export '#.(lispify "CProfileManager_dumpAll" 'function))

(declaim (inline #.(lispify "new_CProfileManager" 'function)))

(cffi:defcfun ("_wrap_new_CProfileManager" #.(lispify "new_CProfileManager" 'function)) :pointer)

(export '#.(lispify "new_CProfileManager" 'function))

(declaim (inline #.(lispify "delete_CProfileManager" 'function)))

(cffi:defcfun ("_wrap_delete_CProfileManager" #.(lispify "delete_CProfileManager" 'function)) :void
  (self :pointer))

(export '#.(lispify "delete_CProfileManager" 'function))

(declaim (inline #.(lispify "new_CProfileSample" 'function)))

(cffi:defcfun ("_wrap_new_CProfileSample" #.(lispify "new_CProfileSample" 'function)) :pointer
  (name :string))

(export '#.(lispify "new_CProfileSample" 'function))

(declaim (inline #.(lispify "delete_CProfileSample" 'function)))

(cffi:defcfun ("_wrap_delete_CProfileSample" #.(lispify "delete_CProfileSample" 'function)) :void
  (self :pointer))

(export '#.(lispify "delete_CProfileSample" 'function))

(cffi:defcenum #.(lispify "DebugDrawModes" 'enumname)
	(#.(lispify "DBG_NoDebug" 'enumvalue :keyword) #.0)
	(#.(lispify "DBG_DrawWireframe" 'enumvalue :keyword) #.1)
	(#.(lispify "DBG_DrawAabb" 'enumvalue :keyword) #.2)
	(#.(lispify "DBG_DrawFeaturesText" 'enumvalue :keyword) #.4)
	(#.(lispify "DBG_DrawContactPoints" 'enumvalue :keyword) #.8)
	(#.(lispify "DBG_NoDeactivation" 'enumvalue :keyword) #.16)
	(#.(lispify "DBG_NoHelpText" 'enumvalue :keyword) #.32)
	(#.(lispify "DBG_DrawText" 'enumvalue :keyword) #.64)
	(#.(lispify "DBG_ProfileTimings" 'enumvalue :keyword) #.128)
	(#.(lispify "DBG_EnableSatComparison" 'enumvalue :keyword) #.256)
	(#.(lispify "DBG_DisableBulletLCP" 'enumvalue :keyword) #.512)
	(#.(lispify "DBG_EnableCCD" 'enumvalue :keyword) #.1024)
	(#.(lispify "DBG_DrawConstraints" 'enumvalue :keyword) #.(ash 1 11))
	(#.(lispify "DBG_DrawConstraintLimits" 'enumvalue :keyword) #.(ash 1 12))
	(#.(lispify "DBG_FastWireframe" 'enumvalue :keyword) #.(ash 1 13))
	(#.(lispify "DBG_DrawNormals" 'enumvalue :keyword) #.(ash 1 14))
	#.(lispify "DBG_MAX_DEBUG_DRAW_MODE" 'enumvalue :keyword))

(export '#.(lispify "DebugDrawModes" 'enumname))

(declaim (inline #.(lispify "delete_btIDebugDraw" 'function)))

(cffi:defcfun ("_wrap_delete_btIDebugDraw" #.(lispify "delete_btIDebugDraw" 'function)) :void
  (self :pointer))

(export '#.(lispify "delete_btIDebugDraw" 'function))

(declaim (inline #.(lispify "btIDebugDraw_drawLine" 'function)))

(cffi:defcfun ("_wrap_btIDebugDraw_drawLine__SWIG_0" #.(lispify "btIDebugDraw_drawLine" 'function)) :void
  (self :pointer)
  (from :pointer)
  (to :pointer)
  (color :pointer))

(export '#.(lispify "btIDebugDraw_drawLine" 'function))

(declaim (inline #.(lispify "btIDebugDraw_drawLine" 'function)))

(cffi:defcfun ("_wrap_btIDebugDraw_drawLine__SWIG_1" #.(lispify "btIDebugDraw_drawLine" 'function)) :void
  (self :pointer)
  (from :pointer)
  (to :pointer)
  (fromColor :pointer)
  (toColor :pointer))

(export '#.(lispify "btIDebugDraw_drawLine" 'function))

(declaim (inline #.(lispify "btIDebugDraw_drawSphere" 'function)))

(cffi:defcfun ("_wrap_btIDebugDraw_drawSphere__SWIG_0" #.(lispify "btIDebugDraw_drawSphere" 'function)) :void
  (self :pointer)
  (radius :float)
  (transform :pointer)
  (color :pointer))

(export '#.(lispify "btIDebugDraw_drawSphere" 'function))

(declaim (inline #.(lispify "btIDebugDraw_drawSphere" 'function)))

(cffi:defcfun ("_wrap_btIDebugDraw_drawSphere__SWIG_1" #.(lispify "btIDebugDraw_drawSphere" 'function)) :void
  (self :pointer)
  (p :pointer)
  (radius :float)
  (color :pointer))

(export '#.(lispify "btIDebugDraw_drawSphere" 'function))

(declaim (inline #.(lispify "btIDebugDraw_drawTriangle" 'function)))

(cffi:defcfun ("_wrap_btIDebugDraw_drawTriangle__SWIG_0" #.(lispify "btIDebugDraw_drawTriangle" 'function)) :void
  (self :pointer)
  (v0 :pointer)
  (v1 :pointer)
  (v2 :pointer)
  (arg4 :pointer)
  (arg5 :pointer)
  (arg6 :pointer)
  (color :pointer)
  (alpha :float))

(export '#.(lispify "btIDebugDraw_drawTriangle" 'function))

(declaim (inline #.(lispify "btIDebugDraw_drawTriangle" 'function)))

(cffi:defcfun ("_wrap_btIDebugDraw_drawTriangle__SWIG_1" #.(lispify "btIDebugDraw_drawTriangle" 'function)) :void
  (self :pointer)
  (v0 :pointer)
  (v1 :pointer)
  (v2 :pointer)
  (color :pointer)
  (arg5 :float))

(export '#.(lispify "btIDebugDraw_drawTriangle" 'function))

(declaim (inline #.(lispify "btIDebugDraw_drawContactPoint" 'function)))

(cffi:defcfun ("_wrap_btIDebugDraw_drawContactPoint" #.(lispify "btIDebugDraw_drawContactPoint" 'function)) :void
  (self :pointer)
  (PointOnB :pointer)
  (normalOnB :pointer)
  (distance :float)
  (lifeTime :int)
  (color :pointer))

(export '#.(lispify "btIDebugDraw_drawContactPoint" 'function))

(declaim (inline #.(lispify "btIDebugDraw_reportErrorWarning" 'function)))

(cffi:defcfun ("_wrap_btIDebugDraw_reportErrorWarning" #.(lispify "btIDebugDraw_reportErrorWarning" 'function)) :void
  (self :pointer)
  (warningString :string))

(export '#.(lispify "btIDebugDraw_reportErrorWarning" 'function))

(declaim (inline #.(lispify "btIDebugDraw_draw3dText" 'function)))

(cffi:defcfun ("_wrap_btIDebugDraw_draw3dText" #.(lispify "btIDebugDraw_draw3dText" 'function)) :void
  (self :pointer)
  (location :pointer)
  (textString :string))

(export '#.(lispify "btIDebugDraw_draw3dText" 'function))

(declaim (inline #.(lispify "btIDebugDraw_setDebugMode" 'function)))

(cffi:defcfun ("_wrap_btIDebugDraw_setDebugMode" #.(lispify "btIDebugDraw_setDebugMode" 'function)) :void
  (self :pointer)
  (debugMode :int))

(export '#.(lispify "btIDebugDraw_setDebugMode" 'function))

(declaim (inline #.(lispify "btIDebugDraw_getDebugMode" 'function)))

(cffi:defcfun ("_wrap_btIDebugDraw_getDebugMode" #.(lispify "btIDebugDraw_getDebugMode" 'function)) :int
  (self :pointer))

(export '#.(lispify "btIDebugDraw_getDebugMode" 'function))

(declaim (inline #.(lispify "btIDebugDraw_drawAabb" 'function)))

(cffi:defcfun ("_wrap_btIDebugDraw_drawAabb" #.(lispify "btIDebugDraw_drawAabb" 'function)) :void
  (self :pointer)
  (from :pointer)
  (to :pointer)
  (color :pointer))

(export '#.(lispify "btIDebugDraw_drawAabb" 'function))

(declaim (inline #.(lispify "btIDebugDraw_drawTransform" 'function)))

(cffi:defcfun ("_wrap_btIDebugDraw_drawTransform" #.(lispify "btIDebugDraw_drawTransform" 'function)) :void
  (self :pointer)
  (transform :pointer)
  (orthoLen :float))

(export '#.(lispify "btIDebugDraw_drawTransform" 'function))

(declaim (inline #.(lispify "btIDebugDraw_drawArc" 'function)))

(cffi:defcfun ("_wrap_btIDebugDraw_drawArc__SWIG_0" #.(lispify "btIDebugDraw_drawArc" 'function)) :void
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

(export '#.(lispify "btIDebugDraw_drawArc" 'function))

(declaim (inline #.(lispify "btIDebugDraw_drawArc" 'function)))

(cffi:defcfun ("_wrap_btIDebugDraw_drawArc__SWIG_1" #.(lispify "btIDebugDraw_drawArc" 'function)) :void
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

(export '#.(lispify "btIDebugDraw_drawArc" 'function))

(declaim (inline #.(lispify "btIDebugDraw_drawSpherePatch" 'function)))

(cffi:defcfun ("_wrap_btIDebugDraw_drawSpherePatch__SWIG_0" #.(lispify "btIDebugDraw_drawSpherePatch" 'function)) :void
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

(export '#.(lispify "btIDebugDraw_drawSpherePatch" 'function))

(declaim (inline #.(lispify "btIDebugDraw_drawSpherePatch" 'function)))

(cffi:defcfun ("_wrap_btIDebugDraw_drawSpherePatch__SWIG_1" #.(lispify "btIDebugDraw_drawSpherePatch" 'function)) :void
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

(export '#.(lispify "btIDebugDraw_drawSpherePatch" 'function))

(declaim (inline #.(lispify "btIDebugDraw_drawSpherePatch" 'function)))

(cffi:defcfun ("_wrap_btIDebugDraw_drawSpherePatch__SWIG_2" #.(lispify "btIDebugDraw_drawSpherePatch" 'function)) :void
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

(export '#.(lispify "btIDebugDraw_drawSpherePatch" 'function))

(declaim (inline #.(lispify "btIDebugDraw_drawBox" 'function)))

(cffi:defcfun ("_wrap_btIDebugDraw_drawBox__SWIG_0" #.(lispify "btIDebugDraw_drawBox" 'function)) :void
  (self :pointer)
  (bbMin :pointer)
  (bbMax :pointer)
  (color :pointer))

(export '#.(lispify "btIDebugDraw_drawBox" 'function))

(declaim (inline #.(lispify "btIDebugDraw_drawBox" 'function)))

(cffi:defcfun ("_wrap_btIDebugDraw_drawBox__SWIG_1" #.(lispify "btIDebugDraw_drawBox" 'function)) :void
  (self :pointer)
  (bbMin :pointer)
  (bbMax :pointer)
  (trans :pointer)
  (color :pointer))

(export '#.(lispify "btIDebugDraw_drawBox" 'function))

(declaim (inline #.(lispify "btIDebugDraw_drawCapsule" 'function)))

(cffi:defcfun ("_wrap_btIDebugDraw_drawCapsule" #.(lispify "btIDebugDraw_drawCapsule" 'function)) :void
  (self :pointer)
  (radius :float)
  (halfHeight :float)
  (upAxis :int)
  (transform :pointer)
  (color :pointer))

(export '#.(lispify "btIDebugDraw_drawCapsule" 'function))

(declaim (inline #.(lispify "btIDebugDraw_drawCylinder" 'function)))

(cffi:defcfun ("_wrap_btIDebugDraw_drawCylinder" #.(lispify "btIDebugDraw_drawCylinder" 'function)) :void
  (self :pointer)
  (radius :float)
  (halfHeight :float)
  (upAxis :int)
  (transform :pointer)
  (color :pointer))

(export '#.(lispify "btIDebugDraw_drawCylinder" 'function))

(declaim (inline #.(lispify "btIDebugDraw_drawCone" 'function)))

(cffi:defcfun ("_wrap_btIDebugDraw_drawCone" #.(lispify "btIDebugDraw_drawCone" 'function)) :void
  (self :pointer)
  (radius :float)
  (height :float)
  (upAxis :int)
  (transform :pointer)
  (color :pointer))

(export '#.(lispify "btIDebugDraw_drawCone" 'function))

(declaim (inline #.(lispify "btIDebugDraw_drawPlane" 'function)))

(cffi:defcfun ("_wrap_btIDebugDraw_drawPlane" #.(lispify "btIDebugDraw_drawPlane" 'function)) :void
  (self :pointer)
  (planeNormal :pointer)
  (planeConst :float)
  (transform :pointer)
  (color :pointer))

(export '#.(lispify "btIDebugDraw_drawPlane" 'function))

(cffi:defcvar ("sBulletDNAstr" #.(lispify "sBulletDNAstr" 'variable))
 :pointer)

(export '#.(lispify "sBulletDNAstr" 'variable))

(cffi:defcvar ("sBulletDNAlen" #.(lispify "sBulletDNAlen" 'variable))
 :int)

(export '#.(lispify "sBulletDNAlen" 'variable))

(cffi:defcvar ("sBulletDNAstr64" #.(lispify "sBulletDNAstr64" 'variable))
 :pointer)

(export '#.(lispify "sBulletDNAstr64" 'variable))

(cffi:defcvar ("sBulletDNAlen64" #.(lispify "sBulletDNAlen64" 'variable))
 :int)

(export '#.(lispify "sBulletDNAlen64" 'variable))

(declaim (inline #.(lispify "btStrLen" 'function)))

(cffi:defcfun ("_wrap_btStrLen" #.(lispify "btStrLen" 'function)) :int
  (str :string))

(export '#.(lispify "btStrLen" 'function))

(declaim (inline #.(lispify "btChunk_m_chunkCode_set" 'function)))

(cffi:defcfun ("_wrap_btChunk_m_chunkCode_set" #.(lispify "btChunk_m_chunkCode_set" 'function)) :void
  (self :pointer)
  (m_chunkCode :int))

(export '#.(lispify "btChunk_m_chunkCode_set" 'function))

(declaim (inline #.(lispify "btChunk_m_chunkCode_get" 'function)))

(cffi:defcfun ("_wrap_btChunk_m_chunkCode_get" #.(lispify "btChunk_m_chunkCode_get" 'function)) :int
  (self :pointer))

(export '#.(lispify "btChunk_m_chunkCode_get" 'function))

(declaim (inline #.(lispify "btChunk_m_length_set" 'function)))

(cffi:defcfun ("_wrap_btChunk_m_length_set" #.(lispify "btChunk_m_length_set" 'function)) :void
  (self :pointer)
  (m_length :int))

(export '#.(lispify "btChunk_m_length_set" 'function))

(declaim (inline #.(lispify "btChunk_m_length_get" 'function)))

(cffi:defcfun ("_wrap_btChunk_m_length_get" #.(lispify "btChunk_m_length_get" 'function)) :int
  (self :pointer))

(export '#.(lispify "btChunk_m_length_get" 'function))

(declaim (inline #.(lispify "btChunk_m_oldPtr_set" 'function)))

(cffi:defcfun ("_wrap_btChunk_m_oldPtr_set" #.(lispify "btChunk_m_oldPtr_set" 'function)) :void
  (self :pointer)
  (m_oldPtr :pointer))

(export '#.(lispify "btChunk_m_oldPtr_set" 'function))

(declaim (inline #.(lispify "btChunk_m_oldPtr_get" 'function)))

(cffi:defcfun ("_wrap_btChunk_m_oldPtr_get" #.(lispify "btChunk_m_oldPtr_get" 'function)) :pointer
  (self :pointer))

(export '#.(lispify "btChunk_m_oldPtr_get" 'function))

(declaim (inline #.(lispify "btChunk_m_dna_nr_set" 'function)))

(cffi:defcfun ("_wrap_btChunk_m_dna_nr_set" #.(lispify "btChunk_m_dna_nr_set" 'function)) :void
  (self :pointer)
  (m_dna_nr :int))

(export '#.(lispify "btChunk_m_dna_nr_set" 'function))

(declaim (inline #.(lispify "btChunk_m_dna_nr_get" 'function)))

(cffi:defcfun ("_wrap_btChunk_m_dna_nr_get" #.(lispify "btChunk_m_dna_nr_get" 'function)) :int
  (self :pointer))

(export '#.(lispify "btChunk_m_dna_nr_get" 'function))

(declaim (inline #.(lispify "btChunk_m_number_set" 'function)))

(cffi:defcfun ("_wrap_btChunk_m_number_set" #.(lispify "btChunk_m_number_set" 'function)) :void
  (self :pointer)
  (m_number :int))

(export '#.(lispify "btChunk_m_number_set" 'function))

(declaim (inline #.(lispify "btChunk_m_number_get" 'function)))

(cffi:defcfun ("_wrap_btChunk_m_number_get" #.(lispify "btChunk_m_number_get" 'function)) :int
  (self :pointer))

(export '#.(lispify "btChunk_m_number_get" 'function))

(declaim (inline #.(lispify "new_btChunk" 'function)))

(cffi:defcfun ("_wrap_new_btChunk" #.(lispify "new_btChunk" 'function)) :pointer)

(export '#.(lispify "new_btChunk" 'function))

(declaim (inline #.(lispify "delete_btChunk" 'function)))

(cffi:defcfun ("_wrap_delete_btChunk" #.(lispify "delete_btChunk" 'function)) :void
  (self :pointer))

(export '#.(lispify "delete_btChunk" 'function))

(cffi:defcenum #.(lispify "btSerializationFlags" 'enumname)
	(#.(lispify "BT_SERIALIZE_NO_BVH" 'enumvalue :keyword) #.1)
	(#.(lispify "BT_SERIALIZE_NO_TRIANGLEINFOMAP" 'enumvalue :keyword) #.2)
	(#.(lispify "BT_SERIALIZE_NO_DUPLICATE_ASSERT" 'enumvalue :keyword) #.4))

(export '#.(lispify "btSerializationFlags" 'enumname))

(declaim (inline #.(lispify "delete_btSerializer" 'function)))

(cffi:defcfun ("_wrap_delete_btSerializer" #.(lispify "delete_btSerializer" 'function)) :void
  (self :pointer))

(export '#.(lispify "delete_btSerializer" 'function))

(declaim (inline #.(lispify "btSerializer_getBufferPointer" 'function)))

(cffi:defcfun ("_wrap_btSerializer_getBufferPointer" #.(lispify "btSerializer_getBufferPointer" 'function)) :pointer
  (self :pointer))

(export '#.(lispify "btSerializer_getBufferPointer" 'function))

(declaim (inline #.(lispify "btSerializer_getCurrentBufferSize" 'function)))

(cffi:defcfun ("_wrap_btSerializer_getCurrentBufferSize" #.(lispify "btSerializer_getCurrentBufferSize" 'function)) :int
  (self :pointer))

(export '#.(lispify "btSerializer_getCurrentBufferSize" 'function))

(declaim (inline #.(lispify "btSerializer_allocate" 'function)))

(cffi:defcfun ("_wrap_btSerializer_allocate" #.(lispify "btSerializer_allocate" 'function)) :pointer
  (self :pointer)
  (size :pointer)
  (numElements :int))

(export '#.(lispify "btSerializer_allocate" 'function))

(declaim (inline #.(lispify "btSerializer_finalizeChunk" 'function)))

(cffi:defcfun ("_wrap_btSerializer_finalizeChunk" #.(lispify "btSerializer_finalizeChunk" 'function)) :void
  (self :pointer)
  (chunk :pointer)
  (structType :string)
  (chunkCode :int)
  (oldPtr :pointer))

(export '#.(lispify "btSerializer_finalizeChunk" 'function))

(declaim (inline #.(lispify "btSerializer_findPointer" 'function)))

(cffi:defcfun ("_wrap_btSerializer_findPointer" #.(lispify "btSerializer_findPointer" 'function)) :pointer
  (self :pointer)
  (oldPtr :pointer))

(export '#.(lispify "btSerializer_findPointer" 'function))

(declaim (inline #.(lispify "btSerializer_getUniquePointer" 'function)))

(cffi:defcfun ("_wrap_btSerializer_getUniquePointer" #.(lispify "btSerializer_getUniquePointer" 'function)) :pointer
  (self :pointer)
  (oldPtr :pointer))

(export '#.(lispify "btSerializer_getUniquePointer" 'function))

(declaim (inline #.(lispify "btSerializer_startSerialization" 'function)))

(cffi:defcfun ("_wrap_btSerializer_startSerialization" #.(lispify "btSerializer_startSerialization" 'function)) :void
  (self :pointer))

(export '#.(lispify "btSerializer_startSerialization" 'function))

(declaim (inline #.(lispify "btSerializer_finishSerialization" 'function)))

(cffi:defcfun ("_wrap_btSerializer_finishSerialization" #.(lispify "btSerializer_finishSerialization" 'function)) :void
  (self :pointer))

(export '#.(lispify "btSerializer_finishSerialization" 'function))

(declaim (inline #.(lispify "btSerializer_findNameForPointer" 'function)))

(cffi:defcfun ("_wrap_btSerializer_findNameForPointer" #.(lispify "btSerializer_findNameForPointer" 'function)) :string
  (self :pointer)
  (ptr :pointer))

(export '#.(lispify "btSerializer_findNameForPointer" 'function))

(declaim (inline #.(lispify "btSerializer_registerNameForPointer" 'function)))

(cffi:defcfun ("_wrap_btSerializer_registerNameForPointer" #.(lispify "btSerializer_registerNameForPointer" 'function)) :void
  (self :pointer)
  (ptr :pointer)
  (name :string))

(export '#.(lispify "btSerializer_registerNameForPointer" 'function))

(declaim (inline #.(lispify "btSerializer_serializeName" 'function)))

(cffi:defcfun ("_wrap_btSerializer_serializeName" #.(lispify "btSerializer_serializeName" 'function)) :void
  (self :pointer)
  (ptr :string))

(export '#.(lispify "btSerializer_serializeName" 'function))

(declaim (inline #.(lispify "btSerializer_getSerializationFlags" 'function)))

(cffi:defcfun ("_wrap_btSerializer_getSerializationFlags" #.(lispify "btSerializer_getSerializationFlags" 'function)) :int
  (self :pointer))

(export '#.(lispify "btSerializer_getSerializationFlags" 'function))

(declaim (inline #.(lispify "btSerializer_setSerializationFlags" 'function)))

(cffi:defcfun ("_wrap_btSerializer_setSerializationFlags" #.(lispify "btSerializer_setSerializationFlags" 'function)) :void
  (self :pointer)
  (flags :int))

(export '#.(lispify "btSerializer_setSerializationFlags" 'function))

(define-constant #.(lispify "BT_HEADER_LENGTH" 'constant) 12)

(export '#.(lispify "BT_HEADER_LENGTH" 'constant))

(cffi:defcstruct #.(lispify "btPointerUid" 'classname))

(export '#.(lispify "btPointerUid" 'classname))

(declaim (inline #.(lispify "new_btDefaultSerializer" 'function)))

(cffi:defcfun ("_wrap_new_btDefaultSerializer__SWIG_0" #.(lispify "new_btDefaultSerializer" 'function)) :pointer
  (totalSize :int))

(export '#.(lispify "new_btDefaultSerializer" 'function))

(declaim (inline #.(lispify "new_btDefaultSerializer" 'function)))

(cffi:defcfun ("_wrap_new_btDefaultSerializer__SWIG_1" #.(lispify "new_btDefaultSerializer" 'function)) :pointer)

(export '#.(lispify "new_btDefaultSerializer" 'function))

(declaim (inline #.(lispify "delete_btDefaultSerializer" 'function)))

(cffi:defcfun ("_wrap_delete_btDefaultSerializer" #.(lispify "delete_btDefaultSerializer" 'function)) :void
  (self :pointer))

(export '#.(lispify "delete_btDefaultSerializer" 'function))

(declaim (inline #.(lispify "btDefaultSerializer_writeHeader" 'function)))

(cffi:defcfun ("_wrap_btDefaultSerializer_writeHeader" #.(lispify "btDefaultSerializer_writeHeader" 'function)) :void
  (self :pointer)
  (buffer :pointer))

(export '#.(lispify "btDefaultSerializer_writeHeader" 'function))

(declaim (inline #.(lispify "btDefaultSerializer_startSerialization" 'function)))

(cffi:defcfun ("_wrap_btDefaultSerializer_startSerialization" #.(lispify "btDefaultSerializer_startSerialization" 'function)) :void
  (self :pointer))

(export '#.(lispify "btDefaultSerializer_startSerialization" 'function))

(declaim (inline #.(lispify "btDefaultSerializer_finishSerialization" 'function)))

(cffi:defcfun ("_wrap_btDefaultSerializer_finishSerialization" #.(lispify "btDefaultSerializer_finishSerialization" 'function)) :void
  (self :pointer))

(export '#.(lispify "btDefaultSerializer_finishSerialization" 'function))

(declaim (inline #.(lispify "btDefaultSerializer_getUniquePointer" 'function)))

(cffi:defcfun ("_wrap_btDefaultSerializer_getUniquePointer" #.(lispify "btDefaultSerializer_getUniquePointer" 'function)) :pointer
  (self :pointer)
  (oldPtr :pointer))

(export '#.(lispify "btDefaultSerializer_getUniquePointer" 'function))

(declaim (inline #.(lispify "btDefaultSerializer_getBufferPointer" 'function)))

(cffi:defcfun ("_wrap_btDefaultSerializer_getBufferPointer" #.(lispify "btDefaultSerializer_getBufferPointer" 'function)) :pointer
  (self :pointer))

(export '#.(lispify "btDefaultSerializer_getBufferPointer" 'function))

(declaim (inline #.(lispify "btDefaultSerializer_getCurrentBufferSize" 'function)))

(cffi:defcfun ("_wrap_btDefaultSerializer_getCurrentBufferSize" #.(lispify "btDefaultSerializer_getCurrentBufferSize" 'function)) :int
  (self :pointer))

(export '#.(lispify "btDefaultSerializer_getCurrentBufferSize" 'function))

(declaim (inline #.(lispify "btDefaultSerializer_finalizeChunk" 'function)))

(cffi:defcfun ("_wrap_btDefaultSerializer_finalizeChunk" #.(lispify "btDefaultSerializer_finalizeChunk" 'function)) :void
  (self :pointer)
  (chunk :pointer)
  (structType :string)
  (chunkCode :int)
  (oldPtr :pointer))

(export '#.(lispify "btDefaultSerializer_finalizeChunk" 'function))

(declaim (inline #.(lispify "btDefaultSerializer_internalAlloc" 'function)))

(cffi:defcfun ("_wrap_btDefaultSerializer_internalAlloc" #.(lispify "btDefaultSerializer_internalAlloc" 'function)) :pointer
  (self :pointer)
  (size :pointer))

(export '#.(lispify "btDefaultSerializer_internalAlloc" 'function))

(declaim (inline #.(lispify "btDefaultSerializer_allocate" 'function)))

(cffi:defcfun ("_wrap_btDefaultSerializer_allocate" #.(lispify "btDefaultSerializer_allocate" 'function)) :pointer
  (self :pointer)
  (size :pointer)
  (numElements :int))

(export '#.(lispify "btDefaultSerializer_allocate" 'function))

(declaim (inline #.(lispify "btDefaultSerializer_findNameForPointer" 'function)))

(cffi:defcfun ("_wrap_btDefaultSerializer_findNameForPointer" #.(lispify "btDefaultSerializer_findNameForPointer" 'function)) :string
  (self :pointer)
  (ptr :pointer))

(export '#.(lispify "btDefaultSerializer_findNameForPointer" 'function))

(declaim (inline #.(lispify "btDefaultSerializer_registerNameForPointer" 'function)))

(cffi:defcfun ("_wrap_btDefaultSerializer_registerNameForPointer" #.(lispify "btDefaultSerializer_registerNameForPointer" 'function)) :void
  (self :pointer)
  (ptr :pointer)
  (name :string))

(export '#.(lispify "btDefaultSerializer_registerNameForPointer" 'function))

(declaim (inline #.(lispify "btDefaultSerializer_serializeName" 'function)))

(cffi:defcfun ("_wrap_btDefaultSerializer_serializeName" #.(lispify "btDefaultSerializer_serializeName" 'function)) :void
  (self :pointer)
  (name :string))

(export '#.(lispify "btDefaultSerializer_serializeName" 'function))

(declaim (inline #.(lispify "btDefaultSerializer_getSerializationFlags" 'function)))

(cffi:defcfun ("_wrap_btDefaultSerializer_getSerializationFlags" #.(lispify "btDefaultSerializer_getSerializationFlags" 'function)) :int
  (self :pointer))

(export '#.(lispify "btDefaultSerializer_getSerializationFlags" 'function))

(declaim (inline #.(lispify "btDefaultSerializer_setSerializationFlags" 'function)))

(cffi:defcfun ("_wrap_btDefaultSerializer_setSerializationFlags" #.(lispify "btDefaultSerializer_setSerializationFlags" 'function)) :void
  (self :pointer)
  (flags :int))

(export '#.(lispify "btDefaultSerializer_setSerializationFlags" 'function))

(declaim (inline #.(lispify "btDiscreteDynamicsWorld_makeCPlusPlusInstance" 'function)))

(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_makeCPlusPlusInstance__SWIG_0" #.(lispify "btDiscreteDynamicsWorld_makeCPlusPlusInstance" 'function)) :pointer
  (self :pointer)
  (sizeInBytes :pointer))

(export '#.(lispify "btDiscreteDynamicsWorld_makeCPlusPlusInstance" 'function))

(declaim (inline #.(lispify "btDiscreteDynamicsWorld_deleteCPlusPlusInstance" 'function)))

(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_deleteCPlusPlusInstance__SWIG_0" #.(lispify "btDiscreteDynamicsWorld_deleteCPlusPlusInstance" 'function)) :void
  (self :pointer)
  (ptr :pointer))

(export '#.(lispify "btDiscreteDynamicsWorld_deleteCPlusPlusInstance" 'function))

(declaim (inline #.(lispify "btDiscreteDynamicsWorld_makeCPlusPlusInstance" 'function)))

(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_makeCPlusPlusInstance__SWIG_1" #.(lispify "btDiscreteDynamicsWorld_makeCPlusPlusInstance" 'function)) :pointer
  (self :pointer)
  (arg1 :pointer)
  (ptr :pointer))

(export '#.(lispify "btDiscreteDynamicsWorld_makeCPlusPlusInstance" 'function))

(declaim (inline #.(lispify "btDiscreteDynamicsWorld_deleteCPlusPlusInstance" 'function)))

(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_deleteCPlusPlusInstance__SWIG_1" #.(lispify "btDiscreteDynamicsWorld_deleteCPlusPlusInstance" 'function)) :void
  (self :pointer)
  (arg1 :pointer)
  (arg2 :pointer))

(export '#.(lispify "btDiscreteDynamicsWorld_deleteCPlusPlusInstance" 'function))

(declaim (inline #.(lispify "btDiscreteDynamicsWorld_makeCPlusArray" 'function)))

(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_makeCPlusArray__SWIG_0" #.(lispify "btDiscreteDynamicsWorld_makeCPlusArray" 'function)) :pointer
  (self :pointer)
  (sizeInBytes :pointer))

(export '#.(lispify "btDiscreteDynamicsWorld_makeCPlusArray" 'function))

(declaim (inline #.(lispify "btDiscreteDynamicsWorld_deleteCPlusArray" 'function)))

(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_deleteCPlusArray__SWIG_0" #.(lispify "btDiscreteDynamicsWorld_deleteCPlusArray" 'function)) :void
  (self :pointer)
  (ptr :pointer))

(export '#.(lispify "btDiscreteDynamicsWorld_deleteCPlusArray" 'function))

(declaim (inline #.(lispify "btDiscreteDynamicsWorld_makeCPlusArray" 'function)))

(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_makeCPlusArray__SWIG_1" #.(lispify "btDiscreteDynamicsWorld_makeCPlusArray" 'function)) :pointer
  (self :pointer)
  (arg1 :pointer)
  (ptr :pointer))

(export '#.(lispify "btDiscreteDynamicsWorld_makeCPlusArray" 'function))

(declaim (inline #.(lispify "btDiscreteDynamicsWorld_deleteCPlusArray" 'function)))

(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_deleteCPlusArray__SWIG_1" #.(lispify "btDiscreteDynamicsWorld_deleteCPlusArray" 'function)) :void
  (self :pointer)
  (arg1 :pointer)
  (arg2 :pointer))

(export '#.(lispify "btDiscreteDynamicsWorld_deleteCPlusArray" 'function))

(declaim (inline #.(lispify "new_btDiscreteDynamicsWorld" 'function)))

(cffi:defcfun ("_wrap_new_btDiscreteDynamicsWorld" #.(lispify "new_btDiscreteDynamicsWorld" 'function)) :pointer
  (dispatcher :pointer)
  (pairCache :pointer)
  (constraintSolver :pointer)
  (collisionConfiguration :pointer))

(export '#.(lispify "new_btDiscreteDynamicsWorld" 'function))

(declaim (inline #.(lispify "delete_btDiscreteDynamicsWorld" 'function)))

(cffi:defcfun ("_wrap_delete_btDiscreteDynamicsWorld" #.(lispify "delete_btDiscreteDynamicsWorld" 'function)) :void
  (self :pointer))

(export '#.(lispify "delete_btDiscreteDynamicsWorld" 'function))

(declaim (inline #.(lispify "btDiscreteDynamicsWorld_stepSimulation" 'function)))

(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_stepSimulation__SWIG_0" #.(lispify "btDiscreteDynamicsWorld_stepSimulation" 'function)) :int
  (self :pointer)
  (timeStep :float)
  (maxSubSteps :int)
  (fixedTimeStep :float))

(export '#.(lispify "btDiscreteDynamicsWorld_stepSimulation" 'function))

(declaim (inline #.(lispify "btDiscreteDynamicsWorld_stepSimulation" 'function)))

(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_stepSimulation__SWIG_1" #.(lispify "btDiscreteDynamicsWorld_stepSimulation" 'function)) :int
  (self :pointer)
  (timeStep :float)
  (maxSubSteps :int))

(export '#.(lispify "btDiscreteDynamicsWorld_stepSimulation" 'function))

(declaim (inline #.(lispify "btDiscreteDynamicsWorld_stepSimulation" 'function)))

(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_stepSimulation__SWIG_2" #.(lispify "btDiscreteDynamicsWorld_stepSimulation" 'function)) :int
  (self :pointer)
  (timeStep :float))

(export '#.(lispify "btDiscreteDynamicsWorld_stepSimulation" 'function))

(declaim (inline #.(lispify "btDiscreteDynamicsWorld_synchronizeMotionStates" 'function)))

(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_synchronizeMotionStates" #.(lispify "btDiscreteDynamicsWorld_synchronizeMotionStates" 'function)) :void
  (self :pointer))

(export '#.(lispify "btDiscreteDynamicsWorld_synchronizeMotionStates" 'function))

(declaim (inline #.(lispify "btDiscreteDynamicsWorld_synchronizeSingleMotionState" 'function)))

(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_synchronizeSingleMotionState" #.(lispify "btDiscreteDynamicsWorld_synchronizeSingleMotionState" 'function)) :void
  (self :pointer)
  (body :pointer))

(export '#.(lispify "btDiscreteDynamicsWorld_synchronizeSingleMotionState" 'function))

(declaim (inline #.(lispify "btDiscreteDynamicsWorld_addConstraint" 'function)))

(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_addConstraint__SWIG_0" #.(lispify "btDiscreteDynamicsWorld_addConstraint" 'function)) :void
  (self :pointer)
  (constraint :pointer)
  (disableCollisionsBetweenLinkedBodies :pointer))

(export '#.(lispify "btDiscreteDynamicsWorld_addConstraint" 'function))

(declaim (inline #.(lispify "btDiscreteDynamicsWorld_addConstraint" 'function)))

(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_addConstraint__SWIG_1" #.(lispify "btDiscreteDynamicsWorld_addConstraint" 'function)) :void
  (self :pointer)
  (constraint :pointer))

(export '#.(lispify "btDiscreteDynamicsWorld_addConstraint" 'function))

(declaim (inline #.(lispify "btDiscreteDynamicsWorld_removeConstraint" 'function)))

(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_removeConstraint" #.(lispify "btDiscreteDynamicsWorld_removeConstraint" 'function)) :void
  (self :pointer)
  (constraint :pointer))

(export '#.(lispify "btDiscreteDynamicsWorld_removeConstraint" 'function))

(declaim (inline #.(lispify "btDiscreteDynamicsWorld_addAction" 'function)))

(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_addAction" #.(lispify "btDiscreteDynamicsWorld_addAction" 'function)) :void
  (self :pointer)
  (arg1 :pointer))

(export '#.(lispify "btDiscreteDynamicsWorld_addAction" 'function))

(declaim (inline #.(lispify "btDiscreteDynamicsWorld_removeAction" 'function)))

(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_removeAction" #.(lispify "btDiscreteDynamicsWorld_removeAction" 'function)) :void
  (self :pointer)
  (arg1 :pointer))

(export '#.(lispify "btDiscreteDynamicsWorld_removeAction" 'function))

(declaim (inline #.(lispify "btDiscreteDynamicsWorld_getSimulationIslandManager" 'function)))

(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_getSimulationIslandManager__SWIG_0" #.(lispify "btDiscreteDynamicsWorld_getSimulationIslandManager" 'function)) :pointer
  (self :pointer))

(export '#.(lispify "btDiscreteDynamicsWorld_getSimulationIslandManager" 'function))

(declaim (inline #.(lispify "btDiscreteDynamicsWorld_getSimulationIslandManager" 'function)))

(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_getSimulationIslandManager__SWIG_1" #.(lispify "btDiscreteDynamicsWorld_getSimulationIslandManager" 'function)) :pointer
  (self :pointer))

(export '#.(lispify "btDiscreteDynamicsWorld_getSimulationIslandManager" 'function))

(declaim (inline #.(lispify "btDiscreteDynamicsWorld_getCollisionWorld" 'function)))

(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_getCollisionWorld" #.(lispify "btDiscreteDynamicsWorld_getCollisionWorld" 'function)) :pointer
  (self :pointer))

(export '#.(lispify "btDiscreteDynamicsWorld_getCollisionWorld" 'function))

(declaim (inline #.(lispify "btDiscreteDynamicsWorld_setGravity" 'function)))

(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_setGravity" #.(lispify "btDiscreteDynamicsWorld_setGravity" 'function)) :void
  (self :pointer)
  (gravity :pointer))

(export '#.(lispify "btDiscreteDynamicsWorld_setGravity" 'function))

(declaim (inline #.(lispify "btDiscreteDynamicsWorld_getGravity" 'function)))

(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_getGravity" #.(lispify "btDiscreteDynamicsWorld_getGravity" 'function)) :pointer
  (self :pointer))

(export '#.(lispify "btDiscreteDynamicsWorld_getGravity" 'function))

(declaim (inline #.(lispify "btDiscreteDynamicsWorld_addCollisionObject" 'function)))

(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_addCollisionObject__SWIG_0" #.(lispify "btDiscreteDynamicsWorld_addCollisionObject" 'function)) :void
  (self :pointer)
  (collisionObject :pointer)
  (collisionFilterGroup :short)
  (collisionFilterMask :short))

(export '#.(lispify "btDiscreteDynamicsWorld_addCollisionObject" 'function))

(declaim (inline #.(lispify "btDiscreteDynamicsWorld_addCollisionObject" 'function)))

(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_addCollisionObject__SWIG_1" #.(lispify "btDiscreteDynamicsWorld_addCollisionObject" 'function)) :void
  (self :pointer)
  (collisionObject :pointer)
  (collisionFilterGroup :short))

(export '#.(lispify "btDiscreteDynamicsWorld_addCollisionObject" 'function))

(declaim (inline #.(lispify "btDiscreteDynamicsWorld_addCollisionObject" 'function)))

(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_addCollisionObject__SWIG_2" #.(lispify "btDiscreteDynamicsWorld_addCollisionObject" 'function)) :void
  (self :pointer)
  (collisionObject :pointer))

(export '#.(lispify "btDiscreteDynamicsWorld_addCollisionObject" 'function))

(declaim (inline #.(lispify "btDiscreteDynamicsWorld_addRigidBody" 'function)))

(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_addRigidBody__SWIG_0" #.(lispify "btDiscreteDynamicsWorld_addRigidBody" 'function)) :void
  (self :pointer)
  (body :pointer))

(export '#.(lispify "btDiscreteDynamicsWorld_addRigidBody" 'function))

(declaim (inline #.(lispify "btDiscreteDynamicsWorld_addRigidBody" 'function)))

(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_addRigidBody__SWIG_1" #.(lispify "btDiscreteDynamicsWorld_addRigidBody" 'function)) :void
  (self :pointer)
  (body :pointer)
  (group :short)
  (mask :short))

(export '#.(lispify "btDiscreteDynamicsWorld_addRigidBody" 'function))

(declaim (inline #.(lispify "btDiscreteDynamicsWorld_removeRigidBody" 'function)))

(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_removeRigidBody" #.(lispify "btDiscreteDynamicsWorld_removeRigidBody" 'function)) :void
  (self :pointer)
  (body :pointer))

(export '#.(lispify "btDiscreteDynamicsWorld_removeRigidBody" 'function))

(declaim (inline #.(lispify "btDiscreteDynamicsWorld_removeCollisionObject" 'function)))

(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_removeCollisionObject" #.(lispify "btDiscreteDynamicsWorld_removeCollisionObject" 'function)) :void
  (self :pointer)
  (collisionObject :pointer))

(export '#.(lispify "btDiscreteDynamicsWorld_removeCollisionObject" 'function))

(declaim (inline #.(lispify "btDiscreteDynamicsWorld_debugDrawConstraint" 'function)))

(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_debugDrawConstraint" #.(lispify "btDiscreteDynamicsWorld_debugDrawConstraint" 'function)) :void
  (self :pointer)
  (constraint :pointer))

(export '#.(lispify "btDiscreteDynamicsWorld_debugDrawConstraint" 'function))

(declaim (inline #.(lispify "btDiscreteDynamicsWorld_debugDrawWorld" 'function)))

(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_debugDrawWorld" #.(lispify "btDiscreteDynamicsWorld_debugDrawWorld" 'function)) :void
  (self :pointer))

(export '#.(lispify "btDiscreteDynamicsWorld_debugDrawWorld" 'function))

(declaim (inline #.(lispify "btDiscreteDynamicsWorld_setConstraintSolver" 'function)))

(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_setConstraintSolver" #.(lispify "btDiscreteDynamicsWorld_setConstraintSolver" 'function)) :void
  (self :pointer)
  (solver :pointer))

(export '#.(lispify "btDiscreteDynamicsWorld_setConstraintSolver" 'function))

(declaim (inline #.(lispify "btDiscreteDynamicsWorld_getConstraintSolver" 'function)))

(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_getConstraintSolver" #.(lispify "btDiscreteDynamicsWorld_getConstraintSolver" 'function)) :pointer
  (self :pointer))

(export '#.(lispify "btDiscreteDynamicsWorld_getConstraintSolver" 'function))

(declaim (inline #.(lispify "btDiscreteDynamicsWorld_getNumConstraints" 'function)))

(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_getNumConstraints" #.(lispify "btDiscreteDynamicsWorld_getNumConstraints" 'function)) :int
  (self :pointer))

(export '#.(lispify "btDiscreteDynamicsWorld_getNumConstraints" 'function))

(declaim (inline #.(lispify "btDiscreteDynamicsWorld_getConstraint" 'function)))

(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_getConstraint__SWIG_0" #.(lispify "btDiscreteDynamicsWorld_getConstraint" 'function)) :pointer
  (self :pointer)
  (index :int))

(export '#.(lispify "btDiscreteDynamicsWorld_getConstraint" 'function))

(declaim (inline #.(lispify "btDiscreteDynamicsWorld_getConstraint" 'function)))

(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_getConstraint__SWIG_1" #.(lispify "btDiscreteDynamicsWorld_getConstraint" 'function)) :pointer
  (self :pointer)
  (index :int))

(export '#.(lispify "btDiscreteDynamicsWorld_getConstraint" 'function))

(declaim (inline #.(lispify "btDiscreteDynamicsWorld_getWorldType" 'function)))

(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_getWorldType" #.(lispify "btDiscreteDynamicsWorld_getWorldType" 'function)) :pointer
  (self :pointer))

(export '#.(lispify "btDiscreteDynamicsWorld_getWorldType" 'function))

(declaim (inline #.(lispify "btDiscreteDynamicsWorld_clearForces" 'function)))

(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_clearForces" #.(lispify "btDiscreteDynamicsWorld_clearForces" 'function)) :void
  (self :pointer))

(export '#.(lispify "btDiscreteDynamicsWorld_clearForces" 'function))

(declaim (inline #.(lispify "btDiscreteDynamicsWorld_applyGravity" 'function)))

(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_applyGravity" #.(lispify "btDiscreteDynamicsWorld_applyGravity" 'function)) :void
  (self :pointer))

(export '#.(lispify "btDiscreteDynamicsWorld_applyGravity" 'function))

(declaim (inline #.(lispify "btDiscreteDynamicsWorld_setNumTasks" 'function)))

(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_setNumTasks" #.(lispify "btDiscreteDynamicsWorld_setNumTasks" 'function)) :void
  (self :pointer)
  (numTasks :int))

(export '#.(lispify "btDiscreteDynamicsWorld_setNumTasks" 'function))

(declaim (inline #.(lispify "btDiscreteDynamicsWorld_updateVehicles" 'function)))

(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_updateVehicles" #.(lispify "btDiscreteDynamicsWorld_updateVehicles" 'function)) :void
  (self :pointer)
  (timeStep :float))

(export '#.(lispify "btDiscreteDynamicsWorld_updateVehicles" 'function))

(declaim (inline #.(lispify "btDiscreteDynamicsWorld_addVehicle" 'function)))

(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_addVehicle" #.(lispify "btDiscreteDynamicsWorld_addVehicle" 'function)) :void
  (self :pointer)
  (vehicle :pointer))

(export '#.(lispify "btDiscreteDynamicsWorld_addVehicle" 'function))

(declaim (inline #.(lispify "btDiscreteDynamicsWorld_removeVehicle" 'function)))

(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_removeVehicle" #.(lispify "btDiscreteDynamicsWorld_removeVehicle" 'function)) :void
  (self :pointer)
  (vehicle :pointer))

(export '#.(lispify "btDiscreteDynamicsWorld_removeVehicle" 'function))

(declaim (inline #.(lispify "btDiscreteDynamicsWorld_addCharacter" 'function)))

(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_addCharacter" #.(lispify "btDiscreteDynamicsWorld_addCharacter" 'function)) :void
  (self :pointer)
  (character :pointer))

(export '#.(lispify "btDiscreteDynamicsWorld_addCharacter" 'function))

(declaim (inline #.(lispify "btDiscreteDynamicsWorld_removeCharacter" 'function)))

(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_removeCharacter" #.(lispify "btDiscreteDynamicsWorld_removeCharacter" 'function)) :void
  (self :pointer)
  (character :pointer))

(export '#.(lispify "btDiscreteDynamicsWorld_removeCharacter" 'function))

(declaim (inline #.(lispify "btDiscreteDynamicsWorld_setSynchronizeAllMotionStates" 'function)))

(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_setSynchronizeAllMotionStates" #.(lispify "btDiscreteDynamicsWorld_setSynchronizeAllMotionStates" 'function)) :void
  (self :pointer)
  (synchronizeAll :pointer))

(export '#.(lispify "btDiscreteDynamicsWorld_setSynchronizeAllMotionStates" 'function))

(declaim (inline #.(lispify "btDiscreteDynamicsWorld_getSynchronizeAllMotionStates" 'function)))

(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_getSynchronizeAllMotionStates" #.(lispify "btDiscreteDynamicsWorld_getSynchronizeAllMotionStates" 'function)) :pointer
  (self :pointer))

(export '#.(lispify "btDiscreteDynamicsWorld_getSynchronizeAllMotionStates" 'function))

(declaim (inline #.(lispify "btDiscreteDynamicsWorld_setApplySpeculativeContactRestitution" 'function)))

(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_setApplySpeculativeContactRestitution" #.(lispify "btDiscreteDynamicsWorld_setApplySpeculativeContactRestitution" 'function)) :void
  (self :pointer)
  (enable :pointer))

(export '#.(lispify "btDiscreteDynamicsWorld_setApplySpeculativeContactRestitution" 'function))

(declaim (inline #.(lispify "btDiscreteDynamicsWorld_getApplySpeculativeContactRestitution" 'function)))

(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_getApplySpeculativeContactRestitution" #.(lispify "btDiscreteDynamicsWorld_getApplySpeculativeContactRestitution" 'function)) :pointer
  (self :pointer))

(export '#.(lispify "btDiscreteDynamicsWorld_getApplySpeculativeContactRestitution" 'function))

(declaim (inline #.(lispify "btDiscreteDynamicsWorld_serialize" 'function)))

(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_serialize" #.(lispify "btDiscreteDynamicsWorld_serialize" 'function)) :void
  (self :pointer)
  (serializer :pointer))

(export '#.(lispify "btDiscreteDynamicsWorld_serialize" 'function))

(declaim (inline #.(lispify "btDiscreteDynamicsWorld_setLatencyMotionStateInterpolation" 'function)))

(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_setLatencyMotionStateInterpolation" #.(lispify "btDiscreteDynamicsWorld_setLatencyMotionStateInterpolation" 'function)) :void
  (self :pointer)
  (latencyInterpolation :pointer))

(export '#.(lispify "btDiscreteDynamicsWorld_setLatencyMotionStateInterpolation" 'function))

(declaim (inline #.(lispify "btDiscreteDynamicsWorld_getLatencyMotionStateInterpolation" 'function)))

(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_getLatencyMotionStateInterpolation" #.(lispify "btDiscreteDynamicsWorld_getLatencyMotionStateInterpolation" 'function)) :pointer
  (self :pointer))

(export '#.(lispify "btDiscreteDynamicsWorld_getLatencyMotionStateInterpolation" 'function))

(declaim (inline #.(lispify "new_btSimpleDynamicsWorld" 'function)))

(cffi:defcfun ("_wrap_new_btSimpleDynamicsWorld" #.(lispify "new_btSimpleDynamicsWorld" 'function)) :pointer
  (dispatcher :pointer)
  (pairCache :pointer)
  (constraintSolver :pointer)
  (collisionConfiguration :pointer))

(export '#.(lispify "new_btSimpleDynamicsWorld" 'function))

(declaim (inline #.(lispify "delete_btSimpleDynamicsWorld" 'function)))

(cffi:defcfun ("_wrap_delete_btSimpleDynamicsWorld" #.(lispify "delete_btSimpleDynamicsWorld" 'function)) :void
  (self :pointer))

(export '#.(lispify "delete_btSimpleDynamicsWorld" 'function))

(declaim (inline #.(lispify "btSimpleDynamicsWorld_stepSimulation" 'function)))

(cffi:defcfun ("_wrap_btSimpleDynamicsWorld_stepSimulation__SWIG_0" #.(lispify "btSimpleDynamicsWorld_stepSimulation" 'function)) :int
  (self :pointer)
  (timeStep :float)
  (maxSubSteps :int)
  (fixedTimeStep :float))

(export '#.(lispify "btSimpleDynamicsWorld_stepSimulation" 'function))

(declaim (inline #.(lispify "btSimpleDynamicsWorld_stepSimulation" 'function)))

(cffi:defcfun ("_wrap_btSimpleDynamicsWorld_stepSimulation__SWIG_1" #.(lispify "btSimpleDynamicsWorld_stepSimulation" 'function)) :int
  (self :pointer)
  (timeStep :float)
  (maxSubSteps :int))

(export '#.(lispify "btSimpleDynamicsWorld_stepSimulation" 'function))

(declaim (inline #.(lispify "btSimpleDynamicsWorld_stepSimulation" 'function)))

(cffi:defcfun ("_wrap_btSimpleDynamicsWorld_stepSimulation__SWIG_2" #.(lispify "btSimpleDynamicsWorld_stepSimulation" 'function)) :int
  (self :pointer)
  (timeStep :float))

(export '#.(lispify "btSimpleDynamicsWorld_stepSimulation" 'function))

(declaim (inline #.(lispify "btSimpleDynamicsWorld_setGravity" 'function)))

(cffi:defcfun ("_wrap_btSimpleDynamicsWorld_setGravity" #.(lispify "btSimpleDynamicsWorld_setGravity" 'function)) :void
  (self :pointer)
  (gravity :pointer))

(export '#.(lispify "btSimpleDynamicsWorld_setGravity" 'function))

(declaim (inline #.(lispify "btSimpleDynamicsWorld_getGravity" 'function)))

(cffi:defcfun ("_wrap_btSimpleDynamicsWorld_getGravity" #.(lispify "btSimpleDynamicsWorld_getGravity" 'function)) :pointer
  (self :pointer))

(export '#.(lispify "btSimpleDynamicsWorld_getGravity" 'function))

(declaim (inline #.(lispify "btSimpleDynamicsWorld_addRigidBody" 'function)))

(cffi:defcfun ("_wrap_btSimpleDynamicsWorld_addRigidBody__SWIG_0" #.(lispify "btSimpleDynamicsWorld_addRigidBody" 'function)) :void
  (self :pointer)
  (body :pointer))

(export '#.(lispify "btSimpleDynamicsWorld_addRigidBody" 'function))

(declaim (inline #.(lispify "btSimpleDynamicsWorld_addRigidBody" 'function)))

(cffi:defcfun ("_wrap_btSimpleDynamicsWorld_addRigidBody__SWIG_1" #.(lispify "btSimpleDynamicsWorld_addRigidBody" 'function)) :void
  (self :pointer)
  (body :pointer)
  (group :short)
  (mask :short))

(export '#.(lispify "btSimpleDynamicsWorld_addRigidBody" 'function))

(declaim (inline #.(lispify "btSimpleDynamicsWorld_removeRigidBody" 'function)))

(cffi:defcfun ("_wrap_btSimpleDynamicsWorld_removeRigidBody" #.(lispify "btSimpleDynamicsWorld_removeRigidBody" 'function)) :void
  (self :pointer)
  (body :pointer))

(export '#.(lispify "btSimpleDynamicsWorld_removeRigidBody" 'function))

(declaim (inline #.(lispify "btSimpleDynamicsWorld_debugDrawWorld" 'function)))

(cffi:defcfun ("_wrap_btSimpleDynamicsWorld_debugDrawWorld" #.(lispify "btSimpleDynamicsWorld_debugDrawWorld" 'function)) :void
  (self :pointer))

(export '#.(lispify "btSimpleDynamicsWorld_debugDrawWorld" 'function))

(declaim (inline #.(lispify "btSimpleDynamicsWorld_addAction" 'function)))

(cffi:defcfun ("_wrap_btSimpleDynamicsWorld_addAction" #.(lispify "btSimpleDynamicsWorld_addAction" 'function)) :void
  (self :pointer)
  (action :pointer))

(export '#.(lispify "btSimpleDynamicsWorld_addAction" 'function))

(declaim (inline #.(lispify "btSimpleDynamicsWorld_removeAction" 'function)))

(cffi:defcfun ("_wrap_btSimpleDynamicsWorld_removeAction" #.(lispify "btSimpleDynamicsWorld_removeAction" 'function)) :void
  (self :pointer)
  (action :pointer))

(export '#.(lispify "btSimpleDynamicsWorld_removeAction" 'function))

(declaim (inline #.(lispify "btSimpleDynamicsWorld_removeCollisionObject" 'function)))

(cffi:defcfun ("_wrap_btSimpleDynamicsWorld_removeCollisionObject" #.(lispify "btSimpleDynamicsWorld_removeCollisionObject" 'function)) :void
  (self :pointer)
  (collisionObject :pointer))

(export '#.(lispify "btSimpleDynamicsWorld_removeCollisionObject" 'function))

(declaim (inline #.(lispify "btSimpleDynamicsWorld_updateAabbs" 'function)))

(cffi:defcfun ("_wrap_btSimpleDynamicsWorld_updateAabbs" #.(lispify "btSimpleDynamicsWorld_updateAabbs" 'function)) :void
  (self :pointer))

(export '#.(lispify "btSimpleDynamicsWorld_updateAabbs" 'function))

(declaim (inline #.(lispify "btSimpleDynamicsWorld_synchronizeMotionStates" 'function)))

(cffi:defcfun ("_wrap_btSimpleDynamicsWorld_synchronizeMotionStates" #.(lispify "btSimpleDynamicsWorld_synchronizeMotionStates" 'function)) :void
  (self :pointer))

(export '#.(lispify "btSimpleDynamicsWorld_synchronizeMotionStates" 'function))

(declaim (inline #.(lispify "btSimpleDynamicsWorld_setConstraintSolver" 'function)))

(cffi:defcfun ("_wrap_btSimpleDynamicsWorld_setConstraintSolver" #.(lispify "btSimpleDynamicsWorld_setConstraintSolver" 'function)) :void
  (self :pointer)
  (solver :pointer))

(export '#.(lispify "btSimpleDynamicsWorld_setConstraintSolver" 'function))

(declaim (inline #.(lispify "btSimpleDynamicsWorld_getConstraintSolver" 'function)))

(cffi:defcfun ("_wrap_btSimpleDynamicsWorld_getConstraintSolver" #.(lispify "btSimpleDynamicsWorld_getConstraintSolver" 'function)) :pointer
  (self :pointer))

(export '#.(lispify "btSimpleDynamicsWorld_getConstraintSolver" 'function))

(declaim (inline #.(lispify "btSimpleDynamicsWorld_getWorldType" 'function)))

(cffi:defcfun ("_wrap_btSimpleDynamicsWorld_getWorldType" #.(lispify "btSimpleDynamicsWorld_getWorldType" 'function)) :pointer
  (self :pointer))

(export '#.(lispify "btSimpleDynamicsWorld_getWorldType" 'function))

(declaim (inline #.(lispify "btSimpleDynamicsWorld_clearForces" 'function)))

(cffi:defcfun ("_wrap_btSimpleDynamicsWorld_clearForces" #.(lispify "btSimpleDynamicsWorld_clearForces" 'function)) :void
  (self :pointer))

(export '#.(lispify "btSimpleDynamicsWorld_clearForces" 'function))

(cffi:defcvar ("gDeactivationTime" #.(lispify "gDeactivationTime" 'variable))
 :float)

(export '#.(lispify "gDeactivationTime" 'variable))

(cffi:defcvar ("gDisableDeactivation" #.(lispify "gDisableDeactivation" 'variable))
 :pointer)

(export '#.(lispify "gDisableDeactivation" 'variable))

(define-constant #.(lispify "btRigidBodyDataName" 'constant) "btRigidBodyFloatData" :test 'equal)

(export '#.(lispify "btRigidBodyDataName" 'constant))

(cffi:defcenum #.(lispify "btRigidBodyFlags" 'enumname)
	(#.(lispify "BT_DISABLE_WORLD_GRAVITY" 'enumvalue :keyword) #.1)
	(#.(lispify "BT_ENABLE_GYROPSCOPIC_FORCE" 'enumvalue :keyword) #.2))

(export '#.(lispify "btRigidBodyFlags" 'enumname))

(declaim (inline #.(lispify "new_btRigidBody" 'function)))

(cffi:defcfun ("_wrap_new_btRigidBody__SWIG_0" #.(lispify "new_btRigidBody" 'function)) :pointer
  (constructionInfo :pointer))

(export '#.(lispify "new_btRigidBody" 'function))

(declaim (inline #.(lispify "new_btRigidBody" 'function)))

(cffi:defcfun ("_wrap_new_btRigidBody__SWIG_1" #.(lispify "new_btRigidBody" 'function)) :pointer
  (mass :float)
  (motionState :pointer)
  (collisionShape :pointer)
  (localInertia :pointer))

(export '#.(lispify "new_btRigidBody" 'function))

(declaim (inline #.(lispify "new_btRigidBody" 'function)))

(cffi:defcfun ("_wrap_new_btRigidBody__SWIG_2" #.(lispify "new_btRigidBody" 'function)) :pointer
  (mass :float)
  (motionState :pointer)
  (collisionShape :pointer))

(export '#.(lispify "new_btRigidBody" 'function))

(declaim (inline #.(lispify "delete_btRigidBody" 'function)))

(cffi:defcfun ("_wrap_delete_btRigidBody" #.(lispify "delete_btRigidBody" 'function)) :void
  (self :pointer))

(export '#.(lispify "delete_btRigidBody" 'function))

(declaim (inline #.(lispify "btRigidBody_proceedToTransform" 'function)))

(cffi:defcfun ("_wrap_btRigidBody_proceedToTransform" #.(lispify "btRigidBody_proceedToTransform" 'function)) :void
  (self :pointer)
  (newTrans :pointer))

(export '#.(lispify "btRigidBody_proceedToTransform" 'function))

(declaim (inline #.(lispify "btRigidBody_upcast" 'function)))

(cffi:defcfun ("_wrap_btRigidBody_upcast__SWIG_0" #.(lispify "btRigidBody_upcast" 'function)) :pointer
  (colObj :pointer))

(export '#.(lispify "btRigidBody_upcast" 'function))

(declaim (inline #.(lispify "btRigidBody_upcast" 'function)))

(cffi:defcfun ("_wrap_btRigidBody_upcast__SWIG_1" #.(lispify "btRigidBody_upcast" 'function)) :pointer
  (colObj :pointer))

(export '#.(lispify "btRigidBody_upcast" 'function))

(declaim (inline #.(lispify "btRigidBody_predictIntegratedTransform" 'function)))

(cffi:defcfun ("_wrap_btRigidBody_predictIntegratedTransform" #.(lispify "btRigidBody_predictIntegratedTransform" 'function)) :void
  (self :pointer)
  (step :float)
  (predictedTransform :pointer))

(export '#.(lispify "btRigidBody_predictIntegratedTransform" 'function))

(declaim (inline #.(lispify "btRigidBody_saveKinematicState" 'function)))

(cffi:defcfun ("_wrap_btRigidBody_saveKinematicState" #.(lispify "btRigidBody_saveKinematicState" 'function)) :void
  (self :pointer)
  (step :float))

(export '#.(lispify "btRigidBody_saveKinematicState" 'function))

(declaim (inline #.(lispify "btRigidBody_applyGravity" 'function)))

(cffi:defcfun ("_wrap_btRigidBody_applyGravity" #.(lispify "btRigidBody_applyGravity" 'function)) :void
  (self :pointer))

(export '#.(lispify "btRigidBody_applyGravity" 'function))

(declaim (inline #.(lispify "btRigidBody_setGravity" 'function)))

(cffi:defcfun ("_wrap_btRigidBody_setGravity" #.(lispify "btRigidBody_setGravity" 'function)) :void
  (self :pointer)
  (acceleration :pointer))

(export '#.(lispify "btRigidBody_setGravity" 'function))

(declaim (inline #.(lispify "btRigidBody_getGravity" 'function)))

(cffi:defcfun ("_wrap_btRigidBody_getGravity" #.(lispify "btRigidBody_getGravity" 'function)) :pointer
  (self :pointer))

(export '#.(lispify "btRigidBody_getGravity" 'function))

(declaim (inline #.(lispify "btRigidBody_setDamping" 'function)))

(cffi:defcfun ("_wrap_btRigidBody_setDamping" #.(lispify "btRigidBody_setDamping" 'function)) :void
  (self :pointer)
  (lin_damping :float)
  (ang_damping :float))

(export '#.(lispify "btRigidBody_setDamping" 'function))

(declaim (inline #.(lispify "btRigidBody_getLinearDamping" 'function)))

(cffi:defcfun ("_wrap_btRigidBody_getLinearDamping" #.(lispify "btRigidBody_getLinearDamping" 'function)) :float
  (self :pointer))

(export '#.(lispify "btRigidBody_getLinearDamping" 'function))

(declaim (inline #.(lispify "btRigidBody_getAngularDamping" 'function)))

(cffi:defcfun ("_wrap_btRigidBody_getAngularDamping" #.(lispify "btRigidBody_getAngularDamping" 'function)) :float
  (self :pointer))

(export '#.(lispify "btRigidBody_getAngularDamping" 'function))

(declaim (inline #.(lispify "btRigidBody_getLinearSleepingThreshold" 'function)))

(cffi:defcfun ("_wrap_btRigidBody_getLinearSleepingThreshold" #.(lispify "btRigidBody_getLinearSleepingThreshold" 'function)) :float
  (self :pointer))

(export '#.(lispify "btRigidBody_getLinearSleepingThreshold" 'function))

(declaim (inline #.(lispify "btRigidBody_getAngularSleepingThreshold" 'function)))

(cffi:defcfun ("_wrap_btRigidBody_getAngularSleepingThreshold" #.(lispify "btRigidBody_getAngularSleepingThreshold" 'function)) :float
  (self :pointer))

(export '#.(lispify "btRigidBody_getAngularSleepingThreshold" 'function))

(declaim (inline #.(lispify "btRigidBody_applyDamping" 'function)))

(cffi:defcfun ("_wrap_btRigidBody_applyDamping" #.(lispify "btRigidBody_applyDamping" 'function)) :void
  (self :pointer)
  (timeStep :float))

(export '#.(lispify "btRigidBody_applyDamping" 'function))

(declaim (inline #.(lispify "btRigidBody_getCollisionShape" 'function)))

(cffi:defcfun ("_wrap_btRigidBody_getCollisionShape__SWIG_0" #.(lispify "btRigidBody_getCollisionShape" 'function)) :pointer
  (self :pointer))

(export '#.(lispify "btRigidBody_getCollisionShape" 'function))

(declaim (inline #.(lispify "btRigidBody_getCollisionShape" 'function)))

(cffi:defcfun ("_wrap_btRigidBody_getCollisionShape__SWIG_1" #.(lispify "btRigidBody_getCollisionShape" 'function)) :pointer
  (self :pointer))

(export '#.(lispify "btRigidBody_getCollisionShape" 'function))

(declaim (inline #.(lispify "btRigidBody_setMassProps" 'function)))

(cffi:defcfun ("_wrap_btRigidBody_setMassProps" #.(lispify "btRigidBody_setMassProps" 'function)) :void
  (self :pointer)
  (mass :float)
  (inertia :pointer))

(export '#.(lispify "btRigidBody_setMassProps" 'function))

(declaim (inline #.(lispify "btRigidBody_getLinearFactor" 'function)))

(cffi:defcfun ("_wrap_btRigidBody_getLinearFactor" #.(lispify "btRigidBody_getLinearFactor" 'function)) :pointer
  (self :pointer))

(export '#.(lispify "btRigidBody_getLinearFactor" 'function))

(declaim (inline #.(lispify "btRigidBody_setLinearFactor" 'function)))

(cffi:defcfun ("_wrap_btRigidBody_setLinearFactor" #.(lispify "btRigidBody_setLinearFactor" 'function)) :void
  (self :pointer)
  (linearFactor :pointer))

(export '#.(lispify "btRigidBody_setLinearFactor" 'function))

(declaim (inline #.(lispify "btRigidBody_getInvMass" 'function)))

(cffi:defcfun ("_wrap_btRigidBody_getInvMass" #.(lispify "btRigidBody_getInvMass" 'function)) :float
  (self :pointer))

(export '#.(lispify "btRigidBody_getInvMass" 'function))

(declaim (inline #.(lispify "btRigidBody_getInvInertiaTensorWorld" 'function)))

(cffi:defcfun ("_wrap_btRigidBody_getInvInertiaTensorWorld" #.(lispify "btRigidBody_getInvInertiaTensorWorld" 'function)) :pointer
  (self :pointer))

(export '#.(lispify "btRigidBody_getInvInertiaTensorWorld" 'function))

(declaim (inline #.(lispify "btRigidBody_integrateVelocities" 'function)))

(cffi:defcfun ("_wrap_btRigidBody_integrateVelocities" #.(lispify "btRigidBody_integrateVelocities" 'function)) :void
  (self :pointer)
  (step :float))

(export '#.(lispify "btRigidBody_integrateVelocities" 'function))

(declaim (inline #.(lispify "btRigidBody_setCenterOfMassTransform" 'function)))

(cffi:defcfun ("_wrap_btRigidBody_setCenterOfMassTransform" #.(lispify "btRigidBody_setCenterOfMassTransform" 'function)) :void
  (self :pointer)
  (xform :pointer))

(export '#.(lispify "btRigidBody_setCenterOfMassTransform" 'function))

(declaim (inline #.(lispify "btRigidBody_applyCentralForce" 'function)))

(cffi:defcfun ("_wrap_btRigidBody_applyCentralForce" #.(lispify "btRigidBody_applyCentralForce" 'function)) :void
  (self :pointer)
  (force :pointer))

(export '#.(lispify "btRigidBody_applyCentralForce" 'function))

(declaim (inline #.(lispify "btRigidBody_getTotalForce" 'function)))

(cffi:defcfun ("_wrap_btRigidBody_getTotalForce" #.(lispify "btRigidBody_getTotalForce" 'function)) :pointer
  (self :pointer))

(export '#.(lispify "btRigidBody_getTotalForce" 'function))

(declaim (inline #.(lispify "btRigidBody_getTotalTorque" 'function)))

(cffi:defcfun ("_wrap_btRigidBody_getTotalTorque" #.(lispify "btRigidBody_getTotalTorque" 'function)) :pointer
  (self :pointer))

(export '#.(lispify "btRigidBody_getTotalTorque" 'function))

(declaim (inline #.(lispify "btRigidBody_getInvInertiaDiagLocal" 'function)))

(cffi:defcfun ("_wrap_btRigidBody_getInvInertiaDiagLocal" #.(lispify "btRigidBody_getInvInertiaDiagLocal" 'function)) :pointer
  (self :pointer))

(export '#.(lispify "btRigidBody_getInvInertiaDiagLocal" 'function))

(declaim (inline #.(lispify "btRigidBody_setInvInertiaDiagLocal" 'function)))

(cffi:defcfun ("_wrap_btRigidBody_setInvInertiaDiagLocal" #.(lispify "btRigidBody_setInvInertiaDiagLocal" 'function)) :void
  (self :pointer)
  (diagInvInertia :pointer))

(export '#.(lispify "btRigidBody_setInvInertiaDiagLocal" 'function))

(declaim (inline #.(lispify "btRigidBody_setSleepingThresholds" 'function)))

(cffi:defcfun ("_wrap_btRigidBody_setSleepingThresholds" #.(lispify "btRigidBody_setSleepingThresholds" 'function)) :void
  (self :pointer)
  (linear :float)
  (angular :float))

(export '#.(lispify "btRigidBody_setSleepingThresholds" 'function))

(declaim (inline #.(lispify "btRigidBody_applyTorque" 'function)))

(cffi:defcfun ("_wrap_btRigidBody_applyTorque" #.(lispify "btRigidBody_applyTorque" 'function)) :void
  (self :pointer)
  (torque :pointer))

(export '#.(lispify "btRigidBody_applyTorque" 'function))

(declaim (inline #.(lispify "btRigidBody_applyForce" 'function)))

(cffi:defcfun ("_wrap_btRigidBody_applyForce" #.(lispify "btRigidBody_applyForce" 'function)) :void
  (self :pointer)
  (force :pointer)
  (rel_pos :pointer))

(export '#.(lispify "btRigidBody_applyForce" 'function))

(declaim (inline #.(lispify "btRigidBody_applyCentralImpulse" 'function)))

(cffi:defcfun ("_wrap_btRigidBody_applyCentralImpulse" #.(lispify "btRigidBody_applyCentralImpulse" 'function)) :void
  (self :pointer)
  (impulse :pointer))

(export '#.(lispify "btRigidBody_applyCentralImpulse" 'function))

(declaim (inline #.(lispify "btRigidBody_applyTorqueImpulse" 'function)))

(cffi:defcfun ("_wrap_btRigidBody_applyTorqueImpulse" #.(lispify "btRigidBody_applyTorqueImpulse" 'function)) :void
  (self :pointer)
  (torque :pointer))

(export '#.(lispify "btRigidBody_applyTorqueImpulse" 'function))

(declaim (inline #.(lispify "btRigidBody_applyImpulse" 'function)))

(cffi:defcfun ("_wrap_btRigidBody_applyImpulse" #.(lispify "btRigidBody_applyImpulse" 'function)) :void
  (self :pointer)
  (impulse :pointer)
  (rel_pos :pointer))

(export '#.(lispify "btRigidBody_applyImpulse" 'function))

(declaim (inline #.(lispify "btRigidBody_clearForces" 'function)))

(cffi:defcfun ("_wrap_btRigidBody_clearForces" #.(lispify "btRigidBody_clearForces" 'function)) :void
  (self :pointer))

(export '#.(lispify "btRigidBody_clearForces" 'function))

(declaim (inline #.(lispify "btRigidBody_updateInertiaTensor" 'function)))

(cffi:defcfun ("_wrap_btRigidBody_updateInertiaTensor" #.(lispify "btRigidBody_updateInertiaTensor" 'function)) :void
  (self :pointer))

(export '#.(lispify "btRigidBody_updateInertiaTensor" 'function))

(declaim (inline #.(lispify "btRigidBody_getCenterOfMassPosition" 'function)))

(cffi:defcfun ("_wrap_btRigidBody_getCenterOfMassPosition" #.(lispify "btRigidBody_getCenterOfMassPosition" 'function)) :pointer
  (self :pointer))

(export '#.(lispify "btRigidBody_getCenterOfMassPosition" 'function))

(declaim (inline #.(lispify "btRigidBody_getOrientation" 'function)))

(cffi:defcfun ("_wrap_btRigidBody_getOrientation" #.(lispify "btRigidBody_getOrientation" 'function)) :pointer
  (self :pointer))

(export '#.(lispify "btRigidBody_getOrientation" 'function))

(declaim (inline #.(lispify "btRigidBody_getCenterOfMassTransform" 'function)))

(cffi:defcfun ("_wrap_btRigidBody_getCenterOfMassTransform" #.(lispify "btRigidBody_getCenterOfMassTransform" 'function)) :pointer
  (self :pointer))

(export '#.(lispify "btRigidBody_getCenterOfMassTransform" 'function))

(declaim (inline #.(lispify "btRigidBody_getLinearVelocity" 'function)))

(cffi:defcfun ("_wrap_btRigidBody_getLinearVelocity" #.(lispify "btRigidBody_getLinearVelocity" 'function)) :pointer
  (self :pointer))

(export '#.(lispify "btRigidBody_getLinearVelocity" 'function))

(declaim (inline #.(lispify "btRigidBody_getAngularVelocity" 'function)))

(cffi:defcfun ("_wrap_btRigidBody_getAngularVelocity" #.(lispify "btRigidBody_getAngularVelocity" 'function)) :pointer
  (self :pointer))

(export '#.(lispify "btRigidBody_getAngularVelocity" 'function))

(declaim (inline #.(lispify "btRigidBody_setLinearVelocity" 'function)))

(cffi:defcfun ("_wrap_btRigidBody_setLinearVelocity" #.(lispify "btRigidBody_setLinearVelocity" 'function)) :void
  (self :pointer)
  (lin_vel :pointer))

(export '#.(lispify "btRigidBody_setLinearVelocity" 'function))

(declaim (inline #.(lispify "btRigidBody_setAngularVelocity" 'function)))

(cffi:defcfun ("_wrap_btRigidBody_setAngularVelocity" #.(lispify "btRigidBody_setAngularVelocity" 'function)) :void
  (self :pointer)
  (ang_vel :pointer))

(export '#.(lispify "btRigidBody_setAngularVelocity" 'function))

(declaim (inline #.(lispify "btRigidBody_getVelocityInLocalPoint" 'function)))

(cffi:defcfun ("_wrap_btRigidBody_getVelocityInLocalPoint" #.(lispify "btRigidBody_getVelocityInLocalPoint" 'function)) :pointer
  (self :pointer)
  (rel_pos :pointer))

(export '#.(lispify "btRigidBody_getVelocityInLocalPoint" 'function))

(declaim (inline #.(lispify "btRigidBody_translate" 'function)))

(cffi:defcfun ("_wrap_btRigidBody_translate" #.(lispify "btRigidBody_translate" 'function)) :void
  (self :pointer)
  (v :pointer))

(export '#.(lispify "btRigidBody_translate" 'function))

(declaim (inline #.(lispify "btRigidBody_getAabb" 'function)))

(cffi:defcfun ("_wrap_btRigidBody_getAabb" #.(lispify "btRigidBody_getAabb" 'function)) :void
  (self :pointer)
  (aabbMin :pointer)
  (aabbMax :pointer))

(export '#.(lispify "btRigidBody_getAabb" 'function))

(declaim (inline #.(lispify "btRigidBody_computeImpulseDenominator" 'function)))

(cffi:defcfun ("_wrap_btRigidBody_computeImpulseDenominator" #.(lispify "btRigidBody_computeImpulseDenominator" 'function)) :float
  (self :pointer)
  (pos :pointer)
  (normal :pointer))

(export '#.(lispify "btRigidBody_computeImpulseDenominator" 'function))

(declaim (inline #.(lispify "btRigidBody_computeAngularImpulseDenominator" 'function)))

(cffi:defcfun ("_wrap_btRigidBody_computeAngularImpulseDenominator" #.(lispify "btRigidBody_computeAngularImpulseDenominator" 'function)) :float
  (self :pointer)
  (axis :pointer))

(export '#.(lispify "btRigidBody_computeAngularImpulseDenominator" 'function))

(declaim (inline #.(lispify "btRigidBody_updateDeactivation" 'function)))

(cffi:defcfun ("_wrap_btRigidBody_updateDeactivation" #.(lispify "btRigidBody_updateDeactivation" 'function)) :void
  (self :pointer)
  (timeStep :float))

(export '#.(lispify "btRigidBody_updateDeactivation" 'function))

(declaim (inline #.(lispify "btRigidBody_wantsSleeping" 'function)))

(cffi:defcfun ("_wrap_btRigidBody_wantsSleeping" #.(lispify "btRigidBody_wantsSleeping" 'function)) :pointer
  (self :pointer))

(export '#.(lispify "btRigidBody_wantsSleeping" 'function))

(declaim (inline #.(lispify "btRigidBody_getBroadphaseProxy" 'function)))

(cffi:defcfun ("_wrap_btRigidBody_getBroadphaseProxy__SWIG_0" #.(lispify "btRigidBody_getBroadphaseProxy" 'function)) :pointer
  (self :pointer))

(export '#.(lispify "btRigidBody_getBroadphaseProxy" 'function))

(declaim (inline #.(lispify "btRigidBody_getBroadphaseProxy" 'function)))

(cffi:defcfun ("_wrap_btRigidBody_getBroadphaseProxy__SWIG_1" #.(lispify "btRigidBody_getBroadphaseProxy" 'function)) :pointer
  (self :pointer))

(export '#.(lispify "btRigidBody_getBroadphaseProxy" 'function))

(declaim (inline #.(lispify "btRigidBody_setNewBroadphaseProxy" 'function)))

(cffi:defcfun ("_wrap_btRigidBody_setNewBroadphaseProxy" #.(lispify "btRigidBody_setNewBroadphaseProxy" 'function)) :void
  (self :pointer)
  (broadphaseProxy :pointer))

(export '#.(lispify "btRigidBody_setNewBroadphaseProxy" 'function))

(declaim (inline #.(lispify "btRigidBody_getMotionState" 'function)))

(cffi:defcfun ("_wrap_btRigidBody_getMotionState__SWIG_0" #.(lispify "btRigidBody_getMotionState" 'function)) :pointer
  (self :pointer))

(export '#.(lispify "btRigidBody_getMotionState" 'function))

(declaim (inline #.(lispify "btRigidBody_getMotionState" 'function)))

(cffi:defcfun ("_wrap_btRigidBody_getMotionState__SWIG_1" #.(lispify "btRigidBody_getMotionState" 'function)) :pointer
  (self :pointer))

(export '#.(lispify "btRigidBody_getMotionState" 'function))

(declaim (inline #.(lispify "btRigidBody_setMotionState" 'function)))

(cffi:defcfun ("_wrap_btRigidBody_setMotionState" #.(lispify "btRigidBody_setMotionState" 'function)) :void
  (self :pointer)
  (motionState :pointer))

(export '#.(lispify "btRigidBody_setMotionState" 'function))

(declaim (inline #.(lispify "btRigidBody_m_contactSolverType_set" 'function)))

(cffi:defcfun ("_wrap_btRigidBody_m_contactSolverType_set" #.(lispify "btRigidBody_m_contactSolverType_set" 'function)) :void
  (self :pointer)
  (m_contactSolverType :int))

(export '#.(lispify "btRigidBody_m_contactSolverType_set" 'function))

(declaim (inline #.(lispify "btRigidBody_m_contactSolverType_get" 'function)))

(cffi:defcfun ("_wrap_btRigidBody_m_contactSolverType_get" #.(lispify "btRigidBody_m_contactSolverType_get" 'function)) :int
  (self :pointer))

(export '#.(lispify "btRigidBody_m_contactSolverType_get" 'function))

(declaim (inline #.(lispify "btRigidBody_m_frictionSolverType_set" 'function)))

(cffi:defcfun ("_wrap_btRigidBody_m_frictionSolverType_set" #.(lispify "btRigidBody_m_frictionSolverType_set" 'function)) :void
  (self :pointer)
  (m_frictionSolverType :int))

(export '#.(lispify "btRigidBody_m_frictionSolverType_set" 'function))

(declaim (inline #.(lispify "btRigidBody_m_frictionSolverType_get" 'function)))

(cffi:defcfun ("_wrap_btRigidBody_m_frictionSolverType_get" #.(lispify "btRigidBody_m_frictionSolverType_get" 'function)) :int
  (self :pointer))

(export '#.(lispify "btRigidBody_m_frictionSolverType_get" 'function))

(declaim (inline #.(lispify "btRigidBody_setAngularFactor" 'function)))

(cffi:defcfun ("_wrap_btRigidBody_setAngularFactor__SWIG_0" #.(lispify "btRigidBody_setAngularFactor" 'function)) :void
  (self :pointer)
  (angFac :pointer))

(export '#.(lispify "btRigidBody_setAngularFactor" 'function))

(declaim (inline #.(lispify "btRigidBody_setAngularFactor" 'function)))

(cffi:defcfun ("_wrap_btRigidBody_setAngularFactor__SWIG_1" #.(lispify "btRigidBody_setAngularFactor" 'function)) :void
  (self :pointer)
  (angFac :float))

(export '#.(lispify "btRigidBody_setAngularFactor" 'function))

(declaim (inline #.(lispify "btRigidBody_getAngularFactor" 'function)))

(cffi:defcfun ("_wrap_btRigidBody_getAngularFactor" #.(lispify "btRigidBody_getAngularFactor" 'function)) :pointer
  (self :pointer))

(export '#.(lispify "btRigidBody_getAngularFactor" 'function))

(declaim (inline #.(lispify "btRigidBody_isInWorld" 'function)))

(cffi:defcfun ("_wrap_btRigidBody_isInWorld" #.(lispify "btRigidBody_isInWorld" 'function)) :pointer
  (self :pointer))

(export '#.(lispify "btRigidBody_isInWorld" 'function))

(declaim (inline #.(lispify "btRigidBody_checkCollideWithOverride" 'function)))

(cffi:defcfun ("_wrap_btRigidBody_checkCollideWithOverride" #.(lispify "btRigidBody_checkCollideWithOverride" 'function)) :pointer
  (self :pointer)
  (co :pointer))

(export '#.(lispify "btRigidBody_checkCollideWithOverride" 'function))

(declaim (inline #.(lispify "btRigidBody_addConstraintRef" 'function)))

(cffi:defcfun ("_wrap_btRigidBody_addConstraintRef" #.(lispify "btRigidBody_addConstraintRef" 'function)) :void
  (self :pointer)
  (c :pointer))

(export '#.(lispify "btRigidBody_addConstraintRef" 'function))

(declaim (inline #.(lispify "btRigidBody_removeConstraintRef" 'function)))

(cffi:defcfun ("_wrap_btRigidBody_removeConstraintRef" #.(lispify "btRigidBody_removeConstraintRef" 'function)) :void
  (self :pointer)
  (c :pointer))

(export '#.(lispify "btRigidBody_removeConstraintRef" 'function))

(declaim (inline #.(lispify "btRigidBody_getConstraintRef" 'function)))

(cffi:defcfun ("_wrap_btRigidBody_getConstraintRef" #.(lispify "btRigidBody_getConstraintRef" 'function)) :pointer
  (self :pointer)
  (index :int))

(export '#.(lispify "btRigidBody_getConstraintRef" 'function))

(declaim (inline #.(lispify "btRigidBody_getNumConstraintRefs" 'function)))

(cffi:defcfun ("_wrap_btRigidBody_getNumConstraintRefs" #.(lispify "btRigidBody_getNumConstraintRefs" 'function)) :int
  (self :pointer))

(export '#.(lispify "btRigidBody_getNumConstraintRefs" 'function))

(declaim (inline #.(lispify "btRigidBody_setFlags" 'function)))

(cffi:defcfun ("_wrap_btRigidBody_setFlags" #.(lispify "btRigidBody_setFlags" 'function)) :void
  (self :pointer)
  (flags :int))

(export '#.(lispify "btRigidBody_setFlags" 'function))

(declaim (inline #.(lispify "btRigidBody_getFlags" 'function)))

(cffi:defcfun ("_wrap_btRigidBody_getFlags" #.(lispify "btRigidBody_getFlags" 'function)) :int
  (self :pointer))

(export '#.(lispify "btRigidBody_getFlags" 'function))

(declaim (inline #.(lispify "btRigidBody_computeGyroscopicForce" 'function)))

(cffi:defcfun ("_wrap_btRigidBody_computeGyroscopicForce" #.(lispify "btRigidBody_computeGyroscopicForce" 'function)) :pointer
  (self :pointer)
  (maxGyroscopicForce :float))

(export '#.(lispify "btRigidBody_computeGyroscopicForce" 'function))

(declaim (inline #.(lispify "btRigidBody_calculateSerializeBufferSize" 'function)))

(cffi:defcfun ("_wrap_btRigidBody_calculateSerializeBufferSize" #.(lispify "btRigidBody_calculateSerializeBufferSize" 'function)) :int
  (self :pointer))

(export '#.(lispify "btRigidBody_calculateSerializeBufferSize" 'function))

(declaim (inline #.(lispify "btRigidBody_serialize" 'function)))

(cffi:defcfun ("_wrap_btRigidBody_serialize" #.(lispify "btRigidBody_serialize" 'function)) :string
  (self :pointer)
  (dataBuffer :pointer)
  (serializer :pointer))

(export '#.(lispify "btRigidBody_serialize" 'function))

(declaim (inline #.(lispify "btRigidBody_serializeSingleObject" 'function)))

(cffi:defcfun ("_wrap_btRigidBody_serializeSingleObject" #.(lispify "btRigidBody_serializeSingleObject" 'function)) :void
  (self :pointer)
  (serializer :pointer))

(export '#.(lispify "btRigidBody_serializeSingleObject" 'function))

(cffi:defcstruct #.(lispify "btRigidBodyFloatData" 'classname)
	(#.(lispify "m_collisionObjectData" 'slotname) #.(lispify "btCollisionObjectFloatData" 'classname))
	(#.(lispify "m_invInertiaTensorWorld" 'slotname) matrix-3x3-float-data)
	(#.(lispify "m_linearVelocity" 'slotname) #.(lispify "btVector3FloatData" 'classname))
	(#.(lispify "m_angularVelocity" 'slotname) #.(lispify "btVector3FloatData" 'classname))
	(#.(lispify "m_angularFactor" 'slotname) #.(lispify "btVector3FloatData" 'classname))
	(#.(lispify "m_linearFactor" 'slotname) #.(lispify "btVector3FloatData" 'classname))
	(#.(lispify "m_gravity" 'slotname) #.(lispify "btVector3FloatData" 'classname))
	(#.(lispify "m_gravity_acceleration" 'slotname) #.(lispify "btVector3FloatData" 'classname))
	(#.(lispify "m_invInertiaLocal" 'slotname) #.(lispify "btVector3FloatData" 'classname))
	(#.(lispify "m_totalForce" 'slotname) #.(lispify "btVector3FloatData" 'classname))
	(#.(lispify "m_totalTorque" 'slotname) #.(lispify "btVector3FloatData" 'classname))
	(#.(lispify "m_inverseMass" 'slotname) :float)
	(#.(lispify "m_linearDamping" 'slotname) :float)
	(#.(lispify "m_angularDamping" 'slotname) :float)
	(#.(lispify "m_additionalDampingFactor" 'slotname) :float)
	(#.(lispify "m_additionalLinearDampingThresholdSqr" 'slotname) :float)
	(#.(lispify "m_additionalAngularDampingThresholdSqr" 'slotname) :float)
	(#.(lispify "m_additionalAngularDampingFactor" 'slotname) :float)
	(#.(lispify "m_linearSleepingThreshold" 'slotname) :float)
	(#.(lispify "m_angularSleepingThreshold" 'slotname) :float)
	(#.(lispify "m_additionalDamping" 'slotname) :int))

(export '#.(lispify "btRigidBodyFloatData" 'classname))

(export '#.(lispify "m_collisionObjectData" 'slotname))

(export '#.(lispify "m_invInertiaTensorWorld" 'slotname))

(export '#.(lispify "m_linearVelocity" 'slotname))

(export '#.(lispify "m_angularVelocity" 'slotname))

(export '#.(lispify "m_angularFactor" 'slotname))

(export '#.(lispify "m_linearFactor" 'slotname))

(export '#.(lispify "m_gravity" 'slotname))

(export '#.(lispify "m_gravity_acceleration" 'slotname))

(export '#.(lispify "m_invInertiaLocal" 'slotname))

(export '#.(lispify "m_totalForce" 'slotname))

(export '#.(lispify "m_totalTorque" 'slotname))

(export '#.(lispify "m_inverseMass" 'slotname))

(export '#.(lispify "m_linearDamping" 'slotname))

(export '#.(lispify "m_angularDamping" 'slotname))

(export '#.(lispify "m_additionalDampingFactor" 'slotname))

(export '#.(lispify "m_additionalLinearDampingThresholdSqr" 'slotname))

(export '#.(lispify "m_additionalAngularDampingThresholdSqr" 'slotname))

(export '#.(lispify "m_additionalAngularDampingFactor" 'slotname))

(export '#.(lispify "m_linearSleepingThreshold" 'slotname))

(export '#.(lispify "m_angularSleepingThreshold" 'slotname))

(export '#.(lispify "m_additionalDamping" 'slotname))

(cffi:defcstruct #.(lispify "btRigidBodyDoubleData" 'classname)
	(#.(lispify "m_collisionObjectData" 'slotname) #.(lispify "btCollisionObjectDoubleData" 'classname))
	(#.(lispify "m_invInertiaTensorWorld" 'slotname) #.(lispify "btMatrix3x3DoubleData" 'classname))
	(#.(lispify "m_linearVelocity" 'slotname) #.(lispify "btVector3DoubleData" 'classname))
	(#.(lispify "m_angularVelocity" 'slotname) #.(lispify "btVector3DoubleData" 'classname))
	(#.(lispify "m_angularFactor" 'slotname) #.(lispify "btVector3DoubleData" 'classname))
	(#.(lispify "m_linearFactor" 'slotname) #.(lispify "btVector3DoubleData" 'classname))
	(#.(lispify "m_gravity" 'slotname) #.(lispify "btVector3DoubleData" 'classname))
	(#.(lispify "m_gravity_acceleration" 'slotname) #.(lispify "btVector3DoubleData" 'classname))
	(#.(lispify "m_invInertiaLocal" 'slotname) #.(lispify "btVector3DoubleData" 'classname))
	(#.(lispify "m_totalForce" 'slotname) #.(lispify "btVector3DoubleData" 'classname))
	(#.(lispify "m_totalTorque" 'slotname) #.(lispify "btVector3DoubleData" 'classname))
	(#.(lispify "m_inverseMass" 'slotname) :double)
	(#.(lispify "m_linearDamping" 'slotname) :double)
	(#.(lispify "m_angularDamping" 'slotname) :double)
	(#.(lispify "m_additionalDampingFactor" 'slotname) :double)
	(#.(lispify "m_additionalLinearDampingThresholdSqr" 'slotname) :double)
	(#.(lispify "m_additionalAngularDampingThresholdSqr" 'slotname) :double)
	(#.(lispify "m_additionalAngularDampingFactor" 'slotname) :double)
	(#.(lispify "m_linearSleepingThreshold" 'slotname) :double)
	(#.(lispify "m_angularSleepingThreshold" 'slotname) :double)
	(#.(lispify "m_additionalDamping" 'slotname) :int)
	(#.(lispify "m_padding" 'slotname) :pointer))

(export '#.(lispify "btRigidBodyDoubleData" 'classname))

(export '#.(lispify "m_collisionObjectData" 'slotname))

(export '#.(lispify "m_invInertiaTensorWorld" 'slotname))

(export '#.(lispify "m_linearVelocity" 'slotname))

(export '#.(lispify "m_angularVelocity" 'slotname))

(export '#.(lispify "m_angularFactor" 'slotname))

(export '#.(lispify "m_linearFactor" 'slotname))

(export '#.(lispify "m_gravity" 'slotname))

(export '#.(lispify "m_gravity_acceleration" 'slotname))

(export '#.(lispify "m_invInertiaLocal" 'slotname))

(export '#.(lispify "m_totalForce" 'slotname))

(export '#.(lispify "m_totalTorque" 'slotname))

(export '#.(lispify "m_inverseMass" 'slotname))

(export '#.(lispify "m_linearDamping" 'slotname))

(export '#.(lispify "m_angularDamping" 'slotname))

(export '#.(lispify "m_additionalDampingFactor" 'slotname))

(export '#.(lispify "m_additionalLinearDampingThresholdSqr" 'slotname))

(export '#.(lispify "m_additionalAngularDampingThresholdSqr" 'slotname))

(export '#.(lispify "m_additionalAngularDampingFactor" 'slotname))

(export '#.(lispify "m_linearSleepingThreshold" 'slotname))

(export '#.(lispify "m_angularSleepingThreshold" 'slotname))

(export '#.(lispify "m_additionalDamping" 'slotname))

(export '#.(lispify "m_padding" 'slotname))

(define-constant #.(lispify "btTypedConstraintDataName" 'constant) "btTypedConstraintFloatData" :test 'equal)

(export '#.(lispify "btTypedConstraintDataName" 'constant))

(cffi:defcenum #.(lispify "btTypedConstraintType" 'enumname)
	(#.(lispify "POINT2POINT_CONSTRAINT_TYPE" 'enumvalue :keyword) #.3)
	#.(lispify "HINGE_CONSTRAINT_TYPE" 'enumvalue :keyword)
	#.(lispify "CONETWIST_CONSTRAINT_TYPE" 'enumvalue :keyword)
	#.(lispify "D6_CONSTRAINT_TYPE" 'enumvalue :keyword)
	#.(lispify "SLIDER_CONSTRAINT_TYPE" 'enumvalue :keyword)
	#.(lispify "CONTACT_CONSTRAINT_TYPE" 'enumvalue :keyword)
	#.(lispify "D6_SPRING_CONSTRAINT_TYPE" 'enumvalue :keyword)
	#.(lispify "GEAR_CONSTRAINT_TYPE" 'enumvalue :keyword)
	#.(lispify "FIXED_CONSTRAINT_TYPE" 'enumvalue :keyword)
	#.(lispify "MAX_CONSTRAINT_TYPE" 'enumvalue :keyword))

(export '#.(lispify "btTypedConstraintType" 'enumname))

(cffi:defcenum #.(lispify "btConstraintParams" 'enumname)
	(#.(lispify "BT_CONSTRAINT_ERP" 'enumvalue :keyword) #.1)
	#.(lispify "BT_CONSTRAINT_STOP_ERP" 'enumvalue :keyword)
	#.(lispify "BT_CONSTRAINT_CFM" 'enumvalue :keyword)
	#.(lispify "BT_CONSTRAINT_STOP_CFM" 'enumvalue :keyword))

(export '#.(lispify "btConstraintParams" 'enumname))

(cffi:defcstruct #.(lispify "btJointFeedback" 'classname)
	(#.(lispify "m_appliedForceBodyA" 'slotname) :pointer)
	(#.(lispify "m_appliedTorqueBodyA" 'slotname) :pointer)
	(#.(lispify "m_appliedForceBodyB" 'slotname) :pointer)
	(#.(lispify "m_appliedTorqueBodyB" 'slotname) :pointer))

(export '#.(lispify "btJointFeedback" 'classname))

(export '#.(lispify "m_appliedForceBodyA" 'slotname))

(export '#.(lispify "m_appliedTorqueBodyA" 'slotname))

(export '#.(lispify "m_appliedForceBodyB" 'slotname))

(export '#.(lispify "m_appliedTorqueBodyB" 'slotname))

(declaim (inline #.(lispify "btTypedConstraint_makeCPlusPlusInstance" 'function)))

(cffi:defcfun ("_wrap_btTypedConstraint_makeCPlusPlusInstance__SWIG_0" #.(lispify "btTypedConstraint_makeCPlusPlusInstance" 'function)) :pointer
  (self :pointer)
  (sizeInBytes :pointer))

(export '#.(lispify "btTypedConstraint_makeCPlusPlusInstance" 'function))

(declaim (inline #.(lispify "btTypedConstraint_deleteCPlusPlusInstance" 'function)))

(cffi:defcfun ("_wrap_btTypedConstraint_deleteCPlusPlusInstance__SWIG_0" #.(lispify "btTypedConstraint_deleteCPlusPlusInstance" 'function)) :void
  (self :pointer)
  (ptr :pointer))

(export '#.(lispify "btTypedConstraint_deleteCPlusPlusInstance" 'function))

(declaim (inline #.(lispify "btTypedConstraint_makeCPlusPlusInstance" 'function)))

(cffi:defcfun ("_wrap_btTypedConstraint_makeCPlusPlusInstance__SWIG_1" #.(lispify "btTypedConstraint_makeCPlusPlusInstance" 'function)) :pointer
  (self :pointer)
  (arg1 :pointer)
  (ptr :pointer))

(export '#.(lispify "btTypedConstraint_makeCPlusPlusInstance" 'function))

(declaim (inline #.(lispify "btTypedConstraint_deleteCPlusPlusInstance" 'function)))

(cffi:defcfun ("_wrap_btTypedConstraint_deleteCPlusPlusInstance__SWIG_1" #.(lispify "btTypedConstraint_deleteCPlusPlusInstance" 'function)) :void
  (self :pointer)
  (arg1 :pointer)
  (arg2 :pointer))

(export '#.(lispify "btTypedConstraint_deleteCPlusPlusInstance" 'function))

(declaim (inline #.(lispify "btTypedConstraint_makeCPlusArray" 'function)))

(cffi:defcfun ("_wrap_btTypedConstraint_makeCPlusArray__SWIG_0" #.(lispify "btTypedConstraint_makeCPlusArray" 'function)) :pointer
  (self :pointer)
  (sizeInBytes :pointer))

(export '#.(lispify "btTypedConstraint_makeCPlusArray" 'function))

(declaim (inline #.(lispify "btTypedConstraint_deleteCPlusArray" 'function)))

(cffi:defcfun ("_wrap_btTypedConstraint_deleteCPlusArray__SWIG_0" #.(lispify "btTypedConstraint_deleteCPlusArray" 'function)) :void
  (self :pointer)
  (ptr :pointer))

(export '#.(lispify "btTypedConstraint_deleteCPlusArray" 'function))

(declaim (inline #.(lispify "btTypedConstraint_makeCPlusArray" 'function)))

(cffi:defcfun ("_wrap_btTypedConstraint_makeCPlusArray__SWIG_1" #.(lispify "btTypedConstraint_makeCPlusArray" 'function)) :pointer
  (self :pointer)
  (arg1 :pointer)
  (ptr :pointer))

(export '#.(lispify "btTypedConstraint_makeCPlusArray" 'function))

(declaim (inline #.(lispify "btTypedConstraint_deleteCPlusArray" 'function)))

(cffi:defcfun ("_wrap_btTypedConstraint_deleteCPlusArray__SWIG_1" #.(lispify "btTypedConstraint_deleteCPlusArray" 'function)) :void
  (self :pointer)
  (arg1 :pointer)
  (arg2 :pointer))

(export '#.(lispify "btTypedConstraint_deleteCPlusArray" 'function))

(declaim (inline #.(lispify "delete_btTypedConstraint" 'function)))

(cffi:defcfun ("_wrap_delete_btTypedConstraint" #.(lispify "delete_btTypedConstraint" 'function)) :void
  (self :pointer))

(export '#.(lispify "delete_btTypedConstraint" 'function))

(declaim (inline #.(lispify "btTypedConstraint_getFixedBody" 'function)))

(cffi:defcfun ("_wrap_btTypedConstraint_getFixedBody" #.(lispify "btTypedConstraint_getFixedBody" 'function)) :pointer)

(export '#.(lispify "btTypedConstraint_getFixedBody" 'function))

(declaim (inline #.(lispify "btTypedConstraint_getOverrideNumSolverIterations" 'function)))

(cffi:defcfun ("_wrap_btTypedConstraint_getOverrideNumSolverIterations" #.(lispify "btTypedConstraint_getOverrideNumSolverIterations" 'function)) :int
  (self :pointer))

(export '#.(lispify "btTypedConstraint_getOverrideNumSolverIterations" 'function))

(declaim (inline #.(lispify "btTypedConstraint_setOverrideNumSolverIterations" 'function)))

(cffi:defcfun ("_wrap_btTypedConstraint_setOverrideNumSolverIterations" #.(lispify "btTypedConstraint_setOverrideNumSolverIterations" 'function)) :void
  (self :pointer)
  (overideNumIterations :int))

(export '#.(lispify "btTypedConstraint_setOverrideNumSolverIterations" 'function))

(declaim (inline #.(lispify "btTypedConstraint_buildJacobian" 'function)))

(cffi:defcfun ("_wrap_btTypedConstraint_buildJacobian" #.(lispify "btTypedConstraint_buildJacobian" 'function)) :void
  (self :pointer))

(export '#.(lispify "btTypedConstraint_buildJacobian" 'function))

(declaim (inline #.(lispify "btTypedConstraint_setupSolverConstraint" 'function)))

(cffi:defcfun ("_wrap_btTypedConstraint_setupSolverConstraint" #.(lispify "btTypedConstraint_setupSolverConstraint" 'function)) :void
  (self :pointer)
  (ca :pointer)
  (solverBodyA :int)
  (solverBodyB :int)
  (timeStep :float))

(export '#.(lispify "btTypedConstraint_setupSolverConstraint" 'function))

(declaim (inline #.(lispify "btTypedConstraint_getInfo1" 'function)))

(cffi:defcfun ("_wrap_btTypedConstraint_getInfo1" #.(lispify "btTypedConstraint_getInfo1" 'function)) :void
  (self :pointer)
  (info :pointer))

(export '#.(lispify "btTypedConstraint_getInfo1" 'function))

(declaim (inline #.(lispify "btTypedConstraint_getInfo2" 'function)))

(cffi:defcfun ("_wrap_btTypedConstraint_getInfo2" #.(lispify "btTypedConstraint_getInfo2" 'function)) :void
  (self :pointer)
  (info :pointer))

(export '#.(lispify "btTypedConstraint_getInfo2" 'function))

(declaim (inline #.(lispify "btTypedConstraint_internalSetAppliedImpulse" 'function)))

(cffi:defcfun ("_wrap_btTypedConstraint_internalSetAppliedImpulse" #.(lispify "btTypedConstraint_internalSetAppliedImpulse" 'function)) :void
  (self :pointer)
  (appliedImpulse :float))

(export '#.(lispify "btTypedConstraint_internalSetAppliedImpulse" 'function))

(declaim (inline #.(lispify "btTypedConstraint_internalGetAppliedImpulse" 'function)))

(cffi:defcfun ("_wrap_btTypedConstraint_internalGetAppliedImpulse" #.(lispify "btTypedConstraint_internalGetAppliedImpulse" 'function)) :float
  (self :pointer))

(export '#.(lispify "btTypedConstraint_internalGetAppliedImpulse" 'function))

(declaim (inline #.(lispify "btTypedConstraint_getBreakingImpulseThreshold" 'function)))

(cffi:defcfun ("_wrap_btTypedConstraint_getBreakingImpulseThreshold" #.(lispify "btTypedConstraint_getBreakingImpulseThreshold" 'function)) :float
  (self :pointer))

(export '#.(lispify "btTypedConstraint_getBreakingImpulseThreshold" 'function))

(declaim (inline #.(lispify "btTypedConstraint_setBreakingImpulseThreshold" 'function)))

(cffi:defcfun ("_wrap_btTypedConstraint_setBreakingImpulseThreshold" #.(lispify "btTypedConstraint_setBreakingImpulseThreshold" 'function)) :void
  (self :pointer)
  (threshold :float))

(export '#.(lispify "btTypedConstraint_setBreakingImpulseThreshold" 'function))

(declaim (inline #.(lispify "btTypedConstraint_isEnabled" 'function)))

(cffi:defcfun ("_wrap_btTypedConstraint_isEnabled" #.(lispify "btTypedConstraint_isEnabled" 'function)) :pointer
  (self :pointer))

(export '#.(lispify "btTypedConstraint_isEnabled" 'function))

(declaim (inline #.(lispify "btTypedConstraint_setEnabled" 'function)))

(cffi:defcfun ("_wrap_btTypedConstraint_setEnabled" #.(lispify "btTypedConstraint_setEnabled" 'function)) :void
  (self :pointer)
  (enabled :pointer))

(export '#.(lispify "btTypedConstraint_setEnabled" 'function))

(declaim (inline #.(lispify "btTypedConstraint_solveConstraintObsolete" 'function)))

(cffi:defcfun ("_wrap_btTypedConstraint_solveConstraintObsolete" #.(lispify "btTypedConstraint_solveConstraintObsolete" 'function)) :void
  (self :pointer)
  (arg1 :pointer)
  (arg2 :pointer)
  (arg3 :float))

(export '#.(lispify "btTypedConstraint_solveConstraintObsolete" 'function))

(declaim (inline #.(lispify "btTypedConstraint_getRigidBodyA" 'function)))

(cffi:defcfun ("_wrap_btTypedConstraint_getRigidBodyA__SWIG_0" #.(lispify "btTypedConstraint_getRigidBodyA" 'function)) :pointer
  (self :pointer))

(export '#.(lispify "btTypedConstraint_getRigidBodyA" 'function))

(declaim (inline #.(lispify "btTypedConstraint_getRigidBodyB" 'function)))

(cffi:defcfun ("_wrap_btTypedConstraint_getRigidBodyB__SWIG_0" #.(lispify "btTypedConstraint_getRigidBodyB" 'function)) :pointer
  (self :pointer))

(export '#.(lispify "btTypedConstraint_getRigidBodyB" 'function))

(declaim (inline #.(lispify "btTypedConstraint_getRigidBodyA" 'function)))

(cffi:defcfun ("_wrap_btTypedConstraint_getRigidBodyA__SWIG_1" #.(lispify "btTypedConstraint_getRigidBodyA" 'function)) :pointer
  (self :pointer))

(export '#.(lispify "btTypedConstraint_getRigidBodyA" 'function))

(declaim (inline #.(lispify "btTypedConstraint_getRigidBodyB" 'function)))

(cffi:defcfun ("_wrap_btTypedConstraint_getRigidBodyB__SWIG_1" #.(lispify "btTypedConstraint_getRigidBodyB" 'function)) :pointer
  (self :pointer))

(export '#.(lispify "btTypedConstraint_getRigidBodyB" 'function))

(declaim (inline #.(lispify "btTypedConstraint_getUserConstraintType" 'function)))

(cffi:defcfun ("_wrap_btTypedConstraint_getUserConstraintType" #.(lispify "btTypedConstraint_getUserConstraintType" 'function)) :int
  (self :pointer))

(export '#.(lispify "btTypedConstraint_getUserConstraintType" 'function))

(declaim (inline #.(lispify "btTypedConstraint_setUserConstraintType" 'function)))

(cffi:defcfun ("_wrap_btTypedConstraint_setUserConstraintType" #.(lispify "btTypedConstraint_setUserConstraintType" 'function)) :void
  (self :pointer)
  (userConstraintType :int))

(export '#.(lispify "btTypedConstraint_setUserConstraintType" 'function))

(declaim (inline #.(lispify "btTypedConstraint_setUserConstraintId" 'function)))

(cffi:defcfun ("_wrap_btTypedConstraint_setUserConstraintId" #.(lispify "btTypedConstraint_setUserConstraintId" 'function)) :void
  (self :pointer)
  (uid :int))

(export '#.(lispify "btTypedConstraint_setUserConstraintId" 'function))

(declaim (inline #.(lispify "btTypedConstraint_getUserConstraintId" 'function)))

(cffi:defcfun ("_wrap_btTypedConstraint_getUserConstraintId" #.(lispify "btTypedConstraint_getUserConstraintId" 'function)) :int
  (self :pointer))

(export '#.(lispify "btTypedConstraint_getUserConstraintId" 'function))

(declaim (inline #.(lispify "btTypedConstraint_setUserConstraintPtr" 'function)))

(cffi:defcfun ("_wrap_btTypedConstraint_setUserConstraintPtr" #.(lispify "btTypedConstraint_setUserConstraintPtr" 'function)) :void
  (self :pointer)
  (ptr :pointer))

(export '#.(lispify "btTypedConstraint_setUserConstraintPtr" 'function))

(declaim (inline #.(lispify "btTypedConstraint_getUserConstraintPtr" 'function)))

(cffi:defcfun ("_wrap_btTypedConstraint_getUserConstraintPtr" #.(lispify "btTypedConstraint_getUserConstraintPtr" 'function)) :pointer
  (self :pointer))

(export '#.(lispify "btTypedConstraint_getUserConstraintPtr" 'function))

(declaim (inline #.(lispify "btTypedConstraint_setJointFeedback" 'function)))

(cffi:defcfun ("_wrap_btTypedConstraint_setJointFeedback" #.(lispify "btTypedConstraint_setJointFeedback" 'function)) :void
  (self :pointer)
  (jointFeedback :pointer))

(export '#.(lispify "btTypedConstraint_setJointFeedback" 'function))

(declaim (inline #.(lispify "btTypedConstraint_getJointFeedback" 'function)))

(cffi:defcfun ("_wrap_btTypedConstraint_getJointFeedback__SWIG_0" #.(lispify "btTypedConstraint_getJointFeedback" 'function)) :pointer
  (self :pointer))

(export '#.(lispify "btTypedConstraint_getJointFeedback" 'function))

(declaim (inline #.(lispify "btTypedConstraint_getJointFeedback" 'function)))

(cffi:defcfun ("_wrap_btTypedConstraint_getJointFeedback__SWIG_1" #.(lispify "btTypedConstraint_getJointFeedback" 'function)) :pointer
  (self :pointer))

(export '#.(lispify "btTypedConstraint_getJointFeedback" 'function))

(declaim (inline #.(lispify "btTypedConstraint_getUid" 'function)))

(cffi:defcfun ("_wrap_btTypedConstraint_getUid" #.(lispify "btTypedConstraint_getUid" 'function)) :int
  (self :pointer))

(export '#.(lispify "btTypedConstraint_getUid" 'function))

(declaim (inline #.(lispify "btTypedConstraint_needsFeedback" 'function)))

(cffi:defcfun ("_wrap_btTypedConstraint_needsFeedback" #.(lispify "btTypedConstraint_needsFeedback" 'function)) :pointer
  (self :pointer))

(export '#.(lispify "btTypedConstraint_needsFeedback" 'function))

(declaim (inline #.(lispify "btTypedConstraint_enableFeedback" 'function)))

(cffi:defcfun ("_wrap_btTypedConstraint_enableFeedback" #.(lispify "btTypedConstraint_enableFeedback" 'function)) :void
  (self :pointer)
  (needsFeedback :pointer))

(export '#.(lispify "btTypedConstraint_enableFeedback" 'function))

(declaim (inline #.(lispify "btTypedConstraint_getAppliedImpulse" 'function)))

(cffi:defcfun ("_wrap_btTypedConstraint_getAppliedImpulse" #.(lispify "btTypedConstraint_getAppliedImpulse" 'function)) :float
  (self :pointer))

(export '#.(lispify "btTypedConstraint_getAppliedImpulse" 'function))

(declaim (inline #.(lispify "btTypedConstraint_getConstraintType" 'function)))

(cffi:defcfun ("_wrap_btTypedConstraint_getConstraintType" #.(lispify "btTypedConstraint_getConstraintType" 'function)) #.(lispify "btTypedConstraintType" 'enumname)
  (self :pointer))

(export '#.(lispify "btTypedConstraint_getConstraintType" 'function))

(declaim (inline #.(lispify "btTypedConstraint_setDbgDrawSize" 'function)))

(cffi:defcfun ("_wrap_btTypedConstraint_setDbgDrawSize" #.(lispify "btTypedConstraint_setDbgDrawSize" 'function)) :void
  (self :pointer)
  (dbgDrawSize :float))

(export '#.(lispify "btTypedConstraint_setDbgDrawSize" 'function))

(declaim (inline #.(lispify "btTypedConstraint_getDbgDrawSize" 'function)))

(cffi:defcfun ("_wrap_btTypedConstraint_getDbgDrawSize" #.(lispify "btTypedConstraint_getDbgDrawSize" 'function)) :float
  (self :pointer))

(export '#.(lispify "btTypedConstraint_getDbgDrawSize" 'function))

(declaim (inline #.(lispify "btTypedConstraint_calculateSerializeBufferSize" 'function)))

(cffi:defcfun ("_wrap_btTypedConstraint_calculateSerializeBufferSize" #.(lispify "btTypedConstraint_calculateSerializeBufferSize" 'function)) :int
  (self :pointer))

(export '#.(lispify "btTypedConstraint_calculateSerializeBufferSize" 'function))

(declaim (inline #.(lispify "btTypedConstraint_serialize" 'function)))

(cffi:defcfun ("_wrap_btTypedConstraint_serialize" #.(lispify "btTypedConstraint_serialize" 'function)) :string
  (self :pointer)
  (dataBuffer :pointer)
  (serializer :pointer))

(export '#.(lispify "btTypedConstraint_serialize" 'function))

(declaim (inline #.(lispify "btAdjustAngleToLimits" 'function)))

(cffi:defcfun ("_wrap_btAdjustAngleToLimits" #.(lispify "btAdjustAngleToLimits" 'function)) :float
  (angleInRadians :float)
  (angleLowerLimitInRadians :float)
  (angleUpperLimitInRadians :float))

(export '#.(lispify "btAdjustAngleToLimits" 'function))

(cffi:defcstruct #.(lispify "btTypedConstraintFloatData" 'classname)
	(#.(lispify "m_rbA" 'slotname) :pointer)
	(#.(lispify "m_rbB" 'slotname) :pointer)
	(#.(lispify "m_name" 'slotname) :string)
	(#.(lispify "m_objectType" 'slotname) :int)
	(#.(lispify "m_userConstraintType" 'slotname) :int)
	(#.(lispify "m_userConstraintId" 'slotname) :int)
	(#.(lispify "m_needsFeedback" 'slotname) :int)
	(#.(lispify "m_appliedImpulse" 'slotname) :float)
	(#.(lispify "m_dbgDrawSize" 'slotname) :float)
	(#.(lispify "m_disableCollisionsBetweenLinkedBodies" 'slotname) :int)
	(#.(lispify "m_overrideNumSolverIterations" 'slotname) :int)
	(#.(lispify "m_breakingImpulseThreshold" 'slotname) :float)
	(#.(lispify "m_isEnabled" 'slotname) :int))

(export '#.(lispify "btTypedConstraintFloatData" 'classname))

(export '#.(lispify "m_rbA" 'slotname))

(export '#.(lispify "m_rbB" 'slotname))

(export '#.(lispify "m_name" 'slotname))

(export '#.(lispify "m_objectType" 'slotname))

(export '#.(lispify "m_userConstraintType" 'slotname))

(export '#.(lispify "m_userConstraintId" 'slotname))

(export '#.(lispify "m_needsFeedback" 'slotname))

(export '#.(lispify "m_appliedImpulse" 'slotname))

(export '#.(lispify "m_dbgDrawSize" 'slotname))

(export '#.(lispify "m_disableCollisionsBetweenLinkedBodies" 'slotname))

(export '#.(lispify "m_overrideNumSolverIterations" 'slotname))

(export '#.(lispify "m_breakingImpulseThreshold" 'slotname))

(export '#.(lispify "m_isEnabled" 'slotname))

(cffi:defcstruct #.(lispify "btTypedConstraintData" 'classname)
	(#.(lispify "m_rbA" 'slotname) :pointer)
	(#.(lispify "m_rbB" 'slotname) :pointer)
	(#.(lispify "m_name" 'slotname) :string)
	(#.(lispify "m_objectType" 'slotname) :int)
	(#.(lispify "m_userConstraintType" 'slotname) :int)
	(#.(lispify "m_userConstraintId" 'slotname) :int)
	(#.(lispify "m_needsFeedback" 'slotname) :int)
	(#.(lispify "m_appliedImpulse" 'slotname) :float)
	(#.(lispify "m_dbgDrawSize" 'slotname) :float)
	(#.(lispify "m_disableCollisionsBetweenLinkedBodies" 'slotname) :int)
	(#.(lispify "m_overrideNumSolverIterations" 'slotname) :int)
	(#.(lispify "m_breakingImpulseThreshold" 'slotname) :float)
	(#.(lispify "m_isEnabled" 'slotname) :int))

(export '#.(lispify "btTypedConstraintData" 'classname))

(export '#.(lispify "m_rbA" 'slotname))

(export '#.(lispify "m_rbB" 'slotname))

(export '#.(lispify "m_name" 'slotname))

(export '#.(lispify "m_objectType" 'slotname))

(export '#.(lispify "m_userConstraintType" 'slotname))

(export '#.(lispify "m_userConstraintId" 'slotname))

(export '#.(lispify "m_needsFeedback" 'slotname))

(export '#.(lispify "m_appliedImpulse" 'slotname))

(export '#.(lispify "m_dbgDrawSize" 'slotname))

(export '#.(lispify "m_disableCollisionsBetweenLinkedBodies" 'slotname))

(export '#.(lispify "m_overrideNumSolverIterations" 'slotname))

(export '#.(lispify "m_breakingImpulseThreshold" 'slotname))

(export '#.(lispify "m_isEnabled" 'slotname))

(cffi:defcstruct #.(lispify "btTypedConstraintDoubleData" 'classname)
	(#.(lispify "m_rbA" 'slotname) :pointer)
	(#.(lispify "m_rbB" 'slotname) :pointer)
	(#.(lispify "m_name" 'slotname) :string)
	(#.(lispify "m_objectType" 'slotname) :int)
	(#.(lispify "m_userConstraintType" 'slotname) :int)
	(#.(lispify "m_userConstraintId" 'slotname) :int)
	(#.(lispify "m_needsFeedback" 'slotname) :int)
	(#.(lispify "m_appliedImpulse" 'slotname) :double)
	(#.(lispify "m_dbgDrawSize" 'slotname) :double)
	(#.(lispify "m_disableCollisionsBetweenLinkedBodies" 'slotname) :int)
	(#.(lispify "m_overrideNumSolverIterations" 'slotname) :int)
	(#.(lispify "m_breakingImpulseThreshold" 'slotname) :double)
	(#.(lispify "m_isEnabled" 'slotname) :int)
	(#.(lispify "padding" 'slotname) :pointer))

(export '#.(lispify "btTypedConstraintDoubleData" 'classname))

(export '#.(lispify "m_rbA" 'slotname))

(export '#.(lispify "m_rbB" 'slotname))

(export '#.(lispify "m_name" 'slotname))

(export '#.(lispify "m_objectType" 'slotname))

(export '#.(lispify "m_userConstraintType" 'slotname))

(export '#.(lispify "m_userConstraintId" 'slotname))

(export '#.(lispify "m_needsFeedback" 'slotname))

(export '#.(lispify "m_appliedImpulse" 'slotname))

(export '#.(lispify "m_dbgDrawSize" 'slotname))

(export '#.(lispify "m_disableCollisionsBetweenLinkedBodies" 'slotname))

(export '#.(lispify "m_overrideNumSolverIterations" 'slotname))

(export '#.(lispify "m_breakingImpulseThreshold" 'slotname))

(export '#.(lispify "m_isEnabled" 'slotname))

(export '#.(lispify "padding" 'slotname))

(declaim (inline #.(lispify "new_btAngularLimit" 'function)))

(cffi:defcfun ("_wrap_new_btAngularLimit" #.(lispify "new_btAngularLimit" 'function)) :pointer)

(export '#.(lispify "new_btAngularLimit" 'function))

(declaim (inline #.(lispify "btAngularLimit_set" 'function)))

(cffi:defcfun ("_wrap_btAngularLimit_set__SWIG_0" #.(lispify "btAngularLimit_set" 'function)) :void
  (self :pointer)
  (low :float)
  (high :float)
  (_softness :float)
  (_biasFactor :float)
  (_relaxationFactor :float))

(export '#.(lispify "btAngularLimit_set" 'function))

(declaim (inline #.(lispify "btAngularLimit_set" 'function)))

(cffi:defcfun ("_wrap_btAngularLimit_set__SWIG_1" #.(lispify "btAngularLimit_set" 'function)) :void
  (self :pointer)
  (low :float)
  (high :float)
  (_softness :float)
  (_biasFactor :float))

(export '#.(lispify "btAngularLimit_set" 'function))

(declaim (inline #.(lispify "btAngularLimit_set" 'function)))

(cffi:defcfun ("_wrap_btAngularLimit_set__SWIG_2" #.(lispify "btAngularLimit_set" 'function)) :void
  (self :pointer)
  (low :float)
  (high :float)
  (_softness :float))

(export '#.(lispify "btAngularLimit_set" 'function))

(declaim (inline #.(lispify "btAngularLimit_set" 'function)))

(cffi:defcfun ("_wrap_btAngularLimit_set__SWIG_3" #.(lispify "btAngularLimit_set" 'function)) :void
  (self :pointer)
  (low :float)
  (high :float))

(export '#.(lispify "btAngularLimit_set" 'function))

(declaim (inline #.(lispify "btAngularLimit_test" 'function)))

(cffi:defcfun ("_wrap_btAngularLimit_test" #.(lispify "btAngularLimit_test" 'function)) :void
  (self :pointer)
  (angle :float))

(export '#.(lispify "btAngularLimit_test" 'function))

(declaim (inline #.(lispify "btAngularLimit_getSoftness" 'function)))

(cffi:defcfun ("_wrap_btAngularLimit_getSoftness" #.(lispify "btAngularLimit_getSoftness" 'function)) :float
  (self :pointer))

(export '#.(lispify "btAngularLimit_getSoftness" 'function))

(declaim (inline #.(lispify "btAngularLimit_getBiasFactor" 'function)))

(cffi:defcfun ("_wrap_btAngularLimit_getBiasFactor" #.(lispify "btAngularLimit_getBiasFactor" 'function)) :float
  (self :pointer))

(export '#.(lispify "btAngularLimit_getBiasFactor" 'function))

(declaim (inline #.(lispify "btAngularLimit_getRelaxationFactor" 'function)))

(cffi:defcfun ("_wrap_btAngularLimit_getRelaxationFactor" #.(lispify "btAngularLimit_getRelaxationFactor" 'function)) :float
  (self :pointer))

(export '#.(lispify "btAngularLimit_getRelaxationFactor" 'function))

(declaim (inline #.(lispify "btAngularLimit_getCorrection" 'function)))

(cffi:defcfun ("_wrap_btAngularLimit_getCorrection" #.(lispify "btAngularLimit_getCorrection" 'function)) :float
  (self :pointer))

(export '#.(lispify "btAngularLimit_getCorrection" 'function))

(declaim (inline #.(lispify "btAngularLimit_getSign" 'function)))

(cffi:defcfun ("_wrap_btAngularLimit_getSign" #.(lispify "btAngularLimit_getSign" 'function)) :float
  (self :pointer))

(export '#.(lispify "btAngularLimit_getSign" 'function))

(declaim (inline #.(lispify "btAngularLimit_getHalfRange" 'function)))

(cffi:defcfun ("_wrap_btAngularLimit_getHalfRange" #.(lispify "btAngularLimit_getHalfRange" 'function)) :float
  (self :pointer))

(export '#.(lispify "btAngularLimit_getHalfRange" 'function))

(declaim (inline #.(lispify "btAngularLimit_isLimit" 'function)))

(cffi:defcfun ("_wrap_btAngularLimit_isLimit" #.(lispify "btAngularLimit_isLimit" 'function)) :pointer
  (self :pointer))

(export '#.(lispify "btAngularLimit_isLimit" 'function))

(declaim (inline #.(lispify "btAngularLimit_fit" 'function)))

(cffi:defcfun ("_wrap_btAngularLimit_fit" #.(lispify "btAngularLimit_fit" 'function)) :void
  (self :pointer)
  (angle :pointer))

(export '#.(lispify "btAngularLimit_fit" 'function))

(declaim (inline #.(lispify "btAngularLimit_getError" 'function)))

(cffi:defcfun ("_wrap_btAngularLimit_getError" #.(lispify "btAngularLimit_getError" 'function)) :float
  (self :pointer))

(export '#.(lispify "btAngularLimit_getError" 'function))

(declaim (inline #.(lispify "btAngularLimit_getLow" 'function)))

(cffi:defcfun ("_wrap_btAngularLimit_getLow" #.(lispify "btAngularLimit_getLow" 'function)) :float
  (self :pointer))

(export '#.(lispify "btAngularLimit_getLow" 'function))

(declaim (inline #.(lispify "btAngularLimit_getHigh" 'function)))

(cffi:defcfun ("_wrap_btAngularLimit_getHigh" #.(lispify "btAngularLimit_getHigh" 'function)) :float
  (self :pointer))

(export '#.(lispify "btAngularLimit_getHigh" 'function))

(declaim (inline #.(lispify "delete_btAngularLimit" 'function)))

(cffi:defcfun ("_wrap_delete_btAngularLimit" #.(lispify "delete_btAngularLimit" 'function)) :void
  (self :pointer))

(export '#.(lispify "delete_btAngularLimit" 'function))

(define-constant #.(lispify "btPoint2PointConstraintDataName" 'constant) "btPoint2PointConstraintFloatData" :test 'equal)

(export '#.(lispify "btPoint2PointConstraintDataName" 'constant))

(cffi:defcstruct #.(lispify "btConstraintSetting" 'classname)
	(#.(lispify "m_tau" 'slotname) :float)
	(#.(lispify "m_damping" 'slotname) :float)
	(#.(lispify "m_impulseClamp" 'slotname) :float))

(export '#.(lispify "btConstraintSetting" 'classname))

(export '#.(lispify "m_tau" 'slotname))

(export '#.(lispify "m_damping" 'slotname))

(export '#.(lispify "m_impulseClamp" 'slotname))

(cffi:defcenum #.(lispify "btPoint2PointFlags" 'enumname)
	(#.(lispify "BT_P2P_FLAGS_ERP" 'enumvalue :keyword) #.1)
	(#.(lispify "BT_P2P_FLAGS_CFM" 'enumvalue :keyword) #.2))

(export '#.(lispify "btPoint2PointFlags" 'enumname))

(declaim (inline #.(lispify "btPoint2PointConstraint_makeCPlusPlusInstance" 'function)))

(cffi:defcfun ("_wrap_btPoint2PointConstraint_makeCPlusPlusInstance__SWIG_0" #.(lispify "btPoint2PointConstraint_makeCPlusPlusInstance" 'function)) :pointer
  (self :pointer)
  (sizeInBytes :pointer))

(export '#.(lispify "btPoint2PointConstraint_makeCPlusPlusInstance" 'function))

(declaim (inline #.(lispify "btPoint2PointConstraint_deleteCPlusPlusInstance" 'function)))

(cffi:defcfun ("_wrap_btPoint2PointConstraint_deleteCPlusPlusInstance__SWIG_0" #.(lispify "btPoint2PointConstraint_deleteCPlusPlusInstance" 'function)) :void
  (self :pointer)
  (ptr :pointer))

(export '#.(lispify "btPoint2PointConstraint_deleteCPlusPlusInstance" 'function))

(declaim (inline #.(lispify "btPoint2PointConstraint_makeCPlusPlusInstance" 'function)))

(cffi:defcfun ("_wrap_btPoint2PointConstraint_makeCPlusPlusInstance__SWIG_1" #.(lispify "btPoint2PointConstraint_makeCPlusPlusInstance" 'function)) :pointer
  (self :pointer)
  (arg1 :pointer)
  (ptr :pointer))

(export '#.(lispify "btPoint2PointConstraint_makeCPlusPlusInstance" 'function))

(declaim (inline #.(lispify "btPoint2PointConstraint_deleteCPlusPlusInstance" 'function)))

(cffi:defcfun ("_wrap_btPoint2PointConstraint_deleteCPlusPlusInstance__SWIG_1" #.(lispify "btPoint2PointConstraint_deleteCPlusPlusInstance" 'function)) :void
  (self :pointer)
  (arg1 :pointer)
  (arg2 :pointer))

(export '#.(lispify "btPoint2PointConstraint_deleteCPlusPlusInstance" 'function))

(declaim (inline #.(lispify "btPoint2PointConstraint_makeCPlusArray" 'function)))

(cffi:defcfun ("_wrap_btPoint2PointConstraint_makeCPlusArray__SWIG_0" #.(lispify "btPoint2PointConstraint_makeCPlusArray" 'function)) :pointer
  (self :pointer)
  (sizeInBytes :pointer))

(export '#.(lispify "btPoint2PointConstraint_makeCPlusArray" 'function))

(declaim (inline #.(lispify "btPoint2PointConstraint_deleteCPlusArray" 'function)))

(cffi:defcfun ("_wrap_btPoint2PointConstraint_deleteCPlusArray__SWIG_0" #.(lispify "btPoint2PointConstraint_deleteCPlusArray" 'function)) :void
  (self :pointer)
  (ptr :pointer))

(export '#.(lispify "btPoint2PointConstraint_deleteCPlusArray" 'function))

(declaim (inline #.(lispify "btPoint2PointConstraint_makeCPlusArray" 'function)))

(cffi:defcfun ("_wrap_btPoint2PointConstraint_makeCPlusArray__SWIG_1" #.(lispify "btPoint2PointConstraint_makeCPlusArray" 'function)) :pointer
  (self :pointer)
  (arg1 :pointer)
  (ptr :pointer))

(export '#.(lispify "btPoint2PointConstraint_makeCPlusArray" 'function))

(declaim (inline #.(lispify "btPoint2PointConstraint_deleteCPlusArray" 'function)))

(cffi:defcfun ("_wrap_btPoint2PointConstraint_deleteCPlusArray__SWIG_1" #.(lispify "btPoint2PointConstraint_deleteCPlusArray" 'function)) :void
  (self :pointer)
  (arg1 :pointer)
  (arg2 :pointer))

(export '#.(lispify "btPoint2PointConstraint_deleteCPlusArray" 'function))

(declaim (inline #.(lispify "btPoint2PointConstraint_m_useSolveConstraintObsolete_set" 'function)))

(cffi:defcfun ("_wrap_btPoint2PointConstraint_m_useSolveConstraintObsolete_set" #.(lispify "btPoint2PointConstraint_m_useSolveConstraintObsolete_set" 'function)) :void
  (self :pointer)
  (m_useSolveConstraintObsolete :pointer))

(export '#.(lispify "btPoint2PointConstraint_m_useSolveConstraintObsolete_set" 'function))

(declaim (inline #.(lispify "btPoint2PointConstraint_m_useSolveConstraintObsolete_get" 'function)))

(cffi:defcfun ("_wrap_btPoint2PointConstraint_m_useSolveConstraintObsolete_get" #.(lispify "btPoint2PointConstraint_m_useSolveConstraintObsolete_get" 'function)) :pointer
  (self :pointer))

(export '#.(lispify "btPoint2PointConstraint_m_useSolveConstraintObsolete_get" 'function))

(declaim (inline #.(lispify "btPoint2PointConstraint_m_setting_set" 'function)))

(cffi:defcfun ("_wrap_btPoint2PointConstraint_m_setting_set" #.(lispify "btPoint2PointConstraint_m_setting_set" 'function)) :void
  (self :pointer)
  (m_setting :pointer))

(export '#.(lispify "btPoint2PointConstraint_m_setting_set" 'function))

(declaim (inline #.(lispify "btPoint2PointConstraint_m_setting_get" 'function)))

(cffi:defcfun ("_wrap_btPoint2PointConstraint_m_setting_get" #.(lispify "btPoint2PointConstraint_m_setting_get" 'function)) :pointer
  (self :pointer))

(export '#.(lispify "btPoint2PointConstraint_m_setting_get" 'function))

(declaim (inline #.(lispify "new_btPoint2PointConstraint" 'function)))

(cffi:defcfun ("_wrap_new_btPoint2PointConstraint__SWIG_0" #.(lispify "new_btPoint2PointConstraint" 'function)) :pointer
  (rbA :pointer)
  (rbB :pointer)
  (pivotInA :pointer)
  (pivotInB :pointer))

(export '#.(lispify "new_btPoint2PointConstraint" 'function))

(declaim (inline #.(lispify "new_btPoint2PointConstraint" 'function)))

(cffi:defcfun ("_wrap_new_btPoint2PointConstraint__SWIG_1" #.(lispify "new_btPoint2PointConstraint" 'function)) :pointer
  (rbA :pointer)
  (pivotInA :pointer))

(export '#.(lispify "new_btPoint2PointConstraint" 'function))

(declaim (inline #.(lispify "btPoint2PointConstraint_buildJacobian" 'function)))

(cffi:defcfun ("_wrap_btPoint2PointConstraint_buildJacobian" #.(lispify "btPoint2PointConstraint_buildJacobian" 'function)) :void
  (self :pointer))

(export '#.(lispify "btPoint2PointConstraint_buildJacobian" 'function))

(declaim (inline #.(lispify "btPoint2PointConstraint_getInfo1" 'function)))

(cffi:defcfun ("_wrap_btPoint2PointConstraint_getInfo1" #.(lispify "btPoint2PointConstraint_getInfo1" 'function)) :void
  (self :pointer)
  (info :pointer))

(export '#.(lispify "btPoint2PointConstraint_getInfo1" 'function))

(declaim (inline #.(lispify "btPoint2PointConstraint_getInfo1NonVirtual" 'function)))

(cffi:defcfun ("_wrap_btPoint2PointConstraint_getInfo1NonVirtual" #.(lispify "btPoint2PointConstraint_getInfo1NonVirtual" 'function)) :void
  (self :pointer)
  (info :pointer))

(export '#.(lispify "btPoint2PointConstraint_getInfo1NonVirtual" 'function))

(declaim (inline #.(lispify "btPoint2PointConstraint_getInfo2" 'function)))

(cffi:defcfun ("_wrap_btPoint2PointConstraint_getInfo2" #.(lispify "btPoint2PointConstraint_getInfo2" 'function)) :void
  (self :pointer)
  (info :pointer))

(export '#.(lispify "btPoint2PointConstraint_getInfo2" 'function))

(declaim (inline #.(lispify "btPoint2PointConstraint_getInfo2NonVirtual" 'function)))

(cffi:defcfun ("_wrap_btPoint2PointConstraint_getInfo2NonVirtual" #.(lispify "btPoint2PointConstraint_getInfo2NonVirtual" 'function)) :void
  (self :pointer)
  (info :pointer)
  (body0_trans :pointer)
  (body1_trans :pointer))

(export '#.(lispify "btPoint2PointConstraint_getInfo2NonVirtual" 'function))

(declaim (inline #.(lispify "btPoint2PointConstraint_updateRHS" 'function)))

(cffi:defcfun ("_wrap_btPoint2PointConstraint_updateRHS" #.(lispify "btPoint2PointConstraint_updateRHS" 'function)) :void
  (self :pointer)
  (timeStep :float))

(export '#.(lispify "btPoint2PointConstraint_updateRHS" 'function))

(declaim (inline #.(lispify "btPoint2PointConstraint_setPivotA" 'function)))

(cffi:defcfun ("_wrap_btPoint2PointConstraint_setPivotA" #.(lispify "btPoint2PointConstraint_setPivotA" 'function)) :void
  (self :pointer)
  (pivotA :pointer))

(export '#.(lispify "btPoint2PointConstraint_setPivotA" 'function))

(declaim (inline #.(lispify "btPoint2PointConstraint_setPivotB" 'function)))

(cffi:defcfun ("_wrap_btPoint2PointConstraint_setPivotB" #.(lispify "btPoint2PointConstraint_setPivotB" 'function)) :void
  (self :pointer)
  (pivotB :pointer))

(export '#.(lispify "btPoint2PointConstraint_setPivotB" 'function))

(declaim (inline #.(lispify "btPoint2PointConstraint_getPivotInA" 'function)))

(cffi:defcfun ("_wrap_btPoint2PointConstraint_getPivotInA" #.(lispify "btPoint2PointConstraint_getPivotInA" 'function)) :pointer
  (self :pointer))

(export '#.(lispify "btPoint2PointConstraint_getPivotInA" 'function))

(declaim (inline #.(lispify "btPoint2PointConstraint_getPivotInB" 'function)))

(cffi:defcfun ("_wrap_btPoint2PointConstraint_getPivotInB" #.(lispify "btPoint2PointConstraint_getPivotInB" 'function)) :pointer
  (self :pointer))

(export '#.(lispify "btPoint2PointConstraint_getPivotInB" 'function))

(declaim (inline #.(lispify "btPoint2PointConstraint_calculateSerializeBufferSize" 'function)))

(cffi:defcfun ("_wrap_btPoint2PointConstraint_calculateSerializeBufferSize" #.(lispify "btPoint2PointConstraint_calculateSerializeBufferSize" 'function)) :int
  (self :pointer))

(export '#.(lispify "btPoint2PointConstraint_calculateSerializeBufferSize" 'function))

(declaim (inline #.(lispify "btPoint2PointConstraint_serialize" 'function)))

(cffi:defcfun ("_wrap_btPoint2PointConstraint_serialize" #.(lispify "btPoint2PointConstraint_serialize" 'function)) :string
  (self :pointer)
  (dataBuffer :pointer)
  (serializer :pointer))

(export '#.(lispify "btPoint2PointConstraint_serialize" 'function))

(declaim (inline #.(lispify "delete_btPoint2PointConstraint" 'function)))

(cffi:defcfun ("_wrap_delete_btPoint2PointConstraint" #.(lispify "delete_btPoint2PointConstraint" 'function)) :void
  (self :pointer))

(export '#.(lispify "delete_btPoint2PointConstraint" 'function))

(cffi:defcstruct #.(lispify "btPoint2PointConstraintFloatData" 'classname)
	(#.(lispify "m_typeConstraintData" 'slotname) #.(lispify "btTypedConstraintData" 'classname))
	(#.(lispify "m_pivotInA" 'slotname) #.(lispify "btVector3FloatData" 'classname))
	(#.(lispify "m_pivotInB" 'slotname) #.(lispify "btVector3FloatData" 'classname)))

(export '#.(lispify "btPoint2PointConstraintFloatData" 'classname))

(export '#.(lispify "m_typeConstraintData" 'slotname))

(export '#.(lispify "m_pivotInA" 'slotname))

(export '#.(lispify "m_pivotInB" 'slotname))

(cffi:defcstruct #.(lispify "btPoint2PointConstraintDoubleData2" 'classname)
	(#.(lispify "m_typeConstraintData" 'slotname) #.(lispify "btTypedConstraintDoubleData" 'classname))
	(#.(lispify "m_pivotInA" 'slotname) #.(lispify "btVector3DoubleData" 'classname))
	(#.(lispify "m_pivotInB" 'slotname) #.(lispify "btVector3DoubleData" 'classname)))

(export '#.(lispify "btPoint2PointConstraintDoubleData2" 'classname))

(export '#.(lispify "m_typeConstraintData" 'slotname))

(export '#.(lispify "m_pivotInA" 'slotname))

(export '#.(lispify "m_pivotInB" 'slotname))

(cffi:defcstruct #.(lispify "btPoint2PointConstraintDoubleData" 'classname)
	(#.(lispify "m_typeConstraintData" 'slotname) #.(lispify "btTypedConstraintData" 'classname))
	(#.(lispify "m_pivotInA" 'slotname) #.(lispify "btVector3DoubleData" 'classname))
	(#.(lispify "m_pivotInB" 'slotname) #.(lispify "btVector3DoubleData" 'classname)))

(export '#.(lispify "btPoint2PointConstraintDoubleData" 'classname))

(export '#.(lispify "m_typeConstraintData" 'slotname))

(export '#.(lispify "m_pivotInA" 'slotname))

(export '#.(lispify "m_pivotInB" 'slotname))

(define-constant #.(lispify "_BT_USE_CENTER_LIMIT_" 'constant) 1)

(export '#.(lispify "_BT_USE_CENTER_LIMIT_" 'constant))

(define-constant #.(lispify "btHingeConstraintDataName" 'constant) "btHingeConstraintFloatData" :test 'equal)

(export '#.(lispify "btHingeConstraintDataName" 'constant))

(cffi:defcenum #.(lispify "btHingeFlags" 'enumname)
	(#.(lispify "BT_HINGE_FLAGS_CFM_STOP" 'enumvalue :keyword) #.1)
	(#.(lispify "BT_HINGE_FLAGS_ERP_STOP" 'enumvalue :keyword) #.2)
	(#.(lispify "BT_HINGE_FLAGS_CFM_NORM" 'enumvalue :keyword) #.4))

(export '#.(lispify "btHingeFlags" 'enumname))

(declaim (inline #.(lispify "btHingeConstraint_makeCPlusPlusInstance" 'function)))

(cffi:defcfun ("_wrap_btHingeConstraint_makeCPlusPlusInstance__SWIG_0" #.(lispify "btHingeConstraint_makeCPlusPlusInstance" 'function)) :pointer
  (self :pointer)
  (sizeInBytes :pointer))

(export '#.(lispify "btHingeConstraint_makeCPlusPlusInstance" 'function))

(declaim (inline #.(lispify "btHingeConstraint_deleteCPlusPlusInstance" 'function)))

(cffi:defcfun ("_wrap_btHingeConstraint_deleteCPlusPlusInstance__SWIG_0" #.(lispify "btHingeConstraint_deleteCPlusPlusInstance" 'function)) :void
  (self :pointer)
  (ptr :pointer))

(export '#.(lispify "btHingeConstraint_deleteCPlusPlusInstance" 'function))

#+ (or)
(progn 
  (declaim (inline #.(lispify "btHingeConstraint_makeCPlusPlusInstance" 'function)))
  
  (cffi:defcfun ("_wrap_btHingeConstraint_makeCPlusPlusInstance__SWIG_1" #.(lispify "btHingeConstraint_makeCPlusPlusInstance" 'function)) :pointer
    (self :pointer)
    (arg1 :pointer)
    (ptr :pointer))
  
  (export '#.(lispify "btHingeConstraint_makeCPlusPlusInstance" 'function))
  (declaim (inline #.(lispify "btHingeConstraint_deleteCPlusPlusInstance" 'function)))

 (cffi:defcfun ("_wrap_btHingeConstraint_deleteCPlusPlusInstance__SWIG_1" #.(lispify "btHingeConstraint_deleteCPlusPlusInstance" 'function)) :void
   (self :pointer)
   (arg1 :pointer)
   (arg2 :pointer))

 (export '#.(lispify "btHingeConstraint_deleteCPlusPlusInstance" 'function)))

(declaim (inline #.(lispify "btHingeConstraint_makeCPlusArray" 'function)))

(cffi:defcfun ("_wrap_btHingeConstraint_makeCPlusArray__SWIG_0" #.(lispify "btHingeConstraint_makeCPlusArray" 'function)) :pointer
  (self :pointer)
  (sizeInBytes :pointer))

(export '#.(lispify "btHingeConstraint_makeCPlusArray" 'function))

(declaim (inline #.(lispify "btHingeConstraint_deleteCPlusArray" 'function)))

(cffi:defcfun ("_wrap_btHingeConstraint_deleteCPlusArray__SWIG_0" #.(lispify "btHingeConstraint_deleteCPlusArray" 'function)) :void
  (self :pointer)
  (ptr :pointer))

(export '#.(lispify "btHingeConstraint_deleteCPlusArray" 'function))

#+ (or)
(progn
  (declaim (inline #.(lispify "btHingeConstraint_makeCPlusArray" 'function)))
  
  (cffi:defcfun ("_wrap_btHingeConstraint_makeCPlusArray__SWIG_1" #.(lispify "btHingeConstraint_makeCPlusArray" 'function)) :pointer
    (self :pointer)
    (arg1 :pointer)
    (ptr :pointer))
  
  (export '#.(lispify "btHingeConstraint_makeCPlusArray" 'function))
  (declaim (inline #.(lispify "btHingeConstraint_deleteCPlusArray" 'function)))

 (cffi:defcfun ("_wrap_btHingeConstraint_deleteCPlusArray__SWIG_1" #.(lispify "btHingeConstraint_deleteCPlusArray" 'function)) :void
   (self :pointer)
   (arg1 :pointer)
   (arg2 :pointer))

 (export '#.(lispify "btHingeConstraint_deleteCPlusArray" 'function)))

(declaim (inline #.(lispify "new_btHingeConstraint" 'function)))

(cffi:defcfun ("_wrap_new_btHingeConstraint__SWIG_0" #.(lispify "new_btHingeConstraint" 'function)) :pointer
  (rbA :pointer)
  (rbB :pointer)
  (pivotInA :pointer)
  (pivotInB :pointer)
  (axisInA :pointer)
  (axisInB :pointer)
  (useReferenceFrameA :pointer))

(export '#.(lispify "new_btHingeConstraint" 'function))

#+ (or)
(progn
  (declaim (inline #.(lispify "new_btHingeConstraint" 'function)))

 (cffi:defcfun ("_wrap_new_btHingeConstraint__SWIG_1" #.(lispify "new_btHingeConstraint" 'function)) :pointer
   (rbA :pointer)
   (rbB :pointer)
   (pivotInA :pointer)
   (pivotInB :pointer)
   (axisInA :pointer)
   (axisInB :pointer))

 (export '#.(lispify "new_btHingeConstraint" 'function))

 (declaim (inline #.(lispify "new_btHingeConstraint" 'function)))

 (cffi:defcfun ("_wrap_new_btHingeConstraint__SWIG_2" #.(lispify "new_btHingeConstraint" 'function)) :pointer
   (rbA :pointer)
   (pivotInA :pointer)
   (axisInA :pointer)
   (useReferenceFrameA :pointer))

 (export '#.(lispify "new_btHingeConstraint" 'function))

 (declaim (inline #.(lispify "new_btHingeConstraint" 'function)))

 (cffi:defcfun ("_wrap_new_btHingeConstraint__SWIG_3" #.(lispify "new_btHingeConstraint" 'function)) :pointer
   (rbA :pointer)
   (pivotInA :pointer)
   (axisInA :pointer))

 (export '#.(lispify "new_btHingeConstraint" 'function))

 (declaim (inline #.(lispify "new_btHingeConstraint" 'function)))

 (cffi:defcfun ("_wrap_new_btHingeConstraint__SWIG_4" #.(lispify "new_btHingeConstraint" 'function)) :pointer
   (rbA :pointer)
   (rbB :pointer)
   (rbAFrame :pointer)
   (rbBFrame :pointer)
   (useReferenceFrameA :pointer))

 (export '#.(lispify "new_btHingeConstraint" 'function))

 (declaim (inline #.(lispify "new_btHingeConstraint" 'function)))

 (cffi:defcfun ("_wrap_new_btHingeConstraint__SWIG_5" #.(lispify "new_btHingeConstraint" 'function)) :pointer
   (rbA :pointer)
   (rbB :pointer)
   (rbAFrame :pointer)
   (rbBFrame :pointer))

 (export '#.(lispify "new_btHingeConstraint" 'function))

 (declaim (inline #.(lispify "new_btHingeConstraint" 'function)))

 (cffi:defcfun ("_wrap_new_btHingeConstraint__SWIG_6" #.(lispify "new_btHingeConstraint" 'function)) :pointer
   (rbA :pointer)
   (rbAFrame :pointer)
   (useReferenceFrameA :pointer))

 (export '#.(lispify "new_btHingeConstraint" 'function))

 (declaim (inline #.(lispify "new_btHingeConstraint" 'function)))

 (cffi:defcfun ("_wrap_new_btHingeConstraint__SWIG_7" #.(lispify "new_btHingeConstraint" 'function)) :pointer
   (rbA :pointer)
   (rbAFrame :pointer))

 (export '#.(lispify "new_btHingeConstraint" 'function))
 )
(declaim (inline #.(lispify "btHingeConstraint_buildJacobian" 'function)))

(cffi:defcfun ("_wrap_btHingeConstraint_buildJacobian" #.(lispify "btHingeConstraint_buildJacobian" 'function)) :void
  (self :pointer))

(export '#.(lispify "btHingeConstraint_buildJacobian" 'function))

(declaim (inline #.(lispify "btHingeConstraint_getInfo1" 'function)))

(cffi:defcfun ("_wrap_btHingeConstraint_getInfo1" #.(lispify "btHingeConstraint_getInfo1" 'function)) :void
  (self :pointer)
  (info :pointer))

(export '#.(lispify "btHingeConstraint_getInfo1" 'function))

(declaim (inline #.(lispify "btHingeConstraint_getInfo1NonVirtual" 'function)))

(cffi:defcfun ("_wrap_btHingeConstraint_getInfo1NonVirtual" #.(lispify "btHingeConstraint_getInfo1NonVirtual" 'function)) :void
  (self :pointer)
  (info :pointer))

(export '#.(lispify "btHingeConstraint_getInfo1NonVirtual" 'function))

(declaim (inline #.(lispify "btHingeConstraint_getInfo2" 'function)))

(cffi:defcfun ("_wrap_btHingeConstraint_getInfo2" #.(lispify "btHingeConstraint_getInfo2" 'function)) :void
  (self :pointer)
  (info :pointer))

(export '#.(lispify "btHingeConstraint_getInfo2" 'function))

(declaim (inline #.(lispify "btHingeConstraint_getInfo2NonVirtual" 'function)))

(cffi:defcfun ("_wrap_btHingeConstraint_getInfo2NonVirtual" #.(lispify "btHingeConstraint_getInfo2NonVirtual" 'function)) :void
  (self :pointer)
  (info :pointer)
  (transA :pointer)
  (transB :pointer)
  (angVelA :pointer)
  (angVelB :pointer))

(export '#.(lispify "btHingeConstraint_getInfo2NonVirtual" 'function))

(declaim (inline #.(lispify "btHingeConstraint_getInfo2Internal" 'function)))

(cffi:defcfun ("_wrap_btHingeConstraint_getInfo2Internal" #.(lispify "btHingeConstraint_getInfo2Internal" 'function)) :void
  (self :pointer)
  (info :pointer)
  (transA :pointer)
  (transB :pointer)
  (angVelA :pointer)
  (angVelB :pointer))

(export '#.(lispify "btHingeConstraint_getInfo2Internal" 'function))

(declaim (inline #.(lispify "btHingeConstraint_getInfo2InternalUsingFrameOffset" 'function)))

(cffi:defcfun ("_wrap_btHingeConstraint_getInfo2InternalUsingFrameOffset" #.(lispify "btHingeConstraint_getInfo2InternalUsingFrameOffset" 'function)) :void
  (self :pointer)
  (info :pointer)
  (transA :pointer)
  (transB :pointer)
  (angVelA :pointer)
  (angVelB :pointer))

(export '#.(lispify "btHingeConstraint_getInfo2InternalUsingFrameOffset" 'function))

(declaim (inline #.(lispify "btHingeConstraint_updateRHS" 'function)))

(cffi:defcfun ("_wrap_btHingeConstraint_updateRHS" #.(lispify "btHingeConstraint_updateRHS" 'function)) :void
  (self :pointer)
  (timeStep :float))

(export '#.(lispify "btHingeConstraint_updateRHS" 'function))

(declaim (inline #.(lispify "btHingeConstraint_getRigidBodyA" 'function)))

(cffi:defcfun ("_wrap_btHingeConstraint_getRigidBodyA__SWIG_0" #.(lispify "btHingeConstraint_getRigidBodyA" 'function)) :pointer
  (self :pointer))

(export '#.(lispify "btHingeConstraint_getRigidBodyA" 'function))

(declaim (inline #.(lispify "btHingeConstraint_getRigidBodyB" 'function)))

(cffi:defcfun ("_wrap_btHingeConstraint_getRigidBodyB__SWIG_0" #.(lispify "btHingeConstraint_getRigidBodyB" 'function)) :pointer
  (self :pointer))

(export '#.(lispify "btHingeConstraint_getRigidBodyB" 'function))

#+ (or)
(progn 
  (declaim (inline #.(lispify "btHingeConstraint_getRigidBodyA" 'function)))

 (cffi:defcfun ("_wrap_btHingeConstraint_getRigidBodyA__SWIG_1" #.(lispify "btHingeConstraint_getRigidBodyA" 'function)) :pointer
   (self :pointer))

 (export '#.(lispify "btHingeConstraint_getRigidBodyA" 'function))

 (declaim (inline #.(lispify "btHingeConstraint_getRigidBodyB" 'function)))

 (cffi:defcfun ("_wrap_btHingeConstraint_getRigidBodyB__SWIG_1" #.(lispify "btHingeConstraint_getRigidBodyB" 'function)) :pointer
   (self :pointer))

 (export '#.(lispify "btHingeConstraint_getRigidBodyB" 'function))
 )
(declaim (inline #.(lispify "btHingeConstraint_getFrameOffsetA" 'function)))

(cffi:defcfun ("_wrap_btHingeConstraint_getFrameOffsetA" #.(lispify "btHingeConstraint_getFrameOffsetA" 'function)) :pointer
  (self :pointer))

(export '#.(lispify "btHingeConstraint_getFrameOffsetA" 'function))

(declaim (inline #.(lispify "btHingeConstraint_getFrameOffsetB" 'function)))

(cffi:defcfun ("_wrap_btHingeConstraint_getFrameOffsetB" #.(lispify "btHingeConstraint_getFrameOffsetB" 'function)) :pointer
  (self :pointer))

(export '#.(lispify "btHingeConstraint_getFrameOffsetB" 'function))

(declaim (inline #.(lispify "btHingeConstraint_setFrames" 'function)))

(cffi:defcfun ("_wrap_btHingeConstraint_setFrames" #.(lispify "btHingeConstraint_setFrames" 'function)) :void
  (self :pointer)
  (frameA :pointer)
  (frameB :pointer))

(export '#.(lispify "btHingeConstraint_setFrames" 'function))

(declaim (inline #.(lispify "btHingeConstraint_setAngularOnly" 'function)))

(cffi:defcfun ("_wrap_btHingeConstraint_setAngularOnly" #.(lispify "btHingeConstraint_setAngularOnly" 'function)) :void
  (self :pointer)
  (angularOnly :pointer))

(export '#.(lispify "btHingeConstraint_setAngularOnly" 'function))

(declaim (inline #.(lispify "btHingeConstraint_enableAngularMotor" 'function)))

(cffi:defcfun ("_wrap_btHingeConstraint_enableAngularMotor" #.(lispify "btHingeConstraint_enableAngularMotor" 'function)) :void
  (self :pointer)
  (enableMotor :pointer)
  (targetVelocity :float)
  (maxMotorImpulse :float))

(export '#.(lispify "btHingeConstraint_enableAngularMotor" 'function))

(declaim (inline #.(lispify "btHingeConstraint_enableMotor" 'function)))

(cffi:defcfun ("_wrap_btHingeConstraint_enableMotor" #.(lispify "btHingeConstraint_enableMotor" 'function)) :void
  (self :pointer)
  (enableMotor :pointer))

(export '#.(lispify "btHingeConstraint_enableMotor" 'function))

(declaim (inline #.(lispify "btHingeConstraint_setMaxMotorImpulse" 'function)))

(cffi:defcfun ("_wrap_btHingeConstraint_setMaxMotorImpulse" #.(lispify "btHingeConstraint_setMaxMotorImpulse" 'function)) :void
  (self :pointer)
  (maxMotorImpulse :float))

(export '#.(lispify "btHingeConstraint_setMaxMotorImpulse" 'function))

(declaim (inline #.(lispify "btHingeConstraint_setMotorTarget" 'function)))

(cffi:defcfun ("_wrap_btHingeConstraint_setMotorTarget__SWIG_0" 
               hinge-constraint/set-motor-target/q-a-in-b) :void
  (self :pointer)
  (qAinB :pointer)
  (dt :float))

(export 'hinge-constraint/set-motor-target/q-a-in-b)

  (declaim (inline #.(lispify "btHingeConstraint_setMotorTarget" 'function)))

 (cffi:defcfun ("_wrap_btHingeConstraint_setMotorTarget__SWIG_1" 
                hinge-constraint/set-motor-target/target-angle) :void
   (self :pointer)
   (targetAngle :float)
   (dt :float))

(export 'hinge-constraint/set-motor-target/target-angle)

(declaim (inline HINGE-CONSTRAINT/SET-LIMIT/softness&bias&relaxation))
  
(cffi:defcfun ("_wrap_btHingeConstraint_setLimit__SWIG_0" 
               HINGE-CONSTRAINT/SET-LIMIT/softness&bias&relaxation) :void
  (self :pointer)
  (low :float)
  (high :float)
  (_softness :float)
  (_biasFactor :float)
  (_relaxationFactor :float))
  
(export 'HINGE-CONSTRAINT/SET-LIMIT/softness&bias&relaxation)
  
(declaim (inline HINGE-CONSTRAINT/SET-LIMIT/softness&bias))
  
(cffi:defcfun ("_wrap_btHingeConstraint_setLimit__SWIG_1"
               HINGE-CONSTRAINT/SET-LIMIT/softness&bias) :void
  (self :pointer)
  (low :float)
  (high :float)
  (_softness :float)
  (_biasFactor :float))
  
(export 'HINGE-CONSTRAINT/SET-LIMIT/softness&bias)

(declaim (inline HINGE-CONSTRAINT/SET-LIMIT/softness))

(cffi:defcfun ("_wrap_btHingeConstraint_setLimit__SWIG_2" 
               HINGE-CONSTRAINT/SET-LIMIT/softness) :void
  (self :pointer)
  (low :float)
  (high :float)
  (_softness :float))

(export 'HINGE-CONSTRAINT/SET-LIMIT/softness)

(declaim (inline HINGE-CONSTRAINT/SET-LIMIT/naked))

(cffi:defcfun ("_wrap_btHingeConstraint_setLimit__SWIG_3" 
               HINGE-CONSTRAINT/SET-LIMIT/naked) :void
  (self :pointer)
  (low :float)
  (high :float))

(export 'HINGE-CONSTRAINT/SET-LIMIT/naked)
 
(declaim (inline #.(lispify "btHingeConstraint_setAxis" 'function)))

(cffi:defcfun ("_wrap_btHingeConstraint_setAxis" #.(lispify "btHingeConstraint_setAxis" 'function)) :void
  (self :pointer)
  (axisInA :pointer))

(export '#.(lispify "btHingeConstraint_setAxis" 'function))

(declaim (inline #.(lispify "btHingeConstraint_getLowerLimit" 'function)))

(cffi:defcfun ("_wrap_btHingeConstraint_getLowerLimit" #.(lispify "btHingeConstraint_getLowerLimit" 'function)) :float
  (self :pointer))

(export '#.(lispify "btHingeConstraint_getLowerLimit" 'function))

(declaim (inline #.(lispify "btHingeConstraint_getUpperLimit" 'function)))

(cffi:defcfun ("_wrap_btHingeConstraint_getUpperLimit" #.(lispify "btHingeConstraint_getUpperLimit" 'function)) :float
  (self :pointer))

(export '#.(lispify "btHingeConstraint_getUpperLimit" 'function))

(declaim (inline #.(lispify "btHingeConstraint_getHingeAngle" 'function)))

(cffi:defcfun ("_wrap_btHingeConstraint_getHingeAngle__SWIG_0" #.(lispify "btHingeConstraint_getHingeAngle" 'function)) :float
  (self :pointer))

(export '#.(lispify "btHingeConstraint_getHingeAngle" 'function))

(declaim (inline #.(lispify "btHingeConstraint_getHingeAngle" 'function)))

(cffi:defcfun ("_wrap_btHingeConstraint_getHingeAngle__SWIG_1" 
               HINGE-CONSTRAINT/GET-HINGE-ANGLE/with-trans-a&b) :float
  (self :pointer)
  (transA :pointer)
  (transB :pointer))

(export '#.(lispify "btHingeConstraint_getHingeAngle" 'function))

(declaim (inline #.(lispify "btHingeConstraint_testLimit" 'function)))

(cffi:defcfun ("_wrap_btHingeConstraint_testLimit" #.(lispify "btHingeConstraint_testLimit" 'function)) :void
  (self :pointer)
  (transA :pointer)
  (transB :pointer))

(export '#.(lispify "btHingeConstraint_testLimit" 'function))

(declaim (inline #.(lispify "btHingeConstraint_getAFrame" 'function)))

(cffi:defcfun ("_wrap_btHingeConstraint_getAFrame__SWIG_0" #.(lispify "btHingeConstraint_getAFrame" 'function)) :pointer
  (self :pointer))

(export '#.(lispify "btHingeConstraint_getAFrame" 'function))

(declaim (inline #.(lispify "btHingeConstraint_getBFrame" 'function)))

(cffi:defcfun ("_wrap_btHingeConstraint_getBFrame__SWIG_0" #.(lispify "btHingeConstraint_getBFrame" 'function)) :pointer
  (self :pointer))

(export '#.(lispify "btHingeConstraint_getBFrame" 'function))

#+ (or)
(progn 
  (declaim (inline #.(lispify "btHingeConstraint_getAFrame" 'function)))

 (cffi:defcfun ("_wrap_btHingeConstraint_getAFrame__SWIG_1" #.(lispify "btHingeConstraint_getAFrame" 'function)) :pointer
   (self :pointer))

 (export '#.(lispify "btHingeConstraint_getAFrame" 'function))

 (declaim (inline #.(lispify "btHingeConstraint_getBFrame" 'function)))

 (cffi:defcfun ("_wrap_btHingeConstraint_getBFrame__SWIG_1" #.(lispify "btHingeConstraint_getBFrame" 'function)) :pointer
   (self :pointer))

 (export '#.(lispify "btHingeConstraint_getBFrame" 'function)))

(declaim (inline #.(lispify "btHingeConstraint_getSolveLimit" 'function)))

(cffi:defcfun ("_wrap_btHingeConstraint_getSolveLimit" #.(lispify "btHingeConstraint_getSolveLimit" 'function)) :int
  (self :pointer))

(export '#.(lispify "btHingeConstraint_getSolveLimit" 'function))

(declaim (inline #.(lispify "btHingeConstraint_getLimitSign" 'function)))

(cffi:defcfun ("_wrap_btHingeConstraint_getLimitSign" #.(lispify "btHingeConstraint_getLimitSign" 'function)) :float
  (self :pointer))

(export '#.(lispify "btHingeConstraint_getLimitSign" 'function))

(declaim (inline #.(lispify "btHingeConstraint_getAngularOnly" 'function)))

(cffi:defcfun ("_wrap_btHingeConstraint_getAngularOnly" #.(lispify "btHingeConstraint_getAngularOnly" 'function)) :pointer
  (self :pointer))

(export '#.(lispify "btHingeConstraint_getAngularOnly" 'function))

(declaim (inline #.(lispify "btHingeConstraint_getEnableAngularMotor" 'function)))

(cffi:defcfun ("_wrap_btHingeConstraint_getEnableAngularMotor" #.(lispify "btHingeConstraint_getEnableAngularMotor" 'function)) :pointer
  (self :pointer))

(export '#.(lispify "btHingeConstraint_getEnableAngularMotor" 'function))

(declaim (inline #.(lispify "btHingeConstraint_getMotorTargetVelosity" 'function)))

(cffi:defcfun ("_wrap_btHingeConstraint_getMotorTargetVelosity" #.(lispify "btHingeConstraint_getMotorTargetVelosity" 'function)) :float
  (self :pointer))

(export '#.(lispify "btHingeConstraint_getMotorTargetVelosity" 'function))

(declaim (inline #.(lispify "btHingeConstraint_getMaxMotorImpulse" 'function)))

(cffi:defcfun ("_wrap_btHingeConstraint_getMaxMotorImpulse" #.(lispify "btHingeConstraint_getMaxMotorImpulse" 'function)) :float
  (self :pointer))

(export '#.(lispify "btHingeConstraint_getMaxMotorImpulse" 'function))

(declaim (inline #.(lispify "btHingeConstraint_getUseFrameOffset" 'function)))

(cffi:defcfun ("_wrap_btHingeConstraint_getUseFrameOffset" #.(lispify "btHingeConstraint_getUseFrameOffset" 'function)) :pointer
  (self :pointer))

(export '#.(lispify "btHingeConstraint_getUseFrameOffset" 'function))

(declaim (inline #.(lispify "btHingeConstraint_setUseFrameOffset" 'function)))

(cffi:defcfun ("_wrap_btHingeConstraint_setUseFrameOffset" #.(lispify "btHingeConstraint_setUseFrameOffset" 'function)) :void
  (self :pointer)
  (frameOffsetOnOff :pointer))

(export '#.(lispify "btHingeConstraint_setUseFrameOffset" 'function))

(declaim (inline #.(lispify "btHingeConstraint_calculateSerializeBufferSize" 'function)))

(cffi:defcfun ("_wrap_btHingeConstraint_calculateSerializeBufferSize" #.(lispify "btHingeConstraint_calculateSerializeBufferSize" 'function)) :int
  (self :pointer))

(export '#.(lispify "btHingeConstraint_calculateSerializeBufferSize" 'function))

(declaim (inline #.(lispify "btHingeConstraint_serialize" 'function)))

(cffi:defcfun ("_wrap_btHingeConstraint_serialize" #.(lispify "btHingeConstraint_serialize" 'function)) :string
  (self :pointer)
  (dataBuffer :pointer)
  (serializer :pointer))

(export '#.(lispify "btHingeConstraint_serialize" 'function))

(declaim (inline #.(lispify "delete_btHingeConstraint" 'function)))

(cffi:defcfun ("_wrap_delete_btHingeConstraint" #.(lispify "delete_btHingeConstraint" 'function)) :void
  (self :pointer))

(export '#.(lispify "delete_btHingeConstraint" 'function))

(cffi:defcstruct #.(lispify "btHingeConstraintDoubleData" 'classname)
	(#.(lispify "m_typeConstraintData" 'slotname) 
           (:POINTER
            (:STRUCT
                TYPED-CONSTRAINT-DATA)))
	(#.(lispify "m_rbAFrame" 'slotname) (:POINTER
                                             (:STRUCT
                                              transform-double-DATA)))
	(#.(lispify "m_rbBFrame" 'slotname) (:POINTER
                                             (:STRUCT
                                              transform-double-DATA)))
	(#.(lispify "m_useReferenceFrameA" 'slotname) :int)
	(#.(lispify "m_angularOnly" 'slotname) :int)
	(#.(lispify "m_enableAngularMotor" 'slotname) :int)
	(#.(lispify "m_motorTargetVelocity" 'slotname) :float)
	(#.(lispify "m_maxMotorImpulse" 'slotname) :float)
	(#.(lispify "m_lowerLimit" 'slotname) :float)
	(#.(lispify "m_upperLimit" 'slotname) :float)
	(#.(lispify "m_limitSoftness" 'slotname) :float)
	(#.(lispify "m_biasFactor" 'slotname) :float)
	(#.(lispify "m_relaxationFactor" 'slotname) :float))

(export '#.(lispify "btHingeConstraintDoubleData" 'classname))

(export '#.(lispify "m_typeConstraintData" 'slotname))

(export '#.(lispify "m_rbAFrame" 'slotname))

(export '#.(lispify "m_rbBFrame" 'slotname))

(export '#.(lispify "m_useReferenceFrameA" 'slotname))

(export '#.(lispify "m_angularOnly" 'slotname))

(export '#.(lispify "m_enableAngularMotor" 'slotname))

(export '#.(lispify "m_motorTargetVelocity" 'slotname))

(export '#.(lispify "m_maxMotorImpulse" 'slotname))

(export '#.(lispify "m_lowerLimit" 'slotname))

(export '#.(lispify "m_upperLimit" 'slotname))

(export '#.(lispify "m_limitSoftness" 'slotname))

(export '#.(lispify "m_biasFactor" 'slotname))

(export '#.(lispify "m_relaxationFactor" 'slotname))

(cffi:defcstruct #.(lispify "btHingeConstraintFloatData" 'classname)
                 (#.(lispify "m_typeConstraintData" 'slotname) (:pointer (:struct #.(lispify "btTypedConstraintData" 'classname))))
	(#.(lispify "m_rbAFrame" 'slotname) (:pointer (:struct TRANSFORM-FLOAT-DATA)))
	(#.(lispify "m_rbBFrame" 'slotname) (:pointer (:struct TRANSFORM-FLOAT-DATA)))
	(#.(lispify "m_useReferenceFrameA" 'slotname) :int)
	(#.(lispify "m_angularOnly" 'slotname) :int)
	(#.(lispify "m_enableAngularMotor" 'slotname) :int)
	(#.(lispify "m_motorTargetVelocity" 'slotname) :float)
	(#.(lispify "m_maxMotorImpulse" 'slotname) :float)
	(#.(lispify "m_lowerLimit" 'slotname) :float)
	(#.(lispify "m_upperLimit" 'slotname) :float)
	(#.(lispify "m_limitSoftness" 'slotname) :float)
	(#.(lispify "m_biasFactor" 'slotname) :float)
	(#.(lispify "m_relaxationFactor" 'slotname) :float))

(export '#.(lispify "btHingeConstraintFloatData" 'classname))

(export '#.(lispify "m_typeConstraintData" 'slotname))

(export '#.(lispify "m_rbAFrame" 'slotname))

(export '#.(lispify "m_rbBFrame" 'slotname))

(export '#.(lispify "m_useReferenceFrameA" 'slotname))

(export '#.(lispify "m_angularOnly" 'slotname))

(export '#.(lispify "m_enableAngularMotor" 'slotname))

(export '#.(lispify "m_motorTargetVelocity" 'slotname))

(export '#.(lispify "m_maxMotorImpulse" 'slotname))

(export '#.(lispify "m_lowerLimit" 'slotname))

(export '#.(lispify "m_upperLimit" 'slotname))

(export '#.(lispify "m_limitSoftness" 'slotname))

(export '#.(lispify "m_biasFactor" 'slotname))

(export '#.(lispify "m_relaxationFactor" 'slotname))

(cffi:defcstruct #.(lispify "btHingeConstraintDoubleData2" 'classname)
                 (#.(lispify "m_typeConstraintData" 'slotname) (:pointer (:struct TYPED-CONSTRAINT-DOUBLE-DATA)))
                 (#.(lispify "m_rbAFrame" 'slotname) (:pointer (:struct TRANSFORM-DOUBLE-DATA)))
                 (#.(lispify "m_rbBFrame" 'slotname) (:pointer (:struct TRANSFORM-DOUBLE-DATA)))
	(#.(lispify "m_useReferenceFrameA" 'slotname) :int)
	(#.(lispify "m_angularOnly" 'slotname) :int)
	(#.(lispify "m_enableAngularMotor" 'slotname) :int)
	(#.(lispify "m_motorTargetVelocity" 'slotname) :double)
	(#.(lispify "m_maxMotorImpulse" 'slotname) :double)
	(#.(lispify "m_lowerLimit" 'slotname) :double)
	(#.(lispify "m_upperLimit" 'slotname) :double)
	(#.(lispify "m_limitSoftness" 'slotname) :double)
	(#.(lispify "m_biasFactor" 'slotname) :double)
	(#.(lispify "m_relaxationFactor" 'slotname) :double)
	(#.(lispify "m_padding1" 'slotname) :pointer))

(export '#.(lispify "btHingeConstraintDoubleData2" 'classname))

(export '#.(lispify "m_typeConstraintData" 'slotname))

(export '#.(lispify "m_rbAFrame" 'slotname))

(export '#.(lispify "m_rbBFrame" 'slotname))

(export '#.(lispify "m_useReferenceFrameA" 'slotname))

(export '#.(lispify "m_angularOnly" 'slotname))

(export '#.(lispify "m_enableAngularMotor" 'slotname))

(export '#.(lispify "m_motorTargetVelocity" 'slotname))

(export '#.(lispify "m_maxMotorImpulse" 'slotname))

(export '#.(lispify "m_lowerLimit" 'slotname))

(export '#.(lispify "m_upperLimit" 'slotname))

(export '#.(lispify "m_limitSoftness" 'slotname))

(export '#.(lispify "m_biasFactor" 'slotname))

(export '#.(lispify "m_relaxationFactor" 'slotname))

(export '#.(lispify "m_padding1" 'slotname))

(define-constant #.(lispify "btConeTwistConstraintDataName" 'constant) "btConeTwistConstraintData" :test 'equal)

(export '#.(lispify "btConeTwistConstraintDataName" 'constant))

(cffi:defcenum #.(lispify "btConeTwistFlags" 'enumname)
	(#.(lispify "BT_CONETWIST_FLAGS_LIN_CFM" 'enumvalue :keyword) #.1)
	(#.(lispify "BT_CONETWIST_FLAGS_LIN_ERP" 'enumvalue :keyword) #.2)
	(#.(lispify "BT_CONETWIST_FLAGS_ANG_CFM" 'enumvalue :keyword) #.4))

(export '#.(lispify "btConeTwistFlags" 'enumname))

(declaim (inline #.(lispify "btConeTwistConstraint_makeCPlusPlusInstance" 'function)))

(cffi:defcfun ("_wrap_btConeTwistConstraint_makeCPlusPlusInstance__SWIG_0" #.(lispify "btConeTwistConstraint_makeCPlusPlusInstance" 'function)) :pointer
  (self :pointer)
  (sizeInBytes :pointer))

(export '#.(lispify "btConeTwistConstraint_makeCPlusPlusInstance" 'function))

(declaim (inline #.(lispify "btConeTwistConstraint_deleteCPlusPlusInstance" 'function)))

(cffi:defcfun ("_wrap_btConeTwistConstraint_deleteCPlusPlusInstance__SWIG_0" #.(lispify "btConeTwistConstraint_deleteCPlusPlusInstance" 'function)) :void
  (self :pointer)
  (ptr :pointer))

(export '#.(lispify "btConeTwistConstraint_deleteCPlusPlusInstance" 'function))

#+ (or)
(progn 
  (declaim (inline #.(lispify "btConeTwistConstraint_makeCPlusPlusInstance" 'function)))

 (cffi:defcfun ("_wrap_btConeTwistConstraint_makeCPlusPlusInstance__SWIG_1" #.(lispify "btConeTwistConstraint_makeCPlusPlusInstance" 'function)) :pointer
   (self :pointer)
   (arg1 :pointer)
   (ptr :pointer))

 (export '#.(lispify "btConeTwistConstraint_makeCPlusPlusInstance" 'function))

 (declaim (inline #.(lispify "btConeTwistConstraint_deleteCPlusPlusInstance" 'function)))

 (cffi:defcfun ("_wrap_btConeTwistConstraint_deleteCPlusPlusInstance__SWIG_1" #.(lispify "btConeTwistConstraint_deleteCPlusPlusInstance" 'function)) :void
   (self :pointer)
   (arg1 :pointer)
   (arg2 :pointer))

 (export '#.(lispify "btConeTwistConstraint_deleteCPlusPlusInstance" 'function)))

(declaim (inline #.(lispify "btConeTwistConstraint_makeCPlusArray" 'function)))

(cffi:defcfun ("_wrap_btConeTwistConstraint_makeCPlusArray__SWIG_0" #.(lispify "btConeTwistConstraint_makeCPlusArray" 'function)) :pointer
  (self :pointer)
  (sizeInBytes :pointer))

(export '#.(lispify "btConeTwistConstraint_makeCPlusArray" 'function))

(declaim (inline #.(lispify "btConeTwistConstraint_deleteCPlusArray" 'function)))

(cffi:defcfun ("_wrap_btConeTwistConstraint_deleteCPlusArray__SWIG_0" #.(lispify "btConeTwistConstraint_deleteCPlusArray" 'function)) :void
  (self :pointer)
  (ptr :pointer))

(export '#.(lispify "btConeTwistConstraint_deleteCPlusArray" 'function))

#+ (or)
(progn
  (declaim (inline #.(lispify "btConeTwistConstraint_makeCPlusArray" 'function)))
  
  (cffi:defcfun ("_wrap_btConeTwistConstraint_makeCPlusArray__SWIG_1" #.(lispify "btConeTwistConstraint_makeCPlusArray" 'function)) :pointer
    (self :pointer)
    (arg1 :pointer)
    (ptr :pointer))
  
  (export '#.(lispify "btConeTwistConstraint_makeCPlusArray" 'function))
  
  (declaim (inline #.(lispify "btConeTwistConstraint_deleteCPlusArray" 'function)))

 (cffi:defcfun ("_wrap_btConeTwistConstraint_deleteCPlusArray__SWIG_1" #.(lispify "btConeTwistConstraint_deleteCPlusArray" 'function)) :void
   (self :pointer)
   (arg1 :pointer)
   (arg2 :pointer))

 (export '#.(lispify "btConeTwistConstraint_deleteCPlusArray" 'function)))

(declaim (inline #.(lispify "new_btConeTwistConstraint" 'function)))

(cffi:defcfun ("_wrap_new_btConeTwistConstraint__SWIG_0" #.(lispify "new_btConeTwistConstraint" 'function)) :pointer
  (rbA :pointer)
  (rbB :pointer)
  (rbAFrame :pointer)
  (rbBFrame :pointer))

(export '#.(lispify "new_btConeTwistConstraint" 'function))

(declaim (inline #.(lispify "new_btConeTwistConstraint" 'function)))

(cffi:defcfun ("_wrap_new_btConeTwistConstraint__SWIG_1"
               make-cone-twist-constraint/without-b) :pointer
  (rbA :pointer)
  (rbAFrame :pointer))

(export '#.(lispify "new_btConeTwistConstraint" 'function))

(declaim (inline #.(lispify "btConeTwistConstraint_buildJacobian" 'function)))

(cffi:defcfun ("_wrap_btConeTwistConstraint_buildJacobian" #.(lispify "btConeTwistConstraint_buildJacobian" 'function)) :void
  (self :pointer))

(export '#.(lispify "btConeTwistConstraint_buildJacobian" 'function))

(declaim (inline #.(lispify "btConeTwistConstraint_getInfo1" 'function)))

(cffi:defcfun ("_wrap_btConeTwistConstraint_getInfo1" #.(lispify "btConeTwistConstraint_getInfo1" 'function)) :void
  (self :pointer)
  (info :pointer))

(export '#.(lispify "btConeTwistConstraint_getInfo1" 'function))

(declaim (inline #.(lispify "btConeTwistConstraint_getInfo1NonVirtual" 'function)))

(cffi:defcfun ("_wrap_btConeTwistConstraint_getInfo1NonVirtual" #.(lispify "btConeTwistConstraint_getInfo1NonVirtual" 'function)) :void
  (self :pointer)
  (info :pointer))

(export '#.(lispify "btConeTwistConstraint_getInfo1NonVirtual" 'function))

(declaim (inline #.(lispify "btConeTwistConstraint_getInfo2" 'function)))

(cffi:defcfun ("_wrap_btConeTwistConstraint_getInfo2" #.(lispify "btConeTwistConstraint_getInfo2" 'function)) :void
  (self :pointer)
  (info :pointer))

(export '#.(lispify "btConeTwistConstraint_getInfo2" 'function))

(declaim (inline #.(lispify "btConeTwistConstraint_getInfo2NonVirtual" 'function)))

(cffi:defcfun ("_wrap_btConeTwistConstraint_getInfo2NonVirtual" #.(lispify "btConeTwistConstraint_getInfo2NonVirtual" 'function)) :void
  (self :pointer)
  (info :pointer)
  (transA :pointer)
  (transB :pointer)
  (invInertiaWorldA :pointer)
  (invInertiaWorldB :pointer))

(export '#.(lispify "btConeTwistConstraint_getInfo2NonVirtual" 'function))

(declaim (inline #.(lispify "btConeTwistConstraint_solveConstraintObsolete" 'function)))

(cffi:defcfun ("_wrap_btConeTwistConstraint_solveConstraintObsolete" #.(lispify "btConeTwistConstraint_solveConstraintObsolete" 'function)) :void
  (self :pointer)
  (bodyA :pointer)
  (bodyB :pointer)
  (timeStep :float))

(export '#.(lispify "btConeTwistConstraint_solveConstraintObsolete" 'function))

(declaim (inline #.(lispify "btConeTwistConstraint_updateRHS" 'function)))

(cffi:defcfun ("_wrap_btConeTwistConstraint_updateRHS" #.(lispify "btConeTwistConstraint_updateRHS" 'function)) :void
  (self :pointer)
  (timeStep :float))

(export '#.(lispify "btConeTwistConstraint_updateRHS" 'function))

(declaim (inline #.(lispify "btConeTwistConstraint_getRigidBodyA" 'function)))

(cffi:defcfun ("_wrap_btConeTwistConstraint_getRigidBodyA" #.(lispify "btConeTwistConstraint_getRigidBodyA" 'function)) :pointer
  (self :pointer))

(export '#.(lispify "btConeTwistConstraint_getRigidBodyA" 'function))

(declaim (inline #.(lispify "btConeTwistConstraint_getRigidBodyB" 'function)))

(cffi:defcfun ("_wrap_btConeTwistConstraint_getRigidBodyB" #.(lispify "btConeTwistConstraint_getRigidBodyB" 'function)) :pointer
  (self :pointer))

(export '#.(lispify "btConeTwistConstraint_getRigidBodyB" 'function))

(declaim (inline #.(lispify "btConeTwistConstraint_setAngularOnly" 'function)))

(cffi:defcfun ("_wrap_btConeTwistConstraint_setAngularOnly" #.(lispify "btConeTwistConstraint_setAngularOnly" 'function)) :void
  (self :pointer)
  (angularOnly :pointer))

(export '#.(lispify "btConeTwistConstraint_setAngularOnly" 'function))

#+ (or)
(progn 
  (declaim (inline #.(lispify "btConeTwistConstraint_setLimit" 'function)))

 (cffi:defcfun ("_wrap_btConeTwistConstraint_setLimit__SWIG_0" #.(lispify "btConeTwistConstraint_setLimit" 'function)) :void
   (self :pointer)
   (limitIndex :int)
   (limitValue :float))

 (export '#.(lispify "btConeTwistConstraint_setLimit" 'function))

 (declaim (inline #.(lispify "btConeTwistConstraint_setLimit" 'function)))

 (cffi:defcfun ("_wrap_btConeTwistConstraint_setLimit__SWIG_1" #.(lispify "btConeTwistConstraint_setLimit" 'function)) :void
   (self :pointer)
   (_swingSpan1 :float)
   (_swingSpan2 :float)
   (_twistSpan :float)
   (_softness :float)
   (_biasFactor :float)
   (_relaxationFactor :float))

 (export '#.(lispify "btConeTwistConstraint_setLimit" 'function))

 (declaim (inline #.(lispify "btConeTwistConstraint_setLimit" 'function)))

 (cffi:defcfun ("_wrap_btConeTwistConstraint_setLimit__SWIG_2" #.(lispify "btConeTwistConstraint_setLimit" 'function)) :void
   (self :pointer)
   (_swingSpan1 :float)
   (_swingSpan2 :float)
   (_twistSpan :float)
   (_softness :float)
   (_biasFactor :float))

 (export '#.(lispify "btConeTwistConstraint_setLimit" 'function))

 (declaim (inline #.(lispify "btConeTwistConstraint_setLimit" 'function)))

 (cffi:defcfun ("_wrap_btConeTwistConstraint_setLimit__SWIG_3" #.(lispify "btConeTwistConstraint_setLimit" 'function)) :void
   (self :pointer)
   (_swingSpan1 :float)
   (_swingSpan2 :float)
   (_twistSpan :float)
   (_softness :float))

 (export '#.(lispify "btConeTwistConstraint_setLimit" 'function))

 (declaim (inline #.(lispify "btConeTwistConstraint_setLimit" 'function)))

 (cffi:defcfun ("_wrap_btConeTwistConstraint_setLimit__SWIG_4" #.(lispify "btConeTwistConstraint_setLimit" 'function)) :void
   (self :pointer)
   (_swingSpan1 :float)
   (_swingSpan2 :float)
   (_twistSpan :float))

 (export '#.(lispify "btConeTwistConstraint_setLimit" 'function))
 )
(declaim (inline #.(lispify "btConeTwistConstraint_getAFrame" 'function)))

(cffi:defcfun ("_wrap_btConeTwistConstraint_getAFrame" #.(lispify "btConeTwistConstraint_getAFrame" 'function)) :pointer
  (self :pointer))

(export '#.(lispify "btConeTwistConstraint_getAFrame" 'function))

(declaim (inline #.(lispify "btConeTwistConstraint_getBFrame" 'function)))

(cffi:defcfun ("_wrap_btConeTwistConstraint_getBFrame" #.(lispify "btConeTwistConstraint_getBFrame" 'function)) :pointer
  (self :pointer))

(export '#.(lispify "btConeTwistConstraint_getBFrame" 'function))

(declaim (inline #.(lispify "btConeTwistConstraint_getSolveTwistLimit" 'function)))

(cffi:defcfun ("_wrap_btConeTwistConstraint_getSolveTwistLimit" #.(lispify "btConeTwistConstraint_getSolveTwistLimit" 'function)) :int
  (self :pointer))

(export '#.(lispify "btConeTwistConstraint_getSolveTwistLimit" 'function))

(declaim (inline #.(lispify "btConeTwistConstraint_getSolveSwingLimit" 'function)))

(cffi:defcfun ("_wrap_btConeTwistConstraint_getSolveSwingLimit" #.(lispify "btConeTwistConstraint_getSolveSwingLimit" 'function)) :int
  (self :pointer))

(export '#.(lispify "btConeTwistConstraint_getSolveSwingLimit" 'function))

(declaim (inline #.(lispify "btConeTwistConstraint_getTwistLimitSign" 'function)))

(cffi:defcfun ("_wrap_btConeTwistConstraint_getTwistLimitSign" #.(lispify "btConeTwistConstraint_getTwistLimitSign" 'function)) :float
  (self :pointer))

(export '#.(lispify "btConeTwistConstraint_getTwistLimitSign" 'function))

(declaim (inline #.(lispify "btConeTwistConstraint_calcAngleInfo" 'function)))

(cffi:defcfun ("_wrap_btConeTwistConstraint_calcAngleInfo" #.(lispify "btConeTwistConstraint_calcAngleInfo" 'function)) :void
  (self :pointer))

(export '#.(lispify "btConeTwistConstraint_calcAngleInfo" 'function))

(declaim (inline #.(lispify "btConeTwistConstraint_calcAngleInfo2" 'function)))

(cffi:defcfun ("_wrap_btConeTwistConstraint_calcAngleInfo2" #.(lispify "btConeTwistConstraint_calcAngleInfo2" 'function)) :void
  (self :pointer)
  (transA :pointer)
  (transB :pointer)
  (invInertiaWorldA :pointer)
  (invInertiaWorldB :pointer))

(export '#.(lispify "btConeTwistConstraint_calcAngleInfo2" 'function))

(declaim (inline #.(lispify "btConeTwistConstraint_getSwingSpan1" 'function)))

(cffi:defcfun ("_wrap_btConeTwistConstraint_getSwingSpan1" #.(lispify "btConeTwistConstraint_getSwingSpan1" 'function)) :float
  (self :pointer))

(export '#.(lispify "btConeTwistConstraint_getSwingSpan1" 'function))

(declaim (inline #.(lispify "btConeTwistConstraint_getSwingSpan2" 'function)))

(cffi:defcfun ("_wrap_btConeTwistConstraint_getSwingSpan2" #.(lispify "btConeTwistConstraint_getSwingSpan2" 'function)) :float
  (self :pointer))

(export '#.(lispify "btConeTwistConstraint_getSwingSpan2" 'function))

(declaim (inline #.(lispify "btConeTwistConstraint_getTwistSpan" 'function)))

(cffi:defcfun ("_wrap_btConeTwistConstraint_getTwistSpan" #.(lispify "btConeTwistConstraint_getTwistSpan" 'function)) :float
  (self :pointer))

(export '#.(lispify "btConeTwistConstraint_getTwistSpan" 'function))

(declaim (inline #.(lispify "btConeTwistConstraint_getTwistAngle" 'function)))

(cffi:defcfun ("_wrap_btConeTwistConstraint_getTwistAngle" #.(lispify "btConeTwistConstraint_getTwistAngle" 'function)) :float
  (self :pointer))

(export '#.(lispify "btConeTwistConstraint_getTwistAngle" 'function))

(declaim (inline #.(lispify "btConeTwistConstraint_isPastSwingLimit" 'function)))

(cffi:defcfun ("_wrap_btConeTwistConstraint_isPastSwingLimit" #.(lispify "btConeTwistConstraint_isPastSwingLimit" 'function)) :pointer
  (self :pointer))

(export '#.(lispify "btConeTwistConstraint_isPastSwingLimit" 'function))

(declaim (inline #.(lispify "btConeTwistConstraint_setDamping" 'function)))

(cffi:defcfun ("_wrap_btConeTwistConstraint_setDamping" #.(lispify "btConeTwistConstraint_setDamping" 'function)) :void
  (self :pointer)
  (damping :float))

(export '#.(lispify "btConeTwistConstraint_setDamping" 'function))

(declaim (inline #.(lispify "btConeTwistConstraint_enableMotor" 'function)))

(cffi:defcfun ("_wrap_btConeTwistConstraint_enableMotor" #.(lispify "btConeTwistConstraint_enableMotor" 'function)) :void
  (self :pointer)
  (b :pointer))

(export '#.(lispify "btConeTwistConstraint_enableMotor" 'function))

(declaim (inline #.(lispify "btConeTwistConstraint_setMaxMotorImpulse" 'function)))

(cffi:defcfun ("_wrap_btConeTwistConstraint_setMaxMotorImpulse" #.(lispify "btConeTwistConstraint_setMaxMotorImpulse" 'function)) :void
  (self :pointer)
  (maxMotorImpulse :float))

(export '#.(lispify "btConeTwistConstraint_setMaxMotorImpulse" 'function))

(declaim (inline #.(lispify "btConeTwistConstraint_setMaxMotorImpulseNormalized" 'function)))

(cffi:defcfun ("_wrap_btConeTwistConstraint_setMaxMotorImpulseNormalized" #.(lispify "btConeTwistConstraint_setMaxMotorImpulseNormalized" 'function)) :void
  (self :pointer)
  (maxMotorImpulse :float))

(export '#.(lispify "btConeTwistConstraint_setMaxMotorImpulseNormalized" 'function))

(declaim (inline #.(lispify "btConeTwistConstraint_getFixThresh" 'function)))

(cffi:defcfun ("_wrap_btConeTwistConstraint_getFixThresh" #.(lispify "btConeTwistConstraint_getFixThresh" 'function)) :float
  (self :pointer))

(export '#.(lispify "btConeTwistConstraint_getFixThresh" 'function))

(declaim (inline #.(lispify "btConeTwistConstraint_setFixThresh" 'function)))

(cffi:defcfun ("_wrap_btConeTwistConstraint_setFixThresh" #.(lispify "btConeTwistConstraint_setFixThresh" 'function)) :void
  (self :pointer)
  (fixThresh :float))

(export '#.(lispify "btConeTwistConstraint_setFixThresh" 'function))

(declaim (inline #.(lispify "btConeTwistConstraint_setMotorTarget" 'function)))

(cffi:defcfun ("_wrap_btConeTwistConstraint_setMotorTarget" #.(lispify "btConeTwistConstraint_setMotorTarget" 'function)) :void
  (self :pointer)
  (q :pointer))

(export '#.(lispify "btConeTwistConstraint_setMotorTarget" 'function))

(declaim (inline #.(lispify "btConeTwistConstraint_setMotorTargetInConstraintSpace" 'function)))

(cffi:defcfun ("_wrap_btConeTwistConstraint_setMotorTargetInConstraintSpace" #.(lispify "btConeTwistConstraint_setMotorTargetInConstraintSpace" 'function)) :void
  (self :pointer)
  (q :pointer))

(export '#.(lispify "btConeTwistConstraint_setMotorTargetInConstraintSpace" 'function))

(declaim (inline #.(lispify "btConeTwistConstraint_GetPointForAngle" 'function)))

(cffi:defcfun ("_wrap_btConeTwistConstraint_GetPointForAngle" #.(lispify "btConeTwistConstraint_GetPointForAngle" 'function)) :pointer
  (self :pointer)
  (fAngleInRadians :float)
  (fLength :float))

(export '#.(lispify "btConeTwistConstraint_GetPointForAngle" 'function))

(declaim (inline #.(lispify "btConeTwistConstraint_setFrames" 'function)))

(cffi:defcfun ("_wrap_btConeTwistConstraint_setFrames" #.(lispify "btConeTwistConstraint_setFrames" 'function)) :void
  (self :pointer)
  (frameA :pointer)
  (frameB :pointer))

(export '#.(lispify "btConeTwistConstraint_setFrames" 'function))

(declaim (inline #.(lispify "btConeTwistConstraint_getFrameOffsetA" 'function)))

(cffi:defcfun ("_wrap_btConeTwistConstraint_getFrameOffsetA" #.(lispify "btConeTwistConstraint_getFrameOffsetA" 'function)) :pointer
  (self :pointer))

(export '#.(lispify "btConeTwistConstraint_getFrameOffsetA" 'function))

(declaim (inline #.(lispify "btConeTwistConstraint_getFrameOffsetB" 'function)))

(cffi:defcfun ("_wrap_btConeTwistConstraint_getFrameOffsetB" #.(lispify "btConeTwistConstraint_getFrameOffsetB" 'function)) :pointer
  (self :pointer))

(export '#.(lispify "btConeTwistConstraint_getFrameOffsetB" 'function))

(declaim (inline #.(lispify "btConeTwistConstraint_calculateSerializeBufferSize" 'function)))

(cffi:defcfun ("_wrap_btConeTwistConstraint_calculateSerializeBufferSize" #.(lispify "btConeTwistConstraint_calculateSerializeBufferSize" 'function)) :int
  (self :pointer))

(export '#.(lispify "btConeTwistConstraint_calculateSerializeBufferSize" 'function))

(declaim (inline #.(lispify "btConeTwistConstraint_serialize" 'function)))

(cffi:defcfun ("_wrap_btConeTwistConstraint_serialize" #.(lispify "btConeTwistConstraint_serialize" 'function)) :string
  (self :pointer)
  (dataBuffer :pointer)
  (serializer :pointer))

(export '#.(lispify "btConeTwistConstraint_serialize" 'function))

(declaim (inline #.(lispify "delete_btConeTwistConstraint" 'function)))

(cffi:defcfun ("_wrap_delete_btConeTwistConstraint" #.(lispify "delete_btConeTwistConstraint" 'function)) :void
  (self :pointer))

(export '#.(lispify "delete_btConeTwistConstraint" 'function))

(cffi:defcstruct #.(lispify "btConeTwistConstraintDoubleData" 'classname)
	(#.(lispify "m_typeConstraintData" 'slotname) 
           (:pointer (:struct TYPED-CONSTRAINT-DOUBLE-DATA)))
	(#.(lispify "m_rbAFrame" 'slotname)
           (:pointer (:struct TRANSFORM-DOUBLE-DATA)))
	(#.(lispify "m_rbBFrame" 'slotname) 
           (:pointer (:struct TRANSFORM-DOUBLE-DATA)))
	(#.(lispify "m_swingSpan1" 'slotname) :double)
	(#.(lispify "m_swingSpan2" 'slotname) :double)
	(#.(lispify "m_twistSpan" 'slotname) :double)
	(#.(lispify "m_limitSoftness" 'slotname) :double)
	(#.(lispify "m_biasFactor" 'slotname) :double)
	(#.(lispify "m_relaxationFactor" 'slotname) :double)
	(#.(lispify "m_damping" 'slotname) :double))

(export '#.(lispify "btConeTwistConstraintDoubleData" 'classname))

(export '#.(lispify "m_typeConstraintData" 'slotname))

(export '#.(lispify "m_rbAFrame" 'slotname))

(export '#.(lispify "m_rbBFrame" 'slotname))

(export '#.(lispify "m_swingSpan1" 'slotname))

(export '#.(lispify "m_swingSpan2" 'slotname))

(export '#.(lispify "m_twistSpan" 'slotname))

(export '#.(lispify "m_limitSoftness" 'slotname))

(export '#.(lispify "m_biasFactor" 'slotname))

(export '#.(lispify "m_relaxationFactor" 'slotname))

(export '#.(lispify "m_damping" 'slotname))

(cffi:defcstruct #.(lispify "btConeTwistConstraintData" 'classname)
                 (#.(lispify "m_typeConstraintData" 'slotname)
                    (:POINTER (:STRUCT
                               TYPED-CONSTRAINT-DATA)))
                 (#.(lispify "m_rbAFrame" 'slotname) (:pointer (:struct transform-float-data)))
                 (#.(lispify "m_rbBFrame" 'slotname) (:pointer (:struct transform-float-data)))
	(#.(lispify "m_swingSpan1" 'slotname) :float)
	(#.(lispify "m_swingSpan2" 'slotname) :float)
	(#.(lispify "m_twistSpan" 'slotname) :float)
	(#.(lispify "m_limitSoftness" 'slotname) :float)
	(#.(lispify "m_biasFactor" 'slotname) :float)
	(#.(lispify "m_relaxationFactor" 'slotname) :float)
	(#.(lispify "m_damping" 'slotname) :float)
	(#.(lispify "m_pad" 'slotname) :pointer))

(export '#.(lispify "btConeTwistConstraintData" 'classname))

(export '#.(lispify "m_typeConstraintData" 'slotname))

(export '#.(lispify "m_rbAFrame" 'slotname))

(export '#.(lispify "m_rbBFrame" 'slotname))

(export '#.(lispify "m_swingSpan1" 'slotname))

(export '#.(lispify "m_swingSpan2" 'slotname))

(export '#.(lispify "m_twistSpan" 'slotname))

(export '#.(lispify "m_limitSoftness" 'slotname))

(export '#.(lispify "m_biasFactor" 'slotname))

(export '#.(lispify "m_relaxationFactor" 'slotname))

(export '#.(lispify "m_damping" 'slotname))

(export '#.(lispify "m_pad" 'slotname))

(define-constant #.(lispify "btGeneric6DofConstraintDataName" 'constant) "btGeneric6DofConstraintData" :test 'equal)

(export '#.(lispify "btGeneric6DofConstraintDataName" 'constant))

(declaim (inline #.(lispify "btRotationalLimitMotor_m_loLimit_set" 'function)))

(cffi:defcfun ("_wrap_btRotationalLimitMotor_m_loLimit_set" #.(lispify "btRotationalLimitMotor_m_loLimit_set" 'function)) :void
  (self :pointer)
  (m_loLimit :float))

(export '#.(lispify "btRotationalLimitMotor_m_loLimit_set" 'function))

(declaim (inline #.(lispify "btRotationalLimitMotor_m_loLimit_get" 'function)))

(cffi:defcfun ("_wrap_btRotationalLimitMotor_m_loLimit_get" #.(lispify "btRotationalLimitMotor_m_loLimit_get" 'function)) :float
  (self :pointer))

(export '#.(lispify "btRotationalLimitMotor_m_loLimit_get" 'function))

(declaim (inline #.(lispify "btRotationalLimitMotor_m_hiLimit_set" 'function)))

(cffi:defcfun ("_wrap_btRotationalLimitMotor_m_hiLimit_set" #.(lispify "btRotationalLimitMotor_m_hiLimit_set" 'function)) :void
  (self :pointer)
  (m_hiLimit :float))

(export '#.(lispify "btRotationalLimitMotor_m_hiLimit_set" 'function))

(declaim (inline #.(lispify "btRotationalLimitMotor_m_hiLimit_get" 'function)))

(cffi:defcfun ("_wrap_btRotationalLimitMotor_m_hiLimit_get" #.(lispify "btRotationalLimitMotor_m_hiLimit_get" 'function)) :float
  (self :pointer))

(export '#.(lispify "btRotationalLimitMotor_m_hiLimit_get" 'function))

(declaim (inline #.(lispify "btRotationalLimitMotor_m_targetVelocity_set" 'function)))

(cffi:defcfun ("_wrap_btRotationalLimitMotor_m_targetVelocity_set" #.(lispify "btRotationalLimitMotor_m_targetVelocity_set" 'function)) :void
  (self :pointer)
  (m_targetVelocity :float))

(export '#.(lispify "btRotationalLimitMotor_m_targetVelocity_set" 'function))

(declaim (inline #.(lispify "btRotationalLimitMotor_m_targetVelocity_get" 'function)))

(cffi:defcfun ("_wrap_btRotationalLimitMotor_m_targetVelocity_get" #.(lispify "btRotationalLimitMotor_m_targetVelocity_get" 'function)) :float
  (self :pointer))

(export '#.(lispify "btRotationalLimitMotor_m_targetVelocity_get" 'function))

(declaim (inline #.(lispify "btRotationalLimitMotor_m_maxMotorForce_set" 'function)))

(cffi:defcfun ("_wrap_btRotationalLimitMotor_m_maxMotorForce_set" #.(lispify "btRotationalLimitMotor_m_maxMotorForce_set" 'function)) :void
  (self :pointer)
  (m_maxMotorForce :float))

(export '#.(lispify "btRotationalLimitMotor_m_maxMotorForce_set" 'function))

(declaim (inline #.(lispify "btRotationalLimitMotor_m_maxMotorForce_get" 'function)))

(cffi:defcfun ("_wrap_btRotationalLimitMotor_m_maxMotorForce_get" #.(lispify "btRotationalLimitMotor_m_maxMotorForce_get" 'function)) :float
  (self :pointer))

(export '#.(lispify "btRotationalLimitMotor_m_maxMotorForce_get" 'function))

(declaim (inline #.(lispify "btRotationalLimitMotor_m_maxLimitForce_set" 'function)))

(cffi:defcfun ("_wrap_btRotationalLimitMotor_m_maxLimitForce_set" #.(lispify "btRotationalLimitMotor_m_maxLimitForce_set" 'function)) :void
  (self :pointer)
  (m_maxLimitForce :float))

(export '#.(lispify "btRotationalLimitMotor_m_maxLimitForce_set" 'function))

(declaim (inline #.(lispify "btRotationalLimitMotor_m_maxLimitForce_get" 'function)))

(cffi:defcfun ("_wrap_btRotationalLimitMotor_m_maxLimitForce_get" #.(lispify "btRotationalLimitMotor_m_maxLimitForce_get" 'function)) :float
  (self :pointer))

(export '#.(lispify "btRotationalLimitMotor_m_maxLimitForce_get" 'function))

(declaim (inline #.(lispify "btRotationalLimitMotor_m_damping_set" 'function)))

(cffi:defcfun ("_wrap_btRotationalLimitMotor_m_damping_set" #.(lispify "btRotationalLimitMotor_m_damping_set" 'function)) :void
  (self :pointer)
  (m_damping :float))

(export '#.(lispify "btRotationalLimitMotor_m_damping_set" 'function))

(declaim (inline #.(lispify "btRotationalLimitMotor_m_damping_get" 'function)))

(cffi:defcfun ("_wrap_btRotationalLimitMotor_m_damping_get" #.(lispify "btRotationalLimitMotor_m_damping_get" 'function)) :float
  (self :pointer))

(export '#.(lispify "btRotationalLimitMotor_m_damping_get" 'function))

(declaim (inline #.(lispify "btRotationalLimitMotor_m_limitSoftness_set" 'function)))

(cffi:defcfun ("_wrap_btRotationalLimitMotor_m_limitSoftness_set" #.(lispify "btRotationalLimitMotor_m_limitSoftness_set" 'function)) :void
  (self :pointer)
  (m_limitSoftness :float))

(export '#.(lispify "btRotationalLimitMotor_m_limitSoftness_set" 'function))

(declaim (inline #.(lispify "btRotationalLimitMotor_m_limitSoftness_get" 'function)))

(cffi:defcfun ("_wrap_btRotationalLimitMotor_m_limitSoftness_get" #.(lispify "btRotationalLimitMotor_m_limitSoftness_get" 'function)) :float
  (self :pointer))

(export '#.(lispify "btRotationalLimitMotor_m_limitSoftness_get" 'function))

(declaim (inline #.(lispify "btRotationalLimitMotor_m_normalCFM_set" 'function)))

(cffi:defcfun ("_wrap_btRotationalLimitMotor_m_normalCFM_set" #.(lispify "btRotationalLimitMotor_m_normalCFM_set" 'function)) :void
  (self :pointer)
  (m_normalCFM :float))

(export '#.(lispify "btRotationalLimitMotor_m_normalCFM_set" 'function))

(declaim (inline #.(lispify "btRotationalLimitMotor_m_normalCFM_get" 'function)))

(cffi:defcfun ("_wrap_btRotationalLimitMotor_m_normalCFM_get" #.(lispify "btRotationalLimitMotor_m_normalCFM_get" 'function)) :float
  (self :pointer))

(export '#.(lispify "btRotationalLimitMotor_m_normalCFM_get" 'function))

(declaim (inline #.(lispify "btRotationalLimitMotor_m_stopERP_set" 'function)))

(cffi:defcfun ("_wrap_btRotationalLimitMotor_m_stopERP_set" #.(lispify "btRotationalLimitMotor_m_stopERP_set" 'function)) :void
  (self :pointer)
  (m_stopERP :float))

(export '#.(lispify "btRotationalLimitMotor_m_stopERP_set" 'function))

(declaim (inline #.(lispify "btRotationalLimitMotor_m_stopERP_get" 'function)))

(cffi:defcfun ("_wrap_btRotationalLimitMotor_m_stopERP_get" #.(lispify "btRotationalLimitMotor_m_stopERP_get" 'function)) :float
  (self :pointer))

(export '#.(lispify "btRotationalLimitMotor_m_stopERP_get" 'function))

(declaim (inline #.(lispify "btRotationalLimitMotor_m_stopCFM_set" 'function)))

(cffi:defcfun ("_wrap_btRotationalLimitMotor_m_stopCFM_set" #.(lispify "btRotationalLimitMotor_m_stopCFM_set" 'function)) :void
  (self :pointer)
  (m_stopCFM :float))

(export '#.(lispify "btRotationalLimitMotor_m_stopCFM_set" 'function))

(declaim (inline #.(lispify "btRotationalLimitMotor_m_stopCFM_get" 'function)))

(cffi:defcfun ("_wrap_btRotationalLimitMotor_m_stopCFM_get" #.(lispify "btRotationalLimitMotor_m_stopCFM_get" 'function)) :float
  (self :pointer))

(export '#.(lispify "btRotationalLimitMotor_m_stopCFM_get" 'function))

(declaim (inline #.(lispify "btRotationalLimitMotor_m_bounce_set" 'function)))

(cffi:defcfun ("_wrap_btRotationalLimitMotor_m_bounce_set" #.(lispify "btRotationalLimitMotor_m_bounce_set" 'function)) :void
  (self :pointer)
  (m_bounce :float))

(export '#.(lispify "btRotationalLimitMotor_m_bounce_set" 'function))

(declaim (inline #.(lispify "btRotationalLimitMotor_m_bounce_get" 'function)))

(cffi:defcfun ("_wrap_btRotationalLimitMotor_m_bounce_get" #.(lispify "btRotationalLimitMotor_m_bounce_get" 'function)) :float
  (self :pointer))

(export '#.(lispify "btRotationalLimitMotor_m_bounce_get" 'function))

(declaim (inline #.(lispify "btRotationalLimitMotor_m_enableMotor_set" 'function)))

(cffi:defcfun ("_wrap_btRotationalLimitMotor_m_enableMotor_set" #.(lispify "btRotationalLimitMotor_m_enableMotor_set" 'function)) :void
  (self :pointer)
  (m_enableMotor :pointer))

(export '#.(lispify "btRotationalLimitMotor_m_enableMotor_set" 'function))

(declaim (inline #.(lispify "btRotationalLimitMotor_m_enableMotor_get" 'function)))

(cffi:defcfun ("_wrap_btRotationalLimitMotor_m_enableMotor_get" #.(lispify "btRotationalLimitMotor_m_enableMotor_get" 'function)) :pointer
  (self :pointer))

(export '#.(lispify "btRotationalLimitMotor_m_enableMotor_get" 'function))

(declaim (inline #.(lispify "btRotationalLimitMotor_m_currentLimitError_set" 'function)))

(cffi:defcfun ("_wrap_btRotationalLimitMotor_m_currentLimitError_set" #.(lispify "btRotationalLimitMotor_m_currentLimitError_set" 'function)) :void
  (self :pointer)
  (m_currentLimitError :float))

(export '#.(lispify "btRotationalLimitMotor_m_currentLimitError_set" 'function))

(declaim (inline #.(lispify "btRotationalLimitMotor_m_currentLimitError_get" 'function)))

(cffi:defcfun ("_wrap_btRotationalLimitMotor_m_currentLimitError_get" #.(lispify "btRotationalLimitMotor_m_currentLimitError_get" 'function)) :float
  (self :pointer))

(export '#.(lispify "btRotationalLimitMotor_m_currentLimitError_get" 'function))

(declaim (inline #.(lispify "btRotationalLimitMotor_m_currentPosition_set" 'function)))

(cffi:defcfun ("_wrap_btRotationalLimitMotor_m_currentPosition_set" #.(lispify "btRotationalLimitMotor_m_currentPosition_set" 'function)) :void
  (self :pointer)
  (m_currentPosition :float))

(export '#.(lispify "btRotationalLimitMotor_m_currentPosition_set" 'function))

(declaim (inline #.(lispify "btRotationalLimitMotor_m_currentPosition_get" 'function)))

(cffi:defcfun ("_wrap_btRotationalLimitMotor_m_currentPosition_get" #.(lispify "btRotationalLimitMotor_m_currentPosition_get" 'function)) :float
  (self :pointer))

(export '#.(lispify "btRotationalLimitMotor_m_currentPosition_get" 'function))

(declaim (inline #.(lispify "btRotationalLimitMotor_m_currentLimit_set" 'function)))

(cffi:defcfun ("_wrap_btRotationalLimitMotor_m_currentLimit_set" #.(lispify "btRotationalLimitMotor_m_currentLimit_set" 'function)) :void
  (self :pointer)
  (m_currentLimit :int))

(export '#.(lispify "btRotationalLimitMotor_m_currentLimit_set" 'function))

(declaim (inline #.(lispify "btRotationalLimitMotor_m_currentLimit_get" 'function)))

(cffi:defcfun ("_wrap_btRotationalLimitMotor_m_currentLimit_get" #.(lispify "btRotationalLimitMotor_m_currentLimit_get" 'function)) :int
  (self :pointer))

(export '#.(lispify "btRotationalLimitMotor_m_currentLimit_get" 'function))

(declaim (inline #.(lispify "btRotationalLimitMotor_m_accumulatedImpulse_set" 'function)))

(cffi:defcfun ("_wrap_btRotationalLimitMotor_m_accumulatedImpulse_set" #.(lispify "btRotationalLimitMotor_m_accumulatedImpulse_set" 'function)) :void
  (self :pointer)
  (m_accumulatedImpulse :float))

(export '#.(lispify "btRotationalLimitMotor_m_accumulatedImpulse_set" 'function))

(declaim (inline #.(lispify "btRotationalLimitMotor_m_accumulatedImpulse_get" 'function)))

(cffi:defcfun ("_wrap_btRotationalLimitMotor_m_accumulatedImpulse_get" #.(lispify "btRotationalLimitMotor_m_accumulatedImpulse_get" 'function)) :float
  (self :pointer))

(export '#.(lispify "btRotationalLimitMotor_m_accumulatedImpulse_get" 'function))

(declaim (inline #.(lispify "new_btRotationalLimitMotor" 'function)))

(cffi:defcfun ("_wrap_new_btRotationalLimitMotor__SWIG_0" #.(lispify "new_btRotationalLimitMotor" 'function)) :pointer)

(export '#.(lispify "new_btRotationalLimitMotor" 'function))

#+ (or)
(progn
  (declaim (inline #.(lispify "new_btRotationalLimitMotor" 'function)))

 (cffi:defcfun ("_wrap_new_btRotationalLimitMotor__SWIG_1" #.(lispify "new_btRotationalLimitMotor" 'function)) :pointer
   (limot :pointer))

 (export '#.(lispify "new_btRotationalLimitMotor" 'function)))

(declaim (inline #.(lispify "btRotationalLimitMotor_isLimited" 'function)))

(cffi:defcfun ("_wrap_btRotationalLimitMotor_isLimited" #.(lispify "btRotationalLimitMotor_isLimited" 'function)) :pointer
  (self :pointer))

(export '#.(lispify "btRotationalLimitMotor_isLimited" 'function))

(declaim (inline #.(lispify "btRotationalLimitMotor_needApplyTorques" 'function)))

(cffi:defcfun ("_wrap_btRotationalLimitMotor_needApplyTorques" #.(lispify "btRotationalLimitMotor_needApplyTorques" 'function)) :pointer
  (self :pointer))

(export '#.(lispify "btRotationalLimitMotor_needApplyTorques" 'function))

(declaim (inline #.(lispify "btRotationalLimitMotor_testLimitValue" 'function)))

(cffi:defcfun ("_wrap_btRotationalLimitMotor_testLimitValue" #.(lispify "btRotationalLimitMotor_testLimitValue" 'function)) :int
  (self :pointer)
  (test_value :float))

(export '#.(lispify "btRotationalLimitMotor_testLimitValue" 'function))

(declaim (inline #.(lispify "btRotationalLimitMotor_solveAngularLimits" 'function)))

(cffi:defcfun ("_wrap_btRotationalLimitMotor_solveAngularLimits" #.(lispify "btRotationalLimitMotor_solveAngularLimits" 'function)) :float
  (self :pointer)
  (timeStep :float)
  (axis :pointer)
  (jacDiagABInv :float)
  (body0 :pointer)
  (body1 :pointer))

(export '#.(lispify "btRotationalLimitMotor_solveAngularLimits" 'function))

(declaim (inline #.(lispify "delete_btRotationalLimitMotor" 'function)))

(cffi:defcfun ("_wrap_delete_btRotationalLimitMotor" #.(lispify "delete_btRotationalLimitMotor" 'function)) :void
  (self :pointer))

(export '#.(lispify "delete_btRotationalLimitMotor" 'function))

(declaim (inline #.(lispify "btTranslationalLimitMotor_m_lowerLimit_set" 'function)))

(cffi:defcfun ("_wrap_btTranslationalLimitMotor_m_lowerLimit_set" #.(lispify "btTranslationalLimitMotor_m_lowerLimit_set" 'function)) :void
  (self :pointer)
  (m_lowerLimit :pointer))

(export '#.(lispify "btTranslationalLimitMotor_m_lowerLimit_set" 'function))

(declaim (inline #.(lispify "btTranslationalLimitMotor_m_lowerLimit_get" 'function)))

(cffi:defcfun ("_wrap_btTranslationalLimitMotor_m_lowerLimit_get" #.(lispify "btTranslationalLimitMotor_m_lowerLimit_get" 'function)) :pointer
  (self :pointer))

(export '#.(lispify "btTranslationalLimitMotor_m_lowerLimit_get" 'function))

(declaim (inline #.(lispify "btTranslationalLimitMotor_m_upperLimit_set" 'function)))

(cffi:defcfun ("_wrap_btTranslationalLimitMotor_m_upperLimit_set" #.(lispify "btTranslationalLimitMotor_m_upperLimit_set" 'function)) :void
  (self :pointer)
  (m_upperLimit :pointer))

(export '#.(lispify "btTranslationalLimitMotor_m_upperLimit_set" 'function))

(declaim (inline #.(lispify "btTranslationalLimitMotor_m_upperLimit_get" 'function)))

(cffi:defcfun ("_wrap_btTranslationalLimitMotor_m_upperLimit_get" #.(lispify "btTranslationalLimitMotor_m_upperLimit_get" 'function)) :pointer
  (self :pointer))

(export '#.(lispify "btTranslationalLimitMotor_m_upperLimit_get" 'function))

(declaim (inline #.(lispify "btTranslationalLimitMotor_m_accumulatedImpulse_set" 'function)))

(cffi:defcfun ("_wrap_btTranslationalLimitMotor_m_accumulatedImpulse_set" #.(lispify "btTranslationalLimitMotor_m_accumulatedImpulse_set" 'function)) :void
  (self :pointer)
  (m_accumulatedImpulse :pointer))

(export '#.(lispify "btTranslationalLimitMotor_m_accumulatedImpulse_set" 'function))

(declaim (inline #.(lispify "btTranslationalLimitMotor_m_accumulatedImpulse_get" 'function)))

(cffi:defcfun ("_wrap_btTranslationalLimitMotor_m_accumulatedImpulse_get" #.(lispify "btTranslationalLimitMotor_m_accumulatedImpulse_get" 'function)) :pointer
  (self :pointer))

(export '#.(lispify "btTranslationalLimitMotor_m_accumulatedImpulse_get" 'function))

(declaim (inline #.(lispify "btTranslationalLimitMotor_m_limitSoftness_set" 'function)))

(cffi:defcfun ("_wrap_btTranslationalLimitMotor_m_limitSoftness_set" #.(lispify "btTranslationalLimitMotor_m_limitSoftness_set" 'function)) :void
  (self :pointer)
  (m_limitSoftness :float))

(export '#.(lispify "btTranslationalLimitMotor_m_limitSoftness_set" 'function))

(declaim (inline #.(lispify "btTranslationalLimitMotor_m_limitSoftness_get" 'function)))

(cffi:defcfun ("_wrap_btTranslationalLimitMotor_m_limitSoftness_get" #.(lispify "btTranslationalLimitMotor_m_limitSoftness_get" 'function)) :float
  (self :pointer))

(export '#.(lispify "btTranslationalLimitMotor_m_limitSoftness_get" 'function))

(declaim (inline #.(lispify "btTranslationalLimitMotor_m_damping_set" 'function)))

(cffi:defcfun ("_wrap_btTranslationalLimitMotor_m_damping_set" #.(lispify "btTranslationalLimitMotor_m_damping_set" 'function)) :void
  (self :pointer)
  (m_damping :float))

(export '#.(lispify "btTranslationalLimitMotor_m_damping_set" 'function))

(declaim (inline #.(lispify "btTranslationalLimitMotor_m_damping_get" 'function)))

(cffi:defcfun ("_wrap_btTranslationalLimitMotor_m_damping_get" #.(lispify "btTranslationalLimitMotor_m_damping_get" 'function)) :float
  (self :pointer))

(export '#.(lispify "btTranslationalLimitMotor_m_damping_get" 'function))

(declaim (inline #.(lispify "btTranslationalLimitMotor_m_restitution_set" 'function)))

(cffi:defcfun ("_wrap_btTranslationalLimitMotor_m_restitution_set" #.(lispify "btTranslationalLimitMotor_m_restitution_set" 'function)) :void
  (self :pointer)
  (m_restitution :float))

(export '#.(lispify "btTranslationalLimitMotor_m_restitution_set" 'function))

(declaim (inline #.(lispify "btTranslationalLimitMotor_m_restitution_get" 'function)))

(cffi:defcfun ("_wrap_btTranslationalLimitMotor_m_restitution_get" #.(lispify "btTranslationalLimitMotor_m_restitution_get" 'function)) :float
  (self :pointer))

(export '#.(lispify "btTranslationalLimitMotor_m_restitution_get" 'function))

(declaim (inline #.(lispify "btTranslationalLimitMotor_m_normalCFM_set" 'function)))

(cffi:defcfun ("_wrap_btTranslationalLimitMotor_m_normalCFM_set" #.(lispify "btTranslationalLimitMotor_m_normalCFM_set" 'function)) :void
  (self :pointer)
  (m_normalCFM :pointer))

(export '#.(lispify "btTranslationalLimitMotor_m_normalCFM_set" 'function))

(declaim (inline #.(lispify "btTranslationalLimitMotor_m_normalCFM_get" 'function)))

(cffi:defcfun ("_wrap_btTranslationalLimitMotor_m_normalCFM_get" #.(lispify "btTranslationalLimitMotor_m_normalCFM_get" 'function)) :pointer
  (self :pointer))

(export '#.(lispify "btTranslationalLimitMotor_m_normalCFM_get" 'function))

(declaim (inline #.(lispify "btTranslationalLimitMotor_m_stopERP_set" 'function)))

(cffi:defcfun ("_wrap_btTranslationalLimitMotor_m_stopERP_set" #.(lispify "btTranslationalLimitMotor_m_stopERP_set" 'function)) :void
  (self :pointer)
  (m_stopERP :pointer))

(export '#.(lispify "btTranslationalLimitMotor_m_stopERP_set" 'function))

(declaim (inline #.(lispify "btTranslationalLimitMotor_m_stopERP_get" 'function)))

(cffi:defcfun ("_wrap_btTranslationalLimitMotor_m_stopERP_get" #.(lispify "btTranslationalLimitMotor_m_stopERP_get" 'function)) :pointer
  (self :pointer))

(export '#.(lispify "btTranslationalLimitMotor_m_stopERP_get" 'function))

(declaim (inline #.(lispify "btTranslationalLimitMotor_m_stopCFM_set" 'function)))

(cffi:defcfun ("_wrap_btTranslationalLimitMotor_m_stopCFM_set" #.(lispify "btTranslationalLimitMotor_m_stopCFM_set" 'function)) :void
  (self :pointer)
  (m_stopCFM :pointer))

(export '#.(lispify "btTranslationalLimitMotor_m_stopCFM_set" 'function))

(declaim (inline #.(lispify "btTranslationalLimitMotor_m_stopCFM_get" 'function)))

(cffi:defcfun ("_wrap_btTranslationalLimitMotor_m_stopCFM_get" #.(lispify "btTranslationalLimitMotor_m_stopCFM_get" 'function)) :pointer
  (self :pointer))

(export '#.(lispify "btTranslationalLimitMotor_m_stopCFM_get" 'function))

(declaim (inline #.(lispify "btTranslationalLimitMotor_m_enableMotor_set" 'function)))

(cffi:defcfun ("_wrap_btTranslationalLimitMotor_m_enableMotor_set" #.(lispify "btTranslationalLimitMotor_m_enableMotor_set" 'function)) :void
  (self :pointer)
  (m_enableMotor :pointer))

(export '#.(lispify "btTranslationalLimitMotor_m_enableMotor_set" 'function))

(declaim (inline #.(lispify "btTranslationalLimitMotor_m_enableMotor_get" 'function)))

(cffi:defcfun ("_wrap_btTranslationalLimitMotor_m_enableMotor_get" #.(lispify "btTranslationalLimitMotor_m_enableMotor_get" 'function)) :pointer
  (self :pointer))

(export '#.(lispify "btTranslationalLimitMotor_m_enableMotor_get" 'function))

(declaim (inline #.(lispify "btTranslationalLimitMotor_m_targetVelocity_set" 'function)))

(cffi:defcfun ("_wrap_btTranslationalLimitMotor_m_targetVelocity_set" #.(lispify "btTranslationalLimitMotor_m_targetVelocity_set" 'function)) :void
  (self :pointer)
  (m_targetVelocity :pointer))

(export '#.(lispify "btTranslationalLimitMotor_m_targetVelocity_set" 'function))

(declaim (inline #.(lispify "btTranslationalLimitMotor_m_targetVelocity_get" 'function)))

(cffi:defcfun ("_wrap_btTranslationalLimitMotor_m_targetVelocity_get" #.(lispify "btTranslationalLimitMotor_m_targetVelocity_get" 'function)) :pointer
  (self :pointer))

(export '#.(lispify "btTranslationalLimitMotor_m_targetVelocity_get" 'function))

(declaim (inline #.(lispify "btTranslationalLimitMotor_m_maxMotorForce_set" 'function)))

(cffi:defcfun ("_wrap_btTranslationalLimitMotor_m_maxMotorForce_set" #.(lispify "btTranslationalLimitMotor_m_maxMotorForce_set" 'function)) :void
  (self :pointer)
  (m_maxMotorForce :pointer))

(export '#.(lispify "btTranslationalLimitMotor_m_maxMotorForce_set" 'function))

(declaim (inline #.(lispify "btTranslationalLimitMotor_m_maxMotorForce_get" 'function)))

(cffi:defcfun ("_wrap_btTranslationalLimitMotor_m_maxMotorForce_get" #.(lispify "btTranslationalLimitMotor_m_maxMotorForce_get" 'function)) :pointer
  (self :pointer))

(export '#.(lispify "btTranslationalLimitMotor_m_maxMotorForce_get" 'function))

(declaim (inline #.(lispify "btTranslationalLimitMotor_m_currentLimitError_set" 'function)))

(cffi:defcfun ("_wrap_btTranslationalLimitMotor_m_currentLimitError_set" #.(lispify "btTranslationalLimitMotor_m_currentLimitError_set" 'function)) :void
  (self :pointer)
  (m_currentLimitError :pointer))

(export '#.(lispify "btTranslationalLimitMotor_m_currentLimitError_set" 'function))

(declaim (inline #.(lispify "btTranslationalLimitMotor_m_currentLimitError_get" 'function)))

(cffi:defcfun ("_wrap_btTranslationalLimitMotor_m_currentLimitError_get" #.(lispify "btTranslationalLimitMotor_m_currentLimitError_get" 'function)) :pointer
  (self :pointer))

(export '#.(lispify "btTranslationalLimitMotor_m_currentLimitError_get" 'function))

(declaim (inline #.(lispify "btTranslationalLimitMotor_m_currentLinearDiff_set" 'function)))

(cffi:defcfun ("_wrap_btTranslationalLimitMotor_m_currentLinearDiff_set" #.(lispify "btTranslationalLimitMotor_m_currentLinearDiff_set" 'function)) :void
  (self :pointer)
  (m_currentLinearDiff :pointer))

(export '#.(lispify "btTranslationalLimitMotor_m_currentLinearDiff_set" 'function))

(declaim (inline #.(lispify "btTranslationalLimitMotor_m_currentLinearDiff_get" 'function)))

(cffi:defcfun ("_wrap_btTranslationalLimitMotor_m_currentLinearDiff_get" #.(lispify "btTranslationalLimitMotor_m_currentLinearDiff_get" 'function)) :pointer
  (self :pointer))

(export '#.(lispify "btTranslationalLimitMotor_m_currentLinearDiff_get" 'function))

(declaim (inline #.(lispify "btTranslationalLimitMotor_m_currentLimit_set" 'function)))

(cffi:defcfun ("_wrap_btTranslationalLimitMotor_m_currentLimit_set" #.(lispify "btTranslationalLimitMotor_m_currentLimit_set" 'function)) :void
  (self :pointer)
  (m_currentLimit :pointer))

(export '#.(lispify "btTranslationalLimitMotor_m_currentLimit_set" 'function))

(declaim (inline #.(lispify "btTranslationalLimitMotor_m_currentLimit_get" 'function)))

(cffi:defcfun ("_wrap_btTranslationalLimitMotor_m_currentLimit_get" #.(lispify "btTranslationalLimitMotor_m_currentLimit_get" 'function)) :pointer
  (self :pointer))

(export '#.(lispify "btTranslationalLimitMotor_m_currentLimit_get" 'function))

(declaim (inline #.(lispify "new_btTranslationalLimitMotor" 'function)))

(cffi:defcfun ("_wrap_new_btTranslationalLimitMotor__SWIG_0" #.(lispify "new_btTranslationalLimitMotor" 'function)) :pointer)

(export '#.(lispify "new_btTranslationalLimitMotor" 'function))

#+ (or)
(progn
  (declaim (inline #.(lispify "new_btTranslationalLimitMotor" 'function)))

 (cffi:defcfun ("_wrap_new_btTranslationalLimitMotor__SWIG_1" #.(lispify "new_btTranslationalLimitMotor" 'function)) :pointer
   (other :pointer))

 (export '#.(lispify "new_btTranslationalLimitMotor" 'function)))

(declaim (inline #.(lispify "btTranslationalLimitMotor_isLimited" 'function)))

(cffi:defcfun ("_wrap_btTranslationalLimitMotor_isLimited" #.(lispify "btTranslationalLimitMotor_isLimited" 'function)) :pointer
  (self :pointer)
  (limitIndex :int))

(export '#.(lispify "btTranslationalLimitMotor_isLimited" 'function))

(declaim (inline #.(lispify "btTranslationalLimitMotor_needApplyForce" 'function)))

(cffi:defcfun ("_wrap_btTranslationalLimitMotor_needApplyForce" #.(lispify "btTranslationalLimitMotor_needApplyForce" 'function)) :pointer
  (self :pointer)
  (limitIndex :int))

(export '#.(lispify "btTranslationalLimitMotor_needApplyForce" 'function))

(declaim (inline #.(lispify "btTranslationalLimitMotor_testLimitValue" 'function)))

(cffi:defcfun ("_wrap_btTranslationalLimitMotor_testLimitValue" #.(lispify "btTranslationalLimitMotor_testLimitValue" 'function)) :int
  (self :pointer)
  (limitIndex :int)
  (test_value :float))

(export '#.(lispify "btTranslationalLimitMotor_testLimitValue" 'function))

(declaim (inline #.(lispify "btTranslationalLimitMotor_solveLinearAxis" 'function)))

(cffi:defcfun ("_wrap_btTranslationalLimitMotor_solveLinearAxis" #.(lispify "btTranslationalLimitMotor_solveLinearAxis" 'function)) :float
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

(export '#.(lispify "btTranslationalLimitMotor_solveLinearAxis" 'function))

(declaim (inline #.(lispify "delete_btTranslationalLimitMotor" 'function)))

(cffi:defcfun ("_wrap_delete_btTranslationalLimitMotor" #.(lispify "delete_btTranslationalLimitMotor" 'function)) :void
  (self :pointer))

(export '#.(lispify "delete_btTranslationalLimitMotor" 'function))

(cffi:defcenum #.(lispify "bt6DofFlags" 'enumname)
	(#.(lispify "BT_6DOF_FLAGS_CFM_NORM" 'enumvalue :keyword) #.1)
	(#.(lispify "BT_6DOF_FLAGS_CFM_STOP" 'enumvalue :keyword) #.2)
	(#.(lispify "BT_6DOF_FLAGS_ERP_STOP" 'enumvalue :keyword) #.4))

(export '#.(lispify "bt6DofFlags" 'enumname))

(define-constant #.(lispify "BT_6DOF_FLAGS_AXIS_SHIFT" 'constant) 3)

(export '#.(lispify "BT_6DOF_FLAGS_AXIS_SHIFT" 'constant))

(declaim (inline #.(lispify "btGeneric6DofConstraint_makeCPlusPlusInstance" 'function)))

(cffi:defcfun ("_wrap_btGeneric6DofConstraint_makeCPlusPlusInstance__SWIG_0" #.(lispify "btGeneric6DofConstraint_makeCPlusPlusInstance" 'function)) :pointer
  (self :pointer)
  (sizeInBytes :pointer))

(export '#.(lispify "btGeneric6DofConstraint_makeCPlusPlusInstance" 'function))

(declaim (inline #.(lispify "btGeneric6DofConstraint_deleteCPlusPlusInstance" 'function)))

(cffi:defcfun ("_wrap_btGeneric6DofConstraint_deleteCPlusPlusInstance__SWIG_0" #.(lispify "btGeneric6DofConstraint_deleteCPlusPlusInstance" 'function)) :void
  (self :pointer)
  (ptr :pointer))

(export '#.(lispify "btGeneric6DofConstraint_deleteCPlusPlusInstance" 'function))

#+ (or)
(progn
  (declaim (inline #.(lispify "btGeneric6DofConstraint_makeCPlusPlusInstance" 'function)))

 (cffi:defcfun ("_wrap_btGeneric6DofConstraint_makeCPlusPlusInstance__SWIG_1" #.(lispify "btGeneric6DofConstraint_makeCPlusPlusInstance" 'function)) :pointer
   (self :pointer)
   (arg1 :pointer)
   (ptr :pointer))

 (export '#.(lispify "btGeneric6DofConstraint_makeCPlusPlusInstance" 'function))

 (declaim (inline #.(lispify "btGeneric6DofConstraint_deleteCPlusPlusInstance" 'function)))

 (cffi:defcfun ("_wrap_btGeneric6DofConstraint_deleteCPlusPlusInstance__SWIG_1" #.(lispify "btGeneric6DofConstraint_deleteCPlusPlusInstance" 'function)) :void
   (self :pointer)
   (arg1 :pointer)
   (arg2 :pointer))

 (export '#.(lispify "btGeneric6DofConstraint_deleteCPlusPlusInstance" 'function)))

(declaim (inline #.(lispify "btGeneric6DofConstraint_makeCPlusArray" 'function)))

(cffi:defcfun ("_wrap_btGeneric6DofConstraint_makeCPlusArray__SWIG_0" #.(lispify "btGeneric6DofConstraint_makeCPlusArray" 'function)) :pointer
  (self :pointer)
  (sizeInBytes :pointer))

(export '#.(lispify "btGeneric6DofConstraint_makeCPlusArray" 'function))

(declaim (inline #.(lispify "btGeneric6DofConstraint_deleteCPlusArray" 'function)))

(cffi:defcfun ("_wrap_btGeneric6DofConstraint_deleteCPlusArray__SWIG_0" #.(lispify "btGeneric6DofConstraint_deleteCPlusArray" 'function)) :void
  (self :pointer)
  (ptr :pointer))

(export '#.(lispify "btGeneric6DofConstraint_deleteCPlusArray" 'function))

#+ (or)
(progn
  (declaim (inline #.(lispify "btGeneric6DofConstraint_makeCPlusArray" 'function)))
  
  (cffi:defcfun ("_wrap_btGeneric6DofConstraint_makeCPlusArray__SWIG_1" #.(lispify "btGeneric6DofConstraint_makeCPlusArray" 'function)) :pointer
    (self :pointer)
    (arg1 :pointer)
    (ptr :pointer))
  
  (export '#.(lispify "btGeneric6DofConstraint_makeCPlusArray" 'function))
  
  (declaim (inline #.(lispify "btGeneric6DofConstraint_deleteCPlusArray" 'function)))

 (cffi:defcfun ("_wrap_btGeneric6DofConstraint_deleteCPlusArray__SWIG_1" #.(lispify "btGeneric6DofConstraint_deleteCPlusArray" 'function)) :void
   (self :pointer)
   (arg1 :pointer)
   (arg2 :pointer))

 (export '#.(lispify "btGeneric6DofConstraint_deleteCPlusArray" 'function)))

(declaim (inline #.(lispify "btGeneric6DofConstraint_m_useSolveConstraintObsolete_set" 'function)))

(cffi:defcfun ("_wrap_btGeneric6DofConstraint_m_useSolveConstraintObsolete_set" #.(lispify "btGeneric6DofConstraint_m_useSolveConstraintObsolete_set" 'function)) :void
  (self :pointer)
  (m_useSolveConstraintObsolete :pointer))

(export '#.(lispify "btGeneric6DofConstraint_m_useSolveConstraintObsolete_set" 'function))

(declaim (inline #.(lispify "btGeneric6DofConstraint_m_useSolveConstraintObsolete_get" 'function)))

(cffi:defcfun ("_wrap_btGeneric6DofConstraint_m_useSolveConstraintObsolete_get" #.(lispify "btGeneric6DofConstraint_m_useSolveConstraintObsolete_get" 'function)) :pointer
  (self :pointer))

(export '#.(lispify "btGeneric6DofConstraint_m_useSolveConstraintObsolete_get" 'function))

(declaim (inline #.(lispify "new_btGeneric6DofConstraint" 'function)))

(cffi:defcfun ("_wrap_new_btGeneric6DofConstraint__SWIG_0" #.(lispify "new_btGeneric6DofConstraint" 'function)) :pointer
  (rbA :pointer)
  (rbB :pointer)
  (frameInA :pointer)
  (frameInB :pointer)
  (useLinearReferenceFrameA :pointer))

(export '#.(lispify "new_btGeneric6DofConstraint" 'function))

(declaim (inline #.(lispify "new_btGeneric6DofConstraint" 'function)))

(cffi:defcfun ("_wrap_new_btGeneric6DofConstraint__SWIG_1" 
               MAKE-GENERIC-6-DOF-CONSTRAINT/with-linear-reference-frame-b) :pointer
  (rbB :pointer)
  (frameInB :pointer)
  (useLinearReferenceFrameB :pointer))

(export '#.(lispify "new_btGeneric6DofConstraint" 'function))

(declaim (inline #.(lispify "btGeneric6DofConstraint_calculateTransforms" 'function)))

(cffi:defcfun ("_wrap_btGeneric6DofConstraint_calculateTransforms__SWIG_0" #.(lispify "btGeneric6DofConstraint_calculateTransforms" 'function)) :void
  (self :pointer)
  (transA :pointer)
  (transB :pointer))

(export '#.(lispify "btGeneric6DofConstraint_calculateTransforms" 'function))

(declaim (inline #.(lispify "btGeneric6DofConstraint_calculateTransforms" 'function)))

(cffi:defcfun ("_wrap_btGeneric6DofConstraint_calculateTransforms__SWIG_1" 
               GENERIC-6-DOF-CONSTRAINT/CALCULATE-TRANSFORMS/naked) :void
  (self :pointer))

(export '#.(lispify "btGeneric6DofConstraint_calculateTransforms" 'function))

(declaim (inline #.(lispify "btGeneric6DofConstraint_getCalculatedTransformA" 'function)))

(cffi:defcfun ("_wrap_btGeneric6DofConstraint_getCalculatedTransformA" #.(lispify "btGeneric6DofConstraint_getCalculatedTransformA" 'function)) :pointer
  (self :pointer))

(export '#.(lispify "btGeneric6DofConstraint_getCalculatedTransformA" 'function))

(declaim (inline #.(lispify "btGeneric6DofConstraint_getCalculatedTransformB" 'function)))

(cffi:defcfun ("_wrap_btGeneric6DofConstraint_getCalculatedTransformB" #.(lispify "btGeneric6DofConstraint_getCalculatedTransformB" 'function)) :pointer
  (self :pointer))

(export '#.(lispify "btGeneric6DofConstraint_getCalculatedTransformB" 'function))

(declaim (inline #.(lispify "btGeneric6DofConstraint_getFrameOffsetA" 'function)))

(cffi:defcfun ("_wrap_btGeneric6DofConstraint_getFrameOffsetA__SWIG_0" #.(lispify "btGeneric6DofConstraint_getFrameOffsetA" 'function)) :pointer
  (self :pointer))

(export '#.(lispify "btGeneric6DofConstraint_getFrameOffsetA" 'function))

(declaim (inline #.(lispify "btGeneric6DofConstraint_getFrameOffsetB" 'function)))

(cffi:defcfun ("_wrap_btGeneric6DofConstraint_getFrameOffsetB__SWIG_0" #.(lispify "btGeneric6DofConstraint_getFrameOffsetB" 'function)) :pointer
  (self :pointer))

(export '#.(lispify "btGeneric6DofConstraint_getFrameOffsetB" 'function))

#+ (or)
(progn
  (declaim (inline #.(lispify "btGeneric6DofConstraint_getFrameOffsetA" 'function)))

 (cffi:defcfun ("_wrap_btGeneric6DofConstraint_getFrameOffsetA__SWIG_1" #.(lispify "btGeneric6DofConstraint_getFrameOffsetA" 'function)) :pointer
   (self :pointer))

 (export '#.(lispify "btGeneric6DofConstraint_getFrameOffsetA" 'function))

 (declaim (inline #.(lispify "btGeneric6DofConstraint_getFrameOffsetB" 'function)))
 (cffi:defcfun ("_wrap_btGeneric6DofConstraint_getFrameOffsetB__SWIG_1" #.(lispify "btGeneric6DofConstraint_getFrameOffsetB" 'function)) :pointer
   (self :pointer))
 (export '#.(lispify "btGeneric6DofConstraint_getFrameOffsetB" 'function)))
(declaim (inline #.(lispify "btGeneric6DofConstraint_buildJacobian" 'function)))

(cffi:defcfun ("_wrap_btGeneric6DofConstraint_buildJacobian" #.(lispify "btGeneric6DofConstraint_buildJacobian" 'function)) :void  (self :pointer))

(export '#.(lispify "btGeneric6DofConstraint_buildJacobian" 'function))
(declaim (inline #.(lispify "btGeneric6DofConstraint_getInfo1" 'function)))
(cffi:defcfun ("_wrap_btGeneric6DofConstraint_getInfo1" #.(lispify "btGeneric6DofConstraint_getInfo1" 'function)) :void
  (info :pointer))
(export '#.(lispify "btGeneric6DofConstraint_getInfo1" 'function))
(declaim (inline #.(lispify "btGeneric6DofConstraint_getInfo1NonVirtual" 'function)))
(cffi:defcfun ("_wrap_btGeneric6DofConstraint_getInfo1NonVirtual" #.(lispify "btGeneric6DofConstraint_getInfo1NonVirtual" 'function)) :void
  (self :pointer)
  (info :pointer))

(export '#.(lispify "btGeneric6DofConstraint_getInfo1NonVirtual" 'function))

(declaim (inline #.(lispify "btGeneric6DofConstraint_getInfo2" 'function)))

(cffi:defcfun ("_wrap_btGeneric6DofConstraint_getInfo2" #.(lispify "btGeneric6DofConstraint_getInfo2" 'function)) :void
  (self :pointer)
  (info :pointer))

(export '#.(lispify "btGeneric6DofConstraint_getInfo2" 'function))

(declaim (inline #.(lispify "btGeneric6DofConstraint_getInfo2NonVirtual" 'function)))

(cffi:defcfun ("_wrap_btGeneric6DofConstraint_getInfo2NonVirtual" #.(lispify "btGeneric6DofConstraint_getInfo2NonVirtual" 'function)) :void
  (self :pointer)
  (info :pointer)
  (transA :pointer)
  (transB :pointer)
  (linVelA :pointer)
  (linVelB :pointer)
  (angVelA :pointer)
  (angVelB :pointer))

(export '#.(lispify "btGeneric6DofConstraint_getInfo2NonVirtual" 'function))

(declaim (inline #.(lispify "btGeneric6DofConstraint_updateRHS" 'function)))

(cffi:defcfun ("_wrap_btGeneric6DofConstraint_updateRHS" #.(lispify "btGeneric6DofConstraint_updateRHS" 'function)) :void
  (self :pointer)
  (timeStep :float))

(export '#.(lispify "btGeneric6DofConstraint_updateRHS" 'function))

(declaim (inline #.(lispify "btGeneric6DofConstraint_getAxis" 'function)))

(cffi:defcfun ("_wrap_btGeneric6DofConstraint_getAxis" #.(lispify "btGeneric6DofConstraint_getAxis" 'function)) :pointer
  (self :pointer)
  (axis_index :int))

(export '#.(lispify "btGeneric6DofConstraint_getAxis" 'function))

(declaim (inline #.(lispify "btGeneric6DofConstraint_getAngle" 'function)))

(cffi:defcfun ("_wrap_btGeneric6DofConstraint_getAngle" #.(lispify "btGeneric6DofConstraint_getAngle" 'function)) :float
  (self :pointer)
  (axis_index :int))

(export '#.(lispify "btGeneric6DofConstraint_getAngle" 'function))

(declaim (inline #.(lispify "btGeneric6DofConstraint_getRelativePivotPosition" 'function)))

(cffi:defcfun ("_wrap_btGeneric6DofConstraint_getRelativePivotPosition" #.(lispify "btGeneric6DofConstraint_getRelativePivotPosition" 'function)) :float
  (self :pointer)
  (axis_index :int))

(export '#.(lispify "btGeneric6DofConstraint_getRelativePivotPosition" 'function))

(declaim (inline #.(lispify "btGeneric6DofConstraint_setFrames" 'function)))

(cffi:defcfun ("_wrap_btGeneric6DofConstraint_setFrames" #.(lispify "btGeneric6DofConstraint_setFrames" 'function)) :void
  (self :pointer)
  (frameA :pointer)
  (frameB :pointer))

(export '#.(lispify "btGeneric6DofConstraint_setFrames" 'function))

(declaim (inline #.(lispify "btGeneric6DofConstraint_testAngularLimitMotor" 'function)))

(cffi:defcfun ("_wrap_btGeneric6DofConstraint_testAngularLimitMotor" #.(lispify "btGeneric6DofConstraint_testAngularLimitMotor" 'function)) :pointer
  (self :pointer)
  (axis_index :int))

(export '#.(lispify "btGeneric6DofConstraint_testAngularLimitMotor" 'function))

(declaim (inline #.(lispify "btGeneric6DofConstraint_setLinearLowerLimit" 'function)))

(cffi:defcfun ("_wrap_btGeneric6DofConstraint_setLinearLowerLimit" #.(lispify "btGeneric6DofConstraint_setLinearLowerLimit" 'function)) :void
  (self :pointer)
  (linearLower :pointer))

(export '#.(lispify "btGeneric6DofConstraint_setLinearLowerLimit" 'function))

(declaim (inline #.(lispify "btGeneric6DofConstraint_getLinearLowerLimit" 'function)))

(cffi:defcfun ("_wrap_btGeneric6DofConstraint_getLinearLowerLimit" #.(lispify "btGeneric6DofConstraint_getLinearLowerLimit" 'function)) :void
  (self :pointer)
  (linearLower :pointer))

(export '#.(lispify "btGeneric6DofConstraint_getLinearLowerLimit" 'function))

(declaim (inline #.(lispify "btGeneric6DofConstraint_setLinearUpperLimit" 'function)))

(cffi:defcfun ("_wrap_btGeneric6DofConstraint_setLinearUpperLimit" #.(lispify "btGeneric6DofConstraint_setLinearUpperLimit" 'function)) :void
  (self :pointer)
  (linearUpper :pointer))

(export '#.(lispify "btGeneric6DofConstraint_setLinearUpperLimit" 'function))

(declaim (inline #.(lispify "btGeneric6DofConstraint_getLinearUpperLimit" 'function)))

(cffi:defcfun ("_wrap_btGeneric6DofConstraint_getLinearUpperLimit" #.(lispify "btGeneric6DofConstraint_getLinearUpperLimit" 'function)) :void
  (self :pointer)
  (linearUpper :pointer))

(export '#.(lispify "btGeneric6DofConstraint_getLinearUpperLimit" 'function))

(declaim (inline #.(lispify "btGeneric6DofConstraint_setAngularLowerLimit" 'function)))

(cffi:defcfun ("_wrap_btGeneric6DofConstraint_setAngularLowerLimit" #.(lispify "btGeneric6DofConstraint_setAngularLowerLimit" 'function)) :void
  (self :pointer)
  (angularLower :pointer))

(export '#.(lispify "btGeneric6DofConstraint_setAngularLowerLimit" 'function))

(declaim (inline #.(lispify "btGeneric6DofConstraint_getAngularLowerLimit" 'function)))

(cffi:defcfun ("_wrap_btGeneric6DofConstraint_getAngularLowerLimit" #.(lispify "btGeneric6DofConstraint_getAngularLowerLimit" 'function)) :void
  (self :pointer)
  (angularLower :pointer))

(export '#.(lispify "btGeneric6DofConstraint_getAngularLowerLimit" 'function))

(declaim (inline #.(lispify "btGeneric6DofConstraint_setAngularUpperLimit" 'function)))

(cffi:defcfun ("_wrap_btGeneric6DofConstraint_setAngularUpperLimit" #.(lispify "btGeneric6DofConstraint_setAngularUpperLimit" 'function)) :void
  (self :pointer)
  (angularUpper :pointer))

(export '#.(lispify "btGeneric6DofConstraint_setAngularUpperLimit" 'function))

(declaim (inline #.(lispify "btGeneric6DofConstraint_getAngularUpperLimit" 'function)))

(cffi:defcfun ("_wrap_btGeneric6DofConstraint_getAngularUpperLimit" #.(lispify "btGeneric6DofConstraint_getAngularUpperLimit" 'function)) :void
  (self :pointer)
  (angularUpper :pointer))

(export '#.(lispify "btGeneric6DofConstraint_getAngularUpperLimit" 'function))

(declaim (inline #.(lispify "btGeneric6DofConstraint_getRotationalLimitMotor" 'function)))

(cffi:defcfun ("_wrap_btGeneric6DofConstraint_getRotationalLimitMotor" #.(lispify "btGeneric6DofConstraint_getRotationalLimitMotor" 'function)) :pointer
  (self :pointer)
  (index :int))

(export '#.(lispify "btGeneric6DofConstraint_getRotationalLimitMotor" 'function))

(declaim (inline #.(lispify "btGeneric6DofConstraint_getTranslationalLimitMotor" 'function)))

(cffi:defcfun ("_wrap_btGeneric6DofConstraint_getTranslationalLimitMotor" #.(lispify "btGeneric6DofConstraint_getTranslationalLimitMotor" 'function)) :pointer  (self :pointer))
(export '#.(lispify "btGeneric6DofConstraint_getTranslationalLimitMotor" 'function))
(declaim (inline #.(lispify "btGeneric6DofConstraint_setLimit" 'function)))
(cffi:defcfun ("_wrap_btGeneric6DofConstraint_setLimit" #.(lispify "btGeneric6DofConstraint_setLimit" 'function)) :void
  (self :pointer)
  (axis :int)
  (lo :float)
  (hi :float))

(export '#.(lispify "btGeneric6DofConstraint_setLimit" 'function))

(declaim (inline #.(lispify "btGeneric6DofConstraint_isLimited" 'function)))

(cffi:defcfun ("_wrap_btGeneric6DofConstraint_isLimited" #.(lispify "btGeneric6DofConstraint_isLimited" 'function)) :pointer
  (self :pointer)
  (limitIndex :int))

(export '#.(lispify "btGeneric6DofConstraint_isLimited" 'function))

(declaim (inline #.(lispify "btGeneric6DofConstraint_calcAnchorPos" 'function)))

(cffi:defcfun ("_wrap_btGeneric6DofConstraint_calcAnchorPos" #.(lispify "btGeneric6DofConstraint_calcAnchorPos" 'function)) :void  (self :pointer))
(export '#.(lispify "btGeneric6DofConstraint_calcAnchorPos" 'function))
(declaim (inline #.(lispify "btGeneric6DofConstraint_get_limit_motor_info2" 'function)))
(cffi:defcfun ("_wrap_btGeneric6DofConstraint_get_limit_motor_info2__SWIG_0"                
               GENERIC-6-DOF-CONSTRAINT/GET-LIMIT-MOTOR-INFO-2) :int
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

(export '#.(lispify "btGeneric6DofConstraint_get_limit_motor_info2" 'function))

(declaim (inline #.(lispify "btGeneric6DofConstraint_get_limit_motor_info2" 'function)))

(cffi:defcfun ("_wrap_btGeneric6DofConstraint_get_limit_motor_info2__SWIG_1"
               GENERIC-6-DOF-CONSTRAINT/GET-LIMIT-MOTOR-INFO-2*) :int
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

(export '#.(lispify "btGeneric6DofConstraint_get_limit_motor_info2" 'function))

(declaim (inline #.(lispify "btGeneric6DofConstraint_getUseFrameOffset" 'function)))

(cffi:defcfun ("_wrap_btGeneric6DofConstraint_getUseFrameOffset" #.(lispify "btGeneric6DofConstraint_getUseFrameOffset" 'function)) :pointer  (self :pointer))
(export '#.(lispify "btGeneric6DofConstraint_getUseFrameOffset" 'function))
(declaim (inline #.(lispify "btGeneric6DofConstraint_setUseFrameOffset" 'function)))

(cffi:defcfun ("_wrap_btGeneric6DofConstraint_setUseFrameOffset" #.(lispify "btGeneric6DofConstraint_setUseFrameOffset" 'function)) :void
  (self :pointer)
  (frameOffsetOnOff :pointer))

(export '#.(lispify "btGeneric6DofConstraint_setUseFrameOffset" 'function))

(declaim (inline #.(lispify "btGeneric6DofConstraint_setAxis" 'function)))

(cffi:defcfun ("_wrap_btGeneric6DofConstraint_setAxis" #.(lispify "btGeneric6DofConstraint_setAxis" 'function)) :void
  (self :pointer)
  (axis1 :pointer)
  (axis2 :pointer))

(export '#.(lispify "btGeneric6DofConstraint_setAxis" 'function))

(declaim (inline #.(lispify "btGeneric6DofConstraint_calculateSerializeBufferSize" 'function)))

(cffi:defcfun ("_wrap_btGeneric6DofConstraint_calculateSerializeBufferSize" #.(lispify "btGeneric6DofConstraint_calculateSerializeBufferSize" 'function)) :int
  (self :pointer))

(export '#.(lispify "btGeneric6DofConstraint_calculateSerializeBufferSize" 'function))

(declaim (inline #.(lispify "btGeneric6DofConstraint_serialize" 'function)))

(cffi:defcfun ("_wrap_btGeneric6DofConstraint_serialize" #.(lispify "btGeneric6DofConstraint_serialize" 'function)) :string
  (self :pointer)
  (dataBuffer :pointer)
  (serializer :pointer))

(export '#.(lispify "btGeneric6DofConstraint_serialize" 'function))

(declaim (inline #.(lispify "delete_btGeneric6DofConstraint" 'function)))

(cffi:defcfun ("_wrap_delete_btGeneric6DofConstraint" #.(lispify "delete_btGeneric6DofConstraint" 'function)) :void
  (self :pointer))

(export '#.(lispify "delete_btGeneric6DofConstraint" 'function))

(cffi:defcstruct #.(lispify "btGeneric6DofConstraintData" 'classname)
                 (#.(lispify "m_typeConstraintData" 'slotname) (:POINTER (:STRUCT
                                                                          TYPED-CONSTRAINT-DATA)))
                 (#.(lispify "m_rbAFrame" 'slotname) (:POINTER
                                                      (:STRUCT
                                                       TRANSFORM-FLOAT-DATA)))
	(#.(lispify "m_rbBFrame" 'slotname) (:POINTER
                                             (:STRUCT
                                              TRANSFORM-FLOAT-DATA)))
	(#.(lispify "m_linearUpperLimit" 'slotname) (:POINTER
                                                     (:STRUCT
                                                      vector-3-FLOAT-DATA)))
	(#.(lispify "m_linearLowerLimit" 'slotname) (:POINTER
                                                     (:STRUCT
                                                      vector-3-FLOAT-DATA)))
	(#.(lispify "m_angularUpperLimit" 'slotname) (:POINTER
                                                      (:STRUCT
                                                       vector-3-FLOAT-DATA)))
	(#.(lispify "m_angularLowerLimit" 'slotname) (:POINTER
                                                      (:STRUCT
                                                       vector-3-FLOAT-DATA)))
	(#.(lispify "m_useLinearReferenceFrameA" 'slotname) :int)
	(#.(lispify "m_useOffsetForConstraintFrame" 'slotname) :int))

(export '#.(lispify "btGeneric6DofConstraintData" 'classname))

(export '#.(lispify "m_typeConstraintData" 'slotname))

(export '#.(lispify "m_rbAFrame" 'slotname))

(export '#.(lispify "m_rbBFrame" 'slotname))

(export '#.(lispify "m_linearUpperLimit" 'slotname))

(export '#.(lispify "m_linearLowerLimit" 'slotname))

(export '#.(lispify "m_angularUpperLimit" 'slotname))

(export '#.(lispify "m_angularLowerLimit" 'slotname))

(export '#.(lispify "m_useLinearReferenceFrameA" 'slotname))

(export '#.(lispify "m_useOffsetForConstraintFrame" 'slotname))

(cffi:defcstruct #.(lispify "btGeneric6DofConstraintDoubleData2" 'classname)
                 (#.(lispify "m_typeConstraintData" 'slotname) (:pointer (:struct #.(lispify "btTypedConstraintDoubleData" 'classname))))
                 (#.(lispify "m_rbAFrame" 'slotname) (:pointer (:struct #.(lispify "btTransformDoubleData" 'classname))))
                 (#.(lispify "m_rbBFrame" 'slotname) (:pointer (:struct #.(lispify "btTransformDoubleData" 'classname))))
	(#.(lispify "m_linearUpperLimit" 'slotname) (:pointer (:struct vector-3-double-data)))
	(#.(lispify "m_linearLowerLimit" 'slotname) (:pointer (:struct vector-3-double-data)))
	(#.(lispify "m_angularUpperLimit" 'slotname) (:pointer (:struct vector-3-double-data)))
	(#.(lispify "m_angularLowerLimit" 'slotname) (:pointer (:struct vector-3-double-data)))
	(#.(lispify "m_useLinearReferenceFrameA" 'slotname) :int)
	(#.(lispify "m_useOffsetForConstraintFrame" 'slotname) :int))

(export '#.(lispify "btGeneric6DofConstraintDoubleData2" 'classname))

(export '#.(lispify "m_typeConstraintData" 'slotname))

(export '#.(lispify "m_rbAFrame" 'slotname))

(export '#.(lispify "m_rbBFrame" 'slotname))

(export '#.(lispify "m_linearUpperLimit" 'slotname))

(export '#.(lispify "m_linearLowerLimit" 'slotname))

(export '#.(lispify "m_angularUpperLimit" 'slotname))

(export '#.(lispify "m_angularLowerLimit" 'slotname))

(export '#.(lispify "m_useLinearReferenceFrameA" 'slotname))

(export '#.(lispify "m_useOffsetForConstraintFrame" 'slotname))

(define-constant #.(lispify "btSliderConstraintDataName" 'constant) "btSliderConstraintData" :test 'equal)

(export '#.(lispify "btSliderConstraintDataName" 'constant))

(cffi:defcenum #.(lispify "btSliderFlags" 'enumname)
	(#.(lispify "BT_SLIDER_FLAGS_CFM_DIRLIN" 'enumvalue :keyword) #.(ash 1 0))
	(#.(lispify "BT_SLIDER_FLAGS_ERP_DIRLIN" 'enumvalue :keyword) #.(ash 1 1))
	(#.(lispify "BT_SLIDER_FLAGS_CFM_DIRANG" 'enumvalue :keyword) #.(ash 1 2))
	(#.(lispify "BT_SLIDER_FLAGS_ERP_DIRANG" 'enumvalue :keyword) #.(ash 1 3))
	(#.(lispify "BT_SLIDER_FLAGS_CFM_ORTLIN" 'enumvalue :keyword) #.(ash 1 4))
	(#.(lispify "BT_SLIDER_FLAGS_ERP_ORTLIN" 'enumvalue :keyword) #.(ash 1 5))
	(#.(lispify "BT_SLIDER_FLAGS_CFM_ORTANG" 'enumvalue :keyword) #.(ash 1 6))
	(#.(lispify "BT_SLIDER_FLAGS_ERP_ORTANG" 'enumvalue :keyword) #.(ash 1 7))
	(#.(lispify "BT_SLIDER_FLAGS_CFM_LIMLIN" 'enumvalue :keyword) #.(ash 1 8))
	(#.(lispify "BT_SLIDER_FLAGS_ERP_LIMLIN" 'enumvalue :keyword) #.(ash 1 9))
	(#.(lispify "BT_SLIDER_FLAGS_CFM_LIMANG" 'enumvalue :keyword) #.(ash 1 10))
	(#.(lispify "BT_SLIDER_FLAGS_ERP_LIMANG" 'enumvalue :keyword) #.(ash 1 11)))

(export '#.(lispify "btSliderFlags" 'enumname))

(declaim (inline #.(lispify "btSliderConstraint_makeCPlusPlusInstance" 'function)))

(cffi:defcfun ("_wrap_btSliderConstraint_makeCPlusPlusInstance__SWIG_0" #.(lispify "btSliderConstraint_makeCPlusPlusInstance" 'function)) :pointer
  (self :pointer)
  (sizeInBytes :pointer))

(export '#.(lispify "btSliderConstraint_makeCPlusPlusInstance" 'function))

(declaim (inline #.(lispify "btSliderConstraint_deleteCPlusPlusInstance" 'function)))

(cffi:defcfun ("_wrap_btSliderConstraint_deleteCPlusPlusInstance__SWIG_0" #.(lispify "btSliderConstraint_deleteCPlusPlusInstance" 'function)) :void
  (self :pointer)
  (ptr :pointer))

(export '#.(lispify "btSliderConstraint_deleteCPlusPlusInstance" 'function))

#+ (or)
(progn 
  (declaim (inline #.(lispify "btSliderConstraint_makeCPlusPlusInstance" 'function)))

 (cffi:defcfun ("_wrap_btSliderConstraint_makeCPlusPlusInstance__SWIG_1" #.(lispify "btSliderConstraint_makeCPlusPlusInstance" 'function)) :pointer
   (self :pointer)
   (arg1 :pointer)
   (ptr :pointer))

 (export '#.(lispify "btSliderConstraint_makeCPlusPlusInstance" 'function))

 (declaim (inline #.(lispify "btSliderConstraint_deleteCPlusPlusInstance" 'function)))

 (cffi:defcfun ("_wrap_btSliderConstraint_deleteCPlusPlusInstance__SWIG_1" #.(lispify "btSliderConstraint_deleteCPlusPlusInstance" 'function)) :void
   (self :pointer)
   (arg1 :pointer)
   (arg2 :pointer))

 (export '#.(lispify "btSliderConstraint_deleteCPlusPlusInstance" 'function)))

(declaim (inline #.(lispify "btSliderConstraint_makeCPlusArray" 'function)))

(cffi:defcfun ("_wrap_btSliderConstraint_makeCPlusArray__SWIG_0" #.(lispify "btSliderConstraint_makeCPlusArray" 'function)) :pointer
  (self :pointer)
  (sizeInBytes :pointer))

(export '#.(lispify "btSliderConstraint_makeCPlusArray" 'function))

(declaim (inline #.(lispify "btSliderConstraint_deleteCPlusArray" 'function)))

(cffi:defcfun ("_wrap_btSliderConstraint_deleteCPlusArray__SWIG_0" #.(lispify "btSliderConstraint_deleteCPlusArray" 'function)) :void
  (self :pointer)
  (ptr :pointer))

(export '#.(lispify "btSliderConstraint_deleteCPlusArray" 'function))

#+ (or)
(progn
  (declaim (inline #.(lispify "btSliderConstraint_makeCPlusArray" 'function)))
  
  (cffi:defcfun ("_wrap_btSliderConstraint_makeCPlusArray__SWIG_1" #.(lispify "btSliderConstraint_makeCPlusArray" 'function)) :pointer
    (self :pointer)
    (arg1 :pointer)
    (ptr :pointer))
  
  (export '#.(lispify "btSliderConstraint_makeCPlusArray" 'function))
  (declaim (inline #.(lispify "btSliderConstraint_deleteCPlusArray" 'function)))

 (cffi:defcfun ("_wrap_btSliderConstraint_deleteCPlusArray__SWIG_1" #.(lispify "btSliderConstraint_deleteCPlusArray" 'function)) :void
   (self :pointer)
   (arg1 :pointer)
   (arg2 :pointer))

 (export '#.(lispify "btSliderConstraint_deleteCPlusArray" 'function)))

(declaim (inline #.(lispify "new_btSliderConstraint" 'function)))

(cffi:defcfun ("_wrap_new_btSliderConstraint__SWIG_0" #.(lispify "new_btSliderConstraint" 'function)) :pointer
  (rbA :pointer)
  (rbB :pointer)
  (frameInA :pointer)
  (frameInB :pointer)
  (useLinearReferenceFrameA :pointer))

(export '#.(lispify "new_btSliderConstraint" 'function))

(declaim (inline #.(lispify "new_btSliderConstraint" 'function)))

(cffi:defcfun ("_wrap_new_btSliderConstraint__SWIG_1" 
               make-slider-constraint/with-linear-reference-frame-a) :pointer
  (rbB :pointer)
  (frameInB :pointer)
  (useLinearReferenceFrameA :pointer))

(export '#.(lispify "new_btSliderConstraint" 'function))

(declaim (inline #.(lispify "btSliderConstraint_getInfo1" 'function)))

(cffi:defcfun ("_wrap_btSliderConstraint_getInfo1" #.(lispify "btSliderConstraint_getInfo1" 'function)) :void
  (self :pointer)
  (info :pointer))

(export '#.(lispify "btSliderConstraint_getInfo1" 'function))

(declaim (inline #.(lispify "btSliderConstraint_getInfo1NonVirtual" 'function)))

(cffi:defcfun ("_wrap_btSliderConstraint_getInfo1NonVirtual" #.(lispify "btSliderConstraint_getInfo1NonVirtual" 'function)) :void
  (self :pointer)
  (info :pointer))

(export '#.(lispify "btSliderConstraint_getInfo1NonVirtual" 'function))

(declaim (inline #.(lispify "btSliderConstraint_getInfo2" 'function)))

(cffi:defcfun ("_wrap_btSliderConstraint_getInfo2" #.(lispify "btSliderConstraint_getInfo2" 'function)) :void
  (self :pointer)
  (info :pointer))

(export '#.(lispify "btSliderConstraint_getInfo2" 'function))

(declaim (inline #.(lispify "btSliderConstraint_getInfo2NonVirtual" 'function)))

(cffi:defcfun ("_wrap_btSliderConstraint_getInfo2NonVirtual" #.(lispify "btSliderConstraint_getInfo2NonVirtual" 'function)) :void
  (self :pointer)
  (info :pointer)
  (transA :pointer)
  (transB :pointer)
  (linVelA :pointer)
  (linVelB :pointer)
  (rbAinvMass :float)
  (rbBinvMass :float))

(export '#.(lispify "btSliderConstraint_getInfo2NonVirtual" 'function))

(declaim (inline #.(lispify "btSliderConstraint_getRigidBodyA" 'function)))

(cffi:defcfun ("_wrap_btSliderConstraint_getRigidBodyA" #.(lispify "btSliderConstraint_getRigidBodyA" 'function)) :pointer
  (self :pointer))

(export '#.(lispify "btSliderConstraint_getRigidBodyA" 'function))

(declaim (inline #.(lispify "btSliderConstraint_getRigidBodyB" 'function)))

(cffi:defcfun ("_wrap_btSliderConstraint_getRigidBodyB" #.(lispify "btSliderConstraint_getRigidBodyB" 'function)) :pointer
  (self :pointer))

(export '#.(lispify "btSliderConstraint_getRigidBodyB" 'function))

(declaim (inline #.(lispify "btSliderConstraint_getCalculatedTransformA" 'function)))

(cffi:defcfun ("_wrap_btSliderConstraint_getCalculatedTransformA" #.(lispify "btSliderConstraint_getCalculatedTransformA" 'function)) :pointer
  (self :pointer))

(export '#.(lispify "btSliderConstraint_getCalculatedTransformA" 'function))

(declaim (inline #.(lispify "btSliderConstraint_getCalculatedTransformB" 'function)))

(cffi:defcfun ("_wrap_btSliderConstraint_getCalculatedTransformB" #.(lispify "btSliderConstraint_getCalculatedTransformB" 'function)) :pointer
  (self :pointer))

(export '#.(lispify "btSliderConstraint_getCalculatedTransformB" 'function))

(declaim (inline #.(lispify "btSliderConstraint_getFrameOffsetA" 'function)))
(cffi:defcfun ("_wrap_btSliderConstraint_getFrameOffsetA__SWIG_0" #.(lispify "btSliderConstraint_getFrameOffsetA" 'function)) :pointer  (self :pointer))
(export '#.(lispify "btSliderConstraint_getFrameOffsetA" 'function))
(declaim (inline #.(lispify "btSliderConstraint_getFrameOffsetB" 'function)))
(cffi:defcfun ("_wrap_btSliderConstraint_getFrameOffsetB__SWIG_0" #.(lispify "btSliderConstraint_getFrameOffsetB" 'function)) :pointer  (self :pointer))
(export '#.(lispify "btSliderConstraint_getFrameOffsetB" 'function))
#+ (or)
(progn
  (declaim (inline #.(lispify "btSliderConstraint_getFrameOffsetA" 'function)))
  (cffi:defcfun ("_wrap_btSliderConstraint_getFrameOffsetA__SWIG_1" #.(lispify "btSliderConstraint_getFrameOffsetA" 'function)) :pointer
    (self :pointer))
  (export '#.(lispify "btSliderConstraint_getFrameOffsetA" 'function))
        (declaim (inline #.(lispify "btSliderConstraint_getFrameOffsetB" 'function))) 
        (cffi:defcfun ("_wrap_btSliderConstraint_getFrameOffsetB__SWIG_1" #.(lispify "btSliderConstraint_getFrameOffsetB" 'function)) :pointer  (self :pointer))
        (export '#.(lispify "btSliderConstraint_getFrameOffsetB" 'function)))
(declaim (inline #.(lispify "btSliderConstraint_getLowerLinLimit" 'function)))
(cffi:defcfun ("_wrap_btSliderConstraint_getLowerLinLimit" #.(lispify "btSliderConstraint_getLowerLinLimit" 'function)) :float  (self :pointer))
(export '#.(lispify "btSliderConstraint_getLowerLinLimit" 'function))
(declaim (inline #.(lispify "btSliderConstraint_setLowerLinLimit" 'function)))
(cffi:defcfun ("_wrap_btSliderConstraint_setLowerLinLimit" #.(lispify "btSliderConstraint_setLowerLinLimit" 'function)) :void
  (lowerLimit :float))
(export '#.(lispify "btSliderConstraint_setLowerLinLimit" 'function))
(declaim (inline #.(lispify "btSliderConstraint_getUpperLinLimit" 'function)))
(cffi:defcfun ("_wrap_btSliderConstraint_getUpperLinLimit" #.(lispify "btSliderConstraint_getUpperLinLimit" 'function)) :float  (self :pointer))
(export '#.(lispify "btSliderConstraint_getUpperLinLimit" 'function))
(declaim (inline #.(lispify "btSliderConstraint_setUpperLinLimit" 'function)))
(cffi:defcfun ("_wrap_btSliderConstraint_setUpperLinLimit" #.(lispify "btSliderConstraint_setUpperLinLimit" 'function)) :void
  (self :pointer)
  (upperLimit :float))

(export '#.(lispify "btSliderConstraint_setUpperLinLimit" 'function))

(declaim (inline #.(lispify "btSliderConstraint_getLowerAngLimit" 'function)))

(cffi:defcfun ("_wrap_btSliderConstraint_getLowerAngLimit" #.(lispify "btSliderConstraint_getLowerAngLimit" 'function)) :float  (self :pointer))
(export '#.(lispify "btSliderConstraint_getLowerAngLimit" 'function))
(declaim (inline #.(lispify "btSliderConstraint_setLowerAngLimit" 'function)))
(cffi:defcfun ("_wrap_btSliderConstraint_setLowerAngLimit" #.(lispify "btSliderConstraint_setLowerAngLimit" 'function)) :void
  (lowerLimit :float))
(export '#.(lispify "btSliderConstraint_setLowerAngLimit" 'function))
(declaim (inline #.(lispify "btSliderConstraint_getUpperAngLimit" 'function)))
(cffi:defcfun ("_wrap_btSliderConstraint_getUpperAngLimit" #.(lispify "btSliderConstraint_getUpperAngLimit" 'function)) :float  (self :pointer))
(export '#.(lispify "btSliderConstraint_getUpperAngLimit" 'function))
(declaim (inline #.(lispify "btSliderConstraint_setUpperAngLimit" 'function)))
(cffi:defcfun ("_wrap_btSliderConstraint_setUpperAngLimit" #.(lispify "btSliderConstraint_setUpperAngLimit" 'function)) :void
  (upperLimit :float))
(export '#.(lispify "btSliderConstraint_setUpperAngLimit" 'function))
(declaim (inline #.(lispify "btSliderConstraint_getUseLinearReferenceFrameA" 'function)))
(cffi:defcfun ("_wrap_btSliderConstraint_getUseLinearReferenceFrameA" #.(lispify "btSliderConstraint_getUseLinearReferenceFrameA" 'function)) :pointer
  (self :pointer))
(export '#.(lispify "btSliderConstraint_getUseLinearReferenceFrameA" 'function))
(declaim (inline #.(lispify "btSliderConstraint_getSoftnessDirLin" 'function)))
(cffi:defcfun ("_wrap_btSliderConstraint_getSoftnessDirLin" #.(lispify "btSliderConstraint_getSoftnessDirLin" 'function)) :float
  (self :pointer))
(export '#.(lispify "btSliderConstraint_getSoftnessDirLin" 'function))
(declaim (inline #.(lispify "btSliderConstraint_getRestitutionDirLin" 'function)))
(cffi:defcfun ("_wrap_btSliderConstraint_getRestitutionDirLin" #.(lispify "btSliderConstraint_getRestitutionDirLin" 'function)) :float
  (self :pointer))
(export '#.(lispify "btSliderConstraint_getRestitutionDirLin" 'function))
(declaim (inline #.(lispify "btSliderConstraint_getDampingDirLin" 'function)))
(cffi:defcfun ("_wrap_btSliderConstraint_getDampingDirLin" #.(lispify "btSliderConstraint_getDampingDirLin" 'function)) :float
  (self :pointer))
(export '#.(lispify "btSliderConstraint_getDampingDirLin" 'function))
(declaim (inline #.(lispify "btSliderConstraint_getSoftnessDirAng" 'function)))
(cffi:defcfun ("_wrap_btSliderConstraint_getSoftnessDirAng" #.(lispify "btSliderConstraint_getSoftnessDirAng" 'function)) :float
  (self :pointer))
(export '#.(lispify "btSliderConstraint_getSoftnessDirAng" 'function))
(declaim (inline #.(lispify "btSliderConstraint_getRestitutionDirAng" 'function)))
(cffi:defcfun ("_wrap_btSliderConstraint_getRestitutionDirAng" #.(lispify "btSliderConstraint_getRestitutionDirAng" 'function)) :float
  (self :pointer))
(export '#.(lispify "btSliderConstraint_getRestitutionDirAng" 'function))
(declaim (inline #.(lispify "btSliderConstraint_getDampingDirAng" 'function)))
(cffi:defcfun ("_wrap_btSliderConstraint_getDampingDirAng" #.(lispify "btSliderConstraint_getDampingDirAng" 'function)) :float
  (self :pointer))
(export '#.(lispify "btSliderConstraint_getDampingDirAng" 'function))
(declaim (inline #.(lispify "btSliderConstraint_getSoftnessLimLin" 'function)))
(cffi:defcfun ("_wrap_btSliderConstraint_getSoftnessLimLin" #.(lispify "btSliderConstraint_getSoftnessLimLin" 'function)) :float
  (self :pointer))
(export '#.(lispify "btSliderConstraint_getSoftnessLimLin" 'function))
(declaim (inline #.(lispify "btSliderConstraint_getRestitutionLimLin" 'function)))
(cffi:defcfun ("_wrap_btSliderConstraint_getRestitutionLimLin" #.(lispify "btSliderConstraint_getRestitutionLimLin" 'function)) :float
  (self :pointer))
(export '#.(lispify "btSliderConstraint_getRestitutionLimLin" 'function))
(declaim (inline #.(lispify "btSliderConstraint_getDampingLimLin" 'function)))
(cffi:defcfun ("_wrap_btSliderConstraint_getDampingLimLin" #.(lispify "btSliderConstraint_getDampingLimLin" 'function)) :float
  (self :pointer))
(export '#.(lispify "btSliderConstraint_getDampingLimLin" 'function))
(declaim (inline #.(lispify "btSliderConstraint_getSoftnessLimAng" 'function)))
(cffi:defcfun ("_wrap_btSliderConstraint_getSoftnessLimAng" #.(lispify "btSliderConstraint_getSoftnessLimAng" 'function)) :float
  (self :pointer))
(export '#.(lispify "btSliderConstraint_getSoftnessLimAng" 'function))
(declaim (inline #.(lispify "btSliderConstraint_getRestitutionLimAng" 'function)))
(cffi:defcfun ("_wrap_btSliderConstraint_getRestitutionLimAng" #.(lispify "btSliderConstraint_getRestitutionLimAng" 'function)) :float  (self :pointer))
(export '#.(lispify "btSliderConstraint_getRestitutionLimAng" 'function))
(declaim (inline #.(lispify "btSliderConstraint_getDampingLimAng" 'function)))
(cffi:defcfun ("_wrap_btSliderConstraint_getDampingLimAng" #.(lispify "btSliderConstraint_getDampingLimAng" 'function)) :float  (self :pointer))
(export '#.(lispify "btSliderConstraint_getDampingLimAng" 'function))
(declaim (inline #.(lispify "btSliderConstraint_getSoftnessOrthoLin" 'function)))
(cffi:defcfun ("_wrap_btSliderConstraint_getSoftnessOrthoLin" #.(lispify "btSliderConstraint_getSoftnessOrthoLin" 'function)) :float
  (self :pointer))
(export '#.(lispify "btSliderConstraint_getSoftnessOrthoLin" 'function))
(declaim (inline #.(lispify "btSliderConstraint_getRestitutionOrthoLin" 'function)))
(cffi:defcfun ("_wrap_btSliderConstraint_getRestitutionOrthoLin" #.(lispify "btSliderConstraint_getRestitutionOrthoLin" 'function)) :float
(self :pointer))
(export '#.(lispify "btSliderConstraint_getRestitutionOrthoLin" 'function))
(declaim (inline #.(lispify "btSliderConstraint_getDampingOrthoLin" 'function)))
(cffi:defcfun ("_wrap_btSliderConstraint_getDampingOrthoLin" #.(lispify "btSliderConstraint_getDampingOrthoLin" 'function)) :float
  (self :pointer))
(export '#.(lispify "btSliderConstraint_getDampingOrthoLin" 'function))
(declaim (inline #.(lispify "btSliderConstraint_getSoftnessOrthoAng" 'function)))
(cffi:defcfun ("_wrap_btSliderConstraint_getSoftnessOrthoAng" #.(lispify "btSliderConstraint_getSoftnessOrthoAng" 'function)) :float  (self :pointer))
(export '#.(lispify "btSliderConstraint_getSoftnessOrthoAng" 'function))
(declaim (inline #.(lispify "btSliderConstraint_getRestitutionOrthoAng" 'function)))
(cffi:defcfun ("_wrap_btSliderConstraint_getRestitutionOrthoAng" #.(lispify "btSliderConstraint_getRestitutionOrthoAng" 'function)) :float  (self :pointer))
(export '#.(lispify "btSliderConstraint_getRestitutionOrthoAng" 'function))
(declaim (inline #.(lispify "btSliderConstraint_getDampingOrthoAng" 'function)))
(cffi:defcfun ("_wrap_btSliderConstraint_getDampingOrthoAng" #.(lispify "btSliderConstraint_getDampingOrthoAng" 'function)) :float
  (self :pointer))
(export '#.(lispify "btSliderConstraint_getDampingOrthoAng" 'function))
(declaim (inline #.(lispify "btSliderConstraint_setSoftnessDirLin" 'function)))
(cffi:defcfun ("_wrap_btSliderConstraint_setSoftnessDirLin" #.(lispify "btSliderConstraint_setSoftnessDirLin" 'function)) :void
  (softnessDirLin :float))
(export '#.(lispify "btSliderConstraint_setSoftnessDirLin" 'function))
(declaim (inline #.(lispify "btSliderConstraint_setRestitutionDirLin" 'function)))
(cffi:defcfun ("_wrap_btSliderConstraint_setRestitutionDirLin" #.(lispify "btSliderConstraint_setRestitutionDirLin" 'function)) :void
  (self :pointer)
  (restitutionDirLin :float))
(export '#.(lispify "btSliderConstraint_setRestitutionDirLin" 'function))
(declaim (inline #.(lispify "btSliderConstraint_setDampingDirLin" 'function)))
(cffi:defcfun ("_wrap_btSliderConstraint_setDampingDirLin" #.(lispify "btSliderConstraint_setDampingDirLin" 'function)) :void
  (self :pointer)
  (dampingDirLin :float))
(export '#.(lispify "btSliderConstraint_setDampingDirLin" 'function))
(declaim (inline #.(lispify "btSliderConstraint_setSoftnessDirAng" 'function)))
(cffi:defcfun ("_wrap_btSliderConstraint_setSoftnessDirAng" #.(lispify "btSliderConstraint_setSoftnessDirAng" 'function)) :void
  (self :pointer)
  (softnessDirAng :float))
(export '#.(lispify "btSliderConstraint_setSoftnessDirAng" 'function))
(declaim (inline #.(lispify "btSliderConstraint_setRestitutionDirAng" 'function)))
(cffi:defcfun ("_wrap_btSliderConstraint_setRestitutionDirAng" #.(lispify "btSliderConstraint_setRestitutionDirAng" 'function)) :void
  (self :pointer)
  (restitutionDirAng :float))
(export '#.(lispify "btSliderConstraint_setRestitutionDirAng" 'function))
(declaim (inline #.(lispify "btSliderConstraint_setDampingDirAng" 'function)))
(cffi:defcfun ("_wrap_btSliderConstraint_setDampingDirAng" #.(lispify "btSliderConstraint_setDampingDirAng" 'function)) :void
  (self :pointer)
  (dampingDirAng :float))
(export '#.(lispify "btSliderConstraint_setDampingDirAng" 'function))
(declaim (inline #.(lispify "btSliderConstraint_setSoftnessLimLin" 'function)))
(cffi:defcfun ("_wrap_btSliderConstraint_setSoftnessLimLin" #.(lispify "btSliderConstraint_setSoftnessLimLin" 'function)) :void
  (self :pointer)
  (softnessLimLin :float))
(export '#.(lispify "btSliderConstraint_setSoftnessLimLin" 'function))
(declaim (inline #.(lispify "btSliderConstraint_setRestitutionLimLin" 'function)))
(cffi:defcfun ("_wrap_btSliderConstraint_setRestitutionLimLin" #.(lispify "btSliderConstraint_setRestitutionLimLin" 'function)) :void
  (self :pointer)
  (restitutionLimLin :float))
(export '#.(lispify "btSliderConstraint_setRestitutionLimLin" 'function))
(declaim (inline #.(lispify "btSliderConstraint_setDampingLimLin" 'function)))
(cffi:defcfun ("_wrap_btSliderConstraint_setDampingLimLin" #.(lispify "btSliderConstraint_setDampingLimLin" 'function)) :void
  (dampingLimLin :float))
(export '#.(lispify "btSliderConstraint_setDampingLimLin" 'function))
(declaim (inline #.(lispify "btSliderConstraint_setSoftnessLimAng" 'function)))
(cffi:defcfun ("_wrap_btSliderConstraint_setSoftnessLimAng" #.(lispify "btSliderConstraint_setSoftnessLimAng" 'function)) :void
  (softnessLimAng :float))
(export '#.(lispify "btSliderConstraint_setSoftnessLimAng" 'function))
(declaim (inline #.(lispify "btSliderConstraint_setRestitutionLimAng" 'function)))
(cffi:defcfun ("_wrap_btSliderConstraint_setRestitutionLimAng" #.(lispify "btSliderConstraint_setRestitutionLimAng" 'function)) :void
  (restitutionLimAng :float))
(export '#.(lispify "btSliderConstraint_setRestitutionLimAng" 'function))
(declaim (inline #.(lispify "btSliderConstraint_setDampingLimAng" 'function)))
(cffi:defcfun ("_wrap_btSliderConstraint_setDampingLimAng" #.(lispify "btSliderConstraint_setDampingLimAng" 'function)) :void
  (self :pointer)
  (dampingLimAng :float))
(export '#.(lispify "btSliderConstraint_setDampingLimAng" 'function))
(declaim (inline #.(lispify "btSliderConstraint_setSoftnessOrthoLin" 'function)))
(cffi:defcfun ("_wrap_btSliderConstraint_setSoftnessOrthoLin" #.(lispify "btSliderConstraint_setSoftnessOrthoLin" 'function)) :void
  (softnessOrthoLin :float))
(export '#.(lispify "btSliderConstraint_setSoftnessOrthoLin" 'function))
(declaim (inline #.(lispify "btSliderConstraint_setRestitutionOrthoLin" 'function)))
(cffi:defcfun ("_wrap_btSliderConstraint_setRestitutionOrthoLin" #.(lispify "btSliderConstraint_setRestitutionOrthoLin" 'function)) :void
  (self :pointer)
  (restitutionOrthoLin :float))
(export '#.(lispify "btSliderConstraint_setRestitutionOrthoLin" 'function))
(declaim (inline #.(lispify "btSliderConstraint_setDampingOrthoLin" 'function)))
(cffi:defcfun ("_wrap_btSliderConstraint_setDampingOrthoLin" #.(lispify "btSliderConstraint_setDampingOrthoLin" 'function)) :void
  (self :pointer)
  (dampingOrthoLin :float))
(export '#.(lispify "btSliderConstraint_setDampingOrthoLin" 'function))
(declaim (inline #.(lispify "btSliderConstraint_setSoftnessOrthoAng" 'function)))
(cffi:defcfun ("_wrap_btSliderConstraint_setSoftnessOrthoAng" #.(lispify "btSliderConstraint_setSoftnessOrthoAng" 'function)) :void
  (self :pointer)
  (softnessOrthoAng :float))
(export '#.(lispify "btSliderConstraint_setSoftnessOrthoAng" 'function))
(declaim (inline #.(lispify "btSliderConstraint_setRestitutionOrthoAng" 'function)))
(cffi:defcfun ("_wrap_btSliderConstraint_setRestitutionOrthoAng" #.(lispify "btSliderConstraint_setRestitutionOrthoAng" 'function)) :void
  (self :pointer)
  (restitutionOrthoAng :float))
(export '#.(lispify "btSliderConstraint_setRestitutionOrthoAng" 'function))
(declaim (inline #.(lispify "btSliderConstraint_setDampingOrthoAng" 'function)))
(cffi:defcfun ("_wrap_btSliderConstraint_setDampingOrthoAng" #.(lispify "btSliderConstraint_setDampingOrthoAng" 'function)) :void
  (self :pointer)
  (dampingOrthoAng :float))
(export '#.(lispify "btSliderConstraint_setDampingOrthoAng" 'function))
(declaim (inline #.(lispify "btSliderConstraint_setPoweredLinMotor" 'function)))
(cffi:defcfun ("_wrap_btSliderConstraint_setPoweredLinMotor" #.(lispify "btSliderConstraint_setPoweredLinMotor" 'function)) :void
  (self :pointer)
  (onOff :pointer))
(export '#.(lispify "btSliderConstraint_setPoweredLinMotor" 'function))
(declaim (inline #.(lispify "btSliderConstraint_getPoweredLinMotor" 'function)))
(cffi:defcfun ("_wrap_btSliderConstraint_getPoweredLinMotor" #.(lispify "btSliderConstraint_getPoweredLinMotor" 'function)) :pointer  (self :pointer))
(export '#.(lispify "btSliderConstraint_getPoweredLinMotor" 'function))
(declaim (inline #.(lispify "btSliderConstraint_setTargetLinMotorVelocity" 'function)))
(cffi:defcfun ("_wrap_btSliderConstraint_setTargetLinMotorVelocity" #.(lispify "btSliderConstraint_setTargetLinMotorVelocity" 'function)) :void
  (targetLinMotorVelocity :float))
(export '#.(lispify "btSliderConstraint_setTargetLinMotorVelocity" 'function))
(declaim (inline #.(lispify "btSliderConstraint_getTargetLinMotorVelocity" 'function)))
(cffi:defcfun ("_wrap_btSliderConstraint_getTargetLinMotorVelocity" #.(lispify "btSliderConstraint_getTargetLinMotorVelocity" 'function)) :float  (self :pointer))
(export '#.(lispify "btSliderConstraint_getTargetLinMotorVelocity" 'function))
(declaim (inline #.(lispify "btSliderConstraint_setMaxLinMotorForce" 'function)))
(cffi:defcfun ("_wrap_btSliderConstraint_setMaxLinMotorForce" #.(lispify "btSliderConstraint_setMaxLinMotorForce" 'function)) :void
  (self :pointer)
  (maxLinMotorForce :float))
(export '#.(lispify "btSliderConstraint_setMaxLinMotorForce" 'function))
(declaim (inline #.(lispify "btSliderConstraint_getMaxLinMotorForce" 'function)))
(cffi:defcfun ("_wrap_btSliderConstraint_getMaxLinMotorForce" #.(lispify "btSliderConstraint_getMaxLinMotorForce" 'function)) :float  (self :pointer))
(export '#.(lispify "btSliderConstraint_getMaxLinMotorForce" 'function))
(declaim (inline #.(lispify "btSliderConstraint_setPoweredAngMotor" 'function)))
(cffi:defcfun ("_wrap_btSliderConstraint_setPoweredAngMotor" #.(lispify "btSliderConstraint_setPoweredAngMotor" 'function)) :void
  (onOff :pointer))
(export '#.(lispify "btSliderConstraint_setPoweredAngMotor" 'function))
(declaim (inline #.(lispify "btSliderConstraint_getPoweredAngMotor" 'function)))
(cffi:defcfun ("_wrap_btSliderConstraint_getPoweredAngMotor" #.(lispify "btSliderConstraint_getPoweredAngMotor" 'function)) :pointer  (self :pointer))
(export '#.(lispify "btSliderConstraint_getPoweredAngMotor" 'function))
(declaim (inline #.(lispify "btSliderConstraint_setTargetAngMotorVelocity" 'function)))
(cffi:defcfun ("_wrap_btSliderConstraint_setTargetAngMotorVelocity" #.(lispify "btSliderConstraint_setTargetAngMotorVelocity" 'function)) :void
  (targetAngMotorVelocity :float))
(export '#.(lispify "btSliderConstraint_setTargetAngMotorVelocity" 'function))
(declaim (inline #.(lispify "btSliderConstraint_getTargetAngMotorVelocity" 'function)))
(cffi:defcfun ("_wrap_btSliderConstraint_getTargetAngMotorVelocity" #.(lispify "btSliderConstraint_getTargetAngMotorVelocity" 'function)) :float
  (self :pointer))

(export '#.(lispify "btSliderConstraint_getTargetAngMotorVelocity" 'function))

(declaim (inline #.(lispify "btSliderConstraint_setMaxAngMotorForce" 'function)))

(cffi:defcfun ("_wrap_btSliderConstraint_setMaxAngMotorForce" #.(lispify "btSliderConstraint_setMaxAngMotorForce" 'function)) :void
  (maxAngMotorForce :float))
(export '#.(lispify "btSliderConstraint_setMaxAngMotorForce" 'function))
(declaim (inline #.(lispify "btSliderConstraint_getMaxAngMotorForce" 'function)))
(cffi:defcfun ("_wrap_btSliderConstraint_getMaxAngMotorForce" #.(lispify "btSliderConstraint_getMaxAngMotorForce" 'function)) :float  (self :pointer))
(export '#.(lispify "btSliderConstraint_getMaxAngMotorForce" 'function))
(declaim (inline #.(lispify "btSliderConstraint_getLinearPos" 'function)))
(cffi:defcfun ("_wrap_btSliderConstraint_getLinearPos" #.(lispify "btSliderConstraint_getLinearPos" 'function)) :float
  (self :pointer))
(export '#.(lispify "btSliderConstraint_getLinearPos" 'function))
(declaim (inline #.(lispify "btSliderConstraint_getAngularPos" 'function)))
(cffi:defcfun ("_wrap_btSliderConstraint_getAngularPos" #.(lispify "btSliderConstraint_getAngularPos" 'function)) :float
  (self :pointer))
(export '#.(lispify "btSliderConstraint_getAngularPos" 'function))
(declaim (inline #.(lispify "btSliderConstraint_getSolveLinLimit" 'function)))
(cffi:defcfun ("_wrap_btSliderConstraint_getSolveLinLimit" #.(lispify "btSliderConstraint_getSolveLinLimit" 'function)) :pointer  (self :pointer))
(export '#.(lispify "btSliderConstraint_getSolveLinLimit" 'function))
(declaim (inline #.(lispify "btSliderConstraint_getLinDepth" 'function)))
(cffi:defcfun ("_wrap_btSliderConstraint_getLinDepth" #.(lispify "btSliderConstraint_getLinDepth" 'function)) :float  (self :pointer))
(export '#.(lispify "btSliderConstraint_getLinDepth" 'function))
(declaim (inline #.(lispify "btSliderConstraint_getSolveAngLimit" 'function)))
(cffi:defcfun ("_wrap_btSliderConstraint_getSolveAngLimit" #.(lispify "btSliderConstraint_getSolveAngLimit" 'function)) :pointer
  (self :pointer))
(export '#.(lispify "btSliderConstraint_getSolveAngLimit" 'function))
(declaim (inline #.(lispify "btSliderConstraint_getAngDepth" 'function)))
(cffi:defcfun ("_wrap_btSliderConstraint_getAngDepth" #.(lispify "btSliderConstraint_getAngDepth" 'function)) :float  (self :pointer))
(export '#.(lispify "btSliderConstraint_getAngDepth" 'function))
(declaim (inline #.(lispify "btSliderConstraint_calculateTransforms" 'function)))
(cffi:defcfun ("_wrap_btSliderConstraint_calculateTransforms" #.(lispify "btSliderConstraint_calculateTransforms" 'function)) :void
  (transA :pointer)
  (transB :pointer))
(export '#.(lispify "btSliderConstraint_calculateTransforms" 'function))
(declaim (inline #.(lispify "btSliderConstraint_testLinLimits" 'function)))
(cffi:defcfun ("_wrap_btSliderConstraint_testLinLimits" #.(lispify "btSliderConstraint_testLinLimits" 'function)) :void  (self :pointer))
(export '#.(lispify "btSliderConstraint_testLinLimits" 'function))
(declaim (inline #.(lispify "btSliderConstraint_testAngLimits" 'function)))
(cffi:defcfun ("_wrap_btSliderConstraint_testAngLimits" #.(lispify "btSliderConstraint_testAngLimits" 'function)) :void
  (self :pointer))
(export '#.(lispify "btSliderConstraint_testAngLimits" 'function))
(declaim (inline #.(lispify "btSliderConstraint_getAncorInA" 'function)))
(cffi:defcfun ("_wrap_btSliderConstraint_getAncorInA" #.(lispify "btSliderConstraint_getAncorInA" 'function)) :pointer  (self :pointer))
(export '#.(lispify "btSliderConstraint_getAncorInA" 'function))
(declaim (inline #.(lispify "btSliderConstraint_getAncorInB" 'function)))
(cffi:defcfun ("_wrap_btSliderConstraint_getAncorInB" #.(lispify "btSliderConstraint_getAncorInB" 'function)) :pointer  (self :pointer))
(export '#.(lispify "btSliderConstraint_getAncorInB" 'function))
(declaim (inline #.(lispify "btSliderConstraint_getUseFrameOffset" 'function)))
(cffi:defcfun ("_wrap_btSliderConstraint_getUseFrameOffset" #.(lispify "btSliderConstraint_getUseFrameOffset" 'function)) :pointer  (self :pointer))
(export '#.(lispify "btSliderConstraint_getUseFrameOffset" 'function))
(declaim (inline #.(lispify "btSliderConstraint_setUseFrameOffset" 'function)))
(cffi:defcfun ("_wrap_btSliderConstraint_setUseFrameOffset" #.(lispify "btSliderConstraint_setUseFrameOffset" 'function)) :void
  (self :pointer)
  (frameOffsetOnOff :pointer))
(export '#.(lispify "btSliderConstraint_setUseFrameOffset" 'function))
(declaim (inline #.(lispify "btSliderConstraint_setFrames" 'function)))
(cffi:defcfun ("_wrap_btSliderConstraint_setFrames" #.(lispify "btSliderConstraint_setFrames" 'function)) :void
  (frameA :pointer)
  (frameB :pointer))
(export '#.(lispify "btSliderConstraint_setFrames" 'function))

(declaim (inline #.(lispify "btSliderConstraint_calculateSerializeBufferSize" 'function)))
(cffi:defcfun ("_wrap_btSliderConstraint_calculateSerializeBufferSize" #.(lispify "btSliderConstraint_calculateSerializeBufferSize" 'function)) :int  (self :pointer))
(export '#.(lispify "btSliderConstraint_calculateSerializeBufferSize" 'function))
(declaim (inline #.(lispify "btSliderConstraint_serialize" 'function)))
(cffi:defcfun ("_wrap_btSliderConstraint_serialize" #.(lispify "btSliderConstraint_serialize" 'function)) :string
  (dataBuffer :pointer)
  (serializer :pointer))
(export '#.(lispify "btSliderConstraint_serialize" 'function))
(declaim (inline #.(lispify "delete_btSliderConstraint" 'function)))
(cffi:defcfun ("_wrap_delete_btSliderConstraint" #.(lispify "delete_btSliderConstraint" 'function)) :void
  (self :pointer))
(export '#.(lispify "delete_btSliderConstraint" 'function))
(cffi:defcstruct #.(lispify "btSliderConstraintData" 'classname)
                 (#.(lispify "m_typeConstraintData" 'slotname) (:pointer (:struct #.(lispify "btTypedConstraintData" 'classname))))
                 (#.(lispify "m_rbAFrame" 'slotname) (:pointer (:struct #.(lispify "btTransformFloatData" 'classname))))
                 (#.(lispify "m_rbBFrame" 'slotname) (:pointer (:struct #.(lispify "btTransformFloatData" 'classname))))
	(#.(lispify "m_linearUpperLimit" 'slotname) :float)
	(#.(lispify "m_linearLowerLimit" 'slotname) :float)
	(#.(lispify "m_angularUpperLimit" 'slotname) :float)
	(#.(lispify "m_angularLowerLimit" 'slotname) :float)
	(#.(lispify "m_useLinearReferenceFrameA" 'slotname) :int)
	(#.(lispify "m_useOffsetForConstraintFrame" 'slotname) :int))
(export '#.(lispify "btSliderConstraintData" 'classname))
(export '#.(lispify "m_typeConstraintData" 'slotname))
(export '#.(lispify "m_rbAFrame" 'slotname))
(export '#.(lispify "m_rbBFrame" 'slotname))
(export '#.(lispify "m_linearUpperLimit" 'slotname))
(export '#.(lispify "m_linearLowerLimit" 'slotname))
(export '#.(lispify "m_angularUpperLimit" 'slotname))
(export '#.(lispify "m_angularLowerLimit" 'slotname))
(export '#.(lispify "m_useLinearReferenceFrameA" 'slotname))
(export '#.(lispify "m_useOffsetForConstraintFrame" 'slotname))
(cffi:defcstruct #.(lispify "btSliderConstraintDoubleData" 'classname)
                 (#.(lispify "m_typeConstraintData" 'slotname) (:pointer (:struct #. (lispify "btTypedConstraintDoubleData" 'classname))))
                 (#.(lispify "m_rbAFrame" 'slotname) (:pointer (:struct transform-double-data)))
                 (#.(lispify "m_rbBFrame" 'slotname) (:pointer (:struct transform-double-data)))
	(#.(lispify "m_linearUpperLimit" 'slotname) :double)
	(#.(lispify "m_linearLowerLimit" 'slotname) :double)
	(#.(lispify "m_angularUpperLimit" 'slotname) :double)
	(#.(lispify "m_angularLowerLimit" 'slotname) :double)
	(#.(lispify "m_useLinearReferenceFrameA" 'slotname) :int)
	(#.(lispify "m_useOffsetForConstraintFrame" 'slotname) :int))
(export '#.(lispify "btSliderConstraintDoubleData" 'classname))
(export '#.(lispify "m_typeConstraintData" 'slotname))
(export '#.(lispify "m_rbAFrame" 'slotname))
(export '#.(lispify "m_rbBFrame" 'slotname))
(export '#.(lispify "m_linearUpperLimit" 'slotname))
(export '#.(lispify "m_linearLowerLimit" 'slotname))
(export '#.(lispify "m_angularUpperLimit" 'slotname))
(export '#.(lispify "m_angularLowerLimit" 'slotname))
(export '#.(lispify "m_useLinearReferenceFrameA" 'slotname))
(export '#.(lispify "m_useOffsetForConstraintFrame" 'slotname))
(define-constant #.(lispify "btGeneric6DofSpringConstraintDataName" 'constant) "btGeneric6DofSpringConstraintData" :test 'equal)
(export '#.(lispify "btGeneric6DofSpringConstraintDataName" 'constant))
(declaim (inline #.(lispify "btGeneric6DofSpringConstraint_makeCPlusPlusInstance" 'function)))
(cffi:defcfun ("_wrap_btGeneric6DofSpringConstraint_makeCPlusPlusInstance__SWIG_0" #.(lispify "btGeneric6DofSpringConstraint_makeCPlusPlusInstance" 'function)) :pointer
  (sizeInBytes :pointer))
(export '#.(lispify "btGeneric6DofSpringConstraint_makeCPlusPlusInstance" 'function))
(declaim (inline #.(lispify "btGeneric6DofSpringConstraint_deleteCPlusPlusInstance" 'function)))
(cffi:defcfun ("_wrap_btGeneric6DofSpringConstraint_deleteCPlusPlusInstance__SWIG_0" #.(lispify "btGeneric6DofSpringConstraint_deleteCPlusPlusInstance" 'function)) :void
  (self :pointer)
  (ptr :pointer))
(export '#.(lispify "btGeneric6DofSpringConstraint_deleteCPlusPlusInstance" 'function))
#+ (or)
(progn 
        (declaim (inline #.(lispify "btGeneric6DofSpringConstraint_makeCPlusPlusInstance" 'function)))
        (cffi:defcfun ("_wrap_btGeneric6DofSpringConstraint_makeCPlusPlusInstance__SWIG_1" #.(lispify "btGeneric6DofSpringConstraint_makeCPlusPlusInstance" 'function)) :pointer
          (arg1 :pointer)
          (ptr :pointer))
        (export '#.(lispify "btGeneric6DofSpringConstraint_makeCPlusPlusInstance" 'function))
        (declaim (inline #.(lispify "btGeneric6DofSpringConstraint_deleteCPlusPlusInstance" 'function)))
        (cffi:defcfun ("_wrap_btGeneric6DofSpringConstraint_deleteCPlusPlusInstance__SWIG_1" #.(lispify "btGeneric6DofSpringConstraint_deleteCPlusPlusInstance" 'function)) :void
          (self :pointer)
          (arg1 :pointer)
          (arg2 :pointer))
        (export '#.(lispify "btGeneric6DofSpringConstraint_deleteCPlusPlusInstance" 'function)))
(declaim (inline #.(lispify "btGeneric6DofSpringConstraint_makeCPlusArray" 'function)))
(cffi:defcfun ("_wrap_btGeneric6DofSpringConstraint_makeCPlusArray__SWIG_0" #.(lispify "btGeneric6DofSpringConstraint_makeCPlusArray" 'function)) :pointer
  (sizeInBytes :pointer))
(export '#.(lispify "btGeneric6DofSpringConstraint_makeCPlusArray" 'function))
(declaim (inline #.(lispify "btGeneric6DofSpringConstraint_deleteCPlusArray" 'function)))
(cffi:defcfun ("_wrap_btGeneric6DofSpringConstraint_deleteCPlusArray__SWIG_0" #.(lispify "btGeneric6DofSpringConstraint_deleteCPlusArray" 'function)) :void
  (self :pointer)
  (ptr :pointer))
(export '#.(lispify "btGeneric6DofSpringConstraint_deleteCPlusArray" 'function))
#+ (or)
(progn
        (declaim (inline #.(lispify "btGeneric6DofSpringConstraint_makeCPlusArray" 'function)))
        (cffi:defcfun ("_wrap_btGeneric6DofSpringConstraint_makeCPlusArray__SWIG_1" #.(lispify "btGeneric6DofSpringConstraint_makeCPlusArray" 'function)) :pointer
          (self :pointer)
          (arg1 :pointer)
          (ptr :pointer))
        (export '#.(lispify "btGeneric6DofSpringConstraint_makeCPlusArray" 'function))
        (declaim (inline #.(lispify "btGeneric6DofSpringConstraint_deleteCPlusArray" 'function)))
        (cffi:defcfun ("_wrap_btGeneric6DofSpringConstraint_deleteCPlusArray__SWIG_1" #.(lispify "btGeneric6DofSpringConstraint_deleteCPlusArray" 'function)) :void
          (arg1 :pointer)
          (arg2 :pointer))
        (export '#.(lispify "btGeneric6DofSpringConstraint_deleteCPlusArray" 'function)))
(declaim (inline #.(lispify "new_btGeneric6DofSpringConstraint" 'function)))
(cffi:defcfun ("_wrap_new_btGeneric6DofSpringConstraint__SWIG_0" #.(lispify "new_btGeneric6DofSpringConstraint" 'function)) :pointer
  (rbA :pointer)
  (rbB :pointer)
  (frameInA :pointer)
  (frameInB :pointer)
  (useLinearReferenceFrameA :pointer))
(export '#.(lispify "new_btGeneric6DofSpringConstraint" 'function))
(declaim (inline #.(lispify "new_btGeneric6DofSpringConstraint" 'function)))
(cffi:defcfun ("_wrap_new_btGeneric6DofSpringConstraint__SWIG_1" 
               MAKE-GENERIC-6-DOF-SPRING-CONSTRAINT/with-rb-b&frame-in-b/using-linear-reference-frame-b)
    :pointer
  (rbB :pointer)
  (frameInB :pointer)
  (useLinearReferenceFrameB :pointer))
(export '#.(lispify "new_btGeneric6DofSpringConstraint" 'function))
(declaim (inline #.(lispify "btGeneric6DofSpringConstraint_enableSpring" 'function)))
(cffi:defcfun ("_wrap_btGeneric6DofSpringConstraint_enableSpring" #.(lispify "btGeneric6DofSpringConstraint_enableSpring" 'function)) :void
  (index :int)
  (onOff :pointer))
(export '#.(lispify "btGeneric6DofSpringConstraint_enableSpring" 'function))
(declaim (inline #.(lispify "btGeneric6DofSpringConstraint_setStiffness" 'function)))
(cffi:defcfun ("_wrap_btGeneric6DofSpringConstraint_setStiffness" #.(lispify "btGeneric6DofSpringConstraint_setStiffness" 'function)) :void
  (index :int)
  (stiffness :float))
(export '#.(lispify "btGeneric6DofSpringConstraint_setStiffness" 'function))
(declaim (inline #.(lispify "btGeneric6DofSpringConstraint_setDamping" 'function)))
(cffi:defcfun ("_wrap_btGeneric6DofSpringConstraint_setDamping" #.(lispify "btGeneric6DofSpringConstraint_setDamping" 'function)) :void
  (self :pointer)
  (index :int)
  (damping :float))
(export '#.(lispify "btGeneric6DofSpringConstraint_setDamping" 'function))
(declaim (inline #.(lispify "btGeneric6DofSpringConstraint_setEquilibriumPoint" 'function)))
(cffi:defcfun ("_wrap_btGeneric6DofSpringConstraint_setEquilibriumPoint__SWIG_0" 
               #.(lispify "btGeneric6DofSpringConstraint_setEquilibriumPoint" 'function)) :void
  (self :pointer))
(export '#.(lispify "btGeneric6DofSpringConstraint_setEquilibriumPoint" 'function))
(declaim (inline #.(lispify "btGeneric6DofSpringConstraint_setEquilibriumPoint" 'function)))
(cffi:defcfun ("_wrap_btGeneric6DofSpringConstraint_setEquilibriumPoint__SWIG_1" 
               GENERIC-6-DOF-SPRING-CONSTRAINT/SET-EQUILIBRIUM-POINT/int-index) :void
  (self :pointer)
  (index :int))
(export '#.(lispify "btGeneric6DofSpringConstraint_setEquilibriumPoint" 'function))
(declaim (inline #.(lispify "btGeneric6DofSpringConstraint_setEquilibriumPoint" 'function)))
(cffi:defcfun ("_wrap_btGeneric6DofSpringConstraint_setEquilibriumPoint__SWIG_2"
               GENERIC-6-DOF-SPRING-CONSTRAINT/SET-EQUILIBRIUM-POINT/float-val) :void
  (index :int)
  (val :float))
(export '#.(lispify "btGeneric6DofSpringConstraint_setEquilibriumPoint" 'function))
(declaim (inline #.(lispify "btGeneric6DofSpringConstraint_setAxis" 'function)))
(cffi:defcfun ("_wrap_btGeneric6DofSpringConstraint_setAxis" #.(lispify "btGeneric6DofSpringConstraint_setAxis" 'function)) :void
  (axis1 :pointer)
  (axis2 :pointer))
(export '#.(lispify "btGeneric6DofSpringConstraint_setAxis" 'function))
(declaim (inline #.(lispify "btGeneric6DofSpringConstraint_getInfo2" 'function)))
(cffi:defcfun ("_wrap_btGeneric6DofSpringConstraint_getInfo2" #.(lispify "btGeneric6DofSpringConstraint_getInfo2" 'function)) :void
  (self :pointer)
  (info :pointer))
(export '#.(lispify "btGeneric6DofSpringConstraint_getInfo2" 'function))
(declaim (inline #.(lispify "btGeneric6DofSpringConstraint_calculateSerializeBufferSize" 'function)))
(cffi:defcfun ("_wrap_btGeneric6DofSpringConstraint_calculateSerializeBufferSize" #.(lispify "btGeneric6DofSpringConstraint_calculateSerializeBufferSize" 'function)) :int
  (self :pointer))
(export '#.(lispify "btGeneric6DofSpringConstraint_calculateSerializeBufferSize" 'function))
(declaim (inline #.(lispify "btGeneric6DofSpringConstraint_serialize" 'function)))
(cffi:defcfun ("_wrap_btGeneric6DofSpringConstraint_serialize" #.(lispify "btGeneric6DofSpringConstraint_serialize" 'function)) :string
  (self :pointer)
  (dataBuffer :pointer)
  (serializer :pointer))
(export '#.(lispify "btGeneric6DofSpringConstraint_serialize" 'function))
(declaim (inline #.(lispify "delete_btGeneric6DofSpringConstraint" 'function)))
(cffi:defcfun ("_wrap_delete_btGeneric6DofSpringConstraint" #.(lispify "delete_btGeneric6DofSpringConstraint" 'function)) :void
  (self :pointer))
(export '#.(lispify "delete_btGeneric6DofSpringConstraint" 'function))
(cffi:defcstruct #.(lispify "btGeneric6DofSpringConstraintData" 'classname)
                 (#.(lispify "m_6dofData" 'slotname) (:pointer (:struct #.(lispify "btGeneric6DofConstraintData" 'classname))))
	(#.(lispify "m_springEnabled" 'slotname) :pointer)
	(#.(lispify "m_equilibriumPoint" 'slotname) :pointer)
	(#.(lispify "m_springStiffness" 'slotname) :pointer)
	(#.(lispify "m_springDamping" 'slotname) :pointer))
(export '#.(lispify "btGeneric6DofSpringConstraintData" 'classname))
(export '#.(lispify "m_6dofData" 'slotname))
(export '#.(lispify "m_springEnabled" 'slotname))
(export '#.(lispify "m_equilibriumPoint" 'slotname))
(export '#.(lispify "m_springStiffness" 'slotname))
(export '#.(lispify "m_springDamping" 'slotname))
(cffi:defcstruct #.(lispify "btGeneric6DofSpringConstraintDoubleData2" 'classname)
                 (#.(lispify "m_6dofData" 'slotname)
                    (:pointer (:struct #. (lispify "btGeneric6DofConstraintDoubleData2" 'classname))))
	(#.(lispify "m_springEnabled" 'slotname) :pointer)
	(#.(lispify "m_equilibriumPoint" 'slotname) :pointer)
	(#.(lispify "m_springStiffness" 'slotname) :pointer)
	(#.(lispify "m_springDamping" 'slotname) :pointer))
(export '#.(lispify "btGeneric6DofSpringConstraintDoubleData2" 'classname))
(export '#.(lispify "m_6dofData" 'slotname))
(export '#.(lispify "m_springEnabled" 'slotname))
(export '#.(lispify "m_equilibriumPoint" 'slotname))
(export '#.(lispify "m_springStiffness" 'slotname))
(export '#.(lispify "m_springDamping" 'slotname))
(declaim (inline #.(lispify "btUniversalConstraint_makeCPlusPlusInstance" 'function)))
(cffi:defcfun ("_wrap_btUniversalConstraint_makeCPlusPlusInstance__SWIG_0" #.(lispify "btUniversalConstraint_makeCPlusPlusInstance" 'function)) :pointer
  (self :pointer)
  (sizeInBytes :pointer))
(export '#.(lispify "btUniversalConstraint_makeCPlusPlusInstance" 'function))
(declaim (inline #.(lispify "btUniversalConstraint_deleteCPlusPlusInstance" 'function)))
(cffi:defcfun ("_wrap_btUniversalConstraint_deleteCPlusPlusInstance__SWIG_0" #.(lispify "btUniversalConstraint_deleteCPlusPlusInstance" 'function)) :void
  (self :pointer)
  (ptr :pointer))
(export '#.(lispify "btUniversalConstraint_deleteCPlusPlusInstance" 'function))
#+ (or)
(progn 
  (declaim (inline #.(lispify "btUniversalConstraint_makeCPlusPlusInstance" 'function)))
 (cffi:defcfun ("_wrap_btUniversalConstraint_makeCPlusPlusInstance__SWIG_1" #.(lispify "btUniversalConstraint_makeCPlusPlusInstance" 'function)) :pointer
   (self :pointer)
   (arg1 :pointer)
   (ptr :pointer))
 (export '#.(lispify "btUniversalConstraint_makeCPlusPlusInstance" 'function))
 (declaim (inline #.(lispify "btUniversalConstraint_deleteCPlusPlusInstance" 'function)))
 (cffi:defcfun ("_wrap_btUniversalConstraint_deleteCPlusPlusInstance__SWIG_1" #.(lispify "btUniversalConstraint_deleteCPlusPlusInstance" 'function)) :void
   (self :pointer)
   (arg1 :pointer)
   (arg2 :pointer))
 (export '#.(lispify "btUniversalConstraint_deleteCPlusPlusInstance" 'function)))
(declaim (inline #.(lispify "btUniversalConstraint_makeCPlusArray" 'function)))
(cffi:defcfun ("_wrap_btUniversalConstraint_makeCPlusArray__SWIG_0" #.(lispify "btUniversalConstraint_makeCPlusArray" 'function)) :pointer
  (self :pointer)
  (sizeInBytes :pointer))
(export '#.(lispify "btUniversalConstraint_makeCPlusArray" 'function))
(declaim (inline #.(lispify "btUniversalConstraint_deleteCPlusArray" 'function)))
(cffi:defcfun ("_wrap_btUniversalConstraint_deleteCPlusArray__SWIG_0" #.(lispify "btUniversalConstraint_deleteCPlusArray" 'function)) :void
  (self :pointer)
  (ptr :pointer))
(export '#.(lispify "btUniversalConstraint_deleteCPlusArray" 'function))
#+ (or)
(progn 
        (declaim (inline #.(lispify "btUniversalConstraint_makeCPlusArray" 'function)))
        (cffi:defcfun ("_wrap_btUniversalConstraint_makeCPlusArray__SWIG_1" #.(lispify "btUniversalConstraint_makeCPlusArray" 'function)) :pointer
          (self :pointer)
          (arg1 :pointer)
          (ptr :pointer))
        (export '#.(lispify "btUniversalConstraint_makeCPlusArray" 'function))
        (declaim (inline #.(lispify "btUniversalConstraint_deleteCPlusArray" 'function)))
        (cffi:defcfun ("_wrap_btUniversalConstraint_deleteCPlusArray__SWIG_1" #.(lispify "btUniversalConstraint_deleteCPlusArray" 'function)) :void
          (self :pointer)
          (arg1 :pointer)
          (arg2 :pointer))
        (export '#.(lispify "btUniversalConstraint_deleteCPlusArray" 'function)))
(declaim (inline #.(lispify "new_btUniversalConstraint" 'function)))
(cffi:defcfun ("_wrap_new_btUniversalConstraint" #.(lispify "new_btUniversalConstraint" 'function)) :pointer
  (rbA :pointer)
  (rbB :pointer)
  (anchor :pointer)
  (axis1 :pointer)
  (axis2 :pointer))
(export '#.(lispify "new_btUniversalConstraint" 'function))
(declaim (inline #.(lispify "btUniversalConstraint_getAnchor" 'function)))
(cffi:defcfun ("_wrap_btUniversalConstraint_getAnchor" #.(lispify "btUniversalConstraint_getAnchor" 'function)) :pointer
  (self :pointer))
(export '#.(lispify "btUniversalConstraint_getAnchor" 'function))
(declaim (inline #.(lispify "btUniversalConstraint_getAnchor2" 'function)))
(cffi:defcfun ("_wrap_btUniversalConstraint_getAnchor2" #.(lispify "btUniversalConstraint_getAnchor2" 'function)) :pointer
  (self :pointer))
(export '#.(lispify "btUniversalConstraint_getAnchor2" 'function))
(declaim (inline #.(lispify "btUniversalConstraint_getAxis1" 'function)))
(cffi:defcfun ("_wrap_btUniversalConstraint_getAxis1" #.(lispify "btUniversalConstraint_getAxis1" 'function)) :pointer
  (self :pointer))
(export '#.(lispify "btUniversalConstraint_getAxis1" 'function))
(declaim (inline #.(lispify "btUniversalConstraint_getAxis2" 'function)))
(cffi:defcfun ("_wrap_btUniversalConstraint_getAxis2" #.(lispify "btUniversalConstraint_getAxis2" 'function)) :pointer
  (self :pointer))
(export '#.(lispify "btUniversalConstraint_getAxis2" 'function))
(declaim (inline #.(lispify "btUniversalConstraint_getAngle1" 'function)))
(cffi:defcfun ("_wrap_btUniversalConstraint_getAngle1" #.(lispify "btUniversalConstraint_getAngle1" 'function)) :float
  (self :pointer))
(export '#.(lispify "btUniversalConstraint_getAngle1" 'function))
(declaim (inline #.(lispify "btUniversalConstraint_getAngle2" 'function)))

(cffi:defcfun ("_wrap_btUniversalConstraint_getAngle2" #.(lispify "btUniversalConstraint_getAngle2" 'function)) :float  (self :pointer))
(export '#.(lispify "btUniversalConstraint_getAngle2" 'function))
(declaim (inline #.(lispify "btUniversalConstraint_setUpperLimit" 'function)))
(cffi:defcfun ("_wrap_btUniversalConstraint_setUpperLimit" #.(lispify "btUniversalConstraint_setUpperLimit" 'function)) :void
  (ang1max :float)
  (ang2max :float))
(export '#.(lispify "btUniversalConstraint_setUpperLimit" 'function))
(declaim (inline #.(lispify "btUniversalConstraint_setLowerLimit" 'function)))
(cffi:defcfun ("_wrap_btUniversalConstraint_setLowerLimit" #.(lispify "btUniversalConstraint_setLowerLimit" 'function)) :void
  (ang1min :float)
  (ang2min :float))
(export '#.(lispify "btUniversalConstraint_setLowerLimit" 'function))
(declaim (inline #.(lispify "btUniversalConstraint_setAxis" 'function)))
(cffi:defcfun ("_wrap_btUniversalConstraint_setAxis" #.(lispify "btUniversalConstraint_setAxis" 'function)) :void
  (axis1 :pointer)
  (axis2 :pointer))
(export '#.(lispify "btUniversalConstraint_setAxis" 'function))
(declaim (inline #.(lispify "delete_btUniversalConstraint" 'function)))
(cffi:defcfun ("_wrap_delete_btUniversalConstraint" #.(lispify "delete_btUniversalConstraint" 'function)) :void  (self :pointer))
(export '#.(lispify "delete_btUniversalConstraint" 'function))
(declaim (inline #.(lispify "btHinge2Constraint_makeCPlusPlusInstance" 'function)))
(cffi:defcfun ("_wrap_btHinge2Constraint_makeCPlusPlusInstance__SWIG_0" #.(lispify "btHinge2Constraint_makeCPlusPlusInstance" 'function)) :pointer
  (sizeInBytes :pointer))
(export '#.(lispify "btHinge2Constraint_makeCPlusPlusInstance" 'function))
(declaim (inline #.(lispify "btHinge2Constraint_deleteCPlusPlusInstance" 'function)))
(cffi:defcfun ("_wrap_btHinge2Constraint_deleteCPlusPlusInstance__SWIG_0" #.(lispify "btHinge2Constraint_deleteCPlusPlusInstance" 'function)) :void
  (ptr :pointer))
(export '#.(lispify "btHinge2Constraint_deleteCPlusPlusInstance" 'function))
#+ (or)
(progn 
        (declaim (inline #.(lispify "btHinge2Constraint_makeCPlusPlusInstance" 'function)))
        (cffi:defcfun ("_wrap_btHinge2Constraint_makeCPlusPlusInstance__SWIG_1" #.(lispify "btHinge2Constraint_makeCPlusPlusInstance" 'function)) :pointer
          (arg1 :pointer)
          (ptr :pointer))
        (export '#.(lispify "btHinge2Constraint_makeCPlusPlusInstance" 'function)))
#+ (or)
(progn
        (declaim (inline #.(lispify "btHinge2Constraint_deleteCPlusPlusInstance" 'function)))
        (cffi:defcfun ("_wrap_btHinge2Constraint_deleteCPlusPlusInstance__SWIG_1" #.(lispify "btHinge2Constraint_deleteCPlusPlusInstance" 'function)) :void
          (arg1 :pointer)
          (arg2 :pointer))
        (export '#.(lispify "btHinge2Constraint_deleteCPlusPlusInstance" 'function)))
(declaim (inline #.(lispify "btHinge2Constraint_makeCPlusArray" 'function)))
(cffi:defcfun ("_wrap_btHinge2Constraint_makeCPlusArray__SWIG_0" #.(lispify "btHinge2Constraint_makeCPlusArray" 'function)) :pointer
  (sizeInBytes :pointer))
(export '#.(lispify "btHinge2Constraint_makeCPlusArray" 'function))
(declaim (inline #.(lispify "btHinge2Constraint_deleteCPlusArray" 'function)))
(cffi:defcfun ("_wrap_btHinge2Constraint_deleteCPlusArray__SWIG_0" #.(lispify "btHinge2Constraint_deleteCPlusArray" 'function)) :void
  (ptr :pointer))
(export '#.(lispify "btHinge2Constraint_deleteCPlusArray" 'function))
#+ (or)
(progn 
  (declaim (inline #.(lispify "btHinge2Constraint_makeCPlusArray" 'function)))
 (cffi:defcfun ("_wrap_btHinge2Constraint_makeCPlusArray__SWIG_1" #.(lispify "btHinge2Constraint_makeCPlusArray" 'function)) :pointer
   (self :pointer)
   (arg1 :pointer)
   (ptr :pointer))
 (export '#.(lispify "btHinge2Constraint_makeCPlusArray" 'function)))
#+ (or)
(progn (declaim (inline #.(lispify "btHinge2Constraint_deleteCPlusArray" 'function)))
             (cffi:defcfun ("_wrap_btHinge2Constraint_deleteCPlusArray__SWIG_1" #.(lispify "btHinge2Constraint_deleteCPlusArray" 'function)) :void
               (self :pointer)
               (arg1 :pointer)
               (arg2 :pointer))
             (export '#.(lispify "btHinge2Constraint_deleteCPlusArray" 'function)))
(declaim (inline #.(lispify "new_btHinge2Constraint" 'function)))
(cffi:defcfun ("_wrap_new_btHinge2Constraint" #.(lispify "new_btHinge2Constraint" 'function)) :pointer
  (rbA :pointer)
  (rbB :pointer)
  (anchor :pointer)
  (axis1 :pointer)
  (axis2 :pointer))

(export '#.(lispify "new_btHinge2Constraint" 'function))

(declaim (inline #.(lispify "btHinge2Constraint_getAnchor" 'function)))

(cffi:defcfun ("_wrap_btHinge2Constraint_getAnchor" #.(lispify "btHinge2Constraint_getAnchor" 'function)) :pointer  (self :pointer))
(export '#.(lispify "btHinge2Constraint_getAnchor" 'function))
(declaim (inline #.(lispify "btHinge2Constraint_getAnchor2" 'function)))
(cffi:defcfun ("_wrap_btHinge2Constraint_getAnchor2" #.(lispify "btHinge2Constraint_getAnchor2" 'function)) :pointer
  (self :pointer))
(export '#.(lispify "btHinge2Constraint_getAnchor2" 'function))
(declaim (inline #.(lispify "btHinge2Constraint_getAxis1" 'function)))
(cffi:defcfun ("_wrap_btHinge2Constraint_getAxis1" #.(lispify "btHinge2Constraint_getAxis1" 'function)) :pointer  (self :pointer))
(export '#.(lispify "btHinge2Constraint_getAxis1" 'function))
(declaim (inline #.(lispify "btHinge2Constraint_getAxis2" 'function)))
(cffi:defcfun ("_wrap_btHinge2Constraint_getAxis2" #.(lispify "btHinge2Constraint_getAxis2" 'function)) :pointer
  (self :pointer))
(export '#.(lispify "btHinge2Constraint_getAxis2" 'function))
(declaim (inline #.(lispify "btHinge2Constraint_getAngle1" 'function)))
(cffi:defcfun ("_wrap_btHinge2Constraint_getAngle1" #.(lispify "btHinge2Constraint_getAngle1" 'function)) :float
  (self :pointer))
(export '#.(lispify "btHinge2Constraint_getAngle1" 'function))
(declaim (inline #.(lispify "btHinge2Constraint_getAngle2" 'function)))
(cffi:defcfun ("_wrap_btHinge2Constraint_getAngle2" #.(lispify "btHinge2Constraint_getAngle2" 'function)) :float
  (self :pointer))
(export '#.(lispify "btHinge2Constraint_getAngle2" 'function))
(declaim (inline #.(lispify "btHinge2Constraint_setUpperLimit" 'function)))
(cffi:defcfun ("_wrap_btHinge2Constraint_setUpperLimit" #.(lispify "btHinge2Constraint_setUpperLimit" 'function)) :void
  (ang1max :float))
(export '#.(lispify "btHinge2Constraint_setUpperLimit" 'function))
(declaim (inline #.(lispify "btHinge2Constraint_setLowerLimit" 'function)))
(cffi:defcfun ("_wrap_btHinge2Constraint_setLowerLimit" #.(lispify "btHinge2Constraint_setLowerLimit" 'function)) :void
  (ang1min :float))
(export '#.(lispify "btHinge2Constraint_setLowerLimit" 'function))
(declaim (inline #.(lispify "delete_btHinge2Constraint" 'function)))
(cffi:defcfun ("_wrap_delete_btHinge2Constraint" #.(lispify "delete_btHinge2Constraint" 'function)) :void
  (self :pointer))
(export '#.(lispify "delete_btHinge2Constraint" 'function))
(define-constant #.(lispify "btGearConstraintDataName" 'constant) "btGearConstraintFloatData" :test 'equal)
(export '#.(lispify "btGearConstraintDataName" 'constant))
(declaim (inline #.(lispify "new_btGearConstraint" 'function)))
(cffi:defcfun ("_wrap_new_btGearConstraint__SWIG_0" #.(lispify "new_btGearConstraint" 'function)) :pointer
  (rbA :pointer)
  (rbB :pointer)
  (axisInA :pointer)
  (axisInB :pointer)
  (ratio :float))
(export '#.(lispify "new_btGearConstraint" 'function))
(declaim (inline make-gear-constraint/without-ratio))
(cffi:defcfun ("_wrap_new_btGearConstraint__SWIG_1" 
               make-gear-constraint/without-ratio) :pointer
  (rbA :pointer)
  (rbB :pointer)
  (axisInA :pointer)
  (axisInB :pointer))
(export 'make-gear-constraint/without-ratio)

(declaim (inline #.(lispify "delete_btGearConstraint" 'function)))

(cffi:defcfun ("_wrap_delete_btGearConstraint" #.(lispify "delete_btGearConstraint" 'function)) :void  (self :pointer))
(export '#.(lispify "delete_btGearConstraint" 'function))
(declaim (inline #.(lispify "btGearConstraint_getInfo1" 'function)))
(cffi:defcfun ("_wrap_btGearConstraint_getInfo1" #.(lispify "btGearConstraint_getInfo1" 'function)) :void
  (info :pointer))
(export '#.(lispify "btGearConstraint_getInfo1" 'function))
(declaim (inline #.(lispify "btGearConstraint_getInfo2" 'function)))
(cffi:defcfun ("_wrap_btGearConstraint_getInfo2" #.(lispify "btGearConstraint_getInfo2" 'function)) :void
  (self :pointer)
  (info :pointer))
(export '#.(lispify "btGearConstraint_getInfo2" 'function))
(declaim (inline #.(lispify "btGearConstraint_setAxisA" 'function)))
(cffi:defcfun ("_wrap_btGearConstraint_setAxisA" #.(lispify "btGearConstraint_setAxisA" 'function)) :void
  (self :pointer)
  (axisA :pointer))
(export '#.(lispify "btGearConstraint_setAxisA" 'function))
(declaim (inline #.(lispify "btGearConstraint_setAxisB" 'function)))
(cffi:defcfun ("_wrap_btGearConstraint_setAxisB" #.(lispify "btGearConstraint_setAxisB" 'function)) :void
  (axisB :pointer))
(export '#.(lispify "btGearConstraint_setAxisB" 'function))
(declaim (inline #.(lispify "btGearConstraint_setRatio" 'function)))
(cffi:defcfun ("_wrap_btGearConstraint_setRatio" #.(lispify "btGearConstraint_setRatio" 'function)) :void
  (ratio :float))
(export '#.(lispify "btGearConstraint_setRatio" 'function))
(declaim (inline #.(lispify "btGearConstraint_getAxisA" 'function)))
(cffi:defcfun ("_wrap_btGearConstraint_getAxisA" #.(lispify "btGearConstraint_getAxisA" 'function)) :pointer  (self :pointer))
(export '#.(lispify "btGearConstraint_getAxisA" 'function))
(declaim (inline #.(lispify "btGearConstraint_getAxisB" 'function)))
(cffi:defcfun ("_wrap_btGearConstraint_getAxisB" #.(lispify "btGearConstraint_getAxisB" 'function)) :pointer  (self :pointer))
(export '#.(lispify "btGearConstraint_getAxisB" 'function))
(declaim (inline #.(lispify "btGearConstraint_getRatio" 'function)))
(cffi:defcfun ("_wrap_btGearConstraint_getRatio" #.(lispify "btGearConstraint_getRatio" 'function)) :float  (self :pointer))
(export '#.(lispify "btGearConstraint_getRatio" 'function))

(declaim (inline #.(lispify "btGearConstraint_calculateSerializeBufferSize" 'function)))
(cffi:defcfun ("_wrap_btGearConstraint_calculateSerializeBufferSize" #.(lispify "btGearConstraint_calculateSerializeBufferSize" 'function)) :int
  (self :pointer))
(export '#.(lispify "btGearConstraint_calculateSerializeBufferSize" 'function))
(declaim (inline #.(lispify "btGearConstraint_serialize" 'function)))
(cffi:defcfun ("_wrap_btGearConstraint_serialize" #.(lispify "btGearConstraint_serialize" 'function)) :string
  (dataBuffer :pointer)
  (serializer :pointer))
(export '#.(lispify "btGearConstraint_serialize" 'function))
(cffi:defcstruct #.(lispify "btGearConstraintFloatData" 'classname)
	(#.(lispify "m_typeConstraintData" 'slotname) 
           (:pointer (:STRUCT
                      TYPED-CONSTRAINT-FLOAT-DATA)))
	(#.(lispify "m_axisInA" 'slotname) (:pointer (:struct vector-3-float-data)))
	(#.(lispify "m_axisInB" 'slotname) (:pointer (:struct vector-3-float-data)))
	(#.(lispify "m_ratio" 'slotname) :float)
	(#.(lispify "m_padding" 'slotname) :pointer))
(export '#.(lispify "btGearConstraintFloatData" 'classname))
(export '#.(lispify "m_typeConstraintData" 'slotname))
(export '#.(lispify "m_axisInA" 'slotname))
(export '#.(lispify "m_axisInB" 'slotname))
(export '#.(lispify "m_ratio" 'slotname))
(export '#.(lispify "m_padding" 'slotname))
(cffi:defcstruct #.(lispify "btGearConstraintDoubleData" 'classname)
                 (#.(lispify "m_typeConstraintData" 'slotname)
                    (:POINTER
                     (:STRUCT
                      TYPED-CONSTRAINT-DOUBLE-DATA)))
                 (#.(lispify "m_axisInA" 'slotname) (:pointer (:struct vector-3-double-data)))
                 (#.(lispify "m_axisInB" 'slotname) (:pointer (:struct vector-3-double-data)))
                 (#.(lispify "m_ratio" 'slotname) :double))
(export '#.(lispify "btGearConstraintDoubleData" 'classname))
(export '#.(lispify "m_typeConstraintData" 'slotname))
(export '#.(lispify "m_axisInA" 'slotname))
(export '#.(lispify "m_axisInB" 'slotname))
(export '#.(lispify "m_ratio" 'slotname))
(declaim (inline #.(lispify "new_btFixedConstraint" 'function)))
(cffi:defcfun ("_wrap_new_btFixedConstraint" #.(lispify "new_btFixedConstraint" 'function)) :pointer
  (rbA :pointer)
  (rbB :pointer)
  (frameInA :pointer)
  (frameInB :pointer))
(export '#.(lispify "new_btFixedConstraint" 'function))
(declaim (inline #.(lispify "delete_btFixedConstraint" 'function)))
(cffi:defcfun ("_wrap_delete_btFixedConstraint" #.(lispify "delete_btFixedConstraint" 'function)) :void  (self :pointer))
(export '#.(lispify "delete_btFixedConstraint" 'function))
(declaim (inline #.(lispify "btFixedConstraint_getInfo1" 'function)))
(cffi:defcfun ("_wrap_btFixedConstraint_getInfo1" #.(lispify "btFixedConstraint_getInfo1" 'function)) :void
  (self :pointer)
  (info :pointer))
(export '#.(lispify "btFixedConstraint_getInfo1" 'function))
(declaim (inline #.(lispify "btFixedConstraint_getInfo2" 'function)))
(cffi:defcfun ("_wrap_btFixedConstraint_getInfo2" #.(lispify "btFixedConstraint_getInfo2" 'function)) :void
  (self :pointer)
  (info :pointer))
(export '#.(lispify "btFixedConstraint_getInfo2" 'function))

(declaim (inline #.(lispify "btSequentialImpulseConstraintSolver_makeCPlusPlusInstance" 'function)))
(cffi:defcfun ("_wrap_btSequentialImpulseConstraintSolver_makeCPlusPlusInstance__SWIG_0" #.(lispify "btSequentialImpulseConstraintSolver_makeCPlusPlusInstance" 'function)) :pointer
  (self :pointer)
  (sizeInBytes :pointer))
(export '#.(lispify "btSequentialImpulseConstraintSolver_makeCPlusPlusInstance" 'function))
(declaim (inline #.(lispify "btSequentialImpulseConstraintSolver_deleteCPlusPlusInstance" 'function)))
(cffi:defcfun ("_wrap_btSequentialImpulseConstraintSolver_deleteCPlusPlusInstance__SWIG_0" #.(lispify "btSequentialImpulseConstraintSolver_deleteCPlusPlusInstance" 'function)) :void
  (ptr :pointer))
(export '#.(lispify "btSequentialImpulseConstraintSolver_deleteCPlusPlusInstance" 'function))
#+ (or)
(progn 
  (declaim (inline #.(lispify "btSequentialImpulseConstraintSolver_makeCPlusPlusInstance" 'function)))
  (cffi:defcfun ("_wrap_btSequentialImpulseConstraintSolver_makeCPlusPlusInstance__SWIG_1" #.(lispify "btSequentialImpulseConstraintSolver_makeCPlusPlusInstance" 'function)) :pointer
    (arg1 :pointer)
    (ptr :pointer))
  (export '#.(lispify "btSequentialImpulseConstraintSolver_makeCPlusPlusInstance" 'function))
        (declaim (inline #.(lispify "btSequentialImpulseConstraintSolver_deleteCPlusPlusInstance" 'function)))
        (cffi:defcfun ("_wrap_btSequentialImpulseConstraintSolver_deleteCPlusPlusInstance__SWIG_1" #.(lispify "btSequentialImpulseConstraintSolver_deleteCPlusPlusInstance" 'function)) :void
          (arg1 :pointer)
          (arg2 :pointer))
        (export '#.(lispify "btSequentialImpulseConstraintSolver_deleteCPlusPlusInstance" 'function)))
(declaim (inline #.(lispify "btSequentialImpulseConstraintSolver_makeCPlusArray" 'function)))
(cffi:defcfun ("_wrap_btSequentialImpulseConstraintSolver_makeCPlusArray__SWIG_0" #.(lispify "btSequentialImpulseConstraintSolver_makeCPlusArray" 'function)) :pointer
  (self :pointer)
  (sizeInBytes :pointer))
(export '#.(lispify "btSequentialImpulseConstraintSolver_makeCPlusArray" 'function))
(declaim (inline #.(lispify "btSequentialImpulseConstraintSolver_deleteCPlusArray" 'function)))
(cffi:defcfun ("_wrap_btSequentialImpulseConstraintSolver_deleteCPlusArray__SWIG_0" #.(lispify "btSequentialImpulseConstraintSolver_deleteCPlusArray" 'function)) :void
  (ptr :pointer))
(export '#.(lispify "btSequentialImpulseConstraintSolver_deleteCPlusArray" 'function))

#+ (or)
(progn 
  (declaim (inline #.(lispify "btSequentialImpulseConstraintSolver_makeCPlusArray" 'function)))
  (cffi:defcfun ("_wrap_btSequentialImpulseConstraintSolver_makeCPlusArray__SWIG_1" #.(lispify "btSequentialImpulseConstraintSolver_makeCPlusArray" 'function)) :pointer
    (arg1 :pointer)
    (ptr :pointer))
  (export '#.(lispify "btSequentialImpulseConstraintSolver_makeCPlusArray" 'function))
  (declaim (inline #.(lispify "btSequentialImpulseConstraintSolver_deleteCPlusArray" 'function)))
        (cffi:defcfun ("_wrap_btSequentialImpulseConstraintSolver_deleteCPlusArray__SWIG_1" #.(lispify "btSequentialImpulseConstraintSolver_deleteCPlusArray" 'function)) :void
          (arg1 :pointer)
          (arg2 :pointer))
        (export '#.(lispify "btSequentialImpulseConstraintSolver_deleteCPlusArray" 'function)))
(declaim (inline #.(lispify "new_btSequentialImpulseConstraintSolver" 'function)))
(cffi:defcfun ("_wrap_new_btSequentialImpulseConstraintSolver" #.(lispify "new_btSequentialImpulseConstraintSolver" 'function)) :pointer)
(export '#.(lispify "new_btSequentialImpulseConstraintSolver" 'function))
(declaim (inline #.(lispify "delete_btSequentialImpulseConstraintSolver" 'function)))
(cffi:defcfun ("_wrap_delete_btSequentialImpulseConstraintSolver" #.(lispify "delete_btSequentialImpulseConstraintSolver" 'function)) :void  (self :pointer))
(export '#.(lispify "delete_btSequentialImpulseConstraintSolver" 'function))
(declaim (inline #.(lispify "btSequentialImpulseConstraintSolver_solveGroup" 'function)))
(cffi:defcfun ("_wrap_btSequentialImpulseConstraintSolver_solveGroup" #.(lispify "btSequentialImpulseConstraintSolver_solveGroup" 'function)) :float
  (bodies :pointer)
  (numBodies :int)
  (manifold :pointer)
  (numManifolds :int)
  (constraints :pointer)
  (numConstraints :int)
  (info :pointer)
  (debugDrawer :pointer)
  (dispatcher :pointer))
(export '#.(lispify "btSequentialImpulseConstraintSolver_solveGroup" 'function))
(declaim (inline #.(lispify "btSequentialImpulseConstraintSolver_reset" 'function)))
(cffi:defcfun ("_wrap_btSequentialImpulseConstraintSolver_reset" #.(lispify "btSequentialImpulseConstraintSolver_reset" 'function)) :void  (self :pointer))
(export '#.(lispify "btSequentialImpulseConstraintSolver_reset" 'function))
(declaim (inline #.(lispify "btSequentialImpulseConstraintSolver_btRand2" 'function)))
(cffi:defcfun ("_wrap_btSequentialImpulseConstraintSolver_btRand2" #.(lispify "btSequentialImpulseConstraintSolver_btRand2" 'function)) :unsigned-long  (self :pointer))
(export '#.(lispify "btSequentialImpulseConstraintSolver_btRand2" 'function))
(declaim (inline #.(lispify "btSequentialImpulseConstraintSolver_btRandInt2" 'function)))
(cffi:defcfun ("_wrap_btSequentialImpulseConstraintSolver_btRandInt2" #.(lispify "btSequentialImpulseConstraintSolver_btRandInt2" 'function)) :int
  (self :pointer)
  (n :int))
(export '#.(lispify "btSequentialImpulseConstraintSolver_btRandInt2" 'function))
(declaim (inline #.(lispify "btSequentialImpulseConstraintSolver_setRandSeed" 'function)))
(cffi:defcfun ("_wrap_btSequentialImpulseConstraintSolver_setRandSeed" #.(lispify "btSequentialImpulseConstraintSolver_setRandSeed" 'function)) :void
  (self :pointer)
  (seed :unsigned-long))
(export '#.(lispify "btSequentialImpulseConstraintSolver_setRandSeed" 'function))
(declaim (inline #.(lispify "btSequentialImpulseConstraintSolver_getRandSeed" 'function)))
(cffi:defcfun ("_wrap_btSequentialImpulseConstraintSolver_getRandSeed" #.(lispify "btSequentialImpulseConstraintSolver_getRandSeed" 'function)) :unsigned-long
  (self :pointer))
(export '#.(lispify "btSequentialImpulseConstraintSolver_getRandSeed" 'function))
(declaim (inline #.(lispify "btSequentialImpulseConstraintSolver_getSolverType" 'function)))
(cffi:defcfun ("_wrap_btSequentialImpulseConstraintSolver_getSolverType" #.(lispify "btSequentialImpulseConstraintSolver_getSolverType" 'function)) :pointer
  (self :pointer))
(export '#.(lispify "btSequentialImpulseConstraintSolver_getSolverType" 'function))



(defmethod #.(lispify "new" 'method) ((self #.(lispify "bt-vector3" 'classname)) sizeInBytes)
  (#.(lispify "btVector3_makeCPlusPlusInstance" 'function) (ff-pointer self) sizeInBytes))

(defmethod #.(lispify "delete" 'method) ((self #.(lispify "bt-vector3" 'classname)) ptr)
  (#.(lispify "btVector3_deleteCPlusPlusInstance" 'function) (ff-pointer self) ptr))

#+ (or)
(progn
  
  (defmethod #.(lispify "new" 'method) ((self #.(lispify "bt-vector3" 'classname)) arg1 ptr)
             (#.(lispify "btVector3_makeCPlusPlusInstance" 'function) (ff-pointer self) arg1 ptr))
  
  
 (defmethod #.(lispify "delete" 'method) ((self #.(lispify "bt-vector3" 'classname)) arg1 arg2)
            (#.(lispify "btVector3_deleteCPlusPlusInstance" 'function)
               (ff-pointer self) arg1 arg2)))

(shadow "new[]")
(defmethod #.(lispify "new[]" 'method) ((self #.(lispify "bt-vector3" 'classname)) sizeInBytes)
  (#.(lispify "btVector3_makeCPlusArray" 'function) (ff-pointer self) sizeInBytes))

(shadow "delete[]")
(defmethod #.(lispify "delete[]" 'method) ((self #.(lispify "bt-vector3" 'classname)) ptr)
  (#.(lispify "btVector3_deleteCPlusArray" 'function) (ff-pointer self) ptr))

#+ (or)
(progn 
  (shadow "new[]")
 (defmethod #.(lispify "new[]" 'method) ((self #.(lispify "bt-vector3" 'classname)) arg1 ptr)
            (#.(lispify "btVector3_makeCPlusArray" 'function) (ff-pointer self) arg1 ptr))

 (shadow "delete[]")
 (defmethod #.(lispify "delete[]" 'method) ((self #.(lispify "bt-vector3" 'classname)) arg1 arg2)
            (#.(lispify "btVector3_deleteCPlusArray" 'function) (ff-pointer self) arg1 arg2)))

(defmethod (setf #.(lispify "m_floats" 'method)) (arg0 (obj #.(lispify "bt-vector3" 'class)))
  (#.(lispify "btVector3_m_floats_set" 'function) (ff-pointer obj) arg0))

(defmethod #.(lispify "m_floats" 'method) ((obj #.(lispify "bt-vector3" 'class)))
  (#.(lispify "btVector3_m_floats_get" 'function) (ff-pointer obj)))

(defmethod initialize-instance :after ((obj #.(lispify "bt-vector3" 'class)) &key)
  (setf (slot-value obj 'ff-pointer) (#.(lispify "new_btVector3" 'function))))

(defmethod initialize-instance :after ((obj #.(lispify "bt-vector3" 'class)) &key _x _y _z)
  (setf (slot-value obj 'ff-pointer) (#.(lispify "new_btVector3" 'function) _x _y _z)))

(shadow "+=")
(defmethod #.(lispify "+=" 'method) ((self #.(lispify "bt-vector3" 'classname)) (v #.(lispify "bt-vector3" 'classname)))
  (#.(lispify "btVector3_increment" 'function) (ff-pointer self) (ff-pointer v)))

(shadow "-=")
(defmethod #.(lispify "-=" 'method) ((self #.(lispify "bt-vector3" 'classname)) (v #.(lispify "bt-vector3" 'classname)))
  (#.(lispify "btVector3_decrement" 'function) (ff-pointer self) (ff-pointer v)))

(shadow "*=")
(defmethod #.(lispify "*=" 'method) ((self #.(lispify "bt-vector3" 'classname)) s)
  (#.(lispify "btVector3_multiplyAndAssign" 'function) (ff-pointer self) s))

(shadow "/=")
(defmethod #.(lispify "/=" 'method) ((self #.(lispify "bt-vector3" 'classname)) s)
  (#.(lispify "btVector3_divideAndAssign" 'function) (ff-pointer self) s))

(defmethod #.(lispify "dot" 'method) ((self #.(lispify "bt-vector3" 'classname)) (v #.(lispify "bt-vector3" 'classname)))
  (#.(lispify "btVector3_dot" 'function) (ff-pointer self) (ff-pointer v)))

(defmethod #.(lispify "length2" 'method) ((self #.(lispify "bt-vector3" 'classname)))
  (#.(lispify "btVector3_length2" 'function) (ff-pointer self)))

(defmethod #.(lispify "length" 'method) ((self #.(lispify "bt-vector3" 'classname)))
  (#.(lispify "btVector3_length" 'function) (ff-pointer self)))

(defmethod #.(lispify "norm" 'method) ((self #.(lispify "bt-vector3" 'classname)))
  (#.(lispify "btVector3_norm" 'function) (ff-pointer self)))

(defmethod #.(lispify "distance2" 'method) ((self #.(lispify "bt-vector3" 'classname)) (v #.(lispify "bt-vector3" 'classname)))
  (#.(lispify "btVector3_distance2" 'function) (ff-pointer self) (ff-pointer v)))

(defmethod #.(lispify "distance" 'method) ((self #.(lispify "bt-vector3" 'classname)) (v #.(lispify "bt-vector3" 'classname)))
  (#.(lispify "btVector3_distance" 'function) (ff-pointer self) (ff-pointer v)))

(defmethod #.(lispify "safe-normalize" 'method) ((self #.(lispify "bt-vector3" 'classname)))
  (#.(lispify "btVector3_safeNormalize" 'function) (ff-pointer self)))

(defmethod #.(lispify "normalize" 'method) ((self #.(lispify "bt-vector3" 'classname)))
  (#.(lispify "btVector3_normalize" 'function) (ff-pointer self)))

(defmethod #.(lispify "normalized" 'method) ((self #.(lispify "bt-vector3" 'classname)))
  (#.(lispify "btVector3_normalized" 'function) (ff-pointer self)))

(defmethod #.(lispify "rotate" 'method) ((self #.(lispify "bt-vector3" 'classname)) (wAxis #.(lispify "bt-vector3" 'classname)) (angle number))
  (#.(lispify "btVector3_rotate" 'function) (ff-pointer self) (ff-pointer wAxis) angle))

(declaim (inline angle))

(defgeneric angle (a b)
  (:method ((a vector3) (b vector3))
    (vector3/angle a b))
  (:method ((a quaternion) (b quaternion))
    (quaternion/angle a b)))

(export 'angle)

#+ (or)
(defmethod #.(lispify "angle" 'method) ((self #.(lispify "bt-vector3" 'classname)) (v #.(lispify "bt-vector3" 'classname)))
  (#.(lispify "btVector3_angle" 'function) (ff-pointer self) (ff-pointer v)))

(defmethod #.(lispify "absolute" 'method) ((self #.(lispify "bt-vector3" 'classname)))
  (#.(lispify "btVector3_absolute" 'function) (ff-pointer self)))

(defmethod #.(lispify "cross" 'method) ((self #.(lispify "bt-vector3" 'classname)) (v #.(lispify "bt-vector3" 'classname)))
  (#.(lispify "btVector3_cross" 'function) (ff-pointer self) (ff-pointer v)))

(defmethod #.(lispify "triple" 'method) ((self #.(lispify "bt-vector3" 'classname)) (v1 #.(lispify "bt-vector3" 'classname)) (v2 #.(lispify "bt-vector3" 'classname)))
  (#.(lispify "btVector3_triple" 'function) (ff-pointer self) (ff-pointer v1) (ff-pointer v2)))

(defmethod #.(lispify "min-axis" 'method) ((self #.(lispify "bt-vector3" 'classname)))
  (#.(lispify "btVector3_minAxis" 'function) (ff-pointer self)))

(defmethod #.(lispify "max-axis" 'method) ((self #.(lispify "bt-vector3" 'classname)))
  (#.(lispify "btVector3_maxAxis" 'function) (ff-pointer self)))

(defmethod #.(lispify "furthest-axis" 'method) ((self #.(lispify "bt-vector3" 'classname)))
  (#.(lispify "btVector3_furthestAxis" 'function) (ff-pointer self)))

(defmethod #.(lispify "closest-axis" 'method) ((self #.(lispify "bt-vector3" 'classname)))
  (#.(lispify "btVector3_closestAxis" 'function) (ff-pointer self)))

(defmethod #.(lispify "set-interpolate3" 'method) ((self #.(lispify "bt-vector3" 'classname)) (v0 #.(lispify "bt-vector3" 'classname)) (v1 #.(lispify "bt-vector3" 'classname)) (rt number))
  (#.(lispify "btVector3_setInterpolate3" 'function) (ff-pointer self) (ff-pointer v0) (ff-pointer v1) rt))

(defmethod #.(lispify "lerp" 'method) ((self #.(lispify "bt-vector3" 'classname)) (v #.(lispify "bt-vector3" 'classname)) t-arg2)
  (#.(lispify "btVector3_lerp" 'function) (ff-pointer self) (ff-pointer v) t-arg2))

(shadow "*=")
(defmethod #.(lispify "*=" 'method) ((self #.(lispify "bt-vector3" 'classname)) (v #.(lispify "bt-vector3" 'classname)))
  (#.(lispify "btVector3_multiplyAndAssign" 'function) (ff-pointer self) (ff-pointer v)))

(defmethod #.(lispify "get-x" 'method) ((self #.(lispify "bt-vector3" 'classname)))
  (#.(lispify "btVector3_getX" 'function) (ff-pointer self)))

(defmethod #.(lispify "get-y" 'method) ((self #.(lispify "bt-vector3" 'classname)))
  (#.(lispify "btVector3_getY" 'function) (ff-pointer self)))

(defmethod #.(lispify "get-z" 'method) ((self #.(lispify "bt-vector3" 'classname)))
  (#.(lispify "btVector3_getZ" 'function) (ff-pointer self)))

(defmethod #.(lispify "set-x" 'method) ((self #.(lispify "bt-vector3" 'classname)) (_x number))
  (#.(lispify "btVector3_setX" 'function) (ff-pointer self) _x))

(defmethod #.(lispify "set-y" 'method) ((self #.(lispify "bt-vector3" 'classname)) (_y number))
  (#.(lispify "btVector3_setY" 'function) (ff-pointer self) _y))

(defmethod #.(lispify "set-z" 'method) ((self #.(lispify "bt-vector3" 'classname)) (_z number))
  (#.(lispify "btVector3_setZ" 'function) (ff-pointer self) _z))

(defmethod #.(lispify "set-w" 'method) ((self #.(lispify "bt-vector3" 'classname)) (_w number))
  (#.(lispify "btVector3_setW" 'function) (ff-pointer self) _w))

(defmethod #.(lispify "x" 'method) ((self #.(lispify "bt-vector3" 'classname)))
  (#.(lispify "btVector3_x" 'function) (ff-pointer self)))

(defmethod #.(lispify "y" 'method) ((self #.(lispify "bt-vector3" 'classname)))
  (#.(lispify "btVector3_y" 'function) (ff-pointer self)))

(defmethod #.(lispify "z" 'method) ((self #.(lispify "bt-vector3" 'classname)))
  (#.(lispify "btVector3_z" 'function) (ff-pointer self)))

(defmethod #.(lispify "w" 'method) ((self #.(lispify "bt-vector3" 'classname)))
  (#.(lispify "btVector3_w" 'function) (ff-pointer self)))

(shadow "==")
(defmethod #.(lispify "==" 'method) ((self #.(lispify "bt-vector3" 'classname)) (other #.(lispify "bt-vector3" 'classname)))
  (#.(lispify "btVector3_isEqual" 'function) (ff-pointer self) (ff-pointer other)))

(shadow "!=")
(defmethod #.(lispify "!=" 'method) ((self #.(lispify "bt-vector3" 'classname)) (other #.(lispify "bt-vector3" 'classname)))
  (#.(lispify "btVector3_notEquals" 'function) (ff-pointer self) (ff-pointer other)))

(defmethod #.(lispify "set-max" 'method) ((self #.(lispify "bt-vector3" 'classname)) (other #.(lispify "bt-vector3" 'classname)))
  (#.(lispify "btVector3_setMax" 'function) (ff-pointer self) (ff-pointer other)))

(defmethod #.(lispify "set-min" 'method) ((self #.(lispify "bt-vector3" 'classname)) (other #.(lispify "bt-vector3" 'classname)))
  (#.(lispify "btVector3_setMin" 'function) (ff-pointer self) (ff-pointer other)))

(defmethod #.(lispify "set-value" 'method) ((self #.(lispify "bt-vector3" 'classname)) _x _y _z)
  (#.(lispify "btVector3_setValue" 'function) (ff-pointer self) _x _y _z))

(defmethod #.(lispify "get-skew-symmetric-matrix" 'method) ((self #.(lispify "bt-vector3" 'classname)) (v0 #.(lispify "bt-vector3" 'classname)) (v1 #.(lispify "bt-vector3" 'classname)) (v2 #.(lispify "bt-vector3" 'classname)))
  (#.(lispify "btVector3_getSkewSymmetricMatrix" 'function) (ff-pointer self) (ff-pointer v0) (ff-pointer v1) (ff-pointer v2)))

(defmethod #.(lispify "set-zero" 'method) ((self #.(lispify "bt-vector3" 'classname)))
  (#.(lispify "btVector3_setZero" 'function) (ff-pointer self)))

(defmethod #.(lispify "is-zero" 'method) ((self #.(lispify "bt-vector3" 'classname)))
  (#.(lispify "btVector3_isZero" 'function) (ff-pointer self)))

(defmethod #.(lispify "fuzzy-zero" 'method) ((self #.(lispify "bt-vector3" 'classname)))
  (#.(lispify "btVector3_fuzzyZero" 'function) (ff-pointer self)))

(defmethod #.(lispify "serialize" 'method) ((self #.(lispify "bt-vector3" 'classname)) dataOut)
  (#.(lispify "btVector3_serialize" 'function) (ff-pointer self) dataOut))

(defmethod #.(lispify "de-serialize" 'method) ((self #.(lispify "bt-vector3" 'classname)) dataIn)
  (#.(lispify "btVector3_deSerialize" 'function) (ff-pointer self) dataIn))

(defmethod #.(lispify "serialize-float" 'method) ((self #.(lispify "bt-vector3" 'classname)) dataOut)
  (#.(lispify "btVector3_serializeFloat" 'function) (ff-pointer self) dataOut))

(defmethod #.(lispify "de-serialize-float" 'method) ((self #.(lispify "bt-vector3" 'classname)) dataIn)
  (#.(lispify "btVector3_deSerializeFloat" 'function) (ff-pointer self) dataIn))

(defmethod #.(lispify "serialize-double" 'method) ((self #.(lispify "bt-vector3" 'classname)) dataOut)
  (#.(lispify "btVector3_serializeDouble" 'function) (ff-pointer self) dataOut))

(defmethod #.(lispify "de-serialize-double" 'method) ((self #.(lispify "bt-vector3" 'classname)) dataIn)
  (#.(lispify "btVector3_deSerializeDouble" 'function) (ff-pointer self) dataIn))

(defmethod #.(lispify "max-dot" 'method) ((self #.(lispify "bt-vector3" 'classname)) (array #.(lispify "bt-vector3" 'classname)) (array_count integer) dotOut)
  (#.(lispify "btVector3_maxDot" 'function) (ff-pointer self) (ff-pointer array) array_count dotOut))

(defmethod #.(lispify "min-dot" 'method) ((self #.(lispify "bt-vector3" 'classname)) (array #.(lispify "bt-vector3" 'classname)) (array_count integer) dotOut)
  (#.(lispify "btVector3_minDot" 'function) (ff-pointer self) (ff-pointer array) array_count dotOut))

(defmethod #.(lispify "dot3" 'method) ((self #.(lispify "bt-vector3" 'classname)) (v0 #.(lispify "bt-vector3" 'classname)) (v1 #.(lispify "bt-vector3" 'classname)) (v2 #.(lispify "bt-vector3" 'classname)))
  (#.(lispify "btVector3_dot3" 'function) (ff-pointer self) (ff-pointer v0) (ff-pointer v1) (ff-pointer v2)))



(defmethod initialize-instance :after ((obj #.(lispify "bt-vector4" 'class)) &key)
  (setf (slot-value obj 'ff-pointer) (#.(lispify "new_btVector4" 'function))))

(defmethod initialize-instance :after ((obj #.(lispify "bt-vector4" 'class)) &key _x _y _z _w)
  (setf (slot-value obj 'ff-pointer) (#.(lispify "new_btVector4" 'function) _x _y _z _w)))

(defmethod #.(lispify "absolute4" 'method) ((self #.(lispify "bt-vector4" 'classname)))
  (#.(lispify "btVector4_absolute4" 'function) (ff-pointer self)))

(defmethod #.(lispify "get-w" 'method) ((self #.(lispify "bt-vector4" 'classname)))
  (#.(lispify "btVector4_getW" 'function) (ff-pointer self)))

(defmethod #.(lispify "max-axis4" 'method) ((self #.(lispify "bt-vector4" 'classname)))
  (#.(lispify "btVector4_maxAxis4" 'function) (ff-pointer self)))

(defmethod #.(lispify "min-axis4" 'method) ((self #.(lispify "bt-vector4" 'classname)))
  (#.(lispify "btVector4_minAxis4" 'function) (ff-pointer self)))

(defmethod #.(lispify "closest-axis4" 'method) ((self #.(lispify "bt-vector4" 'classname)))
  (#.(lispify "btVector4_closestAxis4" 'function) (ff-pointer self)))

(defmethod #.(lispify "set-value" 'method) ((self #.(lispify "bt-vector4" 'classname)) _x _y _z _w)
  (#.(lispify "btVector4_setValue" 'function) (ff-pointer self) _x _y _z _w))



(defmethod initialize-instance :after ((obj #.(lispify "bt-quaternion" 'class)) &key)
  (setf (slot-value obj 'ff-pointer) (#.(lispify "new_btQuaternion" 'function))))

(defmethod initialize-instance :after ((obj #.(lispify "bt-quaternion" 'class)) &key _x _y _z _w)
  (setf (slot-value obj 'ff-pointer) (#.(lispify "new_btQuaternion" 'function) _x _y _z _w)))

(defmethod initialize-instance :after ((obj #.(lispify "bt-quaternion" 'class)) &key (_axis #.(lispify "bt-vector3" 'classname)) _angle)
  (setf (slot-value obj 'ff-pointer) (#.(lispify "new_btQuaternion" 'function) _axis _angle)))

(defmethod initialize-instance :after ((obj #.(lispify "bt-quaternion" 'class)) &key yaw pitch roll)
  (setf (slot-value obj 'ff-pointer) (#.(lispify "new_btQuaternion" 'function) yaw pitch roll)))

(defmethod #.(lispify "set-rotation" 'method) ((self #.(lispify "bt-quaternion" 'classname)) (axis #.(lispify "bt-vector3" 'classname)) _angle)
  (#.(lispify "btQuaternion_setRotation" 'function) (ff-pointer self) axis _angle))

(defmethod #.(lispify "set-euler" 'method) ((self #.(lispify "bt-quaternion" 'classname)) yaw pitch roll)
  (#.(lispify "btQuaternion_setEuler" 'function) (ff-pointer self) yaw pitch roll))

(defmethod #.(lispify "set-euler-zyx" 'method) ((self #.(lispify "bt-quaternion" 'classname)) yaw pitch roll)
  (#.(lispify "btQuaternion_setEulerZYX" 'function) (ff-pointer self) yaw pitch roll))

(shadow "+=")
(defmethod #.(lispify "+=" 'method) ((self #.(lispify "bt-quaternion" 'classname)) (q #.(lispify "bt-quaternion" 'classname)))
  (#.(lispify "btQuaternion_increment" 'function) (ff-pointer self) (ff-pointer q)))

(shadow "-=")
(defmethod #.(lispify "-=" 'method) ((self #.(lispify "bt-quaternion" 'classname)) (q #.(lispify "bt-quaternion" 'classname)))
  (#.(lispify "btQuaternion_decrement" 'function) (ff-pointer self) (ff-pointer q)))

(shadow "*=")
(defmethod #.(lispify "*=" 'method) ((self #.(lispify "bt-quaternion" 'classname)) s)
  (#.(lispify "btQuaternion_multiplyAndAssign" 'function) (ff-pointer self) s))

(shadow "*=")
(defmethod #.(lispify "*=" 'method) ((self #.(lispify "bt-quaternion" 'classname)) (q #.(lispify "bt-quaternion" 'classname)))
  (#.(lispify "btQuaternion_multiplyAndAssign" 'function) (ff-pointer self) (ff-pointer q)))

(defmethod #.(lispify "dot" 'method) ((self #.(lispify "bt-quaternion" 'classname)) (q #.(lispify "bt-quaternion" 'classname)))
  (#.(lispify "btQuaternion_dot" 'function) (ff-pointer self) (ff-pointer q)))

(defmethod #.(lispify "length2" 'method) ((self #.(lispify "bt-quaternion" 'classname)))
  (#.(lispify "btQuaternion_length2" 'function) (ff-pointer self)))

(defmethod #.(lispify "length" 'method) ((self #.(lispify "bt-quaternion" 'classname)))
  (#.(lispify "btQuaternion_length" 'function) (ff-pointer self)))

(defmethod #.(lispify "normalize" 'method) ((self #.(lispify "bt-quaternion" 'classname)))
  (#.(lispify "btQuaternion_normalize" 'function) (ff-pointer self)))

(shadow "*")
(defmethod #.(lispify "*" 'method) ((self #.(lispify "bt-quaternion" 'classname)) s)
  (#.(lispify "btQuaternion_multiply" 'function) (ff-pointer self) s))

(shadow "/")
(defmethod #.(lispify "/" 'method) ((self #.(lispify "bt-quaternion" 'classname)) s)
  (#.(lispify "btQuaternion_divide" 'function) (ff-pointer self) s))

(shadow "/=")
(defmethod #.(lispify "/=" 'method) ((self #.(lispify "bt-quaternion" 'classname)) s)
  (#.(lispify "btQuaternion_divideAndAssign" 'function) (ff-pointer self) s))

(defmethod #.(lispify "normalized" 'method) ((self #.(lispify "bt-quaternion" 'classname)))
  (#.(lispify "btQuaternion_normalized" 'function) (ff-pointer self)))

(defmethod #.(lispify "angle" 'method) 
  ((self #.(lispify "bt-quaternion" 'classname)) 
   (q #.(lispify "bt-quaternion" 'classname)))
  (#.(lispify "btQuaternion_angle" 'function) (ff-pointer self) (ff-pointer q)))

(defmethod #.(lispify "angle-shortest-path" 'method) ((self #.(lispify "bt-quaternion" 'classname)) (q #.(lispify "bt-quaternion" 'classname)))
  (#.(lispify "btQuaternion_angleShortestPath" 'function) (ff-pointer self) (ff-pointer q)))

(defmethod #.(lispify "get-angle" 'method) ((self #.(lispify "bt-quaternion" 'classname)))
  (#.(lispify "btQuaternion_getAngle" 'function) (ff-pointer self)))

(defmethod #.(lispify "get-angle-shortest-path" 'method) ((self #.(lispify "bt-quaternion" 'classname)))
  (#.(lispify "btQuaternion_getAngleShortestPath" 'function) (ff-pointer self)))

(defmethod #.(lispify "get-axis" 'method) ((self #.(lispify "bt-quaternion" 'classname)))
  (#.(lispify "btQuaternion_getAxis" 'function) (ff-pointer self)))

(defmethod #.(lispify "inverse" 'method) ((self #.(lispify "bt-quaternion" 'classname)))
  (#.(lispify "btQuaternion_inverse" 'function) (ff-pointer self)))

(shadow "+")
(defmethod #.(lispify "+" 'method) ((self #.(lispify "bt-quaternion" 'classname)) (q2 #.(lispify "bt-quaternion" 'classname)))
  (#.(lispify "btQuaternion_add" 'function) (ff-pointer self) (ff-pointer q2)))

(shadow "-")
(defmethod #.(lispify "-" 'method) ((self #.(lispify "bt-quaternion" 'classname)) (q2 #.(lispify "bt-quaternion" 'classname)))
  (#.(lispify "btQuaternion_subtract" 'function) (ff-pointer self) (ff-pointer q2)))

(shadow "-")
(defmethod #.(lispify "-" 'method) ((self #.(lispify "bt-quaternion" 'classname)))
  (#.(lispify "btQuaternion___neg__" 'function) (ff-pointer self)))

(defmethod #.(lispify "farthest" 'method) ((self #.(lispify "bt-quaternion" 'classname)) (qd #.(lispify "bt-quaternion" 'classname)))
  (#.(lispify "btQuaternion_farthest" 'function) (ff-pointer self) (ff-pointer qd)))

(defmethod #.(lispify "nearest" 'method) ((self #.(lispify "bt-quaternion" 'classname)) (qd #.(lispify "bt-quaternion" 'classname)))
  (#.(lispify "btQuaternion_nearest" 'function) (ff-pointer self) (ff-pointer qd)))

(defmethod #.(lispify "slerp" 'method) ((self #.(lispify "bt-quaternion" 'classname)) (q #.(lispify "bt-quaternion" 'classname)) t-arg2)
  (#.(lispify "btQuaternion_slerp" 'function) (ff-pointer self) (ff-pointer q) t-arg2))

(defmethod #.(lispify "get-w" 'method) ((self #.(lispify "bt-quaternion" 'classname)))
  (#.(lispify "btQuaternion_getW" 'function) (ff-pointer self)))



(defmethod initialize-instance :after ((obj #.(lispify "bt-matrix3x3" 'class)) &key)
  (setf (slot-value obj 'ff-pointer) (#.(lispify "new_btMatrix3x3" 'function))))

(defmethod initialize-instance :after ((obj #.(lispify "bt-matrix3x3" 'class)) &key (q #.(lispify "bt-quaternion" 'classname)))
  (setf (slot-value obj 'ff-pointer) (#.(lispify "new_btMatrix3x3" 'function) q)))

(defmethod initialize-instance :after ((obj #.(lispify "bt-matrix3x3" 'class)) &key xx xy xz yx yy yz zx zy zz)
  (setf (slot-value obj 'ff-pointer) (#.(lispify "new_btMatrix3x3" 'function) xx xy xz yx yy yz zx zy zz)))

(defmethod initialize-instance :after ((obj #.(lispify "bt-matrix3x3" 'class)) &key (other #.(lispify "bt-matrix3x3" 'classname)))
  (setf (slot-value obj 'ff-pointer) (#.(lispify "new_btMatrix3x3" 'function) (ff-pointer other))))

(shadow "=")
(defmethod #.(lispify "=" 'method) ((self #.(lispify "bt-matrix3x3" 'classname)) (other #.(lispify "bt-matrix3x3" 'classname)))
  (#.(lispify "btMatrix3x3_assignValue" 'function) (ff-pointer self) (ff-pointer other)))

(defmethod #.(lispify "get-column" 'method) ((self #.(lispify "bt-matrix3x3" 'classname)) (i integer))
  (#.(lispify "btMatrix3x3_getColumn" 'function) (ff-pointer self) i))

(defmethod #.(lispify "get-row" 'method) ((self #.(lispify "bt-matrix3x3" 'classname)) (i integer))
  (#.(lispify "btMatrix3x3_getRow" 'function) (ff-pointer self) i))

(shadow "[]")
(defmethod #.(lispify "[]" 'method) ((self #.(lispify "bt-matrix3x3" 'classname)) (i integer))
  (#.(lispify "btMatrix3x3___aref__" 'function) (ff-pointer self) i))

(shadow "[]")
(defmethod #.(lispify "[]" 'method) ((self #.(lispify "bt-matrix3x3" 'classname)) (i integer))
  (#.(lispify "btMatrix3x3___aref__" 'function) (ff-pointer self) i))

(shadow "*=")
(defmethod #.(lispify "*=" 'method) ((self #.(lispify "bt-matrix3x3" 'classname)) (m #.(lispify "bt-matrix3x3" 'classname)))
  (#.(lispify "btMatrix3x3_multiplyAndAssign" 'function) (ff-pointer self) (ff-pointer m)))

(shadow "+=")
(defmethod #.(lispify "+=" 'method) ((self #.(lispify "bt-matrix3x3" 'classname)) (m #.(lispify "bt-matrix3x3" 'classname)))
  (#.(lispify "btMatrix3x3_increment" 'function) (ff-pointer self) (ff-pointer m)))

(shadow "-=")
(defmethod #.(lispify "-=" 'method) ((self #.(lispify "bt-matrix3x3" 'classname)) (m #.(lispify "bt-matrix3x3" 'classname)))
  (#.(lispify "btMatrix3x3_decrement" 'function) (ff-pointer self) (ff-pointer m)))

(defmethod #.(lispify "set-from-open-glsub-matrix" 'method) ((self #.(lispify "bt-matrix3x3" 'classname)) m)
  (#.(lispify "btMatrix3x3_setFromOpenGLSubMatrix" 'function) (ff-pointer self) m))

(defmethod #.(lispify "set-value" 'method) ((self #.(lispify "bt-matrix3x3" 'classname)) xx xy xz yx yy yz zx zy zz)
  (#.(lispify "btMatrix3x3_setValue" 'function) (ff-pointer self) xx xy xz yx yy yz zx zy zz))

(defmethod #.(lispify "set-rotation" 'method) ((self #.(lispify "bt-matrix3x3" 'classname)) (q #.(lispify "bt-quaternion" 'classname)))
  (#.(lispify "btMatrix3x3_setRotation" 'function) (ff-pointer self) q))

(defmethod #.(lispify "set-euler-ypr" 'method) ((self #.(lispify "bt-matrix3x3" 'classname)) yaw pitch roll)
  (#.(lispify "btMatrix3x3_setEulerYPR" 'function) (ff-pointer self) yaw pitch roll))

(defmethod #.(lispify "set-euler-zyx" 'method) ((self #.(lispify "bt-matrix3x3" 'classname)) (eulerX number) (eulerY number) (eulerZ number))
  (#.(lispify "btMatrix3x3_setEulerZYX" 'function) (ff-pointer self) eulerX eulerY eulerZ))

(defmethod #.(lispify "set-identity" 'method) ((self #.(lispify "bt-matrix3x3" 'classname)))
  (#.(lispify "btMatrix3x3_setIdentity" 'function) (ff-pointer self)))

(defmethod #.(lispify "get-open-glsub-matrix" 'method) ((self #.(lispify "bt-matrix3x3" 'classname)) m)
  (#.(lispify "btMatrix3x3_getOpenGLSubMatrix" 'function) (ff-pointer self) m))

(defmethod #.(lispify "get-rotation" 'method) ((self #.(lispify "bt-matrix3x3" 'classname)) (q #.(lispify "bt-quaternion" 'classname)))
  (#.(lispify "btMatrix3x3_getRotation" 'function) (ff-pointer self) q))

(defmethod #.(lispify "get-euler-ypr" 'method) ((self #.(lispify "bt-matrix3x3" 'classname)) yaw pitch roll)
  (#.(lispify "btMatrix3x3_getEulerYPR" 'function) (ff-pointer self) yaw pitch roll))

(defmethod #.(lispify "get-euler-zyx" 'method) ((self #.(lispify "bt-matrix3x3" 'classname)) yaw pitch roll (solution_number integer))
  (#.(lispify "btMatrix3x3_getEulerZYX" 'function) (ff-pointer self) yaw pitch roll solution_number))

(defmethod #.(lispify "get-euler-zyx" 'method) ((self #.(lispify "bt-matrix3x3" 'classname)) yaw pitch roll)
  (#.(lispify "btMatrix3x3_getEulerZYX" 'function) (ff-pointer self) yaw pitch roll))

(defmethod #.(lispify "scaled" 'method) ((self #.(lispify "bt-matrix3x3" 'classname)) (s #.(lispify "bt-vector3" 'classname)))
  (#.(lispify "btMatrix3x3_scaled" 'function) (ff-pointer self) s))

(defmethod #.(lispify "determinant" 'method) ((self #.(lispify "bt-matrix3x3" 'classname)))
  (#.(lispify "btMatrix3x3_determinant" 'function) (ff-pointer self)))

(defmethod #.(lispify "adjoint" 'method) ((self #.(lispify "bt-matrix3x3" 'classname)))
  (#.(lispify "btMatrix3x3_adjoint" 'function) (ff-pointer self)))

(defmethod #.(lispify "absolute" 'method) ((self #.(lispify "bt-matrix3x3" 'classname)))
  (#.(lispify "btMatrix3x3_absolute" 'function) (ff-pointer self)))

(defmethod #.(lispify "transpose" 'method) ((self #.(lispify "bt-matrix3x3" 'classname)))
  (#.(lispify "btMatrix3x3_transpose" 'function) (ff-pointer self)))

(defmethod #.(lispify "inverse" 'method) ((self #.(lispify "bt-matrix3x3" 'classname)))
  (#.(lispify "btMatrix3x3_inverse" 'function) (ff-pointer self)))

(defmethod #.(lispify "transpose-times" 'method) ((self #.(lispify "bt-matrix3x3" 'classname)) (m #.(lispify "bt-matrix3x3" 'classname)))
  (#.(lispify "btMatrix3x3_transposeTimes" 'function) (ff-pointer self) (ff-pointer m)))

(defmethod #.(lispify "times-transpose" 'method) ((self #.(lispify "bt-matrix3x3" 'classname)) (m #.(lispify "bt-matrix3x3" 'classname)))
  (#.(lispify "btMatrix3x3_timesTranspose" 'function) (ff-pointer self) (ff-pointer m)))

(defmethod #.(lispify "tdotx" 'method) ((self #.(lispify "bt-matrix3x3" 'classname)) (v #.(lispify "bt-vector3" 'classname)))
  (#.(lispify "btMatrix3x3_tdotx" 'function) (ff-pointer self) v))

(defmethod #.(lispify "tdoty" 'method) ((self #.(lispify "bt-matrix3x3" 'classname)) (v #.(lispify "bt-vector3" 'classname)))
  (#.(lispify "btMatrix3x3_tdoty" 'function) (ff-pointer self) v))

(defmethod #.(lispify "tdotz" 'method) ((self #.(lispify "bt-matrix3x3" 'classname)) (v #.(lispify "bt-vector3" 'classname)))
  (#.(lispify "btMatrix3x3_tdotz" 'function) (ff-pointer self) v))

(defmethod #.(lispify "diagonalize" 'method) ((self #.(lispify "bt-matrix3x3" 'classname)) (rot #.(lispify "bt-matrix3x3" 'classname)) (threshold number) (maxSteps integer))
  (#.(lispify "btMatrix3x3_diagonalize" 'function) (ff-pointer self) (ff-pointer rot) threshold maxSteps))

(defmethod #.(lispify "cofac" 'method) ((self #.(lispify "bt-matrix3x3" 'classname)) (r1 integer) (c1 integer) (r2 integer) (c2 integer))
  (#.(lispify "btMatrix3x3_cofac" 'function) (ff-pointer self) r1 c1 r2 c2))

(defmethod #.(lispify "serialize" 'method) ((self #.(lispify "bt-matrix3x3" 'classname)) dataOut)
  (#.(lispify "btMatrix3x3_serialize" 'function) (ff-pointer self) dataOut))

(defmethod #.(lispify "serialize-float" 'method) ((self #.(lispify "bt-matrix3x3" 'classname)) dataOut)
  (#.(lispify "btMatrix3x3_serializeFloat" 'function) (ff-pointer self) dataOut))

(defmethod #.(lispify "de-serialize" 'method) ((self #.(lispify "bt-matrix3x3" 'classname)) dataIn)
  (#.(lispify "btMatrix3x3_deSerialize" 'function) (ff-pointer self) dataIn))

(defmethod #.(lispify "de-serialize-float" 'method) ((self #.(lispify "bt-matrix3x3" 'classname)) dataIn)
  (#.(lispify "btMatrix3x3_deSerializeFloat" 'function) (ff-pointer self) dataIn))

(defmethod #.(lispify "de-serialize-double" 'method) ((self #.(lispify "bt-matrix3x3" 'classname)) dataIn)
  (#.(lispify "btMatrix3x3_deSerializeDouble" 'function) (ff-pointer self) dataIn))



(defmethod initialize-instance :after ((obj #.(lispify "bt-transform" 'class)) &key)
  (setf (slot-value obj 'ff-pointer) (#.(lispify "new_btTransform" 'function))))

(defmethod initialize-instance :after ((obj #.(lispify "bt-transform" 'class)) &key (q #.(lispify "bt-quaternion" 'classname)) (c #.(lispify "bt-vector3" 'classname)))
  (setf (slot-value obj 'ff-pointer) (#.(lispify "new_btTransform" 'function) q c)))

(defmethod initialize-instance :after ((obj #.(lispify "bt-transform" 'class)) &key (q #.(lispify "bt-quaternion" 'classname)))
  (setf (slot-value obj 'ff-pointer) (#.(lispify "new_btTransform" 'function) q)))

(defmethod initialize-instance :after ((obj #.(lispify "bt-transform" 'class)) &key (b #.(lispify "bt-matrix3x3" 'classname)) (c #.(lispify "bt-vector3" 'classname)))
  (setf (slot-value obj 'ff-pointer) (#.(lispify "new_btTransform" 'function) b c)))

(defmethod initialize-instance :after ((obj #.(lispify "bt-transform" 'class)) &key (b #.(lispify "bt-matrix3x3" 'classname)))
  (setf (slot-value obj 'ff-pointer) (#.(lispify "new_btTransform" 'function) b)))

(defmethod initialize-instance :after ((obj #.(lispify "bt-transform" 'class)) &key (other #.(lispify "bt-transform" 'classname)))
  (setf (slot-value obj 'ff-pointer) (#.(lispify "new_btTransform" 'function) (ff-pointer other))))

(shadow "=")
(defmethod #.(lispify "=" 'method) ((self #.(lispify "bt-transform" 'classname)) (other #.(lispify "bt-transform" 'classname)))
  (#.(lispify "btTransform_assignValue" 'function) (ff-pointer self) (ff-pointer other)))

(defmethod #.(lispify "mult" 'method) ((self #.(lispify "bt-transform" 'classname)) (t1 #.(lispify "bt-transform" 'classname)) (t2 #.(lispify "bt-transform" 'classname)))
  (#.(lispify "btTransform_mult" 'function) (ff-pointer self) (ff-pointer t1) (ff-pointer t2)))

(shadow "()")
(defmethod #.(lispify "()" 'method) ((self #.(lispify "bt-transform" 'classname)) (x #.(lispify "bt-vector3" 'classname)))
  (#.(lispify "btTransform___funcall__" 'function) (ff-pointer self) x))

(shadow "*")
(defmethod #.(lispify "*" 'method) ((self #.(lispify "bt-transform" 'classname)) (x #.(lispify "bt-vector3" 'classname)))
  (#.(lispify "btTransform_multiply" 'function) (ff-pointer self) x))

(shadow "*")
(defmethod #.(lispify "*" 'method) ((self #.(lispify "bt-transform" 'classname)) (q #.(lispify "bt-quaternion" 'classname)))
  (#.(lispify "btTransform_multiply" 'function) (ff-pointer self) q))

(defmethod #.(lispify "get-basis" 'method) ((self #.(lispify "bt-transform" 'classname)))
  (#.(lispify "btTransform_getBasis" 'function) (ff-pointer self)))

(defmethod #.(lispify "get-basis" 'method) ((self #.(lispify "bt-transform" 'classname)))
  (#.(lispify "btTransform_getBasis" 'function) (ff-pointer self)))

(defmethod #.(lispify "get-origin" 'method) ((self #.(lispify "bt-transform" 'classname)))
  (#.(lispify "btTransform_getOrigin" 'function) (ff-pointer self)))

(defmethod #.(lispify "get-origin" 'method) ((self #.(lispify "bt-transform" 'classname)))
  (#.(lispify "btTransform_getOrigin" 'function) (ff-pointer self)))

(defmethod #.(lispify "get-rotation" 'method) ((self #.(lispify "bt-transform" 'classname)))
  (#.(lispify "btTransform_getRotation" 'function) (ff-pointer self)))

(defmethod #.(lispify "set-from-open-glmatrix" 'method) ((self #.(lispify "bt-transform" 'classname)) m)
  (#.(lispify "btTransform_setFromOpenGLMatrix" 'function) (ff-pointer self) m))

(defmethod #.(lispify "get-open-glmatrix" 'method) ((self #.(lispify "bt-transform" 'classname)) m)
  (#.(lispify "btTransform_getOpenGLMatrix" 'function) (ff-pointer self) m))

(defmethod #.(lispify "set-origin" 'method) ((self #.(lispify "bt-transform" 'classname)) (origin #.(lispify "bt-vector3" 'classname)))
  (#.(lispify "btTransform_setOrigin" 'function) (ff-pointer self) origin))

(defmethod #.(lispify "inv-xform" 'method) ((self #.(lispify "bt-transform" 'classname)) (inVec #.(lispify "bt-vector3" 'classname)))
  (#.(lispify "btTransform_invXform" 'function) (ff-pointer self) inVec))

(defmethod #.(lispify "set-basis" 'method) ((self #.(lispify "bt-transform" 'classname)) (basis #.(lispify "bt-matrix3x3" 'classname)))
  (#.(lispify "btTransform_setBasis" 'function) (ff-pointer self) basis))

(defmethod #.(lispify "set-rotation" 'method) ((self #.(lispify "bt-transform" 'classname)) (q #.(lispify "bt-quaternion" 'classname)))
  (#.(lispify "btTransform_setRotation" 'function) (ff-pointer self) q))

(defmethod #.(lispify "set-identity" 'method) ((self #.(lispify "bt-transform" 'classname)))
  (#.(lispify "btTransform_setIdentity" 'function) (ff-pointer self)))

(shadow "*=")
(defmethod #.(lispify "*=" 'method) ((self #.(lispify "bt-transform" 'classname)) (t-arg1 #.(lispify "bt-transform" 'classname)))
  (#.(lispify "btTransform_multiplyAndAssign" 'function) (ff-pointer self) (ff-pointer t-arg1)))

(defmethod #.(lispify "inverse" 'method) ((self #.(lispify "bt-transform" 'classname)))
  (#.(lispify "btTransform_inverse" 'function) (ff-pointer self)))

(defmethod #.(lispify "inverse-times" 'method) ((self #.(lispify "bt-transform" 'classname)) (t-arg1 #.(lispify "bt-transform" 'classname)))
  (#.(lispify "btTransform_inverseTimes" 'function) (ff-pointer self) (ff-pointer t-arg1)))

(shadow "*")
(defmethod #.(lispify "*" 'method) ((self #.(lispify "bt-transform" 'classname)) (t-arg1 #.(lispify "bt-transform" 'classname)))
  (#.(lispify "btTransform_multiply" 'function) (ff-pointer self) (ff-pointer t-arg1)))

(defmethod #.(lispify "serialize" 'method) ((self #.(lispify "bt-transform" 'classname)) dataOut)
  (#.(lispify "btTransform_serialize" 'function) (ff-pointer self) dataOut))

(defmethod #.(lispify "serialize-float" 'method) ((self #.(lispify "bt-transform" 'classname)) dataOut)
  (#.(lispify "btTransform_serializeFloat" 'function) (ff-pointer self) dataOut))

(defmethod #.(lispify "de-serialize" 'method) ((self #.(lispify "bt-transform" 'classname)) dataIn)
  (#.(lispify "btTransform_deSerialize" 'function) (ff-pointer self) dataIn))

(defmethod #.(lispify "de-serialize-double" 'method) ((self #.(lispify "bt-transform" 'classname)) dataIn)
  (#.(lispify "btTransform_deSerializeDouble" 'function) (ff-pointer self) dataIn))

(defmethod #.(lispify "de-serialize-float" 'method) ((self #.(lispify "bt-transform" 'classname)) dataIn)
  (#.(lispify "btTransform_deSerializeFloat" 'function) (ff-pointer self) dataIn))



(defmethod #.(lispify "get-world-transform" 'method) ((self #.(lispify "bt-motion-state" 'classname)) (worldTrans #.(lispify "bt-transform" 'classname)))
  (#.(lispify "btMotionState_getWorldTransform" 'function) (ff-pointer self) worldTrans))

(defmethod #.(lispify "set-world-transform" 'method) ((self #.(lispify "bt-motion-state" 'classname)) (worldTrans #.(lispify "bt-transform" 'classname)))
  (#.(lispify "btMotionState_setWorldTransform" 'function) (ff-pointer self) worldTrans))

(defmethod #.(lispify "debug-draw-object" 'method) ((self #.(lispify "bt-collision-world" 'classname)) (worldTransform #.(lispify "bt-transform" 'classname)) shape (color #.(lispify "bt-vector3" 'classname)))  (#.(lispify "btCollisionWorld_debugDrawObject" 'function) (ff-pointer self) worldTransform shape color))

(defmethod #.(lispify "ray-test" 'method) ((self #.(lispify "bt-collision-world" 'classname)) (rayFromWorld #.(lispify "bt-vector3" 'classname)) (rayToWorld #.(lispify "bt-vector3" 'classname)) resultCallback)
           (#.(lispify "btCollisionWorld_rayTest" 'function) (ff-pointer self) rayFromWorld rayToWorld resultCallback))

(defmethod #.(lispify "new" 'method) ((self #.(lispify "bt-collision-object" 'classname)) sizeInBytes)
  (#.(lispify "btCollisionObject_makeCPlusPlusInstance" 'function) (ff-pointer self) sizeInBytes))

(defmethod #.(lispify "delete" 'method) ((self #.(lispify "bt-collision-object" 'classname)) ptr)
  (#.(lispify "btCollisionObject_deleteCPlusPlusInstance" 'function) (ff-pointer self) ptr))

(defmethod #.(lispify "new" 'method) ((self #.(lispify "bt-collision-object" 'classname)) arg1 ptr)
  (#.(lispify "btCollisionObject_makeCPlusPlusInstance" 'function) (ff-pointer self) arg1 ptr))

(defmethod #.(lispify "delete" 'method) ((self #.(lispify "bt-collision-object" 'classname)) arg1 arg2)
  (#.(lispify "btCollisionObject_deleteCPlusPlusInstance" 'function) (ff-pointer self) arg1 arg2))

(shadow "new[]")
(defmethod #.(lispify "new[]" 'method) ((self #.(lispify "bt-collision-object" 'classname)) sizeInBytes)
  (#.(lispify "btCollisionObject_makeCPlusArray" 'function) (ff-pointer self) sizeInBytes))

(shadow "delete[]")
(defmethod #.(lispify "delete[]" 'method) ((self #.(lispify "bt-collision-object" 'classname)) ptr)
  (#.(lispify "btCollisionObject_deleteCPlusArray" 'function) (ff-pointer self) ptr))

(shadow "new[]")
(defmethod #.(lispify "new[]" 'method) ((self #.(lispify "bt-collision-object" 'classname)) arg1 ptr)
  (#.(lispify "btCollisionObject_makeCPlusArray" 'function) (ff-pointer self) arg1 ptr))

(shadow "delete[]")
(defmethod #.(lispify "delete[]" 'method) ((self #.(lispify "bt-collision-object" 'classname)) arg1 arg2)
  (#.(lispify "btCollisionObject_deleteCPlusArray" 'function) (ff-pointer self) arg1 arg2))

;; (defmethod #.(lispify "set-anisotropic-friction" 'method) ((self #.(lispify "bt-collision-object" 'classname)) (anisotropicFriction #.(lispify "bt-vector3" 'classname)) (frictionMode integer))
;; (defmethod #.(lispify "set-anisotropic-friction" 'method) ((self #.(lispify "bt-collision-object" 'classname)) (anisotropicFriction #.(lispify "bt-vector3" 'classname)))

;; (defmethod #.(lispify "set-world-transform" 'method) ((self #.(lispify "bt-collision-object" 'classname)) (worldTrans #.(lispify "bt-transform" 'classname)))
(defmethod #.(lispify "set-interpolation-world-transform" 'method) ((self #.(lispify "bt-collision-object" 'classname)) (trans #.(lispify "bt-transform" 'classname)))  (#.(lispify "btCollisionObject_setInterpolationWorldTransform" 'function) (ff-pointer self) trans))

(defmethod #.(lispify "set-interpolation-linear-velocity" 'method) ((self #.(lispify "bt-collision-object" 'classname)) (linvel #.(lispify "bt-vector3" 'classname)))  (#.(lispify "btCollisionObject_setInterpolationWorldTransform" 'function) (ff-pointer self) trans))

(defmethod #.(lispify "set-interpolation-angular-velocity" 'method) ((self #.(lispify "bt-collision-object" 'classname)) (angvel #.(lispify "bt-vector3" 'classname)))
           (#.(lispify "btCollisionObject_setInterpolationWorldTransform" 'function) (ff-pointer self) trans))



(defmethod #.(lispify "new" 'method) ((self #.(lispify "bt-box-shape" 'classname)) sizeInBytes)
  (#.(lispify "btBoxShape_makeCPlusPlusInstance" 'function) (ff-pointer self) sizeInBytes))

(defmethod #.(lispify "delete" 'method) ((self #.(lispify "bt-box-shape" 'classname)) ptr)
  (#.(lispify "btBoxShape_deleteCPlusPlusInstance" 'function) (ff-pointer self) ptr))

(defmethod #.(lispify "new" 'method) ((self #.(lispify "bt-box-shape" 'classname)) arg1 ptr)
  (#.(lispify "btBoxShape_makeCPlusPlusInstance" 'function) (ff-pointer self) arg1 ptr))

(defmethod #.(lispify "delete" 'method) ((self #.(lispify "bt-box-shape" 'classname)) arg1 arg2)
  (#.(lispify "btBoxShape_deleteCPlusPlusInstance" 'function) (ff-pointer self) arg1 arg2))
(shadow "new[]")
(defmethod #.(lispify "new[]" 'method) ((self #.(lispify "bt-box-shape" 'classname)) sizeInBytes)
  (#.(lispify "btBoxShape_makeCPlusArray" 'function) (ff-pointer self) sizeInBytes))
(shadow "delete[]")
(defmethod #.(lispify "delete[]" 'method) ((self #.(lispify "bt-box-shape" 'classname)) ptr)
  (#.(lispify "btBoxShape_deleteCPlusArray" 'function) (ff-pointer self) ptr))
(shadow "new[]")
(defmethod #.(lispify "new[]" 'method) ((self #.(lispify "bt-box-shape" 'classname)) arg1 ptr)
  (#.(lispify "btBoxShape_makeCPlusArray" 'function) (ff-pointer self) arg1 ptr))
(shadow "delete[]")
(defmethod #.(lispify "delete[]" 'method) ((self #.(lispify "bt-box-shape" 'classname)) arg1 arg2)
  (#.(lispify "btBoxShape_deleteCPlusArray" 'function) (ff-pointer self) arg1 arg2))
(defmethod #.(lispify "get-half-extents-with-margin" 'method) ((self #.(lispify "bt-box-shape" 'classname)))
  (#.(lispify "btBoxShape_getHalfExtentsWithMargin" 'function) (ff-pointer self)))
(defmethod #.(lispify "get-half-extents-without-margin" 'method) ((self #.(lispify "bt-box-shape" 'classname)))
  (#.(lispify "btBoxShape_getHalfExtentsWithoutMargin" 'function) (ff-pointer self)))
(defmethod #.(lispify "local-get-supporting-vertex" 'method) ((self #.(lispify "bt-box-shape" 'classname)) (vec #.(lispify "bt-vector3" 'classname)))
  (#.(lispify "btBoxShape_localGetSupportingVertex" 'function) (ff-pointer self) vec))
(defmethod #.(lispify "local-get-supporting-vertex-without-margin" 'method) ((self #.(lispify "bt-box-shape" 'classname)) (vec #.(lispify "bt-vector3" 'classname)))
  (#.(lispify "btBoxShape_localGetSupportingVertexWithoutMargin" 'function) (ff-pointer self) vec))
(defmethod #.(lispify "batched-unit-vector-get-supporting-vertex-without-margin" 'method) ((self #.(lispify "bt-box-shape" 'classname)) (vectors #.(lispify "bt-vector3" 'classname)) (supportVerticesOut #.(lispify "bt-vector3" 'classname)) (numVectors integer))
  (#.(lispify "btBoxShape_batchedUnitVectorGetSupportingVertexWithoutMargin" 'function) (ff-pointer self) vectors supportVerticesOut numVectors))
(defmethod initialize-instance :after ((obj #.(lispify "bt-box-shape" 'class)) &key (boxHalfExtents #.(lispify "bt-vector3" 'classname)))
  (setf (slot-value obj 'ff-pointer) (#.(lispify "new_btBoxShape" 'function) boxHalfExtents)))
(defmethod #.(lispify "set-margin" 'method) ((self #.(lispify "bt-box-shape" 'classname)) (collisionMargin number))
  (#.(lispify "btBoxShape_setMargin" 'function) (ff-pointer self) collisionMargin))
(defmethod #.(lispify "set-local-scaling" 'method) ((self #.(lispify "bt-box-shape" 'classname)) (scaling #.(lispify "bt-vector3" 'classname)))
  (#.(lispify "btBoxShape_setLocalScaling" 'function) (ff-pointer self) scaling))
(defmethod #.(lispify "get-aabb" 'method) ((self #.(lispify "bt-box-shape" 'classname)) (t-arg1 #.(lispify "bt-transform" 'classname)) (aabbMin #.(lispify "bt-vector3" 'classname)) (aabbMax #.(lispify "bt-vector3" 'classname)))
  (#.(lispify "btBoxShape_getAabb" 'function) (ff-pointer self) t-arg1 aabbMin aabbMax))
(defmethod #.(lispify "calculate-local-inertia" 'method) ((self #.(lispify "bt-box-shape" 'classname)) (mass number) (inertia #.(lispify "bt-vector3" 'classname)))
  (#.(lispify "btBoxShape_calculateLocalInertia" 'function) (ff-pointer self) mass inertia))
(defmethod #.(lispify "get-plane" 'method) ((self #.(lispify "bt-box-shape" 'classname)) (planeNormal #.(lispify "bt-vector3" 'classname)) (planeSupport #.(lispify "bt-vector3" 'classname)) (i integer))
  (#.(lispify "btBoxShape_getPlane" 'function) (ff-pointer self) planeNormal planeSupport i))
(defmethod #.(lispify "get-num-planes" 'method) ((self #.(lispify "bt-box-shape" 'classname)))
  (#.(lispify "btBoxShape_getNumPlanes" 'function) (ff-pointer self)))
(defmethod #.(lispify "get-num-vertices" 'method) ((self #.(lispify "bt-box-shape" 'classname)))
  (#.(lispify "btBoxShape_getNumVertices" 'function) (ff-pointer self)))
(defmethod #.(lispify "get-num-edges" 'method) ((self #.(lispify "bt-box-shape" 'classname)))
  (#.(lispify "btBoxShape_getNumEdges" 'function) (ff-pointer self)))
(defmethod #.(lispify "get-vertex" 'method) ((self #.(lispify "bt-box-shape" 'classname)) (i integer) (vtx #.(lispify "bt-vector3" 'classname)))
  (#.(lispify "btBoxShape_getVertex" 'function) (ff-pointer self) i vtx))
(defmethod #.(lispify "get-plane-equation" 'method) ((self #.(lispify "bt-box-shape" 'classname)) (plane #.(lispify "bt-vector4" 'classname)) (i integer))
  (#.(lispify "btBoxShape_getPlaneEquation" 'function) (ff-pointer self) plane i))
(defmethod #.(lispify "get-edge" 'method) ((self #.(lispify "bt-box-shape" 'classname)) (i integer) (pa #.(lispify "bt-vector3" 'classname)) (pb #.(lispify "bt-vector3" 'classname)))
  (#.(lispify "btBoxShape_getEdge" 'function) (ff-pointer self) i pa pb))

(defmethod #.(lispify "is-inside" 'method) ((self #.(lispify "bt-box-shape" 'classname)) (pt #.(lispify "bt-vector3" 'classname)) (tolerance number))
  (#.(lispify "btBoxShape_isInside" 'function) (ff-pointer self) pt tolerance))

(defmethod #.(lispify "get-name" 'method) ((self #.(lispify "bt-box-shape" 'classname)))
  (#.(lispify "btBoxShape_getName" 'function) (ff-pointer self)))

(defmethod #.(lispify "get-num-preferred-penetration-directions" 'method) ((self #.(lispify "bt-box-shape" 'classname)))
  (#.(lispify "btBoxShape_getNumPreferredPenetrationDirections" 'function) (ff-pointer self)))

(defmethod #.(lispify "get-preferred-penetration-direction" 'method) ((self #.(lispify "bt-box-shape" 'classname)) (index integer) (penetrationVector #.(lispify "bt-vector3" 'classname)))
  (#.(lispify "btBoxShape_getPreferredPenetrationDirection" 'function) (ff-pointer self) index penetrationVector))



(defmethod #.(lispify "new" 'method) ((self #.(lispify "bt-sphere-shape" 'classname)) sizeInBytes)
  (#.(lispify "btSphereShape_makeCPlusPlusInstance" 'function) (ff-pointer self) sizeInBytes))

(defmethod #.(lispify "delete" 'method) ((self #.(lispify "bt-sphere-shape" 'classname)) ptr)
  (#.(lispify "btSphereShape_deleteCPlusPlusInstance" 'function) (ff-pointer self) ptr))

(defmethod #.(lispify "new" 'method) ((self #.(lispify "bt-sphere-shape" 'classname)) arg1 ptr)
  (#.(lispify "btSphereShape_makeCPlusPlusInstance" 'function) (ff-pointer self) arg1 ptr))

(defmethod #.(lispify "delete" 'method) ((self #.(lispify "bt-sphere-shape" 'classname)) arg1 arg2)
  (#.(lispify "btSphereShape_deleteCPlusPlusInstance" 'function) (ff-pointer self) arg1 arg2))

(shadow "new[]")
(defmethod #.(lispify "new[]" 'method) ((self #.(lispify "bt-sphere-shape" 'classname)) sizeInBytes)
  (#.(lispify "btSphereShape_makeCPlusArray" 'function) (ff-pointer self) sizeInBytes))

(shadow "delete[]")
(defmethod #.(lispify "delete[]" 'method) ((self #.(lispify "bt-sphere-shape" 'classname)) ptr)
  (#.(lispify "btSphereShape_deleteCPlusArray" 'function) (ff-pointer self) ptr))

(shadow "new[]")
(defmethod #.(lispify "new[]" 'method) ((self #.(lispify "bt-sphere-shape" 'classname)) arg1 ptr)
  (#.(lispify "btSphereShape_makeCPlusArray" 'function) (ff-pointer self) arg1 ptr))

(shadow "delete[]")
(defmethod #.(lispify "delete[]" 'method) ((self #.(lispify "bt-sphere-shape" 'classname)) arg1 arg2)
  (#.(lispify "btSphereShape_deleteCPlusArray" 'function) (ff-pointer self) arg1 arg2))

(defmethod initialize-instance :after ((obj #.(lispify "bt-sphere-shape" 'class)) &key (radius number))
  (setf (slot-value obj 'ff-pointer) (#.(lispify "new_btSphereShape" 'function) radius)))

(defmethod #.(lispify "local-get-supporting-vertex" 'method) ((self #.(lispify "bt-sphere-shape" 'classname)) (vec #.(lispify "bt-vector3" 'classname)))
  (#.(lispify "btSphereShape_localGetSupportingVertex" 'function) (ff-pointer self) vec))

(defmethod #.(lispify "local-get-supporting-vertex-without-margin" 'method) ((self #.(lispify "bt-sphere-shape" 'classname)) (vec #.(lispify "bt-vector3" 'classname)))
  (#.(lispify "btSphereShape_localGetSupportingVertexWithoutMargin" 'function) (ff-pointer self) vec))

(defmethod #.(lispify "batched-unit-vector-get-supporting-vertex-without-margin" 'method) ((self #.(lispify "bt-sphere-shape" 'classname)) (vectors #.(lispify "bt-vector3" 'classname)) (supportVerticesOut #.(lispify "bt-vector3" 'classname)) (numVectors integer))
  (#.(lispify "btSphereShape_batchedUnitVectorGetSupportingVertexWithoutMargin" 'function) (ff-pointer self) vectors supportVerticesOut numVectors))

(defmethod #.(lispify "calculate-local-inertia" 'method) ((self #.(lispify "bt-sphere-shape" 'classname)) (mass number) (inertia #.(lispify "bt-vector3" 'classname)))
  (#.(lispify "btSphereShape_calculateLocalInertia" 'function) (ff-pointer self) mass inertia))

(defmethod #.(lispify "get-aabb" 'method) ((self #.(lispify "bt-sphere-shape" 'classname)) (t-arg1 #.(lispify "bt-transform" 'classname)) (aabbMin #.(lispify "bt-vector3" 'classname)) (aabbMax #.(lispify "bt-vector3" 'classname)))
  (#.(lispify "btSphereShape_getAabb" 'function) (ff-pointer self) t-arg1 aabbMin aabbMax))

(defmethod #.(lispify "get-radius" 'method) ((self #.(lispify "bt-sphere-shape" 'classname)))
  (#.(lispify "btSphereShape_getRadius" 'function) (ff-pointer self)))

(defmethod #.(lispify "set-unscaled-radius" 'method) ((self #.(lispify "bt-sphere-shape" 'classname)) (radius number))
  (#.(lispify "btSphereShape_setUnscaledRadius" 'function) (ff-pointer self) radius))

(defmethod #.(lispify "get-name" 'method) ((self #.(lispify "bt-sphere-shape" 'classname)))
  (#.(lispify "btSphereShape_getName" 'function) (ff-pointer self)))

(defmethod #.(lispify "set-margin" 'method) ((self #.(lispify "bt-sphere-shape" 'classname)) (margin number))
  (#.(lispify "btSphereShape_setMargin" 'function) (ff-pointer self) margin))

(defmethod #.(lispify "get-margin" 'method) ((self #.(lispify "bt-sphere-shape" 'classname)))
  (#.(lispify "btSphereShape_getMargin" 'function) (ff-pointer self)))



(defmethod #.(lispify "new" 'method) ((self #.(lispify "bt-capsule-shape" 'classname)) sizeInBytes)
  (#.(lispify "btCapsuleShape_makeCPlusPlusInstance" 'function) (ff-pointer self) sizeInBytes))

(defmethod #.(lispify "delete" 'method) ((self #.(lispify "bt-capsule-shape" 'classname)) ptr)
  (#.(lispify "btCapsuleShape_deleteCPlusPlusInstance" 'function) (ff-pointer self) ptr))

(defmethod #.(lispify "new" 'method) ((self #.(lispify "bt-capsule-shape" 'classname)) arg1 ptr)
  (#.(lispify "btCapsuleShape_makeCPlusPlusInstance" 'function) (ff-pointer self) arg1 ptr))

(defmethod #.(lispify "delete" 'method) ((self #.(lispify "bt-capsule-shape" 'classname)) arg1 arg2)
  (#.(lispify "btCapsuleShape_deleteCPlusPlusInstance" 'function) (ff-pointer self) arg1 arg2))

(shadow "new[]")
(defmethod #.(lispify "new[]" 'method) ((self #.(lispify "bt-capsule-shape" 'classname)) sizeInBytes)
  (#.(lispify "btCapsuleShape_makeCPlusArray" 'function) (ff-pointer self) sizeInBytes))

(shadow "delete[]")
(defmethod #.(lispify "delete[]" 'method) ((self #.(lispify "bt-capsule-shape" 'classname)) ptr)
  (#.(lispify "btCapsuleShape_deleteCPlusArray" 'function) (ff-pointer self) ptr))

(shadow "new[]")
(defmethod #.(lispify "new[]" 'method) ((self #.(lispify "bt-capsule-shape" 'classname)) arg1 ptr)
  (#.(lispify "btCapsuleShape_makeCPlusArray" 'function) (ff-pointer self) arg1 ptr))

(shadow "delete[]")
(defmethod #.(lispify "delete[]" 'method) ((self #.(lispify "bt-capsule-shape" 'classname)) arg1 arg2)
  (#.(lispify "btCapsuleShape_deleteCPlusArray" 'function) (ff-pointer self) arg1 arg2))

(defmethod initialize-instance :after ((obj #.(lispify "bt-capsule-shape" 'class)) &key (radius number) (height number))
  (setf (slot-value obj 'ff-pointer) (#.(lispify "new_btCapsuleShape" 'function) radius height)))

(defmethod #.(lispify "calculate-local-inertia" 'method) ((self #.(lispify "bt-capsule-shape" 'classname)) (mass number) (inertia #.(lispify "bt-vector3" 'classname)))
  (#.(lispify "btCapsuleShape_calculateLocalInertia" 'function) (ff-pointer self) mass inertia))

(defmethod #.(lispify "local-get-supporting-vertex-without-margin" 'method) ((self #.(lispify "bt-capsule-shape" 'classname)) (vec #.(lispify "bt-vector3" 'classname)))
  (#.(lispify "btCapsuleShape_localGetSupportingVertexWithoutMargin" 'function) (ff-pointer self) vec))

(defmethod #.(lispify "batched-unit-vector-get-supporting-vertex-without-margin" 'method) ((self #.(lispify "bt-capsule-shape" 'classname)) (vectors #.(lispify "bt-vector3" 'classname)) (supportVerticesOut #.(lispify "bt-vector3" 'classname)) (numVectors integer))
  (#.(lispify "btCapsuleShape_batchedUnitVectorGetSupportingVertexWithoutMargin" 'function) (ff-pointer self) vectors supportVerticesOut numVectors))

(defmethod #.(lispify "set-margin" 'method) ((self #.(lispify "bt-capsule-shape" 'classname)) (collisionMargin number))
  (#.(lispify "btCapsuleShape_setMargin" 'function) (ff-pointer self) collisionMargin))

(defmethod #.(lispify "get-aabb" 'method) ((self #.(lispify "bt-capsule-shape" 'classname)) (t-arg1 #.(lispify "bt-transform" 'classname)) (aabbMin #.(lispify "bt-vector3" 'classname)) (aabbMax #.(lispify "bt-vector3" 'classname)))
  (#.(lispify "btCapsuleShape_getAabb" 'function) (ff-pointer self) t-arg1 aabbMin aabbMax))

(defmethod #.(lispify "get-name" 'method) ((self #.(lispify "bt-capsule-shape" 'classname)))
  (#.(lispify "btCapsuleShape_getName" 'function) (ff-pointer self)))

(defmethod #.(lispify "get-up-axis" 'method) ((self #.(lispify "bt-capsule-shape" 'classname)))
  (#.(lispify "btCapsuleShape_getUpAxis" 'function) (ff-pointer self)))

(defmethod #.(lispify "get-radius" 'method) ((self #.(lispify "bt-capsule-shape" 'classname)))
  (#.(lispify "btCapsuleShape_getRadius" 'function) (ff-pointer self)))

(defmethod #.(lispify "get-half-height" 'method) ((self #.(lispify "bt-capsule-shape" 'classname)))
  (#.(lispify "btCapsuleShape_getHalfHeight" 'function) (ff-pointer self)))

(defmethod #.(lispify "set-local-scaling" 'method) ((self #.(lispify "bt-capsule-shape" 'classname)) (scaling #.(lispify "bt-vector3" 'classname)))
  (#.(lispify "btCapsuleShape_setLocalScaling" 'function) (ff-pointer self) scaling))

(defmethod #.(lispify "get-anisotropic-rolling-friction-direction" 'method) ((self #.(lispify "bt-capsule-shape" 'classname)))
  (#.(lispify "btCapsuleShape_getAnisotropicRollingFrictionDirection" 'function) (ff-pointer self)))

(defmethod #.(lispify "calculate-serialize-buffer-size" 'method) ((self #.(lispify "bt-capsule-shape" 'classname)))
  (#.(lispify "btCapsuleShape_calculateSerializeBufferSize" 'function) (ff-pointer self)))

(defmethod #.(lispify "serialize" 'method) ((self #.(lispify "bt-capsule-shape" 'classname)) dataBuffer serializer)
  (#.(lispify "btCapsuleShape_serialize" 'function) (ff-pointer self) dataBuffer serializer))



(defmethod initialize-instance :after ((obj #.(lispify "bt-capsule-shape-x" 'class)) &key (radius number) (height number))
  (setf (slot-value obj 'ff-pointer) (#.(lispify "new_btCapsuleShapeX" 'function) radius height)))

(defmethod #.(lispify "get-name" 'method) ((self #.(lispify "bt-capsule-shape-x" 'classname)))
  (#.(lispify "btCapsuleShapeX_getName" 'function) (ff-pointer self)))



(defmethod initialize-instance :after ((obj #.(lispify "bt-capsule-shape-z" 'class)) &key (radius number) (height number))
  (setf (slot-value obj 'ff-pointer) (#.(lispify "new_btCapsuleShapeZ" 'function) radius height)))

(defmethod #.(lispify "get-name" 'method) ((self #.(lispify "bt-capsule-shape-z" 'classname)))
  (#.(lispify "btCapsuleShapeZ_getName" 'function) (ff-pointer self)))



(defmethod #.(lispify "new" 'method) ((self #.(lispify "bt-cylinder-shape" 'classname)) sizeInBytes)
  (#.(lispify "btCylinderShape_makeCPlusPlusInstance" 'function) (ff-pointer self) sizeInBytes))

(defmethod #.(lispify "delete" 'method) ((self #.(lispify "bt-cylinder-shape" 'classname)) ptr)
  (#.(lispify "btCylinderShape_deleteCPlusPlusInstance" 'function) (ff-pointer self) ptr))

(defmethod #.(lispify "new" 'method) ((self #.(lispify "bt-cylinder-shape" 'classname)) arg1 ptr)
  (#.(lispify "btCylinderShape_makeCPlusPlusInstance" 'function) (ff-pointer self) arg1 ptr))

(defmethod #.(lispify "delete" 'method) ((self #.(lispify "bt-cylinder-shape" 'classname)) arg1 arg2)
  (#.(lispify "btCylinderShape_deleteCPlusPlusInstance" 'function) (ff-pointer self) arg1 arg2))

(shadow "new[]")
(defmethod #.(lispify "new[]" 'method) ((self #.(lispify "bt-cylinder-shape" 'classname)) sizeInBytes)
  (#.(lispify "btCylinderShape_makeCPlusArray" 'function) (ff-pointer self) sizeInBytes))

(shadow "delete[]")
(defmethod #.(lispify "delete[]" 'method) ((self #.(lispify "bt-cylinder-shape" 'classname)) ptr)
  (#.(lispify "btCylinderShape_deleteCPlusArray" 'function) (ff-pointer self) ptr))

(shadow "new[]")
(defmethod #.(lispify "new[]" 'method) ((self #.(lispify "bt-cylinder-shape" 'classname)) arg1 ptr)
  (#.(lispify "btCylinderShape_makeCPlusArray" 'function) (ff-pointer self) arg1 ptr))

(shadow "delete[]")
(defmethod #.(lispify "delete[]" 'method) ((self #.(lispify "bt-cylinder-shape" 'classname)) arg1 arg2)
  (#.(lispify "btCylinderShape_deleteCPlusArray" 'function) (ff-pointer self) arg1 arg2))

(defmethod #.(lispify "get-half-extents-with-margin" 'method) ((self #.(lispify "bt-cylinder-shape" 'classname)))
  (#.(lispify "btCylinderShape_getHalfExtentsWithMargin" 'function) (ff-pointer self)))

(defmethod #.(lispify "get-half-extents-without-margin" 'method) ((self #.(lispify "bt-cylinder-shape" 'classname)))
  (#.(lispify "btCylinderShape_getHalfExtentsWithoutMargin" 'function) (ff-pointer self)))

(defmethod initialize-instance :after ((obj #.(lispify "bt-cylinder-shape" 'class)) &key (halfExtents #.(lispify "bt-vector3" 'classname)))
  (setf (slot-value obj 'ff-pointer) (#.(lispify "new_btCylinderShape" 'function) halfExtents)))

(defmethod #.(lispify "get-aabb" 'method) ((self #.(lispify "bt-cylinder-shape" 'classname)) (t-arg1 #.(lispify "bt-transform" 'classname)) (aabbMin #.(lispify "bt-vector3" 'classname)) (aabbMax #.(lispify "bt-vector3" 'classname)))
  (#.(lispify "btCylinderShape_getAabb" 'function) (ff-pointer self) t-arg1 aabbMin aabbMax))

(defmethod #.(lispify "calculate-local-inertia" 'method) ((self #.(lispify "bt-cylinder-shape" 'classname)) (mass number) (inertia #.(lispify "bt-vector3" 'classname)))
  (#.(lispify "btCylinderShape_calculateLocalInertia" 'function) (ff-pointer self) mass inertia))

(defmethod #.(lispify "local-get-supporting-vertex-without-margin" 'method) ((self #.(lispify "bt-cylinder-shape" 'classname)) (vec #.(lispify "bt-vector3" 'classname)))
  (#.(lispify "btCylinderShape_localGetSupportingVertexWithoutMargin" 'function) (ff-pointer self) vec))

(defmethod #.(lispify "batched-unit-vector-get-supporting-vertex-without-margin" 'method) ((self #.(lispify "bt-cylinder-shape" 'classname)) (vectors #.(lispify "bt-vector3" 'classname)) (supportVerticesOut #.(lispify "bt-vector3" 'classname)) (numVectors integer))
  (#.(lispify "btCylinderShape_batchedUnitVectorGetSupportingVertexWithoutMargin" 'function) (ff-pointer self) vectors supportVerticesOut numVectors))

(defmethod #.(lispify "set-margin" 'method) ((self #.(lispify "bt-cylinder-shape" 'classname)) (collisionMargin number))
  (#.(lispify "btCylinderShape_setMargin" 'function) (ff-pointer self) collisionMargin))

(defmethod #.(lispify "local-get-supporting-vertex" 'method) ((self #.(lispify "bt-cylinder-shape" 'classname)) (vec #.(lispify "bt-vector3" 'classname)))
  (#.(lispify "btCylinderShape_localGetSupportingVertex" 'function) (ff-pointer self) vec))

(defmethod #.(lispify "get-up-axis" 'method) ((self #.(lispify "bt-cylinder-shape" 'classname)))
  (#.(lispify "btCylinderShape_getUpAxis" 'function) (ff-pointer self)))

(defmethod #.(lispify "get-anisotropic-rolling-friction-direction" 'method) ((self #.(lispify "bt-cylinder-shape" 'classname)))
  (#.(lispify "btCylinderShape_getAnisotropicRollingFrictionDirection" 'function) (ff-pointer self)))

(defmethod #.(lispify "get-radius" 'method) ((self #.(lispify "bt-cylinder-shape" 'classname)))
  (#.(lispify "btCylinderShape_getRadius" 'function) (ff-pointer self)))

(defmethod #.(lispify "set-local-scaling" 'method) ((self #.(lispify "bt-cylinder-shape" 'classname)) (scaling #.(lispify "bt-vector3" 'classname)))
  (#.(lispify "btCylinderShape_setLocalScaling" 'function) (ff-pointer self) scaling))

(defmethod #.(lispify "get-name" 'method) ((self #.(lispify "bt-cylinder-shape" 'classname)))
  (#.(lispify "btCylinderShape_getName" 'function) (ff-pointer self)))

(defmethod #.(lispify "calculate-serialize-buffer-size" 'method) ((self #.(lispify "bt-cylinder-shape" 'classname)))
  (#.(lispify "btCylinderShape_calculateSerializeBufferSize" 'function) (ff-pointer self)))

(defmethod #.(lispify "serialize" 'method) ((self #.(lispify "bt-cylinder-shape" 'classname)) dataBuffer serializer)
  (#.(lispify "btCylinderShape_serialize" 'function) (ff-pointer self) dataBuffer serializer))



(defmethod #.(lispify "new" 'method) ((self #.(lispify "bt-cylinder-shape-x" 'classname)) sizeInBytes)
  (#.(lispify "btCylinderShapeX_makeCPlusPlusInstance" 'function) (ff-pointer self) sizeInBytes))

(defmethod #.(lispify "delete" 'method) ((self #.(lispify "bt-cylinder-shape-x" 'classname)) ptr)
  (#.(lispify "btCylinderShapeX_deleteCPlusPlusInstance" 'function) (ff-pointer self) ptr))

(defmethod #.(lispify "new" 'method) ((self #.(lispify "bt-cylinder-shape-x" 'classname)) arg1 ptr)
  (#.(lispify "btCylinderShapeX_makeCPlusPlusInstance" 'function) (ff-pointer self) arg1 ptr))

(defmethod #.(lispify "delete" 'method) ((self #.(lispify "bt-cylinder-shape-x" 'classname)) arg1 arg2)
  (#.(lispify "btCylinderShapeX_deleteCPlusPlusInstance" 'function) (ff-pointer self) arg1 arg2))

(shadow "new[]")
(defmethod #.(lispify "new[]" 'method) ((self #.(lispify "bt-cylinder-shape-x" 'classname)) sizeInBytes)
  (#.(lispify "btCylinderShapeX_makeCPlusArray" 'function) (ff-pointer self) sizeInBytes))

(shadow "delete[]")
(defmethod #.(lispify "delete[]" 'method) ((self #.(lispify "bt-cylinder-shape-x" 'classname)) ptr)
  (#.(lispify "btCylinderShapeX_deleteCPlusArray" 'function) (ff-pointer self) ptr))

(shadow "new[]")
(defmethod #.(lispify "new[]" 'method) ((self #.(lispify "bt-cylinder-shape-x" 'classname)) arg1 ptr)
  (#.(lispify "btCylinderShapeX_makeCPlusArray" 'function) (ff-pointer self) arg1 ptr))

(shadow "delete[]")
(defmethod #.(lispify "delete[]" 'method) ((self #.(lispify "bt-cylinder-shape-x" 'classname)) arg1 arg2)
  (#.(lispify "btCylinderShapeX_deleteCPlusArray" 'function) (ff-pointer self) arg1 arg2))

(defmethod initialize-instance :after ((obj #.(lispify "bt-cylinder-shape-x" 'class)) &key (halfExtents #.(lispify "bt-vector3" 'classname)))
  (setf (slot-value obj 'ff-pointer) (#.(lispify "new_btCylinderShapeX" 'function) halfExtents)))

(defmethod #.(lispify "local-get-supporting-vertex-without-margin" 'method) ((self #.(lispify "bt-cylinder-shape-x" 'classname)) (vec #.(lispify "bt-vector3" 'classname)))
  (#.(lispify "btCylinderShapeX_localGetSupportingVertexWithoutMargin" 'function) (ff-pointer self) vec))

(defmethod #.(lispify "batched-unit-vector-get-supporting-vertex-without-margin" 'method) ((self #.(lispify "bt-cylinder-shape-x" 'classname)) (vectors #.(lispify "bt-vector3" 'classname)) (supportVerticesOut #.(lispify "bt-vector3" 'classname)) (numVectors integer))
  (#.(lispify "btCylinderShapeX_batchedUnitVectorGetSupportingVertexWithoutMargin" 'function) (ff-pointer self) vectors supportVerticesOut numVectors))

(defmethod #.(lispify "get-name" 'method) ((self #.(lispify "bt-cylinder-shape-x" 'classname)))
  (#.(lispify "btCylinderShapeX_getName" 'function) (ff-pointer self)))

(defmethod #.(lispify "get-radius" 'method) ((self #.(lispify "bt-cylinder-shape-x" 'classname)))
  (#.(lispify "btCylinderShapeX_getRadius" 'function) (ff-pointer self)))



(defmethod #.(lispify "new" 'method) ((self #.(lispify "bt-cylinder-shape-z" 'classname)) sizeInBytes)
  (#.(lispify "btCylinderShapeZ_makeCPlusPlusInstance" 'function) (ff-pointer self) sizeInBytes))

(defmethod #.(lispify "delete" 'method) ((self #.(lispify "bt-cylinder-shape-z" 'classname)) ptr)
  (#.(lispify "btCylinderShapeZ_deleteCPlusPlusInstance" 'function) (ff-pointer self) ptr))

(defmethod #.(lispify "new" 'method) ((self #.(lispify "bt-cylinder-shape-z" 'classname)) arg1 ptr)
  (#.(lispify "btCylinderShapeZ_makeCPlusPlusInstance" 'function) (ff-pointer self) arg1 ptr))

(defmethod #.(lispify "delete" 'method) ((self #.(lispify "bt-cylinder-shape-z" 'classname)) arg1 arg2)
  (#.(lispify "btCylinderShapeZ_deleteCPlusPlusInstance" 'function) (ff-pointer self) arg1 arg2))

(shadow "new[]")
(defmethod #.(lispify "new[]" 'method) ((self #.(lispify "bt-cylinder-shape-z" 'classname)) sizeInBytes)
  (#.(lispify "btCylinderShapeZ_makeCPlusArray" 'function) (ff-pointer self) sizeInBytes))

(shadow "delete[]")
(defmethod #.(lispify "delete[]" 'method) ((self #.(lispify "bt-cylinder-shape-z" 'classname)) ptr)
  (#.(lispify "btCylinderShapeZ_deleteCPlusArray" 'function) (ff-pointer self) ptr))

(shadow "new[]")
(defmethod #.(lispify "new[]" 'method) ((self #.(lispify "bt-cylinder-shape-z" 'classname)) arg1 ptr)
  (#.(lispify "btCylinderShapeZ_makeCPlusArray" 'function) (ff-pointer self) arg1 ptr))

(shadow "delete[]")
(defmethod #.(lispify "delete[]" 'method) ((self #.(lispify "bt-cylinder-shape-z" 'classname)) arg1 arg2)
  (#.(lispify "btCylinderShapeZ_deleteCPlusArray" 'function) (ff-pointer self) arg1 arg2))

(defmethod initialize-instance :after ((obj #.(lispify "bt-cylinder-shape-z" 'class)) &key (halfExtents #.(lispify "bt-vector3" 'classname)))
  (setf (slot-value obj 'ff-pointer) (#.(lispify "new_btCylinderShapeZ" 'function) halfExtents)))

(defmethod #.(lispify "local-get-supporting-vertex-without-margin" 'method) ((self #.(lispify "bt-cylinder-shape-z" 'classname)) (vec #.(lispify "bt-vector3" 'classname)))
  (#.(lispify "btCylinderShapeZ_localGetSupportingVertexWithoutMargin" 'function) (ff-pointer self) vec))

(defmethod #.(lispify "batched-unit-vector-get-supporting-vertex-without-margin" 'method) ((self #.(lispify "bt-cylinder-shape-z" 'classname)) (vectors #.(lispify "bt-vector3" 'classname)) (supportVerticesOut #.(lispify "bt-vector3" 'classname)) (numVectors integer))
  (#.(lispify "btCylinderShapeZ_batchedUnitVectorGetSupportingVertexWithoutMargin" 'function) (ff-pointer self) vectors supportVerticesOut numVectors))

(defmethod #.(lispify "get-name" 'method) ((self #.(lispify "bt-cylinder-shape-z" 'classname)))
  (#.(lispify "btCylinderShapeZ_getName" 'function) (ff-pointer self)))

(defmethod #.(lispify "get-radius" 'method) ((self #.(lispify "bt-cylinder-shape-z" 'classname)))
  (#.(lispify "btCylinderShapeZ_getRadius" 'function) (ff-pointer self)))



(defmethod #.(lispify "new" 'method) ((self #.(lispify "bt-cone-shape" 'classname)) sizeInBytes)
  (#.(lispify "btConeShape_makeCPlusPlusInstance" 'function) (ff-pointer self) sizeInBytes))

(defmethod #.(lispify "delete" 'method) ((self #.(lispify "bt-cone-shape" 'classname)) ptr)
  (#.(lispify "btConeShape_deleteCPlusPlusInstance" 'function) (ff-pointer self) ptr))

(defmethod #.(lispify "new" 'method) ((self #.(lispify "bt-cone-shape" 'classname)) arg1 ptr)
  (#.(lispify "btConeShape_makeCPlusPlusInstance" 'function) (ff-pointer self) arg1 ptr))

(defmethod #.(lispify "delete" 'method) ((self #.(lispify "bt-cone-shape" 'classname)) arg1 arg2)
  (#.(lispify "btConeShape_deleteCPlusPlusInstance" 'function) (ff-pointer self) arg1 arg2))

(shadow "new[]")
(defmethod #.(lispify "new[]" 'method) ((self #.(lispify "bt-cone-shape" 'classname)) sizeInBytes)
  (#.(lispify "btConeShape_makeCPlusArray" 'function) (ff-pointer self) sizeInBytes))

(shadow "delete[]")
(defmethod #.(lispify "delete[]" 'method) ((self #.(lispify "bt-cone-shape" 'classname)) ptr)
  (#.(lispify "btConeShape_deleteCPlusArray" 'function) (ff-pointer self) ptr))

(shadow "new[]")
(defmethod #.(lispify "new[]" 'method) ((self #.(lispify "bt-cone-shape" 'classname)) arg1 ptr)
  (#.(lispify "btConeShape_makeCPlusArray" 'function) (ff-pointer self) arg1 ptr))

(shadow "delete[]")
(defmethod #.(lispify "delete[]" 'method) ((self #.(lispify "bt-cone-shape" 'classname)) arg1 arg2)
  (#.(lispify "btConeShape_deleteCPlusArray" 'function) (ff-pointer self) arg1 arg2))

(defmethod initialize-instance :after ((obj #.(lispify "bt-cone-shape" 'class)) &key (radius number) (height number))
  (setf (slot-value obj 'ff-pointer) (#.(lispify "new_btConeShape" 'function) radius height)))

(defmethod #.(lispify "local-get-supporting-vertex" 'method) ((self #.(lispify "bt-cone-shape" 'classname)) (vec #.(lispify "bt-vector3" 'classname)))
  (#.(lispify "btConeShape_localGetSupportingVertex" 'function) (ff-pointer self) vec))

(defmethod #.(lispify "local-get-supporting-vertex-without-margin" 'method) ((self #.(lispify "bt-cone-shape" 'classname)) (vec #.(lispify "bt-vector3" 'classname)))
  (#.(lispify "btConeShape_localGetSupportingVertexWithoutMargin" 'function) (ff-pointer self) vec))

(defmethod #.(lispify "batched-unit-vector-get-supporting-vertex-without-margin" 'method) ((self #.(lispify "bt-cone-shape" 'classname)) (vectors #.(lispify "bt-vector3" 'classname)) (supportVerticesOut #.(lispify "bt-vector3" 'classname)) (numVectors integer))
  (#.(lispify "btConeShape_batchedUnitVectorGetSupportingVertexWithoutMargin" 'function) (ff-pointer self) vectors supportVerticesOut numVectors))

(defmethod #.(lispify "get-radius" 'method) ((self #.(lispify "bt-cone-shape" 'classname)))
  (#.(lispify "btConeShape_getRadius" 'function) (ff-pointer self)))

(defmethod #.(lispify "get-height" 'method) ((self #.(lispify "bt-cone-shape" 'classname)))
  (#.(lispify "btConeShape_getHeight" 'function) (ff-pointer self)))

(defmethod #.(lispify "calculate-local-inertia" 'method) ((self #.(lispify "bt-cone-shape" 'classname)) (mass number) (inertia #.(lispify "bt-vector3" 'classname)))
  (#.(lispify "btConeShape_calculateLocalInertia" 'function) (ff-pointer self) mass inertia))

(defmethod #.(lispify "get-name" 'method) ((self #.(lispify "bt-cone-shape" 'classname)))
  (#.(lispify "btConeShape_getName" 'function) (ff-pointer self)))

(defmethod #.(lispify "set-cone-up-index" 'method) ((self #.(lispify "bt-cone-shape" 'classname)) (upIndex integer))
  (#.(lispify "btConeShape_setConeUpIndex" 'function) (ff-pointer self) upIndex))

(defmethod #.(lispify "get-cone-up-index" 'method) ((self #.(lispify "bt-cone-shape" 'classname)))
  (#.(lispify "btConeShape_getConeUpIndex" 'function) (ff-pointer self)))

(defmethod #.(lispify "get-anisotropic-rolling-friction-direction" 'method) ((self #.(lispify "bt-cone-shape" 'classname)))
  (#.(lispify "btConeShape_getAnisotropicRollingFrictionDirection" 'function) (ff-pointer self)))

(defmethod #.(lispify "set-local-scaling" 'method) ((self #.(lispify "bt-cone-shape" 'classname)) (scaling #.(lispify "bt-vector3" 'classname)))
  (#.(lispify "btConeShape_setLocalScaling" 'function) (ff-pointer self) scaling))

(defmethod #.(lispify "calculate-serialize-buffer-size" 'method) ((self #.(lispify "bt-cone-shape" 'classname)))
  (#.(lispify "btConeShape_calculateSerializeBufferSize" 'function) (ff-pointer self)))

(defmethod #.(lispify "serialize" 'method) ((self #.(lispify "bt-cone-shape" 'classname)) dataBuffer serializer)
  (#.(lispify "btConeShape_serialize" 'function) (ff-pointer self) dataBuffer serializer))



(defmethod initialize-instance :after ((obj #.(lispify "bt-cone-shape-x" 'class)) &key (radius number) (height number))
  (setf (slot-value obj 'ff-pointer) (#.(lispify "new_btConeShapeX" 'function) radius height)))

(defmethod #.(lispify "get-anisotropic-rolling-friction-direction" 'method) ((self #.(lispify "bt-cone-shape-x" 'classname)))
  (#.(lispify "btConeShapeX_getAnisotropicRollingFrictionDirection" 'function) (ff-pointer self)))

(defmethod #.(lispify "get-name" 'method) ((self #.(lispify "bt-cone-shape-x" 'classname)))
  (#.(lispify "btConeShapeX_getName" 'function) (ff-pointer self)))



(defmethod initialize-instance :after ((obj #.(lispify "bt-cone-shape-z" 'class)) &key (radius number) (height number))
  (setf (slot-value obj 'ff-pointer) (#.(lispify "new_btConeShapeZ" 'function) radius height)))

(defmethod #.(lispify "get-anisotropic-rolling-friction-direction" 'method) ((self #.(lispify "bt-cone-shape-z" 'classname)))
  (#.(lispify "btConeShapeZ_getAnisotropicRollingFrictionDirection" 'function) (ff-pointer self)))

(defmethod #.(lispify "get-name" 'method) ((self #.(lispify "bt-cone-shape-z" 'classname)))
  (#.(lispify "btConeShapeZ_getName" 'function) (ff-pointer self)))



(defmethod #.(lispify "new" 'method) ((self #.(lispify "bt-static-plane-shape" 'classname)) sizeInBytes)
  (#.(lispify "btStaticPlaneShape_makeCPlusPlusInstance" 'function) (ff-pointer self) sizeInBytes))

(defmethod #.(lispify "delete" 'method) ((self #.(lispify "bt-static-plane-shape" 'classname)) ptr)
  (#.(lispify "btStaticPlaneShape_deleteCPlusPlusInstance" 'function) (ff-pointer self) ptr))

(defmethod #.(lispify "new" 'method) ((self #.(lispify "bt-static-plane-shape" 'classname)) arg1 ptr)
  (#.(lispify "btStaticPlaneShape_makeCPlusPlusInstance" 'function) (ff-pointer self) arg1 ptr))

(defmethod #.(lispify "delete" 'method) ((self #.(lispify "bt-static-plane-shape" 'classname)) arg1 arg2)
  (#.(lispify "btStaticPlaneShape_deleteCPlusPlusInstance" 'function) (ff-pointer self) arg1 arg2))

(shadow "new[]")
(defmethod #.(lispify "new[]" 'method) ((self #.(lispify "bt-static-plane-shape" 'classname)) sizeInBytes)
  (#.(lispify "btStaticPlaneShape_makeCPlusArray" 'function) (ff-pointer self) sizeInBytes))

(shadow "delete[]")
(defmethod #.(lispify "delete[]" 'method) ((self #.(lispify "bt-static-plane-shape" 'classname)) ptr)
  (#.(lispify "btStaticPlaneShape_deleteCPlusArray" 'function) (ff-pointer self) ptr))

(shadow "new[]")
(defmethod #.(lispify "new[]" 'method) ((self #.(lispify "bt-static-plane-shape" 'classname)) arg1 ptr)
  (#.(lispify "btStaticPlaneShape_makeCPlusArray" 'function) (ff-pointer self) arg1 ptr))

(shadow "delete[]")
(defmethod #.(lispify "delete[]" 'method) ((self #.(lispify "bt-static-plane-shape" 'classname)) arg1 arg2)
  (#.(lispify "btStaticPlaneShape_deleteCPlusArray" 'function) (ff-pointer self) arg1 arg2))

(defmethod initialize-instance :after ((obj #.(lispify "bt-static-plane-shape" 'class)) &key (planeNormal #.(lispify "bt-vector3" 'classname)) (planeConstant number))
  (setf (slot-value obj 'ff-pointer) (#.(lispify "new_btStaticPlaneShape" 'function) planeNormal planeConstant)))

(defmethod #.(lispify "get-aabb" 'method) ((self #.(lispify "bt-static-plane-shape" 'classname)) (t-arg1 #.(lispify "bt-transform" 'classname)) (aabbMin #.(lispify "bt-vector3" 'classname)) (aabbMax #.(lispify "bt-vector3" 'classname)))
  (#.(lispify "btStaticPlaneShape_getAabb" 'function) (ff-pointer self) t-arg1 aabbMin aabbMax))

(defmethod #.(lispify "process-all-triangles" 'method) ((self #.(lispify "bt-static-plane-shape" 'classname)) callback (aabbMin #.(lispify "bt-vector3" 'classname)) (aabbMax #.(lispify "bt-vector3" 'classname)))
  (#.(lispify "btStaticPlaneShape_processAllTriangles" 'function) (ff-pointer self) callback aabbMin aabbMax))

(defmethod #.(lispify "calculate-local-inertia" 'method) ((self #.(lispify "bt-static-plane-shape" 'classname)) (mass number) (inertia #.(lispify "bt-vector3" 'classname)))
  (#.(lispify "btStaticPlaneShape_calculateLocalInertia" 'function) (ff-pointer self) mass inertia))

(defmethod #.(lispify "set-local-scaling" 'method) ((self #.(lispify "bt-static-plane-shape" 'classname)) (scaling #.(lispify "bt-vector3" 'classname)))
  (#.(lispify "btStaticPlaneShape_setLocalScaling" 'function) (ff-pointer self) scaling))

(defmethod #.(lispify "get-local-scaling" 'method) ((self #.(lispify "bt-static-plane-shape" 'classname)))
  (#.(lispify "btStaticPlaneShape_getLocalScaling" 'function) (ff-pointer self)))

(defmethod #.(lispify "get-plane-normal" 'method) ((self #.(lispify "bt-static-plane-shape" 'classname)))
  (#.(lispify "btStaticPlaneShape_getPlaneNormal" 'function) (ff-pointer self)))

(defmethod #.(lispify "get-plane-constant" 'method) ((self #.(lispify "bt-static-plane-shape" 'classname)))
  (#.(lispify "btStaticPlaneShape_getPlaneConstant" 'function) (ff-pointer self)))

(defmethod #.(lispify "get-name" 'method) ((self #.(lispify "bt-static-plane-shape" 'classname)))
  (#.(lispify "btStaticPlaneShape_getName" 'function) (ff-pointer self)))

(defmethod #.(lispify "calculate-serialize-buffer-size" 'method) ((self #.(lispify "bt-static-plane-shape" 'classname)))
  (#.(lispify "btStaticPlaneShape_calculateSerializeBufferSize" 'function) (ff-pointer self)))

(defmethod #.(lispify "serialize" 'method) ((self #.(lispify "bt-static-plane-shape" 'classname)) dataBuffer serializer)
  (#.(lispify "btStaticPlaneShape_serialize" 'function) (ff-pointer self) dataBuffer serializer))



(defmethod #.(lispify "new" 'method) ((self #.(lispify "bt-convex-hull-shape" 'classname)) sizeInBytes)
  (#.(lispify "btConvexHullShape_makeCPlusPlusInstance" 'function) (ff-pointer self) sizeInBytes))

(defmethod #.(lispify "delete" 'method) ((self #.(lispify "bt-convex-hull-shape" 'classname)) ptr)
  (#.(lispify "btConvexHullShape_deleteCPlusPlusInstance" 'function) (ff-pointer self) ptr))

(defmethod #.(lispify "new" 'method) ((self #.(lispify "bt-convex-hull-shape" 'classname)) arg1 ptr)
  (#.(lispify "btConvexHullShape_makeCPlusPlusInstance" 'function) (ff-pointer self) arg1 ptr))

(defmethod #.(lispify "delete" 'method) ((self #.(lispify "bt-convex-hull-shape" 'classname)) arg1 arg2)
  (#.(lispify "btConvexHullShape_deleteCPlusPlusInstance" 'function) (ff-pointer self) arg1 arg2))

(shadow "new[]")
(defmethod #.(lispify "new[]" 'method) ((self #.(lispify "bt-convex-hull-shape" 'classname)) sizeInBytes)
  (#.(lispify "btConvexHullShape_makeCPlusArray" 'function) (ff-pointer self) sizeInBytes))

(shadow "delete[]")
(defmethod #.(lispify "delete[]" 'method) ((self #.(lispify "bt-convex-hull-shape" 'classname)) ptr)
  (#.(lispify "btConvexHullShape_deleteCPlusArray" 'function) (ff-pointer self) ptr))

(shadow "new[]")
(defmethod #.(lispify "new[]" 'method) ((self #.(lispify "bt-convex-hull-shape" 'classname)) arg1 ptr)
  (#.(lispify "btConvexHullShape_makeCPlusArray" 'function) (ff-pointer self) arg1 ptr))

(shadow "delete[]")
(defmethod #.(lispify "delete[]" 'method) ((self #.(lispify "bt-convex-hull-shape" 'classname)) arg1 arg2)
  (#.(lispify "btConvexHullShape_deleteCPlusArray" 'function) (ff-pointer self) arg1 arg2))

(defmethod initialize-instance :after ((obj #.(lispify "bt-convex-hull-shape" 'class)) &key points (numPoints integer) (stride integer))
  (setf (slot-value obj 'ff-pointer) (#.(lispify "new_btConvexHullShape" 'function) points numPoints stride)))

(defmethod initialize-instance :after ((obj #.(lispify "bt-convex-hull-shape" 'class)) &key points (numPoints integer))
  (setf (slot-value obj 'ff-pointer) (#.(lispify "new_btConvexHullShape" 'function) points numPoints)))

(defmethod initialize-instance :after ((obj #.(lispify "bt-convex-hull-shape" 'class)) &key points)
  (setf (slot-value obj 'ff-pointer) (#.(lispify "new_btConvexHullShape" 'function) points)))

(defmethod initialize-instance :after ((obj #.(lispify "bt-convex-hull-shape" 'class)) &key)
  (setf (slot-value obj 'ff-pointer) (#.(lispify "new_btConvexHullShape" 'function))))

(defmethod #.(lispify "add-point" 'method) ((self #.(lispify "bt-convex-hull-shape" 'classname)) (point #.(lispify "bt-vector3" 'classname)) (recalculateLocalAabb t))
  (#.(lispify "btConvexHullShape_addPoint" 'function) (ff-pointer self) point recalculateLocalAabb))

(defmethod #.(lispify "add-point" 'method) ((self #.(lispify "bt-convex-hull-shape" 'classname)) (point #.(lispify "bt-vector3" 'classname)))
  (#.(lispify "btConvexHullShape_addPoint" 'function) (ff-pointer self) point))

(defmethod #.(lispify "get-unscaled-points" 'method) ((self #.(lispify "bt-convex-hull-shape" 'classname)))
  (#.(lispify "btConvexHullShape_getUnscaledPoints" 'function) (ff-pointer self)))

(defmethod #.(lispify "get-unscaled-points" 'method) ((self #.(lispify "bt-convex-hull-shape" 'classname)))
  (#.(lispify "btConvexHullShape_getUnscaledPoints" 'function) (ff-pointer self)))

(defmethod #.(lispify "get-points" 'method) ((self #.(lispify "bt-convex-hull-shape" 'classname)))
  (#.(lispify "btConvexHullShape_getPoints" 'function) (ff-pointer self)))

(defmethod #.(lispify "get-scaled-point" 'method) ((self #.(lispify "bt-convex-hull-shape" 'classname)) (i integer))
  (#.(lispify "btConvexHullShape_getScaledPoint" 'function) (ff-pointer self) i))

(defmethod #.(lispify "get-num-points" 'method) ((self #.(lispify "bt-convex-hull-shape" 'classname)))
  (#.(lispify "btConvexHullShape_getNumPoints" 'function) (ff-pointer self)))

(defmethod #.(lispify "local-get-supporting-vertex" 'method) ((self #.(lispify "bt-convex-hull-shape" 'classname)) (vec #.(lispify "bt-vector3" 'classname)))
  (#.(lispify "btConvexHullShape_localGetSupportingVertex" 'function) (ff-pointer self) vec))

(defmethod #.(lispify "local-get-supporting-vertex-without-margin" 'method) ((self #.(lispify "bt-convex-hull-shape" 'classname)) (vec #.(lispify "bt-vector3" 'classname)))
  (#.(lispify "btConvexHullShape_localGetSupportingVertexWithoutMargin" 'function) (ff-pointer self) vec))

(defmethod #.(lispify "batched-unit-vector-get-supporting-vertex-without-margin" 'method) ((self #.(lispify "bt-convex-hull-shape" 'classname)) (vectors #.(lispify "bt-vector3" 'classname)) (supportVerticesOut #.(lispify "bt-vector3" 'classname)) (numVectors integer))
  (#.(lispify "btConvexHullShape_batchedUnitVectorGetSupportingVertexWithoutMargin" 'function) (ff-pointer self) vectors supportVerticesOut numVectors))

(defmethod #.(lispify "project" 'method) ((self #.(lispify "bt-convex-hull-shape" 'classname)) (trans #.(lispify "bt-transform" 'classname)) (dir #.(lispify "bt-vector3" 'classname)) minProj maxProj (witnesPtMin #.(lispify "bt-vector3" 'classname)) (witnesPtMax #.(lispify "bt-vector3" 'classname)))
  (#.(lispify "btConvexHullShape_project" 'function) (ff-pointer self) trans dir minProj maxProj witnesPtMin witnesPtMax))

(defmethod #.(lispify "get-name" 'method) ((self #.(lispify "bt-convex-hull-shape" 'classname)))
  (#.(lispify "btConvexHullShape_getName" 'function) (ff-pointer self)))

(defmethod #.(lispify "get-num-vertices" 'method) ((self #.(lispify "bt-convex-hull-shape" 'classname)))
  (#.(lispify "btConvexHullShape_getNumVertices" 'function) (ff-pointer self)))

(defmethod #.(lispify "get-num-edges" 'method) ((self #.(lispify "bt-convex-hull-shape" 'classname)))
  (#.(lispify "btConvexHullShape_getNumEdges" 'function) (ff-pointer self)))

(defmethod #.(lispify "get-edge" 'method) ((self #.(lispify "bt-convex-hull-shape" 'classname)) (i integer) (pa #.(lispify "bt-vector3" 'classname)) (pb #.(lispify "bt-vector3" 'classname)))
  (#.(lispify "btConvexHullShape_getEdge" 'function) (ff-pointer self) i pa pb))

(defmethod #.(lispify "get-vertex" 'method) ((self #.(lispify "bt-convex-hull-shape" 'classname)) (i integer) (vtx #.(lispify "bt-vector3" 'classname)))
  (#.(lispify "btConvexHullShape_getVertex" 'function) (ff-pointer self) i vtx))

(defmethod #.(lispify "get-num-planes" 'method) ((self #.(lispify "bt-convex-hull-shape" 'classname)))
  (#.(lispify "btConvexHullShape_getNumPlanes" 'function) (ff-pointer self)))

(defmethod #.(lispify "get-plane" 'method) ((self #.(lispify "bt-convex-hull-shape" 'classname)) (planeNormal #.(lispify "bt-vector3" 'classname)) (planeSupport #.(lispify "bt-vector3" 'classname)) (i integer))
  (#.(lispify "btConvexHullShape_getPlane" 'function) (ff-pointer self) planeNormal planeSupport i))

(defmethod #.(lispify "is-inside" 'method) ((self #.(lispify "bt-convex-hull-shape" 'classname)) (pt #.(lispify "bt-vector3" 'classname)) (tolerance number))
  (#.(lispify "btConvexHullShape_isInside" 'function) (ff-pointer self) pt tolerance))

(defmethod #.(lispify "set-local-scaling" 'method) ((self #.(lispify "bt-convex-hull-shape" 'classname)) (scaling #.(lispify "bt-vector3" 'classname)))
  (#.(lispify "btConvexHullShape_setLocalScaling" 'function) (ff-pointer self) scaling))

(defmethod #.(lispify "calculate-serialize-buffer-size" 'method) ((self #.(lispify "bt-convex-hull-shape" 'classname)))
  (#.(lispify "btConvexHullShape_calculateSerializeBufferSize" 'function) (ff-pointer self)))

(defmethod #.(lispify "serialize" 'method) ((self #.(lispify "bt-convex-hull-shape" 'classname)) dataBuffer serializer)
  (#.(lispify "btConvexHullShape_serialize" 'function) (ff-pointer self) dataBuffer serializer))



(defmethod (setf #.(lispify "m_weldingThreshold" 'method)) (arg0 (obj #.(lispify "bt-triangle-mesh" 'class)))
  (#.(lispify "btTriangleMesh_m_weldingThreshold_set" 'function) (ff-pointer obj) arg0))

(defmethod #.(lispify "m_weldingThreshold" 'method) ((obj #.(lispify "bt-triangle-mesh" 'class)))
  (#.(lispify "btTriangleMesh_m_weldingThreshold_get" 'function) (ff-pointer obj)))

(defmethod initialize-instance :after ((obj #.(lispify "bt-triangle-mesh" 'class)) &key (use32bitIndices t) (use4componentVertices t))
  (setf (slot-value obj 'ff-pointer) (#.(lispify "new_btTriangleMesh" 'function) use32bitIndices use4componentVertices)))

(defmethod initialize-instance :after ((obj #.(lispify "bt-triangle-mesh" 'class)) &key (use32bitIndices t))
  (setf (slot-value obj 'ff-pointer) (#.(lispify "new_btTriangleMesh" 'function) use32bitIndices)))

(defmethod initialize-instance :after ((obj #.(lispify "bt-triangle-mesh" 'class)) &key)
  (setf (slot-value obj 'ff-pointer) (#.(lispify "new_btTriangleMesh" 'function))))

(defmethod #.(lispify "get-use32bit-indices" 'method) ((self #.(lispify "bt-triangle-mesh" 'classname)))
  (#.(lispify "btTriangleMesh_getUse32bitIndices" 'function) (ff-pointer self)))

(defmethod #.(lispify "get-use4component-vertices" 'method) ((self #.(lispify "bt-triangle-mesh" 'classname)))
  (#.(lispify "btTriangleMesh_getUse4componentVertices" 'function) (ff-pointer self)))

(defmethod #.(lispify "add-triangle" 'method) ((self #.(lispify "bt-triangle-mesh" 'classname)) (vertex0 #.(lispify "bt-vector3" 'classname)) (vertex1 #.(lispify "bt-vector3" 'classname)) (vertex2 #.(lispify "bt-vector3" 'classname)) (removeDuplicateVertices t))
  (#.(lispify "btTriangleMesh_addTriangle" 'function) (ff-pointer self) vertex0 vertex1 vertex2 removeDuplicateVertices))

(defmethod #.(lispify "add-triangle" 'method) ((self #.(lispify "bt-triangle-mesh" 'classname)) (vertex0 #.(lispify "bt-vector3" 'classname)) (vertex1 #.(lispify "bt-vector3" 'classname)) (vertex2 #.(lispify "bt-vector3" 'classname)))
  (#.(lispify "btTriangleMesh_addTriangle" 'function) (ff-pointer self) vertex0 vertex1 vertex2))

(defmethod #.(lispify "get-num-triangles" 'method) ((self #.(lispify "bt-triangle-mesh" 'classname)))
  (#.(lispify "btTriangleMesh_getNumTriangles" 'function) (ff-pointer self)))

(defmethod #.(lispify "preallocate-vertices" 'method) ((self #.(lispify "bt-triangle-mesh" 'classname)) (numverts integer))
  (#.(lispify "btTriangleMesh_preallocateVertices" 'function) (ff-pointer self) numverts))

(defmethod #.(lispify "preallocate-indices" 'method) ((self #.(lispify "bt-triangle-mesh" 'classname)) (numindices integer))
  (#.(lispify "btTriangleMesh_preallocateIndices" 'function) (ff-pointer self) numindices))

(defmethod #.(lispify "find-or-add-vertex" 'method) ((self #.(lispify "bt-triangle-mesh" 'classname)) (vertex #.(lispify "bt-vector3" 'classname)) (removeDuplicateVertices t))
  (#.(lispify "btTriangleMesh_findOrAddVertex" 'function) (ff-pointer self) vertex removeDuplicateVertices))

(defmethod #.(lispify "add-index" 'method) ((self #.(lispify "bt-triangle-mesh" 'classname)) (index integer))
  (#.(lispify "btTriangleMesh_addIndex" 'function) (ff-pointer self) index))



(defmethod #.(lispify "new" 'method) ((self #.(lispify "bt-convex-triangle-mesh-shape" 'classname)) sizeInBytes)
  (#.(lispify "btConvexTriangleMeshShape_makeCPlusPlusInstance" 'function) (ff-pointer self) sizeInBytes))

(defmethod #.(lispify "delete" 'method) ((self #.(lispify "bt-convex-triangle-mesh-shape" 'classname)) ptr)
  (#.(lispify "btConvexTriangleMeshShape_deleteCPlusPlusInstance" 'function) (ff-pointer self) ptr))

(defmethod #.(lispify "new" 'method) ((self #.(lispify "bt-convex-triangle-mesh-shape" 'classname)) arg1 ptr)
  (#.(lispify "btConvexTriangleMeshShape_makeCPlusPlusInstance" 'function) (ff-pointer self) arg1 ptr))

(defmethod #.(lispify "delete" 'method) ((self #.(lispify "bt-convex-triangle-mesh-shape" 'classname)) arg1 arg2)
  (#.(lispify "btConvexTriangleMeshShape_deleteCPlusPlusInstance" 'function) (ff-pointer self) arg1 arg2))

(shadow "new[]")
(defmethod #.(lispify "new[]" 'method) ((self #.(lispify "bt-convex-triangle-mesh-shape" 'classname)) sizeInBytes)
  (#.(lispify "btConvexTriangleMeshShape_makeCPlusArray" 'function) (ff-pointer self) sizeInBytes))

(shadow "delete[]")
(defmethod #.(lispify "delete[]" 'method) ((self #.(lispify "bt-convex-triangle-mesh-shape" 'classname)) ptr)
  (#.(lispify "btConvexTriangleMeshShape_deleteCPlusArray" 'function) (ff-pointer self) ptr))

(shadow "new[]")
(defmethod #.(lispify "new[]" 'method) ((self #.(lispify "bt-convex-triangle-mesh-shape" 'classname)) arg1 ptr)
  (#.(lispify "btConvexTriangleMeshShape_makeCPlusArray" 'function) (ff-pointer self) arg1 ptr))

(shadow "delete[]")
(defmethod #.(lispify "delete[]" 'method) ((self #.(lispify "bt-convex-triangle-mesh-shape" 'classname)) arg1 arg2)
  (#.(lispify "btConvexTriangleMeshShape_deleteCPlusArray" 'function) (ff-pointer self) arg1 arg2))

(defmethod initialize-instance :after ((obj #.(lispify "bt-convex-triangle-mesh-shape" 'class)) &key meshInterface (calcAabb t))
  (setf (slot-value obj 'ff-pointer) (#.(lispify "new_btConvexTriangleMeshShape" 'function) meshInterface calcAabb)))

(defmethod initialize-instance :after ((obj #.(lispify "bt-convex-triangle-mesh-shape" 'class)) &key meshInterface)
  (setf (slot-value obj 'ff-pointer) (#.(lispify "new_btConvexTriangleMeshShape" 'function) meshInterface)))

(defmethod #.(lispify "get-mesh-interface" 'method) ((self #.(lispify "bt-convex-triangle-mesh-shape" 'classname)))
  (#.(lispify "btConvexTriangleMeshShape_getMeshInterface" 'function) (ff-pointer self)))

(defmethod #.(lispify "get-mesh-interface" 'method) ((self #.(lispify "bt-convex-triangle-mesh-shape" 'classname)))
  (#.(lispify "btConvexTriangleMeshShape_getMeshInterface" 'function) (ff-pointer self)))

(defmethod #.(lispify "local-get-supporting-vertex" 'method) ((self #.(lispify "bt-convex-triangle-mesh-shape" 'classname)) (vec #.(lispify "bt-vector3" 'classname)))
  (#.(lispify "btConvexTriangleMeshShape_localGetSupportingVertex" 'function) (ff-pointer self) vec))

(defmethod #.(lispify "local-get-supporting-vertex-without-margin" 'method) ((self #.(lispify "bt-convex-triangle-mesh-shape" 'classname)) (vec #.(lispify "bt-vector3" 'classname)))
  (#.(lispify "btConvexTriangleMeshShape_localGetSupportingVertexWithoutMargin" 'function) (ff-pointer self) vec))

(defmethod #.(lispify "batched-unit-vector-get-supporting-vertex-without-margin" 'method) ((self #.(lispify "bt-convex-triangle-mesh-shape" 'classname)) (vectors #.(lispify "bt-vector3" 'classname)) (supportVerticesOut #.(lispify "bt-vector3" 'classname)) (numVectors integer))
  (#.(lispify "btConvexTriangleMeshShape_batchedUnitVectorGetSupportingVertexWithoutMargin" 'function) (ff-pointer self) vectors supportVerticesOut numVectors))

(defmethod #.(lispify "get-name" 'method) ((self #.(lispify "bt-convex-triangle-mesh-shape" 'classname)))
  (#.(lispify "btConvexTriangleMeshShape_getName" 'function) (ff-pointer self)))

(defmethod #.(lispify "get-num-vertices" 'method) ((self #.(lispify "bt-convex-triangle-mesh-shape" 'classname)))
  (#.(lispify "btConvexTriangleMeshShape_getNumVertices" 'function) (ff-pointer self)))

(defmethod #.(lispify "get-num-edges" 'method) ((self #.(lispify "bt-convex-triangle-mesh-shape" 'classname)))
  (#.(lispify "btConvexTriangleMeshShape_getNumEdges" 'function) (ff-pointer self)))

(defmethod #.(lispify "get-edge" 'method) ((self #.(lispify "bt-convex-triangle-mesh-shape" 'classname)) (i integer) (pa #.(lispify "bt-vector3" 'classname)) (pb #.(lispify "bt-vector3" 'classname)))
  (#.(lispify "btConvexTriangleMeshShape_getEdge" 'function) (ff-pointer self) i pa pb))

(defmethod #.(lispify "get-vertex" 'method) ((self #.(lispify "bt-convex-triangle-mesh-shape" 'classname)) (i integer) (vtx #.(lispify "bt-vector3" 'classname)))
  (#.(lispify "btConvexTriangleMeshShape_getVertex" 'function) (ff-pointer self) i vtx))

(defmethod #.(lispify "get-num-planes" 'method) ((self #.(lispify "bt-convex-triangle-mesh-shape" 'classname)))
  (#.(lispify "btConvexTriangleMeshShape_getNumPlanes" 'function) (ff-pointer self)))

(defmethod #.(lispify "get-plane" 'method) ((self #.(lispify "bt-convex-triangle-mesh-shape" 'classname)) (planeNormal #.(lispify "bt-vector3" 'classname)) (planeSupport #.(lispify "bt-vector3" 'classname)) (i integer))
  (#.(lispify "btConvexTriangleMeshShape_getPlane" 'function) (ff-pointer self) planeNormal planeSupport i))

(defmethod #.(lispify "is-inside" 'method) ((self #.(lispify "bt-convex-triangle-mesh-shape" 'classname)) (pt #.(lispify "bt-vector3" 'classname)) (tolerance number))
  (#.(lispify "btConvexTriangleMeshShape_isInside" 'function) (ff-pointer self) pt tolerance))

(defmethod #.(lispify "set-local-scaling" 'method) ((self #.(lispify "bt-convex-triangle-mesh-shape" 'classname)) (scaling #.(lispify "bt-vector3" 'classname)))
  (#.(lispify "btConvexTriangleMeshShape_setLocalScaling" 'function) (ff-pointer self) scaling))

(defmethod #.(lispify "get-local-scaling" 'method) ((self #.(lispify "bt-convex-triangle-mesh-shape" 'classname)))
  (#.(lispify "btConvexTriangleMeshShape_getLocalScaling" 'function) (ff-pointer self)))

(defmethod #.(lispify "calculate-principal-axis-transform" 'method) ((self #.(lispify "bt-convex-triangle-mesh-shape" 'classname)) (principal #.(lispify "bt-transform" 'classname)) (inertia #.(lispify "bt-vector3" 'classname)) volume)
  (#.(lispify "btConvexTriangleMeshShape_calculatePrincipalAxisTransform" 'function) (ff-pointer self) principal inertia volume))



(defmethod #.(lispify "new" 'method) ((self #.(lispify "bt-bvh-triangle-mesh-shape" 'classname)) sizeInBytes)
  (#.(lispify "btBvhTriangleMeshShape_makeCPlusPlusInstance" 'function) (ff-pointer self) sizeInBytes))

(defmethod #.(lispify "delete" 'method) ((self #.(lispify "bt-bvh-triangle-mesh-shape" 'classname)) ptr)
  (#.(lispify "btBvhTriangleMeshShape_deleteCPlusPlusInstance" 'function) (ff-pointer self) ptr))

(defmethod #.(lispify "new" 'method) ((self #.(lispify "bt-bvh-triangle-mesh-shape" 'classname)) arg1 ptr)
  (#.(lispify "btBvhTriangleMeshShape_makeCPlusPlusInstance" 'function) (ff-pointer self) arg1 ptr))

(defmethod #.(lispify "delete" 'method) ((self #.(lispify "bt-bvh-triangle-mesh-shape" 'classname)) arg1 arg2)
  (#.(lispify "btBvhTriangleMeshShape_deleteCPlusPlusInstance" 'function) (ff-pointer self) arg1 arg2))

(shadow "new[]")
(defmethod #.(lispify "new[]" 'method) ((self #.(lispify "bt-bvh-triangle-mesh-shape" 'classname)) sizeInBytes)
  (#.(lispify "btBvhTriangleMeshShape_makeCPlusArray" 'function) (ff-pointer self) sizeInBytes))

(shadow "delete[]")
(defmethod #.(lispify "delete[]" 'method) ((self #.(lispify "bt-bvh-triangle-mesh-shape" 'classname)) ptr)
  (#.(lispify "btBvhTriangleMeshShape_deleteCPlusArray" 'function) (ff-pointer self) ptr))

(shadow "new[]")
(defmethod #.(lispify "new[]" 'method) ((self #.(lispify "bt-bvh-triangle-mesh-shape" 'classname)) arg1 ptr)
  (#.(lispify "btBvhTriangleMeshShape_makeCPlusArray" 'function) (ff-pointer self) arg1 ptr))

(shadow "delete[]")
(defmethod #.(lispify "delete[]" 'method) ((self #.(lispify "bt-bvh-triangle-mesh-shape" 'classname)) arg1 arg2)
  (#.(lispify "btBvhTriangleMeshShape_deleteCPlusArray" 'function) (ff-pointer self) arg1 arg2))

(defmethod initialize-instance :after ((obj #.(lispify "bt-bvh-triangle-mesh-shape" 'class)) &key meshInterface (useQuantizedAabbCompression t) (buildBvh t))
  (setf (slot-value obj 'ff-pointer) (#.(lispify "new_btBvhTriangleMeshShape" 'function) meshInterface useQuantizedAabbCompression buildBvh)))

(defmethod initialize-instance :after ((obj #.(lispify "bt-bvh-triangle-mesh-shape" 'class)) &key meshInterface (useQuantizedAabbCompression t))
  (setf (slot-value obj 'ff-pointer) (#.(lispify "new_btBvhTriangleMeshShape" 'function) meshInterface useQuantizedAabbCompression)))

(defmethod initialize-instance :after ((obj #.(lispify "bt-bvh-triangle-mesh-shape" 'class)) &key meshInterface (useQuantizedAabbCompression t) (bvhAabbMin #.(lispify "bt-vector3" 'classname)) (bvhAabbMax #.(lispify "bt-vector3" 'classname)) (buildBvh t))
  (setf (slot-value obj 'ff-pointer) (#.(lispify "new_btBvhTriangleMeshShape" 'function) meshInterface useQuantizedAabbCompression bvhAabbMin bvhAabbMax buildBvh)))

(defmethod initialize-instance :after ((obj #.(lispify "bt-bvh-triangle-mesh-shape" 'class)) &key meshInterface (useQuantizedAabbCompression t) (bvhAabbMin #.(lispify "bt-vector3" 'classname)) (bvhAabbMax #.(lispify "bt-vector3" 'classname)))
  (setf (slot-value obj 'ff-pointer) (#.(lispify "new_btBvhTriangleMeshShape" 'function) meshInterface useQuantizedAabbCompression bvhAabbMin bvhAabbMax)))

(defmethod #.(lispify "get-owns-bvh" 'method) ((self #.(lispify "bt-bvh-triangle-mesh-shape" 'classname)))
  (#.(lispify "btBvhTriangleMeshShape_getOwnsBvh" 'function) (ff-pointer self)))

(defmethod #.(lispify "perform-raycast" 'method) ((self #.(lispify "bt-bvh-triangle-mesh-shape" 'classname)) callback (raySource #.(lispify "bt-vector3" 'classname)) (rayTarget #.(lispify "bt-vector3" 'classname)))
  (#.(lispify "btBvhTriangleMeshShape_performRaycast" 'function) (ff-pointer self) callback raySource rayTarget))

(defmethod #.(lispify "perform-convexcast" 'method) ((self #.(lispify "bt-bvh-triangle-mesh-shape" 'classname)) callback (boxSource #.(lispify "bt-vector3" 'classname)) (boxTarget #.(lispify "bt-vector3" 'classname)) (boxMin #.(lispify "bt-vector3" 'classname)) (boxMax #.(lispify "bt-vector3" 'classname)))
  (#.(lispify "btBvhTriangleMeshShape_performConvexcast" 'function) (ff-pointer self) callback boxSource boxTarget boxMin boxMax))

(defmethod #.(lispify "process-all-triangles" 'method) ((self #.(lispify "bt-bvh-triangle-mesh-shape" 'classname)) callback (aabbMin #.(lispify "bt-vector3" 'classname)) (aabbMax #.(lispify "bt-vector3" 'classname)))
  (#.(lispify "btBvhTriangleMeshShape_processAllTriangles" 'function) (ff-pointer self) callback aabbMin aabbMax))

(defmethod #.(lispify "refit-tree" 'method) ((self #.(lispify "bt-bvh-triangle-mesh-shape" 'classname)) (aabbMin #.(lispify "bt-vector3" 'classname)) (aabbMax #.(lispify "bt-vector3" 'classname)))
  (#.(lispify "btBvhTriangleMeshShape_refitTree" 'function) (ff-pointer self) aabbMin aabbMax))

(defmethod #.(lispify "partial-refit-tree" 'method) ((self #.(lispify "bt-bvh-triangle-mesh-shape" 'classname)) (aabbMin #.(lispify "bt-vector3" 'classname)) (aabbMax #.(lispify "bt-vector3" 'classname)))
  (#.(lispify "btBvhTriangleMeshShape_partialRefitTree" 'function) (ff-pointer self) aabbMin aabbMax))

(defmethod #.(lispify "get-name" 'method) ((self #.(lispify "bt-bvh-triangle-mesh-shape" 'classname)))
  (#.(lispify "btBvhTriangleMeshShape_getName" 'function) (ff-pointer self)))

(defmethod #.(lispify "set-local-scaling" 'method) ((self #.(lispify "bt-bvh-triangle-mesh-shape" 'classname)) (scaling #.(lispify "bt-vector3" 'classname)))
  (#.(lispify "btBvhTriangleMeshShape_setLocalScaling" 'function) (ff-pointer self) scaling))

(defmethod #.(lispify "get-optimized-bvh" 'method) ((self #.(lispify "bt-bvh-triangle-mesh-shape" 'classname)))
  (#.(lispify "btBvhTriangleMeshShape_getOptimizedBvh" 'function) (ff-pointer self)))

(defmethod #.(lispify "set-optimized-bvh" 'method) ((self #.(lispify "bt-bvh-triangle-mesh-shape" 'classname)) bvh (localScaling #.(lispify "bt-vector3" 'classname)))
  (#.(lispify "btBvhTriangleMeshShape_setOptimizedBvh" 'function) (ff-pointer self) bvh localScaling))

(defmethod #.(lispify "set-optimized-bvh" 'method) ((self #.(lispify "bt-bvh-triangle-mesh-shape" 'classname)) bvh)
  (#.(lispify "btBvhTriangleMeshShape_setOptimizedBvh" 'function) (ff-pointer self) bvh))

(defmethod #.(lispify "build-optimized-bvh" 'method) ((self #.(lispify "bt-bvh-triangle-mesh-shape" 'classname)))
  (#.(lispify "btBvhTriangleMeshShape_buildOptimizedBvh" 'function) (ff-pointer self)))

(defmethod #.(lispify "uses-quantized-aabb-compression" 'method) ((self #.(lispify "bt-bvh-triangle-mesh-shape" 'classname)))
  (#.(lispify "btBvhTriangleMeshShape_usesQuantizedAabbCompression" 'function) (ff-pointer self)))

(defmethod #.(lispify "set-triangle-info-map" 'method) ((self #.(lispify "bt-bvh-triangle-mesh-shape" 'classname)) triangleInfoMap)
  (#.(lispify "btBvhTriangleMeshShape_setTriangleInfoMap" 'function) (ff-pointer self) triangleInfoMap))

(defmethod #.(lispify "get-triangle-info-map" 'method) ((self #.(lispify "bt-bvh-triangle-mesh-shape" 'classname)))
  (#.(lispify "btBvhTriangleMeshShape_getTriangleInfoMap" 'function) (ff-pointer self)))

(defmethod #.(lispify "get-triangle-info-map" 'method) ((self #.(lispify "bt-bvh-triangle-mesh-shape" 'classname)))
  (#.(lispify "btBvhTriangleMeshShape_getTriangleInfoMap" 'function) (ff-pointer self)))

(defmethod #.(lispify "calculate-serialize-buffer-size" 'method) ((self #.(lispify "bt-bvh-triangle-mesh-shape" 'classname)))
  (#.(lispify "btBvhTriangleMeshShape_calculateSerializeBufferSize" 'function) (ff-pointer self)))

(defmethod #.(lispify "serialize" 'method) ((self #.(lispify "bt-bvh-triangle-mesh-shape" 'classname)) dataBuffer serializer)
  (#.(lispify "btBvhTriangleMeshShape_serialize" 'function) (ff-pointer self) dataBuffer serializer))

(defmethod #.(lispify "serialize-single-bvh" 'method) ((self #.(lispify "bt-bvh-triangle-mesh-shape" 'classname)) serializer)
  (#.(lispify "btBvhTriangleMeshShape_serializeSingleBvh" 'function) (ff-pointer self) serializer))

(defmethod #.(lispify "serialize-single-triangle-info-map" 'method) ((self #.(lispify "bt-bvh-triangle-mesh-shape" 'classname)) serializer)
  (#.(lispify "btBvhTriangleMeshShape_serializeSingleTriangleInfoMap" 'function) (ff-pointer self) serializer))



(defmethod #.(lispify "new" 'method) ((self #.(lispify "bt-scaled-bvh-triangle-mesh-shape" 'classname)) sizeInBytes)
  (#.(lispify "btScaledBvhTriangleMeshShape_makeCPlusPlusInstance" 'function) (ff-pointer self) sizeInBytes))

(defmethod #.(lispify "delete" 'method) ((self #.(lispify "bt-scaled-bvh-triangle-mesh-shape" 'classname)) ptr)
  (#.(lispify "btScaledBvhTriangleMeshShape_deleteCPlusPlusInstance" 'function) (ff-pointer self) ptr))

(defmethod #.(lispify "new" 'method) ((self #.(lispify "bt-scaled-bvh-triangle-mesh-shape" 'classname)) arg1 ptr)
  (#.(lispify "btScaledBvhTriangleMeshShape_makeCPlusPlusInstance" 'function) (ff-pointer self) arg1 ptr))

(defmethod #.(lispify "delete" 'method) ((self #.(lispify "bt-scaled-bvh-triangle-mesh-shape" 'classname)) arg1 arg2)
  (#.(lispify "btScaledBvhTriangleMeshShape_deleteCPlusPlusInstance" 'function) (ff-pointer self) arg1 arg2))

(shadow "new[]")
(defmethod #.(lispify "new[]" 'method) ((self #.(lispify "bt-scaled-bvh-triangle-mesh-shape" 'classname)) sizeInBytes)
  (#.(lispify "btScaledBvhTriangleMeshShape_makeCPlusArray" 'function) (ff-pointer self) sizeInBytes))

(shadow "delete[]")
(defmethod #.(lispify "delete[]" 'method) ((self #.(lispify "bt-scaled-bvh-triangle-mesh-shape" 'classname)) ptr)
  (#.(lispify "btScaledBvhTriangleMeshShape_deleteCPlusArray" 'function) (ff-pointer self) ptr))

(shadow "new[]")
(defmethod #.(lispify "new[]" 'method) ((self #.(lispify "bt-scaled-bvh-triangle-mesh-shape" 'classname)) arg1 ptr)
  (#.(lispify "btScaledBvhTriangleMeshShape_makeCPlusArray" 'function) (ff-pointer self) arg1 ptr))

(shadow "delete[]")
(defmethod #.(lispify "delete[]" 'method) ((self #.(lispify "bt-scaled-bvh-triangle-mesh-shape" 'classname)) arg1 arg2)
  (#.(lispify "btScaledBvhTriangleMeshShape_deleteCPlusArray" 'function) (ff-pointer self) arg1 arg2))

(defmethod initialize-instance :after ((obj #.(lispify "bt-scaled-bvh-triangle-mesh-shape" 'class)) &key (childShape #.(lispify "bt-bvh-triangle-mesh-shape" 'classname)) (localScaling #.(lispify "bt-vector3" 'classname)))
  (setf (slot-value obj 'ff-pointer) (#.(lispify "new_btScaledBvhTriangleMeshShape" 'function) childShape localScaling)))

(defmethod #.(lispify "get-aabb" 'method) ((self #.(lispify "bt-scaled-bvh-triangle-mesh-shape" 'classname)) (t-arg1 #.(lispify "bt-transform" 'classname)) (aabbMin #.(lispify "bt-vector3" 'classname)) (aabbMax #.(lispify "bt-vector3" 'classname)))
  (#.(lispify "btScaledBvhTriangleMeshShape_getAabb" 'function) (ff-pointer self) t-arg1 aabbMin aabbMax))

(defmethod #.(lispify "set-local-scaling" 'method) ((self #.(lispify "bt-scaled-bvh-triangle-mesh-shape" 'classname)) (scaling #.(lispify "bt-vector3" 'classname)))
  (#.(lispify "btScaledBvhTriangleMeshShape_setLocalScaling" 'function) (ff-pointer self) scaling))

(defmethod #.(lispify "get-local-scaling" 'method) ((self #.(lispify "bt-scaled-bvh-triangle-mesh-shape" 'classname)))
  (#.(lispify "btScaledBvhTriangleMeshShape_getLocalScaling" 'function) (ff-pointer self)))

(defmethod #.(lispify "calculate-local-inertia" 'method) ((self #.(lispify "bt-scaled-bvh-triangle-mesh-shape" 'classname)) (mass number) (inertia #.(lispify "bt-vector3" 'classname)))
  (#.(lispify "btScaledBvhTriangleMeshShape_calculateLocalInertia" 'function) (ff-pointer self) mass inertia))

(defmethod #.(lispify "process-all-triangles" 'method) ((self #.(lispify "bt-scaled-bvh-triangle-mesh-shape" 'classname)) callback (aabbMin #.(lispify "bt-vector3" 'classname)) (aabbMax #.(lispify "bt-vector3" 'classname)))
  (#.(lispify "btScaledBvhTriangleMeshShape_processAllTriangles" 'function) (ff-pointer self) callback aabbMin aabbMax))

(defmethod #.(lispify "get-child-shape" 'method) ((self #.(lispify "bt-scaled-bvh-triangle-mesh-shape" 'classname)))
  (#.(lispify "btScaledBvhTriangleMeshShape_getChildShape" 'function) (ff-pointer self)))

(defmethod #.(lispify "get-child-shape" 'method) ((self #.(lispify "bt-scaled-bvh-triangle-mesh-shape" 'classname)))
  (#.(lispify "btScaledBvhTriangleMeshShape_getChildShape" 'function) (ff-pointer self)))

(defmethod #.(lispify "get-name" 'method) ((self #.(lispify "bt-scaled-bvh-triangle-mesh-shape" 'classname)))
  (#.(lispify "btScaledBvhTriangleMeshShape_getName" 'function) (ff-pointer self)))

(defmethod #.(lispify "calculate-serialize-buffer-size" 'method) ((self #.(lispify "bt-scaled-bvh-triangle-mesh-shape" 'classname)))
  (#.(lispify "btScaledBvhTriangleMeshShape_calculateSerializeBufferSize" 'function) (ff-pointer self)))

(defmethod #.(lispify "serialize" 'method) ((self #.(lispify "bt-scaled-bvh-triangle-mesh-shape" 'classname)) dataBuffer serializer)
  (#.(lispify "btScaledBvhTriangleMeshShape_serialize" 'function) (ff-pointer self) dataBuffer serializer))



(defmethod #.(lispify "new" 'method) ((self #.(lispify "bt-triangle-mesh-shape" 'classname)) sizeInBytes)
  (#.(lispify "btTriangleMeshShape_makeCPlusPlusInstance" 'function) (ff-pointer self) sizeInBytes))

(defmethod #.(lispify "delete" 'method) ((self #.(lispify "bt-triangle-mesh-shape" 'classname)) ptr)
  (#.(lispify "btTriangleMeshShape_deleteCPlusPlusInstance" 'function) (ff-pointer self) ptr))

(defmethod #.(lispify "new" 'method) ((self #.(lispify "bt-triangle-mesh-shape" 'classname)) arg1 ptr)
  (#.(lispify "btTriangleMeshShape_makeCPlusPlusInstance" 'function) (ff-pointer self) arg1 ptr))

(defmethod #.(lispify "delete" 'method) ((self #.(lispify "bt-triangle-mesh-shape" 'classname)) arg1 arg2)
  (#.(lispify "btTriangleMeshShape_deleteCPlusPlusInstance" 'function) (ff-pointer self) arg1 arg2))

(shadow "new[]")
(defmethod #.(lispify "new[]" 'method) ((self #.(lispify "bt-triangle-mesh-shape" 'classname)) sizeInBytes)
  (#.(lispify "btTriangleMeshShape_makeCPlusArray" 'function) (ff-pointer self) sizeInBytes))

(shadow "delete[]")
(defmethod #.(lispify "delete[]" 'method) ((self #.(lispify "bt-triangle-mesh-shape" 'classname)) ptr)
  (#.(lispify "btTriangleMeshShape_deleteCPlusArray" 'function) (ff-pointer self) ptr))

(shadow "new[]")
(defmethod #.(lispify "new[]" 'method) ((self #.(lispify "bt-triangle-mesh-shape" 'classname)) arg1 ptr)
  (#.(lispify "btTriangleMeshShape_makeCPlusArray" 'function) (ff-pointer self) arg1 ptr))

(shadow "delete[]")
(defmethod #.(lispify "delete[]" 'method) ((self #.(lispify "bt-triangle-mesh-shape" 'classname)) arg1 arg2)
  (#.(lispify "btTriangleMeshShape_deleteCPlusArray" 'function) (ff-pointer self) arg1 arg2))

(defmethod #.(lispify "local-get-supporting-vertex" 'method) ((self #.(lispify "bt-triangle-mesh-shape" 'classname)) (vec #.(lispify "bt-vector3" 'classname)))
  (#.(lispify "btTriangleMeshShape_localGetSupportingVertex" 'function) (ff-pointer self) vec))

(defmethod #.(lispify "local-get-supporting-vertex-without-margin" 'method) ((self #.(lispify "bt-triangle-mesh-shape" 'classname)) (vec #.(lispify "bt-vector3" 'classname)))
  (#.(lispify "btTriangleMeshShape_localGetSupportingVertexWithoutMargin" 'function) (ff-pointer self) vec))

(defmethod #.(lispify "recalc-local-aabb" 'method) ((self #.(lispify "bt-triangle-mesh-shape" 'classname)))
  (#.(lispify "btTriangleMeshShape_recalcLocalAabb" 'function) (ff-pointer self)))

(defmethod #.(lispify "get-aabb" 'method) ((self #.(lispify "bt-triangle-mesh-shape" 'classname)) (t-arg1 #.(lispify "bt-transform" 'classname)) (aabbMin #.(lispify "bt-vector3" 'classname)) (aabbMax #.(lispify "bt-vector3" 'classname)))
  (#.(lispify "btTriangleMeshShape_getAabb" 'function) (ff-pointer self) t-arg1 aabbMin aabbMax))

(defmethod #.(lispify "process-all-triangles" 'method) ((self #.(lispify "bt-triangle-mesh-shape" 'classname)) callback (aabbMin #.(lispify "bt-vector3" 'classname)) (aabbMax #.(lispify "bt-vector3" 'classname)))
  (#.(lispify "btTriangleMeshShape_processAllTriangles" 'function) (ff-pointer self) callback aabbMin aabbMax))

(defmethod #.(lispify "calculate-local-inertia" 'method) ((self #.(lispify "bt-triangle-mesh-shape" 'classname)) (mass number) (inertia #.(lispify "bt-vector3" 'classname)))
  (#.(lispify "btTriangleMeshShape_calculateLocalInertia" 'function) (ff-pointer self) mass inertia))

(defmethod #.(lispify "set-local-scaling" 'method) ((self #.(lispify "bt-triangle-mesh-shape" 'classname)) (scaling #.(lispify "bt-vector3" 'classname)))
  (#.(lispify "btTriangleMeshShape_setLocalScaling" 'function) (ff-pointer self) scaling))

(defmethod #.(lispify "get-local-scaling" 'method) ((self #.(lispify "bt-triangle-mesh-shape" 'classname)))
  (#.(lispify "btTriangleMeshShape_getLocalScaling" 'function) (ff-pointer self)))

(defmethod #.(lispify "get-mesh-interface" 'method) ((self #.(lispify "bt-triangle-mesh-shape" 'classname)))
  (#.(lispify "btTriangleMeshShape_getMeshInterface" 'function) (ff-pointer self)))

(defmethod #.(lispify "get-mesh-interface" 'method) ((self #.(lispify "bt-triangle-mesh-shape" 'classname)))
  (#.(lispify "btTriangleMeshShape_getMeshInterface" 'function) (ff-pointer self)))

(defmethod #.(lispify "get-local-aabb-min" 'method) ((self #.(lispify "bt-triangle-mesh-shape" 'classname)))
  (#.(lispify "btTriangleMeshShape_getLocalAabbMin" 'function) (ff-pointer self)))

(defmethod #.(lispify "get-local-aabb-max" 'method) ((self #.(lispify "bt-triangle-mesh-shape" 'classname)))
  (#.(lispify "btTriangleMeshShape_getLocalAabbMax" 'function) (ff-pointer self)))

(defmethod #.(lispify "get-name" 'method) ((self #.(lispify "bt-triangle-mesh-shape" 'classname)))
  (#.(lispify "btTriangleMeshShape_getName" 'function) (ff-pointer self)))



(defmethod #.(lispify "new" 'method) ((self #.(lispify "bt-triangle-index-vertex-array" 'classname)) sizeInBytes)
  (#.(lispify "btTriangleIndexVertexArray_makeCPlusPlusInstance" 'function) (ff-pointer self) sizeInBytes))

(defmethod #.(lispify "delete" 'method) ((self #.(lispify "bt-triangle-index-vertex-array" 'classname)) ptr)
  (#.(lispify "btTriangleIndexVertexArray_deleteCPlusPlusInstance" 'function) (ff-pointer self) ptr))

(defmethod #.(lispify "new" 'method) ((self #.(lispify "bt-triangle-index-vertex-array" 'classname)) arg1 ptr)
  (#.(lispify "btTriangleIndexVertexArray_makeCPlusPlusInstance" 'function) (ff-pointer self) arg1 ptr))

(defmethod #.(lispify "delete" 'method) ((self #.(lispify "bt-triangle-index-vertex-array" 'classname)) arg1 arg2)
  (#.(lispify "btTriangleIndexVertexArray_deleteCPlusPlusInstance" 'function) (ff-pointer self) arg1 arg2))

(shadow "new[]")
(defmethod #.(lispify "new[]" 'method) ((self #.(lispify "bt-triangle-index-vertex-array" 'classname)) sizeInBytes)
  (#.(lispify "btTriangleIndexVertexArray_makeCPlusArray" 'function) (ff-pointer self) sizeInBytes))

(shadow "delete[]")
(defmethod #.(lispify "delete[]" 'method) ((self #.(lispify "bt-triangle-index-vertex-array" 'classname)) ptr)
  (#.(lispify "btTriangleIndexVertexArray_deleteCPlusArray" 'function) (ff-pointer self) ptr))

(shadow "new[]")
(defmethod #.(lispify "new[]" 'method) ((self #.(lispify "bt-triangle-index-vertex-array" 'classname)) arg1 ptr)
  (#.(lispify "btTriangleIndexVertexArray_makeCPlusArray" 'function) (ff-pointer self) arg1 ptr))

(shadow "delete[]")
(defmethod #.(lispify "delete[]" 'method) ((self #.(lispify "bt-triangle-index-vertex-array" 'classname)) arg1 arg2)
  (#.(lispify "btTriangleIndexVertexArray_deleteCPlusArray" 'function) (ff-pointer self) arg1 arg2))

(defmethod initialize-instance :after ((obj #.(lispify "bt-triangle-index-vertex-array" 'class)) &key)
  (setf (slot-value obj 'ff-pointer) (#.(lispify "new_btTriangleIndexVertexArray" 'function))))

(defmethod initialize-instance :after ((obj #.(lispify "bt-triangle-index-vertex-array" 'class)) &key (numTriangles integer) triangleIndexBase (triangleIndexStride integer) (numVertices integer) vertexBase (vertexStride integer))
  (setf (slot-value obj 'ff-pointer) (#.(lispify "new_btTriangleIndexVertexArray" 'function) numTriangles triangleIndexBase triangleIndexStride numVertices vertexBase vertexStride)))

(defmethod #.(lispify "add-indexed-mesh" 'method) ((self #.(lispify "bt-triangle-index-vertex-array" 'classname)) mesh indexType)
  (#.(lispify "btTriangleIndexVertexArray_addIndexedMesh" 'function) (ff-pointer self) mesh indexType))

(defmethod #.(lispify "add-indexed-mesh" 'method) ((self #.(lispify "bt-triangle-index-vertex-array" 'classname)) mesh)
  (#.(lispify "btTriangleIndexVertexArray_addIndexedMesh" 'function) (ff-pointer self) mesh))

(defmethod #.(lispify "get-locked-vertex-index-base" 'method) ((self #.(lispify "bt-triangle-index-vertex-array" 'classname)) vertexbase numverts type vertexStride indexbase indexstride numfaces indicestype (subpart integer))
  (#.(lispify "btTriangleIndexVertexArray_getLockedVertexIndexBase" 'function) (ff-pointer self) vertexbase numverts type vertexStride indexbase indexstride numfaces indicestype subpart))

(defmethod #.(lispify "get-locked-vertex-index-base" 'method) ((self #.(lispify "bt-triangle-index-vertex-array" 'classname)) vertexbase numverts type vertexStride indexbase indexstride numfaces indicestype)
  (#.(lispify "btTriangleIndexVertexArray_getLockedVertexIndexBase" 'function) (ff-pointer self) vertexbase numverts type vertexStride indexbase indexstride numfaces indicestype))

(defmethod #.(lispify "get-locked-read-only-vertex-index-base" 'method) ((self #.(lispify "bt-triangle-index-vertex-array" 'classname)) vertexbase numverts type vertexStride indexbase indexstride numfaces indicestype (subpart integer))
  (#.(lispify "btTriangleIndexVertexArray_getLockedReadOnlyVertexIndexBase" 'function) (ff-pointer self) vertexbase numverts type vertexStride indexbase indexstride numfaces indicestype subpart))

(defmethod #.(lispify "get-locked-read-only-vertex-index-base" 'method) ((self #.(lispify "bt-triangle-index-vertex-array" 'classname)) vertexbase numverts type vertexStride indexbase indexstride numfaces indicestype)
  (#.(lispify "btTriangleIndexVertexArray_getLockedReadOnlyVertexIndexBase" 'function) (ff-pointer self) vertexbase numverts type vertexStride indexbase indexstride numfaces indicestype))

(defmethod #.(lispify "un-lock-vertex-base" 'method) ((self #.(lispify "bt-triangle-index-vertex-array" 'classname)) (subpart integer))
  (#.(lispify "btTriangleIndexVertexArray_unLockVertexBase" 'function) (ff-pointer self) subpart))

(defmethod #.(lispify "un-lock-read-only-vertex-base" 'method) ((self #.(lispify "bt-triangle-index-vertex-array" 'classname)) (subpart integer))
  (#.(lispify "btTriangleIndexVertexArray_unLockReadOnlyVertexBase" 'function) (ff-pointer self) subpart))

(defmethod #.(lispify "get-num-sub-parts" 'method) ((self #.(lispify "bt-triangle-index-vertex-array" 'classname)))
  (#.(lispify "btTriangleIndexVertexArray_getNumSubParts" 'function) (ff-pointer self)))

(defmethod #.(lispify "get-indexed-mesh-array" 'method) ((self #.(lispify "bt-triangle-index-vertex-array" 'classname)))
  (#.(lispify "btTriangleIndexVertexArray_getIndexedMeshArray" 'function) (ff-pointer self)))

(defmethod #.(lispify "get-indexed-mesh-array" 'method) ((self #.(lispify "bt-triangle-index-vertex-array" 'classname)))
  (#.(lispify "btTriangleIndexVertexArray_getIndexedMeshArray" 'function) (ff-pointer self)))

(defmethod #.(lispify "preallocate-vertices" 'method) ((self #.(lispify "bt-triangle-index-vertex-array" 'classname)) (numverts integer))
  (#.(lispify "btTriangleIndexVertexArray_preallocateVertices" 'function) (ff-pointer self) numverts))

(defmethod #.(lispify "preallocate-indices" 'method) ((self #.(lispify "bt-triangle-index-vertex-array" 'classname)) (numindices integer))
  (#.(lispify "btTriangleIndexVertexArray_preallocateIndices" 'function) (ff-pointer self) numindices))

(defmethod #.(lispify "has-premade-aabb" 'method) ((self #.(lispify "bt-triangle-index-vertex-array" 'classname)))
  (#.(lispify "btTriangleIndexVertexArray_hasPremadeAabb" 'function) (ff-pointer self)))

(defmethod #.(lispify "set-premade-aabb" 'method) ((self #.(lispify "bt-triangle-index-vertex-array" 'classname)) (aabbMin #.(lispify "bt-vector3" 'classname)) (aabbMax #.(lispify "bt-vector3" 'classname)))
  (#.(lispify "btTriangleIndexVertexArray_setPremadeAabb" 'function) (ff-pointer self) aabbMin aabbMax))

(defmethod #.(lispify "get-premade-aabb" 'method) ((self #.(lispify "bt-triangle-index-vertex-array" 'classname)) (aabbMin #.(lispify "bt-vector3" 'classname)) (aabbMax #.(lispify "bt-vector3" 'classname)))
  (#.(lispify "btTriangleIndexVertexArray_getPremadeAabb" 'function) (ff-pointer self) aabbMin aabbMax))



(defmethod #.(lispify "new" 'method) ((self #.(lispify "bt-compound-shape" 'classname)) sizeInBytes)
  (#.(lispify "btCompoundShape_makeCPlusPlusInstance" 'function) (ff-pointer self) sizeInBytes))

(defmethod #.(lispify "delete" 'method) ((self #.(lispify "bt-compound-shape" 'classname)) ptr)
  (#.(lispify "btCompoundShape_deleteCPlusPlusInstance" 'function) (ff-pointer self) ptr))

(defmethod #.(lispify "new" 'method) ((self #.(lispify "bt-compound-shape" 'classname)) arg1 ptr)
  (#.(lispify "btCompoundShape_makeCPlusPlusInstance" 'function) (ff-pointer self) arg1 ptr))

(defmethod #.(lispify "delete" 'method) ((self #.(lispify "bt-compound-shape" 'classname)) arg1 arg2)
  (#.(lispify "btCompoundShape_deleteCPlusPlusInstance" 'function) (ff-pointer self) arg1 arg2))

(shadow "new[]")
(defmethod #.(lispify "new[]" 'method) ((self #.(lispify "bt-compound-shape" 'classname)) sizeInBytes)
  (#.(lispify "btCompoundShape_makeCPlusArray" 'function) (ff-pointer self) sizeInBytes))

(shadow "delete[]")
(defmethod #.(lispify "delete[]" 'method) ((self #.(lispify "bt-compound-shape" 'classname)) ptr)
  (#.(lispify "btCompoundShape_deleteCPlusArray" 'function) (ff-pointer self) ptr))

(shadow "new[]")
(defmethod #.(lispify "new[]" 'method) ((self #.(lispify "bt-compound-shape" 'classname)) arg1 ptr)
  (#.(lispify "btCompoundShape_makeCPlusArray" 'function) (ff-pointer self) arg1 ptr))

(shadow "delete[]")
(defmethod #.(lispify "delete[]" 'method) ((self #.(lispify "bt-compound-shape" 'classname)) arg1 arg2)
  (#.(lispify "btCompoundShape_deleteCPlusArray" 'function) (ff-pointer self) arg1 arg2))

(defmethod initialize-instance :after ((obj #.(lispify "bt-compound-shape" 'class)) &key (enableDynamicAabbTree t))
  (setf (slot-value obj 'ff-pointer) (#.(lispify "new_btCompoundShape" 'function) enableDynamicAabbTree)))

(defmethod initialize-instance :after ((obj #.(lispify "bt-compound-shape" 'class)) &key)
  (setf (slot-value obj 'ff-pointer) (#.(lispify "new_btCompoundShape" 'function))))

(defmethod #.(lispify "add-child-shape" 'method) ((self #.(lispify "bt-compound-shape" 'classname)) (localTransform #.(lispify "bt-transform" 'classname)) shape)
  (#.(lispify "btCompoundShape_addChildShape" 'function) (ff-pointer self) localTransform shape))

(defmethod #.(lispify "remove-child-shape" 'method) ((self #.(lispify "bt-compound-shape" 'classname)) shape)
  (#.(lispify "btCompoundShape_removeChildShape" 'function) (ff-pointer self) shape))

(defmethod #.(lispify "remove-child-shape-by-index" 'method) ((self #.(lispify "bt-compound-shape" 'classname)) (childShapeindex integer))
  (#.(lispify "btCompoundShape_removeChildShapeByIndex" 'function) (ff-pointer self) childShapeindex))

(defmethod #.(lispify "get-num-child-shapes" 'method) ((self #.(lispify "bt-compound-shape" 'classname)))
  (#.(lispify "btCompoundShape_getNumChildShapes" 'function) (ff-pointer self)))

(defmethod #.(lispify "get-child-shape" 'method) ((self #.(lispify "bt-compound-shape" 'classname)) (index integer))
  (#.(lispify "btCompoundShape_getChildShape" 'function) (ff-pointer self) index))

(defmethod #.(lispify "get-child-shape" 'method) ((self #.(lispify "bt-compound-shape" 'classname)) (index integer))
  (#.(lispify "btCompoundShape_getChildShape" 'function) (ff-pointer self) index))

(defmethod #.(lispify "get-child-transform" 'method) ((self #.(lispify "bt-compound-shape" 'classname)) (index integer))
  (#.(lispify "btCompoundShape_getChildTransform" 'function) (ff-pointer self) index))

(defmethod #.(lispify "get-child-transform" 'method) ((self #.(lispify "bt-compound-shape" 'classname)) (index integer))
  (#.(lispify "btCompoundShape_getChildTransform" 'function) (ff-pointer self) index))

(defmethod #.(lispify "update-child-transform" 'method) ((self #.(lispify "bt-compound-shape" 'classname)) (childIndex integer) (newChildTransform #.(lispify "bt-transform" 'classname)) (shouldRecalculateLocalAabb t))
  (#.(lispify "btCompoundShape_updateChildTransform" 'function) (ff-pointer self) childIndex newChildTransform shouldRecalculateLocalAabb))

(defmethod #.(lispify "update-child-transform" 'method) ((self #.(lispify "bt-compound-shape" 'classname)) (childIndex integer) (newChildTransform #.(lispify "bt-transform" 'classname)))
  (#.(lispify "btCompoundShape_updateChildTransform" 'function) (ff-pointer self) childIndex newChildTransform))

(defmethod #.(lispify "get-child-list" 'method) ((self #.(lispify "bt-compound-shape" 'classname)))
  (#.(lispify "btCompoundShape_getChildList" 'function) (ff-pointer self)))

(defmethod #.(lispify "get-aabb" 'method) ((self #.(lispify "bt-compound-shape" 'classname)) (t-arg1 #.(lispify "bt-transform" 'classname)) (aabbMin #.(lispify "bt-vector3" 'classname)) (aabbMax #.(lispify "bt-vector3" 'classname)))
  (#.(lispify "btCompoundShape_getAabb" 'function) (ff-pointer self) t-arg1 aabbMin aabbMax))

(defmethod #.(lispify "recalculate-local-aabb" 'method) ((self #.(lispify "bt-compound-shape" 'classname)))
  (#.(lispify "btCompoundShape_recalculateLocalAabb" 'function) (ff-pointer self)))

(defmethod #.(lispify "set-local-scaling" 'method) ((self #.(lispify "bt-compound-shape" 'classname)) (scaling #.(lispify "bt-vector3" 'classname)))
  (#.(lispify "btCompoundShape_setLocalScaling" 'function) (ff-pointer self) scaling))

(defmethod #.(lispify "get-local-scaling" 'method) ((self #.(lispify "bt-compound-shape" 'classname)))
  (#.(lispify "btCompoundShape_getLocalScaling" 'function) (ff-pointer self)))

(defmethod #.(lispify "calculate-local-inertia" 'method) ((self #.(lispify "bt-compound-shape" 'classname)) (mass number) (inertia #.(lispify "bt-vector3" 'classname)))
  (#.(lispify "btCompoundShape_calculateLocalInertia" 'function) (ff-pointer self) mass inertia))

(defmethod #.(lispify "set-margin" 'method) ((self #.(lispify "bt-compound-shape" 'classname)) (margin number))
  (#.(lispify "btCompoundShape_setMargin" 'function) (ff-pointer self) margin))

(defmethod #.(lispify "get-margin" 'method) ((self #.(lispify "bt-compound-shape" 'classname)))
  (#.(lispify "btCompoundShape_getMargin" 'function) (ff-pointer self)))

(defmethod #.(lispify "get-name" 'method) ((self #.(lispify "bt-compound-shape" 'classname)))
  (#.(lispify "btCompoundShape_getName" 'function) (ff-pointer self)))

(defmethod #.(lispify "get-dynamic-aabb-tree" 'method) ((self #.(lispify "bt-compound-shape" 'classname)))
  (#.(lispify "btCompoundShape_getDynamicAabbTree" 'function) (ff-pointer self)))

(defmethod #.(lispify "get-dynamic-aabb-tree" 'method) ((self #.(lispify "bt-compound-shape" 'classname)))
  (#.(lispify "btCompoundShape_getDynamicAabbTree" 'function) (ff-pointer self)))

(defmethod #.(lispify "create-aabb-tree-from-children" 'method) ((self #.(lispify "bt-compound-shape" 'classname)))
  (#.(lispify "btCompoundShape_createAabbTreeFromChildren" 'function) (ff-pointer self)))

(defmethod #.(lispify "calculate-principal-axis-transform" 'method) ((self #.(lispify "bt-compound-shape" 'classname)) masses (principal #.(lispify "bt-transform" 'classname)) (inertia #.(lispify "bt-vector3" 'classname)))
  (#.(lispify "btCompoundShape_calculatePrincipalAxisTransform" 'function) (ff-pointer self) masses principal inertia))

(defmethod #.(lispify "get-update-revision" 'method) ((self #.(lispify "bt-compound-shape" 'classname)))
  (#.(lispify "btCompoundShape_getUpdateRevision" 'function) (ff-pointer self)))

(defmethod #.(lispify "calculate-serialize-buffer-size" 'method) ((self #.(lispify "bt-compound-shape" 'classname)))
  (#.(lispify "btCompoundShape_calculateSerializeBufferSize" 'function) (ff-pointer self)))

(defmethod #.(lispify "serialize" 'method) ((self #.(lispify "bt-compound-shape" 'classname)) dataBuffer serializer)
  (#.(lispify "btCompoundShape_serialize" 'function) (ff-pointer self) dataBuffer serializer))



(defmethod #.(lispify "new" 'method) ((self #.(lispify "bt-bu-simplex1to4" 'classname)) sizeInBytes)
  (#.(lispify "btBU_Simplex1to4_makeCPlusPlusInstance" 'function) (ff-pointer self) sizeInBytes))

(defmethod #.(lispify "delete" 'method) ((self #.(lispify "bt-bu-simplex1to4" 'classname)) ptr)
  (#.(lispify "btBU_Simplex1to4_deleteCPlusPlusInstance" 'function) (ff-pointer self) ptr))

(defmethod #.(lispify "new" 'method) ((self #.(lispify "bt-bu-simplex1to4" 'classname)) arg1 ptr)
  (#.(lispify "btBU_Simplex1to4_makeCPlusPlusInstance" 'function) (ff-pointer self) arg1 ptr))

(defmethod #.(lispify "delete" 'method) ((self #.(lispify "bt-bu-simplex1to4" 'classname)) arg1 arg2)
  (#.(lispify "btBU_Simplex1to4_deleteCPlusPlusInstance" 'function) (ff-pointer self) arg1 arg2))

(shadow "new[]")
(defmethod #.(lispify "new[]" 'method) ((self #.(lispify "bt-bu-simplex1to4" 'classname)) sizeInBytes)
  (#.(lispify "btBU_Simplex1to4_makeCPlusArray" 'function) (ff-pointer self) sizeInBytes))

(shadow "delete[]")
(defmethod #.(lispify "delete[]" 'method) ((self #.(lispify "bt-bu-simplex1to4" 'classname)) ptr)
  (#.(lispify "btBU_Simplex1to4_deleteCPlusArray" 'function) (ff-pointer self) ptr))

(shadow "new[]")
(defmethod #.(lispify "new[]" 'method) ((self #.(lispify "bt-bu-simplex1to4" 'classname)) arg1 ptr)
  (#.(lispify "btBU_Simplex1to4_makeCPlusArray" 'function) (ff-pointer self) arg1 ptr))

(shadow "delete[]")
(defmethod #.(lispify "delete[]" 'method) ((self #.(lispify "bt-bu-simplex1to4" 'classname)) arg1 arg2)
  (#.(lispify "btBU_Simplex1to4_deleteCPlusArray" 'function) (ff-pointer self) arg1 arg2))

(defmethod initialize-instance :after ((obj #.(lispify "bt-bu-simplex1to4" 'class)) &key)
  (setf (slot-value obj 'ff-pointer) (#.(lispify "new_btBU_Simplex1to4" 'function))))

(defmethod initialize-instance :after ((obj #.(lispify "bt-bu-simplex1to4" 'class)) &key (pt0 #.(lispify "bt-vector3" 'classname)))
  (setf (slot-value obj 'ff-pointer) (#.(lispify "new_btBU_Simplex1to4" 'function) pt0)))

(defmethod initialize-instance :after ((obj #.(lispify "bt-bu-simplex1to4" 'class)) &key (pt0 #.(lispify "bt-vector3" 'classname)) (pt1 #.(lispify "bt-vector3" 'classname)))
  (setf (slot-value obj 'ff-pointer) (#.(lispify "new_btBU_Simplex1to4" 'function) pt0 pt1)))

(defmethod initialize-instance :after ((obj #.(lispify "bt-bu-simplex1to4" 'class)) &key (pt0 #.(lispify "bt-vector3" 'classname)) (pt1 #.(lispify "bt-vector3" 'classname)) (pt2 #.(lispify "bt-vector3" 'classname)))
  (setf (slot-value obj 'ff-pointer) (#.(lispify "new_btBU_Simplex1to4" 'function) pt0 pt1 pt2)))

(defmethod initialize-instance :after ((obj #.(lispify "bt-bu-simplex1to4" 'class)) &key (pt0 #.(lispify "bt-vector3" 'classname)) (pt1 #.(lispify "bt-vector3" 'classname)) (pt2 #.(lispify "bt-vector3" 'classname)) (pt3 #.(lispify "bt-vector3" 'classname)))
  (setf (slot-value obj 'ff-pointer) (#.(lispify "new_btBU_Simplex1to4" 'function) pt0 pt1 pt2 pt3)))

(defmethod #.(lispify "reset" 'method) ((self #.(lispify "bt-bu-simplex1to4" 'classname)))
  (#.(lispify "btBU_Simplex1to4_reset" 'function) (ff-pointer self)))

(defmethod #.(lispify "get-aabb" 'method) ((self #.(lispify "bt-bu-simplex1to4" 'classname)) (t-arg1 #.(lispify "bt-transform" 'classname)) (aabbMin #.(lispify "bt-vector3" 'classname)) (aabbMax #.(lispify "bt-vector3" 'classname)))
  (#.(lispify "btBU_Simplex1to4_getAabb" 'function) (ff-pointer self) t-arg1 aabbMin aabbMax))

(defmethod #.(lispify "add-vertex" 'method) ((self #.(lispify "bt-bu-simplex1to4" 'classname)) (pt #.(lispify "bt-vector3" 'classname)))
  (#.(lispify "btBU_Simplex1to4_addVertex" 'function) (ff-pointer self) pt))

(defmethod #.(lispify "get-num-vertices" 'method) ((self #.(lispify "bt-bu-simplex1to4" 'classname)))
  (#.(lispify "btBU_Simplex1to4_getNumVertices" 'function) (ff-pointer self)))

(defmethod #.(lispify "get-num-edges" 'method) ((self #.(lispify "bt-bu-simplex1to4" 'classname)))
  (#.(lispify "btBU_Simplex1to4_getNumEdges" 'function) (ff-pointer self)))

(defmethod #.(lispify "get-edge" 'method) ((self #.(lispify "bt-bu-simplex1to4" 'classname)) (i integer) (pa #.(lispify "bt-vector3" 'classname)) (pb #.(lispify "bt-vector3" 'classname)))
  (#.(lispify "btBU_Simplex1to4_getEdge" 'function) (ff-pointer self) i pa pb))

(defmethod #.(lispify "get-vertex" 'method) ((self #.(lispify "bt-bu-simplex1to4" 'classname)) (i integer) (vtx #.(lispify "bt-vector3" 'classname)))
  (#.(lispify "btBU_Simplex1to4_getVertex" 'function) (ff-pointer self) i vtx))

(defmethod #.(lispify "get-num-planes" 'method) ((self #.(lispify "bt-bu-simplex1to4" 'classname)))
  (#.(lispify "btBU_Simplex1to4_getNumPlanes" 'function) (ff-pointer self)))

(defmethod #.(lispify "get-plane" 'method) ((self #.(lispify "bt-bu-simplex1to4" 'classname)) (planeNormal #.(lispify "bt-vector3" 'classname)) (planeSupport #.(lispify "bt-vector3" 'classname)) (i integer))
  (#.(lispify "btBU_Simplex1to4_getPlane" 'function) (ff-pointer self) planeNormal planeSupport i))

(defmethod #.(lispify "get-index" 'method) ((self #.(lispify "bt-bu-simplex1to4" 'classname)) (i integer))
  (#.(lispify "btBU_Simplex1to4_getIndex" 'function) (ff-pointer self) i))

(defmethod #.(lispify "is-inside" 'method) ((self #.(lispify "bt-bu-simplex1to4" 'classname)) (pt #.(lispify "bt-vector3" 'classname)) (tolerance number))
  (#.(lispify "btBU_Simplex1to4_isInside" 'function) (ff-pointer self) pt tolerance))

(defmethod #.(lispify "get-name" 'method) ((self #.(lispify "bt-bu-simplex1to4" 'classname)))
  (#.(lispify "btBU_Simplex1to4_getName" 'function) (ff-pointer self)))



(defmethod #.(lispify "new" 'method) ((self #.(lispify "bt-empty-shape" 'classname)) sizeInBytes)
  (#.(lispify "btEmptyShape_makeCPlusPlusInstance" 'function) (ff-pointer self) sizeInBytes))

(defmethod #.(lispify "delete" 'method) ((self #.(lispify "bt-empty-shape" 'classname)) ptr)
  (#.(lispify "btEmptyShape_deleteCPlusPlusInstance" 'function) (ff-pointer self) ptr))

(defmethod #.(lispify "new" 'method) ((self #.(lispify "bt-empty-shape" 'classname)) arg1 ptr)
  (#.(lispify "btEmptyShape_makeCPlusPlusInstance" 'function) (ff-pointer self) arg1 ptr))

(defmethod #.(lispify "delete" 'method) ((self #.(lispify "bt-empty-shape" 'classname)) arg1 arg2)
  (#.(lispify "btEmptyShape_deleteCPlusPlusInstance" 'function) (ff-pointer self) arg1 arg2))

(shadow "new[]")
(defmethod #.(lispify "new[]" 'method) ((self #.(lispify "bt-empty-shape" 'classname)) sizeInBytes)
  (#.(lispify "btEmptyShape_makeCPlusArray" 'function) (ff-pointer self) sizeInBytes))

(shadow "delete[]")
(defmethod #.(lispify "delete[]" 'method) ((self #.(lispify "bt-empty-shape" 'classname)) ptr)
  (#.(lispify "btEmptyShape_deleteCPlusArray" 'function) (ff-pointer self) ptr))

(shadow "new[]")
(defmethod #.(lispify "new[]" 'method) ((self #.(lispify "bt-empty-shape" 'classname)) arg1 ptr)
  (#.(lispify "btEmptyShape_makeCPlusArray" 'function) (ff-pointer self) arg1 ptr))

(shadow "delete[]")
(defmethod #.(lispify "delete[]" 'method) ((self #.(lispify "bt-empty-shape" 'classname)) arg1 arg2)
  (#.(lispify "btEmptyShape_deleteCPlusArray" 'function) (ff-pointer self) arg1 arg2))

(defmethod initialize-instance :after ((obj #.(lispify "bt-empty-shape" 'class)) &key)
  (setf (slot-value obj 'ff-pointer) (#.(lispify "new_btEmptyShape" 'function))))

(defmethod #.(lispify "get-aabb" 'method) ((self #.(lispify "bt-empty-shape" 'classname)) (t-arg1 #.(lispify "bt-transform" 'classname)) (aabbMin #.(lispify "bt-vector3" 'classname)) (aabbMax #.(lispify "bt-vector3" 'classname)))
  (#.(lispify "btEmptyShape_getAabb" 'function) (ff-pointer self) t-arg1 aabbMin aabbMax))

(defmethod #.(lispify "set-local-scaling" 'method) ((self #.(lispify "bt-empty-shape" 'classname)) (scaling #.(lispify "bt-vector3" 'classname)))
  (#.(lispify "btEmptyShape_setLocalScaling" 'function) (ff-pointer self) scaling))

(defmethod #.(lispify "get-local-scaling" 'method) ((self #.(lispify "bt-empty-shape" 'classname)))
  (#.(lispify "btEmptyShape_getLocalScaling" 'function) (ff-pointer self)))

(defmethod #.(lispify "calculate-local-inertia" 'method) ((self #.(lispify "bt-empty-shape" 'classname)) (mass number) (inertia #.(lispify "bt-vector3" 'classname)))
  (#.(lispify "btEmptyShape_calculateLocalInertia" 'function) (ff-pointer self) mass inertia))

(defmethod #.(lispify "get-name" 'method) ((self #.(lispify "bt-empty-shape" 'classname)))
  (#.(lispify "btEmptyShape_getName" 'function) (ff-pointer self)))

(defmethod #.(lispify "process-all-triangles" 'method) ((self #.(lispify "bt-empty-shape" 'classname)) arg1 (arg2 #.(lispify "bt-vector3" 'classname)) (arg3 #.(lispify "bt-vector3" 'classname)))
  (#.(lispify "btEmptyShape_processAllTriangles" 'function) (ff-pointer self) arg1 arg2 arg3))



(defmethod #.(lispify "new" 'method) ((self #.(lispify "bt-multi-sphere-shape" 'classname)) sizeInBytes)
  (#.(lispify "btMultiSphereShape_makeCPlusPlusInstance" 'function) (ff-pointer self) sizeInBytes))

(defmethod #.(lispify "delete" 'method) ((self #.(lispify "bt-multi-sphere-shape" 'classname)) ptr)
  (#.(lispify "btMultiSphereShape_deleteCPlusPlusInstance" 'function) (ff-pointer self) ptr))

(defmethod #.(lispify "new" 'method) ((self #.(lispify "bt-multi-sphere-shape" 'classname)) arg1 ptr)
  (#.(lispify "btMultiSphereShape_makeCPlusPlusInstance" 'function) (ff-pointer self) arg1 ptr))

(defmethod #.(lispify "delete" 'method) ((self #.(lispify "bt-multi-sphere-shape" 'classname)) arg1 arg2)
  (#.(lispify "btMultiSphereShape_deleteCPlusPlusInstance" 'function) (ff-pointer self) arg1 arg2))

(shadow "new[]")
(defmethod #.(lispify "new[]" 'method) ((self #.(lispify "bt-multi-sphere-shape" 'classname)) sizeInBytes)
  (#.(lispify "btMultiSphereShape_makeCPlusArray" 'function) (ff-pointer self) sizeInBytes))

(shadow "delete[]")
(defmethod #.(lispify "delete[]" 'method) ((self #.(lispify "bt-multi-sphere-shape" 'classname)) ptr)
  (#.(lispify "btMultiSphereShape_deleteCPlusArray" 'function) (ff-pointer self) ptr))

(shadow "new[]")
(defmethod #.(lispify "new[]" 'method) ((self #.(lispify "bt-multi-sphere-shape" 'classname)) arg1 ptr)
  (#.(lispify "btMultiSphereShape_makeCPlusArray" 'function) (ff-pointer self) arg1 ptr))

(shadow "delete[]")
(defmethod #.(lispify "delete[]" 'method) ((self #.(lispify "bt-multi-sphere-shape" 'classname)) arg1 arg2)
  (#.(lispify "btMultiSphereShape_deleteCPlusArray" 'function) (ff-pointer self) arg1 arg2))

(defmethod initialize-instance :after ((obj #.(lispify "bt-multi-sphere-shape" 'class)) &key (positions #.(lispify "bt-vector3" 'classname)) radi (numSpheres integer))
  (setf (slot-value obj 'ff-pointer) (#.(lispify "new_btMultiSphereShape" 'function) positions radi numSpheres)))

(defmethod #.(lispify "calculate-local-inertia" 'method) ((self #.(lispify "bt-multi-sphere-shape" 'classname)) (mass number) (inertia #.(lispify "bt-vector3" 'classname)))
  (#.(lispify "btMultiSphereShape_calculateLocalInertia" 'function) (ff-pointer self) mass inertia))

(defmethod #.(lispify "local-get-supporting-vertex-without-margin" 'method) ((self #.(lispify "bt-multi-sphere-shape" 'classname)) (vec #.(lispify "bt-vector3" 'classname)))
  (#.(lispify "btMultiSphereShape_localGetSupportingVertexWithoutMargin" 'function) (ff-pointer self) vec))

(defmethod #.(lispify "batched-unit-vector-get-supporting-vertex-without-margin" 'method) ((self #.(lispify "bt-multi-sphere-shape" 'classname)) (vectors #.(lispify "bt-vector3" 'classname)) (supportVerticesOut #.(lispify "bt-vector3" 'classname)) (numVectors integer))
  (#.(lispify "btMultiSphereShape_batchedUnitVectorGetSupportingVertexWithoutMargin" 'function) (ff-pointer self) vectors supportVerticesOut numVectors))

(defmethod #.(lispify "get-sphere-count" 'method) ((self #.(lispify "bt-multi-sphere-shape" 'classname)))
  (#.(lispify "btMultiSphereShape_getSphereCount" 'function) (ff-pointer self)))

(defmethod #.(lispify "get-sphere-position" 'method) ((self #.(lispify "bt-multi-sphere-shape" 'classname)) (index integer))
  (#.(lispify "btMultiSphereShape_getSpherePosition" 'function) (ff-pointer self) index))

(defmethod #.(lispify "get-sphere-radius" 'method) ((self #.(lispify "bt-multi-sphere-shape" 'classname)) (index integer))
  (#.(lispify "btMultiSphereShape_getSphereRadius" 'function) (ff-pointer self) index))

(defmethod #.(lispify "get-name" 'method) ((self #.(lispify "bt-multi-sphere-shape" 'classname)))
  (#.(lispify "btMultiSphereShape_getName" 'function) (ff-pointer self)))

(defmethod #.(lispify "calculate-serialize-buffer-size" 'method) ((self #.(lispify "bt-multi-sphere-shape" 'classname)))
  (#.(lispify "btMultiSphereShape_calculateSerializeBufferSize" 'function) (ff-pointer self)))

(defmethod #.(lispify "serialize" 'method) ((self #.(lispify "bt-multi-sphere-shape" 'classname)) dataBuffer serializer)
  (#.(lispify "btMultiSphereShape_serialize" 'function) (ff-pointer self) dataBuffer serializer))



(defmethod #.(lispify "new" 'method) ((self #.(lispify "bt-uniform-scaling-shape" 'classname)) sizeInBytes)
  (#.(lispify "btUniformScalingShape_makeCPlusPlusInstance" 'function) (ff-pointer self) sizeInBytes))

(defmethod #.(lispify "delete" 'method) ((self #.(lispify "bt-uniform-scaling-shape" 'classname)) ptr)
  (#.(lispify "btUniformScalingShape_deleteCPlusPlusInstance" 'function) (ff-pointer self) ptr))

(defmethod #.(lispify "new" 'method) ((self #.(lispify "bt-uniform-scaling-shape" 'classname)) arg1 ptr)
  (#.(lispify "btUniformScalingShape_makeCPlusPlusInstance" 'function) (ff-pointer self) arg1 ptr))

(defmethod #.(lispify "delete" 'method) ((self #.(lispify "bt-uniform-scaling-shape" 'classname)) arg1 arg2)
  (#.(lispify "btUniformScalingShape_deleteCPlusPlusInstance" 'function) (ff-pointer self) arg1 arg2))

(shadow "new[]")
(defmethod #.(lispify "new[]" 'method) ((self #.(lispify "bt-uniform-scaling-shape" 'classname)) sizeInBytes)
  (#.(lispify "btUniformScalingShape_makeCPlusArray" 'function) (ff-pointer self) sizeInBytes))

(shadow "delete[]")
(defmethod #.(lispify "delete[]" 'method) ((self #.(lispify "bt-uniform-scaling-shape" 'classname)) ptr)
  (#.(lispify "btUniformScalingShape_deleteCPlusArray" 'function) (ff-pointer self) ptr))

(shadow "new[]")
(defmethod #.(lispify "new[]" 'method) ((self #.(lispify "bt-uniform-scaling-shape" 'classname)) arg1 ptr)
  (#.(lispify "btUniformScalingShape_makeCPlusArray" 'function) (ff-pointer self) arg1 ptr))

(shadow "delete[]")
(defmethod #.(lispify "delete[]" 'method) ((self #.(lispify "bt-uniform-scaling-shape" 'classname)) arg1 arg2)
  (#.(lispify "btUniformScalingShape_deleteCPlusArray" 'function) (ff-pointer self) arg1 arg2))

(defmethod initialize-instance :after ((obj #.(lispify "bt-uniform-scaling-shape" 'class)) &key convexChildShape (uniformScalingFactor number))
  (setf (slot-value obj 'ff-pointer) (#.(lispify "new_btUniformScalingShape" 'function) convexChildShape uniformScalingFactor)))

(defmethod #.(lispify "local-get-supporting-vertex-without-margin" 'method) ((self #.(lispify "bt-uniform-scaling-shape" 'classname)) (vec #.(lispify "bt-vector3" 'classname)))
  (#.(lispify "btUniformScalingShape_localGetSupportingVertexWithoutMargin" 'function) (ff-pointer self) vec))

(defmethod #.(lispify "local-get-supporting-vertex" 'method) ((self #.(lispify "bt-uniform-scaling-shape" 'classname)) (vec #.(lispify "bt-vector3" 'classname)))
  (#.(lispify "btUniformScalingShape_localGetSupportingVertex" 'function) (ff-pointer self) vec))

(defmethod #.(lispify "batched-unit-vector-get-supporting-vertex-without-margin" 'method) ((self #.(lispify "bt-uniform-scaling-shape" 'classname)) (vectors #.(lispify "bt-vector3" 'classname)) (supportVerticesOut #.(lispify "bt-vector3" 'classname)) (numVectors integer))
  (#.(lispify "btUniformScalingShape_batchedUnitVectorGetSupportingVertexWithoutMargin" 'function) (ff-pointer self) vectors supportVerticesOut numVectors))

(defmethod #.(lispify "calculate-local-inertia" 'method) ((self #.(lispify "bt-uniform-scaling-shape" 'classname)) (mass number) (inertia #.(lispify "bt-vector3" 'classname)))
  (#.(lispify "btUniformScalingShape_calculateLocalInertia" 'function) (ff-pointer self) mass inertia))

(defmethod #.(lispify "get-uniform-scaling-factor" 'method) ((self #.(lispify "bt-uniform-scaling-shape" 'classname)))
  (#.(lispify "btUniformScalingShape_getUniformScalingFactor" 'function) (ff-pointer self)))

(defmethod #.(lispify "get-child-shape" 'method) ((self #.(lispify "bt-uniform-scaling-shape" 'classname)))
  (#.(lispify "btUniformScalingShape_getChildShape" 'function) (ff-pointer self)))

(defmethod #.(lispify "get-child-shape" 'method) ((self #.(lispify "bt-uniform-scaling-shape" 'classname)))
  (#.(lispify "btUniformScalingShape_getChildShape" 'function) (ff-pointer self)))

(defmethod #.(lispify "get-name" 'method) ((self #.(lispify "bt-uniform-scaling-shape" 'classname)))
  (#.(lispify "btUniformScalingShape_getName" 'function) (ff-pointer self)))

(defmethod #.(lispify "get-aabb" 'method) ((self #.(lispify "bt-uniform-scaling-shape" 'classname)) (t-arg1 #.(lispify "bt-transform" 'classname)) (aabbMin #.(lispify "bt-vector3" 'classname)) (aabbMax #.(lispify "bt-vector3" 'classname)))
  (#.(lispify "btUniformScalingShape_getAabb" 'function) (ff-pointer self) t-arg1 aabbMin aabbMax))

(defmethod #.(lispify "get-aabb-slow" 'method) ((self #.(lispify "bt-uniform-scaling-shape" 'classname)) (t-arg1 #.(lispify "bt-transform" 'classname)) (aabbMin #.(lispify "bt-vector3" 'classname)) (aabbMax #.(lispify "bt-vector3" 'classname)))
  (#.(lispify "btUniformScalingShape_getAabbSlow" 'function) (ff-pointer self) t-arg1 aabbMin aabbMax))

(defmethod #.(lispify "set-local-scaling" 'method) ((self #.(lispify "bt-uniform-scaling-shape" 'classname)) (scaling #.(lispify "bt-vector3" 'classname)))
  (#.(lispify "btUniformScalingShape_setLocalScaling" 'function) (ff-pointer self) scaling))

(defmethod #.(lispify "get-local-scaling" 'method) ((self #.(lispify "bt-uniform-scaling-shape" 'classname)))
  (#.(lispify "btUniformScalingShape_getLocalScaling" 'function) (ff-pointer self)))

(defmethod #.(lispify "set-margin" 'method) ((self #.(lispify "bt-uniform-scaling-shape" 'classname)) (margin number))
  (#.(lispify "btUniformScalingShape_setMargin" 'function) (ff-pointer self) margin))

(defmethod #.(lispify "get-margin" 'method) ((self #.(lispify "bt-uniform-scaling-shape" 'classname)))
  (#.(lispify "btUniformScalingShape_getMargin" 'function) (ff-pointer self)))

(defmethod #.(lispify "get-num-preferred-penetration-directions" 'method) ((self #.(lispify "bt-uniform-scaling-shape" 'classname)))
  (#.(lispify "btUniformScalingShape_getNumPreferredPenetrationDirections" 'function) (ff-pointer self)))

(defmethod #.(lispify "get-preferred-penetration-direction" 'method) ((self #.(lispify "bt-uniform-scaling-shape" 'classname)) (index integer) (penetrationVector #.(lispify "bt-vector3" 'classname)))
  (#.(lispify "btUniformScalingShape_getPreferredPenetrationDirection" 'function) (ff-pointer self) index penetrationVector))



(defmethod initialize-instance :after ((obj #.(lispify "bt-sphere-sphere-collision-algorithm" 'class)) &key mf ci col0Wrap col1Wrap)
  (setf (slot-value obj 'ff-pointer) (#.(lispify "new_btSphereSphereCollisionAlgorithm" 'function) mf ci col0Wrap col1Wrap)))

(defmethod initialize-instance :after ((obj #.(lispify "bt-sphere-sphere-collision-algorithm" 'class)) &key ci)
  (setf (slot-value obj 'ff-pointer) (#.(lispify "new_btSphereSphereCollisionAlgorithm" 'function) ci)))

(defmethod #.(lispify "process-collision" 'method) ((self #.(lispify "bt-sphere-sphere-collision-algorithm" 'classname)) body0Wrap body1Wrap dispatchInfo resultOut)
  (#.(lispify "btSphereSphereCollisionAlgorithm_processCollision" 'function) (ff-pointer self) body0Wrap body1Wrap dispatchInfo resultOut))

(defmethod #.(lispify "calculate-time-of-impact" 'method) ((self #.(lispify "bt-sphere-sphere-collision-algorithm" 'classname)) (body0 #.(lispify "bt-collision-object" 'classname)) (body1 #.(lispify "bt-collision-object" 'classname)) dispatchInfo resultOut)
  (#.(lispify "btSphereSphereCollisionAlgorithm_calculateTimeOfImpact" 'function) (ff-pointer self) body0 body1 dispatchInfo resultOut))

(defmethod #.(lispify "get-all-contact-manifolds" 'method) ((self #.(lispify "bt-sphere-sphere-collision-algorithm" 'classname)) manifoldArray)
  (#.(lispify "btSphereSphereCollisionAlgorithm_getAllContactManifolds" 'function) (ff-pointer self) manifoldArray))



#+ (or)
(defmethod initialize-instance :after ((obj #.(lispify "bt-default-collision-configuration" 'class)) &key constructionInfo)
  (setf (slot-value obj 'ff-pointer) (#.(lispify "new_btDefaultCollisionConfiguration" 'function) constructionInfo)))

(defmethod initialize-instance :after ((obj #.(lispify "bt-default-collision-configuration" 'class)) &key)
  (setf (slot-value obj 'ff-pointer) (#.(lispify "new_btDefaultCollisionConfiguration" 'function))))

(defmethod #.(lispify "get-persistent-manifold-pool" 'method) ((self #.(lispify "bt-default-collision-configuration" 'classname)))
  (#.(lispify "btDefaultCollisionConfiguration_getPersistentManifoldPool" 'function) (ff-pointer self)))

(defmethod #.(lispify "get-collision-algorithm-pool" 'method) ((self #.(lispify "bt-default-collision-configuration" 'classname)))
  (#.(lispify "btDefaultCollisionConfiguration_getCollisionAlgorithmPool" 'function) (ff-pointer self)))

(defmethod #.(lispify "get-simplex-solver" 'method) ((self #.(lispify "bt-default-collision-configuration" 'classname)))
  (#.(lispify "btDefaultCollisionConfiguration_getSimplexSolver" 'function) (ff-pointer self)))

(defmethod #.(lispify "get-collision-algorithm-create-func" 'method) ((self #.(lispify "bt-default-collision-configuration" 'classname)) (proxyType0 integer) (proxyType1 integer))
  (#.(lispify "btDefaultCollisionConfiguration_getCollisionAlgorithmCreateFunc" 'function) (ff-pointer self) proxyType0 proxyType1))

(defmethod #.(lispify "set-convex-convex-multipoint-iterations" 'method) ((self #.(lispify "bt-default-collision-configuration" 'classname)) (numPerturbationIterations integer) (minimumPointsPerturbationThreshold integer))
  (#.(lispify "btDefaultCollisionConfiguration_setConvexConvexMultipointIterations" 'function) (ff-pointer self) numPerturbationIterations minimumPointsPerturbationThreshold))

(defmethod #.(lispify "set-convex-convex-multipoint-iterations" 'method) ((self #.(lispify "bt-default-collision-configuration" 'classname)) (numPerturbationIterations integer))
  (#.(lispify "btDefaultCollisionConfiguration_setConvexConvexMultipointIterations" 'function) (ff-pointer self) numPerturbationIterations))

(defmethod #.(lispify "set-convex-convex-multipoint-iterations" 'method) ((self #.(lispify "bt-default-collision-configuration" 'classname)))
  (#.(lispify "btDefaultCollisionConfiguration_setConvexConvexMultipointIterations" 'function) (ff-pointer self)))

(defmethod #.(lispify "set-plane-convex-multipoint-iterations" 'method) ((self #.(lispify "bt-default-collision-configuration" 'classname)) (numPerturbationIterations integer) (minimumPointsPerturbationThreshold integer))
  (#.(lispify "btDefaultCollisionConfiguration_setPlaneConvexMultipointIterations" 'function) (ff-pointer self) numPerturbationIterations minimumPointsPerturbationThreshold))

(defmethod #.(lispify "set-plane-convex-multipoint-iterations" 'method) ((self #.(lispify "bt-default-collision-configuration" 'classname)) (numPerturbationIterations integer))
  (#.(lispify "btDefaultCollisionConfiguration_setPlaneConvexMultipointIterations" 'function) (ff-pointer self) numPerturbationIterations))

(defmethod #.(lispify "set-plane-convex-multipoint-iterations" 'method) ((self #.(lispify "bt-default-collision-configuration" 'classname)))
  (#.(lispify "btDefaultCollisionConfiguration_setPlaneConvexMultipointIterations" 'function) (ff-pointer self)))



(defmethod #.(lispify "get-dispatcher-flags" 'method) ((self #.(lispify "bt-collision-dispatcher" 'classname)))
  (#.(lispify "btCollisionDispatcher_getDispatcherFlags" 'function) (ff-pointer self)))

(defmethod #.(lispify "set-dispatcher-flags" 'method) ((self #.(lispify "bt-collision-dispatcher" 'classname)) (flags integer))
  (#.(lispify "btCollisionDispatcher_setDispatcherFlags" 'function) (ff-pointer self) flags))

(defmethod #.(lispify "register-collision-create-func" 'method) ((self #.(lispify "bt-collision-dispatcher" 'classname)) (proxyType0 integer) (proxyType1 integer) createFunc)
  (#.(lispify "btCollisionDispatcher_registerCollisionCreateFunc" 'function) (ff-pointer self) proxyType0 proxyType1 createFunc))

(defmethod #.(lispify "get-num-manifolds" 'method) ((self #.(lispify "bt-collision-dispatcher" 'classname)))
  (#.(lispify "btCollisionDispatcher_getNumManifolds" 'function) (ff-pointer self)))

(defmethod #.(lispify "get-internal-manifold-pointer" 'method) ((self #.(lispify "bt-collision-dispatcher" 'classname)))
  (#.(lispify "btCollisionDispatcher_getInternalManifoldPointer" 'function) (ff-pointer self)))

(defmethod #.(lispify "get-manifold-by-index-internal" 'method) ((self #.(lispify "bt-collision-dispatcher" 'classname)) (index integer))
  (#.(lispify "btCollisionDispatcher_getManifoldByIndexInternal" 'function) (ff-pointer self) index))

(defmethod #.(lispify "get-manifold-by-index-internal" 'method) ((self #.(lispify "bt-collision-dispatcher" 'classname)) (index integer))
  (#.(lispify "btCollisionDispatcher_getManifoldByIndexInternal" 'function) (ff-pointer self) index))

(defmethod initialize-instance :after ((obj #.(lispify "bt-collision-dispatcher" 'class)) &key collisionConfiguration)
  (setf (slot-value obj 'ff-pointer) (#.(lispify "new_btCollisionDispatcher" 'function) collisionConfiguration)))

(defmethod #.(lispify "get-new-manifold" 'method) ((self #.(lispify "bt-collision-dispatcher" 'classname)) (b0 #.(lispify "bt-collision-object" 'classname)) (b1 #.(lispify "bt-collision-object" 'classname)))
  (#.(lispify "btCollisionDispatcher_getNewManifold" 'function) (ff-pointer self) b0 b1))

(defmethod #.(lispify "release-manifold" 'method) ((self #.(lispify "bt-collision-dispatcher" 'classname)) manifold)
  (#.(lispify "btCollisionDispatcher_releaseManifold" 'function) (ff-pointer self) manifold))

(defmethod #.(lispify "clear-manifold" 'method) ((self #.(lispify "bt-collision-dispatcher" 'classname)) manifold)
  (#.(lispify "btCollisionDispatcher_clearManifold" 'function) (ff-pointer self) manifold))

(defmethod #.(lispify "find-algorithm" 'method) ((self #.(lispify "bt-collision-dispatcher" 'classname)) body0Wrap body1Wrap sharedManifold)
  (#.(lispify "btCollisionDispatcher_findAlgorithm" 'function) (ff-pointer self) body0Wrap body1Wrap sharedManifold))

(defmethod #.(lispify "find-algorithm" 'method) ((self #.(lispify "bt-collision-dispatcher" 'classname)) body0Wrap body1Wrap)
  (#.(lispify "btCollisionDispatcher_findAlgorithm" 'function) (ff-pointer self) body0Wrap body1Wrap))

(defmethod #.(lispify "needs-collision" 'method) ((self #.(lispify "bt-collision-dispatcher" 'classname)) (body0 #.(lispify "bt-collision-object" 'classname)) (body1 #.(lispify "bt-collision-object" 'classname)))
  (#.(lispify "btCollisionDispatcher_needsCollision" 'function) (ff-pointer self) body0 body1))

(defmethod #.(lispify "needs-response" 'method) ((self #.(lispify "bt-collision-dispatcher" 'classname)) (body0 #.(lispify "bt-collision-object" 'classname)) (body1 #.(lispify "bt-collision-object" 'classname)))
  (#.(lispify "btCollisionDispatcher_needsResponse" 'function) (ff-pointer self) body0 body1))

(defmethod #.(lispify "dispatch-all-collision-pairs" 'method) ((self #.(lispify "bt-collision-dispatcher" 'classname)) pairCache dispatchInfo dispatcher)
  (#.(lispify "btCollisionDispatcher_dispatchAllCollisionPairs" 'function) (ff-pointer self) pairCache dispatchInfo dispatcher))

(defmethod #.(lispify "set-near-callback" 'method) ((self #.(lispify "bt-collision-dispatcher" 'classname)) nearCallback)
  (#.(lispify "btCollisionDispatcher_setNearCallback" 'function) (ff-pointer self) nearCallback))

(defmethod #.(lispify "get-near-callback" 'method) ((self #.(lispify "bt-collision-dispatcher" 'classname)))
  (#.(lispify "btCollisionDispatcher_getNearCallback" 'function) (ff-pointer self)))

(defmethod #.(lispify "allocate-collision-algorithm" 'method) ((self #.(lispify "bt-collision-dispatcher" 'classname)) (size integer))
  (#.(lispify "btCollisionDispatcher_allocateCollisionAlgorithm" 'function) (ff-pointer self) size))

(defmethod #.(lispify "free-collision-algorithm" 'method) ((self #.(lispify "bt-collision-dispatcher" 'classname)) ptr)
  (#.(lispify "btCollisionDispatcher_freeCollisionAlgorithm" 'function) (ff-pointer self) ptr))

(defmethod #.(lispify "get-collision-configuration" 'method) ((self #.(lispify "bt-collision-dispatcher" 'classname)))
  (#.(lispify "btCollisionDispatcher_getCollisionConfiguration" 'function) (ff-pointer self)))

(defmethod #.(lispify "get-collision-configuration" 'method) ((self #.(lispify "bt-collision-dispatcher" 'classname)))
  (#.(lispify "btCollisionDispatcher_getCollisionConfiguration" 'function) (ff-pointer self)))

(defmethod #.(lispify "set-collision-configuration" 'method) ((self #.(lispify "bt-collision-dispatcher" 'classname)) config)
  (#.(lispify "btCollisionDispatcher_setCollisionConfiguration" 'function) (ff-pointer self) config))

(defmethod #.(lispify "get-internal-manifold-pool" 'method) ((self #.(lispify "bt-collision-dispatcher" 'classname)))
  (#.(lispify "btCollisionDispatcher_getInternalManifoldPool" 'function) (ff-pointer self)))

(defmethod #.(lispify "get-internal-manifold-pool" 'method) ((self #.(lispify "bt-collision-dispatcher" 'classname)))
  (#.(lispify "btCollisionDispatcher_getInternalManifoldPool" 'function) (ff-pointer self)))



(defmethod initialize-instance :after ((obj simple-broadphase) &key (maxProxies integer) overlappingPairCache)
  (setf (slot-value obj 'ff-pointer) (#.(lispify "new_btSimpleBroadphase" 'function) maxProxies overlappingPairCache)))

(defmethod initialize-instance :after ((obj #.(lispify "bt-simple-broadphase" 'class)) &key (maxProxies integer))
  (setf (slot-value obj 'ff-pointer) (#.(lispify "new_btSimpleBroadphase" 'function) maxProxies)))

(defmethod initialize-instance :after ((obj #.(lispify "bt-simple-broadphase" 'class)) &key)
  (setf (slot-value obj 'ff-pointer) (#.(lispify "new_btSimpleBroadphase" 'function))))

(defmethod #.(lispify "create-proxy" 'method) ((self #.(lispify "bt-simple-broadphase" 'classname)) (aabbMin #.(lispify "bt-vector3" 'classname)) (aabbMax #.(lispify "bt-vector3" 'classname)) (shapeType integer) userPtr (collisionFilterGroup integer) (collisionFilterMask integer) dispatcher multiSapProxy)
  (#.(lispify "btSimpleBroadphase_createProxy" 'function) (ff-pointer self) aabbMin aabbMax shapeType userPtr collisionFilterGroup collisionFilterMask dispatcher multiSapProxy))

(defmethod #.(lispify "calculate-overlapping-pairs" 'method) ((self #.(lispify "bt-simple-broadphase" 'classname)) dispatcher)
  (#.(lispify "btSimpleBroadphase_calculateOverlappingPairs" 'function) (ff-pointer self) dispatcher))

(defmethod #.(lispify "destroy-proxy" 'method) ((self #.(lispify "bt-simple-broadphase" 'classname)) proxy dispatcher)
  (#.(lispify "btSimpleBroadphase_destroyProxy" 'function) (ff-pointer self) proxy dispatcher))

(defmethod #.(lispify "set-aabb" 'method) ((self #.(lispify "bt-simple-broadphase" 'classname)) proxy (aabbMin #.(lispify "bt-vector3" 'classname)) (aabbMax #.(lispify "bt-vector3" 'classname)) dispatcher)
  (#.(lispify "btSimpleBroadphase_setAabb" 'function) (ff-pointer self) proxy aabbMin aabbMax dispatcher))

(defmethod #.(lispify "get-aabb" 'method) ((self #.(lispify "bt-simple-broadphase" 'classname)) proxy (aabbMin #.(lispify "bt-vector3" 'classname)) (aabbMax #.(lispify "bt-vector3" 'classname)))
  (#.(lispify "btSimpleBroadphase_getAabb" 'function) (ff-pointer self) proxy aabbMin aabbMax))

(defmethod #.(lispify "ray-test" 'method) ((self #.(lispify "bt-simple-broadphase" 'classname)) (rayFrom #.(lispify "bt-vector3" 'classname)) (rayTo #.(lispify "bt-vector3" 'classname)) rayCallback (aabbMin #.(lispify "bt-vector3" 'classname)) (aabbMax #.(lispify "bt-vector3" 'classname)))
  (#.(lispify "btSimpleBroadphase_rayTest" 'function) (ff-pointer self) rayFrom rayTo rayCallback aabbMin aabbMax))

(defmethod #.(lispify "ray-test" 'method) ((self #.(lispify "bt-simple-broadphase" 'classname)) (rayFrom #.(lispify "bt-vector3" 'classname)) (rayTo #.(lispify "bt-vector3" 'classname)) rayCallback (aabbMin #.(lispify "bt-vector3" 'classname)))
  (#.(lispify "btSimpleBroadphase_rayTest" 'function) (ff-pointer self) rayFrom rayTo rayCallback aabbMin))

(defmethod #.(lispify "ray-test" 'method) ((self #.(lispify "bt-simple-broadphase" 'classname)) (rayFrom #.(lispify "bt-vector3" 'classname)) (rayTo #.(lispify "bt-vector3" 'classname)) rayCallback)
  (#.(lispify "btSimpleBroadphase_rayTest" 'function) (ff-pointer self) rayFrom rayTo rayCallback))

(defmethod #.(lispify "aabb-test" 'method) ((self #.(lispify "bt-simple-broadphase" 'classname)) (aabbMin #.(lispify "bt-vector3" 'classname)) (aabbMax #.(lispify "bt-vector3" 'classname)) callback)
  (#.(lispify "btSimpleBroadphase_aabbTest" 'function) (ff-pointer self) aabbMin aabbMax callback))

(defmethod #.(lispify "get-overlapping-pair-cache" 'method) ((self #.(lispify "bt-simple-broadphase" 'classname)))
  (#.(lispify "btSimpleBroadphase_getOverlappingPairCache" 'function) (ff-pointer self)))

(defmethod #.(lispify "get-overlapping-pair-cache" 'method) ((self #.(lispify "bt-simple-broadphase" 'classname)))
  (#.(lispify "btSimpleBroadphase_getOverlappingPairCache" 'function) (ff-pointer self)))

(defmethod #.(lispify "test-aabb-overlap" 'method) ((self #.(lispify "bt-simple-broadphase" 'classname)) proxy0 proxy1)
  (#.(lispify "btSimpleBroadphase_testAabbOverlap" 'function) (ff-pointer self) proxy0 proxy1))

(defmethod #.(lispify "get-broadphase-aabb" 'method) ((self #.(lispify "bt-simple-broadphase" 'classname)) (aabbMin #.(lispify "bt-vector3" 'classname)) (aabbMax #.(lispify "bt-vector3" 'classname)))
  (#.(lispify "btSimpleBroadphase_getBroadphaseAabb" 'function) (ff-pointer self) aabbMin aabbMax))

(defmethod #.(lispify "print-stats" 'method) ((self #.(lispify "bt-simple-broadphase" 'classname)))
  (#.(lispify "btSimpleBroadphase_printStats" 'function) (ff-pointer self)))



(defmethod initialize-instance :after ((obj #.(lispify "bt-axis-sweep3" 'class)) &key (worldAabbMin #.(lispify "bt-vector3" 'classname)) (worldAabbMax #.(lispify "bt-vector3" 'classname)) (maxHandles integer) pairCache (disableRaycastAccelerator t))
  (setf (slot-value obj 'ff-pointer) (#.(lispify "new_btAxisSweep3" 'function) worldAabbMin worldAabbMax maxHandles pairCache disableRaycastAccelerator)))

(defmethod initialize-instance :after ((obj #.(lispify "bt-axis-sweep3" 'class)) &key (worldAabbMin #.(lispify "bt-vector3" 'classname)) (worldAabbMax #.(lispify "bt-vector3" 'classname)) (maxHandles integer) pairCache)
  (setf (slot-value obj 'ff-pointer) (#.(lispify "new_btAxisSweep3" 'function) worldAabbMin worldAabbMax maxHandles pairCache)))

(defmethod initialize-instance :after ((obj #.(lispify "bt-axis-sweep3" 'class)) &key (worldAabbMin #.(lispify "bt-vector3" 'classname)) (worldAabbMax #.(lispify "bt-vector3" 'classname)) (maxHandles integer))
  (setf (slot-value obj 'ff-pointer) (#.(lispify "new_btAxisSweep3" 'function) worldAabbMin worldAabbMax maxHandles)))

(defmethod initialize-instance :after ((obj #.(lispify "bt-axis-sweep3" 'class)) &key (worldAabbMin #.(lispify "bt-vector3" 'classname)) (worldAabbMax #.(lispify "bt-vector3" 'classname)))
  (setf (slot-value obj 'ff-pointer) (#.(lispify "new_btAxisSweep3" 'function) worldAabbMin worldAabbMax)))



(defmethod initialize-instance :after ((obj #.(lispify "bt32-bit-axis-sweep3" 'class)) &key (worldAabbMin #.(lispify "bt-vector3" 'classname)) (worldAabbMax #.(lispify "bt-vector3" 'classname)) (maxHandles integer) pairCache (disableRaycastAccelerator t))
  (setf (slot-value obj 'ff-pointer) (#.(lispify "new_bt32BitAxisSweep3" 'function) worldAabbMin worldAabbMax maxHandles pairCache disableRaycastAccelerator)))

(defmethod initialize-instance :after ((obj #.(lispify "bt32-bit-axis-sweep3" 'class)) &key (worldAabbMin #.(lispify "bt-vector3" 'classname)) (worldAabbMax #.(lispify "bt-vector3" 'classname)) (maxHandles integer) pairCache)
  (setf (slot-value obj 'ff-pointer) (#.(lispify "new_bt32BitAxisSweep3" 'function) worldAabbMin worldAabbMax maxHandles pairCache)))

(defmethod initialize-instance :after ((obj #.(lispify "bt32-bit-axis-sweep3" 'class)) &key (worldAabbMin #.(lispify "bt-vector3" 'classname)) (worldAabbMax #.(lispify "bt-vector3" 'classname)) (maxHandles integer))
  (setf (slot-value obj 'ff-pointer) (#.(lispify "new_bt32BitAxisSweep3" 'function) worldAabbMin worldAabbMax maxHandles)))

(defmethod initialize-instance :after ((obj #.(lispify "bt32-bit-axis-sweep3" 'class)) &key (worldAabbMin #.(lispify "bt-vector3" 'classname)) (worldAabbMax #.(lispify "bt-vector3" 'classname)))
  (setf (slot-value obj 'ff-pointer) (#.(lispify "new_bt32BitAxisSweep3" 'function) worldAabbMin worldAabbMax)))



(defmethod #.(lispify "get-broadphase-array" 'method) ((self #.(lispify "bt-multi-sap-broadphase" 'classname)))
  (#.(lispify "btMultiSapBroadphase_getBroadphaseArray" 'function) (ff-pointer self)))

(defmethod #.(lispify "get-broadphase-array" 'method) ((self #.(lispify "bt-multi-sap-broadphase" 'classname)))
  (#.(lispify "btMultiSapBroadphase_getBroadphaseArray" 'function) (ff-pointer self)))

(defmethod #.(lispify "create-proxy" 'method) ((self #.(lispify "bt-multi-sap-broadphase" 'classname)) (aabbMin #.(lispify "bt-vector3" 'classname)) (aabbMax #.(lispify "bt-vector3" 'classname)) (shapeType integer) userPtr (collisionFilterGroup integer) (collisionFilterMask integer) dispatcher multiSapProxy)
  (#.(lispify "btMultiSapBroadphase_createProxy" 'function) (ff-pointer self) aabbMin aabbMax shapeType userPtr collisionFilterGroup collisionFilterMask dispatcher multiSapProxy))

(defmethod #.(lispify "destroy-proxy" 'method) ((self #.(lispify "bt-multi-sap-broadphase" 'classname)) proxy dispatcher)
  (#.(lispify "btMultiSapBroadphase_destroyProxy" 'function) (ff-pointer self) proxy dispatcher))

(defmethod #.(lispify "set-aabb" 'method) ((self #.(lispify "bt-multi-sap-broadphase" 'classname)) proxy (aabbMin #.(lispify "bt-vector3" 'classname)) (aabbMax #.(lispify "bt-vector3" 'classname)) dispatcher)
  (#.(lispify "btMultiSapBroadphase_setAabb" 'function) (ff-pointer self) proxy aabbMin aabbMax dispatcher))

(defmethod #.(lispify "get-aabb" 'method) ((self #.(lispify "bt-multi-sap-broadphase" 'classname)) proxy (aabbMin #.(lispify "bt-vector3" 'classname)) (aabbMax #.(lispify "bt-vector3" 'classname)))
  (#.(lispify "btMultiSapBroadphase_getAabb" 'function) (ff-pointer self) proxy aabbMin aabbMax))

(defmethod #.(lispify "ray-test" 'method) ((self #.(lispify "bt-multi-sap-broadphase" 'classname)) (rayFrom #.(lispify "bt-vector3" 'classname)) (rayTo #.(lispify "bt-vector3" 'classname)) rayCallback (aabbMin #.(lispify "bt-vector3" 'classname)) (aabbMax #.(lispify "bt-vector3" 'classname)))
  (#.(lispify "btMultiSapBroadphase_rayTest" 'function) (ff-pointer self) rayFrom rayTo rayCallback aabbMin aabbMax))

(defmethod #.(lispify "ray-test" 'method) ((self #.(lispify "bt-multi-sap-broadphase" 'classname)) (rayFrom #.(lispify "bt-vector3" 'classname)) (rayTo #.(lispify "bt-vector3" 'classname)) rayCallback (aabbMin #.(lispify "bt-vector3" 'classname)))
  (#.(lispify "btMultiSapBroadphase_rayTest" 'function) (ff-pointer self) rayFrom rayTo rayCallback aabbMin))

(defmethod #.(lispify "ray-test" 'method) ((self #.(lispify "bt-multi-sap-broadphase" 'classname)) (rayFrom #.(lispify "bt-vector3" 'classname)) (rayTo #.(lispify "bt-vector3" 'classname)) rayCallback)
  (#.(lispify "btMultiSapBroadphase_rayTest" 'function) (ff-pointer self) rayFrom rayTo rayCallback))

(defmethod #.(lispify "add-to-child-broadphase" 'method) ((self #.(lispify "bt-multi-sap-broadphase" 'classname)) parentMultiSapProxy childProxy childBroadphase)
  (#.(lispify "btMultiSapBroadphase_addToChildBroadphase" 'function) (ff-pointer self) parentMultiSapProxy childProxy childBroadphase))

(defmethod #.(lispify "calculate-overlapping-pairs" 'method) ((self #.(lispify "bt-multi-sap-broadphase" 'classname)) dispatcher)
  (#.(lispify "btMultiSapBroadphase_calculateOverlappingPairs" 'function) (ff-pointer self) dispatcher))

(defmethod #.(lispify "test-aabb-overlap" 'method) ((self #.(lispify "bt-multi-sap-broadphase" 'classname)) proxy0 proxy1)
  (#.(lispify "btMultiSapBroadphase_testAabbOverlap" 'function) (ff-pointer self) proxy0 proxy1))

(defmethod #.(lispify "get-overlapping-pair-cache" 'method) ((self #.(lispify "bt-multi-sap-broadphase" 'classname)))
  (#.(lispify "btMultiSapBroadphase_getOverlappingPairCache" 'function) (ff-pointer self)))

(defmethod #.(lispify "get-overlapping-pair-cache" 'method) ((self #.(lispify "bt-multi-sap-broadphase" 'classname)))
  (#.(lispify "btMultiSapBroadphase_getOverlappingPairCache" 'function) (ff-pointer self)))

(defmethod #.(lispify "get-broadphase-aabb" 'method) ((self #.(lispify "bt-multi-sap-broadphase" 'classname)) (aabbMin #.(lispify "bt-vector3" 'classname)) (aabbMax #.(lispify "bt-vector3" 'classname)))
  (#.(lispify "btMultiSapBroadphase_getBroadphaseAabb" 'function) (ff-pointer self) aabbMin aabbMax))

(defmethod #.(lispify "build-tree" 'method) ((self #.(lispify "bt-multi-sap-broadphase" 'classname)) (bvhAabbMin #.(lispify "bt-vector3" 'classname)) (bvhAabbMax #.(lispify "bt-vector3" 'classname)))
  (#.(lispify "btMultiSapBroadphase_buildTree" 'function) (ff-pointer self) bvhAabbMin bvhAabbMax))

(defmethod #.(lispify "print-stats" 'method) ((self #.(lispify "bt-multi-sap-broadphase" 'classname)))
  (#.(lispify "btMultiSapBroadphase_printStats" 'function) (ff-pointer self)))

(defmethod #.(lispify "quicksort" 'method) ((self #.(lispify "bt-multi-sap-broadphase" 'classname)) a (lo integer) (hi integer))
  (#.(lispify "btMultiSapBroadphase_quicksort" 'function) (ff-pointer self) a lo hi))

(defmethod #.(lispify "reset-pool" 'method) ((self #.(lispify "bt-multi-sap-broadphase" 'classname)) dispatcher)
  (#.(lispify "btMultiSapBroadphase_resetPool" 'function) (ff-pointer self) dispatcher))



(defmethod initialize-instance :after ((obj #.(lispify "bt-clock" 'class)) &key)
  (setf (slot-value obj 'ff-pointer) (#.(lispify "new_btClock" 'function))))

(defmethod initialize-instance :after ((obj #.(lispify "bt-clock" 'class)) &key (other #.(lispify "bt-clock" 'classname)))
  (setf (slot-value obj 'ff-pointer) (#.(lispify "new_btClock" 'function) (ff-pointer other))))

(shadow "=")
(defmethod #.(lispify "=" 'method) ((self #.(lispify "bt-clock" 'classname)) (other #.(lispify "bt-clock" 'classname)))
  (#.(lispify "btClock_assignValue" 'function) (ff-pointer self) (ff-pointer other)))

(defmethod #.(lispify "reset" 'method) ((self #.(lispify "bt-clock" 'classname)))
  (#.(lispify "btClock_reset" 'function) (ff-pointer self)))

(defmethod #.(lispify "get-time-milliseconds" 'method) ((self #.(lispify "bt-clock" 'classname)))
  (#.(lispify "btClock_getTimeMilliseconds" 'function) (ff-pointer self)))

(defmethod #.(lispify "get-time-microseconds" 'method) ((self #.(lispify "bt-clock" 'classname)))
  (#.(lispify "btClock_getTimeMicroseconds" 'function) (ff-pointer self)))



(defmethod initialize-instance :after ((obj #.(lispify "cprofile-node" 'class)) &key (name string) (parent #.(lispify "cprofile-node" 'classname)))
  (setf (slot-value obj 'ff-pointer) (#.(lispify "new_CProfileNode" 'function) name (ff-pointer parent))))

(defmethod #.(lispify "get-sub-node" 'method) ((self #.(lispify "cprofile-node" 'classname)) (name string))
  (#.(lispify "CProfileNode_Get_Sub_Node" 'function) (ff-pointer self) name))

(defmethod #.(lispify "get-parent" 'method) ((self #.(lispify "cprofile-node" 'classname)))
  (#.(lispify "CProfileNode_Get_Parent" 'function) (ff-pointer self)))

(defmethod #.(lispify "get-sibling" 'method) ((self #.(lispify "cprofile-node" 'classname)))
  (#.(lispify "CProfileNode_Get_Sibling" 'function) (ff-pointer self)))

(defmethod #.(lispify "get-child" 'method) ((self #.(lispify "cprofile-node" 'classname)))
  (#.(lispify "CProfileNode_Get_Child" 'function) (ff-pointer self)))

(defmethod #.(lispify "cleanup-memory" 'method) ((self #.(lispify "cprofile-node" 'classname)))
  (#.(lispify "CProfileNode_CleanupMemory" 'function) (ff-pointer self)))

(defmethod #.(lispify "reset" 'method) ((self #.(lispify "cprofile-node" 'classname)))
  (#.(lispify "CProfileNode_Reset" 'function) (ff-pointer self)))

(defmethod #.(lispify "call" 'method) ((self #.(lispify "cprofile-node" 'classname)))
  (#.(lispify "CProfileNode_Call" 'function) (ff-pointer self)))

(defmethod #.(lispify "return" 'method) ((self #.(lispify "cprofile-node" 'classname)))
  (#.(lispify "CProfileNode_Return" 'function) (ff-pointer self)))

(defmethod #.(lispify "get-name" 'method) ((self #.(lispify "cprofile-node" 'classname)))
  (#.(lispify "CProfileNode_Get_Name" 'function) (ff-pointer self)))

(defmethod #.(lispify "get-total-calls" 'method) ((self #.(lispify "cprofile-node" 'classname)))
  (#.(lispify "CProfileNode_Get_Total_Calls" 'function) (ff-pointer self)))

(defmethod #.(lispify "get-total-time" 'method) ((self #.(lispify "cprofile-node" 'classname)))
  (#.(lispify "CProfileNode_Get_Total_Time" 'function) (ff-pointer self)))

(defmethod #.(lispify "get-user-pointer" 'method) ((self #.(lispify "cprofile-node" 'classname)))
  (#.(lispify "CProfileNode_GetUserPointer" 'function) (ff-pointer self)))

(defmethod #.(lispify "set-user-pointer" 'method) ((self #.(lispify "cprofile-node" 'classname)) ptr)
  (#.(lispify "CProfileNode_SetUserPointer" 'function) (ff-pointer self) ptr))



(defmethod #.(lispify "first" 'method) ((self #.(lispify "cprofile-iterator" 'classname)))
  (#.(lispify "CProfileIterator_First" 'function) (ff-pointer self)))

(defmethod #.(lispify "next" 'method) ((self #.(lispify "cprofile-iterator" 'classname)))
  (#.(lispify "CProfileIterator_Next" 'function) (ff-pointer self)))

(defmethod #.(lispify "is-done" 'method) ((self #.(lispify "cprofile-iterator" 'classname)))
  (#.(lispify "CProfileIterator_Is_Done" 'function) (ff-pointer self)))

(defmethod #.(lispify "is-root" 'method) ((self #.(lispify "cprofile-iterator" 'classname)))
  (#.(lispify "CProfileIterator_Is_Root" 'function) (ff-pointer self)))

(defmethod #.(lispify "enter-child" 'method) ((self #.(lispify "cprofile-iterator" 'classname)) (index integer))
  (#.(lispify "CProfileIterator_Enter_Child" 'function) (ff-pointer self) index))

(defmethod #.(lispify "enter-largest-child" 'method) ((self #.(lispify "cprofile-iterator" 'classname)))
  (#.(lispify "CProfileIterator_Enter_Largest_Child" 'function) (ff-pointer self)))

(defmethod #.(lispify "enter-parent" 'method) ((self #.(lispify "cprofile-iterator" 'classname)))
  (#.(lispify "CProfileIterator_Enter_Parent" 'function) (ff-pointer self)))

(defmethod #.(lispify "get-current-name" 'method) ((self #.(lispify "cprofile-iterator" 'classname)))
  (#.(lispify "CProfileIterator_Get_Current_Name" 'function) (ff-pointer self)))

(defmethod #.(lispify "get-current-total-calls" 'method) ((self #.(lispify "cprofile-iterator" 'classname)))
  (#.(lispify "CProfileIterator_Get_Current_Total_Calls" 'function) (ff-pointer self)))

(defmethod #.(lispify "get-current-total-time" 'method) ((self #.(lispify "cprofile-iterator" 'classname)))
  (#.(lispify "CProfileIterator_Get_Current_Total_Time" 'function) (ff-pointer self)))

(defmethod #.(lispify "get-current-user-pointer" 'method) ((self #.(lispify "cprofile-iterator" 'classname)))
  (#.(lispify "CProfileIterator_Get_Current_UserPointer" 'function) (ff-pointer self)))

(defmethod #.(lispify "set-current-user-pointer" 'method) ((self #.(lispify "cprofile-iterator" 'classname)) ptr)
  (#.(lispify "CProfileIterator_Set_Current_UserPointer" 'function) (ff-pointer self) ptr))

(defmethod #.(lispify "get-current-parent-name" 'method) ((self #.(lispify "cprofile-iterator" 'classname)))
  (#.(lispify "CProfileIterator_Get_Current_Parent_Name" 'function) (ff-pointer self)))

(defmethod #.(lispify "get-current-parent-total-calls" 'method) ((self #.(lispify "cprofile-iterator" 'classname)))
  (#.(lispify "CProfileIterator_Get_Current_Parent_Total_Calls" 'function) (ff-pointer self)))

(defmethod #.(lispify "get-current-parent-total-time" 'method) ((self #.(lispify "cprofile-iterator" 'classname)))
  (#.(lispify "CProfileIterator_Get_Current_Parent_Total_Time" 'function) (ff-pointer self)))



(defmethod initialize-instance :after ((obj #.(lispify "cprofile-manager" 'class)) &key)
  (setf (slot-value obj 'ff-pointer) (#.(lispify "new_CProfileManager" 'function))))



(defmethod initialize-instance :after ((obj #.(lispify "cprofile-sample" 'class)) &key (name string))
  (setf (slot-value obj 'ff-pointer) (#.(lispify "new_CProfileSample" 'function) name)))



(defmethod #.(lispify "draw-line" 'method) ((self #.(lispify "bt-idebug-draw" 'classname)) (from #.(lispify "bt-vector3" 'classname)) (to #.(lispify "bt-vector3" 'classname)) (color #.(lispify "bt-vector3" 'classname)))
  (#.(lispify "btIDebugDraw_drawLine" 'function) (ff-pointer self) from to color))

(defmethod #.(lispify "draw-line" 'method) ((self #.(lispify "bt-idebug-draw" 'classname)) (from #.(lispify "bt-vector3" 'classname)) (to #.(lispify "bt-vector3" 'classname)) (fromColor #.(lispify "bt-vector3" 'classname)) (toColor #.(lispify "bt-vector3" 'classname)))
  (#.(lispify "btIDebugDraw_drawLine" 'function) (ff-pointer self) from to fromColor toColor))

(defmethod #.(lispify "draw-sphere" 'method) ((self #.(lispify "bt-idebug-draw" 'classname)) (radius number) (transform #.(lispify "bt-transform" 'classname)) (color #.(lispify "bt-vector3" 'classname)))
  (#.(lispify "btIDebugDraw_drawSphere" 'function) (ff-pointer self) radius transform color))

(defmethod #.(lispify "draw-sphere" 'method) ((self #.(lispify "bt-idebug-draw" 'classname)) (p #.(lispify "bt-vector3" 'classname)) (radius number) (color #.(lispify "bt-vector3" 'classname)))
  (#.(lispify "btIDebugDraw_drawSphere" 'function) (ff-pointer self) p radius color))

(defmethod #.(lispify "draw-triangle" 'method) ((self #.(lispify "bt-idebug-draw" 'classname)) (v0 #.(lispify "bt-vector3" 'classname)) (v1 #.(lispify "bt-vector3" 'classname)) (v2 #.(lispify "bt-vector3" 'classname)) (arg4 #.(lispify "bt-vector3" 'classname)) (arg5 #.(lispify "bt-vector3" 'classname)) (arg6 #.(lispify "bt-vector3" 'classname)) (color #.(lispify "bt-vector3" 'classname)) (alpha number))
  (#.(lispify "btIDebugDraw_drawTriangle" 'function) (ff-pointer self) v0 v1 v2 arg4 arg5 arg6 color alpha))

(defmethod #.(lispify "draw-triangle" 'method) ((self #.(lispify "bt-idebug-draw" 'classname)) (v0 #.(lispify "bt-vector3" 'classname)) (v1 #.(lispify "bt-vector3" 'classname)) (v2 #.(lispify "bt-vector3" 'classname)) (color #.(lispify "bt-vector3" 'classname)) (arg5 number))
  (#.(lispify "btIDebugDraw_drawTriangle" 'function) (ff-pointer self) v0 v1 v2 color arg5))

(defmethod #.(lispify "draw-contact-point" 'method) ((self #.(lispify "bt-idebug-draw" 'classname)) (PointOnB #.(lispify "bt-vector3" 'classname)) (normalOnB #.(lispify "bt-vector3" 'classname)) (distance number) (lifeTime integer) (color #.(lispify "bt-vector3" 'classname)))
  (#.(lispify "btIDebugDraw_drawContactPoint" 'function) (ff-pointer self) PointOnB normalOnB distance lifeTime color))

(defmethod #.(lispify "report-error-warning" 'method) ((self #.(lispify "bt-idebug-draw" 'classname)) (warningString string))
  (#.(lispify "btIDebugDraw_reportErrorWarning" 'function) (ff-pointer self) warningString))

(defmethod #.(lispify "draw3d-text" 'method) ((self #.(lispify "bt-idebug-draw" 'classname)) (location #.(lispify "bt-vector3" 'classname)) (textString string))
  (#.(lispify "btIDebugDraw_draw3dText" 'function) (ff-pointer self) location textString))

(defmethod #.(lispify "set-debug-mode" 'method) ((self #.(lispify "bt-idebug-draw" 'classname)) (debugMode integer))
  (#.(lispify "btIDebugDraw_setDebugMode" 'function) (ff-pointer self) debugMode))

(defmethod #.(lispify "get-debug-mode" 'method) ((self #.(lispify "bt-idebug-draw" 'classname)))
  (#.(lispify "btIDebugDraw_getDebugMode" 'function) (ff-pointer self)))

(defmethod #.(lispify "draw-aabb" 'method) ((self #.(lispify "bt-idebug-draw" 'classname)) (from #.(lispify "bt-vector3" 'classname)) (to #.(lispify "bt-vector3" 'classname)) (color #.(lispify "bt-vector3" 'classname)))
  (#.(lispify "btIDebugDraw_drawAabb" 'function) (ff-pointer self) from to color))

(defmethod #.(lispify "draw-transform" 'method) ((self #.(lispify "bt-idebug-draw" 'classname)) (transform #.(lispify "bt-transform" 'classname)) (orthoLen number))
  (#.(lispify "btIDebugDraw_drawTransform" 'function) (ff-pointer self) transform orthoLen))

(defmethod #.(lispify "draw-arc" 'method) ((self #.(lispify "bt-idebug-draw" 'classname)) (center #.(lispify "bt-vector3" 'classname)) (normal #.(lispify "bt-vector3" 'classname)) (axis #.(lispify "bt-vector3" 'classname)) (radiusA number) (radiusB number) (minAngle number) (maxAngle number) (color #.(lispify "bt-vector3" 'classname)) (drawSect t) (stepDegrees number))
  (#.(lispify "btIDebugDraw_drawArc" 'function) (ff-pointer self) center normal axis radiusA radiusB minAngle maxAngle color drawSect stepDegrees))

(defmethod #.(lispify "draw-arc" 'method) ((self #.(lispify "bt-idebug-draw" 'classname)) (center #.(lispify "bt-vector3" 'classname)) (normal #.(lispify "bt-vector3" 'classname)) (axis #.(lispify "bt-vector3" 'classname)) (radiusA number) (radiusB number) (minAngle number) (maxAngle number) (color #.(lispify "bt-vector3" 'classname)) (drawSect t))
  (#.(lispify "btIDebugDraw_drawArc" 'function) (ff-pointer self) center normal axis radiusA radiusB minAngle maxAngle color drawSect))

(defmethod #.(lispify "draw-sphere-patch" 'method) ((self #.(lispify "bt-idebug-draw" 'classname)) (center #.(lispify "bt-vector3" 'classname)) (up #.(lispify "bt-vector3" 'classname)) (axis #.(lispify "bt-vector3" 'classname)) (radius number) (minTh number) (maxTh number) (minPs number) (maxPs number) (color #.(lispify "bt-vector3" 'classname)) (stepDegrees number) (drawCenter t))
  (#.(lispify "btIDebugDraw_drawSpherePatch" 'function) (ff-pointer self) center up axis radius minTh maxTh minPs maxPs color stepDegrees drawCenter))

(defmethod #.(lispify "draw-sphere-patch" 'method) ((self #.(lispify "bt-idebug-draw" 'classname)) (center #.(lispify "bt-vector3" 'classname)) (up #.(lispify "bt-vector3" 'classname)) (axis #.(lispify "bt-vector3" 'classname)) (radius number) (minTh number) (maxTh number) (minPs number) (maxPs number) (color #.(lispify "bt-vector3" 'classname)) (stepDegrees number))
  (#.(lispify "btIDebugDraw_drawSpherePatch" 'function) (ff-pointer self) center up axis radius minTh maxTh minPs maxPs color stepDegrees))

(defmethod #.(lispify "draw-sphere-patch" 'method) ((self #.(lispify "bt-idebug-draw" 'classname)) (center #.(lispify "bt-vector3" 'classname)) (up #.(lispify "bt-vector3" 'classname)) (axis #.(lispify "bt-vector3" 'classname)) (radius number) (minTh number) (maxTh number) (minPs number) (maxPs number) (color #.(lispify "bt-vector3" 'classname)))
  (#.(lispify "btIDebugDraw_drawSpherePatch" 'function) (ff-pointer self) center up axis radius minTh maxTh minPs maxPs color))

(defmethod #.(lispify "draw-box" 'method) ((self #.(lispify "bt-idebug-draw" 'classname)) (bbMin #.(lispify "bt-vector3" 'classname)) (bbMax #.(lispify "bt-vector3" 'classname)) (color #.(lispify "bt-vector3" 'classname)))
  (#.(lispify "btIDebugDraw_drawBox" 'function) (ff-pointer self) bbMin bbMax color))

(defmethod #.(lispify "draw-box" 'method) ((self #.(lispify "bt-idebug-draw" 'classname)) (bbMin #.(lispify "bt-vector3" 'classname)) (bbMax #.(lispify "bt-vector3" 'classname)) (trans #.(lispify "bt-transform" 'classname)) (color #.(lispify "bt-vector3" 'classname)))
  (#.(lispify "btIDebugDraw_drawBox" 'function) (ff-pointer self) bbMin bbMax trans color))

(defmethod #.(lispify "draw-capsule" 'method) ((self #.(lispify "bt-idebug-draw" 'classname)) (radius number) (halfHeight number) (upAxis integer) (transform #.(lispify "bt-transform" 'classname)) (color #.(lispify "bt-vector3" 'classname)))
  (#.(lispify "btIDebugDraw_drawCapsule" 'function) (ff-pointer self) radius halfHeight upAxis transform color))

(defmethod #.(lispify "draw-cylinder" 'method) ((self #.(lispify "bt-idebug-draw" 'classname)) (radius number) (halfHeight number) (upAxis integer) (transform #.(lispify "bt-transform" 'classname)) (color #.(lispify "bt-vector3" 'classname)))
  (#.(lispify "btIDebugDraw_drawCylinder" 'function) (ff-pointer self) radius halfHeight upAxis transform color))

(defmethod #.(lispify "draw-cone" 'method) ((self #.(lispify "bt-idebug-draw" 'classname)) (radius number) (height number) (upAxis integer) (transform #.(lispify "bt-transform" 'classname)) (color #.(lispify "bt-vector3" 'classname)))
  (#.(lispify "btIDebugDraw_drawCone" 'function) (ff-pointer self) radius height upAxis transform color))

(defmethod #.(lispify "draw-plane" 'method) ((self #.(lispify "bt-idebug-draw" 'classname)) (planeNormal #.(lispify "bt-vector3" 'classname)) (planeConst number) (transform #.(lispify "bt-transform" 'classname)) (color #.(lispify "bt-vector3" 'classname)))
  (#.(lispify "btIDebugDraw_drawPlane" 'function) (ff-pointer self) planeNormal planeConst transform color))



(defmethod (setf #.(lispify "m_chunkCode" 'method)) (arg0 (obj #.(lispify "bt-chunk" 'class)))
  (#.(lispify "btChunk_m_chunkCode_set" 'function) (ff-pointer obj) arg0))

(defmethod #.(lispify "m_chunkCode" 'method) ((obj #.(lispify "bt-chunk" 'class)))
  (#.(lispify "btChunk_m_chunkCode_get" 'function) (ff-pointer obj)))

(defmethod (setf #.(lispify "m_length" 'method)) (arg0 (obj #.(lispify "bt-chunk" 'class)))
  (#.(lispify "btChunk_m_length_set" 'function) (ff-pointer obj) arg0))

(defmethod #.(lispify "m_length" 'method) ((obj #.(lispify "bt-chunk" 'class)))
  (#.(lispify "btChunk_m_length_get" 'function) (ff-pointer obj)))

(defmethod (setf #.(lispify "m_oldPtr" 'method)) (arg0 (obj #.(lispify "bt-chunk" 'class)))
  (#.(lispify "btChunk_m_oldPtr_set" 'function) (ff-pointer obj) arg0))

(defmethod #.(lispify "m_oldPtr" 'method) ((obj #.(lispify "bt-chunk" 'class)))
  (#.(lispify "btChunk_m_oldPtr_get" 'function) (ff-pointer obj)))

(defmethod (setf #.(lispify "m_dna_nr" 'method)) (arg0 (obj #.(lispify "bt-chunk" 'class)))
  (#.(lispify "btChunk_m_dna_nr_set" 'function) (ff-pointer obj) arg0))

(defmethod #.(lispify "m_dna_nr" 'method) ((obj #.(lispify "bt-chunk" 'class)))
  (#.(lispify "btChunk_m_dna_nr_get" 'function) (ff-pointer obj)))

(defmethod (setf #.(lispify "m_number" 'method)) (arg0 (obj #.(lispify "bt-chunk" 'class)))
  (#.(lispify "btChunk_m_number_set" 'function) (ff-pointer obj) arg0))

(defmethod #.(lispify "m_number" 'method) ((obj #.(lispify "bt-chunk" 'class)))
  (#.(lispify "btChunk_m_number_get" 'function) (ff-pointer obj)))

(defmethod initialize-instance :after ((obj #.(lispify "bt-chunk" 'class)) &key)
  (setf (slot-value obj 'ff-pointer) (#.(lispify "new_btChunk" 'function))))



(defmethod #.(lispify "get-buffer-pointer" 'method) ((self #.(lispify "bt-serializer" 'classname)))
  (#.(lispify "btSerializer_getBufferPointer" 'function) (ff-pointer self)))

(defmethod #.(lispify "get-current-buffer-size" 'method) ((self #.(lispify "bt-serializer" 'classname)))
  (#.(lispify "btSerializer_getCurrentBufferSize" 'function) (ff-pointer self)))

(defmethod #.(lispify "allocate" 'method) ((self #.(lispify "bt-serializer" 'classname)) size (numElements integer))
  (#.(lispify "btSerializer_allocate" 'function) (ff-pointer self) size numElements))

(defmethod #.(lispify "finalize-chunk" 'method) ((self #.(lispify "bt-serializer" 'classname)) (chunk #.(lispify "bt-chunk" 'classname)) (structType string) (chunkCode integer) oldPtr)
  (#.(lispify "btSerializer_finalizeChunk" 'function) (ff-pointer self) chunk structType chunkCode oldPtr))

(defmethod #.(lispify "find-pointer" 'method) ((self #.(lispify "bt-serializer" 'classname)) oldPtr)
  (#.(lispify "btSerializer_findPointer" 'function) (ff-pointer self) oldPtr))

(defmethod #.(lispify "get-unique-pointer" 'method) ((self #.(lispify "bt-serializer" 'classname)) oldPtr)
  (#.(lispify "btSerializer_getUniquePointer" 'function) (ff-pointer self) oldPtr))

(defmethod #.(lispify "start-serialization" 'method) ((self #.(lispify "bt-serializer" 'classname)))
  (#.(lispify "btSerializer_startSerialization" 'function) (ff-pointer self)))

(defmethod #.(lispify "finish-serialization" 'method) ((self #.(lispify "bt-serializer" 'classname)))
  (#.(lispify "btSerializer_finishSerialization" 'function) (ff-pointer self)))

(defmethod #.(lispify "find-name-for-pointer" 'method) ((self #.(lispify "bt-serializer" 'classname)) ptr)
  (#.(lispify "btSerializer_findNameForPointer" 'function) (ff-pointer self) ptr))

(defmethod #.(lispify "register-name-for-pointer" 'method) ((self #.(lispify "bt-serializer" 'classname)) ptr (name string))
  (#.(lispify "btSerializer_registerNameForPointer" 'function) (ff-pointer self) ptr name))

(defmethod #.(lispify "serialize-name" 'method) ((self #.(lispify "bt-serializer" 'classname)) (ptr string))
  (#.(lispify "btSerializer_serializeName" 'function) (ff-pointer self) ptr))

(defmethod #.(lispify "get-serialization-flags" 'method) ((self #.(lispify "bt-serializer" 'classname)))
  (#.(lispify "btSerializer_getSerializationFlags" 'function) (ff-pointer self)))

(defmethod #.(lispify "set-serialization-flags" 'method) ((self #.(lispify "bt-serializer" 'classname)) (flags integer))
  (#.(lispify "btSerializer_setSerializationFlags" 'function) (ff-pointer self) flags))



(defmethod initialize-instance :after ((obj #.(lispify "bt-default-serializer" 'class)) &key (totalSize integer))
  (setf (slot-value obj 'ff-pointer) (#.(lispify "new_btDefaultSerializer" 'function) totalSize)))

(defmethod initialize-instance :after ((obj #.(lispify "bt-default-serializer" 'class)) &key)
  (setf (slot-value obj 'ff-pointer) (#.(lispify "new_btDefaultSerializer" 'function))))

(defmethod #.(lispify "write-header" 'method) ((self #.(lispify "bt-default-serializer" 'classname)) buffer)
  (#.(lispify "btDefaultSerializer_writeHeader" 'function) (ff-pointer self) buffer))

(defmethod #.(lispify "start-serialization" 'method) ((self #.(lispify "bt-default-serializer" 'classname)))
  (#.(lispify "btDefaultSerializer_startSerialization" 'function) (ff-pointer self)))

(defmethod #.(lispify "finish-serialization" 'method) ((self #.(lispify "bt-default-serializer" 'classname)))
  (#.(lispify "btDefaultSerializer_finishSerialization" 'function) (ff-pointer self)))

(defmethod #.(lispify "get-unique-pointer" 'method) ((self #.(lispify "bt-default-serializer" 'classname)) oldPtr)
  (#.(lispify "btDefaultSerializer_getUniquePointer" 'function) (ff-pointer self) oldPtr))

(defmethod #.(lispify "get-buffer-pointer" 'method) ((self #.(lispify "bt-default-serializer" 'classname)))
  (#.(lispify "btDefaultSerializer_getBufferPointer" 'function) (ff-pointer self)))

(defmethod #.(lispify "get-current-buffer-size" 'method) ((self #.(lispify "bt-default-serializer" 'classname)))
  (#.(lispify "btDefaultSerializer_getCurrentBufferSize" 'function) (ff-pointer self)))

(defmethod #.(lispify "finalize-chunk" 'method) ((self #.(lispify "bt-default-serializer" 'classname)) (chunk #.(lispify "bt-chunk" 'classname)) (structType string) (chunkCode integer) oldPtr)
  (#.(lispify "btDefaultSerializer_finalizeChunk" 'function) (ff-pointer self) chunk structType chunkCode oldPtr))

(defmethod #.(lispify "internal-alloc" 'method) ((self #.(lispify "bt-default-serializer" 'classname)) size)
  (#.(lispify "btDefaultSerializer_internalAlloc" 'function) (ff-pointer self) size))

(defmethod #.(lispify "allocate" 'method) ((self #.(lispify "bt-default-serializer" 'classname)) size (numElements integer))
  (#.(lispify "btDefaultSerializer_allocate" 'function) (ff-pointer self) size numElements))

(defmethod #.(lispify "find-name-for-pointer" 'method) ((self #.(lispify "bt-default-serializer" 'classname)) ptr)
  (#.(lispify "btDefaultSerializer_findNameForPointer" 'function) (ff-pointer self) ptr))

(defmethod #.(lispify "register-name-for-pointer" 'method) ((self #.(lispify "bt-default-serializer" 'classname)) ptr (name string))
  (#.(lispify "btDefaultSerializer_registerNameForPointer" 'function) (ff-pointer self) ptr name))

(defmethod #.(lispify "serialize-name" 'method) ((self #.(lispify "bt-default-serializer" 'classname)) (name string))
  (#.(lispify "btDefaultSerializer_serializeName" 'function) (ff-pointer self) name))

(defmethod #.(lispify "get-serialization-flags" 'method) ((self #.(lispify "bt-default-serializer" 'classname)))
  (#.(lispify "btDefaultSerializer_getSerializationFlags" 'function) (ff-pointer self)))

(defmethod #.(lispify "set-serialization-flags" 'method) ((self #.(lispify "bt-default-serializer" 'classname)) (flags integer))
  (#.(lispify "btDefaultSerializer_setSerializationFlags" 'function) (ff-pointer self) flags))



(defmethod #.(lispify "new" 'method) ((self #.(lispify "bt-discrete-dynamics-world" 'classname)) sizeInBytes)
  (#.(lispify "btDiscreteDynamicsWorld_makeCPlusPlusInstance" 'function) (ff-pointer self) sizeInBytes))

(defmethod #.(lispify "delete" 'method) ((self #.(lispify "bt-discrete-dynamics-world" 'classname)) ptr)
  (#.(lispify "btDiscreteDynamicsWorld_deleteCPlusPlusInstance" 'function) (ff-pointer self) ptr))

(defmethod #.(lispify "new" 'method) ((self #.(lispify "bt-discrete-dynamics-world" 'classname)) arg1 ptr)
  (#.(lispify "btDiscreteDynamicsWorld_makeCPlusPlusInstance" 'function) (ff-pointer self) arg1 ptr))

(defmethod #.(lispify "delete" 'method) ((self #.(lispify "bt-discrete-dynamics-world" 'classname)) arg1 arg2)
  (#.(lispify "btDiscreteDynamicsWorld_deleteCPlusPlusInstance" 'function) (ff-pointer self) arg1 arg2))

(shadow "new[]")
(defmethod #.(lispify "new[]" 'method) ((self #.(lispify "bt-discrete-dynamics-world" 'classname)) sizeInBytes)
  (#.(lispify "btDiscreteDynamicsWorld_makeCPlusArray" 'function) (ff-pointer self) sizeInBytes))

(shadow "delete[]")
(defmethod #.(lispify "delete[]" 'method) ((self #.(lispify "bt-discrete-dynamics-world" 'classname)) ptr)
  (#.(lispify "btDiscreteDynamicsWorld_deleteCPlusArray" 'function) (ff-pointer self) ptr))

(shadow "new[]")
(defmethod #.(lispify "new[]" 'method) ((self #.(lispify "bt-discrete-dynamics-world" 'classname)) arg1 ptr)
  (#.(lispify "btDiscreteDynamicsWorld_makeCPlusArray" 'function) (ff-pointer self) arg1 ptr))

(shadow "delete[]")
(defmethod #.(lispify "delete[]" 'method) ((self #.(lispify "bt-discrete-dynamics-world" 'classname)) arg1 arg2)
  (#.(lispify "btDiscreteDynamicsWorld_deleteCPlusArray" 'function) (ff-pointer self) arg1 arg2))

(defmethod initialize-instance :after ((obj #.(lispify "bt-discrete-dynamics-world" 'class)) &key dispatcher pairCache constraintSolver collisionConfiguration)
  (setf (slot-value obj 'ff-pointer) (#.(lispify "new_btDiscreteDynamicsWorld" 'function) dispatcher pairCache constraintSolver collisionConfiguration)))

(defmethod #.(lispify "step-simulation" 'method) ((self #.(lispify "bt-discrete-dynamics-world" 'classname)) (timeStep number) (maxSubSteps integer) (fixedTimeStep number))
  (#.(lispify "btDiscreteDynamicsWorld_stepSimulation" 'function) (ff-pointer self) timeStep maxSubSteps fixedTimeStep))

(defmethod #.(lispify "step-simulation" 'method) ((self #.(lispify "bt-discrete-dynamics-world" 'classname)) (timeStep number) (maxSubSteps integer))
  (#.(lispify "btDiscreteDynamicsWorld_stepSimulation" 'function) (ff-pointer self) timeStep maxSubSteps))

(defmethod #.(lispify "step-simulation" 'method) ((self #.(lispify "bt-discrete-dynamics-world" 'classname)) (timeStep number))
  (#.(lispify "btDiscreteDynamicsWorld_stepSimulation" 'function) (ff-pointer self) timeStep))

(defmethod #.(lispify "synchronize-motion-states" 'method) ((self #.(lispify "bt-discrete-dynamics-world" 'classname)))
  (#.(lispify "btDiscreteDynamicsWorld_synchronizeMotionStates" 'function) (ff-pointer self)))

(defmethod #.(lispify "synchronize-single-motion-state" 'method) ((self #.(lispify "bt-discrete-dynamics-world" 'classname)) body)
  (#.(lispify "btDiscreteDynamicsWorld_synchronizeSingleMotionState" 'function) (ff-pointer self) body))

(defmethod #.(lispify "add-constraint" 'method) ((self #.(lispify "bt-discrete-dynamics-world" 'classname)) constraint (disableCollisionsBetweenLinkedBodies t))
  (#.(lispify "btDiscreteDynamicsWorld_addConstraint" 'function) (ff-pointer self) constraint disableCollisionsBetweenLinkedBodies))

(defmethod #.(lispify "add-constraint" 'method) ((self #.(lispify "bt-discrete-dynamics-world" 'classname)) constraint)
  (#.(lispify "btDiscreteDynamicsWorld_addConstraint" 'function) (ff-pointer self) constraint))

(defmethod #.(lispify "remove-constraint" 'method) ((self #.(lispify "bt-discrete-dynamics-world" 'classname)) constraint)
  (#.(lispify "btDiscreteDynamicsWorld_removeConstraint" 'function) (ff-pointer self) constraint))

(defmethod #.(lispify "add-action" 'method) ((self #.(lispify "bt-discrete-dynamics-world" 'classname)) arg1)
  (#.(lispify "btDiscreteDynamicsWorld_addAction" 'function) (ff-pointer self) arg1))

(defmethod #.(lispify "remove-action" 'method) ((self #.(lispify "bt-discrete-dynamics-world" 'classname)) arg1)
  (#.(lispify "btDiscreteDynamicsWorld_removeAction" 'function) (ff-pointer self) arg1))

(defmethod #.(lispify "get-simulation-island-manager" 'method) ((self #.(lispify "bt-discrete-dynamics-world" 'classname)))
  (#.(lispify "btDiscreteDynamicsWorld_getSimulationIslandManager" 'function) (ff-pointer self)))

(defmethod #.(lispify "get-simulation-island-manager" 'method) ((self #.(lispify "bt-discrete-dynamics-world" 'classname)))
  (#.(lispify "btDiscreteDynamicsWorld_getSimulationIslandManager" 'function) (ff-pointer self)))

(defmethod #.(lispify "get-collision-world" 'method) ((self #.(lispify "bt-discrete-dynamics-world" 'classname)))
  (#.(lispify "btDiscreteDynamicsWorld_getCollisionWorld" 'function) (ff-pointer self)))

(defmethod #.(lispify "set-gravity" 'method) ((self #.(lispify "bt-discrete-dynamics-world" 'classname)) (gravity #.(lispify "bt-vector3" 'classname)))
  (#.(lispify "btDiscreteDynamicsWorld_setGravity" 'function) (ff-pointer self) gravity))

(defmethod #.(lispify "get-gravity" 'method) ((self #.(lispify "bt-discrete-dynamics-world" 'classname)))
  (#.(lispify "btDiscreteDynamicsWorld_getGravity" 'function) (ff-pointer self)))

(defmethod #.(lispify "add-collision-object" 'method) ((self #.(lispify "bt-discrete-dynamics-world" 'classname)) (collisionObject #.(lispify "bt-collision-object" 'classname)) (collisionFilterGroup integer) (collisionFilterMask integer))
  (#.(lispify "btDiscreteDynamicsWorld_addCollisionObject" 'function) (ff-pointer self) collisionObject collisionFilterGroup collisionFilterMask))

(defmethod #.(lispify "add-collision-object" 'method) ((self #.(lispify "bt-discrete-dynamics-world" 'classname)) (collisionObject #.(lispify "bt-collision-object" 'classname)) (collisionFilterGroup integer))
  (#.(lispify "btDiscreteDynamicsWorld_addCollisionObject" 'function) (ff-pointer self) collisionObject collisionFilterGroup))

(defmethod #.(lispify "add-collision-object" 'method) ((self #.(lispify "bt-discrete-dynamics-world" 'classname)) (collisionObject #.(lispify "bt-collision-object" 'classname)))
  (#.(lispify "btDiscreteDynamicsWorld_addCollisionObject" 'function) (ff-pointer self) collisionObject))

(defmethod #.(lispify "remove-rigid-body" 'method) ((self #.(lispify "bt-discrete-dynamics-world" 'classname)) body)
  (#.(lispify "btDiscreteDynamicsWorld_removeRigidBody" 'function) (ff-pointer self) body))

(defmethod #.(lispify "remove-collision-object" 'method) ((self #.(lispify "bt-discrete-dynamics-world" 'classname)) (collisionObject #.(lispify "bt-collision-object" 'classname)))
  (#.(lispify "btDiscreteDynamicsWorld_removeCollisionObject" 'function) (ff-pointer self) collisionObject))

(defmethod #.(lispify "debug-draw-constraint" 'method) ((self #.(lispify "bt-discrete-dynamics-world" 'classname)) constraint)
  (#.(lispify "btDiscreteDynamicsWorld_debugDrawConstraint" 'function) (ff-pointer self) constraint))

(defmethod #.(lispify "debug-draw-world" 'method) ((self #.(lispify "bt-discrete-dynamics-world" 'classname)))  (#.(lispify "btDiscreteDynamicsWorld_debugDrawWorld" 'function) (ff-pointer self)))

(defmethod #.(lispify "set-constraint-solver" 'method) ((self #.(lispify "bt-discrete-dynamics-world" 'classname)) solver)
  (#.(lispify "btDiscreteDynamicsWorld_setConstraintSolver" 'function) (ff-pointer self) solver))

(defmethod #.(lispify "get-constraint-solver" 'method) ((self #.(lispify "bt-discrete-dynamics-world" 'classname)))
  (#.(lispify "btDiscreteDynamicsWorld_getConstraintSolver" 'function) (ff-pointer self)))

(defmethod #.(lispify "get-num-constraints" 'method) ((self #.(lispify "bt-discrete-dynamics-world" 'classname)))
  (#.(lispify "btDiscreteDynamicsWorld_getNumConstraints" 'function) (ff-pointer self)))

(defmethod #.(lispify "get-constraint" 'method) ((self #.(lispify "bt-discrete-dynamics-world" 'classname)) (index integer))
  (#.(lispify "btDiscreteDynamicsWorld_getConstraint" 'function) (ff-pointer self) index))

(defmethod #.(lispify "get-constraint" 'method) ((self #.(lispify "bt-discrete-dynamics-world" 'classname)) (index integer))
  (#.(lispify "btDiscreteDynamicsWorld_getConstraint" 'function) (ff-pointer self) index))

(defmethod #.(lispify "get-world-type" 'method) ((self #.(lispify "bt-discrete-dynamics-world" 'classname)))
  (#.(lispify "btDiscreteDynamicsWorld_getWorldType" 'function) (ff-pointer self)))

(defmethod #.(lispify "clear-forces" 'method) ((self #.(lispify "bt-discrete-dynamics-world" 'classname)))
  (#.(lispify "btDiscreteDynamicsWorld_clearForces" 'function) (ff-pointer self)))

(defmethod #.(lispify "apply-gravity" 'method) ((self #.(lispify "bt-discrete-dynamics-world" 'classname)))
  (#.(lispify "btDiscreteDynamicsWorld_applyGravity" 'function) (ff-pointer self)))

(defmethod #.(lispify "set-num-tasks" 'method) ((self #.(lispify "bt-discrete-dynamics-world" 'classname)) (numTasks integer))
  (#.(lispify "btDiscreteDynamicsWorld_setNumTasks" 'function) (ff-pointer self) numTasks))

(defmethod #.(lispify "update-vehicles" 'method) ((self #.(lispify "bt-discrete-dynamics-world" 'classname)) (timeStep number))
  (#.(lispify "btDiscreteDynamicsWorld_updateVehicles" 'function) (ff-pointer self) timeStep))

(defmethod #.(lispify "add-vehicle" 'method) ((self #.(lispify "bt-discrete-dynamics-world" 'classname)) vehicle)
  (#.(lispify "btDiscreteDynamicsWorld_addVehicle" 'function) (ff-pointer self) vehicle))

(defmethod #.(lispify "remove-vehicle" 'method) ((self #.(lispify "bt-discrete-dynamics-world" 'classname)) vehicle)
  (#.(lispify "btDiscreteDynamicsWorld_removeVehicle" 'function) (ff-pointer self) vehicle))

(defmethod #.(lispify "add-character" 'method) ((self #.(lispify "bt-discrete-dynamics-world" 'classname)) character)
  (#.(lispify "btDiscreteDynamicsWorld_addCharacter" 'function) (ff-pointer self) character))

(defmethod #.(lispify "remove-character" 'method) ((self #.(lispify "bt-discrete-dynamics-world" 'classname)) character)
  (#.(lispify "btDiscreteDynamicsWorld_removeCharacter" 'function) (ff-pointer self) character))

(defmethod #.(lispify "set-synchronize-all-motion-states" 'method) ((self #.(lispify "bt-discrete-dynamics-world" 'classname)) (synchronizeAll t))
  (#.(lispify "btDiscreteDynamicsWorld_setSynchronizeAllMotionStates" 'function) (ff-pointer self) synchronizeAll))

(defmethod #.(lispify "get-synchronize-all-motion-states" 'method) ((self #.(lispify "bt-discrete-dynamics-world" 'classname)))
  (#.(lispify "btDiscreteDynamicsWorld_getSynchronizeAllMotionStates" 'function) (ff-pointer self)))

(defmethod #.(lispify "set-apply-speculative-contact-restitution" 'method) ((self #.(lispify "bt-discrete-dynamics-world" 'classname)) (enable t))
  (#.(lispify "btDiscreteDynamicsWorld_setApplySpeculativeContactRestitution" 'function) (ff-pointer self) enable))

(defmethod #.(lispify "get-apply-speculative-contact-restitution" 'method) ((self #.(lispify "bt-discrete-dynamics-world" 'classname)))
  (#.(lispify "btDiscreteDynamicsWorld_getApplySpeculativeContactRestitution" 'function) (ff-pointer self)))

(defmethod #.(lispify "serialize" 'method) ((self #.(lispify "bt-discrete-dynamics-world" 'classname)) (serializer #.(lispify "bt-serializer" 'classname)))
  (#.(lispify "btDiscreteDynamicsWorld_serialize" 'function) (ff-pointer self) serializer))

(defmethod #.(lispify "set-latency-motion-state-interpolation" 'method) ((self #.(lispify "bt-discrete-dynamics-world" 'classname)) (latencyInterpolation t))
  (#.(lispify "btDiscreteDynamicsWorld_setLatencyMotionStateInterpolation" 'function) (ff-pointer self) latencyInterpolation))

(defmethod #.(lispify "get-latency-motion-state-interpolation" 'method) ((self #.(lispify "bt-discrete-dynamics-world" 'classname)))
  (#.(lispify "btDiscreteDynamicsWorld_getLatencyMotionStateInterpolation" 'function) (ff-pointer self)))



(defmethod initialize-instance :after ((obj #.(lispify "bt-simple-dynamics-world" 'class)) &key dispatcher pairCache constraintSolver collisionConfiguration)
  (setf (slot-value obj 'ff-pointer) (#.(lispify "new_btSimpleDynamicsWorld" 'function) dispatcher pairCache constraintSolver collisionConfiguration)))

(defmethod #.(lispify "step-simulation" 'method) ((self #.(lispify "bt-simple-dynamics-world" 'classname)) (timeStep number) (maxSubSteps integer) (fixedTimeStep number))
  (#.(lispify "btSimpleDynamicsWorld_stepSimulation" 'function) (ff-pointer self) timeStep maxSubSteps fixedTimeStep))

(defmethod #.(lispify "step-simulation" 'method) ((self #.(lispify "bt-simple-dynamics-world" 'classname)) (timeStep number) (maxSubSteps integer))
  (#.(lispify "btSimpleDynamicsWorld_stepSimulation" 'function) (ff-pointer self) timeStep maxSubSteps))

(defmethod #.(lispify "step-simulation" 'method) ((self #.(lispify "bt-simple-dynamics-world" 'classname)) (timeStep number))
  (#.(lispify "btSimpleDynamicsWorld_stepSimulation" 'function) (ff-pointer self) timeStep))

(defmethod #.(lispify "set-gravity" 'method) ((self #.(lispify "bt-simple-dynamics-world" 'classname)) (gravity #.(lispify "bt-vector3" 'classname)))
  (#.(lispify "btSimpleDynamicsWorld_setGravity" 'function) (ff-pointer self) gravity))

(defmethod #.(lispify "get-gravity" 'method) ((self #.(lispify "bt-simple-dynamics-world" 'classname)))
  (#.(lispify "btSimpleDynamicsWorld_getGravity" 'function) (ff-pointer self)))

(defmethod #.(lispify "add-rigid-body" 'method) ((self #.(lispify "bt-simple-dynamics-world" 'classname)) body)
  (#.(lispify "btSimpleDynamicsWorld_addRigidBody" 'function) (ff-pointer self) body))

(defmethod #.(lispify "add-rigid-body" 'method) ((self #.(lispify "bt-simple-dynamics-world" 'classname)) body (group integer) (mask integer))
  (#.(lispify "btSimpleDynamicsWorld_addRigidBody" 'function) (ff-pointer self) body group mask))

(defmethod #.(lispify "remove-rigid-body" 'method) ((self #.(lispify "bt-simple-dynamics-world" 'classname)) body)
  (#.(lispify "btSimpleDynamicsWorld_removeRigidBody" 'function) (ff-pointer self) body))

(defmethod #.(lispify "debug-draw-world" 'method) ((self #.(lispify "bt-simple-dynamics-world" 'classname)))
  (#.(lispify "btSimpleDynamicsWorld_debugDrawWorld" 'function) (ff-pointer self)))

(defmethod #.(lispify "add-action" 'method) ((self #.(lispify "bt-simple-dynamics-world" 'classname)) action)
  (#.(lispify "btSimpleDynamicsWorld_addAction" 'function) (ff-pointer self) action))

(defmethod #.(lispify "remove-action" 'method) ((self #.(lispify "bt-simple-dynamics-world" 'classname)) action)
  (#.(lispify "btSimpleDynamicsWorld_removeAction" 'function) (ff-pointer self) action))

(defmethod #.(lispify "remove-collision-object" 'method) ((self #.(lispify "bt-simple-dynamics-world" 'classname)) (collisionObject #.(lispify "bt-collision-object" 'classname)))
  (#.(lispify "btSimpleDynamicsWorld_removeCollisionObject" 'function) (ff-pointer self) collisionObject))

(defmethod #.(lispify "update-aabbs" 'method) ((self #.(lispify "bt-simple-dynamics-world" 'classname)))
  (#.(lispify "btSimpleDynamicsWorld_updateAabbs" 'function) (ff-pointer self)))

(defmethod #.(lispify "synchronize-motion-states" 'method) ((self #.(lispify "bt-simple-dynamics-world" 'classname)))
  (#.(lispify "btSimpleDynamicsWorld_synchronizeMotionStates" 'function) (ff-pointer self)))

(defmethod #.(lispify "set-constraint-solver" 'method) ((self #.(lispify "bt-simple-dynamics-world" 'classname)) solver)
  (#.(lispify "btSimpleDynamicsWorld_setConstraintSolver" 'function) (ff-pointer self) solver))

(defmethod #.(lispify "get-constraint-solver" 'method) ((self #.(lispify "bt-simple-dynamics-world" 'classname)))
  (#.(lispify "btSimpleDynamicsWorld_getConstraintSolver" 'function) (ff-pointer self)))

(defmethod #.(lispify "get-world-type" 'method) ((self #.(lispify "bt-simple-dynamics-world" 'classname)))
  (#.(lispify "btSimpleDynamicsWorld_getWorldType" 'function) (ff-pointer self)))

(defmethod #.(lispify "clear-forces" 'method) ((self #.(lispify "bt-simple-dynamics-world" 'classname)))
  (#.(lispify "btSimpleDynamicsWorld_clearForces" 'function) (ff-pointer self)))



(defmethod initialize-instance :after ((obj #.(lispify "bt-rigid-body" 'class)) &key constructionInfo)
  (setf (slot-value obj 'ff-pointer) (#.(lispify "new_btRigidBody" 'function) constructionInfo)))

(defmethod initialize-instance :after ((obj #.(lispify "bt-rigid-body" 'class)) &key (mass number) (motionState #.(lispify "bt-motion-state" 'classname)) collisionShape (localInertia #.(lispify "bt-vector3" 'classname)))
  (setf (slot-value obj 'ff-pointer) (#.(lispify "new_btRigidBody" 'function) mass motionState collisionShape localInertia)))

(defmethod initialize-instance :after ((obj #.(lispify "bt-rigid-body" 'class)) &key (mass number) (motionState #.(lispify "bt-motion-state" 'classname)) collisionShape)
  (setf (slot-value obj 'ff-pointer) (#.(lispify "new_btRigidBody" 'function) mass motionState collisionShape)))

(defmethod #.(lispify "proceed-to-transform" 'method) ((self #.(lispify "bt-rigid-body" 'classname)) (newTrans #.(lispify "bt-transform" 'classname)))
  (#.(lispify "btRigidBody_proceedToTransform" 'function) (ff-pointer self) newTrans))

(defmethod #.(lispify "predict-integrated-transform" 'method) ((self #.(lispify "bt-rigid-body" 'classname)) (step number) (predictedTransform #.(lispify "bt-transform" 'classname)))
  (#.(lispify "btRigidBody_predictIntegratedTransform" 'function) (ff-pointer self) step predictedTransform))

(defmethod #.(lispify "save-kinematic-state" 'method) ((self #.(lispify "bt-rigid-body" 'classname)) (step number))
  (#.(lispify "btRigidBody_saveKinematicState" 'function) (ff-pointer self) step))

(defmethod #.(lispify "apply-gravity" 'method) ((self #.(lispify "bt-rigid-body" 'classname)))
  (#.(lispify "btRigidBody_applyGravity" 'function) (ff-pointer self)))

(defmethod #.(lispify "set-gravity" 'method) ((self #.(lispify "bt-rigid-body" 'classname)) (acceleration #.(lispify "bt-vector3" 'classname)))
  (#.(lispify "btRigidBody_setGravity" 'function) (ff-pointer self) acceleration))

(defmethod #.(lispify "get-gravity" 'method) ((self #.(lispify "bt-rigid-body" 'classname)))
  (#.(lispify "btRigidBody_getGravity" 'function) (ff-pointer self)))

(defmethod #.(lispify "set-damping" 'method) ((self #.(lispify "bt-rigid-body" 'classname)) (lin_damping number) (ang_damping number))
  (#.(lispify "btRigidBody_setDamping" 'function) (ff-pointer self) lin_damping ang_damping))

(defmethod #.(lispify "get-linear-damping" 'method) ((self #.(lispify "bt-rigid-body" 'classname)))
  (#.(lispify "btRigidBody_getLinearDamping" 'function) (ff-pointer self)))

(defmethod #.(lispify "get-angular-damping" 'method) ((self #.(lispify "bt-rigid-body" 'classname)))
  (#.(lispify "btRigidBody_getAngularDamping" 'function) (ff-pointer self)))

(defmethod #.(lispify "get-linear-sleeping-threshold" 'method) ((self #.(lispify "bt-rigid-body" 'classname)))
  (#.(lispify "btRigidBody_getLinearSleepingThreshold" 'function) (ff-pointer self)))

(defmethod #.(lispify "get-angular-sleeping-threshold" 'method) ((self #.(lispify "bt-rigid-body" 'classname)))
  (#.(lispify "btRigidBody_getAngularSleepingThreshold" 'function) (ff-pointer self)))

(defmethod #.(lispify "apply-damping" 'method) ((self #.(lispify "bt-rigid-body" 'classname)) (timeStep number))
  (#.(lispify "btRigidBody_applyDamping" 'function) (ff-pointer self) timeStep))

(defmethod #.(lispify "get-collision-shape" 'method) ((self #.(lispify "bt-rigid-body" 'classname)))
  (#.(lispify "btRigidBody_getCollisionShape" 'function) (ff-pointer self)))

(defmethod #.(lispify "get-collision-shape" 'method) ((self #.(lispify "bt-rigid-body" 'classname)))
  (#.(lispify "btRigidBody_getCollisionShape" 'function) (ff-pointer self)))

(defmethod #.(lispify "set-mass-props" 'method) ((self #.(lispify "bt-rigid-body" 'classname)) (mass number) (inertia #.(lispify "bt-vector3" 'classname)))
  (#.(lispify "btRigidBody_setMassProps" 'function) (ff-pointer self) mass inertia))

(defmethod #.(lispify "get-linear-factor" 'method) ((self #.(lispify "bt-rigid-body" 'classname)))
  (#.(lispify "btRigidBody_getLinearFactor" 'function) (ff-pointer self)))

(defmethod #.(lispify "set-linear-factor" 'method) ((self #.(lispify "bt-rigid-body" 'classname)) (linearFactor #.(lispify "bt-vector3" 'classname)))
  (#.(lispify "btRigidBody_setLinearFactor" 'function) (ff-pointer self) linearFactor))

(defmethod #.(lispify "get-inv-mass" 'method) ((self #.(lispify "bt-rigid-body" 'classname)))
  (#.(lispify "btRigidBody_getInvMass" 'function) (ff-pointer self)))

(defmethod #.(lispify "get-inv-inertia-tensor-world" 'method) ((self #.(lispify "bt-rigid-body" 'classname)))
  (#.(lispify "btRigidBody_getInvInertiaTensorWorld" 'function) (ff-pointer self)))

(defmethod #.(lispify "integrate-velocities" 'method) ((self #.(lispify "bt-rigid-body" 'classname)) (step number))
  (#.(lispify "btRigidBody_integrateVelocities" 'function) (ff-pointer self) step))

(defmethod #.(lispify "set-center-of-mass-transform" 'method) ((self #.(lispify "bt-rigid-body" 'classname)) (xform #.(lispify "bt-transform" 'classname)))
  (#.(lispify "btRigidBody_setCenterOfMassTransform" 'function) (ff-pointer self) xform))

(defmethod #.(lispify "apply-central-force" 'method) ((self #.(lispify "bt-rigid-body" 'classname)) (force #.(lispify "bt-vector3" 'classname)))
  (#.(lispify "btRigidBody_applyCentralForce" 'function) (ff-pointer self) force))

(defmethod #.(lispify "get-total-force" 'method) ((self #.(lispify "bt-rigid-body" 'classname)))
  (#.(lispify "btRigidBody_getTotalForce" 'function) (ff-pointer self)))

(defmethod #.(lispify "get-total-torque" 'method) ((self #.(lispify "bt-rigid-body" 'classname)))
  (#.(lispify "btRigidBody_getTotalTorque" 'function) (ff-pointer self)))

(defmethod #.(lispify "get-inv-inertia-diag-local" 'method) ((self #.(lispify "bt-rigid-body" 'classname)))
  (#.(lispify "btRigidBody_getInvInertiaDiagLocal" 'function) (ff-pointer self)))

(defmethod #.(lispify "set-inv-inertia-diag-local" 'method) ((self #.(lispify "bt-rigid-body" 'classname)) (diagInvInertia #.(lispify "bt-vector3" 'classname)))
  (#.(lispify "btRigidBody_setInvInertiaDiagLocal" 'function) (ff-pointer self) diagInvInertia))

(defmethod #.(lispify "set-sleeping-thresholds" 'method) ((self #.(lispify "bt-rigid-body" 'classname)) (linear number) (angular number))
  (#.(lispify "btRigidBody_setSleepingThresholds" 'function) (ff-pointer self) linear angular))

(defmethod #.(lispify "apply-torque" 'method) ((self #.(lispify "bt-rigid-body" 'classname)) (torque #.(lispify "bt-vector3" 'classname)))
  (#.(lispify "btRigidBody_applyTorque" 'function) (ff-pointer self) torque))

(defmethod #.(lispify "apply-force" 'method) ((self #.(lispify "bt-rigid-body" 'classname)) (force #.(lispify "bt-vector3" 'classname)) (rel_pos #.(lispify "bt-vector3" 'classname)))
  (#.(lispify "btRigidBody_applyForce" 'function) (ff-pointer self) force rel_pos))

(defmethod #.(lispify "apply-central-impulse" 'method) ((self #.(lispify "bt-rigid-body" 'classname)) (impulse #.(lispify "bt-vector3" 'classname)))
  (#.(lispify "btRigidBody_applyCentralImpulse" 'function) (ff-pointer self) impulse))

(defmethod #.(lispify "apply-torque-impulse" 'method) ((self #.(lispify "bt-rigid-body" 'classname)) (torque #.(lispify "bt-vector3" 'classname)))
  (#.(lispify "btRigidBody_applyTorqueImpulse" 'function) (ff-pointer self) torque))

(defmethod #.(lispify "apply-impulse" 'method) ((self #.(lispify "bt-rigid-body" 'classname)) (impulse #.(lispify "bt-vector3" 'classname)) (rel_pos #.(lispify "bt-vector3" 'classname)))
  (#.(lispify "btRigidBody_applyImpulse" 'function) (ff-pointer self) impulse rel_pos))

(defmethod #.(lispify "clear-forces" 'method) ((self #.(lispify "bt-rigid-body" 'classname)))
  (#.(lispify "btRigidBody_clearForces" 'function) (ff-pointer self)))

(defmethod #.(lispify "update-inertia-tensor" 'method) ((self #.(lispify "bt-rigid-body" 'classname)))
  (#.(lispify "btRigidBody_updateInertiaTensor" 'function) (ff-pointer self)))

(defmethod #.(lispify "get-center-of-mass-position" 'method) ((self #.(lispify "bt-rigid-body" 'classname)))
  (#.(lispify "btRigidBody_getCenterOfMassPosition" 'function) (ff-pointer self)))

(defmethod #.(lispify "get-orientation" 'method) ((self #.(lispify "bt-rigid-body" 'classname)))
  (#.(lispify "btRigidBody_getOrientation" 'function) (ff-pointer self)))

(defmethod #.(lispify "get-center-of-mass-transform" 'method) ((self #.(lispify "bt-rigid-body" 'classname)))
  (#.(lispify "btRigidBody_getCenterOfMassTransform" 'function) (ff-pointer self)))

(defmethod #.(lispify "get-linear-velocity" 'method) ((self #.(lispify "bt-rigid-body" 'classname)))
  (#.(lispify "btRigidBody_getLinearVelocity" 'function) (ff-pointer self)))

(defmethod #.(lispify "get-angular-velocity" 'method) ((self #.(lispify "bt-rigid-body" 'classname)))
  (#.(lispify "btRigidBody_getAngularVelocity" 'function) (ff-pointer self)))

(defmethod #.(lispify "set-linear-velocity" 'method) ((self #.(lispify "bt-rigid-body" 'classname)) (lin_vel #.(lispify "bt-vector3" 'classname)))
  (#.(lispify "btRigidBody_setLinearVelocity" 'function) (ff-pointer self) lin_vel))

(defmethod #.(lispify "set-angular-velocity" 'method) ((self #.(lispify "bt-rigid-body" 'classname)) (ang_vel #.(lispify "bt-vector3" 'classname)))
  (#.(lispify "btRigidBody_setAngularVelocity" 'function) (ff-pointer self) ang_vel))

(defmethod #.(lispify "get-velocity-in-local-point" 'method) ((self #.(lispify "bt-rigid-body" 'classname)) (rel_pos #.(lispify "bt-vector3" 'classname)))
  (#.(lispify "btRigidBody_getVelocityInLocalPoint" 'function) (ff-pointer self) rel_pos))

(defmethod #.(lispify "translate" 'method) ((self #.(lispify "bt-rigid-body" 'classname)) (v #.(lispify "bt-vector3" 'classname)))
  (#.(lispify "btRigidBody_translate" 'function) (ff-pointer self) v))

(defmethod #.(lispify "get-aabb" 'method) ((self #.(lispify "bt-rigid-body" 'classname)) (aabbMin #.(lispify "bt-vector3" 'classname)) (aabbMax #.(lispify "bt-vector3" 'classname)))
  (#.(lispify "btRigidBody_getAabb" 'function) (ff-pointer self) aabbMin aabbMax))

(defmethod #.(lispify "compute-impulse-denominator" 'method) ((self #.(lispify "bt-rigid-body" 'classname)) (pos #.(lispify "bt-vector3" 'classname)) (normal #.(lispify "bt-vector3" 'classname)))
  (#.(lispify "btRigidBody_computeImpulseDenominator" 'function) (ff-pointer self) pos normal))

(defmethod #.(lispify "compute-angular-impulse-denominator" 'method) ((self #.(lispify "bt-rigid-body" 'classname)) (axis #.(lispify "bt-vector3" 'classname)))
  (#.(lispify "btRigidBody_computeAngularImpulseDenominator" 'function) (ff-pointer self) axis))

(defmethod #.(lispify "update-deactivation" 'method) ((self #.(lispify "bt-rigid-body" 'classname)) (timeStep number))
  (#.(lispify "btRigidBody_updateDeactivation" 'function) (ff-pointer self) timeStep))

(defmethod #.(lispify "wants-sleeping" 'method) ((self #.(lispify "bt-rigid-body" 'classname)))
  (#.(lispify "btRigidBody_wantsSleeping" 'function) (ff-pointer self)))

(defmethod #.(lispify "get-broadphase-proxy" 'method) ((self #.(lispify "bt-rigid-body" 'classname)))
  (#.(lispify "btRigidBody_getBroadphaseProxy" 'function) (ff-pointer self)))

(defmethod #.(lispify "get-broadphase-proxy" 'method) ((self #.(lispify "bt-rigid-body" 'classname)))
  (#.(lispify "btRigidBody_getBroadphaseProxy" 'function) (ff-pointer self)))

(defmethod #.(lispify "set-new-broadphase-proxy" 'method) ((self #.(lispify "bt-rigid-body" 'classname)) broadphaseProxy)
  (#.(lispify "btRigidBody_setNewBroadphaseProxy" 'function) (ff-pointer self) broadphaseProxy))

(defmethod #.(lispify "get-motion-state" 'method) ((self #.(lispify "bt-rigid-body" 'classname)))
  (#.(lispify "btRigidBody_getMotionState" 'function) (ff-pointer self)))

(defmethod #.(lispify "get-motion-state" 'method) ((self #.(lispify "bt-rigid-body" 'classname)))
  (#.(lispify "btRigidBody_getMotionState" 'function) (ff-pointer self)))

(defmethod #.(lispify "set-motion-state" 'method) ((self #.(lispify "bt-rigid-body" 'classname)) (motionState #.(lispify "bt-motion-state" 'classname)))
  (#.(lispify "btRigidBody_setMotionState" 'function) (ff-pointer self) motionState))

(defmethod (setf #.(lispify "m_contactSolverType" 'method)) (arg0 (obj #.(lispify "bt-rigid-body" 'class)))
  (#.(lispify "btRigidBody_m_contactSolverType_set" 'function) (ff-pointer obj) arg0))

(defmethod #.(lispify "m_contactSolverType" 'method) ((obj #.(lispify "bt-rigid-body" 'class)))
  (#.(lispify "btRigidBody_m_contactSolverType_get" 'function) (ff-pointer obj)))

(defmethod (setf #.(lispify "m_frictionSolverType" 'method)) (arg0 (obj #.(lispify "bt-rigid-body" 'class)))
  (#.(lispify "btRigidBody_m_frictionSolverType_set" 'function) (ff-pointer obj) arg0))

(defmethod #.(lispify "m_frictionSolverType" 'method) ((obj #.(lispify "bt-rigid-body" 'class)))
  (#.(lispify "btRigidBody_m_frictionSolverType_get" 'function) (ff-pointer obj)))

(defmethod #.(lispify "set-angular-factor" 'method) ((self #.(lispify "bt-rigid-body" 'classname)) (angFac #.(lispify "bt-vector3" 'classname)))
  (#.(lispify "btRigidBody_setAngularFactor" 'function) (ff-pointer self) angFac))

(defmethod #.(lispify "set-angular-factor" 'method) ((self #.(lispify "bt-rigid-body" 'classname)) (angFac number))
  (#.(lispify "btRigidBody_setAngularFactor" 'function) (ff-pointer self) angFac))

(defmethod #.(lispify "get-angular-factor" 'method) ((self #.(lispify "bt-rigid-body" 'classname)))
  (#.(lispify "btRigidBody_getAngularFactor" 'function) (ff-pointer self)))

(defmethod #.(lispify "is-in-world" 'method) ((self #.(lispify "bt-rigid-body" 'classname)))
  (#.(lispify "btRigidBody_isInWorld" 'function) (ff-pointer self)))

(defmethod #.(lispify "check-collide-with-override" 'method) ((self #.(lispify "bt-rigid-body" 'classname)) (co #.(lispify "bt-collision-object" 'classname)))
  (#.(lispify "btRigidBody_checkCollideWithOverride" 'function) (ff-pointer self) co))

(defmethod #.(lispify "add-constraint-ref" 'method) ((self #.(lispify "bt-rigid-body" 'classname)) c)
  (#.(lispify "btRigidBody_addConstraintRef" 'function) (ff-pointer self) c))

(defmethod #.(lispify "remove-constraint-ref" 'method) ((self #.(lispify "bt-rigid-body" 'classname)) c)
  (#.(lispify "btRigidBody_removeConstraintRef" 'function) (ff-pointer self) c))

(defmethod #.(lispify "get-constraint-ref" 'method) ((self #.(lispify "bt-rigid-body" 'classname)) (index integer))
  (#.(lispify "btRigidBody_getConstraintRef" 'function) (ff-pointer self) index))

(defmethod #.(lispify "get-num-constraint-refs" 'method) ((self #.(lispify "bt-rigid-body" 'classname)))
  (#.(lispify "btRigidBody_getNumConstraintRefs" 'function) (ff-pointer self)))

(defmethod #.(lispify "set-flags" 'method) ((self #.(lispify "bt-rigid-body" 'classname)) (flags integer))
  (#.(lispify "btRigidBody_setFlags" 'function) (ff-pointer self) flags))

(defmethod #.(lispify "get-flags" 'method) ((self #.(lispify "bt-rigid-body" 'classname)))
  (#.(lispify "btRigidBody_getFlags" 'function) (ff-pointer self)))

(defmethod #.(lispify "compute-gyroscopic-force" 'method) ((self #.(lispify "bt-rigid-body" 'classname)) (maxGyroscopicForce number))
  (#.(lispify "btRigidBody_computeGyroscopicForce" 'function) (ff-pointer self) maxGyroscopicForce))

(defmethod #.(lispify "calculate-serialize-buffer-size" 'method) ((self #.(lispify "bt-rigid-body" 'classname)))
  (#.(lispify "btRigidBody_calculateSerializeBufferSize" 'function) (ff-pointer self)))

(defmethod #.(lispify "serialize" 'method) ((self #.(lispify "bt-rigid-body" 'classname)) dataBuffer (serializer #.(lispify "bt-serializer" 'classname)))
  (#.(lispify "btRigidBody_serialize" 'function) (ff-pointer self) dataBuffer serializer))

(defmethod #.(lispify "serialize-single-object" 'method) ((self #.(lispify "bt-rigid-body" 'classname)) (serializer #.(lispify "bt-serializer" 'classname)))
  (#.(lispify "btRigidBody_serializeSingleObject" 'function) (ff-pointer self) serializer))



(defmethod #.(lispify "new" 'method) ((self #.(lispify "bt-typed-constraint" 'classname)) sizeInBytes)
  (#.(lispify "btTypedConstraint_makeCPlusPlusInstance" 'function) (ff-pointer self) sizeInBytes))

(defmethod #.(lispify "delete" 'method) ((self #.(lispify "bt-typed-constraint" 'classname)) ptr)
  (#.(lispify "btTypedConstraint_deleteCPlusPlusInstance" 'function) (ff-pointer self) ptr))

(defmethod #.(lispify "new" 'method) ((self #.(lispify "bt-typed-constraint" 'classname)) arg1 ptr)
  (#.(lispify "btTypedConstraint_makeCPlusPlusInstance" 'function) (ff-pointer self) arg1 ptr))

(defmethod #.(lispify "delete" 'method) ((self #.(lispify "bt-typed-constraint" 'classname)) arg1 arg2)
  (#.(lispify "btTypedConstraint_deleteCPlusPlusInstance" 'function) (ff-pointer self) arg1 arg2))

(shadow "new[]")
(defmethod #.(lispify "new[]" 'method) ((self #.(lispify "bt-typed-constraint" 'classname)) sizeInBytes)
  (#.(lispify "btTypedConstraint_makeCPlusArray" 'function) (ff-pointer self) sizeInBytes))

(shadow "delete[]")
(defmethod #.(lispify "delete[]" 'method) ((self #.(lispify "bt-typed-constraint" 'classname)) ptr)
  (#.(lispify "btTypedConstraint_deleteCPlusArray" 'function) (ff-pointer self) ptr))

(shadow "new[]")
(defmethod #.(lispify "new[]" 'method) ((self #.(lispify "bt-typed-constraint" 'classname)) arg1 ptr)
  (#.(lispify "btTypedConstraint_makeCPlusArray" 'function) (ff-pointer self) arg1 ptr))

(shadow "delete[]")
(defmethod #.(lispify "delete[]" 'method) ((self #.(lispify "bt-typed-constraint" 'classname)) arg1 arg2)
  (#.(lispify "btTypedConstraint_deleteCPlusArray" 'function) (ff-pointer self) arg1 arg2))

(defmethod #.(lispify "get-override-num-solver-iterations" 'method) ((self #.(lispify "bt-typed-constraint" 'classname)))
  (#.(lispify "btTypedConstraint_getOverrideNumSolverIterations" 'function) (ff-pointer self)))

(defmethod #.(lispify "set-override-num-solver-iterations" 'method) ((self #.(lispify "bt-typed-constraint" 'classname)) (overideNumIterations integer))
  (#.(lispify "btTypedConstraint_setOverrideNumSolverIterations" 'function) (ff-pointer self) overideNumIterations))

(defmethod #.(lispify "build-jacobian" 'method) ((self #.(lispify "bt-typed-constraint" 'classname)))
  (#.(lispify "btTypedConstraint_buildJacobian" 'function) (ff-pointer self)))

(defmethod #.(lispify "setup-solver-constraint" 'method) ((self #.(lispify "bt-typed-constraint" 'classname)) ca (solverBodyA integer) (solverBodyB integer) (timeStep number))
  (#.(lispify "btTypedConstraint_setupSolverConstraint" 'function) (ff-pointer self) ca solverBodyA solverBodyB timeStep))

(defmethod #.(lispify "get-info1" 'method) ((self #.(lispify "bt-typed-constraint" 'classname)) info)
  (#.(lispify "btTypedConstraint_getInfo1" 'function) (ff-pointer self) info))

(defmethod #.(lispify "get-info2" 'method) ((self #.(lispify "bt-typed-constraint" 'classname)) info)
  (#.(lispify "btTypedConstraint_getInfo2" 'function) (ff-pointer self) info))

(defmethod #.(lispify "internal-set-applied-impulse" 'method) ((self #.(lispify "bt-typed-constraint" 'classname)) (appliedImpulse number))
  (#.(lispify "btTypedConstraint_internalSetAppliedImpulse" 'function) (ff-pointer self) appliedImpulse))

(defmethod #.(lispify "internal-get-applied-impulse" 'method) ((self #.(lispify "bt-typed-constraint" 'classname)))
  (#.(lispify "btTypedConstraint_internalGetAppliedImpulse" 'function) (ff-pointer self)))

(defmethod #.(lispify "get-breaking-impulse-threshold" 'method) ((self #.(lispify "bt-typed-constraint" 'classname)))
  (#.(lispify "btTypedConstraint_getBreakingImpulseThreshold" 'function) (ff-pointer self)))

(defmethod #.(lispify "set-breaking-impulse-threshold" 'method) ((self #.(lispify "bt-typed-constraint" 'classname)) (threshold number))
  (#.(lispify "btTypedConstraint_setBreakingImpulseThreshold" 'function) (ff-pointer self) threshold))

(defmethod #.(lispify "is-enabled" 'method) ((self #.(lispify "bt-typed-constraint" 'classname)))
  (#.(lispify "btTypedConstraint_isEnabled" 'function) (ff-pointer self)))

(defmethod #.(lispify "set-enabled" 'method) ((self #.(lispify "bt-typed-constraint" 'classname)) (enabled t))
  (#.(lispify "btTypedConstraint_setEnabled" 'function) (ff-pointer self) enabled))

(defmethod #.(lispify "solve-constraint-obsolete" 'method) ((self #.(lispify "bt-typed-constraint" 'classname)) arg1 arg2 (arg3 number))
  (#.(lispify "btTypedConstraint_solveConstraintObsolete" 'function) (ff-pointer self) arg1 arg2 arg3))

(defmethod #.(lispify "get-rigid-body-a" 'method) ((self #.(lispify "bt-typed-constraint" 'classname)))
  (#.(lispify "btTypedConstraint_getRigidBodyA" 'function) (ff-pointer self)))

(defmethod #.(lispify "get-rigid-body-b" 'method) ((self #.(lispify "bt-typed-constraint" 'classname)))
  (#.(lispify "btTypedConstraint_getRigidBodyB" 'function) (ff-pointer self)))

(defmethod #.(lispify "get-rigid-body-a" 'method) ((self #.(lispify "bt-typed-constraint" 'classname)))
  (#.(lispify "btTypedConstraint_getRigidBodyA" 'function) (ff-pointer self)))

(defmethod #.(lispify "get-rigid-body-b" 'method) ((self #.(lispify "bt-typed-constraint" 'classname)))
  (#.(lispify "btTypedConstraint_getRigidBodyB" 'function) (ff-pointer self)))

(defmethod #.(lispify "get-user-constraint-type" 'method) ((self #.(lispify "bt-typed-constraint" 'classname)))
  (#.(lispify "btTypedConstraint_getUserConstraintType" 'function) (ff-pointer self)))

(defmethod #.(lispify "set-user-constraint-type" 'method) ((self #.(lispify "bt-typed-constraint" 'classname)) (userConstraintType integer))
  (#.(lispify "btTypedConstraint_setUserConstraintType" 'function) (ff-pointer self) userConstraintType))

(defmethod #.(lispify "set-user-constraint-id" 'method) ((self #.(lispify "bt-typed-constraint" 'classname)) (uid integer))
  (#.(lispify "btTypedConstraint_setUserConstraintId" 'function) (ff-pointer self) uid))

(defmethod #.(lispify "get-user-constraint-id" 'method) ((self #.(lispify "bt-typed-constraint" 'classname)))
  (#.(lispify "btTypedConstraint_getUserConstraintId" 'function) (ff-pointer self)))

(defmethod #.(lispify "set-user-constraint-ptr" 'method) ((self #.(lispify "bt-typed-constraint" 'classname)) ptr)
  (#.(lispify "btTypedConstraint_setUserConstraintPtr" 'function) (ff-pointer self) ptr))

(defmethod #.(lispify "get-user-constraint-ptr" 'method) ((self #.(lispify "bt-typed-constraint" 'classname)))
  (#.(lispify "btTypedConstraint_getUserConstraintPtr" 'function) (ff-pointer self)))

(defmethod #.(lispify "set-joint-feedback" 'method) ((self #.(lispify "bt-typed-constraint" 'classname)) jointFeedback)
  (#.(lispify "btTypedConstraint_setJointFeedback" 'function) (ff-pointer self) jointFeedback))

(defmethod #.(lispify "get-joint-feedback" 'method) ((self #.(lispify "bt-typed-constraint" 'classname)))
  (#.(lispify "btTypedConstraint_getJointFeedback" 'function) (ff-pointer self)))

(defmethod #.(lispify "get-joint-feedback" 'method) ((self #.(lispify "bt-typed-constraint" 'classname)))
  (#.(lispify "btTypedConstraint_getJointFeedback" 'function) (ff-pointer self)))

(defmethod #.(lispify "get-uid" 'method) ((self #.(lispify "bt-typed-constraint" 'classname)))
  (#.(lispify "btTypedConstraint_getUid" 'function) (ff-pointer self)))

(defmethod #.(lispify "needs-feedback" 'method) ((self #.(lispify "bt-typed-constraint" 'classname)))
  (#.(lispify "btTypedConstraint_needsFeedback" 'function) (ff-pointer self)))

(defmethod #.(lispify "enable-feedback" 'method) ((self #.(lispify "bt-typed-constraint" 'classname)) (needsFeedback t))
  (#.(lispify "btTypedConstraint_enableFeedback" 'function) (ff-pointer self) needsFeedback))

(defmethod #.(lispify "get-applied-impulse" 'method) ((self #.(lispify "bt-typed-constraint" 'classname)))
  (#.(lispify "btTypedConstraint_getAppliedImpulse" 'function) (ff-pointer self)))

(defmethod #.(lispify "get-constraint-type" 'method) ((self #.(lispify "bt-typed-constraint" 'classname)))
  (#.(lispify "btTypedConstraint_getConstraintType" 'function) (ff-pointer self)))

(defmethod #.(lispify "set-dbg-draw-size" 'method) ((self #.(lispify "bt-typed-constraint" 'classname)) (dbgDrawSize number))
  (#.(lispify "btTypedConstraint_setDbgDrawSize" 'function) (ff-pointer self) dbgDrawSize))

(defmethod #.(lispify "get-dbg-draw-size" 'method) ((self #.(lispify "bt-typed-constraint" 'classname)))
  (#.(lispify "btTypedConstraint_getDbgDrawSize" 'function) (ff-pointer self)))

(defmethod #.(lispify "calculate-serialize-buffer-size" 'method) ((self #.(lispify "bt-typed-constraint" 'classname)))
  (#.(lispify "btTypedConstraint_calculateSerializeBufferSize" 'function) (ff-pointer self)))

(defmethod #.(lispify "serialize" 'method) ((self #.(lispify "bt-typed-constraint" 'classname)) dataBuffer (serializer #.(lispify "bt-serializer" 'classname)))
  (#.(lispify "btTypedConstraint_serialize" 'function) (ff-pointer self) dataBuffer serializer))



(defmethod initialize-instance :after ((obj #.(lispify "bt-angular-limit" 'class)) &key)
  (setf (slot-value obj 'ff-pointer) (#.(lispify "new_btAngularLimit" 'function))))

(defmethod #.(lispify "set" 'method) ((self #.(lispify "bt-angular-limit" 'classname)) (low number) (high number) (_softness number) (_biasFactor number) (_relaxationFactor number))
  (#.(lispify "btAngularLimit_set" 'function) (ff-pointer self) low high _softness _biasFactor _relaxationFactor))

(defmethod #.(lispify "set" 'method) ((self #.(lispify "bt-angular-limit" 'classname)) (low number) (high number) (_softness number) (_biasFactor number))
  (#.(lispify "btAngularLimit_set" 'function) (ff-pointer self) low high _softness _biasFactor))

(defmethod #.(lispify "set" 'method) ((self #.(lispify "bt-angular-limit" 'classname)) (low number) (high number) (_softness number))
  (#.(lispify "btAngularLimit_set" 'function) (ff-pointer self) low high _softness))

(defmethod #.(lispify "set" 'method) ((self #.(lispify "bt-angular-limit" 'classname)) (low number) (high number))
  (#.(lispify "btAngularLimit_set" 'function) (ff-pointer self) low high))

(defmethod #.(lispify "test" 'method) ((self #.(lispify "bt-angular-limit" 'classname)) (angle number))
  (#.(lispify "btAngularLimit_test" 'function) (ff-pointer self) angle))

(defmethod #.(lispify "get-softness" 'method) ((self #.(lispify "bt-angular-limit" 'classname)))
  (#.(lispify "btAngularLimit_getSoftness" 'function) (ff-pointer self)))

(defmethod #.(lispify "get-bias-factor" 'method) ((self #.(lispify "bt-angular-limit" 'classname)))
  (#.(lispify "btAngularLimit_getBiasFactor" 'function) (ff-pointer self)))

(defmethod #.(lispify "get-relaxation-factor" 'method) ((self #.(lispify "bt-angular-limit" 'classname)))
  (#.(lispify "btAngularLimit_getRelaxationFactor" 'function) (ff-pointer self)))

(defmethod #.(lispify "get-correction" 'method) ((self #.(lispify "bt-angular-limit" 'classname)))
  (#.(lispify "btAngularLimit_getCorrection" 'function) (ff-pointer self)))

(defmethod #.(lispify "get-sign" 'method) ((self #.(lispify "bt-angular-limit" 'classname)))
  (#.(lispify "btAngularLimit_getSign" 'function) (ff-pointer self)))

(defmethod #.(lispify "get-half-range" 'method) ((self #.(lispify "bt-angular-limit" 'classname)))
  (#.(lispify "btAngularLimit_getHalfRange" 'function) (ff-pointer self)))

(defmethod #.(lispify "is-limit" 'method) ((self #.(lispify "bt-angular-limit" 'classname)))
  (#.(lispify "btAngularLimit_isLimit" 'function) (ff-pointer self)))

(defmethod #.(lispify "fit" 'method) ((self #.(lispify "bt-angular-limit" 'classname)) angle)
  (#.(lispify "btAngularLimit_fit" 'function) (ff-pointer self) angle))

(defmethod #.(lispify "get-error" 'method) ((self #.(lispify "bt-angular-limit" 'classname)))
  (#.(lispify "btAngularLimit_getError" 'function) (ff-pointer self)))

(defmethod #.(lispify "get-low" 'method) ((self #.(lispify "bt-angular-limit" 'classname)))
  (#.(lispify "btAngularLimit_getLow" 'function) (ff-pointer self)))

(defmethod #.(lispify "get-high" 'method) ((self #.(lispify "bt-angular-limit" 'classname)))
  (#.(lispify "btAngularLimit_getHigh" 'function) (ff-pointer self)))



(defmethod #.(lispify "new" 'method) ((self #.(lispify "bt-point2-point-constraint" 'classname)) sizeInBytes)
  (#.(lispify "btPoint2PointConstraint_makeCPlusPlusInstance" 'function) (ff-pointer self) sizeInBytes))

(defmethod #.(lispify "delete" 'method) ((self #.(lispify "bt-point2-point-constraint" 'classname)) ptr)
  (#.(lispify "btPoint2PointConstraint_deleteCPlusPlusInstance" 'function) (ff-pointer self) ptr))

(defmethod #.(lispify "new" 'method) ((self #.(lispify "bt-point2-point-constraint" 'classname)) arg1 ptr)
  (#.(lispify "btPoint2PointConstraint_makeCPlusPlusInstance" 'function) (ff-pointer self) arg1 ptr))

(defmethod #.(lispify "delete" 'method) ((self #.(lispify "bt-point2-point-constraint" 'classname)) arg1 arg2)
  (#.(lispify "btPoint2PointConstraint_deleteCPlusPlusInstance" 'function) (ff-pointer self) arg1 arg2))

(shadow "new[]")
(defmethod #.(lispify "new[]" 'method) ((self #.(lispify "bt-point2-point-constraint" 'classname)) sizeInBytes)
  (#.(lispify "btPoint2PointConstraint_makeCPlusArray" 'function) (ff-pointer self) sizeInBytes))

(shadow "delete[]")
(defmethod #.(lispify "delete[]" 'method) ((self #.(lispify "bt-point2-point-constraint" 'classname)) ptr)
  (#.(lispify "btPoint2PointConstraint_deleteCPlusArray" 'function) (ff-pointer self) ptr))

(shadow "new[]")
(defmethod #.(lispify "new[]" 'method) ((self #.(lispify "bt-point2-point-constraint" 'classname)) arg1 ptr)
  (#.(lispify "btPoint2PointConstraint_makeCPlusArray" 'function) (ff-pointer self) arg1 ptr))

(shadow "delete[]")
(defmethod #.(lispify "delete[]" 'method) ((self #.(lispify "bt-point2-point-constraint" 'classname)) arg1 arg2)
  (#.(lispify "btPoint2PointConstraint_deleteCPlusArray" 'function) (ff-pointer self) arg1 arg2))

(defmethod (setf #.(lispify "m_useSolveConstraintObsolete" 'method)) (arg0 (obj #.(lispify "bt-point2-point-constraint" 'class)))
  (#.(lispify "btPoint2PointConstraint_m_useSolveConstraintObsolete_set" 'function) (ff-pointer obj) arg0))

(defmethod #.(lispify "m_useSolveConstraintObsolete" 'method) ((obj #.(lispify "bt-point2-point-constraint" 'class)))
  (#.(lispify "btPoint2PointConstraint_m_useSolveConstraintObsolete_get" 'function) (ff-pointer obj)))

(defmethod (setf #.(lispify "m_setting" 'method)) (arg0 (obj #.(lispify "bt-point2-point-constraint" 'class)))
  (#.(lispify "btPoint2PointConstraint_m_setting_set" 'function) (ff-pointer obj) arg0))

(defmethod #.(lispify "m_setting" 'method) ((obj #.(lispify "bt-point2-point-constraint" 'class)))
  (#.(lispify "btPoint2PointConstraint_m_setting_get" 'function) (ff-pointer obj)))

(defmethod initialize-instance :after ((obj #.(lispify "bt-point2-point-constraint" 'class)) &key (rbA #.(lispify "bt-rigid-body" 'classname)) (rbB #.(lispify "bt-rigid-body" 'classname)) (pivotInA #.(lispify "bt-vector3" 'classname)) (pivotInB #.(lispify "bt-vector3" 'classname)))
  (setf (slot-value obj 'ff-pointer) (#.(lispify "new_btPoint2PointConstraint" 'function) rbA rbB pivotInA pivotInB)))

(defmethod initialize-instance :after ((obj #.(lispify "bt-point2-point-constraint" 'class)) &key (rbA #.(lispify "bt-rigid-body" 'classname)) (pivotInA #.(lispify "bt-vector3" 'classname)))
  (setf (slot-value obj 'ff-pointer) (#.(lispify "new_btPoint2PointConstraint" 'function) rbA pivotInA)))

(defmethod #.(lispify "build-jacobian" 'method) ((self #.(lispify "bt-point2-point-constraint" 'classname)))
  (#.(lispify "btPoint2PointConstraint_buildJacobian" 'function) (ff-pointer self)))

(defmethod #.(lispify "get-info1" 'method) ((self #.(lispify "bt-point2-point-constraint" 'classname)) info)
  (#.(lispify "btPoint2PointConstraint_getInfo1" 'function) (ff-pointer self) info))

(defmethod #.(lispify "get-info1-non-virtual" 'method) ((self #.(lispify "bt-point2-point-constraint" 'classname)) info)
  (#.(lispify "btPoint2PointConstraint_getInfo1NonVirtual" 'function) (ff-pointer self) info))

(defmethod #.(lispify "get-info2" 'method) ((self #.(lispify "bt-point2-point-constraint" 'classname)) info)
  (#.(lispify "btPoint2PointConstraint_getInfo2" 'function) (ff-pointer self) info))

(defmethod #.(lispify "get-info2-non-virtual" 'method) ((self #.(lispify "bt-point2-point-constraint" 'classname)) info (body0_trans #.(lispify "bt-transform" 'classname)) (body1_trans #.(lispify "bt-transform" 'classname)))
  (#.(lispify "btPoint2PointConstraint_getInfo2NonVirtual" 'function) (ff-pointer self) info body0_trans body1_trans))

(defmethod #.(lispify "update-rhs" 'method) ((self #.(lispify "bt-point2-point-constraint" 'classname)) (timeStep number))
  (#.(lispify "btPoint2PointConstraint_updateRHS" 'function) (ff-pointer self) timeStep))

(defmethod #.(lispify "set-pivot-a" 'method) ((self #.(lispify "bt-point2-point-constraint" 'classname)) (pivotA #.(lispify "bt-vector3" 'classname)))
  (#.(lispify "btPoint2PointConstraint_setPivotA" 'function) (ff-pointer self) pivotA))

(defmethod #.(lispify "set-pivot-b" 'method) ((self #.(lispify "bt-point2-point-constraint" 'classname)) (pivotB #.(lispify "bt-vector3" 'classname)))
  (#.(lispify "btPoint2PointConstraint_setPivotB" 'function) (ff-pointer self) pivotB))

(defmethod #.(lispify "get-pivot-in-a" 'method) ((self #.(lispify "bt-point2-point-constraint" 'classname)))
  (#.(lispify "btPoint2PointConstraint_getPivotInA" 'function) (ff-pointer self)))

(defmethod #.(lispify "get-pivot-in-b" 'method) ((self #.(lispify "bt-point2-point-constraint" 'classname)))
  (#.(lispify "btPoint2PointConstraint_getPivotInB" 'function) (ff-pointer self)))

(defmethod #.(lispify "calculate-serialize-buffer-size" 'method) ((self #.(lispify "bt-point2-point-constraint" 'classname)))
  (#.(lispify "btPoint2PointConstraint_calculateSerializeBufferSize" 'function) (ff-pointer self)))

(defmethod #.(lispify "serialize" 'method) ((self #.(lispify "bt-point2-point-constraint" 'classname)) dataBuffer (serializer #.(lispify "bt-serializer" 'classname)))
  (#.(lispify "btPoint2PointConstraint_serialize" 'function) (ff-pointer self) dataBuffer serializer))



(defmethod #.(lispify "new" 'method) ((self #.(lispify "bt-hinge-constraint" 'classname)) sizeInBytes)
  (#.(lispify "btHingeConstraint_makeCPlusPlusInstance" 'function) (ff-pointer self) sizeInBytes))

(defmethod #.(lispify "delete" 'method) ((self #.(lispify "bt-hinge-constraint" 'classname)) ptr)
  (#.(lispify "btHingeConstraint_deleteCPlusPlusInstance" 'function) (ff-pointer self) ptr))

(defmethod #.(lispify "new" 'method) ((self #.(lispify "bt-hinge-constraint" 'classname)) arg1 ptr)
  (#.(lispify "btHingeConstraint_makeCPlusPlusInstance" 'function) (ff-pointer self) arg1 ptr))

(defmethod #.(lispify "delete" 'method) ((self #.(lispify "bt-hinge-constraint" 'classname)) arg1 arg2)
  (#.(lispify "btHingeConstraint_deleteCPlusPlusInstance" 'function) (ff-pointer self) arg1 arg2))

(shadow "new[]")
(defmethod #.(lispify "new[]" 'method) ((self #.(lispify "bt-hinge-constraint" 'classname)) sizeInBytes)
  (#.(lispify "btHingeConstraint_makeCPlusArray" 'function) (ff-pointer self) sizeInBytes))

(shadow "delete[]")
(defmethod #.(lispify "delete[]" 'method) ((self #.(lispify "bt-hinge-constraint" 'classname)) ptr)
  (#.(lispify "btHingeConstraint_deleteCPlusArray" 'function) (ff-pointer self) ptr))

(shadow "new[]")
(defmethod #.(lispify "new[]" 'method) ((self #.(lispify "bt-hinge-constraint" 'classname)) arg1 ptr)
  (#.(lispify "btHingeConstraint_makeCPlusArray" 'function) (ff-pointer self) arg1 ptr))

(shadow "delete[]")
(defmethod #.(lispify "delete[]" 'method) ((self #.(lispify "bt-hinge-constraint" 'classname)) arg1 arg2)
  (#.(lispify "btHingeConstraint_deleteCPlusArray" 'function) (ff-pointer self) arg1 arg2))

(defmethod initialize-instance :after ((obj #.(lispify "bt-hinge-constraint" 'class)) &key (rbA #.(lispify "bt-rigid-body" 'classname)) (rbB #.(lispify "bt-rigid-body" 'classname)) (pivotInA #.(lispify "bt-vector3" 'classname)) (pivotInB #.(lispify "bt-vector3" 'classname)) (axisInA #.(lispify "bt-vector3" 'classname)) (axisInB #.(lispify "bt-vector3" 'classname)) (useReferenceFrameA t))
  (setf (slot-value obj 'ff-pointer) (#.(lispify "new_btHingeConstraint" 'function) rbA rbB pivotInA pivotInB axisInA axisInB useReferenceFrameA)))

(defmethod initialize-instance :after ((obj #.(lispify "bt-hinge-constraint" 'class)) &key (rbA #.(lispify "bt-rigid-body" 'classname)) (rbB #.(lispify "bt-rigid-body" 'classname)) (pivotInA #.(lispify "bt-vector3" 'classname)) (pivotInB #.(lispify "bt-vector3" 'classname)) (axisInA #.(lispify "bt-vector3" 'classname)) (axisInB #.(lispify "bt-vector3" 'classname)))
  (setf (slot-value obj 'ff-pointer) (#.(lispify "new_btHingeConstraint" 'function) rbA rbB pivotInA pivotInB axisInA axisInB)))

(defmethod initialize-instance :after ((obj #.(lispify "bt-hinge-constraint" 'class)) &key (rbA #.(lispify "bt-rigid-body" 'classname)) (pivotInA #.(lispify "bt-vector3" 'classname)) (axisInA #.(lispify "bt-vector3" 'classname)) (useReferenceFrameA t))
  (setf (slot-value obj 'ff-pointer) (#.(lispify "new_btHingeConstraint" 'function) rbA pivotInA axisInA useReferenceFrameA)))

(defmethod initialize-instance :after ((obj #.(lispify "bt-hinge-constraint" 'class)) &key (rbA #.(lispify "bt-rigid-body" 'classname)) (pivotInA #.(lispify "bt-vector3" 'classname)) (axisInA #.(lispify "bt-vector3" 'classname)))
  (setf (slot-value obj 'ff-pointer) (#.(lispify "new_btHingeConstraint" 'function) rbA pivotInA axisInA)))

(defmethod initialize-instance :after ((obj #.(lispify "bt-hinge-constraint" 'class)) &key (rbA #.(lispify "bt-rigid-body" 'classname)) (rbB #.(lispify "bt-rigid-body" 'classname)) (rbAFrame #.(lispify "bt-transform" 'classname)) (rbBFrame #.(lispify "bt-transform" 'classname)) (useReferenceFrameA t))
  (setf (slot-value obj 'ff-pointer) (#.(lispify "new_btHingeConstraint" 'function) rbA rbB rbAFrame rbBFrame useReferenceFrameA)))

(defmethod initialize-instance :after ((obj #.(lispify "bt-hinge-constraint" 'class)) &key (rbA #.(lispify "bt-rigid-body" 'classname)) (rbB #.(lispify "bt-rigid-body" 'classname)) (rbAFrame #.(lispify "bt-transform" 'classname)) (rbBFrame #.(lispify "bt-transform" 'classname)))
  (setf (slot-value obj 'ff-pointer) (#.(lispify "new_btHingeConstraint" 'function) rbA rbB rbAFrame rbBFrame)))

(defmethod initialize-instance :after ((obj #.(lispify "bt-hinge-constraint" 'class)) &key (rbA #.(lispify "bt-rigid-body" 'classname)) (rbAFrame #.(lispify "bt-transform" 'classname)) (useReferenceFrameA t))
  (setf (slot-value obj 'ff-pointer) (#.(lispify "new_btHingeConstraint" 'function) rbA rbAFrame useReferenceFrameA)))

(defmethod initialize-instance :after ((obj #.(lispify "bt-hinge-constraint" 'class)) &key (rbA #.(lispify "bt-rigid-body" 'classname)) (rbAFrame #.(lispify "bt-transform" 'classname)))
  (setf (slot-value obj 'ff-pointer) (#.(lispify "new_btHingeConstraint" 'function) rbA rbAFrame)))

(defmethod #.(lispify "build-jacobian" 'method) ((self #.(lispify "bt-hinge-constraint" 'classname)))
  (#.(lispify "btHingeConstraint_buildJacobian" 'function) (ff-pointer self)))

(defmethod #.(lispify "get-info1" 'method) ((self #.(lispify "bt-hinge-constraint" 'classname)) info)
  (#.(lispify "btHingeConstraint_getInfo1" 'function) (ff-pointer self) info))

(defmethod #.(lispify "get-info1-non-virtual" 'method) ((self #.(lispify "bt-hinge-constraint" 'classname)) info)
  (#.(lispify "btHingeConstraint_getInfo1NonVirtual" 'function) (ff-pointer self) info))

(defmethod #.(lispify "get-info2" 'method) ((self #.(lispify "bt-hinge-constraint" 'classname)) info)
  (#.(lispify "btHingeConstraint_getInfo2" 'function) (ff-pointer self) info))

(defmethod #.(lispify "get-info2-non-virtual" 'method) ((self #.(lispify "bt-hinge-constraint" 'classname)) info (transA #.(lispify "bt-transform" 'classname)) (transB #.(lispify "bt-transform" 'classname)) (angVelA #.(lispify "bt-vector3" 'classname)) (angVelB #.(lispify "bt-vector3" 'classname)))
  (#.(lispify "btHingeConstraint_getInfo2NonVirtual" 'function) (ff-pointer self) info transA transB angVelA angVelB))

(defmethod #.(lispify "get-info2-internal" 'method) ((self #.(lispify "bt-hinge-constraint" 'classname)) info (transA #.(lispify "bt-transform" 'classname)) (transB #.(lispify "bt-transform" 'classname)) (angVelA #.(lispify "bt-vector3" 'classname)) (angVelB #.(lispify "bt-vector3" 'classname)))
  (#.(lispify "btHingeConstraint_getInfo2Internal" 'function) (ff-pointer self) info transA transB angVelA angVelB))

(defmethod #.(lispify "get-info2-internal-using-frame-offset" 'method) ((self #.(lispify "bt-hinge-constraint" 'classname)) info (transA #.(lispify "bt-transform" 'classname)) (transB #.(lispify "bt-transform" 'classname)) (angVelA #.(lispify "bt-vector3" 'classname)) (angVelB #.(lispify "bt-vector3" 'classname)))
  (#.(lispify "btHingeConstraint_getInfo2InternalUsingFrameOffset" 'function) (ff-pointer self) info transA transB angVelA angVelB))

(defmethod #.(lispify "update-rhs" 'method) ((self #.(lispify "bt-hinge-constraint" 'classname)) (timeStep number))
  (#.(lispify "btHingeConstraint_updateRHS" 'function) (ff-pointer self) timeStep))

(defmethod #.(lispify "get-rigid-body-a" 'method) ((self #.(lispify "bt-hinge-constraint" 'classname)))
  (#.(lispify "btHingeConstraint_getRigidBodyA" 'function) (ff-pointer self)))

(defmethod #.(lispify "get-rigid-body-b" 'method) ((self #.(lispify "bt-hinge-constraint" 'classname)))
  (#.(lispify "btHingeConstraint_getRigidBodyB" 'function) (ff-pointer self)))

(defmethod #.(lispify "get-rigid-body-a" 'method) ((self #.(lispify "bt-hinge-constraint" 'classname)))
  (#.(lispify "btHingeConstraint_getRigidBodyA" 'function) (ff-pointer self)))

(defmethod #.(lispify "get-rigid-body-b" 'method) ((self #.(lispify "bt-hinge-constraint" 'classname)))
  (#.(lispify "btHingeConstraint_getRigidBodyB" 'function) (ff-pointer self)))

(defmethod #.(lispify "get-frame-offset-a" 'method) ((self #.(lispify "bt-hinge-constraint" 'classname)))
  (#.(lispify "btHingeConstraint_getFrameOffsetA" 'function) (ff-pointer self)))

(defmethod #.(lispify "get-frame-offset-b" 'method) ((self #.(lispify "bt-hinge-constraint" 'classname)))
  (#.(lispify "btHingeConstraint_getFrameOffsetB" 'function) (ff-pointer self)))

(defmethod #.(lispify "set-frames" 'method) ((self #.(lispify "bt-hinge-constraint" 'classname)) (frameA #.(lispify "bt-transform" 'classname)) (frameB #.(lispify "bt-transform" 'classname)))
  (#.(lispify "btHingeConstraint_setFrames" 'function) (ff-pointer self) frameA frameB))

(defmethod #.(lispify "set-angular-only" 'method) ((self #.(lispify "bt-hinge-constraint" 'classname)) (angularOnly t))
  (#.(lispify "btHingeConstraint_setAngularOnly" 'function) (ff-pointer self) angularOnly))

(defmethod #.(lispify "enable-angular-motor" 'method) ((self #.(lispify "bt-hinge-constraint" 'classname)) (enableMotor t) (targetVelocity number) (maxMotorImpulse number))
  (#.(lispify "btHingeConstraint_enableAngularMotor" 'function) (ff-pointer self) enableMotor targetVelocity maxMotorImpulse))

(defmethod #.(lispify "enable-motor" 'method) ((self #.(lispify "bt-hinge-constraint" 'classname)) (enableMotor t))
  (#.(lispify "btHingeConstraint_enableMotor" 'function) (ff-pointer self) enableMotor))

(defmethod #.(lispify "set-max-motor-impulse" 'method) ((self #.(lispify "bt-hinge-constraint" 'classname)) (maxMotorImpulse number))
  (#.(lispify "btHingeConstraint_setMaxMotorImpulse" 'function) (ff-pointer self) maxMotorImpulse))

(defmethod #.(lispify "set-motor-target" 'method) ((self #.(lispify "bt-hinge-constraint" 'classname)) (qAinB #.(lispify "bt-quaternion" 'classname)) (dt number))
  (#.(lispify "btHingeConstraint_setMotorTarget" 'function) (ff-pointer self) qAinB dt))

(defmethod #.(lispify "set-motor-target" 'method) ((self #.(lispify "bt-hinge-constraint" 'classname)) (targetAngle number) (dt number))
  (#.(lispify "btHingeConstraint_setMotorTarget" 'function) (ff-pointer self) targetAngle dt))

(defmethod #.(lispify "set-limit" 'method) ((self #.(lispify "bt-hinge-constraint" 'classname)) (low number) (high number) (_softness number) (_biasFactor number) (_relaxationFactor number))
  (HINGE-CONSTRAINT/SET-LIMIT (ff-pointer self) low high _softness _biasFactor _relaxationFactor))

(defmethod #.(lispify "set-limit" 'method) ((self #.(lispify "bt-hinge-constraint" 'classname)) (low number) (high number) (_softness number) (_biasFactor number))
  (HINGE-CONSTRAINT/SET-LIMIT (ff-pointer self) low high _softness _biasFactor))

(defmethod #.(lispify "set-limit" 'method) ((self #.(lispify "bt-hinge-constraint" 'classname)) (low number) (high number) (_softness number))
  (HINGE-CONSTRAINT/SET-LIMIT (ff-pointer self) low high _softness))

(defmethod #.(lispify "set-limit" 'method) ((self #.(lispify "bt-hinge-constraint" 'classname)) (low number) (high number))
           (HINGE-CONSTRAINT/SET-LIMIT (ff-pointer self) low high))

(defmethod #.(lispify "set-axis" 'method) ((self #.(lispify "bt-hinge-constraint" 'classname)) (axisInA #.(lispify "bt-vector3" 'classname)))
  (#.(lispify "btHingeConstraint_setAxis" 'function) (ff-pointer self) axisInA))

(defmethod #.(lispify "get-lower-limit" 'method) ((self #.(lispify "bt-hinge-constraint" 'classname)))
  (#.(lispify "btHingeConstraint_getLowerLimit" 'function) (ff-pointer self)))

(defmethod #.(lispify "get-upper-limit" 'method) ((self #.(lispify "bt-hinge-constraint" 'classname)))
  (#.(lispify "btHingeConstraint_getUpperLimit" 'function) (ff-pointer self)))

(defmethod #.(lispify "get-hinge-angle" 'method) ((self #.(lispify "bt-hinge-constraint" 'classname)))
  (#.(lispify "btHingeConstraint_getHingeAngle" 'function) (ff-pointer self)))

(defmethod #.(lispify "get-hinge-angle" 'method) ((self #.(lispify "bt-hinge-constraint" 'classname)) (transA #.(lispify "bt-transform" 'classname)) (transB #.(lispify "bt-transform" 'classname)))
  (#.(lispify "btHingeConstraint_getHingeAngle" 'function) (ff-pointer self) transA transB))

(defmethod #.(lispify "test-limit" 'method) ((self #.(lispify "bt-hinge-constraint" 'classname)) (transA #.(lispify "bt-transform" 'classname)) (transB #.(lispify "bt-transform" 'classname)))
  (#.(lispify "btHingeConstraint_testLimit" 'function) (ff-pointer self) transA transB))

(defmethod #.(lispify "get-aframe" 'method) ((self #.(lispify "bt-hinge-constraint" 'classname)))
  (#.(lispify "btHingeConstraint_getAFrame" 'function) (ff-pointer self)))

(defmethod #.(lispify "get-bframe" 'method) ((self #.(lispify "bt-hinge-constraint" 'classname)))
  (#.(lispify "btHingeConstraint_getBFrame" 'function) (ff-pointer self)))

(defmethod #.(lispify "get-aframe" 'method) ((self #.(lispify "bt-hinge-constraint" 'classname)))
  (#.(lispify "btHingeConstraint_getAFrame" 'function) (ff-pointer self)))

(defmethod #.(lispify "get-bframe" 'method) ((self #.(lispify "bt-hinge-constraint" 'classname)))
  (#.(lispify "btHingeConstraint_getBFrame" 'function) (ff-pointer self)))

(defmethod #.(lispify "get-solve-limit" 'method) ((self #.(lispify "bt-hinge-constraint" 'classname)))
  (#.(lispify "btHingeConstraint_getSolveLimit" 'function) (ff-pointer self)))

(defmethod #.(lispify "get-limit-sign" 'method) ((self #.(lispify "bt-hinge-constraint" 'classname)))
  (#.(lispify "btHingeConstraint_getLimitSign" 'function) (ff-pointer self)))

(defmethod #.(lispify "get-angular-only" 'method) ((self #.(lispify "bt-hinge-constraint" 'classname)))
  (#.(lispify "btHingeConstraint_getAngularOnly" 'function) (ff-pointer self)))

(defmethod #.(lispify "get-enable-angular-motor" 'method) ((self #.(lispify "bt-hinge-constraint" 'classname)))
  (#.(lispify "btHingeConstraint_getEnableAngularMotor" 'function) (ff-pointer self)))

(defmethod #.(lispify "get-motor-target-velosity" 'method) ((self #.(lispify "bt-hinge-constraint" 'classname)))
  (#.(lispify "btHingeConstraint_getMotorTargetVelosity" 'function) (ff-pointer self)))

(defmethod #.(lispify "get-max-motor-impulse" 'method) ((self #.(lispify "bt-hinge-constraint" 'classname)))
  (#.(lispify "btHingeConstraint_getMaxMotorImpulse" 'function) (ff-pointer self)))

(defmethod #.(lispify "get-use-frame-offset" 'method) ((self #.(lispify "bt-hinge-constraint" 'classname)))
  (#.(lispify "btHingeConstraint_getUseFrameOffset" 'function) (ff-pointer self)))

(defmethod #.(lispify "set-use-frame-offset" 'method) ((self #.(lispify "bt-hinge-constraint" 'classname)) (frameOffsetOnOff t))
  (#.(lispify "btHingeConstraint_setUseFrameOffset" 'function) (ff-pointer self) frameOffsetOnOff))

(defmethod #.(lispify "calculate-serialize-buffer-size" 'method) ((self #.(lispify "bt-hinge-constraint" 'classname)))
  (#.(lispify "btHingeConstraint_calculateSerializeBufferSize" 'function) (ff-pointer self)))

(defmethod #.(lispify "serialize" 'method) ((self #.(lispify "bt-hinge-constraint" 'classname)) dataBuffer (serializer #.(lispify "bt-serializer" 'classname)))
  (#.(lispify "btHingeConstraint_serialize" 'function) (ff-pointer self) dataBuffer serializer))



(defmethod #.(lispify "new" 'method) ((self #.(lispify "bt-cone-twist-constraint" 'classname)) sizeInBytes)
  (#.(lispify "btConeTwistConstraint_makeCPlusPlusInstance" 'function) (ff-pointer self) sizeInBytes))

(defmethod #.(lispify "delete" 'method) ((self #.(lispify "bt-cone-twist-constraint" 'classname)) ptr)
  (#.(lispify "btConeTwistConstraint_deleteCPlusPlusInstance" 'function) (ff-pointer self) ptr))

(defmethod #.(lispify "new" 'method) ((self #.(lispify "bt-cone-twist-constraint" 'classname)) arg1 ptr)
  (#.(lispify "btConeTwistConstraint_makeCPlusPlusInstance" 'function) (ff-pointer self) arg1 ptr))

(defmethod #.(lispify "delete" 'method) ((self #.(lispify "bt-cone-twist-constraint" 'classname)) arg1 arg2)
  (#.(lispify "btConeTwistConstraint_deleteCPlusPlusInstance" 'function) (ff-pointer self) arg1 arg2))

(shadow "new[]")
(defmethod #.(lispify "new[]" 'method) ((self #.(lispify "bt-cone-twist-constraint" 'classname)) sizeInBytes)
  (#.(lispify "btConeTwistConstraint_makeCPlusArray" 'function) (ff-pointer self) sizeInBytes))

(shadow "delete[]")
(defmethod #.(lispify "delete[]" 'method) ((self #.(lispify "bt-cone-twist-constraint" 'classname)) ptr)
  (#.(lispify "btConeTwistConstraint_deleteCPlusArray" 'function) (ff-pointer self) ptr))

(shadow "new[]")
(defmethod #.(lispify "new[]" 'method) ((self #.(lispify "bt-cone-twist-constraint" 'classname)) arg1 ptr)
  (#.(lispify "btConeTwistConstraint_makeCPlusArray" 'function) (ff-pointer self) arg1 ptr))

(shadow "delete[]")
(defmethod #.(lispify "delete[]" 'method) ((self #.(lispify "bt-cone-twist-constraint" 'classname)) arg1 arg2)
  (#.(lispify "btConeTwistConstraint_deleteCPlusArray" 'function) (ff-pointer self) arg1 arg2))

(defmethod initialize-instance :after ((obj #.(lispify "bt-cone-twist-constraint" 'class)) &key (rbA #.(lispify "bt-rigid-body" 'classname)) (rbB #.(lispify "bt-rigid-body" 'classname)) (rbAFrame #.(lispify "bt-transform" 'classname)) (rbBFrame #.(lispify "bt-transform" 'classname)))
  (setf (slot-value obj 'ff-pointer) (#.(lispify "new_btConeTwistConstraint" 'function) rbA rbB rbAFrame rbBFrame)))

(defmethod initialize-instance :after ((obj #.(lispify "bt-cone-twist-constraint" 'class)) &key (rbA #.(lispify "bt-rigid-body" 'classname)) (rbAFrame #.(lispify "bt-transform" 'classname)))
  (setf (slot-value obj 'ff-pointer) (#.(lispify "new_btConeTwistConstraint" 'function) rbA rbAFrame)))

(defmethod #.(lispify "build-jacobian" 'method) ((self #.(lispify "bt-cone-twist-constraint" 'classname)))
  (#.(lispify "btConeTwistConstraint_buildJacobian" 'function) (ff-pointer self)))

(defmethod #.(lispify "get-info1" 'method) ((self #.(lispify "bt-cone-twist-constraint" 'classname)) info)
  (#.(lispify "btConeTwistConstraint_getInfo1" 'function) (ff-pointer self) info))

(defmethod #.(lispify "get-info1-non-virtual" 'method) ((self #.(lispify "bt-cone-twist-constraint" 'classname)) info)
  (#.(lispify "btConeTwistConstraint_getInfo1NonVirtual" 'function) (ff-pointer self) info))

(defmethod #.(lispify "get-info2" 'method) ((self #.(lispify "bt-cone-twist-constraint" 'classname)) info)
  (#.(lispify "btConeTwistConstraint_getInfo2" 'function) (ff-pointer self) info))

(defmethod #.(lispify "get-info2-non-virtual" 'method) ((self #.(lispify "bt-cone-twist-constraint" 'classname)) info (transA #.(lispify "bt-transform" 'classname)) (transB #.(lispify "bt-transform" 'classname)) (invInertiaWorldA #.(lispify "bt-matrix3x3" 'classname)) (invInertiaWorldB #.(lispify "bt-matrix3x3" 'classname)))
  (#.(lispify "btConeTwistConstraint_getInfo2NonVirtual" 'function) (ff-pointer self) info transA transB invInertiaWorldA invInertiaWorldB))

(defmethod #.(lispify "solve-constraint-obsolete" 'method) ((self #.(lispify "bt-cone-twist-constraint" 'classname)) bodyA bodyB (timeStep number))
  (#.(lispify "btConeTwistConstraint_solveConstraintObsolete" 'function) (ff-pointer self) bodyA bodyB timeStep))

(defmethod #.(lispify "update-rhs" 'method) ((self #.(lispify "bt-cone-twist-constraint" 'classname)) (timeStep number))
  (#.(lispify "btConeTwistConstraint_updateRHS" 'function) (ff-pointer self) timeStep))

(defmethod #.(lispify "get-rigid-body-a" 'method) ((self #.(lispify "bt-cone-twist-constraint" 'classname)))
  (#.(lispify "btConeTwistConstraint_getRigidBodyA" 'function) (ff-pointer self)))

(defmethod #.(lispify "get-rigid-body-b" 'method) ((self #.(lispify "bt-cone-twist-constraint" 'classname)))
  (#.(lispify "btConeTwistConstraint_getRigidBodyB" 'function) (ff-pointer self)))

(defmethod #.(lispify "set-angular-only" 'method) ((self #.(lispify "bt-cone-twist-constraint" 'classname)) (angularOnly t))
  (#.(lispify "btConeTwistConstraint_setAngularOnly" 'function) (ff-pointer self) angularOnly))

(defmethod #.(lispify "set-limit" 'method) ((self #.(lispify "bt-cone-twist-constraint" 'classname)) (limitIndex integer) (limitValue number))
  (#.(lispify "btConeTwistConstraint_setLimit" 'function) (ff-pointer self) limitIndex limitValue))

(defmethod #.(lispify "set-limit" 'method) ((self #.(lispify "bt-cone-twist-constraint" 'classname)) (_swingSpan1 number) (_swingSpan2 number) (_twistSpan number) (_softness number) (_biasFactor number) (_relaxationFactor number))
  (#.(lispify "btConeTwistConstraint_setLimit" 'function) (ff-pointer self) _swingSpan1 _swingSpan2 _twistSpan _softness _biasFactor _relaxationFactor))

(defmethod #.(lispify "set-limit" 'method) ((self #.(lispify "bt-cone-twist-constraint" 'classname)) (_swingSpan1 number) (_swingSpan2 number) (_twistSpan number) (_softness number) (_biasFactor number))
  (#.(lispify "btConeTwistConstraint_setLimit" 'function) (ff-pointer self) _swingSpan1 _swingSpan2 _twistSpan _softness _biasFactor))

(defmethod #.(lispify "set-limit" 'method) ((self #.(lispify "bt-cone-twist-constraint" 'classname)) (_swingSpan1 number) (_swingSpan2 number) (_twistSpan number) (_softness number))
  (#.(lispify "btConeTwistConstraint_setLimit" 'function) (ff-pointer self) _swingSpan1 _swingSpan2 _twistSpan _softness))

(defmethod #.(lispify "set-limit" 'method) ((self #.(lispify "bt-cone-twist-constraint" 'classname)) (_swingSpan1 number) (_swingSpan2 number) (_twistSpan number))
  (#.(lispify "btConeTwistConstraint_setLimit" 'function) (ff-pointer self) _swingSpan1 _swingSpan2 _twistSpan))

(defmethod #.(lispify "get-aframe" 'method) ((self #.(lispify "bt-cone-twist-constraint" 'classname)))
  (#.(lispify "btConeTwistConstraint_getAFrame" 'function) (ff-pointer self)))

(defmethod #.(lispify "get-bframe" 'method) ((self #.(lispify "bt-cone-twist-constraint" 'classname)))
  (#.(lispify "btConeTwistConstraint_getBFrame" 'function) (ff-pointer self)))

(defmethod #.(lispify "get-solve-twist-limit" 'method) ((self #.(lispify "bt-cone-twist-constraint" 'classname)))
  (#.(lispify "btConeTwistConstraint_getSolveTwistLimit" 'function) (ff-pointer self)))

(defmethod #.(lispify "get-solve-swing-limit" 'method) ((self #.(lispify "bt-cone-twist-constraint" 'classname)))
  (#.(lispify "btConeTwistConstraint_getSolveSwingLimit" 'function) (ff-pointer self)))

(defmethod #.(lispify "get-twist-limit-sign" 'method) ((self #.(lispify "bt-cone-twist-constraint" 'classname)))
  (#.(lispify "btConeTwistConstraint_getTwistLimitSign" 'function) (ff-pointer self)))

(defmethod #.(lispify "calc-angle-info" 'method) ((self #.(lispify "bt-cone-twist-constraint" 'classname)))
  (#.(lispify "btConeTwistConstraint_calcAngleInfo" 'function) (ff-pointer self)))

(defmethod #.(lispify "calc-angle-info2" 'method) ((self #.(lispify "bt-cone-twist-constraint" 'classname)) (transA #.(lispify "bt-transform" 'classname)) (transB #.(lispify "bt-transform" 'classname)) (invInertiaWorldA #.(lispify "bt-matrix3x3" 'classname)) (invInertiaWorldB #.(lispify "bt-matrix3x3" 'classname)))
  (#.(lispify "btConeTwistConstraint_calcAngleInfo2" 'function) (ff-pointer self) transA transB invInertiaWorldA invInertiaWorldB))

(defmethod #.(lispify "get-swing-span1" 'method) ((self #.(lispify "bt-cone-twist-constraint" 'classname)))
  (#.(lispify "btConeTwistConstraint_getSwingSpan1" 'function) (ff-pointer self)))

(defmethod #.(lispify "get-swing-span2" 'method) ((self #.(lispify "bt-cone-twist-constraint" 'classname)))
  (#.(lispify "btConeTwistConstraint_getSwingSpan2" 'function) (ff-pointer self)))

(defmethod #.(lispify "get-twist-span" 'method) ((self #.(lispify "bt-cone-twist-constraint" 'classname)))
  (#.(lispify "btConeTwistConstraint_getTwistSpan" 'function) (ff-pointer self)))

(defmethod #.(lispify "get-twist-angle" 'method) ((self #.(lispify "bt-cone-twist-constraint" 'classname)))
  (#.(lispify "btConeTwistConstraint_getTwistAngle" 'function) (ff-pointer self)))

(defmethod #.(lispify "is-past-swing-limit" 'method) ((self #.(lispify "bt-cone-twist-constraint" 'classname)))
  (#.(lispify "btConeTwistConstraint_isPastSwingLimit" 'function) (ff-pointer self)))

(defmethod #.(lispify "set-damping" 'method) ((self #.(lispify "bt-cone-twist-constraint" 'classname)) (damping number))
  (#.(lispify "btConeTwistConstraint_setDamping" 'function) (ff-pointer self) damping))

(defmethod #.(lispify "enable-motor" 'method) ((self #.(lispify "bt-cone-twist-constraint" 'classname)) (b t))
  (#.(lispify "btConeTwistConstraint_enableMotor" 'function) (ff-pointer self) b))

(defmethod #.(lispify "set-max-motor-impulse" 'method) ((self #.(lispify "bt-cone-twist-constraint" 'classname)) (maxMotorImpulse number))
  (#.(lispify "btConeTwistConstraint_setMaxMotorImpulse" 'function) (ff-pointer self) maxMotorImpulse))

(defmethod #.(lispify "set-max-motor-impulse-normalized" 'method) ((self #.(lispify "bt-cone-twist-constraint" 'classname)) (maxMotorImpulse number))
  (#.(lispify "btConeTwistConstraint_setMaxMotorImpulseNormalized" 'function) (ff-pointer self) maxMotorImpulse))

(defmethod #.(lispify "get-fix-thresh" 'method) ((self #.(lispify "bt-cone-twist-constraint" 'classname)))
  (#.(lispify "btConeTwistConstraint_getFixThresh" 'function) (ff-pointer self)))

(defmethod #.(lispify "set-fix-thresh" 'method) ((self #.(lispify "bt-cone-twist-constraint" 'classname)) (fixThresh number))
  (#.(lispify "btConeTwistConstraint_setFixThresh" 'function) (ff-pointer self) fixThresh))

(defmethod #.(lispify "set-motor-target" 'method) ((self #.(lispify "bt-cone-twist-constraint" 'classname)) (q #.(lispify "bt-quaternion" 'classname)))
  (#.(lispify "btConeTwistConstraint_setMotorTarget" 'function) (ff-pointer self) q))

(defmethod #.(lispify "set-motor-target-in-constraint-space" 'method) ((self #.(lispify "bt-cone-twist-constraint" 'classname)) (q #.(lispify "bt-quaternion" 'classname)))
  (#.(lispify "btConeTwistConstraint_setMotorTargetInConstraintSpace" 'function) (ff-pointer self) q))

(defmethod #.(lispify "get-point-for-angle" 'method) ((self #.(lispify "bt-cone-twist-constraint" 'classname)) (fAngleInRadians number) (fLength number))
  (#.(lispify "btConeTwistConstraint_GetPointForAngle" 'function) (ff-pointer self) fAngleInRadians fLength))

(defmethod #.(lispify "get-frame-offset-a" 'method) ((self #.(lispify "bt-cone-twist-constraint" 'classname)))
  (#.(lispify "btConeTwistConstraint_getFrameOffsetA" 'function) (ff-pointer self)))

(defmethod #.(lispify "get-frame-offset-b" 'method) ((self #.(lispify "bt-cone-twist-constraint" 'classname)))
  (#.(lispify "btConeTwistConstraint_getFrameOffsetB" 'function) (ff-pointer self)))

(defmethod #.(lispify "calculate-serialize-buffer-size" 'method) ((self #.(lispify "bt-cone-twist-constraint" 'classname)))
  (#.(lispify "btConeTwistConstraint_calculateSerializeBufferSize" 'function) (ff-pointer self)))

(defmethod #.(lispify "serialize" 'method) ((self #.(lispify "bt-cone-twist-constraint" 'classname)) dataBuffer (serializer #.(lispify "bt-serializer" 'classname)))
  (#.(lispify "btConeTwistConstraint_serialize" 'function) (ff-pointer self) dataBuffer serializer))



(defmethod (setf #.(lispify "m_loLimit" 'method)) (arg0 (obj #.(lispify "bt-rotational-limit-motor" 'class)))
  (#.(lispify "btRotationalLimitMotor_m_loLimit_set" 'function) (ff-pointer obj) arg0))

(defmethod #.(lispify "m_loLimit" 'method) ((obj #.(lispify "bt-rotational-limit-motor" 'class)))
  (#.(lispify "btRotationalLimitMotor_m_loLimit_get" 'function) (ff-pointer obj)))

(defmethod (setf #.(lispify "m_hiLimit" 'method)) (arg0 (obj #.(lispify "bt-rotational-limit-motor" 'class)))
  (#.(lispify "btRotationalLimitMotor_m_hiLimit_set" 'function) (ff-pointer obj) arg0))

(defmethod #.(lispify "m_hiLimit" 'method) ((obj #.(lispify "bt-rotational-limit-motor" 'class)))
  (#.(lispify "btRotationalLimitMotor_m_hiLimit_get" 'function) (ff-pointer obj)))

(defmethod (setf #.(lispify "m_targetVelocity" 'method)) (arg0 (obj #.(lispify "bt-rotational-limit-motor" 'class)))
  (#.(lispify "btRotationalLimitMotor_m_targetVelocity_set" 'function) (ff-pointer obj) arg0))

(defmethod #.(lispify "m_targetVelocity" 'method) ((obj #.(lispify "bt-rotational-limit-motor" 'class)))
  (#.(lispify "btRotationalLimitMotor_m_targetVelocity_get" 'function) (ff-pointer obj)))

(defmethod (setf #.(lispify "m_maxMotorForce" 'method)) (arg0 (obj #.(lispify "bt-rotational-limit-motor" 'class)))
  (#.(lispify "btRotationalLimitMotor_m_maxMotorForce_set" 'function) (ff-pointer obj) arg0))

(defmethod #.(lispify "m_maxMotorForce" 'method) ((obj #.(lispify "bt-rotational-limit-motor" 'class)))
  (#.(lispify "btRotationalLimitMotor_m_maxMotorForce_get" 'function) (ff-pointer obj)))

(defmethod (setf #.(lispify "m_maxLimitForce" 'method)) (arg0 (obj #.(lispify "bt-rotational-limit-motor" 'class)))
  (#.(lispify "btRotationalLimitMotor_m_maxLimitForce_set" 'function) (ff-pointer obj) arg0))

(defmethod #.(lispify "m_maxLimitForce" 'method) ((obj #.(lispify "bt-rotational-limit-motor" 'class)))
  (#.(lispify "btRotationalLimitMotor_m_maxLimitForce_get" 'function) (ff-pointer obj)))

(defmethod (setf #.(lispify "m_damping" 'method)) (arg0 (obj #.(lispify "bt-rotational-limit-motor" 'class)))
  (#.(lispify "btRotationalLimitMotor_m_damping_set" 'function) (ff-pointer obj) arg0))

(defmethod #.(lispify "m_damping" 'method) ((obj #.(lispify "bt-rotational-limit-motor" 'class)))
  (#.(lispify "btRotationalLimitMotor_m_damping_get" 'function) (ff-pointer obj)))

(defmethod (setf #.(lispify "m_limitSoftness" 'method)) (arg0 (obj #.(lispify "bt-rotational-limit-motor" 'class)))
  (#.(lispify "btRotationalLimitMotor_m_limitSoftness_set" 'function) (ff-pointer obj) arg0))

(defmethod #.(lispify "m_limitSoftness" 'method) ((obj #.(lispify "bt-rotational-limit-motor" 'class)))
  (#.(lispify "btRotationalLimitMotor_m_limitSoftness_get" 'function) (ff-pointer obj)))

(defmethod (setf #.(lispify "m_normalCFM" 'method)) (arg0 (obj #.(lispify "bt-rotational-limit-motor" 'class)))
  (#.(lispify "btRotationalLimitMotor_m_normalCFM_set" 'function) (ff-pointer obj) arg0))

(defmethod #.(lispify "m_normalCFM" 'method) ((obj #.(lispify "bt-rotational-limit-motor" 'class)))
  (#.(lispify "btRotationalLimitMotor_m_normalCFM_get" 'function) (ff-pointer obj)))

(defmethod (setf #.(lispify "m_stopERP" 'method)) (arg0 (obj #.(lispify "bt-rotational-limit-motor" 'class)))
  (#.(lispify "btRotationalLimitMotor_m_stopERP_set" 'function) (ff-pointer obj) arg0))

(defmethod #.(lispify "m_stopERP" 'method) ((obj #.(lispify "bt-rotational-limit-motor" 'class)))
  (#.(lispify "btRotationalLimitMotor_m_stopERP_get" 'function) (ff-pointer obj)))

(defmethod (setf #.(lispify "m_stopCFM" 'method)) (arg0 (obj #.(lispify "bt-rotational-limit-motor" 'class)))
  (#.(lispify "btRotationalLimitMotor_m_stopCFM_set" 'function) (ff-pointer obj) arg0))

(defmethod #.(lispify "m_stopCFM" 'method) ((obj #.(lispify "bt-rotational-limit-motor" 'class)))
  (#.(lispify "btRotationalLimitMotor_m_stopCFM_get" 'function) (ff-pointer obj)))

(defmethod (setf #.(lispify "m_bounce" 'method)) (arg0 (obj #.(lispify "bt-rotational-limit-motor" 'class)))
  (#.(lispify "btRotationalLimitMotor_m_bounce_set" 'function) (ff-pointer obj) arg0))

(defmethod #.(lispify "m_bounce" 'method) ((obj #.(lispify "bt-rotational-limit-motor" 'class)))
  (#.(lispify "btRotationalLimitMotor_m_bounce_get" 'function) (ff-pointer obj)))

(defmethod (setf #.(lispify "m_enableMotor" 'method)) (arg0 (obj #.(lispify "bt-rotational-limit-motor" 'class)))
  (#.(lispify "btRotationalLimitMotor_m_enableMotor_set" 'function) (ff-pointer obj) arg0))

(defmethod #.(lispify "m_enableMotor" 'method) ((obj #.(lispify "bt-rotational-limit-motor" 'class)))
  (#.(lispify "btRotationalLimitMotor_m_enableMotor_get" 'function) (ff-pointer obj)))

(defmethod (setf #.(lispify "m_currentLimitError" 'method)) (arg0 (obj #.(lispify "bt-rotational-limit-motor" 'class)))
  (#.(lispify "btRotationalLimitMotor_m_currentLimitError_set" 'function) (ff-pointer obj) arg0))

(defmethod #.(lispify "m_currentLimitError" 'method) ((obj #.(lispify "bt-rotational-limit-motor" 'class)))
  (#.(lispify "btRotationalLimitMotor_m_currentLimitError_get" 'function) (ff-pointer obj)))

(defmethod (setf #.(lispify "m_currentPosition" 'method)) (arg0 (obj #.(lispify "bt-rotational-limit-motor" 'class)))
  (#.(lispify "btRotationalLimitMotor_m_currentPosition_set" 'function) (ff-pointer obj) arg0))

(defmethod #.(lispify "m_currentPosition" 'method) ((obj #.(lispify "bt-rotational-limit-motor" 'class)))
  (#.(lispify "btRotationalLimitMotor_m_currentPosition_get" 'function) (ff-pointer obj)))

(defmethod (setf #.(lispify "m_currentLimit" 'method)) (arg0 (obj #.(lispify "bt-rotational-limit-motor" 'class)))
  (#.(lispify "btRotationalLimitMotor_m_currentLimit_set" 'function) (ff-pointer obj) arg0))

(defmethod #.(lispify "m_currentLimit" 'method) ((obj #.(lispify "bt-rotational-limit-motor" 'class)))
  (#.(lispify "btRotationalLimitMotor_m_currentLimit_get" 'function) (ff-pointer obj)))

(defmethod (setf #.(lispify "m_accumulatedImpulse" 'method)) (arg0 (obj #.(lispify "bt-rotational-limit-motor" 'class)))
  (#.(lispify "btRotationalLimitMotor_m_accumulatedImpulse_set" 'function) (ff-pointer obj) arg0))

(defmethod #.(lispify "m_accumulatedImpulse" 'method) ((obj #.(lispify "bt-rotational-limit-motor" 'class)))
  (#.(lispify "btRotationalLimitMotor_m_accumulatedImpulse_get" 'function) (ff-pointer obj)))

(defmethod initialize-instance :after ((obj #.(lispify "bt-rotational-limit-motor" 'class)) &key)
  (setf (slot-value obj 'ff-pointer) (#.(lispify "new_btRotationalLimitMotor" 'function))))

(defmethod initialize-instance :after ((obj #.(lispify "bt-rotational-limit-motor" 'class)) &key (limot #.(lispify "bt-rotational-limit-motor" 'classname)))
  (setf (slot-value obj 'ff-pointer) (#.(lispify "new_btRotationalLimitMotor" 'function) (ff-pointer limot))))

(defmethod #.(lispify "is-limited" 'method) ((self #.(lispify "bt-rotational-limit-motor" 'classname)))
  (#.(lispify "btRotationalLimitMotor_isLimited" 'function) (ff-pointer self)))

(defmethod #.(lispify "need-apply-torques" 'method) ((self #.(lispify "bt-rotational-limit-motor" 'classname)))
  (#.(lispify "btRotationalLimitMotor_needApplyTorques" 'function) (ff-pointer self)))

(defmethod #.(lispify "test-limit-value" 'method) ((self #.(lispify "bt-rotational-limit-motor" 'classname)) (test_value number))
  (#.(lispify "btRotationalLimitMotor_testLimitValue" 'function) (ff-pointer self) test_value))

(defmethod #.(lispify "solve-angular-limits" 'method) ((self #.(lispify "bt-rotational-limit-motor" 'classname)) (timeStep number) (axis #.(lispify "bt-vector3" 'classname)) (jacDiagABInv number) (body0 #.(lispify "bt-rigid-body" 'classname)) (body1 #.(lispify "bt-rigid-body" 'classname)))
  (#.(lispify "btRotationalLimitMotor_solveAngularLimits" 'function) (ff-pointer self) timeStep axis jacDiagABInv body0 body1))



(defmethod (setf #.(lispify "m_lowerLimit" 'method)) (arg0 (obj #.(lispify "bt-translational-limit-motor" 'class)))
  (#.(lispify "btTranslationalLimitMotor_m_lowerLimit_set" 'function) (ff-pointer obj) arg0))

(defmethod #.(lispify "m_lowerLimit" 'method) ((obj #.(lispify "bt-translational-limit-motor" 'class)))
  (#.(lispify "btTranslationalLimitMotor_m_lowerLimit_get" 'function) (ff-pointer obj)))

(defmethod (setf #.(lispify "m_upperLimit" 'method)) (arg0 (obj #.(lispify "bt-translational-limit-motor" 'class)))
  (#.(lispify "btTranslationalLimitMotor_m_upperLimit_set" 'function) (ff-pointer obj) arg0))

(defmethod #.(lispify "m_upperLimit" 'method) ((obj #.(lispify "bt-translational-limit-motor" 'class)))
  (#.(lispify "btTranslationalLimitMotor_m_upperLimit_get" 'function) (ff-pointer obj)))

(defmethod (setf #.(lispify "m_accumulatedImpulse" 'method)) (arg0 (obj #.(lispify "bt-translational-limit-motor" 'class)))
  (#.(lispify "btTranslationalLimitMotor_m_accumulatedImpulse_set" 'function) (ff-pointer obj) arg0))

(defmethod #.(lispify "m_accumulatedImpulse" 'method) ((obj #.(lispify "bt-translational-limit-motor" 'class)))
  (#.(lispify "btTranslationalLimitMotor_m_accumulatedImpulse_get" 'function) (ff-pointer obj)))

(defmethod (setf #.(lispify "m_limitSoftness" 'method)) (arg0 (obj #.(lispify "bt-translational-limit-motor" 'class)))
  (#.(lispify "btTranslationalLimitMotor_m_limitSoftness_set" 'function) (ff-pointer obj) arg0))

(defmethod #.(lispify "m_limitSoftness" 'method) ((obj #.(lispify "bt-translational-limit-motor" 'class)))
  (#.(lispify "btTranslationalLimitMotor_m_limitSoftness_get" 'function) (ff-pointer obj)))

(defmethod (setf #.(lispify "m_damping" 'method)) (arg0 (obj #.(lispify "bt-translational-limit-motor" 'class)))
  (#.(lispify "btTranslationalLimitMotor_m_damping_set" 'function) (ff-pointer obj) arg0))

(defmethod #.(lispify "m_damping" 'method) ((obj #.(lispify "bt-translational-limit-motor" 'class)))
  (#.(lispify "btTranslationalLimitMotor_m_damping_get" 'function) (ff-pointer obj)))

(defmethod (setf #.(lispify "m_restitution" 'method)) (arg0 (obj #.(lispify "bt-translational-limit-motor" 'class)))
  (#.(lispify "btTranslationalLimitMotor_m_restitution_set" 'function) (ff-pointer obj) arg0))

(defmethod #.(lispify "m_restitution" 'method) ((obj #.(lispify "bt-translational-limit-motor" 'class)))
  (#.(lispify "btTranslationalLimitMotor_m_restitution_get" 'function) (ff-pointer obj)))

(defmethod (setf #.(lispify "m_normalCFM" 'method)) (arg0 (obj #.(lispify "bt-translational-limit-motor" 'class)))
  (#.(lispify "btTranslationalLimitMotor_m_normalCFM_set" 'function) (ff-pointer obj) arg0))

(defmethod #.(lispify "m_normalCFM" 'method) ((obj #.(lispify "bt-translational-limit-motor" 'class)))
  (#.(lispify "btTranslationalLimitMotor_m_normalCFM_get" 'function) (ff-pointer obj)))

(defmethod (setf #.(lispify "m_stopERP" 'method)) (arg0 (obj #.(lispify "bt-translational-limit-motor" 'class)))
  (#.(lispify "btTranslationalLimitMotor_m_stopERP_set" 'function) (ff-pointer obj) arg0))

(defmethod #.(lispify "m_stopERP" 'method) ((obj #.(lispify "bt-translational-limit-motor" 'class)))
  (#.(lispify "btTranslationalLimitMotor_m_stopERP_get" 'function) (ff-pointer obj)))

(defmethod (setf #.(lispify "m_stopCFM" 'method)) (arg0 (obj #.(lispify "bt-translational-limit-motor" 'class)))
  (#.(lispify "btTranslationalLimitMotor_m_stopCFM_set" 'function) (ff-pointer obj) arg0))

(defmethod #.(lispify "m_stopCFM" 'method) ((obj #.(lispify "bt-translational-limit-motor" 'class)))
  (#.(lispify "btTranslationalLimitMotor_m_stopCFM_get" 'function) (ff-pointer obj)))

(defmethod (setf #.(lispify "m_enableMotor" 'method)) (arg0 (obj #.(lispify "bt-translational-limit-motor" 'class)))
  (#.(lispify "btTranslationalLimitMotor_m_enableMotor_set" 'function) (ff-pointer obj) arg0))

(defmethod #.(lispify "m_enableMotor" 'method) ((obj #.(lispify "bt-translational-limit-motor" 'class)))
  (#.(lispify "btTranslationalLimitMotor_m_enableMotor_get" 'function) (ff-pointer obj)))

(defmethod (setf #.(lispify "m_targetVelocity" 'method)) (arg0 (obj #.(lispify "bt-translational-limit-motor" 'class)))
  (#.(lispify "btTranslationalLimitMotor_m_targetVelocity_set" 'function) (ff-pointer obj) arg0))

(defmethod #.(lispify "m_targetVelocity" 'method) ((obj #.(lispify "bt-translational-limit-motor" 'class)))
  (#.(lispify "btTranslationalLimitMotor_m_targetVelocity_get" 'function) (ff-pointer obj)))

(defmethod (setf #.(lispify "m_maxMotorForce" 'method)) (arg0 (obj #.(lispify "bt-translational-limit-motor" 'class)))
  (#.(lispify "btTranslationalLimitMotor_m_maxMotorForce_set" 'function) (ff-pointer obj) arg0))

(defmethod #.(lispify "m_maxMotorForce" 'method) ((obj #.(lispify "bt-translational-limit-motor" 'class)))
  (#.(lispify "btTranslationalLimitMotor_m_maxMotorForce_get" 'function) (ff-pointer obj)))

(defmethod (setf #.(lispify "m_currentLimitError" 'method)) (arg0 (obj #.(lispify "bt-translational-limit-motor" 'class)))
  (#.(lispify "btTranslationalLimitMotor_m_currentLimitError_set" 'function) (ff-pointer obj) arg0))

(defmethod #.(lispify "m_currentLimitError" 'method) ((obj #.(lispify "bt-translational-limit-motor" 'class)))
  (#.(lispify "btTranslationalLimitMotor_m_currentLimitError_get" 'function) (ff-pointer obj)))

(defmethod (setf #.(lispify "m_currentLinearDiff" 'method)) (arg0 (obj #.(lispify "bt-translational-limit-motor" 'class)))
  (#.(lispify "btTranslationalLimitMotor_m_currentLinearDiff_set" 'function) (ff-pointer obj) arg0))

(defmethod #.(lispify "m_currentLinearDiff" 'method) ((obj #.(lispify "bt-translational-limit-motor" 'class)))
  (#.(lispify "btTranslationalLimitMotor_m_currentLinearDiff_get" 'function) (ff-pointer obj)))

(defmethod (setf #.(lispify "m_currentLimit" 'method)) (arg0 (obj #.(lispify "bt-translational-limit-motor" 'class)))
  (#.(lispify "btTranslationalLimitMotor_m_currentLimit_set" 'function) (ff-pointer obj) arg0))

(defmethod #.(lispify "m_currentLimit" 'method) ((obj #.(lispify "bt-translational-limit-motor" 'class)))
  (#.(lispify "btTranslationalLimitMotor_m_currentLimit_get" 'function) (ff-pointer obj)))

(defmethod initialize-instance :after ((obj #.(lispify "bt-translational-limit-motor" 'class)) &key)
  (setf (slot-value obj 'ff-pointer) (#.(lispify "new_btTranslationalLimitMotor" 'function))))

(defmethod initialize-instance :after ((obj #.(lispify "bt-translational-limit-motor" 'class)) &key (other #.(lispify "bt-translational-limit-motor" 'classname)))
  (setf (slot-value obj 'ff-pointer) (#.(lispify "new_btTranslationalLimitMotor" 'function) (ff-pointer other))))

(defmethod #.(lispify "is-limited" 'method) ((self #.(lispify "bt-translational-limit-motor" 'classname)) (limitIndex integer))
  (#.(lispify "btTranslationalLimitMotor_isLimited" 'function) (ff-pointer self) limitIndex))

(defmethod #.(lispify "need-apply-force" 'method) ((self #.(lispify "bt-translational-limit-motor" 'classname)) (limitIndex integer))
  (#.(lispify "btTranslationalLimitMotor_needApplyForce" 'function) (ff-pointer self) limitIndex))

(defmethod #.(lispify "test-limit-value" 'method) ((self #.(lispify "bt-translational-limit-motor" 'classname)) (limitIndex integer) (test_value number))
  (#.(lispify "btTranslationalLimitMotor_testLimitValue" 'function) (ff-pointer self) limitIndex test_value))

(defmethod #.(lispify "solve-linear-axis" 'method) ((self #.(lispify "bt-translational-limit-motor" 'classname)) (timeStep number) (jacDiagABInv number) (body1 #.(lispify "bt-rigid-body" 'classname)) (pointInA #.(lispify "bt-vector3" 'classname)) (body2 #.(lispify "bt-rigid-body" 'classname)) (pointInB #.(lispify "bt-vector3" 'classname)) (limit_index integer) (axis_normal_on_a #.(lispify "bt-vector3" 'classname)) (anchorPos #.(lispify "bt-vector3" 'classname)))
  (#.(lispify "btTranslationalLimitMotor_solveLinearAxis" 'function) (ff-pointer self) timeStep jacDiagABInv body1 pointInA body2 pointInB limit_index axis_normal_on_a anchorPos))



(defmethod #.(lispify "new" 'method) ((self #.(lispify "bt-generic6-dof-constraint" 'classname)) sizeInBytes)
  (#.(lispify "btGeneric6DofConstraint_makeCPlusPlusInstance" 'function) (ff-pointer self) sizeInBytes))

(defmethod #.(lispify "delete" 'method) ((self #.(lispify "bt-generic6-dof-constraint" 'classname)) ptr)
  (#.(lispify "btGeneric6DofConstraint_deleteCPlusPlusInstance" 'function) (ff-pointer self) ptr))

(defmethod #.(lispify "new" 'method) ((self #.(lispify "bt-generic6-dof-constraint" 'classname)) arg1 ptr)
  (#.(lispify "btGeneric6DofConstraint_makeCPlusPlusInstance" 'function) (ff-pointer self) arg1 ptr))

(defmethod #.(lispify "delete" 'method) ((self #.(lispify "bt-generic6-dof-constraint" 'classname)) arg1 arg2)
  (#.(lispify "btGeneric6DofConstraint_deleteCPlusPlusInstance" 'function) (ff-pointer self) arg1 arg2))

(shadow "new[]")
(defmethod #.(lispify "new[]" 'method) ((self #.(lispify "bt-generic6-dof-constraint" 'classname)) sizeInBytes)
  (#.(lispify "btGeneric6DofConstraint_makeCPlusArray" 'function) (ff-pointer self) sizeInBytes))

(shadow "delete[]")
(defmethod #.(lispify "delete[]" 'method) ((self #.(lispify "bt-generic6-dof-constraint" 'classname)) ptr)
  (#.(lispify "btGeneric6DofConstraint_deleteCPlusArray" 'function) (ff-pointer self) ptr))

(shadow "new[]")
(defmethod #.(lispify "new[]" 'method) ((self #.(lispify "bt-generic6-dof-constraint" 'classname)) arg1 ptr)
  (#.(lispify "btGeneric6DofConstraint_makeCPlusArray" 'function) (ff-pointer self) arg1 ptr))

(shadow "delete[]")
(defmethod #.(lispify "delete[]" 'method) ((self #.(lispify "bt-generic6-dof-constraint" 'classname)) arg1 arg2)
  (#.(lispify "btGeneric6DofConstraint_deleteCPlusArray" 'function) (ff-pointer self) arg1 arg2))

(defmethod (setf #.(lispify "m_useSolveConstraintObsolete" 'method)) (arg0 (obj #.(lispify "bt-generic6-dof-constraint" 'class)))
  (#.(lispify "btGeneric6DofConstraint_m_useSolveConstraintObsolete_set" 'function) (ff-pointer obj) arg0))

(defmethod #.(lispify "m_useSolveConstraintObsolete" 'method) ((obj #.(lispify "bt-generic6-dof-constraint" 'class)))
  (#.(lispify "btGeneric6DofConstraint_m_useSolveConstraintObsolete_get" 'function) (ff-pointer obj)))

(defmethod initialize-instance :after ((obj #.(lispify "bt-generic6-dof-constraint" 'class)) &key (rbA #.(lispify "bt-rigid-body" 'classname)) (rbB #.(lispify "bt-rigid-body" 'classname)) (frameInA #.(lispify "bt-transform" 'classname)) (frameInB #.(lispify "bt-transform" 'classname)) (useLinearReferenceFrameA t))
  (setf (slot-value obj 'ff-pointer) (#.(lispify "new_btGeneric6DofConstraint" 'function) rbA rbB frameInA frameInB useLinearReferenceFrameA)))

(defmethod initialize-instance :after ((obj #.(lispify "bt-generic6-dof-constraint" 'class)) &key (rbB #.(lispify "bt-rigid-body" 'classname)) (frameInB #.(lispify "bt-transform" 'classname)) (useLinearReferenceFrameB t))
  (setf (slot-value obj 'ff-pointer) (#.(lispify "new_btGeneric6DofConstraint" 'function) rbB frameInB useLinearReferenceFrameB)))

(defmethod #.(lispify "calculate-transforms" 'method) ((self #.(lispify "bt-generic6-dof-constraint" 'classname)) (transA #.(lispify "bt-transform" 'classname)) (transB #.(lispify "bt-transform" 'classname)))
  (#.(lispify "btGeneric6DofConstraint_calculateTransforms" 'function) (ff-pointer self) transA transB))

(defmethod #.(lispify "calculate-transforms" 'method) ((self #.(lispify "bt-generic6-dof-constraint" 'classname)))
  (#.(lispify "btGeneric6DofConstraint_calculateTransforms" 'function) (ff-pointer self)))

(defmethod #.(lispify "get-calculated-transform-a" 'method) ((self #.(lispify "bt-generic6-dof-constraint" 'classname)))
  (#.(lispify "btGeneric6DofConstraint_getCalculatedTransformA" 'function) (ff-pointer self)))

(defmethod #.(lispify "get-calculated-transform-b" 'method) ((self #.(lispify "bt-generic6-dof-constraint" 'classname)))
  (#.(lispify "btGeneric6DofConstraint_getCalculatedTransformB" 'function) (ff-pointer self)))

(defmethod #.(lispify "get-frame-offset-a" 'method) ((self #.(lispify "bt-generic6-dof-constraint" 'classname)))
  (#.(lispify "btGeneric6DofConstraint_getFrameOffsetA" 'function) (ff-pointer self)))

(defmethod #.(lispify "get-frame-offset-b" 'method) ((self #.(lispify "bt-generic6-dof-constraint" 'classname)))
  (#.(lispify "btGeneric6DofConstraint_getFrameOffsetB" 'function) (ff-pointer self)))

(defmethod #.(lispify "get-frame-offset-a" 'method) ((self #.(lispify "bt-generic6-dof-constraint" 'classname)))
  (#.(lispify "btGeneric6DofConstraint_getFrameOffsetA" 'function) (ff-pointer self)))

(defmethod #.(lispify "get-frame-offset-b" 'method) ((self #.(lispify "bt-generic6-dof-constraint" 'classname)))
  (#.(lispify "btGeneric6DofConstraint_getFrameOffsetB" 'function) (ff-pointer self)))

(defmethod #.(lispify "build-jacobian" 'method) ((self #.(lispify "bt-generic6-dof-constraint" 'classname)))
  (#.(lispify "btGeneric6DofConstraint_buildJacobian" 'function) (ff-pointer self)))

(defmethod #.(lispify "get-info1" 'method) ((self #.(lispify "bt-generic6-dof-constraint" 'classname)) info)
  (#.(lispify "btGeneric6DofConstraint_getInfo1" 'function) (ff-pointer self) info))

(defmethod #.(lispify "get-info1-non-virtual" 'method) ((self #.(lispify "bt-generic6-dof-constraint" 'classname)) info)
  (#.(lispify "btGeneric6DofConstraint_getInfo1NonVirtual" 'function) (ff-pointer self) info))

(defmethod #.(lispify "get-info2" 'method) ((self #.(lispify "bt-generic6-dof-constraint" 'classname)) info)
  (#.(lispify "btGeneric6DofConstraint_getInfo2" 'function) (ff-pointer self) info))

(defmethod #.(lispify "get-info2-non-virtual" 'method) ((self #.(lispify "bt-generic6-dof-constraint" 'classname)) info (transA #.(lispify "bt-transform" 'classname)) (transB #.(lispify "bt-transform" 'classname)) (linVelA #.(lispify "bt-vector3" 'classname)) (linVelB #.(lispify "bt-vector3" 'classname)) (angVelA #.(lispify "bt-vector3" 'classname)) (angVelB #.(lispify "bt-vector3" 'classname)))
  (#.(lispify "btGeneric6DofConstraint_getInfo2NonVirtual" 'function) (ff-pointer self) info transA transB linVelA linVelB angVelA angVelB))

(defmethod #.(lispify "update-rhs" 'method) ((self #.(lispify "bt-generic6-dof-constraint" 'classname)) (timeStep number))
  (#.(lispify "btGeneric6DofConstraint_updateRHS" 'function) (ff-pointer self) timeStep))

(defmethod #.(lispify "get-axis" 'method) ((self #.(lispify "bt-generic6-dof-constraint" 'classname)) (axis_index integer))
  (#.(lispify "btGeneric6DofConstraint_getAxis" 'function) (ff-pointer self) axis_index))

(defmethod #.(lispify "get-angle" 'method) ((self #.(lispify "bt-generic6-dof-constraint" 'classname)) (axis_index integer))
  (#.(lispify "btGeneric6DofConstraint_getAngle" 'function) (ff-pointer self) axis_index))

(defmethod #.(lispify "get-relative-pivot-position" 'method) ((self #.(lispify "bt-generic6-dof-constraint" 'classname)) (axis_index integer))
  (#.(lispify "btGeneric6DofConstraint_getRelativePivotPosition" 'function) (ff-pointer self) axis_index))

(defmethod #.(lispify "set-frames" 'method) ((self #.(lispify "bt-generic6-dof-constraint" 'classname)) (frameA #.(lispify "bt-transform" 'classname)) (frameB #.(lispify "bt-transform" 'classname)))
  (#.(lispify "btGeneric6DofConstraint_setFrames" 'function) (ff-pointer self) frameA frameB))

(defmethod #.(lispify "test-angular-limit-motor" 'method) ((self #.(lispify "bt-generic6-dof-constraint" 'classname)) (axis_index integer))
  (#.(lispify "btGeneric6DofConstraint_testAngularLimitMotor" 'function) (ff-pointer self) axis_index))

(defmethod #.(lispify "set-linear-lower-limit" 'method) ((self #.(lispify "bt-generic6-dof-constraint" 'classname)) (linearLower #.(lispify "bt-vector3" 'classname)))
  (#.(lispify "btGeneric6DofConstraint_setLinearLowerLimit" 'function) (ff-pointer self) linearLower))

(defmethod #.(lispify "get-linear-lower-limit" 'method) ((self #.(lispify "bt-generic6-dof-constraint" 'classname)) (linearLower #.(lispify "bt-vector3" 'classname)))
  (#.(lispify "btGeneric6DofConstraint_getLinearLowerLimit" 'function) (ff-pointer self) linearLower))

(defmethod #.(lispify "set-linear-upper-limit" 'method) ((self #.(lispify "bt-generic6-dof-constraint" 'classname)) (linearUpper #.(lispify "bt-vector3" 'classname)))
  (#.(lispify "btGeneric6DofConstraint_setLinearUpperLimit" 'function) (ff-pointer self) linearUpper))

(defmethod #.(lispify "get-linear-upper-limit" 'method) ((self #.(lispify "bt-generic6-dof-constraint" 'classname)) (linearUpper #.(lispify "bt-vector3" 'classname)))
  (#.(lispify "btGeneric6DofConstraint_getLinearUpperLimit" 'function) (ff-pointer self) linearUpper))

(defmethod #.(lispify "set-angular-lower-limit" 'method) ((self #.(lispify "bt-generic6-dof-constraint" 'classname)) (angularLower #.(lispify "bt-vector3" 'classname)))
  (#.(lispify "btGeneric6DofConstraint_setAngularLowerLimit" 'function) (ff-pointer self) angularLower))

(defmethod #.(lispify "get-angular-lower-limit" 'method) ((self #.(lispify "bt-generic6-dof-constraint" 'classname)) (angularLower #.(lispify "bt-vector3" 'classname)))
  (#.(lispify "btGeneric6DofConstraint_getAngularLowerLimit" 'function) (ff-pointer self) angularLower))

(defmethod #.(lispify "set-angular-upper-limit" 'method) ((self #.(lispify "bt-generic6-dof-constraint" 'classname)) (angularUpper #.(lispify "bt-vector3" 'classname)))
  (#.(lispify "btGeneric6DofConstraint_setAngularUpperLimit" 'function) (ff-pointer self) angularUpper))

(defmethod #.(lispify "get-angular-upper-limit" 'method) ((self #.(lispify "bt-generic6-dof-constraint" 'classname)) (angularUpper #.(lispify "bt-vector3" 'classname)))
  (#.(lispify "btGeneric6DofConstraint_getAngularUpperLimit" 'function) (ff-pointer self) angularUpper))

(defmethod #.(lispify "get-rotational-limit-motor" 'method) ((self #.(lispify "bt-generic6-dof-constraint" 'classname)) (index integer))
  (#.(lispify "btGeneric6DofConstraint_getRotationalLimitMotor" 'function) (ff-pointer self) index))

(defmethod #.(lispify "get-translational-limit-motor" 'method) ((self #.(lispify "bt-generic6-dof-constraint" 'classname)))
  (#.(lispify "btGeneric6DofConstraint_getTranslationalLimitMotor" 'function) (ff-pointer self)))

(defmethod #.(lispify "set-limit" 'method) ((self #.(lispify "bt-generic6-dof-constraint" 'classname)) (axis integer) (lo number) (hi number))
  (#.(lispify "btGeneric6DofConstraint_setLimit" 'function) (ff-pointer self) axis lo hi))

(defmethod #.(lispify "is-limited" 'method) ((self #.(lispify "bt-generic6-dof-constraint" 'classname)) (limitIndex integer))
  (#.(lispify "btGeneric6DofConstraint_isLimited" 'function) (ff-pointer self) limitIndex))

(defmethod #.(lispify "calc-anchor-pos" 'method) ((self #.(lispify "bt-generic6-dof-constraint" 'classname)))
  (#.(lispify "btGeneric6DofConstraint_calcAnchorPos" 'function) (ff-pointer self)))

(defmethod #.(lispify "get-limit-motor-info2" 'method) ((self #.(lispify "bt-generic6-dof-constraint" 'classname)) (limot #.(lispify "bt-rotational-limit-motor" 'classname)) (transA #.(lispify "bt-transform" 'classname)) (transB #.(lispify "bt-transform" 'classname)) (linVelA #.(lispify "bt-vector3" 'classname)) (linVelB #.(lispify "bt-vector3" 'classname)) (angVelA #.(lispify "bt-vector3" 'classname)) (angVelB #.(lispify "bt-vector3" 'classname)) info (row integer) (ax1 #.(lispify "bt-vector3" 'classname)) (rotational integer) (rotAllowed integer))
  (#.(lispify "btGeneric6DofConstraint_get_limit_motor_info2" 'function) (ff-pointer self) limot transA transB linVelA linVelB angVelA angVelB info row ax1 rotational rotAllowed))

(defmethod #.(lispify "get-limit-motor-info2" 'method) ((self #.(lispify "bt-generic6-dof-constraint" 'classname)) (limot #.(lispify "bt-rotational-limit-motor" 'classname)) (transA #.(lispify "bt-transform" 'classname)) (transB #.(lispify "bt-transform" 'classname)) (linVelA #.(lispify "bt-vector3" 'classname)) (linVelB #.(lispify "bt-vector3" 'classname)) (angVelA #.(lispify "bt-vector3" 'classname)) (angVelB #.(lispify "bt-vector3" 'classname)) info (row integer) (ax1 #.(lispify "bt-vector3" 'classname)) (rotational integer))
  (#.(lispify "btGeneric6DofConstraint_get_limit_motor_info2" 'function) (ff-pointer self) limot transA transB linVelA linVelB angVelA angVelB info row ax1 rotational))

(defmethod #.(lispify "get-use-frame-offset" 'method) ((self #.(lispify "bt-generic6-dof-constraint" 'classname)))
  (#.(lispify "btGeneric6DofConstraint_getUseFrameOffset" 'function) (ff-pointer self)))

(defmethod #.(lispify "set-use-frame-offset" 'method) ((self #.(lispify "bt-generic6-dof-constraint" 'classname)) (frameOffsetOnOff t))
  (#.(lispify "btGeneric6DofConstraint_setUseFrameOffset" 'function) (ff-pointer self) frameOffsetOnOff))

(defmethod #.(lispify "set-axis" 'method) ((self #.(lispify "bt-generic6-dof-constraint" 'classname)) (axis1 #.(lispify "bt-vector3" 'classname)) (axis2 #.(lispify "bt-vector3" 'classname)))
  (#.(lispify "btGeneric6DofConstraint_setAxis" 'function) (ff-pointer self) axis1 axis2))
(defmethod #.(lispify "calculate-serialize-buffer-size" 'method) ((self #.(lispify "bt-generic6-dof-constraint" 'classname)))
  (#.(lispify "btGeneric6DofConstraint_calculateSerializeBufferSize" 'function) (ff-pointer self)))
(defmethod #.(lispify "serialize" 'method) ((self #.(lispify "bt-generic6-dof-constraint" 'classname)) dataBuffer (serializer #.(lispify "bt-serializer" 'classname)))
  (#.(lispify "btGeneric6DofConstraint_serialize" 'function) (ff-pointer self) dataBuffer serializer))


(defmethod #.(lispify "new" 'method) ((self #.(lispify "bt-slider-constraint" 'classname)) sizeInBytes)
  (#.(lispify "btSliderConstraint_makeCPlusPlusInstance" 'function) (ff-pointer self) sizeInBytes))

(defmethod #.(lispify "delete" 'method) ((self #.(lispify "bt-slider-constraint" 'classname)) ptr)
  (#.(lispify "btSliderConstraint_deleteCPlusPlusInstance" 'function) (ff-pointer self) ptr))

(defmethod #.(lispify "new" 'method) ((self #.(lispify "bt-slider-constraint" 'classname)) arg1 ptr)
  (#.(lispify "btSliderConstraint_makeCPlusPlusInstance" 'function) (ff-pointer self) arg1 ptr))

(defmethod #.(lispify "delete" 'method) ((self #.(lispify "bt-slider-constraint" 'classname)) arg1 arg2)
  (#.(lispify "btSliderConstraint_deleteCPlusPlusInstance" 'function) (ff-pointer self) arg1 arg2))
(shadow "new[]")
(defmethod #.(lispify "new[]" 'method) ((self #.(lispify "bt-slider-constraint" 'classname)) sizeInBytes)
  (#.(lispify "btSliderConstraint_makeCPlusArray" 'function) (ff-pointer self) sizeInBytes))
(shadow "delete[]")
(defmethod #.(lispify "delete[]" 'method) ((self #.(lispify "bt-slider-constraint" 'classname)) ptr)
  (#.(lispify "btSliderConstraint_deleteCPlusArray" 'function) (ff-pointer self) ptr))
(shadow "new[]")
(defmethod #.(lispify "new[]" 'method) ((self #.(lispify "bt-slider-constraint" 'classname)) arg1 ptr)
  (#.(lispify "btSliderConstraint_makeCPlusArray" 'function) (ff-pointer self) arg1 ptr))
(shadow "delete[]")
(defmethod #.(lispify "delete[]" 'method) ((self #.(lispify "bt-slider-constraint" 'classname)) arg1 arg2)
  (#.(lispify "btSliderConstraint_deleteCPlusArray" 'function) (ff-pointer self) arg1 arg2))
(defmethod initialize-instance :after ((obj #.(lispify "bt-slider-constraint" 'class)) &key (rbA #.(lispify "bt-rigid-body" 'classname)) (rbB #.(lispify "bt-rigid-body" 'classname)) (frameInA #.(lispify "bt-transform" 'classname)) (frameInB #.(lispify "bt-transform" 'classname)) (useLinearReferenceFrameA t))
  (setf (slot-value obj 'ff-pointer) (#.(lispify "new_btSliderConstraint" 'function) rbA rbB frameInA frameInB useLinearReferenceFrameA)))
(defmethod initialize-instance :after ((obj #.(lispify "bt-slider-constraint" 'class)) &key (rbB #.(lispify "bt-rigid-body" 'classname)) (frameInB #.(lispify "bt-transform" 'classname)) (useLinearReferenceFrameA t))
  (setf (slot-value obj 'ff-pointer) (#.(lispify "new_btSliderConstraint" 'function) rbB frameInB useLinearReferenceFrameA)))
(defmethod #.(lispify "get-info1" 'method) ((self #.(lispify "bt-slider-constraint" 'classname)) info)
  (#.(lispify "btSliderConstraint_getInfo1" 'function) (ff-pointer self) info))
(defmethod #.(lispify "get-info1-non-virtual" 'method) ((self #.(lispify "bt-slider-constraint" 'classname)) info)
  (#.(lispify "btSliderConstraint_getInfo1NonVirtual" 'function) (ff-pointer self) info))
(defmethod #.(lispify "get-info2" 'method) ((self #.(lispify "bt-slider-constraint" 'classname)) info)
  (#.(lispify "btSliderConstraint_getInfo2" 'function) (ff-pointer self) info))
(defmethod #.(lispify "get-info2-non-virtual" 'method) ((self #.(lispify "bt-slider-constraint" 'classname)) info (transA #.(lispify "bt-transform" 'classname)) (transB #.(lispify "bt-transform" 'classname)) (linVelA #.(lispify "bt-vector3" 'classname)) (linVelB #.(lispify "bt-vector3" 'classname)) (rbAinvMass number) (rbBinvMass number))
  (#.(lispify "btSliderConstraint_getInfo2NonVirtual" 'function) (ff-pointer self) info transA transB linVelA linVelB rbAinvMass rbBinvMass))
(defmethod #.(lispify "get-rigid-body-a" 'method) ((self #.(lispify "bt-slider-constraint" 'classname)))
  (#.(lispify "btSliderConstraint_getRigidBodyA" 'function) (ff-pointer self)))

(defmethod #.(lispify "get-rigid-body-b" 'method) ((self #.(lispify "bt-slider-constraint" 'classname)))
  (#.(lispify "btSliderConstraint_getRigidBodyB" 'function) (ff-pointer self)))

(defmethod #.(lispify "get-calculated-transform-a" 'method) ((self #.(lispify "bt-slider-constraint" 'classname)))
  (#.(lispify "btSliderConstraint_getCalculatedTransformA" 'function) (ff-pointer self)))

(defmethod #.(lispify "get-calculated-transform-b" 'method) ((self #.(lispify "bt-slider-constraint" 'classname)))
  (#.(lispify "btSliderConstraint_getCalculatedTransformB" 'function) (ff-pointer self)))

(defmethod #.(lispify "get-frame-offset-a" 'method) ((self #.(lispify "bt-slider-constraint" 'classname)))
  (#.(lispify "btSliderConstraint_getFrameOffsetA" 'function) (ff-pointer self)))

(defmethod #.(lispify "get-frame-offset-b" 'method) ((self #.(lispify "bt-slider-constraint" 'classname)))
  (#.(lispify "btSliderConstraint_getFrameOffsetB" 'function) (ff-pointer self)))

(defmethod #.(lispify "get-frame-offset-a" 'method) ((self #.(lispify "bt-slider-constraint" 'classname)))
  (#.(lispify "btSliderConstraint_getFrameOffsetA" 'function) (ff-pointer self)))

(defmethod #.(lispify "get-frame-offset-b" 'method) ((self #.(lispify "bt-slider-constraint" 'classname)))
  (#.(lispify "btSliderConstraint_getFrameOffsetB" 'function) (ff-pointer self)))

(defmethod #.(lispify "get-lower-lin-limit" 'method) ((self #.(lispify "bt-slider-constraint" 'classname)))
  (#.(lispify "btSliderConstraint_getLowerLinLimit" 'function) (ff-pointer self)))

(defmethod #.(lispify "set-lower-lin-limit" 'method) ((self #.(lispify "bt-slider-constraint" 'classname)) (lowerLimit number))
  (#.(lispify "btSliderConstraint_setLowerLinLimit" 'function) (ff-pointer self) lowerLimit))

(defmethod #.(lispify "get-upper-lin-limit" 'method) ((self #.(lispify "bt-slider-constraint" 'classname)))
  (#.(lispify "btSliderConstraint_getUpperLinLimit" 'function) (ff-pointer self)))

(defmethod #.(lispify "set-upper-lin-limit" 'method) ((self #.(lispify "bt-slider-constraint" 'classname)) (upperLimit number))
  (#.(lispify "btSliderConstraint_setUpperLinLimit" 'function) (ff-pointer self) upperLimit))

(defmethod #.(lispify "get-lower-ang-limit" 'method) ((self #.(lispify "bt-slider-constraint" 'classname)))
  (#.(lispify "btSliderConstraint_getLowerAngLimit" 'function) (ff-pointer self)))

(defmethod #.(lispify "set-lower-ang-limit" 'method) ((self #.(lispify "bt-slider-constraint" 'classname)) (lowerLimit number))
  (#.(lispify "btSliderConstraint_setLowerAngLimit" 'function) (ff-pointer self) lowerLimit))

(defmethod #.(lispify "get-upper-ang-limit" 'method) ((self #.(lispify "bt-slider-constraint" 'classname)))
  (#.(lispify "btSliderConstraint_getUpperAngLimit" 'function) (ff-pointer self)))

(defmethod #.(lispify "set-upper-ang-limit" 'method) ((self #.(lispify "bt-slider-constraint" 'classname)) (upperLimit number))
  (#.(lispify "btSliderConstraint_setUpperAngLimit" 'function) (ff-pointer self) upperLimit))

(defmethod #.(lispify "get-use-linear-reference-frame-a" 'method) ((self #.(lispify "bt-slider-constraint" 'classname)))
  (#.(lispify "btSliderConstraint_getUseLinearReferenceFrameA" 'function) (ff-pointer self)))

(defmethod #.(lispify "get-softness-dir-lin" 'method) ((self #.(lispify "bt-slider-constraint" 'classname)))
  (#.(lispify "btSliderConstraint_getSoftnessDirLin" 'function) (ff-pointer self)))

(defmethod #.(lispify "get-restitution-dir-lin" 'method) ((self #.(lispify "bt-slider-constraint" 'classname)))
  (#.(lispify "btSliderConstraint_getRestitutionDirLin" 'function) (ff-pointer self)))

(defmethod #.(lispify "get-damping-dir-lin" 'method) ((self #.(lispify "bt-slider-constraint" 'classname)))
  (#.(lispify "btSliderConstraint_getDampingDirLin" 'function) (ff-pointer self)))

(defmethod #.(lispify "get-softness-dir-ang" 'method) ((self #.(lispify "bt-slider-constraint" 'classname)))
  (#.(lispify "btSliderConstraint_getSoftnessDirAng" 'function) (ff-pointer self)))

(defmethod #.(lispify "get-restitution-dir-ang" 'method) ((self #.(lispify "bt-slider-constraint" 'classname)))
  (#.(lispify "btSliderConstraint_getRestitutionDirAng" 'function) (ff-pointer self)))

(defmethod #.(lispify "get-damping-dir-ang" 'method) ((self #.(lispify "bt-slider-constraint" 'classname)))
  (#.(lispify "btSliderConstraint_getDampingDirAng" 'function) (ff-pointer self)))

(defmethod #.(lispify "get-softness-lim-lin" 'method) ((self #.(lispify "bt-slider-constraint" 'classname)))
  (#.(lispify "btSliderConstraint_getSoftnessLimLin" 'function) (ff-pointer self)))

(defmethod #.(lispify "get-restitution-lim-lin" 'method) ((self #.(lispify "bt-slider-constraint" 'classname)))
  (#.(lispify "btSliderConstraint_getRestitutionLimLin" 'function) (ff-pointer self)))

(defmethod #.(lispify "get-damping-lim-lin" 'method) ((self #.(lispify "bt-slider-constraint" 'classname)))
  (#.(lispify "btSliderConstraint_getDampingLimLin" 'function) (ff-pointer self)))

(defmethod #.(lispify "get-softness-lim-ang" 'method) ((self #.(lispify "bt-slider-constraint" 'classname)))
  (#.(lispify "btSliderConstraint_getSoftnessLimAng" 'function) (ff-pointer self)))

(defmethod #.(lispify "get-restitution-lim-ang" 'method) ((self #.(lispify "bt-slider-constraint" 'classname)))
  (#.(lispify "btSliderConstraint_getRestitutionLimAng" 'function) (ff-pointer self)))

(defmethod #.(lispify "get-damping-lim-ang" 'method) ((self #.(lispify "bt-slider-constraint" 'classname)))
  (#.(lispify "btSliderConstraint_getDampingLimAng" 'function) (ff-pointer self)))

(defmethod #.(lispify "get-softness-ortho-lin" 'method) ((self #.(lispify "bt-slider-constraint" 'classname)))
  (#.(lispify "btSliderConstraint_getSoftnessOrthoLin" 'function) (ff-pointer self)))

(defmethod #.(lispify "get-restitution-ortho-lin" 'method) ((self #.(lispify "bt-slider-constraint" 'classname)))
  (#.(lispify "btSliderConstraint_getRestitutionOrthoLin" 'function) (ff-pointer self)))

(defmethod #.(lispify "get-damping-ortho-lin" 'method) ((self #.(lispify "bt-slider-constraint" 'classname)))
  (#.(lispify "btSliderConstraint_getDampingOrthoLin" 'function) (ff-pointer self)))

(defmethod #.(lispify "get-softness-ortho-ang" 'method) ((self #.(lispify "bt-slider-constraint" 'classname)))
  (#.(lispify "btSliderConstraint_getSoftnessOrthoAng" 'function) (ff-pointer self)))

(defmethod #.(lispify "get-restitution-ortho-ang" 'method) ((self #.(lispify "bt-slider-constraint" 'classname)))
  (#.(lispify "btSliderConstraint_getRestitutionOrthoAng" 'function) (ff-pointer self)))

(defmethod #.(lispify "get-damping-ortho-ang" 'method) ((self #.(lispify "bt-slider-constraint" 'classname)))
  (#.(lispify "btSliderConstraint_getDampingOrthoAng" 'function) (ff-pointer self)))

(defmethod #.(lispify "set-softness-dir-lin" 'method) ((self #.(lispify "bt-slider-constraint" 'classname)) (softnessDirLin number))
  (#.(lispify "btSliderConstraint_setSoftnessDirLin" 'function) (ff-pointer self) softnessDirLin))

(defmethod #.(lispify "set-restitution-dir-lin" 'method) ((self #.(lispify "bt-slider-constraint" 'classname)) (restitutionDirLin number))
  (#.(lispify "btSliderConstraint_setRestitutionDirLin" 'function) (ff-pointer self) restitutionDirLin))

(defmethod #.(lispify "set-damping-dir-lin" 'method) ((self #.(lispify "bt-slider-constraint" 'classname)) (dampingDirLin number))
  (#.(lispify "btSliderConstraint_setDampingDirLin" 'function) (ff-pointer self) dampingDirLin))

(defmethod #.(lispify "set-softness-dir-ang" 'method) ((self #.(lispify "bt-slider-constraint" 'classname)) (softnessDirAng number))
  (#.(lispify "btSliderConstraint_setSoftnessDirAng" 'function) (ff-pointer self) softnessDirAng))

(defmethod #.(lispify "set-restitution-dir-ang" 'method) ((self #.(lispify "bt-slider-constraint" 'classname)) (restitutionDirAng number))
  (#.(lispify "btSliderConstraint_setRestitutionDirAng" 'function) (ff-pointer self) restitutionDirAng))

(defmethod #.(lispify "set-damping-dir-ang" 'method) ((self #.(lispify "bt-slider-constraint" 'classname)) (dampingDirAng number))
  (#.(lispify "btSliderConstraint_setDampingDirAng" 'function) (ff-pointer self) dampingDirAng))

(defmethod #.(lispify "set-softness-lim-lin" 'method) ((self #.(lispify "bt-slider-constraint" 'classname)) (softnessLimLin number))
  (#.(lispify "btSliderConstraint_setSoftnessLimLin" 'function) (ff-pointer self) softnessLimLin))

(defmethod #.(lispify "set-restitution-lim-lin" 'method) ((self #.(lispify "bt-slider-constraint" 'classname)) (restitutionLimLin number))
  (#.(lispify "btSliderConstraint_setRestitutionLimLin" 'function) (ff-pointer self) restitutionLimLin))

(defmethod #.(lispify "set-damping-lim-lin" 'method) ((self #.(lispify "bt-slider-constraint" 'classname)) (dampingLimLin number))
  (#.(lispify "btSliderConstraint_setDampingLimLin" 'function) (ff-pointer self) dampingLimLin))

(defmethod #.(lispify "set-softness-lim-ang" 'method) ((self #.(lispify "bt-slider-constraint" 'classname)) (softnessLimAng number))
  (#.(lispify "btSliderConstraint_setSoftnessLimAng" 'function) (ff-pointer self) softnessLimAng))

(defmethod #.(lispify "set-restitution-lim-ang" 'method) ((self #.(lispify "bt-slider-constraint" 'classname)) (restitutionLimAng number))
  (#.(lispify "btSliderConstraint_setRestitutionLimAng" 'function) (ff-pointer self) restitutionLimAng))

(defmethod #.(lispify "set-damping-lim-ang" 'method) ((self #.(lispify "bt-slider-constraint" 'classname)) (dampingLimAng number))
  (#.(lispify "btSliderConstraint_setDampingLimAng" 'function) (ff-pointer self) dampingLimAng))

(defmethod #.(lispify "set-softness-ortho-lin" 'method) ((self #.(lispify "bt-slider-constraint" 'classname)) (softnessOrthoLin number))
  (#.(lispify "btSliderConstraint_setSoftnessOrthoLin" 'function) (ff-pointer self) softnessOrthoLin))

(defmethod #.(lispify "set-restitution-ortho-lin" 'method) ((self #.(lispify "bt-slider-constraint" 'classname)) (restitutionOrthoLin number))
  (#.(lispify "btSliderConstraint_setRestitutionOrthoLin" 'function) (ff-pointer self) restitutionOrthoLin))

(defmethod #.(lispify "set-damping-ortho-lin" 'method) ((self #.(lispify "bt-slider-constraint" 'classname)) (dampingOrthoLin number))
  (#.(lispify "btSliderConstraint_setDampingOrthoLin" 'function) (ff-pointer self) dampingOrthoLin))

(defmethod #.(lispify "set-softness-ortho-ang" 'method) ((self #.(lispify "bt-slider-constraint" 'classname)) (softnessOrthoAng number))
  (#.(lispify "btSliderConstraint_setSoftnessOrthoAng" 'function) (ff-pointer self) softnessOrthoAng))

(defmethod #.(lispify "set-restitution-ortho-ang" 'method) ((self #.(lispify "bt-slider-constraint" 'classname)) (restitutionOrthoAng number))
  (#.(lispify "btSliderConstraint_setRestitutionOrthoAng" 'function) (ff-pointer self) restitutionOrthoAng))

(defmethod #.(lispify "set-damping-ortho-ang" 'method) ((self #.(lispify "bt-slider-constraint" 'classname)) (dampingOrthoAng number))
  (#.(lispify "btSliderConstraint_setDampingOrthoAng" 'function) (ff-pointer self) dampingOrthoAng))

(defmethod #.(lispify "set-powered-lin-motor" 'method) ((self #.(lispify "bt-slider-constraint" 'classname)) (onOff t))
  (#.(lispify "btSliderConstraint_setPoweredLinMotor" 'function) (ff-pointer self) onOff))

(defmethod #.(lispify "get-powered-lin-motor" 'method) ((self #.(lispify "bt-slider-constraint" 'classname)))
  (#.(lispify "btSliderConstraint_getPoweredLinMotor" 'function) (ff-pointer self)))

(defmethod #.(lispify "set-target-lin-motor-velocity" 'method) ((self #.(lispify "bt-slider-constraint" 'classname)) (targetLinMotorVelocity number))
  (#.(lispify "btSliderConstraint_setTargetLinMotorVelocity" 'function) (ff-pointer self) targetLinMotorVelocity))

(defmethod #.(lispify "get-target-lin-motor-velocity" 'method) ((self #.(lispify "bt-slider-constraint" 'classname)))
  (#.(lispify "btSliderConstraint_getTargetLinMotorVelocity" 'function) (ff-pointer self)))

(defmethod #.(lispify "set-max-lin-motor-force" 'method) ((self #.(lispify "bt-slider-constraint" 'classname)) (maxLinMotorForce number))
  (#.(lispify "btSliderConstraint_setMaxLinMotorForce" 'function) (ff-pointer self) maxLinMotorForce))

(defmethod #.(lispify "get-max-lin-motor-force" 'method) ((self #.(lispify "bt-slider-constraint" 'classname)))
  (#.(lispify "btSliderConstraint_getMaxLinMotorForce" 'function) (ff-pointer self)))

(defmethod #.(lispify "set-powered-ang-motor" 'method) ((self #.(lispify "bt-slider-constraint" 'classname)) (onOff t))
  (#.(lispify "btSliderConstraint_setPoweredAngMotor" 'function) (ff-pointer self) onOff))

(defmethod #.(lispify "get-powered-ang-motor" 'method) ((self #.(lispify "bt-slider-constraint" 'classname)))
  (#.(lispify "btSliderConstraint_getPoweredAngMotor" 'function) (ff-pointer self)))

(defmethod #.(lispify "set-target-ang-motor-velocity" 'method) ((self #.(lispify "bt-slider-constraint" 'classname)) (targetAngMotorVelocity number))
  (#.(lispify "btSliderConstraint_setTargetAngMotorVelocity" 'function) (ff-pointer self) targetAngMotorVelocity))

(defmethod #.(lispify "get-target-ang-motor-velocity" 'method) ((self #.(lispify "bt-slider-constraint" 'classname)))
  (#.(lispify "btSliderConstraint_getTargetAngMotorVelocity" 'function) (ff-pointer self)))

(defmethod #.(lispify "set-max-ang-motor-force" 'method) ((self #.(lispify "bt-slider-constraint" 'classname)) (maxAngMotorForce number))
  (#.(lispify "btSliderConstraint_setMaxAngMotorForce" 'function) (ff-pointer self) maxAngMotorForce))

(defmethod #.(lispify "get-max-ang-motor-force" 'method) ((self #.(lispify "bt-slider-constraint" 'classname)))
  (#.(lispify "btSliderConstraint_getMaxAngMotorForce" 'function) (ff-pointer self)))

(defmethod #.(lispify "get-linear-pos" 'method) ((self #.(lispify "bt-slider-constraint" 'classname)))
  (#.(lispify "btSliderConstraint_getLinearPos" 'function) (ff-pointer self)))

(defmethod #.(lispify "get-angular-pos" 'method) ((self #.(lispify "bt-slider-constraint" 'classname)))
  (#.(lispify "btSliderConstraint_getAngularPos" 'function) (ff-pointer self)))

(defmethod #.(lispify "get-solve-lin-limit" 'method) ((self #.(lispify "bt-slider-constraint" 'classname)))
  (#.(lispify "btSliderConstraint_getSolveLinLimit" 'function) (ff-pointer self)))

(defmethod #.(lispify "get-lin-depth" 'method) ((self #.(lispify "bt-slider-constraint" 'classname)))
  (#.(lispify "btSliderConstraint_getLinDepth" 'function) (ff-pointer self)))

(defmethod #.(lispify "get-solve-ang-limit" 'method) ((self #.(lispify "bt-slider-constraint" 'classname)))
  (#.(lispify "btSliderConstraint_getSolveAngLimit" 'function) (ff-pointer self)))

(defmethod #.(lispify "get-ang-depth" 'method) ((self #.(lispify "bt-slider-constraint" 'classname)))
  (#.(lispify "btSliderConstraint_getAngDepth" 'function) (ff-pointer self)))

(defmethod #.(lispify "calculate-transforms" 'method) ((self #.(lispify "bt-slider-constraint" 'classname)) (transA #.(lispify "bt-transform" 'classname)) (transB #.(lispify "bt-transform" 'classname)))
  (#.(lispify "btSliderConstraint_calculateTransforms" 'function) (ff-pointer self) transA transB))

(defmethod #.(lispify "test-lin-limits" 'method) ((self #.(lispify "bt-slider-constraint" 'classname)))
  (#.(lispify "btSliderConstraint_testLinLimits" 'function) (ff-pointer self)))

(defmethod #.(lispify "test-ang-limits" 'method) ((self #.(lispify "bt-slider-constraint" 'classname)))
  (#.(lispify "btSliderConstraint_testAngLimits" 'function) (ff-pointer self)))

(defmethod #.(lispify "get-ancor-in-a" 'method) ((self #.(lispify "bt-slider-constraint" 'classname)))
  (#.(lispify "btSliderConstraint_getAncorInA" 'function) (ff-pointer self)))

(defmethod #.(lispify "get-ancor-in-b" 'method) ((self #.(lispify "bt-slider-constraint" 'classname)))
  (#.(lispify "btSliderConstraint_getAncorInB" 'function) (ff-pointer self)))

(defmethod #.(lispify "get-use-frame-offset" 'method) ((self #.(lispify "bt-slider-constraint" 'classname)))
  (#.(lispify "btSliderConstraint_getUseFrameOffset" 'function) (ff-pointer self)))

(defmethod #.(lispify "set-use-frame-offset" 'method) ((self #.(lispify "bt-slider-constraint" 'classname)) (frameOffsetOnOff t))
  (#.(lispify "btSliderConstraint_setUseFrameOffset" 'function) (ff-pointer self) frameOffsetOnOff))

(defmethod #.(lispify "set-frames" 'method) ((self #.(lispify "bt-slider-constraint" 'classname)) (frameA #.(lispify "bt-transform" 'classname)) (frameB #.(lispify "bt-transform" 'classname)))
  (#.(lispify "btSliderConstraint_setFrames" 'function) (ff-pointer self) frameA frameB))

(defmethod #.(lispify "calculate-serialize-buffer-size" 'method) ((self #.(lispify "bt-slider-constraint" 'classname)))
  (#.(lispify "btSliderConstraint_calculateSerializeBufferSize" 'function) (ff-pointer self)))

(defmethod #.(lispify "serialize" 'method) ((self #.(lispify "bt-slider-constraint" 'classname)) dataBuffer (serializer #.(lispify "bt-serializer" 'classname)))
  (#.(lispify "btSliderConstraint_serialize" 'function) (ff-pointer self) dataBuffer serializer))



(defmethod #.(lispify "new" 'method) ((self #.(lispify "bt-generic6-dof-spring-constraint" 'classname)) sizeInBytes)
  (#.(lispify "btGeneric6DofSpringConstraint_makeCPlusPlusInstance" 'function) (ff-pointer self) sizeInBytes))

(defmethod #.(lispify "delete" 'method) ((self #.(lispify "bt-generic6-dof-spring-constraint" 'classname)) ptr)
  (#.(lispify "btGeneric6DofSpringConstraint_deleteCPlusPlusInstance" 'function) (ff-pointer self) ptr))

(defmethod #.(lispify "new" 'method) ((self #.(lispify "bt-generic6-dof-spring-constraint" 'classname)) arg1 ptr)
  (#.(lispify "btGeneric6DofSpringConstraint_makeCPlusPlusInstance" 'function) (ff-pointer self) arg1 ptr))

(defmethod #.(lispify "delete" 'method) ((self #.(lispify "bt-generic6-dof-spring-constraint" 'classname)) arg1 arg2)
  (#.(lispify "btGeneric6DofSpringConstraint_deleteCPlusPlusInstance" 'function) (ff-pointer self) arg1 arg2))
(shadow "new[]")
(defmethod #.(lispify "new[]" 'method) ((self #.(lispify "bt-generic6-dof-spring-constraint" 'classname)) sizeInBytes)
  (#.(lispify "btGeneric6DofSpringConstraint_makeCPlusArray" 'function) (ff-pointer self) sizeInBytes))
(shadow "delete[]")
(defmethod #.(lispify "delete[]" 'method) ((self #.(lispify "bt-generic6-dof-spring-constraint" 'classname)) ptr)
  (#.(lispify "btGeneric6DofSpringConstraint_deleteCPlusArray" 'function) (ff-pointer self) ptr))
(shadow "new[]")
(defmethod #.(lispify "new[]" 'method) ((self #.(lispify "bt-generic6-dof-spring-constraint" 'classname)) arg1 ptr)
  (#.(lispify "btGeneric6DofSpringConstraint_makeCPlusArray" 'function) (ff-pointer self) arg1 ptr))
(shadow "delete[]")
(defmethod #.(lispify "delete[]" 'method) ((self #.(lispify "bt-generic6-dof-spring-constraint" 'classname)) arg1 arg2)
  (#.(lispify "btGeneric6DofSpringConstraint_deleteCPlusArray" 'function) (ff-pointer self) arg1 arg2))
(defmethod initialize-instance :after ((obj #.(lispify "bt-generic6-dof-spring-constraint" 'class)) &key (rbA #.(lispify "bt-rigid-body" 'classname)) (rbB #.(lispify "bt-rigid-body" 'classname)) (frameInA #.(lispify "bt-transform" 'classname)) (frameInB #.(lispify "bt-transform" 'classname)) (useLinearReferenceFrameA t))
  (setf (slot-value obj 'ff-pointer) (#.(lispify "new_btGeneric6DofSpringConstraint" 'function) rbA rbB frameInA frameInB useLinearReferenceFrameA)))
(defmethod initialize-instance :after ((obj #.(lispify "bt-generic6-dof-spring-constraint" 'class)) &key (rbB #.(lispify "bt-rigid-body" 'classname)) (frameInB #.(lispify "bt-transform" 'classname)) (useLinearReferenceFrameB t))
  (setf (slot-value obj 'ff-pointer) (#.(lispify "new_btGeneric6DofSpringConstraint" 'function) rbB frameInB useLinearReferenceFrameB)))
(defmethod #.(lispify "enable-spring" 'method) ((self #.(lispify "bt-generic6-dof-spring-constraint" 'classname)) (index integer) (onOff t))
  (#.(lispify "btGeneric6DofSpringConstraint_enableSpring" 'function) (ff-pointer self) index onOff))
(defmethod #.(lispify "set-stiffness" 'method) ((self #.(lispify "bt-generic6-dof-spring-constraint" 'classname)) (index integer) (stiffness number))
  (#.(lispify "btGeneric6DofSpringConstraint_setStiffness" 'function) (ff-pointer self) index stiffness))
(defmethod #.(lispify "set-damping" 'method) ((self #.(lispify "bt-generic6-dof-spring-constraint" 'classname)) (index integer) (damping number))
  (#.(lispify "btGeneric6DofSpringConstraint_setDamping" 'function) (ff-pointer self) index damping))
(defmethod #.(lispify "set-equilibrium-point" 'method) ((self #.(lispify "bt-generic6-dof-spring-constraint" 'classname)))
  (#.(lispify "btGeneric6DofSpringConstraint_setEquilibriumPoint" 'function) (ff-pointer self)))
(defmethod #.(lispify "set-equilibrium-point" 'method) ((self #.(lispify "bt-generic6-dof-spring-constraint" 'classname)) (index integer))
  (#.(lispify "btGeneric6DofSpringConstraint_setEquilibriumPoint" 'function) (ff-pointer self) index))
(defmethod #.(lispify "set-equilibrium-point" 'method) ((self #.(lispify "bt-generic6-dof-spring-constraint" 'classname)) (index integer) (val number))
  (#.(lispify "btGeneric6DofSpringConstraint_setEquilibriumPoint" 'function) (ff-pointer self) index val))
(defmethod #.(lispify "set-axis" 'method) ((self #.(lispify "bt-generic6-dof-spring-constraint" 'classname)) (axis1 #.(lispify "bt-vector3" 'classname)) (axis2 #.(lispify "bt-vector3" 'classname)))
  (#.(lispify "btGeneric6DofSpringConstraint_setAxis" 'function) (ff-pointer self) axis1 axis2))
(defmethod #.(lispify "get-info2" 'method) ((self #.(lispify "bt-generic6-dof-spring-constraint" 'classname)) info)
  (#.(lispify "btGeneric6DofSpringConstraint_getInfo2" 'function) (ff-pointer self) info))
(defmethod #.(lispify "calculate-serialize-buffer-size" 'method) ((self #.(lispify "bt-generic6-dof-spring-constraint" 'classname)))
  (#.(lispify "btGeneric6DofSpringConstraint_calculateSerializeBufferSize" 'function) (ff-pointer self)))

(defmethod #.(lispify "serialize" 'method) ((self #.(lispify "bt-generic6-dof-spring-constraint" 'classname)) dataBuffer (serializer #.(lispify "bt-serializer" 'classname)))
  (#.(lispify "btGeneric6DofSpringConstraint_serialize" 'function) (ff-pointer self) dataBuffer serializer))



(defmethod #.(lispify "new" 'method) ((self #.(lispify "bt-universal-constraint" 'classname)) sizeInBytes)
  (#.(lispify "btUniversalConstraint_makeCPlusPlusInstance" 'function) (ff-pointer self) sizeInBytes))

(defmethod #.(lispify "delete" 'method) ((self #.(lispify "bt-universal-constraint" 'classname)) ptr)
  (#.(lispify "btUniversalConstraint_deleteCPlusPlusInstance" 'function) (ff-pointer self) ptr))

(defmethod #.(lispify "new" 'method) ((self #.(lispify "bt-universal-constraint" 'classname)) arg1 ptr)
  (#.(lispify "btUniversalConstraint_makeCPlusPlusInstance" 'function) (ff-pointer self) arg1 ptr))

(defmethod #.(lispify "delete" 'method) ((self #.(lispify "bt-universal-constraint" 'classname)) arg1 arg2)
  (#.(lispify "btUniversalConstraint_deleteCPlusPlusInstance" 'function) (ff-pointer self) arg1 arg2))

(shadow "new[]")
(defmethod #.(lispify "new[]" 'method) ((self #.(lispify "bt-universal-constraint" 'classname)) sizeInBytes)
  (#.(lispify "btUniversalConstraint_makeCPlusArray" 'function) (ff-pointer self) sizeInBytes))

(shadow "delete[]")
(defmethod #.(lispify "delete[]" 'method) ((self #.(lispify "bt-universal-constraint" 'classname)) ptr)
  (#.(lispify "btUniversalConstraint_deleteCPlusArray" 'function) (ff-pointer self) ptr))

(shadow "new[]")
(defmethod #.(lispify "new[]" 'method) ((self #.(lispify "bt-universal-constraint" 'classname)) arg1 ptr)
  (#.(lispify "btUniversalConstraint_makeCPlusArray" 'function) (ff-pointer self) arg1 ptr))

(shadow "delete[]")
(defmethod #.(lispify "delete[]" 'method) ((self #.(lispify "bt-universal-constraint" 'classname)) arg1 arg2)
  (#.(lispify "btUniversalConstraint_deleteCPlusArray" 'function) (ff-pointer self) arg1 arg2))

(defmethod initialize-instance :after ((obj #.(lispify "bt-universal-constraint" 'class)) &key (rbA #.(lispify "bt-rigid-body" 'classname)) (rbB #.(lispify "bt-rigid-body" 'classname)) (anchor #.(lispify "bt-vector3" 'classname)) (axis1 #.(lispify "bt-vector3" 'classname)) (axis2 #.(lispify "bt-vector3" 'classname)))
  (setf (slot-value obj 'ff-pointer) (#.(lispify "new_btUniversalConstraint" 'function) rbA rbB anchor axis1 axis2)))

(defmethod #.(lispify "get-anchor" 'method) ((self #.(lispify "bt-universal-constraint" 'classname)))
  (#.(lispify "btUniversalConstraint_getAnchor" 'function) (ff-pointer self)))

(defmethod #.(lispify "get-anchor2" 'method) ((self #.(lispify "bt-universal-constraint" 'classname)))
  (#.(lispify "btUniversalConstraint_getAnchor2" 'function) (ff-pointer self)))

(defmethod #.(lispify "get-axis1" 'method) ((self #.(lispify "bt-universal-constraint" 'classname)))
  (#.(lispify "btUniversalConstraint_getAxis1" 'function) (ff-pointer self)))

(defmethod #.(lispify "get-axis2" 'method) ((self #.(lispify "bt-universal-constraint" 'classname)))
  (#.(lispify "btUniversalConstraint_getAxis2" 'function) (ff-pointer self)))

(defmethod #.(lispify "get-angle1" 'method) ((self #.(lispify "bt-universal-constraint" 'classname)))
  (#.(lispify "btUniversalConstraint_getAngle1" 'function) (ff-pointer self)))

(defmethod #.(lispify "get-angle2" 'method) ((self #.(lispify "bt-universal-constraint" 'classname)))
  (#.(lispify "btUniversalConstraint_getAngle2" 'function) (ff-pointer self)))

(defmethod #.(lispify "set-upper-limit" 'method) ((self #.(lispify "bt-universal-constraint" 'classname)) (ang1max number) (ang2max number))
  (#.(lispify "btUniversalConstraint_setUpperLimit" 'function) (ff-pointer self) ang1max ang2max))

(defmethod #.(lispify "set-lower-limit" 'method) ((self #.(lispify "bt-universal-constraint" 'classname)) (ang1min number) (ang2min number))
  (#.(lispify "btUniversalConstraint_setLowerLimit" 'function) (ff-pointer self) ang1min ang2min))

(defmethod #.(lispify "set-axis" 'method) ((self #.(lispify "bt-universal-constraint" 'classname)) (axis1 #.(lispify "bt-vector3" 'classname)) (axis2 #.(lispify "bt-vector3" 'classname)))
  (#.(lispify "btUniversalConstraint_setAxis" 'function) (ff-pointer self) axis1 axis2))



(defmethod #.(lispify "new" 'method) ((self #.(lispify "bt-hinge2-constraint" 'classname)) sizeInBytes)
  (#.(lispify "btHinge2Constraint_makeCPlusPlusInstance" 'function) (ff-pointer self) sizeInBytes))

(defmethod #.(lispify "delete" 'method) ((self #.(lispify "bt-hinge2-constraint" 'classname)) ptr)
  (#.(lispify "btHinge2Constraint_deleteCPlusPlusInstance" 'function) (ff-pointer self) ptr))

(defmethod #.(lispify "new" 'method) ((self #.(lispify "bt-hinge2-constraint" 'classname)) arg1 ptr)
  (#.(lispify "btHinge2Constraint_makeCPlusPlusInstance" 'function) (ff-pointer self) arg1 ptr))

(defmethod #.(lispify "delete" 'method) ((self #.(lispify "bt-hinge2-constraint" 'classname)) arg1 arg2)
  (#.(lispify "btHinge2Constraint_deleteCPlusPlusInstance" 'function) (ff-pointer self) arg1 arg2))

(shadow "new[]")
(defmethod #.(lispify "new[]" 'method) ((self #.(lispify "bt-hinge2-constraint" 'classname)) sizeInBytes)
  (#.(lispify "btHinge2Constraint_makeCPlusArray" 'function) (ff-pointer self) sizeInBytes))

(shadow "delete[]")
(defmethod #.(lispify "delete[]" 'method) ((self #.(lispify "bt-hinge2-constraint" 'classname)) ptr)
  (#.(lispify "btHinge2Constraint_deleteCPlusArray" 'function) (ff-pointer self) ptr))

(shadow "new[]")
(defmethod #.(lispify "new[]" 'method) ((self #.(lispify "bt-hinge2-constraint" 'classname)) arg1 ptr)
  (#.(lispify "btHinge2Constraint_makeCPlusArray" 'function) (ff-pointer self) arg1 ptr))

(shadow "delete[]")
(defmethod #.(lispify "delete[]" 'method) ((self #.(lispify "bt-hinge2-constraint" 'classname)) arg1 arg2)
  (#.(lispify "btHinge2Constraint_deleteCPlusArray" 'function) (ff-pointer self) arg1 arg2))

(defmethod initialize-instance :after ((obj #.(lispify "bt-hinge2-constraint" 'class)) &key (rbA #.(lispify "bt-rigid-body" 'classname)) (rbB #.(lispify "bt-rigid-body" 'classname)) (anchor #.(lispify "bt-vector3" 'classname)) (axis1 #.(lispify "bt-vector3" 'classname)) (axis2 #.(lispify "bt-vector3" 'classname)))
  (setf (slot-value obj 'ff-pointer) (#.(lispify "new_btHinge2Constraint" 'function) rbA rbB anchor axis1 axis2)))

(defmethod #.(lispify "get-anchor" 'method) ((self #.(lispify "bt-hinge2-constraint" 'classname)))
  (#.(lispify "btHinge2Constraint_getAnchor" 'function) (ff-pointer self)))

(defmethod #.(lispify "get-anchor2" 'method) ((self #.(lispify "bt-hinge2-constraint" 'classname)))
  (#.(lispify "btHinge2Constraint_getAnchor2" 'function) (ff-pointer self)))

(defmethod #.(lispify "get-axis1" 'method) ((self #.(lispify "bt-hinge2-constraint" 'classname)))
  (#.(lispify "btHinge2Constraint_getAxis1" 'function) (ff-pointer self)))

(defmethod #.(lispify "get-axis2" 'method) ((self #.(lispify "bt-hinge2-constraint" 'classname)))
  (#.(lispify "btHinge2Constraint_getAxis2" 'function) (ff-pointer self)))

(defmethod #.(lispify "get-angle1" 'method) ((self #.(lispify "bt-hinge2-constraint" 'classname)))
  (#.(lispify "btHinge2Constraint_getAngle1" 'function) (ff-pointer self)))

(defmethod #.(lispify "get-angle2" 'method) ((self #.(lispify "bt-hinge2-constraint" 'classname)))
  (#.(lispify "btHinge2Constraint_getAngle2" 'function) (ff-pointer self)))

(defmethod #.(lispify "set-upper-limit" 'method) ((self #.(lispify "bt-hinge2-constraint" 'classname)) (ang1max number))
  (#.(lispify "btHinge2Constraint_setUpperLimit" 'function) (ff-pointer self) ang1max))

(defmethod #.(lispify "set-lower-limit" 'method) ((self #.(lispify "bt-hinge2-constraint" 'classname)) (ang1min number))
  (#.(lispify "btHinge2Constraint_setLowerLimit" 'function) (ff-pointer self) ang1min))



(defmethod initialize-instance :after ((obj #.(lispify "bt-gear-constraint" 'class)) &key (rbA #.(lispify "bt-rigid-body" 'classname)) (rbB #.(lispify "bt-rigid-body" 'classname)) (axisInA #.(lispify "bt-vector3" 'classname)) (axisInB #.(lispify "bt-vector3" 'classname)) (ratio number))
  (setf (slot-value obj 'ff-pointer) (#.(lispify "new_btGearConstraint" 'function) rbA rbB axisInA axisInB ratio)))

(defmethod initialize-instance :after ((obj #.(lispify "bt-gear-constraint" 'class)) &key (rbA #.(lispify "bt-rigid-body" 'classname)) (rbB #.(lispify "bt-rigid-body" 'classname)) (axisInA #.(lispify "bt-vector3" 'classname)) (axisInB #.(lispify "bt-vector3" 'classname)))
  (setf (slot-value obj 'ff-pointer) (#.(lispify "new_btGearConstraint" 'function) rbA rbB axisInA axisInB)))

(defmethod #.(lispify "get-info1" 'method) ((self #.(lispify "bt-gear-constraint" 'classname)) info)
  (#.(lispify "btGearConstraint_getInfo1" 'function) (ff-pointer self) info))

(defmethod #.(lispify "get-info2" 'method) ((self #.(lispify "bt-gear-constraint" 'classname)) info)
  (#.(lispify "btGearConstraint_getInfo2" 'function) (ff-pointer self) info))

(defmethod #.(lispify "set-axis-a" 'method) ((self #.(lispify "bt-gear-constraint" 'classname)) (axisA #.(lispify "bt-vector3" 'classname)))
  (#.(lispify "btGearConstraint_setAxisA" 'function) (ff-pointer self) axisA))

(defmethod #.(lispify "set-axis-b" 'method) ((self #.(lispify "bt-gear-constraint" 'classname)) (axisB #.(lispify "bt-vector3" 'classname)))
  (#.(lispify "btGearConstraint_setAxisB" 'function) (ff-pointer self) axisB))

(defmethod #.(lispify "set-ratio" 'method) ((self #.(lispify "bt-gear-constraint" 'classname)) (ratio number))
  (#.(lispify "btGearConstraint_setRatio" 'function) (ff-pointer self) ratio))

(defmethod #.(lispify "get-axis-a" 'method) ((self #.(lispify "bt-gear-constraint" 'classname)))
  (#.(lispify "btGearConstraint_getAxisA" 'function) (ff-pointer self)))

(defmethod #.(lispify "get-axis-b" 'method) ((self #.(lispify "bt-gear-constraint" 'classname)))
  (#.(lispify "btGearConstraint_getAxisB" 'function) (ff-pointer self)))

(defmethod #.(lispify "get-ratio" 'method) ((self #.(lispify "bt-gear-constraint" 'classname)))
  (#.(lispify "btGearConstraint_getRatio" 'function) (ff-pointer self)))

(defmethod #.(lispify "calculate-serialize-buffer-size" 'method) ((self #.(lispify "bt-gear-constraint" 'classname)))
  (#.(lispify "btGearConstraint_calculateSerializeBufferSize" 'function) (ff-pointer self)))

(defmethod #.(lispify "serialize" 'method) ((self #.(lispify "bt-gear-constraint" 'classname)) dataBuffer (serializer #.(lispify "bt-serializer" 'classname)))
  (#.(lispify "btGearConstraint_serialize" 'function) (ff-pointer self) dataBuffer serializer))



(defmethod initialize-instance :after ((obj #.(lispify "bt-fixed-constraint" 'class)) &key (rbA #.(lispify "bt-rigid-body" 'classname)) (rbB #.(lispify "bt-rigid-body" 'classname)) (frameInA #.(lispify "bt-transform" 'classname)) (frameInB #.(lispify "bt-transform" 'classname)))
  (setf (slot-value obj 'ff-pointer) (#.(lispify "new_btFixedConstraint" 'function) rbA rbB frameInA frameInB)))

(defmethod #.(lispify "get-info1" 'method) ((self #.(lispify "bt-fixed-constraint" 'classname)) info)
  (#.(lispify "btFixedConstraint_getInfo1" 'function) (ff-pointer self) info))

(defmethod #.(lispify "get-info2" 'method) ((self #.(lispify "bt-fixed-constraint" 'classname)) info)
           (#.(lispify "btFixedConstraint_getInfo2" 'function) (ff-pointer self) info))



(defmethod #.(lispify "new" 'method) ((self #.(lispify "bt-sequential-impulse-constraint-solver" 'classname)) sizeInBytes)
  (#.(lispify "btSequentialImpulseConstraintSolver_makeCPlusPlusInstance" 'function) (ff-pointer self) sizeInBytes))

(defmethod #.(lispify "delete" 'method) ((self #.(lispify "bt-sequential-impulse-constraint-solver" 'classname)) ptr)
  (#.(lispify "btSequentialImpulseConstraintSolver_deleteCPlusPlusInstance" 'function) (ff-pointer self) ptr))

(defmethod #.(lispify "new" 'method) ((self #.(lispify "bt-sequential-impulse-constraint-solver" 'classname)) arg1 ptr)
  (#.(lispify "btSequentialImpulseConstraintSolver_makeCPlusPlusInstance" 'function) (ff-pointer self) arg1 ptr))

(defmethod #.(lispify "delete" 'method) ((self #.(lispify "bt-sequential-impulse-constraint-solver" 'classname)) arg1 arg2)
  (#.(lispify "btSequentialImpulseConstraintSolver_deleteCPlusPlusInstance" 'function) (ff-pointer self) arg1 arg2))

(shadow "new[]")
(defmethod #.(lispify "new[]" 'method) ((self #.(lispify "bt-sequential-impulse-constraint-solver" 'classname)) sizeInBytes)
  (#.(lispify "btSequentialImpulseConstraintSolver_makeCPlusArray" 'function) (ff-pointer self) sizeInBytes))

(shadow "delete[]")
(defmethod #.(lispify "delete[]" 'method) ((self #.(lispify "bt-sequential-impulse-constraint-solver" 'classname)) ptr)
  (#.(lispify "btSequentialImpulseConstraintSolver_deleteCPlusArray" 'function) (ff-pointer self) ptr))

(shadow "new[]")
(defmethod #.(lispify "new[]" 'method) ((self #.(lispify "bt-sequential-impulse-constraint-solver" 'classname)) arg1 ptr)
  (#.(lispify "btSequentialImpulseConstraintSolver_makeCPlusArray" 'function) (ff-pointer self) arg1 ptr))

(shadow "delete[]")
(defmethod #.(lispify "delete[]" 'method) ((self #.(lispify "bt-sequential-impulse-constraint-solver" 'classname)) arg1 arg2)
  (#.(lispify "btSequentialImpulseConstraintSolver_deleteCPlusArray" 'function) (ff-pointer self) arg1 arg2))

(defmethod initialize-instance :after ((obj #.(lispify "bt-sequential-impulse-constraint-solver" 'class)) &key)
  (setf (slot-value obj 'ff-pointer) (#.(lispify "new_btSequentialImpulseConstraintSolver" 'function))))

(defmethod #.(lispify "solve-group" 'method) ((self #.(lispify "bt-sequential-impulse-constraint-solver" 'classname)) bodies (numBodies integer) manifold (numManifolds integer) constraints (numConstraints integer) info (debugDrawer #.(lispify "bt-idebug-draw" 'classname)) dispatcher)
  (#.(lispify "btSequentialImpulseConstraintSolver_solveGroup" 'function) (ff-pointer self) bodies numBodies manifold numManifolds constraints numConstraints info debugDrawer dispatcher))

(defmethod #.(lispify "reset" 'method) ((self #.(lispify "bt-sequential-impulse-constraint-solver" 'classname)))
  (#.(lispify "btSequentialImpulseConstraintSolver_reset" 'function) (ff-pointer self)))

(defmethod #.(lispify "bt-rand2" 'method) ((self #.(lispify "bt-sequential-impulse-constraint-solver" 'classname)))
  (#.(lispify "btSequentialImpulseConstraintSolver_btRand2" 'function) (ff-pointer self)))

(defmethod #.(lispify "bt-rand-int2" 'method) ((self #.(lispify "bt-sequential-impulse-constraint-solver" 'classname)) (n integer))
  (#.(lispify "btSequentialImpulseConstraintSolver_btRandInt2" 'function) (ff-pointer self) n))

(defmethod #.(lispify "set-rand-seed" 'method) ((self #.(lispify "bt-sequential-impulse-constraint-solver" 'classname)) (seed integer))
  (#.(lispify "btSequentialImpulseConstraintSolver_setRandSeed" 'function) (ff-pointer self) seed))

(defmethod #.(lispify "get-rand-seed" 'method) ((self #.(lispify "bt-sequential-impulse-constraint-solver" 'classname)))
  (#.(lispify "btSequentialImpulseConstraintSolver_getRandSeed" 'function) (ff-pointer self)))

(defmethod #.(lispify "get-solver-type" 'method) ((self #.(lispify "bt-sequential-impulse-constraint-solver" 'classname)))
           (#.(lispify "btSequentialImpulseConstraintSolver_getSolverType" 'function) (ff-pointer self)))

(format *trace-output* "~&Loading Bullet Physics C libraries: ")
(mapcar (lambda (n)
          (format *trace-output* "Loading ~A…" n)
          (cffi:load-foreign-library
           (merge-pathnames
            (format nil "lib/cl-bullet2l/lib~A.so" n)))
          (format *trace-output* "OK; "))
        '("LinearMath"
          "BulletCollision" "BulletDynamics"
          "BulletSoftBody"
          "cl-bullet2l"))
(format *trace-output* " (Done.) ")

(eval-when (:compile-toplevel)
  (close *compile-trace-output*)
  (setf *compile-trace-output* nil))

