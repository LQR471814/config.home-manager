{
  pkgs ? import <nixpkgs> { },
  ...
}:
with pkgs;
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
