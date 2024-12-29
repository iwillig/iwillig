

posts/hello_world.html: src/hello_world.md
	pandoc --filter pandoc-plantuml --template template.html src/hello_world.md -o posts/hello_world.html

.PHONY: build
build: posts/hello_world.html
	haunt build
