{ pkgs, ... }:

{
  programs.fish.enable = true;
  programs.nushell.enable = true;

  environment.shells = [
    pkgs.fish
    pkgs.nushell
  ];
}
