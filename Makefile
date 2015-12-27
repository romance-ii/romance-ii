# MAIN TARGETS: all (dist); clean; push (to dev server)
all: dist

clean:
	-rm -rf build/*
	-rm -rf $(DISTVDIR)
	-rm -rf $(SERVERDIR)
	-find . -name \*~ -exec rm {} \;
	git submodule foreach git clean -f

include ../program.mak
include ../versions.mak
include ../license.mak
include ../push-to.mak

########################################################################

push:	dist/$(PROJECT)-$(VERSION).tar.xz
	scp $< $(HOST):$(DIR)
	ssh $(HOST) tar -C $(DIR) -jxvf $(DIR)/$(PROJECT)-$(VERSION).tar.xz

SERVERDIR=dist/$(PROJECT)-server-$(VERSION)/
SERVERFULLNAME=$(PROJECT)-server-$(VERSION).$(shell uname -s)-$(shell uname -m)

dist: dist/$(SERVERFULLNAME).tar.xz doc

dist/$(SERVERFULLNAME).tar.xz: \
	$(SERVERDIR)/bin/$(SERVERFULLNAME) \
	$(SERVERDIR)/lib/libcl-bullet2l.so
	tar -Jcvf $@ --transform='s#../dist/##' $(SERVERDIR)

$(SERVERDIR)/bin/$(SERVERFULLNAME):	$(shell find src/romans -type f)
	mkdir -p build/$(SERVERFULLNAME)-$(VERSION)/{bin,lib}	
	missed=$(egrep -v -e '^#' tools/required-rpm-packages | while read pkg; do rpm -q $pkg &>/dev/null || echo $pkg; done) ; if [ "x$missed" != x ] ; then pkcon install $missed ; fi
	BUILDDIR=../../build/$(SERVERFULLNAME)-$(VERSION)/ \
		$(MAKE) -e -C src/romans
	mkdir -p $(SERVERDIR)/bin
	ln build/$(SERVERFULLNAME)-$(VERSION)/bin/romance -f $@
	for f in build/$(SERVERFULLNAME)-$(VERSION)/bin/* ; do \
		ln -sf $(basename $@) $(SERVERDIR)/bin/$(PROJECT)-$$(basename $$f) ; done

$(SERVERDIR)/lib/libcl-bullet2l.so:	\
	$(SERVERDIR)/bin/$(SERVERFULLNAME) \
	$(shell find src/romans/lib/cl-bullet2l src/romans/lib/cl-bullet2l/bullet2 -type f)
	mkdir -p $(SERVERDIR)/lib
	ln build/$(SERVERFULLNAME)-$(VERSION)/lib/*.so -f $(SERVERDIR)/lib/



doc:
	$(MAKE) -C doc/devel all

