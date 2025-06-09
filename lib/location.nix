{ lib, ... }:

{
  options.location = {
    latitude = lib.mkOption {
      type = lib.types.nullOr lib.types.float;
      default = null;
      description = "Latitude for daylight/tint services";
    };

    longitude = lib.mkOption {
      type = lib.types.nullOr lib.types.float;
      default = null;
      description = "Longitude for daylight/tint services";
    };

    timezone = lib.mkOption {
      type = lib.types.str;
      default = "UTC";
      description = "IANA time‑zone identifier";
    };
  };
}
