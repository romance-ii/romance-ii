(in-package :bullet-physics)

(defmethod HALF-EXTENTS-WITH-MARGIN ((self BOX-SHAPE))
  (BOX-SHAPE/GET-HALF-EXTENTS-WITH-MARGIN (ff-pointer self)))

(defmethod HALF-EXTENTS-WITHOUT-MARGIN ((self BOX-SHAPE))
  (BOX-SHAPE/GET-HALF-EXTENTS-WITHOUT-MARGIN (ff-pointer self)))

(defmethod LOCAL-SUPPORTING-VERTEX ((self BOX-SHAPE) (vec VECTOR3))
  (BOX-SHAPE/LOCAL-GET-SUPPORTING-VERTEX (ff-pointer self) vec))

(defmethod LOCAL-SUPPORTING-VERTEX-WITHOUT-MARGIN ((self BOX-SHAPE) (vec VECTOR3))
  (BOX-SHAPE/LOCAL-GET-SUPPORTING-VERTEX-WITHOUT-MARGIN (ff-pointer self) vec))

(defmethod BATCHED-UNIT-VECTOR-SUPPORTING-VERTEX-WITHOUT-MARGIN ((self BOX-SHAPE) (vectors VECTOR3) (supportVerticesOut VECTOR3) (numVectors integer))
  (BOX-SHAPE/BATCHED-UNIT-VECTOR-GET-SUPPORTING-VERTEX-WITHOUT-MARGIN (ff-pointer self) vectors supportVerticesOut numVectors))

(defmethod initialize-instance :after ((obj BOX-SHAPE) &key box-Half-Extents)
  (setf (slot-value obj 'ff-pointer) 
        (cond
          (box-half-extents ;(check-type box-half-extents integer)
           (MAKE-BOX-SHAPE (ff-pointer box-half-extents)))
          (t (error 'foo)))))

(defmethod (SETF MARGIN) ( (collisionMargin number) (self BOX-SHAPE))
  (BOX-SHAPE/SET-MARGIN (ff-pointer self) collisionMargin))

(defmethod (SETF LOCAL-SCALING) ( (scaling VECTOR3) (self BOX-SHAPE))
  (BOX-SHAPE/SET-LOCAL-SCALING (ff-pointer self) scaling))

(defmethod AABB+ ((self BOX-SHAPE) 
                  ( t-arg1 TRANSFORM)
                  ( aabb-Min VECTOR3)
                  ( aabb-Max VECTOR3))
  (BOX-SHAPE/GET-AABB (ff-pointer self) t-arg1 aabb-min aabb-max))

(defmethod CALCULATE-LOCAL-INERTIA ((self BOX-SHAPE) (mass number) (inertia VECTOR3))
  (BOX-SHAPE/CALCULATE-LOCAL-INERTIA (ff-pointer self) mass inertia))

(defmethod PLANE ((self BOX-SHAPE) (planeNormal VECTOR3) (planeSupport VECTOR3) (i integer))
  (BOX-SHAPE/GET-PLANE (ff-pointer self) planeNormal planeSupport i))

(defmethod NUM-PLANES ((self BOX-SHAPE))
  (BOX-SHAPE/GET-NUM-PLANES (ff-pointer self)))

(defmethod NUM-VERTICES ((self BOX-SHAPE))
  (BOX-SHAPE/GET-NUM-VERTICES (ff-pointer self)))

(defmethod NUM-EDGES ((self BOX-SHAPE))
  (BOX-SHAPE/GET-NUM-EDGES (ff-pointer self)))

(defmethod VERTEX ((self BOX-SHAPE) (i integer) (vtx VECTOR3))
  (BOX-SHAPE/GET-VERTEX (ff-pointer self) i vtx))

(defmethod PLANE-EQUATION ((self BOX-SHAPE) (plane VECTOR4) (i integer))
  (BOX-SHAPE/GET-PLANE-EQUATION (ff-pointer self) plane i))

(defmethod EDGE ((self BOX-SHAPE) (i integer) (pa VECTOR3) (pb VECTOR3))
  (BOX-SHAPE/GET-EDGE (ff-pointer self) i pa pb))

(defmethod INSIDEP ((self BOX-SHAPE) (pt VECTOR3) (tolerance number))
  (BOX-SHAPE/IS-INSIDE (ff-pointer self) pt tolerance))

(defmethod NAME ((self BOX-SHAPE))
  (BOX-SHAPE/GET-NAME (ff-pointer self)))

(defmethod NUM-PREFERRED-PENETRATION-DIRECTIONS ((self BOX-SHAPE))
  (BOX-SHAPE/GET-NUM-PREFERRED-PENETRATION-DIRECTIONS (ff-pointer self)))

(defmethod PREFERRED-PENETRATION-DIRECTION ((self BOX-SHAPE) (index integer) (penetrationVector VECTOR3))
  (BOX-SHAPE/GET-PREFERRED-PENETRATION-DIRECTION (ff-pointer self) index penetrationVector))
#+(or) (defmethod NEW ((self SPHERE-SHAPE) sizeInBytes)
         (SPHERE-SHAPE/MAKE-C++-INSTANCE (ff-pointer self) sizeInBytes))
#+(or) (defmethod DELETE((self SPHERE-SHAPE) ptr)
         (SPHERE-SHAPE/DELETE-C++-INSTANCE (ff-pointer self) ptr))
#+(or) (defmethod NEW ((self SPHERE-SHAPE) arg1 ptr)
         (SPHERE-SHAPE/MAKE-C++-INSTANCE/with-arg1&ptr (ff-pointer self) arg1 ptr))
#+(or) (defmethod DELETE((self SPHERE-SHAPE) arg1 arg2)
         (SPHERE-SHAPE/DELETE-C++-INSTANCE/with-arg1&2 (ff-pointer self) arg1 arg2))
#+(or) (defmethod NEW[] ((self SPHERE-SHAPE) sizeInBytes)
         (SPHERE-SHAPE/MAKE-C++-ARRAY (ff-pointer self) sizeInBytes))
#+(or) (defmethod DELETE[] ((self SPHERE-SHAPE) ptr)
         (SPHERE-SHAPE/DELETE-C++-ARRAY (ff-pointer self) ptr))
#+(or) (defmethod NEW[] ((self SPHERE-SHAPE) arg1 ptr)
         (SPHERE-SHAPE/MAKE-C++-ARRAY/with-arg1&ptr (ff-pointer self) arg1 ptr))
#+(or) (defmethod DELETE[] ((self SPHERE-SHAPE) arg1 arg2)
         (SPHERE-SHAPE/DELETE-C++-ARRAY/with-arg1&2 (ff-pointer self) arg1 arg2))

(defmethod initialize-instance :after ((obj SPHERE-SHAPE) &key radius)
  (check-type radius number)
  (setf (slot-value obj 'ff-pointer) (MAKE-SPHERE-SHAPE radius)))

(defmethod LOCAL-SUPPORTING-VERTEX ((self SPHERE-SHAPE) (vec VECTOR3))
  (SPHERE-SHAPE/LOCAL-GET-SUPPORTING-VERTEX (ff-pointer self) vec))

(defmethod LOCAL-SUPPORTING-VERTEX-WITHOUT-MARGIN ((self SPHERE-SHAPE) (vec VECTOR3))
  (SPHERE-SHAPE/LOCAL-GET-SUPPORTING-VERTEX-WITHOUT-MARGIN (ff-pointer self) vec))

(defmethod BATCHED-UNIT-VECTOR-SUPPORTING-VERTEX-WITHOUT-MARGIN ((self SPHERE-SHAPE) (vectors VECTOR3) (supportVerticesOut VECTOR3) (numVectors integer))
  (SPHERE-SHAPE/BATCHED-UNIT-VECTOR-GET-SUPPORTING-VERTEX-WITHOUT-MARGIN (ff-pointer self) vectors supportVerticesOut numVectors))

(defmethod CALCULATE-LOCAL-INERTIA ((self SPHERE-SHAPE) (mass number) (inertia VECTOR3))
  (SPHERE-SHAPE/CALCULATE-LOCAL-INERTIA (ff-pointer self) mass inertia))

(defmethod AABB+ ((self SPHERE-SHAPE) (t-arg1 TRANSFORM) (aabbMin VECTOR3) (aabbMax VECTOR3))
  (SPHERE-SHAPE/GET-AABB (ff-pointer self) t-arg1 aabbMin aabbMax))

(defmethod RADIUS ((self SPHERE-SHAPE))
  (SPHERE-SHAPE/GET-RADIUS (ff-pointer self)))

(defmethod (SETF UNSCALED-RADIUS) ( (radius number) (self SPHERE-SHAPE))
  (SPHERE-SHAPE/SET-UNSCALED-RADIUS (ff-pointer self) radius))

(defmethod NAME ((self SPHERE-SHAPE))
  (SPHERE-SHAPE/GET-NAME (ff-pointer self)))

(defmethod (SETF MARGIN) ( (margin number) (self SPHERE-SHAPE))
  (SPHERE-SHAPE/SET-MARGIN (ff-pointer self) margin))

(defmethod MARGIN ((self SPHERE-SHAPE))
  (SPHERE-SHAPE/GET-MARGIN (ff-pointer self)))
#+(or) (defmethod NEW ((self CAPSULE-SHAPE) sizeInBytes)
         (CAPSULE-SHAPE/MAKE-C++-INSTANCE (ff-pointer self) sizeInBytes))
#+(or) (defmethod DELETE((self CAPSULE-SHAPE) ptr)
         (CAPSULE-SHAPE/DELETE-C++-INSTANCE (ff-pointer self) ptr))
#+(or) (defmethod NEW ((self CAPSULE-SHAPE) arg1 ptr)
         (CAPSULE-SHAPE/MAKE-C++-INSTANCE/with-arg1&ptr (ff-pointer self) arg1 ptr))
