;;; -*- Mode: Lisp; Syntax: Common-Lisp; -*-

(in-package #.*simple-planners-package-name*)

;;; Copyright 2010 by David Boyuka and Robert St. Amant.

;;; To download the code for the simple planners, visit
;;; <http://www.csc.ncsu.edu/faculty/stamant/simple-planners/simple-planners.html>.

;;; This software is released under the license described by Peter
;;; Norvig: <http://www.norvig.com/license.html>.  If you find this
;;; software useful, please send email to <stamant@csc.ncsu.edu>.

;;; About simple-hsp.lisp:

;;; simple-HSP is based on the HSP2 planner, described by Bonet and
;;; Geffner, "Planning as heuristic search", Artificial Intelligence,
;;; 129, 5-33.

;;; The top-level function is simple-HSP, which takes as arguments an
;;; initial world state, a comparable goal state, and a list of
;;; actions.  The most convenient way to invoke this planner, however,
;;; is via a call to PLAN, which handles access to specific problems
;;; and domains:
#||
(plan (make-instance 'HSP-planner) 'sussman :domain 'blocksworld)
||#
;;; PLAN calls RUN-PLANNER, defined below.  RUN-PLANNER-TESTS is a
;;; testing function overall all the domains this planner can handle.

;;; simple-HSP finds plans with best-first search from the initial
;;; world state, using a heuristic function to estimate the number of
;;; steps required to reach the goal state.

;;; We would like the heuristic function to calculate, given a certain
;;; state, the minimum number of actions (the distance) required to
;;; move from that state to a goal. However, this problem is as hard
;;; as planning itself, so we make some simplifications. The heuristic
;;; operates on a relaxed version of the problem, which is derived
;;; from the original problem by ignoring the delete lists of all
;;; actions (only the add lists are considered). The heuristic
;;; attempts to calculate this same distance on the simplified
;;; problem. However, this problem is still too difficult, so we make
;;; one further simplification: calculate instead the minimum distance
;;; to each literal in the goal state, and then combine these
;;; distances using some function. This problem turns out to be
;;; solvable in polynomial time.
 
;;; To calculate this function, the simple-HSP heuristic runs roughly
;;; as follows.  Let S be the current state, G the goal state.
 
;;; 1. For each literal p in S, set d(p) = 0.  d(p) = +infinity+
;;;    for all other literals.

;;; 2. For each action a applicable in S,

;;;    a. Compute the distance to precond(a), using a combiner
;;;       function over its literals. Call the result x.

;;;    b. For each literal q in addlist(a), if x + 1 < d(q), set 
;;;       d(q) = x + 1 and add q to S.

;;; 3. If there were any changes to any literals, go to 2.

;;; 4. Return the distance to G, using the same combiner function.

;;; If a plan is a sequence of actions that can be executed beginning
;;; in the initial state of a problem, and the plan maintains the
;;; state (S) reached by the execution of that sequence, then the
;;; procedure above gives an estimate of how many more actions need to
;;; be added to the plan to reach the goal (G).  Naturally, S starts
;;; out being the initial state.

;;; The default combiner function in simple-HSP sums the
;;; distances/costs of literals.  For the problems defined in
;;; simple-problems.lisp, this heuristic works reasonably well.  An
;;; alternative combiner, which uses max, works less well.

;;; ==============================
;;; Planner definition

(defclass HSP-planner (propositional-preprocessor basic-planner)
  ()
  (:default-initargs
   :planner-bindings '((*action-class* propositional-action)
		       (*plan-class* hsp-plan))))

(defmethod initialize-state ((the-planner HSP-planner) initial-state goals actions)
  (close-world initial-state goals actions :closure '(:goal :actions)))

(defmethod run-planner ((the-planner HSP-planner) init goal actions
                        &rest rest &key &allow-other-keys)
  ;; simple-HSP searches through a space of plan objects, unlike
  ;; simple-GP and its variants.  Its return value is already a plan.
  (apply #'simple-HSP init goal actions :allow-other-keys t rest))

#+testing
(run-planner-tests (make-instance 'HSP-planner)
		   (append *propositional-problems-and-domains*
			   *first-order-problems-and-domains*))

;;; ==============================
;;; Top-level planning function

(defun simple-HSP (initial goals actions &key (heuristic #'hadd) (w 1) &allow-other-keys)
  "Run HSP to search out a solution plan using ACTIONS to traverse
   from INITIAL state to a state satisfying GOALS. A heuristic function
   can be specified with the :HEURISTIC key, and a heuristic bias can
   be specified with the :W key."
  (let* ((*actions* actions)  ; Redundant if called by 'plan'
	 (plan (simple-search
		(HSP-plan nil initial 0) ; No plan actions, initial state, zero cost.
		(lambda (plan)
		  (subsetp goals (state plan) :test #'literals-eql))
		#'plan-successors
		(lambda (plan)
		  (+ (plan-cost plan)
		     (* w (funcall heuristic goals (state plan) actions)))))))
    (when plan
      ;; Plan actions have been collected in reverse order, for efficiency.
      (setf (actions plan) (reverse (actions plan)))
      (values plan t))))

(defun hadd (literals current-state actions)
  (relaxed-cost literals current-state actions #'+))

(defun hmax (literals current-state actions)
  (relaxed-cost literals current-state actions #'max))

;;; ==============================

;;; An HSP-plan holds a sequence of ACTIONS (stored in reverse order),
;;; leading from the initial state to some (current) STATE, with an
;;; accumulated (relaxed) COST.

(defun HSP-plan (actions state cost)
  "Create a new HSP-plan with the given arguments."
  (make-instance 'HSP-plan :actions actions :state state :cost cost))

(defmethod plan-successors ((the-plan HSP-plan))
  "Return all plans reachable by applying applicable actions from
   *actions*. Also maintains action records for each plan, as
   well as accumulated cost."
  ;; all-such-that collects non-nil predicate results for list elements.
  (all-such-that (lambda (action)
		   (when (action-applicable-p action (state the-plan))
		     (HSP-plan (cons action (actions the-plan))
			       (apply-action action (state the-plan))
			       (increment-cost (plan-cost the-plan)))))
		 *actions*))

;;; ==============================
;;; The heuristic

;;; See discussion at the top of this file.

(defvar +infinite-cost+ most-positive-fixnum)

;; Implementation note: the macro repeat-while-flag is an iteration
;; construct with an anonymous flag set to nil on each iteration.  If
;; on any pass, the local function update-flag is called with a
;; non-nil value, the loop repeats.  If the flag is not so updated on
;; a given pass, the loop exits.

(defun relaxed-cost (goals current-state actions combiner)
  "Return the heuristic cost of the given list of literals in
   the relaxed problem, the problem obtained by ignoring the
   delete lists of all actions."
  (let ((cost-table (make-hash-table :test #'equal)))
    ;; Initialize the cost of any literal already present to 0.
    ;; The cost of any other literal will be +infinite-cost+ by default.
    (dolist (literal current-state)
      (setf (gethash literal cost-table) 0))
    (repeat-while-flag
      (dolist (action (find-all-if (lambda (action)
				     (action-applicable-p action current-state))
				   actions))
	(update-flag (changed-costs action combiner cost-table)) ; Adjust costs, update flag.
	(setf current-state (union current-state (action-add-list action) ; Add list only
				   :test #'literals-eql))))
    (combine-costs combiner goals cost-table)))

;;; changed-costs is overkill, because only a flag needs to be
;;; returned.  But for conceptual clarity, we return something more
;;; meaningful: the set of literals whose costs have changed.

(defun changed-costs (action combiner cost-table)
  "Return the literals from the add-list of the action whose costs have changed."
  ;; The cost of an applicable action is the combined cost of its
  ;; precondition literals.  Increment by 1 to reflect execution.
  (let ((new-cost (increment-cost
		   (aif (action-precond action)
			(combine-costs combiner it cost-table)
			0))))
    ;; Find all the literals in the add list of the action whose costs
    ;; need to be updated.  Update them along the way.
    (all-such-that (lambda (effect-literal)
		     ;; When a new literal is considered, its infinite cost is reduced.
		     (when (< new-cost (gethash effect-literal cost-table +infinite-cost+))
		       (setf (gethash effect-literal cost-table) new-cost)
		       effect-literal))
		   (action-add-list action))))

;;; We could cache add lists, but that would mean a new data structure.
(defmethod action-add-list ((action propositional-action))
  (remove-if #'negated-literal-p (action-effect action)))

;;; ==============================
;;; Costs

;;; Accessing cost values

(defun combine-costs (combiner literals cost-table)
  "Return the cost of the supplied literals, using combiner."
  (flet ((get-cost (literal)
	   (gethash literal cost-table +infinite-cost+)))
    (if (find +infinite-cost+ literals :key #'get-cost)
	+infinite-cost+       ; This default behavior should work for all combiners.
	(reduce combiner literals :key #'get-cost))))

;;; Computing costs with infinity

(defun increment-cost (cost &optional (increment 1))
  (if (= cost +infinite-cost+)		; Stick to fixnums
      +infinite-cost+
      (+ cost increment)))

;;; ==============================

#|| BEGIN EXTENDED COMMMENT

Students may wonder how much of a benefit the reduced cost heuristic
gives us.  Here's one way to judge: Try a different heuristic, such as
plan-length (i.e. plan-cost, which is the length of a plan up to some
point in the search, without the call to relaxed-cost).  This is easy
to do:

(plan (make-instance 'HSP-planner) <problem> :domain <domain>
      :heuristic (lambda (literals current-state actions)
		   (declare (ignore literals current-state actions))
		   0))

Just fill in a <problem> and a <domain>.  This does well for most
of the simple problems we give the planners; figuring out the
reason why is left as an exercise.  But consider the artificial
NK1 domain, with just seven actions.  This heuristic causes the
planner to search 792,896 possible plans before finding a
solution.  There are two caveats in reproducing this result, if
you'd like to try it yourself.  First, it only works when run on
the AIMA code base (and, for all I know, only on my Lisp
platform).  The PAIP and standalone versions use a different
implementation of best-first-search, which records states in a
slightly different order, enough for the NK-P1 problem to be
intractable with the plan-length heuristic.  This leads to the
second caveat: HSP2, as described by Bonet and Geffner, uses A*
search, and thus presumably caches search nodes it's seen before.
simple-HSP does not, and so for larger problems its performance
using the plan-length heuristic is even worse than you might
expect.

||#

;;; ==============================
;;; EOF