{ ... }:

{
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    sharedModules = [ { programs.home-manager.enable = true; } ];
  };
}
