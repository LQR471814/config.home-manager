ctx@{
  pkgs,
  HOME,
  ...
}:
let
  DIRNAME = builtins.toString ./..;

  filterAttrs =
    pred: set:
    builtins.listToAttrs (
      builtins.filter (a: pred a.name a.value) (
        builtins.attrValues (
          builtins.mapAttrs (n: v: {
            name = n;
            value = v;
          }) set
        )
      )
    );

  # directories in `home_files/.config/<dir>` will be symlinked to `~/.config/<dir>`
  dotfiles = (
    pkgs.lib.attrsets.mapAttrs' (name: value: {
      name = ".config/${name}";
      value = {
        source = DIRNAME + "/home_files/.config/" + name;
      };
    }) (filterAttrs (name: value: name != "nushell") (builtins.readDir ../home_files/.config))
  );

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
in
# `//` merges 2 attribute sets
dotfiles
// homefiles
// (import ./dotfiles/tree-sitter.nix ctx)
// (import ./dotfiles/tofi.nix ctx)
// {
  ".gnupg/gpg-agent.conf" = {
    text = "pinentry-program ${HOME}/.nix-profile/bin/pinentry";
  };
  texmf = {
    source = pkgs.mytexlive + "/share/texmf";
  };
}
