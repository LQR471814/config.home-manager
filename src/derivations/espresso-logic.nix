{
  final,
  prev,

  overrideCC,
  stdenv,
  fetchgit,

  llvmPackages,
  clang,
  pkg-config,
}:

let
  clangStdenv = overrideCC stdenv llvmPackages.clang;
in
clangStdenv.mkDerivation {
  name = "espresso-logic";
  version = "1.1";
  system = "x86_64-linux";

  src = fetchgit {
    url = "https://github.com/classabbyamp/espresso-logic.git";
    rev = "85265139e9598852f9388d293658a1977a829a01";
    hash = "sha256-qgq+9Z3zYLXakJ0CQtF6eF8tL26CB6UTto/L3ZuqRdk=";
  };

  stdenv = overrideCC stdenv clang;
  nativeBuildInputs = [
    pkg-config
  ];

  buildPhase = ''
    cd espresso-src && make
  '';

  installPhase = ''
    cd ..
    mkdir -p $out
    cp -r bin $out

    mkdir -p $out/share
    cp -r man $out/share
  '';
}
