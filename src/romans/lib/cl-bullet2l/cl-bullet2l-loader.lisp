
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

(cl:defmethod #.(bullet-wrap::swig-lispify "debug-draw-object" 'method) ((self #.(bullet-wrap::swig-lispify "bt-collision-world" 'classname)) worldTransform shape color)
  (#.(bullet-wrap::swig-lispify "btCollisionWorld_debugDrawObject" 'function) (ff-pointer self) worldTransform shape color))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-num-collision-objects" 'method) ((self #.(bullet-wrap::swig-lispify "bt-collision-world" 'classname)))
  (#.(bullet-wrap::swig-lispify "btCollisionWorld_getNumCollisionObjects" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "ray-test" 'method) ((self #.(bullet-wrap::swig-lispify "bt-collision-world" 'classname)) rayFromWorld rayToWorld resultCallback)
  (#.(bullet-wrap::swig-lispify "btCollisionWorld_rayTest" 'function) (ff-pointer self) rayFromWorld rayToWorld resultCallback))

(cl:defmethod #.(bullet-wrap::swig-lispify "convex-sweep-test" 'method) ((self #.(bullet-wrap::swig-lispify "bt-collision-world" 'classname)) castShape from to resultCallback (allowedCcdPenetration cl:number))
  (#.(bullet-wrap::swig-lispify "btCollisionWorld_convexSweepTest" 'function) (ff-pointer self) castShape from to resultCallback allowedCcdPenetration))

(cl:defmethod #.(bullet-wrap::swig-lispify "convex-sweep-test" 'method) ((self #.(bullet-wrap::swig-lispify "bt-collision-world" 'classname)) castShape from to resultCallback)
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

(cl:defmethod #.(bullet-wrap::swig-lispify "merges-simulation-islands" 'method) ((self #.(bullet-wrap::swig-lispify "bt-collision-object" 'classname)))
  (#.(bullet-wrap::swig-lispify "btCollisionObject_mergesSimulationIslands" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "get-anisotropic-friction" 'method) ((self #.(bullet-wrap::swig-lispify "bt-collision-object" 'classname)))
  (#.(bullet-wrap::swig-lispify "btCollisionObject_getAnisotropicFriction" 'function) (ff-pointer self)))

(cl:defmethod #.(bullet-wrap::swig-lispify "set-anisotropic-friction" 'method) ((self #.(bullet-wrap::swig-lispify "bt-collision-object" 'classname)) anisotropicFriction (frictionMode cl:integer))
  (#.(bullet-wrap::swig-lispify "btCollisionObject_setAnisotropicFriction" 'function) (ff-pointer self) anisotropicFriction frictionMode))

(cl:defmethod #.(bullet-wrap::swig-lispify "set-anisotropic-friction" 'method) ((self #.(bullet-wrap::swig-lispify "bt-collision-object" 'classname)) anisotropicFriction)
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

(cl:defmethod #.(bullet-wrap::swig-lispify "set-world-transform" 'method) ((self #.(bullet-wrap::swig-lispify "bt-collision-object" 'classname)) worldTrans)
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

(cl:defmethod #.(bullet-wrap::swig-lispify "set-interpolation-world-transform" 'method) ((self #.(bullet-wrap::swig-lispify "bt-collision-object" 'classname)) trans)
  (#.(bullet-wrap::swig-lispify "btCollisionObject_setInterpolationWorldTransform" 'function) (ff-pointer self) trans))

(cl:defmethod #.(bullet-wrap::swig-lispify "set-interpolation-linear-velocity" 'method) ((self #.(bullet-wrap::swig-lispify "bt-collision-object" 'classname)) linvel)
  (#.(bullet-wrap::swig-lispify "btCollisionObject_setInterpolationLinearVelocity" 'function) (ff-pointer self) linvel))

(cl:defmethod #.(bullet-wrap::swig-lispify "set-interpolation-angular-velocity" 'method) ((self #.(bullet-wrap::swig-lispify "bt-collision-object" 'classname)) angvel)
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


(cl:defclass #.(bullet-wrap::swig-lispify "bt-discrete-dynamics-world" 'classname)()
  ((ff-pointer :reader ff-pointer)))

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

(cl:defmethod #.(bullet-wrap::swig-lispify "set-gravity" 'method) ((self #.(bullet-wrap::swig-lispify "bt-discrete-dynamics-world" 'classname)) gravity)
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

(cl:defmethod #.(bullet-wrap::swig-lispify "serialize" 'method) ((self #.(bullet-wrap::swig-lispify "bt-discrete-dynamics-world" 'classname)) serializer)
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

(cl:defmethod #.(bullet-wrap::swig-lispify "set-gravity" 'method) ((self #.(bullet-wrap::swig-lispify "bt-simple-dynamics-world" 'classname)) gravity)
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

