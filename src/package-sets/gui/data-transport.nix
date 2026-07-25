{
  pkgs ? import <nixpkgs> { },
  ...
}:
let
  inherit (pkgs)
    firefox
    ungoogled-chromium
    thunderbird
    localsend
    legcord
    filezilla
    ;
in
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
