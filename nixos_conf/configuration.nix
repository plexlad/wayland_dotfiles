# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }: 
let
    # Use SDDM theme for the... SDDM theme
    sddm-theme = pkgs.stdenv.mkDerivation {
        name = "gruvbox-sddm-theme";
        src = pkgs.fetchFromGitHub {
            owner = "scientiac";
            repo = "gruvbox-minimal-sddm";
            rev = "af0e63389031619edbe93d71f44a5ece50edc1a2";
            hash = "sha256-CKfACg5nT8Ip9Y7kr5Wi3SJOTdQZ4U+ISeGP9HmlTAY=";
        };

        installPhase = ''
            mkdir -p $out
            cp -R ./* $out/
        '';
    };
in
{
  imports =
    [ 
      # Include the results of the hardware scan.
      # Uses the hardware configuration in the root
      /etc/nixos/hardware-configuration.nix
      ./system_packages.nix # Packages to install
      ./fonts.nix # Fonts
      ./window_manager.nix # Currently set as Hyprland WM
      ./virtual_machine.nix # Set up for VirtualBox
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

  # Use SDDM as the dispaly manager
  services.xserver = {
    enable = true;
    layout = "us";
    xkbVariant = "";
    displayManager = {
      defaultSession = "hyprland";
      sddm = {
        enable = true;
        theme = "${ sddm-theme }";
        wayland.enable = true;
      };
    };
  };

  ## Options for GNOME, Hyprland used below that
  # Enable the GNOME Desktop Environment.
  #services.xserver.displayManager.gdm.enable = true;
  #services.xserver.desktopManager.gnome.enable = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;

#  # Enable sound with pipewire.
#  sound.enable = true;
#  security.rtkit.enable = true;
#  services.pipewire = {
#    enable = true;
#    alsa.enable = true;
#    alsa.support32Bit = true;
#    pulse.enable = true;
#    # If you want to use JACK applications, uncomment this
#    #jack.enable = true;
#
#    # use the example session manager (no others are packaged yet so this is enabled by default,
#    # no need to redefine it in your config for now)
#    #media-session.enable = true;
#  };

hardware.pulseaudio = {
    enable = true;
    support32Bit = true;
};
nixpkgs.config.pulseaudio = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.

  # Configuration for home user
  users.users.toastielad = {
    isNormalUser = true;
    extraGroups = [ "wheel" "video" "networkmanager" "audio" ];
  };

  # Allow insecure packages (I think it's a dependency)

  # Polkit protocol options
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

  # Tailscale VPN (to connect to other servers and learn tools)
  services.tailscale.enable = true;

  # Steam for gaming
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };

  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?
}
