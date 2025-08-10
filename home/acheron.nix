{ pkgs, ... }:

{
  imports = [
    ./common.nix
    ./linux.nix
    ../modules/linux/niri-acheron
  ];

  home = {
    username = "martin";
    homeDirectory = "/home/martin";
    stateVersion = "25.05";
  };
}
