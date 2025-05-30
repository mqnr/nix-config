{ ... }:

{
  imports = [ ./greetd-niri.nix ];

  services.greetd.enable = true;

  environment.etc."greetd/environments".text = ''
    niri-session
    fish
    bash
  '';
}
