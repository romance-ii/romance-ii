(format *trace-output* "~&DOCS-TO-TEXI: getting ready")
(in-package :cl-user)
(require :quicklisp)
(load "../../src/romans/setup")
(eval-when (:compile-toplevel :load-toplevel :execute)
  (ql:quickload :sb-texinfo))
(defpackage docs-to-texi (:use :cl :alexandria))
(in-package :docs-to-texi)
(defparameter *r2* 
  (truename 
   (make-pathname :directory (append (pathname-directory *load-truename*) 
                                     (list ".." "..")))))
(defparameter *doc-dir*
  (make-pathname :directory (append (pathname-directory *r2*)
                                    (list "doc" "devel" "genr"))))

(format *trace-output* "~&DOCS-TO-TEXI: Romance Ⅱ in ~a" *r2*)

(defun sb-texinfo::write-chapter/package (package doc)
  (when doc
    (format sb-texinfo::*texinfo-output* "
@node Package ~A~:*
@subsection Package ~A~%"
            (sb-texinfo::package-shortest-name package))
    (sb-texinfo::texinfo-body doc)))

(defvar *sb-texinfo-package*)

(defun sb-texinfo::write-chapter/dictionary (docs)
  (format sb-texinfo::*texinfo-output*
          "
@node Dictionary of ~a~:*
@subsubsection Dictionary of ~a
" *sb-texinfo-package*)
  (dolist (doc docs)
    (format sb-texinfo::*texinfo-output*
            "@include include/~A~%" (sb-texinfo::include-pathname doc))))

(defun tex-it (package title)
  (let ((*default-pathname-defaults* *doc-dir*)
        (*sb-texinfo-package* (string package)))
    (sb-texinfo:document-package package
                                 :standalone nil
                                 :title title
                                 :output-file 
                                 (merge-pathnames
                                  *doc-dir*
                                  (make-pathname :name (string package)
                                                 :type "texi")))))




(define-constant +core-packages+
    '((:romance "Romance Ⅱ Core Package")
      (:romance-user "Romance Ⅱ User Package")
      (:cl "Common Lisp Standard Library")
      (:fad "CL-FAD Portable Pathname Library")
      (:alexandria "Alexandria Utilities")
      (:bordeaux-threads "Bordeaux Threads")
      (:split-sequence "Split-Sequence Library")
      (:cl-ppcre "Common Lisp Portable Perl-Compatible Regex Library"))
  :test 'equal
  :documentation "Core/utility packages")

(define-constant +roman-packages+
    '(
      (:appius "Appius Claudius Caecus Communications Facility")
      (:asinius "Gaius Asinius Pollo Postgres Facility")
      (:caesar "Gaius Julius Caesar Management Facility")
      (:catullus "Gaius Valerius Catullus Conversation Facility")
      (:galen "Aelius Galenus Quiescence and Burgeoning Facility")
      (:frontinus "Sextus Julius Frontinus Weather Facility")
      (:lutatius "Gaius Lutatios Catulus Character Facility")
      (:narcissus "Narcissus Physics Facility")
      (:rabirius "Rabirius Geography Facility")
      (:regillus "Lucius Aemilius Regillus Pathfinding Facility")
      (:vitruvius "Marcus Vitruvius Pollio Genetics Facility")
      )
  :test 'equal
  :documentation "The Romans")

(defun collector (package title collection)
  (format collection "~2%
@node System Documentation --- ~a
@subsection ~:*~a

@include ~a.texi" 
          (sb-texinfo::escape-for-texinfo title)
          (make-boring (string package))))

