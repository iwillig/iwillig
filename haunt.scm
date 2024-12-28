(use-modules (haunt asset)
             (haunt site)
             (haunt builder blog)
             (haunt builder atom)
             (haunt builder assets)
             (haunt reader commonmark)
             (haunt site))

(site #:title "Software Ramblings"
      #:domain "iwillig.me"
      #:default-metadata
      '((author . "Ivan Willig")
        (email  . "iwillig@gmail.com"))

      #:build-directory "public"

      #:readers  (list commonmark-reader)
      #:builders (list (blog)
                       (atom-feed)
                       (atom-feeds-by-tag)
                       (static-directory "css")
                       (static-directory "images")))
