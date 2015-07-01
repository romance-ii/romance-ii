;;; -*- Mode: Lisp; Syntax: Common-Lisp; -*-

(in-package #.*simple-planners-package-name*)

;;; Copyright 2007 by Robert St. Amant.

;;; To download the code for the simple planners, visit
;;; <http://www.csc.ncsu.edu/faculty/stamant/simple-planners/simple-planners.html>.

;;; This software is released under the license described by Peter
;;; Norvig: <http://www.norvig.com/license.html>.  If you find this
;;; software useful, please send email to <stamant@csc.ncsu.edu>.

;;; About paip-problems.lisp:

;;; This file contains conversion functions for translating problems
;;; developed for the GPS systems in PAIP, from gps.lisp and
;;; gps1.lisp.

;;; We perform a simplistic conversion of GPS operators to simple-POP
;;; and simple-GP actions, by negating all the literals in the delete
;;; list of an operator and adding them to the effect of an action.
;; This leads to some ugliness.  For example, from *banana-ops*, we
;;; have

;;; (op 'eat-bananas
;;;     :preconds '(has-bananas)
;;;     :add-list '(empty-handed not-hungry)
;;;     :del-list '(has-bananas hungry))

;;; which will produce an action with the effect

;;; (EMPTY-HANDED NOT-HUNGRY (NOT HAS-BANANAS) (NOT HUNGRY)).

;;; This may mean more work in the planning process, but it doesn't
;;; break anything.

(defun simple-convert-op (op)
  "Translate a GPS op into a simple-POP action.  Analogous to convert-op,
  but nondestructive."
  (flet ((negate (literal)
           `(not ,literal))
         (unconvert-op (op)
           (setf (op-add-list op)
                 (remove-if #'(lambda (p)
                                (and (consp p) (eq (first p) 'EXECUTING)))
                            (op-add-list op)))
           op))
    (let ((op1 (unconvert-op (copy-op op)))) 
      `(:name    ,(op-action op1)
	:precond ,(op-preconds op1)
	:effect  ,(append (op-add-list op1)
			  (mapcar #'negate (op-del-list op1)))))))

(defun make-PAIP-domain (name operators)
  (add-domain name (mapcar #'simple-convert-op operators)))

;;; ==============================

;;; PAIP domains and problems, from gps.lisp and gps1.lisp.


;;; ------------------------------
;;; Going to school [PAIP, p. 118]

(make-PAIP-domain 'school *school-ops*)

(define (problem at-home)
    (:domain school)
  (:init son-at-home car-works)
  (:goal son-at-home))

(define (problem at-school)
    (:domain school)
  (:init son-at-home car-works)
  (:goal son-at-school))

(define (problem at-school-2)
    (:domain school)
  (:init son-at-home car-needs-battery have-money have-phone-book)
  (:goal son-at-school))

;;; Here's what simple-POP, for example, generates:

;;; #<Plan: Start, Give-Shop-Money, Look-Up-Number, Telephone-Shop,
;;;  Tell-Shop-Problem, Shop-Installs-Battery, Drive-Son-To-School,
;;;  Finish>

;;; This isn't quite right--you shouldn't be able to give-shop-money
;;; until after, say, tell-shop-problem.  (We assume the shop makes
;;; house calls.)  This is actually a minor bug in *school-ops*.
;;; Let's revise:

(make-PAIP-domain 'school
		  (substitute (make-op :action 'give-shop-money
				       ;; :preconds '(have-money) ; formerly
				       :preconds '(have-money shop-knows-problem) ; ***
				       :add-list '(shop-has-money)
				       :del-list '(have-money))
			      'give-shop-money
			      *school-ops*
			      :key #'op-action))

;;; Better now:

;;; #<Plan: Start, Look-Up-Number, Telephone-Shop, Tell-Shop-Problem,
;;;  Give-Shop-Money, Shop-Installs-Battery, Drive-Son-To-School,
;;;  Finish>

;;; ------------------------------
;;; Monkey and bananas [PAIP, p. 133]

(make-PAIP-domain 'bananas *banana-ops*)

(define (problem bananas)
    (:domain bananas)
  (:init at-door on-floor has-ball hungry chair-at-door)
  (:goal not-hungry))

;;; ------------------------------
;;; Mazes [PAIP, p. 134]

(make-PAIP-domain 'maze *maze-ops*)

;;; The POP planners do not find a solution in a "reasonable" amount of time.

(define (problem start-to-finish)
    (:domain maze)
  (:init (at 1))
  (:goal (at 25)))

;;; This works for the POP planners.

(define (problem start-to-8)
    (:domain maze)
  (:init (at 1))
  (:goal (at 8)))

;;; ------------------------------
;;; Blocks world [PAIP, p. 137]

(make-PAIP-domain 'three-blocks (make-block-ops '(a b c)))

(define (problem stack-two)
    (:domain three-blocks)
  (:objects a b)
  (:init (a on table) (b on table) (space on a) (space on b) (space on table))
  (:goal (and (a on b) (b on table))))

;;; Order of conjuncts [PAIP, p. 138-9]

(define (problem order-1)
    (:domain three-blocks)
  (:init (a on b) (b on table) (space on a) (space on table))
  (:goal (b on a)))

(define (problem stack-three-1)
    (:domain three-blocks)
  (:init (a on b) (b on c) (c on table) (space on a) (space on table))
  (:goal (and (b on a) (c on b))))

(define (problem stack-three-2)
    (:domain three-blocks)
  (:init (a on b) (b on c) (c on table) (space on a) (space on table))
  (:goal (and (c on b) (b on a))))

;;; Shorter solutions [PAIP, p. 140-1]

(define (problem stack-three-3)
    (:domain three-blocks)
  (:init (c on a) (a on table) (b on table)
	 (space on c) (space on b) (space on table))
  (:goal (and (c on table) (a on b))))

(define (problem stack-three-4)
    (:domain three-blocks)
  (:init (a on b) (b on c) (c on table) (space on a) (space on table))
  (:goal (and (b on a) (c on b))))

(define (problem stack-three-5)
    (:domain three-blocks)
  (:init (a on b) (b on c) (c on table) (space on a) (space on table))
  (:goal (and (c on b) (b on a))))

;;; The dreaded Sussman anomaly [PAIP, p. 142]

(define (problem sussman)
    (:domain three-blocks)
  (:init (c on a) (a on table) (b on table) (space on c)
	 (space on b) (space on table))
  (:goal (and (a on b) (b on c))))

;;; ==============================
;;; Override of definition in simple-problems.lisp 

(defparameter *propositional-problems-and-domains*
  '((at-home school)
    (at-school school)
    (at-school-2 school)
    (bananas bananas)
    (start-to-8 maze)
    (start-to-finish maze)
    (stack-two three-blocks)
    (order-1 three-blocks)
    (stack-three-1 three-blocks)
    (stack-three-2 three-blocks)
    (stack-three-3 three-blocks)
    (stack-three-4 three-blocks)
    (stack-three-5 three-blocks)
    (sussman three-blocks)
    (put-on-shoes socks-and-shoes)
    (fix-flat flat-tire)
    (alternative-fix-flat alternative-flat-tire)
    (have-and-eat cake)
    (dinner-date dinner)))

;;; ==============================
;;; EOF