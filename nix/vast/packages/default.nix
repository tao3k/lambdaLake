{
  inputs,
  cell,
} @ args: let
  inherit (inputs) vast2nix;
  inherit (inputs.cells-lab.containers.lib) nixpkgs;
in {
  inherit
    (vast2nix.vast.packages)
    vast-release
    vast-latest
    ;
}
