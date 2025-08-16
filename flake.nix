{
  description = "Multi‑host Nix config";

  nixConfig = {
    extra-substituters = [ "https://nix-community.cachix.org" ];

    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };

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
          ];
        };
    in
    {
      nixosConfigurations = {
        acheron = mkSystem {
          host = "acheron";
          system = "x86_64-linux";
        };

        tigris = mkSystem {
          host = "tigris";
          system = "x86_64-linux";
        };
      };
    };
}
