{ config, lib, ... }:

lib.mkIf config.isPC {
  services = {
    gvfs.enable = true;
    udisks2.enable = true;
    devmon.enable = true;
    geoclue2.enable = true;
    automatic-timezoned.enable = true;
  };

  # TODO: place this in another module
  security.polkit.enable = true;
}
