{
  config,
  pkgs,
  lib,
  ...
}:
let
  mkDerived =
    conditional: description:
    lib.mkOption {
      type = lib.types.bool;
      default = conditional;
      description = description;
      readOnly = true;
    };
  mkEnum = variants: lib.mkOption { type = lib.types.enum variants; };
in
{
  options = {
    isDesktop = lib.mkEnableOption "desktop configuration";
    isLaptop = lib.mkEnableOption "laptop configuration";
    isPC = mkDerived (config.isDesktop || config.isLaptop) "Personal computer configuration";

    isLinux = mkDerived pkgs.stdenv.hostPlatform.isLinux "Linux configuration";
    isDarwin = mkDerived pkgs.stdenv.hostPlatform.isDarwin "Darwin configuration";

    isDev = lib.mkEnableOption "developer configuration";
    isWork = lib.mkEnableOption "work configuration";
    isGaming = lib.mkEnableOption "gaming configuration";

    username = lib.mkOption { type = lib.types.str; };
    hostname = lib.mkOption { type = lib.types.str; };

    gpu = mkEnum [
      "nvidia"
      "amd"
      "intel"
    ];
  };
}
