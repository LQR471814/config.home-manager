{ pkgs ? import <nixpkgs> {}, ... }:

pkgs.stdenv.mkDerivation {
  name = "yt-dlp";
  version = "2025.09.26";
  system = "x86_64-linux";

  src = pkgs.fetchurl {
    url = "https://github.com/yt-dlp/yt-dlp/releases/download/2025.12.08/yt-dlp_linux";
    hash = "sha256-RX8/Kob3R6XzuGCBO3rCiCjCj5L3yQMMmYC2nGY3hZ8=";
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
