{
  pkgs ? import <nixpkgs> { },
  ...
}:
with pkgs;
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
  # bear
]
