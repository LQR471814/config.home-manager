{
  pkgs ? import <nixpkgs> { },
  ...
}:
let
  inherit (pkgs) zulu;
in
[
  zulu
]
