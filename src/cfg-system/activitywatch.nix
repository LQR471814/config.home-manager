{ pkgs, ... }: {
  services.activitywatch = {
    enable = true;
    settings.port = 5600;
    watchers = {
      aw-watcher-afk = {
        package = pkgs.activitywatch;
      };
      aw-watcher-window = {
        package = pkgs.activitywatch;
      };
    };
  };
}
