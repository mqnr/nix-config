{ config, lib, ... }:

lib.mkIf config.isLaptop {
  services.upower.enable = true;
}
