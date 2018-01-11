#!gmake

# MAIN TARGETS: all (romans-server); clean

OSNAME=$(shell uname -s)
CPU=$(shell uname -m | sed -e 's,_,-,g')

BUILDDIR=$(shell if [ "x$$BUILDDIR" != "x" ] ; then echo "$$BUILDDIR"; else echo build/$(OSNAME)-$(CPU); fi)
FASLDIR=$(BUILDDIR)/fasls
LIBDIR=$(BUILDDIR)/lib
BINDIR=$(BUILDDIR)/bin

TOOLBIN=../../tools/bin
BUILDAPPSRC=../../src/tools/buildapp

DYNSPACE=4096 # MiB

BINS=		$(BINDIR)/romance2 \
		$(BINDIR)/romance-repl \
		$(BINDIR)/galen \
		$(BINDIR)/catullus \
		$(BINDIR)/appius \
		$(BINDIR)/asinius \
		$(BINDIR)/caesar \
		$(BINDIR)/lutatius \
		$(BINDIR)/narcissus \
		$(BINDIR)/clodia

#		$(BUILDDIR)/lib/libbulletphysics.so ??

SOLIBS=	# $(LIBDIR)/libcl-bullet2l.so	\
# 	$(LIBDIR)/libLinearMath.so	\
# 	$(LIBDIR)/libBulletCollision.so	\
# 	$(LIBDIR)/libBulletDynamics.so	\
# 	$(LIBDIR)/libBulletSoftBody.so

all: $(SOLIBS) $(BINS)

clean:
	mkdir -p $(FASLDIR)
	mkdir -p $(LIBDIR)
	mkdir -p $(BINDIR)
	-rm -rf $(FASLDIR)/*
	-rm -rf $(LIBDIR)/*
	-rm -rf $(BINDIR)/*
	-rm -rf $(BUILDDIR)/$(OSNAME)-Romance-$(CPU)
	-find . -name '*~' -exec rm -f {} \;
	-find . -name '*.fasl' -exec rm -f {} \;
	make -C lib/cl-bullet2l

$(TOOLBIN)/buildapp: $(shell find $(BUILDAPPSRC) -type f)
	$(MAKE) DESTDIR=$(shell pwd)/$(TOOLBIN)/.. -C $(BUILDAPPSRC) buildapp install

BUILDCONSTS=--eval "(defconstant cl-user::+BUILD-OS+ :$(OSNAME))" \
		--eval "(defconstant cl-user::+BUILD-CPU+ :$(CPU))" \
		--eval "(defconstant cl-user::+BUILD-LIBDIR+ (merge-pathnames \"$(LIBDIR)\"))"

$(LIBDIR)/libcl-bullet2l.so: lib/cl-bullet2l/libcl-bullet2l.so
	-rm -f $@
	cp -f $< $@

$(LIBDIR)/libLinearMath.so:	lib/cl-bullet2l/bullet2/ld/lib/libLinearMath.so
	-rm -f $@
	cp -f $< $@

$(LIBDIR)/libBulletCollision.so:	lib/cl-bullet2l/bullet2/ld/lib/libBulletCollision.so
	-rm -f $@
	cp -f $< $@

$(LIBDIR)/libBulletDynamics.so:	lib/cl-bullet2l/bullet2/ld/lib/libBulletDynamics.so
	-rm -f $@
	cp -f $< $@

$(LIBDIR)/libBulletSoftBody.so:	lib/cl-bullet2l/bullet2/ld/lib/libBulletSoftBody.so
	-rm -f $@
	cp -f $< $@


lib/cl-bullet2l/libcl-bullet2l.so:
	$(MAKE) -C lib/cl-bullet2l

lib/cl-bullet2l/bullet2/ld/lib/libLinearMath.so:
	$(MAKE) -C lib/cl-bullet2l

lib/cl-bullet2l/bullet2/ld/lib/libBulletCollision.so:
	$(MAKE) -C lib/cl-bullet2l

lib/cl-bullet2l/bullet2/ld/lib/libBulletDynamics.so:
	$(MAKE) -C lib/cl-bullet2l

lib/cl-bullet2l/bullet2/ld/lib/libBulletSoftBody.so:
	$(MAKE) -C lib/cl-bullet2l



$(BUILDDIR)/Romance.manifest:	\
		$(shell find . -name '*.lisp' -not -path '**/.*') \
		$(shell find . -name '*.asd' -not -path '**/.*')
	echo "Generating Manifest of Lisp library dependencies from Quicklisp…"
	mkdir -p $(BUILDDIR)
	sbcl --no-userinit --no-sysinit --non-interactive \
		--disable-debugger \
		--load ~/quicklisp/setup.lisp \
		$(BUILDCONSTS) \
		--load setup.lisp \
		--eval '(progn (ql:quickload :romance-ii)(ql:write-asdf-manifest-file "'$(BUILDDIR)/Romance.manifest'"))'

