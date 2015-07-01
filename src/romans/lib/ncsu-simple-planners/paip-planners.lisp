;;; -*- Mode: Lisp; Syntax: Common-Lisp; -*-

;;; Copyright 2007 by Robert St. Amant.

;;; To download the code for the simple planners, visit
;;; <http://www.csc.ncsu.edu/faculty/stamant/simple-planners/simple-planners.html>.

;;; This software is released under the license described by Peter
;;; Norvig: <http://www.norvig.com/license.html>.  If you find this
;;; software useful, please send email to <stamant@csc.ncsu.edu>.

;;; ==============================

(in-package "COMMON-LISP-USER")

;;; ==============================

(defvar *simple-planners-package-name* "CL-USER")

;;; ==============================
;;; Among other things, the following file loads gps, search, and unify.

(requires "paip-compatibility")

;;; ==============================
;;; Partial-order planning and GraphPlan code.

(requires "simple-utilities")		; macros and utility functions
(requires "simple-pddl-processing")     ; domain and problem management
(requires "simple-problems")            ; problem definitions
(requires "paip-problems")              ; PAIP-specific problem definitions
(requires "simple-data-structures")     ; planning data structures
(requires "simple-planners")	        ; domain and problem management
(requires "simple-pop")		        ; planning with propositional actions
(requires "simple-pop-with-bindings")   ; planning with first-order actions
(requires "simple-gp")		        ; GraphPlan
(requires "simple-gp-csp")		; GraphPlan with constraint satisfaction

(requires "simple-sat-solver")		; SAT solver
(requires "simple-sat")			; SAT planner: control and translation

(requires "simple-hsp") 		; Heuristic search planner

;;; ==============================
;;; EOF