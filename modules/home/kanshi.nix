{ ... }:

{
  services.kanshi = {
    enable = true;
    settings = let laptop = "eDP-1"; exmonitor = "HDMI-A-1"; in [
      { output.criteria = laptop;
        output.scale = 1.25;
      }
      { output.criteria = exmonitor;
        output.mode = "1920x1080@100Hz";
      }
      { profile.name = "undocked";
        profile.outputs = [
          { criteria = laptop; }
        ];
      }
      { profile.name = "docked";
        profile.outputs = [
          { criteria = laptop; status = "disable"; }
          { criteria = exmonitor; }
        ];
      }
    ];
  };
}
