{
  description = "Multi‑host Nix config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, home-manager, ... }:
  let
    # --- Configuration ---
    username = "martin";

    # shared special args for all modules
    specialArgs = {
      inherit inputs username;
    };

    # helper to create system configurationsx
    mkSystem = { host, system }:
      let
        systemBuilder = nixpkgs.lib.nixosSystem;

        homeManagerModule = home-manager.nixosModules.home-manager;

        systemModules = [ ./modules/system/common-linux.nix ];
      in
      systemBuilder {
        inherit system specialArgs;
        modules = systemModules ++ [
          ./modules/shared/common.nix

          { nixpkgs.overlays = [ ]; }

          (./hosts/nixos + "/${host}")

          homeManagerModule
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.${username} = import (./home + "/${host}.nix");
              extraSpecialArgs = specialArgs // { inherit host; };
            };
          }

          ./modules/shared/location-options.nix
          ./modules/shared/location-private.nix
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
