{ ... }:

{
  programs.ghostty = {
    enable = true;
    enableFishIntegration = true;
    settings = {
      command = "fish";
      font-family = "Aporetic Sans Mono";
      font-size = 18;
      background-opacity = 0.9;
    };
  };
}
