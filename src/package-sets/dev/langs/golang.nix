{
  pkgs ? import <nixpkgs> { },
  ...
}:
with pkgs;
[
  go
  templ
  sqlc
  buf
  atlas
  # reftools
  hugo
  openapi-generator-cli
]
