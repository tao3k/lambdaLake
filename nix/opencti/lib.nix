{
  inputs,
  cell,
}: let
  nixpkgs = inputs.nixpkgs.appendOverlays [
    cell.overlays.opencti
  ];
in {
  mkCompose = import ./dockerComposes/mkCompose.nix;
  inherit nixpkgs;
}
