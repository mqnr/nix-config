{ pkgs, ... }:

{
  boot = {
    plymouth = {
      enable = true;
      theme = "sliced";
      themePackages = [ (pkgs.adi1090x-plymouth-themes.override { selected_themes = [ "sliced" ]; }) ];
    };

    consoleLogLevel = 3;
    initrd.verbose = false;
    kernelParams = [
      "quiet"
      "splash"
      "boot.shell_on_fail"
      "udev.log_priority=3"
      "rd.systemd.show_status=auto"
    ];
    loader.timeout = 0;
  };
}
