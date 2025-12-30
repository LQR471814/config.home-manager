{ pkgs, ... }:
{
  enable = true;
  plugins = with pkgs.obs-studio-plugins; [
    wlrobs
    obs-pipewire-audio-capture
  ];
}
