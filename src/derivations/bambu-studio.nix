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
  version = "02.05.00.67";
  platform = "linux_fedora-v02.05.00.66";

  src = fetchurl {
    url = "https://github.com/bambulab/BambuStudio/releases/download/v${version}/Bambu_Studio_${platform}.AppImage";
    hash = "sha256-ydurwaGx3+AfA64oY1OZ7X3RoLjqbZcyvy2Ro5OBsK0=";
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
    ];
}
