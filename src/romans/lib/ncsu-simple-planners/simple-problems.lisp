;;; -*- Mode: Lisp; Syntax: Common-Lisp; -*-

(in-package #.*simple-planners-package-name*)

;;; Copyright 2007 by Robert St. Amant.

;;; To download the code for the simple planners, visit
;;; <http://www.csc.ncsu.edu/faculty/stamant/simple-planners/simple-planners.html>.

;;; This software is released under the license described by Peter
;;; Norvig: <http://www.norvig.com/license.html>.  If you find this
;;; software useful, please send email to <stamant@csc.ncsu.edu>.

;;; About simple-problems.lisp:

;;; This file contains domains and problems for testing the planners.
;;; See the end of simple-planners.lisp for aggregate tests for the
;;; planners on the problems to which each can be applied.

;;; Not all of the planners will work with all of the problems.
;;; Specifically:

;;; * The propositional-POP-planner will not work for any of the
;;;   domains containing first-order actions, starting with
;;;   getting-dressed-1 below.

;;; * The POP planners do not handle all problems with negated
;;;   literals in goals, for reasons yet to be discovered.

;;; * Some of the problems are too large for some of the planners.

;;; ==============================
;;; Propositional planning domains and problems

;;; ------------------------------
;;; Getting dressed [AIMA, p. 388]

(define (domain socks-and-shoes)
  (:action Right-Shoe :precond Right-Sock-On :effect Right-Shoe-On)
  (:action Right-Sock :precond nil :effect Right-Sock-On)
  (:action Left-Shoe :precond Left-Sock-On :effect Left-Shoe-On)
  (:action Left-Sock :precond nil :effect Left-Sock-On))

(define (problem put-on-shoes)
    (:domain socks-and-shoes)
  (:init)
  (:goal (and Right-Shoe-On Left-Shoe-On)))

;;; ------------------------------
;;; Negated literals in goals

(define (domain rooms)
  (:action open-door :precond (not door-open) :effect door-open)
  (:action move-between-rooms
	   :precond (and door-open
			 in-first-room (not in-second-room))
	   :effect (and (not in-first-room) in-second-room))
  (:action close-door :precond door-open :effect (not door-open)))

(define (problem close-door)
    (:domain rooms)
  (:init door-open)
  (:goal (not door-open)))

(define (problem change-rooms)
    (:domain rooms)
  (:init (not door-open) in-first-room)
  (:goal (and (not door-open) in-second-room)))

;;; ------------------------------
;;; Changing a flat tire [AIMA, p. 391]

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

;;; An alternative implementation

(define (domain alternative-flat-tire)
  (:action remove-spare-trunk
	   :precond spare-in-trunk
	   :effect (and (not spare-in-trunk) spare-on-ground))
  (:action remove-flat-from-axle
	   :precond flat-at-axle
	   :effect (and (not flat-at-axle) flat-on-ground))
  (:action puton-spare-axle
	   :precond (and spare-on-ground (not flat-at-axle))
	   :effect (and (not spare-on-ground) spare-at-axle))
  (:action leave-overnight
	   :precond ()
	   :effect (and (not spare-on-ground) (not spare-at-axle) (not spare-in-trunk) (not flat-on-ground) (not flat-at-axle))))

(define (problem alternative-fix-flat)
    (:domain alternative-flat-tire)
  (:init flat-at-axle spare-in-trunk (not spare-at-axle) (not flat-on-ground) (not spare-on-ground))
  (:goal spare-at-axle))

;;; ------------------------------
;;; The "have cake and eat cake too" problem [AIMA, p. 391]

(define (domain cake)
  (:action eat-cake :precond have-cake :effect (and (not have-cake) eaten-cake))
  (:action bake-cake :precond (not have-cake) :effect have-cake))

(define (problem have-and-eat)
    (:domain cake)
  (:init have-cake (not eaten-cake)) 
  (:goal (and have-cake eaten-cake)))

;;; ------------------------------
;;; Dan Weld's dinner date problem

;;; Weld, D. S. (1999). Recent Advances in AI Planning, AI Magazine
;;; 20(2):93-123.

(define (domain dinner)
  (:action cook
	   :precond clean-hands
	   :effect dinner)
  (:action wrap
	   :precond quiet
	   :effect present)
  (:action carry
	   :precond nil
	   :effect (and (not garbage) (not clean-hands)))
  (:action dolly
	   :precond nil
	   :effect (and (not garbage) (not quiet))))

;;; Note: the propositional-POP-planner, POP-planner, and GP-planner
;;; all produce different solutions to this problem.  

;;; POP-planner: #<Plan: Cook, Carry, Wrap>  -- the solution Dan describes.
;;; GP-planner: #<Plan: [Cook, Wrap], [Dolly]>.
;;; propositional-POP-planner: #<Plan: Wrap, Dolly, Cook>.

;;; All are consistent with the domain description, though in real
;;; life we'd probably think the latter two plans were not as good.

(define (problem dinner-date)
    (:domain dinner)
  (:init garbage clean-hands quiet) 
  (:goal (and dinner present (not garbage))))

;;; ==============================
;;; First-order planning domains and problems

;;; A simple two-step plan.

(define (domain getting-dressed-1)
    (:action pick-up
	     :parameters (?x)
	     :precond (see ?x)
	     :effect (in-hand ?x))
  (:action put-on
	   :parameters (?a)
	   :precond (in-hand ?a)
	   :effect (and (wearing ?a) dressed)))

(define (problem get-dressed-1)
    (:domain getting-dressed-1)
  (:objects shoes other-shoes)
  (:init (see shoes) (see other-shoes))
  (:goal dressed))

;;; A plan with an inequality constraint.

(define (domain getting-dressed-2)
    (:action pick-up
	     :parameters (?x)
	     :precond (see ?x)
	     :effect (in-hand ?x))
  (:action put-on
	   :parameters (?a)
	   :precond (and (in-hand ?a) (neq ?a those-shoes))
	   :effect (and (wearing ?a) dressed)))

(define (problem get-dressed-2) 
    (:domain getting-dressed-2)
  (:objects shoes other-shoes)
  (:init (see those-shoes) (see other-shoes))
  (:goal dressed))

;;; ------------------------------
;;; Blocks World [AIMA p. 383]

(define (domain blocksworld)
    (:action Move
	     :parameters (?b ?x ?y)
	     :precond (and (On ?b ?x) (Clear ?b) (Clear ?y) (Block ?b)
			   (neq ?b ?x) (neq ?b ?y) (neq ?x ?y))
	     :effect (and (On ?b ?y) (Clear ?x) (not (On ?b ?x)) (not (Clear ?y))))
  (:action MoveToTable
	   :parameters (?b ?x)
	   :precond (and (On ?b ?x) (Clear ?b) (Block ?b) (neq ?b ?x) (not (On ?b Table))) ; (not (On ?b Table)) is an additional constraint
	   :effect (and (On ?b Table) (Clear ?x) (not (On ?b ?x)))))

(define (problem simple-stack)
    (:domain blocksworld)
  (:objects A B C Table)
  (:init (Block A) (Block B) (Block C)
	 (On A Table) (On B Table) (On C Table)
	 (Clear A) (Clear B) (Clear C))
  (:goal (and (On A B) (On B C))))

;;; Blocks World, the Sussman anomaly

(define (problem sussman)
    (:domain blocksworld)
  (:objects A B C Table)
  (:init (Block A) (Block B) (Block C)
	 (On A Table) (On C A) (On B Table)
	 (Clear B) (Clear C) (Clear Table))
  (:goal (and (On A B) (On B C))))

;;; ------------------------------
;;; Alternative Blocks World [AIMA p. 445]
;;; Slight difference: no free variables allowed in simple-POP.

(define (domain one-action-blocksworld)
    (:action Move ; Move ?x from ?z to ?y
	     :parameters (?x ?z ?y)
	     :precond (and (Clear ?x) (Clear ?y) (On ?x ?z)
			   #+test (neq ?x ?y) #+test (neq ?y ?z) #+test (neq ?x ?z))
	     :effect (and (On ?x ?y) (Clear ?z) (not (On ?x ?z)) (not (Clear ?y)))))

(define (problem no-goals)
    (:domain one-action-blocksworld)
  (:objects A B C D E F G)
  (:init (On B E) (On C F) (On D G)
	 (Clear A) (Clear B) (Clear C) (Clear D))
  (:goal nil))

(define (problem one-goal)
    (:domain one-action-blocksworld)
  (:objects A B C D E F G)
  (:init (On B E) (On C F) (On D G)
	 (Clear A) (Clear B) (Clear C) (Clear D))
  (:goal (On D B)))

(define (problem two-goals)
    (:domain one-action-blocksworld)
  (:objects A B C D E F G)
  (:init (On B E) (On C F) (On D G)
	 (Clear A) (Clear B) (Clear C) (Clear D))
  (:goal (and (On C D) (On D B))))

;;; ==============================
;;; Yet more Blocks World

;;; This is a hack, but for what it's worth: Go to the Web site
;;; <http://users.rsise.anu.edu.au/~jks/cgi-bin/bwstates/bwcgi>.
;;; Generate a set of small problems (e.g., four blocks).  Save the
;;; text of the generated page in a file in the directory below, named
;;; *blocksworld-problems-directory*, which you may need to change on
;;; your platform.  There's a sample file, "blocksworld.text", that
;;; accompanies the Lisp planner files to show how it works.  You can
;;; then run the planners on the generated blocksworld problems.  Even
;;; four blocks may be too many for the POP planners, and simple-GP
;;; may take a while.

#+testing
(dolist (problem (read-bw-file "blocksworld.text"))
  (format t "Problem ~A in domain ~A.~%Solution: ~A.~2%"
	  problem
	  'blocksworld
	  (plan (make-instance 'gp-planner) problem :domain 'blocksworld)))

(defvar *blocksworld-problems-directory*
  :unbound				; (truename *load-pathname*)
  "This needs to be set to an appropriate directory.  Its default
  value won't work on all platforms.")

(defvar *whitespace-chars*
  '(#\  #\Newline #\Tab #\Page #\Null #\Newline))

(defun read-bw-file (file-name &optional (directory *blocksworld-problems-directory*))
  (let ((problems nil))
    (flet ((empty-string-p (string)
	     (string= (string-trim *whitespace-chars* string) "")))
      (with-open-file (input (merge-pathnames file-name (pathname directory)))
	(loop for line = (read-line input nil nil)
	   until (null line)
	   do (let ((trimmed-line (string-trim *whitespace-chars* line)))
		(cond ((empty-string-p trimmed-line))
		      ((string= trimmed-line "Problem:")
		       (push (translate-bw-problem (read-data-items input #'empty-string-p 3))
			     problems)))))))
    problems))

(defun read-data-items (input &optional stop-when n-items-per-line n-lines)
  (let ((eof (gensym)))
    (loop for line-count from 0
       for line = (read-line input nil nil)
       until (or (null line)
		 (and n-lines (>= line-count n-lines))
		 (and stop-when (funcall stop-when line)))
       ;; Make sure there's something readable in the line
       when (read-from-string line nil nil)
       collect (let ((item nil)
		     (position 0))
		 (loop for count from 1
		    ;; do at least one iteration
		    do (multiple-value-setq (item position)
			 (read-from-string line nil eof :start position))
		    until (or (eq item eof)
			      (and n-items-per-line (> count n-items-per-line)))
		    collect item into items
		    finally (return (if n-items-per-line
					(map-into (make-list n-items-per-line)
						  #'identity items)
					items)))))))

(defun translate-bw-problem (data &optional (name (gentemp "BW-")))
  (assert (equal (pop data) '(BLOCK INITIAL GOAL)))
  (let* ((objects (mapcar #'first data))
	 (initial (mapcar #'second data))
	 (goal (mapcar #'third data)))
    (eval `(define (problem ,name)
	     (:domain blocksworld)
	     (:objects ,@objects Table)
	     (:init ,@(mapcar #'(lambda (object)
				  `(Block ,object))
			      objects)
		    ,@(mapcar #'(lambda (object initial)
				  `(On ,object ,initial))
			      objects initial)
		    ,@(loop for object in objects
			 unless (find object initial)
			 collect `(clear ,object)))
	     (:goal (and ,@(mapcar #'(lambda (object goal)
				       `(On ,object ,goal))
				   objects goal)))))
    name))

;;; ------------------------------
;;; Air cargo transportation [AIMA p. 380]

(define (domain cargo)
    (:action Load
	     :parameters (?c ?p ?a)
	     :precond (and (At ?c ?a) (At ?p ?a) (Cargo ?c) (Plane ?p) (Airport ?a))
	     :effect (and (not (At ?c ?a)) (In ?c ?p)))
  (:action Unload
	   :parameters (?c ?p ?a)
	   :precond (and (In ?c ?p) (At ?p ?a) (Cargo ?c) (Plane ?p) (Airport ?a))
	   :effect (and (At ?c ?a) (not (In ?c ?p))))
  (:action Fly
	   :parameters (?p ?from ?to) 
	   :precond (and (At ?p ?from) (Plane ?p) (Airport ?from) (Airport ?to))
	   :effect (and (not (At ?p ?from)) (At ?p ?to))))

;;; Air cargo transportation [AIMA p. 380], simplified for a one-way
;;; trip with a single plane and one piece of cargo.

(define (problem deliver-no-return)
    (:domain cargo)
  (:objects C1 SFO P1 JFK)
  (:init (At C1 SFO) (At P1 SFO)
	 (Cargo C1) (Plane P1)
	 (Airport JFK) (Airport SFO))
  (:goal (At C1 JFK)))

;;; Air cargo transportation [AIMA p. 380], simplified for a round
;;; trip with a single plane and one piece of cargo, the plane
;;; returning empty.  Takes some time but finishes.

(define (problem deliver-and-return)
    (:domain cargo)
  (:objects C1 SFO P1 JFK)
  (:init (At C1 SFO) (At P1 SFO)
	 (Cargo C1) (Plane P1)
	 (Airport JFK) (Airport SFO))
  (:goal (and (At C1 JFK) (At P1 SFO))))

(define (problem one-full-one-empty)
    (:domain cargo)
  (:objects C1 SFO P1 P2 JFK)
  (:init (At C1 SFO) (At P1 SFO) (At P2 JFK)
	 (Cargo C1) (Plane P1) (Plane P2)
	 (Airport JFK) (Airport SFO))
  (:goal (and (At C1 JFK) (At P2 SFO) #+test (At P1 SFO))))


;;; Air cargo transportation [AIMA p. 380], as given.
;;; Beyond the capabilities of POP-planner.
(define (problem back-and-forth)
    (:domain cargo)
  (:objects C1 C2 SFO P1 P2 JFK)
  (:init (At C1 SFO) (At C2 JFK) (At P1 SFO) (At P2 JFK)
	 (Cargo C1) (Cargo C2) (Plane P1) (Plane P2)
	 (Airport JFK) (Airport SFO))
  (:goal (and (At C1 JFK) (At C2 SFO))))

;;; A bigger problem, in which planes return to their starting point.
;;; simple-HSP solves it in a reasonable amount of time (seconds),
;;; simple-SAT a bit longer (half a minute), but I have to give up on
;;; the other planners.

(define (problem deliver-and-return-2)
    (:domain cargo)
  (:objects C1 C2 SFO P1 P2 JFK)
  (:init (At C1 SFO) (At C2 JFK) (At P1 SFO) (At P2 JFK)
	 (Cargo C1) (Cargo C2) (Plane P1) (Plane P2)
	 (Airport JFK) (Airport SFO))
  (:goal (and (At C1 JFK) (At C2 SFO) (At P1 SFO) (At P2 JFK))))

;;; ==============================
;;; An artificial problem due to Neelakantan Kartha, at Stottler Henke
;;; Associates, Inc., who discovered a bug (now resolved) in the simple-POP
;;; design.

(define (domain nk1)
  (:action A-a1-a :precond a1 :effect a)
  (:action A-b1-b :precond b1 :effect b)
  (:action A-c1-c :precond c1 :effect c)
  (:action A-d-a1 :precond d  :effect a1)
  (:action A-e-b1 :precond e  :effect b1)
  (:action A-f-c1 :precond f  :effect c1)
  (:action A      :precond r  :effect (and f (not a1) (not b1))))

(define (problem nk-p1)
    (:domain nk1)
  (:init d e r)
  (:goal (and a b c)))

;;; That is, to achieve a, b, and c, we need A-a1-a, A-b1-b, and
;;; A-c1-c.  To achieve a1, b1, and c1, we need A-d-a1, A-e-b1, and
;;; A-f-c1. Along comes A, to establish f, but also to threaten A-d-a1
;;; ->[a1] A-a1-a and A-e-b1 ->[b1] A-b1-b at the same time. A has to
;;; happen outside both protected intervals.

;;; ==============================
;;; Aggregate tests

(defparameter *propositional-problems-and-domains*
  '((close-door rooms)
    (change-rooms rooms)
    (put-on-shoes socks-and-shoes)
    (fix-flat flat-tire)
    (alternative-fix-flat alternative-flat-tire)
    (have-and-eat cake)
    (dinner-date dinner)
    (nk-p1 nk1)))

(defparameter *first-order-problems-and-domains*
  '((get-dressed-1 getting-dressed-1)
    (get-dressed-2 getting-dressed-2)
    (simple-stack blocksworld)
    (sussman blocksworld)
    (deliver-no-return cargo)
    (deliver-and-return cargo)
    (back-and-forth cargo)))

;;; ==============================
;;; EOF