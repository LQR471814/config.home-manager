{ HOME, ... }:
let
  nixbin = name: "${HOME}/.nix-profile/bin/${name}";
  dotconfig = path: "${HOME}/.config/${path}";
in
{
  enable = true;

  # NOTE: all user systemd services have to be under the target 'default.target', no other targets exist for the user session
  services = {
    metasearch2 = {
      Unit = {
        Description = "metasearch engine";
      };
      Service = {
        Type = "simple";
        TimeoutStartSec = 0;
        ExecStart = nixbin "metasearch";
        WorkingDirectory = dotconfig "metasearch";
      };
      Install = {
        WantedBy = [ "default.target" ];
      };
    };

    fcitx5 = {
      Unit = {
        Description = "fcitx5 input method daemon";
        DefaultDependencies = "no";
      };
      Service = {
        ExecStart = nixbin "fcitx5";
        Restart = "no";
      };
      Install = { };
    };

    # aw-qt = {
    #   Unit = {
    #     Description = "activitywatch daemon";
    #     DefaultDependencies = "no";
    #   };
    #   Service = {
    #     # wrapper script is executed because aw-qt needs to call some other processes
    #     # and it cannot do that without the nix env vars being present
    #     ExecStart = "${nixbin "zsh"} -c 'aw-qt --no-gui'";
    #     Restart = "no";
    #   };
    #   Install = { };
    # };

    # awsync = {
    #   Unit = {
    #     Description = "synchronize activitywatch data";
    #   };
    #   Service = {
    #     Type = "simple";
    #     TimeoutStartSec = 0;
    #     ExecStart = nixbin "aw-sync";
    #     WorkingDirectory = HOME;
    #     Restart = "always";
    #     RestartSec = 30;
    #   };
    #   Install = {
    #     WantedBy = [ "default.target" ];
    #   };
    # };

  };
}
