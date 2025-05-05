{ ... }:

{  
  programs.git = {
    enable = true;
    userName = "mzamorano";
    userEmail = "martin@mzamorano.com";
    aliases = {
      "st" = "status";
      "co" = "checkout";
      "br" = "branch";
      "ci" = "commit";
      "unstage" = "reset HEAD --";
      "last" = "log -1 HEAD";
      "lg" = "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit";
    };
    ignores = [
      ".idea"
      ".direnv"
      ".envrc"
      "*~"
      ".fuse_hidden*"
      ".directory"
      ".Trash-*"
      ".nfs*"
      "nohup.out"
    ];
    extraConfig = {
      init.defaultBranch = "main";
      color.ui = "auto";
      pull.rebase = false;
    };
  };
}
