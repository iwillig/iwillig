.DEFAULT_GOAL := build

css/highlighting.css:
	 pandoc --highlight-style zenburn --template=./templates/highlighting.css src/hello_world.md -t html -o css/highlighting.css

posts/hello_world.html: src/hello_world.md
	pandoc --filter pandoc-plantuml --filter pandoc-include --template templates/template.html src/hello_world.md -o posts/hello_world.html


resume.html: src/resume.yml templates/resume.html
	pandoc --template templates/resume.html src/resume.yml -t html -o resume.html

.PHONY: hbuild
hbuild: posts/hello_world.html
	haunt build

CNAME: hbuild css/highlighting.css
	cp CNAME public/CNAME

.PHONY: build
build: CNAME


.PHONY: clean
clean:
	-rm css/highlighting.css
	-rm resume.html
