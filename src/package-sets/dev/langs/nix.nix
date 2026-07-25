{
  pkgs ? import <nixpkgs> { },
  ...
}:
let
  inherit (pkgs)
    nixd
    nixfmt
    ;
in
[
  nixd
  nixfmt
]
