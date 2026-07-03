{
  pkgs ? import <nixpkgs> { },
  fix-pw,
  ...
}:
with pkgs;
[
  blender
  kdePackages.kdenlive
  gimp3
  inkscape
  scribus
  freecad
  calculix-ccx
  gmsh
]
