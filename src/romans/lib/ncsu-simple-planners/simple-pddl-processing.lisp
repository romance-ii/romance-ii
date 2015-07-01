;;; -*- Mode: Lisp; Syntax: Common-Lisp; -*-

(in-package #.*simple-planners-package-name*)

;;; Copyright 2007 by Robert St. Amant.

;;; To download the code for the simple planners, visit
;;; <http://www.csc.ncsu.edu/faculty/stamant/simple-planners/simple-planners.html>.

;;; This software is released under the license described by Peter
;;; Norvig: <http://www.norvig.com/license.html>.  If you find this
;;; software useful, please send email to <stamant@csc.ncsu.edu>.

;;; About simple-pddl-processing.lisp:

;;; This is a minimal implementation supporting the definition of
;;; domains and problems in PDDL form.  It is minimal in the sense
;;; that from a given domain or problem definition, only a few pieces
;;; of information are extracted and processed.  For domains, only
;;; :ACTION forms are handled; :requirements, :types, :constants, and
;;; :predicates are all ignored.  For problems, only :objects, :init,
;;; and :goal forms are handled.

;;; There is only the most cursory error testing in these macros and
;;; functions.

;;; One area to be careful in the use of this code is in :goal forms
;;; in problems as well as :precond and :effect forms in actions.
;;; Simple-POP and simple-GP assume that all of these forms are lists
;;; that represent implicit conjunctions.  For consistency with PDDL,
;;; such forms can be either single literals, such as X, or explicit
;;; conjunctions of the form (AND X Y. . .).  The function
;;; implicit-conjunction translates such forms into lists: in the
;;; examples above, (X) or (X Y).  No analysis or error checking is
;;; carried out.

;;; ==============================
;;; Top-level macro

(eval-when (:compile-toplevel :load-toplevel :execute)
(defmacro define ((key name) &body forms)
  (case key
    (domain
     `(add-domain ',name ',(extract-action-forms forms)))
    (problem
     `(add-problem ',name ',forms)))))

;;; ==============================
;;; Domain processing

(defvar *domains* (make-hash-table))

(defun add-domain (name action-forms)
  (setf (gethash name *domains*) action-forms)
  name)

(defun domain-p (name)
  (gethash name *domains*))

(defun remove-domain (name)
  (remhash name *domains*)
  nil)

(defun domain-action-forms (name)
  (gethash name *domains*))

(defun extract-action-forms (list)
  (loop for (key . args) in list
     if (eq key :action)
     collect (list :name (first args)
		   :parameters (getf (rest args) :parameters)
		   :precond (make-implicit-conjunction (or (getf (rest args) :precond)
							   (getf (rest args) :precondition)))
		   :effect (make-implicit-conjunction (getf (rest args) :effect)))
     else do (format t "Ignoring ~S and arguments.~%" key)))

(defun make-implicit-conjunction (form)
  (cond ((null form) nil)
	((and (listp form) (eq (first form) 'AND))
	 (rest form))
	(t (list form))))

(defun make-explicit-conjunction (form)
  `(and ,@form))

;;; ==============================
;;; Problem processing

(defclass PDDL-problem ()
  ((objects :accessor PDDL-problem-objects :initarg :objects :initform nil)
   (init :accessor PDDL-problem-init :initarg :init)
   (goal :accessor PDDL-problem-goal :initarg :goal)))

(defvar *problems* (make-hash-table))

(defun add-problem (name alist)
  (let ((domain (second (assoc :domain alist)))
	(goal (make-implicit-conjunction (second (assoc :goal alist))))
	(objects (rest (assoc :objects alist)))
	(init (rest (assoc :init alist))))
    (assert (domain-p domain)) 
    (let ((problem (make-instance 'PDDL-problem :objects objects :init init :goal goal))
	  (problem-entry (assoc domain (gethash name *problems*))))
      (if problem-entry
	  (setf (cdr problem-entry) problem)
	  (push (cons domain problem) (gethash name *problems*)))
      problem)))

(defun PDDL-problem (name domain-name)
  (cdr (assoc domain-name (gethash name *problems*))))

;;; ==============================
;;; EOF