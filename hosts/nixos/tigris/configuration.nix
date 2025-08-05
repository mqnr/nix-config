{ config, lib, pkgs, ... }:

{
  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Enable hibernation
  boot.resumeDevice = "/dev/disk/by-label/NIXOS_SWAP";
  boot.kernelParams = [ "quiet" "loglevel=3" "resume_offset=0" "mem_sleep_default=deep" ];

  # Enable zram
  zramSwap = {
    enable = true;
    algorithm = "zstd";
    memoryPercent = 50;  # Use 50% of RAM for compressed swap
  };

  # Networking
  networking.hostName = "tigris";
  networking.networkmanager.enable = true;

  # Services to enable:

  services.tlp.enable = true;

  # In short, don't touch this.
  system.stateVersion = "24.11";
}
