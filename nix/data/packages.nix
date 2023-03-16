{
  inputs,
  cell,
}: let
  inherit (inputs.cells.common.lib.__inputs__) nixpkgs-hardenedlinux;
in {
  inherit
    (nixpkgs-hardenedlinux.packages)
    tuc
    ;
}
