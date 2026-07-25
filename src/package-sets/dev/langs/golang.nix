{
  pkgs ? import <nixpkgs> { },
  ...
}:
let
  inherit (pkgs)
    go
    gopls
    templ
    sqlc
    buf
    atlas
    hugo
    openapi-generator-cli
    ;
in
[
  go
  gopls
  templ
  sqlc
  buf
  atlas
  # reftools
  hugo
  openapi-generator-cli
]
