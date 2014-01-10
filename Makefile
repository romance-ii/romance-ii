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

# Some of the original assets are auto-built from SWF sources using a
# multi-step process.  Where are the SWF sources kept?  These won't be
# needed indefinitely, they're just a stepping-stone for 1.0 only…
# Note that we'll probably parse the FLA files as well/instead ASAP.
SWFSOURCESDIR=src/art/

########################################################################

push:	dist/$(PROJECT)-$(VERSION).tar.xz
	scp $< $(HOST):$(DIR)
	ssh $(HOST) tar -C $(DIR) -jxvf $(DIR)/$(PROJECT)-$(VERSION).tar.xz

ALL_JS=	build/01-preamble.js	\
	build/store.js \
	build/Modernizr.js \
	build/js-lib/glge.js \
	build/gl-utils.js	\
	build/network.js	\
	build/asset-loader.js	\
	build/string-utils.js	\
	build/ui-help.js	\

ALL_CSS= src/css/base.css	\
	 src/css/text.css	\
	 src/css/game-ui.css

DISTVDIR=dist/$(PROJECT)-$(VERSION)/
SERVERDIR=dist/$(PROJECT)-server-$(VERSION)/
DISTASSETVDIR=dist/$(PROJECT)-assets-$(ASSETSVERSION)
SERVERFULLNAME=$(PROJECT)-server-$(shell uname -s)-$(shell uname -m)-$(VERSION)

dist: dist/$(PROJECT)-$(VERSION).tar.xz dist/$(PROJECT)-assets-$(ASSETSVERSION).tar.xz \
	dist/$(SERVERFULLNAME).tar.xz doc

dist/$(PROJECT)-$(VERSION).tar.xz: \
	$(DISTVDIR)/$(PROJECT).js \
	$(DISTVDIR)/$(PROJECT).css \
	$(DISTVDIR)/$(PROJECT).html \
	$(DISTVDIR)
	cp -a src/static/v $(DISTVDIR)
	cp -a src/static/help $(DISTVDIR)
	cd dist; tar jcvf -C .. $@ $(shell basename $(DISTVDIR))

dist/$(SERVERFULLNAME).tar.xz: \
	$(SERVERDIR)/bin/$(SERVERFULLNAME)
	cd dist; tar jcvf -C .. $@ $(shell basename $(SERVERDIR))

$(SERVERDIR)/bin/$(SERVERFULLNAME):	$(shell find src/romans -type f)
	$(MAKE) BUILDDIR=build/$(PROJECT)-server-$(VERSION) -C src/romans
	mkdir -p $(SERVERDIR)
	cp build/$(PROJECT)-server-$(VERSION)/$(shell uname -s)-Romance-$(shell uname -m | sed -e 's,_,-,g') \
		$@

$(DISTVDIR):
	mkdir -p $@

$(DISTVDIR)/$(PROJECT).css: \
	$(DISTVDIR) \
	build/$(PROJECT)-$(VERSION)-min.yahoo.css
	cp $(shell tools/bin/smaller $^) $@

$(DISTVDIR)/$(PROJECT).js: \
	$(DISTVDIR) \
	build/$(PROJECT)-$(VERSION)-min.yahoo.js \
	build/$(PROJECT)-$(VERSION)-min.ugly.js \
	build/$(PROJECT)-$(VERSION)-min.google.js
	cp $(shell tools/bin/smaller $^) $@
	cp build/$(PROJECT)-$(VERSION)-all.js $(DISTVDIR)/debug.js

build/01-preamble.js: src/ps/01-preamble.js
	cp $^ $@

build/%.js:	src/static/%.js
	cp $^ $@

build/js-lib/glge.js:	src/js-lib/glge/glge-compiled.js build/js-lib/glge-prefix.txt 
	mkdir -p build/js-lib
	cat build/js-lib/glge-prefix.txt $^ > $@

build/js-lib/glge-prefix.txt:	Makefile
	echo -n "/** @COPYRIGHT: " > $@

