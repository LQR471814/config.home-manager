{
  description = "Home manager configuration";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-25.11";
    unstable.url = "github:flox/nixpkgs/unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    xs.url = "github:cablehead/xs";
  };

  outputs =
    {
      nixpkgs,
      unstable,
      home-manager,
      xs,
      ...
    }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        overlays = [
          (import ./src/overlay-unstable-pkgs.nix {
            inherit unstable system;
          })
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
          (import ./home.nix)
        ];
        extraSpecialArgs = {
          inherit system;
        };
      };
    };
}
