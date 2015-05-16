(defpackage :rahab
  (:use :cl :romans)
  (:nicknames :spy)
  (:documentation "Rahab is the interface for operators to interact
  directly with the Romance Ⅱ server. Rahab can intercept various kinds of
  messages from components, interact with Emacs, run listeners with Lisp
  REPLs and other scripting languages, and support both software
  development and system administration tasks.

Rahab wasn't actually a Roman; she's an Old Testament spy who helped the
Israelite army.  This module's name is a throw-back to before the
standardization of all our major component names as being Romans.")
  (:export #:spy))

