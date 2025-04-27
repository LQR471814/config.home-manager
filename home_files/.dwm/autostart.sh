systemctl --user start dwmblocks
systemctl --user start picom
systemctl --user start fcitx5
systemctl --user start aw-qt
systemctl --user start slock

xinput set-prop 10 "libinput Natural Scrolling Enabled" 1
