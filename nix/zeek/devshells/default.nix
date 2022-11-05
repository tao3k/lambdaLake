{
  inputs,
  cell,
}: let
  inherit (inputs) nixpkgs std;
in rec {
  default = std.lib.dev.mkShell {
    imports = [
      cell.devshellProfiles.default
    ];
    env = [];
  };
  dev = std.lib.dev.mkShell {
    imports = [
      cell.devshellProfiles.default
      inputs.cells.data.devshellProfiles.zed
    ];
    env = [];
  };
  spicy = inputs.cells-lab.common.lib.mergeDevShell {
    mkShell = nixpkgs.mkShell {
      nativeBuildInputs = with nixpkgs; [llvmPackages.clang];
    };
    inherit default;
  };
}
