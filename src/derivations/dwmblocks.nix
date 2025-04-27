{ pkgs ? import <nixpkgs> {}, ... }:

pkgs.stdenv.mkDerivation {
  name = "dwmblocks";

  src = pkgs.fetchFromGitHub {
    owner = "LQR471814";
    repo = "dwmblocks-async";
    rev = "c39377269b9691413663b73278c3149f3fb94727";
    hash = "sha256-EfIZ3CzCRR8XzjaRqLa/SjZ0CoEX0+u0RldNKpWg+EQ=";
  };

  prePatch = ''
    sed -i "s@/usr/local@$out@" Makefile
  '';

  buildInputs = with pkgs; [
    pkg-config
    xorg.libxcb
    xorg.xcbproto
    xorg.xcbutil
  ];
  makeFlags = [ "CC=${pkgs.stdenv.cc.targetPrefix}cc" ];

  meta = {
    homepage = "https://github.com/LQR471814/dwmblocks-async";
    description = "My fork of dwmblocks-async.";
  };
}
