{
  config,
  pkgs,
  lib,
  ...
}:

lib.mkIf config.isPC {
  home-manager.sharedModules = [
    {
      home.pointerCursor = {
        enable = true;
        package = pkgs.simp1e-cursors;
        name = "Simp1e-Catppuccin-Mocha";
        size = 64;
      };
    }
  ];
}
