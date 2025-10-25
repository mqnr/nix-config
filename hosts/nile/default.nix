{ config, ... }:

{
  username = "martin";
  hostname = "nile";

  isLaptop = true;
  isDev = true;
  isWork = true;

  home-manager.users."${config.username}".home = {
    stateVersion = "25.05";
    homeDirectory = config.users.users."${config.username}".home;
  };

  system.stateVersion = 6;
}
