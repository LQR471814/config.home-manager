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

# fix GL/vulkan problems
nix-channel --add https://github.com/nix-community/nixGL/archive/main.tar.gz nixgl && nix-channel --update
nix-env -iA nixgl.auto.nixGLDefault

# allow unfree packages
mkdir -p ~/.config/nixpkgs && echo "{ allowUnfree = true; }" > ~/.config/nixpkgs/config.nix 

# apply configuration
home-manager switch

# after applying config for the first time
./postinstall.sh

# clear dmenu cache (may need to run after home-manager switch)
rm -rf ~/.cache/dmenu_run

# remove unnecessary files from nix cache (may want to run this occasionally)
nix-collect-garbage
```

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

