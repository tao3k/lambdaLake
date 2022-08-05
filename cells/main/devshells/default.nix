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
        inputs.cells-lab.main.devshellProfiles.docs

        inputs.cells.data.devshellProfiles.zed
        inputs.cells.data.devshellProfiles.default
      ];
      nixago = [
        inputs.cells-lab.main.nixago.treefmt
      ];
    };
    zeek = {...}: {
      name = "Zeek Project";
      imports = [
        inputs.cells.zeek.devshellProfiles.default
        inputs.cells.data.devshellProfiles.zed
        inputs.cells.data.devshellProfiles.default
      ];
    };
  }
