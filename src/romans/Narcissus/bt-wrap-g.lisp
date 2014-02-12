(in-package :bullet-physics)


#+(or) (defmethod bullet/delete ((self BOX-SHAPE) ptr))


(cffi:defcfun ("_wrap_new_btFixedConstraint"
               MAKE-FIXED-CONSTRAINT) :pointer
  (rigid-body-a :pointer)
  (rigid-body-b :pointer)
  (frame-in-a :pointer)
  (frame-in-b :pointer))

(defmethod GRAVITY ((self DISCRETE-DYNAMICS-WORLD))
  (DISCRETE-DYNAMICS-WORLD/GET-GRAVITY (ff-pointer self)))

(defmethod ADD-COLLISION-OBJECT ((self discrete-dynamics-world)
                                 (collision-object collision-object)
                                 &optional
                                   collision-filter-group
                                   collision-filter-mask)
  (check-type collision-filter-group (or null integer))
  (check-type collision-filter-mask (or null integer))
  (cond
    ((and collision-filter-mask
          collision-filter-group)
     (discrete-dynamics-world/add-collision-object/with-filter-group&mask
      (ff-pointer self) collision-object collision-filter-group collision-filter-mask))
    (collision-filter-group
     (discrete-dynamics-world/add-collision-object/with-filter-group
      (ff-pointer self) collision-object collision-filter-group))
    (t
     (discrete-dynamics-world/add-collision-object (ff-pointer self) collision-object))))

(defmethod REMOVE-RIGID-BODY ((self DISCRETE-DYNAMICS-WORLD) body)
  (DISCRETE-DYNAMICS-WORLD/REMOVE-RIGID-BODY (ff-pointer self) body))

(defmethod REMOVE-COLLISION-OBJECT ((self DISCRETE-DYNAMICS-WORLD)
                                    (collisionObject COLLISION-OBJECT))
  (DISCRETE-DYNAMICS-WORLD/REMOVE-COLLISION-OBJECT (ff-pointer self) collisionObject))

(defmethod DEBUG-DRAW-CONSTRAINT ((self DISCRETE-DYNAMICS-WORLD) constraint)
  (DISCRETE-DYNAMICS-WORLD/DEBUG-DRAW-CONSTRAINT (ff-pointer self) constraint))

(defmethod DEBUG-DRAW-WORLD ((self DISCRETE-DYNAMICS-WORLD))  (DISCRETE-DYNAMICS-WORLD/DEBUG-DRAW-WORLD (ff-pointer self)))

(defmethod (SETF CONSTRAINT-SOLVER) ( solver (self DISCRETE-DYNAMICS-WORLD))
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

(defmethod (SETF NUM-TASKS) ( (numTasks integer) (self DISCRETE-DYNAMICS-WORLD))
  (DISCRETE-DYNAMICS-WORLD/SET-NUM-TASKS (ff-pointer self) numTasks))

(defmethod UPDATE-VEHICLES ((self DISCRETE-DYNAMICS-WORLD) (time-step number))
  (DISCRETE-DYNAMICS-WORLD/UPDATE-VEHICLES (ff-pointer self) time-step))

(defmethod ADD-VEHICLE ((self DISCRETE-DYNAMICS-WORLD) vehicle)
  (DISCRETE-DYNAMICS-WORLD/ADD-VEHICLE (ff-pointer self) vehicle))

(defmethod REMOVE-VEHICLE ((self DISCRETE-DYNAMICS-WORLD) vehicle)
  (DISCRETE-DYNAMICS-WORLD/REMOVE-VEHICLE (ff-pointer self) vehicle))

(defmethod ADD-CHARACTER ((self DISCRETE-DYNAMICS-WORLD) character)
  (DISCRETE-DYNAMICS-WORLD/ADD-CHARACTER (ff-pointer self) character))

(defmethod REMOVE-CHARACTER ((self DISCRETE-DYNAMICS-WORLD) character)
  (DISCRETE-DYNAMICS-WORLD/REMOVE-CHARACTER (ff-pointer self) character))

(defmethod (SETF SYNCHRONIZE-ALL-MOTION-STATES-P)
    ( (synchronizeAll t) (self DISCRETE-DYNAMICS-WORLD))
  (DISCRETE-DYNAMICS-WORLD/SET-SYNCHRONIZE-ALL-MOTION-STATES (ff-pointer self) synchronizeAll))

(defmethod SYNCHRONIZE-ALL-MOTION-STATES-P ((self DISCRETE-DYNAMICS-WORLD))
  (DISCRETE-DYNAMICS-WORLD/GET-SYNCHRONIZE-ALL-MOTION-STATES (ff-pointer self)))

(defmethod (SETF APPLY-SPECULATIVE-CONTACT-RESTITUTION-P)
    ( (enable t) (self DISCRETE-DYNAMICS-WORLD))
  (DISCRETE-DYNAMICS-WORLD/SET-APPLY-SPECULATIVE-CONTACT-RESTITUTION (ff-pointer self) enable))

(defmethod APPLY-SPECULATIVE-CONTACT-RESTITUTION-P
    ((self DISCRETE-DYNAMICS-WORLD))
  (DISCRETE-DYNAMICS-WORLD/GET-APPLY-SPECULATIVE-CONTACT-RESTITUTION (ff-pointer self)))

(defmethod ->serial ((self DISCRETE-DYNAMICS-WORLD) &key serializer &allow-other-keys)
  (check-type serializer serializer)
  (DISCRETE-DYNAMICS-WORLD/SERIALIZE (ff-pointer self) (ff-pointer serializer)))

(defmethod (SETF LATENCY-MOTION-STATE-INTERPOLATION-P)
    ( (latencyInterpolation t) (self DISCRETE-DYNAMICS-WORLD))
  (DISCRETE-DYNAMICS-WORLD/SET-LATENCY-MOTION-STATE-INTERPOLATION (ff-pointer self) latencyInterpolation))

(defmethod LATENCY-MOTION-STATE-INTERPOLATION-P
    ((self DISCRETE-DYNAMICS-WORLD))
  (discrete-dynamics-world/get-latency-motion-state-interpolation (ff-pointer self)))

(defmethod initialize-instance :after ((obj SIMPLE-DYNAMICS-WORLD) &key dispatcher pairCache constraintSolver collisionConfiguration)
  (setf (slot-value obj 'ff-pointer) (MAKE-SIMPLE-DYNAMICS-WORLD dispatcher pairCache constraintSolver collisionConfiguration)))

(defmethod STEP-SIMULATION ((self SIMPLE-DYNAMICS-WORLD) (time-step number)
                            &optional max-sub-steps fixed-time-step)
  (check-type max-sub-steps (or null integer))
  (check-type fixed-time-step (or null number))
  (cond
    ((and fixed-time-step max-sub-steps)
     (SIMPLE-DYNAMICS-WORLD/STEP-SIMULATION/with-max&fixed
      (ff-pointer self) time-step max-sub-steps (coerce fixed-Time-Step 'single-float)))
    (max-sub-steps
     (SIMPLE-DYNAMICS-WORLD/STEP-SIMULATION/with-max (ff-pointer self) time-step max-sub-steps))
    (t (SIMPLE-DYNAMICS-WORLD/STEP-SIMULATION (ff-pointer self) time-step))))


(defmethod (SETF GRAVITY) ( (gravity VECTOR3) (self SIMPLE-DYNAMICS-WORLD))
  (SIMPLE-DYNAMICS-WORLD/SET-GRAVITY (ff-pointer self) gravity))

(defmethod GRAVITY ((self SIMPLE-DYNAMICS-WORLD))
  (SIMPLE-DYNAMICS-WORLD/GET-GRAVITY (ff-pointer self)))

(defmethod ADD-RIGID-BODY ((self SIMPLE-DYNAMICS-WORLD) body &optional group mask)
  (check-type group (or null integer))
  (check-type mask (or null integer))
  (cond
    ((and mask group)
     (SIMPLE-DYNAMICS-WORLD/ADD-RIGID-BODY/with-group&mask
      (ff-pointer self) body group mask))
    (group
     (error 'foo))
    (t
     (SIMPLE-DYNAMICS-WORLD/ADD-RIGID-BODY (ff-pointer self) body))))

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



#+(or) (defmethod new ((self TYPED-CONSTRAINT) sizeInBytes)
          (TYPED-CONSTRAINT/MAKE-c++-INSTANCE (ff-pointer self) sizeInBytes))
#+(or) (defmethod bullet/delete ((self TYPED-CONSTRAINT) ptr)
          (TYPED-CONSTRAINT/DELETE-c++-INSTANCE (ff-pointer self) ptr))
#+(or) (defmethod new ((self TYPED-CONSTRAINT) arg1 ptr)
          (TYPED-CONSTRAINT/MAKE-c++-INSTANCE (ff-pointer self) arg1 ptr))
#+(or) (defmethod bullet/delete ((self TYPED-CONSTRAINT) arg1 arg2)
          (TYPED-CONSTRAINT/DELETE-c++-INSTANCE (ff-pointer self) arg1 arg2))
#+(or) (shadow "new[]")
#+(or) (defmethod new[] ((self TYPED-CONSTRAINT) sizeInBytes)
          (TYPED-CONSTRAINT/MAKE-c++-ARRAY (ff-pointer self) sizeInBytes))
#+(or) (shadow "delete[]")
#+(or) (defmethod delete[] ((self TYPED-CONSTRAINT) ptr)
          (TYPED-CONSTRAINT/DELETE-c++-ARRAY (ff-pointer self) ptr))
#+(or) (shadow "new[]")
#+(or) (defmethod new[] ((self TYPED-CONSTRAINT) arg1 ptr)
          (TYPED-CONSTRAINT/MAKE-c++-ARRAY (ff-pointer self) arg1 ptr))
#+(or) (defmethod delete[] ((self TYPED-CONSTRAINT) arg1 arg2)
          (TYPED-CONSTRAINT/DELETE-c++-ARRAY (ff-pointer self) arg1 arg2))

(defmethod OVERRIDE-NUM-SOLVER-ITERATIONS ((self TYPED-CONSTRAINT))
  (TYPED-CONSTRAINT/GET-OVERRIDE-NUM-SOLVER-ITERATIONS (ff-pointer self)))

(defmethod (SETF OVERRIDE-NUM-SOLVER-ITERATIONS) ( (overideNumIterations integer) (self TYPED-CONSTRAINT))
  (TYPED-CONSTRAINT/SET-OVERRIDE-NUM-SOLVER-ITERATIONS (ff-pointer self) overideNumIterations))

(defmethod BUILD-JACOBIAN ((self TYPED-CONSTRAINT))
  (TYPED-CONSTRAINT/BUILD-JACOBIAN (ff-pointer self)))

(defmethod SETUP-SOLVER-CONSTRAINT ((self TYPED-CONSTRAINT) ca (solverBodyA integer) (solverBodyB integer) (time-step number))
  (TYPED-CONSTRAINT/SETUP-SOLVER-CONSTRAINT (ff-pointer self) ca solverBodyA solverBodyB time-step))

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

(defmethod (SETF BREAKING-IMPULSE-THRESHOLD) ( (threshold number) (self TYPED-CONSTRAINT))
  (TYPED-CONSTRAINT/SET-BREAKING-IMPULSE-THRESHOLD (ff-pointer self) threshold))

(defmethod ENABLEDP ((self TYPED-CONSTRAINT))
  (TYPED-CONSTRAINT/IS-ENABLED (ff-pointer self)))

(defmethod (SETF ENABLED) ( (enabled t) (self TYPED-CONSTRAINT))
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

(defmethod (SETF USER-CONSTRAINT-TYPE) ( (userConstraintType integer) (self TYPED-CONSTRAINT))
  (TYPED-CONSTRAINT/SET-USER-CONSTRAINT-TYPE (ff-pointer self) userConstraintType))

(defmethod (SETF USER-CONSTRAINT-ID) ( (uid integer) (self TYPED-CONSTRAINT))
  (TYPED-CONSTRAINT/SET-USER-CONSTRAINT-ID (ff-pointer self) uid))

(defmethod USER-CONSTRAINT-ID ((self TYPED-CONSTRAINT))
  (TYPED-CONSTRAINT/GET-USER-CONSTRAINT-ID (ff-pointer self)))

(defmethod (SETF USER-CONSTRAINT-PTR) ( ptr (self TYPED-CONSTRAINT))
  (TYPED-CONSTRAINT/SET-USER-CONSTRAINT-PTR (ff-pointer self) ptr))

(defmethod USER-CONSTRAINT-PTR ((self TYPED-CONSTRAINT))
  (TYPED-CONSTRAINT/GET-USER-CONSTRAINT-PTR (ff-pointer self)))

(defmethod (SETF JOINT-FEEDBACK) ( jointFeedback (self TYPED-CONSTRAINT))
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

(defmethod (SETF DBG-DRAW-SIZE) ( (dbgDrawSize number) (self TYPED-CONSTRAINT))
  (TYPED-CONSTRAINT/SET-DBG-DRAW-SIZE (ff-pointer self) dbgDrawSize))

(defmethod DBG-DRAW-SIZE ((self TYPED-CONSTRAINT))
  (TYPED-CONSTRAINT/GET-DBG-DRAW-SIZE (ff-pointer self)))

(defmethod CALCULATE-SERIALIZE-BUFFER-SIZE ((self TYPED-CONSTRAINT))
  (TYPED-CONSTRAINT/CALCULATE-SERIALIZE-BUFFER-SIZE (ff-pointer self)))

(defmethod ->serial ((self TYPED-CONSTRAINT) &key data-Buffer serializer &allow-other-keys)
  (check-type serializer SERIALIZER)
  (TYPED-CONSTRAINT/SERIALIZE (ff-pointer self) data-Buffer (ff-pointer serializer)))


(defmethod initialize-instance :after ((obj ANGULAR-LIMIT) &key)
  (setf (slot-value obj 'ff-pointer) (MAKE-ANGULAR-LIMIT)))

(defmethod angular-limit-set-all ((self ANGULAR-LIMIT) (low number) (high number) (softness number) (bias-factor number) (relaxation-factor number))
  (ANGULAR-LIMIT/SET (ff-pointer self) low high softness bias-factor relaxation-factor))

#+TODO (defmethod BULLET/SET ((self ANGULAR-LIMIT) (low number) (high number) (softness number) (bias-factor number))
  (ANGULAR-LIMIT/SET (ff-pointer self) low high softness bias-factor))

#+TODO (defmethod BULLET/SET ((self ANGULAR-LIMIT) (low number) (high number) (softness number))
  (ANGULAR-LIMIT/SET (ff-pointer self) low high softness))

#+TODO (defmethod BULLET/SET ((self ANGULAR-LIMIT) (low number) (high number))
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


#+(or) (defmethod new ((self POINT->POINT-CONSTRAINT) sizeInBytes)
        (POINT->POINT-CONSTRAINT/MAKE-c++-INSTANCE (ff-pointer self) sizeInBytes))

#+(or) (defmethod bullet/delete ((self POINT->POINT-CONSTRAINT) ptr)
  (POINT->POINT-CONSTRAINT/DELETE-c++-INSTANCE (ff-pointer self) ptr))

#+(or) (defmethod new ((self POINT->POINT-CONSTRAINT) arg1 ptr)
  (POINT->POINT-CONSTRAINT/MAKE-c++-INSTANCE (ff-pointer self) arg1 ptr))

#+(or) (defmethod bullet/delete ((self POINT->POINT-CONSTRAINT) arg1 arg2)
  (POINT->POINT-CONSTRAINT/DELETE-c++-INSTANCE (ff-pointer self) arg1 arg2))

