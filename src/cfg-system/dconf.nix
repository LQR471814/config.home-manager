{ ... }:
{
  enable = true;
  settings = {
    "org/gnome/desktop/interface" = {
      clock-format = "24h";
      gtk-theme = "Adwaita-dark";
      color-scheme = "prefer-dark";
    };
    "org/gnome/desktop/peripherals/touchpad" = {
      natural-scroll = false;
    };
  };
}
