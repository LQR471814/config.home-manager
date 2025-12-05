# wayland display configuration
{ ... }:
{
  enable = true;
  settings = [
    {
      output = {
        criteria = "DP-1";
        status = "enable";
        mode = "3840x2160@120.000000Hz";
        position = "0,0";
        scale = 2.0;
        adaptiveSync = true;
      };
    }
    {
      output = {
        criteria = "HDMI-A-1";
        status = "enable";
        mode = "1920x1080@144.001007Hz";
        position = "1920,0";
        scale = 1.0;
        adaptiveSync = true;
      };
    }
    {
      output = {
        criteria = "eDP-1";
        status = "enable";
        mode = "2560x1600@90.000999Hz";
        scale = 1.5;
        adaptiveSync = true;
      };
    }
  ];
}
