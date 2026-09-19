{ config, ... }:
{
  services.wayland-pipewire-idle-inhibit = {
  enable = true;
  systemdTarget = config.wayland.systemd.target;
  settings = {
    verbosity = "INFO";
    idle_inhibitor = "wayland";
  };
};
}
