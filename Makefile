.PHONY: update
update:
	home-manager switch --impure --flake .#lqr471814
	rm -rf ~/.cache/tofi-compgen
