;;; -*- Mode: Lisp; Syntax: Common-Lisp; -*-

(in-package #.*simple-planners-package-name*)

;;; Copyright 2007 by Robert St. Amant.

;;; To download the code for the simple planners, visit
;;; <http://www.csc.ncsu.edu/faculty/stamant/simple-planners/simple-planners.html>.

;;; This software is released under the license described by Peter
;;; Norvig: <http://www.norvig.com/license.html>.  If you find this
;;; software useful, please send email to <stamant@csc.ncsu.edu>.

;;; About aima-compatibility.lisp:

;;; The code in this file provides a set of quick-and-dirty glue
;;; functions to allow simple-POP and simple-GP to use the AIMA code
;;; base.

(eval-when (:compile-toplevel :load-toplevel :execute)
(aima-load 'search)
(aima-load 'agents)
(aima-load 'logic)
)

;;; ==============================
;;; AIMA extensions to handle functionality present in PAIP

(defconstant +variable-prefix-char+ #\?)

(defun variable? (x)
  "Is x a variable (a symbol starting with $)?"
  (and (symbolp x) (eql (char (symbol-name x) 0) +variable-prefix-char+)))

(setf (symbol-function 'find-all-if) #'remove-if-not)

(defun find-all (item sequence &rest keyword-args
                 &key (test #'eql) test-not &allow-other-keys)
  "Find all those elements of sequence that match item,
  according to the keywords.  Doesn't alter sequence."
  (if test-not
      (apply #'remove item sequence 
             :test-not (complement test-not) keyword-args)
      (apply #'remove item sequence
             :test (complement test) keyword-args)))

;;; See PAIP/auxfns.lisp

(defun match-variable (var input bindings)
  "Does VAR match input?  Uses (or updates) and returns bindings."
  (let ((binding (get-binding var bindings)))
    (cond ((not binding) (extend-bindings var input bindings))
          ((equal input (binding-val binding)) bindings)
          (t +fail+))))

;;; See PAIP/patmatch.lisp

(defun variable-p (x)
  "Is x a variable (a symbol beginning with +variable-prefix-char+)?"
  (and (symbolp x) (equal (elt (symbol-name x) 0) +variable-prefix-char+)))

;;; See PAIP/search.lisp

(defun sorter (cost-fn)
  "Return a combiner function that sorts according to cost-fn."
  #'(lambda (new old)
      (sort (append new old) #'< :key cost-fn)))

(defstructure (planning-problem (:include problem)))

(defvar *goal-test*)

(defmethod goal-test ((problem planning-problem) node)
  (funcall *goal-test* (state-if-node node)))

(defvar *successors-function*)

(defmethod successors ((problem planning-problem) node)
  ;; The successors method for problem objects must return 
  ;; "an alist of (action . state) pairs, reachable from this state".
  (mapcar #'(lambda (successor)
	      (cons 'action successor))
	  (funcall *successors-function* (state-if-node node))))

;;; Utility

(defun state-if-node (node-or-state)
  (if (node-p node-or-state)
      (node-state node-or-state)
      node-or-state))

;;; ==============================
;;; Common function

(defun simple-search (start goal-p successors cost-fn)
  (let* ((*goal-test* goal-p)
	 (*successors-function* successors)
	 (result (best-first-search
		  (make-planning-problem :initial-state start)
		  #'(lambda (node-or-state)
		      (funcall cost-fn (state-if-node node-or-state))))))
    (when result
      (node-state result))))
