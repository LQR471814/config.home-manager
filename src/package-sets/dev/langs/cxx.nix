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
  # bear
]
