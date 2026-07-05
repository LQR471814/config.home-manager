{
  pkgs ? import <nixpkgs> { },
  ...
}:
with pkgs;
[
  zathura # pdf viewer
  vlc # media viewer
  mpv # media viewer
  imv # image viewer
  rhythmbox # music player
  foliate # epub viewer

  zotero
  # rdfglance
  houdoku
  # miru
]
