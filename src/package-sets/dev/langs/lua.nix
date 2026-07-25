{
  pkgs ? import <nixpkgs> { },
  ...
}:
let
  inherit (pkgs) lua-language-server;
in
[
  lua-language-server
]
