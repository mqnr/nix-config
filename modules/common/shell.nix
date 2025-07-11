{ ... }:

{
  home.shellAliases = {
    g = "git";
    o = "bat --plain";
    p = "bat --plain --paging=auto";

    "..." = "cd ../..";
    "...." = "cd ../../..";
    "....." = "cd ../../../..";
    "......" = "cd ../../../../..";
  };
}
