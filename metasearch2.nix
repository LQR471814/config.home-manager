{ pkgs ? import <nixpkgs> {} }:

pkgs.rustPlatform.buildRustPackage {
  name = "metasearch2";

  src = pkgs.fetchgit {
    url = "https://github.com/LQR471814/metasearch2.git";
    rev = "fa839e3c53c44d7f9bfea962acaed49dbd047cec";
    hash = "sha256-Peka/ln+o9k2/PHSiOHj98CGRgt3BeQ/taFNRtv5EJ8=";
  };

  cargoHash = "sha256-Mk7iOtU20WYeVviG5Bd9htjFl8tpwj3CWeUDmVmCnoA=";

  buildPhase = "cargo build --frozen --release";
  installPhase = ''
    install -m 755 -d $out/bin
    install -m 755 target/release/metasearch $out/bin
  '';

  meta = {
    description = "a cute metasearch engine";
    homepage = "https://github.com/LQR471814/metasearch2";
  };
}
