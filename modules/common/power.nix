{ config, lib, ... }:

lib.mkIf config.isLaptop { services.tlp.enable = true; }
