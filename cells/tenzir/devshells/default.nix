{
  inputs,
  cell,
}: let
  inherit (inputs) nixpkgs;
  devshell = inputs.std.inputs.devshell.legacyPackages.${nixpkgs.system};
in {
  default =
    devshell.mkShell {
    };
}
