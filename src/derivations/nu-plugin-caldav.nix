{
  pkgs ? import <nixpkgs> { },
  ...
}:

pkgs.buildGoModule {
  name = "nu_plugin_caldav";
  system = builtins.currentSystem;

  src = pkgs.fetchFromGitHub {
    owner = "lqr471814";
    repo = "nu_plugin_caldav";
    rev = "c78c9e4c1a19cfdf7ce0652025ddb21c2c8badd4";
    hash = "sha256-nmcwNnETBjWt4WMJcvK1y3CGvbgkRP/dfbwcdrodMnM=";
  };

  vendorHash = "sha256-bivznLooydYLDcmrJsBNRAB20GNn8cKJS0Y16pbn9rM=";
  subPackages = [ "." ];
}
