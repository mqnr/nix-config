{ pkgs, ... }:

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
