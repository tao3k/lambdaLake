{
  inputs,
  cell,
}: let
  inherit (inputs.cells-lab.writers.lib) writeShellApplication;
  inherit (inputs) nixpkgs;
in {
  gen = writeShellApplication {
    name = "gen";
    runtimeInputs = [cell.lib.nixpkgs.bower2nix];
    text = ''
    bower2nix ${cell.lib.nixpkgs.thehive-patchSrc}/frontend/bower.json nix/thehive/packages/bower-generated.nix
    '';
  };
}
