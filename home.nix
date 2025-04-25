{ config, pkgs, ... }:

let
  HOSTNAME = builtins.readFile /etc/hostname;
  HOME = builtins.getEnv "HOME";
  IS_DESKTOP = builtins.match ".*desktop.*" HOSTNAME != null;
  IS_LAPTOP = builtins.match ".*laptop.*" HOSTNAME != null;

  mytexlive = pkgs.texlive.combine {
    inherit (pkgs.texlive)
      scheme-basic
      collection-latexrecommended
      latexmk
      pdftex
      svg
      transparent
      pgfplots
      catchfile
      titlesec
      ctex
      dvipng
      standalone
      ;
  };
  fixGL = config.lib.nixGL.wrap;
  fixPW = import ./src/derivations/fix_pipewire.nix { pkgs = pkgs; };
  ctx = {
    inherit HOME;
    inherit HOSTNAME;
    inherit IS_DESKTOP;
    inherit IS_LAPTOP;

    inherit pkgs;
    inherit config;
    inherit fixGL;
    inherit mytexlive;
  };
in
{
  nixGL = {
    defaultWrapper = if IS_DESKTOP then "nvidia" else "mesa";
    packages = import <nixgl> { inherit pkgs; };
  };
  targets.genericLinux.enable = true;

  home = {
    username = "lqr471814";
    homeDirectory = HOME;
    stateVersion = "24.11";

    packages = with pkgs; [
      home-manager
      jetbrains-mono
      nerd-fonts.jetbrains-mono
      source-han-serif-vf-ttf

      # build tools
      cmake
      gnumake
      pkg-config

      # dev tools
      ripgrep
      fd
      zsh
      zplug
      tmux
      git
      git-credential-manager
      git-filter-repo
      docker
      lazygit
      nix-prefetch-git
      buf
      sqlc
      atlas
      templ
      pnpm
      cloc
      pipx
      clang
      jq
      reftools
      rye
      ruff
      sqlite
      redis
      croc

      # lsps
      nixd
      nixfmt-rfc-style
      texlab
      lua-language-server
      vtsls
      tailwindcss-language-server
      svelte-language-server
      biome
      vscode-langservers-extracted

      # languages
      go
      nodejs
      pnpm
      rustc
      cargo
      numbat
      mytexlive
      zulu23

      # general terminal tools
      pdf2svg
      ffmpeg
      neovim
      yazi
      rclone
      ffmpeg
      htop
      btop
      xsel
      rclone
      mprocs
      tree
      sshfs
      aria2
      cloudflare-warp
      imagemagick
      (import ./src/derivations/yt-dlp.nix ctx)
      cloudflare-warp
      watchman
      tlaplus
      libqalculate
      wine
      winetricks
      bluetuith
      socat

      # daemons
      (import ./src/derivations/metasearch2.nix ctx)
      activitywatch
      syncthing
      cups

      # gui apps
      (import ./src/derivations/thorium.nix ctx)
      (fixGL alacritty)
      (fixGL localsend)
      (fixPW {
        package = fixGL musescore;
        name = "musescore";
        bin = "mscore";
      })
      (fixPW {
        package = fixGL ardour;
        name = "ardour";
        bin = "ardour8";
      })
      (fixPW {
        package = easyeffects;
        name = "easyeffects";
        bin = "easyeffects";
      })
      (fixGL blender)
      (fixGL kdePackages.kdenlive)
      (fixGL obs-studio)
      (fixGL anki)
      (fixGL qpwgraph)
      (fixGL foliate)
      ueberzugpp # this is a dependency of yazi
      zathura
      legcord
      dbeaver-bin
      miru
      keepassxc
      tor-browser
      thunderbird
      obsidian
      libreoffice
      gimp
      inkscape
      scribus
      tlaplusToolbox
      rofi
      xclip
      xss-lock
      filezilla
      vlc
      rhythmbox

      # dwm
      (import ./src/derivations/dwm.nix ctx)
      (import ./src/derivations/dwmblocks.nix ctx)
      xorg.libX11
      xorg.libXft
      xorg.libXinerama
      xorg.xdm
      dmenu
      picom
      pwvucontrol
      playerctl
      flameshot
    ];

    file = import ./src/home_files.nix ctx;
  };

  programs.alacritty = import ./src/cfg-programs/alacritty.nix ctx;
  programs.zsh = import ./src/cfg-programs/zsh.nix ctx;
  programs.git = import ./src/cfg-programs/git.nix ctx;
  programs.tmux = import ./src/cfg-programs/tmux.nix ctx;
  services.syncthing = import ./src/cfg-programs/syncthing.nix ctx;

  fonts.fontconfig = import ./src/cfg-system/fontconfig.nix ctx;
  xdg.mimeApps = import ./src/cfg-system/mimeapps.nix ctx;
  dconf = import ./src/cfg-system/dconf.nix ctx;
  systemd.user = import ./src/cfg-system/systemd.nix ctx;

  # the systemd daemon created by this doesn't start automatically
  # because I am running dwm, therefore fcitx5 is started in ~/.dwm/autostart.sh
  i18n.inputMethod.enabled = "fcitx5";
  i18n.inputMethod.fcitx5.addons = with pkgs; [
    fcitx5-gtk
    libsForQt5.fcitx5-qt
    libsForQt5.fcitx5-chinese-addons
  ];

  xdg.portal.enable = true;
  xdg.portal.extraPortals = [
    pkgs.xdg-desktop-portal-gtk
  ];
  xdg.portal.config.common.default = "*";
}
