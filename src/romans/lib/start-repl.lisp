;;; This is in a separate file, since it requires CAESAR.
(in-package :romans)

(defun start-repl (&optional argv)
  (unless (member "--silent" argv :test #'string-equal)
    (format t "~&~|~%Romance Ⅱ
Copyright © 2013-2015, Bruce-Robert Fenn Pocock.
Evaluate (ROMANCE:COPYRIGHTS T) for details.
Read-Eval-Print-Loop interactive session.
For help, evaluate (ROMANCE:REPL-HELP) (ie type: (HELP) at the prompt.)~2%"))
  (unless (user-ident)
    (format t "~&You haven't identified yourself. Say Hello!
... enter (HELLO \"your name here\") to identify yourself.")
    (setf *user-ident* (format nil "REPL user ~A" (gensym "REPL"))))
  (caesar:with-oversight (repl)
    (let ((*package* (find-package :romance-user)))
      (prepl:repl :nobanner t :inspect t :continuable t))))
