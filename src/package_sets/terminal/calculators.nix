{
  pkgs ? import <nixpkgs> { },
  ...
}:
with pkgs;
[
  numbat
  libqalculate
  qucs-s
  (import ../derivations/rddlsim.nix ctx)
  (import ../derivations/espresso-logic.nix ctx)
]
