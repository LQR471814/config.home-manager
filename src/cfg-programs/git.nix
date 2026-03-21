{ HOME, ... }:
{
  enable = true;
  signing.key = "LQR471814";
  settings = {
    user = {
      name = "LQR471814";
      email = "42160088+LQR471814@users.noreply.github.com";
    };
    credential = {
      helper = "${HOME}/.nix-profile/bin/git-credential-manager";
      credentialStore = "plaintext";
    };
  };
}
