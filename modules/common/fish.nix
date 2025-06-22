{ ... }:

{
  programs.fish = {
    enable = true;

    interactiveShellInit = ''
      set fish_greeting # Disable greeting
      direnv hook fish | source
    '';

    shellAliases = {
      g = "git";
      o = "bat --plain";
      p = "bat --plain --paging=auto";

      "..."    = "cd ../..";
      "...."   = "cd ../../..";
      "....."  = "cd ../../../..";
      "......" = "cd ../../../../..";
    };
  };
}
