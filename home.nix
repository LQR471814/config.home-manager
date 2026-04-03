{
  config,
  pkgs,
  lib,
  ...
}:

let
  HOSTNAME = builtins.readFile /etc/hostname;
  HOME = builtins.getEnv "HOME";
  IS_DESKTOP = builtins.match ".*desktop.*" HOSTNAME != null;
  IS_LAPTOP = builtins.match ".*laptop.*" HOSTNAME != null;
  SYSTEM_BIN = "/run/current-system/sw/bin";

  fix-pw = pkgs.callPackage ./src/fix-pipewire.nix { };
  session-env = lib.mapAttrsToList (name: value: "${name}=${toString value}") (
    config.home.sessionVariables // { PATH = lib.concatStringsSep ":" config.home.sessionPath; }
  );

  ctx = {
    inherit
      HOME
      HOSTNAME
      IS_DESKTOP
      IS_LAPTOP
      SYSTEM_BIN
      pkgs
      config
      session-env
      fix-pw
      ;
  };
in
{
  # basic configuration
  home.username = "lqr471814";
  home.homeDirectory = HOME;
  home.stateVersion = "25.11";

  # packages
  home.packages = import ./src/home-packages.nix ctx;

  # home files (.config, etc...)
  home.file = import ./src/home-files.nix ctx;

  # env vars
  home.sessionVariables = {
    CC = "${pkgs.clang}/bin/clang";
    GTK_IM_MODULE = "fcitx";
    QT_IM_MODULE = "fcitx";
    XMODIFIERS = "@im=fcitx";
    SDL_IM_MODULE = "fcitx";
    GOBIN = "${HOME}/go/bin";
  };
  home.sessionPath = [
    "${HOME}/bin"
    "${HOME}/go/bin"
    "${HOME}/.local/bin"
    "${HOME}/.cargo/bin"
  ];

  # cursor
  home.pointerCursor = {
    name = "phinger-cursors-light";
    package = pkgs.phinger-cursors;
    size = 32;
    gtk.enable = true;
  };

  # userland program configuration
  programs.kitty = import ./src/cfg-programs/kitty.nix ctx;
  programs.fish = import ./src/cfg-programs/fish.nix ctx;
  programs.git = import ./src/cfg-programs/git.nix ctx;
  programs.tmux = import ./src/cfg-programs/tmux.nix ctx;
  programs.swaylock = import ./src/cfg-programs/swaylock.nix ctx;
  programs.obs-studio = import ./src/cfg-programs/obs-studio.nix ctx;
  programs.bluetuith.enable = true;
  programs.nushell = import ./src/cfg-programs/nushell.nix ctx;

  # wayland stuff
  wayland.systemd.target = "graphical-session.target";
  services.mako = import ./src/cfg-system/mako.nix ctx;
  services.kanshi = import ./src/cfg-system/kanshi.nix ctx;
  services.ollama = import ./src/cfg-programs/ollama.nix ctx;
  services.syncthing = import ./src/cfg-programs/syncthing.nix ctx;
  services.cliphist = import ./src/cfg-system/cliphist.nix ctx;
  services.wl-clip-persist = import ./src/cfg-system/wl-clip-persist.nix ctx;
  services.wayland-pipewire-idle-inhibit = import ./src/cfg-system/wayland-pipewire-idle-inhibit.nix ctx;

  # xdg and desktop stuff
  dconf = import ./src/cfg-system/dconf.nix ctx;
  xdg.mimeApps = import ./src/cfg-system/mimeapps.nix ctx;
  gtk = import ./src/cfg-system/gtk.nix ctx;
  i18n = import ./src/cfg-system/i18n.nix ctx;

  # systemd
  systemd.user = import ./src/cfg-system/systemd.nix ctx;

  # sleep & idle lock
  services.swayidle = import ./src/cfg-system/swayidle.nix ctx;

  # garbage collect packages
  nix.gc = {
    automatic = true;
    dates = "monthly";
    options = "--delete-older-than 30d";
  };
}
