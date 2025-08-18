{
  config,
  pkgs,
  lib,
  ...
}:

lib.mkIf config.isGaming {
  programs.steam.enable = true;
  environment.systemPackages = [ pkgs.bubblewrap ];
}
