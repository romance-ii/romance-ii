(in-package :brfp)

(defun prerequisite-systems (&optional (child :romance-ii))
  (check-type child string-designator)
  (assert child)
  (if-let ((prereqs (remove-duplicates
                     (mapcar #'keywordify
                             (remove-if #'null
                                        (list*
                                         (ignore-errors (slot-value (asdf:find-system child)
                                                                    'asdf::load-dependencies))
                                         (ignore-errors (slot-value (asdf:find-system child)
                                                                    'asdf::depends-on))
                                         (ignore-errors (slot-value (asdf:find-system child)
                                                                    'asdf::sideway-dependencies))))))))
    (remove-if
     (lambda (sys)
       (member sys
               #+sbcl '(:sb-grovel :sb-posix :sb-rotate-byte
                        :sb-grovel :sb-bsd-sockets)
               #-sbcl '()))
     (remove-duplicates (append (mapcan #'prerequisite-systems prereqs) prereqs)))))


(define-constant +license-words+
    '(:license :licence :copying :copyright)
  :test 'equal)


(defun manual-license-path (system)
  (merge-pathnames
   (make-pathname :directory '(:relative "doc" "legal" "licenses")
                  :name (string-downcase (string system))
                  :type "txt")
   (or #+romans romans-compiler-setup:*path/r2project*
       *load-truename*
       *compile-file-truename*)))

(defun find-copyrights (&optional (longp nil))
  (append
   (loop for system in (sort (prerequisite-systems :romance-ii)
                             #'string<
                             :key (compose #'string-upcase #'string))
      for asdf-dir = (make-pathname
                      :directory (pathname-directory
                                  (or (asdf:system-source-directory system)
                                      #p"."))
                      :name :wild :type :wild)
      for license =
        (or
         (let ((override-file (manual-license-path system)))
           (when (fad:file-exists-p override-file)
             override-file))
         (unless longp
           (if-let ((license (ignore-errors
                               (slot-value (asdf:find-system system) 'asdf::licence))))
             license))
         (loop
            for path in (directory asdf-dir)
            when (member (make-keyword (string-upcase
                                        (pathname-name path))) +license-words+)
            return (pathname path))
         (loop
            for path in (directory (merge-pathnames "doc/" asdf-dir))
            when (member (make-keyword (string-upcase
                                        (pathname-name path))) +license-words+)
            return (pathname path))
         (if longp
             (if-let ((license (ignore-errors
                                 (slot-value (asdf:find-system system) 'asdf::licence))))
               license))
         (loop
            for path in (directory asdf-dir)
            when (member (make-keyword (string-upcase
                                        (pathname-name path))) '(:readme))
            return (prog1 (list system (pathname path))
                     (warn "No LICENSE for ~:(~A~), using README~%(in ~A)"
                           system asdf-dir))))
      when license collect (list system license)
      else collect (prog1 (list system nil)
                     (warn "No LICENSE for ~:(~A~)~%(in ~A );~%~TPlease find the license and insert it as ~a"
                           system asdf-dir (manual-license-path system))))
   (if longp
       (list (list :bullet2 (merge-pathnames
                             (make-pathname :directory '(:relative "doc" "legal" "licenses")
                                            :name "bullet2"
                                            :type "txt")
                             #+romans romans-compiler-setup:*path/r2project*)))
       (list (list :bullet2 "MIT")))))




(defun copyrights (&optional (longp nil))
  "Return a string with applicable copyright notices."

  (strcat
   "Romance Game System
Copyright © 1987-2015, Bruce-Robert Pocock;

This program is free software: you may use, modify, and/or distribute it
 *ONLY* in accordance with the terms of the GNU Affero General Public License
 (GNU AGPL).

   ★ Romance Ⅱ uses libraries which have their own licenses. ★

"
   (unless longp "(Abbreviated:)
")
   (loop for (package license) in (find-copyrights longp)
      collect
        (if longp
            (format nil "
————————————————————————————————————————————————————————————————————————
Romance Ⅱ uses the library ~@:(~A~)~2%"
                    package)
            (format nil "~% • ~:(~A~): " package))

      collect
        (typecase license
          (pathname (if longp
                        (alexandria:read-file-into-string license)
                        (first-paragraph-of license 2)))
          (string (if (or (< (length license) 75) longp)
                      license
                      (concatenate 'string (subseq license 0 75) "…")))
          (t (warn "Package ~A has no license?" package)
             "(see its documentation for license)")))
   (if longp
       "~|
————————————————————————————————————————————————————————————————————————

Romance Ⅱ itself is a program.

    Romance Game System Copyright © 1987-2015, Bruce-Robert Fenn Pocock;

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU Affero General Public License as
    published by the Free Software Foundation, either version 3 of the
    License, or (at your option) any later version.

    This program is distributed in the hope that it will be useful, but
    WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
    Affero General Public License for more details.

    You should have received a copy of the GNU Affero General Public
    License along with this program.  If not, see
    http://www.gnu.org/licenses/ ."
       ;; short version
       "
See COPYING.AGPL3 or run “romance --copyright” for details.
")))



(defmacro warn-impl (symbol &optional message)
  `(warn "An implementation of ~a is needed for ~a on ~a.
~@[~%~a~%~]~
Please add an implementation to the file:
~a
git
 … with an appropriate #+(feature) tag to identify it, or contact the Romans
   development team, and we may be able to help. Your *FEATURES* contains the
   following:
~s
"
         ',symbol
         (lisp-implementation-type) (machine-type)
         ,message
         (or *compile-file-truename* *load-truename*)
         *features*))


