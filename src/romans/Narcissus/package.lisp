(defpackage :narcissus 
  (:use :cl :alexandria :romans :local-time :bordeaux-threads :split-sequence)
  (:documentation "Narcissus handles the simulation of physical forces.

Named for the famous wrestler Narcissus, who may have once
assassinated an emperor, not the mythological character who was turned
into a flower.

Narcissus uses the Bullet Physics library for its underlying model.")
  (:export #:start-server))
