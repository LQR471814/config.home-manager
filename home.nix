{
  config,
  pkgs,
  nixgl,
  ...
}:

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
  fixPW = import ./src/derivations/fix_pipewire.nix { inherit pkgs; };
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
    packages = nixgl.packages;
    defaultWrapper = if IS_DESKTOP then "nvidia" else "mesa";
  };
  targets.genericLinux.enable = true;

  home = {
    username = "lqr471814";
    homeDirectory = HOME;
    stateVersion = "25.05";

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
      mercurial
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
      clang-tools
      bear
      jq
      reftools
      uv
      ruff
      sqlite
      redis
      croc
      graphviz
      llama-cpp
      hugo
      tlaplusToolbox

      # (if IS_DESKTOP then cudaPackages.cudatoolkit else null)

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
      bluetuith
      socat
      xray
      tun2socks

      # daemons
      (import ./src/derivations/metasearch2.nix ctx)
      activitywatch
      syncthing
      cups
      v2rayn

      # gui apps
      (import ./src/derivations/thorium.nix ctx)
      (fixGL alacritty)
      (fixGL localsend)
      (fixPW (fixGL musescore))
      (fixPW (fixGL ardour))
      (fixPW (fixGL easyeffects))
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
      nyxt

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

    sessionVariables = {
      BROWSER = "thorium-browser";
    };

    file = import ./src/home_files.nix ctx;
  };

  programs.alacritty = import ./src/cfg_programs/alacritty.nix ctx;
  programs.zsh = import ./src/cfg_programs/zsh.nix ctx;
  programs.git = import ./src/cfg_programs/git.nix ctx;
  programs.tmux = import ./src/cfg_programs/tmux.nix ctx;
  services.syncthing = import ./src/cfg_programs/syncthing.nix ctx;

  fonts.fontconfig = import ./src/cfg_system/fontconfig.nix ctx;
  xdg.mimeApps = import ./src/cfg_system/mimeapps.nix ctx;
  dconf = import ./src/cfg_system/dconf.nix ctx;
  systemd.user = import ./src/cfg_system/systemd.nix ctx;

  # the systemd daemon created by this doesn't start automatically
  # because I am running dwm, therefore fcitx5 is started in ~/.dwm/autostart.sh
  i18n.inputMethod.enable = true;
  i18n.inputMethod.type = "fcitx5";
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
