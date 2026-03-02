{
  final,
  prev,

  stdenv,
  fetchurl,
  lib,

  unzip,
  libGL,
  libGLU,
  libsForQt5,
}:
let
  libs = [
    libGL
    libGLU
    libsForQt5.qt5.qtbase
  ];
  libPath = lib.makeLibraryPath libs;
in
stdenv.mkDerivation {
  name = "qblade";

  src = fetchurl {
    url = "https://qblade.org/assets/QBladeCE_2.0.9.6_unix.zip";
    hash = "sha256-05J1uFwUNevjHLfPmjdZ1MRyq69LEFvhZbJuBcQJrIo=";
  };

  nativeBuildInputs = [
    unzip
  ];
  buildInputs = libs;

  dontWrapQtApps = true;

  installPhase = ''
    mkdir -p $out/bin
    cp -r . $out
    mv $out/QBladeCE* $out/bin/qbladece
  '';

  preFixup = ''
    patchelf --set-rpath "$(patchelf --print-rpath $out/bin/qbladece):$out/Libraries:${libPath}" $out/bin/qbladece
  '';
}
