---
title: Hello, World
date: 2024-12-28 12:00
tags: design, software, ffp, writing, system-design
---

Welcome to Software Wanderings, my new technical blog. I hope this
blog will encourage me to write about my experiences, learnings and
observations about software engineering. I am also making this blog
public and hopefully other people will find some of this useful.

This blog is going to cover software design, functional programming,
API design and more. It will focus on the Clojure programming
language, but should include other languages like JavaScript,
TypeScript, Rust, Scheme and SQL.

I have several goals for 2025, and I will be using this blog to record
my efforts in reaching these goals.

### 2025 Goals

~~~{ .plantuml plantuml-filename=images/goals.svg }
@startmindmap
* 2025 Goals
** Game Development
*** Godot
*** LWJGL
** Immutable Linux Distros
*** GNU Guix
*** Fedora Sliverblue
** Pandoc
** API
*** GraphQL
*** REST API
@endmindmap
~~~

I hope to learn or better understand the following software systems.

1. **Learn about Game Development**: Since I was a kid and playing Red Alert at my
   friend John's house I have wanted to build a Command and Conquer or
   StarCraft like game. I want to make 2025 the year when I finally
   understand game development and build something.
2. **Learn more about Immutable Linux**: Understand and better use immutable Linux
   distros. NixOS, Gnu Guix, Fedora Sliverblue are all modern
   "immutable" distributions.
3. **Deepen my understanding of Pandoc**: Pandoc is an advance
   document transformation system. It allows you to convert any
   document into any other document. It also includes a
   "transformation" system that allow you to modify documents.
4. **Deepen my understanding Rest API and GraphQL API**: Continue to
   learn and write about the best ways to design and build these type
   of API Systems.
5. **Write about it!**: Hence the blog.

### Blog Architecture

This blog is host on GitHub, using GitHub pages. The blog uses
[Haunt](https://dthompson.us/projects/haunt.html) to build and
organize our HTML Templates. Most of my understanding of Haunt comes
from [David Thompson's own blog](https://dthompson.us/). Thanks to
David for both writing Haunt and sharing his own blog.


Currently, I am using [Pandoc](https://pandoc.org/) to preprocess
Markdown documents into HTML documents. These HTML documents are then
processed by Haunt. Haunt supports Markdown, but I am using Pandoc's
render instead of Haunt for now.

I am doing this for a couple of reason. It's mainly because Pandoc
offers a more advanced system for generating diagrams for code
blocks. Pandoc also support code highlighting for much more language
than Haunt currently support. Lastly, learning about Pandoc is also
one of my 2025 goals.

I'm also using [GNU Make](https://www.gnu.org/software/make/) to build
the blog system. It is fine, but a well known thing. Classic example
of a boring technology.

Finally, I am attempting to use [GNU Guix](https://guix.gnu.org/) to
manage my dependencies. However, my usage GNU Guix is only partly
successful as of Dec 2024.

#### C1 Diagram

This is a [C1](https://c4model.com/diagrams/system-context) diagram of
my blog system. Not super helpful but you can see we are using GitHub
to host the blog. Hey, you the reader are there. We are building
software with people first.

~~~{ .plantuml plantuml-filename=images/blog_c_1.svg }
@startuml
!include https://raw.githubusercontent.com/plantuml-stdlib/C4-PlantUML/master/C4_Container.puml

Person(personAlias, "Reader", "A person who wants to read my blog")

System_Boundary(sw, "GitHub Infra") {
    Container(app, "Blog APP", "App", "A HTML App for display blog posts.")
}

Rel(personAlias, app, "Views blog posts")

@enduml
~~~

#### C2 Diagram

This is a [C2 Diagram](https://c4model.com/diagrams/container) for the
blogging system. We are using a GitHub git repo for storage, and
GitHub's build system to deploy changes. Pushes to the `main` branch
currently trigger a new build and deploy to "production".

~~~{ .plantuml plantuml-filename=images/blog_c_2.svg }
@startuml
!include https://raw.githubusercontent.com/plantuml-stdlib/C4-PlantUML/master/C4_Container.puml

Person(personAlias, "Reader", "A person who wants to read my blog.")
Person(author, "Author", "A person who wants to write blog posts.")

System_Boundary(github, "Github Infra") {

    Container(gitHubPage, "Github Pages", "App", "Serve the HTML for the blog")
    Container(gitHubAction, "Github Actions", "Actions", "Builds HTML documents and pushes to a branch")
    ContainerDb(gitRepo, "Git Repo", "Container Git", "Stores blog posts")

}

Rel(personAlias, gitHubPage, "Views blog posts")
Rel(author, gitRepo, "Commits new HTML Documents")
Rel_L(gitRepo, gitHubAction, "New commits trigger GitHub actions")
Rel_L(gitHubAction, gitHubPage, "Actions trigger the pages app to rebuild")

@enduml
~~~

#### Dependencies and GNU Guix

I am trying to use Gnu Guix to manage my dependencies. Currently,
plantuml and its friends are not working with Guix. For now, I am just
using fedora and [pipx](https://github.com/pypa/pipx) to manage those
dependencies.

```bash
## Install pandoc
dnf install pipx plantuml
## Install pandoc filters
pipx install pandoc-plantuml-filter pandoc-include

## Load enviorment with guix
guix shell
## Rebuild the site locally
make build
## Run a local server
haunt serve
```

This is an example of the current `manifest.scm` file for this
blog. You can see that I am using a commit from github for Haunt. I
need a few things that are unreleased in Haunt, so I am pulling it in
via git. This is what David's blog does, and my blog is pinned against
the same commit as his.

```scheme
!include manifest.scm
```


Thats most of it for now. Thanks for reading.
