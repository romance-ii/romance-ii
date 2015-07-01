;;; -*- Mode: Lisp; Syntax: Common-Lisp; -*-

(in-package #.*simple-planners-package-name*)

;;; Copyright 2007 by Robert St. Amant.

;;; To download the code for the simple planners, visit
;;; <http://www.csc.ncsu.edu/faculty/stamant/simple-planners/simple-planners.html>.

;;; This software is released under the license described by Peter
;;; Norvig: <http://www.norvig.com/license.html>.  If you find this
;;; software useful, please send email to <stamant@csc.ncsu.edu>.

;;; About simple-data-structures.lisp:

;;; This file contains data structure definitions to support
;;; processing by each of the different planners.  There's lots of
;;; definition here, but not much that's really interesting.

;;; ==============================
;;; General purpose 

(defvar *plan-class* :unbound
  "The class of plans created and possibly manipulated during planning.")

(defun make-plan (&rest args)
  (apply #'make-instance *plan-class* args))

(defvar *action-class* 'propositional-action
  "The class of actions created and manipulated during planning.")

(defun make-action (&rest args)
  (apply #'make-instance *action-class* args))

;;; Actions, used by all planners

(defclass propositional-action ()
  ((name :accessor action-name :initarg :name)
   (precond :accessor action-precond :initarg :precond :initform nil)
   (effect :accessor action-effect :initarg :effect :initform nil)))

(defmethod action-applicable-p ((action propositional-action) state)
  "Test whether an action can be applied in a state."
  ;; Notice that this works if all negations are explicit in the
  ;; action precondition and the state, or if negations are implicit
  ;; in both, but it doesn't distinguish between these two cases.  It
  ;; will break if (not A) is present in the precondition and A is not
  ;; in the state.  I don't think any of the planners are subject to
  ;; this problem, though.
  (subsetp (action-precond action) state  :test #'literals-eql))

(defmethod apply-action ((action propositional-action) state)
  "For each literal in the effect of the action, remove its
  negation from the state and add it to the state."
  (union (set-difference state (mapcar #'negate (action-effect action))
			 :test #'literals-eql)
	 (action-effect action)
	 :test #'literals-eql))

(defmethod print-object ((action propositional-action) stream)
  (format stream "#<Action: ~A>" (action-print-name action)))

(defmethod action-print-name ((action propositional-action))
  (let ((name (action-name action)))
    (if (atom name)
	(format nil  "~:(~A~)" name)
	(format nil  "~:(~A~)~@[~A~]" (first name)
		(if (consp (first (rest name)))
		    (first (rest name))
		    (rest name))))))

;;; ==============================
;;; GraphPlan

;;; Planning graphs

(defvar *planning-graph-class* 'planning-graph)

(defclass planning-graph ()
  ((levels :accessor levels :initarg :levels)))

;;; Plans

(defclass gp-plan ()
  ((planning-graph :accessor planning-graph :initarg :planning-graph)
   (actions :initarg :actions)))

(defparameter *include-persistent-actions-p* nil)

(defmethod print-object ((the-plan gp-plan) stream)
  (with-slots (actions) the-plan
    (format stream "#<Plan: ~{[~{~A~^, ~}]~^; ~}>"
	    (mapcar #'(lambda (level)
			(mapcar #'action-print-name level))
		    (if *include-persistent-actions-p*
			actions
			(mapcar #'(lambda (action-list)
				    (remove-if #'action-persistent-p action-list))
				actions))))))

;;; simple-GP relies on the propositional-action class, but we add
;;; utilities for persistent actions.

(defun make-persistent-action (literal)
  (let ((l (list literal)))
    (make-action :name literal :precond l :effect l)))

(defmethod action-persistent-p ((the-action propositional-action))
  ;; Could use eq here for efficiency.
  (equal (action-precond the-action)
	 (action-effect the-action)))

;;; ------------------------------
;;; For testing plans by executing them

(defmethod actions ((the-plan gp-plan))
  ;; Any ordering appropriate for execution
  (with-slots (actions) the-plan
    (reduce #'append actions)))

;;; ==============================
;;; Specializations of simple-GP

;;; For the simple-GP-CSP planner:
(defclass CSP-planning-graph (planning-graph)
  ())

;;; For the simple-SAT planner:
(defclass SAT-planning-graph (planning-graph)
  ;; plan-object-table records the mapping between actions and SAT
  ;; variables, among other bookkeeping.
  ((plan-object-table :initform (make-hash-table :test #'equal))))

;;; ==============================
;;; Heuristic search planning

;;; Plans

(defclass HSP-plan ()
  ((state :accessor state  :initarg :state)
   (actions :accessor actions :initarg :actions)
   (cost :accessor plan-cost :initarg :cost :initform 0)))

(defmethod print-object ((the-plan hsp-plan) stream)
  (with-slots (actions) the-plan
    (format stream "#<Plan: ~{~A~^, ~}>"
	    ;; "#<Plan-~A: ~{~A~^, ~}>" (id plan) ; for debugging
	    (mapcar #'action-print-name actions))))

;;; ==============================
;;; Propositional partial-order planning

;;; Plans

(defclass propositional-pop-plan ()
  ((start :accessor plan-start :initarg :start :initform nil)
   (finish :accessor plan-finish :initarg :finish :initform nil)
   (steps :accessor plan-steps :initarg :steps :initform nil)
   (ordering :accessor plan-ordering :initarg :ordering :initform nil)
   (links :accessor plan-links :initarg :links :initform nil)
   (open :accessor plan-open :initarg :open :initform nil)))

(defun linearized-steps (plan)
  "Return the steps of the plan in some order."
  (sort (copy-list (plan-steps plan))
        #'(lambda (s1 s2)
            (step-less-p s1 s2 plan))))

;;; Plans print out with steps linearized, but are still
;;; partial-order, of course.
(defmethod print-object ((plan propositional-pop-plan) stream)
  (format stream "#<Plan: ~{~A~^, ~}>"
	  ;; "#<Plan-~A: ~{~A~^, ~}>" (id plan) ; for debugging
	  (mapcar #'step-print-name 
		  (find-all-if #'(lambda (step)
				   (real-step-p plan step))
			       (linearized-steps plan)))))

(defmethod real-step-p ((plan propositional-pop-plan) step)
  "Test whether step is not start or finish--'virtual' steps."
  (and (not (eql step (plan-start plan)))
       (not (eql step (plan-finish plan)))))

(defmethod real-plan-steps ((plan propositional-pop-plan))
  "Return all steps except start and finish."
  (find-all-if #'(lambda (step)
		   (real-step-p plan step))
	       (plan-steps plan)))

(defmethod copy-plan ((plan propositional-pop-plan))
  (make-instance *plan-class*
                 :start (plan-start plan)
                 :finish (plan-finish plan)
                 :steps (plan-steps plan)
                 :ordering (plan-ordering plan)
                 :links (plan-links plan)
                 :open (plan-open plan)))

;;; Steps

(defvar *step-class* 'propositional-step
  "The class of steps created and manipulated during partial-order planning.")

(defun make-step (action)
  (make-instance *step-class* :action action))

(defclass propositional-step ()
  ((action :accessor step-action :initarg :action)))

(defmethod step-print-name ((step propositional-step))
  (let ((name (step-name step)))
    (if (atom name)
	(format nil  "~:(~A~)" name)
	(format nil  "~:(~A~)~@[~A~]" (first name) (rest name)))))

(defmethod print-object ((step propositional-step) stream)
  (format stream "#<Step: ~A>" (step-print-name step)))

(defmethod step-name (step)
  (action-name (step-action step)))

(defmethod step-effect ((step propositional-step))
  (action-effect (step-action step)))

(defmethod step-precond ((step propositional-step))
  (action-precond (step-action step)))

;;; Ordering constraints

(defstruct (ordering (:type list)) before after)
(defun order (before after) (make-ordering :before before :after after))

(defun order-eql (ordering-1 ordering-2)
  (equal ordering-1 ordering-2))

;;; Causal links

(defstruct (link (:type list)) from to literal)
(defun link (from to literal) (make-link :from from :to to :literal literal))

;;; Open preconditions

(defstruct (open (:type list) (:constructor make-open-precond)) literal step)
(defun make-open (literal step) (make-open-precond :literal literal :step step))

;;; Threats

(defstruct (threat (:type list)) step link)
(defun threat (step link) (make-threat :step step :link link))

;;; ------------------------------
;;; For testing plans by executing them

(defmethod actions ((plan propositional-pop-plan))
  (mapcar #'step-action
	  (find-all-if #'(lambda (step)
			   (real-step-p plan step))
		       (linearized-steps plan))))

;;; ==============================
;;; First-order partial-order planning

(defvar *plan-bindings* nil             ; Support for printing
  "If this variable is bound to a set of bindings,
  steps within a plan are printed with their bindings
  rather than variable names.")

;;; Plans

(defclass pop-plan (propositional-pop-plan)
  ((bindings :accessor plan-bindings :initarg :bindings :initform +no-bindings+)
   (inequality-constraints :accessor plan-inequalities :initarg :inequalities :initform nil)))

(defmethod copy-plan :around ((plan pop-plan))
  (let ((copy (call-next-method)))
    (setf (plan-bindings copy) (plan-bindings plan))
    (setf (plan-inequalities copy) (plan-inequalities plan))
    copy))

(defmethod print-object ((plan pop-plan) stream)
  (declare (ignore stream))
  (let ((*plan-bindings* (plan-bindings plan)))
    (call-next-method)))

;;; Actions

(defclass first-order-action (propositional-action)
  ((parameters :accessor action-parameters :initarg :parameters :initform nil)))

(defmethod print-object ((action first-order-action) stream)
  (with-slots (name parameters) action
    (format stream "#<Action: ~A~@[~A~]>" name parameters)))

;;; Steps

(defclass first-order-step (propositional-step)
  ((variables :accessor step-variables :initarg :variables :initform nil)
   (inequality-constraints :accessor step-inequalities :initarg :inequalities :initform nil)
   (precond :accessor step-precond :initarg :precond :initform nil)
   (effect :accessor step-effect :initarg :effect :initform nil)))

(defparameter *pretty-step-variables* t)

(defmethod step-print-name ((step first-order-step))
  (let ((variables (if *pretty-step-variables*
		       (pretty-step-variables step)
		       (step-variables step))))
    (if variables
	(format nil  "~:(~A~)~@[~A~]" (step-name step) variables)
	(call-next-method))))

(defmethod pretty-step-variables ((step first-order-step))
  (let ((variables (step-variables step)))
    (loop for v in variables
       for p in (action-parameters (step-action step))
       for binding = (if *plan-bindings*
			 (subst-bindings *plan-bindings* v)
			 v)
       collect (if (variable-p binding)
		   p
		   binding))))

;;; ------------------------------
;;; For testing plans by executing them

(defmethod actions ((plan pop-plan))
  ;; We need to create actions in which all variables are bound.
  (let* ((steps (find-all-if #'(lambda (step)
				 (real-step-p plan step))
			     (linearized-steps plan)))
	 (bindings (plan-bindings plan)))
    (mapcar #'(lambda (step)
		(make-instance 'propositional-action
			       :name (action-name (step-action step))
			       :precond (subst-bindings bindings (step-precond step))
			       :effect (subst-bindings bindings (step-effect step))))
	    steps)))

;;; ==============================
;;; EOF