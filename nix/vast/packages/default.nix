{
  inputs,
  cell,
}: let
  inherit (inputs) vast2nix;
in {
  inherit
    (vast2nix.vast.packages)
    vast-release
    vast-latest
    ;
}
