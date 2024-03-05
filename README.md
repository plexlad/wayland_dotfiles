# DOTFILES
My configuration using wayland (Hyprland WM) and NixOS as the base.

Configurations include:

- NixOS (packages and settings)
- Hyprland (builtin to NixOS as Desktop Manager)
- Dunst
- Kitty
- Neovim
- Oh My Posh
- Waybar
- Other goodies

All of these files are able to stay installed in the same directory with the power of symlinks (with help from GNU Stow) as well as the NixOS rebuilding process.
For more information, look at the respective programs documentation. 

`dot_init.sh` is a script to automatically start linking the necessary resources with stow. Directions below.

## Initializing on a new NixOS system

Make sure git and stow are installed on the shell using: 

`nix-shell -p git stow`

In the shell, change to the ~/.config directory and clone this repository into it:

`cd ~/.config`

`git clone https://github.com/plexlad/wayland_dotfiles.git .`

You can now run the `dot_init.sh` script:

`chmod +x dot_init.sh`

`./dot_init.sh`

> This will require your password for "wheel" permissions

Now rebuild the system:

`sudo nixos-rebuild switch`

And enjoy!
