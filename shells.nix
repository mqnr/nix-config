{ pkgs, ... }:

{
  programs.fish.enable = true;

  environment.shells = [
    pkgs.fish
    pkgs.nushell
  ];
}
