{
  pkgs ? import <nixpkgs> { },
  ...
}:
with pkgs;
[
  zathura # pdf viewer
  vlc # media viewer
  imv # image viewer
  rhythmbox # music player
  foliate # epub viewer
  (import ./src/derivations/zotero.nix ctx)
  (import ./src/derivations/rdfglance.nix ctx)
  (import ./src/derivations/houdoku.nix ctx)
  # miru
]
