{
  pkgs ? import <nixpkgs> { },
  ...
}:
let
  inherit (pkgs) graphviz;
in
[
  graphviz
]
