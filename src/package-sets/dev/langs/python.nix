{
  pkgs ? import <nixpkgs> { },
  ...
}:
with pkgs;
[
  # pipx
  ruff
  uv
  basedpyright
]
