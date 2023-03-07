{
  inputs,
  cell,
}: {
  nixpkgs = inputs.nixpkgs.appendOverlays [
    cell.overlays.default
    inputs.cells.common.lib.__inputs__.npm-buildpackage.overlays.default
  ];
  mkCompose = import ./dockerComposes/mkCompose.nix;
}
