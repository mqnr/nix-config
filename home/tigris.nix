{ pkgs, ... }:

{
  imports = [
    ./common.nix
    ./linux.nix
    ../modules/linux/niri-tigris
  ];

  home = {
    username = "martin";
    homeDirectory = "/home/martin";
    packages = [
      pkgs.brightnessctl

      pkgs.librewolf

      # Development
      pkgs.jetbrains.idea-ultimate # Java development
      pkgs.jetbrains.phpstorm      # PHP development
      pkgs.jetbrains.rider         # .NET development
      pkgs.jetbrains.rust-rover    # Rust development
      pkgs.nil                     # Nix language server
      pkgs.postman

      # Office suite
      pkgs.libreoffice-qt6-fresh # LibreOffice
    ];
    stateVersion = "24.11";
  };
}
