{ inputs, config, ... }:

{
  homebrew = {
    enable = true;

    taps = builtins.attrNames config.nix-homebrew.taps;

    onActivation.cleanup = "uninstall";
    global.autoUpdate = false;
  };

  nix-homebrew = {
    enable = true;

    user = config.username;
    taps = {
      "homebrew/homebrew-core" = inputs.homebrew-core;
      "homebrew/homebrew-cask" = inputs.homebrew-cask;
    };
    mutableTaps = false;
  };
}
