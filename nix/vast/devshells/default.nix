{
  inputs,
  cell,
}: let
  inherit (inputs) nixpkgs std;
  l = nixpkgs.lib // builtins;
in
  l.mapAttrs (_: std.lib.dev.mkShell) {
    default = _: {
      name = "Vast: default devshell";
      imports = [
        cell.devshellProfiles.default
        inputs.cells.data.devshellProfiles.tuc
        inputs.cells.data.devshellProfiles.zed
      ];
    };
  }
