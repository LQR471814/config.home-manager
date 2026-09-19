{ pkgs, ... }@ctx:
let
  paths = pkgs.lib.filesystem.listFilesRecursive ./package-sets;
  nix-paths = builtins.filter (path: pkgs.lib.hasSuffix ".nix" (toString path)) paths;
  package-sets = map (path: import "${path}" ctx) nix-paths;
in
{
  imports = [
    ./cfg-programs/kitty.nix
    ./cfg-programs/git.nix
    ./cfg-programs/tmux.nix
    ./cfg-programs/swaylock.nix
    ./cfg-programs/obs-studio.nix
    ./cfg-programs/nushell.nix
    ./cfg-programs/carapace.nix
    ./cfg-programs/yazi.nix
    ./cfg-programs/ast-grep.nix
  ];

  home.packages = builtins.concatLists package-sets;

  programs.bluetuith.enable = true;
}
