# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ 
      # Include the results of the hardware scan.
      # Uses the hardware configuration in the root
      /etc/nixos/hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixdeck"; # Define your hostname.
  # Below cannot work with networkmanager
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Denver";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Enable flakes and nix-command
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  ## Options for GNOME, Hyprland used below
  # Enable the GNOME Desktop Environment.
  #services.xserver.displayManager.gdm.enable = true;
  #services.xserver.desktopManager.gnome.enable = true;

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.

  # Configuration for home user
  users.users.toastielad = {
    isNormalUser = true;
    extraGroups = [ "wheel" "video" ];
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  # 
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
#    kde-gruvbox
#    bibata-cursors

    ## Editors
    obsidian
    vscodium

    ## Customization
    oh-my-posh
    nwg-look
    # Theming
    gruvbox-gtk-theme
    kde-gruvbox
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

    ## Development
    gcc
    gh
    dotnet-sdk_8
    rustup
    python3
    bun
    electron
    
    ## Comms
    signal-desktop
    signal-cli
    discord
    teams-for-linux
    
    # Fonts
    (nerdfonts.override { fonts = ["CodeNewRoman" "JetBrainsMono" "FiraCode" ]; })
    jetbrains-mono
    fira-code
    fira-code-symbols
  ];

  # Allow insecure packages (I think it's a dependency)
  nixpkgs.config.permittedInsecurePackages = [ "electron-25.9.0" ];

  # Font configuration
  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "CodeNewRoman" "JetBrainsMono" "FiraCode" ]; }) # Set dev fonts
    jetbrains-mono
    fira-code
    fira-code-symbols
    fira-code-nerdfont
  ];

  ## File Explorer (Thunar)
  programs.xfconf.enable = true;
  programs.thunar.plugins = with pkgs.xfce; [
    thunar-volman
  ];

  # Polkit p=otocol options
  security.polkit.enable = true;

  security.polkit.extraConfig = ''
    polkit.addRule(function(action, subject) {
      if (
        subject.isInGroup("users")
	  && (
	    action.id == "org.freedesktop.login1.reboot" ||
	    action.id == "org.freedesktop.login1.reboot-multiple-sessions" ||
	    action.id == "org.freedesktop.login1.power-off" ||
	    action.id == "org.freedesktop.login1.power-off-multiple-sessions"
	  )
	)
      {
        return polkit.Result.YES;
      }
    })
  '';

  systemd = {
    user.services.polkit-gnome-authentication-agent-1 = {
      description = "polkit-gnome-authentication-agent-1";
      wantedBy = [ "graphical-session.target" ];
      wants = [ "graphical-session.target" ];
      after = [ "graphical-session.target" ];
      serviceConfig = {
        Type = "simple";
	ExecStart = "${pkgs.libsForQt5.polkit-kde-agent}/libexec/polkit-kde-authentication-agent-1";
	Restart = "on-failure";
	RestartSec = 1;
	TimeoutStopSec = 10;
      };
    };
  };

  # Allow unfree packages (vscode, steam, etc.)
  nixpkgs.config.allowUnfree = true;

  ## Hyprland Configuration ##
  programs.hyprland = {
    enable = true;
    #nvidiaPatches = true # If using nvidia based GPU
    xwayland.enable = true;
  };

  environment.sessionVariables = {
    # If cursor becomes invisible
    #WLR_NO_HARDWARE_CURSORS = "1";
    # Hint electron apps to use Wayland
  };

  hardware = {
    opengl.enable = true;
    # For Nvidia gpu
    #nvidia.modesetting.enable = true;
  };

  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

  # Editor default options
#  programs.neovim.enable = true;
#  programs.neovim.defaultEditor = true;
  
  ## Theming (below uses GTK and QT to color everything to the needed degree
  qt.enable = true; # QT (for KDE based packages)
  qt.platformTheme = "gtk2";
#  qt.style.package = pkgs.kde-gruvbox;
  qt.style = "gtk2";

#  gtk = {
#    enable = true; # GTK (for Gnome based packages)
#    theme.package = pkgs.gruvbox-gtk-theme;
#     TODO: Set cursor here
#  }

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  ## Bluetooth
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  # Bluetooth configuration client
  services.blueman.enable = true;
  # Extra bluetooth codecs (using pipewire so disabled for now)
#  hardware.pulseaudio = {
#    enable = true;
#    package = pkgs.pulseaudioFull;
#  };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

}
