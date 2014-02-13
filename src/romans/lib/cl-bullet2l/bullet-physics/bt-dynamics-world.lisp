(in-package :bullet-physics)

(declaim (inline MAKE-DISCRETE-DYNAMICS-WORLD))

(cffi:defcfun ("_wrap_new_btDiscreteDynamicsWorld"
               MAKE-DISCRETE-DYNAMICS-WORLD) :pointer
  (dispatcher :pointer)
  (pairCache :pointer)
  (constraint-Solver :pointer)
  (collision-Configuration :pointer))

(declaim (inline DISCRETE-DYNAMICS-WORLD/STEP-SIMULATION))

(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_stepSimulation__SWIG_0"
               DISCRETE-DYNAMICS-WORLD/STEP-SIMULATION) :int
  (self :pointer)
  (timeStep :float)
  (maxSubSteps :int)
  (fixedTimeStep :float))
#+ (or)

(progn
  (declaim (inline DISCRETE-DYNAMICS-WORLD/STEP-SIMULATION))
  (cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_stepSimulation__SWIG_1"
                 DISCRETE-DYNAMICS-WORLD/STEP-SIMULATION) :int
    (self :pointer)
    (timeStep :float)
    (maxSubSteps :int))

  (declaim (inline DISCRETE-DYNAMICS-WORLD/STEP-SIMULATION))
  (cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_stepSimulation__SWIG_2"
                 DISCRETE-DYNAMICS-WORLD/STEP-SIMULATION) :int
    (self :pointer)
    (timeStep :float))
  )

(declaim (inline DISCRETE-DYNAMICS-WORLD/SYNCHRONIZE-MOTION-STATES))

(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_synchronizeMotionStates"
               DISCRETE-DYNAMICS-WORLD/SYNCHRONIZE-MOTION-STATES) :void
  (self :pointer))

(declaim (inline DISCRETE-DYNAMICS-WORLD/ADD-CONSTRAINT))

(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_addConstraint__SWIG_0"
               DISCRETE-DYNAMICS-WORLD/ADD-CONSTRAINT/with-disable-collisions-between-linked-bodies)
    :void
  (self :pointer)
  (constraint :pointer)
  (disableCollisionsBetweenLinkedBodies :pointer))

(declaim (inline DISCRETE-DYNAMICS-WORLD/ADD-CONSTRAINT))
  (cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_addConstraint__SWIG_1"
                 DISCRETE-DYNAMICS-WORLD/ADD-CONSTRAINT) :void
    (self :pointer)
    (constraint :pointer))

(declaim (inline DISCRETE-DYNAMICS-WORLD/REMOVE-CONSTRAINT))

(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_removeConstraint"
               DISCRETE-DYNAMICS-WORLD/REMOVE-CONSTRAINT) :void
  (self :pointer)
  (constraint :pointer))

(declaim (inline DISCRETE-DYNAMICS-WORLD/ADD-ACTION))

(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_addAction"
               DISCRETE-DYNAMICS-WORLD/ADD-ACTION) :void
  (self :pointer)
  (arg1 :pointer))

(declaim (inline DISCRETE-DYNAMICS-WORLD/REMOVE-ACTION))

(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_removeAction"
               DISCRETE-DYNAMICS-WORLD/REMOVE-ACTION) :void
  (self :pointer)
  (arg1 :pointer))

(declaim (inline DISCRETE-DYNAMICS-WORLD/GET-SIMULATION-ISLAND-MANAGER))

(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_getSimulationIslandManager__SWIG_0"
               DISCRETE-DYNAMICS-WORLD/GET-SIMULATION-ISLAND-MANAGER) :pointer
  (self :pointer))
#+ (or)

(progn
  (declaim (inline DISCRETE-DYNAMICS-WORLD/GET-SIMULATION-ISLAND-MANAGER))
  (cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_getSimulationIslandManager__SWIG_1"
                 DISCRETE-DYNAMICS-WORLD/GET-SIMULATION-ISLAND-MANAGER) :pointer
    (self :pointer))
  )

