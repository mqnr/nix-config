{ pkgs, ... }:

{
  imports = [
    ./greetd-sys.nix
    ./niri/xdg.nix
  ];

  # Enable X11
  services.xserver.enable = true;

  # Define custom layouts
  services.xserver.xkb.extraLayouts = {
    tangent-qwerty = {
      description = "Tangent QWERTY layout";
      languages = [ "eng" "spa" ];
      symbolsFile = ../../kblayouts/tangent-qwerty;
    };
    tangent-gallium = {
      description = "Tangent Gallium layout";
      languages = [ "eng" "spa" ];
      symbolsFile = ../../kblayouts/tangent-gallium;
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

  # Enable dconf
  programs.dconf.enable = true;

  # Define a user account
  users.users.martin = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" "bluetooth" "video" ];
  };

  # Services to enable:

  services.gvfs.enable = true;

  services.udisks2.enable = true;

  services.devmon.enable = true;

  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  security.polkit.enable = true;

  services.tumbler.enable = true;

  # Enable flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
}
