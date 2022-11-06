{
  inputs,
  cell,
}: let
  l = nixpkgs.lib // builtins;
  inherit (inputs) nixpkgs std;
in
  l.mapAttrs (_: std.lib.dev.mkShell) {
    default = {...}: {
      name = "Lambda Hunt";
      imports = [
        inputs.cells-lab._automation.devshellProfiles.default
        inputs.cells-lab._automation.devshellProfiles.docs

        inputs.cells.data.devshellProfiles.zed
        inputs.cells.data.devshellProfiles.tuc

        inputs.cells.opencti.devshellProfiles.default
      ];
      nixago =
        [
          inputs.cells-lab._automation.nixago.treefmt
        ];
    };
    zeek = {...}: {
      name = "Zeek Project";
      imports = [
        inputs.cells.zeek.devshellProfiles.default
        inputs.cells.data.devshellProfiles.zed
      ];
    };
    doc = {...}: {
      name = "Documentation";
      imports = [
        inputs.cells-lab._automation.devshellProfiles.docs
      ];
    };
    generator = {...}: {
      name = "Generator";
      nixago = l.attrValues inputs.cells.vast.nixago;
    };
  }
