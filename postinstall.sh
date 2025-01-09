# things to run after running `home-manager switch` for the first time

sudo echo "[Desktop Entry]
Name=dwm
Comment=Dynamic Window Manager
Exec=dwm
Type=Application" > /usr/share/xsessions/dwm.desktop

# see https://bbs.archlinux.org/viewtopic.php?pid=2100854#p2100854
sudo apt remove xdg-desktop-portal-gnome -y

