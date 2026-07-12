{ pkgs }:
final: prev:
{
  nushell = pkgs.nushell;
  nushellPlugins = pkgs.nushellPlugins;
}
