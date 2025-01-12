mkdir -p ~/svr-home
sshfs "lqr471814@192.168.1.10:/home/lqr471814" ~/svr-home/
mkdir -p ~/svr-home/syncthing/$(hostname)

cp ~/.local/state/syncthing/config.xml     ~/svr-home/syncthing/$(hostname)/
cp ~/.local/state/syncthing/https-key.pem  ~/svr-home/syncthing/$(hostname)/
cp ~/.local/state/syncthing/https-cert.pem ~/svr-home/syncthing/$(hostname)/
cp ~/.local/state/syncthing/key.pem        ~/svr-home/syncthing/$(hostname)/
cp ~/.local/state/syncthing/cert.pem       ~/svr-home/syncthing/$(hostname)/

fusermount -u ~/svr-home/

