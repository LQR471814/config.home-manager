{ HOME, ... }:
{
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
}
