{
  description = "Mat's Clean NixOS 25.11 Config";

  inputs = {
    # nixpkgs version (25.11)
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";

    # Home Manager for 25.11
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules = [
        ./configuration.nix
        home-manager.nixosModules.home-manager {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.mat = import ./home.nix;
        }
      ];
    };
  };
}
