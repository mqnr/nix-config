{ lib, config, pkgs, ... }:

let
  fontSans = "Aporetic Sans";
  fontSansMono = "Aporetic Sans Mono";
in
{
  imports = [
    ./location-module.nix
    ./labwc.nix
  ] ++ lib.optional (builtins.pathExists ./private/location.nix) ./private/location.nix
    ++ lib.optional (builtins.pathExists ./private/ssh.nix) ./private/ssh.nix;

  home.username = "martin";
  home.homeDirectory = "/home/martin";

  home.packages = with pkgs; [
    # Communication
    discord # Messaging platform

    # System utilities
    file          # File type identifier
    wget          # Get files over network
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
    lxqt.pcmanfm-qt       # File manager

    # Programming
    jetbrains.idea-ultimate # Java development
    jetbrains.phpstorm      # PHP development
    jetbrains.rider         # .NET development
    jetbrains.rust-rover    # Rust development
    nil                     # Nix language server

    # Office suite
    libreoffice-qt6-fresh # LibreOffice

    # Emacs
    (emacsWithPackagesFromUsePackage {
      config = ./init.el;

      defaultInitFile = true;

      package = pkgs.emacs-unstable-pgtk;

      extraEmacsPackages = epkgs: [
        epkgs.treesit-grammars.with-all-grammars
      ];
    })

    # Other
    aporetic # Protesilaos Stavrou's build of Iosevka
  ];

  programs.ssh = {
    enable = true;
    addKeysToAgent = "yes";
  };

  services.ssh-agent.enable = true;

  programs.git = {
    enable = true;
    userName = "mzamorano";
    userEmail = "martin@mzamorano.com";
    aliases = {
      "st" = "status";
      "co" = "checkout";
      "br" = "branch";
      "ci" = "commit";
      "unstage" = "reset HEAD --";
      "last" = "log -1 HEAD";
      "lg" = "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit";
    };
    extraConfig = {
      init.defaultBranch = "main";
      color.ui = "auto";
      pull.rebase = false;
    };
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting # Disable greeting
      direnv hook fish | source
    '';
  };

  programs.foot = {
    enable = true;
    settings = {
      main = {
        font = "${fontSansMono}:size=16";
        shell = "${pkgs.fish}/bin/fish";
      };
      colors = {
        alpha = 0.93;
      };
    };
  };

  programs.firefox = {
    enable = true;
  };

  programs.mpv = {
    enable = true;
  };
  
  programs.waybar = {
    enable = true;
    settings.mainBar = {
      layer = "top";
      modules-left = [ "wlr/taskbar" ];
      modules-right = [
        "tray"
        "battery"
        "wireplumber"
        "clock"
      ];
      "wlr/taskbar" = {
        format = "{icon}";
        icon-size = 14;
        icon-theme = "Numix-Circle";
        tooltip-format = "{title}";
        on-click = "activate";
      };
      clock = {
        format = "{:%a %Y-%m-%d %H:%M}";
        tooltip = false;
      };
      tray = {
        icon-size = 17;
        spacing = 10;
        reverse-direction = true;
      };
    };
  };

  services.mako.enable = true;

  services.gammastep = {
    enable = true;
    latitude = config.location.latitude;
    longitude = config.location.longitude;
    temperature = {
      day = 6500;
      night = 3500;
    };
  };

  home.stateVersion = "24.11";

  programs.home-manager.enable = true;
}
