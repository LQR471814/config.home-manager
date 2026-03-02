{
  final,
  prev,

  fetchgit,

  rustPlatform,
  clang,
  git,
  pkg-config,
  cmake,
  perl,
  glibc,
  libclang,
  boringssl,

}:

let
  boringssl-source = fetchgit {
    url = "https://boringssl.googlesource.com/boringssl";
    rev = "b94d71f87ff943a617d77f3ff029f9a01a1ec6bc";
    sha256 = "sha256-i+HP5Q1UmBCLmDdGvSKPts6nwo/9vGUh5wMdmmQ7qLU=";
  };
in

rustPlatform.buildRustPackage {
  name = "metasearch2";

  src = fetchgit {
    url = "https://github.com/LQR471814/metasearch2.git";
    rev = "88b9ad6771be240ea06604a83cb29b7b6b425706";
    hash = "sha256-4FJIAfwRZzpv+TI1+KHiFXHc8NzV9TBc/vNKp4UXOcI=";
  };

  cargoHash = "sha256-h16jPDO6q3wE35WyiA35fz7CIMxqJMa1uByqv2wmV0k=";

  nativeBuildInputs = [
    rustPlatform.bindgenHook
    clang
    git
    pkg-config
    cmake
    perl
  ];

  buildInputs = [
    glibc.dev
    libclang.lib
    libclang.dev
    boringssl
  ];

  buildPhase = ''
    export LIBCLANG_PATH="${libclang.lib}/lib"
    # export BORING_BSSL_PATH="${boringssl}/lib"
    # export BORING_BSSL_INCLUDE_PATH="${boringssl.dev}/include"
    export BORING_BSSL_SOURCE_PATH="${boringssl-source}"
    export BORING_BSSL_ASSUME_PATCHED=1
    export RUSTFLAGS="-L ${boringssl}/lib"
    export PATH="$PATH:${cmake}/bin"

    cargo build --frozen --release
  '';
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
