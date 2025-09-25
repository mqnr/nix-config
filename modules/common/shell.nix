{ config, lib, ... }:

{
  home-manager.sharedModules = [
    {
      home.shell.enableFishIntegration = true;
      home.shellAliases = {
        g = "git";

        "..." = "cd ../..";
        "...." = "cd ../../..";
        "....." = "cd ../../../..";
        "......" = "cd ../../../../..";
      };

      programs.starship.enable = true;
    }
    (lib.mkIf config.isPC {
      home.shellAliases = {
        o = "bat --plain";
        p = "bat --plain --paging=auto";
      };
    })
  ];
}
