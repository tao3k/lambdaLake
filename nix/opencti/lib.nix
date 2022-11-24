{
  inputs,
  cell,
}: let
  __inputs__ = inputs.data-science-threat-intelligence.common.lib.__inputs__;

  nixpkgs = inputs.nixpkgs.appendOverlays [
    cell.overlays.opencti
    __inputs__.poetry2nix.overlay
  ];
in {
  mkCompose = import ./dockerComposes/mkCompose.nix;
  inherit nixpkgs;
}
