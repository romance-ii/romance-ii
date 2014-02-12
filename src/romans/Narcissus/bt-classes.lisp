(in-package :bullet)

;;; Worlds

(defclass collision-world ()
  ((ff-pointer :reader ff-pointer)))

(defclass discrete-dynamics-world ()
  ((ff-pointer :reader ff-pointer)))

(defclass simple-dynamics-world ()
  ((ff-pointer :reader ff-pointer)))

;;; Things in worlds (objects/bodies)

(defclass collision-object ()
  ((ff-pointer :reader ff-pointer)))

(defclass box-shape ()
  ((ff-pointer :reader ff-pointer)))

(defclass sphere-shape ()
  ((ff-pointer :reader ff-pointer)))

(defclass capsule-shape ()
  ((ff-pointer :reader ff-pointer)))

(defclass capsule-shape-x (capsule-shape)
  ((ff-pointer :reader ff-pointer)))

(defclass capsule-shape-z (capsule-shape)
  ((ff-pointer :reader ff-pointer)))

(defclass cylinder-shape ()
  ((ff-pointer :reader ff-pointer)))

(defclass cylinder-shape-x (cylinder-shape)
  ((ff-pointer :reader ff-pointer)))

(defclass cylinder-shape-z (cylinder-shape)
  ((ff-pointer :reader ff-pointer)))

(defclass cone-shape ()
  ((ff-pointer :reader ff-pointer)))

(defclass cone-shape-x (cone-shape)
  ((ff-pointer :reader ff-pointer)))

(defclass cone-shape-z (cone-shape)
  ((ff-pointer :reader ff-pointer)))

(defclass static-plane-shape ()
  ((ff-pointer :reader ff-pointer)))

(defclass convex-hull-shape ()
  ((ff-pointer :reader ff-pointer)))

(defclass triangle-mesh ()
  ((ff-pointer :reader ff-pointer)))

(defclass convex-triangle-mesh-shape ()
  ((ff-pointer :reader ff-pointer)))

(defclass bvh-triangle-mesh-shape ()
  ((ff-pointer :reader ff-pointer)))

(defclass scaled-bvh-triangle-mesh-shape ()
  ((ff-pointer :reader ff-pointer)))

(defclass triangle-mesh-shape ()
  ((ff-pointer :reader ff-pointer)))

(defclass triangle-index-vertex-array ()
  ((ff-pointer :reader ff-pointer)))

(defclass compound-shape ()
  ((ff-pointer :reader ff-pointer)))

;;; Constraints

;;; Vectors, matrices, et al.

(defclass vector3 ()
  ((ff-pointer :reader ff-pointer)))

(defclass vector4 (vector3)
  ((ff-pointer :reader ff-pointer)))

(defclass quaternion ()
  ((ff-pointer :reader ff-pointer)))

(defclass matrix-3x3 ()
  ((ff-pointer :reader ff-pointer)))

(defclass transform ()
  ((ff-pointer :reader ff-pointer)))

;;; Unsorted mass of things

(defclass motion-state ()
  ((ff-pointer :reader ff-pointer)))

(defclass bu-simplex1to4 ()
  ((ff-pointer :reader ff-pointer)))

(defclass empty-shape ()
  ((ff-pointer :reader ff-pointer)))

(defclass multi-sphere-shape ()
  ((ff-pointer :reader ff-pointer)))

(defclass uniform-scaling-shape ()
  ((ff-pointer :reader ff-pointer)))

(defclass sphere-sphere-collision-algorithm ()
  ((ff-pointer :reader ff-pointer)))

(defclass default-collision-configuration ()
  ((ff-pointer :reader ff-pointer)))

(defclass collision-dispatcher ()
  ((ff-pointer :reader ff-pointer)))

(defclass simple-broadphase ()
  ((ff-pointer :reader ff-pointer)))

(defclass axis-sweep3 ()
  ((ff-pointer :reader ff-pointer)))

(defclass bt-32-bit-axis-sweep3 ()
  ((ff-pointer :reader ff-pointer)))

(defclass multi-sap-broadphase ()
  ((ff-pointer :reader ff-pointer)))

(defclass clock ()
  ((ff-pointer :reader ff-pointer)))

(defclass cprofile-node ()
  ((ff-pointer :reader ff-pointer)))

(defclass cprofile-iterator ()
  ((ff-pointer :reader ff-pointer)))

(defclass cprofile-manager ()
  ((ff-pointer :reader ff-pointer)))

(defclass cprofile-sample ()
  ((ff-pointer :reader ff-pointer)))

(defclass idebug-draw ()
  ((ff-pointer :reader ff-pointer)))

(defclass chunk ()
  ((ff-pointer :reader ff-pointer)))

(defclass serializer ()
  ((ff-pointer :reader ff-pointer)))

(defclass default-serializer (serializer)
  ((ff-pointer :reader ff-pointer)))

(defclass discrete-dynamics-world ()
  ((ff-pointer :reader ff-pointer)))

(defclass simple-dynamics-world ()
  ((ff-pointer :reader ff-pointer)))

(defclass rigid-body (collision-object)
  ((ff-pointer :reader ff-pointer)))

(defclass typed-constraint (typed-object)
  ((ff-pointer :reader ff-pointer)))

(defclass angular-limit ()
  ((ff-pointer :reader ff-pointer)))

(defclass point->point-constraint (typed-constraint)
  ((ff-pointer :reader ff-pointer)))

(defclass hinge-constraint (typed-constraint)
  ((ff-pointer :reader ff-pointer)))

(warn "Guessing at HINGE-2-CONSTRAINT")
(defclass hinge-2-constraint (hinge-constraint)
  ((ff-pointer :reader ff-pointer)))

(defclass cone-twist-constraint (typed-constraint)
  ((ff-pointer :reader ff-pointer)))

(defclass rotational-limit-motor ()
  ((ff-pointer :reader ff-pointer)))

(defclass translational-limit-motor ()
  ((ff-pointer :reader ff-pointer)))

(defclass generic-6-dof-constraint (typed-constraint)
  ((ff-pointer :reader ff-pointer)))

(defclass slider-constraint (typed-constraint)
  ((ff-pointer :reader ff-pointer)))

(defclass generic-6-dof-spring-constraint (generic-6dof-constraint)
  ((ff-pointer :reader ff-pointer)))

(defclass universal-constraint (generic-6dof-constraint)
  ((ff-pointer :reader ff-pointer)))

(defclass hinge2-constraint (generic-6dof-spring-constraint)
  ((ff-pointer :reader ff-pointer)))

(defclass gear-constraint (typed-constraint)
  ((ff-pointer :reader ff-pointer)))

(defclass fixed-constraint (typed-constraint)
  ((ff-pointer :reader ff-pointer)))

(defclass sequential-impulse-constraint-solver ()
  ((ff-pointer :reader ff-pointer)))

