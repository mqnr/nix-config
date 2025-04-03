{ config, lib, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ./configuration.nix
      ../../modules/location.nix
      ../../keyd.nix
    ] ++ lib.optional (builtins.pathExists ../../private/location.nix) ../../private/location.nix;
}
