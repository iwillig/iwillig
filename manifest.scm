(use-modules (gnu packages autotools)
             (gnu packages base)
             (gnu packages uml)
             (gnu packages web)
             (gnu packages guile)
             (gnu packages emacs)
             (gnu packages emacs-xyz)
             (gnu packages haskell-xyz)
             (gnu packages guile-xyz)
             (gnu packages pkg-config)
             (gnu packages rsync)
             (gnu packages texinfo)
             (guix git-download)
             (guix packages)
             (guix profiles)
             (guix utils))

(define haunt*
  (let ((commit "2b8268683ad2406b38500cde18210100df67b745"))
    (package
     (inherit haunt)
     (source (origin
              (method git-fetch)
              (uri (git-reference
                    (url "https://git.dthompson.us/haunt.git")
                    (commit commit)))
              (sha256
               (base32
                "1dz0r5lds8dhzvk6x0qslq3q098vcw1ifyr6m27vlk67d5fxgpdm"))))
     (native-inputs
      (list automake autoconf pkg-config texinfo))
     (inputs
      (list rsync guile-3.0-latest))
     (arguments
      (substitute-keyword-arguments (package-arguments haunt)
        ((#:phases phases)
         `(modify-phases ,phases
            (add-after 'unpack 'bootstrap
              (lambda _
                (invoke "sh" "bootstrap"))))))))))

(packages->manifest
 (list guile-3.0-latest
       ;; plantuml This does not work with c4 diagrams because
       ;; plantuml can't seem to access the internet.
       emacs
       emacs-geiser
       emacs-geiser-guile
       pandoc
       jq
       tidy-html
       gnu-make
       haunt*))
