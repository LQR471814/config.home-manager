mkdir -p ~/svr-home
sshfs "lqr471814@192.168.1.10:/home/lqr471814" ~/svr-home/

rm -rf ~/.local/state/syncthing
mkdir -p ~/.local/state/syncthing
cp -r ~/svr-home/config.syncthing/$(hostname) ~/.local/state/syncthing

fusermount -u ~/svr-home/

