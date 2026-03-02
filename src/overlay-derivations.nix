final: prev:
let
  paths = prev.lib.filesystem.listFilesRecursive ./derivations;
  nix-paths = builtins.filter (path: prev.lib.hasSuffix ".nix" (builtins.toString path)) paths;
in

builtins.listToAttrs (
  builtins.map (
    path:
    let
      # we use callPackage because passing "pkgs" (whether final or prev)
      # implicitly creates a dependency on this overlay itself
      pkg = final.callPackage path { inherit final prev; };
    in
    {
      # we use the filename as the name because depending on the package name
      # creates a cycle (the package name is defined to be "the package name")
      name = prev.lib.removeSuffix ".nix" (builtins.baseNameOf path);
      value = pkg;
    }
  ) nix-paths
)
