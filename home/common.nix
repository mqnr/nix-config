{ pkgs, lib, ... }:

{
  imports = [
    ../modules/common/git.nix
    ../modules/common/ssh.nix
    ../modules/common/fish.nix
    ../modules/common/direnv.nix
    ../modules/common/firefox.nix
    ../modules/common/ghostty.nix
    ../modules/common/vscode.nix

    ../modules/common/location-options.nix
    ../modules/common/location-private.nix
  ];

  home.packages = with pkgs; [
    # Communication
    discord        # Messaging platform
    discord-ptb    # Public Test Build
    discord-canary # Bleeding edge

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
