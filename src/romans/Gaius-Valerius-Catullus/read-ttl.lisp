;;;; -*- Lisp -*-
;;;
;;;; Turtle  (Terse   RDF  Triple   Language)  TTL   ontologies  loader.
;;;; Builds upon  the base  work laid out  for ConceptNet5  loading, but
;;;; with the alternative syntax. Also handles TQL files.

(in-package :Catullus)

(defvar *turtle-file*)
(defun read-turtle-file (pathname)
  "Read  a Turtle  (Terse RDF  Triple Language)  file. The  file can  be
compressed, and will be transparently decompressed as it's being read.."
  (let ((*turtle-file* pathname))
    (cond ((file-is-bzip2-p pathname)
           (uiop:run-program (list "/usr/bin/bzip2" "-d" "-c" pathname) 
                             :output #'turtle->sexp))
          (t (with-input-from-file (stream pathname 
                                           :element-type 'character)
               (turtle->sexp stream))))))



(define-constant +bzip2-magic-cookie+ (map 'vector #'char-code
                                           "BZh91AY&SY")
  :test #'equalp
  :documentation "The magic cookie starting a BZip2 file")

(defun file-is-bzip2-p (pathname)
  (let ((file-header (make-array (length +bzip2-magic-cookie+)
                                 :initial-element 42
                                 :element-type '(unsigned-byte 8))))
    (with-input-from-file (stream pathname 
                                  :element-type '(unsigned-byte 8))
      (read-sequence file-header stream))
    (equalp +bzip2-magic-cookie+ file-header)))



(defparameter *turtle-s* :?)
(defparameter *turtle-p* :?)
(defparameter *turtle-o* :?)
(defparameter *turtle-context* :top)
(defparameter *turtle-count* 0)

(defun turtle->sexp (stream)
  (let ((*turtle-s* :?)
        (*turtle-p* :?)
        (*turtle-o* :?)
        (*turtle-context* ())
        (*turtle-count* 0))
    (loop while (turtle-read-term stream))))

(defun turtle-read-number (stream first-char)
  (loop
     with string = (make-array 10
                               :element-type 'character
                               :fill-pointer t
                               :initial-contents (vector first-char))
     with decimalp = nil
     with exponentp = nil

     for peek = (peek-char nil stream)
     do (case peek
          ((#\0 #\1 #\2 #\3 #\4 #\5 #\6 #\7 #\8 #\9)
           (vector-push-extend (read-char stream) string))
          (#\.
           (when decimalp
             (error "Two decimals in one number?"))
           (vector-push-extend (read-char stream) string)
           (setf decimalp t))
          ((#\e #\E)
           (when exponentp
             (error "Two exponents on one number?"))
           (vector-push-extend (read-char stream) string)
           (setf exponentp t))
          (otherwise (return-from turtle-read-number string)))))

(defun turtle-read-blank-phrase (stream)
  (error "Unimplemented"))

(defun turtle-read-blank-reference (stream)
  (error "Unimplemented"))

(defun turtle-read-term (stream) 
  (let ((char (read-char stream nil nil)))
    (unless char (return-from turtle-read-term nil))
    #+ (or) (format *trace-output* "~& • Next term starts with ~:c" char)
    (case char
      ((#\space #\page #\return #\linefeed #\tab) t) ; no op
      ((#\0 #\1 #\2 #\3 #\4 #\5 #\6 #\7 #\8 #\9 #\-)
       (turtle-read-number stream char))
      (#\[ (turtle-read-blank-phrase stream))
      (#\_ (turtle-read-blank-reference stream))
      (#\# (format *trace-output*
                   "~&;; # ~a"
                   (turtle-read-before-delimiter stream #\newline))
           t)
      (#\@ (turtle-read-prefix-or-base-or-error stream))
      (#\< (set-next (turtle-read-iri stream)))
      (#\, (turtle-read-alternative-for-last-word stream))
      (#\. (turtle-end-current-term))
      (#\semicolon (turtle-read-next-predicate-phrase stream))
      (#\apostrophe (turtle-read-quoted-literal stream #\apostrophe))
      (#\" (set-next (turtle-read-quoted-literal stream #\")))
      (otherwise (turtle-read-word stream)))))

(defmacro replace-turtle-word-with-or (place stream)
  `(setf ,place (list 'or ,place
                      (turtle-read-word ,stream))))

(defun turtle-read-alternative-for-last-word (stream)
  (cond ((eql :? *turtle-p*)
         (replace-turtle-word-with-or *turtle-s* stream))
        ((eql :? *turtle-o*)
         (replace-turtle-word-with-or *turtle-p* stream))
        (t
         (replace-turtle-word-with-or *turtle-o* stream))))

(defun turtle-read-next-predicate-phrase (stream)
  (setf *turtle-p* :?
        *turtle-o* :?)
  (turtle-read-term stream))

(defun turtle-read-letters (stream)
  (loop with string = (make-array 15
                                  :element-type 'character
                                  :fill-pointer 0)
     while (alpha-char-p (peek-char nil stream nil))
     do (vector-push-extend (read-char stream nil nil)
                            string)
     finally (return string)))

(defun turtle-read-prefix-or-base-or-? (stream else)
  (let ((next-word (turtle-read-letters stream)))
    (cond ((string-equal next-word "prefix")
           (turtle-read-prefix stream))
          ((string-equal next-word "base")
           (turtle-read-base stream))
          (t (funcall else next-word)))))

(defun rdf-pn-name-char-p (char)
  (or (alphanumericp char) 
      (find char #(#\_ #\. #\-
                   #\· #\‿ #\⁀))
      (char<= (code-char #x300) char (code-char #x36f))))

(defun find-turtle-prefix (prefix)
  (when-let (found (assoc prefix *turtle-context* :test #'string=))
    (cdr found)))

(defun string->iri (string)
  (unless (= 1 (count #\: string))
    (error "No colon in IRI-type-string-thing ~a" string))
  (destructuring-bind (prefix name) (split-sequence #\: string)
    (if-let (iri-prefix (find-turtle-prefix prefix))
      (concatenate 'string iri-prefix name)
      (error "Prefix ~a not registered" prefix))))

(defun turtle-reading-word% (stream start)
  (string->iri
   (loop with string = (make-array 80
                                   :element-type 'character
                                   :fill-pointer t
                                   :initial-contents start)
      with colonp = (find #\: string)
        
      for char = (peek-char nil stream)
        
      when (rdf-pn-name-char-p char)
      do (vector-push-extend (read-char stream) string)
        
      when (char= #\: char)
      do (progn 
           (when colonp
             (error "Two colons in one name"))
           (setf colonp t)
           (vector-push-extend (read-char stream) string))
        
      when (not (or (rdf-pn-name-char-p char)
                    (char= #\: char)))
      do (return string))))

(defmacro turtle-read-word% (place stream &optional (start ""))
  `(setf ,place (turtle-reading-word% ,stream ,start)))

(defun turtle-read-more-subject (stream start)
  (turtle-read-word% *turtle-s* stream start))

(defun turtle-read-prefix-or-base-or-subject (stream)
  (turtle-read-prefix-or-base-or-? 
   stream 
   (lambda (start)
     (turtle-read-more-subject stream start))))

(defun turtle-read-prefix-or-base-or-error (stream)
  (turtle-read-prefix-or-base-or-? 
   stream 
   (lambda (word)
     (error "After @ prefix, expected PREFIX or BASE directive, got ~a" 
            word))))

(defun turtle-read-base (stream)
  (error "unimplemented BASE — FIXME"))

(defun whitespacep (char)
  (and (characterp char)
       (not (graphic-char-p char))
       (not (char= #\Space char))))

(defun skip-whitespace (stream)
  (loop while (whitespacep (peek-char nil stream))
     do (read-char stream)))

(defun turtle-read-prefix (stream)
  (skip-whitespace stream))

(defun turtle-read-multi-line-quoted-literal (stream delimiter)
  (error "multi-line literal TODO"))

(defun turtle-read-quoted-literal (stream delimiter)
  (if (char= (peek-char nil stream nil) delimiter)
      (progn (read-char stream nil nil)
             (if (char= (peek-char nil stream nil) delimiter)
                 (progn (read-char stream nil nil)
                        (turtle-read-multi-line-quoted-literal
                         stream delimiter))
                 (turtle-read-string-attributes stream "")))
      (turtle-read-string-attributes
       stream
       (turtle-read-before-delimiter stream delimiter))))

(defun turtle-read-before-delimiter (stream delimiter)
  (loop with string = (make-array 80
                                  :element-type 'character
                                  :adjustable t
                                  :fill-pointer 0)
     for char = (read-char stream nil nil)
       
     do (cond ((char= char #\Null) t)  ; Skip NULL
              ((char= char #\\)
               (vector-push-extend (read-char stream) string))
              ((char= char delimiter)
               (return string))
              (t (vector-push-extend char string)))))

(defun set-next (string)
  (cond ((eql :? *turtle-s*) (setf *turtle-s* string))
        ((eql :? *turtle-p*) (setf *turtle-p* string))
        ((eql :? *turtle-o*) (setf *turtle-o* string))
        (t (error "Four words in a phrase?"))))

(defun turtle-read-iri (stream)
  (turtle-read-before-delimiter stream #\>))

(defun turtle-end-current-term ()
  (trace-sample-record *turtle-file*
                       (incf *turtle-count*)
                       *turtle-s* *turtle-p* *turtle-o*)
  (add-concept *turtle-s* *turtle-p* *turtle-o*) 
  (setf *turtle-s* :?
        *turtle-p* :?
        *turtle-o* :?))

(defun turtle-read-string-language (stream string)
  (assert (char= #\@ (read-char stream)))
  (concatenate 'string "@str/" (turtle-read-letters stream) "/" 
               string))

(defun turtle-read-type-annotation (stream string)
  (assert (char= #\^ (read-char stream)))
  (assert (char= #\^ (read-char stream)))
  (error "Annotation of types not supported"))

(defun turtle-read-predicate (stream)
  (turtle-read-word% *turtle-p* stream))

(defun turtle-read-object (stream)
  (turtle-read-word% *turtle-o* stream))

(defun turtle-read-string-attributes (stream string)
  (case (peek-char nil stream nil)
    (#\@ (turtle-read-string-language stream string))
    (#\^ (turtle-read-type-annotation stream string))
    (otherwise string)))

(defun turtle-read-word (stream)
  (cond ((eql :? *turtle-s*)
         (turtle-read-prefix-or-base-or-subject stream))
        ((eql :? *turtle-p*)
         (turtle-read-predicate stream))
        ((eql :? *turtle-o*)
         (turtle-read-object stream))
        (t (error "Fourth term?"))))


