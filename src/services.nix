_: {
  imports = [
    ./cfg-system/systemd.nix
    ./cfg-system/swayidle.nix
    ./cfg-system/mako.nix
    ./cfg-system/kanshi.nix
    ./cfg-system/cliphist.nix
    ./cfg-system/wl-clip-persist.nix
    ./cfg-system/wayland-pipewire-idle-inhibit.nix
    ./cfg-programs/ollama.nix
    ./cfg-programs/syncthing.nix
  ];
}
