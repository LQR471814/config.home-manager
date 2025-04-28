{ pkgs ? import <nixpkgs> {}, ... }:

pkgs.rustPlatform.buildRustPackage {
  name = "metasearch2";

  src = pkgs.fetchgit {
    url = "https://github.com/LQR471814/metasearch2.git";
    rev = "cad5db8072bdbc8b5b26fe7eca96304d54598caf";
    hash = "sha256-IRflQI4fqFUYDoZHl2r+2mhqphonX+CU4TyDdcBWsGo=";
  };

  cargoHash = "sha256-vQJcIPpoxobUiIrScyjQlS2xV9FRUCbNdESjfklAXko=";

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
