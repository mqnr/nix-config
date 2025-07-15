{ config, lib, pkgs, ... }:

{
  services.mako = {
    enable = true;

    settings = {
      font = "Aporetic Sans 14";
      background-color = "#26302FE6";
      border-radius = 6;
      default-timeout = 15000; # 15 seconds
    };
  };
}
