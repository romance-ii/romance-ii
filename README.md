# Romance Ⅱ MMORPG Game System

## What does it do?

*Romance* is a server platform  (and, with this release, we're beginning
to  provide  client  software  and  libraries  as  well)  for  massively
multiplayer  online rôle-playing  games (MMORPG).  Romance provides  a(n
increasing) number of facilities  for open, persistent multi-user worlds
that  make it  easier for  game designers  and programmers  to not  kill
one another.

That is: the  design of Romance is  such that the design of  the game is
meant to be very, very well-isolated from the game engine code itself.

In  addition, Romance  is being  designed to  be very  modular, allowing
multiple  games  to  be  developed  while  sharing  the  cost/effort  of
maintaining the infrastructural code.

See below for a list of major functions that Romance provides.

## Where does it live?

That's a bit complicated, right now.

The canonical project page is via SourceForge:

http://sourceforge.net/p/romance

 * Note  that  the Romance  Ⅱ  project  is  a  "branch" off  the  older,
   less-capable  (but still  usable) Romance  1 project  on SourceForge;
   make sure you have the branch you want.

The Git sources  are accessible via GitHub, or  mirrored at SourceForge;
the GitHub archive is the preferred source, today.

http://github.com/romance-ii/romance-ii

Information or assistance gladly provided; write romance2@star-hope.org

## Why the name?

The original component was just the network socket server (sorta), which
was  named Appius  Claudius Caecus  (Appius for  short) after  the Roman
consul who famously built the Appian Way. As more components were added,
we followed  the style  of naming  them after  other famous  Romans with
more-or-less appropriate mappings to the purpose of that module.

The  English adjective  ROMANCE  has  many meanings,  one  of which  is,
"related  to  something  Roman,"  as  in  the  Romance  Languages  being
languages derived from Latin.

So, the Romance  project is the project which is  related to the Romans,
which in this case, are software modules.

## Sub-Projects

The overall Romance project has two parallel/orthogonal divisions.

One is between the CORE and LOCAL parts.

The  other is  between the  server-side software,  the various  possible
client-side programs, and the  operational components like documentation
and systems administration tasks.

Thus, there are potentially six major areas: the cross-product of

     (core local) × (server client(,client…) ops)

The Core components only are  discussed here. Local components are those
particular to "your" own game.

### Clients

 * The   Parenthetical    WebGL   client    is   a    game-play   client
   application. It's written in Parenscript  and uses GLGE for its WebGL
   implementation,  and a  combination of  WebSockets and  XML/JSON AJAX
   requests for communication with the server(s).

### Server Components

