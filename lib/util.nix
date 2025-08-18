final: prev:
let
  inherit (prev) filter hasSuffix filesystem;
in
{
  listNixFiles = path: filesystem.listFilesRecursive path |> filter (hasSuffix ".nix");
}
