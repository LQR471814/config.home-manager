{ HOME, pkgs, ... }:
{
  home = {
    # basic configuration
    username = "lqr471814";
    homeDirectory = HOME;
    stateVersion = "26.05";

    # env vars
    sessionVariables = {
      CC = "${pkgs.clang}/bin/clang";
      GTK_IM_MODULE = "fcitx";
      QT_IM_MODULE = "fcitx";
      XMODIFIERS = "@im=fcitx";
      SDL_IM_MODULE = "fcitx";
      GOBIN = "${HOME}/go/bin";
      CGO_ENABLED = "0";
    };

    sessionPath = [
      "${HOME}/bin"
      "${HOME}/go/bin"
      "${HOME}/.local/bin"
      "${HOME}/.cargo/bin"
    ];
    shell.enableNushellIntegration = true;
  };
}
