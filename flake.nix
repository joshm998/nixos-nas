{
  description = "NixOS NAS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, sops-nix, home-manager, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      lib = nixpkgs.lib;
    in {
      nixosConfigurations.nas = lib.nixosSystem {
        inherit system;
        modules = [
          # Hardware configuration
          ./modules/hardware/hardware-configuration.nix
          
          # Core system configuration
          ./modules/system
          
          # Services 
          ./modules/services
          
	  # Containers
	  ./modules/containers
	
          # Home-manager configuration
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.nasuser = import ./modules/home-manager;
          }
        ];
      };
    };
}
