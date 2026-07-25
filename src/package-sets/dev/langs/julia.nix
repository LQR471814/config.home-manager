{
  pkgs ? import <nixpkgs> { },
  ...
}:
let
  inherit (pkgs) julia-bin;
in
[
  julia-bin
]
