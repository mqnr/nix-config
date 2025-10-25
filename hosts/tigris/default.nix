{ config, ... }:

{
  imports = [
    ./hardware.nix
    ./diagnosis.nix
  ];

  username = "martin";
  hostname = "tigris";

  isLaptop = true;
  isDev = true;
  isWork = true;

  gpu = "amd";

  home-manager.users."${config.username}".home = {
    inherit (config.system) stateVersion;
    homeDirectory = config.users.users."${config.username}".home;
  };

  system.stateVersion = "24.11";
}
