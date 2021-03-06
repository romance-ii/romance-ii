;;; -*- Mode: Lisp; Syntax: Common-Lisp; -*-

(in-package #.*simple-planners-package-name*)

;;; Copyright 2010 by Stephen G. Ware and Robert St. Amant.

;;; To download the code for the simple planners, visit
;;; <http://www.csc.ncsu.edu/faculty/stamant/simple-planners/simple-planners.html>.

;;; This software is released under the license described by Peter
;;; Norvig: <http://www.norvig.com/license.html>.  If you find this
;;; software useful, please send email to <stamant@csc.ncsu.edu>.

;;; About simple-SAT.lisp:

;;; This file contains the main simple-SAT methods and the functions
;;; needed to convert a planning graph into logical axioms suitable
;;; for a SAT problem solver and the result back into a plan.

;;; The top-level function is simple-GP, which takes as arguments an
;;; initial world state, a comparable goal state, and a list of
;;; actions.  The most convenient way to invoke this planner, however,
;;; is via a call to PLAN, which handles access to specific problems
;;; and domains:
#||
(plan (make-instance 'SAT-planner) 'sussman :domain 'blocksworld)
||#
;;; PLAN calls RUN-PLANNER, defined below.  RUN-PLANNER-TESTS is a
;;; testing function overall all the domains this planner can handle.

;;; Planning has traditionally been thought of as logical deduction,
;;; but in 1991 Kautz and Selman demonstrated that planning problems
;;; can be converted into Boolean satisfiability problems (Planning
;;; as satisfiability, 1991).  This was potentially helpful because
;;; an entire branch of AI is dedicated to building better SAT
;;; solvers, so perhaps these solvers could be used to speed up the
;;; process of planning as well.  This turned out to be true, with
;;; SAT-based planners winning several awards for speed at
;;; international planning conferences.

;;; In "Pushing the Envelope: Planning, Propositional Logic, and
;;; Stochastic Search" (PPSS 1996), Kautz and Selman demonstrated
;;; that the planning graphs generated by GraphPlan could be
;;; directly converted into a set of logical axioms (aka, into a
;;; SAT problem) that was smaller and better than their original
;;; formulation.  That process is recreated below in simple-SAT.

;;; The simple-SAT planner builds on simple-GP, but extends it by
;;; using SAT solving methods to extract solutions.  There are three
;;; main steps:

;;; 1. Convert the graph into a set of logical axioms in conjunctive
;;;    normal form. (simple-SAT.lisp)
;;; 2. Solve the SAT problem. (simple-SAT-solver.lisp)
;;; 3. Translate the solution back into a readable plan. (simple-SAT.lisp)

;;; A planning graph can generate quite a lot of axioms.  For example,
;;; the two-level graph for the very simple Have and Eat Cake problem
;;; turns into the following set of axioms (before conversion into
;;; conjunctive normal form):

;;; (AND #:HAVE-CAKE-0-15
;;;      (NOT #:EATEN-CAKE-0-16)
;;;      #:HAVE-CAKE-2-22
;;;      #:EATEN-CAKE-2-23
;;;      (IF #:EAT-CAKE-0-19 #:HAVE-CAKE-0-15)
;;;      (IF #:PERSIST-HAVE-CAKE-0-20 #:HAVE-CAKE-0-15)
;;;      (IF #:PERSIST-NOT-EATEN-CAKE-0-21 (NOT #:EATEN-CAKE-0-16))
;;;      (OR (NOT #:EAT-CAKE-0-19) (NOT #:PERSIST-NOT-EATEN-CAKE-0-21))
;;;      (OR (NOT #:EAT-CAKE-0-19) (NOT #:PERSIST-HAVE-CAKE-0-20))
;;;      (IF (NOT #:HAVE-CAKE-1-17) #:EAT-CAKE-0-19)
;;;      (IF #:EATEN-CAKE-1-18 #:EAT-CAKE-0-19)
;;;      (IF #:HAVE-CAKE-1-17 #:PERSIST-HAVE-CAKE-0-20)
;;;      (IF (NOT #:EATEN-CAKE-1-18) #:PERSIST-NOT-EATEN-CAKE-0-21)
;;;      (IF #:EAT-CAKE-1-24 #:HAVE-CAKE-1-17)
;;;      (IF #:BAKE-CAKE-1-25 (NOT #:HAVE-CAKE-1-17))
;;;      (IF #:PERSIST-NOT-HAVE-CAKE-1-26 (NOT #:HAVE-CAKE-1-17))
;;;      (IF #:PERSIST-EATEN-CAKE-1-27 #:EATEN-CAKE-1-18)
;;;      (IF #:PERSIST-HAVE-CAKE-1-28 #:HAVE-CAKE-1-17)
;;;      (IF #:PERSIST-NOT-EATEN-CAKE-1-29 (NOT #:EATEN-CAKE-1-18))
;;;      (OR (NOT #:PERSIST-NOT-HAVE-CAKE-1-26) (NOT #:PERSIST-HAVE-CAKE-1-28))
;;;      (OR (NOT #:PERSIST-EATEN-CAKE-1-27) (NOT #:PERSIST-NOT-EATEN-CAKE-1-29))
;;;      (OR (NOT #:EAT-CAKE-1-24) (NOT #:PERSIST-NOT-HAVE-CAKE-1-26))
;;;      (OR (NOT #:EAT-CAKE-1-24) (NOT #:PERSIST-NOT-EATEN-CAKE-1-29))
;;;      (OR (NOT #:EAT-CAKE-1-24) (NOT #:PERSIST-HAVE-CAKE-1-28))
;;;      (OR (NOT #:EAT-CAKE-1-24) (NOT #:BAKE-CAKE-1-25))
;;;      (OR (NOT #:BAKE-CAKE-1-25) (NOT #:PERSIST-NOT-HAVE-CAKE-1-26))
;;;      (OR (NOT #:BAKE-CAKE-1-25) (NOT #:PERSIST-HAVE-CAKE-1-28))
;;;      (IF (NOT #:HAVE-CAKE-2-22) (OR #:EAT-CAKE-1-24 #:PERSIST-NOT-HAVE-CAKE-1-26))
;;;      (IF #:EATEN-CAKE-2-23 (OR #:EAT-CAKE-1-24 #:PERSIST-EATEN-CAKE-1-27))
;;;      (IF #:HAVE-CAKE-2-22 (OR #:BAKE-CAKE-1-25 #:PERSIST-HAVE-CAKE-1-28))
;;;      (IF (NOT #:EATEN-CAKE-2-23) #:PERSIST-NOT-EATEN-CAKE-1-29))

;;; This example demonstrates two important things about simple-SAT.
;;; Firstly, all axioms are in Lisp-style syntax so that they can be
;;; easily read and manipulated.

;;; Secondly, all of the variables in the axioms (which correspond to
;;; actions or facts in a plan) include a time stamp.  For example,
;;; the variable #:BAKE-CAKE-1-25 corresponds to the BAKE-CAKE action
;;; happening at time 1.  (The "#:" prefix and "-25" suffix are Lisp
;;; artifacts.)  If this variable is set to true in the SAT solution,
;;; it means that the BAKE-CAKE action happens at time 1.  If it is
;;; set to false, the BAKE-CAKE action does not happen at time 1.
;;; #:HAVE-CAKE-0-15 corresponds to whether or not the fact HAVE-CAKE
;;; is true in the initial state.  If this variable is set to true in
;;; the SAT solution (which it must be), then it means HAVE-CAKE holds
;;; in the initial state.

;;; Time steps correspond to the action and literal levels of
;;; GraphPlan.  Even numbered times are "state times," and odd
;;; numbered times are "action times."  In other words, all states
;;; occur at even time steps and all actions occur at odd time steps.

;;; ==============================
;;; Planner definition

(defclass SAT-planner (GP-planner)
  ()
  ;; Planning graph construction uses GP-planner functionality, but
  ;; solution extraction is based on an extract-solution specialized
  ;; to SAT-planning-graph.
  (:default-initargs
   :planner-bindings '((*action-class* propositional-action)
		       (*plan-class* gp-plan)
		       (*planning-graph-class* SAT-planning-graph))))

(defmethod initialize-state ((the-planner SAT-planner) initial-state goals actions)
  (close-world initial-state goals actions :closure '(:goal :actions)))

;;; run-planner defined in simple-gp.lisp.

#+testing
(run-planner-tests (make-instance 'SAT-planner)
		   (append *propositional-problems-and-domains*
			   *first-order-problems-and-domains*))

;;; ==============================
;;; Top-level planning function

;;; See simple-GP in simple-gp.lisp.

;;; ==============================
;;; Extracting solutions from a planning graph

;;; Convert a planning graph into a set of logical axioms, and then
;;; search for a way to satisfy all of those axioms.  If a solution
;;; is found, it means a plan exists.

(defmethod extract-solution ((the-graph SAT-planning-graph) goals n)
  "Extract a solution from a planning graph via a SAT technique."
  (let ((SAT-solution (solve-SAT	; Solve the SAT problem.
		       (simplify-SAT	; Simplify the axioms.
			(axioms-to-cnf  ; Convert axioms to conjunctive normal form.
			 (graph-axioms the-graph goals n))))))
    (when SAT-solution
      ;; Translate the plan back into a set of actions
      (values (translate-SAT-solution-to-plan SAT-solution the-graph n) t))))

;;; ==============================
;;; Axiom Generation Methods

;;; Convert an entire graph into a set of logical axioms.

(defun graph-axioms (graph goals n)
  ;; Collect axioms for the initial state, the goal state, and all graph levels.
  `(and ,@(loop for fact in (level-state graph 0)
	     collect (make-literal-variable graph fact 0))
	,@(loop for fact in goals
	     collect (make-literal-variable graph fact n))
	,@(loop for j from 0 to n
	     ;; For each level of a graph there are three kinds of axioms.
	     append (establishing-action-axioms graph j)
	     append (action-precond-axioms graph j)
	     append (mutex-axioms graph j))))

;;; ------------------------------
;;; Establishing Action Axioms

;;; Quoted from PPSS:
;;;
;;; "Each fact at level i implies the disjunction of all the
;;; operators at level i-1 that have it as an add effect."
;;;
;;; An establishing action axiom explains how a fact can come about:
;;; by one of the actions (including persistence actions) which has
;;; that fact as an effect.  If more than one action could have
;;; brought about a fact, only one needs to be chosen.
;;;
;;; In the Dinner Date example, it is possible that (NOT GARBAGE)
;;; occurs in the second state (after the first set of actions is
;;; applied).  This fact could have been caused by two different
;;; actions: CARRY or DOLLY.  Thus, we get the following axiom:
;;;
;;; (IF (NOT GARBAGE-2) (OR CARRY-1 DOLLY-1))
;;;
;;; In other words, if the garbage has been taken out by time 2,
;;; it means that either you carried it out or you dollied it out
;;; at time 1.

(defun establishing-action-axioms (graph n)
  ;; First level has no establishing actions
  (if (= n 0)
      nil
      (loop for fact in (level-state graph n) collect
	 ;; Convert the actions that establish this fact into variables
	   (let ((establishers (mapcar (lambda (action)
					 (make-action-variable graph action (1- n)))
				       (establishing-actions fact graph n))))
	     `(if ,(make-literal-variable graph fact n)
		  ,(singularize-form establishers 'or))))))
    
(defun establishing-actions (fact graph n)
  "Return all of the actions that establish a given fact."
  (find-all-if (lambda (action)
		 (find fact (action-effect action) :test #'literals-eql))
	       (level-actions graph (1- n))))

(defun singularize-form (operands operator)
  "Given a list of operands of length > 1, turn it into a conjunction or disjunction,
  depending on operator.  If just one element is in the list, return that element."
  (if (null (rest operands))
      (first operands)
      `(,operator ,@operands)))

;;; ------------------------------
;;; Action Precondition Axioms

;;; Quoted from PPSS:
;;;
;;; "Operators imply their preconditions."
;;;
;;; This may seem strange because we usually think of an operator as
;;; implying its effects.  But effects are handled by other axioms.
;;; An action precondition axiom makes sure that an action can only
;;; be included in a plan if its preconditions hold at the previous
;;; level.
;;;
;;; In the Flat Tire example, the PUTON-SPARE-AXLE action requires
;;; that the spare tire be on the ground and that the flat tire not
;;; be on the axle.  Thus, we get this axiom:
;;;
;;; (IF PUTON-SPARE-AXLE-1 (AND SPARE-ON-GROUND-0 (NOT FLAT-AT-AXLE-0)))
;;;
;;; Note that in the Fix Flat problem, this axiom will prevent the
;;; PUTON-SPARE-AXLE action from happening at time 1.  This is good,
;;; because its preconditions do not hold in the initial state.
;;;
;;; An action precondition axiom might get converted into several
;;; axioms once we put it in conjunctive normal form.  See the
;;; description of (if-to-or) for more details.

(defun action-precond-axioms (graph n)
  ;; For each action at this level of the graph...
  (loop for action in (level-actions graph n) 
     ;; Convert the precondition of this action into SAT literals
     for preconds = (mapcar (lambda (fact)
			      (make-literal-variable graph fact n))
			    (action-precond action))
     ;; Include only actions with preconditions
     when preconds
     collect `(if ,(make-action-variable graph action n)
		  ,(singularize-form preconds 'and))))

;;; ------------------------------
;;; Action Mutex Axioms

;;; Quoted from PPSS:
;;;
;;; "Conflicting [mutex] actions are mutually exclusive."
;;;
;;; An action mutex axiom is a direct translation of a GraphPlan
;;; mutex into a logical axiom.  This prevents mutex actions from
;;; being executed at the same time.
;;;
;;; In the Dinner Date example, the CARRY and COOK actions are mutex
;;; because CARRY undoes the CLEANHANDS condition needed for COOK.
;;; Thus, we get this axiom:
;;;
;;; (OR (NOT CARRY-1) (NOT COOK-1))
;;;
;;; In other words, you can do one, but not both.  According to PPSS,
;;; the literal mutexes generated by GraphPlan do not need to be
;;; included as axioms, only action mutexes.

(defun mutex-axioms (graph n)
  (mapcar (lambda (mutex)
	    ;; One may happen, but not both.
	    `(or (not ,(make-action-variable graph (mutex-1 mutex) n))
		 (not ,(make-action-variable graph (mutex-2 mutex) n))))
	  (level-action-mutexes graph n)))

;;; Get all the action mutexes from one level of the graph.

(defun level-action-mutexes (graph n)
  (let ((mutexes nil))
    (maphash (lambda (key value)
	       (declare (ignore value))
	       (push key mutexes))
             (single-level-action-mutex-relations (elt (levels graph) n)))
    mutexes))

;;; ==============================
;;; Conversion Utilities

;;; Convert a set of axioms into conjunctive normal form (CNF).  The
;;; axioms should already be in CNF, except that some may be 'if'
;;; axioms.  Those need to be converted.

(defun axioms-to-cnf (axioms)
  `(and ,@(loop for axiom in (conjuncts axioms)
	     if (implicationp axiom)
	     append (disjuncts (if-to-or axiom))
	     else collect axiom)))

;;; Convert an 'if' axiom into an 'or' axiom.  The following two
;;; axioms are logically equivalent:
;;;
;;; (IF ANTECEDENT CONSEQUENT)
;;; (OR (NOT ANTECEDENT) CONSEQUENT)
;;;
;;; However, the consequent might be a conjunction or disjunction of
;;; literals.  If the consequent is a disjunction, the conversion is
;;; easy thanks to the associative property of boolean logic:
;;;
;;; (IF ANTECEDENT (OR CONSEQUENT-1 CONSEQUENT-2))
;;; (OR (NOT ANTECEDENT) CONSEQUENT-1 CONSEQUENT-2)
;;;
;;; Conjunctive consequents are a little harder.  We need the
;;; distributive property of boolean logic.  This means that one
;;; axiom might become many.
;;;
;;; (IF ANTECEDENT (AND CONSEQUENT-1 CONSEQUENT-2))
;;; (AND (OR (NOT ANTECEDENT) CONSEQUENT-1)
;;;      (OR (NOT ANTECEDENT) CONSEQUENT-2))

(defun if-to-or (statement)
  (destructuring-bind (antecedent consequent) (operands statement)
    ;; Axioms of the form (if A (and B C)) must be split
    ;; into multiple axioms.
    (if (conjunctionp consequent)
        `(and ,@(mapcar (lambda (fact)
			  `(or ,(negate antecedent) ,fact))
			(conjuncts consequent)))
        ;; Axioms of the form (if A B) become (or (not A) B)
	`(and (or ,(negate antecedent)
		  ,@(if (disjunctionp consequent)
			;; (if A (or B C)) becomes (or (not A) B C).
			(disjuncts consequent)
			;; Literals remain as is.
			(list consequent)))))))

;;; ==============================
;;; Low-level encoding: a plan (in a planning graph) to a SAT problem

;;; Encoding and decoding SAT literals: For efficiency, we'd like the
;;; basic data structure for the SAT algorithm to be a symbol, rather
;;; a cons of a literal/action and its level in the planning graph.
;;; We need to consistently encode such a pairing as a symbol for the
;;; SAT algorithm to work on.  If EATEN-CAKE and (not EATEN-CAKE)
;;; happen to appear at the same level, we want both plan variables to
;;; map to the same SAT variable.  We need to consistently decode some
;;; symbols as well, back to planning actions and levels.  We do this
;;; in a slightly sloppy way, by dumping both mappings into the same
;;; hash table, plan-object-table.  The code would be more concise if
;;; we used Lisp symbols in the CL-USER package, but we'd like to
;;; avoid polluting that package with a lot of random symbols.

;;; Syntactic sugar, for clarity in decoding a SAT representation.
(defstruct (action-variable (:type list) (:constructor action-variable))
  action time)

(defun make-action-variable (graph action time)
  (with-slots (plan-object-table) graph
    (let* ((persistentp (action-persistent-p action))
	   ;; Actions at different levels are different SAT variables.
	   (key (list (action-name action) (1+ (* 2 time))))
	   (symbol (or (gethash key plan-object-table)
		       (setf (gethash key plan-object-table)
			     (gensym (pretty-string 
				      (list (action-name action) time)
				      (and persistentp "PERSIST")))))))
      (unless (action-persistent-p action)
	;; To map a SAT solution back to a plan, we need the action
	;; object and its level.
	(setf (gethash symbol plan-object-table)
	      (action-variable :action action :time time)))
      symbol)))

;;; This is awkwardly named: It creates a SAT literal of the same
;;; polarity as the planning literal at a given level (i.e., if the
;;; planning variable is negated, so is the SAT literal returned).  It
;;; creates a new symbol as a SAT variable and caches its relationship
;;; to the planning variable, so that a consistent mapping can be
;;; maintained.

(defun make-literal-variable (graph literal time)
  (with-slots (plan-object-table) graph
    (let* ((negatedp (negated-literal-p literal))
	   (positive-literal (if negatedp (negate literal) literal))
	   ;; Literals at different levels are different SAT variables,
	   ;; but they're the same variable whether negated or not.
	   (key (list positive-literal (* 2 time)))
	   (symbol (or (gethash key plan-object-table)
		       (setf (gethash key plan-object-table)
			     (gensym (pretty-string (list positive-literal time)))))))
      ;; Return the SAT variable (negated if the original literal was negated)
      (if negatedp
	  (negate symbol)
	  symbol))))

;;; ------------------------------
;;; Decoding: a SAT solution to a plan

;;; Once a solution has been found to the SAT problem, we need to
;;; translate that solution back into a plan.  If a variable in the
;;; SAT problem corresponds to an action, and if that variable has
;;; been set to true in the solution, we need to add that action to
;;; the plan.  Persistence actions have not been added to the
;;; plan-object-table, so they'll be automatically eliminated.

(defun translate-SAT-solution-to-plan (SAT-solution graph n)
  (with-slots (plan-object-table) graph
    ;; Add an empty list for each level of the graph
    (let ((plan (make-list n :initial-element nil)))
      ;; If an action's variable is true in the SAT solution,
      ;; add it to (the appropriate level of) the plan.
      (dolist (binding SAT-solution)
	(awhen (and (binding-val binding)
		    (gethash (binding-var binding) plan-object-table))
	  (push (action-variable-action IT)
		(nth (action-variable-time IT) plan))))
      ;; A SAT solution may not be the most compact plan.  Do one obvious fixup.
      (remove-noops (level-state graph 0) plan))))

(defun remove-noops (state plan)
  ;; We don't have a planning graph to check here, so let's walk
  ;; through the plan itself.  (Could we re-use a planning graph?  Not
  ;; in the current implementation.)
  (loop for level in plan
     collect (loop for action in level
		;; An action is a noop if every effect is already in
		;; the current state.  Assumes negations are explicit.
		unless (subsetp (action-effect action) state :test #'literals-eql)
		collect action)
     do (loop for action in level do
	     (setf state (apply-action action state)))))

;;; ==============================
;;; Other utilities

;;; This is mainly for debugging; anonymous gensyms would do as well.

(defun pretty-string (elements &optional prefix)
  (labels ((listify (x) (if (listp x) x (list x)))
	   (flatten (list)
	     (apply #'append (mapcar #'listify list))))
    (remove-if #'(lambda (c)
		   (find c " .,;:`!?#()\\\"<>"))
	       (format nil "~@[~A-~]~{~A-~}"
		       prefix
		       (flatten (listify elements))))))

;;; ==============================
;;; EOF