{
  config,
  pkgs,
  lib,
  ...
}:

# TODO: don't cope
lib.mkIf (config.isPC && config.isLinux) {
  home-manager.sharedModules = [
    {
      programs.vscode = {
        enable = true;
        package = pkgs.vscodium;
        profiles.default.extensions = [
          pkgs.vscode-extensions.mkhl.direnv
          pkgs.vscode-extensions.rust-lang.rust-analyzer
          pkgs.vscode-extensions.jnoortheen.nix-ide
          pkgs.vscode-extensions.dracula-theme.theme-dracula
        ];
      };
    }
  ];
}
