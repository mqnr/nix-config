{ pkgs, ... }:

{
  imports = [
    ./common.nix
    ./linux.nix
    ../modules/home/kanshi.nix
  ];

  home = {
    username = "martin";
    homeDirectory = "/home/martin";
    packages = [ pkgs.brightnessctl ];
    stateVersion = "24.11";
  };
}
