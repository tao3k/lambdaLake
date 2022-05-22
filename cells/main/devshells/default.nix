{
  inputs,
  cell,
}: let
  l = nixpkgs.lib // builtins;
  inherit (inputs) nixpkgs std;
in
  l.mapAttrs (_: std.std.lib.mkShell) {
    default = {...}: {
      name = "Hunting Cells";
      imports = [
        inputs.cells-lab.main.devshellProfiles.default
      ];
    };
  }