#+(or) (shadow "new[]")

#+(or) (defmethod new[] ((self POINT->POINT-CONSTRAINT) sizeInBytes)
  (POINT->POINT-CONSTRAINT/MAKE-c++-ARRAY (ff-pointer self) sizeInBytes))

#+(or) (shadow "delete[]")

#+(or) (defmethod delete[] ((self POINT->POINT-CONSTRAINT) ptr)
  (POINT->POINT-CONSTRAINT/DELETE-c++-ARRAY (ff-pointer self) ptr))

#+(or) (shadow "new[]")

#+(or) (defmethod new[] ((self POINT->POINT-CONSTRAINT) arg1 ptr)
  (POINT->POINT-CONSTRAINT/MAKE-c++-ARRAY (ff-pointer self) arg1 ptr))

#+(or) (shadow "delete[]")

#+(or) (defmethod delete[] ((self POINT->POINT-CONSTRAINT) arg1 arg2)
  (POINT->POINT-CONSTRAINT/DELETE-c++-ARRAY (ff-pointer self) arg1 arg2))

(defmethod (setf USE-SOLVE-CONSTRAINT-OBSOLETE) ( (obj POINT->POINT-CONSTRAINT) arg0)
  (POINT->POINT-CONSTRAINT/USE-SOLVE-CONSTRAINT-OBSOLETE/SET (ff-pointer obj) arg0))

(defmethod USE-SOLVE-CONSTRAINT-OBSOLETE ((obj POINT->POINT-CONSTRAINT))
  (POINT->POINT-CONSTRAINT/USE-SOLVE-CONSTRAINT-OBSOLETE/GET (ff-pointer obj)))

(defmethod (setf SETTING) ( (obj POINT->POINT-CONSTRAINT) arg0)
  (POINT->POINT-CONSTRAINT/SETTING/SET (ff-pointer obj) arg0))

(defmethod SETTING ((obj POINT->POINT-CONSTRAINT))
  (POINT->POINT-CONSTRAINT/SETTING/GET (ff-pointer obj)))

(defmethod initialize-instance :after ((obj POINT->POINT-CONSTRAINT) 
                                       &key rigid-body-a rigid-body-b
                                         pivot-in-a pivot-in-b)
  (check-type rigid-body-a RIGID-BODY) 
  (check-type pivot-In-A VECTOR3)
  (setf (slot-value obj 'ff-pointer)
        (cond
          ((or rigid-body-b pivot-in-b)
           (check-type rigid-body-b RIGID-BODY)
           (check-type pivot-In-B VECTOR3)
           (MAKE-POINT->POINT-CONSTRAINT (ff-pointer rigid-body-a)
                                         (ff-pointer rigid-body-b)
                                         (ff-pointer pivot-in-A) 
                                         (ff-pointer pivot-in-B)))
          (t (MAKE-POINT->POINT-CONSTRAINT/with-rigid-body-a&pivot-in-a 
              rigid-body-a pivot-in-A)))))

(defmethod BUILD-JACOBIAN ((self POINT->POINT-CONSTRAINT))
  (POINT->POINT-CONSTRAINT/BUILD-JACOBIAN (ff-pointer self)))

(defmethod INFO-1 ((self POINT->POINT-CONSTRAINT) info)
  (POINT->POINT-CONSTRAINT/GET-INFO-1 (ff-pointer self) info))

(defmethod INFO-1-NON-VIRTUAL ((self POINT->POINT-CONSTRAINT) info)
  (POINT->POINT-CONSTRAINT/GET-INFO-1-NON-VIRTUAL (ff-pointer self) info))

(defmethod INFO-2 ((self POINT->POINT-CONSTRAINT) info)
  (POINT->POINT-CONSTRAINT/GET-INFO-2 (ff-pointer self) info))

(defmethod INFO-2-NON-VIRTUAL/point->point ((self POINT->POINT-CONSTRAINT) info (body0_trans TRANSFORM) (body1_trans TRANSFORM))
  (POINT->POINT-CONSTRAINT/GET-INFO-2-NON-VIRTUAL (ff-pointer self) info body0_trans body1_trans))

(defmethod UPDATE-RHS ((self POINT->POINT-CONSTRAINT) (time-step number))
  (POINT->POINT-CONSTRAINT/UPDATE-RHS (ff-pointer self) time-step))

(defmethod (SETF PIVOT-A) ( (pivotA VECTOR3) (self POINT->POINT-CONSTRAINT))
  (POINT->POINT-CONSTRAINT/SET-PIVOT-A (ff-pointer self) pivotA))

(defmethod (SETF PIVOT-B) ( (pivotB VECTOR3) (self POINT->POINT-CONSTRAINT))
  (POINT->POINT-CONSTRAINT/SET-PIVOT-B (ff-pointer self) pivotB))

(defmethod PIVOT-IN-A ((self POINT->POINT-CONSTRAINT))
  (POINT->POINT-CONSTRAINT/GET-PIVOT-IN-A (ff-pointer self)))

(defmethod PIVOT-IN-B ((self POINT->POINT-CONSTRAINT))
  (POINT->POINT-CONSTRAINT/GET-PIVOT-IN-B (ff-pointer self)))

(defmethod CALCULATE-SERIALIZE-BUFFER-SIZE ((self POINT->POINT-CONSTRAINT))
  (POINT->POINT-CONSTRAINT/CALCULATE-SERIALIZE-BUFFER-SIZE (ff-pointer self)))

(defmethod ->serial ((self POINT->POINT-CONSTRAINT)&key data-buffer serializer &allow-other-keys)
    (check-type serializer serializer)
    (POINT->POINT-CONSTRAINT/SERIALIZE (ff-pointer self) data-buffer
                                       (ff-pointer serializer)))


#+(or) (defmethod new ((self HINGE-CONSTRAINT) sizeInBytes)
  (HINGE-CONSTRAINT/MAKE-c++-INSTANCE (ff-pointer self) sizeInBytes))

#+(or) (defmethod bullet/delete ((self HINGE-CONSTRAINT) ptr)
  (HINGE-CONSTRAINT/DELETE-c++-INSTANCE (ff-pointer self) ptr))

#+(or) (defmethod new ((self HINGE-CONSTRAINT) arg1 ptr)
  (HINGE-CONSTRAINT/MAKE-c++-INSTANCE (ff-pointer self) arg1 ptr))

#+(or) (defmethod bullet/delete ((self HINGE-CONSTRAINT) arg1 arg2)
  (HINGE-CONSTRAINT/DELETE-c++-INSTANCE (ff-pointer self) arg1 arg2))

#+(or) (shadow "new[]")

#+(or) (defmethod new[] ((self HINGE-CONSTRAINT) sizeInBytes)
  (HINGE-CONSTRAINT/MAKE-c++-ARRAY (ff-pointer self) sizeInBytes))

#+(or) (shadow "delete[]")

#+(or) (defmethod delete[] ((self HINGE-CONSTRAINT) ptr)
  (HINGE-CONSTRAINT/DELETE-c++-ARRAY (ff-pointer self) ptr))

#+(or) (shadow "new[]")

#+(or) (defmethod new[] ((self HINGE-CONSTRAINT) arg1 ptr)
  (HINGE-CONSTRAINT/MAKE-c++-ARRAY (ff-pointer self) arg1 ptr))

#+(or) (shadow "delete[]")

#+(or) (defmethod delete[] ((self HINGE-CONSTRAINT) arg1 arg2)
           (HINGE-CONSTRAINT/DELETE-c++-ARRAY (ff-pointer self) arg1 arg2))


(defmethod initialize-instance :after ((obj HINGE-CONSTRAINT) 
                                       &key 
                                         rigid-body-a rigid-body-b
                                         pivot-in-a pivot-in-b
                                         axis-in-a axis-in-b
                                         rigid-body-a-frame rigid-body-b-frame
                                         (use-reference-frame-a-p nil use-a?))
  (when axis-in-a
    (check-type rigid-body-a RIGID-BODY)
   (check-type pivot-in-A VECTOR3) 
   (check-type axis-in-a VECTOR3))
  (when axis-in-b
   (check-type rigid-body-b RIGID-BODY) 
   (check-type pivot-in-B VECTOR3)
   (check-type axis-in-b VECTOR3))
  (check-type rigid-body-a-frame (or null TRANSFORM)) 
  (check-type rigid-body-b-frame (or null TRANSFORM))
  (setf (slot-value obj 'ff-pointer) 
        (cond
          ((and use-a? axis-in-b)
           (MAKE-HINGE-CONSTRAINT/with-a&b&use-a rigid-body-a rigid-body-b
                                                               pivot-in-A pivot-in-B
                                                               axis-in-a axis-in-b 
                                                               use-Reference-Frame-A-P))
           ((and axis-in-b)
            (MAKE-HINGE-CONSTRAINT/with-a&b rigid-body-a rigid-body-b 
                                          pivot-in-A pivot-in-B
                                          axis-in-a axis-in-b))
           ((and use-a? rigid-body-b-frame rigid-body-a-frame)
            (MAKE-HINGE-CONSTRAINT/with-frame-a&b&use-a
             rigid-body-a rigid-body-b
             rigid-body-a-frame rigid-body-b-frame
             use-reference-frame-a-p))
           ((and rigid-body-b-frame rigid-body-a-frame)
            (MAKE-HINGE-CONSTRAINT/with-frame-a&b rigid-body-a rigid-body-b
                                                  rigid-body-a-frame rigid-body-b-frame))
           ((and use-a? rigid-body-a-frame)
            (MAKE-HINGE-CONSTRAINT/with-frame-a&use-a
             rigid-body-a rigid-body-a-frame 
             use-reference-frame-a-p))
           (rigid-body-a-frame
            (MAKE-HINGE-CONSTRAINT/with-frame-a
             rigid-body-a rigid-body-a-frame))
           (use-a?
            (MAKE-HINGE-CONSTRAINT/WITH-USE-A rigid-body-a 
                                              pivot-in-A 
                                              axis-in-a
                                              use-Reference-Frame-A-P))
           (t (MAKE-HINGE-CONSTRAINT rigid-body-a pivot-in-A axis-in-a)))))


(defmethod BUILD-JACOBIAN ((self HINGE-CONSTRAINT))
  (HINGE-CONSTRAINT/BUILD-JACOBIAN (ff-pointer self)))

(defmethod INFO-1 ((self HINGE-CONSTRAINT) info)
  (HINGE-CONSTRAINT/GET-INFO-1 (ff-pointer self) info))

(defmethod INFO-1-NON-VIRTUAL ((self HINGE-CONSTRAINT) info)
  (HINGE-CONSTRAINT/GET-INFO-1-NON-VIRTUAL (ff-pointer self) info))

(defmethod INFO-2 ((self HINGE-CONSTRAINT) info)
  (HINGE-CONSTRAINT/GET-INFO-2 (ff-pointer self) info))

(defmethod INFO-2-NON-VIRTUAL-with-angles
    ((self HINGE-CONSTRAINT) info (transA TRANSFORM) (transB TRANSFORM) (angVelA VECTOR3) (angVelB VECTOR3))
  (HINGE-CONSTRAINT/GET-INFO-2-NON-VIRTUAL (ff-pointer self) info transA transB angVelA angVelB))

(defmethod INFO-2-INTERNAL ((self HINGE-CONSTRAINT) info (transA TRANSFORM) (transB TRANSFORM) (angVelA VECTOR3) (angVelB VECTOR3))
  (HINGE-CONSTRAINT/GET-INFO-2-INTERNAL (ff-pointer self) info transA transB angVelA angVelB))

(defmethod INFO-2-INTERNAL-USING-FRAME-OFFSET ((self HINGE-CONSTRAINT) info (transA TRANSFORM) (transB TRANSFORM) (angVelA VECTOR3) (angVelB VECTOR3))
  (HINGE-CONSTRAINT/GET-INFO-2-INTERNAL-USING-FRAME-OFFSET (ff-pointer self) info transA transB angVelA angVelB))

(defmethod UPDATE-RHS ((self HINGE-CONSTRAINT) (time-step number))
  (HINGE-CONSTRAINT/UPDATE-RHS (ff-pointer self) time-step))

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

(defmethod (SETF FRAMES) ((frameA TRANSFORM) (frameB TRANSFORM)
                          (self HINGE-CONSTRAINT))
  (HINGE-CONSTRAINT/SET-FRAMES (ff-pointer self) frameA frameB))

(defmethod (SETF ANGULAR-ONLY) ( (angularOnly t) (self HINGE-CONSTRAINT))
  (HINGE-CONSTRAINT/SET-ANGULAR-ONLY (ff-pointer self) angularOnly))

(defmethod ENABLE-ANGULAR-MOTOR ((self HINGE-CONSTRAINT) (enableMotor t) (targetVelocity number) (maxMotorImpulse number))
  (HINGE-CONSTRAINT/ENABLE-ANGULAR-MOTOR (ff-pointer self) enableMotor targetVelocity maxMotorImpulse))

(defmethod (SETF MOTOR-ENABLED-P) ( (enableMotor t) (self HINGE-CONSTRAINT))
  (HINGE-CONSTRAINT/ENABLE-MOTOR (ff-pointer self) enableMotor))

(defmethod (SETF MAX-MOTOR-IMPULSE) ( (maxMotorImpulse number) (self HINGE-CONSTRAINT))
  (HINGE-CONSTRAINT/SET-MAX-MOTOR-IMPULSE (ff-pointer self) maxMotorImpulse))

(defmethod (SETF MOTOR-TARGET) ( (qAinB QUATERNION) (self HINGE-CONSTRAINT) (dt number))
  (HINGE-CONSTRAINT/SET-MOTOR-TARGET (ff-pointer self) qAinB dt))

(defmethod (SETF MOTOR-TARGET) ( (targetAngle number) (self HINGE-CONSTRAINT) (dt number))
  (HINGE-CONSTRAINT/SET-MOTOR-TARGET (ff-pointer self) targetAngle dt))

(defmethod (SETF LIMITS+softness+bias+relaxation)
    ((self HINGE-CONSTRAINT) (low number) (high number)
     (softness number) (bias-factor number) (relaxation-Factor number))
  (HINGE-CONSTRAINT/SET-LIMIT/with-softness&bias&relaxation
   (ff-pointer self) low high softness bias-factor relaxation-Factor))

(defmethod (SETF LIMITS+softness+bias)
    ((self HINGE-CONSTRAINT) (low number) (high number) (softness number) (bias-factor number))
  (HINGE-CONSTRAINT/SET-LIMIT/with-softness&bias (ff-pointer self)
                                                 low high softness bias-factor))

(defmethod (SETF LIMITs+softness) ((self HINGE-CONSTRAINT) (low number) (high number)
                                   (softness number))
  (HINGE-CONSTRAINT/SET-LIMIT/with-softness (ff-pointer self) low high softness))

(defmethod (SETF LIMITS) ((self HINGE-CONSTRAINT) (low number) (high number))
  (HINGE-CONSTRAINT/SET-LIMIT (ff-pointer self) low high))

(defmethod (SETF AXIS) ( (axis-in-a VECTOR3) (self HINGE-CONSTRAINT))
  (HINGE-CONSTRAINT/SET-AXIS (ff-pointer self) axis-in-a))

(defmethod LOWER-LIMIT ((self HINGE-CONSTRAINT))
  (HINGE-CONSTRAINT/GET-LOWER-LIMIT (ff-pointer self)))

(defmethod UPPER-LIMIT ((self HINGE-CONSTRAINT))
  (HINGE-CONSTRAINT/GET-UPPER-LIMIT (ff-pointer self)))

(defmethod HINGE-ANGLE ((self HINGE-CONSTRAINT) &optional trans-a trans-b)
  (if trans-a
      (progn
        (check-type trans-a transform)
        (check-type trans-b transform)
        (HINGE-CONSTRAINT/GET-HINGE-ANGLE/with-trans-a&b (ff-pointer self) trans-A trans-B))
      (HINGE-CONSTRAINT/GET-HINGE-ANGLE (ff-pointer self))))

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

(defmethod ANGULAR-MOTOR-ENABLED-P ((self HINGE-CONSTRAINT))
  (HINGE-CONSTRAINT/GET-ENABLE-ANGULAR-MOTOR (ff-pointer self)))

(defmethod MOTOR-TARGET-VELOSITY ((self HINGE-CONSTRAINT))
  (HINGE-CONSTRAINT/GET-MOTOR-TARGET-VELOSITY (ff-pointer self)))

(defmethod MAX-MOTOR-IMPULSE ((self HINGE-CONSTRAINT))
  (HINGE-CONSTRAINT/GET-MAX-MOTOR-IMPULSE (ff-pointer self)))

(defmethod USE-FRAME-OFFSET ((self HINGE-CONSTRAINT))
  (HINGE-CONSTRAINT/GET-USE-FRAME-OFFSET (ff-pointer self)))

(defmethod (SETF USE-FRAME-OFFSET) ( (frameOffsetOnOff t) (self HINGE-CONSTRAINT))
  (HINGE-CONSTRAINT/SET-USE-FRAME-OFFSET (ff-pointer self) frameOffsetOnOff))

(defmethod CALCULATE-SERIALIZE-BUFFER-SIZE ((self HINGE-CONSTRAINT))
  (HINGE-CONSTRAINT/CALCULATE-SERIALIZE-BUFFER-SIZE (ff-pointer self)))

(defmethod ->serial ((self HINGE-CONSTRAINT) &key data-buffer serializer &allow-other-keys)
    (check-type serializer serializer)
    (HINGE-CONSTRAINT/SERIALIZE (ff-pointer self) data-buffer (ff-pointer serializer)))


#+(or) (defmethod new ((self CONE-TWIST-CONSTRAINT) sizeInBytes)
  (CONE-TWIST-CONSTRAINT/MAKE-c++-INSTANCE (ff-pointer self) sizeInBytes))

