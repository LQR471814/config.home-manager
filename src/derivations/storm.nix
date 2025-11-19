{
  pkgs ? import <nixpkgs> { },
  ...
}:

let
  clangStdenv = pkgs.overrideCC pkgs.stdenv pkgs.llvmPackages.clang;
in
clangStdenv.mkDerivation {
  name = "storm-model-checker";
  version = "v1.11.1";
  system = "x86_64-linux";

  src = pkgs.fetchgit {
    url = "https://github.com/moves-rwth/storm.git";
    rev = "8478d92eea9243dd50be380fa2fdc1ab99be8db6";
	hash = "sha256-2ClVJt/Pj1Oatr9muep+QD/R+LUmmsRPDCFY4Ec0UTg=";
  };

  stdenv = pkgs.overrideCC pkgs.stdenv pkgs.clang;
  nativeBuildInputs = with pkgs; [
    pkg-config
	autoconf
    automake
    cmake
    git
  ];
  buildInputs = with pkgs; [
    boost
    ginac
    gmp
    hwloc
	eigen
	glpk
	z3
	xercesc
  ];

  buildPhase = ''
    mkdir build
	cd build
	cmake ..
	make -j8
	make binaries
  '';

  installPhase = ''
  	mkdir $out
  	cp -r bin $out/bin
  '';
}
