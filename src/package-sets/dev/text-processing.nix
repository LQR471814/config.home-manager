{
  pkgs ? import <nixpkgs> { },
  ...
}:
with pkgs;
[
  cloc
  ripgrep
  fd
  ast-grep
  croc
  jq
  fzf
  tree-sitter
  htmlq
]
