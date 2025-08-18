{ config, lib, ... }:

{
  home-manager.sharedModules = [
    {
      home.shellAliases = {
        g = "git";

        "..." = "cd ../..";
        "...." = "cd ../../..";
        "....." = "cd ../../../..";
        "......" = "cd ../../../../..";
      }
      // lib.optionalAttrs config.isPC {
        o = "bat --plain";
        p = "bat --plain --paging=auto";
      };
    }
  ];
}
