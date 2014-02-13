(in-package #:bullet-physics)
(cffi:defcfun ("_wrap_btCollisionWorld_getForceUpdateAllAabbs"
               COLLISION-WORLD/GET-FORCE-UPDATE-ALL-AABBS) :pointer
  (self :pointer))
(declaim (inline COLLISION-WORLD/SET-FORCE-UPDATE-ALL-AABBS))
(cffi:defcfun ("_wrap_btCollisionWorld_setForceUpdateAllAabbs"
               COLLISION-WORLD/SET-FORCE-UPDATE-ALL-AABBS) :void
  (self :pointer)
  (forceUpdateAllAabbs :pointer))
(declaim (inline COLLISION-WORLD/SERIALIZE))
(cffi:defcfun ("_wrap_btCollisionWorld_serialize"
               COLLISION-WORLD/SERIALIZE) :void
  (self :pointer)
  (serializer :pointer))
(define-constant +ACTIVE-TAG+ 1)
(define-constant +ISLAND-SLEEPING+ 2)
(define-constant +WANTS-DEACTIVATION+ 3)
(define-constant +DISABLE-DEACTIVATION+ 4)
(define-constant +DISABLE-SIMULATION+ 5)
(cffi:defcenum COLLISION-FLAGS
  (:STATIC-OBJECT 1)
  (:KINEMATIC-OBJECT 2)
  (:NO-CONTACT-RESPONSE 4)
  (:CUSTOM-MATERIAL-CALLBACK 8)
  (:CHARACTER-OBJECT 16)
  (:DISABLE-VISUALIZE-OBJECT #.32)
  (:DISABLE-SPU-COLLISION-PROCESSING #.64))
(cffi:defcenum ANISOTROPIC-FRICTION-FLAGS
  (:ANISOTROPIC-FRICTION-DISABLED 0)
  (:ANISOTROPIC-FRICTION 1)
  (:ANISOTROPIC-ROLLING-FRICTION 2))
(declaim (inline BOX-SHAPE/MAKE-c++-INSTANCE))
(cffi:defcfun ("_wrap_btBoxShape_makeCPlusPlusInstance__SWIG_0"
               BOX-SHAPE/MAKE-c++-INSTANCE) :pointer
  (self :pointer)
  (sizeInBytes :pointer))
(declaim (inline BOX-SHAPE/DELETE-c++-INSTANCE))
(cffi:defcfun ("_wrap_btBoxShape_deleteCPlusPlusInstance__SWIG_0"
               BOX-SHAPE/DELETE-c++-INSTANCE) :void
  (self :pointer)
  (ptr :pointer))
(declaim (inline BOX-SHAPE/MAKE-c++-INSTANCE))
(cffi:defcfun ("_wrap_btBoxShape_makeCPlusPlusInstance__SWIG_1"
               BOX-SHAPE/MAKE-c++-INSTANCE/with-arg1&ptr) :pointer
  (self :pointer)
  (arg1 :pointer)
  (ptr :pointer))
(declaim (inline BOX-SHAPE/DELETE-c++-INSTANCE))
(cffi:defcfun ("_wrap_btBoxShape_deleteCPlusPlusInstance__SWIG_1"
               BOX-SHAPE/DELETE-c++-INSTANCE/with-arg1&2) :void
  (self :pointer)
  (arg1 :pointer)
  (arg2 :pointer))
(declaim (inline BOX-SHAPE/MAKE-c++-ARRAY))
(cffi:defcfun ("_wrap_btBoxShape_makeCPlusArray__SWIG_0"
               BOX-SHAPE/MAKE-c++-ARRAY) :pointer
  (self :pointer)
  (sizeInBytes :pointer))
(declaim (inline BOX-SHAPE/DELETE-c++-ARRAY))
(cffi:defcfun ("_wrap_btBoxShape_deleteCPlusArray__SWIG_0"
               BOX-SHAPE/DELETE-c++-ARRAY) :void
  (self :pointer)
  (ptr :pointer))
(declaim (inline BOX-SHAPE/MAKE-c++-ARRAY))
(cffi:defcfun ("_wrap_btBoxShape_makeCPlusArray__SWIG_1"
               BOX-SHAPE/MAKE-c++-ARRAY/with-arg1&ptr) :pointer
  (self :pointer)
  (arg1 :pointer)
  (ptr :pointer))
(declaim (inline BOX-SHAPE/DELETE-c++-ARRAY))
(cffi:defcfun ("_wrap_btBoxShape_deleteCPlusArray__SWIG_1"
               BOX-SHAPE/DELETE-c++-ARRAY/with-arg1&2) :void
  (self :pointer)
  (arg1 :pointer)
  (arg2 :pointer))
(declaim (inline BOX-SHAPE/GET-HALF-EXTENTS-WITH-MARGIN))
(cffi:defcfun ("_wrap_btBoxShape_getHalfExtentsWithMargin"
               BOX-SHAPE/GET-HALF-EXTENTS-WITH-MARGIN) :pointer
  (self :pointer))
(declaim (inline BOX-SHAPE/GET-HALF-EXTENTS-WITHOUT-MARGIN))
(cffi:defcfun ("_wrap_btBoxShape_getHalfExtentsWithoutMargin"
               BOX-SHAPE/GET-HALF-EXTENTS-WITHOUT-MARGIN) :pointer
  (self :pointer))
(declaim (inline BOX-SHAPE/LOCAL-GET-SUPPORTING-VERTEX))
(cffi:defcfun ("_wrap_btBoxShape_localGetSupportingVertex"
               BOX-SHAPE/LOCAL-GET-SUPPORTING-VERTEX) :pointer
  (self :pointer)
  (vec :pointer))
(declaim (inline BOX-SHAPE/LOCAL-GET-SUPPORTING-VERTEX-WITHOUT-MARGIN))
(cffi:defcfun ("_wrap_btBoxShape_localGetSupportingVertexWithoutMargin"
               BOX-SHAPE/LOCAL-GET-SUPPORTING-VERTEX-WITHOUT-MARGIN) :pointer
  (self :pointer)
  (vec :pointer))
(declaim (inline BOX-SHAPE/BATCHED-UNIT-VECTOR-GET-SUPPORTING-VERTEX-WITHOUT-MARGIN))
(cffi:defcfun ("_wrap_btBoxShape_batchedUnitVectorGetSupportingVertexWithoutMargin"
               BOX-SHAPE/BATCHED-UNIT-VECTOR-GET-SUPPORTING-VERTEX-WITHOUT-MARGIN) :void
  (self :pointer)
  (vectors :pointer)
  (supportVerticesOut :pointer)
  (numVectors :int))
(declaim (inline MAKE-BOX-SHAPE))
(cffi:defcfun ("_wrap_new_btBoxShape"
               MAKE-BOX-SHAPE) :pointer
  (boxHalfExtents :pointer))
(declaim (inline BOX-SHAPE/SET-MARGIN))
(cffi:defcfun ("_wrap_btBoxShape_setMargin"
               BOX-SHAPE/SET-MARGIN) :void
  (self :pointer)
  (collisionMargin :float))
(declaim (inline BOX-SHAPE/SET-LOCAL-SCALING))
(cffi:defcfun ("_wrap_btBoxShape_setLocalScaling"
               BOX-SHAPE/SET-LOCAL-SCALING) :void
  (self :pointer)
  (scaling :pointer))
(declaim (inline BOX-SHAPE/GET-AABB))
(cffi:defcfun ("_wrap_btBoxShape_getAabb"
               BOX-SHAPE/GET-AABB) :void
  (self :pointer)
  (t_arg1 :pointer)
  (aabbMin :pointer)
  (aabbMax :pointer))
(declaim (inline BOX-SHAPE/CALCULATE-LOCAL-INERTIA))
(cffi:defcfun ("_wrap_btBoxShape_calculateLocalInertia"
               BOX-SHAPE/CALCULATE-LOCAL-INERTIA) :void
  (self :pointer)
  (mass :float)
  (inertia :pointer))
(declaim (inline BOX-SHAPE/GET-PLANE))
(cffi:defcfun ("_wrap_btBoxShape_getPlane"
               BOX-SHAPE/GET-PLANE) :void
  (self :pointer)
  (planeNormal :pointer)
  (planeSupport :pointer)
  (i :int))
(declaim (inline BOX-SHAPE/GET-NUM-PLANES))
(cffi:defcfun ("_wrap_btBoxShape_getNumPlanes"
               BOX-SHAPE/GET-NUM-PLANES) :int
  (self :pointer))
(declaim (inline BOX-SHAPE/GET-NUM-VERTICES))
(cffi:defcfun ("_wrap_btBoxShape_getNumVertices"
               BOX-SHAPE/GET-NUM-VERTICES) :int
  (self :pointer))
(declaim (inline BOX-SHAPE/GET-NUM-EDGES))
(cffi:defcfun ("_wrap_btBoxShape_getNumEdges"
               BOX-SHAPE/GET-NUM-EDGES) :int
  (self :pointer))
(declaim (inline BOX-SHAPE/GET-VERTEX))
(cffi:defcfun ("_wrap_btBoxShape_getVertex"
               BOX-SHAPE/GET-VERTEX) :void
  (self :pointer)
  (i :int)
  (vtx :pointer))
(declaim (inline BOX-SHAPE/GET-PLANE-EQUATION))
(cffi:defcfun ("_wrap_btBoxShape_getPlaneEquation"
               BOX-SHAPE/GET-PLANE-EQUATION) :void
  (self :pointer)
  (plane :pointer)
  (i :int))
(declaim (inline BOX-SHAPE/GET-EDGE))
(cffi:defcfun ("_wrap_btBoxShape_getEdge"
               BOX-SHAPE/GET-EDGE) :void
  (self :pointer)
  (i :int)
  (pa :pointer)
  (pb :pointer))
(declaim (inline BOX-SHAPE/IS-INSIDE))
(cffi:defcfun ("_wrap_btBoxShape_isInside"
               BOX-SHAPE/IS-INSIDE) :pointer
  (self :pointer)
  (pt :pointer)
  (tolerance :float))
(declaim (inline BOX-SHAPE/GET-NAME))
(cffi:defcfun ("_wrap_btBoxShape_getName"
               BOX-SHAPE/GET-NAME) :string
  (self :pointer))
(declaim (inline BOX-SHAPE/GET-NUM-PREFERRED-PENETRATION-DIRECTIONS))
(cffi:defcfun ("_wrap_btBoxShape_getNumPreferredPenetrationDirections"
               BOX-SHAPE/GET-NUM-PREFERRED-PENETRATION-DIRECTIONS) :int
  (self :pointer))
(declaim (inline BOX-SHAPE/GET-PREFERRED-PENETRATION-DIRECTION))
(cffi:defcfun ("_wrap_btBoxShape_getPreferredPenetrationDirection"
               BOX-SHAPE/GET-PREFERRED-PENETRATION-DIRECTION) :void
  (self :pointer)
  (index :int)
  (penetrationVector :pointer))
(declaim (inline DELETE/BT-BOX-SHAPE))
(cffi:defcfun ("_wrap_delete_btBoxShape"
               DELETE/BT-BOX-SHAPE) :void
  (self :pointer))
(declaim (inline SPHERE-SHAPE/MAKE-c++-INSTANCE))
(cffi:defcfun ("_wrap_btSphereShape_makeCPlusPlusInstance__SWIG_0"
               SPHERE-SHAPE/MAKE-c++-INSTANCE) :pointer
  (self :pointer)
  (sizeInBytes :pointer))
(declaim (inline SPHERE-SHAPE/DELETE-c++-INSTANCE))
(cffi:defcfun ("_wrap_btSphereShape_deleteCPlusPlusInstance__SWIG_0"
               SPHERE-SHAPE/DELETE-c++-INSTANCE) :void
  (self :pointer)
  (ptr :pointer))
(declaim (inline SPHERE-SHAPE/MAKE-c++-INSTANCE))
(cffi:defcfun ("_wrap_btSphereShape_makeCPlusPlusInstance__SWIG_1"
               SPHERE-SHAPE/MAKE-c++-INSTANCE/with-arg1&ptr) :pointer
  (self :pointer)
  (arg1 :pointer)
  (ptr :pointer))
(declaim (inline SPHERE-SHAPE/DELETE-c++-INSTANCE))
(cffi:defcfun ("_wrap_btSphereShape_deleteCPlusPlusInstance__SWIG_1"
               SPHERE-SHAPE/DELETE-c++-INSTANCE/with-arg1&2) :void
  (self :pointer)
  (arg1 :pointer)
  (arg2 :pointer))
(declaim (inline SPHERE-SHAPE/MAKE-c++-ARRAY))
(cffi:defcfun ("_wrap_btSphereShape_makeCPlusArray__SWIG_0"
               SPHERE-SHAPE/MAKE-c++-ARRAY) :pointer
  (self :pointer)
  (sizeInBytes :pointer))
(declaim (inline SPHERE-SHAPE/DELETE-c++-ARRAY))
(cffi:defcfun ("_wrap_btSphereShape_deleteCPlusArray__SWIG_0"
               SPHERE-SHAPE/DELETE-c++-ARRAY) :void
  (self :pointer)
  (ptr :pointer))
(declaim (inline SPHERE-SHAPE/MAKE-c++-ARRAY))
(cffi:defcfun ("_wrap_btSphereShape_makeCPlusArray__SWIG_1"
               SPHERE-SHAPE/MAKE-c++-ARRAY/with-arg1&ptr) :pointer
  (self :pointer)
  (arg1 :pointer)
  (ptr :pointer))
(declaim (inline SPHERE-SHAPE/DELETE-c++-ARRAY))
(cffi:defcfun ("_wrap_btSphereShape_deleteCPlusArray__SWIG_1"
               SPHERE-SHAPE/DELETE-c++-ARRAY/with-arg1&2) :void
  (self :pointer)
  (arg1 :pointer)
  (arg2 :pointer))
(declaim (inline MAKE-SPHERE-SHAPE))
(cffi:defcfun ("_wrap_new_btSphereShape"
               MAKE-SPHERE-SHAPE) :pointer
  (radius :float))
(declaim (inline SPHERE-SHAPE/LOCAL-GET-SUPPORTING-VERTEX))
(cffi:defcfun ("_wrap_btSphereShape_localGetSupportingVertex"
               SPHERE-SHAPE/LOCAL-GET-SUPPORTING-VERTEX) :pointer
  (self :pointer)
  (vec :pointer))
(declaim (inline SPHERE-SHAPE/LOCAL-GET-SUPPORTING-VERTEX-WITHOUT-MARGIN))
(cffi:defcfun ("_wrap_btSphereShape_localGetSupportingVertexWithoutMargin"
               SPHERE-SHAPE/LOCAL-GET-SUPPORTING-VERTEX-WITHOUT-MARGIN) :pointer
  (self :pointer)
  (vec :pointer))
(declaim (inline SPHERE-SHAPE/BATCHED-UNIT-VECTOR-GET-SUPPORTING-VERTEX-WITHOUT-MARGIN))
(cffi:defcfun ("_wrap_btSphereShape_batchedUnitVectorGetSupportingVertexWithoutMargin"
               SPHERE-SHAPE/BATCHED-UNIT-VECTOR-GET-SUPPORTING-VERTEX-WITHOUT-MARGIN) :void
  (self :pointer)
  (vectors :pointer)
  (supportVerticesOut :pointer)
  (numVectors :int))
(declaim (inline SPHERE-SHAPE/CALCULATE-LOCAL-INERTIA))
(cffi:defcfun ("_wrap_btSphereShape_calculateLocalInertia"
               SPHERE-SHAPE/CALCULATE-LOCAL-INERTIA) :void
  (self :pointer)
  (mass :float)
  (inertia :pointer))
(declaim (inline SPHERE-SHAPE/GET-AABB))
(cffi:defcfun ("_wrap_btSphereShape_getAabb"
               SPHERE-SHAPE/GET-AABB) :void
  (self :pointer)
  (t_arg1 :pointer)
  (aabbMin :pointer)
  (aabbMax :pointer))
(declaim (inline SPHERE-SHAPE/GET-RADIUS))
(cffi:defcfun ("_wrap_btSphereShape_getRadius"
               SPHERE-SHAPE/GET-RADIUS) :float
  (self :pointer))
(declaim (inline SPHERE-SHAPE/SET-UNSCALED-RADIUS))
(cffi:defcfun ("_wrap_btSphereShape_setUnscaledRadius"
               SPHERE-SHAPE/SET-UNSCALED-RADIUS) :void
  (self :pointer)
  (radius :float))
(declaim (inline SPHERE-SHAPE/GET-NAME))
(cffi:defcfun ("_wrap_btSphereShape_getName"
               SPHERE-SHAPE/GET-NAME) :string
  (self :pointer))
(declaim (inline SPHERE-SHAPE/SET-MARGIN))
(cffi:defcfun ("_wrap_btSphereShape_setMargin"
               SPHERE-SHAPE/SET-MARGIN) :void
  (self :pointer)
  (margin :float))
(declaim (inline SPHERE-SHAPE/GET-MARGIN))
(cffi:defcfun ("_wrap_btSphereShape_getMargin"
               SPHERE-SHAPE/GET-MARGIN) :float
  (self :pointer))
(declaim (inline DELETE/BT-SPHERE-SHAPE))
(cffi:defcfun ("_wrap_delete_btSphereShape"
               DELETE/BT-SPHERE-SHAPE) :void
  (self :pointer))
(declaim (inline CAPSULE-SHAPE/MAKE-c++-INSTANCE))
(cffi:defcfun ("_wrap_btCapsuleShape_makeCPlusPlusInstance__SWIG_0"
               cAPSULE-SHAPE/MAKE-c++-INSTANCE) :pointer
  (self :pointer)
  (sizeInBytes :pointer))
(declaim (inline CAPSULE-SHAPE/DELETE-c++-INSTANCE))
(cffi:defcfun ("_wrap_btCapsuleShape_deleteCPlusPlusInstance__SWIG_0"
               cAPSULE-SHAPE/DELETE-c++-INSTANCE) :void
  (self :pointer)
  (ptr :pointer))
(declaim (inline CAPSULE-SHAPE/MAKE-c++-INSTANCE))
(cffi:defcfun ("_wrap_btCapsuleShape_makeCPlusPlusInstance__SWIG_1"
               CAPSULE-SHAPE/MAKE-c++-INSTANCE/with-arg1&ptr) :pointer
  (self :pointer)
  (arg1 :pointer)
  (ptr :pointer))
(declaim (inline CAPSULE-SHAPE/DELETE-c++-INSTANCE))
(cffi:defcfun ("_wrap_btCapsuleShape_deleteCPlusPlusInstance__SWIG_1"
               CAPSULE-SHAPE/DELETE-C++-INSTANCE/with-arg1&2) :void
  (self :pointer)
  (arg1 :pointer)
  (arg2 :pointer))
(declaim (inline CAPSULE-SHAPE/MAKE-c++-ARRAY))
(cffi:defcfun ("_wrap_btCapsuleShape_makeCPlusArray__SWIG_0"
               cAPSULE-SHAPE/MAKE-c++-ARRAY) :pointer
  (self :pointer)
  (sizeInBytes :pointer))
(declaim (inline CAPSULE-SHAPE/DELETE-c++-ARRAY))
(cffi:defcfun ("_wrap_btCapsuleShape_deleteCPlusArray__SWIG_0"
               cAPSULE-SHAPE/DELETE-c++-ARRAY) :void
  (self :pointer)
  (ptr :pointer))
(declaim (inline CAPSULE-SHAPE/MAKE-c++-ARRAY))
(cffi:defcfun ("_wrap_btCapsuleShape_makeCPlusArray__SWIG_1"
               CAPSULE-SHAPE/MAKE-C++-ARRAY/with-arg1&ptr) :pointer
  (self :pointer)
  (arg1 :pointer)
  (ptr :pointer))
(declaim (inline CAPSULE-SHAPE/DELETE-c++-ARRAY))
(cffi:defcfun ("_wrap_btCapsuleShape_deleteCPlusArray__SWIG_1"
               CAPSULE-SHAPE/DELETE-c++-ARRAY/with-arg1&2) :void
  (self :pointer)
  (arg1 :pointer)
  (arg2 :pointer))
(declaim (inline MAKE-CAPSULE-SHAPE))
(cffi:defcfun ("_wrap_new_btCapsuleShape__SWIG_1"
               MAKE-CAPSULE-SHAPE) :pointer
  (radius :float)
  (height :float))
(declaim (inline CAPSULE-SHAPE/CALCULATE-LOCAL-INERTIA))
(cffi:defcfun ("_wrap_btCapsuleShape_calculateLocalInertia"
               cAPSULE-SHAPE/CALCULATE-LOCAL-INERTIA) :void
  (self :pointer)
  (mass :float)
  (inertia :pointer))
(declaim (inline CAPSULE-SHAPE/LOCAL-GET-SUPPORTING-VERTEX-WITHOUT-MARGIN))
(cffi:defcfun ("_wrap_btCapsuleShape_localGetSupportingVertexWithoutMargin"
               cAPSULE-SHAPE/LOCAL-GET-SUPPORTING-VERTEX-WITHOUT-MARGIN) :pointer
  (self :pointer)
  (vec :pointer))
(declaim (inline CAPSULE-SHAPE/BATCHED-UNIT-VECTOR-GET-SUPPORTING-VERTEX-WITHOUT-MARGIN))
(cffi:defcfun ("_wrap_btCapsuleShape_batchedUnitVectorGetSupportingVertexWithoutMargin"
               cAPSULE-SHAPE/BATCHED-UNIT-VECTOR-GET-SUPPORTING-VERTEX-WITHOUT-MARGIN) :void
  (self :pointer)
  (vectors :pointer)
  (supportVerticesOut :pointer)
  (numVectors :int))
(declaim (inline CAPSULE-SHAPE/SET-MARGIN))
(cffi:defcfun ("_wrap_btCapsuleShape_setMargin"
               cAPSULE-SHAPE/SET-MARGIN) :void
  (self :pointer)
  (collisionMargin :float))
(declaim (inline CAPSULE-SHAPE/GET-AABB))
(cffi:defcfun ("_wrap_btCapsuleShape_getAabb"
               cAPSULE-SHAPE/GET-AABB) :void
  (self :pointer)
  (t_arg1 :pointer)
  (aabbMin :pointer)
  (aabbMax :pointer))
(declaim (inline CAPSULE-SHAPE/GET-NAME))
(cffi:defcfun ("_wrap_btCapsuleShape_getName"
               cAPSULE-SHAPE/GET-NAME) :string
  (self :pointer))
(declaim (inline CAPSULE-SHAPE/GET-UP-AXIS))
(cffi:defcfun ("_wrap_btCapsuleShape_getUpAxis"
               cAPSULE-SHAPE/GET-UP-AXIS) :int
  (self :pointer))
(declaim (inline CAPSULE-SHAPE/GET-RADIUS))
(cffi:defcfun ("_wrap_btCapsuleShape_getRadius"
               cAPSULE-SHAPE/GET-RADIUS) :float
  (self :pointer))
(declaim (inline CAPSULE-SHAPE/GET-HALF-HEIGHT))
(cffi:defcfun ("_wrap_btCapsuleShape_getHalfHeight"
               cAPSULE-SHAPE/GET-HALF-HEIGHT) :float
  (self :pointer))
(declaim (inline CAPSULE-SHAPE/SET-LOCAL-SCALING))
(cffi:defcfun ("_wrap_btCapsuleShape_setLocalScaling"
               cAPSULE-SHAPE/SET-LOCAL-SCALING) :void
  (self :pointer)
  (scaling :pointer))
(declaim (inline CAPSULE-SHAPE/GET-ANISOTROPIC-ROLLING-FRICTION-DIRECTION))
(cffi:defcfun ("_wrap_btCapsuleShape_getAnisotropicRollingFrictionDirection"
               cAPSULE-SHAPE/GET-ANISOTROPIC-ROLLING-FRICTION-DIRECTION) :pointer
  (self :pointer))
(declaim (inline CAPSULE-SHAPE/CALCULATE-SERIALIZE-BUFFER-SIZE))
(cffi:defcfun ("_wrap_btCapsuleShape_calculateSerializeBufferSize"
               cAPSULE-SHAPE/CALCULATE-SERIALIZE-BUFFER-SIZE) :int
  (self :pointer))
(declaim (inline CAPSULE-SHAPE/SERIALIZE))
(cffi:defcfun ("_wrap_btCapsuleShape_serialize"
               cAPSULE-SHAPE/SERIALIZE) :string
  (self :pointer)
  (dataBuffer :pointer)
  (serializer :pointer))
(declaim (inline DELETE/BT-CAPSULE-SHAPE))
(cffi:defcfun ("_wrap_delete_btCapsuleShape"
               DELETE/BT-CAPSULE-SHAPE) :void
  (self :pointer))
(declaim (inline MAKE-CAPSULE-SHAPE-X))
(cffi:defcfun ("_wrap_new_btCapsuleShapeX"
               MAKE-CAPSULE-SHAPE-X) :pointer
  (radius :float)
  (height :float))
(declaim (inline CAPSULE-SHAPE-X/GET-NAME))
(cffi:defcfun ("_wrap_btCapsuleShapeX_getName"
               cAPSULE-SHAPE-X/GET-NAME) :string
  (self :pointer))
(declaim (inline DELETE/BT-CAPSULE-SHAPE-X))
(cffi:defcfun ("_wrap_delete_btCapsuleShapeX"
               DELETE/BT-CAPSULE-SHAPE-X) :void
  (self :pointer))
(declaim (inline MAKE-CAPSULE-SHAPE-Z))
(cffi:defcfun ("_wrap_new_btCapsuleShapeZ"
               MAKE-CAPSULE-SHAPE-Z) :pointer
  (radius :float)
  (height :float))
(declaim (inline CAPSULE-SHAPE-Z/GET-NAME))
(cffi:defcfun ("_wrap_btCapsuleShapeZ_getName"
               cAPSULE-SHAPE-Z/GET-NAME) :string
  (self :pointer))
(declaim (inline DELETE/BT-CAPSULE-SHAPE-Z))
(cffi:defcfun ("_wrap_delete_btCapsuleShapeZ"
               DELETE/BT-CAPSULE-SHAPE-Z) :void
  (self :pointer))

(declaim (inline CYLINDER-SHAPE/MAKE-c++-INSTANCE))
(cffi:defcfun ("_wrap_btCylinderShape_makeCPlusPlusInstance__SWIG_0"
               cYLINDER-SHAPE/MAKE-c++-INSTANCE) :pointer
  (self :pointer)
  (sizeInBytes :pointer))
(declaim (inline CYLINDER-SHAPE/DELETE-c++-INSTANCE))
(cffi:defcfun ("_wrap_btCylinderShape_deleteCPlusPlusInstance__SWIG_0"
               cYLINDER-SHAPE/DELETE-c++-INSTANCE) :void
  (self :pointer)
  (ptr :pointer))
(declaim (inline CYLINDER-SHAPE/MAKE-c++-INSTANCE))
(cffi:defcfun ("_wrap_btCylinderShape_makeCPlusPlusInstance__SWIG_1"
               CYLINDER-SHAPE/MAKE-c++-INSTANCE/with-arg1&ptr) :pointer
  (self :pointer)
  (arg1 :pointer)
  (ptr :pointer))
(declaim (inline CYLINDER-SHAPE/DELETE-c++-INSTANCE))
(cffi:defcfun ("_wrap_btCylinderShape_deleteCPlusPlusInstance__SWIG_1"
               CYLINDER-SHAPE/DELETE-C++-INSTANCE/with-arg1&2) :void
  (self :pointer)
  (arg1 :pointer)
  (arg2 :pointer))
(declaim (inline CYLINDER-SHAPE/MAKE-c++-ARRAY))
(cffi:defcfun ("_wrap_btCylinderShape_makeCPlusArray__SWIG_0"
               cYLINDER-SHAPE/MAKE-c++-ARRAY) :pointer
  (self :pointer)
  (sizeInBytes :pointer))
(declaim (inline CYLINDER-SHAPE/DELETE-c++-ARRAY))
(cffi:defcfun ("_wrap_btCylinderShape_deleteCPlusArray__SWIG_0"
               cYLINDER-SHAPE/DELETE-c++-ARRAY) :void
  (self :pointer)
  (ptr :pointer))
(declaim (inline CYLINDER-SHAPE/MAKE-c++-ARRAY))
(cffi:defcfun ("_wrap_btCylinderShape_makeCPlusArray__SWIG_1"
               CYLINDER-SHAPE/MAKE-C++-ARRAY/with-arg1&ptr) :pointer
  (self :pointer)
  (arg1 :pointer)
  (ptr :pointer))
(declaim (inline CYLINDER-SHAPE/DELETE-c++-ARRAY))
(cffi:defcfun ("_wrap_btCylinderShape_deleteCPlusArray__SWIG_1"
               CYLINDER-SHAPE/DELETE-C++-ARRAY/WITH-ARG1&2) :void
  (self :pointer)
  (arg1 :pointer)
  (arg2 :pointer))
(declaim (inline CYLINDER-SHAPE/GET-HALF-EXTENTS-WITH-MARGIN))
(cffi:defcfun ("_wrap_btCylinderShape_getHalfExtentsWithMargin"
               cYLINDER-SHAPE/GET-HALF-EXTENTS-WITH-MARGIN) :pointer
  (self :pointer))
(declaim (inline CYLINDER-SHAPE/GET-HALF-EXTENTS-WITHOUT-MARGIN))
(cffi:defcfun ("_wrap_btCylinderShape_getHalfExtentsWithoutMargin"
               cYLINDER-SHAPE/GET-HALF-EXTENTS-WITHOUT-MARGIN) :pointer
  (self :pointer))
(declaim (inline MAKE-CYLINDER-SHAPE))
(cffi:defcfun ("_wrap_new_btCylinderShape"
               MAKE-CYLINDER-SHAPE) :pointer
  (halfExtents :pointer))
(declaim (inline CYLINDER-SHAPE/GET-AABB))
(cffi:defcfun ("_wrap_btCylinderShape_getAabb"
               cYLINDER-SHAPE/GET-AABB) :void
  (self :pointer)
  (t_arg1 :pointer)
  (aabbMin :pointer)
  (aabbMax :pointer))
(declaim (inline CYLINDER-SHAPE/CALCULATE-LOCAL-INERTIA))
(cffi:defcfun ("_wrap_btCylinderShape_calculateLocalInertia"
               cYLINDER-SHAPE/CALCULATE-LOCAL-INERTIA) :void
  (self :pointer)
  (mass :float)
  (inertia :pointer))
(declaim (inline CYLINDER-SHAPE/LOCAL-GET-SUPPORTING-VERTEX-WITHOUT-MARGIN))
(cffi:defcfun ("_wrap_btCylinderShape_localGetSupportingVertexWithoutMargin"
               cYLINDER-SHAPE/LOCAL-GET-SUPPORTING-VERTEX-WITHOUT-MARGIN) :pointer
  (self :pointer)
  (vec :pointer))
(declaim (inline CYLINDER-SHAPE/BATCHED-UNIT-VECTOR-GET-SUPPORTING-VERTEX-WITHOUT-MARGIN))
(cffi:defcfun ("_wrap_btCylinderShape_batchedUnitVectorGetSupportingVertexWithoutMargin"
               cYLINDER-SHAPE/BATCHED-UNIT-VECTOR-GET-SUPPORTING-VERTEX-WITHOUT-MARGIN) :void
  (self :pointer)
  (vectors :pointer)
  (supportVerticesOut :pointer)
  (numVectors :int))
(declaim (inline CYLINDER-SHAPE/SET-MARGIN))
(cffi:defcfun ("_wrap_btCylinderShape_setMargin"
               cYLINDER-SHAPE/SET-MARGIN) :void
  (self :pointer)
  (collisionMargin :float))
(declaim (inline CYLINDER-SHAPE/LOCAL-GET-SUPPORTING-VERTEX))
(cffi:defcfun ("_wrap_btCylinderShape_localGetSupportingVertex"
               cYLINDER-SHAPE/LOCAL-GET-SUPPORTING-VERTEX) :pointer
  (self :pointer)
  (vec :pointer))
(declaim (inline CYLINDER-SHAPE/GET-UP-AXIS))
(cffi:defcfun ("_wrap_btCylinderShape_getUpAxis"
               cYLINDER-SHAPE/GET-UP-AXIS) :int
  (self :pointer))
(declaim (inline CYLINDER-SHAPE/GET-ANISOTROPIC-ROLLING-FRICTION-DIRECTION))
(cffi:defcfun ("_wrap_btCylinderShape_getAnisotropicRollingFrictionDirection"
               cYLINDER-SHAPE/GET-ANISOTROPIC-ROLLING-FRICTION-DIRECTION) :pointer
  (self :pointer))
(declaim (inline CYLINDER-SHAPE/GET-RADIUS))
(cffi:defcfun ("_wrap_btCylinderShape_getRadius"
               cYLINDER-SHAPE/GET-RADIUS) :float
  (self :pointer))
(declaim (inline CYLINDER-SHAPE/SET-LOCAL-SCALING))
(cffi:defcfun ("_wrap_btCylinderShape_setLocalScaling"
               cYLINDER-SHAPE/SET-LOCAL-SCALING) :void
  (self :pointer)
  (scaling :pointer))
(declaim (inline CYLINDER-SHAPE/GET-NAME))
(cffi:defcfun ("_wrap_btCylinderShape_getName"
               cYLINDER-SHAPE/GET-NAME) :string
  (self :pointer))
(declaim (inline CYLINDER-SHAPE/CALCULATE-SERIALIZE-BUFFER-SIZE))
(cffi:defcfun ("_wrap_btCylinderShape_calculateSerializeBufferSize"
               cYLINDER-SHAPE/CALCULATE-SERIALIZE-BUFFER-SIZE) :int
  (self :pointer))
(declaim (inline CYLINDER-SHAPE/SERIALIZE))
(cffi:defcfun ("_wrap_btCylinderShape_serialize"
               cYLINDER-SHAPE/SERIALIZE) :string
  (self :pointer)
  (dataBuffer :pointer)
  (serializer :pointer))
(declaim (inline DELETE/BT-CYLINDER-SHAPE))
(cffi:defcfun ("_wrap_delete_btCylinderShape"
               DELETE/BT-CYLINDER-SHAPE) :void
  (self :pointer))
(declaim (inline CYLINDER-SHAPE-X/MAKE-c++-INSTANCE))
(cffi:defcfun ("_wrap_btCylinderShapeX_makeCPlusPlusInstance__SWIG_0"
               cYLINDER-SHAPE-X/MAKE-c++-INSTANCE) :pointer
  (self :pointer)
  (sizeInBytes :pointer))
(declaim (inline CYLINDER-SHAPE-X/DELETE-c++-INSTANCE))
(cffi:defcfun ("_wrap_btCylinderShapeX_deleteCPlusPlusInstance__SWIG_0"
               cYLINDER-SHAPE-X/DELETE-c++-INSTANCE) :void
  (self :pointer)
  (ptr :pointer))
(declaim (inline CYLINDER-SHAPE-X/MAKE-c++-INSTANCE))
(cffi:defcfun ("_wrap_btCylinderShapeX_makeCPlusPlusInstance__SWIG_1"
               CYLINDER-SHAPE-X/MAKE-C++-INSTANCE/with-arg1&ptr) :pointer
  (self :pointer)
  (arg1 :pointer)
  (ptr :pointer))
(declaim (inline CYLINDER-SHAPE-X/DELETE-c++-INSTANCE))
(cffi:defcfun ("_wrap_btCylinderShapeX_deleteCPlusPlusInstance__SWIG_1"
               CYLINDER-SHAPE-X/DELETE-C++-INSTANCE/with-arg1&2) :void
  (self :pointer)
  (arg1 :pointer)
  (arg2 :pointer))
(declaim (inline CYLINDER-SHAPE-X/MAKE-c++-ARRAY))
(cffi:defcfun ("_wrap_btCylinderShapeX_makeCPlusArray__SWIG_0"
               cYLINDER-SHAPE-X/MAKE-c++-ARRAY) :pointer
  (self :pointer)
  (sizeInBytes :pointer))
(declaim (inline CYLINDER-SHAPE-X/DELETE-c++-ARRAY))
(cffi:defcfun ("_wrap_btCylinderShapeX_deleteCPlusArray__SWIG_0"
               cYLINDER-SHAPE-X/DELETE-c++-ARRAY) :void
  (self :pointer)
  (ptr :pointer))
(declaim (inline CYLINDER-SHAPE-X/MAKE-c++-ARRAY))
(cffi:defcfun ("_wrap_btCylinderShapeX_makeCPlusArray__SWIG_1"
               CYLINDER-SHAPE-X/MAKE-C++-ARRAY/with-arg1&ptr) :pointer
  (self :pointer)
  (arg1 :pointer)
  (ptr :pointer))
(declaim (inline CYLINDER-SHAPE-X/DELETE-c++-ARRAY))
(cffi:defcfun ("_wrap_btCylinderShapeX_deleteCPlusArray__SWIG_1"
               CYLINDER-SHAPE-X/DELETE-c++-ARRAY/with-arg1&2) :void
  (self :pointer)
  (arg1 :pointer)
  (arg2 :pointer))
(declaim (inline MAKE-CYLINDER-SHAPE-X))
(cffi:defcfun ("_wrap_new_btCylinderShapeX"
               MAKE-CYLINDER-SHAPE-X) :pointer
  (halfExtents :pointer))
(declaim (inline CYLINDER-SHAPE-X/LOCAL-GET-SUPPORTING-VERTEX-WITHOUT-MARGIN))
(cffi:defcfun ("_wrap_btCylinderShapeX_localGetSupportingVertexWithoutMargin"
               cYLINDER-SHAPE-X/LOCAL-GET-SUPPORTING-VERTEX-WITHOUT-MARGIN) :pointer
  (self :pointer)
  (vec :pointer))
(declaim (inline CYLINDER-SHAPE-X/BATCHED-UNIT-VECTOR-GET-SUPPORTING-VERTEX-WITHOUT-MARGIN))
(cffi:defcfun ("_wrap_btCylinderShapeX_batchedUnitVectorGetSupportingVertexWithoutMargin"
               cYLINDER-SHAPE-X/BATCHED-UNIT-VECTOR-GET-SUPPORTING-VERTEX-WITHOUT-MARGIN) :void
  (self :pointer)
  (vectors :pointer)
  (supportVerticesOut :pointer)
  (numVectors :int))
(declaim (inline CYLINDER-SHAPE-X/GET-NAME))
(cffi:defcfun ("_wrap_btCylinderShapeX_getName"
               cYLINDER-SHAPE-X/GET-NAME) :string
  (self :pointer))
(declaim (inline CYLINDER-SHAPE-X/GET-RADIUS))
(cffi:defcfun ("_wrap_btCylinderShapeX_getRadius"
               cYLINDER-SHAPE-X/GET-RADIUS) :float
  (self :pointer))
(declaim (inline DELETE/BT-CYLINDER-SHAPE-X))
(cffi:defcfun ("_wrap_delete_btCylinderShapeX"
               DELETE/BT-CYLINDER-SHAPE-X) :void
  (self :pointer))
(declaim (inline CYLINDER-SHAPE-Z/MAKE-c++-INSTANCE))
(cffi:defcfun ("_wrap_btCylinderShapeZ_makeCPlusPlusInstance__SWIG_0"
               cYLINDER-SHAPE-Z/MAKE-c++-INSTANCE) :pointer
  (self :pointer)
  (sizeInBytes :pointer))
(declaim (inline CYLINDER-SHAPE-Z/DELETE-c++-INSTANCE))
(cffi:defcfun ("_wrap_btCylinderShapeZ_deleteCPlusPlusInstance__SWIG_0"
               cYLINDER-SHAPE-Z/DELETE-c++-INSTANCE) :void
  (self :pointer)
  (ptr :pointer))
(declaim (inline CYLINDER-SHAPE-Z/MAKE-c++-INSTANCE))
(cffi:defcfun ("_wrap_btCylinderShapeZ_makeCPlusPlusInstance__SWIG_1"
               CYLINDER-SHAPE-Z/MAKE-c++-INSTANCE/with-arg1&ptr) :pointer
  (self :pointer)
  (arg1 :pointer)
  (ptr :pointer))
(declaim (inline CYLINDER-SHAPE-Z/DELETE-c++-INSTANCE))
(cffi:defcfun ("_wrap_btCylinderShapeZ_deleteCPlusPlusInstance__SWIG_1"
               CYLINDER-SHAPE-Z/DELETE-c++-INSTANCE/with-arg1&2) :void
  (self :pointer)
  (arg1 :pointer)
  (arg2 :pointer))
(declaim (inline CYLINDER-SHAPE-Z/MAKE-c++-ARRAY))
(cffi:defcfun ("_wrap_btCylinderShapeZ_makeCPlusArray__SWIG_0"
               cYLINDER-SHAPE-Z/MAKE-c++-ARRAY) :pointer
  (self :pointer)
  (sizeInBytes :pointer))
(declaim (inline CYLINDER-SHAPE-Z/DELETE-c++-ARRAY))
(cffi:defcfun ("_wrap_btCylinderShapeZ_deleteCPlusArray__SWIG_0"
               cYLINDER-SHAPE-Z/DELETE-c++-ARRAY) :void
  (self :pointer)
  (ptr :pointer))
(declaim (inline CYLINDER-SHAPE-Z/MAKE-c++-ARRAY))
(cffi:defcfun ("_wrap_btCylinderShapeZ_makeCPlusArray__SWIG_1"
               CYLINDER-SHAPE-Z/MAKE-c++-ARRAY/with-arg1&ptr) :pointer
  (self :pointer)
  (arg1 :pointer)
  (ptr :pointer))
(declaim (inline CYLINDER-SHAPE-Z/DELETE-c++-ARRAY))
(cffi:defcfun ("_wrap_btCylinderShapeZ_deleteCPlusArray__SWIG_1"
               CYLINDER-SHAPE-Z/DELETE-c++-ARRAY/with-arg1&2) :void
  (self :pointer)
  (arg1 :pointer)
  (arg2 :pointer))
(declaim (inline MAKE-CYLINDER-SHAPE-Z))
(cffi:defcfun ("_wrap_new_btCylinderShapeZ"
               MAKE-CYLINDER-SHAPE-Z) :pointer
  (halfExtents :pointer))
(declaim (inline CYLINDER-SHAPE-Z/LOCAL-GET-SUPPORTING-VERTEX-WITHOUT-MARGIN))
(cffi:defcfun ("_wrap_btCylinderShapeZ_localGetSupportingVertexWithoutMargin"
               cYLINDER-SHAPE-Z/LOCAL-GET-SUPPORTING-VERTEX-WITHOUT-MARGIN) :pointer
  (self :pointer)
  (vec :pointer))
(declaim (inline CYLINDER-SHAPE-Z/BATCHED-UNIT-VECTOR-GET-SUPPORTING-VERTEX-WITHOUT-MARGIN))
(cffi:defcfun ("_wrap_btCylinderShapeZ_batchedUnitVectorGetSupportingVertexWithoutMargin"
               cYLINDER-SHAPE-Z/BATCHED-UNIT-VECTOR-GET-SUPPORTING-VERTEX-WITHOUT-MARGIN) :void
  (self :pointer)
  (vectors :pointer)
  (supportVerticesOut :pointer)
  (numVectors :int))
(declaim (inline CYLINDER-SHAPE-Z/GET-NAME))
(cffi:defcfun ("_wrap_btCylinderShapeZ_getName"
               cYLINDER-SHAPE-Z/GET-NAME) :string
  (self :pointer))
(declaim (inline CYLINDER-SHAPE-Z/GET-RADIUS))
(cffi:defcfun ("_wrap_btCylinderShapeZ_getRadius"
               cYLINDER-SHAPE-Z/GET-RADIUS) :float
  (self :pointer))
(declaim (inline DELETE/BT-CYLINDER-SHAPE-Z))
(cffi:defcfun ("_wrap_delete_btCylinderShapeZ"
               DELETE/BT-CYLINDER-SHAPE-Z) :void
  (self :pointer))

(declaim (inline CONE-SHAPE/MAKE-c++-INSTANCE))
(cffi:defcfun ("_wrap_btConeShape_makeCPlusPlusInstance__SWIG_0"
               CONE-SHAPE/MAKE-c++-INSTANCE) :pointer
  (self :pointer)
  (sizeInBytes :pointer))
(declaim (inline CONE-SHAPE/DELETE-c++-INSTANCE))
(cffi:defcfun ("_wrap_btConeShape_deleteCPlusPlusInstance__SWIG_0"
               CONE-SHAPE/DELETE-c++-INSTANCE) :void
  (self :pointer)
  (ptr :pointer))
(declaim (inline CONE-SHAPE/MAKE-c++-INSTANCE))
(cffi:defcfun ("_wrap_btConeShape_makeCPlusPlusInstance__SWIG_1"
               CONE-SHAPE/MAKE-c++-INSTANCE/with-arg1&ptr) :pointer
  (self :pointer)
  (arg1 :pointer)
  (ptr :pointer))
(declaim (inline CONE-SHAPE/DELETE-c++-INSTANCE))
(cffi:defcfun ("_wrap_btConeShape_deleteCPlusPlusInstance__SWIG_1"
               CONE-SHAPE/DELETE-c++-INSTANCE/with-arg1&2) :void
  (self :pointer)
  (arg1 :pointer)
  (arg2 :pointer))
(declaim (inline CONE-SHAPE/MAKE-c++-ARRAY))
(cffi:defcfun ("_wrap_btConeShape_makeCPlusArray__SWIG_0"
               CONE-SHAPE/MAKE-c++-ARRAY) :pointer
  (self :pointer)
  (sizeInBytes :pointer))
(declaim (inline CONE-SHAPE/DELETE-c++-ARRAY))
(cffi:defcfun ("_wrap_btConeShape_deleteCPlusArray__SWIG_0"
               CONE-SHAPE/DELETE-c++-ARRAY) :void
  (self :pointer)
  (ptr :pointer))
(declaim (inline CONE-SHAPE/MAKE-c++-ARRAY))
(cffi:defcfun ("_wrap_btConeShape_makeCPlusArray__SWIG_1"
               CONE-SHAPE/MAKE-c++-ARRAY/with-arg1&ptr) :pointer
  (self :pointer)
  (arg1 :pointer)
  (ptr :pointer))
(declaim (inline CONE-SHAPE/DELETE-c++-ARRAY))
(cffi:defcfun ("_wrap_btConeShape_deleteCPlusArray__SWIG_1"
               CONE-SHAPE/DELETE-c++-ARRAY/with-arg1&2) :void
  (self :pointer)
  (arg1 :pointer)
  (arg2 :pointer))
(declaim (inline MAKE-CONE-SHAPE))
(cffi:defcfun ("_wrap_new_btConeShape"
               MAKE-CONE-SHAPE) :pointer
  (radius :float)
  (height :float))
(declaim (inline CONE-SHAPE/LOCAL-GET-SUPPORTING-VERTEX))
(cffi:defcfun ("_wrap_btConeShape_localGetSupportingVertex"
               CONE-SHAPE/LOCAL-GET-SUPPORTING-VERTEX) :pointer
  (self :pointer)
  (vec :pointer))
(declaim (inline CONE-SHAPE/LOCAL-GET-SUPPORTING-VERTEX-WITHOUT-MARGIN))
(cffi:defcfun ("_wrap_btConeShape_localGetSupportingVertexWithoutMargin"
               CONE-SHAPE/LOCAL-GET-SUPPORTING-VERTEX-WITHOUT-MARGIN) :pointer
  (self :pointer)
  (vec :pointer))
(declaim (inline CONE-SHAPE/BATCHED-UNIT-VECTOR-GET-SUPPORTING-VERTEX-WITHOUT-MARGIN))
(cffi:defcfun ("_wrap_btConeShape_batchedUnitVectorGetSupportingVertexWithoutMargin"
               CONE-SHAPE/BATCHED-UNIT-VECTOR-GET-SUPPORTING-VERTEX-WITHOUT-MARGIN) :void
  (self :pointer)
  (vectors :pointer)
  (supportVerticesOut :pointer)
  (numVectors :int))
(declaim (inline CONE-SHAPE/GET-RADIUS))
(cffi:defcfun ("_wrap_btConeShape_getRadius"
               CONE-SHAPE/GET-RADIUS) :float
  (self :pointer))
(declaim (inline CONE-SHAPE/GET-HEIGHT))
(cffi:defcfun ("_wrap_btConeShape_getHeight"
               CONE-SHAPE/GET-HEIGHT) :float
  (self :pointer))
(declaim (inline CONE-SHAPE/CALCULATE-LOCAL-INERTIA))
(cffi:defcfun ("_wrap_btConeShape_calculateLocalInertia"
               CONE-SHAPE/CALCULATE-LOCAL-INERTIA) :void
  (self :pointer)
  (mass :float)
  (inertia :pointer))
(declaim (inline CONE-SHAPE/GET-NAME))
(cffi:defcfun ("_wrap_btConeShape_getName"
               CONE-SHAPE/GET-NAME) :string
  (self :pointer))
(declaim (inline CONE-SHAPE/SET-CONE-UP-INDEX))
(cffi:defcfun ("_wrap_btConeShape_setConeUpIndex"
               CONE-SHAPE/SET-CONE-UP-INDEX) :void
  (self :pointer)
  (upIndex :int))
(declaim (inline CONE-SHAPE/GET-CONE-UP-INDEX))
(cffi:defcfun ("_wrap_btConeShape_getConeUpIndex"
               CONE-SHAPE/GET-CONE-UP-INDEX) :int
  (self :pointer))
(declaim (inline CONE-SHAPE/GET-ANISOTROPIC-ROLLING-FRICTION-DIRECTION))
(cffi:defcfun ("_wrap_btConeShape_getAnisotropicRollingFrictionDirection"
               CONE-SHAPE/GET-ANISOTROPIC-ROLLING-FRICTION-DIRECTION) :pointer
  (self :pointer))
(declaim (inline CONE-SHAPE/SET-LOCAL-SCALING))
(cffi:defcfun ("_wrap_btConeShape_setLocalScaling"
               CONE-SHAPE/SET-LOCAL-SCALING) :void
  (self :pointer)
  (scaling :pointer))
(declaim (inline CONE-SHAPE/CALCULATE-SERIALIZE-BUFFER-SIZE))
(cffi:defcfun ("_wrap_btConeShape_calculateSerializeBufferSize"
               CONE-SHAPE/CALCULATE-SERIALIZE-BUFFER-SIZE) :int
  (self :pointer))
(declaim (inline CONE-SHAPE/SERIALIZE))
(cffi:defcfun ("_wrap_btConeShape_serialize"
               CONE-SHAPE/SERIALIZE) :string
  (self :pointer)
  (dataBuffer :pointer)
  (serializer :pointer))
(declaim (inline DELETE/BT-CONE-SHAPE))
(cffi:defcfun ("_wrap_delete_btConeShape"
               DELETE/BT-CONE-SHAPE) :void
  (self :pointer))
(declaim (inline MAKE-CONE-SHAPE-X))
(cffi:defcfun ("_wrap_new_btConeShapeX"
               MAKE-CONE-SHAPE-X) :pointer
  (radius :float)
  (height :float))
(declaim (inline CONE-SHAPE-X/GET-ANISOTROPIC-ROLLING-FRICTION-DIRECTION))
(cffi:defcfun ("_wrap_btConeShapeX_getAnisotropicRollingFrictionDirection"
               CONE-SHAPE-X/GET-ANISOTROPIC-ROLLING-FRICTION-DIRECTION) :pointer
  (self :pointer))
(declaim (inline CONE-SHAPE-X/GET-NAME))
(cffi:defcfun ("_wrap_btConeShapeX_getName"
               CONE-SHAPE-X/GET-NAME) :string
  (self :pointer))
(declaim (inline DELETE/BT-CONE-SHAPE-X))
(cffi:defcfun ("_wrap_delete_btConeShapeX"
               DELETE/BT-CONE-SHAPE-X) :void
  (self :pointer))
(declaim (inline MAKE-CONE-SHAPE-Z))
(cffi:defcfun ("_wrap_new_btConeShapeZ"
               MAKE-CONE-SHAPE-Z) :pointer
  (radius :float)
  (height :float))
(declaim (inline CONE-SHAPE-Z/GET-ANISOTROPIC-ROLLING-FRICTION-DIRECTION))
(cffi:defcfun ("_wrap_btConeShapeZ_getAnisotropicRollingFrictionDirection"
               CONE-SHAPE-Z/GET-ANISOTROPIC-ROLLING-FRICTION-DIRECTION) :pointer
  (self :pointer))
(declaim (inline CONE-SHAPE-Z/GET-NAME))
(cffi:defcfun ("_wrap_btConeShapeZ_getName"
               CONE-SHAPE-Z/GET-NAME) :string
  (self :pointer))
(declaim (inline DELETE/BT-CONE-SHAPE-Z))
(cffi:defcfun ("_wrap_delete_btConeShapeZ"
               DELETE/BT-CONE-SHAPE-Z) :void
  (self :pointer))

(declaim (inline STATIC-PLANE-SHAPE/MAKE-c++-INSTANCE))
(cffi:defcfun ("_wrap_btStaticPlaneShape_makeCPlusPlusInstance__SWIG_0"
               STATIC-PLANE-SHAPE/MAKE-c++-INSTANCE) :pointer
  (self :pointer)
  (sizeInBytes :pointer))
(declaim (inline STATIC-PLANE-SHAPE/DELETE-c++-INSTANCE))
(cffi:defcfun ("_wrap_btStaticPlaneShape_deleteCPlusPlusInstance__SWIG_0"
               STATIC-PLANE-SHAPE/DELETE-c++-INSTANCE) :void
  (self :pointer)
  (ptr :pointer))
(declaim (inline STATIC-PLANE-SHAPE/MAKE-c++-INSTANCE))
(cffi:defcfun ("_wrap_btStaticPlaneShape_makeCPlusPlusInstance__SWIG_1"
               STATIC-PLANE-SHAPE/MAKE-c++-INSTANCE/with-arg1&ptr) :pointer
  (self :pointer)
  (arg1 :pointer)
  (ptr :pointer))
(declaim (inline STATIC-PLANE-SHAPE/DELETE-c++-INSTANCE))
(cffi:defcfun ("_wrap_btStaticPlaneShape_deleteCPlusPlusInstance__SWIG_1"
               STATIC-PLANE-SHAPE/DELETE-c++-INSTANCE/with-arg1&2) :void
  (self :pointer)
  (arg1 :pointer)
  (arg2 :pointer))
(declaim (inline STATIC-PLANE-SHAPE/MAKE-c++-ARRAY))
(cffi:defcfun ("_wrap_btStaticPlaneShape_makeCPlusArray__SWIG_0"
               STATIC-PLANE-SHAPE/MAKE-c++-ARRAY) :pointer
  (self :pointer)
  (sizeInBytes :pointer))
(declaim (inline STATIC-PLANE-SHAPE/DELETE-c++-ARRAY))
(cffi:defcfun ("_wrap_btStaticPlaneShape_deleteCPlusArray__SWIG_0"
               STATIC-PLANE-SHAPE/DELETE-c++-ARRAY) :void
  (self :pointer)
  (ptr :pointer))
(declaim (inline STATIC-PLANE-SHAPE/MAKE-c++-ARRAY))
(cffi:defcfun ("_wrap_btStaticPlaneShape_makeCPlusArray__SWIG_1"
               STATIC-PLANE-SHAPE/MAKE-c++-ARRAY/with-arg1&ptr) :pointer
  (self :pointer)
  (arg1 :pointer)
  (ptr :pointer))
(declaim (inline STATIC-PLANE-SHAPE/DELETE-c++-ARRAY))
(cffi:defcfun ("_wrap_btStaticPlaneShape_deleteCPlusArray__SWIG_1"
               STATIC-PLANE-SHAPE/DELETE-c++-ARRAY/with-arg1&2) :void
  (self :pointer)
  (arg1 :pointer)
  (arg2 :pointer))
(declaim (inline MAKE-STATIC-PLANE-SHAPE))
(cffi:defcfun ("_wrap_new_btStaticPlaneShape"
               MAKE-STATIC-PLANE-SHAPE) :pointer
  (planeNormal :pointer)
  (planeConstant :float))
(declaim (inline DELETE/BT-STATIC-PLANE-SHAPE))
(cffi:defcfun ("_wrap_delete_btStaticPlaneShape"
               DELETE/BT-STATIC-PLANE-SHAPE) :void
  (self :pointer))
(declaim (inline STATIC-PLANE-SHAPE/GET-AABB))
(cffi:defcfun ("_wrap_btStaticPlaneShape_getAabb"
               STATIC-PLANE-SHAPE/GET-AABB) :void
  (self :pointer)
  (t_arg1 :pointer)
  (aabbMin :pointer)
  (aabbMax :pointer))
(declaim (inline STATIC-PLANE-SHAPE/PROCESS-ALL-TRIANGLES))
(cffi:defcfun ("_wrap_btStaticPlaneShape_processAllTriangles"
               STATIC-PLANE-SHAPE/PROCESS-ALL-TRIANGLES) :void
  (self :pointer)
  (callback :pointer)
  (aabbMin :pointer)
  (aabbMax :pointer))
(declaim (inline STATIC-PLANE-SHAPE/CALCULATE-LOCAL-INERTIA))
(cffi:defcfun ("_wrap_btStaticPlaneShape_calculateLocalInertia"
               STATIC-PLANE-SHAPE/CALCULATE-LOCAL-INERTIA) :void
  (self :pointer)
  (mass :float)
  (inertia :pointer))
(declaim (inline STATIC-PLANE-SHAPE/SET-LOCAL-SCALING))
(cffi:defcfun ("_wrap_btStaticPlaneShape_setLocalScaling"
               STATIC-PLANE-SHAPE/SET-LOCAL-SCALING) :void
  (self :pointer)
  (scaling :pointer))
(declaim (inline STATIC-PLANE-SHAPE/GET-LOCAL-SCALING))
(cffi:defcfun ("_wrap_btStaticPlaneShape_getLocalScaling"
               STATIC-PLANE-SHAPE/GET-LOCAL-SCALING) :pointer
  (self :pointer))
(declaim (inline STATIC-PLANE-SHAPE/GET-PLANE-NORMAL))
(cffi:defcfun ("_wrap_btStaticPlaneShape_getPlaneNormal"
               STATIC-PLANE-SHAPE/GET-PLANE-NORMAL) :pointer
  (self :pointer))
(declaim (inline STATIC-PLANE-SHAPE/GET-PLANE-CONSTANT))
(cffi:defcfun ("_wrap_btStaticPlaneShape_getPlaneConstant"
               STATIC-PLANE-SHAPE/GET-PLANE-CONSTANT) :pointer
  (self :pointer))
(declaim (inline STATIC-PLANE-SHAPE/GET-NAME))
(cffi:defcfun ("_wrap_btStaticPlaneShape_getName"
               STATIC-PLANE-SHAPE/GET-NAME) :string
  (self :pointer))
(declaim (inline STATIC-PLANE-SHAPE/CALCULATE-SERIALIZE-BUFFER-SIZE))
(cffi:defcfun ("_wrap_btStaticPlaneShape_calculateSerializeBufferSize"
               STATIC-PLANE-SHAPE/CALCULATE-SERIALIZE-BUFFER-SIZE) :int
  (self :pointer))
(declaim (inline STATIC-PLANE-SHAPE/SERIALIZE))
(cffi:defcfun ("_wrap_btStaticPlaneShape_serialize"
               STATIC-PLANE-SHAPE/SERIALIZE) :string
  (self :pointer)
  (dataBuffer :pointer)
  (serializer :pointer))

(declaim (inline CONVEX-HULL-SHAPE/MAKE-c++-INSTANCE))
(cffi:defcfun ("_wrap_btConvexHullShape_makeCPlusPlusInstance__SWIG_0"
               CONVEX-HULL-SHAPE/MAKE-c++-INSTANCE) :pointer
  (self :pointer)
  (sizeInBytes :pointer))
(declaim (inline CONVEX-HULL-SHAPE/DELETE-c++-INSTANCE))
(cffi:defcfun ("_wrap_btConvexHullShape_deleteCPlusPlusInstance__SWIG_0"
               CONVEX-HULL-SHAPE/DELETE-c++-INSTANCE) :void
  (self :pointer)
  (ptr :pointer))
(declaim (inline CONVEX-HULL-SHAPE/MAKE-c++-INSTANCE))
(cffi:defcfun ("_wrap_btConvexHullShape_makeCPlusPlusInstance__SWIG_1"
               CONVEX-HULL-SHAPE/MAKE-c++-INSTANCE/with-arg1&ptr) :pointer
  (self :pointer)
  (arg1 :pointer)
  (ptr :pointer))
(declaim (inline CONVEX-HULL-SHAPE/DELETE-c++-INSTANCE))
(cffi:defcfun ("_wrap_btConvexHullShape_deleteCPlusPlusInstance__SWIG_1"
               CONVEX-HULL-SHAPE/DELETE-c++-INSTANCE/with-arg1&2) :void
  (self :pointer)
  (arg1 :pointer)
  (arg2 :pointer))
(declaim (inline CONVEX-HULL-SHAPE/MAKE-c++-ARRAY))
(cffi:defcfun ("_wrap_btConvexHullShape_makeCPlusArray__SWIG_0"
               CONVEX-HULL-SHAPE/MAKE-c++-ARRAY) :pointer
  (self :pointer)
  (sizeInBytes :pointer))
(declaim (inline CONVEX-HULL-SHAPE/DELETE-c++-ARRAY))
(cffi:defcfun ("_wrap_btConvexHullShape_deleteCPlusArray__SWIG_0"
               CONVEX-HULL-SHAPE/DELETE-c++-ARRAY) :void
  (self :pointer)
  (ptr :pointer))
(declaim (inline CONVEX-HULL-SHAPE/MAKE-c++-ARRAY))
(cffi:defcfun ("_wrap_btConvexHullShape_makeCPlusArray__SWIG_1"
               CONVEX-HULL-SHAPE/MAKE-c++-ARRAY/with-arg1&ptr) :pointer
  (self :pointer)
  (arg1 :pointer)
  (ptr :pointer))
(declaim (inline CONVEX-HULL-SHAPE/DELETE-c++-ARRAY))
(cffi:defcfun ("_wrap_btConvexHullShape_deleteCPlusArray__SWIG_1"
               CONVEX-HULL-SHAPE/DELETE-c++-ARRAY/with-arg1&2) :void
  (self :pointer)
  (arg1 :pointer)
  (arg2 :pointer))
(declaim (inline MAKE-CONVEX-HULL-SHAPE))
(cffi:defcfun ("_wrap_new_btConvexHullShape__SWIG_0"
               MAKE-CONVEX-HULL-SHAPE/with-num-points&stride) :pointer
  (points :pointer)
  (numPoints :int)
  (stride :int))
(declaim (inline MAKE-CONVEX-HULL-SHAPE))
(cffi:defcfun ("_wrap_new_btConvexHullShape__SWIG_1"
               MAKE-CONVEX-HULL-SHAPE/with-num-points) :pointer
  (points :pointer)
  (numPoints :int))
(declaim (inline MAKE-CONVEX-HULL-SHAPE))
(cffi:defcfun ("_wrap_new_btConvexHullShape__SWIG_2"
               MAKE-CONVEX-HULL-SHAPE/with-points) :pointer
  (points :pointer))
(declaim (inline MAKE-CONVEX-HULL-SHAPE))
(cffi:defcfun ("_wrap_new_btConvexHullShape__SWIG_3"
               MAKE-CONVEX-HULL-SHAPE/naked) :pointer)
(declaim (inline CONVEX-HULL-SHAPE/ADD-POINT))
(cffi:defcfun ("_wrap_btConvexHullShape_addPoint__SWIG_0"
               CONVEX-HULL-SHAPE/ADD-POINT/with-recalculate-local-aabb) :void
  (self :pointer)
  (point :pointer)
  (recalculateLocalAabb :pointer))
(cffi:defcfun ("_wrap_btConvexHullShape_addPoint__SWIG_1"
               CONVEX-HULL-SHAPE/ADD-POINT) :void
  (self :pointer)
  (point :pointer))
(declaim (inline CONVEX-HULL-SHAPE/GET-UNSCALED-POINTS))
(cffi:defcfun ("_wrap_btConvexHullShape_getUnscaledPoints__SWIG_0"
               CONVEX-HULL-SHAPE/GET-UNSCALED-POINTS) :pointer
  (self :pointer))
#+ (or)
(cffi:defcfun ("_wrap_btConvexHullShape_getUnscaledPoints__SWIG_1"
               CONVEX-HULL-SHAPE/GET-UNSCALED-POINTS) :pointer
  (self :pointer))
(declaim (inline CONVEX-HULL-SHAPE/GET-POINTS))
(cffi:defcfun ("_wrap_btConvexHullShape_getPoints"
               CONVEX-HULL-SHAPE/GET-POINTS) :pointer
  (self :pointer))
(declaim (inline CONVEX-HULL-SHAPE/GET-SCALED-POINT))
(cffi:defcfun ("_wrap_btConvexHullShape_getScaledPoint"
               CONVEX-HULL-SHAPE/GET-SCALED-POINT) :pointer
  (self :pointer)
  (i :int))
(declaim (inline CONVEX-HULL-SHAPE/GET-NUM-POINTS))
(cffi:defcfun ("_wrap_btConvexHullShape_getNumPoints"
               CONVEX-HULL-SHAPE/GET-NUM-POINTS) :int
  (self :pointer))
(declaim (inline CONVEX-HULL-SHAPE/LOCAL-GET-SUPPORTING-VERTEX))
(cffi:defcfun ("_wrap_btConvexHullShape_localGetSupportingVertex"
               CONVEX-HULL-SHAPE/LOCAL-GET-SUPPORTING-VERTEX) :pointer
  (self :pointer)
  (vec :pointer))
(declaim (inline CONVEX-HULL-SHAPE/LOCAL-GET-SUPPORTING-VERTEX-WITHOUT-MARGIN))
(cffi:defcfun ("_wrap_btConvexHullShape_localGetSupportingVertexWithoutMargin"
               CONVEX-HULL-SHAPE/LOCAL-GET-SUPPORTING-VERTEX-WITHOUT-MARGIN) :pointer
  (self :pointer)
  (vec :pointer))
(declaim (inline CONVEX-HULL-SHAPE/BATCHED-UNIT-VECTOR-GET-SUPPORTING-VERTEX-WITHOUT-MARGIN))
(cffi:defcfun ("_wrap_btConvexHullShape_batchedUnitVectorGetSupportingVertexWithoutMargin"
               CONVEX-HULL-SHAPE/BATCHED-UNIT-VECTOR-GET-SUPPORTING-VERTEX-WITHOUT-MARGIN) :void
  (self :pointer)
  (vectors :pointer)
  (supportVerticesOut :pointer)
  (numVectors :int))
(declaim (inline CONVEX-HULL-SHAPE/PROJECT))
(cffi:defcfun ("_wrap_btConvexHullShape_project"
               CONVEX-HULL-SHAPE/PROJECT) :void
  (self :pointer)
  (trans :pointer)
  (dir :pointer)
  (minProj :pointer)
  (maxProj :pointer)
  (witnesPtMin :pointer)
  (witnesPtMax :pointer))
(declaim (inline CONVEX-HULL-SHAPE/GET-NAME))
(cffi:defcfun ("_wrap_btConvexHullShape_getName"
               CONVEX-HULL-SHAPE/GET-NAME) :string
  (self :pointer))
(declaim (inline CONVEX-HULL-SHAPE/GET-NUM-VERTICES))
(cffi:defcfun ("_wrap_btConvexHullShape_getNumVertices"
               CONVEX-HULL-SHAPE/GET-NUM-VERTICES) :int
  (self :pointer))
(declaim (inline CONVEX-HULL-SHAPE/GET-NUM-EDGES))
(cffi:defcfun ("_wrap_btConvexHullShape_getNumEdges"
               CONVEX-HULL-SHAPE/GET-NUM-EDGES) :int
  (self :pointer))
(declaim (inline CONVEX-HULL-SHAPE/GET-EDGE))
(cffi:defcfun ("_wrap_btConvexHullShape_getEdge"
               CONVEX-HULL-SHAPE/GET-EDGE) :void
  (self :pointer)
  (i :int)
  (pa :pointer)
  (pb :pointer))
(declaim (inline CONVEX-HULL-SHAPE/GET-VERTEX))
(cffi:defcfun ("_wrap_btConvexHullShape_getVertex"
               CONVEX-HULL-SHAPE/GET-VERTEX) :void
  (self :pointer)
  (i :int)
  (vtx :pointer))
(declaim (inline CONVEX-HULL-SHAPE/GET-NUM-PLANES))
(cffi:defcfun ("_wrap_btConvexHullShape_getNumPlanes"
               CONVEX-HULL-SHAPE/GET-NUM-PLANES) :int
  (self :pointer))
(declaim (inline CONVEX-HULL-SHAPE/GET-PLANE))
(cffi:defcfun ("_wrap_btConvexHullShape_getPlane"
               CONVEX-HULL-SHAPE/GET-PLANE) :void
  (self :pointer)
  (planeNormal :pointer)
  (planeSupport :pointer)
  (i :int))
(declaim (inline CONVEX-HULL-SHAPE/IS-INSIDE))
(cffi:defcfun ("_wrap_btConvexHullShape_isInside"
               CONVEX-HULL-SHAPE/IS-INSIDE) :pointer
  (self :pointer)
  (pt :pointer)
  (tolerance :float))
(declaim (inline CONVEX-HULL-SHAPE/SET-LOCAL-SCALING))
(cffi:defcfun ("_wrap_btConvexHullShape_setLocalScaling"
               CONVEX-HULL-SHAPE/SET-LOCAL-SCALING) :void
  (self :pointer)
  (scaling :pointer))
(declaim (inline CONVEX-HULL-SHAPE/CALCULATE-SERIALIZE-BUFFER-SIZE))
(cffi:defcfun ("_wrap_btConvexHullShape_calculateSerializeBufferSize"
               CONVEX-HULL-SHAPE/CALCULATE-SERIALIZE-BUFFER-SIZE) :int
  (self :pointer))
(declaim (inline CONVEX-HULL-SHAPE/SERIALIZE))
(cffi:defcfun ("_wrap_btConvexHullShape_serialize"
               CONVEX-HULL-SHAPE/SERIALIZE) :string
  (self :pointer)
  (dataBuffer :pointer)
  (serializer :pointer))
(declaim (inline DELETE/BT-CONVEX-HULL-SHAPE))
(cffi:defcfun ("_wrap_delete_btConvexHullShape"
               DELETE/BT-CONVEX-HULL-SHAPE) :void
  (self :pointer))

(declaim (inline TRIANGLE-MESH/WELDING-THRESHOLD/SET))
(cffi:defcfun ("_wrap_btTriangleMesh_m_weldingThreshold_set"
               TRIANGLE-MESH/WELDING-THRESHOLD/SET) :void
  (self :pointer)
  (m_weldingThreshold :float))
(declaim (inline TRIANGLE-MESH/WELDING-THRESHOLD/GET))
(cffi:defcfun ("_wrap_btTriangleMesh_m_weldingThreshold_get"
               TRIANGLE-MESH/WELDING-THRESHOLD/GET) :float
  (self :pointer))
(declaim (inline MAKE-TRIANGLE-MESH))
(cffi:defcfun ("_wrap_new_btTriangleMesh__SWIG_0"
               MAKE-TRIANGLE-MESH/with-use-32-bit-indices&use-4-component-vertices) :pointer
  (use32bitIndices :pointer)
  (use4componentVertices :pointer))
(declaim (inline MAKE-TRIANGLE-MESH))
(cffi:defcfun ("_wrap_new_btTriangleMesh__SWIG_1"
               MAKE-TRIANGLE-MESH/with-use-32-bit-indices) :pointer
  (use32bitIndices :pointer))
(declaim (inline MAKE-TRIANGLE-MESH))
(cffi:defcfun ("_wrap_new_btTriangleMesh__SWIG_2"
               MAKE-TRIANGLE-MESH/naked) :pointer)
(declaim (inline TRIANGLE-MESH/GET-USE-32BIT-INDICES))
(cffi:defcfun ("_wrap_btTriangleMesh_getUse32bitIndices"
               TRIANGLE-MESH/GET-USE-32BIT-INDICES) :pointer
  (self :pointer))
(declaim (inline TRIANGLE-MESH/GET-USE-4COMPONENT-VERTICES))
(cffi:defcfun ("_wrap_btTriangleMesh_getUse4componentVertices"
               TRIANGLE-MESH/GET-USE-4COMPONENT-VERTICES) :pointer
  (self :pointer))
(declaim (inline TRIANGLE-MESH/ADD-TRIANGLE))
(cffi:defcfun ("_wrap_btTriangleMesh_addTriangle__SWIG_0"
               TRIANGLE-MESH/ADD-TRIANGLE) :void
  (self :pointer)
  (vertex0 :pointer)
  (vertex1 :pointer)
  (vertex2 :pointer)
  (removeDuplicateVertices :pointer))
(declaim (inline TRIANGLE-MESH/ADD-TRIANGLE))
(cffi:defcfun ("_wrap_btTriangleMesh_addTriangle__SWIG_1"
               TRIANGLE-MESH/ADD-TRIANGLE/with-3-vertices) :void
  (self :pointer)
  (vertex0 :pointer)
  (vertex1 :pointer)
  (vertex2 :pointer))
(declaim (inline TRIANGLE-MESH/GET-NUM-TRIANGLES))
(cffi:defcfun ("_wrap_btTriangleMesh_getNumTriangles"
               TRIANGLE-MESH/GET-NUM-TRIANGLES) :int
  (self :pointer))
(declaim (inline TRIANGLE-MESH/PREALLOCATE-VERTICES))
(cffi:defcfun ("_wrap_btTriangleMesh_preallocateVertices"
               TRIANGLE-MESH/PREALLOCATE-VERTICES) :void
  (self :pointer)
  (numverts :int))
(declaim (inline TRIANGLE-MESH/PREALLOCATE-INDICES))
(cffi:defcfun ("_wrap_btTriangleMesh_preallocateIndices"
               TRIANGLE-MESH/PREALLOCATE-INDICES) :void
  (self :pointer)
  (numindices :int))
(declaim (inline TRIANGLE-MESH/FIND-OR-ADD-VERTEX))
(cffi:defcfun ("_wrap_btTriangleMesh_findOrAddVertex"
               TRIANGLE-MESH/FIND-OR-ADD-VERTEX) :int
  (self :pointer)
  (vertex :pointer)
  (removeDuplicateVertices :pointer))
(declaim (inline TRIANGLE-MESH/ADD-INDEX))
(cffi:defcfun ("_wrap_btTriangleMesh_addIndex"
               TRIANGLE-MESH/ADD-INDEX) :void
  (self :pointer)
  (index :int))
(declaim (inline DELETE/BT-TRIANGLE-MESH))
(cffi:defcfun ("_wrap_delete_btTriangleMesh"
               DELETE/BT-TRIANGLE-MESH) :void
  (self :pointer))
(declaim (inline CONVEX-TRIANGLE-MESH-SHAPE/MAKE-c++-INSTANCE))
(cffi:defcfun ("_wrap_btConvexTriangleMeshShape_makeCPlusPlusInstance__SWIG_0"
               CONVEX-TRIANGLE-MESH-SHAPE/MAKE-c++-INSTANCE) :pointer
  (self :pointer)
  (sizeInBytes :pointer))
(declaim (inline CONVEX-TRIANGLE-MESH-SHAPE/DELETE-c++-INSTANCE))
(cffi:defcfun ("_wrap_btConvexTriangleMeshShape_deleteCPlusPlusInstance__SWIG_0"
               CONVEX-TRIANGLE-MESH-SHAPE/DELETE-c++-INSTANCE) :void
  (self :pointer)
  (ptr :pointer))
(declaim (inline CONVEX-TRIANGLE-MESH-SHAPE/MAKE-c++-INSTANCE))
(cffi:defcfun ("_wrap_btConvexTriangleMeshShape_makeCPlusPlusInstance__SWIG_1"
               CONVEX-TRIANGLE-MESH-SHAPE/MAKE-c++-INSTANCE/with-arg1&ptr) :pointer
  (self :pointer)
  (arg1 :pointer)
  (ptr :pointer))
(declaim (inline CONVEX-TRIANGLE-MESH-SHAPE/DELETE-c++-INSTANCE))
(cffi:defcfun ("_wrap_btConvexTriangleMeshShape_deleteCPlusPlusInstance__SWIG_1"
               CONVEX-TRIANGLE-MESH-SHAPE/DELETE-c++-INSTANCE/with-arg1&2) :void
  (self :pointer)
  (arg1 :pointer)
  (arg2 :pointer))
(declaim (inline CONVEX-TRIANGLE-MESH-SHAPE/MAKE-c++-ARRAY))
(cffi:defcfun ("_wrap_btConvexTriangleMeshShape_makeCPlusArray__SWIG_0"
               CONVEX-TRIANGLE-MESH-SHAPE/MAKE-c++-ARRAY) :pointer
  (self :pointer)
  (sizeInBytes :pointer))
(declaim (inline CONVEX-TRIANGLE-MESH-SHAPE/DELETE-c++-ARRAY))
(cffi:defcfun ("_wrap_btConvexTriangleMeshShape_deleteCPlusArray__SWIG_0"
               CONVEX-TRIANGLE-MESH-SHAPE/DELETE-c++-ARRAY) :void
  (self :pointer)
  (ptr :pointer))
(declaim (inline CONVEX-TRIANGLE-MESH-SHAPE/MAKE-c++-ARRAY))
(cffi:defcfun ("_wrap_btConvexTriangleMeshShape_makeCPlusArray__SWIG_1"
               CONVEX-TRIANGLE-MESH-SHAPE/MAKE-c++-ARRAY/with-arg1&ptr) :pointer
  (self :pointer)
  (arg1 :pointer)
  (ptr :pointer))
(declaim (inline CONVEX-TRIANGLE-MESH-SHAPE/DELETE-c++-ARRAY))
(cffi:defcfun ("_wrap_btConvexTriangleMeshShape_deleteCPlusArray__SWIG_1"
               CONVEX-TRIANGLE-MESH-SHAPE/DELETE-c++-ARRAY/with-arg1&2) :void
  (self :pointer)
  (arg1 :pointer)
  (arg2 :pointer))
(declaim (inline MAKE-CONVEX-TRIANGLE-MESH-SHAPE))
(cffi:defcfun ("_wrap_new_btConvexTriangleMeshShape__SWIG_0"
               MAKE-CONVEX-TRIANGLE-MESH-SHAPE/with-calc-aabb) :pointer
  (meshInterface :pointer)
  (calcAabb :pointer))
(declaim (inline MAKE-CONVEX-TRIANGLE-MESH-SHAPE))
(cffi:defcfun ("_wrap_new_btConvexTriangleMeshShape__SWIG_1"
               MAKE-CONVEX-TRIANGLE-MESH-SHAPE) :pointer
  (meshInterface :pointer))
(declaim (inline CONVEX-TRIANGLE-MESH-SHAPE/GET-MESH-INTERFACE))
(cffi:defcfun ("_wrap_btConvexTriangleMeshShape_getMeshInterface__SWIG_0"
               CONVEX-TRIANGLE-MESH-SHAPE/GET-MESH-INTERFACE) :pointer
  (self :pointer))
#+ (or)
(cffi:defcfun ("_wrap_btConvexTriangleMeshShape_getMeshInterface__SWIG_1"
               CONVEX-TRIANGLE-MESH-SHAPE/GET-MESH-INTERFACE) :pointer
  (self :pointer))
(declaim (inline CONVEX-TRIANGLE-MESH-SHAPE/LOCAL-GET-SUPPORTING-VERTEX))
(cffi:defcfun ("_wrap_btConvexTriangleMeshShape_localGetSupportingVertex"
               CONVEX-TRIANGLE-MESH-SHAPE/LOCAL-GET-SUPPORTING-VERTEX) :pointer
  (self :pointer)
  (vec :pointer))
(declaim (inline CONVEX-TRIANGLE-MESH-SHAPE/LOCAL-GET-SUPPORTING-VERTEX-WITHOUT-MARGIN))
(cffi:defcfun ("_wrap_btConvexTriangleMeshShape_localGetSupportingVertexWithoutMargin"
               CONVEX-TRIANGLE-MESH-SHAPE/LOCAL-GET-SUPPORTING-VERTEX-WITHOUT-MARGIN) :pointer
  (self :pointer)
  (vec :pointer))
(declaim (inline CONVEX-TRIANGLE-MESH-SHAPE/BATCHED-UNIT-VECTOR-GET-SUPPORTING-VERTEX-WITHOUT-MARGIN))
(cffi:defcfun ("_wrap_btConvexTriangleMeshShape_batchedUnitVectorGetSupportingVertexWithoutMargin"
               CONVEX-TRIANGLE-MESH-SHAPE/BATCHED-UNIT-VECTOR-GET-SUPPORTING-VERTEX-WITHOUT-MARGIN) :void
  (self :pointer)
  (vectors :pointer)
  (supportVerticesOut :pointer)
  (numVectors :int))
(declaim (inline CONVEX-TRIANGLE-MESH-SHAPE/GET-NAME))
(cffi:defcfun ("_wrap_btConvexTriangleMeshShape_getName"
               CONVEX-TRIANGLE-MESH-SHAPE/GET-NAME) :string
  (self :pointer))
(declaim (inline CONVEX-TRIANGLE-MESH-SHAPE/GET-NUM-VERTICES))
(cffi:defcfun ("_wrap_btConvexTriangleMeshShape_getNumVertices"
               CONVEX-TRIANGLE-MESH-SHAPE/GET-NUM-VERTICES) :int
  (self :pointer))
(declaim (inline CONVEX-TRIANGLE-MESH-SHAPE/GET-NUM-EDGES))
(cffi:defcfun ("_wrap_btConvexTriangleMeshShape_getNumEdges"
               CONVEX-TRIANGLE-MESH-SHAPE/GET-NUM-EDGES) :int
  (self :pointer))
(declaim (inline CONVEX-TRIANGLE-MESH-SHAPE/GET-EDGE))
(cffi:defcfun ("_wrap_btConvexTriangleMeshShape_getEdge"
               CONVEX-TRIANGLE-MESH-SHAPE/GET-EDGE) :void
  (self :pointer)
  (i :int)
  (pa :pointer)
  (pb :pointer))
(declaim (inline CONVEX-TRIANGLE-MESH-SHAPE/GET-VERTEX))
(cffi:defcfun ("_wrap_btConvexTriangleMeshShape_getVertex"
               CONVEX-TRIANGLE-MESH-SHAPE/GET-VERTEX) :void
  (self :pointer)
  (i :int)
  (vtx :pointer))
(declaim (inline CONVEX-TRIANGLE-MESH-SHAPE/GET-NUM-PLANES))
(cffi:defcfun ("_wrap_btConvexTriangleMeshShape_getNumPlanes"
               CONVEX-TRIANGLE-MESH-SHAPE/GET-NUM-PLANES) :int
  (self :pointer))
(declaim (inline CONVEX-TRIANGLE-MESH-SHAPE/GET-PLANE))
(cffi:defcfun ("_wrap_btConvexTriangleMeshShape_getPlane"
               CONVEX-TRIANGLE-MESH-SHAPE/GET-PLANE) :void
  (self :pointer)
  (planeNormal :pointer)
  (planeSupport :pointer)
  (i :int))
(declaim (inline CONVEX-TRIANGLE-MESH-SHAPE/IS-INSIDE))
(cffi:defcfun ("_wrap_btConvexTriangleMeshShape_isInside"
               CONVEX-TRIANGLE-MESH-SHAPE/IS-INSIDE) :pointer
  (self :pointer)
  (pt :pointer)
  (tolerance :float))
(declaim (inline CONVEX-TRIANGLE-MESH-SHAPE/SET-LOCAL-SCALING))
(cffi:defcfun ("_wrap_btConvexTriangleMeshShape_setLocalScaling"
               CONVEX-TRIANGLE-MESH-SHAPE/SET-LOCAL-SCALING) :void
  (self :pointer)
  (scaling :pointer))
(declaim (inline CONVEX-TRIANGLE-MESH-SHAPE/GET-LOCAL-SCALING))
(cffi:defcfun ("_wrap_btConvexTriangleMeshShape_getLocalScaling"
               CONVEX-TRIANGLE-MESH-SHAPE/GET-LOCAL-SCALING) :pointer
  (self :pointer))
(declaim (inline CONVEX-TRIANGLE-MESH-SHAPE/CALCULATE-PRINCIPAL-AXIS-TRANSFORM))
(cffi:defcfun ("_wrap_btConvexTriangleMeshShape_calculatePrincipalAxisTransform"
               CONVEX-TRIANGLE-MESH-SHAPE/CALCULATE-PRINCIPAL-AXIS-TRANSFORM) :void
  (self :pointer)
  (principal :pointer)
  (inertia :pointer)
  (volume :pointer))
(declaim (inline DELETE/BT-CONVEX-TRIANGLE-MESH-SHAPE))
(cffi:defcfun ("_wrap_delete_btConvexTriangleMeshShape"
               DELETE/BT-CONVEX-TRIANGLE-MESH-SHAPE) :void
  (self :pointer))
(declaim (inline BVH-TRIANGLE-MESH-SHAPE/MAKE-c++-INSTANCE))
(cffi:defcfun ("_wrap_btBvhTriangleMeshShape_makeCPlusPlusInstance__SWIG_0"
               BVH-TRIANGLE-MESH-SHAPE/MAKE-c++-INSTANCE) :pointer
  (self :pointer)
  (sizeInBytes :pointer))
(declaim (inline BVH-TRIANGLE-MESH-SHAPE/DELETE-c++-INSTANCE))
(cffi:defcfun ("_wrap_btBvhTriangleMeshShape_deleteCPlusPlusInstance__SWIG_0"
               BVH-TRIANGLE-MESH-SHAPE/DELETE-c++-INSTANCE) :void
  (self :pointer)
  (ptr :pointer))
(declaim (inline BVH-TRIANGLE-MESH-SHAPE/MAKE-c++-INSTANCE))
(cffi:defcfun ("_wrap_btBvhTriangleMeshShape_makeCPlusPlusInstance__SWIG_1"
               BVH-TRIANGLE-MESH-SHAPE/MAKE-c++-INSTANCE/with-arg1&ptr) :pointer
  (self :pointer)
  (arg1 :pointer)
  (ptr :pointer))
(declaim (inline BVH-TRIANGLE-MESH-SHAPE/DELETE-c++-INSTANCE))
(cffi:defcfun ("_wrap_btBvhTriangleMeshShape_deleteCPlusPlusInstance__SWIG_1"
               BVH-TRIANGLE-MESH-SHAPE/DELETE-c++-INSTANCE/with-arg1&2) :void
  (self :pointer)
  (arg1 :pointer)
  (arg2 :pointer))
(declaim (inline BVH-TRIANGLE-MESH-SHAPE/MAKE-c++-ARRAY))
(cffi:defcfun ("_wrap_btBvhTriangleMeshShape_makeCPlusArray__SWIG_0"
               BVH-TRIANGLE-MESH-SHAPE/MAKE-c++-ARRAY) :pointer
  (self :pointer)
  (sizeInBytes :pointer))
(declaim (inline BVH-TRIANGLE-MESH-SHAPE/DELETE-c++-ARRAY))
(cffi:defcfun ("_wrap_btBvhTriangleMeshShape_deleteCPlusArray__SWIG_0"
               BVH-TRIANGLE-MESH-SHAPE/DELETE-c++-ARRAY) :void
  (self :pointer)
  (ptr :pointer))
(declaim (inline BVH-TRIANGLE-MESH-SHAPE/MAKE-c++-ARRAY))
(cffi:defcfun ("_wrap_btBvhTriangleMeshShape_makeCPlusArray__SWIG_1"
               BVH-TRIANGLE-MESH-SHAPE/MAKE-c++-ARRAY/with-arg1&ptr) :pointer
  (self :pointer)
  (arg1 :pointer)
  (ptr :pointer))
(declaim (inline BVH-TRIANGLE-MESH-SHAPE/DELETE-c++-ARRAY))
(cffi:defcfun ("_wrap_btBvhTriangleMeshShape_deleteCPlusArray__SWIG_1"
               BVH-TRIANGLE-MESH-SHAPE/DELETE-c++-ARRAY/with-arg1&2) :void
  (self :pointer)
  (arg1 :pointer)
  (arg2 :pointer))
(declaim (inline MAKE-BVH-TRIANGLE-MESH-SHAPE))
(cffi:defcfun ("_wrap_new_btBvhTriangleMeshShape__SWIG_0"
               MAKE-BVH-TRIANGLE-MESH-SHAPE/with-mesh-interface&use-quantized-aabb-compression&Build-bvh)
    :pointer
  (meshInterface :pointer)
  (useQuantizedAabbCompression :pointer)
  (buildBvh :pointer))
(declaim (inline MAKE-BVH-TRIANGLE-MESH-SHAPE))
(cffi:defcfun ("_wrap_new_btBvhTriangleMeshShape__SWIG_1"
               MAKE-BVH-TRIANGLE-MESH-SHAPE) :pointer
  (meshInterface :pointer)
  (useQuantizedAabbCompression :pointer))
(declaim (inline MAKE-BVH-TRIANGLE-MESH-SHAPE))
(cffi:defcfun ("_wrap_new_btBvhTriangleMeshShape__SWIG_2"
               MAKE-BVH-TRIANGLE-MESH-SHAPE/with-mesh-interface&use-quantized-aabb-compression&bvhaabb-min&max&Build-bvh)
    :pointer
  (meshInterface :pointer)
  (useQuantizedAabbCompression :pointer)
  (bvhAabbMin :pointer)
  (bvhAabbMax :pointer)
  (buildBvh :pointer))
(declaim (inline MAKE-BVH-TRIANGLE-MESH-SHAPE))
(cffi:defcfun ("_wrap_new_btBvhTriangleMeshShape__SWIG_3"
               MAKE-BVH-TRIANGLE-MESH-SHAPE/with-mesh-interface&use-quantized-aabb-compression&bvhaabb-min&max)
    :pointer
  (meshInterface :pointer)
  (useQuantizedAabbCompression :pointer)
  (bvhAabbMin :pointer)
  (bvhAabbMax :pointer))
(declaim (inline DELETE/BT-BVH-TRIANGLE-MESH-SHAPE))
(cffi:defcfun ("_wrap_delete_btBvhTriangleMeshShape"
               DELETE/BT-BVH-TRIANGLE-MESH-SHAPE) :void
  (self :pointer))
(declaim (inline BVH-TRIANGLE-MESH-SHAPE/GET-OWNS-BVH))
(cffi:defcfun ("_wrap_btBvhTriangleMeshShape_getOwnsBvh"
               BVH-TRIANGLE-MESH-SHAPE/GET-OWNS-BVH) :pointer
  (self :pointer))
(declaim (inline BVH-TRIANGLE-MESH-SHAPE/PERFORM-RAYCAST))
(cffi:defcfun ("_wrap_btBvhTriangleMeshShape_performRaycast"
               BVH-TRIANGLE-MESH-SHAPE/PERFORM-RAYCAST) :void
  (self :pointer)
  (callback :pointer)
  (raySource :pointer)
  (rayTarget :pointer))
(declaim (inline BVH-TRIANGLE-MESH-SHAPE/PERFORM-CONVEXCAST))
(cffi:defcfun ("_wrap_btBvhTriangleMeshShape_performConvexcast"
               BVH-TRIANGLE-MESH-SHAPE/PERFORM-CONVEXCAST) :void
  (self :pointer)
  (callback :pointer)
  (boxSource :pointer)
  (boxTarget :pointer)
  (boxMin :pointer)
  (boxMax :pointer))
(declaim (inline BVH-TRIANGLE-MESH-SHAPE/PROCESS-ALL-TRIANGLES))
(cffi:defcfun ("_wrap_btBvhTriangleMeshShape_processAllTriangles"
               BVH-TRIANGLE-MESH-SHAPE/PROCESS-ALL-TRIANGLES) :void
  (self :pointer)
  (callback :pointer)
  (aabbMin :pointer)
  (aabbMax :pointer))
(declaim (inline BVH-TRIANGLE-MESH-SHAPE/REFIT-TREE))
(cffi:defcfun ("_wrap_btBvhTriangleMeshShape_refitTree"
               BVH-TRIANGLE-MESH-SHAPE/REFIT-TREE) :void
  (self :pointer)
  (aabbMin :pointer)
  (aabbMax :pointer))
(declaim (inline BVH-TRIANGLE-MESH-SHAPE/PARTIAL-REFIT-TREE))
(cffi:defcfun ("_wrap_btBvhTriangleMeshShape_partialRefitTree"
               BVH-TRIANGLE-MESH-SHAPE/PARTIAL-REFIT-TREE) :void
  (self :pointer)
  (aabbMin :pointer)
  (aabbMax :pointer))
(declaim (inline BVH-TRIANGLE-MESH-SHAPE/GET-NAME))
(cffi:defcfun ("_wrap_btBvhTriangleMeshShape_getName"
               BVH-TRIANGLE-MESH-SHAPE/GET-NAME) :string
  (self :pointer))
(declaim (inline BVH-TRIANGLE-MESH-SHAPE/SET-LOCAL-SCALING))
(cffi:defcfun ("_wrap_btBvhTriangleMeshShape_setLocalScaling"
               BVH-TRIANGLE-MESH-SHAPE/SET-LOCAL-SCALING) :void
  (self :pointer)
  (scaling :pointer))
(declaim (inline BVH-TRIANGLE-MESH-SHAPE/GET-OPTIMIZED-BVH))
(cffi:defcfun ("_wrap_btBvhTriangleMeshShape_getOptimizedBvh"
               BVH-TRIANGLE-MESH-SHAPE/GET-OPTIMIZED-BVH) :pointer
  (self :pointer))
(declaim (inline BVH-TRIANGLE-MESH-SHAPE/SET-OPTIMIZED-BVH))
(cffi:defcfun ("_wrap_btBvhTriangleMeshShape_setOptimizedBvh__SWIG_0"
               BVH-TRIANGLE-MESH-SHAPE/SET-OPTIMIZED-BVH/with-local-scaling) :void
  (self :pointer)
  (bvh :pointer)
  (localScaling :pointer))
(declaim (inline BVH-TRIANGLE-MESH-SHAPE/SET-OPTIMIZED-BVH))
(cffi:defcfun ("_wrap_btBvhTriangleMeshShape_setOptimizedBvh__SWIG_1"
               BVH-TRIANGLE-MESH-SHAPE/SET-OPTIMIZED-BVH) :void
  (self :pointer)
  (bvh :pointer))
(declaim (inline BVH-TRIANGLE-MESH-SHAPE/BUILD-OPTIMIZED-BVH))
(cffi:defcfun ("_wrap_btBvhTriangleMeshShape_buildOptimizedBvh"
               BVH-TRIANGLE-MESH-SHAPE/BUILD-OPTIMIZED-BVH) :void
  (self :pointer))
(declaim (inline BVH-TRIANGLE-MESH-SHAPE/USES-QUANTIZED-AABB-COMPRESSION))
(cffi:defcfun ("_wrap_btBvhTriangleMeshShape_usesQuantizedAabbCompression"
               BVH-TRIANGLE-MESH-SHAPE/USES-QUANTIZED-AABB-COMPRESSION) :pointer
  (self :pointer))
(declaim (inline BVH-TRIANGLE-MESH-SHAPE/SET-TRIANGLE-INFO-MAP))
(cffi:defcfun ("_wrap_btBvhTriangleMeshShape_setTriangleInfoMap"
               BVH-TRIANGLE-MESH-SHAPE/SET-TRIANGLE-INFO-MAP) :void
  (self :pointer)
  (triangleInfoMap :pointer))
(declaim (inline BVH-TRIANGLE-MESH-SHAPE/GET-TRIANGLE-INFO-MAP))
(cffi:defcfun ("_wrap_btBvhTriangleMeshShape_getTriangleInfoMap__SWIG_0"
               BVH-TRIANGLE-MESH-SHAPE/GET-TRIANGLE-INFO-MAP) :pointer
  (self :pointer))
#+ (or)
(cffi:defcfun ("_wrap_btBvhTriangleMeshShape_getTriangleInfoMap__SWIG_1"
               BVH-TRIANGLE-MESH-SHAPE/GET-TRIANGLE-INFO-MAP) :pointer
  (self :pointer))
(declaim (inline BVH-TRIANGLE-MESH-SHAPE/CALCULATE-SERIALIZE-BUFFER-SIZE))
(cffi:defcfun ("_wrap_btBvhTriangleMeshShape_calculateSerializeBufferSize"
               BVH-TRIANGLE-MESH-SHAPE/CALCULATE-SERIALIZE-BUFFER-SIZE) :int
  (self :pointer))
(declaim (inline BVH-TRIANGLE-MESH-SHAPE/SERIALIZE))
(cffi:defcfun ("_wrap_btBvhTriangleMeshShape_serialize"
               BVH-TRIANGLE-MESH-SHAPE/SERIALIZE) :string
  (self :pointer)
  (dataBuffer :pointer)
  (serializer :pointer))
(declaim (inline BVH-TRIANGLE-MESH-SHAPE/SERIALIZE-SINGLE-BVH))
(cffi:defcfun ("_wrap_btBvhTriangleMeshShape_serializeSingleBvh"
               BVH-TRIANGLE-MESH-SHAPE/SERIALIZE-SINGLE-BVH) :void
  (self :pointer)
  (serializer :pointer))
(declaim (inline BVH-TRIANGLE-MESH-SHAPE/SERIALIZE-SINGLE-TRIANGLE-INFO-MAP))
(cffi:defcfun ("_wrap_btBvhTriangleMeshShape_serializeSingleTriangleInfoMap"
               BVH-TRIANGLE-MESH-SHAPE/SERIALIZE-SINGLE-TRIANGLE-INFO-MAP) :void
  (self :pointer)
  (serializer :pointer))

(declaim (inline SCALED-BVH-TRIANGLE-MESH-SHAPE/MAKE-c++-INSTANCE))
(cffi:defcfun ("_wrap_btScaledBvhTriangleMeshShape_makeCPlusPlusInstance__SWIG_0"
               SCALED-BVH-TRIANGLE-MESH-SHAPE/MAKE-c++-INSTANCE) :pointer
  (self :pointer)
  (sizeInBytes :pointer))
(declaim (inline SCALED-BVH-TRIANGLE-MESH-SHAPE/DELETE-c++-INSTANCE))
(cffi:defcfun ("_wrap_btScaledBvhTriangleMeshShape_deleteCPlusPlusInstance__SWIG_0"
               SCALED-BVH-TRIANGLE-MESH-SHAPE/DELETE-c++-INSTANCE) :void
  (self :pointer)
  (ptr :pointer))
(declaim (inline SCALED-BVH-TRIANGLE-MESH-SHAPE/MAKE-c++-INSTANCE))
(cffi:defcfun ("_wrap_btScaledBvhTriangleMeshShape_makeCPlusPlusInstance__SWIG_1"
               SCALED-BVH-TRIANGLE-MESH-SHAPE/MAKE-c++-INSTANCE/with-arg1&ptr) :pointer
  (self :pointer)
  (arg1 :pointer)
  (ptr :pointer))
(declaim (inline SCALED-BVH-TRIANGLE-MESH-SHAPE/DELETE-c++-INSTANCE))
(cffi:defcfun ("_wrap_btScaledBvhTriangleMeshShape_deleteCPlusPlusInstance__SWIG_1"
               SCALED-BVH-TRIANGLE-MESH-SHAPE/DELETE-c++-INSTANCE/with-arg1&2) :void
  (self :pointer)
  (arg1 :pointer)
  (arg2 :pointer))
(declaim (inline SCALED-BVH-TRIANGLE-MESH-SHAPE/MAKE-c++-ARRAY))
(cffi:defcfun ("_wrap_btScaledBvhTriangleMeshShape_makeCPlusArray__SWIG_0"
               SCALED-BVH-TRIANGLE-MESH-SHAPE/MAKE-c++-ARRAY) :pointer
  (self :pointer)
  (sizeInBytes :pointer))
(declaim (inline SCALED-BVH-TRIANGLE-MESH-SHAPE/DELETE-c++-ARRAY))
(cffi:defcfun ("_wrap_btScaledBvhTriangleMeshShape_deleteCPlusArray__SWIG_0"
               SCALED-BVH-TRIANGLE-MESH-SHAPE/DELETE-c++-ARRAY) :void
  (self :pointer)
  (ptr :pointer))
(declaim (inline SCALED-BVH-TRIANGLE-MESH-SHAPE/MAKE-c++-ARRAY))
(cffi:defcfun ("_wrap_btScaledBvhTriangleMeshShape_makeCPlusArray__SWIG_1"
               SCALED-BVH-TRIANGLE-MESH-SHAPE/MAKE-c++-ARRAY/with-arg1&ptr) :pointer
  (self :pointer)
  (arg1 :pointer)
  (ptr :pointer))
(declaim (inline SCALED-BVH-TRIANGLE-MESH-SHAPE/DELETE-c++-ARRAY))
(cffi:defcfun ("_wrap_btScaledBvhTriangleMeshShape_deleteCPlusArray__SWIG_1"
               SCALED-BVH-TRIANGLE-MESH-SHAPE/DELETE-c++-ARRAY/with-arg1&2) :void
  (self :pointer)
  (arg1 :pointer)
  (arg2 :pointer))
(declaim (inline MAKE-SCALED-BVH-TRIANGLE-MESH-SHAPE))
(cffi:defcfun ("_wrap_new_btScaledBvhTriangleMeshShape"
               MAKE-SCALED-BVH-TRIANGLE-MESH-SHAPE) :pointer
  (childShape :pointer)
  (localScaling :pointer))
(declaim (inline DELETE/BT-SCALED-BVH-TRIANGLE-MESH-SHAPE))
(cffi:defcfun ("_wrap_delete_btScaledBvhTriangleMeshShape"
               DELETE/BT-SCALED-BVH-TRIANGLE-MESH-SHAPE) :void
  (self :pointer))
(declaim (inline SCALED-BVH-TRIANGLE-MESH-SHAPE/GET-AABB))
(cffi:defcfun ("_wrap_btScaledBvhTriangleMeshShape_getAabb"
               SCALED-BVH-TRIANGLE-MESH-SHAPE/GET-AABB) :void
  (self :pointer)
  (t_arg1 :pointer)
  (aabbMin :pointer)
  (aabbMax :pointer))
(declaim (inline SCALED-BVH-TRIANGLE-MESH-SHAPE/SET-LOCAL-SCALING))
(cffi:defcfun ("_wrap_btScaledBvhTriangleMeshShape_setLocalScaling"
               SCALED-BVH-TRIANGLE-MESH-SHAPE/SET-LOCAL-SCALING) :void
  (self :pointer)
  (scaling :pointer))
(declaim (inline SCALED-BVH-TRIANGLE-MESH-SHAPE/GET-LOCAL-SCALING))
(cffi:defcfun ("_wrap_btScaledBvhTriangleMeshShape_getLocalScaling"
               SCALED-BVH-TRIANGLE-MESH-SHAPE/GET-LOCAL-SCALING) :pointer
  (self :pointer))
(declaim (inline SCALED-BVH-TRIANGLE-MESH-SHAPE/CALCULATE-LOCAL-INERTIA))
(cffi:defcfun ("_wrap_btScaledBvhTriangleMeshShape_calculateLocalInertia"
               SCALED-BVH-TRIANGLE-MESH-SHAPE/CALCULATE-LOCAL-INERTIA) :void
  (self :pointer)
  (mass :float)
  (inertia :pointer))
(declaim (inline SCALED-BVH-TRIANGLE-MESH-SHAPE/PROCESS-ALL-TRIANGLES))
(cffi:defcfun ("_wrap_btScaledBvhTriangleMeshShape_processAllTriangles"
               SCALED-BVH-TRIANGLE-MESH-SHAPE/PROCESS-ALL-TRIANGLES) :void
  (self :pointer)
  (callback :pointer)
  (aabbMin :pointer)
  (aabbMax :pointer))
(declaim (inline SCALED-BVH-TRIANGLE-MESH-SHAPE/GET-CHILD-SHAPE))
(cffi:defcfun ("_wrap_btScaledBvhTriangleMeshShape_getChildShape__SWIG_0"
               SCALED-BVH-TRIANGLE-MESH-SHAPE/GET-CHILD-SHAPE) :pointer
  (self :pointer))
#+ (or)
(cffi:defcfun ("_wrap_btScaledBvhTriangleMeshShape_getChildShape__SWIG_1"
               SCALED-BVH-TRIANGLE-MESH-SHAPE/GET-CHILD-SHAPE) :pointer
  (self :pointer))
(declaim (inline SCALED-BVH-TRIANGLE-MESH-SHAPE/GET-NAME))
(cffi:defcfun ("_wrap_btScaledBvhTriangleMeshShape_getName"
               SCALED-BVH-TRIANGLE-MESH-SHAPE/GET-NAME) :string
  (self :pointer))
(declaim (inline SCALED-BVH-TRIANGLE-MESH-SHAPE/CALCULATE-SERIALIZE-BUFFER-SIZE))
(cffi:defcfun ("_wrap_btScaledBvhTriangleMeshShape_calculateSerializeBufferSize"
               SCALED-BVH-TRIANGLE-MESH-SHAPE/CALCULATE-SERIALIZE-BUFFER-SIZE) :int
  (self :pointer))
(declaim (inline SCALED-BVH-TRIANGLE-MESH-SHAPE/SERIALIZE))
(cffi:defcfun ("_wrap_btScaledBvhTriangleMeshShape_serialize"
               SCALED-BVH-TRIANGLE-MESH-SHAPE/SERIALIZE) :string
  (self :pointer)
  (dataBuffer :pointer)
  (serializer :pointer))

(declaim (inline TRIANGLE-MESH-SHAPE/MAKE-c++-INSTANCE))
(cffi:defcfun ("_wrap_btTriangleMeshShape_makeCPlusPlusInstance__SWIG_0"
               TRIANGLE-MESH-SHAPE/MAKE-c++-INSTANCE) :pointer
  (self :pointer)
  (sizeInBytes :pointer))
(declaim (inline TRIANGLE-MESH-SHAPE/DELETE-c++-INSTANCE))
(cffi:defcfun ("_wrap_btTriangleMeshShape_deleteCPlusPlusInstance__SWIG_0"
               TRIANGLE-MESH-SHAPE/DELETE-c++-INSTANCE) :void
  (self :pointer)
  (ptr :pointer))
(declaim (inline TRIANGLE-MESH-SHAPE/MAKE-c++-INSTANCE))
(cffi:defcfun ("_wrap_btTriangleMeshShape_makeCPlusPlusInstance__SWIG_1"
               TRIANGLE-MESH-SHAPE/MAKE-c++-INSTANCE/with-arg1&ptr) :pointer
  (self :pointer)
  (arg1 :pointer)
  (ptr :pointer))
(declaim (inline TRIANGLE-MESH-SHAPE/DELETE-c++-INSTANCE))
(cffi:defcfun ("_wrap_btTriangleMeshShape_deleteCPlusPlusInstance__SWIG_1"
               TRIANGLE-MESH-SHAPE/DELETE-c++-INSTANCE/with-arg1&2) :void
  (self :pointer)
  (arg1 :pointer)
  (arg2 :pointer))
(declaim (inline TRIANGLE-MESH-SHAPE/MAKE-c++-ARRAY))
(cffi:defcfun ("_wrap_btTriangleMeshShape_makeCPlusArray__SWIG_0"
               TRIANGLE-MESH-SHAPE/MAKE-c++-ARRAY) :pointer
  (self :pointer)
  (sizeInBytes :pointer))
(declaim (inline TRIANGLE-MESH-SHAPE/DELETE-c++-ARRAY))
(cffi:defcfun ("_wrap_btTriangleMeshShape_deleteCPlusArray__SWIG_0"
               TRIANGLE-MESH-SHAPE/DELETE-c++-ARRAY) :void
  (self :pointer)
  (ptr :pointer))
(declaim (inline TRIANGLE-MESH-SHAPE/MAKE-c++-ARRAY))
(cffi:defcfun ("_wrap_btTriangleMeshShape_makeCPlusArray__SWIG_1"
               TRIANGLE-MESH-SHAPE/MAKE-c++-ARRAY/with-arg1&ptr) :pointer
  (self :pointer)
  (arg1 :pointer)
  (ptr :pointer))
(declaim (inline TRIANGLE-MESH-SHAPE/DELETE-c++-ARRAY))
(cffi:defcfun ("_wrap_btTriangleMeshShape_deleteCPlusArray__SWIG_1"
               TRIANGLE-MESH-SHAPE/DELETE-c++-ARRAY/with-arg1&2) :void
  (self :pointer)
  (arg1 :pointer)
  (arg2 :pointer))
(declaim (inline DELETE/BT-TRIANGLE-MESH-SHAPE))
(cffi:defcfun ("_wrap_delete_btTriangleMeshShape"
               DELETE/BT-TRIANGLE-MESH-SHAPE) :void
  (self :pointer))
(declaim (inline TRIANGLE-MESH-SHAPE/LOCAL-GET-SUPPORTING-VERTEX))
(cffi:defcfun ("_wrap_btTriangleMeshShape_localGetSupportingVertex"
               TRIANGLE-MESH-SHAPE/LOCAL-GET-SUPPORTING-VERTEX) :pointer
  (self :pointer)
  (vec :pointer))
(declaim (inline TRIANGLE-MESH-SHAPE/LOCAL-GET-SUPPORTING-VERTEX-WITHOUT-MARGIN))
(cffi:defcfun ("_wrap_btTriangleMeshShape_localGetSupportingVertexWithoutMargin"
               TRIANGLE-MESH-SHAPE/LOCAL-GET-SUPPORTING-VERTEX-WITHOUT-MARGIN) :pointer
  (self :pointer)
  (vec :pointer))
(declaim (inline TRIANGLE-MESH-SHAPE/RECALC-LOCAL-AABB))
(cffi:defcfun ("_wrap_btTriangleMeshShape_recalcLocalAabb"
               TRIANGLE-MESH-SHAPE/RECALC-LOCAL-AABB) :void
  (self :pointer))
(declaim (inline TRIANGLE-MESH-SHAPE/GET-AABB))
(cffi:defcfun ("_wrap_btTriangleMeshShape_getAabb"
               TRIANGLE-MESH-SHAPE/GET-AABB) :void
  (self :pointer)
  (t_arg1 :pointer)
  (aabbMin :pointer)
  (aabbMax :pointer))
(declaim (inline TRIANGLE-MESH-SHAPE/PROCESS-ALL-TRIANGLES))
(cffi:defcfun ("_wrap_btTriangleMeshShape_processAllTriangles"
               TRIANGLE-MESH-SHAPE/PROCESS-ALL-TRIANGLES) :void
  (self :pointer)
  (callback :pointer)
  (aabbMin :pointer)
  (aabbMax :pointer))
(declaim (inline TRIANGLE-MESH-SHAPE/CALCULATE-LOCAL-INERTIA))
(cffi:defcfun ("_wrap_btTriangleMeshShape_calculateLocalInertia"
               TRIANGLE-MESH-SHAPE/CALCULATE-LOCAL-INERTIA) :void
  (self :pointer)
  (mass :float)
  (inertia :pointer))
(declaim (inline TRIANGLE-MESH-SHAPE/SET-LOCAL-SCALING))
(cffi:defcfun ("_wrap_btTriangleMeshShape_setLocalScaling"
               TRIANGLE-MESH-SHAPE/SET-LOCAL-SCALING) :void
  (self :pointer)
  (scaling :pointer))
(declaim (inline TRIANGLE-MESH-SHAPE/GET-LOCAL-SCALING))
(cffi:defcfun ("_wrap_btTriangleMeshShape_getLocalScaling"
               TRIANGLE-MESH-SHAPE/GET-LOCAL-SCALING) :pointer
  (self :pointer))
(declaim (inline TRIANGLE-MESH-SHAPE/GET-MESH-INTERFACE))
(cffi:defcfun ("_wrap_btTriangleMeshShape_getMeshInterface__SWIG_0"
               TRIANGLE-MESH-SHAPE/GET-MESH-INTERFACE) :pointer
  (self :pointer))
#+ (or)
(cffi:defcfun ("_wrap_btTriangleMeshShape_getMeshInterface__SWIG_1"
               TRIANGLE-MESH-SHAPE/GET-MESH-INTERFACE) :pointer
  (self :pointer))
(declaim (inline TRIANGLE-MESH-SHAPE/GET-LOCAL-AABB-MIN))
(cffi:defcfun ("_wrap_btTriangleMeshShape_getLocalAabbMin"
               TRIANGLE-MESH-SHAPE/GET-LOCAL-AABB-MIN) :pointer
  (self :pointer))
(declaim (inline TRIANGLE-MESH-SHAPE/GET-LOCAL-AABB-MAX))
(cffi:defcfun ("_wrap_btTriangleMeshShape_getLocalAabbMax"
               TRIANGLE-MESH-SHAPE/GET-LOCAL-AABB-MAX) :pointer
  (self :pointer))
(declaim (inline TRIANGLE-MESH-SHAPE/GET-NAME))
(cffi:defcfun ("_wrap_btTriangleMeshShape_getName"
               TRIANGLE-MESH-SHAPE/GET-NAME) :string
  (self :pointer))


(declaim (inline TRIANGLE-INDEX-VERTEX-ARRAY/MAKE-c++-INSTANCE))
(cffi:defcfun ("_wrap_btTriangleIndexVertexArray_makeCPlusPlusInstance__SWIG_0"
               TRIANGLE-INDEX-VERTEX-ARRAY/MAKE-c++-INSTANCE) :pointer
  (self :pointer)
  (sizeInBytes :pointer))
(declaim (inline TRIANGLE-INDEX-VERTEX-ARRAY/DELETE-c++-INSTANCE))
(cffi:defcfun ("_wrap_btTriangleIndexVertexArray_deleteCPlusPlusInstance__SWIG_0"
               TRIANGLE-INDEX-VERTEX-ARRAY/DELETE-c++-INSTANCE) :void
  (self :pointer)
  (ptr :pointer))
(declaim (inline TRIANGLE-INDEX-VERTEX-ARRAY/MAKE-c++-INSTANCE))
(cffi:defcfun ("_wrap_btTriangleIndexVertexArray_makeCPlusPlusInstance__SWIG_1"
               TRIANGLE-INDEX-VERTEX-ARRAY/MAKE-c++-INSTANCE/with-arg1&ptr) :pointer
  (self :pointer)
  (arg1 :pointer)
  (ptr :pointer))
(declaim (inline TRIANGLE-INDEX-VERTEX-ARRAY/DELETE-c++-INSTANCE))
(cffi:defcfun ("_wrap_btTriangleIndexVertexArray_deleteCPlusPlusInstance__SWIG_1"
               TRIANGLE-INDEX-VERTEX-ARRAY/DELETE-c++-INSTANCE/with-arg1&2) :void
  (self :pointer)
  (arg1 :pointer)
  (arg2 :pointer))
(declaim (inline TRIANGLE-INDEX-VERTEX-ARRAY/MAKE-c++-ARRAY))
(cffi:defcfun ("_wrap_btTriangleIndexVertexArray_makeCPlusArray__SWIG_0"
               TRIANGLE-INDEX-VERTEX-ARRAY/MAKE-c++-ARRAY) :pointer
  (self :pointer)
  (sizeInBytes :pointer))
(declaim (inline TRIANGLE-INDEX-VERTEX-ARRAY/DELETE-c++-ARRAY))
(cffi:defcfun ("_wrap_btTriangleIndexVertexArray_deleteCPlusArray__SWIG_0"
               TRIANGLE-INDEX-VERTEX-ARRAY/DELETE-c++-ARRAY) :void
  (self :pointer)
  (ptr :pointer))
(declaim (inline TRIANGLE-INDEX-VERTEX-ARRAY/MAKE-c++-ARRAY))
(cffi:defcfun ("_wrap_btTriangleIndexVertexArray_makeCPlusArray__SWIG_1"
               TRIANGLE-INDEX-VERTEX-ARRAY/MAKE-c++-ARRAY/with-arg1&ptr) :pointer
  (self :pointer)
  (arg1 :pointer)
  (ptr :pointer))
(declaim (inline TRIANGLE-INDEX-VERTEX-ARRAY/DELETE-c++-ARRAY))
(cffi:defcfun ("_wrap_btTriangleIndexVertexArray_deleteCPlusArray__SWIG_1"
               TRIANGLE-INDEX-VERTEX-ARRAY/DELETE-c++-ARRAY/with-arg1&2) :void
  (self :pointer)
  (arg1 :pointer)
  (arg2 :pointer))
(declaim (inline MAKE-TRIANGLE-INDEX-VERTEX-ARRAY))
(cffi:defcfun ("_wrap_new_btTriangleIndexVertexArray__SWIG_0"
               MAKE-TRIANGLE-INDEX-VERTEX-ARRAY) :pointer)
(declaim (inline DELETE/BT-TRIANGLE-INDEX-VERTEX-ARRAY))
(cffi:defcfun ("_wrap_delete_btTriangleIndexVertexArray"
               DELETE/BT-TRIANGLE-INDEX-VERTEX-ARRAY) :void
  (self :pointer))
(declaim (inline MAKE-TRIANGLE-INDEX-VERTEX-ARRAY))
(cffi:defcfun ("_wrap_new_btTriangleIndexVertexArray__SWIG_1"
               MAKE-TRIANGLE-INDEX-VERTEX-ARRAY/with-triangle-index-base&stride&num-vertices&vertex-base&stride)
    :pointer
  (numTriangles :int)
  (triangleIndexBase :pointer)
  (triangleIndexStride :int)
  (numVertices :int)
  (vertexBase :pointer)
  (vertexStride :int))
(declaim (inline TRIANGLE-INDEX-VERTEX-ARRAY/ADD-INDEXED-MESH))
(cffi:defcfun ("_wrap_btTriangleIndexVertexArray_addIndexedMesh__SWIG_0"
               TRIANGLE-INDEX-VERTEX-ARRAY/ADD-INDEXED-MESH/with-index-type) :void
  (self :pointer)
  (mesh :pointer)
  (indexType :pointer))
(declaim (inline TRIANGLE-INDEX-VERTEX-ARRAY/ADD-INDEXED-MESH))
(cffi:defcfun ("_wrap_btTriangleIndexVertexArray_addIndexedMesh__SWIG_1"
               TRIANGLE-INDEX-VERTEX-ARRAY/ADD-INDEXED-MESH) :void
  (self :pointer)
  (mesh :pointer))
(declaim (inline TRIANGLE-INDEX-VERTEX-ARRAY/GET-LOCKED-VERTEX-INDEX-BASE))
(cffi:defcfun ("_wrap_btTriangleIndexVertexArray_getLockedVertexIndexBase__SWIG_0"
               TRIANGLE-INDEX-VERTEX-ARRAY/GET-LOCKED-VERTEX-INDEX-BASE/with-v&n&t&v&i&i&n&i&s) :void
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
(declaim (inline TRIANGLE-INDEX-VERTEX-ARRAY/GET-LOCKED-VERTEX-INDEX-BASE))
(cffi:defcfun ("_wrap_btTriangleIndexVertexArray_getLockedVertexIndexBase__SWIG_1"
               TRIANGLE-INDEX-VERTEX-ARRAY/GET-LOCKED-VERTEX-INDEX-BASE/with-v&n&t&v&i&i&n&i) :void
  (self :pointer)
  (vertexbase :pointer)
  (numverts :pointer)
  (type :pointer)
  (vertexStride :pointer)
  (indexbase :pointer)
  (indexstride :pointer)
  (numfaces :pointer)
  (indicestype :pointer))
(declaim (inline TRIANGLE-INDEX-VERTEX-ARRAY/GET-LOCKED-READ-ONLY-VERTEX-INDEX-BASE))
(cffi:defcfun ("_wrap_btTriangleIndexVertexArray_getLockedReadOnlyVertexIndexBase__SWIG_0"
               TRIANGLE-INDEX-VERTEX-ARRAY/GET-LOCKED-READ-ONLY-VERTEX-INDEX-BASE/with-v&n&t&v&i&i&n&i&s) :void
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
(declaim (inline TRIANGLE-INDEX-VERTEX-ARRAY/GET-LOCKED-READ-ONLY-VERTEX-INDEX-BASE))
(cffi:defcfun ("_wrap_btTriangleIndexVertexArray_getLockedReadOnlyVertexIndexBase__SWIG_1"
               TRIANGLE-INDEX-VERTEX-ARRAY/GET-LOCKED-READ-ONLY-VERTEX-INDEX-BASE/with-v&n&t&v&i&i&n&i) :void
  (self :pointer)
  (vertexbase :pointer)
  (numverts :pointer)
  (type :pointer)
  (vertexStride :pointer)
  (indexbase :pointer)
  (indexstride :pointer)
  (numfaces :pointer)
  (indicestype :pointer))
(declaim (inline TRIANGLE-INDEX-VERTEX-ARRAY/UN-LOCK-VERTEX-BASE))
(cffi:defcfun ("_wrap_btTriangleIndexVertexArray_unLockVertexBase"
               TRIANGLE-INDEX-VERTEX-ARRAY/UN-LOCK-VERTEX-BASE) :void
  (self :pointer)
  (subpart :int))
(declaim (inline TRIANGLE-INDEX-VERTEX-ARRAY/UN-LOCK-READ-ONLY-VERTEX-BASE))
(cffi:defcfun ("_wrap_btTriangleIndexVertexArray_unLockReadOnlyVertexBase"
               TRIANGLE-INDEX-VERTEX-ARRAY/UN-LOCK-READ-ONLY-VERTEX-BASE) :void
  (self :pointer)
  (subpart :int))
(declaim (inline TRIANGLE-INDEX-VERTEX-ARRAY/GET-NUM-SUB-PARTS))
(cffi:defcfun ("_wrap_btTriangleIndexVertexArray_getNumSubParts"
               TRIANGLE-INDEX-VERTEX-ARRAY/GET-NUM-SUB-PARTS) :int
  (self :pointer))
(declaim (inline TRIANGLE-INDEX-VERTEX-ARRAY/GET-INDEXED-MESH-ARRAY))
(cffi:defcfun ("_wrap_btTriangleIndexVertexArray_getIndexedMeshArray__SWIG_0"
               TRIANGLE-INDEX-VERTEX-ARRAY/GET-INDEXED-MESH-ARRAY) :pointer
  (self :pointer))
#+ (or)
(cffi:defcfun ("_wrap_btTriangleIndexVertexArray_getIndexedMeshArray__SWIG_1"
               TRIANGLE-INDEX-VERTEX-ARRAY/GET-INDEXED-MESH-ARRAY) :pointer
  (self :pointer))
(declaim (inline TRIANGLE-INDEX-VERTEX-ARRAY/PREALLOCATE-VERTICES))
(cffi:defcfun ("_wrap_btTriangleIndexVertexArray_preallocateVertices"
               TRIANGLE-INDEX-VERTEX-ARRAY/PREALLOCATE-VERTICES) :void
  (self :pointer)
  (numverts :int))
(declaim (inline TRIANGLE-INDEX-VERTEX-ARRAY/PREALLOCATE-INDICES))
(cffi:defcfun ("_wrap_btTriangleIndexVertexArray_preallocateIndices"
               TRIANGLE-INDEX-VERTEX-ARRAY/PREALLOCATE-INDICES) :void
  (self :pointer)
  (numindices :int))
(declaim (inline TRIANGLE-INDEX-VERTEX-ARRAY/HAS-PREMADE-AABB))
(cffi:defcfun ("_wrap_btTriangleIndexVertexArray_hasPremadeAabb"
               TRIANGLE-INDEX-VERTEX-ARRAY/HAS-PREMADE-AABB) :pointer
  (self :pointer))
(declaim (inline TRIANGLE-INDEX-VERTEX-ARRAY/SET-PREMADE-AABB))
(cffi:defcfun ("_wrap_btTriangleIndexVertexArray_setPremadeAabb"
               TRIANGLE-INDEX-VERTEX-ARRAY/SET-PREMADE-AABB) :void
  (self :pointer)
  (aabbMin :pointer)
  (aabbMax :pointer))
(declaim (inline TRIANGLE-INDEX-VERTEX-ARRAY/GET-PREMADE-AABB))
(cffi:defcfun ("_wrap_btTriangleIndexVertexArray_getPremadeAabb"
               TRIANGLE-INDEX-VERTEX-ARRAY/GET-PREMADE-AABB) :void
  (self :pointer)
  (aabbMin :pointer)
  (aabbMax :pointer))

(declaim (inline COMPOUND-SHAPE/MAKE-c++-INSTANCE))
(cffi:defcfun ("_wrap_btCompoundShape_makeCPlusPlusInstance__SWIG_0"
               COMPOUND-SHAPE/MAKE-c++-INSTANCE) :pointer
  (self :pointer)
  (sizeInBytes :pointer))
(declaim (inline COMPOUND-SHAPE/DELETE-c++-INSTANCE))
(cffi:defcfun ("_wrap_btCompoundShape_deleteCPlusPlusInstance__SWIG_0"
               COMPOUND-SHAPE/DELETE-c++-INSTANCE) :void
  (self :pointer)
  (ptr :pointer))
(declaim (inline COMPOUND-SHAPE/MAKE-c++-INSTANCE))
(cffi:defcfun ("_wrap_btCompoundShape_makeCPlusPlusInstance__SWIG_1"
               COMPOUND-SHAPE/MAKE-c++-INSTANCE/with-arg1&ptr) :pointer
  (self :pointer)
  (arg1 :pointer)
  (ptr :pointer))
(declaim (inline COMPOUND-SHAPE/DELETE-c++-INSTANCE))
(cffi:defcfun ("_wrap_btCompoundShape_deleteCPlusPlusInstance__SWIG_1"
               COMPOUND-SHAPE/DELETE-c++-INSTANCE/with-arg1&2) :void
  (self :pointer)
  (arg1 :pointer)
  (arg2 :pointer))
(declaim (inline COMPOUND-SHAPE/MAKE-c++-ARRAY))
(cffi:defcfun ("_wrap_btCompoundShape_makeCPlusArray__SWIG_0"
               COMPOUND-SHAPE/MAKE-c++-ARRAY) :pointer
  (self :pointer)
  (sizeInBytes :pointer))
(declaim (inline COMPOUND-SHAPE/DELETE-c++-ARRAY))
(cffi:defcfun ("_wrap_btCompoundShape_deleteCPlusArray__SWIG_0"
               COMPOUND-SHAPE/DELETE-c++-ARRAY) :void
  (self :pointer)
  (ptr :pointer))
(declaim (inline COMPOUND-SHAPE/MAKE-c++-ARRAY))
(cffi:defcfun ("_wrap_btCompoundShape_makeCPlusArray__SWIG_1"
               COMPOUND-SHAPE/MAKE-c++-ARRAY/with-arg1&ptr) :pointer
  (self :pointer)
  (arg1 :pointer)
  (ptr :pointer))
(declaim (inline COMPOUND-SHAPE/DELETE-c++-ARRAY))
(cffi:defcfun ("_wrap_btCompoundShape_deleteCPlusArray__SWIG_1"
               COMPOUND-SHAPE/DELETE-c++-ARRAY/with-arg1&2) :void
  (self :pointer)
  (arg1 :pointer)
  (arg2 :pointer))

