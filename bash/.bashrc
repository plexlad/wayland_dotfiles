alias backup_nixos_config='cp -f /etc/nixos/configuration.nix ~/.config/nixos_conf/'
alias edit_nixos_config='sudo nvim /etc/nixos/configuration.nix'
alias refresh_wallpaper='swww img ~/.config/wallpapers/pixelart/dock.jpg'

eval "$(thefuck --alias)"
eval "$(oh-my-posh -c ~/.config/oh-my-posh/theme.json init bash)"

export PATH=/home/toastielad/.local/share/nvim/mason/bin:$PATH
