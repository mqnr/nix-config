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
      home.packages = with pkgs; [
        nautilus

        lxde.lxmenu-data
        shared-mime-info

        evince
        ffmpegthumbnailer

        lxqt.lxqt-archiver

        unzip
        p7zip
        unrar
        zip
      ];
    }
  ];
}
