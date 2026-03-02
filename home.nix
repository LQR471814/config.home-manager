{
  metasearch2,
}:
{
  config,
  pkgs,
  ...
}:

let
  HOSTNAME = builtins.readFile /etc/hostname;
  HOME = builtins.getEnv "HOME";
  IS_DESKTOP = builtins.match ".*desktop.*" HOSTNAME != null;
  IS_LAPTOP = builtins.match ".*laptop.*" HOSTNAME != null;

  mytexlive = import ./src/derivations/mytexlive.nix { inherit pkgs; };
  fix-pw = import ./src/derivations/fix-pipewire.nix { inherit pkgs; };

  ctx = {
    inherit HOME;
    inherit HOSTNAME;
    inherit IS_DESKTOP;
    inherit IS_LAPTOP;

    inherit pkgs;
    inherit config;

    inherit mytexlive;
    inherit fix-pw;
  };
in
{
  # basic configuration
  home.username = "lqr471814";
  home.homeDirectory = HOME;
  home.stateVersion = "25.11";

  # packages
  home.packages = import ./src/home_packages.nix ctx;

  # home files (.config, etc...)
  home.file = import ./src/home_files.nix ctx;

  # env vars
  home.sessionVariables = import ./src/home_env.nix ctx;
  home.sessionPath = import ./src/home_path.nix ctx;

  # cursor
  home.pointerCursor = import ./src/home_cursor.nix ctx;

  # userland program configuration
  programs.kitty = import ./src/cfg_programs/kitty.nix ctx;
  programs.fish = import ./src/cfg_programs/fish.nix ctx;
  programs.git = import ./src/cfg_programs/git.nix ctx;
  programs.tmux = import ./src/cfg_programs/tmux.nix ctx;
  programs.swaylock = import ./src/cfg_programs/swaylock.nix ctx;
  programs.obs-studio = import ./src/cfg_programs/obs-studio.nix ctx;
  programs.bluetuith.enable = true;
  programs.nushell = import ./src/cfg_programs/nushell.nix ctx;

  # wayland stuff
  services.mako = import ./src/cfg_system/mako.nix ctx;
  services.kanshi = import ./src/cfg_system/kanshi.nix ctx;
  services.ollama = import ./src/cfg_programs/ollama.nix ctx;
  services.syncthing = import ./src/cfg_programs/syncthing.nix ctx;

  # xdg and desktop stuff
  dconf = import ./src/cfg_system/dconf.nix ctx;
  xdg.mimeApps = import ./src/cfg_system/mimeapps.nix ctx;
  gtk = import ./src/cfg_system/gtk.nix ctx;
  i18n = import ./src/cfg_system/i18n.nix ctx;

  # systemd
  systemd.user = import ./src/cfg_system/systemd.nix ctx;

  # sleep & idle lock
  services.swayidle = import ./src/cfg_system/swayidle.nix ctx;
}
