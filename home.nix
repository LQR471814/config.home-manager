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

  nu-lint = pkgs.callPackage (pkgs.fetchFromGitHub {
    owner = "wvhulle";
    repo = "nu-lint";
    rev = "905635ab0cb980fd15d29949cb08337375db8032";
    sha256 = "sha256-FaL7iF9cMC6/VF5QbgfIQhUBs3TtsXcuoOyqrK1PwpI=";
  }) { };

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
      dvipng
      standalone
      varwidth
      preview
      cm-super
      biber
      biblatex
      biblatex-apa
      biblatex-mla
      hyperref
      setspace
      texcount
      fontspec
      ctex
      xecjk
      enumitem
      moderncv
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
  # packages
  home.packages = with pkgs; [
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
    nixfmt
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
    deno
    pnpm
    rustc
    cargo
    zulu
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
    claude-code
    qpdf
    nu-lint
    imv

    # daemons
    # (import ./src/derivations/metasearch2.nix ctx)
    # metasearch2
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
    (import ./src/derivations/zotero.nix ctx)
    ungoogled-chromium
    upscayl-ncnn
    (import ./src/derivations/rdfglance.nix ctx)
    rustdesk-flutter
    linvstmanager
    wineWowPackages.stable
    winetricks
    # dependencies necessary for winapps
    freerdp
    dialog
    netcat-openbsd
    libnotify
    freecad
    android-studio
    httptoolkit
    httptoolkit-server
    sway-audio-idle-inhibit
  ];

  # basic configuration
  home.username = "lqr471814";
  home.homeDirectory = HOME;
  home.stateVersion = "25.11";

  # home files (.config, etc...)
  home.file = import ./src/home_files.nix ctx;

  # env vars
  home.sessionVariables = {
    CC = "${pkgs.clang}/bin/clang";
    GTK_IM_MODULE = "fcitx";
    QT_IM_MODULE = "fcitx";
    XMODIFIERS = "@im=fcitx";
    SDL_IM_MODULE = "fcitx";
    TEXINPUTS = "${HOME}/texmf//:${HOME}/.config/texmf//";
  };
  home.sessionPath = [
    "${HOME}/bin"
    "${HOME}/go/bin"
    "${HOME}/.local/bin"
  ];

  # cursor
  home.pointerCursor = {
    name = "phinger-cursors-light";
    package = pkgs.phinger-cursors;
    size = 32;
    gtk.enable = true;
  };

  # userland program configuration

  programs.kitty = import ./src/cfg_programs/kitty.nix ctx;
  programs.fish = import ./src/cfg_programs/fish.nix ctx;
  programs.git = import ./src/cfg_programs/git.nix ctx;
  programs.tmux = import ./src/cfg_programs/tmux.nix ctx;
  programs.swaylock = import ./src/cfg_programs/swaylock.nix ctx;
  programs.obs-studio = import ./src/cfg_programs/obs-studio.nix ctx;
  services.ollama = import ./src/cfg_programs/ollama.nix ctx;
  services.syncthing = import ./src/cfg_programs/syncthing.nix ctx;
  programs.bluetuith.enable = true;

  # wayland stuff
  services.mako = import ./src/cfg_system/mako.nix ctx;
  services.kanshi = import ./src/cfg_system/kanshi.nix ctx;

  # xdg and desktop stuff
  dconf = import ./src/cfg_system/dconf.nix ctx;
  xdg.mimeApps = import ./src/cfg_system/mimeapps.nix ctx;
  gtk = import ./src/cfg_system/gtk.nix ctx;
  i18n = import ./src/cfg_system/i18n.nix ctx;

  # systemd
  systemd.user = import ./src/cfg_system/systemd.nix ctx;

  # sleep & idle lock
  services.swayidle = {
    enable = true;

    events = [
      {
        event = "before-sleep";
        command = "${pkgs.swaylock}/bin/swaylock";
      }
      {
        event = "lock";
        command = "${pkgs.swaylock}/bin/swaylock";
      }
    ];
    timeouts = [
      {
        timeout = 600;
        command = "/run/current-system/sw/bin/systemctl suspend";
      }
    ];
  };
}
