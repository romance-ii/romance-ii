#!gmake

# MAIN TARGETS: all (romans-server); clean

OSNAME=$(shell uname -s)
CPU=$(shell uname -m | sed -e 's,_,-,g')

BUILDDIR=$(shell if [ "x$BUILDDIR" != "x" ] ; then echo "$BUILDDIR"; else build/$(OSNAME)-$(CPU); fi)
FASLDIR=$(BUILDDIR)/fasls
LIBDIR=$(BUILDDIR)/lib

TOOLBIN=../../tools/bin
BUILDAPPSRC=../../src/tools/buildapp

DYNSPACE=4096 # MiB

all: \
		$(BUILDDIR)/bin/romance \
		$(BUILDDIR)/bin/romance-repl \
		$(BUILDDIR)/bin/galen \
		$(BUILDDIR)/bin/appius \
		$(BUILDDIR)/bin/asinius \
		$(BUILDDIR)/bin/caesar \
		$(BUILDDIR)/bin/lutatius \
		$(BUILDDIR)/bin/narcissus \
		$(BUILDDIR)/bin/clodia \
		
#		$(BUILDDIR)/lib/libbulletphysics.so ??

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

BUILDCONSTS=--eval "(defconstant cl-user::+BUILD-OS+ :$(OSNAME))" \
		--eval "(defconstant cl-user::+BUILD-CPU+ :$(CPU))" \
		--eval "(defconstant cl-user::+BUILD-LIBDIR+ (merge-pathnames \"$(LIBDIR)\"))"

$(BUILDDIR)/Romance.manifest:	\
		$(shell find . -name '*.lisp' -not -path '**/.*') \
		$(shell find . -name '*.asd' -not -path '**/.*')
	mkdir -p $(BUILDDIR)
	sbcl --no-userinit --no-sysinit --non-interactive \
		--disable-debugger \
		--load ~/quicklisp/setup.lisp \
		$(BUILDCONSTS) \
		--load setup.lisp \
		--eval '(progn (ql:quickload :romance-ii)(ql:write-asdf-manifest-file "'$(BUILDDIR)/Romance.manifest'"))'

$(BUILDDIR)/$(OSNAME)-Romance-$(CPU):	\
		$(BUILDDIR)/Romance.manifest $(TOOLBIN)/buildapp
	mkdir -p $(FASLDIR) $(LIBDIR) $(BUILDDIR) $(BUILDDIR)/bin $(BUILDDIR)/lib
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
	
$(BUILDDIR)/bin/romance: $(BUILDDIR)/$(OSNAME)-Romance-$(CPU)
	ln -f $< $@

$(BUILDDIR)/bin/romance-repl: $(BUILDDIR)/$(OSNAME)-Romance-$(CPU)
	ln -f $< $@

$(BUILDDIR)/bin/galen: $(BUILDDIR)/$(OSNAME)-Romance-$(CPU)
	ln -f $< $@

$(BUILDDIR)/bin/appius: $(BUILDDIR)/$(OSNAME)-Romance-$(CPU)
	ln -f $< $@

$(BUILDDIR)/bin/asinius: $(BUILDDIR)/$(OSNAME)-Romance-$(CPU)
	ln -f $< $@

$(BUILDDIR)/bin/caesar: $(BUILDDIR)/$(OSNAME)-Romance-$(CPU)
	ln -f $< $@

$(BUILDDIR)/bin/lutatius: $(BUILDDIR)/$(OSNAME)-Romance-$(CPU)
	ln -f $< $@

$(BUILDDIR)/bin/narcissus: $(BUILDDIR)/$(OSNAME)-Romance-$(CPU)
	ln -f $< $@

$(BUILDDIR)/bin/clodia: $(BUILDDIR)/$(OSNAME)-Romance-$(CPU)
	ln -f $< $@



