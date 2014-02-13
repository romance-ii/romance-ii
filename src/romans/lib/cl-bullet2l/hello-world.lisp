;;; A fairly direct Lisp port of the C++ tutorial
(defpackage :bullet-tutorial
  (:use :cl :alexandria :bullet))
(in-package :bullet-tutorial)

(defun hello-rock-falls ()
  (let* ((broadphase (make-instance 'simple-broadphase #+ (or)'dbvt-broadphase))
        (collision-configuration (make-instance 'default-collision-configuration))
        (dispatcher (make-instance 'collision-dispatcher :collision collision-configuration))
        (solver (make-instance 'sequential-impulse-constraint-solver))
        (dynamics-world (make-instance 'discrete-dynamics-world
                                       :dispatcher dispatcher
                                       :broadphase broadphase 
                                       :solver solver 
                                       :collision-configuration collision-configuration)))
    (setf (gravity dynamics-world) (make-instance 'vector3 :x 0 :y -10 :z 0))
    (let* ((ground-shape (make-instance 'static-plane-shape 
                                        :thing1 (make-instance 'vector3 :x 0 :y 1 :z 0) :thing2 1))
          (fall-shape (make-instance 'sphere-shape :radius 1))
          (ground-motion-state (make-instance
                                'default-motion-state 
                                :transform
                                (make-instance 'transform
                                               :quaternion (make-instance 'quaternion) 
                                               :vector (make-instance 'vector3 :y -1))))
           (ground-rigid-body (make-instance 'rigid-body 
                                             :mass 0
                                             :motion-state ground-motion-state
                                             :shape ground-shape
                                             :inertia (make-instance 'vector3))))
     (add-rigid-body dynamics-world ground-rigid-body)
     (let ((fall-motion-state (make-instance 
                               'default-motion-state
                               :transform
                               (make-instance 
                                'transform
                                :q (make-instance 'quaternion)
                                :v (make-instance 'vector3 :y 50))))
           (mass 1.0)
           (fall-inertia (make-instance 'vector3)))
       (calculate-local-inertia fall-shape mass fall-inertia)
       (let ((fall-rigid-body (make-instance 
                               'rigid-body
                               :mass mass 
                               :motion-state fall-motion-state
                               :shape fall-shape
                               :inertia fall-inertia)))
         (add-rigid-body dynamics-world fall-rigid-body)
         (dotimes (i 300)
           (step-simulation dynamics-world 1/60 10)
           (let
               ;; (world-transform motion-state fall-rigid-body) 
               ;; but that doesn't match the signature
               ((trans (world-transform fall-rigid-body)))
             (format t "~&time: ~:ds sphere height: ~4f"
                     (/ i 60)
                     (y (origin trans)))))

         (remove-rigid-body dynamics-world fall-rigid-body)
         #+ (or)(delete (motion-state fall-rigid-body) )
         #+ (or)(delete fall-rigid-body)
        
         (remove-rigid-body dynamics-world ground-rigid-body)
         #+ (or)(delete (motion-state ground-rigid-body) )
         #+ (or)(delete ground-rigid-body)

         #+ (or)(delete fall-shape)
         #+ (or)(delete ground-shape)
         #+ (or)(delete dynamics-world)
         #+ (or)(delete solver)
         #+ (or)(delete collision-configuration)
         #+ (or)(delete dispatcher)
         #+ (or)(delete broadphase))))))
