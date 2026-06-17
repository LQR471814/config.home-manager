{
  pkgs ? import <nixpkgs> { },
  ...
}:
with pkgs;
[
  kubectl
  kind
  k9s

  # lazydocker
  # wineWowPackages.stable
  # winetricks
]
