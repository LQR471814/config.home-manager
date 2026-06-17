{ IS_LAPTOP, pkgs, ... }:
{
  enable = IS_LAPTOP;
  events = {
    "before-sleep" = "${pkgs.swaylock}/bin/swaylock -f --fingerprint";
  };
  timeouts = [
    {
      timeout = 600;
      command = "/run/current-system/sw/bin/systemctl suspend";
    }
  ];
}
