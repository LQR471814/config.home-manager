{ pkgs, ... }:
{
  enable = true;
  iconTheme = {
    name = "Papirus-Light";
    package = pkgs.papirus-icon-theme;
  };
  gtk3.bookmarks = [
    "file:///home/lqr471814/Downloads"
    "file:///home/lqr471814/files/Documents"
    "file:///home/lqr471814/files/Documents/School"
    "file:///home/lqr471814/files/Documents/Knowledge%20Base"
    "file:///home/lqr471814/files/Documents/Recruiting"
    "file:///home/lqr471814/files/Books"
    "file:///home/lqr471814/files/Music"
    "file:///home/lqr471814/files"
  ];
}
