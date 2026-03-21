{
  final,
  prev,

  stdenv,
  fetchgit,

  jdk8,
  bash,
}:

stdenv.mkDerivation {
  name = "rddlsim";
  system = "x86_64-linux";

  src = fetchgit {
    url = "https://github.com/LQR471814/rddlsim.git";
    rev = "c45d1d266cd64b2d211f3b36276b4105177de68d";
    hash = "sha256-2pca9So0A1huhkeCdn64vnJZThiE9q9iluRAv2Q+z+M=";
  };

  buildInputs = [ jdk8.home ];
  nativeBuildInputs = [
    jdk8
    bash
  ];

  buildPhase = ''
    LIB="$(echo lib/*.jar | tr ' ' ':')"
    mkdir bin
    javac -encoding UTF-8 -classpath "src:$LIB" -d bin src/*/*.java src/*/*/*.java
  '';

  installPhase = ''
    mkdir -p $out/{bin,lib}

    cp -r bin/* $out/bin/
    cp lib/*.jar $out/lib/

    LIB="$(echo $out/lib/*.jar | tr ' ' ':')"

    echo "#!/bin/sh
    ${jdk8.home}/bin/java \\
      -Xms100M -Xmx500M \\
      -classpath '$out/bin:$LIB' \\
      rddl.sim.Simulator \$@" > $out/bin/rddlsim
    chmod +x $out/bin/rddlsim
  '';
}
