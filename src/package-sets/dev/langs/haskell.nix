{
  pkgs ? import <nixpkgs> { },
  ...
}:
with pkgs;
[
  ghc
  haskell-language-server
  cabal-install
]