#+(or) (defmethod DELETE((self CAPSULE-SHAPE) arg1 arg2)
         (CAPSULE-SHAPE/DELETE-C++-INSTANCE/with-arg1&2 (ff-pointer self) arg1 arg2))
#+(or) (defmethod NEW[] ((self CAPSULE-SHAPE) sizeInBytes)
         (CAPSULE-SHAPE/MAKE-C++-ARRAY (ff-pointer self) sizeInBytes))
#+(or) (defmethod DELETE[] ((self CAPSULE-SHAPE) ptr)
         (CAPSULE-SHAPE/DELETE-C++-ARRAY (ff-pointer self) ptr))
#+(or) (defmethod NEW[] ((self CAPSULE-SHAPE) arg1 ptr)
         (CAPSULE-SHAPE/MAKE-C++-ARRAY/with-arg1&ptr (ff-pointer self) arg1 ptr))
#+(or) (defmethod DELETE[] ((self CAPSULE-SHAPE) arg1 arg2)
         (CAPSULE-SHAPE/DELETE-C++-ARRAY/with-arg1&2 (ff-pointer self) arg1 arg2))

(defmethod initialize-instance :after ((obj CAPSULE-SHAPE) &key radius height)
  (check-type radius number)
  (check-type height number)
  (setf (slot-value obj 'ff-pointer) (MAKE-CAPSULE-SHAPE radius height)))

(defmethod CALCULATE-LOCAL-INERTIA ((self CAPSULE-SHAPE) (mass number) (inertia VECTOR3))
  (CAPSULE-SHAPE/CALCULATE-LOCAL-INERTIA (ff-pointer self) mass inertia))

(defmethod LOCAL-SUPPORTING-VERTEX-WITHOUT-MARGIN ((self CAPSULE-SHAPE) (vec VECTOR3))
  (CAPSULE-SHAPE/LOCAL-GET-SUPPORTING-VERTEX-WITHOUT-MARGIN (ff-pointer self) vec))

(defmethod BATCHED-UNIT-VECTOR-SUPPORTING-VERTEX-WITHOUT-MARGIN ((self CAPSULE-SHAPE) (vectors VECTOR3) (supportVerticesOut VECTOR3) (numVectors integer))
  (CAPSULE-SHAPE/BATCHED-UNIT-VECTOR-GET-SUPPORTING-VERTEX-WITHOUT-MARGIN (ff-pointer self) vectors supportVerticesOut numVectors))

(defmethod (SETF MARGIN) ( (collisionMargin number) (self CAPSULE-SHAPE))
  (CAPSULE-SHAPE/SET-MARGIN (ff-pointer self) collisionMargin))

(defmethod AABB+ ((self CAPSULE-SHAPE) (t-arg1 TRANSFORM) (aabbMin VECTOR3) (aabbMax VECTOR3))
  (CAPSULE-SHAPE/GET-AABB (ff-pointer self) t-arg1 aabbMin aabbMax))

(defmethod NAME ((self CAPSULE-SHAPE))
  (CAPSULE-SHAPE/GET-NAME (ff-pointer self)))

(defmethod UP-AXIS ((self CAPSULE-SHAPE))
  (CAPSULE-SHAPE/GET-UP-AXIS (ff-pointer self)))

(defmethod RADIUS ((self CAPSULE-SHAPE))
  (CAPSULE-SHAPE/GET-RADIUS (ff-pointer self)))

(defmethod HALF-HEIGHT ((self CAPSULE-SHAPE))
  (CAPSULE-SHAPE/GET-HALF-HEIGHT (ff-pointer self)))

(defmethod (SETF LOCAL-SCALING) ( (scaling VECTOR3) (self CAPSULE-SHAPE))
  (CAPSULE-SHAPE/SET-LOCAL-SCALING (ff-pointer self) scaling))

(defmethod ANISOTROPIC-ROLLING-FRICTION-DIRECTION ((self CAPSULE-SHAPE))
  (CAPSULE-SHAPE/GET-ANISOTROPIC-ROLLING-FRICTION-DIRECTION (ff-pointer self)))

(defmethod CALCULATE-SERIALIZE-BUFFER-SIZE ((self CAPSULE-SHAPE))
  (CAPSULE-SHAPE/CALCULATE-SERIALIZE-BUFFER-SIZE (ff-pointer self)))

(defmethod ->serial ((self CAPSULE-SHAPE) &key  data-Buffer serializer &allow-other-keys)
  (CAPSULE-SHAPE/SERIALIZE (ff-pointer self) data-Buffer serializer))

(defmethod initialize-instance :after ((obj CAPSULE-SHAPE-X) &key radius height)
  (check-type radius number)
  (check-type height number)
  (setf (slot-value obj 'ff-pointer) (MAKE-CAPSULE-SHAPE-X radius height)))

(defmethod NAME ((self CAPSULE-SHAPE-X))
  (CAPSULE-SHAPE-X/GET-NAME (ff-pointer self)))

(defmethod initialize-instance :after ((obj CAPSULE-SHAPE-Z) &key radius height)
  (check-type radius number)
  (check-type height number)
  (setf (slot-value obj 'ff-pointer) (MAKE-CAPSULE-SHAPE-Z radius height)))

(defmethod NAME ((self CAPSULE-SHAPE-Z))
  (CAPSULE-SHAPE-Z/GET-NAME (ff-pointer self)))
#+(or) (defmethod NEW ((self CYLINDER-SHAPE) sizeInBytes)
         (CYLINDER-SHAPE/MAKE-C++-INSTANCE (ff-pointer self) sizeInBytes))
#+(or) (defmethod DELETE((self CYLINDER-SHAPE) ptr)
         (CYLINDER-SHAPE/DELETE-C++-INSTANCE (ff-pointer self) ptr))
#+(or) (defmethod NEW ((self CYLINDER-SHAPE) arg1 ptr)
         (CYLINDER-SHAPE/MAKE-C++-INSTANCE/with-arg1&ptr (ff-pointer self) arg1 ptr))
#+(or) (defmethod DELETE((self CYLINDER-SHAPE) arg1 arg2)
         (CYLINDER-SHAPE/DELETE-C++-INSTANCE/with-arg1&2 (ff-pointer self) arg1 arg2))
#+(or) (defmethod NEW[] ((self CYLINDER-SHAPE) sizeInBytes)
         (CYLINDER-SHAPE/MAKE-C++-ARRAY (ff-pointer self) sizeInBytes))
#+(or) (defmethod DELETE[] ((self CYLINDER-SHAPE) ptr)
         (CYLINDER-SHAPE/DELETE-C++-ARRAY (ff-pointer self) ptr))
#+(or) (defmethod NEW[] ((self CYLINDER-SHAPE) arg1 ptr)
         (CYLINDER-SHAPE/MAKE-C++-ARRAY/with-arg1&ptr (ff-pointer self) arg1 ptr))
#+(or) (defmethod DELETE[] ((self CYLINDER-SHAPE) arg1 arg2)
         (CYLINDER-SHAPE/DELETE-C++-ARRAY/with-arg1&2 (ff-pointer self) arg1 arg2))

(defmethod HALF-EXTENTS-WITH-MARGIN ((self CYLINDER-SHAPE))
  (CYLINDER-SHAPE/GET-HALF-EXTENTS-WITH-MARGIN (ff-pointer self)))

(defmethod HALF-EXTENTS-WITHOUT-MARGIN ((self CYLINDER-SHAPE))
  (CYLINDER-SHAPE/GET-HALF-EXTENTS-WITHOUT-MARGIN (ff-pointer self)))

(defmethod initialize-instance :after ((obj CYLINDER-SHAPE) &key half-extents)
  (check-type half-extents VECTOR3)
  (setf (slot-value obj 'ff-pointer) (make-cylinder-shape (ff-pointer half-extents))))

(defmethod AABB+ ((self CYLINDER-SHAPE) (t-arg1 TRANSFORM) (aabbMin VECTOR3) (aabbMax VECTOR3))
  (CYLINDER-SHAPE/GET-AABB (ff-pointer self) t-arg1 aabbMin aabbMax))

(defmethod CALCULATE-LOCAL-INERTIA ((self CYLINDER-SHAPE) (mass number) (inertia VECTOR3))
  (CYLINDER-SHAPE/CALCULATE-LOCAL-INERTIA (ff-pointer self) mass inertia))

(defmethod LOCAL-SUPPORTING-VERTEX-WITHOUT-MARGIN ((self CYLINDER-SHAPE) (vec VECTOR3))
  (CYLINDER-SHAPE/LOCAL-GET-SUPPORTING-VERTEX-WITHOUT-MARGIN (ff-pointer self) vec))

(defmethod BATCHED-UNIT-VECTOR-SUPPORTING-VERTEX-WITHOUT-MARGIN ((self CYLINDER-SHAPE) (vectors VECTOR3) (supportVerticesOut VECTOR3) (numVectors integer))
  (CYLINDER-SHAPE/BATCHED-UNIT-VECTOR-GET-SUPPORTING-VERTEX-WITHOUT-MARGIN (ff-pointer self) vectors supportVerticesOut numVectors))

(defmethod (SETF MARGIN) ( (collisionMargin number) (self CYLINDER-SHAPE))
  (CYLINDER-SHAPE/SET-MARGIN (ff-pointer self) collisionMargin))

(defmethod LOCAL-SUPPORTING-VERTEX ((self CYLINDER-SHAPE) (vec VECTOR3))
  (CYLINDER-SHAPE/LOCAL-GET-SUPPORTING-VERTEX (ff-pointer self) vec))

(defmethod UP-AXIS ((self CYLINDER-SHAPE))
  (CYLINDER-SHAPE/GET-UP-AXIS (ff-pointer self)))

(defmethod ANISOTROPIC-ROLLING-FRICTION-DIRECTION ((self CYLINDER-SHAPE))
  (CYLINDER-SHAPE/GET-ANISOTROPIC-ROLLING-FRICTION-DIRECTION (ff-pointer self)))

(defmethod RADIUS ((self CYLINDER-SHAPE))
  (CYLINDER-SHAPE/GET-RADIUS (ff-pointer self)))

(defmethod (SETF LOCAL-SCALING) ( (scaling VECTOR3) (self CYLINDER-SHAPE))
  (CYLINDER-SHAPE/SET-LOCAL-SCALING (ff-pointer self) scaling))

(defmethod NAME ((self CYLINDER-SHAPE))
  (CYLINDER-SHAPE/GET-NAME (ff-pointer self)))

(defmethod CALCULATE-SERIALIZE-BUFFER-SIZE ((self CYLINDER-SHAPE))
  (CYLINDER-SHAPE/CALCULATE-SERIALIZE-BUFFER-SIZE (ff-pointer self)))

(defmethod ->serial ((self CYLINDER-SHAPE) &key data-buffer serializer &allow-other-keys)
  (CYLINDER-SHAPE/SERIALIZE (ff-pointer self) data-buffer serializer))
#+(or) (defmethod NEW ((self CYLINDER-SHAPE-X) sizeInBytes)
         (CYLINDER-SHAPE-X/MAKE-C++-INSTANCE (ff-pointer self) sizeInBytes))
#+(or) (defmethod DELETE((self CYLINDER-SHAPE-X) ptr)
         (CYLINDER-SHAPE-X/DELETE-C++-INSTANCE (ff-pointer self) ptr))
#+(or) (defmethod NEW ((self CYLINDER-SHAPE-X) arg1 ptr)
         (CYLINDER-SHAPE-X/MAKE-C++-INSTANCE/with-arg1&ptr (ff-pointer self) arg1 ptr))
#+(or) (defmethod DELETE((self CYLINDER-SHAPE-X) arg1 arg2)
         (CYLINDER-SHAPE-X/DELETE-C++-INSTANCE/with-arg1&2 (ff-pointer self) arg1 arg2))
