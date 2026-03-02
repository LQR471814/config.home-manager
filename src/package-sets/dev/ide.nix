{
  pkgs ? import <nixpkgs> { },
  ...
}:
with pkgs;
[
  eclipses.eclipse-cpp
  dbeaver-bin
  usbimager
]
