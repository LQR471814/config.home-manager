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
      Install = {
        WantedBy = [ "default.target" ];
      };
    };
    awsync = {
      Unit = {
        Description = "synchronize activitywatch data";
      };
      Service = {
        Type = "simple";
        TimeoutStartSec = 0;
        ExecStart = "${HOME}/.nix-profile/bin/aw-sync";
        WorkingDirectory = HOME;
        Restart = "always";
        RestartSec = 30;
      };
      Install = {
        WantedBy = [ "network.target" ];
      };
    };
    syncthing = {
      Unit = {
        Description = "synchronize files";
        Documentation = "man:syncthing(1)";
        After = "network.target";
        StartLimitIntervalSec = 60;
        StartLimitBurst = 4;
      };
      Service = {
        Type = "simple";
        TimeoutStartSec = 0;
        ExecStart = "${HOME}/.nix-profile/bin/syncthing serve --no-browser --no-restart --logflags=0";
        WorkingDirectory = HOME;
        Restart = "on-failure";
        RestartSec = 1;
        SuccessExitStatus = "3 4";
        RestartForceExitStatus = "3 4";

        ProtectSystem = "full";
        PrivateTmp = true;
        SystemCallArchitectures = "native";
        MemoryDenyWriteExecute = true;
        NoNewPrivileges = true;
      };
      Install = {
        WantedBy = [ "network.target" ];
      };
    };
  };
}
