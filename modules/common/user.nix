{ config, lib, ... }:

lib.mkIf config.isPC {
  users.users."${config.username}" = {
    home = "/home/${config.username}";
    isNormalUser = true;
    extraGroups = [
      "networkmanager"
      "wheel"
      "bluetooth"
      "video"
    ];
  };
}
