{
  final,
  prev,
  appimageTools,
  fetchurl,
  cacert,
  glib-networking,
}:
appimageTools.wrapType2 rec {
  name = "BambuStudio";
  pname = "bambu-studio";
  version = "02.06.00.51";

  src = fetchurl {
    url = "https://github.com/bambulab/BambuStudio/releases/download/v${version}/BambuStudio_ubuntu-24.04-v${version}-20260417160415.AppImage";
    hash = "sha256-CYePefJ7FXcAK+OXsIaNRHkml18BA7um4W2+f6l49zQ=";
  };

  profile = ''
    export SSL_CERT_FILE="${cacert}/etc/ssl/certs/ca-bundle.crt"
    export GIO_MODULE_DIR="${glib-networking}/lib/gio/modules/"
  '';

  extraPkgs =
    pkgs: with pkgs; [
      cacert
      glib
      glib-networking
      gst_all_1.gst-plugins-bad
      gst_all_1.gst-plugins-base
      gst_all_1.gst-plugins-good
      webkitgtk_4_1
      libsoup_3
    ];
}
