ctx@{
  pkgs ? import <nixpkgs> { },
  ...
}:
let
  paths = pkgs.lib.filesystem.listFilesRecursive ./package-sets;
  nix-paths = builtins.filter (path: pkgs.lib.hasSuffix ".nix" (builtins.toString path)) paths;
  package-sets = builtins.map (path: import "${path}" ctx) nix-paths;
in
builtins.concatLists package-sets
