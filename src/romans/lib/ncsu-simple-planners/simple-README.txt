To download the code for the simple planners, visit
<http://www.csc.ncsu.edu/faculty/stamant/simple-planners/simple-planners.html>.

GENERAL NOTES:

There are a few different ways to install this code.  The simple
planners were initially developed for teaching a course using Norvig's
Paradigms of Artificial Intelligence Programming (PAIP), and they use
some of the same coding conventions.  The design of the planners,
however, follows Russell and Norvig's Artificial Intelligence: A
Modern Approach (AIMA).  It's thus reasonable to expect the planning
code to run with either code base, and also reasonable to think that
it might run on its own.  The following sections cover all these
possibilities.  If you switch between loading methods for the system,
any existing compiled files should be deleted and the system
recompiled.

One the planners have been loaded by one of the procedures below, they
can be tested by running any or all of the following.  It takes up to
30 seconds for some of the planners to complete their runs on my
machine.

(run-planner-tests (make-instance 'propositional-POP-planner)
		   *propositional-problems-and-domains*
		   :exclude-problems '(change-rooms start-to-finish))

(run-planner-tests (make-instance 'POP-planner)
		   (append *propositional-problems-and-domains*
			   *first-order-problems-and-domains*)
		   :exclude-problems '(change-rooms start-to-finish back-and-forth))

(run-planner-tests (make-instance 'GP-planner)
		   (append *propositional-problems-and-domains*
			   *first-order-problems-and-domains*))

(run-planner-tests (make-instance 'GP-CSP-planner)
		   (append *propositional-problems-and-domains*
			   *first-order-problems-and-domains*))

(run-planner-tests (make-instance 'SAT-planner)
		   (append *propositional-problems-and-domains*
			   *first-order-problems-and-domains*))

(run-planner-tests (make-instance 'HSP-planner)
		   (append *propositional-problems-and-domains*
			   *first-order-problems-and-domains*))

These forms are also found at the end of simple-planners.lisp and in
the files that define the planners.


ASDF INSTALLATION (standalone):

If you're familiar with ASDF, the easiest way to get the simple
planners running is in standalone mode--just follow your usual
practice for where to put the files and so forth.  The planners are
loaded by default into the common-lisp-user package, but this can be
changed by editing the value of *simple-planners-package-name* in the
asd file; all the files are loaded into the package named by
*simple-planners-package-name*, via a read-time conditionalization.

Loading the system means evaluating the following (assuming that ASDF
is loaded and has the simple planners directory in its registry):

(asdf:oos 'asdf:load-op '#:simple-planners)

The planner tests should then run.


AIMA/ASDF INSTALLATION:

If you're working with Russell and Norvig's AIMA code but you prefer
the loading procedures of ASDF, you can do the following.  In the file
simple-planners.asd, uncomment the line

(pushnew :AIMA *features*)

The value of *simple-planners-package-name*, in the same file, should
be "CL-USER", because AIMA code, by default, loads into this package.

Getting everything loaded looks like this on my system (assuming that
ASDF is loaded and has the simple planners directory in its registry):

(load "/Users/stamant/systems/AIMA/aima")

(asdf:oos 'asdf:load-op '#:simple-planners)

The planner tests should then run, in the cl-user package.


PAIP/ASDF INSTALLATION:

If you're working with Norvig's PAIP code but you prefer the loading
procedures of ASDF, you can do the following.  In the file
simple-planners.asd, uncomment the line

(pushnew :PAIP *features*)

The value of *simple-planners-package-name*, in the same file, should
be "CL-USER", because PAIP code, by default, loads into this package.

Getting everything loaded looks like this on my system (assuming that
ASDF is loaded and has the simple planners directory in its registry):

(load "/Users/stamant/systems/PAIP/auxfns")

(asdf:oos 'asdf:load-op '#:simple-planners)

The planner tests should then run, in the cl-user package.


AIMA/non-ASDF INSTALLATION:

Let's say you don't know or perhaps care about ASDF, but you'd still
like to run the simple planners with the AIMA code base.  You can do
this by relying on Russell and Norvig's loading functions.  Assuming
you have the AIMA Lisp system in place, start by editing the file
"aima.lisp".  Search for the form

(def-aima-system planning ()
  "Code from Part IV: Planning and Acting"
   ("planning" / ))

and replace it with this:

(def-aima-system planning (search agents logic)
    "Code from Part IV: Planning and Acting"
  ("planning" / "aima-compatibility"
	      "simple-utilities"
	      "simple-pddl-processing"
	      "simple-problems"
	      "simple-data-structures"
	      "simple-planners"
	      "simple-pop"
	      "simple-pop-with-bindings"
	      "simple-gp"
	      "simple-gp-csp"
	      "simple-sat-solver"
	      "simple-sat"
	      "simple-hsp"))

Also add the following somewhere in aima.lisp.

(defvar *simple-planners-package-name* "CL-USER")

Unzip the simple-planners.zip archive and put all the contained files
in a planning subdirectory of the aima directory (which you may need
to create).

Getting everything loaded looks like this on my system:

(load "/Users/stamant/systems/AIMA/aima")

(aima-compile 'planning)

... and for later sessions...

(aima-load 'planning)

The planner tests should then run, in the cl-user package.

The usual (aima-load 'all) will load the planners along with
everything else.


PAIP/non-ASDF INSTALLATION:

Let's say you don't know or perhaps care about ASDF, but you'd still
like to run the simple planners with the PAIP code base.  You can do
this by relying on Norvig's loading functions.  Assuming you have the
PAIP system in place, unzip the simple-planners.zip archive and put
all the contained files in the same directory as the other PAIP files.

Getting everything loaded looks like this on my system:

(load "/Users/stamant/systems/paip/auxfns")

(requires "paip-planners")

The planner tests should then run, in the cl-user package.


-- Rob St. Amant (stamant@csc.ncsu.edu)
