#!gmake

# MAIN TARGETS: all (romans-server); clean

OSNAME=$(shell uname -s)
CPU=$(shell uname -m | sed -e 's,_,-,g')

BUILDDIR=build
FASLDIR=build/$(OSNAME)/$(CPU)
LIBDIR=build/$(OSNAME)/$(CPU)

TOOLBIN=../../tools/bin
BUILDAPPSRC=../../src/tools/buildapp

DYNSPACE=4096 # MiB

all: $(BUILDDIR)/$(OSNAME)-Romance-$(CPU)

clean:
	mkdir -p $(FASLDIR)
	mkdir -p $(LIBDIR)
	mkdir -p $(BUILDDIR)
	-rm -rf $(FASLDIR)/*
	-rm -rf $(LIBDIR)/*
	-rm -rf $(BUILDDIR)/$(OSNAME)-Romance-$(CPU)
	-find . -name '*~' -exec rm -f {} \;
	-find . -name '*.fasl' -exec rm -f {} \;

$(TOOLBIN)/buildapp: $(shell find $(BUILDAPPSRC) -type f)
	$(MAKE) DESTDIR=$(shell pwd)/$(TOOLBIN)/.. -C $(BUILDAPPSRC) buildapp install

BUILDCONSTS= 	--eval "(defconstant cl-user::+BUILD-OS+ :$(OSNAME))" \
		--eval "(defconstant cl-user::+BUILD-CPU+ :$(CPU))" \
		--eval "(defconstant cl-user::+BUILD-LIBDIR+ (merge-pathnames \"$(LIBDIR)\"))"

$(BUILDDIR)/Romance.manifest:	\
		$(shell find . -name '*.lisp' -not -path '**/.*') \
		$(shell find . -name '*.asd' -not -path '**/.*')
	sbcl --no-userinit --no-sysinit --non-interactive \
		--disable-debugger \
		--load ~/quicklisp/setup.lisp \
		$(BUILDCONSTS) \
		--load setup.lisp \
		--eval '(ql:quickload :romance-ii)' \
		--eval "(ql:write-asdf-manifest-file \"$(BUILDDIR)/Romance.manifest\")"

$(BUILDDIR)/$(OSNAME)-Romance-$(CPU):	\
		$(BUILDDIR)/Romance.manifest $(TOOLBIN)/buildapp
	mkdir -p $(FASLDIR) $(LIBDIR) $(BUILDDIR) $(BUILDDIR)/$(OSNAME)-$(CPU)-bin
#	ASDF_OUTPUT_TRANSLATIONS="(:output-translations :ignore-inherited-configuration \
#		(T (lambda (pathname dir) (declare (ignored dir)) \
#		      (merge-pathnames pathname \"$(FASLDIR)\"))))" \
	$(TOOLBIN)/buildapp \
		--load ~/quicklisp/setup.lisp \
		--manifest-file $(BUILDDIR)/Romance.manifest \
		--output $(BUILDDIR)/$(OSNAME)-Romance-$(CPU) \
		--logfile $(BUILDDIR)/build.Romance.$(OSNAME).$(CPU).log \
		$(BUILDCONSTS) \
		--dispatched-entry /romance:start-server \
		--dispatched-entry romance-repl/romance:start-repl \
		--dispatched-entry galen/galen:start-server \
		--dispatched-entry appius/appius:start-server \
		--dispatched-entry asinius/asinius:start-server \
		--dispatched-entry caesar/caesar:start-server \
		--dispatched-entry lutatius/lutatius:start-server \
		--dispatched-entry narcissus/narcissus:start-server \
		--dispatched-entry clodia/clodia:start-server \
		--load setup.lisp \
		--load-system romance-ii \
		--asdf-tree . \
		--dynamic-space-size $(DYNSPACE)
	cd $(BUILDDIR)/$(OSNAME)-$(CPU)-bin; ( \
		cp ../$(OSNAME)-Romance-$(CPU) romance ; \
		for n in galen appius asinius caesar lutatius narcissus clodia ; do \
			ln -s romance $n ; done )


