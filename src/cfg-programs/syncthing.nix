{ HOME, ... }:
{
  enable = true;
  settings = {
    devices = {
      homeserver = {
        addresses = [
          "tcp://192.168.1.10:22000"
          "quic://192.168.1.10:22000"
        ];
        id = "VS3PDKE-TBTBRWJ-L2OTOUD-Z36HTYA-GCBUQUB-GOR5IN3-VYOPHCJ-MOJK7AZ";
      };
    };
    folders = {
      files = {
        id = "files";
        label = "Files";
        path = "${HOME}/files";
        devices = [ "homeserver" ];
        versioning = {
          type = "trashcan";
          params.cleanoutDays = "30";
        };
      };
    };
  };
}
