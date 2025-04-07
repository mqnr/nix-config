{ config, lib, pkgs, ... }:

{
  home.packages = [ pkgs.sfwbar ];

  xdg.configFile."sfwbar/sfwbar.config".source = ./sfwbar.config;
}
