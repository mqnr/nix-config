{ config, ... }:

{
  imports = [ ./hardware.nix ];

  isDesktop = true;
  isGaming = true;

  os = "linux";
  hostname = "acheron";

  gpu = "nvidia";

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

  system.stateVersion = "25.05";
}
