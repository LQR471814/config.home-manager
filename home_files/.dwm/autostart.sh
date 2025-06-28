systemctl --user start dwmblocks
systemctl --user start bar-network-watcher
systemctl --user start bar-battery-watcher
systemctl --user start picom
systemctl --user start fcitx5
systemctl --user start aw-qt
systemctl --user start slock

xinput set-prop 10 "libinput Natural Scrolling Enabled" 0