#+(or) (defmethod bullet/delete ((self CONE-TWIST-CONSTRAINT) ptr)
  (CONE-TWIST-CONSTRAINT/DELETE-c++-INSTANCE (ff-pointer self) ptr))

#+(or) (defmethod new ((self CONE-TWIST-CONSTRAINT) arg1 ptr)
        (CONE-TWIST-CONSTRAINT/MAKE-c++-INSTANCE (ff-pointer self) arg1 ptr))

#+(or) (defmethod bullet/delete ((self CONE-TWIST-CONSTRAINT) arg1 arg2)
  (CONE-TWIST-CONSTRAINT/DELETE-c++-INSTANCE (ff-pointer self) arg1 arg2))

#+(or)(shadow "new[]")

#+(or)#+(or) (defmethod new[] ((self CONE-TWIST-CONSTRAINT) sizeInBytes)
  (CONE-TWIST-CONSTRAINT/MAKE-c++-ARRAY (ff-pointer self) sizeInBytes))

#+(or)(shadow "delete[]")

#+(or) (defmethod delete[] ((self CONE-TWIST-CONSTRAINT) ptr)
  (CONE-TWIST-CONSTRAINT/DELETE-c++-ARRAY (ff-pointer self) ptr))

#+(or)(shadow "new[]")

#+(or)#+(or) (defmethod new[] ((self CONE-TWIST-CONSTRAINT) arg1 ptr)
  (CONE-TWIST-CONSTRAINT/MAKE-c++-ARRAY (ff-pointer self) arg1 ptr))

#+(or)(shadow "delete[]")

#+(or) (defmethod delete[] ((self CONE-TWIST-CONSTRAINT) arg1 arg2)
  (CONE-TWIST-CONSTRAINT/DELETE-c++-ARRAY (ff-pointer self) arg1 arg2))