#+(or) (defmethod NEW[] ((self CYLINDER-SHAPE-X) sizeInBytes)
         (CYLINDER-SHAPE-X/MAKE-C++-ARRAY (ff-pointer self) sizeInBytes))
#+(or) (defmethod DELETE[] ((self CYLINDER-SHAPE-X) ptr)
         (CYLINDER-SHAPE-X/DELETE-C++-ARRAY (ff-pointer self) ptr))
#+(or) (defmethod NEW[] ((self CYLINDER-SHAPE-X) arg1 ptr)
         (CYLINDER-SHAPE-X/MAKE-C++-ARRAY/with-arg1&ptr (ff-pointer self) arg1 ptr))
#+(or) (defmethod DELETE[] ((self CYLINDER-SHAPE-X) arg1 arg2)
         (CYLINDER-SHAPE-X/DELETE-C++-ARRAY/with-arg1&2 (ff-pointer self) arg1 arg2))

(defmethod initialize-instance :after ((obj CYLINDER-SHAPE-X) &key half-extents)
  (check-type half-Extents VECTOR3)
  (setf (slot-value obj 'ff-pointer) (MAKE-CYLINDER-SHAPE-X (ff-pointer half-extents))))

(defmethod LOCAL-SUPPORTING-VERTEX-WITHOUT-MARGIN ((self CYLINDER-SHAPE-X) (vec VECTOR3))
  (CYLINDER-SHAPE-X/LOCAL-GET-SUPPORTING-VERTEX-WITHOUT-MARGIN (ff-pointer self) vec))

(defmethod BATCHED-UNIT-VECTOR-SUPPORTING-VERTEX-WITHOUT-MARGIN ((self CYLINDER-SHAPE-X) (vectors VECTOR3) (supportVerticesOut VECTOR3) (numVectors integer))
  (CYLINDER-SHAPE-X/BATCHED-UNIT-VECTOR-GET-SUPPORTING-VERTEX-WITHOUT-MARGIN (ff-pointer self) vectors supportVerticesOut numVectors))

(defmethod NAME ((self CYLINDER-SHAPE-X))
  (CYLINDER-SHAPE-X/GET-NAME (ff-pointer self)))

(defmethod RADIUS ((self CYLINDER-SHAPE-X))
  (CYLINDER-SHAPE-X/GET-RADIUS (ff-pointer self)))
#+(or) (defmethod NEW ((self CYLINDER-SHAPE-Z) sizeInBytes)
         (CYLINDER-SHAPE-Z/MAKE-C++-INSTANCE (ff-pointer self) sizeInBytes))
#+(or) (defmethod DELETE((self CYLINDER-SHAPE-Z) ptr)
         (CYLINDER-SHAPE-Z/DELETE-C++-INSTANCE (ff-pointer self) ptr))
#+(or) (defmethod NEW ((self CYLINDER-SHAPE-Z) arg1 ptr)
         (CYLINDER-SHAPE-Z/MAKE-C++-INSTANCE/with-arg1&ptr (ff-pointer self) arg1 ptr))
#+(or) (defmethod DELETE((self CYLINDER-SHAPE-Z) arg1 arg2)
         (CYLINDER-SHAPE-Z/DELETE-C++-INSTANCE/with-arg1&2 (ff-pointer self) arg1 arg2))
#+(or) (defmethod NEW[] ((self CYLINDER-SHAPE-Z) sizeInBytes)
         (CYLINDER-SHAPE-Z/MAKE-C++-ARRAY (ff-pointer self) sizeInBytes))
#+(or) (defmethod DELETE[] ((self CYLINDER-SHAPE-Z) ptr)
         (CYLINDER-SHAPE-Z/DELETE-C++-ARRAY (ff-pointer self) ptr))
#+(or) (defmethod NEW[] ((self CYLINDER-SHAPE-Z) arg1 ptr)
         (CYLINDER-SHAPE-Z/MAKE-C++-ARRAY/with-arg1&ptr (ff-pointer self) arg1 ptr))
#+(or) (defmethod DELETE[] ((self CYLINDER-SHAPE-Z) arg1 arg2)
         (CYLINDER-SHAPE-Z/DELETE-C++-ARRAY/with-arg1&2 (ff-pointer self) arg1 arg2))

(defmethod initialize-instance :after ((obj CYLINDER-SHAPE-Z) &key half-extents)
  (check-type half-Extents VECTOR3)
  (setf (slot-value obj 'ff-pointer) (MAKE-CYLINDER-SHAPE-Z (ff-pointer half-Extents))))

(defmethod LOCAL-SUPPORTING-VERTEX-WITHOUT-MARGIN ((self CYLINDER-SHAPE-Z) (vec VECTOR3))
  (CYLINDER-SHAPE-Z/LOCAL-GET-SUPPORTING-VERTEX-WITHOUT-MARGIN (ff-pointer self) vec))

(defmethod BATCHED-UNIT-VECTOR-SUPPORTING-VERTEX-WITHOUT-MARGIN ((self CYLINDER-SHAPE-Z) (vectors VECTOR3) (supportVerticesOut VECTOR3) (numVectors integer))
  (CYLINDER-SHAPE-Z/BATCHED-UNIT-VECTOR-GET-SUPPORTING-VERTEX-WITHOUT-MARGIN (ff-pointer self) vectors supportVerticesOut numVectors))

(defmethod NAME ((self CYLINDER-SHAPE-Z))
  (CYLINDER-SHAPE-Z/GET-NAME (ff-pointer self)))

(defmethod RADIUS ((self CYLINDER-SHAPE-Z))
  (CYLINDER-SHAPE-Z/GET-RADIUS (ff-pointer self)))
#+(or) (defmethod NEW ((self CONE-SHAPE) sizeInBytes)
         (CONE-SHAPE/MAKE-C++-INSTANCE (ff-pointer self) sizeInBytes))
#+(or) (defmethod DELETE((self CONE-SHAPE) ptr)
         (CONE-SHAPE/DELETE-C++-INSTANCE (ff-pointer self) ptr))
#+(or) (defmethod NEW ((self CONE-SHAPE) arg1 ptr)
         (CONE-SHAPE/MAKE-C++-INSTANCE/with-arg1&ptr (ff-pointer self) arg1 ptr))
#+(or) (defmethod DELETE((self CONE-SHAPE) arg1 arg2)
         (CONE-SHAPE/DELETE-C++-INSTANCE/with-arg1&2 (ff-pointer self) arg1 arg2))
#+(or) (defmethod NEW[] ((self CONE-SHAPE) sizeInBytes)
         (CONE-SHAPE/MAKE-C++-ARRAY (ff-pointer self) sizeInBytes))
#+(or) (defmethod DELETE[] ((self CONE-SHAPE) ptr)
         (CONE-SHAPE/DELETE-C++-ARRAY (ff-pointer self) ptr))
