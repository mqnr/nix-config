{
  config,
  lib,
  pkgs,
  ...
}:

{
  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Networking
  networking.hostName = "acheron";
  networking.networkmanager.enable = true;

  # NVIDIA
  hardware.graphics.enable = true;
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia.open = true;

  environment.systemPackages = [ pkgs.bubblewrap ];

  # In short, don't touch this.
  system.stateVersion = "25.05";
}
