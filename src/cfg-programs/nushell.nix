{ config, pkgs, ... }:
with pkgs;
{
  enable = true;
  settings = {
    show_banner = false;
    edit_mode = "vi";
  };
  shellAliases = {
    lzg = "lazygit";
    lzd = "lazydocker";
    y = "yazi";
    nvt = "tmux-spawn $env.PWD 'nvim .'";
    shut = "sudo shutdown now -h";
    batchargefull = "sudo tlp setcharge 0 100";
    batcharge80 = "sudo tlp setcharge 0 80";
    batcharge40 = "sudo tlp setcharge 40 60";
    batcharge50 = "sudo tlp setcharge 40 50";
    batreset = "sudo tlp start";
    notes = "tmux-spawn ~/Documents/Notes 'nvim ~/Documents/Notes'";
    hmconf = "tmux-spawn ~/.config/home-manager 'nvim ~/.config/home-manager'";
    osconf = "tmux-spawn ~/.config/nixos 'nvim ~/.config/nixos'";
    nvconf = "tmux-spawn ~/.config/nvim 'nvim ~/.config/nvim'";
    mansearch = "man -k . | fzf | awk '{print $1 $2}' | xargs -r man";
    ta = "tmux a";
    ndev = "nix develop --command fish";
  };
  extraConfig =
    let
      PATH = builtins.concatStringsSep "\n" (map (x: "\"${x}\"") config.home.sessionPath);
    in
    ''
      $env.PATH = $env.PATH ++ [
      ${PATH}
      ]
      const NU_LIB_DIRS = $NU_LIB_DIRS ++ [
        "${nu-ai}"
        "${nu-xs}"
      ]
      const NU_PLUGIN_DIRS = $NU_PLUGIN_DIRS ++ [
        "${nushellPlugins.query}/bin"
        "${nushellPlugins.polars}/bin"
        "${nu-plugin-caldav}/bin"
      ]
      plugin add nu_plugin_query
      plugin add nu_plugin_polars
      plugin add nu_plugin_caldav
      plugin use query
      plugin use polars
      plugin use caldav
    '';
}
