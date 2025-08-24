{ lib, ... }:

{
  imports =
    lib.listNixFiles ./. |> lib.remove ./default.nix |> lib.remove ./niri/niri-config-text.nix;
}
