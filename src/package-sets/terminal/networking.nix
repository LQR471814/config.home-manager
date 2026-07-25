{
  pkgs ? import <nixpkgs> { },
  ...
}:
let
  inherit (pkgs)
    cloudflare-warp
    xray
    tun2socks
    socat
    netcat-openbsd
    ;
in
[
  cloudflare-warp
  xray
  tun2socks
  socat
  netcat-openbsd
]