#+(or) (defmethod NEW[] ((self CONE-SHAPE) arg1 ptr)
         (CONE-SHAPE/MAKE-C++-ARRAY/with-arg1&ptr (ff-pointer self) arg1 ptr))
#+(or) (defmethod DELETE[] ((self CONE-SHAPE) arg1 arg2)
         (CONE-SHAPE/DELETE-C++-ARRAY/with-arg1&2 (ff-pointer self) arg1 arg2))

(defmethod initialize-instance :after ((obj CONE-SHAPE) &key radius height)
  (check-type radius number) (check-type height number)
  (setf (slot-value obj 'ff-pointer) (MAKE-CONE-SHAPE radius height)))

(defmethod LOCAL-SUPPORTING-VERTEX ((self CONE-SHAPE) (vec VECTOR3))
  (CONE-SHAPE/LOCAL-GET-SUPPORTING-VERTEX (ff-pointer self) vec))

(defmethod LOCAL-SUPPORTING-VERTEX-WITHOUT-MARGIN ((self CONE-SHAPE) (vec VECTOR3))
  (CONE-SHAPE/LOCAL-GET-SUPPORTING-VERTEX-WITHOUT-MARGIN (ff-pointer self) vec))

(defmethod BATCHED-UNIT-VECTOR-SUPPORTING-VERTEX-WITHOUT-MARGIN ((self CONE-SHAPE) (vectors VECTOR3) (supportVerticesOut VECTOR3) (numVectors integer))
  (CONE-SHAPE/BATCHED-UNIT-VECTOR-GET-SUPPORTING-VERTEX-WITHOUT-MARGIN (ff-pointer self) vectors supportVerticesOut numVectors))

(defmethod RADIUS ((self CONE-SHAPE))
  (CONE-SHAPE/GET-RADIUS (ff-pointer self)))

(defmethod HEIGHT ((self CONE-SHAPE))
  (CONE-SHAPE/GET-HEIGHT (ff-pointer self)))

(defmethod CALCULATE-LOCAL-INERTIA ((self CONE-SHAPE) (mass number) (inertia VECTOR3))
  (CONE-SHAPE/CALCULATE-LOCAL-INERTIA (ff-pointer self) mass inertia))

(defmethod NAME ((self CONE-SHAPE))
  (CONE-SHAPE/GET-NAME (ff-pointer self)))

(defmethod (SETF CONE-UP-INDEX) ( (upIndex integer) (self CONE-SHAPE))
  (CONE-SHAPE/SET-CONE-UP-INDEX (ff-pointer self) upIndex))

(defmethod CONE-UP-INDEX ((self CONE-SHAPE))
  (CONE-SHAPE/GET-CONE-UP-INDEX (ff-pointer self)))

(defmethod ANISOTROPIC-ROLLING-FRICTION-DIRECTION ((self CONE-SHAPE))
  (CONE-SHAPE/GET-ANISOTROPIC-ROLLING-FRICTION-DIRECTION (ff-pointer self)))

(defmethod (SETF LOCAL-SCALING) ( (scaling VECTOR3) (self CONE-SHAPE))
  (CONE-SHAPE/SET-LOCAL-SCALING (ff-pointer self) scaling))

(defmethod CALCULATE-SERIALIZE-BUFFER-SIZE ((self CONE-SHAPE))
  (CONE-SHAPE/CALCULATE-SERIALIZE-BUFFER-SIZE (ff-pointer self)))

(defmethod ->serial ((self CONE-SHAPE) &key data-buffer serializer &allow-other-keys)
  (CONE-SHAPE/SERIALIZE (ff-pointer self) data-buffer serializer))

(defmethod initialize-instance :after ((obj CONE-SHAPE-X) &key radius height)
  (check-type radius number) (check-type height number)
  (setf (slot-value obj 'ff-pointer) (MAKE-CONE-SHAPE-X radius height)))

(defmethod ANISOTROPIC-ROLLING-FRICTION-DIRECTION ((self CONE-SHAPE-X))
  (CONE-SHAPE-X/GET-ANISOTROPIC-ROLLING-FRICTION-DIRECTION (ff-pointer self)))

(defmethod NAME ((self CONE-SHAPE-X))
  (CONE-SHAPE-X/GET-NAME (ff-pointer self)))

(defmethod initialize-instance :after ((obj CONE-SHAPE-Z) &key radius height)
  (check-type radius number) (check-type height number)
  (setf (slot-value obj 'ff-pointer) (MAKE-CONE-SHAPE-Z radius height)))

(defmethod ANISOTROPIC-ROLLING-FRICTION-DIRECTION ((self CONE-SHAPE-Z))
  (CONE-SHAPE-Z/GET-ANISOTROPIC-ROLLING-FRICTION-DIRECTION (ff-pointer self)))

(defmethod NAME ((self CONE-SHAPE-Z))
  (CONE-SHAPE-Z/GET-NAME (ff-pointer self)))
#+(or) (defmethod NEW ((self STATIC-PLANE-SHAPE) sizeInBytes)
         (STATIC-PLANE-SHAPE/MAKE-C++-INSTANCE (ff-pointer self) sizeInBytes))
#+(or) (defmethod DELETE((self STATIC-PLANE-SHAPE) ptr)
         (STATIC-PLANE-SHAPE/DELETE-C++-INSTANCE (ff-pointer self) ptr))
#+(or) (defmethod NEW ((self STATIC-PLANE-SHAPE) arg1 ptr)
         (STATIC-PLANE-SHAPE/MAKE-C++-INSTANCE/with-arg1&ptr (ff-pointer self) arg1 ptr))
#+(or) (defmethod DELETE((self STATIC-PLANE-SHAPE) arg1 arg2)
         (STATIC-PLANE-SHAPE/DELETE-C++-INSTANCE/with-arg1&2 (ff-pointer self) arg1 arg2))
#+(or) (defmethod NEW[] ((self STATIC-PLANE-SHAPE) sizeInBytes)
         (STATIC-PLANE-SHAPE/MAKE-C++-ARRAY (ff-pointer self) sizeInBytes))
#+(or) (defmethod DELETE[] ((self STATIC-PLANE-SHAPE) ptr)
         (STATIC-PLANE-SHAPE/DELETE-C++-ARRAY (ff-pointer self) ptr))
#+(or) (defmethod NEW[] ((self STATIC-PLANE-SHAPE) arg1 ptr)
         (STATIC-PLANE-SHAPE/MAKE-C++-ARRAY/with-arg1&ptr (ff-pointer self) arg1 ptr))
#+(or) (defmethod DELETE[] ((self STATIC-PLANE-SHAPE) arg1 arg2)
         (STATIC-PLANE-SHAPE/DELETE-C++-ARRAY/with-arg1&2 (ff-pointer self) arg1 arg2))

(defmethod initialize-instance :after ((obj STATIC-PLANE-SHAPE) &key plane-normal plane-constant)
  (check-type plane-Normal VECTOR3) (check-type plane-Constant number)
  (setf (slot-value obj 'ff-pointer)
        (MAKE-STATIC-PLANE-SHAPE (ff-pointer plane-Normal) (ff-pointer plane-Constant))))

(defmethod AABB+ ((self STATIC-PLANE-SHAPE) (t-arg1 TRANSFORM) (aabbMin VECTOR3) (aabbMax VECTOR3))
  (STATIC-PLANE-SHAPE/GET-AABB (ff-pointer self) t-arg1 aabbMin aabbMax))

(defmethod PROCESS-ALL-TRIANGLES ((self STATIC-PLANE-SHAPE) callback (aabbMin VECTOR3) (aabbMax VECTOR3))
  (STATIC-PLANE-SHAPE/PROCESS-ALL-TRIANGLES (ff-pointer self) callback aabbMin aabbMax))

(defmethod CALCULATE-LOCAL-INERTIA ((self STATIC-PLANE-SHAPE) (mass number) (inertia VECTOR3))
  (STATIC-PLANE-SHAPE/CALCULATE-LOCAL-INERTIA (ff-pointer self) mass inertia))

(defmethod (SETF LOCAL-SCALING) ( (scaling VECTOR3) (self STATIC-PLANE-SHAPE))
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

(defmethod ->serial ((self STATIC-PLANE-SHAPE) &key data-buffer serializer &allow-other-keys)
  (STATIC-PLANE-SHAPE/SERIALIZE (ff-pointer self) data-buffer serializer))
#+(or) (defmethod NEW ((self CONVEX-HULL-SHAPE) sizeInBytes)
         (CONVEX-HULL-SHAPE/MAKE-C++-INSTANCE (ff-pointer self) sizeInBytes))
#+(or) (defmethod DELETE((self CONVEX-HULL-SHAPE) ptr)
         (CONVEX-HULL-SHAPE/DELETE-C++-INSTANCE (ff-pointer self) ptr))
#+(or) (defmethod NEW ((self CONVEX-HULL-SHAPE) arg1 ptr)
         (CONVEX-HULL-SHAPE/MAKE-C++-INSTANCE/with-arg1&ptr (ff-pointer self) arg1 ptr))
#+(or) (defmethod DELETE((self CONVEX-HULL-SHAPE) arg1 arg2)
         (CONVEX-HULL-SHAPE/DELETE-C++-INSTANCE/with-arg1&2 (ff-pointer self) arg1 arg2))
#+(or) (defmethod NEW[] ((self CONVEX-HULL-SHAPE) sizeInBytes)
         (CONVEX-HULL-SHAPE/MAKE-C++-ARRAY (ff-pointer self) sizeInBytes))
