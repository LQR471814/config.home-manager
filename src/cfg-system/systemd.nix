{
  HOME,
  SYSTEM_BIN,
  pkgs,
  ...
}:
let
  in-river-session = {
    Unit = {
      # when river-session.target started, this must be started (or running)
      # (unlike bind, it does not start river-session.target if it is not started)
      Requisite = [ "river-session.target" ];
      After = [ "river-session.target" ];
      # When river-sesion.target is stopped or restarted, this service is
      # also stopped/restarted
      PartOf = [ "river-session.target" ];
    };
    Install.WantedBy = [ "river-session.target" ];
  };
  # in-graphical-session = {
  #   Unit = {
  #     Requisite = [ "graphical-session.target" ];
  #     After = [ "graphical-session.target" ];
  #     PartOf = [ "graphical-session.target" ];
  #   };
  #   Install.WantedBy = [ "graphical-session.target" ];
  # };
in
{
  enable = true;

  # default.target (builtin) - start up right as user logs in
  # river-session.target - start up after river specifically has started
  # graphical-session.target (builtin) - start up after wayland compositor is started
  targets = {
    river-session = {
      Unit = {
        Description = "River session.";
        Documentation = [ "man:systemd.target(5)" ];
        # to start this target, graphical-session.target also needs to be
        # started.
        BindsTo = [ "graphical-session.target" ];
        # if something stops graphical-session.target, this target also needs
        # to be stopped
        PartOf = [ "graphical-session.target" ];
        # river-session.target must be reached before graphical-session.target
        Before = [ "graphical-session.target" ];
        # prevent systemd --user start <this target>
        RefuseManualStart = "yes";
        StopWhenUnneeded = "yes";
      };
    };
  };

  services = {
    river = {
      Unit = {
        Description = "River wayland compositor";
        Documentation = [ "man:river(1)" ];
        BindsTo = [ "river-session.target" ];
        PartOf = [ "river-session.target" ];
        Before = [ "river-session.target" ];
      };
      Service = {
        # process is classified as "started" when the process notifies systemd
        # that it has "started" rather than the point right when it is executed
        #
        # this "notification" comes inside the end of the river/init file
        Type = "notify";
        # since we will emit the notification from the end of river/init and not the
        # river process itself, we must include this option to allow notification from
        # any process
        NotifyAccess = "all";
        # remove environment variables set by river compositor after it exits
        ExecStopPost = "${SYSTEM_BIN}/systemctl --user unset-environment WAYLAND_DISPLAY DISPLAY XCURSOR_SIZE XDG_CURRENT_DESKTOP";
        # slice with slightly higher priority on resources
        Slice = "session.slice";
        ExecStart = "${SYSTEM_BIN}/river";
        Restart = "on-failure";
        RestartSec = 2;
        UnsetEnvironment = [
          "WAYLAND_DISPLAY"
          "DISPLAY"
          "WLR_BACKENDS"
        ];
        # because rootless kind requires `Delegate=yes` for the systemd service
        # that owns the process running `kind`
        # (https://kind.sigs.k8s.io/docs/user/rootless/) and `Delegate=yes` is
        # not inherited from parent systemd services, we must explicitly set
        # Delegate=yes on river.service because it owns the terminal that is
        # likely to be running `kind create cluster`
        Delegate = "yes";
      };
    };

    sandbar = in-river-session // {
      Unit = {
        Description = "Bar for river compositor.";
      };
      Service = {
        Type = "simple";
        ExecStart = "${pkgs.nushell}/bin/nu ${HOME}/.config/river/bar.nu";
        WorkingDirectory = "${HOME}/.config/river";
        Restart = "always";
      };
    };

    paisa = {
      Unit = {
        Description = "Personal finance tool.";
      };
      Service = {
        Type = "simple";
        ExecStart = "${pkgs.paisa}/bin/paisa serve";
        WorkingDirectory = "${HOME}/Documents";
        Restart = "always";
      };
      Install.WantedBy = [ "graphical-session.target" ];
    };

    # temporis = {
    #   Unit = {
    #     Description = "Temporis web client.";
    #     After = [ "network.target" ];
    #   };
    #   Service = {
    #     ExecStart = "${pkgs.static-web-server}/bin/static-web-server --port 4111 --root ${HOME}/Code/temporis/dist";
    #     Restart = "on-failure";
    #   };
    #   Install.WantedBy = [ "default.target" ];
    # };

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
  timers = {
    darkman-morning-dark = {
      Unit.Description = "Keeps darkman in dark mode for the start of the day.";
      Timer = {
        OnCalendar = "*-*-* 07:00:00";
        Persistent = true;
      };
      Install.WantedBy = [ "timers.target" ];
    };
    darkman-morning-light = {
      Unit.Description = "Make darkman light later.";
      Timer = {
        OnCalendar = "*-*-* 07:05:00";
        Persistent = true;
      };
      Install.WantedBy = [ "timers.target" ];
    };
  };
}
