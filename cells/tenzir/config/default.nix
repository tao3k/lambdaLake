{
  inputs,
  cell,
}: let
  inherit (inputs) data-merge vast2nix;
  inherit (cell) lib;
  inherit (inputs) nixpkgs;
in {
  vast = vast2nix.vast.config.default;
}
