{ config, lib, ... }:

# TODO: do something different with this?
lib.mkIf config.isLinux {
  imports = lib.optional (builtins.pathExists ../../private/ssh.nix) ../../private/ssh.nix;

  home-manager.sharedModules = [
    {
      programs.ssh.enable = true;
      services.ssh-agent.enable = true;
    }
  ];
}
