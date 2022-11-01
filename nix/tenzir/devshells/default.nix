{
  inputs,
  cell,
}: let
  inherit (inputs) nixpkgs;
  devshell = inputs.std.inputs.devshell.legacyPackages.${nixpkgs.system};
  l = nixpkgs.lib // builtins;
in
  l.mapAttrs (_: inputs.std.lib.dev.mkShell) {
    default = _: {};
  }
