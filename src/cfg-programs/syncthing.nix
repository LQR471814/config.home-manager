{ HOME, ... }:
let
  folder = id: name: {
    id = id;
    label = name;
    path = "${HOME}/${name}";
    devices = [ "homeserver" ];
  };
in
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
      applications = folder "applications" "Applications";
      books = folder "books" "Books";
      documents = folder "documents" "Documents";
      music = folder "music" "Music";
    };
  };
}
