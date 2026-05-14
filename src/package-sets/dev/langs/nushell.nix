{
  pkgs ? import <nixpkgs> { },
  ...
}:
with pkgs;
[
  cross-stream
  nu-lint
]
