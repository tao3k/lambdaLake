{
  inputs,
  cell,
}: let
  l = nixpkgs.lib // builtins;
  inherit (inputs) nixpkgs std;
in
  l.mapAttrs (_: std.lib.dev.mkShell) {
    default = {...}: {
      name = "Hunting Lab";
      imports = [
        inputs.std.std.devshellProfiles.default
        # inputs.cells-lab.common.devshellProfiles.docs

        inputs.cells.data.devshellProfiles.zed
        inputs.cells.data.devshellProfiles.default
      ];
      nixago = [
        inputs.cells-lab._automation.nixago.treefmt
      ] ++ l.attrValues inputs.cells.tenzir.nixago;
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
