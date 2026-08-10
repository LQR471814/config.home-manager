{ pkgs, ... }: {
  qt = {
    enable = true;
    platformTheme.name = "qtct";
  };

  services.darkman = {
    enable = true;
    settings.usegeoclue = true;

    scripts.theme = ''
       mode="$1"

       case "$mode" in
         dark)
           gtk_scheme="prefer-dark"
           qt5_scheme="${pkgs.libsForQt5.qt5ct}/share/qt5ct/colors/darker.conf"
           qt6_scheme="${pkgs.qt6Packages.qt6ct}/share/qt6ct/colors/darker.conf"
           ;;

         light)
           gtk_scheme="prefer-light"
           qt5_scheme="${pkgs.libsForQt5.qt5ct}/share/qt5ct/colors/airy.conf"
           qt6_scheme="${pkgs.qt6Packages.qt6ct}/share/qt6ct/colors/airy.conf"
           ;;

         *)
           echo "unknown mode: $mode" >&2
           exit 1
           ;;
       esac

       # GTK
       ${pkgs.dconf}/bin/dconf write \
         /org/gnome/desktop/interface/color-scheme \
         "'$gtk_scheme'"

       # Qt5 + Qt6
       for item in \
         "qt5ct:$qt5_scheme" \
         "qt6ct:$qt6_scheme"
       do
         toolkit="''${item%%:*}"
         scheme="''${item#*:}"

         config_home="''${XDG_CONFIG_HOME:-$HOME/.config}"
         config_file="$config_home/$toolkit/$toolkit.conf"

         mkdir -p "$(dirname "$config_file")"

         ${pkgs.python3}/bin/python3 - "$config_file" "$scheme" <<'PY'
      import configparser
      import os
      import pathlib
      import sys
      import tempfile

      path = pathlib.Path(sys.argv[1])
      scheme = sys.argv[2]

      config = configparser.RawConfigParser()
      config.optionxform = str

      if path.exists():
          config.read(path)

      if not config.has_section("Appearance"):
          config.add_section("Appearance")

      config.set("Appearance", "custom_palette", "true")
      config.set("Appearance", "color_scheme_path", scheme)

      fd, temporary = tempfile.mkstemp(
          prefix=path.name + ".",
          dir=path.parent,
      )

      try:
          with os.fdopen(fd, "w") as f:
              config.write(f)

          os.replace(temporary, path)
      finally:
          if os.path.exists(temporary):
              os.unlink(temporary)
      PY
        done
    '';
  };
}
