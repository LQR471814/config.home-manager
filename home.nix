{ config, pkgs, ... }:

let
  HOME = builtins.getEnv "HOME";
  thorium = import ./thorium.nix { inherit pkgs; };
  metasearch2 = import ./metasearch2.nix { inherit pkgs; };
in
{
  targets.genericLinux.enable = true;

  home.packages = with pkgs; [
    # build tools
    cmake
    make
    pkg-config

    # dev tools
    ripgrep
    fd
    zsh
    tmux
    git
    gh
    docker
    lazygit
    nix-prefetch-git

    # languages
    rye
    go
    nodejs
    pnpm
    rustc
    cargo

    # general terminal tools
    ffmpeg
    neovim
    yt-dlp
    yazi
    rclone

    # daemons
    activitywatch
    syncthing
    cups
    metasearch2

    # gui apps
    jetbrains-mono
    alacritty
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
    ueberzugpp # this is a dependency of yazi
    zathura
    legcord
    dbeaver-bin
    keepassxc
    thorium
    musescore
    ardour
    localsend
    gimp
    cloc
    xsel
    miru

    # dwm
    xorg.libX11
    xorg.libXft
    xorg.libXinerama
    xorg.xdm
    dmenu
    picom
    pavucontrol
    playerctl
    flameshot
  ];

  home.file =
    # directories in `home_files/.config/<dir>` will be symlinked to `~/.config/<dir>`
    (builtins.mapAttrs
      (name: value: ".config/" + name)
      builtins.readDir ./home_files/.config)
    //
    # directories in `home_files/<dir>` will be symlinked to `~/<dir>` besides `.config`
    (builtins.filterAttrs
      (name: value: name != ".config")
      builtins.readDir ./home_files);

  fonts.fontconfig = {
    enable = true;
    defaultFonts.monospace = [ "JetBrainsMono" ];
  };

  programs.zsh = {
    enable = true;
  };

  users.users.lqr471814.shell = pkgs.zsh;

  programs.git = {
    enable = true;
    userName = "LQR471814";
    userEmail = "42160088+LQR471814@users.noreply.github.com";
  };

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "application/pdf" = ./dotfiles/zathura/zathura.desktop;
    };
  };

  programs.dconf = {
    enable = true;
    profiles.user.databases = [
      {
        settings = {
          "org/gnome/desktop/interface" = {
            clock-format = "24h";
          };
        };
      }
    ];
  };

  systemd.user = {
    enable = true;
    services = {
      metasearch2 = {
        Unit = {
          Description = "metasearch engine, to avoid using google with an account";
        };
        Service = {
          Type = "simple";
          TimeoutStartSec = 0;
          ExecStart = "/usr/bin/env metasearch2";
          WorkingDirectory = "${HOME}/.config/metasearch2";
        };
      };
    };
  };
}
