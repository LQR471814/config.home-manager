{
  pkgs ? import <nixpkgs> { },
  ...
}:
with pkgs;
[
  firefox
  # tor-browser
  # qbittorrent-enhanced
  ungoogled-chromium
  thunderbird
  localsend
  legcord
  filezilla
]
