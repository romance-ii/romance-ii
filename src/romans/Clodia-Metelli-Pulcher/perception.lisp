(in-package :clodia)

(defclass sound-event nil nil)
(defclass speech-event (sound-event) nil)
(defclass visual-event nil nil)
(defclass physics-event nil nil)

(defgeneric stimulate (mind stimulus))

(defmethod stimulate (mind (stimulus sound-event)) :TODO)

(defmethod stimulate (mind (stimulus speech-event)) :TODO)

(defmethod stimulate (mind (stimulus visual-event)) :TODO)

(defmethod stimulate (mind (stimulus physics-event)) :TODO)


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

(defun perform (mind plan) :TODO)

(defun judge-game-state (mind environment) :TODO)
(defun begin-game (mind environment game) :TODO)

(defun leave-game (mind environment) :TODO)

(defgeneric get-game-actions (mind environment game))
(defgeneric adjudicate-game-action (mind environment game action))
(defgeneric choose-next-game-action (mind environment game))



(defmethod get-game-actions (mind environment (game (eql :football)))
  :TODO)
(defmethod adjudicate-game-action
 (mind environment (game (eql :football)) action)
  :TODO)
(defmethod choose-next-game-action (mind environment (game (eql :football)))
  :TODO)


(defmethod get-game-actions (mind environment (game (eql :volleyball)))
  :TODO)
(defmethod adjudicate-game-action
    (mind environment (game (eql :volleyball)) action)
  :TODO)
(defmethod choose-next-game-action (mind environment (game (eql :volleyball)))
  :TODO)



(defmethod get-game-actions (mind environment (game (eql :baseball)))
  :TODO)
(defmethod adjudicate-game-action
    (mind environment (game (eql :baseball)) action)
  :TODO)
(defmethod choose-next-game-action (mind environment (game (eql :baseball)))
  :TODO)



(defmethod get-game-actions (mind environment (game (eql :basketball)))
  :TODO)
(defmethod adjudicate-game-action
    (mind environment (game (eql :basketball)) action)
  :TODO)
(defmethod choose-next-game-action (mind environment (game (eql :basketball)))
  :TODO)



(defmethod get-game-actions (mind environment (game (eql :zap-rocks)))
  :TODO)
(defmethod adjudicate-game-action
    (mind environment (game (eql :zap-rocks)) action)
  :TODO)
(defmethod choose-next-game-action (mind environment (game (eql :zap-rocks)))
  :TODO)

(defmethod get-game-actions (mind environment (game (eql :pilot-craft)))
  :TODO)
(defmethod adjudicate-game-action
    (mind environment (game (eql :pilot-craft)) action)
  :TODO)
(defmethod choose-next-game-action (mind environment (game (eql :pilot-craft)))
  :TODO)


(defmethod get-game-actions (mind environment (game (eql :mission-control)))
  :TODO)
(defmethod adjudicate-game-action
    (mind environment (game (eql :mission-control)) action)
  :TODO)
(defmethod choose-next-game-action
 (mind environment (game (eql :mission-control)))
  :TODO)


(defun inspired-to-create-a-maze ()
  :TODO)

(defun inspired-to-bury-treasure () :TODO)

(defun construction-crew-behaviour () :TODO)

(defun singing-behavious () :TODO)






