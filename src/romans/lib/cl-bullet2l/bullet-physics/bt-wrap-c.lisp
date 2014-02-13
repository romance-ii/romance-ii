(in-package #:bullet-physics)
(declaim (inline MAKE-COMPOUND-SHAPE))
(cffi:defcfun ("_wrap_new_btCompoundShape__SWIG_0"
               MAKE-COMPOUND-SHAPE/with-enable-dynamic-aabb-tree) :pointer
  (enableDynamicAabbTree :pointer))
(declaim (inline MAKE-COMPOUND-SHAPE))
(cffi:defcfun ("_wrap_new_btCompoundShape__SWIG_1"
               MAKE-COMPOUND-SHAPE) :pointer)
(declaim (inline DELETE/BT-COMPOUND-SHAPE))
(cffi:defcfun ("_wrap_delete_btCompoundShape"
               DELETE/BT-COMPOUND-SHAPE) :void
  (self :pointer))
(declaim (inline COMPOUND-SHAPE/ADD-CHILD-SHAPE))
(cffi:defcfun ("_wrap_btCompoundShape_addChildShape"
               COMPOUND-SHAPE/ADD-CHILD-SHAPE) :void
  (self :pointer)
  (localTransform :pointer)
  (shape :pointer))
(declaim (inline COMPOUND-SHAPE/REMOVE-CHILD-SHAPE))
(cffi:defcfun ("_wrap_btCompoundShape_removeChildShape"
               COMPOUND-SHAPE/REMOVE-CHILD-SHAPE) :void
  (self :pointer)
  (shape :pointer))
(declaim (inline COMPOUND-SHAPE/REMOVE-CHILD-SHAPE-BY-INDEX))
(cffi:defcfun ("_wrap_btCompoundShape_removeChildShapeByIndex"
               COMPOUND-SHAPE/REMOVE-CHILD-SHAPE-BY-INDEX) :void
  (self :pointer)
  (childShapeindex :int))
(declaim (inline COMPOUND-SHAPE/GET-NUM-CHILD-SHAPES))
(cffi:defcfun ("_wrap_btCompoundShape_getNumChildShapes"
               COMPOUND-SHAPE/GET-NUM-CHILD-SHAPES) :int
  (self :pointer))
(declaim (inline COMPOUND-SHAPE/GET-CHILD-SHAPE))
(cffi:defcfun ("_wrap_btCompoundShape_getChildShape__SWIG_0"
               COMPOUND-SHAPE/GET-CHILD-SHAPE) :pointer
  (self :pointer)
  (index :int))
#+ (or)
(cffi:defcfun ("_wrap_btCompoundShape_getChildShape__SWIG_1"
               COMPOUND-SHAPE/GET-CHILD-SHAPE) :pointer
  (self :pointer)
  (index :int))
(declaim (inline COMPOUND-SHAPE/GET-CHILD-TRANSFORM))
(cffi:defcfun ("_wrap_btCompoundShape_getChildTransform__SWIG_0"
               COMPOUND-SHAPE/GET-CHILD-TRANSFORM) :pointer
  (self :pointer)
  (index :int))
#+ (or)
(cffi:defcfun ("_wrap_btCompoundShape_getChildTransform__SWIG_1"
               COMPOUND-SHAPE/GET-CHILD-TRANSFORM) :pointer
  (self :pointer)
  (index :int))
(declaim (inline COMPOUND-SHAPE/UPDATE-CHILD-TRANSFORM))
(cffi:defcfun ("_wrap_btCompoundShape_updateChildTransform__SWIG_0"
               COMPOUND-SHAPE/UPDATE-CHILD-TRANSFORM/with-child-index&new-child-transform&should-recalculate-local-aabb)
    :void
  (self :pointer)
  (childIndex :int)
  (newChildTransform :pointer)
  (shouldRecalculateLocalAabb :pointer))
(declaim (inline COMPOUND-SHAPE/UPDATE-CHILD-TRANSFORM))
(cffi:defcfun ("_wrap_btCompoundShape_updateChildTransform__SWIG_1"
               COMPOUND-SHAPE/UPDATE-CHILD-TRANSFORM/with-child-index&new-child-transform)
    :void
  (self :pointer)
  (childIndex :int)
  (newChildTransform :pointer))
(declaim (inline COMPOUND-SHAPE/GET-CHILD-LIST))
(cffi:defcfun ("_wrap_btCompoundShape_getChildList"
               COMPOUND-SHAPE/GET-CHILD-LIST) :pointer
  (self :pointer))
(declaim (inline COMPOUND-SHAPE/GET-AABB))
(cffi:defcfun ("_wrap_btCompoundShape_getAabb"
               COMPOUND-SHAPE/GET-AABB) :void
  (self :pointer)
  (t_arg1 :pointer)
  (aabbMin :pointer)
  (aabbMax :pointer))
(declaim (inline COMPOUND-SHAPE/RECALCULATE-LOCAL-AABB))
(cffi:defcfun ("_wrap_btCompoundShape_recalculateLocalAabb"
               COMPOUND-SHAPE/RECALCULATE-LOCAL-AABB) :void
  (self :pointer))
(declaim (inline COMPOUND-SHAPE/SET-LOCAL-SCALING))
(cffi:defcfun ("_wrap_btCompoundShape_setLocalScaling"
               COMPOUND-SHAPE/SET-LOCAL-SCALING) :void
  (self :pointer)
  (scaling :pointer))
(declaim (inline COMPOUND-SHAPE/GET-LOCAL-SCALING))
(cffi:defcfun ("_wrap_btCompoundShape_getLocalScaling"
               COMPOUND-SHAPE/GET-LOCAL-SCALING) :pointer
  (self :pointer))
(declaim (inline COMPOUND-SHAPE/CALCULATE-LOCAL-INERTIA))
(cffi:defcfun ("_wrap_btCompoundShape_calculateLocalInertia"
               COMPOUND-SHAPE/CALCULATE-LOCAL-INERTIA) :void
  (self :pointer)
  (mass :float)
  (inertia :pointer))
(declaim (inline COMPOUND-SHAPE/SET-MARGIN))
(cffi:defcfun ("_wrap_btCompoundShape_setMargin"
               COMPOUND-SHAPE/SET-MARGIN) :void
  (self :pointer)
  (margin :float))
(declaim (inline COMPOUND-SHAPE/GET-MARGIN))
(cffi:defcfun ("_wrap_btCompoundShape_getMargin"
               COMPOUND-SHAPE/GET-MARGIN) :float
  (self :pointer))
(declaim (inline COMPOUND-SHAPE/GET-NAME))
(cffi:defcfun ("_wrap_btCompoundShape_getName"
               COMPOUND-SHAPE/GET-NAME) :string
  (self :pointer))
(declaim (inline COMPOUND-SHAPE/GET-DYNAMIC-AABB-TREE))
(cffi:defcfun ("_wrap_btCompoundShape_getDynamicAabbTree__SWIG_0"
               COMPOUND-SHAPE/GET-DYNAMIC-AABB-TREE) :pointer
  (self :pointer))
#+ (or)
(cffi:defcfun ("_wrap_btCompoundShape_getDynamicAabbTree__SWIG_1"
               COMPOUND-SHAPE/GET-DYNAMIC-AABB-TREE) :pointer
  (self :pointer))
(declaim (inline COMPOUND-SHAPE/CREATE-AABB-TREE-FROM-CHILDREN))
(cffi:defcfun ("_wrap_btCompoundShape_createAabbTreeFromChildren"
               COMPOUND-SHAPE/CREATE-AABB-TREE-FROM-CHILDREN) :void
  (self :pointer))
(declaim (inline COMPOUND-SHAPE/CALCULATE-PRINCIPAL-AXIS-TRANSFORM))
(cffi:defcfun ("_wrap_btCompoundShape_calculatePrincipalAxisTransform"
               COMPOUND-SHAPE/CALCULATE-PRINCIPAL-AXIS-TRANSFORM) :void
  (self :pointer)
  (masses :pointer)
  (principal :pointer)
  (inertia :pointer))
(declaim (inline COMPOUND-SHAPE/GET-UPDATE-REVISION))
(cffi:defcfun ("_wrap_btCompoundShape_getUpdateRevision"
               COMPOUND-SHAPE/GET-UPDATE-REVISION) :int
  (self :pointer))
(declaim (inline COMPOUND-SHAPE/CALCULATE-SERIALIZE-BUFFER-SIZE))
(cffi:defcfun ("_wrap_btCompoundShape_calculateSerializeBufferSize"
               COMPOUND-SHAPE/CALCULATE-SERIALIZE-BUFFER-SIZE) :int
  (self :pointer))
(declaim (inline COMPOUND-SHAPE/SERIALIZE))
(cffi:defcfun ("_wrap_btCompoundShape_serialize"
               COMPOUND-SHAPE/SERIALIZE) :string
  (self :pointer)
  (dataBuffer :pointer)
  (serializer :pointer))

(declaim (inline BU/SIMPLEX-1TO-4/MAKE-c++-INSTANCE))
(cffi:defcfun ("_wrap_btBU_Simplex1to4_makeCPlusPlusInstance__SWIG_0"
               BU/SIMPLEX-1TO-4/MAKE-c++-INSTANCE) :pointer
  (self :pointer)
  (sizeInBytes :pointer))
(declaim (inline BU/SIMPLEX-1TO-4/DELETE-c++-INSTANCE))
(cffi:defcfun ("_wrap_btBU_Simplex1to4_deleteCPlusPlusInstance__SWIG_0"
               BU/SIMPLEX-1TO-4/DELETE-c++-INSTANCE) :void
  (self :pointer)
  (ptr :pointer))
(declaim (inline BU/SIMPLEX-1TO-4/MAKE-c++-INSTANCE))
(cffi:defcfun ("_wrap_btBU_Simplex1to4_makeCPlusPlusInstance__SWIG_1"
               BU/SIMPLEX-1TO-4/MAKE-c++-INSTANCE/with-arg1&ptr) :pointer
  (self :pointer)
  (arg1 :pointer)
  (ptr :pointer))
(declaim (inline BU/SIMPLEX-1TO-4/DELETE-c++-INSTANCE))
(cffi:defcfun ("_wrap_btBU_Simplex1to4_deleteCPlusPlusInstance__SWIG_1"
               BU/SIMPLEX-1TO-4/DELETE-c++-INSTANCE/with-arg1&2) :void
  (self :pointer)
  (arg1 :pointer)
  (arg2 :pointer))
(declaim (inline BU/SIMPLEX-1TO-4/MAKE-c++-ARRAY))
(cffi:defcfun ("_wrap_btBU_Simplex1to4_makeCPlusArray__SWIG_0"
               BU/SIMPLEX-1TO-4/MAKE-c++-ARRAY) :pointer
  (self :pointer)
  (sizeInBytes :pointer))
(declaim (inline BU/SIMPLEX-1TO-4/DELETE-c++-ARRAY))
(cffi:defcfun ("_wrap_btBU_Simplex1to4_deleteCPlusArray__SWIG_0"
               BU/SIMPLEX-1TO-4/DELETE-c++-ARRAY) :void
  (self :pointer)
  (ptr :pointer))
(declaim (inline BU/SIMPLEX-1TO-4/MAKE-c++-ARRAY))
(cffi:defcfun ("_wrap_btBU_Simplex1to4_makeCPlusArray__SWIG_1"
               BU/SIMPLEX-1TO-4/MAKE-c++-ARRAY/with-arg1&ptr) :pointer
  (self :pointer)
  (arg1 :pointer)
  (ptr :pointer))
(declaim (inline BU/SIMPLEX-1TO-4/DELETE-c++-ARRAY))
(cffi:defcfun ("_wrap_btBU_Simplex1to4_deleteCPlusArray__SWIG_1"
               BU/SIMPLEX-1TO-4/DELETE-c++-ARRAY/with-arg1&2) :void
  (self :pointer)
  (arg1 :pointer)
  (arg2 :pointer))
(declaim (inline MAKE-BU/SIMPLEX-1TO-4))
(cffi:defcfun ("_wrap_new_btBU_Simplex1to4__SWIG_0"
               MAKE-BU/SIMPLEX-1TO-4) :pointer)
(declaim (inline MAKE-BU/SIMPLEX-1TO-4))
(cffi:defcfun ("_wrap_new_btBU_Simplex1to4__SWIG_1"
               MAKE-BU/SIMPLEX-1TO-4/with-pt0) :pointer
  (pt0 :pointer))
(declaim (inline MAKE-BU/SIMPLEX-1TO-4))
(cffi:defcfun ("_wrap_new_btBU_Simplex1to4__SWIG_2"
               MAKE-BU/SIMPLEX-1TO-4/with-pt0&1) :pointer
  (pt0 :pointer)
  (pt1 :pointer))
(declaim (inline MAKE-BU/SIMPLEX-1TO-4))
(cffi:defcfun ("_wrap_new_btBU_Simplex1to4__SWIG_3"
               MAKE-BU/SIMPLEX-1TO-4/with-pt0-2) :pointer
  (pt0 :pointer)
  (pt1 :pointer)
  (pt2 :pointer))
(declaim (inline MAKE-BU/SIMPLEX-1TO-4))
(cffi:defcfun ("_wrap_new_btBU_Simplex1to4__SWIG_4"
               MAKE-BU/SIMPLEX-1TO-4/with-pt0-3) :pointer
  (pt0 :pointer)
  (pt1 :pointer)
  (pt2 :pointer)
  (pt3 :pointer))
(declaim (inline BU/SIMPLEX-1TO-4/RESET))
(cffi:defcfun ("_wrap_btBU_Simplex1to4_reset"
               BU/SIMPLEX-1TO-4/RESET) :void
  (self :pointer))
(declaim (inline BU/SIMPLEX-1TO-4/GET-AABB))
(cffi:defcfun ("_wrap_btBU_Simplex1to4_getAabb"
               BU/SIMPLEX-1TO-4/GET-AABB) :void
  (self :pointer)
  (t_arg1 :pointer)
  (aabbMin :pointer)
  (aabbMax :pointer))
(declaim (inline BU/SIMPLEX-1TO-4/ADD-VERTEX))
(cffi:defcfun ("_wrap_btBU_Simplex1to4_addVertex"
               BU/SIMPLEX-1TO-4/ADD-VERTEX) :void
  (self :pointer)
  (pt :pointer))
(declaim (inline BU/SIMPLEX-1TO-4/GET-NUM-VERTICES))
(cffi:defcfun ("_wrap_btBU_Simplex1to4_getNumVertices"
               BU/SIMPLEX-1TO-4/GET-NUM-VERTICES) :int
  (self :pointer))
(declaim (inline BU/SIMPLEX-1TO-4/GET-NUM-EDGES))
(cffi:defcfun ("_wrap_btBU_Simplex1to4_getNumEdges"
               BU/SIMPLEX-1TO-4/GET-NUM-EDGES) :int
  (self :pointer))
(declaim (inline BU/SIMPLEX-1TO-4/GET-EDGE))
(cffi:defcfun ("_wrap_btBU_Simplex1to4_getEdge"
               BU/SIMPLEX-1TO-4/GET-EDGE) :void
  (self :pointer)
  (i :int)
  (pa :pointer)
  (pb :pointer))
(declaim (inline BU/SIMPLEX-1TO-4/GET-VERTEX))
(cffi:defcfun ("_wrap_btBU_Simplex1to4_getVertex"
               BU/SIMPLEX-1TO-4/GET-VERTEX) :void
  (self :pointer)
  (i :int)
  (vtx :pointer))
(declaim (inline BU/SIMPLEX-1TO-4/GET-NUM-PLANES))
(cffi:defcfun ("_wrap_btBU_Simplex1to4_getNumPlanes"
               BU/SIMPLEX-1TO-4/GET-NUM-PLANES) :int
  (self :pointer))
(declaim (inline BU/SIMPLEX-1TO-4/GET-PLANE))
(cffi:defcfun ("_wrap_btBU_Simplex1to4_getPlane"
               BU/SIMPLEX-1TO-4/GET-PLANE) :void
  (self :pointer)
  (planeNormal :pointer)
  (planeSupport :pointer)
  (i :int))
(declaim (inline BU/SIMPLEX-1TO-4/GET-INDEX))
(cffi:defcfun ("_wrap_btBU_Simplex1to4_getIndex"
               BU/SIMPLEX-1TO-4/GET-INDEX) :int
  (self :pointer)
  (i :int))
(declaim (inline BU/SIMPLEX-1TO-4/IS-INSIDE))
(cffi:defcfun ("_wrap_btBU_Simplex1to4_isInside"
               BU/SIMPLEX-1TO-4/IS-INSIDE) :pointer
  (self :pointer)
  (pt :pointer)
  (tolerance :float))
(declaim (inline BU/SIMPLEX-1TO-4/GET-NAME))
(cffi:defcfun ("_wrap_btBU_Simplex1to4_getName"
               BU/SIMPLEX-1TO-4/GET-NAME) :string
  (self :pointer))
(declaim (inline DELETE/BT-BU/SIMPLEX-1TO-4))
(cffi:defcfun ("_wrap_delete_btBU_Simplex1to4"
               DELETE/BT-BU/SIMPLEX-1TO-4) :void
  (self :pointer))
(declaim (inline EMPTY-SHAPE/MAKE-c++-INSTANCE))
(cffi:defcfun ("_wrap_btEmptyShape_makeCPlusPlusInstance__SWIG_0"
               EMPTY-SHAPE/MAKE-c++-INSTANCE) :pointer
  (self :pointer)
  (sizeInBytes :pointer))
(declaim (inline EMPTY-SHAPE/DELETE-c++-INSTANCE))
(cffi:defcfun ("_wrap_btEmptyShape_deleteCPlusPlusInstance__SWIG_0"
               EMPTY-SHAPE/DELETE-c++-INSTANCE) :void
  (self :pointer)
  (ptr :pointer))
(declaim (inline EMPTY-SHAPE/MAKE-c++-INSTANCE))
(cffi:defcfun ("_wrap_btEmptyShape_makeCPlusPlusInstance__SWIG_1"
               EMPTY-SHAPE/MAKE-c++-INSTANCE/with-arg1&ptr) :pointer
  (self :pointer)
  (arg1 :pointer)
  (ptr :pointer))
(declaim (inline EMPTY-SHAPE/DELETE-c++-INSTANCE))
(cffi:defcfun ("_wrap_btEmptyShape_deleteCPlusPlusInstance__SWIG_1"
               EMPTY-SHAPE/DELETE-c++-INSTANCE/with-arg1&2) :void
  (self :pointer)
  (arg1 :pointer)
  (arg2 :pointer))
(declaim (inline EMPTY-SHAPE/MAKE-c++-ARRAY))
(cffi:defcfun ("_wrap_btEmptyShape_makeCPlusArray__SWIG_0"
               EMPTY-SHAPE/MAKE-c++-ARRAY) :pointer
  (self :pointer)
  (sizeInBytes :pointer))
(declaim (inline EMPTY-SHAPE/DELETE-c++-ARRAY))
(cffi:defcfun ("_wrap_btEmptyShape_deleteCPlusArray__SWIG_0"
               EMPTY-SHAPE/DELETE-c++-ARRAY) :void
  (self :pointer)
  (ptr :pointer))
(declaim (inline EMPTY-SHAPE/MAKE-c++-ARRAY))
(cffi:defcfun ("_wrap_btEmptyShape_makeCPlusArray__SWIG_1"
               EMPTY-SHAPE/MAKE-c++-ARRAY/with-arg1&ptr) :pointer
  (self :pointer)
  (arg1 :pointer)
  (ptr :pointer))
(declaim (inline EMPTY-SHAPE/DELETE-c++-ARRAY))
(cffi:defcfun ("_wrap_btEmptyShape_deleteCPlusArray__SWIG_1"
               EMPTY-SHAPE/DELETE-c++-ARRAY/with-arg1&2) :void
  (self :pointer)
  (arg1 :pointer)
  (arg2 :pointer))
(declaim (inline MAKE-EMPTY-SHAPE))
(cffi:defcfun ("_wrap_new_btEmptyShape"
               MAKE-EMPTY-SHAPE) :pointer)
(declaim (inline DELETE/BT-EMPTY-SHAPE))
(cffi:defcfun ("_wrap_delete_btEmptyShape"
               DELETE/BT-EMPTY-SHAPE) :void
  (self :pointer))
(declaim (inline EMPTY-SHAPE/GET-AABB))
(cffi:defcfun ("_wrap_btEmptyShape_getAabb"
               EMPTY-SHAPE/GET-AABB) :void
  (self :pointer)
  (t_arg1 :pointer)
  (aabbMin :pointer)
  (aabbMax :pointer))
(declaim (inline EMPTY-SHAPE/SET-LOCAL-SCALING))
(cffi:defcfun ("_wrap_btEmptyShape_setLocalScaling"
               EMPTY-SHAPE/SET-LOCAL-SCALING) :void
  (self :pointer)
  (scaling :pointer))
(declaim (inline EMPTY-SHAPE/GET-LOCAL-SCALING))
(cffi:defcfun ("_wrap_btEmptyShape_getLocalScaling"
               EMPTY-SHAPE/GET-LOCAL-SCALING) :pointer
  (self :pointer))
(declaim (inline EMPTY-SHAPE/CALCULATE-LOCAL-INERTIA))
(cffi:defcfun ("_wrap_btEmptyShape_calculateLocalInertia"
               EMPTY-SHAPE/CALCULATE-LOCAL-INERTIA) :void
  (self :pointer)
  (mass :float)
  (inertia :pointer))
(declaim (inline EMPTY-SHAPE/GET-NAME))
(cffi:defcfun ("_wrap_btEmptyShape_getName"
               EMPTY-SHAPE/GET-NAME) :string
  (self :pointer))
(declaim (inline EMPTY-SHAPE/PROCESS-ALL-TRIANGLES))
(cffi:defcfun ("_wrap_btEmptyShape_processAllTriangles"
               EMPTY-SHAPE/PROCESS-ALL-TRIANGLES) :void
  (self :pointer)
  (arg1 :pointer)
  (arg2 :pointer)
  (arg3 :pointer))
(declaim (inline MULTI-SPHERE-SHAPE/MAKE-c++-INSTANCE))
(cffi:defcfun ("_wrap_btMultiSphereShape_makeCPlusPlusInstance__SWIG_0"
               MULTI-SPHERE-SHAPE/MAKE-c++-INSTANCE) :pointer
  (self :pointer)
  (sizeInBytes :pointer))
(declaim (inline MULTI-SPHERE-SHAPE/DELETE-c++-INSTANCE))
(cffi:defcfun ("_wrap_btMultiSphereShape_deleteCPlusPlusInstance__SWIG_0"
               MULTI-SPHERE-SHAPE/DELETE-c++-INSTANCE) :void
  (self :pointer)
  (ptr :pointer))
(declaim (inline MULTI-SPHERE-SHAPE/MAKE-c++-INSTANCE))
(cffi:defcfun ("_wrap_btMultiSphereShape_makeCPlusPlusInstance__SWIG_1"
               MULTI-SPHERE-SHAPE/MAKE-c++-INSTANCE/with-arg1&ptr) :pointer
  (self :pointer)
  (arg1 :pointer)
  (ptr :pointer))
(declaim (inline MULTI-SPHERE-SHAPE/DELETE-c++-INSTANCE))
(cffi:defcfun ("_wrap_btMultiSphereShape_deleteCPlusPlusInstance__SWIG_1"
               MULTI-SPHERE-SHAPE/DELETE-c++-INSTANCE/with-arg1&2) :void
  (self :pointer)
  (arg1 :pointer)
  (arg2 :pointer))
(declaim (inline MULTI-SPHERE-SHAPE/MAKE-c++-ARRAY))
(cffi:defcfun ("_wrap_btMultiSphereShape_makeCPlusArray__SWIG_0"
               MULTI-SPHERE-SHAPE/MAKE-c++-ARRAY) :pointer
  (self :pointer)
  (sizeInBytes :pointer))
(declaim (inline MULTI-SPHERE-SHAPE/DELETE-c++-ARRAY))
(cffi:defcfun ("_wrap_btMultiSphereShape_deleteCPlusArray__SWIG_0"
               MULTI-SPHERE-SHAPE/DELETE-c++-ARRAY) :void
  (self :pointer)
  (ptr :pointer))
(declaim (inline MULTI-SPHERE-SHAPE/MAKE-c++-ARRAY))
(cffi:defcfun ("_wrap_btMultiSphereShape_makeCPlusArray__SWIG_1"
               MULTI-SPHERE-SHAPE/MAKE-c++-ARRAY/with-arg1&ptr) :pointer
  (self :pointer)
  (arg1 :pointer)
  (ptr :pointer))
(declaim (inline MULTI-SPHERE-SHAPE/DELETE-c++-ARRAY))
(cffi:defcfun ("_wrap_btMultiSphereShape_deleteCPlusArray__SWIG_1"
               MULTI-SPHERE-SHAPE/DELETE-c++-ARRAY/with-arg1&2) :void
  (self :pointer)
  (arg1 :pointer)
  (arg2 :pointer))
(declaim (inline MAKE-MULTI-SPHERE-SHAPE))
(cffi:defcfun ("_wrap_new_btMultiSphereShape"
               MAKE-MULTI-SPHERE-SHAPE) :pointer
  (positions :pointer)
  (radi :pointer)
  (numSpheres :int))
(declaim (inline MULTI-SPHERE-SHAPE/CALCULATE-LOCAL-INERTIA))
(cffi:defcfun ("_wrap_btMultiSphereShape_calculateLocalInertia"
               MULTI-SPHERE-SHAPE/CALCULATE-LOCAL-INERTIA) :void
  (self :pointer)
  (mass :float)
  (inertia :pointer))
(declaim (inline MULTI-SPHERE-SHAPE/LOCAL-GET-SUPPORTING-VERTEX-WITHOUT-MARGIN))
(cffi:defcfun ("_wrap_btMultiSphereShape_localGetSupportingVertexWithoutMargin"
               MULTI-SPHERE-SHAPE/LOCAL-GET-SUPPORTING-VERTEX-WITHOUT-MARGIN) :pointer
  (self :pointer)
  (vec :pointer))
(declaim (inline MULTI-SPHERE-SHAPE/BATCHED-UNIT-VECTOR-GET-SUPPORTING-VERTEX-WITHOUT-MARGIN))
(cffi:defcfun ("_wrap_btMultiSphereShape_batchedUnitVectorGetSupportingVertexWithoutMargin"
               MULTI-SPHERE-SHAPE/BATCHED-UNIT-VECTOR-GET-SUPPORTING-VERTEX-WITHOUT-MARGIN) :void
  (self :pointer)
  (vectors :pointer)
  (supportVerticesOut :pointer)
  (numVectors :int))
(declaim (inline MULTI-SPHERE-SHAPE/GET-SPHERE-COUNT))
(cffi:defcfun ("_wrap_btMultiSphereShape_getSphereCount"
               MULTI-SPHERE-SHAPE/GET-SPHERE-COUNT) :int
  (self :pointer))
(declaim (inline MULTI-SPHERE-SHAPE/GET-SPHERE-POSITION))
(cffi:defcfun ("_wrap_btMultiSphereShape_getSpherePosition"
               MULTI-SPHERE-SHAPE/GET-SPHERE-POSITION) :pointer
  (self :pointer)
  (index :int))
(declaim (inline MULTI-SPHERE-SHAPE/GET-SPHERE-RADIUS))
(cffi:defcfun ("_wrap_btMultiSphereShape_getSphereRadius"
               MULTI-SPHERE-SHAPE/GET-SPHERE-RADIUS) :float
  (self :pointer)
  (index :int))
(declaim (inline MULTI-SPHERE-SHAPE/GET-NAME))
(cffi:defcfun ("_wrap_btMultiSphereShape_getName"
               MULTI-SPHERE-SHAPE/GET-NAME) :string
  (self :pointer))
(declaim (inline MULTI-SPHERE-SHAPE/CALCULATE-SERIALIZE-BUFFER-SIZE))
(cffi:defcfun ("_wrap_btMultiSphereShape_calculateSerializeBufferSize"
               MULTI-SPHERE-SHAPE/CALCULATE-SERIALIZE-BUFFER-SIZE) :int
  (self :pointer))
(declaim (inline MULTI-SPHERE-SHAPE/SERIALIZE))
(cffi:defcfun ("_wrap_btMultiSphereShape_serialize"
               MULTI-SPHERE-SHAPE/SERIALIZE) :string
  (self :pointer)
  (dataBuffer :pointer)
  (serializer :pointer))
(declaim (inline DELETE/BT-MULTI-SPHERE-SHAPE))
(cffi:defcfun ("_wrap_delete_btMultiSphereShape"
               DELETE/BT-MULTI-SPHERE-SHAPE) :void
  (self :pointer))

(declaim (inline UNIFORM-SCALING-SHAPE/MAKE-c++-INSTANCE))
(cffi:defcfun ("_wrap_btUniformScalingShape_makeCPlusPlusInstance__SWIG_0"
               UNIFORM-SCALING-SHAPE/MAKE-c++-INSTANCE) :pointer
  (self :pointer)
  (sizeInBytes :pointer))
(declaim (inline UNIFORM-SCALING-SHAPE/DELETE-c++-INSTANCE))
(cffi:defcfun ("_wrap_btUniformScalingShape_deleteCPlusPlusInstance__SWIG_0"
               UNIFORM-SCALING-SHAPE/DELETE-c++-INSTANCE) :void
  (self :pointer)
  (ptr :pointer))
(declaim (inline UNIFORM-SCALING-SHAPE/MAKE-c++-INSTANCE))
(cffi:defcfun ("_wrap_btUniformScalingShape_makeCPlusPlusInstance__SWIG_1"
               UNIFORM-SCALING-SHAPE/MAKE-c++-INSTANCE/with-arg1&ptr) :pointer
  (self :pointer)
  (arg1 :pointer)
  (ptr :pointer))
(declaim (inline UNIFORM-SCALING-SHAPE/DELETE-c++-INSTANCE))
(cffi:defcfun ("_wrap_btUniformScalingShape_deleteCPlusPlusInstance__SWIG_1"
               UNIFORM-SCALING-SHAPE/DELETE-c++-INSTANCE/with-arg1&2) :void
  (self :pointer)
  (arg1 :pointer)
  (arg2 :pointer))
(declaim (inline UNIFORM-SCALING-SHAPE/MAKE-c++-ARRAY))
(cffi:defcfun ("_wrap_btUniformScalingShape_makeCPlusArray__SWIG_0"
               UNIFORM-SCALING-SHAPE/MAKE-c++-ARRAY) :pointer
  (self :pointer)
  (sizeInBytes :pointer))
(declaim (inline UNIFORM-SCALING-SHAPE/DELETE-c++-ARRAY))
(cffi:defcfun ("_wrap_btUniformScalingShape_deleteCPlusArray__SWIG_0"
               UNIFORM-SCALING-SHAPE/DELETE-c++-ARRAY) :void
  (self :pointer)
  (ptr :pointer))
(declaim (inline UNIFORM-SCALING-SHAPE/MAKE-c++-ARRAY))
(cffi:defcfun ("_wrap_btUniformScalingShape_makeCPlusArray__SWIG_1"
               UNIFORM-SCALING-SHAPE/MAKE-c++-ARRAY/with-arg1&ptr) :pointer
  (self :pointer)
  (arg1 :pointer)
  (ptr :pointer))
(declaim (inline UNIFORM-SCALING-SHAPE/DELETE-c++-ARRAY))
(cffi:defcfun ("_wrap_btUniformScalingShape_deleteCPlusArray__SWIG_1"
               UNIFORM-SCALING-SHAPE/DELETE-c++-ARRAY/with-arg1&2) :void
  (self :pointer)
  (arg1 :pointer)
  (arg2 :pointer))
(declaim (inline MAKE-UNIFORM-SCALING-SHAPE))
(cffi:defcfun ("_wrap_new_btUniformScalingShape"
               MAKE-UNIFORM-SCALING-SHAPE) :pointer
  (convexChildShape :pointer)
  (uniformScalingFactor :float))
(declaim (inline DELETE/BT-UNIFORM-SCALING-SHAPE))
(cffi:defcfun ("_wrap_delete_btUniformScalingShape"
               DELETE/BT-UNIFORM-SCALING-SHAPE) :void
  (self :pointer))
(declaim (inline UNIFORM-SCALING-SHAPE/LOCAL-GET-SUPPORTING-VERTEX-WITHOUT-MARGIN))
(cffi:defcfun ("_wrap_btUniformScalingShape_localGetSupportingVertexWithoutMargin"
               UNIFORM-SCALING-SHAPE/LOCAL-GET-SUPPORTING-VERTEX-WITHOUT-MARGIN) :pointer
  (self :pointer)
  (vec :pointer))
(declaim (inline UNIFORM-SCALING-SHAPE/LOCAL-GET-SUPPORTING-VERTEX))
(cffi:defcfun ("_wrap_btUniformScalingShape_localGetSupportingVertex"
               UNIFORM-SCALING-SHAPE/LOCAL-GET-SUPPORTING-VERTEX) :pointer
  (self :pointer)
  (vec :pointer))
(declaim (inline UNIFORM-SCALING-SHAPE/BATCHED-UNIT-VECTOR-GET-SUPPORTING-VERTEX-WITHOUT-MARGIN))
(cffi:defcfun ("_wrap_btUniformScalingShape_batchedUnitVectorGetSupportingVertexWithoutMargin"
               UNIFORM-SCALING-SHAPE/BATCHED-UNIT-VECTOR-GET-SUPPORTING-VERTEX-WITHOUT-MARGIN) :void
  (self :pointer)
  (vectors :pointer)
  (supportVerticesOut :pointer)
  (numVectors :int))
(declaim (inline UNIFORM-SCALING-SHAPE/CALCULATE-LOCAL-INERTIA))
(cffi:defcfun ("_wrap_btUniformScalingShape_calculateLocalInertia"
               UNIFORM-SCALING-SHAPE/CALCULATE-LOCAL-INERTIA) :void
  (self :pointer)
  (mass :float)
  (inertia :pointer))
(declaim (inline UNIFORM-SCALING-SHAPE/GET-UNIFORM-SCALING-FACTOR))
(cffi:defcfun ("_wrap_btUniformScalingShape_getUniformScalingFactor"
               UNIFORM-SCALING-SHAPE/GET-UNIFORM-SCALING-FACTOR) :float
  (self :pointer))
(declaim (inline UNIFORM-SCALING-SHAPE/GET-CHILD-SHAPE))
(cffi:defcfun ("_wrap_btUniformScalingShape_getChildShape__SWIG_0"
               UNIFORM-SCALING-SHAPE/GET-CHILD-SHAPE) :pointer
  (self :pointer))
#+ (or)
(cffi:defcfun ("_wrap_btUniformScalingShape_getChildShape__SWIG_1"
               UNIFORM-SCALING-SHAPE/GET-CHILD-SHAPE) :pointer
  (self :pointer))
(declaim (inline UNIFORM-SCALING-SHAPE/GET-NAME))
(cffi:defcfun ("_wrap_btUniformScalingShape_getName"
               UNIFORM-SCALING-SHAPE/GET-NAME) :string
  (self :pointer))
(declaim (inline UNIFORM-SCALING-SHAPE/GET-AABB))
(cffi:defcfun ("_wrap_btUniformScalingShape_getAabb"
               UNIFORM-SCALING-SHAPE/GET-AABB) :void
  (self :pointer)
  (t_arg1 :pointer)
  (aabbMin :pointer)
  (aabbMax :pointer))
(declaim (inline UNIFORM-SCALING-SHAPE/GET-AABB-SLOW))
(cffi:defcfun ("_wrap_btUniformScalingShape_getAabbSlow"
               UNIFORM-SCALING-SHAPE/GET-AABB-SLOW) :void
  (self :pointer)
  (t_arg1 :pointer)
  (aabbMin :pointer)
  (aabbMax :pointer))
(declaim (inline UNIFORM-SCALING-SHAPE/SET-LOCAL-SCALING))
(cffi:defcfun ("_wrap_btUniformScalingShape_setLocalScaling"
               UNIFORM-SCALING-SHAPE/SET-LOCAL-SCALING) :void
  (self :pointer)
  (scaling :pointer))
(declaim (inline UNIFORM-SCALING-SHAPE/GET-LOCAL-SCALING))
(cffi:defcfun ("_wrap_btUniformScalingShape_getLocalScaling"
               UNIFORM-SCALING-SHAPE/GET-LOCAL-SCALING) :pointer
  (self :pointer))
(declaim (inline UNIFORM-SCALING-SHAPE/SET-MARGIN))
(cffi:defcfun ("_wrap_btUniformScalingShape_setMargin"
               UNIFORM-SCALING-SHAPE/SET-MARGIN) :void
  (self :pointer)
  (margin :float))
(declaim (inline UNIFORM-SCALING-SHAPE/GET-MARGIN))
(cffi:defcfun ("_wrap_btUniformScalingShape_getMargin"
               UNIFORM-SCALING-SHAPE/GET-MARGIN) :float
  (self :pointer))
(declaim (inline UNIFORM-SCALING-SHAPE/GET-NUM-PREFERRED-PENETRATION-DIRECTIONS))
(cffi:defcfun ("_wrap_btUniformScalingShape_getNumPreferredPenetrationDirections"
               UNIFORM-SCALING-SHAPE/GET-NUM-PREFERRED-PENETRATION-DIRECTIONS) :int
  (self :pointer))
(declaim (inline UNIFORM-SCALING-SHAPE/GET-PREFERRED-PENETRATION-DIRECTION))
(cffi:defcfun ("_wrap_btUniformScalingShape_getPreferredPenetrationDirection"
               UNIFORM-SCALING-SHAPE/GET-PREFERRED-PENETRATION-DIRECTION) :void
  (self :pointer)
  (index :int)
  (penetrationVector :pointer))
(declaim (inline MAKE-SPHERE-SPHERE-COLLISION-ALGORITHM))
(cffi:defcfun ("_wrap_new_btSphereSphereCollisionAlgorithm__SWIG_0"
               MAKE-SPHERE-SPHERE-COLLISION-ALGORITHM/with-mf&ci&cal0&1wrap) :pointer
  (mf :pointer)
  (ci :pointer)
  (col0Wrap :pointer)
  (col1Wrap :pointer))
(declaim (inline MAKE-SPHERE-SPHERE-COLLISION-ALGORITHM))
(cffi:defcfun ("_wrap_new_btSphereSphereCollisionAlgorithm__SWIG_1"
               MAKE-SPHERE-SPHERE-COLLISION-ALGORITHM/with-ci) :pointer
  (ci :pointer))
(declaim (inline SPHERE-SPHERE-COLLISION-ALGORITHM/PROCESS-COLLISION))
(cffi:defcfun ("_wrap_btSphereSphereCollisionAlgorithm_processCollision"
               SPHERE-SPHERE-COLLISION-ALGORITHM/PROCESS-COLLISION) :void
  (self :pointer)
  (body0Wrap :pointer)
  (body1Wrap :pointer)
  (dispatchInfo :pointer)
  (resultOut :pointer))
(declaim (inline SPHERE-SPHERE-COLLISION-ALGORITHM/CALCULATE-TIME-OF-IMPACT))
(cffi:defcfun ("_wrap_btSphereSphereCollisionAlgorithm_calculateTimeOfImpact"
               SPHERE-SPHERE-COLLISION-ALGORITHM/CALCULATE-TIME-OF-IMPACT) :float
  (self :pointer)
  (body0 :pointer)
  (body1 :pointer)
  (dispatchInfo :pointer)
  (resultOut :pointer))
(declaim (inline SPHERE-SPHERE-COLLISION-ALGORITHM/GET-ALL-CONTACT-MANIFOLDS))
(cffi:defcfun ("_wrap_btSphereSphereCollisionAlgorithm_getAllContactManifolds"
               SPHERE-SPHERE-COLLISION-ALGORITHM/GET-ALL-CONTACT-MANIFOLDS) :void
  (self :pointer)
  (manifoldArray :pointer))
(declaim (inline DELETE/BT-SPHERE-SPHERE-COLLISION-ALGORITHM))
(cffi:defcfun ("_wrap_delete_btSphereSphereCollisionAlgorithm"
               DELETE/BT-SPHERE-SPHERE-COLLISION-ALGORITHM) :void
  (self :pointer))

(declaim (inline MAKE-DEFAULT-COLLISION-CONFIGURATION))
(cffi:defcfun ("_wrap_new_btDefaultCollisionConfiguration__SWIG_0"
               MAKE-DEFAULT-COLLISION-CONFIGURATION/with-construction-info) :pointer
  (constructionInfo :pointer))
(declaim (inline MAKE-DEFAULT-COLLISION-CONFIGURATION))
(cffi:defcfun ("_wrap_new_btDefaultCollisionConfiguration__SWIG_1"
               MAKE-DEFAULT-COLLISION-CONFIGURATION) :pointer)
(declaim (inline DELETE/BT-DEFAULT-COLLISION-CONFIGURATION))
(cffi:defcfun ("_wrap_delete_btDefaultCollisionConfiguration"
               DELETE/BT-DEFAULT-COLLISION-CONFIGURATION) :void
  (self :pointer))
(declaim (inline DEFAULT-COLLISION-CONFIGURATION/GET-PERSISTENT-MANIFOLD-POOL))
(cffi:defcfun ("_wrap_btDefaultCollisionConfiguration_getPersistentManifoldPool"
               DEFAULT-COLLISION-CONFIGURATION/GET-PERSISTENT-MANIFOLD-POOL) :pointer
  (self :pointer))
(declaim (inline DEFAULT-COLLISION-CONFIGURATION/GET-COLLISION-ALGORITHM-POOL))
(cffi:defcfun ("_wrap_btDefaultCollisionConfiguration_getCollisionAlgorithmPool"
               DEFAULT-COLLISION-CONFIGURATION/GET-COLLISION-ALGORITHM-POOL) :pointer
  (self :pointer))
(declaim (inline DEFAULT-COLLISION-CONFIGURATION/GET-SIMPLEX-SOLVER))
(cffi:defcfun ("_wrap_btDefaultCollisionConfiguration_getSimplexSolver"
               DEFAULT-COLLISION-CONFIGURATION/GET-SIMPLEX-SOLVER) :pointer
  (self :pointer))
(declaim (inline DEFAULT-COLLISION-CONFIGURATION/GET-COLLISION-ALGORITHM-CREATE-FUNC))
(cffi:defcfun ("_wrap_btDefaultCollisionConfiguration_getCollisionAlgorithmCreateFunc"
               DEFAULT-COLLISION-CONFIGURATION/GET-COLLISION-ALGORITHM-CREATE-FUNC) :pointer
  (self :pointer)
  (proxyType0 :int)
  (proxyType1 :int))
(declaim (inline DEFAULT-COLLISION-CONFIGURATION/SET-CONVEX-CONVEX-MULTIPOINT-ITERATIONS))
(cffi:defcfun ("_wrap_btDefaultCollisionConfiguration_setConvexConvexMultipointIterations__SWIG_0"
               DEFAULT-COLLISION-CONFIGURATION/SET-CONVEX-CONVEX-MULTIPOINT-ITERATIONS/with-num&max)
    :void
  (self :pointer)
  (numPerturbationIterations :int)
  (minimumPointsPerturbationThreshold :int))
(declaim (inline DEFAULT-COLLISION-CONFIGURATION/SET-CONVEX-CONVEX-MULTIPOINT-ITERATIONS))
(cffi:defcfun ("_wrap_btDefaultCollisionConfiguration_setConvexConvexMultipointIterations__SWIG_1"
               DEFAULT-COLLISION-CONFIGURATION/SET-CONVEX-CONVEX-MULTIPOINT-ITERATIONS/with-num)
    :void
  (self :pointer)
  (numPerturbationIterations :int))
(declaim (inline DEFAULT-COLLISION-CONFIGURATION/SET-CONVEX-CONVEX-MULTIPOINT-ITERATIONS))
(cffi:defcfun ("_wrap_btDefaultCollisionConfiguration_setConvexConvexMultipointIterations__SWIG_2"
               DEFAULT-COLLISION-CONFIGURATION/SET-CONVEX-CONVEX-MULTIPOINT-ITERATIONS) :void
  (self :pointer))
(declaim (inline DEFAULT-COLLISION-CONFIGURATION/SET-PLANE-CONVEX-MULTIPOINT-ITERATIONS))
(cffi:defcfun ("_wrap_btDefaultCollisionConfiguration_setPlaneConvexMultipointIterations__SWIG_0"
               DEFAULT-COLLISION-CONFIGURATION/SET-PLANE-CONVEX-MULTIPOINT-ITERATIONS/with-num&min)
    :void
  (self :pointer)
  (numPerturbationIterations :int)
  (minimumPointsPerturbationThreshold :int))
(declaim (inline DEFAULT-COLLISION-CONFIGURATION/SET-PLANE-CONVEX-MULTIPOINT-ITERATIONS))
(cffi:defcfun ("_wrap_btDefaultCollisionConfiguration_setPlaneConvexMultipointIterations__SWIG_1"
               DEFAULT-COLLISION-CONFIGURATION/SET-PLANE-CONVEX-MULTIPOINT-ITERATIONS/with-num)
    :void
  (self :pointer)
  (numPerturbationIterations :int))
(declaim (inline DEFAULT-COLLISION-CONFIGURATION/SET-PLANE-CONVEX-MULTIPOINT-ITERATIONS))
(cffi:defcfun ("_wrap_btDefaultCollisionConfiguration_setPlaneConvexMultipointIterations__SWIG_2"
               DEFAULT-COLLISION-CONFIGURATION/SET-PLANE-CONVEX-MULTIPOINT-ITERATIONS) :void
  (self :pointer))
(define-constant +USE-DISPATCH-REGISTRY-ARRAY+ 1)
(cffi:defcenum DISPATCHER-FLAGS
  (:CD-STATIC-STATIC-REPORTED 1)
  (:CD-USE-RELATIVE-CONTACT-BREAKING-THRESHOLD 2)
  (:CD-DISABLE-CONTACTPOOL-DYNAMIC-ALLOCATION 4))
(declaim (inline COLLISION-DISPATCHER/GET-DISPATCHER-FLAGS))
(cffi:defcfun ("_wrap_btCollisionDispatcher_getDispatcherFlags"
               COLLISION-DISPATCHER/GET-DISPATCHER-FLAGS) :int
  (self :pointer))
(declaim (inline COLLISION-DISPATCHER/SET-DISPATCHER-FLAGS))
(cffi:defcfun ("_wrap_btCollisionDispatcher_setDispatcherFlags"
               COLLISION-DISPATCHER/SET-DISPATCHER-FLAGS) :void
  (self :pointer)
  (flags :int))
(declaim (inline COLLISION-DISPATCHER/REGISTER-COLLISION-CREATE-FUNC))
(cffi:defcfun ("_wrap_btCollisionDispatcher_registerCollisionCreateFunc"
               COLLISION-DISPATCHER/REGISTER-COLLISION-CREATE-FUNC) :void
  (self :pointer)
  (proxyType0 :int)
  (proxyType1 :int)
  (createFunc :pointer))
(declaim (inline COLLISION-DISPATCHER/GET-NUM-MANIFOLDS))
(cffi:defcfun ("_wrap_btCollisionDispatcher_getNumManifolds"
               COLLISION-DISPATCHER/GET-NUM-MANIFOLDS) :int
  (self :pointer))
(declaim (inline COLLISION-DISPATCHER/GET-INTERNAL-MANIFOLD-POINTER))
(cffi:defcfun ("_wrap_btCollisionDispatcher_getInternalManifoldPointer"
               COLLISION-DISPATCHER/GET-INTERNAL-MANIFOLD-POINTER) :pointer
  (self :pointer))
(declaim (inline COLLISION-DISPATCHER/GET-MANIFOLD-BY-INDEX-INTERNAL))
(cffi:defcfun ("_wrap_btCollisionDispatcher_getManifoldByIndexInternal__SWIG_0"
               COLLISION-DISPATCHER/GET-MANIFOLD-BY-INDEX-INTERNAL) :pointer
  (self :pointer)
  (index :int))
#+ (or)
(cffi:defcfun ("_wrap_btCollisionDispatcher_getManifoldByIndexInternal__SWIG_1"
               COLLISION-DISPATCHER/GET-MANIFOLD-BY-INDEX-INTERNAL) :pointer
  (self :pointer)
  (index :int))
(declaim (inline MAKE-COLLISION-DISPATCHER))
(cffi:defcfun ("_wrap_new_btCollisionDispatcher"
               MAKE-COLLISION-DISPATCHER) :pointer
  (collisionConfiguration :pointer))
(declaim (inline DELETE/BT-COLLISION-DISPATCHER))
(cffi:defcfun ("_wrap_delete_btCollisionDispatcher"
               DELETE/BT-COLLISION-DISPATCHER) :void
  (self :pointer))
(declaim (inline COLLISION-DISPATCHER/GET-NEW-MANIFOLD))
(cffi:defcfun ("_wrap_btCollisionDispatcher_getNewManifold"
               COLLISION-DISPATCHER/GET-NEW-MANIFOLD) :pointer
  (self :pointer)
  (b0 :pointer)
  (b1 :pointer))
(declaim (inline COLLISION-DISPATCHER/RELEASE-MANIFOLD))
(cffi:defcfun ("_wrap_btCollisionDispatcher_releaseManifold"
               COLLISION-DISPATCHER/RELEASE-MANIFOLD) :void
  (self :pointer)
  (manifold :pointer))
(declaim (inline COLLISION-DISPATCHER/CLEAR-MANIFOLD))
(cffi:defcfun ("_wrap_btCollisionDispatcher_clearManifold"
               COLLISION-DISPATCHER/CLEAR-MANIFOLD) :void
  (self :pointer)
  (manifold :pointer))
(declaim (inline COLLISION-DISPATCHER/FIND-ALGORITHM))
(cffi:defcfun ("_wrap_btCollisionDispatcher_findAlgorithm__SWIG_0"
               COLLISION-DISPATCHER/FIND-ALGORITHM/with-body0&1wrap&shared-manifold) :pointer
  (self :pointer)
  (body0Wrap :pointer)
  (body1Wrap :pointer)
  (sharedManifold :pointer))
(declaim (inline COLLISION-DISPATCHER/FIND-ALGORITHM))
(cffi:defcfun ("_wrap_btCollisionDispatcher_findAlgorithm__SWIG_1"
               COLLISION-DISPATCHER/FIND-ALGORITHM/with-body0&1wrap) :pointer
  (self :pointer)
  (body0Wrap :pointer)
  (body1Wrap :pointer))
(declaim (inline COLLISION-DISPATCHER/NEEDS-COLLISION))
(cffi:defcfun ("_wrap_btCollisionDispatcher_needsCollision"
               COLLISION-DISPATCHER/NEEDS-COLLISION) :pointer
  (self :pointer)
  (body0 :pointer)
  (body1 :pointer))
(declaim (inline COLLISION-DISPATCHER/NEEDS-RESPONSE))
(cffi:defcfun ("_wrap_btCollisionDispatcher_needsResponse"
               COLLISION-DISPATCHER/NEEDS-RESPONSE) :pointer
  (self :pointer)
  (body0 :pointer)
  (body1 :pointer))
(declaim (inline COLLISION-DISPATCHER/DISPATCH-ALL-COLLISION-PAIRS))
(cffi:defcfun ("_wrap_btCollisionDispatcher_dispatchAllCollisionPairs"
               COLLISION-DISPATCHER/DISPATCH-ALL-COLLISION-PAIRS) :void
  (self :pointer)
  (pairCache :pointer)
  (dispatchInfo :pointer)
  (dispatcher :pointer))
(declaim (inline COLLISION-DISPATCHER/SET-NEAR-CALLBACK))
(cffi:defcfun ("_wrap_btCollisionDispatcher_setNearCallback"
               COLLISION-DISPATCHER/SET-NEAR-CALLBACK) :void
  (self :pointer)
  (nearCallback :pointer))
(declaim (inline COLLISION-DISPATCHER/GET-NEAR-CALLBACK))
(cffi:defcfun ("_wrap_btCollisionDispatcher_getNearCallback"
               COLLISION-DISPATCHER/GET-NEAR-CALLBACK) :pointer
  (self :pointer))
(declaim (inline COLLISION-DISPATCHER/DEFAULT-NEAR-CALLBACK))
(cffi:defcfun ("_wrap_btCollisionDispatcher_defaultNearCallback"
               COLLISION-DISPATCHER/DEFAULT-NEAR-CALLBACK) :void
  (collisionPair :pointer)
  (dispatcher :pointer)
  (dispatchInfo :pointer))
(declaim (inline COLLISION-DISPATCHER/ALLOCATE-COLLISION-ALGORITHM))
(cffi:defcfun ("_wrap_btCollisionDispatcher_allocateCollisionAlgorithm"
               COLLISION-DISPATCHER/ALLOCATE-COLLISION-ALGORITHM) :pointer
  (self :pointer)
  (size :int))
(declaim (inline COLLISION-DISPATCHER/FREE-COLLISION-ALGORITHM))
(cffi:defcfun ("_wrap_btCollisionDispatcher_freeCollisionAlgorithm"
               COLLISION-DISPATCHER/FREE-COLLISION-ALGORITHM) :void
  (self :pointer)
  (ptr :pointer))
(declaim (inline COLLISION-DISPATCHER/GET-COLLISION-CONFIGURATION))
(cffi:defcfun ("_wrap_btCollisionDispatcher_getCollisionConfiguration__SWIG_0"
               COLLISION-DISPATCHER/GET-COLLISION-CONFIGURATION) :pointer
  (self :pointer))
#+ (or)
(cffi:defcfun ("_wrap_btCollisionDispatcher_getCollisionConfiguration__SWIG_1"
               COLLISION-DISPATCHER/GET-COLLISION-CONFIGURATION) :pointer
  (self :pointer))
(declaim (inline COLLISION-DISPATCHER/SET-COLLISION-CONFIGURATION))
(cffi:defcfun ("_wrap_btCollisionDispatcher_setCollisionConfiguration"
               COLLISION-DISPATCHER/SET-COLLISION-CONFIGURATION) :void
  (self :pointer)
  (config :pointer))
(declaim (inline COLLISION-DISPATCHER/GET-INTERNAL-MANIFOLD-POOL))
(cffi:defcfun ("_wrap_btCollisionDispatcher_getInternalManifoldPool__SWIG_0"
               COLLISION-DISPATCHER/GET-INTERNAL-MANIFOLD-POOL) :pointer
  (self :pointer))
#+ (or)
(cffi:defcfun ("_wrap_btCollisionDispatcher_getInternalManifoldPool__SWIG_1"
               COLLISION-DISPATCHER/GET-INTERNAL-MANIFOLD-POOL) :pointer
  (self :pointer))

(declaim (inline MAKE-SIMPLE-BROADPHASE))
(cffi:defcfun ("_wrap_new_btSimpleBroadphase__SWIG_0"
               MAKE-SIMPLE-BROADPHASE/with-max-proxies&overlapping-pair-cache) :pointer
  (maxProxies :int)
  (overlappingPairCache :pointer))

(cffi:defcfun ("_wrap_new_btSimpleBroadphase__SWIG_1"
               MAKE-SIMPLE-BROADPHASE/with-max-proxies) :pointer
  (maxProxies :int))

(cffi:defcfun ("_wrap_new_btSimpleBroadphase__SWIG_2"
               MAKE-SIMPLE-BROADPHASE) :pointer)
(declaim (inline DELETE/BT-SIMPLE-BROADPHASE))
(cffi:defcfun ("_wrap_delete_btSimpleBroadphase"
               DELETE/BT-SIMPLE-BROADPHASE) :void
  (self :pointer))
(declaim (inline SIMPLE-BROADPHASE/AABB-OVERLAP))
(cffi:defcfun ("_wrap_btSimpleBroadphase_aabbOverlap"
               SIMPLE-BROADPHASE/AABB-OVERLAP) :pointer
  (proxy0 :pointer)
  (proxy1 :pointer))
(declaim (inline SIMPLE-BROADPHASE/CREATE-PROXY))
(cffi:defcfun ("_wrap_btSimpleBroadphase_createProxy"
               SIMPLE-BROADPHASE/CREATE-PROXY) :pointer
  (self :pointer)
  (aabbMin :pointer)
  (aabbMax :pointer)
  (shapeType :int)
  (userPtr :pointer)
  (collisionFilterGroup :short)
  (collisionFilterMask :short)
  (dispatcher :pointer)
  (multiSapProxy :pointer))
(declaim (inline SIMPLE-BROADPHASE/CALCULATE-OVERLAPPING-PAIRS))
(cffi:defcfun ("_wrap_btSimpleBroadphase_calculateOverlappingPairs"
               SIMPLE-BROADPHASE/CALCULATE-OVERLAPPING-PAIRS) :void
  (self :pointer)
  (dispatcher :pointer))
(declaim (inline SIMPLE-BROADPHASE/DESTROY-PROXY))
(cffi:defcfun ("_wrap_btSimpleBroadphase_destroyProxy"
               SIMPLE-BROADPHASE/DESTROY-PROXY) :void
  (self :pointer)
  (proxy :pointer)
  (dispatcher :pointer))
(declaim (inline SIMPLE-BROADPHASE/SET-AABB))
(cffi:defcfun ("_wrap_btSimpleBroadphase_setAabb"
               SIMPLE-BROADPHASE/SET-AABB) :void
  (self :pointer)
  (proxy :pointer)
  (aabbMin :pointer)
  (aabbMax :pointer)
  (dispatcher :pointer))
(declaim (inline SIMPLE-BROADPHASE/GET-AABB))
(cffi:defcfun ("_wrap_btSimpleBroadphase_getAabb"
               SIMPLE-BROADPHASE/GET-AABB) :void
  (self :pointer)
  (proxy :pointer)
  (aabbMin :pointer)
  (aabbMax :pointer))
(declaim (inline SIMPLE-BROADPHASE/RAY-TEST))
(cffi:defcfun ("_wrap_btSimpleBroadphase_rayTest__SWIG_0"
               SIMPLE-BROADPHASE/RAY-TEST/with-ray-from&to&callback&aabb-min&max) :void
  (self :pointer)
  (rayFrom :pointer)
  (rayTo :pointer)
  (rayCallback :pointer)
  (aabbMin :pointer)
  (aabbMax :pointer))
(declaim (inline SIMPLE-BROADPHASE/RAY-TEST))
(cffi:defcfun ("_wrap_btSimpleBroadphase_rayTest__SWIG_1"
               SIMPLE-BROADPHASE/RAY-TEST/with-ray-from&to&callback&aabb-min) :void
  (self :pointer)
  (rayFrom :pointer)
  (rayTo :pointer)
  (rayCallback :pointer)
  (aabbMin :pointer))
(declaim (inline SIMPLE-BROADPHASE/RAY-TEST))
(cffi:defcfun ("_wrap_btSimpleBroadphase_rayTest__SWIG_2"
               SIMPLE-BROADPHASE/RAY-TEST/with-ray-from&to&callback) :void
  (self :pointer)
  (rayFrom :pointer)
  (rayTo :pointer)
  (rayCallback :pointer))
(declaim (inline SIMPLE-BROADPHASE/AABB-TEST))
(cffi:defcfun ("_wrap_btSimpleBroadphase_aabbTest"
               SIMPLE-BROADPHASE/AABB-TEST/with-aabb-min&max&callback) :void
  (self :pointer)
  (aabbMin :pointer)
  (aabbMax :pointer)
  (callback :pointer))
(declaim (inline SIMPLE-BROADPHASE/GET-OVERLAPPING-PAIR-CACHE))
(cffi:defcfun ("_wrap_btSimpleBroadphase_getOverlappingPairCache__SWIG_0"
               SIMPLE-BROADPHASE/GET-OVERLAPPING-PAIR-CACHE) :pointer
  (self :pointer))
#+ (or)
(cffi:defcfun ("_wrap_btSimpleBroadphase_getOverlappingPairCache__SWIG_1"
               SIMPLE-BROADPHASE/GET-OVERLAPPING-PAIR-CACHE) :pointer
  (self :pointer))
(declaim (inline SIMPLE-BROADPHASE/TEST-AABB-OVERLAP))
(cffi:defcfun ("_wrap_btSimpleBroadphase_testAabbOverlap"
               SIMPLE-BROADPHASE/TEST-AABB-OVERLAP) :pointer
  (self :pointer)
  (proxy0 :pointer)
  (proxy1 :pointer))
(declaim (inline SIMPLE-BROADPHASE/GET-BROADPHASE-AABB))
(cffi:defcfun ("_wrap_btSimpleBroadphase_getBroadphaseAabb"
               SIMPLE-BROADPHASE/GET-BROADPHASE-AABB) :void
  (self :pointer)
  (aabbMin :pointer)
  (aabbMax :pointer))
(declaim (inline SIMPLE-BROADPHASE/PRINT-STATS))
(cffi:defcfun ("_wrap_btSimpleBroadphase_printStats"
               SIMPLE-BROADPHASE/PRINT-STATS) :void
  (self :pointer))
(define-constant +USE-OVERLAP-TEST-ON-REMOVES+ 1)
(cffi:defcvar ("gOverlappingPairs"
               *OVERLAPPING-PAIRS*)
    :int)
(declaim (inline MAKE-AXIS-SWEEP-3))
(cffi:defcfun ("_wrap_new_btAxisSweep3__SWIG_0"
               MAKE-AXIS-SWEEP-3/with-world-aabb-min&max&max-handles&pair-cache&d.r.a.) :pointer
  (worldAabbMin :pointer)
  (worldAabbMax :pointer)
  (maxHandles :unsigned-short)
  (pairCache :pointer)
  (disableRaycastAccelerator :pointer))
(declaim (inline MAKE-AXIS-SWEEP-3))
(cffi:defcfun ("_wrap_new_btAxisSweep3__SWIG_1"
               MAKE-AXIS-SWEEP-3/with-world-aabb-min&max&max-handles&pair-cache) :pointer
  (worldAabbMin :pointer)
  (worldAabbMax :pointer)
  (maxHandles :unsigned-short)
  (pairCache :pointer))
(declaim (inline MAKE-AXIS-SWEEP-3))
(cffi:defcfun ("_wrap_new_btAxisSweep3__SWIG_2"
               MAKE-AXIS-SWEEP-3/with-world-aabb-min&max&max-handles) :pointer
  (worldAabbMin :pointer)
  (worldAabbMax :pointer)
  (maxHandles :unsigned-short))
(declaim (inline MAKE-AXIS-SWEEP-3))
(cffi:defcfun ("_wrap_new_btAxisSweep3__SWIG_3"
               MAKE-AXIS-SWEEP-3/with-world-aabb-min&max) :pointer
  (worldAabbMin :pointer)
  (worldAabbMax :pointer))
(declaim (inline DELETE/BT-AXIS-SWEEP-3))
(cffi:defcfun ("_wrap_delete_btAxisSweep3"
               DELETE/BT-AXIS-SWEEP-3) :void
  (self :pointer))
(declaim (inline MAKE-32-BIT-AXIS-SWEEP-3))
(cffi:defcfun ("_wrap_new_bt32BitAxisSweep3__SWIG_0"
               MAKE-32-BIT-AXIS-SWEEP-3/with-world-aabb-min&max&max-handles&pair-cache&d.r.a.)
    :pointer
  (worldAabbMin :pointer)
  (worldAabbMax :pointer)
  (maxHandles :unsigned-int)
  (pairCache :pointer)
  (disableRaycastAccelerator :pointer))
(declaim (inline MAKE-32-BIT-AXIS-SWEEP-3))
(cffi:defcfun ("_wrap_new_bt32BitAxisSweep3__SWIG_1"
               MAKE-32-BIT-AXIS-SWEEP-3/with-world-aabb-min&max&max-handles&pair-cache)
    :pointer
  (worldAabbMin :pointer)
  (worldAabbMax :pointer)
  (maxHandles :unsigned-int)
  (pairCache :pointer))
(declaim (inline MAKE-32-BIT-AXIS-SWEEP-3))
(cffi:defcfun ("_wrap_new_bt32BitAxisSweep3__SWIG_2"
               MAKE-32-BIT-AXIS-SWEEP-3/with-world-aabb-min&max&max-handles) :pointer
  (worldAabbMin :pointer)
  (worldAabbMax :pointer)
  (maxHandles :unsigned-int))
(declaim (inline MAKE-32-BIT-AXIS-SWEEP-3))
(cffi:defcfun ("_wrap_new_bt32BitAxisSweep3__SWIG_3"
               MAKE-32-BIT-AXIS-SWEEP-3/with-world-aabb-min&max) :pointer
  (worldAabbMin :pointer)
  (worldAabbMax :pointer))
(declaim (inline DELETE/BT-32-BIT-AXIS-SWEEP-3))
(cffi:defcfun ("_wrap_delete_bt32BitAxisSweep3"
               DELETE/BT-32-BIT-AXIS-SWEEP-3) :void
  (self :pointer))
(declaim (inline MULTI-SAP-BROADPHASE/GET-BROADPHASE-ARRAY))
(cffi:defcfun ("_wrap_btMultiSapBroadphase_getBroadphaseArray__SWIG_0"
               MULTI-SAP-BROADPHASE/GET-BROADPHASE-ARRAY) :pointer
  (self :pointer))
#+ (or)
(cffi:defcfun ("_wrap_btMultiSapBroadphase_getBroadphaseArray__SWIG_1"
               MULTI-SAP-BROADPHASE/GET-BROADPHASE-ARRAY) :pointer
  (self :pointer))
(declaim (inline DELETE/BT-MULTI-SAP-BROADPHASE))
(cffi:defcfun ("_wrap_delete_btMultiSapBroadphase"
               DELETE/BT-MULTI-SAP-BROADPHASE) :void
  (self :pointer))
(declaim (inline MULTI-SAP-BROADPHASE/CREATE-PROXY))
(cffi:defcfun ("_wrap_btMultiSapBroadphase_createProxy"
               MULTI-SAP-BROADPHASE/CREATE-PROXY) :pointer
  (self :pointer)
  (aabbMin :pointer)
  (aabbMax :pointer)
  (shapeType :int)
  (userPtr :pointer)
  (collisionFilterGroup :short)
  (collisionFilterMask :short)
  (dispatcher :pointer)
  (multiSapProxy :pointer))
(declaim (inline MULTI-SAP-BROADPHASE/DESTROY-PROXY))
(cffi:defcfun ("_wrap_btMultiSapBroadphase_destroyProxy"
               MULTI-SAP-BROADPHASE/DESTROY-PROXY) :void
  (self :pointer)
  (proxy :pointer)
  (dispatcher :pointer))
(declaim (inline MULTI-SAP-BROADPHASE/SET-AABB))
(cffi:defcfun ("_wrap_btMultiSapBroadphase_setAabb"
               MULTI-SAP-BROADPHASE/SET-AABB) :void
  (self :pointer)
  (proxy :pointer)
  (aabbMin :pointer)
  (aabbMax :pointer)
  (dispatcher :pointer))
(declaim (inline MULTI-SAP-BROADPHASE/GET-AABB))
(cffi:defcfun ("_wrap_btMultiSapBroadphase_getAabb"
               MULTI-SAP-BROADPHASE/GET-AABB) :void
  (self :pointer)
  (proxy :pointer)
  (aabbMin :pointer)
  (aabbMax :pointer))
(declaim (inline MULTI-SAP-BROADPHASE/RAY-TEST))
(cffi:defcfun ("_wrap_btMultiSapBroadphase_rayTest__SWIG_0"
               MULTI-SAP-BROADPHASE/RAY-TEST/with-ray-from&to&callback&aabb-min&max) :void
  (self :pointer)
  (rayFrom :pointer)
  (rayTo :pointer)
  (rayCallback :pointer)
  (aabbMin :pointer)
  (aabbMax :pointer))
(declaim (inline MULTI-SAP-BROADPHASE/RAY-TEST))
(cffi:defcfun ("_wrap_btMultiSapBroadphase_rayTest__SWIG_1"
               MULTI-SAP-BROADPHASE/RAY-TEST/with-ray-from&to&callback&aabb-min) :void
  (self :pointer)
  (rayFrom :pointer)
  (rayTo :pointer)
  (rayCallback :pointer)
  (aabbMin :pointer))
(declaim (inline MULTI-SAP-BROADPHASE/RAY-TEST))
(cffi:defcfun ("_wrap_btMultiSapBroadphase_rayTest__SWIG_2"
               MULTI-SAP-BROADPHASE/RAY-TEST/with-ray-from&to&callback) :void
  (self :pointer)
  (rayFrom :pointer)
  (rayTo :pointer)
  (rayCallback :pointer))
(declaim (inline MULTI-SAP-BROADPHASE/ADD-TO-CHILD-BROADPHASE))
(cffi:defcfun ("_wrap_btMultiSapBroadphase_addToChildBroadphase"
               MULTI-SAP-BROADPHASE/ADD-TO-CHILD-BROADPHASE) :void
  (self :pointer)
  (parentMultiSapProxy :pointer)
  (childProxy :pointer)
  (childBroadphase :pointer))
(declaim (inline MULTI-SAP-BROADPHASE/CALCULATE-OVERLAPPING-PAIRS))
(cffi:defcfun ("_wrap_btMultiSapBroadphase_calculateOverlappingPairs"
               MULTI-SAP-BROADPHASE/CALCULATE-OVERLAPPING-PAIRS) :void
  (self :pointer)
  (dispatcher :pointer))
(declaim (inline MULTI-SAP-BROADPHASE/TEST-AABB-OVERLAP))
(cffi:defcfun ("_wrap_btMultiSapBroadphase_testAabbOverlap"
               MULTI-SAP-BROADPHASE/TEST-AABB-OVERLAP) :pointer
  (self :pointer)
  (proxy0 :pointer)
  (proxy1 :pointer))
(declaim (inline MULTI-SAP-BROADPHASE/GET-OVERLAPPING-PAIR-CACHE))
(cffi:defcfun ("_wrap_btMultiSapBroadphase_getOverlappingPairCache__SWIG_0"
               MULTI-SAP-BROADPHASE/GET-OVERLAPPING-PAIR-CACHE) :pointer
  (self :pointer))
#+ (or)
(cffi:defcfun ("_wrap_btMultiSapBroadphase_getOverlappingPairCache__SWIG_1"
               MULTI-SAP-BROADPHASE/GET-OVERLAPPING-PAIR-CACHE) :pointer
  (self :pointer))
(declaim (inline MULTI-SAP-BROADPHASE/GET-BROADPHASE-AABB))
(cffi:defcfun ("_wrap_btMultiSapBroadphase_getBroadphaseAabb"
               MULTI-SAP-BROADPHASE/GET-BROADPHASE-AABB) :void
  (self :pointer)
  (aabbMin :pointer)
  (aabbMax :pointer))
(declaim (inline MULTI-SAP-BROADPHASE/BUILD-TREE))
(cffi:defcfun ("_wrap_btMultiSapBroadphase_buildTree"
               MULTI-SAP-BROADPHASE/BUILD-TREE) :void
  (self :pointer)
  (bvhAabbMin :pointer)
  (bvhAabbMax :pointer))
(declaim (inline MULTI-SAP-BROADPHASE/PRINT-STATS))
(cffi:defcfun ("_wrap_btMultiSapBroadphase_printStats"
               MULTI-SAP-BROADPHASE/PRINT-STATS) :void
  (self :pointer))
(declaim (inline MULTI-SAP-BROADPHASE/QUICKSORT))
(cffi:defcfun ("_wrap_btMultiSapBroadphase_quicksort"
               MULTI-SAP-BROADPHASE/QUICKSORT) :void
  (self :pointer)
  (a :pointer)
  (lo :int)
  (hi :int))
(declaim (inline MULTI-SAP-BROADPHASE/RESET-POOL))
(cffi:defcfun ("_wrap_btMultiSapBroadphase_resetPool"
               MULTI-SAP-BROADPHASE/RESET-POOL) :void
  (self :pointer)
  (dispatcher :pointer))
(define-constant +DBVT-BP-PROFILE+ 0)
(define-constant +DBVT-BP-PREVENTFALSEUPDATE+ 0)
(define-constant +DBVT-BP-ACCURATESLEEPING+ 0)
(define-constant +DBVT-BP-ENABLE-BENCHMARK+ 0)


(define-constant +USE-BT-CLOCK+ 1)
(declaim (inline MAKE-CLOCK))
(cffi:defcfun ("_wrap_new_btClock__SWIG_0"
               MAKE-CLOCK) :pointer)
(declaim (inline MAKE-CLOCK))
(cffi:defcfun ("_wrap_new_btClock__SWIG_1"
               MAKE-CLOCK/with-other) :pointer
  (other :pointer))
(declaim (inline CLOCK/ASSIGN-VALUE))
(cffi:defcfun ("_wrap_btClock_assignValue"
               cLOCK/ASSIGN-VALUE) :pointer
  (self :pointer)
  (other :pointer))
(declaim (inline DELETE/BT-CLOCK))
(cffi:defcfun ("_wrap_delete_btClock"
               DELETE/BT-CLOCK) :void
  (self :pointer))
(declaim (inline CLOCK/RESET))
(cffi:defcfun ("_wrap_btClock_reset"
               cLOCK/RESET) :void
  (self :pointer))
(declaim (inline CLOCK/GET-TIME-MILLISECONDS))
(cffi:defcfun ("_wrap_btClock_getTimeMilliseconds"
               cLOCK/GET-TIME-MILLISECONDS) :unsigned-long
  (self :pointer))
(declaim (inline CLOCK/GET-TIME-MICROSECONDS))
(cffi:defcfun ("_wrap_btClock_getTimeMicroseconds"
               cLOCK/GET-TIME-MICROSECONDS) :unsigned-long
  (self :pointer))
(declaim (inline MAKE-CPROFILE-NODE))
(cffi:defcfun ("_wrap_new_CProfileNode"
               MAKE-CPROFILE-NODE) :pointer
  (name :string)
  (parent :pointer))
(declaim (inline DELETE/CPROFILE-NODE))
(cffi:defcfun ("_wrap_delete_CProfileNode"
               DELETE/CPROFILE-NODE) :void
  (self :pointer))
(declaim (inline CPROFILE-NODE/GET/SUB/NODE))
(cffi:defcfun ("_wrap_CProfileNode_Get_Sub_Node"
               cPROFILE-NODE/GET/SUB/NODE) :pointer
  (self :pointer)
  (name :string))
(declaim (inline CPROFILE-NODE/GET/PARENT))
(cffi:defcfun ("_wrap_CProfileNode_Get_Parent"
               cPROFILE-NODE/GET/PARENT) :pointer
  (self :pointer))
(declaim (inline CPROFILE-NODE/GET/SIBLING))
(cffi:defcfun ("_wrap_CProfileNode_Get_Sibling"
               cPROFILE-NODE/GET/SIBLING) :pointer
  (self :pointer))
(declaim (inline CPROFILE-NODE/GET/CHILD))
(cffi:defcfun ("_wrap_CProfileNode_Get_Child"
               cPROFILE-NODE/GET/CHILD) :pointer
  (self :pointer))
(declaim (inline CPROFILE-NODE/CLEANUP-MEMORY))
(cffi:defcfun ("_wrap_CProfileNode_CleanupMemory"
               cPROFILE-NODE/CLEANUP-MEMORY) :void
  (self :pointer))
(declaim (inline CPROFILE-NODE/RESET))
(cffi:defcfun ("_wrap_CProfileNode_Reset"
               cPROFILE-NODE/RESET) :void
  (self :pointer))
(declaim (inline CPROFILE-NODE/CALL))
(cffi:defcfun ("_wrap_CProfileNode_Call"
               cPROFILE-NODE/CALL) :void
  (self :pointer))
(declaim (inline CPROFILE-NODE/RETURN))
(cffi:defcfun ("_wrap_CProfileNode_Return"
               cPROFILE-NODE/RETURN) :pointer
  (self :pointer))
(declaim (inline CPROFILE-NODE/GET/NAME))
(cffi:defcfun ("_wrap_CProfileNode_Get_Name"
               cPROFILE-NODE/GET/NAME) :string
  (self :pointer))
(declaim (inline CPROFILE-NODE/GET/TOTAL/CALLS))
(cffi:defcfun ("_wrap_CProfileNode_Get_Total_Calls"
               cPROFILE-NODE/GET/TOTAL/CALLS) :int
  (self :pointer))
(declaim (inline CPROFILE-NODE/GET/TOTAL/TIME))
(cffi:defcfun ("_wrap_CProfileNode_Get_Total_Time"
               cPROFILE-NODE/GET/TOTAL/TIME) :float
  (self :pointer))
(declaim (inline CPROFILE-NODE/GET-USER-POINTER))
(cffi:defcfun ("_wrap_CProfileNode_GetUserPointer"
               cPROFILE-NODE/GET-USER-POINTER) :pointer
  (self :pointer))
(declaim (inline CPROFILE-NODE/SET-USER-POINTER))
(cffi:defcfun ("_wrap_CProfileNode_SetUserPointer"
               cPROFILE-NODE/SET-USER-POINTER) :void
  (self :pointer)
  (ptr :pointer))
(declaim (inline CPROFILE-ITERATOR/FIRST))
(cffi:defcfun ("_wrap_CProfileIterator_First"
               cPROFILE-ITERATOR/FIRST) :void
  (self :pointer))
(declaim (inline CPROFILE-ITERATOR/NEXT))
(cffi:defcfun ("_wrap_CProfileIterator_Next"
               cPROFILE-ITERATOR/NEXT) :void
  (self :pointer))
(declaim (inline CPROFILE-ITERATOR/IS/DONE))
(cffi:defcfun ("_wrap_CProfileIterator_Is_Done"
               cPROFILE-ITERATOR/IS/DONE) :pointer
  (self :pointer))
(declaim (inline CPROFILE-ITERATOR/IS/ROOT))
(cffi:defcfun ("_wrap_CProfileIterator_Is_Root"
               cPROFILE-ITERATOR/IS/ROOT) :pointer
  (self :pointer))
(declaim (inline CPROFILE-ITERATOR/ENTER/CHILD))
(cffi:defcfun ("_wrap_CProfileIterator_Enter_Child"
               cPROFILE-ITERATOR/ENTER/CHILD) :void
  (self :pointer)
  (index :int))
(declaim (inline CPROFILE-ITERATOR/ENTER/LARGEST/CHILD))
(cffi:defcfun ("_wrap_CProfileIterator_Enter_Largest_Child"
               cPROFILE-ITERATOR/ENTER/LARGEST/CHILD) :void
  (self :pointer))
(declaim (inline CPROFILE-ITERATOR/ENTER/PARENT))
(cffi:defcfun ("_wrap_CProfileIterator_Enter_Parent"
               cPROFILE-ITERATOR/ENTER/PARENT) :void
  (self :pointer))
(declaim (inline CPROFILE-ITERATOR/GET/CURRENT/NAME))
(cffi:defcfun ("_wrap_CProfileIterator_Get_Current_Name"
               cPROFILE-ITERATOR/GET/CURRENT/NAME) :string
  (self :pointer))
(declaim (inline CPROFILE-ITERATOR/GET/CURRENT/TOTAL/CALLS))
(cffi:defcfun ("_wrap_CProfileIterator_Get_Current_Total_Calls"
               cPROFILE-ITERATOR/GET/CURRENT/TOTAL/CALLS) :int
  (self :pointer))
(declaim (inline CPROFILE-ITERATOR/GET/CURRENT/TOTAL/TIME))
(cffi:defcfun ("_wrap_CProfileIterator_Get_Current_Total_Time"
               cPROFILE-ITERATOR/GET/CURRENT/TOTAL/TIME) :float
  (self :pointer))
(declaim (inline CPROFILE-ITERATOR/GET/CURRENT/USER-POINTER))
(cffi:defcfun ("_wrap_CProfileIterator_Get_Current_UserPointer"
               cPROFILE-ITERATOR/GET/CURRENT/USER-POINTER) :pointer
  (self :pointer))
(declaim (inline CPROFILE-ITERATOR/SET/CURRENT/USER-POINTER))
(cffi:defcfun ("_wrap_CProfileIterator_Set_Current_UserPointer"
               cPROFILE-ITERATOR/SET/CURRENT/USER-POINTER) :void
  (self :pointer)
  (ptr :pointer))
(declaim (inline CPROFILE-ITERATOR/GET/CURRENT/PARENT/NAME))
(cffi:defcfun ("_wrap_CProfileIterator_Get_Current_Parent_Name"
               cPROFILE-ITERATOR/GET/CURRENT/PARENT/NAME) :string
  (self :pointer))
(declaim (inline CPROFILE-ITERATOR/GET/CURRENT/PARENT/TOTAL/CALLS))
(cffi:defcfun ("_wrap_CProfileIterator_Get_Current_Parent_Total_Calls"
               cPROFILE-ITERATOR/GET/CURRENT/PARENT/TOTAL/CALLS) :int
  (self :pointer))
(declaim (inline CPROFILE-ITERATOR/GET/CURRENT/PARENT/TOTAL/TIME))
(cffi:defcfun ("_wrap_CProfileIterator_Get_Current_Parent_Total_Time"
               cPROFILE-ITERATOR/GET/CURRENT/PARENT/TOTAL/TIME) :float
  (self :pointer))
(declaim (inline DELETE/CPROFILE-ITERATOR))
(cffi:defcfun ("_wrap_delete_CProfileIterator"
               DELETE/CPROFILE-ITERATOR) :void
  (self :pointer))
(declaim (inline CPROFILE-MANAGER/START/PROFILE))
(cffi:defcfun ("_wrap_CProfileManager_Start_Profile"
               cPROFILE-MANAGER/START/PROFILE) :void
  (name :string))
(declaim (inline CPROFILE-MANAGER/STOP/PROFILE))
(cffi:defcfun ("_wrap_CProfileManager_Stop_Profile"
               cPROFILE-MANAGER/STOP/PROFILE) :void)
(declaim (inline CPROFILE-MANAGER/CLEANUP-MEMORY))
(cffi:defcfun ("_wrap_CProfileManager_CleanupMemory"
               cPROFILE-MANAGER/CLEANUP-MEMORY) :void)
(declaim (inline CPROFILE-MANAGER/RESET))
(cffi:defcfun ("_wrap_CProfileManager_Reset"
               cPROFILE-MANAGER/RESET) :void)
(declaim (inline CPROFILE-MANAGER/INCREMENT/FRAME/COUNTER))
(cffi:defcfun ("_wrap_CProfileManager_Increment_Frame_Counter"
               cPROFILE-MANAGER/INCREMENT/FRAME/COUNTER) :void)
(declaim (inline CPROFILE-MANAGER/GET/FRAME/COUNT/SINCE/RESET))
(cffi:defcfun ("_wrap_CProfileManager_Get_Frame_Count_Since_Reset"
               cPROFILE-MANAGER/GET/FRAME/COUNT/SINCE/RESET) :int)
(declaim (inline CPROFILE-MANAGER/GET/TIME/SINCE/RESET))
(cffi:defcfun ("_wrap_CProfileManager_Get_Time_Since_Reset"
               cPROFILE-MANAGER/GET/TIME/SINCE/RESET) :float)
(declaim (inline CPROFILE-MANAGER/GET/ITERATOR))
(cffi:defcfun ("_wrap_CProfileManager_Get_Iterator"
               cPROFILE-MANAGER/GET/ITERATOR) :pointer)
(declaim (inline CPROFILE-MANAGER/RELEASE/ITERATOR))
(cffi:defcfun ("_wrap_CProfileManager_Release_Iterator"
               cPROFILE-MANAGER/RELEASE/ITERATOR) :void
  (iterator :pointer))
(declaim (inline CPROFILE-MANAGER/DUMP-RECURSIVE))
(cffi:defcfun ("_wrap_CProfileManager_dumpRecursive"
               cPROFILE-MANAGER/DUMP-RECURSIVE) :void
  (profileIterator :pointer)
  (spacing :int))
(declaim (inline CPROFILE-MANAGER/DUMP-ALL))
(cffi:defcfun ("_wrap_CProfileManager_dumpAll"
               cPROFILE-MANAGER/DUMP-ALL) :void)
(declaim (inline MAKE-CPROFILE-MANAGER))
(cffi:defcfun ("_wrap_new_CProfileManager"
               MAKE-CPROFILE-MANAGER) :pointer)
(declaim (inline DELETE/CPROFILE-MANAGER))
(cffi:defcfun ("_wrap_delete_CProfileManager"
               DELETE/CPROFILE-MANAGER) :void
  (self :pointer))
(declaim (inline MAKE-CPROFILE-SAMPLE))
(cffi:defcfun ("_wrap_new_CProfileSample"
               MAKE-CPROFILE-SAMPLE) :pointer
  (name :string))
(declaim (inline DELETE/CPROFILE-SAMPLE))
(cffi:defcfun ("_wrap_delete_CProfileSample"
               DELETE/CPROFILE-SAMPLE) :void
  (self :pointer))
(cffi:defcenum DEBUG-DRAW-MODES
  (:DBG-NO-DEBUG 0)
  (:DBG-DRAW-WIREFRAME 1)
  (:DBG-DRAW-AABB 2)
  (:DBG-DRAW-FEATURES-TEXT 4)
  (:DBG-DRAW-CONTACT-POINTS 8)
  (:DBG-NO-DEACTIVATION 16)
  (:DBG-NO-HELP-TEXT #.32)
  (:DBG-DRAW-TEXT #.64)
  (:DBG-PROFILE-TIMINGS 128)
  (:DBG-ENABLE-SAT-COMPARISON 256)
  (:DBG-DISABLE-BULLET-LCP #.512)
  (:DBG-ENABLE-CCD 1024)
  (:DBG-DRAW-CONSTRAINTS #.(ash 1 11))
  (:DBG-DRAW-CONSTRAINT-LIMITS #.(ash 1 12))
  (:DBG-FAST-WIREFRAME #.(ash 1 13))
  (:DBG-DRAW-NORMALS #.(ash 1 14))
  :DBG-MAX-DEBUG-DRAW-MODE)
(declaim (inline DELETE/BT-IDEBUG-DRAW))
(cffi:defcfun ("_wrap_delete_btIDebugDraw"
               DELETE/BT-IDEBUG-DRAW) :void
  (self :pointer))
(declaim (inline IDEBUG-DRAW/DRAW-LINE))
(cffi:defcfun ("_wrap_btIDebugDraw_drawLine__SWIG_0"
               IDEBUG-DRAW/DRAW-LINE/with-from&to&color) :void
  (self :pointer)
  (from :pointer)
  (to :pointer)
  (color :pointer))
(declaim (inline IDEBUG-DRAW/DRAW-LINE))
(cffi:defcfun ("_wrap_btIDebugDraw_drawLine__SWIG_1"
               IDEBUG-DRAW/DRAW-LINE/with-from&to&from-&to-color) :void
  (self :pointer)
  (from :pointer)
  (to :pointer)
  (fromColor :pointer)
  (toColor :pointer))
(declaim (inline IDEBUG-DRAW/DRAW-SPHERE))
(cffi:defcfun ("_wrap_btIDebugDraw_drawSphere__SWIG_0"
               IDEBUG-DRAW/DRAW-SPHERE/with-radius&transform&color) :void
  (self :pointer)
  (radius :float)
  (transform :pointer)
  (color :pointer))
(declaim (inline IDEBUG-DRAW/DRAW-SPHERE))
(cffi:defcfun ("_wrap_btIDebugDraw_drawSphere__SWIG_1"
               IDEBUG-DRAW/DRAW-SPHERE/with-p&radius&color) :void
  (self :pointer)
  (p :pointer)
  (radius :float)
  (color :pointer))
(declaim (inline IDEBUG-DRAW/DRAW-TRIANGLE))
(cffi:defcfun ("_wrap_btIDebugDraw_drawTriangle__SWIG_0"
               IDEBUG-DRAW/DRAW-TRIANGLE/with-v0&1&2&arg4&5&6&color&alpha) :void
  (self :pointer)
  (v0 :pointer)
  (v1 :pointer)
  (v2 :pointer)
  (arg4 :pointer)
  (arg5 :pointer)
  (arg6 :pointer)
  (color :pointer)
  (alpha :float))
(declaim (inline IDEBUG-DRAW/DRAW-TRIANGLE))
(cffi:defcfun ("_wrap_btIDebugDraw_drawTriangle__SWIG_1"
               IDEBUG-DRAW/DRAW-TRIANGLE/with-v0&1&2&color&arg5) :void
  (self :pointer)
  (v0 :pointer)
  (v1 :pointer)
  (v2 :pointer)
  (color :pointer)
  (arg5 :float))
(declaim (inline IDEBUG-DRAW/DRAW-CONTACT-POINT))
(cffi:defcfun ("_wrap_btIDebugDraw_drawContactPoint"
               IDEBUG-DRAW/DRAW-CONTACT-POINT) :void
  (self :pointer)
  (PointOnB :pointer)
  (normalOnB :pointer)
  (distance :float)
  (lifeTime :int)
  (color :pointer))
(declaim (inline IDEBUG-DRAW/REPORT-ERROR-WARNING))
(cffi:defcfun ("_wrap_btIDebugDraw_reportErrorWarning"
               IDEBUG-DRAW/REPORT-ERROR-WARNING) :void
  (self :pointer)
  (warningString :string))
(declaim (inline IDEBUG-DRAW/DRAW-3D-TEXT))
(cffi:defcfun ("_wrap_btIDebugDraw_draw3dText"
               IDEBUG-DRAW/DRAW-3D-TEXT) :void
  (self :pointer)
  (location :pointer)
  (textString :string))
(declaim (inline IDEBUG-DRAW/SET-DEBUG-MODE))
(cffi:defcfun ("_wrap_btIDebugDraw_setDebugMode"
               IDEBUG-DRAW/SET-DEBUG-MODE) :void
  (self :pointer)
  (debugMode :int))
(declaim (inline IDEBUG-DRAW/GET-DEBUG-MODE))
(cffi:defcfun ("_wrap_btIDebugDraw_getDebugMode"
               IDEBUG-DRAW/GET-DEBUG-MODE) :int
  (self :pointer))
(declaim (inline IDEBUG-DRAW/DRAW-AABB))
(cffi:defcfun ("_wrap_btIDebugDraw_drawAabb"
               IDEBUG-DRAW/DRAW-AABB) :void
  (self :pointer)
  (from :pointer)
  (to :pointer)
  (color :pointer))
(declaim (inline IDEBUG-DRAW/DRAW-TRANSFORM))
(cffi:defcfun ("_wrap_btIDebugDraw_drawTransform"
               IDEBUG-DRAW/DRAW-TRANSFORM) :void
  (self :pointer)
  (transform :pointer)
  (orthoLen :float))
(declaim (inline IDEBUG-DRAW/DRAW-ARC))
(cffi:defcfun ("_wrap_btIDebugDraw_drawArc__SWIG_0"
               IDEBUG-DRAW/DRAW-ARC) :void
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
(declaim (inline IDEBUG-DRAW/DRAW-ARC))
(cffi:defcfun ("_wrap_btIDebugDraw_drawArc__SWIG_1"
               IDEBUG-DRAW/DRAW-ARC/with-center&normal&axis&radius-a&&b&&min-&max-angle&color&draw-sect)
    :void
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
(declaim (inline IDEBUG-DRAW/DRAW-SPHERE-PATCH))
(cffi:defcfun ("_wrap_btIDebugDraw_drawSpherePatch__SWIG_0"
               IDEBUG-DRAW/DRAW-SPHERE-PATCH/with-c&u&a&r&m&m&m&m&c&s&d) :void
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
(declaim (inline IDEBUG-DRAW/DRAW-SPHERE-PATCH))
(cffi:defcfun ("_wrap_btIDebugDraw_drawSpherePatch__SWIG_1"
               IDEBUG-DRAW/DRAW-SPHERE-PATCH/with-c&u&a&r&m&m&m&m&c&s) :void
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
(declaim (inline IDEBUG-DRAW/DRAW-SPHERE-PATCH))
(cffi:defcfun ("_wrap_btIDebugDraw_drawSpherePatch__SWIG_2"
               IDEBUG-DRAW/DRAW-SPHERE-PATCH/with-c&u&a&r&m&m&m&m&c) :void
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
(declaim (inline IDEBUG-DRAW/DRAW-BOX))
(cffi:defcfun ("_wrap_btIDebugDraw_drawBox__SWIG_0"
               IDEBUG-DRAW/DRAW-BOX/with-bb-min&max&color) :void
  (self :pointer)
  (bbMin :pointer)
  (bbMax :pointer)
  (color :pointer))
(declaim (inline IDEBUG-DRAW/DRAW-BOX))
(cffi:defcfun ("_wrap_btIDebugDraw_drawBox__SWIG_1"
               IDEBUG-DRAW/DRAW-BOX/with-bb-min&max&trans&color) :void
  (self :pointer)
  (bbMin :pointer)
  (bbMax :pointer)
  (trans :pointer)
  (color :pointer))
(declaim (inline IDEBUG-DRAW/DRAW-CAPSULE))
(cffi:defcfun ("_wrap_btIDebugDraw_drawCapsule"
               IDEBUG-DRAW/DRAW-CAPSULE) :void
  (self :pointer)
  (radius :float)
  (halfHeight :float)
  (upAxis :int)
  (transform :pointer)
  (color :pointer))
(declaim (inline IDEBUG-DRAW/DRAW-CYLINDER))
(cffi:defcfun ("_wrap_btIDebugDraw_drawCylinder"
               IDEBUG-DRAW/DRAW-CYLINDER) :void
  (self :pointer)
  (radius :float)
  (halfHeight :float)
  (upAxis :int)
  (transform :pointer)
  (color :pointer))
(declaim (inline IDEBUG-DRAW/DRAW-CONE))
(cffi:defcfun ("_wrap_btIDebugDraw_drawCone"
               IDEBUG-DRAW/DRAW-CONE) :void
  (self :pointer)
  (radius :float)
  (height :float)
  (upAxis :int)
  (transform :pointer)
  (color :pointer))
(declaim (inline IDEBUG-DRAW/DRAW-PLANE))
(cffi:defcfun ("_wrap_btIDebugDraw_drawPlane"
               IDEBUG-DRAW/DRAW-PLANE) :void
  (self :pointer)
  (planeNormal :pointer)
  (planeConst :float)
  (transform :pointer)
  (color :pointer))
(cffi:defcvar ("sBulletDNAstr"
               *S-BULLET-DNASTR*)
    :pointer)
(cffi:defcvar ("sBulletDNAlen"
               *S-BULLET-DNALEN*)
    :int)
(cffi:defcvar ("sBulletDNAstr64"
               *S-BULLET-DNASTR-64*)
    :pointer)
(cffi:defcvar ("sBulletDNAlen64"
               *S-BULLET-DNALEN-64*)
    :int)
(declaim (inline STR-LEN))
(cffi:defcfun ("_wrap_btStrLen"
               STR-LEN) :int
  (str :string))
(declaim (inline CHUNK/CHUNK-CODE/SET))
(cffi:defcfun ("_wrap_btChunk_m_chunkCode_set"
               cHUNK/CHUNK-CODE/SET) :void
  (self :pointer)
  (m_chunkCode :int))
(declaim (inline CHUNK/CHUNK-CODE/GET))
(cffi:defcfun ("_wrap_btChunk_m_chunkCode_get"
               cHUNK/CHUNK-CODE/GET) :int
  (self :pointer))
(declaim (inline CHUNK/LENGTH/SET))
(cffi:defcfun ("_wrap_btChunk_m_length_set"
               cHUNK/LENGTH/SET) :void
  (self :pointer)
  (m_length :int))
(declaim (inline CHUNK/LENGTH/GET))
(cffi:defcfun ("_wrap_btChunk_m_length_get"
               cHUNK/LENGTH/GET) :int
  (self :pointer))
(declaim (inline CHUNK/OLD-PTR/SET))
(cffi:defcfun ("_wrap_btChunk_m_oldPtr_set"
               cHUNK/OLD-PTR/SET) :void
  (self :pointer)
  (m_oldPtr :pointer))
(declaim (inline CHUNK/OLD-PTR/GET))
(cffi:defcfun ("_wrap_btChunk_m_oldPtr_get"
               cHUNK/OLD-PTR/GET) :pointer
  (self :pointer))
(declaim (inline CHUNK/DNA/NR/SET))
(cffi:defcfun ("_wrap_btChunk_m_dna_nr_set"
               cHUNK/DNA/NR/SET) :void
  (self :pointer)
  (m_dna_nr :int))
(declaim (inline CHUNK/DNA/NR/GET))
(cffi:defcfun ("_wrap_btChunk_m_dna_nr_get"
               cHUNK/DNA/NR/GET) :int
  (self :pointer))
(declaim (inline CHUNK/NUMBER/SET))
(cffi:defcfun ("_wrap_btChunk_m_number_set"
               cHUNK/NUMBER/SET) :void
  (self :pointer)
  (m_number :int))
(declaim (inline CHUNK/NUMBER/GET))
(cffi:defcfun ("_wrap_btChunk_m_number_get"
               cHUNK/NUMBER/GET) :int
  (self :pointer))
(declaim (inline MAKE-CHUNK))
(cffi:defcfun ("_wrap_new_btChunk"
               MAKE-CHUNK) :pointer)
(declaim (inline DELETE/BT-CHUNK))
(cffi:defcfun ("_wrap_delete_btChunk"
               DELETE/BT-CHUNK) :void
  (self :pointer))
(cffi:defcenum SERIALIZATION-FLAGS
  (:SERIALIZE-NO-BVH 1)
  (:SERIALIZE-NO-TRIANGLEINFOMAP 2)
  (:SERIALIZE-NO-DUPLICATE-ASSERT 4))
(declaim (inline DELETE/BT-SERIALIZER))
(cffi:defcfun ("_wrap_delete_btSerializer"
               DELETE/BT-SERIALIZER) :void
  (self :pointer))
(declaim (inline SERIALIZER/GET-BUFFER-POINTER))
(cffi:defcfun ("_wrap_btSerializer_getBufferPointer"
               SERIALIZER/GET-BUFFER-POINTER) :pointer
  (self :pointer))
(declaim (inline SERIALIZER/GET-CURRENT-BUFFER-SIZE))
(cffi:defcfun ("_wrap_btSerializer_getCurrentBufferSize"
               SERIALIZER/GET-CURRENT-BUFFER-SIZE) :int
  (self :pointer))
(declaim (inline SERIALIZER/ALLOCATE))
(cffi:defcfun ("_wrap_btSerializer_allocate"
               SERIALIZER/ALLOCATE) :pointer
  (self :pointer)
  (size :pointer)
  (numElements :int))
(declaim (inline SERIALIZER/FINALIZE-CHUNK))
(cffi:defcfun ("_wrap_btSerializer_finalizeChunk"
               SERIALIZER/FINALIZE-CHUNK) :void
  (self :pointer)
  (chunk :pointer)
  (structType :string)
  (chunkCode :int)
  (oldPtr :pointer))
(declaim (inline SERIALIZER/FIND-POINTER))
(cffi:defcfun ("_wrap_btSerializer_findPointer"
               SERIALIZER/FIND-POINTER) :pointer
  (self :pointer)
  (oldPtr :pointer))
(declaim (inline SERIALIZER/GET-UNIQUE-POINTER))
(cffi:defcfun ("_wrap_btSerializer_getUniquePointer"
               SERIALIZER/GET-UNIQUE-POINTER) :pointer
  (self :pointer)
  (oldPtr :pointer))
(declaim (inline SERIALIZER/START-SERIALIZATION))
(cffi:defcfun ("_wrap_btSerializer_startSerialization"
               SERIALIZER/START-SERIALIZATION) :void
  (self :pointer))
(declaim (inline SERIALIZER/FINISH-SERIALIZATION))
(cffi:defcfun ("_wrap_btSerializer_finishSerialization"
               SERIALIZER/FINISH-SERIALIZATION) :void
  (self :pointer))
(declaim (inline SERIALIZER/FIND-NAME-FOR-POINTER))
(cffi:defcfun ("_wrap_btSerializer_findNameForPointer"
               SERIALIZER/FIND-NAME-FOR-POINTER) :string
  (self :pointer)
  (ptr :pointer))
(declaim (inline SERIALIZER/REGISTER-NAME-FOR-POINTER))
(cffi:defcfun ("_wrap_btSerializer_registerNameForPointer"
               SERIALIZER/REGISTER-NAME-FOR-POINTER) :void
  (self :pointer)
  (ptr :pointer)
  (name :string))
(declaim (inline SERIALIZER/SERIALIZE-NAME))
(cffi:defcfun ("_wrap_btSerializer_serializeName"
               SERIALIZER/SERIALIZE-NAME) :void
  (self :pointer)
  (ptr :string))
(declaim (inline SERIALIZER/GET-SERIALIZATION-FLAGS))
(cffi:defcfun ("_wrap_btSerializer_getSerializationFlags"
               SERIALIZER/GET-SERIALIZATION-FLAGS) :int
  (self :pointer))
(declaim (inline SERIALIZER/SET-SERIALIZATION-FLAGS))
(cffi:defcfun ("_wrap_btSerializer_setSerializationFlags"
               SERIALIZER/SET-SERIALIZATION-FLAGS) :void
  (self :pointer)
  (flags :int))
(define-constant +HEADER-LENGTH+ 12)

(declaim (inline MAKE-DEFAULT-SERIALIZER))
(cffi:defcfun ("_wrap_new_btDefaultSerializer__SWIG_0"
               MAKE-DEFAULT-SERIALIZER/with-total-size) :pointer
  (totalSize :int))
(declaim (inline MAKE-DEFAULT-SERIALIZER))
(cffi:defcfun ("_wrap_new_btDefaultSerializer__SWIG_1"
               MAKE-DEFAULT-SERIALIZER) :pointer)
(declaim (inline DELETE/BT-DEFAULT-SERIALIZER))
(cffi:defcfun ("_wrap_delete_btDefaultSerializer"
               DELETE/BT-DEFAULT-SERIALIZER) :void
  (self :pointer))
(declaim (inline DEFAULT-SERIALIZER/WRITE-HEADER))
(cffi:defcfun ("_wrap_btDefaultSerializer_writeHeader"
               DEFAULT-SERIALIZER/WRITE-HEADER) :void
  (self :pointer)
  (buffer :pointer))
(declaim (inline DEFAULT-SERIALIZER/START-SERIALIZATION))
(cffi:defcfun ("_wrap_btDefaultSerializer_startSerialization"
               DEFAULT-SERIALIZER/START-SERIALIZATION) :void
  (self :pointer))
(declaim (inline DEFAULT-SERIALIZER/FINISH-SERIALIZATION))
(cffi:defcfun ("_wrap_btDefaultSerializer_finishSerialization"
               DEFAULT-SERIALIZER/FINISH-SERIALIZATION) :void
  (self :pointer))
(declaim (inline DEFAULT-SERIALIZER/GET-UNIQUE-POINTER))
(cffi:defcfun ("_wrap_btDefaultSerializer_getUniquePointer"
               DEFAULT-SERIALIZER/GET-UNIQUE-POINTER) :pointer
  (self :pointer)
  (oldPtr :pointer))
(declaim (inline DEFAULT-SERIALIZER/GET-BUFFER-POINTER))
(cffi:defcfun ("_wrap_btDefaultSerializer_getBufferPointer"
               DEFAULT-SERIALIZER/GET-BUFFER-POINTER) :pointer
  (self :pointer))
(declaim (inline DEFAULT-SERIALIZER/GET-CURRENT-BUFFER-SIZE))
(cffi:defcfun ("_wrap_btDefaultSerializer_getCurrentBufferSize"
               DEFAULT-SERIALIZER/GET-CURRENT-BUFFER-SIZE) :int
  (self :pointer))
(declaim (inline DEFAULT-SERIALIZER/FINALIZE-CHUNK))
(cffi:defcfun ("_wrap_btDefaultSerializer_finalizeChunk"
               DEFAULT-SERIALIZER/FINALIZE-CHUNK) :void
  (self :pointer)
  (chunk :pointer)
  (structType :string)
  (chunkCode :int)
  (oldPtr :pointer))
(declaim (inline DEFAULT-SERIALIZER/INTERNAL-ALLOC))
(cffi:defcfun ("_wrap_btDefaultSerializer_internalAlloc"
               DEFAULT-SERIALIZER/INTERNAL-ALLOC) :pointer
  (self :pointer)
  (size :pointer))
(declaim (inline DEFAULT-SERIALIZER/ALLOCATE))
(cffi:defcfun ("_wrap_btDefaultSerializer_allocate"
               DEFAULT-SERIALIZER/ALLOCATE) :pointer
  (self :pointer)
  (size :pointer)
  (numElements :int))
(declaim (inline DEFAULT-SERIALIZER/FIND-NAME-FOR-POINTER))
(cffi:defcfun ("_wrap_btDefaultSerializer_findNameForPointer"
               DEFAULT-SERIALIZER/FIND-NAME-FOR-POINTER) :string
  (self :pointer)
  (ptr :pointer))
(declaim (inline DEFAULT-SERIALIZER/REGISTER-NAME-FOR-POINTER))
(cffi:defcfun ("_wrap_btDefaultSerializer_registerNameForPointer"
               DEFAULT-SERIALIZER/REGISTER-NAME-FOR-POINTER) :void
  (self :pointer)
  (ptr :pointer)
  (name :string))
(declaim (inline DEFAULT-SERIALIZER/SERIALIZE-NAME))
(cffi:defcfun ("_wrap_btDefaultSerializer_serializeName"
               DEFAULT-SERIALIZER/SERIALIZE-NAME) :void
  (self :pointer)
  (name :string))
(declaim (inline DEFAULT-SERIALIZER/GET-SERIALIZATION-FLAGS))
(cffi:defcfun ("_wrap_btDefaultSerializer_getSerializationFlags"
               DEFAULT-SERIALIZER/GET-SERIALIZATION-FLAGS) :int
  (self :pointer))
(declaim (inline DEFAULT-SERIALIZER/SET-SERIALIZATION-FLAGS))
(cffi:defcfun ("_wrap_btDefaultSerializer_setSerializationFlags"
               DEFAULT-SERIALIZER/SET-SERIALIZATION-FLAGS) :void
  (self :pointer)
  (flags :int))
(declaim (inline DISCRETE-DYNAMICS-WORLD/MAKE-c++-INSTANCE))
(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_makeCPlusPlusInstance__SWIG_0"
               DISCRETE-DYNAMICS-WORLD/MAKE-c++-INSTANCE) :pointer
  (self :pointer)
  (sizeInBytes :pointer))
(declaim (inline DISCRETE-DYNAMICS-WORLD/DELETE-c++-INSTANCE))
(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_deleteCPlusPlusInstance__SWIG_0"
               DISCRETE-DYNAMICS-WORLD/DELETE-c++-INSTANCE) :void
  (self :pointer)
  (ptr :pointer))
(declaim (inline DISCRETE-DYNAMICS-WORLD/MAKE-c++-INSTANCE))
(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_makeCPlusPlusInstance__SWIG_1"
               DISCRETE-DYNAMICS-WORLD/MAKE-c++-INSTANCE/with-arg1&ptr) :pointer
  (self :pointer)
  (arg1 :pointer)
  (ptr :pointer))
(declaim (inline DISCRETE-DYNAMICS-WORLD/DELETE-c++-INSTANCE))
(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_deleteCPlusPlusInstance__SWIG_1"
               DISCRETE-DYNAMICS-WORLD/DELETE-c++-INSTANCE/with-arg1&2) :void
  (self :pointer)
  (arg1 :pointer)
  (arg2 :pointer))
(declaim (inline DISCRETE-DYNAMICS-WORLD/MAKE-c++-ARRAY))
(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_makeCPlusArray__SWIG_0"
               DISCRETE-DYNAMICS-WORLD/MAKE-c++-ARRAY) :pointer
  (self :pointer)
  (sizeInBytes :pointer))
(declaim (inline DISCRETE-DYNAMICS-WORLD/DELETE-c++-ARRAY))
(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_deleteCPlusArray__SWIG_0"
               DISCRETE-DYNAMICS-WORLD/DELETE-c++-ARRAY) :void
  (self :pointer)
  (ptr :pointer))
(declaim (inline DISCRETE-DYNAMICS-WORLD/MAKE-c++-ARRAY))
(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_makeCPlusArray__SWIG_1"
               DISCRETE-DYNAMICS-WORLD/MAKE-c++-ARRAY/with-arg1&ptr) :pointer
  (self :pointer)
  (arg1 :pointer)
  (ptr :pointer))
(declaim (inline DISCRETE-DYNAMICS-WORLD/DELETE-c++-ARRAY))
(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_deleteCPlusArray__SWIG_1"
               DISCRETE-DYNAMICS-WORLD/DELETE-c++-ARRAY/with-arg1&2) :void
  (self :pointer)
  (arg1 :pointer)
  (arg2 :pointer))
(declaim (inline MAKE-DISCRETE-DYNAMICS-WORLD))
(cffi:defcfun ("_wrap_new_btDiscreteDynamicsWorld"
               MAKE-DISCRETE-DYNAMICS-WORLD) :pointer
  (dispatcher :pointer)
  (pairCache :pointer)
  (constraintSolver :pointer)
  (collisionConfiguration :pointer))
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
               DISCRETE-DYNAMICS-WORLD/STEP-SIMULATION/with-time-step&max-sub-steps)
    :int
  (self :pointer)
  (timeStep :float)
  (maxSubSteps :int))
(declaim (inline DISCRETE-DYNAMICS-WORLD/STEP-SIMULATION))
(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_stepSimulation__SWIG_2"
               DISCRETE-DYNAMICS-WORLD/STEP-SIMULATION/with-time-step) :int
  (self :pointer)
  (timeStep :float))
(declaim (inline DISCRETE-DYNAMICS-WORLD/SYNCHRONIZE-MOTION-STATES))
(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_synchronizeMotionStates"
               DISCRETE-DYNAMICS-WORLD/SYNCHRONIZE-MOTION-STATES) :void
  (self :pointer))
(declaim (inline DISCRETE-DYNAMICS-WORLD/SYNCHRONIZE-SINGLE-MOTION-STATE))
(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_synchronizeSingleMotionState"
               DISCRETE-DYNAMICS-WORLD/SYNCHRONIZE-SINGLE-MOTION-STATE) :void
  (self :pointer)
  (body :pointer))
