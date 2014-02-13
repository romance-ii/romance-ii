(defpackage :caesar
  (:use :cl :alexandria)
  (:nicknames :gaius-iulius-caesar)
  (:documentation "Caesar oversees the system on which it is running,
and ensures that sufficient resources are available for uninterrupted
operations. Caesar may terminate workers when they are no longer
needed, or requisition additional resources (such as starting a new
virtual machine or requesting additional storage space)
when necessary.

Gaius Julius Caesar was known as a famous general. (But you knew
that, right?)")
  
  (:export #:report
           #:with-oversight))


