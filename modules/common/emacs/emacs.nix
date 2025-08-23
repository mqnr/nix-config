{
  config,
  pkgs,
  lib,
  ...
}:

lib.mkIf config.isPC {
  home-manager.sharedModules = [
    {
      home.packages = [
        (pkgs.emacsWithPackagesFromUsePackage {
          config = ./init.el;
          defaultInitFile = true;
          package = pkgs.emacs-pgtk;
          extraEmacsPackages = epkgs: [ epkgs.treesit-grammars.with-all-grammars ];
        })
      ];
    }
  ];
}