#+(or) (defmethod DELETE[] ((self CONVEX-HULL-SHAPE) ptr)
         (CONVEX-HULL-SHAPE/DELETE-C++-ARRAY (ff-pointer self) ptr))
#+(or) (defmethod NEW[] ((self CONVEX-HULL-SHAPE) arg1 ptr)
         (CONVEX-HULL-SHAPE/MAKE-C++-ARRAY/with-arg1&ptr (ff-pointer self) arg1 ptr))
#+(or) (defmethod DELETE[] ((self CONVEX-HULL-SHAPE) arg1 arg2)
         (CONVEX-HULL-SHAPE/DELETE-C++-ARRAY/with-arg1&2 (ff-pointer self) arg1 arg2))

(defmethod initialize-instance :after ((obj CONVEX-HULL-SHAPE) &key points num-points stride)
  (check-type num-Points (or null integer))
  (check-type stride (or null integer))
  (setf (slot-value obj 'ff-pointer) 
        (cond
          ((and points num-points stride)
           (MAKE-CONVEX-HULL-SHAPE/with-points&num-points&stride points num-Points stride))
          ((and points num-points)
           (MAKE-CONVEX-HULL-SHAPE/with-points&num-points points num-Points))
          (points
           (MAKE-CONVEX-HULL-SHAPE/with-points points))
          (t (MAKE-CONVEX-HULL-SHAPE)))))

(defmethod ADD-POINT ((self CONVEX-HULL-SHAPE) (point VECTOR3)
                      &key (recalculate-local-aabb-p t calc?))
  (if calc?
      (CONVEX-HULL-SHAPE/ADD-POINT/with-recalculate-local-aabb
       (ff-pointer self) point recalculate-local-aabb-p)
      (CONVEX-HULL-SHAPE/ADD-POINT (ff-pointer self) point)))

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

(defmethod LOCAL-SUPPORTING-VERTEX ((self CONVEX-HULL-SHAPE) (vec VECTOR3))
  (CONVEX-HULL-SHAPE/LOCAL-GET-SUPPORTING-VERTEX (ff-pointer self) vec))

(defmethod LOCAL-SUPPORTING-VERTEX-WITHOUT-MARGIN ((self CONVEX-HULL-SHAPE) (vec VECTOR3))
  (CONVEX-HULL-SHAPE/LOCAL-GET-SUPPORTING-VERTEX-WITHOUT-MARGIN (ff-pointer self) vec))

(defmethod BATCHED-UNIT-VECTOR-SUPPORTING-VERTEX-WITHOUT-MARGIN ((self CONVEX-HULL-SHAPE) (vectors VECTOR3) (supportVerticesOut VECTOR3) (numVectors integer))
  (CONVEX-HULL-SHAPE/BATCHED-UNIT-VECTOR-GET-SUPPORTING-VERTEX-WITHOUT-MARGIN (ff-pointer self) vectors supportVerticesOut numVectors))

(defmethod PROJECT ((self CONVEX-HULL-SHAPE) (trans TRANSFORM) (dir VECTOR3) minProj maxProj (witnesPtMin VECTOR3) (witnesPtMax VECTOR3))
  (CONVEX-HULL-SHAPE/PROJECT (ff-pointer self) trans dir minProj maxProj witnesPtMin witnesPtMax))

(defmethod NAME ((self CONVEX-HULL-SHAPE))
  (CONVEX-HULL-SHAPE/GET-NAME (ff-pointer self)))

(defmethod NUM-VERTICES ((self CONVEX-HULL-SHAPE))
  (CONVEX-HULL-SHAPE/GET-NUM-VERTICES (ff-pointer self)))

(defmethod NUM-EDGES ((self CONVEX-HULL-SHAPE))
  (CONVEX-HULL-SHAPE/GET-NUM-EDGES (ff-pointer self)))

(defmethod EDGE ((self CONVEX-HULL-SHAPE) (i integer) (pa VECTOR3) (pb VECTOR3))
  (CONVEX-HULL-SHAPE/GET-EDGE (ff-pointer self) i pa pb))

(defmethod VERTEX ((self CONVEX-HULL-SHAPE) (i integer) (vtx VECTOR3))
  (CONVEX-HULL-SHAPE/GET-VERTEX (ff-pointer self) i vtx))

(defmethod NUM-PLANES ((self CONVEX-HULL-SHAPE))
  (CONVEX-HULL-SHAPE/GET-NUM-PLANES (ff-pointer self)))

(defmethod PLANE ((self CONVEX-HULL-SHAPE) (planeNormal VECTOR3) (planeSupport VECTOR3) (i integer))
  (CONVEX-HULL-SHAPE/GET-PLANE (ff-pointer self) planeNormal planeSupport i))

(defmethod INSIDEP ((self CONVEX-HULL-SHAPE) (pt VECTOR3) (tolerance number))
  (CONVEX-HULL-SHAPE/IS-INSIDE (ff-pointer self) pt tolerance))

(defmethod (SETF LOCAL-SCALING) ( (scaling VECTOR3) (self CONVEX-HULL-SHAPE))
  (CONVEX-HULL-SHAPE/SET-LOCAL-SCALING (ff-pointer self) scaling))

(defmethod CALCULATE-SERIALIZE-BUFFER-SIZE ((self CONVEX-HULL-SHAPE))
  (CONVEX-HULL-SHAPE/CALCULATE-SERIALIZE-BUFFER-SIZE (ff-pointer self)))

(defmethod ->serial ((self CONVEX-HULL-SHAPE) &key data-buffer serializer &allow-other-keys)
  (CONVEX-HULL-SHAPE/SERIALIZE (ff-pointer self) data-buffer serializer))

(defmethod (setf WELDING-THRESHOLD) ( (obj TRIANGLE-MESH) arg0)
  (TRIANGLE-MESH/WELDING-THRESHOLD/SET (ff-pointer obj) arg0))

(defmethod WELDING-THRESHOLD ((obj TRIANGLE-MESH))
  (TRIANGLE-MESH/WELDING-THRESHOLD/GET (ff-pointer obj)))

(defmethod initialize-instance :after ((obj TRIANGLE-MESH)
                                       &key (use-32-bit-Indices t bits?)
                                         (use-4-component-Vertices t components?))
  (setf (slot-value obj 'ff-pointer)
        (cond ((and bits? components?)
               (MAKE-TRIANGLE-MESH/with-use-32-bit-indices&use-4-component-vertices
                use-32-bit-Indices use-4-component-Vertices))
              (bits? (MAKE-TRIANGLE-MESH/with-use-32-bit-indices use-32-bit-Indices))
              (t (MAKE-TRIANGLE-MESH)))))

(defmethod USE-32BIT-INDICES ((self TRIANGLE-MESH))
  (TRIANGLE-MESH/GET-USE-32BIT-INDICES (ff-pointer self)))

(defmethod USE-4COMPONENT-VERTICES ((self TRIANGLE-MESH))
  (TRIANGLE-MESH/GET-USE-4COMPONENT-VERTICES (ff-pointer self)))

(defmethod ADD-TRIANGLE ((self TRIANGLE-MESH)
                         (vertex0 VECTOR3) (vertex1 VECTOR3) (vertex2 VECTOR3)
                         &optional (remove-Duplicate-Vertices-p t rm?))
  (if rm? (TRIANGLE-MESH/ADD-TRIANGLE/with-remove-duplicate-vertices 
           (ff-pointer self) vertex0 vertex1 vertex2 remove-Duplicate-Vertices-p)
      (TRIANGLE-MESH/ADD-TRIANGLE (ff-pointer self) vertex0 vertex1 vertex2)))

(defmethod NUM-TRIANGLES ((self TRIANGLE-MESH))
  (TRIANGLE-MESH/GET-NUM-TRIANGLES (ff-pointer self)))

(defmethod PREALLOCATE-VERTICES ((self TRIANGLE-MESH) (numverts integer))
  (TRIANGLE-MESH/PREALLOCATE-VERTICES (ff-pointer self) numverts))

(defmethod PREALLOCATE-INDICES ((self TRIANGLE-MESH) (numindices integer))
  (TRIANGLE-MESH/PREALLOCATE-INDICES (ff-pointer self) numindices))

(defmethod FIND-OR-ADD-VERTEX ((self TRIANGLE-MESH) (vertex VECTOR3)
                               (remove-Duplicate-Vertices-p t))
  (TRIANGLE-MESH/FIND-OR-ADD-VERTEX (ff-pointer self) vertex remove-Duplicate-Vertices-p))

(defmethod ADD-INDEX ((self TRIANGLE-MESH) (index integer))
  (TRIANGLE-MESH/ADD-INDEX (ff-pointer self) index))
#+(or) (defmethod NEW ((self CONVEX-TRIANGLE-MESH-SHAPE) sizeInBytes)
         (CONVEX-TRIANGLE-MESH-SHAPE/MAKE-C++-INSTANCE (ff-pointer self) sizeInBytes))
#+(or) (defmethod DELETE((self CONVEX-TRIANGLE-MESH-SHAPE) ptr)
         (CONVEX-TRIANGLE-MESH-SHAPE/DELETE-C++-INSTANCE (ff-pointer self) ptr))
#+(or) (defmethod NEW ((self CONVEX-TRIANGLE-MESH-SHAPE) arg1 ptr)
         (CONVEX-TRIANGLE-MESH-SHAPE/MAKE-C++-INSTANCE/with-arg1&ptr (ff-pointer self) arg1 ptr))
