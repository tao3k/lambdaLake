{
  inputs,
  cell,
}: let
  inherit (inputs.cells-lab.writers.lib) writeShellApplication;
  inherit (inputs) nixpkgs;
in {
  gen = writeShellApplication {
    name = "gen";
    runtimeInputs = [cell.packages.bower2nix];
    text = ''
    bower2nix ${inputs.thehive}/frontend/bower.json nix/thehive/packages/bower-generated.nix
    '';
  };
}
