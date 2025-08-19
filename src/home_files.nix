{
  pkgs,
  mytexlive,
  HOME,
  ...
}:
let
  DIRNAME = builtins.toString ./..;

  # directories in `home_files/.config/<dir>` will be symlinked to `~/.config/<dir>`
  dotfiles =
    (pkgs.lib.attrsets.mapAttrs' (name: value: {
      name = ".config/${name}";
      value = {
        source = DIRNAME + "/home_files/.config/" + name;
      };
    }) (builtins.readDir ../home_files/.config))
    // {
      ".gnupg/gpg-agent.conf" = {
        text = "pinentry-program ${HOME}/.nix-profile/bin/pinentry";
      };
    };

  # directories in `home_files/<dir>` will be symlinked to `~/<dir>` besides `.config` and `.thunderbird`
  homefiles = (
    pkgs.lib.attrsets.mapAttrs'
      (name: value: {
        inherit name;
        value = {
          source = DIRNAME + "/home_files/" + name;
        };
      })
      (
        pkgs.lib.attrsets.filterAttrs (
          name: value:
          !(builtins.elem name [
            ".config"
            ".thunderbird"
          ])
        ) (builtins.readDir ../home_files)
      )
  );

  # thunderbird has special handling
  tbfiles =
    if builtins.pathExists "${HOME}/.thunderbird" then
      let
        tbdir = builtins.readDir "${HOME}/.thunderbird";
        tbprofilename = builtins.head (
          builtins.filter (name: builtins.match ".*\\.default" name != null) (builtins.attrNames tbdir)
        );
      in
      {
        ".thunderbird/${tbprofilename}/user.js" = {
          source = DIRNAME + "/home_files/.thunderbird/user.js";
        };
      }
    else
      { };

  texfiles = {
    texmf = {
      source = mytexlive + "/share/texmf";
    };
  };

  pluginfiles =
    if
      (builtins.pathExists "${HOME}/Production/Plugins/lv2")
      && (builtins.pathExists "${HOME}/Production/Plugins/vst3")
    then
      {
        ".lv2" = {
          source = "${HOME}/Production/Plugins/lv2";
        };
        ".vst3" = {
          source = "${HOME}/Production/Plugins/vst3";
        };
      }
    else
      { };
in
# `//` merges 2 attribute sets
dotfiles // homefiles // texfiles // tbfiles // pluginfiles
