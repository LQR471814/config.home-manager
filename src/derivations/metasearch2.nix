{ pkgs ? import <nixpkgs> {}, ... }:

pkgs.rustPlatform.buildRustPackage {
  name = "metasearch2";

  src = pkgs.fetchgit {
    url = "https://github.com/LQR471814/metasearch2.git";
    rev = "37dc3364731f3a62c554f2d19160c22bd5f260fe";
    hash = "sha256-UwDYpjgiFQbDIK1PsZNXmu0gUXBKEAfLHS17/JuD0Bs=";
  };

  cargoHash = "sha256-x3F/ykuxAofop3L/i/zAmXfGa6qccJg8UKgWB1rdkRM=";

  buildPhase = "cargo build --frozen --release";
  installPhase = ''
    install -m 755 -d $out/bin
    install -m 755 target/release/metasearch $out/bin
  '';

  doCheck = false;
  doInstallCheck = false;

  meta = {
    description = "a cute metasearch engine";
    homepage = "https://github.com/LQR471814/metasearch2";
  };
}