#+(or) (defmethod DELETE((self CONVEX-TRIANGLE-MESH-SHAPE) arg1 arg2)
         (CONVEX-TRIANGLE-MESH-SHAPE/DELETE-C++-INSTANCE/with-arg1&2 (ff-pointer self) arg1 arg2))
#+(or) (defmethod NEW[] ((self CONVEX-TRIANGLE-MESH-SHAPE) sizeInBytes)
         (CONVEX-TRIANGLE-MESH-SHAPE/MAKE-C++-ARRAY (ff-pointer self) sizeInBytes))
#+(or) (defmethod DELETE[] ((self CONVEX-TRIANGLE-MESH-SHAPE) ptr)
         (CONVEX-TRIANGLE-MESH-SHAPE/DELETE-C++-ARRAY (ff-pointer self) ptr))
#+(or) (defmethod NEW[] ((self CONVEX-TRIANGLE-MESH-SHAPE) arg1 ptr)
         (CONVEX-TRIANGLE-MESH-SHAPE/MAKE-C++-ARRAY/with-arg1&ptr (ff-pointer self) arg1 ptr))
#+(or) (defmethod DELETE[] ((self CONVEX-TRIANGLE-MESH-SHAPE) arg1 arg2)
         (CONVEX-TRIANGLE-MESH-SHAPE/DELETE-C++-ARRAY/with-arg1&2 (ff-pointer self) arg1 arg2))

(defmethod initialize-instance :after ((obj CONVEX-TRIANGLE-MESH-SHAPE)
                                       &key meshInterface (calcAabb t calc?))
  (setf (slot-value obj 'ff-pointer) 
        (if calc? (MAKE-CONVEX-TRIANGLE-MESH-SHAPE/with-calc-aabb meshInterface calcAabb)
            (MAKE-CONVEX-TRIANGLE-MESH-SHAPE meshInterface))))

(defmethod MESH-INTERFACE ((self CONVEX-TRIANGLE-MESH-SHAPE))
  (CONVEX-TRIANGLE-MESH-SHAPE/GET-MESH-INTERFACE (ff-pointer self)))

(defmethod LOCAL-SUPPORTING-VERTEX ((self CONVEX-TRIANGLE-MESH-SHAPE)
                                    (vec VECTOR3))
  (CONVEX-TRIANGLE-MESH-SHAPE/LOCAL-GET-SUPPORTING-VERTEX (ff-pointer self) vec))

(defmethod LOCAL-SUPPORTING-VERTEX-WITHOUT-MARGIN
    ((self CONVEX-TRIANGLE-MESH-SHAPE) (vec VECTOR3))
  (CONVEX-TRIANGLE-MESH-SHAPE/LOCAL-GET-SUPPORTING-VERTEX-WITHOUT-MARGIN
   (ff-pointer self) vec))

(defmethod BATCHED-UNIT-VECTOR-SUPPORTING-VERTEX-WITHOUT-MARGIN 
    ((self CONVEX-TRIANGLE-MESH-SHAPE) (vectors VECTOR3)
     (supportVerticesOut VECTOR3) (numVectors integer))
  (CONVEX-TRIANGLE-MESH-SHAPE/BATCHED-UNIT-VECTOR-GET-SUPPORTING-VERTEX-WITHOUT-MARGIN 
   (ff-pointer self) vectors supportVerticesOut numVectors))

(defmethod NAME ((self CONVEX-TRIANGLE-MESH-SHAPE))
  (CONVEX-TRIANGLE-MESH-SHAPE/GET-NAME (ff-pointer self)))

(defmethod NUM-VERTICES ((self CONVEX-TRIANGLE-MESH-SHAPE))
  (CONVEX-TRIANGLE-MESH-SHAPE/GET-NUM-VERTICES (ff-pointer self)))

(defmethod NUM-EDGES ((self CONVEX-TRIANGLE-MESH-SHAPE))
  (CONVEX-TRIANGLE-MESH-SHAPE/GET-NUM-EDGES (ff-pointer self)))

(defmethod EDGE ((self CONVEX-TRIANGLE-MESH-SHAPE) (i integer) (pa VECTOR3) (pb VECTOR3))
  (CONVEX-TRIANGLE-MESH-SHAPE/GET-EDGE (ff-pointer self) i pa pb))

(defmethod VERTEX ((self CONVEX-TRIANGLE-MESH-SHAPE) (i integer) (vtx VECTOR3))
  (CONVEX-TRIANGLE-MESH-SHAPE/GET-VERTEX (ff-pointer self) i vtx))

(defmethod NUM-PLANES ((self CONVEX-TRIANGLE-MESH-SHAPE))
  (CONVEX-TRIANGLE-MESH-SHAPE/GET-NUM-PLANES (ff-pointer self)))

(defmethod PLANE ((self CONVEX-TRIANGLE-MESH-SHAPE) (planeNormal VECTOR3) (planeSupport VECTOR3) (i integer))
  (CONVEX-TRIANGLE-MESH-SHAPE/GET-PLANE (ff-pointer self) planeNormal planeSupport i))

(defmethod INSIDEP ((self CONVEX-TRIANGLE-MESH-SHAPE) (pt VECTOR3) (tolerance number))
  (CONVEX-TRIANGLE-MESH-SHAPE/IS-INSIDE (ff-pointer self) pt tolerance))

(defmethod (SETF LOCAL-SCALING) ( (scaling VECTOR3) (self CONVEX-TRIANGLE-MESH-SHAPE))
  (CONVEX-TRIANGLE-MESH-SHAPE/SET-LOCAL-SCALING (ff-pointer self) scaling))

(defmethod LOCAL-SCALING ((self CONVEX-TRIANGLE-MESH-SHAPE))
  (CONVEX-TRIANGLE-MESH-SHAPE/GET-LOCAL-SCALING (ff-pointer self)))

(defmethod CALCULATE-PRINCIPAL-AXIS-TRANSFORM ((self CONVEX-TRIANGLE-MESH-SHAPE) (principal TRANSFORM) (inertia VECTOR3) volume)
  (CONVEX-TRIANGLE-MESH-SHAPE/CALCULATE-PRINCIPAL-AXIS-TRANSFORM (ff-pointer self) principal inertia volume))
#+(or) (defmethod NEW ((self BVH-TRIANGLE-MESH-SHAPE) sizeInBytes)
         (BVH-TRIANGLE-MESH-SHAPE/MAKE-C++-INSTANCE (ff-pointer self) sizeInBytes))
#+(or) (defmethod DELETE((self BVH-TRIANGLE-MESH-SHAPE) ptr)
         (BVH-TRIANGLE-MESH-SHAPE/DELETE-C++-INSTANCE (ff-pointer self) ptr))
#+(or) (defmethod NEW ((self BVH-TRIANGLE-MESH-SHAPE) arg1 ptr)
         (BVH-TRIANGLE-MESH-SHAPE/MAKE-C++-INSTANCE/with-arg1&ptr (ff-pointer self) arg1 ptr))
#+(or) (defmethod DELETE((self BVH-TRIANGLE-MESH-SHAPE) arg1 arg2)
         (BVH-TRIANGLE-MESH-SHAPE/DELETE-C++-INSTANCE/with-arg1&2 (ff-pointer self) arg1 arg2))
#+(or) (defmethod NEW[] ((self BVH-TRIANGLE-MESH-SHAPE) sizeInBytes)
         (BVH-TRIANGLE-MESH-SHAPE/MAKE-C++-ARRAY (ff-pointer self) sizeInBytes))
#+(or) (defmethod DELETE[] ((self BVH-TRIANGLE-MESH-SHAPE) ptr)
         (BVH-TRIANGLE-MESH-SHAPE/DELETE-C++-ARRAY (ff-pointer self) ptr))
#+(or) (defmethod NEW[] ((self BVH-TRIANGLE-MESH-SHAPE) arg1 ptr)
         (BVH-TRIANGLE-MESH-SHAPE/MAKE-C++-ARRAY/with-arg1&ptr (ff-pointer self) arg1 ptr))
#+(or) (defmethod DELETE[] ((self BVH-TRIANGLE-MESH-SHAPE) arg1 arg2)
         (BVH-TRIANGLE-MESH-SHAPE/DELETE-C++-ARRAY/with-arg1&2 (ff-pointer self) arg1 arg2))

