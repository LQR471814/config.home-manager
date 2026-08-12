{
  description = "Home manager configuration";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-26.05";
    unstable.url = "nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    wayland-pipewire-idle-inhibit = {
      url = "github:rafaelrc7/wayland-pipewire-idle-inhibit";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    libtexprintf = {
      url = "github:xbwwj/libtexprintf-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    xs = {
      url = "github:cablehead/xs";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nu-lint = {
      url = "github:wvhulle/nu-lint";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    topiary-nushell = {
      url = "github:blindFS/topiary-nushell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nu-type-alias = {
      url = "git+https://github.com/LQR471814/nu-type-alias.git";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nu_plugin_caldav = {
      url = "github:LQR471814/nu_plugin_caldav";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixpkgs,
      unstable,
      home-manager,

      wayland-pipewire-idle-inhibit,
      libtexprintf,

      xs,
      nu-lint,
      nu_plugin_caldav,
      nu-type-alias,
      topiary-nushell,

      ...
    }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit
          system
          ;
        overlays = [
          (final: prev: {
            cross-stream = xs.packages.${system}.default;
            libtexprintf = libtexprintf.packages.${system}.default;
            nu-lint = nu-lint.packages.${system}.default;
            nu-type-alias = nu-type-alias.packages.${system}.default;
            nu-type-fmt = nu-type-alias.packages.${system}.nu-type-fmt;
            nu_plugin_caldav = nu_plugin_caldav.packages.${system}.default;
            topiary-nushell = topiary-nushell.packages.${system}.default;
          })
          (import ./src/overlays/derivations.nix)
          (import ./src/overlays/kitten-themes.nix)
          (import ./src/overlays/unstable.nix {
            pkgs = import unstable {
              inherit system;
              config = {
                cudaSupport = builtins.pathExists /etc/nixos/DESKTOP;
                allowUnfree = true;
              };
            };
          })
        ];
        config = {
          cudaSupport = builtins.pathExists /etc/nixos/DESKTOP;
          allowUnfree = true;
        };
      };
    in
    {
      homeConfigurations.lqr471814 =
        let
          HOSTNAME = builtins.readFile /etc/hostname;
          HOME = builtins.getEnv "HOME";
          IS_DESKTOP = builtins.match ".*desktop.*" HOSTNAME != null;
          IS_LAPTOP = builtins.match ".*laptop.*" HOSTNAME != null;
          SYSTEM_BIN = "/run/current-system/sw/bin";
          fix-pw = pkgs.callPackage ./src/lib/fix-pipewire.nix { };
        in
        home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [
            wayland-pipewire-idle-inhibit.homeModules.default
            ./src/nix.nix
            ./src/user.nix
            ./src/programs.nix
            ./src/services.nix
            ./src/desktop.nix
            ./src/home-files.nix
            ./src/darkmode.nix
          ];
          extraSpecialArgs = {
            inherit
              system
              pkgs
              HOSTNAME
              HOME
              IS_DESKTOP
              IS_LAPTOP
              SYSTEM_BIN
              fix-pw
              ;
          };
        };
    };
}
