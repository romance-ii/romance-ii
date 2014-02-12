(in-package #:bullet-physics)
(declaim (inline COLLISION-OBJECT/MERGES-SIMULATION-ISLANDS))
(cffi:defcfun ("_wrap_btCollisionObject_mergesSimulationIslands" 
               COLLISION-OBJECT/MERGES-SIMULATION-ISLANDS) :pointer
  (self :pointer))
(declaim (inline COLLISION-OBJECT/GET-ANISOTROPIC-FRICTION))
(cffi:defcfun ("_wrap_btCollisionObject_getAnisotropicFriction" 
               COLLISION-OBJECT/GET-ANISOTROPIC-FRICTION) :pointer
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
(cffi:defcfun ("_wrap_btCollisionObject_setContactProcessingThreshold" 
               COLLISION-OBJECT/SET-CONTACT-PROCESSING-THRESHOLD) :void
  (self :pointer)
  (contactProcessingThreshold :float))
(declaim (inline COLLISION-OBJECT/GET-CONTACT-PROCESSING-THRESHOLD))
(cffi:defcfun ("_wrap_btCollisionObject_getContactProcessingThreshold" 
               COLLISION-OBJECT/GET-CONTACT-PROCESSING-THRESHOLD) :float
  (self :pointer))
(declaim (inline COLLISION-OBJECT/IS-STATIC-OBJECT))
(cffi:defcfun ("_wrap_btCollisionObject_isStaticObject" 
               COLLISION-OBJECT/IS-STATIC-OBJECT) :pointer
  (self :pointer))
(declaim (inline COLLISION-OBJECT/IS-KINEMATIC-OBJECT))
(cffi:defcfun ("_wrap_btCollisionObject_isKinematicObject" 
               COLLISION-OBJECT/IS-KINEMATIC-OBJECT) :pointer
  (self :pointer))
(declaim (inline COLLISION-OBJECT/IS-STATIC-OR-KINEMATIC-OBJECT))
(cffi:defcfun ("_wrap_btCollisionObject_isStaticOrKinematicObject" BULLET> ) :pointer
  (self :pointer))
(declaim (inline COLLISION-OBJECT/IS-STATIC-OR-KINEMATIC-OBJECT))
(cffi:defcfun ("_wrap_btCollisionObject_hasContactResponse" 
               COLLISION-OBJECT/HAS-CONTACT-RESPONSE) :pointer
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
(cffi:defcfun ("_wrap_btCollisionObject_getCollisionShape__SWIG_0" 
               COLLISION-OBJECT/GET-COLLISION-SHAPE) :pointer
  (self :pointer))
#+ (or)
(progn 
  (declaim (inline COLLISION-OBJECT/GET-COLLISION-SHAPE))
  (cffi:defcfun ("_wrap_btCollisionObject_getCollisionShape__SWIG_1" 
                 COLLISION-OBJECT/GET-COLLISION-SHAPE) :pointer
    (self :pointer))
  )
(declaim (inline COLLISION-OBJECT/INTERNAL-GET-EXTENSION-POINTER))
(cffi:defcfun ("_wrap_btCollisionObject_internalGetExtensionPointer" 
               COLLISION-OBJECT/INTERNAL-GET-EXTENSION-POINTER) :pointer
  (self :pointer))
(declaim (inline COLLISION-OBJECT/INTERNAL-SET-EXTENSION-POINTER))
(cffi:defcfun ("_wrap_btCollisionObject_internalSetExtensionPointer" 
               COLLISION-OBJECT/INTERNAL-SET-EXTENSION-POINTER) :void
  (self :pointer)
  (pointer :pointer))
(declaim (inline COLLISION-OBJECT/GET-ACTIVATION-STATE))
(cffi:defcfun ("_wrap_btCollisionObject_getActivationState" 
               COLLISION-OBJECT/GET-ACTIVATION-STATE) :int
  (self :pointer))
(declaim (inline COLLISION-OBJECT/SET-ACTIVATION-STATE))
(cffi:defcfun ("_wrap_btCollisionObject_setActivationState" 
               COLLISION-OBJECT/SET-ACTIVATION-STATE) :void
  (self :pointer)
  (newState :int))
(declaim (inline COLLISION-OBJECT/SET-DEACTIVATION-TIME))
(cffi:defcfun ("_wrap_btCollisionObject_setDeactivationTime" 
               COLLISION-OBJECT/SET-DEACTIVATION-TIME) :void
  (self :pointer)
  (time :float))
(declaim (inline COLLISION-OBJECT/GET-DEACTIVATION-TIME))
(cffi:defcfun ("_wrap_btCollisionObject_getDeactivationTime" 
               COLLISION-OBJECT/GET-DEACTIVATION-TIME) :float
  (self :pointer))
(declaim (inline COLLISION-OBJECT/FORCE-ACTIVATION-STATE))
(cffi:defcfun ("_wrap_btCollisionObject_forceActivationState" 
               COLLISION-OBJECT/FORCE-ACTIVATION-STATE) :void
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
(cffi:defcfun ("_wrap_btCollisionObject_setRestitution" 
               COLLISION-OBJECT/SET-RESTITUTION) :void
  (self :pointer)
  (rest :float))
(declaim (inline COLLISION-OBJECT/GET-RESTITUTION))
(cffi:defcfun ("_wrap_btCollisionObject_getRestitution" 
               COLLISION-OBJECT/GET-RESTITUTION) :float
  (self :pointer))
(declaim (inline COLLISION-OBJECT/SET-FRICTION))
(cffi:defcfun ("_wrap_btCollisionObject_setFriction" 
               COLLISION-OBJECT/SET-FRICTION) :void
  (self :pointer)
  (frict :float))
(declaim (inline COLLISION-OBJECT/GET-FRICTION))
(cffi:defcfun ("_wrap_btCollisionObject_getFriction" 
               COLLISION-OBJECT/GET-FRICTION) :float
  (self :pointer))
(declaim (inline COLLISION-OBJECT/SET-ROLLING-FRICTION))
(cffi:defcfun ("_wrap_btCollisionObject_setRollingFriction" 
               COLLISION-OBJECT/SET-ROLLING-FRICTION) :void
  (self :pointer)
  (frict :float))
(declaim (inline COLLISION-OBJECT/GET-ROLLING-FRICTION))
(cffi:defcfun ("_wrap_btCollisionObject_getRollingFriction" 
               COLLISION-OBJECT/GET-ROLLING-FRICTION) :float
  (self :pointer))
(declaim (inline COLLISION-OBJECT/GET-INTERNAL-TYPE))
(cffi:defcfun ("_wrap_btCollisionObject_getInternalType" 
               COLLISION-OBJECT/GET-INTERNAL-TYPE) :int
  (self :pointer))
(declaim (inline COLLISION-OBJECT/GET-WORLD-TRANSFORM))
(cffi:defcfun ("_wrap_btCollisionObject_getWorldTransform__SWIG_0" 
               COLLISION-OBJECT/GET-WORLD-TRANSFORM) :pointer
  (self :pointer))
#+ (or)
(progn
  (declaim (inline COLLISION-OBJECT/GET-WORLD-TRANSFORM))
  (cffi:defcfun ("_wrap_btCollisionObject_getWorldTransform__SWIG_1" 
                 COLLISION-OBJECT/GET-WORLD-TRANSFORM) :pointer
    (self :pointer))
  )
(declaim (inline COLLISION-OBJECT/SET-WORLD-TRANSFORM))
(cffi:defcfun ("_wrap_btCollisionObject_setWorldTransform" 
               COLLISION-OBJECT/SET-WORLD-TRANSFORM) :void
  (self :pointer)
  (worldTrans :pointer))
(declaim (inline COLLISION-OBJECT/GET-BROADPHASE-HANDLE))
(cffi:defcfun ("_wrap_btCollisionObject_getBroadphaseHandle__SWIG_0" 
               COLLISION-OBJECT/GET-BROADPHASE-HANDLE) :pointer
  (self :pointer))
#+ (or)
(progn 
  (declaim (inline COLLISION-OBJECT/GET-BROADPHASE-HANDLE))
  (cffi:defcfun ("_wrap_btCollisionObject_getBroadphaseHandle__SWIG_1" 
                 COLLISION-OBJECT/GET-BROADPHASE-HANDLE) :pointer
    (self :pointer))
  )
(declaim (inline COLLISION-OBJECT/SET-BROADPHASE-HANDLE))
(cffi:defcfun ("_wrap_btCollisionObject_setBroadphaseHandle" 
               COLLISION-OBJECT/SET-BROADPHASE-HANDLE) :void
  (self :pointer)
  (handle :pointer))
(declaim (inline COLLISION-OBJECT/GET-INTERPOLATION-WORLD-TRANSFORM))
(cffi:defcfun ("_wrap_btCollisionObject_getInterpolationWorldTransform__SWIG_0" 
               COLLISION-OBJECT/GET-INTERPOLATION-WORLD-TRANSFORM) :pointer
  (self :pointer))
#+ (or)
(progn 
  (declaim (inline COLLISION-OBJECT/GET-INTERPOLATION-WORLD-TRANSFORM))
  (cffi:defcfun ("_wrap_btCollisionObject_getInterpolationWorldTransform__SWIG_1" 
                 COLLISION-OBJECT/GET-INTERPOLATION-WORLD-TRANSFORM) :pointer
    (self :pointer))
  )
(declaim (inline COLLISION-OBJECT/SET-INTERPOLATION-WORLD-TRANSFORM))
(cffi:defcfun ("_wrap_btCollisionObject_setInterpolationWorldTransform" 
               COLLISION-OBJECT/SET-INTERPOLATION-WORLD-TRANSFORM) :void
  (self :pointer)
  (trans :pointer))
(declaim (inline COLLISION-OBJECT/SET-INTERPOLATION-LINEAR-VELOCITY))
(cffi:defcfun ("_wrap_btCollisionObject_setInterpolationLinearVelocity" 
               COLLISION-OBJECT/SET-INTERPOLATION-LINEAR-VELOCITY) :void
  (self :pointer)
  (linvel :pointer))
(declaim (inline COLLISION-OBJECT/SET-INTERPOLATION-ANGULAR-VELOCITY))
(cffi:defcfun ("_wrap_btCollisionObject_setInterpolationAngularVelocity" 
               COLLISION-OBJECT/SET-INTERPOLATION-ANGULAR-VELOCITY) :void
  (self :pointer)
  (angvel :pointer))
(declaim (inline COLLISION-OBJECT/GET-INTERPOLATION-LINEAR-VELOCITY))
(cffi:defcfun ("_wrap_btCollisionObject_getInterpolationLinearVelocity" 
               COLLISION-OBJECT/GET-INTERPOLATION-LINEAR-VELOCITY) :pointer
  (self :pointer))
(declaim (inline COLLISION-OBJECT/GET-INTERPOLATION-ANGULAR-VELOCITY))
(cffi:defcfun ("_wrap_btCollisionObject_getInterpolationAngularVelocity" 
               COLLISION-OBJECT/GET-INTERPOLATION-ANGULAR-VELOCITY) :pointer
  (self :pointer))
(declaim (inline COLLISION-OBJECT/GET-ISLAND-TAG))
(cffi:defcfun ("_wrap_btCollisionObject_getIslandTag" 
               COLLISION-OBJECT/GET-ISLAND-TAG) :int
  (self :pointer))
(declaim (inline COLLISION-OBJECT/SET-ISLAND-TAG))
(cffi:defcfun ("_wrap_btCollisionObject_setIslandTag" 
               COLLISION-OBJECT/SET-ISLAND-TAG) :void
  (self :pointer)
  (tag :int))
(declaim (inline COLLISION-OBJECT/GET-COMPANION-ID))
(cffi:defcfun ("_wrap_btCollisionObject_getCompanionId" 
               COLLISION-OBJECT/GET-COMPANION-ID) :int
  (self :pointer))
(declaim (inline COLLISION-OBJECT/SET-COMPANION-ID))
(cffi:defcfun ("_wrap_btCollisionObject_setCompanionId" 
               COLLISION-OBJECT/SET-COMPANION-ID) :void
  (self :pointer)
  (id :int))
(declaim (inline COLLISION-OBJECT/GET-HIT-FRACTION))
(cffi:defcfun ("_wrap_btCollisionObject_getHitFraction"
               cOLLISION-OBJECT/GET-HIT-FRACTION) :float
  (self :pointer))
(declaim (inline COLLISION-OBJECT/SET-HIT-FRACTION))
(cffi:defcfun ("_wrap_btCollisionObject_setHitFraction"
               cOLLISION-OBJECT/SET-HIT-FRACTION) :void
  (self :pointer)
  (hitFraction :float))
(declaim (inline COLLISION-OBJECT/GET-COLLISION-FLAGS))
(cffi:defcfun ("_wrap_btCollisionObject_getCollisionFlags"
               cOLLISION-OBJECT/GET-COLLISION-FLAGS) :int
  (self :pointer))
(declaim (inline COLLISION-OBJECT/SET-COLLISION-FLAGS))
(cffi:defcfun ("_wrap_btCollisionObject_setCollisionFlags"
               cOLLISION-OBJECT/SET-COLLISION-FLAGS) :void
  (self :pointer)
  (flags :int))
(declaim (inline COLLISION-OBJECT/GET-CCD-SWEPT-SPHERE-RADIUS))
(cffi:defcfun ("_wrap_btCollisionObject_getCcdSweptSphereRadius"
               cOLLISION-OBJECT/GET-CCD-SWEPT-SPHERE-RADIUS) :float
  (self :pointer))
(declaim (inline COLLISION-OBJECT/SET-CCD-SWEPT-SPHERE-RADIUS))
(cffi:defcfun ("_wrap_btCollisionObject_setCcdSweptSphereRadius"
               cOLLISION-OBJECT/SET-CCD-SWEPT-SPHERE-RADIUS) :void
  (self :pointer)
  (radius :float))
(declaim (inline COLLISION-OBJECT/GET-CCD-MOTION-THRESHOLD))
(cffi:defcfun ("_wrap_btCollisionObject_getCcdMotionThreshold"
               cOLLISION-OBJECT/GET-CCD-MOTION-THRESHOLD) :float
  (self :pointer))
(declaim (inline COLLISION-OBJECT/GET-CCD-SQUARE-MOTION-THRESHOLD))
(cffi:defcfun ("_wrap_btCollisionObject_getCcdSquareMotionThreshold"
               cOLLISION-OBJECT/GET-CCD-SQUARE-MOTION-THRESHOLD) :float
  (self :pointer))
(declaim (inline COLLISION-OBJECT/SET-CCD-MOTION-THRESHOLD))
(cffi:defcfun ("_wrap_btCollisionObject_setCcdMotionThreshold"
               cOLLISION-OBJECT/SET-CCD-MOTION-THRESHOLD) :void
  (self :pointer)
  (ccdMotionThreshold :float))
(declaim (inline COLLISION-OBJECT/GET-USER-POINTER))
(cffi:defcfun ("_wrap_btCollisionObject_getUserPointer"
               cOLLISION-OBJECT/GET-USER-POINTER) :pointer
  (self :pointer))
(declaim (inline COLLISION-OBJECT/GET-USER-INDEX))
(cffi:defcfun ("_wrap_btCollisionObject_getUserIndex"
               cOLLISION-OBJECT/GET-USER-INDEX) :int
  (self :pointer))
(declaim (inline COLLISION-OBJECT/SET-USER-POINTER))
(cffi:defcfun ("_wrap_btCollisionObject_setUserPointer"
               cOLLISION-OBJECT/SET-USER-POINTER) :void
  (self :pointer)
  (userPointer :pointer))
(declaim (inline COLLISION-OBJECT/SET-USER-INDEX))
(cffi:defcfun ("_wrap_btCollisionObject_setUserIndex"
               cOLLISION-OBJECT/SET-USER-INDEX) :void
  (self :pointer)
  (index :int))
(declaim (inline COLLISION-OBJECT/GET-UPDATE-REVISION-INTERNAL))
(cffi:defcfun ("_wrap_btCollisionObject_getUpdateRevisionInternal"
               cOLLISION-OBJECT/GET-UPDATE-REVISION-INTERNAL) :int
  (self :pointer))
(declaim (inline COLLISION-OBJECT/CHECK-COLLIDE-WITH))
(cffi:defcfun ("_wrap_btCollisionObject_checkCollideWith"
               cOLLISION-OBJECT/CHECK-COLLIDE-WITH) :pointer
  (self :pointer)
  (co :pointer))
(declaim (inline COLLISION-OBJECT/CALCULATE-SERIALIZE-BUFFER-SIZE))
(cffi:defcfun ("_wrap_btCollisionObject_calculateSerializeBufferSize"
               cOLLISION-OBJECT/CALCULATE-SERIALIZE-BUFFER-SIZE) :int
  (self :pointer))
(declaim (inline COLLISION-OBJECT/SERIALIZE))
(cffi:defcfun ("_wrap_btCollisionObject_serialize"
               cOLLISION-OBJECT/SERIALIZE) :string
  (self :pointer)
  (dataBuffer :pointer)
  (serializer :pointer))
(declaim (inline COLLISION-OBJECT/SERIALIZE-SINGLE-OBJECT))
(cffi:defcfun ("_wrap_btCollisionObject_serializeSingleObject"
               cOLLISION-OBJECT/SERIALIZE-SINGLE-OBJECT) :void
  (self :pointer)
  (serializer :pointer))


(defmethod MERGES-SIMULATION-ISLANDS ((self COLLISION-OBJECT))
  (COLLISION-OBJECT/MERGES-SIMULATION-ISLANDS (ff-pointer self)))
(defmethod ANISOTROPIC-FRICTION ((self COLLISION-OBJECT))
  (COLLISION-OBJECT/GET-ANISOTROPIC-FRICTION (ff-pointer self)))
(defmethod (setf anisotropic-friction) ((friction cons) (self collision-object))
  (destructuring-bind (anisotropicfriction friction-mode) friction
   (check-type friction-mode (or null integer))
   (if friction-mode
       (collision-object/set-anisotropic-friction/with-mode
        (ff-pointer self) anisotropicfriction friction-mode)
       (collision-object/set-anisotropic-friction/without-mode
        (ff-pointer self) anisotropicfriction))))
(defmethod HAS-ANISOTROPIC-FRICTION-P
    ((self COLLISION-OBJECT) (frictionMode integer))
  (COLLISION-OBJECT/HAS-ANISOTROPIC-FRICTION/WITH-MODE
   (ff-pointer self) frictionMode))
(defmethod HAS-ANISOTROPIC-FRICTION-P
    ((self COLLISION-OBJECT) (friction-mode null))
  (COLLISION-OBJECT/HAS-ANISOTROPIC-FRICTION/WITHOUT-MODE
   (ff-pointer self)))
(defmethod (SETF CONTACT-PROCESSING-THRESHOLD)
    (
     (contactProcessingThreshold number) (self COLLISION-OBJECT))
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
(defmethod (SETF COLLISION-SHAPE) ( collisionShape (self COLLISION-OBJECT))
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
(defmethod (SETF ACTIVATION-STATE) ( (newState integer) (self COLLISION-OBJECT))
  (COLLISION-OBJECT/SET-ACTIVATION-STATE (ff-pointer self) newState))
(defmethod (SETF DEACTIVATION-TIME) ( (time number) (self COLLISION-OBJECT))
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
(defmethod (SETF RESTITUTION) ( (rest number) (self COLLISION-OBJECT))
  (COLLISION-OBJECT/SET-RESTITUTION (ff-pointer self) rest))
(defmethod RESTITUTION ((self COLLISION-OBJECT))
  (COLLISION-OBJECT/GET-RESTITUTION (ff-pointer self)))
(defmethod (SETF FRICTION) ( (frict number) (self COLLISION-OBJECT))
  (COLLISION-OBJECT/SET-FRICTION (ff-pointer self) frict))
(defmethod FRICTION ((self COLLISION-OBJECT))
  (COLLISION-OBJECT/GET-FRICTION (ff-pointer self)))
(defmethod (SETF ROLLING-FRICTION) ( (frict number) (self COLLISION-OBJECT))
  (COLLISION-OBJECT/SET-ROLLING-FRICTION (ff-pointer self) frict))
(defmethod ROLLING-FRICTION ((self COLLISION-OBJECT))
  (COLLISION-OBJECT/GET-ROLLING-FRICTION (ff-pointer self)))
(defmethod INTERNAL-TYPE ((self COLLISION-OBJECT))
  (COLLISION-OBJECT/GET-INTERNAL-TYPE (ff-pointer self)))
(defmethod WORLD-TRANSFORM ((self COLLISION-OBJECT))
  (COLLISION-OBJECT/GET-WORLD-TRANSFORM (ff-pointer self)))
(defmethod WORLD-TRANSFORM ((self COLLISION-OBJECT))
  (COLLISION-OBJECT/GET-WORLD-TRANSFORM (ff-pointer self)))
(defmethod (SETF WORLD-TRANSFORM) ( worldTrans (self COLLISION-OBJECT))
  (COLLISION-OBJECT/SET-WORLD-TRANSFORM (ff-pointer self) worldTrans))
(defmethod GET-BROADPHASE-HANDLE ((self COLLISION-OBJECT))
  (COLLISION-OBJECT/GET-BROADPHASE-HANDLE (ff-pointer self)))
(defmethod (SETF BROADPHASE-HANDLE) ( handle (self COLLISION-OBJECT))
  (COLLISION-OBJECT/SET-BROADPHASE-HANDLE (ff-pointer self) handle))
(defmethod INTERPOLATION-WORLD-TRANSFORM ((self COLLISION-OBJECT))
  (COLLISION-OBJECT/GET-INTERPOLATION-WORLD-TRANSFORM (ff-pointer self)))
(defmethod INTERPOLATION-WORLD-TRANSFORM ((self COLLISION-OBJECT))
  (COLLISION-OBJECT/GET-INTERPOLATION-WORLD-TRANSFORM (ff-pointer self)))
(defmethod (SETF INTERPOLATION-WORLD-TRANSFORM) ( trans (self COLLISION-OBJECT))
  (COLLISION-OBJECT/SET-INTERPOLATION-WORLD-TRANSFORM (ff-pointer self) trans))
(defmethod (SETF INTERPOLATION-LINEAR-VELOCITY) ( linvel (self COLLISION-OBJECT))
  (COLLISION-OBJECT/SET-INTERPOLATION-LINEAR-VELOCITY (ff-pointer self) linvel))
(defmethod (SETF INTERPOLATION-ANGULAR-VELOCITY) ( angvel (self COLLISION-OBJECT))
  (COLLISION-OBJECT/SET-INTERPOLATION-ANGULAR-VELOCITY (ff-pointer self) angvel))
(defmethod INTERPOLATION-LINEAR-VELOCITY ((self COLLISION-OBJECT))
  (COLLISION-OBJECT/GET-INTERPOLATION-LINEAR-VELOCITY (ff-pointer self)))
(defmethod INTERPOLATION-ANGULAR-VELOCITY ((self COLLISION-OBJECT))
  (COLLISION-OBJECT/GET-INTERPOLATION-ANGULAR-VELOCITY (ff-pointer self)))
(defmethod ISLAND-TAG ((self COLLISION-OBJECT))
  (COLLISION-OBJECT/GET-ISLAND-TAG (ff-pointer self)))
(defmethod (SETF ISLAND-TAG) ( (tag integer) (self COLLISION-OBJECT))
  (COLLISION-OBJECT/SET-ISLAND-TAG (ff-pointer self) tag))
(defmethod COMPANION-ID ((self COLLISION-OBJECT))
  (COLLISION-OBJECT/GET-COMPANION-ID (ff-pointer self)))
(defmethod (SETF COMPANION-ID) ( (id integer) (self COLLISION-OBJECT))
  (COLLISION-OBJECT/SET-COMPANION-ID (ff-pointer self) id))
(defmethod HIT-FRACTION ((self COLLISION-OBJECT))
  (COLLISION-OBJECT/GET-HIT-FRACTION (ff-pointer self)))
(defmethod (SETF HIT-FRACTION) ( (hitFraction number) (self COLLISION-OBJECT))
  (COLLISION-OBJECT/SET-HIT-FRACTION (ff-pointer self) hitFraction))
(defmethod COLLISION-FLAGS ((self COLLISION-OBJECT))
  (COLLISION-OBJECT/GET-COLLISION-FLAGS (ff-pointer self)))
(defmethod (SETF COLLISION-FLAGS) ( (flags integer) (self COLLISION-OBJECT))
  (COLLISION-OBJECT/SET-COLLISION-FLAGS (ff-pointer self) flags))
(defmethod CCD-SWEPT-SPHERE-RADIUS ((self COLLISION-OBJECT))
  (COLLISION-OBJECT/GET-CCD-SWEPT-SPHERE-RADIUS (ff-pointer self)))
(defmethod (SETF CCD-SWEPT-SPHERE-RADIUS) ( (radius number) (self COLLISION-OBJECT))
  (COLLISION-OBJECT/SET-CCD-SWEPT-SPHERE-RADIUS (ff-pointer self) radius))
(defmethod CCD-MOTION-THRESHOLD ((self COLLISION-OBJECT))
  (COLLISION-OBJECT/GET-CCD-MOTION-THRESHOLD (ff-pointer self)))
(defmethod CCD-SQUARE-MOTION-THRESHOLD ((self COLLISION-OBJECT))
  (COLLISION-OBJECT/GET-CCD-SQUARE-MOTION-THRESHOLD (ff-pointer self)))
(defmethod (SETF CCD-MOTION-THRESHOLD) ( (ccdMotionThreshold number) (self COLLISION-OBJECT))
  (COLLISION-OBJECT/SET-CCD-MOTION-THRESHOLD (ff-pointer self) ccdMotionThreshold))
(defmethod USER-POINTER ((self COLLISION-OBJECT))
  (COLLISION-OBJECT/GET-USER-POINTER (ff-pointer self)))
(defmethod USER-INDEX ((self COLLISION-OBJECT))
  (COLLISION-OBJECT/GET-USER-INDEX (ff-pointer self)))
(defmethod (SETF USER-POINTER) ( userPointer (self COLLISION-OBJECT))
  (COLLISION-OBJECT/SET-USER-POINTER (ff-pointer self) userPointer))
(defmethod (SETF USER-INDEX) ( (index integer) (self COLLISION-OBJECT))
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

(cffi:defcenum COLLISION-OBJECT-TYPES
  (:COLLISION-OBJECT 1)
  (:RIGID-BODY 2)
  (:GHOST-OBJECT 4)
  (:SOFT-BODY 8)
  (:HF-FLUID 16)
  (:USER-TYPE #.32)
  (:FEATHERSTONE-LINK #.64))
(define-constant +COLLISION-OBJECT-DATA-NAME+ "btCollisionObjectFloatData"  :test 'equal)
(cffi:defcfun ("_wrap_btCollisionObject_makeCPlusPlusInstance__SWIG_0"
               COLLISION-OBJECT/MAKE-C++-INSTANCE) :pointer
  (self :pointer)
  (sizeInBytes :pointer))
(cffi:defcfun ("_wrap_btCollisionObject_deleteCPlusPlusInstance__SWIG_0"
               COLLISION-OBJECT/DELETE-C++-INSTANCE) :void
  (self :pointer)
  (ptr :pointer))
(cffi:defcfun ("_wrap_btCollisionObject_makeCPlusArray__SWIG_0"
               COLLISION-OBJECT/MAKE-C++-ARRAY) :pointer
  (self :pointer)
  (sizeInBytes :pointer))

(cffi:defcfun ("_wrap_btCollisionObject_deleteCPlusArray__SWIG_0"
               COLLISION-OBJECT/DELETE-C++-ARRAY) :void
  (self :pointer)
  (ptr :pointer))

