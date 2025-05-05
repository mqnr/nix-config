{ lib, ... }:

let
  privatePath = ../../private/location.nix;
in
if builtins.pathExists privatePath
then import privatePath {}
else {}
