{
  config,
  pkgs,
  lib,
  ...
}:

lib.mkIf config.isPC {
  home-manager.sharedModules = [
    {
      services.swww.enable = true;

      home.packages = [
        (pkgs.writeShellScriptBin "set-wallpaper" ''
          set -eu

          default_dir="$HOME/Pictures/Wallpapers"
          config_file="$HOME/.local/share/wallpapers-directory"

          if [ -r "$config_file" ]; then
            dir=$(sed -e '1q' -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//' "$config_file")
            [ -n "$dir" ] || dir="$default_dir"
          else
            dir="$default_dir"
          fi

          if [ ! -d "$dir" ]; then
            printf 'Error: directory not found: %s\n' "$dir" >&2
            exit 1
          fi

          choice=$(
            cd "$dir" &&
              find . -type f -print |
              sed 's|^\./||' |
              LC_ALL=C sort |
              "${pkgs.fuzzel}/bin/fuzzel" --dmenu --width 60 --prompt 'Wallpaper: '
          )

          [ -n "$choice" ] || exit 0

          case "$choice" in
            /*) selected="$choice" ;;
            *)  selected="''${dir%/}/$choice" ;;
          esac

          if [ ! -f "$selected" ]; then
            printf 'Error: file not found: %s\n' "$selected" >&2
            exit 1
          fi

          exec "${pkgs.swww}/bin/swww" img "$selected" --transition-type right --transition-duration 1
        '')
      ];
    }
  ];
}
