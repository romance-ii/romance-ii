(in-package :bullet-physics)
(defparameter *compile-trace-output* nil)
#+trace-bullet-compile
(eval-when (:compile-toplevel)
  (setf *compile-trace-output* (open "Bullet-Physics-Wrapper-mapping.log"
                                     :direction :output
                                     :if-exists :supersede)))

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
  (when *compile-trace-output*
      (close *compile-trace-output*)
      (setf *compile-trace-output* nil)))

