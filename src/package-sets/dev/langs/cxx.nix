{
  pkgs ? import <nixpkgs> { },
  ...
}:
let
  inherit (pkgs)
    cmake
    gnumake
    pkg-config
    patchelf
    clang
    lld
    lldb
    libcxx
    clang-tools
    ccache
    arduino-language-server
    arduino-cli
    ;
in
[
  cmake
  gnumake
  pkg-config
  patchelf
  clang
  lld
  lldb
  libcxx
  clang-tools
  ccache
  arduino-language-server
  arduino-cli
  # bear
]
