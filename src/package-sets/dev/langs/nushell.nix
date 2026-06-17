{
  pkgs ? import <nixpkgs> { },
  ...
}:
with pkgs;
[
  cross-stream
  nu-lint
  nu-type-alias
  nu-type-fmt
  topiary-nushell
]
