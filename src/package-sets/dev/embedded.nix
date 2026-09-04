{
  pkgs ? import <nixpkgs> { },
  ...
}:
let
  inherit (pkgs)
    picocom
    ;
in
[
  picocom
]
