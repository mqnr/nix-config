{ ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ./configuration.nix
      ../../../modules/linux/keyd.nix
    ];
}