(defmethod initialize-instance :after ((obj CONE-TWIST-CONSTRAINT)
                                       &key rigid-body-a rigid-body-b
                                         rigid-body-a-frame rigid-body-b-frame)
  (check-type rigid-body-a RIGID-BODY)
  (check-type rigid-body-a-frame TRANSFORM)
  (setf (slot-value obj 'ff-pointer) 
        (cond
          (rigid-body-b
           (check-type rigid-body-b RIGID-BODY)
           (check-type rigid-body-b-frame TRANSFORM)
           (MAKE-CONE-TWIST-CONSTRAINT/with-b (ff-pointer rigid-body-a)
                                              (ff-pointer rigid-body-b) 
                                              (ff-pointer rigid-body-a-frame)
                                              (ff-pointer rigid-body-b-frame)))
          (t (MAKE-CONE-TWIST-CONSTRAINT (ff-pointer rigid-body-a) 
                                         (ff-pointer rigid-body-a-frame))))))

(defmethod BUILD-JACOBIAN ((self CONE-TWIST-CONSTRAINT))
  (CONE-TWIST-CONSTRAINT/BUILD-JACOBIAN (ff-pointer self)))

(defmethod INFO-1 ((self CONE-TWIST-CONSTRAINT) info)
  (CONE-TWIST-CONSTRAINT/GET-INFO-1 (ff-pointer self) info))

(defmethod INFO-1-NON-VIRTUAL ((self CONE-TWIST-CONSTRAINT) info)
  (CONE-TWIST-CONSTRAINT/GET-INFO-1-NON-VIRTUAL (ff-pointer self) info))

(defmethod INFO-2 ((self CONE-TWIST-CONSTRAINT) info)
  (CONE-TWIST-CONSTRAINT/GET-INFO-2 (ff-pointer self) info))

(defmethod INFO-2-NON-VIRTUAL-conic ((self CONE-TWIST-CONSTRAINT) info
                               (transA TRANSFORM) (transB TRANSFORM)
                               (invInertiaWorldA MATRIX-3X3)
                               (invInertiaWorldB MATRIX-3X3))
  (CONE-TWIST-CONSTRAINT/GET-INFO-2-NON-VIRTUAL (ff-pointer self) info transA transB invInertiaWorldA invInertiaWorldB))

(defmethod SOLVE-CONSTRAINT-OBSOLETE ((self CONE-TWIST-CONSTRAINT)
                                      bodyA bodyB (time-step number))
  (CONE-TWIST-CONSTRAINT/SOLVE-CONSTRAINT-OBSOLETE (ff-pointer self) bodyA bodyB time-step))

(defmethod UPDATE-RHS ((self CONE-TWIST-CONSTRAINT) (time-step number))
  (CONE-TWIST-CONSTRAINT/UPDATE-RHS (ff-pointer self) time-step))

(defmethod RIGID-BODY-A ((self CONE-TWIST-CONSTRAINT))
  (CONE-TWIST-CONSTRAINT/GET-RIGID-BODY-A (ff-pointer self)))

(defmethod RIGID-BODY-B ((self CONE-TWIST-CONSTRAINT))
  (CONE-TWIST-CONSTRAINT/GET-RIGID-BODY-B (ff-pointer self)))

(defmethod (SETF ANGULAR-ONLY-P) ( (angularOnly t) (self CONE-TWIST-CONSTRAINT))
  (CONE-TWIST-CONSTRAINT/SET-ANGULAR-ONLY (ff-pointer self) angularOnly))

(defmethod (SETF LIMIT-ELT) ((limit-Value number)
                             (self CONE-TWIST-CONSTRAINT) (limit-Index integer))
  (CONE-TWIST-CONSTRAINT/SET-LIMIT/elt (ff-pointer self) limit-Index limit-Value))

(defmethod (SETF cone-twist-LIMITS) ((self CONE-TWIST-CONSTRAINT)
                          (swing-Span-1 number)  (swing-Span-2 number)
                          (twist-Span number) (softness number)
                          (bias-factor number) (relaxation-factor number))
  (CONE-TWIST-CONSTRAINT/SET-LIMIT/with-swing&twist&softness&bias&relaxation
   (ff-pointer self) swing-Span-1 swing-Span-2
   twist-Span softness bias-factor relaxation-factor))

(defmethod (SETF cone-twist-limits) ((self CONE-TWIST-CONSTRAINT)
                          (swing-Span-1 number)  (swing-Span-2 number)
                          (twist-Span number) (softness number)
                          (bias-factor number) (relax null))
  (CONE-TWIST-CONSTRAINT/SET-LIMIT/with-swing&twist&softness&bias
   (ff-pointer self) swing-Span-1 swing-Span-2
                                   twist-Span softness bias-factor))

(defmethod (SETF cone-twist-limits) ((self CONE-TWIST-CONSTRAINT)
                          (swing-Span-1 number) (swing-Span-2 number) 
                          (twist-Span number) (softness number)
                                     (bias-factor null) (relaxation-factor null))
  (CONE-TWIST-CONSTRAINT/SET-LIMIT/with-swing&twist&softness
   (ff-pointer self) swing-Span-1 swing-Span-2 twist-Span softness))

(defmethod (SETF cone-twist-limits) ((self CONE-TWIST-CONSTRAINT)
                          (swing-Span-1 number)  (swing-Span-2 number) (twist-Span number)
                                     (softness null) (bias-factor null) (relaxation-factor null))
  (CONE-TWIST-CONSTRAINT/SET-LIMIT/with-swing&twist
   (ff-pointer self) swing-Span-1 swing-Span-2 twist-Span))

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

(defmethod CALC-ANGLE-INFO-2 ((self CONE-TWIST-CONSTRAINT) (transA TRANSFORM) (transB TRANSFORM) (invInertiaWorldA MATRIX-3X3) (invInertiaWorldB MATRIX-3X3))
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

(defmethod (SETF DAMPING) ( (damping number) (self CONE-TWIST-CONSTRAINT))
  (CONE-TWIST-CONSTRAINT/SET-DAMPING (ff-pointer self) damping))

(defmethod (SETF MOTOR-ENABLED-P) ( (b t) (self CONE-TWIST-CONSTRAINT))
  (CONE-TWIST-CONSTRAINT/ENABLE-MOTOR (ff-pointer self) b))

(defmethod (SETF MAX-MOTOR-IMPULSE) ( (maxMotorImpulse number) (self CONE-TWIST-CONSTRAINT))
  (CONE-TWIST-CONSTRAINT/SET-MAX-MOTOR-IMPULSE (ff-pointer self) maxMotorImpulse))

(defmethod (SETF MAX-MOTOR-IMPULSE-NORMALIZED) ( (maxMotorImpulse number) (self CONE-TWIST-CONSTRAINT))
  (CONE-TWIST-CONSTRAINT/SET-MAX-MOTOR-IMPULSE-NORMALIZED (ff-pointer self) maxMotorImpulse))

(defmethod FIX-THRESH ((self CONE-TWIST-CONSTRAINT))
  (CONE-TWIST-CONSTRAINT/GET-FIX-THRESH (ff-pointer self)))

(defmethod (SETF FIX-THRESH) ( (fixThresh number) (self CONE-TWIST-CONSTRAINT))
  (CONE-TWIST-CONSTRAINT/SET-FIX-THRESH (ff-pointer self) fixThresh))

(defmethod (SETF CONE-MOTOR-TARGET) ( (q QUATERNION) (self CONE-TWIST-CONSTRAINT))
  (CONE-TWIST-CONSTRAINT/SET-MOTOR-TARGET (ff-pointer self) q))

(defmethod (SETF MOTOR-TARGET-IN-CONSTRAINT-SPACE) ( (q QUATERNION) (self CONE-TWIST-CONSTRAINT))
  (CONE-TWIST-CONSTRAINT/SET-MOTOR-TARGET-IN-CONSTRAINT-SPACE (ff-pointer self) q))

(defmethod POINT-FOR-ANGLE ((self CONE-TWIST-CONSTRAINT) (fAngleInRadians number) (fLength number))
  (CONE-TWIST-CONSTRAINT/GET-POINT-FOR-ANGLE (ff-pointer self) fAngleInRadians fLength))

(defmethod FRAME-OFFSET-A ((self CONE-TWIST-CONSTRAINT))
  (CONE-TWIST-CONSTRAINT/GET-FRAME-OFFSET-A (ff-pointer self)))

(defmethod FRAME-OFFSET-B ((self CONE-TWIST-CONSTRAINT))
  (CONE-TWIST-CONSTRAINT/GET-FRAME-OFFSET-B (ff-pointer self)))

(defmethod CALCULATE-SERIALIZE-BUFFER-SIZE ((self CONE-TWIST-CONSTRAINT))
  (CONE-TWIST-CONSTRAINT/CALCULATE-SERIALIZE-BUFFER-SIZE (ff-pointer self)))

(defmethod ->serial ((self CONE-TWIST-CONSTRAINT)&key data-buffer serializer &allow-other-keys)
    (check-type serializer serializer)
    (CONE-TWIST-CONSTRAINT/SERIALIZE (ff-pointer self) data-buffer 
                                     (ff-pointer serializer)))


(defmethod (setf LO-LIMIT) ( (obj ROTATIONAL-LIMIT-MOTOR) arg0)
  (ROTATIONAL-LIMIT-MOTOR/LO-LIMIT/SET (ff-pointer obj) arg0))

(defmethod LO-LIMIT ((obj ROTATIONAL-LIMIT-MOTOR))
  (ROTATIONAL-LIMIT-MOTOR/LO-LIMIT/GET (ff-pointer obj)))

(defmethod (setf HI-LIMIT) ( (obj ROTATIONAL-LIMIT-MOTOR) arg0)
  (ROTATIONAL-LIMIT-MOTOR/HI-LIMIT/SET (ff-pointer obj) arg0))

(defmethod HI-LIMIT ((obj ROTATIONAL-LIMIT-MOTOR))
  (ROTATIONAL-LIMIT-MOTOR/HI-LIMIT/GET (ff-pointer obj)))

(defmethod (setf TARGET-VELOCITY) ( (obj ROTATIONAL-LIMIT-MOTOR) arg0)
  (ROTATIONAL-LIMIT-MOTOR/TARGET-VELOCITY/SET (ff-pointer obj) arg0))

(defmethod TARGET-VELOCITY ((obj ROTATIONAL-LIMIT-MOTOR))
  (ROTATIONAL-LIMIT-MOTOR/TARGET-VELOCITY/GET (ff-pointer obj)))

(defmethod (setf MAX-MOTOR-FORCE) ( (obj ROTATIONAL-LIMIT-MOTOR) arg0)
  (ROTATIONAL-LIMIT-MOTOR/MAX-MOTOR-FORCE/SET (ff-pointer obj) arg0))

(defmethod MAX-MOTOR-FORCE ((obj ROTATIONAL-LIMIT-MOTOR))
  (ROTATIONAL-LIMIT-MOTOR/MAX-MOTOR-FORCE/GET (ff-pointer obj)))

(defmethod (setf MAX-LIMIT-FORCE) ( (obj ROTATIONAL-LIMIT-MOTOR) arg0)
  (ROTATIONAL-LIMIT-MOTOR/MAX-LIMIT-FORCE/SET (ff-pointer obj) arg0))

(defmethod MAX-LIMIT-FORCE ((obj ROTATIONAL-LIMIT-MOTOR))
  (ROTATIONAL-LIMIT-MOTOR/MAX-LIMIT-FORCE/GET (ff-pointer obj)))

(defmethod (setf DAMPING) ( (obj ROTATIONAL-LIMIT-MOTOR) arg0)
  (ROTATIONAL-LIMIT-MOTOR/DAMPING/SET (ff-pointer obj) arg0))

(defmethod DAMPING ((obj ROTATIONAL-LIMIT-MOTOR))
  (ROTATIONAL-LIMIT-MOTOR/DAMPING/GET (ff-pointer obj)))

(defmethod (setf LIMIT-SOFTNESS) ( (obj ROTATIONAL-LIMIT-MOTOR) arg0)
  (ROTATIONAL-LIMIT-MOTOR/LIMIT-SOFTNESS/SET (ff-pointer obj) arg0))

(defmethod LIMIT-SOFTNESS ((obj ROTATIONAL-LIMIT-MOTOR))
  (ROTATIONAL-LIMIT-MOTOR/LIMIT-SOFTNESS/GET (ff-pointer obj)))

(defmethod (setf NORMAL-CFM) ( (obj ROTATIONAL-LIMIT-MOTOR) arg0)
  (ROTATIONAL-LIMIT-MOTOR/NORMAL-CFM/SET (ff-pointer obj) arg0))

(defmethod NORMAL-CFM ((obj ROTATIONAL-LIMIT-MOTOR))
  (ROTATIONAL-LIMIT-MOTOR/NORMAL-CFM/GET (ff-pointer obj)))

(defmethod (setf STOP-ERP) ( (obj ROTATIONAL-LIMIT-MOTOR) arg0)
  (ROTATIONAL-LIMIT-MOTOR/STOP-ERP/SET (ff-pointer obj) arg0))

(defmethod STOP-ERP ((obj ROTATIONAL-LIMIT-MOTOR))
  (ROTATIONAL-LIMIT-MOTOR/STOP-ERP/GET (ff-pointer obj)))

(defmethod (setf STOP-CFM) ( (obj ROTATIONAL-LIMIT-MOTOR) arg0)
  (ROTATIONAL-LIMIT-MOTOR/STOP-CFM/SET (ff-pointer obj) arg0))

(defmethod STOP-CFM ((obj ROTATIONAL-LIMIT-MOTOR))
  (ROTATIONAL-LIMIT-MOTOR/STOP-CFM/GET (ff-pointer obj)))

(defmethod (setf BOUNCE) ( (obj ROTATIONAL-LIMIT-MOTOR) arg0)
  (ROTATIONAL-LIMIT-MOTOR/BOUNCE/SET (ff-pointer obj) arg0))

(defmethod BOUNCE ((obj ROTATIONAL-LIMIT-MOTOR))
  (ROTATIONAL-LIMIT-MOTOR/BOUNCE/GET (ff-pointer obj)))

(defmethod (setf MOTOR-ENABLED-P) (arg0 (obj ROTATIONAL-LIMIT-MOTOR))
  (ROTATIONAL-LIMIT-MOTOR/ENABLE-MOTOR/SET (ff-pointer obj) arg0))

(defmethod MOTOR-ENABLED-P ((obj ROTATIONAL-LIMIT-MOTOR))
  (ROTATIONAL-LIMIT-MOTOR/ENABLE-MOTOR/GET (ff-pointer obj)))

(defmethod (setf CURRENT-LIMIT-ERROR) ( (obj ROTATIONAL-LIMIT-MOTOR) arg0)
  (ROTATIONAL-LIMIT-MOTOR/CURRENT-LIMIT-ERROR/SET (ff-pointer obj) arg0))

(defmethod CURRENT-LIMIT-ERROR ((obj ROTATIONAL-LIMIT-MOTOR))
  (ROTATIONAL-LIMIT-MOTOR/CURRENT-LIMIT-ERROR/GET (ff-pointer obj)))

(defmethod (setf CURRENT-POSITION) ( (obj ROTATIONAL-LIMIT-MOTOR) arg0)
  (ROTATIONAL-LIMIT-MOTOR/CURRENT-POSITION/SET (ff-pointer obj) arg0))

(defmethod CURRENT-POSITION ((obj ROTATIONAL-LIMIT-MOTOR))
  (ROTATIONAL-LIMIT-MOTOR/CURRENT-POSITION/GET (ff-pointer obj)))

(defmethod (setf CURRENT-LIMIT) ( (obj ROTATIONAL-LIMIT-MOTOR) arg0)
  (ROTATIONAL-LIMIT-MOTOR/CURRENT-LIMIT/SET (ff-pointer obj) arg0))

(defmethod CURRENT-LIMIT ((obj ROTATIONAL-LIMIT-MOTOR))
  (ROTATIONAL-LIMIT-MOTOR/CURRENT-LIMIT/GET (ff-pointer obj)))

(defmethod (setf ACCUMULATED-IMPULSE) ( (obj ROTATIONAL-LIMIT-MOTOR) arg0)
  (ROTATIONAL-LIMIT-MOTOR/ACCUMULATED-IMPULSE/SET (ff-pointer obj) arg0))

(defmethod ACCUMULATED-IMPULSE ((obj ROTATIONAL-LIMIT-MOTOR))
  (ROTATIONAL-LIMIT-MOTOR/ACCUMULATED-IMPULSE/GET (ff-pointer obj)))

(defmethod initialize-instance :after ((obj ROTATIONAL-LIMIT-MOTOR) &key)
  (setf (slot-value obj 'ff-pointer) (MAKE-ROTATIONAL-LIMIT-MOTOR)))

(defmethod initialize-instance :after ((obj ROTATIONAL-LIMIT-MOTOR) 
                                       &key limot)
  (check-type limot ROTATIONAL-LIMIT-MOTOR)
  (setf (slot-value obj 'ff-pointer) 
        (MAKE-ROTATIONAL-LIMIT-MOTOR/with-limot (ff-pointer limot))))

(defmethod LIMITEDP ((self ROTATIONAL-LIMIT-MOTOR))
  (ROTATIONAL-LIMIT-MOTOR/IS-LIMITED (ff-pointer self)))

(defmethod NEED-APPLY-TORQUES ((self ROTATIONAL-LIMIT-MOTOR))
  (ROTATIONAL-LIMIT-MOTOR/NEED-APPLY-TORQUES (ff-pointer self)))

(defmethod TEST-LIMIT-VALUE ((self ROTATIONAL-LIMIT-MOTOR) (test_value number))
  (ROTATIONAL-LIMIT-MOTOR/TEST-LIMIT-VALUE (ff-pointer self) test_value))

(defmethod SOLVE-ANGULAR-LIMITS ((self ROTATIONAL-LIMIT-MOTOR) (time-step number) (axis VECTOR3) (jacDiagABInv number) (body0 RIGID-BODY) (body1 RIGID-BODY))
  (ROTATIONAL-LIMIT-MOTOR/SOLVE-ANGULAR-LIMITS (ff-pointer self) time-step axis jacDiagABInv body0 body1))


(defmethod (setf LOWER-LIMIT) ( (obj TRANSLATIONAL-LIMIT-MOTOR) arg0)
  (TRANSLATIONAL-LIMIT-MOTOR/LOWER-LIMIT/SET (ff-pointer obj) arg0))

(defmethod LOWER-LIMIT ((obj TRANSLATIONAL-LIMIT-MOTOR))
  (TRANSLATIONAL-LIMIT-MOTOR/LOWER-LIMIT/GET (ff-pointer obj)))

(defmethod (setf UPPER-LIMIT) ( (obj TRANSLATIONAL-LIMIT-MOTOR) arg0)
  (TRANSLATIONAL-LIMIT-MOTOR/UPPER-LIMIT/SET (ff-pointer obj) arg0))

(defmethod UPPER-LIMIT ((obj TRANSLATIONAL-LIMIT-MOTOR))
  (TRANSLATIONAL-LIMIT-MOTOR/UPPER-LIMIT/GET (ff-pointer obj)))

(defmethod (setf ACCUMULATED-IMPULSE) ( (obj TRANSLATIONAL-LIMIT-MOTOR) arg0)
  (TRANSLATIONAL-LIMIT-MOTOR/ACCUMULATED-IMPULSE/SET (ff-pointer obj) arg0))

(defmethod ACCUMULATED-IMPULSE ((obj TRANSLATIONAL-LIMIT-MOTOR))
  (TRANSLATIONAL-LIMIT-MOTOR/ACCUMULATED-IMPULSE/GET (ff-pointer obj)))

(defmethod (setf LIMIT-SOFTNESS) ( (obj TRANSLATIONAL-LIMIT-MOTOR) arg0)
  (TRANSLATIONAL-LIMIT-MOTOR/LIMIT-SOFTNESS/SET (ff-pointer obj) arg0))

(defmethod LIMIT-SOFTNESS ((obj TRANSLATIONAL-LIMIT-MOTOR))
  (TRANSLATIONAL-LIMIT-MOTOR/LIMIT-SOFTNESS/GET (ff-pointer obj)))

(defmethod (setf DAMPING) ( (obj TRANSLATIONAL-LIMIT-MOTOR) arg0)
  (TRANSLATIONAL-LIMIT-MOTOR/DAMPING/SET (ff-pointer obj) arg0))

(defmethod DAMPING ((obj TRANSLATIONAL-LIMIT-MOTOR))
  (TRANSLATIONAL-LIMIT-MOTOR/DAMPING/GET (ff-pointer obj)))

(defmethod (setf RESTITUTION) ( (obj TRANSLATIONAL-LIMIT-MOTOR) arg0)
  (TRANSLATIONAL-LIMIT-MOTOR/RESTITUTION/SET (ff-pointer obj) arg0))

(defmethod RESTITUTION ((obj TRANSLATIONAL-LIMIT-MOTOR))
  (TRANSLATIONAL-LIMIT-MOTOR/RESTITUTION/GET (ff-pointer obj)))

(defmethod (setf NORMAL-CFM) ( (obj TRANSLATIONAL-LIMIT-MOTOR) arg0)
  (TRANSLATIONAL-LIMIT-MOTOR/NORMAL-CFM/SET (ff-pointer obj) arg0))

(defmethod NORMAL-CFM ((obj TRANSLATIONAL-LIMIT-MOTOR))
  (TRANSLATIONAL-LIMIT-MOTOR/NORMAL-CFM/GET (ff-pointer obj)))

(defmethod (setf STOP-ERP) ( (obj TRANSLATIONAL-LIMIT-MOTOR) arg0)
  (TRANSLATIONAL-LIMIT-MOTOR/STOP-ERP/SET (ff-pointer obj) arg0))

(defmethod STOP-ERP ((obj TRANSLATIONAL-LIMIT-MOTOR))
  (TRANSLATIONAL-LIMIT-MOTOR/STOP-ERP/GET (ff-pointer obj)))

(defmethod (setf STOP-CFM) ( (obj TRANSLATIONAL-LIMIT-MOTOR) arg0)
  (TRANSLATIONAL-LIMIT-MOTOR/STOP-CFM/SET (ff-pointer obj) arg0))

(defmethod STOP-CFM ((obj TRANSLATIONAL-LIMIT-MOTOR))
  (TRANSLATIONAL-LIMIT-MOTOR/STOP-CFM/GET (ff-pointer obj)))

(defmethod (setf MOTOR-ENABLED-P) ( arg0 (obj TRANSLATIONAL-LIMIT-MOTOR) )
  (TRANSLATIONAL-LIMIT-MOTOR/ENABLE-MOTOR/SET (ff-pointer obj) arg0))

(defmethod MOTOR-ENABLED-P ((obj TRANSLATIONAL-LIMIT-MOTOR))
  (TRANSLATIONAL-LIMIT-MOTOR/ENABLE-MOTOR/GET (ff-pointer obj)))

(defmethod (setf TARGET-VELOCITY) ( (obj TRANSLATIONAL-LIMIT-MOTOR) arg0)
  (TRANSLATIONAL-LIMIT-MOTOR/TARGET-VELOCITY/SET (ff-pointer obj) arg0))

(defmethod TARGET-VELOCITY ((obj TRANSLATIONAL-LIMIT-MOTOR))
  (TRANSLATIONAL-LIMIT-MOTOR/TARGET-VELOCITY/GET (ff-pointer obj)))

(defmethod (setf MAX-MOTOR-FORCE) ( (obj TRANSLATIONAL-LIMIT-MOTOR) arg0)
  (TRANSLATIONAL-LIMIT-MOTOR/MAX-MOTOR-FORCE/SET (ff-pointer obj) arg0))

(defmethod MAX-MOTOR-FORCE ((obj TRANSLATIONAL-LIMIT-MOTOR))
  (TRANSLATIONAL-LIMIT-MOTOR/MAX-MOTOR-FORCE/GET (ff-pointer obj)))

(defmethod (setf CURRENT-LIMIT-ERROR) ( (obj TRANSLATIONAL-LIMIT-MOTOR) arg0)
  (TRANSLATIONAL-LIMIT-MOTOR/CURRENT-LIMIT-ERROR/SET (ff-pointer obj) arg0))

(defmethod CURRENT-LIMIT-ERROR ((obj TRANSLATIONAL-LIMIT-MOTOR))
  (TRANSLATIONAL-LIMIT-MOTOR/CURRENT-LIMIT-ERROR/GET (ff-pointer obj)))

(defmethod (setf CURRENT-LINEAR-DIFF) ( (obj TRANSLATIONAL-LIMIT-MOTOR) arg0)
  (TRANSLATIONAL-LIMIT-MOTOR/CURRENT-LINEAR-DIFF/SET (ff-pointer obj) arg0))

(defmethod CURRENT-LINEAR-DIFF ((obj TRANSLATIONAL-LIMIT-MOTOR))
  (TRANSLATIONAL-LIMIT-MOTOR/CURRENT-LINEAR-DIFF/GET (ff-pointer obj)))

(defmethod (setf CURRENT-LIMIT) ( (obj TRANSLATIONAL-LIMIT-MOTOR) arg0)
  (TRANSLATIONAL-LIMIT-MOTOR/CURRENT-LIMIT/SET (ff-pointer obj) arg0))

(defmethod CURRENT-LIMIT ((obj TRANSLATIONAL-LIMIT-MOTOR))
  (TRANSLATIONAL-LIMIT-MOTOR/CURRENT-LIMIT/GET (ff-pointer obj)))

(defmethod initialize-instance :after ((obj TRANSLATIONAL-LIMIT-MOTOR) 
                                       &key other)
  (check-type other (or null translational-limit-motor))
  (setf (slot-value obj 'ff-pointer) 
        (if other 
         (MAKE-TRANSLATIONAL-LIMIT-MOTOR/WITH-OTHER (ff-pointer other))
         (MAKE-TRANSLATIONAL-LIMIT-MOTOR))))

(defmethod ELT-LIMITED-P ((self TRANSLATIONAL-LIMIT-MOTOR) (limitIndex integer))
  (TRANSLATIONAL-LIMIT-MOTOR/IS-LIMITED (ff-pointer self) limitIndex))

(defmethod NEED-APPLY-FORCE ((self TRANSLATIONAL-LIMIT-MOTOR) (limitIndex integer))
  (TRANSLATIONAL-LIMIT-MOTOR/NEED-APPLY-FORCE (ff-pointer self) limitIndex))

(defmethod TEST-ELT-LIMIT-VALUE ((self TRANSLATIONAL-LIMIT-MOTOR) (limitIndex integer) (test_value number))
  (TRANSLATIONAL-LIMIT-MOTOR/TEST-LIMIT-VALUE (ff-pointer self) limitIndex test_value))

(defmethod SOLVE-LINEAR-AXIS ((self TRANSLATIONAL-LIMIT-MOTOR) (time-step number) (jacDiagABInv number) (body1 RIGID-BODY) (pointInA VECTOR3) (body2 RIGID-BODY) (pointInB VECTOR3) (limit_index integer) (axis_normal_on_a VECTOR3) (anchorPos VECTOR3))
  (TRANSLATIONAL-LIMIT-MOTOR/SOLVE-LINEAR-AXIS (ff-pointer self) time-step jacDiagABInv body1 pointInA body2 pointInB limit_index axis_normal_on_a anchorPos))


#+(or) (defmethod new ((self GENERIC-6-DOF-CONSTRAINT) sizeInBytes)
  (GENERIC-6-DOF-CONSTRAINT/MAKE-c++-INSTANCE (ff-pointer self) sizeInBytes))

#+(or) (defmethod bullet/delete ((self GENERIC-6-DOF-CONSTRAINT) ptr)
  (GENERIC-6-DOF-CONSTRAINT/DELETE-c++-INSTANCE (ff-pointer self) ptr))

#+(or) (defmethod new ((self GENERIC-6-DOF-CONSTRAINT) arg1 ptr)
        (GENERIC-6-DOF-CONSTRAINT/MAKE-c++-INSTANCE (ff-pointer self) arg1 ptr))

#+(or) (defmethod bullet/delete ((self GENERIC-6-DOF-CONSTRAINT) arg1 arg2)
  (GENERIC-6-DOF-CONSTRAINT/DELETE-c++-INSTANCE (ff-pointer self) arg1 arg2))

#+(or)(shadow "new[]")

#+(or)#+(or) (defmethod new[] ((self GENERIC-6-DOF-CONSTRAINT) sizeInBytes)
  (GENERIC-6-DOF-CONSTRAINT/MAKE-c++-ARRAY (ff-pointer self) sizeInBytes))

#+(or)(shadow "delete[]")

#+(or) (defmethod delete[] ((self GENERIC-6-DOF-CONSTRAINT) ptr)
  (GENERIC-6-DOF-CONSTRAINT/DELETE-c++-ARRAY (ff-pointer self) ptr))

#+(or)(shadow "new[]")

#+(or)#+(or) (defmethod new[] ((self GENERIC-6-DOF-CONSTRAINT) arg1 ptr)
  (GENERIC-6-DOF-CONSTRAINT/MAKE-c++-ARRAY (ff-pointer self) arg1 ptr))

