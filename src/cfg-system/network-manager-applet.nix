{
  pkgs,
  lib,
  config,
  ...
}:
{
  # not using `services.network-manager-applet.enable` because it causes issues
  # with neovim because of XDG_DATA_DIRS somehow...

  systemd.user.services.network-manager-applet = {
    Unit = {
      Description = "Network Manager applet";
      Requires = [ "tray.target" ];
      After = [
        "graphical-session.target"
        "tray.target"
      ];
      PartOf = [ "graphical-session.target" ];
    };

    Install = {
      WantedBy = [ "graphical-session.target" ];
    };

    Service = {
      ExecStart = toString (
        [ (lib.getExe' pkgs.networkmanagerapplet "nm-applet") ]
        ++ lib.optional config.xsession.preferStatusNotifierItems "--indicator"
      );
    };
  };
}
