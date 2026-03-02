{ pkgs, ... }:
pkgs.callPackage (pkgs.fetchFromGitHub {
  owner = "wvhulle";
  repo = "nu-lint";
  rev = "905635ab0cb980fd15d29949cb08337375db8032";
  sha256 = "sha256-FaL7iF9cMC6/VF5QbgfIQhUBs3TtsXcuoOyqrK1PwpI=";
}) { }
