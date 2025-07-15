{ pkgs, ... }:

{
  imports = [
    ../modules/linux/qt.nix
    ../modules/linux/gtk.nix
    ../modules/common/mpv.nix
    ../modules/linux/sfwbar
    ../modules/linux/mako.nix
    ../modules/linux/mime.nix
    ../modules/linux/dconf.nix
    ../modules/linux/cursor.nix
    ../modules/linux/gammastep.nix
    ../modules/linux/niri
    ../modules/linux/wallpaper.nix
    ../modules/linux/fuzzel.nix
    ../modules/linux/userdirs.nix
    ../modules/linux/file-manager.nix
  ];

  home.packages = with pkgs; [
    # Media and graphics
    viewnior               # Image viewer
    kdePackages.okular     # Document viewer

    # Desktop
    swayidle              # Idle management
    swaylock              # Screen locker
    xwayland-satellite    # Xwayland integration for compositors lacking it
    wayland-logout        # Utility to kill Wayland compositors

    # Other
    papirus-icon-theme        # Icon theme
  ];
}
