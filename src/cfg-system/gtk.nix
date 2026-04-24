{ pkgs, ... }:
{
  enable = true;
  iconTheme = {
    name = "Papirus-Light";
    package = pkgs.papirus-icon-theme;
  };
  gtk3.bookmarks = [
    "file:///home/lqr471814/Downloads"
    "file:///home/lqr471814/Documents"
    "file:///home/lqr471814/Documents/School"
    "file:///home/lqr471814/Documents/Knowledge%20Base"
    "file:///home/lqr471814/Documents/Recruiting"
    "file:///home/lqr471814/Books"
    "file:///home/lqr471814/Music"
    "file:///home/lqr471814/files"
  ];
}
