{ IS_DESKTOP, ... }:
let
  folders = {
    # digital media creation
    ardour = {
      id = "ardour";
      label = "Ardour";
      path = "~/Documents/Ardour";
      type = "sendreceive";
    };
    blender = {
      id = "blender";
      label = "Blender";
      path = "~/Documents/Blender";
      type = "sendreceive";
    };
    musescore = {
      id = "musescore";
      label = "Musescore";
      path = "~/Documents/Musescore4";
      type = "sendreceive";
    };
    production = {
      id = "production";
      label = "Production";
      path = "~/Production";
      type = "sendreceive";
    };
    media = {
      id = "media";
      label = "Media";
      path = "~/Media";
      type = "sendreceive";
    };

    # writing material
    latex = {
      id = "latex";
      label = "Latex";
      path = "~/Documents/latex";
      type = "sendreceive";
    };
    obsidian = {
      id = "obsidian";
      label = "Obsidian";
      path = "~/Documents/obsidian";
      type = "sendreceive";
    };
    itemarchive = {
      id = "itemarchive";
      label = "Item Archive";
      path = "~/Documents/item-archive";
      type = "sendreceive";
    };

    # reading material
    books = {
      id = "books";
      label = "Books";
      path = "~/Books";
      type = "sendreceive";
    };
    scores = {
      id = "scores";
      label = "Scores";
      path = "~/Scores";
      type = "sendreceive";
    };
    music = {
      id = "music";
      label = "Music";
      path = "~/Music";
      type = "sendreceive";
    };

    # for programs
    activitywatch = {
      id = "activitywatch";
      label = "Activitywatch";
      path = "~/ActivityWatchSync";
      type = "sendreceive";
    };
    keeshare = {
      id = "keeshare";
      label = "Keeshare";
      path = "~/Keeshare";
      type = "sendreceive";
    };
    inkscape-prefs = {
      id = "inkscape-prefs";
      label = "Inkscape Preferences";
      path = "~/.config/inkscape";
      type = "sendreceive";
    };
  };
in
{
  enable = true;
  cert = "~/syncthing/cert.pem";
  key = "~/syncthing/key.pem";
}
// (
  if IS_DESKTOP then
    {
      settings.devices = {
        laptop = {
          id = "N2RFYOY-QK7M4RX-JIRSU32-7LFAOZD-VJPMUBB-MU5KONB-NETKDXR-UWHCXQT";
          name = "Laptop";
        };
        raspberrypi = {
          id = "VS3PDKE-TBTBRWJ-L2OTOUD-Z36HTYA-GCBUQUB-GOR5IN3-VYOPHCJ-MOJK7AZ";
          name = "Raspberry Pi";
        };
      };
      settings.folders = builtins.mapAttrs (
        _: folder:
        folder
        // {
          devices =
            if folder.id == "activitywatch" then
              [ "laptop" ]
            else
              [
                "laptop"
                "raspberrypi"
              ];
        }
      ) folders;
    }
  else
    {
      settings.devices = {
        desktop = {
          id = "YCGC2F3-DH2TRG5-BQYZRXO-2KR5YIN-YY7U3XY-SBNB225-EOOIWEE-XBKWRQT";
          name = "Desktop";
        };
        raspberrypi = {
          id = "VS3PDKE-TBTBRWJ-L2OTOUD-Z36HTYA-GCBUQUB-GOR5IN3-VYOPHCJ-MOJK7AZ";
          name = "Raspberry Pi";
        };
      };
      settings.folders = builtins.mapAttrs (
        _: folder:
        folder
        // {
          devices =
            if folder.id == "activitywatch" then
              [ "desktop" ]
            else
              [
                "desktop"
                "raspberrypi"
              ];
        }
      ) folders;
    }
)
