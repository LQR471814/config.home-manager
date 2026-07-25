{
  pkgs ? import <nixpkgs> { },
  ...
}:
let
  inherit (pkgs)
    sqlite
    trailbase
    ;
in
[
  sqlite
  # redis
  trailbase
]
