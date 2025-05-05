{ pkgs, ... }:

{
  imports = [
    ../modules/home/kanshi.nix
  ];

  home.packages = [ pkgs.brightnessctl ];
}
