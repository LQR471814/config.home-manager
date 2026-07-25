{
  pkgs ? import <nixpkgs> { },
  ...
}:
let
  inherit (pkgs)
    aria2
    yt-dlp
    ;
in
[
  aria2
  yt-dlp
]
