{
  pkgs,
  inputs,
  ...
}:

{
  home-manager.sharedModules = [
    {
      home.packages = [ pkgs.kanata ];
      xdg.configFile."kanata/config.kbd".source = "${inputs.tangent}/mac/kanata.kbd";
    }
  ];
  # environment.systemPackages = [ pkgs.kanata ];

  # # Copy kanata config to a known location
  # environment.etc."kanata/config.kbd".source = "${inputs.tangent}/mac/kanata.kbd";

  # Set up launchd service to run kanata at startup
  # Kanata requires elevated privileges to intercept keyboard events
  # launchd.daemons.kanata = {
  #   serviceConfig = {
  #     ProgramArguments = [
  #       "${pkgs.kanata-with-cmd}/bin/kanata"
  #       "--cfg"
  #       "/etc/kanata/config.kbd"
  #     ];
  #     RunAtLoad = true;
  #     KeepAlive = true;
  #     StandardOutPath = "/var/log/kanata.log";
  #     StandardErrorPath = "/var/log/kanata.log";
  #   };
  # };
}
