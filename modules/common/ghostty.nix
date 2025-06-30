{ ... }:

{
  programs.ghostty = {
    enable = true;
    enableFishIntegration = true;
    settings = {
      command = "fish";
      font-family = "Aporetic Sans Mono";
      font-size = 16;
      background-opacity = 0.9;
    };
  };
}
