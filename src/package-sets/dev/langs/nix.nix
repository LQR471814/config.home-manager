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
    vulnix
    ;
in
[
  nixd
  nixfmt
  statix
  deadnix
  vulnix
]
