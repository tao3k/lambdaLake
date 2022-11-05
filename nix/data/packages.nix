{
  inputs,
  cell,
}: let
  inherit (inputs) nixpkgs nixpkgs-hardenedlinux;
in {
  inherit
    (nixpkgs-hardenedlinux.packages.${nixpkgs.system})
    tuc
    ;
}
