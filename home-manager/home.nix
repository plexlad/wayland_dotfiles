{ config, pkgs, ... }:

{
  home.username = "toastielad";
  home.homeDirectory = "/home/toastielad";

  home.stateVersion = "23.11"; # Be really careful with this
  
  # Allows unfree non opensource packages
	nixpkgs.config.allowUnfree = true;

  # Manage plaintext dotfiles
  home = {
		packages = with pkgs; [
			hello
			# Customize fonts
	    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })
			# Shell scripts that go into bin and can be accessed anywhere
			# (pkgs.writeShellScriptBin "my-hello" ''
			#   echo "Hello, ${config.home.username}!"
			# '')
			
			## Editors
			neovim
			obsidian

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
			thefuck # Funniest name, but helps to correct commands if they don't work properly

			## Development
			gcc
			vscodium
			vscode
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

			## Fonts
			(nerdfonts.override { fonts = [ "CodeNewRoman" "JetBrainsMono" "FiraCode" ]; })
			jetbrains-mono
			fira-code
			fira-code-symbols
		];

		file = {
			
		};
  };

	# Required to autoload fonts
	fonts.fontconfig.enable = true;

  home.sessionVariables = {
    EDITOR = "nvim";
  };

#  programs.home-manager.enable = true;

	programs.neovim = {
		enable = true;
		defaultEditor = true;
	};

	services.gpg-agent = {
		enable = true;
		defaultCacheTtl = 1800;
		enableSshSupport = true;
	};
}
