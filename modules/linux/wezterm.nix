{ config, lib, ... }:

lib.mkIf config.isPC {
  home-manager.sharedModules = [
    {
      programs.wezterm = {
        enable = true;
        extraConfig = ''
          local wezterm = require 'wezterm'

          return {
            default_prog = { "fish", "--login" },

            font = wezterm.font_with_fallback({
              "Aporetic Sans Mono",
              "Symbols Nerd Font Mono",
              "Noto Color Emoji",
            }),
            font_size = 16,
          }
        '';
      };
    }
  ];
}
