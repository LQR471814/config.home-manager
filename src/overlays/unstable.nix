{ pkgs }:
final: prev: {
  inherit (pkgs)
    nushell
    nushellPlugins
    codex
    ;
}
