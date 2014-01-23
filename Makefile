#!gmake

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
SERVERFULLNAME=$(PROJECT)-server-$(shell uname -s)-$(shell uname -m)-$(VERSION)

dist: dist/$(SERVERFULLNAME).tar.xz doc

dist/$(SERVERFULLNAME).tar.xz: \
	$(SERVERDIR)/bin/$(SERVERFULLNAME)
	cd dist; tar jcvf -C .. $@ $(shell basename $(SERVERDIR))

$(SERVERDIR)/bin/$(SERVERFULLNAME):	$(shell find src/romans -type f)
	$(MAKE) BUILDDIR=build/$(PROJECT)-server-$(VERSION) -C src/romans
	mkdir -p $(SERVERDIR)
	cp build/$(PROJECT)-server-$(VERSION)/$(shell uname -s)-Romance-$(shell uname -m | sed -e 's,_,-,g') \
		$@

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
	texi2any --info --force $< -o $@

%.html:  %.texi	
	texi2any --html --split=section --css-ref=romance2.css --force $< -o $@

%.pdf:	%.texi
	texi2any --pdf --force $< -o $@

%.ps:	%.texi
	texi2any --ps --force $< -o $@

%.txt:	%.texi
	texi2any --plaintext --force $< -o $@

doc:	\
	doc/devel/The-Book-of-Romance.pdf \
	doc/devel/The-Book-of-Romance.info