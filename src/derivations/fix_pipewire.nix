{ pkgs ? import <nixpkgs> { }, ... }:
pkg:

pkgs.stdenv.mkDerivation {
  name = pkg.name + "-pw";

  buildInputs = [
    pkgs.pipewire.jack
    pkg
  ];

  dontUnpack = true;

  installPhase = ''
    mkdir -p $out/bin

    for file in ${pkg}/bin/*; do
      if [ -f "$file" ]; then
        echo "${pkgs.pipewire.jack}/bin/pw-jack '$file'" > "$out/bin/$(basename "$file")"
        chmod +x "$out/bin/$(basename "$file")"
      fi
    done
  '';
}
