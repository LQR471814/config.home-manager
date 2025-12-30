{
  pkgs ? import <nixpkgs> { },
  ...
}:

pkgs.stdenv.mkDerivation {
  # temporary workaround for zotero crashes on wayland w/ Nvidia GPU while
  # waiting for zotero 7.1 which reportedly fixes it
  # TODO: remove when zotero 7.1 drops
  name = "zotero-workaround";
  buildInputs = [ pkgs.zotero ];
  dontUnpack = true;
  installPhase = ''
    mkdir -p $out/bin
    echo "__NV_DISABLE_EXPLICIT_SYNC=1 ${pkgs.zotero}/bin/zotero" > "$out/bin/zotero"
    chmod +x "$out/bin/zotero"
  '';
}
