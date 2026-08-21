{
  pkgs ? import <nixpkgs> { },
  ...
}:
let
  inherit (pkgs) graphviz vivify;
in
[
  graphviz
  vivify
]
