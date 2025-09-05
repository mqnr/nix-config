{
  config,
  lib,
  inputs,
  ...
}:

lib.mkIf config.isPC {
  services.xserver.xkb.extraLayouts = {
    tangent-qwerty = {
      description = "Tangent QWERTY layout";
      languages = [
        "eng"
        "spa"
      ];
      symbolsFile = "${inputs.tangent}/xkb/symbols/tangent-qwerty";
    };
    tangent-gallium = {
      description = "Tangent Gallium layout";
      languages = [
        "eng"
        "spa"
      ];
      symbolsFile = "${inputs.tangent}/xkb/symbols/tangent-gallium";
    };
  };

  services.keyd.enable = true;
  environment.etc."keyd/default.conf".source = "${inputs.tangent}/keyd/default.conf";
}
