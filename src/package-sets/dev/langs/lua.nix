{
  pkgs ? import <nixpkgs> { },
  ...
}:
with pkgs;
[
  lua-language-server
]
