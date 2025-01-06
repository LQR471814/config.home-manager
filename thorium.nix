{ pkgs }:

let
  name = "thorium";
  version = "128.0.6613.189";
  system = "x86_64-linux";

  src = pkgs.fetchurl {
    url = "https://github.com/Alex313031/thorium/releases/download/M128.0.6613.189/Thorium_Browser_128.0.6613.189_AVX2.AppImage";
    sha256 = "sha256-RBPSGgwF6A4KXgLdn/YIrdFpZG2+KwMJ8MkTjSPpkhU=";
  };

  appimageContents = pkgs.appimageTools.extractType2 {
    inherit name src;
  };
in
pkgs.appimageTools.wrapType2 {
  inherit name version src;
  extraInstallCommands = ''
    install -m 444 -D ${appimageContents}/thorium-browser.desktop $out/share/applications/thorium-browser.desktop
    install -m 444 -D ${appimageContents}/thorium.png $out/share/icons/hicolor/512x512/apps/thorium.png
    substituteInPlace $out/share/applications/thorium-browser.desktop \
    --replace 'Exec=AppRun --no-sandbox %U' 'Exec=${name} --no-default-browser-check %U'
  '';
}

