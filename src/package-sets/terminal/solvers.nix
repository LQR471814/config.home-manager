{
  pkgs ? import <nixpkgs> { },
  ...
}:
let
  inherit (pkgs)
    numbat
    libqalculate
    qucs-s
    ngspice
    rddlsim
    espresso-logic
    ;
in
[
  numbat
  libqalculate
  qucs-s
  ngspice
  rddlsim
  espresso-logic
]
