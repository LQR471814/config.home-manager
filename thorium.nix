{ pkgs ? import <nixpkgs> {} }:

pkgs.stdenv.mkDerivation {
  name = "thorium";
  version = "128.0.6613.189";
  system = "x86_64-linux";

  src = pkgs.fetchurl {
    url = "https://github.com/Alex313031/thorium/releases/download/M128.0.6613.189/thorium-browser_128.0.6613.189_AVX2.zip";
    sha256 = "sha256-10sJ5AlSNcIydtAlRZBvahXaUXOSmtNJJmUY9p/syvM=";
  };

  nativeBuildInputs = [ pkgs.unzip ];
  dontUnpack = true;

  installPhase = ''
    mkdir -p $out/bin
    unzip -q $src -d $out/bin

    install -m 444 -D $out/bin/thorium-portable.desktop $out/share/applications/thorium-browser.desktop
    install -m 444 -D $out/bin/thorium-shell.desktop $out/share/applications/thorium-shell.desktop
    install -m 444 -D $out/bin/product_logo_256.png $out/share/pixmaps/thorium-browser.png
    install -m 444 -D $out/bin/thorium_shell.png $out/share/pixmaps/thorium-shell.png
    rm $out/bin/thorium-portable.desktop
    rm $out/bin/thorium-shell.desktop
    rm $out/bin/product_logo_256.png
    rm $out/bin/thorium_shell.png
    rm $out/bin/product_logo*

    substituteInPlace $out/share/applications/thorium-browser.desktop \
      --replace-fail "Exec=./thorium-browser" "Exec=/usr/bin/env thorium-browser" \
      --replace-fail "Icon=product_logo_256.png" "Icon=thorium-browser"

    substituteInPlace $out/share/applications/thorium-shell.desktop \
      --replace-fail "Exec=./thorium_shell" "Exec=/usr/bin/env thorium-shell" \
      --replace-fail "Icon=./thorium_shell.png" "Icon=thorium-shell"
  '';

  meta = {
    description = "A fork of chromium optimized for speed.";
    homepage = "https://github.com/Alex313031/thorium";
  };
}
