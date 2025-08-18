{ config, ... }:

{
  imports = [ ./hardware.nix ];

  isLaptop = true;
  isDev = true;
  isWork = true;

  os = "linux";
  hostname = "tigris";

  gpu = "amd";

  users.users.martin = {
    name = "martin";
    home = "/home/martin";
    isNormalUser = true;
    extraGroups = [
      "networkmanager"
      "wheel"
      "bluetooth"
      "video"
    ];
  };

  home-manager.users.martin.home = {
    inherit (config.system) stateVersion;
    homeDirectory = config.users.users.martin.home;
  };

  system.stateVersion = "24.11";
}
