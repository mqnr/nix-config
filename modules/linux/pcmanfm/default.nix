{ pkgs, ... }:

{
  home.packages = with pkgs; [
    lxqt.pcmanfm-qt

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
