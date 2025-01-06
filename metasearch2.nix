{ pkgs }:

pkgs.buildRustPackage rec {
  pname = "metasearch2";

  src = pkgs.fetchgit {
    url = "https://github.com/LQR471814/metasearch2.git";
    rev = "fa839e3c53c44d7f9bfea962acaed49dbd047cec";
    hash = "sha256-Peka/ln+o9k2/PHSiOHj98CGRgt3BeQ/taFNRtv5EJ8=";
  };

  cargoHash = pkgs.lib.fakeHash;

  buildPhase = "cargo build --release";

  meta = {
    description = "a cute metasearch engine";
    homepage = "https://github.com/LQR471814/metasearch2";
  };
}