(declaim (inline DISCRETE-DYNAMICS-WORLD/GET-COLLISION-WORLD))

(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_getCollisionWorld"
               DISCRETE-DYNAMICS-WORLD/GET-COLLISION-WORLD) :pointer
  (self :pointer))

(declaim (inline DISCRETE-DYNAMICS-WORLD/SET-GRAVITY))

(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_setGravity"
               DISCRETE-DYNAMICS-WORLD/SET-GRAVITY) :void
  (self :pointer)
  (gravity :pointer))

(declaim (inline DISCRETE-DYNAMICS-WORLD/GET-GRAVITY))

(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_getGravity"
               DISCRETE-DYNAMICS-WORLD/GET-GRAVITY) :pointer
  (self :pointer))

(declaim (inline DISCRETE-DYNAMICS-WORLD/ADD-COLLISION-OBJECT))

(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_addCollisionObject__SWIG_0"
               DISCRETE-DYNAMICS-WORLD/ADD-COLLISION-OBJECT) :void
  (self :pointer)
  (collisionObject :pointer)
  (collisionFilterGroup :short)
  (collisionFilterMask :short))
#+ (or)

(progn
  (declaim (inline DISCRETE-DYNAMICS-WORLD/ADD-COLLISION-OBJECT))
  (cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_addCollisionObject__SWIG_1"
                 DISCRETE-DYNAMICS-WORLD/ADD-COLLISION-OBJECT) :void
    (self :pointer)
    (collisionObject :pointer)
    (collisionFilterGroup :short))

  (declaim (inline DISCRETE-DYNAMICS-WORLD/ADD-COLLISION-OBJECT))
  (cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_addCollisionObject__SWIG_2"
                 DISCRETE-DYNAMICS-WORLD/ADD-COLLISION-OBJECT) :void
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

(declaim (inline DISCRETE-DYNAMICS-WORLD/REMOVE-RIGID-BODY))

(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_removeRigidBody"
               DISCRETE-DYNAMICS-WORLD/REMOVE-RIGID-BODY) :void
  (self :pointer)
  (body :pointer))

(declaim (inline DISCRETE-DYNAMICS-WORLD/REMOVE-COLLISION-OBJECT))

(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_removeCollisionObject"
               DISCRETE-DYNAMICS-WORLD/REMOVE-COLLISION-OBJECT) :void
  (self :pointer)
  (collisionObject :pointer))

(declaim (inline DISCRETE-DYNAMICS-WORLD/DEBUG-DRAW-CONSTRAINT))

(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_debugDrawConstraint"
               DISCRETE-DYNAMICS-WORLD/DEBUG-DRAW-CONSTRAINT) :void
  (self :pointer)
  (constraint :pointer))

(declaim (inline DISCRETE-DYNAMICS-WORLD/DEBUG-DRAW-WORLD))

(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_debugDrawWorld"
               DISCRETE-DYNAMICS-WORLD/DEBUG-DRAW-WORLD) :void
  (self :pointer))

(declaim (inline DISCRETE-DYNAMICS-WORLD/SET-CONSTRAINT-SOLVER))

(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_setConstraintSolver"
               DISCRETE-DYNAMICS-WORLD/SET-CONSTRAINT-SOLVER) :void
  (self :pointer)
  (solver :pointer))

(declaim (inline DISCRETE-DYNAMICS-WORLD/GET-CONSTRAINT-SOLVER))

(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_getConstraintSolver"
               DISCRETE-DYNAMICS-WORLD/GET-CONSTRAINT-SOLVER) :pointer
  (self :pointer))

(declaim (inline DISCRETE-DYNAMICS-WORLD/GET-NUM-CONSTRAINTS))

(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_getNumConstraints"
               DISCRETE-DYNAMICS-WORLD/GET-NUM-CONSTRAINTS) :int
  (self :pointer))

(declaim (inline DISCRETE-DYNAMICS-WORLD/GET-CONSTRAINT))

(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_getConstraint__SWIG_0"
               DISCRETE-DYNAMICS-WORLD/GET-CONSTRAINT[]) :pointer
  (self :pointer)
  (index :int))
