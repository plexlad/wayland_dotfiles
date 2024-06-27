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

  # Neovim as text editor
  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

  environment.systemPackages = with pkgs; [
    ## Defaults (must haves)
    stow # Dotfile manager along with git
    vim
    bashmount # Mount USB drives
    ripgrep # This and others are used with neovim plugins
    fd # Alternative to find
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
    hyprpaper # Set wallpaper with hyprland support

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
    blockbench-electron
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
    # Internet tools
    inetutils # Telnet contained
    spotify
    flameshot
    marp-cli # Presentations in markdown
    # Writing
    xournal
    xournalpp
    zotero # Note taking research app
    cura # 3D printing slicer

    ## Development (Developer tools)
    # Programming language features
    gcc
    dotnet-sdk_8
    netcoredbg # Debugging for dotnet
    omnisharp-roslyn # More debugging
    rustup
    python3
    go
    air # Auto restart for go
    delve
    bun
    nodejs_21
    nodePackages.postcss
    electron
    lua
    stylua
    lua-language-server
    rust-analyzer
    luajitPackages.luarocks
    luajitPackages.jsregexp
    php83Packages.composer
    zulu
    julia_18
    python311Packages.pip
    php
    # Cool dev tools
    lazygit
    gh # Github CLI becuase keys can be annoying sometimes
    flyctl
    zola # A static site generator
    chromium
    tailwindcss
    rust-analyzer
    
    ## Comms
    signal-desktop
    signal-cli
    discord
    teams-for-linux

    # Games
    steam
    ferium
    
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
