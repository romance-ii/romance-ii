(in-package :narcissus)

(define-condition unable-to-load-c++-libraries ()
  ((libs-loaded) (error-condition) (user-message))
  (:report (lambda (c s)
             (format s "Unable to load C++ libraries. ~@[~%Loaded these libraries successfully:~{~% • ~A~}~]
Unable to load because of error: ~A~&~A"
                     (libs-loaded c) (error-condition c) (user-message c)))))

(defgeneric propagate-stimulus (stimulus)
  (:documentation "Inject a stimulus into the world. 

This event then must be propagated to any obhserver(s) who might be
able to perceive it. Note that this is separate from any issue such as
the actual physical changes that could occur in the game world; this
is, rather, the bridge to the players (presenting a stimulus through
their user agent) or NPC's (provididng the stimulus to the mind
controlling the character).

In general, a haptic (including sound or speech) or visual event may
be triggered by any change in the physics core. Narcissus will then
determine the potential observers only after considering occlusions or
dampening (e.g. by distance).

For players, then, most all observable events will be routed to their
user-agent for immediate presentation (via Appius).

For NPC's, the process continues:

Once the event has been routed to a subset of potential observers,
then a second layer of dampening or elimination is possible by
Lutatius. The sensory capabilities of a creature might limit their
ability to perceive the event; e.g. a deaf character might only
receive haptic events of wery great magnitude, and be unable to detect
more subtle ones like sppech.
 
Finally, Clōdia will be given the opportunity to handle the creature's
reaction; a further realm of dampening might occur as the NPC might
not notice something, or might not be paying attemtion to it."))

(defun start-server (argv)
  (caesar:with-oversight (:narcissus)
    (romans:server-start-banner "Narcissus" "Narcissus"
                                "Physical forces simulation server"))
  (format t "~& Narcissus: Bye!~%"))


