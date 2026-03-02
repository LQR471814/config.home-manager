{
  pkgs ? import <nixpkgs> { },
  ...
}:
with pkgs;
[
  cloudflare-warp
  xray
  tun2socks
  socat
  netcat-openbsd
]
