_: {
  sops = {
    gnupg = {
      home = "/home/lqr471814/.gnupg";
      sshKeyPaths = [ ];
    };

    secrets = {
      ssh_homesrv_lqr471814 = {
        mode = "0400";
        sopsFile = ../secrets/id_homesrv_lqr471814;
        format = "binary";
      };
      ssh_homesrv_git = {
        mode = "0400";
        sopsFile = ../secrets/id_homesrv_git;
        format = "binary";
      };
    };
  };
}
