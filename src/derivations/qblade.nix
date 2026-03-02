{
  final,
  prev,

  stdenv,
  fetchurl,
  lib,
  makeWrapper,
  writeShellScriptBin,

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
  qblade = stdenv.mkDerivation {
    name = "qblade";

    src = fetchurl {
      url = "https://qblade.org/assets/QBladeCE_2.0.9.6_unix.zip";
      hash = "sha256-05J1uFwUNevjHLfPmjdZ1MRyq69LEFvhZbJuBcQJrIo=";
    };

    nativeBuildInputs = [
      unzip
      makeWrapper
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
  };
in
writeShellScriptBin "qblade" ''
  APP_DIR="$HOME/.local/share/qblade"
  mkdir -p "$APP_DIR"
  cp -f ${qblade}/bin/qbladece "$APP_DIR/qbladece"
  ln -s ${qblade}/ControllerFiles "$APP_DIR/ControllerFiles"
  exec "$APP_DIR/qbladece" "$@"
''
