{ config, ... }: {
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    settings = {
      "*" = {
        ForwardAgent = false;
        AddKeysToAgent = "no";
        Compression = false;
        ServerAliveInterval = 0;
        ServerAliveCountMax = 3;
        HashKnownHosts = false;
        UserKnownHostsFile = "~/.ssh/known_hosts";
        ControlMaster = "no";
        ControlPath = "~/.ssh/master-%r@%n:%p";
        ControlPersist = "no";
      };
      homesrv = {
        HostName = "192.168.1.10";
        User = "nixos";
        IdentityFile = config.sops.secrets.ssh_homesrv_lqr471814.path;
        AddKeysToAgent = "yes";
      };
      homesrv_git = {
        HostName = "192.168.1.10";
        User = "git";
        IdentityFile = config.sops.secrets.ssh_homesrv_git.path;
        AddKeysToAgent = "yes";
      };
    };
  };
}
