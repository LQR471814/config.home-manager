{
  pkgs ? import <nixpkgs> { },
  ...
}:
with pkgs;
[
  mytexlive
  texlab
  ghostscript
  libtexprintf
  ltex-ls-plus
]
