{
  pkgs ? import <nixpkgs> { },
  ...
}:
with pkgs;
[
  git
  git-filter-repo
  git-credential-manager
  gh
  nix-prefetch-git
  lazygit
]