#+ (or)

(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_getConstraint__SWIG_1"
               DISCRETE-DYNAMICS-WORLD/GET-CONSTRAINT) :pointer
  (self :pointer)
  (index :int))

(declaim (inline DISCRETE-DYNAMICS-WORLD/GET-WORLD-TYPE))

(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_getWorldType"
               DISCRETE-DYNAMICS-WORLD/GET-WORLD-TYPE) :pointer
  (self :pointer))

(declaim (inline DISCRETE-DYNAMICS-WORLD/CLEAR-FORCES))

(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_clearForces"
               DISCRETE-DYNAMICS-WORLD/CLEAR-FORCES) :void
  (self :pointer))

(declaim (inline DISCRETE-DYNAMICS-WORLD/APPLY-GRAVITY))

(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_applyGravity"
               DISCRETE-DYNAMICS-WORLD/APPLY-GRAVITY) :void
  (self :pointer))

(declaim (inline DISCRETE-DYNAMICS-WORLD/SET-NUM-TASKS))

(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_setNumTasks"
               DISCRETE-DYNAMICS-WORLD/SET-NUM-TASKS) :void
  (self :pointer)
  (numTasks :int))

(declaim (inline DISCRETE-DYNAMICS-WORLD/UPDATE-VEHICLES))

(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_updateVehicles"
               DISCRETE-DYNAMICS-WORLD/UPDATE-VEHICLES) :void
  (self :pointer)
  (timeStep :float))

(declaim (inline DISCRETE-DYNAMICS-WORLD/ADD-VEHICLE))

(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_addVehicle"
               DISCRETE-DYNAMICS-WORLD/ADD-VEHICLE) :void
  (self :pointer)
  (vehicle :pointer))

(declaim (inline DISCRETE-DYNAMICS-WORLD/REMOVE-VEHICLE))

(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_removeVehicle"
               DISCRETE-DYNAMICS-WORLD/REMOVE-VEHICLE) :void
  (self :pointer)
  (vehicle :pointer))

(declaim (inline DISCRETE-DYNAMICS-WORLD/ADD-CHARACTER))

(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_addCharacter"
               DISCRETE-DYNAMICS-WORLD/ADD-CHARACTER) :void
  (self :pointer)
  (character :pointer))

(declaim (inline DISCRETE-DYNAMICS-WORLD/REMOVE-CHARACTER))

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
               SIMPLE-DYNAMICS-WORLD/STEP-SIMULATION/with-max&fixed) :int
  (self :pointer)
  (timeStep :float)
  (maxSubSteps :int)
  (fixedTimeStep :float))

(declaim (inline SIMPLE-DYNAMICS-WORLD/STEP-SIMULATION))

(cffi:defcfun ("_wrap_btSimpleDynamicsWorld_stepSimulation__SWIG_1"
               SIMPLE-DYNAMICS-WORLD/STEP-SIMULATION/with-max) :int
  (self :pointer)
  (timeStep :float)
  (maxSubSteps :int))


(declaim (inline SIMPLE-DYNAMICS-WORLD/STEP-SIMULATION))

(cffi:defcfun ("_wrap_btSimpleDynamicsWorld_stepSimulation__SWIG_2"
               SIMPLE-DYNAMICS-WORLD/STEP-SIMULATION) :int
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

(declaim (inline MAKE-DISCRETE-DYNAMICS-WORLD))

(cffi:defcfun ("_wrap_new_btDiscreteDynamicsWorld"
               MAKE-DISCRETE-DYNAMICS-WORLD/with-pair-cache&constraint-solver&collision-configuration)
    :pointer
  (dispatcher :pointer)
  (pair-Cache :pointer)
  (constraint-Solver :pointer)
  (collision-Configuration :pointer))

(declaim (inline DELETE/BT-DISCRETE-DYNAMICS-WORLD))

(cffi:defcfun ("_wrap_delete_btDiscreteDynamicsWorld"
               DELETE/BT-DISCRETE-DYNAMICS-WORLD) :void
  (self :pointer))

(declaim (inline DISCRETE-DYNAMICS-WORLD/STEP-SIMULATION))

(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_stepSimulation__SWIG_0"
               DISCRETE-DYNAMICS-WORLD/STEP-SIMULATION/with-time-step&max-sub-steps&fixed-time-step)
    :int
  (self :pointer)
  (timeStep :float)
  (maxSubSteps :int)
  (fixedTimeStep :float))

