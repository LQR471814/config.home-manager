{
  pkgs ? import <nixpkgs> { },
  ...
}:
with pkgs;
[
  android-studio
  frida-tools
  httptoolkit
  httptoolkit-server
]
