{
  pkgs ? import <nixpkgs> { },
  ...
}:
with pkgs;
[
  mytexlive
  texlab
  ghostscript

  ltex-ls-plus
]
