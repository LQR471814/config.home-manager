{ pkgs ? import <nixpkgs> {}, ... }:

pkgs.stdenv.mkDerivation {
  name = "yt-dlp";
  version = "2025.01.15";
  system = "x86_64-linux";

  src = pkgs.fetchurl {
    url = "https://github.com/yt-dlp/yt-dlp/releases/download/2025.01.15/yt-dlp_linux";
    hash = "sha256-5CIlu4X0/bMyODQ1HR7nwydMhkxAFJPJ9Oh4TgovAaE=";
  };

  dontUnpack = true;

  installPhase = ''
    mkdir -p $out/bin
    cp $src $out/bin/yt-dlp
    chmod +x $out/bin/yt-dlp
  '';

  meta = {
    description = "A fork of youtube-dl.";
    homepage = "https://github.com/yt-dlp/yt-dlp";
  };
}
