{ HOME, pkgs, ... }:
{
  CC = "${pkgs.clang}/bin/clang";
  GTK_IM_MODULE = "fcitx";
  QT_IM_MODULE = "fcitx";
  XMODIFIERS = "@im=fcitx";
  SDL_IM_MODULE = "fcitx";
  TEXINPUTS = "${HOME}/texmf//:${HOME}/.config/texmf//";
  GOBIN = "${HOME}/go/bin";
}
