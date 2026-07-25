{
  pkgs ? import <nixpkgs> { },
  ...
}:
let
  inherit (pkgs)
    ghc
    haskell-language-server
    cabal-install
    ;
in
[
  ghc
  haskell-language-server
  cabal-install
]
