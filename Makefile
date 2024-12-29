

posts/hello_world.html: src/hello_world.md
	pandoc --template template.html src/hello_world.md -o posts/hello_world.html

.PHONY: build
build: posts/hello_world.html
	haunt build
