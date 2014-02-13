(in-package #:bullet-physics)

(defmethod initialize-instance :after ((obj TRIANGLE-INDEX-VERTEX-ARRAY)
                                       &key
                                         num-triangles
                                         triangle-index-base
                                         triangle-index-stride
                                         num-vertices 
                                         vertex-base
                                         vertex-stride)
  (setf (slot-value obj 'ff-pointer)
        (cond
          ((and num-triangles num-vertices
                triangle-index-base triangle-index-stride
                vertex-base vertex-stride)
           (check-type num-triangles integer)
           (check-type triangle-index-stride integer)
           (check-type num-vertices integer)
           (check-type vertex-stride integer)
           (MAKE-TRIANGLE-INDEX-VERTEX-ARRAY/WITH-TRIANGLE-INDEX-BASE&STRIDE&NUM-VERTICES&VERTEX-BASE&STRIDE
            num-triangles triangle-index-base triangle-index-stride
            num-vertices vertex-base vertex-stride))
         (t (MAKE-TRIANGLE-INDEX-VERTEX-ARRAY)))))

(defmethod ADD-INDEXED-MESH ((self TRIANGLE-INDEX-VERTEX-ARRAY) mesh 
                             &optional (index-type nil type?))
  (cond
    (type? (TRIANGLE-INDEX-VERTEX-ARRAY/ADD-INDEXED-MESH/with-index-type
            (ff-pointer self) mesh index-type))
    (t (TRIANGLE-INDEX-VERTEX-ARRAY/ADD-INDEXED-MESH (ff-pointer self) mesh))))

(defmethod LOCKED-VERTEX-INDEX-BASE ((self TRIANGLE-INDEX-VERTEX-ARRAY)
                                     vertex-base num-vertices type vertex-Stride
                                     index-base index-stride
                                     num-faces
                                     indices-type 
                                     &key subpart read-only-p)
  (cond 
    ((and read-only-p
          subpart) (check-type subpart integer)
     (TRIANGLE-INDEX-VERTEX-ARRAY/GET-LOCKED-READ-ONLY-VERTEX-INDEX-BASE/WITH-SUBPART
      (ff-pointer self) vertex-base num-vertices type vertex-Stride
      index-base index-stride num-faces indices-type subpart))
    ((and read-only-p
          (not subpart)) (TRIANGLE-INDEX-VERTEX-ARRAY/GET-LOCKED-READ-ONLY-VERTEX-INDEX-BASE
                          (ff-pointer self) vertex-base num-vertices type vertex-Stride
                          index-base index-stride num-faces indices-type))
    (subpart (check-type subpart integer)
             (TRIANGLE-INDEX-VERTEX-ARRAY/GET-LOCKED-VERTEX-INDEX-BASE/WITH-SUBPART
              (ff-pointer self) vertex-base num-vertices type vertex-Stride
              index-base index-stride num-faces indices-type subpart))
    (t (TRIANGLE-INDEX-VERTEX-ARRAY/GET-LOCKED-VERTEX-INDEX-BASE
        (ff-pointer self) vertex-base num-vertices type vertex-Stride
        index-base index-stride num-faces indices-type))))

(defmethod UN-LOCK-VERTEX-BASE ((self TRIANGLE-INDEX-VERTEX-ARRAY) (subpart integer))
  (TRIANGLE-INDEX-VERTEX-ARRAY/UN-LOCK-VERTEX-BASE (ff-pointer self) subpart))

(defmethod UN-LOCK-READ-ONLY-VERTEX-BASE
    ((self TRIANGLE-INDEX-VERTEX-ARRAY) (subpart integer))
  (TRIANGLE-INDEX-VERTEX-ARRAY/UN-LOCK-READ-ONLY-VERTEX-BASE (ff-pointer self) subpart))

(defmethod NUM-SUB-PARTS ((self TRIANGLE-INDEX-VERTEX-ARRAY))
  (TRIANGLE-INDEX-VERTEX-ARRAY/GET-NUM-SUB-PARTS (ff-pointer self)))

(defmethod INDEXED-MESH-ARRAY ((self TRIANGLE-INDEX-VERTEX-ARRAY))
  (TRIANGLE-INDEX-VERTEX-ARRAY/GET-INDEXED-MESH-ARRAY (ff-pointer self)))

(defmethod INDEXED-MESH-ARRAY ((self TRIANGLE-INDEX-VERTEX-ARRAY))
  (TRIANGLE-INDEX-VERTEX-ARRAY/GET-INDEXED-MESH-ARRAY (ff-pointer self)))

(defmethod PREALLOCATE-VERTICES ((self TRIANGLE-INDEX-VERTEX-ARRAY) (numverts integer))
  (TRIANGLE-INDEX-VERTEX-ARRAY/PREALLOCATE-VERTICES (ff-pointer self) numverts))

(defmethod PREALLOCATE-INDICES
    ((self TRIANGLE-INDEX-VERTEX-ARRAY) (numindices integer))
  (TRIANGLE-INDEX-VERTEX-ARRAY/PREALLOCATE-INDICES (ff-pointer self) numindices))

(defmethod HAS-PREMADE-AABB-P ((self TRIANGLE-INDEX-VERTEX-ARRAY))
  (TRIANGLE-INDEX-VERTEX-ARRAY/HAS-PREMADE-AABB (ff-pointer self)))

(defmethod (SETF PREMADE-AABB)
    ( (aabbMin VECTOR3) (self TRIANGLE-INDEX-VERTEX-ARRAY) (aabbMax VECTOR3))
  (TRIANGLE-INDEX-VERTEX-ARRAY/SET-PREMADE-AABB (ff-pointer self) aabbMin aabbMax))

(defmethod PREMADE-AABB
    ((self TRIANGLE-INDEX-VERTEX-ARRAY) (aabbMin VECTOR3) (aabbMax VECTOR3))
  (TRIANGLE-INDEX-VERTEX-ARRAY/GET-PREMADE-AABB (ff-pointer self) aabbMin aabbMax))
#+(or) (defmethod NEW ((self COMPOUND-SHAPE) sizeInBytes)
  (COMPOUND-SHAPE/MAKE-C++-INSTANCE (ff-pointer self) sizeInBytes))
#+(or) (defmethod DELETE((self COMPOUND-SHAPE) ptr)
  (COMPOUND-SHAPE/DELETE-C++-INSTANCE (ff-pointer self) ptr))
#+(or) (defmethod NEW ((self COMPOUND-SHAPE) arg1 ptr)
  (COMPOUND-SHAPE/MAKE-C++-INSTANCE/with-arg1&ptr (ff-pointer self) arg1 ptr))
#+(or) (defmethod DELETE((self COMPOUND-SHAPE) arg1 arg2)
  (COMPOUND-SHAPE/DELETE-C++-INSTANCE/with-arg1&2 (ff-pointer self) arg1 arg2))
#+(or) (defmethod NEW[] ((self COMPOUND-SHAPE) sizeInBytes)
  (COMPOUND-SHAPE/MAKE-C++-ARRAY (ff-pointer self) sizeInBytes))
#+(or) (defmethod DELETE[] ((self COMPOUND-SHAPE) ptr)
  (COMPOUND-SHAPE/DELETE-C++-ARRAY (ff-pointer self) ptr))
#+(or) (defmethod NEW[] ((self COMPOUND-SHAPE) arg1 ptr)
  (COMPOUND-SHAPE/MAKE-C++-ARRAY/with-arg1&ptr (ff-pointer self) arg1 ptr))
#+(or) (defmethod DELETE[] ((self COMPOUND-SHAPE) arg1 arg2)
  (COMPOUND-SHAPE/DELETE-C++-ARRAY/with-arg1&2 (ff-pointer self) arg1 arg2))

