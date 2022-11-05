{
  inputs,
  cell,
}: let
  container = import ./container.nix;
in {
  inherit container;
  nixos = import ./nixos.nix;
  hydration = container {};
}
