{
  description = "Multi‑host Nix config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    emacs-overlay = {
      url = "github:nix-community/emacs-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, home-manager, emacs-overlay, ... }:
  let
    # --- Convenience ---
    username = "martin";
    supportedSystems = [ "x86_64-linux" "aarch64-darwin" ];

    overlays = [ emacs-overlay.overlays.default ];

    mkPkgs = system: import nixpkgs {
      inherit system overlays;
      config.allowUnfree = true;
    };

    mkHome = { system, host }:
      home-manager.lib.homeManagerConfiguration {
        pkgs = mkPkgs system;
        modules = [
          ./home
        ];
        extraSpecialArgs = {
          inherit inputs username host;
          os = if nixpkgs.lib.strings.hasSuffix "darwin" system
               then "darwin" else "linux";
        };
      };

    linux = "x86_64-linux";
  in
  {
    # --- OS builds ---
    nixosConfigurations = {
      tigris  = nixpkgs.lib.nixosSystem {
        system = linux;
        pkgs   = mkPkgs linux;
        modules = [
          ./hosts/tigris
        ];
      };
    };

    # --- home-manager ---
    homeConfigurations = {
      tigris = mkHome { system = linux;  host = "tigris"; };
    };

    packages = builtins.listToAttrs (map (system: {
      name = system;
      value = {
        home-manager = home-manager.packages.${system}.home-manager;
      };
    }) supportedSystems);
  };
}
