{ config, lib, ... }:

lib.mkIf config.isPC {
  homebrew.casks = [ "ghostty" ];
}
