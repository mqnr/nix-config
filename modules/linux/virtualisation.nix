{ config, lib, ... }:

lib.mkIf config.isWork {
  virtualisation.containers.enable = true;

  virtualisation = {
    podman = {
      enable = true;
    };
  };
}
