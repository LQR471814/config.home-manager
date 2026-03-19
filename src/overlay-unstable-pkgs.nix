{ unstable, system }:
super: self:
(with unstable.legacyPackages.${system}; {
  inherit
    firefox
    thunderbird
    kitty
    zathura
    vlc
    rhythmbox
    pwvucontrol
    gnome-clocks
    localsend
    musescore
    ardour
    easyeffects
    blender
    anki
    qpwgraph
    foliate
    legcord
    dbeaver-bin
    keepassxc
    tor-browser
    libreoffice
    gimp3
    inkscape
    scribus
    filezilla
    qbittorrent-enhanced
    usbimager
    zotero
    ungoogled-chromium
    obs-studio
    julia-bin
    freecad
    ;
})
