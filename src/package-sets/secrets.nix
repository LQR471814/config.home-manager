{
  pkgs ? import <nixpkgs> { },
  ...
}:
let
  inherit (pkgs)
    sops
    gnupg
    kdePackages
    pinentry-qt
    ;
in
[
  sops
  gnupg
  kdePackages.kleopatra
  pinentry-qt
]
