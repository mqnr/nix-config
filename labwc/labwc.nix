{ config, lib, pkgs, ... }:

{
  xdg.configFile = {
    "labwc/rc.xml".source = ./rc.xml;
    "labwc/autostart".source = ./autostart;
    "labwc/environment".source = ./environment;
  };
}
