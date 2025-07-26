{
  description = "Multi‑host Nix config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      home-manager,
      niri,
      ...
    }:
    let
      # --- Configuration ---
      username = "martin";

      # shared special args for all modules
      specialArgs = { inherit inputs username; };

      # helper to create system configurationsx
      mkSystem =
        { host, system }:
        let
          systemBuilder = nixpkgs.lib.nixosSystem;

          homeManagerModule = home-manager.nixosModules.home-manager;

          systemModules = [ ./modules/linux/common-linux.nix ];
        in
        systemBuilder {
          inherit system specialArgs;
          modules = systemModules ++ [
            ./modules/common/common.nix

            (
              { pkgs, ... }:
              {
                programs.niri.enable = true;
                programs.niri.package = pkgs.niri;
                nixpkgs.overlays = [ niri.overlays.niri ];
              }
            )

            (./hosts/nixos + "/${host}")

            niri.nixosModules.niri

            homeManagerModule
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                users.${username} = import (./home + "/${host}.nix");
                extraSpecialArgs = specialArgs // {
                  inherit host;
                };
              };
            }

            ./lib/location.nix
            ./modules/common/location-private.nix
          ];
        };
    in
    {
      nixosConfigurations = {
        tigris = mkSystem {
          host = "tigris";
          system = "x86_64-linux";
        };
      };
    };
}
