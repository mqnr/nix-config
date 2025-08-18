{ config, lib, ... }:

lib.mkIf config.isPC {
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
}
