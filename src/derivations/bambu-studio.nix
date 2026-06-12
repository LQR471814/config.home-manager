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
  version = "02.07.01.57";

  src = fetchurl {
    url = "https://github.com/bambulab/BambuStudio/releases/download/v${version}/BambuStudio_ubuntu-22.04-v${version}-20260601192128.AppImage";
    hash = "sha256-mF1kFjtHi0xBe0F4N0nsGzSpnKF1HjOfSZPmVXlxPFw=";
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
