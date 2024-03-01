{
  description = "toastielad configuration for NixOS";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs }@inputs:
  let 
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;

      config = {
        allowUnfree = true; # Allows unfree packages like Steam, etc.
      };
    };
  in
  {
    nixosConfigurations = {
      specialArgs = { inherit inputs system; };
  
      # The configuration file location
      modules = [
        ./configuration.nix
      ];
    };
  };
}
