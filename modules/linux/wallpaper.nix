{ pkgs, ... }:

let
  set-wallpaper = pkgs.writeScriptBin "set-wallpaper" ''
    #!${pkgs.nushell}/bin/nu
    let default_dir = $env.HOME | path join "Pictures" "Wallpapers"
    let dir = try {
      $env.HOME
      | path join ".local" "share" "wallpapers-directory"
      | open
      | str trim
    } catch {
      $default_dir
    }
    let choice = glob $"($dir)/**/*" --no-dir
      | path relative-to $dir
      | sort
      | to text
      | fuzzel --dmenu --width 60 --prompt "Wallpaper: "
    swww img ($dir | path join $choice) --transition-type right --transition-duration 1
  '';
in
{
  services.swww.enable = true;

  home.packages = [ set-wallpaper ];
}
