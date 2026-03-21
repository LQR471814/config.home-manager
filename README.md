## Personal nix home-manager config

> My personal nix home-manager configuration.

### Usage

```sh
# install nix
sh <(curl -L https://nixos.org/nix/install) --daemon

# symlinks
ln -s ~/files/Plugins/lv2 ~/.lv2
ln -s ~/files/Plugins/vst ~/.lxvst
ln -s ~/files/Plugins/vst3 ~/.vst3

# other installation
julia --project=~/.julia/environments/nvim-lspconfig install_lsp.jl
julia install.jl
```

- `rm -rf ~/.cache/dmenu_run` - clears the dmenu cache (you may need to run
  this after home-manager switch if programs aren't showing up in `super+p`)
- `nix-collect-garbage` - frees up space occupied by unnecessary nix packages.
- `fcitx5-configtool` - configure enabled input methods, you will need to
  configure this manually after install.

### Note on flake behavior

Since this is a flake, it only sees the files that have been committed or
staged to the git repo in this repository, if you are getting strange issues
where your changes aren't being applied or your `flake.nix` is not being found,
try staging/commit all your files.

### Note on environment vars

Environment variables defined in `sessionVariables` will only be
updated after a reboot in `tmux` sessions as the `tmux` daemon
will not be restarted after logging-in and logging-out?

### Note on LaTeX version issues

Sometimes updating LaTeX environments will cause version conflicts
due to PATH and various other environment variable issues.

To fix this, simply run `nix-garbage-collect -d`, then restart the
computer.

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
- [nice intro to flakes](https://serokell.io/blog/practical-nix-flakes)
- chatgpt & google

