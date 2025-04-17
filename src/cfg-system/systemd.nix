{ HOME, ... }:
let 
  nixbin = name: "${HOME}/.nix-profile/bin/${name}";
  dotconfig = path: "${HOME}/.config/${path}";
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

    awsync = {
      Unit = {
        Description = "synchronize activitywatch data";
      };
      Service = {
        Type = "simple";
        TimeoutStartSec = 0;
        ExecStart = nixbin "aw-sync";
        WorkingDirectory = HOME;
        Restart = "always";
        RestartSec = 30;
      };
      Install = {
        WantedBy = [ "default.target" ];
      };
    };

    # the following are services that do not have a dependency because they are run in .dwm/autostart.sh
    dwm-bar = {
      Unit = {
        Description = "dwm-bar scripts";
        DefaultDependencies = "no";
      };
      Service = {
        ExecStart = dotconfig "dwm-bar/dwm_bar.sh";
        Restart = "no";
      };
      Install = {};
    };

    picom = {
      Unit = {
        Description = "picom X compositor";
        DefaultDependencies = "no";
      };
      Service = {
        ExecStart = "${nixbin "picom"} --config ${dotconfig "picom/picom.conf"}";
        Restart = "no";
      };
      Install = {};
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
      Install = {};
    };

    aw-qt = {
      Unit = {
        Description = "activitywatch daemon";
        DefaultDependencies = "no";
      };
      Service = {
        # wrapper script is executed because aw-qt needs to call some other processes
        # and it cannot do that without the nix env vars being present
        ExecStart = "${HOME}/bin/aw-qt-with-nix";
        Restart = "no";
      };
      Install = {};
    };

    slock = {
      Unit = {
        Description = "lock screen";
        DefaultDependencies = "no";
      };
      Service = {
        ExecStart = "${nixbin "xss-lock"} -- ${nixbin "slock"}";
        Restart = "no";
      };
      Install = {};
    };
  };
}
