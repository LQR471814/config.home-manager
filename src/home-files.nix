{
  pkgs,
  HOME,
  ...
}@ctx:
let
  DIRNAME = toString ./..;

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

  # directories in `home-files/.config/<dir>` will be symlinked to `~/.config/<dir>`
  dotfiles = pkgs.lib.attrsets.mapAttrs' (name: value: {
    name = ".config/${name}";
    value = {
      source = DIRNAME + "/home-files/.config/" + name;
    };
  }) (filterAttrs (name: value: name != "nushell") (builtins.readDir ../home-files/.config));

  # directories in `home-files/<dir>` will be symlinked to `~/<dir>` besides `.config` and `.thunderbird`
  homefiles =
    pkgs.lib.attrsets.mapAttrs'
      (name: value: {
        inherit name;
        value = {
          source = DIRNAME + "/home-files/" + name;
        };
      })
      (
        pkgs.lib.attrsets.filterAttrs (
          name: value:
          !(builtins.elem name [
            ".config"
            ".thunderbird"
          ])
        ) (builtins.readDir ../home-files)
      );
in
{
  # `//` merges 2 attribute sets
  home.file =
    dotfiles
    // homefiles
    // (import ./dotfiles/tree-sitter.nix ctx)
    // (import ./dotfiles/tofi.nix ctx)
    // {
      ".gnupg/gpg-agent.conf" = {
        text = "pinentry-program ${HOME}/.nix-profile/bin/pinentry";
      };
    }
    // (
      let
        cfg = import ./cfg-programs/ast-grep.nix { inherit pkgs; };
        src = (pkgs.formats.yaml { }).generate "config.yaml" cfg;
      in
      {
        "sgconfig.yaml" = {
          source = "${src}";
        };
      }
    )
    // (
      let
        stignore = {
          text = builtins.readFile ../.stignore;
        };
      in
      {
        "Applications/.stignore" = stignore;
        "Books/.stignore" = stignore;
        "Documents/.stignore" = stignore;
        "Music/.stignore" = stignore;
      }
    );
}
