XSLTPROC = xsltproc

XSL-NS-SS = http://docbook.sourceforge.net/release/xsl-ns/current/

generate: main.docbook
	$(XSLTPROC) \
		--xinclude \
		--stringparam base.dir public/ \
		--stringparam chunk.toc chunk.toc \
		--stringparam section.autolabel 1 \
		--stringparam collect.xref.targets "yes" \
		--stringparam toc.section.depth 1 \
		--stringparam targets.filename "$(patsubst %.xhtml,%.olinkdb,$@)" \
		stylesheets/flameeyes.eu.xsl \
		$<

chunk.toc.new:
	$(XSLTPROC) \
		--output $@ \
		--xinclude \
		--stringparam chunk.section.depth 8 \
		--stringparam chunk.first.sections 1 \
		--stringparam use.id.as.filename 1 \
		$(XSL-NS-SS)/xhtml-1_1/maketoc.xsl \
		main.docbook

clean:
	rm -f *~ *.olinkdb
	find public -name '*.html' -delete

.PHONY: generate chunk.toc.new clean

