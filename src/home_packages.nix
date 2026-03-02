ctx@{
  pkgs ? import <nixpkgs> { },
  ...
}:
let
  paths = pkgs.lib.filesystem.listFilesRecursive ./package_sets;
  nix-path = builtins.filter (path: pkgs.lib.hasSuffix ".nix" (builtins.toString path)) paths;
  package-sets = builtins.map (path: import "${path}" ctx) nix-path;
  packages-all = builtins.concatLists package-sets;
in
{
  pkgs = packages-all;
}
