## Personal nix home-manager config

> My personal nix home-manager configuration.

### Usage

```sh
# install nix
sh <(curl -L https://nixos.org/nix/install) --daemon
# install home manager
nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
nix-channel --update
nix-shell '<home-manager>' -A install
# apply configuration
home-manager switch
```

### References

- [home-manager docs](https://nix-community.github.io/home-manager/options.xhtml)
- [nix manual - builtins docs](https://nix.dev/manual/nix/2.24/language/builtins.html?highlight=nixpkgs#source-types)
- [unofficial docs on trivial builders?](https://ryantm.github.io/nixpkgs/builders/trivial-builders/)
- [docs on `programs.<some_program>` config](https://github.com/NixOS/nixpkgs/tree/master/nixos/modules/programs)
- [nixos package search](https://search.nixos.org/)
- [nixos wiki](https://nixos.wiki/wiki/Main_Page)
- [reading nixpkgs source code](https://github.com/NixOS/nixpkgs/tree/master/pkgs)
- chatgpt & google

