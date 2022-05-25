{
  inputs,
  cell,
} @ args: let
  inherit (inputs) threatbus2nix vast2nix;
  inherit (inputs.cells-lab.containers.library) nixpkgs;
  vast-n2c = builtins.listToAttrs (map (version: {
    name = "vast-n2c-" + version;
    value = nixpkgs.callPackage ./n2c/vast.nix {inherit version;} args;
  }) ["release" "latest"]);
in {
  inherit (vast-n2c) vast-n2c-release vast-n2c-latest;

  inherit
    (vast2nix.packages)
    vast-release
    vast-latest
    ;
  inherit
    (threatbus2nix.packages)
    threatbus
    threatbus-latest
    ;
}
