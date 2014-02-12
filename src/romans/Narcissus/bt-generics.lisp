(in-package :bullet-physics)

;;; 
;;; For purposes of ensuring that we don't accidentally vivify a
;;; method with some odd signature, all generics are defined herein,
;;; in alphabetical order, with the (setf) forms sorted up front.
;;; 

(defgeneric (setf anisotropic-friction) (friction thing))
(defgeneric (setf apply-speculative-contact-restitution-p) (enablep world))
(defgeneric (setf basis) (basis thing))
(defgeneric (setf broadphase) (broadphase self))
(defgeneric (setf constraint-solver) (solver world))
(defgeneric (setf ncopy) (self other))
(defgeneric (setf debug-drawer) (drawer world))
(defgeneric (setf dispatcher) (dispatcher self))
(defgeneric (setf force-update-all-aabbs) (force-p world))
(defgeneric (setf frames) (constraint frame-a frame-b))
(defgeneric (setf gravity) (gravity world))
(defgeneric (setf interpolation-angular-velocity) (transform thing))
(defgeneric (setf interpolation-linear-velocity) (transform thing))
(defgeneric (setf interpolation-world-transform) (transform thing))
(defgeneric (setf latency-motion-state-interpolation-p) (enablep world))
(defgeneric (setf local-scaling) (scaling thing))
(defgeneric (setf margin) (margin thing))
(defgeneric (setf num-tasks) (tasks world))
(defgeneric (setf origin) (origin thing))
(defgeneric (setf pair-cache) (pair-cache self))
(defgeneric (setf rotation) (rotation thing))
(defgeneric (setf synchronize-all-motion-states-p) (synchp world))
(defgeneric (setf world-transform) (world-transform thing))
(defgeneric ->serial (object &key &allow-other-keys))
(defgeneric <-serial (object &key &allow-other-keys))
(defgeneric +f (thing amount))
(defgeneric -f (thing amount))
(defgeneric *f (thing amount))
(defgeneric /f (thing amount))
(defgeneric aabb (thing aabb-min aabb-max)) ; Axis-Aligned Bounding-Box
(defgeneric apply-transform (transform vector))
(defgeneric add-action (world action))
(defgeneric add-character (world character))
(defgeneric add-collision-object (world object &optional group mask))
(defgeneric add-constraint (world constraint &key disable-collisions-between-linked-bodies-p))
(defgeneric add-rigid-body (world body &optional group mask))
(defgeneric add-vehicle (world vehicle))
(defgeneric apply-gravity (world))
(defgeneric apply-speculative-contact-restitution-p (world))
(defgeneric BATCHED-UNIT-VECTOR-GET-SUPPORTING-VERTEX-WITHOUT-MARGIN (self vectors support-vertices-out num-vectors))
(defgeneric basis (thing))
(defgeneric broadphase (self))
(defgeneric calculate-local-inertia (thing mass inertia))
(defgeneric clear-forces (world))
(defgeneric collision-object-array (world))
(defgeneric collision-world (dynamics-world))
(defgeneric compute-overlapping-pairs (world))
(defgeneric constraint (world index))
(defgeneric constraint-solver (world))
(defgeneric contact-pair-test (world object-a object-b result-callback))
(defgeneric contact-test (world object result-callback))
(defgeneric convex-sweep-test (self cast-shape from to result-callback allowed-ccd-penetration))
(defgeneric debug-draw-constraint (world constraint))
(defgeneric debug-draw-object (world world-transform shape color))
(defgeneric debug-draw-world (world))
(defgeneric debug-drawer (world))
(defgeneric dispatch-info (world))
(defgeneric dispatcher (self))
(defgeneric edge (shape i pa pb))
(defgeneric find-algorithm (dispatcher body1 body2 &optional other))
(defgeneric force-update-all-aabbs-p (world))
(defgeneric gravity (world))
(defgeneric half-extents-with-margin (shape))
(defgeneric half-extents-without-margin (shape))
(defgeneric info-2-non-virtual (constraint info a b))
(defgeneric insidep (shape point tolerance))
(defgeneric inv-xform (transform vector)) ; ??
(defgeneric latency-motion-state-interpolation-p (world))
(defgeneric local-supporting-vertex (shape vector))
(defgeneric local-supporting-vertex-without-margin (shape vector))
(defgeneric name (thing))
(defgeneric num-collision-objects (world))
(defgeneric num-constraints (world))
(defgeneric num-planes (shape))
(defgeneric num-preferred-penetration-directions (shape))
(defgeneric num-vertices (shape))
(defgeneric opengl-matrix (thing))
(defgeneric origin (thing))
(defgeneric pair-cache (self))
(defgeneric perform-discrete-collision-detection (world))
(defgeneric preferred-penetration-direction (shape i penetration-vector))
(defgeneric plane (shape plane-normal plane-support i))
(defgeneric plane-equation (shape plane i))
(defgeneric ray-test (self ray<-world ray->world result-callback
                      &optional aabb-min aabb-max))
