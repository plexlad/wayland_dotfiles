
# init script, will probably become more elaborate
echo "Toastielad dotfile copy and initialization!"
echo "Requires GNU Stow"
echo "Starting..."
echo "stow bash"
stow bash
echo "sudo stow --target=/etc/nixos/ nixos_conf"
sudo stow --target=/etc/nixos/ nixos_conf/
echo "Completed."