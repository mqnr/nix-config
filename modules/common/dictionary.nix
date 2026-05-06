{
  config,
  pkgs,
  lib,
  ...
}:

lib.mkIf config.isPC {
  home-manager.sharedModules = [
    {
      home.packages = [
        pkgs.hunspellDicts.en_US-large
        pkgs.hunspellDicts.es_MX
      ];
    }
  ];
}
