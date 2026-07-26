{ pkgs, ... }@ctx:
let
  paths = pkgs.lib.filesystem.listFilesRecursive ./package-sets;
  nix-paths = builtins.filter (path: pkgs.lib.hasSuffix ".nix" (toString path)) paths;
  package-sets = map (path: import "${path}" ctx) nix-paths;
in
{
  home.packages = builtins.concatLists package-sets;

  programs = {
    kitty = import ./cfg-programs/kitty.nix ctx;
    git = import ./cfg-programs/git.nix ctx;
    tmux = import ./cfg-programs/tmux.nix ctx;
    swaylock = import ./cfg-programs/swaylock.nix ctx;
    obs-studio = import ./cfg-programs/obs-studio.nix ctx;
    bluetuith.enable = true;
    nushell = import ./cfg-programs/nushell.nix ctx;
    carapace = import ./cfg-programs/carapace.nix ctx;
    yazi = import ./cfg-programs/yazi.nix ctx;
  };
}
