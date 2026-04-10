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

  qblade-build = stdenv.mkDerivation {
    name = "qblade-build";
    src = fetchurl {
      url = "https://qblade.org/assets/qblade_2.0.4_source.zip";
      hash = "sha256-5yF1yZ9TVJWN1yt+Ex9A+W/MOafbZS4PbA7kqYRdej4=";
    };
    nativeBuildInputs = [
      unzip
      makeWrapper
      libsForQt5.wrapQtAppsHook
    ];
    buildInputs = libs;
    buildPhase = ''
      qmake qblade.pro
      make -j $(nproc)
    '';
    installPhase = ''
      mkdir -p $out
      cp -r . $out
    '';
  };

  qblade-bin = stdenv.mkDerivation {
    name = "qblade-install";

    src = null;
    dontUnpack = true;

    installPhase = ''
      mkdir -p $out/bin
      mkdir -p $out/lib

      ls ${qblade-build}
      cp -r ${qblade-build}/libraries/libs_unix_64bit/* $out/lib
      ln -s $out/lib/libclblast.so $out/lib/libclblast.so.1
      cp -r ${qblade-build}/ControllerFiles $out
      cp ${qblade-build}/Binaries/unix/* $out/bin
      cp ${qblade-build}/QBladeCE $out/bin/QBladeCE
    '';
  };

  qblade = writeShellScriptBin "qblade" ''
    export LD_LIBRARY_PATH="${libPath}:${qblade-bin}/lib:${stdenv.cc.cc.lib}/lib"
    APP_DIR="$HOME/.local/share/qblade"
    mkdir -p "$APP_DIR"
    cp -f ${qblade-bin}/bin/QBladeCE "$APP_DIR/QBladeCE"
    ln -s ${qblade-bin}/ControllerFiles "$APP_DIR/ControllerFiles"
    ${qblade-bin}/bin/QBladeCE "$@"
    rm -rf "$APP_DIR"
  '';
in
qblade
