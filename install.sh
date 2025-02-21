# install packages that must be available under sudo
sudo apt install curl build-essential wireguard-tools -y

# install nix & restart shell
sh <(curl -L https://nixos.org/nix/install) --daemon

# allow unfree packages
mkdir -p ~/.config/nixpkgs && echo "{ allowUnfree = true; }" > ~/.config/nixpkgs/config.nix 

# enable experimental features
mkdir -p ~/.config/nix
echo 'experimental-features = nix-command flakes' >> ~/.config/nix/nix.conf

# fix GL/vulkan problems
nix-channel --add https://github.com/nix-community/nixGL/archive/main.tar.gz nixgl && nix-channel --update
nix-env -iA nixgl.auto.nixGLDefault

# install home manager & apply configuration
nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
nix-channel --update
nix-shell '<home-manager>' -A install


# ----- things to run after setting up home-manager for the first time


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

# install python packages (cause python on nix is a mess)
rye

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
}

profile bwrap /**/bwrap flags=(unconfined) {
  userns,
  include if exists <local/bwrap>
}
" | sudo tee /etc/apparmor.d/nix.bins

sudo systemctl restart apparmor

# start warp-svc on startup

echo "[Unit]
Description=cloudflare warp-svc
After=network.target

[Service]
ExecStart=/home/lqr471814/.nix-profile/bin/warp-svc
Restart=always
User=root

[Install]
WantedBy=multi-user.target" | sudo tee /etc/systemd/system/warp-svc.service

sudo systemctl enable warp-svc.service
sudo systemctl start warp-svc.service

warp-cli registration new

