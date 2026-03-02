{
  final,
  prev,

  rustPlatform,
  fetchgit,
  lib,

  pkg-config,
  wayland-scanner,
  makeWrapper,
  openssl,
  wayland,
  wayland-protocols,
  libxkbcommon,
  vulkan-loader,
  mesa,
  udev,
  libglvnd,
}:

rustPlatform.buildRustPackage {
  name = "rdfglance";

  src = fetchgit {
    url = "https://github.com/LQR471814/rdfglance.git";
    rev = "393dbb75c3d7bc9a0683c1efee3fe55ac10ef8e6";
    hash = "sha256-XFqxBFeugA8uNNI4LI97SVPG275LUlflp9a46dwm1nc=";
  };

  nativeBuildInputs = [
    pkg-config
    wayland-scanner
    makeWrapper
  ];
  buildInputs = [
    openssl
    wayland
    wayland-protocols
    libxkbcommon
    vulkan-loader
    mesa
    udev
  ];
  OPENSSL_NO_VENDOR = 1;

  buildPhase = "cargo build --frozen --release";
  installPhase = ''
    install -m 755 -d $out/bin
    install -m 755 target/release/rdf-glance $out/bin

    wrapProgram $out/bin/rdf-glance \
      --prefix LD_LIBRARY_PATH : ${
        lib.makeLibraryPath [
          wayland
          libxkbcommon
          vulkan-loader
          libglvnd
        ]
      }
  '';
  cargoHash = "sha256-V2np/6D5eWpawN2ynNXcSMgjiJgmnX89qNaCHtRPIbM=";

  doCheck = false;
  doInstallCheck = false;

  meta = {
    description = "a lightweight RDF visualizer and editor";
    homepage = "https://github.com/LQR471814/rdfglance";
  };
}
