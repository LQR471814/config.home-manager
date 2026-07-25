{
  pkgs ? import <nixpkgs> { },
  ...
}:
let
  inherit (pkgs)
    btop
    powertop
    ;
in
[
  btop
  powertop
]
