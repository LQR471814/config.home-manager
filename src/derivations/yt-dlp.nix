{ pkgs ? import <nixpkgs> {}, ... }:

pkgs.stdenv.mkDerivation {
  name = "yt-dlp";
  version = "2025.09.26";
  system = "x86_64-linux";

  src = pkgs.fetchurl {
    url = "https://github.com/yt-dlp/yt-dlp/releases/download/2025.09.26/yt-dlp_linux";
    hash = "sha256-0vBzghOPS9iCJUmWUCY29aZ6jF7lq4olgH4nhKSHhkI=";
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