(defmethod initialize-instance :after ((obj COMPOUND-SHAPE) 
                                       &key (enable-dynamic-aabb-tree-p t aabb?))
  (setf (slot-value obj 'ff-pointer)
        (if aabb?
            (make-compound-shape/with-enable-dynamic-aabb-tree enable-dynamic-aabb-tree-p)
            (make-compound-shape))))

(defmethod ADD-CHILD-SHAPE ((self COMPOUND-SHAPE) (localTransform TRANSFORM) shape)
  (COMPOUND-SHAPE/ADD-CHILD-SHAPE (ff-pointer self) localTransform shape))

(defmethod REMOVE-CHILD-SHAPE ((self COMPOUND-SHAPE) shape)
  (COMPOUND-SHAPE/REMOVE-CHILD-SHAPE (ff-pointer self) shape))

(defmethod REMOVE-CHILD-SHAPE-BY-INDEX ((self COMPOUND-SHAPE) (childShapeindex integer))
  (COMPOUND-SHAPE/REMOVE-CHILD-SHAPE-BY-INDEX (ff-pointer self) childShapeindex))

(defmethod NUM-CHILD-SHAPES ((self COMPOUND-SHAPE))
  (COMPOUND-SHAPE/GET-NUM-CHILD-SHAPES (ff-pointer self)))

(defmethod CHILD-SHAPE-ELT ((self COMPOUND-SHAPE) (index integer))
  (COMPOUND-SHAPE/GET-CHILD-SHAPE (ff-pointer self) index))

(defmethod CHILD-SHAPE-ELT ((self COMPOUND-SHAPE) (index integer))
  (COMPOUND-SHAPE/GET-CHILD-SHAPE (ff-pointer self) index))

(defmethod CHILD-TRANSFORM ((self COMPOUND-SHAPE) (index integer))
  (COMPOUND-SHAPE/GET-CHILD-TRANSFORM (ff-pointer self) index))

(defmethod CHILD-TRANSFORM ((self COMPOUND-SHAPE) (index integer))
  (COMPOUND-SHAPE/GET-CHILD-TRANSFORM (ff-pointer self) index))

(defmethod UPDATE-CHILD-TRANSFORM ((self COMPOUND-SHAPE) (child-index integer)
                                   (new-child-transform TRANSFORM) &optional (should-Recalculate-Local-Aabb-p t aabb?))
  (if aabb?
      (compound-shape/update-child-transform/with-recalc
       (ff-pointer self) child-index new-child-transform
       should-recalculate-local-aabb-p)
      (compound-shape/update-child-transform
       (ff-pointer self) child-index new-child-transform)))

(defmethod CHILD-LIST ((self COMPOUND-SHAPE))
  (COMPOUND-SHAPE/GET-CHILD-LIST (ff-pointer self)))

(defmethod AABB+ ((self COMPOUND-SHAPE) (t-arg1 TRANSFORM) (aabbMin VECTOR3) (aabbMax VECTOR3))
  (COMPOUND-SHAPE/GET-AABB (ff-pointer self) t-arg1 aabbMin aabbMax))

(defmethod RECALCULATE-LOCAL-AABB ((self COMPOUND-SHAPE))
  (COMPOUND-SHAPE/RECALCULATE-LOCAL-AABB (ff-pointer self)))

(defmethod (SETF LOCAL-SCALING) ( (scaling VECTOR3) (self COMPOUND-SHAPE))
  (COMPOUND-SHAPE/SET-LOCAL-SCALING (ff-pointer self) scaling))

(defmethod LOCAL-SCALING ((self COMPOUND-SHAPE))
  (COMPOUND-SHAPE/GET-LOCAL-SCALING (ff-pointer self)))

(defmethod CALCULATE-LOCAL-INERTIA ((self COMPOUND-SHAPE) (mass number) (inertia VECTOR3))
  (COMPOUND-SHAPE/CALCULATE-LOCAL-INERTIA (ff-pointer self) mass inertia))

(defmethod (SETF MARGIN) ( (margin number) (self COMPOUND-SHAPE))
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

(defmethod CALCULATE-PRINCIPAL-AXIS-TRANSFORM ((self COMPOUND-SHAPE) masses (principal TRANSFORM) (inertia VECTOR3))
  (COMPOUND-SHAPE/CALCULATE-PRINCIPAL-AXIS-TRANSFORM (ff-pointer self) masses principal inertia))

(defmethod UPDATE-REVISION ((self COMPOUND-SHAPE))
  (COMPOUND-SHAPE/GET-UPDATE-REVISION (ff-pointer self)))

(defmethod CALCULATE-SERIALIZE-BUFFER-SIZE ((self COMPOUND-SHAPE))
  (COMPOUND-SHAPE/CALCULATE-SERIALIZE-BUFFER-SIZE (ff-pointer self)))

(defmethod ->serial ((self COMPOUND-SHAPE) &key data-buffer serializer &allow-other-keys)
  (COMPOUND-SHAPE/SERIALIZE (ff-pointer self) data-buffer serializer))
#+(or) (defmethod NEW ((self BU-SIMPLEX1TO4) sizeInBytes)
  (BU/SIMPLEX1TO4/MAKE-C++-INSTANCE/with-size (ff-pointer self) sizeInBytes))
#+(or) (defmethod DELETE((self BU-SIMPLEX1TO4) ptr)
  (BU/SIMPLEX1TO4/DELETE-C++-INSTANCE (ff-pointer self) ptr))
#+(or) (defmethod NEW ((self BU-SIMPLEX1TO4) arg1 ptr)
  (BU/SIMPLEX1TO4/MAKE-C++-INSTANCE/with-arg1&ptr (ff-pointer self) arg1 ptr))
#+(or) (defmethod DELETE((self BU-SIMPLEX1TO4) arg1 arg2)
  (BU/SIMPLEX1TO4/DELETE-C++-INSTANCE/with-arg1&2 (ff-pointer self) arg1 arg2))
#+(or) (defmethod NEW[] ((self BU-SIMPLEX1TO4) sizeInBytes)
  (BU/SIMPLEX1TO4/MAKE-C++-ARRAY (ff-pointer self) sizeInBytes))
#+(or) (defmethod DELETE[] ((self BU-SIMPLEX1TO4) ptr)
  (BU/SIMPLEX1TO4/DELETE-C++-ARRAY (ff-pointer self) ptr))
#+(or) (defmethod NEW[] ((self BU-SIMPLEX1TO4) arg1 ptr)
  (BU/SIMPLEX1TO4/MAKE-C++-ARRAY/with-arg1&ptr (ff-pointer self) arg1 ptr))
#+(or) (defmethod DELETE[] ((self BU-SIMPLEX1TO4) arg1 arg2)
  (BU/SIMPLEX1TO4/DELETE-C++-ARRAY/with-arg1&2 (ff-pointer self) arg1 arg2))

