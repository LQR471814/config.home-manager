{ pkgs }:
final: prev: {
  inherit (pkgs)
    nushell
    nushellPlugins
    codex
    carapace
    carapace-bridge
    # to obtain v2.1.3
    syncthing
    ;
}
