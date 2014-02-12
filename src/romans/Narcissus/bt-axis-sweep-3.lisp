(in-package :bullet-physics)

(defmethod initialize-instance :after ((obj AXIS-SWEEP-3)
                                       &key world-Aabb-Min world-Aabb-Max 
                                         max-handles pair-cache
                                         (disable-raycast-accelerator-p nil dis?))
  (check-type world-Aabb-Min (or null VECTOR3))
  (check-type world-Aabb-Max (or null VECTOR3))
  (check-type max-handles (or null integer)) 
  (setf (slot-value obj 'ff-pointer) 
        (cond
          ((and world-aabb-min world-aabb-max
                max-handles pair-cache dis?)
           (MAKE-AXIS-SWEEP-3 world-Aabb-Min world-Aabb-Max
                              max-handles pair-cache
                              disable-Raycast-Accelerator-p))
          ((and world-aabb-min world-aabb-max
                max-handles pair-cache (not dis?))
           (MAKE-AXIS-SWEEP-3 world-Aabb-Min world-Aabb-Max max-handles pair-cache))
          ((and world-aabb-min world-aabb-max
                max-handles (not pair-cache) (not dis?))
           (MAKE-AXIS-SWEEP-3 world-Aabb-Min world-Aabb-Max max-handles))
          ((and world-aabb-min world-aabb-max
                (not max-handles) (not pair-cache) (not dis?))
           (MAKE-AXIS-SWEEP-3 world-Aabb-Min world-Aabb-Max))
          (t (error 'foo)))))

(defmethod initialize-instance :after ((obj BT-32-BIT-AXIS-SWEEP-3) 
                                       &optional world-Aabb-Min world-Aabb-Max 
                                         max-handles pair-cache
                                         (disable-raycast-accelerator-p nil dis?))
  (check-type world-Aabb-Min (or null VECTOR3))
  (check-type world-Aabb-Max (or null VECTOR3))
  (check-type max-handles (or null integer)) 
  (setf (slot-value obj 'ff-pointer) 
        (cond
          ((and world-aabb-min world-aabb-max
                max-handles pair-cache dis?)
           (MAKE-32-BIT-AXIS-SWEEP-3 world-Aabb-Min world-Aabb-Max
                                     max-handles pair-cache
                                     disable-Raycast-Accelerator-p))
          ((and world-aabb-min world-aabb-max
                max-handles pair-cache (not dis?))
           (MAKE-32-BIT-AXIS-SWEEP-3 world-Aabb-Min world-Aabb-Max max-handles pair-cache))
          ((and world-aabb-min world-aabb-max
                max-handles (not pair-cache) (not dis?))
           (MAKE-32-BIT-AXIS-SWEEP-3 world-Aabb-Min world-Aabb-Max max-handles))
          ((and world-aabb-min world-aabb-max
                (not max-handles) (not pair-cache) (not dis?))
           (MAKE-32-BIT-AXIS-SWEEP-3 world-Aabb-Min world-Aabb-Max))
          (t (error 'foo)))))



