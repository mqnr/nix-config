{ lib, config, pkgs, ... }:

{
  imports = [
    ../modules/location.nix
    ./emacs
    ./labwc/labwc.nix
    ./qt.nix
    ./git.nix
    ./gtk.nix
    ./mpv.nix
    ./sfwbar
    ./ssh.nix
    ./fish.nix
    ./foot.nix
    ./mako.nix
    ./mime.nix
    ./pcmanfm
    ./dconf.nix
    ./cursor.nix
    ./direnv.nix
    ./kanshi.nix
    ./waybar.nix
    ./firefox.nix
    ./gammastep.nix
  ];

  home.username = "martin";
  home.homeDirectory = "/home/martin";

  home.packages = with pkgs; [
    # Communication
    discord # Messaging platform

    # System utilities
    file          # File type identifier
    wget          # Get files over network
    tree          # File system tree visualizer
    killall       # Kill all
    fd            # Modern alternative to 'find'
    ripgrep       # Modern alternative to grep
    fzf           # Fuzzy finder
    brightnessctl # Control device brightness
    age           # Encryption tool

    # Media and graphics
    viewnior               # Image viewer
    kdePackages.okular     # Document viewer
    ffmpeg                 # Media manipulation suite
    obs-studio             # Recording/streaming

    # Downloading and torrenting
    yt-dlp      # Video downloader
    qbittorrent # Torrent client

    # Desktop
    labwc                 # Stacking Wayland compositor
    swaybg                # Wallpaper tool
    swayidle              # Idle management
    swaylock              # Screen locker
    sway-contrib.grimshot # Screenshot tool
    fuzzel                # Application launcher

    # Programming
    jetbrains.idea-ultimate # Java development
    jetbrains.phpstorm      # PHP development
    jetbrains.rider         # .NET development
    jetbrains.rust-rover    # Rust development
    nil                     # Nix language server

    # Office suite
    libreoffice-qt6-fresh # LibreOffice

    # Other
    aporetic           # Protesilaos Stavrou's build of Iosevka
    papirus-icon-theme # Icon theme
  ];

  home.stateVersion = "24.11";

  programs.home-manager.enable = true;
}
