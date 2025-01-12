{ pkgs ? import <nixpkgs> {}, ... }:

pkgs.stdenv.mkDerivation {
  name = "dwm";

  src = pkgs.fetchFromGitHub {
    owner = "LQR471814";
    repo = "dwm";
    rev = "f019eea9d97861c19cd44f51c094daee06e46f71";
    hash = "sha256-dRIkcvypVn+Wy4F0ebPQIdc32VGyDkIqY1AxmVtCfQU=";
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
