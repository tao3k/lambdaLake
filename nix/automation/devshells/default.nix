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
        inputs.std-ext.automation.devshellProfiles.default
        inputs.std-ext.automation.devshellProfiles.docs

        inputs.cells.data.devshellProfiles.zed
        inputs.cells.data.devshellProfiles.tuc

        inputs.cells.opencti.devshellProfiles.default
      ];
      nixago = [
        inputs.std-ext.automation.nixago.treefmt
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
        inputs.std-ext.automation.devshellProfiles.docs
      ];
    };
    generator = {...}: {
      name = "Generator";
      nixago = l.attrValues inputs.cells.vast.nixago;
    };
  }
