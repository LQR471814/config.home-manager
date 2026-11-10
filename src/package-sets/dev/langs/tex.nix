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
    tex-fmt
    ;
in
[
  mytexlive
  texlab
  ghostscript
  libtexprintf
  ltex-ls-plus
  tex-fmt
]
