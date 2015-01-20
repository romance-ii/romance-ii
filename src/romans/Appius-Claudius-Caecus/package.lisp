(defpackage :appius
  (:use :cl :alexandria :usocket :st-json)
  (:nicknames :appius-claudius-caecus :appius-claudius-cæcus)
  (:documentation
   "Appius Claudius Caecus handles network I/O. All socket connections
from clients are routed through Appius, and into the message queues
for the game itself.

Appius Claudius Caecus was notable for building a major road out of
Rome, the Appian Way, as well as being blind, and twice Consul.")
  (:export #:start-server))
