{ config, lib, pkgs, ... }:

{
  xdg.dataFile = {
    "themes" = {
      source = ../vendor/labwc-themes;
      recursive = true;
    };
  };

  xdg.configFile = {
    "labwc/rc.xml".source = ./rc.xml;
    "labwc/autostart".source = ./autostart;
    "labwc/environment".source = ./environment;
  };
}
