---
title: Using Pandoc to build a technical manual
date: 2025-01-04 12:00
tags: pandoc, markdown, clojure
---

This guide is going to walk you through building a "technical manual"
with [Pandoc](https://pandoc.org/index.html). For our goals, the
technical manual will be a collection of Markdown documents with
[PlantUML](https://plantuml.com/) diagrams. We will use Pandoc to
combine these documents into a single HTML page and render the
PlantUML diagrams as SVG images.

[Pandoc](https://pandoc.org/index.html) is a markup transformation
tool that allows you to convert from any format into any format. It's a
helpful tool for any software engineer working in any language.

#### Install

You can install Pandoc on MacOS with homebrew

~~~{.bash}
brew install pandoc
~~~

On Fedora with

~~~{.bash}
sudo dnf install pandoc
~~~

Or with Guix

~~~{.bash}
guix install pandoc
~~~

#### Introduction to Pandoc

Let's say you have a simple HTML document. Something like.

~~~{.html .numberLines}
!include code-examples/sample.html
~~~

One could convert that from HTML into markdown with the following command.

~~~{.bash}
## Both of these work, you can reference a file as a parameter
## and Pandoc happily accepts input from standard in.

pandoc -f html -t markdown public/about.html

cat public/about.html | pandoc -f html -t markdown
~~~

Which produces the following output

~~~{.markdown .numberLines}
!include code-examples/sample.md
~~~

Or Emacs's [Org Mode](https://orgmode.org/)

~~~{ .numberLines }
!include code-examples/sample.org
~~~

Pandoc also have a native and JSON output format. When you select
this, the raw AST that Pandoc generates from your document is
returned. Let's take a quick peak at this AST.

~~~{.bash}
pandoc code-examples/sample.html -f html -t json | jq > code-examples/sample.json
~~~

~~~{.json .numberLines }
!include`startLine=1, endLine=40` code-examples/sample.json
~~~

We can clearly see now Pandoc is a transformation system. It parses a
document into its native AST. It then has a set of printers that take
that AST and render the document into that format.

~~~
INPUT --reader--> AST --filter--> AST --writer--> OUTPUT
~~~


| Transform Step | What's happening |
|----------------|------------------|
| reader         |                  |
| filter         |                  |
| writer         |                  |

Taken from the [Pandoc Website](https://pandoc.org/filters.html)

#### Combining documents

Let's say you have a couple of markdown documents that you want to
combine into a single document. Pandoc makes this pretty easy. Lets
say you have a folder called `docs`. In that folder you have three
markdown documents. We are going to combine then into a single
markdown file.

~~~{.bash}
pandoc -t markdown -o all-docs.md \
    001-introduction.md \
    002-install.md \
    003-system-context-diagram.md
~~~

#### Using Pandoc filters


#### Pandoc templates

Each output format has a template. You can generate the template using
Pandoc itself.

~~~{.bash}
pandoc -D html
~~~

Which outputs the following template. You can read more about Pandoc's
template synatx
[here](https://pandoc.org/chunkedhtml-demo/6.1-template-syntax.html).

~~~{.html .numberLines}
!include`startLine=1, endLine=10` code-examples/sample-html-template.html
~~~
