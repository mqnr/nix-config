{ pkgs, ... }:

{
  imports = [
    ../modules/home/labwc
    ../modules/home/qt.nix
    ../modules/home/gtk.nix
    ../modules/home/mpv.nix
    ../modules/home/sfwbar
    ../modules/home/foot.nix
    ../modules/home/mako.nix
    ../modules/home/mime.nix
    ../modules/home/pcmanfm
    ../modules/home/dconf.nix
    ../modules/home/cursor.nix
    ../modules/home/waybar
    ../modules/home/gammastep.nix
  ];

  home.packages = with pkgs; [
    # Media and graphics
    viewnior               # Image viewer
    kdePackages.okular     # Document viewer

    # Desktop
    labwc                 # Stacking Wayland compositor
    swaybg                # Wallpaper tool
    swayidle              # Idle management
    swaylock              # Screen locker
    sway-contrib.grimshot # Screenshot tool
    fuzzel                # Application launcher

    # Other
    papirus-icon-theme # Icon theme
  ];
}
