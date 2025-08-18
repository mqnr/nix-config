{ lib, ... }:

{
  imports = lib.listNixFiles ./. |> lib.remove ./default.nix;
}
