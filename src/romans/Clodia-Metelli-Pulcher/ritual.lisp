(in-package :clodia)

;;; Things that have to do with performing ritual activities, which
;;; can include as well as rituals per se, things like games, dancing,
;;; musical performances, and the like.

(defun perform (mind plan) :TODO)

(defun judge-ritual-state (mind environment) :TODO)
(defun begin-ritual (mind environment ritual) :TODO)

(defun leave-ritual (mind environment) :TODO)

(defgeneric get-ritual-actions (mind environment ritual))
(defgeneric adjudicate-ritual-action (mind environment ritual action))
(defgeneric choose-next-ritual-action (mind environment ritual))



(defmethod get-ritual-actions (mind environment (ritual (eql :football)))
  :TODO)
(defmethod adjudicate-ritual-action
    (mind environment (ritual (eql :football)) action)
  :TODO)
(defmethod choose-next-ritual-action (mind environment (ritual (eql :football)))
  :TODO)


(defmethod get-ritual-actions (mind environment (ritual (eql :volleyball)))
  :TODO)
(defmethod adjudicate-ritual-action
    (mind environment (ritual (eql :volleyball)) action)
  :TODO)
(defmethod choose-next-ritual-action (mind environment (ritual (eql :volleyball)))
  :TODO)



(defmethod get-ritual-actions (mind environment (ritual (eql :baseball)))
  :TODO)
(defmethod adjudicate-ritual-action
    (mind environment (ritual (eql :baseball)) action)
  :TODO)
(defmethod choose-next-ritual-action (mind environment (ritual (eql :baseball)))
  :TODO)



(defmethod get-ritual-actions (mind environment (ritual (eql :basketball)))
  :TODO)
(defmethod adjudicate-ritual-action
    (mind environment (ritual (eql :basketball)) action)
  :TODO)
(defmethod choose-next-ritual-action (mind environment (ritual (eql :basketball)))
  :TODO)



(defmethod get-ritual-actions (mind environment (ritual (eql :zap-rocks)))
  :TODO)
(defmethod adjudicate-ritual-action
    (mind environment (ritual (eql :zap-rocks)) action)
  :TODO)
(defmethod choose-next-ritual-action (mind environment (ritual (eql :zap-rocks)))
  :TODO)

(defmethod get-ritual-actions (mind environment (ritual (eql :pilot-craft)))
  :TODO)
(defmethod adjudicate-ritual-action
    (mind environment (ritual (eql :pilot-craft)) action)
  :TODO)
(defmethod choose-next-ritual-action (mind environment (ritual (eql :pilot-craft)))
  :TODO)


(defmethod get-ritual-actions (mind environment (ritual (eql :mission-control)))
  :TODO)
(defmethod adjudicate-ritual-action
    (mind environment (ritual (eql :mission-control)) action)
  :TODO)
(defmethod choose-next-ritual-action
    (mind environment (ritual (eql :mission-control)))
  :TODO)


;;; These are particular, game-oriented mental attitudes which are
;;; bizarre, but serve purposes within the game world. They should
;;; perhaps not be hard-coded, but rather re-inforced as rituals with
;;; a mental gratification.


(defun inspired-to-create-a-maze ()
  :TODO)

(defun inspired-to-bury-treasure () :TODO)

(defun construction-crew-behaviour () :TODO)

(defun singing-behaviour () :TODO)

