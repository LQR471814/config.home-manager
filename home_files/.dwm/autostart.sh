$HOME/.config/dwm-bar/dwm_bar.sh &
picom --config $HOME/.config/picom/picom.conf &
$HOME/bin/activitywatch/aw-qt --no-gui 2> ~/activitywatch.log &
/usr/bin/syncthing serve --no-browser --logfile=default &
