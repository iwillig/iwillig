.PHONY: publish
publish:
	haunt build
	git push origin `git subtree split --prefix docs origin gh-pages`:gh-pages --force
