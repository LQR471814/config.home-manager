{ pkgs, ... }@ctx:
{
  # cursor
  home.pointerCursor = {
    enable = true;
    name = "phinger-cursors-light";
    package = pkgs.phinger-cursors;
    size = 32;
    gtk.enable = true;
  };

  # desktop stuff
  wayland.systemd.target = "graphical-session.target";
  dconf = import ./cfg-system/dconf.nix ctx;
  xdg.mimeApps = import ./cfg-system/mimeapps.nix ctx;
  gtk = import ./cfg-system/gtk.nix ctx;
  i18n = import ./cfg-system/i18n.nix ctx;
}
