{ pkgs, ... }:

let
  niriConfig = pkgs.writeText "greetd-niri-config" ''
    input {
      keyboard {
        xkb {
          layout "tangent-gallium"
          model ""
          rules ""
          variant ""
        }
      }
    }

    output "eDP-1" {
      scale 1.250000
      transform "normal"
    }

    binds {
      Ctrl+Alt+Delete { quit; }
      Mod+Shift+D { quit; }
    }

    hotkey-overlay {
      skip-at-startup
    }

    spawn-at-startup "sh" "-c" "${pkgs.gtkgreet}/bin/gtkgreet -l && ${pkgs.wayland-logout}/bin/wayland-logout"
  '';
in
{
  services.greetd = {
    enable = true;
    settings.default_session.command = "dbus-run-session ${pkgs.niri}/bin/niri --config ${niriConfig}";
  };

  environment.etc."greetd/environments".text = ''
    niri-session
    fish
    nu
    bash
  '';
}
