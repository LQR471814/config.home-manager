{
  pkgs ? import <nixpkgs> { },
  ...
}:
with pkgs;
[
  sbcl
  sbclPackages.lisp-stat
  sbclPackages.fft
]
