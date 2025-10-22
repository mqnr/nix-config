{ config, lib, ... }:

lib.mkIf config.isLaptop {
  services.upower.enable = true;
  services.power-profiles-daemon.enable = true;
}
