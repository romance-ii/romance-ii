;;; -*- Mode: LISP; Syntax: Common-lisp; Package: FUTURE-COMMON-LISP-USER; Base: 10 -*-

;;; CommonLisp interface to WordNet
;;; 1995, Mark Nahabedian
;;; Artificial Intelligence Laboratory
;;; Massachusetts Institute of Technology


;;; Modified April 2000 to work with Allegro Common Lisp on Solaris
;;; Dan G. Tecuci,
;;; Univ of Texas at Austin

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; package definitions

(defpackage wordnet
  (:nicknames wn)

  (:use 
	;#+Genera future-common-lisp
        ;#+MCL common-lisp
        ;#+LispWorks common-lisp
	common-lisp)

  (:export
    ;; file "parts-of-speech"
    "CANONICALIZE-PART-OF-SPEECH"
    "DO-PARTS-OF-SPEECH"
    "PARTS-OF-SPEECH"

    ;; file "wordnet-database-files":
    "EXCEPTION-ENTRY-FOR-WORD"
    "INDEX-ENTRY-FOR-WORD"
    "READ-DATA-FILE-ENTRY"

    ;; file "parse-wordnet-data":
    "PARSE-DATA-FILE-ENTRY"
    "PARSE-EXCEPTION-FILE-ENTRY"
    "PARSE-INDEX-FILE-ENTRY"

    ;; file "representation":
    "CACHED-DATA-LOOKUP"
    "CACHED-INDEX-LOOKUP"
    "INDEX-ENTRY-SYNSETS"
    "INDEX-ENTRY-WORD"
    "WORDNET-INDEX-ENTRY"
    "WORDNET-SYNSET-ENTRY"
    "WORDNET-NOUN-ENTRY"
    "WORDNET-ADJECTIVE-ENTRY"
    "WORDNET-ADVERB-ENTRY"
    "WORDNET-VERB-ENTRY"
    "WORDNET-POINTER"
    "WORDNET-POINTERS"
    "WORDNET-POINTER-TYPE"
    "WORDNET-POINTER-FROM-SYNSET"
    "WORDNET-POINTER-FROM-SYNSET-INDEX"
    "WORDNET-POINTER-TO-SYNSET"
    "WORDNET-POINTER-TO-SYNSET-INDEX"
    "PRETTY-PRINT-SYNSET"
    "PART-OF-SPEECH"
    "SYNSET-WORDS"
    "WORDNET-POINTER-FROM-WORD"
    "WORDNET-POINTER-TO-WORD"
    "WORDNET-SYNSET-ENTRY-OFFSET"

    ;; file "relationship-algorithms":
    "RELATION-TRANSITIVE-CLOSURE"
    "COMMONALITY"
	
    ;; file "wn-features":
    "ADD-WN-FEATURES"
    "GET-ALL-OFF-DIST-SUPERS-SYNSETS-NOUN"
    "ADD-MOST-GENERAL-SUPER"
    "CAHED-GET-ALL-OFF-DIST-SUPERS-SYNSETS-NOUN"
    ))

#+CLIM
(defpackage wordnet-interface
  (:nicknames wni)
  (:use wordnet clim clim-lisp)
  (:export
    "WORDNET-BROWSER"
    ))

