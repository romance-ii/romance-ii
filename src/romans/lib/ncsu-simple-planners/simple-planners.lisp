;;; -*- Mode: Lisp; Syntax: Common-Lisp; -*-

(in-package #.*simple-planners-package-name*)

;;; Copyright 2007-2010 by Robert St. Amant and Stephen G. Ware.

;;; To download the code for the simple planners, visit
;;; <http://www.csc.ncsu.edu/faculty/stamant/simple-planners/simple-planners.html>.

;;; This software is released under the license described by Peter
;;; Norvig: <http://www.norvig.com/license.html>.  If you find this
;;; software useful, please send email to <stamant@csc.ncsu.edu>.

;;; About simple-planners.lisp:

;;; This code is intended to provide a relatively consistent
;;; functional interface to all simple planners.  Consistency is
;;; imposed in the form of a basic-planner class that all 'real'
;;; planner classes are expected to inherit. Four methods for
;;; basic-planner are defined:

;;;   PLAN is the top-level method by which all planners can be
;;;   invoked.  It takes an instance of a planner, a problem, and a
;;;   domain as arguments, along with any other keyword arguments that
;;;   specific planners may accept.

;;;   RUN-PLAN is a method that a 'real' planner must define.  It
;;;   takes as arguments the planner instance, a list of literals
;;;   representing the initial state of a problem, the goal for the
;;;   problem, and a list of actions that the planner can apply.  As
;;;   with the plan method, additional arguments are passed through.

;;;   GENERATE-ACTIONS takes a PDDL representation of the set of
;;;   actions for a domain and converts it into a list of instances of
;;;   an action class (*action-class*) appropriate for the planner.
;;;   For some planners (the POP planners), the conversion is
;;;   one-to-one; the other planners propositionalize actions by
;;;   exhaustively substituting objects for variables.

;;;   INITIALIZE-STATE takes a PDDL representation of the initial
;;;   state for a problem and converts it into a list of literals.
;;;   For some planners (the POP planners, which rely on the closed
;;;   world assumption), the initial state is passed through
;;;   unchanged.  The other planners call the method close-world to
;;;   add negated literals to the initial state, using information
;;;   from the goal state and in some cases from the effects of
;;;   actions.

;;; Each of 'real' planners may supply a value for the instance
;;; variable planner-bindings in basic-planner.  This is a list of
;;; bindings for dynamic variables to control the specific classes to
;;; be instantiated by a given planner.  For example, simple-GP binds
;;; *planning-graph-class* to planning-graph, while simple-GP-CSP
;;; binds that variable to CSP-planning-graph, in order to support a
;;; different method for solution extraction.

;;; Except for the simple-POP planners, all of the planner classes
;;; inherit propositional-preprocessor, also defined in this file.
;;; The generate-actions method of this class converts actions with
;;; variables into propositional actions; the initialize-state method
;;; adds negated literals to the initial state, based on the goal of a
;;; problem, the effects of actions in the domain, or both.

;;; ==============================
;;; Definitions

(defvar *global-planner-bindings*
  '((*variable-prefix-char* #\?)))	; AIMA compatibility

(defvar *actions* :unbound
  "Some planners find it convenient to have global access to the
 set of actions defined for a given domain.  *actions* is bound
 in the plan method, but may also be bound (redundantly) in other
 functions or methods specific to a given planner.")

;;; ==============================
;;; A basic class for planners, not intended to be instantiated alone.

(defclass basic-planner ()
  ((planner-bindings :accessor planner-bindings :initarg :planner-bindings :initform nil
		   :documentation "An alist of bindings for *plan-class*,
		    *action-class*, etc., specific to a planner.")))

(eval-when (:compile-toplevel :load-toplevel :execute)
(defmacro with-planner-bindings (planner &body body)
  (let ((planner-var (gensym))
	(bindings-var (gensym))) 
    `(let* ((,planner-var ,planner)
	    (,bindings-var (append *global-planner-bindings* (planner-bindings ,planner-var))))
       (progv		 ; Bind dynamic class variables appropriately.
	   (mapcar #'first ,bindings-var)
	    (mapcar #'second ,bindings-var)
	 ,@body)))))

(defmethod plan ((the-planner basic-planner) problem &rest rest &key domain &allow-other-keys)
  (with-planner-bindings the-planner
    (let* ((problem (PDDL-problem problem domain))
	   (goal (PDDL-problem-goal problem))
	   (*actions* (generate-actions the-planner (domain-action-forms domain) problem))
	   (initial-state (initialize-state the-planner (PDDL-problem-init problem) goal *actions*)))
      (apply #'run-planner the-planner initial-state goal *actions* rest))))

(defmethod run-planner ((the-planner basic-planner) init goal actions &rest rest &key &allow-other-keys)
  (declare (ignore init goal actions rest))
  (error "A run-planner method must be supplied for ~A." the-planner))

(defmethod generate-actions ((the-planner basic-planner) action-forms problem)
  (declare (ignore problem))
  (mapcar #'(lambda (action-form)
	      (apply #'make-action :allow-other-keys t action-form))
	  action-forms))

(defmethod initialize-state ((the-planner basic-planner) initial-state goals actions)
  (declare (ignore goals actions))
  initial-state)

;;; ==============================
;;; Action and initial state preprocessing for planning with propositions only

(defclass propositional-preprocessor ()
  ())

;;; Translate first-order actions into propositions, by binding each
;;; parameter of each action to known objects, in all combinations.

(defmethod generate-actions ((the-preprocessor propositional-preprocessor) action-forms problem)
  (let ((objects (PDDL-problem-objects problem)))
    (loop for action-form in action-forms
       if (getf action-form :parameters)
       append (propositionalize-action action-form objects)
       else collect (apply #'make-action :allow-other-keys t action-form))))

(defmethod propositionalize-action (action-form objects)
  (let ((name (getf action-form :name))
	(parameters (getf action-form :parameters))
	(precond (getf action-form :precond))
	(effect (getf action-form :effect)))
    (multiple-value-bind (neq-list remaining-precond)
	(bipartition-if #'inequalityp precond)
      (let ((inequalities (mapcar #'make-neq neq-list)))
	(loop for bindings in (all-bindings-list parameters objects)
	   when (valid-bindings-p bindings inequalities)
	   collect (make-action :name (propositionalized-action-name name bindings)
				:precond (sublis bindings remaining-precond)
				:effect (sublis bindings effect)))))))

(defun all-bindings-list (variables values &optional (bindings-list (list nil)))
  (if (null variables)
      bindings-list
      (apply #'append
	     (mapcar #'(lambda (bindings)
			 (mapcar #'(lambda (value)
				     (cons (make-binding (first variables) value)
					   bindings))
				 values))
		     (all-bindings-list (rest variables)
					values bindings-list)))))

(defun propositionalized-action-name (name bindings)
  (list name (mapcar #'binding-val bindings)))

;;; Create an appropriate initial state.  The Closed World Assumption
;;; (CWA) states that all facts not explicitly true are false.
;;; simple-SAT needs all of these assumed false facts to the initial
;;; state to avoid generating axioms which are impossible to satisfy.
;;; The other planners need this in case negated literals are in a
;;; problem goal.

(defun close-world (initial-state goals actions &key (closure '(:goal :actions)))
  "Add to some initial state all relevant false facts.  A relevant
   fact is one which appears (true or false) in the goal state or in
   any of the preconditions of the domain's actions."
  (let ((all-facts initial-state))
    (flet ((add-negation (fact)
	     ;; If the fact is not true, add its negation to the
	     ;; initial state.
	     (cond ((negated-literal-p fact)
		    (unless (member (negate fact) all-facts :test #'literals-eql)
		      (push fact all-facts)))
		   (t (unless (member fact all-facts :test #'literals-eql)
			(push (negate fact) all-facts))))))
      (when (member :goal closure)
	(dolist (goal goals)
	  (add-negation goal)))
      (when (member :actions closure)
	(dolist (action actions)
	  (dolist (fact (union (action-precond action) (action-effect action)))
	    (add-negation fact))))
      ;; Return the closed initial state, minus duplicates
      (remove-duplicates all-facts :test #'literals-eql))))

(defmethod initialize-state ((preprocessor propositional-preprocessor) initial-state goals actions)
  (close-world initial-state goals actions))

;;; ==============================
;;; Testing planners

;;; This is a quick hack.

(defun run-planner-tests (planner problems-and-domains &rest rest
			  &key (exclude-problems nil) (executep t) (messagep t) (verbosep nil) (errorp nil)
			  &allow-other-keys)
  (loop for (problem domain) in (remove-if #'(lambda (problem-and-domain)
					       (member (first problem-and-domain)
						       exclude-problems))
					   problems-and-domains)
     for plan = (apply #'plan planner problem :domain domain rest)
     do (when messagep
	  (format t "~2&Planner: ~A.~&Problem: ~A in domain ~A.~&Plan:   ~A."
		  (type-of planner) problem domain plan)
	  (when (and plan executep)
	    (run-plan plan problem :domain domain :messagep messagep :verbosep verbosep :errorp errorp)))))

;;; ------------------------------
;;; Testing plans

;;; This is also a quick hack.

(defun run-plan (plan problem &key domain (messagep t) (verbosep t) (errorp nil))
  (let* ((problem-object (PDDL-problem problem domain))
	 (goal (PDDL-problem-goal problem-object))
	 (state (close-world (PDDL-problem-init problem-object) goal (actions plan)
			     :closure '(:goal :actions)))
	 (success t))
    (when verbosep
      (format t "~&State: ~A.~&Goal:  ~A.~&Plan:  ~A." state goal plan))
    (dolist (action (actions plan))
      (cond ((action-applicable-p action state)
	     (when verbosep
	       (format t "~&Executing ~A in state ~A." action state))
	     (setf state (apply-action action state)))
	    (t
	     (setf success nil)
	     (cond (errorp
		    (error "~&~A failed in state ~A." action state))
		   (verbosep
		    (format t "~&~A failed in state ~A." action state))))))
    (unless (subsetp goal state :test #'literals-eql)
      (setf success nil))
    (when messagep
      (if success
	  (format t "~&*** Execution successful, goal achieved.")
	  (format t "~&*** ~A failed." plan)))
    success))

;;; ------------------------------
;;; Run me.

#+testing
(progn
  (run-planner-tests (make-instance 'propositional-POP-planner)
		     *propositional-problems-and-domains*
		     :exclude-problems '(change-rooms start-to-finish))

  (run-planner-tests (make-instance 'POP-planner)
		     (append *propositional-problems-and-domains*
			     *first-order-problems-and-domains*)
		     :exclude-problems '(change-rooms start-to-finish back-and-forth))

  (run-planner-tests (make-instance 'GP-planner)
		     (append *propositional-problems-and-domains*
			     *first-order-problems-and-domains*))

  (run-planner-tests (make-instance 'GP-CSP-planner)
		     (append *propositional-problems-and-domains*
			     *first-order-problems-and-domains*))

  (run-planner-tests (make-instance 'SAT-planner)
		     (append *propositional-problems-and-domains*
			     *first-order-problems-and-domains*))

  (run-planner-tests (make-instance 'HSP-planner)
		     (append *propositional-problems-and-domains*
			     *first-order-problems-and-domains*)))

;;; ==============================
;;; EOF