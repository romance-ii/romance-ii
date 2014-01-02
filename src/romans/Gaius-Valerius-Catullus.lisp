(defpackage :catullus (:use :cl :alexandria :bordeaux-threads)
  (:nicknames :gaius-valerius-catullus)
  (:documentation "Catullus handles the textual interface whereby
human-provided strings are parsed and tokenized into propositions
understandable to the AI characters, and rendering the “thoughts” of
AI characters into string form.

This module also handles the ConceptNet5 database.

Gaius Valerius Catullus was a noted poet/songwriter."))

(in-package :catullus)


;;; ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––

(defvar *concept-db* nil)
(defvar *concept-db-lock* (make-lock "ConceptDB Update Lock"))

(defmacro in-db (&body body)
  `(restart-case
       (handler-case
           (progn 
             (unless *concept-db*
               (connect-concepts-db))
             ,@body))
     (reconnect-to-memory-db ()
       (connect-concepts-db))
     (initialize-db ()
       (init-memory-db))
     (demolish-db-without-hope-of-recovery ()
       (mapcar (lambda (q) (sqlite:execute-non-query *concept-db* q))
               '("DROP TABLE concepts"
                 "DROP TABLE atoms")))))

(defun connect-concepts-db ()
  (setf *concept-db* (sqlite:connect ":memory:"))
  (init-memory-db)
  (in-db
    (setf &select-atom-id
          (sqlite:prepare-statement
           *concept-db*
           "SELECT rowid FROM atoms WHERE symbol=?"))
    (setf &insert-atom
          (sqlite:prepare-statement
           *concept-db*
           "INSERT OR FAIL INTO atoms (symbol) VALUES (?)"))
    (setf &insert-concept
          (sqlite:prepare-statement
           *concept-db*
           "INSERT OR FAIL INTO concepts (s,p,o) VALUES (?,?,?)"))
    (setf &select-concept-spo
          (sqlite:prepare-statement
           *concept-db*
           "SELECT rowid,s,p,o FROM concepts WHERE s=? AND p=? AND o=?"))
    (setf &select-concept-sp
          (sqlite:prepare-statement
           *concept-db*
           "SELECT rowid,s,p,o FROM concepts WHERE s=? AND p=?"))
    (setf &select-concept-po
          (sqlite:prepare-statement
           *concept-db*
           "SELECT rowid,s,p,o FROM concepts WHERE p=? AND o=?"))
    (setf &select-concept-so
          (sqlite:prepare-statement
           *concept-db*
           "SELECT rowid,s,p,o FROM concepts WHERE s=? AND o=?"))
    (setf &select-concept-s
          (sqlite:prepare-statement
           *concept-db*
           "SELECT rowid,s,p,o FROM concepts WHERE s=?"))
    (setf &select-concept-p
          (sqlite:prepare-statement
           *concept-db*
           "SELECT rowid,s,p,o FROM concepts WHERE p=?"))
    (setf &select-concept-o
          (sqlite:prepare-statement
           *concept-db*
           "SELECT rowid,s,p,o FROM concepts WHERE o=?"))))

(defun init-memory-db ()
  (mapcar (lambda (q) (sqlite:execute-non-query *concept-db* q))
          '("CREATE TABLE atoms (symbol VARCHAR)"
            "CREATE INDEX symbolic ON atoms (symbol)"
            "CREATE TABLE concepts (s INT, p INT, o INT)"
            "CREATE INDEX spo ON concepts (s, p, o)"
            "CREATE INDEX sp ON concepts (s, p)"
            "CREATE INDEX po ON concepts (p, o)"
            "CREATE INDEX so ON concepts (s, o)"
            "CREATE INDEX s ON concepts (s)"
            "CREATE INDEX p ON concepts (p)"
            "CREATE INDEX o ON concepts (o)")))

(defvar &select-atom-id)
(defvar &insert-atom)
(defvar &insert-concept)
(defvar &select-concept-spo)
(defvar &select-concept-sp)
(defvar &select-concept-po)
(defvar &select-concept-so)
(defvar &select-concept-s)
(defvar &select-concept-p)
(defvar &select-concept-o)

(defun intern-cn5-symbol (symbol)
  (declare (type string symbol))
  (in-db
    (if-let ((id (progn
                   (sqlite:reset-statement &select-atom-id)
                   (sqlite:bind-parameter &select-atom-id 1 symbol)
                   (sqlite:step-statement &select-atom-id)
                   (sqlite:statement-column-value &select-atom-id 0))))
      id
      (with-lock-held (*concept-db-lock*)
        (sqlite:reset-statement &insert-atom)
        (sqlite:bind-parameter &insert-atom 1 symbol)
        (sqlite:step-statement &insert-atom)
        (sqlite:last-insert-rowid *concept-db*)))))

(defun add-concept (subj pred obj
                    &aux
                      (s (intern-cn5-symbol subj))
                      (p (intern-cn5-symbol pred))
                      (o (intern-cn5-symbol obj)))
  (in-db
    (with-lock-held (*concept-db-lock*)
      (sqlite:reset-statement &insert-concept)
      (sqlite:bind-parameter &insert-concept 1 s)
      (sqlite:bind-parameter &insert-concept 2 p)
      (sqlite:bind-parameter &insert-concept 3 o)
      (sqlite:step-statement &insert-concept)
      (sqlite:last-insert-rowid *concept-db*))))

(defgeneric find-facts (s p o)
  (:documentation "Find facts in the conceptual database that match
  the given subject, predicate, and/or object. Any one or two
  parameters can be replaced with '* as a wildcard."))

(defmacro find-facts-pattern (s-spec p-spec o-spec)
  (let ((statement (intern (format nil "&SELECT-CONCEPT-~:[~;S~]~:[~;P~]~:[~;O~]"
                                   s-spec p-spec o-spec)))
        (p-index (if s-spec 2 1))
        (o-index (+ 1 (if s-spec 1 0) (if p-spec 1 0))))
    `(defmethod find-facts 
         ((s ,(if s-spec 'string '(eql '*)))
          (p ,(if p-spec 'string '(eql '*)))
          (o ,(if o-spec 'string '(eql '*))))
       ((lambda (subj pred obj )
          ,(append (list 'declare)
                   (unless s-spec `((ignore subj)))
                   (unless p-spec `((ignore pred)))
                   (unless o-spec `((ignore obj ))))
          (in-db
            (sqlite:reset-statement ,statement)
            ,(when s-spec `(sqlite:bind-parameter ,statement 1 subj))
            ,(when p-spec `(sqlite:bind-parameter ,statement ,p-index pred))
            ,(when o-spec `(sqlite:bind-parameter ,statement ,o-index obj))
            (loop while (sqlite:step-statement ,statement)
               collecting (list (sqlite:statement-column-value ,statement 1)
                                (sqlite:statement-column-value ,statement 2)
                                (sqlite:statement-column-value ,statement 3)))))
        ,(when s-spec `(intern-cn5-symbol s))
        ,(when p-spec `(intern-cn5-symbol p))
        ,(when o-spec `(intern-cn5-symbol o))))))

(find-facts-pattern nil  nil  t)
(find-facts-pattern nil  t    nil)
(find-facts-pattern nil  t    t)
(find-facts-pattern t    nil  nil)
(find-facts-pattern t    nil  t)
(find-facts-pattern t    t    nil)
(find-facts-pattern t    t    t)

(defun conceptnet5-file->sexp (file)
  (format *trace-output* "~& Loading ConceptNet5 data from ~S~%" file)
  (with-open-file (in file :direction :input :external-format :utf-8)
    (loop
       for line = (read-line in nil :eof)
       until (eql :eof line)
       for line-count from 1
       for parts = (split-sequence:split-sequence #\Tab line :test #'char=)
       ;; for (pred subj obj ctx vers src eid lic) =
       ;;   (mapcar (lambda (s) (intern s :cvc)) (subseq parts 1 9))
       for (pred subj obj) = (subseq parts 1 4)
       do (add-concept subj pred obj)
       when (or nil (= 0 (random 10000)))
       do (format *trace-output* "~& - Record #~:D states:	~A"
                  line-count (utterance->human (list subj pred obj) :en))
       finally (format *trace-output* "~& Finished with ~:D records" line-count))))

(defun conceptnet5-read-files (wildcard)
  (mapcar #'conceptnet5-file->sexp (directory wildcard)))

(defun print-fact (s p o)
  (format t "~&~A" (utterance->human (list s p o) :en)))

(defun dump-concepts ()
  
  (TODO))


;;; ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––

(defmacro TODO (&rest params)
  `(cerror "ignore and continue"
           "Unimplemented function called with~%~S" (list ,@params)))

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
       (list :untranslatable utterance)))

(defgeneric utterance->human (utterance language-code))

(defgeneric utterance-formatting-string (predicate language-code))

(defmethod utterance-formatting-string 
    ((predicate integer) language-code)
  (utterance-formatting-string 
   (utterance->human predicate language-code) language-code))

(defmacro string-case (compare &body clauses)
  `(cond
     ,@(mapcar (lambda (clause)
                 (if (eql t (car clause))
                     `(t ,@(cdr clause))
                     `((string= ,compare ,(car clause)) ,@(cdr clause))))
               clauses)))

(defmethod utterance-formatting-string
    (predicate (language-code (eql :en)))
  (string-case predicate
    ("/r/Antonym" "~0@*~A and ~2@*~A are antonyms.")
    ("/r/AtLocation" "~0@*~A is at the location ~2@*~A.")
    ("/r/Attribute" "~0@*~A has the attribute that it is ~2@*~A.")
    ("/r/CapableOf" "~0@*~A can ~2@*~A.")
    ("/r/Causes" "~0@*~A causes ~2@*~A.")
    ("/r/CausesDesire" "~0@*~A might cause a desire for ~2@*~A.")
    ("/r/ConceptuallyRelatedTo" "~0@*~A is a concept which is related to the concept of ~2@*~A.")
    ("/r/CreatedBy" "~2@*~A creates ~0@*~A.")
    ("/r/DefinedAs" "~0@*~A is defined as being ~2@*~A.")
    ("/r/Derivative" "~2@*~A is derived from ~0@*~A.")
    ("/r/DerivedFrom" "~0@*~A is derived from ~2@*~A.")
    ("/r/DerivedFrom" "~0@*~A is derived from ~2@*~A.")
    ("/r/DesireOf" "~0@*~A is the desire of ~2@*~A.")
    ("/r/Desires" "~0@*~A desires ~2@*~A.")
    ("/r/Entails" "~0@*~A entails ~2@*~A.")
    ("/r/HasA" "~0@*~A has a ~2@*~A.")
    ("/r/HasContext" "~0@*~A occurs in the context of ~2@*~A.")
    ("/r/HasFirstSubevent" "The first thing to do when doing ~0@*~A, is ~2@*~A")
    ("/r/HasLastSubevent" "The last thing to do when doing ~0@*~A, is ~2@*~A")
    ("/r/HasPainCharacter" "~0@*~A has the pain character of ~2@*~A.")
    ("/r/HasPainIntensity" "~0@*~A has the pain intensity of ~2@*~A.")
    ("/r/HasPrerequisite" "~2@*~A is required before ~0@*~A.")
    ("/r/HasProperty" "~2@*~A is a property of a ~0@*~A.")
    ("/r/HasSubevent" "While doing ~0@*~A, one might ~2@*~A.")
    ("/r/InheritsFrom" "~0@*~A inherits from ~2@*~A.")
    ("/r/InstanceOf" "~0@*~A is an instance of ~2@*~A.")
    ("/r/IsA" "~0@*~A is a ~2@*~A.")
    ("/r/LocatedNear" "~0@*~A is located near to ~2@*~A.")
    ("/r/LocationOfAction" "~0@*~A is where one might do ~2@*~A.")
    ("/r/MadeOf" "~0@*~A is made of ~2@*~A.")
    ("/r/MemberOf" "~0@*~A is a member of ~2@*~A.")
    ("/r/MotivatedByGoal" "~0@*~A is motivated by the goal of ~2@*~A.")
    ("/r/NotCapableOf" "~0@*~A cannot ~2@*~A.")
    ("/r/NotCauses" "~0@*~A does not cause ~2@*~A.")
    ("/r/NotDesires" "~0@*~A does not desire ~2@*~A.")
    ("/r/NotHasA" "~0@*~A does not have a ~2@*~A.")
    ("/r/NotHasProperty" "~0@*~A does not have the property of being ~2@*~A.")
    ("/r/NotIsA" "~0@*~A is not a ~2@*~A.")
    ("/r/NotMadeOf" "~0@*~A is not made of ~2@*~A.")
    ("/r/NotUsedFor" "~0@*~A is not used for ~2@*~A")
    ("/r/ObstructedBy" "~0@*~A is obstructed by ~2@*~A.")
    ("/r/PartOf" "~0@*~A is a part of ~2@*~A.")
    ("/r/ReceivesAction" "~0@*~A receives the action ~2@*~A (one might be able to ~2@*~A a ~0@*~A).")
    ("/r/RelatedTo" "~0@*~A is related to ~2@*~A.")
    ("/r/SimilarSize" "~0@*~A and ~2@*~A are of similar size.")
    ("/r/SimilarTo" "~0@*~A is similar to ~2@*~A.")
    ("/r/SymbolOf" "~0@*~A is a symbol of ~2@*~A.")
    ("/r/Synonym" "~0@*~A and ~2@*~A are synonymous.")
    ("/r/TranslationOf" "~0@*~A is a translation of ~2@*~A into another language.")
    ("/r/UsedFor" "One might use a ~0@*~A for ~2@*~A.")
    ("/r/UsedFor/" "One might use a ~0@*~A for ~2@*~A.")
    ("/r/wordnet/adjectivePertainsTo" "~0@*~A is an adjective which pertains to ~2@*~A.")
    ("/r/wordnet/adverbPertainsTo" "~0@*~A is an adverb which pertains to ~2@*~A.")
    ("/r/wordnet/participleOf" "~0@*~A is a participle (in inflection) of ~2@*~A.")
    (t (cerror "ignore and continue" "Untranslated predicate: ~A" predicate)
       "“~A” —~A→ “~A”")))

(defgeneric language-name (code in-language))
(defmethod language-name (code (language-code (eql :en)))
  (format nil "the language with code ~A" code))

(defgeneric utterance->human/sub-expression 
    (keyword utterance language-code))

(defmethod utterance->human/sub-expression ((keyword t) utterance
                                            (language-code (eql :en)))
  (format nil "~A: [~{~A~^ ~}]" keyword utterance))

(defmethod utterance->human/sub-expression ((keyword (eql :untranslateable))
                                            utterance
                                            (language-code (eql :en)))
  (let ((path (split-sequence:split-sequence #\/ utterance
                                             :remove-empty-subseqs t)))
    (string-case (car path)
      ("c" (format nil "“~A~{~^ (~A)~}” (in ~A)"
                   (third path) (cdddr path)
                   (language-name (second path) :en)))
      (t (format nil "untranslateable concept in ~A encoded as ~A"
                 (second path) utterance)))))


(defgeneric utterance->human/fact (utterance language-code))

(defmethod
    utterance->human/fact (utterance (language-code (eql :en)))
  (destructuring-bind (subj pred obj) utterance
    (format nil (utterance-formatting-string pred :en)
            (utterance->human subj :en)
            (utterance->human pred :en)
            (utterance->human obj :en))))

(defmethod utterance->human ((utterance cons) (language-code (eql :en)))
  (if (keywordp (car utterance))
      (utterance->human/sub-expression (car utterance)
                                       (cdr utterance) language-code)
      (utterance->human/fact utterance language-code)))

(defun launder_string (string)
  (map 'string (lambda (ch) (case ch
                              (#\Tab #\Space)
                              (#\_ #\Space)
                              (otherwise ch)))
       string))

(defmethod utterance->human ((utterance null) language-code)
  (cerror "continue" "Got a null in an utterance.")
  "×")

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

(defmethod utterance->human ((utterance string) (language-code (eql :en)))
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
         utterance))))

(defmethod utterance->human ((utterance integer) language-code)
  (let ((p (sqlite:execute-single *concept-db*
                                  "SELECT symbol FROM atoms WHERE rowid=?"
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
  (format t "~&~10TReady >")
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

(defun converse/answer-question (string tagged haggard chunky)
  (declare (ignorable string tagged haggard chunky))
  (format *trace-output* "~& Answering question: ~A" string)
  (format *trace-output* "~& tree: ~S" (parse-tagged-into-tree haggard))
  (cond
    ((find-if (lambda (pair) (equal (second pair) "WP")) haggard)
     (let ((wh (mapcar #'car (remove-if-not (lambda (pair)
                                              (equal (second pair) "WP")) haggard)))
           (vb (mapcar #'car (remove-if-not (lambda (pair)
                                              (member (second pair) '("VBZ" "VBP")))
                                            haggard)))
           #+(or)(expr (remove-if (lambda (pair)
                                    (string-case (second pair)
                                      ("WP" t)
                                      ("DT" t)
                                      ("." t)
                                      (t nil))) haggard)))
       (format t "~&>~:(~{~A~^/~}~) ~{~A~} ~A?"
               wh vb
               (descend-langutils-tokens 
                (mapcar #'langutils:phrase->token-array chunky)))
       (format t "~&>~A" (parse-sentence-langnet haggard))))
    (t ;; adjudicate validity of assertion
     (TODO "true or false question, perhaps?"))))

(defun space-to-_ (string)
  (map 'string (lambda (ch) (if (char= ch #\Space) #\_ ch)) string))

(defun concept-for (thing language)
  (format nil "/c/~(~A~)/~:[~(~A~)~;~{~(~A~)~^/~}~]"
          language (consp thing)
          (if (consp thing)
              (mapcar #'space-to-_ thing)
              thing)))

(defun string-camelcase (string &optional (initial-upper-case-p t))
  (let ((to-upper initial-upper-case-p)
        (output ""))
    (loop for ch across string
       do (if (member ch '(#\- #\_ #\Space))
              (setf to-upper t)
              (progn
                (appendf output
                         (if to-upper
                             (char-upcase ch)
                             (char-downcase ch)))
                (setf to-upper nil))))))

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
                              (list _ "/r/HasProperty"
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

(defun converse-eval (string)
  (cond
    ((and (<= 1 (length string))
          (char= #\? (elt string 0))) (converse-repl-help))
    ((> 2 (length string))
     (format t "‽~%")
     (return-from converse-eval nil))
    ((char= #\; (elt string 0)) nil)
    (t (let* ((tagged (langutils:tag string))
              (haggard (tagged-to-haggard tagged))
              ;;(chunky (langutils:chunk string))
              )
         (format *trace-output*
                 "~&~
trace)string) ~A
trace)tagged) ~A
trace)haggard) ~{‘~A’~^ ~}~%~%"
                 ;; trace)chunky) ~S
                 string tagged haggard  ;chunky
                 )
         (string-case (car (car (last haggard 2)))
                      ("?" (converse/answer-question string tagged haggard ;chunky
                                                     nil))
                      ("!" (TODO))
                      (t (TODO)))))))

(defun converse-repl ()
  (init)
  (format t "~|~&~% Conversation REPL; Gaius Valerius Catullus~%~%")
  (let ((*last-reply*))
    (loop
       (converse-dump 
        (converse-eval
         (converse-read))))))

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

(defun load-conceptnet5-csv-database
    (&optional
       (wildcard (make-pathname :host "r2src"
                                :directory '(:relative "conceptnet5-csv" "assertions")
                                :name :wild
                                :type "csv")))
  (format *trace-output* "~&~%Loading ConceptNet5 dataset from ~S" wildcard)
  (in-db (time (conceptnet5-read-files wildcard)))
  (format *trace-output*
          "~&~%Done, loaded ConceptNet5; ~:D interned tokens, ~:D cross-indexed assertions"
          (sqlite:execute-single *concept-db* "SELECT COUNT(*) FROM atoms")
          (sqlite:execute-single *concept-db* "SELECT COUNT(*) FROM concepts"))
  (push :conceptnet5 *initialized*))

(defun load-langutils (&optional
                         (langutils-dir (asdf:system-relative-pathname 
                                         :langutils ".")))
  (let ((*default-pathname-defaults* langutils-dir))
    (langutils:init-langutils))
  (push :langutils *initialized*))

(defun init ()
  (unless (member :conceptnet5 *initialized*)
    (load-conceptnet5-csv-database))
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
           ("number" :ordinal-marker :precedes-value))
      #\$ ("dollar" :currency (or :singular :plural) :precedes-value)
      #\@ "at"
      #\£ ("pound" :currency :precedes-value)
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
      #\+ "plus"
      #\= ("equal" (or :singular :plural) (or "to"))
      #\≈ (:phrase "approximately" ("equal" (or :singular :plural)) (or "to"))
      #\≠ (:phrase "not" ("equal" (or :singular :plural)) (or "to"))
      #\¢ ("cent" :currency (or :singular :plural))
      #\§ "section"
      #\¶ (or "pi" "paragraph")
      #\♥ (or "heart" "love" "loves")
      #\© "copyright"
      #\® "trademark" ;; ignoring the registered stuff, who cares?
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

(#-later defvar
 #+later define-constant
         english-core-words
         '(|the|  (:article :definite)
           |a|     ((or (:noun :letter) (:article :indefinite :should-not-precede-vowel)))
           |an|    ((or (:if :archaic) (:article :indefinite :must-precede-vowel)))
           |no|    ((or (:article :negative) :determinant :negation))
           |this|  ((or :determinant (:pronoun :impersonal)))
           |am|    ((or (:verb :1person :singular :copula :present :active :indicative)
                     (:assist-verb :1person :singular :present :active)))
           |is|    ((or (:verb :3person :singular :copula :present :active :indicative)
                     (:assist-verb :3person :singular :present :active)))
           |are|   ((or (:verb (or :1person :3person) :plural :copula :present :active :indicative)
                     (:verb :2person (or :singular :plural) :copula :active)
                     (:assist-verb (or (:2person (or :singular :plural))
                                          ((or :1person :3person) :plural)) :present :active)))
           |be|    ((or (:verb :present :participle)
                     (:verb :1person :subjunctive)))
           |were|  ((or (:verb (or :2person :3person) :subjunctive)
                     (:verb :2person :active :indicative :past))))
    #+later :test #+later 'equal)

(defvar punctuation
  '(#\. (:punctuation :sentence-terminal :statement)
    #\, (or (:punctuation :list-separator)
         (:punctuation :vocative-separator)
         (:punctation :phrase-disambiguator)
         (:punctuation :in-quotes-final-sentence-full-stop))
    #\en_dash (or (:punctuation :vocative-separator)
               (:punctation :annominative-separator)
               (:punctation :phrase-disambiguator))
    #\em_dash (or (:punctuation :vocative-separator)
         (:punctation :annominative-separator)
         (:punctation :phrase-disambiguator))
    #\; (or (:punctation :clause-splitting)
         (:punctuation :list-separator-superior))
    #\: (or (:punctuation :vocative-separator)
         (:punctuation :phrase-spliting))
    #\! (:punctuation :sentence-terminal :exclamation)
    #\? (:punctuation :sentence-terminal :interrogative)
    #\‽ (:punctuation :sentence-terminal :exclamation :interrogative)
    #\/ (:stroke)
    #\" (:error)))

(defvar paired-punctuation 
  '((#\( #\)) (:parenthetical)
    (#\“ #\”) (:quotation)
    (#\‘ #\’) (:quotation)
    (#\« #\») (:quotation)
    (#\¿ #\?) (:interrogative)
    (#\¡ #\!) (:exclamation)))

(defun forgotten-punctuation (set)
  (remove-if (lambda (char)
               (getf punctuation char))
             (remove-if (lambda (char)
                          (find-if (lambda (el)
                                    (member char el))
                                  paired-punctuation))
                        set)))

(defmethod potential-parts-of-speech (word (language (eql :en)))
  (cond
    ((keywordp word) '(:particle))
    ((and (consp word) (keywordp (car word))) word)
    ((and (stringp word) (= 1 (length word)))
     (let ((char (elt word 0)))
       (if-let ((interp (getf punctuation char)))
         interp
         (if-let ((start (find-if (lambda (el)
                                    (eql (car el) char)) paired-punctuation)))
           :punctuation-start-pair
           :mystery))))
    ((or-list-p word)
     (cons (car word)
           (mapcar (lambda (maybe) (potential-parts-of-speech maybe :en))
                   (cdr word))))
    (t (or (and (stringp word)
                (getf english-core-words (intern (string-downcase word))))
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
               (mapcar (lambda (each) (tag-sentence each :en)) (cdr sentence))))
        ((find-if #'or-list-p sentence :from-end t)
         (tag-sentence (superpose-or sentence) :en))
        (t
         (superpose-or 
          (loop for word in sentence
             for parts = (potential-parts-of-speech word :en) 
             collect
               (cond
                 ((null parts) :unknown)
                 ((or-list-p parts) (list word parts))
                 ((consp parts) (cons word parts))
                 (t (list word parts))))))))

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
                (mapcar (lambda (alt) (print-tagged alt nil)) (cdr sentence)))
        (format stream"~&~{~A~^ ~_~}"
                (mapcar #'tagged-to-string
                        sentence))))

(defun or-list-p (thing)
  (and (consp thing) (eql 'or (car thing))))

(defun merge-or-list (list)
  (assert (eql (car list) 'or))
  (cons (car list)
        (remove-duplicates 
         (loop for el in (cdr list) 
            if (or-list-p el)
            append (cdr el)
            else collect el)
         :test 'equal)))

(defun list-before (list index)
  (check-type list cons)
  (check-type index (integer 0 *))
  (if (plusp index) (subseq list 0 index) (values)))

(defun burgeon (list alt index)
  (check-type list cons) 
  (check-type index (integer 0 *))
  (check-type alt (or cons atom))
  (typecase alt 
    ;; This case is easy, and works reliably, and can probably be
    ;; optimized pretty heavily.
    (atom (let ((returning (copy-list list)))
            (setf (nth index returning) alt)
            returning))
    ;; This case is a pain in the ass.
    (cons (cond
            ((zerop index) (append alt (cdr list)))
            (t
             (append (subseq list 0 index)
                     alt
                     (when (< index (length list))
                       (subseq list (1+ index)))))))))

(defun superpose-within-list (list)
  (loop
     for el in list
     for i from 0
     when (or-list-p el)
     do (return-from superpose-within-list
          (cons (car el)
                (mapcar (lambda (alt) (burgeon list alt i))
                        (cdr el))))))

(defun superpose-or (list)
  (cond
    ((atom list) list)
    ((or-list-p list)
     (cond 
       ((find-if #'or-list-p (cdr list)) (superpose-or (merge-or-list list)))
       ((null (cddr list)) (superpose-or (cdr list)))
       (t (cons (car list)
                (remove-duplicates
                 (loop 
                    for sub-list in (cdr list)
                    collecting (superpose-or sub-list))
                 :test 'equal)))))
    ((find-if #'or-list-p list :from-end t)
     (merge-or-list (superpose-within-list list)))
    (t (mapcar #'superpose-or list))))

(defun identify-main-verb (tagged-sentence)
  (cons 'or 
        (loop for word in tagged-sentence
           for i from 0
           when (member :verb (cdr word))
           collect (burgeon tagged-sentence (append word :main) i))))

(defgeneric parse-structure (clause language context antecedents))

(defun any-cdr (needle haystacks)
  (loop for stack in (mapcar #'cdr haystacks)
     when (member needle stack)
     return t))

(defun assist-verb (clause language verb i &optional (direction :interrogative))
  (loop for word from 0 to i
     when t return nil))

(defun find-subordinated-clauses (clause)
  (loop for word in clause
     when (equal (second word) :subordinating-clause-marker)
     do (break "I don't actually handle subordinated clauses yet; found ~S in ~S" word clause))
  clause)

(defmethod parse-structure (clause (language (eql :en)) (context (eql :sentence)) antecedents)
  (let ((clause (find-subordinated-clauses clause)))
    (cond ((any-cdr :interrogative clause)
           (when (and (any-cdr :assist-verb clause)
                      (any-cdr :verb clause))
               (loop for verb in clause
                  for i from 0
                  when (eql (second verb) :assist-verb)
                  do (assist-verb clause language verb i :interrogative))))
          (t (error "Interrogative only")))))

(defun test-parser ()
  (assert (null (forgotten-punctuation +syntactic-punctuation+))
          (punctuation paired-punctuation)
          "Forgotten punctuation: ~S
All punctuation in +SYNTACTIC-PUNCTUATION+
must be defined in PUNCTUATION or PAIRED-PUNCTUATION" (forgotten-punctuation +syntactic-punctuation+))
  (assert (null (forgotten-punctuation +word-terminating-punctuation+))
          (punctuation paired-punctuation)
          "Forgotten punctuation: ~S
All punctuation in +WORD-TERMINATING-PUNCTUATION+
must be defined in PUNCTUATION or PAIRED-PUNCTUATION" (forgotten-punctuation +word-terminating-punctuation+))
  (fresh-line)
  (assert (equal (merge-or-list '(or a (or b c))) '(or a b c)))
  (assert (equal (burgeon '(thing (or (1 2) (3 4))) '(1 2) 1)
                 '(thing 1 2)))
  (assert (equal (superpose-within-list '(thing (or 1 2)))
                 '(or (thing 1) (thing 2))))
  (assert (equal (superpose-within-list '(thing (or (:one 1) (:two 2))))
                 '(or (thing :one 1) (thing :two 2))))
  (assert (equal (superpose-or '(thing (:one (or (1 2) (3 4)))))
                 '(or (thing (or (:one 1 2) (:one 3 4))))))
  (assert (equal (superpose-or '("thing" (or :one :two)))
                 '(or ("thing" :one) ("thing" :two))))
  (assert (equal (superpose-or '("thing" (or (:one 1) (:two 2))))
                 '(or ("thing" :one 1) ("thing" :two 2))))
  (assert (equal (burgeon '(dog (or :noun :verb)) :noun 1)
                 '(dog :noun))
          nil "Burgeoning should replace element 1 of a 2-part list")
  (assert (equal (burgeon '((or cat dog) :pet) 'cat 0)
                 '(cat :pet))
          nil "Burgeoning should replace element 0 of a 2-part list")
  (assert (equal (burgeon '(dog :being (or :noun :verb))  :noun 2)
                 '(dog :being :noun))
          nil "Burgeoning should replace element 2 of a 3-part list")
  (assert (equal (burgeon '((or :noun :verb)) :noun 0)
                 '(:noun))
          nil "Burgeoning should replace element 0 of a 1-part list")
  (let ((sentence "Why is the cat purple?"))
    (print sentence)
    (fresh-line)
    (princ "Lex:")
    (let ((lexed (lex-sentence sentence :en)))
      (assert (equal lexed
                     '("Why" "is" "the" "cat" "purple" "?"))
              nil "Lexing this sentence should yield the given result")
      (print lexed)
      (fresh-line)
      (princ "Tag:")
      (let ((tagged (tag-sentence lexed :en))
            (expected '(("Why" :noun) 
                        (or ("is" :verb :3person :singular :copula :present :active :indicative)
                         ("is" :assist-verb :3person :singular :present :active))
                        ("the" :article :definite)
                        (or ("cat" :noun) ("cat" :verb))
                        (or ("purple" :noun) ("purple" :verb) ("purple" :adjective))
                        ("?" :punctuation :sentence-terminal :interrogative))))
        (assert (equal tagged expected) (tagged expected)
                "Expected to tag ~A~%as: ~S~%but instead got~%~S"
                lexed expected tagged)
        (print tagged)
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
          (assert (equal tagged-superposition expected-superposition)
                  (tagged-superposition expected-superposition)
                  "The tagged sentence contains superpositions, which need to be normalized
into a singular top-level superposed sentence (this is a sort of first normal form,
which is a cross product of the interior superpositions). This process should have
returned:
~S

Instead, the following was returned:
~S"
                  expected-superposition tagged-superposition)
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
            (if parses
                (format t "Found ~:D distinct ways to parse:~{~%~S~}"
                        (length parses) parses)
                (format t "Can't parse any alternative. Sentence seems to be nonsense."))))))))







(defun server-start (argv)
  (romance:server-start-banner "Catullus"
                               "Gaius Valerius Catullus"
                               "Intelligent Agents and Language Server")
  (format t "~& Conversation REPL starting…")
  (converse-repl))
