(in-package :romans)

;;; Internationalization and Localization Support

(define-constant +language-names+
    '((:en "English" "English" "Language")
      (:es "Español" "Spanish" "Idioma")
      (:fr "Français" "French" "Langue")
      (:ga "Gaeilge" "Irish" "Teanga"))
  :test 'equalp)

(define-condition language-not-implemented-warning (warning)
  ((language :initarg :language :reader language-not-implemented)
   (fn :initarg :function :reader language-not-implemented-function))
  (:report (lambda (s c)
             (format s "There is not an implementation of ƒ ~A for language ~A ~@[~{~*(~A/~A)~}~]"
                     (language-not-implemented-function c)
                     (language-not-implemented c)
                     (assoc (language-not-implemented c) +language-names+)))))

(defmacro defun-lang (function (&rest lambda-list) &body bodies)
  (let ((underlying (intern (concatenate 'string (string function) "%"))))
    (let ((implemented (mapcar #'car bodies)))
      (unless (every (lambda (language) (member language implemented)) 
                     (mapcar #'car +language-names+))
        (warn "Defining ƒ ~A with partial language support: ~{~{~%  • ~5A: ~20A ~:[ ✗ ~; ✓ ~]~}~}"
              function 
              (mapcar (lambda (language)
                        (list (car language)
                              (third language)
                              (member (car language) implemented)))
                      +language-names+))))
    `(progn 
       (defgeneric ,underlying (language ,@lambda-list)
         ,@(mapcar (lambda (body)
                     (let ((match (car body))
                           (code (cdr body)))
                       (unless (assoc match +language-names+)
                         (warn "Defining a handler for unrecognized language-code ~A in ƒ ~A"
                               match function))
                       `(:method ((language (eql ,match)) ,@lambda-list)
                          ,@code)))
                   bodies)
         (:method ((language t) ,@lambda-list)
           (warn 'language-not-implemented-warning :language language :function ',function)
           (,underlying :en ,@lambda-list)))
       (defun ,function (,@lambda-list)
         (,underlying (or (get-lang) :en)
                      ,@lambda-list)))))

(defun char-string (char)
  (make-string 1 :initial-element char))

(defun irish-broad-vowel-p (char)
  (member char '(#\a #\o #\u #\á #\ó #\ú)))

(defun irish-broad-ending-p (word)
  (irish-broad-vowel-p (last-elt (remove-if-not #'irish-vowel-p word))))



(defvar irish-gender-dictionary (make-hash-table :test 'equal))
(dolist (word '(adharc  baintreach  báisteach  buíon  caor  cearc 
                ciall  cloch  cos  craobh  críoch  cros  dámh 
                dealbh  eangach  fadhb  fearg  ficheall  fréamh 
                gaoth  géag  gealt  girseach  grian  iall  iníon 
                lámh  leac  long  luch  méar  mian  mias  muc 
                nead  pian  sceach  scian  scornach  slat
                sluasaid  srón  téad  tonn  ubh banríon  Cáisc 
                cuid  díolaim  Eoraip  feag  feoil  muir  scread
                rogha teanga bearna veain))
  (setf (gethash (string word) irish-gender-dictionary) :f))
(dolist (word '(am anam áth béas bláth cath cíos cith 
                crios dath dream droim eas fíon flaith
                greim loch lus luach modh rámh rang 
                rás roth rud sioc taom teas tréad  
                im sliabh   ainm máistir seans club dlí
                rince))
  (setf (gethash (string word) irish-gender-dictionary) :m))

(defvar english-gender-dictionary (make-hash-table :test 'equal))
(dolist (word '(car automobile ship plane
                airplane boat vessel 
                cat kitty hen chick peahen
                girl woman lady miss mistress mrs ms
                chauffeus…ae masseuse stewardess
                madam))
  (setf (gethash (string word) english-gender-dictionary) :f))
(dolist (word '(man boy guy bloke fellow dude 
                dog cock rooster peacock
                mister master mr))
  (setf (gethash (string word) english-gender-dictionary) :m))

(defun-lang gender-of (noun)
  (:en (if-let ((gender (gethash (string-upcase noun) english-gender-dictionary)))
         gender
         :n))
  (:es (string-ends-with-case noun
         (("o") :m)
         (("a") :f)
         (otherwise :m)))
  (:fr (if (member (last-elt noun) '(#\e #\E))
           :f
           :m))
  (:ga (if-let ((gender (gethash (string-upcase noun) irish-gender-dictionary)))
         gender
         (string-ends-with-case noun
           (("e" "í") :f)
           (("a" "o" "e" "u" "i"
                 "á" "ó" "é" "ú" "í" 
                 "ín") :m)
           (("áil" "úil" "ail" "úint" "cht" "irt") :f)
           (("éir" "eoir" "óir" "úir") :m)
           (("óg" "eog" "lann") :f)
           (otherwise 
            (if (irish-broad-ending-p noun)
                :m
                :f))))))

(defun-lang a/an (string)
  (:en (let ((letter (elt string 0)))
         (case letter
           ((#\a #\e #\i #\o #\u #\h)
            (concatenate 'string "an " string))
           ((#\A #\E #\I #\O #\U #\H)
            (concatenate 'string (funcall (letter-case string) "an ") string))
           (otherwise 
            (concatenate 'string (funcall (letter-case string) "a ") string)))))
  (:es (strcat (funcall (letter-case string)
                        (ecase (gender-of% :es string)
                          ((:m nil) "un ")
                          (:f "una "))) string))
  (:fr (strcat (funcall (letter-case string)
                        (ecase (gender-of% :fr string)
                          ((:m nil) "un ")
                          (:f "une "))) string))
  (:ga string))



(defun internalize-irish (word)
  "Remove presentation forms"
  (substitute-map '(#\ı #\i
                    #\ɑ #\a
                    #\⁊ #\&) word))

(defun present-irish (word)
  "Create a “read-only” string that looks nicer, including the use of
dotless-i (ı) and the letter “latin alpha,“ (ɑ), the Tironian ampersand,
and fixing up some irregular hyphenation rules."
  (let ((word1 (substitute-map '(#\i #\ı
                                 #\a #\ɑ
                                 #\A #\Ɑ
                                 #\⁊ #\&) word)))
    (when (or (search "t-" word1)
              (search "n-" word1))
      (setf word1 (cl-ppcre:regex-replace "\\b([tn])-([AOEUIÁÓÉÚÍ])" word1
                                          "\\1\\2")))
    (when (or (search "de " word1)
              (search "do " word1)
              (search "me " word1)
              (search "ba " word1))
      (setf word1 (cl-ppcre:regex-replace "\\b(ba|de|mo|do) (fh)?([aoeuiAOEUIáóéúíÁÓÉÚÍ])"
                                          word1
                                          "\\1'\\2\\3")))))

(defun irish-eclipsis (word)
  (strcat (case (elt word 0)
            (#\b "m")
            (#\c "g")
            (#\d "n")
            (#\f "bh")
            (#\g "n")
            (#\p "b")
            (#\t "d")
            (otherwise "")) word))

(defun irish-downcase-eclipsed (word)
  "In Irish, eclipsis-added characters shouldn't be capitalized with the rest of the word;
e.g. as an bPoblacht.

It's technically allowed' but discouraged, in ALL CAPS writing."
  (cond
    ((member (subseq word 0 2)
             '("MB" "GC" "ND" "NG" "BP" "DT")
             :test 'string-equal)
     (strcat (string-downcase (subseq word 0 1))
             (funcall (letter-case word) (subseq word 1))))
    ((string-equal (subseq word 0 3) "BHF")
     (strcat "bh" 
             (funcall (letter-case word) (subseq word 2))))
    (t word)))

(assert (equal (irish-downcase-eclipsed "Bpoblacht") "bPoblacht"))
(assert (equal (irish-downcase-eclipsed "BHFEAR") "bhFEAR"))

(defmacro with-irish-endings ((word) &body body)
  `(block irish-endings
     (let* ((last-vowel (or (position-if #'irish-vowel-p ,word :from-end t)
                            (progn
                              (warn "No vowels in ,word? ~A" ,word)
                              (return-from irish-endings ,word))))
            (last-vowels-start 
             (if (and (plusp last-vowel)
                      (irish-vowel-p (elt ,word (1- last-vowel))))
                 (if (and (< 1 last-vowel)
                          (irish-vowel-p (elt ,word (- last-vowel 2))))
                     (- last-vowel 2)
                     (1- last-vowel))
                 last-vowel))
            (vowels (subseq ,word last-vowels-start (1+ last-vowel)))
            (ending (subseq ,word last-vowels-start)))
       (flet ((replace-vowels (replacement)
                (strcat (subseq ,word 0 last-vowels-start) replacement 
                        (subseq ,word (1+ last-vowel))))
              (replace-ending (replacement)
                (strcat (subseq ,word 0 last-vowels-start) replacement))
              (add-after-vowels (addition)
                (strcat (subseq ,word 0 (1+ last-vowel)) addition 
                        (subseq ,word (1+ last-vowel)))))
         ,@body))))

(defun caolú (word)
  "Caolú is the Irish version of palatalisation."
  (with-irish-endings (word)
    (cond
      ((= (length word) last-vowel) word)
      ((or (string-equal "each" ending)
           (string-equal "íoch" ending)) (replace-ending "igh"))
      ((or (string-equal "éa" vowels)
           (string-equal "ia" vowels)) (replace-vowels "éi"))
      ((string-equal "ea" vowels) (replace-vowels "i"))
      ((string-equal "ach" ending) (replace-ending "aigh"))
      ((string-equal "io" vowels) (replace-vowels "i"))
      ((string-equal "ío" vowels) (replace-vowels "í"))
      (t (add-after-vowels "i")))))

(assert (equalp (mapcar #'caolú 
                        '("leanbh" "fear" "cliabh" "coileach" "leac"
                          "ceart" "céad" "líon" "bacach" "pian"
                          "neart" "léann" "míol" "gaiscíoch"))
                '("linbh" "fir" "cléibh" "coiligh" "lic" 
                  "cirt" "céid" "lín" "bacaigh" "péin"
                  "nirt" "léinn" "míl" "gaiscigh")))

;;; NOTE: féar→fir is asserted, but I think they meant fear→fir?
;;; ditto for gaiscíoch→gaiscígh (gaiscigh)

(defun leathnú (word)
  "Make a word broad (in Irish)"
  (with-irish-endings (word)
    (format *trace-output* "~& Leathnú word ~A vowels ~A"
            word vowels)
    (let ((base (string-case vowels
                  (("ei" "i") (replace-vowels "ea"))
                  ("éi" (replace-vowels "éa"))
                  ("ui" (replace-vowels "o"))
                  ("aí" (replace-vowels "aío"))
                  (otherwise
                   (if (and (< 1 (length vowels))
                            (char= #\i (last-elt vowels)))
                       (replace-vowels (subseq vowels 0 (1- (length vowels))))
                       word)))))
      (strcat base
              (case (last-elt base)
                ((#\r #\l #\m #\n) "a")
                (otherwise ""))))))

(let ((slender-words '("múinteoir" "bliain" "feoil" "dochtúir" "fuil"
                       "baincéir" "greim" "móin" "altóir" "muir"))
      (broad-words '("múinteora" "bliana" "feola" "dochtúra" "fola"
                     "baincéara" "greama" "móna" "altóra" "mara")))
  (unless (equalp (mapcar #'leathnú slender-words) broad-words)
    (#+irish-cerror 
     cerror
     #+irish-cerror 
     "Continue, and look foolish when speaking Irish"
     #-irish-cerror
     warn 
     
     "The LEATHNÚ function (used in Irish grammar) is being tested
        with a set of known-good word-forms, but something has gone awry
        and it has failed to properly “broaden” the ending of one or
        more of the words in the test set.

Slender forms: ~{~A~^, ~}
Computed broad forms: ~{~A~^, ~}
Correct broad forms: ~{~A~^, ~}"
     slender-words (mapcar #'leathnú slender-words) broad-words)))


(defun caolaítear (word)
  (todo) word)

(defun leathnaítear (word)
  "LEATHNAÍTEAR (lenition) is used to change the leading consonant in
  certain situations in Irish grammar.

This does NOT enforce the dntls+dts nor m+bp exceptions."
  (flet ((lenite ()
           (strcat (subseq word 0 1)
                   "h"
                   (subseq word 1))))
    (cond
      ((member (elt word 0) '(#\b #\c #\d #\f #\g #\m #\p #\t))
       (lenite))
      ((and (char= #\s (elt word 0))
            (not (member (elt word 1) '(#\c #\p #\t #\m #\f))))
       (lenite))
      (t word))))

(defun-lang declension-of (noun)
  (:en nil)
  (:ga (cond
         ((or (eql (last-elt noun) #\e)
              (eql (last-elt noun) #\í)
              (irish-vowel-p (last-elt noun))
              (string-ends-with noun "ín")) 4)
         ((or (member noun '("áil" "úil" "ail" "úint" "cht" "irt"
                             "éir" "eoir" "óir" "úir") 
                      :test #'string-ends-with)) 3)
         ((or (string-ends-with noun "eog")
              (string-ends-with noun "óg")
              (string-ends-with noun "lann")
              (not (irish-broad-ending-p noun))) 2)
         ((irish-broad-ending-p noun) 1)
         (t (warn "Can't guess declension () of “~a”" noun)))))

(defun-lang syllable-count (string)
  (:en (loop 
          with counter = 0
          with last-vowel-p = nil
            
          for char across (string-downcase string)
          for vowelp = (member char '(#\a #\o #\e #\u #\i))
            
          when (or (and vowelp
                        (not last-vowel-p))
                   (member char '(#\é #\ö #\ï)))
          do (incf counter)
            
          do (setf last-vowel-p vowelp)
            
          finally (return (max 1 
                               (if (and (char= char #\e)
                                        (not last-vowel-p))
                                   (1- counter)
                                   counter)))))
  (:es (loop 
          with counter = 0
          with last-i-p = nil
            
          for char across (string-downcase string)
          for vowelp = (member char '(#\a #\o #\e #\u #\i))
            
          when (or (and vowelp
                        (not last-i-p))
                   (member char '(#\á #\ó #\é #\ú #\í)))
          do (incf counter)
            
          do (setf last-i-p (eql char #\i))
            
          finally (return (max 1 counter))))
  (:ga (loop 
          with counter = 0
          with last-vowel-p = nil
            
          for char across (string-downcase string)
          for vowelp = (irish-vowel-p char)
            
          when (and vowelp
                    (not last-vowel-p))
          do (incf counter)
            
          do (setf last-vowel-p vowelp)
            
          finally (return (max 1 counter)))))

(defun irish-plural-form (string)
  (let* ((gender (gender-of% :ga string))
         (declension (declension-of% :ga string))
         (syllables (syllable-count% :ga string))
         (multi-syllabic (> 1 syllables))
         (len (length string)))
    (cond
      ((and (= 1 declension)
            (eq :m gender)
            (string-ends-with string "ach"))
       (caolaítear
        (strcat (subseq string 0 (- len 3)) "igh")))
      
      ((and (= 1 declension)
            (eq :m gender)
            (string-ends-with string "each"))
       (caolaítear 
        (strcat (subseq string 0 (- len 4)) "aigh")))
      
      ((and (= 1 declension)
            (eq :m gender))
       (caolaítear string))
      
      ((or (and (= 2 declension)
                (eq :f gender)
                (or (string-ends-with string "eog")
                    (string-ends-with string "óg")
                    (string-ends-with string "lann")
                    (and multi-syllabic
                         (string-ends-with string "each"))
                    (equal string "binn")
                    (equal string "deoir")))
           (= 3 declension)
           (= 4 declension))
       (strcat (leathnaítear string) "a"))
      
      ((and (= 2 declension)
            (eq :f gender))
       (strcat string "e"))
      
      ((and (not multi-syllabic)
            (or (and (eq :m gender)
                     (= 1 declension))
                (and (eq :f gender)
                     (= 2 declension)
                     (not (irish-broad-ending-p string)))
                (and (eq :m gender)
                     (= 3 declension))
                (= 4 declension)))
       (strcat string "anna"))     ; -(e)anna??
      
      ((and (not multi-syllabic)
            (or (and (eq :m gender)
                     (= 1 declension))
                (and (eq :f gender)
                     (= 2 declension))
                (= 3 declension))
            (or (char= #\l (last-elt string))
                (char= #\n (last-elt string)))
            (or (diphthongp (subseq string
                                    (- len 2)
                                    len))
                (long-vowel-p (elt string (- len 1)))))
       
       (strcat string "ta"))       ; or -te
      
      ((and (not multi-syllabic)
            (or (and (eq :m gender)
                     (= 1 declension))
                (and (eq :f gender)
                     (= 2 declension)))
            (char= #\r (last-elt string))
            (or (diphthongp (subseq string
                                    (- len 2)
                                    len))
                (long-vowel-p (elt string (- len 1)))))
       
       (strcat string "tha"))      ; or -the
      
      ((and multi-syllabic
            (or (and (eq :m gender)
                     (= 1 declension)
                     (or (string-ends-with string "adh")
                         (string-ends-with string "ach")))
                (and (eq :f gender)
                     (= 2 declension)
                     (or (not (irish-ending-broad-p string))
                         (string-ends-with string "ach")))
                (and (= 3 declension)
                     (any (curry #'string-ends-with string)
                          '("éir" "eoir" "óir" "úir" 
                            "cht" "áint" "úint" "irt")))
                (and (= 4 declension)
                     (or (string-ends-with string "ín")
                         (string-ends-with string "a")
                         (string-ends-with string "e")))))
       (strcat string "í"))
      ;; rules read:
      ;; • add -(a)í
      ;; • -(e)adh, -(e)ach → (a)í
      ;; • -e → í
      
      ((or (and (= 2 syllables)
                (eq :m gender)
                (= 1 declension)
                (let ((last (last-elt string)))
                  (or (char= #\l last)
                      (char= #\n last)
                      (char= #\r last))))
           (and (= 2 declension)
                (eq :f gender))
           (and (= 3 declension)
                (or (string-ends-with string "il")
                    (string-ends-with string "in")
                    (string-ends-with string "ir")))
           (= 4 declension))
       
       (strcat string "acha")) ;; or -eacha
      
      ((and (= 1 declension)
            (eq :m gender))
       (strcat (irish-syncopate string) "e"))
      
      ((= 3 declension)
       (strcat (irish-syncopate string) "a"))
      
      ((and (= 4 declension)
            (string-ends-with string "le")
            )
       (strcat (subseq string 0 (- len 2)) "lte"))
      
      ((and (= 4 declension)
            (string-ends-with string "ne"))
       (strcat (subseq string 0 (- len 2)) "lne"))
      
      (t (warn "Unable to figure out the plural form of “~A” (~:R decl. ~A)"
               string declension gender)
         string))))

(defun-lang plural (count string)
  (:en
   (if (= 1 count) 
       string
       (funcall
        (letter-case string)
        (let ((s (string-downcase string)))
          (flet ((lessen (n)
                   (subseq s 0 (- (length s) n))))
            (if (member s (lc-string-syms 
                           '(bison buffalo deer duck fish moose
                             pike plankton salmon sheep squid swine
                             trout algae marlin
                             furniture information
                             cannon blues iris cactus
                             meatus status specie
                             benshi otaku samurai
                             kiwi kowhai Māori Maori
                             marae tui waka wikiwiki
                             Swiss Québécois omnibus
                             Cherokee Cree Comanche Delaware Hopi
                             Iroquois Kiowa Navajo Ojibwa Sioux Zuni))
                        :test #'string-equal)
                s
                (string-case s
                  ("child" "children") ("ox" "oxen")
                  ("cow" "kine") ("foot" "feet")
                  ("louse" "lice") ("mouse" "mice")
                  ("tooth" "teeth") ("die" "dice") ("person" "people")
                  ("genus" "genera") ("campus" "campuses")
                  ("viscus" "viscera") ("virus" "viruses")
                  ("opus" "opera") ("corpus" "corpera")
                  ("cherub" "cherubim")
                  ("seraph" "seraphim") ("kibbutz" "kibbutzim")
                  ("inuk" "inuit") ("inukshuk" "inukshuit")
                  ("Iqalummiuq" "Iqalummiut")
                  ("Nunavimmiuq" "Nunavimmiut") 
                  ("Nunavummiuq" "Nunavummiut")
                  ("aide-de-camp" "aides-de-camp")
                  
                  (otherwise
                   (string-ends-with-case s
                     ("enny" (strcat (lessen 4) "ence"))
                     ("eau" (strcat s "x"))
                     (("ies" "ese" "fish") s)
                     ("ife" (strcat (lessen 2) "ves"))
                     (("eef" "eaf") (strcat (lessen 1) "ves"))
                     ("on" (strcat (lessen 2) "a"))
                     ("ma" (strcat s "ta"))
                     (("ix" "ex") (strcat (lessen 1) "ces"))
                     ("nx" (strcat (lessen 1) "ges"))
                     (("tum" "dum" "rum") (strcat (lessen 2) "a"))
                     (("nus" "rpus" "tus" "cus" "bus" 
                             "lus" "eus" "gus" "mus") (strcat (lessen 2) "i"))
                     (("mna" "ula" "dia") (strcat (lessen 1) "ae"))
                     ("pus" (strcat (lessen 2) "odes"))
                     ("man" (strcat (lessen 2) "en"))
                     ("x" (strcat s "es"))
                     ("y" (let ((penult (elt s (- (length s) 2))))
                            (if (or (eql #\r penult) (char= #\l penult))
                                (strcat (lessen 1) (char-string penult) "ies")
                                (strcat (lessen 1) "ies"))))
                     
                     (otherwise
                      (strcat s "s")))))))))))
  (:fr (if (= 1 count) 
           string
           (cond
             (t (funcall (letter-case string)
                         (strcat string "s"))))))
  (:es (if (= 1 count) 
           string
           (cond
             (t (funcall (letter-case string)
                         (strcat string "s"))))))
  (:ga 
   (if (= 1 count) 
       string
       (funcall (letter-case string)
                (string-case string
                  ("seoid"  "seoda")
                  ("bean"  "mná")
                  ("grasta" "grásta")
                  (otherwise
                   (irish-plural-form string)))))))

(let ((singulars (lc-string-syms 
                  '(bád fear béal íasc síol bacach taoiseach gaiscíoch
                    deireadh saol
                    beach bos scornach eaglais aisling
                    cainteoir gnólacht tincéir am
                    adhmáil beannacht ban-aba canúint droim
                    bata ciste cailín runaí rí bus
                    ordú cruinniú
                    bearna féile)))
      (plurals (lc-string-syms 
                '(báid f béil éisc síl bacaigh taoisigh gaiscigh
                  deirí saolta
                  beacha bosa scornacha eaglaisí ailingí
                  cainteorí gnólachtaí tincéirí amanna
                  admhálacha beannachtaí ban-abaí canúintí dromanna
                  bataí cistí cailíní runaithe rithe busanna
                  orduíthe cruinnithe
                  bearnaí féilte))))
  (let ((computed (loop for s in singulars
                     collecting (plural% :ga 2 s))))
    (loop for s in singulars
       for pl in plurals
       for c-pl in computed
       when (not (equal pl c-pl))
       do (warn "Plural formation for Irish failed: ~A ⇒ ~A (but got ✗~A)"
                s pl c-pl))))

;; (assert (equal (plural% :ga 5 "súil") "súila"))
;; (assert (equal (plural% :ga 5 "deoir") "deora"))
;; (assert (equal (plural% :ga 5 "cuibhreach") "cubhraigha"))

(define-constant spanish-numbers 
    (mapcar #'lc-string-syms
            '(1 uno
              2 dos
              3 tres
              4 cuatro
              5 cinco
              6 seis
              7 siete
              8 ocho
              9 nueve
              10 diez
              11 once
              12 doce
              13 trece
              14 catorce
              15 quince
              16 dieciséis
              17 diecisiete
              18 dieciocho
              19 diecinueve
              20 veinte
              21 veintiuno
              22 veintidós
              23 veintitrés
              24 veinticuatro
              25 veinticinco
              26 veintiséis
              27 veintisiete
              28 veintiocho
              29 veintinueve
              30 treinta 
              40 cuarenta
              50 cincuenta
              60 sesenta
              70 setenta
              80 ochenta
              90 noventa
              100 cien ;; ciento +
              200 doscientos
              300 trescientos
              400 cuatrocientos
              500 quinientos
              600 seiscientos
              700 setecientos
              800 ochocientos
              900 novecientos
              1000 mil))
  :test 'equalp)

(defun-lang counting (count string)
  (:en (cond
         ((zerop count) (a/an/some% :en 0 string))
         ((< count 21) (funcall (letter-case string)
                                (format nil "~R ~A" count
                                        (plural% :en count string))))
         (t (format nil "~:D ~A" count (plural% :en count string)))))
  (:es (cond 
         ((zerop count) (a/an/some 0 string))
         ((= 1 count) (funcall (letter-case string)
                               (strcat (ecase (gender-of% :es string)
                                         (:m "un ")
                                         (:f "una "))
                                       (plural% :es  count string))))
         ((< count 31) (funcall (letter-case string)
                                (strcat (getf spanish-numbers count)
                                        " " 
                                        (plural% :es count string))))
         (t (format nil "~,,'.:D ~A" count (plural% :es count string))))))

(assert (equal (counting% :es 2 "gato") "dos gatos"))
(assert (equal (counting% :es 1492 "gato") "1.492 gatos"))
(assert (equal (counting% :es 1 "gato") "un gato"))
(assert (equal (counting% :es 1 "casa") "una casa"))

(defun-lang a/an/some (count string)
  (:en (case count
         (0 (concatenate 'string (funcall (letter-case string) "no ")
                         (plural% :en 0 string)))
         (1 (a/an string))
         (otherwise (concatenate 'string (funcall (letter-case string) "some ")
                                 (plural% :en count string)))))
  (:fr (case count
         (0 (concatenate 'string (funcall (letter-case string) "sans ")
                         (plural% :fr 0 string)))
         (1 (a/an string))
         (otherwise (concatenate 'string (funcall (letter-case string) "des ")
                                 (plural% :fr count string)))))
  (:ga (plural% :ga count string)))

;;; Credit for Irish language support to Irish language documents by Amy
;;; de Buitléir, CC-BY 3.0 license, found at
;;; http://unaleargais.ie/foghlaim/ …
;;; http://creativecommons.org/licenses/by/3.0/

