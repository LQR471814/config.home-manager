# wayland display configuration
{ ... }:
{
  enable = true;
  settings = [
    {
      profile.name = "desktop";
      profile.outputs = [
        {
          criteria = "Dell Inc. DELL S2725QS 21SDT84";
          status = "enable";
          mode = "3840x2160@120.000000Hz";
          position = "0,0";
          scale = 2.0;
          adaptiveSync = true;
        }
        {
          criteria = "LG Electronics 27GL650F 910NTDV3G842";
          status = "enable";
          mode = "1920x1080@144.001007Hz";
          position = "1920,0";
          scale = 1.0;
          adaptiveSync = true;
        }
      ];
    }
    {
      profile.name = "laptop";
      profile.outputs = [
        {
          criteria = "eDP-1";
          status = "enable";
          mode = "2560x1600@90.000999Hz";
          scale = 1.5;
          adaptiveSync = true;
        }
      ];
    }
    {
      profile.name = "laptop-docked";
      profile.outputs = [
        {
          criteria = "eDP-1";
          status = "disable";
        }
        {
          criteria = "Dell Inc. DELL S2725QS 21SDT84";
          status = "enable";
          mode = "3840x2160@60.000000Hz";
          scale = 2.0;
          adaptiveSync = false;
          position = "0,0";
        }
        {
          criteria = "LG Electronics 27GL650F 910NTDV3G842";
          status = "enable";
          mode = "1920x1080@120.000000Hz";
          scale = 1.0;
          adaptiveSync = false;
          position = "1920,0";
        }
      ];
    }
  ];
}
