(defpackage catullus 
  (:use :cl :alexandria :romans :local-time :bordeaux-threads :split-sequence)
  (:nicknames :gaius-valerius-catullus)
  (:documentation "Catullus handles the textual interface whereby
human-provided strings are parsed and tokenized into propositions
understandable to the AI characters, and rendering the “thoughts” of
AI characters into string form.

This module also handles the ConceptNet5 database.

Gaius Valerius Catullus was a noted poet/songwriter.")
  (:export #:converse-repl #:server-start #:test-parser))