(defmethod initialize-instance :after ((obj BU-SIMPLEX1TO4) 
                                       &key
                                         (pt0 nil pt0?)
                                         (pt1 nil pt1?)
                                         (pt2 nil pt2?)
                                         (pt3 nil pt3?))
  (check-type pt0 (or null VECTOR3))
  (check-type pt1 (or null VECTOR3))
  (check-type pt2 (or null VECTOR3))
  (check-type pt3 (or null VECTOR3))
  (setf (slot-value obj 'ff-pointer) 
        (cond
          ((and pt3? pt2? pt1? pt0?)
           (MAKE-BU/SIMPLEX1TO4/with-pt0&1&2&3  pt0 pt1 pt2 pt3))
          ((and (not pt3?) pt2? pt1? pt0? )
           (MAKE-BU/SIMPLEX1TO4/with-pt0&1&2    pt0 pt1 pt2))
          ((and (not pt2?) (not pt3?) pt1? pt0?)
           (MAKE-BU/SIMPLEX1TO4/with-pt0&1      pt0 pt1))
          ((and pt0? (not pt1?) (not pt2?) (not pt3?))
           (MAKE-BU/SIMPLEX1TO4/with-pt0        pt0))
          ((and (not pt0?) (not pt1?) (not pt2?) (not pt3?))
           (MAKE-BU/SIMPLEX1TO4))
          (t (error 'foo)))))

(defmethod RESET ((self BU-SIMPLEX1TO4))
  (BU/SIMPLEX1TO4/RESET (ff-pointer self)))

(defmethod AABB+ ((self BU-SIMPLEX1TO4) (t-arg1 TRANSFORM) (aabbMin VECTOR3) (aabbMax VECTOR3))
  (BU/SIMPLEX1TO4/GET-AABB (ff-pointer self) t-arg1 aabbMin aabbMax))

(defmethod ADD-VERTEX ((self BU-SIMPLEX1TO4) (pt VECTOR3))
  (BU/SIMPLEX1TO4/ADD-VERTEX (ff-pointer self) pt))

(defmethod NUM-VERTICES ((self BU-SIMPLEX1TO4))
  (BU/SIMPLEX1TO4/GET-NUM-VERTICES (ff-pointer self)))

(defmethod NUM-EDGES ((self BU-SIMPLEX1TO4))
  (BU/SIMPLEX1TO4/GET-NUM-EDGES (ff-pointer self)))

(defmethod EDGE ((self BU-SIMPLEX1TO4) (i integer) (pa VECTOR3) (pb VECTOR3))
  (BU/SIMPLEX1TO4/GET-EDGE (ff-pointer self) i pa pb))

(defmethod VERTEX ((self BU-SIMPLEX1TO4) (i integer) (vtx VECTOR3))
  (BU/SIMPLEX1TO4/GET-VERTEX (ff-pointer self) i vtx))

(defmethod NUM-PLANES ((self BU-SIMPLEX1TO4))
  (BU/SIMPLEX1TO4/GET-NUM-PLANES (ff-pointer self)))

(defmethod PLANE ((self BU-SIMPLEX1TO4) (planeNormal VECTOR3) (planeSupport VECTOR3) (i integer))
  (BU/SIMPLEX1TO4/GET-PLANE (ff-pointer self) planeNormal planeSupport i))

(defmethod INDEX ((self BU-SIMPLEX1TO4) (i integer))
  (BU/SIMPLEX1TO4/GET-INDEX (ff-pointer self) i))

(defmethod INSIDEP ((self BU-SIMPLEX1TO4) (pt VECTOR3) (tolerance number))
  (BU/SIMPLEX1TO4/IS-INSIDE (ff-pointer self) pt tolerance))

(defmethod NAME ((self BU-SIMPLEX1TO4))
  (BU/SIMPLEX1TO4/GET-NAME (ff-pointer self)))
#+(or) (defmethod NEW ((self EMPTY-SHAPE) sizeInBytes)
  (EMPTY-SHAPE/MAKE-C++-INSTANCE (ff-pointer self) sizeInBytes))
#+(or) (defmethod DELETE((self EMPTY-SHAPE) ptr)
  (EMPTY-SHAPE/DELETE-C++-INSTANCE (ff-pointer self) ptr))
#+(or) (defmethod NEW ((self EMPTY-SHAPE) arg1 ptr)
  (EMPTY-SHAPE/MAKE-C++-INSTANCE (ff-pointer self) arg1 ptr))
#+(or) (defmethod DELETE((self EMPTY-SHAPE) arg1 arg2)
  (EMPTY-SHAPE/DELETE-C++-INSTANCE (ff-pointer self) arg1 arg2))
#+(or) (defmethod NEW[] ((self EMPTY-SHAPE) sizeInBytes)
  (EMPTY-SHAPE/MAKE-C++-ARRAY (ff-pointer self) sizeInBytes))
#+(or) (defmethod DELETE[] ((self EMPTY-SHAPE) ptr)
  (EMPTY-SHAPE/DELETE-C++-ARRAY (ff-pointer self) ptr))
#+(or) (defmethod NEW[] ((self EMPTY-SHAPE) arg1 ptr)
  (EMPTY-SHAPE/MAKE-C++-ARRAY (ff-pointer self) arg1 ptr))
#+(or) (defmethod DELETE[] ((self EMPTY-SHAPE) arg1 arg2)
  (EMPTY-SHAPE/DELETE-C++-ARRAY (ff-pointer self) arg1 arg2))

(defmethod initialize-instance :after ((obj EMPTY-SHAPE) &key)
  (setf (slot-value obj 'ff-pointer) (MAKE-EMPTY-SHAPE)))

(defmethod AABB+ ((self EMPTY-SHAPE) (t-arg1 TRANSFORM) (aabbMin VECTOR3) (aabbMax VECTOR3))
  (EMPTY-SHAPE/GET-AABB (ff-pointer self) t-arg1 aabbMin aabbMax))

(defmethod (SETF LOCAL-SCALING) ( (scaling VECTOR3) (self EMPTY-SHAPE))
  (EMPTY-SHAPE/SET-LOCAL-SCALING (ff-pointer self) scaling))

(defmethod LOCAL-SCALING ((self EMPTY-SHAPE))
  (EMPTY-SHAPE/GET-LOCAL-SCALING (ff-pointer self)))

(defmethod CALCULATE-LOCAL-INERTIA ((self EMPTY-SHAPE) (mass number) (inertia VECTOR3))
  (EMPTY-SHAPE/CALCULATE-LOCAL-INERTIA (ff-pointer self) mass inertia))

(defmethod NAME ((self EMPTY-SHAPE))
  (EMPTY-SHAPE/GET-NAME (ff-pointer self)))

(defmethod PROCESS-ALL-TRIANGLES ((self EMPTY-SHAPE) arg1 (arg2 VECTOR3) (arg3 VECTOR3))
  (EMPTY-SHAPE/PROCESS-ALL-TRIANGLES (ff-pointer self) arg1 arg2 arg3))
#+(or) (defmethod NEW ((self MULTI-SPHERE-SHAPE) sizeInBytes)
  (MULTI-SPHERE-SHAPE/MAKE-C++-INSTANCE (ff-pointer self) sizeInBytes))
#+(or) (defmethod DELETE((self MULTI-SPHERE-SHAPE) ptr)
  (MULTI-SPHERE-SHAPE/DELETE-C++-INSTANCE (ff-pointer self) ptr))
#+(or) (defmethod NEW ((self MULTI-SPHERE-SHAPE) arg1 ptr)
  (MULTI-SPHERE-SHAPE/MAKE-C++-INSTANCE (ff-pointer self) arg1 ptr))
#+(or) (defmethod DELETE((self MULTI-SPHERE-SHAPE) arg1 arg2)
  (MULTI-SPHERE-SHAPE/DELETE-C++-INSTANCE (ff-pointer self) arg1 arg2))
#+(or) (defmethod NEW[] ((self MULTI-SPHERE-SHAPE) sizeInBytes)
  (MULTI-SPHERE-SHAPE/MAKE-C++-ARRAY (ff-pointer self) sizeInBytes))
#+(or) (defmethod DELETE[] ((self MULTI-SPHERE-SHAPE) ptr)
  (MULTI-SPHERE-SHAPE/DELETE-C++-ARRAY (ff-pointer self) ptr))
#+(or) (defmethod NEW[] ((self MULTI-SPHERE-SHAPE) arg1 ptr)
  (MULTI-SPHERE-SHAPE/MAKE-C++-ARRAY/with-arg1&ptr (ff-pointer self) arg1 ptr))
#+(or) (defmethod DELETE[] ((self MULTI-SPHERE-SHAPE) arg1 arg2)
  (MULTI-SPHERE-SHAPE/DELETE-C++-ARRAY/with-arg1&2 (ff-pointer self) arg1 arg2))

