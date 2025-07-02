{ HOME, ... }:
{
  enable = true;
  userName = "LQR471814";
  userEmail = "42160088+LQR471814@users.noreply.github.com";
  extraConfig = {
    credential = {
      helper = "${HOME}/.nix-profile/bin/git-credential-manager";
      credentialStore = "gpg";
    };
  };
}
