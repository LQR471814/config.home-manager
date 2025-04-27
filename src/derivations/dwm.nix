{ pkgs ? import <nixpkgs> {}, ... }:

pkgs.stdenv.mkDerivation {
  name = "dwm";

  src = pkgs.fetchFromGitHub {
    owner = "LQR471814";
    repo = "dwm";
    rev = "ea76daadde7ed753b069e2b876ef72db2266b3e0";
    hash = "sha256-nFA3dfZViTWDG3qXuLElB7YkVnhdMM+9NeZKjYea2c4=";
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
