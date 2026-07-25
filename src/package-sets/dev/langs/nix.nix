{
  pkgs ? import <nixpkgs> { },
  ...
}:
let
  inherit (pkgs)
    nixd
    nixfmt
    statix
    deadnix
    ;
in
[
  nixd
  nixfmt
  statix
  deadnix
]
