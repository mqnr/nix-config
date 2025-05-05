{ pkgs, ... }:

{
  programs.foot = {
    enable = true;
    settings = {
      main = {
        font = "Aporetic Sans Mono:size=16";
        shell = "${pkgs.fish}/bin/fish";
      };
      colors = {
        alpha = 0.93;
      };
    };
  };
}
