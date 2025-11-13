{
  pkgs ? import <nixpkgs> { },
  ...
}:

let
  rddlsim = import ./rddlsim.nix { inherit pkgs; };
in
pkgs.stdenv.mkDerivation {
  name = "prost";
  system = "x86_64-linux";

  src = pkgs.fetchgit {
    url = "https://github.com/LQR471814/prost.git";
    rev = "558067d901c16624b3d2375c27f0a73113641bac";
    hash = "sha256-ZDY1jChWjs1O2Sh7TEWWaUYjDhkyeTqSyqUL/kLC5R0=";
  };

  buildInputs =
    (with pkgs; [
      bison
      flex
      buddy
      z3
    ])
    ++ [ rddlsim ];

  nativeBuildInputs = with pkgs; [
    pkg-config
    autoconf
    automake

    cmake
    clang
    git
    python3
  ];

  buildPhase = ''
    export RDDLSIM_ROOT="${rddlsim}/bin/rddlsim"
    python3 build.py
  '';

  installPhase = '''';
}
