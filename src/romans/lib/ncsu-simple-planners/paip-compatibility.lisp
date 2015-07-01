;;; -*- Mode: Lisp; Syntax: Common-Lisp; -*-

(in-package #.*simple-planners-package-name*)

;;; Copyright 2007 by Robert St. Amant.

;;; To download the code for the simple planners, visit
;;; <http://www.csc.ncsu.edu/faculty/stamant/simple-planners/simple-planners.html>.

;;; This software is released under the license described by Peter
;;; Norvig: <http://www.norvig.com/license.html>.  If you find this
;;; software useful, please send email to <stamant@csc.ncsu.edu>.

;;; About paip-compatibility.lisp:

;;; The code in this file provides a set of quick-and-dirty glue
;;; functions to allow simple-POP and simple-GP to use the PAIP code
;;; base, while supporting other code bases.

(eval-when (:compile-toplevel :load-toplevel :execute)
(requires "gps")                        ; For problem definitions
(requires "search")                     ; For best-first-search
(requires "unify")                      ; For variable bindings
)

;;; ==============================
;;; PAIP overrides and extensions

;;; See PAIP/auxfns.lisp

(defconstant +no-bindings+ no-bindings)

(defconstant +variable-prefix-char+ #\?)

(defun variable-p (x)
  "Is x a variable (a symbol beginning with +variable-prefix-char+)?"
  (and (symbolp x) (equal (elt (symbol-name x) 0) +variable-prefix-char+)))

;;; ==============================
;;; Fixup

(defun simple-search (start goal-p successors cost-fn)
  (declare (ignorable goal-p successors))
  (best-first-search start goal-p successors cost-fn))

;;; ==============================
;;; EOF