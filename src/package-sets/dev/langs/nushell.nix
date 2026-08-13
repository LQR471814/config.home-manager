{
  pkgs ? import <nixpkgs> { },
  ...
}:
let
  inherit (pkgs)
    cross-stream
    # nu-lint
    nu-type-alias
    nu-type-fmt
    topiary-nushell
    ;
in
[
  cross-stream
  # nu-lint
  nu-type-alias
  nu-type-fmt
  topiary-nushell
]
