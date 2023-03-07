{
  inputs,
  cell,
}: let
  inherit (inputs) nixpkgs;
  inherit (inputs.cells-lab.common.lib) callFlake;
  l = nixpkgs.lib // builtins;

  __inputs__ = callFlake ./lib/lock {
    niXpkgs.locked = inputs.nixpkgs.sourceInfo;
    nixos.locked =
      inputs.nixos.sourceInfo
      // {
        type = "github";
        owner = "NixOS";
        repo = "nixpkgs";
      };
  };
in {
  inherit __inputs__ l;
}
