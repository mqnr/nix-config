{
  description = "Multi‑host Nix config";

  nixConfig = {
    extra-substituters = [ "https://nix-community.cachix.org" ];

    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];

    builders-use-substitutes = true;
    trusted-users = [
      "root"
      "@build"
      "@wheel"
      "@admin"
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
      ...
    }:
    let
      # --- Configuration ---
      # TODO: get this another way
      username = "martin";

      lib = nixpkgs.lib.extend (import ./lib/util.nix) // home-manager.lib;

      # shared special args for all modules
      specialArgs = { inherit inputs lib username; };

      # helper to create system configurationsx
      mkSystem =
        { host, system }:
        let
          systemBuilder = nixpkgs.lib.nixosSystem;

          homeManagerModule = home-manager.nixosModules.home-manager;
        in
        systemBuilder {
          inherit system specialArgs;
          modules = [
            ./lib/options.nix

            ./modules/common
            ./modules/linux # TODO: do something different

            (
              { pkgs, ... }:
              {
                programs.niri.enable = true;
                programs.niri.package = pkgs.niri;
                nixpkgs.overlays = [ inputs.niri.overlays.niri ];
              }
            )

            (./hosts + "/${host}")

            inputs.niri.nixosModules.niri

            homeManagerModule
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
