{ IS_LAPTOP, pkgs, ... }:
{
  enable = IS_LAPTOP;
  events = [
    {
      event = "before-sleep";
      command = "${pkgs.swaylock}/bin/swaylock -f";
    }
  ];
  timeouts = [
    {
      timeout = 600;
      command = "/run/current-system/sw/bin/systemctl suspend";
    }
  ];
}
