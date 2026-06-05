{
  description = "Home manager configuration";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    wayland-pipewire-idle-inhibit.url = "github:rafaelrc7/wayland-pipewire-idle-inhibit";
    libtexprintf.url = "github:xbwwj/libtexprintf-nix";

    xs.url = "github:cablehead/xs";
    nu-lint.url = "git+https://codeberg.org/wvhulle/nu-lint.git";

    nu-type-alias.url = "git+https://github.com/LQR471814/nu-type-alias.git";
    nu_plugin_caldav.url = "git+https://github.com/LQR471814/nu_plugin_caldav.git";
  };

  outputs =
    {
      nixpkgs,
      home-manager,

      wayland-pipewire-idle-inhibit,
      libtexprintf,

      xs,
      nu-lint,
      nu_plugin_caldav,
      nu-type-alias,

      ...
    }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        overlays = [
          (final: prev: {
            cross-stream = xs.packages.${system}.default;
            libtexprintf = libtexprintf.packages.${system}.default;
            nu-lint = nu-lint.packages.${system}.default;
            nu-type-alias = nu-type-alias.packages.${system}.default;
            nu_plugin_caldav = nu_plugin_caldav.packages.${system}.default;
          })
          (import ./src/overlay-derivations.nix)
        ];
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
          wayland-pipewire-idle-inhibit.homeModules.default
          (import ./home.nix)
        ];
        extraSpecialArgs = {
          inherit system;
        };
      };
    };
}