(defmethod initialize-instance :after ((obj MULTI-SPHERE-SHAPE) 
                                       &key positions radi num-Spheres)
  (check-type num-spheres integer)
  (check-type positions vector3)
  (setf (slot-value obj 'ff-pointer)
        (MAKE-MULTI-SPHERE-SHAPE (ff-pointer positions) radi num-spheres)))

(defmethod CALCULATE-LOCAL-INERTIA ((self MULTI-SPHERE-SHAPE) (mass number) (inertia VECTOR3))
  (MULTI-SPHERE-SHAPE/CALCULATE-LOCAL-INERTIA (ff-pointer self) mass inertia))

(defmethod LOCAL-SUPPORTING-VERTEX-WITHOUT-MARGIN ((self MULTI-SPHERE-SHAPE) (vec VECTOR3))
  (MULTI-SPHERE-SHAPE/LOCAL-GET-SUPPORTING-VERTEX-WITHOUT-MARGIN (ff-pointer self) vec))

(defmethod BATCHED-UNIT-VECTOR-SUPPORTING-VERTEX-WITHOUT-MARGIN ((self MULTI-SPHERE-SHAPE) (vectors VECTOR3) (supportVerticesOut VECTOR3) (numVectors integer))
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

(defmethod ->serial ((self MULTI-SPHERE-SHAPE) &key data-buffer serializer &allow-other-keys)
  (MULTI-SPHERE-SHAPE/SERIALIZE (ff-pointer self) data-buffer serializer))
#+(or) (defmethod NEW ((self UNIFORM-SCALING-SHAPE) sizeInBytes)
  (UNIFORM-SCALING-SHAPE/MAKE-C++-INSTANCE (ff-pointer self) sizeInBytes))
#+(or) (defmethod DELETE((self UNIFORM-SCALING-SHAPE) ptr)
  (UNIFORM-SCALING-SHAPE/DELETE-C++-INSTANCE (ff-pointer self) ptr))
#+(or) (defmethod NEW ((self UNIFORM-SCALING-SHAPE) arg1 ptr)
  (UNIFORM-SCALING-SHAPE/MAKE-C++-INSTANCE/with-arg1&ptr (ff-pointer self) arg1 ptr))
#+(or) (defmethod DELETE((self UNIFORM-SCALING-SHAPE) arg1 arg2)
  (UNIFORM-SCALING-SHAPE/DELETE-C++-INSTANCE/with-arg1&2 (ff-pointer self) arg1 arg2))
#+(or) (defmethod NEW[] ((self UNIFORM-SCALING-SHAPE) sizeInBytes)
  (UNIFORM-SCALING-SHAPE/MAKE-C++-ARRAY (ff-pointer self) sizeInBytes))
#+(or) (defmethod DELETE[] ((self UNIFORM-SCALING-SHAPE) ptr)
  (UNIFORM-SCALING-SHAPE/DELETE-C++-ARRAY (ff-pointer self) ptr))
#+(or) (defmethod NEW[] ((self UNIFORM-SCALING-SHAPE) arg1 ptr)
  (UNIFORM-SCALING-SHAPE/MAKE-C++-ARRAY/with-arg1&ptr (ff-pointer self) arg1 ptr))
#+(or) (defmethod DELETE[] ((self UNIFORM-SCALING-SHAPE) arg1 arg2)
  (UNIFORM-SCALING-SHAPE/DELETE-C++-ARRAY/with-arg1&2 (ff-pointer self) arg1 arg2))

