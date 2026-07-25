{
  pkgs ? import <nixpkgs> { },
  ...
}:
let
  inherit (pkgs)
    mytexlive
    texlab
    ghostscript
    libtexprintf
    ltex-ls-plus
    ;
in
[
  mytexlive
  texlab
  ghostscript
  libtexprintf
  ltex-ls-plus
]
