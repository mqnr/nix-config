{
  config,
  pkgs,
  lib,
  ...
}:

lib.mkIf config.isPC {
  services.tumbler.enable = true;

  home-manager.sharedModules = [
    {
      home.packages = [
        pkgs.nautilus

        pkgs.lxmenu-data
        pkgs.shared-mime-info

        pkgs.evince
        pkgs.ffmpegthumbnailer

        pkgs.lxqt.lxqt-archiver

        pkgs.unzip
        pkgs.p7zip
        pkgs.unrar
        pkgs.zip
      ];
    }
  ];
}
