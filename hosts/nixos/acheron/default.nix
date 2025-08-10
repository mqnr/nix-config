{ ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./configuration.nix
    ../../../modules/linux/keyd.nix
    ../../../modules/linux/steam.nix
  ];
}
