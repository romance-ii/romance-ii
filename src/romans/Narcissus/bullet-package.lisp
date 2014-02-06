(defpackage bullet-physics
  (:use :cl :alexandria)
  (:nicknames bullet)
  (:documentation 
   
   "Bullet is a Collision Detection and Rigid Body Dynamics Library.
 The Library is Open Source and free for commercial use, under the
 zlib.  The C++ documentation is at bulletphysics.org; this is a
 simple wrapper to make Bullet available to Common Lisp programs.

This package was hand-edited to save time over learning
Swig properly.")
  (:export #:+active-tag+
           #:+collision-object-data-name+
           #:+disable-deactivation+
           #:+disable-simulation+
           #:+dynamic-set+
           #:+fixed-set+
           #:+island-sleeping+
           #:+stagecount+
           #:+wants-deactivation+
           #:6-dof-flags
           #:activate
           #:activation-state
           #:activation-state-1
           #:activep
           #:add-action
           #:add-character
           #:add-collision-object
           #:add-constraint
           #:add-rigid-body
           #:add-single-result
           #:add-vehicle
           #:all-hits-ray-result-callback
           #:anisotropic-friction
           #:anisotropic-friction-flags
           #:apply-gravity
           #:apply-speculative-contact-restitution
           #:broadphase
           #:broadphase-handle
           #:calculate-serialize-buffer-size
           #:ccd-motion-threshold
           #:ccd-square-motion-threshold
           #:ccd-swept-sphere-radius
           #:check-collide-with
           #:clear-forces
           #:closest-convex-result-callback
           #:closest-hit-fraction
           #:closest-ray-result-callback
           #:collision-filter-group
           #:collision-filter-mask
           #:collision-flags
           #:collision-object
           #:collision-object-array
           #:collision-object-double-data
           #:collision-object-float-data
           #:collision-object-types
           #:collision-objects
           #:collision-shape
           #:collision-world
           #:companion-id
           #:compute-overlapping-pairs
           #:cone-twist-flags
           #:constraint
           #:constraint-solver
           #:contact-pair-test
           #:contact-processing-threshold
           #:contact-result-callback
           #:contact-test
           #:convex-from-world
           #:convex-result-callback
           #:convex-sweep-test
           #:convex-to-world
           #:deactivation-time
           #:debug-draw-constraint
           #:debug-draw-modes
           #:debug-draw-object
           #:debug-draw-world
           #:debug-drawer
           #:dispatch-info
           #:dispatcher
           #:dispatcher-flags
           #:flags
           #:force-activation-state
           #:force-update-all-aabbs
           #:friction
           #:get-broadphase-handle
           #:gravity
           #:has-anisotropic-friction
           #:has-anisotropic-friction-p
           #:has-contact-response-p
           #:has-hit
           #:hinge-flags
           #:hit-collision-object
           #:hit-fraction
           #:hit-fractions
           #:hit-normal-local
           #:hit-normal-world
           #:hit-point-local
           #:hit-point-world
           #:initialize-instance
           #:internal-get-extension-pointer
           #:internal-set-extension-pointer
           #:internal-type
           #:interpolation-angular-velocity
           #:interpolation-linear-velocity
           #:interpolation-world-transform
           #:island-tag
           #:island-tag-1
           #:kinematic-object-p
           #:latency-motion-state-interpolation
           #:local-convex-result
           #:local-ray-result
           #:local-shape-info
           #:make-collision-object
           #:make-collision-world
           #:make-discrete-dynamics-world
           #:make-simple-dynamics-world
           #:make-vector3
           #:merges-simulation-islands
           #:name
           #:needs-collision
           #:num-collision-objects
           #:num-constraints
           #:num-tasks
           #:padding
           #:pair-cache
           #:perform-discrete-collision-detection
           #:point-2-point-flags
           #:ray-from-world
           #:ray-result-callback
           #:ray-test
           #:ray-to-world
           #:remove-action
           #:remove-character
           #:remove-collision-object
           #:remove-constraint
           #:remove-rigid-body
           #:remove-vehicle
           #:restitution
           #:rigid-body-flags
           #:rolling-friction
           #:root-collision-shape
           #:serialization-flags
           #:serialize
           #:serialize-single-object
           #:setf
           #:shape-part
           #:simple-broadphase
           #:simulation-island-manager
           #:slider-flags
           #:static-object-p
           #:static-or-kinematic-object-p
           #:step-simulation
           #:synchronize-all-motion-states
           #:synchronize-motion-states
           #:synchronize-single-motion-state
           #:triangle-index
           #:update-aabbs
           #:update-revision-internal
           #:update-single-aabb
           #:update-vehicles
           #:user-index
           #:user-pointer
           #:world-transform
           #:world-type))

(in-package #:bullet-physics)

(defparameter *compile-trace-output* nil)
(eval-when (:compile-toplevel)
  (setf *compile-trace-output* (open "Bullet Physics Wrapper mapping.log"
                                     :direction :output
                                     :if-exists :supersede)))

(cl:eval-when (:compile-toplevel :load-toplevel :execute)
  (defun lispify (identifier expression &optional (package cl:*package*)
                  &aux (setf% nil))
    (check-type identifier string)
    (assert (member expression '(function method
                                 classname class enumname
                                 constant enumvalue
                                 variable slotname)))
    (when *compile-trace-output*
      (format *compile-trace-output*
              "~& ~S → ~:(~A~) ⇒ " identifier expression))
    
    (when (and (> (length identifier) 4)
               (or (equal (subseq identifier 0 4) "set-")
                   (equal (subseq identifier 0 4) "set_"))
               (eql expression 'method))
      (setf identifier (subseq identifier 4)
            setf% t))
    (when (and (> (length identifier) 4)
               (or (equal (subseq identifier 0 4) "get-")
                   (equal (subseq identifier 0 4) "get_")))
      (setf identifier (subseq identifier 4)))
    (when (and (> (length identifier) 3)
               (or (equal (subseq identifier 0 3) "is-")
                   (equal (subseq identifier 0 3) "is_")))
      (setf identifier (concatenate
                        'string (subseq identifier 3) 
                        (if (or (find #\- (subseq identifier 3))
                                (find #\_ (subseq identifier 3)))
                            "-p" "p"))))
    (when (and (> (length identifier) 4)
               (or (equal (subseq identifier 0 4) "has-")
                   (equal (subseq identifier 0 4) "has_")))
      (setf identifier (concatenate 'string identifier "-p")))
    (when (and (> (length identifier) 4)
               (equal (subseq identifier 0 4) "new_")
               (member expression '(function method)))
      (setf identifier (concatenate
                        'string "make-"
                        (cond ((or (equal (subseq identifier 4 7) "bt_")
                                   (equal (subseq identifier 4 7) "BT_")
                                   (equal (subseq identifier 4 7) "bt-"))
                               (subseq identifier 7))
                              ((equal (subseq identifier 4 6) "bt")
                               (subseq identifier 6))
                              (t (subseq identifier 4))))))

    (when (and (eql expression 'variable)
               (eql (elt identifier 0) #\g))
      (setf identifier (subseq identifier 1)))
    (when (and (> (length identifier) 3)
               (or (equal (subseq identifier 0 2) "m_")
                   (equal (subseq identifier 0 2) "m-")))
      (setf identifier (subseq identifier 2)))
    (when (and (> (length identifier) 3)
               (or (equal (subseq identifier 0 3) "bt_")
                   (equal (subseq identifier 0 3) "BT_")
                   (equal (subseq identifier 0 3) "bt-")))
      (setf identifier (subseq identifier 3)))
    (when (and (> (length identifier) 2)
               (equal (subseq identifier 0 2) "bt"))
      (setf identifier (subseq identifier 2)))

    (let ((name identifier)
          (flag expression))
      (labels
          ((helper (list last rest &aux (c (car list)))
             (cond
               ((null list) rest)
               ((upper-case-p c)    (helper (cdr list) 'upper
                                            (case last
                                              ((lower
                                                digit)  (list* c #\- rest))
                                              (t        (cons c rest)))))
               ((lower-case-p c)    (helper (cdr list) 'lower
                                            (cons (char-upcase c) rest)))
               ((digit-char-p c)    (helper (cdr list) 'digit
                                            (case last
                                              ((upper
                                                lower)  (list* c #\- rest))
                                              (t        (cons c rest)))))

               ((char-equal c #\_)  (helper (cdr list) '_
                                            (cons (case expression 
                                                    ((method 
                                                      function
                                                      classname
                                                      class
                                                      enumname) #\/)
                                                    (otherwise #\-)) rest)))
               (t                   (helper (cdr list) '_
                                            (cons c rest))))))
        
        (let ((fix (case flag
                     (constant "+")
                     (variable "*")
                     (otherwise ""))))
          (let ((token (concatenate 'string
                                    fix
                                    (nreverse (helper (concatenate 'list name)
                                                      nil nil))
                                    fix)))
            (when-let ((sym (find-symbol token :common-lisp)))
              (when (case flag
                      ((function method slotname)     (fboundp sym))
                      ((variable constant enumvalue)  (boundp sym))))
              (setf token (concatenate 'string "BULLET/" token)))
            (let ((sym (intern token package)))
              
              (if setf% 
                  (progn 
                    (when *compile-trace-output*
                      (format *compile-trace-output* "(SETF ~S)" sym))
                    (list 'setf sym))
                  (progn 
                    (when *compile-trace-output*
                      (format *compile-trace-output* "~S" sym))
                    sym)))))))))

(defmacro defmeth (name &rest method-stuff)
  `(progn (defmethod ,name ,@method-stuff)
          (export ',name)))

(defmacro defklass (name &rest method-stuff)
  `(progn (defclass ,name ,@method-stuff)
          (export ',name)))

(defmacro define-anonymous-enum (&body enums)
  "Converts anonymous enums to defconstants."
  `(progn ,@(loop for value in enums
               for index = 0 then (1+ index)
               when (listp value) do (setf index (second value)
                                           value (first value))
               collect `(define-constant ,value ,index))))


