{ pkgs, ... }:

{
  imports = [
    ./common.nix
    ./linux.nix
  ];

  home = {
    username = "martin";
    homeDirectory = "/home/martin";
    packages = [ pkgs.brightnessctl ];
    stateVersion = "24.11";
  };
}