#+(or)(shadow "delete[]")

#+(or) (defmethod delete[] ((self GENERIC-6-DOF-CONSTRAINT) arg1 arg2)
  (GENERIC-6-DOF-CONSTRAINT/DELETE-c++-ARRAY (ff-pointer self) arg1 arg2))

(defmethod (setf USE-SOLVE-CONSTRAINT-OBSOLETE) ( (obj GENERIC-6-DOF-CONSTRAINT) arg0)
  (GENERIC-6-DOF-CONSTRAINT/USE-SOLVE-CONSTRAINT-OBSOLETE/SET (ff-pointer obj) arg0))

(defmethod USE-SOLVE-CONSTRAINT-OBSOLETE ((obj GENERIC-6-DOF-CONSTRAINT))
  (GENERIC-6-DOF-CONSTRAINT/USE-SOLVE-CONSTRAINT-OBSOLETE/GET (ff-pointer obj)))

(defmethod initialize-instance :after ((obj generic-6-dof-constraint)
                                       &key
                                         rigid-body-a rigid-body-b
                                         frame-in-a frame-in-b
                                         (use-linear-reference-frame-a-p nil use-a?)
                                         (use-linear-reference-frame-b-p nil use-b?))
  (check-type rigid-body-b rigid-body) 
  (check-type frame-in-b transform)
  (setf (slot-value obj 'ff-pointer)
        (cond
          (use-a?
           (check-type rigid-body-a rigid-body) 
           (check-type frame-in-a transform) 
           (make-generic-6-dof-constraint (ff-pointer rigid-body-a) 
                                          (ff-pointer rigid-body-b) 
                                          (ff-pointer frame-in-a) 
                                          (ff-pointer frame-in-b)
                                          use-linear-reference-frame-a-p))
          (use-b?
           (make-generic-6-dof-constraint/with-linear-reference-frame-b
            (ff-pointer rigid-body-b) (ff-pointer frame-in-b)
            use-linear-reference-frame-b-p))
          (t (error 'foo)))))

(defmethod CALCULATE-TRANSFORMS/A+B ((self GENERIC-6-DOF-CONSTRAINT) (transA TRANSFORM) (transB TRANSFORM))
  (GENERIC-6-DOF-CONSTRAINT/CALCULATE-TRANSFORMS (ff-pointer self) transA transB))

(defmethod CALCULATE-TRANSFORMS ((self GENERIC-6-DOF-CONSTRAINT))
  (GENERIC-6-DOF-CONSTRAINT/CALCULATE-TRANSFORMS/naked (ff-pointer self)))

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

(defmethod INFO-2-NON-VIRTUAL-generic-6-dof ((self GENERIC-6-DOF-CONSTRAINT) info
                               (transA TRANSFORM) (transB TRANSFORM)
                               (linear-velocity-A VECTOR3) (linear-velocity-B VECTOR3)
                               (angVelA VECTOR3) (angVelB VECTOR3))
  (GENERIC-6-DOF-CONSTRAINT/GET-INFO-2-NON-VIRTUAL (ff-pointer self) info transA transB linear-velocity-A linear-velocity-B angVelA angVelB))

(defmethod UPDATE-RHS ((self GENERIC-6-DOF-CONSTRAINT) (time-step number))
  (GENERIC-6-DOF-CONSTRAINT/UPDATE-RHS (ff-pointer self) time-step))

(defmethod AXIS-ELT ((self GENERIC-6-DOF-CONSTRAINT) (axis_index integer))
  (GENERIC-6-DOF-CONSTRAINT/GET-AXIS (ff-pointer self) axis_index))

(defmethod ANGLE-ELT ((self GENERIC-6-DOF-CONSTRAINT) (axis_index integer))
  (GENERIC-6-DOF-CONSTRAINT/GET-ANGLE (ff-pointer self) axis_index))

(defmethod RELATIVE-PIVOT-POSITION ((self GENERIC-6-DOF-CONSTRAINT) (axis_index integer))
  (GENERIC-6-DOF-CONSTRAINT/GET-RELATIVE-PIVOT-POSITION (ff-pointer self) axis_index))

(defmethod (SETF FRAMES) ( (frameA TRANSFORM) (self GENERIC-6-DOF-CONSTRAINT) (frameB TRANSFORM))
  (GENERIC-6-DOF-CONSTRAINT/SET-FRAMES (ff-pointer self) frameA frameB))

(defmethod TEST-ANGULAR-LIMIT-MOTOR ((self GENERIC-6-DOF-CONSTRAINT) (axis_index integer))
  (GENERIC-6-DOF-CONSTRAINT/TEST-ANGULAR-LIMIT-MOTOR (ff-pointer self) axis_index))

(defmethod (SETF LINEAR-LOWER-LIMIT) ( (linearLower VECTOR3) (self GENERIC-6-DOF-CONSTRAINT))
  (GENERIC-6-DOF-CONSTRAINT/SET-LINEAR-LOWER-LIMIT (ff-pointer self) linearLower))

(defmethod LINEAR-LOWER-LIMIT ((self GENERIC-6-DOF-CONSTRAINT) (linearLower VECTOR3))
  (GENERIC-6-DOF-CONSTRAINT/GET-LINEAR-LOWER-LIMIT (ff-pointer self) linearLower))

(defmethod (SETF LINEAR-UPPER-LIMIT) ( (linearUpper VECTOR3) (self GENERIC-6-DOF-CONSTRAINT))
  (GENERIC-6-DOF-CONSTRAINT/SET-LINEAR-UPPER-LIMIT (ff-pointer self) linearUpper))

(defmethod LINEAR-UPPER-LIMIT ((self GENERIC-6-DOF-CONSTRAINT) (linearUpper VECTOR3))
  (GENERIC-6-DOF-CONSTRAINT/GET-LINEAR-UPPER-LIMIT (ff-pointer self) linearUpper))

(defmethod (SETF ANGULAR-LOWER-LIMIT) ( (angularLower VECTOR3) (self GENERIC-6-DOF-CONSTRAINT))
  (GENERIC-6-DOF-CONSTRAINT/SET-ANGULAR-LOWER-LIMIT (ff-pointer self) angularLower))

(defmethod ANGULAR-LOWER-LIMIT ((self GENERIC-6-DOF-CONSTRAINT) (angularLower VECTOR3))
  (GENERIC-6-DOF-CONSTRAINT/GET-ANGULAR-LOWER-LIMIT (ff-pointer self) angularLower))

(defmethod (SETF ANGULAR-UPPER-LIMIT) ( (angularUpper VECTOR3) (self GENERIC-6-DOF-CONSTRAINT))
  (GENERIC-6-DOF-CONSTRAINT/SET-ANGULAR-UPPER-LIMIT (ff-pointer self) angularUpper))

(defmethod ANGULAR-UPPER-LIMIT ((self GENERIC-6-DOF-CONSTRAINT) (angularUpper VECTOR3))
  (GENERIC-6-DOF-CONSTRAINT/GET-ANGULAR-UPPER-LIMIT (ff-pointer self) angularUpper))

(defmethod ROTATIONAL-LIMIT-MOTOR ((self GENERIC-6-DOF-CONSTRAINT) (index integer))
  (GENERIC-6-DOF-CONSTRAINT/GET-ROTATIONAL-LIMIT-MOTOR (ff-pointer self) index))

(defmethod TRANSLATIONAL-LIMIT-MOTOR ((self GENERIC-6-DOF-CONSTRAINT))
  (GENERIC-6-DOF-CONSTRAINT/GET-TRANSLATIONAL-LIMIT-MOTOR (ff-pointer self)))

(defmethod (SETF LIMIT) ( (axis integer) (self GENERIC-6-DOF-CONSTRAINT) (lo number) (hi number))
  (GENERIC-6-DOF-CONSTRAINT/SET-LIMIT (ff-pointer self) axis lo hi))

(defmethod ELT-LIMITED-P ((self GENERIC-6-DOF-CONSTRAINT) (limitIndex integer))
  (GENERIC-6-DOF-CONSTRAINT/IS-LIMITED (ff-pointer self) limitIndex))

(defmethod CALC-ANCHOR-POS ((self GENERIC-6-DOF-CONSTRAINT))
  (GENERIC-6-DOF-CONSTRAINT/CALC-ANCHOR-POS (ff-pointer self)))

(defmethod LIMIT-MOTOR-INFO-2+ ((self GENERIC-6-DOF-CONSTRAINT) (limot ROTATIONAL-LIMIT-MOTOR) (transA TRANSFORM) (transB TRANSFORM) (linear-velocity-A VECTOR3) (linear-velocity-B VECTOR3) (angVelA VECTOR3) (angVelB VECTOR3) info (row integer) (ax1 VECTOR3) (rotational integer) (rotAllowed integer))
  (GENERIC-6-DOF-CONSTRAINT/GET/LIMIT/MOTOR/INFO-2 (ff-pointer self) limot transA transB linear-velocity-A linear-velocity-B angVelA angVelB info row ax1 rotational rotAllowed))

(defmethod LIMIT-MOTOR-INFO-2 ((self GENERIC-6-DOF-CONSTRAINT) (limot ROTATIONAL-LIMIT-MOTOR) (transA TRANSFORM) (transB TRANSFORM) (linear-velocity-A VECTOR3) (linear-velocity-B VECTOR3) (angVelA VECTOR3) (angVelB VECTOR3) info (row integer) (ax1 VECTOR3) (rotational integer))
  (GENERIC-6-DOF-CONSTRAINT/GET/LIMIT/MOTOR/INFO-2 (ff-pointer self) limot transA transB linear-velocity-A linear-velocity-B angVelA angVelB info row ax1 rotational))

(defmethod USE-FRAME-OFFSET ((self GENERIC-6-DOF-CONSTRAINT))
  (GENERIC-6-DOF-CONSTRAINT/GET-USE-FRAME-OFFSET (ff-pointer self)))

(defmethod (SETF USE-FRAME-OFFSET) ( (frameOffsetOnOff t) (self GENERIC-6-DOF-CONSTRAINT))
  (GENERIC-6-DOF-CONSTRAINT/SET-USE-FRAME-OFFSET (ff-pointer self) frameOffsetOnOff))

(defmethod (SETF AXES) ((self GENERIC-6-DOF-CONSTRAINT) (axis1 VECTOR3) (axis2 VECTOR3))
  (GENERIC-6-DOF-CONSTRAINT/SET-AXIS (ff-pointer self) axis1 axis2))

(defmethod CALCULATE-SERIALIZE-BUFFER-SIZE ((self GENERIC-6-DOF-CONSTRAINT))
  (GENERIC-6-DOF-CONSTRAINT/CALCULATE-SERIALIZE-BUFFER-SIZE (ff-pointer self)))

(defmethod ->serial ((self GENERIC-6-DOF-CONSTRAINT)&key data-buffer serializer &allow-other-keys)
    (check-type serializer serializer)
    (GENERIC-6-DOF-CONSTRAINT/SERIALIZE (ff-pointer self) data-buffer 
                                        (ff-pointer serializer)))


#+(or) (defmethod new ((self SLIDER-CONSTRAINT) sizeInBytes)
  (SLIDER-CONSTRAINT/MAKE-c++-INSTANCE (ff-pointer self) sizeInBytes))

#+(or) (defmethod bullet/delete ((self SLIDER-CONSTRAINT) ptr)
  (SLIDER-CONSTRAINT/DELETE-c++-INSTANCE (ff-pointer self) ptr))

#+(or) (defmethod new ((self SLIDER-CONSTRAINT) arg1 ptr)
  (SLIDER-CONSTRAINT/MAKE-c++-INSTANCE (ff-pointer self) arg1 ptr))

#+(or) (defmethod bullet/delete ((self SLIDER-CONSTRAINT) arg1 arg2)
  (SLIDER-CONSTRAINT/DELETE-c++-INSTANCE (ff-pointer self) arg1 arg2))

#+(or) (defmethod new[] ((self SLIDER-CONSTRAINT) sizeInBytes)
  (SLIDER-CONSTRAINT/MAKE-c++-ARRAY (ff-pointer self) sizeInBytes))

#+(or) (defmethod delete[] ((self SLIDER-CONSTRAINT) ptr)
  (SLIDER-CONSTRAINT/DELETE-c++-ARRAY (ff-pointer self) ptr))



