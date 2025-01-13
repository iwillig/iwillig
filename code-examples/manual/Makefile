.DEFAULT_GOAL := docs.html

docs.html: *.md
	pandoc metadata.yml \
	--toc --toc-depth=5 \
	--template templates/template.html \
	--highlight-style zenburn \
	-F pandoc-plantuml \
	-f markdown -t html \
	sections/introduction.md \
    	sections/architecture.md \
	-o docs.html

.PHONY:
clean:
	-rm docs.html
	-rm plantuml-images/*.svg
	-rm plantuml-images/*.uml
