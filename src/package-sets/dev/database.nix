{
  pkgs ? import <nixpkgs> { },
  ...
}:
let
  inherit (pkgs)
    sqlite
    trailbase
    sqls
    dbeaver-bin
    markdowndb
    ;
in
[
  sqlite
  # redis
  trailbase
  sqls
  dbeaver-bin
  markdowndb
]
