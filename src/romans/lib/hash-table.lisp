(in-package :romans)

(defmacro |hash| ((&rest params) plist-or-alist)
  `(let ((h (make-hash-table ,@params))) 
     ,(if (and (consp (car plist-or-alist))
               (atomp (cdr (car plist-or-alist))))
          ;; let's assume it's an alist
          (loop for (key . value) in plist-or-alist
             collecting `(setf (gethash ,key h) ,value))
          ;; plist
          (loop for (key value) in plist-or-alist :by #'cddr
             collecting `(setf (gethash ,key h) ,value)))))
