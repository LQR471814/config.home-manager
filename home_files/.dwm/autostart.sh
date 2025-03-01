$HOME/.config/dwm-bar/dwm_bar.sh &
picom --config $HOME/.config/picom/picom.conf &
aw-qt --no-gui &
syncthing serve --no-browser --logfile=default &
xinput set-prop 10 "libinput Natural Scrolling Enabled" 1

# enable lock screen
xss-lock -- slock &
