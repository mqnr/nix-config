{ config, lib, ... }:

lib.mkIf config.isPC {
  services.automatic-timezoned.enable = true;

  # TODO: place this in another module
  security.polkit.enable = true;
}
