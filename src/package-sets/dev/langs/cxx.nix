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
  # bear
]
