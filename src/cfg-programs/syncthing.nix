{ HOME, ... }:
let
  folder = id: name: {
    inherit id;
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
        id = "N7WGQDL-UBANXJC-ERJKEOL-4QSTGAE-FQ7F3QC-UENJJDO-SEG27XF-PKHBBA7";
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
