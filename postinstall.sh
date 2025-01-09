# things to run after running `home-manager switch` for the first time

# register dwm as a window manager
echo "[Desktop Entry]
Name=dwm
Comment=Dynamic Window Manager
Exec=dwm
Type=Application" | sudo tee /usr/share/xsessions/dwm.desktop

# clone neovim config
git clone https://github.com/LQR471814/config.nvim ~/.config/nvim

# use zsh as the login shell
chsh -s $(which zsh)
sudo chsh -s $(which zsh)

# see https://bbs.archlinux.org/viewtopic.php?pid=2100854#p2100854
sudo apt remove xdg-desktop-portal-gnome -y

