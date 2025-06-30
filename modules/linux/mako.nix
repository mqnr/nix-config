{ config, lib, pkgs, ... }:

{
  services.mako = {
    enable = true;

    settings = {
      default-timeout = 120000; # 2 minutes
    };
  };
}
