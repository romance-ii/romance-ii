;; Sarah Tierney
;; component-find-offset.lisp

(load "init-wn.lisp")
(init-wn-interf)

;; loads the global variable of the index file of components
;; *component-index*
(load "~www/users/mfkb/RKF/tree/clib-index-data.lisp")

;; wrapper for component-find that returns a sorted list of 
;; semantically close concepts in the component-library
;; retains the concept that is 
(defun component-find-sorted (word)
  (reverse
   (remove-duplicates 
    (sort (component-find word) #'index-entry->=)
    :key #'car :test #'string=)))

;; function gets word from caller and searches all parts of speech for 
;; matches.
;; returns a list of lists of
;; matching synonyms, level in component-library, parts of speech labels,
;; and level found in searching label
;; ie: ((<component> <level in library> <ptspeech> <level in search>)...)
(defun component-find (word)
  (if (and (stringp word)
	   (<= (length word) 25))
      
      (remove-duplicates
       (concatenate 'list 
		    (component-find-with-part-speech word "verb")
		    (component-find-with-part-speech word "noun")
		    (component-find-with-part-speech word "adverb")
		    (component-find-with-part-speech word "adjective"))
       :test #'equal)))

;; function gets word and part of speech from caller and searches for matches
;; under that part of speech. returns a list of lists of matching synonyms, level in
;; component library, parts of speech labels, and level found in searching
;; ie : ((<component> <level in library> <ptspeech> <level in search>)...) 
(defun component-find-with-part-speech (word part-speech)
  (let ((cmatches (refine-component-check (component-check word))))
    (concatenate 'list (if (= (length cmatches) 0)
			   '()
			 (first (cons cmatches '())))
		 (hypernym-check(offsets-word word part-speech)))))

;; refine-component-check returns an empty list if there are no component matches
;; and returns a list of lists of matching components, level in component library, ptspeech, and level
;; in search--- can only match 1 component to word given
(defun refine-component-check (lst)
  (if (= (length lst) 0)
      '()
    (remove-duplicates
     (mapcar #'(lambda (str) 
		 (concatenate 'list str (list 0))) 
	     lst) 
     :test #'equal)))

;; component-check returns list of lists of matching components and level in component library
(defun component-check (word)
  (let ((matches '() ))
    (dolist (obj *component-index*)
	    (cond ((string-equal (first (cdr obj)) word) 
		   (setf matches (cons (append (cdr obj) (get-part-speech obj)) matches)))))
    matches))

;; gets the part of speech that corresponds to the matching offset
(defun get-part-speech (obj)
  (list (third (first obj))))

;; hypernym-check returns the concatenated list of all matching components of all levels of the 
;; hypernym tree for each synonym of the given word
(defun hypernym-check (hypernym-list)
  (if (null hypernym-list)
      nil
    (concatenate 'list (looptree-offset (car hypernym-list)) (hypernym-check (cdr hypernym-list)))))


;; looptree-offset finds the matches in the component library for the words in the synsets of
;; the hypernym tree	
 (defun looptree-offset (offset-list)
  (let (( lev 1)
       (matches4 '() ))
    (dolist (obj offset-list)
	    (if (null(looptree2-offset obj) )
		'()
	      (setf matches4 (concatenate 'list (append-level (looptree2-offset obj) lev) matches4) ))
	    (setf lev (+ lev 1)))
    matches4))   
 
;; appendlev adds the level of the word found in the hypernym tree to the output list
(defun append-level (lst level)
  (mapcar #'(lambda (str2) (concatenate 'list str2 (list level))) lst))

;; looptree2-offset searches through the words who have synonyms and offsets associated with the word
;; and searches for matches in the component library
(defun looptree2-offset (newp)
  (let (( matches3 '() ))
    (dolist (obj *component-index*)
	    (cond ((equal (fourth (first obj)) newp)
		   (setf matches3 (cons (append (cdr obj) (get-part-speech obj)) matches3)))))
    matches3))

;; returns list of hypernym trees of each synset's offset numbers for a given word
(defun offsets-word (word part-speech)
  (cond ((string-equal part-speech "noun")
	 (mapcar #'get-offsets(wn:index-entry-synsets (wn:cached-index-lookup  word :noun))))
	((string-equal part-speech "verb")
	 (mapcar #'get-offsets(wn:index-entry-synsets (wn:cached-index-lookup word :verb))))
	((string-equal part-speech "adjective")
	 (mapcar #'get-offsets(wn:index-entry-synsets (wn:cached-index-lookup word :adjective))))
	((string-equal part-speech "adverb")
	 (mapcar #'get-offsets(wn:index-entry-synsets (wn:cached-index-lookup word :adverb))))))


;; function returns the offset numbers for the hypernym tree
(defun get-offsets (synset)
  (mapcar #'wn: wordnet-synset-entry-offset
	  (reverse 
	   (mapcar #'first 
		   (wn:relation-transitive-closure synset :hypernym)))))

;; 
;; less-than predicate for entries returned by component-find-aux.
;; Entry (Comp-name level pos dist) is sorted 
;; - ascending on dist,
;; - descending on level
;; - ascending on Comp-name  
(defun index-entry-< (x y)
   (or (< (nth 3 x) (nth 3 y))
       (and (= (nth 3 x) (nth 3 y))
            (> (nth 1 x) (nth 1 y)))
       (and (= (nth 3 x) (nth 3 y))
	    (= (nth 1 x) (nth 1 y))
	    (string< (nth 0 x) (nth 0 y)))))

;; greater or equal for entries returned by component-find-aux
(defun index-entry->= (x y)
  (index-entry-< y x))




