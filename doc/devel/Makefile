.PHONY: clean

all: book

clean:
	rm -rf genr/*
	rm -f  *.pdf *.html *.info
	rm -f *.aux *.cp *.fn *.fns *.ky *.log *.pg *.toc *.tp *.tps *.vr
	rm -f autodocs.texi
	rm -f include-stamp

# include-stamp: ../../src/**/*.lisp ../../src/**/*.asd
# 	sbcl \
# 	--eval '(let ((asdf:*central-registry* (cons #p"../../src/romans" asdf:*central-registry*))) (require :sb-texi))' \
# 	--eval '(sb-texi:generate-includes "include/" (list :sb-texi) :base-package :sb-texi)' \
# 	--eval '(quit)'
# 	touch include-stamp

# autodocs.texi: ../../src/**/*.lisp ../../src/**/*.asd
# 	sbcl \
# 	--eval '(let ((asdf:*central-registry* (cons #p"../" asdf:*central-registry*))) (require :sb-texi))' \
# 	--eval '(sb-texi:document-package ' $pkg  ' :standalone nil :title "' $pkgname '" :output-file "' $pkg '.texi")' \
# 	--eval '(quit)'

%.html: %.texi style.css include-stamp
	makeinfo --html --no-split --css-include=style.css $<

%.pdf: %.texi include-stamp
	texi2dvi -p $<

%.info: %.texi include-stamp
	makeinfo --no-split $<

html:	The-Book-of-Romance.html.d/index.html
#sb-texi.html document-package-sample.html

pdf:	The-Book-of-Romance.pdf
#sb-texi.pdf document-package-sample.pdf

info:	The-Book-of-Romance.info
#sb-texi.info document-package-sample.info



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
	cd $(shell dirname $< ) && texi2any --info --force $(shell basename $<) -o $(shell ../../tools/bin/relative-to $< $@)

%.html.d:  %.texi	
	cd $(shell dirname $< ) && texi2any --html --split=section \
		--css-ref=romance2-doc.css --force \
		$(shell basename $<) -o $(shell ../../tools/bin/relative-to $< $@)

%.pdf:	%.texi
	cd $(shell dirname $< ) && texi2any --pdf --force $(shell basename $<) -o $(shell ../../tools/bin/relative-to $< $@)

%.ps:	%.texi
	cd $(shell dirname $< ) && texi2any --ps --force $(shell basename $<) -o $(shell ../../tools/bin/relative-to $< $@)

%.txt:	%.texi
	cd $(shell dirname $< ) && texi2any --plaintext --force $(shell basename $<) -o $(shell ../../tools/bin/relative-to $< $@) 

book: The-Book-of-Romance.pdf \
	The-Book-of-Romance.ps \
	The-Book-of-Romance.info \
	The-Book-of-Romance.html.d

The-Book-of-Romance.info:  The-Book-of-Romance.texi
	cd genr; texi2any --info --force $< -o ../$@

The-Book-of-Romance.html.d:  The-Book-of-Romance.texi	
	cd genr; texi2any --html --split=section \
		--css-ref=romance2-doc.css --force \
		$< -o $@

The-Book-of-Romance.pdf:	The-Book-of-Romance.texi
	cd genr; texi2any --pdf --force $< -o ../$@

The-Book-of-Romance.ps:	The-Book-of-Romance.texi
	cd genr; texi2any --ps --force $< -o ../$@

The-Book-of-Romance.txt:	The-Book-of-Romance.texi
	texi2any --plaintext --force $< -o ../$@ 
