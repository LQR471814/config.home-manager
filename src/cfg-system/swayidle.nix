{ IS_LAPTOP, pkgs, lib, ... }:
{
  services.swayidle = {
  enable = IS_LAPTOP;
  events = {
    "before-sleep" = "${lib.getExe' pkgs.swaylock "swaylock"} -f";
  };
  timeouts = [
    {
      timeout = 600;
      command = "/run/current-system/sw/bin/systemctl suspend";
    }
  ];
};
}