(declaim (inline DISCRETE-DYNAMICS-WORLD/STEP-SIMULATION))
  (cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_stepSimulation__SWIG_1"
                 DISCRETE-DYNAMICS-WORLD/STEP-SIMULATION/with-time-step&max-sub-steps) :int
    (self :pointer)
    (timeStep :float)
    (maxSubSteps :int))

  (declaim (inline DISCRETE-DYNAMICS-WORLD/STEP-SIMULATION))
  (cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_stepSimulation__SWIG_2"
                 DISCRETE-DYNAMICS-WORLD/STEP-SIMULATION/with-time-step) :int
    (self :pointer)
    (timeStep :float))

;; (declaim (inline DISCRETE-DYNAMICS-WORLD/SYNCHRONIZE-MOTION-STATES))

;; (cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_synchronizeMotionStates"
;;                DISCRETE-DYNAMICS-WORLD/SYNCHRONIZE-MOTION-STATES) :void
;;   (self :pointer))

(declaim (inline DISCRETE-DYNAMICS-WORLD/SYNCHRONIZE-SINGLE-MOTION-STATE))

(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_synchronizeSingleMotionState"
               DISCRETE-DYNAMICS-WORLD/SYNCHRONIZE-SINGLE-MOTION-STATE) :void
  (self :pointer)
  (body :pointer))

