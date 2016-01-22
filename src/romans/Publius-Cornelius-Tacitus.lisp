(defpackage :publius-cornelius-tacitus
  (:nicknames :tacitus)
  (:documentation "Publius Cornelius Tacitus, or  Gaius Cornelius Tacitus (born ad 156 — died  c. 120), Roman orator and
  public  official,  probably  the  greatest historian  and  one  of  the  greatest  prose  stylists who  wrote  in  the
  Latin language.

The Tacitus package produces the TexInfo documentation from the Lisp source code.")
  (:export #:make-documentation)
  (:use :cl :alexandria))

(in-package :tacitus)

(defvar *seen*)

(defgeneric make-node-name (node))
(defgeneric node-title (node))

(defmethod make-node-name ((node asdf/lisp-action:cl-source-file))
  (concatenate 'string "source-" (slot-value node 'name)))

(defmethod make-node-name ((node asdf/component:module))
  (concatenate 'string "component-" (slot-value node 'name)))

(defmethod make-node-name ((node asdf/lisp-action:cl-source-file))
  (concatenate 'string "Source file " (slot-value node 'name)))

(defmethod make-node-name ((node asdf/component:module))
  (concatenate 'string "System Module " (slot-value node 'name)))

(defun print-menu (children)
  (format t "
@menu ~{~%* ~a:: ~a~}
@end menu~2%"
          (mapcar (lambda (child)
                    (list (make-node-name child) (node-title child)))
                  children)))

(defun print-doc-preamble ()
  (format t "@chapter Romance Software System Reference

The following  is the  extracted on-line documentation  contained within
the Romance II software itself.

") 
  (print-menu (slot-value (asdf:find-system :romance-ii) 
                          'asdf::children)))

(defun replace-string (before after string &key (start 0))
  (if (>= start (length string))
      string
      (if-let ((found (search before string :start2 start)))
        (replace-string before after
                        (replace string after
                                 :start1 found :end1 (+ found (length before)))
                        :start (+ found (length after)))
        string)))

(defun texinfo (string)
  (loop for (before after) in '()
     do (setf string (replace-string before after string))))

(defun print-asdf-system-dependencies (system)
  (format t "@subsystem Dependencies

This system depends upon the following other ASDF systems:

@menu~{
 * ~a:: @code{~/tacitus:texinfo/}: ~/tacitus:texinfo/
~}
@end menu"
          (mapcar (lambda (dependency)
                    (list (make-node-name dependency)
                          (slot-value dependency 'asdf::name)
                          (node-title dependency)))
                  (asdf:system-depends-on system))))

(defun print-asdf-metadata (system)
  (format t "@subsystem About this System

@table
~@[@item Author
~/tacitus:texinfo/
~]~@[@item Maintainer
~/tacitus:texinfo/
~]~@[@item License
~/tacitus:texinfo/
~]~@[@item E-mail
~/tacitus:texinfo/
~]~@[@item Home page
~/tacitus:texinfo/
~]~@[@item Bug Tracker
~/tacitus:texinfo/
~]
@end table

"
          (mapcar (rcurry #'funcall system)
                  '(asdf:system-author asdf:system-maintainer
                    asdf:system-license asdf:system-mailto
                    asdf:system-homepage asdf:system-bug-tracker))))

(defun document-asdf-system (system)
  (format t "@section System ~/tacitus:texinfo/

~/tacitus:texinfo/
"
          (asdf:system-long-name)
          (or (asdf:system-long-description system)
              (asdf:system-description system)))
  (print-asdf-system-dependencies))

(defun print-doc-postlude ())

(defun make-documentation ()
  (with-output-to-file (*standard-output*
                        (make-pathname :defaults romans-compiler-setup:*path/r2project*
                                       :directory '(:relative "doc") 
                                       :name "generated" :type "texinfo")
                        :if-exists :supersede)
    (let ((*seen* nil))
      (print-doc-preamble)
      (document-asdf-system (asdf:find-system :romance-ii))
      (print-doc-postlude))))


