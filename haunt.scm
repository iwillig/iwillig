(use-modules (haunt asset)
             (haunt site)
             (haunt builder blog)
             (haunt builder atom)
             (haunt builder assets)
             (haunt reader commonmark)
             (haunt site))

(site #:title "Ivan Willig's Blog"
      #:domain "iwillig.me"
      #:default-metadata
      '((author . "Ivan Willig")
        (email  . "iwillig@gmail.com"))
      #:build-directory "docs"
      #:readers (list commonmark-reader)
      #:builders (list (blog)
                       (atom-feed)
                       (atom-feeds-by-tag)
                       (static-directory "css")
                       (static-directory "images")))
