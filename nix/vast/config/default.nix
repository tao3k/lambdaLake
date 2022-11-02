{
  inputs,
  cell,
}: let
  inherit (inputs) vast2nix;
  inherit (inputs) nixpkgs;
in {
  vast = vast2nix.vast.lib.mkConfig {};
}
