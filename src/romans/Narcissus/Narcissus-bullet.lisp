(in-package #:bullet-physics)

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




(defmethod (setf frames) ((self CONE-TWIST-CONSTRAINT) (frameA transform) (frameB transform))
  (CONE-TWIST-CONSTRAINT/SET-FRAMES (ff-pointer self) frameA frameB))

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

(declaim (inline COLLISION-OBJECT/IS-STATIC-OR-KINEMATIC-OBJECT))

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

(declaim (inline UNIFORM-SCALING-SHAPE/MAKE-CPLUS-ARRAY))

(cffi:defcfun ("_wrap_btUniformScalingShape_makeCPlusArray__SWIG_0" UNIFORM-SCALING-SHAPE/MAKE-CPLUS-ARRAY) :pointer
  (self :pointer)
  (sizeInBytes :pointer))

(export 'UNIFORM-SCALING-SHAPE/MAKE-CPLUS-ARRAY)

(declaim (inline UNIFORM-SCALING-SHAPE/DELETE-CPLUS-ARRAY))

(cffi:defcfun ("_wrap_btUniformScalingShape_deleteCPlusArray__SWIG_0" UNIFORM-SCALING-SHAPE/DELETE-CPLUS-ARRAY) :void
  (self :pointer)
  (ptr :pointer))

(export 'UNIFORM-SCALING-SHAPE/DELETE-CPLUS-ARRAY)

(declaim (inline UNIFORM-SCALING-SHAPE/MAKE-CPLUS-ARRAY))

(cffi:defcfun ("_wrap_btUniformScalingShape_makeCPlusArray__SWIG_1" UNIFORM-SCALING-SHAPE/MAKE-CPLUS-ARRAY) :pointer
  (self :pointer)
  (arg1 :pointer)
  (ptr :pointer))

(export 'UNIFORM-SCALING-SHAPE/MAKE-CPLUS-ARRAY)

(declaim (inline UNIFORM-SCALING-SHAPE/DELETE-CPLUS-ARRAY))

(cffi:defcfun ("_wrap_btUniformScalingShape_deleteCPlusArray__SWIG_1" UNIFORM-SCALING-SHAPE/DELETE-CPLUS-ARRAY) :void
  (self :pointer)
  (arg1 :pointer)
  (arg2 :pointer))

(export 'UNIFORM-SCALING-SHAPE/DELETE-CPLUS-ARRAY)

(declaim (inline MAKE-UNIFORM-SCALING-SHAPE))

(cffi:defcfun ("_wrap_new_btUniformScalingShape" MAKE-UNIFORM-SCALING-SHAPE) :pointer
  (convexChildShape :pointer)
  (uniformScalingFactor :float))

(export 'MAKE-UNIFORM-SCALING-SHAPE)

(declaim (inline DELETE/BT-UNIFORM-SCALING-SHAPE))

(cffi:defcfun ("_wrap_delete_btUniformScalingShape" DELETE/BT-UNIFORM-SCALING-SHAPE) :void
  (self :pointer))

(export 'DELETE/BT-UNIFORM-SCALING-SHAPE)

(declaim (inline UNIFORM-SCALING-SHAPE/LOCAL-GET-SUPPORTING-VERTEX-WITHOUT-MARGIN))

(cffi:defcfun ("_wrap_btUniformScalingShape_localGetSupportingVertexWithoutMargin" UNIFORM-SCALING-SHAPE/LOCAL-GET-SUPPORTING-VERTEX-WITHOUT-MARGIN) :pointer
  (self :pointer)
  (vec :pointer))

(export 'UNIFORM-SCALING-SHAPE/LOCAL-GET-SUPPORTING-VERTEX-WITHOUT-MARGIN)

(declaim (inline UNIFORM-SCALING-SHAPE/LOCAL-GET-SUPPORTING-VERTEX))

(cffi:defcfun ("_wrap_btUniformScalingShape_localGetSupportingVertex" UNIFORM-SCALING-SHAPE/LOCAL-GET-SUPPORTING-VERTEX) :pointer
  (self :pointer)
  (vec :pointer))

(export 'UNIFORM-SCALING-SHAPE/LOCAL-GET-SUPPORTING-VERTEX)

(declaim (inline UNIFORM-SCALING-SHAPE/BATCHED-UNIT-VECTOR-GET-SUPPORTING-VERTEX-WITHOUT-MARGIN))

(cffi:defcfun ("_wrap_btUniformScalingShape_batchedUnitVectorGetSupportingVertexWithoutMargin" UNIFORM-SCALING-SHAPE/BATCHED-UNIT-VECTOR-GET-SUPPORTING-VERTEX-WITHOUT-MARGIN) :void
  (self :pointer)
  (vectors :pointer)
  (supportVerticesOut :pointer)
  (numVectors :int))

(export 'UNIFORM-SCALING-SHAPE/BATCHED-UNIT-VECTOR-GET-SUPPORTING-VERTEX-WITHOUT-MARGIN)

(declaim (inline UNIFORM-SCALING-SHAPE/CALCULATE-LOCAL-INERTIA))

(cffi:defcfun ("_wrap_btUniformScalingShape_calculateLocalInertia" UNIFORM-SCALING-SHAPE/CALCULATE-LOCAL-INERTIA) :void
  (self :pointer)
  (mass :float)
  (inertia :pointer))

(export 'UNIFORM-SCALING-SHAPE/CALCULATE-LOCAL-INERTIA)

(declaim (inline UNIFORM-SCALING-SHAPE/GET-UNIFORM-SCALING-FACTOR))

(cffi:defcfun ("_wrap_btUniformScalingShape_getUniformScalingFactor" UNIFORM-SCALING-SHAPE/GET-UNIFORM-SCALING-FACTOR) :float
  (self :pointer))

(export 'UNIFORM-SCALING-SHAPE/GET-UNIFORM-SCALING-FACTOR)

(declaim (inline UNIFORM-SCALING-SHAPE/GET-CHILD-SHAPE))

(cffi:defcfun ("_wrap_btUniformScalingShape_getChildShape__SWIG_0" UNIFORM-SCALING-SHAPE/GET-CHILD-SHAPE) :pointer
  (self :pointer))

(export 'UNIFORM-SCALING-SHAPE/GET-CHILD-SHAPE)

(declaim (inline UNIFORM-SCALING-SHAPE/GET-CHILD-SHAPE))

(cffi:defcfun ("_wrap_btUniformScalingShape_getChildShape__SWIG_1" UNIFORM-SCALING-SHAPE/GET-CHILD-SHAPE) :pointer
  (self :pointer))

(export 'UNIFORM-SCALING-SHAPE/GET-CHILD-SHAPE)

(declaim (inline UNIFORM-SCALING-SHAPE/GET-NAME))

(cffi:defcfun ("_wrap_btUniformScalingShape_getName" UNIFORM-SCALING-SHAPE/GET-NAME) :string
  (self :pointer))

(export 'UNIFORM-SCALING-SHAPE/GET-NAME)

(declaim (inline UNIFORM-SCALING-SHAPE/GET-AABB))

(cffi:defcfun ("_wrap_btUniformScalingShape_getAabb" UNIFORM-SCALING-SHAPE/GET-AABB) :void
  (self :pointer)
  (t_arg1 :pointer)
  (aabbMin :pointer)
  (aabbMax :pointer))

(export 'UNIFORM-SCALING-SHAPE/GET-AABB)

(declaim (inline UNIFORM-SCALING-SHAPE/GET-AABB-SLOW))

(cffi:defcfun ("_wrap_btUniformScalingShape_getAabbSlow" UNIFORM-SCALING-SHAPE/GET-AABB-SLOW) :void
  (self :pointer)
  (t_arg1 :pointer)
  (aabbMin :pointer)
  (aabbMax :pointer))

(export 'UNIFORM-SCALING-SHAPE/GET-AABB-SLOW)

(declaim (inline UNIFORM-SCALING-SHAPE/SET-LOCAL-SCALING))

(cffi:defcfun ("_wrap_btUniformScalingShape_setLocalScaling" UNIFORM-SCALING-SHAPE/SET-LOCAL-SCALING) :void
  (self :pointer)
  (scaling :pointer))

(export 'UNIFORM-SCALING-SHAPE/SET-LOCAL-SCALING)

(declaim (inline UNIFORM-SCALING-SHAPE/GET-LOCAL-SCALING))

(cffi:defcfun ("_wrap_btUniformScalingShape_getLocalScaling" UNIFORM-SCALING-SHAPE/GET-LOCAL-SCALING) :pointer
  (self :pointer))

(export 'UNIFORM-SCALING-SHAPE/GET-LOCAL-SCALING)

(declaim (inline UNIFORM-SCALING-SHAPE/SET-MARGIN))

(cffi:defcfun ("_wrap_btUniformScalingShape_setMargin" UNIFORM-SCALING-SHAPE/SET-MARGIN) :void
  (self :pointer)
  (margin :float))

(export 'UNIFORM-SCALING-SHAPE/SET-MARGIN)

(declaim (inline UNIFORM-SCALING-SHAPE/GET-MARGIN))

(cffi:defcfun ("_wrap_btUniformScalingShape_getMargin" UNIFORM-SCALING-SHAPE/GET-MARGIN) :float
  (self :pointer))

(export 'UNIFORM-SCALING-SHAPE/GET-MARGIN)

(declaim (inline UNIFORM-SCALING-SHAPE/GET-NUM-PREFERRED-PENETRATION-DIRECTIONS))

(cffi:defcfun ("_wrap_btUniformScalingShape_getNumPreferredPenetrationDirections" UNIFORM-SCALING-SHAPE/GET-NUM-PREFERRED-PENETRATION-DIRECTIONS) :int
  (self :pointer))

(export 'UNIFORM-SCALING-SHAPE/GET-NUM-PREFERRED-PENETRATION-DIRECTIONS)

(declaim (inline UNIFORM-SCALING-SHAPE/GET-PREFERRED-PENETRATION-DIRECTION))

(cffi:defcfun ("_wrap_btUniformScalingShape_getPreferredPenetrationDirection" UNIFORM-SCALING-SHAPE/GET-PREFERRED-PENETRATION-DIRECTION) :void
  (self :pointer)
  (index :int)
  (penetrationVector :pointer))

(export 'UNIFORM-SCALING-SHAPE/GET-PREFERRED-PENETRATION-DIRECTION)

(declaim (inline MAKE-SPHERE-SPHERE-COLLISION-ALGORITHM))

(cffi:defcfun ("_wrap_new_btSphereSphereCollisionAlgorithm__SWIG_0" MAKE-SPHERE-SPHERE-COLLISION-ALGORITHM) :pointer
  (mf :pointer)
  (ci :pointer)
  (col0Wrap :pointer)
  (col1Wrap :pointer))

(export 'MAKE-SPHERE-SPHERE-COLLISION-ALGORITHM)

(declaim (inline MAKE-SPHERE-SPHERE-COLLISION-ALGORITHM))

(cffi:defcfun ("_wrap_new_btSphereSphereCollisionAlgorithm__SWIG_1" MAKE-SPHERE-SPHERE-COLLISION-ALGORITHM) :pointer
  (ci :pointer))

(export 'MAKE-SPHERE-SPHERE-COLLISION-ALGORITHM)

(declaim (inline SPHERE-SPHERE-COLLISION-ALGORITHM/PROCESS-COLLISION))

(cffi:defcfun ("_wrap_btSphereSphereCollisionAlgorithm_processCollision" SPHERE-SPHERE-COLLISION-ALGORITHM/PROCESS-COLLISION) :void
  (self :pointer)
  (body0Wrap :pointer)
  (body1Wrap :pointer)
  (dispatchInfo :pointer)
  (resultOut :pointer))

(export 'SPHERE-SPHERE-COLLISION-ALGORITHM/PROCESS-COLLISION)

(declaim (inline SPHERE-SPHERE-COLLISION-ALGORITHM/CALCULATE-TIME-OF-IMPACT))

(cffi:defcfun ("_wrap_btSphereSphereCollisionAlgorithm_calculateTimeOfImpact" SPHERE-SPHERE-COLLISION-ALGORITHM/CALCULATE-TIME-OF-IMPACT) :float
  (self :pointer)
  (body0 :pointer)
  (body1 :pointer)
  (dispatchInfo :pointer)
  (resultOut :pointer))

(export 'SPHERE-SPHERE-COLLISION-ALGORITHM/CALCULATE-TIME-OF-IMPACT)

(declaim (inline SPHERE-SPHERE-COLLISION-ALGORITHM/GET-ALL-CONTACT-MANIFOLDS))

(cffi:defcfun ("_wrap_btSphereSphereCollisionAlgorithm_getAllContactManifolds" SPHERE-SPHERE-COLLISION-ALGORITHM/GET-ALL-CONTACT-MANIFOLDS) :void
  (self :pointer)
  (manifoldArray :pointer))

(export 'SPHERE-SPHERE-COLLISION-ALGORITHM/GET-ALL-CONTACT-MANIFOLDS)

(declaim (inline DELETE/BT-SPHERE-SPHERE-COLLISION-ALGORITHM))

(cffi:defcfun ("_wrap_delete_btSphereSphereCollisionAlgorithm" DELETE/BT-SPHERE-SPHERE-COLLISION-ALGORITHM) :void
  (self :pointer))

(export 'DELETE/BT-SPHERE-SPHERE-COLLISION-ALGORITHM)

(cffi:defcstruct DEFAULT-COLLISION-CONSTRUCTION-INFO
  (PERSISTENT-MANIFOLD-POOL :pointer)
  (COLLISION-ALGORITHM-POOL :pointer)
  (DEFAULT-MAX-PERSISTENT-MANIFOLD-POOL-SIZE :int)
  (DEFAULT-MAX-COLLISION-ALGORITHM-POOL-SIZE :int)
  (CUSTOM-COLLISION-ALGORITHM-MAX-ELEMENT-SIZE :int)
  (USE-EPA-PENETRATION-ALGORITHM :int))

(export 'DEFAULT-COLLISION-CONSTRUCTION-INFO)

(export 'PERSISTENT-MANIFOLD-POOL)

(export 'COLLISION-ALGORITHM-POOL)

(export 'DEFAULT-MAX-PERSISTENT-MANIFOLD-POOL-SIZE)

(export 'DEFAULT-MAX-COLLISION-ALGORITHM-POOL-SIZE)

(export 'CUSTOM-COLLISION-ALGORITHM-MAX-ELEMENT-SIZE)

(export 'USE-EPA-PENETRATION-ALGORITHM)

(declaim (inline MAKE-DEFAULT-COLLISION-CONFIGURATION))

(cffi:defcfun ("_wrap_new_btDefaultCollisionConfiguration__SWIG_0" MAKE-DEFAULT-COLLISION-CONFIGURATION) :pointer
  (constructionInfo :pointer))

(export 'MAKE-DEFAULT-COLLISION-CONFIGURATION)

(declaim (inline MAKE-DEFAULT-COLLISION-CONFIGURATION))

(cffi:defcfun ("_wrap_new_btDefaultCollisionConfiguration__SWIG_1" MAKE-DEFAULT-COLLISION-CONFIGURATION) :pointer)

(export 'MAKE-DEFAULT-COLLISION-CONFIGURATION)

(declaim (inline DELETE/BT-DEFAULT-COLLISION-CONFIGURATION))

(cffi:defcfun ("_wrap_delete_btDefaultCollisionConfiguration" DELETE/BT-DEFAULT-COLLISION-CONFIGURATION) :void
  (self :pointer))

(export 'DELETE/BT-DEFAULT-COLLISION-CONFIGURATION)

(declaim (inline DEFAULT-COLLISION-CONFIGURATION/GET-PERSISTENT-MANIFOLD-POOL))

(cffi:defcfun ("_wrap_btDefaultCollisionConfiguration_getPersistentManifoldPool" DEFAULT-COLLISION-CONFIGURATION/GET-PERSISTENT-MANIFOLD-POOL) :pointer
  (self :pointer))

(export 'DEFAULT-COLLISION-CONFIGURATION/GET-PERSISTENT-MANIFOLD-POOL)

(declaim (inline DEFAULT-COLLISION-CONFIGURATION/GET-COLLISION-ALGORITHM-POOL))

(cffi:defcfun ("_wrap_btDefaultCollisionConfiguration_getCollisionAlgorithmPool" DEFAULT-COLLISION-CONFIGURATION/GET-COLLISION-ALGORITHM-POOL) :pointer
  (self :pointer))

(export 'DEFAULT-COLLISION-CONFIGURATION/GET-COLLISION-ALGORITHM-POOL)

(declaim (inline DEFAULT-COLLISION-CONFIGURATION/GET-SIMPLEX-SOLVER))

(cffi:defcfun ("_wrap_btDefaultCollisionConfiguration_getSimplexSolver" DEFAULT-COLLISION-CONFIGURATION/GET-SIMPLEX-SOLVER) :pointer
  (self :pointer))

(export 'DEFAULT-COLLISION-CONFIGURATION/GET-SIMPLEX-SOLVER)

(declaim (inline DEFAULT-COLLISION-CONFIGURATION/GET-COLLISION-ALGORITHM-CREATE-FUNC))

(cffi:defcfun ("_wrap_btDefaultCollisionConfiguration_getCollisionAlgorithmCreateFunc" DEFAULT-COLLISION-CONFIGURATION/GET-COLLISION-ALGORITHM-CREATE-FUNC) :pointer
  (self :pointer)
  (proxyType0 :int)
  (proxyType1 :int))

(export 'DEFAULT-COLLISION-CONFIGURATION/GET-COLLISION-ALGORITHM-CREATE-FUNC)

(declaim (inline DEFAULT-COLLISION-CONFIGURATION/SET-CONVEX-CONVEX-MULTIPOINT-ITERATIONS))

(cffi:defcfun ("_wrap_btDefaultCollisionConfiguration_setConvexConvexMultipointIterations__SWIG_0" DEFAULT-COLLISION-CONFIGURATION/SET-CONVEX-CONVEX-MULTIPOINT-ITERATIONS) :void
  (self :pointer)
  (numPerturbationIterations :int)
  (minimumPointsPerturbationThreshold :int))

(export 'DEFAULT-COLLISION-CONFIGURATION/SET-CONVEX-CONVEX-MULTIPOINT-ITERATIONS)

(declaim (inline DEFAULT-COLLISION-CONFIGURATION/SET-CONVEX-CONVEX-MULTIPOINT-ITERATIONS))

(cffi:defcfun ("_wrap_btDefaultCollisionConfiguration_setConvexConvexMultipointIterations__SWIG_1" DEFAULT-COLLISION-CONFIGURATION/SET-CONVEX-CONVEX-MULTIPOINT-ITERATIONS) :void
  (self :pointer)
  (numPerturbationIterations :int))

(export 'DEFAULT-COLLISION-CONFIGURATION/SET-CONVEX-CONVEX-MULTIPOINT-ITERATIONS)

(declaim (inline DEFAULT-COLLISION-CONFIGURATION/SET-CONVEX-CONVEX-MULTIPOINT-ITERATIONS))

(cffi:defcfun ("_wrap_btDefaultCollisionConfiguration_setConvexConvexMultipointIterations__SWIG_2" DEFAULT-COLLISION-CONFIGURATION/SET-CONVEX-CONVEX-MULTIPOINT-ITERATIONS) :void
  (self :pointer))

(export 'DEFAULT-COLLISION-CONFIGURATION/SET-CONVEX-CONVEX-MULTIPOINT-ITERATIONS)

(declaim (inline DEFAULT-COLLISION-CONFIGURATION/SET-PLANE-CONVEX-MULTIPOINT-ITERATIONS))

(cffi:defcfun ("_wrap_btDefaultCollisionConfiguration_setPlaneConvexMultipointIterations__SWIG_0" DEFAULT-COLLISION-CONFIGURATION/SET-PLANE-CONVEX-MULTIPOINT-ITERATIONS) :void
  (self :pointer)
  (numPerturbationIterations :int)
  (minimumPointsPerturbationThreshold :int))

(export 'DEFAULT-COLLISION-CONFIGURATION/SET-PLANE-CONVEX-MULTIPOINT-ITERATIONS)

(declaim (inline DEFAULT-COLLISION-CONFIGURATION/SET-PLANE-CONVEX-MULTIPOINT-ITERATIONS))

(cffi:defcfun ("_wrap_btDefaultCollisionConfiguration_setPlaneConvexMultipointIterations__SWIG_1" DEFAULT-COLLISION-CONFIGURATION/SET-PLANE-CONVEX-MULTIPOINT-ITERATIONS) :void
  (self :pointer)
  (numPerturbationIterations :int))

(export 'DEFAULT-COLLISION-CONFIGURATION/SET-PLANE-CONVEX-MULTIPOINT-ITERATIONS)

(declaim (inline DEFAULT-COLLISION-CONFIGURATION/SET-PLANE-CONVEX-MULTIPOINT-ITERATIONS))

(cffi:defcfun ("_wrap_btDefaultCollisionConfiguration_setPlaneConvexMultipointIterations__SWIG_2" DEFAULT-COLLISION-CONFIGURATION/SET-PLANE-CONVEX-MULTIPOINT-ITERATIONS) :void
  (self :pointer))

(export 'DEFAULT-COLLISION-CONFIGURATION/SET-PLANE-CONVEX-MULTIPOINT-ITERATIONS)

(define-constant +USE-DISPATCH-REGISTRY-ARRAY+ 1)

(export '+USE-DISPATCH-REGISTRY-ARRAY+)

(cffi:defcenum DISPATCHER-FLAGS
  (:CD-STATIC-STATIC-REPORTED #.1)
  (:CD-USE-RELATIVE-CONTACT-BREAKING-THRESHOLD #.2)
  (:CD-DISABLE-CONTACTPOOL-DYNAMIC-ALLOCATION #.4))

(export 'DISPATCHER-FLAGS)

(declaim (inline COLLISION-DISPATCHER/GET-DISPATCHER-FLAGS))

(cffi:defcfun ("_wrap_btCollisionDispatcher_getDispatcherFlags" COLLISION-DISPATCHER/GET-DISPATCHER-FLAGS) :int
  (self :pointer))

(export 'COLLISION-DISPATCHER/GET-DISPATCHER-FLAGS)

(declaim (inline COLLISION-DISPATCHER/SET-DISPATCHER-FLAGS))

(cffi:defcfun ("_wrap_btCollisionDispatcher_setDispatcherFlags" COLLISION-DISPATCHER/SET-DISPATCHER-FLAGS) :void
  (self :pointer)
  (flags :int))

(export 'COLLISION-DISPATCHER/SET-DISPATCHER-FLAGS)

(declaim (inline COLLISION-DISPATCHER/REGISTER-COLLISION-CREATE-FUNC))

(cffi:defcfun ("_wrap_btCollisionDispatcher_registerCollisionCreateFunc" COLLISION-DISPATCHER/REGISTER-COLLISION-CREATE-FUNC) :void
  (self :pointer)
  (proxyType0 :int)
  (proxyType1 :int)
  (createFunc :pointer))

(export 'COLLISION-DISPATCHER/REGISTER-COLLISION-CREATE-FUNC)

(declaim (inline COLLISION-DISPATCHER/GET-NUM-MANIFOLDS))

(cffi:defcfun ("_wrap_btCollisionDispatcher_getNumManifolds" COLLISION-DISPATCHER/GET-NUM-MANIFOLDS) :int
  (self :pointer))

(export 'COLLISION-DISPATCHER/GET-NUM-MANIFOLDS)

(declaim (inline COLLISION-DISPATCHER/GET-INTERNAL-MANIFOLD-POINTER))

(cffi:defcfun ("_wrap_btCollisionDispatcher_getInternalManifoldPointer" COLLISION-DISPATCHER/GET-INTERNAL-MANIFOLD-POINTER) :pointer
  (self :pointer))

(export 'COLLISION-DISPATCHER/GET-INTERNAL-MANIFOLD-POINTER)

(declaim (inline COLLISION-DISPATCHER/GET-MANIFOLD-BY-INDEX-INTERNAL))

(cffi:defcfun ("_wrap_btCollisionDispatcher_getManifoldByIndexInternal__SWIG_0" COLLISION-DISPATCHER/GET-MANIFOLD-BY-INDEX-INTERNAL) :pointer
  (self :pointer)
  (index :int))

(export 'COLLISION-DISPATCHER/GET-MANIFOLD-BY-INDEX-INTERNAL)

(declaim (inline COLLISION-DISPATCHER/GET-MANIFOLD-BY-INDEX-INTERNAL))

(cffi:defcfun ("_wrap_btCollisionDispatcher_getManifoldByIndexInternal__SWIG_1" COLLISION-DISPATCHER/GET-MANIFOLD-BY-INDEX-INTERNAL) :pointer
  (self :pointer)
  (index :int))

(export 'COLLISION-DISPATCHER/GET-MANIFOLD-BY-INDEX-INTERNAL)

(declaim (inline MAKE-COLLISION-DISPATCHER))

(cffi:defcfun ("_wrap_new_btCollisionDispatcher" MAKE-COLLISION-DISPATCHER) :pointer
  (collisionConfiguration :pointer))

(export 'MAKE-COLLISION-DISPATCHER)

(declaim (inline DELETE/BT-COLLISION-DISPATCHER))

(cffi:defcfun ("_wrap_delete_btCollisionDispatcher" DELETE/BT-COLLISION-DISPATCHER) :void
  (self :pointer))

(export 'DELETE/BT-COLLISION-DISPATCHER)

(declaim (inline COLLISION-DISPATCHER/GET-NEW-MANIFOLD))

(cffi:defcfun ("_wrap_btCollisionDispatcher_getNewManifold" COLLISION-DISPATCHER/GET-NEW-MANIFOLD) :pointer
  (self :pointer)
  (b0 :pointer)
  (b1 :pointer))

(export 'COLLISION-DISPATCHER/GET-NEW-MANIFOLD)

(declaim (inline COLLISION-DISPATCHER/RELEASE-MANIFOLD))

(cffi:defcfun ("_wrap_btCollisionDispatcher_releaseManifold" COLLISION-DISPATCHER/RELEASE-MANIFOLD) :void
  (self :pointer)
  (manifold :pointer))

(export 'COLLISION-DISPATCHER/RELEASE-MANIFOLD)

(declaim (inline COLLISION-DISPATCHER/CLEAR-MANIFOLD))

(cffi:defcfun ("_wrap_btCollisionDispatcher_clearManifold" COLLISION-DISPATCHER/CLEAR-MANIFOLD) :void
  (self :pointer)
  (manifold :pointer))

(export 'COLLISION-DISPATCHER/CLEAR-MANIFOLD)

(declaim (inline COLLISION-DISPATCHER/FIND-ALGORITHM))

(cffi:defcfun ("_wrap_btCollisionDispatcher_findAlgorithm__SWIG_0" COLLISION-DISPATCHER/FIND-ALGORITHM) :pointer
  (self :pointer)
  (body0Wrap :pointer)
  (body1Wrap :pointer)
  (sharedManifold :pointer))

(export 'COLLISION-DISPATCHER/FIND-ALGORITHM)

(declaim (inline COLLISION-DISPATCHER/FIND-ALGORITHM))

(cffi:defcfun ("_wrap_btCollisionDispatcher_findAlgorithm__SWIG_1" COLLISION-DISPATCHER/FIND-ALGORITHM) :pointer
  (self :pointer)
  (body0Wrap :pointer)
  (body1Wrap :pointer))

(export 'COLLISION-DISPATCHER/FIND-ALGORITHM)

(declaim (inline COLLISION-DISPATCHER/NEEDS-COLLISION))

(cffi:defcfun ("_wrap_btCollisionDispatcher_needsCollision" COLLISION-DISPATCHER/NEEDS-COLLISION) :pointer
  (self :pointer)
  (body0 :pointer)
  (body1 :pointer))

(export 'COLLISION-DISPATCHER/NEEDS-COLLISION)

(declaim (inline COLLISION-DISPATCHER/NEEDS-RESPONSE))

(cffi:defcfun ("_wrap_btCollisionDispatcher_needsResponse" COLLISION-DISPATCHER/NEEDS-RESPONSE) :pointer
  (self :pointer)
  (body0 :pointer)
  (body1 :pointer))

(export 'COLLISION-DISPATCHER/NEEDS-RESPONSE)

(declaim (inline COLLISION-DISPATCHER/DISPATCH-ALL-COLLISION-PAIRS))

(cffi:defcfun ("_wrap_btCollisionDispatcher_dispatchAllCollisionPairs" COLLISION-DISPATCHER/DISPATCH-ALL-COLLISION-PAIRS) :void
  (self :pointer)
  (pairCache :pointer)
  (dispatchInfo :pointer)
  (dispatcher :pointer))

(export 'COLLISION-DISPATCHER/DISPATCH-ALL-COLLISION-PAIRS)

(declaim (inline COLLISION-DISPATCHER/SET-NEAR-CALLBACK))

(cffi:defcfun ("_wrap_btCollisionDispatcher_setNearCallback" COLLISION-DISPATCHER/SET-NEAR-CALLBACK) :void
  (self :pointer)
  (nearCallback :pointer))

(export 'COLLISION-DISPATCHER/SET-NEAR-CALLBACK)

(declaim (inline COLLISION-DISPATCHER/GET-NEAR-CALLBACK))

(cffi:defcfun ("_wrap_btCollisionDispatcher_getNearCallback" COLLISION-DISPATCHER/GET-NEAR-CALLBACK) :pointer
  (self :pointer))

(export 'COLLISION-DISPATCHER/GET-NEAR-CALLBACK)

(declaim (inline COLLISION-DISPATCHER/DEFAULT-NEAR-CALLBACK))

(cffi:defcfun ("_wrap_btCollisionDispatcher_defaultNearCallback" COLLISION-DISPATCHER/DEFAULT-NEAR-CALLBACK) :void
  (collisionPair :pointer)
  (dispatcher :pointer)
  (dispatchInfo :pointer))

(export 'COLLISION-DISPATCHER/DEFAULT-NEAR-CALLBACK)

(declaim (inline COLLISION-DISPATCHER/ALLOCATE-COLLISION-ALGORITHM))

(cffi:defcfun ("_wrap_btCollisionDispatcher_allocateCollisionAlgorithm" COLLISION-DISPATCHER/ALLOCATE-COLLISION-ALGORITHM) :pointer
  (self :pointer)
  (size :int))

(export 'COLLISION-DISPATCHER/ALLOCATE-COLLISION-ALGORITHM)

(declaim (inline COLLISION-DISPATCHER/FREE-COLLISION-ALGORITHM))

(cffi:defcfun ("_wrap_btCollisionDispatcher_freeCollisionAlgorithm" COLLISION-DISPATCHER/FREE-COLLISION-ALGORITHM) :void
  (self :pointer)
  (ptr :pointer))

(export 'COLLISION-DISPATCHER/FREE-COLLISION-ALGORITHM)

(declaim (inline COLLISION-DISPATCHER/GET-COLLISION-CONFIGURATION))

(cffi:defcfun ("_wrap_btCollisionDispatcher_getCollisionConfiguration__SWIG_0" COLLISION-DISPATCHER/GET-COLLISION-CONFIGURATION) :pointer
  (self :pointer))

(export 'COLLISION-DISPATCHER/GET-COLLISION-CONFIGURATION)

(declaim (inline COLLISION-DISPATCHER/GET-COLLISION-CONFIGURATION))

(cffi:defcfun ("_wrap_btCollisionDispatcher_getCollisionConfiguration__SWIG_1" COLLISION-DISPATCHER/GET-COLLISION-CONFIGURATION) :pointer
  (self :pointer))

(export 'COLLISION-DISPATCHER/GET-COLLISION-CONFIGURATION)

(declaim (inline COLLISION-DISPATCHER/SET-COLLISION-CONFIGURATION))

(cffi:defcfun ("_wrap_btCollisionDispatcher_setCollisionConfiguration" COLLISION-DISPATCHER/SET-COLLISION-CONFIGURATION) :void
  (self :pointer)
  (config :pointer))

(export 'COLLISION-DISPATCHER/SET-COLLISION-CONFIGURATION)

(declaim (inline COLLISION-DISPATCHER/GET-INTERNAL-MANIFOLD-POOL))

(cffi:defcfun ("_wrap_btCollisionDispatcher_getInternalManifoldPool__SWIG_0" COLLISION-DISPATCHER/GET-INTERNAL-MANIFOLD-POOL) :pointer
  (self :pointer))

(export 'COLLISION-DISPATCHER/GET-INTERNAL-MANIFOLD-POOL)

(declaim (inline COLLISION-DISPATCHER/GET-INTERNAL-MANIFOLD-POOL))

(cffi:defcfun ("_wrap_btCollisionDispatcher_getInternalManifoldPool__SWIG_1" COLLISION-DISPATCHER/GET-INTERNAL-MANIFOLD-POOL) :pointer
  (self :pointer))

(export 'COLLISION-DISPATCHER/GET-INTERNAL-MANIFOLD-POOL)

(cffi:defcstruct SIMPLE-BROADPHASE-PROXY
  (NEXT-FREE :int)
  (SET-NEXT-FREE :pointer)
  (GET-NEXT-FREE :pointer))

(export 'SIMPLE-BROADPHASE-PROXY)

(export 'NEXT-FREE)

(export 'SET-NEXT-FREE)

(export 'GET-NEXT-FREE)

(declaim (inline MAKE-SIMPLE-BROADPHASE))

(cffi:defcfun ("_wrap_new_btSimpleBroadphase__SWIG_0" MAKE-SIMPLE-BROADPHASE) :pointer
  (maxProxies :int)
  (overlappingPairCache :pointer))

(export 'MAKE-SIMPLE-BROADPHASE)

(declaim (inline MAKE-SIMPLE-BROADPHASE))

(cffi:defcfun ("_wrap_new_btSimpleBroadphase__SWIG_1" MAKE-SIMPLE-BROADPHASE) :pointer
  (maxProxies :int))

(export 'MAKE-SIMPLE-BROADPHASE)

(declaim (inline MAKE-SIMPLE-BROADPHASE))

(cffi:defcfun ("_wrap_new_btSimpleBroadphase__SWIG_2" MAKE-SIMPLE-BROADPHASE) :pointer)

(export 'MAKE-SIMPLE-BROADPHASE)

(declaim (inline DELETE/BT-SIMPLE-BROADPHASE))

(cffi:defcfun ("_wrap_delete_btSimpleBroadphase" DELETE/BT-SIMPLE-BROADPHASE) :void
  (self :pointer))

(export 'DELETE/BT-SIMPLE-BROADPHASE)

(declaim (inline SIMPLE-BROADPHASE/AABB-OVERLAP))

(cffi:defcfun ("_wrap_btSimpleBroadphase_aabbOverlap" SIMPLE-BROADPHASE/AABB-OVERLAP) :pointer
  (proxy0 :pointer)
  (proxy1 :pointer))

(export 'SIMPLE-BROADPHASE/AABB-OVERLAP)

(declaim (inline SIMPLE-BROADPHASE/CREATE-PROXY))

(cffi:defcfun ("_wrap_btSimpleBroadphase_createProxy" SIMPLE-BROADPHASE/CREATE-PROXY) :pointer
  (self :pointer)
  (aabbMin :pointer)
  (aabbMax :pointer)
  (shapeType :int)
  (userPtr :pointer)
  (collisionFilterGroup :short)
  (collisionFilterMask :short)
  (dispatcher :pointer)
  (multiSapProxy :pointer))

(export 'SIMPLE-BROADPHASE/CREATE-PROXY)

(declaim (inline SIMPLE-BROADPHASE/CALCULATE-OVERLAPPING-PAIRS))

(cffi:defcfun ("_wrap_btSimpleBroadphase_calculateOverlappingPairs" SIMPLE-BROADPHASE/CALCULATE-OVERLAPPING-PAIRS) :void
  (self :pointer)
  (dispatcher :pointer))

(export 'SIMPLE-BROADPHASE/CALCULATE-OVERLAPPING-PAIRS)

(declaim (inline SIMPLE-BROADPHASE/DESTROY-PROXY))

(cffi:defcfun ("_wrap_btSimpleBroadphase_destroyProxy" SIMPLE-BROADPHASE/DESTROY-PROXY) :void
  (self :pointer)
  (proxy :pointer)
  (dispatcher :pointer))

(export 'SIMPLE-BROADPHASE/DESTROY-PROXY)

(declaim (inline SIMPLE-BROADPHASE/SET-AABB))

(cffi:defcfun ("_wrap_btSimpleBroadphase_setAabb" SIMPLE-BROADPHASE/SET-AABB) :void
  (self :pointer)
  (proxy :pointer)
  (aabbMin :pointer)
  (aabbMax :pointer)
  (dispatcher :pointer))

(export 'SIMPLE-BROADPHASE/SET-AABB)

(declaim (inline SIMPLE-BROADPHASE/GET-AABB))

(cffi:defcfun ("_wrap_btSimpleBroadphase_getAabb" SIMPLE-BROADPHASE/GET-AABB) :void
  (self :pointer)
  (proxy :pointer)
  (aabbMin :pointer)
  (aabbMax :pointer))

(export 'SIMPLE-BROADPHASE/GET-AABB)

(declaim (inline SIMPLE-BROADPHASE/RAY-TEST))

(cffi:defcfun ("_wrap_btSimpleBroadphase_rayTest__SWIG_0" SIMPLE-BROADPHASE/RAY-TEST) :void
  (self :pointer)
  (rayFrom :pointer)
  (rayTo :pointer)
  (rayCallback :pointer)
  (aabbMin :pointer)
  (aabbMax :pointer))

(export 'SIMPLE-BROADPHASE/RAY-TEST)

(declaim (inline SIMPLE-BROADPHASE/RAY-TEST))

(cffi:defcfun ("_wrap_btSimpleBroadphase_rayTest__SWIG_1" SIMPLE-BROADPHASE/RAY-TEST) :void
  (self :pointer)
  (rayFrom :pointer)
  (rayTo :pointer)
  (rayCallback :pointer)
  (aabbMin :pointer))

(export 'SIMPLE-BROADPHASE/RAY-TEST)

(declaim (inline SIMPLE-BROADPHASE/RAY-TEST))

(cffi:defcfun ("_wrap_btSimpleBroadphase_rayTest__SWIG_2" SIMPLE-BROADPHASE/RAY-TEST) :void
  (self :pointer)
  (rayFrom :pointer)
  (rayTo :pointer)
  (rayCallback :pointer))

(export 'SIMPLE-BROADPHASE/RAY-TEST)

(declaim (inline SIMPLE-BROADPHASE/AABB-TEST))

(cffi:defcfun ("_wrap_btSimpleBroadphase_aabbTest" SIMPLE-BROADPHASE/AABB-TEST) :void
  (self :pointer)
  (aabbMin :pointer)
  (aabbMax :pointer)
  (callback :pointer))

(export 'SIMPLE-BROADPHASE/AABB-TEST)

(declaim (inline SIMPLE-BROADPHASE/GET-OVERLAPPING-PAIR-CACHE))

(cffi:defcfun ("_wrap_btSimpleBroadphase_getOverlappingPairCache__SWIG_0" SIMPLE-BROADPHASE/GET-OVERLAPPING-PAIR-CACHE) :pointer
  (self :pointer))

(export 'SIMPLE-BROADPHASE/GET-OVERLAPPING-PAIR-CACHE)

(declaim (inline SIMPLE-BROADPHASE/GET-OVERLAPPING-PAIR-CACHE))

(cffi:defcfun ("_wrap_btSimpleBroadphase_getOverlappingPairCache__SWIG_1" SIMPLE-BROADPHASE/GET-OVERLAPPING-PAIR-CACHE) :pointer
  (self :pointer))

(export 'SIMPLE-BROADPHASE/GET-OVERLAPPING-PAIR-CACHE)

(declaim (inline SIMPLE-BROADPHASE/TEST-AABB-OVERLAP))

(cffi:defcfun ("_wrap_btSimpleBroadphase_testAabbOverlap" SIMPLE-BROADPHASE/TEST-AABB-OVERLAP) :pointer
  (self :pointer)
  (proxy0 :pointer)
  (proxy1 :pointer))

(export 'SIMPLE-BROADPHASE/TEST-AABB-OVERLAP)

(declaim (inline SIMPLE-BROADPHASE/GET-BROADPHASE-AABB))

(cffi:defcfun ("_wrap_btSimpleBroadphase_getBroadphaseAabb" SIMPLE-BROADPHASE/GET-BROADPHASE-AABB) :void
  (self :pointer)
  (aabbMin :pointer)
  (aabbMax :pointer))

(export 'SIMPLE-BROADPHASE/GET-BROADPHASE-AABB)

(declaim (inline SIMPLE-BROADPHASE/PRINT-STATS))

(cffi:defcfun ("_wrap_btSimpleBroadphase_printStats" SIMPLE-BROADPHASE/PRINT-STATS) :void
  (self :pointer))

(export 'SIMPLE-BROADPHASE/PRINT-STATS)

(define-constant +USE-OVERLAP-TEST-ON-REMOVES+ 1)

(export '+USE-OVERLAP-TEST-ON-REMOVES+)

(cffi:defcvar ("gOverlappingPairs" *OVERLAPPING-PAIRS*)
 :int)

(export '*OVERLAPPING-PAIRS*)

(declaim (inline MAKE-AXIS-SWEEP-3))

(cffi:defcfun ("_wrap_new_btAxisSweep3__SWIG_0" MAKE-AXIS-SWEEP-3) :pointer
  (worldAabbMin :pointer)
  (worldAabbMax :pointer)
  (maxHandles :unsigned-short)
  (pairCache :pointer)
  (disableRaycastAccelerator :pointer))

(export 'MAKE-AXIS-SWEEP-3)

(declaim (inline MAKE-AXIS-SWEEP-3))

(cffi:defcfun ("_wrap_new_btAxisSweep3__SWIG_1" MAKE-AXIS-SWEEP-3) :pointer
  (worldAabbMin :pointer)
  (worldAabbMax :pointer)
  (maxHandles :unsigned-short)
  (pairCache :pointer))

(export 'MAKE-AXIS-SWEEP-3)

(declaim (inline MAKE-AXIS-SWEEP-3))

(cffi:defcfun ("_wrap_new_btAxisSweep3__SWIG_2" MAKE-AXIS-SWEEP-3) :pointer
  (worldAabbMin :pointer)
  (worldAabbMax :pointer)
  (maxHandles :unsigned-short))

(export 'MAKE-AXIS-SWEEP-3)

(declaim (inline MAKE-AXIS-SWEEP-3))

(cffi:defcfun ("_wrap_new_btAxisSweep3__SWIG_3" MAKE-AXIS-SWEEP-3) :pointer
  (worldAabbMin :pointer)
  (worldAabbMax :pointer))

(export 'MAKE-AXIS-SWEEP-3)

(declaim (inline DELETE/BT-AXIS-SWEEP-3))

(cffi:defcfun ("_wrap_delete_btAxisSweep3" DELETE/BT-AXIS-SWEEP-3) :void
  (self :pointer))

(export 'DELETE/BT-AXIS-SWEEP-3)

(declaim (inline MAKE-32-BIT-AXIS-SWEEP-3))

(cffi:defcfun ("_wrap_new_bt32BitAxisSweep3__SWIG_0" MAKE-32-BIT-AXIS-SWEEP-3) :pointer
  (worldAabbMin :pointer)
  (worldAabbMax :pointer)
  (maxHandles :unsigned-int)
  (pairCache :pointer)
  (disableRaycastAccelerator :pointer))

(export 'MAKE-32-BIT-AXIS-SWEEP-3)

(declaim (inline MAKE-32-BIT-AXIS-SWEEP-3))

(cffi:defcfun ("_wrap_new_bt32BitAxisSweep3__SWIG_1" MAKE-32-BIT-AXIS-SWEEP-3) :pointer
  (worldAabbMin :pointer)
  (worldAabbMax :pointer)
  (maxHandles :unsigned-int)
  (pairCache :pointer))

(export 'MAKE-32-BIT-AXIS-SWEEP-3)

(declaim (inline MAKE-32-BIT-AXIS-SWEEP-3))

(cffi:defcfun ("_wrap_new_bt32BitAxisSweep3__SWIG_2" MAKE-32-BIT-AXIS-SWEEP-3) :pointer
  (worldAabbMin :pointer)
  (worldAabbMax :pointer)
  (maxHandles :unsigned-int))

(export 'MAKE-32-BIT-AXIS-SWEEP-3)

(declaim (inline MAKE-32-BIT-AXIS-SWEEP-3))

(cffi:defcfun ("_wrap_new_bt32BitAxisSweep3__SWIG_3" MAKE-32-BIT-AXIS-SWEEP-3) :pointer
  (worldAabbMin :pointer)
  (worldAabbMax :pointer))

(export 'MAKE-32-BIT-AXIS-SWEEP-3)

(declaim (inline DELETE/BT-32-BIT-AXIS-SWEEP-3))

(cffi:defcfun ("_wrap_delete_bt32BitAxisSweep3" DELETE/BT-32-BIT-AXIS-SWEEP-3) :void
  (self :pointer))

(export 'DELETE/BT-32-BIT-AXIS-SWEEP-3)

(declaim (inline MULTI-SAP-BROADPHASE/GET-BROADPHASE-ARRAY))

(cffi:defcfun ("_wrap_btMultiSapBroadphase_getBroadphaseArray__SWIG_0" MULTI-SAP-BROADPHASE/GET-BROADPHASE-ARRAY) :pointer
  (self :pointer))

(export 'MULTI-SAP-BROADPHASE/GET-BROADPHASE-ARRAY)

(declaim (inline MULTI-SAP-BROADPHASE/GET-BROADPHASE-ARRAY))

(cffi:defcfun ("_wrap_btMultiSapBroadphase_getBroadphaseArray__SWIG_1" MULTI-SAP-BROADPHASE/GET-BROADPHASE-ARRAY) :pointer
  (self :pointer))

(export 'MULTI-SAP-BROADPHASE/GET-BROADPHASE-ARRAY)

(declaim (inline DELETE/BT-MULTI-SAP-BROADPHASE))

(cffi:defcfun ("_wrap_delete_btMultiSapBroadphase" DELETE/BT-MULTI-SAP-BROADPHASE) :void
  (self :pointer))

(export 'DELETE/BT-MULTI-SAP-BROADPHASE)

(declaim (inline MULTI-SAP-BROADPHASE/CREATE-PROXY))

(cffi:defcfun ("_wrap_btMultiSapBroadphase_createProxy" MULTI-SAP-BROADPHASE/CREATE-PROXY) :pointer
  (self :pointer)
  (aabbMin :pointer)
  (aabbMax :pointer)
  (shapeType :int)
  (userPtr :pointer)
  (collisionFilterGroup :short)
  (collisionFilterMask :short)
  (dispatcher :pointer)
  (multiSapProxy :pointer))

(export 'MULTI-SAP-BROADPHASE/CREATE-PROXY)

(declaim (inline MULTI-SAP-BROADPHASE/DESTROY-PROXY))

(cffi:defcfun ("_wrap_btMultiSapBroadphase_destroyProxy" MULTI-SAP-BROADPHASE/DESTROY-PROXY) :void
  (self :pointer)
  (proxy :pointer)
  (dispatcher :pointer))

(export 'MULTI-SAP-BROADPHASE/DESTROY-PROXY)

(declaim (inline MULTI-SAP-BROADPHASE/SET-AABB))

(cffi:defcfun ("_wrap_btMultiSapBroadphase_setAabb" MULTI-SAP-BROADPHASE/SET-AABB) :void
  (self :pointer)
  (proxy :pointer)
  (aabbMin :pointer)
  (aabbMax :pointer)
  (dispatcher :pointer))

(export 'MULTI-SAP-BROADPHASE/SET-AABB)

(declaim (inline MULTI-SAP-BROADPHASE/GET-AABB))

(cffi:defcfun ("_wrap_btMultiSapBroadphase_getAabb" MULTI-SAP-BROADPHASE/GET-AABB) :void
  (self :pointer)
  (proxy :pointer)
  (aabbMin :pointer)
  (aabbMax :pointer))

(export 'MULTI-SAP-BROADPHASE/GET-AABB)

(declaim (inline MULTI-SAP-BROADPHASE/RAY-TEST))

(cffi:defcfun ("_wrap_btMultiSapBroadphase_rayTest__SWIG_0" MULTI-SAP-BROADPHASE/RAY-TEST) :void
  (self :pointer)
  (rayFrom :pointer)
  (rayTo :pointer)
  (rayCallback :pointer)
  (aabbMin :pointer)
  (aabbMax :pointer))

(export 'MULTI-SAP-BROADPHASE/RAY-TEST)

(declaim (inline MULTI-SAP-BROADPHASE/RAY-TEST))

(cffi:defcfun ("_wrap_btMultiSapBroadphase_rayTest__SWIG_1" MULTI-SAP-BROADPHASE/RAY-TEST) :void
  (self :pointer)
  (rayFrom :pointer)
  (rayTo :pointer)
  (rayCallback :pointer)
  (aabbMin :pointer))

(export 'MULTI-SAP-BROADPHASE/RAY-TEST)

(declaim (inline MULTI-SAP-BROADPHASE/RAY-TEST))

(cffi:defcfun ("_wrap_btMultiSapBroadphase_rayTest__SWIG_2" MULTI-SAP-BROADPHASE/RAY-TEST) :void
  (self :pointer)
  (rayFrom :pointer)
  (rayTo :pointer)
  (rayCallback :pointer))

(export 'MULTI-SAP-BROADPHASE/RAY-TEST)

(declaim (inline MULTI-SAP-BROADPHASE/ADD-TO-CHILD-BROADPHASE))

(cffi:defcfun ("_wrap_btMultiSapBroadphase_addToChildBroadphase" MULTI-SAP-BROADPHASE/ADD-TO-CHILD-BROADPHASE) :void
  (self :pointer)
  (parentMultiSapProxy :pointer)
  (childProxy :pointer)
  (childBroadphase :pointer))

(export 'MULTI-SAP-BROADPHASE/ADD-TO-CHILD-BROADPHASE)

(declaim (inline MULTI-SAP-BROADPHASE/CALCULATE-OVERLAPPING-PAIRS))

(cffi:defcfun ("_wrap_btMultiSapBroadphase_calculateOverlappingPairs" MULTI-SAP-BROADPHASE/CALCULATE-OVERLAPPING-PAIRS) :void
  (self :pointer)
  (dispatcher :pointer))

(export 'MULTI-SAP-BROADPHASE/CALCULATE-OVERLAPPING-PAIRS)

(declaim (inline MULTI-SAP-BROADPHASE/TEST-AABB-OVERLAP))

(cffi:defcfun ("_wrap_btMultiSapBroadphase_testAabbOverlap" MULTI-SAP-BROADPHASE/TEST-AABB-OVERLAP) :pointer
  (self :pointer)
  (proxy0 :pointer)
  (proxy1 :pointer))

(export 'MULTI-SAP-BROADPHASE/TEST-AABB-OVERLAP)

(declaim (inline MULTI-SAP-BROADPHASE/GET-OVERLAPPING-PAIR-CACHE))

(cffi:defcfun ("_wrap_btMultiSapBroadphase_getOverlappingPairCache__SWIG_0" MULTI-SAP-BROADPHASE/GET-OVERLAPPING-PAIR-CACHE) :pointer
  (self :pointer))

(export 'MULTI-SAP-BROADPHASE/GET-OVERLAPPING-PAIR-CACHE)

(declaim (inline MULTI-SAP-BROADPHASE/GET-OVERLAPPING-PAIR-CACHE))

(cffi:defcfun ("_wrap_btMultiSapBroadphase_getOverlappingPairCache__SWIG_1" MULTI-SAP-BROADPHASE/GET-OVERLAPPING-PAIR-CACHE) :pointer
  (self :pointer))

(export 'MULTI-SAP-BROADPHASE/GET-OVERLAPPING-PAIR-CACHE)

(declaim (inline MULTI-SAP-BROADPHASE/GET-BROADPHASE-AABB))

(cffi:defcfun ("_wrap_btMultiSapBroadphase_getBroadphaseAabb" MULTI-SAP-BROADPHASE/GET-BROADPHASE-AABB) :void
  (self :pointer)
  (aabbMin :pointer)
  (aabbMax :pointer))

(export 'MULTI-SAP-BROADPHASE/GET-BROADPHASE-AABB)

(declaim (inline MULTI-SAP-BROADPHASE/BUILD-TREE))

(cffi:defcfun ("_wrap_btMultiSapBroadphase_buildTree" MULTI-SAP-BROADPHASE/BUILD-TREE) :void
  (self :pointer)
  (bvhAabbMin :pointer)
  (bvhAabbMax :pointer))

(export 'MULTI-SAP-BROADPHASE/BUILD-TREE)

(declaim (inline MULTI-SAP-BROADPHASE/PRINT-STATS))

(cffi:defcfun ("_wrap_btMultiSapBroadphase_printStats" MULTI-SAP-BROADPHASE/PRINT-STATS) :void
  (self :pointer))

(export 'MULTI-SAP-BROADPHASE/PRINT-STATS)

(declaim (inline MULTI-SAP-BROADPHASE/QUICKSORT))

(cffi:defcfun ("_wrap_btMultiSapBroadphase_quicksort" MULTI-SAP-BROADPHASE/QUICKSORT) :void
  (self :pointer)
  (a :pointer)
  (lo :int)
  (hi :int))

(export 'MULTI-SAP-BROADPHASE/QUICKSORT)

(declaim (inline MULTI-SAP-BROADPHASE/RESET-POOL))

(cffi:defcfun ("_wrap_btMultiSapBroadphase_resetPool" MULTI-SAP-BROADPHASE/RESET-POOL) :void
  (self :pointer)
  (dispatcher :pointer))

(export 'MULTI-SAP-BROADPHASE/RESET-POOL)

(define-constant +DBVT-BP-PROFILE+ 0)

(export '+DBVT-BP-PROFILE+)

(define-constant +DBVT-BP-PREVENTFALSEUPDATE+ 0)

(export '+DBVT-BP-PREVENTFALSEUPDATE+)

(define-constant +DBVT-BP-ACCURATESLEEPING+ 0)

(export '+DBVT-BP-ACCURATESLEEPING+)

(define-constant +DBVT-BP-ENABLE-BENCHMARK+ 0)

(export '+DBVT-BP-ENABLE-BENCHMARK+)

(cffi:defcstruct DBVT-PROXY
  (LEAF :pointer)
  (LINKS :pointer)
  (STAGE :int))

(export 'DBVT-PROXY)

(export 'LEAF)

(export 'LINKS)

(export 'STAGE)

(cffi:defcstruct DBVT-BROADPHASE
  (SETS :pointer)
  (STAGE-ROOTS :pointer)
  (PAIRCACHE :pointer)
  (PREDICTION :float)
  (STAGE-CURRENT :int)
  (FUPDATES :int)
  (DUPDATES :int)
  (CUPDATES :int)
  (NEWPAIRS :int)
  (FIXEDLEFT :int)
  (UPDATES-CALL :unsigned-int)
  (UPDATES-DONE :unsigned-int)
  (UPDATES-RATIO :float)
  (PID :int)
  (CID :int)
  (GID :int)
  (RELEASEPAIRCACHE :pointer)
  (DEFEREDCOLLIDE :pointer)
  (NEEDCLEANUP :pointer)
  (COLLIDE :pointer)
  (BULLET/OPTIMIZE :pointer)
  (CREATE-PROXY :pointer)
  (DESTROY-PROXY :pointer)
  (SET-AABB :pointer)
  (RAY-TEST :pointer)
  (RAY-TEST :pointer)
  (RAY-TEST :pointer)
  (AABB-TEST :pointer)
  (GET-AABB :pointer)
  (CALCULATE-OVERLAPPING-PAIRS :pointer)
  (GET-OVERLAPPING-PAIR-CACHE :pointer)
  (GET-OVERLAPPING-PAIR-CACHE :pointer)
  (GET-BROADPHASE-AABB :pointer)
  (PRINT-STATS :pointer)
  (RESET-POOL :pointer)
  (PERFORM-DEFERRED-REMOVAL :pointer)
  (SET-VELOCITY-PREDICTION :pointer)
  (GET-VELOCITY-PREDICTION :pointer)
  (SET-AABB-FORCE-UPDATE :pointer)
  (BENCHMARK :pointer))

(export 'DBVT-BROADPHASE)

(export 'SETS)

(export 'STAGE-ROOTS)

(export 'PAIRCACHE)

(export 'PREDICTION)

(export 'STAGE-CURRENT)

(export 'FUPDATES)

(export 'DUPDATES)

(export 'CUPDATES)

(export 'NEWPAIRS)

(export 'FIXEDLEFT)

(export 'UPDATES-CALL)

(export 'UPDATES-DONE)

(export 'UPDATES-RATIO)

(export 'PID)

(export 'CID)

(export 'GID)

(export 'RELEASEPAIRCACHE)

(export 'DEFEREDCOLLIDE)

(export 'NEEDCLEANUP)

(export 'COLLIDE)

(export 'BULLET/OPTIMIZE)

(export 'CREATE-PROXY)

(export 'DESTROY-PROXY)

(export 'SET-AABB)

(export 'RAY-TEST)

(export 'RAY-TEST)

(export 'RAY-TEST)

(export 'AABB-TEST)

(export 'GET-AABB)

(export 'CALCULATE-OVERLAPPING-PAIRS)

(export 'GET-OVERLAPPING-PAIR-CACHE)

(export 'GET-OVERLAPPING-PAIR-CACHE)

(export 'GET-BROADPHASE-AABB)

(export 'PRINT-STATS)

(export 'RESET-POOL)

(export 'PERFORM-DEFERRED-REMOVAL)

(export 'SET-VELOCITY-PREDICTION)

(export 'GET-VELOCITY-PREDICTION)

(export 'SET-AABB-FORCE-UPDATE)

(export 'BENCHMARK)

(cffi:defcstruct DEFAULT-MOTION-STATE
  (GRAPHICS-WORLD-TRANS :pointer)
  (CENTER-OF-MASS-OFFSET :pointer)
  (START-WORLD-TRANS :pointer)
  (USER-POINTER :pointer)
  (MAKE-CPLUS-PLUS-INSTANCE :pointer)
  (DELETE-CPLUS-PLUS-INSTANCE :pointer)
  (MAKE-CPLUS-PLUS-INSTANCE :pointer)
  (DELETE-CPLUS-PLUS-INSTANCE :pointer)
  (MAKE-CPLUS-ARRAY :pointer)
  (DELETE-CPLUS-ARRAY :pointer)
  (MAKE-CPLUS-ARRAY :pointer)
  (DELETE-CPLUS-ARRAY :pointer)
  (GET-WORLD-TRANSFORM :pointer)
  (SET-WORLD-TRANSFORM :pointer))

(export 'DEFAULT-MOTION-STATE)

(export 'GRAPHICS-WORLD-TRANS)

(export 'CENTER-OF-MASS-OFFSET)

(export 'START-WORLD-TRANS)

(export 'USER-POINTER)

(export 'MAKE-CPLUS-PLUS-INSTANCE)

(export 'DELETE-CPLUS-PLUS-INSTANCE)

(export 'MAKE-CPLUS-PLUS-INSTANCE)

(export 'DELETE-CPLUS-PLUS-INSTANCE)

(export 'MAKE-CPLUS-ARRAY)

(export 'DELETE-CPLUS-ARRAY)

(export 'MAKE-CPLUS-ARRAY)

(export 'DELETE-CPLUS-ARRAY)

(export 'GET-WORLD-TRANSFORM)

(export 'SET-WORLD-TRANSFORM)

(define-constant +USE-BT-CLOCK+ 1)

(export '+USE-BT-CLOCK+)

(declaim (inline MAKE-CLOCK))

(cffi:defcfun ("_wrap_new_btClock__SWIG_0" MAKE-CLOCK) :pointer)

(export 'MAKE-CLOCK)

(declaim (inline MAKE-CLOCK))

(cffi:defcfun ("_wrap_new_btClock__SWIG_1" MAKE-CLOCK) :pointer
  (other :pointer))

(export 'MAKE-CLOCK)

(declaim (inline CLOCK/ASSIGN-VALUE))

(cffi:defcfun ("_wrap_btClock_assignValue" CLOCK/ASSIGN-VALUE) :pointer
  (self :pointer)
  (other :pointer))

(export 'CLOCK/ASSIGN-VALUE)

(declaim (inline DELETE/BT-CLOCK))

(cffi:defcfun ("_wrap_delete_btClock" DELETE/BT-CLOCK) :void
  (self :pointer))

(export 'DELETE/BT-CLOCK)

(declaim (inline CLOCK/RESET))

(cffi:defcfun ("_wrap_btClock_reset" CLOCK/RESET) :void
  (self :pointer))

(export 'CLOCK/RESET)

(declaim (inline CLOCK/GET-TIME-MILLISECONDS))

(cffi:defcfun ("_wrap_btClock_getTimeMilliseconds" CLOCK/GET-TIME-MILLISECONDS) :unsigned-long
  (self :pointer))

(export 'CLOCK/GET-TIME-MILLISECONDS)

(declaim (inline CLOCK/GET-TIME-MICROSECONDS))

(cffi:defcfun ("_wrap_btClock_getTimeMicroseconds" CLOCK/GET-TIME-MICROSECONDS) :unsigned-long
  (self :pointer))

(export 'CLOCK/GET-TIME-MICROSECONDS)

(declaim (inline MAKE-CPROFILE-NODE))

(cffi:defcfun ("_wrap_new_CProfileNode" MAKE-CPROFILE-NODE) :pointer
  (name :string)
  (parent :pointer))

(export 'MAKE-CPROFILE-NODE)

(declaim (inline DELETE/CPROFILE-NODE))

(cffi:defcfun ("_wrap_delete_CProfileNode" DELETE/CPROFILE-NODE) :void
  (self :pointer))

(export 'DELETE/CPROFILE-NODE)

(declaim (inline CPROFILE-NODE/GET/SUB/NODE))

(cffi:defcfun ("_wrap_CProfileNode_Get_Sub_Node" CPROFILE-NODE/GET/SUB/NODE) :pointer
  (self :pointer)
  (name :string))

(export 'CPROFILE-NODE/GET/SUB/NODE)

(declaim (inline CPROFILE-NODE/GET/PARENT))

(cffi:defcfun ("_wrap_CProfileNode_Get_Parent" CPROFILE-NODE/GET/PARENT) :pointer
  (self :pointer))

(export 'CPROFILE-NODE/GET/PARENT)

(declaim (inline CPROFILE-NODE/GET/SIBLING))

(cffi:defcfun ("_wrap_CProfileNode_Get_Sibling" CPROFILE-NODE/GET/SIBLING) :pointer
  (self :pointer))

(export 'CPROFILE-NODE/GET/SIBLING)

(declaim (inline CPROFILE-NODE/GET/CHILD))

(cffi:defcfun ("_wrap_CProfileNode_Get_Child" CPROFILE-NODE/GET/CHILD) :pointer
  (self :pointer))

(export 'CPROFILE-NODE/GET/CHILD)

(declaim (inline CPROFILE-NODE/CLEANUP-MEMORY))

(cffi:defcfun ("_wrap_CProfileNode_CleanupMemory" CPROFILE-NODE/CLEANUP-MEMORY) :void
  (self :pointer))

(export 'CPROFILE-NODE/CLEANUP-MEMORY)

(declaim (inline CPROFILE-NODE/RESET))

(cffi:defcfun ("_wrap_CProfileNode_Reset" CPROFILE-NODE/RESET) :void
  (self :pointer))

(export 'CPROFILE-NODE/RESET)

(declaim (inline CPROFILE-NODE/CALL))

(cffi:defcfun ("_wrap_CProfileNode_Call" CPROFILE-NODE/CALL) :void
  (self :pointer))

(export 'CPROFILE-NODE/CALL)

(declaim (inline CPROFILE-NODE/RETURN))

(cffi:defcfun ("_wrap_CProfileNode_Return" CPROFILE-NODE/RETURN) :pointer
  (self :pointer))

(export 'CPROFILE-NODE/RETURN)

(declaim (inline CPROFILE-NODE/GET/NAME))

(cffi:defcfun ("_wrap_CProfileNode_Get_Name" CPROFILE-NODE/GET/NAME) :string
  (self :pointer))

(export 'CPROFILE-NODE/GET/NAME)

(declaim (inline CPROFILE-NODE/GET/TOTAL/CALLS))

(cffi:defcfun ("_wrap_CProfileNode_Get_Total_Calls" CPROFILE-NODE/GET/TOTAL/CALLS) :int
  (self :pointer))

(export 'CPROFILE-NODE/GET/TOTAL/CALLS)

(declaim (inline CPROFILE-NODE/GET/TOTAL/TIME))

(cffi:defcfun ("_wrap_CProfileNode_Get_Total_Time" CPROFILE-NODE/GET/TOTAL/TIME) :float
  (self :pointer))

(export 'CPROFILE-NODE/GET/TOTAL/TIME)

(declaim (inline CPROFILE-NODE/GET-USER-POINTER))

(cffi:defcfun ("_wrap_CProfileNode_GetUserPointer" CPROFILE-NODE/GET-USER-POINTER) :pointer
  (self :pointer))

(export 'CPROFILE-NODE/GET-USER-POINTER)

(declaim (inline CPROFILE-NODE/SET-USER-POINTER))

(cffi:defcfun ("_wrap_CProfileNode_SetUserPointer" CPROFILE-NODE/SET-USER-POINTER) :void
  (self :pointer)
  (ptr :pointer))

(export 'CPROFILE-NODE/SET-USER-POINTER)

(declaim (inline CPROFILE-ITERATOR/FIRST))

(cffi:defcfun ("_wrap_CProfileIterator_First" CPROFILE-ITERATOR/FIRST) :void
  (self :pointer))

(export 'CPROFILE-ITERATOR/FIRST)

(declaim (inline CPROFILE-ITERATOR/NEXT))

(cffi:defcfun ("_wrap_CProfileIterator_Next" CPROFILE-ITERATOR/NEXT) :void
  (self :pointer))

(export 'CPROFILE-ITERATOR/NEXT)

(declaim (inline CPROFILE-ITERATOR/IS/DONE))

(cffi:defcfun ("_wrap_CProfileIterator_Is_Done" CPROFILE-ITERATOR/IS/DONE) :pointer
  (self :pointer))

(export 'CPROFILE-ITERATOR/IS/DONE)

(declaim (inline CPROFILE-ITERATOR/IS/ROOT))

(cffi:defcfun ("_wrap_CProfileIterator_Is_Root" CPROFILE-ITERATOR/IS/ROOT) :pointer
  (self :pointer))

(export 'CPROFILE-ITERATOR/IS/ROOT)

(declaim (inline CPROFILE-ITERATOR/ENTER/CHILD))

(cffi:defcfun ("_wrap_CProfileIterator_Enter_Child" CPROFILE-ITERATOR/ENTER/CHILD) :void
  (self :pointer)
  (index :int))

(export 'CPROFILE-ITERATOR/ENTER/CHILD)

(declaim (inline CPROFILE-ITERATOR/ENTER/LARGEST/CHILD))

(cffi:defcfun ("_wrap_CProfileIterator_Enter_Largest_Child" CPROFILE-ITERATOR/ENTER/LARGEST/CHILD) :void
  (self :pointer))

(export 'CPROFILE-ITERATOR/ENTER/LARGEST/CHILD)

(declaim (inline CPROFILE-ITERATOR/ENTER/PARENT))

(cffi:defcfun ("_wrap_CProfileIterator_Enter_Parent" CPROFILE-ITERATOR/ENTER/PARENT) :void
  (self :pointer))

(export 'CPROFILE-ITERATOR/ENTER/PARENT)

(declaim (inline CPROFILE-ITERATOR/GET/CURRENT/NAME))

(cffi:defcfun ("_wrap_CProfileIterator_Get_Current_Name" CPROFILE-ITERATOR/GET/CURRENT/NAME) :string
  (self :pointer))

(export 'CPROFILE-ITERATOR/GET/CURRENT/NAME)

(declaim (inline CPROFILE-ITERATOR/GET/CURRENT/TOTAL/CALLS))

(cffi:defcfun ("_wrap_CProfileIterator_Get_Current_Total_Calls" CPROFILE-ITERATOR/GET/CURRENT/TOTAL/CALLS) :int
  (self :pointer))

(export 'CPROFILE-ITERATOR/GET/CURRENT/TOTAL/CALLS)

(declaim (inline CPROFILE-ITERATOR/GET/CURRENT/TOTAL/TIME))

(cffi:defcfun ("_wrap_CProfileIterator_Get_Current_Total_Time" CPROFILE-ITERATOR/GET/CURRENT/TOTAL/TIME) :float
  (self :pointer))

(export 'CPROFILE-ITERATOR/GET/CURRENT/TOTAL/TIME)

(declaim (inline CPROFILE-ITERATOR/GET/CURRENT/USER-POINTER))

(cffi:defcfun ("_wrap_CProfileIterator_Get_Current_UserPointer" CPROFILE-ITERATOR/GET/CURRENT/USER-POINTER) :pointer
  (self :pointer))

(export 'CPROFILE-ITERATOR/GET/CURRENT/USER-POINTER)

(declaim (inline CPROFILE-ITERATOR/SET/CURRENT/USER-POINTER))

(cffi:defcfun ("_wrap_CProfileIterator_Set_Current_UserPointer" CPROFILE-ITERATOR/SET/CURRENT/USER-POINTER) :void
  (self :pointer)
  (ptr :pointer))

(export 'CPROFILE-ITERATOR/SET/CURRENT/USER-POINTER)

(declaim (inline CPROFILE-ITERATOR/GET/CURRENT/PARENT/NAME))

(cffi:defcfun ("_wrap_CProfileIterator_Get_Current_Parent_Name" CPROFILE-ITERATOR/GET/CURRENT/PARENT/NAME) :string
  (self :pointer))

(export 'CPROFILE-ITERATOR/GET/CURRENT/PARENT/NAME)

(declaim (inline CPROFILE-ITERATOR/GET/CURRENT/PARENT/TOTAL/CALLS))

(cffi:defcfun ("_wrap_CProfileIterator_Get_Current_Parent_Total_Calls" CPROFILE-ITERATOR/GET/CURRENT/PARENT/TOTAL/CALLS) :int
  (self :pointer))

(export 'CPROFILE-ITERATOR/GET/CURRENT/PARENT/TOTAL/CALLS)

(declaim (inline CPROFILE-ITERATOR/GET/CURRENT/PARENT/TOTAL/TIME))

(cffi:defcfun ("_wrap_CProfileIterator_Get_Current_Parent_Total_Time" CPROFILE-ITERATOR/GET/CURRENT/PARENT/TOTAL/TIME) :float
  (self :pointer))

(export 'CPROFILE-ITERATOR/GET/CURRENT/PARENT/TOTAL/TIME)

(declaim (inline DELETE/CPROFILE-ITERATOR))

(cffi:defcfun ("_wrap_delete_CProfileIterator" DELETE/CPROFILE-ITERATOR) :void
  (self :pointer))

(export 'DELETE/CPROFILE-ITERATOR)

(declaim (inline CPROFILE-MANAGER/START/PROFILE))

(cffi:defcfun ("_wrap_CProfileManager_Start_Profile" CPROFILE-MANAGER/START/PROFILE) :void
  (name :string))

(export 'CPROFILE-MANAGER/START/PROFILE)

(declaim (inline CPROFILE-MANAGER/STOP/PROFILE))

(cffi:defcfun ("_wrap_CProfileManager_Stop_Profile" CPROFILE-MANAGER/STOP/PROFILE) :void)

(export 'CPROFILE-MANAGER/STOP/PROFILE)

(declaim (inline CPROFILE-MANAGER/CLEANUP-MEMORY))

(cffi:defcfun ("_wrap_CProfileManager_CleanupMemory" CPROFILE-MANAGER/CLEANUP-MEMORY) :void)

(export 'CPROFILE-MANAGER/CLEANUP-MEMORY)

(declaim (inline CPROFILE-MANAGER/RESET))

(cffi:defcfun ("_wrap_CProfileManager_Reset" CPROFILE-MANAGER/RESET) :void)

(export 'CPROFILE-MANAGER/RESET)

(declaim (inline CPROFILE-MANAGER/INCREMENT/FRAME/COUNTER))

(cffi:defcfun ("_wrap_CProfileManager_Increment_Frame_Counter" CPROFILE-MANAGER/INCREMENT/FRAME/COUNTER) :void)

(export 'CPROFILE-MANAGER/INCREMENT/FRAME/COUNTER)

(declaim (inline CPROFILE-MANAGER/GET/FRAME/COUNT/SINCE/RESET))

(cffi:defcfun ("_wrap_CProfileManager_Get_Frame_Count_Since_Reset" CPROFILE-MANAGER/GET/FRAME/COUNT/SINCE/RESET) :int)

(export 'CPROFILE-MANAGER/GET/FRAME/COUNT/SINCE/RESET)

(declaim (inline CPROFILE-MANAGER/GET/TIME/SINCE/RESET))

(cffi:defcfun ("_wrap_CProfileManager_Get_Time_Since_Reset" CPROFILE-MANAGER/GET/TIME/SINCE/RESET) :float)

(export 'CPROFILE-MANAGER/GET/TIME/SINCE/RESET)

(declaim (inline CPROFILE-MANAGER/GET/ITERATOR))

(cffi:defcfun ("_wrap_CProfileManager_Get_Iterator" CPROFILE-MANAGER/GET/ITERATOR) :pointer)

(export 'CPROFILE-MANAGER/GET/ITERATOR)

(declaim (inline CPROFILE-MANAGER/RELEASE/ITERATOR))

(cffi:defcfun ("_wrap_CProfileManager_Release_Iterator" CPROFILE-MANAGER/RELEASE/ITERATOR) :void
  (iterator :pointer))

(export 'CPROFILE-MANAGER/RELEASE/ITERATOR)

(declaim (inline CPROFILE-MANAGER/DUMP-RECURSIVE))

(cffi:defcfun ("_wrap_CProfileManager_dumpRecursive" CPROFILE-MANAGER/DUMP-RECURSIVE) :void
  (profileIterator :pointer)
  (spacing :int))

(export 'CPROFILE-MANAGER/DUMP-RECURSIVE)

(declaim (inline CPROFILE-MANAGER/DUMP-ALL))

(cffi:defcfun ("_wrap_CProfileManager_dumpAll" CPROFILE-MANAGER/DUMP-ALL) :void)

(export 'CPROFILE-MANAGER/DUMP-ALL)

(declaim (inline MAKE-CPROFILE-MANAGER))

(cffi:defcfun ("_wrap_new_CProfileManager" MAKE-CPROFILE-MANAGER) :pointer)

(export 'MAKE-CPROFILE-MANAGER)

(declaim (inline DELETE/CPROFILE-MANAGER))

(cffi:defcfun ("_wrap_delete_CProfileManager" DELETE/CPROFILE-MANAGER) :void
  (self :pointer))

(export 'DELETE/CPROFILE-MANAGER)

(declaim (inline MAKE-CPROFILE-SAMPLE))

(cffi:defcfun ("_wrap_new_CProfileSample" MAKE-CPROFILE-SAMPLE) :pointer
  (name :string))

(export 'MAKE-CPROFILE-SAMPLE)

(declaim (inline DELETE/CPROFILE-SAMPLE))

(cffi:defcfun ("_wrap_delete_CProfileSample" DELETE/CPROFILE-SAMPLE) :void
  (self :pointer))

(export 'DELETE/CPROFILE-SAMPLE)

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

(export 'DEBUG-DRAW-MODES)

(declaim (inline DELETE/BT-IDEBUG-DRAW))

(cffi:defcfun ("_wrap_delete_btIDebugDraw" DELETE/BT-IDEBUG-DRAW) :void
  (self :pointer))

(export 'DELETE/BT-IDEBUG-DRAW)

(declaim (inline IDEBUG-DRAW/DRAW-LINE))

(cffi:defcfun ("_wrap_btIDebugDraw_drawLine__SWIG_0" IDEBUG-DRAW/DRAW-LINE) :void
  (self :pointer)
  (from :pointer)
  (to :pointer)
  (color :pointer))

(export 'IDEBUG-DRAW/DRAW-LINE)

(declaim (inline IDEBUG-DRAW/DRAW-LINE))

(cffi:defcfun ("_wrap_btIDebugDraw_drawLine__SWIG_1" IDEBUG-DRAW/DRAW-LINE) :void
  (self :pointer)
  (from :pointer)
  (to :pointer)
  (fromColor :pointer)
  (toColor :pointer))

(export 'IDEBUG-DRAW/DRAW-LINE)

(declaim (inline IDEBUG-DRAW/DRAW-SPHERE))

(cffi:defcfun ("_wrap_btIDebugDraw_drawSphere__SWIG_0" IDEBUG-DRAW/DRAW-SPHERE) :void
  (self :pointer)
  (radius :float)
  (transform :pointer)
  (color :pointer))

(export 'IDEBUG-DRAW/DRAW-SPHERE)

(declaim (inline IDEBUG-DRAW/DRAW-SPHERE))

(cffi:defcfun ("_wrap_btIDebugDraw_drawSphere__SWIG_1" IDEBUG-DRAW/DRAW-SPHERE) :void
  (self :pointer)
  (p :pointer)
  (radius :float)
  (color :pointer))

(export 'IDEBUG-DRAW/DRAW-SPHERE)

(declaim (inline IDEBUG-DRAW/DRAW-TRIANGLE))

(cffi:defcfun ("_wrap_btIDebugDraw_drawTriangle__SWIG_0" IDEBUG-DRAW/DRAW-TRIANGLE) :void
  (self :pointer)
  (v0 :pointer)
  (v1 :pointer)
  (v2 :pointer)
  (arg4 :pointer)
  (arg5 :pointer)
  (arg6 :pointer)
  (color :pointer)
  (alpha :float))

(export 'IDEBUG-DRAW/DRAW-TRIANGLE)

(declaim (inline IDEBUG-DRAW/DRAW-TRIANGLE))

(cffi:defcfun ("_wrap_btIDebugDraw_drawTriangle__SWIG_1" IDEBUG-DRAW/DRAW-TRIANGLE) :void
  (self :pointer)
  (v0 :pointer)
  (v1 :pointer)
  (v2 :pointer)
  (color :pointer)
  (arg5 :float))

(export 'IDEBUG-DRAW/DRAW-TRIANGLE)

(declaim (inline IDEBUG-DRAW/DRAW-CONTACT-POINT))

(cffi:defcfun ("_wrap_btIDebugDraw_drawContactPoint" IDEBUG-DRAW/DRAW-CONTACT-POINT) :void
  (self :pointer)
  (PointOnB :pointer)
  (normalOnB :pointer)
  (distance :float)
  (lifeTime :int)
  (color :pointer))

(export 'IDEBUG-DRAW/DRAW-CONTACT-POINT)

(declaim (inline IDEBUG-DRAW/REPORT-ERROR-WARNING))

(cffi:defcfun ("_wrap_btIDebugDraw_reportErrorWarning" IDEBUG-DRAW/REPORT-ERROR-WARNING) :void
  (self :pointer)
  (warningString :string))

(export 'IDEBUG-DRAW/REPORT-ERROR-WARNING)

(declaim (inline IDEBUG-DRAW/DRAW-3D-TEXT))

(cffi:defcfun ("_wrap_btIDebugDraw_draw3dText" IDEBUG-DRAW/DRAW-3D-TEXT) :void
  (self :pointer)
  (location :pointer)
  (textString :string))

(export 'IDEBUG-DRAW/DRAW-3D-TEXT)

(declaim (inline IDEBUG-DRAW/SET-DEBUG-MODE))

(cffi:defcfun ("_wrap_btIDebugDraw_setDebugMode" IDEBUG-DRAW/SET-DEBUG-MODE) :void
  (self :pointer)
  (debugMode :int))

(export 'IDEBUG-DRAW/SET-DEBUG-MODE)

(declaim (inline IDEBUG-DRAW/GET-DEBUG-MODE))

(cffi:defcfun ("_wrap_btIDebugDraw_getDebugMode" IDEBUG-DRAW/GET-DEBUG-MODE) :int
  (self :pointer))

(export 'IDEBUG-DRAW/GET-DEBUG-MODE)

(declaim (inline IDEBUG-DRAW/DRAW-AABB))

(cffi:defcfun ("_wrap_btIDebugDraw_drawAabb" IDEBUG-DRAW/DRAW-AABB) :void
  (self :pointer)
  (from :pointer)
  (to :pointer)
  (color :pointer))

(export 'IDEBUG-DRAW/DRAW-AABB)

(declaim (inline IDEBUG-DRAW/DRAW-TRANSFORM))

(cffi:defcfun ("_wrap_btIDebugDraw_drawTransform" IDEBUG-DRAW/DRAW-TRANSFORM) :void
  (self :pointer)
  (transform :pointer)
  (orthoLen :float))

(export 'IDEBUG-DRAW/DRAW-TRANSFORM)

(declaim (inline IDEBUG-DRAW/DRAW-ARC))

(cffi:defcfun ("_wrap_btIDebugDraw_drawArc__SWIG_0" IDEBUG-DRAW/DRAW-ARC) :void
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

(export 'IDEBUG-DRAW/DRAW-ARC)

(declaim (inline IDEBUG-DRAW/DRAW-ARC))

(cffi:defcfun ("_wrap_btIDebugDraw_drawArc__SWIG_1" IDEBUG-DRAW/DRAW-ARC) :void
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

(export 'IDEBUG-DRAW/DRAW-ARC)

(declaim (inline IDEBUG-DRAW/DRAW-SPHERE-PATCH))

(cffi:defcfun ("_wrap_btIDebugDraw_drawSpherePatch__SWIG_0" IDEBUG-DRAW/DRAW-SPHERE-PATCH) :void
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

(export 'IDEBUG-DRAW/DRAW-SPHERE-PATCH)

(declaim (inline IDEBUG-DRAW/DRAW-SPHERE-PATCH))

(cffi:defcfun ("_wrap_btIDebugDraw_drawSpherePatch__SWIG_1" IDEBUG-DRAW/DRAW-SPHERE-PATCH) :void
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

(export 'IDEBUG-DRAW/DRAW-SPHERE-PATCH)

(declaim (inline IDEBUG-DRAW/DRAW-SPHERE-PATCH))

(cffi:defcfun ("_wrap_btIDebugDraw_drawSpherePatch__SWIG_2" IDEBUG-DRAW/DRAW-SPHERE-PATCH) :void
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

(export 'IDEBUG-DRAW/DRAW-SPHERE-PATCH)

(declaim (inline IDEBUG-DRAW/DRAW-BOX))

(cffi:defcfun ("_wrap_btIDebugDraw_drawBox__SWIG_0" IDEBUG-DRAW/DRAW-BOX) :void
  (self :pointer)
  (bbMin :pointer)
  (bbMax :pointer)
  (color :pointer))

(export 'IDEBUG-DRAW/DRAW-BOX)

(declaim (inline IDEBUG-DRAW/DRAW-BOX))

(cffi:defcfun ("_wrap_btIDebugDraw_drawBox__SWIG_1" IDEBUG-DRAW/DRAW-BOX) :void
  (self :pointer)
  (bbMin :pointer)
  (bbMax :pointer)
  (trans :pointer)
  (color :pointer))

(export 'IDEBUG-DRAW/DRAW-BOX)

(declaim (inline IDEBUG-DRAW/DRAW-CAPSULE))

(cffi:defcfun ("_wrap_btIDebugDraw_drawCapsule" IDEBUG-DRAW/DRAW-CAPSULE) :void
  (self :pointer)
  (radius :float)
  (halfHeight :float)
  (upAxis :int)
  (transform :pointer)
  (color :pointer))

(export 'IDEBUG-DRAW/DRAW-CAPSULE)

(declaim (inline IDEBUG-DRAW/DRAW-CYLINDER))

(cffi:defcfun ("_wrap_btIDebugDraw_drawCylinder" IDEBUG-DRAW/DRAW-CYLINDER) :void
  (self :pointer)
  (radius :float)
  (halfHeight :float)
  (upAxis :int)
  (transform :pointer)
  (color :pointer))

(export 'IDEBUG-DRAW/DRAW-CYLINDER)

(declaim (inline IDEBUG-DRAW/DRAW-CONE))

(cffi:defcfun ("_wrap_btIDebugDraw_drawCone" IDEBUG-DRAW/DRAW-CONE) :void
  (self :pointer)
  (radius :float)
  (height :float)
  (upAxis :int)
  (transform :pointer)
  (color :pointer))

(export 'IDEBUG-DRAW/DRAW-CONE)

(declaim (inline IDEBUG-DRAW/DRAW-PLANE))

(cffi:defcfun ("_wrap_btIDebugDraw_drawPlane" IDEBUG-DRAW/DRAW-PLANE) :void
  (self :pointer)
  (planeNormal :pointer)
  (planeConst :float)
  (transform :pointer)
  (color :pointer))

(export 'IDEBUG-DRAW/DRAW-PLANE)

(cffi:defcvar ("sBulletDNAstr" *S-BULLET-DNASTR*)
 :pointer)

(export '*S-BULLET-DNASTR*)

(cffi:defcvar ("sBulletDNAlen" *S-BULLET-DNALEN*)
 :int)

(export '*S-BULLET-DNALEN*)

(cffi:defcvar ("sBulletDNAstr64" *S-BULLET-DNASTR-64*)
 :pointer)

(export '*S-BULLET-DNASTR-64*)

(cffi:defcvar ("sBulletDNAlen64" *S-BULLET-DNALEN-64*)
 :int)

(export '*S-BULLET-DNALEN-64*)

(declaim (inline STR-LEN))

(cffi:defcfun ("_wrap_btStrLen" STR-LEN) :int
  (str :string))

(export 'STR-LEN)

(declaim (inline CHUNK/M/CHUNK-CODE/SET))

(cffi:defcfun ("_wrap_btChunk_m_chunkCode_set" CHUNK/M/CHUNK-CODE/SET) :void
  (self :pointer)
  (m_chunkCode :int))

(export 'CHUNK/M/CHUNK-CODE/SET)

(declaim (inline CHUNK/M/CHUNK-CODE/GET))

(cffi:defcfun ("_wrap_btChunk_m_chunkCode_get" CHUNK/M/CHUNK-CODE/GET) :int
  (self :pointer))

(export 'CHUNK/M/CHUNK-CODE/GET)

(declaim (inline CHUNK/M/LENGTH/SET))

(cffi:defcfun ("_wrap_btChunk_m_length_set" CHUNK/M/LENGTH/SET) :void
  (self :pointer)
  (m_length :int))

(export 'CHUNK/M/LENGTH/SET)

(declaim (inline CHUNK/M/LENGTH/GET))

(cffi:defcfun ("_wrap_btChunk_m_length_get" CHUNK/M/LENGTH/GET) :int
  (self :pointer))

(export 'CHUNK/M/LENGTH/GET)

(declaim (inline CHUNK/M/OLD-PTR/SET))

(cffi:defcfun ("_wrap_btChunk_m_oldPtr_set" CHUNK/M/OLD-PTR/SET) :void
  (self :pointer)
  (m_oldPtr :pointer))

(export 'CHUNK/M/OLD-PTR/SET)

(declaim (inline CHUNK/M/OLD-PTR/GET))

(cffi:defcfun ("_wrap_btChunk_m_oldPtr_get" CHUNK/M/OLD-PTR/GET) :pointer
  (self :pointer))

(export 'CHUNK/M/OLD-PTR/GET)

(declaim (inline CHUNK/M/DNA/NR/SET))

(cffi:defcfun ("_wrap_btChunk_m_dna_nr_set" CHUNK/M/DNA/NR/SET) :void
  (self :pointer)
  (m_dna_nr :int))

(export 'CHUNK/M/DNA/NR/SET)

(declaim (inline CHUNK/M/DNA/NR/GET))

(cffi:defcfun ("_wrap_btChunk_m_dna_nr_get" CHUNK/M/DNA/NR/GET) :int
  (self :pointer))

(export 'CHUNK/M/DNA/NR/GET)

(declaim (inline CHUNK/M/NUMBER/SET))

(cffi:defcfun ("_wrap_btChunk_m_number_set" CHUNK/M/NUMBER/SET) :void
  (self :pointer)
  (m_number :int))

(export 'CHUNK/M/NUMBER/SET)

(declaim (inline CHUNK/M/NUMBER/GET))

(cffi:defcfun ("_wrap_btChunk_m_number_get" CHUNK/M/NUMBER/GET) :int
  (self :pointer))

(export 'CHUNK/M/NUMBER/GET)

(declaim (inline MAKE-CHUNK))

(cffi:defcfun ("_wrap_new_btChunk" MAKE-CHUNK) :pointer)

(export 'MAKE-CHUNK)

(declaim (inline DELETE/BT-CHUNK))

(cffi:defcfun ("_wrap_delete_btChunk" DELETE/BT-CHUNK) :void
  (self :pointer))

(export 'DELETE/BT-CHUNK)

(cffi:defcenum SERIALIZATION-FLAGS
  (:SERIALIZE-NO-BVH #.1)
  (:SERIALIZE-NO-TRIANGLEINFOMAP #.2)
  (:SERIALIZE-NO-DUPLICATE-ASSERT #.4))

(export 'SERIALIZATION-FLAGS)

(declaim (inline DELETE/BT-SERIALIZER))

(cffi:defcfun ("_wrap_delete_btSerializer" DELETE/BT-SERIALIZER) :void
  (self :pointer))

(export 'DELETE/BT-SERIALIZER)

(declaim (inline SERIALIZER/GET-BUFFER-POINTER))

(cffi:defcfun ("_wrap_btSerializer_getBufferPointer" SERIALIZER/GET-BUFFER-POINTER) :pointer
  (self :pointer))

(export 'SERIALIZER/GET-BUFFER-POINTER)

(declaim (inline SERIALIZER/GET-CURRENT-BUFFER-SIZE))

(cffi:defcfun ("_wrap_btSerializer_getCurrentBufferSize" SERIALIZER/GET-CURRENT-BUFFER-SIZE) :int
  (self :pointer))

(export 'SERIALIZER/GET-CURRENT-BUFFER-SIZE)

(declaim (inline SERIALIZER/ALLOCATE))

(cffi:defcfun ("_wrap_btSerializer_allocate" SERIALIZER/ALLOCATE) :pointer
  (self :pointer)
  (size :pointer)
  (numElements :int))

(export 'SERIALIZER/ALLOCATE)

(declaim (inline SERIALIZER/FINALIZE-CHUNK))

(cffi:defcfun ("_wrap_btSerializer_finalizeChunk" SERIALIZER/FINALIZE-CHUNK) :void
  (self :pointer)
  (chunk :pointer)
  (structType :string)
  (chunkCode :int)
  (oldPtr :pointer))

(export 'SERIALIZER/FINALIZE-CHUNK)

(declaim (inline SERIALIZER/FIND-POINTER))

(cffi:defcfun ("_wrap_btSerializer_findPointer" SERIALIZER/FIND-POINTER) :pointer
  (self :pointer)
  (oldPtr :pointer))

(export 'SERIALIZER/FIND-POINTER)

(declaim (inline SERIALIZER/GET-UNIQUE-POINTER))

(cffi:defcfun ("_wrap_btSerializer_getUniquePointer" SERIALIZER/GET-UNIQUE-POINTER) :pointer
  (self :pointer)
  (oldPtr :pointer))

(export 'SERIALIZER/GET-UNIQUE-POINTER)

(declaim (inline SERIALIZER/START-SERIALIZATION))

(cffi:defcfun ("_wrap_btSerializer_startSerialization" SERIALIZER/START-SERIALIZATION) :void
  (self :pointer))

(export 'SERIALIZER/START-SERIALIZATION)

(declaim (inline SERIALIZER/FINISH-SERIALIZATION))

(cffi:defcfun ("_wrap_btSerializer_finishSerialization" SERIALIZER/FINISH-SERIALIZATION) :void
  (self :pointer))

(export 'SERIALIZER/FINISH-SERIALIZATION)

(declaim (inline SERIALIZER/FIND-NAME-FOR-POINTER))

(cffi:defcfun ("_wrap_btSerializer_findNameForPointer" SERIALIZER/FIND-NAME-FOR-POINTER) :string
  (self :pointer)
  (ptr :pointer))

(export 'SERIALIZER/FIND-NAME-FOR-POINTER)

(declaim (inline SERIALIZER/REGISTER-NAME-FOR-POINTER))

(cffi:defcfun ("_wrap_btSerializer_registerNameForPointer" SERIALIZER/REGISTER-NAME-FOR-POINTER) :void
  (self :pointer)
  (ptr :pointer)
  (name :string))

(export 'SERIALIZER/REGISTER-NAME-FOR-POINTER)

(declaim (inline SERIALIZER/SERIALIZE-NAME))

(cffi:defcfun ("_wrap_btSerializer_serializeName" SERIALIZER/SERIALIZE-NAME) :void
  (self :pointer)
  (ptr :string))

(export 'SERIALIZER/SERIALIZE-NAME)

(declaim (inline SERIALIZER/GET-SERIALIZATION-FLAGS))

(cffi:defcfun ("_wrap_btSerializer_getSerializationFlags" SERIALIZER/GET-SERIALIZATION-FLAGS) :int
  (self :pointer))

(export 'SERIALIZER/GET-SERIALIZATION-FLAGS)

(declaim (inline SERIALIZER/SET-SERIALIZATION-FLAGS))

(cffi:defcfun ("_wrap_btSerializer_setSerializationFlags" SERIALIZER/SET-SERIALIZATION-FLAGS) :void
  (self :pointer)
  (flags :int))

(export 'SERIALIZER/SET-SERIALIZATION-FLAGS)

(define-constant +HEADER-LENGTH+ 12)

(export '+HEADER-LENGTH+)

(cffi:defcstruct POINTER-UID)

(export 'POINTER-UID)

(declaim (inline MAKE-DEFAULT-SERIALIZER))

(cffi:defcfun ("_wrap_new_btDefaultSerializer__SWIG_0" MAKE-DEFAULT-SERIALIZER) :pointer
  (totalSize :int))

(export 'MAKE-DEFAULT-SERIALIZER)

(declaim (inline MAKE-DEFAULT-SERIALIZER))

(cffi:defcfun ("_wrap_new_btDefaultSerializer__SWIG_1" MAKE-DEFAULT-SERIALIZER) :pointer)

(export 'MAKE-DEFAULT-SERIALIZER)

(declaim (inline DELETE/BT-DEFAULT-SERIALIZER))

(cffi:defcfun ("_wrap_delete_btDefaultSerializer" DELETE/BT-DEFAULT-SERIALIZER) :void
  (self :pointer))

(export 'DELETE/BT-DEFAULT-SERIALIZER)

(declaim (inline DEFAULT-SERIALIZER/WRITE-HEADER))

(cffi:defcfun ("_wrap_btDefaultSerializer_writeHeader" DEFAULT-SERIALIZER/WRITE-HEADER) :void
  (self :pointer)
  (buffer :pointer))

(export 'DEFAULT-SERIALIZER/WRITE-HEADER)

(declaim (inline DEFAULT-SERIALIZER/START-SERIALIZATION))

(cffi:defcfun ("_wrap_btDefaultSerializer_startSerialization" DEFAULT-SERIALIZER/START-SERIALIZATION) :void
  (self :pointer))

(export 'DEFAULT-SERIALIZER/START-SERIALIZATION)

(declaim (inline DEFAULT-SERIALIZER/FINISH-SERIALIZATION))

(cffi:defcfun ("_wrap_btDefaultSerializer_finishSerialization" DEFAULT-SERIALIZER/FINISH-SERIALIZATION) :void
  (self :pointer))

(export 'DEFAULT-SERIALIZER/FINISH-SERIALIZATION)

(declaim (inline DEFAULT-SERIALIZER/GET-UNIQUE-POINTER))

(cffi:defcfun ("_wrap_btDefaultSerializer_getUniquePointer" DEFAULT-SERIALIZER/GET-UNIQUE-POINTER) :pointer
  (self :pointer)
  (oldPtr :pointer))

(export 'DEFAULT-SERIALIZER/GET-UNIQUE-POINTER)

(declaim (inline DEFAULT-SERIALIZER/GET-BUFFER-POINTER))

(cffi:defcfun ("_wrap_btDefaultSerializer_getBufferPointer" DEFAULT-SERIALIZER/GET-BUFFER-POINTER) :pointer
  (self :pointer))

(export 'DEFAULT-SERIALIZER/GET-BUFFER-POINTER)

(declaim (inline DEFAULT-SERIALIZER/GET-CURRENT-BUFFER-SIZE))

(cffi:defcfun ("_wrap_btDefaultSerializer_getCurrentBufferSize" DEFAULT-SERIALIZER/GET-CURRENT-BUFFER-SIZE) :int
  (self :pointer))

(export 'DEFAULT-SERIALIZER/GET-CURRENT-BUFFER-SIZE)

(declaim (inline DEFAULT-SERIALIZER/FINALIZE-CHUNK))

(cffi:defcfun ("_wrap_btDefaultSerializer_finalizeChunk" DEFAULT-SERIALIZER/FINALIZE-CHUNK) :void
  (self :pointer)
  (chunk :pointer)
  (structType :string)
  (chunkCode :int)
  (oldPtr :pointer))

(export 'DEFAULT-SERIALIZER/FINALIZE-CHUNK)

(declaim (inline DEFAULT-SERIALIZER/INTERNAL-ALLOC))

(cffi:defcfun ("_wrap_btDefaultSerializer_internalAlloc" DEFAULT-SERIALIZER/INTERNAL-ALLOC) :pointer
  (self :pointer)
  (size :pointer))

(export 'DEFAULT-SERIALIZER/INTERNAL-ALLOC)

(declaim (inline DEFAULT-SERIALIZER/ALLOCATE))

(cffi:defcfun ("_wrap_btDefaultSerializer_allocate" DEFAULT-SERIALIZER/ALLOCATE) :pointer
  (self :pointer)
  (size :pointer)
  (numElements :int))

(export 'DEFAULT-SERIALIZER/ALLOCATE)

(declaim (inline DEFAULT-SERIALIZER/FIND-NAME-FOR-POINTER))

(cffi:defcfun ("_wrap_btDefaultSerializer_findNameForPointer" DEFAULT-SERIALIZER/FIND-NAME-FOR-POINTER) :string
  (self :pointer)
  (ptr :pointer))

(export 'DEFAULT-SERIALIZER/FIND-NAME-FOR-POINTER)

(declaim (inline DEFAULT-SERIALIZER/REGISTER-NAME-FOR-POINTER))

(cffi:defcfun ("_wrap_btDefaultSerializer_registerNameForPointer" DEFAULT-SERIALIZER/REGISTER-NAME-FOR-POINTER) :void
  (self :pointer)
  (ptr :pointer)
  (name :string))

(export 'DEFAULT-SERIALIZER/REGISTER-NAME-FOR-POINTER)

(declaim (inline DEFAULT-SERIALIZER/SERIALIZE-NAME))

(cffi:defcfun ("_wrap_btDefaultSerializer_serializeName" DEFAULT-SERIALIZER/SERIALIZE-NAME) :void
  (self :pointer)
  (name :string))

(export 'DEFAULT-SERIALIZER/SERIALIZE-NAME)

(declaim (inline DEFAULT-SERIALIZER/GET-SERIALIZATION-FLAGS))

(cffi:defcfun ("_wrap_btDefaultSerializer_getSerializationFlags" DEFAULT-SERIALIZER/GET-SERIALIZATION-FLAGS) :int
  (self :pointer))

(export 'DEFAULT-SERIALIZER/GET-SERIALIZATION-FLAGS)

(declaim (inline DEFAULT-SERIALIZER/SET-SERIALIZATION-FLAGS))

(cffi:defcfun ("_wrap_btDefaultSerializer_setSerializationFlags" DEFAULT-SERIALIZER/SET-SERIALIZATION-FLAGS) :void
  (self :pointer)
  (flags :int))

(export 'DEFAULT-SERIALIZER/SET-SERIALIZATION-FLAGS)

(declaim (inline DISCRETE-DYNAMICS-WORLD/MAKE-CPLUS-PLUS-INSTANCE))

(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_makeCPlusPlusInstance__SWIG_0" DISCRETE-DYNAMICS-WORLD/MAKE-CPLUS-PLUS-INSTANCE) :pointer
  (self :pointer)
  (sizeInBytes :pointer))

(export 'DISCRETE-DYNAMICS-WORLD/MAKE-CPLUS-PLUS-INSTANCE)

(declaim (inline DISCRETE-DYNAMICS-WORLD/DELETE-CPLUS-PLUS-INSTANCE))

(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_deleteCPlusPlusInstance__SWIG_0" DISCRETE-DYNAMICS-WORLD/DELETE-CPLUS-PLUS-INSTANCE) :void
  (self :pointer)
  (ptr :pointer))

(export 'DISCRETE-DYNAMICS-WORLD/DELETE-CPLUS-PLUS-INSTANCE)

(declaim (inline DISCRETE-DYNAMICS-WORLD/MAKE-CPLUS-PLUS-INSTANCE))

(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_makeCPlusPlusInstance__SWIG_1" DISCRETE-DYNAMICS-WORLD/MAKE-CPLUS-PLUS-INSTANCE) :pointer
  (self :pointer)
  (arg1 :pointer)
  (ptr :pointer))

(export 'DISCRETE-DYNAMICS-WORLD/MAKE-CPLUS-PLUS-INSTANCE)

(declaim (inline DISCRETE-DYNAMICS-WORLD/DELETE-CPLUS-PLUS-INSTANCE))

(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_deleteCPlusPlusInstance__SWIG_1" DISCRETE-DYNAMICS-WORLD/DELETE-CPLUS-PLUS-INSTANCE) :void
  (self :pointer)
  (arg1 :pointer)
  (arg2 :pointer))

(export 'DISCRETE-DYNAMICS-WORLD/DELETE-CPLUS-PLUS-INSTANCE)

(declaim (inline DISCRETE-DYNAMICS-WORLD/MAKE-CPLUS-ARRAY))

(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_makeCPlusArray__SWIG_0" DISCRETE-DYNAMICS-WORLD/MAKE-CPLUS-ARRAY) :pointer
  (self :pointer)
  (sizeInBytes :pointer))

(export 'DISCRETE-DYNAMICS-WORLD/MAKE-CPLUS-ARRAY)

(declaim (inline DISCRETE-DYNAMICS-WORLD/DELETE-CPLUS-ARRAY))

(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_deleteCPlusArray__SWIG_0" DISCRETE-DYNAMICS-WORLD/DELETE-CPLUS-ARRAY) :void
  (self :pointer)
  (ptr :pointer))

(export 'DISCRETE-DYNAMICS-WORLD/DELETE-CPLUS-ARRAY)

(declaim (inline DISCRETE-DYNAMICS-WORLD/MAKE-CPLUS-ARRAY))

(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_makeCPlusArray__SWIG_1" DISCRETE-DYNAMICS-WORLD/MAKE-CPLUS-ARRAY) :pointer
  (self :pointer)
  (arg1 :pointer)
  (ptr :pointer))

(export 'DISCRETE-DYNAMICS-WORLD/MAKE-CPLUS-ARRAY)

(declaim (inline DISCRETE-DYNAMICS-WORLD/DELETE-CPLUS-ARRAY))

(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_deleteCPlusArray__SWIG_1" DISCRETE-DYNAMICS-WORLD/DELETE-CPLUS-ARRAY) :void
  (self :pointer)
  (arg1 :pointer)
  (arg2 :pointer))

(export 'DISCRETE-DYNAMICS-WORLD/DELETE-CPLUS-ARRAY)

(declaim (inline MAKE-DISCRETE-DYNAMICS-WORLD))

(cffi:defcfun ("_wrap_new_btDiscreteDynamicsWorld" MAKE-DISCRETE-DYNAMICS-WORLD) :pointer
  (dispatcher :pointer)
  (pairCache :pointer)
  (constraintSolver :pointer)
  (collisionConfiguration :pointer))

(export 'MAKE-DISCRETE-DYNAMICS-WORLD)

(declaim (inline DELETE/BT-DISCRETE-DYNAMICS-WORLD))

(cffi:defcfun ("_wrap_delete_btDiscreteDynamicsWorld" DELETE/BT-DISCRETE-DYNAMICS-WORLD) :void
  (self :pointer))

(export 'DELETE/BT-DISCRETE-DYNAMICS-WORLD)

(declaim (inline DISCRETE-DYNAMICS-WORLD/STEP-SIMULATION))

(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_stepSimulation__SWIG_0" DISCRETE-DYNAMICS-WORLD/STEP-SIMULATION) :int
  (self :pointer)
  (timeStep :float)
  (maxSubSteps :int)
  (fixedTimeStep :float))

(export 'DISCRETE-DYNAMICS-WORLD/STEP-SIMULATION)

(declaim (inline DISCRETE-DYNAMICS-WORLD/STEP-SIMULATION))

(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_stepSimulation__SWIG_1" DISCRETE-DYNAMICS-WORLD/STEP-SIMULATION) :int
  (self :pointer)
  (timeStep :float)
  (maxSubSteps :int))

(export 'DISCRETE-DYNAMICS-WORLD/STEP-SIMULATION)

(declaim (inline DISCRETE-DYNAMICS-WORLD/STEP-SIMULATION))

(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_stepSimulation__SWIG_2" DISCRETE-DYNAMICS-WORLD/STEP-SIMULATION) :int
  (self :pointer)
  (timeStep :float))

(export 'DISCRETE-DYNAMICS-WORLD/STEP-SIMULATION)

(declaim (inline DISCRETE-DYNAMICS-WORLD/SYNCHRONIZE-MOTION-STATES))

(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_synchronizeMotionStates" DISCRETE-DYNAMICS-WORLD/SYNCHRONIZE-MOTION-STATES) :void
  (self :pointer))

(export 'DISCRETE-DYNAMICS-WORLD/SYNCHRONIZE-MOTION-STATES)

(declaim (inline DISCRETE-DYNAMICS-WORLD/SYNCHRONIZE-SINGLE-MOTION-STATE))

(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_synchronizeSingleMotionState" DISCRETE-DYNAMICS-WORLD/SYNCHRONIZE-SINGLE-MOTION-STATE) :void
  (self :pointer)
  (body :pointer))

(export 'DISCRETE-DYNAMICS-WORLD/SYNCHRONIZE-SINGLE-MOTION-STATE)

(declaim (inline DISCRETE-DYNAMICS-WORLD/ADD-CONSTRAINT))

(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_addConstraint__SWIG_0" DISCRETE-DYNAMICS-WORLD/ADD-CONSTRAINT) :void
  (self :pointer)
  (constraint :pointer)
  (disableCollisionsBetweenLinkedBodies :pointer))

(export 'DISCRETE-DYNAMICS-WORLD/ADD-CONSTRAINT)

(declaim (inline DISCRETE-DYNAMICS-WORLD/ADD-CONSTRAINT))

(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_addConstraint__SWIG_1" DISCRETE-DYNAMICS-WORLD/ADD-CONSTRAINT) :void
  (self :pointer)
  (constraint :pointer))

(export 'DISCRETE-DYNAMICS-WORLD/ADD-CONSTRAINT)

(declaim (inline DISCRETE-DYNAMICS-WORLD/REMOVE-CONSTRAINT))

(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_removeConstraint" DISCRETE-DYNAMICS-WORLD/REMOVE-CONSTRAINT) :void
  (self :pointer)
  (constraint :pointer))

(export 'DISCRETE-DYNAMICS-WORLD/REMOVE-CONSTRAINT)

(declaim (inline DISCRETE-DYNAMICS-WORLD/ADD-ACTION))

(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_addAction" DISCRETE-DYNAMICS-WORLD/ADD-ACTION) :void
  (self :pointer)
  (arg1 :pointer))

(export 'DISCRETE-DYNAMICS-WORLD/ADD-ACTION)

(declaim (inline DISCRETE-DYNAMICS-WORLD/REMOVE-ACTION))

(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_removeAction" DISCRETE-DYNAMICS-WORLD/REMOVE-ACTION) :void
  (self :pointer)
  (arg1 :pointer))

(export 'DISCRETE-DYNAMICS-WORLD/REMOVE-ACTION)

(declaim (inline DISCRETE-DYNAMICS-WORLD/GET-SIMULATION-ISLAND-MANAGER))

(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_getSimulationIslandManager__SWIG_0" DISCRETE-DYNAMICS-WORLD/GET-SIMULATION-ISLAND-MANAGER) :pointer
  (self :pointer))

(export 'DISCRETE-DYNAMICS-WORLD/GET-SIMULATION-ISLAND-MANAGER)

(declaim (inline DISCRETE-DYNAMICS-WORLD/GET-SIMULATION-ISLAND-MANAGER))

(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_getSimulationIslandManager__SWIG_1" DISCRETE-DYNAMICS-WORLD/GET-SIMULATION-ISLAND-MANAGER) :pointer
  (self :pointer))

(export 'DISCRETE-DYNAMICS-WORLD/GET-SIMULATION-ISLAND-MANAGER)

(declaim (inline DISCRETE-DYNAMICS-WORLD/GET-COLLISION-WORLD))

(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_getCollisionWorld" DISCRETE-DYNAMICS-WORLD/GET-COLLISION-WORLD) :pointer
  (self :pointer))

(export 'DISCRETE-DYNAMICS-WORLD/GET-COLLISION-WORLD)

(declaim (inline DISCRETE-DYNAMICS-WORLD/SET-GRAVITY))

(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_setGravity" DISCRETE-DYNAMICS-WORLD/SET-GRAVITY) :void
  (self :pointer)
  (gravity :pointer))

(export 'DISCRETE-DYNAMICS-WORLD/SET-GRAVITY)

(declaim (inline DISCRETE-DYNAMICS-WORLD/GET-GRAVITY))

(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_getGravity" DISCRETE-DYNAMICS-WORLD/GET-GRAVITY) :pointer
  (self :pointer))

(export 'DISCRETE-DYNAMICS-WORLD/GET-GRAVITY)

(declaim (inline DISCRETE-DYNAMICS-WORLD/ADD-COLLISION-OBJECT))

(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_addCollisionObject__SWIG_0" DISCRETE-DYNAMICS-WORLD/ADD-COLLISION-OBJECT) :void
  (self :pointer)
  (collisionObject :pointer)
  (collisionFilterGroup :short)
  (collisionFilterMask :short))

(export 'DISCRETE-DYNAMICS-WORLD/ADD-COLLISION-OBJECT)

(declaim (inline DISCRETE-DYNAMICS-WORLD/ADD-COLLISION-OBJECT))

(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_addCollisionObject__SWIG_1" DISCRETE-DYNAMICS-WORLD/ADD-COLLISION-OBJECT) :void
  (self :pointer)
  (collisionObject :pointer)
  (collisionFilterGroup :short))

(export 'DISCRETE-DYNAMICS-WORLD/ADD-COLLISION-OBJECT)

(declaim (inline DISCRETE-DYNAMICS-WORLD/ADD-COLLISION-OBJECT))

(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_addCollisionObject__SWIG_2" DISCRETE-DYNAMICS-WORLD/ADD-COLLISION-OBJECT) :void
  (self :pointer)
  (collisionObject :pointer))

(export 'DISCRETE-DYNAMICS-WORLD/ADD-COLLISION-OBJECT)

(declaim (inline DISCRETE-DYNAMICS-WORLD/ADD-RIGID-BODY))

(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_addRigidBody__SWIG_0" DISCRETE-DYNAMICS-WORLD/ADD-RIGID-BODY) :void
  (self :pointer)
  (body :pointer))

(export 'DISCRETE-DYNAMICS-WORLD/ADD-RIGID-BODY)

(declaim (inline DISCRETE-DYNAMICS-WORLD/ADD-RIGID-BODY))

(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_addRigidBody__SWIG_1" DISCRETE-DYNAMICS-WORLD/ADD-RIGID-BODY) :void
  (self :pointer)
  (body :pointer)
  (group :short)
  (mask :short))

(export 'DISCRETE-DYNAMICS-WORLD/ADD-RIGID-BODY)

(declaim (inline DISCRETE-DYNAMICS-WORLD/REMOVE-RIGID-BODY))

(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_removeRigidBody" DISCRETE-DYNAMICS-WORLD/REMOVE-RIGID-BODY) :void
  (self :pointer)
  (body :pointer))

(export 'DISCRETE-DYNAMICS-WORLD/REMOVE-RIGID-BODY)

(declaim (inline DISCRETE-DYNAMICS-WORLD/REMOVE-COLLISION-OBJECT))

(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_removeCollisionObject" DISCRETE-DYNAMICS-WORLD/REMOVE-COLLISION-OBJECT) :void
  (self :pointer)
  (collisionObject :pointer))

(export 'DISCRETE-DYNAMICS-WORLD/REMOVE-COLLISION-OBJECT)

(declaim (inline DISCRETE-DYNAMICS-WORLD/DEBUG-DRAW-CONSTRAINT))

(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_debugDrawConstraint" DISCRETE-DYNAMICS-WORLD/DEBUG-DRAW-CONSTRAINT) :void
  (self :pointer)
  (constraint :pointer))

(export 'DISCRETE-DYNAMICS-WORLD/DEBUG-DRAW-CONSTRAINT)

(declaim (inline DISCRETE-DYNAMICS-WORLD/DEBUG-DRAW-WORLD))

(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_debugDrawWorld" DISCRETE-DYNAMICS-WORLD/DEBUG-DRAW-WORLD) :void
  (self :pointer))

(export 'DISCRETE-DYNAMICS-WORLD/DEBUG-DRAW-WORLD)

(declaim (inline DISCRETE-DYNAMICS-WORLD/SET-CONSTRAINT-SOLVER))

(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_setConstraintSolver" DISCRETE-DYNAMICS-WORLD/SET-CONSTRAINT-SOLVER) :void
  (self :pointer)
  (solver :pointer))

(export 'DISCRETE-DYNAMICS-WORLD/SET-CONSTRAINT-SOLVER)

(declaim (inline DISCRETE-DYNAMICS-WORLD/GET-CONSTRAINT-SOLVER))

(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_getConstraintSolver" DISCRETE-DYNAMICS-WORLD/GET-CONSTRAINT-SOLVER) :pointer
  (self :pointer))

(export 'DISCRETE-DYNAMICS-WORLD/GET-CONSTRAINT-SOLVER)

(declaim (inline DISCRETE-DYNAMICS-WORLD/GET-NUM-CONSTRAINTS))

(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_getNumConstraints" DISCRETE-DYNAMICS-WORLD/GET-NUM-CONSTRAINTS) :int
  (self :pointer))

(export 'DISCRETE-DYNAMICS-WORLD/GET-NUM-CONSTRAINTS)

(declaim (inline DISCRETE-DYNAMICS-WORLD/GET-CONSTRAINT))

(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_getConstraint__SWIG_0" DISCRETE-DYNAMICS-WORLD/GET-CONSTRAINT) :pointer
  (self :pointer)
  (index :int))

(export 'DISCRETE-DYNAMICS-WORLD/GET-CONSTRAINT)

(declaim (inline DISCRETE-DYNAMICS-WORLD/GET-CONSTRAINT))

(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_getConstraint__SWIG_1" DISCRETE-DYNAMICS-WORLD/GET-CONSTRAINT) :pointer
  (self :pointer)
  (index :int))

(export 'DISCRETE-DYNAMICS-WORLD/GET-CONSTRAINT)

(declaim (inline DISCRETE-DYNAMICS-WORLD/GET-WORLD-TYPE))

(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_getWorldType" DISCRETE-DYNAMICS-WORLD/GET-WORLD-TYPE) :pointer
  (self :pointer))

(export 'DISCRETE-DYNAMICS-WORLD/GET-WORLD-TYPE)

(declaim (inline DISCRETE-DYNAMICS-WORLD/CLEAR-FORCES))

(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_clearForces" DISCRETE-DYNAMICS-WORLD/CLEAR-FORCES) :void
  (self :pointer))

(export 'DISCRETE-DYNAMICS-WORLD/CLEAR-FORCES)

(declaim (inline DISCRETE-DYNAMICS-WORLD/APPLY-GRAVITY))

(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_applyGravity" DISCRETE-DYNAMICS-WORLD/APPLY-GRAVITY) :void
  (self :pointer))

(export 'DISCRETE-DYNAMICS-WORLD/APPLY-GRAVITY)

(declaim (inline DISCRETE-DYNAMICS-WORLD/SET-NUM-TASKS))

(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_setNumTasks" DISCRETE-DYNAMICS-WORLD/SET-NUM-TASKS) :void
  (self :pointer)
  (numTasks :int))

(export 'DISCRETE-DYNAMICS-WORLD/SET-NUM-TASKS)

(declaim (inline DISCRETE-DYNAMICS-WORLD/UPDATE-VEHICLES))

(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_updateVehicles" DISCRETE-DYNAMICS-WORLD/UPDATE-VEHICLES) :void
  (self :pointer)
  (timeStep :float))

(export 'DISCRETE-DYNAMICS-WORLD/UPDATE-VEHICLES)

(declaim (inline DISCRETE-DYNAMICS-WORLD/ADD-VEHICLE))

(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_addVehicle" DISCRETE-DYNAMICS-WORLD/ADD-VEHICLE) :void
  (self :pointer)
  (vehicle :pointer))

(export 'DISCRETE-DYNAMICS-WORLD/ADD-VEHICLE)

(declaim (inline DISCRETE-DYNAMICS-WORLD/REMOVE-VEHICLE))

(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_removeVehicle" DISCRETE-DYNAMICS-WORLD/REMOVE-VEHICLE) :void
  (self :pointer)
  (vehicle :pointer))

(export 'DISCRETE-DYNAMICS-WORLD/REMOVE-VEHICLE)

(declaim (inline DISCRETE-DYNAMICS-WORLD/ADD-CHARACTER))

(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_addCharacter" DISCRETE-DYNAMICS-WORLD/ADD-CHARACTER) :void
  (self :pointer)
  (character :pointer))

(export 'DISCRETE-DYNAMICS-WORLD/ADD-CHARACTER)

(declaim (inline DISCRETE-DYNAMICS-WORLD/REMOVE-CHARACTER))

(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_removeCharacter" DISCRETE-DYNAMICS-WORLD/REMOVE-CHARACTER) :void
  (self :pointer)
  (character :pointer))

(export 'DISCRETE-DYNAMICS-WORLD/REMOVE-CHARACTER)

(declaim (inline DISCRETE-DYNAMICS-WORLD/SET-SYNCHRONIZE-ALL-MOTION-STATES))

(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_setSynchronizeAllMotionStates" DISCRETE-DYNAMICS-WORLD/SET-SYNCHRONIZE-ALL-MOTION-STATES) :void
  (self :pointer)
  (synchronizeAll :pointer))

(export 'DISCRETE-DYNAMICS-WORLD/SET-SYNCHRONIZE-ALL-MOTION-STATES)

(declaim (inline DISCRETE-DYNAMICS-WORLD/GET-SYNCHRONIZE-ALL-MOTION-STATES))

(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_getSynchronizeAllMotionStates" DISCRETE-DYNAMICS-WORLD/GET-SYNCHRONIZE-ALL-MOTION-STATES) :pointer
  (self :pointer))

(export 'DISCRETE-DYNAMICS-WORLD/GET-SYNCHRONIZE-ALL-MOTION-STATES)

(declaim (inline DISCRETE-DYNAMICS-WORLD/SET-APPLY-SPECULATIVE-CONTACT-RESTITUTION))

(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_setApplySpeculativeContactRestitution" DISCRETE-DYNAMICS-WORLD/SET-APPLY-SPECULATIVE-CONTACT-RESTITUTION) :void
  (self :pointer)
  (enable :pointer))

(export 'DISCRETE-DYNAMICS-WORLD/SET-APPLY-SPECULATIVE-CONTACT-RESTITUTION)

(declaim (inline DISCRETE-DYNAMICS-WORLD/GET-APPLY-SPECULATIVE-CONTACT-RESTITUTION))

(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_getApplySpeculativeContactRestitution" DISCRETE-DYNAMICS-WORLD/GET-APPLY-SPECULATIVE-CONTACT-RESTITUTION) :pointer
  (self :pointer))

(export 'DISCRETE-DYNAMICS-WORLD/GET-APPLY-SPECULATIVE-CONTACT-RESTITUTION)

(declaim (inline DISCRETE-DYNAMICS-WORLD/SERIALIZE))

(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_serialize" DISCRETE-DYNAMICS-WORLD/SERIALIZE) :void
  (self :pointer)
  (serializer :pointer))

(export 'DISCRETE-DYNAMICS-WORLD/SERIALIZE)

(declaim (inline DISCRETE-DYNAMICS-WORLD/SET-LATENCY-MOTION-STATE-INTERPOLATION))

(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_setLatencyMotionStateInterpolation" DISCRETE-DYNAMICS-WORLD/SET-LATENCY-MOTION-STATE-INTERPOLATION) :void
  (self :pointer)
  (latencyInterpolation :pointer))

(export 'DISCRETE-DYNAMICS-WORLD/SET-LATENCY-MOTION-STATE-INTERPOLATION)

(declaim (inline DISCRETE-DYNAMICS-WORLD/GET-LATENCY-MOTION-STATE-INTERPOLATION))

(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_getLatencyMotionStateInterpolation" DISCRETE-DYNAMICS-WORLD/GET-LATENCY-MOTION-STATE-INTERPOLATION) :pointer
  (self :pointer))

(export 'DISCRETE-DYNAMICS-WORLD/GET-LATENCY-MOTION-STATE-INTERPOLATION)

(declaim (inline MAKE-SIMPLE-DYNAMICS-WORLD))

(cffi:defcfun ("_wrap_new_btSimpleDynamicsWorld" MAKE-SIMPLE-DYNAMICS-WORLD) :pointer
  (dispatcher :pointer)
  (pairCache :pointer)
  (constraintSolver :pointer)
  (collisionConfiguration :pointer))

(export 'MAKE-SIMPLE-DYNAMICS-WORLD)

(declaim (inline DELETE/BT-SIMPLE-DYNAMICS-WORLD))

(cffi:defcfun ("_wrap_delete_btSimpleDynamicsWorld" DELETE/BT-SIMPLE-DYNAMICS-WORLD) :void
  (self :pointer))

(export 'DELETE/BT-SIMPLE-DYNAMICS-WORLD)

(declaim (inline SIMPLE-DYNAMICS-WORLD/STEP-SIMULATION))

(cffi:defcfun ("_wrap_btSimpleDynamicsWorld_stepSimulation__SWIG_0" SIMPLE-DYNAMICS-WORLD/STEP-SIMULATION) :int
  (self :pointer)
  (timeStep :float)
  (maxSubSteps :int)
  (fixedTimeStep :float))

(export 'SIMPLE-DYNAMICS-WORLD/STEP-SIMULATION)

(declaim (inline SIMPLE-DYNAMICS-WORLD/STEP-SIMULATION))

(cffi:defcfun ("_wrap_btSimpleDynamicsWorld_stepSimulation__SWIG_1" SIMPLE-DYNAMICS-WORLD/STEP-SIMULATION) :int
  (self :pointer)
  (timeStep :float)
  (maxSubSteps :int))

(export 'SIMPLE-DYNAMICS-WORLD/STEP-SIMULATION)

(declaim (inline SIMPLE-DYNAMICS-WORLD/STEP-SIMULATION))

(cffi:defcfun ("_wrap_btSimpleDynamicsWorld_stepSimulation__SWIG_2" SIMPLE-DYNAMICS-WORLD/STEP-SIMULATION) :int
  (self :pointer)
  (timeStep :float))

(export 'SIMPLE-DYNAMICS-WORLD/STEP-SIMULATION)

(declaim (inline SIMPLE-DYNAMICS-WORLD/SET-GRAVITY))

(cffi:defcfun ("_wrap_btSimpleDynamicsWorld_setGravity" SIMPLE-DYNAMICS-WORLD/SET-GRAVITY) :void
  (self :pointer)
  (gravity :pointer))

(export 'SIMPLE-DYNAMICS-WORLD/SET-GRAVITY)

(declaim (inline SIMPLE-DYNAMICS-WORLD/GET-GRAVITY))

(cffi:defcfun ("_wrap_btSimpleDynamicsWorld_getGravity" SIMPLE-DYNAMICS-WORLD/GET-GRAVITY) :pointer
  (self :pointer))

(export 'SIMPLE-DYNAMICS-WORLD/GET-GRAVITY)

(declaim (inline SIMPLE-DYNAMICS-WORLD/ADD-RIGID-BODY))

(cffi:defcfun ("_wrap_btSimpleDynamicsWorld_addRigidBody__SWIG_0" SIMPLE-DYNAMICS-WORLD/ADD-RIGID-BODY) :void
  (self :pointer)
  (body :pointer))

(export 'SIMPLE-DYNAMICS-WORLD/ADD-RIGID-BODY)

(declaim (inline SIMPLE-DYNAMICS-WORLD/ADD-RIGID-BODY))

(cffi:defcfun ("_wrap_btSimpleDynamicsWorld_addRigidBody__SWIG_1" SIMPLE-DYNAMICS-WORLD/ADD-RIGID-BODY) :void
  (self :pointer)
  (body :pointer)
  (group :short)
  (mask :short))

(export 'SIMPLE-DYNAMICS-WORLD/ADD-RIGID-BODY)

(declaim (inline SIMPLE-DYNAMICS-WORLD/REMOVE-RIGID-BODY))

(cffi:defcfun ("_wrap_btSimpleDynamicsWorld_removeRigidBody" SIMPLE-DYNAMICS-WORLD/REMOVE-RIGID-BODY) :void
  (self :pointer)
  (body :pointer))

(export 'SIMPLE-DYNAMICS-WORLD/REMOVE-RIGID-BODY)

(declaim (inline SIMPLE-DYNAMICS-WORLD/DEBUG-DRAW-WORLD))

(cffi:defcfun ("_wrap_btSimpleDynamicsWorld_debugDrawWorld" SIMPLE-DYNAMICS-WORLD/DEBUG-DRAW-WORLD) :void
  (self :pointer))

(export 'SIMPLE-DYNAMICS-WORLD/DEBUG-DRAW-WORLD)

(declaim (inline SIMPLE-DYNAMICS-WORLD/ADD-ACTION))

(cffi:defcfun ("_wrap_btSimpleDynamicsWorld_addAction" SIMPLE-DYNAMICS-WORLD/ADD-ACTION) :void
  (self :pointer)
  (action :pointer))

(export 'SIMPLE-DYNAMICS-WORLD/ADD-ACTION)

(declaim (inline SIMPLE-DYNAMICS-WORLD/REMOVE-ACTION))

(cffi:defcfun ("_wrap_btSimpleDynamicsWorld_removeAction" SIMPLE-DYNAMICS-WORLD/REMOVE-ACTION) :void
  (self :pointer)
  (action :pointer))

(export 'SIMPLE-DYNAMICS-WORLD/REMOVE-ACTION)

(declaim (inline SIMPLE-DYNAMICS-WORLD/REMOVE-COLLISION-OBJECT))

(cffi:defcfun ("_wrap_btSimpleDynamicsWorld_removeCollisionObject" SIMPLE-DYNAMICS-WORLD/REMOVE-COLLISION-OBJECT) :void
  (self :pointer)
  (collisionObject :pointer))

(export 'SIMPLE-DYNAMICS-WORLD/REMOVE-COLLISION-OBJECT)

(declaim (inline SIMPLE-DYNAMICS-WORLD/UPDATE-AABBS))

(cffi:defcfun ("_wrap_btSimpleDynamicsWorld_updateAabbs" SIMPLE-DYNAMICS-WORLD/UPDATE-AABBS) :void
  (self :pointer))

(export 'SIMPLE-DYNAMICS-WORLD/UPDATE-AABBS)

(declaim (inline SIMPLE-DYNAMICS-WORLD/SYNCHRONIZE-MOTION-STATES))

(cffi:defcfun ("_wrap_btSimpleDynamicsWorld_synchronizeMotionStates" SIMPLE-DYNAMICS-WORLD/SYNCHRONIZE-MOTION-STATES) :void
  (self :pointer))

(export 'SIMPLE-DYNAMICS-WORLD/SYNCHRONIZE-MOTION-STATES)

(declaim (inline SIMPLE-DYNAMICS-WORLD/SET-CONSTRAINT-SOLVER))

(cffi:defcfun ("_wrap_btSimpleDynamicsWorld_setConstraintSolver" SIMPLE-DYNAMICS-WORLD/SET-CONSTRAINT-SOLVER) :void
  (self :pointer)
  (solver :pointer))

(export 'SIMPLE-DYNAMICS-WORLD/SET-CONSTRAINT-SOLVER)

(declaim (inline SIMPLE-DYNAMICS-WORLD/GET-CONSTRAINT-SOLVER))

(cffi:defcfun ("_wrap_btSimpleDynamicsWorld_getConstraintSolver" SIMPLE-DYNAMICS-WORLD/GET-CONSTRAINT-SOLVER) :pointer
  (self :pointer))

(export 'SIMPLE-DYNAMICS-WORLD/GET-CONSTRAINT-SOLVER)

(declaim (inline SIMPLE-DYNAMICS-WORLD/GET-WORLD-TYPE))

(cffi:defcfun ("_wrap_btSimpleDynamicsWorld_getWorldType" SIMPLE-DYNAMICS-WORLD/GET-WORLD-TYPE) :pointer
  (self :pointer))

(export 'SIMPLE-DYNAMICS-WORLD/GET-WORLD-TYPE)

(declaim (inline SIMPLE-DYNAMICS-WORLD/CLEAR-FORCES))

(cffi:defcfun ("_wrap_btSimpleDynamicsWorld_clearForces" SIMPLE-DYNAMICS-WORLD/CLEAR-FORCES) :void
  (self :pointer))

(export 'SIMPLE-DYNAMICS-WORLD/CLEAR-FORCES)

(cffi:defcvar ("gDeactivationTime" *DEACTIVATION-TIME*)
 :float)

(export '*DEACTIVATION-TIME*)

(cffi:defcvar ("gDisableDeactivation" *DISABLE-DEACTIVATION*)
 :pointer)

(export '*DISABLE-DEACTIVATION*)

(define-constant +RIGID-BODY-DATA-NAME+ "btRigidBodyFloatData" :test 'equal)

(export '+RIGID-BODY-DATA-NAME+)

(cffi:defcenum RIGID-BODY-FLAGS
  (:DISABLE-WORLD-GRAVITY #.1)
  (:ENABLE-GYROPSCOPIC-FORCE #.2))

(export 'RIGID-BODY-FLAGS)

(declaim (inline MAKE-RIGID-BODY))

(cffi:defcfun ("_wrap_new_btRigidBody__SWIG_0" MAKE-RIGID-BODY) :pointer
  (constructionInfo :pointer))

(export 'MAKE-RIGID-BODY)

(declaim (inline MAKE-RIGID-BODY))

(cffi:defcfun ("_wrap_new_btRigidBody__SWIG_1" MAKE-RIGID-BODY) :pointer
  (mass :float)
  (motionState :pointer)
  (collisionShape :pointer)
  (localInertia :pointer))

(export 'MAKE-RIGID-BODY)

(declaim (inline MAKE-RIGID-BODY))

(cffi:defcfun ("_wrap_new_btRigidBody__SWIG_2" MAKE-RIGID-BODY) :pointer
  (mass :float)
  (motionState :pointer)
  (collisionShape :pointer))

(export 'MAKE-RIGID-BODY)

(declaim (inline DELETE/BT-RIGID-BODY))

(cffi:defcfun ("_wrap_delete_btRigidBody" DELETE/BT-RIGID-BODY) :void
  (self :pointer))

(export 'DELETE/BT-RIGID-BODY)

(declaim (inline RIGID-BODY/PROCEED-TO-TRANSFORM))

(cffi:defcfun ("_wrap_btRigidBody_proceedToTransform" RIGID-BODY/PROCEED-TO-TRANSFORM) :void
  (self :pointer)
  (newTrans :pointer))

(export 'RIGID-BODY/PROCEED-TO-TRANSFORM)

(declaim (inline RIGID-BODY/UPCAST))

(cffi:defcfun ("_wrap_btRigidBody_upcast__SWIG_0" RIGID-BODY/UPCAST) :pointer
  (colObj :pointer))

(export 'RIGID-BODY/UPCAST)

(declaim (inline RIGID-BODY/UPCAST))

(cffi:defcfun ("_wrap_btRigidBody_upcast__SWIG_1" RIGID-BODY/UPCAST) :pointer
  (colObj :pointer))

(export 'RIGID-BODY/UPCAST)

(declaim (inline RIGID-BODY/PREDICT-INTEGRATED-TRANSFORM))

(cffi:defcfun ("_wrap_btRigidBody_predictIntegratedTransform" RIGID-BODY/PREDICT-INTEGRATED-TRANSFORM) :void
  (self :pointer)
  (step :float)
  (predictedTransform :pointer))

(export 'RIGID-BODY/PREDICT-INTEGRATED-TRANSFORM)

(declaim (inline RIGID-BODY/SAVE-KINEMATIC-STATE))

(cffi:defcfun ("_wrap_btRigidBody_saveKinematicState" RIGID-BODY/SAVE-KINEMATIC-STATE) :void
  (self :pointer)
  (step :float))

(export 'RIGID-BODY/SAVE-KINEMATIC-STATE)

(declaim (inline RIGID-BODY/APPLY-GRAVITY))

(cffi:defcfun ("_wrap_btRigidBody_applyGravity" RIGID-BODY/APPLY-GRAVITY) :void
  (self :pointer))

(export 'RIGID-BODY/APPLY-GRAVITY)

(declaim (inline RIGID-BODY/SET-GRAVITY))

(cffi:defcfun ("_wrap_btRigidBody_setGravity" RIGID-BODY/SET-GRAVITY) :void
  (self :pointer)
  (acceleration :pointer))

(export 'RIGID-BODY/SET-GRAVITY)

(declaim (inline RIGID-BODY/GET-GRAVITY))

(cffi:defcfun ("_wrap_btRigidBody_getGravity" RIGID-BODY/GET-GRAVITY) :pointer
  (self :pointer))

(export 'RIGID-BODY/GET-GRAVITY)

(declaim (inline RIGID-BODY/SET-DAMPING))

(cffi:defcfun ("_wrap_btRigidBody_setDamping" RIGID-BODY/SET-DAMPING) :void
  (self :pointer)
  (lin_damping :float)
  (ang_damping :float))

(export 'RIGID-BODY/SET-DAMPING)

(declaim (inline RIGID-BODY/GET-LINEAR-DAMPING))

(cffi:defcfun ("_wrap_btRigidBody_getLinearDamping" RIGID-BODY/GET-LINEAR-DAMPING) :float
  (self :pointer))

(export 'RIGID-BODY/GET-LINEAR-DAMPING)

(declaim (inline RIGID-BODY/GET-ANGULAR-DAMPING))

(cffi:defcfun ("_wrap_btRigidBody_getAngularDamping" RIGID-BODY/GET-ANGULAR-DAMPING) :float
  (self :pointer))

(export 'RIGID-BODY/GET-ANGULAR-DAMPING)

(declaim (inline RIGID-BODY/GET-LINEAR-SLEEPING-THRESHOLD))

(cffi:defcfun ("_wrap_btRigidBody_getLinearSleepingThreshold" RIGID-BODY/GET-LINEAR-SLEEPING-THRESHOLD) :float
  (self :pointer))

(export 'RIGID-BODY/GET-LINEAR-SLEEPING-THRESHOLD)

(declaim (inline RIGID-BODY/GET-ANGULAR-SLEEPING-THRESHOLD))

(cffi:defcfun ("_wrap_btRigidBody_getAngularSleepingThreshold" RIGID-BODY/GET-ANGULAR-SLEEPING-THRESHOLD) :float
  (self :pointer))

(export 'RIGID-BODY/GET-ANGULAR-SLEEPING-THRESHOLD)

(declaim (inline RIGID-BODY/APPLY-DAMPING))

(cffi:defcfun ("_wrap_btRigidBody_applyDamping" RIGID-BODY/APPLY-DAMPING) :void
  (self :pointer)
  (timeStep :float))

(export 'RIGID-BODY/APPLY-DAMPING)

(declaim (inline RIGID-BODY/GET-COLLISION-SHAPE))

(cffi:defcfun ("_wrap_btRigidBody_getCollisionShape__SWIG_0" RIGID-BODY/GET-COLLISION-SHAPE) :pointer
  (self :pointer))

(export 'RIGID-BODY/GET-COLLISION-SHAPE)

(declaim (inline RIGID-BODY/GET-COLLISION-SHAPE))

(cffi:defcfun ("_wrap_btRigidBody_getCollisionShape__SWIG_1" RIGID-BODY/GET-COLLISION-SHAPE) :pointer
  (self :pointer))

(export 'RIGID-BODY/GET-COLLISION-SHAPE)

(declaim (inline RIGID-BODY/SET-MASS-PROPS))

(cffi:defcfun ("_wrap_btRigidBody_setMassProps" RIGID-BODY/SET-MASS-PROPS) :void
  (self :pointer)
  (mass :float)
  (inertia :pointer))

(export 'RIGID-BODY/SET-MASS-PROPS)

(declaim (inline RIGID-BODY/GET-LINEAR-FACTOR))

(cffi:defcfun ("_wrap_btRigidBody_getLinearFactor" RIGID-BODY/GET-LINEAR-FACTOR) :pointer
  (self :pointer))

(export 'RIGID-BODY/GET-LINEAR-FACTOR)

(declaim (inline RIGID-BODY/SET-LINEAR-FACTOR))

(cffi:defcfun ("_wrap_btRigidBody_setLinearFactor" RIGID-BODY/SET-LINEAR-FACTOR) :void
  (self :pointer)
  (linearFactor :pointer))

(export 'RIGID-BODY/SET-LINEAR-FACTOR)

(declaim (inline RIGID-BODY/GET-INV-MASS))

(cffi:defcfun ("_wrap_btRigidBody_getInvMass" RIGID-BODY/GET-INV-MASS) :float
  (self :pointer))

(export 'RIGID-BODY/GET-INV-MASS)

(declaim (inline RIGID-BODY/GET-INV-INERTIA-TENSOR-WORLD))

(cffi:defcfun ("_wrap_btRigidBody_getInvInertiaTensorWorld" RIGID-BODY/GET-INV-INERTIA-TENSOR-WORLD) :pointer
  (self :pointer))

(export 'RIGID-BODY/GET-INV-INERTIA-TENSOR-WORLD)

(declaim (inline RIGID-BODY/INTEGRATE-VELOCITIES))

(cffi:defcfun ("_wrap_btRigidBody_integrateVelocities" RIGID-BODY/INTEGRATE-VELOCITIES) :void
  (self :pointer)
  (step :float))

(export 'RIGID-BODY/INTEGRATE-VELOCITIES)

(declaim (inline RIGID-BODY/SET-CENTER-OF-MASS-TRANSFORM))

(cffi:defcfun ("_wrap_btRigidBody_setCenterOfMassTransform" RIGID-BODY/SET-CENTER-OF-MASS-TRANSFORM) :void
  (self :pointer)
  (xform :pointer))

(export 'RIGID-BODY/SET-CENTER-OF-MASS-TRANSFORM)

(declaim (inline RIGID-BODY/APPLY-CENTRAL-FORCE))

(cffi:defcfun ("_wrap_btRigidBody_applyCentralForce" RIGID-BODY/APPLY-CENTRAL-FORCE) :void
  (self :pointer)
  (force :pointer))

(export 'RIGID-BODY/APPLY-CENTRAL-FORCE)

(declaim (inline RIGID-BODY/GET-TOTAL-FORCE))

(cffi:defcfun ("_wrap_btRigidBody_getTotalForce" RIGID-BODY/GET-TOTAL-FORCE) :pointer
  (self :pointer))

(export 'RIGID-BODY/GET-TOTAL-FORCE)

(declaim (inline RIGID-BODY/GET-TOTAL-TORQUE))

(cffi:defcfun ("_wrap_btRigidBody_getTotalTorque" RIGID-BODY/GET-TOTAL-TORQUE) :pointer
  (self :pointer))

(export 'RIGID-BODY/GET-TOTAL-TORQUE)

(declaim (inline RIGID-BODY/GET-INV-INERTIA-DIAG-LOCAL))

(cffi:defcfun ("_wrap_btRigidBody_getInvInertiaDiagLocal" RIGID-BODY/GET-INV-INERTIA-DIAG-LOCAL) :pointer
  (self :pointer))

(export 'RIGID-BODY/GET-INV-INERTIA-DIAG-LOCAL)

(declaim (inline RIGID-BODY/SET-INV-INERTIA-DIAG-LOCAL))

(cffi:defcfun ("_wrap_btRigidBody_setInvInertiaDiagLocal" RIGID-BODY/SET-INV-INERTIA-DIAG-LOCAL) :void
  (self :pointer)
  (diagInvInertia :pointer))

(export 'RIGID-BODY/SET-INV-INERTIA-DIAG-LOCAL)

(declaim (inline RIGID-BODY/SET-SLEEPING-THRESHOLDS))

(cffi:defcfun ("_wrap_btRigidBody_setSleepingThresholds" RIGID-BODY/SET-SLEEPING-THRESHOLDS) :void
  (self :pointer)
  (linear :float)
  (angular :float))

(export 'RIGID-BODY/SET-SLEEPING-THRESHOLDS)

(declaim (inline RIGID-BODY/APPLY-TORQUE))

(cffi:defcfun ("_wrap_btRigidBody_applyTorque" RIGID-BODY/APPLY-TORQUE) :void
  (self :pointer)
  (torque :pointer))

(export 'RIGID-BODY/APPLY-TORQUE)

(declaim (inline RIGID-BODY/APPLY-FORCE))

(cffi:defcfun ("_wrap_btRigidBody_applyForce" RIGID-BODY/APPLY-FORCE) :void
  (self :pointer)
  (force :pointer)
  (rel_pos :pointer))

(export 'RIGID-BODY/APPLY-FORCE)

(declaim (inline RIGID-BODY/APPLY-CENTRAL-IMPULSE))

(cffi:defcfun ("_wrap_btRigidBody_applyCentralImpulse" RIGID-BODY/APPLY-CENTRAL-IMPULSE) :void
  (self :pointer)
  (impulse :pointer))

(export 'RIGID-BODY/APPLY-CENTRAL-IMPULSE)

(declaim (inline RIGID-BODY/APPLY-TORQUE-IMPULSE))

(cffi:defcfun ("_wrap_btRigidBody_applyTorqueImpulse" RIGID-BODY/APPLY-TORQUE-IMPULSE) :void
  (self :pointer)
  (torque :pointer))

(export 'RIGID-BODY/APPLY-TORQUE-IMPULSE)

(declaim (inline RIGID-BODY/APPLY-IMPULSE))

(cffi:defcfun ("_wrap_btRigidBody_applyImpulse" RIGID-BODY/APPLY-IMPULSE) :void
  (self :pointer)
  (impulse :pointer)
  (rel_pos :pointer))

(export 'RIGID-BODY/APPLY-IMPULSE)

(declaim (inline RIGID-BODY/CLEAR-FORCES))

(cffi:defcfun ("_wrap_btRigidBody_clearForces" RIGID-BODY/CLEAR-FORCES) :void
  (self :pointer))

(export 'RIGID-BODY/CLEAR-FORCES)

(declaim (inline RIGID-BODY/UPDATE-INERTIA-TENSOR))

(cffi:defcfun ("_wrap_btRigidBody_updateInertiaTensor" RIGID-BODY/UPDATE-INERTIA-TENSOR) :void
  (self :pointer))

(export 'RIGID-BODY/UPDATE-INERTIA-TENSOR)

(declaim (inline RIGID-BODY/GET-CENTER-OF-MASS-POSITION))

(cffi:defcfun ("_wrap_btRigidBody_getCenterOfMassPosition" RIGID-BODY/GET-CENTER-OF-MASS-POSITION) :pointer
  (self :pointer))

(export 'RIGID-BODY/GET-CENTER-OF-MASS-POSITION)

(declaim (inline RIGID-BODY/GET-ORIENTATION))

(cffi:defcfun ("_wrap_btRigidBody_getOrientation" RIGID-BODY/GET-ORIENTATION) :pointer
  (self :pointer))

(export 'RIGID-BODY/GET-ORIENTATION)

(declaim (inline RIGID-BODY/GET-CENTER-OF-MASS-TRANSFORM))

(cffi:defcfun ("_wrap_btRigidBody_getCenterOfMassTransform" RIGID-BODY/GET-CENTER-OF-MASS-TRANSFORM) :pointer
  (self :pointer))

(export 'RIGID-BODY/GET-CENTER-OF-MASS-TRANSFORM)

(declaim (inline RIGID-BODY/GET-LINEAR-VELOCITY))

(cffi:defcfun ("_wrap_btRigidBody_getLinearVelocity" RIGID-BODY/GET-LINEAR-VELOCITY) :pointer
  (self :pointer))

(export 'RIGID-BODY/GET-LINEAR-VELOCITY)

(declaim (inline RIGID-BODY/GET-ANGULAR-VELOCITY))

(cffi:defcfun ("_wrap_btRigidBody_getAngularVelocity" RIGID-BODY/GET-ANGULAR-VELOCITY) :pointer
  (self :pointer))

(export 'RIGID-BODY/GET-ANGULAR-VELOCITY)

(declaim (inline RIGID-BODY/SET-LINEAR-VELOCITY))

(cffi:defcfun ("_wrap_btRigidBody_setLinearVelocity" RIGID-BODY/SET-LINEAR-VELOCITY) :void
  (self :pointer)
  (lin_vel :pointer))

(export 'RIGID-BODY/SET-LINEAR-VELOCITY)

(declaim (inline RIGID-BODY/SET-ANGULAR-VELOCITY))

(cffi:defcfun ("_wrap_btRigidBody_setAngularVelocity" RIGID-BODY/SET-ANGULAR-VELOCITY) :void
  (self :pointer)
  (ang_vel :pointer))

(export 'RIGID-BODY/SET-ANGULAR-VELOCITY)

(declaim (inline RIGID-BODY/GET-VELOCITY-IN-LOCAL-POINT))

(cffi:defcfun ("_wrap_btRigidBody_getVelocityInLocalPoint" RIGID-BODY/GET-VELOCITY-IN-LOCAL-POINT) :pointer
  (self :pointer)
  (rel_pos :pointer))

(export 'RIGID-BODY/GET-VELOCITY-IN-LOCAL-POINT)

(declaim (inline RIGID-BODY/TRANSLATE))

(cffi:defcfun ("_wrap_btRigidBody_translate" RIGID-BODY/TRANSLATE) :void
  (self :pointer)
  (v :pointer))

(export 'RIGID-BODY/TRANSLATE)

(declaim (inline RIGID-BODY/GET-AABB))

(cffi:defcfun ("_wrap_btRigidBody_getAabb" RIGID-BODY/GET-AABB) :void
  (self :pointer)
  (aabbMin :pointer)
  (aabbMax :pointer))

(export 'RIGID-BODY/GET-AABB)

(declaim (inline RIGID-BODY/COMPUTE-IMPULSE-DENOMINATOR))

(cffi:defcfun ("_wrap_btRigidBody_computeImpulseDenominator" RIGID-BODY/COMPUTE-IMPULSE-DENOMINATOR) :float
  (self :pointer)
  (pos :pointer)
  (normal :pointer))

(export 'RIGID-BODY/COMPUTE-IMPULSE-DENOMINATOR)

(declaim (inline RIGID-BODY/COMPUTE-ANGULAR-IMPULSE-DENOMINATOR))

(cffi:defcfun ("_wrap_btRigidBody_computeAngularImpulseDenominator" RIGID-BODY/COMPUTE-ANGULAR-IMPULSE-DENOMINATOR) :float
  (self :pointer)
  (axis :pointer))

(export 'RIGID-BODY/COMPUTE-ANGULAR-IMPULSE-DENOMINATOR)

(declaim (inline RIGID-BODY/UPDATE-DEACTIVATION))

(cffi:defcfun ("_wrap_btRigidBody_updateDeactivation" RIGID-BODY/UPDATE-DEACTIVATION) :void
  (self :pointer)
  (timeStep :float))

(export 'RIGID-BODY/UPDATE-DEACTIVATION)

(declaim (inline RIGID-BODY/WANTS-SLEEPING))

(cffi:defcfun ("_wrap_btRigidBody_wantsSleeping" RIGID-BODY/WANTS-SLEEPING) :pointer
  (self :pointer))

(export 'RIGID-BODY/WANTS-SLEEPING)

(declaim (inline RIGID-BODY/GET-BROADPHASE-PROXY))

(cffi:defcfun ("_wrap_btRigidBody_getBroadphaseProxy__SWIG_0" RIGID-BODY/GET-BROADPHASE-PROXY) :pointer
  (self :pointer))

(export 'RIGID-BODY/GET-BROADPHASE-PROXY)

(declaim (inline RIGID-BODY/GET-BROADPHASE-PROXY))

(cffi:defcfun ("_wrap_btRigidBody_getBroadphaseProxy__SWIG_1" RIGID-BODY/GET-BROADPHASE-PROXY) :pointer
  (self :pointer))

(export 'RIGID-BODY/GET-BROADPHASE-PROXY)

(declaim (inline RIGID-BODY/SET-NEW-BROADPHASE-PROXY))

(cffi:defcfun ("_wrap_btRigidBody_setNewBroadphaseProxy" RIGID-BODY/SET-NEW-BROADPHASE-PROXY) :void
  (self :pointer)
  (broadphaseProxy :pointer))

(export 'RIGID-BODY/SET-NEW-BROADPHASE-PROXY)

(declaim (inline RIGID-BODY/GET-MOTION-STATE))

(cffi:defcfun ("_wrap_btRigidBody_getMotionState__SWIG_0" RIGID-BODY/GET-MOTION-STATE) :pointer
  (self :pointer))

(export 'RIGID-BODY/GET-MOTION-STATE)

(declaim (inline RIGID-BODY/GET-MOTION-STATE))

(cffi:defcfun ("_wrap_btRigidBody_getMotionState__SWIG_1" RIGID-BODY/GET-MOTION-STATE) :pointer
  (self :pointer))

(export 'RIGID-BODY/GET-MOTION-STATE)

(declaim (inline RIGID-BODY/SET-MOTION-STATE))

(cffi:defcfun ("_wrap_btRigidBody_setMotionState" RIGID-BODY/SET-MOTION-STATE) :void
  (self :pointer)
  (motionState :pointer))

(export 'RIGID-BODY/SET-MOTION-STATE)

(declaim (inline RIGID-BODY/M/CONTACT-SOLVER-TYPE/SET))

(cffi:defcfun ("_wrap_btRigidBody_m_contactSolverType_set" RIGID-BODY/M/CONTACT-SOLVER-TYPE/SET) :void
  (self :pointer)
  (m_contactSolverType :int))

(export 'RIGID-BODY/M/CONTACT-SOLVER-TYPE/SET)

(declaim (inline RIGID-BODY/M/CONTACT-SOLVER-TYPE/GET))

(cffi:defcfun ("_wrap_btRigidBody_m_contactSolverType_get" RIGID-BODY/M/CONTACT-SOLVER-TYPE/GET) :int
  (self :pointer))

(export 'RIGID-BODY/M/CONTACT-SOLVER-TYPE/GET)

(declaim (inline RIGID-BODY/M/FRICTION-SOLVER-TYPE/SET))

(cffi:defcfun ("_wrap_btRigidBody_m_frictionSolverType_set" RIGID-BODY/M/FRICTION-SOLVER-TYPE/SET) :void
  (self :pointer)
  (m_frictionSolverType :int))

(export 'RIGID-BODY/M/FRICTION-SOLVER-TYPE/SET)

(declaim (inline RIGID-BODY/M/FRICTION-SOLVER-TYPE/GET))

(cffi:defcfun ("_wrap_btRigidBody_m_frictionSolverType_get" RIGID-BODY/M/FRICTION-SOLVER-TYPE/GET) :int
  (self :pointer))

(export 'RIGID-BODY/M/FRICTION-SOLVER-TYPE/GET)

(declaim (inline RIGID-BODY/SET-ANGULAR-FACTOR))

(cffi:defcfun ("_wrap_btRigidBody_setAngularFactor__SWIG_0" RIGID-BODY/SET-ANGULAR-FACTOR) :void
  (self :pointer)
  (angFac :pointer))

(export 'RIGID-BODY/SET-ANGULAR-FACTOR)

(declaim (inline RIGID-BODY/SET-ANGULAR-FACTOR))

(cffi:defcfun ("_wrap_btRigidBody_setAngularFactor__SWIG_1" RIGID-BODY/SET-ANGULAR-FACTOR) :void
  (self :pointer)
  (angFac :float))

(export 'RIGID-BODY/SET-ANGULAR-FACTOR)

(declaim (inline RIGID-BODY/GET-ANGULAR-FACTOR))

(cffi:defcfun ("_wrap_btRigidBody_getAngularFactor" RIGID-BODY/GET-ANGULAR-FACTOR) :pointer
  (self :pointer))

(export 'RIGID-BODY/GET-ANGULAR-FACTOR)

(declaim (inline RIGID-BODY/IS-IN-WORLD))

(cffi:defcfun ("_wrap_btRigidBody_isInWorld" RIGID-BODY/IS-IN-WORLD) :pointer
  (self :pointer))

(export 'RIGID-BODY/IS-IN-WORLD)

(declaim (inline RIGID-BODY/CHECK-COLLIDE-WITH-OVERRIDE))

(cffi:defcfun ("_wrap_btRigidBody_checkCollideWithOverride" RIGID-BODY/CHECK-COLLIDE-WITH-OVERRIDE) :pointer
  (self :pointer)
  (co :pointer))

(export 'RIGID-BODY/CHECK-COLLIDE-WITH-OVERRIDE)

(declaim (inline RIGID-BODY/ADD-CONSTRAINT-REF))

(cffi:defcfun ("_wrap_btRigidBody_addConstraintRef" RIGID-BODY/ADD-CONSTRAINT-REF) :void
  (self :pointer)
  (c :pointer))

(export 'RIGID-BODY/ADD-CONSTRAINT-REF)

(declaim (inline RIGID-BODY/REMOVE-CONSTRAINT-REF))

(cffi:defcfun ("_wrap_btRigidBody_removeConstraintRef" RIGID-BODY/REMOVE-CONSTRAINT-REF) :void
  (self :pointer)
  (c :pointer))

(export 'RIGID-BODY/REMOVE-CONSTRAINT-REF)

(declaim (inline RIGID-BODY/GET-CONSTRAINT-REF))

(cffi:defcfun ("_wrap_btRigidBody_getConstraintRef" RIGID-BODY/GET-CONSTRAINT-REF) :pointer
  (self :pointer)
  (index :int))

(export 'RIGID-BODY/GET-CONSTRAINT-REF)

(declaim (inline RIGID-BODY/GET-NUM-CONSTRAINT-REFS))

(cffi:defcfun ("_wrap_btRigidBody_getNumConstraintRefs" RIGID-BODY/GET-NUM-CONSTRAINT-REFS) :int
  (self :pointer))

(export 'RIGID-BODY/GET-NUM-CONSTRAINT-REFS)

(declaim (inline RIGID-BODY/SET-FLAGS))

(cffi:defcfun ("_wrap_btRigidBody_setFlags" RIGID-BODY/SET-FLAGS) :void
  (self :pointer)
  (flags :int))

(export 'RIGID-BODY/SET-FLAGS)

(declaim (inline RIGID-BODY/GET-FLAGS))

(cffi:defcfun ("_wrap_btRigidBody_getFlags" RIGID-BODY/GET-FLAGS) :int
  (self :pointer))

(export 'RIGID-BODY/GET-FLAGS)

(declaim (inline RIGID-BODY/COMPUTE-GYROSCOPIC-FORCE))

(cffi:defcfun ("_wrap_btRigidBody_computeGyroscopicForce" RIGID-BODY/COMPUTE-GYROSCOPIC-FORCE) :pointer
  (self :pointer)
  (maxGyroscopicForce :float))

(export 'RIGID-BODY/COMPUTE-GYROSCOPIC-FORCE)

(declaim (inline RIGID-BODY/CALCULATE-SERIALIZE-BUFFER-SIZE))

(cffi:defcfun ("_wrap_btRigidBody_calculateSerializeBufferSize" RIGID-BODY/CALCULATE-SERIALIZE-BUFFER-SIZE) :int
  (self :pointer))

(export 'RIGID-BODY/CALCULATE-SERIALIZE-BUFFER-SIZE)

(declaim (inline RIGID-BODY/SERIALIZE))

(cffi:defcfun ("_wrap_btRigidBody_serialize" RIGID-BODY/SERIALIZE) :string
  (self :pointer)
  (dataBuffer :pointer)
  (serializer :pointer))

(export 'RIGID-BODY/SERIALIZE)

(declaim (inline RIGID-BODY/SERIALIZE-SINGLE-OBJECT))

(cffi:defcfun ("_wrap_btRigidBody_serializeSingleObject" RIGID-BODY/SERIALIZE-SINGLE-OBJECT) :void
  (self :pointer)
  (serializer :pointer))

(export 'RIGID-BODY/SERIALIZE-SINGLE-OBJECT)

(cffi:defcstruct RIGID-BODY-FLOAT-DATA
  (COLLISION-OBJECT-DATA COLLISION-OBJECT-FLOAT-DATA)
  (INV-INERTIA-TENSOR-WORLD matrix-3x3-float-data)
  (LINEAR-VELOCITY VECTOR-3-FLOAT-DATA)
  (ANGULAR-VELOCITY VECTOR-3-FLOAT-DATA)
  (ANGULAR-FACTOR VECTOR-3-FLOAT-DATA)
  (LINEAR-FACTOR VECTOR-3-FLOAT-DATA)
  (GRAVITY VECTOR-3-FLOAT-DATA)
  (GRAVITY-ACCELERATION VECTOR-3-FLOAT-DATA)
  (INV-INERTIA-LOCAL VECTOR-3-FLOAT-DATA)
  (TOTAL-FORCE VECTOR-3-FLOAT-DATA)
  (TOTAL-TORQUE VECTOR-3-FLOAT-DATA)
  (INVERSE-MASS :float)
  (LINEAR-DAMPING :float)
  (ANGULAR-DAMPING :float)
  (ADDITIONAL-DAMPING-FACTOR :float)
  (ADDITIONAL-LINEAR-DAMPING-THRESHOLD-SQR :float)
  (ADDITIONAL-ANGULAR-DAMPING-THRESHOLD-SQR :float)
  (ADDITIONAL-ANGULAR-DAMPING-FACTOR :float)
  (LINEAR-SLEEPING-THRESHOLD :float)
  (ANGULAR-SLEEPING-THRESHOLD :float)
  (ADDITIONAL-DAMPING :int))

(export 'RIGID-BODY-FLOAT-DATA)

(export 'COLLISION-OBJECT-DATA)

(export 'INV-INERTIA-TENSOR-WORLD)

(export 'LINEAR-VELOCITY)

(export 'ANGULAR-VELOCITY)

(export 'ANGULAR-FACTOR)

(export 'LINEAR-FACTOR)

(export 'GRAVITY)

(export 'GRAVITY-ACCELERATION)

(export 'INV-INERTIA-LOCAL)

(export 'TOTAL-FORCE)

(export 'TOTAL-TORQUE)

(export 'INVERSE-MASS)

(export 'LINEAR-DAMPING)

(export 'ANGULAR-DAMPING)

(export 'ADDITIONAL-DAMPING-FACTOR)

(export 'ADDITIONAL-LINEAR-DAMPING-THRESHOLD-SQR)

(export 'ADDITIONAL-ANGULAR-DAMPING-THRESHOLD-SQR)

(export 'ADDITIONAL-ANGULAR-DAMPING-FACTOR)

(export 'LINEAR-SLEEPING-THRESHOLD)

(export 'ANGULAR-SLEEPING-THRESHOLD)

(export 'ADDITIONAL-DAMPING)

(cffi:defcstruct RIGID-BODY-DOUBLE-DATA
  (COLLISION-OBJECT-DATA COLLISION-OBJECT-DOUBLE-DATA)
  (INV-INERTIA-TENSOR-WORLD MATRIX-3X-3-DOUBLE-DATA)
  (LINEAR-VELOCITY VECTOR-3-DOUBLE-DATA)
  (ANGULAR-VELOCITY VECTOR-3-DOUBLE-DATA)
  (ANGULAR-FACTOR VECTOR-3-DOUBLE-DATA)
  (LINEAR-FACTOR VECTOR-3-DOUBLE-DATA)
  (GRAVITY VECTOR-3-DOUBLE-DATA)
  (GRAVITY-ACCELERATION VECTOR-3-DOUBLE-DATA)
  (INV-INERTIA-LOCAL VECTOR-3-DOUBLE-DATA)
  (TOTAL-FORCE VECTOR-3-DOUBLE-DATA)
  (TOTAL-TORQUE VECTOR-3-DOUBLE-DATA)
  (INVERSE-MASS :double)
  (LINEAR-DAMPING :double)
  (ANGULAR-DAMPING :double)
  (ADDITIONAL-DAMPING-FACTOR :double)
  (ADDITIONAL-LINEAR-DAMPING-THRESHOLD-SQR :double)
  (ADDITIONAL-ANGULAR-DAMPING-THRESHOLD-SQR :double)
  (ADDITIONAL-ANGULAR-DAMPING-FACTOR :double)
  (LINEAR-SLEEPING-THRESHOLD :double)
  (ANGULAR-SLEEPING-THRESHOLD :double)
  (ADDITIONAL-DAMPING :int)
  (PADDING :pointer))

(export 'RIGID-BODY-DOUBLE-DATA)

(export 'COLLISION-OBJECT-DATA)

(export 'INV-INERTIA-TENSOR-WORLD)

(export 'LINEAR-VELOCITY)

(export 'ANGULAR-VELOCITY)

(export 'ANGULAR-FACTOR)

(export 'LINEAR-FACTOR)

(export 'GRAVITY)

(export 'GRAVITY-ACCELERATION)

(export 'INV-INERTIA-LOCAL)

(export 'TOTAL-FORCE)

(export 'TOTAL-TORQUE)

(export 'INVERSE-MASS)

(export 'LINEAR-DAMPING)

(export 'ANGULAR-DAMPING)

(export 'ADDITIONAL-DAMPING-FACTOR)

(export 'ADDITIONAL-LINEAR-DAMPING-THRESHOLD-SQR)

(export 'ADDITIONAL-ANGULAR-DAMPING-THRESHOLD-SQR)

(export 'ADDITIONAL-ANGULAR-DAMPING-FACTOR)

(export 'LINEAR-SLEEPING-THRESHOLD)

(export 'ANGULAR-SLEEPING-THRESHOLD)

(export 'ADDITIONAL-DAMPING)

(export 'PADDING)

(define-constant +TYPED-CONSTRAINT-DATA-NAME+ "btTypedConstraintFloatData" :test 'equal)

(export '+TYPED-CONSTRAINT-DATA-NAME+)

(cffi:defcenum TYPED-CONSTRAINT-TYPE
  (:POINT-2-POINT-CONSTRAINT-TYPE #.3)
  :HINGE-CONSTRAINT-TYPE
  :CONETWIST-CONSTRAINT-TYPE
  :D-6-CONSTRAINT-TYPE
  :SLIDER-CONSTRAINT-TYPE
  :CONTACT-CONSTRAINT-TYPE
  :D-6-SPRING-CONSTRAINT-TYPE
  :GEAR-CONSTRAINT-TYPE
  :FIXED-CONSTRAINT-TYPE
  :MAX-CONSTRAINT-TYPE)

(export 'TYPED-CONSTRAINT-TYPE)

(cffi:defcenum CONSTRAINT-PARAMS
  (:CONSTRAINT-ERP #.1)
  :CONSTRAINT-STOP-ERP
  :CONSTRAINT-CFM
  :CONSTRAINT-STOP-CFM)

(export 'CONSTRAINT-PARAMS)

(cffi:defcstruct JOINT-FEEDBACK
  (APPLIED-FORCE-BODY-A :pointer)
  (APPLIED-TORQUE-BODY-A :pointer)
  (APPLIED-FORCE-BODY-B :pointer)
  (APPLIED-TORQUE-BODY-B :pointer))

(export 'JOINT-FEEDBACK)

(export 'APPLIED-FORCE-BODY-A)

(export 'APPLIED-TORQUE-BODY-A)

(export 'APPLIED-FORCE-BODY-B)

(export 'APPLIED-TORQUE-BODY-B)

(declaim (inline TYPED-CONSTRAINT/MAKE-CPLUS-PLUS-INSTANCE))

(cffi:defcfun ("_wrap_btTypedConstraint_makeCPlusPlusInstance__SWIG_0" TYPED-CONSTRAINT/MAKE-CPLUS-PLUS-INSTANCE) :pointer
  (self :pointer)
  (sizeInBytes :pointer))

(export 'TYPED-CONSTRAINT/MAKE-CPLUS-PLUS-INSTANCE)

(declaim (inline TYPED-CONSTRAINT/DELETE-CPLUS-PLUS-INSTANCE))

(cffi:defcfun ("_wrap_btTypedConstraint_deleteCPlusPlusInstance__SWIG_0" TYPED-CONSTRAINT/DELETE-CPLUS-PLUS-INSTANCE) :void
  (self :pointer)
  (ptr :pointer))

(export 'TYPED-CONSTRAINT/DELETE-CPLUS-PLUS-INSTANCE)

(declaim (inline TYPED-CONSTRAINT/MAKE-CPLUS-PLUS-INSTANCE))

(cffi:defcfun ("_wrap_btTypedConstraint_makeCPlusPlusInstance__SWIG_1" TYPED-CONSTRAINT/MAKE-CPLUS-PLUS-INSTANCE) :pointer
  (self :pointer)
  (arg1 :pointer)
  (ptr :pointer))

(export 'TYPED-CONSTRAINT/MAKE-CPLUS-PLUS-INSTANCE)

(declaim (inline TYPED-CONSTRAINT/DELETE-CPLUS-PLUS-INSTANCE))

(cffi:defcfun ("_wrap_btTypedConstraint_deleteCPlusPlusInstance__SWIG_1" TYPED-CONSTRAINT/DELETE-CPLUS-PLUS-INSTANCE) :void
  (self :pointer)
  (arg1 :pointer)
  (arg2 :pointer))

(export 'TYPED-CONSTRAINT/DELETE-CPLUS-PLUS-INSTANCE)

(declaim (inline TYPED-CONSTRAINT/MAKE-CPLUS-ARRAY))

(cffi:defcfun ("_wrap_btTypedConstraint_makeCPlusArray__SWIG_0" TYPED-CONSTRAINT/MAKE-CPLUS-ARRAY) :pointer
  (self :pointer)
  (sizeInBytes :pointer))

(export 'TYPED-CONSTRAINT/MAKE-CPLUS-ARRAY)

(declaim (inline TYPED-CONSTRAINT/DELETE-CPLUS-ARRAY))

(cffi:defcfun ("_wrap_btTypedConstraint_deleteCPlusArray__SWIG_0" TYPED-CONSTRAINT/DELETE-CPLUS-ARRAY) :void
  (self :pointer)
  (ptr :pointer))

(export 'TYPED-CONSTRAINT/DELETE-CPLUS-ARRAY)

(declaim (inline TYPED-CONSTRAINT/MAKE-CPLUS-ARRAY))

(cffi:defcfun ("_wrap_btTypedConstraint_makeCPlusArray__SWIG_1" TYPED-CONSTRAINT/MAKE-CPLUS-ARRAY) :pointer
  (self :pointer)
  (arg1 :pointer)
  (ptr :pointer))

(export 'TYPED-CONSTRAINT/MAKE-CPLUS-ARRAY)

(declaim (inline TYPED-CONSTRAINT/DELETE-CPLUS-ARRAY))

(cffi:defcfun ("_wrap_btTypedConstraint_deleteCPlusArray__SWIG_1" TYPED-CONSTRAINT/DELETE-CPLUS-ARRAY) :void
  (self :pointer)
  (arg1 :pointer)
  (arg2 :pointer))

(export 'TYPED-CONSTRAINT/DELETE-CPLUS-ARRAY)

(declaim (inline DELETE/BT-TYPED-CONSTRAINT))

(cffi:defcfun ("_wrap_delete_btTypedConstraint" DELETE/BT-TYPED-CONSTRAINT) :void
  (self :pointer))

(export 'DELETE/BT-TYPED-CONSTRAINT)

(declaim (inline TYPED-CONSTRAINT/GET-FIXED-BODY))

(cffi:defcfun ("_wrap_btTypedConstraint_getFixedBody" TYPED-CONSTRAINT/GET-FIXED-BODY) :pointer)

(export 'TYPED-CONSTRAINT/GET-FIXED-BODY)

(declaim (inline TYPED-CONSTRAINT/GET-OVERRIDE-NUM-SOLVER-ITERATIONS))

(cffi:defcfun ("_wrap_btTypedConstraint_getOverrideNumSolverIterations" TYPED-CONSTRAINT/GET-OVERRIDE-NUM-SOLVER-ITERATIONS) :int
  (self :pointer))

(export 'TYPED-CONSTRAINT/GET-OVERRIDE-NUM-SOLVER-ITERATIONS)

(declaim (inline TYPED-CONSTRAINT/SET-OVERRIDE-NUM-SOLVER-ITERATIONS))

(cffi:defcfun ("_wrap_btTypedConstraint_setOverrideNumSolverIterations" TYPED-CONSTRAINT/SET-OVERRIDE-NUM-SOLVER-ITERATIONS) :void
  (self :pointer)
  (overideNumIterations :int))

(export 'TYPED-CONSTRAINT/SET-OVERRIDE-NUM-SOLVER-ITERATIONS)

(declaim (inline TYPED-CONSTRAINT/BUILD-JACOBIAN))

(cffi:defcfun ("_wrap_btTypedConstraint_buildJacobian" TYPED-CONSTRAINT/BUILD-JACOBIAN) :void
  (self :pointer))

(export 'TYPED-CONSTRAINT/BUILD-JACOBIAN)

(declaim (inline TYPED-CONSTRAINT/SETUP-SOLVER-CONSTRAINT))

(cffi:defcfun ("_wrap_btTypedConstraint_setupSolverConstraint" TYPED-CONSTRAINT/SETUP-SOLVER-CONSTRAINT) :void
  (self :pointer)
  (ca :pointer)
  (solverBodyA :int)
  (solverBodyB :int)
  (timeStep :float))

(export 'TYPED-CONSTRAINT/SETUP-SOLVER-CONSTRAINT)

(declaim (inline TYPED-CONSTRAINT/GET-INFO-1))

(cffi:defcfun ("_wrap_btTypedConstraint_getInfo1" TYPED-CONSTRAINT/GET-INFO-1) :void
  (self :pointer)
  (info :pointer))

(export 'TYPED-CONSTRAINT/GET-INFO-1)

(declaim (inline TYPED-CONSTRAINT/GET-INFO-2))

(cffi:defcfun ("_wrap_btTypedConstraint_getInfo2" TYPED-CONSTRAINT/GET-INFO-2) :void
  (self :pointer)
  (info :pointer))

(export 'TYPED-CONSTRAINT/GET-INFO-2)

(declaim (inline TYPED-CONSTRAINT/INTERNAL-SET-APPLIED-IMPULSE))

(cffi:defcfun ("_wrap_btTypedConstraint_internalSetAppliedImpulse" TYPED-CONSTRAINT/INTERNAL-SET-APPLIED-IMPULSE) :void
  (self :pointer)
  (appliedImpulse :float))

(export 'TYPED-CONSTRAINT/INTERNAL-SET-APPLIED-IMPULSE)

(declaim (inline TYPED-CONSTRAINT/INTERNAL-GET-APPLIED-IMPULSE))

(cffi:defcfun ("_wrap_btTypedConstraint_internalGetAppliedImpulse" TYPED-CONSTRAINT/INTERNAL-GET-APPLIED-IMPULSE) :float
  (self :pointer))

(export 'TYPED-CONSTRAINT/INTERNAL-GET-APPLIED-IMPULSE)

(declaim (inline TYPED-CONSTRAINT/GET-BREAKING-IMPULSE-THRESHOLD))

(cffi:defcfun ("_wrap_btTypedConstraint_getBreakingImpulseThreshold" TYPED-CONSTRAINT/GET-BREAKING-IMPULSE-THRESHOLD) :float
  (self :pointer))

(export 'TYPED-CONSTRAINT/GET-BREAKING-IMPULSE-THRESHOLD)

(declaim (inline TYPED-CONSTRAINT/SET-BREAKING-IMPULSE-THRESHOLD))

(cffi:defcfun ("_wrap_btTypedConstraint_setBreakingImpulseThreshold" TYPED-CONSTRAINT/SET-BREAKING-IMPULSE-THRESHOLD) :void
  (self :pointer)
  (threshold :float))

(export 'TYPED-CONSTRAINT/SET-BREAKING-IMPULSE-THRESHOLD)

(declaim (inline TYPED-CONSTRAINT/IS-ENABLED))

(cffi:defcfun ("_wrap_btTypedConstraint_isEnabled" TYPED-CONSTRAINT/IS-ENABLED) :pointer
  (self :pointer))

(export 'TYPED-CONSTRAINT/IS-ENABLED)

(declaim (inline TYPED-CONSTRAINT/SET-ENABLED))

(cffi:defcfun ("_wrap_btTypedConstraint_setEnabled" TYPED-CONSTRAINT/SET-ENABLED) :void
  (self :pointer)
  (enabled :pointer))

(export 'TYPED-CONSTRAINT/SET-ENABLED)

(declaim (inline TYPED-CONSTRAINT/SOLVE-CONSTRAINT-OBSOLETE))

(cffi:defcfun ("_wrap_btTypedConstraint_solveConstraintObsolete" TYPED-CONSTRAINT/SOLVE-CONSTRAINT-OBSOLETE) :void
  (self :pointer)
  (arg1 :pointer)
  (arg2 :pointer)
  (arg3 :float))

(export 'TYPED-CONSTRAINT/SOLVE-CONSTRAINT-OBSOLETE)

(declaim (inline TYPED-CONSTRAINT/GET-RIGID-BODY-A))

(cffi:defcfun ("_wrap_btTypedConstraint_getRigidBodyA__SWIG_0" TYPED-CONSTRAINT/GET-RIGID-BODY-A) :pointer
  (self :pointer))

(export 'TYPED-CONSTRAINT/GET-RIGID-BODY-A)

(declaim (inline TYPED-CONSTRAINT/GET-RIGID-BODY-B))

(cffi:defcfun ("_wrap_btTypedConstraint_getRigidBodyB__SWIG_0" TYPED-CONSTRAINT/GET-RIGID-BODY-B) :pointer
  (self :pointer))

(export 'TYPED-CONSTRAINT/GET-RIGID-BODY-B)

(declaim (inline TYPED-CONSTRAINT/GET-RIGID-BODY-A))

(cffi:defcfun ("_wrap_btTypedConstraint_getRigidBodyA__SWIG_1" TYPED-CONSTRAINT/GET-RIGID-BODY-A) :pointer
  (self :pointer))

(export 'TYPED-CONSTRAINT/GET-RIGID-BODY-A)

(declaim (inline TYPED-CONSTRAINT/GET-RIGID-BODY-B))

(cffi:defcfun ("_wrap_btTypedConstraint_getRigidBodyB__SWIG_1" TYPED-CONSTRAINT/GET-RIGID-BODY-B) :pointer
  (self :pointer))

(export 'TYPED-CONSTRAINT/GET-RIGID-BODY-B)

(declaim (inline TYPED-CONSTRAINT/GET-USER-CONSTRAINT-TYPE))

(cffi:defcfun ("_wrap_btTypedConstraint_getUserConstraintType" TYPED-CONSTRAINT/GET-USER-CONSTRAINT-TYPE) :int
  (self :pointer))

(export 'TYPED-CONSTRAINT/GET-USER-CONSTRAINT-TYPE)

(declaim (inline TYPED-CONSTRAINT/SET-USER-CONSTRAINT-TYPE))

(cffi:defcfun ("_wrap_btTypedConstraint_setUserConstraintType" TYPED-CONSTRAINT/SET-USER-CONSTRAINT-TYPE) :void
  (self :pointer)
  (userConstraintType :int))

(export 'TYPED-CONSTRAINT/SET-USER-CONSTRAINT-TYPE)

(declaim (inline TYPED-CONSTRAINT/SET-USER-CONSTRAINT-ID))

(cffi:defcfun ("_wrap_btTypedConstraint_setUserConstraintId" TYPED-CONSTRAINT/SET-USER-CONSTRAINT-ID) :void
  (self :pointer)
  (uid :int))

(export 'TYPED-CONSTRAINT/SET-USER-CONSTRAINT-ID)

(declaim (inline TYPED-CONSTRAINT/GET-USER-CONSTRAINT-ID))

(cffi:defcfun ("_wrap_btTypedConstraint_getUserConstraintId" TYPED-CONSTRAINT/GET-USER-CONSTRAINT-ID) :int
  (self :pointer))

(export 'TYPED-CONSTRAINT/GET-USER-CONSTRAINT-ID)

(declaim (inline TYPED-CONSTRAINT/SET-USER-CONSTRAINT-PTR))

(cffi:defcfun ("_wrap_btTypedConstraint_setUserConstraintPtr" TYPED-CONSTRAINT/SET-USER-CONSTRAINT-PTR) :void
  (self :pointer)
  (ptr :pointer))

(export 'TYPED-CONSTRAINT/SET-USER-CONSTRAINT-PTR)

(declaim (inline TYPED-CONSTRAINT/GET-USER-CONSTRAINT-PTR))

(cffi:defcfun ("_wrap_btTypedConstraint_getUserConstraintPtr" TYPED-CONSTRAINT/GET-USER-CONSTRAINT-PTR) :pointer
  (self :pointer))

(export 'TYPED-CONSTRAINT/GET-USER-CONSTRAINT-PTR)

(declaim (inline TYPED-CONSTRAINT/SET-JOINT-FEEDBACK))

(cffi:defcfun ("_wrap_btTypedConstraint_setJointFeedback" TYPED-CONSTRAINT/SET-JOINT-FEEDBACK) :void
  (self :pointer)
  (jointFeedback :pointer))

(export 'TYPED-CONSTRAINT/SET-JOINT-FEEDBACK)

(declaim (inline TYPED-CONSTRAINT/GET-JOINT-FEEDBACK))

(cffi:defcfun ("_wrap_btTypedConstraint_getJointFeedback__SWIG_0" TYPED-CONSTRAINT/GET-JOINT-FEEDBACK) :pointer
  (self :pointer))

(export 'TYPED-CONSTRAINT/GET-JOINT-FEEDBACK)

(declaim (inline TYPED-CONSTRAINT/GET-JOINT-FEEDBACK))

(cffi:defcfun ("_wrap_btTypedConstraint_getJointFeedback__SWIG_1" TYPED-CONSTRAINT/GET-JOINT-FEEDBACK) :pointer
  (self :pointer))

(export 'TYPED-CONSTRAINT/GET-JOINT-FEEDBACK)

(declaim (inline TYPED-CONSTRAINT/GET-UID))

(cffi:defcfun ("_wrap_btTypedConstraint_getUid" TYPED-CONSTRAINT/GET-UID) :int
  (self :pointer))

(export 'TYPED-CONSTRAINT/GET-UID)

(declaim (inline TYPED-CONSTRAINT/NEEDS-FEEDBACK))

(cffi:defcfun ("_wrap_btTypedConstraint_needsFeedback" TYPED-CONSTRAINT/NEEDS-FEEDBACK) :pointer
  (self :pointer))

(export 'TYPED-CONSTRAINT/NEEDS-FEEDBACK)

(declaim (inline TYPED-CONSTRAINT/ENABLE-FEEDBACK))

(cffi:defcfun ("_wrap_btTypedConstraint_enableFeedback" TYPED-CONSTRAINT/ENABLE-FEEDBACK) :void
  (self :pointer)
  (needsFeedback :pointer))

(export 'TYPED-CONSTRAINT/ENABLE-FEEDBACK)

(declaim (inline TYPED-CONSTRAINT/GET-APPLIED-IMPULSE))

(cffi:defcfun ("_wrap_btTypedConstraint_getAppliedImpulse" TYPED-CONSTRAINT/GET-APPLIED-IMPULSE) :float
  (self :pointer))

(export 'TYPED-CONSTRAINT/GET-APPLIED-IMPULSE)

(declaim (inline TYPED-CONSTRAINT/GET-CONSTRAINT-TYPE))

(cffi:defcfun ("_wrap_btTypedConstraint_getConstraintType" TYPED-CONSTRAINT/GET-CONSTRAINT-TYPE) TYPED-CONSTRAINT-TYPE
  (self :pointer))

(export 'TYPED-CONSTRAINT/GET-CONSTRAINT-TYPE)

(declaim (inline TYPED-CONSTRAINT/SET-DBG-DRAW-SIZE))

(cffi:defcfun ("_wrap_btTypedConstraint_setDbgDrawSize" TYPED-CONSTRAINT/SET-DBG-DRAW-SIZE) :void
  (self :pointer)
  (dbgDrawSize :float))

(export 'TYPED-CONSTRAINT/SET-DBG-DRAW-SIZE)

(declaim (inline TYPED-CONSTRAINT/GET-DBG-DRAW-SIZE))

(cffi:defcfun ("_wrap_btTypedConstraint_getDbgDrawSize" TYPED-CONSTRAINT/GET-DBG-DRAW-SIZE) :float
  (self :pointer))

(export 'TYPED-CONSTRAINT/GET-DBG-DRAW-SIZE)

(declaim (inline TYPED-CONSTRAINT/CALCULATE-SERIALIZE-BUFFER-SIZE))

(cffi:defcfun ("_wrap_btTypedConstraint_calculateSerializeBufferSize" TYPED-CONSTRAINT/CALCULATE-SERIALIZE-BUFFER-SIZE) :int
  (self :pointer))

(export 'TYPED-CONSTRAINT/CALCULATE-SERIALIZE-BUFFER-SIZE)

(declaim (inline TYPED-CONSTRAINT/SERIALIZE))

(cffi:defcfun ("_wrap_btTypedConstraint_serialize" TYPED-CONSTRAINT/SERIALIZE) :string
  (self :pointer)
  (dataBuffer :pointer)
  (serializer :pointer))

(export 'TYPED-CONSTRAINT/SERIALIZE)

(declaim (inline ADJUST-ANGLE-TO-LIMITS))

(cffi:defcfun ("_wrap_btAdjustAngleToLimits" ADJUST-ANGLE-TO-LIMITS) :float
  (angleInRadians :float)
  (angleLowerLimitInRadians :float)
  (angleUpperLimitInRadians :float))

(export 'ADJUST-ANGLE-TO-LIMITS)

(cffi:defcstruct TYPED-CONSTRAINT-FLOAT-DATA
  (RB-A :pointer)
  (RB-B :pointer)
  (NAME :string)
  (OBJECT-TYPE :int)
  (USER-CONSTRAINT-TYPE :int)
  (USER-CONSTRAINT-ID :int)
  (NEEDS-FEEDBACK :int)
  (APPLIED-IMPULSE :float)
  (DBG-DRAW-SIZE :float)
  (DISABLE-COLLISIONS-BETWEEN-LINKED-BODIES :int)
  (OVERRIDE-NUM-SOLVER-ITERATIONS :int)
  (BREAKING-IMPULSE-THRESHOLD :float)
  (IS-ENABLED :int))

(export 'TYPED-CONSTRAINT-FLOAT-DATA)

(export 'RB-A)

(export 'RB-B)

(export 'NAME)

(export 'OBJECT-TYPE)

(export 'USER-CONSTRAINT-TYPE)

(export 'USER-CONSTRAINT-ID)

(export 'NEEDS-FEEDBACK)

(export 'APPLIED-IMPULSE)

(export 'DBG-DRAW-SIZE)

(export 'DISABLE-COLLISIONS-BETWEEN-LINKED-BODIES)

(export 'OVERRIDE-NUM-SOLVER-ITERATIONS)

(export 'BREAKING-IMPULSE-THRESHOLD)

(export 'IS-ENABLED)

(cffi:defcstruct TYPED-CONSTRAINT-DATA
  (RB-A :pointer)
  (RB-B :pointer)
  (NAME :string)
  (OBJECT-TYPE :int)
  (USER-CONSTRAINT-TYPE :int)
  (USER-CONSTRAINT-ID :int)
  (NEEDS-FEEDBACK :int)
  (APPLIED-IMPULSE :float)
  (DBG-DRAW-SIZE :float)
  (DISABLE-COLLISIONS-BETWEEN-LINKED-BODIES :int)
  (OVERRIDE-NUM-SOLVER-ITERATIONS :int)
  (BREAKING-IMPULSE-THRESHOLD :float)
  (IS-ENABLED :int))

(export 'TYPED-CONSTRAINT-DATA)

(export 'RB-A)

(export 'RB-B)

(export 'NAME)

(export 'OBJECT-TYPE)

(export 'USER-CONSTRAINT-TYPE)

(export 'USER-CONSTRAINT-ID)

(export 'NEEDS-FEEDBACK)

(export 'APPLIED-IMPULSE)

(export 'DBG-DRAW-SIZE)

(export 'DISABLE-COLLISIONS-BETWEEN-LINKED-BODIES)

(export 'OVERRIDE-NUM-SOLVER-ITERATIONS)

(export 'BREAKING-IMPULSE-THRESHOLD)

(export 'IS-ENABLED)

(cffi:defcstruct TYPED-CONSTRAINT-DOUBLE-DATA
  (RB-A :pointer)
  (RB-B :pointer)
  (NAME :string)
  (OBJECT-TYPE :int)
  (USER-CONSTRAINT-TYPE :int)
  (USER-CONSTRAINT-ID :int)
  (NEEDS-FEEDBACK :int)
  (APPLIED-IMPULSE :double)
  (DBG-DRAW-SIZE :double)
  (DISABLE-COLLISIONS-BETWEEN-LINKED-BODIES :int)
  (OVERRIDE-NUM-SOLVER-ITERATIONS :int)
  (BREAKING-IMPULSE-THRESHOLD :double)
  (IS-ENABLED :int)
  (PADDING :pointer))

(export 'TYPED-CONSTRAINT-DOUBLE-DATA)

(export 'RB-A)

(export 'RB-B)

(export 'NAME)

(export 'OBJECT-TYPE)

(export 'USER-CONSTRAINT-TYPE)

(export 'USER-CONSTRAINT-ID)

(export 'NEEDS-FEEDBACK)

(export 'APPLIED-IMPULSE)

(export 'DBG-DRAW-SIZE)

(export 'DISABLE-COLLISIONS-BETWEEN-LINKED-BODIES)

(export 'OVERRIDE-NUM-SOLVER-ITERATIONS)

(export 'BREAKING-IMPULSE-THRESHOLD)

(export 'IS-ENABLED)

(export 'PADDING)

(declaim (inline MAKE-ANGULAR-LIMIT))

(cffi:defcfun ("_wrap_new_btAngularLimit" MAKE-ANGULAR-LIMIT) :pointer)

(export 'MAKE-ANGULAR-LIMIT)

(declaim (inline ANGULAR-LIMIT/SET))

(cffi:defcfun ("_wrap_btAngularLimit_set__SWIG_0" ANGULAR-LIMIT/SET) :void
  (self :pointer)
  (low :float)
  (high :float)
  (_softness :float)
  (_biasFactor :float)
  (_relaxationFactor :float))

(export 'ANGULAR-LIMIT/SET)

(declaim (inline ANGULAR-LIMIT/SET))

(cffi:defcfun ("_wrap_btAngularLimit_set__SWIG_1" ANGULAR-LIMIT/SET) :void
  (self :pointer)
  (low :float)
  (high :float)
  (_softness :float)
  (_biasFactor :float))

(export 'ANGULAR-LIMIT/SET)

(declaim (inline ANGULAR-LIMIT/SET))

(cffi:defcfun ("_wrap_btAngularLimit_set__SWIG_2" ANGULAR-LIMIT/SET) :void
  (self :pointer)
  (low :float)
  (high :float)
  (_softness :float))

(export 'ANGULAR-LIMIT/SET)

(declaim (inline ANGULAR-LIMIT/SET))

(cffi:defcfun ("_wrap_btAngularLimit_set__SWIG_3" ANGULAR-LIMIT/SET) :void
  (self :pointer)
  (low :float)
  (high :float))

(export 'ANGULAR-LIMIT/SET)

(declaim (inline ANGULAR-LIMIT/TEST))

(cffi:defcfun ("_wrap_btAngularLimit_test" ANGULAR-LIMIT/TEST) :void
  (self :pointer)
  (angle :float))

(export 'ANGULAR-LIMIT/TEST)

(declaim (inline ANGULAR-LIMIT/GET-SOFTNESS))

(cffi:defcfun ("_wrap_btAngularLimit_getSoftness" ANGULAR-LIMIT/GET-SOFTNESS) :float
  (self :pointer))

(export 'ANGULAR-LIMIT/GET-SOFTNESS)

(declaim (inline ANGULAR-LIMIT/GET-BIAS-FACTOR))

(cffi:defcfun ("_wrap_btAngularLimit_getBiasFactor" ANGULAR-LIMIT/GET-BIAS-FACTOR) :float
  (self :pointer))

(export 'ANGULAR-LIMIT/GET-BIAS-FACTOR)

(declaim (inline ANGULAR-LIMIT/GET-RELAXATION-FACTOR))

(cffi:defcfun ("_wrap_btAngularLimit_getRelaxationFactor" ANGULAR-LIMIT/GET-RELAXATION-FACTOR) :float
  (self :pointer))

(export 'ANGULAR-LIMIT/GET-RELAXATION-FACTOR)

(declaim (inline ANGULAR-LIMIT/GET-CORRECTION))

(cffi:defcfun ("_wrap_btAngularLimit_getCorrection" ANGULAR-LIMIT/GET-CORRECTION) :float
  (self :pointer))

(export 'ANGULAR-LIMIT/GET-CORRECTION)

(declaim (inline ANGULAR-LIMIT/GET-SIGN))

(cffi:defcfun ("_wrap_btAngularLimit_getSign" ANGULAR-LIMIT/GET-SIGN) :float
  (self :pointer))

(export 'ANGULAR-LIMIT/GET-SIGN)

(declaim (inline ANGULAR-LIMIT/GET-HALF-RANGE))

(cffi:defcfun ("_wrap_btAngularLimit_getHalfRange" ANGULAR-LIMIT/GET-HALF-RANGE) :float
  (self :pointer))

(export 'ANGULAR-LIMIT/GET-HALF-RANGE)

(declaim (inline ANGULAR-LIMIT/IS-LIMIT))

(cffi:defcfun ("_wrap_btAngularLimit_isLimit" ANGULAR-LIMIT/IS-LIMIT) :pointer
  (self :pointer))

(export 'ANGULAR-LIMIT/IS-LIMIT)

(declaim (inline ANGULAR-LIMIT/FIT))

(cffi:defcfun ("_wrap_btAngularLimit_fit" ANGULAR-LIMIT/FIT) :void
  (self :pointer)
  (angle :pointer))

(export 'ANGULAR-LIMIT/FIT)

(declaim (inline ANGULAR-LIMIT/GET-ERROR))

(cffi:defcfun ("_wrap_btAngularLimit_getError" ANGULAR-LIMIT/GET-ERROR) :float
  (self :pointer))

(export 'ANGULAR-LIMIT/GET-ERROR)

(declaim (inline ANGULAR-LIMIT/GET-LOW))

(cffi:defcfun ("_wrap_btAngularLimit_getLow" ANGULAR-LIMIT/GET-LOW) :float
  (self :pointer))

(export 'ANGULAR-LIMIT/GET-LOW)

(declaim (inline ANGULAR-LIMIT/GET-HIGH))

(cffi:defcfun ("_wrap_btAngularLimit_getHigh" ANGULAR-LIMIT/GET-HIGH) :float
  (self :pointer))

(export 'ANGULAR-LIMIT/GET-HIGH)

(declaim (inline DELETE/BT-ANGULAR-LIMIT))

(cffi:defcfun ("_wrap_delete_btAngularLimit" DELETE/BT-ANGULAR-LIMIT) :void
  (self :pointer))

(export 'DELETE/BT-ANGULAR-LIMIT)

(define-constant +POINT-2-POINT-CONSTRAINT-DATA-NAME+ "btPoint2PointConstraintFloatData" :test 'equal)

(export '+POINT-2-POINT-CONSTRAINT-DATA-NAME+)

(cffi:defcstruct CONSTRAINT-SETTING
  (TAU :float)
  (DAMPING :float)
  (IMPULSE-CLAMP :float))

(export 'CONSTRAINT-SETTING)

(export 'TAU)

(export 'DAMPING)

(export 'IMPULSE-CLAMP)

(cffi:defcenum POINT-2-POINT-FLAGS
  (:P-2-P-FLAGS-ERP #.1)
  (:P-2-P-FLAGS-CFM #.2))

(export 'POINT-2-POINT-FLAGS)

(declaim (inline POINT-2-POINT-CONSTRAINT/MAKE-CPLUS-PLUS-INSTANCE))

(cffi:defcfun ("_wrap_btPoint2PointConstraint_makeCPlusPlusInstance__SWIG_0" POINT-2-POINT-CONSTRAINT/MAKE-CPLUS-PLUS-INSTANCE) :pointer
  (self :pointer)
  (sizeInBytes :pointer))

(export 'POINT-2-POINT-CONSTRAINT/MAKE-CPLUS-PLUS-INSTANCE)

(declaim (inline POINT-2-POINT-CONSTRAINT/DELETE-CPLUS-PLUS-INSTANCE))

(cffi:defcfun ("_wrap_btPoint2PointConstraint_deleteCPlusPlusInstance__SWIG_0" POINT-2-POINT-CONSTRAINT/DELETE-CPLUS-PLUS-INSTANCE) :void
  (self :pointer)
  (ptr :pointer))

(export 'POINT-2-POINT-CONSTRAINT/DELETE-CPLUS-PLUS-INSTANCE)

(declaim (inline POINT-2-POINT-CONSTRAINT/MAKE-CPLUS-PLUS-INSTANCE))

(cffi:defcfun ("_wrap_btPoint2PointConstraint_makeCPlusPlusInstance__SWIG_1" POINT-2-POINT-CONSTRAINT/MAKE-CPLUS-PLUS-INSTANCE) :pointer
  (self :pointer)
  (arg1 :pointer)
  (ptr :pointer))

(export 'POINT-2-POINT-CONSTRAINT/MAKE-CPLUS-PLUS-INSTANCE)

(declaim (inline POINT-2-POINT-CONSTRAINT/DELETE-CPLUS-PLUS-INSTANCE))

(cffi:defcfun ("_wrap_btPoint2PointConstraint_deleteCPlusPlusInstance__SWIG_1" POINT-2-POINT-CONSTRAINT/DELETE-CPLUS-PLUS-INSTANCE) :void
  (self :pointer)
  (arg1 :pointer)
  (arg2 :pointer))

(export 'POINT-2-POINT-CONSTRAINT/DELETE-CPLUS-PLUS-INSTANCE)

(declaim (inline POINT-2-POINT-CONSTRAINT/MAKE-CPLUS-ARRAY))

(cffi:defcfun ("_wrap_btPoint2PointConstraint_makeCPlusArray__SWIG_0" POINT-2-POINT-CONSTRAINT/MAKE-CPLUS-ARRAY) :pointer
  (self :pointer)
  (sizeInBytes :pointer))

(export 'POINT-2-POINT-CONSTRAINT/MAKE-CPLUS-ARRAY)

(declaim (inline POINT-2-POINT-CONSTRAINT/DELETE-CPLUS-ARRAY))

(cffi:defcfun ("_wrap_btPoint2PointConstraint_deleteCPlusArray__SWIG_0" POINT-2-POINT-CONSTRAINT/DELETE-CPLUS-ARRAY) :void
  (self :pointer)
  (ptr :pointer))

(export 'POINT-2-POINT-CONSTRAINT/DELETE-CPLUS-ARRAY)

(declaim (inline POINT-2-POINT-CONSTRAINT/MAKE-CPLUS-ARRAY))

(cffi:defcfun ("_wrap_btPoint2PointConstraint_makeCPlusArray__SWIG_1" POINT-2-POINT-CONSTRAINT/MAKE-CPLUS-ARRAY) :pointer
  (self :pointer)
  (arg1 :pointer)
  (ptr :pointer))

(export 'POINT-2-POINT-CONSTRAINT/MAKE-CPLUS-ARRAY)

(declaim (inline POINT-2-POINT-CONSTRAINT/DELETE-CPLUS-ARRAY))

(cffi:defcfun ("_wrap_btPoint2PointConstraint_deleteCPlusArray__SWIG_1" POINT-2-POINT-CONSTRAINT/DELETE-CPLUS-ARRAY) :void
  (self :pointer)
  (arg1 :pointer)
  (arg2 :pointer))

(export 'POINT-2-POINT-CONSTRAINT/DELETE-CPLUS-ARRAY)

(declaim (inline POINT-2-POINT-CONSTRAINT/M/USE-SOLVE-CONSTRAINT-OBSOLETE/SET))

(cffi:defcfun ("_wrap_btPoint2PointConstraint_m_useSolveConstraintObsolete_set" POINT-2-POINT-CONSTRAINT/M/USE-SOLVE-CONSTRAINT-OBSOLETE/SET) :void
  (self :pointer)
  (m_useSolveConstraintObsolete :pointer))

(export 'POINT-2-POINT-CONSTRAINT/M/USE-SOLVE-CONSTRAINT-OBSOLETE/SET)

(declaim (inline POINT-2-POINT-CONSTRAINT/M/USE-SOLVE-CONSTRAINT-OBSOLETE/GET))

(cffi:defcfun ("_wrap_btPoint2PointConstraint_m_useSolveConstraintObsolete_get" POINT-2-POINT-CONSTRAINT/M/USE-SOLVE-CONSTRAINT-OBSOLETE/GET) :pointer
  (self :pointer))

(export 'POINT-2-POINT-CONSTRAINT/M/USE-SOLVE-CONSTRAINT-OBSOLETE/GET)

(declaim (inline POINT-2-POINT-CONSTRAINT/M/SETTING/SET))

(cffi:defcfun ("_wrap_btPoint2PointConstraint_m_setting_set" POINT-2-POINT-CONSTRAINT/M/SETTING/SET) :void
  (self :pointer)
  (m_setting :pointer))

(export 'POINT-2-POINT-CONSTRAINT/M/SETTING/SET)

(declaim (inline POINT-2-POINT-CONSTRAINT/M/SETTING/GET))

(cffi:defcfun ("_wrap_btPoint2PointConstraint_m_setting_get" POINT-2-POINT-CONSTRAINT/M/SETTING/GET) :pointer
  (self :pointer))

(export 'POINT-2-POINT-CONSTRAINT/M/SETTING/GET)

(declaim (inline (lispify "new_btPoint2PointConstraint" 'function)))

(cffi:defcfun ("_wrap_new_btPoint2PointConstraint__SWIG_0" MAKE-POINT-2-POINT-CONSTRAINT) :pointer
  (rbA :pointer)
  (rbB :pointer)
  (pivotInA :pointer)
  (pivotInB :pointer))

(export 'MAKE-POINT-2-POINT-CONSTRAINT)

(declaim (inline MAKE-POINT-2-POINT-CONSTRAINT))

(cffi:defcfun ("_wrap_new_btPoint2PointConstraint__SWIG_1" MAKE-POINT-2-POINT-CONSTRAINT) :pointer
  (rbA :pointer)
  (pivotInA :pointer))

(export 'MAKE-POINT-2-POINT-CONSTRAINT)

(declaim (inline POINT-2-POINT-CONSTRAINT/BUILD-JACOBIAN))

(cffi:defcfun ("_wrap_btPoint2PointConstraint_buildJacobian" POINT-2-POINT-CONSTRAINT/BUILD-JACOBIAN) :void
  (self :pointer))

(export 'POINT-2-POINT-CONSTRAINT/BUILD-JACOBIAN)

(declaim (inline POINT-2-POINT-CONSTRAINT/GET-INFO-1))

(cffi:defcfun ("_wrap_btPoint2PointConstraint_getInfo1" POINT-2-POINT-CONSTRAINT/GET-INFO-1) :void
  (self :pointer)
  (info :pointer))

(export 'POINT-2-POINT-CONSTRAINT/GET-INFO-1)

(declaim (inline POINT-2-POINT-CONSTRAINT/GET-INFO-1-NON-VIRTUAL))

(cffi:defcfun ("_wrap_btPoint2PointConstraint_getInfo1NonVirtual" POINT-2-POINT-CONSTRAINT/GET-INFO-1-NON-VIRTUAL) :void
  (self :pointer)
  (info :pointer))

(export 'POINT-2-POINT-CONSTRAINT/GET-INFO-1-NON-VIRTUAL)

(declaim (inline POINT-2-POINT-CONSTRAINT/GET-INFO-2))

(cffi:defcfun ("_wrap_btPoint2PointConstraint_getInfo2" POINT-2-POINT-CONSTRAINT/GET-INFO-2) :void
  (self :pointer)
  (info :pointer))

(export 'POINT-2-POINT-CONSTRAINT/GET-INFO-2)

(declaim (inline POINT-2-POINT-CONSTRAINT/GET-INFO-2-NON-VIRTUAL))

(cffi:defcfun ("_wrap_btPoint2PointConstraint_getInfo2NonVirtual" POINT-2-POINT-CONSTRAINT/GET-INFO-2-NON-VIRTUAL) :void
  (self :pointer)
  (info :pointer)
  (body0_trans :pointer)
  (body1_trans :pointer))

(export 'POINT-2-POINT-CONSTRAINT/GET-INFO-2-NON-VIRTUAL)

(declaim (inline POINT-2-POINT-CONSTRAINT/UPDATE-RHS))

(cffi:defcfun ("_wrap_btPoint2PointConstraint_updateRHS" POINT-2-POINT-CONSTRAINT/UPDATE-RHS) :void
  (self :pointer)
  (timeStep :float))

(export 'POINT-2-POINT-CONSTRAINT/UPDATE-RHS)

(declaim (inline POINT-2-POINT-CONSTRAINT/SET-PIVOT-A))

(cffi:defcfun ("_wrap_btPoint2PointConstraint_setPivotA" POINT-2-POINT-CONSTRAINT/SET-PIVOT-A) :void
  (self :pointer)
  (pivotA :pointer))

(export 'POINT-2-POINT-CONSTRAINT/SET-PIVOT-A)

(declaim (inline POINT-2-POINT-CONSTRAINT/SET-PIVOT-B))

(cffi:defcfun ("_wrap_btPoint2PointConstraint_setPivotB" POINT-2-POINT-CONSTRAINT/SET-PIVOT-B) :void
  (self :pointer)
  (pivotB :pointer))

(export 'POINT-2-POINT-CONSTRAINT/SET-PIVOT-B)

(declaim (inline POINT-2-POINT-CONSTRAINT/GET-PIVOT-IN-A))

(cffi:defcfun ("_wrap_btPoint2PointConstraint_getPivotInA" POINT-2-POINT-CONSTRAINT/GET-PIVOT-IN-A) :pointer
  (self :pointer))

(export 'POINT-2-POINT-CONSTRAINT/GET-PIVOT-IN-A)

(declaim (inline POINT-2-POINT-CONSTRAINT/GET-PIVOT-IN-B))

(cffi:defcfun ("_wrap_btPoint2PointConstraint_getPivotInB" POINT-2-POINT-CONSTRAINT/GET-PIVOT-IN-B) :pointer
  (self :pointer))

(export 'POINT-2-POINT-CONSTRAINT/GET-PIVOT-IN-B)

(declaim (inline POINT-2-POINT-CONSTRAINT/CALCULATE-SERIALIZE-BUFFER-SIZE))

(cffi:defcfun ("_wrap_btPoint2PointConstraint_calculateSerializeBufferSize" POINT-2-POINT-CONSTRAINT/CALCULATE-SERIALIZE-BUFFER-SIZE) :int
  (self :pointer))

(export 'POINT-2-POINT-CONSTRAINT/CALCULATE-SERIALIZE-BUFFER-SIZE)

(declaim (inline POINT-2-POINT-CONSTRAINT/SERIALIZE))

(cffi:defcfun ("_wrap_btPoint2PointConstraint_serialize" POINT-2-POINT-CONSTRAINT/SERIALIZE) :string
  (self :pointer)
  (dataBuffer :pointer)
  (serializer :pointer))

(export 'POINT-2-POINT-CONSTRAINT/SERIALIZE)

(declaim (inline DELETE/BT-POINT-2-POINT-CONSTRAINT))

(cffi:defcfun ("_wrap_delete_btPoint2PointConstraint" DELETE/BT-POINT-2-POINT-CONSTRAINT) :void
  (self :pointer))

(export 'DELETE/BT-POINT-2-POINT-CONSTRAINT)

(cffi:defcstruct POINT-2-POINT-CONSTRAINT-FLOAT-DATA
  (TYPE-CONSTRAINT-DATA TYPED-CONSTRAINT-DATA)
  (PIVOT-IN-A VECTOR-3-FLOAT-DATA)
  (PIVOT-IN-B VECTOR-3-FLOAT-DATA))

(export 'POINT-2-POINT-CONSTRAINT-FLOAT-DATA)

(export 'TYPE-CONSTRAINT-DATA)

(export 'PIVOT-IN-A)

(export 'PIVOT-IN-B)

(cffi:defcstruct POINT-2-POINT-CONSTRAINT-DOUBLE-DATA-2
  (TYPE-CONSTRAINT-DATA TYPED-CONSTRAINT-DOUBLE-DATA)
  (PIVOT-IN-A VECTOR-3-DOUBLE-DATA)
  (PIVOT-IN-B VECTOR-3-DOUBLE-DATA))

(export 'POINT-2-POINT-CONSTRAINT-DOUBLE-DATA-2)

(export 'TYPE-CONSTRAINT-DATA)

(export 'PIVOT-IN-A)

(export 'PIVOT-IN-B)

(cffi:defcstruct POINT-2-POINT-CONSTRAINT-DOUBLE-DATA
  (TYPE-CONSTRAINT-DATA TYPED-CONSTRAINT-DATA)
  (PIVOT-IN-A VECTOR-3-DOUBLE-DATA)
  (PIVOT-IN-B VECTOR-3-DOUBLE-DATA))

(export 'POINT-2-POINT-CONSTRAINT-DOUBLE-DATA)

(export 'TYPE-CONSTRAINT-DATA)

(export 'PIVOT-IN-A)

(export 'PIVOT-IN-B)

(define-constant +-BT-USE-CENTER-LIMIT-+ 1)

(export '+-BT-USE-CENTER-LIMIT-+)

(define-constant (lispify "btHingeConstraintDataName" 'constant) "btHingeConstraintFloatData" :test 'equal)

(export '+HINGE-CONSTRAINT-DATA-NAME+)

(cffi:defcenum HINGE-FLAGS
  (:HINGE-FLAGS-CFM-STOP #.1)
  (:HINGE-FLAGS-ERP-STOP #.2)
  (:HINGE-FLAGS-CFM-NORM #.4))

(export 'HINGE-FLAGS)

(declaim (inline HINGE-CONSTRAINT/MAKE-CPLUS-PLUS-INSTANCE))

(cffi:defcfun ("_wrap_btHingeConstraint_makeCPlusPlusInstance__SWIG_0" HINGE-CONSTRAINT/MAKE-CPLUS-PLUS-INSTANCE) :pointer
  (self :pointer)
  (sizeInBytes :pointer))

(export 'HINGE-CONSTRAINT/MAKE-CPLUS-PLUS-INSTANCE)

(declaim (inline HINGE-CONSTRAINT/DELETE-CPLUS-PLUS-INSTANCE))

(cffi:defcfun ("_wrap_btHingeConstraint_deleteCPlusPlusInstance__SWIG_0" HINGE-CONSTRAINT/DELETE-CPLUS-PLUS-INSTANCE) :void
  (self :pointer)
  (ptr :pointer))

(export 'HINGE-CONSTRAINT/DELETE-CPLUS-PLUS-INSTANCE)

#+ (or)
(progn 
  (declaim (inline HINGE-CONSTRAINT/MAKE-CPLUS-PLUS-INSTANCE))
  
  (cffi:defcfun ("_wrap_btHingeConstraint_makeCPlusPlusInstance__SWIG_1" HINGE-CONSTRAINT/MAKE-CPLUS-PLUS-INSTANCE) :pointer
    (self :pointer)
    (arg1 :pointer)
    (ptr :pointer))
  
  (export 'HINGE-CONSTRAINT/MAKE-CPLUS-PLUS-INSTANCE)
  (declaim (inline HINGE-CONSTRAINT/DELETE-CPLUS-PLUS-INSTANCE))

  (cffi:defcfun ("_wrap_btHingeConstraint_deleteCPlusPlusInstance__SWIG_1" HINGE-CONSTRAINT/DELETE-CPLUS-PLUS-INSTANCE) :void
   (self :pointer)
   (arg1 :pointer)
   (arg2 :pointer))

  (export 'HINGE-CONSTRAINT/DELETE-CPLUS-PLUS-INSTANCE))

(declaim (inline HINGE-CONSTRAINT/MAKE-CPLUS-ARRAY))

(cffi:defcfun ("_wrap_btHingeConstraint_makeCPlusArray__SWIG_0" HINGE-CONSTRAINT/MAKE-CPLUS-ARRAY) :pointer
  (self :pointer)
  (sizeInBytes :pointer))

(export 'HINGE-CONSTRAINT/MAKE-CPLUS-ARRAY)

(declaim (inline HINGE-CONSTRAINT/DELETE-CPLUS-ARRAY))

(cffi:defcfun ("_wrap_btHingeConstraint_deleteCPlusArray__SWIG_0" HINGE-CONSTRAINT/DELETE-CPLUS-ARRAY) :void
  (self :pointer)
  (ptr :pointer))

(export 'HINGE-CONSTRAINT/DELETE-CPLUS-ARRAY)

#+ (or)
(progn
  (declaim (inline HINGE-CONSTRAINT/MAKE-CPLUS-ARRAY))
  
  (cffi:defcfun ("_wrap_btHingeConstraint_makeCPlusArray__SWIG_1" HINGE-CONSTRAINT/MAKE-CPLUS-ARRAY) :pointer
    (self :pointer)
    (arg1 :pointer)
    (ptr :pointer))
  
  (export 'HINGE-CONSTRAINT/MAKE-CPLUS-ARRAY)
  (declaim (inline HINGE-CONSTRAINT/DELETE-CPLUS-ARRAY))

  (cffi:defcfun ("_wrap_btHingeConstraint_deleteCPlusArray__SWIG_1" HINGE-CONSTRAINT/DELETE-CPLUS-ARRAY) :void
   (self :pointer)
   (arg1 :pointer)
   (arg2 :pointer))

  (export 'HINGE-CONSTRAINT/DELETE-CPLUS-ARRAY))

(declaim (inline MAKE-HINGE-CONSTRAINT))

(cffi:defcfun ("_wrap_new_btHingeConstraint__SWIG_0" MAKE-HINGE-CONSTRAINT) :pointer
  (rbA :pointer)
  (rbB :pointer)
  (pivotInA :pointer)
  (pivotInB :pointer)
  (axisInA :pointer)
  (axisInB :pointer)
  (useReferenceFrameA :pointer))

(export 'MAKE-HINGE-CONSTRAINT)

#+ (or)
(progn
  (declaim (inline MAKE-HINGE-CONSTRAINT))

  (cffi:defcfun ("_wrap_new_btHingeConstraint__SWIG_1" MAKE-HINGE-CONSTRAINT) :pointer
   (rbA :pointer)
   (rbB :pointer)
   (pivotInA :pointer)
   (pivotInB :pointer)
   (axisInA :pointer)
   (axisInB :pointer))

  (export 'MAKE-HINGE-CONSTRAINT)

  (declaim (inline MAKE-HINGE-CONSTRAINT))

  (cffi:defcfun ("_wrap_new_btHingeConstraint__SWIG_2" MAKE-HINGE-CONSTRAINT) :pointer
   (rbA :pointer)
   (pivotInA :pointer)
   (axisInA :pointer)
   (useReferenceFrameA :pointer))

  (export 'MAKE-HINGE-CONSTRAINT)

  (declaim (inline MAKE-HINGE-CONSTRAINT))

  (cffi:defcfun ("_wrap_new_btHingeConstraint__SWIG_3" MAKE-HINGE-CONSTRAINT) :pointer
   (rbA :pointer)
   (pivotInA :pointer)
   (axisInA :pointer))

  (export 'MAKE-HINGE-CONSTRAINT)

  (declaim (inline MAKE-HINGE-CONSTRAINT))

  (cffi:defcfun ("_wrap_new_btHingeConstraint__SWIG_4" MAKE-HINGE-CONSTRAINT) :pointer
   (rbA :pointer)
   (rbB :pointer)
   (rbAFrame :pointer)
   (rbBFrame :pointer)
   (useReferenceFrameA :pointer))

  (export 'MAKE-HINGE-CONSTRAINT)

  (declaim (inline MAKE-HINGE-CONSTRAINT))

  (cffi:defcfun ("_wrap_new_btHingeConstraint__SWIG_5" MAKE-HINGE-CONSTRAINT) :pointer
   (rbA :pointer)
   (rbB :pointer)
   (rbAFrame :pointer)
   (rbBFrame :pointer))

  (export 'MAKE-HINGE-CONSTRAINT)

  (declaim (inline MAKE-HINGE-CONSTRAINT))

  (cffi:defcfun ("_wrap_new_btHingeConstraint__SWIG_6" MAKE-HINGE-CONSTRAINT) :pointer
   (rbA :pointer)
   (rbAFrame :pointer)
   (useReferenceFrameA :pointer))

  (export 'MAKE-HINGE-CONSTRAINT)

  (declaim (inline MAKE-HINGE-CONSTRAINT))

  (cffi:defcfun ("_wrap_new_btHingeConstraint__SWIG_7" MAKE-HINGE-CONSTRAINT) :pointer
   (rbA :pointer)
   (rbAFrame :pointer))

  (export 'MAKE-HINGE-CONSTRAINT)
 )
(declaim (inline HINGE-CONSTRAINT/BUILD-JACOBIAN))

(cffi:defcfun ("_wrap_btHingeConstraint_buildJacobian" HINGE-CONSTRAINT/BUILD-JACOBIAN) :void
  (self :pointer))

(export 'HINGE-CONSTRAINT/BUILD-JACOBIAN)

(declaim (inline HINGE-CONSTRAINT/GET-INFO-1))

(cffi:defcfun ("_wrap_btHingeConstraint_getInfo1" HINGE-CONSTRAINT/GET-INFO-1) :void
  (self :pointer)
  (info :pointer))

(export 'HINGE-CONSTRAINT/GET-INFO-1)

(declaim (inline HINGE-CONSTRAINT/GET-INFO-1-NON-VIRTUAL))

(cffi:defcfun ("_wrap_btHingeConstraint_getInfo1NonVirtual" HINGE-CONSTRAINT/GET-INFO-1-NON-VIRTUAL) :void
  (self :pointer)
  (info :pointer))

(export 'HINGE-CONSTRAINT/GET-INFO-1-NON-VIRTUAL)

(declaim (inline HINGE-CONSTRAINT/GET-INFO-2))

(cffi:defcfun ("_wrap_btHingeConstraint_getInfo2" HINGE-CONSTRAINT/GET-INFO-2) :void
  (self :pointer)
  (info :pointer))

(export 'HINGE-CONSTRAINT/GET-INFO-2)

(declaim (inline HINGE-CONSTRAINT/GET-INFO-2-NON-VIRTUAL))

(cffi:defcfun ("_wrap_btHingeConstraint_getInfo2NonVirtual" HINGE-CONSTRAINT/GET-INFO-2-NON-VIRTUAL) :void
  (self :pointer)
  (info :pointer)
  (transA :pointer)
  (transB :pointer)
  (angVelA :pointer)
  (angVelB :pointer))

(export 'HINGE-CONSTRAINT/GET-INFO-2-NON-VIRTUAL)

(declaim (inline HINGE-CONSTRAINT/GET-INFO-2-INTERNAL))

(cffi:defcfun ("_wrap_btHingeConstraint_getInfo2Internal" HINGE-CONSTRAINT/GET-INFO-2-INTERNAL) :void
  (self :pointer)
  (info :pointer)
  (transA :pointer)
  (transB :pointer)
  (angVelA :pointer)
  (angVelB :pointer))

(export 'HINGE-CONSTRAINT/GET-INFO-2-INTERNAL)

(declaim (inline HINGE-CONSTRAINT/GET-INFO-2-INTERNAL-USING-FRAME-OFFSET))

(cffi:defcfun ("_wrap_btHingeConstraint_getInfo2InternalUsingFrameOffset" HINGE-CONSTRAINT/GET-INFO-2-INTERNAL-USING-FRAME-OFFSET) :void
  (self :pointer)
  (info :pointer)
  (transA :pointer)
  (transB :pointer)
  (angVelA :pointer)
  (angVelB :pointer))

(export 'HINGE-CONSTRAINT/GET-INFO-2-INTERNAL-USING-FRAME-OFFSET)

(declaim (inline HINGE-CONSTRAINT/UPDATE-RHS))

(cffi:defcfun ("_wrap_btHingeConstraint_updateRHS" HINGE-CONSTRAINT/UPDATE-RHS) :void
  (self :pointer)
  (timeStep :float))

(export 'HINGE-CONSTRAINT/UPDATE-RHS)

(declaim (inline HINGE-CONSTRAINT/GET-RIGID-BODY-A))

(cffi:defcfun ("_wrap_btHingeConstraint_getRigidBodyA__SWIG_0" HINGE-CONSTRAINT/GET-RIGID-BODY-A) :pointer
  (self :pointer))

(export 'HINGE-CONSTRAINT/GET-RIGID-BODY-A)

(declaim (inline HINGE-CONSTRAINT/GET-RIGID-BODY-B))

(cffi:defcfun ("_wrap_btHingeConstraint_getRigidBodyB__SWIG_0" HINGE-CONSTRAINT/GET-RIGID-BODY-B) :pointer
  (self :pointer))

(export 'HINGE-CONSTRAINT/GET-RIGID-BODY-B)

#+ (or)
(progn 
  (declaim (inline HINGE-CONSTRAINT/GET-RIGID-BODY-A))

  (cffi:defcfun ("_wrap_btHingeConstraint_getRigidBodyA__SWIG_1" HINGE-CONSTRAINT/GET-RIGID-BODY-A) :pointer
   (self :pointer))

  (export 'HINGE-CONSTRAINT/GET-RIGID-BODY-A)

  (declaim (inline HINGE-CONSTRAINT/GET-RIGID-BODY-B))

  (cffi:defcfun ("_wrap_btHingeConstraint_getRigidBodyB__SWIG_1" HINGE-CONSTRAINT/GET-RIGID-BODY-B) :pointer
   (self :pointer))

  (export 'HINGE-CONSTRAINT/GET-RIGID-BODY-B)
 )
(declaim (inline HINGE-CONSTRAINT/GET-FRAME-OFFSET-A))

(cffi:defcfun ("_wrap_btHingeConstraint_getFrameOffsetA" HINGE-CONSTRAINT/GET-FRAME-OFFSET-A) :pointer
  (self :pointer))

(export 'HINGE-CONSTRAINT/GET-FRAME-OFFSET-A)

(declaim (inline HINGE-CONSTRAINT/GET-FRAME-OFFSET-B))

(cffi:defcfun ("_wrap_btHingeConstraint_getFrameOffsetB" HINGE-CONSTRAINT/GET-FRAME-OFFSET-B) :pointer
  (self :pointer))

(export 'HINGE-CONSTRAINT/GET-FRAME-OFFSET-B)

(declaim (inline HINGE-CONSTRAINT/SET-FRAMES))

(cffi:defcfun ("_wrap_btHingeConstraint_setFrames" HINGE-CONSTRAINT/SET-FRAMES) :void
  (self :pointer)
  (frameA :pointer)
  (frameB :pointer))

(export 'BULLET> )

(declaim (inline HINGE-CONSTRAINT/SET-ANGULAR-ONLY))

(cffi:defcfun ("_wrap_btHingeConstraint_setAngularOnly" HINGE-CONSTRAINT/SET-ANGULAR-ONLY) :void
  (self :pointer)
  (angularOnly :pointer))

(export 'HINGE-CONSTRAINT/SET-ANGULAR-ONLY)

(declaim (inline HINGE-CONSTRAINT/ENABLE-ANGULAR-MOTOR))

(cffi:defcfun ("_wrap_btHingeConstraint_enableAngularMotor" HINGE-CONSTRAINT/ENABLE-ANGULAR-MOTOR) :void
  (self :pointer)
  (enableMotor :pointer)
  (targetVelocity :float)
  (maxMotorImpulse :float))

(export 'HINGE-CONSTRAINT/ENABLE-ANGULAR-MOTOR)

(declaim (inline HINGE-CONSTRAINT/ENABLE-MOTOR))

(cffi:defcfun ("_wrap_btHingeConstraint_enableMotor" HINGE-CONSTRAINT/ENABLE-MOTOR) :void
  (self :pointer)
  (enableMotor :pointer))

(export 'HINGE-CONSTRAINT/ENABLE-MOTOR)

(declaim (inline HINGE-CONSTRAINT/SET-MAX-MOTOR-IMPULSE))

(cffi:defcfun ("_wrap_btHingeConstraint_setMaxMotorImpulse" HINGE-CONSTRAINT/SET-MAX-MOTOR-IMPULSE) :void
  (self :pointer)
  (maxMotorImpulse :float))

(export 'HINGE-CONSTRAINT/SET-MAX-MOTOR-IMPULSE)

(declaim (inline HINGE-CONSTRAINT/SET-MOTOR-TARGET))

(cffi:defcfun ("_wrap_btHingeConstraint_setMotorTarget__SWIG_0" 
               hinge-constraint/set-motor-target/q-a-in-b) :void
  (self :pointer)
  (qAinB :pointer)
  (dt :float))

(export 'hinge-constraint/set-motor-target/q-a-in-b)

(declaim (inline HINGE-CONSTRAINT/SET-MOTOR-TARGET))

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
 
(declaim (inline HINGE-CONSTRAINT/SET-AXIS))

(cffi:defcfun ("_wrap_btHingeConstraint_setAxis" HINGE-CONSTRAINT/SET-AXIS) :void
  (self :pointer)
  (axisInA :pointer))

(export 'HINGE-CONSTRAINT/SET-AXIS)

(declaim (inline HINGE-CONSTRAINT/GET-LOWER-LIMIT))

(cffi:defcfun ("_wrap_btHingeConstraint_getLowerLimit" HINGE-CONSTRAINT/GET-LOWER-LIMIT) :float
  (self :pointer))

(export 'HINGE-CONSTRAINT/GET-LOWER-LIMIT)

(declaim (inline (lispify "btHingeConstraint_getUpperLimit" 'function)))

(cffi:defcfun ("_wrap_btHingeConstraint_getUpperLimit" HINGE-CONSTRAINT/GET-UPPER-LIMIT) :float
  (self :pointer))

(export 'HINGE-CONSTRAINT/GET-UPPER-LIMIT)

(declaim (inline HINGE-CONSTRAINT/GET-HINGE-ANGLE))

(cffi:defcfun ("_wrap_btHingeConstraint_getHingeAngle__SWIG_0" HINGE-CONSTRAINT/GET-HINGE-ANGLE) :float
  (self :pointer))

(export 'HINGE-CONSTRAINT/GET-HINGE-ANGLE)

(declaim (inline HINGE-CONSTRAINT/GET-HINGE-ANGLE))

(cffi:defcfun ("_wrap_btHingeConstraint_getHingeAngle__SWIG_1" 
               HINGE-CONSTRAINT/GET-HINGE-ANGLE/with-trans-a&b) :float
  (self :pointer)
  (transA :pointer)
  (transB :pointer))

(export 'HINGE-CONSTRAINT/GET-HINGE-ANGLE)

(declaim (inline HINGE-CONSTRAINT/TEST-LIMIT))

(cffi:defcfun ("_wrap_btHingeConstraint_testLimit" HINGE-CONSTRAINT/TEST-LIMIT) :void
  (self :pointer)
  (transA :pointer)
  (transB :pointer))

(export 'HINGE-CONSTRAINT/TEST-LIMIT)

(declaim (inline HINGE-CONSTRAINT/GET-AFRAME))

(cffi:defcfun ("_wrap_btHingeConstraint_getAFrame__SWIG_0" HINGE-CONSTRAINT/GET-AFRAME) :pointer
  (self :pointer))

(export 'HINGE-CONSTRAINT/GET-AFRAME)

(declaim (inline HINGE-CONSTRAINT/GET-BFRAME))

(cffi:defcfun ("_wrap_btHingeConstraint_getBFrame__SWIG_0" HINGE-CONSTRAINT/GET-BFRAME) :pointer
  (self :pointer))

(export 'HINGE-CONSTRAINT/GET-BFRAME)

#+ (or)
(progn 
  (declaim (inline HINGE-CONSTRAINT/GET-AFRAME))

  (cffi:defcfun ("_wrap_btHingeConstraint_getAFrame__SWIG_1" HINGE-CONSTRAINT/GET-AFRAME) :pointer
   (self :pointer))

  (export 'HINGE-CONSTRAINT/GET-AFRAME)

  (declaim (inline HINGE-CONSTRAINT/GET-BFRAME))

  (cffi:defcfun ("_wrap_btHingeConstraint_getBFrame__SWIG_1" HINGE-CONSTRAINT/GET-BFRAME) :pointer
   (self :pointer))

  (export 'HINGE-CONSTRAINT/GET-BFRAME))

(declaim (inline HINGE-CONSTRAINT/GET-SOLVE-LIMIT))

(cffi:defcfun ("_wrap_btHingeConstraint_getSolveLimit" HINGE-CONSTRAINT/GET-SOLVE-LIMIT) :int
  (self :pointer))

(export 'HINGE-CONSTRAINT/GET-SOLVE-LIMIT)

(declaim (inline HINGE-CONSTRAINT/GET-LIMIT-SIGN))

(cffi:defcfun ("_wrap_btHingeConstraint_getLimitSign" HINGE-CONSTRAINT/GET-LIMIT-SIGN) :float
  (self :pointer))

(export 'HINGE-CONSTRAINT/GET-LIMIT-SIGN)

(declaim (inline HINGE-CONSTRAINT/GET-ANGULAR-ONLY))

(cffi:defcfun ("_wrap_btHingeConstraint_getAngularOnly" HINGE-CONSTRAINT/GET-ANGULAR-ONLY) :pointer
  (self :pointer))

(export 'HINGE-CONSTRAINT/GET-ANGULAR-ONLY)

(declaim (inline HINGE-CONSTRAINT/GET-ENABLE-ANGULAR-MOTOR))

(cffi:defcfun ("_wrap_btHingeConstraint_getEnableAngularMotor" HINGE-CONSTRAINT/GET-ENABLE-ANGULAR-MOTOR) :pointer
  (self :pointer))

(export 'HINGE-CONSTRAINT/GET-ENABLE-ANGULAR-MOTOR)

(declaim (inline HINGE-CONSTRAINT/GET-MOTOR-TARGET-VELOSITY))

(cffi:defcfun ("_wrap_btHingeConstraint_getMotorTargetVelosity" HINGE-CONSTRAINT/GET-MOTOR-TARGET-VELOSITY) :float
  (self :pointer))

(export 'HINGE-CONSTRAINT/GET-MOTOR-TARGET-VELOSITY)

(declaim (inline HINGE-CONSTRAINT/GET-MAX-MOTOR-IMPULSE))

(cffi:defcfun ("_wrap_btHingeConstraint_getMaxMotorImpulse" HINGE-CONSTRAINT/GET-MAX-MOTOR-IMPULSE) :float
  (self :pointer))

(export 'HINGE-CONSTRAINT/GET-MAX-MOTOR-IMPULSE)

(declaim (inline HINGE-CONSTRAINT/GET-USE-FRAME-OFFSET))

(cffi:defcfun ("_wrap_btHingeConstraint_getUseFrameOffset" HINGE-CONSTRAINT/GET-USE-FRAME-OFFSET) :pointer
  (self :pointer))

(export 'HINGE-CONSTRAINT/GET-USE-FRAME-OFFSET)

(declaim (inline HINGE-CONSTRAINT/SET-USE-FRAME-OFFSET))

(cffi:defcfun ("_wrap_btHingeConstraint_setUseFrameOffset" HINGE-CONSTRAINT/SET-USE-FRAME-OFFSET) :void
  (self :pointer)
  (frameOffsetOnOff :pointer))

(export 'HINGE-CONSTRAINT/SET-USE-FRAME-OFFSET)

(declaim (inline HINGE-CONSTRAINT/CALCULATE-SERIALIZE-BUFFER-SIZE))

(cffi:defcfun ("_wrap_btHingeConstraint_calculateSerializeBufferSize" HINGE-CONSTRAINT/CALCULATE-SERIALIZE-BUFFER-SIZE) :int
  (self :pointer))

(export 'HINGE-CONSTRAINT/CALCULATE-SERIALIZE-BUFFER-SIZE)

(declaim (inline HINGE-CONSTRAINT/SERIALIZE))

(cffi:defcfun ("_wrap_btHingeConstraint_serialize" HINGE-CONSTRAINT/SERIALIZE) :string
  (self :pointer)
  (dataBuffer :pointer)
  (serializer :pointer))

(export 'HINGE-CONSTRAINT/SERIALIZE)

(declaim (inline DELETE/BT-HINGE-CONSTRAINT))

(cffi:defcfun ("_wrap_delete_btHingeConstraint" DELETE/BT-HINGE-CONSTRAINT) :void
  (self :pointer))

(export 'DELETE/BT-HINGE-CONSTRAINT)

(cffi:defcstruct HINGE-CONSTRAINT-DOUBLE-DATA
  (TYPE-CONSTRAINT-DATA 
           (:POINTER
            (:STRUCT
                TYPED-CONSTRAINT-DATA)))
  (RB-AFRAME (:POINTER
                                             (:STRUCT
                                              transform-double-DATA)))
  (RB-BFRAME (:POINTER
                                             (:STRUCT
                                              transform-double-DATA)))
  (USE-REFERENCE-FRAME-A :int)
  (ANGULAR-ONLY :int)
  (ENABLE-ANGULAR-MOTOR :int)
  (MOTOR-TARGET-VELOCITY :float)
  (MAX-MOTOR-IMPULSE :float)
  (LOWER-LIMIT :float)
  (UPPER-LIMIT :float)
  (LIMIT-SOFTNESS :float)
  (BIAS-FACTOR :float)
  (RELAXATION-FACTOR :float))

(export 'HINGE-CONSTRAINT-DOUBLE-DATA)

(export 'TYPE-CONSTRAINT-DATA)

(export 'RB-AFRAME)

(export 'RB-BFRAME)

(export 'USE-REFERENCE-FRAME-A)

(export 'ANGULAR-ONLY)

(export 'ENABLE-ANGULAR-MOTOR)

(export 'MOTOR-TARGET-VELOCITY)

(export 'MAX-MOTOR-IMPULSE)

(export 'LOWER-LIMIT)

(export '(lispify "m_upperLimit" 'slotname))

(export 'LIMIT-SOFTNESS)

(export 'BIAS-FACTOR)

(export 'RELAXATION-FACTOR)

(cffi:defcstruct HINGE-CONSTRAINT-FLOAT-DATA
  (TYPE-CONSTRAINT-DATA (:pointer (:struct TYPED-CONSTRAINT-DATA)))
  (RB-AFRAME (:pointer (:struct TRANSFORM-FLOAT-DATA)))
  (RB-BFRAME (:pointer (:struct TRANSFORM-FLOAT-DATA)))
  (USE-REFERENCE-FRAME-A :int)
  (ANGULAR-ONLY :int)
  (ENABLE-ANGULAR-MOTOR :int)
  (MOTOR-TARGET-VELOCITY :float)
  (MAX-MOTOR-IMPULSE :float)
  (LOWER-LIMIT :float)
  (UPPER-LIMIT :float)
  (LIMIT-SOFTNESS :float)
  (BIAS-FACTOR :float)
  (RELAXATION-FACTOR :float))

(export 'HINGE-CONSTRAINT-FLOAT-DATA)

(export 'TYPE-CONSTRAINT-DATA)

(export 'RB-AFRAME)

(export 'RB-BFRAME)

(export 'USE-REFERENCE-FRAME-A)

(export 'ANGULAR-ONLY)

(export 'ENABLE-ANGULAR-MOTOR)

(export 'MOTOR-TARGET-VELOCITY)

(export 'MAX-MOTOR-IMPULSE)

(export 'LOWER-LIMIT)

(export 'UPPER-LIMIT)

(export 'LIMIT-SOFTNESS)

(export 'BIAS-FACTOR)

(export 'RELAXATION-FACTOR)

(cffi:defcstruct HINGE-CONSTRAINT-DOUBLE-DATA-2
  (TYPE-CONSTRAINT-DATA (:pointer (:struct TYPED-CONSTRAINT-DOUBLE-DATA)))
  (RB-AFRAME (:pointer (:struct TRANSFORM-DOUBLE-DATA)))
  (RB-BFRAME (:pointer (:struct TRANSFORM-DOUBLE-DATA)))
  (USE-REFERENCE-FRAME-A :int)
  (ANGULAR-ONLY :int)
  (ENABLE-ANGULAR-MOTOR :int)
  (MOTOR-TARGET-VELOCITY :double)
  (MAX-MOTOR-IMPULSE :double)
  (LOWER-LIMIT :double)
  (UPPER-LIMIT :double)
  (LIMIT-SOFTNESS :double)
  (BIAS-FACTOR :double)
  (RELAXATION-FACTOR :double)
  (PADDING-1 :pointer))

(export 'HINGE-CONSTRAINT-DOUBLE-DATA-2)

(export 'TYPE-CONSTRAINT-DATA)

(export 'RB-AFRAME)

(export 'RB-BFRAME)

(export 'USE-REFERENCE-FRAME-A)

(export 'ANGULAR-ONLY)

(export 'ENABLE-ANGULAR-MOTOR)

(export 'MOTOR-TARGET-VELOCITY)

(export 'MAX-MOTOR-IMPULSE)

(export 'LOWER-LIMIT)

(export 'UPPER-LIMIT)

(export 'LIMIT-SOFTNESS)

(export 'BIAS-FACTOR)

(export 'RELAXATION-FACTOR)

(export 'PADDING-1)

(define-constant +CONE-TWIST-CONSTRAINT-DATA-NAME+ "btConeTwistConstraintData" :test 'equal)

(export '+CONE-TWIST-CONSTRAINT-DATA-NAME+)

(cffi:defcenum CONE-TWIST-FLAGS
  (:CONETWIST-FLAGS-LIN-CFM #.1)
  (:CONETWIST-FLAGS-LIN-ERP #.2)
  (:CONETWIST-FLAGS-ANG-CFM #.4))

(export 'CONE-TWIST-FLAGS)

(declaim (inline CONE-TWIST-CONSTRAINT/MAKE-CPLUS-PLUS-INSTANCE))

(cffi:defcfun ("_wrap_btConeTwistConstraint_makeCPlusPlusInstance__SWIG_0" CONE-TWIST-CONSTRAINT/MAKE-CPLUS-PLUS-INSTANCE) :pointer
  (self :pointer)
  (sizeInBytes :pointer))

(export 'CONE-TWIST-CONSTRAINT/MAKE-CPLUS-PLUS-INSTANCE)

(declaim (inline CONE-TWIST-CONSTRAINT/DELETE-CPLUS-PLUS-INSTANCE))

(cffi:defcfun ("_wrap_btConeTwistConstraint_deleteCPlusPlusInstance__SWIG_0" CONE-TWIST-CONSTRAINT/DELETE-CPLUS-PLUS-INSTANCE) :void
  (self :pointer)
  (ptr :pointer))

(export 'CONE-TWIST-CONSTRAINT/DELETE-CPLUS-PLUS-INSTANCE)

#+ (or)
(progn 
  (declaim (inline CONE-TWIST-CONSTRAINT/MAKE-CPLUS-PLUS-INSTANCE))

  (cffi:defcfun ("_wrap_btConeTwistConstraint_makeCPlusPlusInstance__SWIG_1" CONE-TWIST-CONSTRAINT/MAKE-CPLUS-PLUS-INSTANCE) :pointer
   (self :pointer)
   (arg1 :pointer)
   (ptr :pointer))

  (export 'CONE-TWIST-CONSTRAINT/MAKE-CPLUS-PLUS-INSTANCE)

  (declaim (inline CONE-TWIST-CONSTRAINT/DELETE-CPLUS-PLUS-INSTANCE))

  (cffi:defcfun ("_wrap_btConeTwistConstraint_deleteCPlusPlusInstance__SWIG_1" CONE-TWIST-CONSTRAINT/DELETE-CPLUS-PLUS-INSTANCE) :void
   (self :pointer)
   (arg1 :pointer)
   (arg2 :pointer))

  (export 'CONE-TWIST-CONSTRAINT/DELETE-CPLUS-PLUS-INSTANCE))

(declaim (inline CONE-TWIST-CONSTRAINT/MAKE-CPLUS-ARRAY))

(cffi:defcfun ("_wrap_btConeTwistConstraint_makeCPlusArray__SWIG_0" CONE-TWIST-CONSTRAINT/MAKE-CPLUS-ARRAY) :pointer
  (self :pointer)
  (sizeInBytes :pointer))

(export 'CONE-TWIST-CONSTRAINT/MAKE-CPLUS-ARRAY)

(declaim (inline CONE-TWIST-CONSTRAINT/DELETE-CPLUS-ARRAY))

(cffi:defcfun ("_wrap_btConeTwistConstraint_deleteCPlusArray__SWIG_0" CONE-TWIST-CONSTRAINT/DELETE-CPLUS-ARRAY) :void
  (self :pointer)
  (ptr :pointer))

(export 'CONE-TWIST-CONSTRAINT/DELETE-CPLUS-ARRAY)

#+ (or)
(progn
  (declaim (inline CONE-TWIST-CONSTRAINT/MAKE-CPLUS-ARRAY))
  
  (cffi:defcfun ("_wrap_btConeTwistConstraint_makeCPlusArray__SWIG_1" CONE-TWIST-CONSTRAINT/MAKE-CPLUS-ARRAY) :pointer
    (self :pointer)
    (arg1 :pointer)
    (ptr :pointer))
  
  (export 'CONE-TWIST-CONSTRAINT/MAKE-CPLUS-ARRAY)
  
  (declaim (inline CONE-TWIST-CONSTRAINT/DELETE-CPLUS-ARRAY))

  (cffi:defcfun ("_wrap_btConeTwistConstraint_deleteCPlusArray__SWIG_1" CONE-TWIST-CONSTRAINT/DELETE-CPLUS-ARRAY) :void
   (self :pointer)
   (arg1 :pointer)
   (arg2 :pointer))

  (export 'CONE-TWIST-CONSTRAINT/DELETE-CPLUS-ARRAY))

(declaim (inline MAKE-CONE-TWIST-CONSTRAINT))

(cffi:defcfun ("_wrap_new_btConeTwistConstraint__SWIG_0" MAKE-CONE-TWIST-CONSTRAINT) :pointer
  (rbA :pointer)
  (rbB :pointer)
  (rbAFrame :pointer)
  (rbBFrame :pointer))

(export 'MAKE-CONE-TWIST-CONSTRAINT)

(declaim (inline MAKE-CONE-TWIST-CONSTRAINT))

(cffi:defcfun ("_wrap_new_btConeTwistConstraint__SWIG_1"
               make-cone-twist-constraint/without-b) :pointer
  (rbA :pointer)
  (rbAFrame :pointer))

(export 'MAKE-CONE-TWIST-CONSTRAINT)

(declaim (inline CONE-TWIST-CONSTRAINT/BUILD-JACOBIAN))

(cffi:defcfun ("_wrap_btConeTwistConstraint_buildJacobian" CONE-TWIST-CONSTRAINT/BUILD-JACOBIAN) :void
  (self :pointer))

(export 'CONE-TWIST-CONSTRAINT/BUILD-JACOBIAN)

(declaim (inline CONE-TWIST-CONSTRAINT/GET-INFO-1))

(cffi:defcfun ("_wrap_btConeTwistConstraint_getInfo1" CONE-TWIST-CONSTRAINT/GET-INFO-1) :void
  (self :pointer)
  (info :pointer))

(export 'CONE-TWIST-CONSTRAINT/GET-INFO-1)

(declaim (inline CONE-TWIST-CONSTRAINT/GET-INFO-1-NON-VIRTUAL))

(cffi:defcfun ("_wrap_btConeTwistConstraint_getInfo1NonVirtual" CONE-TWIST-CONSTRAINT/GET-INFO-1-NON-VIRTUAL) :void
  (self :pointer)
  (info :pointer))

(export 'CONE-TWIST-CONSTRAINT/GET-INFO-1-NON-VIRTUAL)

(declaim (inline CONE-TWIST-CONSTRAINT/GET-INFO-2))

(cffi:defcfun ("_wrap_btConeTwistConstraint_getInfo2" CONE-TWIST-CONSTRAINT/GET-INFO-2) :void
  (self :pointer)
  (info :pointer))

(export 'CONE-TWIST-CONSTRAINT/GET-INFO-2)

(declaim (inline CONE-TWIST-CONSTRAINT/GET-INFO-2-NON-VIRTUAL))

(cffi:defcfun ("_wrap_btConeTwistConstraint_getInfo2NonVirtual" CONE-TWIST-CONSTRAINT/GET-INFO-2-NON-VIRTUAL) :void
  (self :pointer)
  (info :pointer)
  (transA :pointer)
  (transB :pointer)
  (invInertiaWorldA :pointer)
  (invInertiaWorldB :pointer))

(export 'CONE-TWIST-CONSTRAINT/GET-INFO-2-NON-VIRTUAL)

(declaim (inline CONE-TWIST-CONSTRAINT/SOLVE-CONSTRAINT-OBSOLETE))

(cffi:defcfun ("_wrap_btConeTwistConstraint_solveConstraintObsolete" CONE-TWIST-CONSTRAINT/SOLVE-CONSTRAINT-OBSOLETE) :void
  (self :pointer)
  (bodyA :pointer)
  (bodyB :pointer)
  (timeStep :float))

(export 'CONE-TWIST-CONSTRAINT/SOLVE-CONSTRAINT-OBSOLETE)

(declaim (inline CONE-TWIST-CONSTRAINT/UPDATE-RHS))

(cffi:defcfun ("_wrap_btConeTwistConstraint_updateRHS" CONE-TWIST-CONSTRAINT/UPDATE-RHS) :void
  (self :pointer)
  (timeStep :float))

(export 'CONE-TWIST-CONSTRAINT/UPDATE-RHS)

(declaim (inline CONE-TWIST-CONSTRAINT/GET-RIGID-BODY-A))

(cffi:defcfun ("_wrap_btConeTwistConstraint_getRigidBodyA" CONE-TWIST-CONSTRAINT/GET-RIGID-BODY-A) :pointer
  (self :pointer))

(export 'CONE-TWIST-CONSTRAINT/GET-RIGID-BODY-A)

(declaim (inline CONE-TWIST-CONSTRAINT/GET-RIGID-BODY-B))

(cffi:defcfun ("_wrap_btConeTwistConstraint_getRigidBodyB" CONE-TWIST-CONSTRAINT/GET-RIGID-BODY-B) :pointer
  (self :pointer))

(export 'CONE-TWIST-CONSTRAINT/GET-RIGID-BODY-B)

(declaim (inline CONE-TWIST-CONSTRAINT/SET-ANGULAR-ONLY))

(cffi:defcfun ("_wrap_btConeTwistConstraint_setAngularOnly" CONE-TWIST-CONSTRAINT/SET-ANGULAR-ONLY) :void
  (self :pointer)
  (angularOnly :pointer))

(export 'CONE-TWIST-CONSTRAINT/SET-ANGULAR-ONLY)

#+ (or)
(progn 
  (declaim (inline CONE-TWIST-CONSTRAINT/SET-LIMIT))

  (cffi:defcfun ("_wrap_btConeTwistConstraint_setLimit__SWIG_0" CONE-TWIST-CONSTRAINT/SET-LIMIT) :void
   (self :pointer)
   (limitIndex :int)
   (limitValue :float))

  (export 'CONE-TWIST-CONSTRAINT/SET-LIMIT)

  (declaim (inline CONE-TWIST-CONSTRAINT/SET-LIMIT))

  (cffi:defcfun ("_wrap_btConeTwistConstraint_setLimit__SWIG_1" CONE-TWIST-CONSTRAINT/SET-LIMIT) :void
   (self :pointer)
   (_swingSpan1 :float)
   (_swingSpan2 :float)
   (_twistSpan :float)
   (_softness :float)
   (_biasFactor :float)
   (_relaxationFactor :float))

  (export 'CONE-TWIST-CONSTRAINT/SET-LIMIT)

  (declaim (inline CONE-TWIST-CONSTRAINT/SET-LIMIT))

  (cffi:defcfun ("_wrap_btConeTwistConstraint_setLimit__SWIG_2" CONE-TWIST-CONSTRAINT/SET-LIMIT) :void
   (self :pointer)
   (_swingSpan1 :float)
   (_swingSpan2 :float)
   (_twistSpan :float)
   (_softness :float)
   (_biasFactor :float))

  (export 'CONE-TWIST-CONSTRAINT/SET-LIMIT)

  (declaim (inline CONE-TWIST-CONSTRAINT/SET-LIMIT))

  (cffi:defcfun ("_wrap_btConeTwistConstraint_setLimit__SWIG_3" CONE-TWIST-CONSTRAINT/SET-LIMIT) :void
   (self :pointer)
   (_swingSpan1 :float)
   (_swingSpan2 :float)
   (_twistSpan :float)
   (_softness :float))

  (export 'CONE-TWIST-CONSTRAINT/SET-LIMIT)

  (declaim (inline CONE-TWIST-CONSTRAINT/SET-LIMIT))

  (cffi:defcfun ("_wrap_btConeTwistConstraint_setLimit__SWIG_4" CONE-TWIST-CONSTRAINT/SET-LIMIT) :void
   (self :pointer)
   (_swingSpan1 :float)
   (_swingSpan2 :float)
   (_twistSpan :float))

  (export 'CONE-TWIST-CONSTRAINT/SET-LIMIT)
 )
(declaim (inline CONE-TWIST-CONSTRAINT/GET-AFRAME))

(cffi:defcfun ("_wrap_btConeTwistConstraint_getAFrame" CONE-TWIST-CONSTRAINT/GET-AFRAME) :pointer
  (self :pointer))

(export 'CONE-TWIST-CONSTRAINT/GET-AFRAME)

(declaim (inline CONE-TWIST-CONSTRAINT/GET-BFRAME))

(cffi:defcfun ("_wrap_btConeTwistConstraint_getBFrame" CONE-TWIST-CONSTRAINT/GET-BFRAME) :pointer
  (self :pointer))

(export 'CONE-TWIST-CONSTRAINT/GET-BFRAME)

(declaim (inline CONE-TWIST-CONSTRAINT/GET-SOLVE-TWIST-LIMIT))

(cffi:defcfun ("_wrap_btConeTwistConstraint_getSolveTwistLimit" CONE-TWIST-CONSTRAINT/GET-SOLVE-TWIST-LIMIT) :int
  (self :pointer))

(export 'CONE-TWIST-CONSTRAINT/GET-SOLVE-TWIST-LIMIT)

(declaim (inline CONE-TWIST-CONSTRAINT/GET-SOLVE-SWING-LIMIT))

(cffi:defcfun ("_wrap_btConeTwistConstraint_getSolveSwingLimit" CONE-TWIST-CONSTRAINT/GET-SOLVE-SWING-LIMIT) :int
  (self :pointer))

(export 'CONE-TWIST-CONSTRAINT/GET-SOLVE-SWING-LIMIT)

(declaim (inline CONE-TWIST-CONSTRAINT/GET-TWIST-LIMIT-SIGN))

(cffi:defcfun ("_wrap_btConeTwistConstraint_getTwistLimitSign" CONE-TWIST-CONSTRAINT/GET-TWIST-LIMIT-SIGN) :float
  (self :pointer))

(export 'CONE-TWIST-CONSTRAINT/GET-TWIST-LIMIT-SIGN)

(declaim (inline CONE-TWIST-CONSTRAINT/CALC-ANGLE-INFO))

(cffi:defcfun ("_wrap_btConeTwistConstraint_calcAngleInfo" CONE-TWIST-CONSTRAINT/CALC-ANGLE-INFO) :void
  (self :pointer))

(export 'CONE-TWIST-CONSTRAINT/CALC-ANGLE-INFO)

(declaim (inline CONE-TWIST-CONSTRAINT/CALC-ANGLE-INFO-2))

(cffi:defcfun ("_wrap_btConeTwistConstraint_calcAngleInfo2" CONE-TWIST-CONSTRAINT/CALC-ANGLE-INFO-2) :void
  (self :pointer)
  (transA :pointer)
  (transB :pointer)
  (invInertiaWorldA :pointer)
  (invInertiaWorldB :pointer))

(export 'CONE-TWIST-CONSTRAINT/CALC-ANGLE-INFO-2)

(declaim (inline CONE-TWIST-CONSTRAINT/GET-SWING-SPAN-1))

(cffi:defcfun ("_wrap_btConeTwistConstraint_getSwingSpan1" CONE-TWIST-CONSTRAINT/GET-SWING-SPAN-1) :float
  (self :pointer))

(export 'CONE-TWIST-CONSTRAINT/GET-SWING-SPAN-1)

(declaim (inline CONE-TWIST-CONSTRAINT/GET-SWING-SPAN-2))

(cffi:defcfun ("_wrap_btConeTwistConstraint_getSwingSpan2" CONE-TWIST-CONSTRAINT/GET-SWING-SPAN-2) :float
  (self :pointer))

(export 'CONE-TWIST-CONSTRAINT/GET-SWING-SPAN-2)

(declaim (inline CONE-TWIST-CONSTRAINT/GET-TWIST-SPAN))

(cffi:defcfun ("_wrap_btConeTwistConstraint_getTwistSpan" CONE-TWIST-CONSTRAINT/GET-TWIST-SPAN) :float
  (self :pointer))

(export 'CONE-TWIST-CONSTRAINT/GET-TWIST-SPAN)

(declaim (inline CONE-TWIST-CONSTRAINT/GET-TWIST-ANGLE))

(cffi:defcfun ("_wrap_btConeTwistConstraint_getTwistAngle" CONE-TWIST-CONSTRAINT/GET-TWIST-ANGLE) :float
  (self :pointer))

(export 'CONE-TWIST-CONSTRAINT/GET-TWIST-ANGLE)

(declaim (inline CONE-TWIST-CONSTRAINT/IS-PAST-SWING-LIMIT))

(cffi:defcfun ("_wrap_btConeTwistConstraint_isPastSwingLimit" CONE-TWIST-CONSTRAINT/IS-PAST-SWING-LIMIT) :pointer
  (self :pointer))

(export 'CONE-TWIST-CONSTRAINT/IS-PAST-SWING-LIMIT)

(declaim (inline CONE-TWIST-CONSTRAINT/SET-DAMPING))

(cffi:defcfun ("_wrap_btConeTwistConstraint_setDamping" CONE-TWIST-CONSTRAINT/SET-DAMPING) :void
  (self :pointer)
  (damping :float))

(export 'CONE-TWIST-CONSTRAINT/SET-DAMPING)

(declaim (inline CONE-TWIST-CONSTRAINT/ENABLE-MOTOR))

(cffi:defcfun ("_wrap_btConeTwistConstraint_enableMotor" CONE-TWIST-CONSTRAINT/ENABLE-MOTOR) :void
  (self :pointer)
  (b :pointer))

(export 'CONE-TWIST-CONSTRAINT/ENABLE-MOTOR)

(declaim (inline CONE-TWIST-CONSTRAINT/SET-MAX-MOTOR-IMPULSE))

(cffi:defcfun ("_wrap_btConeTwistConstraint_setMaxMotorImpulse" CONE-TWIST-CONSTRAINT/SET-MAX-MOTOR-IMPULSE) :void
  (self :pointer)
  (maxMotorImpulse :float))

(export 'CONE-TWIST-CONSTRAINT/SET-MAX-MOTOR-IMPULSE)

(declaim (inline CONE-TWIST-CONSTRAINT/SET-MAX-MOTOR-IMPULSE-NORMALIZED))

(cffi:defcfun ("_wrap_btConeTwistConstraint_setMaxMotorImpulseNormalized" CONE-TWIST-CONSTRAINT/SET-MAX-MOTOR-IMPULSE-NORMALIZED) :void
  (self :pointer)
  (maxMotorImpulse :float))

(export 'CONE-TWIST-CONSTRAINT/SET-MAX-MOTOR-IMPULSE-NORMALIZED)

(declaim (inline CONE-TWIST-CONSTRAINT/GET-FIX-THRESH))

(cffi:defcfun ("_wrap_btConeTwistConstraint_getFixThresh" CONE-TWIST-CONSTRAINT/GET-FIX-THRESH) :float
  (self :pointer))

(export 'CONE-TWIST-CONSTRAINT/GET-FIX-THRESH)

(declaim (inline CONE-TWIST-CONSTRAINT/SET-FIX-THRESH))

(cffi:defcfun ("_wrap_btConeTwistConstraint_setFixThresh" CONE-TWIST-CONSTRAINT/SET-FIX-THRESH) :void
  (self :pointer)
  (fixThresh :float))

(export 'CONE-TWIST-CONSTRAINT/SET-FIX-THRESH)

(declaim (inline CONE-TWIST-CONSTRAINT/SET-MOTOR-TARGET))

(cffi:defcfun ("_wrap_btConeTwistConstraint_setMotorTarget" CONE-TWIST-CONSTRAINT/SET-MOTOR-TARGET) :void
  (self :pointer)
  (q :pointer))

(export 'CONE-TWIST-CONSTRAINT/SET-MOTOR-TARGET)

(declaim (inline CONE-TWIST-CONSTRAINT/SET-MOTOR-TARGET-IN-CONSTRAINT-SPACE))

(cffi:defcfun ("_wrap_btConeTwistConstraint_setMotorTargetInConstraintSpace" CONE-TWIST-CONSTRAINT/SET-MOTOR-TARGET-IN-CONSTRAINT-SPACE) :void
  (self :pointer)
  (q :pointer))

(export 'CONE-TWIST-CONSTRAINT/SET-MOTOR-TARGET-IN-CONSTRAINT-SPACE)

(declaim (inline CONE-TWIST-CONSTRAINT/GET-POINT-FOR-ANGLE))

(cffi:defcfun ("_wrap_btConeTwistConstraint_GetPointForAngle" CONE-TWIST-CONSTRAINT/GET-POINT-FOR-ANGLE) :pointer
  (self :pointer)
  (fAngleInRadians :float)
  (fLength :float))

(export 'CONE-TWIST-CONSTRAINT/GET-POINT-FOR-ANGLE)

(declaim (inline CONE-TWIST-CONSTRAINT/SET-FRAMES))

(cffi:defcfun ("_wrap_btConeTwistConstraint_setFrames" CONE-TWIST-CONSTRAINT/SET-FRAMES) :void
  (self :pointer)
  (frameA :pointer)
  (frameB :pointer))

(export 'CONE-TWIST-CONSTRAINT/SET-FRAMES)

(declaim (inline CONE-TWIST-CONSTRAINT/GET-FRAME-OFFSET-A))

(cffi:defcfun ("_wrap_btConeTwistConstraint_getFrameOffsetA" CONE-TWIST-CONSTRAINT/GET-FRAME-OFFSET-A) :pointer
  (self :pointer))

(export 'CONE-TWIST-CONSTRAINT/GET-FRAME-OFFSET-A)

(declaim (inline CONE-TWIST-CONSTRAINT/GET-FRAME-OFFSET-B))

(cffi:defcfun ("_wrap_btConeTwistConstraint_getFrameOffsetB" CONE-TWIST-CONSTRAINT/GET-FRAME-OFFSET-B) :pointer
  (self :pointer))

(export 'CONE-TWIST-CONSTRAINT/GET-FRAME-OFFSET-B)

(declaim (inline CONE-TWIST-CONSTRAINT/CALCULATE-SERIALIZE-BUFFER-SIZE))

(cffi:defcfun ("_wrap_btConeTwistConstraint_calculateSerializeBufferSize" CONE-TWIST-CONSTRAINT/CALCULATE-SERIALIZE-BUFFER-SIZE) :int
  (self :pointer))

(export 'CONE-TWIST-CONSTRAINT/CALCULATE-SERIALIZE-BUFFER-SIZE)

(declaim (inline CONE-TWIST-CONSTRAINT/SERIALIZE))

(cffi:defcfun ("_wrap_btConeTwistConstraint_serialize" CONE-TWIST-CONSTRAINT/SERIALIZE) :string
  (self :pointer)
  (dataBuffer :pointer)
  (serializer :pointer))

(export 'CONE-TWIST-CONSTRAINT/SERIALIZE)

(declaim (inline DELETE/BT-CONE-TWIST-CONSTRAINT))

(cffi:defcfun ("_wrap_delete_btConeTwistConstraint" DELETE/BT-CONE-TWIST-CONSTRAINT) :void
  (self :pointer))

(export 'DELETE/BT-CONE-TWIST-CONSTRAINT)

(cffi:defcstruct CONE-TWIST-CONSTRAINT-DOUBLE-DATA
  (TYPE-CONSTRAINT-DATA 
           (:pointer (:struct TYPED-CONSTRAINT-DOUBLE-DATA)))
  (RB-AFRAME
           (:pointer (:struct TRANSFORM-DOUBLE-DATA)))
  (RB-BFRAME 
           (:pointer (:struct TRANSFORM-DOUBLE-DATA)))
  (SWING-SPAN-1 :double)
  (SWING-SPAN-2 :double)
  (TWIST-SPAN :double)
  (LIMIT-SOFTNESS :double)
  (BIAS-FACTOR :double)
  (RELAXATION-FACTOR :double)
  (DAMPING :double))

(export 'CONE-TWIST-CONSTRAINT-DOUBLE-DATA)

(export 'TYPE-CONSTRAINT-DATA)

(export 'RB-AFRAME)

(export 'RB-BFRAME)

(export 'SWING-SPAN-1)

(export 'SWING-SPAN-2)

(export 'TWIST-SPAN)

(export 'LIMIT-SOFTNESS)

(export 'BIAS-FACTOR)

(export 'RELAXATION-FACTOR)

(export 'DAMPING)

(cffi:defcstruct CONE-TWIST-CONSTRAINT-DATA
  (TYPE-CONSTRAINT-DATA
                    (:POINTER (:STRUCT
                               TYPED-CONSTRAINT-DATA)))
  (RB-AFRAME (:pointer (:struct transform-float-data)))
  (RB-BFRAME (:pointer (:struct transform-float-data)))
  (SWING-SPAN-1 :float)
  (SWING-SPAN-2 :float)
  (TWIST-SPAN :float)
  (LIMIT-SOFTNESS :float)
  (BIAS-FACTOR :float)
  (RELAXATION-FACTOR :float)
  (DAMPING :float)
  (PAD :pointer))

(export 'CONE-TWIST-CONSTRAINT-DATA)

(export 'TYPE-CONSTRAINT-DATA)

(export 'RB-AFRAME)

(export 'RB-BFRAME)

(export 'SWING-SPAN-1)

(export 'SWING-SPAN-2)

(export 'TWIST-SPAN)

(export 'LIMIT-SOFTNESS)

(export 'BIAS-FACTOR)

(export 'RELAXATION-FACTOR)

(export 'DAMPING)

(export 'PAD)

(define-constant +GENERIC-6-DOF-CONSTRAINT-DATA-NAME+ "btGeneric6DofConstraintData" :test 'equal)

(export '+GENERIC-6-DOF-CONSTRAINT-DATA-NAME+)

(declaim (inline ROTATIONAL-LIMIT-MOTOR/M/LO-LIMIT/SET))

(cffi:defcfun ("_wrap_btRotationalLimitMotor_m_loLimit_set" ROTATIONAL-LIMIT-MOTOR/M/LO-LIMIT/SET) :void
  (self :pointer)
  (m_loLimit :float))

(export 'ROTATIONAL-LIMIT-MOTOR/M/LO-LIMIT/SET)

(declaim (inline ROTATIONAL-LIMIT-MOTOR/M/LO-LIMIT/GET))

(cffi:defcfun ("_wrap_btRotationalLimitMotor_m_loLimit_get" ROTATIONAL-LIMIT-MOTOR/M/LO-LIMIT/GET) :float
  (self :pointer))

(export 'ROTATIONAL-LIMIT-MOTOR/M/LO-LIMIT/GET)

(declaim (inline ROTATIONAL-LIMIT-MOTOR/M/HI-LIMIT/SET))

(cffi:defcfun ("_wrap_btRotationalLimitMotor_m_hiLimit_set" ROTATIONAL-LIMIT-MOTOR/M/HI-LIMIT/SET) :void
  (self :pointer)
  (m_hiLimit :float))

(export 'ROTATIONAL-LIMIT-MOTOR/M/HI-LIMIT/SET)

(declaim (inline ROTATIONAL-LIMIT-MOTOR/M/HI-LIMIT/GET))

(cffi:defcfun ("_wrap_btRotationalLimitMotor_m_hiLimit_get" ROTATIONAL-LIMIT-MOTOR/M/HI-LIMIT/GET) :float
  (self :pointer))

(export 'ROTATIONAL-LIMIT-MOTOR/M/HI-LIMIT/GET)

(declaim (inline ROTATIONAL-LIMIT-MOTOR/M/TARGET-VELOCITY/SET))

(cffi:defcfun ("_wrap_btRotationalLimitMotor_m_targetVelocity_set" ROTATIONAL-LIMIT-MOTOR/M/TARGET-VELOCITY/SET) :void
  (self :pointer)
  (m_targetVelocity :float))

(export 'ROTATIONAL-LIMIT-MOTOR/M/TARGET-VELOCITY/SET)

(declaim (inline ROTATIONAL-LIMIT-MOTOR/M/TARGET-VELOCITY/GET))

(cffi:defcfun ("_wrap_btRotationalLimitMotor_m_targetVelocity_get" ROTATIONAL-LIMIT-MOTOR/M/TARGET-VELOCITY/GET) :float
  (self :pointer))

(export 'ROTATIONAL-LIMIT-MOTOR/M/TARGET-VELOCITY/GET)

(declaim (inline ROTATIONAL-LIMIT-MOTOR/M/MAX-MOTOR-FORCE/SET))

(cffi:defcfun ("_wrap_btRotationalLimitMotor_m_maxMotorForce_set" ROTATIONAL-LIMIT-MOTOR/M/MAX-MOTOR-FORCE/SET) :void
  (self :pointer)
  (m_maxMotorForce :float))

(export 'ROTATIONAL-LIMIT-MOTOR/M/MAX-MOTOR-FORCE/SET)

(declaim (inline ROTATIONAL-LIMIT-MOTOR/M/MAX-MOTOR-FORCE/GET))

(cffi:defcfun ("_wrap_btRotationalLimitMotor_m_maxMotorForce_get" ROTATIONAL-LIMIT-MOTOR/M/MAX-MOTOR-FORCE/GET) :float
  (self :pointer))

(export 'ROTATIONAL-LIMIT-MOTOR/M/MAX-MOTOR-FORCE/GET)

(declaim (inline ROTATIONAL-LIMIT-MOTOR/M/MAX-LIMIT-FORCE/SET))

(cffi:defcfun ("_wrap_btRotationalLimitMotor_m_maxLimitForce_set" ROTATIONAL-LIMIT-MOTOR/M/MAX-LIMIT-FORCE/SET) :void
  (self :pointer)
  (m_maxLimitForce :float))

(export 'ROTATIONAL-LIMIT-MOTOR/M/MAX-LIMIT-FORCE/SET)

(declaim (inline ROTATIONAL-LIMIT-MOTOR/M/MAX-LIMIT-FORCE/GET))

(cffi:defcfun ("_wrap_btRotationalLimitMotor_m_maxLimitForce_get" ROTATIONAL-LIMIT-MOTOR/M/MAX-LIMIT-FORCE/GET) :float
  (self :pointer))

(export 'ROTATIONAL-LIMIT-MOTOR/M/MAX-LIMIT-FORCE/GET)

(declaim (inline ROTATIONAL-LIMIT-MOTOR/M/DAMPING/SET))

(cffi:defcfun ("_wrap_btRotationalLimitMotor_m_damping_set" ROTATIONAL-LIMIT-MOTOR/M/DAMPING/SET) :void
  (self :pointer)
  (m_damping :float))

(export 'ROTATIONAL-LIMIT-MOTOR/M/DAMPING/SET)

(declaim (inline ROTATIONAL-LIMIT-MOTOR/M/DAMPING/GET))

(cffi:defcfun ("_wrap_btRotationalLimitMotor_m_damping_get" ROTATIONAL-LIMIT-MOTOR/M/DAMPING/GET) :float
  (self :pointer))

(export 'ROTATIONAL-LIMIT-MOTOR/M/DAMPING/GET)

(declaim (inline ROTATIONAL-LIMIT-MOTOR/M/LIMIT-SOFTNESS/SET))

(cffi:defcfun ("_wrap_btRotationalLimitMotor_m_limitSoftness_set" ROTATIONAL-LIMIT-MOTOR/M/LIMIT-SOFTNESS/SET) :void
  (self :pointer)
  (m_limitSoftness :float))

(export 'ROTATIONAL-LIMIT-MOTOR/M/LIMIT-SOFTNESS/SET)

(declaim (inline ROTATIONAL-LIMIT-MOTOR/M/LIMIT-SOFTNESS/GET))

(cffi:defcfun ("_wrap_btRotationalLimitMotor_m_limitSoftness_get" ROTATIONAL-LIMIT-MOTOR/M/LIMIT-SOFTNESS/GET) :float
  (self :pointer))

(export 'ROTATIONAL-LIMIT-MOTOR/M/LIMIT-SOFTNESS/GET)

(declaim (inline ROTATIONAL-LIMIT-MOTOR/M/NORMAL-CFM/SET))

(cffi:defcfun ("_wrap_btRotationalLimitMotor_m_normalCFM_set" ROTATIONAL-LIMIT-MOTOR/M/NORMAL-CFM/SET) :void
  (self :pointer)
  (m_normalCFM :float))

(export 'ROTATIONAL-LIMIT-MOTOR/M/NORMAL-CFM/SET)

(declaim (inline ROTATIONAL-LIMIT-MOTOR/M/NORMAL-CFM/GET))

(cffi:defcfun ("_wrap_btRotationalLimitMotor_m_normalCFM_get" ROTATIONAL-LIMIT-MOTOR/M/NORMAL-CFM/GET) :float
  (self :pointer))

(export 'ROTATIONAL-LIMIT-MOTOR/M/NORMAL-CFM/GET)

(declaim (inline ROTATIONAL-LIMIT-MOTOR/M/STOP-ERP/SET))

(cffi:defcfun ("_wrap_btRotationalLimitMotor_m_stopERP_set" ROTATIONAL-LIMIT-MOTOR/M/STOP-ERP/SET) :void
  (self :pointer)
  (m_stopERP :float))

(export 'ROTATIONAL-LIMIT-MOTOR/M/STOP-ERP/SET)

(declaim (inline ROTATIONAL-LIMIT-MOTOR/M/STOP-ERP/GET))

(cffi:defcfun ("_wrap_btRotationalLimitMotor_m_stopERP_get" ROTATIONAL-LIMIT-MOTOR/M/STOP-ERP/GET) :float
  (self :pointer))

(export 'ROTATIONAL-LIMIT-MOTOR/M/STOP-ERP/GET)

(declaim (inline ROTATIONAL-LIMIT-MOTOR/M/STOP-CFM/SET))

(cffi:defcfun ("_wrap_btRotationalLimitMotor_m_stopCFM_set" ROTATIONAL-LIMIT-MOTOR/M/STOP-CFM/SET) :void
  (self :pointer)
  (m_stopCFM :float))

(export 'ROTATIONAL-LIMIT-MOTOR/M/STOP-CFM/SET)

(declaim (inline ROTATIONAL-LIMIT-MOTOR/M/STOP-CFM/GET))

(cffi:defcfun ("_wrap_btRotationalLimitMotor_m_stopCFM_get" ROTATIONAL-LIMIT-MOTOR/M/STOP-CFM/GET) :float
  (self :pointer))

(export 'ROTATIONAL-LIMIT-MOTOR/M/STOP-CFM/GET)

(declaim (inline ROTATIONAL-LIMIT-MOTOR/M/BOUNCE/SET))

(cffi:defcfun ("_wrap_btRotationalLimitMotor_m_bounce_set" ROTATIONAL-LIMIT-MOTOR/M/BOUNCE/SET) :void
  (self :pointer)
  (m_bounce :float))

(export 'ROTATIONAL-LIMIT-MOTOR/M/BOUNCE/SET)

(declaim (inline ROTATIONAL-LIMIT-MOTOR/M/BOUNCE/GET))

(cffi:defcfun ("_wrap_btRotationalLimitMotor_m_bounce_get" ROTATIONAL-LIMIT-MOTOR/M/BOUNCE/GET) :float
  (self :pointer))

(export 'ROTATIONAL-LIMIT-MOTOR/M/BOUNCE/GET)

(declaim (inline ROTATIONAL-LIMIT-MOTOR/M/ENABLE-MOTOR/SET))

(cffi:defcfun ("_wrap_btRotationalLimitMotor_m_enableMotor_set" ROTATIONAL-LIMIT-MOTOR/M/ENABLE-MOTOR/SET) :void
  (self :pointer)
  (m_enableMotor :pointer))

(export 'ROTATIONAL-LIMIT-MOTOR/M/ENABLE-MOTOR/SET)

(declaim (inline ROTATIONAL-LIMIT-MOTOR/M/ENABLE-MOTOR/GET))

(cffi:defcfun ("_wrap_btRotationalLimitMotor_m_enableMotor_get" ROTATIONAL-LIMIT-MOTOR/M/ENABLE-MOTOR/GET) :pointer
  (self :pointer))

(export 'ROTATIONAL-LIMIT-MOTOR/M/ENABLE-MOTOR/GET)

(declaim (inline ROTATIONAL-LIMIT-MOTOR/M/CURRENT-LIMIT-ERROR/SET))

(cffi:defcfun ("_wrap_btRotationalLimitMotor_m_currentLimitError_set" ROTATIONAL-LIMIT-MOTOR/M/CURRENT-LIMIT-ERROR/SET) :void
  (self :pointer)
  (m_currentLimitError :float))

(export 'ROTATIONAL-LIMIT-MOTOR/M/CURRENT-LIMIT-ERROR/SET)

(declaim (inline ROTATIONAL-LIMIT-MOTOR/M/CURRENT-LIMIT-ERROR/GET))

(cffi:defcfun ("_wrap_btRotationalLimitMotor_m_currentLimitError_get" ROTATIONAL-LIMIT-MOTOR/M/CURRENT-LIMIT-ERROR/GET) :float
  (self :pointer))

(export 'ROTATIONAL-LIMIT-MOTOR/M/CURRENT-LIMIT-ERROR/GET)

(declaim (inline ROTATIONAL-LIMIT-MOTOR/M/CURRENT-POSITION/SET))

(cffi:defcfun ("_wrap_btRotationalLimitMotor_m_currentPosition_set" ROTATIONAL-LIMIT-MOTOR/M/CURRENT-POSITION/SET) :void
  (self :pointer)
  (m_currentPosition :float))

(export 'ROTATIONAL-LIMIT-MOTOR/M/CURRENT-POSITION/SET)

(declaim (inline ROTATIONAL-LIMIT-MOTOR/M/CURRENT-POSITION/GET))

(cffi:defcfun ("_wrap_btRotationalLimitMotor_m_currentPosition_get" ROTATIONAL-LIMIT-MOTOR/M/CURRENT-POSITION/GET) :float
  (self :pointer))

(export 'ROTATIONAL-LIMIT-MOTOR/M/CURRENT-POSITION/GET)

(declaim (inline ROTATIONAL-LIMIT-MOTOR/M/CURRENT-LIMIT/SET))

(cffi:defcfun ("_wrap_btRotationalLimitMotor_m_currentLimit_set" ROTATIONAL-LIMIT-MOTOR/M/CURRENT-LIMIT/SET) :void
  (self :pointer)
  (m_currentLimit :int))

(export 'ROTATIONAL-LIMIT-MOTOR/M/CURRENT-LIMIT/SET)

(declaim (inline ROTATIONAL-LIMIT-MOTOR/M/CURRENT-LIMIT/GET))

(cffi:defcfun ("_wrap_btRotationalLimitMotor_m_currentLimit_get" ROTATIONAL-LIMIT-MOTOR/M/CURRENT-LIMIT/GET) :int
  (self :pointer))

(export 'ROTATIONAL-LIMIT-MOTOR/M/CURRENT-LIMIT/GET)

(declaim (inline ROTATIONAL-LIMIT-MOTOR/M/ACCUMULATED-IMPULSE/SET))

(cffi:defcfun ("_wrap_btRotationalLimitMotor_m_accumulatedImpulse_set" ROTATIONAL-LIMIT-MOTOR/M/ACCUMULATED-IMPULSE/SET) :void
  (self :pointer)
  (m_accumulatedImpulse :float))

(export 'ROTATIONAL-LIMIT-MOTOR/M/ACCUMULATED-IMPULSE/SET)

(declaim (inline ROTATIONAL-LIMIT-MOTOR/M/ACCUMULATED-IMPULSE/GET))

(cffi:defcfun ("_wrap_btRotationalLimitMotor_m_accumulatedImpulse_get" ROTATIONAL-LIMIT-MOTOR/M/ACCUMULATED-IMPULSE/GET) :float
  (self :pointer))

(export 'ROTATIONAL-LIMIT-MOTOR/M/ACCUMULATED-IMPULSE/GET)

(declaim (inline MAKE-ROTATIONAL-LIMIT-MOTOR))

(cffi:defcfun ("_wrap_new_btRotationalLimitMotor__SWIG_0" MAKE-ROTATIONAL-LIMIT-MOTOR) :pointer)

(export 'MAKE-ROTATIONAL-LIMIT-MOTOR)

#+ (or)
(progn
  (declaim (inline MAKE-ROTATIONAL-LIMIT-MOTOR))

  (cffi:defcfun ("_wrap_new_btRotationalLimitMotor__SWIG_1" MAKE-ROTATIONAL-LIMIT-MOTOR) :pointer
   (limot :pointer))

  (export 'MAKE-ROTATIONAL-LIMIT-MOTOR))

(declaim (inline ROTATIONAL-LIMIT-MOTOR/IS-LIMITED))

(cffi:defcfun ("_wrap_btRotationalLimitMotor_isLimited" ROTATIONAL-LIMIT-MOTOR/IS-LIMITED) :pointer
  (self :pointer))

(export 'ROTATIONAL-LIMIT-MOTOR/IS-LIMITED)

(declaim (inline ROTATIONAL-LIMIT-MOTOR/NEED-APPLY-TORQUES))

(cffi:defcfun ("_wrap_btRotationalLimitMotor_needApplyTorques" ROTATIONAL-LIMIT-MOTOR/NEED-APPLY-TORQUES) :pointer
  (self :pointer))

(export 'ROTATIONAL-LIMIT-MOTOR/NEED-APPLY-TORQUES)

(declaim (inline ROTATIONAL-LIMIT-MOTOR/TEST-LIMIT-VALUE))

(cffi:defcfun ("_wrap_btRotationalLimitMotor_testLimitValue" ROTATIONAL-LIMIT-MOTOR/TEST-LIMIT-VALUE) :int
  (self :pointer)
  (test_value :float))

(export 'ROTATIONAL-LIMIT-MOTOR/TEST-LIMIT-VALUE)

(declaim (inline ROTATIONAL-LIMIT-MOTOR/SOLVE-ANGULAR-LIMITS))

(cffi:defcfun ("_wrap_btRotationalLimitMotor_solveAngularLimits" ROTATIONAL-LIMIT-MOTOR/SOLVE-ANGULAR-LIMITS) :float
  (self :pointer)
  (timeStep :float)
  (axis :pointer)
  (jacDiagABInv :float)
  (body0 :pointer)
  (body1 :pointer))

(export 'ROTATIONAL-LIMIT-MOTOR/SOLVE-ANGULAR-LIMITS)

(declaim (inline DELETE/BT-ROTATIONAL-LIMIT-MOTOR))

(cffi:defcfun ("_wrap_delete_btRotationalLimitMotor" DELETE/BT-ROTATIONAL-LIMIT-MOTOR) :void
  (self :pointer))

(export 'DELETE/BT-ROTATIONAL-LIMIT-MOTOR)

(declaim (inline TRANSLATIONAL-LIMIT-MOTOR/M/LOWER-LIMIT/SET))

(cffi:defcfun ("_wrap_btTranslationalLimitMotor_m_lowerLimit_set" TRANSLATIONAL-LIMIT-MOTOR/M/LOWER-LIMIT/SET) :void
  (self :pointer)
  (m_lowerLimit :pointer))

(export 'TRANSLATIONAL-LIMIT-MOTOR/M/LOWER-LIMIT/SET)

(declaim (inline TRANSLATIONAL-LIMIT-MOTOR/M/LOWER-LIMIT/GET))

(cffi:defcfun ("_wrap_btTranslationalLimitMotor_m_lowerLimit_get" TRANSLATIONAL-LIMIT-MOTOR/M/LOWER-LIMIT/GET) :pointer
  (self :pointer))

(export 'TRANSLATIONAL-LIMIT-MOTOR/M/LOWER-LIMIT/GET)

(declaim (inline TRANSLATIONAL-LIMIT-MOTOR/M/UPPER-LIMIT/SET))

(cffi:defcfun ("_wrap_btTranslationalLimitMotor_m_upperLimit_set" TRANSLATIONAL-LIMIT-MOTOR/M/UPPER-LIMIT/SET) :void
  (self :pointer)
  (m_upperLimit :pointer))

(export 'TRANSLATIONAL-LIMIT-MOTOR/M/UPPER-LIMIT/SET)

(declaim (inline TRANSLATIONAL-LIMIT-MOTOR/M/UPPER-LIMIT/GET))

(cffi:defcfun ("_wrap_btTranslationalLimitMotor_m_upperLimit_get" (lispify "btTranslationalLimitMotor_m_upperLimit_get" 'function)) :pointer
  (self :pointer))

(export 'TRANSLATIONAL-LIMIT-MOTOR/M/UPPER-LIMIT/GET)

(declaim (inline TRANSLATIONAL-LIMIT-MOTOR/M/ACCUMULATED-IMPULSE/SET))

(cffi:defcfun ("_wrap_btTranslationalLimitMotor_m_accumulatedImpulse_set" TRANSLATIONAL-LIMIT-MOTOR/M/ACCUMULATED-IMPULSE/SET) :void
  (self :pointer)
  (m_accumulatedImpulse :pointer))

(export 'TRANSLATIONAL-LIMIT-MOTOR/M/ACCUMULATED-IMPULSE/SET)

(declaim (inline TRANSLATIONAL-LIMIT-MOTOR/M/ACCUMULATED-IMPULSE/GET))

(cffi:defcfun ("_wrap_btTranslationalLimitMotor_m_accumulatedImpulse_get" TRANSLATIONAL-LIMIT-MOTOR/M/ACCUMULATED-IMPULSE/GET) :pointer
  (self :pointer))

(export 'TRANSLATIONAL-LIMIT-MOTOR/M/ACCUMULATED-IMPULSE/GET)

(declaim (inline TRANSLATIONAL-LIMIT-MOTOR/M/LIMIT-SOFTNESS/SET))

(cffi:defcfun ("_wrap_btTranslationalLimitMotor_m_limitSoftness_set" TRANSLATIONAL-LIMIT-MOTOR/M/LIMIT-SOFTNESS/SET) :void
  (self :pointer)
  (m_limitSoftness :float))

(export 'TRANSLATIONAL-LIMIT-MOTOR/M/LIMIT-SOFTNESS/SET)

(declaim (inline TRANSLATIONAL-LIMIT-MOTOR/M/LIMIT-SOFTNESS/GET))

(cffi:defcfun ("_wrap_btTranslationalLimitMotor_m_limitSoftness_get" TRANSLATIONAL-LIMIT-MOTOR/M/LIMIT-SOFTNESS/GET) :float
  (self :pointer))

(export 'TRANSLATIONAL-LIMIT-MOTOR/M/LIMIT-SOFTNESS/GET)

(declaim (inline TRANSLATIONAL-LIMIT-MOTOR/M/DAMPING/SET))

(cffi:defcfun ("_wrap_btTranslationalLimitMotor_m_damping_set" TRANSLATIONAL-LIMIT-MOTOR/M/DAMPING/SET) :void
  (self :pointer)
  (m_damping :float))

(export 'TRANSLATIONAL-LIMIT-MOTOR/M/DAMPING/SET)

(declaim (inline TRANSLATIONAL-LIMIT-MOTOR/M/DAMPING/GET))

(cffi:defcfun ("_wrap_btTranslationalLimitMotor_m_damping_get" TRANSLATIONAL-LIMIT-MOTOR/M/DAMPING/GET) :float
  (self :pointer))

(export 'TRANSLATIONAL-LIMIT-MOTOR/M/DAMPING/GET)

(declaim (inline TRANSLATIONAL-LIMIT-MOTOR/M/RESTITUTION/SET))

(cffi:defcfun ("_wrap_btTranslationalLimitMotor_m_restitution_set" TRANSLATIONAL-LIMIT-MOTOR/M/RESTITUTION/SET) :void
  (self :pointer)
  (m_restitution :float))

(export 'TRANSLATIONAL-LIMIT-MOTOR/M/RESTITUTION/SET)

(declaim (inline TRANSLATIONAL-LIMIT-MOTOR/M/RESTITUTION/GET))

(cffi:defcfun ("_wrap_btTranslationalLimitMotor_m_restitution_get" TRANSLATIONAL-LIMIT-MOTOR/M/RESTITUTION/GET) :float
  (self :pointer))

(export 'TRANSLATIONAL-LIMIT-MOTOR/M/RESTITUTION/GET)

(declaim (inline TRANSLATIONAL-LIMIT-MOTOR/M/NORMAL-CFM/SET))

(cffi:defcfun ("_wrap_btTranslationalLimitMotor_m_normalCFM_set" TRANSLATIONAL-LIMIT-MOTOR/M/NORMAL-CFM/SET) :void
  (self :pointer)
  (m_normalCFM :pointer))

(export 'TRANSLATIONAL-LIMIT-MOTOR/M/NORMAL-CFM/SET)

(declaim (inline TRANSLATIONAL-LIMIT-MOTOR/M/NORMAL-CFM/GET))

(cffi:defcfun ("_wrap_btTranslationalLimitMotor_m_normalCFM_get" TRANSLATIONAL-LIMIT-MOTOR/M/NORMAL-CFM/GET) :pointer
  (self :pointer))

(export 'TRANSLATIONAL-LIMIT-MOTOR/M/NORMAL-CFM/GET)

(declaim (inline TRANSLATIONAL-LIMIT-MOTOR/M/STOP-ERP/SET))

(cffi:defcfun ("_wrap_btTranslationalLimitMotor_m_stopERP_set" TRANSLATIONAL-LIMIT-MOTOR/M/STOP-ERP/SET) :void
  (self :pointer)
  (m_stopERP :pointer))

(export 'TRANSLATIONAL-LIMIT-MOTOR/M/STOP-ERP/SET)

(declaim (inline TRANSLATIONAL-LIMIT-MOTOR/M/STOP-ERP/GET))

(cffi:defcfun ("_wrap_btTranslationalLimitMotor_m_stopERP_get" TRANSLATIONAL-LIMIT-MOTOR/M/STOP-ERP/GET) :pointer
  (self :pointer))

(export 'TRANSLATIONAL-LIMIT-MOTOR/M/STOP-ERP/GET)

(declaim (inline TRANSLATIONAL-LIMIT-MOTOR/M/STOP-CFM/SET))

(cffi:defcfun ("_wrap_btTranslationalLimitMotor_m_stopCFM_set" TRANSLATIONAL-LIMIT-MOTOR/M/STOP-CFM/SET) :void
  (self :pointer)
  (m_stopCFM :pointer))

(export 'TRANSLATIONAL-LIMIT-MOTOR/M/STOP-CFM/SET)

(declaim (inline TRANSLATIONAL-LIMIT-MOTOR/M/STOP-CFM/GET))

(cffi:defcfun ("_wrap_btTranslationalLimitMotor_m_stopCFM_get" TRANSLATIONAL-LIMIT-MOTOR/M/STOP-CFM/GET) :pointer
  (self :pointer))

(export 'TRANSLATIONAL-LIMIT-MOTOR/M/STOP-CFM/GET)

(declaim (inline TRANSLATIONAL-LIMIT-MOTOR/M/ENABLE-MOTOR/SET))

(cffi:defcfun ("_wrap_btTranslationalLimitMotor_m_enableMotor_set" TRANSLATIONAL-LIMIT-MOTOR/M/ENABLE-MOTOR/SET) :void
  (self :pointer)
  (m_enableMotor :pointer))

(export 'TRANSLATIONAL-LIMIT-MOTOR/M/ENABLE-MOTOR/SET)

(declaim (inline TRANSLATIONAL-LIMIT-MOTOR/M/ENABLE-MOTOR/GET))

(cffi:defcfun ("_wrap_btTranslationalLimitMotor_m_enableMotor_get" TRANSLATIONAL-LIMIT-MOTOR/M/ENABLE-MOTOR/GET) :pointer
  (self :pointer))

(export 'TRANSLATIONAL-LIMIT-MOTOR/M/ENABLE-MOTOR/GET)

(declaim (inline TRANSLATIONAL-LIMIT-MOTOR/M/TARGET-VELOCITY/SET))

(cffi:defcfun ("_wrap_btTranslationalLimitMotor_m_targetVelocity_set" TRANSLATIONAL-LIMIT-MOTOR/M/TARGET-VELOCITY/SET) :void
  (self :pointer)
  (m_targetVelocity :pointer))

(export 'TRANSLATIONAL-LIMIT-MOTOR/M/TARGET-VELOCITY/SET)

(declaim (inline TRANSLATIONAL-LIMIT-MOTOR/M/TARGET-VELOCITY/GET))

(cffi:defcfun ("_wrap_btTranslationalLimitMotor_m_targetVelocity_get" TRANSLATIONAL-LIMIT-MOTOR/M/TARGET-VELOCITY/GET) :pointer
  (self :pointer))

(export 'TRANSLATIONAL-LIMIT-MOTOR/M/TARGET-VELOCITY/GET)

(declaim (inline TRANSLATIONAL-LIMIT-MOTOR/M/MAX-MOTOR-FORCE/SET))

(cffi:defcfun ("_wrap_btTranslationalLimitMotor_m_maxMotorForce_set" TRANSLATIONAL-LIMIT-MOTOR/M/MAX-MOTOR-FORCE/SET) :void
  (self :pointer)
  (m_maxMotorForce :pointer))

(export 'TRANSLATIONAL-LIMIT-MOTOR/M/MAX-MOTOR-FORCE/SET)

(declaim (inline TRANSLATIONAL-LIMIT-MOTOR/M/MAX-MOTOR-FORCE/GET))

(cffi:defcfun ("_wrap_btTranslationalLimitMotor_m_maxMotorForce_get" TRANSLATIONAL-LIMIT-MOTOR/M/MAX-MOTOR-FORCE/GET) :pointer
  (self :pointer))

(export 'TRANSLATIONAL-LIMIT-MOTOR/M/MAX-MOTOR-FORCE/GET)

(declaim (inline TRANSLATIONAL-LIMIT-MOTOR/M/CURRENT-LIMIT-ERROR/SET))

(cffi:defcfun ("_wrap_btTranslationalLimitMotor_m_currentLimitError_set" TRANSLATIONAL-LIMIT-MOTOR/M/CURRENT-LIMIT-ERROR/SET) :void
  (self :pointer)
  (m_currentLimitError :pointer))

(export 'TRANSLATIONAL-LIMIT-MOTOR/M/CURRENT-LIMIT-ERROR/SET)

(declaim (inline TRANSLATIONAL-LIMIT-MOTOR/M/CURRENT-LIMIT-ERROR/GET))

(cffi:defcfun ("_wrap_btTranslationalLimitMotor_m_currentLimitError_get" TRANSLATIONAL-LIMIT-MOTOR/M/CURRENT-LIMIT-ERROR/GET) :pointer
  (self :pointer))

(export 'TRANSLATIONAL-LIMIT-MOTOR/M/CURRENT-LIMIT-ERROR/GET)

(declaim (inline TRANSLATIONAL-LIMIT-MOTOR/M/CURRENT-LINEAR-DIFF/SET))

(cffi:defcfun ("_wrap_btTranslationalLimitMotor_m_currentLinearDiff_set" TRANSLATIONAL-LIMIT-MOTOR/M/CURRENT-LINEAR-DIFF/SET) :void
  (self :pointer)
  (m_currentLinearDiff :pointer))

(export 'TRANSLATIONAL-LIMIT-MOTOR/M/CURRENT-LINEAR-DIFF/SET)

(declaim (inline TRANSLATIONAL-LIMIT-MOTOR/M/CURRENT-LINEAR-DIFF/GET))

(cffi:defcfun ("_wrap_btTranslationalLimitMotor_m_currentLinearDiff_get" TRANSLATIONAL-LIMIT-MOTOR/M/CURRENT-LINEAR-DIFF/GET) :pointer
  (self :pointer))

(export 'TRANSLATIONAL-LIMIT-MOTOR/M/CURRENT-LINEAR-DIFF/GET)

(declaim (inline TRANSLATIONAL-LIMIT-MOTOR/M/CURRENT-LIMIT/SET))

(cffi:defcfun ("_wrap_btTranslationalLimitMotor_m_currentLimit_set" TRANSLATIONAL-LIMIT-MOTOR/M/CURRENT-LIMIT/SET) :void
  (self :pointer)
  (m_currentLimit :pointer))

(export 'TRANSLATIONAL-LIMIT-MOTOR/M/CURRENT-LIMIT/SET)

(declaim (inline TRANSLATIONAL-LIMIT-MOTOR/M/CURRENT-LIMIT/GET))

(cffi:defcfun ("_wrap_btTranslationalLimitMotor_m_currentLimit_get" TRANSLATIONAL-LIMIT-MOTOR/M/CURRENT-LIMIT/GET) :pointer
  (self :pointer))

(export 'TRANSLATIONAL-LIMIT-MOTOR/M/CURRENT-LIMIT/GET)

(declaim (inline MAKE-TRANSLATIONAL-LIMIT-MOTOR))

(cffi:defcfun ("_wrap_new_btTranslationalLimitMotor__SWIG_0" MAKE-TRANSLATIONAL-LIMIT-MOTOR) :pointer)

(export 'MAKE-TRANSLATIONAL-LIMIT-MOTOR)

#+ (or)
(progn
  (declaim (inline MAKE-TRANSLATIONAL-LIMIT-MOTOR))

  (cffi:defcfun ("_wrap_new_btTranslationalLimitMotor__SWIG_1" MAKE-TRANSLATIONAL-LIMIT-MOTOR) :pointer
   (other :pointer))

  (export 'MAKE-TRANSLATIONAL-LIMIT-MOTOR))

(declaim (inline TRANSLATIONAL-LIMIT-MOTOR/IS-LIMITED))

(cffi:defcfun ("_wrap_btTranslationalLimitMotor_isLimited" TRANSLATIONAL-LIMIT-MOTOR/IS-LIMITED) :pointer
  (self :pointer)
  (limitIndex :int))

(export 'TRANSLATIONAL-LIMIT-MOTOR/IS-LIMITED)

(declaim (inline TRANSLATIONAL-LIMIT-MOTOR/NEED-APPLY-FORCE))

(cffi:defcfun ("_wrap_btTranslationalLimitMotor_needApplyForce" TRANSLATIONAL-LIMIT-MOTOR/NEED-APPLY-FORCE) :pointer
  (self :pointer)
  (limitIndex :int))

(export 'TRANSLATIONAL-LIMIT-MOTOR/NEED-APPLY-FORCE)

(declaim (inline TRANSLATIONAL-LIMIT-MOTOR/TEST-LIMIT-VALUE))

(cffi:defcfun ("_wrap_btTranslationalLimitMotor_testLimitValue" TRANSLATIONAL-LIMIT-MOTOR/TEST-LIMIT-VALUE) :int
  (self :pointer)
  (limitIndex :int)
  (test_value :float))

(export 'TRANSLATIONAL-LIMIT-MOTOR/TEST-LIMIT-VALUE)

(declaim (inline TRANSLATIONAL-LIMIT-MOTOR/SOLVE-LINEAR-AXIS))

(cffi:defcfun ("_wrap_btTranslationalLimitMotor_solveLinearAxis" TRANSLATIONAL-LIMIT-MOTOR/SOLVE-LINEAR-AXIS) :float
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

(export 'TRANSLATIONAL-LIMIT-MOTOR/SOLVE-LINEAR-AXIS)

(declaim (inline DELETE/BT-TRANSLATIONAL-LIMIT-MOTOR))

(cffi:defcfun ("_wrap_delete_btTranslationalLimitMotor" DELETE/BT-TRANSLATIONAL-LIMIT-MOTOR) :void
  (self :pointer))

(export '(lispify "delete_btTranslationalLimitMotor" 'function))

(cffi:defcenum 6-DOF-FLAGS
  (:6-DOF-FLAGS-CFM-NORM #.1)
  (:6-DOF-FLAGS-CFM-STOP #.2)
  (:6-DOF-FLAGS-ERP-STOP #.4))

(export '6-DOF-FLAGS)

(define-constant +6-DOF-FLAGS-AXIS-SHIFT+ 3)

(export '+6-DOF-FLAGS-AXIS-SHIFT+)

(declaim (inline GENERIC-6-DOF-CONSTRAINT/MAKE-CPLUS-PLUS-INSTANCE))

(cffi:defcfun ("_wrap_btGeneric6DofConstraint_makeCPlusPlusInstance__SWIG_0" GENERIC-6-DOF-CONSTRAINT/MAKE-CPLUS-PLUS-INSTANCE) :pointer
  (self :pointer)
  (sizeInBytes :pointer))

(export 'GENERIC-6-DOF-CONSTRAINT/MAKE-CPLUS-PLUS-INSTANCE)

(declaim (inline GENERIC-6-DOF-CONSTRAINT/DELETE-CPLUS-PLUS-INSTANCE))

(cffi:defcfun ("_wrap_btGeneric6DofConstraint_deleteCPlusPlusInstance__SWIG_0" GENERIC-6-DOF-CONSTRAINT/DELETE-CPLUS-PLUS-INSTANCE) :void
  (self :pointer)
  (ptr :pointer))

(export 'GENERIC-6-DOF-CONSTRAINT/DELETE-CPLUS-PLUS-INSTANCE)

#+ (or)
(progn
  (declaim (inline GENERIC-6-DOF-CONSTRAINT/MAKE-CPLUS-PLUS-INSTANCE))

  (cffi:defcfun ("_wrap_btGeneric6DofConstraint_makeCPlusPlusInstance__SWIG_1" GENERIC-6-DOF-CONSTRAINT/MAKE-CPLUS-PLUS-INSTANCE) :pointer
   (self :pointer)
   (arg1 :pointer)
   (ptr :pointer))

  (export 'GENERIC-6-DOF-CONSTRAINT/MAKE-CPLUS-PLUS-INSTANCE)

  (declaim (inline GENERIC-6-DOF-CONSTRAINT/DELETE-CPLUS-PLUS-INSTANCE))

  (cffi:defcfun ("_wrap_btGeneric6DofConstraint_deleteCPlusPlusInstance__SWIG_1" GENERIC-6-DOF-CONSTRAINT/DELETE-CPLUS-PLUS-INSTANCE) :void
   (self :pointer)
   (arg1 :pointer)
   (arg2 :pointer))

  (export 'GENERIC-6-DOF-CONSTRAINT/DELETE-CPLUS-PLUS-INSTANCE))

(declaim (inline (lispify "btGeneric6DofConstraint_makeCPlusArray" 'function)))

(cffi:defcfun ("_wrap_btGeneric6DofConstraint_makeCPlusArray__SWIG_0" GENERIC-6-DOF-CONSTRAINT/MAKE-CPLUS-ARRAY) :pointer
  (self :pointer)
  (sizeInBytes :pointer))

(export 'GENERIC-6-DOF-CONSTRAINT/MAKE-CPLUS-ARRAY)

(declaim (inline GENERIC-6-DOF-CONSTRAINT/DELETE-CPLUS-ARRAY))

(cffi:defcfun ("_wrap_btGeneric6DofConstraint_deleteCPlusArray__SWIG_0" GENERIC-6-DOF-CONSTRAINT/DELETE-CPLUS-ARRAY) :void
  (self :pointer)
  (ptr :pointer))

(export 'GENERIC-6-DOF-CONSTRAINT/DELETE-CPLUS-ARRAY)

#+ (or)
(progn
  (declaim (inline GENERIC-6-DOF-CONSTRAINT/MAKE-CPLUS-ARRAY))
  
  (cffi:defcfun ("_wrap_btGeneric6DofConstraint_makeCPlusArray__SWIG_1" GENERIC-6-DOF-CONSTRAINT/MAKE-CPLUS-ARRAY) :pointer
    (self :pointer)
    (arg1 :pointer)
    (ptr :pointer))
  
  (export 'GENERIC-6-DOF-CONSTRAINT/MAKE-CPLUS-ARRAY)
  
  (declaim (inline GENERIC-6-DOF-CONSTRAINT/DELETE-CPLUS-ARRAY))

  (cffi:defcfun ("_wrap_btGeneric6DofConstraint_deleteCPlusArray__SWIG_1" GENERIC-6-DOF-CONSTRAINT/DELETE-CPLUS-ARRAY) :void
   (self :pointer)
   (arg1 :pointer)
   (arg2 :pointer))

  (export 'GENERIC-6-DOF-CONSTRAINT/DELETE-CPLUS-ARRAY))

(declaim (inline GENERIC-6-DOF-CONSTRAINT/M/USE-SOLVE-CONSTRAINT-OBSOLETE/SET))

(cffi:defcfun ("_wrap_btGeneric6DofConstraint_m_useSolveConstraintObsolete_set" GENERIC-6-DOF-CONSTRAINT/M/USE-SOLVE-CONSTRAINT-OBSOLETE/SET) :void
  (self :pointer)
  (m_useSolveConstraintObsolete :pointer))

(export 'GENERIC-6-DOF-CONSTRAINT/M/USE-SOLVE-CONSTRAINT-OBSOLETE/SET)

(declaim (inline GENERIC-6-DOF-CONSTRAINT/M/USE-SOLVE-CONSTRAINT-OBSOLETE/GET))

(cffi:defcfun ("_wrap_btGeneric6DofConstraint_m_useSolveConstraintObsolete_get" GENERIC-6-DOF-CONSTRAINT/M/USE-SOLVE-CONSTRAINT-OBSOLETE/GET) :pointer
  (self :pointer))

(export 'GENERIC-6-DOF-CONSTRAINT/M/USE-SOLVE-CONSTRAINT-OBSOLETE/GET)

(declaim (inline MAKE-GENERIC-6-DOF-CONSTRAINT))

(cffi:defcfun ("_wrap_new_btGeneric6DofConstraint__SWIG_0" MAKE-GENERIC-6-DOF-CONSTRAINT) :pointer
  (rbA :pointer)
  (rbB :pointer)
  (frameInA :pointer)
  (frameInB :pointer)
  (useLinearReferenceFrameA :pointer))

(export 'MAKE-GENERIC-6-DOF-CONSTRAINT)

(declaim (inline MAKE-GENERIC-6-DOF-CONSTRAINT))

(cffi:defcfun ("_wrap_new_btGeneric6DofConstraint__SWIG_1" 
               MAKE-GENERIC-6-DOF-CONSTRAINT/with-linear-reference-frame-b) :pointer
  (rbB :pointer)
  (frameInB :pointer)
  (useLinearReferenceFrameB :pointer))

(export 'MAKE-GENERIC-6-DOF-CONSTRAINT)

(declaim (inline GENERIC-6-DOF-CONSTRAINT/CALCULATE-TRANSFORMS))

(cffi:defcfun ("_wrap_btGeneric6DofConstraint_calculateTransforms__SWIG_0" GENERIC-6-DOF-CONSTRAINT/CALCULATE-TRANSFORMS) :void
  (self :pointer)
  (transA :pointer)
  (transB :pointer))

(export 'GENERIC-6-DOF-CONSTRAINT/CALCULATE-TRANSFORMS)

(declaim (inline GENERIC-6-DOF-CONSTRAINT/CALCULATE-TRANSFORMS))

(cffi:defcfun ("_wrap_btGeneric6DofConstraint_calculateTransforms__SWIG_1" 
               GENERIC-6-DOF-CONSTRAINT/CALCULATE-TRANSFORMS/naked) :void
  (self :pointer))

(export 'GENERIC-6-DOF-CONSTRAINT/CALCULATE-TRANSFORMS)

(declaim (inline GENERIC-6-DOF-CONSTRAINT/GET-CALCULATED-TRANSFORM-A))

(cffi:defcfun ("_wrap_btGeneric6DofConstraint_getCalculatedTransformA" GENERIC-6-DOF-CONSTRAINT/GET-CALCULATED-TRANSFORM-A) :pointer
  (self :pointer))

(export 'GENERIC-6-DOF-CONSTRAINT/GET-CALCULATED-TRANSFORM-A)

(declaim (inline GENERIC-6-DOF-CONSTRAINT/GET-CALCULATED-TRANSFORM-B))

(cffi:defcfun ("_wrap_btGeneric6DofConstraint_getCalculatedTransformB" GENERIC-6-DOF-CONSTRAINT/GET-CALCULATED-TRANSFORM-B) :pointer
  (self :pointer))

(export 'GENERIC-6-DOF-CONSTRAINT/GET-CALCULATED-TRANSFORM-B)

(declaim (inline GENERIC-6-DOF-CONSTRAINT/GET-FRAME-OFFSET-A))

(cffi:defcfun ("_wrap_btGeneric6DofConstraint_getFrameOffsetA__SWIG_0" GENERIC-6-DOF-CONSTRAINT/GET-FRAME-OFFSET-A) :pointer
  (self :pointer))

(export 'GENERIC-6-DOF-CONSTRAINT/GET-FRAME-OFFSET-A)

(declaim (inline GENERIC-6-DOF-CONSTRAINT/GET-FRAME-OFFSET-B))

(cffi:defcfun ("_wrap_btGeneric6DofConstraint_getFrameOffsetB__SWIG_0" GENERIC-6-DOF-CONSTRAINT/GET-FRAME-OFFSET-B) :pointer
  (self :pointer))

(export 'GENERIC-6-DOF-CONSTRAINT/GET-FRAME-OFFSET-B)

#+ (or)
(progn
  (declaim (inline GENERIC-6-DOF-CONSTRAINT/GET-FRAME-OFFSET-A))

  (cffi:defcfun ("_wrap_btGeneric6DofConstraint_getFrameOffsetA__SWIG_1" GENERIC-6-DOF-CONSTRAINT/GET-FRAME-OFFSET-A) :pointer
   (self :pointer))

  (export 'GENERIC-6-DOF-CONSTRAINT/GET-FRAME-OFFSET-A)

  (declaim (inline GENERIC-6-DOF-CONSTRAINT/GET-FRAME-OFFSET-B))
  (cffi:defcfun ("_wrap_btGeneric6DofConstraint_getFrameOffsetB__SWIG_1" GENERIC-6-DOF-CONSTRAINT/GET-FRAME-OFFSET-B) :pointer
   (self :pointer))
  (export 'GENERIC-6-DOF-CONSTRAINT/GET-FRAME-OFFSET-B))
(declaim (inline GENERIC-6-DOF-CONSTRAINT/BUILD-JACOBIAN))

(cffi:defcfun ("_wrap_btGeneric6DofConstraint_buildJacobian" GENERIC-6-DOF-CONSTRAINT/BUILD-JACOBIAN) :void  (self :pointer))

(export 'GENERIC-6-DOF-CONSTRAINT/BUILD-JACOBIAN)
(declaim (inline GENERIC-6-DOF-CONSTRAINT/GET-INFO-1))
(cffi:defcfun ("_wrap_btGeneric6DofConstraint_getInfo1" GENERIC-6-DOF-CONSTRAINT/GET-INFO-1) :void
  (info :pointer))
(export 'GENERIC-6-DOF-CONSTRAINT/GET-INFO-1)
(declaim (inline GENERIC-6-DOF-CONSTRAINT/GET-INFO-1-NON-VIRTUAL))
(cffi:defcfun ("_wrap_btGeneric6DofConstraint_getInfo1NonVirtual" GENERIC-6-DOF-CONSTRAINT/GET-INFO-1-NON-VIRTUAL) :void
  (self :pointer)
  (info :pointer))

(export 'GENERIC-6-DOF-CONSTRAINT/GET-INFO-1-NON-VIRTUAL)

(declaim (inline GENERIC-6-DOF-CONSTRAINT/GET-INFO-2))

(cffi:defcfun ("_wrap_btGeneric6DofConstraint_getInfo2" GENERIC-6-DOF-CONSTRAINT/GET-INFO-2) :void
  (self :pointer)
  (info :pointer))

(export 'GENERIC-6-DOF-CONSTRAINT/GET-INFO-2)

(declaim (inline GENERIC-6-DOF-CONSTRAINT/GET-INFO-2-NON-VIRTUAL))

(cffi:defcfun ("_wrap_btGeneric6DofConstraint_getInfo2NonVirtual" GENERIC-6-DOF-CONSTRAINT/GET-INFO-2-NON-VIRTUAL) :void
  (self :pointer)
  (info :pointer)
  (transA :pointer)
  (transB :pointer)
  (linVelA :pointer)
  (linVelB :pointer)
  (angVelA :pointer)
  (angVelB :pointer))

(export '(lispify "btGeneric6DofConstraint_getInfo2NonVirtual" 'function))

(declaim (inline GENERIC-6-DOF-CONSTRAINT/UPDATE-RHS))

(cffi:defcfun ("_wrap_btGeneric6DofConstraint_updateRHS" GENERIC-6-DOF-CONSTRAINT/UPDATE-RHS) :void
  (self :pointer)
  (timeStep :float))

(export 'GENERIC-6-DOF-CONSTRAINT/UPDATE-RHS)

(declaim (inline GENERIC-6-DOF-CONSTRAINT/GET-AXIS))

(cffi:defcfun ("_wrap_btGeneric6DofConstraint_getAxis" GENERIC-6-DOF-CONSTRAINT/GET-AXIS) :pointer
  (self :pointer)
  (axis_index :int))

(export 'GENERIC-6-DOF-CONSTRAINT/GET-AXIS)

(declaim (inline GENERIC-6-DOF-CONSTRAINT/GET-ANGLE))

(cffi:defcfun ("_wrap_btGeneric6DofConstraint_getAngle" GENERIC-6-DOF-CONSTRAINT/GET-ANGLE) :float
  (self :pointer)
  (axis_index :int))

(export 'GENERIC-6-DOF-CONSTRAINT/GET-ANGLE)

(declaim (inline GENERIC-6-DOF-CONSTRAINT/GET-RELATIVE-PIVOT-POSITION))

(cffi:defcfun ("_wrap_btGeneric6DofConstraint_getRelativePivotPosition" GENERIC-6-DOF-CONSTRAINT/GET-RELATIVE-PIVOT-POSITION) :float
  (self :pointer)
  (axis_index :int))

(export 'GENERIC-6-DOF-CONSTRAINT/GET-RELATIVE-PIVOT-POSITION)

(declaim (inline GENERIC-6-DOF-CONSTRAINT/SET-FRAMES))

(cffi:defcfun ("_wrap_btGeneric6DofConstraint_setFrames" GENERIC-6-DOF-CONSTRAINT/SET-FRAMES) :void
  (self :pointer)
  (frameA :pointer)
  (frameB :pointer))

(export 'GENERIC-6-DOF-CONSTRAINT/SET-FRAMES)

(declaim (inline GENERIC-6-DOF-CONSTRAINT/TEST-ANGULAR-LIMIT-MOTOR))

(cffi:defcfun ("_wrap_btGeneric6DofConstraint_testAngularLimitMotor" GENERIC-6-DOF-CONSTRAINT/TEST-ANGULAR-LIMIT-MOTOR) :pointer
  (self :pointer)
  (axis_index :int))

(export 'GENERIC-6-DOF-CONSTRAINT/TEST-ANGULAR-LIMIT-MOTOR)

(declaim (inline GENERIC-6-DOF-CONSTRAINT/SET-LINEAR-LOWER-LIMIT))

(cffi:defcfun ("_wrap_btGeneric6DofConstraint_setLinearLowerLimit" (lispify "btGeneric6DofConstraint_setLinearLowerLimit" 'function)) :void
  (self :pointer)
  (linearLower :pointer))

(export 'GENERIC-6-DOF-CONSTRAINT/SET-LINEAR-LOWER-LIMIT)

(declaim (inline GENERIC-6-DOF-CONSTRAINT/GET-LINEAR-LOWER-LIMIT))

(cffi:defcfun ("_wrap_btGeneric6DofConstraint_getLinearLowerLimit" GENERIC-6-DOF-CONSTRAINT/GET-LINEAR-LOWER-LIMIT) :void
  (self :pointer)
  (linearLower :pointer))

(export 'GENERIC-6-DOF-CONSTRAINT/GET-LINEAR-LOWER-LIMIT)

(declaim (inline GENERIC-6-DOF-CONSTRAINT/SET-LINEAR-UPPER-LIMIT))

(cffi:defcfun ("_wrap_btGeneric6DofConstraint_setLinearUpperLimit" GENERIC-6-DOF-CONSTRAINT/SET-LINEAR-UPPER-LIMIT) :void
  (self :pointer)
  (linearUpper :pointer))

(export 'GENERIC-6-DOF-CONSTRAINT/SET-LINEAR-UPPER-LIMIT)

(declaim (inline GENERIC-6-DOF-CONSTRAINT/GET-LINEAR-UPPER-LIMIT))

(cffi:defcfun ("_wrap_btGeneric6DofConstraint_getLinearUpperLimit" GENERIC-6-DOF-CONSTRAINT/GET-LINEAR-UPPER-LIMIT) :void
  (self :pointer)
  (linearUpper :pointer))

(export 'GENERIC-6-DOF-CONSTRAINT/GET-LINEAR-UPPER-LIMIT)

(declaim (inline GENERIC-6-DOF-CONSTRAINT/SET-ANGULAR-LOWER-LIMIT))

(cffi:defcfun ("_wrap_btGeneric6DofConstraint_setAngularLowerLimit" GENERIC-6-DOF-CONSTRAINT/SET-ANGULAR-LOWER-LIMIT) :void
  (self :pointer)
  (angularLower :pointer))

(export 'GENERIC-6-DOF-CONSTRAINT/SET-ANGULAR-LOWER-LIMIT)

(declaim (inline GENERIC-6-DOF-CONSTRAINT/GET-ANGULAR-LOWER-LIMIT))

(cffi:defcfun ("_wrap_btGeneric6DofConstraint_getAngularLowerLimit" GENERIC-6-DOF-CONSTRAINT/GET-ANGULAR-LOWER-LIMIT) :void
  (self :pointer)
  (angularLower :pointer))

(export 'GENERIC-6-DOF-CONSTRAINT/GET-ANGULAR-LOWER-LIMIT)

(declaim (inline GENERIC-6-DOF-CONSTRAINT/SET-ANGULAR-UPPER-LIMIT))

(cffi:defcfun ("_wrap_btGeneric6DofConstraint_setAngularUpperLimit" GENERIC-6-DOF-CONSTRAINT/SET-ANGULAR-UPPER-LIMIT) :void
  (self :pointer)
  (angularUpper :pointer))

(export 'GENERIC-6-DOF-CONSTRAINT/SET-ANGULAR-UPPER-LIMIT)

(declaim (inline (lispify "btGeneric6DofConstraint_getAngularUpperLimit" 'function)))

(cffi:defcfun ("_wrap_btGeneric6DofConstraint_getAngularUpperLimit" GENERIC-6-DOF-CONSTRAINT/GET-ANGULAR-UPPER-LIMIT) :void
  (self :pointer)
  (angularUpper :pointer))

(export 'GENERIC-6-DOF-CONSTRAINT/GET-ANGULAR-UPPER-LIMIT)

(declaim (inline GENERIC-6-DOF-CONSTRAINT/GET-ROTATIONAL-LIMIT-MOTOR))

(cffi:defcfun ("_wrap_btGeneric6DofConstraint_getRotationalLimitMotor" GENERIC-6-DOF-CONSTRAINT/GET-ROTATIONAL-LIMIT-MOTOR) :pointer
  (self :pointer)
  (index :int))

(export 'GENERIC-6-DOF-CONSTRAINT/GET-ROTATIONAL-LIMIT-MOTOR)

(declaim (inline GENERIC-6-DOF-CONSTRAINT/GET-TRANSLATIONAL-LIMIT-MOTOR))

(cffi:defcfun ("_wrap_btGeneric6DofConstraint_getTranslationalLimitMotor" GENERIC-6-DOF-CONSTRAINT/GET-TRANSLATIONAL-LIMIT-MOTOR) :pointer  (self :pointer))
(export 'GENERIC-6-DOF-CONSTRAINT/GET-TRANSLATIONAL-LIMIT-MOTOR)
(declaim (inline GENERIC-6-DOF-CONSTRAINT/SET-LIMIT))
(cffi:defcfun ("_wrap_btGeneric6DofConstraint_setLimit" GENERIC-6-DOF-CONSTRAINT/SET-LIMIT) :void
  (self :pointer)
  (axis :int)
  (lo :float)
  (hi :float))

(export 'GENERIC-6-DOF-CONSTRAINT/SET-LIMIT)

(declaim (inline GENERIC-6-DOF-CONSTRAINT/IS-LIMITED))

(cffi:defcfun ("_wrap_btGeneric6DofConstraint_isLimited" GENERIC-6-DOF-CONSTRAINT/IS-LIMITED) :pointer
  (self :pointer)
  (limitIndex :int))

(export 'GENERIC-6-DOF-CONSTRAINT/IS-LIMITED)

(declaim (inline GENERIC-6-DOF-CONSTRAINT/CALC-ANCHOR-POS))

(cffi:defcfun ("_wrap_btGeneric6DofConstraint_calcAnchorPos" GENERIC-6-DOF-CONSTRAINT/CALC-ANCHOR-POS) :void  (self :pointer))
(export 'GENERIC-6-DOF-CONSTRAINT/CALC-ANCHOR-POS)
(declaim (inline GENERIC-6-DOF-CONSTRAINT/GET/LIMIT/MOTOR/INFO-2))
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

(export 'GENERIC-6-DOF-CONSTRAINT/GET/LIMIT/MOTOR/INFO-2)

(declaim (inline (lispify "btGeneric6DofConstraint_get_limit_motor_info2" 'function)))

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

(export 'GENERIC-6-DOF-CONSTRAINT/GET/LIMIT/MOTOR/INFO-2)

(declaim (inline GENERIC-6-DOF-CONSTRAINT/GET-USE-FRAME-OFFSET))

(cffi:defcfun ("_wrap_btGeneric6DofConstraint_getUseFrameOffset" GENERIC-6-DOF-CONSTRAINT/GET-USE-FRAME-OFFSET) :pointer  (self :pointer))
(export 'GENERIC-6-DOF-CONSTRAINT/GET-USE-FRAME-OFFSET)
(declaim (inline GENERIC-6-DOF-CONSTRAINT/SET-USE-FRAME-OFFSET))

(cffi:defcfun ("_wrap_btGeneric6DofConstraint_setUseFrameOffset" GENERIC-6-DOF-CONSTRAINT/SET-USE-FRAME-OFFSET) :void
  (self :pointer)
  (frameOffsetOnOff :pointer))

(export 'GENERIC-6-DOF-CONSTRAINT/SET-USE-FRAME-OFFSET)

(declaim (inline GENERIC-6-DOF-CONSTRAINT/SET-AXIS))

(cffi:defcfun ("_wrap_btGeneric6DofConstraint_setAxis" GENERIC-6-DOF-CONSTRAINT/SET-AXIS) :void
  (self :pointer)
  (axis1 :pointer)
  (axis2 :pointer))

(export 'GENERIC-6-DOF-CONSTRAINT/SET-AXIS)

(declaim (inline GENERIC-6-DOF-CONSTRAINT/CALCULATE-SERIALIZE-BUFFER-SIZE))

(cffi:defcfun ("_wrap_btGeneric6DofConstraint_calculateSerializeBufferSize" GENERIC-6-DOF-CONSTRAINT/CALCULATE-SERIALIZE-BUFFER-SIZE) :int
  (self :pointer))

(export 'GENERIC-6-DOF-CONSTRAINT/CALCULATE-SERIALIZE-BUFFER-SIZE)

(declaim (inline GENERIC-6-DOF-CONSTRAINT/SERIALIZE))

(cffi:defcfun ("_wrap_btGeneric6DofConstraint_serialize" GENERIC-6-DOF-CONSTRAINT/SERIALIZE) :string
  (self :pointer)
  (dataBuffer :pointer)
  (serializer :pointer))

(export 'GENERIC-6-DOF-CONSTRAINT/SERIALIZE)

(declaim (inline DELETE/BT-GENERIC-6-DOF-CONSTRAINT))

(cffi:defcfun ("_wrap_delete_btGeneric6DofConstraint" DELETE/BT-GENERIC-6-DOF-CONSTRAINT) :void
  (self :pointer))

(export 'DELETE/BT-GENERIC-6-DOF-CONSTRAINT)

(cffi:defcstruct GENERIC-6-DOF-CONSTRAINT-DATA
  (TYPE-CONSTRAINT-DATA (:POINTER (:STRUCT
                                                                          TYPED-CONSTRAINT-DATA)))
  (RB-AFRAME (:POINTER
                                                      (:STRUCT
                                                       TRANSFORM-FLOAT-DATA)))
  (RB-BFRAME (:POINTER
                                             (:STRUCT
                                              TRANSFORM-FLOAT-DATA)))
  (LINEAR-UPPER-LIMIT (:POINTER
                                                     (:STRUCT
                                                      vector-3-FLOAT-DATA)))
  (LINEAR-LOWER-LIMIT (:POINTER
                                                     (:STRUCT
                                                      vector-3-FLOAT-DATA)))
  (ANGULAR-UPPER-LIMIT (:POINTER
                                                      (:STRUCT
                                                       vector-3-FLOAT-DATA)))
  (ANGULAR-LOWER-LIMIT (:POINTER
                                                      (:STRUCT
                                                       vector-3-FLOAT-DATA)))
  (USE-LINEAR-REFERENCE-FRAME-A :int)
  (USE-OFFSET-FOR-CONSTRAINT-FRAME :int))

(export 'GENERIC-6-DOF-CONSTRAINT-DATA)

(export 'TYPE-CONSTRAINT-DATA)

(export 'RB-AFRAME)

(export 'RB-BFRAME)

(export 'LINEAR-UPPER-LIMIT)

(export 'LINEAR-LOWER-LIMIT)

(export 'ANGULAR-UPPER-LIMIT)

(export 'ANGULAR-LOWER-LIMIT)

(export 'USE-LINEAR-REFERENCE-FRAME-A)

(export 'USE-OFFSET-FOR-CONSTRAINT-FRAME)

(cffi:defcstruct GENERIC-6-DOF-CONSTRAINT-DOUBLE-DATA-2
  (TYPE-CONSTRAINT-DATA (:pointer (:struct TYPED-CONSTRAINT-DOUBLE-DATA)))
  (RB-AFRAME (:pointer (:struct TRANSFORM-DOUBLE-DATA)))
  (RB-BFRAME (:pointer (:struct TRANSFORM-DOUBLE-DATA)))
  (LINEAR-UPPER-LIMIT (:pointer (:struct vector-3-double-data)))
  (LINEAR-LOWER-LIMIT (:pointer (:struct vector-3-double-data)))
  (ANGULAR-UPPER-LIMIT (:pointer (:struct vector-3-double-data)))
  (ANGULAR-LOWER-LIMIT (:pointer (:struct vector-3-double-data)))
  (USE-LINEAR-REFERENCE-FRAME-A :int)
  (USE-OFFSET-FOR-CONSTRAINT-FRAME :int))

(export 'GENERIC-6-DOF-CONSTRAINT-DOUBLE-DATA-2)

(export 'TYPE-CONSTRAINT-DATA)

(export 'RB-AFRAME)

(export 'RB-BFRAME)

(export 'LINEAR-UPPER-LIMIT)

(export 'LINEAR-LOWER-LIMIT)

(export 'ANGULAR-UPPER-LIMIT)

(export 'ANGULAR-LOWER-LIMIT)

(export 'USE-LINEAR-REFERENCE-FRAME-A)

(export 'USE-OFFSET-FOR-CONSTRAINT-FRAME)

(define-constant +SLIDER-CONSTRAINT-DATA-NAME+ "btSliderConstraintData" :test 'equal)

(export '+SLIDER-CONSTRAINT-DATA-NAME+)

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

(export 'SLIDER-FLAGS)

(declaim (inline SLIDER-CONSTRAINT/MAKE-CPLUS-PLUS-INSTANCE))

(cffi:defcfun ("_wrap_btSliderConstraint_makeCPlusPlusInstance__SWIG_0" SLIDER-CONSTRAINT/MAKE-CPLUS-PLUS-INSTANCE) :pointer
  (self :pointer)
  (sizeInBytes :pointer))

(export 'SLIDER-CONSTRAINT/MAKE-CPLUS-PLUS-INSTANCE)

(declaim (inline SLIDER-CONSTRAINT/DELETE-CPLUS-PLUS-INSTANCE))

(cffi:defcfun ("_wrap_btSliderConstraint_deleteCPlusPlusInstance__SWIG_0" SLIDER-CONSTRAINT/DELETE-CPLUS-PLUS-INSTANCE) :void
  (self :pointer)
  (ptr :pointer))

(export 'SLIDER-CONSTRAINT/DELETE-CPLUS-PLUS-INSTANCE)

#+ (or)
(progn 
  (declaim (inline SLIDER-CONSTRAINT/MAKE-CPLUS-PLUS-INSTANCE))

  (cffi:defcfun ("_wrap_btSliderConstraint_makeCPlusPlusInstance__SWIG_1" SLIDER-CONSTRAINT/MAKE-CPLUS-PLUS-INSTANCE) :pointer
   (self :pointer)
   (arg1 :pointer)
   (ptr :pointer))

  (export 'SLIDER-CONSTRAINT/MAKE-CPLUS-PLUS-INSTANCE)

  (declaim (inline SLIDER-CONSTRAINT/DELETE-CPLUS-PLUS-INSTANCE))

  (cffi:defcfun ("_wrap_btSliderConstraint_deleteCPlusPlusInstance__SWIG_1" SLIDER-CONSTRAINT/DELETE-CPLUS-PLUS-INSTANCE) :void
   (self :pointer)
   (arg1 :pointer)
   (arg2 :pointer))

  (export 'SLIDER-CONSTRAINT/DELETE-CPLUS-PLUS-INSTANCE))

(declaim (inline SLIDER-CONSTRAINT/MAKE-CPLUS-ARRAY))

(cffi:defcfun ("_wrap_btSliderConstraint_makeCPlusArray__SWIG_0" SLIDER-CONSTRAINT/MAKE-CPLUS-ARRAY) :pointer
  (self :pointer)
  (sizeInBytes :pointer))

(export 'SLIDER-CONSTRAINT/MAKE-CPLUS-ARRAY)

(declaim (inline SLIDER-CONSTRAINT/DELETE-CPLUS-ARRAY))

(cffi:defcfun ("_wrap_btSliderConstraint_deleteCPlusArray__SWIG_0" SLIDER-CONSTRAINT/DELETE-CPLUS-ARRAY) :void
  (self :pointer)
  (ptr :pointer))

(export 'SLIDER-CONSTRAINT/DELETE-CPLUS-ARRAY)

#+ (or)
(progn
  (declaim (inline SLIDER-CONSTRAINT/MAKE-CPLUS-ARRAY))
  
  (cffi:defcfun ("_wrap_btSliderConstraint_makeCPlusArray__SWIG_1" SLIDER-CONSTRAINT/MAKE-CPLUS-ARRAY) :pointer
    (self :pointer)
    (arg1 :pointer)
    (ptr :pointer))
  
  (export 'SLIDER-CONSTRAINT/MAKE-CPLUS-ARRAY)
  (declaim (inline SLIDER-CONSTRAINT/DELETE-CPLUS-ARRAY))

  (cffi:defcfun ("_wrap_btSliderConstraint_deleteCPlusArray__SWIG_1" SLIDER-CONSTRAINT/DELETE-CPLUS-ARRAY) :void
   (self :pointer)
   (arg1 :pointer)
   (arg2 :pointer))

  (export 'SLIDER-CONSTRAINT/DELETE-CPLUS-ARRAY))

(declaim (inline MAKE-SLIDER-CONSTRAINT))

(cffi:defcfun ("_wrap_new_btSliderConstraint__SWIG_0" MAKE-SLIDER-CONSTRAINT) :pointer
  (rbA :pointer)
  (rbB :pointer)
  (frameInA :pointer)
  (frameInB :pointer)
  (useLinearReferenceFrameA :pointer))

(export 'MAKE-SLIDER-CONSTRAINT)

(declaim (inline MAKE-SLIDER-CONSTRAINT))

(cffi:defcfun ("_wrap_new_btSliderConstraint__SWIG_1" 
               make-slider-constraint/with-linear-reference-frame-a) :pointer
  (rbB :pointer)
  (frameInB :pointer)
  (useLinearReferenceFrameA :pointer))

(export 'MAKE-SLIDER-CONSTRAINT)

(declaim (inline SLIDER-CONSTRAINT/GET-INFO-1))

(cffi:defcfun ("_wrap_btSliderConstraint_getInfo1" SLIDER-CONSTRAINT/GET-INFO-1) :void
  (self :pointer)
  (info :pointer))

(export 'SLIDER-CONSTRAINT/GET-INFO-1)

(declaim (inline SLIDER-CONSTRAINT/GET-INFO-1-NON-VIRTUAL))

(cffi:defcfun ("_wrap_btSliderConstraint_getInfo1NonVirtual" SLIDER-CONSTRAINT/GET-INFO-1-NON-VIRTUAL) :void
  (self :pointer)
  (info :pointer))

(export 'SLIDER-CONSTRAINT/GET-INFO-1-NON-VIRTUAL)

(declaim (inline SLIDER-CONSTRAINT/GET-INFO-2))

(cffi:defcfun ("_wrap_btSliderConstraint_getInfo2" SLIDER-CONSTRAINT/GET-INFO-2) :void
  (self :pointer)
  (info :pointer))

(export 'SLIDER-CONSTRAINT/GET-INFO-2)

(declaim (inline SLIDER-CONSTRAINT/GET-INFO-2-NON-VIRTUAL))

(cffi:defcfun ("_wrap_btSliderConstraint_getInfo2NonVirtual" SLIDER-CONSTRAINT/GET-INFO-2-NON-VIRTUAL) :void
  (self :pointer)
  (info :pointer)
  (transA :pointer)
  (transB :pointer)
  (linVelA :pointer)
  (linVelB :pointer)
  (rbAinvMass :float)
  (rbBinvMass :float))

(export 'SLIDER-CONSTRAINT/GET-INFO-2-NON-VIRTUAL)

(declaim (inline SLIDER-CONSTRAINT/GET-RIGID-BODY-A))

(cffi:defcfun ("_wrap_btSliderConstraint_getRigidBodyA" SLIDER-CONSTRAINT/GET-RIGID-BODY-A) :pointer
  (self :pointer))

(export 'SLIDER-CONSTRAINT/GET-RIGID-BODY-A)

(declaim (inline SLIDER-CONSTRAINT/GET-RIGID-BODY-B))

(cffi:defcfun ("_wrap_btSliderConstraint_getRigidBodyB" SLIDER-CONSTRAINT/GET-RIGID-BODY-B) :pointer
  (self :pointer))

(export 'SLIDER-CONSTRAINT/GET-RIGID-BODY-B)

(declaim (inline SLIDER-CONSTRAINT/GET-CALCULATED-TRANSFORM-A))

(cffi:defcfun ("_wrap_btSliderConstraint_getCalculatedTransformA" SLIDER-CONSTRAINT/GET-CALCULATED-TRANSFORM-A) :pointer
  (self :pointer))

(export 'SLIDER-CONSTRAINT/GET-CALCULATED-TRANSFORM-A)

(declaim (inline SLIDER-CONSTRAINT/GET-CALCULATED-TRANSFORM-B))

(cffi:defcfun ("_wrap_btSliderConstraint_getCalculatedTransformB" SLIDER-CONSTRAINT/GET-CALCULATED-TRANSFORM-B) :pointer
  (self :pointer))

(export 'SLIDER-CONSTRAINT/GET-CALCULATED-TRANSFORM-B)

(declaim (inline SLIDER-CONSTRAINT/GET-FRAME-OFFSET-A))
(cffi:defcfun ("_wrap_btSliderConstraint_getFrameOffsetA__SWIG_0" SLIDER-CONSTRAINT/GET-FRAME-OFFSET-A) :pointer  (self :pointer))
(export 'SLIDER-CONSTRAINT/GET-FRAME-OFFSET-A)
(declaim (inline SLIDER-CONSTRAINT/GET-FRAME-OFFSET-B))
(cffi:defcfun ("_wrap_btSliderConstraint_getFrameOffsetB__SWIG_0" SLIDER-CONSTRAINT/GET-FRAME-OFFSET-B) :pointer  (self :pointer))
(export 'SLIDER-CONSTRAINT/GET-FRAME-OFFSET-B)
#+ (or)
(progn
  (declaim (inline SLIDER-CONSTRAINT/GET-FRAME-OFFSET-A))
  (cffi:defcfun ("_wrap_btSliderConstraint_getFrameOffsetA__SWIG_1" SLIDER-CONSTRAINT/GET-FRAME-OFFSET-A) :pointer
    (self :pointer))
  (export 'SLIDER-CONSTRAINT/GET-FRAME-OFFSET-A)
  (declaim (inline SLIDER-CONSTRAINT/GET-FRAME-OFFSET-B)) 
  (cffi:defcfun ("_wrap_btSliderConstraint_getFrameOffsetB__SWIG_1" SLIDER-CONSTRAINT/GET-FRAME-OFFSET-B) :pointer  (self :pointer))
  (export 'SLIDER-CONSTRAINT/GET-FRAME-OFFSET-B))
(declaim (inline SLIDER-CONSTRAINT/GET-LOWER-LIN-LIMIT))
(cffi:defcfun ("_wrap_btSliderConstraint_getLowerLinLimit" SLIDER-CONSTRAINT/GET-LOWER-LIN-LIMIT) :float  (self :pointer))
(export 'SLIDER-CONSTRAINT/GET-LOWER-LIN-LIMIT)
(declaim (inline SLIDER-CONSTRAINT/SET-LOWER-LIN-LIMIT))
(cffi:defcfun ("_wrap_btSliderConstraint_setLowerLinLimit" SLIDER-CONSTRAINT/SET-LOWER-LIN-LIMIT) :void
  (lowerLimit :float))
(export 'SLIDER-CONSTRAINT/SET-LOWER-LIN-LIMIT)
(declaim (inline SLIDER-CONSTRAINT/GET-UPPER-LIN-LIMIT))
(cffi:defcfun ("_wrap_btSliderConstraint_getUpperLinLimit" SLIDER-CONSTRAINT/GET-UPPER-LIN-LIMIT) :float  (self :pointer))
(export 'SLIDER-CONSTRAINT/GET-UPPER-LIN-LIMIT)
(declaim (inline SLIDER-CONSTRAINT/SET-UPPER-LIN-LIMIT))
(cffi:defcfun ("_wrap_btSliderConstraint_setUpperLinLimit" SLIDER-CONSTRAINT/SET-UPPER-LIN-LIMIT) :void
  (self :pointer)
  (upperLimit :float))

(export 'SLIDER-CONSTRAINT/SET-UPPER-LIN-LIMIT)

(declaim (inline SLIDER-CONSTRAINT/GET-LOWER-ANG-LIMIT))

(cffi:defcfun ("_wrap_btSliderConstraint_getLowerAngLimit" SLIDER-CONSTRAINT/GET-LOWER-ANG-LIMIT) :float  (self :pointer))
(export 'SLIDER-CONSTRAINT/GET-LOWER-ANG-LIMIT)
(declaim (inline SLIDER-CONSTRAINT/SET-LOWER-ANG-LIMIT))
(cffi:defcfun ("_wrap_btSliderConstraint_setLowerAngLimit" SLIDER-CONSTRAINT/SET-LOWER-ANG-LIMIT) :void
  (lowerLimit :float))
(export 'SLIDER-CONSTRAINT/SET-LOWER-ANG-LIMIT)
(declaim (inline SLIDER-CONSTRAINT/GET-UPPER-ANG-LIMIT))
(cffi:defcfun ("_wrap_btSliderConstraint_getUpperAngLimit" SLIDER-CONSTRAINT/GET-UPPER-ANG-LIMIT) :float  (self :pointer))
(export 'SLIDER-CONSTRAINT/GET-UPPER-ANG-LIMIT)
(declaim (inline SLIDER-CONSTRAINT/SET-UPPER-ANG-LIMIT))
(cffi:defcfun ("_wrap_btSliderConstraint_setUpperAngLimit" SLIDER-CONSTRAINT/SET-UPPER-ANG-LIMIT) :void
  (upperLimit :float))
(export 'SLIDER-CONSTRAINT/SET-UPPER-ANG-LIMIT)
(declaim (inline SLIDER-CONSTRAINT/GET-USE-LINEAR-REFERENCE-FRAME-A))
(cffi:defcfun ("_wrap_btSliderConstraint_getUseLinearReferenceFrameA" SLIDER-CONSTRAINT/GET-USE-LINEAR-REFERENCE-FRAME-A) :pointer
  (self :pointer))
(export 'SLIDER-CONSTRAINT/GET-USE-LINEAR-REFERENCE-FRAME-A)
(declaim (inline SLIDER-CONSTRAINT/GET-SOFTNESS-DIR-LIN))
(cffi:defcfun ("_wrap_btSliderConstraint_getSoftnessDirLin" SLIDER-CONSTRAINT/GET-SOFTNESS-DIR-LIN) :float
  (self :pointer))
(export 'SLIDER-CONSTRAINT/GET-SOFTNESS-DIR-LIN)
(declaim (inline SLIDER-CONSTRAINT/GET-RESTITUTION-DIR-LIN))
(cffi:defcfun ("_wrap_btSliderConstraint_getRestitutionDirLin" SLIDER-CONSTRAINT/GET-RESTITUTION-DIR-LIN) :float
  (self :pointer))
(export 'SLIDER-CONSTRAINT/GET-RESTITUTION-DIR-LIN)
(declaim (inline SLIDER-CONSTRAINT/GET-DAMPING-DIR-LIN))
(cffi:defcfun ("_wrap_btSliderConstraint_getDampingDirLin" SLIDER-CONSTRAINT/GET-DAMPING-DIR-LIN) :float
  (self :pointer))
(export 'SLIDER-CONSTRAINT/GET-DAMPING-DIR-LIN)
(declaim (inline SLIDER-CONSTRAINT/GET-SOFTNESS-DIR-ANG))
(cffi:defcfun ("_wrap_btSliderConstraint_getSoftnessDirAng" SLIDER-CONSTRAINT/GET-SOFTNESS-DIR-ANG) :float
  (self :pointer))
(export 'SLIDER-CONSTRAINT/GET-SOFTNESS-DIR-ANG)
(declaim (inline SLIDER-CONSTRAINT/GET-RESTITUTION-DIR-ANG))
(cffi:defcfun ("_wrap_btSliderConstraint_getRestitutionDirAng" SLIDER-CONSTRAINT/GET-RESTITUTION-DIR-ANG) :float
  (self :pointer))
(export 'SLIDER-CONSTRAINT/GET-RESTITUTION-DIR-ANG)
(declaim (inline SLIDER-CONSTRAINT/GET-DAMPING-DIR-ANG))
(cffi:defcfun ("_wrap_btSliderConstraint_getDampingDirAng" SLIDER-CONSTRAINT/GET-DAMPING-DIR-ANG) :float
  (self :pointer))
(export 'SLIDER-CONSTRAINT/GET-DAMPING-DIR-ANG)
(declaim (inline SLIDER-CONSTRAINT/GET-SOFTNESS-LIM-LIN))
(cffi:defcfun ("_wrap_btSliderConstraint_getSoftnessLimLin" SLIDER-CONSTRAINT/GET-SOFTNESS-LIM-LIN) :float
  (self :pointer))
(export 'SLIDER-CONSTRAINT/GET-SOFTNESS-LIM-LIN)
(declaim (inline SLIDER-CONSTRAINT/GET-RESTITUTION-LIM-LIN))
(cffi:defcfun ("_wrap_btSliderConstraint_getRestitutionLimLin" SLIDER-CONSTRAINT/GET-RESTITUTION-LIM-LIN) :float
  (self :pointer))
(export 'SLIDER-CONSTRAINT/GET-RESTITUTION-LIM-LIN)
(declaim (inline SLIDER-CONSTRAINT/GET-DAMPING-LIM-LIN))
(cffi:defcfun ("_wrap_btSliderConstraint_getDampingLimLin" SLIDER-CONSTRAINT/GET-DAMPING-LIM-LIN) :float
  (self :pointer))
(export 'SLIDER-CONSTRAINT/GET-DAMPING-LIM-LIN)
(declaim (inline SLIDER-CONSTRAINT/GET-SOFTNESS-LIM-ANG))
(cffi:defcfun ("_wrap_btSliderConstraint_getSoftnessLimAng" SLIDER-CONSTRAINT/GET-SOFTNESS-LIM-ANG) :float
  (self :pointer))
(export 'SLIDER-CONSTRAINT/GET-SOFTNESS-LIM-ANG)
(declaim (inline SLIDER-CONSTRAINT/GET-RESTITUTION-LIM-ANG))
(cffi:defcfun ("_wrap_btSliderConstraint_getRestitutionLimAng" SLIDER-CONSTRAINT/GET-RESTITUTION-LIM-ANG) :float  (self :pointer))
(export 'SLIDER-CONSTRAINT/GET-RESTITUTION-LIM-ANG)
(declaim (inline SLIDER-CONSTRAINT/GET-DAMPING-LIM-ANG))
(cffi:defcfun ("_wrap_btSliderConstraint_getDampingLimAng" SLIDER-CONSTRAINT/GET-DAMPING-LIM-ANG) :float  (self :pointer))
(export 'SLIDER-CONSTRAINT/GET-DAMPING-LIM-ANG)
(declaim (inline SLIDER-CONSTRAINT/GET-SOFTNESS-ORTHO-LIN))
(cffi:defcfun ("_wrap_btSliderConstraint_getSoftnessOrthoLin" SLIDER-CONSTRAINT/GET-SOFTNESS-ORTHO-LIN) :float
  (self :pointer))
(export 'SLIDER-CONSTRAINT/GET-SOFTNESS-ORTHO-LIN)
(declaim (inline SLIDER-CONSTRAINT/GET-RESTITUTION-ORTHO-LIN))
(cffi:defcfun ("_wrap_btSliderConstraint_getRestitutionOrthoLin" SLIDER-CONSTRAINT/GET-RESTITUTION-ORTHO-LIN) :float
(self :pointer))
(export 'SLIDER-CONSTRAINT/GET-RESTITUTION-ORTHO-LIN)
(declaim (inline SLIDER-CONSTRAINT/GET-DAMPING-ORTHO-LIN))
(cffi:defcfun ("_wrap_btSliderConstraint_getDampingOrthoLin" SLIDER-CONSTRAINT/GET-DAMPING-ORTHO-LIN) :float
  (self :pointer))
(export 'SLIDER-CONSTRAINT/GET-DAMPING-ORTHO-LIN)
(declaim (inline SLIDER-CONSTRAINT/GET-SOFTNESS-ORTHO-ANG))
(cffi:defcfun ("_wrap_btSliderConstraint_getSoftnessOrthoAng" SLIDER-CONSTRAINT/GET-SOFTNESS-ORTHO-ANG) :float  (self :pointer))
(export 'SLIDER-CONSTRAINT/GET-SOFTNESS-ORTHO-ANG)
(declaim (inline SLIDER-CONSTRAINT/GET-RESTITUTION-ORTHO-ANG))
(cffi:defcfun ("_wrap_btSliderConstraint_getRestitutionOrthoAng" SLIDER-CONSTRAINT/GET-RESTITUTION-ORTHO-ANG) :float  (self :pointer))
(export 'SLIDER-CONSTRAINT/GET-RESTITUTION-ORTHO-ANG)
(declaim (inline SLIDER-CONSTRAINT/GET-DAMPING-ORTHO-ANG))
(cffi:defcfun ("_wrap_btSliderConstraint_getDampingOrthoAng" SLIDER-CONSTRAINT/GET-DAMPING-ORTHO-ANG) :float
  (self :pointer))
(export 'SLIDER-CONSTRAINT/GET-DAMPING-ORTHO-ANG)
(declaim (inline SLIDER-CONSTRAINT/SET-SOFTNESS-DIR-LIN))
(cffi:defcfun ("_wrap_btSliderConstraint_setSoftnessDirLin" SLIDER-CONSTRAINT/SET-SOFTNESS-DIR-LIN) :void
  (softnessDirLin :float))
(export 'SLIDER-CONSTRAINT/SET-SOFTNESS-DIR-LIN)
(declaim (inline SLIDER-CONSTRAINT/SET-RESTITUTION-DIR-LIN))
(cffi:defcfun ("_wrap_btSliderConstraint_setRestitutionDirLin" SLIDER-CONSTRAINT/SET-RESTITUTION-DIR-LIN) :void
  (self :pointer)
  (restitutionDirLin :float))
(export 'SLIDER-CONSTRAINT/SET-RESTITUTION-DIR-LIN)
(declaim (inline SLIDER-CONSTRAINT/SET-DAMPING-DIR-LIN))
(cffi:defcfun ("_wrap_btSliderConstraint_setDampingDirLin" SLIDER-CONSTRAINT/SET-DAMPING-DIR-LIN) :void
  (self :pointer)
  (dampingDirLin :float))
(export 'SLIDER-CONSTRAINT/SET-DAMPING-DIR-LIN)
(declaim (inline SLIDER-CONSTRAINT/SET-SOFTNESS-DIR-ANG))
(cffi:defcfun ("_wrap_btSliderConstraint_setSoftnessDirAng" SLIDER-CONSTRAINT/SET-SOFTNESS-DIR-ANG) :void
  (self :pointer)
  (softnessDirAng :float))
(export 'SLIDER-CONSTRAINT/SET-SOFTNESS-DIR-ANG)
(declaim (inline SLIDER-CONSTRAINT/SET-RESTITUTION-DIR-ANG))
(cffi:defcfun ("_wrap_btSliderConstraint_setRestitutionDirAng" SLIDER-CONSTRAINT/SET-RESTITUTION-DIR-ANG) :void
  (self :pointer)
  (restitutionDirAng :float))
(export 'SLIDER-CONSTRAINT/SET-RESTITUTION-DIR-ANG)
(declaim (inline SLIDER-CONSTRAINT/SET-DAMPING-DIR-ANG))
(cffi:defcfun ("_wrap_btSliderConstraint_setDampingDirAng" SLIDER-CONSTRAINT/SET-DAMPING-DIR-ANG) :void
  (self :pointer)
  (dampingDirAng :float))
(export 'SLIDER-CONSTRAINT/SET-DAMPING-DIR-ANG)
(declaim (inline SLIDER-CONSTRAINT/SET-SOFTNESS-LIM-LIN))
(cffi:defcfun ("_wrap_btSliderConstraint_setSoftnessLimLin" SLIDER-CONSTRAINT/SET-SOFTNESS-LIM-LIN) :void
  (self :pointer)
  (softnessLimLin :float))
(export 'SLIDER-CONSTRAINT/SET-SOFTNESS-LIM-LIN)
(declaim (inline SLIDER-CONSTRAINT/SET-RESTITUTION-LIM-LIN))
(cffi:defcfun ("_wrap_btSliderConstraint_setRestitutionLimLin" SLIDER-CONSTRAINT/SET-RESTITUTION-LIM-LIN) :void
  (self :pointer)
  (restitutionLimLin :float))
(export 'SLIDER-CONSTRAINT/SET-RESTITUTION-LIM-LIN)
(declaim (inline SLIDER-CONSTRAINT/SET-DAMPING-LIM-LIN))
(cffi:defcfun ("_wrap_btSliderConstraint_setDampingLimLin" SLIDER-CONSTRAINT/SET-DAMPING-LIM-LIN) :void
  (dampingLimLin :float))
(export 'SLIDER-CONSTRAINT/SET-DAMPING-LIM-LIN)
(declaim (inline SLIDER-CONSTRAINT/SET-SOFTNESS-LIM-ANG))
(cffi:defcfun ("_wrap_btSliderConstraint_setSoftnessLimAng" SLIDER-CONSTRAINT/SET-SOFTNESS-LIM-ANG) :void
  (softnessLimAng :float))
(export 'SLIDER-CONSTRAINT/SET-SOFTNESS-LIM-ANG)
(declaim (inline SLIDER-CONSTRAINT/SET-RESTITUTION-LIM-ANG))
(cffi:defcfun ("_wrap_btSliderConstraint_setRestitutionLimAng" SLIDER-CONSTRAINT/SET-RESTITUTION-LIM-ANG) :void
  (restitutionLimAng :float))
(export 'SLIDER-CONSTRAINT/SET-RESTITUTION-LIM-ANG)
(declaim (inline SLIDER-CONSTRAINT/SET-DAMPING-LIM-ANG))
(cffi:defcfun ("_wrap_btSliderConstraint_setDampingLimAng" SLIDER-CONSTRAINT/SET-DAMPING-LIM-ANG) :void
  (self :pointer)
  (dampingLimAng :float))
(export 'SLIDER-CONSTRAINT/SET-DAMPING-LIM-ANG)
(declaim (inline SLIDER-CONSTRAINT/SET-SOFTNESS-ORTHO-LIN))
(cffi:defcfun ("_wrap_btSliderConstraint_setSoftnessOrthoLin" SLIDER-CONSTRAINT/SET-SOFTNESS-ORTHO-LIN) :void
  (softnessOrthoLin :float))
(export 'SLIDER-CONSTRAINT/SET-SOFTNESS-ORTHO-LIN)
(declaim (inline SLIDER-CONSTRAINT/SET-RESTITUTION-ORTHO-LIN))
(cffi:defcfun ("_wrap_btSliderConstraint_setRestitutionOrthoLin" SLIDER-CONSTRAINT/SET-RESTITUTION-ORTHO-LIN) :void
  (self :pointer)
  (restitutionOrthoLin :float))
(export 'SLIDER-CONSTRAINT/SET-RESTITUTION-ORTHO-LIN)
(declaim (inline SLIDER-CONSTRAINT/SET-DAMPING-ORTHO-LIN))
(cffi:defcfun ("_wrap_btSliderConstraint_setDampingOrthoLin" SLIDER-CONSTRAINT/SET-DAMPING-ORTHO-LIN) :void
  (self :pointer)
  (dampingOrthoLin :float))
(export 'SLIDER-CONSTRAINT/SET-DAMPING-ORTHO-LIN)
(declaim (inline SLIDER-CONSTRAINT/SET-SOFTNESS-ORTHO-ANG))
(cffi:defcfun ("_wrap_btSliderConstraint_setSoftnessOrthoAng" SLIDER-CONSTRAINT/SET-SOFTNESS-ORTHO-ANG) :void
  (self :pointer)
  (softnessOrthoAng :float))
(export 'SLIDER-CONSTRAINT/SET-SOFTNESS-ORTHO-ANG)
(declaim (inline SLIDER-CONSTRAINT/SET-RESTITUTION-ORTHO-ANG))
(cffi:defcfun ("_wrap_btSliderConstraint_setRestitutionOrthoAng" SLIDER-CONSTRAINT/SET-RESTITUTION-ORTHO-ANG) :void
  (self :pointer)
  (restitutionOrthoAng :float))
(export 'SLIDER-CONSTRAINT/SET-RESTITUTION-ORTHO-ANG)
(declaim (inline SLIDER-CONSTRAINT/SET-DAMPING-ORTHO-ANG))
(cffi:defcfun ("_wrap_btSliderConstraint_setDampingOrthoAng" SLIDER-CONSTRAINT/SET-DAMPING-ORTHO-ANG) :void
  (self :pointer)
  (dampingOrthoAng :float))
(export 'SLIDER-CONSTRAINT/SET-DAMPING-ORTHO-ANG)
(declaim (inline SLIDER-CONSTRAINT/SET-POWERED-LIN-MOTOR))
(cffi:defcfun ("_wrap_btSliderConstraint_setPoweredLinMotor" SLIDER-CONSTRAINT/SET-POWERED-LIN-MOTOR) :void
  (self :pointer)
  (onOff :pointer))
(export 'SLIDER-CONSTRAINT/SET-POWERED-LIN-MOTOR)
(declaim (inline SLIDER-CONSTRAINT/GET-POWERED-LIN-MOTOR))
(cffi:defcfun ("_wrap_btSliderConstraint_getPoweredLinMotor" SLIDER-CONSTRAINT/GET-POWERED-LIN-MOTOR) :pointer  (self :pointer))
(export 'SLIDER-CONSTRAINT/GET-POWERED-LIN-MOTOR)
(declaim (inline SLIDER-CONSTRAINT/SET-TARGET-LIN-MOTOR-VELOCITY))
(cffi:defcfun ("_wrap_btSliderConstraint_setTargetLinMotorVelocity" SLIDER-CONSTRAINT/SET-TARGET-LIN-MOTOR-VELOCITY) :void
  (targetLinMotorVelocity :float))
(export 'SLIDER-CONSTRAINT/SET-TARGET-LIN-MOTOR-VELOCITY)
(declaim (inline SLIDER-CONSTRAINT/GET-TARGET-LIN-MOTOR-VELOCITY))
(cffi:defcfun ("_wrap_btSliderConstraint_getTargetLinMotorVelocity" SLIDER-CONSTRAINT/GET-TARGET-LIN-MOTOR-VELOCITY) :float  (self :pointer))
(export 'SLIDER-CONSTRAINT/GET-TARGET-LIN-MOTOR-VELOCITY)
(declaim (inline SLIDER-CONSTRAINT/SET-MAX-LIN-MOTOR-FORCE))
(cffi:defcfun ("_wrap_btSliderConstraint_setMaxLinMotorForce" SLIDER-CONSTRAINT/SET-MAX-LIN-MOTOR-FORCE) :void
  (self :pointer)
  (maxLinMotorForce :float))
(export 'SLIDER-CONSTRAINT/SET-MAX-LIN-MOTOR-FORCE)
(declaim (inline SLIDER-CONSTRAINT/GET-MAX-LIN-MOTOR-FORCE))
(cffi:defcfun ("_wrap_btSliderConstraint_getMaxLinMotorForce" SLIDER-CONSTRAINT/GET-MAX-LIN-MOTOR-FORCE) :float  (self :pointer))
(export 'SLIDER-CONSTRAINT/GET-MAX-LIN-MOTOR-FORCE)
(declaim (inline SLIDER-CONSTRAINT/SET-POWERED-ANG-MOTOR))
(cffi:defcfun ("_wrap_btSliderConstraint_setPoweredAngMotor" SLIDER-CONSTRAINT/SET-POWERED-ANG-MOTOR) :void
  (onOff :pointer))
(export 'SLIDER-CONSTRAINT/SET-POWERED-ANG-MOTOR)
(declaim (inline SLIDER-CONSTRAINT/GET-POWERED-ANG-MOTOR))
(cffi:defcfun ("_wrap_btSliderConstraint_getPoweredAngMotor" SLIDER-CONSTRAINT/GET-POWERED-ANG-MOTOR) :pointer  (self :pointer))
(export 'SLIDER-CONSTRAINT/GET-POWERED-ANG-MOTOR)
(declaim (inline SLIDER-CONSTRAINT/SET-TARGET-ANG-MOTOR-VELOCITY))
(cffi:defcfun ("_wrap_btSliderConstraint_setTargetAngMotorVelocity" SLIDER-CONSTRAINT/SET-TARGET-ANG-MOTOR-VELOCITY) :void
  (targetAngMotorVelocity :float))
(export 'SLIDER-CONSTRAINT/SET-TARGET-ANG-MOTOR-VELOCITY)
(declaim (inline SLIDER-CONSTRAINT/GET-TARGET-ANG-MOTOR-VELOCITY))
(cffi:defcfun ("_wrap_btSliderConstraint_getTargetAngMotorVelocity" SLIDER-CONSTRAINT/GET-TARGET-ANG-MOTOR-VELOCITY) :float
  (self :pointer))

(export 'SLIDER-CONSTRAINT/GET-TARGET-ANG-MOTOR-VELOCITY)

(declaim (inline SLIDER-CONSTRAINT/SET-MAX-ANG-MOTOR-FORCE))

(cffi:defcfun ("_wrap_btSliderConstraint_setMaxAngMotorForce" SLIDER-CONSTRAINT/SET-MAX-ANG-MOTOR-FORCE) :void
  (maxAngMotorForce :float))
(export 'SLIDER-CONSTRAINT/SET-MAX-ANG-MOTOR-FORCE)
(declaim (inline SLIDER-CONSTRAINT/GET-MAX-ANG-MOTOR-FORCE))
(cffi:defcfun ("_wrap_btSliderConstraint_getMaxAngMotorForce" SLIDER-CONSTRAINT/GET-MAX-ANG-MOTOR-FORCE) :float  (self :pointer))
(export 'SLIDER-CONSTRAINT/GET-MAX-ANG-MOTOR-FORCE)
(declaim (inline SLIDER-CONSTRAINT/GET-LINEAR-POS))
(cffi:defcfun ("_wrap_btSliderConstraint_getLinearPos" SLIDER-CONSTRAINT/GET-LINEAR-POS) :float
  (self :pointer))
(export 'SLIDER-CONSTRAINT/GET-LINEAR-POS)
(declaim (inline SLIDER-CONSTRAINT/GET-ANGULAR-POS))
(cffi:defcfun ("_wrap_btSliderConstraint_getAngularPos" SLIDER-CONSTRAINT/GET-ANGULAR-POS) :float
  (self :pointer))
(export 'SLIDER-CONSTRAINT/GET-ANGULAR-POS)
(declaim (inline SLIDER-CONSTRAINT/GET-SOLVE-LIN-LIMIT))
(cffi:defcfun ("_wrap_btSliderConstraint_getSolveLinLimit" SLIDER-CONSTRAINT/GET-SOLVE-LIN-LIMIT) :pointer  (self :pointer))
(export 'SLIDER-CONSTRAINT/GET-SOLVE-LIN-LIMIT)
(declaim (inline SLIDER-CONSTRAINT/GET-LIN-DEPTH))
(cffi:defcfun ("_wrap_btSliderConstraint_getLinDepth" SLIDER-CONSTRAINT/GET-LIN-DEPTH) :float  (self :pointer))
(export 'SLIDER-CONSTRAINT/GET-LIN-DEPTH)
(declaim (inline SLIDER-CONSTRAINT/GET-SOLVE-ANG-LIMIT))
(cffi:defcfun ("_wrap_btSliderConstraint_getSolveAngLimit" SLIDER-CONSTRAINT/GET-SOLVE-ANG-LIMIT) :pointer
  (self :pointer))
(export 'SLIDER-CONSTRAINT/GET-SOLVE-ANG-LIMIT)
(declaim (inline SLIDER-CONSTRAINT/GET-ANG-DEPTH))
(cffi:defcfun ("_wrap_btSliderConstraint_getAngDepth" SLIDER-CONSTRAINT/GET-ANG-DEPTH) :float  (self :pointer))
(export 'SLIDER-CONSTRAINT/GET-ANG-DEPTH)
(declaim (inline SLIDER-CONSTRAINT/CALCULATE-TRANSFORMS))
(cffi:defcfun ("_wrap_btSliderConstraint_calculateTransforms" SLIDER-CONSTRAINT/CALCULATE-TRANSFORMS) :void
  (transA :pointer)
  (transB :pointer))
(export 'SLIDER-CONSTRAINT/CALCULATE-TRANSFORMS)
(declaim (inline SLIDER-CONSTRAINT/TEST-LIN-LIMITS))
(cffi:defcfun ("_wrap_btSliderConstraint_testLinLimits" SLIDER-CONSTRAINT/TEST-LIN-LIMITS) :void  (self :pointer))
(export 'SLIDER-CONSTRAINT/TEST-LIN-LIMITS)
(declaim (inline SLIDER-CONSTRAINT/TEST-ANG-LIMITS))
(cffi:defcfun ("_wrap_btSliderConstraint_testAngLimits" SLIDER-CONSTRAINT/TEST-ANG-LIMITS) :void
  (self :pointer))
(export 'SLIDER-CONSTRAINT/TEST-ANG-LIMITS)
(declaim (inline SLIDER-CONSTRAINT/GET-ANCOR-IN-A))
(cffi:defcfun ("_wrap_btSliderConstraint_getAncorInA" SLIDER-CONSTRAINT/GET-ANCOR-IN-A) :pointer  (self :pointer))
(export 'SLIDER-CONSTRAINT/GET-ANCOR-IN-A)
(declaim (inline SLIDER-CONSTRAINT/GET-ANCOR-IN-B))
(cffi:defcfun ("_wrap_btSliderConstraint_getAncorInB" SLIDER-CONSTRAINT/GET-ANCOR-IN-B) :pointer  (self :pointer))
(export 'SLIDER-CONSTRAINT/GET-ANCOR-IN-B)
(declaim (inline SLIDER-CONSTRAINT/GET-USE-FRAME-OFFSET))
(cffi:defcfun ("_wrap_btSliderConstraint_getUseFrameOffset" SLIDER-CONSTRAINT/GET-USE-FRAME-OFFSET) :pointer  (self :pointer))
(export 'SLIDER-CONSTRAINT/GET-USE-FRAME-OFFSET)
(declaim (inline SLIDER-CONSTRAINT/SET-USE-FRAME-OFFSET))
(cffi:defcfun ("_wrap_btSliderConstraint_setUseFrameOffset" SLIDER-CONSTRAINT/SET-USE-FRAME-OFFSET) :void
  (self :pointer)
  (frameOffsetOnOff :pointer))
(export 'SLIDER-CONSTRAINT/SET-USE-FRAME-OFFSET)
(declaim (inline SLIDER-CONSTRAINT/SET-FRAMES))
(cffi:defcfun ("_wrap_btSliderConstraint_setFrames" SLIDER-CONSTRAINT/SET-FRAMES) :void
  (frameA :pointer)
  (frameB :pointer))
(export 'SLIDER-CONSTRAINT/SET-FRAMES)

(declaim (inline SLIDER-CONSTRAINT/CALCULATE-SERIALIZE-BUFFER-SIZE))
(cffi:defcfun ("_wrap_btSliderConstraint_calculateSerializeBufferSize" SLIDER-CONSTRAINT/CALCULATE-SERIALIZE-BUFFER-SIZE) :int  (self :pointer))
(export 'SLIDER-CONSTRAINT/CALCULATE-SERIALIZE-BUFFER-SIZE)
(declaim (inline SLIDER-CONSTRAINT/SERIALIZE))
(cffi:defcfun ("_wrap_btSliderConstraint_serialize" SLIDER-CONSTRAINT/SERIALIZE) :string
  (dataBuffer :pointer)
  (serializer :pointer))
(export 'SLIDER-CONSTRAINT/SERIALIZE)
(declaim (inline DELETE/BT-SLIDER-CONSTRAINT))
(cffi:defcfun ("_wrap_delete_btSliderConstraint" DELETE/BT-SLIDER-CONSTRAINT) :void
  (self :pointer))
(export 'DELETE/BT-SLIDER-CONSTRAINT)
(cffi:defcstruct SLIDER-CONSTRAINT-DATA
  (TYPE-CONSTRAINT-DATA (:pointer (:struct TYPED-CONSTRAINT-DATA)))
  (RB-AFRAME (:pointer (:struct TRANSFORM-FLOAT-DATA)))
  (RB-BFRAME (:pointer (:struct TRANSFORM-FLOAT-DATA)))
  (LINEAR-UPPER-LIMIT :float)
  (LINEAR-LOWER-LIMIT :float)
  (ANGULAR-UPPER-LIMIT :float)
  (ANGULAR-LOWER-LIMIT :float)
  (USE-LINEAR-REFERENCE-FRAME-A :int)
  (USE-OFFSET-FOR-CONSTRAINT-FRAME :int))
(export 'SLIDER-CONSTRAINT-DATA)
(export 'TYPE-CONSTRAINT-DATA)
(export 'RB-AFRAME)
(export 'RB-BFRAME)
(export 'LINEAR-UPPER-LIMIT)
(export 'LINEAR-LOWER-LIMIT)
(export 'ANGULAR-UPPER-LIMIT)
(export 'ANGULAR-LOWER-LIMIT)
(export 'USE-LINEAR-REFERENCE-FRAME-A)
(export 'USE-OFFSET-FOR-CONSTRAINT-FRAME)
(cffi:defcstruct SLIDER-CONSTRAINT-DOUBLE-DATA
  (TYPE-CONSTRAINT-DATA (:pointer (:struct #. (lispify "btTypedConstraintDoubleData" 'classname))))
  (RB-AFRAME (:pointer (:struct transform-double-data)))
  (RB-BFRAME (:pointer (:struct transform-double-data)))
  (LINEAR-UPPER-LIMIT :double)
  (LINEAR-LOWER-LIMIT :double)
  (ANGULAR-UPPER-LIMIT :double)
  (ANGULAR-LOWER-LIMIT :double)
  (USE-LINEAR-REFERENCE-FRAME-A :int)
  (USE-OFFSET-FOR-CONSTRAINT-FRAME :int))
(export 'SLIDER-CONSTRAINT-DOUBLE-DATA)
(export 'TYPE-CONSTRAINT-DATA)
(export 'RB-AFRAME)
(export 'RB-BFRAME)
(export 'LINEAR-UPPER-LIMIT)
(export 'LINEAR-LOWER-LIMIT)
(export 'ANGULAR-UPPER-LIMIT)
(export 'ANGULAR-LOWER-LIMIT)
(export 'USE-LINEAR-REFERENCE-FRAME-A)
(export 'USE-OFFSET-FOR-CONSTRAINT-FRAME)
(define-constant +GENERIC-6-DOF-SPRING-CONSTRAINT-DATA-NAME+ "btGeneric6DofSpringConstraintData" :test 'equal)
(export '+GENERIC-6-DOF-SPRING-CONSTRAINT-DATA-NAME+)
(declaim (inline GENERIC-6-DOF-SPRING-CONSTRAINT/MAKE-CPLUS-PLUS-INSTANCE))
(cffi:defcfun ("_wrap_btGeneric6DofSpringConstraint_makeCPlusPlusInstance__SWIG_0" GENERIC-6-DOF-SPRING-CONSTRAINT/MAKE-CPLUS-PLUS-INSTANCE) :pointer
  (sizeInBytes :pointer))
(export 'GENERIC-6-DOF-SPRING-CONSTRAINT/MAKE-CPLUS-PLUS-INSTANCE)
(declaim (inline GENERIC-6-DOF-SPRING-CONSTRAINT/DELETE-CPLUS-PLUS-INSTANCE))
(cffi:defcfun ("_wrap_btGeneric6DofSpringConstraint_deleteCPlusPlusInstance__SWIG_0" GENERIC-6-DOF-SPRING-CONSTRAINT/DELETE-CPLUS-PLUS-INSTANCE) :void
  (self :pointer)
  (ptr :pointer))
(export 'GENERIC-6-DOF-SPRING-CONSTRAINT/DELETE-CPLUS-PLUS-INSTANCE)
#+ (or)
(progn 
  (declaim (inline GENERIC-6-DOF-SPRING-CONSTRAINT/MAKE-CPLUS-PLUS-INSTANCE))
  (cffi:defcfun ("_wrap_btGeneric6DofSpringConstraint_makeCPlusPlusInstance__SWIG_1" GENERIC-6-DOF-SPRING-CONSTRAINT/MAKE-CPLUS-PLUS-INSTANCE) :pointer
          (arg1 :pointer)
          (ptr :pointer))
  (export 'GENERIC-6-DOF-SPRING-CONSTRAINT/MAKE-CPLUS-PLUS-INSTANCE)
  (declaim (inline GENERIC-6-DOF-SPRING-CONSTRAINT/DELETE-CPLUS-PLUS-INSTANCE))
  (cffi:defcfun ("_wrap_btGeneric6DofSpringConstraint_deleteCPlusPlusInstance__SWIG_1" GENERIC-6-DOF-SPRING-CONSTRAINT/DELETE-CPLUS-PLUS-INSTANCE) :void
          (self :pointer)
          (arg1 :pointer)
          (arg2 :pointer))
  (export 'GENERIC-6-DOF-SPRING-CONSTRAINT/DELETE-CPLUS-PLUS-INSTANCE))
(declaim (inline GENERIC-6-DOF-SPRING-CONSTRAINT/MAKE-CPLUS-ARRAY))
(cffi:defcfun ("_wrap_btGeneric6DofSpringConstraint_makeCPlusArray__SWIG_0" GENERIC-6-DOF-SPRING-CONSTRAINT/MAKE-CPLUS-ARRAY) :pointer
  (sizeInBytes :pointer))
(export 'GENERIC-6-DOF-SPRING-CONSTRAINT/MAKE-CPLUS-ARRAY)
(declaim (inline GENERIC-6-DOF-SPRING-CONSTRAINT/DELETE-CPLUS-ARRAY))
(cffi:defcfun ("_wrap_btGeneric6DofSpringConstraint_deleteCPlusArray__SWIG_0" GENERIC-6-DOF-SPRING-CONSTRAINT/DELETE-CPLUS-ARRAY) :void
  (self :pointer)
  (ptr :pointer))
(export 'GENERIC-6-DOF-SPRING-CONSTRAINT/DELETE-CPLUS-ARRAY)
#+ (or)
(progn
  (declaim (inline GENERIC-6-DOF-SPRING-CONSTRAINT/MAKE-CPLUS-ARRAY))
  (cffi:defcfun ("_wrap_btGeneric6DofSpringConstraint_makeCPlusArray__SWIG_1" GENERIC-6-DOF-SPRING-CONSTRAINT/MAKE-CPLUS-ARRAY) :pointer
          (self :pointer)
          (arg1 :pointer)
          (ptr :pointer))
  (export 'GENERIC-6-DOF-SPRING-CONSTRAINT/MAKE-CPLUS-ARRAY)
  (declaim (inline GENERIC-6-DOF-SPRING-CONSTRAINT/DELETE-CPLUS-ARRAY))
  (cffi:defcfun ("_wrap_btGeneric6DofSpringConstraint_deleteCPlusArray__SWIG_1" GENERIC-6-DOF-SPRING-CONSTRAINT/DELETE-CPLUS-ARRAY) :void
          (arg1 :pointer)
          (arg2 :pointer))
  (export 'GENERIC-6-DOF-SPRING-CONSTRAINT/DELETE-CPLUS-ARRAY))
(declaim (inline MAKE-GENERIC-6-DOF-SPRING-CONSTRAINT))
(cffi:defcfun ("_wrap_new_btGeneric6DofSpringConstraint__SWIG_0" MAKE-GENERIC-6-DOF-SPRING-CONSTRAINT) :pointer
  (rbA :pointer)
  (rbB :pointer)
  (frameInA :pointer)
  (frameInB :pointer)
  (useLinearReferenceFrameA :pointer))
(export 'MAKE-GENERIC-6-DOF-SPRING-CONSTRAINT)
(declaim (inline MAKE-GENERIC-6-DOF-SPRING-CONSTRAINT))
(cffi:defcfun ("_wrap_new_btGeneric6DofSpringConstraint__SWIG_1" 
               MAKE-GENERIC-6-DOF-SPRING-CONSTRAINT/with-rb-b&frame-in-b/using-linear-reference-frame-b)
    :pointer
  (rbB :pointer)
  (frameInB :pointer)
  (useLinearReferenceFrameB :pointer))
(export 'MAKE-GENERIC-6-DOF-SPRING-CONSTRAINT)
(declaim (inline GENERIC-6-DOF-SPRING-CONSTRAINT/ENABLE-SPRING))
(cffi:defcfun ("_wrap_btGeneric6DofSpringConstraint_enableSpring" GENERIC-6-DOF-SPRING-CONSTRAINT/ENABLE-SPRING) :void
  (index :int)
  (onOff :pointer))
(export 'GENERIC-6-DOF-SPRING-CONSTRAINT/ENABLE-SPRING)
(declaim (inline GENERIC-6-DOF-SPRING-CONSTRAINT/SET-STIFFNESS))
(cffi:defcfun ("_wrap_btGeneric6DofSpringConstraint_setStiffness" GENERIC-6-DOF-SPRING-CONSTRAINT/SET-STIFFNESS) :void
  (index :int)
  (stiffness :float))
(export 'GENERIC-6-DOF-SPRING-CONSTRAINT/SET-STIFFNESS)
(declaim (inline GENERIC-6-DOF-SPRING-CONSTRAINT/SET-DAMPING))
(cffi:defcfun ("_wrap_btGeneric6DofSpringConstraint_setDamping" GENERIC-6-DOF-SPRING-CONSTRAINT/SET-DAMPING) :void
  (self :pointer)
  (index :int)
  (damping :float))
(export 'GENERIC-6-DOF-SPRING-CONSTRAINT/SET-DAMPING)
(declaim (inline GENERIC-6-DOF-SPRING-CONSTRAINT/SET-EQUILIBRIUM-POINT))
(cffi:defcfun ("_wrap_btGeneric6DofSpringConstraint_setEquilibriumPoint__SWIG_0" 
               GENERIC-6-DOF-SPRING-CONSTRAINT/SET-EQUILIBRIUM-POINT) :void
  (self :pointer))
(export 'GENERIC-6-DOF-SPRING-CONSTRAINT/SET-EQUILIBRIUM-POINT)
(declaim (inline GENERIC-6-DOF-SPRING-CONSTRAINT/SET-EQUILIBRIUM-POINT))
(cffi:defcfun ("_wrap_btGeneric6DofSpringConstraint_setEquilibriumPoint__SWIG_1" 
               GENERIC-6-DOF-SPRING-CONSTRAINT/SET-EQUILIBRIUM-POINT/int-index) :void
  (self :pointer)
  (index :int))
(export 'GENERIC-6-DOF-SPRING-CONSTRAINT/SET-EQUILIBRIUM-POINT)
(declaim (inline GENERIC-6-DOF-SPRING-CONSTRAINT/SET-EQUILIBRIUM-POINT))
(cffi:defcfun ("_wrap_btGeneric6DofSpringConstraint_setEquilibriumPoint__SWIG_2"
               GENERIC-6-DOF-SPRING-CONSTRAINT/SET-EQUILIBRIUM-POINT/float-val) :void
  (index :int)
  (val :float))
(export 'GENERIC-6-DOF-SPRING-CONSTRAINT/SET-EQUILIBRIUM-POINT)
(declaim (inline GENERIC-6-DOF-SPRING-CONSTRAINT/SET-AXIS))
(cffi:defcfun ("_wrap_btGeneric6DofSpringConstraint_setAxis" GENERIC-6-DOF-SPRING-CONSTRAINT/SET-AXIS) :void
  (axis1 :pointer)
  (axis2 :pointer))
(export 'GENERIC-6-DOF-SPRING-CONSTRAINT/SET-AXIS)
(declaim (inline GENERIC-6-DOF-SPRING-CONSTRAINT/GET-INFO-2))
(cffi:defcfun ("_wrap_btGeneric6DofSpringConstraint_getInfo2" GENERIC-6-DOF-SPRING-CONSTRAINT/GET-INFO-2) :void
  (self :pointer)
  (info :pointer))
(export 'GENERIC-6-DOF-SPRING-CONSTRAINT/GET-INFO-2)
(declaim (inline GENERIC-6-DOF-SPRING-CONSTRAINT/CALCULATE-SERIALIZE-BUFFER-SIZE))
(cffi:defcfun ("_wrap_btGeneric6DofSpringConstraint_calculateSerializeBufferSize" GENERIC-6-DOF-SPRING-CONSTRAINT/CALCULATE-SERIALIZE-BUFFER-SIZE) :int
  (self :pointer))
(export 'GENERIC-6-DOF-SPRING-CONSTRAINT/CALCULATE-SERIALIZE-BUFFER-SIZE)
(declaim (inline GENERIC-6-DOF-SPRING-CONSTRAINT/SERIALIZE))
(cffi:defcfun ("_wrap_btGeneric6DofSpringConstraint_serialize" GENERIC-6-DOF-SPRING-CONSTRAINT/SERIALIZE) :string
  (self :pointer)
  (dataBuffer :pointer)
  (serializer :pointer))
(export 'GENERIC-6-DOF-SPRING-CONSTRAINT/SERIALIZE)
(declaim (inline DELETE/BT-GENERIC-6-DOF-SPRING-CONSTRAINT))
(cffi:defcfun ("_wrap_delete_btGeneric6DofSpringConstraint" DELETE/BT-GENERIC-6-DOF-SPRING-CONSTRAINT) :void
  (self :pointer))
(export 'DELETE/BT-GENERIC-6-DOF-SPRING-CONSTRAINT)
(cffi:defcstruct GENERIC-6-DOF-SPRING-CONSTRAINT-DATA
  (6DOF-DATA (:pointer (:struct GENERIC-6-DOF-CONSTRAINT-DATA)))
  (SPRING-ENABLED :pointer)
  (EQUILIBRIUM-POINT :pointer)
  (SPRING-STIFFNESS :pointer)
  (SPRING-DAMPING :pointer))
(export 'GENERIC-6-DOF-SPRING-CONSTRAINT-DATA)
(export '6DOF-DATA)
(export 'SPRING-ENABLED)
(export 'EQUILIBRIUM-POINT)
(export 'SPRING-STIFFNESS)
(export 'SPRING-DAMPING)
(cffi:defcstruct GENERIC-6-DOF-SPRING-CONSTRAINT-DOUBLE-DATA-2
  (6DOF-DATA
                    (:pointer (:struct #. (lispify "btGeneric6DofConstraintDoubleData2" 'classname))))
  (SPRING-ENABLED :pointer)
  (EQUILIBRIUM-POINT :pointer)
  (SPRING-STIFFNESS :pointer)
  (SPRING-DAMPING :pointer))
(export 'GENERIC-6-DOF-SPRING-CONSTRAINT-DOUBLE-DATA-2)
(export '6DOF-DATA)
(export 'SPRING-ENABLED)
(export 'EQUILIBRIUM-POINT)
(export 'SPRING-STIFFNESS)
(export 'SPRING-DAMPING)
(declaim (inline UNIVERSAL-CONSTRAINT/MAKE-CPLUS-PLUS-INSTANCE))
(cffi:defcfun ("_wrap_btUniversalConstraint_makeCPlusPlusInstance__SWIG_0" UNIVERSAL-CONSTRAINT/MAKE-CPLUS-PLUS-INSTANCE) :pointer
  (self :pointer)
  (sizeInBytes :pointer))
(export 'UNIVERSAL-CONSTRAINT/MAKE-CPLUS-PLUS-INSTANCE)
(declaim (inline UNIVERSAL-CONSTRAINT/DELETE-CPLUS-PLUS-INSTANCE))
(cffi:defcfun ("_wrap_btUniversalConstraint_deleteCPlusPlusInstance__SWIG_0" UNIVERSAL-CONSTRAINT/DELETE-CPLUS-PLUS-INSTANCE) :void
  (self :pointer)
  (ptr :pointer))
(export 'UNIVERSAL-CONSTRAINT/DELETE-CPLUS-PLUS-INSTANCE)
#+ (or)
(progn 
  (declaim (inline UNIVERSAL-CONSTRAINT/MAKE-CPLUS-PLUS-INSTANCE))
  (cffi:defcfun ("_wrap_btUniversalConstraint_makeCPlusPlusInstance__SWIG_1" UNIVERSAL-CONSTRAINT/MAKE-CPLUS-PLUS-INSTANCE) :pointer
   (self :pointer)
   (arg1 :pointer)
   (ptr :pointer))
  (export 'UNIVERSAL-CONSTRAINT/MAKE-CPLUS-PLUS-INSTANCE)
  (declaim (inline UNIVERSAL-CONSTRAINT/DELETE-CPLUS-PLUS-INSTANCE))
  (cffi:defcfun ("_wrap_btUniversalConstraint_deleteCPlusPlusInstance__SWIG_1" UNIVERSAL-CONSTRAINT/DELETE-CPLUS-PLUS-INSTANCE) :void
   (self :pointer)
   (arg1 :pointer)
   (arg2 :pointer))
  (export 'UNIVERSAL-CONSTRAINT/DELETE-CPLUS-PLUS-INSTANCE))
(declaim (inline UNIVERSAL-CONSTRAINT/MAKE-CPLUS-ARRAY))
(cffi:defcfun ("_wrap_btUniversalConstraint_makeCPlusArray__SWIG_0" UNIVERSAL-CONSTRAINT/MAKE-CPLUS-ARRAY) :pointer
  (self :pointer)
  (sizeInBytes :pointer))
(export 'UNIVERSAL-CONSTRAINT/MAKE-CPLUS-ARRAY)
(declaim (inline UNIVERSAL-CONSTRAINT/DELETE-CPLUS-ARRAY))
(cffi:defcfun ("_wrap_btUniversalConstraint_deleteCPlusArray__SWIG_0" UNIVERSAL-CONSTRAINT/DELETE-CPLUS-ARRAY) :void
  (self :pointer)
  (ptr :pointer))
(export 'UNIVERSAL-CONSTRAINT/DELETE-CPLUS-ARRAY)
#+ (or)
(progn 
  (declaim (inline UNIVERSAL-CONSTRAINT/MAKE-CPLUS-ARRAY))
  (cffi:defcfun ("_wrap_btUniversalConstraint_makeCPlusArray__SWIG_1" UNIVERSAL-CONSTRAINT/MAKE-CPLUS-ARRAY) :pointer
          (self :pointer)
          (arg1 :pointer)
          (ptr :pointer))
  (export 'UNIVERSAL-CONSTRAINT/MAKE-CPLUS-ARRAY)
  (declaim (inline UNIVERSAL-CONSTRAINT/DELETE-CPLUS-ARRAY))
  (cffi:defcfun ("_wrap_btUniversalConstraint_deleteCPlusArray__SWIG_1" UNIVERSAL-CONSTRAINT/DELETE-CPLUS-ARRAY) :void
          (self :pointer)
          (arg1 :pointer)
          (arg2 :pointer))
  (export 'UNIVERSAL-CONSTRAINT/DELETE-CPLUS-ARRAY))
(declaim (inline MAKE-UNIVERSAL-CONSTRAINT))
(cffi:defcfun ("_wrap_new_btUniversalConstraint" MAKE-UNIVERSAL-CONSTRAINT) :pointer
  (rbA :pointer)
  (rbB :pointer)
  (anchor :pointer)
  (axis1 :pointer)
  (axis2 :pointer))
(export 'MAKE-UNIVERSAL-CONSTRAINT)
(declaim (inline UNIVERSAL-CONSTRAINT/GET-ANCHOR))
(cffi:defcfun ("_wrap_btUniversalConstraint_getAnchor" UNIVERSAL-CONSTRAINT/GET-ANCHOR) :pointer
  (self :pointer))
(export 'UNIVERSAL-CONSTRAINT/GET-ANCHOR)
(declaim (inline UNIVERSAL-CONSTRAINT/GET-ANCHOR-2))
(cffi:defcfun ("_wrap_btUniversalConstraint_getAnchor2" UNIVERSAL-CONSTRAINT/GET-ANCHOR-2) :pointer
  (self :pointer))
(export 'UNIVERSAL-CONSTRAINT/GET-ANCHOR-2)
(declaim (inline UNIVERSAL-CONSTRAINT/GET-AXIS-1))
(cffi:defcfun ("_wrap_btUniversalConstraint_getAxis1" UNIVERSAL-CONSTRAINT/GET-AXIS-1) :pointer
  (self :pointer))
(export 'UNIVERSAL-CONSTRAINT/GET-AXIS-1)
(declaim (inline UNIVERSAL-CONSTRAINT/GET-AXIS-2))
(cffi:defcfun ("_wrap_btUniversalConstraint_getAxis2" UNIVERSAL-CONSTRAINT/GET-AXIS-2) :pointer
  (self :pointer))
(export 'UNIVERSAL-CONSTRAINT/GET-AXIS-2)
(declaim (inline UNIVERSAL-CONSTRAINT/GET-ANGLE-1))
(cffi:defcfun ("_wrap_btUniversalConstraint_getAngle1" UNIVERSAL-CONSTRAINT/GET-ANGLE-1) :float
  (self :pointer))
(export 'UNIVERSAL-CONSTRAINT/GET-ANGLE-1)
(declaim (inline UNIVERSAL-CONSTRAINT/GET-ANGLE-2))

(cffi:defcfun ("_wrap_btUniversalConstraint_getAngle2" UNIVERSAL-CONSTRAINT/GET-ANGLE-2) :float  (self :pointer))
(export 'UNIVERSAL-CONSTRAINT/GET-ANGLE-2)
(declaim (inline UNIVERSAL-CONSTRAINT/SET-UPPER-LIMIT))
(cffi:defcfun ("_wrap_btUniversalConstraint_setUpperLimit" UNIVERSAL-CONSTRAINT/SET-UPPER-LIMIT) :void
  (ang1max :float)
  (ang2max :float))
(export 'UNIVERSAL-CONSTRAINT/SET-UPPER-LIMIT)
(declaim (inline UNIVERSAL-CONSTRAINT/SET-LOWER-LIMIT))
(cffi:defcfun ("_wrap_btUniversalConstraint_setLowerLimit" UNIVERSAL-CONSTRAINT/SET-LOWER-LIMIT) :void
  (ang1min :float)
  (ang2min :float))
(export 'UNIVERSAL-CONSTRAINT/SET-LOWER-LIMIT)
(declaim (inline UNIVERSAL-CONSTRAINT/SET-AXIS))
(cffi:defcfun ("_wrap_btUniversalConstraint_setAxis" UNIVERSAL-CONSTRAINT/SET-AXIS) :void
  (axis1 :pointer)
  (axis2 :pointer))
(export 'UNIVERSAL-CONSTRAINT/SET-AXIS)
(declaim (inline DELETE/BT-UNIVERSAL-CONSTRAINT))
(cffi:defcfun ("_wrap_delete_btUniversalConstraint" DELETE/BT-UNIVERSAL-CONSTRAINT) :void  (self :pointer))
(export 'DELETE/BT-UNIVERSAL-CONSTRAINT)
(declaim (inline HINGE-2-CONSTRAINT/MAKE-CPLUS-PLUS-INSTANCE))
(cffi:defcfun ("_wrap_btHinge2Constraint_makeCPlusPlusInstance__SWIG_0" HINGE-2-CONSTRAINT/MAKE-CPLUS-PLUS-INSTANCE) :pointer
  (sizeInBytes :pointer))
(export 'HINGE-2-CONSTRAINT/MAKE-CPLUS-PLUS-INSTANCE)
(declaim (inline HINGE-2-CONSTRAINT/DELETE-CPLUS-PLUS-INSTANCE))
(cffi:defcfun ("_wrap_btHinge2Constraint_deleteCPlusPlusInstance__SWIG_0" HINGE-2-CONSTRAINT/DELETE-CPLUS-PLUS-INSTANCE) :void
  (ptr :pointer))
(export 'HINGE-2-CONSTRAINT/DELETE-CPLUS-PLUS-INSTANCE)
#+ (or)
(progn 
  (declaim (inline HINGE-2-CONSTRAINT/MAKE-CPLUS-PLUS-INSTANCE))
  (cffi:defcfun ("_wrap_btHinge2Constraint_makeCPlusPlusInstance__SWIG_1" HINGE-2-CONSTRAINT/MAKE-CPLUS-PLUS-INSTANCE) :pointer
          (arg1 :pointer)
          (ptr :pointer))
  (export 'HINGE-2-CONSTRAINT/MAKE-CPLUS-PLUS-INSTANCE))
#+ (or)
(progn
  (declaim (inline HINGE-2-CONSTRAINT/DELETE-CPLUS-PLUS-INSTANCE))
  (cffi:defcfun ("_wrap_btHinge2Constraint_deleteCPlusPlusInstance__SWIG_1" HINGE-2-CONSTRAINT/DELETE-CPLUS-PLUS-INSTANCE) :void
          (arg1 :pointer)
          (arg2 :pointer))
  (export 'HINGE-2-CONSTRAINT/DELETE-CPLUS-PLUS-INSTANCE))
(declaim (inline HINGE-2-CONSTRAINT/MAKE-CPLUS-ARRAY))
(cffi:defcfun ("_wrap_btHinge2Constraint_makeCPlusArray__SWIG_0" HINGE-2-CONSTRAINT/MAKE-CPLUS-ARRAY) :pointer
  (sizeInBytes :pointer))
(export 'HINGE-2-CONSTRAINT/MAKE-CPLUS-ARRAY)
(declaim (inline HINGE-2-CONSTRAINT/DELETE-CPLUS-ARRAY))
(cffi:defcfun ("_wrap_btHinge2Constraint_deleteCPlusArray__SWIG_0" HINGE-2-CONSTRAINT/DELETE-CPLUS-ARRAY) :void
  (ptr :pointer))
(export 'HINGE-2-CONSTRAINT/DELETE-CPLUS-ARRAY)
#+ (or)
(progn 
  (declaim (inline HINGE-2-CONSTRAINT/MAKE-CPLUS-ARRAY))
  (cffi:defcfun ("_wrap_btHinge2Constraint_makeCPlusArray__SWIG_1" HINGE-2-CONSTRAINT/MAKE-CPLUS-ARRAY) :pointer
   (self :pointer)
   (arg1 :pointer)
   (ptr :pointer))
  (export 'HINGE-2-CONSTRAINT/MAKE-CPLUS-ARRAY))
#+ (or)
(progn (declaim (inline HINGE-2-CONSTRAINT/DELETE-CPLUS-ARRAY))
       (cffi:defcfun ("_wrap_btHinge2Constraint_deleteCPlusArray__SWIG_1" HINGE-2-CONSTRAINT/DELETE-CPLUS-ARRAY) :void
               (self :pointer)
               (arg1 :pointer)
               (arg2 :pointer))
       (export 'HINGE-2-CONSTRAINT/DELETE-CPLUS-ARRAY))
(declaim (inline MAKE-HINGE-2-CONSTRAINT))
(cffi:defcfun ("_wrap_new_btHinge2Constraint" MAKE-HINGE-2-CONSTRAINT) :pointer
  (rbA :pointer)
  (rbB :pointer)
  (anchor :pointer)
  (axis1 :pointer)
  (axis2 :pointer))

(export 'MAKE-HINGE-2-CONSTRAINT)

(declaim (inline HINGE-2-CONSTRAINT/GET-ANCHOR))

(cffi:defcfun ("_wrap_btHinge2Constraint_getAnchor" HINGE-2-CONSTRAINT/GET-ANCHOR) :pointer  (self :pointer))
(export 'HINGE-2-CONSTRAINT/GET-ANCHOR)
(declaim (inline HINGE-2-CONSTRAINT/GET-ANCHOR-2))
(cffi:defcfun ("_wrap_btHinge2Constraint_getAnchor2" HINGE-2-CONSTRAINT/GET-ANCHOR-2) :pointer
  (self :pointer))
(export 'HINGE-2-CONSTRAINT/GET-ANCHOR-2)
(declaim (inline HINGE-2-CONSTRAINT/GET-AXIS-1))
(cffi:defcfun ("_wrap_btHinge2Constraint_getAxis1" HINGE-2-CONSTRAINT/GET-AXIS-1) :pointer  (self :pointer))
(export 'HINGE-2-CONSTRAINT/GET-AXIS-1)
(declaim (inline HINGE-2-CONSTRAINT/GET-AXIS-2))
(cffi:defcfun ("_wrap_btHinge2Constraint_getAxis2" HINGE-2-CONSTRAINT/GET-AXIS-2) :pointer
  (self :pointer))
(export 'HINGE-2-CONSTRAINT/GET-AXIS-2)
(declaim (inline HINGE-2-CONSTRAINT/GET-ANGLE-1))
(cffi:defcfun ("_wrap_btHinge2Constraint_getAngle1" HINGE-2-CONSTRAINT/GET-ANGLE-1) :float
  (self :pointer))
(export 'HINGE-2-CONSTRAINT/GET-ANGLE-1)
(declaim (inline HINGE-2-CONSTRAINT/GET-ANGLE-2))
(cffi:defcfun ("_wrap_btHinge2Constraint_getAngle2" HINGE-2-CONSTRAINT/GET-ANGLE-2) :float
  (self :pointer))
(export 'HINGE-2-CONSTRAINT/GET-ANGLE-2)
(declaim (inline HINGE-2-CONSTRAINT/SET-UPPER-LIMIT))
(cffi:defcfun ("_wrap_btHinge2Constraint_setUpperLimit" HINGE-2-CONSTRAINT/SET-UPPER-LIMIT) :void
  (ang1max :float))
(export 'HINGE-2-CONSTRAINT/SET-UPPER-LIMIT)
(declaim (inline HINGE-2-CONSTRAINT/SET-LOWER-LIMIT))
(cffi:defcfun ("_wrap_btHinge2Constraint_setLowerLimit" HINGE-2-CONSTRAINT/SET-LOWER-LIMIT) :void
  (ang1min :float))
(export 'HINGE-2-CONSTRAINT/SET-LOWER-LIMIT)
(declaim (inline DELETE/BT-HINGE-2-CONSTRAINT))
(cffi:defcfun ("_wrap_delete_btHinge2Constraint" DELETE/BT-HINGE-2-CONSTRAINT) :void
  (self :pointer))
(export 'DELETE/BT-HINGE-2-CONSTRAINT)
(define-constant +GEAR-CONSTRAINT-DATA-NAME+ "btGearConstraintFloatData" :test 'equal)
(export '+GEAR-CONSTRAINT-DATA-NAME+)
(declaim (inline MAKE-GEAR-CONSTRAINT))
(cffi:defcfun ("_wrap_new_btGearConstraint__SWIG_0" MAKE-GEAR-CONSTRAINT) :pointer
  (rbA :pointer)
  (rbB :pointer)
  (axisInA :pointer)
  (axisInB :pointer)
  (ratio :float))
(export 'MAKE-GEAR-CONSTRAINT)
(declaim (inline make-gear-constraint/without-ratio))
(cffi:defcfun ("_wrap_new_btGearConstraint__SWIG_1" 
               make-gear-constraint/without-ratio) :pointer
  (rbA :pointer)
  (rbB :pointer)
  (axisInA :pointer)
  (axisInB :pointer))
(export 'make-gear-constraint/without-ratio)

(declaim (inline DELETE/BT-GEAR-CONSTRAINT))

(cffi:defcfun ("_wrap_delete_btGearConstraint" DELETE/BT-GEAR-CONSTRAINT) :void  (self :pointer))
(export 'DELETE/BT-GEAR-CONSTRAINT)
(declaim (inline GEAR-CONSTRAINT/GET-INFO-1))
(cffi:defcfun ("_wrap_btGearConstraint_getInfo1" GEAR-CONSTRAINT/GET-INFO-1) :void
  (info :pointer))
(export 'GEAR-CONSTRAINT/GET-INFO-1)
(declaim (inline GEAR-CONSTRAINT/GET-INFO-2))
(cffi:defcfun ("_wrap_btGearConstraint_getInfo2" GEAR-CONSTRAINT/GET-INFO-2) :void
  (self :pointer)
  (info :pointer))
(export 'GEAR-CONSTRAINT/GET-INFO-2)
(declaim (inline GEAR-CONSTRAINT/SET-AXIS-A))
(cffi:defcfun ("_wrap_btGearConstraint_setAxisA" GEAR-CONSTRAINT/SET-AXIS-A) :void
  (self :pointer)
  (axisA :pointer))
(export 'GEAR-CONSTRAINT/SET-AXIS-A)
(declaim (inline GEAR-CONSTRAINT/SET-AXIS-B))
(cffi:defcfun ("_wrap_btGearConstraint_setAxisB" GEAR-CONSTRAINT/SET-AXIS-B) :void
  (axisB :pointer))
(export 'GEAR-CONSTRAINT/SET-AXIS-B)
(declaim (inline GEAR-CONSTRAINT/SET-RATIO))
(cffi:defcfun ("_wrap_btGearConstraint_setRatio" GEAR-CONSTRAINT/SET-RATIO) :void
  (ratio :float))
(export 'GEAR-CONSTRAINT/SET-RATIO)
(declaim (inline GEAR-CONSTRAINT/GET-AXIS-A))
(cffi:defcfun ("_wrap_btGearConstraint_getAxisA" GEAR-CONSTRAINT/GET-AXIS-A) :pointer  (self :pointer))
(export 'GEAR-CONSTRAINT/GET-AXIS-A)
(declaim (inline GEAR-CONSTRAINT/GET-AXIS-B))
(cffi:defcfun ("_wrap_btGearConstraint_getAxisB" GEAR-CONSTRAINT/GET-AXIS-B) :pointer  (self :pointer))
(export 'GEAR-CONSTRAINT/GET-AXIS-B)
(declaim (inline GEAR-CONSTRAINT/GET-RATIO))
(cffi:defcfun ("_wrap_btGearConstraint_getRatio" GEAR-CONSTRAINT/GET-RATIO) :float  (self :pointer))
(export 'GEAR-CONSTRAINT/GET-RATIO)

(declaim (inline GEAR-CONSTRAINT/CALCULATE-SERIALIZE-BUFFER-SIZE))
(cffi:defcfun ("_wrap_btGearConstraint_calculateSerializeBufferSize" GEAR-CONSTRAINT/CALCULATE-SERIALIZE-BUFFER-SIZE) :int
  (self :pointer))
(export 'GEAR-CONSTRAINT/CALCULATE-SERIALIZE-BUFFER-SIZE)
(declaim (inline GEAR-CONSTRAINT/SERIALIZE))
(cffi:defcfun ("_wrap_btGearConstraint_serialize" GEAR-CONSTRAINT/SERIALIZE) :string
  (dataBuffer :pointer)
  (serializer :pointer))
(export 'GEAR-CONSTRAINT/SERIALIZE)
(cffi:defcstruct GEAR-CONSTRAINT-FLOAT-DATA
  (TYPE-CONSTRAINT-DATA 
           (:pointer (:STRUCT
                      TYPED-CONSTRAINT-FLOAT-DATA)))
  (AXIS-IN-A (:pointer (:struct vector-3-float-data)))
  (AXIS-IN-B (:pointer (:struct vector-3-float-data)))
  (BULLET/RATIO :float)
  (PADDING :pointer))
(export 'GEAR-CONSTRAINT-FLOAT-DATA)
(export 'TYPE-CONSTRAINT-DATA)
(export 'AXIS-IN-A)
(export 'AXIS-IN-B)
(export 'BULLET/RATIO)
(export 'PADDING)
(cffi:defcstruct GEAR-CONSTRAINT-DOUBLE-DATA
  (TYPE-CONSTRAINT-DATA
                    (:POINTER
                     (:STRUCT
                      TYPED-CONSTRAINT-DOUBLE-DATA)))
  (AXIS-IN-A (:pointer (:struct vector-3-double-data)))
  (AXIS-IN-B (:pointer (:struct vector-3-double-data)))
  (BULLET/RATIO :double))
(export 'GEAR-CONSTRAINT-DOUBLE-DATA)
(export 'TYPE-CONSTRAINT-DATA)
(export 'AXIS-IN-A)
(export 'AXIS-IN-B)
(export 'BULLET/RATIO)
(declaim (inline MAKE-FIXED-CONSTRAINT))
(cffi:defcfun ("_wrap_new_btFixedConstraint" MAKE-FIXED-CONSTRAINT) :pointer
  (rbA :pointer)
  (rbB :pointer)
  (frameInA :pointer)
  (frameInB :pointer))
(export 'MAKE-FIXED-CONSTRAINT)
(declaim (inline DELETE/BT-FIXED-CONSTRAINT))
(cffi:defcfun ("_wrap_delete_btFixedConstraint" DELETE/BT-FIXED-CONSTRAINT) :void  (self :pointer))
(export 'DELETE/BT-FIXED-CONSTRAINT)
(declaim (inline FIXED-CONSTRAINT/GET-INFO-1))
(cffi:defcfun ("_wrap_btFixedConstraint_getInfo1" FIXED-CONSTRAINT/GET-INFO-1) :void
  (self :pointer)
  (info :pointer))
(export 'FIXED-CONSTRAINT/GET-INFO-1)
(declaim (inline FIXED-CONSTRAINT/GET-INFO-2))
(cffi:defcfun ("_wrap_btFixedConstraint_getInfo2" FIXED-CONSTRAINT/GET-INFO-2) :void
  (self :pointer)
  (info :pointer))
(export 'FIXED-CONSTRAINT/GET-INFO-2)

(declaim (inline SEQUENTIAL-IMPULSE-CONSTRAINT-SOLVER/MAKE-CPLUS-PLUS-INSTANCE))
(cffi:defcfun ("_wrap_btSequentialImpulseConstraintSolver_makeCPlusPlusInstance__SWIG_0" SEQUENTIAL-IMPULSE-CONSTRAINT-SOLVER/MAKE-CPLUS-PLUS-INSTANCE) :pointer
  (self :pointer)
  (sizeInBytes :pointer))
(export 'SEQUENTIAL-IMPULSE-CONSTRAINT-SOLVER/MAKE-CPLUS-PLUS-INSTANCE)
(declaim (inline SEQUENTIAL-IMPULSE-CONSTRAINT-SOLVER/DELETE-CPLUS-PLUS-INSTANCE))
(cffi:defcfun ("_wrap_btSequentialImpulseConstraintSolver_deleteCPlusPlusInstance__SWIG_0" SEQUENTIAL-IMPULSE-CONSTRAINT-SOLVER/DELETE-CPLUS-PLUS-INSTANCE) :void
  (ptr :pointer))
(export 'SEQUENTIAL-IMPULSE-CONSTRAINT-SOLVER/DELETE-CPLUS-PLUS-INSTANCE)
#+ (or)
(progn 
  (declaim (inline SEQUENTIAL-IMPULSE-CONSTRAINT-SOLVER/MAKE-CPLUS-PLUS-INSTANCE))
  (cffi:defcfun ("_wrap_btSequentialImpulseConstraintSolver_makeCPlusPlusInstance__SWIG_1" SEQUENTIAL-IMPULSE-CONSTRAINT-SOLVER/MAKE-CPLUS-PLUS-INSTANCE) :pointer
    (arg1 :pointer)
    (ptr :pointer))
  (export 'SEQUENTIAL-IMPULSE-CONSTRAINT-SOLVER/MAKE-CPLUS-PLUS-INSTANCE)
  (declaim (inline SEQUENTIAL-IMPULSE-CONSTRAINT-SOLVER/DELETE-CPLUS-PLUS-INSTANCE))
  (cffi:defcfun ("_wrap_btSequentialImpulseConstraintSolver_deleteCPlusPlusInstance__SWIG_1" SEQUENTIAL-IMPULSE-CONSTRAINT-SOLVER/DELETE-CPLUS-PLUS-INSTANCE) :void
          (arg1 :pointer)
          (arg2 :pointer))
  (export 'SEQUENTIAL-IMPULSE-CONSTRAINT-SOLVER/DELETE-CPLUS-PLUS-INSTANCE))
(declaim (inline SEQUENTIAL-IMPULSE-CONSTRAINT-SOLVER/MAKE-CPLUS-ARRAY))
(cffi:defcfun ("_wrap_btSequentialImpulseConstraintSolver_makeCPlusArray__SWIG_0" SEQUENTIAL-IMPULSE-CONSTRAINT-SOLVER/MAKE-CPLUS-ARRAY) :pointer
  (self :pointer)
  (sizeInBytes :pointer))
(export 'SEQUENTIAL-IMPULSE-CONSTRAINT-SOLVER/MAKE-CPLUS-ARRAY)
(declaim (inline SEQUENTIAL-IMPULSE-CONSTRAINT-SOLVER/DELETE-CPLUS-ARRAY))
(cffi:defcfun ("_wrap_btSequentialImpulseConstraintSolver_deleteCPlusArray__SWIG_0" SEQUENTIAL-IMPULSE-CONSTRAINT-SOLVER/DELETE-CPLUS-ARRAY) :void
  (ptr :pointer))
(export 'SEQUENTIAL-IMPULSE-CONSTRAINT-SOLVER/DELETE-CPLUS-ARRAY)

#+ (or)
(progn 
  (declaim (inline SEQUENTIAL-IMPULSE-CONSTRAINT-SOLVER/MAKE-CPLUS-ARRAY))
  (cffi:defcfun ("_wrap_btSequentialImpulseConstraintSolver_makeCPlusArray__SWIG_1" SEQUENTIAL-IMPULSE-CONSTRAINT-SOLVER/MAKE-CPLUS-ARRAY) :pointer
    (arg1 :pointer)
    (ptr :pointer))
  (export 'SEQUENTIAL-IMPULSE-CONSTRAINT-SOLVER/MAKE-CPLUS-ARRAY)
  (declaim (inline SEQUENTIAL-IMPULSE-CONSTRAINT-SOLVER/DELETE-CPLUS-ARRAY))
  (cffi:defcfun ("_wrap_btSequentialImpulseConstraintSolver_deleteCPlusArray__SWIG_1" SEQUENTIAL-IMPULSE-CONSTRAINT-SOLVER/DELETE-CPLUS-ARRAY) :void
          (arg1 :pointer)
          (arg2 :pointer))
  (export 'SEQUENTIAL-IMPULSE-CONSTRAINT-SOLVER/DELETE-CPLUS-ARRAY))
(declaim (inline MAKE-SEQUENTIAL-IMPULSE-CONSTRAINT-SOLVER))
(cffi:defcfun ("_wrap_new_btSequentialImpulseConstraintSolver" MAKE-SEQUENTIAL-IMPULSE-CONSTRAINT-SOLVER) :pointer)
(export 'MAKE-SEQUENTIAL-IMPULSE-CONSTRAINT-SOLVER)
(declaim (inline DELETE/BT-SEQUENTIAL-IMPULSE-CONSTRAINT-SOLVER))
(cffi:defcfun ("_wrap_delete_btSequentialImpulseConstraintSolver" DELETE/BT-SEQUENTIAL-IMPULSE-CONSTRAINT-SOLVER) :void  (self :pointer))
(export 'DELETE/BT-SEQUENTIAL-IMPULSE-CONSTRAINT-SOLVER)
(declaim (inline SEQUENTIAL-IMPULSE-CONSTRAINT-SOLVER/SOLVE-GROUP))
(cffi:defcfun ("_wrap_btSequentialImpulseConstraintSolver_solveGroup" SEQUENTIAL-IMPULSE-CONSTRAINT-SOLVER/SOLVE-GROUP) :float
  (bodies :pointer)
  (numBodies :int)
  (manifold :pointer)
  (numManifolds :int)
  (constraints :pointer)
  (numConstraints :int)
  (info :pointer)
  (debugDrawer :pointer)
  (dispatcher :pointer))
(export 'SEQUENTIAL-IMPULSE-CONSTRAINT-SOLVER/SOLVE-GROUP)
(declaim (inline SEQUENTIAL-IMPULSE-CONSTRAINT-SOLVER/RESET))
(cffi:defcfun ("_wrap_btSequentialImpulseConstraintSolver_reset" SEQUENTIAL-IMPULSE-CONSTRAINT-SOLVER/RESET) :void  (self :pointer))
(export 'SEQUENTIAL-IMPULSE-CONSTRAINT-SOLVER/RESET)
(declaim (inline SEQUENTIAL-IMPULSE-CONSTRAINT-SOLVER/BT-RAND-2))
(cffi:defcfun ("_wrap_btSequentialImpulseConstraintSolver_btRand2" SEQUENTIAL-IMPULSE-CONSTRAINT-SOLVER/BT-RAND-2) :unsigned-long  (self :pointer))
(export 'SEQUENTIAL-IMPULSE-CONSTRAINT-SOLVER/BT-RAND-2)
(declaim (inline SEQUENTIAL-IMPULSE-CONSTRAINT-SOLVER/BT-RAND-INT-2))
(cffi:defcfun ("_wrap_btSequentialImpulseConstraintSolver_btRandInt2" SEQUENTIAL-IMPULSE-CONSTRAINT-SOLVER/BT-RAND-INT-2) :int
  (self :pointer)
  (n :int))
(export 'SEQUENTIAL-IMPULSE-CONSTRAINT-SOLVER/BT-RAND-INT-2)
(declaim (inline SEQUENTIAL-IMPULSE-CONSTRAINT-SOLVER/SET-RAND-SEED))
(cffi:defcfun ("_wrap_btSequentialImpulseConstraintSolver_setRandSeed" SEQUENTIAL-IMPULSE-CONSTRAINT-SOLVER/SET-RAND-SEED) :void
  (self :pointer)
  (seed :unsigned-long))
(export 'SEQUENTIAL-IMPULSE-CONSTRAINT-SOLVER/SET-RAND-SEED)
(declaim (inline SEQUENTIAL-IMPULSE-CONSTRAINT-SOLVER/GET-RAND-SEED))
(cffi:defcfun ("_wrap_btSequentialImpulseConstraintSolver_getRandSeed" SEQUENTIAL-IMPULSE-CONSTRAINT-SOLVER/GET-RAND-SEED) :unsigned-long
  (self :pointer))
(export 'SEQUENTIAL-IMPULSE-CONSTRAINT-SOLVER/GET-RAND-SEED)
(declaim (inline SEQUENTIAL-IMPULSE-CONSTRAINT-SOLVER/GET-SOLVER-TYPE))
(cffi:defcfun ("_wrap_btSequentialImpulseConstraintSolver_getSolverType" SEQUENTIAL-IMPULSE-CONSTRAINT-SOLVER/GET-SOLVER-TYPE) :pointer
  (self :pointer))
(export 'SEQUENTIAL-IMPULSE-CONSTRAINT-SOLVER/GET-SOLVER-TYPE)



(defmethod NEW ((self VECTOR-3) sizeInBytes)
  (VECTOR-3/MAKE-CPLUS-PLUS-INSTANCE (ff-pointer self) sizeInBytes))

(defmethod BULLET/DELETE ((self VECTOR-3) ptr)
  (VECTOR-3/DELETE-CPLUS-PLUS-INSTANCE (ff-pointer self) ptr))

#+ (or)
(progn
  
  (defmethod NEW ((self VECTOR-3) arg1 ptr)
    (VECTOR-3/MAKE-CPLUS-PLUS-INSTANCE (ff-pointer self) arg1 ptr))
  
  
  (defmethod BULLET/DELETE ((self VECTOR-3) arg1 arg2)
    (VECTOR-3/DELETE-CPLUS-PLUS-INSTANCE
               (ff-pointer self) arg1 arg2)))

(shadow "new[]")
(defmethod NEW[] ((self VECTOR-3) sizeInBytes)
  (VECTOR-3/MAKE-CPLUS-ARRAY (ff-pointer self) sizeInBytes))

(shadow "delete[]")
(defmethod DELETE[] ((self VECTOR-3) ptr)
  (VECTOR-3/DELETE-CPLUS-ARRAY (ff-pointer self) ptr))

#+ (or)
(progn 
  (shadow "new[]")
  (defmethod NEW[] ((self VECTOR-3) arg1 ptr)
    (VECTOR-3/MAKE-CPLUS-ARRAY (ff-pointer self) arg1 ptr))

 (shadow "delete[]")
 (defmethod DELETE[] ((self VECTOR-3) arg1 arg2)
   (VECTOR-3/DELETE-CPLUS-ARRAY (ff-pointer self) arg1 arg2)))

(defmethod (setf FLOATS) (arg0 (obj VECTOR-3))
  (VECTOR-3/M/FLOATS/SET (ff-pointer obj) arg0))

(defmethod FLOATS ((obj VECTOR-3))
  (VECTOR-3/M/FLOATS/GET (ff-pointer obj)))

(defmethod initialize-instance :after ((obj VECTOR-3) &key)
  (setf (slot-value obj 'ff-pointer) (MAKE-VECTOR-3)))

(defmethod initialize-instance :after ((obj VECTOR-3) &key _x _y _z)
  (setf (slot-value obj 'ff-pointer) (MAKE-VECTOR-3 _x _y _z)))

(shadow "+=")
(defmethod += ((self VECTOR-3) (v VECTOR-3))
  (VECTOR-3/INCREMENT (ff-pointer self) (ff-pointer v)))

(shadow "-=")
(defmethod -= ((self VECTOR-3) (v VECTOR-3))
  (VECTOR-3/DECREMENT (ff-pointer self) (ff-pointer v)))

(shadow "*=")
(defmethod *= ((self VECTOR-3) s)
  (VECTOR-3/MULTIPLY-AND-ASSIGN (ff-pointer self) s))

(shadow "/=")
(defmethod BULLET//= ((self VECTOR-3) s)
  (VECTOR-3/DIVIDE-AND-ASSIGN (ff-pointer self) s))

(defmethod DOT ((self VECTOR-3) (v VECTOR-3))
  (VECTOR-3/DOT (ff-pointer self) (ff-pointer v)))

(defmethod LENGTH-2 ((self VECTOR-3))
  (VECTOR-3/LENGTH-2 (ff-pointer self)))

(defmethod BULLET/LENGTH ((self VECTOR-3))
  (VECTOR-3/LENGTH (ff-pointer self)))

(defmethod NORM ((self VECTOR-3))
  (VECTOR-3/NORM (ff-pointer self)))

(defmethod DISTANCE-2 ((self VECTOR-3) (v VECTOR-3))
  (VECTOR-3/DISTANCE-2 (ff-pointer self) (ff-pointer v)))

(defmethod DISTANCE ((self VECTOR-3) (v VECTOR-3))
  (VECTOR-3/DISTANCE (ff-pointer self) (ff-pointer v)))

(defmethod SAFE-NORMALIZE ((self VECTOR-3))
  (VECTOR-3/SAFE-NORMALIZE (ff-pointer self)))

(defmethod NORMALIZE ((self VECTOR-3))
  (VECTOR-3/NORMALIZE (ff-pointer self)))

(defmethod NORMALIZED ((self VECTOR-3))
  (VECTOR-3/NORMALIZED (ff-pointer self)))

(defmethod ROTATE ((self VECTOR-3) (wAxis VECTOR-3) (angle number))
  (VECTOR-3/ROTATE (ff-pointer self) (ff-pointer wAxis) angle))

(declaim (inline angle))

(defgeneric angle (a b)
  (:method ((a vector3) (b vector3))
    (vector3/angle a b))
  (:method ((a quaternion) (b quaternion))
    (quaternion/angle a b)))

(export 'angle)

#+ (or)
(defmethod ANGLE ((self VECTOR-3) (v VECTOR-3))
  (VECTOR-3/ANGLE (ff-pointer self) (ff-pointer v)))

(defmethod ABSOLUTE ((self VECTOR-3))
  (VECTOR-3/ABSOLUTE (ff-pointer self)))

(defmethod CROSS ((self VECTOR-3) (v VECTOR-3))
  (VECTOR-3/CROSS (ff-pointer self) (ff-pointer v)))

(defmethod TRIPLE ((self VECTOR-3) (v1 VECTOR-3) (v2 VECTOR-3))
  (VECTOR-3/TRIPLE (ff-pointer self) (ff-pointer v1) (ff-pointer v2)))

(defmethod MIN-AXIS ((self VECTOR-3))
  (VECTOR-3/MIN-AXIS (ff-pointer self)))

(defmethod MAX-AXIS ((self VECTOR-3))
  (VECTOR-3/MAX-AXIS (ff-pointer self)))

(defmethod FURTHEST-AXIS ((self VECTOR-3))
  (VECTOR-3/FURTHEST-AXIS (ff-pointer self)))

(defmethod CLOSEST-AXIS ((self VECTOR-3))
  (VECTOR-3/CLOSEST-AXIS (ff-pointer self)))

(defmethod (SETF INTERPOLATE-3) ((self VECTOR-3) (v0 VECTOR-3) (v1 VECTOR-3) (rt number))
  (VECTOR-3/SET-INTERPOLATE-3 (ff-pointer self) (ff-pointer v0) (ff-pointer v1) rt))

(defmethod LERP ((self VECTOR-3) (v VECTOR-3) t-arg2)
  (VECTOR-3/LERP (ff-pointer self) (ff-pointer v) t-arg2))

(shadow "*=")
(defmethod *= ((self VECTOR-3) (v VECTOR-3))
  (VECTOR-3/MULTIPLY-AND-ASSIGN (ff-pointer self) (ff-pointer v)))

(defmethod X ((self VECTOR-3))
  (VECTOR-3/GET-X (ff-pointer self)))

(defmethod Y ((self VECTOR-3))
  (VECTOR-3/GET-Y (ff-pointer self)))

(defmethod Z ((self VECTOR-3))
  (VECTOR-3/GET-Z (ff-pointer self)))

(defmethod (SETF X) ((self VECTOR-3) (_x number))
  (VECTOR-3/SET-X (ff-pointer self) _x))

(defmethod (SETF Y) ((self VECTOR-3) (_y number))
  (VECTOR-3/SET-Y (ff-pointer self) _y))

(defmethod (SETF Z) ((self VECTOR-3) (_z number))
  (VECTOR-3/SET-Z (ff-pointer self) _z))

(defmethod (SETF W) ((self VECTOR-3) (_w number))
  (VECTOR-3/SET-W (ff-pointer self) _w))

(defmethod X ((self VECTOR-3))
  (VECTOR-3/X (ff-pointer self)))

(defmethod Y ((self VECTOR-3))
  (VECTOR-3/Y (ff-pointer self)))

(defmethod Z ((self VECTOR-3))
  (VECTOR-3/Z (ff-pointer self)))

(defmethod W ((self VECTOR-3))
  (VECTOR-3/W (ff-pointer self)))

(shadow "==")
(defmethod == ((self VECTOR-3) (other VECTOR-3))
  (VECTOR-3/IS-EQUAL (ff-pointer self) (ff-pointer other)))

(shadow "!=")
(defmethod != ((self VECTOR-3) (other VECTOR-3))
  (VECTOR-3/NOT-EQUALS (ff-pointer self) (ff-pointer other)))

(defmethod (SETF BULLET/MAX) ((self VECTOR-3) (other VECTOR-3))
  (VECTOR-3/SET-MAX (ff-pointer self) (ff-pointer other)))

(defmethod (SETF BULLET/MIN) ((self VECTOR-3) (other VECTOR-3))
  (VECTOR-3/SET-MIN (ff-pointer self) (ff-pointer other)))

(defmethod (SETF VALUE) ((self VECTOR-3) _x _y _z)
  (VECTOR-3/SET-VALUE (ff-pointer self) _x _y _z))

(defmethod SKEW-SYMMETRIC-MATRIX ((self VECTOR-3) (v0 VECTOR-3) (v1 VECTOR-3) (v2 VECTOR-3))
  (VECTOR-3/GET-SKEW-SYMMETRIC-MATRIX (ff-pointer self) (ff-pointer v0) (ff-pointer v1) (ff-pointer v2)))

(defmethod (SETF ZERO) ((self VECTOR-3))
  (VECTOR-3/SET-ZERO (ff-pointer self)))

(defmethod BULLET/ZEROP ((self VECTOR-3))
  (VECTOR-3/IS-ZERO (ff-pointer self)))

(defmethod FUZZY-ZERO ((self VECTOR-3))
  (VECTOR-3/FUZZY-ZERO (ff-pointer self)))

(defmethod SERIALIZE ((self VECTOR-3) dataOut)
  (VECTOR-3/SERIALIZE (ff-pointer self) dataOut))

(defmethod DE-SERIALIZE ((self VECTOR-3) dataIn)
  (VECTOR-3/DE-SERIALIZE (ff-pointer self) dataIn))

(defmethod SERIALIZE-FLOAT ((self VECTOR-3) dataOut)
  (VECTOR-3/SERIALIZE-FLOAT (ff-pointer self) dataOut))

(defmethod DE-SERIALIZE-FLOAT ((self VECTOR-3) dataIn)
  (VECTOR-3/DE-SERIALIZE-FLOAT (ff-pointer self) dataIn))

(defmethod SERIALIZE-DOUBLE ((self VECTOR-3) dataOut)
  (VECTOR-3/SERIALIZE-DOUBLE (ff-pointer self) dataOut))

(defmethod DE-SERIALIZE-DOUBLE ((self VECTOR-3) dataIn)
  (VECTOR-3/DE-SERIALIZE-DOUBLE (ff-pointer self) dataIn))

(defmethod MAX-DOT ((self VECTOR-3) (array VECTOR-3) (array_count integer) dotOut)
  (VECTOR-3/MAX-DOT (ff-pointer self) (ff-pointer array) array_count dotOut))

(defmethod MIN-DOT ((self VECTOR-3) (array VECTOR-3) (array_count integer) dotOut)
  (VECTOR-3/MIN-DOT (ff-pointer self) (ff-pointer array) array_count dotOut))

(defmethod DOT-3 ((self VECTOR-3) (v0 VECTOR-3) (v1 VECTOR-3) (v2 VECTOR-3))
  (VECTOR-3/DOT-3 (ff-pointer self) (ff-pointer v0) (ff-pointer v1) (ff-pointer v2)))



(defmethod initialize-instance :after ((obj VECTOR-4) &key)
  (setf (slot-value obj 'ff-pointer) (MAKE-VECTOR-4)))

(defmethod initialize-instance :after ((obj VECTOR-4) &key _x _y _z _w)
  (setf (slot-value obj 'ff-pointer) (MAKE-VECTOR-4 _x _y _z _w)))

(defmethod ABSOLUTE-4 ((self VECTOR-4))
  (VECTOR-4/ABSOLUTE-4 (ff-pointer self)))

(defmethod W ((self VECTOR-4))
  (VECTOR-4/GET-W (ff-pointer self)))

(defmethod MAX-AXIS-4 ((self VECTOR-4))
  (VECTOR-4/MAX-AXIS-4 (ff-pointer self)))

(defmethod MIN-AXIS-4 ((self VECTOR-4))
  (VECTOR-4/MIN-AXIS-4 (ff-pointer self)))

(defmethod CLOSEST-AXIS-4 ((self VECTOR-4))
  (VECTOR-4/CLOSEST-AXIS-4 (ff-pointer self)))

(defmethod (SETF VALUE) ((self VECTOR-4) _x _y _z _w)
  (VECTOR-4/SET-VALUE (ff-pointer self) _x _y _z _w))



(defmethod initialize-instance :after ((obj QUATERNION) &key)
  (setf (slot-value obj 'ff-pointer) (MAKE-QUATERNION)))

(defmethod initialize-instance :after ((obj QUATERNION) &key _x _y _z _w)
  (setf (slot-value obj 'ff-pointer) (MAKE-QUATERNION _x _y _z _w)))

(defmethod initialize-instance :after ((obj QUATERNION) &key (_axis VECTOR-3) _angle)
  (setf (slot-value obj 'ff-pointer) (MAKE-QUATERNION _axis _angle)))

(defmethod initialize-instance :after ((obj QUATERNION) &key yaw pitch roll)
  (setf (slot-value obj 'ff-pointer) (MAKE-QUATERNION yaw pitch roll)))

(defmethod (SETF ROTATION) ((self QUATERNION) (axis VECTOR-3) _angle)
  (QUATERNION/SET-ROTATION (ff-pointer self) axis _angle))

(defmethod (SETF EULER) ((self QUATERNION) yaw pitch roll)
  (QUATERNION/SET-EULER (ff-pointer self) yaw pitch roll))

(defmethod (SETF EULER-ZYX) ((self QUATERNION) yaw pitch roll)
  (QUATERNION/SET-EULER-ZYX (ff-pointer self) yaw pitch roll))

(shadow "+=")
(defmethod += ((self QUATERNION) (q QUATERNION))
  (QUATERNION/INCREMENT (ff-pointer self) (ff-pointer q)))

(shadow "-=")
(defmethod -= ((self QUATERNION) (q QUATERNION))
  (QUATERNION/DECREMENT (ff-pointer self) (ff-pointer q)))

(shadow "*=")
(defmethod *= ((self QUATERNION) s)
  (QUATERNION/MULTIPLY-AND-ASSIGN (ff-pointer self) s))

(shadow "*=")
(defmethod *= ((self QUATERNION) (q QUATERNION))
  (QUATERNION/MULTIPLY-AND-ASSIGN (ff-pointer self) (ff-pointer q)))

(defmethod DOT ((self QUATERNION) (q QUATERNION))
  (QUATERNION/DOT (ff-pointer self) (ff-pointer q)))

(defmethod LENGTH-2 ((self QUATERNION))
  (QUATERNION/LENGTH-2 (ff-pointer self)))

(defmethod BULLET/LENGTH ((self QUATERNION))
  (QUATERNION/LENGTH (ff-pointer self)))

(defmethod NORMALIZE ((self QUATERNION))
  (QUATERNION/NORMALIZE (ff-pointer self)))

(shadow "*")
(defmethod BULLET/* ((self QUATERNION) s)
  (QUATERNION/MULTIPLY (ff-pointer self) s))

(shadow "/")
(defmethod BULLET// ((self QUATERNION) s)
  (QUATERNION/DIVIDE (ff-pointer self) s))

(shadow "/=")
(defmethod BULLET//= ((self QUATERNION) s)
  (QUATERNION/DIVIDE-AND-ASSIGN (ff-pointer self) s))

(defmethod NORMALIZED ((self QUATERNION))
  (QUATERNION/NORMALIZED (ff-pointer self)))

(defmethod ANGLE 
    ((self QUATERNION) 
     (q QUATERNION))
  (QUATERNION/ANGLE (ff-pointer self) (ff-pointer q)))

(defmethod ANGLE-SHORTEST-PATH ((self QUATERNION) (q QUATERNION))
  (QUATERNION/ANGLE-SHORTEST-PATH (ff-pointer self) (ff-pointer q)))

(defmethod ANGLE ((self QUATERNION))
  (QUATERNION/GET-ANGLE (ff-pointer self)))

(defmethod ANGLE-SHORTEST-PATH ((self QUATERNION))
  (QUATERNION/GET-ANGLE-SHORTEST-PATH (ff-pointer self)))

(defmethod AXIS ((self QUATERNION))
  (QUATERNION/GET-AXIS (ff-pointer self)))

(defmethod INVERSE ((self QUATERNION))
  (QUATERNION/INVERSE (ff-pointer self)))

(shadow "+")
(defmethod BULLET/+ ((self QUATERNION) (q2 QUATERNION))
  (QUATERNION/ADD (ff-pointer self) (ff-pointer q2)))

(shadow "-")
(defmethod BULLET/- ((self QUATERNION) (q2 QUATERNION))
  (QUATERNION/SUBTRACT (ff-pointer self) (ff-pointer q2)))

(shadow "-")
(defmethod BULLET/- ((self QUATERNION))
  (QUATERNION///NEG// (ff-pointer self)))

(defmethod FARTHEST ((self QUATERNION) (qd QUATERNION))
  (QUATERNION/FARTHEST (ff-pointer self) (ff-pointer qd)))

(defmethod NEAREST ((self QUATERNION) (qd QUATERNION))
  (QUATERNION/NEAREST (ff-pointer self) (ff-pointer qd)))

(defmethod SLERP ((self QUATERNION) (q QUATERNION) t-arg2)
  (QUATERNION/SLERP (ff-pointer self) (ff-pointer q) t-arg2))

(defmethod W ((self QUATERNION))
  (QUATERNION/GET-W (ff-pointer self)))



(defmethod initialize-instance :after ((obj MATRIX-3X-3) &key)
  (setf (slot-value obj 'ff-pointer) (MAKE-MATRIX-3X-3)))

(defmethod initialize-instance :after ((obj MATRIX-3X-3) &key (q QUATERNION))
  (setf (slot-value obj 'ff-pointer) (MAKE-MATRIX-3X-3 q)))

(defmethod initialize-instance :after ((obj MATRIX-3X-3) &key xx xy xz yx yy yz zx zy zz)
  (setf (slot-value obj 'ff-pointer) (MAKE-MATRIX-3X-3 xx xy xz yx yy yz zx zy zz)))

(defmethod initialize-instance :after ((obj MATRIX-3X-3) &key (other MATRIX-3X-3))
  (setf (slot-value obj 'ff-pointer) (MAKE-MATRIX-3X-3 (ff-pointer other))))

(shadow "=")
(defmethod BULLET/= ((self MATRIX-3X-3) (other MATRIX-3X-3))
  (MATRIX-3X-3/ASSIGN-VALUE (ff-pointer self) (ff-pointer other)))

(defmethod COLUMN ((self MATRIX-3X-3) (i integer))
  (MATRIX-3X-3/GET-COLUMN (ff-pointer self) i))

(defmethod ROW ((self MATRIX-3X-3) (i integer))
  (MATRIX-3X-3/GET-ROW (ff-pointer self) i))

(shadow "[]")
(defmethod [] ((self MATRIX-3X-3) (i integer))
  (MATRIX-3X-3///AREF// (ff-pointer self) i))

(shadow "[]")
(defmethod [] ((self MATRIX-3X-3) (i integer))
  (MATRIX-3X-3///AREF// (ff-pointer self) i))

(shadow "*=")
(defmethod *= ((self MATRIX-3X-3) (m MATRIX-3X-3))
  (MATRIX-3X-3/MULTIPLY-AND-ASSIGN (ff-pointer self) (ff-pointer m)))

(shadow "+=")
(defmethod += ((self MATRIX-3X-3) (m MATRIX-3X-3))
  (MATRIX-3X-3/INCREMENT (ff-pointer self) (ff-pointer m)))

(shadow "-=")
(defmethod -= ((self MATRIX-3X-3) (m MATRIX-3X-3))
  (MATRIX-3X-3/DECREMENT (ff-pointer self) (ff-pointer m)))

(defmethod (SETF FROM-OPEN-GLSUB-MATRIX) ((self MATRIX-3X-3) m)
  (MATRIX-3X-3/SET-FROM-OPEN-GLSUB-MATRIX (ff-pointer self) m))

(defmethod (SETF VALUE) ((self MATRIX-3X-3) xx xy xz yx yy yz zx zy zz)
  (MATRIX-3X-3/SET-VALUE (ff-pointer self) xx xy xz yx yy yz zx zy zz))

(defmethod (SETF ROTATION) ((self MATRIX-3X-3) (q QUATERNION))
  (MATRIX-3X-3/SET-ROTATION (ff-pointer self) q))

(defmethod (SETF EULER-YPR) ((self MATRIX-3X-3) yaw pitch roll)
  (MATRIX-3X-3/SET-EULER-YPR (ff-pointer self) yaw pitch roll))

(defmethod (SETF EULER-ZYX) ((self MATRIX-3X-3) (eulerX number) (eulerY number) (eulerZ number))
  (MATRIX-3X-3/SET-EULER-ZYX (ff-pointer self) eulerX eulerY eulerZ))

(defmethod (SETF BULLET/IDENTITY) ((self MATRIX-3X-3))
  (MATRIX-3X-3/SET-IDENTITY (ff-pointer self)))

(defmethod OPEN-GLSUB-MATRIX ((self MATRIX-3X-3) m)
  (MATRIX-3X-3/GET-OPEN-GLSUB-MATRIX (ff-pointer self) m))

(defmethod ROTATION ((self MATRIX-3X-3) (q QUATERNION))
  (MATRIX-3X-3/GET-ROTATION (ff-pointer self) q))

(defmethod EULER-YPR ((self MATRIX-3X-3) yaw pitch roll)
  (MATRIX-3X-3/GET-EULER-YPR (ff-pointer self) yaw pitch roll))

(defmethod EULER-ZYX ((self MATRIX-3X-3) yaw pitch roll (solution_number integer))
  (MATRIX-3X-3/GET-EULER-ZYX (ff-pointer self) yaw pitch roll solution_number))

(defmethod EULER-ZYX ((self MATRIX-3X-3) yaw pitch roll)
  (MATRIX-3X-3/GET-EULER-ZYX (ff-pointer self) yaw pitch roll))

(defmethod SCALED ((self MATRIX-3X-3) (s VECTOR-3))
  (MATRIX-3X-3/SCALED (ff-pointer self) s))

(defmethod DETERMINANT ((self MATRIX-3X-3))
  (MATRIX-3X-3/DETERMINANT (ff-pointer self)))

(defmethod ADJOINT ((self MATRIX-3X-3))
  (MATRIX-3X-3/ADJOINT (ff-pointer self)))

(defmethod ABSOLUTE ((self MATRIX-3X-3))
  (MATRIX-3X-3/ABSOLUTE (ff-pointer self)))

(defmethod TRANSPOSE ((self MATRIX-3X-3))
  (MATRIX-3X-3/TRANSPOSE (ff-pointer self)))

(defmethod INVERSE ((self MATRIX-3X-3))
  (MATRIX-3X-3/INVERSE (ff-pointer self)))

(defmethod TRANSPOSE-TIMES ((self MATRIX-3X-3) (m MATRIX-3X-3))
  (MATRIX-3X-3/TRANSPOSE-TIMES (ff-pointer self) (ff-pointer m)))

(defmethod TIMES-TRANSPOSE ((self MATRIX-3X-3) (m MATRIX-3X-3))
  (MATRIX-3X-3/TIMES-TRANSPOSE (ff-pointer self) (ff-pointer m)))

(defmethod TDOTX ((self MATRIX-3X-3) (v VECTOR-3))
  (MATRIX-3X-3/TDOTX (ff-pointer self) v))

(defmethod TDOTY ((self MATRIX-3X-3) (v VECTOR-3))
  (MATRIX-3X-3/TDOTY (ff-pointer self) v))

(defmethod TDOTZ ((self MATRIX-3X-3) (v VECTOR-3))
  (MATRIX-3X-3/TDOTZ (ff-pointer self) v))

(defmethod DIAGONALIZE ((self MATRIX-3X-3) (rot MATRIX-3X-3) (threshold number) (maxSteps integer))
  (MATRIX-3X-3/DIAGONALIZE (ff-pointer self) (ff-pointer rot) threshold maxSteps))

(defmethod COFAC ((self MATRIX-3X-3) (r1 integer) (c1 integer) (r2 integer) (c2 integer))
  (MATRIX-3X-3/COFAC (ff-pointer self) r1 c1 r2 c2))

(defmethod SERIALIZE ((self MATRIX-3X-3) dataOut)
  (MATRIX-3X-3/SERIALIZE (ff-pointer self) dataOut))

(defmethod SERIALIZE-FLOAT ((self MATRIX-3X-3) dataOut)
  (MATRIX-3X-3/SERIALIZE-FLOAT (ff-pointer self) dataOut))

(defmethod DE-SERIALIZE ((self MATRIX-3X-3) dataIn)
  (MATRIX-3X-3/DE-SERIALIZE (ff-pointer self) dataIn))

(defmethod DE-SERIALIZE-FLOAT ((self MATRIX-3X-3) dataIn)
  (MATRIX-3X-3/DE-SERIALIZE-FLOAT (ff-pointer self) dataIn))

(defmethod DE-SERIALIZE-DOUBLE ((self MATRIX-3X-3) dataIn)
  (MATRIX-3X-3/DE-SERIALIZE-DOUBLE (ff-pointer self) dataIn))



(defmethod initialize-instance :after ((obj TRANSFORM) &key)
  (setf (slot-value obj 'ff-pointer) (MAKE-TRANSFORM)))

(defmethod initialize-instance :after ((obj TRANSFORM) &key (q QUATERNION) (c VECTOR-3))
  (setf (slot-value obj 'ff-pointer) (MAKE-TRANSFORM q c)))

(defmethod initialize-instance :after ((obj TRANSFORM) &key (q QUATERNION))
  (setf (slot-value obj 'ff-pointer) (MAKE-TRANSFORM q)))

(defmethod initialize-instance :after ((obj TRANSFORM) &key (b MATRIX-3X-3) (c VECTOR-3))
  (setf (slot-value obj 'ff-pointer) (MAKE-TRANSFORM b c)))

(defmethod initialize-instance :after ((obj TRANSFORM) &key (b MATRIX-3X-3))
  (setf (slot-value obj 'ff-pointer) (MAKE-TRANSFORM b)))

(defmethod initialize-instance :after ((obj TRANSFORM) &key (other TRANSFORM))
  (setf (slot-value obj 'ff-pointer) (MAKE-TRANSFORM (ff-pointer other))))

(shadow "=")
(defmethod BULLET/= ((self TRANSFORM) (other TRANSFORM))
  (TRANSFORM/ASSIGN-VALUE (ff-pointer self) (ff-pointer other)))

(defmethod MULT ((self TRANSFORM) (t1 TRANSFORM) (t2 TRANSFORM))
  (TRANSFORM/MULT (ff-pointer self) (ff-pointer t1) (ff-pointer t2)))

(shadow "()")
(defmethod |()| ((self TRANSFORM) (x VECTOR-3))
  (TRANSFORM///FUNCALL// (ff-pointer self) x))

(shadow "*")
(defmethod BULLET/* ((self TRANSFORM) (x VECTOR-3))
  (TRANSFORM/MULTIPLY (ff-pointer self) x))

(shadow "*")
(defmethod BULLET/* ((self TRANSFORM) (q QUATERNION))
  (TRANSFORM/MULTIPLY (ff-pointer self) q))

(defmethod BASIS ((self TRANSFORM))
  (TRANSFORM/GET-BASIS (ff-pointer self)))

(defmethod BASIS ((self TRANSFORM))
  (TRANSFORM/GET-BASIS (ff-pointer self)))

(defmethod ORIGIN ((self TRANSFORM))
  (TRANSFORM/GET-ORIGIN (ff-pointer self)))

(defmethod ORIGIN ((self TRANSFORM))
  (TRANSFORM/GET-ORIGIN (ff-pointer self)))

(defmethod ROTATION ((self TRANSFORM))
  (TRANSFORM/GET-ROTATION (ff-pointer self)))

(defmethod (SETF FROM-OPEN-GLMATRIX) ((self TRANSFORM) m)
  (TRANSFORM/SET-FROM-OPEN-GLMATRIX (ff-pointer self) m))

(defmethod OPEN-GLMATRIX ((self TRANSFORM) m)
  (TRANSFORM/GET-OPEN-GLMATRIX (ff-pointer self) m))

(defmethod (SETF ORIGIN) ((self TRANSFORM) (origin VECTOR-3))
  (TRANSFORM/SET-ORIGIN (ff-pointer self) origin))

(defmethod INV-XFORM ((self TRANSFORM) (inVec VECTOR-3))
  (TRANSFORM/INV-XFORM (ff-pointer self) inVec))

(defmethod (SETF BASIS) ((self TRANSFORM) (basis MATRIX-3X-3))
  (TRANSFORM/SET-BASIS (ff-pointer self) basis))

(defmethod (SETF ROTATION) ((self TRANSFORM) (q QUATERNION))
  (TRANSFORM/SET-ROTATION (ff-pointer self) q))

(defmethod (SETF BULLET/IDENTITY) ((self TRANSFORM))
  (TRANSFORM/SET-IDENTITY (ff-pointer self)))

(shadow "*=")
(defmethod *= ((self TRANSFORM) (t-arg1 TRANSFORM))
  (TRANSFORM/MULTIPLY-AND-ASSIGN (ff-pointer self) (ff-pointer t-arg1)))

(defmethod INVERSE ((self TRANSFORM))
  (TRANSFORM/INVERSE (ff-pointer self)))

(defmethod INVERSE-TIMES ((self TRANSFORM) (t-arg1 TRANSFORM))
  (TRANSFORM/INVERSE-TIMES (ff-pointer self) (ff-pointer t-arg1)))

(shadow "*")
(defmethod BULLET/* ((self TRANSFORM) (t-arg1 TRANSFORM))
  (TRANSFORM/MULTIPLY (ff-pointer self) (ff-pointer t-arg1)))

(defmethod SERIALIZE ((self TRANSFORM) dataOut)
  (TRANSFORM/SERIALIZE (ff-pointer self) dataOut))

(defmethod SERIALIZE-FLOAT ((self TRANSFORM) dataOut)
  (TRANSFORM/SERIALIZE-FLOAT (ff-pointer self) dataOut))

(defmethod DE-SERIALIZE ((self TRANSFORM) dataIn)
  (TRANSFORM/DE-SERIALIZE (ff-pointer self) dataIn))

(defmethod DE-SERIALIZE-DOUBLE ((self TRANSFORM) dataIn)
  (TRANSFORM/DE-SERIALIZE-DOUBLE (ff-pointer self) dataIn))

(defmethod DE-SERIALIZE-FLOAT ((self TRANSFORM) dataIn)
  (TRANSFORM/DE-SERIALIZE-FLOAT (ff-pointer self) dataIn))



(defmethod WORLD-TRANSFORM ((self MOTION-STATE) (worldTrans TRANSFORM))
  (MOTION-STATE/GET-WORLD-TRANSFORM (ff-pointer self) worldTrans))

(defmethod (SETF WORLD-TRANSFORM) ((self MOTION-STATE) (worldTrans TRANSFORM))
  (MOTION-STATE/SET-WORLD-TRANSFORM (ff-pointer self) worldTrans))

(defmethod DEBUG-DRAW-OBJECT ((self COLLISION-WORLD) (worldTransform TRANSFORM) shape (color VECTOR-3))  (COLLISION-WORLD/DEBUG-DRAW-OBJECT (ff-pointer self) worldTransform shape color))

(defmethod RAY-TEST ((self COLLISION-WORLD) (rayFromWorld VECTOR-3) (rayToWorld VECTOR-3) resultCallback)
  (COLLISION-WORLD/RAY-TEST (ff-pointer self) rayFromWorld rayToWorld resultCallback))

(defmethod NEW ((self COLLISION-OBJECT) sizeInBytes)
  (COLLISION-OBJECT/MAKE-CPLUS-PLUS-INSTANCE (ff-pointer self) sizeInBytes))

(defmethod BULLET/DELETE ((self COLLISION-OBJECT) ptr)
  (COLLISION-OBJECT/DELETE-CPLUS-PLUS-INSTANCE (ff-pointer self) ptr))

(defmethod NEW ((self COLLISION-OBJECT) arg1 ptr)
  (COLLISION-OBJECT/MAKE-CPLUS-PLUS-INSTANCE (ff-pointer self) arg1 ptr))

(defmethod BULLET/DELETE ((self COLLISION-OBJECT) arg1 arg2)
  (COLLISION-OBJECT/DELETE-CPLUS-PLUS-INSTANCE (ff-pointer self) arg1 arg2))

(shadow "new[]")
(defmethod NEW[] ((self COLLISION-OBJECT) sizeInBytes)
  (COLLISION-OBJECT/MAKE-CPLUS-ARRAY (ff-pointer self) sizeInBytes))

(shadow "delete[]")
(defmethod DELETE[] ((self COLLISION-OBJECT) ptr)
  (COLLISION-OBJECT/DELETE-CPLUS-ARRAY (ff-pointer self) ptr))

(shadow "new[]")
(defmethod NEW[] ((self COLLISION-OBJECT) arg1 ptr)
  (COLLISION-OBJECT/MAKE-CPLUS-ARRAY (ff-pointer self) arg1 ptr))

(shadow "delete[]")
(defmethod DELETE[] ((self COLLISION-OBJECT) arg1 arg2)
  (COLLISION-OBJECT/DELETE-CPLUS-ARRAY (ff-pointer self) arg1 arg2))

;; (defmethod (SETF ANISOTROPIC-FRICTION) ((self COLLISION-OBJECT) (anisotropicFriction VECTOR-3) (frictionMode integer))
;; (defmethod (SETF ANISOTROPIC-FRICTION) ((self COLLISION-OBJECT) (anisotropicFriction VECTOR-3))

;; (defmethod (SETF WORLD-TRANSFORM) ((self COLLISION-OBJECT) (worldTrans TRANSFORM))
(defmethod (SETF INTERPOLATION-WORLD-TRANSFORM) ((self COLLISION-OBJECT) (trans TRANSFORM))  (COLLISION-OBJECT/SET-INTERPOLATION-WORLD-TRANSFORM (ff-pointer self) trans))

(defmethod (SETF INTERPOLATION-LINEAR-VELOCITY) ((self COLLISION-OBJECT) (linvel VECTOR-3))  (COLLISION-OBJECT/SET-INTERPOLATION-WORLD-TRANSFORM (ff-pointer self) trans))

(defmethod (SETF INTERPOLATION-ANGULAR-VELOCITY) ((self COLLISION-OBJECT) (angvel VECTOR-3))
  (COLLISION-OBJECT/SET-INTERPOLATION-WORLD-TRANSFORM (ff-pointer self) trans))



(defmethod NEW ((self BOX-SHAPE) sizeInBytes)
  (BOX-SHAPE/MAKE-CPLUS-PLUS-INSTANCE (ff-pointer self) sizeInBytes))

(defmethod BULLET/DELETE ((self BOX-SHAPE) ptr)
  (BOX-SHAPE/DELETE-CPLUS-PLUS-INSTANCE (ff-pointer self) ptr))

(defmethod NEW ((self BOX-SHAPE) arg1 ptr)
  (BOX-SHAPE/MAKE-CPLUS-PLUS-INSTANCE (ff-pointer self) arg1 ptr))

(defmethod BULLET/DELETE ((self BOX-SHAPE) arg1 arg2)
  (BOX-SHAPE/DELETE-CPLUS-PLUS-INSTANCE (ff-pointer self) arg1 arg2))
(shadow "new[]")
(defmethod NEW[] ((self BOX-SHAPE) sizeInBytes)
  (BOX-SHAPE/MAKE-CPLUS-ARRAY (ff-pointer self) sizeInBytes))
(shadow "delete[]")
(defmethod DELETE[] ((self BOX-SHAPE) ptr)
  (BOX-SHAPE/DELETE-CPLUS-ARRAY (ff-pointer self) ptr))
(shadow "new[]")
(defmethod NEW[] ((self BOX-SHAPE) arg1 ptr)
  (BOX-SHAPE/MAKE-CPLUS-ARRAY (ff-pointer self) arg1 ptr))
(shadow "delete[]")
(defmethod DELETE[] ((self BOX-SHAPE) arg1 arg2)
  (BOX-SHAPE/DELETE-CPLUS-ARRAY (ff-pointer self) arg1 arg2))
(defmethod HALF-EXTENTS-WITH-MARGIN ((self BOX-SHAPE))
  (BOX-SHAPE/GET-HALF-EXTENTS-WITH-MARGIN (ff-pointer self)))
(defmethod HALF-EXTENTS-WITHOUT-MARGIN ((self BOX-SHAPE))
  (BOX-SHAPE/GET-HALF-EXTENTS-WITHOUT-MARGIN (ff-pointer self)))
(defmethod LOCAL-GET-SUPPORTING-VERTEX ((self BOX-SHAPE) (vec VECTOR-3))
  (BOX-SHAPE/LOCAL-GET-SUPPORTING-VERTEX (ff-pointer self) vec))
(defmethod LOCAL-GET-SUPPORTING-VERTEX-WITHOUT-MARGIN ((self BOX-SHAPE) (vec VECTOR-3))
  (BOX-SHAPE/LOCAL-GET-SUPPORTING-VERTEX-WITHOUT-MARGIN (ff-pointer self) vec))
(defmethod BATCHED-UNIT-VECTOR-GET-SUPPORTING-VERTEX-WITHOUT-MARGIN ((self BOX-SHAPE) (vectors VECTOR-3) (supportVerticesOut VECTOR-3) (numVectors integer))
  (BOX-SHAPE/BATCHED-UNIT-VECTOR-GET-SUPPORTING-VERTEX-WITHOUT-MARGIN (ff-pointer self) vectors supportVerticesOut numVectors))
(defmethod initialize-instance :after ((obj BOX-SHAPE) &key (boxHalfExtents VECTOR-3))
  (setf (slot-value obj 'ff-pointer) (MAKE-BOX-SHAPE boxHalfExtents)))
(defmethod (SETF MARGIN) ((self BOX-SHAPE) (collisionMargin number))
  (BOX-SHAPE/SET-MARGIN (ff-pointer self) collisionMargin))
(defmethod (SETF LOCAL-SCALING) ((self BOX-SHAPE) (scaling VECTOR-3))
  (BOX-SHAPE/SET-LOCAL-SCALING (ff-pointer self) scaling))
(defmethod AABB ((self BOX-SHAPE) (t-arg1 TRANSFORM) (aabbMin VECTOR-3) (aabbMax VECTOR-3))
  (BOX-SHAPE/GET-AABB (ff-pointer self) t-arg1 aabbMin aabbMax))
(defmethod CALCULATE-LOCAL-INERTIA ((self BOX-SHAPE) (mass number) (inertia VECTOR-3))
  (BOX-SHAPE/CALCULATE-LOCAL-INERTIA (ff-pointer self) mass inertia))
(defmethod PLANE ((self BOX-SHAPE) (planeNormal VECTOR-3) (planeSupport VECTOR-3) (i integer))
  (BOX-SHAPE/GET-PLANE (ff-pointer self) planeNormal planeSupport i))
(defmethod NUM-PLANES ((self BOX-SHAPE))
  (BOX-SHAPE/GET-NUM-PLANES (ff-pointer self)))
(defmethod NUM-VERTICES ((self BOX-SHAPE))
  (BOX-SHAPE/GET-NUM-VERTICES (ff-pointer self)))
(defmethod NUM-EDGES ((self BOX-SHAPE))
  (BOX-SHAPE/GET-NUM-EDGES (ff-pointer self)))
(defmethod VERTEX ((self BOX-SHAPE) (i integer) (vtx VECTOR-3))
  (BOX-SHAPE/GET-VERTEX (ff-pointer self) i vtx))
(defmethod PLANE-EQUATION ((self BOX-SHAPE) (plane VECTOR-4) (i integer))
  (BOX-SHAPE/GET-PLANE-EQUATION (ff-pointer self) plane i))
(defmethod EDGE ((self BOX-SHAPE) (i integer) (pa VECTOR-3) (pb VECTOR-3))
  (BOX-SHAPE/GET-EDGE (ff-pointer self) i pa pb))

(defmethod INSIDEP ((self BOX-SHAPE) (pt VECTOR-3) (tolerance number))
  (BOX-SHAPE/IS-INSIDE (ff-pointer self) pt tolerance))

(defmethod NAME ((self BOX-SHAPE))
  (BOX-SHAPE/GET-NAME (ff-pointer self)))

(defmethod NUM-PREFERRED-PENETRATION-DIRECTIONS ((self BOX-SHAPE))
  (BOX-SHAPE/GET-NUM-PREFERRED-PENETRATION-DIRECTIONS (ff-pointer self)))

(defmethod PREFERRED-PENETRATION-DIRECTION ((self BOX-SHAPE) (index integer) (penetrationVector VECTOR-3))
  (BOX-SHAPE/GET-PREFERRED-PENETRATION-DIRECTION (ff-pointer self) index penetrationVector))



(defmethod NEW ((self SPHERE-SHAPE) sizeInBytes)
  (SPHERE-SHAPE/MAKE-CPLUS-PLUS-INSTANCE (ff-pointer self) sizeInBytes))

(defmethod BULLET/DELETE ((self SPHERE-SHAPE) ptr)
  (SPHERE-SHAPE/DELETE-CPLUS-PLUS-INSTANCE (ff-pointer self) ptr))

(defmethod NEW ((self SPHERE-SHAPE) arg1 ptr)
  (SPHERE-SHAPE/MAKE-CPLUS-PLUS-INSTANCE (ff-pointer self) arg1 ptr))

(defmethod BULLET/DELETE ((self SPHERE-SHAPE) arg1 arg2)
  (SPHERE-SHAPE/DELETE-CPLUS-PLUS-INSTANCE (ff-pointer self) arg1 arg2))

(shadow "new[]")
(defmethod NEW[] ((self SPHERE-SHAPE) sizeInBytes)
  (SPHERE-SHAPE/MAKE-CPLUS-ARRAY (ff-pointer self) sizeInBytes))

(shadow "delete[]")
(defmethod DELETE[] ((self SPHERE-SHAPE) ptr)
  (SPHERE-SHAPE/DELETE-CPLUS-ARRAY (ff-pointer self) ptr))

(shadow "new[]")
(defmethod NEW[] ((self SPHERE-SHAPE) arg1 ptr)
  (SPHERE-SHAPE/MAKE-CPLUS-ARRAY (ff-pointer self) arg1 ptr))

(shadow "delete[]")
(defmethod DELETE[] ((self SPHERE-SHAPE) arg1 arg2)
  (SPHERE-SHAPE/DELETE-CPLUS-ARRAY (ff-pointer self) arg1 arg2))

(defmethod initialize-instance :after ((obj SPHERE-SHAPE) &key (radius number))
  (setf (slot-value obj 'ff-pointer) (MAKE-SPHERE-SHAPE radius)))

(defmethod LOCAL-GET-SUPPORTING-VERTEX ((self SPHERE-SHAPE) (vec VECTOR-3))
  (SPHERE-SHAPE/LOCAL-GET-SUPPORTING-VERTEX (ff-pointer self) vec))

(defmethod LOCAL-GET-SUPPORTING-VERTEX-WITHOUT-MARGIN ((self SPHERE-SHAPE) (vec VECTOR-3))
  (SPHERE-SHAPE/LOCAL-GET-SUPPORTING-VERTEX-WITHOUT-MARGIN (ff-pointer self) vec))

(defmethod BATCHED-UNIT-VECTOR-GET-SUPPORTING-VERTEX-WITHOUT-MARGIN ((self SPHERE-SHAPE) (vectors VECTOR-3) (supportVerticesOut VECTOR-3) (numVectors integer))
  (SPHERE-SHAPE/BATCHED-UNIT-VECTOR-GET-SUPPORTING-VERTEX-WITHOUT-MARGIN (ff-pointer self) vectors supportVerticesOut numVectors))

(defmethod CALCULATE-LOCAL-INERTIA ((self SPHERE-SHAPE) (mass number) (inertia VECTOR-3))
  (SPHERE-SHAPE/CALCULATE-LOCAL-INERTIA (ff-pointer self) mass inertia))

(defmethod AABB ((self SPHERE-SHAPE) (t-arg1 TRANSFORM) (aabbMin VECTOR-3) (aabbMax VECTOR-3))
  (SPHERE-SHAPE/GET-AABB (ff-pointer self) t-arg1 aabbMin aabbMax))

(defmethod RADIUS ((self SPHERE-SHAPE))
  (SPHERE-SHAPE/GET-RADIUS (ff-pointer self)))

(defmethod (SETF UNSCALED-RADIUS) ((self SPHERE-SHAPE) (radius number))
  (SPHERE-SHAPE/SET-UNSCALED-RADIUS (ff-pointer self) radius))

(defmethod NAME ((self SPHERE-SHAPE))
  (SPHERE-SHAPE/GET-NAME (ff-pointer self)))

(defmethod (SETF MARGIN) ((self SPHERE-SHAPE) (margin number))
  (SPHERE-SHAPE/SET-MARGIN (ff-pointer self) margin))

(defmethod MARGIN ((self SPHERE-SHAPE))
  (SPHERE-SHAPE/GET-MARGIN (ff-pointer self)))



(defmethod NEW ((self CAPSULE-SHAPE) sizeInBytes)
  (CAPSULE-SHAPE/MAKE-CPLUS-PLUS-INSTANCE (ff-pointer self) sizeInBytes))

(defmethod BULLET/DELETE ((self CAPSULE-SHAPE) ptr)
  (CAPSULE-SHAPE/DELETE-CPLUS-PLUS-INSTANCE (ff-pointer self) ptr))

(defmethod NEW ((self CAPSULE-SHAPE) arg1 ptr)
  (CAPSULE-SHAPE/MAKE-CPLUS-PLUS-INSTANCE (ff-pointer self) arg1 ptr))

(defmethod BULLET/DELETE ((self CAPSULE-SHAPE) arg1 arg2)
  (CAPSULE-SHAPE/DELETE-CPLUS-PLUS-INSTANCE (ff-pointer self) arg1 arg2))

(shadow "new[]")
(defmethod NEW[] ((self CAPSULE-SHAPE) sizeInBytes)
  (CAPSULE-SHAPE/MAKE-CPLUS-ARRAY (ff-pointer self) sizeInBytes))

(shadow "delete[]")
(defmethod DELETE[] ((self CAPSULE-SHAPE) ptr)
  (CAPSULE-SHAPE/DELETE-CPLUS-ARRAY (ff-pointer self) ptr))

(shadow "new[]")
(defmethod NEW[] ((self CAPSULE-SHAPE) arg1 ptr)
  (CAPSULE-SHAPE/MAKE-CPLUS-ARRAY (ff-pointer self) arg1 ptr))

(shadow "delete[]")
(defmethod DELETE[] ((self CAPSULE-SHAPE) arg1 arg2)
  (CAPSULE-SHAPE/DELETE-CPLUS-ARRAY (ff-pointer self) arg1 arg2))

(defmethod initialize-instance :after ((obj CAPSULE-SHAPE) &key (radius number) (height number))
  (setf (slot-value obj 'ff-pointer) (MAKE-CAPSULE-SHAPE radius height)))

(defmethod CALCULATE-LOCAL-INERTIA ((self CAPSULE-SHAPE) (mass number) (inertia VECTOR-3))
  (CAPSULE-SHAPE/CALCULATE-LOCAL-INERTIA (ff-pointer self) mass inertia))

(defmethod LOCAL-GET-SUPPORTING-VERTEX-WITHOUT-MARGIN ((self CAPSULE-SHAPE) (vec VECTOR-3))
  (CAPSULE-SHAPE/LOCAL-GET-SUPPORTING-VERTEX-WITHOUT-MARGIN (ff-pointer self) vec))

(defmethod BATCHED-UNIT-VECTOR-GET-SUPPORTING-VERTEX-WITHOUT-MARGIN ((self CAPSULE-SHAPE) (vectors VECTOR-3) (supportVerticesOut VECTOR-3) (numVectors integer))
  (CAPSULE-SHAPE/BATCHED-UNIT-VECTOR-GET-SUPPORTING-VERTEX-WITHOUT-MARGIN (ff-pointer self) vectors supportVerticesOut numVectors))

(defmethod (SETF MARGIN) ((self CAPSULE-SHAPE) (collisionMargin number))
  (CAPSULE-SHAPE/SET-MARGIN (ff-pointer self) collisionMargin))

(defmethod AABB ((self CAPSULE-SHAPE) (t-arg1 TRANSFORM) (aabbMin VECTOR-3) (aabbMax VECTOR-3))
  (CAPSULE-SHAPE/GET-AABB (ff-pointer self) t-arg1 aabbMin aabbMax))

(defmethod NAME ((self CAPSULE-SHAPE))
  (CAPSULE-SHAPE/GET-NAME (ff-pointer self)))

(defmethod UP-AXIS ((self CAPSULE-SHAPE))
  (CAPSULE-SHAPE/GET-UP-AXIS (ff-pointer self)))

(defmethod RADIUS ((self CAPSULE-SHAPE))
  (CAPSULE-SHAPE/GET-RADIUS (ff-pointer self)))

(defmethod HALF-HEIGHT ((self CAPSULE-SHAPE))
  (CAPSULE-SHAPE/GET-HALF-HEIGHT (ff-pointer self)))

(defmethod (SETF LOCAL-SCALING) ((self CAPSULE-SHAPE) (scaling VECTOR-3))
  (CAPSULE-SHAPE/SET-LOCAL-SCALING (ff-pointer self) scaling))

(defmethod ANISOTROPIC-ROLLING-FRICTION-DIRECTION ((self CAPSULE-SHAPE))
  (CAPSULE-SHAPE/GET-ANISOTROPIC-ROLLING-FRICTION-DIRECTION (ff-pointer self)))

(defmethod CALCULATE-SERIALIZE-BUFFER-SIZE ((self CAPSULE-SHAPE))
  (CAPSULE-SHAPE/CALCULATE-SERIALIZE-BUFFER-SIZE (ff-pointer self)))

(defmethod SERIALIZE ((self CAPSULE-SHAPE) dataBuffer serializer)
  (CAPSULE-SHAPE/SERIALIZE (ff-pointer self) dataBuffer serializer))



(defmethod initialize-instance :after ((obj CAPSULE-SHAPE-X) &key (radius number) (height number))
  (setf (slot-value obj 'ff-pointer) (MAKE-CAPSULE-SHAPE-X radius height)))

(defmethod NAME ((self CAPSULE-SHAPE-X))
  (CAPSULE-SHAPE-X/GET-NAME (ff-pointer self)))



(defmethod initialize-instance :after ((obj CAPSULE-SHAPE-Z) &key (radius number) (height number))
  (setf (slot-value obj 'ff-pointer) (MAKE-CAPSULE-SHAPE-Z radius height)))

(defmethod NAME ((self CAPSULE-SHAPE-Z))
  (CAPSULE-SHAPE-Z/GET-NAME (ff-pointer self)))



(defmethod NEW ((self CYLINDER-SHAPE) sizeInBytes)
  (CYLINDER-SHAPE/MAKE-CPLUS-PLUS-INSTANCE (ff-pointer self) sizeInBytes))

(defmethod BULLET/DELETE ((self CYLINDER-SHAPE) ptr)
  (CYLINDER-SHAPE/DELETE-CPLUS-PLUS-INSTANCE (ff-pointer self) ptr))

(defmethod NEW ((self CYLINDER-SHAPE) arg1 ptr)
  (CYLINDER-SHAPE/MAKE-CPLUS-PLUS-INSTANCE (ff-pointer self) arg1 ptr))

(defmethod BULLET/DELETE ((self CYLINDER-SHAPE) arg1 arg2)
  (CYLINDER-SHAPE/DELETE-CPLUS-PLUS-INSTANCE (ff-pointer self) arg1 arg2))

(shadow "new[]")
(defmethod NEW[] ((self CYLINDER-SHAPE) sizeInBytes)
  (CYLINDER-SHAPE/MAKE-CPLUS-ARRAY (ff-pointer self) sizeInBytes))

(shadow "delete[]")
(defmethod DELETE[] ((self CYLINDER-SHAPE) ptr)
  (CYLINDER-SHAPE/DELETE-CPLUS-ARRAY (ff-pointer self) ptr))

(shadow "new[]")
(defmethod NEW[] ((self CYLINDER-SHAPE) arg1 ptr)
  (CYLINDER-SHAPE/MAKE-CPLUS-ARRAY (ff-pointer self) arg1 ptr))

(shadow "delete[]")
(defmethod DELETE[] ((self CYLINDER-SHAPE) arg1 arg2)
  (CYLINDER-SHAPE/DELETE-CPLUS-ARRAY (ff-pointer self) arg1 arg2))

(defmethod HALF-EXTENTS-WITH-MARGIN ((self CYLINDER-SHAPE))
  (CYLINDER-SHAPE/GET-HALF-EXTENTS-WITH-MARGIN (ff-pointer self)))

(defmethod HALF-EXTENTS-WITHOUT-MARGIN ((self CYLINDER-SHAPE))
  (CYLINDER-SHAPE/GET-HALF-EXTENTS-WITHOUT-MARGIN (ff-pointer self)))

(defmethod initialize-instance :after ((obj CYLINDER-SHAPE) &key (halfExtents VECTOR-3))
  (setf (slot-value obj 'ff-pointer) (MAKE-CYLINDER-SHAPE halfExtents)))

(defmethod AABB ((self CYLINDER-SHAPE) (t-arg1 TRANSFORM) (aabbMin VECTOR-3) (aabbMax VECTOR-3))
  (CYLINDER-SHAPE/GET-AABB (ff-pointer self) t-arg1 aabbMin aabbMax))

(defmethod CALCULATE-LOCAL-INERTIA ((self CYLINDER-SHAPE) (mass number) (inertia VECTOR-3))
  (CYLINDER-SHAPE/CALCULATE-LOCAL-INERTIA (ff-pointer self) mass inertia))

(defmethod LOCAL-GET-SUPPORTING-VERTEX-WITHOUT-MARGIN ((self CYLINDER-SHAPE) (vec VECTOR-3))
  (CYLINDER-SHAPE/LOCAL-GET-SUPPORTING-VERTEX-WITHOUT-MARGIN (ff-pointer self) vec))

(defmethod BATCHED-UNIT-VECTOR-GET-SUPPORTING-VERTEX-WITHOUT-MARGIN ((self CYLINDER-SHAPE) (vectors VECTOR-3) (supportVerticesOut VECTOR-3) (numVectors integer))
  (CYLINDER-SHAPE/BATCHED-UNIT-VECTOR-GET-SUPPORTING-VERTEX-WITHOUT-MARGIN (ff-pointer self) vectors supportVerticesOut numVectors))

(defmethod (SETF MARGIN) ((self CYLINDER-SHAPE) (collisionMargin number))
  (CYLINDER-SHAPE/SET-MARGIN (ff-pointer self) collisionMargin))

(defmethod LOCAL-GET-SUPPORTING-VERTEX ((self CYLINDER-SHAPE) (vec VECTOR-3))
  (CYLINDER-SHAPE/LOCAL-GET-SUPPORTING-VERTEX (ff-pointer self) vec))

(defmethod UP-AXIS ((self CYLINDER-SHAPE))
  (CYLINDER-SHAPE/GET-UP-AXIS (ff-pointer self)))

(defmethod ANISOTROPIC-ROLLING-FRICTION-DIRECTION ((self CYLINDER-SHAPE))
  (CYLINDER-SHAPE/GET-ANISOTROPIC-ROLLING-FRICTION-DIRECTION (ff-pointer self)))

(defmethod RADIUS ((self CYLINDER-SHAPE))
  (CYLINDER-SHAPE/GET-RADIUS (ff-pointer self)))

(defmethod (SETF LOCAL-SCALING) ((self CYLINDER-SHAPE) (scaling VECTOR-3))
  (CYLINDER-SHAPE/SET-LOCAL-SCALING (ff-pointer self) scaling))

(defmethod NAME ((self CYLINDER-SHAPE))
  (CYLINDER-SHAPE/GET-NAME (ff-pointer self)))

(defmethod CALCULATE-SERIALIZE-BUFFER-SIZE ((self CYLINDER-SHAPE))
  (CYLINDER-SHAPE/CALCULATE-SERIALIZE-BUFFER-SIZE (ff-pointer self)))

(defmethod SERIALIZE ((self CYLINDER-SHAPE) dataBuffer serializer)
  (CYLINDER-SHAPE/SERIALIZE (ff-pointer self) dataBuffer serializer))



(defmethod NEW ((self CYLINDER-SHAPE-X) sizeInBytes)
  (CYLINDER-SHAPE-X/MAKE-CPLUS-PLUS-INSTANCE (ff-pointer self) sizeInBytes))

(defmethod BULLET/DELETE ((self CYLINDER-SHAPE-X) ptr)
  (CYLINDER-SHAPE-X/DELETE-CPLUS-PLUS-INSTANCE (ff-pointer self) ptr))

(defmethod NEW ((self CYLINDER-SHAPE-X) arg1 ptr)
  (CYLINDER-SHAPE-X/MAKE-CPLUS-PLUS-INSTANCE (ff-pointer self) arg1 ptr))

(defmethod BULLET/DELETE ((self CYLINDER-SHAPE-X) arg1 arg2)
  (CYLINDER-SHAPE-X/DELETE-CPLUS-PLUS-INSTANCE (ff-pointer self) arg1 arg2))

(shadow "new[]")
(defmethod NEW[] ((self CYLINDER-SHAPE-X) sizeInBytes)
  (CYLINDER-SHAPE-X/MAKE-CPLUS-ARRAY (ff-pointer self) sizeInBytes))

(shadow "delete[]")
(defmethod DELETE[] ((self CYLINDER-SHAPE-X) ptr)
  (CYLINDER-SHAPE-X/DELETE-CPLUS-ARRAY (ff-pointer self) ptr))

(shadow "new[]")
(defmethod NEW[] ((self CYLINDER-SHAPE-X) arg1 ptr)
  (CYLINDER-SHAPE-X/MAKE-CPLUS-ARRAY (ff-pointer self) arg1 ptr))

(shadow "delete[]")
(defmethod DELETE[] ((self CYLINDER-SHAPE-X) arg1 arg2)
  (CYLINDER-SHAPE-X/DELETE-CPLUS-ARRAY (ff-pointer self) arg1 arg2))

(defmethod initialize-instance :after ((obj CYLINDER-SHAPE-X) &key (halfExtents VECTOR-3))
  (setf (slot-value obj 'ff-pointer) (MAKE-CYLINDER-SHAPE-X halfExtents)))

(defmethod LOCAL-GET-SUPPORTING-VERTEX-WITHOUT-MARGIN ((self CYLINDER-SHAPE-X) (vec VECTOR-3))
  (CYLINDER-SHAPE-X/LOCAL-GET-SUPPORTING-VERTEX-WITHOUT-MARGIN (ff-pointer self) vec))

(defmethod BATCHED-UNIT-VECTOR-GET-SUPPORTING-VERTEX-WITHOUT-MARGIN ((self CYLINDER-SHAPE-X) (vectors VECTOR-3) (supportVerticesOut VECTOR-3) (numVectors integer))
  (CYLINDER-SHAPE-X/BATCHED-UNIT-VECTOR-GET-SUPPORTING-VERTEX-WITHOUT-MARGIN (ff-pointer self) vectors supportVerticesOut numVectors))

(defmethod NAME ((self CYLINDER-SHAPE-X))
  (CYLINDER-SHAPE-X/GET-NAME (ff-pointer self)))

(defmethod RADIUS ((self CYLINDER-SHAPE-X))
  (CYLINDER-SHAPE-X/GET-RADIUS (ff-pointer self)))



(defmethod NEW ((self CYLINDER-SHAPE-Z) sizeInBytes)
  (CYLINDER-SHAPE-Z/MAKE-CPLUS-PLUS-INSTANCE (ff-pointer self) sizeInBytes))

(defmethod BULLET/DELETE ((self CYLINDER-SHAPE-Z) ptr)
  (CYLINDER-SHAPE-Z/DELETE-CPLUS-PLUS-INSTANCE (ff-pointer self) ptr))

(defmethod NEW ((self CYLINDER-SHAPE-Z) arg1 ptr)
  (CYLINDER-SHAPE-Z/MAKE-CPLUS-PLUS-INSTANCE (ff-pointer self) arg1 ptr))

(defmethod BULLET/DELETE ((self CYLINDER-SHAPE-Z) arg1 arg2)
  (CYLINDER-SHAPE-Z/DELETE-CPLUS-PLUS-INSTANCE (ff-pointer self) arg1 arg2))

(shadow "new[]")
(defmethod NEW[] ((self CYLINDER-SHAPE-Z) sizeInBytes)
  (CYLINDER-SHAPE-Z/MAKE-CPLUS-ARRAY (ff-pointer self) sizeInBytes))

(shadow "delete[]")
(defmethod DELETE[] ((self CYLINDER-SHAPE-Z) ptr)
  (CYLINDER-SHAPE-Z/DELETE-CPLUS-ARRAY (ff-pointer self) ptr))

(shadow "new[]")
(defmethod NEW[] ((self CYLINDER-SHAPE-Z) arg1 ptr)
  (CYLINDER-SHAPE-Z/MAKE-CPLUS-ARRAY (ff-pointer self) arg1 ptr))

(shadow "delete[]")
(defmethod DELETE[] ((self CYLINDER-SHAPE-Z) arg1 arg2)
  (CYLINDER-SHAPE-Z/DELETE-CPLUS-ARRAY (ff-pointer self) arg1 arg2))

(defmethod initialize-instance :after ((obj CYLINDER-SHAPE-Z) &key (halfExtents VECTOR-3))
  (setf (slot-value obj 'ff-pointer) (MAKE-CYLINDER-SHAPE-Z halfExtents)))

(defmethod LOCAL-GET-SUPPORTING-VERTEX-WITHOUT-MARGIN ((self CYLINDER-SHAPE-Z) (vec VECTOR-3))
  (CYLINDER-SHAPE-Z/LOCAL-GET-SUPPORTING-VERTEX-WITHOUT-MARGIN (ff-pointer self) vec))

(defmethod BATCHED-UNIT-VECTOR-GET-SUPPORTING-VERTEX-WITHOUT-MARGIN ((self CYLINDER-SHAPE-Z) (vectors VECTOR-3) (supportVerticesOut VECTOR-3) (numVectors integer))
  (CYLINDER-SHAPE-Z/BATCHED-UNIT-VECTOR-GET-SUPPORTING-VERTEX-WITHOUT-MARGIN (ff-pointer self) vectors supportVerticesOut numVectors))

(defmethod NAME ((self CYLINDER-SHAPE-Z))
  (CYLINDER-SHAPE-Z/GET-NAME (ff-pointer self)))

(defmethod RADIUS ((self CYLINDER-SHAPE-Z))
  (CYLINDER-SHAPE-Z/GET-RADIUS (ff-pointer self)))



(defmethod NEW ((self CONE-SHAPE) sizeInBytes)
  (CONE-SHAPE/MAKE-CPLUS-PLUS-INSTANCE (ff-pointer self) sizeInBytes))

(defmethod BULLET/DELETE ((self CONE-SHAPE) ptr)
  (CONE-SHAPE/DELETE-CPLUS-PLUS-INSTANCE (ff-pointer self) ptr))

(defmethod NEW ((self CONE-SHAPE) arg1 ptr)
  (CONE-SHAPE/MAKE-CPLUS-PLUS-INSTANCE (ff-pointer self) arg1 ptr))

(defmethod BULLET/DELETE ((self CONE-SHAPE) arg1 arg2)
  (CONE-SHAPE/DELETE-CPLUS-PLUS-INSTANCE (ff-pointer self) arg1 arg2))

(shadow "new[]")
(defmethod NEW[] ((self CONE-SHAPE) sizeInBytes)
  (CONE-SHAPE/MAKE-CPLUS-ARRAY (ff-pointer self) sizeInBytes))

(shadow "delete[]")
(defmethod DELETE[] ((self CONE-SHAPE) ptr)
  (CONE-SHAPE/DELETE-CPLUS-ARRAY (ff-pointer self) ptr))

(shadow "new[]")
(defmethod NEW[] ((self CONE-SHAPE) arg1 ptr)
  (CONE-SHAPE/MAKE-CPLUS-ARRAY (ff-pointer self) arg1 ptr))

(shadow "delete[]")
(defmethod DELETE[] ((self CONE-SHAPE) arg1 arg2)
  (CONE-SHAPE/DELETE-CPLUS-ARRAY (ff-pointer self) arg1 arg2))

(defmethod initialize-instance :after ((obj CONE-SHAPE) &key (radius number) (height number))
  (setf (slot-value obj 'ff-pointer) (MAKE-CONE-SHAPE radius height)))

(defmethod LOCAL-GET-SUPPORTING-VERTEX ((self CONE-SHAPE) (vec VECTOR-3))
  (CONE-SHAPE/LOCAL-GET-SUPPORTING-VERTEX (ff-pointer self) vec))

(defmethod LOCAL-GET-SUPPORTING-VERTEX-WITHOUT-MARGIN ((self CONE-SHAPE) (vec VECTOR-3))
  (CONE-SHAPE/LOCAL-GET-SUPPORTING-VERTEX-WITHOUT-MARGIN (ff-pointer self) vec))

(defmethod BATCHED-UNIT-VECTOR-GET-SUPPORTING-VERTEX-WITHOUT-MARGIN ((self CONE-SHAPE) (vectors VECTOR-3) (supportVerticesOut VECTOR-3) (numVectors integer))
  (CONE-SHAPE/BATCHED-UNIT-VECTOR-GET-SUPPORTING-VERTEX-WITHOUT-MARGIN (ff-pointer self) vectors supportVerticesOut numVectors))

(defmethod RADIUS ((self CONE-SHAPE))
  (CONE-SHAPE/GET-RADIUS (ff-pointer self)))

(defmethod HEIGHT ((self CONE-SHAPE))
  (CONE-SHAPE/GET-HEIGHT (ff-pointer self)))

(defmethod CALCULATE-LOCAL-INERTIA ((self CONE-SHAPE) (mass number) (inertia VECTOR-3))
  (CONE-SHAPE/CALCULATE-LOCAL-INERTIA (ff-pointer self) mass inertia))

(defmethod NAME ((self CONE-SHAPE))
  (CONE-SHAPE/GET-NAME (ff-pointer self)))

(defmethod (SETF CONE-UP-INDEX) ((self CONE-SHAPE) (upIndex integer))
  (CONE-SHAPE/SET-CONE-UP-INDEX (ff-pointer self) upIndex))

(defmethod CONE-UP-INDEX ((self CONE-SHAPE))
  (CONE-SHAPE/GET-CONE-UP-INDEX (ff-pointer self)))

(defmethod ANISOTROPIC-ROLLING-FRICTION-DIRECTION ((self CONE-SHAPE))
  (CONE-SHAPE/GET-ANISOTROPIC-ROLLING-FRICTION-DIRECTION (ff-pointer self)))

(defmethod (SETF LOCAL-SCALING) ((self CONE-SHAPE) (scaling VECTOR-3))
  (CONE-SHAPE/SET-LOCAL-SCALING (ff-pointer self) scaling))

(defmethod CALCULATE-SERIALIZE-BUFFER-SIZE ((self CONE-SHAPE))
  (CONE-SHAPE/CALCULATE-SERIALIZE-BUFFER-SIZE (ff-pointer self)))

(defmethod SERIALIZE ((self CONE-SHAPE) dataBuffer serializer)
  (CONE-SHAPE/SERIALIZE (ff-pointer self) dataBuffer serializer))



(defmethod initialize-instance :after ((obj CONE-SHAPE-X) &key (radius number) (height number))
  (setf (slot-value obj 'ff-pointer) (MAKE-CONE-SHAPE-X radius height)))

(defmethod ANISOTROPIC-ROLLING-FRICTION-DIRECTION ((self CONE-SHAPE-X))
  (CONE-SHAPE-X/GET-ANISOTROPIC-ROLLING-FRICTION-DIRECTION (ff-pointer self)))

(defmethod NAME ((self CONE-SHAPE-X))
  (CONE-SHAPE-X/GET-NAME (ff-pointer self)))



(defmethod initialize-instance :after ((obj CONE-SHAPE-Z) &key (radius number) (height number))
  (setf (slot-value obj 'ff-pointer) (MAKE-CONE-SHAPE-Z radius height)))

(defmethod ANISOTROPIC-ROLLING-FRICTION-DIRECTION ((self CONE-SHAPE-Z))
  (CONE-SHAPE-Z/GET-ANISOTROPIC-ROLLING-FRICTION-DIRECTION (ff-pointer self)))

(defmethod NAME ((self CONE-SHAPE-Z))
  (CONE-SHAPE-Z/GET-NAME (ff-pointer self)))



(defmethod NEW ((self STATIC-PLANE-SHAPE) sizeInBytes)
  (STATIC-PLANE-SHAPE/MAKE-CPLUS-PLUS-INSTANCE (ff-pointer self) sizeInBytes))

(defmethod BULLET/DELETE ((self STATIC-PLANE-SHAPE) ptr)
  (STATIC-PLANE-SHAPE/DELETE-CPLUS-PLUS-INSTANCE (ff-pointer self) ptr))

(defmethod NEW ((self STATIC-PLANE-SHAPE) arg1 ptr)
  (STATIC-PLANE-SHAPE/MAKE-CPLUS-PLUS-INSTANCE (ff-pointer self) arg1 ptr))

(defmethod BULLET/DELETE ((self STATIC-PLANE-SHAPE) arg1 arg2)
  (STATIC-PLANE-SHAPE/DELETE-CPLUS-PLUS-INSTANCE (ff-pointer self) arg1 arg2))

(shadow "new[]")
(defmethod NEW[] ((self STATIC-PLANE-SHAPE) sizeInBytes)
  (STATIC-PLANE-SHAPE/MAKE-CPLUS-ARRAY (ff-pointer self) sizeInBytes))

(shadow "delete[]")
(defmethod DELETE[] ((self STATIC-PLANE-SHAPE) ptr)
  (STATIC-PLANE-SHAPE/DELETE-CPLUS-ARRAY (ff-pointer self) ptr))

(shadow "new[]")
(defmethod NEW[] ((self STATIC-PLANE-SHAPE) arg1 ptr)
  (STATIC-PLANE-SHAPE/MAKE-CPLUS-ARRAY (ff-pointer self) arg1 ptr))

(shadow "delete[]")
(defmethod DELETE[] ((self STATIC-PLANE-SHAPE) arg1 arg2)
  (STATIC-PLANE-SHAPE/DELETE-CPLUS-ARRAY (ff-pointer self) arg1 arg2))

(defmethod initialize-instance :after ((obj STATIC-PLANE-SHAPE) &key (planeNormal VECTOR-3) (planeConstant number))
  (setf (slot-value obj 'ff-pointer) (MAKE-STATIC-PLANE-SHAPE planeNormal planeConstant)))

(defmethod AABB ((self STATIC-PLANE-SHAPE) (t-arg1 TRANSFORM) (aabbMin VECTOR-3) (aabbMax VECTOR-3))
  (STATIC-PLANE-SHAPE/GET-AABB (ff-pointer self) t-arg1 aabbMin aabbMax))

(defmethod PROCESS-ALL-TRIANGLES ((self STATIC-PLANE-SHAPE) callback (aabbMin VECTOR-3) (aabbMax VECTOR-3))
  (STATIC-PLANE-SHAPE/PROCESS-ALL-TRIANGLES (ff-pointer self) callback aabbMin aabbMax))

(defmethod CALCULATE-LOCAL-INERTIA ((self STATIC-PLANE-SHAPE) (mass number) (inertia VECTOR-3))
  (STATIC-PLANE-SHAPE/CALCULATE-LOCAL-INERTIA (ff-pointer self) mass inertia))

(defmethod (SETF LOCAL-SCALING) ((self STATIC-PLANE-SHAPE) (scaling VECTOR-3))
  (STATIC-PLANE-SHAPE/SET-LOCAL-SCALING (ff-pointer self) scaling))

(defmethod LOCAL-SCALING ((self STATIC-PLANE-SHAPE))
  (STATIC-PLANE-SHAPE/GET-LOCAL-SCALING (ff-pointer self)))

(defmethod PLANE-NORMAL ((self STATIC-PLANE-SHAPE))
  (STATIC-PLANE-SHAPE/GET-PLANE-NORMAL (ff-pointer self)))

(defmethod PLANE-CONSTANT ((self STATIC-PLANE-SHAPE))
  (STATIC-PLANE-SHAPE/GET-PLANE-CONSTANT (ff-pointer self)))

(defmethod NAME ((self STATIC-PLANE-SHAPE))
  (STATIC-PLANE-SHAPE/GET-NAME (ff-pointer self)))

(defmethod CALCULATE-SERIALIZE-BUFFER-SIZE ((self STATIC-PLANE-SHAPE))
  (STATIC-PLANE-SHAPE/CALCULATE-SERIALIZE-BUFFER-SIZE (ff-pointer self)))

(defmethod SERIALIZE ((self STATIC-PLANE-SHAPE) dataBuffer serializer)
  (STATIC-PLANE-SHAPE/SERIALIZE (ff-pointer self) dataBuffer serializer))



(defmethod NEW ((self CONVEX-HULL-SHAPE) sizeInBytes)
  (CONVEX-HULL-SHAPE/MAKE-CPLUS-PLUS-INSTANCE (ff-pointer self) sizeInBytes))

(defmethod BULLET/DELETE ((self CONVEX-HULL-SHAPE) ptr)
  (CONVEX-HULL-SHAPE/DELETE-CPLUS-PLUS-INSTANCE (ff-pointer self) ptr))

(defmethod NEW ((self CONVEX-HULL-SHAPE) arg1 ptr)
  (CONVEX-HULL-SHAPE/MAKE-CPLUS-PLUS-INSTANCE (ff-pointer self) arg1 ptr))

(defmethod BULLET/DELETE ((self CONVEX-HULL-SHAPE) arg1 arg2)
  (CONVEX-HULL-SHAPE/DELETE-CPLUS-PLUS-INSTANCE (ff-pointer self) arg1 arg2))

(shadow "new[]")
(defmethod NEW[] ((self CONVEX-HULL-SHAPE) sizeInBytes)
  (CONVEX-HULL-SHAPE/MAKE-CPLUS-ARRAY (ff-pointer self) sizeInBytes))

(shadow "delete[]")
(defmethod DELETE[] ((self CONVEX-HULL-SHAPE) ptr)
  (CONVEX-HULL-SHAPE/DELETE-CPLUS-ARRAY (ff-pointer self) ptr))

(shadow "new[]")
(defmethod NEW[] ((self CONVEX-HULL-SHAPE) arg1 ptr)
  (CONVEX-HULL-SHAPE/MAKE-CPLUS-ARRAY (ff-pointer self) arg1 ptr))

(shadow "delete[]")
(defmethod DELETE[] ((self CONVEX-HULL-SHAPE) arg1 arg2)
  (CONVEX-HULL-SHAPE/DELETE-CPLUS-ARRAY (ff-pointer self) arg1 arg2))

(defmethod initialize-instance :after ((obj CONVEX-HULL-SHAPE) &key points (numPoints integer) (stride integer))
  (setf (slot-value obj 'ff-pointer) (MAKE-CONVEX-HULL-SHAPE points numPoints stride)))

(defmethod initialize-instance :after ((obj CONVEX-HULL-SHAPE) &key points (numPoints integer))
  (setf (slot-value obj 'ff-pointer) (MAKE-CONVEX-HULL-SHAPE points numPoints)))

(defmethod initialize-instance :after ((obj CONVEX-HULL-SHAPE) &key points)
  (setf (slot-value obj 'ff-pointer) (MAKE-CONVEX-HULL-SHAPE points)))

(defmethod initialize-instance :after ((obj CONVEX-HULL-SHAPE) &key)
  (setf (slot-value obj 'ff-pointer) (MAKE-CONVEX-HULL-SHAPE)))

(defmethod ADD-POINT ((self CONVEX-HULL-SHAPE) (point VECTOR-3) (recalculateLocalAabb t))
  (CONVEX-HULL-SHAPE/ADD-POINT (ff-pointer self) point recalculateLocalAabb))

(defmethod ADD-POINT ((self CONVEX-HULL-SHAPE) (point VECTOR-3))
  (CONVEX-HULL-SHAPE/ADD-POINT (ff-pointer self) point))

(defmethod UNSCALED-POINTS ((self CONVEX-HULL-SHAPE))
  (CONVEX-HULL-SHAPE/GET-UNSCALED-POINTS (ff-pointer self)))

(defmethod UNSCALED-POINTS ((self CONVEX-HULL-SHAPE))
  (CONVEX-HULL-SHAPE/GET-UNSCALED-POINTS (ff-pointer self)))

(defmethod POINTS ((self CONVEX-HULL-SHAPE))
  (CONVEX-HULL-SHAPE/GET-POINTS (ff-pointer self)))

(defmethod SCALED-POINT ((self CONVEX-HULL-SHAPE) (i integer))
  (CONVEX-HULL-SHAPE/GET-SCALED-POINT (ff-pointer self) i))

(defmethod NUM-POINTS ((self CONVEX-HULL-SHAPE))
  (CONVEX-HULL-SHAPE/GET-NUM-POINTS (ff-pointer self)))

(defmethod LOCAL-GET-SUPPORTING-VERTEX ((self CONVEX-HULL-SHAPE) (vec VECTOR-3))
  (CONVEX-HULL-SHAPE/LOCAL-GET-SUPPORTING-VERTEX (ff-pointer self) vec))

(defmethod LOCAL-GET-SUPPORTING-VERTEX-WITHOUT-MARGIN ((self CONVEX-HULL-SHAPE) (vec VECTOR-3))
  (CONVEX-HULL-SHAPE/LOCAL-GET-SUPPORTING-VERTEX-WITHOUT-MARGIN (ff-pointer self) vec))

(defmethod BATCHED-UNIT-VECTOR-GET-SUPPORTING-VERTEX-WITHOUT-MARGIN ((self CONVEX-HULL-SHAPE) (vectors VECTOR-3) (supportVerticesOut VECTOR-3) (numVectors integer))
  (CONVEX-HULL-SHAPE/BATCHED-UNIT-VECTOR-GET-SUPPORTING-VERTEX-WITHOUT-MARGIN (ff-pointer self) vectors supportVerticesOut numVectors))

(defmethod PROJECT ((self CONVEX-HULL-SHAPE) (trans TRANSFORM) (dir VECTOR-3) minProj maxProj (witnesPtMin VECTOR-3) (witnesPtMax VECTOR-3))
  (CONVEX-HULL-SHAPE/PROJECT (ff-pointer self) trans dir minProj maxProj witnesPtMin witnesPtMax))

(defmethod NAME ((self CONVEX-HULL-SHAPE))
  (CONVEX-HULL-SHAPE/GET-NAME (ff-pointer self)))

(defmethod NUM-VERTICES ((self CONVEX-HULL-SHAPE))
  (CONVEX-HULL-SHAPE/GET-NUM-VERTICES (ff-pointer self)))

(defmethod NUM-EDGES ((self CONVEX-HULL-SHAPE))
  (CONVEX-HULL-SHAPE/GET-NUM-EDGES (ff-pointer self)))

(defmethod EDGE ((self CONVEX-HULL-SHAPE) (i integer) (pa VECTOR-3) (pb VECTOR-3))
  (CONVEX-HULL-SHAPE/GET-EDGE (ff-pointer self) i pa pb))

(defmethod VERTEX ((self CONVEX-HULL-SHAPE) (i integer) (vtx VECTOR-3))
  (CONVEX-HULL-SHAPE/GET-VERTEX (ff-pointer self) i vtx))

(defmethod NUM-PLANES ((self CONVEX-HULL-SHAPE))
  (CONVEX-HULL-SHAPE/GET-NUM-PLANES (ff-pointer self)))

(defmethod PLANE ((self CONVEX-HULL-SHAPE) (planeNormal VECTOR-3) (planeSupport VECTOR-3) (i integer))
  (CONVEX-HULL-SHAPE/GET-PLANE (ff-pointer self) planeNormal planeSupport i))

(defmethod INSIDEP ((self CONVEX-HULL-SHAPE) (pt VECTOR-3) (tolerance number))
  (CONVEX-HULL-SHAPE/IS-INSIDE (ff-pointer self) pt tolerance))

(defmethod (SETF LOCAL-SCALING) ((self CONVEX-HULL-SHAPE) (scaling VECTOR-3))
  (CONVEX-HULL-SHAPE/SET-LOCAL-SCALING (ff-pointer self) scaling))

(defmethod CALCULATE-SERIALIZE-BUFFER-SIZE ((self CONVEX-HULL-SHAPE))
  (CONVEX-HULL-SHAPE/CALCULATE-SERIALIZE-BUFFER-SIZE (ff-pointer self)))

(defmethod SERIALIZE ((self CONVEX-HULL-SHAPE) dataBuffer serializer)
  (CONVEX-HULL-SHAPE/SERIALIZE (ff-pointer self) dataBuffer serializer))



(defmethod (setf WELDING-THRESHOLD) (arg0 (obj TRIANGLE-MESH))
  (TRIANGLE-MESH/M/WELDING-THRESHOLD/SET (ff-pointer obj) arg0))

(defmethod WELDING-THRESHOLD ((obj TRIANGLE-MESH))
  (TRIANGLE-MESH/M/WELDING-THRESHOLD/GET (ff-pointer obj)))

(defmethod initialize-instance :after ((obj TRIANGLE-MESH) &key (use32bitIndices t) (use4componentVertices t))
  (setf (slot-value obj 'ff-pointer) (MAKE-TRIANGLE-MESH use32bitIndices use4componentVertices)))

(defmethod initialize-instance :after ((obj TRIANGLE-MESH) &key (use32bitIndices t))
  (setf (slot-value obj 'ff-pointer) (MAKE-TRIANGLE-MESH use32bitIndices)))

(defmethod initialize-instance :after ((obj TRIANGLE-MESH) &key)
  (setf (slot-value obj 'ff-pointer) (MAKE-TRIANGLE-MESH)))

(defmethod USE-32BIT-INDICES ((self TRIANGLE-MESH))
  (TRIANGLE-MESH/GET-USE-32BIT-INDICES (ff-pointer self)))

(defmethod USE-4COMPONENT-VERTICES ((self TRIANGLE-MESH))
  (TRIANGLE-MESH/GET-USE-4COMPONENT-VERTICES (ff-pointer self)))

(defmethod ADD-TRIANGLE ((self TRIANGLE-MESH) (vertex0 VECTOR-3) (vertex1 VECTOR-3) (vertex2 VECTOR-3) (removeDuplicateVertices t))
  (TRIANGLE-MESH/ADD-TRIANGLE (ff-pointer self) vertex0 vertex1 vertex2 removeDuplicateVertices))

(defmethod ADD-TRIANGLE ((self TRIANGLE-MESH) (vertex0 VECTOR-3) (vertex1 VECTOR-3) (vertex2 VECTOR-3))
  (TRIANGLE-MESH/ADD-TRIANGLE (ff-pointer self) vertex0 vertex1 vertex2))

(defmethod NUM-TRIANGLES ((self TRIANGLE-MESH))
  (TRIANGLE-MESH/GET-NUM-TRIANGLES (ff-pointer self)))

(defmethod PREALLOCATE-VERTICES ((self TRIANGLE-MESH) (numverts integer))
  (TRIANGLE-MESH/PREALLOCATE-VERTICES (ff-pointer self) numverts))

(defmethod PREALLOCATE-INDICES ((self TRIANGLE-MESH) (numindices integer))
  (TRIANGLE-MESH/PREALLOCATE-INDICES (ff-pointer self) numindices))

(defmethod FIND-OR-ADD-VERTEX ((self TRIANGLE-MESH) (vertex VECTOR-3) (removeDuplicateVertices t))
  (TRIANGLE-MESH/FIND-OR-ADD-VERTEX (ff-pointer self) vertex removeDuplicateVertices))

(defmethod ADD-INDEX ((self TRIANGLE-MESH) (index integer))
  (TRIANGLE-MESH/ADD-INDEX (ff-pointer self) index))



(defmethod NEW ((self CONVEX-TRIANGLE-MESH-SHAPE) sizeInBytes)
  (CONVEX-TRIANGLE-MESH-SHAPE/MAKE-CPLUS-PLUS-INSTANCE (ff-pointer self) sizeInBytes))

(defmethod BULLET/DELETE ((self CONVEX-TRIANGLE-MESH-SHAPE) ptr)
  (CONVEX-TRIANGLE-MESH-SHAPE/DELETE-CPLUS-PLUS-INSTANCE (ff-pointer self) ptr))

(defmethod NEW ((self CONVEX-TRIANGLE-MESH-SHAPE) arg1 ptr)
  (CONVEX-TRIANGLE-MESH-SHAPE/MAKE-CPLUS-PLUS-INSTANCE (ff-pointer self) arg1 ptr))

(defmethod BULLET/DELETE ((self CONVEX-TRIANGLE-MESH-SHAPE) arg1 arg2)
  (CONVEX-TRIANGLE-MESH-SHAPE/DELETE-CPLUS-PLUS-INSTANCE (ff-pointer self) arg1 arg2))

(shadow "new[]")
(defmethod NEW[] ((self CONVEX-TRIANGLE-MESH-SHAPE) sizeInBytes)
  (CONVEX-TRIANGLE-MESH-SHAPE/MAKE-CPLUS-ARRAY (ff-pointer self) sizeInBytes))

(shadow "delete[]")
(defmethod DELETE[] ((self CONVEX-TRIANGLE-MESH-SHAPE) ptr)
  (CONVEX-TRIANGLE-MESH-SHAPE/DELETE-CPLUS-ARRAY (ff-pointer self) ptr))

(shadow "new[]")
(defmethod NEW[] ((self CONVEX-TRIANGLE-MESH-SHAPE) arg1 ptr)
  (CONVEX-TRIANGLE-MESH-SHAPE/MAKE-CPLUS-ARRAY (ff-pointer self) arg1 ptr))

(shadow "delete[]")
(defmethod DELETE[] ((self CONVEX-TRIANGLE-MESH-SHAPE) arg1 arg2)
  (CONVEX-TRIANGLE-MESH-SHAPE/DELETE-CPLUS-ARRAY (ff-pointer self) arg1 arg2))

(defmethod initialize-instance :after ((obj CONVEX-TRIANGLE-MESH-SHAPE) &key meshInterface (calcAabb t))
  (setf (slot-value obj 'ff-pointer) (MAKE-CONVEX-TRIANGLE-MESH-SHAPE meshInterface calcAabb)))

(defmethod initialize-instance :after ((obj CONVEX-TRIANGLE-MESH-SHAPE) &key meshInterface)
  (setf (slot-value obj 'ff-pointer) (MAKE-CONVEX-TRIANGLE-MESH-SHAPE meshInterface)))

(defmethod MESH-INTERFACE ((self CONVEX-TRIANGLE-MESH-SHAPE))
  (CONVEX-TRIANGLE-MESH-SHAPE/GET-MESH-INTERFACE (ff-pointer self)))

(defmethod MESH-INTERFACE ((self CONVEX-TRIANGLE-MESH-SHAPE))
  (CONVEX-TRIANGLE-MESH-SHAPE/GET-MESH-INTERFACE (ff-pointer self)))

(defmethod LOCAL-GET-SUPPORTING-VERTEX ((self CONVEX-TRIANGLE-MESH-SHAPE) (vec VECTOR-3))
  (CONVEX-TRIANGLE-MESH-SHAPE/LOCAL-GET-SUPPORTING-VERTEX (ff-pointer self) vec))

(defmethod LOCAL-GET-SUPPORTING-VERTEX-WITHOUT-MARGIN ((self CONVEX-TRIANGLE-MESH-SHAPE) (vec VECTOR-3))
  (CONVEX-TRIANGLE-MESH-SHAPE/LOCAL-GET-SUPPORTING-VERTEX-WITHOUT-MARGIN (ff-pointer self) vec))

(defmethod BATCHED-UNIT-VECTOR-GET-SUPPORTING-VERTEX-WITHOUT-MARGIN ((self CONVEX-TRIANGLE-MESH-SHAPE) (vectors VECTOR-3) (supportVerticesOut VECTOR-3) (numVectors integer))
  (CONVEX-TRIANGLE-MESH-SHAPE/BATCHED-UNIT-VECTOR-GET-SUPPORTING-VERTEX-WITHOUT-MARGIN (ff-pointer self) vectors supportVerticesOut numVectors))

(defmethod NAME ((self CONVEX-TRIANGLE-MESH-SHAPE))
  (CONVEX-TRIANGLE-MESH-SHAPE/GET-NAME (ff-pointer self)))

(defmethod NUM-VERTICES ((self CONVEX-TRIANGLE-MESH-SHAPE))
  (CONVEX-TRIANGLE-MESH-SHAPE/GET-NUM-VERTICES (ff-pointer self)))

(defmethod NUM-EDGES ((self CONVEX-TRIANGLE-MESH-SHAPE))
  (CONVEX-TRIANGLE-MESH-SHAPE/GET-NUM-EDGES (ff-pointer self)))

(defmethod EDGE ((self CONVEX-TRIANGLE-MESH-SHAPE) (i integer) (pa VECTOR-3) (pb VECTOR-3))
  (CONVEX-TRIANGLE-MESH-SHAPE/GET-EDGE (ff-pointer self) i pa pb))

(defmethod VERTEX ((self CONVEX-TRIANGLE-MESH-SHAPE) (i integer) (vtx VECTOR-3))
  (CONVEX-TRIANGLE-MESH-SHAPE/GET-VERTEX (ff-pointer self) i vtx))

(defmethod NUM-PLANES ((self CONVEX-TRIANGLE-MESH-SHAPE))
  (CONVEX-TRIANGLE-MESH-SHAPE/GET-NUM-PLANES (ff-pointer self)))

(defmethod PLANE ((self CONVEX-TRIANGLE-MESH-SHAPE) (planeNormal VECTOR-3) (planeSupport VECTOR-3) (i integer))
  (CONVEX-TRIANGLE-MESH-SHAPE/GET-PLANE (ff-pointer self) planeNormal planeSupport i))

(defmethod INSIDEP ((self CONVEX-TRIANGLE-MESH-SHAPE) (pt VECTOR-3) (tolerance number))
  (CONVEX-TRIANGLE-MESH-SHAPE/IS-INSIDE (ff-pointer self) pt tolerance))

(defmethod (SETF LOCAL-SCALING) ((self CONVEX-TRIANGLE-MESH-SHAPE) (scaling VECTOR-3))
  (CONVEX-TRIANGLE-MESH-SHAPE/SET-LOCAL-SCALING (ff-pointer self) scaling))

(defmethod LOCAL-SCALING ((self CONVEX-TRIANGLE-MESH-SHAPE))
  (CONVEX-TRIANGLE-MESH-SHAPE/GET-LOCAL-SCALING (ff-pointer self)))

(defmethod CALCULATE-PRINCIPAL-AXIS-TRANSFORM ((self CONVEX-TRIANGLE-MESH-SHAPE) (principal TRANSFORM) (inertia VECTOR-3) volume)
  (CONVEX-TRIANGLE-MESH-SHAPE/CALCULATE-PRINCIPAL-AXIS-TRANSFORM (ff-pointer self) principal inertia volume))



(defmethod NEW ((self BVH-TRIANGLE-MESH-SHAPE) sizeInBytes)
  (BVH-TRIANGLE-MESH-SHAPE/MAKE-CPLUS-PLUS-INSTANCE (ff-pointer self) sizeInBytes))

(defmethod BULLET/DELETE ((self BVH-TRIANGLE-MESH-SHAPE) ptr)
  (BVH-TRIANGLE-MESH-SHAPE/DELETE-CPLUS-PLUS-INSTANCE (ff-pointer self) ptr))

(defmethod NEW ((self BVH-TRIANGLE-MESH-SHAPE) arg1 ptr)
  (BVH-TRIANGLE-MESH-SHAPE/MAKE-CPLUS-PLUS-INSTANCE (ff-pointer self) arg1 ptr))

(defmethod BULLET/DELETE ((self BVH-TRIANGLE-MESH-SHAPE) arg1 arg2)
  (BVH-TRIANGLE-MESH-SHAPE/DELETE-CPLUS-PLUS-INSTANCE (ff-pointer self) arg1 arg2))

(shadow "new[]")
(defmethod NEW[] ((self BVH-TRIANGLE-MESH-SHAPE) sizeInBytes)
  (BVH-TRIANGLE-MESH-SHAPE/MAKE-CPLUS-ARRAY (ff-pointer self) sizeInBytes))

(shadow "delete[]")
(defmethod DELETE[] ((self BVH-TRIANGLE-MESH-SHAPE) ptr)
  (BVH-TRIANGLE-MESH-SHAPE/DELETE-CPLUS-ARRAY (ff-pointer self) ptr))

(shadow "new[]")
(defmethod NEW[] ((self BVH-TRIANGLE-MESH-SHAPE) arg1 ptr)
  (BVH-TRIANGLE-MESH-SHAPE/MAKE-CPLUS-ARRAY (ff-pointer self) arg1 ptr))

(shadow "delete[]")
(defmethod DELETE[] ((self BVH-TRIANGLE-MESH-SHAPE) arg1 arg2)
  (BVH-TRIANGLE-MESH-SHAPE/DELETE-CPLUS-ARRAY (ff-pointer self) arg1 arg2))

(defmethod initialize-instance :after ((obj BVH-TRIANGLE-MESH-SHAPE) &key meshInterface (useQuantizedAabbCompression t) (buildBvh t))
  (setf (slot-value obj 'ff-pointer) (MAKE-BVH-TRIANGLE-MESH-SHAPE meshInterface useQuantizedAabbCompression buildBvh)))

(defmethod initialize-instance :after ((obj BVH-TRIANGLE-MESH-SHAPE) &key meshInterface (useQuantizedAabbCompression t))
  (setf (slot-value obj 'ff-pointer) (MAKE-BVH-TRIANGLE-MESH-SHAPE meshInterface useQuantizedAabbCompression)))

(defmethod initialize-instance :after ((obj BVH-TRIANGLE-MESH-SHAPE) &key meshInterface (useQuantizedAabbCompression t) (bvhAabbMin VECTOR-3) (bvhAabbMax VECTOR-3) (buildBvh t))
  (setf (slot-value obj 'ff-pointer) (MAKE-BVH-TRIANGLE-MESH-SHAPE meshInterface useQuantizedAabbCompression bvhAabbMin bvhAabbMax buildBvh)))

(defmethod initialize-instance :after ((obj BVH-TRIANGLE-MESH-SHAPE) &key meshInterface (useQuantizedAabbCompression t) (bvhAabbMin VECTOR-3) (bvhAabbMax VECTOR-3))
  (setf (slot-value obj 'ff-pointer) (MAKE-BVH-TRIANGLE-MESH-SHAPE meshInterface useQuantizedAabbCompression bvhAabbMin bvhAabbMax)))

(defmethod OWNS-BVH ((self BVH-TRIANGLE-MESH-SHAPE))
  (BVH-TRIANGLE-MESH-SHAPE/GET-OWNS-BVH (ff-pointer self)))

(defmethod PERFORM-RAYCAST ((self BVH-TRIANGLE-MESH-SHAPE) callback (raySource VECTOR-3) (rayTarget VECTOR-3))
  (BVH-TRIANGLE-MESH-SHAPE/PERFORM-RAYCAST (ff-pointer self) callback raySource rayTarget))

(defmethod PERFORM-CONVEXCAST ((self BVH-TRIANGLE-MESH-SHAPE) callback (boxSource VECTOR-3) (boxTarget VECTOR-3) (boxMin VECTOR-3) (boxMax VECTOR-3))
  (BVH-TRIANGLE-MESH-SHAPE/PERFORM-CONVEXCAST (ff-pointer self) callback boxSource boxTarget boxMin boxMax))

(defmethod PROCESS-ALL-TRIANGLES ((self BVH-TRIANGLE-MESH-SHAPE) callback (aabbMin VECTOR-3) (aabbMax VECTOR-3))
  (BVH-TRIANGLE-MESH-SHAPE/PROCESS-ALL-TRIANGLES (ff-pointer self) callback aabbMin aabbMax))

(defmethod REFIT-TREE ((self BVH-TRIANGLE-MESH-SHAPE) (aabbMin VECTOR-3) (aabbMax VECTOR-3))
  (BVH-TRIANGLE-MESH-SHAPE/REFIT-TREE (ff-pointer self) aabbMin aabbMax))

(defmethod PARTIAL-REFIT-TREE ((self BVH-TRIANGLE-MESH-SHAPE) (aabbMin VECTOR-3) (aabbMax VECTOR-3))
  (BVH-TRIANGLE-MESH-SHAPE/PARTIAL-REFIT-TREE (ff-pointer self) aabbMin aabbMax))

(defmethod NAME ((self BVH-TRIANGLE-MESH-SHAPE))
  (BVH-TRIANGLE-MESH-SHAPE/GET-NAME (ff-pointer self)))

(defmethod (SETF LOCAL-SCALING) ((self BVH-TRIANGLE-MESH-SHAPE) (scaling VECTOR-3))
  (BVH-TRIANGLE-MESH-SHAPE/SET-LOCAL-SCALING (ff-pointer self) scaling))

(defmethod OPTIMIZED-BVH ((self BVH-TRIANGLE-MESH-SHAPE))
  (BVH-TRIANGLE-MESH-SHAPE/GET-OPTIMIZED-BVH (ff-pointer self)))

(defmethod (SETF OPTIMIZED-BVH) ((self BVH-TRIANGLE-MESH-SHAPE) bvh (localScaling VECTOR-3))
  (BVH-TRIANGLE-MESH-SHAPE/SET-OPTIMIZED-BVH (ff-pointer self) bvh localScaling))

(defmethod (SETF OPTIMIZED-BVH) ((self BVH-TRIANGLE-MESH-SHAPE) bvh)
  (BVH-TRIANGLE-MESH-SHAPE/SET-OPTIMIZED-BVH (ff-pointer self) bvh))

(defmethod BUILD-OPTIMIZED-BVH ((self BVH-TRIANGLE-MESH-SHAPE))
  (BVH-TRIANGLE-MESH-SHAPE/BUILD-OPTIMIZED-BVH (ff-pointer self)))

(defmethod USES-QUANTIZED-AABB-COMPRESSION ((self BVH-TRIANGLE-MESH-SHAPE))
  (BVH-TRIANGLE-MESH-SHAPE/USES-QUANTIZED-AABB-COMPRESSION (ff-pointer self)))

(defmethod (SETF TRIANGLE-INFO-MAP) ((self BVH-TRIANGLE-MESH-SHAPE) triangleInfoMap)
  (BVH-TRIANGLE-MESH-SHAPE/SET-TRIANGLE-INFO-MAP (ff-pointer self) triangleInfoMap))

(defmethod TRIANGLE-INFO-MAP ((self BVH-TRIANGLE-MESH-SHAPE))
  (BVH-TRIANGLE-MESH-SHAPE/GET-TRIANGLE-INFO-MAP (ff-pointer self)))

(defmethod TRIANGLE-INFO-MAP ((self BVH-TRIANGLE-MESH-SHAPE))
  (BVH-TRIANGLE-MESH-SHAPE/GET-TRIANGLE-INFO-MAP (ff-pointer self)))

(defmethod CALCULATE-SERIALIZE-BUFFER-SIZE ((self BVH-TRIANGLE-MESH-SHAPE))
  (BVH-TRIANGLE-MESH-SHAPE/CALCULATE-SERIALIZE-BUFFER-SIZE (ff-pointer self)))

(defmethod SERIALIZE ((self BVH-TRIANGLE-MESH-SHAPE) dataBuffer serializer)
  (BVH-TRIANGLE-MESH-SHAPE/SERIALIZE (ff-pointer self) dataBuffer serializer))

(defmethod SERIALIZE-SINGLE-BVH ((self BVH-TRIANGLE-MESH-SHAPE) serializer)
  (BVH-TRIANGLE-MESH-SHAPE/SERIALIZE-SINGLE-BVH (ff-pointer self) serializer))

(defmethod SERIALIZE-SINGLE-TRIANGLE-INFO-MAP ((self BVH-TRIANGLE-MESH-SHAPE) serializer)
  (BVH-TRIANGLE-MESH-SHAPE/SERIALIZE-SINGLE-TRIANGLE-INFO-MAP (ff-pointer self) serializer))



(defmethod NEW ((self SCALED-BVH-TRIANGLE-MESH-SHAPE) sizeInBytes)
  (SCALED-BVH-TRIANGLE-MESH-SHAPE/MAKE-CPLUS-PLUS-INSTANCE (ff-pointer self) sizeInBytes))

(defmethod BULLET/DELETE ((self SCALED-BVH-TRIANGLE-MESH-SHAPE) ptr)
  (SCALED-BVH-TRIANGLE-MESH-SHAPE/DELETE-CPLUS-PLUS-INSTANCE (ff-pointer self) ptr))

(defmethod NEW ((self SCALED-BVH-TRIANGLE-MESH-SHAPE) arg1 ptr)
  (SCALED-BVH-TRIANGLE-MESH-SHAPE/MAKE-CPLUS-PLUS-INSTANCE (ff-pointer self) arg1 ptr))

(defmethod BULLET/DELETE ((self SCALED-BVH-TRIANGLE-MESH-SHAPE) arg1 arg2)
  (SCALED-BVH-TRIANGLE-MESH-SHAPE/DELETE-CPLUS-PLUS-INSTANCE (ff-pointer self) arg1 arg2))

(shadow "new[]")
(defmethod NEW[] ((self SCALED-BVH-TRIANGLE-MESH-SHAPE) sizeInBytes)
  (SCALED-BVH-TRIANGLE-MESH-SHAPE/MAKE-CPLUS-ARRAY (ff-pointer self) sizeInBytes))

(shadow "delete[]")
(defmethod DELETE[] ((self SCALED-BVH-TRIANGLE-MESH-SHAPE) ptr)
  (SCALED-BVH-TRIANGLE-MESH-SHAPE/DELETE-CPLUS-ARRAY (ff-pointer self) ptr))

(shadow "new[]")
(defmethod NEW[] ((self SCALED-BVH-TRIANGLE-MESH-SHAPE) arg1 ptr)
  (SCALED-BVH-TRIANGLE-MESH-SHAPE/MAKE-CPLUS-ARRAY (ff-pointer self) arg1 ptr))

(shadow "delete[]")
(defmethod DELETE[] ((self SCALED-BVH-TRIANGLE-MESH-SHAPE) arg1 arg2)
  (SCALED-BVH-TRIANGLE-MESH-SHAPE/DELETE-CPLUS-ARRAY (ff-pointer self) arg1 arg2))

(defmethod initialize-instance :after ((obj SCALED-BVH-TRIANGLE-MESH-SHAPE) &key (childShape BVH-TRIANGLE-MESH-SHAPE) (localScaling VECTOR-3))
  (setf (slot-value obj 'ff-pointer) (MAKE-SCALED-BVH-TRIANGLE-MESH-SHAPE childShape localScaling)))

(defmethod AABB ((self SCALED-BVH-TRIANGLE-MESH-SHAPE) (t-arg1 TRANSFORM) (aabbMin VECTOR-3) (aabbMax VECTOR-3))
  (SCALED-BVH-TRIANGLE-MESH-SHAPE/GET-AABB (ff-pointer self) t-arg1 aabbMin aabbMax))

(defmethod (SETF LOCAL-SCALING) ((self SCALED-BVH-TRIANGLE-MESH-SHAPE) (scaling VECTOR-3))
  (SCALED-BVH-TRIANGLE-MESH-SHAPE/SET-LOCAL-SCALING (ff-pointer self) scaling))

(defmethod LOCAL-SCALING ((self SCALED-BVH-TRIANGLE-MESH-SHAPE))
  (SCALED-BVH-TRIANGLE-MESH-SHAPE/GET-LOCAL-SCALING (ff-pointer self)))

(defmethod CALCULATE-LOCAL-INERTIA ((self SCALED-BVH-TRIANGLE-MESH-SHAPE) (mass number) (inertia VECTOR-3))
  (SCALED-BVH-TRIANGLE-MESH-SHAPE/CALCULATE-LOCAL-INERTIA (ff-pointer self) mass inertia))

(defmethod PROCESS-ALL-TRIANGLES ((self SCALED-BVH-TRIANGLE-MESH-SHAPE) callback (aabbMin VECTOR-3) (aabbMax VECTOR-3))
  (SCALED-BVH-TRIANGLE-MESH-SHAPE/PROCESS-ALL-TRIANGLES (ff-pointer self) callback aabbMin aabbMax))

(defmethod CHILD-SHAPE ((self SCALED-BVH-TRIANGLE-MESH-SHAPE))
  (SCALED-BVH-TRIANGLE-MESH-SHAPE/GET-CHILD-SHAPE (ff-pointer self)))

(defmethod CHILD-SHAPE ((self SCALED-BVH-TRIANGLE-MESH-SHAPE))
  (SCALED-BVH-TRIANGLE-MESH-SHAPE/GET-CHILD-SHAPE (ff-pointer self)))

(defmethod NAME ((self SCALED-BVH-TRIANGLE-MESH-SHAPE))
  (SCALED-BVH-TRIANGLE-MESH-SHAPE/GET-NAME (ff-pointer self)))

(defmethod CALCULATE-SERIALIZE-BUFFER-SIZE ((self SCALED-BVH-TRIANGLE-MESH-SHAPE))
  (SCALED-BVH-TRIANGLE-MESH-SHAPE/CALCULATE-SERIALIZE-BUFFER-SIZE (ff-pointer self)))

(defmethod SERIALIZE ((self SCALED-BVH-TRIANGLE-MESH-SHAPE) dataBuffer serializer)
  (SCALED-BVH-TRIANGLE-MESH-SHAPE/SERIALIZE (ff-pointer self) dataBuffer serializer))



(defmethod NEW ((self TRIANGLE-MESH-SHAPE) sizeInBytes)
  (TRIANGLE-MESH-SHAPE/MAKE-CPLUS-PLUS-INSTANCE (ff-pointer self) sizeInBytes))

(defmethod BULLET/DELETE ((self TRIANGLE-MESH-SHAPE) ptr)
  (TRIANGLE-MESH-SHAPE/DELETE-CPLUS-PLUS-INSTANCE (ff-pointer self) ptr))

(defmethod NEW ((self TRIANGLE-MESH-SHAPE) arg1 ptr)
  (TRIANGLE-MESH-SHAPE/MAKE-CPLUS-PLUS-INSTANCE (ff-pointer self) arg1 ptr))

(defmethod BULLET/DELETE ((self TRIANGLE-MESH-SHAPE) arg1 arg2)
  (TRIANGLE-MESH-SHAPE/DELETE-CPLUS-PLUS-INSTANCE (ff-pointer self) arg1 arg2))

(shadow "new[]")
(defmethod NEW[] ((self TRIANGLE-MESH-SHAPE) sizeInBytes)
  (TRIANGLE-MESH-SHAPE/MAKE-CPLUS-ARRAY (ff-pointer self) sizeInBytes))

(shadow "delete[]")
(defmethod DELETE[] ((self TRIANGLE-MESH-SHAPE) ptr)
  (TRIANGLE-MESH-SHAPE/DELETE-CPLUS-ARRAY (ff-pointer self) ptr))

(shadow "new[]")
(defmethod NEW[] ((self TRIANGLE-MESH-SHAPE) arg1 ptr)
  (TRIANGLE-MESH-SHAPE/MAKE-CPLUS-ARRAY (ff-pointer self) arg1 ptr))

(shadow "delete[]")
(defmethod DELETE[] ((self TRIANGLE-MESH-SHAPE) arg1 arg2)
  (TRIANGLE-MESH-SHAPE/DELETE-CPLUS-ARRAY (ff-pointer self) arg1 arg2))

(defmethod LOCAL-GET-SUPPORTING-VERTEX ((self TRIANGLE-MESH-SHAPE) (vec VECTOR-3))
  (TRIANGLE-MESH-SHAPE/LOCAL-GET-SUPPORTING-VERTEX (ff-pointer self) vec))

(defmethod LOCAL-GET-SUPPORTING-VERTEX-WITHOUT-MARGIN ((self TRIANGLE-MESH-SHAPE) (vec VECTOR-3))
  (TRIANGLE-MESH-SHAPE/LOCAL-GET-SUPPORTING-VERTEX-WITHOUT-MARGIN (ff-pointer self) vec))

(defmethod RECALC-LOCAL-AABB ((self TRIANGLE-MESH-SHAPE))
  (TRIANGLE-MESH-SHAPE/RECALC-LOCAL-AABB (ff-pointer self)))

(defmethod AABB ((self TRIANGLE-MESH-SHAPE) (t-arg1 TRANSFORM) (aabbMin VECTOR-3) (aabbMax VECTOR-3))
  (TRIANGLE-MESH-SHAPE/GET-AABB (ff-pointer self) t-arg1 aabbMin aabbMax))

(defmethod PROCESS-ALL-TRIANGLES ((self TRIANGLE-MESH-SHAPE) callback (aabbMin VECTOR-3) (aabbMax VECTOR-3))
  (TRIANGLE-MESH-SHAPE/PROCESS-ALL-TRIANGLES (ff-pointer self) callback aabbMin aabbMax))

(defmethod CALCULATE-LOCAL-INERTIA ((self TRIANGLE-MESH-SHAPE) (mass number) (inertia VECTOR-3))
  (TRIANGLE-MESH-SHAPE/CALCULATE-LOCAL-INERTIA (ff-pointer self) mass inertia))

(defmethod (SETF LOCAL-SCALING) ((self TRIANGLE-MESH-SHAPE) (scaling VECTOR-3))
  (TRIANGLE-MESH-SHAPE/SET-LOCAL-SCALING (ff-pointer self) scaling))

(defmethod LOCAL-SCALING ((self TRIANGLE-MESH-SHAPE))
  (TRIANGLE-MESH-SHAPE/GET-LOCAL-SCALING (ff-pointer self)))

(defmethod MESH-INTERFACE ((self TRIANGLE-MESH-SHAPE))
  (TRIANGLE-MESH-SHAPE/GET-MESH-INTERFACE (ff-pointer self)))

(defmethod MESH-INTERFACE ((self TRIANGLE-MESH-SHAPE))
  (TRIANGLE-MESH-SHAPE/GET-MESH-INTERFACE (ff-pointer self)))

(defmethod LOCAL-AABB-MIN ((self TRIANGLE-MESH-SHAPE))
  (TRIANGLE-MESH-SHAPE/GET-LOCAL-AABB-MIN (ff-pointer self)))

(defmethod LOCAL-AABB-MAX ((self TRIANGLE-MESH-SHAPE))
  (TRIANGLE-MESH-SHAPE/GET-LOCAL-AABB-MAX (ff-pointer self)))

(defmethod NAME ((self TRIANGLE-MESH-SHAPE))
  (TRIANGLE-MESH-SHAPE/GET-NAME (ff-pointer self)))



(defmethod NEW ((self TRIANGLE-INDEX-VERTEX-ARRAY) sizeInBytes)
  (TRIANGLE-INDEX-VERTEX-ARRAY/MAKE-CPLUS-PLUS-INSTANCE (ff-pointer self) sizeInBytes))

(defmethod BULLET/DELETE ((self TRIANGLE-INDEX-VERTEX-ARRAY) ptr)
  (TRIANGLE-INDEX-VERTEX-ARRAY/DELETE-CPLUS-PLUS-INSTANCE (ff-pointer self) ptr))

(defmethod NEW ((self TRIANGLE-INDEX-VERTEX-ARRAY) arg1 ptr)
  (TRIANGLE-INDEX-VERTEX-ARRAY/MAKE-CPLUS-PLUS-INSTANCE (ff-pointer self) arg1 ptr))

(defmethod BULLET/DELETE ((self TRIANGLE-INDEX-VERTEX-ARRAY) arg1 arg2)
  (TRIANGLE-INDEX-VERTEX-ARRAY/DELETE-CPLUS-PLUS-INSTANCE (ff-pointer self) arg1 arg2))

(shadow "new[]")
(defmethod NEW[] ((self TRIANGLE-INDEX-VERTEX-ARRAY) sizeInBytes)
  (TRIANGLE-INDEX-VERTEX-ARRAY/MAKE-CPLUS-ARRAY (ff-pointer self) sizeInBytes))

(shadow "delete[]")
(defmethod DELETE[] ((self TRIANGLE-INDEX-VERTEX-ARRAY) ptr)
  (TRIANGLE-INDEX-VERTEX-ARRAY/DELETE-CPLUS-ARRAY (ff-pointer self) ptr))

(shadow "new[]")
(defmethod NEW[] ((self TRIANGLE-INDEX-VERTEX-ARRAY) arg1 ptr)
  (TRIANGLE-INDEX-VERTEX-ARRAY/MAKE-CPLUS-ARRAY (ff-pointer self) arg1 ptr))

(shadow "delete[]")
(defmethod DELETE[] ((self TRIANGLE-INDEX-VERTEX-ARRAY) arg1 arg2)
  (TRIANGLE-INDEX-VERTEX-ARRAY/DELETE-CPLUS-ARRAY (ff-pointer self) arg1 arg2))

(defmethod initialize-instance :after ((obj TRIANGLE-INDEX-VERTEX-ARRAY) &key)
  (setf (slot-value obj 'ff-pointer) (MAKE-TRIANGLE-INDEX-VERTEX-ARRAY)))

(defmethod initialize-instance :after ((obj TRIANGLE-INDEX-VERTEX-ARRAY) &key (numTriangles integer) triangleIndexBase (triangleIndexStride integer) (numVertices integer) vertexBase (vertexStride integer))
  (setf (slot-value obj 'ff-pointer) (MAKE-TRIANGLE-INDEX-VERTEX-ARRAY numTriangles triangleIndexBase triangleIndexStride numVertices vertexBase vertexStride)))

(defmethod ADD-INDEXED-MESH ((self TRIANGLE-INDEX-VERTEX-ARRAY) mesh indexType)
  (TRIANGLE-INDEX-VERTEX-ARRAY/ADD-INDEXED-MESH (ff-pointer self) mesh indexType))

(defmethod ADD-INDEXED-MESH ((self TRIANGLE-INDEX-VERTEX-ARRAY) mesh)
  (TRIANGLE-INDEX-VERTEX-ARRAY/ADD-INDEXED-MESH (ff-pointer self) mesh))

(defmethod LOCKED-VERTEX-INDEX-BASE ((self TRIANGLE-INDEX-VERTEX-ARRAY) vertexbase numverts type vertexStride indexbase indexstride numfaces indicestype (subpart integer))
  (TRIANGLE-INDEX-VERTEX-ARRAY/GET-LOCKED-VERTEX-INDEX-BASE (ff-pointer self) vertexbase numverts type vertexStride indexbase indexstride numfaces indicestype subpart))

(defmethod LOCKED-VERTEX-INDEX-BASE ((self TRIANGLE-INDEX-VERTEX-ARRAY) vertexbase numverts type vertexStride indexbase indexstride numfaces indicestype)
  (TRIANGLE-INDEX-VERTEX-ARRAY/GET-LOCKED-VERTEX-INDEX-BASE (ff-pointer self) vertexbase numverts type vertexStride indexbase indexstride numfaces indicestype))

(defmethod LOCKED-READ-ONLY-VERTEX-INDEX-BASE ((self TRIANGLE-INDEX-VERTEX-ARRAY) vertexbase numverts type vertexStride indexbase indexstride numfaces indicestype (subpart integer))
  (TRIANGLE-INDEX-VERTEX-ARRAY/GET-LOCKED-READ-ONLY-VERTEX-INDEX-BASE (ff-pointer self) vertexbase numverts type vertexStride indexbase indexstride numfaces indicestype subpart))

(defmethod LOCKED-READ-ONLY-VERTEX-INDEX-BASE ((self TRIANGLE-INDEX-VERTEX-ARRAY) vertexbase numverts type vertexStride indexbase indexstride numfaces indicestype)
  (TRIANGLE-INDEX-VERTEX-ARRAY/GET-LOCKED-READ-ONLY-VERTEX-INDEX-BASE (ff-pointer self) vertexbase numverts type vertexStride indexbase indexstride numfaces indicestype))

(defmethod UN-LOCK-VERTEX-BASE ((self TRIANGLE-INDEX-VERTEX-ARRAY) (subpart integer))
  (TRIANGLE-INDEX-VERTEX-ARRAY/UN-LOCK-VERTEX-BASE (ff-pointer self) subpart))

(defmethod UN-LOCK-READ-ONLY-VERTEX-BASE ((self TRIANGLE-INDEX-VERTEX-ARRAY) (subpart integer))
  (TRIANGLE-INDEX-VERTEX-ARRAY/UN-LOCK-READ-ONLY-VERTEX-BASE (ff-pointer self) subpart))

(defmethod NUM-SUB-PARTS ((self TRIANGLE-INDEX-VERTEX-ARRAY))
  (TRIANGLE-INDEX-VERTEX-ARRAY/GET-NUM-SUB-PARTS (ff-pointer self)))

(defmethod INDEXED-MESH-ARRAY ((self TRIANGLE-INDEX-VERTEX-ARRAY))
  (TRIANGLE-INDEX-VERTEX-ARRAY/GET-INDEXED-MESH-ARRAY (ff-pointer self)))

(defmethod INDEXED-MESH-ARRAY ((self TRIANGLE-INDEX-VERTEX-ARRAY))
  (TRIANGLE-INDEX-VERTEX-ARRAY/GET-INDEXED-MESH-ARRAY (ff-pointer self)))

(defmethod PREALLOCATE-VERTICES ((self TRIANGLE-INDEX-VERTEX-ARRAY) (numverts integer))
  (TRIANGLE-INDEX-VERTEX-ARRAY/PREALLOCATE-VERTICES (ff-pointer self) numverts))

(defmethod PREALLOCATE-INDICES ((self TRIANGLE-INDEX-VERTEX-ARRAY) (numindices integer))
  (TRIANGLE-INDEX-VERTEX-ARRAY/PREALLOCATE-INDICES (ff-pointer self) numindices))

(defmethod HAS-PREMADE-AABB-P ((self TRIANGLE-INDEX-VERTEX-ARRAY))
  (TRIANGLE-INDEX-VERTEX-ARRAY/HAS-PREMADE-AABB (ff-pointer self)))

(defmethod (SETF PREMADE-AABB) ((self TRIANGLE-INDEX-VERTEX-ARRAY) (aabbMin VECTOR-3) (aabbMax VECTOR-3))
  (TRIANGLE-INDEX-VERTEX-ARRAY/SET-PREMADE-AABB (ff-pointer self) aabbMin aabbMax))

(defmethod PREMADE-AABB ((self TRIANGLE-INDEX-VERTEX-ARRAY) (aabbMin VECTOR-3) (aabbMax VECTOR-3))
  (TRIANGLE-INDEX-VERTEX-ARRAY/GET-PREMADE-AABB (ff-pointer self) aabbMin aabbMax))



(defmethod NEW ((self COMPOUND-SHAPE) sizeInBytes)
  (COMPOUND-SHAPE/MAKE-CPLUS-PLUS-INSTANCE (ff-pointer self) sizeInBytes))

(defmethod BULLET/DELETE ((self COMPOUND-SHAPE) ptr)
  (COMPOUND-SHAPE/DELETE-CPLUS-PLUS-INSTANCE (ff-pointer self) ptr))

(defmethod NEW ((self COMPOUND-SHAPE) arg1 ptr)
  (COMPOUND-SHAPE/MAKE-CPLUS-PLUS-INSTANCE (ff-pointer self) arg1 ptr))

(defmethod BULLET/DELETE ((self COMPOUND-SHAPE) arg1 arg2)
  (COMPOUND-SHAPE/DELETE-CPLUS-PLUS-INSTANCE (ff-pointer self) arg1 arg2))

(shadow "new[]")
(defmethod NEW[] ((self COMPOUND-SHAPE) sizeInBytes)
  (COMPOUND-SHAPE/MAKE-CPLUS-ARRAY (ff-pointer self) sizeInBytes))

(shadow "delete[]")
(defmethod DELETE[] ((self COMPOUND-SHAPE) ptr)
  (COMPOUND-SHAPE/DELETE-CPLUS-ARRAY (ff-pointer self) ptr))

(shadow "new[]")
(defmethod NEW[] ((self COMPOUND-SHAPE) arg1 ptr)
  (COMPOUND-SHAPE/MAKE-CPLUS-ARRAY (ff-pointer self) arg1 ptr))

(shadow "delete[]")
(defmethod DELETE[] ((self COMPOUND-SHAPE) arg1 arg2)
  (COMPOUND-SHAPE/DELETE-CPLUS-ARRAY (ff-pointer self) arg1 arg2))

(defmethod initialize-instance :after ((obj COMPOUND-SHAPE) &key (enableDynamicAabbTree t))
  (setf (slot-value obj 'ff-pointer) (MAKE-COMPOUND-SHAPE enableDynamicAabbTree)))

(defmethod initialize-instance :after ((obj COMPOUND-SHAPE) &key)
  (setf (slot-value obj 'ff-pointer) (MAKE-COMPOUND-SHAPE)))

(defmethod ADD-CHILD-SHAPE ((self COMPOUND-SHAPE) (localTransform TRANSFORM) shape)
  (COMPOUND-SHAPE/ADD-CHILD-SHAPE (ff-pointer self) localTransform shape))

(defmethod REMOVE-CHILD-SHAPE ((self COMPOUND-SHAPE) shape)
  (COMPOUND-SHAPE/REMOVE-CHILD-SHAPE (ff-pointer self) shape))

(defmethod REMOVE-CHILD-SHAPE-BY-INDEX ((self COMPOUND-SHAPE) (childShapeindex integer))
  (COMPOUND-SHAPE/REMOVE-CHILD-SHAPE-BY-INDEX (ff-pointer self) childShapeindex))

(defmethod NUM-CHILD-SHAPES ((self COMPOUND-SHAPE))
  (COMPOUND-SHAPE/GET-NUM-CHILD-SHAPES (ff-pointer self)))

(defmethod CHILD-SHAPE ((self COMPOUND-SHAPE) (index integer))
  (COMPOUND-SHAPE/GET-CHILD-SHAPE (ff-pointer self) index))

(defmethod CHILD-SHAPE ((self COMPOUND-SHAPE) (index integer))
  (COMPOUND-SHAPE/GET-CHILD-SHAPE (ff-pointer self) index))

(defmethod CHILD-TRANSFORM ((self COMPOUND-SHAPE) (index integer))
  (COMPOUND-SHAPE/GET-CHILD-TRANSFORM (ff-pointer self) index))

(defmethod CHILD-TRANSFORM ((self COMPOUND-SHAPE) (index integer))
  (COMPOUND-SHAPE/GET-CHILD-TRANSFORM (ff-pointer self) index))

(defmethod UPDATE-CHILD-TRANSFORM ((self COMPOUND-SHAPE) (childIndex integer) (newChildTransform TRANSFORM) (shouldRecalculateLocalAabb t))
  (COMPOUND-SHAPE/UPDATE-CHILD-TRANSFORM (ff-pointer self) childIndex newChildTransform shouldRecalculateLocalAabb))

(defmethod UPDATE-CHILD-TRANSFORM ((self COMPOUND-SHAPE) (childIndex integer) (newChildTransform TRANSFORM))
  (COMPOUND-SHAPE/UPDATE-CHILD-TRANSFORM (ff-pointer self) childIndex newChildTransform))

(defmethod CHILD-LIST ((self COMPOUND-SHAPE))
  (COMPOUND-SHAPE/GET-CHILD-LIST (ff-pointer self)))

(defmethod AABB ((self COMPOUND-SHAPE) (t-arg1 TRANSFORM) (aabbMin VECTOR-3) (aabbMax VECTOR-3))
  (COMPOUND-SHAPE/GET-AABB (ff-pointer self) t-arg1 aabbMin aabbMax))

(defmethod RECALCULATE-LOCAL-AABB ((self COMPOUND-SHAPE))
  (COMPOUND-SHAPE/RECALCULATE-LOCAL-AABB (ff-pointer self)))

(defmethod (SETF LOCAL-SCALING) ((self COMPOUND-SHAPE) (scaling VECTOR-3))
  (COMPOUND-SHAPE/SET-LOCAL-SCALING (ff-pointer self) scaling))

(defmethod LOCAL-SCALING ((self COMPOUND-SHAPE))
  (COMPOUND-SHAPE/GET-LOCAL-SCALING (ff-pointer self)))

(defmethod CALCULATE-LOCAL-INERTIA ((self COMPOUND-SHAPE) (mass number) (inertia VECTOR-3))
  (COMPOUND-SHAPE/CALCULATE-LOCAL-INERTIA (ff-pointer self) mass inertia))

(defmethod (SETF MARGIN) ((self COMPOUND-SHAPE) (margin number))
  (COMPOUND-SHAPE/SET-MARGIN (ff-pointer self) margin))

(defmethod MARGIN ((self COMPOUND-SHAPE))
  (COMPOUND-SHAPE/GET-MARGIN (ff-pointer self)))

(defmethod NAME ((self COMPOUND-SHAPE))
  (COMPOUND-SHAPE/GET-NAME (ff-pointer self)))

(defmethod DYNAMIC-AABB-TREE ((self COMPOUND-SHAPE))
  (COMPOUND-SHAPE/GET-DYNAMIC-AABB-TREE (ff-pointer self)))

(defmethod DYNAMIC-AABB-TREE ((self COMPOUND-SHAPE))
  (COMPOUND-SHAPE/GET-DYNAMIC-AABB-TREE (ff-pointer self)))

(defmethod CREATE-AABB-TREE-FROM-CHILDREN ((self COMPOUND-SHAPE))
  (COMPOUND-SHAPE/CREATE-AABB-TREE-FROM-CHILDREN (ff-pointer self)))

(defmethod CALCULATE-PRINCIPAL-AXIS-TRANSFORM ((self COMPOUND-SHAPE) masses (principal TRANSFORM) (inertia VECTOR-3))
  (COMPOUND-SHAPE/CALCULATE-PRINCIPAL-AXIS-TRANSFORM (ff-pointer self) masses principal inertia))

(defmethod UPDATE-REVISION ((self COMPOUND-SHAPE))
  (COMPOUND-SHAPE/GET-UPDATE-REVISION (ff-pointer self)))

(defmethod CALCULATE-SERIALIZE-BUFFER-SIZE ((self COMPOUND-SHAPE))
  (COMPOUND-SHAPE/CALCULATE-SERIALIZE-BUFFER-SIZE (ff-pointer self)))

(defmethod SERIALIZE ((self COMPOUND-SHAPE) dataBuffer serializer)
  (COMPOUND-SHAPE/SERIALIZE (ff-pointer self) dataBuffer serializer))



(defmethod NEW ((self BU-SIMPLEX-1TO-4) sizeInBytes)
  (BU/SIMPLEX-1TO-4/MAKE-CPLUS-PLUS-INSTANCE (ff-pointer self) sizeInBytes))

(defmethod BULLET/DELETE ((self BU-SIMPLEX-1TO-4) ptr)
  (BU/SIMPLEX-1TO-4/DELETE-CPLUS-PLUS-INSTANCE (ff-pointer self) ptr))

(defmethod NEW ((self BU-SIMPLEX-1TO-4) arg1 ptr)
  (BU/SIMPLEX-1TO-4/MAKE-CPLUS-PLUS-INSTANCE (ff-pointer self) arg1 ptr))

(defmethod BULLET/DELETE ((self BU-SIMPLEX-1TO-4) arg1 arg2)
  (BU/SIMPLEX-1TO-4/DELETE-CPLUS-PLUS-INSTANCE (ff-pointer self) arg1 arg2))

(shadow "new[]")
(defmethod NEW[] ((self BU-SIMPLEX-1TO-4) sizeInBytes)
  (BU/SIMPLEX-1TO-4/MAKE-CPLUS-ARRAY (ff-pointer self) sizeInBytes))

(shadow "delete[]")
(defmethod DELETE[] ((self BU-SIMPLEX-1TO-4) ptr)
  (BU/SIMPLEX-1TO-4/DELETE-CPLUS-ARRAY (ff-pointer self) ptr))

(shadow "new[]")
(defmethod NEW[] ((self BU-SIMPLEX-1TO-4) arg1 ptr)
  (BU/SIMPLEX-1TO-4/MAKE-CPLUS-ARRAY (ff-pointer self) arg1 ptr))

(shadow "delete[]")
(defmethod DELETE[] ((self BU-SIMPLEX-1TO-4) arg1 arg2)
  (BU/SIMPLEX-1TO-4/DELETE-CPLUS-ARRAY (ff-pointer self) arg1 arg2))

(defmethod initialize-instance :after ((obj BU-SIMPLEX-1TO-4) &key)
  (setf (slot-value obj 'ff-pointer) (MAKE-BU/SIMPLEX-1TO-4)))

(defmethod initialize-instance :after ((obj BU-SIMPLEX-1TO-4) &key (pt0 VECTOR-3))
  (setf (slot-value obj 'ff-pointer) (MAKE-BU/SIMPLEX-1TO-4 pt0)))

(defmethod initialize-instance :after ((obj BU-SIMPLEX-1TO-4) &key (pt0 VECTOR-3) (pt1 VECTOR-3))
  (setf (slot-value obj 'ff-pointer) (MAKE-BU/SIMPLEX-1TO-4 pt0 pt1)))

(defmethod initialize-instance :after ((obj BU-SIMPLEX-1TO-4) &key (pt0 VECTOR-3) (pt1 VECTOR-3) (pt2 VECTOR-3))
  (setf (slot-value obj 'ff-pointer) (MAKE-BU/SIMPLEX-1TO-4 pt0 pt1 pt2)))

(defmethod initialize-instance :after ((obj BU-SIMPLEX-1TO-4) &key (pt0 VECTOR-3) (pt1 VECTOR-3) (pt2 VECTOR-3) (pt3 VECTOR-3))
  (setf (slot-value obj 'ff-pointer) (MAKE-BU/SIMPLEX-1TO-4 pt0 pt1 pt2 pt3)))

(defmethod RESET ((self BU-SIMPLEX-1TO-4))
  (BU/SIMPLEX-1TO-4/RESET (ff-pointer self)))

(defmethod AABB ((self BU-SIMPLEX-1TO-4) (t-arg1 TRANSFORM) (aabbMin VECTOR-3) (aabbMax VECTOR-3))
  (BU/SIMPLEX-1TO-4/GET-AABB (ff-pointer self) t-arg1 aabbMin aabbMax))

(defmethod ADD-VERTEX ((self BU-SIMPLEX-1TO-4) (pt VECTOR-3))
  (BU/SIMPLEX-1TO-4/ADD-VERTEX (ff-pointer self) pt))

(defmethod NUM-VERTICES ((self BU-SIMPLEX-1TO-4))
  (BU/SIMPLEX-1TO-4/GET-NUM-VERTICES (ff-pointer self)))

(defmethod NUM-EDGES ((self BU-SIMPLEX-1TO-4))
  (BU/SIMPLEX-1TO-4/GET-NUM-EDGES (ff-pointer self)))

(defmethod EDGE ((self BU-SIMPLEX-1TO-4) (i integer) (pa VECTOR-3) (pb VECTOR-3))
  (BU/SIMPLEX-1TO-4/GET-EDGE (ff-pointer self) i pa pb))

(defmethod VERTEX ((self BU-SIMPLEX-1TO-4) (i integer) (vtx VECTOR-3))
  (BU/SIMPLEX-1TO-4/GET-VERTEX (ff-pointer self) i vtx))

(defmethod NUM-PLANES ((self BU-SIMPLEX-1TO-4))
  (BU/SIMPLEX-1TO-4/GET-NUM-PLANES (ff-pointer self)))

(defmethod PLANE ((self BU-SIMPLEX-1TO-4) (planeNormal VECTOR-3) (planeSupport VECTOR-3) (i integer))
  (BU/SIMPLEX-1TO-4/GET-PLANE (ff-pointer self) planeNormal planeSupport i))

(defmethod INDEX ((self BU-SIMPLEX-1TO-4) (i integer))
  (BU/SIMPLEX-1TO-4/GET-INDEX (ff-pointer self) i))

(defmethod INSIDEP ((self BU-SIMPLEX-1TO-4) (pt VECTOR-3) (tolerance number))
  (BU/SIMPLEX-1TO-4/IS-INSIDE (ff-pointer self) pt tolerance))

(defmethod NAME ((self BU-SIMPLEX-1TO-4))
  (BU/SIMPLEX-1TO-4/GET-NAME (ff-pointer self)))



(defmethod NEW ((self EMPTY-SHAPE) sizeInBytes)
  (EMPTY-SHAPE/MAKE-CPLUS-PLUS-INSTANCE (ff-pointer self) sizeInBytes))

(defmethod BULLET/DELETE ((self EMPTY-SHAPE) ptr)
  (EMPTY-SHAPE/DELETE-CPLUS-PLUS-INSTANCE (ff-pointer self) ptr))

(defmethod NEW ((self EMPTY-SHAPE) arg1 ptr)
  (EMPTY-SHAPE/MAKE-CPLUS-PLUS-INSTANCE (ff-pointer self) arg1 ptr))

(defmethod BULLET/DELETE ((self EMPTY-SHAPE) arg1 arg2)
  (EMPTY-SHAPE/DELETE-CPLUS-PLUS-INSTANCE (ff-pointer self) arg1 arg2))

(shadow "new[]")
(defmethod NEW[] ((self EMPTY-SHAPE) sizeInBytes)
  (EMPTY-SHAPE/MAKE-CPLUS-ARRAY (ff-pointer self) sizeInBytes))

(shadow "delete[]")
(defmethod DELETE[] ((self EMPTY-SHAPE) ptr)
  (EMPTY-SHAPE/DELETE-CPLUS-ARRAY (ff-pointer self) ptr))

(shadow "new[]")
(defmethod NEW[] ((self EMPTY-SHAPE) arg1 ptr)
  (EMPTY-SHAPE/MAKE-CPLUS-ARRAY (ff-pointer self) arg1 ptr))

(shadow "delete[]")
(defmethod DELETE[] ((self EMPTY-SHAPE) arg1 arg2)
  (EMPTY-SHAPE/DELETE-CPLUS-ARRAY (ff-pointer self) arg1 arg2))

(defmethod initialize-instance :after ((obj EMPTY-SHAPE) &key)
  (setf (slot-value obj 'ff-pointer) (MAKE-EMPTY-SHAPE)))

(defmethod AABB ((self EMPTY-SHAPE) (t-arg1 TRANSFORM) (aabbMin VECTOR-3) (aabbMax VECTOR-3))
  (EMPTY-SHAPE/GET-AABB (ff-pointer self) t-arg1 aabbMin aabbMax))

(defmethod (SETF LOCAL-SCALING) ((self EMPTY-SHAPE) (scaling VECTOR-3))
  (EMPTY-SHAPE/SET-LOCAL-SCALING (ff-pointer self) scaling))

(defmethod LOCAL-SCALING ((self EMPTY-SHAPE))
  (EMPTY-SHAPE/GET-LOCAL-SCALING (ff-pointer self)))

(defmethod CALCULATE-LOCAL-INERTIA ((self EMPTY-SHAPE) (mass number) (inertia VECTOR-3))
  (EMPTY-SHAPE/CALCULATE-LOCAL-INERTIA (ff-pointer self) mass inertia))

(defmethod NAME ((self EMPTY-SHAPE))
  (EMPTY-SHAPE/GET-NAME (ff-pointer self)))

(defmethod PROCESS-ALL-TRIANGLES ((self EMPTY-SHAPE) arg1 (arg2 VECTOR-3) (arg3 VECTOR-3))
  (EMPTY-SHAPE/PROCESS-ALL-TRIANGLES (ff-pointer self) arg1 arg2 arg3))



(defmethod NEW ((self MULTI-SPHERE-SHAPE) sizeInBytes)
  (MULTI-SPHERE-SHAPE/MAKE-CPLUS-PLUS-INSTANCE (ff-pointer self) sizeInBytes))

(defmethod BULLET/DELETE ((self MULTI-SPHERE-SHAPE) ptr)
  (MULTI-SPHERE-SHAPE/DELETE-CPLUS-PLUS-INSTANCE (ff-pointer self) ptr))

(defmethod NEW ((self MULTI-SPHERE-SHAPE) arg1 ptr)
  (MULTI-SPHERE-SHAPE/MAKE-CPLUS-PLUS-INSTANCE (ff-pointer self) arg1 ptr))

(defmethod BULLET/DELETE ((self MULTI-SPHERE-SHAPE) arg1 arg2)
  (MULTI-SPHERE-SHAPE/DELETE-CPLUS-PLUS-INSTANCE (ff-pointer self) arg1 arg2))

(shadow "new[]")
(defmethod NEW[] ((self MULTI-SPHERE-SHAPE) sizeInBytes)
  (MULTI-SPHERE-SHAPE/MAKE-CPLUS-ARRAY (ff-pointer self) sizeInBytes))

(shadow "delete[]")
(defmethod DELETE[] ((self MULTI-SPHERE-SHAPE) ptr)
  (MULTI-SPHERE-SHAPE/DELETE-CPLUS-ARRAY (ff-pointer self) ptr))

(shadow "new[]")
(defmethod NEW[] ((self MULTI-SPHERE-SHAPE) arg1 ptr)
  (MULTI-SPHERE-SHAPE/MAKE-CPLUS-ARRAY (ff-pointer self) arg1 ptr))

(shadow "delete[]")
(defmethod DELETE[] ((self MULTI-SPHERE-SHAPE) arg1 arg2)
  (MULTI-SPHERE-SHAPE/DELETE-CPLUS-ARRAY (ff-pointer self) arg1 arg2))

(defmethod initialize-instance :after ((obj MULTI-SPHERE-SHAPE) &key (positions VECTOR-3) radi (numSpheres integer))
  (setf (slot-value obj 'ff-pointer) (MAKE-MULTI-SPHERE-SHAPE positions radi numSpheres)))

(defmethod CALCULATE-LOCAL-INERTIA ((self MULTI-SPHERE-SHAPE) (mass number) (inertia VECTOR-3))
  (MULTI-SPHERE-SHAPE/CALCULATE-LOCAL-INERTIA (ff-pointer self) mass inertia))

(defmethod LOCAL-GET-SUPPORTING-VERTEX-WITHOUT-MARGIN ((self MULTI-SPHERE-SHAPE) (vec VECTOR-3))
  (MULTI-SPHERE-SHAPE/LOCAL-GET-SUPPORTING-VERTEX-WITHOUT-MARGIN (ff-pointer self) vec))

(defmethod BATCHED-UNIT-VECTOR-GET-SUPPORTING-VERTEX-WITHOUT-MARGIN ((self MULTI-SPHERE-SHAPE) (vectors VECTOR-3) (supportVerticesOut VECTOR-3) (numVectors integer))
  (MULTI-SPHERE-SHAPE/BATCHED-UNIT-VECTOR-GET-SUPPORTING-VERTEX-WITHOUT-MARGIN (ff-pointer self) vectors supportVerticesOut numVectors))

(defmethod SPHERE-COUNT ((self MULTI-SPHERE-SHAPE))
  (MULTI-SPHERE-SHAPE/GET-SPHERE-COUNT (ff-pointer self)))

(defmethod SPHERE-POSITION ((self MULTI-SPHERE-SHAPE) (index integer))
  (MULTI-SPHERE-SHAPE/GET-SPHERE-POSITION (ff-pointer self) index))

(defmethod SPHERE-RADIUS ((self MULTI-SPHERE-SHAPE) (index integer))
  (MULTI-SPHERE-SHAPE/GET-SPHERE-RADIUS (ff-pointer self) index))

(defmethod NAME ((self MULTI-SPHERE-SHAPE))
  (MULTI-SPHERE-SHAPE/GET-NAME (ff-pointer self)))

(defmethod CALCULATE-SERIALIZE-BUFFER-SIZE ((self MULTI-SPHERE-SHAPE))
  (MULTI-SPHERE-SHAPE/CALCULATE-SERIALIZE-BUFFER-SIZE (ff-pointer self)))

(defmethod SERIALIZE ((self MULTI-SPHERE-SHAPE) dataBuffer serializer)
  (MULTI-SPHERE-SHAPE/SERIALIZE (ff-pointer self) dataBuffer serializer))



(defmethod NEW ((self UNIFORM-SCALING-SHAPE) sizeInBytes)
  (UNIFORM-SCALING-SHAPE/MAKE-CPLUS-PLUS-INSTANCE (ff-pointer self) sizeInBytes))

(defmethod BULLET/DELETE ((self UNIFORM-SCALING-SHAPE) ptr)
  (UNIFORM-SCALING-SHAPE/DELETE-CPLUS-PLUS-INSTANCE (ff-pointer self) ptr))

(defmethod NEW ((self UNIFORM-SCALING-SHAPE) arg1 ptr)
  (UNIFORM-SCALING-SHAPE/MAKE-CPLUS-PLUS-INSTANCE (ff-pointer self) arg1 ptr))

(defmethod BULLET/DELETE ((self UNIFORM-SCALING-SHAPE) arg1 arg2)
  (UNIFORM-SCALING-SHAPE/DELETE-CPLUS-PLUS-INSTANCE (ff-pointer self) arg1 arg2))

(shadow "new[]")
(defmethod NEW[] ((self UNIFORM-SCALING-SHAPE) sizeInBytes)
  (UNIFORM-SCALING-SHAPE/MAKE-CPLUS-ARRAY (ff-pointer self) sizeInBytes))

(shadow "delete[]")
(defmethod DELETE[] ((self UNIFORM-SCALING-SHAPE) ptr)
  (UNIFORM-SCALING-SHAPE/DELETE-CPLUS-ARRAY (ff-pointer self) ptr))

(shadow "new[]")
(defmethod NEW[] ((self UNIFORM-SCALING-SHAPE) arg1 ptr)
  (UNIFORM-SCALING-SHAPE/MAKE-CPLUS-ARRAY (ff-pointer self) arg1 ptr))

(shadow "delete[]")
(defmethod DELETE[] ((self UNIFORM-SCALING-SHAPE) arg1 arg2)
  (UNIFORM-SCALING-SHAPE/DELETE-CPLUS-ARRAY (ff-pointer self) arg1 arg2))

(defmethod initialize-instance :after ((obj UNIFORM-SCALING-SHAPE) &key convexChildShape (uniformScalingFactor number))
  (setf (slot-value obj 'ff-pointer) (MAKE-UNIFORM-SCALING-SHAPE convexChildShape uniformScalingFactor)))

(defmethod LOCAL-GET-SUPPORTING-VERTEX-WITHOUT-MARGIN ((self UNIFORM-SCALING-SHAPE) (vec VECTOR-3))
  (UNIFORM-SCALING-SHAPE/LOCAL-GET-SUPPORTING-VERTEX-WITHOUT-MARGIN (ff-pointer self) vec))

(defmethod LOCAL-GET-SUPPORTING-VERTEX ((self UNIFORM-SCALING-SHAPE) (vec VECTOR-3))
  (UNIFORM-SCALING-SHAPE/LOCAL-GET-SUPPORTING-VERTEX (ff-pointer self) vec))

(defmethod BATCHED-UNIT-VECTOR-GET-SUPPORTING-VERTEX-WITHOUT-MARGIN ((self UNIFORM-SCALING-SHAPE) (vectors VECTOR-3) (supportVerticesOut VECTOR-3) (numVectors integer))
  (UNIFORM-SCALING-SHAPE/BATCHED-UNIT-VECTOR-GET-SUPPORTING-VERTEX-WITHOUT-MARGIN (ff-pointer self) vectors supportVerticesOut numVectors))

(defmethod CALCULATE-LOCAL-INERTIA ((self UNIFORM-SCALING-SHAPE) (mass number) (inertia VECTOR-3))
  (UNIFORM-SCALING-SHAPE/CALCULATE-LOCAL-INERTIA (ff-pointer self) mass inertia))

(defmethod UNIFORM-SCALING-FACTOR ((self UNIFORM-SCALING-SHAPE))
  (UNIFORM-SCALING-SHAPE/GET-UNIFORM-SCALING-FACTOR (ff-pointer self)))

(defmethod CHILD-SHAPE ((self UNIFORM-SCALING-SHAPE))
  (UNIFORM-SCALING-SHAPE/GET-CHILD-SHAPE (ff-pointer self)))

(defmethod CHILD-SHAPE ((self UNIFORM-SCALING-SHAPE))
  (UNIFORM-SCALING-SHAPE/GET-CHILD-SHAPE (ff-pointer self)))

(defmethod NAME ((self UNIFORM-SCALING-SHAPE))
  (UNIFORM-SCALING-SHAPE/GET-NAME (ff-pointer self)))

(defmethod AABB ((self UNIFORM-SCALING-SHAPE) (t-arg1 TRANSFORM) (aabbMin VECTOR-3) (aabbMax VECTOR-3))
  (UNIFORM-SCALING-SHAPE/GET-AABB (ff-pointer self) t-arg1 aabbMin aabbMax))

(defmethod AABB-SLOW ((self UNIFORM-SCALING-SHAPE) (t-arg1 TRANSFORM) (aabbMin VECTOR-3) (aabbMax VECTOR-3))
  (UNIFORM-SCALING-SHAPE/GET-AABB-SLOW (ff-pointer self) t-arg1 aabbMin aabbMax))

(defmethod (SETF LOCAL-SCALING) ((self UNIFORM-SCALING-SHAPE) (scaling VECTOR-3))
  (UNIFORM-SCALING-SHAPE/SET-LOCAL-SCALING (ff-pointer self) scaling))

(defmethod LOCAL-SCALING ((self UNIFORM-SCALING-SHAPE))
  (UNIFORM-SCALING-SHAPE/GET-LOCAL-SCALING (ff-pointer self)))

(defmethod (SETF MARGIN) ((self UNIFORM-SCALING-SHAPE) (margin number))
  (UNIFORM-SCALING-SHAPE/SET-MARGIN (ff-pointer self) margin))

(defmethod MARGIN ((self UNIFORM-SCALING-SHAPE))
  (UNIFORM-SCALING-SHAPE/GET-MARGIN (ff-pointer self)))

(defmethod NUM-PREFERRED-PENETRATION-DIRECTIONS ((self UNIFORM-SCALING-SHAPE))
  (UNIFORM-SCALING-SHAPE/GET-NUM-PREFERRED-PENETRATION-DIRECTIONS (ff-pointer self)))

(defmethod PREFERRED-PENETRATION-DIRECTION ((self UNIFORM-SCALING-SHAPE) (index integer) (penetrationVector VECTOR-3))
  (UNIFORM-SCALING-SHAPE/GET-PREFERRED-PENETRATION-DIRECTION (ff-pointer self) index penetrationVector))



(defmethod initialize-instance :after ((obj SPHERE-SPHERE-COLLISION-ALGORITHM) &key mf ci col0Wrap col1Wrap)
  (setf (slot-value obj 'ff-pointer) (MAKE-SPHERE-SPHERE-COLLISION-ALGORITHM mf ci col0Wrap col1Wrap)))

(defmethod initialize-instance :after ((obj SPHERE-SPHERE-COLLISION-ALGORITHM) &key ci)
  (setf (slot-value obj 'ff-pointer) (MAKE-SPHERE-SPHERE-COLLISION-ALGORITHM ci)))

(defmethod PROCESS-COLLISION ((self SPHERE-SPHERE-COLLISION-ALGORITHM) body0Wrap body1Wrap dispatchInfo resultOut)
  (SPHERE-SPHERE-COLLISION-ALGORITHM/PROCESS-COLLISION (ff-pointer self) body0Wrap body1Wrap dispatchInfo resultOut))

(defmethod CALCULATE-TIME-OF-IMPACT ((self SPHERE-SPHERE-COLLISION-ALGORITHM) (body0 COLLISION-OBJECT) (body1 COLLISION-OBJECT) dispatchInfo resultOut)
  (SPHERE-SPHERE-COLLISION-ALGORITHM/CALCULATE-TIME-OF-IMPACT (ff-pointer self) body0 body1 dispatchInfo resultOut))

(defmethod ALL-CONTACT-MANIFOLDS ((self SPHERE-SPHERE-COLLISION-ALGORITHM) manifoldArray)
  (SPHERE-SPHERE-COLLISION-ALGORITHM/GET-ALL-CONTACT-MANIFOLDS (ff-pointer self) manifoldArray))



#+ (or)
(defmethod initialize-instance :after ((obj DEFAULT-COLLISION-CONFIGURATION) &key constructionInfo)
  (setf (slot-value obj 'ff-pointer) (MAKE-DEFAULT-COLLISION-CONFIGURATION constructionInfo)))

(defmethod initialize-instance :after ((obj DEFAULT-COLLISION-CONFIGURATION) &key)
  (setf (slot-value obj 'ff-pointer) (MAKE-DEFAULT-COLLISION-CONFIGURATION)))

(defmethod PERSISTENT-MANIFOLD-POOL ((self DEFAULT-COLLISION-CONFIGURATION))
  (DEFAULT-COLLISION-CONFIGURATION/GET-PERSISTENT-MANIFOLD-POOL (ff-pointer self)))

(defmethod COLLISION-ALGORITHM-POOL ((self DEFAULT-COLLISION-CONFIGURATION))
  (DEFAULT-COLLISION-CONFIGURATION/GET-COLLISION-ALGORITHM-POOL (ff-pointer self)))

(defmethod SIMPLEX-SOLVER ((self DEFAULT-COLLISION-CONFIGURATION))
  (DEFAULT-COLLISION-CONFIGURATION/GET-SIMPLEX-SOLVER (ff-pointer self)))

(defmethod COLLISION-ALGORITHM-CREATE-FUNC ((self DEFAULT-COLLISION-CONFIGURATION) (proxyType0 integer) (proxyType1 integer))
  (DEFAULT-COLLISION-CONFIGURATION/GET-COLLISION-ALGORITHM-CREATE-FUNC (ff-pointer self) proxyType0 proxyType1))

(defmethod (SETF CONVEX-CONVEX-MULTIPOINT-ITERATIONS) ((self DEFAULT-COLLISION-CONFIGURATION) (numPerturbationIterations integer) (minimumPointsPerturbationThreshold integer))
  (DEFAULT-COLLISION-CONFIGURATION/SET-CONVEX-CONVEX-MULTIPOINT-ITERATIONS (ff-pointer self) numPerturbationIterations minimumPointsPerturbationThreshold))

(defmethod (SETF CONVEX-CONVEX-MULTIPOINT-ITERATIONS) ((self DEFAULT-COLLISION-CONFIGURATION) (numPerturbationIterations integer))
  (DEFAULT-COLLISION-CONFIGURATION/SET-CONVEX-CONVEX-MULTIPOINT-ITERATIONS (ff-pointer self) numPerturbationIterations))

(defmethod (SETF CONVEX-CONVEX-MULTIPOINT-ITERATIONS) ((self DEFAULT-COLLISION-CONFIGURATION))
  (DEFAULT-COLLISION-CONFIGURATION/SET-CONVEX-CONVEX-MULTIPOINT-ITERATIONS (ff-pointer self)))

(defmethod (SETF PLANE-CONVEX-MULTIPOINT-ITERATIONS) ((self DEFAULT-COLLISION-CONFIGURATION) (numPerturbationIterations integer) (minimumPointsPerturbationThreshold integer))
  (DEFAULT-COLLISION-CONFIGURATION/SET-PLANE-CONVEX-MULTIPOINT-ITERATIONS (ff-pointer self) numPerturbationIterations minimumPointsPerturbationThreshold))

(defmethod (SETF PLANE-CONVEX-MULTIPOINT-ITERATIONS) ((self DEFAULT-COLLISION-CONFIGURATION) (numPerturbationIterations integer))
  (DEFAULT-COLLISION-CONFIGURATION/SET-PLANE-CONVEX-MULTIPOINT-ITERATIONS (ff-pointer self) numPerturbationIterations))

(defmethod (SETF PLANE-CONVEX-MULTIPOINT-ITERATIONS) ((self DEFAULT-COLLISION-CONFIGURATION))
  (DEFAULT-COLLISION-CONFIGURATION/SET-PLANE-CONVEX-MULTIPOINT-ITERATIONS (ff-pointer self)))



(defmethod DISPATCHER-FLAGS ((self COLLISION-DISPATCHER))
  (COLLISION-DISPATCHER/GET-DISPATCHER-FLAGS (ff-pointer self)))

(defmethod (SETF DISPATCHER-FLAGS) ((self COLLISION-DISPATCHER) (flags integer))
  (COLLISION-DISPATCHER/SET-DISPATCHER-FLAGS (ff-pointer self) flags))

(defmethod REGISTER-COLLISION-CREATE-FUNC ((self COLLISION-DISPATCHER) (proxyType0 integer) (proxyType1 integer) createFunc)
  (COLLISION-DISPATCHER/REGISTER-COLLISION-CREATE-FUNC (ff-pointer self) proxyType0 proxyType1 createFunc))

(defmethod NUM-MANIFOLDS ((self COLLISION-DISPATCHER))
  (COLLISION-DISPATCHER/GET-NUM-MANIFOLDS (ff-pointer self)))

(defmethod INTERNAL-MANIFOLD-POINTER ((self COLLISION-DISPATCHER))
  (COLLISION-DISPATCHER/GET-INTERNAL-MANIFOLD-POINTER (ff-pointer self)))

(defmethod MANIFOLD-BY-INDEX-INTERNAL ((self COLLISION-DISPATCHER) (index integer))
  (COLLISION-DISPATCHER/GET-MANIFOLD-BY-INDEX-INTERNAL (ff-pointer self) index))

(defmethod MANIFOLD-BY-INDEX-INTERNAL ((self COLLISION-DISPATCHER) (index integer))
  (COLLISION-DISPATCHER/GET-MANIFOLD-BY-INDEX-INTERNAL (ff-pointer self) index))

(defmethod initialize-instance :after ((obj COLLISION-DISPATCHER) &key collisionConfiguration)
  (setf (slot-value obj 'ff-pointer) (MAKE-COLLISION-DISPATCHER collisionConfiguration)))

(defmethod NEW-MANIFOLD ((self COLLISION-DISPATCHER) (b0 COLLISION-OBJECT) (b1 COLLISION-OBJECT))
  (COLLISION-DISPATCHER/GET-NEW-MANIFOLD (ff-pointer self) b0 b1))

(defmethod RELEASE-MANIFOLD ((self COLLISION-DISPATCHER) manifold)
  (COLLISION-DISPATCHER/RELEASE-MANIFOLD (ff-pointer self) manifold))

(defmethod CLEAR-MANIFOLD ((self COLLISION-DISPATCHER) manifold)
  (COLLISION-DISPATCHER/CLEAR-MANIFOLD (ff-pointer self) manifold))

(defmethod FIND-ALGORITHM ((self COLLISION-DISPATCHER) body0Wrap body1Wrap sharedManifold)
  (COLLISION-DISPATCHER/FIND-ALGORITHM (ff-pointer self) body0Wrap body1Wrap sharedManifold))

(defmethod FIND-ALGORITHM ((self COLLISION-DISPATCHER) body0Wrap body1Wrap)
  (COLLISION-DISPATCHER/FIND-ALGORITHM (ff-pointer self) body0Wrap body1Wrap))

(defmethod NEEDS-COLLISION ((self COLLISION-DISPATCHER) (body0 COLLISION-OBJECT) (body1 COLLISION-OBJECT))
  (COLLISION-DISPATCHER/NEEDS-COLLISION (ff-pointer self) body0 body1))

(defmethod NEEDS-RESPONSE ((self COLLISION-DISPATCHER) (body0 COLLISION-OBJECT) (body1 COLLISION-OBJECT))
  (COLLISION-DISPATCHER/NEEDS-RESPONSE (ff-pointer self) body0 body1))

(defmethod DISPATCH-ALL-COLLISION-PAIRS ((self COLLISION-DISPATCHER) pairCache dispatchInfo dispatcher)
  (COLLISION-DISPATCHER/DISPATCH-ALL-COLLISION-PAIRS (ff-pointer self) pairCache dispatchInfo dispatcher))

(defmethod (SETF NEAR-CALLBACK) ((self COLLISION-DISPATCHER) nearCallback)
  (COLLISION-DISPATCHER/SET-NEAR-CALLBACK (ff-pointer self) nearCallback))

(defmethod NEAR-CALLBACK ((self COLLISION-DISPATCHER))
  (COLLISION-DISPATCHER/GET-NEAR-CALLBACK (ff-pointer self)))

(defmethod ALLOCATE-COLLISION-ALGORITHM ((self COLLISION-DISPATCHER) (size integer))
  (COLLISION-DISPATCHER/ALLOCATE-COLLISION-ALGORITHM (ff-pointer self) size))

(defmethod FREE-COLLISION-ALGORITHM ((self COLLISION-DISPATCHER) ptr)
  (COLLISION-DISPATCHER/FREE-COLLISION-ALGORITHM (ff-pointer self) ptr))

(defmethod COLLISION-CONFIGURATION ((self COLLISION-DISPATCHER))
  (COLLISION-DISPATCHER/GET-COLLISION-CONFIGURATION (ff-pointer self)))

(defmethod COLLISION-CONFIGURATION ((self COLLISION-DISPATCHER))
  (COLLISION-DISPATCHER/GET-COLLISION-CONFIGURATION (ff-pointer self)))

(defmethod (SETF COLLISION-CONFIGURATION) ((self COLLISION-DISPATCHER) config)
  (COLLISION-DISPATCHER/SET-COLLISION-CONFIGURATION (ff-pointer self) config))

(defmethod INTERNAL-MANIFOLD-POOL ((self COLLISION-DISPATCHER))
  (COLLISION-DISPATCHER/GET-INTERNAL-MANIFOLD-POOL (ff-pointer self)))

(defmethod INTERNAL-MANIFOLD-POOL ((self COLLISION-DISPATCHER))
  (COLLISION-DISPATCHER/GET-INTERNAL-MANIFOLD-POOL (ff-pointer self)))



(defmethod initialize-instance :after ((obj simple-broadphase) &key (maxProxies integer) overlappingPairCache)
  (setf (slot-value obj 'ff-pointer) (MAKE-SIMPLE-BROADPHASE maxProxies overlappingPairCache)))

(defmethod initialize-instance :after ((obj SIMPLE-BROADPHASE) &key (maxProxies integer))
  (setf (slot-value obj 'ff-pointer) (MAKE-SIMPLE-BROADPHASE maxProxies)))

(defmethod initialize-instance :after ((obj SIMPLE-BROADPHASE) &key)
  (setf (slot-value obj 'ff-pointer) (MAKE-SIMPLE-BROADPHASE)))

(defmethod CREATE-PROXY ((self SIMPLE-BROADPHASE) (aabbMin VECTOR-3) (aabbMax VECTOR-3) (shapeType integer) userPtr (collisionFilterGroup integer) (collisionFilterMask integer) dispatcher multiSapProxy)
  (SIMPLE-BROADPHASE/CREATE-PROXY (ff-pointer self) aabbMin aabbMax shapeType userPtr collisionFilterGroup collisionFilterMask dispatcher multiSapProxy))

(defmethod CALCULATE-OVERLAPPING-PAIRS ((self SIMPLE-BROADPHASE) dispatcher)
  (SIMPLE-BROADPHASE/CALCULATE-OVERLAPPING-PAIRS (ff-pointer self) dispatcher))

(defmethod DESTROY-PROXY ((self SIMPLE-BROADPHASE) proxy dispatcher)
  (SIMPLE-BROADPHASE/DESTROY-PROXY (ff-pointer self) proxy dispatcher))

(defmethod (SETF AABB) ((self SIMPLE-BROADPHASE) proxy (aabbMin VECTOR-3) (aabbMax VECTOR-3) dispatcher)
  (SIMPLE-BROADPHASE/SET-AABB (ff-pointer self) proxy aabbMin aabbMax dispatcher))

(defmethod AABB ((self SIMPLE-BROADPHASE) proxy (aabbMin VECTOR-3) (aabbMax VECTOR-3))
  (SIMPLE-BROADPHASE/GET-AABB (ff-pointer self) proxy aabbMin aabbMax))

(defmethod RAY-TEST ((self SIMPLE-BROADPHASE) (rayFrom VECTOR-3) (rayTo VECTOR-3) rayCallback (aabbMin VECTOR-3) (aabbMax VECTOR-3))
  (SIMPLE-BROADPHASE/RAY-TEST (ff-pointer self) rayFrom rayTo rayCallback aabbMin aabbMax))

(defmethod RAY-TEST ((self SIMPLE-BROADPHASE) (rayFrom VECTOR-3) (rayTo VECTOR-3) rayCallback (aabbMin VECTOR-3))
  (SIMPLE-BROADPHASE/RAY-TEST (ff-pointer self) rayFrom rayTo rayCallback aabbMin))

(defmethod RAY-TEST ((self SIMPLE-BROADPHASE) (rayFrom VECTOR-3) (rayTo VECTOR-3) rayCallback)
  (SIMPLE-BROADPHASE/RAY-TEST (ff-pointer self) rayFrom rayTo rayCallback))

(defmethod AABB-TEST ((self SIMPLE-BROADPHASE) (aabbMin VECTOR-3) (aabbMax VECTOR-3) callback)
  (SIMPLE-BROADPHASE/AABB-TEST (ff-pointer self) aabbMin aabbMax callback))

(defmethod OVERLAPPING-PAIR-CACHE ((self SIMPLE-BROADPHASE))
  (SIMPLE-BROADPHASE/GET-OVERLAPPING-PAIR-CACHE (ff-pointer self)))

(defmethod OVERLAPPING-PAIR-CACHE ((self SIMPLE-BROADPHASE))
  (SIMPLE-BROADPHASE/GET-OVERLAPPING-PAIR-CACHE (ff-pointer self)))

(defmethod TEST-AABB-OVERLAP ((self SIMPLE-BROADPHASE) proxy0 proxy1)
  (SIMPLE-BROADPHASE/TEST-AABB-OVERLAP (ff-pointer self) proxy0 proxy1))

(defmethod BROADPHASE-AABB ((self SIMPLE-BROADPHASE) (aabbMin VECTOR-3) (aabbMax VECTOR-3))
  (SIMPLE-BROADPHASE/GET-BROADPHASE-AABB (ff-pointer self) aabbMin aabbMax))

(defmethod PRINT-STATS ((self SIMPLE-BROADPHASE))
  (SIMPLE-BROADPHASE/PRINT-STATS (ff-pointer self)))



(defmethod initialize-instance :after ((obj AXIS-SWEEP-3) &key (worldAabbMin VECTOR-3) (worldAabbMax VECTOR-3) (maxHandles integer) pairCache (disableRaycastAccelerator t))
  (setf (slot-value obj 'ff-pointer) (MAKE-AXIS-SWEEP-3 worldAabbMin worldAabbMax maxHandles pairCache disableRaycastAccelerator)))

(defmethod initialize-instance :after ((obj AXIS-SWEEP-3) &key (worldAabbMin VECTOR-3) (worldAabbMax VECTOR-3) (maxHandles integer) pairCache)
  (setf (slot-value obj 'ff-pointer) (MAKE-AXIS-SWEEP-3 worldAabbMin worldAabbMax maxHandles pairCache)))

(defmethod initialize-instance :after ((obj AXIS-SWEEP-3) &key (worldAabbMin VECTOR-3) (worldAabbMax VECTOR-3) (maxHandles integer))
  (setf (slot-value obj 'ff-pointer) (MAKE-AXIS-SWEEP-3 worldAabbMin worldAabbMax maxHandles)))

(defmethod initialize-instance :after ((obj AXIS-SWEEP-3) &key (worldAabbMin VECTOR-3) (worldAabbMax VECTOR-3))
  (setf (slot-value obj 'ff-pointer) (MAKE-AXIS-SWEEP-3 worldAabbMin worldAabbMax)))



(defmethod initialize-instance :after ((obj 32-BIT-AXIS-SWEEP-3) &key (worldAabbMin VECTOR-3) (worldAabbMax VECTOR-3) (maxHandles integer) pairCache (disableRaycastAccelerator t))
  (setf (slot-value obj 'ff-pointer) (MAKE-32-BIT-AXIS-SWEEP-3 worldAabbMin worldAabbMax maxHandles pairCache disableRaycastAccelerator)))

(defmethod initialize-instance :after ((obj 32-BIT-AXIS-SWEEP-3) &key (worldAabbMin VECTOR-3) (worldAabbMax VECTOR-3) (maxHandles integer) pairCache)
  (setf (slot-value obj 'ff-pointer) (MAKE-32-BIT-AXIS-SWEEP-3 worldAabbMin worldAabbMax maxHandles pairCache)))

(defmethod initialize-instance :after ((obj 32-BIT-AXIS-SWEEP-3) &key (worldAabbMin VECTOR-3) (worldAabbMax VECTOR-3) (maxHandles integer))
  (setf (slot-value obj 'ff-pointer) (MAKE-32-BIT-AXIS-SWEEP-3 worldAabbMin worldAabbMax maxHandles)))

(defmethod initialize-instance :after ((obj 32-BIT-AXIS-SWEEP-3) &key (worldAabbMin VECTOR-3) (worldAabbMax VECTOR-3))
  (setf (slot-value obj 'ff-pointer) (MAKE-32-BIT-AXIS-SWEEP-3 worldAabbMin worldAabbMax)))



(defmethod BROADPHASE-ARRAY ((self MULTI-SAP-BROADPHASE))
  (MULTI-SAP-BROADPHASE/GET-BROADPHASE-ARRAY (ff-pointer self)))

(defmethod BROADPHASE-ARRAY ((self MULTI-SAP-BROADPHASE))
  (MULTI-SAP-BROADPHASE/GET-BROADPHASE-ARRAY (ff-pointer self)))

(defmethod CREATE-PROXY ((self MULTI-SAP-BROADPHASE) (aabbMin VECTOR-3) (aabbMax VECTOR-3) (shapeType integer) userPtr (collisionFilterGroup integer) (collisionFilterMask integer) dispatcher multiSapProxy)
  (MULTI-SAP-BROADPHASE/CREATE-PROXY (ff-pointer self) aabbMin aabbMax shapeType userPtr collisionFilterGroup collisionFilterMask dispatcher multiSapProxy))

(defmethod DESTROY-PROXY ((self MULTI-SAP-BROADPHASE) proxy dispatcher)
  (MULTI-SAP-BROADPHASE/DESTROY-PROXY (ff-pointer self) proxy dispatcher))

(defmethod (SETF AABB) ((self MULTI-SAP-BROADPHASE) proxy (aabbMin VECTOR-3) (aabbMax VECTOR-3) dispatcher)
  (MULTI-SAP-BROADPHASE/SET-AABB (ff-pointer self) proxy aabbMin aabbMax dispatcher))

(defmethod AABB ((self MULTI-SAP-BROADPHASE) proxy (aabbMin VECTOR-3) (aabbMax VECTOR-3))
  (MULTI-SAP-BROADPHASE/GET-AABB (ff-pointer self) proxy aabbMin aabbMax))

(defmethod RAY-TEST ((self MULTI-SAP-BROADPHASE) (rayFrom VECTOR-3) (rayTo VECTOR-3) rayCallback (aabbMin VECTOR-3) (aabbMax VECTOR-3))
  (MULTI-SAP-BROADPHASE/RAY-TEST (ff-pointer self) rayFrom rayTo rayCallback aabbMin aabbMax))

(defmethod RAY-TEST ((self MULTI-SAP-BROADPHASE) (rayFrom VECTOR-3) (rayTo VECTOR-3) rayCallback (aabbMin VECTOR-3))
  (MULTI-SAP-BROADPHASE/RAY-TEST (ff-pointer self) rayFrom rayTo rayCallback aabbMin))

(defmethod RAY-TEST ((self MULTI-SAP-BROADPHASE) (rayFrom VECTOR-3) (rayTo VECTOR-3) rayCallback)
  (MULTI-SAP-BROADPHASE/RAY-TEST (ff-pointer self) rayFrom rayTo rayCallback))

(defmethod ADD-TO-CHILD-BROADPHASE ((self MULTI-SAP-BROADPHASE) parentMultiSapProxy childProxy childBroadphase)
  (MULTI-SAP-BROADPHASE/ADD-TO-CHILD-BROADPHASE (ff-pointer self) parentMultiSapProxy childProxy childBroadphase))

(defmethod CALCULATE-OVERLAPPING-PAIRS ((self MULTI-SAP-BROADPHASE) dispatcher)
  (MULTI-SAP-BROADPHASE/CALCULATE-OVERLAPPING-PAIRS (ff-pointer self) dispatcher))

(defmethod TEST-AABB-OVERLAP ((self MULTI-SAP-BROADPHASE) proxy0 proxy1)
  (MULTI-SAP-BROADPHASE/TEST-AABB-OVERLAP (ff-pointer self) proxy0 proxy1))

(defmethod OVERLAPPING-PAIR-CACHE ((self MULTI-SAP-BROADPHASE))
  (MULTI-SAP-BROADPHASE/GET-OVERLAPPING-PAIR-CACHE (ff-pointer self)))

(defmethod OVERLAPPING-PAIR-CACHE ((self MULTI-SAP-BROADPHASE))
  (MULTI-SAP-BROADPHASE/GET-OVERLAPPING-PAIR-CACHE (ff-pointer self)))

(defmethod BROADPHASE-AABB ((self MULTI-SAP-BROADPHASE) (aabbMin VECTOR-3) (aabbMax VECTOR-3))
  (MULTI-SAP-BROADPHASE/GET-BROADPHASE-AABB (ff-pointer self) aabbMin aabbMax))

(defmethod BUILD-TREE ((self MULTI-SAP-BROADPHASE) (bvhAabbMin VECTOR-3) (bvhAabbMax VECTOR-3))
  (MULTI-SAP-BROADPHASE/BUILD-TREE (ff-pointer self) bvhAabbMin bvhAabbMax))

(defmethod PRINT-STATS ((self MULTI-SAP-BROADPHASE))
  (MULTI-SAP-BROADPHASE/PRINT-STATS (ff-pointer self)))

(defmethod QUICKSORT ((self MULTI-SAP-BROADPHASE) a (lo integer) (hi integer))
  (MULTI-SAP-BROADPHASE/QUICKSORT (ff-pointer self) a lo hi))

(defmethod RESET-POOL ((self MULTI-SAP-BROADPHASE) dispatcher)
  (MULTI-SAP-BROADPHASE/RESET-POOL (ff-pointer self) dispatcher))



(defmethod initialize-instance :after ((obj CLOCK) &key)
  (setf (slot-value obj 'ff-pointer) (MAKE-CLOCK)))

(defmethod initialize-instance :after ((obj CLOCK) &key (other CLOCK))
  (setf (slot-value obj 'ff-pointer) (MAKE-CLOCK (ff-pointer other))))

(shadow "=")
(defmethod BULLET/= ((self CLOCK) (other CLOCK))
  (CLOCK/ASSIGN-VALUE (ff-pointer self) (ff-pointer other)))

(defmethod RESET ((self CLOCK))
  (CLOCK/RESET (ff-pointer self)))

(defmethod TIME-MILLISECONDS ((self CLOCK))
  (CLOCK/GET-TIME-MILLISECONDS (ff-pointer self)))

(defmethod TIME-MICROSECONDS ((self CLOCK))
  (CLOCK/GET-TIME-MICROSECONDS (ff-pointer self)))



(defmethod initialize-instance :after ((obj CPROFILE-NODE) &key (name string) (parent CPROFILE-NODE))
  (setf (slot-value obj 'ff-pointer) (MAKE-CPROFILE-NODE name (ff-pointer parent))))

(defmethod SUB-NODE ((self CPROFILE-NODE) (name string))
  (CPROFILE-NODE/GET/SUB/NODE (ff-pointer self) name))

(defmethod PARENT ((self CPROFILE-NODE))
  (CPROFILE-NODE/GET/PARENT (ff-pointer self)))

(defmethod SIBLING ((self CPROFILE-NODE))
  (CPROFILE-NODE/GET/SIBLING (ff-pointer self)))

(defmethod CHILD ((self CPROFILE-NODE))
  (CPROFILE-NODE/GET/CHILD (ff-pointer self)))

(defmethod CLEANUP-MEMORY ((self CPROFILE-NODE))
  (CPROFILE-NODE/CLEANUP-MEMORY (ff-pointer self)))

(defmethod RESET ((self CPROFILE-NODE))
  (CPROFILE-NODE/RESET (ff-pointer self)))

(defmethod CALL ((self CPROFILE-NODE))
  (CPROFILE-NODE/CALL (ff-pointer self)))

(defmethod BULLET/RETURN ((self CPROFILE-NODE))
  (CPROFILE-NODE/RETURN (ff-pointer self)))

(defmethod NAME ((self CPROFILE-NODE))
  (CPROFILE-NODE/GET/NAME (ff-pointer self)))

(defmethod TOTAL-CALLS ((self CPROFILE-NODE))
  (CPROFILE-NODE/GET/TOTAL/CALLS (ff-pointer self)))

(defmethod TOTAL-TIME ((self CPROFILE-NODE))
  (CPROFILE-NODE/GET/TOTAL/TIME (ff-pointer self)))

(defmethod USER-POINTER ((self CPROFILE-NODE))
  (CPROFILE-NODE/GET-USER-POINTER (ff-pointer self)))

(defmethod (SETF USER-POINTER) ((self CPROFILE-NODE) ptr)
  (CPROFILE-NODE/SET-USER-POINTER (ff-pointer self) ptr))



(defmethod BULLET/FIRST ((self CPROFILE-ITERATOR))
  (CPROFILE-ITERATOR/FIRST (ff-pointer self)))

(defmethod NEXT ((self CPROFILE-ITERATOR))
  (CPROFILE-ITERATOR/NEXT (ff-pointer self)))

(defmethod DONEP ((self CPROFILE-ITERATOR))
  (CPROFILE-ITERATOR/IS/DONE (ff-pointer self)))

(defmethod ROOTP ((self CPROFILE-ITERATOR))
  (CPROFILE-ITERATOR/IS/ROOT (ff-pointer self)))

(defmethod ENTER-CHILD ((self CPROFILE-ITERATOR) (index integer))
  (CPROFILE-ITERATOR/ENTER/CHILD (ff-pointer self) index))

(defmethod ENTER-LARGEST-CHILD ((self CPROFILE-ITERATOR))
  (CPROFILE-ITERATOR/ENTER/LARGEST/CHILD (ff-pointer self)))

(defmethod ENTER-PARENT ((self CPROFILE-ITERATOR))
  (CPROFILE-ITERATOR/ENTER/PARENT (ff-pointer self)))

(defmethod CURRENT-NAME ((self CPROFILE-ITERATOR))
  (CPROFILE-ITERATOR/GET/CURRENT/NAME (ff-pointer self)))

(defmethod CURRENT-TOTAL-CALLS ((self CPROFILE-ITERATOR))
  (CPROFILE-ITERATOR/GET/CURRENT/TOTAL/CALLS (ff-pointer self)))

(defmethod CURRENT-TOTAL-TIME ((self CPROFILE-ITERATOR))
  (CPROFILE-ITERATOR/GET/CURRENT/TOTAL/TIME (ff-pointer self)))

(defmethod CURRENT-USER-POINTER ((self CPROFILE-ITERATOR))
  (CPROFILE-ITERATOR/GET/CURRENT/USER-POINTER (ff-pointer self)))

(defmethod (SETF CURRENT-USER-POINTER) ((self CPROFILE-ITERATOR) ptr)
  (CPROFILE-ITERATOR/SET/CURRENT/USER-POINTER (ff-pointer self) ptr))

(defmethod CURRENT-PARENT-NAME ((self CPROFILE-ITERATOR))
  (CPROFILE-ITERATOR/GET/CURRENT/PARENT/NAME (ff-pointer self)))

(defmethod CURRENT-PARENT-TOTAL-CALLS ((self CPROFILE-ITERATOR))
  (CPROFILE-ITERATOR/GET/CURRENT/PARENT/TOTAL/CALLS (ff-pointer self)))

(defmethod CURRENT-PARENT-TOTAL-TIME ((self CPROFILE-ITERATOR))
  (CPROFILE-ITERATOR/GET/CURRENT/PARENT/TOTAL/TIME (ff-pointer self)))



(defmethod initialize-instance :after ((obj CPROFILE-MANAGER) &key)
  (setf (slot-value obj 'ff-pointer) (MAKE-CPROFILE-MANAGER)))



(defmethod initialize-instance :after ((obj CPROFILE-SAMPLE) &key (name string))
  (setf (slot-value obj 'ff-pointer) (MAKE-CPROFILE-SAMPLE name)))



(defmethod DRAW-LINE ((self IDEBUG-DRAW) (from VECTOR-3) (to VECTOR-3) (color VECTOR-3))
  (IDEBUG-DRAW/DRAW-LINE (ff-pointer self) from to color))

(defmethod DRAW-LINE ((self IDEBUG-DRAW) (from VECTOR-3) (to VECTOR-3) (fromColor VECTOR-3) (toColor VECTOR-3))
  (IDEBUG-DRAW/DRAW-LINE (ff-pointer self) from to fromColor toColor))

(defmethod DRAW-SPHERE ((self IDEBUG-DRAW) (radius number) (transform TRANSFORM) (color VECTOR-3))
  (IDEBUG-DRAW/DRAW-SPHERE (ff-pointer self) radius transform color))

(defmethod DRAW-SPHERE ((self IDEBUG-DRAW) (p VECTOR-3) (radius number) (color VECTOR-3))
  (IDEBUG-DRAW/DRAW-SPHERE (ff-pointer self) p radius color))

(defmethod DRAW-TRIANGLE ((self IDEBUG-DRAW) (v0 VECTOR-3) (v1 VECTOR-3) (v2 VECTOR-3) (arg4 VECTOR-3) (arg5 VECTOR-3) (arg6 VECTOR-3) (color VECTOR-3) (alpha number))
  (IDEBUG-DRAW/DRAW-TRIANGLE (ff-pointer self) v0 v1 v2 arg4 arg5 arg6 color alpha))

(defmethod DRAW-TRIANGLE ((self IDEBUG-DRAW) (v0 VECTOR-3) (v1 VECTOR-3) (v2 VECTOR-3) (color VECTOR-3) (arg5 number))
  (IDEBUG-DRAW/DRAW-TRIANGLE (ff-pointer self) v0 v1 v2 color arg5))

(defmethod DRAW-CONTACT-POINT ((self IDEBUG-DRAW) (PointOnB VECTOR-3) (normalOnB VECTOR-3) (distance number) (lifeTime integer) (color VECTOR-3))
  (IDEBUG-DRAW/DRAW-CONTACT-POINT (ff-pointer self) PointOnB normalOnB distance lifeTime color))

(defmethod REPORT-ERROR-WARNING ((self IDEBUG-DRAW) (warningString string))
  (IDEBUG-DRAW/REPORT-ERROR-WARNING (ff-pointer self) warningString))

(defmethod DRAW-3D-TEXT ((self IDEBUG-DRAW) (location VECTOR-3) (textString string))
  (IDEBUG-DRAW/DRAW-3D-TEXT (ff-pointer self) location textString))

(defmethod (SETF DEBUG-MODE) ((self IDEBUG-DRAW) (debugMode integer))
  (IDEBUG-DRAW/SET-DEBUG-MODE (ff-pointer self) debugMode))

(defmethod DEBUG-MODE ((self IDEBUG-DRAW))
  (IDEBUG-DRAW/GET-DEBUG-MODE (ff-pointer self)))

(defmethod DRAW-AABB ((self IDEBUG-DRAW) (from VECTOR-3) (to VECTOR-3) (color VECTOR-3))
  (IDEBUG-DRAW/DRAW-AABB (ff-pointer self) from to color))

(defmethod DRAW-TRANSFORM ((self IDEBUG-DRAW) (transform TRANSFORM) (orthoLen number))
  (IDEBUG-DRAW/DRAW-TRANSFORM (ff-pointer self) transform orthoLen))

(defmethod DRAW-ARC ((self IDEBUG-DRAW) (center VECTOR-3) (normal VECTOR-3) (axis VECTOR-3) (radiusA number) (radiusB number) (minAngle number) (maxAngle number) (color VECTOR-3) (drawSect t) (stepDegrees number))
  (IDEBUG-DRAW/DRAW-ARC (ff-pointer self) center normal axis radiusA radiusB minAngle maxAngle color drawSect stepDegrees))

(defmethod DRAW-ARC ((self IDEBUG-DRAW) (center VECTOR-3) (normal VECTOR-3) (axis VECTOR-3) (radiusA number) (radiusB number) (minAngle number) (maxAngle number) (color VECTOR-3) (drawSect t))
  (IDEBUG-DRAW/DRAW-ARC (ff-pointer self) center normal axis radiusA radiusB minAngle maxAngle color drawSect))

(defmethod DRAW-SPHERE-PATCH ((self IDEBUG-DRAW) (center VECTOR-3) (up VECTOR-3) (axis VECTOR-3) (radius number) (minTh number) (maxTh number) (minPs number) (maxPs number) (color VECTOR-3) (stepDegrees number) (drawCenter t))
  (IDEBUG-DRAW/DRAW-SPHERE-PATCH (ff-pointer self) center up axis radius minTh maxTh minPs maxPs color stepDegrees drawCenter))

(defmethod DRAW-SPHERE-PATCH ((self IDEBUG-DRAW) (center VECTOR-3) (up VECTOR-3) (axis VECTOR-3) (radius number) (minTh number) (maxTh number) (minPs number) (maxPs number) (color VECTOR-3) (stepDegrees number))
  (IDEBUG-DRAW/DRAW-SPHERE-PATCH (ff-pointer self) center up axis radius minTh maxTh minPs maxPs color stepDegrees))

(defmethod DRAW-SPHERE-PATCH ((self IDEBUG-DRAW) (center VECTOR-3) (up VECTOR-3) (axis VECTOR-3) (radius number) (minTh number) (maxTh number) (minPs number) (maxPs number) (color VECTOR-3))
  (IDEBUG-DRAW/DRAW-SPHERE-PATCH (ff-pointer self) center up axis radius minTh maxTh minPs maxPs color))

(defmethod DRAW-BOX ((self IDEBUG-DRAW) (bbMin VECTOR-3) (bbMax VECTOR-3) (color VECTOR-3))
  (IDEBUG-DRAW/DRAW-BOX (ff-pointer self) bbMin bbMax color))

(defmethod DRAW-BOX ((self IDEBUG-DRAW) (bbMin VECTOR-3) (bbMax VECTOR-3) (trans TRANSFORM) (color VECTOR-3))
  (IDEBUG-DRAW/DRAW-BOX (ff-pointer self) bbMin bbMax trans color))

(defmethod DRAW-CAPSULE ((self IDEBUG-DRAW) (radius number) (halfHeight number) (upAxis integer) (transform TRANSFORM) (color VECTOR-3))
  (IDEBUG-DRAW/DRAW-CAPSULE (ff-pointer self) radius halfHeight upAxis transform color))

(defmethod DRAW-CYLINDER ((self IDEBUG-DRAW) (radius number) (halfHeight number) (upAxis integer) (transform TRANSFORM) (color VECTOR-3))
  (IDEBUG-DRAW/DRAW-CYLINDER (ff-pointer self) radius halfHeight upAxis transform color))

(defmethod DRAW-CONE ((self IDEBUG-DRAW) (radius number) (height number) (upAxis integer) (transform TRANSFORM) (color VECTOR-3))
  (IDEBUG-DRAW/DRAW-CONE (ff-pointer self) radius height upAxis transform color))

(defmethod DRAW-PLANE ((self IDEBUG-DRAW) (planeNormal VECTOR-3) (planeConst number) (transform TRANSFORM) (color VECTOR-3))
  (IDEBUG-DRAW/DRAW-PLANE (ff-pointer self) planeNormal planeConst transform color))



(defmethod (setf CHUNK-CODE) (arg0 (obj CHUNK))
  (CHUNK/M/CHUNK-CODE/SET (ff-pointer obj) arg0))

(defmethod CHUNK-CODE ((obj CHUNK))
  (CHUNK/M/CHUNK-CODE/GET (ff-pointer obj)))

(defmethod (setf BULLET/LENGTH) (arg0 (obj CHUNK))
  (CHUNK/M/LENGTH/SET (ff-pointer obj) arg0))

(defmethod BULLET/LENGTH ((obj CHUNK))
  (CHUNK/M/LENGTH/GET (ff-pointer obj)))

(defmethod (setf OLD-PTR) (arg0 (obj CHUNK))
  (CHUNK/M/OLD-PTR/SET (ff-pointer obj) arg0))

(defmethod OLD-PTR ((obj CHUNK))
  (CHUNK/M/OLD-PTR/GET (ff-pointer obj)))

(defmethod (setf DNA/NR) (arg0 (obj CHUNK))
  (CHUNK/M/DNA/NR/SET (ff-pointer obj) arg0))

(defmethod DNA/NR ((obj CHUNK))
  (CHUNK/M/DNA/NR/GET (ff-pointer obj)))

(defmethod (setf BULLET/NUMBER) (arg0 (obj CHUNK))
  (CHUNK/M/NUMBER/SET (ff-pointer obj) arg0))

(defmethod BULLET/NUMBER ((obj CHUNK))
  (CHUNK/M/NUMBER/GET (ff-pointer obj)))

(defmethod initialize-instance :after ((obj CHUNK) &key)
  (setf (slot-value obj 'ff-pointer) (MAKE-CHUNK)))



(defmethod BUFFER-POINTER ((self SERIALIZER))
  (SERIALIZER/GET-BUFFER-POINTER (ff-pointer self)))

(defmethod CURRENT-BUFFER-SIZE ((self SERIALIZER))
  (SERIALIZER/GET-CURRENT-BUFFER-SIZE (ff-pointer self)))

(defmethod ALLOCATE ((self SERIALIZER) size (numElements integer))
  (SERIALIZER/ALLOCATE (ff-pointer self) size numElements))

(defmethod FINALIZE-CHUNK ((self SERIALIZER) (chunk CHUNK) (structType string) (chunkCode integer) oldPtr)
  (SERIALIZER/FINALIZE-CHUNK (ff-pointer self) chunk structType chunkCode oldPtr))

(defmethod FIND-POINTER ((self SERIALIZER) oldPtr)
  (SERIALIZER/FIND-POINTER (ff-pointer self) oldPtr))

(defmethod UNIQUE-POINTER ((self SERIALIZER) oldPtr)
  (SERIALIZER/GET-UNIQUE-POINTER (ff-pointer self) oldPtr))

(defmethod START-SERIALIZATION ((self SERIALIZER))
  (SERIALIZER/START-SERIALIZATION (ff-pointer self)))

(defmethod FINISH-SERIALIZATION ((self SERIALIZER))
  (SERIALIZER/FINISH-SERIALIZATION (ff-pointer self)))

(defmethod FIND-NAME-FOR-POINTER ((self SERIALIZER) ptr)
  (SERIALIZER/FIND-NAME-FOR-POINTER (ff-pointer self) ptr))

(defmethod REGISTER-NAME-FOR-POINTER ((self SERIALIZER) ptr (name string))
  (SERIALIZER/REGISTER-NAME-FOR-POINTER (ff-pointer self) ptr name))

(defmethod SERIALIZE-NAME ((self SERIALIZER) (ptr string))
  (SERIALIZER/SERIALIZE-NAME (ff-pointer self) ptr))

(defmethod SERIALIZATION-FLAGS ((self SERIALIZER))
  (SERIALIZER/GET-SERIALIZATION-FLAGS (ff-pointer self)))

(defmethod (SETF SERIALIZATION-FLAGS) ((self SERIALIZER) (flags integer))
  (SERIALIZER/SET-SERIALIZATION-FLAGS (ff-pointer self) flags))



(defmethod initialize-instance :after ((obj DEFAULT-SERIALIZER) &key (totalSize integer))
  (setf (slot-value obj 'ff-pointer) (MAKE-DEFAULT-SERIALIZER totalSize)))

(defmethod initialize-instance :after ((obj DEFAULT-SERIALIZER) &key)
  (setf (slot-value obj 'ff-pointer) (MAKE-DEFAULT-SERIALIZER)))

(defmethod WRITE-HEADER ((self DEFAULT-SERIALIZER) buffer)
  (DEFAULT-SERIALIZER/WRITE-HEADER (ff-pointer self) buffer))

(defmethod START-SERIALIZATION ((self DEFAULT-SERIALIZER))
  (DEFAULT-SERIALIZER/START-SERIALIZATION (ff-pointer self)))

(defmethod FINISH-SERIALIZATION ((self DEFAULT-SERIALIZER))
  (DEFAULT-SERIALIZER/FINISH-SERIALIZATION (ff-pointer self)))

(defmethod UNIQUE-POINTER ((self DEFAULT-SERIALIZER) oldPtr)
  (DEFAULT-SERIALIZER/GET-UNIQUE-POINTER (ff-pointer self) oldPtr))

(defmethod BUFFER-POINTER ((self DEFAULT-SERIALIZER))
  (DEFAULT-SERIALIZER/GET-BUFFER-POINTER (ff-pointer self)))

(defmethod CURRENT-BUFFER-SIZE ((self DEFAULT-SERIALIZER))
  (DEFAULT-SERIALIZER/GET-CURRENT-BUFFER-SIZE (ff-pointer self)))

(defmethod FINALIZE-CHUNK ((self DEFAULT-SERIALIZER) (chunk CHUNK) (structType string) (chunkCode integer) oldPtr)
  (DEFAULT-SERIALIZER/FINALIZE-CHUNK (ff-pointer self) chunk structType chunkCode oldPtr))

(defmethod INTERNAL-ALLOC ((self DEFAULT-SERIALIZER) size)
  (DEFAULT-SERIALIZER/INTERNAL-ALLOC (ff-pointer self) size))

(defmethod ALLOCATE ((self DEFAULT-SERIALIZER) size (numElements integer))
  (DEFAULT-SERIALIZER/ALLOCATE (ff-pointer self) size numElements))

(defmethod FIND-NAME-FOR-POINTER ((self DEFAULT-SERIALIZER) ptr)
  (DEFAULT-SERIALIZER/FIND-NAME-FOR-POINTER (ff-pointer self) ptr))

(defmethod REGISTER-NAME-FOR-POINTER ((self DEFAULT-SERIALIZER) ptr (name string))
  (DEFAULT-SERIALIZER/REGISTER-NAME-FOR-POINTER (ff-pointer self) ptr name))

(defmethod SERIALIZE-NAME ((self DEFAULT-SERIALIZER) (name string))
  (DEFAULT-SERIALIZER/SERIALIZE-NAME (ff-pointer self) name))

(defmethod SERIALIZATION-FLAGS ((self DEFAULT-SERIALIZER))
  (DEFAULT-SERIALIZER/GET-SERIALIZATION-FLAGS (ff-pointer self)))

(defmethod (SETF SERIALIZATION-FLAGS) ((self DEFAULT-SERIALIZER) (flags integer))
  (DEFAULT-SERIALIZER/SET-SERIALIZATION-FLAGS (ff-pointer self) flags))



(defmethod NEW ((self DISCRETE-DYNAMICS-WORLD) sizeInBytes)
  (DISCRETE-DYNAMICS-WORLD/MAKE-CPLUS-PLUS-INSTANCE (ff-pointer self) sizeInBytes))

(defmethod BULLET/DELETE ((self DISCRETE-DYNAMICS-WORLD) ptr)
  (DISCRETE-DYNAMICS-WORLD/DELETE-CPLUS-PLUS-INSTANCE (ff-pointer self) ptr))

(defmethod NEW ((self DISCRETE-DYNAMICS-WORLD) arg1 ptr)
  (DISCRETE-DYNAMICS-WORLD/MAKE-CPLUS-PLUS-INSTANCE (ff-pointer self) arg1 ptr))

(defmethod BULLET/DELETE ((self DISCRETE-DYNAMICS-WORLD) arg1 arg2)
  (DISCRETE-DYNAMICS-WORLD/DELETE-CPLUS-PLUS-INSTANCE (ff-pointer self) arg1 arg2))

(shadow "new[]")
(defmethod NEW[] ((self DISCRETE-DYNAMICS-WORLD) sizeInBytes)
  (DISCRETE-DYNAMICS-WORLD/MAKE-CPLUS-ARRAY (ff-pointer self) sizeInBytes))

(shadow "delete[]")
(defmethod DELETE[] ((self DISCRETE-DYNAMICS-WORLD) ptr)
  (DISCRETE-DYNAMICS-WORLD/DELETE-CPLUS-ARRAY (ff-pointer self) ptr))

(shadow "new[]")
(defmethod NEW[] ((self DISCRETE-DYNAMICS-WORLD) arg1 ptr)
  (DISCRETE-DYNAMICS-WORLD/MAKE-CPLUS-ARRAY (ff-pointer self) arg1 ptr))

(shadow "delete[]")
(defmethod DELETE[] ((self DISCRETE-DYNAMICS-WORLD) arg1 arg2)
  (DISCRETE-DYNAMICS-WORLD/DELETE-CPLUS-ARRAY (ff-pointer self) arg1 arg2))

(defmethod initialize-instance :after ((obj DISCRETE-DYNAMICS-WORLD) &key dispatcher pairCache constraintSolver collisionConfiguration)
  (setf (slot-value obj 'ff-pointer) (MAKE-DISCRETE-DYNAMICS-WORLD dispatcher pairCache constraintSolver collisionConfiguration)))

(defmethod STEP-SIMULATION ((self DISCRETE-DYNAMICS-WORLD) (timeStep number) (maxSubSteps integer) (fixedTimeStep number))
  (DISCRETE-DYNAMICS-WORLD/STEP-SIMULATION (ff-pointer self) timeStep maxSubSteps fixedTimeStep))

(defmethod STEP-SIMULATION ((self DISCRETE-DYNAMICS-WORLD) (timeStep number) (maxSubSteps integer))
  (DISCRETE-DYNAMICS-WORLD/STEP-SIMULATION (ff-pointer self) timeStep maxSubSteps))

(defmethod STEP-SIMULATION ((self DISCRETE-DYNAMICS-WORLD) (timeStep number))
  (DISCRETE-DYNAMICS-WORLD/STEP-SIMULATION (ff-pointer self) timeStep))

(defmethod SYNCHRONIZE-MOTION-STATES ((self DISCRETE-DYNAMICS-WORLD))
  (DISCRETE-DYNAMICS-WORLD/SYNCHRONIZE-MOTION-STATES (ff-pointer self)))

(defmethod SYNCHRONIZE-SINGLE-MOTION-STATE ((self DISCRETE-DYNAMICS-WORLD) body)
  (DISCRETE-DYNAMICS-WORLD/SYNCHRONIZE-SINGLE-MOTION-STATE (ff-pointer self) body))

(defmethod ADD-CONSTRAINT ((self DISCRETE-DYNAMICS-WORLD) constraint (disableCollisionsBetweenLinkedBodies t))
  (DISCRETE-DYNAMICS-WORLD/ADD-CONSTRAINT (ff-pointer self) constraint disableCollisionsBetweenLinkedBodies))

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

(defmethod (SETF GRAVITY) ((self DISCRETE-DYNAMICS-WORLD) (gravity VECTOR-3))
  (DISCRETE-DYNAMICS-WORLD/SET-GRAVITY (ff-pointer self) gravity))

(defmethod GRAVITY ((self DISCRETE-DYNAMICS-WORLD))
  (DISCRETE-DYNAMICS-WORLD/GET-GRAVITY (ff-pointer self)))

(defmethod ADD-COLLISION-OBJECT ((self DISCRETE-DYNAMICS-WORLD) (collisionObject COLLISION-OBJECT) (collisionFilterGroup integer) (collisionFilterMask integer))
  (DISCRETE-DYNAMICS-WORLD/ADD-COLLISION-OBJECT (ff-pointer self) collisionObject collisionFilterGroup collisionFilterMask))

(defmethod ADD-COLLISION-OBJECT ((self DISCRETE-DYNAMICS-WORLD) (collisionObject COLLISION-OBJECT) (collisionFilterGroup integer))
  (DISCRETE-DYNAMICS-WORLD/ADD-COLLISION-OBJECT (ff-pointer self) collisionObject collisionFilterGroup))

(defmethod ADD-COLLISION-OBJECT ((self DISCRETE-DYNAMICS-WORLD) (collisionObject COLLISION-OBJECT))
  (DISCRETE-DYNAMICS-WORLD/ADD-COLLISION-OBJECT (ff-pointer self) collisionObject))

(defmethod REMOVE-RIGID-BODY ((self DISCRETE-DYNAMICS-WORLD) body)
  (DISCRETE-DYNAMICS-WORLD/REMOVE-RIGID-BODY (ff-pointer self) body))

(defmethod REMOVE-COLLISION-OBJECT ((self DISCRETE-DYNAMICS-WORLD) (collisionObject COLLISION-OBJECT))
  (DISCRETE-DYNAMICS-WORLD/REMOVE-COLLISION-OBJECT (ff-pointer self) collisionObject))

(defmethod DEBUG-DRAW-CONSTRAINT ((self DISCRETE-DYNAMICS-WORLD) constraint)
  (DISCRETE-DYNAMICS-WORLD/DEBUG-DRAW-CONSTRAINT (ff-pointer self) constraint))

(defmethod DEBUG-DRAW-WORLD ((self DISCRETE-DYNAMICS-WORLD))  (DISCRETE-DYNAMICS-WORLD/DEBUG-DRAW-WORLD (ff-pointer self)))

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

(defmethod SERIALIZE ((self DISCRETE-DYNAMICS-WORLD) (serializer SERIALIZER))
  (DISCRETE-DYNAMICS-WORLD/SERIALIZE (ff-pointer self) serializer))

(defmethod (SETF LATENCY-MOTION-STATE-INTERPOLATION) ((self DISCRETE-DYNAMICS-WORLD) (latencyInterpolation t))
  (DISCRETE-DYNAMICS-WORLD/SET-LATENCY-MOTION-STATE-INTERPOLATION (ff-pointer self) latencyInterpolation))

(defmethod LATENCY-MOTION-STATE-INTERPOLATION ((self (lispify "bt-discrete-dynamics-world" 'classname)))
  (BULLET>  (ff-pointer self)))



(defmethod initialize-instance :after ((obj SIMPLE-DYNAMICS-WORLD) &key dispatcher pairCache constraintSolver collisionConfiguration)
  (setf (slot-value obj 'ff-pointer) (MAKE-SIMPLE-DYNAMICS-WORLD dispatcher pairCache constraintSolver collisionConfiguration)))

(defmethod STEP-SIMULATION ((self SIMPLE-DYNAMICS-WORLD) (timeStep number) (maxSubSteps integer) (fixedTimeStep number))
  (SIMPLE-DYNAMICS-WORLD/STEP-SIMULATION (ff-pointer self) timeStep maxSubSteps fixedTimeStep))

(defmethod STEP-SIMULATION ((self SIMPLE-DYNAMICS-WORLD) (timeStep number) (maxSubSteps integer))
  (SIMPLE-DYNAMICS-WORLD/STEP-SIMULATION (ff-pointer self) timeStep maxSubSteps))

(defmethod STEP-SIMULATION ((self SIMPLE-DYNAMICS-WORLD) (timeStep number))
  (SIMPLE-DYNAMICS-WORLD/STEP-SIMULATION (ff-pointer self) timeStep))

(defmethod (SETF GRAVITY) ((self SIMPLE-DYNAMICS-WORLD) (gravity VECTOR-3))
  (SIMPLE-DYNAMICS-WORLD/SET-GRAVITY (ff-pointer self) gravity))

(defmethod GRAVITY ((self SIMPLE-DYNAMICS-WORLD))
  (SIMPLE-DYNAMICS-WORLD/GET-GRAVITY (ff-pointer self)))

(defmethod ADD-RIGID-BODY ((self SIMPLE-DYNAMICS-WORLD) body)
  (SIMPLE-DYNAMICS-WORLD/ADD-RIGID-BODY (ff-pointer self) body))

(defmethod ADD-RIGID-BODY ((self SIMPLE-DYNAMICS-WORLD) body (group integer) (mask integer))
  (SIMPLE-DYNAMICS-WORLD/ADD-RIGID-BODY (ff-pointer self) body group mask))

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



(defmethod initialize-instance :after ((obj RIGID-BODY) &key constructionInfo)
  (setf (slot-value obj 'ff-pointer) (MAKE-RIGID-BODY constructionInfo)))

(defmethod initialize-instance :after ((obj RIGID-BODY) &key (mass number) (motionState MOTION-STATE) collisionShape (localInertia VECTOR-3))
  (setf (slot-value obj 'ff-pointer) (MAKE-RIGID-BODY mass motionState collisionShape localInertia)))

(defmethod initialize-instance :after ((obj RIGID-BODY) &key (mass number) (motionState MOTION-STATE) collisionShape)
  (setf (slot-value obj 'ff-pointer) (MAKE-RIGID-BODY mass motionState collisionShape)))

(defmethod PROCEED-TO-TRANSFORM ((self RIGID-BODY) (newTrans TRANSFORM))
  (RIGID-BODY/PROCEED-TO-TRANSFORM (ff-pointer self) newTrans))

(defmethod PREDICT-INTEGRATED-TRANSFORM ((self RIGID-BODY) (step number) (predictedTransform TRANSFORM))
  (RIGID-BODY/PREDICT-INTEGRATED-TRANSFORM (ff-pointer self) step predictedTransform))

(defmethod SAVE-KINEMATIC-STATE ((self RIGID-BODY) (step number))
  (RIGID-BODY/SAVE-KINEMATIC-STATE (ff-pointer self) step))

(defmethod APPLY-GRAVITY ((self RIGID-BODY))
  (RIGID-BODY/APPLY-GRAVITY (ff-pointer self)))

(defmethod (SETF GRAVITY) ((self RIGID-BODY) (acceleration VECTOR-3))
  (RIGID-BODY/SET-GRAVITY (ff-pointer self) acceleration))

(defmethod GRAVITY ((self RIGID-BODY))
  (RIGID-BODY/GET-GRAVITY (ff-pointer self)))

(defmethod (SETF DAMPING) ((self RIGID-BODY) (lin_damping number) (ang_damping number))
  (RIGID-BODY/SET-DAMPING (ff-pointer self) lin_damping ang_damping))

(defmethod LINEAR-DAMPING ((self RIGID-BODY))
  (RIGID-BODY/GET-LINEAR-DAMPING (ff-pointer self)))

(defmethod ANGULAR-DAMPING ((self RIGID-BODY))
  (RIGID-BODY/GET-ANGULAR-DAMPING (ff-pointer self)))

(defmethod LINEAR-SLEEPING-THRESHOLD ((self RIGID-BODY))
  (RIGID-BODY/GET-LINEAR-SLEEPING-THRESHOLD (ff-pointer self)))

(defmethod ANGULAR-SLEEPING-THRESHOLD ((self RIGID-BODY))
  (RIGID-BODY/GET-ANGULAR-SLEEPING-THRESHOLD (ff-pointer self)))

(defmethod APPLY-DAMPING ((self RIGID-BODY) (timeStep number))
  (RIGID-BODY/APPLY-DAMPING (ff-pointer self) timeStep))

(defmethod COLLISION-SHAPE ((self RIGID-BODY))
  (RIGID-BODY/GET-COLLISION-SHAPE (ff-pointer self)))

(defmethod COLLISION-SHAPE ((self RIGID-BODY))
  (RIGID-BODY/GET-COLLISION-SHAPE (ff-pointer self)))

(defmethod (SETF MASS-PROPS) ((self RIGID-BODY) (mass number) (inertia VECTOR-3))
  (RIGID-BODY/SET-MASS-PROPS (ff-pointer self) mass inertia))

(defmethod LINEAR-FACTOR ((self RIGID-BODY))
  (RIGID-BODY/GET-LINEAR-FACTOR (ff-pointer self)))

(defmethod (SETF LINEAR-FACTOR) ((self RIGID-BODY) (linearFactor VECTOR-3))
  (RIGID-BODY/SET-LINEAR-FACTOR (ff-pointer self) linearFactor))

(defmethod INV-MASS ((self RIGID-BODY))
  (RIGID-BODY/GET-INV-MASS (ff-pointer self)))

(defmethod INV-INERTIA-TENSOR-WORLD ((self RIGID-BODY))
  (RIGID-BODY/GET-INV-INERTIA-TENSOR-WORLD (ff-pointer self)))

(defmethod INTEGRATE-VELOCITIES ((self RIGID-BODY) (step number))
  (RIGID-BODY/INTEGRATE-VELOCITIES (ff-pointer self) step))

(defmethod (SETF CENTER-OF-MASS-TRANSFORM) ((self RIGID-BODY) (xform TRANSFORM))
  (RIGID-BODY/SET-CENTER-OF-MASS-TRANSFORM (ff-pointer self) xform))

(defmethod APPLY-CENTRAL-FORCE ((self RIGID-BODY) (force VECTOR-3))
  (RIGID-BODY/APPLY-CENTRAL-FORCE (ff-pointer self) force))

(defmethod TOTAL-FORCE ((self RIGID-BODY))
  (RIGID-BODY/GET-TOTAL-FORCE (ff-pointer self)))

(defmethod TOTAL-TORQUE ((self RIGID-BODY))
  (RIGID-BODY/GET-TOTAL-TORQUE (ff-pointer self)))

(defmethod INV-INERTIA-DIAG-LOCAL ((self RIGID-BODY))
  (RIGID-BODY/GET-INV-INERTIA-DIAG-LOCAL (ff-pointer self)))

(defmethod (SETF INV-INERTIA-DIAG-LOCAL) ((self RIGID-BODY) (diagInvInertia VECTOR-3))
  (RIGID-BODY/SET-INV-INERTIA-DIAG-LOCAL (ff-pointer self) diagInvInertia))

(defmethod (SETF SLEEPING-THRESHOLDS) ((self RIGID-BODY) (linear number) (angular number))
  (RIGID-BODY/SET-SLEEPING-THRESHOLDS (ff-pointer self) linear angular))

(defmethod APPLY-TORQUE ((self RIGID-BODY) (torque VECTOR-3))
  (RIGID-BODY/APPLY-TORQUE (ff-pointer self) torque))

(defmethod APPLY-FORCE ((self RIGID-BODY) (force VECTOR-3) (rel_pos VECTOR-3))
  (RIGID-BODY/APPLY-FORCE (ff-pointer self) force rel_pos))

(defmethod APPLY-CENTRAL-IMPULSE ((self RIGID-BODY) (impulse VECTOR-3))
  (RIGID-BODY/APPLY-CENTRAL-IMPULSE (ff-pointer self) impulse))

(defmethod APPLY-TORQUE-IMPULSE ((self RIGID-BODY) (torque VECTOR-3))
  (RIGID-BODY/APPLY-TORQUE-IMPULSE (ff-pointer self) torque))

(defmethod APPLY-IMPULSE ((self RIGID-BODY) (impulse VECTOR-3) (rel_pos VECTOR-3))
  (RIGID-BODY/APPLY-IMPULSE (ff-pointer self) impulse rel_pos))

(defmethod CLEAR-FORCES ((self RIGID-BODY))
  (RIGID-BODY/CLEAR-FORCES (ff-pointer self)))

(defmethod UPDATE-INERTIA-TENSOR ((self RIGID-BODY))
  (RIGID-BODY/UPDATE-INERTIA-TENSOR (ff-pointer self)))

(defmethod CENTER-OF-MASS-POSITION ((self RIGID-BODY))
  (RIGID-BODY/GET-CENTER-OF-MASS-POSITION (ff-pointer self)))

(defmethod ORIENTATION ((self RIGID-BODY))
  (RIGID-BODY/GET-ORIENTATION (ff-pointer self)))

(defmethod CENTER-OF-MASS-TRANSFORM ((self RIGID-BODY))
  (RIGID-BODY/GET-CENTER-OF-MASS-TRANSFORM (ff-pointer self)))

(defmethod LINEAR-VELOCITY ((self RIGID-BODY))
  (RIGID-BODY/GET-LINEAR-VELOCITY (ff-pointer self)))

(defmethod ANGULAR-VELOCITY ((self RIGID-BODY))
  (RIGID-BODY/GET-ANGULAR-VELOCITY (ff-pointer self)))

(defmethod (SETF LINEAR-VELOCITY) ((self RIGID-BODY) (lin_vel VECTOR-3))
  (RIGID-BODY/SET-LINEAR-VELOCITY (ff-pointer self) lin_vel))

(defmethod (SETF ANGULAR-VELOCITY) ((self RIGID-BODY) (ang_vel VECTOR-3))
  (RIGID-BODY/SET-ANGULAR-VELOCITY (ff-pointer self) ang_vel))

(defmethod VELOCITY-IN-LOCAL-POINT ((self RIGID-BODY) (rel_pos VECTOR-3))
  (RIGID-BODY/GET-VELOCITY-IN-LOCAL-POINT (ff-pointer self) rel_pos))

(defmethod TRANSLATE ((self RIGID-BODY) (v VECTOR-3))
  (RIGID-BODY/TRANSLATE (ff-pointer self) v))

(defmethod AABB ((self RIGID-BODY) (aabbMin VECTOR-3) (aabbMax VECTOR-3))
  (RIGID-BODY/GET-AABB (ff-pointer self) aabbMin aabbMax))

(defmethod COMPUTE-IMPULSE-DENOMINATOR ((self RIGID-BODY) (pos VECTOR-3) (normal VECTOR-3))
  (RIGID-BODY/COMPUTE-IMPULSE-DENOMINATOR (ff-pointer self) pos normal))

(defmethod COMPUTE-ANGULAR-IMPULSE-DENOMINATOR ((self RIGID-BODY) (axis VECTOR-3))
  (RIGID-BODY/COMPUTE-ANGULAR-IMPULSE-DENOMINATOR (ff-pointer self) axis))

(defmethod UPDATE-DEACTIVATION ((self RIGID-BODY) (timeStep number))
  (RIGID-BODY/UPDATE-DEACTIVATION (ff-pointer self) timeStep))

(defmethod WANTS-SLEEPING ((self RIGID-BODY))
  (RIGID-BODY/WANTS-SLEEPING (ff-pointer self)))

(defmethod BROADPHASE-PROXY ((self RIGID-BODY))
  (RIGID-BODY/GET-BROADPHASE-PROXY (ff-pointer self)))

(defmethod BROADPHASE-PROXY ((self RIGID-BODY))
  (RIGID-BODY/GET-BROADPHASE-PROXY (ff-pointer self)))

(defmethod (SETF NEW-BROADPHASE-PROXY) ((self RIGID-BODY) broadphaseProxy)
  (RIGID-BODY/SET-NEW-BROADPHASE-PROXY (ff-pointer self) broadphaseProxy))

(defmethod MOTION-STATE ((self RIGID-BODY))
  (RIGID-BODY/GET-MOTION-STATE (ff-pointer self)))

(defmethod MOTION-STATE ((self RIGID-BODY))
  (RIGID-BODY/GET-MOTION-STATE (ff-pointer self)))

(defmethod (SETF MOTION-STATE) ((self RIGID-BODY) (motionState MOTION-STATE))
  (RIGID-BODY/SET-MOTION-STATE (ff-pointer self) motionState))

(defmethod (setf CONTACT-SOLVER-TYPE) (arg0 (obj RIGID-BODY))
  (RIGID-BODY/M/CONTACT-SOLVER-TYPE/SET (ff-pointer obj) arg0))

(defmethod CONTACT-SOLVER-TYPE ((obj RIGID-BODY))
  (RIGID-BODY/M/CONTACT-SOLVER-TYPE/GET (ff-pointer obj)))

(defmethod (setf FRICTION-SOLVER-TYPE) (arg0 (obj RIGID-BODY))
  (RIGID-BODY/M/FRICTION-SOLVER-TYPE/SET (ff-pointer obj) arg0))

(defmethod FRICTION-SOLVER-TYPE ((obj RIGID-BODY))
  (RIGID-BODY/M/FRICTION-SOLVER-TYPE/GET (ff-pointer obj)))

(defmethod (SETF ANGULAR-FACTOR) ((self RIGID-BODY) (angFac VECTOR-3))
  (RIGID-BODY/SET-ANGULAR-FACTOR (ff-pointer self) angFac))

(defmethod (SETF ANGULAR-FACTOR) ((self RIGID-BODY) (angFac number))
  (RIGID-BODY/SET-ANGULAR-FACTOR (ff-pointer self) angFac))

(defmethod ANGULAR-FACTOR ((self RIGID-BODY))
  (RIGID-BODY/GET-ANGULAR-FACTOR (ff-pointer self)))

(defmethod IN-WORLD-P ((self RIGID-BODY))
  (RIGID-BODY/IS-IN-WORLD (ff-pointer self)))

(defmethod CHECK-COLLIDE-WITH-OVERRIDE ((self RIGID-BODY) (co COLLISION-OBJECT))
  (RIGID-BODY/CHECK-COLLIDE-WITH-OVERRIDE (ff-pointer self) co))

(defmethod ADD-CONSTRAINT-REF ((self RIGID-BODY) c)
  (RIGID-BODY/ADD-CONSTRAINT-REF (ff-pointer self) c))

(defmethod REMOVE-CONSTRAINT-REF ((self RIGID-BODY) c)
  (RIGID-BODY/REMOVE-CONSTRAINT-REF (ff-pointer self) c))

(defmethod CONSTRAINT-REF ((self RIGID-BODY) (index integer))
  (RIGID-BODY/GET-CONSTRAINT-REF (ff-pointer self) index))

(defmethod NUM-CONSTRAINT-REFS ((self RIGID-BODY))
  (RIGID-BODY/GET-NUM-CONSTRAINT-REFS (ff-pointer self)))

(defmethod (SETF FLAGS) ((self RIGID-BODY) (flags integer))
  (RIGID-BODY/SET-FLAGS (ff-pointer self) flags))

(defmethod FLAGS ((self RIGID-BODY))
  (RIGID-BODY/GET-FLAGS (ff-pointer self)))

(defmethod COMPUTE-GYROSCOPIC-FORCE ((self RIGID-BODY) (maxGyroscopicForce number))
  (RIGID-BODY/COMPUTE-GYROSCOPIC-FORCE (ff-pointer self) maxGyroscopicForce))

(defmethod CALCULATE-SERIALIZE-BUFFER-SIZE ((self RIGID-BODY))
  (RIGID-BODY/CALCULATE-SERIALIZE-BUFFER-SIZE (ff-pointer self)))

(defmethod SERIALIZE ((self RIGID-BODY) dataBuffer (serializer SERIALIZER))
  (RIGID-BODY/SERIALIZE (ff-pointer self) dataBuffer serializer))

(defmethod SERIALIZE-SINGLE-OBJECT ((self RIGID-BODY) (serializer SERIALIZER))
  (RIGID-BODY/SERIALIZE-SINGLE-OBJECT (ff-pointer self) serializer))



(defmethod NEW ((self TYPED-CONSTRAINT) sizeInBytes)
  (TYPED-CONSTRAINT/MAKE-CPLUS-PLUS-INSTANCE (ff-pointer self) sizeInBytes))

(defmethod BULLET/DELETE ((self TYPED-CONSTRAINT) ptr)
  (TYPED-CONSTRAINT/DELETE-CPLUS-PLUS-INSTANCE (ff-pointer self) ptr))

(defmethod NEW ((self TYPED-CONSTRAINT) arg1 ptr)
  (TYPED-CONSTRAINT/MAKE-CPLUS-PLUS-INSTANCE (ff-pointer self) arg1 ptr))

(defmethod BULLET/DELETE ((self TYPED-CONSTRAINT) arg1 arg2)
  (TYPED-CONSTRAINT/DELETE-CPLUS-PLUS-INSTANCE (ff-pointer self) arg1 arg2))

(shadow "new[]")
(defmethod NEW[] ((self TYPED-CONSTRAINT) sizeInBytes)
  (TYPED-CONSTRAINT/MAKE-CPLUS-ARRAY (ff-pointer self) sizeInBytes))

(shadow "delete[]")
(defmethod DELETE[] ((self TYPED-CONSTRAINT) ptr)
  (TYPED-CONSTRAINT/DELETE-CPLUS-ARRAY (ff-pointer self) ptr))

(shadow "new[]")
(defmethod NEW[] ((self TYPED-CONSTRAINT) arg1 ptr)
  (TYPED-CONSTRAINT/MAKE-CPLUS-ARRAY (ff-pointer self) arg1 ptr))


(defmethod DELETE[] ((self TYPED-CONSTRAINT) arg1 arg2)
  (TYPED-CONSTRAINT/DELETE-CPLUS-ARRAY (ff-pointer self) arg1 arg2))

(defmethod OVERRIDE-NUM-SOLVER-ITERATIONS ((self TYPED-CONSTRAINT))
  (TYPED-CONSTRAINT/GET-OVERRIDE-NUM-SOLVER-ITERATIONS (ff-pointer self)))

(defmethod (SETF OVERRIDE-NUM-SOLVER-ITERATIONS) ((self TYPED-CONSTRAINT) (overideNumIterations integer))
  (TYPED-CONSTRAINT/SET-OVERRIDE-NUM-SOLVER-ITERATIONS (ff-pointer self) overideNumIterations))

(defmethod BUILD-JACOBIAN ((self TYPED-CONSTRAINT))
  (TYPED-CONSTRAINT/BUILD-JACOBIAN (ff-pointer self)))

(defmethod SETUP-SOLVER-CONSTRAINT ((self TYPED-CONSTRAINT) ca (solverBodyA integer) (solverBodyB integer) (timeStep number))
  (TYPED-CONSTRAINT/SETUP-SOLVER-CONSTRAINT (ff-pointer self) ca solverBodyA solverBodyB timeStep))

(defmethod INFO-1 ((self TYPED-CONSTRAINT) info)
  (TYPED-CONSTRAINT/GET-INFO-1 (ff-pointer self) info))

(defmethod INFO-2 ((self TYPED-CONSTRAINT) info)
  (TYPED-CONSTRAINT/GET-INFO-2 (ff-pointer self) info))

(defmethod INTERNAL-SET-APPLIED-IMPULSE ((self TYPED-CONSTRAINT) (appliedImpulse number))
  (TYPED-CONSTRAINT/INTERNAL-SET-APPLIED-IMPULSE (ff-pointer self) appliedImpulse))

(defmethod INTERNAL-GET-APPLIED-IMPULSE ((self TYPED-CONSTRAINT))
  (TYPED-CONSTRAINT/INTERNAL-GET-APPLIED-IMPULSE (ff-pointer self)))

(defmethod BREAKING-IMPULSE-THRESHOLD ((self TYPED-CONSTRAINT))
  (TYPED-CONSTRAINT/GET-BREAKING-IMPULSE-THRESHOLD (ff-pointer self)))

(defmethod (SETF BREAKING-IMPULSE-THRESHOLD) ((self TYPED-CONSTRAINT) (threshold number))
  (TYPED-CONSTRAINT/SET-BREAKING-IMPULSE-THRESHOLD (ff-pointer self) threshold))

(defmethod ENABLEDP ((self TYPED-CONSTRAINT))
  (TYPED-CONSTRAINT/IS-ENABLED (ff-pointer self)))

(defmethod (SETF ENABLED) ((self TYPED-CONSTRAINT) (enabled t))
  (TYPED-CONSTRAINT/SET-ENABLED (ff-pointer self) enabled))

(defmethod SOLVE-CONSTRAINT-OBSOLETE ((self TYPED-CONSTRAINT) arg1 arg2 (arg3 number))
  (TYPED-CONSTRAINT/SOLVE-CONSTRAINT-OBSOLETE (ff-pointer self) arg1 arg2 arg3))

(defmethod RIGID-BODY-A ((self TYPED-CONSTRAINT))
  (TYPED-CONSTRAINT/GET-RIGID-BODY-A (ff-pointer self)))

(defmethod RIGID-BODY-B ((self TYPED-CONSTRAINT))
  (TYPED-CONSTRAINT/GET-RIGID-BODY-B (ff-pointer self)))

(defmethod RIGID-BODY-A ((self TYPED-CONSTRAINT))
  (TYPED-CONSTRAINT/GET-RIGID-BODY-A (ff-pointer self)))

(defmethod RIGID-BODY-B ((self TYPED-CONSTRAINT))
  (TYPED-CONSTRAINT/GET-RIGID-BODY-B (ff-pointer self)))

(defmethod USER-CONSTRAINT-TYPE ((self TYPED-CONSTRAINT))
  (TYPED-CONSTRAINT/GET-USER-CONSTRAINT-TYPE (ff-pointer self)))

(defmethod (SETF USER-CONSTRAINT-TYPE) ((self TYPED-CONSTRAINT) (userConstraintType integer))
  (TYPED-CONSTRAINT/SET-USER-CONSTRAINT-TYPE (ff-pointer self) userConstraintType))

(defmethod (SETF USER-CONSTRAINT-ID) ((self TYPED-CONSTRAINT) (uid integer))
  (TYPED-CONSTRAINT/SET-USER-CONSTRAINT-ID (ff-pointer self) uid))

(defmethod USER-CONSTRAINT-ID ((self TYPED-CONSTRAINT))
  (TYPED-CONSTRAINT/GET-USER-CONSTRAINT-ID (ff-pointer self)))

(defmethod (SETF USER-CONSTRAINT-PTR) ((self TYPED-CONSTRAINT) ptr)
  (TYPED-CONSTRAINT/SET-USER-CONSTRAINT-PTR (ff-pointer self) ptr))

(defmethod USER-CONSTRAINT-PTR ((self TYPED-CONSTRAINT))
  (TYPED-CONSTRAINT/GET-USER-CONSTRAINT-PTR (ff-pointer self)))

(defmethod (SETF JOINT-FEEDBACK) ((self TYPED-CONSTRAINT) jointFeedback)
  (TYPED-CONSTRAINT/SET-JOINT-FEEDBACK (ff-pointer self) jointFeedback))

(defmethod JOINT-FEEDBACK ((self TYPED-CONSTRAINT))
  (TYPED-CONSTRAINT/GET-JOINT-FEEDBACK (ff-pointer self)))

(defmethod JOINT-FEEDBACK ((self TYPED-CONSTRAINT))
  (TYPED-CONSTRAINT/GET-JOINT-FEEDBACK (ff-pointer self)))

(defmethod UID ((self TYPED-CONSTRAINT))
  (TYPED-CONSTRAINT/GET-UID (ff-pointer self)))

(defmethod NEEDS-FEEDBACK ((self TYPED-CONSTRAINT))
  (TYPED-CONSTRAINT/NEEDS-FEEDBACK (ff-pointer self)))

(defmethod ENABLE-FEEDBACK ((self TYPED-CONSTRAINT) (needsFeedback t))
  (TYPED-CONSTRAINT/ENABLE-FEEDBACK (ff-pointer self) needsFeedback))

(defmethod APPLIED-IMPULSE ((self TYPED-CONSTRAINT))
  (TYPED-CONSTRAINT/GET-APPLIED-IMPULSE (ff-pointer self)))

(defmethod CONSTRAINT-TYPE ((self TYPED-CONSTRAINT))
  (TYPED-CONSTRAINT/GET-CONSTRAINT-TYPE (ff-pointer self)))

(defmethod (SETF DBG-DRAW-SIZE) ((self TYPED-CONSTRAINT) (dbgDrawSize number))
  (TYPED-CONSTRAINT/SET-DBG-DRAW-SIZE (ff-pointer self) dbgDrawSize))

(defmethod DBG-DRAW-SIZE ((self TYPED-CONSTRAINT))
  (TYPED-CONSTRAINT/GET-DBG-DRAW-SIZE (ff-pointer self)))

(defmethod CALCULATE-SERIALIZE-BUFFER-SIZE ((self TYPED-CONSTRAINT))
  (TYPED-CONSTRAINT/CALCULATE-SERIALIZE-BUFFER-SIZE (ff-pointer self)))

(defmethod SERIALIZE ((self TYPED-CONSTRAINT) dataBuffer (serializer SERIALIZER))
  (TYPED-CONSTRAINT/SERIALIZE (ff-pointer self) dataBuffer serializer))



(defmethod initialize-instance :after ((obj ANGULAR-LIMIT) &key)
  (setf (slot-value obj 'ff-pointer) (MAKE-ANGULAR-LIMIT)))

(defmethod BULLET/SET ((self ANGULAR-LIMIT) (low number) (high number) (_softness number) (_biasFactor number) (_relaxationFactor number))
  (ANGULAR-LIMIT/SET (ff-pointer self) low high _softness _biasFactor _relaxationFactor))

(defmethod BULLET/SET ((self ANGULAR-LIMIT) (low number) (high number) (_softness number) (_biasFactor number))
  (ANGULAR-LIMIT/SET (ff-pointer self) low high _softness _biasFactor))

(defmethod BULLET/SET ((self ANGULAR-LIMIT) (low number) (high number) (_softness number))
  (ANGULAR-LIMIT/SET (ff-pointer self) low high _softness))

(defmethod BULLET/SET ((self ANGULAR-LIMIT) (low number) (high number))
  (ANGULAR-LIMIT/SET (ff-pointer self) low high))

(defmethod TEST ((self ANGULAR-LIMIT) (angle number))
  (ANGULAR-LIMIT/TEST (ff-pointer self) angle))

(defmethod SOFTNESS ((self ANGULAR-LIMIT))
  (ANGULAR-LIMIT/GET-SOFTNESS (ff-pointer self)))

(defmethod BIAS-FACTOR ((self ANGULAR-LIMIT))
  (ANGULAR-LIMIT/GET-BIAS-FACTOR (ff-pointer self)))

(defmethod RELAXATION-FACTOR ((self ANGULAR-LIMIT))
  (ANGULAR-LIMIT/GET-RELAXATION-FACTOR (ff-pointer self)))

(defmethod CORRECTION ((self ANGULAR-LIMIT))
  (ANGULAR-LIMIT/GET-CORRECTION (ff-pointer self)))

(defmethod SIGN ((self ANGULAR-LIMIT))
  (ANGULAR-LIMIT/GET-SIGN (ff-pointer self)))

(defmethod HALF-RANGE ((self ANGULAR-LIMIT))
  (ANGULAR-LIMIT/GET-HALF-RANGE (ff-pointer self)))

(defmethod LIMITP ((self ANGULAR-LIMIT))
  (ANGULAR-LIMIT/IS-LIMIT (ff-pointer self)))

(defmethod FIT ((self ANGULAR-LIMIT) angle)
  (ANGULAR-LIMIT/FIT (ff-pointer self) angle))

(defmethod BULLET/ERROR ((self ANGULAR-LIMIT))
  (ANGULAR-LIMIT/GET-ERROR (ff-pointer self)))

(defmethod LOW ((self ANGULAR-LIMIT))
  (ANGULAR-LIMIT/GET-LOW (ff-pointer self)))

(defmethod HIGH ((self ANGULAR-LIMIT))
  (ANGULAR-LIMIT/GET-HIGH (ff-pointer self)))



(defmethod NEW ((self POINT-2-POINT-CONSTRAINT) sizeInBytes)
  (POINT-2-POINT-CONSTRAINT/MAKE-CPLUS-PLUS-INSTANCE (ff-pointer self) sizeInBytes))

(defmethod BULLET/DELETE ((self POINT-2-POINT-CONSTRAINT) ptr)
  (POINT-2-POINT-CONSTRAINT/DELETE-CPLUS-PLUS-INSTANCE (ff-pointer self) ptr))

(defmethod NEW ((self POINT-2-POINT-CONSTRAINT) arg1 ptr)
  (POINT-2-POINT-CONSTRAINT/MAKE-CPLUS-PLUS-INSTANCE (ff-pointer self) arg1 ptr))

(defmethod BULLET/DELETE ((self POINT-2-POINT-CONSTRAINT) arg1 arg2)
  (POINT-2-POINT-CONSTRAINT/DELETE-CPLUS-PLUS-INSTANCE (ff-pointer self) arg1 arg2))

(shadow "new[]")
(defmethod NEW[] ((self POINT-2-POINT-CONSTRAINT) sizeInBytes)
  (POINT-2-POINT-CONSTRAINT/MAKE-CPLUS-ARRAY (ff-pointer self) sizeInBytes))

(shadow "delete[]")
(defmethod DELETE[] ((self POINT-2-POINT-CONSTRAINT) ptr)
  (POINT-2-POINT-CONSTRAINT/DELETE-CPLUS-ARRAY (ff-pointer self) ptr))

(shadow "new[]")
(defmethod NEW[] ((self POINT-2-POINT-CONSTRAINT) arg1 ptr)
  (POINT-2-POINT-CONSTRAINT/MAKE-CPLUS-ARRAY (ff-pointer self) arg1 ptr))

(shadow "delete[]")
(defmethod DELETE[] ((self POINT-2-POINT-CONSTRAINT) arg1 arg2)
  (POINT-2-POINT-CONSTRAINT/DELETE-CPLUS-ARRAY (ff-pointer self) arg1 arg2))

(defmethod (setf USE-SOLVE-CONSTRAINT-OBSOLETE) (arg0 (obj POINT-2-POINT-CONSTRAINT))
  (POINT-2-POINT-CONSTRAINT/M/USE-SOLVE-CONSTRAINT-OBSOLETE/SET (ff-pointer obj) arg0))

(defmethod USE-SOLVE-CONSTRAINT-OBSOLETE ((obj POINT-2-POINT-CONSTRAINT))
  (POINT-2-POINT-CONSTRAINT/M/USE-SOLVE-CONSTRAINT-OBSOLETE/GET (ff-pointer obj)))

(defmethod (setf SETTING) (arg0 (obj POINT-2-POINT-CONSTRAINT))
  (POINT-2-POINT-CONSTRAINT/M/SETTING/SET (ff-pointer obj) arg0))

(defmethod SETTING ((obj POINT-2-POINT-CONSTRAINT))
  (POINT-2-POINT-CONSTRAINT/M/SETTING/GET (ff-pointer obj)))

(defmethod initialize-instance :after ((obj POINT-2-POINT-CONSTRAINT) &key (rbA RIGID-BODY) (rbB RIGID-BODY) (pivotInA VECTOR-3) (pivotInB VECTOR-3))
  (setf (slot-value obj 'ff-pointer) (MAKE-POINT-2-POINT-CONSTRAINT rbA rbB pivotInA pivotInB)))

(defmethod initialize-instance :after ((obj POINT-2-POINT-CONSTRAINT) &key (rbA RIGID-BODY) (pivotInA VECTOR-3))
  (setf (slot-value obj 'ff-pointer) (MAKE-POINT-2-POINT-CONSTRAINT rbA pivotInA)))

(defmethod BUILD-JACOBIAN ((self POINT-2-POINT-CONSTRAINT))
  (POINT-2-POINT-CONSTRAINT/BUILD-JACOBIAN (ff-pointer self)))

(defmethod INFO-1 ((self POINT-2-POINT-CONSTRAINT) info)
  (POINT-2-POINT-CONSTRAINT/GET-INFO-1 (ff-pointer self) info))

(defmethod INFO-1-NON-VIRTUAL ((self POINT-2-POINT-CONSTRAINT) info)
  (POINT-2-POINT-CONSTRAINT/GET-INFO-1-NON-VIRTUAL (ff-pointer self) info))

(defmethod INFO-2 ((self POINT-2-POINT-CONSTRAINT) info)
  (POINT-2-POINT-CONSTRAINT/GET-INFO-2 (ff-pointer self) info))

(defmethod INFO-2-NON-VIRTUAL ((self POINT-2-POINT-CONSTRAINT) info (body0_trans TRANSFORM) (body1_trans TRANSFORM))
  (POINT-2-POINT-CONSTRAINT/GET-INFO-2-NON-VIRTUAL (ff-pointer self) info body0_trans body1_trans))

(defmethod UPDATE-RHS ((self POINT-2-POINT-CONSTRAINT) (timeStep number))
  (POINT-2-POINT-CONSTRAINT/UPDATE-RHS (ff-pointer self) timeStep))

(defmethod (SETF PIVOT-A) ((self POINT-2-POINT-CONSTRAINT) (pivotA VECTOR-3))
  (POINT-2-POINT-CONSTRAINT/SET-PIVOT-A (ff-pointer self) pivotA))

(defmethod (SETF PIVOT-B) ((self POINT-2-POINT-CONSTRAINT) (pivotB VECTOR-3))
  (POINT-2-POINT-CONSTRAINT/SET-PIVOT-B (ff-pointer self) pivotB))

(defmethod PIVOT-IN-A ((self POINT-2-POINT-CONSTRAINT))
  (POINT-2-POINT-CONSTRAINT/GET-PIVOT-IN-A (ff-pointer self)))

(defmethod PIVOT-IN-B ((self POINT-2-POINT-CONSTRAINT))
  (POINT-2-POINT-CONSTRAINT/GET-PIVOT-IN-B (ff-pointer self)))

(defmethod CALCULATE-SERIALIZE-BUFFER-SIZE ((self POINT-2-POINT-CONSTRAINT))
  (POINT-2-POINT-CONSTRAINT/CALCULATE-SERIALIZE-BUFFER-SIZE (ff-pointer self)))

(defmethod SERIALIZE ((self POINT-2-POINT-CONSTRAINT) dataBuffer (serializer SERIALIZER))
  (POINT-2-POINT-CONSTRAINT/SERIALIZE (ff-pointer self) dataBuffer serializer))



(defmethod NEW ((self HINGE-CONSTRAINT) sizeInBytes)
  (HINGE-CONSTRAINT/MAKE-CPLUS-PLUS-INSTANCE (ff-pointer self) sizeInBytes))

(defmethod BULLET/DELETE ((self HINGE-CONSTRAINT) ptr)
  (HINGE-CONSTRAINT/DELETE-CPLUS-PLUS-INSTANCE (ff-pointer self) ptr))

(defmethod NEW ((self HINGE-CONSTRAINT) arg1 ptr)
  (HINGE-CONSTRAINT/MAKE-CPLUS-PLUS-INSTANCE (ff-pointer self) arg1 ptr))

(defmethod BULLET/DELETE ((self HINGE-CONSTRAINT) arg1 arg2)
  (HINGE-CONSTRAINT/DELETE-CPLUS-PLUS-INSTANCE (ff-pointer self) arg1 arg2))

(shadow "new[]")
(defmethod NEW[] ((self HINGE-CONSTRAINT) sizeInBytes)
  (HINGE-CONSTRAINT/MAKE-CPLUS-ARRAY (ff-pointer self) sizeInBytes))

(shadow "delete[]")
(defmethod DELETE[] ((self HINGE-CONSTRAINT) ptr)
  (HINGE-CONSTRAINT/DELETE-CPLUS-ARRAY (ff-pointer self) ptr))

(shadow "new[]")
(defmethod NEW[] ((self HINGE-CONSTRAINT) arg1 ptr)
  (HINGE-CONSTRAINT/MAKE-CPLUS-ARRAY (ff-pointer self) arg1 ptr))

(shadow "delete[]")
(defmethod DELETE[] ((self HINGE-CONSTRAINT) arg1 arg2)
  (HINGE-CONSTRAINT/DELETE-CPLUS-ARRAY (ff-pointer self) arg1 arg2))

(defmethod initialize-instance :after ((obj HINGE-CONSTRAINT) &key (rbA RIGID-BODY) (rbB RIGID-BODY) (pivotInA VECTOR-3) (pivotInB VECTOR-3) (axisInA VECTOR-3) (axisInB VECTOR-3) (useReferenceFrameA t))
  (setf (slot-value obj 'ff-pointer) (MAKE-HINGE-CONSTRAINT rbA rbB pivotInA pivotInB axisInA axisInB useReferenceFrameA)))

(defmethod initialize-instance :after ((obj HINGE-CONSTRAINT) &key (rbA RIGID-BODY) (rbB RIGID-BODY) (pivotInA VECTOR-3) (pivotInB VECTOR-3) (axisInA VECTOR-3) (axisInB VECTOR-3))
  (setf (slot-value obj 'ff-pointer) (MAKE-HINGE-CONSTRAINT rbA rbB pivotInA pivotInB axisInA axisInB)))

(defmethod initialize-instance :after ((obj HINGE-CONSTRAINT) &key (rbA RIGID-BODY) (pivotInA VECTOR-3) (axisInA VECTOR-3) (useReferenceFrameA t))
  (setf (slot-value obj 'ff-pointer) (MAKE-HINGE-CONSTRAINT rbA pivotInA axisInA useReferenceFrameA)))

(defmethod initialize-instance :after ((obj HINGE-CONSTRAINT) &key (rbA RIGID-BODY) (pivotInA VECTOR-3) (axisInA VECTOR-3))
  (setf (slot-value obj 'ff-pointer) (MAKE-HINGE-CONSTRAINT rbA pivotInA axisInA)))

(defmethod initialize-instance :after ((obj HINGE-CONSTRAINT) &key (rbA RIGID-BODY) (rbB RIGID-BODY) (rbAFrame TRANSFORM) (rbBFrame TRANSFORM) (useReferenceFrameA t))
  (setf (slot-value obj 'ff-pointer) (MAKE-HINGE-CONSTRAINT rbA rbB rbAFrame rbBFrame useReferenceFrameA)))

(defmethod initialize-instance :after ((obj HINGE-CONSTRAINT) &key (rbA RIGID-BODY) (rbB RIGID-BODY) (rbAFrame TRANSFORM) (rbBFrame TRANSFORM))
  (setf (slot-value obj 'ff-pointer) (MAKE-HINGE-CONSTRAINT rbA rbB rbAFrame rbBFrame)))

(defmethod initialize-instance :after ((obj HINGE-CONSTRAINT) &key (rbA RIGID-BODY) (rbAFrame TRANSFORM) (useReferenceFrameA t))
  (setf (slot-value obj 'ff-pointer) (MAKE-HINGE-CONSTRAINT rbA rbAFrame useReferenceFrameA)))

(defmethod initialize-instance :after ((obj HINGE-CONSTRAINT) &key (rbA RIGID-BODY) (rbAFrame TRANSFORM))
  (setf (slot-value obj 'ff-pointer) (MAKE-HINGE-CONSTRAINT rbA rbAFrame)))

(defmethod BUILD-JACOBIAN ((self HINGE-CONSTRAINT))
  (HINGE-CONSTRAINT/BUILD-JACOBIAN (ff-pointer self)))

(defmethod INFO-1 ((self HINGE-CONSTRAINT) info)
  (HINGE-CONSTRAINT/GET-INFO-1 (ff-pointer self) info))

(defmethod INFO-1-NON-VIRTUAL ((self HINGE-CONSTRAINT) info)
  (HINGE-CONSTRAINT/GET-INFO-1-NON-VIRTUAL (ff-pointer self) info))

(defmethod INFO-2 ((self HINGE-CONSTRAINT) info)
  (HINGE-CONSTRAINT/GET-INFO-2 (ff-pointer self) info))

(defmethod INFO-2-NON-VIRTUAL ((self HINGE-CONSTRAINT) info (transA TRANSFORM) (transB TRANSFORM) (angVelA VECTOR-3) (angVelB VECTOR-3))
  (HINGE-CONSTRAINT/GET-INFO-2-NON-VIRTUAL (ff-pointer self) info transA transB angVelA angVelB))

(defmethod INFO-2-INTERNAL ((self HINGE-CONSTRAINT) info (transA TRANSFORM) (transB TRANSFORM) (angVelA VECTOR-3) (angVelB VECTOR-3))
  (HINGE-CONSTRAINT/GET-INFO-2-INTERNAL (ff-pointer self) info transA transB angVelA angVelB))

(defmethod INFO-2-INTERNAL-USING-FRAME-OFFSET ((self HINGE-CONSTRAINT) info (transA TRANSFORM) (transB TRANSFORM) (angVelA VECTOR-3) (angVelB VECTOR-3))
  (HINGE-CONSTRAINT/GET-INFO-2-INTERNAL-USING-FRAME-OFFSET (ff-pointer self) info transA transB angVelA angVelB))

(defmethod UPDATE-RHS ((self HINGE-CONSTRAINT) (timeStep number))
  (HINGE-CONSTRAINT/UPDATE-RHS (ff-pointer self) timeStep))

(defmethod RIGID-BODY-A ((self HINGE-CONSTRAINT))
  (HINGE-CONSTRAINT/GET-RIGID-BODY-A (ff-pointer self)))

(defmethod RIGID-BODY-B ((self HINGE-CONSTRAINT))
  (HINGE-CONSTRAINT/GET-RIGID-BODY-B (ff-pointer self)))

(defmethod RIGID-BODY-A ((self HINGE-CONSTRAINT))
  (HINGE-CONSTRAINT/GET-RIGID-BODY-A (ff-pointer self)))

(defmethod RIGID-BODY-B ((self HINGE-CONSTRAINT))
  (HINGE-CONSTRAINT/GET-RIGID-BODY-B (ff-pointer self)))

(defmethod FRAME-OFFSET-A ((self HINGE-CONSTRAINT))
  (HINGE-CONSTRAINT/GET-FRAME-OFFSET-A (ff-pointer self)))

(defmethod FRAME-OFFSET-B ((self HINGE-CONSTRAINT))
  (HINGE-CONSTRAINT/GET-FRAME-OFFSET-B (ff-pointer self)))

(defmethod (SETF FRAMES) ((self HINGE-CONSTRAINT) (frameA TRANSFORM) (frameB TRANSFORM))
  (HINGE-CONSTRAINT/SET-FRAMES (ff-pointer self) frameA frameB))

(defmethod (SETF ANGULAR-ONLY) ((self HINGE-CONSTRAINT) (angularOnly t))
  (HINGE-CONSTRAINT/SET-ANGULAR-ONLY (ff-pointer self) angularOnly))

(defmethod ENABLE-ANGULAR-MOTOR ((self HINGE-CONSTRAINT) (enableMotor t) (targetVelocity number) (maxMotorImpulse number))
  (HINGE-CONSTRAINT/ENABLE-ANGULAR-MOTOR (ff-pointer self) enableMotor targetVelocity maxMotorImpulse))

(defmethod ENABLE-MOTOR ((self HINGE-CONSTRAINT) (enableMotor t))
  (HINGE-CONSTRAINT/ENABLE-MOTOR (ff-pointer self) enableMotor))

(defmethod (SETF MAX-MOTOR-IMPULSE) ((self HINGE-CONSTRAINT) (maxMotorImpulse number))
  (HINGE-CONSTRAINT/SET-MAX-MOTOR-IMPULSE (ff-pointer self) maxMotorImpulse))

(defmethod (SETF MOTOR-TARGET) ((self HINGE-CONSTRAINT) (qAinB QUATERNION) (dt number))
  (HINGE-CONSTRAINT/SET-MOTOR-TARGET (ff-pointer self) qAinB dt))

(defmethod (SETF MOTOR-TARGET) ((self HINGE-CONSTRAINT) (targetAngle number) (dt number))
  (HINGE-CONSTRAINT/SET-MOTOR-TARGET (ff-pointer self) targetAngle dt))

(defmethod (SETF LIMIT) ((self HINGE-CONSTRAINT) (low number) (high number) (_softness number) (_biasFactor number) (_relaxationFactor number))
  (HINGE-CONSTRAINT/SET-LIMIT (ff-pointer self) low high _softness _biasFactor _relaxationFactor))

(defmethod (SETF LIMIT) ((self HINGE-CONSTRAINT) (low number) (high number) (_softness number) (_biasFactor number))
  (HINGE-CONSTRAINT/SET-LIMIT (ff-pointer self) low high _softness _biasFactor))

(defmethod (SETF LIMIT) ((self HINGE-CONSTRAINT) (low number) (high number) (_softness number))
  (HINGE-CONSTRAINT/SET-LIMIT (ff-pointer self) low high _softness))

(defmethod (SETF LIMIT) ((self HINGE-CONSTRAINT) (low number) (high number))
           (HINGE-CONSTRAINT/SET-LIMIT (ff-pointer self) low high))

(defmethod (SETF AXIS) ((self HINGE-CONSTRAINT) (axisInA VECTOR-3))
  (HINGE-CONSTRAINT/SET-AXIS (ff-pointer self) axisInA))

(defmethod LOWER-LIMIT ((self HINGE-CONSTRAINT))
  (HINGE-CONSTRAINT/GET-LOWER-LIMIT (ff-pointer self)))

(defmethod UPPER-LIMIT ((self HINGE-CONSTRAINT))
  (HINGE-CONSTRAINT/GET-UPPER-LIMIT (ff-pointer self)))

(defmethod HINGE-ANGLE ((self HINGE-CONSTRAINT))
  (HINGE-CONSTRAINT/GET-HINGE-ANGLE (ff-pointer self)))

(defmethod HINGE-ANGLE ((self HINGE-CONSTRAINT) (transA TRANSFORM) (transB TRANSFORM))
  (HINGE-CONSTRAINT/GET-HINGE-ANGLE (ff-pointer self) transA transB))

(defmethod TEST-LIMIT ((self HINGE-CONSTRAINT) (transA TRANSFORM) (transB TRANSFORM))
  (HINGE-CONSTRAINT/TEST-LIMIT (ff-pointer self) transA transB))

(defmethod AFRAME ((self HINGE-CONSTRAINT))
  (HINGE-CONSTRAINT/GET-AFRAME (ff-pointer self)))

(defmethod BFRAME ((self HINGE-CONSTRAINT))
  (HINGE-CONSTRAINT/GET-BFRAME (ff-pointer self)))

(defmethod AFRAME ((self HINGE-CONSTRAINT))
  (HINGE-CONSTRAINT/GET-AFRAME (ff-pointer self)))

(defmethod BFRAME ((self HINGE-CONSTRAINT))
  (HINGE-CONSTRAINT/GET-BFRAME (ff-pointer self)))

(defmethod SOLVE-LIMIT ((self HINGE-CONSTRAINT))
  (HINGE-CONSTRAINT/GET-SOLVE-LIMIT (ff-pointer self)))

(defmethod LIMIT-SIGN ((self HINGE-CONSTRAINT))
  (HINGE-CONSTRAINT/GET-LIMIT-SIGN (ff-pointer self)))

(defmethod ANGULAR-ONLY ((self HINGE-CONSTRAINT))
  (HINGE-CONSTRAINT/GET-ANGULAR-ONLY (ff-pointer self)))

(defmethod ENABLE-ANGULAR-MOTOR ((self HINGE-CONSTRAINT))
  (HINGE-CONSTRAINT/GET-ENABLE-ANGULAR-MOTOR (ff-pointer self)))

(defmethod MOTOR-TARGET-VELOSITY ((self HINGE-CONSTRAINT))
  (HINGE-CONSTRAINT/GET-MOTOR-TARGET-VELOSITY (ff-pointer self)))

(defmethod MAX-MOTOR-IMPULSE ((self HINGE-CONSTRAINT))
  (HINGE-CONSTRAINT/GET-MAX-MOTOR-IMPULSE (ff-pointer self)))

(defmethod USE-FRAME-OFFSET ((self HINGE-CONSTRAINT))
  (HINGE-CONSTRAINT/GET-USE-FRAME-OFFSET (ff-pointer self)))

(defmethod (SETF USE-FRAME-OFFSET) ((self HINGE-CONSTRAINT) (frameOffsetOnOff t))
  (HINGE-CONSTRAINT/SET-USE-FRAME-OFFSET (ff-pointer self) frameOffsetOnOff))

(defmethod CALCULATE-SERIALIZE-BUFFER-SIZE ((self HINGE-CONSTRAINT))
  (HINGE-CONSTRAINT/CALCULATE-SERIALIZE-BUFFER-SIZE (ff-pointer self)))

(defmethod SERIALIZE ((self HINGE-CONSTRAINT) dataBuffer (serializer SERIALIZER))
  (HINGE-CONSTRAINT/SERIALIZE (ff-pointer self) dataBuffer serializer))



(defmethod NEW ((self CONE-TWIST-CONSTRAINT) sizeInBytes)
  (CONE-TWIST-CONSTRAINT/MAKE-CPLUS-PLUS-INSTANCE (ff-pointer self) sizeInBytes))

(defmethod BULLET/DELETE ((self CONE-TWIST-CONSTRAINT) ptr)
  (CONE-TWIST-CONSTRAINT/DELETE-CPLUS-PLUS-INSTANCE (ff-pointer self) ptr))

(defmethod NEW ((self CONE-TWIST-CONSTRAINT) arg1 ptr)
  (CONE-TWIST-CONSTRAINT/MAKE-CPLUS-PLUS-INSTANCE (ff-pointer self) arg1 ptr))

(defmethod BULLET/DELETE ((self CONE-TWIST-CONSTRAINT) arg1 arg2)
  (CONE-TWIST-CONSTRAINT/DELETE-CPLUS-PLUS-INSTANCE (ff-pointer self) arg1 arg2))

(shadow "new[]")
(defmethod NEW[] ((self CONE-TWIST-CONSTRAINT) sizeInBytes)
  (CONE-TWIST-CONSTRAINT/MAKE-CPLUS-ARRAY (ff-pointer self) sizeInBytes))

(shadow "delete[]")
(defmethod DELETE[] ((self CONE-TWIST-CONSTRAINT) ptr)
  (CONE-TWIST-CONSTRAINT/DELETE-CPLUS-ARRAY (ff-pointer self) ptr))

(shadow "new[]")
(defmethod NEW[] ((self CONE-TWIST-CONSTRAINT) arg1 ptr)
  (CONE-TWIST-CONSTRAINT/MAKE-CPLUS-ARRAY (ff-pointer self) arg1 ptr))

(shadow "delete[]")
(defmethod DELETE[] ((self CONE-TWIST-CONSTRAINT) arg1 arg2)
  (CONE-TWIST-CONSTRAINT/DELETE-CPLUS-ARRAY (ff-pointer self) arg1 arg2))

(defmethod initialize-instance :after ((obj CONE-TWIST-CONSTRAINT) &key (rbA RIGID-BODY) (rbB RIGID-BODY) (rbAFrame TRANSFORM) (rbBFrame TRANSFORM))
  (setf (slot-value obj 'ff-pointer) (MAKE-CONE-TWIST-CONSTRAINT rbA rbB rbAFrame rbBFrame)))

(defmethod initialize-instance :after ((obj CONE-TWIST-CONSTRAINT) &key (rbA RIGID-BODY) (rbAFrame TRANSFORM))
  (setf (slot-value obj 'ff-pointer) (MAKE-CONE-TWIST-CONSTRAINT rbA rbAFrame)))

(defmethod BUILD-JACOBIAN ((self CONE-TWIST-CONSTRAINT))
  (CONE-TWIST-CONSTRAINT/BUILD-JACOBIAN (ff-pointer self)))

(defmethod INFO-1 ((self CONE-TWIST-CONSTRAINT) info)
  (CONE-TWIST-CONSTRAINT/GET-INFO-1 (ff-pointer self) info))

(defmethod INFO-1-NON-VIRTUAL ((self CONE-TWIST-CONSTRAINT) info)
  (CONE-TWIST-CONSTRAINT/GET-INFO-1-NON-VIRTUAL (ff-pointer self) info))

(defmethod INFO-2 ((self CONE-TWIST-CONSTRAINT) info)
  (CONE-TWIST-CONSTRAINT/GET-INFO-2 (ff-pointer self) info))

(defmethod INFO-2-NON-VIRTUAL ((self CONE-TWIST-CONSTRAINT) info (transA TRANSFORM) (transB TRANSFORM) (invInertiaWorldA MATRIX-3X-3) (invInertiaWorldB MATRIX-3X-3))
  (CONE-TWIST-CONSTRAINT/GET-INFO-2-NON-VIRTUAL (ff-pointer self) info transA transB invInertiaWorldA invInertiaWorldB))

(defmethod SOLVE-CONSTRAINT-OBSOLETE ((self CONE-TWIST-CONSTRAINT) bodyA bodyB (timeStep number))
  (CONE-TWIST-CONSTRAINT/SOLVE-CONSTRAINT-OBSOLETE (ff-pointer self) bodyA bodyB timeStep))

(defmethod UPDATE-RHS ((self CONE-TWIST-CONSTRAINT) (timeStep number))
  (CONE-TWIST-CONSTRAINT/UPDATE-RHS (ff-pointer self) timeStep))

(defmethod RIGID-BODY-A ((self CONE-TWIST-CONSTRAINT))
  (CONE-TWIST-CONSTRAINT/GET-RIGID-BODY-A (ff-pointer self)))

(defmethod RIGID-BODY-B ((self CONE-TWIST-CONSTRAINT))
  (CONE-TWIST-CONSTRAINT/GET-RIGID-BODY-B (ff-pointer self)))

(defmethod (SETF ANGULAR-ONLY) ((self CONE-TWIST-CONSTRAINT) (angularOnly t))
  (CONE-TWIST-CONSTRAINT/SET-ANGULAR-ONLY (ff-pointer self) angularOnly))

(defmethod (SETF LIMIT) ((self CONE-TWIST-CONSTRAINT) (limitIndex integer) (limitValue number))
  (CONE-TWIST-CONSTRAINT/SET-LIMIT (ff-pointer self) limitIndex limitValue))

(defmethod (SETF LIMIT) ((self CONE-TWIST-CONSTRAINT) (_swingSpan1 number) (_swingSpan2 number) (_twistSpan number) (_softness number) (_biasFactor number) (_relaxationFactor number))
  (CONE-TWIST-CONSTRAINT/SET-LIMIT (ff-pointer self) _swingSpan1 _swingSpan2 _twistSpan _softness _biasFactor _relaxationFactor))

(defmethod (SETF LIMIT) ((self CONE-TWIST-CONSTRAINT) (_swingSpan1 number) (_swingSpan2 number) (_twistSpan number) (_softness number) (_biasFactor number))
  (CONE-TWIST-CONSTRAINT/SET-LIMIT (ff-pointer self) _swingSpan1 _swingSpan2 _twistSpan _softness _biasFactor))

(defmethod (SETF LIMIT) ((self CONE-TWIST-CONSTRAINT) (_swingSpan1 number) (_swingSpan2 number) (_twistSpan number) (_softness number))
  (CONE-TWIST-CONSTRAINT/SET-LIMIT (ff-pointer self) _swingSpan1 _swingSpan2 _twistSpan _softness))

(defmethod (SETF LIMIT) ((self CONE-TWIST-CONSTRAINT) (_swingSpan1 number) (_swingSpan2 number) (_twistSpan number))
  (CONE-TWIST-CONSTRAINT/SET-LIMIT (ff-pointer self) _swingSpan1 _swingSpan2 _twistSpan))

(defmethod AFRAME ((self CONE-TWIST-CONSTRAINT))
  (CONE-TWIST-CONSTRAINT/GET-AFRAME (ff-pointer self)))

(defmethod BFRAME ((self CONE-TWIST-CONSTRAINT))
  (CONE-TWIST-CONSTRAINT/GET-BFRAME (ff-pointer self)))

(defmethod SOLVE-TWIST-LIMIT ((self CONE-TWIST-CONSTRAINT))
  (CONE-TWIST-CONSTRAINT/GET-SOLVE-TWIST-LIMIT (ff-pointer self)))

(defmethod SOLVE-SWING-LIMIT ((self CONE-TWIST-CONSTRAINT))
  (CONE-TWIST-CONSTRAINT/GET-SOLVE-SWING-LIMIT (ff-pointer self)))

(defmethod TWIST-LIMIT-SIGN ((self CONE-TWIST-CONSTRAINT))
  (CONE-TWIST-CONSTRAINT/GET-TWIST-LIMIT-SIGN (ff-pointer self)))

(defmethod CALC-ANGLE-INFO ((self CONE-TWIST-CONSTRAINT))
  (CONE-TWIST-CONSTRAINT/CALC-ANGLE-INFO (ff-pointer self)))

(defmethod CALC-ANGLE-INFO-2 ((self CONE-TWIST-CONSTRAINT) (transA TRANSFORM) (transB TRANSFORM) (invInertiaWorldA MATRIX-3X-3) (invInertiaWorldB MATRIX-3X-3))
  (CONE-TWIST-CONSTRAINT/CALC-ANGLE-INFO-2 (ff-pointer self) transA transB invInertiaWorldA invInertiaWorldB))

(defmethod SWING-SPAN-1 ((self CONE-TWIST-CONSTRAINT))
  (CONE-TWIST-CONSTRAINT/GET-SWING-SPAN-1 (ff-pointer self)))

(defmethod SWING-SPAN-2 ((self CONE-TWIST-CONSTRAINT))
  (CONE-TWIST-CONSTRAINT/GET-SWING-SPAN-2 (ff-pointer self)))

(defmethod TWIST-SPAN ((self CONE-TWIST-CONSTRAINT))
  (CONE-TWIST-CONSTRAINT/GET-TWIST-SPAN (ff-pointer self)))

(defmethod TWIST-ANGLE ((self CONE-TWIST-CONSTRAINT))
  (CONE-TWIST-CONSTRAINT/GET-TWIST-ANGLE (ff-pointer self)))

(defmethod PAST-SWING-LIMIT-P ((self CONE-TWIST-CONSTRAINT))
  (CONE-TWIST-CONSTRAINT/IS-PAST-SWING-LIMIT (ff-pointer self)))

(defmethod (SETF DAMPING) ((self CONE-TWIST-CONSTRAINT) (damping number))
  (CONE-TWIST-CONSTRAINT/SET-DAMPING (ff-pointer self) damping))

(defmethod ENABLE-MOTOR ((self CONE-TWIST-CONSTRAINT) (b t))
  (CONE-TWIST-CONSTRAINT/ENABLE-MOTOR (ff-pointer self) b))

(defmethod (SETF MAX-MOTOR-IMPULSE) ((self CONE-TWIST-CONSTRAINT) (maxMotorImpulse number))
  (CONE-TWIST-CONSTRAINT/SET-MAX-MOTOR-IMPULSE (ff-pointer self) maxMotorImpulse))

(defmethod (SETF MAX-MOTOR-IMPULSE-NORMALIZED) ((self CONE-TWIST-CONSTRAINT) (maxMotorImpulse number))
  (CONE-TWIST-CONSTRAINT/SET-MAX-MOTOR-IMPULSE-NORMALIZED (ff-pointer self) maxMotorImpulse))

(defmethod FIX-THRESH ((self CONE-TWIST-CONSTRAINT))
  (CONE-TWIST-CONSTRAINT/GET-FIX-THRESH (ff-pointer self)))

(defmethod (SETF FIX-THRESH) ((self CONE-TWIST-CONSTRAINT) (fixThresh number))
  (CONE-TWIST-CONSTRAINT/SET-FIX-THRESH (ff-pointer self) fixThresh))

(defmethod (SETF MOTOR-TARGET) ((self CONE-TWIST-CONSTRAINT) (q QUATERNION))
  (CONE-TWIST-CONSTRAINT/SET-MOTOR-TARGET (ff-pointer self) q))

(defmethod (SETF MOTOR-TARGET-IN-CONSTRAINT-SPACE) ((self CONE-TWIST-CONSTRAINT) (q QUATERNION))
  (CONE-TWIST-CONSTRAINT/SET-MOTOR-TARGET-IN-CONSTRAINT-SPACE (ff-pointer self) q))

(defmethod POINT-FOR-ANGLE ((self CONE-TWIST-CONSTRAINT) (fAngleInRadians number) (fLength number))
  (CONE-TWIST-CONSTRAINT/GET-POINT-FOR-ANGLE (ff-pointer self) fAngleInRadians fLength))

(defmethod FRAME-OFFSET-A ((self CONE-TWIST-CONSTRAINT))
  (CONE-TWIST-CONSTRAINT/GET-FRAME-OFFSET-A (ff-pointer self)))

(defmethod FRAME-OFFSET-B ((self CONE-TWIST-CONSTRAINT))
  (CONE-TWIST-CONSTRAINT/GET-FRAME-OFFSET-B (ff-pointer self)))

(defmethod CALCULATE-SERIALIZE-BUFFER-SIZE ((self CONE-TWIST-CONSTRAINT))
  (CONE-TWIST-CONSTRAINT/CALCULATE-SERIALIZE-BUFFER-SIZE (ff-pointer self)))

(defmethod SERIALIZE ((self CONE-TWIST-CONSTRAINT) dataBuffer (serializer SERIALIZER))
  (CONE-TWIST-CONSTRAINT/SERIALIZE (ff-pointer self) dataBuffer serializer))



(defmethod (setf LO-LIMIT) (arg0 (obj ROTATIONAL-LIMIT-MOTOR))
  (ROTATIONAL-LIMIT-MOTOR/M/LO-LIMIT/SET (ff-pointer obj) arg0))

(defmethod LO-LIMIT ((obj ROTATIONAL-LIMIT-MOTOR))
  (ROTATIONAL-LIMIT-MOTOR/M/LO-LIMIT/GET (ff-pointer obj)))

(defmethod (setf HI-LIMIT) (arg0 (obj ROTATIONAL-LIMIT-MOTOR))
  (ROTATIONAL-LIMIT-MOTOR/M/HI-LIMIT/SET (ff-pointer obj) arg0))

(defmethod HI-LIMIT ((obj ROTATIONAL-LIMIT-MOTOR))
  (ROTATIONAL-LIMIT-MOTOR/M/HI-LIMIT/GET (ff-pointer obj)))

(defmethod (setf TARGET-VELOCITY) (arg0 (obj ROTATIONAL-LIMIT-MOTOR))
  (ROTATIONAL-LIMIT-MOTOR/M/TARGET-VELOCITY/SET (ff-pointer obj) arg0))

(defmethod TARGET-VELOCITY ((obj ROTATIONAL-LIMIT-MOTOR))
  (ROTATIONAL-LIMIT-MOTOR/M/TARGET-VELOCITY/GET (ff-pointer obj)))

(defmethod (setf MAX-MOTOR-FORCE) (arg0 (obj ROTATIONAL-LIMIT-MOTOR))
  (ROTATIONAL-LIMIT-MOTOR/M/MAX-MOTOR-FORCE/SET (ff-pointer obj) arg0))

(defmethod MAX-MOTOR-FORCE ((obj ROTATIONAL-LIMIT-MOTOR))
  (ROTATIONAL-LIMIT-MOTOR/M/MAX-MOTOR-FORCE/GET (ff-pointer obj)))

(defmethod (setf MAX-LIMIT-FORCE) (arg0 (obj ROTATIONAL-LIMIT-MOTOR))
  (ROTATIONAL-LIMIT-MOTOR/M/MAX-LIMIT-FORCE/SET (ff-pointer obj) arg0))

(defmethod MAX-LIMIT-FORCE ((obj ROTATIONAL-LIMIT-MOTOR))
  (ROTATIONAL-LIMIT-MOTOR/M/MAX-LIMIT-FORCE/GET (ff-pointer obj)))

(defmethod (setf DAMPING) (arg0 (obj ROTATIONAL-LIMIT-MOTOR))
  (ROTATIONAL-LIMIT-MOTOR/M/DAMPING/SET (ff-pointer obj) arg0))

(defmethod DAMPING ((obj ROTATIONAL-LIMIT-MOTOR))
  (ROTATIONAL-LIMIT-MOTOR/M/DAMPING/GET (ff-pointer obj)))

(defmethod (setf LIMIT-SOFTNESS) (arg0 (obj ROTATIONAL-LIMIT-MOTOR))
  (ROTATIONAL-LIMIT-MOTOR/M/LIMIT-SOFTNESS/SET (ff-pointer obj) arg0))

(defmethod LIMIT-SOFTNESS ((obj ROTATIONAL-LIMIT-MOTOR))
  (ROTATIONAL-LIMIT-MOTOR/M/LIMIT-SOFTNESS/GET (ff-pointer obj)))

(defmethod (setf NORMAL-CFM) (arg0 (obj ROTATIONAL-LIMIT-MOTOR))
  (ROTATIONAL-LIMIT-MOTOR/M/NORMAL-CFM/SET (ff-pointer obj) arg0))

(defmethod NORMAL-CFM ((obj ROTATIONAL-LIMIT-MOTOR))
  (ROTATIONAL-LIMIT-MOTOR/M/NORMAL-CFM/GET (ff-pointer obj)))

(defmethod (setf STOP-ERP) (arg0 (obj ROTATIONAL-LIMIT-MOTOR))
  (ROTATIONAL-LIMIT-MOTOR/M/STOP-ERP/SET (ff-pointer obj) arg0))

(defmethod STOP-ERP ((obj ROTATIONAL-LIMIT-MOTOR))
  (ROTATIONAL-LIMIT-MOTOR/M/STOP-ERP/GET (ff-pointer obj)))

(defmethod (setf STOP-CFM) (arg0 (obj ROTATIONAL-LIMIT-MOTOR))
  (ROTATIONAL-LIMIT-MOTOR/M/STOP-CFM/SET (ff-pointer obj) arg0))

(defmethod STOP-CFM ((obj ROTATIONAL-LIMIT-MOTOR))
  (ROTATIONAL-LIMIT-MOTOR/M/STOP-CFM/GET (ff-pointer obj)))

(defmethod (setf BOUNCE) (arg0 (obj ROTATIONAL-LIMIT-MOTOR))
  (ROTATIONAL-LIMIT-MOTOR/M/BOUNCE/SET (ff-pointer obj) arg0))

(defmethod BOUNCE ((obj ROTATIONAL-LIMIT-MOTOR))
  (ROTATIONAL-LIMIT-MOTOR/M/BOUNCE/GET (ff-pointer obj)))

(defmethod (setf ENABLE-MOTOR) (arg0 (obj ROTATIONAL-LIMIT-MOTOR))
  (ROTATIONAL-LIMIT-MOTOR/M/ENABLE-MOTOR/SET (ff-pointer obj) arg0))

(defmethod ENABLE-MOTOR ((obj ROTATIONAL-LIMIT-MOTOR))
  (ROTATIONAL-LIMIT-MOTOR/M/ENABLE-MOTOR/GET (ff-pointer obj)))

(defmethod (setf CURRENT-LIMIT-ERROR) (arg0 (obj ROTATIONAL-LIMIT-MOTOR))
  (ROTATIONAL-LIMIT-MOTOR/M/CURRENT-LIMIT-ERROR/SET (ff-pointer obj) arg0))

(defmethod CURRENT-LIMIT-ERROR ((obj ROTATIONAL-LIMIT-MOTOR))
  (ROTATIONAL-LIMIT-MOTOR/M/CURRENT-LIMIT-ERROR/GET (ff-pointer obj)))

(defmethod (setf CURRENT-POSITION) (arg0 (obj ROTATIONAL-LIMIT-MOTOR))
  (ROTATIONAL-LIMIT-MOTOR/M/CURRENT-POSITION/SET (ff-pointer obj) arg0))

(defmethod CURRENT-POSITION ((obj ROTATIONAL-LIMIT-MOTOR))
  (ROTATIONAL-LIMIT-MOTOR/M/CURRENT-POSITION/GET (ff-pointer obj)))

(defmethod (setf CURRENT-LIMIT) (arg0 (obj ROTATIONAL-LIMIT-MOTOR))
  (ROTATIONAL-LIMIT-MOTOR/M/CURRENT-LIMIT/SET (ff-pointer obj) arg0))

(defmethod CURRENT-LIMIT ((obj ROTATIONAL-LIMIT-MOTOR))
  (ROTATIONAL-LIMIT-MOTOR/M/CURRENT-LIMIT/GET (ff-pointer obj)))

(defmethod (setf ACCUMULATED-IMPULSE) (arg0 (obj ROTATIONAL-LIMIT-MOTOR))
  (ROTATIONAL-LIMIT-MOTOR/M/ACCUMULATED-IMPULSE/SET (ff-pointer obj) arg0))

(defmethod ACCUMULATED-IMPULSE ((obj ROTATIONAL-LIMIT-MOTOR))
  (ROTATIONAL-LIMIT-MOTOR/M/ACCUMULATED-IMPULSE/GET (ff-pointer obj)))

(defmethod initialize-instance :after ((obj ROTATIONAL-LIMIT-MOTOR) &key)
  (setf (slot-value obj 'ff-pointer) (MAKE-ROTATIONAL-LIMIT-MOTOR)))

(defmethod initialize-instance :after ((obj ROTATIONAL-LIMIT-MOTOR) &key (limot ROTATIONAL-LIMIT-MOTOR))
  (setf (slot-value obj 'ff-pointer) (MAKE-ROTATIONAL-LIMIT-MOTOR (ff-pointer limot))))

(defmethod LIMITEDP ((self ROTATIONAL-LIMIT-MOTOR))
  (ROTATIONAL-LIMIT-MOTOR/IS-LIMITED (ff-pointer self)))

(defmethod NEED-APPLY-TORQUES ((self ROTATIONAL-LIMIT-MOTOR))
  (ROTATIONAL-LIMIT-MOTOR/NEED-APPLY-TORQUES (ff-pointer self)))

(defmethod TEST-LIMIT-VALUE ((self ROTATIONAL-LIMIT-MOTOR) (test_value number))
  (ROTATIONAL-LIMIT-MOTOR/TEST-LIMIT-VALUE (ff-pointer self) test_value))

(defmethod SOLVE-ANGULAR-LIMITS ((self ROTATIONAL-LIMIT-MOTOR) (timeStep number) (axis VECTOR-3) (jacDiagABInv number) (body0 RIGID-BODY) (body1 RIGID-BODY))
  (ROTATIONAL-LIMIT-MOTOR/SOLVE-ANGULAR-LIMITS (ff-pointer self) timeStep axis jacDiagABInv body0 body1))



(defmethod (setf LOWER-LIMIT) (arg0 (obj TRANSLATIONAL-LIMIT-MOTOR))
  (TRANSLATIONAL-LIMIT-MOTOR/M/LOWER-LIMIT/SET (ff-pointer obj) arg0))

(defmethod LOWER-LIMIT ((obj TRANSLATIONAL-LIMIT-MOTOR))
  (TRANSLATIONAL-LIMIT-MOTOR/M/LOWER-LIMIT/GET (ff-pointer obj)))

(defmethod (setf UPPER-LIMIT) (arg0 (obj TRANSLATIONAL-LIMIT-MOTOR))
  (TRANSLATIONAL-LIMIT-MOTOR/M/UPPER-LIMIT/SET (ff-pointer obj) arg0))

(defmethod UPPER-LIMIT ((obj TRANSLATIONAL-LIMIT-MOTOR))
  (TRANSLATIONAL-LIMIT-MOTOR/M/UPPER-LIMIT/GET (ff-pointer obj)))

(defmethod (setf ACCUMULATED-IMPULSE) (arg0 (obj TRANSLATIONAL-LIMIT-MOTOR))
  (TRANSLATIONAL-LIMIT-MOTOR/M/ACCUMULATED-IMPULSE/SET (ff-pointer obj) arg0))

(defmethod ACCUMULATED-IMPULSE ((obj TRANSLATIONAL-LIMIT-MOTOR))
  (TRANSLATIONAL-LIMIT-MOTOR/M/ACCUMULATED-IMPULSE/GET (ff-pointer obj)))

(defmethod (setf LIMIT-SOFTNESS) (arg0 (obj TRANSLATIONAL-LIMIT-MOTOR))
  (TRANSLATIONAL-LIMIT-MOTOR/M/LIMIT-SOFTNESS/SET (ff-pointer obj) arg0))

(defmethod LIMIT-SOFTNESS ((obj TRANSLATIONAL-LIMIT-MOTOR))
  (TRANSLATIONAL-LIMIT-MOTOR/M/LIMIT-SOFTNESS/GET (ff-pointer obj)))

(defmethod (setf DAMPING) (arg0 (obj TRANSLATIONAL-LIMIT-MOTOR))
  (TRANSLATIONAL-LIMIT-MOTOR/M/DAMPING/SET (ff-pointer obj) arg0))

(defmethod DAMPING ((obj TRANSLATIONAL-LIMIT-MOTOR))
  (TRANSLATIONAL-LIMIT-MOTOR/M/DAMPING/GET (ff-pointer obj)))

(defmethod (setf RESTITUTION) (arg0 (obj TRANSLATIONAL-LIMIT-MOTOR))
  (TRANSLATIONAL-LIMIT-MOTOR/M/RESTITUTION/SET (ff-pointer obj) arg0))

(defmethod RESTITUTION ((obj TRANSLATIONAL-LIMIT-MOTOR))
  (TRANSLATIONAL-LIMIT-MOTOR/M/RESTITUTION/GET (ff-pointer obj)))

(defmethod (setf NORMAL-CFM) (arg0 (obj TRANSLATIONAL-LIMIT-MOTOR))
  (TRANSLATIONAL-LIMIT-MOTOR/M/NORMAL-CFM/SET (ff-pointer obj) arg0))

(defmethod NORMAL-CFM ((obj TRANSLATIONAL-LIMIT-MOTOR))
  (TRANSLATIONAL-LIMIT-MOTOR/M/NORMAL-CFM/GET (ff-pointer obj)))

(defmethod (setf STOP-ERP) (arg0 (obj TRANSLATIONAL-LIMIT-MOTOR))
  (TRANSLATIONAL-LIMIT-MOTOR/M/STOP-ERP/SET (ff-pointer obj) arg0))

(defmethod STOP-ERP ((obj TRANSLATIONAL-LIMIT-MOTOR))
  (TRANSLATIONAL-LIMIT-MOTOR/M/STOP-ERP/GET (ff-pointer obj)))

(defmethod (setf STOP-CFM) (arg0 (obj TRANSLATIONAL-LIMIT-MOTOR))
  (TRANSLATIONAL-LIMIT-MOTOR/M/STOP-CFM/SET (ff-pointer obj) arg0))

(defmethod STOP-CFM ((obj TRANSLATIONAL-LIMIT-MOTOR))
  (TRANSLATIONAL-LIMIT-MOTOR/M/STOP-CFM/GET (ff-pointer obj)))

(defmethod (setf ENABLE-MOTOR) (arg0 (obj TRANSLATIONAL-LIMIT-MOTOR))
  (TRANSLATIONAL-LIMIT-MOTOR/M/ENABLE-MOTOR/SET (ff-pointer obj) arg0))

(defmethod ENABLE-MOTOR ((obj TRANSLATIONAL-LIMIT-MOTOR))
  (TRANSLATIONAL-LIMIT-MOTOR/M/ENABLE-MOTOR/GET (ff-pointer obj)))

(defmethod (setf TARGET-VELOCITY) (arg0 (obj TRANSLATIONAL-LIMIT-MOTOR))
  (TRANSLATIONAL-LIMIT-MOTOR/M/TARGET-VELOCITY/SET (ff-pointer obj) arg0))

(defmethod TARGET-VELOCITY ((obj TRANSLATIONAL-LIMIT-MOTOR))
  (TRANSLATIONAL-LIMIT-MOTOR/M/TARGET-VELOCITY/GET (ff-pointer obj)))

(defmethod (setf MAX-MOTOR-FORCE) (arg0 (obj TRANSLATIONAL-LIMIT-MOTOR))
  (TRANSLATIONAL-LIMIT-MOTOR/M/MAX-MOTOR-FORCE/SET (ff-pointer obj) arg0))

(defmethod MAX-MOTOR-FORCE ((obj TRANSLATIONAL-LIMIT-MOTOR))
  (TRANSLATIONAL-LIMIT-MOTOR/M/MAX-MOTOR-FORCE/GET (ff-pointer obj)))

(defmethod (setf CURRENT-LIMIT-ERROR) (arg0 (obj TRANSLATIONAL-LIMIT-MOTOR))
  (TRANSLATIONAL-LIMIT-MOTOR/M/CURRENT-LIMIT-ERROR/SET (ff-pointer obj) arg0))

(defmethod CURRENT-LIMIT-ERROR ((obj TRANSLATIONAL-LIMIT-MOTOR))
  (TRANSLATIONAL-LIMIT-MOTOR/M/CURRENT-LIMIT-ERROR/GET (ff-pointer obj)))

(defmethod (setf CURRENT-LINEAR-DIFF) (arg0 (obj TRANSLATIONAL-LIMIT-MOTOR))
  (TRANSLATIONAL-LIMIT-MOTOR/M/CURRENT-LINEAR-DIFF/SET (ff-pointer obj) arg0))

(defmethod CURRENT-LINEAR-DIFF ((obj TRANSLATIONAL-LIMIT-MOTOR))
  (TRANSLATIONAL-LIMIT-MOTOR/M/CURRENT-LINEAR-DIFF/GET (ff-pointer obj)))

(defmethod (setf CURRENT-LIMIT) (arg0 (obj TRANSLATIONAL-LIMIT-MOTOR))
  (TRANSLATIONAL-LIMIT-MOTOR/M/CURRENT-LIMIT/SET (ff-pointer obj) arg0))

(defmethod CURRENT-LIMIT ((obj TRANSLATIONAL-LIMIT-MOTOR))
  (TRANSLATIONAL-LIMIT-MOTOR/M/CURRENT-LIMIT/GET (ff-pointer obj)))

(defmethod initialize-instance :after ((obj TRANSLATIONAL-LIMIT-MOTOR) &key)
  (setf (slot-value obj 'ff-pointer) (MAKE-TRANSLATIONAL-LIMIT-MOTOR)))

(defmethod initialize-instance :after ((obj TRANSLATIONAL-LIMIT-MOTOR) &key (other TRANSLATIONAL-LIMIT-MOTOR))
  (setf (slot-value obj 'ff-pointer) (MAKE-TRANSLATIONAL-LIMIT-MOTOR (ff-pointer other))))

(defmethod LIMITEDP ((self TRANSLATIONAL-LIMIT-MOTOR) (limitIndex integer))
  (TRANSLATIONAL-LIMIT-MOTOR/IS-LIMITED (ff-pointer self) limitIndex))

(defmethod NEED-APPLY-FORCE ((self TRANSLATIONAL-LIMIT-MOTOR) (limitIndex integer))
  (TRANSLATIONAL-LIMIT-MOTOR/NEED-APPLY-FORCE (ff-pointer self) limitIndex))

(defmethod TEST-LIMIT-VALUE ((self TRANSLATIONAL-LIMIT-MOTOR) (limitIndex integer) (test_value number))
  (TRANSLATIONAL-LIMIT-MOTOR/TEST-LIMIT-VALUE (ff-pointer self) limitIndex test_value))

(defmethod SOLVE-LINEAR-AXIS ((self TRANSLATIONAL-LIMIT-MOTOR) (timeStep number) (jacDiagABInv number) (body1 RIGID-BODY) (pointInA VECTOR-3) (body2 RIGID-BODY) (pointInB VECTOR-3) (limit_index integer) (axis_normal_on_a VECTOR-3) (anchorPos VECTOR-3))
  (TRANSLATIONAL-LIMIT-MOTOR/SOLVE-LINEAR-AXIS (ff-pointer self) timeStep jacDiagABInv body1 pointInA body2 pointInB limit_index axis_normal_on_a anchorPos))



(defmethod NEW ((self GENERIC-6-DOF-CONSTRAINT) sizeInBytes)
  (GENERIC-6-DOF-CONSTRAINT/MAKE-CPLUS-PLUS-INSTANCE (ff-pointer self) sizeInBytes))

(defmethod BULLET/DELETE ((self GENERIC-6-DOF-CONSTRAINT) ptr)
  (GENERIC-6-DOF-CONSTRAINT/DELETE-CPLUS-PLUS-INSTANCE (ff-pointer self) ptr))

(defmethod NEW ((self GENERIC-6-DOF-CONSTRAINT) arg1 ptr)
  (GENERIC-6-DOF-CONSTRAINT/MAKE-CPLUS-PLUS-INSTANCE (ff-pointer self) arg1 ptr))

(defmethod BULLET/DELETE ((self GENERIC-6-DOF-CONSTRAINT) arg1 arg2)
  (GENERIC-6-DOF-CONSTRAINT/DELETE-CPLUS-PLUS-INSTANCE (ff-pointer self) arg1 arg2))

(shadow "new[]")
(defmethod NEW[] ((self GENERIC-6-DOF-CONSTRAINT) sizeInBytes)
  (GENERIC-6-DOF-CONSTRAINT/MAKE-CPLUS-ARRAY (ff-pointer self) sizeInBytes))

(shadow "delete[]")
(defmethod DELETE[] ((self GENERIC-6-DOF-CONSTRAINT) ptr)
  (GENERIC-6-DOF-CONSTRAINT/DELETE-CPLUS-ARRAY (ff-pointer self) ptr))

(shadow "new[]")
(defmethod NEW[] ((self GENERIC-6-DOF-CONSTRAINT) arg1 ptr)
  (GENERIC-6-DOF-CONSTRAINT/MAKE-CPLUS-ARRAY (ff-pointer self) arg1 ptr))

(shadow "delete[]")
(defmethod DELETE[] ((self GENERIC-6-DOF-CONSTRAINT) arg1 arg2)
  (GENERIC-6-DOF-CONSTRAINT/DELETE-CPLUS-ARRAY (ff-pointer self) arg1 arg2))

(defmethod (setf USE-SOLVE-CONSTRAINT-OBSOLETE) (arg0 (obj GENERIC-6-DOF-CONSTRAINT))
  (GENERIC-6-DOF-CONSTRAINT/M/USE-SOLVE-CONSTRAINT-OBSOLETE/SET (ff-pointer obj) arg0))

(defmethod USE-SOLVE-CONSTRAINT-OBSOLETE ((obj GENERIC-6-DOF-CONSTRAINT))
  (GENERIC-6-DOF-CONSTRAINT/M/USE-SOLVE-CONSTRAINT-OBSOLETE/GET (ff-pointer obj)))

(defmethod initialize-instance :after ((obj GENERIC-6-DOF-CONSTRAINT) &key (rbA RIGID-BODY) (rbB RIGID-BODY) (frameInA TRANSFORM) (frameInB TRANSFORM) (useLinearReferenceFrameA t))
  (setf (slot-value obj 'ff-pointer) (MAKE-GENERIC-6-DOF-CONSTRAINT rbA rbB frameInA frameInB useLinearReferenceFrameA)))

(defmethod initialize-instance :after ((obj GENERIC-6-DOF-CONSTRAINT) &key (rbB RIGID-BODY) (frameInB TRANSFORM) (useLinearReferenceFrameB t))
  (setf (slot-value obj 'ff-pointer) (MAKE-GENERIC-6-DOF-CONSTRAINT rbB frameInB useLinearReferenceFrameB)))

(defmethod CALCULATE-TRANSFORMS ((self GENERIC-6-DOF-CONSTRAINT) (transA TRANSFORM) (transB TRANSFORM))
  (GENERIC-6-DOF-CONSTRAINT/CALCULATE-TRANSFORMS (ff-pointer self) transA transB))

(defmethod CALCULATE-TRANSFORMS ((self GENERIC-6-DOF-CONSTRAINT))
  (GENERIC-6-DOF-CONSTRAINT/CALCULATE-TRANSFORMS (ff-pointer self)))

(defmethod CALCULATED-TRANSFORM-A ((self GENERIC-6-DOF-CONSTRAINT))
  (GENERIC-6-DOF-CONSTRAINT/GET-CALCULATED-TRANSFORM-A (ff-pointer self)))

(defmethod CALCULATED-TRANSFORM-B ((self GENERIC-6-DOF-CONSTRAINT))
  (GENERIC-6-DOF-CONSTRAINT/GET-CALCULATED-TRANSFORM-B (ff-pointer self)))

(defmethod FRAME-OFFSET-A ((self GENERIC-6-DOF-CONSTRAINT))
  (GENERIC-6-DOF-CONSTRAINT/GET-FRAME-OFFSET-A (ff-pointer self)))

(defmethod FRAME-OFFSET-B ((self GENERIC-6-DOF-CONSTRAINT))
  (GENERIC-6-DOF-CONSTRAINT/GET-FRAME-OFFSET-B (ff-pointer self)))

(defmethod FRAME-OFFSET-A ((self GENERIC-6-DOF-CONSTRAINT))
  (GENERIC-6-DOF-CONSTRAINT/GET-FRAME-OFFSET-A (ff-pointer self)))

(defmethod FRAME-OFFSET-B ((self GENERIC-6-DOF-CONSTRAINT))
  (GENERIC-6-DOF-CONSTRAINT/GET-FRAME-OFFSET-B (ff-pointer self)))

(defmethod BUILD-JACOBIAN ((self GENERIC-6-DOF-CONSTRAINT))
  (GENERIC-6-DOF-CONSTRAINT/BUILD-JACOBIAN (ff-pointer self)))

(defmethod INFO-1 ((self GENERIC-6-DOF-CONSTRAINT) info)
  (GENERIC-6-DOF-CONSTRAINT/GET-INFO-1 (ff-pointer self) info))

(defmethod INFO-1-NON-VIRTUAL ((self GENERIC-6-DOF-CONSTRAINT) info)
  (GENERIC-6-DOF-CONSTRAINT/GET-INFO-1-NON-VIRTUAL (ff-pointer self) info))

(defmethod INFO-2 ((self GENERIC-6-DOF-CONSTRAINT) info)
  (GENERIC-6-DOF-CONSTRAINT/GET-INFO-2 (ff-pointer self) info))

(defmethod INFO-2-NON-VIRTUAL ((self GENERIC-6-DOF-CONSTRAINT) info (transA TRANSFORM) (transB TRANSFORM) (linVelA VECTOR-3) (linVelB VECTOR-3) (angVelA VECTOR-3) (angVelB VECTOR-3))
  (GENERIC-6-DOF-CONSTRAINT/GET-INFO-2-NON-VIRTUAL (ff-pointer self) info transA transB linVelA linVelB angVelA angVelB))

(defmethod UPDATE-RHS ((self GENERIC-6-DOF-CONSTRAINT) (timeStep number))
  (GENERIC-6-DOF-CONSTRAINT/UPDATE-RHS (ff-pointer self) timeStep))

(defmethod AXIS ((self GENERIC-6-DOF-CONSTRAINT) (axis_index integer))
  (GENERIC-6-DOF-CONSTRAINT/GET-AXIS (ff-pointer self) axis_index))

(defmethod ANGLE ((self GENERIC-6-DOF-CONSTRAINT) (axis_index integer))
  (GENERIC-6-DOF-CONSTRAINT/GET-ANGLE (ff-pointer self) axis_index))

(defmethod RELATIVE-PIVOT-POSITION ((self GENERIC-6-DOF-CONSTRAINT) (axis_index integer))
  (GENERIC-6-DOF-CONSTRAINT/GET-RELATIVE-PIVOT-POSITION (ff-pointer self) axis_index))

(defmethod (SETF FRAMES) ((self GENERIC-6-DOF-CONSTRAINT) (frameA TRANSFORM) (frameB TRANSFORM))
  (GENERIC-6-DOF-CONSTRAINT/SET-FRAMES (ff-pointer self) frameA frameB))

(defmethod TEST-ANGULAR-LIMIT-MOTOR ((self GENERIC-6-DOF-CONSTRAINT) (axis_index integer))
  (GENERIC-6-DOF-CONSTRAINT/TEST-ANGULAR-LIMIT-MOTOR (ff-pointer self) axis_index))

(defmethod (SETF LINEAR-LOWER-LIMIT) ((self GENERIC-6-DOF-CONSTRAINT) (linearLower VECTOR-3))
  (GENERIC-6-DOF-CONSTRAINT/SET-LINEAR-LOWER-LIMIT (ff-pointer self) linearLower))

(defmethod LINEAR-LOWER-LIMIT ((self GENERIC-6-DOF-CONSTRAINT) (linearLower VECTOR-3))
  (GENERIC-6-DOF-CONSTRAINT/GET-LINEAR-LOWER-LIMIT (ff-pointer self) linearLower))

(defmethod (SETF LINEAR-UPPER-LIMIT) ((self GENERIC-6-DOF-CONSTRAINT) (linearUpper VECTOR-3))
  (GENERIC-6-DOF-CONSTRAINT/SET-LINEAR-UPPER-LIMIT (ff-pointer self) linearUpper))

(defmethod LINEAR-UPPER-LIMIT ((self GENERIC-6-DOF-CONSTRAINT) (linearUpper VECTOR-3))
  (GENERIC-6-DOF-CONSTRAINT/GET-LINEAR-UPPER-LIMIT (ff-pointer self) linearUpper))

(defmethod (SETF ANGULAR-LOWER-LIMIT) ((self GENERIC-6-DOF-CONSTRAINT) (angularLower VECTOR-3))
  (GENERIC-6-DOF-CONSTRAINT/SET-ANGULAR-LOWER-LIMIT (ff-pointer self) angularLower))

(defmethod ANGULAR-LOWER-LIMIT ((self GENERIC-6-DOF-CONSTRAINT) (angularLower VECTOR-3))
  (GENERIC-6-DOF-CONSTRAINT/GET-ANGULAR-LOWER-LIMIT (ff-pointer self) angularLower))

(defmethod (SETF ANGULAR-UPPER-LIMIT) ((self GENERIC-6-DOF-CONSTRAINT) (angularUpper VECTOR-3))
  (GENERIC-6-DOF-CONSTRAINT/SET-ANGULAR-UPPER-LIMIT (ff-pointer self) angularUpper))

(defmethod ANGULAR-UPPER-LIMIT ((self GENERIC-6-DOF-CONSTRAINT) (angularUpper VECTOR-3))
  (GENERIC-6-DOF-CONSTRAINT/GET-ANGULAR-UPPER-LIMIT (ff-pointer self) angularUpper))

(defmethod ROTATIONAL-LIMIT-MOTOR ((self GENERIC-6-DOF-CONSTRAINT) (index integer))
  (GENERIC-6-DOF-CONSTRAINT/GET-ROTATIONAL-LIMIT-MOTOR (ff-pointer self) index))

(defmethod TRANSLATIONAL-LIMIT-MOTOR ((self GENERIC-6-DOF-CONSTRAINT))
  (GENERIC-6-DOF-CONSTRAINT/GET-TRANSLATIONAL-LIMIT-MOTOR (ff-pointer self)))

(defmethod (SETF LIMIT) ((self GENERIC-6-DOF-CONSTRAINT) (axis integer) (lo number) (hi number))
  (GENERIC-6-DOF-CONSTRAINT/SET-LIMIT (ff-pointer self) axis lo hi))

(defmethod LIMITEDP ((self GENERIC-6-DOF-CONSTRAINT) (limitIndex integer))
  (GENERIC-6-DOF-CONSTRAINT/IS-LIMITED (ff-pointer self) limitIndex))

(defmethod CALC-ANCHOR-POS ((self GENERIC-6-DOF-CONSTRAINT))
  (GENERIC-6-DOF-CONSTRAINT/CALC-ANCHOR-POS (ff-pointer self)))

(defmethod LIMIT-MOTOR-INFO-2 ((self GENERIC-6-DOF-CONSTRAINT) (limot ROTATIONAL-LIMIT-MOTOR) (transA TRANSFORM) (transB TRANSFORM) (linVelA VECTOR-3) (linVelB VECTOR-3) (angVelA VECTOR-3) (angVelB VECTOR-3) info (row integer) (ax1 VECTOR-3) (rotational integer) (rotAllowed integer))
  (GENERIC-6-DOF-CONSTRAINT/GET/LIMIT/MOTOR/INFO-2 (ff-pointer self) limot transA transB linVelA linVelB angVelA angVelB info row ax1 rotational rotAllowed))

(defmethod LIMIT-MOTOR-INFO-2 ((self GENERIC-6-DOF-CONSTRAINT) (limot ROTATIONAL-LIMIT-MOTOR) (transA TRANSFORM) (transB TRANSFORM) (linVelA VECTOR-3) (linVelB VECTOR-3) (angVelA VECTOR-3) (angVelB VECTOR-3) info (row integer) (ax1 VECTOR-3) (rotational integer))
  (GENERIC-6-DOF-CONSTRAINT/GET/LIMIT/MOTOR/INFO-2 (ff-pointer self) limot transA transB linVelA linVelB angVelA angVelB info row ax1 rotational))

(defmethod USE-FRAME-OFFSET ((self GENERIC-6-DOF-CONSTRAINT))
  (GENERIC-6-DOF-CONSTRAINT/GET-USE-FRAME-OFFSET (ff-pointer self)))

(defmethod (SETF USE-FRAME-OFFSET) ((self GENERIC-6-DOF-CONSTRAINT) (frameOffsetOnOff t))
  (GENERIC-6-DOF-CONSTRAINT/SET-USE-FRAME-OFFSET (ff-pointer self) frameOffsetOnOff))

(defmethod (SETF AXIS) ((self GENERIC-6-DOF-CONSTRAINT) (axis1 VECTOR-3) (axis2 VECTOR-3))
  (GENERIC-6-DOF-CONSTRAINT/SET-AXIS (ff-pointer self) axis1 axis2))
(defmethod CALCULATE-SERIALIZE-BUFFER-SIZE ((self GENERIC-6-DOF-CONSTRAINT))
  (GENERIC-6-DOF-CONSTRAINT/CALCULATE-SERIALIZE-BUFFER-SIZE (ff-pointer self)))
(defmethod SERIALIZE ((self GENERIC-6-DOF-CONSTRAINT) dataBuffer (serializer SERIALIZER))
  (GENERIC-6-DOF-CONSTRAINT/SERIALIZE (ff-pointer self) dataBuffer serializer))


(defmethod NEW ((self SLIDER-CONSTRAINT) sizeInBytes)
  (SLIDER-CONSTRAINT/MAKE-CPLUS-PLUS-INSTANCE (ff-pointer self) sizeInBytes))

(defmethod BULLET/DELETE ((self SLIDER-CONSTRAINT) ptr)
  (SLIDER-CONSTRAINT/DELETE-CPLUS-PLUS-INSTANCE (ff-pointer self) ptr))

(defmethod NEW ((self SLIDER-CONSTRAINT) arg1 ptr)
  (SLIDER-CONSTRAINT/MAKE-CPLUS-PLUS-INSTANCE (ff-pointer self) arg1 ptr))

(defmethod BULLET/DELETE ((self SLIDER-CONSTRAINT) arg1 arg2)
  (SLIDER-CONSTRAINT/DELETE-CPLUS-PLUS-INSTANCE (ff-pointer self) arg1 arg2))
(shadow "new[]")
(defmethod NEW[] ((self SLIDER-CONSTRAINT) sizeInBytes)
  (SLIDER-CONSTRAINT/MAKE-CPLUS-ARRAY (ff-pointer self) sizeInBytes))
(shadow "delete[]")
(defmethod DELETE[] ((self SLIDER-CONSTRAINT) ptr)
  (SLIDER-CONSTRAINT/DELETE-CPLUS-ARRAY (ff-pointer self) ptr))
(shadow "new[]")
(defmethod NEW[] ((self SLIDER-CONSTRAINT) arg1 ptr)
  (SLIDER-CONSTRAINT/MAKE-CPLUS-ARRAY (ff-pointer self) arg1 ptr))
(shadow "delete[]")
(defmethod DELETE[] ((self SLIDER-CONSTRAINT) arg1 arg2)
  (SLIDER-CONSTRAINT/DELETE-CPLUS-ARRAY (ff-pointer self) arg1 arg2))
(defmethod initialize-instance :after ((obj SLIDER-CONSTRAINT) &key (rbA RIGID-BODY) (rbB RIGID-BODY) (frameInA TRANSFORM) (frameInB TRANSFORM) (useLinearReferenceFrameA t))
  (setf (slot-value obj 'ff-pointer) (MAKE-SLIDER-CONSTRAINT rbA rbB frameInA frameInB useLinearReferenceFrameA)))
(defmethod initialize-instance :after ((obj SLIDER-CONSTRAINT) &key (rbB RIGID-BODY) (frameInB TRANSFORM) (useLinearReferenceFrameA t))
  (setf (slot-value obj 'ff-pointer) (MAKE-SLIDER-CONSTRAINT rbB frameInB useLinearReferenceFrameA)))
(defmethod INFO-1 ((self SLIDER-CONSTRAINT) info)
  (SLIDER-CONSTRAINT/GET-INFO-1 (ff-pointer self) info))
(defmethod INFO-1-NON-VIRTUAL ((self SLIDER-CONSTRAINT) info)
  (SLIDER-CONSTRAINT/GET-INFO-1-NON-VIRTUAL (ff-pointer self) info))
(defmethod INFO-2 ((self SLIDER-CONSTRAINT) info)
  (SLIDER-CONSTRAINT/GET-INFO-2 (ff-pointer self) info))
(defmethod INFO-2-NON-VIRTUAL ((self SLIDER-CONSTRAINT) info (transA TRANSFORM) (transB TRANSFORM) (linVelA VECTOR-3) (linVelB VECTOR-3) (rbAinvMass number) (rbBinvMass number))
  (SLIDER-CONSTRAINT/GET-INFO-2-NON-VIRTUAL (ff-pointer self) info transA transB linVelA linVelB rbAinvMass rbBinvMass))
(defmethod RIGID-BODY-A ((self SLIDER-CONSTRAINT))
  (SLIDER-CONSTRAINT/GET-RIGID-BODY-A (ff-pointer self)))

(defmethod RIGID-BODY-B ((self SLIDER-CONSTRAINT))
  (SLIDER-CONSTRAINT/GET-RIGID-BODY-B (ff-pointer self)))

(defmethod CALCULATED-TRANSFORM-A ((self SLIDER-CONSTRAINT))
  (SLIDER-CONSTRAINT/GET-CALCULATED-TRANSFORM-A (ff-pointer self)))

(defmethod CALCULATED-TRANSFORM-B ((self SLIDER-CONSTRAINT))
  (SLIDER-CONSTRAINT/GET-CALCULATED-TRANSFORM-B (ff-pointer self)))

(defmethod FRAME-OFFSET-A ((self SLIDER-CONSTRAINT))
  (SLIDER-CONSTRAINT/GET-FRAME-OFFSET-A (ff-pointer self)))

(defmethod FRAME-OFFSET-B ((self SLIDER-CONSTRAINT))
  (SLIDER-CONSTRAINT/GET-FRAME-OFFSET-B (ff-pointer self)))

(defmethod FRAME-OFFSET-A ((self SLIDER-CONSTRAINT))
  (SLIDER-CONSTRAINT/GET-FRAME-OFFSET-A (ff-pointer self)))

(defmethod FRAME-OFFSET-B ((self SLIDER-CONSTRAINT))
  (SLIDER-CONSTRAINT/GET-FRAME-OFFSET-B (ff-pointer self)))

(defmethod LOWER-LIN-LIMIT ((self SLIDER-CONSTRAINT))
  (SLIDER-CONSTRAINT/GET-LOWER-LIN-LIMIT (ff-pointer self)))

(defmethod (SETF LOWER-LIN-LIMIT) ((self SLIDER-CONSTRAINT) (lowerLimit number))
  (SLIDER-CONSTRAINT/SET-LOWER-LIN-LIMIT (ff-pointer self) lowerLimit))

(defmethod UPPER-LIN-LIMIT ((self SLIDER-CONSTRAINT))
  (SLIDER-CONSTRAINT/GET-UPPER-LIN-LIMIT (ff-pointer self)))

(defmethod (SETF UPPER-LIN-LIMIT) ((self SLIDER-CONSTRAINT) (upperLimit number))
  (SLIDER-CONSTRAINT/SET-UPPER-LIN-LIMIT (ff-pointer self) upperLimit))

(defmethod LOWER-ANG-LIMIT ((self SLIDER-CONSTRAINT))
  (SLIDER-CONSTRAINT/GET-LOWER-ANG-LIMIT (ff-pointer self)))

(defmethod (SETF LOWER-ANG-LIMIT) ((self SLIDER-CONSTRAINT) (lowerLimit number))
  (SLIDER-CONSTRAINT/SET-LOWER-ANG-LIMIT (ff-pointer self) lowerLimit))

(defmethod UPPER-ANG-LIMIT ((self SLIDER-CONSTRAINT))
  (SLIDER-CONSTRAINT/GET-UPPER-ANG-LIMIT (ff-pointer self)))

(defmethod (SETF UPPER-ANG-LIMIT) ((self SLIDER-CONSTRAINT) (upperLimit number))
  (SLIDER-CONSTRAINT/SET-UPPER-ANG-LIMIT (ff-pointer self) upperLimit))

(defmethod USE-LINEAR-REFERENCE-FRAME-A ((self SLIDER-CONSTRAINT))
  (SLIDER-CONSTRAINT/GET-USE-LINEAR-REFERENCE-FRAME-A (ff-pointer self)))

(defmethod SOFTNESS-DIR-LIN ((self SLIDER-CONSTRAINT))
  (SLIDER-CONSTRAINT/GET-SOFTNESS-DIR-LIN (ff-pointer self)))

(defmethod RESTITUTION-DIR-LIN ((self SLIDER-CONSTRAINT))
  (SLIDER-CONSTRAINT/GET-RESTITUTION-DIR-LIN (ff-pointer self)))

(defmethod DAMPING-DIR-LIN ((self SLIDER-CONSTRAINT))
  (SLIDER-CONSTRAINT/GET-DAMPING-DIR-LIN (ff-pointer self)))

(defmethod SOFTNESS-DIR-ANG ((self SLIDER-CONSTRAINT))
  (SLIDER-CONSTRAINT/GET-SOFTNESS-DIR-ANG (ff-pointer self)))

(defmethod RESTITUTION-DIR-ANG ((self SLIDER-CONSTRAINT))
  (SLIDER-CONSTRAINT/GET-RESTITUTION-DIR-ANG (ff-pointer self)))

(defmethod DAMPING-DIR-ANG ((self SLIDER-CONSTRAINT))
  (SLIDER-CONSTRAINT/GET-DAMPING-DIR-ANG (ff-pointer self)))

(defmethod SOFTNESS-LIM-LIN ((self SLIDER-CONSTRAINT))
  (SLIDER-CONSTRAINT/GET-SOFTNESS-LIM-LIN (ff-pointer self)))

(defmethod RESTITUTION-LIM-LIN ((self SLIDER-CONSTRAINT))
  (SLIDER-CONSTRAINT/GET-RESTITUTION-LIM-LIN (ff-pointer self)))

(defmethod DAMPING-LIM-LIN ((self SLIDER-CONSTRAINT))
  (SLIDER-CONSTRAINT/GET-DAMPING-LIM-LIN (ff-pointer self)))

(defmethod SOFTNESS-LIM-ANG ((self SLIDER-CONSTRAINT))
  (SLIDER-CONSTRAINT/GET-SOFTNESS-LIM-ANG (ff-pointer self)))

(defmethod RESTITUTION-LIM-ANG ((self SLIDER-CONSTRAINT))
  (SLIDER-CONSTRAINT/GET-RESTITUTION-LIM-ANG (ff-pointer self)))

(defmethod DAMPING-LIM-ANG ((self SLIDER-CONSTRAINT))
  (SLIDER-CONSTRAINT/GET-DAMPING-LIM-ANG (ff-pointer self)))

(defmethod SOFTNESS-ORTHO-LIN ((self SLIDER-CONSTRAINT))
  (SLIDER-CONSTRAINT/GET-SOFTNESS-ORTHO-LIN (ff-pointer self)))

(defmethod RESTITUTION-ORTHO-LIN ((self SLIDER-CONSTRAINT))
  (SLIDER-CONSTRAINT/GET-RESTITUTION-ORTHO-LIN (ff-pointer self)))

(defmethod DAMPING-ORTHO-LIN ((self SLIDER-CONSTRAINT))
  (SLIDER-CONSTRAINT/GET-DAMPING-ORTHO-LIN (ff-pointer self)))

(defmethod SOFTNESS-ORTHO-ANG ((self SLIDER-CONSTRAINT))
  (SLIDER-CONSTRAINT/GET-SOFTNESS-ORTHO-ANG (ff-pointer self)))

(defmethod RESTITUTION-ORTHO-ANG ((self SLIDER-CONSTRAINT))
  (SLIDER-CONSTRAINT/GET-RESTITUTION-ORTHO-ANG (ff-pointer self)))

(defmethod DAMPING-ORTHO-ANG ((self SLIDER-CONSTRAINT))
  (SLIDER-CONSTRAINT/GET-DAMPING-ORTHO-ANG (ff-pointer self)))

(defmethod (SETF SOFTNESS-DIR-LIN) ((self SLIDER-CONSTRAINT) (softnessDirLin number))
  (SLIDER-CONSTRAINT/SET-SOFTNESS-DIR-LIN (ff-pointer self) softnessDirLin))

(defmethod (SETF RESTITUTION-DIR-LIN) ((self SLIDER-CONSTRAINT) (restitutionDirLin number))
  (SLIDER-CONSTRAINT/SET-RESTITUTION-DIR-LIN (ff-pointer self) restitutionDirLin))

(defmethod (SETF DAMPING-DIR-LIN) ((self SLIDER-CONSTRAINT) (dampingDirLin number))
  (SLIDER-CONSTRAINT/SET-DAMPING-DIR-LIN (ff-pointer self) dampingDirLin))

(defmethod (SETF SOFTNESS-DIR-ANG) ((self SLIDER-CONSTRAINT) (softnessDirAng number))
  (SLIDER-CONSTRAINT/SET-SOFTNESS-DIR-ANG (ff-pointer self) softnessDirAng))

(defmethod (SETF RESTITUTION-DIR-ANG) ((self SLIDER-CONSTRAINT) (restitutionDirAng number))
  (SLIDER-CONSTRAINT/SET-RESTITUTION-DIR-ANG (ff-pointer self) restitutionDirAng))

(defmethod (SETF DAMPING-DIR-ANG) ((self SLIDER-CONSTRAINT) (dampingDirAng number))
  (SLIDER-CONSTRAINT/SET-DAMPING-DIR-ANG (ff-pointer self) dampingDirAng))

(defmethod (SETF SOFTNESS-LIM-LIN) ((self SLIDER-CONSTRAINT) (softnessLimLin number))
  (SLIDER-CONSTRAINT/SET-SOFTNESS-LIM-LIN (ff-pointer self) softnessLimLin))

(defmethod (SETF RESTITUTION-LIM-LIN) ((self SLIDER-CONSTRAINT) (restitutionLimLin number))
  (SLIDER-CONSTRAINT/SET-RESTITUTION-LIM-LIN (ff-pointer self) restitutionLimLin))

(defmethod (SETF DAMPING-LIM-LIN) ((self SLIDER-CONSTRAINT) (dampingLimLin number))
  (SLIDER-CONSTRAINT/SET-DAMPING-LIM-LIN (ff-pointer self) dampingLimLin))

(defmethod (SETF SOFTNESS-LIM-ANG) ((self SLIDER-CONSTRAINT) (softnessLimAng number))
  (SLIDER-CONSTRAINT/SET-SOFTNESS-LIM-ANG (ff-pointer self) softnessLimAng))

(defmethod (SETF RESTITUTION-LIM-ANG) ((self SLIDER-CONSTRAINT) (restitutionLimAng number))
  (SLIDER-CONSTRAINT/SET-RESTITUTION-LIM-ANG (ff-pointer self) restitutionLimAng))

(defmethod (SETF DAMPING-LIM-ANG) ((self SLIDER-CONSTRAINT) (dampingLimAng number))
  (SLIDER-CONSTRAINT/SET-DAMPING-LIM-ANG (ff-pointer self) dampingLimAng))

(defmethod (SETF SOFTNESS-ORTHO-LIN) ((self SLIDER-CONSTRAINT) (softnessOrthoLin number))
  (SLIDER-CONSTRAINT/SET-SOFTNESS-ORTHO-LIN (ff-pointer self) softnessOrthoLin))

(defmethod (SETF RESTITUTION-ORTHO-LIN) ((self SLIDER-CONSTRAINT) (restitutionOrthoLin number))
  (SLIDER-CONSTRAINT/SET-RESTITUTION-ORTHO-LIN (ff-pointer self) restitutionOrthoLin))

(defmethod (SETF DAMPING-ORTHO-LIN) ((self SLIDER-CONSTRAINT) (dampingOrthoLin number))
  (SLIDER-CONSTRAINT/SET-DAMPING-ORTHO-LIN (ff-pointer self) dampingOrthoLin))

(defmethod (SETF SOFTNESS-ORTHO-ANG) ((self SLIDER-CONSTRAINT) (softnessOrthoAng number))
  (SLIDER-CONSTRAINT/SET-SOFTNESS-ORTHO-ANG (ff-pointer self) softnessOrthoAng))

(defmethod (SETF RESTITUTION-ORTHO-ANG) ((self SLIDER-CONSTRAINT) (restitutionOrthoAng number))
  (SLIDER-CONSTRAINT/SET-RESTITUTION-ORTHO-ANG (ff-pointer self) restitutionOrthoAng))

(defmethod (SETF DAMPING-ORTHO-ANG) ((self SLIDER-CONSTRAINT) (dampingOrthoAng number))
  (SLIDER-CONSTRAINT/SET-DAMPING-ORTHO-ANG (ff-pointer self) dampingOrthoAng))

(defmethod (SETF POWERED-LIN-MOTOR) ((self SLIDER-CONSTRAINT) (onOff t))
  (SLIDER-CONSTRAINT/SET-POWERED-LIN-MOTOR (ff-pointer self) onOff))

(defmethod POWERED-LIN-MOTOR ((self SLIDER-CONSTRAINT))
  (SLIDER-CONSTRAINT/GET-POWERED-LIN-MOTOR (ff-pointer self)))

(defmethod (SETF TARGET-LIN-MOTOR-VELOCITY) ((self SLIDER-CONSTRAINT) (targetLinMotorVelocity number))
  (SLIDER-CONSTRAINT/SET-TARGET-LIN-MOTOR-VELOCITY (ff-pointer self) targetLinMotorVelocity))

(defmethod TARGET-LIN-MOTOR-VELOCITY ((self SLIDER-CONSTRAINT))
  (SLIDER-CONSTRAINT/GET-TARGET-LIN-MOTOR-VELOCITY (ff-pointer self)))

(defmethod (SETF MAX-LIN-MOTOR-FORCE) ((self SLIDER-CONSTRAINT) (maxLinMotorForce number))
  (SLIDER-CONSTRAINT/SET-MAX-LIN-MOTOR-FORCE (ff-pointer self) maxLinMotorForce))

(defmethod MAX-LIN-MOTOR-FORCE ((self SLIDER-CONSTRAINT))
  (SLIDER-CONSTRAINT/GET-MAX-LIN-MOTOR-FORCE (ff-pointer self)))

(defmethod (SETF POWERED-ANG-MOTOR) ((self SLIDER-CONSTRAINT) (onOff t))
  (SLIDER-CONSTRAINT/SET-POWERED-ANG-MOTOR (ff-pointer self) onOff))

(defmethod POWERED-ANG-MOTOR ((self SLIDER-CONSTRAINT))
  (SLIDER-CONSTRAINT/GET-POWERED-ANG-MOTOR (ff-pointer self)))

(defmethod (SETF TARGET-ANG-MOTOR-VELOCITY) ((self SLIDER-CONSTRAINT) (targetAngMotorVelocity number))
  (SLIDER-CONSTRAINT/SET-TARGET-ANG-MOTOR-VELOCITY (ff-pointer self) targetAngMotorVelocity))

(defmethod TARGET-ANG-MOTOR-VELOCITY ((self SLIDER-CONSTRAINT))
  (SLIDER-CONSTRAINT/GET-TARGET-ANG-MOTOR-VELOCITY (ff-pointer self)))

(defmethod (SETF MAX-ANG-MOTOR-FORCE) ((self SLIDER-CONSTRAINT) (maxAngMotorForce number))
  (SLIDER-CONSTRAINT/SET-MAX-ANG-MOTOR-FORCE (ff-pointer self) maxAngMotorForce))

(defmethod MAX-ANG-MOTOR-FORCE ((self SLIDER-CONSTRAINT))
  (SLIDER-CONSTRAINT/GET-MAX-ANG-MOTOR-FORCE (ff-pointer self)))

(defmethod LINEAR-POS ((self SLIDER-CONSTRAINT))
  (SLIDER-CONSTRAINT/GET-LINEAR-POS (ff-pointer self)))

(defmethod ANGULAR-POS ((self SLIDER-CONSTRAINT))
  (SLIDER-CONSTRAINT/GET-ANGULAR-POS (ff-pointer self)))

(defmethod SOLVE-LIN-LIMIT ((self SLIDER-CONSTRAINT))
  (SLIDER-CONSTRAINT/GET-SOLVE-LIN-LIMIT (ff-pointer self)))

(defmethod LIN-DEPTH ((self SLIDER-CONSTRAINT))
  (SLIDER-CONSTRAINT/GET-LIN-DEPTH (ff-pointer self)))

(defmethod SOLVE-ANG-LIMIT ((self SLIDER-CONSTRAINT))
  (SLIDER-CONSTRAINT/GET-SOLVE-ANG-LIMIT (ff-pointer self)))

(defmethod ANG-DEPTH ((self SLIDER-CONSTRAINT))
  (SLIDER-CONSTRAINT/GET-ANG-DEPTH (ff-pointer self)))

(defmethod CALCULATE-TRANSFORMS ((self SLIDER-CONSTRAINT) (transA TRANSFORM) (transB TRANSFORM))
  (SLIDER-CONSTRAINT/CALCULATE-TRANSFORMS (ff-pointer self) transA transB))

(defmethod TEST-LIN-LIMITS ((self SLIDER-CONSTRAINT))
  (SLIDER-CONSTRAINT/TEST-LIN-LIMITS (ff-pointer self)))

(defmethod TEST-ANG-LIMITS ((self SLIDER-CONSTRAINT))
  (SLIDER-CONSTRAINT/TEST-ANG-LIMITS (ff-pointer self)))

(defmethod ANCOR-IN-A ((self SLIDER-CONSTRAINT))
  (SLIDER-CONSTRAINT/GET-ANCOR-IN-A (ff-pointer self)))

(defmethod ANCOR-IN-B ((self SLIDER-CONSTRAINT))
  (SLIDER-CONSTRAINT/GET-ANCOR-IN-B (ff-pointer self)))

(defmethod USE-FRAME-OFFSET ((self SLIDER-CONSTRAINT))
  (SLIDER-CONSTRAINT/GET-USE-FRAME-OFFSET (ff-pointer self)))

(defmethod (SETF USE-FRAME-OFFSET) ((self SLIDER-CONSTRAINT) (frameOffsetOnOff t))
  (SLIDER-CONSTRAINT/SET-USE-FRAME-OFFSET (ff-pointer self) frameOffsetOnOff))

(defmethod (SETF FRAMES) ((self SLIDER-CONSTRAINT) (frameA TRANSFORM) (frameB TRANSFORM))
  (SLIDER-CONSTRAINT/SET-FRAMES (ff-pointer self) frameA frameB))

(defmethod CALCULATE-SERIALIZE-BUFFER-SIZE ((self SLIDER-CONSTRAINT))
  (SLIDER-CONSTRAINT/CALCULATE-SERIALIZE-BUFFER-SIZE (ff-pointer self)))

(defmethod SERIALIZE ((self SLIDER-CONSTRAINT) dataBuffer (serializer SERIALIZER))
  (SLIDER-CONSTRAINT/SERIALIZE (ff-pointer self) dataBuffer serializer))



(defmethod NEW ((self GENERIC-6-DOF-SPRING-CONSTRAINT) sizeInBytes)
  (GENERIC-6-DOF-SPRING-CONSTRAINT/MAKE-CPLUS-PLUS-INSTANCE (ff-pointer self) sizeInBytes))

(defmethod BULLET/DELETE ((self GENERIC-6-DOF-SPRING-CONSTRAINT) ptr)
  (GENERIC-6-DOF-SPRING-CONSTRAINT/DELETE-CPLUS-PLUS-INSTANCE (ff-pointer self) ptr))

(defmethod NEW ((self GENERIC-6-DOF-SPRING-CONSTRAINT) arg1 ptr)
  (GENERIC-6-DOF-SPRING-CONSTRAINT/MAKE-CPLUS-PLUS-INSTANCE (ff-pointer self) arg1 ptr))

(defmethod BULLET/DELETE ((self GENERIC-6-DOF-SPRING-CONSTRAINT) arg1 arg2)
  (GENERIC-6-DOF-SPRING-CONSTRAINT/DELETE-CPLUS-PLUS-INSTANCE (ff-pointer self) arg1 arg2))
(shadow "new[]")
(defmethod NEW[] ((self GENERIC-6-DOF-SPRING-CONSTRAINT) sizeInBytes)
  (GENERIC-6-DOF-SPRING-CONSTRAINT/MAKE-CPLUS-ARRAY (ff-pointer self) sizeInBytes))
(shadow "delete[]")
(defmethod DELETE[] ((self GENERIC-6-DOF-SPRING-CONSTRAINT) ptr)
  (GENERIC-6-DOF-SPRING-CONSTRAINT/DELETE-CPLUS-ARRAY (ff-pointer self) ptr))
(shadow "new[]")
(defmethod NEW[] ((self GENERIC-6-DOF-SPRING-CONSTRAINT) arg1 ptr)
  (GENERIC-6-DOF-SPRING-CONSTRAINT/MAKE-CPLUS-ARRAY (ff-pointer self) arg1 ptr))
(shadow "delete[]")
(defmethod DELETE[] ((self GENERIC-6-DOF-SPRING-CONSTRAINT) arg1 arg2)
  (GENERIC-6-DOF-SPRING-CONSTRAINT/DELETE-CPLUS-ARRAY (ff-pointer self) arg1 arg2))
(defmethod initialize-instance :after ((obj GENERIC-6-DOF-SPRING-CONSTRAINT) &key (rbA RIGID-BODY) (rbB RIGID-BODY) (frameInA TRANSFORM) (frameInB TRANSFORM) (useLinearReferenceFrameA t))
  (setf (slot-value obj 'ff-pointer) (MAKE-GENERIC-6-DOF-SPRING-CONSTRAINT rbA rbB frameInA frameInB useLinearReferenceFrameA)))
(defmethod initialize-instance :after ((obj GENERIC-6-DOF-SPRING-CONSTRAINT) &key (rbB RIGID-BODY) (frameInB TRANSFORM) (useLinearReferenceFrameB t))
  (setf (slot-value obj 'ff-pointer) (MAKE-GENERIC-6-DOF-SPRING-CONSTRAINT rbB frameInB useLinearReferenceFrameB)))
(defmethod ENABLE-SPRING ((self GENERIC-6-DOF-SPRING-CONSTRAINT) (index integer) (onOff t))
  (GENERIC-6-DOF-SPRING-CONSTRAINT/ENABLE-SPRING (ff-pointer self) index onOff))
(defmethod (SETF STIFFNESS) ((self GENERIC-6-DOF-SPRING-CONSTRAINT) (index integer) (stiffness number))
  (GENERIC-6-DOF-SPRING-CONSTRAINT/SET-STIFFNESS (ff-pointer self) index stiffness))
(defmethod (SETF DAMPING) ((self GENERIC-6-DOF-SPRING-CONSTRAINT) (index integer) (damping number))
  (GENERIC-6-DOF-SPRING-CONSTRAINT/SET-DAMPING (ff-pointer self) index damping))
(defmethod (SETF EQUILIBRIUM-POINT) ((self GENERIC-6-DOF-SPRING-CONSTRAINT))
  (GENERIC-6-DOF-SPRING-CONSTRAINT/SET-EQUILIBRIUM-POINT (ff-pointer self)))
(defmethod (SETF EQUILIBRIUM-POINT) ((self GENERIC-6-DOF-SPRING-CONSTRAINT) (index integer))
  (GENERIC-6-DOF-SPRING-CONSTRAINT/SET-EQUILIBRIUM-POINT (ff-pointer self) index))
(defmethod (SETF EQUILIBRIUM-POINT) ((self GENERIC-6-DOF-SPRING-CONSTRAINT) (index integer) (val number))
  (GENERIC-6-DOF-SPRING-CONSTRAINT/SET-EQUILIBRIUM-POINT (ff-pointer self) index val))
(defmethod (SETF AXIS) ((self GENERIC-6-DOF-SPRING-CONSTRAINT) (axis1 VECTOR-3) (axis2 VECTOR-3))
  (GENERIC-6-DOF-SPRING-CONSTRAINT/SET-AXIS (ff-pointer self) axis1 axis2))
(defmethod INFO-2 ((self GENERIC-6-DOF-SPRING-CONSTRAINT) info)
  (GENERIC-6-DOF-SPRING-CONSTRAINT/GET-INFO-2 (ff-pointer self) info))
(defmethod CALCULATE-SERIALIZE-BUFFER-SIZE ((self GENERIC-6-DOF-SPRING-CONSTRAINT))
  (GENERIC-6-DOF-SPRING-CONSTRAINT/CALCULATE-SERIALIZE-BUFFER-SIZE (ff-pointer self)))

(defmethod SERIALIZE ((self GENERIC-6-DOF-SPRING-CONSTRAINT) dataBuffer (serializer SERIALIZER))
  (GENERIC-6-DOF-SPRING-CONSTRAINT/SERIALIZE (ff-pointer self) dataBuffer serializer))



(defmethod NEW ((self UNIVERSAL-CONSTRAINT) sizeInBytes)
  (UNIVERSAL-CONSTRAINT/MAKE-CPLUS-PLUS-INSTANCE (ff-pointer self) sizeInBytes))

(defmethod BULLET/DELETE ((self UNIVERSAL-CONSTRAINT) ptr)
  (UNIVERSAL-CONSTRAINT/DELETE-CPLUS-PLUS-INSTANCE (ff-pointer self) ptr))

(defmethod NEW ((self UNIVERSAL-CONSTRAINT) arg1 ptr)
  (UNIVERSAL-CONSTRAINT/MAKE-CPLUS-PLUS-INSTANCE (ff-pointer self) arg1 ptr))

(defmethod BULLET/DELETE ((self UNIVERSAL-CONSTRAINT) arg1 arg2)
  (UNIVERSAL-CONSTRAINT/DELETE-CPLUS-PLUS-INSTANCE (ff-pointer self) arg1 arg2))

(shadow "new[]")
(defmethod NEW[] ((self UNIVERSAL-CONSTRAINT) sizeInBytes)
  (UNIVERSAL-CONSTRAINT/MAKE-CPLUS-ARRAY (ff-pointer self) sizeInBytes))

(shadow "delete[]")
(defmethod DELETE[] ((self UNIVERSAL-CONSTRAINT) ptr)
  (UNIVERSAL-CONSTRAINT/DELETE-CPLUS-ARRAY (ff-pointer self) ptr))

(shadow "new[]")
(defmethod NEW[] ((self UNIVERSAL-CONSTRAINT) arg1 ptr)
  (UNIVERSAL-CONSTRAINT/MAKE-CPLUS-ARRAY (ff-pointer self) arg1 ptr))

(shadow "delete[]")
(defmethod DELETE[] ((self UNIVERSAL-CONSTRAINT) arg1 arg2)
  (UNIVERSAL-CONSTRAINT/DELETE-CPLUS-ARRAY (ff-pointer self) arg1 arg2))

(defmethod initialize-instance :after ((obj UNIVERSAL-CONSTRAINT) &key (rbA RIGID-BODY) (rbB RIGID-BODY) (anchor VECTOR-3) (axis1 VECTOR-3) (axis2 VECTOR-3))
  (setf (slot-value obj 'ff-pointer) (MAKE-UNIVERSAL-CONSTRAINT rbA rbB anchor axis1 axis2)))

(defmethod ANCHOR ((self UNIVERSAL-CONSTRAINT))
  (UNIVERSAL-CONSTRAINT/GET-ANCHOR (ff-pointer self)))

(defmethod ANCHOR-2 ((self UNIVERSAL-CONSTRAINT))
  (UNIVERSAL-CONSTRAINT/GET-ANCHOR-2 (ff-pointer self)))

(defmethod AXIS-1 ((self UNIVERSAL-CONSTRAINT))
  (UNIVERSAL-CONSTRAINT/GET-AXIS-1 (ff-pointer self)))

(defmethod AXIS-2 ((self UNIVERSAL-CONSTRAINT))
  (UNIVERSAL-CONSTRAINT/GET-AXIS-2 (ff-pointer self)))

(defmethod ANGLE-1 ((self UNIVERSAL-CONSTRAINT))
  (UNIVERSAL-CONSTRAINT/GET-ANGLE-1 (ff-pointer self)))

(defmethod ANGLE-2 ((self UNIVERSAL-CONSTRAINT))
  (UNIVERSAL-CONSTRAINT/GET-ANGLE-2 (ff-pointer self)))

(defmethod (SETF UPPER-LIMIT) ((self UNIVERSAL-CONSTRAINT) (ang1max number) (ang2max number))
  (UNIVERSAL-CONSTRAINT/SET-UPPER-LIMIT (ff-pointer self) ang1max ang2max))

(defmethod (SETF LOWER-LIMIT) ((self UNIVERSAL-CONSTRAINT) (ang1min number) (ang2min number))
  (UNIVERSAL-CONSTRAINT/SET-LOWER-LIMIT (ff-pointer self) ang1min ang2min))

(defmethod (SETF AXIS) ((self UNIVERSAL-CONSTRAINT) (axis1 VECTOR-3) (axis2 VECTOR-3))
  (UNIVERSAL-CONSTRAINT/SET-AXIS (ff-pointer self) axis1 axis2))



(defmethod NEW ((self HINGE-2-CONSTRAINT) sizeInBytes)
  (HINGE-2-CONSTRAINT/MAKE-CPLUS-PLUS-INSTANCE (ff-pointer self) sizeInBytes))

(defmethod BULLET/DELETE ((self HINGE-2-CONSTRAINT) ptr)
  (HINGE-2-CONSTRAINT/DELETE-CPLUS-PLUS-INSTANCE (ff-pointer self) ptr))

(defmethod NEW ((self HINGE-2-CONSTRAINT) arg1 ptr)
  (HINGE-2-CONSTRAINT/MAKE-CPLUS-PLUS-INSTANCE (ff-pointer self) arg1 ptr))

(defmethod BULLET/DELETE ((self HINGE-2-CONSTRAINT) arg1 arg2)
  (HINGE-2-CONSTRAINT/DELETE-CPLUS-PLUS-INSTANCE (ff-pointer self) arg1 arg2))

(shadow "new[]")
(defmethod NEW[] ((self HINGE-2-CONSTRAINT) sizeInBytes)
  (HINGE-2-CONSTRAINT/MAKE-CPLUS-ARRAY (ff-pointer self) sizeInBytes))

(shadow "delete[]")
(defmethod DELETE[] ((self HINGE-2-CONSTRAINT) ptr)
  (HINGE-2-CONSTRAINT/DELETE-CPLUS-ARRAY (ff-pointer self) ptr))

(shadow "new[]")
(defmethod NEW[] ((self HINGE-2-CONSTRAINT) arg1 ptr)
  (HINGE-2-CONSTRAINT/MAKE-CPLUS-ARRAY (ff-pointer self) arg1 ptr))

(shadow "delete[]")
(defmethod DELETE[] ((self HINGE-2-CONSTRAINT) arg1 arg2)
  (HINGE-2-CONSTRAINT/DELETE-CPLUS-ARRAY (ff-pointer self) arg1 arg2))

(defmethod initialize-instance :after ((obj HINGE-2-CONSTRAINT) &key (rbA RIGID-BODY) (rbB RIGID-BODY) (anchor VECTOR-3) (axis1 VECTOR-3) (axis2 VECTOR-3))
  (setf (slot-value obj 'ff-pointer) (MAKE-HINGE-2-CONSTRAINT rbA rbB anchor axis1 axis2)))

(defmethod ANCHOR ((self HINGE-2-CONSTRAINT))
  (HINGE-2-CONSTRAINT/GET-ANCHOR (ff-pointer self)))

(defmethod ANCHOR-2 ((self HINGE-2-CONSTRAINT))
  (HINGE-2-CONSTRAINT/GET-ANCHOR-2 (ff-pointer self)))

(defmethod AXIS-1 ((self HINGE-2-CONSTRAINT))
  (HINGE-2-CONSTRAINT/GET-AXIS-1 (ff-pointer self)))

(defmethod AXIS-2 ((self HINGE-2-CONSTRAINT))
  (HINGE-2-CONSTRAINT/GET-AXIS-2 (ff-pointer self)))

(defmethod ANGLE-1 ((self HINGE-2-CONSTRAINT))
  (HINGE-2-CONSTRAINT/GET-ANGLE-1 (ff-pointer self)))

(defmethod ANGLE-2 ((self HINGE-2-CONSTRAINT))
  (HINGE-2-CONSTRAINT/GET-ANGLE-2 (ff-pointer self)))

(defmethod (SETF UPPER-LIMIT) ((self HINGE-2-CONSTRAINT) (ang1max number))
  (HINGE-2-CONSTRAINT/SET-UPPER-LIMIT (ff-pointer self) ang1max))

(defmethod (SETF LOWER-LIMIT) ((self HINGE-2-CONSTRAINT) (ang1min number))
  (HINGE-2-CONSTRAINT/SET-LOWER-LIMIT (ff-pointer self) ang1min))



(defmethod initialize-instance :after ((obj GEAR-CONSTRAINT) &key (rbA RIGID-BODY) (rbB RIGID-BODY) (axisInA VECTOR-3) (axisInB VECTOR-3) (ratio number))
  (setf (slot-value obj 'ff-pointer) (MAKE-GEAR-CONSTRAINT rbA rbB axisInA axisInB ratio)))

(defmethod initialize-instance :after ((obj GEAR-CONSTRAINT) &key (rbA RIGID-BODY) (rbB RIGID-BODY) (axisInA VECTOR-3) (axisInB VECTOR-3))
  (setf (slot-value obj 'ff-pointer) (MAKE-GEAR-CONSTRAINT rbA rbB axisInA axisInB)))

(defmethod INFO-1 ((self GEAR-CONSTRAINT) info)
  (GEAR-CONSTRAINT/GET-INFO-1 (ff-pointer self) info))

(defmethod INFO-2 ((self GEAR-CONSTRAINT) info)
  (GEAR-CONSTRAINT/GET-INFO-2 (ff-pointer self) info))

(defmethod (SETF AXIS-A) ((self GEAR-CONSTRAINT) (axisA VECTOR-3))
  (GEAR-CONSTRAINT/SET-AXIS-A (ff-pointer self) axisA))

(defmethod (SETF AXIS-B) ((self GEAR-CONSTRAINT) (axisB VECTOR-3))
  (GEAR-CONSTRAINT/SET-AXIS-B (ff-pointer self) axisB))

(defmethod (SETF BULLET/RATIO) ((self GEAR-CONSTRAINT) (ratio number))
  (GEAR-CONSTRAINT/SET-RATIO (ff-pointer self) ratio))

(defmethod AXIS-A ((self GEAR-CONSTRAINT))
  (GEAR-CONSTRAINT/GET-AXIS-A (ff-pointer self)))

(defmethod AXIS-B ((self GEAR-CONSTRAINT))
  (GEAR-CONSTRAINT/GET-AXIS-B (ff-pointer self)))

(defmethod BULLET/RATIO ((self GEAR-CONSTRAINT))
  (GEAR-CONSTRAINT/GET-RATIO (ff-pointer self)))

(defmethod CALCULATE-SERIALIZE-BUFFER-SIZE ((self GEAR-CONSTRAINT))
  (GEAR-CONSTRAINT/CALCULATE-SERIALIZE-BUFFER-SIZE (ff-pointer self)))

(defmethod SERIALIZE ((self GEAR-CONSTRAINT) dataBuffer (serializer SERIALIZER))
  (GEAR-CONSTRAINT/SERIALIZE (ff-pointer self) dataBuffer serializer))



(defmethod initialize-instance :after ((obj FIXED-CONSTRAINT) &key (rbA RIGID-BODY) (rbB RIGID-BODY) (frameInA TRANSFORM) (frameInB TRANSFORM))
  (setf (slot-value obj 'ff-pointer) (MAKE-FIXED-CONSTRAINT rbA rbB frameInA frameInB)))

(defmethod INFO-1 ((self FIXED-CONSTRAINT) info)
  (FIXED-CONSTRAINT/GET-INFO-1 (ff-pointer self) info))

(defmethod INFO-2 ((self FIXED-CONSTRAINT) info)
  (FIXED-CONSTRAINT/GET-INFO-2 (ff-pointer self) info))



(defmethod NEW ((self SEQUENTIAL-IMPULSE-CONSTRAINT-SOLVER) sizeInBytes)
  (SEQUENTIAL-IMPULSE-CONSTRAINT-SOLVER/MAKE-CPLUS-PLUS-INSTANCE (ff-pointer self) sizeInBytes))

(defmethod BULLET/DELETE ((self SEQUENTIAL-IMPULSE-CONSTRAINT-SOLVER) ptr)
  (SEQUENTIAL-IMPULSE-CONSTRAINT-SOLVER/DELETE-CPLUS-PLUS-INSTANCE (ff-pointer self) ptr))

(defmethod NEW ((self SEQUENTIAL-IMPULSE-CONSTRAINT-SOLVER) arg1 ptr)
  (SEQUENTIAL-IMPULSE-CONSTRAINT-SOLVER/MAKE-CPLUS-PLUS-INSTANCE (ff-pointer self) arg1 ptr))

(defmethod BULLET/DELETE ((self SEQUENTIAL-IMPULSE-CONSTRAINT-SOLVER) arg1 arg2)
  (SEQUENTIAL-IMPULSE-CONSTRAINT-SOLVER/DELETE-CPLUS-PLUS-INSTANCE (ff-pointer self) arg1 arg2))

(shadow "new[]")
(defmethod NEW[] ((self SEQUENTIAL-IMPULSE-CONSTRAINT-SOLVER) sizeInBytes)
  (SEQUENTIAL-IMPULSE-CONSTRAINT-SOLVER/MAKE-CPLUS-ARRAY (ff-pointer self) sizeInBytes))

(shadow "delete[]")
(defmethod DELETE[] ((self SEQUENTIAL-IMPULSE-CONSTRAINT-SOLVER) ptr)
  (SEQUENTIAL-IMPULSE-CONSTRAINT-SOLVER/DELETE-CPLUS-ARRAY (ff-pointer self) ptr))

(shadow "new[]")
(defmethod NEW[] ((self SEQUENTIAL-IMPULSE-CONSTRAINT-SOLVER) arg1 ptr)
  (SEQUENTIAL-IMPULSE-CONSTRAINT-SOLVER/MAKE-CPLUS-ARRAY (ff-pointer self) arg1 ptr))

(shadow "delete[]")
(defmethod DELETE[] ((self SEQUENTIAL-IMPULSE-CONSTRAINT-SOLVER) arg1 arg2)
  (SEQUENTIAL-IMPULSE-CONSTRAINT-SOLVER/DELETE-CPLUS-ARRAY (ff-pointer self) arg1 arg2))

(defmethod initialize-instance :after ((obj SEQUENTIAL-IMPULSE-CONSTRAINT-SOLVER) &key)
  (setf (slot-value obj 'ff-pointer) (MAKE-SEQUENTIAL-IMPULSE-CONSTRAINT-SOLVER)))

(defmethod SOLVE-GROUP ((self SEQUENTIAL-IMPULSE-CONSTRAINT-SOLVER) bodies (numBodies integer) manifold (numManifolds integer) constraints (numConstraints integer) info (debugDrawer IDEBUG-DRAW) dispatcher)
  (SEQUENTIAL-IMPULSE-CONSTRAINT-SOLVER/SOLVE-GROUP (ff-pointer self) bodies numBodies manifold numManifolds constraints numConstraints info debugDrawer dispatcher))

(defmethod RESET ((self SEQUENTIAL-IMPULSE-CONSTRAINT-SOLVER))
  (SEQUENTIAL-IMPULSE-CONSTRAINT-SOLVER/RESET (ff-pointer self)))

(defmethod RAND-2 ((self SEQUENTIAL-IMPULSE-CONSTRAINT-SOLVER))
  (SEQUENTIAL-IMPULSE-CONSTRAINT-SOLVER/BT-RAND-2 (ff-pointer self)))

(defmethod RAND-INT-2 ((self SEQUENTIAL-IMPULSE-CONSTRAINT-SOLVER) (n integer))
  (SEQUENTIAL-IMPULSE-CONSTRAINT-SOLVER/BT-RAND-INT-2 (ff-pointer self) n))

(defmethod (SETF RAND-SEED) ((self SEQUENTIAL-IMPULSE-CONSTRAINT-SOLVER) (seed integer))
  (SEQUENTIAL-IMPULSE-CONSTRAINT-SOLVER/SET-RAND-SEED (ff-pointer self) seed))

(defmethod RAND-SEED ((self SEQUENTIAL-IMPULSE-CONSTRAINT-SOLVER))
  (SEQUENTIAL-IMPULSE-CONSTRAINT-SOLVER/GET-RAND-SEED (ff-pointer self)))

(defmethod SOLVER-TYPE ((self SEQUENTIAL-IMPULSE-CONSTRAINT-SOLVER))
  (SEQUENTIAL-IMPULSE-CONSTRAINT-SOLVER/GET-SOLVER-TYPE (ff-pointer self)))

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

