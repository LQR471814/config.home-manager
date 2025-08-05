{ HOME, ... }:
let
  nixbin = name: "${HOME}/.nix-profile/bin/${name}";
  dotconfig = path: "${HOME}/.config/${path}";
  PATH = "${HOME}/bin:${HOME}/.nix-profile/bin:/nix/var/nix/profiles/default/bin:${HOME}/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin";
in
{
  enable = true;
  # NOTE: all user systemd services have to be under the target 'default.target', no other targets exist for the user session
  services = {
    metasearch = {
      Unit = {
        Description = "metasearch engine, to avoid using google with an account";
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
  };
}
