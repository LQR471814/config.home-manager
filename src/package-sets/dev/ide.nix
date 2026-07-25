{
  pkgs ? import <nixpkgs> { },
  ...
}:
let
  inherit (pkgs) dbeaver-bin;
in
[
  # eclipses.eclipse-cpp
  dbeaver-bin
]
