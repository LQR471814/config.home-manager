{
  final,
  prev,

  appimageTools,
  fetchurl,
  stdenv,
}:
let
  appimage = appimageTools.wrapType2 rec {
    name = "houdoku-appimage";
    pname = "houdoku";
    version = "2.16.0";

    src = fetchurl {
      url = "https://github.com/xgi/houdoku/releases/download/v${version}/Houdoku-${version}.AppImage";
      hash = "sha256-P9f8t5K6c9hF/qe0Fqv5pAgB3rjya9FswV6sPF1ykOg=";
    };
  };
in
stdenv.mkDerivation {
  name = "houdoku";
  buildInputs = [
    appimage
  ];
  dontUnpack = true;
  installPhase = ''
    mkdir -p $out/bin
    echo "${appimage}/bin/houdoku --ozone-platform-hint=auto --enable-features=WaylandWindowDecorations" > "$out/bin/houdoku"
    chmod +x "$out/bin/houdoku"
  '';
}
