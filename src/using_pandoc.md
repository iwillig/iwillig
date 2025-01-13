---
title: Using Pandoc to build a technical manual
date: 2025-01-04 12:00
tags: pandoc, markdown, clojure
---

[Pandoc](https://pandoc.org/index.html) is a markup transformation
tool that allows you to convert from any format into any format. It's
a helpful tool for any software engineer working in any language.

This guide is going to walk you through building a "technical manual"
with [Pandoc](https://pandoc.org/index.html). For our goals, the
technical manual will be a collection of Markdown documents with
[PlantUML](https://plantuml.com/) diagrams. We will use Pandoc to
combine these documents into a single HTML page and render the
PlantUML diagrams as SVG images. We will use pandoc filters to render
PlantUML diagrams and to include source code from your project.

The goal is to give you the reader enough understanding of Pandoc to
build your own documentation system with Pandoc.

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

One could convert that from HTML into markdown with the following
command.

~~~{.bash}
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
!include`startLine=40, endLine=60` code-examples/sample.json
~~~

We can clearly see now Pandoc is a transformation system. It parses a
document into its native AST. It then has a set of printers that take
that AST and render the document into that format.

~~~
INPUT --reader--> AST --filter--> AST --writer--> OUTPUT
~~~


Taken from the [Pandoc Website](https://pandoc.org/filters.html)

#### Building your technical document

Now that we understand the basics of how Pandoc works, we are going to
use it to build a technical manual. We have three main goals with this
manual. We want to use PlantUML to draw diagram and we want to be able
to include code fragments in our main document. Also we want to use
Markdown for our content.

- PlantUML based digrams
- Include code modules
- Markdown based

#### Setup

We want to use a Markdown file for each section. We are going to use a
Makefile to build our document into a single HTML document. These are
just examples and feel free to use what you want to build
software. The rough structure for our manual will be as follows.

- **Makefile**
- **metadata.yml**
- **sections/introduction.md**
- **sections/architecture.md**

First, let's create a Pandoc metadata file. Pandoc uses yaml for
metadata. You can include the metadata in a file or in a separate
file.


Create a file called **metadata.yml** with the following content.

~~~{.yaml .numberLines}
!include code-examples/manual/metadata.yml
~~~

After that, let's add a simple **Makefile** for the project. Something
like the following.

~~~{.makefile .numberLines}
!include code-examples/manual/Makefile
~~~

You can see on line 10 and 11 we reference an introduction.md and
architecture.md document.



#### Using Pandoc filters



#### Pandoc templates

Each output format has a template. You can generate the template using
Pandoc itself.

~~~{.bash}
pandoc -D html
~~~

Which outputs the following template. You can read more about Pandoc's
template syntax
[here](https://pandoc.org/chunkedhtml-demo/6.1-template-syntax.html).

~~~{.html .numberLines}
!include`startLine=1, endLine=10` code-examples/sample-html-template.html
~~~
