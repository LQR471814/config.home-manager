{
  pkgs ? import <nixpkgs> { },
  ...
}:
with pkgs;
[
  keepassxc
  gnome-clocks
  libreoffice
  anki
  bambu-studio
  cheese
]
