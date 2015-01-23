(defpackage :asinius
  (:use :cl :alexandria :romans :local-time :bordeaux-threads :split-sequence)
  (:nicknames :gaius-asinius-pollio)
  (:documentation
   "Asinius handles connectivity to the Postgres database server, for
long-term storage and disaster recovery.

Gaius Asinius Pollio was a consul noted for constructing the first
public library in Rome, the Atrium Libertatis, as a posthumous favor
to Caesar.")
  (:export #:start-server))
