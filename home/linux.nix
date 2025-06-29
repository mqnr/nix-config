{ pkgs, ... }:

{
  imports = [
    ../modules/linux/qt.nix
    ../modules/linux/gtk.nix
    ../modules/common/mpv.nix
    ../modules/linux/sfwbar
    ../modules/linux/mako.nix
    ../modules/linux/mime.nix
    ../modules/linux/pcmanfm
    ../modules/linux/dconf.nix
    ../modules/linux/cursor.nix
    ../modules/linux/gammastep.nix
    ../modules/linux/niri
  ];

  home.packages = with pkgs; [
    # Media and graphics
    viewnior               # Image viewer
    kdePackages.okular     # Document viewer

    # Desktop
    swaybg                # Wallpaper tool
    swayidle              # Idle management
    swaylock              # Screen locker
    fuzzel                # Application launcher
    xwayland-satellite    # Xwayland integration for compositors lacking it
    wayland-logout        # Utility to kill Wayland compositors

    # Other
    papirus-icon-theme        # Icon theme
  ];
}
