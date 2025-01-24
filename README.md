## Personal nix home-manager config

> My personal nix home-manager configuration.

### Usage

- `./install.sh` - sets up everything.
- `rm -rf ~/.cache/dmenu_run` - clears the dmenu cache (you may need to run this after home-manager switch if programs aren't showing up in `super+p`)
- `nix-collect-garbage` - frees up space occupied by unnecessary nix packages.

### References

- [nixpkgs api docs](https://nixos.org/manual/nixpkgs/stable/)
- [home-manager api docs](https://nix-community.github.io/home-manager/options.xhtml)
- [builtins api docs](https://nix.dev/manual/nix/2.24/language/builtins.html?highlight=nixpkgs#source-types)
- [docs on `programs.<some_program>` config (home manager)](https://github.com/nix-community/home-manager/tree/master/modules/programs)
- [docs on `programs.<some_program>` config](https://github.com/NixOS/nixpkgs/tree/master/nixos/modules/programs)
- [nixos package search](https://search.nixos.org/)
- [unofficial docs on trivial builders?](https://ryantm.github.io/nixpkgs/builders/trivial-builders/)
- [nixos wiki](https://nixos.wiki/wiki/Main_Page)
- [browse source code for a given nix pkg](https://github.com/NixOS/nixpkgs/tree/master/pkgs)
- chatgpt & google

