{
  pkgs ? import <nixpkgs> { },
  ...
}:
let
  inherit (pkgs)
    kubectl
    kind
    k9s
    ;
in
[
  kubectl
  kind
  k9s

  # lazydocker
  # wineWowPackages.stable
  # winetricks
]
