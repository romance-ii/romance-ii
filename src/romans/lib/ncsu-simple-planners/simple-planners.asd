;;; -*- Mode: Lisp; Syntax: Common-Lisp; -*-

;;; Copyright 2007 by Robert St. Amant.

;;; To download the code for simple-POP and simple-GP, visit
;;; <http://www.csc.ncsu.edu/faculty/stamant/simple-planners/simple-planners.html>.

;;; This software is released under the license described by Peter
;;; Norvig: <http://www.norvig.com/license.html>.  If you find this
;;; software useful, please send email to <stamant@csc.ncsu.edu>.

;;; ************************************************************************

(in-package CL-USER)

;;; ************************************************************************

#+ignore
(defpackage "SIMPLE-PLANNERS"
  (:use COMMON-LISP)
  (:export))

(defvar *simple-planners-package-name* "CL-USER"
  "This variable can be changed if the planners are to be loaded
  into a different package.")

;;; ************************************************************************
;;; The code for the simple planners can be run standalone, with
;;; Norvig's code for Paradigms of Artificial Intelligence Programming
;;; (PAIP), or with Russell and Norvig's code for Artificial
;;; Intelligence: A Modern Approach (AIMA).  To do so and use the ASDF
;;; loading facilities, uncomment one of the following.  You'll need
;;; to have one of the systems already loaded before you load the
;;; simple planners.

;;; (pushnew :AIMA *features*)
;;; (pushnew :PAIP *features*)

(asdf:defsystem simple-planner-support
  ;; Compatibility with AIMA, PAIP, or standalone use
  :components ((:file 
		#+PAIP  "paip-compatibility"
		#+AIMA "aima-compatibility"
		#-(or PAIP AIMA) "standalone")))

(asdf:defsystem simple-planners
    :version "0.1"
    :author "Rob St. Amant (stamant@csc.ncsu.edu)"
    :maintainer "Rob St. Amant (stamant@csc.ncsu.edu)"
    :description "Simple planning systems in Common Lisp"
    :components ((:file "simple-utilities") ; macros and utility functions
		 (:file "simple-pddl-processing" ; domain and problem management
			:depends-on ("simple-utilities"))
		 (:file "simple-problems" ; problem definitions
			:depends-on ("simple-utilities" "simple-pddl-processing"))
		 #+PAIP
		 (:file "paip-problems" ; PAIP-specific problem definitions
			:depends-on ("simple-utilities" "simple-pddl-processing" "simple-problems"))
		 (:file "simple-data-structures" ; planning data structures
			:depends-on ("simple-utilities"))
		 (:file "simple-planners" ; domain and problem management
			:depends-on ("simple-utilities" "simple-data-structures"))
		 (:file "simple-pop" ; planning with propositional actions
			:depends-on ("simple-utilities" "simple-data-structures"))
		 (:file "simple-pop-with-bindings" ; planning with first-order actions
			:depends-on ("simple-utilities" "simple-data-structures" "simple-pop"))
		 (:file "simple-gp"	; GraphPlan
			:depends-on ("simple-utilities" "simple-data-structures" "simple-planners"))
		 (:file "simple-gp-csp"	; GraphPlan
			:depends-on ("simple-utilities" "simple-data-structures" "simple-gp"))
		 (:file "simple-sat-solver" ; SAT solver
			:depends-on ("simple-utilities" "simple-data-structures" "simple-gp"))
		 (:file "simple-sat"	; SAT planning
			:depends-on ("simple-utilities" "simple-data-structures" "simple-gp"))
		 (:file "simple-hsp"	; heuristic search planning
			:depends-on ("simple-utilities" "simple-data-structures" "simple-sat")))
    :depends-on (simple-planner-support))

;;; ************************************************************************
;;; EOF

