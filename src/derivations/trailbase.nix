{
  final,
  prev,

  stdenv,
  fetchurl,

  unzip,
}:
stdenv.mkDerivation {
  name = "trailbase";
  src = fetchurl {
    url = "https://github.com/trailbaseio/trailbase/releases/download/v0.23.6/trailbase_v0.23.6_x86_64_linux.zip";
    hash = "sha256-eIyP8O+GtpgDqWe46IjGTDgES1kmenSdPCAgfLc2/o4=";
  };
  nativeBuildInputs = [ unzip ];
  sourceRoot = ".";
  installPhase = ''
    chmod +x trail
    mkdir -p $out/bin
    mv trail $out/bin/trail
  '';
}