(defmethod initialize-instance :after ((obj BVH-TRIANGLE-MESH-SHAPE)
                                       &key mesh-Interface
                                         (bvh-aabb-min nil min?)
                                         (bvh-aabb-max nil max?)
                                         (use-Quantized-Aabb-Compression-p t aabb?)
                                         (build-Bvh-p t bvh?))
  (check-type bvh-Aabb-Min (or null VECTOR3))
  (check-type bvh-Aabb-Max (or null VECTOR3))
  (setf (slot-value obj 'ff-pointer)
        (cond
          ((and min? max? aabb? bvh?)
           (make-bvh-triangle-mesh-shape/with-aabb&min&max&bvh
            mesh-interface use-quantized-aabb-compression-p
            bvh-aabb-min bvh-aabb-max build-bvh-p))
          ((and (not min?) (not max?) aabb? bvh?)
           (make-bvh-triangle-mesh-shape/with-aabb&bvh
            mesh-interface use-quantized-aabb-compression-p build-bvh-p))
          ((and (not min?) (not max?) aabb? (not bvh?))
           (make-bvh-triangle-mesh-shape/with-aabb
            mesh-interface use-quantized-aabb-compression-p))
          (t (error 'foo)))))


(defmethod OWNS-BVH ((self BVH-TRIANGLE-MESH-SHAPE))
  (BVH-TRIANGLE-MESH-SHAPE/GET-OWNS-BVH (ff-pointer self)))

(defmethod PERFORM-RAYCAST ((self BVH-TRIANGLE-MESH-SHAPE) callback (raySource VECTOR3) (rayTarget VECTOR3))
  (BVH-TRIANGLE-MESH-SHAPE/PERFORM-RAYCAST (ff-pointer self) callback raySource rayTarget))

(defmethod PERFORM-CONVEXCAST ((self BVH-TRIANGLE-MESH-SHAPE) callback (boxSource VECTOR3) (boxTarget VECTOR3) (boxMin VECTOR3) (boxMax VECTOR3))
  (BVH-TRIANGLE-MESH-SHAPE/PERFORM-CONVEXCAST (ff-pointer self) callback boxSource boxTarget boxMin boxMax))

(defmethod PROCESS-ALL-TRIANGLES ((self BVH-TRIANGLE-MESH-SHAPE) callback (aabbMin VECTOR3) (aabbMax VECTOR3))
  (BVH-TRIANGLE-MESH-SHAPE/PROCESS-ALL-TRIANGLES (ff-pointer self) callback aabbMin aabbMax))

(defmethod REFIT-TREE ((self BVH-TRIANGLE-MESH-SHAPE) (aabbMin VECTOR3) (aabbMax VECTOR3))
  (BVH-TRIANGLE-MESH-SHAPE/REFIT-TREE (ff-pointer self) aabbMin aabbMax))

(defmethod PARTIAL-REFIT-TREE ((self BVH-TRIANGLE-MESH-SHAPE) (aabbMin VECTOR3) (aabbMax VECTOR3))
  (BVH-TRIANGLE-MESH-SHAPE/PARTIAL-REFIT-TREE (ff-pointer self) aabbMin aabbMax))

(defmethod NAME ((self BVH-TRIANGLE-MESH-SHAPE))
  (BVH-TRIANGLE-MESH-SHAPE/GET-NAME (ff-pointer self)))

(defmethod (SETF LOCAL-SCALING) ( (scaling VECTOR3) (self BVH-TRIANGLE-MESH-SHAPE))
  (BVH-TRIANGLE-MESH-SHAPE/SET-LOCAL-SCALING (ff-pointer self) scaling))

(defmethod OPTIMIZED-BVH ((self BVH-TRIANGLE-MESH-SHAPE))
  (BVH-TRIANGLE-MESH-SHAPE/GET-OPTIMIZED-BVH (ff-pointer self)))

(defmethod (SETF OPTIMIZED-BVH) (
                                 bvh (self BVH-TRIANGLE-MESH-SHAPE) &optional (local-scaling nil scaling?))
  (if scaling?
      (progn
        (check-type local-scaling VECTOR3)
        (BVH-TRIANGLE-MESH-SHAPE/SET-OPTIMIZED-BVH (ff-pointer self) bvh local-scaling))
      (BVH-TRIANGLE-MESH-SHAPE/SET-OPTIMIZED-BVH (ff-pointer self) bvh)))

(defmethod BUILD-OPTIMIZED-BVH ((self BVH-TRIANGLE-MESH-SHAPE))
  (BVH-TRIANGLE-MESH-SHAPE/BUILD-OPTIMIZED-BVH (ff-pointer self)))

(defmethod USES-QUANTIZED-AABB-COMPRESSION ((self BVH-TRIANGLE-MESH-SHAPE))
  (BVH-TRIANGLE-MESH-SHAPE/USES-QUANTIZED-AABB-COMPRESSION (ff-pointer self)))

(defmethod (SETF TRIANGLE-INFO-MAP) ( triangleInfoMap (self BVH-TRIANGLE-MESH-SHAPE))
  (BVH-TRIANGLE-MESH-SHAPE/SET-TRIANGLE-INFO-MAP (ff-pointer self) triangleInfoMap))

(defmethod TRIANGLE-INFO-MAP ((self BVH-TRIANGLE-MESH-SHAPE))
  (BVH-TRIANGLE-MESH-SHAPE/GET-TRIANGLE-INFO-MAP (ff-pointer self)))

(defmethod TRIANGLE-INFO-MAP ((self BVH-TRIANGLE-MESH-SHAPE))
  (BVH-TRIANGLE-MESH-SHAPE/GET-TRIANGLE-INFO-MAP (ff-pointer self)))

(defmethod CALCULATE-SERIALIZE-BUFFER-SIZE ((self BVH-TRIANGLE-MESH-SHAPE))
  (BVH-TRIANGLE-MESH-SHAPE/CALCULATE-SERIALIZE-BUFFER-SIZE (ff-pointer self)))

(defmethod ->serial ((self BVH-TRIANGLE-MESH-SHAPE) &key data-buffer serializer &allow-other-keys)
  (BVH-TRIANGLE-MESH-SHAPE/SERIALIZE (ff-pointer self) data-buffer serializer))

(defmethod ->serial-SINGLE-BVH ((self BVH-TRIANGLE-MESH-SHAPE) serializer)
  (BVH-TRIANGLE-MESH-SHAPE/SERIALIZE-SINGLE-BVH (ff-pointer self) serializer))

(defmethod ->serial-SINGLE-TRIANGLE-INFO-MAP ((self BVH-TRIANGLE-MESH-SHAPE) serializer)
  (BVH-TRIANGLE-MESH-SHAPE/SERIALIZE-SINGLE-TRIANGLE-INFO-MAP (ff-pointer self) serializer))
#+(or) (defmethod NEW ((self SCALED-BVH-TRIANGLE-MESH-SHAPE) sizeInBytes)
         (SCALED-BVH-TRIANGLE-MESH-SHAPE/MAKE-C++-INSTANCE (ff-pointer self) sizeInBytes))
#+(or) (defmethod DELETE((self SCALED-BVH-TRIANGLE-MESH-SHAPE) ptr)
         (SCALED-BVH-TRIANGLE-MESH-SHAPE/DELETE-C++-INSTANCE (ff-pointer self) ptr))
#+(or) (defmethod NEW ((self SCALED-BVH-TRIANGLE-MESH-SHAPE) arg1 ptr)
         (SCALED-BVH-TRIANGLE-MESH-SHAPE/MAKE-C++-INSTANCE/with-arg1&ptr (ff-pointer self) arg1 ptr))
#+(or) (defmethod DELETE((self SCALED-BVH-TRIANGLE-MESH-SHAPE) arg1 arg2)
         (SCALED-BVH-TRIANGLE-MESH-SHAPE/DELETE-C++-INSTANCE/with-arg1&2 (ff-pointer self) arg1 arg2))
#+(or) (defmethod NEW[] ((self SCALED-BVH-TRIANGLE-MESH-SHAPE) sizeInBytes)
         (SCALED-BVH-TRIANGLE-MESH-SHAPE/MAKE-C++-ARRAY (ff-pointer self) sizeInBytes))
#+(or) (defmethod DELETE[] ((self SCALED-BVH-TRIANGLE-MESH-SHAPE) ptr)
         (SCALED-BVH-TRIANGLE-MESH-SHAPE/DELETE-C++-ARRAY (ff-pointer self) ptr))
#+(or) (defmethod NEW[] ((self SCALED-BVH-TRIANGLE-MESH-SHAPE) arg1 ptr)
         (SCALED-BVH-TRIANGLE-MESH-SHAPE/MAKE-C++-ARRAY/with-arg1&ptr (ff-pointer self) arg1 ptr))
#+(or) (defmethod DELETE[] ((self SCALED-BVH-TRIANGLE-MESH-SHAPE) arg1 arg2)
         (SCALED-BVH-TRIANGLE-MESH-SHAPE/DELETE-C++-ARRAY/with-arg1&2 (ff-pointer self) arg1 arg2))

