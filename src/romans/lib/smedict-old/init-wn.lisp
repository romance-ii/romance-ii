;;; Loader for WordNet interface

;;; Dan G. Tecuci
;;; University of Texas at Austin
;;; April 2000

(defun init-wn-interf ()
   (mapcar #'load
      '("packages" "parts-of-speech" "wordnet-database-files"
        "parse-wordnet-data" "representation" "relationship-algorithms")))


