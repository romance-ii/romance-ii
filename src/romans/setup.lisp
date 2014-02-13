(in-package :common-lisp-user)

(defpackage :romans-compiler-setup (:use :cl))
(in-package :romans-compiler-setup)

(unless *load-pathname*
  (error "This file must be `load'ed, not `compile'd"))

#-sbcl
(warn "Your compiler is not SBCL. Some things may be weird.

Romance II is being developed using SBCL. While we greatly appreciate
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

If you are legitimately trying to compile Romance II using some
un-Common Lisp, well: good luck, but please don't expect
any miracles.

If you're on a Common Lisp system that doesn't mention COMMON-LISP in
its *FEATURES*, please advise us with a copy of CL:*FEATURES*:~%~S"
      *features*)

#-linux
(warn "*FEATURES* omits LINUX.

Romance II is being developed on Linux®. While support for some other
operating systems is certainly possible, keep in mind, that the more
your operating system differs from Linux, the less likely things are
to Just Work. Patches for other OS are accepted, as long as they don't
break Linux support.

If your OS *is* a Linux, and your compiler simply does not specify
the :LINUX keyword in *FEATURES*, please advise us with this copy of
your CL:*FEATURES*: ~%~S" *features*)

#-x86-64 
(warn "*FEATURES* omits X64-64.

Your machine type is reported as ~A
 (specifically: ~A)

If this is not an AMD-alike* 64-bit architecture, please be forewarned
that Romance II is being developed primarily for the “AMD 64” (X86-64)
architecture. While support for other architectures is surely
possible, and patches are encouraged, neither the curator nor primary
contributors are currently using them.

   * Intel's non-Itanium 64-bit systems are AMD-alikes; e.g. the Intel
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
     ;; Shared logic.                   ;
     (let ((name (sb-kernel::redefinition-warning-name warning)))
       (not (sb-kernel::interesting-function-redefinition-warning-p
             warning
             (or (fdefinition name)
                 (macro-function name)))))))
        
  (deftype my-uninteresting-redefinition ()
    '(or
      (satisfies uninteresting-ordinary-function-redefinition-p)))
        
  (setf sb-ext:*muffled-warnings* 'my-uninteresting-redefinition))

;;; Define “Hosts” for Logical Pathnames

(defun set-logical-pathname-host  (host dir)
  (setf (logical-pathname-translations host)
        `(("**;*.*.*" ,(merge-pathnames "**/" dir))))) ;

(set-logical-pathname-host "etc" (make-pathname :directory '(:absolute "etc")))
(set-logical-pathname-host "share" (make-pathname :directory '(:absolute "usr" "share")))
(set-logical-pathname-host "r2share" "/usr/share/romance-ii/")
(set-logical-pathname-host "bin" "/usr/bin/")
(set-logical-pathname-host "var" "/var/lib/romance-ii/")
(set-logical-pathname-host "tmp" "/tmp/")
(set-logical-pathname-host "vartmp" "/var/tmp/")
(set-logical-pathname-host "r2src"
                           (make-pathname :directory 
                                          `(,@(pathname-directory *load-pathname*) "..")))
(set-logical-pathname-host "r2project"
                           (make-pathname :directory
                                          `(,@(pathname-directory *load-pathname*) ".." "..")))

(let ((r2src (make-pathname :host "r2src" :directory "romans")))
  (pushnew r2src asdf:*central-registry* :test 'equal))

(let ((bullet-src (merge-pathnames "romans/lib/cl-bullet2l/bullet-physics/"
                               (translate-logical-pathname (make-pathname :host "r2src")))))
  (pushnew bullet-src asdf:*central-registry* :test 'equal))

(let ((wn-src (merge-pathnames "romans/lib/smedict-old/"
                               (translate-logical-pathname (make-pathname :host "r2src")))))
  (pushnew wn-src asdf:*central-registry* :test 'equal))

(defvar *os-name* (or #+android "Android"
                      #+ios "iOS"
                      #+linux "Linux"
                      #+darwin "Darwin"
                      #+freebsd "FreeBSD"
                      #+unix "UNIX"
                      #+posix "POSIX"
                      "unknown"))

(eval-when (:compile-toplevel :load-toplevel :execute)
  (unless (boundp (intern "+BUILD-OS+" :cl-user))
    (eval `(progn
             (defconstant ,(intern "+BUILD-OS+" :cl-user) 
               ,(intern (string-upcase *os-name*) :keyword))
             (defconstant ,(intern "+BUILD-CPU+" :cl-user)
               ,(intern (string-upcase (machine-type)) :keyword))
             (defconstant ,(intern "+BUILD-LIBDIR+" :cl-user) #p".")))))

(set-logical-pathname-host "lib" (or (eval (intern "+BUILD-LIBDIR+" :cl-user))
                                     (merge-pathnames 
                                      ;; TODO: other 64-bit systems add to first list
                                      #+(or X86-64) "/usr/lib64"
                                      #-(or X86-64) "/usr/lib"
                                      )))

(format *trace-output* "~&
*** Romance II set-up script completed.

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

:romance-ii

