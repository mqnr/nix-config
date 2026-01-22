{
  config,
  lib,
  ...
}:

lib.mkIf config.isPC {
  home-manager.sharedModules = [
    {
      programs.dank-material-shell = {
        enable = true;
        systemd.enable = true;
        niri.includes.enable = false;
      };
    }
  ];
}
