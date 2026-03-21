{ ... }:
{
  settings = {
    "org/gnome/rhythmbox/rhythmdb" = {
      locations = [ "file:///home/lqr471814/Music" ];
      monitor-library = true;
    };
    "org/gnome/rhythmbox/sources" = {
      visible-columns = [
        "time"
        "quality"
        "track-number"
        "album"
        "genre"
        "artist"
        "bitrate"
        "duration"
        "last-played"
      ];
    };
  };
}
