(in-package :common-lisp-user)

(defpackage :romans-compiler-setup 
  (:use :cl)
  (:export #:*path/etc*
           #:*path/share*
           #:*path/r2share*
           #:*path/bin*
           #:*path/var*
           #:*path/tmp*
           #:*path/var/tmp*
           #:*path/r2src*
           #:*path/r2project*))
(in-package :romans-compiler-setup)


(format *trace-output* "~|~2% ★ Romance Ⅱ set-up script ★

Setting up environment to compile Romance Ⅱ… If you run into problems,
check the manual in the “doc” folder.")

(load "~/quicklisp/setup" :verbose nil)

;;; Check  that  we're being  LOADed.  COMPILEing  this won't  have  the
;;; expected effects.

(unless *load-pathname*
  (error "This file must be `load'ed, not `compile'd. (LOAD \"setup\")"))

(eval-when (:compile-toplevel)
  (error "This file must be `load'ed, not `compile'd. (LOAD \"setup\")"))


;;; Check that the  environment is plausibly similar  enough that things
;;; will actually work.

#-sbcl
(warn "Your compiler is not SBCL. Some things may be weird.

Romance Ⅱ is being developed using SBCL. While we greatly appreciate
and encourage other compilers to be used, and would like to support as
many as are practical, please keep in mind that the curator and
principal developers use SBCL on Linux® (64-bit). Patches for your
compiler will certainly be accepted, however, as long as they don't
break support for SBCL (e.g. use #+xyzlisp reader macros).

The name of your compiler would be helpful for us to know, as well as
its feature-test symbol(s) for #± reader macros; your CL:*FEATURES*
is: ~%~S" *features*)

#-common-lisp
(warn "*FEATURES* omits COMMON-LISP. What madness is this??

If you are legitimately trying to compile Romance Ⅱ using some
un-Common Lisp, well: good luck, but please don't expect
any miracles.

If you're on a Common Lisp system that doesn't mention COMMON-LISP in
its *FEATURES*, please advise us with a copy of CL:*FEATURES*:~%~S"
      *features*)


#-linux
(warn "*FEATURES* omits LINUX.

Romance Ⅱ is being developed on Linux®. While support for some other
operating systems is certainly possible, keep in mind, that the more
your operating system differs from Linux, the less likely things are
to Just Work. Patches for other OS are accepted, as long as they don't
break Linux support.

If your OS *is* a Linux, and your compiler simply does not specify
the :LINUX keyword in *FEATURES*, please advise us with this copy of
your CL:*FEATURES*: ~%~S" *features*)

;;; CLisp doesn't set *FEATURES*, but  it does set (MACHINE-TYPE), so we
;;; can set it, here, for consistency.

#-x86-64
(when (or (string-equal "x86-64" (machine-type))
          (string-equal "x86_64" (machine-type)))
  (pushnew :x86-64 *features*))

#-x86-64
(warn "*FEATURES* omits X64-64.

Your machine type is reported as ~A
 (specifically: ~A)

If this is not an AMD-alike* 64-bit architecture, please be forewarned
that Romance Ⅱ is being developed primarily for the “AMD 64” (X86-64)
architecture. While support for other architectures is surely
possible, and patches are encouraged, neither the curator nor primary
contributors are currently using them.

   * Intel's (non-Itanium) 64-bit systems are AMD-alikes; e.g. the Intel
     Core series.

If your architecture *is* an X86-64 system, and your compiler simply
does not specify the :X86-64 keyword in *FEATURES*, please advise us
with a copy of your CL:*FEATURES*: ~%~S" *features*)

#+sbcl
(progn
  (setf sb-impl::*default-external-format* :utf-8)

  (defun uninteresting-ordinary-function-redefinition-p (warning)
    (and
     (or (typep warning 'sb-kernel::redefinition-with-defun)
         (typep warning 'sb-kernel::redefinition-with-defmacro))
     ;; Shared logic.
     (let ((name (sb-kernel::redefinition-warning-name warning)))
       (not (sb-kernel::interesting-function-redefinition-warning-p
             warning
             (or (fdefinition name)
                 (macro-function name)))))))

  (deftype uninteresting-redefinition ()
    '(or
      (satisfies uninteresting-ordinary-function-redefinition-p)))

  (setf sb-ext:*muffled-warnings* 'uninteresting-redefinition))


;;; Set the paths for a normal, production installation. These are DEFVARs now, so you can override them.

(defvar *path/etc* (make-pathname :directory '(:absolute "etc")))
(defvar *path/share* (make-pathname :directory '(:absolute "usr" "share")))
(defvar *path/r2share* (make-pathname :directory '(:absolite "usr" "share" "romance-ii")))
(defvar *path/bin* (make-pathname :directory '(:absolute "usr" "bin")))
(defvar *path/var* (make-pathname :directory '(:absolute "var" "lib" "romance-ii")))
(defvar *path/tmp* (make-pathname :directory '(:absolute "tmp")))
(defvar *path/var/tmp* (make-pathname :directory '(:absolute "var" "tmp")))
(defvar *path/r2src* (truename 
                      (merge-pathnames (make-pathname :directory '(:relative "..")) 
                                       (make-pathname :directory (pathname-directory *load-pathname*)))))
(defvar *path/r2project*
  (truename (merge-pathnames (make-pathname :directory '(:relative ".." ".."))
                             (make-pathname :directory (pathname-directory *load-pathname*)))))
(defvar *path/game-project*
  (truename (merge-pathnames (make-pathname :directory '(:relative ".." ".." ".."))
                             (make-pathname :directory (pathname-directory *load-pathname*)))))
(defvar *path/distdir*
  (merge-pathnames (make-pathname :directory '(:relative "dist")) 
                   *path/r2project*))
(defvar *path/libdir*
  (merge-pathnames (make-pathname :directory '(:relative  "lib")) 
                   *path/distdir*))
(defvar *path/incdir*
  (merge-pathnames (make-pathname :directory '(:relative "include")) 
                   *path/distdir*))
(defvar *path/bindir*
  (merge-pathnames (make-pathname :directory '(:relative "bin")) 
                   *path/distdir*))
(defvar *path/sharedir*
  (merge-pathnames (make-pathname :directory '(:relative "share")) 
                   *path/distdir*))

(map nil (lambda (path)
           (ignore-errors (#+sbcl sb-posix:mkdir
                                  #-sbcl (error "How do you say MKDIR here?") 
                                  (format nil "~a" path)
                                  #o775)))
     (list *path/distdir* *path/libdir* *path/incdir* *path/bindir* *path/sharedir*))


;;; Set up the ASDF Registry

(dolist (path '(#p"elephant/"
                #p"romans/"
                #p"romans/lib/smedict-old/"
                #p"romans/lib/sb-texinfo/"))
  (pushnew (merge-pathnames path *path/r2src*)
           asdf:*central-registry* :test 'equal))

;;; Get the OS  name. Note, we consider “Android”  different enough from
;;; GNU/Linux to warrant its own heading.

(defvar *os-name* (or #+android "Android"
                      #+ios "iOS"
                      #+(or macos osx) "MacOS"
                      #+(or linux linux32 linux64) "Linux"
                      #+darwin "Darwin"
                      #+freebsd "FreeBSD"
                      #+unix "UNIX"
                      #+posix "POSIX"
                      #+(or win32 win64 windows) "Windows"
                      "unknown"))


;;; Bind some  symbols that  will be useful  later. The  crazy interning
;;; mess has been necessary for various reasons.


(eval-when (:compile-toplevel :load-toplevel :execute)
  (unless (boundp (intern "+BUILD-OS+" :cl-user))
    (eval `(progn
             (defconstant ,(intern "+BUILD-OS+" :cl-user)
               ,(intern (string-upcase *os-name*) :keyword))
             (defconstant ,(intern "+BUILD-CPU+" :cl-user)
               ,(intern (string-upcase (machine-type)) :keyword))
             (defconstant ,(intern "+BUILD-LIBDIR+" :cl-user) #p".")))))

(defparameter *path/lib* (or (eval (intern "+BUILD-LIBDIR+" :cl-user))
                             (merge-pathnames
                              ;; TODO: other 64-bit systems add to first list
                              #+(or X86-64) "/usr/lib64/"
                              #-(or X86-64) "/usr/lib/"
                              )))


;;; Preload the basics

(format *trace-output* "~&Quicklisp-quickloading some core dependencies~2%")

(mapcar 
 (lambda (pkg) 
   (ql:quickload pkg :silent t :verbose nil :prompt nil :explain nil))
 '(:cffi :alexandria :split-sequence :local-time :bordeaux-threads))

(format *trace-output* "~&Setting up C library deps…")

(pushnew (merge-pathnames "./lib/cl-bullet2l/" *load-truename*)
         cffi:*foreign-library-directories*
         :test 'equal)
(pushnew *path/lib*
         cffi:*foreign-library-directories*
         :test 'equal)
(pushnew *path/libdir*
         cffi:*foreign-library-directories*
         :test 'equal)

(unless (probe-file (merge-pathnames (make-pathname :name "libfixposix" :type "so")
                                     *path/libdir*))
  (format *trace-output* "~&Building libfixposix …")
  (uiop:run-program (format nil "~a/tools/bin/make-libfixposix" *path/r2project*))
  (format *trace-output* " … done."))

(flet ((path-push (key value)
         (sb-posix:setenv key
                          (format nil "~{~a~^:~}" (remove-if (lambda (el) (or (null el) (equal "NIL" el)))
                                                             (remove-duplicates 
                                                              (append (list (princ-to-string value)) 
                                                                      (split-sequence:split-sequence #\: (sb-posix:getenv key)))
                                                              :test #'string=)))
                          1)
         (format *trace-output* "~& • Set environment variable ~a to “~a”" key (sb-posix:getenv key))))
  (path-push "C_INCLUDE_PATH" *path/incdir*)
  (path-push "PATH" *path/bindir*)
  (path-push "LD_LIBRARY_PATH" *path/libdir*))



(format *trace-output* "~&
  ★ Romance Ⅱ set-up script completed. ★

Configured on ~:(~A~)
Machine type: ~A (~:(~A~))
  specifically: ~A
OS type: ~A (~:(~A~))
LIBDIR: ~S
"
        (machine-instance)
        (machine-type) (eval (intern "+BUILD-CPU+" :cl-user))
        (machine-version)
        *os-name* (eval (intern "+BUILD-OS+" :cl-user))
        (eval (intern "+BUILD-LIBDIR+" :cl-user)))

(unless (ignore-errors (ql:help) t)
  (warn "Quicklisp doesn't appear to be loaded?"))



(declaim (optimize (speed 0) (safety 3) (debug 3) (space 0)))

:romance-ii
