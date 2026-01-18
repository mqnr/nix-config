{ ... }:

{
  home-manager.sharedModules = [
    {
      programs.ssh = {
        enable = true;

        enableDefaultConfig = false;

        matchBlocks = {
          "*" = {
            forwardAgent = false;
            addKeysToAgent = "yes";
            compression = false;

            serverAliveInterval = 60;
            serverAliveCountMax = 3;

            hashKnownHosts = false;
            userKnownHostsFile = "~/.ssh/known_hosts";

            controlMaster = "auto";
            controlPath = "~/.ssh/master-%r@%n:%p";
            controlPersist = "10m";
          };

          "github.com" = {
            hostname = "github.com";
            user = "git";
            identityFile = "~/.ssh/id_ed25519_github";
          };
        };
      };
    }
  ];
}
