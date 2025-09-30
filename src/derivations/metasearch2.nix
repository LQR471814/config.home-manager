{ pkgs ? import <nixpkgs> {}, ... }:

pkgs.rustPlatform.buildRustPackage {
  name = "metasearch2";

  src = pkgs.fetchgit {
    url = "https://github.com/LQR471814/metasearch2.git";
    rev = "940012121c73a24e95995af2ef09dff768ab2b8d";
    hash = "sha256-PmTWrSYUeiGkok9m1IauTVQ1PcyfIEJjzaR0o5TH0cA=";
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
