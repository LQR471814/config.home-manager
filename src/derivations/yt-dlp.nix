{
  final,
  prev,

  stdenv,
  fetchurl,
}:

let
  version = "2026.10.26";
in
stdenv.mkDerivation {
  name = "yt-dlp";
  inherit version;
  system = "x86_64-linux";

  src = fetchurl {
    url = "https://github.com/yt-dlp/yt-dlp/releases/download/${version}/yt-dlp_linux";
    hash = "sha256-dnup3OcFKqGW+LEmUvQz123hKLoWiWb6hLY5TV5sZ5U=";
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
