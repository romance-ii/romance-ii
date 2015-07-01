;;; -*- Mode: Lisp; Syntax: Common-Lisp; -*-

(in-package #.*simple-planners-package-name*)

;;; Copyright 2007 by Robert St. Amant.

;;; To download the code for the simple planners, visit
;;; <http://www.csc.ncsu.edu/faculty/stamant/simple-planners/simple-planners.html>.

;;; This software is released under the license described by Peter
;;; Norvig: <http://www.norvig.com/license.html>.  If you find this
;;; software useful, please send email to <stamant@csc.ncsu.edu>.

;;; About simple-pop.lisp:

;;; This code builds on the GPS and search code in Peter Norvig's
;;; Paradigms of Artificial Intelligence Programming (PAIP), in order
;;; to illustrate the development of a propositional partial-order
;;; planner as described in Chapter 11 of Stuart Russell and Peter
;;; Norvig's Artificial Intelligence: A Modern Approach, 2nd edition
;;; (AIMA).  While other Lisp planners are available, such as UCPOP,
;;; they're too complex to present easily in a class.  The code for
;;; simple-POP is intended to be as straightforward as possible, with
;;; efficiency and functionality taking a backseat to clarity.

;;; The main function is simple-POP, which takes as arguments an
;;; initial world state, a comparable goal state, and a list of
;;; actions.  The most convenient way to invoke this planner, however,
;;; is via a call to PLAN, which handles access to specific problems
;;; and domains:

#||
(define (domain flat-tire)
  (:action (remove spare trunk) 
	   :precond (at spare trunk)
	   :effect (and (not (at spare trunk)) (at spare ground))) 
  (:action (remove flat axle) 
	   :precond (at flat axle)
	   :effect (and (not (at flat axle)) (at flat ground)))
  (:action (puton spare axle)
	   :precond (and (at spare ground) (not (at flat axle)))
	   :effect (and (not (at spare ground)) (at spare axle)))
  (:action leaveovernight 
	   :effect (and (not (at spare ground)) (not (at spare axle)) (not (at spare trunk))
			(not (at flat ground)) (not (at flat axle)))))

(define (problem fix-flat)
    (:domain flat-tire)
  (:init (at flat axle) (at spare trunk))
  (:goal (at spare axle)))

(plan (make-instance 'propositional-POP-planner) 'fix-flat :domain 'flat-tire)
||#
;;; PLAN calls RUN-PLANNER, defined below.  RUN-PLANNER-TESTS is a
;;; testing function overall all the domains this planner can handle.

;;; The code for simple-POP has been structured to follow AIMA's
;;; discussion as closely as I could manage.  There's some abstraction
;;; in the code that's not strictly necessary, but this is intended to
;;; support extension to partial-order planning with variable
;;; bindings.  There are a few superfluous named data structures
;;; defined, to make it clear what's being passed around between the
;;; functions.

;;; Implementation note: Plans maintain four lists: steps, ordering
;;; [constraints], [causal] links, and open [preconditions].  The only
;;; modification operation on steps, ordering, and links is to push
;;; new elements onto them.  This means that these lists can share
;;; structure across plans.  Because elements are removed from open,
;;; however, structure cannot be shared.  This is managed in a lazy
;;; fashion: remove (a non-destructive function) is used in
;;; add-plan-link; an alternative would have been to use copy-list on
;;; the open instance variable in copy-plan.

;;; ==============================
;;; Planner definition

(defclass propositional-POP-planner (basic-planner)
  ()
  (:default-initargs
   :planner-bindings '((*action-class* propositional-action)
		       (*step-class* propositional-step)
		       (*plan-class* propositional-pop-plan))))

(defmethod run-planner ((the-planner propositional-POP-planner) init goal actions
			&rest rest &key &allow-other-keys)
  "Extract the initial state, goal, and actions from a problem
  and pass them as arguments to simple-POP."
  (apply #'simple-POP init goal actions :allow-other-keys t rest))

#+testing
(run-planner-tests (make-instance 'propositional-POP-planner)
		   *propositional-problems-and-domains*
		   :exclude-problems '(change-rooms start-to-finish))

;;; ==============================
;;; Top-level planning function

(defun simple-POP (initial goal actions &key
		   (plan-cost #'(lambda (plan)
				  ;; Prefer shorter plans.
				  (length (plan-steps plan)))))
  (let ((*actions* actions))	       ; Redundant if called by 'plan'
    ;; See aima-compatibility.lisp for definition
    (simple-search (make-minimal-plan initial goal)
		   #'plan-solution-p
		   #'plan-successors
		   plan-cost)))

;;; ==============================

;;; I. "The initial plan contains Start and Finish, the ordering
;;; constraint Start < Finish, and no causal links and has all the
;;; preconditions in Finish as open preconditions."  [AIMA, p. 390]

(defmethod make-minimal-plan (initial goal)
  (let ((start (make-step (make-action :name :start
				       :precond nil
				       :effect initial)))
        (finish (make-step (make-action :name :finish
					:precond goal
					:effect nil))))
    (make-plan :start start
               :finish finish
               :steps (list start finish)
               :open (open-preconds finish)
               :ordering (list (order start finish)))))

(defun open-preconds (step)
  (mapcar #'(lambda (p)
              (make-open p step))
          (step-precond step)))

;;; ==============================
;;; Quoted from AIMA, p. 390, annotated with simple-POP [function names].

;;; "II. The successor function [plan-successors] arbitrarily picks
;;; one open precondition p on an action B [choose-open-precond] and
;;; generates a successor plan for every possible consistent way of
;;; choosing an action A [steps-for-precond] that achieves p.
;;; Consistency is enforced as follows [plan-consistent-p]:

;;; "1. The causal link A ->p B and the ordering constraint A < B are
;;; added to the plan [add-plan-link].  Action A may be an existing
;;; action in the plan or a new one.  If it is new, add it to the plan
;;; and also add Start < A and A < Finish [add-plan-step].

;;; "2. We resolve conflicts between the new causal link and all
;;; existing actions and between the action A (if it is new) and all
;;; existing causal links [plan-threats].  A conflict between A ->p B
;;; and C is resolved by making C occur at some time outside the
;;; protection interval, either by adding B < C or C < A.  We add
;;; successor states for either or both if they result in consistent
;;; plans [resolve-threat]."

(defmethod choose-open-precond (plan)
  "Return an arbitrary open precondition.  Defaults to #'first."
  ;; AIMA proposes various heuristics for choosing a good open
  ;; precondition to achieve.  See the extended comment at the end of
  ;; simple-pop-with-bindings.lisp for an example.
  (first (plan-open plan)))

(defmethod plan-successors (plan)
  "Return a list of successor plans."
  (let ((open-precond (choose-open-precond plan))
        (successors nil))
    (dolist (candidate-step (steps-for-precond plan open-precond))
      (multiple-value-bind (successor new-link)
	  (add-plan-link plan candidate-step open-precond)
	(setf successors
	      (append (resolve-threats (plan-threats successor
						     candidate-step
						     new-link)
				       successor)
		      successors))))
    (find-all-if #'plan-consistent-p successors)))

(defmethod plan-threats (plan new-step new-link)
  "Return a list threats in a plan."
  (let ((threats nil))
    ;; Threat possibility: new step versus existing link.
    (dolist (link (plan-links plan))
      (awhen (threatens-link-p plan new-step link)
	(push it threats)))
    ;; Threat possibility: New link versus existing step.
    (dolist (step (plan-steps plan))
      (awhen (threatens-link-p plan step new-link)
	(push it threats)))
    threats))

(defmethod steps-for-precond (plan open-precond)
  "Build a list of steps that can achieve some precondition.
  Some of these may be in the plan; others are taken from the
  global action list and converted into steps.  Since we're
  working with propositions, action effects and step effects are
  treated similarly."
  (flet ((achieves-precond-p (step)
           (member (open-literal open-precond) (step-effect step)
                   :test #'literals-eql)))
    (find-all-if #'achieves-precond-p
                 (append (plan-steps plan) (mapcar #'make-step *actions*)))))

(defmethod add-plan-link (plan step open-precond)
  "Return a plan with a new causal link between step and the step
  associated with the open precond, which is removed, plus
  appropriate ordering constraints.  Mainly bookkeeping."
  (let ((new-plan (copy-plan plan))
	(link (link step
                    (open-step open-precond)
                    (open-literal open-precond))))
    (when (not (step-in-plan-p step new-plan))
      ;; Unless the step is already in the plan, add it.
      (add-plan-step new-plan step))
    (push link (plan-links new-plan))
    ;; There may already be an appropriate ordering.
    (pushnew (order step (open-step open-precond))
             (plan-ordering new-plan)
             :test #'order-eql)
    (setf (plan-open new-plan) (remove open-precond (plan-open new-plan)))
    (values new-plan link)))

(defmethod step-in-plan-p (step plan)
  (member step (plan-steps plan)))

(defmethod add-plan-step (plan step)
  "Add the step to plan-steps; order it between start and finish;
  add its preconditions as being open."
  (push step (plan-steps plan))
  (push (order (plan-start plan) step) (plan-ordering plan))
  (push (order step (plan-finish plan)) (plan-ordering plan))
  (setf (plan-open plan) (append (open-preconds step) (plan-open plan)))
  step)

(defmethod threatens-link-p (plan step link)
  "Return a threat, if the precondition identified in the link is
  threatened by some condition in the effect of the step."
  ;; UCPOP caches threatened (unsafe) links in a plan.  This would be
  ;; a useful modification.
  (when (and (not (or (step-less-p step (link-from link) plan)
                      (step-less-p (link-to link) step plan)))
             (some #'(lambda (p)
                       ;; Assume no forms (not (not X))
		       (literals-negate-p p (link-literal link)))
                   (step-effect step)))
    (threat step link)))

(defmethod plan-consistent-p (plan)
  "Check plan for the absence of ordering cycles and threats."
  (and
   ;; No cycles in the ordering constraints.
   (not (ordering-cycle-p (plan-steps plan) (plan-ordering plan)))
   ;; No unresolved threats for any step/link combination.
   (not (some #'(lambda (step)
                  ;; Does this step threaten *any* link?
                  (some #'(lambda (link)
                            ;; Does this step threaten *this* link?
                            (threatens-link-p plan step link))
                        (plan-links plan)))
              (plan-steps plan)))))

(defun ordering-cycle-p (steps ordering)
  "Treat ordering constraints as arcs in a DAG.  For each of the
  n steps--on each end of a constraint--perform a DFS (ignoring
  graph structure) to see if the same step can be reached in 1 <
  k < n traversals.  The depth bound on the search prevents
  infinite recursion."
  (let ((n (length steps)))
    (some #'(lambda (step)
              (bounded-dfs step step    ; Unintuitive but okay
                           #'(lambda (s)
                               (step-successors s ordering))
                           n
                           ;; Optional test of goal depth: disallow
                           ;; goals at the root.
                           (complement #'zerop)))
          steps)))

(defun step-successors (step ordering)
  "Return the steps that come after step in the ordering.
  This could be made more efficient."
  (mapcar #'ordering-after
          (find-all step ordering :key #'ordering-before)))

(defmethod resolve-threats (threats plan)
  "Try to resolve threats recursively using whatever means are available.
  Return a list of candidate plans."
  (if (null threats)
      (list plan)
      (loop for new-plan in (resolve-threat (first threats) plan)
	 ;; Resolving a single threat may produce multiple plans.
	 ;; For each, resolve any remaining threats.  That is, for
	 ;; every plan, all threats are resolved.
	 append (resolve-threats (rest threats) new-plan))))

;;; Threat resolution possibilities.  We could do promotion and
;;; demotion in a single function, but this seems cleaner and more
;;; extensible.

(defmethod resolve-threat (threat plan)
  "Try to resolve a threat using whatever means are available.
  Return a list of candidate plans."
  (loop for method in (threat-resolution-means plan)
     for new-plan* = (funcall method threat (copy-plan plan))
     if (listp new-plan*)
     append new-plan*
     else collect new-plan*))

(defmethod threat-resolution-means (plan)
  (declare (ignore plan))
  ;; It's possible that the names of these functions should be
  ;; reversed.
  (list 'promote-step
        'demote-step))

(defun promote-step (threat plan)
  "Try to resolve a threat of step C to link A ->p B by promoting C."
  ;; Move step C before A->B.
  (push (order (threat-step threat) (link-from (threat-link threat)))
        (plan-ordering plan))
  plan)

(defun demote-step (threat plan)
  "Try to resolve a threat of step C to link A ->p B by demoting C."
  ;; Move step C after A->B
  (push (order (link-to (threat-link threat)) (threat-step threat))
        (plan-ordering plan))
  plan)

;;; ==============================
;;; III. "The goal test checks whether a plan is a solution to the
;;; original planning problem.  Because only consistent plans are
;;; generated, the goal test just needs to check that there are no
;;; open preconditions." [AIMA, p. 390]

(defmethod plan-solution-p (plan)
  (null (plan-open plan)))

;;; ==============================
;;; Planning utilities

;;; The function step-less-p is implemented in about as naive a
;;; fashion as can be imagined.  Profiling in OpenMCL shows that for
;;; the Sussman anomaly in propositional Blocks World, step-less-p
;;; takes 0.512 s. of a total 1.805 s., with a monitoring overhead of
;;; 0.26 s.  The simplest interpretation is that calls to step-less-p
;;; account for 33% of run time.  The situation is about the same for
;;; the variable-bindings version.  Devising a better representation
;;; is left as an exercise.

(defun step-less-p (step1 step2 plan)
  "Test whether one step comes before another in plan.
  Transitive ordering relationships need to be followed.
  Bounding the search prevents infinite recursion due to cycles."
  (let ((n (length (plan-steps plan)))
        (ordering (plan-ordering plan)))
    (bounded-dfs step1 step2
                 #'(lambda (s)
                     (step-successors s ordering))
                 n)))

;;; PAIP-specific: Memoization helps for some problems, hurts for
;;; others.  Step-less-p is called often, but the ordering constraint
;;; lists are short, and there are lots of unique plans.  (See the
;;; PAIP maze problem for an example.)  Students should consider the
;;; tradeoffs.  (Memoization isn't really the solution here; a data
;;; structure/algorithm change is called for.)
#+ignore
(memoize 'step-less-p :key #'identity :test #'equal)

;;; ==============================
;;; EOF