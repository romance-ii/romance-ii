;; Wraper for using component-find.lisp from CGI/Perl search facility of the CLib browser

(setf *default-pathname-defaults* "/usr/spool/net/www/users/mfkb/RKF/smedict/")
(load "/usr/spool/net/www/users/mfkb/RKF/smedict/component-find.lisp")

(defun component-find-pp (word)
  (mapcar #'(lambda (entry)
	      (format t "===~A===~%" (first entry)))
	  (component-find-sorted word)))

