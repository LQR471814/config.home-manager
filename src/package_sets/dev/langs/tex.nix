ctx@{
  pkgs ? import <nixpkgs> { },
  ...
}:
let
  mytexlive = import ../../../derivations/mytexlive.nix ctx;
in
with pkgs;
[
  mytexlive
  texlab
  ghostscript

  ltex-ls-plus
]
