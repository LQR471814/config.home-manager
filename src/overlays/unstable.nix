{ pkgs }:
final: prev: {
  inherit (pkgs)
    nushell
    nushellPlugins
    codex
    # to obtain v2.1.3
    syncthing
    ;
}
