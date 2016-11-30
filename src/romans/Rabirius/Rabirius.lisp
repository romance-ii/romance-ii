(in-package :rabirius)

(defvar *map-pngs* nil)

(defun array->one-channel (channel-number array)
  (check-type array (simple-array (unsigned-byte 8) (* * 4)))
  (let ((width (array-dimension array 0))
        (height (array-dimension array 1)))
    (let ((target (make-array (list width height) :element-type '(unsigned-byte 8))))
      (dotimes (y height)
        (dotimes (x width)
          (setf (aref target x y) (aref array x y channel-number))))
      target)))

(defun map-to-2d (map)
  ;; Altitude  map is  greyscale;  so  read channel  0.  All others  are
  ;; alpha-based, so read channel 3.
  (let ((channel-number (if (eql :altitude map) 0 3)))
    (array->one-channel channel-number
                        (png-read:image-data 
                         (png-read:read-png-file
                          (reference-path "maps" (format nil "~(~a~).png" map)))))))

(defun ensure-pngs ()
  (dolist (map '(:altitude :forests :prarie :sand :savannah :scrub :shadows))
    (unless (getf *map-pngs* map)
      (setf (getf *map-pngs* map) (map-to-2d map)))))

(defun fractalizer-random-state (pixel-x pixel-y map-width map-height)
  (sb-ext:seed-random-state
   (make-array '(2) :element-type '(unsigned-byte 32)
               :initial-contents (list
                                  (coerce (round (* (/ pixel-x map-width) (expt 2 32)))
                                          '(unsigned-byte 32))
                                  (coerce (round (* (/ pixel-y map-height) (expt 2 32)))
                                          '(unsigned-byte 32))))))

(defconstant +pixel->meters+ 100)
(defconstant +offset-scalar+ 1000)
(defconstant +offset-denominator+ 50)
(defconstant +max-offset+ (+ +pixel->meters+ (/ +offset-scalar+ +offset-denominator+)))

(defconstant +random-step+ 20)

(defun drain-random-pool (pixel-x pixel-y map-width)
  (loop repeat (* 2 (+ (* (/ map-width +random-step+)
                          (* (round pixel-x (/ 1 +random-step+)) +random-step+))
                       (* (round pixel-y (/ 1 +random-step+)) +random-step+))) 
     do (random +offset-scalar+)))

(defun merge-pixels-fuzzily (map-pixels &rest keys 
                             &key
                               map-height map-width 
                               pixel-x pixel-y Δpixel-x Δpixel-y
                               offset-x offset-y Δoffset-x Δoffset-y)
  (format t "~& Keys: ~{~% ~10t ~a: ~30t ~a~}" keys)
  (let* ((pixels (loop for x from (+ pixel-x Δpixel-x) to (+ 1 pixel-x Δpixel-x)
                    collect (loop for y from (+ pixel-y Δpixel-y) to (+ 1 pixel-y Δpixel-y)
                               do (format t "~& @ ~d,~d" x y)
                               collect 
                                 (aref map-pixels
                                       (pin 0 x map-width)
                                       (pin 0 y map-height)))))
         (x0 (/ (+ offset-x Δoffset-x) +max-offset+))
         (y0 (/ (+ offset-y Δoffset-y) +max-offset+))
         (x1 (- 1 x0))
         (y1 (- 1 y0))) 
    (format t "~& Pixels: ~{~%~{    #x~2,'0x #x~2,'0x ~2:* ~3d ~3d ~}~}" pixels)
    (format t "~& XY01: ~%    ~d ~d   ≈ ~f ~f ~%    ~d ~d    ≈ ~f ~f" x0 y0 (* 1.0 x0) (* 1.0 y0) x1 y1 (* 1.0 x1) (* 1.0 y1))
    (let ((value (/ (+ (* (aref pixels 0 0) x0 y0) 
                       (* (aref pixels 0 1) x0 y1)
                       (* (aref pixels 1 0) x1 y0)
                       (* (aref pixels 1 1) x1 y1))
                    4)))
      (format t "~& ⇒ ~d = #x~2,'0x ≈ ~f" value (round value) (* 1.0 value))
      value)))

(defun sample-pixels (map x y)
  (ensure-pngs)
  (let ((map-pixels (getf *map-pngs* map)))
    (check-type map-pixels (array (unsigned-byte 8) (* *)))
    (let ((map-width (array-dimension map-pixels 0))
          (map-height (array-dimension map-pixels 1)))
      (multiple-value-bind (pixel-x offset-x) (round x +pixel->meters+)
        (assert (< 0 pixel-x map-width))
        (multiple-value-bind (pixel-y offset-y) (round y +pixel->meters+)
          (assert (< 0 pixel-y map-height))
          (let ((*random-state* (fractalizer-random-state pixel-x pixel-y map-width map-height)))
            (drain-random-pool pixel-x pixel-y map-width)
            (multiple-value-bind (Δpixel-x Δoffset-x)
                (round (/ (random +offset-scalar+) +offset-denominator+))
              (multiple-value-bind (Δpixel-y Δoffset-y)
                  (round (/ (random 1000) +offset-denominator+))
                (merge-pixels-fuzzily map-pixels
                                      :map-height map-height :map-width map-width
                                      :pixel-x pixel-x :pixel-y pixel-y
                                      :Δpixel-x Δpixel-x :Δpixel-y Δpixel-y
                                      :offset-x offset-x :offset-y offset-y
                                      :Δoffset-x Δoffset-x :Δoffset-y Δoffset-y)))))))))

(defun fat-bit (value))

(defun server-start (&optional argv)
  (declare (ignore argv))
  (romans:server-start-banner "Rabirius"
                              "Rabirius"
                              "Geography")
  (format t "~& Not doing anything (yet)"))

