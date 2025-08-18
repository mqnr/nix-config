{ config, lib, ... }:

lib.mkIf config.isPC {
  networking.hostName = config.hostname;
  networking.networkmanager.enable = true;

  hardware.bluetooth.enable = true;
  services.blueman.enable = true;
}
