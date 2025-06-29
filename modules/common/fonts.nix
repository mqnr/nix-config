{ pkgs, ... }:

{
  home.packages = [
    pkgs.aporetic
    pkgs.nerd-fonts.jetbrains-mono
  ];

  # TODO: make this Linux-only maybe?
  fonts.fontconfig.enable = true;
}
