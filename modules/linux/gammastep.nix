{ config, lib, ... }:

lib.mkIf (config.location.latitude != null && config.location.longitude != null) {
  services.gammastep = {
    enable = true;
    latitude = config.location.latitude;
    longitude = config.location.longitude;
    temperature = { day = 6500; night = 3500; };
  };
}