#+(or) (defmethod new[] ((self SLIDER-CONSTRAINT) arg1 ptr)
  (SLIDER-CONSTRAINT/MAKE-c++-ARRAY (ff-pointer self) arg1 ptr))



#+(or) (defmethod delete[] ((self SLIDER-CONSTRAINT) arg1 arg2)
  (SLIDER-CONSTRAINT/DELETE-c++-ARRAY (ff-pointer self) arg1 arg2))

#+TODO
(defmethod initialize-instance :after ((obj SLIDER-CONSTRAINT) &key (rigid-body-a RIGID-BODY) (rigid-body-b RIGID-BODY) (frame-in-a TRANSFORM) (frame-in-b TRANSFORM) (USE-LINEAR-REFERENCE-FRAME-A-P t))
  (setf (slot-value obj 'ff-pointer) (MAKE-SLIDER-CONSTRAINT rigid-body-a rigid-body-b frame-in-a frame-in-b USE-LINEAR-REFERENCE-FRAME-A-P)))

#+TODO
(defmethod initialize-instance :after ((obj SLIDER-CONSTRAINT) &key (rigid-body-b RIGID-BODY) (frame-in-b TRANSFORM) (USE-LINEAR-REFERENCE-FRAME-A-P t))
  (setf (slot-value obj 'ff-pointer) (MAKE-SLIDER-CONSTRAINT rigid-body-b frame-in-b USE-LINEAR-REFERENCE-FRAME-A-P)))

(defmethod INFO-1 ((self SLIDER-CONSTRAINT) info)
  (SLIDER-CONSTRAINT/GET-INFO-1 (ff-pointer self) info))

(defmethod INFO-1-NON-VIRTUAL ((self SLIDER-CONSTRAINT) info)
  (SLIDER-CONSTRAINT/GET-INFO-1-NON-VIRTUAL (ff-pointer self) info))

(defmethod INFO-2 ((self SLIDER-CONSTRAINT) info)
  (SLIDER-CONSTRAINT/GET-INFO-2 (ff-pointer self) info))

(defmethod INFO-2-NON-VIRTUAL/slider ((self SLIDER-CONSTRAINT) info (transA TRANSFORM) (transB TRANSFORM) (linear-velocity-A VECTOR3) (linear-velocity-B VECTOR3) (rigid-body-ainvMass number) (rigid-body-binvMass number))
  (SLIDER-CONSTRAINT/GET-INFO-2-NON-VIRTUAL (ff-pointer self) info transA transB linear-velocity-A linear-velocity-B rigid-body-ainvMass rigid-body-binvMass))

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

(defmethod LOWER-LINEAR-LIMIT ((self SLIDER-CONSTRAINT))
  (SLIDER-CONSTRAINT/GET-LOWER-LIN-LIMIT (ff-pointer self)))

(defmethod (SETF LOWER-LINEAR-LIMIT) ( (lower-Limit number) (self SLIDER-CONSTRAINT))
  (SLIDER-CONSTRAINT/SET-LOWER-LIN-LIMIT (ff-pointer self) lower-Limit))

(defmethod UPPER-LINEAR-LIMIT ((self SLIDER-CONSTRAINT))
  (SLIDER-CONSTRAINT/GET-UPPER-LIN-LIMIT (ff-pointer self)))

(defmethod (SETF UPPER-LINEAR-LIMIT) ( (upperLimit number) (self SLIDER-CONSTRAINT))
  (SLIDER-CONSTRAINT/SET-UPPER-LIN-LIMIT (ff-pointer self) upperLimit))

(defmethod LOWER-ANG-LIMIT ((self SLIDER-CONSTRAINT))
  (SLIDER-CONSTRAINT/GET-LOWER-ANG-LIMIT (ff-pointer self)))

(defmethod (SETF LOWER-ANG-LIMIT) ( (lowerLimit number) (self SLIDER-CONSTRAINT))
  (SLIDER-CONSTRAINT/SET-LOWER-ANG-LIMIT (ff-pointer self) lowerLimit))

(defmethod UPPER-ANG-LIMIT ((self SLIDER-CONSTRAINT))
  (SLIDER-CONSTRAINT/GET-UPPER-ANG-LIMIT (ff-pointer self)))

(defmethod (SETF UPPER-ANG-LIMIT) ( (upperLimit number) (self SLIDER-CONSTRAINT))
  (SLIDER-CONSTRAINT/SET-UPPER-ANG-LIMIT (ff-pointer self) upperLimit))

(defmethod USE-LINEAR-REFERENCE-FRAME-A-P ((self SLIDER-CONSTRAINT))
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

(defmethod (SETF SOFTNESS-DIR-LIN) ( (softnessDirLin number) (self SLIDER-CONSTRAINT))
  (SLIDER-CONSTRAINT/SET-SOFTNESS-DIR-LIN (ff-pointer self) softnessDirLin))

(defmethod (SETF RESTITUTION-DIR-LIN) ( (restitutionDirLin number) (self SLIDER-CONSTRAINT))
  (SLIDER-CONSTRAINT/SET-RESTITUTION-DIR-LIN (ff-pointer self) restitutionDirLin))

(defmethod (SETF DAMPING-DIR-LIN) ( (dampingDirLin number) (self SLIDER-CONSTRAINT))
  (SLIDER-CONSTRAINT/SET-DAMPING-DIR-LIN (ff-pointer self) dampingDirLin))

(defmethod (SETF SOFTNESS-DIR-ANG) ( (softnessDirAng number) (self SLIDER-CONSTRAINT))
  (SLIDER-CONSTRAINT/SET-SOFTNESS-DIR-ANG (ff-pointer self) softnessDirAng))

(defmethod (SETF RESTITUTION-DIR-ANG) ( (restitutionDirAng number) (self SLIDER-CONSTRAINT))
  (SLIDER-CONSTRAINT/SET-RESTITUTION-DIR-ANG (ff-pointer self) restitutionDirAng))

(defmethod (SETF DAMPING-DIR-ANG) ( (dampingDirAng number) (self SLIDER-CONSTRAINT))
  (SLIDER-CONSTRAINT/SET-DAMPING-DIR-ANG (ff-pointer self) dampingDirAng))

(defmethod (SETF SOFTNESS-LIM-LIN) ( (softnessLimLin number) (self SLIDER-CONSTRAINT))
  (SLIDER-CONSTRAINT/SET-SOFTNESS-LIM-LIN (ff-pointer self) softnessLimLin))

(defmethod (SETF RESTITUTION-LIM-LIN) ( (restitutionLimLin number) (self SLIDER-CONSTRAINT))
  (SLIDER-CONSTRAINT/SET-RESTITUTION-LIM-LIN (ff-pointer self) restitutionLimLin))

(defmethod (SETF DAMPING-LIM-LIN) ( (dampingLimLin number) (self SLIDER-CONSTRAINT))
  (SLIDER-CONSTRAINT/SET-DAMPING-LIM-LIN (ff-pointer self) dampingLimLin))

(defmethod (SETF SOFTNESS-LIM-ANG) ( (softnessLimAng number) (self SLIDER-CONSTRAINT))
  (SLIDER-CONSTRAINT/SET-SOFTNESS-LIM-ANG (ff-pointer self) softnessLimAng))

(defmethod (SETF RESTITUTION-LIM-ANG) ( (restitutionLimAng number) (self SLIDER-CONSTRAINT))
  (SLIDER-CONSTRAINT/SET-RESTITUTION-LIM-ANG (ff-pointer self) restitutionLimAng))

(defmethod (SETF DAMPING-LIM-ANG) ( (dampingLimAng number) (self SLIDER-CONSTRAINT))
  (SLIDER-CONSTRAINT/SET-DAMPING-LIM-ANG (ff-pointer self) dampingLimAng))

(defmethod (SETF SOFTNESS-ORTHO-LIN) ( (softnessOrthoLin number) (self SLIDER-CONSTRAINT))
  (SLIDER-CONSTRAINT/SET-SOFTNESS-ORTHO-LIN (ff-pointer self) softnessOrthoLin))

(defmethod (SETF RESTITUTION-ORTHO-LIN) ( (restitutionOrthoLin number) (self SLIDER-CONSTRAINT))
  (SLIDER-CONSTRAINT/SET-RESTITUTION-ORTHO-LIN (ff-pointer self) restitutionOrthoLin))

(defmethod (SETF DAMPING-ORTHO-LIN) ( (dampingOrthoLin number) (self SLIDER-CONSTRAINT))
  (SLIDER-CONSTRAINT/SET-DAMPING-ORTHO-LIN (ff-pointer self) dampingOrthoLin))

(defmethod (SETF SOFTNESS-ORTHO-ANG) ( (softnessOrthoAng number) (self SLIDER-CONSTRAINT))
  (SLIDER-CONSTRAINT/SET-SOFTNESS-ORTHO-ANG (ff-pointer self) softnessOrthoAng))

(defmethod (SETF RESTITUTION-ORTHO-ANG) ( (restitutionOrthoAng number) (self SLIDER-CONSTRAINT))
  (SLIDER-CONSTRAINT/SET-RESTITUTION-ORTHO-ANG (ff-pointer self) restitutionOrthoAng))

(defmethod (SETF DAMPING-ORTHO-ANG) ( (dampingOrthoAng number) (self SLIDER-CONSTRAINT))
  (SLIDER-CONSTRAINT/SET-DAMPING-ORTHO-ANG (ff-pointer self) dampingOrthoAng))

(defmethod (SETF POWERED-LIN-MOTOR) ( (onOff t) (self SLIDER-CONSTRAINT))
  (SLIDER-CONSTRAINT/SET-POWERED-LIN-MOTOR (ff-pointer self) onOff))

(defmethod POWERED-LIN-MOTOR ((self SLIDER-CONSTRAINT))
  (SLIDER-CONSTRAINT/GET-POWERED-LIN-MOTOR (ff-pointer self)))

(defmethod (SETF TARGET-LIN-MOTOR-VELOCITY) ( (targetLinMotorVelocity number) (self SLIDER-CONSTRAINT))
  (SLIDER-CONSTRAINT/SET-TARGET-LIN-MOTOR-VELOCITY (ff-pointer self) targetLinMotorVelocity))

(defmethod TARGET-LIN-MOTOR-VELOCITY ((self SLIDER-CONSTRAINT))
  (SLIDER-CONSTRAINT/GET-TARGET-LIN-MOTOR-VELOCITY (ff-pointer self)))

(defmethod (SETF MAX-LIN-MOTOR-FORCE) ( (maxLinMotorForce number) (self SLIDER-CONSTRAINT))
  (SLIDER-CONSTRAINT/SET-MAX-LIN-MOTOR-FORCE (ff-pointer self) maxLinMotorForce))

(defmethod MAX-LIN-MOTOR-FORCE ((self SLIDER-CONSTRAINT))
  (SLIDER-CONSTRAINT/GET-MAX-LIN-MOTOR-FORCE (ff-pointer self)))

(defmethod (SETF POWERED-ANG-MOTOR) ( (onOff t) (self SLIDER-CONSTRAINT))
  (SLIDER-CONSTRAINT/SET-POWERED-ANG-MOTOR (ff-pointer self) onOff))

(defmethod POWERED-ANG-MOTOR ((self SLIDER-CONSTRAINT))
  (SLIDER-CONSTRAINT/GET-POWERED-ANG-MOTOR (ff-pointer self)))

(defmethod (SETF TARGET-ANG-MOTOR-VELOCITY) ( (targetAngMotorVelocity number) (self SLIDER-CONSTRAINT))
  (SLIDER-CONSTRAINT/SET-TARGET-ANG-MOTOR-VELOCITY (ff-pointer self) targetAngMotorVelocity))

(defmethod TARGET-ANG-MOTOR-VELOCITY ((self SLIDER-CONSTRAINT))
  (SLIDER-CONSTRAINT/GET-TARGET-ANG-MOTOR-VELOCITY (ff-pointer self)))

(defmethod (SETF MAX-ANG-MOTOR-FORCE) ( (maxAngMotorForce number) (self SLIDER-CONSTRAINT))
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

(defmethod CALCULATE-TRANSFORMS/a+b ((self SLIDER-CONSTRAINT) (transA TRANSFORM) (transB TRANSFORM))
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

(defmethod (SETF USE-FRAME-OFFSET) ( (frameOffsetOnOff t) (self SLIDER-CONSTRAINT))
  (SLIDER-CONSTRAINT/SET-USE-FRAME-OFFSET (ff-pointer self) frameOffsetOnOff))

(defmethod (SETF FRAMES) ( (frameA TRANSFORM) (self SLIDER-CONSTRAINT) (frameB TRANSFORM))
  (SLIDER-CONSTRAINT/SET-FRAMES (ff-pointer self) frameA frameB))

(defmethod CALCULATE-SERIALIZE-BUFFER-SIZE ((self SLIDER-CONSTRAINT))
  (SLIDER-CONSTRAINT/CALCULATE-SERIALIZE-BUFFER-SIZE (ff-pointer self)))

(defmethod ->serial ((self SLIDER-CONSTRAINT)&key data-buffer serializer &allow-other-keys)
    (check-type serializer serializer)
    (SLIDER-CONSTRAINT/SERIALIZE (ff-pointer self) data-buffer 
                                 (ff-pointer serializer)))


#+(or) (defmethod new ((self GENERIC-6-DOF-SPRING-CONSTRAINT) sizeInBytes)
        (GENERIC-6-DOF-SPRING-CONSTRAINT/MAKE-c++-INSTANCE (ff-pointer self) sizeInBytes))

#+(or) (defmethod bullet/delete ((self GENERIC-6-DOF-SPRING-CONSTRAINT) ptr)
  (GENERIC-6-DOF-SPRING-CONSTRAINT/DELETE-c++-INSTANCE (ff-pointer self) ptr))

#+(or) (defmethod new ((self GENERIC-6-DOF-SPRING-CONSTRAINT) arg1 ptr)
        (GENERIC-6-DOF-SPRING-CONSTRAINT/MAKE-c++-INSTANCE (ff-pointer self) arg1 ptr))

#+(or) (defmethod bullet/delete ((self GENERIC-6-DOF-SPRING-CONSTRAINT) arg1 arg2)
  (GENERIC-6-DOF-SPRING-CONSTRAINT/DELETE-c++-INSTANCE (ff-pointer self) arg1 arg2))

#+(or) (defmethod new[] ((self GENERIC-6-DOF-SPRING-CONSTRAINT) sizeInBytes)
  (GENERIC-6-DOF-SPRING-CONSTRAINT/MAKE-c++-ARRAY (ff-pointer self) sizeInBytes))

#+(or) (defmethod delete[] ((self GENERIC-6-DOF-SPRING-CONSTRAINT) ptr)
  (GENERIC-6-DOF-SPRING-CONSTRAINT/DELETE-c++-ARRAY (ff-pointer self) ptr))
#+(or) (defmethod new[] ((self GENERIC-6-DOF-SPRING-CONSTRAINT) arg1 ptr)
  (GENERIC-6-DOF-SPRING-CONSTRAINT/MAKE-c++-ARRAY (ff-pointer self) arg1 ptr))

#+(or) (defmethod delete[] ((self GENERIC-6-DOF-SPRING-CONSTRAINT) arg1 arg2)
  (GENERIC-6-DOF-SPRING-CONSTRAINT/DELETE-c++-ARRAY (ff-pointer self) arg1 arg2))

(defmethod initialize-instance :after ((obj GENERIC-6-DOF-SPRING-CONSTRAINT)
                                       &key 
                                         rigid-body-a rigid-body-b
                                         frame-in-a frame-in-b
                                         (use-linear-reference-frame-a-p
                                          nil use-a?)
                                         (use-linear-reference-frame-b-p
                                          nil use-b?))
  (check-type rigid-body-b RIGID-BODY) 
  (check-type frame-in-b TRANSFORM)
  (setf (slot-value obj 'ff-pointer) 
        (cond
          (use-a?
           (check-type rigid-body-a RIGID-BODY) 
           (check-type frame-in-a TRANSFORM)
           (MAKE-GENERIC-6-DOF-SPRING-CONSTRAINT/with-a&b&use-a
            rigid-body-a rigid-body-b frame-in-a frame-in-b 
            USE-LINEAR-REFERENCE-FRAME-A-P))
          (use-b?
           (MAKE-GENERIC-6-DOF-SPRING-CONSTRAINT/with-rb-b&frame-in-b/using-linear-reference-frame-b
            rigid-body-b frame-in-b USE-LINEAR-REFERENCE-FRAME-B-P)))))

(defmethod (setf spring-enabled-p) ((enablep t)
                                    (self GENERIC-6-DOF-SPRING-CONSTRAINT) (index integer))
  (GENERIC-6-DOF-SPRING-CONSTRAINT/ENABLE-SPRING (ff-pointer self) index enablep))

(defmethod (SETF STIFFNESS) ((stiffness number)
                             (self GENERIC-6-DOF-SPRING-CONSTRAINT)
                             (index integer))
  (GENERIC-6-DOF-SPRING-CONSTRAINT/SET-STIFFNESS (ff-pointer self) index stiffness))

(defmethod (SETF ELT-DAMPING) ((damping number) (self GENERIC-6-DOF-SPRING-CONSTRAINT) (index integer))
  (GENERIC-6-DOF-SPRING-CONSTRAINT/SET-DAMPING (ff-pointer self) index damping))

(defmethod (SETF EQUILIBRIUM-POINT) ((self GENERIC-6-DOF-SPRING-CONSTRAINT)
                                     (index null) (val null))
           (GENERIC-6-DOF-SPRING-CONSTRAINT/SET-EQUILIBRIUM-POINT (ff-pointer self)))

(defmethod (SETF EQUILIBRIUM-POINT) ((val null)
                                     (self GENERIC-6-DOF-SPRING-CONSTRAINT)
                                     (index integer))
  (GENERIC-6-DOF-SPRING-CONSTRAINT/SET-EQUILIBRIUM-POINT/with-index (ff-pointer self) index))

(defmethod (SETF EQUILIBRIUM-POINT) ((val number)
                                     (self GENERIC-6-DOF-SPRING-CONSTRAINT)
                                     (index integer))
  (GENERIC-6-DOF-SPRING-CONSTRAINT/SET-EQUILIBRIUM-POINT/with-index&float
   (ff-pointer self) index val))

(defmethod (SETF AXES) ((self GENERIC-6-DOF-SPRING-CONSTRAINT)
                        (axis1 VECTOR3) (axis2 VECTOR3))
  (GENERIC-6-DOF-SPRING-CONSTRAINT/SET-AXIS (ff-pointer self) axis1 axis2))

(defmethod INFO-2 ((self GENERIC-6-DOF-SPRING-CONSTRAINT) info)
  (GENERIC-6-DOF-SPRING-CONSTRAINT/GET-INFO-2 (ff-pointer self) info))

(defmethod CALCULATE-SERIALIZE-BUFFER-SIZE ((self GENERIC-6-DOF-SPRING-CONSTRAINT))
  (GENERIC-6-DOF-SPRING-CONSTRAINT/CALCULATE-SERIALIZE-BUFFER-SIZE (ff-pointer self)))

(defmethod ->serial ((self GENERIC-6-DOF-SPRING-CONSTRAINT)&key data-buffer serializer &allow-other-keys)
    (check-type serializer serializer)
    (GENERIC-6-DOF-SPRING-CONSTRAINT/SERIALIZE (ff-pointer self) data-buffer 
                                               (ff-pointer serializer)))

#+(or) (defmethod new ((self UNIVERSAL-CONSTRAINT) sizeInBytes)
  (UNIVERSAL-CONSTRAINT/MAKE-c++-INSTANCE (ff-pointer self) sizeInBytes))

#+(or) (defmethod bullet/delete ((self UNIVERSAL-CONSTRAINT) ptr)
  (UNIVERSAL-CONSTRAINT/DELETE-c++-INSTANCE (ff-pointer self) ptr))

