(asdf:defsystem :cl-bullet2l
  :description "Bullet Physics 2 Common Lisp bindings"
  :author "Bruce-Robert Fenn Pocock"
  :licence "Bullet"

  :depends-on (:alexandria :cffi)

  :encoding :utf-8

  :components
  ((:file "bullet-package")
   (:file "bt-classes")
   (:file "bt-structs")
   (:file "bt-generics")
   (:file "bt-param")
   (:file "bt-collision-object")
   (:file "bt-vector34")
   (:file "bt-matrix3x3")
   (:file "bt-dynamics-world")
   (:file "bt-rigid-body")
   (:file "bt-shapes")
   (:file "bt-wrap-a")
   (:file "bt-wrap-b")
   (:file "bt-wrap-c") 
   (:file "bt-wrap-d")
   (:file "bt-wrap-e")
   (:file "bt-wrap-f")
   (:file "bt-wrap-g")
   (:file "bt-load-libs")))

