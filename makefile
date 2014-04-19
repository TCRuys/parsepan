# parsepan - makefile

all: parsepan.html parsepan.pdf

parsepan.html: parsepan.1
	echo "<meta http-equiv=\"Content-Type\" content=\"text/html;charset=utf-8\" />" > $@
	echo "<head>" >> $@
	echo "  <style type=\"text/css\"> " >> $@
	echo "    h2 { font-size: 100% }" >> $@
	echo "  </style>" >> $@
	echo "</head>" >> $@
	echo "<body>\n" >> $@
	nroff -man -c -Tascii $< | man2html -bare -nodepage >> $@
	echo "</body>" >> $@

# On Mac OS X, nroff is emulated with GNU's groff.
# The "-c" option is needed to force nroff to use the old 
# output scheme which man2html relies on.

parsepan.ps: parsepan.1
	groff -man -Tps $< > $@

parsepan.pdf: parsepan.ps
	ps2pdf $<

clean: 
	rm -r -f pan.* pan _spin_nvr.tmp
	rm -f parsepan.ps

very_clean: clean
	rm parsepan.html parsepan.pdf
