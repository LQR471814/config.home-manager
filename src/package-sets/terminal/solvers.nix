{
  pkgs ? import <nixpkgs> { },
  ...
}:
let
  inherit (pkgs)
    numbat
    libqalculate
    qucs-s
    rddlsim
    espresso-logic
    ;
in
[
  numbat
  libqalculate
  qucs-s
  rddlsim
  espresso-logic
]
