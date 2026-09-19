{ pkgs, ... }:
{
  imports = [
    ./cfg-system/dconf.nix
    ./cfg-system/mimeapps.nix
    ./cfg-system/gtk.nix
    ./cfg-system/i18n.nix
  ];

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
}
