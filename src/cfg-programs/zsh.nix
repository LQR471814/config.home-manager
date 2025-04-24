{ HOME, pkgs, ... }:
{
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
    ls = "ls --color=auto";
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

    export PATH="$HOME/bin:$PATH"
    export PATH="$HOME/go/bin:$PATH"

    export TEXINPUTS="${HOME}/texmf//:${HOME}/.config/texmf//"
  '';
}
