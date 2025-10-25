{
  config,
  pkgs,
  lib,
  ...
}:

{
  home-manager.sharedModules = [
    {
      home.packages =
        lib.optionals config.isPC [
          pkgs.discord # Messaging platform
          pkgs.discord-ptb # Public Test Build
          pkgs.discord-canary # Bleeding edge
          pkgs.thunderbird # Email client

          # Media and graphics
          pkgs.obs-studio # Recording/streaming
          pkgs.loupe # Image viewer
          pkgs.kdePackages.okular # Document viewer
          pkgs.haruna # Media player
          pkgs.gimp3-with-plugins # Graphics editor

          # Downloading and torrenting
          pkgs.qbittorrent # Torrent client

          # Browsers
          pkgs.brave # Privacy-focused Chromium-based browser
          pkgs.firefox # Browser by Mozilla
          pkgs.google-chrome # Propietary browser by Google

          # Desktop
          pkgs.xwayland-satellite # Xwayland integration for compositors lacking it
          pkgs.wayland-logout # Utility to kill Wayland compositors

          # Other
          pkgs.wl-clipboard
          pkgs.papirus-icon-theme # Icon theme
        ]
        ++ lib.optionals config.isDev [
          pkgs.jetbrains.idea-ultimate # Java development
          pkgs.jetbrains.phpstorm # PHP development
          pkgs.jetbrains.rider # .NET development
          pkgs.postman # You know what Postman is
        ]
        ++ lib.optionals (config.hostname == "tigris") [ pkgs.librewolf ];
    }
  ];
}
