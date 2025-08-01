{ pkgs, lib, ... }:

{
  imports = [
    ../modules/common/git.nix
    ../modules/common/ssh.nix
    ../modules/common/fish.nix
    ../modules/common/direnv.nix
    ../modules/common/ghostty.nix
    ../modules/common/vscode.nix
    ../modules/common/nushell.nix
    ../modules/common/bat.nix
    ../modules/common/helix.nix
    ../modules/common/fonts.nix
    ../modules/common/shell.nix

    ../lib/location.nix
    ../modules/common/location-private.nix
  ];

  home.packages = with pkgs; [
    # Communication
    discord        # Messaging platform
    discord-ptb    # Public Test Build
    discord-canary # Bleeding edge
    thunderbird    # Email client

    # System utilities
    file          # File type identifier
    wget          # Get files over network
    tree          # File system tree visualizer
    killall       # Kill all
    fd            # Modern alternative to 'find'
    ripgrep       # Modern alternative to 'grep'
    fzf           # Fuzzy finder
    age           # Encryption tool

    # Media and graphics
    ffmpeg                 # Media manipulation suite
    obs-studio             # Recording/streaming

    # Downloading and torrenting
    yt-dlp      # Video downloader
    qbittorrent # Torrent client

    # Development
    jetbrains.idea-ultimate # Java development
    jetbrains.phpstorm      # PHP development
    jetbrains.rider         # .NET development
    jetbrains.rust-rover    # Rust development
    nil                     # Nix language server
    postman

    # Office suite
    libreoffice-qt6-fresh # LibreOffice

    # Browsers
    brave         # Privacy-focused Chromium-based browser  
    firefox       # Browser by Mozilla
    librewolf     # Firefox fork
    google-chrome # Propietary browser by Google
  ];

  programs.home-manager.enable = true;
}
