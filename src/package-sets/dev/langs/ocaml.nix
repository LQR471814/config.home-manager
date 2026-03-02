{
  pkgs ? import <nixpkgs> { },
  ...
}:
with pkgs;
[
  # dune
  # ocaml
  # ocamlPackages.ocaml-lsp
  # ocamlPackages.utop
  # ocamlPackages.odoc
  # ocamlPackages.ocamlformat
]
