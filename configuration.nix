{ config, lib, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ./location-module.nix
    ] ++ lib.optional (builtins.pathExists ./private/location.nix) ./private/location.nix;

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Enable hibernation
  boot.resumeDevice = "/dev/disk/by-label/NIXOS_SWAP";
  boot.kernelParams = [ "resume_offset=0" "mem_sleep_default=deep" ];

  # Enable zram
  zramSwap = {
    enable = true;
    algorithm = "zstd";
    memoryPercent = 50;  # Use 50% of RAM for compressed swap
  };

  # Networking
  networking.hostName = "tigris";
  networking.networkmanager.enable = true;

  # Set time zone
  time.timeZone = config.location.timezone;

  # Enable X11
  services.xserver.enable = true;

  # Define custom layouts
  services.xserver.xkb.extraLayouts = {
    tangent-qwerty = {
      description = "Tangent QWERTY layout";
      languages = [ "eng" "spa" ];
      symbolsFile = ./kblayouts/tangent-qwerty;
    };
  };

  # Enable CUPS to print documents
  services.printing.enable = true;

  # Enable sound
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # XDG portal
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-wlr
      xdg-desktop-portal-gtk
    ];
  };

  # Define a user account
  users.users.martin = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" ];
  };

  # Services to enable:

  services.tlp.enable = true;

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.greetd.greetd}/bin/agreety --cmd labwc";
        user = "greeter";
      };
    };
  };

  # Enable flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # In short, don't touch this.
  system.stateVersion = "24.11";
}
