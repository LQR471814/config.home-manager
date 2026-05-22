{
  final,
  prev,

  tmux,

  fetchFromGitHub,
  haskellPackages,
}:

let
  pkg = haskellPackages.callCabal2nix "datepicker" (fetchFromGitHub {
    owner = "nmeum";
    repo = "datepicker";
    rev = "master";
    hash = "sha256-PTkk52YeIl3NoJkRZEwbE4oLPmGcsbNjr/IdHhH45c0=";
  }) { };
in
pkg.overrideAttrs (old: {
  doCheck = false;
})
