---
title: Using Pandoc for documentation
date: 2025-01-04 12:00
tags: pandoc, markdown, clojure
---

[Pandoc](https://pandoc.org/index.html) is a markup transformation
tool that allows you to convert from any format into any format. It's a
helpful tool for any software engineer workign in any language.

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

#### Simple transformations

Let's say you have a simple HTML document. Something like.

~~~{.html .numberLines}
!include code-examples/sample.html
~~~

One could convert that from HTML into markdown with the following command.

~~~{.bash}
cat public/about.html | pandoc -f html -t markdown
~~~

Which produces the following output

~~~{.markdown .numberLines}
## Hello

I am a professional software engineer. I am currently working at
[Shortcut](https://www.shortcut.com/) where I have been an backend
engineer for ten years.

I primarily work in [Clojure](https://clojure.org/), but have experience
with Python, JavaScript, TypeScript and other languages.

I live in Brooklyn with my family. When I am not hanging out with them,
you can find me on my bike or in a hammock

Thanks for reading my [blog](/).
~~~

Or Emacs's [Org Mode](https://orgmode.org/)

~~~{ .numberLines }
I am a professional software engineer. I am currently working at
[[https://www.shortcut.com/][Shortcut]] where I have been an backend
engineer for ten years.

I primarily work in [[https://clojure.org/][Clojure]], but have
experience with Python, JavaScript, TypeScript and other languages.

I live in Brooklyn with my family. When I am not hanging out with them,
you can find me on my bike or in a hammock

Thanks for reading my [[/][blog]].
~~~

#### Pandoc templates

Each output format has a template. You can generate the template using
Pandoc itself.

~~~{.bash}
pandoc -D html
~~~

Which outputs,

~~~{.html .numberLines}
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" lang="$lang$" xml:lang="$lang$"$if(dir)$ dir="$dir$"$endif$>
<head>
  <meta charset="utf-8" />
  <meta name="generator" content="pandoc" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=yes" />
$for(author-meta)$
  <meta name="author" content="$author-meta$" />
$endfor$
$if(date-meta)$
  <meta name="dcterms.date" content="$date-meta$" />
$endif$
$if(keywords)$
  <meta name="keywords" content="$for(keywords)$$keywords$$sep$, $endfor$" />
$endif$
$if(description-meta)$
  <meta name="description" content="$description-meta$" />
$endif$
  <title>$if(title-prefix)$$title-prefix$ – $endif$$pagetitle$</title>
  <style>
    $styles.html()$
  </style>
$for(css)$
  <link rel="stylesheet" href="$css$" />
$endfor$
$if(math)$
  $math$
$endif$
  <!--[if lt IE 9]>
    <script src="//cdnjs.cloudflare.com/ajax/libs/html5shiv/3.7.3/html5shiv-printshiv.min.js"></script>
  <![endif]-->
$for(header-includes)$
  $header-includes$
$endfor$
</head>
<body>
$for(include-before)$
$include-before$
$endfor$
$if(title)$
<header id="title-block-header">
<h1 class="title">$title$</h1>
$if(subtitle)$
<p class="subtitle">$subtitle$</p>
$endif$
$for(author)$
<p class="author">$author$</p>
$endfor$
$if(date)$
<p class="date">$date$</p>
$endif$
</header>
$endif$
$if(toc)$
<nav id="$idprefix$TOC" role="doc-toc">
$if(toc-title)$
<h2 id="$idprefix$toc-title">$toc-title$</h2>
$endif$
$table-of-contents$
</nav>
$endif$
$body$
$for(include-after)$
$include-after$
$endfor$
</body>
</html>
~~~
