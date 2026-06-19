{
  final,
  prev,

  stdenv,
  fetchurl,
}:

let
  version = "2026.06.09";
in
stdenv.mkDerivation {
  name = "yt-dlp";
  inherit version;
  system = "x86_64-linux";

  src = fetchurl {
    url = "https://github.com/yt-dlp/yt-dlp/releases/download/${version}/yt-dlp_linux";
    hash = "sha256-v4qsebcih6bSBDB0QVEyVYtDdDqPlGGiKwFB6Q8WzmY=";
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
