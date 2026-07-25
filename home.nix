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
  home = {
    # basic configuration
    username = "lqr471814";
    homeDirectory = HOME;
    stateVersion = "26.05";

    # home files (.config, etc...)
    file = import ./src/home-files.nix ctx;

    # env vars
    sessionVariables = {
      CC = "${pkgs.clang}/bin/clang";
      GTK_IM_MODULE = "fcitx";
      QT_IM_MODULE = "fcitx";
      XMODIFIERS = "@im=fcitx";
      SDL_IM_MODULE = "fcitx";
      GOBIN = "${HOME}/go/bin";
      CGO_ENABLED = "0";
    };
    sessionPath = [
      "${HOME}/bin"
      "${HOME}/go/bin"
      "${HOME}/.local/bin"
      "${HOME}/.cargo/bin"
    ];
    shell.enableNushellIntegration = true;

    # cursor
    pointerCursor = {
      enable = true;
      name = "phinger-cursors-light";
      package = pkgs.phinger-cursors;
      size = 32;
      gtk.enable = true;
    };

    # packages
    packages = import ./src/home-packages.nix ctx;
  };

  # program configuration
  programs = {
    kitty = import ./src/cfg-programs/kitty.nix ctx;
    git = import ./src/cfg-programs/git.nix ctx;
    tmux = import ./src/cfg-programs/tmux.nix ctx;
    swaylock = import ./src/cfg-programs/swaylock.nix ctx;
    obs-studio = import ./src/cfg-programs/obs-studio.nix ctx;
    bluetuith.enable = true;
    nushell = import ./src/cfg-programs/nushell.nix ctx;
    carapace = import ./src/cfg-programs/carapace.nix ctx;
    yazi = import ./src/cfg-programs/yazi.nix ctx;
  };

  # desktop stuff
  wayland.systemd.target = "graphical-session.target";
  dconf = import ./src/cfg-system/dconf.nix ctx;
  xdg.mimeApps = import ./src/cfg-system/mimeapps.nix ctx;
  gtk = import ./src/cfg-system/gtk.nix ctx;
  i18n = import ./src/cfg-system/i18n.nix ctx;

  # systemd
  systemd.user = import ./src/cfg-system/systemd.nix ctx;

  # services
  services = {
    swayidle = import ./src/cfg-system/swayidle.nix ctx;
    mako = import ./src/cfg-system/mako.nix ctx;
    kanshi = import ./src/cfg-system/kanshi.nix ctx;
    ollama = import ./src/cfg-programs/ollama.nix ctx;
    syncthing = import ./src/cfg-programs/syncthing.nix ctx;
    cliphist = import ./src/cfg-system/cliphist.nix ctx;
    wl-clip-persist = import ./src/cfg-system/wl-clip-persist.nix ctx;
    wayland-pipewire-idle-inhibit = import ./src/cfg-system/wayland-pipewire-idle-inhibit.nix ctx;
  };

  # nix
  nix.gc = {
    automatic = true;
    dates = "monthly";
    options = "--delete-older-than 30d";
  };
}
