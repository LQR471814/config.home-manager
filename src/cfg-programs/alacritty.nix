{ IS_DESKTOP, pkgs, fixGL, ... }:
{
  enable = true;
  package = fixGL pkgs.alacritty;
  settings = {
    font = {
      size = if IS_DESKTOP then 10 else 6;
      normal = {
        family = "JetBrainsMono NF";
        style = "Mono";
      };
      bold = {
        family = "JetBrainsMono NF";
        style = "Bold";
      };
      italic = {
        family = "JetBrainsMono NF";
        style = "Italic";
      };
    };
    window = {
      dynamic_padding = true;
    };
    env = {
      TERM = "xterm-256color";
    };
    keyboard = {
      bindings = [
        { key = "Key0"; mods = "Control"; chars = "\\u001b[48;5u"; }
        { key = "Key1"; mods = "Control"; chars = "\\u001b[49;5u"; }
        { key = "Key2"; mods = "Control"; chars = "\\u001b[50;5u"; }
        { key = "Key3"; mods = "Control"; chars = "\\u001b[51;5u"; }
        { key = "Key4"; mods = "Control"; chars = "\\u001b[52;5u"; }
        { key = "Key5"; mods = "Control"; chars = "\\u001b[53;5u"; }
        { key = "Key6"; mods = "Control"; chars = "\\u001b[54;5u"; }
        { key = "Key7"; mods = "Control"; chars = "\\u001b[55;5u"; }
        { key = "Key8"; mods = "Control"; chars = "\\u001b[56;5u"; }
        { key = "Key9"; mods = "Control"; chars = "\\u001b[57;5u"; }
        { key = "F11"; action = "ToggleFullscreen"; }
      ];
    };
  };
}
