{
  final,
  prev,
  stdenvNoCC,
}:
stdenvNoCC.mkDerivation {
  pname = "myconfig";
  name = "myconfig";
  src = ./myconfig;
  outputs = [
    "tex"
  ];
  preHook = ''
    out="''${tex-}"
  '';
  installPhase = ''
    mkdir -p $tex/tex/latex/myconfig
    cp * $tex/tex/latex/myconfig
  '';
  tlType = "run";
}
