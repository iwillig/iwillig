# iwillig

A haunt based blogging system.

## Install

Using GNU Guix should be enough. You can install the depdencies via
GNU Guix via the guix shell command.

```shell
guix shell
```

You will need to install the pandoc-plantuml and pandoc-include
filters. These do not work with the pandoc version in Guix. You will
also need to install pandoc.

## Publish

```shell
guix shell
make build
```
