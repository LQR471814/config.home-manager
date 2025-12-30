{
  description = "Home manager configuration";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-25.11";
    unstable.url = "github:flox/nixpkgs/unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # metasearch2 = {
    #   url = "github:mat-1/metasearch2";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
  };

  outputs =
    {
      nixpkgs,
      unstable,
      home-manager,
      # metasearch2,
      ...
    }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config = {
          cudaSupport = builtins.pathExists /etc/nixos/DESKTOP;
          allowUnfree = true;
        };
      };
    in
    {
      homeConfigurations.lqr471814 = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          (import ./home.nix {
            metasearch2 = null;
            # metasearch2 = metasearch2.packages.${system}.default;
          })
          {
            nixpkgs.overlays = [
              (
                super: self: with unstable.legacyPackages.${system}; {
                  inherit firefox;
                  inherit thunderbird;
                  inherit kitty;
                  inherit zathura;
                  inherit vlc;
                  inherit rhythmbox;
                  inherit pwvucontrol;
                  inherit gnome-clocks;
                  inherit localsend;
                  inherit musescore;
                  inherit ardour;
                  inherit easyeffects;
                  inherit blender;
                  inherit anki;
                  inherit qpwgraph;
                  inherit foliate;
                  inherit legcord;
                  inherit dbeaver-bin;
                  inherit keepassxc;
                  inherit tor-browser;
                  inherit libreoffice;
                  inherit gimp3;
                  inherit inkscape;
                  inherit scribus;
                  inherit filezilla;
                  inherit qbittorrent-enhanced;
                  inherit usbimager;
                  inherit zotero;
                  inherit ungoogled-chromium;
                  inherit obs-studio;
                  inherit julia-bin;
                  inherit freecad;
                }
              )
            ];
          }
        ];
        extraSpecialArgs = {
          inherit system;
        };
      };
    };
}
