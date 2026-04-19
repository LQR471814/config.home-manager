{
  final,
  prev,

  stdenv,
  fetchurl,
}:

let
  version = "2026.03.17";
in
stdenv.mkDerivation {
  name = "yt-dlp";
  inherit version;
  system = "x86_64-linux";

  src = fetchurl {
    url = "https://github.com/yt-dlp/yt-dlp/releases/download/${version}/yt-dlp_linux";
    hash = "sha256-wrAYn1gf5KLd1BlU8by30yfbBLB+0N6pfk8bPgm13Y4=";
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
