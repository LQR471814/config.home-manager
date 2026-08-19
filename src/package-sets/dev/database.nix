{
  pkgs ? import <nixpkgs> { },
  ...
}:
let
  inherit (pkgs)
    sqlite
    trailbase
    sqls
    ;
in
[
  sqlite
  # redis
  trailbase
  sqls
]