(defun cobol-to-texi (source-file-name output-file-name)
  (with-input-from-file (source source-file-name)
    (with-output-to-file (texi output-file-name
                               :if-exists :supersede)
      (loop with eof = "//////////"
         with in-doc-p = nil
         for line = (read-line source nil eof)
         for commentp = (and (< 7 (length line))
                             (eql #\* (elt line 7)))
         for start-doc-p = (and commentp
                                (< 8 (length line))
                                (eql #\+ (elt line 8)))
         for content = (or (and (< 9 (length line)) 
                                (subseq line 9))
                           "") 
         while (not (equal line eof))
         do (cond 
              ((and commentp in-doc-p)
               (terpri texi)
               (princ content texi))
              ((and (not in-doc-p)
                    start-doc-p)
               (setf in-doc-p t)
               (format texi "~2%@node ~a~%@subsection ~:*~a~2%"
                       (sb-texinfo::escape-for-texinfo content)))
              (start-doc-p
               (format texi "~2%@node ~a~%@subsection ~:*~a~2%"
                       (sb-texinfo::escape-for-texinfo content)))
              (t (setf in-doc-p nil)))))))

(defun numidicus-document ()
  (cobol-to-texi
   (make-pathname :directory (append (pathname-directory *r2*)
                                     '("src" "ROM2"))
                  :name "QCMN"
                  :type "cob")
   (merge-pathnames *doc-dir* "QCMN.texi")))

(defun find-defpackages-in-file (file-name)
  (with-input-from-file (source file-name)
    (loop for form in (read source)
       when (eql (car form) 'defpackage)
       collect (make-keyword (string (elt form 1))))))

(defun for-every-asdf-file (fn asdf-system)
  (labels 
      ((for-every-file (dir &aux collected) 
         (dolist (name (directory 
                        (make-pathname :directory (pathname-directory dir)
                                       :name :wild :type :wild
                                       :version :newest)))
           (cond ((fad:directory-exists-p name)
                  (for-every-file name))
                 ((equal (pathname-type name) "lisp")
                  (mapcar (lambda (file) 
                            (pushnew file collected))
                          (ignore-errors
                            (find-defpackages-in-file name))))))
         collected))
    (mapcar fn 
            (for-every-file (asdf:system-source-directory asdf-system)))))

(defun asdf-system-packages (system)
  (remove-duplicates 
   (for-every-asdf-file (curry #'find-defpackages-in-file)
                        system)))

(defun make-boring (string)
  (substitute #\- #\/
              (cl-ppcre:regex-replace "[^A-Za-z0-9\\-\\+\\.\\_\\=\\@]" string "-")))

(defun document-other-packages (collection)
  (format collection "~2%@node System Documentation --- Other Packages
@section Other Packages

@menu
@end menu~2%")
  (let ((prerequisites 
         (sort (remove-if (lambda (system)
                            (or (member system +core-packages+)
                                (member system +roman-packages+)))
                          (romans::prerequisite-systems :romance-ii))
               #'string<
               :key (compose #'string-upcase #'string))))
    (loop for system in prerequisites
       for system-title = (concatenate 'string
                                       "System "
                                       (or (let ((lname (asdf:system-long-name (asdf:find-system system))))
                                             (when (< 60 (length lname))
                                               lname))
                                           (string system)))
       do
         (collector system-title 
                    (or (asdf:system-description (asdf:find-system system))
                        (asdf:system-long-name (asdf:find-system system))
                        system-title) 
                    collection)
       do
         (with-output-to-file (texi (make-pathname 
                                     :name (make-boring system-title)
                                     :type "texi"
                                     :directory (pathname-directory *doc-dir*))
                                    :if-exists :supersede)
           (format texi "``~a'' is a system defined by ASDF and loaded
as a prerequisite package for the compilation of Romance. The following
sections define the packages@footnote{It's possible that not all
packages may be listed correctly, because ASDF systems enumerate their
source code modules, not their packages. Package discovery is still
somewhat error-prone in the DOCS-TO-TEXI driver which extracts this
documentation.} provided by the system.~2%" 
                   (sb-texinfo::escape-for-texinfo system-title))) 
         
       do
         (loop for package in (asdf-system-packages system)
            for title = (concatenate 'string
                                     system-title
                                     " Package "
                                     (string-capitalize (string package)))
            do (collector package title collection)
            do (tex-it package title)))
    prerequisites))

(defun docs-to-texi ()
  "Convert all packaged documentation into TeXInfo form for the manuals."
  (format *trace-output* "~&DOCS-TO-TEXI: Beginning… ")
  (ignore-errors (sb-posix:mkdir *doc-dir* #o775))
  
  (with-open-file (collection (merge-pathnames *doc-dir* "all-docs.texi")
                              :direction :output
                              :if-exists :supersede)
    (format collection "%% AUTO-GENERATED by tools/bin/docs-to-texi.lisp
@node System Documentation
@chapter System Documentation

The following documentation describes all of the packages which
collectively make up Romance.

The core packages provide some low-level functionality and entry
points. The Romans are the main packages. Most of these are in Common
Lisp. To demonstrate calling between Lisp and non-Lisp modules, however,
Numidicus (QCMN) is written instead in COBOL.")
    
    (format *trace-output* "~& Building docs for core packages… ")
    (format collection "~2%@node System Documentation --- Core Packages
@section Core Packages

@menu
@end menu~2%")
    (loop for (package title) in +core-packages+
       do (collector package title collection)
       do (tex-it package title))
    
    (format *trace-output* "~& Building docs for Romans (Lisp)… ")
    (format collection "~2%@node System Documentation --- The Romans
@section The Romans

@menu
@end menu~2%")
    (loop for (package title) in +roman-packages+
       do (collector package title collection)
       do (tex-it package title))
    
    (format *trace-output* "~& Building docs for Numidicus (COBOL)… ")
    (collector "QCMN" "Quintius Caecilius Metellus Numidicus" collection)
    (numidicus-document)
    
    (format *trace-output* "~& Building docs for other ASDF systems… ")
    (let ((prerequisites (document-other-packages collection)))
      (format collection "~2%@node System Documentation --- End
@section System Documentation Summary

The documentation for this software includes ~r core packages that
provide basic utility functionality, ~r Romance packages which provide
the main body of the application-specific functionality, and ~r
additional prerequisite library systems which provide supporting
functions in various packages."
              (length +core-packages+)
              (length +roman-packages+)
              (length prerequisites))))
  
  (format *trace-output* "~& Fixing generated includes' paths… ")
  (dolist (a-file (directory
                   (make-pathname :directory (pathname-directory *doc-dir*)
                                  :name :wild :type "texi")))
    (sb-ext:run-program "/usr/bin/perl" (list "-pne" 
                                              "s,\\@include include/,\\@include include/,g; s{^\\@include (.*)$} {open IN, '<', $1 or die; join $/, <IN>}gex"
                                              "-i"
                                              (princ-to-string a-file))))
  
  
  (copy-file (make-pathname :directory (append (pathname-directory *r2*) 
                                               '("doc" "devel"))
                            :name "The-Book-of-Romance"
                            :type "texi")
             (make-pathname :directory (append (pathname-directory *r2*) 
                                               '("doc" "devel" "genr"))
                            :name "The-Book-of-Romance"
                            :type "texi"))
  (format *trace-output* "~& DOCS-TO-TEXI done."))

(docs-to-texi)
