ctx: {
  # systemd
  systemd.user = import ./cfg-system/systemd.nix ctx;

  services = {
    swayidle = import ./cfg-system/swayidle.nix ctx;
    mako = import ./cfg-system/mako.nix ctx;
    kanshi = import ./cfg-system/kanshi.nix ctx;
    ollama = import ./cfg-programs/ollama.nix ctx;
    syncthing = import ./cfg-programs/syncthing.nix ctx;
    cliphist = import ./cfg-system/cliphist.nix ctx;
    wl-clip-persist = import ./cfg-system/wl-clip-persist.nix ctx;
    wayland-pipewire-idle-inhibit = import ./cfg-system/wayland-pipewire-idle-inhibit.nix ctx;
  };
}
