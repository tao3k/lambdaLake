{
  inputs,
  cell,
}: let
  inherit (cell) packages;
in {
  default = _: {};
  zed = import ./zed.nix inputs;
}
