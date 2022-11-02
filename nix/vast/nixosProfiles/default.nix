{
  inputs,
  cell,
}: let
  inherit (cell) generator;
in {
  vast = ./nomad-vast.nix;
}
