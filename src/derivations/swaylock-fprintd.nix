{
  stdenv,

  meson,
  ninja,
  pkg-config,
  scdoc,
  wayland-scanner,

  cairo,
  dbus,
  fprintd,
  gdk-pixbuf,
  glib,
  libxkbcommon,
  pam,
  wayland,
  wayland-protocols,
  libxcrypt,
  git,

  fetchFromGitHub,
  ...
}:
stdenv.mkDerivation {
  pname = "swaylock-fprintd";
  version = "git";

  src = fetchFromGitHub {
    owner = "SL-RU";
    repo = "swaylock-fprintd";
    rev = "536d9dff795eb85720fc942da13e93bebea9f5fa";
    hash = "sha256-M19RR1+5oMTdPbC/GwqjpKnnNl30MLDlCkaRY/WMHx4=";
  };

  nativeBuildInputs = [
    meson
    ninja
    pkg-config
    scdoc
    wayland-scanner
  ];

  buildInputs = [
    cairo
    dbus
    fprintd
    gdk-pixbuf
    glib
    libxkbcommon
    pam
    wayland
    wayland-protocols
    libxcrypt
    git
  ];

  postPatch = ''
    substituteInPlace fingerprint/meson.build \
      --replace-fail \
        "/usr/share/dbus-1/interfaces/net.reactivated.Fprint.Manager.xml" \
        "${fprintd}/share/dbus-1/interfaces/net.reactivated.Fprint.Manager.xml" \
      --replace-fail \
        "/usr/share/dbus-1/interfaces/net.reactivated.Fprint.Device.xml" \
        "${fprintd}/share/dbus-1/interfaces/net.reactivated.Fprint.Device.xml"
  '';

  mesonFlags = [
    "-Dpam=enabled"
    "-Dgdk-pixbuf=enabled"
  ];
}
