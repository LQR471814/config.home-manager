{
  pkgs ? import <nixpkgs> { },
  ...
}:
let
  inherit (pkgs)
    git
    git-lfs
    git-filter-repo
    git-credential-manager
    gh
    nix-prefetch-git
    lazygit
    meteor-git
    pre-commit
    ;
in
[
  git
  git-lfs
  git-filter-repo
  git-credential-manager
  gh
  nix-prefetch-git
  lazygit
  meteor-git
  pre-commit
]
