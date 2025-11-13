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
      cm-super
      biblatex
      biblatex-apa
      hyperref
      ;
  };
  fixPW = import ./src/derivations/fix-pipewire.nix { inherit pkgs; };
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
      hugo
      tree-sitter
      nushell
      ast-grep
      (if IS_DESKTOP then ollama-cuda else ollama)
      openssl
      sbcl
      sbclPackages.lisp-stat
      sbclPackages.fft

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
      pyright
      ltex-ls-plus

      # languages
      go
      nodejs
      pnpm
      rustc
      cargo
      zulu23
      mytexlive
      uv
      pipx
      ruff
      tlaplusToolbox
      marksman
      clang
      clang-tools
      lld
      lldb
      libcxx
      julia-bin
      mermaid-cli

      # general terminal tools
      pdf2svg
      ffmpeg
      yazi
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
      sc-im
      librsvg
      numbat
      pandoc
      picocom
      fzf
      zenity
      (import ./src/derivations/espresso-logic.nix ctx)
      (import ./src/derivations/rddlsim.nix ctx)

      # daemons
      (import ./src/derivations/metasearch2.nix ctx)
      # activitywatch

      # basic apps
      firefox
      zathura # pdf viewer
      vlc # media viewer
      rhythmbox # music player
      pwvucontrol # audio patcher
      gnome-clocks

      # additional apps
      localsend
      (fixPW musescore)
      (fixPW ardour)
      (fixPW easyeffects)
      blender
      kdePackages.kdenlive
      anki
      qpwgraph
      foliate
      legcord
      dbeaver-bin
      # miru
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
      zotero
      ungoogled-chromium
      upscayl-ncnn
      swayimg
      (import ./src/derivations/rdfglance.nix ctx)
      rustdesk-flutter

      # dependencies necessary for winapps
      freerdp
      dialog
      netcat-openbsd
      libnotify
    ];

    file = import ./src/home_files.nix ctx;

    sessionVariables = {
      GTK_IM_MODULE = "fcitx";
      QT_IM_MODULE = "fcitx";
      XMODIFIERS = "@im=fcitx";
      SDL_IM_MODULE = "fcitx";
      TEXINPUTS = "${HOME}/texmf//:${HOME}/.config/texmf//";
    };

    sessionPath = [
      "${HOME}/bin"
      "${HOME}/go/bin"
      "${HOME}/.local/bin"
    ];

    pointerCursor = {
      name = "phinger-cursors-light";
      package = pkgs.phinger-cursors;
      size = 32;
      gtk.enable = true;
    };
  };

  programs.kitty = import ./src/cfg_programs/kitty.nix ctx;
  programs.fish = import ./src/cfg_programs/fish.nix ctx;
  programs.git = import ./src/cfg_programs/git.nix ctx;
  programs.tmux = import ./src/cfg_programs/tmux.nix ctx;
  programs.swaylock = {
    enable = true;
    settings = {
      color = "000000";
    };
  };

  programs.obs-studio = {
    enable = true;
    plugins = with pkgs.obs-studio-plugins; [
      wlrobs
      obs-pipewire-audio-capture
    ];
  };

  services.mako = {
    enable = true;
    settings = {
      width = "400";
      height = "200";
    };
  };
  services.ollama = {
    enable = true;
    package = if IS_DESKTOP then pkgs.ollama-cuda else pkgs.ollama;
    acceleration = if IS_DESKTOP then "cuda" else null;
  };
  services.syncthing = {
    enable = true;
    settings = {
      devices = {
        homeserver = {
          addresses = [
            "tcp://192.168.1.10:22000"
            "quic://192.168.1.10:22000"
          ];
          id = "VS3PDKE-TBTBRWJ-L2OTOUD-Z36HTYA-GCBUQUB-GOR5IN3-VYOPHCJ-MOJK7AZ";
        };
      };
      folders = {
        files = {
          id = "files";
          label = "Files";
          path = "${HOME}/files";
          devices = [ "homeserver" ];
          versioning = {
            type = "trashcan";
            params.cleanoutDays = "30";
          };
        };
      };
    };
  };

  dconf = import ./src/cfg_system/dconf.nix ctx;
  xdg.mimeApps = import ./src/cfg_system/mimeapps.nix ctx;
  systemd.user = import ./src/cfg_system/systemd.nix ctx;
  gtk = import ./src/cfg_system/gtk.nix ctx;

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
