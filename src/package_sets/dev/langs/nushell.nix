ctx@{
  pkgs ? import <nixpkgs> { },
  ...
}:
let
  nu-lint = import ../../../derivations/nu-lint.nix ctx;
in
with pkgs;
[
  cross-stream
  nufmt
  nu-lint
]
