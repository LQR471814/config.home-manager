{
  pkgs ? import <nixpkgs> { },
  ...
}:
let
  inherit (pkgs)
    zathura
    vlc
    mpv
    imv
    rhythmbox
    foliate
    zotero
    ;
in
[
  zathura # pdf viewer
  vlc # media viewer
  mpv # media viewer
  imv # image viewer
  rhythmbox # music player
  foliate # epub viewer

  zotero
  # rdfglance
  # miru
]
