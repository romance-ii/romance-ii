########################################################################
# Configuration Cards

# Options to build front-end clients would be here.

# The web-based front-end
# Parenthetical: Javascript
#MAKEWEBFRONT=t
#WEBFRONT=Parenthetical-Tortoise
#WEBVERSION=0.1.2

# Talos: Android
#MAKETALOS=t
#TALOSNAME=Talos-Tortoise
#TALOSVERSION=0.0.1
#TALOSDIR=Talos-Tortoise
#TALOSTOUCHDIR=Talos-Tortoise/Touch
#TALOSOUYADIR=Talos-Tortoise/Ouya
#TALOSTOUCHDIST=../dist/os/Linux/Android/Touch
#TALOSOUYADIST=../dist/os/Linux/Android/OUYA

# Proserpina: Native binaries (Lin/Mac/Win)
#MAKEPROSERPINA=t
#PROSERPINADIR=Pomegranate
#PROSERPINAVERSION=0.0.1

# Unreal Engine front-ends
#MAKEUNREAL=t
UNREALPROJECT=UnrealEngine
UNREALSTAGING=UnrealStaging

########################################################################

# Some of the original assets are auto-built from SWF sources using a
# multi-step process.  Where are the SWF sources kept?  These won't be
# needed indefinitely, they're just a stepping-stone for 1.0 only…
# Note that we'll probably parse the FLA files as well/instead ASAP.
SWFSOURCESDIR=../art/game/