$(BUILDDIR)/$(OSNAME)-Romance-$(CPU):	\
		$(BUILDDIR)/Romance.manifest $(TOOLBIN)/buildapp
	echo "Compiling $@ and dependencies through BUILDAPP…"
	mkdir -p $(FASLDIR) $(LIBDIR) $(BINDIR)
#	ASDF_OUTPUT_TRANSLATIONS="(:output-translations :ignore-inherited-configuration \
#		(T (lambda (pathname dir) (declare (ignored dir)) \
#		      (merge-pathnames pathname \"$(FASLDIR)\"))))" \

	$(TOOLBIN)/buildapp \
		--load ~/quicklisp/setup.lisp \
		--manifest-file $(BUILDDIR)/Romance.manifest \
		--output $(BUILDDIR)/$(OSNAME)-Romance-$(CPU) \
		--logfile $(BUILDDIR)/build.Romance.$(OSNAME).$(CPU).log \
		$(BUILDCONSTS) \
		--dispatched-entry /romans:start-server \
		--dispatched-entry romance-repl/romans:start-repl \
		--dispatched-entry galen/galen:start-server \
		--dispatched-entry appius/appius:start-server \
		--dispatched-entry asinius/asinius:start-server \
		--dispatched-entry caesar/caesar:start-server \
		--dispatched-entry catullus/catullus:start-server \
		--dispatched-entry lutatius/lutatius:start-server \
		--dispatched-entry narcissus/narcissus:start-server \
		--dispatched-entry clodia/clodia:start-server \
		--load setup.lisp \
		--load-system romance-ii \
		--asdf-tree . \
		--dynamic-space-size $(DYNSPACE)

$(BINDIR)/romance2: $(BUILDDIR)/$(OSNAME)-Romance-$(CPU)
	ln -f $< $@

$(BINDIR)/romance-repl: $(BUILDDIR)/$(OSNAME)-Romance-$(CPU)
	ln -f $< $@

$(BINDIR)/galen: $(BUILDDIR)/$(OSNAME)-Romance-$(CPU)
	ln -f $< $@

$(BINDIR)/appius: $(BUILDDIR)/$(OSNAME)-Romance-$(CPU)
	ln -f $< $@

$(BINDIR)/catullus: $(BUILDDIR)/$(OSNAME)-Romance-$(CPU)
	ln -f $< $@

$(BINDIR)/asinius: $(BUILDDIR)/$(OSNAME)-Romance-$(CPU)
	ln -f $< $@

$(BINDIR)/caesar: $(BUILDDIR)/$(OSNAME)-Romance-$(CPU)
	ln -f $< $@

$(BINDIR)/lutatius: $(BUILDDIR)/$(OSNAME)-Romance-$(CPU)
	ln -f $< $@

$(BINDIR)/narcissus: $(BUILDDIR)/$(OSNAME)-Romance-$(CPU)
	ln -f $< $@

$(BINDIR)/clodia: $(BUILDDIR)/$(OSNAME)-Romance-$(CPU)
	ln -f $< $@



