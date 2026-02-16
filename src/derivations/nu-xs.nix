{
  pkgs ? import <nixpkgs> { },
  ...
}:

derivation {
  name = "nu-xs";
  system = builtins.currentSystem;
  builder = "${pkgs.busybox}/bin/sh";
  args = [
    "-c"
    ''
      ${pkgs.busybox}/bin/mkdir -p $out
      ${pkgs.cross-stream}/bin/xs nu > $out/xs.nu 
    ''
  ];
}
