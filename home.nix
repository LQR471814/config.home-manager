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
      varwidth
      preview
      biber
      ;
  };
  fixPW = import ./src/derivations/fix_pipewire.nix { inherit pkgs; };
  ctx = {
    inherit HOME;
    inherit HOSTNAME;
    inherit IS_DESKTOP;
    inherit IS_LAPTOP;

    inherit pkgs;
    inherit config;
    inherit mytexlive;
  };
in
{
  home = {
    username = "lqr471814";
    homeDirectory = HOME;
    stateVersion = "25.05";

    packages = with pkgs; [
      # build tools
      cmake
      gnumake
      pkg-config
      git
      tmux
      git
      git-filter-repo
      git-credential-manager
      gh

      # dev tools
      ripgrep
      fd
      docker
      lazygit
      nix-prefetch-git
      buf
      cloc
      sqlc
      atlas
      templ
      bear
      jq
      reftools
      sqlite
      redis
      croc
      graphviz
      llama-cpp
      hugo
      tree-sitter

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
      zulu23
      mytexlive
      uv
      pipx
      ruff
      tlaplusToolbox
      clang
      clang-tools

      # general terminal tools
      pdf2svg
      ffmpeg
      yazi
      ueberzugpp # this is a dependency of yazi
      rclone
      ffmpeg
      htop
      btop
      rclone
      mprocs
      tree
      sshfs
      aria2
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
      playerctl
      ghostscript
      mermaid-cli

      # daemons
      (import ./src/derivations/metasearch2.nix ctx)
      # activitywatch
      cups

      # basic apps
      firefox
      zathura # pdf viewer
      vlc # media viewer
      rhythmbox # music player
      pwvucontrol # audio patcher

      # additional apps
      localsend
      (fixPW musescore)
      (fixPW ardour)
      (fixPW easyeffects)
      blender
      kdePackages.kdenlive
      obs-studio
      anki
      qpwgraph
      foliate
      legcord
      dbeaver-bin
      miru
      keepassxc
      tor-browser
      thunderbird
      libreoffice
      gimp3
      inkscape
      scribus
      filezilla
      qbittorrent-enhanced
      usbimager
      nextcloud-client
    ];

    file = import ./src/home_files.nix ctx;

    sessionVariables = {
      GTK_IM_MODULE = "fcitx";
      QT_IM_MODULE = "fcitx";
      XMODIFIERS = "@im=fcitx";
      SDL_IM_MODULE = "fcitx";
    };

    pointerCursor = {
      name = "phinger-cursors-light";
      package = pkgs.phinger-cursors;
      size = 32;
      gtk.enable = true;
    };
  };

  programs.kitty = import ./src/cfg_programs/kitty.nix ctx;
  programs.zsh = import ./src/cfg_programs/zsh.nix ctx;
  programs.git = import ./src/cfg_programs/git.nix ctx;
  programs.tmux = import ./src/cfg_programs/tmux.nix ctx;
  programs.swaylock.enable = true;

  dconf = import ./src/cfg_system/dconf.nix ctx;
  xdg.mimeApps = import ./src/cfg_system/mimeapps.nix ctx;
  systemd.user = import ./src/cfg_system/systemd.nix ctx;
  gtk.enable = true;
  gtk.iconTheme = {
    name = "Papirus-Light";
    package = pkgs.papirus-icon-theme;
  };

  # the systemd daemon created by this doesn't start automatically
  # because I am running dwm, therefore fcitx5 is started in ~/.dwm/autostart.sh
  i18n.inputMethod.enable = true;
  i18n.inputMethod.type = "fcitx5";
  i18n.inputMethod.fcitx5.addons = with pkgs; [
    fcitx5-gtk
    libsForQt5.fcitx5-qt
    libsForQt5.fcitx5-chinese-addons
  ];
}
