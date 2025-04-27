{ pkgs ? import <nixpkgs> {}, ... }:

pkgs.stdenv.mkDerivation {
  name = "dwmblocks";

  src = pkgs.fetchFromGitHub {
    owner = "LQR471814";
    repo = "dwmblocks-async";
    rev = "7abb83db049f37860579a2969925312355f4fd8e";
    hash = "sha256-URh3QC8q7JMXm+alkCy20rMHuyIUpkB+osm6+WozTPc=";
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
