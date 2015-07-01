;;; -*- Mode: Lisp; Syntax: Common-Lisp; -*-

(in-package #.*simple-planners-package-name*)

;;; Copyright 2007 by Mike Dickheiser and Robert St. Amant.

;;; To download the code for the simple planners, visit
;;; <http://www.csc.ncsu.edu/faculty/stamant/simple-planners/simple-planners.html>.

;;; This software is released under the license described by Peter
;;; Norvig: <http://www.norvig.com/license.html>.  If you find this
;;; software useful, please send email to <stamant@csc.ncsu.edu>.

;;; About simple-GP.lisp:

;;; This code is an implementation of GraphPlan, as described in
;;; Chapter 11 of Stuart Russell and Peter Norvig's Artificial
;;; Intelligence: A Modern Approach, 2nd edition (AIMA).  The code for
;;; simple-GP has been structured to follow AIMA's discussion as
;;; closely as I could manage.  simple-GP is intended for classroom
;;; use: it has less functionality and is much less efficient than
;;; existing Lisp implementations (e.g., Sensory Graphplan, from the
;;; University of Washington), the tradeoff being (I hope) additional
;;; clarity.

;;; The top-level function is simple-GP, which takes as arguments an
;;; initial world state, a comparable goal state, and a list of
;;; actions.  The most convenient way to invoke this planner, however,
;;; is via a call to PLAN, which handles access to specific problems
;;; and domains:
#||
(plan (make-instance 'GP-planner) 'sussman :domain 'blocksworld)
||#
;;; PLAN calls RUN-PLANNER, defined below.  RUN-PLANNER-TESTS is a
;;; testing function overall all the domains this planner can handle.

;;; Note: Simple-GP terminates differently from GraphPlan, strictly
;;; speaking, on unsolvable problems.  Blum and Furst's algorithm, in
;;; "Fast Planning Through Planning Graph Analysis", memoizes
;;; unsolvable goal sets as it searches a planning graph for a plan.
;;; This allows it to recognized some problems as being unsolvable.
;;; (Blum and Furst's example of such a problem is from Blocksworld:
;;; On(A B), On(B C), On(C A).)  Simple-GP, being simple, doesn't
;;; record such information, relying instead on (a) Blum and Furst's
;;; "quick and easy test" for termination and (b) a limit on
;;; iterations in planning graph extension.  A future revision may fix
;;; this problem.  The design is nevertheless consistent with the
;;; discussion in AIMA; see the comments on extracting solutions
;;; below.

;;; Note: Simple-GP relies on a simplifying assumption, one I believe
;;; is shared with Sensory Graphplan: the initial state level contains
;;; only the literals explicitly in the initial state and the goal
;;; state, rather than all literals (from all actions) consistent with
;;; the initial state.  This means that mutexes decrease monotonically
;;; *only* across levels that contain the same literals.  Since this
;;; is only relevant as a stopping criterion, tied to exactly such a
;;; test of the literals across state levels, it doesn't affect
;;; behavior for plausible domains and problems.  However, if a
;;; negated literal appears in an action precondition but is not
;;; present in the initial state or the effect of some other action,
;;; it will break.  See the initialize-state method for a fix.

;;; ==============================
;;; Planner definition

(defclass GP-planner (propositional-preprocessor basic-planner)
  ()
  (:default-initargs
   :planner-bindings '((*action-class* propositional-action)
		       (*plan-class* gp-plan)
		       (*planning-graph-class* planning-graph))))

(defmethod initialize-state ((the-planner GP-planner) initial-state goals actions)
  ;; We could call close-world with '(:goal :actions) as an argument
  ;; instead of just '(:goal), but it slows simple-GP down a lot.
  (close-world initial-state goals actions :closure '(:goal)))

(defmethod run-planner ((the-planner GP-planner) init goal actions
			&rest rest &key &allow-other-keys)
  (multiple-value-bind (solution solution-p planning-graph)
      (apply #'simple-GP init goal actions :allow-other-keys t rest)
    (values (when solution-p
	      ;; simple-GP returns a list of levels, each containing a
	      ;; list of actions.  For consistency, this is turned
	      ;; into a plan object.
	      (make-plan :actions solution :planning-graph planning-graph))
	    solution-p
	    planning-graph)))

#+testing
(run-planner-tests (make-instance 'GP-planner)
		   (append *propositional-problems-and-domains*
			   *first-order-problems-and-domains*))

;;; ==============================
;;; Top-level planning function

;;; From [AIMA, p. 399]:

;;; function GraphPlan (problem) returns solution or failure
;;;   graph <- Initial-Planning-Graph(problem)
;;;   goals <- Goals [problem]
;;;   loop do
;;;     if goals all non-mutex in last level of graph then do
;;;       solution <- Extract-Solution (graph, goals, Length(graph))
;;;       if solution /= failure then return solution
;;;       else if No-Solution-Possible(graph) then return failure
;;;     graph <- Expand-Graph(graph, problem)

;;; Note: The function simple-GP differs slightly from the pseudocode
;;; above, which tests whether a solution is impossible only when all
;;; goals are non-mutex in the last level.  That's not quite right:
;;; the test should be moved outward, because the absence of such a
;;; set of goals in the last level should be part of the test for
;;; unsolvable problems.

;;; Implementation note: The &key lambda keyword in simple-GP is for
;;; consistency with the more abstract functions for running a
;;; planner, either a POP plan or a graphplan instance; it could also
;;; support later extension.

;;; Implementation note: extract-solution and no-solution-possible-p
;;; are generic functions, which means that alternative methods for a
;;; class inheriting planning-graph can be added without modifying the
;;; top-level function.  Currently only extract-solution has been
;;; experimented with in the simple planners.

(defparameter *level-limit* 100)

(defun simple-GP (initial goals actions &key (graph (make-planning-graph initial)))
  (do-forever (:practical-limit *level-limit*)
    (when (goals-non-mutex-p goals graph (n graph))
      (multiple-value-bind (solution solutionp)
	  ;; A returned value may be NIL, but solutionp tells us if it's a solution.
	  (extract-solution graph goals (n graph))
	(when solutionp
	  (return-from simple-GP (values solution T graph)))))
    (when (no-solution-possible-p graph goals)
      (return-from simple-GP (values nil nil graph)))
    (setf graph (expand-graph graph actions)))
  ;; Limit exceeded means failure; return the planning graph to help in debugging.
  (values nil nil graph))

(defmethod goals-non-mutex-p (goals (the-graph planning-graph) n)
  "Test whether all goals are in the nth state level and no mutex
  relations exist between them."
  (and (subsetp goals (level-state the-graph n) :test #'literals-eql)
       (non-mutex-set-p goals the-graph n)))

(defmethod no-solution-possible-p ((the-graph planning-graph) goals)
  (let ((n (n the-graph)))
    (and (graph-leveled-off-p the-graph)
	 (or (not (subsetp goals (level-state the-graph n) :test #'literals-eql))
	     (not (goals-non-mutex-p goals the-graph n))) ; repeated computation, could be cached
	 ;; *****
	 ;; Here is where the non-quick-and-easy test for unsolvable
	 ;; problems should go.  We punt on it.
	 ;; *****
	 )))

;;; Literals increase and mutexes decrease monotonically.
(defmethod graph-leveled-off-p ((the-graph planning-graph))
  "Test whether the last state level of the graph is equal to the
  next-to-last."
  (let ((n (n the-graph)))
    (unless (zerop n)
      (and (= (level-state-count the-graph n)
	      (level-state-count the-graph (1- n)))
	   (= (level-state-mutex-count the-graph n)
	      (level-state-mutex-count the-graph (1- n)))))))

;;; ==============================
;;; Planning graphs

;;; Quoted from AIMA:

;;; "A planning graph consists of a sequence of levels that correspond
;;; to time steps in the plan, where level 0 is the initial
;;; state. Each level contains a set of literals and a set of
;;; actions."  [p. 394]

;;; We define a LEVEL data structure with two slots: a list of
;;; literals and a list of actions.  Actions are propositional, which
;;; means that in simple-GP, as in propositional simple-POP, the
;;; precondition and effect of an action are both lists of literals.
;;; Thus literals and actions constitute the nodes of the planning
;;; graph, with preconditions being the arcs between state literals
;;; and actions within a level, and effects being the arcs between
;;; literals in one level and actions in the next.  Note that in this
;;; representation, arcs can be efficiently traversed only in one
;;; direction: forward from an action to its effect literals or
;;; backward from an action to its precondition literals.

;;; A planning graph also maintains literal/literal and action/action
;;; mutex relations, which we record in the LEVEL data structure in
;;; the form of two hash tables, one for literal mutex relations and
;;; one for action mutex relations.  These tables are filled in the
;;; functions add-level-state and (setf level-actions) as side
;;; effects.

;;; For efficiency (though that's not really a concern in this code),
;;; the LEVEL data structure also maintains a count of the number of
;;; literals and literal mutexes it records.

;;; Implementation note: We provide a level of abstraction between
;;; simple-GP and the representation of an individual levels; access
;;; to the state, actions, and mutex relations at a given level are by
;;; way of functions that take an index into the levels vector of a
;;; planning-graph instance: level-state, add-level-state,
;;; level-actions, (setf level-actions), level-state-count,
;;; level-state-mutex-count, and mutex-relation.  Single-level-state
;;; et al. are not called outside these functions.  See utility
;;; section at the end of this file.

(defstruct (single-level)
  (state nil)
  (state-count 0)			; for leveled-off testing
  (actions nil)
  (state-mutex-relations (make-hash-table :test #'equal))
  (state-mutex-count 0)			; for leveled-off testing
  (action-mutex-relations (make-hash-table :test #'equal)))

;;; We represent the planning graph as an instance of planning-graph,
;;; which contains a vector (called levels) of level objects.  We
;;; index into the levels vector by a time step index, which we simply
;;; call N (which corresponds in the AIMA discussion to the subscripts
;;; of state levels and action levels).

(defun make-planning-graph (state)
  (let ((graph (make-instance *planning-graph-class*)))
    (initialize-planning-graph graph state)
    graph))

(defmethod initialize-planning-graph ((the-graph planning-graph) state)
  (with-slots (levels) the-graph
    (setf levels (make-array *level-limit*
			     :fill-pointer 0
			     :initial-element nil))
    ;; A planning-graph is initialized with a "partial" level: a state
    ;; and its mutex relations.
    (add-level-state the-graph state)
    the-graph))

(defmethod (setf level-actions) (actions (the-graph planning-graph))
  "Set the set of actions associated with the last level.
  As a side effect, record mutex relations between all pairs of
  actions."
  (let* ((n (n the-graph))
	 (mutex-store (single-level-action-mutex-relations (elt (levels the-graph) n))))
    (setf (single-level-actions (elt (levels the-graph) (n the-graph))) actions)
    (do-unordered-pairs (a1 a2 actions)
      (when (actions-mutex-p a1 a2 the-graph n)
	(set-mutex-entry a1 a2 mutex-store))))
  actions)

(defmethod add-level-state ((the-graph planning-graph) state)
  "Add a new level with the set of literals. As a side effect,
  record mutex relations between all pairs of literals."
  (let ((new-level (make-single-level :state state :state-count (length state))))
    (vector-push new-level (levels the-graph))
    (let* ((n (n the-graph))
	   (mutex-store (single-level-state-mutex-relations (elt (levels the-graph) n))))
      (do-unordered-pairs (l1 l2 state)
	(when (literals-mutex-p l1 l2 the-graph n)
	  (set-mutex-entry l1 l2 mutex-store)
	  (incf (single-level-state-mutex-count new-level)))))
    state))

(defmethod n ((the-graph planning-graph))
  ;; The zero-based index of the last element.
  (with-slots (levels) the-graph
    (1- (length levels))))

;;; ==============================
;;; Graph expansion

(defmethod expand-graph ((the-graph planning-graph) actions)
  "Expand a graph by adding the next action and state level, as
  well as mutex relations for each."
  ;;   "An action level contains \"all the actions whose preconditions
  ;;   are satisfied in the previous level\" [AIMA, p. 395], plus
  ;;   persistence actions."
  (let* ((n (n the-graph))
	 (state (level-state the-graph n)))
    (setf (level-actions the-graph)
	  ;; Collect all such actions, plus a persistent action for each literal.
	  (append (find-all-if (lambda (action)
				 (action-applicable-p action state))
			       actions)
		  (mapcar #'make-persistent-action state)))
    ;; Add a new level, with a state containing all action effect literals
    (add-level-state the-graph
		     (collect-action-literals #'action-effect
					      (level-actions the-graph n)))
    the-graph))

;;; ==============================
;;; Action mutex relationships

;;; Implementation note: graph and n are used as arguments here
;;; because they're required for literal mutex testing, in a chain of
;;; calls: actions-mutex-p -> competing-needs -> literals-mutex-p ->
;;; inconsistent-support-p.  An alternative design could bind special
;;; variables to these values in the dynamic context in which
;;; actions-mutex-p is called, so that these functions wouldn't need
;;; to pass through values that they don't use.

(defun actions-mutex-p (action1 action2 graph n)
  (cond ((eql action1 action2) nil)
	((competing-needs-p action1 action2 graph n))
	((interference-p action1 action2))
	((inconsistent-effects-p action1 action2))))

;;; "Competing needs: one of the preconditions of one action is
;;; mutually exclusive with a precondition of the other" [AIMA,
;;; p. 397].

(defun competing-needs-p (action1 action2 graph n)
  (intersection-p (action-precond action1) (action-precond action2)
		  :test #'(lambda (l1 l2)
			    (literals-mutex-p l1 l2 graph n))))

;;; "Interference: one of the effects of one action is the negation of
;;; a precondition of the other" [AIMA, p. 397].

(defun interference-p (action1 action2)
  (or (intersection-p (action-precond action2) (action-effect action1)
		      :test #'literals-negate-p)
      (intersection-p (action-precond action1) (action-effect action2)
		      :test #'literals-negate-p)))

;;; "Inconsistent effects: one action negates an effect of the other"
;;; [AIMA, p. 397].

(defun inconsistent-effects-p (action1 action2)
  (intersection-p (action-effect action1) (action-effect action2)
		  :test #'literals-negate-p))

;;; ==============================
;;; Literal mutex relationships

;;; A mutex relation holds between two literals at the same level if
;;; one is the negation of the other or if each possible pair of
;;; actions that could achieve the two literals is mutually
;;; exclusive. This condition is called inconsistent support [AIMA,
;;; p. 397].

(defun literals-mutex-p (l1 l2 graph n)
  (or (literals-negate-p l1 l2)
      (and (> n 0) (inconsistent-support-p l1 l2 graph n))))

(defun inconsistent-support-p (l1 l2 graph n)
  ;; This may look a bit convoluted, but the test here is whether some
  ;; pair of actions to achieve each literal is not mutex.  If such a
  ;; pair exists, then support is *not* inconsistent.  We also test
  ;; whether both literals can be satisfied by a single action, which
  ;; would mean support is *not* inconsistent.  (I don't think the
  ;; second case is explicitly mentioned in AIMA, but it seems
  ;; reasonable.)
  (let ((actions (level-actions graph (1- n))))
    (flet ((actions-for-literal (literal)
	     (find-all-if (lambda (action)
			    (action-achieves-literal-p action literal))
			  actions)))
      (and (not (intersection-p (actions-for-literal l1)
				(actions-for-literal l2)
				:test #'(lambda (a1 a2)
					  (not (mutex-relation a1 a2 graph n)))))
	   (not (some #'(lambda (a)
			  (subsetp (list l1 l2) (action-effect a) :test #'literals-eql))
		      actions))))))

;;; ==============================
;;; Extracting solutions: Per AIMA, p. 400, extracting a solution can
;;; be treated as a constraint satisfaction problem or a search
;;; problem.  For simplicity of implementation, (a) we treat it as a
;;; search problem, and (b) we solve it by brute force.  The function
;;; extract-solution is just a placeholder for brute-force-extract.
;;; This function starts with a graph in which all the goals are in
;;; the last state level and are non-mutex.  If a solution exists,
;;; then some non-mutex subset of the actions at the previous action
;;; level will achieve these goals.  An exhaustive search over subsets
;;; in this action level is carried out.  How can we tell whether a
;;; subset is satisfactory?  By testing whether the aggregate set of
;;; preconditions of these actions is non-mutex and can be satisfied
;;; by literals in the same level.  This produces the recursive
;;; structure of brute-force-extract.

;;; simple-GP is an oversimplification of Blum and Furst's original
;;; algorithm.  AIMA describes the initial state of the search problem
;;; in GraphPlan as the set of goals from the planning problem, and
;;; search actions for a search state at some level i as a
;;; conflict-free sets of actions at level i - 1.  Blum and Furst go
;;; further: subsets of literals at a given level constitute search
;;; states, and incrementally constructed set of actions to achieve a
;;; given subset are maintained.  The reason for considering subsets
;;; of literals at each level rather than the all the literals that
;;; will contribute to a solution at each level is that some subsets
;;; can be determined to be unachievable.  If these subsets are
;;; memoized, then the solution extraction procedure can eventually
;;; determine that a given problem has no solution if this is the
;;; case.  In simple-GP, for simplicity of implementation, this
;;; important issue is ignored.

(defmethod extract-solution ((the-graph planning-graph) goals n)
  "Extract a solution from a planning graph."
  ;; We're considering actions at the level previous to the one the
  ;; goals appear in, hence the (1- n).
  (brute-force-extract the-graph goals (1- n)))

;;; Note: This is brute force in the sense that do-subsets
;;; (i.e. walking a power set) plus the recursion produce a
;;; depth-first search through the planning graph, with all that
;;; entails for time complexity.

;;; Implementation note: Using an accumulator, acc, is a common idiom.
;;; Since brute-force-extract works backward in the graph, sets of
;;; actions are collected in the correct, forward order when they're
;;; consed onto acc.

(defun brute-force-extract (graph goals n &optional (acc nil))
  "Extract a solution by working backward through a planning graph, testing all subsets."
  (flet ((actions-for-goals (actions)
	   (find-all-if (lambda (action)
			  (intersection-p (action-effect action) goals
					  :test #'literals-eql))
			actions)))
    ;; The first cond branch covers null plans as well as the recursive base case.
    (cond ((minusp n) (values acc t))
	  (t (do-subsets (actions (actions-for-goals (level-actions graph n)))
	       (when (and (non-mutex-set-p actions graph n)
			  (actions-have-effects-p actions goals))
		 ;; The set of actions is not mutex and it satisfies the goals.
		 (let ((preconditions (collect-action-literals #'action-precond actions)))
		   ;; Set up the same condition that's tested in the function simple-GP.
		   (when (goals-non-mutex-p preconditions graph n) 
		     (multiple-value-bind (solution foundp)
			 ;; Recurse, testing for all preconditions of the candidate actions.
			 (brute-force-extract graph preconditions (1- n) (cons actions acc))
		       (when foundp
			 ;; It's not sufficient simply to have found a
			 ;; solution; we need to break out of the iteration.
			 (return-from brute-force-extract (values solution t))))))))))))

;;; ==============================
;;; Utilities

;;; Accessing levels in a planning graph

(defmethod level-state ((the-graph planning-graph) n)
  "Return the set of literals associated with level N."
  (single-level-state (elt (levels the-graph) n)))

(defmethod level-actions ((the-graph planning-graph) n)
  "Return the set of actions associated with level N."
  (single-level-actions (elt (levels the-graph) n)))

(defmethod level-state-count ((the-graph planning-graph) n)
  "Return the number of literals associated with level N."
  (single-level-state-count (elt (levels the-graph) n)))

(defmethod level-state-mutex-count ((the-graph planning-graph) n)
  "Return the number of literal mutexes associated with level N."
  (single-level-state-mutex-count (elt (levels the-graph) n)))

;;; ------------------------------
;;; Handling mutexes

;;; For convenience, we define functions to set and get mutex
;;; relations, hiding their implementation as hash table entries.
;;; Mutex relations might be cached more transparently, with
;;; memoization of the functions that compute them, literals-mutex-p
;;; and actions-mutex-p, but the resulting code would be less obvious
;;; about when the computation versus the look-up is taking place.
;;; Further, we need to count some mutexes, which means that
;;; general-purpose memoization on arbitrary arguments doesn't meet
;;; our needs.

;;; A mutex relation is just a cons of two literals or two actions.

(defun make-mutex (x y) (cons x y))

;;; Mutexes are unordered, but...
(defun mutex-1 (cons) (car cons))
(defun mutex-2 (cons) (cdr cons))

;;; Implementation note: We've seen an analogous problem of storing a
;;; set of pairs, in the ordering relations of simple-POP plans.  Why
;;; don't we store mutex objects in a list?  For the largest problem
;;; in simple-problems.lisp, back-and-forth in the cargo domain,
;;; simple-GP generates 648 propositional actions from three
;;; first-order actions and six objects.  Traversing a linear list of
;;; O(N^2) mutex relations would be much more expensive than looking
;;; them up in a hash table, even given the overhead of creating and
;;; maintaining the table.  Whether simple-POP would be improved by
;;; modifying its representation of ordering relations is an open
;;; question.  (Preliminary answer: doubtful.)

(defun set-mutex-entry (x y table)
  (setf (gethash (make-mutex x y) table) t))

(defun mutex-entry (x y table)
  ;; Allow mutexes to be tested in either order.
  (or (gethash (make-mutex x y) table)
      (gethash (make-mutex y x) table)))

;;; For conciseness, we'll use a mutex-relation method to refer either
;;; to literal/literal or action/action mutex relations.
(defmethod mutex-relation ((l1 t) (l2 t) (the-graph planning-graph) n)
  (mutex-entry l1 l2 (single-level-state-mutex-relations (elt (levels the-graph) n))))

(defmethod mutex-relation ((a1 propositional-action) (a2 propositional-action)
			   (the-graph planning-graph) n)
  (mutex-entry a1 a2 (single-level-action-mutex-relations (elt (levels the-graph) n))))

(defun non-mutex-set-p (items graph n)
  "Return NIL if some pair of literals or a pair of actions is
   mutex, based on cached mutex values; otherwise T."
  (not (some-unordered-pair #'(lambda (x1 x2)
				(mutex-relation x1 x2 graph n))
			    items)))

;;; ------------------------------
;; Action predicates

(defun action-achieves-literal-p (action literal)
  (find literal (action-effect action) :test #'literals-eql))

(defun actions-have-effects-p (actions literals)
  "Test whether every literal is in the effect of some action."
  (every #'(lambda (literal)
	     (some #'(lambda (action)
		       (action-achieves-literal-p action literal))
		   actions))
	 literals))

;;; ------------------------------
;;; A collection utility

(defun collect-action-literals (key actions)
  (remove-duplicates (mappend key actions) :test #'literals-eql))

;;; ==============================
;;; EOF