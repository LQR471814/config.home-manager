{
  final,
  prev,
  stdenv,
}:
stdenv.mkDerivation {
  pname = "myconfig";
  name = "myconfig";
  src = ./myconfig;
  installPhase = ''
    mkdir -p $out/tex/latex/myconfig
    cp * $out/tex/latex/myconfig
  '';
  tlType = "run";
}
