{ pkgs, ... }:

{
  programs.zsh.enable = true;
  programs.bash.enable = true;
  programs.fish.enable = true;
  programs.nushell.enable = true;

  environment.shells = [
    pkgs.zsh
    pkgs.bashInteractive
    pkgs.fish
    pkgs.nushell
  ];
}
