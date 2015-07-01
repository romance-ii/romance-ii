;;; -*- Mode: Lisp; Syntax: Common-Lisp; -*-

(in-package #.*simple-planners-package-name*)

;;; Copyright 2010 by Stephen G. Ware and Robert St. Amant.

;;; To download the code for the simple planners, visit
;;; <http://www.csc.ncsu.edu/faculty/stamant/simple-planners/simple-planners.html>.

;;; This software is released under the license described by Peter
;;; Norvig: <http://www.norvig.com/license.html>.  If you find this
;;; software useful, please send email to <stamant@csc.ncsu.edu>.

;;; About simple-GP-CSP.lisp:

;;; This is a simple, specialized CSP solver for simple-GP.  It
;;; replaces the exhaustive examination of the power set of actions
;;; for satisfying a set of goals with a less naive approach.

;;; The top-level function is simple-GP, which takes as arguments an
;;; initial world state, a comparable goal state, and a list of
;;; actions.  The most convenient way to invoke this planner, however,
;;; is via a call to PLAN, which handles access to specific problems
;;; and domains:
#||
(plan (make-instance 'GP-CSP-planner) 'sussman :domain 'blocksworld)
||#
;;; PLAN calls RUN-PLANNER, defined below.  RUN-PLANNER-TESTS is a
;;; testing function overall all the domains this planner can handle.

;;; ==============================
;;; Planner definition

(defclass GP-CSP-planner (GP-planner)
  ()
  ;; Planning graph construction uses GP-planner functionality, but
  ;; solution extraction is based on an extract-solution specialized
  ;; to GP-CSP-planning-graph.
  (:default-initargs
   :planner-bindings '((*action-class* propositional-action)
		       (*plan-class* gp-plan)
		       (*planning-graph-class* CSP-planning-graph))))

;;; See run-planner in simple-gp.lisp.

#+testing
(run-planner-tests (make-instance 'GP-CSP-planner)
		   (append *propositional-problems-and-domains*
			   *first-order-problems-and-domains*))

;;; ==============================
;;; Top-level planning function

;;; See simple-GP in simple-gp.lisp.

;;; ==============================
;;; CSP definition

;;; Create a CSP from a list of goals--a CSP is just a list of
;;; constraints.

(defun make-CSP (goals graph n)
  "Build a constraint satisfaction problem from a set of goals."
  (flet ((new-constraint (goal)
	   (make-constraint
	    ;; Build a constraint from a goal...
	    goal
	    ;; ...and the actions that achieve it.
	    (find-all-if #'(lambda (action)
			     (action-achieves-literal-p action goal))
			 (level-actions graph n)))))
    (if (< n 0)
	nil
	;; Build the CSP.  Each goal is associated with the actions that
	;; can be carried out to achieve it.
	(sort-CSP (mapcar #'new-constraint goals)))))

;;; ==============================
;;; Extracting solutions from a planning graph

;;; extract-solution is just a front-end for the real workhorse
;;; method, needed because in the recursive extraction process, a plan
;;; is constructed in reverse order.

(defmethod extract-solution ((the-graph CSP-planning-graph) goals n)
  "Call extract-CSP-solution to find a solution; if one is found, reverse it."
  (decf n)
  (multiple-value-bind (solution foundp)
      (extract-CSP-solution (make-CSP goals the-graph n) the-graph n)
    (when foundp ; Redundant--extract-CSP-solution returns nil on failure.
      (values (reverse solution) foundp))))

;;; ==============================
;;; Solution extraction

;;; extract-CSP-solution extracts a solution from a planning graph.
;;; extract-CSP-solution is first called with a CSP constructed from
;;; the goals at the nth level of the graph, along with the actions
;;; that can achieve those goals.  It finds a plan in two stages.

;;; Suppose that in the CSP, each constraint consists of a goal and
;;; just one candidate action to satisfy it.  If all of these actions
;;; are non-mutex, then the current level of the graph is done, and
;;; the function recurses on the previous level.

;;; If the CSP is not fully constrained, then there's at least one
;;; goal that has more than one candidate action to satisfy it.
;;; extract-CSP-solution calls constrain-CSP to try alternative
;;; actions for such a goal, for all goals.  There's mutual recursion,
;;; using a conventional Lisp idiom: once constrain-CSP does its work,
;;; it calls extract-CSP-solution to check the result.  This
;;; level-by-level testing can be inefficient, but it produces
;;; relatively understandable code.

(defun extract-CSP-solution (CSP graph n)
  "Extract a solution from a CSP.  If every goal has a single
  action assigned to it, check to ensure that all actions are
  mutex and recurse.  If not all goals are so constrained, call
  constrain-CSP."
  (flet ((CSP-for-level (actions)
	   (make-CSP (collect-action-literals #'action-precond actions)
		     graph (1- n))))
    (cond ((< n 0) (values nil t))	; Beginning of graph--success!
	  ((every #'single-action CSP) ; CSP fully constrained; check for solution.
	   (let ((actions (CSP-values CSP)))
	     ;; The nested 'ands' indicate that nil is returned if a
	     ;; solution is not found.
	     (and (non-mutex-set-p actions graph n)
		  ;; Success at current level; move back one level.
		  (multiple-value-bind (solution found-p)
		      (extract-CSP-solution (CSP-for-level actions) graph (1- n))
		    (and found-p
			 (values (cons actions solution) t))))))
	  ;; CSP not fully constrained; constrain more variables.
	  (t (constrain-CSP CSP graph n)))))

;;; Implementation note: The function constrain-CSP has a similarity
;;; to brute-force-extract, in simple-gp.lisp, in that it's testing
;;; solutions within an iteration (here nested).  When a solution is
;;; found (here in the form of a set of assignments that works), the
;;; function needs to break out of the iterations and return it.

(defun constrain-CSP (CSP graph n)
  "Create a new CSP from the input by walking through the list of
  constraints and assigning each goal to one of its candidate
  actions.  Test each new CSP by a call to extract-CSP-solution."
  (dolist (constraint CSP)
    (unless (single-action constraint) ; Goals achieved by one action are already done.
      (dolist (action (constraint-actions constraint))
	(let ((new-CSP (constrain-CSP-variable CSP (constraint-goal constraint) action
					       ;; Inconsistency test
					       (lambda (a)
						 (mutex-relation a action graph n)))))
	  (when (not (null new-CSP))
	    ;; Consistent assignment; check it out.
	    (multiple-value-bind (solution found-p)
		(extract-CSP-solution new-CSP graph n)
	      (when found-p
		(return-from constrain-CSP (values solution t))))))))))

;;; Sort the CSP so that goals with the smallest number of relevant
;;; actions are first.  This is a simple form of dynamic variable
;;; ordering, which speeds up solution extraction.

(defun sort-CSP (CSP)
  "Sort a CSP so that the variables with the fewest options are first."
  (flet ((action-sorter (a1 a2)
	   (declare (ignore a2))
	   ;; Persistent actions should be tried first.
	   (action-persistent-p a1))
	 (constraint-sorter (c1 c2)
	   ;; Inefficient--could use :key #'constraint-actions, but for consistency.
	   (< (length (constraint-actions c1)) (length (constraint-actions c2)))))
    (sort (mapcar (lambda (constraint)
		    (make-constraint (constraint-goal constraint)
				     (sort (constraint-actions constraint)
					   #'action-sorter)))
		  CSP)
	  #'constraint-sorter)))

;;; Assign a goal to be achieved by a specific action, unless this
;;; produces an inconsistency.

(defun constrain-CSP-variable (CSP goal action action-inconsistency-test)
  "Constrain a CSP by assigning var the given value."
  ;; This function does backward and forward checking, though not very
  ;; efficiently, because it's not keeping track of constraints that
  ;; have already been processed, i.e., their ordering in the CSP.

  ;; Processing: If a variable has a value in its range that would be
  ;; inconsistent with the current assignment, remove that value.  If
  ;; the range is reduced to nil, return nil for the CSP.  Otherwise
  ;; use the reduced range for the variable.
  (loop for constraint in CSP collect
       (cond ((eql goal (constraint-goal constraint))
	      (make-constraint goal (list action)))
	     ((some action-inconsistency-test (constraint-actions constraint))
	      (aif (remove-if action-inconsistency-test
			      (constraint-actions constraint))
		   ;; Use only consistent assignments.
		   (make-constraint (constraint-goal constraint) it)
		   ;; All consistent assignments have gone away. Return nil.
		   (return-from constrain-CSP-variable nil))) ; non-local exit
	     (t constraint))))

;;; Get the actions assigned to the goals in the CSP.

(defun CSP-values (CSP)
  "Extract the set of fully constrained values from a CSP."
  (remove-duplicates (all-such-that #'single-action CSP) :test #'constraints-eql))

;;; ==============================
;;; Utilities and syntactic sugar

;;; A constraint is a list.  The first element of the list is a
;;; variable (a goal), and the rest are values (actions to achieve the
;;; goal).  The approach gradually constrains the CSP by trying
;;; individual actions for goals.

(defun make-constraint (goal actions) (cons goal actions))

(defun constraint-goal (constraint) (first constraint))
(defun constraint-actions (constraint) (rest constraint))

(defun constraints-eql (c1 c2) (equal c1 c2))

(defun single-action (constraint)
  (and (null (rest (constraint-actions constraint)))
       (first (constraint-actions constraint))))

;;; ==============================
;;; EOF
