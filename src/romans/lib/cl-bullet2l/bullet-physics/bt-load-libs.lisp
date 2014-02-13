(in-package :bullet-physics)

(defvar *c++-libs-loaded* nil)
(defun load-c++-libraries (&aux errors)
  (format *trace-output* "~&Loading Bullet Physics C libraries: ")
  (mapcar (lambda (lib-name)
            (if (member lib-name *c++-libs-loaded* :test 'equal)
                (format *trace-output* "Already loaded ~A; " lib-name)
                (let ((lib 
                       (handler-bind
                           (#+sbcl
                            (SB-KERNEL:UNDEFINED-ALIEN-STYLE-WARNING
                             (lambda (c)
                               (format *trace-output* "Undefined alien: ~S" c)
                               (muffle-warning) t))
                            (error 
                                 (lambda (c)
                                   (warn "~A" c)
                                   (push c errors)
                                   nil)))
                             (format *trace-output* "Loading ~A…" lib-name)
                             (cffi:load-foreign-library
                              ;; TODO: +LIBDIR+
                                 (merge-pathnames
                                  (format nil "lib/cl-bullet2l/lib~A.so" lib-name))))))
                  (when lib (pushnew lib-name *c++-libs-loaded* :test 'equal))
                  (format *trace-output* "~:[FAILED!~;OK~]; " lib))))
            '("LinearMath"
              "BulletCollision" "BulletDynamics"
              "BulletSoftBody"
              "cl-bullet2l"))
          (format *trace-output* " (Done.) Loaded ~R library file~:P. "
                  (length *c++-libs-loaded*))
  (values *c++-libs-loaded*
          errors))

