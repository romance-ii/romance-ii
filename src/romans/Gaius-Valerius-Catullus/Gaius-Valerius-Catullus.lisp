(in-package :catullus)

(defvar *logical-output* nil)

(defmacro logic-trace (&rest args)
  `(when *logical-output*
     (format *logical-output* ,@args)))

(defun mq/tap-n-talk->utterance (message)
  (TODO message))

(defun parse-utterance (utterance)
  (TODO utterance))

(defun find-translation (utterance language-code)
  (or (loop
         for (xlat p o) in (find-facts '* "/r/TranslationOf" utterance)
         for path = (split-sequence:split-sequence #\/ utterance
                                                   :remove-empty-subseqs t)
         when (string-equal (second path) (symbol-name language-code))
         return (list :english-word xlat)
         finally (list :foreign-term utterance))
      (let ((path (split-sequence #\/ utterance
                                  :remove-empty-subseqs t)))
        (assert (and (<= 3 (length path))
                     (string-equal "c" (first path))
                     (<= 2 (length (second path)) 7)
                     (every (lambda (char)
                              (or (char<= #\a char #\z)
                                  (char<= #\A char #\Z)
                                  (char= char #\-)
                                  (char= char #\_)))
                            (second path))))
        (append (list :untranslatable (make-keyword (second path)))
                (nthcdr 2 path)))))

(defgeneric utterance->human (utterance language-code))

(defgeneric utterance-formatting-string (predicate language-code))

(defmethod utterance-formatting-string ((predicate symbol) language-code)
  (utterance-formatting-string (utterance->human predicate language-code) language-code))

(defun normalise-noun (noun)
  "Given a noun, normalise it as best possible."
  (if (stringp noun)
      (cond
        ((find #\( noun) 
         (warn "Contains a parenthetical expression, which should be parsed. TODO")
         noun)
        (t noun))
      noun))

(defun predicate-string (predicate)
  (string-camelcase (string predicate)))

(defun conceptnet-predicate->keyword (predicate)
  (if (stringp predicate) 
      (make-keyword (cffi:translate-camelcase-name predicate))
      predicate))

(defun normalise-predicate (subject predicate object)
  "Given a  predicate with complex  meaning, attempt to  break it down  into a simpler  predicate which is  perhaps more
understandable  to  the  logic  system.  Returns  a  clause  in  p-s-(o)  order,  but  may  have  sub-clauses  and  such
after processing."
  (let ((subject (normalise-noun subject))
        (object (normalise-noun object))
        (predicate (conceptnet-predicate->keyword predicate)))
    ;; if the CASE returns NIL, return the list (P S O)
    (or (case predicate
          (:/r/-antonym nil)
          (:/r/-at-location (list :is-at subject (list :/r/-is-a object :location)))
          (:/r/-attribute nil)
          (:/r/-capable-of nil)
          (:/r/-causes nil)
          (:/r/-causes-desire (list :/r/-causes subject (list :/r/-desire-of '* object)))
          (:/r/-conceptually-related-to nil)
          (:/r/-compound-derived-from (list :/r/-derived-from (list :/r/-is-a subject :compound) object))
          (:/r/-created-by nil)
          (:/r/-defined-as nil)
          (:/r/-derivative (list :/r/-derived-from object subject))
          (:/r/-derived-from nil)
          (:/r/-desire-of nil)
          (:/r/-desires nil)
          (:/r/-entails nil)
          (:/r/-etymologically-derived-from nil)
          (:/r/-has-a nil)
          (:/r/-has-context nil)
          (:/r/-has-first-subevent `(and (:/r/-has-a (:/r/-is-a ,subject :event) (:/r/is-a ,object :sub-event))
                                         (:precedes ,object (and (:/r/-is-a '* :sub-event)
                                                                 (not (equal '* ,object))))))
          (:/r/-has-last-subevent `(and (:/r/-has-a (:/r/-is-a ,subject :event) (:/r/is-a ,object :sub-event))
                                        (:follows ,object (and (:/r/-is-a '* :sub-event)
                                                               (not (equal '* ,object))))))
          (:/r/-has-pain-character nil)
          (:/r/-has-pain-intensity nil)
          (:/r/-has-prerequisite nil)
          (:/r/-has-property nil)
          (:/r/-has-subevent nil)
          (:/r/-inherits-from nil)
          (:/r/-instance-of nil)
          (:/r/-is-a nil)
          (:/r/-located-near nil)
          (:/r/-location-of-action nil)
          (:/r/-made-of nil)
          (:/r/-member-of nil)
          (:/r/-motivated-by-goal `(and (:/r/-has-a ,subject (:/r/-is-a ,object :goal))))
          (:/r/-not-capable-of `(not (:/r/-capable-of ,subject ,object)))
          (:/r/-not-causes `(not (:/r/-causes ,subject ,object)))
          (:/r/-not-desires `(not (:/r/-desires ,subject ,object)))
          (:/r/-not-has-a `(not (:/r/-has-a ,subject ,object)))
          (:/r/-not-has-property `(not (:/r/-has-property ,subject ,object)))
          (:/r/-not-is-a `(not (:/r/-is-a ,subject ,object)))
          (:/r/-not-made-of `(not (:/r/-made-of ,subject ,object)))
          (:/r/-not-used-for `(not (:/r/-used-for ,subject ,object)))
          (:/r/-obstructed-by nil)
          (:/r/-part-of nil)
          (:/r/-receives-action `(:receives ,subject (:/r/-is-a ,object :action)))
          (:/r/-related-to nil)
          (:/r/-similar-size `(:/r/-similar-to (:size-of ,subject) (:size-of ,object)))
          (:/r/-similar-to nil)
          (:/r/-symbol-of nil)
          (:/r/-synonym nil)
          (:/r/-translation-of nil)
          (:/r/-used-for nil)
          (:/r/-used-for/ (normalise-predicate subject :/r/-used-for object))
          (:/r/dbpedia/field nil)
          (:/r/dbpedia/genre nil)
          (:/r/dbpedia/influenced-by nil)
          (:/r/wordnet/adjective-pertains-to nil)
          (:/r/wordnet/adverb-pertains-to nil)
          (:/r/wordnet/participle-of nil)
          (t (cerror "ignore and continue" "Unrecognized predicate: ~A" predicate)
             "“~A” —~s→ “~A”"))
        (list predicate subject object))))

(defmethod utterance-formatting-string ((predicate string) language-code)
  (utterance-formatting-string (conceptnet-predicate->keyword predicate) language-code))

(defmethod utterance-formatting-string ((predicate symbol) (language-code (eql :en)))
  (if-let ((formatter (find-facts predicate (format nil "/oper/format/~(~a~)" language-code) '*)))
    (regex-replace-pairs '(("\\~s" . "~0@*~a")
                           ("\\~p" . "~1@*~a")
                           ("\\~o" . "~2@*~a")) formatter)
    
    
    (progn (cerror "ignore and continue" "Untranslated predicate: ~A" predicate)
           "“~A” —~s→ “~A”")))

(defgeneric language-name (code in-language)
  (:method ((code t) (language-code (eql :en)))
    (format nil "the language with code ~A" code))
  (:method ((code string) (language-code t))
    (if (string-begins "/c/" code)
        (let ((path (split-sequence #\/ code)))
          (language-name (make-keyword (string-upcase (second path))) language-code))
        (language-name (make-keyword (string-upcase code)) language-code)))
  (:method ((code (eql :en)) (lang (eql :en))) "English")
  (:method ((code (eql :es)) (lang (eql :en))) "Spanish")
  (:method ((code (eql :ga)) (lang (eql :en))) "Irish")
  (:method ((code (eql :fr)) (lang (eql :en))) "French")
  (:method ((code (eql :ru)) (lang (eql :en))) "Russian")
  (:method ((code (eql :la)) (lang (eql :en))) "Latin")
  (:method ((code (eql :de)) (lang (eql :en))) "German")
  (:method ((code (eql :pt)) (lang (eql :en))) "Portuguese")
  (:method ((code (eql :zh)) (lang (eql :en))) "Chinese")
  (:method ((code (eql :ja)) (lang (eql :en))) "Japanese")
  (:method ((code (eql :cs)) (lang (eql :en))) "Czech")
  (:method ((code (eql :el)) (lang (eql :en))) "Greek")
  (:method ((code (eql :fi)) (lang (eql :en))) "Finnish")
  (:method ((code (eql :it)) (lang (eql :en))) "Italian")
  (:method ((code (eql :sv)) (lang (eql :en))) "Swedish"))

(defgeneric utterance->human/sub-expression
    (keyword utterance language-code))

(defmethod utterance->human/sub-expression ((keyword t) utterance (language-code (eql :en)))
  (format nil "~A: [~{~A~^ ~}]" keyword utterance))

(defmethod utterance->human/sub-expression ((keyword (eql :untranslateable))
                                            utterance
                                            (language-code (eql :en)))
  (let ((path (etypecase utterance
                (string (split-sequence:split-sequence #\/ utterance
                                                       :remove-empty-subseqs t))
                (cons utterance))))
    (string-case (car path)
      ("c" (format nil "“~A~{~^ (~A)~}” (in ~A)"
                   (third path) (cdddr path)
                   (language-name (second path) :en)))
      (t (format nil "untranslateable concept in ~A encoded as ~A"
                 (second path) utterance)))))


(defgeneric utterance->human/fact (utterance language-code))

(defmethod utterance->human/fact (utterance (language-code (eql :en)))
  (destructuring-bind (subj pred obj) utterance
    (format nil (utterance-formatting-string pred :en)
            (utterance->human subj :en)
            (utterance->human pred :en)
            (utterance->human obj :en))))

(defmethod utterance->human ((utterance cons) (language-code (eql :en)))
  (typecase (car utterance)
    (character (ecase (car utterance)
                 (#\; (format nil "~{~a~^ — ~}" (mapcar (rcurry #'utterance->human :en)
                                                        (rest utterance))))))
    (keyword (utterance->human/sub-expression (car utterance)
                                              (cdr utterance) language-code))
    (t (utterance->human/fact utterance language-code))))

(defun launder_string (string)
  (map 'string (lambda (ch) (case ch
                              (#\Tab #\Space)
                              (#\_ #\Space)
                              (otherwise ch)))
       string))

(defmethod utterance->human ((utterance null) language-code)
  (warn "Got a null in an utterance.")
  "∅")

(defun destructure-assertion-1 (a)
  (unless (and (string= (subseq a 0 4) "/a/[")
               (char= (elt a (1- (length a))) #\])
               (not (find #\[ (subseq a 4 (- (length a) 2)))))
    (cerror "skip it" "Can't destructure assertion ~A" a)
    (return-from destructure-assertion-1
      (concatenate 'string "/c/ConceptNet/borked" a)))
  (destructuring-bind (pred subj obj)
      (split-sequence:split-sequence #\, a
                                     :start 4 :end (- (length a) 2))
    (list :clause subj pred obj)))

(defmethod utterance->human ((predicate symbol) language-code)
  (utterance-formatting-string (cffi:translate-camelcase-name predicate) language-code))

(defmethod utterance->human ((utterance string) (language-code (eql :en)))
  (if (or (find #\/ utterance)
          (find #\_ utterance))
      (let ((path (split-sequence:split-sequence #\/ utterance
                                                 :remove-empty-subseqs t)))
        (string-case (car path)
          ("c" (if (equal "en" (second path))
                   (format nil "~A~{ (~A)~}"
                           (launder_string (third path)) (mapcar #'launder_string (nthcdr 4 path)))
                   (utterance->human (find-translation utterance language-code) language-code)))
          ("r" (format nil "~A~{ (~A)~}" (second path) (nthcdr 3 path)))
          ("a" (utterance->human (destructure-assertion-1 utterance) :en))
          (t (cerror "Use it unmodified"
                     "An unrecognized part of speech “~A” was found in “~A”"
                     (car path) utterance)
             utterance)))
      (utterance->human (concatenate 'string "/c/en/" utterance) :en)))

(defmethod utterance->human ((utterance integer) language-code)
  (let ((p (db-execute-single "SELECT symbol FROM atoms WHERE id=?"
                              utterance)))
    (if (and (< 3 (length p)) (string= "/r/" (subseq p 0 3)))
        p
        (utterance->human p language-code))))

(defun adjudicate-utterance (context utterance) (TODO context utterance))

(defun evaluate-utterance (utterance) (TODO utterance))

(defun repond-to-yes/no (utterance response) (TODO utterance response))

(defun resolve-anaphora (context anaphora) (TODO context anaphora))

(defun unbound-anaphora->question (anaphora) (TODO anaphora))

(defun unbound-anaphora->guess (anaphora) (TODO anaphora))

(defun adjudicate-lie/joke (context utterance) (TODO context utterance))

(defun adjudicate-trust (context utterance) (TODO context utterance))

(defun utterance->mq (utterance) (TODO utterance))

(defun prompt/self-introduction (context) (TODO context))
(defun prompt/curiosity (context subject) (TODO context subject))
(defun prompt/request (context request) (TODO context request))
(defun prompt/imperative (context demand) (TODO context demand))
(defun prompt/express-interest (context subject) (TODO context subject))
(defun adjudicate-imperative/obedience (context demand) (TODO context demand))
(defun evaluate-imperative/determine-plan (context demand) (TODO context demand))

;;; ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––


(defun find-facts-about (noun)
  (append (find-facts noun '* '*)
          (find-facts '* '* noun)))

(defun converse-repl-help ()
  (format t "

––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––----

Good morning. You're in the Conversational REPL now.

I understand questions, and try to answer them, if you end them with: ?
  Where is Paris?

I accept advice about my answers, if you end it with: !
  Paris, France is not in Texas!

I learn from you, if you tell me factual statements, and end with: .
  Paris is a city.

If you want to annotate your transcript with a remark to yourself,
you can whisper by leading off with a ;
  ; This computer is dumb.

To see this help again, enter just a ? by itself.
To quit, enter: Bye!

––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––----
"))

(defvar *last-reply*)

(defun converse-dump (stuff)
  (if stuff
      (format t "~&REPLY: ~A"
              (utterance->human (setf *last-reply* stuff) :en))
      (format t "~&☹I have no reply to that.")))

(defun converse-read ()
  (format t "~&~10TReady ⇒")
  (read-line))

(defun descend-langutils-tokens (chain)
  (etypecase chain
    (list (mapcar #'descend-langutils-tokens chain))
    (vector (loop for el across chain collecting (descend-langutils-tokens el)))
    (integer (langutils:token-for-id chain))))

(defun all-but (index list)
  (loop for el in list for i from 0
     unless (= index i) collect el))

(defun parse-noun-expression (tagged)
  (cond
    ((or (null tagged) (zerop (length tagged))) nil)
    (t (let ((nn (loop for (word tag) in tagged
                    for index from 0
                    when (member tag '(:nn)) collect index)))
         (cond
           ((= 1 (length nn)) (list (nth (car nn) tagged)
                                    (all-but (car nn) tagged)))
           ((= 0 (length nn)) (warn "no nouns in ~S" tagged) nil)
           (t (error "too many nouns for me, I'm confused")))))))

(defun expand-tags-of-verb (tag)
  (ecase tag
    (:vb  '(:verb))
    (:vbd '(:verb :past))
    (:vbg '(:verb :present :participle))
    (:vbn '(:verb :past :participle))
    (:vbp '(:verb :present :not-3s))
    (:vbz '(:verb :present :third-person :singular))))

(defun parse-tagged-into-tree (tagged)
  ;; First, let's look for the verb
  (let ((vb (loop for (word tag) in tagged
               for index from 0
               when (member tag '(:vb :vbd :vbg :vbn :vbp :vbz)) collect index)))
    (cond
      ((zerop (length vb))
       (error "Can't interpret a sentence without a verb of some kind…"))
      ((= 1 (length vb ))
       ;; unambiguous: single verb in sentence
       (let* ((vi (car vb))
              (v (nth vi tagged)))
         (list (cons (car v) (expand-tags-of-verb (second v)))
               (when (plusp vi) (parse-noun-expression (subseq tagged 0 vi)))
               (when (< vi (length tagged)) (parse-noun-expression (subseq tagged (1+ vi)))))))
      (t (error "Can't parse complex multi-verb sentences, yet")))))

(defun converse/answer-question (string tagged haggard)
  (declare (ignorable string tagged haggard))
  (format *trace-output* "~& Answering question: ~A" string)
  ;; (format *trace-output* "~& tree: ~S" (parse-tagged-into-tree haggard))
  (cond
    ((find-if (lambda (pair) (equal (second pair) :WP)) haggard)
     (let ((wh (car (remove-if-not (lambda (pair)
                                     (eql (second pair) :WP)) haggard)))
           (vb (car (remove-if-not (lambda (pair)
                                     (eql (second pair) :VBZ))
                                   haggard))))
       
       (format *trace-output* "~& WH-? ~a  Verb? ~a …" wh vb)
       (assert (< (position wh haggard :test #'equalp)
                  (position vb haggard :test #'equalp)))
       (let* ((trailing (subseq haggard (1+ (position vb haggard :test #'equalp))))
              (thing (find-if (lambda (x) (eql (second x) :nn)) trailing)))
         (unless thing
           (error "I don't know what you're asking me about."))
         (format *trace-output* "~& You want to know what is “~a” …" thing)
         (let ((facts (find-facts-about (concatenate 'string "/c/en/"(car thing)))))
           (cond
             ((emptyp facts)
              (format t "~2% Sorry, I don't know anything about “~a”" (car thing)))
             ((> 5 (length facts))
              (format t "~2%~{~% • ~a~}" (mapcar (rcurry #'utterance->human :en) facts)))
             (t (format t "~2%~{~% • ~a~}~%(and I know ~r other fact~:p, too)" 
                        (mapcar (rcurry #'utterance->human :en) (subseq facts 0 5)) 
                        (- (length facts) 5))))))))
    (t ;; adjudicate validity of assertion
     (TODO "true or false question, perhaps?"))))

(defun space-to-_ (string)
  (substitute #\_ #\space string))

(defun concept-for (thing language)
  (format nil "/c/~(~A~)/~:[~(~A~)~;~{~(~A~)~^/~}~]"
          language (consp thing)
          (if (consp thing)
              (mapcar #'space-to-_ thing)
              thing)))

(defun ask-disambiguate-concept (concept)
  `(:you :/r/meaning-intended (or 
                               ,@(mapcar (lambda (sub-concept)
                                           (list concept :/r/-is-a sub-concept))
                                         (sub-concepts concept)))))

(defun sub-concepts (concept)
  (mapcar #'second
          (db-execute "select symbol from atoms
 where substr(symbol,1,?)=? 
    and substr(symbol,?+1,1) in ('/', '_')"
                      (length concept)
                      concept
                      (length concept))))

(defun string-camelcase (string &optional (initial-upper-case-p t))
  (let ((to-upper initial-upper-case-p))
    (coerce (remove-if #'null
                       (loop for ch across string
                          collecting (cond 
                                       ((member ch '(#\- #\_ #\Space))
                                        (setf to-upper t)
                                        nil)
                                       (to-upper
                                        (setf to-upper nil)
                                        (char-upcase ch))
                                       (t (char-downcase ch)))))
            'string)))

(defun relation-for (thing language)
  (ecase language
    (:en (format nil "/r/~:(~A~)" (string-camelcase thing)))))

(defun get-anonymous-node ()
  (format nil "/n/~A" (gensym "node-")))

(defun parse-sentence-langnet (haggard)
  (let (prep be have adjs noun advs verb subj obj wh facts)
    (format *trace-output* "~&Going to parse ~S" haggard)
    (loop
       for i from 0 upto (length haggard)
       for (word . tags) in haggard
       when tags
       do (ecase (car tags)
            (:WP                      ; question word or preposition?
             (setf wh (cons word tags)))
            (:NN (let ((_ (get-anonymous-node)))
                   (push (list _ "/r/IsA" (concept-for word :en)) facts)
                   (when adjs
                     (push (mapcar
                            (lambda (adj)
                              (list _ "/r/-has-property"
                                    (concept-for adj :en))) adjs) facts)
                     (setf adjs nil))
                   (when wh
                     (push (list _ "/r/Inquiry" (concept-for wh :en)) facts)
                     (setf wh nil))
                   (when prep
                     (push (list (relation-for prep :en) _) adjs))
                   (when noun
                     ())))
            ((:TO :JJ) (setf prep word))
            ((:DT :PRP$) (setf adjs word))
            (:VBZ (setf verb word))
            (:adverb (push (concept-for word :en) advs))
            (:. nil))
       do (format *trace-output*
                  "~& Parsing: so far ~S~%    dangling bits: ~@[prep ~S ~]~@[be ~S ~]~@[have ~S ~]~
~@[adjs ~S ~]~@[noun ~S ~]~@[verb ~S ~]~@[subj ~S ~]~@[obj ~S ~]~
~@[wh ~O ~]"
                  facts
                  prep be have adjs noun verb subj obj wh))
    facts))

(defun string-to-sentence (string)
  (parse-sentence-langnet (tagged-to-haggard (langutils:tag string))))

(defun tagged-to-haggard (tagged)
  (mapcar
   (lambda (taggy)
     (destructuring-bind (morph &rest tags)
         (split-sequence:split-sequence #\/ taggy)
       (cons morph (mapcar (lambda (tag) (intern tag :keyword)) tags))))
   (split-sequence:split-sequence #\Space tagged)))

(defun tag->description-of-tag (tag)
  (ecase tag
    (:CC "Coordinating conjunction")
    (:CD  "Cardinal number")
    (:DT  "Determiner")
    (:EX  "Existential there")
    (:FW  "Foreign word")
    (:IN  "Preposition or subordinating conjunction")
    (:JJ  "Adjective")
    (:JJR  "Adjective, comparative")
    (:JJS  "Adjective, superlative")
    (:LS  "List item marker")
    (:MD  "Modal")
    (:NN  "Noun, singular or mass")
    (:NNS  "Noun, plural")
    (:NNP  "Proper noun, singular")
    (:NNPS  "Proper noun, plural")
    (:PDT  "Predeterminer")
    (:POS  "Possessive ending")
    (:PRP  "Personal pronoun")
    (:PRP$  "Possessive pronoun (prolog version PRP-S)")
    (:RB  "Adverb")
    (:RBR  "Adverb, comparative")
    (:RBS  "Adverb, superlative")
    (:RP  "Particle")
    (:SYM  "Symbol")
    (:TO  "to")
    (:UH  "Interjection")
    (:VB  "Verb, base form")
    (:VBD  "Verb, past tense")
    (:VBG  "Verb, gerund or present participle")
    (:VBN  "Verb, past participle")
    (:VBP  "Verb, non-3rd person singular present")
    (:VBZ  "Verb, 3rd person singular present")
    (:WDT  "Wh-determiner")
    (:WP  "Wh-pronoun")
    (:WP$  "Possessive wh-pronoun (prolog version WP-S)")
    (:WRB  "Wh-adverb")
    (:|.| "full stop")
    (:|:| "(colon:)")
    (:|(| "(open paren:)")))

(defun describe-tags (cons)
  (cond 
    ((= 1 (length cons))
     (concatenate 'string (car cons) " (no tag)"))
    
    ((= 2 (length cons))
     (destructuring-bind (word tag) cons
       (concatenate 'string word " (" (tag->description-of-tag tag) ")")))))

(defun clean-up-string (string)
  (let ((words (remove-if #'emptyp
                          (split-sequence #\space 
                                          (substitute-if #\space 
                                                         (rcurry #'find +whitespace+) 
                                                         string)))))
    (format nil "~{~a~^ ~}"
            (mapcar (lambda (word)
                      (cond
                        ((member (last-elt word) +syntactic-punctuation+)
                         (concatenate 'string
                                      (subseq word 0 (1- (length word)))
                                      " " (vector (last-elt word))))
                        ((equal #(#\newline) word) (values))
                        (t word))) 
                    words))))

(defun converse/hear-statement (phrase)
  (cond
    ((and (= 2 (length phrase))
          (equalp (second (second phrase)) :|.|))
     (cond
       ((equalp '("bye" :vb) (car phrase))
        (throw 'conversation-over :bye))
       ((equalp '("hello" :uh) (car phrase)) '(#\;
                                               (nil "hello" nil)
                                               (("/c/en/i" :/r/-has-a "/c/en/name")
                                                :/r/-is-a
                                                "Catullus")))
       (t '("i" (nil "not" "understand") phrase))))))

(defun converse-eval (string)
  (cond
    ((and (<= 1 (length string))
          (char= #\? (elt string 0))) (converse-repl-help))
    ((> 2 (length string))
     (format t "‽~%")
     (return-from converse-eval nil))
    ((char= #\; (elt string 0)) nil)
    (t (let* ((string (clean-up-string string))
              (tagged (string-trim +whitespace+ (langutils:tag string)))
              (haggard (tagged-to-haggard tagged)))
         (format *trace-output*
                 "~&~
 trace)string) ~A
 trace)tagged) ~A
 trace)haggard) “~{~a~^ ~}”
~%~%"
                 
                 string tagged (mapcar #'describe-tags haggard))
         (if (equal "?" (caar (last haggard)))
             (converse/answer-question string tagged haggard)
             (converse/hear-statement haggard))))))

(defun converse-repl ()
  (init)
  (catch
      'conversation-over
    (tagbody
     converse-repl
       (restart-case 
           (block 
               repl
             (format t "~|~&~% Conversation REPL; Gaius Valerius Catullus~%~%")
             (let ((*last-reply*))
               (loop
                  (converse-dump
                   (converse-eval
                    (converse-read))))))
         (continue-repl ()
           :report "Continue the conversation"
           (go converse-repl))))))

;;; ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––

(defvar *kb*)

(defgeneric reckon (assertion &key source trust superposition))

(defgeneric asserted (source mechanism thing))
(defmethod asserted (source (mechanism (eql :heard)) (statement string))
  (asserted source mechanism (string-to-sentence statement)))
(defmethod asserted (source (mechanism (eql :superposition))
                     (superposition cons))
  (dolist (assertion superposition)
    (reckon assertion :source source :superposition superposition)))
(defmethod asserted (source (mechanism (eql :haggard)) (haggard cons))
  (break))

;;; ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––


;;; ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––

(defvar *initialized* nil)

(define-constant +conceptnet5-download-root+ "http://conceptnet5.media.mit.edu/downloads/current/"
  :test #'string-equal
  :documentation "The URI under which the ConceptNet5 files can be downloaded.")

(defun download-current-conceptnet5-files (wildcard)
  (let ((download-to  (make-pathname :directory (pathname-directory wildcard))))
    (format *trace-output* "~& Going to try to download ConceptNet5~% from ~a~% to ~a"
            +conceptnet5-download-root+ download-to)
    (let* ((index (progn
                    (format *trace-output* "~&Looking for latest version of ConceptNet5 …")
                    (drakma:http-request +conceptnet5-download-root+)))
           (ref-uri (concatenate 'string +conceptnet5-download-root+
                                 (multiple-value-bind (begin end beginnings endings)
                                     (scan "<a href=\"(conceptnet5_flat_csv_[\\d\\.]+\\.tar\\.bz2)\""
                                           index)
                                   (declare (ignore begin end))
                                   (assert (and (vectorp beginnings)
                                                (plusp (length beginnings))) ()
                                                "Looking for <a href=\"(conceptnet5_flat_csv_[\\d\\.]+\\.tar\\.bz2)\" at ~a, but did not find it"
                                                +conceptnet5-download-root+)
                                   (subseq index (elt beginnings 0) (elt endings 0)))))
           (tar-bz2 (progn (format *trace-output* " Downloading ~a … (This will be several 100's of MiB, so it could take a moment) " ref-uri)
                           (drakma:http-request ref-uri))))
      (format *trace-output* " Decompressing and expanding tarball …")
      (uiop/stream:with-temporary-file (:pathname temp-file
                                                  :prefix "tmp.download.ConceptNet5.db.csv"
                                                  :suffix "" :type ".tar.bz2"
                                                  :directory download-to)

        (with-output-to-file (temp-stream temp-file :if-exists :supersede :element-type '(unsigned-byte 8))
          (map nil (rcurry #'write-byte temp-stream) tar-bz2))
        (uiop:run-program (format nil "cd '~a'; tar -xjvf '~a'" download-to temp-file)
                          :input nil :output *trace-output* :error-output *trace-output*))
      (dolist (csv-file (directory (merge-pathnames (make-pathname :directory '(:relative "data" "assertions")
                                                                   :name :wild :type "csv")
                                                    download-to)))
        (rename-file csv-file (make-pathname :directory (pathname-directory download-to)
                                             :name (pathname-name csv-file)
                                             :type "csv"))))))

(defun ensure-conceptnet5-db-unzipped (wildcard)
  (unless (plusp (length (directory wildcard)))
    (format *trace-output* "~&CSV “database” not present; ")
    (let ((bz2s (directory (make-pathname
                            :directory (pathname-directory wildcard)
                            :name :wild :type "csv.bz2"))))
      (cond ((plusp (length bz2s))
             (format *trace-output* " … found BZip2 compressed copy; decompressing:~%")
             (dolist (bz2 bz2s)
               (uiop:run-program (format nil "bzip -d '~a'" bz2) :output *trace-output* :error-output *trace-output* :input nil))
             (format *trace-output* " … done."))
            (:otherwise (format *trace-output* " … and BZip2 compressed copies also not found.")))))
  (unless (plusp (length (directory wildcard)))
    (download-current-conceptnet5-files wildcard)))

(defun load-conceptnet5-csv-database
    (&optional
       (wildcard (merge-pathnames (make-pathname :directory '(:relative "conceptnet5-csv" "assertions")
                                                 :name :wild
                                                 :type "csv")
                                  ROMANS-COMPILER-SETUP:*PATH/R2SRC*)))
  (ensure-conceptnet5-db-unzipped wildcard)
  (unless (plusp (length (directory wildcard)))
    (error "Cannot find ConceptNet5 CSV “database” files; cannot proceed."))
  (format *trace-output* "~&~%Loading ConceptNet5 dataset from ~S" wildcard)
  (in-db (:transaction nil)
    (time (conceptnet5-read-files wildcard)))
  (format *trace-output*
          "~&~%Almost done, loaded ConceptNet5; ~:D interned token~:P, ~:D assertion~:P in DB, ~:D assertion~:P pending"
          (db-execute-single "SELECT COUNT(*) FROM atoms")
          (db-execute-single "SELECT COUNT(*) FROM concepts")
          (length *new-inserts*))
  (time (while (< 2 (length *new-inserts*))
          (format *trace-output*
                  "~&~%Still need to flush ~:d assertions to DB…" (length *new-inserts*))
          (flush-to-db)))
  (push :conceptnet5 *initialized*))

(defun load-langutils (&optional
                         (langutils-dir (asdf:system-relative-pathname
                                         :langutils ".")))
  (let ((*default-pathname-defaults* langutils-dir))
    (langutils:init-langutils))
  (push :langutils *initialized*))

(defun init ()
  (unless (member :conceptnet5 *initialized*)
    (handler-bind
        ((file-error 
          (lambda (c)
            (declare (ignore c))
            (load-conceptnet5-csv-database))))
      (connect-concepts-db)))
  (unless (member :langutils *initialized*)
    (load-langutils)))

;;; ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––

(defvar *word-features* (make-hash-table :test 'equal))

(defun ensure-hash-value-member (hash-table key value-member)
  (unless (member value-member
                  (let ((orig (gethash key hash-table)))
                    (if (consp orig) orig
                        (setf (gethash key hash-table) nil))))
    (appendf (gethash key hash-table) value-member)))

(defun learn-word-feature (word word-feature)
  (ensure-hash-value-member *word-features* word word-feature))

(defun find-word-features (word)
  (cons word (gethash word *word-features*)))

(defun break-down-sentence (sentence)
  ;; TODO, punctuation
  (split-sequence:split-sequence #\Space sentence))



;;; ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––

(in-package :catullus)

(defgeneric lex-sentence (sentence language)
  (:documentation "Lex a sentence into words."))

(define-constant +english-word-symbols+
    '(#\& "and"
      #\# (or ("pound" :unit-of-weight (or :singular :plural))
           ("number" :ordinal-marker :precedes-value)
           ((:phrase "count" "each") :cardinal-marker :succeeds-value))
      #\$ ((or "dollar" "Peso") :currency (or :singular :plural) :precedes-value)
      #\@ "at"
      #\£ ("pound" :currency :precedes-value)
      #\€ ("Euro" :currency :precedes-value)
      #\¬ :not
      #\∈ (or (:phrase "element" "of") (:phrase ("is" (or :singular :plural)) "element" "of"))
      #\∋ (:phrase ("contain" (or :singular :plural)) "as" ("element" (or :singular :plural)))
      #\∀ (:phrase "for" (or "all" "every"))
      #\∞ :infinity
      #\☿ "Mercury"
      #\♀ (or "Venus" "female")
      #\⊕ "Earth"
      #\♂ (or "Mars" "male")
      #\♃ "Jupiter"
      #\♄ "Saturn"
      #\♅ "Uranus"
      #\♆ "Neptune"
      #\🌙 (or "moon" "night")
      #\☉ (or "Sun" "center" "day")
      #\★ "star"
      #\* (or "asterisk" "footnote" "star" (:phrase "multiply" "by"))
      #\× (or "times" (:phrase "multiply" "by"))
      #\+ "plus"
      #\✝ (or "Cross" "Christian" "crucifix")
      #\☠ (or "poison" (:phrase "skull" "and" "cross-bones") (:phrase "computer" "programmer")
           (:phrase "Admiral" "Grace" "Hopper"))
      #\= ("equal" (or :singular :plural) (or "to"))
      #\≈ (:phrase "approximately" ("equal" (or :singular :plural)) (or "to"))
      #\≠ (:phrase "not" ("equal" (or :singular :plural)) (or "to"))
      #\¢ ("cent" :currency (or :singular :plural))
      #\§ "section"
      #\¶ (or "pi" "paragraph")
      #\♥ (or ("heart" :noun) ("love" (or :noun :verb)) ("loves" :verb))
      #\© "copyright"
      #\® (:phrase "registered" "trademark")
      #\™ "trademark"
      #\% "percent"
      #\‰ "per-mille"
      #\√ (:phrase "square" "root" "of")
      #\✓ (or "check" "yes")
      #\∴ "therefore"
      #\∵ "because")
  :test 'equal)

;; Note, due to ambiguities, neither - nor ' should be on this list
;; (although dashes and a single closing quotation mark are)
(define-constant +word-terminating-punctuation+
    '(#\, #\. #\! #\? #\" #\” #\– #\— #\) #\‽ #\’ #\/ #\» #\; #\:)
  :test 'equal)

;; Note, due to ambiguities, neither - nor ' should be on this list,
;; nor " (although dashes and actual quotes are)
(define-constant +syntactic-punctuation+
    '(#\, #\. #\! #\? #\“ #\” #\– #\— #\( #\) #\‘ #\’ #\« #\» #\/ #\‽
      #\¿ #\¡ #\; #\:)
  :test 'equal)

(defmethod lex-sentence (sentence (language (eql :en)))
  (let ((word-start nil)
        (words nil)
        (the-end (1- (length sentence)))
        (whitespacep   (cl-unicode:property-test "WhiteSpace"))
        (letterp       (cl-unicode:property-test "Letter"))
        (numberp       (cl-unicode:property-test "Number"))
        (latinp        (cl-unicode:property-test "Latin")))
    (macrolet ((collect-literal (word)
                 `(setf words (append words (list ,word))))
               (collect-word ()
                 `(progn (when word-start
                           (setf words (append words (list (subseq sentence word-start i)))))
                         (setf word-start nil)))
               (word-end (&optional (distance 0))
                 `(or (= the-end (+ i -1 ,distance))
                      (funcall whitespacep (elt sentence (+ i ,distance)))
                      (member (elt sentence (+ i ,distance)) +word-terminating-punctuation+)
                      (member (elt sentence (+ i ,distance)) +english-word-symbols+))))
      (loop
         for i from 0 upto the-end
         for char = (elt sentence i)
         ;; do (format t "~&~%Parse: ~S~%Input: ~A~%~VT⤒~%" words sentence (+ 7 i))
         when (word-end) do (collect-word)
         do (cond

              ;; are we able to start reading a new word?
              ((and (null word-start)
                    (funcall latinp char)
                    (funcall letterp char)) (setf word-start i))

              ;; continuing within a word?
              ((and word-start
                    (or (char= char #\-)
                        (and (funcall latinp char)
                             (funcall letterp char)))) nil)

              ;; whitespace?
              ((funcall whitespacep char) nil)

              ;; numbers suck, let's scan ahead and find the end
              ;; of them.
              ((funcall numberp char)
               (collect-literal (read-from-string
                                 (coerce (loop
                                            for j from i
                                            for ch = (elt sentence j)
                                            unless (char= ch #\,)
                                            when (or (funcall numberp ch)
                                                     (char= ch #\.)
                                                     (char= ch #\/))
                                            collect ch
                                            else do (setf i j) and do (loop-finish))
                                         'string))))

              ;; punctuation which is syntactically meaningful — these
              ;; are effectively the same thing as words, for the
              ;; purposes of the lexer.
              ((member char +syntactic-punctuation+) (collect-literal (string char)))

              ;; word-like symbols.
              ((getf +english-word-symbols+ char)
               (collect-literal (getf +english-word-symbols+ char)))

              ;; naked - or -- are translated to a dash
              ((and (char= #\- char)
                    (and (word-end 2)
                         (char= #\- (elt sentence (1+ i))))) (collect-literal "–") (incf i))
              ((and (char= #\- char) (word-end 1)) (collect-literal "–"))

              ;; users type ' for ‘’ and we need to detect it. Gross.
              ((and (null word-start)
                    (not (word-end 1))
                    (char= #\' char))
               (collect-literal (or #\‘ #\’)))

              ;; a " might be either “”
              ((char= #\" char)
               (collect-literal (or #\“ #\”)))

              ;; Apostrophes are evil. Let's begin to examine just how evil, here.
              ((and word-start
                    (char= #\' char))

               (cond

                 ;; word ending "in'" actually end "ing"
                 ((and (word-end 1)
                       (> i (+ 2 word-start))
                       (char= #\n (elt sentence (- i 1)))
                       (char= #\i (elt sentence (- i 2))))
                  (collect-literal (concatenate 'string (subseq sentence word-start i)
                                                "g"))
                  (setf word-start nil))

                 ;; a trailing ' with a preceding s is a
                 ;; plural-possessive; or, it could be an attempt at a
                 ;; ’ (closing quote)
                 ((and (word-end 1)
                       (char= #\s (elt sentence (1- i))))
                  (collect-literal (list (subseq sentence word-start i)
                                         :plural))
                  (setf word-start nil)
                  (collect-literal (or :possessive-s #\’)))

                 ;; other trailing ' are probably a ’
                 ((word-end 1)
                  (collect-word)
                  (collect-literal #\’))

                 ;; 's is pernicious and difficult to decide the meaning-of.
                 ;; It might be a contraction, or a possessive particle.
                 ((and (< (1+ i) the-end)
                       (char= #\s (elt sentence (1+ i)))
                       (word-end 2))
                  (let ((so-far (subseq sentence word-start i)))
                    (cond
                      ;; pronouns of all sorts can only be has or is
                      ((member so-far '("he" "she" "it"
                                        "how" "what" "who" "when" "where"
                                        "there" "this" "that") :test #'string=)
                       (collect-word)
                       (collect-literal '(or "has" "is"))
                       (incf i))
                      ;; let's
                      ((string= so-far "let")
                       (collect-word)
                       (collect-literal "us")
                       (incf i))
                      ;; so's can be "so as" or "so is"
                      ((string= so-far "so")
                       (collect-word)
                       (collect-literal '(or "as" "is"))
                       (incf i))
                      ;; and for (almost) any other word, this can be:
                      ;; (n)'s (possessive), or (n) is, or (n) has
                      ;; technically, (n) must be a noun.
                      (t
                       (collect-word)   ; technically: must be a noun.
                       (collect-literal '(or :possessive-s "is" "has"))))))

                 ;; I'm
                 ((and (< (1+ i) the-end)
                       (= word-start (1- i))
                       (word-end 2)
                       (char= #\I (elt sentence (1- i)))
                       (char= #\m (elt sentence (1+ i))))
                  (collect-literal '("I" :first-person :singular :pronoun))
                  (collect-literal "am")
                  (incf i)
                  (setf word-start nil))

                 ;; 'd
                 ((and (< (1+ i) the-end)
                       (char= #\d (elt sentence (1+ i)))
                       (word-end 2))
                  (collect-word)
                  (collect-literal '(or "had" "would"))
                  (incf i))

                 ;; n't
                 ((and (< (1+ i) the-end)
                       (char= #\n (elt sentence (1- i)))
                       (char= #\t (elt sentence (1+ i)))
                       (word-end 2))
                  (let ((so-far (subseq sentence word-start (1- i))))
                    (cond
                      ((string= so-far "ai") (collect-literal '(or "am" "are" "is" "has" "have")))
                      ((string= so-far "are") (collect-literal '(or "am" "are")))
                      ((string= so-far "wo") (collect-literal "will"))
                      (t (collect-literal so-far))))
                  (collect-literal "not")
                  (setf word-start nil)
                  (incf i 2))

                 ;; 're
                 ((and (< (+ 2 i) the-end)
                       (char= #\r (elt sentence (1+ i)))
                       (char= #\e (elt sentence (+ 2 i)))
                       (word-end 3))
                  (collect-word)
                  (collect-literal "are")
                  (incf i 3))

                 ;; 've
                 ((and (< (+ 2 i) the-end)
                       (char= #\v (elt sentence (1+ i)))
                       (char= #\e (elt sentence (+ 2 i)))
                       (word-end 3))
                  (collect-word)
                  (collect-literal "have")
                  (incf i 3))

                 ;; 'll
                 ((and (< (+ 2 i) the-end)
                       (char= #\l
                              (elt sentence (+ 1 i))
                              (elt sentence (+ 2 i)))
                       (word-end 3))
                  (collect-word)
                  (collect-literal '(or "shall" "will"))
                  (incf i 3))

                 ;; in all other cases, assume it's a letterlike
                 ;; symbol. keep reading the word.
                 (t nil)))

              (t (cerror "Ignore and continue"
                         "Unhandled symbol in input stream: ~S in:~%~A ★~A★ ~A"
                         char (subseq sentence 0 i)
                         char (subseq sentence (1+ i))))))
      (when word-start (collect-literal (subseq sentence word-start))))
    words))

(defgeneric potential-parts-of-speech (word language))

(define-constant
    +english-core-words+
    '(:the  (:article :definite)
      :a     ((or (:noun :letter) (:article :indefinite :should-not-precede-vowel)))
      :an    ((or (:if :archaic) (:article :indefinite :must-precede-vowel)))
      :no    ((or (:article :negative) :determinant :negation))
      :this  ((or :determinant (:pronoun :impersonal)))
      :am    ((or (:verb :1person :singular :copula :present :active :indicative)
               (:assist-verb :1person :singular :present :active)))
      :is    ((or (:verb :3person :singular :copula :present :active :indicative)
               (:assist-verb :3person :singular :present :active)))
      :are   ((or (:verb (or :1person :3person) :plural :copula :present :active :indicative)
               (:verb :2person (or :singular :plural) :copula :active)
               (:assist-verb (or (:2person (or :singular :plural))
                                 ((or :1person :3person) :plural)) :present :active)))
      :be    ((or (:verb :present :participle)
               (:verb :1person :subjunctive)))
      :were  ((or (:verb (or :2person :3person) :subjunctive)
               (:verb :2person :active :indicative :past))))
  :test #'equalp)

(define-constant +punctuation+
    '(#\. (:punctuation :sentence-terminal :statement)
      #\, (or (:punctuation :list-separator)
           (:punctuation :vocative-separator)
           (:punctuation :phrase-disambiguator)
           (:punctuation :in-quotes-final-sentence-full-stop))
      #\en_dash (or (:punctuation :vocative-separator)
                 (:punctuation :annominative-separator)
                 (:punctuation :phrase-disambiguator))
      #\em_dash (or (:punctuation :vocative-separator)
                 (:punctuation :annominative-separator)
                 (:punctuation :phrase-disambiguator))
      #\; (or (:punctuation :clause-splitting)
           (:punctuation :list-separator-superior))
      #\: (or (:punctuation :vocative-separator)
           (:punctuation :phrase-spliting))
      #\! (:punctuation :sentence-terminal :exclamation)
      #\? (:punctuation :sentence-terminal :interrogative)
      #\‽ (:punctuation :sentence-terminal :exclamation :interrogative)
      #\/ (:stroke)
      #\" (:error))
  :test #'equalp)

(define-constant +paired-punctuation+
    '((#\( #\)) (:parenthetical)
      (#\“ #\”) (:quotation)
      (#\‘ #\’) (:quotation)
      (#\« #\») (:quotation)
      (#\¿ #\?) (:interrogative)
      (#\¡ #\!) (:exclamation))
  :test #'equalp)

(defun forgotten-punctuation (set)
  (remove-if (lambda (char)
               (getf +punctuation+ char))
             (remove-if (lambda (char)
                          (find-if (lambda (el)
                                     (member char el))
                                   +paired-punctuation+))
                        set)))

(defmethod potential-parts-of-speech (word (language (eql :en)))
  (cond
    ((keywordp word) '(:particle))
    ((and (consp word) (keywordp (car word))) word)
    ((and (stringp word) (= 1 (length word)))
     (let ((char (elt word 0)))
       (if-let ((interp (getf +punctuation+ char)))
         interp
         (if-let ((start (find-if (lambda (el)
                                    (eql (car el) char)) +paired-punctuation+)))
           :punctuation-start-pair
           :mystery))))
    ((or-list-p word)
     (cons (car word)
           (mapcar (lambda (maybe) (potential-parts-of-speech maybe :en))
                   (cdr word))))
    (t (or (and (stringp word)
                (getf +english-core-words+ (intern (string-upcase word) :keyword)))
           (let ((matches (loop for pos in (wordnet:parts-of-speech)
                             when (wordnet:cached-index-lookup word pos) collect pos)))
             (case (length matches)
               (0 :mystery)
               (1 (car matches))
               (otherwise (cons 'or matches))))))))

(defgeneric tag-sentence (sentence language))

(defmethod tag-sentence (sentence (language (eql :en)))
  (cond ((or-list-p sentence)
         (cons (car sentence)
               (mapcar (rcurry #'tag-sentence :en) (cdr sentence))))
        ((any-or sentence)
         (tag-sentence (superpose-or sentence) :en))
        (t (superpose-or
            (loop for word in sentence
               for parts = (potential-parts-of-speech word :en)
               collect
                 (cond
                   ((null parts) :unknown)
                   ((or-list-p parts) (list word parts))
                   ((consp parts) (cons word parts))
                   (t (list word parts))))))))

(defun strictly-antonym-p (a b)
  (warn "Strictly antonyms? ~a and ~a?" a b)
  nil)                                  ; TODO

(defun strictly-synonym-p (a b)
  (warn "Strictly synonyms? ~a and ~a?" a b)
  nil)                                  ; TODO

(defun opposite-p (a b)
  (or (equalp a (list 'not b))
      (equalp b (list 'not a))
      (and (consp a)
           (eql (car a) 'not)
           (strictly-synonym-p (cdr a) b))
      (and (consp b)
           (eql (car b) 'not)
           (strictly-synonym-p (cdr b) a))
      (strictly-antonym-p a b)))

(defun any-opposites (list)
  (cond
    ((null list) nil)
    ((atom list) nil)
    ((endp list) nil)
    (t (let ((one (first list))
             (others (rest list)))
         (or (find-if (curry #'opposite-p one) others)
             (funcall #'any-opposites others))))))

(defun collapse (phrase)
  (cond
    ((atom phrase) phrase)
    ((null phrase) nil) 

    ((and (member (first phrase) '(and or))
          (not (equalp phrase (remove-duplicates phrase :test #'equalp))))
     (collapse (remove-duplicates phrase :test #'equalp)))
    
    ((and (member (first phrase) '(and or))
          (= 2 (length phrase)))
     (second phrase))
    
    ((and-list-p phrase)
     (cond 
       ((member t phrase)
        (collapse (remove t phrase :test #'eql)))
       ((member nil phrase)
        nil)
       ((any-opposites (rest phrase))
        nil)
       (t (error "TODO"))))
    ((or-list-p phrase)
     (cond
       ((member nil phrase)
        (collapse (remove nil phrase :test #'eql)))
       ((member t phrase)
        t)
       ((any-opposites (rest phrase))
        t)
       (t (error "TODO"))))

    (t (error "TODO"))))

(defun tagged-to-string (word)
  (cond
    ((or-list-p word)
     (format nil "[~{~A~^, or ~}]" (mapcar #'tagged-to-string (cdr word))))
    ((or-list-p (cdr word))
     (format nil "~A (~(~{~A~^, ~_or ~}~))" (car word) (cddr word)))
    (t (format nil "~A (~(~{~A~^, ~_~}~))" (car word) (cdr word)))))

(defun print-tagged (sentence &optional (stream t))
  (if (or-list-p sentence)
      (format stream"~&~{~A~^~&or: ~}"
              (mapcar (lambda (alt) (print-tagged alt nil))
                      (cdr sentence)))
      (format stream"~&~{~A~^ ~_~}"
              (mapcar #'tagged-to-string
                      sentence))))

(defun or-list-p (thing)
  (and (consp thing) (eql 'or (car thing))))

(defun and-list-p (thing)
  (and (consp thing) (eql 'and (car thing))))

(defun list-before (list index)
  (check-type list cons)
  (check-type index (integer 0 *))
  (if (plusp index) (subseq list 0 index) (values)))

(defun any-or (list)
  (and (consp list)
       (or (or-list-p list)
           (any #'any-or list))))

(defun superpose-or/immediate (phrase)
  (logic-trace "~&Superposition (immediate) of the logical OR assertion:~%~A" (treely phrase))
  (let ((members (remove-duplicates (cdr phrase) :test #'equalp)))
    (if (null (cdr members))
        (car members)
        (cons (car phrase) members))))

(defun inject-into-list (list pos inject)
  (check-type list cons)
  (check-type pos (integer 0 *))
  (assert (not (null inject)))
  (flet ((lastp (n) (= n (length list))))
    (typecase inject
      (atom (let ((copy (copy-list list)))
              (setf (nth pos copy) inject)
              copy))
      (cons (cond
              ((zerop pos)
               (append inject (subseq list (1+ pos))))
              ((lastp pos)
               (append (subseq list 0 pos) inject))
              (t (append (subseq list 0 pos)
                         inject
                         (subseq list (1+ pos)))))))))

(defun superpose-or/next-depth (phrase)
  (logic-trace "~&Lifting a nested OR assertion from a lower level:~%~A" (treely phrase))
  (cons (car phrase)
        (mapcan (lambda (part)
                  (if (or-list-p part)
                      (cdr part)
                      (list part))) (cdr phrase))))

(defun superpose-or/cross-product (phrase)
  (logic-trace "~&Going to perform a cross-product on:~%~A" (treely phrase))
  (let ((pos (position 'or phrase :key #'car?)))
    (if pos
        (progn (logic-trace "~&Found the OR list at index ~:D" pos)
               (let ((alternatives (cdr (elt phrase pos))))
                 (logic-trace "~&Creating the cross-product with these alternatives:~{~% •~A~}" alternatives)
                 (let ((cross (cons 'or (mapcar (curry #'inject-into-list phrase pos) alternatives))))
                   (if (any-or (cdr cross))
                       (progn (logic-trace "~&Initial cross-product yields:~%~A
This contains further OR lists which can be superposed."
                                           cross)
                              (superpose-or cross))
                       cross))))
        (error "No subordinate OR lists found."))))

(defun car? (x)
  (and (consp x) (car x)))

(defvar *superpose-or/recursion-guard* nil)

(defun superpose-or (phrase)
  "If a phrase contains any expressions of the form (OR x …), this
function will create top-level superpositions, such as:

 • Nested OR expressions will be lifted to create a single top-level
   OR expression that is a cross-product of all nested expressions;
 • Any WRITEME

⁂See TEST-PARSER for not-really-docs in the form of tests
"
  (logic-trace "~&Superpostition of any OR expressions in:~&~A" (treely phrase))

  (let ((*superpose-or/recursion-guard* (or (and *superpose-or/recursion-guard*
                                                 (1- *superpose-or/recursion-guard*))
                                            (progn
                                              (logic-trace "~&Not recursive yet; initializing recursion guard to 10")
                                              10))))
    (logic-trace "~&(Recursion guard is currently set to allow ~R further level~:P)" *superpose-or/recursion-guard*)
    (unless (plusp *superpose-or/recursion-guard*)
      (break "Recursion guard stricken; you probably need to abort."))
    (cond
      ((atom phrase) phrase)
      ((null phrase) nil)
                                        ;     ✗ ((null (cdr phrase)) (list (superpose-or (car phrase))))

      ;; No alternatives: (OR x) ⇒ x
      ((and (or-list-p phrase)
            (null (cdr (cdr phrase))))
       (logic-trace "~&A choice of only one alternative is no choice at all. Reducing to ~a" 
                    (treely (second phrase)))
       (second phrase))

      ((and (or-list-p phrase)
            (let ((without-duplicates (remove-duplicates phrase :test #'equalp)))
              (not (equalp phrase without-duplicates))))
       (let ((without-duplicates (remove-duplicates phrase :test #'equalp)))
         (logic-trace "~&The phrase contained duplicate members; after reducing them, the revised phrase is:~&~A" 
                      (treely without-duplicates))
         (superpose-or without-duplicates)))

      ;; (OR x (OR y z)) ⇒ (OR x y z)
      ;;
      ;; (sort of associative property)
      ((and (or-list-p phrase)
            (any #'or-list-p (cdr phrase))) (superpose-or (superpose-or/next-depth phrase)))

      ;; (x (OR y z)) ⇒ (OR (x y) (x z))
      ;;
      ;; (simplify as a cross-“product”)
      ((any #'or-list-p (cdr phrase)) (superpose-or (superpose-or/cross-product phrase)))

      ;; nested OR is farther down; need to elevate or eliminate it at
      ;; that lower level.
      ((any-or (rest phrase)) (logic-trace "~& There's an OR phrase in there, but it's buried.
I'm going to try to dig it out to the top level.")
       (superpose-or (mapcar #'superpose-or phrase)))

      ;; any other simplifications possible should occur here
      ((or-list-p phrase) (superpose-or/immediate phrase))

      ;; whatever's left is untouchable here
      (t phrase))))

(defun identify-main-verb (tagged-sentence)
  (cons 'or
        (loop for word in tagged-sentence
           for i from 0
           when (member :verb (cdr word))
           collect (inject-into-list tagged-sentence i (append word :main)))))

(defgeneric parse-structure (clause language context antecedents))

#+ (or) ; this one might be better
(defun any-cdr (needle haystacks)
  (reduce #'or (mapcar (curry #'member needle) (mapcar #'cdr haystacks))))

(defun any-cdr (needle haystacks)
  (loop for stack in (mapcar #'cdr haystacks)
     when (member needle stack)
     return t))

(defun assist-verb (clause language verb i &optional (direction :interrogative))
  (declare (ignorable clause language verb i direction))
  (break "I don't handle ASSIST-VERB yet")
  #+ (or)  (loop for word from 0 to i
              when t return nil))

(defun find-subordinated-clauses (clause)
  (loop for word in clause
     when (equal (second word) :subordinating-clause-marker)
     do (break "I don't actually handle subordinated clauses yet; found ~S in ~S" word clause))
  clause)

(defmethod parse-structure (clause (language (eql :en))
                            (context (eql :sentence)) antecedents)
  (let ((clause (find-subordinated-clauses clause)))
    (cond ((any-cdr :interrogative clause)
           (when (and (any-cdr :assist-verb clause)
                      (any-cdr :verb clause))
             (loop for verb in clause
                for i from 0
                when (eql (second verb) :assist-verb)
                do (assist-verb clause language verb i :interrogative))))
          (t (error "Interrogative only")))))

(defvar *interactive-test* t)
(defvar *tests-pass* 0)
(defvar *tests-fail* 0)

(defmacro itest (expr vars &rest report)
  (declare (ignore vars))
  `(cond
     (*interactive-test* (format *terminal-io* "~& ★ Test: ~%")
                         (format *terminal-io* ,@report)
                         (format *terminal-io* "~&~% Test expression: ~%~S" ',expr)
                         (if (or t (y-or-n-p "Run this test?"))
                             (let ((out ,expr))
                               (cond
                                 (out (incf *tests-pass*)
                                      (format *terminal-io* "~& ✓ Test PASSED ⇒ ~S" out))
                                 (:otherwise (incf *tests-fail*)
                                             (format *terminal-io* "~& ✗ Test FAILED")
                                             (break " ✗ Test FAILED ~%~S~%~%~A" ',expr (format nil ,@report)))))
                             (format *terminal-io* "~& ⁂ Test SKIPPED")))
     (,expr (incf *tests-pass*))
     (:otherwise (incf *tests-fail*)
                 (break " ✗ Test FAILED ~%~S~%~%~A" ',expr (format nil ,@report)))))

(defun test-parser ()
  (format t "~&Testing parser components; any failure should signal an error.")
  (when *interactive-test*
    (format t "~&Testing parser components (interactively)"))
  (setf *tests-pass* 0 *tests-fail* 0)
  (itest (null (forgotten-punctuation +syntactic-punctuation+))
         ()
         "Forgotten punctuation: ~S
All punctuation in +SYNTACTIC-PUNCTUATION+
must be defined in +PUNCTUATION+ or +PAIRED-PUNCTUATION+"
         (forgotten-punctuation +syntactic-punctuation+))
  (itest (null (forgotten-punctuation +word-terminating-punctuation+))
         ()
         "Forgotten punctuation: ~S
All punctuation in +WORD-TERMINATING-PUNCTUATION+
must be defined in +PUNCTUATION+ or +PAIRED-PUNCTUATION+"
         (forgotten-punctuation +word-terminating-punctuation+))
  (fresh-line)
  (itest (equalp (superpose-or '(or a (or b c)))
                 '(or a b c))
         () "A list containing nested OR expressions must reduce to a single list.")
  (itest (equalp (inject-into-list '(thing (or (1 2) (3 4))) 1 '(1 2))
                 '(thing 1 2))
         () "Replacing a sublist with a new list must work at the end.")
  (itest (equalp (inject-into-list '(a b c) 0 '(1 2 3))
                 '(1 2 3 b c))
         () "Relpacing a sub-list with a new list must work at the beginning.")
  (itest (equalp (superpose-or '(thing (or 1 2)))
                 '(or (thing 1) (thing 2)))
         () "A buried OR expression must be lifted to the highest level.")
  (itest (equalp (superpose-or '(thing (or (:one 1) (:two 2))))
                 '(or (thing :one 1) (thing :two 2)))
         () "A buried OR expression must be lifted to the highest level.")
  (itest (equalp (superpose-or '(thing (:one (or (1 2) (3 4)))))
                 '(or (thing :one 1 2) (thing :one 3 4)))
         () "A buried OR expression must be lifted to the highest level.")
  (itest (equalp (superpose-or '(or it))
                 'it)
         () "An OR expression with only one alternative must be simplified to a constant.")
  (itest (equalp (superpose-or '(or it it it))
                 'it)
         () "An OR expression with only one alternative (even if
         re-expressed more than once) must be simplified to
         a constant.")
  (itest (equalp (superpose-or '(or (1 2 3 4) (1 (or 2 2) (or 3 3) (or 4))))
                 '(1 2 3 4))
         () "An OR expression which reduces to anly one alternative
          must be simplified to a constant after all nested OR
          expressions have likewise been normalized.")
  (itest (equalp (superpose-or '("thing" (or :one :two)))
                 '(or ("thing" :one) ("thing" :two)))
         () "An OR expression being lifted must deal with any type of
          nested sequence (including a string or array) as well as
          atoms or constructed cells.")
  (itest (equalp (superpose-or '("thing" (or (:one 1) (:two 2))))
                 '(or ("thing" :one 1) ("thing" :two 2)))
         () "An OR expression being lifted must deal with any type of
          nested sequence (including a string or array) as well as
          atoms or constructed cells.")
  (itest (equalp (inject-into-list '(dog (or :noun :verb)) 1 :noun)
                 '(dog :noun))
         nil "Burgeoning should replace element 1 of a 2-part list")
  (itest (equalp (inject-into-list '((or cat dog) :pet) 0 'cat)
                 '(cat :pet))
         nil "Burgeoning should replace element 0 of a 2-part list")
  (itest (equalp (inject-into-list '(dog :being (or :noun :verb)) 2 :noun)
                 '(dog :being :noun))
         nil "Burgeoning should replace element 2 of a 3-part list")
  (itest (equalp (inject-into-list '((or :noun :verb)) 0 :noun)
                 '(:noun))
         nil "Burgeoning should replace element 0 of a 1-part list")
  (itest (equalp (collapse '(and a (not a)))
                 nil)
         nil "An assertion to be A ∧ ¬A must reduce to NIL")
  (itest (equalp (collapse '(and a a))
                 'a)
         nil "A repeated AND assertion must reduce to a constant.")
  (itest (equalp (collapse '(or a (not a)))
                 t)
         nil "An assertion of A ∨ ¬A must reduce to T")
  (itest (equalp (collapse '(and t nil))
                 nil)
         nil "An assertion of truth and falsity must reduce to false.")
  (itest (equalp (collapse '(or t nil))
                 t)
         nil "An assertion of truth or falsity must reduce to truth.")
  (itest (equalp (collapse '(or nil b)) 'b)
         nil "An assertion of OR with only one true value reduces to
                  that value.")
  (itest (equalp (collapse '(and (or t nil) nil))
                 nil)
         nil "( ( T ∨ NIL ) ∧ NIL ) ⇒ NIL")
  (cerror "Good, keep going" "Passed all the simplest tests")
  (let ((sentence "Why is the cat purple?"))
    (print sentence)
    (fresh-line)
    (princ "Lex:")
    (let ((lexed (lex-sentence sentence :en)))
      (itest (equalp lexed
                     '("Why" "is" "the" "cat" "purple" "?"))
             nil "Lexing this sentence should yield the given result")
      (print lexed)
      (fresh-line)
      (princ "Tag:")
      (let ((tagged (tag-sentence lexed :en))
            (expected '(("Why" :mystery)
                        (or ("is" :verb :3person :singular :copula :present :active :indicative)
                         ("is" :assist-verb :3person :singular :present :active))
                        ("the" :article :definite)
                        (or ("cat" :noun) ("cat" :verb))
                        (or ("purple" :noun) ("purple" :verb) ("purple" :adjective))
                        ("?" :punctuation :sentence-terminal :interrogative))))
        (itest (equalp tagged expected) (tagged expected)
               "Expected to tag ~A~%as: ~A~%but instead got~%~A"
               (treely lexed) (treely expected) (treely tagged))
        (print (treely tagged))
        (fresh-line)
        (princ "Print tagged:")
        (print-tagged tagged)
        (fresh-line)
        (princ "Superpose OR:")
        (let ((tagged-superposition (superpose-or tagged))
              (expected-superposition
               '(OR
                 ((#1="Why" :NOUN)
                  (#2="is" :VERB :3PERSON :SINGULAR :COPULA :PRESENT :ACTIVE :INDICATIVE)
                  (#3="the" :ARTICLE :DEFINITE) (#4="cat" :NOUN) (#5="purple" :NOUN)
                  (#6="?" :PUNCTUATION :SENTENCE-TERMINAL :INTERROGATIVE))
                 ((#1# :NOUN)
                  (#2# :VERB :3PERSON :SINGULAR :COPULA :PRESENT :ACTIVE :INDICATIVE)
                  (#3# :ARTICLE :DEFINITE) (#4# :NOUN) (#5# :VERB)
                  (#6# :PUNCTUATION :SENTENCE-TERMINAL :INTERROGATIVE))
                 ((#1# :NOUN)
                  (#2# :VERB :3PERSON :SINGULAR :COPULA :PRESENT :ACTIVE :INDICATIVE)
                  (#3# :ARTICLE :DEFINITE) (#4# :NOUN) (#5# :ADJECTIVE)
                  (#6# :PUNCTUATION :SENTENCE-TERMINAL :INTERROGATIVE))
                 ((#1# :NOUN)
                  (#2# :VERB :3PERSON :SINGULAR :COPULA :PRESENT :ACTIVE :INDICATIVE)
                  (#3# :ARTICLE :DEFINITE) (#4# :VERB) (#5# :NOUN)
                  (#6# :PUNCTUATION :SENTENCE-TERMINAL :INTERROGATIVE))
                 ((#1# :NOUN)
                  (#2# :VERB :3PERSON :SINGULAR :COPULA :PRESENT :ACTIVE :INDICATIVE)
                  (#3# :ARTICLE :DEFINITE) (#4# :VERB) (#5# :VERB)
                  (#6# :PUNCTUATION :SENTENCE-TERMINAL :INTERROGATIVE))
                 ((#1# :NOUN)
                  (#2# :VERB :3PERSON :SINGULAR :COPULA :PRESENT :ACTIVE :INDICATIVE)
                  (#3# :ARTICLE :DEFINITE) (#4# :VERB) (#5# :ADJECTIVE)
                  (#6# :PUNCTUATION :SENTENCE-TERMINAL :INTERROGATIVE)))))
          (itest (equalp tagged-superposition expected-superposition)
                 (tagged-superposition expected-superposition)
                 "The tagged sentence contains superpositions, which need to be normalized
into a singular top-level superposed sentence (this is a sort of first normal form,
which is a cross product of the interior superpositions). This process should have
returned:
~A

Instead, the following was returned:
~A"
                 (treely expected-superposition) (treely tagged-superposition))
          (print-tagged tagged-superposition)
          (fresh-line)
          (let ((parses
                 (remove-duplicates
                  (remove-if
                   #'null
                   (loop for alt in (cdr tagged-superposition)
                      do (terpri)
                      collect
                        (if-let ((parsed (parse-structure alt :en :sentence nil)))
                          (prog1 parsed
                            (format t "~&~% Parsed sentence structure: ~%~A~%from: ~A"
                                    parsed alt))
                          (prog1 (values)
                            (princ "**Alternative dropped: can't parse")
                            (print-tagged alt))))))))
            (terpri) (terpri)
            (format t "Found ~:D distinct ways to parse:~{~%~S~}"
                    (length parses) parses))))))

  (format *trace-output* "~& Tests completed~%~%Ran ~:D tests~% ✓ ~:D test~:P passed~% ✗ ~:D test~:P failed"
          (+ *tests-pass* *tests-fail*) *tests-pass* *tests-fail*)
  (when (plusp *tests-fail*)
    (format *trace-output* "~& (SETQ CATULLUS::*INTERACTIVE-TESTS* T) for more debugging aids")))

(defun treely (sexp &optional (indent 2) (carp nil))
  (if (consp sexp)
      (format nil "~:[~%~VT~; ~*~](~A ~{~A~^ ~})" carp indent
              (treely (car sexp) (+ 2 indent) t)
              (mapcar (rcurry #'treely (+ 2 indent) nil) (cdr sexp)))
      (format nil "~S" sexp)))






(defun start-server (&optional argv)
  (declare (ignorable argv))
  (romans:server-start-banner "Catullus"
                              "Gaius Valerius Catullus"
                              "Intelligent Agents and Language Server")
  (init)
  (test-parser)
  (format t "~& Conversation REPL starting…")
  (converse-repl))


