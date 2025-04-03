{ config, lib, pkgs, ... }:

{
  options.location = {
    latitude = lib.mkOption {
      type = lib.types.float;
      description = "Latitude coordinate";
      default = 0.0;
    };
    longitude = lib.mkOption {
      type = lib.types.float;
      description = "Longitude coordinate";
      default = 0.0;
    };
    timezone = lib.mkOption {
      type = lib.types.str;
      description = "Timezone in IANA format";
      default = "UTC";
      example = "America/New_York";
    };
  };
}
