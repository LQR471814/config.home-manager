{ pkgs ? import <nixpkgs> {}, ... }:

pkgs.stdenv.mkDerivation {
  name = "dwm";

  src = pkgs.fetchFromGitHub {
    owner = "LQR471814";
    repo = "dwm";
    rev = "bdafc86ffff41f9ed7cd6716c9906f39461ea40f";
    hash = "sha256-LO6QZcC9vPSu1XhujcUd5iDN/mIpYoCOxDVxseYjco0=";
  };

  prePatch = ''
    sed -i "s@/usr/local@$out@" config.mk
  '';

  buildInputs = with pkgs.xorg; [ libX11 libXinerama libXft ];
  makeFlags = [ "CC=${pkgs.stdenv.cc.targetPrefix}cc" ];

  meta = {
    homepage = "https://github.com/LQR471814/dwm";
    description = "My fork of dwm.";
  };
}
