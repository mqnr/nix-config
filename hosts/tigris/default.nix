{ config, lib, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ../common
      ./configuration.nix
      ../../modules/location.nix
      ../common/keyd.nix
    ] ++ lib.optional (builtins.pathExists ../../private/location.nix) ../../private/location.nix;
}
