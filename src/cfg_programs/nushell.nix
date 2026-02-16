ctx@{ pkgs, ... }:
let
  nu-ai = import ../derivations/nu-ai.nix ctx;
  nu-xs = import ../derivations/nu-xs.nix ctx;
  nu-plugin-caldav = import ../derivations/nu-plugin-caldav.nix ctx;
in
{
  enable = true;
  settings = {
    show_banner = false;
  };
  extraConfig = ''
    const NU_LIB_DIRS = $NU_LIB_DIRS ++ [
      "${nu-ai}"
      "${nu-xs}"
    ]
    const NU_PLUGIN_DIRS = $NU_PLUGIN_DIRS ++ [
      "${pkgs.nushellPlugins.query}/bin"
      "${pkgs.nushellPlugins.polars}/bin"
      "${nu-plugin-caldav}/bin"
    ]
    plugin add nu_plugin_query
    plugin add nu_plugin_polars
    plugin add nu_plugin_caldav
    plugin use query
    plugin use polars
    plugin use caldav
  '';
}
