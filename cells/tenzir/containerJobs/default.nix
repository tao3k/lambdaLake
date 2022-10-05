{
  inputs,
  cell,
} @ args: let
  inherit (inputs.cells.containers.lib) nixpkgs;

  vast = {
    compose = _args: import ./vast-compose.nix _args;
  };
in {
  vast-compose-release = vast.compose {};
}
