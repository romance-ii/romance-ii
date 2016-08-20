(defpackage :caesar
  (:use :cl :romans)
  (:nicknames :gaius-iulius-caesar)
  (:documentation "Caesar oversees the system on which it is running,
and ensures that sufficient resources are available for uninterrupted
operations. Caesar may terminate workers when they are no longer
needed, or requisition additional resources (such as starting a new
virtual machine or requesting additional storage space)
when necessary.

Gaius Julius Caesar was known as a famous general. (But you knew
that, right?)")
  
  (:export #:*module*
           #:*operator-handle-signals*
           #:all-process-ids
           #:all-threads/alpha
           #:collect-qos
           #:get-real-time
           #:find-thread
           #:local-processes
           #:machine-meminfo
           #:machine-vmstat
           #:process-command
           #:process-command-line
           #:process-control-groups
           #:process-core-dump-filter
           #:process-environment
           #:process-file
           #:process-id
           #:process-io-stats
           #:process-login-uid
           #:process-mount-info
           #:process-mount-points
           #:process-name
           #:process-oom-adjust
           #:process-oom-score
           #:process-oom-score-adjust
           #:process-sched
           #:process-security-attributes
           #:process-state-gerund
           #:process-status
           #:process-wait-channel
           #:processes-in-control-group
           #:read-from-thread
           #:report
           #:run-external
           #:split-and-collect-file
           #:start-server
           #:this-process
           #:todo
           #:what
           #:who
           #:with-oversight
           #:with-report-acceptor
           #:with-timeout-handler))

(require :trivial-backtrace)

