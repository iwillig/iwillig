(use-modules (haunt asset)
             (haunt site)
             (haunt builder flat-pages)
             (haunt builder blog)
             (haunt builder atom)
             (haunt builder assets)
             (haunt reader)
             (haunt reader commonmark)
             (haunt artifact)
             (haunt builder blog)
             (haunt html)
             (haunt post)
             (haunt site)
             (ice-9 match)
             (srfi srfi-19)
             (haunt site))

(define a-link
  (lambda (str-name href)
    `(a (@ (href ,href)) ,str-name)))

(define nav-items
  (lambda ()
    `(nav (@ (class "nav"))
          (ul (@ (class "nav-list"))
              (li (@ (class "nav-item"))
                  (a (@ (href "/about.html")
                        (class "pure-menu-link"))
                     "About"))

              (li (@ (class "nav-item"))
                  (a (@ (href "/")
                        (class "pure-menu-link"))
                     "Blog"))

              (li (@ (class "nav-item"))
                  (a (@ (href "/static/resume.html")
                        (class "pure-menu-link"))
                     "Resume"))))))


(define side-bar
  (lambda (site)
    `(div (@ (class "pure-u-1 pure-u-md-1-4 sidebar"))
          (div (@ (class ""))
               (a
                (@ (href "/"))
                (h1 (@ (class ""))
                      ,(site-title site)))

               ,(nav-items)))))

(define render-body
  (lambda (body)
    `(div (@ (class "pure-u-1 pure-u-md-3-4 content"))
          ,body)))

(define render-layout
  (lambda (site title body)
    `((doctype "html")
      (head
       (meta (@ (name "viewport")
                (content "width=device-width")
                (initial-scale "1")))

       (meta (@ (charset "utf-8")))
       (meta (@ (name "description")
                (content ,(site-title site))))

       (link (@ (rel "stylesheet")
                (href "https://cdn.jsdelivr.net/npm/purecss@3.0.0/build/pure-min.css")))

       (link (@ (rel "stylesheet")
                (href "https://cdn.jsdelivr.net/npm/purecss@3.0.0/build/grids-responsive-min.css")))

       (link (@ (rel "stylesheet")
                (href "css/site.css")))

       (link (@ (rel "stylesheet")
                (href "css/highlighting.css"))))

      (body

       (div (@ (class "pure-g")
               (id "layout"))

            ,(side-bar site)
            ,(render-body body))))))

(define render-post
  (lambda (post)
    `((article
       (div (@ (class "post"))
            (h2 ,(post-ref post 'title))
            (div ,(date->string (post-date post)
                                "~B ~d, ~Y"))
            (div (@ (class "pure-menu pure-menu-horizontal"))
                 "Tags:"
                 (ul (@ (class "pure-menu-list"))
                  ,@(map (lambda (tag)
                           `(li
                             (@ (class "pure-menu-item"))
                             (a (@ (href ,(string-append "/feeds/tags/"
                                                         tag ".xml"))
                                   (class "pure-menu-link"))
                                ,tag)))
                         (assq-ref (post-metadata post) 'tags))))
            ,(post-sxml post))))))

(define (post-uri site prefix post)
  (string-append prefix "/" (site-post-slug site post) ".html"))


(define (first-paragraph post)
  (let loop ((sxml (post-sxml post)))
    (match sxml
      (() '())
      (((and paragraph ('p . _)) . _)
       (list paragraph))
      ((head . tail)
       (cons head (loop tail))))))


(define render-collection
  (lambda (site title posts prefix)
    `((h2 ,title)
      ,(map (lambda (post)
              (let ((uri (post-uri site prefix post)))
                `(article
                  (h3 (a (@ (href ,uri))
                         ,(post-ref post 'title)))
                  (div (@ (class "date"))
                       ,(date->string (post-date post)
                                      "~B ~d, ~Y"))
                  (div (@ (class "post"))
                       ,(first-paragraph post))
                  (a (@ (href ,uri)) "read more →"))))
            posts))))

(define software-wanderings-theme
  (theme #:name "software-wanderings"
         #:layout              render-layout
         #:post-template       render-post
         #:collection-template render-collection))


(site #:title "Software Wanderings"
      #:domain "iwillig.github.io"

      #:default-metadata
      '((author . "Ivan Willig")
        (email  . "iwillig@gmail.com"))

      #:build-directory "public"

      #:readers  (list commonmark-reader html-reader)
      #:builders (list (blog #:theme software-wanderings-theme)

                       (flat-pages "pages"
                                   #:template (theme-layout software-wanderings-theme))

                       (atom-feed)
                       (atom-feeds-by-tag)
                       (static-directory "css")
                       (static-directory "static")
                       (static-directory "images")))
