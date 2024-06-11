
# init script, will probably become more elaborate
echo "Toastielad dotfile copy and initialization!"
echo "Requires GNU Stow"
echo "Starting..."
echo "stow bash"
stow bash
echo "sudo rm -f /etc/nixos/configuration.nix"
sudo rm -f /etc/nixos/configuration.nix
echo "sudo stow --target=/etc/nixos/ nixos_conf"
sudo stow --target=/etc/nixos/ nixos_conf/
echo "stow nix-shell-config-toastielad"
echo "Completed."
