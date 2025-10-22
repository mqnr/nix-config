{ config, lib, ... }:

lib.mkIf config.isPC {
  security.polkit.enable = true;
}
