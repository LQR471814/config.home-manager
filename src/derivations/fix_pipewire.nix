{ pkgs ? import <nixpkgs> { }, ... }:
{ name, package, bin }:

pkgs.stdenv.mkDerivation {
  name = name + "-pw";

  buildInputs = [
    pkgs.pipewire.jack
    package
  ];

  dontUnpack = true;

  installPhase = ''
    mkdir -p $out/bin
    echo "${pkgs.pipewire.jack}/bin/pw-jack ${package}/bin/${bin}" > $out/bin/${bin}
    chmod +x $out/bin/${bin}
  '';
}
