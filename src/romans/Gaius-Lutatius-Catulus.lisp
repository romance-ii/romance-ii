(defpackage :lutatius
  (:use :cl :alexandria)
  (:documentation "Gaius Lutatius Catulus [Latin:
C·LVTATIVS·C·F·CATVLVS] was a Roman statesman and naval commander in
the First Punic War.  Temple to Juturna, built by Catulus to celebrate
his victory at Aegades islands, in Largo di Torre Argentina, Rome.

He was elected as a consul in 242 BC, a novus homo. During his
consulship he supervised the construction of a new Roman fleet. This
fleet was funded by donations from wealthy citizens, since the public
treasury was virtually empty. He then led the fleet into victory over
Hanno the Great's Carthaginian fleet in the Battle of the Aegates
Islands. This was the decisive battle of the First Punic War. To
celebrate his victory, he built a temple to Juturna in Campus Martius,
in the area currently known as Largo di Torre Argentina.")
  (:export #:start-server))

(in-package :lutatius)

(defclass equipping-person-shape ()
  ((equipment-slots :initarg :slots :reader person-equipment-slots)))

(defun symbolize (n)
  (when n (intern (string-upcase (etypecase n
                                   (symbol (symbol-name n))
                                   (string n))) "KEYWORD")))

(define-condition redefined-equipment-slot ()
  ((previously :reader previous-slot-parent :initarg :previously :type (or symbol nil))
   (now :reader new-slot-parent :initarg :now :type (or symbol nil))
   (slot :reader redefined-slot-name :initarg :slot :type (or symbol nil)))
  (:report (lambda (c s)
             (format s
                     "The equipment mount-point symbol ~:(~A~) was previously
defined as a ~:[slot~*~;valence level of the slot ~:(~A~)~];
but in this form, you tried to redefine it as a ~:[slot~*~;valence level of the slot ~:(~A~)~],
which is not allowed. Every mount-point identified by the same
symbol (:~S) must be used in the same way."
                     (redefined-slot-name c)
                     (not (eql t (previous-slot-parent c)))
                     (previous-slot-parent c)
                     (not (eql t (new-slot-parent c)))
                     (new-slot-parent c)
                     (redefined-slot-name c))))
  (:documentation "Signaled when an attempt is made in a
`define-person-shape-for-equipment' form to define a slot or valence
level of a slot which are already defined to mean something else. This
might mean a valence redefined as a slot, or vice-versa, or a valence
defined as a level of a different slot than it was previously
defined (e.g. putting bracelets on your head)"))

(defvar *all-equipment-slots* (make-hash-table :test 'eql))

(defun %define-equipment-slot (slot-desc)
  (destructuring-bind (slot equiv &rest valences) slot-desc
    (let* ((equivalent (when equiv (car equiv)))
           (effective (or equivalent slot)))
      (unless (eql t (gethash effective
                              *all-equipment-slots* t))
        (error 'redefined-equipment-slot
               :previously (gethash effective *all-equipment-slots*)
               :now t
               :slot effective))
      (setf (gethash effective *all-equipment-slots*) t)
      (dolist (valence valences)
        (unless (eql effective (gethash valence
                                        *all-equipment-slots* effective))
          (error 'redefined-equipment-slot
                 :previously (gethash valence *all-equipment-slots*)
                 :now effective
                 :slot valence))
        (setf (gethash valence *all-equipment-slots*) effective))
      (mapcar #'symbolize
              (append (list slot equivalent) valences)))))

(defmacro define-person-shape-for-equipment (shape-name (&rest slots))
  `(defvar ,(intern (concatenate 'string "*PERSON-SHAPE-"
                                 (string-upcase (symbol-name shape-name)) "*"))
       (make-instance
     'equipping-person-shape
     :slots '(,(mapcar #'%define-equipment-slot slots)))))

(define-person-shape-for-equipment biped
    ((head () helmet hat hair)
     (face () glasses mask goggles faceplate)
     (neck () necklace collar)
     (torso () bra undershirt shirt waistcoast jacket coat overcoat sash backpack)
     (left-arm (arm) undershirt-sleeve shirt-sleeve
               jacket-sleeve coat-sleeve overcoat-sleeve arm-band)
     (right-arm (arm) undershirt-sleeve shirt-sleeve
                jacket-sleeve coat-sleeve overcoat-sleeve arm-band)
     (left-hand (hand) glove wrist handheld)
     (right-hand (hand) glove write handheld)
     (waist () belt gunbelt)
     (groin () briefs cup boxers pants overpants)
     (left-leg (leg) boxers-leg pants-leg overpants-leg leg-band)
     (right-leg (leg) boxers-leg pants-leg overpants-leg leg-band)
     (left-foot (foot) socks shoes galoshes)
     (right-foot (foot) socks shoes galoshes)))

(defclass item () ())
(defclass equippable-item (item)
  ((mounts 
    )))
(defclass item+discrete-count (equippable-item) ())
(defclass item+continuous-gauge (equippable-item) ())
(defclass usable-item (item) ())
(defclass usable-item/targeted (usable-item) ())
(defclass usable-item/directed (usable-item) ())
(defclass usable-item/directional (usable-item) ())
(defclass usable-item/immediate (usable-item) ())

(defgeneric can-equip-p (shape item))

(defmethod can-equip-p ((shape equipping-person-shape) (item equippable-item))
  (loop :for mount :in (equipment-mount-points item)
     :unless (loop :for slot :in (person-equipment-slots shape)
                :return (find mount (cddr slot)))
     :return nil
     :finally t))

(defgeneric equip (character item &optional slot-specifier))

(defgeneric character-use-item (character item target))

;;; ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––


(defun start-server (argv)
  (romance:server-start-banner "Lutatius"
                               "Gaius Lutatius Catulus"
                               "Equipment handling server")
  (format t "~&Lutatius: No-op.~%"))


