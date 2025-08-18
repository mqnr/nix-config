{ config, lib, ... }:

lib.mkIf config.isPC { home-manager.sharedModules = [ { xdg.userDirs.enable = true; } ]; }
