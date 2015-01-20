(in-package :clodia)

(defclass sound-asset ()
  ((kind )))

(defclass stimulus-event ()
  ((origin :initarg :origin :reader stimulus-origin)))

(defclass visual-event (stimulus-event) nil)

(defclass haptic-event (stimulus-event)
  ((force :initarg :volume :reader haptic-force)))

(defclass sound-event (haptic-event)
  ((asset :initarg :asset :reader sound-asset)))

(defclass speech-event (sound-event)
  ((language :initarg :lang :reader speech-language)
   (voice :initarg :voice :reader speech-voice)
   (timbre :initarg :timbre :reader speech-timbre)
   (dialog :initarg :dialog :reader dialog)))

(defun sound-volume (sound-event)
  (check-type sound-event sound-event)
  (haptic-force sound-event))

;;(defgeneric effective-force-at-point (origin force point))

(defclass haptic-event (stimulus-event) nil)

(defgeneric stimulate (observer stimulus))

(define-condition stimulus-not-acceptable (warning)
  ((stimulus :initarg :stimulus :reader stimulus))
  (:report (lambda (c s)
             (format s "The stimulus signaled was not acceptable to any observer."))))


(defun pay-attention-to (mind matter) :TODO)

(defun determine-perception (mind stimulus) :TODO)

(defun compare/contrast (mind one other) :TODO)

(defun adjudicate-like/dislike (mind matter) :TODO)

(defun what-to-wear? (mind inventory) :TODO)

(defun self-preservation (mind stimulus) :TODO)

(defun find-route-to (mind destination) :TODO)

(defun find-route (mind start destination) :TODO)

(defun reckon-how-to-get (mind object) :TODO)

(defun reckon-how-to-create (mind situation) :TODO)

(defun evaluate-plan-virtue (mind plan) :TODO)

(defun evaluate-character-virtue (mind character) :TODO)

;;; TODO: conversational interactions with Catullus






