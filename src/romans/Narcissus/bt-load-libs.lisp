(in-package :bullet-physics)
(format *trace-output* "~&Loading Bullet Physics C libraries: ")
(mapcar (lambda (n)
          (format *trace-output* "Loading ~A…" n)
          (cffi:load-foreign-library
           (merge-pathnames
            (format nil "lib/cl-bullet2l/lib~A.so" n)))
          (format *trace-output* "OK; "))
        '("LinearMath"
          "BulletCollision" "BulletDynamics"
          "BulletSoftBody"
          "cl-bullet2l"))
(format *trace-output* " (Done.) ")
(eval-when (:compile-toplevel)
  (close *compile-trace-output*)
  (setf *compile-trace-output* nil))
