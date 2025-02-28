{ pkgs ? import <nixpkgs> {}, ... }:

pkgs.stdenv.mkDerivation {
  name = "dwm";

  src = pkgs.fetchFromGitHub {
    owner = "LQR471814";
    repo = "dwm";
    rev = "9bd42fa40a853a07af63285ae54476174bc29fd2";
    hash = "sha256-5xx5Jobk7qjMjeSN7E2vfWdIYt3HWnvGQ8JlxyxsKjs=";
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
