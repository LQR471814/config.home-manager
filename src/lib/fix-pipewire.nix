# this derivation fixes all apps that require pipewire

{
  stdenv,
  pipewire,
  ...
}:
pkg:

stdenv.mkDerivation {
  name = pkg.name + "-pw";

  buildInputs = [
    pipewire.jack
    pkg
  ];

  dontUnpack = true;

  installPhase = ''
    mkdir -p $out/bin

    for file in ${pkg}/bin/*; do
      if [ -f "$file" ]; then
        echo "${pipewire.jack}/bin/pw-jack '$file'" > "$out/bin/$(basename "$file")"
        chmod +x "$out/bin/$(basename "$file")"
      fi
    done
  '';
}
