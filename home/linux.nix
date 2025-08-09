{ pkgs, ... }:

{
  imports = [
    ../modules/linux/qt.nix
    ../modules/linux/gtk.nix
    ../modules/common/mpv.nix
    ../modules/linux/mako.nix
    ../modules/linux/mime.nix
    ../modules/linux/dconf.nix
    ../modules/linux/cursor.nix
    ../modules/linux/gammastep.nix
    ../modules/linux/wallpaper.nix
    ../modules/linux/fuzzel.nix
    ../modules/linux/userdirs.nix
    ../modules/linux/file-manager.nix
  ];

  home.packages = [
    # Media and graphics
    pkgs.loupe # Image viewer
    pkgs.kdePackages.okular # Document viewer
    pkgs.haruna # Media player

    # Desktop
    pkgs.swayidle # Idle management
    pkgs.swaylock # Screen locker
    pkgs.xwayland-satellite # Xwayland integration for compositors lacking it
    pkgs.wayland-logout # Utility to kill Wayland compositors

    # Other
    pkgs.papirus-icon-theme # Icon theme
  ];
}
