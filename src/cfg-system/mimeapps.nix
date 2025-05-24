{ ... }:
{
  enable = true;
  defaultApplications = {
    "application/pdf" = [ "org.pwmt.zathura.desktop" ];

    "x-scheme-handler/mailto" = [ "userapp-Thunderbird-IFAK72.desktop" ];
    "message/rfc822" = [ "userapp-Thunderbird-IFAK72.desktop" ];
    "x-scheme-handler/mid" = [ "userapp-Thunderbird-IFAK72.desktop" ];
    "x-scheme-handler/news" = [ "userapp-Thunderbird-89NL72.desktop" ];
    "x-scheme-handler/snews" = [ "userapp-Thunderbird-89NL72.desktop" ];
    "x-scheme-handler/nntp" = [ "userapp-Thunderbird-89NL72.desktop" ];
    "x-scheme-handler/feed" = [ "userapp-Thunderbird-0R1G72.desktop" ];
    "application/rss+xml" = [ "userapp-Thunderbird-0R1G72.desktop" ];
    "application/x-extension-rss" = [ "userapp-Thunderbird-0R1G72.desktop" ];
    "x-scheme-handler/webcal" = [ "userapp-Thunderbird-GGQ262.desktop" ];
    "text/calendar" = [ "userapp-Thunderbird-GGQ262.desktop" ];
    "application/x-extension-ics" = [ "userapp-Thunderbird-GGQ262.desktop" ];
    "x-scheme-handler/webcals" = [ "userapp-Thunderbird-GGQ262.desktop" ];
  };
}
