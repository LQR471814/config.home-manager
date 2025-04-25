{ pkgs ? import <nixpkgs> {}, ... }:

pkgs.stdenv.mkDerivation {
  name = "dwmblocks";

  src = pkgs.fetchFromGitHub {
    owner = "LQR471814";
    repo = "dwmblocks-async";
    rev = "97ba8cee40052f1b30b03c7378ae36e3b4613095";
    hash = "sha256-6rainfPvCeTjX6VTNgoJO8TnAJzB/Qw4FXcqWmUE8os=";
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
    homepage = "https://github.com/LQR471814/dwm";
    description = "My fork of dwm.";
  };
}
