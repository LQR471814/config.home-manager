{
  pkgs ? import <nixpkgs> { },
  nixgl,
  ...
}:
pkg:

pkgs.stdenv.mkDerivation {
  name = pkg.name + "-gl";

  buildInputs = [
    pkg
  ];

  dontUnpack = true;

  installPhase = ''
	mkdir -p $out/bin

	nixgl=$(find ${nixgl.packages."${pkgs.system}".default} -maxdepth 1 -type f -executable | head -n 1)

	for file in ${pkg}/bin/*; do
	  if [ -f "$file" ]; then
		echo "$nixgl '$file'" > "$out/bin/$(basename '$file')"
		chmod +x "$out/bin/$(basename '$file')"
	  fi
	done
  '';
}
