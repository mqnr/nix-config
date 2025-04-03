{ config, lib, pkgs, ... }:

{
  imports = lib.optional (builtins.pathExists ../private/location.nix) ../private/location.nix;

  services.gammastep = {
    enable = true;
    latitude = config.location.latitude;
    longitude = config.location.longitude;
    temperature = {
      day = 6500;
      night = 3500;
    };
  };
}