(defmethod initialize-instance :after ((obj DISCRETE-DYNAMICS-WORLD) &key dispatcher pair-Cache constraint-Solver collision-Configuration)
  (setf (slot-value obj 'ff-pointer) (MAKE-DISCRETE-DYNAMICS-WORLD dispatcher pair-Cache constraint-Solver collision-Configuration)))
(defmethod STEP-SIMULATION
    ((self DISCRETE-DYNAMICS-WORLD)
     (time-Step number) &optional max-sub-steps fixed-time-step)
  (check-type max-Sub-Steps (or null number))
  (check-type fixed-Time-Step (or null number))
  (cond
    ((and max-sub-steps fixed-time-step)
     (discrete-dynamics-world/step-simulation/with-time-step&max-sub-steps&fixed-time-step
      (ff-pointer self) time-Step max-Sub-Steps fixed-Time-Step))
    (max-sub-steps (discrete-dynamics-world/step-simulation/with-time-step&max-sub-steps
                    (ff-pointer self) time-Step max-Sub-Steps))
    (t (DISCRETE-DYNAMICS-WORLD/STEP-SIMULATION/with-time-step (ff-pointer self) time-Step))))

(defmethod SYNCHRONIZE-MOTION-STATES ((self DISCRETE-DYNAMICS-WORLD))
  (DISCRETE-DYNAMICS-WORLD/SYNCHRONIZE-MOTION-STATES (ff-pointer self)))
(defmethod SYNCHRONIZE-SINGLE-MOTION-STATE ((self DISCRETE-DYNAMICS-WORLD) body)
  (DISCRETE-DYNAMICS-WORLD/SYNCHRONIZE-SINGLE-MOTION-STATE (ff-pointer self) body))
(defmethod ADD-CONSTRAINT ((self DISCRETE-DYNAMICS-WORLD) constraint
                           &key (disable-Collisions-Between-Linked-Bodies-p nil disable?))
  (if disable?
      (DISCRETE-DYNAMICS-WORLD/ADD-CONSTRAINT/with-disable-collisions-between-linked-bodies
       (ff-pointer self) constraint disable-Collisions-Between-Linked-Bodies-p)
      (DISCRETE-DYNAMICS-WORLD/ADD-CONSTRAINT (ff-pointer self) constraint)))

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
(defmethod (SETF GRAVITY) (gravity (self DISCRETE-DYNAMICS-WORLD))
  (DISCRETE-DYNAMICS-WORLD/SET-GRAVITY (ff-pointer self) gravity))
(defmethod GRAVITY ((self DISCRETE-DYNAMICS-WORLD))
  (DISCRETE-DYNAMICS-WORLD/GET-GRAVITY (ff-pointer self)))
(defmethod ADD-COLLISION-OBJECT ((self DISCRETE-DYNAMICS-WORLD) (collisionObject COLLISION-OBJECT)
                                 &optional collisionfiltergroup collisionfiltermask)
  (cond
    ((and collisionfiltergroup collisionfiltermask)
     (check-type collisionfiltergroup integer)
     (check-type collisionfiltermask integer)
     (DISCRETE-DYNAMICS-WORLD/ADD-COLLISION-OBJECT/with-filter-group&mask
      (ff-pointer self) collisionObject collisionFilterGroup collisionFilterMask))
    ((and collisionfiltergroup)
     (check-type collisionfiltergroup integer)
     (DISCRETE-DYNAMICS-WORLD/ADD-COLLISION-OBJECT/with-filter-group
      (ff-pointer self) collisionObject collisionFilterGroup))
    (t
     (DISCRETE-DYNAMICS-WORLD/ADD-COLLISION-OBJECT (ff-pointer self) collisionObject))))
(defmethod REMOVE-RIGID-BODY ((self DISCRETE-DYNAMICS-WORLD) body)
  (DISCRETE-DYNAMICS-WORLD/REMOVE-RIGID-BODY (ff-pointer self) body))
(defmethod REMOVE-COLLISION-OBJECT ((self DISCRETE-DYNAMICS-WORLD)
                                    (collisionObject COLLISION-OBJECT))
  (DISCRETE-DYNAMICS-WORLD/REMOVE-COLLISION-OBJECT (ff-pointer self) collisionObject))
(defmethod DEBUG-DRAW-CONSTRAINT ((self DISCRETE-DYNAMICS-WORLD) constraint)
  (DISCRETE-DYNAMICS-WORLD/DEBUG-DRAW-CONSTRAINT (ff-pointer self) constraint))
(defmethod DEBUG-DRAW-WORLD ((self DISCRETE-DYNAMICS-WORLD))
  (DISCRETE-DYNAMICS-WORLD/DEBUG-DRAW-WORLD (ff-pointer self)))
(defmethod (SETF CONSTRAINT-SOLVER) (solver (self DISCRETE-DYNAMICS-WORLD))
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
(defmethod (SETF NUM-TASKS) ((numTasks integer) (self DISCRETE-DYNAMICS-WORLD))
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
(defmethod (SETF SYNCHRONIZE-ALL-MOTION-STATES-P) ( (synchronizeAll t) (self DISCRETE-DYNAMICS-WORLD))
  (DISCRETE-DYNAMICS-WORLD/SET-SYNCHRONIZE-ALL-MOTION-STATES (ff-pointer self) synchronizeAll))
(defmethod SYNCHRONIZE-ALL-MOTION-STATES-P ((self DISCRETE-DYNAMICS-WORLD))
  (DISCRETE-DYNAMICS-WORLD/GET-SYNCHRONIZE-ALL-MOTION-STATES (ff-pointer self)))
(defmethod (SETF APPLY-SPECULATIVE-CONTACT-RESTITUTION-P) ( (enable t) (self DISCRETE-DYNAMICS-WORLD))
  (DISCRETE-DYNAMICS-WORLD/SET-APPLY-SPECULATIVE-CONTACT-RESTITUTION (ff-pointer self) enable))
(defmethod APPLY-SPECULATIVE-CONTACT-RESTITUTION-P ((self DISCRETE-DYNAMICS-WORLD))
  (DISCRETE-DYNAMICS-WORLD/GET-APPLY-SPECULATIVE-CONTACT-RESTITUTION (ff-pointer self)))
(defmethod ->serial ((self discrete-dynamics-world) &key serializer
                                                      &allow-other-keys)
  (DISCRETE-DYNAMICS-WORLD/SERIALIZE (ff-pointer self) serializer))
(defmethod (SETF LATENCY-MOTION-STATE-INTERPOLATION-P) ( (latencyInterpolation t) (self DISCRETE-DYNAMICS-WORLD))
  (DISCRETE-DYNAMICS-WORLD/SET-LATENCY-MOTION-STATE-INTERPOLATION (ff-pointer self) latencyInterpolation))
(defmethod LATENCY-MOTION-STATE-INTERPOLATION-P ((self DISCRETE-DYNAMICS-WORLD))
  (DISCRETE-DYNAMICS-WORLD/GET-LATENCY-MOTION-STATE-INTERPOLATION (ff-pointer self)))
(defmethod initialize-instance :after ((obj simple-dynamics-world)
                                       &key dispatcher pair-Cache constraint-Solver collision-Configuration)
  (setf (slot-value obj 'ff-pointer)
        (MAKE-SIMPLE-DYNAMICS-WORLD
         dispatcher pair-Cache constraint-Solver collision-Configuration)))
(defmethod STEP-SIMULATION ((self SIMPLE-DYNAMICS-WORLD) (time-step number)
                            &optional max-sub-steps fixed-time-step)
  (check-type max-sub-steps (or null number))
  (check-type fixed-time-step (or null number))
  (cond
    ((and max-sub-steps fixed-time-step)
     (SIMPLE-DYNAMICS-WORLD/STEP-SIMULATION/with-max&fixed
      (ff-pointer self) time-step max-Sub-Steps fixed-Time-Step))
    (max-sub-steps
     (SIMPLE-DYNAMICS-WORLD/STEP-SIMULATION/with-max
      (ff-pointer self) time-step max-Sub-Steps))
    (t
     (SIMPLE-DYNAMICS-WORLD/STEP-SIMULATION (ff-pointer self) time-step))))
(defmethod (SETF GRAVITY) ( gravity (self SIMPLE-DYNAMICS-WORLD))
  (SIMPLE-DYNAMICS-WORLD/SET-GRAVITY (ff-pointer self) gravity))
(defmethod GRAVITY ((self SIMPLE-DYNAMICS-WORLD))
  (SIMPLE-DYNAMICS-WORLD/GET-GRAVITY (ff-pointer self)))
(defmethod add-rigid-body ((self simple-dynamics-world) body &optional group mask)
  (if group
      (progn
        (check-type group integer)
        (check-type mask integer)
        (SIMPLE-DYNAMICS-WORLD/ADD-RIGID-BODY/with-group&mask
         (ff-pointer self) body group mask))
      (SIMPLE-DYNAMICS-WORLD/ADD-RIGID-BODY
       (ff-pointer self) body)))
(defmethod add-rigid-body ((self discrete-dynamics-world) body &optional group mask)
  (if group
      (progn
        (check-type group integer)
        (check-type mask integer)
        (DISCRETE-DYNAMICS-WORLD/ADD-RIGID-BODY/with-group&mask
         (ff-pointer self) body group mask))
      (DISCRETE-DYNAMICS-WORLD/ADD-RIGID-BODY (ff-pointer self) body)))
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
(defmethod (SETF CONSTRAINT-SOLVER) ( solver (self SIMPLE-DYNAMICS-WORLD))
  (SIMPLE-DYNAMICS-WORLD/SET-CONSTRAINT-SOLVER (ff-pointer self) solver))
(defmethod CONSTRAINT-SOLVER ((self SIMPLE-DYNAMICS-WORLD))
  (SIMPLE-DYNAMICS-WORLD/GET-CONSTRAINT-SOLVER (ff-pointer self)))
(defmethod WORLD-TYPE ((self SIMPLE-DYNAMICS-WORLD))
  (SIMPLE-DYNAMICS-WORLD/GET-WORLD-TYPE (ff-pointer self)))
(defmethod CLEAR-FORCES ((self SIMPLE-DYNAMICS-WORLD))
  (SIMPLE-DYNAMICS-WORLD/CLEAR-FORCES (ff-pointer self)))

