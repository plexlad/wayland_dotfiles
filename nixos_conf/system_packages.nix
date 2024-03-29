{ pkgs, ... }: {
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  
  # Use Firefox Nightly instead of the default Firefox
  nixpkgs.overlays =
    let
      moz-rev = "master";
      moz-url = builtins.fetchTarball { url = "https://github.com/mozilla/nixpkgs-mozilla/archive/${moz-rev}.tar.gz";};
      nightlyOverlay = (import "${moz-url}/firefox-overlay.nix");
    in [
      nightlyOverlay
    ];
  programs.firefox.package = pkgs.latest.firefox-nightly-bin;

  environment.systemPackages = with pkgs; [
    ## Defaults (must haves)
    stow # Dotfile manager along with git
    vim
    neovim
    wget # For installation and builds of internet packages
    curl 
    killall
    unzip
    xclip # Copy and paste
    gcc
    git
    wl-clipboard
    brightnessctl
    firefox  # Best browser
    kitty    # Best terminal
    libreoffice # Essentials for school work and basic logo/design
    vlc
    xfce.thunar
    xfce.thunar-volman

    ## Fonts
    nerdfonts # dev fonts
    jetbrains-mono
    fira-code
    fira-code-symbols
    fira-code-nerdfont

    ## Hyprland packages
    waybar # Can be configured with CSS
    eww # More extensible, but uses own markup language
    dunst # Notification Daemon
    libnotify # Sends notifications to daemon
    swww # Wallpaper
    alacritty # Just in case kitty has issues with wayland
    rofi-wayland # App launcher
    networkmanagerapplet # Adds a GUI to set wifi

    # Display workspaces properly
    (pkgs.waybar.overrideAttrs (oldAttrs: {
        mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
      })
    )

    # Config
    pulseaudio
    pipewire # Screensharing / Audio maintaining
    wireplumber
    xdg-desktop-portal
    xdg-desktop-portal-hyprland
    polkit
    libsForQt5.polkit-kde-agent
    gtk4
    gtk3
    gtk2
    # ssh # TODO: enable SSH here
    # Theming packages (gruvbox for life, fight me)
#    gruvbox-gtk-theme
    kde-gruvbox
    bibata-cursors
    libsForQt5.sddm # Display manager
    libsForQt5.qt5.qtgraphicaleffects # For SDDM
    libsForQt5.plasma-framework # Also for SDDM

    ## Editors
    obsidian
    vscodium

    ## Customization
    oh-my-posh
    nwg-look
    # Theming
    gruvbox-gtk-theme
    kde-gruvbox
    sddm
    bibata-cursors

    ## Utility
    # Artsy fartsy
    inkscape
    lutgen
    # Recording
    obs-studio
    obs-cli
    # Nice features
    thefuck # Helps you get that command right with short syntax
    transmission # Torrent client
    spotify-tui # Make sure to oconfigure with the Spotify dev API!
    virtualbox
    # Proton Apps
    protonvpn-cli
    protonmail-bridge

    ## Development
    # Programming language features
    gcc
    dotnet-sdk_8
    rustup
    python3
    go
    bun
    nodejs_21
    electron
    luajitPackages.luarocks
    # Cool dev tools
    lazygit
    flyctl
    zola # A static site generator
    
    ## Comms
    signal-desktop
    signal-cli
    discord
    teams-for-linux
    
    # Fonts
    (nerdfonts.override { fonts = ["CodeNewRoman" "JetBrainsMono" "FiraCode" "FantasqueSansMono" ]; })
    jetbrains-mono
    fira-code
    fira-code-symbols
  ];

  ## File Explorer (Thunar)
  programs.xfconf.enable = true;
  programs.thunar.plugins = with pkgs.xfce; [
    thunar-volman
  ];

  # Packages that are deemed "insecure"
  nixpkgs.config.permittedInsecurePackages = [ "electron-25.9.0" ];

  # Allow unfree packages (vscode, steam, etc.)
  nixpkgs.config.allowUnfree = true;
}
