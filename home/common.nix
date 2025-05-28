{ pkgs, lib, ... }:

{
  imports = [
    ../modules/home/git.nix
    ../modules/home/ssh.nix
    ../modules/home/fish.nix
    ../modules/home/direnv.nix
    ../modules/home/firefox.nix
    ../modules/home/ghostty.nix
    ../modules/home/vscode.nix

    ../modules/shared/location-options.nix
  ] ++ lib.optional (builtins.pathExists ../modules/shared/location-private.nix) ../modules/shared/location-private.nix;

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
    age           # Encryption tool

    # Media and graphics
    ffmpeg                 # Media manipulation suite
    obs-studio             # Recording/streaming

    # Downloading and torrenting
    yt-dlp      # Video downloader
    qbittorrent # Torrent client

    # Development
    helix
    jetbrains.idea-ultimate # Java development
    jetbrains.phpstorm      # PHP development
    jetbrains.rider         # .NET development
    jetbrains.rust-rover    # Rust development
    nil                     # Nix language server
    postman

    # Office suite
    libreoffice-qt6-fresh # LibreOffice

    # Other
    aporetic           # Protesilaos Stavrou's build of Iosevka
    google-chrome      # Popular propietary browser
  ];

  programs.home-manager.enable = true;
}
