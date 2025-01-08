{ config, pkgs, ... }:

let
  HOME = builtins.getEnv "HOME";
  DIRNAME = builtins.toString ./.;
  fixGL = config.lib.nixGL.wrap;
  thorium = import ./thorium.nix { inherit pkgs; };
  metasearch2 = import ./metasearch2.nix { inherit pkgs; };
in
{
  nixGL.packages = import <nixgl> { inherit pkgs; };
  targets.genericLinux.enable = true;

  home = {
    username = "lqr471814";
    homeDirectory = "/home/lqr471814";
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
      gh
      docker
      lazygit
      nix-prefetch-git
      nil
      buf
      atlas
      pnpm
      cloc

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

      # daemons
      activitywatch
      syncthing
      cups
      metasearch2

      # gui apps
      (fixGL alacritty)
      ueberzugpp # this is a dependency of yazi
      zathura
      legcord
      dbeaver-bin
      localsend
      miru
      keepassxc
      thorium
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

    file = let
      # directories in `home_files/.config/<dir>` will be symlinked to `~/.config/<dir>`
      dotfiles = (pkgs.lib.attrsets.mapAttrs'
        (name: value: {
          name = ".config/${name}";
          value = { source = DIRNAME + "/home_files/.config/" + name; };
        })
        (builtins.readDir ./home_files/.config));

      # directories in `home_files/<dir>` will be symlinked to `~/<dir>` besides `.config`
      homefiles = (pkgs.lib.attrsets.mapAttrs'
        (name: value: {
          inherit name;
          value = { source = DIRNAME + "/home_files/" + name; };
        })
        (pkgs.lib.attrsets.filterAttrs
          (name: value: name != ".config")
          (builtins.readDir ./home_files)));
      in
        # `//` merges the 2 attribute sets
        dotfiles // homefiles;
  };

  programs.alacritty = {
    enable = true;
    package = fixGL pkgs.alacritty;
    settings = {
      font = {
        size = 6;
        normal = {
          family = "JetBrainsMono NF";
          style = "Mono";
        };
        bold = {
          family = "JetBrainsMono NF";
          style = "Bold";
        };
        italic = {
          family = "JetBrainsMono NF";
          style = "Italic";
        };
      };
      window = {
        dynamic_padding = true;
      };
      env = {
        TERM = "xterm-256color";
      };
      keyboard = {
        bindings = [
          { key = "Key0"; mods = "Control"; chars = "\u001b[48;5u"; }
          { key = "Key1"; mods = "Control"; chars = "\u001b[49;5u"; }
          { key = "Key2"; mods = "Control"; chars = "\u001b[50;5u"; }
          { key = "Key3"; mods = "Control"; chars = "\u001b[51;5u"; }
          { key = "Key4"; mods = "Control"; chars = "\u001b[52;5u"; }
          { key = "Key5"; mods = "Control"; chars = "\u001b[53;5u"; }
          { key = "Key6"; mods = "Control"; chars = "\u001b[54;5u"; }
          { key = "Key7"; mods = "Control"; chars = "\u001b[55;5u"; }
          { key = "Key8"; mods = "Control"; chars = "\u001b[56;5u"; }
          { key = "Key9"; mods = "Control"; chars = "\u001b[57;5u"; }
          { key = "F11"; action = "ToggleFullscreen"; }
        ];
      };
    };
  };

  programs.zsh = {
    enable = true;
    enableCompletion = false;
    zprof = {
      enable = false;
    };
    history = {
      append = true;
      ignoreAllDups = true;
    };
    shellAliases = {
      lzg = "lazygit";
      y = "yazi";
    };
    plugins = [
      {
        name = "alien-minimal";
        src = pkgs.fetchFromGitHub {
          owner = "eendroroy";
          repo = "alien-minimal";
          rev = "1.5.0";
          hash = "sha256-OQQHzYbmQgzwbUE7zsmEHl93S3OiaoCj1WrfPIyfhmM=";
          fetchSubmodules = true;
        };
      }
      {
        name = "zsh-vi-mode";
        src = pkgs.fetchFromGitHub {
          owner = "jeffreytse";
          repo = "zsh-vi-mode";
          rev = "v0.11.0";
          hash = "sha256-xbchXJTFWeABTwq6h4KWLh+EvydDrDzcY9AQVK65RS8=";
        };
      }
      {
        name = "zsh-system-clipboard";
        src = pkgs.fetchFromGitHub {
          owner = "kutsan";
          repo = "zsh-system-clipboard";
          rev = "v0.8.0";
          hash = "sha256-VWTEJGudlQlNwLOUfpo0fvh0MyA2DqV+aieNPx/WzSI=";
        };
      }
    ];
    initExtra = ''
      ({
        autoload -Uz compinit
        # only run compinit once per day, instead of on startup
        if [ $(date +'%j') != $(date -d "$(stat -c %y ~/.zcompdump | cut -d' ' -f1)" +%j) ]; then
          compinit
        else
          compinit -C
        fi
      } &) > /dev/null 2>&1

      # system clipboard workaround
      zvm_vi_yank () {
	zvm_yank
	printf %s "$CUTBUFFER" | xsel --clipboard --input
	zvm_exit_visual_mode
      }
    '';
  };

  programs.git = {
    enable = true;
    userName = "LQR471814";
    userEmail = "42160088+LQR471814@users.noreply.github.com";
  };

  fonts.fontconfig = {
    enable = true;
    defaultFonts.monospace = [ "JetBrainsMono" ];
  };

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "application/pdf" = ["org.pwmt.zathura.desktop"];
    };
  };

  dconf = {
    enable = true;
    settings = {
      "org/gnome/desktop/interface" = {
        clock-format = "24h";
      };
    };
  };

  systemd.user = {
    enable = true;
    services = {
      metasearch = {
        Unit = {
          Description = "metasearch engine, to avoid using google with an account";
        };
        Service = {
          Type = "simple";
          TimeoutStartSec = 0;
          ExecStart = "${HOME}/.nix-profile/bin/metasearch";
          WorkingDirectory = "${HOME}/.config/metasearch";
        };
      };
    };
  };
}
