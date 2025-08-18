{ config, lib, ... }:

lib.mkIf config.isPC { boot.supportedFilesystems = [ "ntfs" ]; }