#+(or) (defmethod new ((self UNIVERSAL-CONSTRAINT) arg1 ptr)
        (UNIVERSAL-CONSTRAINT/MAKE-c++-INSTANCE (ff-pointer self) arg1 ptr))

#+(or) (defmethod bullet/delete ((self UNIVERSAL-CONSTRAINT) arg1 arg2)
  (UNIVERSAL-CONSTRAINT/DELETE-c++-INSTANCE (ff-pointer self) arg1 arg2))

#+(or) (defmethod new[] ((self UNIVERSAL-CONSTRAINT) sizeInBytes)
        (UNIVERSAL-CONSTRAINT/MAKE-c++-ARRAY (ff-pointer self) sizeInBytes))

#+(or) (defmethod delete[] ((self UNIVERSAL-CONSTRAINT) ptr)
  (UNIVERSAL-CONSTRAINT/DELETE-c++-ARRAY (ff-pointer self) ptr))

#+(or) (defmethod new[] ((self UNIVERSAL-CONSTRAINT) arg1 ptr)
        (UNIVERSAL-CONSTRAINT/MAKE-c++-ARRAY (ff-pointer self) arg1 ptr))

#+(or) (defmethod delete[] ((self UNIVERSAL-CONSTRAINT) arg1 arg2)
  (UNIVERSAL-CONSTRAINT/DELETE-c++-ARRAY (ff-pointer self) arg1 arg2))

