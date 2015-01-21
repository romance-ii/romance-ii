(in-package :romans)

;; flow control convenience functions

(defmacro until (test &body body)
  `(do () (,test) ,@body))

(defmacro while (test &body body)
  `(do () ((not ,test)) ,@body))

(defmacro doseq ((element sequence) &body body)
  `(loop for ,element across ,sequence do (progn ,@body)))

(defmacro any (predicate sequence)
  `(notevery (complement ,predicate) ,sequence))


(defmacro forever (&body body)
  (let* ((block-tag (if (symbolp (first body))
                        (first body)
                        'forever))
         (loop-tag (gensym block-tag)))
    `(block ,block-tag
       (tagbody
          ,loop-tag
          ,@body
          (go ,loop-tag)))))


(defmacro eval-once (form)
  `(let ((v ',(gensym "ONCE")))
     (if (boundp v)
         (symbol-value v)
         (set v ,form))) )

(defmacro without-warnings (&body body)
  `(handler-bind
       ((warning #'muffle-warning))
     ,@body))



(defmacro modincf (place base)
  "Increment a setf'able place, and return true whenever it wraps
around modulo base.

Put in a more sane way: return true every `base' times it is called
with the same `place'"
  `(zerop (setf ,place (mod (1+ ,place) ,base))))

(defun make-t-every-n-times (base)
  "Returns a function which, every \"N\" times that it is called,
  returns true."
  (let ((private 0))
    (lambda ()
      (modincf private base))))




(define-condition todo-item (error)
  ((note :initarg :note :reader todo-note)))

(defmethod todo (&optional (string "TODO: This function is not yet implemented")
                 &rest keys)
  (restart-case
      (error 'todo-item :note (apply #'format string whinge))
    (return-nil ()
      :report (lambda (s)
                (format s "Return NIL"))
      nil)
    (return-t ()
      :report (lambda (s)
                (format s "Return T"))
      t)
    (return-value (value)
      :report (lambda (s)
                (format s "Return some other value"))
      value)))




(defun strings-list-p (list)
  (and (consp list)
       (every #'stringp list)))

(deftype strings-list ()
  '(satisfies string-list-p))
