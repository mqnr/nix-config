{ config, ... }:

{
  imports = [ ./hardware.nix ];

  username = "martin";
  hostname = "acheron";

  isDesktop = true;
  isGaming = true;

  gpu = "nvidia";

  home-manager.users."${config.username}".home = {
    inherit (config.system) stateVersion;
    homeDirectory = config.users.users."${config.username}".home;
  };

  system.stateVersion = "25.05";
}
