{ pkgs, ... }:
{
  inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5.addons = with pkgs; [
      fcitx5-gtk
      libsForQt5.fcitx5-qt
      kdePackages.fcitx5-chinese-addons
    ];
  };
}
