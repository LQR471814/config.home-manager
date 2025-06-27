# install packages that must be available under sudo
sudo apt install curl build-essential wireguard-tools libfuse-dev -y

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


# make slock
sudo apt install libx11-dev libxrandr-dev
mkdir -p ~/Code/config/slock
git clone https://github.com/LQR471814/slock.git ~/Code/config/slock
cd ~/Code/config/slock && sudo make clean install

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
sudo ln -f -s $HOME/.nix-profile/bin/alacritty /etc/alternatives/x-terminal-emulator
sudo ln -f -s $HOME/.nix-profile/bin/thorium-browser /etc/alternatives/gnome-www-browser
sudo ln -f -s $HOME/.nix-profile/bin/thorium-browser /etc/alternatives/www-browser
sudo ln -f -s $HOME/.nix-profile/bin/thorium-browser /etc/alternatives/x-www-browser

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
ExecStart=$HOME/.nix-profile/bin/warp-svc
Restart=always
User=root

[Install]
WantedBy=multi-user.target" | sudo tee /etc/systemd/system/warp-svc.service

# not using warp-svc for now
#
# sudo systemctl enable warp-svc.service
# sudo systemctl start warp-svc.service
#
# warp-cli registration new

# start dockerd on startup

echo "[Unit]
Description=docker daemon
After=default.target

[Service]
ExecStart=$HOME/.nix-profile/bin/dockerd
User=root

[Install]
WantedBy=multi-user.target" | sudo tee /etc/systemd/system/docker.service

sudo groupadd docker
sudo usermod -aG docker $USER
sudo chown root:docker /var/run/docker.sock

# don't enable docker for now
# sudo systemctl enable docker.service
# sudo systemctl start docker.service

# remove and disable snap
sudo snap remove firefox
sudo snap remove gtk-common-themes
sudo snap remove $(snap list | grep gnome | awk '{print $1}')
sudo snap remove snapd-desktop-integration
sudo snap remove snap-store
sudo snap remove desktop-security-center
sudo snap remove firmware-updater
sudo snap remove prompting-client
sudo snap remove $(snap list | grep core | awk '{print $1}')
sudo snap remove bare
sudo snap remove snapd
sudo systemctl stop snapd
sudo systemctl disable snapd
sudo systemctl mask snapd
sudo apt purge snapd -y
sudo apt-mark hold snapd
sudo rm -rf ~/snap /snap /var/snap /var/lib/snapd
echo "Package: snapd
Pin: release a=*
Pin-Priority: -10" | sudo tee /etc/apt/preferences.d/nosnap.pref

# disable wifi powersave
sudo sed -i 's/wifi.powersave = 3/wifi.powersave = 2/' /etc/NetworkManager/conf.d/default-wifi-powersave-on.conf && systemctl restart network-manager.service

# add TLP

if [[ $(hostname) == *laptop* ]]; then
  sudo add-apt-repository ppa:linrunner/tlp
  sudo apt update
  sudo apt install tlp tlp-rdw
fi

