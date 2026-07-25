{
  pkgs ? import <nixpkgs> { },
  ...
}:
let
  inherit (pkgs)
    keepassxc
    gnome-clocks
    libreoffice
    anki
    bambu-studio
    cheese
    ;
in
[
  keepassxc
  gnome-clocks
  libreoffice
  anki
  bambu-studio
  cheese
]
