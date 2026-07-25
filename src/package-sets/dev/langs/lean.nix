{
  pkgs ? import <nixpkgs> { },
  ...
}:
let
  inherit (pkgs) elan;
in
[
  elan
]
