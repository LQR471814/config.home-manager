{
  pkgs ? import <nixpkgs> {},
  ...
}:
pkgs.stdenv.mkDerivation {
  name = "please-build";
  version = "v17.27.0";
  system = "x86_64-linux";

  src = pkgs.fetchurl {
    url = "https://github.com/thought-machine/please/releases/download/v17.27.0/please_17.27.0_linux_amd64.tar.gz";
    hash = "sha256-1dXPeIprcuUOjLXbMppmpzWkxYfIBu32ZK+ke/3v+wk=";
  };

  installPhase = ''
    mkdir -p $out/bin
    cp * $out/bin
  '';

  meta = {
    description = "A simple build tool.";
    homepage = "https://please.build";
  };
}