(declaim (inline DISCRETE-DYNAMICS-WORLD/ADD-CONSTRAINT))
(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_addConstraint__SWIG_0"
               DISCRETE-DYNAMICS-WORLD/ADD-CONSTRAINT/with-disable-collision-between-linked-bodies) 
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
(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_getSimulationIslandManager__SWIG_1"
               DISCRETE-DYNAMICS-WORLD/GET-SIMULATION-ISLAND-MANAGER) :pointer
  (self :pointer))
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
(declaim (inline DISCRETE-DYNAMICS-WORLD/ADD-COLLISION-OBJECT/with-filter-group&mask))
(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_addCollisionObject__SWIG_0"
               DISCRETE-DYNAMICS-WORLD/ADD-COLLISION-OBJECT/with-filter-group&mask) :void
  (self :pointer)
  (collisionObject :pointer)
  (collisionFilterGroup :short)
  (collisionFilterMask :short))
(declaim (inline DISCRETE-DYNAMICS-WORLD/ADD-COLLISION-OBJECT/with-filter-group))
(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_addCollisionObject__SWIG_1"
               DISCRETE-DYNAMICS-WORLD/ADD-COLLISION-OBJECT/with-filter-group) :void
  (self :pointer)
  (collisionObject :pointer)
  (collisionFilterGroup :short))
(declaim (inline DISCRETE-DYNAMICS-WORLD/ADD-COLLISION-OBJECT))
(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_addCollisionObject__SWIG_2"
               DISCRETE-DYNAMICS-WORLD/ADD-COLLISION-OBJECT) :void
  (self :pointer)
  (collisionObject :pointer))
(declaim (inline DISCRETE-DYNAMICS-WORLD/ADD-RIGID-BODY))
(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_addRigidBody__SWIG_0"
               DISCRETE-DYNAMICS-WORLD/ADD-RIGID-BODY) :void
  (self :pointer)
  (body :pointer))
(declaim (inline DISCRETE-DYNAMICS-WORLD/ADD-RIGID-BODY))
(cffi:defcfun ("_wrap_btDiscreteDynamicsWorld_addRigidBody__SWIG_1"
               DISCRETE-DYNAMICS-WORLD/ADD-RIGID-BODY/with-group&mask) :void
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
               DISCRETE-DYNAMICS-WORLD/GET-CONSTRAINT) :pointer
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

