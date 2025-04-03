{ config, lib, pkgs, ... }:

{
  imports = lib.optional (builtins.pathExists ../private/ssh.nix) ../private/ssh.nix;

  programs.ssh = {
    enable = true;
    addKeysToAgent = "yes";
  };

  services.ssh-agent.enable = true;
}
