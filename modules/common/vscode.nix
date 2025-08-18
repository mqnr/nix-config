{
  config,
  pkgs,
  lib,
  ...
}:

lib.mkIf config.isPC {
  home-manager.sharedModules = [
    {
      programs.vscode = {
        enable = true;
        package = pkgs.vscodium;
      };
    }
  ];
}
