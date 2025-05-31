{ config, lib, pkgs, ... }:

{
  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      icon-theme = "Papirus-Dark";
    };
  };
}
