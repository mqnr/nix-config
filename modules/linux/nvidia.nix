{ config, lib, ... }:

lib.mkIf (config.isPC && config.gpu == "nvidia") {
  hardware.graphics.enable = true;
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia.open = true;
}