(defmethod initialize-instance :after ((obj SCALED-BVH-TRIANGLE-MESH-SHAPE) 
                                       &key child-shape local-scaling)
  (check-type child-Shape BVH-TRIANGLE-MESH-SHAPE)
  (check-type local-Scaling VECTOR3)
  (setf (slot-value obj 'ff-pointer)
        (MAKE-SCALED-BVH-TRIANGLE-MESH-SHAPE (ff-pointer child-shape)
                                             (ff-pointer local-scaling))))

(defmethod AABB+ ((self SCALED-BVH-TRIANGLE-MESH-SHAPE) (t-arg1 TRANSFORM) (aabbMin VECTOR3) (aabbMax VECTOR3))
  (SCALED-BVH-TRIANGLE-MESH-SHAPE/GET-AABB (ff-pointer self) t-arg1 aabbMin aabbMax))

(defmethod (SETF LOCAL-SCALING) ( (scaling VECTOR3) (self SCALED-BVH-TRIANGLE-MESH-SHAPE))
  (SCALED-BVH-TRIANGLE-MESH-SHAPE/SET-LOCAL-SCALING (ff-pointer self) scaling))

(defmethod LOCAL-SCALING ((self SCALED-BVH-TRIANGLE-MESH-SHAPE))
  (SCALED-BVH-TRIANGLE-MESH-SHAPE/GET-LOCAL-SCALING (ff-pointer self)))

(defmethod CALCULATE-LOCAL-INERTIA ((self SCALED-BVH-TRIANGLE-MESH-SHAPE) (mass number) (inertia VECTOR3))
  (SCALED-BVH-TRIANGLE-MESH-SHAPE/CALCULATE-LOCAL-INERTIA (ff-pointer self) mass inertia))

(defmethod PROCESS-ALL-TRIANGLES ((self SCALED-BVH-TRIANGLE-MESH-SHAPE) callback (aabbMin VECTOR3) (aabbMax VECTOR3))
  (SCALED-BVH-TRIANGLE-MESH-SHAPE/PROCESS-ALL-TRIANGLES (ff-pointer self) callback aabbMin aabbMax))

(defmethod CHILD-SHAPE ((self SCALED-BVH-TRIANGLE-MESH-SHAPE))
  (SCALED-BVH-TRIANGLE-MESH-SHAPE/GET-CHILD-SHAPE (ff-pointer self)))

(defmethod CHILD-SHAPE ((self SCALED-BVH-TRIANGLE-MESH-SHAPE))
  (SCALED-BVH-TRIANGLE-MESH-SHAPE/GET-CHILD-SHAPE (ff-pointer self)))

(defmethod NAME ((self SCALED-BVH-TRIANGLE-MESH-SHAPE))
  (SCALED-BVH-TRIANGLE-MESH-SHAPE/GET-NAME (ff-pointer self)))

(defmethod CALCULATE-SERIALIZE-BUFFER-SIZE ((self SCALED-BVH-TRIANGLE-MESH-SHAPE))
  (SCALED-BVH-TRIANGLE-MESH-SHAPE/CALCULATE-SERIALIZE-BUFFER-SIZE (ff-pointer self)))

(defmethod ->serial ((self SCALED-BVH-TRIANGLE-MESH-SHAPE) &key data-buffer serializer &allow-other-keys)
  (SCALED-BVH-TRIANGLE-MESH-SHAPE/SERIALIZE (ff-pointer self) data-buffer serializer))
#+(or) (defmethod NEW ((self TRIANGLE-MESH-SHAPE) sizeInBytes)
         (TRIANGLE-MESH-SHAPE/MAKE-C++-INSTANCE (ff-pointer self) sizeInBytes))
#+(or) (defmethod DELETE((self TRIANGLE-MESH-SHAPE) ptr)
         (TRIANGLE-MESH-SHAPE/DELETE-C++-INSTANCE (ff-pointer self) ptr))
#+(or) (defmethod NEW ((self TRIANGLE-MESH-SHAPE) arg1 ptr)
         (TRIANGLE-MESH-SHAPE/MAKE-C++-INSTANCE/with-arg1&ptr (ff-pointer self) arg1 ptr))
#+(or) (defmethod DELETE((self TRIANGLE-MESH-SHAPE) arg1 arg2)
         (TRIANGLE-MESH-SHAPE/DELETE-C++-INSTANCE/with-arg1&2 (ff-pointer self) arg1 arg2))
#+(or) (defmethod NEW[] ((self TRIANGLE-MESH-SHAPE) sizeInBytes)
         (TRIANGLE-MESH-SHAPE/MAKE-C++-ARRAY (ff-pointer self) sizeInBytes))
#+(or) (defmethod DELETE[] ((self TRIANGLE-MESH-SHAPE) ptr)
         (TRIANGLE-MESH-SHAPE/DELETE-C++-ARRAY (ff-pointer self) ptr))
#+(or) (defmethod NEW[] ((self TRIANGLE-MESH-SHAPE) arg1 ptr)
         (TRIANGLE-MESH-SHAPE/MAKE-C++-ARRAY/with-arg1&ptr (ff-pointer self) arg1 ptr))
#+(or) (defmethod DELETE[] ((self TRIANGLE-MESH-SHAPE) arg1 arg2)
         (TRIANGLE-MESH-SHAPE/DELETE-C++-ARRAY/with-arg1&2 (ff-pointer self) arg1 arg2))

(defmethod LOCAL-SUPPORTING-VERTEX ((self TRIANGLE-MESH-SHAPE) (vec VECTOR3))
  (TRIANGLE-MESH-SHAPE/LOCAL-GET-SUPPORTING-VERTEX (ff-pointer self) vec))

(defmethod LOCAL-SUPPORTING-VERTEX-WITHOUT-MARGIN ((self TRIANGLE-MESH-SHAPE) (vec VECTOR3))
  (TRIANGLE-MESH-SHAPE/LOCAL-GET-SUPPORTING-VERTEX-WITHOUT-MARGIN (ff-pointer self) vec))

(defmethod RECALC-LOCAL-AABB ((self TRIANGLE-MESH-SHAPE))
  (TRIANGLE-MESH-SHAPE/RECALC-LOCAL-AABB (ff-pointer self)))

(defmethod AABB+ ((self TRIANGLE-MESH-SHAPE) (t-arg1 TRANSFORM) (aabbMin VECTOR3) (aabbMax VECTOR3))
  (TRIANGLE-MESH-SHAPE/GET-AABB (ff-pointer self) t-arg1 aabbMin aabbMax))

(defmethod PROCESS-ALL-TRIANGLES ((self TRIANGLE-MESH-SHAPE) callback (aabbMin VECTOR3) (aabbMax VECTOR3))
  (TRIANGLE-MESH-SHAPE/PROCESS-ALL-TRIANGLES (ff-pointer self) callback aabbMin aabbMax))

(defmethod CALCULATE-LOCAL-INERTIA ((self TRIANGLE-MESH-SHAPE) (mass number) (inertia VECTOR3))
  (TRIANGLE-MESH-SHAPE/CALCULATE-LOCAL-INERTIA (ff-pointer self) mass inertia))

(defmethod (SETF LOCAL-SCALING) ( (scaling VECTOR3) (self TRIANGLE-MESH-SHAPE))
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
#+(or) (defmethod NEW ((self TRIANGLE-INDEX-VERTEX-ARRAY) sizeInBytes)
         (TRIANGLE-INDEX-VERTEX-ARRAY/MAKE-C++-INSTANCE (ff-pointer self) sizeInBytes))
#+(or) (defmethod DELETE((self TRIANGLE-INDEX-VERTEX-ARRAY) ptr)
         (TRIANGLE-INDEX-VERTEX-ARRAY/DELETE-C++-INSTANCE (ff-pointer self) ptr))
#+(or) (defmethod NEW ((self TRIANGLE-INDEX-VERTEX-ARRAY) arg1 ptr)
         (TRIANGLE-INDEX-VERTEX-ARRAY/MAKE-C++-INSTANCE/with-arg1&ptr (ff-pointer self) arg1 ptr))
#+(or) (defmethod DELETE((self TRIANGLE-INDEX-VERTEX-ARRAY) arg1 arg2)
         (TRIANGLE-INDEX-VERTEX-ARRAY/DELETE-C++-INSTANCE/with-arg1&2 (ff-pointer self) arg1 arg2))
#+(or) (defmethod NEW[] ((self TRIANGLE-INDEX-VERTEX-ARRAY) sizeInBytes)
         (TRIANGLE-INDEX-VERTEX-ARRAY/MAKE-C++-ARRAY (ff-pointer self) sizeInBytes))
#+(or) (defmethod DELETE[] ((self TRIANGLE-INDEX-VERTEX-ARRAY) ptr)
         (TRIANGLE-INDEX-VERTEX-ARRAY/DELETE-C++-ARRAY (ff-pointer self) ptr))
#+(or) (defmethod NEW[] ((self TRIANGLE-INDEX-VERTEX-ARRAY) arg1 ptr)
         (TRIANGLE-INDEX-VERTEX-ARRAY/MAKE-C++-ARRAY/with-arg1&ptr (ff-pointer self) arg1 ptr))
#+(or) (defmethod DELETE[] ((self TRIANGLE-INDEX-VERTEX-ARRAY) arg1 arg2)
         (TRIANGLE-INDEX-VERTEX-ARRAY/DELETE-C++-ARRAY/with-arg1&2 (ff-pointer self) arg1 arg2))
#+(or) (defmethod DELETE((self BOX-SHAPE) ptr)
         (BOX-SHAPE/DELETE-C++-INSTANCE (ff-pointer self) ptr))
#+(or) (defmethod NEW ((self BOX-SHAPE) arg1 ptr)
         (BOX-SHAPE/MAKE-C++-INSTANCE/with-arg1&ptr (ff-pointer self) arg1 ptr))
#+(or) (defmethod DELETE((self BOX-SHAPE) arg1 arg2)
         (BOX-SHAPE/DELETE-C++-INSTANCE/with-arg1&2 (ff-pointer self) arg1 arg2))
#+(or) (defmethod NEW[] ((self BOX-SHAPE) sizeInBytes)
         (BOX-SHAPE/MAKE-C++-ARRAY (ff-pointer self) sizeInBytes))
#+(or) (defmethod DELETE[] ((self BOX-SHAPE) ptr)
         (BOX-SHAPE/DELETE-C++-ARRAY (ff-pointer self) ptr))
#+(or) (defmethod NEW[] ((self BOX-SHAPE) arg1 ptr)
         (BOX-SHAPE/MAKE-C++-ARRAY/with-arg1&ptr (ff-pointer self) arg1 ptr))
#+(or) (defmethod DELETE[] ((self BOX-SHAPE) arg1 arg2)
         (BOX-SHAPE/DELETE-C++-ARRAY/with-arg1&2 (ff-pointer self) arg1 arg2))
#+(or) (defmethod NEW ((self BOX-SHAPE) sizeInBytes)
         (BOX-SHAPE/MAKE-c++-INSTANCE (ff-pointer self) sizeInBytes))



