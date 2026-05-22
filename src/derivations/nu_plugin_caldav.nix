{
  final,
  prev,

  buildGoModule,
  fetchFromGitHub,
}:

buildGoModule {
  name = "nu_plugin_caldav";
  system = builtins.currentSystem;
  meta.mainProgram = "nu_plugin_caldav";

  src = fetchFromGitHub {
    owner = "lqr471814";
    repo = "nu_plugin_caldav";
    rev = "b3339613ce1add671afb6af5a3aade6222d26604";
    hash = "sha256-zRDh2INbPp4pX2Ma/Vi/nNvNSI2L3k+os0o4TwQ7JdU=";
  };

  vendorHash = "sha256-kdrYg1oMWu6/nJEoEIrP7jhbSBxSoiMDeNEtjvqb0TE=";
  subPackages = [ "." ];
}
