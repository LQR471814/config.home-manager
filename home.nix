{ config, pkgs, ... }:

let
  HOME = builtins.getEnv "HOME";
  fixGL = config.lib.nixGL.wrap;
  ctx = {
    inherit pkgs;
    inherit fixGL;
    inherit HOME;
  };
in
{
  nixGL.packages = import <nixgl> { inherit pkgs; };
  targets.genericLinux.enable = true;

  home = {
    username = "lqr471814";
    homeDirectory = HOME;
    stateVersion = "24.11";             

    packages = with pkgs; [
      home-manager
      jetbrains-mono
      nerd-fonts.jetbrains-mono

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
      atlas
      pnpm
      cloc
      pipx
      clang
      jq
      (texliveSmall.withPackages (ps: [ ps.latexmk ps.pdftex ]))

      # lsps
      nil
      texlab
      lua-language-server
      vtsls
      tailwindcss-language-server
      svelte-language-server
      gopls
      biome
      black

      # languages
      rye
      go
      nodejs
      pnpm
      rustc
      cargo
      numbat

      # general terminal tools
      ffmpeg
      neovim
      yt-dlp
      yazi
      rclone
      ffmpeg
      btop
      xsel
      rclone
      mprocs

      # daemons
      (import ./src/derivations/metasearch2.nix ctx)
      activitywatch
      syncthing
      cups

      # gui apps
      (import ./src/derivations/thorium.nix ctx)
      (fixGL alacritty)
      ueberzugpp # this is a dependency of yazi
      zathura
      legcord
      dbeaver-bin
      localsend
      miru
      keepassxc
      tor-browser
      thunderbird
      obsidian
      libreoffice
      gimp
      inkscape
      musescore
      ardour
      blender

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
