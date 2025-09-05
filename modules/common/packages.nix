{
  config,
  pkgs,
  lib,
  ...
}:

{
  home-manager.sharedModules = [
    {
      home.packages = [
        pkgs.file # File type identifier
        pkgs.wget # Get files over network
        pkgs.tree # File system tree visualizer
        pkgs.killall # Kill all
        pkgs.fd # Modern alternative to 'find'
        pkgs.ripgrep # Modern alternative to 'grep'
        pkgs.jc # Converts many outputs to JSON
        pkgs.fzf # Fuzzy finder
        pkgs.rage # Encryption tool
      ]
      ++ lib.optionals config.isPC [
        # Communication
        pkgs.discord # Messaging platform
        pkgs.discord-ptb # Public Test Build
        pkgs.discord-canary # Bleeding edge
        pkgs.thunderbird # Email client

        # Media and graphics
        pkgs.ffmpeg # Media manipulation suite
        pkgs.obs-studio # Recording/streaming

        # Downloading and torrenting
        pkgs.yt-dlp # Video downloader
        pkgs.qbittorrent # Torrent client

        # Browsers
        pkgs.firefox # Browser by Mozilla
        pkgs.google-chrome # Propietary browser by Google
      ]
      ++ lib.optionals (config.isPC && config.isLinux) [
        # Media and graphics
        pkgs.loupe # Image viewer
        pkgs.kdePackages.okular # Document viewer
        pkgs.haruna # Media player
        pkgs.gimp3-with-plugins # Graphics editor

        # Desktop
        pkgs.swayidle # Idle management
        pkgs.swaylock # Screen locker
        pkgs.xwayland-satellite # Xwayland integration for compositors lacking it
        pkgs.wayland-logout # Utility to kill Wayland compositors

        # Other
        pkgs.papirus-icon-theme # Icon theme
      ]
      ++ lib.optionals config.isLaptop [ pkgs.brightnessctl ]
      ++ lib.optionals config.isDev [
        pkgs.jetbrains.idea-ultimate # Java development
        pkgs.jetbrains.phpstorm # PHP development
        pkgs.jetbrains.rider # .NET development
        pkgs.nixfmt-rfc-style # Nix formatter
        pkgs.nixd # Nix language server
        pkgs.basedpyright # Python language server
        pkgs.postman
      ]
      ++ lib.optionals config.isWork [
        pkgs.libreoffice-qt6-fresh # LibreOffice
      ]
      ++ lib.optionals (config.hostname == "tigris") [ pkgs.librewolf ];
    }
  ];
}