The Romance Ⅱ Server Core consists of:

 * APPIUS:  Appius Claudius  Caecus,  the main  networking component  or
   "socket server."   Appius manages network listening  sockets, using a
   few different possible communications channels.
 * ASINIUS: Gaius Asinius Pollio, the  database module. While Romance II
   does   not  "constantly   ride   the  database,"   for  purposes   of
   failure-proofing and conserving  RAM, it *does* rely  upon a Postgres
   database  back-end for  its  persistent storage  of game-world  data,
   which can also be used by  reporting tools to generate ad-hoc queries
   about the game world.
 * CAESAR: Gaius Julius  Caesar, the module which  monitors and controls
   all other components. Caesar is being extended to have the ability to
   bring  up  and down  other  services,  as  well as  provide  "health"
   monitoring of them.
 * CATULLUS:  Gaius Valerius  Catullus, which  translates between  plain
   written text forms  of language and the  internal "propositions" used
   by  the  game. It  enables  the  game  server (and  particularly,  AI
   characters)  to   create  English  (and  someday,   other  languages)
   sentences from these "propositions," and  parses human text back into
   "propositional" form.
 * CLODIA:   Clodia  Metelli   Pulcher,   the  server   for  "real"   AI
   characters. "Real AI" meaning that these are artificially intelligent
   logical  agents,  capable  of  establishing  and  seeking  goals  for
   themselves,  operating upon  the  game world  in the  same  way as  a
   player-character might;  these are  not "scripted  AI's" of  the sort
   which carry out a fixed task repeatedly.
 * FRONTINUS: Frontinus  handles water cycles  and weather for  the game
   world,  and  (somewhat  tangentially)  heavenly  bodies  of  the  sky
   (i.e. phases of the moon, apparent motion of the sun, moon(s), stars)
   as well. Frontinus  applies a basic model to the  flow and current of
   rivers  and  streams,  waves  in   lakes  and  seas,  and  cloud  and
   precipitation patterns, as well as wind forces.
 * GALEN: Aelius Galenus, a system for quiescing and burgeoning areas of
   the game  world; that  is, it  stops actively  performing simulations
   upon areas  that no-one can  see, but  then "spins up,"  or burgeons,
   that   area   before  a   character   enters   it,  performing   some
   "fast-forward"  actions to  bring  it  up to  date.  This works  with
   Vitruvius, Rabirius, and Frontinus.
 * LUTATIUS:   Gaius  Lutatius   Catulus,  the   module  which   handles
   "equipment" of various kinds; this  is the inventory, "use item," and
   so forth controller.
 * NARCISSUS:  Narcissus is  an adapter/wrapper  for the  Bullet physics
   system, and applies Bullet's rigid-  and soft-body physics to objects
   in the game world. This replaces the Dawson-Pocock physics model, but
   some elements  of that  model are being  re-introduced to  reduce the
   potential CPU overhead.
   * Due to development delays in  the tooling of Narcissus, development
     of  the  Narcissus  Bullet  integration has  been  halted  for  the
     forseeable future.
 * RABIRIUS:  Rabirius  is  the  module  responsible  for  handling  the
   geometry of the  game world's "map," i.e. inanimate  objects, such as
   the ground, rocks,  and (in concert with  Vitruvius) plants. Rabirius
   can  also  automatically  generate  terrain areas  based  upon  vague
   details, allowing  a game designer to  "sketch" a loose map  and have
   the  game  system fill  in  the  finer  points. This  works  together
   with Frontinus.
 * REGILLUS:  Lucius  Aemilius   Regillus,  which  performs  pathfinding
   through the  game's 3D  environment. Regillus  understands "difficult
   terrain"  and   can  provide  pathfinding  using   "acrobatics"  when
   necessary (e.g. jumping)
 * VITRUVIUS:  Marcus Vitruvius  Pollio,  which  manages the  biological
   simulation  for plants  and  animals.  Vitruvius handles  "biological
   stats" like health,  strength, and stamina, as well  as morphology of
   the animal/plant's body, and can use a simple genetics/heredity model
   to produce new life-forms based upon their parentage.

## Major External Dependencies

 * Bullet Physics (required only for Narcissus, and not presently being
   used, in fact)
 * GLGE WebGL library
 * GNU Make
 * LaTeX
 * Linux Containers
 * Parenscript
 * Quicklisp and various libraries, including Buildapp
 * Steel Bank Common Lisp (SBCL)
 * ZeroMQ (0MQ)

Also, primary development of Parenthetical is being performed using only
Firefox  at  present, although  other  browsers  are being  ocassionally
tested and we do intend to support as many as plausible.
 
## Getting Started

Since you're presumably a programmer, suffice to say that you can name
everything, whatever you like, but here's an example of spinning up a
blank, server-only project.

    cd ~/Projects
    mkdir My-New-Project
    cd My-New-Project
    git init
    git submodule add git@github.com:romance-ii/romance-ii ./Romance-II
    git submodule init
    cd Romance-II
    git checkout Romance-2
    cp doc/devel/project-skel/* ..
    make doc
    xdg-open doc/devel/The-Book-of-Romance.pdf
    emacsclient ~/Projects/My-New-Project/*.mak

I also recommend checking out your Unreal project for your front-end as
a submodule under the same parent.

