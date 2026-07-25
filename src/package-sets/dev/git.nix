{
  pkgs ? import <nixpkgs> { },
  ...
}:
let
  inherit (pkgs)
    git
    git-filter-repo
    git-credential-manager
    gh
    nix-prefetch-git
    lazygit
    meteor-git
    ;
in
[
  git
  git-filter-repo
  git-credential-manager
  gh
  nix-prefetch-git
  lazygit
  meteor-git
]
