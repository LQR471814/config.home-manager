{
  pkgs ? import <nixpkgs> { },
  ...
}:
let
  inherit (pkgs)
    cargo
    rustc
    rust-analyzer
    ;
in
[
  cargo
  rustc
  rust-analyzer
]
