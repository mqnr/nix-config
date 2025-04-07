{ config, lib, pkgs, ... }:

{
  home.packages = [
    (pkgs.emacsWithPackagesFromUsePackage {
      config = ./init.el;

      defaultInitFile = true;

      package = pkgs.emacs-unstable-pgtk;

      extraEmacsPackages = epkgs: [
        epkgs.treesit-grammars.with-all-grammars
      ];
    })
  ];
}
