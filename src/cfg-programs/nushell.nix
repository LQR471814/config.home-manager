{ config, pkgs, ... }:
let
  inherit (pkgs)
    nushellPlugins
    nu_plugin_caldav
    nu-ai
    nu-xs
    ;
in
{
  enable = true;
  settings = {
    show_banner = false;
    edit_mode = "vi";
    history = {
      file_format = "sqlite";
      max_size = 1000000;
      sync_on_enter = true;
      isolation = true;
    };
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
    ta = "tmux a";
    ndev = "nix develop --command fish";
    sbtop = "sudo (which btop | get 0.path)";
    rm = "nu ${../../home-files/bin/safe-rm.nu}";
  };
  plugins = [
    # nushellPlugins.polars
    nushellPlugins.query
    nu_plugin_caldav
  ];
  environmentVariables = config.home.sessionVariables;
  extraConfig =
    let
      PATH = builtins.concatStringsSep "\n" (map (x: "\"${x}\"") config.home.sessionPath);
    in
    ''
      $env.PATH ++= [
      ${PATH}
      ]
      const NU_LIB_DIRS = $NU_LIB_DIRS ++ [
        "${nu-ai}"
        "${nu-xs}"
      ]
      $env.config.keybindings ++= [
        {
          name: complete_hint_shift_tab
          modifier: CONTROL
          keycode: Tab
          mode: [emacs vi_normal vi_insert]
          event: { send: HistoryHintComplete }
        }
      ]

      def "lsmod table" [] {
        ^lsmod | lines | split column -r '\s+' | rename name size used_by_count used_by | slice 1..
      }
    '';
}
