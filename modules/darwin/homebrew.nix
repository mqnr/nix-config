{ inputs, config, ... }:

{
  homebrew.enable = true;

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
