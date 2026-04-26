cd /etc/nixos && \
sudo nix flake update nixos-config && \
sudo nixos-rebuild switch --flake "/etc/nixos#$1" \