(defgeneric remove-action (world action))
(defgeneric remove-character (world character))
(defgeneric remove-collision-object (world object))
(defgeneric remove-constraint (world constraint))
(defgeneric remove-rigid-body (world body))
(defgeneric remove-vehicle (world vehicle))
(defgeneric rotation (thing))
(defgeneric set-identity (thing))
(defgeneric simulation-island-manager (world))
(defgeneric step-simulation (world time-step &optional max-sub-steps fixed-time-step)
  (:documentation
   "Perform the physics simulation.

The `WORLD' is the Dynamics World to be advanced.

The `TIME-STEP' argument is the easy one. It's simply the amount of time
by which to step the simulation. Typically, you're going to be passing
it the time since you last called it

Bullet maintains an internal clock, in order to keep the actual length
of ticks constant. This is pivotally important for framerate
independence. The third parameter --- `FIXED-TIME-STEP' --- is the size
of that internal step.

The second parameter --- `MAX-SUB-STEPS' --- is the maximum number of
steps that Bullet is allowed to take each time you call it. If you
pass a very large TIME-STEP as the first parameter (say, five times the
size of the fixed internal time step), then you must increase the
number of MAX-SUB-STEPS to compensate for this; otherwise, your
simulation will ``lose'' time.

@section How do I use this?

It's important that timeStep is always less than
maxSubSteps*fixedTimeStep, otherwise you are losing
time. Mathematically,

      \( < TIME-STEP  (* MAX-SUB-STEPS FIXED-TIME-STEP) )

When you are calculating what figures you need for your game, start by
picking the maximum and minimum framerates you expect to see. For
example, I cap my game framerate at 120f/s, I guess it might
conceivably go as low as 12f/s.

At 120f/s, the TIME-STEP I'm passing will be 1/120 of a second. The
default FIXED-TIME-STEP is 1/60 of a second. In order to meed the
equation above, TIME-STEP doesn't need to be greater than 1. At
120f/s, with 1/60 of a second per tick, you're looking at
interpolating (as opposed to more accurately simulating) one in every
two ticks.

At 12f/s, the TIME-STEP will be roughly 1/12 of a second. In order to
meet the equation above, MAX-SUB-STEPS would need to be at least
5. Every time the game spikes a little and the framerate drops lower,
I'm still losing time. So, run with 6 or 7. At 12f/s, with 1/60 of a
second per tick, you're going to be getting maybe five genuine
simulation steps every tick.

My call to STEP-SIMULATION here would therefore be

   \(STEP-SIMULATION MY-WORLD TIME-SINCE-LAST-CALL 7)

@section Any other important things to know?

@subsection Units

The first and third parameters to STEP-SIMULATION are measured in
seconds, and \emph{not} milliseconds. A common and easy mistake in
most systems is to just pass it the value returned by their system's
getTime-equivalent function, which commonly returns time in
milliseconds. However, since GET-UNIVERSAL-TIME is in seconds already,
this shouldn't be a problem.

This mistake can give strange results such as: 

@itemize

@item No framerate dependence no matter what you do.

@item Objects not moving at all until you apply a huge force and then
they give huge acceleration.

@end itemize

Simply divide the time by 1000 before passing it to stepSimulation.

@subsection FIXED-TIME-STEP resolution

By decreasing the size of FIXED-TIME-STEP, you are increasing the
``resolution'' of the simulation.

If you are finding that your objects are moving very fast and escaping
from your walls instead of colliding with them, then one way to help
fix this problem is by decreasing FIXED-TIME-STEP. If you do this,
then you will need to increase MAX-SUB-STEPS to ensure the equation
listed above is still satisfied.

The issue with this is that each internal ``tick'' takes an amount of
computation. More of them means your CPU will be spending more time on
physics, and therefore less time on other stuff. If you want twice the
resolution, you'll need twice the MAX-SUB-STEPS, which could chew up
twice as much CPU for the same amount of simulation time.

@subsection MAX-SUB-STEPS = 0 ?

If you pass MAX-SUB-STEPS 0 to the function, then it will assume a
variable tick rate. Every tick, it will move the simulation along by
exactly the TIME-STEP you pass, in a single tick, instead of a number
of ticks equal to FIXED-TIME-STEP.

This is not officially supported, and the death of determinism and
framerate independence. \emph{Don't do it}.  

@subsection Bullet interpolates stuff, a.k.a., MAX-SUB-STEPS = 1 ?

When you pass Bullet MAX-SUB-STEPS > 1, it will interpolate movement
for you. This means that if your FIXED-TIME-STEP is 3/100 units, and
you pass a TIME-STEP of 4/100, then it will do exactly one tick, and
estimate the remaining movement by 1/3. This saves you having to do
interpolation yourself, but keep in mind that MAX-SUB-STEPS needs to
be greater than 1.

@section Simulation Tick Callbacks

Every time that Bullet does a complete internal tick, it has the
ability to call a function of your choosing. This callback can happen
before the simulation step or at the end of the simulation step. Such
a callback is useful to notify other parts of your application about the
simulation or to modify velocities of bodies; for example, if you are
building a spaceship and you want each spaceship to have an individual
speed cap. No matter how many substeps Bullet will do, your spaceship
can have its speed limited at the end of every tick, which helps
framerate independance.

 @subsection How to use

The prototype function for the callback (in C++) is this: 

@example
typedef void (*btInternalTickCallback)(btDynamicsWorld *world, btScalar timeStep);
@end example

and the appropriate call to add it to the world is

@example
void btDynamicsWorld::setInternalTickCallback(btInternalTickCallback cb, 
void* worldUserInfo=0,bool isPreTick=false);
@end example"))
(defgeneric synchronize-all-motion-states-p (world))
(defgeneric synchronize-motion-states (world))
(defgeneric synchronize-single-motion-state (world body))
(defgeneric transform* (one other &optional more))
(defgeneric update-aabbs (world))
(defgeneric update-single-aabb (world object))
(defgeneric update-vehicles (world vehicle))
(defgeneric vertex (thing i vertex))
(defgeneric world-type (world))
(defgeneric world-transform (thing))


(defgeneric angular-motor-enabled-p (thing))
(defgeneric motor-target-velocity (thing))
(defgeneric max-motor-impulse (thing))
(defgeneric use-frame-offset (thing))
(defgeneric (setf use-frame-offset) (value thing))


