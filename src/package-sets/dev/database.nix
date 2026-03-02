{
  pkgs ? import <nixpkgs> { },
  ...
}:
with pkgs;
[
  sqlite
  redis
]
