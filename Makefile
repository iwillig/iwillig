.DEFAULT_GOAL := build

css/highlighting.css:
	 pandoc --highlight-style zenburn --template=./templates/highlighting.css src/hello_world.md -t html -o css/highlighting.css

posts/hello_world.html: src/hello_world.md
	pandoc --filter pandoc-plantuml --filter pandoc-include --template templates/template.html src/hello_world.md -o posts/hello_world.html



.PHONY: hbuild
hbuild: posts/hello_world.html
	haunt build

CNAME: hbuild
	cp CNAME public/CNAME

.PHONY: build
build: CNAME


.PHONY: clean
clean:
	-rm css/highlighting.css
