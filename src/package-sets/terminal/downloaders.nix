{
  pkgs ? import <nixpkgs> { },
  ...
}:
with pkgs;
[
  aria2
  yt-dlp
]