(defmethod initialize-instance :after ((obj UNIFORM-SCALING-SHAPE)
                                       &key convex-child-shape uniform-scaling-factor)
  (check-type uniform-scaling-factor number)
  (setf (slot-value obj 'ff-pointer)
        (make-uniform-scaling-shape convex-child-shape uniform-scaling-factor)))

(defmethod LOCAL-SUPPORTING-VERTEX-WITHOUT-MARGIN
    ((self UNIFORM-SCALING-SHAPE) (vec VECTOR3))
  (UNIFORM-SCALING-SHAPE/LOCAL-GET-SUPPORTING-VERTEX-WITHOUT-MARGIN (ff-pointer self) vec))

(defmethod LOCAL-SUPPORTING-VERTEX ((self UNIFORM-SCALING-SHAPE) (vec VECTOR3))
  (UNIFORM-SCALING-SHAPE/LOCAL-GET-SUPPORTING-VERTEX (ff-pointer self) vec))

(defmethod BATCHED-UNIT-VECTOR-SUPPORTING-VERTEX-WITHOUT-MARGIN 
    ((self UNIFORM-SCALING-SHAPE) (vectors VECTOR3)
     (supportVerticesOut VECTOR3) (numVectors integer))
  (UNIFORM-SCALING-SHAPE/BATCHED-UNIT-VECTOR-GET-SUPPORTING-VERTEX-WITHOUT-MARGIN (ff-pointer self) vectors supportVerticesOut numVectors))

(defmethod CALCULATE-LOCAL-INERTIA ((self UNIFORM-SCALING-SHAPE)
                                    (mass number) (inertia VECTOR3))
  (UNIFORM-SCALING-SHAPE/CALCULATE-LOCAL-INERTIA (ff-pointer self) mass inertia))

(defmethod UNIFORM-SCALING-FACTOR ((self UNIFORM-SCALING-SHAPE))
  (UNIFORM-SCALING-SHAPE/GET-UNIFORM-SCALING-FACTOR (ff-pointer self)))

(defmethod CHILD-SHAPE ((self UNIFORM-SCALING-SHAPE))
  (UNIFORM-SCALING-SHAPE/GET-CHILD-SHAPE (ff-pointer self)))

(defmethod CHILD-SHAPE ((self UNIFORM-SCALING-SHAPE))
  (UNIFORM-SCALING-SHAPE/GET-CHILD-SHAPE (ff-pointer self)))

(defmethod NAME ((self UNIFORM-SCALING-SHAPE))
  (UNIFORM-SCALING-SHAPE/GET-NAME (ff-pointer self)))

(defmethod AABB+ ((self UNIFORM-SCALING-SHAPE) (t-arg1 TRANSFORM)
                 (aabbMin VECTOR3) (aabbMax VECTOR3))
  (UNIFORM-SCALING-SHAPE/GET-AABB (ff-pointer self) t-arg1 aabbMin aabbMax))

(defmethod AABB+-SLOW ((self UNIFORM-SCALING-SHAPE) (t-arg1 TRANSFORM)
                      (aabbMin VECTOR3) (aabbMax VECTOR3))
  (UNIFORM-SCALING-SHAPE/GET-AABB-SLOW (ff-pointer self) t-arg1 aabbMin aabbMax))

(defmethod (SETF LOCAL-SCALING) ( (scaling VECTOR3) (self UNIFORM-SCALING-SHAPE))
  (UNIFORM-SCALING-SHAPE/SET-LOCAL-SCALING (ff-pointer self) scaling))

(defmethod LOCAL-SCALING ((self UNIFORM-SCALING-SHAPE))
  (UNIFORM-SCALING-SHAPE/GET-LOCAL-SCALING (ff-pointer self)))

(defmethod (SETF MARGIN) ( (margin number) (self UNIFORM-SCALING-SHAPE))
  (UNIFORM-SCALING-SHAPE/SET-MARGIN (ff-pointer self) margin))

(defmethod MARGIN ((self UNIFORM-SCALING-SHAPE))
  (UNIFORM-SCALING-SHAPE/GET-MARGIN (ff-pointer self)))

(defmethod NUM-PREFERRED-PENETRATION-DIRECTIONS ((self UNIFORM-SCALING-SHAPE))
  (UNIFORM-SCALING-SHAPE/GET-NUM-PREFERRED-PENETRATION-DIRECTIONS (ff-pointer self)))

(defmethod PREFERRED-PENETRATION-DIRECTION ((self UNIFORM-SCALING-SHAPE)
                                            (index integer) (penetrationVector VECTOR3))
  (UNIFORM-SCALING-SHAPE/GET-PREFERRED-PENETRATION-DIRECTION (ff-pointer self) index penetrationVector))

(defmethod initialize-instance :after ((obj SPHERE-SPHERE-COLLISION-ALGORITHM) &key mf ci col0Wrap col1Wrap)
  (setf (slot-value obj 'ff-pointer)
        (MAKE-SPHERE-SPHERE-COLLISION-ALGORITHM mf ci col0Wrap col1Wrap)))

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

(defmethod (SETF CONVEX-CONVEX-MULTIPOINT-ITERATIONS)
    ((num&min cons)
     (self DEFAULT-COLLISION-CONFIGURATION))
  (destructuring-bind 
        (numPerturbationIterations minimumPointsPerturbationThreshold) num&min
    (check-type numPerturbationIterations integer) 
    (check-type minimumPointsPerturbationThreshold integer)
    (DEFAULT-COLLISION-CONFIGURATION/SET-CONVEX-CONVEX-MULTIPOINT-ITERATIONS/with-num&min
       (ff-pointer self) numPerturbationIterations minimumPointsPerturbationThreshold)))

(defmethod (SETF CONVEX-CONVEX-MULTIPOINT-ITERATIONS)
    ((numPerturbationIterations integer) (self DEFAULT-COLLISION-CONFIGURATION))
  (DEFAULT-COLLISION-CONFIGURATION/SET-CONVEX-CONVEX-MULTIPOINT-ITERATIONS/with-num
      (ff-pointer self) numPerturbationIterations))

(defmethod (SETF CONVEX-CONVEX-MULTIPOINT-ITERATIONS) 
    ((_ null) (self DEFAULT-COLLISION-CONFIGURATION))
  (declare (ignore _))
  (DEFAULT-COLLISION-CONFIGURATION/SET-CONVEX-CONVEX-MULTIPOINT-ITERATIONS
      (ff-pointer self)))

(defmethod (SETF PLANE-CONVEX-MULTIPOINT-ITERATIONS) ((num&min cons)
                                                      (self DEFAULT-COLLISION-CONFIGURATION))
  
  (destructuring-bind 
        (numPerturbationIterations minimumPointsPerturbationThreshold) num&min
    (check-type numPerturbationIterations integer) 
    (check-type minimumPointsPerturbationThreshold integer)
    (DEFAULT-COLLISION-CONFIGURATION/SET-PLANE-CONVEX-MULTIPOINT-ITERATIONS/with-num&min
        (ff-pointer self) numPerturbationIterations minimumPointsPerturbationThreshold)))

(defmethod (SETF PLANE-CONVEX-MULTIPOINT-ITERATIONS) ( (numPerturbationIterations integer) (self DEFAULT-COLLISION-CONFIGURATION))
  (DEFAULT-COLLISION-CONFIGURATION/SET-PLANE-CONVEX-MULTIPOINT-ITERATIONS/with-num
      (ff-pointer self) numPerturbationIterations))

(defmethod (SETF PLANE-CONVEX-MULTIPOINT-ITERATIONS) ((_ null)
                                                      (self DEFAULT-COLLISION-CONFIGURATION))
  (DEFAULT-COLLISION-CONFIGURATION/SET-PLANE-CONVEX-MULTIPOINT-ITERATIONS
      (ff-pointer self)))

(defmethod DISPATCHER-FLAGS ((self COLLISION-DISPATCHER))
  (COLLISION-DISPATCHER/GET-DISPATCHER-FLAGS (ff-pointer self)))

(defmethod (SETF DISPATCHER-FLAGS) ( (flags integer) (self COLLISION-DISPATCHER))
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
#+(or) (defmethod NEW-MANIFOLD ((self COLLISION-DISPATCHER) (b0 COLLISION-OBJECT) (b1 COLLISION-OBJECT))
  (COLLISION-DISPATCHER/GET-NEW-MANIFOLD (ff-pointer self) b0 b1))

(defmethod RELEASE-MANIFOLD ((self COLLISION-DISPATCHER) manifold)
  (COLLISION-DISPATCHER/RELEASE-MANIFOLD (ff-pointer self) manifold))

(defmethod CLEAR-MANIFOLD ((self COLLISION-DISPATCHER) manifold)
  (COLLISION-DISPATCHER/CLEAR-MANIFOLD (ff-pointer self) manifold))

(defmethod FIND-ALGORITHM ((self COLLISION-DISPATCHER) body0Wrap body1Wrap &optional sharedManifold)
  (if sharedmanifold
      (COLLISION-DISPATCHER/FIND-ALGORITHM (ff-pointer self) body0Wrap body1Wrap sharedManifold)
   (COLLISION-DISPATCHER/FIND-ALGORITHM (ff-pointer self) body0Wrap body1Wrap)))


(defmethod NEEDS-COLLISION ((self COLLISION-DISPATCHER) (body0 COLLISION-OBJECT) (body1 COLLISION-OBJECT))
  (COLLISION-DISPATCHER/NEEDS-COLLISION (ff-pointer self) body0 body1))

(defmethod NEEDS-RESPONSE ((self COLLISION-DISPATCHER) (body0 COLLISION-OBJECT) (body1 COLLISION-OBJECT))
  (COLLISION-DISPATCHER/NEEDS-RESPONSE (ff-pointer self) body0 body1))

(defmethod DISPATCH-ALL-COLLISION-PAIRS ((self COLLISION-DISPATCHER) pairCache dispatchInfo dispatcher)
  (COLLISION-DISPATCHER/DISPATCH-ALL-COLLISION-PAIRS (ff-pointer self) pairCache dispatchInfo dispatcher))

(defmethod (SETF NEAR-CALLBACK) ( nearCallback (self COLLISION-DISPATCHER))
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

(defmethod (SETF COLLISION-CONFIGURATION) ( config (self COLLISION-DISPATCHER))
  (COLLISION-DISPATCHER/SET-COLLISION-CONFIGURATION (ff-pointer self) config))

(defmethod INTERNAL-MANIFOLD-POOL ((self COLLISION-DISPATCHER))
  (COLLISION-DISPATCHER/GET-INTERNAL-MANIFOLD-POOL (ff-pointer self)))

(defmethod INTERNAL-MANIFOLD-POOL ((self COLLISION-DISPATCHER))
  (COLLISION-DISPATCHER/GET-INTERNAL-MANIFOLD-POOL (ff-pointer self)))

(defmethod initialize-instance :after ((obj simple-broadphase)
                                       &key (max-proxies nil max?)
                                         (overlapping-Pair-Cache nil cache?))
  (setf (slot-value obj 'ff-pointer) 
        (cond ((and max? cache?)
               (MAKE-SIMPLE-BROADPHASE/with-max-proxies&overlapping-pair-cache
                max-proxies overlapping-pair-cache))
              (max?
               (MAKE-SIMPLE-BROADPHASE/with-max-proxies max-Proxies))
              (t
               (MAKE-SIMPLE-BROADPHASE)))))

(defmethod CREATE-PROXY ((self SIMPLE-BROADPHASE) (aabbMin VECTOR3) (aabbMax VECTOR3)
                         (shapeType integer) userPtr (collisionFilterGroup integer)
                         (collisionFilterMask integer) dispatcher multiSapProxy)
  (SIMPLE-BROADPHASE/CREATE-PROXY (ff-pointer self) aabbMin aabbMax shapeType userPtr collisionFilterGroup collisionFilterMask dispatcher multiSapProxy))

(defmethod CALCULATE-OVERLAPPING-PAIRS ((self SIMPLE-BROADPHASE) dispatcher)
  (SIMPLE-BROADPHASE/CALCULATE-OVERLAPPING-PAIRS (ff-pointer self) dispatcher))

(defmethod DESTROY-PROXY ((self SIMPLE-BROADPHASE) proxy dispatcher)
  (SIMPLE-BROADPHASE/DESTROY-PROXY (ff-pointer self) proxy dispatcher))

(defmethod (SETF AABB) ( proxy (self SIMPLE-BROADPHASE)
                        (aabbMin VECTOR3) (aabbMax VECTOR3) dispatcher)
  (SIMPLE-BROADPHASE/SET-AABB (ff-pointer self) proxy aabbMin aabbMax dispatcher))

(defmethod AABB+ ((self SIMPLE-BROADPHASE) proxy (aabbMin VECTOR3) (aabbMax VECTOR3))
  (SIMPLE-BROADPHASE/GET-AABB (ff-pointer self) proxy aabbMin aabbMax))

(defmethod ray-test ((self simple-broadphase) (ray-from vector3) (ray-to vector3)
                     ray-callback &optional aabb-min aabb-max)
  (cond ((and aabb-min aabb-max) (check-type aabb-min vector3)
         (check-type aabb-max vector3)
         (simple-broadphase/ray-test/with-aabb-min&max (ff-pointer self)
                                     ray-from ray-to ray-callback aabb-min aabb-max))
        (aabb-min (check-type aabb-min vector3)
                  (simple-broadphase/ray-test/with-aabb-min (ff-pointer self)
                                              ray-from ray-to ray-callback aabb-min))
        (t (simple-broadphase/ray-test (ff-pointer self)
                                       ray-from ray-to ray-callback))))

(defmethod AABB-TEST ((self SIMPLE-BROADPHASE) (aabbMin VECTOR3) (aabbMax VECTOR3) callback)
  (SIMPLE-BROADPHASE/AABB-TEST (ff-pointer self) aabbMin aabbMax callback))

(defmethod OVERLAPPING-PAIR-CACHE ((self SIMPLE-BROADPHASE))
  (SIMPLE-BROADPHASE/GET-OVERLAPPING-PAIR-CACHE (ff-pointer self)))

(defmethod OVERLAPPING-PAIR-CACHE ((self SIMPLE-BROADPHASE))
  (SIMPLE-BROADPHASE/GET-OVERLAPPING-PAIR-CACHE (ff-pointer self)))

(defmethod TEST-AABB-OVERLAP ((self SIMPLE-BROADPHASE) proxy0 proxy1)
  (SIMPLE-BROADPHASE/TEST-AABB-OVERLAP (ff-pointer self) proxy0 proxy1))

(defmethod BROADPHASE-AABB ((self SIMPLE-BROADPHASE) (aabbMin VECTOR3) (aabbMax VECTOR3))
  (SIMPLE-BROADPHASE/GET-BROADPHASE-AABB (ff-pointer self) aabbMin aabbMax))

(defmethod PRINT-STATS ((self SIMPLE-BROADPHASE))
  (SIMPLE-BROADPHASE/PRINT-STATS (ff-pointer self)))

(defmethod BROADPHASE-ARRAY ((self MULTI-SAP-BROADPHASE))
  (MULTI-SAP-BROADPHASE/GET-BROADPHASE-ARRAY (ff-pointer self)))

(defmethod BROADPHASE-ARRAY ((self MULTI-SAP-BROADPHASE))
  (MULTI-SAP-BROADPHASE/GET-BROADPHASE-ARRAY (ff-pointer self)))

(defmethod CREATE-PROXY ((self MULTI-SAP-BROADPHASE) (aabbMin VECTOR3) (aabbMax VECTOR3) (shapeType integer) userPtr (collisionFilterGroup integer) (collisionFilterMask integer) dispatcher multiSapProxy)
  (MULTI-SAP-BROADPHASE/CREATE-PROXY (ff-pointer self) aabbMin aabbMax shapeType userPtr collisionFilterGroup collisionFilterMask dispatcher multiSapProxy))

(defmethod DESTROY-PROXY ((self MULTI-SAP-BROADPHASE) proxy dispatcher)
  (MULTI-SAP-BROADPHASE/DESTROY-PROXY (ff-pointer self) proxy dispatcher))

(defmethod (SETF AABB) ( proxy (self MULTI-SAP-BROADPHASE) (aabbMin VECTOR3) (aabbMax VECTOR3) dispatcher)
  (MULTI-SAP-BROADPHASE/SET-AABB (ff-pointer self) proxy aabbMin aabbMax dispatcher))

(defmethod AABB+ ((self MULTI-SAP-BROADPHASE) proxy (aabbMin VECTOR3) (aabbMax VECTOR3))
  (MULTI-SAP-BROADPHASE/GET-AABB (ff-pointer self) proxy aabbMin aabbMax))

(defmethod RAY-TEST ((self MULTI-SAP-BROADPHASE)
                     (ray-from vector3) (ray-to vector3) ray-callback 
                     &optional aabb-min aabb-max)
  (check-type aabb-Min (or null VECTOR3))
  (check-type aabb-Max (or null VECTOR3)) 
  (cond
    ((and aabb-max aabb-min)
     (MULTI-SAP-BROADPHASE/RAY-TEST/with-ray-from&to&callback&aabb-min&max
      (ff-pointer self) ray-From ray-To ray-Callback aabb-Min aabb-Max))
    (aabb-min
     (MULTI-SAP-BROADPHASE/RAY-TEST/with-ray-from&to&callback&aabb-min
      (ff-pointer self) ray-From ray-To ray-Callback aabb-Min))
    (t
     (MULTI-SAP-BROADPHASE/RAY-TEST/with-ray-from&to&callback
      (ff-pointer self) ray-From ray-To ray-Callback))
))

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

(defmethod BROADPHASE-AABB ((self MULTI-SAP-BROADPHASE) (aabbMin VECTOR3) (aabbMax VECTOR3))
  (MULTI-SAP-BROADPHASE/GET-BROADPHASE-AABB (ff-pointer self) aabbMin aabbMax))

(defmethod BUILD-TREE ((self MULTI-SAP-BROADPHASE) (bvhAabbMin VECTOR3) (bvhAabbMax VECTOR3))
  (MULTI-SAP-BROADPHASE/BUILD-TREE (ff-pointer self) bvhAabbMin bvhAabbMax))

(defmethod PRINT-STATS ((self MULTI-SAP-BROADPHASE))
  (MULTI-SAP-BROADPHASE/PRINT-STATS (ff-pointer self)))

(defmethod QUICKSORT ((self MULTI-SAP-BROADPHASE) a (lo integer) (hi integer))
  (MULTI-SAP-BROADPHASE/QUICKSORT (ff-pointer self) a lo hi))

(defmethod RESET-POOL ((self MULTI-SAP-BROADPHASE) dispatcher)
  (MULTI-SAP-BROADPHASE/RESET-POOL (ff-pointer self) dispatcher))

(defmethod initialize-instance :after ((obj CLOCK) &key other)
  (setf (slot-value obj 'ff-pointer) 
        (etypecase other
          (null (MAKE-CLOCK))
          (clock (MAKE-CLOCK/with-other (ff-pointer other))))))

(defmethod (setf clock) ( (other CLOCK) (self CLOCK))
  (CLOCK/ASSIGN-VALUE (ff-pointer self) (ff-pointer other)))

(defmethod RESET ((self CLOCK))
  (CLOCK/RESET (ff-pointer self)))

(defmethod TIME-MILLISECONDS ((self CLOCK))
  (CLOCK/GET-TIME-MILLISECONDS (ff-pointer self)))

(defmethod TIME-MICROSECONDS ((self CLOCK))
  (CLOCK/GET-TIME-MICROSECONDS (ff-pointer self)))

(defmethod initialize-instance :after ((obj CPROFILE-NODE) &key name parent)
  (check-type name string) (check-type parent CPROFILE-NODE)
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

(defmethod (SETF USER-POINTER) ( ptr (self CPROFILE-NODE))
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

(defmethod (SETF CURRENT-USER-POINTER) ( ptr (self CPROFILE-ITERATOR))
  (CPROFILE-ITERATOR/SET/CURRENT/USER-POINTER (ff-pointer self) ptr))

(defmethod CURRENT-PARENT-NAME ((self CPROFILE-ITERATOR))
  (CPROFILE-ITERATOR/GET/CURRENT/PARENT/NAME (ff-pointer self)))

(defmethod CURRENT-PARENT-TOTAL-CALLS ((self CPROFILE-ITERATOR))
  (CPROFILE-ITERATOR/GET/CURRENT/PARENT/TOTAL/CALLS (ff-pointer self)))

(defmethod CURRENT-PARENT-TOTAL-TIME ((self CPROFILE-ITERATOR))
  (CPROFILE-ITERATOR/GET/CURRENT/PARENT/TOTAL/TIME (ff-pointer self)))

(defmethod initialize-instance :after ((obj CPROFILE-MANAGER) &key)
  (setf (slot-value obj 'ff-pointer) (MAKE-CPROFILE-MANAGER)))
#+ (or)

(defmethod initialize-instance :after ((obj CPROFILE-SAMPLE) &key (name string))
  (setf (slot-value obj 'ff-pointer) (MAKE-CPROFILE-SAMPLE name)))
#+ (or)

(defmethod DRAW-LINE ((self IDEBUG-DRAW) (from VECTOR3) (to VECTOR3) (color VECTOR3))
  (IDEBUG-DRAW/DRAW-LINE (ff-pointer self) from to color))

(defmethod DRAW-LINE ((self IDEBUG-DRAW) (from VECTOR3) (to VECTOR3) (fromColor VECTOR3) (toColor VECTOR3))
  (IDEBUG-DRAW/DRAW-LINE (ff-pointer self) from to fromColor toColor))
#+ (or)

(defmethod DRAW-SPHERE ((self IDEBUG-DRAW) (radius number) (transform TRANSFORM) (color VECTOR3))
  (IDEBUG-DRAW/DRAW-SPHERE (ff-pointer self) radius transform color))

(defmethod DRAW-SPHERE ((self IDEBUG-DRAW) (p VECTOR3) (radius number) (color VECTOR3))
  (IDEBUG-DRAW/DRAW-SPHERE (ff-pointer self) p radius color))
#+ (or)

(defmethod DRAW-TRIANGLE ((self IDEBUG-DRAW) (v0 VECTOR3) (v1 VECTOR3) (v2 VECTOR3) (arg4 VECTOR3) (arg5 VECTOR3) (arg6 VECTOR3) (color VECTOR3) (alpha number))
  (IDEBUG-DRAW/DRAW-TRIANGLE (ff-pointer self) v0 v1 v2 arg4 arg5 arg6 color alpha))

(defmethod DRAW-TRIANGLE ((self IDEBUG-DRAW) (v0 VECTOR3) (v1 VECTOR3) (v2 VECTOR3) (color VECTOR3) (arg5 number))
  (IDEBUG-DRAW/DRAW-TRIANGLE (ff-pointer self) v0 v1 v2 color arg5))

(defmethod DRAW-CONTACT-POINT ((self IDEBUG-DRAW) (PointOnB VECTOR3) (normalOnB VECTOR3) (distance number) (lifeTime integer) (color VECTOR3))
  (IDEBUG-DRAW/DRAW-CONTACT-POINT (ff-pointer self) PointOnB normalOnB distance lifeTime color))

(defmethod REPORT-ERROR-WARNING ((self IDEBUG-DRAW) (warningString string))
  (IDEBUG-DRAW/REPORT-ERROR-WARNING (ff-pointer self) warningString))

(defmethod DRAW-3D-TEXT ((self IDEBUG-DRAW) (location VECTOR3) (textString string))
  (IDEBUG-DRAW/DRAW-3D-TEXT (ff-pointer self) location textString))

(defmethod (SETF DEBUG-MODE) ( (debugMode integer) (self IDEBUG-DRAW))
  (IDEBUG-DRAW/SET-DEBUG-MODE (ff-pointer self) debugMode))

(defmethod DEBUG-MODE ((self IDEBUG-DRAW))
  (IDEBUG-DRAW/GET-DEBUG-MODE (ff-pointer self)))

(defmethod DRAW-AABB ((self IDEBUG-DRAW) (from VECTOR3) (to VECTOR3) (color VECTOR3))
  (IDEBUG-DRAW/DRAW-AABB (ff-pointer self) from to color))

(defmethod DRAW-TRANSFORM ((self IDEBUG-DRAW) (transform TRANSFORM) (orthoLen number))
  (IDEBUG-DRAW/DRAW-TRANSFORM (ff-pointer self) transform orthoLen))
#+ (or)

(defmethod DRAW-ARC ((self IDEBUG-DRAW) (center VECTOR3) (normal VECTOR3) (axis VECTOR3) (radiusA number) (radiusB number) (minAngle number) (maxAngle number) (color VECTOR3) (drawSect-p t) (stepDegrees number))
  (IDEBUG-DRAW/DRAW-ARC (ff-pointer self) center normal axis radiusA radiusB minAngle maxAngle color drawSect stepDegrees))
#+ (or)

(defmethod DRAW-ARC ((self IDEBUG-DRAW) (center VECTOR3) (normal VECTOR3) (axis VECTOR3) (radiusA number) (radiusB number) (minAngle number) (maxAngle number) (color VECTOR3) (drawSect-p t))
  (IDEBUG-DRAW/DRAW-ARC (ff-pointer self) center normal axis radiusA radiusB minAngle maxAngle color drawSect))
#+ (or)

(defmethod DRAW-SPHERE-PATCH ((self IDEBUG-DRAW) (center VECTOR3) (up VECTOR3) (axis VECTOR3) (radius number) (minTh number) (maxTh number) (minPs number) (maxPs number) (color VECTOR3) (stepDegrees number) (drawCenter-p t))
  (IDEBUG-DRAW/DRAW-SPHERE-PATCH (ff-pointer self) center up axis radius minTh maxTh minPs maxPs color stepDegrees drawCenter))
#+ (or)

(defmethod DRAW-SPHERE-PATCH ((self IDEBUG-DRAW) (center VECTOR3) (up VECTOR3) (axis VECTOR3) (radius number) (minTh number) (maxTh number) (minPs number) (maxPs number) (color VECTOR3) (stepDegrees number))
  (IDEBUG-DRAW/DRAW-SPHERE-PATCH (ff-pointer self) center up axis radius minTh maxTh minPs maxPs color stepDegrees))

(defmethod DRAW-SPHERE-PATCH ((self IDEBUG-DRAW) (center VECTOR3) (up VECTOR3) (axis VECTOR3) (radius number) (minTh number) (maxTh number) (minPs number) (maxPs number) (color VECTOR3))
  (IDEBUG-DRAW/DRAW-SPHERE-PATCH (ff-pointer self) center up axis radius minTh maxTh minPs maxPs color))
#+ (or)

(defmethod DRAW-BOX ((self IDEBUG-DRAW) (bbMin VECTOR3) (bbMax VECTOR3) (color VECTOR3))
  (IDEBUG-DRAW/DRAW-BOX (ff-pointer self) bbMin bbMax color))

(defmethod DRAW-BOX ((self IDEBUG-DRAW) (bbMin VECTOR3) (bbMax VECTOR3) (trans TRANSFORM) (color VECTOR3))
  (IDEBUG-DRAW/DRAW-BOX (ff-pointer self) bbMin bbMax trans color))

(defmethod DRAW-CAPSULE ((self IDEBUG-DRAW) (radius number) (halfHeight number) (upAxis integer) (transform TRANSFORM) (color VECTOR3))
  (IDEBUG-DRAW/DRAW-CAPSULE (ff-pointer self) radius halfHeight upAxis transform color))

(defmethod DRAW-CYLINDER ((self IDEBUG-DRAW) (radius number) (halfHeight number) (upAxis integer) (transform TRANSFORM) (color VECTOR3))
  (IDEBUG-DRAW/DRAW-CYLINDER (ff-pointer self) radius halfHeight upAxis transform color))

(defmethod DRAW-CONE ((self IDEBUG-DRAW) (radius number) (height number) (upAxis integer) (transform TRANSFORM) (color VECTOR3))
  (IDEBUG-DRAW/DRAW-CONE (ff-pointer self) radius height upAxis transform color))

(defmethod DRAW-PLANE ((self IDEBUG-DRAW) (planeNormal VECTOR3) (planeConst number) (transform TRANSFORM) (color VECTOR3))
  (IDEBUG-DRAW/DRAW-PLANE (ff-pointer self) planeNormal planeConst transform color))

(defmethod (setf CHUNK-CODE) ( (obj CHUNK) arg0)
  (CHUNK/CHUNK-CODE/SET (ff-pointer obj) arg0))

(defmethod CHUNK-CODE ((obj CHUNK))
  (CHUNK/CHUNK-CODE/GET (ff-pointer obj)))

(defmethod (setf BULLET/LENGTH) ( (obj CHUNK) arg0)
  (CHUNK/LENGTH/SET (ff-pointer obj) arg0))

(defmethod BULLET/LENGTH ((obj CHUNK))
  (CHUNK/LENGTH/GET (ff-pointer obj)))

(defmethod (setf OLD-PTR) ( (obj CHUNK) arg0)
  (CHUNK/OLD-PTR/SET (ff-pointer obj) arg0))

(defmethod OLD-PTR ((obj CHUNK))
  (CHUNK/OLD-PTR/GET (ff-pointer obj)))

(defmethod (setf DNA/NR) ( (obj CHUNK) arg0)
  (CHUNK/DNA/NR/SET (ff-pointer obj) arg0))

(defmethod DNA/NR ((obj CHUNK))
  (CHUNK/DNA/NR/GET (ff-pointer obj)))

(defmethod (setf BULLET/NUMBER) ( (obj CHUNK) arg0)
  (CHUNK/NUMBER/SET (ff-pointer obj) arg0))

(defmethod BULLET/NUMBER ((obj CHUNK))
  (CHUNK/NUMBER/GET (ff-pointer obj)))

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

(defmethod ->serial-NAME ((self SERIALIZER) (ptr string))
  (SERIALIZER/SERIALIZE-NAME (ff-pointer self) ptr))

(defmethod SERIALIZATION-FLAGS ((self SERIALIZER))
  (SERIALIZER/GET-SERIALIZATION-FLAGS (ff-pointer self)))

(defmethod (SETF SERIALIZATION-FLAGS) ( (flags integer) (self SERIALIZER))
  (SERIALIZER/SET-SERIALIZATION-FLAGS (ff-pointer self) flags))

(defmethod initialize-instance :after ((obj DEFAULT-SERIALIZER) &key (total-Size nil))
  (check-type total-size (or null integer))
  (setf (slot-value obj 'ff-pointer) 
        (cond
          (total-size (MAKE-DEFAULT-SERIALIZER/with-total-size total-Size))
          (t (MAKE-DEFAULT-SERIALIZER)))))

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

(defmethod ->serial-NAME ((self DEFAULT-SERIALIZER) (name string))
  (DEFAULT-SERIALIZER/SERIALIZE-NAME (ff-pointer self) name))

(defmethod SERIALIZATION-FLAGS ((self DEFAULT-SERIALIZER))
  (DEFAULT-SERIALIZER/GET-SERIALIZATION-FLAGS (ff-pointer self)))

(defmethod (SETF SERIALIZATION-FLAGS) ( (flags integer) (self DEFAULT-SERIALIZER))
  (DEFAULT-SERIALIZER/SET-SERIALIZATION-FLAGS (ff-pointer self) flags))
#+(or) (defmethod NEW ((self DISCRETE-DYNAMICS-WORLD) sizeInBytes)
  (DISCRETE-DYNAMICS-WORLD/MAKE-C++-INSTANCE (ff-pointer self) sizeInBytes))
#+(or) (defmethod DELETE((self DISCRETE-DYNAMICS-WORLD) ptr)
  (DISCRETE-DYNAMICS-WORLD/DELETE-C++-INSTANCE (ff-pointer self) ptr))
#+(or) (defmethod NEW ((self DISCRETE-DYNAMICS-WORLD) arg1 ptr)
  (DISCRETE-DYNAMICS-WORLD/MAKE-C++-INSTANCE/with-arg1&ptr (ff-pointer self) arg1 ptr))
#+(or) (defmethod DELETE((self DISCRETE-DYNAMICS-WORLD) arg1 arg2)
  (DISCRETE-DYNAMICS-WORLD/DELETE-C++-INSTANCE/with-arg1&2 (ff-pointer self) arg1 arg2))
#+(or) (defmethod NEW[] ((self DISCRETE-DYNAMICS-WORLD) sizeInBytes)
  (DISCRETE-DYNAMICS-WORLD/MAKE-C++-ARRAY (ff-pointer self) sizeInBytes))
#+(or) (defmethod DELETE[] ((self DISCRETE-DYNAMICS-WORLD) ptr)
  (DISCRETE-DYNAMICS-WORLD/DELETE-C++-ARRAY (ff-pointer self) ptr))
#+(or) (defmethod NEW[] ((self DISCRETE-DYNAMICS-WORLD) arg1 ptr)
  (DISCRETE-DYNAMICS-WORLD/MAKE-C++-ARRAY/with-arg1&ptr (ff-pointer self) arg1 ptr))
#+(or) (defmethod DELETE[] ((self DISCRETE-DYNAMICS-WORLD) arg1 arg2)
  (DISCRETE-DYNAMICS-WORLD/DELETE-C++-ARRAY/with-arg1&2 (ff-pointer self) arg1 arg2))

(defmethod initialize-instance :after ((obj DISCRETE-DYNAMICS-WORLD) &key dispatcher pairCache constraintSolver collisionConfiguration)
  (setf (slot-value obj 'ff-pointer) (MAKE-DISCRETE-DYNAMICS-WORLD dispatcher pairCache constraintSolver collisionConfiguration)))

(defmethod STEP-SIMULATION ((self DISCRETE-DYNAMICS-WORLD) (time-step number)
                            &optional max-sub-steps fixed-time-step)
  (check-type max-sub-steps (or null number))
  (check-type fixed-time-step (or null number))
  (cond
    ((and fixed-time-Step max-Sub-Steps)
     (DISCRETE-DYNAMICS-WORLD/STEP-SIMULATION/WITH-TIME-STEP&max-sub-steps&fixed-time-step
      (ff-pointer self) time-Step max-Sub-Steps fixed-Time-Step))
    (max-sub-steps
     (DISCRETE-DYNAMICS-WORLD/STEP-SIMULATION/WITH-TIME-STEP&max-sub-steps
      (ff-pointer self) time-Step max-Sub-Steps))
    (t
     (DISCRETE-DYNAMICS-WORLD/STEP-SIMULATION/with-time-step (ff-pointer self) time-Step))))


(defmethod SYNCHRONIZE-MOTION-STATES ((self DISCRETE-DYNAMICS-WORLD))
  (DISCRETE-DYNAMICS-WORLD/SYNCHRONIZE-MOTION-STATES (ff-pointer self)))

(defmethod SYNCHRONIZE-SINGLE-MOTION-STATE ((self DISCRETE-DYNAMICS-WORLD) body)
  (DISCRETE-DYNAMICS-WORLD/SYNCHRONIZE-SINGLE-MOTION-STATE (ff-pointer self) body))

(defmethod ADD-CONSTRAINT ((self DISCRETE-DYNAMICS-WORLD) constraint
                           &key (disable-Collisions-Between-Linked-Bodies-p t disable?))
  (if disable?
      (DISCRETE-DYNAMICS-WORLD/ADD-CONSTRAINT/WITH-DISABLE-COLLISION-BETWEEN-LINKED-BODIES
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

(defmethod (SETF GRAVITY) ( (gravity VECTOR3) (self DISCRETE-DYNAMICS-WORLD))
  (DISCRETE-DYNAMICS-WORLD/SET-GRAVITY (ff-pointer self) gravity))

