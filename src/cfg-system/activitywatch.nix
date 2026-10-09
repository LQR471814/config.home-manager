{ pkgs, ... }: {
  services.activitywatch = {
    enable = true;
    settings.port = 5600;
    watchers = {
      awatcher = {
        package = pkgs.awatcher;
        extraOptions = [
          "--idle-timeout"
          "180"
        ];
      };
    };
  };
}
