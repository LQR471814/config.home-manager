{ pkgs ? import <nixpkgs> {}, ... }:

pkgs.stdenv.mkDerivation {
  name = "dwmblocks";

  src = pkgs.fetchFromGitHub {
    owner = "LQR471814";
    repo = "dwmblocks-async";
    rev = "4223adbe3479f6538555a351bc8c9713fb0a8c88";
    hash = "sha256-rK2klE6KsLWCHLODEc32+tn7d9+QWyitRD6hHjpwuYY=";
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
