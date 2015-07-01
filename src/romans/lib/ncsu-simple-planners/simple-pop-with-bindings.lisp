;;; -*- Mode: Lisp; Syntax: Common-Lisp; -*-

(in-package #.*simple-planners-package-name*)

;;; Copyright 2007 by Robert St. Amant.

;;; To download the code for the simple planners, visit
;;; <http://www.csc.ncsu.edu/faculty/stamant/simple-planners/simple-planners.html>.

;;; This software is released under the license described by Peter
;;; Norvig: <http://www.norvig.com/license.html>.  If you find this
;;; software useful, please send email to <stamant@csc.ncsu.edu>.

;;; About simple-pop-with-bindings.lisp:

;;; This file contains extensions to a propositional partial-order
;;; planner to handle variable bindings.  See notes in simple-pop.lisp
;;; for more on the code in general.  These extensions continue to
;;; follow the approach described in AIMA.  You'll need to be familiar
;;; with the code and notes in simple-pop.lisp for the comments and
;;; code in this file to make sense.

;;; Because simple-POP was designed to be presentable as a standalone
;;; propositional planner in the context of PAIP, there are a few
;;; oversimplifications in its design.  In particular, the basic
;;; methods for propositional planning just refer to actions, steps,
;;; and plans, rather than being specialized to classes appropriate
;;; for propositional planning (propositional-action,
;;; propositional-step, and propositional-pop-plan, in contrast to
;;; first-order-action, first-order-step, and pop-plan).  This poses
;;; no difficulties when the planners run, but it's a software design
;;; issue that may have to be revisited if further extensions are
;;; carried out.

;;; Is this the best way to extend a propositional partial-order
;;; planner to handle variable bindings, so that we have two related
;;; planners available?  No.  An alternative approach is to notice
;;; that once simple-POP can handle variable bindings, it subsumes the
;;; functionality of the propositional planner--we might have simply
;;; skipped the propositional planner.  But for pedagogical reasons I
;;; think the incremental design is appropriate; it's the way things
;;; are presented in AIMA.  For a more sophisticated and elegant
;;; approach to partial-order planner design, see UCPOP, which manages
;;; variable bindings with what Dan Weld calls varsets.

;;; The top-level function is simple-POP, which takes as arguments an
;;; initial world state, a comparable goal state, and a list of
;;; actions.  The most convenient way to invoke this planner, however,
;;; is via a call to PLAN, which handles access to specific problems
;;; and domains:
#||
(plan (make-instance 'POP-planner) 'sussman :domain 'blocksworld)
||#
;;; PLAN calls RUN-PLANNER, defined in simple-pop.lisp.
;;; RUN-PLANNER-TESTS is a testing function overall all the domains
;;; this planner can handle.

;;; ==============================
;;; Planner definition

(defclass POP-planner (propositional-POP-planner)
  ()
  ;; The POP-planner uses the same top-level plan construction method 
  ;; as the propositional-POP-planner.
  (:default-initargs
   :planner-bindings '((*action-class* first-order-action)
		       (*step-class* first-order-step)
		       (*plan-class* pop-plan))))

;;; run-planner defined in simple-pop.lisp

#+testing
(run-planner-tests (make-instance 'POP-planner)
		   (append *propositional-problems-and-domains*
			   *first-order-problems-and-domains*)
		   :exclude-problems '(change-rooms start-to-finish back-and-forth))

;;; ==============================
;;; Top-level planning function

;;; See simple-pop in simple-pop.lisp.

;;; ==============================
;;; Planning data structure refinements 

(defmethod initialize-instance :after ((the-step first-order-step) &key)
  ;; A first-order-step extends a propositional-step to handle
  ;; variable bindings.  Step variable names are derived from action
  ;; parameter names but are unique and local to the step.  This means
  ;; that multiple instantiations of the same action can coexist in
  ;; the same plan without name collisions.  We create aliases and
  ;; substitute them for the action parameter names in the precond,
  ;; effect, and inequality-constraints of the step when it is
  ;; created.

  ;; Notice that inequality constraints, (NEQ ?x ?y) can be included
  ;; in action preconditions.  These are removed when steps are
  ;; instantiated and recorded as inequality constraints; they're not
  ;; preconditions that can be achieved.
  (with-slots (action variables precond effect inequality-constraints) the-step
    (setf variables (mapcar #'parameter-alias (action-parameters action)))
    (let ((substitutions (mapcar #'cons (action-parameters action) variables)))
      (multiple-value-bind (neq-list remaining-precond)
          (bipartition-if #'inequalityp (action-precond action))
        (setf inequality-constraints
              (sublis substitutions (mapcar #'make-neq neq-list)))
        (setf precond (sublis substitutions remaining-precond))
        (setf effect (sublis substitutions (action-effect action)))
        the-step))))

;;; ==============================

;;; Revised: This method is very slightly different from its version
;;; in the propositional planner design.  In the original version,
;;; steps-for-precond returns a list of steps, and this list is
;;; iterated over, with add-plan-link generating a new link and a new
;;; plan for each step.  When variable bindings need to be considered,
;;; passing only a step between these two stages is insufficient: we
;;; also need information about bindings.  We can't set variable
;;; bindings directly in a step, because steps are shared between
;;; plans, and two alternative plans may rely on the same step, with
;;; different bindings stored at the plan level.  The cleanest
;;; solution seems to be to integrate the two functions of
;;; steps-for-precond and add-plan-link into one, plans-for-precond.

(defmethod plan-successors ((plan pop-plan))
  "Return a list of successor plans."
  (let ((open-precond (choose-open-precond plan))
        (successors nil))
    (multiple-value-bind (new-plans new-steps new-links)
	(plans-for-precond plan open-precond)
      (do ((successor (pop new-plans) (pop new-plans))
	   (new-link (pop new-links) (pop new-links))
	   (candidate-step (pop new-steps) (pop new-steps)))
	  ((null successor))
	(setf successors
	      (append (resolve-threats (plan-threats successor
						     candidate-step
						     new-link)
				       successor)
		      successors))))
    (find-all-if #'plan-consistent-p successors)))

;;; New: This method combines steps-for-precond and add-plan-link from
;;; the propositional planner design, being called as a substitute for
;;; steps-for-precond.  Why?  Because plan-successors passes around
;;; steps to the two functions above, but more information than that
;;; is needed to construct a plan with variable bindings.  To avoid
;;; temporarily storing bindings, steps to be added to a new plan are
;;; managed within the same function as the creation of that new plan.
(defmethod plans-for-precond ((plan pop-plan) open-precond)
  "Build a list of plans that can achieve some precondition.
  The achievement may be by a step in the plan or by an action
  from the global action list, converted into a step.  We're
  working with actions and steps that may have unbound variables,
  so matching must be done by unification.  Notice that we don't
  test local inequality constraints here--in brand-new steps, for
  example, any unbound variables can codesignate.  We do test for
  plan-level inequality constraints.  Return a list of plans, a
  list of steps, and a list of links."
  (let ((candidates nil))
    (dolist (step (append (plan-steps plan) (mapcar #'make-step *actions*)))
      (dolist (p (subst-bindings (plan-bindings plan) (step-effect step)))
        (let ((new-bindings (unify (open-literal open-precond) p (plan-bindings plan))))
          (when (and new-bindings
                     (valid-bindings-p new-bindings (plan-inequalities plan))) 
	    (multiple-value-bind (new-plan new-link)
		(add-plan-link (copy-plan plan) step open-precond)
	      (setf (plan-bindings new-plan)
		    (merge-bindings new-bindings (plan-bindings new-plan)))
	      (push (list new-plan step new-link) candidates))))))
    (when candidates
      ;; Reverse, below, is for ordering consistency with the
      ;; steps-for-precond in the propositional planner.  *NOT*
      ;; including the reverse causes problems, which suggests a
      ;; subtle bug in the code, which I haven't tracked down.
      (values-list (transpose-list (reverse candidates))))))

;;; New: When a link is added, any new step inequalities have to be
;;; added as well to the plan.
(defmethod add-plan-link :before ((plan pop-plan) (step first-order-step) open-precond)
  (declare (ignore open-precond))
  (setf (plan-inequalities plan)
        (merge-bindings (step-inequalities step)
                        (plan-inequalities plan))))

;;; Quoted from AIMA, p. 394, annotated with simple-POP [function names].

;;; "The presence of variables in preconditions and actions
;;; complicates the process of detecting and resolving conflicts.  For
;;; example, when Move(A, x, B) is added to the plan, we will need a
;;; causal link Move(A,x, B) -> [On(A,B)] Finish.  If there is another
;;; action M2 with effect not On(A, z), then M2 conflicts only if z is
;;; B [threatens-link-p, with possible as well as necessary
;;; conflicts].  To accommodate this possibility, we extend the
;;; representation of plans [inequality-constraints slot of pop-plan
;;; class] to include a set of inequality constraints of the form z /=
;;; X where z is a variable and X is either another variable or a
;;; constant symbol.  In this case, we would resolve the conflict by
;;; adding z /= B, which means that future extensions to the plan can
;;; instantiate z to any value except B [add-inequality]. Anytime we
;;; apply a substitution to a plan, we must check that the
;;; inequalities do not contradict the substitution
;;; [plan-consistent-p]."

;;; New: A link can be threatened by a step with unbound variables.
;;; Instead of testing for equality between literals, we use
;;; unification.
(defmethod threatens-link-p ((plan pop-plan) (step first-order-step) link)
  "Return a threat, if the precondition identified in the link is
  threatened by some condition in the effect of the step."
  (when (and (not (or (step-less-p step (link-from link) plan)
                      (step-less-p (link-to link) step plan)))
             (some #'(lambda (p)
                       (let ((bindings (unify (negate p) (link-literal link)
                                              (plan-bindings plan))))
                         (and bindings
                              (valid-bindings-p bindings
                                                (plan-inequalities plan)))))
                   (step-effect step)))
    (threat step link)))

;;; New: Consistency must also test for inequality violations.
(defmethod plan-consistent-p ((plan pop-plan))
  "Check plan for the absence of ordering cycles and threats, plus inequalities."
  (and (call-next-method)
       (valid-bindings-p (plan-bindings plan) (plan-inequalities plan))))

;;; New: We add a new possibility for resolving threats.
(defmethod threat-resolution-means ((plan pop-plan))
  (list 'promote-step
        'demote-step
        'add-inequalities))

;;; New: We resolve threats by adding inequalities to a plan.
(defun add-inequalities (threat plan)
  "Try to resolve a threat of step C to link A ->p B by adding
  inequality constraints such that the possibility of an effect
  of C unifying with p is eliminated by an inequality
  constraint."
  (let ((successors nil))
    (dolist (p (step-effect (threat-step threat)))
      (let ((new-bindings (new-bindings-only (negate p)
                                             (link-literal (threat-link threat))
                                             (plan-bindings plan))))
        (when new-bindings
          ;; new bindings mean that there are some bindings we can
          ;; rule out by inequality constraints, to prevent
          ;; unification and remove a threat.
          (let ((copy (copy-plan plan)))
            (setf (plan-inequalities copy)
                  (merge-inequalities (mapcar #'make-neq-from-binding new-bindings)
                                      (plan-inequalities copy)))
            (push copy successors)))))
    successors))

;;; ==============================
;;; Utility

(defun parameter-alias (symbol)
  (gensym (symbol-name symbol)))

(defun transpose-list (list)
  "Treating a list of lists as a matrix, return its transpose, as a list of lists."
  ;; This is inefficient but adequate for small lists.
  (apply #'mapcar #'list list))

;;; ==============================

#|| BEGIN EXTENDED COMMMENT

;;; One of the reasons simple-POP is slow is that it chooses an
;;; arbitrary open precondition to achieve when generating plan
;;; successors.  Here's a better heuristic (which we specialize to
;;; pop-plans but would work for propositional-pop-plans as well):

(defmethod simple-most-constrained-fn ((the-plan pop-plan))
  "Return an open precondition for which the fewest action
  effects unify, ignoring plan bindings and possible presence as
  steps in the plan."
  (let ((actions *actions*))
    (arg-min (plan-open the-plan)
	     #'(lambda (open)
		 (count-if #'(lambda (effect)
			       (find (open-literal open) effect :test #'unify))
			   actions
			   :key #'action-effect)))))

;;; How do we make simple-POP aware of it?  One possibility is to
;;; write a new method choose-open-precond for first-order simple-POP,
;;; that directly calls simple-most-constrained-fn, but this limits
;;; flexibility--it ties every instance of the planner to a specific
;;; heuristic.  Here's a different approach:

(defvar *choose-open-precond-fn* nil)

(defmethod choose-open-precond ((plan pop-plan))
  (if *choose-open-precond-fn*
      (funcall *choose-open-precond-fn* plan)
      (call-next-method)))

;;; Let's compare.  In the first case we run the planner with the
;;; default heuristic.  In the second case we bind
;;; *choose-open-precond-fn* to the new function.

> (time (plan (make-instance 'pop-planner) 'sussman :domain 'blocksworld))
(PLAN (MAKE-INSTANCE 'POP-PLANNER) 'SUSSMAN :DOMAIN 'BLOCKSWORLD) took 591 milliseconds (0.591 seconds) to run.
Of that, 516 milliseconds (0.516 seconds) were spent in user mode
         20 milliseconds (0.020 seconds) were spent in system mode
         55 milliseconds (0.055 seconds) were spent executing other OS processes.
22 milliseconds (0.022 seconds) was spent in GC.
 7,303,304 bytes of memory allocated.

> (let ((*choose-open-precond-fn* 'simple-most-constrained-fn))
    (time (plan (make-instance 'pop-planner) 'sussman :domain 'blocksworld)))
(PLAN (MAKE-INSTANCE 'POP-PLANNER) 'SUSSMAN :DOMAIN 'BLOCKSWORLD) took 179 milliseconds (0.179 seconds) to run.
Of that, 150 milliseconds (0.150 seconds) were spent in user mode
         6 milliseconds (0.006 seconds) were spent in system mode
         23 milliseconds (0.023 seconds) were spent executing other OS processes.
6 milliseconds (0.006 seconds) was spent in GC.
 2,323,944 bytes of memory allocated.

;;; If we *do* want this to be the default, then we change the default
;;; bindings for the class, something like this.

(setf *POP-planner-bindings*
      '((*action-class* first-order-action)
	(*step-class* first-order-step)
	(*plan-class* pop-plan)
	(*choose-open-precond-fn* simple-most-constrained-fn)))

(defclass POP-planner (propositional-POP-planner)
  ()
  (:default-initargs
   :planner-bindings *POP-planner-bindings*))

> (time (plan (make-instance 'pop-planner) 'sussman :domain 'blocksworld))
(PLAN (MAKE-INSTANCE 'POP-PLANNER) 'SUSSMAN :DOMAIN 'BLOCKSWORLD) took 149 milliseconds (0.149 seconds) to run.
Of that, 132 milliseconds (0.132 seconds) were spent in user mode
         5 milliseconds (0.005 seconds) were spent in system mode
         12 milliseconds (0.012 seconds) were spent executing other OS processes.
5 milliseconds (0.005 seconds) was spent in GC.
 2,323,880 bytes of memory allocated.

END EXTENDED COMMMENT
||#

;;; ==============================
;;; EOF