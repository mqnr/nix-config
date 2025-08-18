{ ... }:

{
  nixpkgs.config.allowUnfree = true;

  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
      "pipe-operators"
    ];
    builders-use-substitutes = true;
    trusted-users = [
      "root"
      "@build"
      "@wheel"
      "@admin"
    ];
  };
}
