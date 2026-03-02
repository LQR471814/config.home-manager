{
  pkgs ? import <nixpkgs> { },
  fix-pw,
  ...
}:
with pkgs;
[
  ardour
  (fix-pw musescore)
  (fix-pw easyeffects)
  blender
  kdePackages.kdenlive
  gimp3
  inkscape
  scribus
  freecad

  linvstmanager
  pwvucontrol # audio patcher
  qpwgraph
]
