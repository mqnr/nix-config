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

  services.keyd = {
    enable = true;
    keyboards.default = {
      ids = [ "*" ];
      settings = {
        main.capslock = "overload(capslock, esc)";
        "capslock:C" = {
          "1" = "f1";
          "2" = "f2";
          "3" = "f3";
          "4" = "f4";
          "5" = "f5";
          "6" = "f6";
          "7" = "f7";
          "8" = "f8";
          "9" = "f9";
          "0" = "f10";
          "-" = "f11";
          "=" = "f12";

          e = "S-tab";
          r = "tab";

          a = "oneshot(meta)";
          s = "oneshot(alt)";
          d = "oneshot(shift)";
          f = "oneshot(control)";

          t = "volumeup";
          g = "volumedown";
          b = "mute";

          u = "home";
          j = "left";
          k = "down";
          i = "up";
          l = "right";
          p = "end";

          z = "C-b";
          x = "C-z";
          c = "C-r";
          v = "C-t";

          "/" = "capslock";

          semicolon = "backspace";
          apostrophe = "delete";
        };
      };
    };
  };
}
