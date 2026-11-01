{
  description = "Mat's NixOS Config";

  # To update
  # sudo nixos-rebuild switch --flake .#name

  inputs = {
    # nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    # Home Manager
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    treefmt-nix.url = "github:numtide/treefmt-nix";
    treefmt-nix.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    {
      nixpkgs,
      nixpkgs-unstable,
      home-manager,
      treefmt-nix,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
      treefmtEval = treefmt-nix.lib.evalModule pkgs {
        projectRootFile = "flake.nix";
        programs.nixfmt.enable = true;
        programs.nixfmt.package = pkgs.nixfmt;
      };

      overlays = [
        (final: _: {
          unstable = import nixpkgs-unstable {
            inherit (final.stdenv.hostPlatform) system;
            config.allowUnfree = true;
          };
        })

      ];

      mkHost =
        hostname:
        nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs; };
          modules = [
            { nixpkgs.overlays = overlays; }
            ./hosts/${hostname}
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = { inherit inputs; };
              home-manager.users.mat = import ./modules/home-manager;
            }
          ];
        };
    in
    {
      formatter.${system} = treefmtEval.config.build.wrapper;

      devShells.${system}.default = pkgs.mkShell {
        nativeBuildInputs = with pkgs; [
          pre-commit
          niri
          treefmtEval.config.build.wrapper
          deadnix
        ];
      };

      nixosConfigurations = {
        laptop = mkHost "laptop";
        desktop = mkHost "desktop";
      };
    };
}
