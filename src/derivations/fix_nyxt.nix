{ pkgs ? import <nixpkgs> { }, ... }:

pkgs.stdenv.mkDerivation {
  name = "nyxt-wrapped";

  nativeBuildInputs = with pkgs; [
    makeWrapper
  ];

  buildInputs = with pkgs; [
    nyxt
    libgbm
  ];

  dontUnpack = true;

  installPhase = with pkgs; ''
    mkdir -p $out/bin

    export LD_LIBRARY_PATH="${libgbm}/lib:$LD_LIBRARY_PATH"
	echo "LD_LIBRARY_PATH=\"$LD_LIBRARY_PATH\" ${nyxt}/bin/nyxt" > $out/bin/nyxt
	chmod +x $out/bin/nyxt
  '';
}
