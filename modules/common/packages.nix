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
        pkgs.ffmpeg
        pkgs.yt-dlp
      ]
      ++ lib.optionals config.isDev [
        pkgs.nixfmt-rfc-style # Nix formatter
        pkgs.nixd # Nix language server
        pkgs.gopls # Go language server
        pkgs.claude-code # Agentic AI coding tool
        pkgs.basedpyright # Python language server
      ];
    }
  ];
}
