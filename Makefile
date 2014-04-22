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
	BUILDDIR=../../build/$(SERVERFULLNAME)-$(VERSION)/ \
		$(MAKE) -e -C src/romans
	mkdir -p $(SERVERDIR)/bin
	ln build/$(SERVERFULLNAME)-$(VERSION)/bin/romance -f $@
	for f in build/$(SERVERFULLNAME)-$(VERSION)/bin/* ; do \
		ln -sf $@ $(SERVERDIR)/bin/$(PROJECT)-$$(basename $$f) ; done

$(SERVERDIR)/lib/libcl-bullet2l.so:	\
	$(SERVERDIR)/bin/$(SERVERFULLNAME) \
	$(shell find src/romans/lib/cl-bullet2l src/romans/lib/cl-bullet2l/bullet2 -type f)
	mkdir -p $(SERVERDIR)/lib
	ln build/$(SERVERFULLNAME)-$(VERSION)/lib/*.so -f $(SERVERDIR)/lib/




%.txt:	%.org
	emacs --batch -q -nw \
		--load doc/batch-export.el \
		--visit $< \
		--funcall org-ascii-export-to-ascii

%.html:	%.org
	emacs --batch -q -nw \
		--load doc/batch-export.el \
		--visit $< \
		--funcall org-html-export-to-html

%.tex:	%.org
	emacs --batch -q -nw \
		--load doc/batch-export.el \
		--visit $< \
		--funcall org-latex-export-to-latex

%.pdf:	%.tex
	( cd $(shell dirname $< ) ; pdflatex $(shell basename $< ) ) < /dev/null

%.info:  %.texi
	cd $(shell dirname $< ) && texi2any --info --force $(shell basename $<) -o $(shell tools/bin/relative-to $< $@)

%.html.d:  %.texi	
	cd $(shell dirname $< ) && texi2any --html --split=section \
		--css-ref=romance2-doc.css --force \
		$(shell basename $<) -o $(shell tools/bin/relative-to $< $@)

%.pdf:	%.texi
	cd $(shell dirname $< ) && texi2any --pdf --force $(shell basename $<) -o $(shell tools/bin/relative-to $< $@)

%.ps:	%.texi
	cd $(shell dirname $< ) && texi2any --ps --force $(shell basename $<) -o $(shell tools/bin/relative-to $< $@)

%.txt:	%.texi
	cd $(shell dirname $< ) && texi2any --plaintext --force $(shell basename $<) -o $(shell tools/bin/relative-to $< $@) 
 
doc:	\
	doc/devel/The-Book-of-Romance.pdf \
	doc/devel/The-Book-of-Romance.info \
	doc/devel/The-Book-of-Romance.html.d
