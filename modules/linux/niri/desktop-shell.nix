{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:

lib.mkIf config.isPC {
  home-manager.sharedModules = [
    {
      programs.dankMaterialShell = {
        enable = true;
        enableSystemd = true;
      };
    }
  ];
}
