{ config, lib, pkgs, ... }:

{
  services.kanshi = {
    enable = true;
    settings = let laptop = "eDP-1"; in [
      { output.criteria = laptop;
        output.scale = 1.25;
      }
      { profile.name = "undocked";
        profile.outputs = [
          {
            criteria = laptop;
          }
        ];
      }
    ];
  };
}
