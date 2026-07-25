{ pkgs, ... }:
{
  enable = true;
  plugins =
    let
      inherit (pkgs.obs-studio-plugins)
        wlrobs
        obs-pipewire-audio-capture
        ;
    in
    [
      wlrobs
      obs-pipewire-audio-capture
    ];
}
