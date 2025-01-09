{ pkgs ? import <nixpkgs> {}, ... }:

pkgs.stdenv.mkDerivation {
  name = "dwm";

  src = pkgs.fetchFromGitHub {
    owner = "LQR471814";
    repo = "dwm";
    rev = "f94531d47604db20c2b31efb4a270f7aba681064";
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
