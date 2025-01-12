# things to run after running `home-manager switch` for the first time

# register dwm as a window manager
echo "[Desktop Entry]
Name=dwm
Comment=Dynamic Window Manager
Exec=dwm
Type=Application" | sudo tee /usr/share/xsessions/dwm.desktop

# fix dwm gnome issues - see https://bbs.archlinux.org/viewtopic.php?pid=2100854#p2100854
sudo apt remove xdg-desktop-portal-gnome -y

# clone neovim config
rm -rf ~/.config/nvim && git clone https://github.com/LQR471814/config.nvim ~/.config/nvim

# use zsh as the login shell
echo $(which zsh) | sudo tee -a /etc/shells
chsh -s $(which zsh)
sudo chsh -s $(which zsh)

# register default apps
sudo ln -f -s /home/lqr471814/.nix-profile/bin/alacritty /etc/alternatives/x-terminal-emulator
sudo ln -f -s /home/lqr471814/.nix-profile/bin/thorium-browser /etc/alternatives/gnome-www-browser
sudo ln -f -s /home/lqr471814/.nix-profile/bin/thorium-browser /etc/alternatives/www-browser
sudo ln -f -s /home/lqr471814/.nix-profile/bin/thorium-browser /etc/alternatives/x-www-browser

# fix apparmor issues
echo "abi <abi/4.0>,
include <tunables/global>

profile electron /nix/store/**/electron flags=(unconfined) {
userns,
include if exists <local/electron>
}

profile thorium /nix/store/**/thorium-* flags=(unconfined) {
userns,
include if exists <local/thorium>
}" | sudo tee /etc/apparmor.d/nix.bins

sudo systemctl restart apparmor

