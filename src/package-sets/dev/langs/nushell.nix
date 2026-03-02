{
  pkgs ? import <nixpkgs> { },
  ...
}:
with pkgs;
[
  cross-stream
  nufmt
  nu-lint
]
