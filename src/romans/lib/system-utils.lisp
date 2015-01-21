(in-package :romans)


(defun prerequisite-systems (&optional (child :romance-ii))
  (if-let ((prereqs (slot-value (asdf:find-system child)
                                'asdf::load-dependencies)))
    (remove-if
     (lambda (sys)
       (member (keywordify sys)
               #+sbcl '(:sb-grovel :sb-posix :sb-rotate-byte
                        :sb-grovel :sb-bsd-sockets)))
     (remove-duplicates
      (append (remove-if #'null
                         (mapcan #'prerequisite-systems prereqs))
              prereqs)
      :test #'eql :key #'keywordify))))




(define-constant +license-words+
    '(:license :licence :copying :copyright)
  :test 'equal)



(defun find-copyrights (&optional (long nil))
  (append
   (loop for system in (sort (prerequisite-systems :romance-ii)
                             #'string<
                             :key (compose #'string-upcase #'string))
      for asdf-dir = (make-pathname
                      :directory (pathname-directory
                                  (asdf:system-source-directory system))
                      :name :wild :type :wild)
      for license =
        (or
         (let ((override-file
                (merge-pathnames
                 (make-pathname :directory '(:relative "doc" "legal" "licenses")
                                :name (string-downcase (string system))
                                :type "txt") (translate-logical-pathname
                                              (make-pathname :host "r2project")))))
           (when (fad:file-exists-p override-file)
             (list system override-file)))
         (unless long
           (if-let ((license (ignore-errors
                               (slot-value (asdf:find-system system) 'asdf::licence))))
             (list system license)))
         (loop
            for path in (directory asdf-dir)
            when (member (make-keyword (string-upcase
                                        (pathname-name path))) +license-words+)
            return (list system (pathname path)))
         (loop
            for path in (directory (merge-pathnames "doc/" asdf-dir))
            when (member (make-keyword (string-upcase
                                        (pathname-name path))) +license-words+)
            return (list system (pathname path)))
         (if long
             (if-let ((license (ignore-errors
                                 (slot-value (asdf:find-system system) 'asdf::licence))))
               (list system license)))
         (loop
            for path in (directory asdf-dir)
            when (member (make-keyword (string-upcase
                                        (pathname-name path))) '(:readme))
            return (prog1 (list system (pathname path))
                     (warn "No LICENSE for ~:(~A~), using README~%(in ~A)"
                           system asdf-dir))))
      when license collect license
      else collect (prog1 (list system nil)
                     (warn "No LICENSE for ~:(~A~)~%(in ~A)" system asdf-dir)))
   (if long
       (list :bullet2 (merge-pathnames
                       (make-pathname :directory '(:relative "doc" "legal" "licenses")
                                      :name "bullet2"
                                      :type "txt")
                       (translate-logical-pathname
                        (make-pathname :host "r2project"))))
       (list :bullet2 "MIT"))))




(defun copyrights (&optional (long nil))
  "Return a string with applicable copyright notices."
  
  (strcat
   "Romance Game System
Copyright © 1987-2014, Bruce-Robert Pocock;

This program is free software: you may use, modify, and/or distribute it
 *ONLY* in accordance with the terms of the GNU Affero General Public License
 (GNU AGPL).

   ★ Romance Ⅱ contains libraries which have their own licenses. ★

"
   (unless long "(Abbreviated:)
")
   (loop for (package license) in (find-copyrights long)
      collect
        (if long
            (format nil "
————————————————————————————————————————————————————————————————————————
Romance Ⅱ uses the library ~@:(~A~)~2%"
                    package)
            (format nil "~% • ~:(~A~): " package))
        
      collect
        (typecase license
          (pathname (if long
                        (alexandria:read-file-into-string license)
                        (first-paragraph-of license 2)))
          (string (if (or (< (length license) 75) long)
                      license
                      (concatenate 'string (subseq license 0 75) "…")))
          (t (warn "Package ~A has no license?" package)
             "(see its documentation for license)")))
   (if long
       "~|
————————————————————————————————————————————————————————————————————————

Romance Ⅱ itself is a program.

    Romance Game System Copyright © 1987-2014, Bruce-Robert Fenn
    Pocock;

    This  program is  free software:  you can  redistribute it  and/or
    modify it under the terms of the GNU Affero General Public License
    as published by the Free  Software Foundation, either version 3 of
    the License, or (at your option) any later version.

    This program  is distributed in the  hope that it will  be useful,
    but WITHOUT  ANY WARRANTY;  without even  the implied  warranty of
    MERCHANTABILITY or FITNESS FOR A  PARTICULAR PURPOSE.  See the GNU
    Affero General Public License for more details.

    You should have  received a copy of the GNU  Affero General Public
    License    along    with    this    program.     If    not,    see
    < http://www.gnu.org/licenses/ >."
       ;; short version
       "
See COPYING.AGPL3 or run “romance --copyright” for details.
")))
