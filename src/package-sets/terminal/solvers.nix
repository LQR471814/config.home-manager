{
  pkgs ? import <nixpkgs> { },
  ...
}:
with pkgs;
[
  numbat
  libqalculate
  qucs-s
  rddlsim
  espresso-logic
  qblade
]
