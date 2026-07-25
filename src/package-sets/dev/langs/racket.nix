{
  pkgs ? import <nixpkgs> { },
  ...
}:
let
  inherit (pkgs) racket;
in
[
  racket
]
