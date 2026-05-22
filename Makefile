.PHONY: switch
switch:
	home-manager switch --impure --flake .#lqr471814 || (which notify-send && notify-send "Nix: home-manager switch failed." -t 3000)
	rm -rf ~/.cache/tofi-compgen
	which notify-send && notify-send "Nix: home-manager switch complete." -t 3000

news:
	home-manager news --impure --flake .#lqr471814
