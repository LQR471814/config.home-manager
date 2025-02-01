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
      ctex;
  };
  fixGL = config.lib.nixGL.wrap;
  ctx = {
    inherit HOME;
    inherit HOSTNAME;
    inherit IS_DESKTOP;
    inherit IS_LAPTOP;

    inherit pkgs;
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
      docker
      lazygit
      nix-prefetch-git
      buf
      sqlc
      atlas
      pnpm
      cloc
      pipx
      clang
      jq
      reftools
      rye
      ruff

      # lsps
      nixd
      nixfmt-rfc-style
      texlab
      lua-language-server
      vtsls
      tailwindcss-language-server
      svelte-language-server
      biome

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

      # daemons
      (import ./src/derivations/metasearch2.nix ctx)
      activitywatch
      syncthing
      cups

      # gui apps
      (import ./src/derivations/thorium.nix ctx)
      (fixGL alacritty)
      (fixGL localsend)
      (fixGL musescore)
      (fixGL blender)
      (fixGL kdePackages.kdenlive)
      qpwgraph
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
      ardour

      # dwm
      (import ./src/derivations/dwm.nix ctx)
      xorg.libX11
      xorg.libXft
      xorg.libXinerama
      xorg.xdm
      dmenu
      picom
      pulseaudio
      pamixer
      pavucontrol
      playerctl
      flameshot
    ];

    file = import ./src/home_files.nix ctx;
  };

  programs.alacritty = import ./src/cfg-programs/alacritty.nix ctx;
  programs.zsh = import ./src/cfg-programs/zsh.nix ctx;
  programs.git = import ./src/cfg-programs/git.nix ctx;
  programs.tmux = import ./src/cfg-programs/tmux.nix ctx;

  fonts.fontconfig = import ./src/cfg-system/fontconfig.nix ctx;
  xdg.mimeApps = import ./src/cfg-system/mimeapps.nix ctx;
  dconf = import ./src/cfg-system/dconf.nix ctx;
  systemd.user = import ./src/cfg-system/systemd.nix ctx;
}
