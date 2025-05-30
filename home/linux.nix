{ pkgs, ... }:

{
  imports = [
    ../modules/home/qt.nix
    ../modules/home/gtk.nix
    ../modules/home/mpv.nix
    ../modules/home/sfwbar
    ../modules/home/mako.nix
    ../modules/home/mime.nix
    ../modules/home/pcmanfm
    ../modules/home/dconf.nix
    ../modules/home/cursor.nix
    ../modules/home/waybar
    ../modules/home/gammastep.nix
    ../modules/home/niri.nix
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
    greetd.gtkgreet    # GTK frontend for greetd
    papirus-icon-theme # Icon theme
  ];
}