src/js-lib/glge/glge-compiled.js:	$(shell find src/js-lib/glge/src -type f)
	$(MAKE) -C src/js-lib/glge

build/%.js: src/ps/%.lisp \
	src/ps/00-macros.lisp \
	src/ps/01-preamble.js
# Brute-force: updates all JavaScript files every time
	sbcl --disable-debugger --load tools/parenscript-compile.lisp

build/$(PROJECT)-$(VERSION)-all.js: \
	$(ALL_JS)
	cat $^ > $@

build/$(PROJECT)-$(VERSION)-all.css: $(ALL_CSS)
	cat $^ > $@

build/$(PROJECT)-$(VERSION)-min.yahoo.js: \
		build/$(PROJECT)-$(VERSION)-all.js \
		tools/yuicompressor/yuicompressor.jar
	java -jar tools/yuicompressor/yuicompressor.jar \
		--type js --charset utf-8 -o $@ $<

tools/yuicompressor/yuicompressor.jar: $(shell find src/tools/yuicompressor/src -name \*java)
	src/tools/yuicompressor/bin/build
	mkdir -p tools/yuicompressor
	cp $^ $@

build/$(PROJECT)-$(VERSION)-min.ugly.js: build/$(PROJECT)-$(VERSION)-all.js
	uglifyjs $< -o $@ --source-map $@.source-map

build/$(PROJECT)-$(VERSION)-min.google.js: build/$(PROJECT)-$(VERSION)-all.js
	java -jar tools/closure-compiler/compiler.jar \
		--compilation_level ADVANCED_OPTIMIZATIONS \
		--create_source_map $(DISTVDIR)/debug.js.map \
		--js=$< --js_output_file=$@

build/$(PROJECT)-$(VERSION)-min.yahoo.css: \
	build/$(PROJECT)-$(VERSION)-all.css
	java -jar tools/yuicompressor/build/yuicompressor-2.4.8.jar \
		--type css --charset utf-8 --verbose -o $@ $<

build/$(PROJECT)-$(VERSION).html: src/$(PROJECT).html
	sed -s 's,$$VERSION,$(VERSION),' < $< > $@

build/$(PROJECT)-$(VERSION)-min.google.html: \
	build/$(PROJECT)-$(VERSION).html
	java -jar tools/htmlcompressor-1.5.3.jar -t html $< -o $@


$(DISTVDIR)/$(PROJECT).html: \
	$(DISTVDIR) \
	build/$(PROJECT)-$(VERSION)-min.google.html
	cp $(shell tools/bin/smaller $^) $@

../assets.mak:	tools/bin/make-assets $(SWFSOURCESDIR)
	tools/bin/make-assets $(SWFSOURCESDIR) > ../assets.mak

include ../assets.mak

dist/$(PROJECT)-assets-$(ASSETSVERSION).tar.xz: \
	../assets.mak \
	$(VERSIONEDASSETS)
	tar jcvf ../$@ -C build/$(PROJECT)-assets *

build/$(PROJECT)-assets/%: build/art/%
	mkdir -p `dirname $@`
	ln $< $@

%.svg:	%.swf
	tools/bin/swf2svg $< > $@ 2| tee $@.err

%.raw.dae:	%.svg
	tools/bin/svg2collada $< > $@ 2| tee $@.err

build/art/%.svg: $(SWFSOURCESDIR)/%.swf
	tools/bin/swf2svg $< > $@ 2| tee $@.err

build/art/%.svg: $(SWFSOURCESDIR)/%.fla
	tools/bin/fla2svg $< > $@ 2| tee $@.err

%.dae:	%.raw.dae
	tools/bin/minify-xml $< $@

%.ttf:	%.ttf
	cp $< $@

%.mp3:	%.mp3
	cp $< $@

%.ogg:	%.mp3
	FIXME

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
	( cd \$( dirname $< ) ; pdflatex \$( basename $< ) )

doc:	\
	doc/devel/Development-Features-Plan.html \
	doc/devel/Development-Features-Plan.txt \
	doc/devel/Development-Features-Plan.pdf

