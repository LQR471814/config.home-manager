{
  pkgs ? import <nixpkgs> { },
  ...
}:
with pkgs;
[
  cross-stream
  nu-lint
  nu-type-alias
  topiary-nushell
]
