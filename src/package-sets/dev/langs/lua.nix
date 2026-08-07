{
  pkgs ? import <nixpkgs> { },
  ...
}:
let
  inherit (pkgs) lua-language-server luaPackages;
in
[
  lua-language-server
  luaPackages.lyaml
]