(defmethod initialize-instance :after ((obj UNIVERSAL-CONSTRAINT)
                                       &key rigid-body-a rigid-body-b
                                         anchor
                                         axis1 axis2)
  (check-type rigid-body-a RIGID-BODY) 
  (check-type rigid-body-b RIGID-BODY) 
  (check-type anchor VECTOR3) 
  (check-type axis1 VECTOR3) 
  (check-type axis2 VECTOR3)
  (setf (slot-value obj 'ff-pointer)
        (MAKE-UNIVERSAL-CONSTRAINT (ff-pointer rigid-body-a) 
                                   (ff-pointer rigid-body-b) 
                                   (ff-pointer anchor) 
                                   (ff-pointer axis1) (ff-pointer axis2))))

(defmethod ANCHOR ((self UNIVERSAL-CONSTRAINT))
  (UNIVERSAL-CONSTRAINT/GET-ANCHOR (ff-pointer self)))

(defmethod ANCHOR-2 ((self UNIVERSAL-CONSTRAINT))
  (UNIVERSAL-CONSTRAINT/GET-ANCHOR-2 (ff-pointer self)))

(defmethod ANCHORS ((self UNIVERSAL-CONSTRAINT))
  (values (UNIVERSAL-CONSTRAINT/GET-ANCHOR (ff-pointer self))
          (UNIVERSAL-CONSTRAINT/GET-ANCHOR-2 (ff-pointer self))))

(defmethod AXIS-1 ((self UNIVERSAL-CONSTRAINT))
  (UNIVERSAL-CONSTRAINT/GET-AXIS-1 (ff-pointer self)))

(defmethod AXIS-2 ((self UNIVERSAL-CONSTRAINT))
  (UNIVERSAL-CONSTRAINT/GET-AXIS-2 (ff-pointer self)))

(defmethod axes ((self universal-constraint))
  (values (UNIVERSAL-CONSTRAINT/GET-AXIS-1 (ff-pointer self))
          (UNIVERSAL-CONSTRAINT/GET-AXIS-2 (ff-pointer self))))

(defmethod ANGLE-1 ((self UNIVERSAL-CONSTRAINT))
  (UNIVERSAL-CONSTRAINT/GET-ANGLE-1 (ff-pointer self)))

(defmethod ANGLE-2 ((self UNIVERSAL-CONSTRAINT))
  (UNIVERSAL-CONSTRAINT/GET-ANGLE-2 (ff-pointer self)))

(defmethod ANGLES ((self UNIVERSAL-CONSTRAINT))
  (values (UNIVERSAL-CONSTRAINT/GET-ANGLE-1 (ff-pointer self))
          (UNIVERSAL-CONSTRAINT/GET-ANGLE-2 (ff-pointer self))))

(defmethod (SETF UPPER-LIMITS) ((self UNIVERSAL-CONSTRAINT)
                                (ang1max number) (ang2max number))
  (UNIVERSAL-CONSTRAINT/SET-UPPER-LIMIT (ff-pointer self) ang1max ang2max))

(defmethod (SETF LOWER-LIMITS) ((self UNIVERSAL-CONSTRAINT)
                                (angle-1-min number)
                                (angle-2-min number))
  (UNIVERSAL-CONSTRAINT/SET-LOWER-LIMIT (ff-pointer self) angle-1-min angle-2-min))

(defmethod (SETF AXES) ( (self UNIVERSAL-CONSTRAINT) (axis1 VECTOR3) (axis2 VECTOR3))
  (UNIVERSAL-CONSTRAINT/SET-AXIS (ff-pointer self) axis1 axis2))

#+(or) (defmethod new ((self HINGE-2-CONSTRAINT) sizeInBytes)
        (HINGE-2-CONSTRAINT/MAKE-c++-INSTANCE (ff-pointer self) sizeInBytes))

#+(or) (defmethod bullet/delete ((self HINGE-2-CONSTRAINT) ptr)
  (HINGE-2-CONSTRAINT/DELETE-c++-INSTANCE (ff-pointer self) ptr))

#+(or) (defmethod new ((self HINGE-2-CONSTRAINT) arg1 ptr)
        (HINGE-2-CONSTRAINT/MAKE-c++-INSTANCE (ff-pointer self) arg1 ptr))

#+(or) (defmethod bullet/delete ((self HINGE-2-CONSTRAINT) arg1 arg2)
  (HINGE-2-CONSTRAINT/DELETE-c++-INSTANCE (ff-pointer self) arg1 arg2))

#+(or) (defmethod new[] ((self HINGE-2-CONSTRAINT) sizeInBytes)
  (HINGE-2-CONSTRAINT/MAKE-c++-ARRAY (ff-pointer self) sizeInBytes))

#+(or) (defmethod delete[] ((self HINGE-2-CONSTRAINT) ptr)
  (HINGE-2-CONSTRAINT/DELETE-c++-ARRAY (ff-pointer self) ptr))

#+(or) (defmethod new[] ((self HINGE-2-CONSTRAINT) arg1 ptr)
        (HINGE-2-CONSTRAINT/MAKE-c++-ARRAY (ff-pointer self) arg1 ptr))

#+(or) (defmethod delete[] ((self HINGE-2-CONSTRAINT) arg1 arg2)
         (HINGE-2-CONSTRAINT/DELETE-c++-ARRAY (ff-pointer self) arg1 arg2))

(defmethod initialize-instance :after ((obj HINGE-2-CONSTRAINT)
                                       &key rigid-body-a rigid-body-b
                                         anchor axis1 axis2)
  (check-type rigid-body-a RIGID-BODY) 
  (check-type rigid-body-b RIGID-BODY)
  (check-type anchor VECTOR3)
  (check-type axis1 VECTOR3) (check-type axis2 VECTOR3)
  (setf (slot-value obj 'ff-pointer) 
        (MAKE-HINGE-2-CONSTRAINT (ff-pointer rigid-body-a) 
                                 (ff-pointer rigid-body-b) 
                                 (ff-pointer anchor) 
                                 (ff-pointer axis1) 
                                 (ff-pointer axis2))))

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

(defmethod (SETF UPPER-LIMIT) ( (angle-1-max number) (self HINGE-2-CONSTRAINT))
  (HINGE-2-CONSTRAINT/SET-UPPER-LIMIT (ff-pointer self) angle-1-max))

(defmethod (SETF LOWER-LIMIT) ( (angle-1-min number) (self HINGE-2-CONSTRAINT))
  (HINGE-2-CONSTRAINT/SET-LOWER-LIMIT (ff-pointer self) angle-1-min))

(defmethod initialize-instance :after ((obj GEAR-CONSTRAINT)
                                       &key rigid-body-a rigid-body-b
                                         axis-In-A axis-In-B
                                         ratio)
  (check-type rigid-body-a RIGID-BODY) (check-type rigid-body-b RIGID-BODY)
  (check-type axis-In-A VECTOR3) (check-type axis-In-B VECTOR3)
  (check-type ratio (or null number))
  (setf (slot-value obj 'ff-pointer)
        (if ratio
            (MAKE-GEAR-CONSTRAINT/with-ratio 
             (ff-pointer rigid-body-a) (ff-pointer rigid-body-b) 
             (ff-pointer axis-In-A) (ff-pointer axis-In-B) ratio)
            (MAKE-GEAR-CONSTRAINT (ff-pointer rigid-body-a) (ff-pointer rigid-body-b) 
                                  (ff-pointer axis-In-A) (ff-pointer axis-In-B)))))

(defmethod INFO-1 ((self GEAR-CONSTRAINT) info)
  (GEAR-CONSTRAINT/GET-INFO-1 (ff-pointer self) info))

(defmethod INFO-2 ((self GEAR-CONSTRAINT) info)
  (GEAR-CONSTRAINT/GET-INFO-2 (ff-pointer self) info))

(defmethod (SETF AXIS-A) ( (axisA VECTOR3) (self GEAR-CONSTRAINT))
  (GEAR-CONSTRAINT/SET-AXIS-A (ff-pointer self) axisA))

(defmethod (SETF AXIS-B) ( (axisB VECTOR3) (self GEAR-CONSTRAINT))
  (GEAR-CONSTRAINT/SET-AXIS-B (ff-pointer self) axisB))

(defmethod (setf gear-ratio) ( (ratio number) (self GEAR-CONSTRAINT))
  (GEAR-CONSTRAINT/SET-RATIO (ff-pointer self) ratio))

(defmethod AXIS-A ((self GEAR-CONSTRAINT))
  (GEAR-CONSTRAINT/GET-AXIS-A (ff-pointer self)))

(defmethod AXIS-B ((self GEAR-CONSTRAINT))
  (GEAR-CONSTRAINT/GET-AXIS-B (ff-pointer self)))

(defmethod BULLET/RATIO ((self GEAR-CONSTRAINT))
  (GEAR-CONSTRAINT/GET-RATIO (ff-pointer self)))

(defmethod CALCULATE-SERIALIZE-BUFFER-SIZE ((self GEAR-CONSTRAINT))
  (GEAR-CONSTRAINT/CALCULATE-SERIALIZE-BUFFER-SIZE (ff-pointer self)))

(defmethod ->serial ((self GEAR-CONSTRAINT)&key data-buffer serializer &allow-other-keys)
    (check-type serializer serializer)
    (GEAR-CONSTRAINT/SERIALIZE (ff-pointer self) data-buffer (ff-pointer serializer)))

(defmethod initialize-instance :after ((obj FIXED-CONSTRAINT)
                                       &key rigid-body-a rigid-body-b frame-in-a frame-in-b)
  (check-type rigid-body-a RIGID-BODY) (check-type rigid-body-b RIGID-BODY)
  (check-type frame-in-A TRANSFORM) (check-type frame-in-B TRANSFORM)
  (setf (slot-value obj 'ff-pointer)
        (MAKE-FIXED-CONSTRAINT (ff-pointer rigid-body-a) 
                               (ff-pointer rigid-body-b) 
                               (ff-pointer frame-in-A) 
                               (ff-pointer frame-in-B))))

(defmethod INFO-1 ((self FIXED-CONSTRAINT) info)
  (FIXED-CONSTRAINT/GET-INFO-1 (ff-pointer self) info))

(defmethod INFO-2 ((self FIXED-CONSTRAINT) info)
  (FIXED-CONSTRAINT/GET-INFO-2 (ff-pointer self) info))

#+(or) (defmethod new ((self SEQUENTIAL-IMPULSE-CONSTRAINT-SOLVER) sizeInBytes)
  (SEQUENTIAL-IMPULSE-CONSTRAINT-SOLVER/MAKE-c++-INSTANCE (ff-pointer self) sizeInBytes))

#+(or) (defmethod bullet/delete ((self SEQUENTIAL-IMPULSE-CONSTRAINT-SOLVER) ptr)
  (SEQUENTIAL-IMPULSE-CONSTRAINT-SOLVER/DELETE-c++-INSTANCE (ff-pointer self) ptr))

#+(or) (defmethod new ((self SEQUENTIAL-IMPULSE-CONSTRAINT-SOLVER) arg1 ptr)
  (SEQUENTIAL-IMPULSE-CONSTRAINT-SOLVER/MAKE-c++-INSTANCE (ff-pointer self) arg1 ptr))

#+(or) (defmethod bullet/delete ((self SEQUENTIAL-IMPULSE-CONSTRAINT-SOLVER) arg1 arg2)
  (SEQUENTIAL-IMPULSE-CONSTRAINT-SOLVER/DELETE-c++-INSTANCE (ff-pointer self) arg1 arg2))

#+(or) (defmethod new[] ((self SEQUENTIAL-IMPULSE-CONSTRAINT-SOLVER) sizeInBytes)
  (SEQUENTIAL-IMPULSE-CONSTRAINT-SOLVER/MAKE-c++-ARRAY (ff-pointer self) sizeInBytes))

#+(or) (defmethod delete[] ((self SEQUENTIAL-IMPULSE-CONSTRAINT-SOLVER) ptr)
  (SEQUENTIAL-IMPULSE-CONSTRAINT-SOLVER/DELETE-c++-ARRAY (ff-pointer self) ptr))

#+(or) (defmethod new[] ((self SEQUENTIAL-IMPULSE-CONSTRAINT-SOLVER) arg1 ptr)
  (SEQUENTIAL-IMPULSE-CONSTRAINT-SOLVER/MAKE-c++-ARRAY (ff-pointer self) arg1 ptr))

#+(or) (defmethod delete[] ((self SEQUENTIAL-IMPULSE-CONSTRAINT-SOLVER) arg1 arg2)
  (SEQUENTIAL-IMPULSE-CONSTRAINT-SOLVER/DELETE-c++-ARRAY (ff-pointer self) arg1 arg2))

(defmethod initialize-instance :after ((obj SEQUENTIAL-IMPULSE-CONSTRAINT-SOLVER) &key)
  (setf (slot-value obj 'ff-pointer) (MAKE-SEQUENTIAL-IMPULSE-CONSTRAINT-SOLVER)))

(defmethod SOLVE-GROUP ((self SEQUENTIAL-IMPULSE-CONSTRAINT-SOLVER)
                        bodies (num-Bodies integer)
                        manifold (num-Manifolds integer)
                        constraints (num-Constraints integer)
                        info (debug-Drawer IDEBUG-DRAW) dispatcher)
  (SEQUENTIAL-IMPULSE-CONSTRAINT-SOLVER/SOLVE-GROUP
   (ff-pointer self) bodies num-Bodies manifold num-Manifolds constraints num-Constraints
   info debug-Drawer dispatcher))

(defmethod RESET ((self SEQUENTIAL-IMPULSE-CONSTRAINT-SOLVER))
  (SEQUENTIAL-IMPULSE-CONSTRAINT-SOLVER/RESET (ff-pointer self)))

(defmethod RAND-2 ((self SEQUENTIAL-IMPULSE-CONSTRAINT-SOLVER))
  (SEQUENTIAL-IMPULSE-CONSTRAINT-SOLVER/BT-RAND-2 (ff-pointer self)))

(defmethod RAND-INT-2 ((self SEQUENTIAL-IMPULSE-CONSTRAINT-SOLVER) (n integer))
  (SEQUENTIAL-IMPULSE-CONSTRAINT-SOLVER/BT-RAND-INT-2 (ff-pointer self) n))

(defmethod (SETF RAND-SEED) ( (seed integer) (self SEQUENTIAL-IMPULSE-CONSTRAINT-SOLVER))
  (SEQUENTIAL-IMPULSE-CONSTRAINT-SOLVER/SET-RAND-SEED (ff-pointer self) seed))

(defmethod RAND-SEED ((self SEQUENTIAL-IMPULSE-CONSTRAINT-SOLVER))
  (SEQUENTIAL-IMPULSE-CONSTRAINT-SOLVER/GET-RAND-SEED (ff-pointer self)))

(defmethod SOLVER-TYPE ((self SEQUENTIAL-IMPULSE-CONSTRAINT-SOLVER))
  (SEQUENTIAL-IMPULSE-CONSTRAINT-SOLVER/GET-SOLVER-TYPE (ff-pointer self)))

