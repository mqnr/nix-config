{ ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ./configuration.nix
      ../../../modules/system/keyd.nix
    ];
}
