{ lib, ... }:

{
  imports = lib.optional (builtins.pathExists ../modules/shared/location-private.nix) ../modules/shared/location-private.nix;

  nixpkgs.config.allowUnfree = true;
}
