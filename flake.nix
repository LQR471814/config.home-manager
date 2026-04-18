{
  description = "Home manager configuration";

  inputs = {
    nixpkgs.url = "github:flox/nixpkgs/unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    xs.url = "github:cablehead/xs";
    wayland-pipewire-idle-inhibit.url = "github:rafaelrc7/wayland-pipewire-idle-inhibit";
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      xs,
      wayland-pipewire-idle-inhibit,
      ...
    }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        overlays = [
          (final: prev: {
            cross-stream = xs.packages.${system}.default;
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
