{ pkgs, mytexlive, HOME, ... }:
let
  DIRNAME = builtins.toString ./..;

  # directories in `home_files/.config/<dir>` will be symlinked to `~/.config/<dir>`
  dotfiles = (pkgs.lib.attrsets.mapAttrs'
    (name: value: {
      name = ".config/${name}";
      value = { source = DIRNAME + "/home_files/.config/" + name; };
    })
    (builtins.readDir ../home_files/.config));

  # directories in `home_files/<dir>` will be symlinked to `~/<dir>` besides `.config`
  homefiles = (pkgs.lib.attrsets.mapAttrs'
    (name: value: {
      inherit name;
      value = { source = DIRNAME + "/home_files/" + name; };
    })
    (pkgs.lib.attrsets.filterAttrs
      (name: value: !(builtins.elem name [".config"]))
      (builtins.readDir ../home_files)));
  
  texfiles = {
    texmf = {
      source = mytexlive + "/share/texmf";
    };
  };
in
  # `//` merges 2 attribute sets
  dotfiles // homefiles // texfiles // {
    ".lv2" = {
      source = "${HOME}/Production/Plugins/lv2";
    };
    ".vst3" = {
      source = "${HOME}/Production/Plugins/vst3";
    };
  }
