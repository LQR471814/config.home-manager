{
  pkgs ? import <nixpkgs> { },
  ...
}:
let
  inherit (pkgs)
    ruff
    uv
    ty
    ;
in
[
  # pipx
  ruff
  uv
  ty
]
