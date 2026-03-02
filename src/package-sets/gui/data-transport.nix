{
  pkgs ? import <nixpkgs> { },
  ...
}:
with pkgs;
[
  firefox
  tor-browser
  ungoogled-chromium
  qbittorrent-enhanced
  thunderbird
  localsend
  legcord
  filezilla
]
